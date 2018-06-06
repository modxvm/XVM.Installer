[Code]


//JSON
function  JSON_ContainsKeyW(JSON: String; Path: String): Boolean;
external 'JSON_ContainsKeyW@files:innoextensions.dll cdecl';

procedure JSON_GetValueW(JSON: String; Path: String; Buffer: String; BufferSize: Integer);
external 'JSON_GetValueW@files:innoextensions.dll cdecl';

procedure JSON_SetValueBoolW(FileFullName: String; ValuePath: String; Value: Boolean);
external 'JSON_SetValueBoolW@files:innoextensions.dll cdecl';

//value isAdd - True add value to the array, False replace the whole array
procedure JSON_SetValueObjW(FileFullName: String; Value: String; isAdd: Boolean);
external 'JSON_SetValueObjW@files:innoextensions.dll cdecl';

procedure JSON_GetNamesAndValuesW(FileFullName: String; Path: String; BufNames: String; BufValues: String; BufferSize: Integer);
external 'JSON_GetNamesAndValuesW@files:innoextensions.dll cdecl';

procedure JSON_GetNamesAndValuesW_S(StrJSON: String; BufNames: String; BufValues: String; BufferSize: Integer);
external 'JSON_GetNamesAndValuesW_S@files:innoextensions.dll cdecl';

procedure JSON_GetArrayValueW_S(StrJSON: String; BufValues: String; BufferSize: Integer);
external 'JSON_GetArrayValueW_S@files:innoextensions.dll cdecl';

procedure IMAGEDRAW_PngToBmp(FileName: String);
external 'IMAGEDRAW_PngToBmp@files:innoextensions.dll cdecl';

//PROCESS
function PROCESS_GetRunningInDirectoryW(DirectoryPth: String; Buffer: String; BufferSize: Integer): Boolean;
external 'PROCESS_GetRunningInDirectoryW@files:innoextensions.dll cdecl';

function PROCESS_TerminateProcess(ProcessName: String): Boolean;
external 'PROCESS_TerminateProcess@files:innoextensions.dll cdecl';


//WGC
procedure WGC_GetInstallPathW(Buffer: String; BufferSize: Integer);
external 'WGC_GetInstallPathW@files:innoextensions.dll cdecl';

function WGC_IsInstalled(): Boolean;
external 'WGC_IsInstalled@files:innoextensions.dll cdecl';


//Wine
function WINE_IsRunningUnder(): Boolean;
external 'WINE_IsRunningUnder@files:innoextensions.dll cdecl';


//WoT
function WOT_AddClientW(ClientPath: String): Integer;
external 'WOT_AddClientW@files:innoextensions.dll cdecl';

procedure WOT_GetPreferredClientPathW(Buffer: String; BufferSize: Integer);
external 'WOT_GetPreferredClientPathW@files:innoextensions.dll cdecl';

function WOT_GetClientsCount(): Integer;
external 'WOT_GetClientsCount@files:innoextensions.dll cdecl';

function WOT_GetClientBranch(ClientIndex: Integer): Integer;
external 'WOT_GetClientBranch@files:innoextensions.dll cdecl';

function WOT_GetClientType(ClientIndex: Integer): Integer;
external 'WOT_GetClientType@files:innoextensions.dll cdecl';

procedure WOT_GetClientLocaleW(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientLocaleW@files:innoextensions.dll cdecl';

procedure WOT_GetClientPathW(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientPathW@files:innoextensions.dll cdecl';

procedure WOT_GetClientVersionW(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientVersionW@files:innoextensions.dll cdecl';

procedure WOT_GetClientExeVersionW(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientExeVersionW@files:innoextensions.dll cdecl';
