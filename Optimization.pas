unit Optimization;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellApi, StdCtrls, Registry, jpeg, ExtCtrls, Buttons, ComCtrls, Masks,
  Vcl.Menus, GifImg, IOUtils, MATH, Vcl.CheckLst, Vcl.Imaging.pngimage;

procedure RegEdit(way: string; key: string; val: string);
procedure StartBoost;
procedure ShutDownBoost;
procedure move(codekey : integer; n : integer);
procedure VE_switch();

type
  Service = class(TObject)
    const w = 'SYSTEM\CurrentControlSet\Services\';
  private
    procedure switch(way : string; val : integer);
  public
    procedure OfflineFiles(val : integer);overload;//���������� �����
    procedure OfflineFiles(cb : TCheckBox);overload;

    procedure BiomWinSvc(val : integer);overload;//�������������� ������ Windows
    procedure BiomWinSvc(cb : TCheckBox);overload;

    procedure Firewall(val : integer);overload;//����������
    procedure Firewall(cb : TCheckBox);overload;

    procedure IPHelperSvc(val : integer);overload;//��������������� ������ IP
    procedure IPHelperSvc(cb : TCheckBox);overload;

    procedure SecLog(val : integer);overload;//��������� ���� � �������
    procedure SecLog(cb : TCheckBox);overload;

    procedure PrintManager(val : integer);overload;//��������� ������
    procedure PrintManager(cb : TCheckBox);overload;

    procedure SessionManager(val : integer);overload;//��������� ������� ���������� ���� �������� �����
    procedure SessionManager(cb : TCheckBox);overload;

    procedure DowMapManager(val : integer);overload;//��������� ��������� ����
    procedure DowMapManager(cb : TCheckBox);overload;

    procedure SecureStorage(val : integer);overload;//���������� ���������
    procedure SecureStorage(cb : TCheckBox);overload;

    procedure Server(val : integer);overload;//������
    procedure Server(cb : TCheckBox);overload;

    procedure XboxLiveNet(val : integer);overload;//������� ������ Xbox Live
    procedure XboxLiveNet(cb : TCheckBox);overload;

    procedure TabletInputSvc(val : integer);overload;//������ ����� ����������� ��
    procedure TabletInputSvc(cb : TCheckBox);overload;

    procedure DiagTrackSvc(val : integer);overload;//������ ���������������� ������������
    procedure DiagTrackSvc(cb : TCheckBox);overload;

    //procedure WinDefSvc(val : integer);overload;//������ ��������� Windows
   // procedure WinDefSvc(cb : TCheckBox);overload;

    //procedure DiagPolicySvc(val : integer);overload;//������ �������� �����������
   // procedure DiagPolicySvc(cb : TCheckBox);overload;

    procedure ProgCompatbltyAssistSvc(val : integer);overload;//������ ��������� �� ������������� ��������
    procedure ProgCompatbltyAssistSvc(cb : TCheckBox);overload;

    procedure WinErrLogSvc(val : integer);overload;//������ ����������� ������ �������
    procedure WinErrLogSvc(cb : TCheckBox);overload;

    procedure BitLockDrvEncryptSvc(val : integer);overload;//������ ���������� ������ BitLocker
    procedure BitLockDrvEncryptSvc(cb : TCheckBox);overload;

    procedure Themes(val : integer);overload;//����
    procedure Themes(cb : TCheckBox);overload;

    procedure RemoteReg(val : integer);overload;//��������� ������
    procedure RemoteReg(cb : TCheckBox);overload;

    procedure SecurityCenter(val : integer);overload;//����� ����������� ������������
    procedure SecurityCenter(cb : TCheckBox);overload;

    procedure Superfetch(val : integer);overload;//Superfetch
    procedure Superfetch(cb : TCheckBox);overload;
end;

implementation
  uses Form;

procedure Service.switch(way: string; val : integer);
  var
    Reg: TRegistry;
  begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
    if val=0
      then
        begin
          Reg.OpenKey(way, false);
          Reg.WriteInteger('Start', 3);
        end
      else
        begin
          Reg.OpenKey(way, false);
          Reg.WriteInteger('Start', 2);
        end;
        Reg.CloseKey;
        Reg.Free;
  end;

procedure Service.BiomWinSvc(cb: TCheckBox);
  begin
    cb.Caption := '�������������� ������ Windows';
    cb.Hint := '����, ��������� � �������� �������������� ������.';
  end;
