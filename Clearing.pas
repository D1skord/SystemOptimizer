unit Clearing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellApi, StdCtrls, Registry, jpeg, ExtCtrls, Buttons, ComCtrls, Masks,
  Vcl.Menus, GifImg, IOUtils, MATH, Vcl.CheckLst, Vcl.Imaging.pngimage;

procedure ClearFolder(way:string);
function GetUserName():string;
procedure CleanDump();
procedure EmptyRecycleBin;
procedure CleanBrowsCache();
function FreeDisk(): real;
procedure CleanDownloads();
procedure CleanTempFiles();

implementation
  uses Form;

procedure ClearFolder(way:string);
  var
    iIndex: Integer;
    SearchRec: TSearchRec;
    sFileName: string;
  begin
    way := way + '\*.*';
    iIndex := FindFirst(way, faAnyFile, SearchRec);
      while iIndex = 0 do
        begin
          sFileName := ExtractFileDir(way)+'\'+SearchRec.name;
            if SearchRec.Attr = faDirectory then
                begin
                  if (SearchRec.name <> '' ) and (SearchRec.name <> '.') and
                   (SearchRec.name <> '..')
                   then TDirectory.Delete(sFileName, True);
                end
          else
            begin
              if SearchRec.Attr <> faArchive then FileSetAttr(sFileName, faArchive);
              DeleteFile(sFileName);
            end;
          iIndex := FindNext(SearchRec);
        end;
    FindClose(SearchRec);
  end;

function GetUserName():string;
  var
    Name: string;
    UserName: array[0..255] of Char;
    UserNameSize: DWORD;
  begin
    UserNameSize := 255;
      if Windows.GetUserName(@UserName, UserNameSize) then result := string(UserName)
        else result := '%UserName%';
  end;

procedure CleanDump();
  var
    FileName :TSearchRec;
    r :integer;
  begin

    ChDir('C:\Windows');
    r := FindFirst('*.dmp',faAnyFile,FileName);
    if r = 0 then DeleteFile(FileName.Name);
      while (FindNext(FileName) = 0) do
        DeleteFile(FileName.Name);
      FindClose(FileName);

    if DirectoryExists('C:\Windows\LiveKernelReports') = True then
      ClearFolder('C:\Windows\LiveKernelReports');

    if DirectoryExists('C:\Windows\Minidump') = True then
      ClearFolder('C:\Windows\Minidump');
  end;

procedure EmptyRecycleBin;    // http://www.kansoftware.ru/?tid=1510
 const
   SHERB_NOCONFIRMATION = $00000001;
   SHERB_NOPROGRESSUI = $00000002;
   SHERB_NOSOUND = $00000004;
 type
   TSHEmptyRecycleBin = function(Wnd: HWND;
                                 pszRootPath: PChar;
                                 dwFlags: DWORD): HRESULT;  stdcall;
 var
   SHEmptyRecycleBin: TSHEmptyRecycleBin;
   LibHandle: THandle;
 begin  { EmptyRecycleBin }
   LibHandle := LoadLibrary(PChar('Shell32.dll'));
    if LibHandle <> 0 then @SHEmptyRecycleBin :=
      GetProcAddress(LibHandle, 'SHEmptyRecycleBinA')
   else
    begin
      MessageDlg('Failed to load Shell32.dll.', mtError, [mbOK], 0);
      Exit;
    end;

   if @SHEmptyRecycleBin <> nil then
     SHEmptyRecycleBin(Application.Handle,
                       nil,
                       SHERB_NOCONFIRMATION or SHERB_NOPROGRESSUI or SHERB_NOSOUND);
   FreeLibrary(LibHandle); @SHEmptyRecycleBin := nil;
 end;

procedure CleanBrowsCache();
  var
    s, way, UserName: string;
    tsr : TSearchRec;
 begin

  UserName := GetUserName;
  way := 'C:\Users\' + UserName + '\AppData\Local\';

  //Yandex Browser
  s := way + 'Yandex\YandexBrowser\User Data\Default\Cache';
  ClearFolder(s);

  //Google Chrome
  s := way + 'Google\Chrome\User Data\Default\Cache';
  ClearFolder(s);

  //Opera Browser
  s := way + 'Opera Software\Opera Stable\Cache';
  ClearFolder(s);

 //Mozilla Firefox
  if FindFirst(way + 'Mozilla\Firefox\Profiles\*.*', faAnyFile, tsr) = 0 then
    begin
      repeat
        s := way + 'Mozilla\Firefox\Profiles\' + tsr.name + '\cache2';
        ClearFolder(s);
      until FindNext(tsr) <> 0;
        FindClose(tsr);
      end;

  //Microsoft Edge
  s := way + 'Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\LocalCache';
    ClearFolder(s);
  s := way + 'Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\LocalState';
    ClearFolder(s);
 end;

 procedure CleanTempFiles();
 var
    s, way, UserName: string;
 begin
  UserName := GetUserName;
  way := 'C:\Users\' + UserName + '\AppData\Local\';

  s := 'C:\Windows\Temp';
    ClearFolder(s);
   s := way + 'Temp';
    ClearFolder(s);

 end;

function FreeDisk(): real;
  var
    FreeBytesAvailableToCaller: TLargeInteger;
    FreeSize: TLargeInteger;
    TotalSize: TLargeInteger;
  begin
    GetDiskFreeSpaceEx('c:',
    FreeBytesAvailableToCaller,
    Totalsize,
    @FreeSize);
    result := FreeSize/(1024*1024);
  end;

procedure CleanDownloads();
  var
    s,UserName: string;
  begin
    UserName := GetUserName;
    s := 'C:\Users\' + UserName + '\downloads';
    ClearFolder(s);
  end;

end.
