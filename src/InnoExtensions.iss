// SPDX-License-Identifier: MIT
// Copyright (c) 2017-2022 OpenWG.Utils Contributors

// directory with OpenWG.Utils installation files, relative to the main .iss file
#ifndef OPENWGUTILS_DIR_SRC
#define OPENWGUTILS_DIR_SRC "dll"
#endif

// directory with OpenWG.Utils uninstallation files, relative to the application installation folder
#ifndef OPENWGUTILS_DIR_UNINST
#define OPENWGUTILS_DIR_UNINST "."
#endif


[Files]
Source: "{#OPENWGUTILS_DIR_SRC}\openwg.utils.x86_32.dll"; DestName: openwg.utils.dll; Flags: ignoreversion dontcopy noencryption;
Source: "{#OPENWGUTILS_DIR_SRC}\openwg.utils.x86_32.dll"; DestDir: {app}\{#OPENWGUTILS_DIR_UNINST}; DestName: openwg.utils.dll; Flags: ignoreversion noencryption;

[Code]

// BWXML/UnpackW
function BWXML_UnpackW_I(PathPacked: String; PathUnpacked: String): Integer;
external 'BWXML_UnpackW@files:openwg.utils.dll cdecl setuponly';

function BWXML_UnpackW_U(PathPacked: String; PathUnpacked: String): Integer;
external 'BWXML_UnpackW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function BWXML_UnpackW(PathPacked: String; PathUnpacked: String): Integer;
begin
    if IsUninstaller() then
        Result := BWXML_UnpackW_U(PathPacked, PathUnpacked)
    else
        Result := BWXML_UnpackW_I(PathPacked, PathUnpacked)
end;


// JSON/ContainsKeyW
function JSON_ContainsKeyW_I(JSON: String; Path: String): Boolean;
external 'JSON_ContainsKeyW@files:openwg.utils.dll cdecl setuponly';

function JSON_ContainsKeyW_U(JSON: String; Path: String): Boolean;
external 'JSON_ContainsKeyW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function JSON_ContainsKeyW(JSON: String; Path: String): Boolean;
begin
    if IsUninstaller() then
        Result := JSON_ContainsKeyW_U(JSON, Path)
    else
        Result := JSON_ContainsKeyW_I(JSON, Path)
end;


// JSON/GetValueW
procedure JSON_GetValueW_I(JSON: String; Path: String; Buffer: String; BufferSize: Integer);
external 'JSON_GetValueW@files:openwg.utils.dll cdecl setuponly';

procedure JSON_GetValueW_U(JSON: String; Path: String; Buffer: String; BufferSize: Integer);
external 'JSON_GetValueW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

procedure JSON_GetValueW(JSON: String; Path: String; Buffer: String; BufferSize: Integer);
begin
    if IsUninstaller() then
        JSON_GetValueW_U(JSON, Path, Buffer, BufferSize)
    else
        JSON_GetValueW_I(JSON, Path, Buffer, BufferSize)
end;


// JSON/SetValueBoolW
procedure JSON_SetValueBoolW_I(FileFullName: String; ValuePath: String; Value: Boolean);
external 'JSON_SetValueBoolW@files:openwg.utils.dll cdecl setuponly';

procedure JSON_SetValueBoolW_U(FileFullName: String; ValuePath: String; Value: Boolean);
external 'JSON_SetValueBoolW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

procedure JSON_SetValueBoolW(FileFullName: String; ValuePath: String; Value: Boolean);
begin
    if IsUninstaller() then
        JSON_SetValueBoolW_U(FileFullName, ValuePath, Value)
    else
        JSON_SetValueBoolW_I(FileFullName, ValuePath, Value)
end;


// JSON/SetValueObjW
procedure JSON_SetValueObjW_I(FileFullName: String; Value: String; isAdd: Boolean);
external 'JSON_SetValueObjW@files:openwg.utils.dll cdecl setuponly';

procedure JSON_SetValueObjW_U(FileFullName: String; Value: String; isAdd: Boolean);
external 'JSON_SetValueObjW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

//value isAdd - True add value to the array, False replace the whole array
procedure JSON_SetValueObjW(FileFullName: String; Value: String; isAdd: Boolean);
begin
    if IsUninstaller() then
        JSON_SetValueObjW_U(FileFullName, Value, isAdd)
    else
        JSON_SetValueObjW_I(FileFullName, Value, isAdd)
end;


// JSON/JSON_GetNamesAndValuesW
procedure JSON_GetNamesAndValuesW_I(FileFullName: String; Path: String; BufNames: String; BufValues: String; BufferSize: Integer);
external 'JSON_GetNamesAndValuesW@files:openwg.utils.dll cdecl setuponly';

procedure JSON_GetNamesAndValuesW_U(FileFullName: String; Path: String; BufNames: String; BufValues: String; BufferSize: Integer);
external 'JSON_GetNamesAndValuesW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

procedure JSON_GetNamesAndValuesW(FileFullName: String; Path: String; BufNames: String; BufValues: String; BufferSize: Integer);
begin
    if IsUninstaller() then
        JSON_GetNamesAndValuesW_U(FileFullName, Path, BufNames, BufValues, BufferSize)
    else
        JSON_GetNamesAndValuesW_I(FileFullName, Path, BufNames, BufValues, BufferSize)
end;


// JSON/JSON_GetNamesAndValuesW
procedure JSON_GetNamesAndValuesW_S_I(StrJSON: String; BufNames: String; BufValues: String; BufferSize: Integer);
external 'JSON_GetNamesAndValuesW_S@files:openwg.utils.dll cdecl setuponly';

procedure JSON_GetNamesAndValuesW_S_U(StrJSON: String; BufNames: String; BufValues: String; BufferSize: Integer);
external 'JSON_GetNamesAndValuesW_S@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

procedure JSON_GetNamesAndValuesW_S(StrJSON: String; BufNames: String; BufValues: String; BufferSize: Integer);
begin
    if IsUninstaller() then
        JSON_GetNamesAndValuesW_S_U(StrJSON, BufNames, BufValues, BufferSize)
    else
        JSON_GetNamesAndValuesW_S_I(StrJSON, BufNames, BufValues, BufferSize)
end;


// JSON/JSON_GetNamesAndValuesW
procedure JSON_GetArrayValueW_S_I(StrJSON: String; BufValues: String; BufferSize: Integer);
external 'JSON_GetArrayValueW_S@files:openwg.utils.dll cdecl setuponly';

procedure JSON_GetArrayValueW_S_U(StrJSON: String; BufValues: String; BufferSize: Integer);
external 'JSON_GetArrayValueW_S@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

procedure JSON_GetArrayValueW_S(StrJSON: String; BufValues: String; BufferSize: Integer);
begin
    if IsUninstaller() then
        JSON_GetArrayValueW_S_U(StrJSON, BufValues, BufferSize)
    else
        JSON_GetArrayValueW_S_I(StrJSON, BufValues, BufferSize)
end;


// IMAGEDRAW/PngToBmp
procedure IMAGEDRAW_PngToBmp_I(FileName: String);
external 'IMAGEDRAW_PngToBmp@files:openwg.utils.dll cdecl setuponly';

procedure IMAGEDRAW_PngToBmp_U(FileName: String);
external 'IMAGEDRAW_PngToBmp@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

procedure IMAGEDRAW_PngToBmp(FileName: String);
begin
    if IsUninstaller() then
        IMAGEDRAW_PngToBmp_U(FileName)
    else
        IMAGEDRAW_PngToBmp_I(FileName)
end;


// PROCESS/GetRunningInDirectoryW
function PROCESS_GetRunningInDirectoryW_I(DirectoryPth: String; Buffer: String; BufferSize: Integer): Boolean;
external 'PROCESS_GetRunningInDirectoryW@files:openwg.utils.dll cdecl setuponly';

function PROCESS_GetRunningInDirectoryW_U(DirectoryPth: String; Buffer: String; BufferSize: Integer): Boolean;
external 'PROCESS_GetRunningInDirectoryW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function PROCESS_GetRunningInDirectoryW(DirectoryPth: String; Buffer: String; BufferSize: Integer): Boolean;
begin
    if IsUninstaller() then
        Result := PROCESS_GetRunningInDirectoryW_U(DirectoryPth, Buffer, BufferSize)
    else
        Result := PROCESS_GetRunningInDirectoryW_I(DirectoryPth, Buffer, BufferSize)
end;


//PROCESS/TerminateProcess
function PROCESS_TerminateProcess_I(ProcessName: String): Boolean;
external 'PROCESS_TerminateProcess@files:openwg.utils.dll cdecl setuponly';

function PROCESS_TerminateProcess_U(ProcessName: String): Boolean;
external 'PROCESS_TerminateProcess@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function PROCESS_TerminateProcess(ProcessName: String): Boolean;
begin
    if IsUninstaller() then
        Result := PROCESS_TerminateProcess_U(ProcessName)
    else
        Result := PROCESS_TerminateProcess_I(ProcessName)
end;


//SPLASHSCREEN/ShowSplashScreenW
function SPLASHSCREEN_ShowSplashScreenW_I(FileName: String; SecondsToShow: Integer): Boolean;
external 'SPLASHSCREEN_ShowSplashScreenW@files:openwg.utils.dll cdecl setuponly';

function SPLASHSCREEN_ShowSplashScreenW_U(FileName: String; SecondsToShow: Integer): Boolean;
external 'SPLASHSCREEN_ShowSplashScreenW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function SPLASHSCREEN_ShowSplashScreenW(FileName: String; SecondsToShow: Integer): Boolean;
begin
    if IsUninstaller() then
        Result := SPLASHSCREEN_ShowSplashScreenW_U(FileName, SecondsToShow)
    else
        Result := SPLASHSCREEN_ShowSplashScreenW_I(FileName, SecondsToShow)
end;


// WINE/IsRunningUnder
function WINE_IsRunningUnder_I(): Boolean;
external 'WINE_IsRunningUnder@files:openwg.utils.dll cdecl setuponly';

function WINE_IsRunningUnder_U(): Boolean;
external 'WINE_IsRunningUnder@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WINE_IsRunningUnder(): Boolean;
begin
    if IsUninstaller() then
        Result := WINE_IsRunningUnder_U()
    else
        Result := WINE_IsRunningUnder_I()
end;


// WOT/AddClientW
function WOT_AddClientW_I(ClientPath: String): Integer;
external 'WOT_AddClientW@files:openwg.utils.dll cdecl setuponly';

function WOT_AddClientW_U(ClientPath: String): Integer;
external 'WOT_AddClientW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_AddClientW(ClientPath: String): Integer;
begin
    if IsUninstaller() then
        Result := WOT_AddClientW_U(ClientPath)
    else
        Result := WOT_AddClientW_I(ClientPath)
end;


// WOT/LauncherGetPreferredClient
function WOT_LauncherGetPreferredClient_I(LauncherFlavour: Integer): Integer;
external 'WOT_LauncherGetPreferredClient@files:openwg.utils.dll cdecl setuponly';

function WOT_LauncherGetPreferredClient_U(LauncherFlavour: Integer): Integer;
external 'WOT_LauncherGetPreferredClient@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_LauncherGetPreferredClient(LauncherFlavour: Integer): Integer;
begin
    if IsUninstaller() then
        Result := WOT_LauncherGetPreferredClient_U(LauncherFlavour)
    else
        Result := WOT_LauncherGetPreferredClient_I(LauncherFlavour)
end;


// WOT/LauncherRescan
function WOT_LauncherRescan_I(): Integer;
external 'WOT_LauncherRescan@files:openwg.utils.dll cdecl setuponly';

function WOT_LauncherRescan_U(): Integer;
external 'WOT_LauncherRescan@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_LauncherRescan(): Integer;
begin
    if IsUninstaller() then
        Result := WOT_LauncherRescan_U()
    else
        Result := WOT_LauncherRescan_I()
end;


// WOT/LauncherSetDefault
function WOT_LauncherSetDefault_I(LauncherFlavour: Integer): Integer;
external 'WOT_LauncherSetDefault@files:openwg.utils.dll cdecl setuponly';

function WOT_LauncherSetDefault_U(LauncherFlavour: Integer): Integer;
external 'WOT_LauncherSetDefault@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_LauncherSetDefault(LauncherFlavour: Integer): Integer;
begin
    if IsUninstaller() then
        Result := WOT_LauncherGetPreferredClient_U(LauncherFlavour)
    else
        Result := WOT_LauncherGetPreferredClient_I(LauncherFlavour)
end;


// WOT/ClientIsStarted
function WOT_ClientIsStarted_I(ClientIndex: Integer): Integer;
external 'WOT_ClientIsStarted@files:openwg.utils.dll cdecl setuponly';

function WOT_ClientIsStarted_U(ClientIndex: Integer): Integer;
external 'WOT_ClientIsStarted@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_ClientIsStarted(ClientIndex: Integer): Integer;
begin
    if IsUninstaller() then
        Result := WOT_ClientIsStarted_U(ClientIndex)
    else
        Result := WOT_ClientIsStarted_I(ClientIndex)
end;


// WOT/ClientTerminate
function WOT_ClientTerminate_I(ClientIndex: Integer): Integer;
external 'WOT_ClientTerminate@files:openwg.utils.dll cdecl setuponly';

function WOT_ClientTerminate_U(ClientIndex: Integer): Integer;
external 'WOT_ClientTerminate@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_ClientTerminate(ClientIndex: Integer): Integer;
begin
    if IsUninstaller() then
        Result := WOT_ClientTerminate_U(ClientIndex)
    else
        Result := WOT_ClientTerminate_I(ClientIndex)
end;


// WOT/GetClientsCount
function WOT_GetClientsCount_I(): Integer;
external 'WOT_GetClientsCount@files:openwg.utils.dll cdecl setuponly';

function WOT_GetClientsCount_U(): Integer;
external 'WOT_GetClientsCount@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_GetClientsCount(): Integer;
begin
    if IsUninstaller() then
        Result := WOT_GetClientsCount_U()
    else
        Result := WOT_GetClientsCount_I()
end;


// WOT/GetClientBranch
function WOT_GetClientBranch_I(ClientIndex: Integer): Integer;
external 'WOT_GetClientBranch@files:openwg.utils.dll cdecl setuponly';

function WOT_GetClientBranch_U(ClientIndex: Integer): Integer;
external 'WOT_GetClientBranch@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_GetClientBranch(ClientIndex: Integer): Integer;
begin
    if IsUninstaller() then
        Result := WOT_GetClientBranch_U(ClientIndex)
    else
        Result := WOT_GetClientBranch_I(ClientIndex)
end;


// WOT/GetClientLauncherFlavour
function WOT_GetClientLauncherFlavour_I(ClientIndex: Integer): Integer;
external 'WOT_GetClientLauncherFlavour@files:openwg.utils.dll cdecl setuponly';

function WOT_GetClientLauncherFlavour_U(ClientIndex: Integer): Integer;
external 'WOT_GetClientLauncherFlavour@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_GetClientLauncherFlavour(ClientIndex: Integer): Integer;
begin
    if IsUninstaller() then
        Result := WOT_GetClientLauncherFlavour_U(ClientIndex)
    else
        Result := WOT_GetClientLauncherFlavour_I(ClientIndex)
end;


// WOT/GetClientLocale
procedure WOT_GetClientLocaleW_I(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientLocaleW@files:openwg.utils.dll cdecl setuponly';

procedure WOT_GetClientLocaleW_U(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientLocaleW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

procedure WOT_GetClientLocaleW(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
begin
    if IsUninstaller() then
        WOT_GetClientLocaleW_U(Buffer, BufferSize, ClientIndex)
    else
        WOT_GetClientLocaleW_I(Buffer, BufferSize, ClientIndex)
end;


// WOT/GetClientPathW
procedure WOT_GetClientPathW_I(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientPathW@files:openwg.utils.dll cdecl setuponly';

procedure WOT_GetClientPathW_U(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientPathW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

procedure WOT_GetClientPathW(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
begin
    if IsUninstaller() then
        WOT_GetClientPathW_U(Buffer, BufferSize, ClientIndex)
    else
        WOT_GetClientPathW_I(Buffer, BufferSize, ClientIndex)
end;


// WOT/GetClientRealmW
procedure WOT_GetClientRealmW_I(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientRealmW@files:openwg.utils.dll cdecl setuponly';

procedure WOT_GetClientRealmW_U(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientRealmW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

procedure WOT_GetClientRealmW(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
begin
    if IsUninstaller() then
        WOT_GetClientRealmW_U(Buffer, BufferSize, ClientIndex)
    else
        WOT_GetClientRealmW_I(Buffer, BufferSize, ClientIndex)
end;


// WOT/GetClientType
function WOT_GetClientType_I(ClientIndex: Integer): Integer;
external 'WOT_GetClientType@files:openwg.utils.dll cdecl setuponly';

function WOT_GetClientType_U(ClientIndex: Integer): Integer;
external 'WOT_GetClientType@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

function WOT_GetClientType(ClientIndex: Integer): Integer;
begin
    if IsUninstaller() then
        Result := WOT_GetClientType_U(ClientIndex)
    else
        Result := WOT_GetClientType_I(ClientIndex)
end;


// WOT/GetClientVersionW
procedure WOT_GetClientVersionW_I(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientVersionW@files:openwg.utils.dll cdecl setuponly';

procedure WOT_GetClientVersionW_U(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientVersionW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

procedure WOT_GetClientVersionW(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
begin
    if IsUninstaller() then
        WOT_GetClientVersionW_U(Buffer, BufferSize, ClientIndex)
    else
        WOT_GetClientVersionW_I(Buffer, BufferSize, ClientIndex)
end;


// WOT/GetClientExeVersionW
procedure WOT_GetClientExeVersionW_I(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientExeVersionW@files:openwg.utils.dll cdecl setuponly';

procedure WOT_GetClientExeVersionW_U(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientExeVersionW@{app}\{#OPENWGUTILS_DIR_UNINST}\openwg.utils.dll cdecl uninstallonly';

procedure WOT_GetClientExeVersionW(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
begin
    if IsUninstaller() then
        WOT_GetClientExeVersionW_U(Buffer, BufferSize, ClientIndex)
    else
        WOT_GetClientExeVersionW_I(Buffer, BufferSize, ClientIndex)
end;