procedure Service.BiomWinSvc(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := 'SYSTEM\CurrentControlSet\Services\WbioSrvc';
    Svc.switch(way,val);
  end;

procedure Service.Firewall(cb : TCheckBox);
  begin
    cb.Caption := '����������';
    cb.Hint := '���� �� ����������� ��������� ���������, � �� ���������� Windows, �� ������ ������ �� ���������';
  end;
procedure Service.Firewall(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'MpsSvc';
    Svc.switch(way,val);
  end;

procedure Service.IPHelperSvc(cb : TCheckBox);
  begin
    cb.Caption := '��������������� ������ IP';
    cb.Hint := '���� �� �� ����������� IPv6-�����������.';
  end;
procedure Service.IPHelperSvc(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'iphlpsvc';
    Svc.switch(way,val);
  end;

procedure Service.SecLog(cb : TCheckBox);
  begin
    cb.Caption := '��������� ���� � �������';
    cb.Hint := '��������� ��������� �������� �� ����� ������� ������������.';
  end;
procedure Service.SecLog(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'seclogon';
    Svc.switch(way,val);
  end;

procedure Service.PrintManager(cb : TCheckBox);
  begin
    cb.Caption := '��������� ������';
    cb.Hint := '���� � ��� ��� ��������.';

  end;
procedure Service.PrintManager(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'Spooler';
    Svc.switch(way,val);
  end;

procedure Service.DowMapManager(cb : TCheckBox);
  begin
    cb.Caption := '��������� ��������� ����';
    cb.Hint := '���� �� �� ����������� ���������� �������';

  end;
procedure Service.DowMapManager(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'MapsBroker';
    Svc.switch(way,val);
  end;

procedure Service.XboxLiveNet(cb : TCheckBox);
  begin
    cb.Caption := '������� ������ Xbox Live';
    cb.Hint := '������������ ������ � �������� Xbox Live.';
  end;
procedure Service.XboxLiveNet(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'XboxNetApiSvc';
    Svc.switch(way,val);
  end;

procedure Service.DiagTrackSvc(cb : TCheckBox);
  begin
    cb.Caption := '������ ���������������� ������������';
    cb.Hint := '��������� �������� �������� � �������������� ���������, ��������� � ������������ Windows.';
  end;
procedure Service.DiagTrackSvc(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'DiagTrack';
    Svc.switch(way,val);
  end;

procedure Service.ProgCompatbltyAssistSvc(cb : TCheckBox);
  begin
    cb.Caption := '������ ��������� �� ������������� ��������';
    cb.Hint := '������������ ��������� ��������� �� ������������� ��������.';
  end;
procedure Service.ProgCompatbltyAssistSvc(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'PcaSvc';
    Svc.switch(way,val);
  end;

procedure Service.WinErrLogSvc(cb : TCheckBox);
  begin
    cb.Caption := '������ ����������� ������ Windows';
    cb.Hint := '��������� �������� ������� �� ������� � ������ ����������� ������ ��� ��������� ���������.';
  end;
procedure Service.WinErrLogSvc(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'WerSvc';
    Svc.switch(way,val);
  end;

procedure Service.BitLockDrvEncryptSvc(cb : TCheckBox);
  begin
    cb.Caption := '������ ���������� ������ BitLocker';
    cb.Hint := '��������� ��������� �����, ���� �� �� �� ����������� ���������� ���������.';
  end;
procedure Service.BitLockDrvEncryptSvc(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'BDESVC';
    Svc.switch(way,val);
  end;

procedure Service.RemoteReg(cb : TCheckBox);
  begin
    cb.Caption := '�������� ������';
    cb.Hint := '��� ����������� ������ ������������� �������� �������� ��� ������.';
  end;
procedure Service.RemoteReg(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'RemoteRegistry';
    Svc.switch(way,val);
  end;

procedure Service.SecurityCenter(cb : TCheckBox);
  begin
    cb.Caption := '����� ����������� ������������';
    cb.Hint := '������ �� ����������� ����������������� ������� ������������ � ������������� ��.';
  end;
procedure Service.SecurityCenter(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'wscsvc';
    Svc.switch(way,val);
  end;

procedure Service.Superfetch(cb : TCheckBox);
  begin
    cb.Caption := 'Superfetch';
    cb.Hint := '������������� ���������, ���� ����������� SSD ����.';
  end;
procedure Service.Superfetch(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'SysMain';
    Svc.switch(way,val);
  end;

procedure Service.OfflineFiles(cb : TCheckBox);
  begin
    cb.Caption := '���������� �����';
    cb.Hint := '������� ��������, ����������� �������� ������ � ������ �������������, '#13'������� ������������ � ���� ������������, ��� ���������� �������, ������ �����';
  end;
procedure Service.OfflineFiles(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'CscService';
    Svc.switch(way,val);
  end;

procedure Service.Server(cb : TCheckBox);
  begin
    cb.Caption := '������';
    cb.Hint := '������������� ���������, ���� ��������� �� ������������ ��� ������';
  end;
procedure Service.Server(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'LanmanServer';
    Svc.switch(way,val);
  end;

procedure Service.SessionManager(cb : TCheckBox);
  begin
    cb.Caption := '��������� ������� ���������� ���� �������� �����';
    cb.Hint := '���� �� ����������� ���� ���������� Aero.';
  end;
procedure Service.SessionManager(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'UxSms';
    Svc.switch(way,val);
  end;

procedure Service.SecureStorage(cb : TCheckBox);
  begin
    cb.Caption := '���������� ���������';
    cb.Hint := '��������� ������ ����������� (������� ��������������� ���������� ���� � ���������.';
  end;
procedure Service.SecureStorage(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'ProtectedStorage';
    Svc.switch(way,val);
  end;

procedure Service.TabletInputSvc(cb : TCheckBox);
  begin
    cb.Caption := '������ ����� ����������� ��';
    cb.Hint := '������������ ���������������� ���� � ����������� ����� �� ���������� ��.';
  end;
procedure Service.TabletInputSvc(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'TabletInputService';
    Svc.switch(way,val);
  end;

procedure Service.Themes(cb : TCheckBox);
  begin
    cb.Caption := '����';
    cb.Hint := '���� �� �� ����������� ����� ���������� Windows 7, �� ���������� ���������.';
  end;
procedure Service.Themes(val : integer);
  var
    Svc : Service;
    way : string;
  begin
    way := w + 'Themes';
    Svc.switch(way,val);
  end;


procedure RegEdit(way: string; key: string; val: string);
  var
    Reg : TRegistry;
    s : string;
  begin
    Reg := TRegistry.Create;
    s := way;
    s := Copy(s, 1, Pos('\', s)-1);

    if (s = 'HKEY_CURRENT_USER') then Reg.RootKey := HKEY_CURRENT_USER
      else
        if (s = 'HKEY_LOCAL_MACHINE') then Reg.RootKey := HKEY_LOCAL_MACHINE
          else Exit;

    way := copy(way,length(s)+2,length(way)-1);

    if Reg.OpenKey(way, True) then Reg.WriteString(key, val);

    Reg.CloseKey;
    Reg.Free;
  end;


procedure ShutDownBoost;
  begin
    RegEdit('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control','WaitToKillServiceTimeout','3000');
  end;

procedure StartBoost;
  begin
    RegEdit('HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Control','MenuShowDelay','50');
  end;

procedure move(codekey : integer; n : integer);
  var
    i : integer;
  begin
    for i:=1 to n do
      begin
        keybd_event(codekey, 0, 0, 0);
        keybd_event(codekey, 0, KEYEVENTF_KEYUP, 0);
      end;
    keybd_event(VK_RETURN, 0, 0, 0);
    keybd_event(VK_RETURN, 0, KEYEVENTF_KEYUP, 0);
  end;

procedure VE_switch();
  var
    Reg: TRegistry;
    s : integer;
    one : dword;
  begin
    if  not Form1.VE_CB.Checked then Exit;

    Reg := TRegIniFile.Create;

  Reg.RootKey := HKEY_CURRENT_USER;
   Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects', False);
    if not reg.ValueExists('VisualFXSetting') then
      begin
        Reg.WriteInteger('VisualFXSetting',0);
      end;
    s := reg.ReadInteger('VisualFXSetting');
    reg.closekey;
    reg.free;

    if (Form1.offVE_CB.Checked) and (s = 2) then Exit;
    if (Form1.onVE_CB.Checked) and (s = 1) then Exit;

    ShellExecute(Form1.Handle, 'open','c:\Windows\system32\SystemPropertiesPerformance.exe', nil, nil, SW_SHOWNORMAL);
        Sleep(1000);
    if Form1.offVE_CB.Checked
      then
        case s of
          0: move(40,2);
          1: move(40,1);
          3: move(38,1);
        end
      else
        case s of
          0: move(40,1);
          2: move(38,1);
          3: move(38,2);
        end;
  end;

 end.
