
[Files]
Source: "SettingsInstall\default\config\*"; DestDir: "{app}"; Flags: createallsubdirs recursesubdirs
Source: "SettingsInstall\default\default.mrg"; Flags: dontcopy

[Components]
Name: "default"; Description: "Config default XVM"; Types: default
;Name: "user"; Description: "User config"; Types: user

[Types]
Name: "default"; Description: "Default config"
;Name: "user"; Description: "User config"

[Code]

const 
  DEFAULT = 'default';

procedure TypesComboOnChange(Sender: TObject);
begin
  
  if WizardForm.TypesCombo.Text = 'Default config' then
  begin
    FNameSettings := DEFAULT + '.xc';
  end;
end;

function Init: boolean;
var
  ResultCode: Integer;
begin
  
  ExtractTemporaryFile('merg_f.exe');
  ExtractTemporaryFile(DEFAULT + '.mrg');
  if not Exec(ExpandConstant('{tmp}\merg_f.exe'), ' -d ' + DEFAULT + '.mrg', ExpandConstant('{tmp}'), SW_HIDE, ewNoWait, ResultCode) then
    MsgBox(SysErrorMessage(ResultCode) , mbInformation, MB_OK);
  Result := True;
end;

procedure CopyingAdditionalFiles(AdditionalFiles : String);
var
  FileNames : TStringList;
  i: Integer;
  tmp, app, FileName, Buffer : String;
begin
  SetLength(Buffer, sizeBuf);
  JSON_GetArrayValueW_S(AdditionalFiles, Buffer, sizeBuf);
  FileNames := TStringList.Create;
  try
    FileNames.Text := Copy(Buffer,0,Pos(#0, Buffer));
    for i := 0 to FileNames.Count - 1 do
      if FileNames[i] <> '' then
        begin
          FileName := FileNames[i];
          StringChangeEx(FileName, '/', '\', True);
          if FileName[1] = #92 then
          begin
            tmp := ExpandConstant('{tmp}\files') + FileName;
            app := ExpandConstant('{app}') + FileName;
          end
          else
          begin
            tmp := ExpandConstant('{tmp}\files\') + FileName;
            app := ExpandConstant('{app}\') + FileName;
          end;
          if not FileCopy(tmp, app, False) then
            SaveStringToFile(ExpandConstant('{src}\log.txt'), FileName + ' - file not copied' + #13, True);
        end;
  finally
    FileNames.Free;
  end;
end;

procedure ApplySettings;
var
  Count, i: Integer;
begin
  Count:= Length(arraySettings);
  for i := 0 to Count - 1 do
  begin
    if (arraySettings[i].NameFile <> '') and (arraySettings[i].Value <> '') then
      JSON_SetValueObjW(ExpandConstant('{app}\res_mods\configs\xvm\') + DEFAULT + '\' + arraySettings[i].NameFile, arraySettings[i].Value, arraySettings[i].IsAdd);
    if arraySettings[i].AdditionalFiles <> '' then
      CopyingAdditionalFiles(arraySettings[i].AdditionalFiles);
  end;
end;