#define APP_WEBSITE    "https://modxvm.com/"
#define APP_DIR_UNINST "xvm_uninst"

#include "openwg.utils.iss"
#include "..\temp\defines\xvm_defines.iss"
#include "..\temp\l10n_result\lang.iss"
#include "xvm_defines_template.iss"
#include "form_select_component.iss"
#include "configuration_settings.iss"

[Setup]
AppCopyright    = "2022 (c) XVM Team"
AppId           = {{2865cd27-6b8b-4413-8272-cd968f316050}
AppName         = "XVM"
AppPublisher    = "XVM Team"
AppPublisherURL = {#APP_WEBSITE}
AppSupportURL   = {#APP_WEBSITE}
AppUpdatesURL   = {#APP_WEBSITE}
AppVersion      = {#VersionXVM}

WizardImageFile      = images\big_image.bmp
WizardSmallImageFile = images\small_image.bmp
SetupIconFile        = images\setup_ico.ico

; PrivilegesRequired=lowest
; Compression=lzma2/ultra64
; Compression=none
; InternalCompressLevel=ultra64
; InternalCompressLevel=none

DirExistsWarning=false
CreateAppDir=true
AppendDefaultDirName=false
ShowLanguageDialog=true
DisableProgramGroupPage=true
Uninstallable=true
DisableDirPage=false

OutputDir=..\output
OutputBaseFilename=setup_xvm_v2

UninstallFilesDir={app}\{#APP_DIR_UNINST}

DefaultDirName=C:\

SetupLogging=yes

WizardStyle=modern

[Tasks]
Name: "xvmbackup"; Description: "{cm:backupXVM}"; Flags: unchecked;

[Run]
Filename: {#APP_WEBSITE}; Description: "{cm:websiteXVM}"; Flags: postinstall nowait shellexec;

[Components]
;Name: "XVM"; Description: "{cm:component_XVM}"; Types: full compact custom; Flags: fixed;

[Files]
;backup
Source: "{app}\res_mods\configs\*"; DestDir: "{app}\xvm_backup\configs"; Tasks: xvmbackup; Flags: external skipifsourcedoesntexist createallsubdirs recursesubdirs uninsneveruninstall;
;Source: "{app}\res_mods\mods\shared_resources\xvm\res\*"; DestDir: "{app}\xvm_backup\mods\shared_resources\xvm\res"; Tasks: xvmbackup; Flags: external skipifsourcedoesntexist createallsubdirs recursesubdirs uninsneveruninstall;

;xvm
;Source: "..\..\..\~output\mods\*"; DestDir: "{app}\mods"; Flags: createallsubdirs recursesubdirs; Components: XVM
;Source: "..\..\..\~output\res_mods\*"; DestDir: "{app}\res_mods"; Flags: createallsubdirs recursesubdirs; Components: XVM
;Source: "..\..\..\~output\readme*.*"; DestDir: "{app}"; Components: XVM

;installer libs
Source: "dll\bass.dll"; Flags: dontcopy;
Source: "dll\unmerg_f.dll"; Flags: dontcopy;


[InstallDelete]
;mods\ver\com.modxvm.xfw\*.wotmod
;Type: filesandordirs; Name: "{app}\mods\{#VersionWOT}\com.modxvm.xfw\com.modxvm.*.wotmod"
Type: dirifempty; Name: "{app}\mods\{#VersionWOT}\com.modxvm.xfw\"

;mods\ver\temp
;Type: filesandordirs; Name: "{app}\mods\temp\com.modxvm.*"
Type: dirifempty; Name: "{app}\mods\temp\"

;res_mods\mods\shared_resources
;Type: filesandordirs; Name: "{app}\res_mods\mods\shared_resources\xvm"
Type: dirifempty; Name: "{app}\res_mods\mods\shared_resources\"

;res_mods\mods\packages
;Type: filesandordirs; Name: "{app}\res_mods\mods\xfw_packages\xvm_*"
Type: dirifempty; Name: "{app}\res_mods\mods\xfw_packages\"
Type: dirifempty; Name: "{app}\res_mods\mods\"

;res_mods\ver\audioww
;Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\audioww\xvm.bnk"
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\audioww\"

;configs\xvm\py_macro
Type: filesandordirs; Name: "{app}\res_mods\configs\xvm\py_macro\xvm\*.pyc"
Type: filesandordirs; Name: "{app}\res_mods\configs\xvm\py_macro\*.pyc"
Type: dirifempty; Name: "{app}\res_mods\configs\xvm\py_macro\"
Type: dirifempty; Name: "{app}\res_mods\configs\xvm\"
Type: dirifempty; Name: "{app}\res_mods\configs\"

Type: filesandordirs; Name: "{app}\{#APP_DIR_UNINST}"
;Type: files; Name: "{app}\readme-*.txt"

[UninstallDelete]
;mods\ver\com.modxvm.xfw\*.wotmod
Type: filesandordirs; Name: "{app}\mods\{#VersionWOT}\com.modxvm.xfw\com.modxvm.*.wotmod"
Type: dirifempty; Name: "{app}\mods\{#VersionWOT}\com.modxvm.xfw\"

;mods\ver\temp
Type: filesandordirs; Name: "{app}\mods\temp\com.modxvm.*"
Type: dirifempty; Name: "{app}\mods\temp\"

;res_mods\mods\shared_resources
Type: filesandordirs; Name: "{app}\res_mods\mods\shared_resources\xvm"
Type: dirifempty; Name: "{app}\res_mods\mods\shared_resources\"

;res_mods\mods\packages
Type: filesandordirs; Name: "{app}\res_mods\mods\xfw_packages\xvm_*"
Type: dirifempty; Name: "{app}\res_mods\mods\xfw_packages\"
Type: dirifempty; Name: "{app}\res_mods\mods\"

;res_mods\ver\audioww
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\audioww\xvm.bnk"
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\audioww\"

;configs\xvm\py_macro
Type: filesandordirs; Name: "{app}\res_mods\configs\xvm\py_macro\xvm\*.pyc"
Type: filesandordirs; Name: "{app}\res_mods\configs\xvm\py_macro\*.pyc"
Type: filesandordirs; Name: "{app}\res_mods\configs\xvm\xvm.xc"
Type: dirifempty; Name: "{app}\res_mods\configs\xvm\py_macro\"
Type: dirifempty; Name: "{app}\res_mods\configs\xvm\"
Type: dirifempty; Name: "{app}\res_mods\configs\"

Type: filesandordirs; Name: "{app}\{#APP_DIR_UNINST}"
Type: files; Name: "{app}\readme-*.txt"

[CustomMessages]
en.client_started=The selected client is running.%n%nDo you want to terminate the selected client?
ru.client_started=Выбранный клиент запущен.%n%nЖелаете ли вы закрыть выбранный клиент?

[Code]

//
// Globals
//

var
  WotList: TNewComboBox;


//
// Checks
//

function CHECK_IsLesta(): Boolean;
var
  Flavour: Integer;
begin
  Flavour := WotList_Selected_Record(WotList).LauncherFlavour
  Result := Flavour = 4;
end;



//
// Placeholders
//

function PH_Folder_Mods(s: String): String;
begin
  Result := WotList_Selected_Record(WotList).PathMods;
end;

function PH_Folder_Resmods(s: String): String;
begin
  Result := WotList_Selected_Record(WotList).PathResmods;
end;



//
// Initialize
//


function InitializeSetup(): Boolean;
begin
//   ExtractTemporaryFile('splashscreen.png');
//   SPLASHSCREEN_ShowSplashScreenW(ExpandConstant('{tmp}\splashscreen.png'), 3);
  FNameSettings := 'default.xc';
  SelectPreset:= 'default';
  LinkSupport := 'https://koreanrandom.com/forum/forum/81-';
  Result := True;
end;


function InitializeUninstall: Boolean;
begin
  SPLASHSCREEN_ShowSplashScreenW(ExpandConstant('{app}\{#APP_DIR_UNINST}\splashscreen_uninst.png'), 3);
  Result := True;
end;


procedure InitializeWizard();
begin
  WotList := WotList_Create(WizardForm.DirEdit.Parent,
      WizardForm.DirEdit.Left,
      WizardForm.DirEdit.Top,
      WizardForm.DirBrowseButton.Left + WizardForm.DirBrowseButton.Width,
      WizardForm.DirEdit.Height
  );
  WotList.ItemIndex := WOT_ClientFind(WizardForm.DirEdit.Text);

  if (WotList.ItemIndex = -1) and (WotList.Items.Count > 1) then
    WotList.ItemIndex := 0;
  WotList.OnChange(WotList);

  WizardForm.DirEdit.Visible := False;
  WizardForm.DirEdit.Text := '';
  WizardForm.DirBrowseButton.Visible := False;
end;



//
// CurPageChanged
//

procedure CurPageChanged_wpSelectDir();
begin
end;


procedure CurPageChanged_wpSelectComponents();
var
  Index: Integer;
  IsLesta: Boolean;
  ItemCaption: String;
begin
  IsLesta := CHECK_IsLesta();

  for Index := 0 to WizardForm.ComponentsList.Items.Count - 1 do
  begin
    ItemCaption := WizardForm.ComponentsList.ItemCaption[Index];
    if ((pos('Lesta', ItemCaption) <> 0) and (not IsLesta)) or ((pos('WG', ItemCaption) <> 0) and IsLesta) then
    begin
        WizardForm.ComponentsList.Checked[Index] := false; 
        WizardForm.ComponentsList.ItemEnabled[Index] := false;   
    end;
  end;
end;


procedure CurPageChanged(CurPage: Integer);
begin
  case CurPage of
    wpSelectDir:        CurPageChanged_wpSelectDir();
    wpSelectComponents:
		        begin
		       	  AddButtonSelectComponent();
			  CurPageChanged_wpSelectComponents();
		        end;
    wpFinished:         ApplySettings();
  end
end;



//
// CurUninstallStepChanged
//

procedure CurUninstallStepChanged_usUninstall();
begin
  OPENWG_DllUnload();
  OPENWG_DllDelete();
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  case CurUninstallStep of
    usUninstall: CurUninstallStepChanged_usUninstall();
  end
end;



//
// DeinitializeUninstall
//

procedure DeinitializeUninstall();
begin
end;



//
// NextButtonClick
//

function NextButtonClick_wpSelectDir(): Boolean;
begin
  Result := True;

  // check for version
//    if not WotList_Selected_VersionMatch(WotList, '{#WOT_VERSION_PATTERN}') then
//    begin
//      MsgBox(ExpandConstant('{cm:version_not_match}'), mbError, MB_OK);
//      Result := False;
//      Exit;
//    end;

  // check for running client
  if WotList_Selected_IsStarted(WotList) then
  begin
    if (MsgBox(ExpandConstant('{cm:client_started}'), mbConfirmation, MB_YESNO) = IDYES) then 
      WotList_Selected_Terminate(WotList)
    else
      Result := False;
  end;
end;


function NextButtonClick(CurPage: Integer): Boolean;
begin
  Result := True;

  case CurPage of
    wpSelectDir: Result := NextButtonClick_wpSelectDir();
  end;
end;

