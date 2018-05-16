[Code]

const
  BTN_WIDTH = 75;
  BTN_HEIGHT = 23;
  BORDER_WIDTH = 20;

type
  TItems = (iCheckBox, iRadioBtn, iGroup);
  TSettings = record 
    NameFile: string;
    Value: string;
    AdditionalFiles: string;
    IsAdd: Boolean;
  end;
var
  arraySettings: array of TSettings;
  FNameSettings, SelectPreset, DirTemp: string;
  Image: TBitmapImage;
  SettingsCheckListBox: TNewCheckListBox;
  sizeBuf: Integer;

procedure GetNamesAndValues(Path: String; ALevel: Byte; TypeItem : TItems);  forward;

procedure Init;
var
  ResultCode, i: Integer;
begin
  DirTemp := ExpandConstant('{tmp}\') + SelectPreset;
  ExtractTemporaryFile(SelectPreset + '.mrg');
  if not Exec(ExpandConstant('{tmp}\merg_f.exe'), ' -d ' + SelectPreset + '.mrg ' + DirTemp, ExpandConstant('{tmp}'), SW_HIDE, ewWaitUntilTerminated, ResultCode) then
    MsgBox(SysErrorMessage(ResultCode) , mbInformation, MB_OK);
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
            tmp := DirTemp + '\files' + FileName;
            app := ExpandConstant('{app}') + FileName;
          end
          else
          begin
            tmp := DirTemp + '\files\' + FileName;
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
    begin
      JSON_SetValueObjW(ExpandConstant('{app}\res_mods\configs\xvm\') + SelectPreset + '\' + arraySettings[i].NameFile, arraySettings[i].Value, arraySettings[i].IsAdd);
      //SaveStringToFile(ExpandConstant('{src}\log.txt'), inttostr(i) + ' = ' + arraySettings[i].Value + #13, True);
    end;
    if arraySettings[i].AdditionalFiles <> '' then
      CopyingAdditionalFiles(arraySettings[i].AdditionalFiles);
  end;
end;

procedure AddItem(Path : String; NamesList, ValuesList: TStringList; ALevel : Byte; TypeItem : TItems);
var
  Setting: TStringList;
  Index: Integer;
  Name: string;
  Checked: boolean;
begin
  //MsgBox(Path, mbInformation, MB_OK);
  //MsgBox(IntToStr(NamesList.Count) + NamesList.Text, mbInformation, MB_OK);
  //MsgBox(IntToStr(ValuesList.Count) + ValuesList.Text, mbInformation, MB_OK);
  Setting := TStringList.Create;
  if NamesList.Find('name', Index) then
    Name := ValuesList[Index]   //name
  else
    Exit;
  Checked := not (NamesList.Find('checked', Index) and (AnsiLowercase(Trim(ValuesList[Index])) = 'false'));
  TypeItem := iCheckBox;
  if NamesList.Find('itemtype', Index) then
    if (AnsiLowercase(Trim(ValuesList[Index])) = 'group') then
      TypeItem := iGroup
    else if (AnsiLowercase(Trim(ValuesList[Index])) = 'radiobutton') then
      TypeItem := iRadioBtn;
  if NamesList.Find('imagesifselected', Index) and (Trim(ValuesList[Index]) <> '') then
    Setting.Append(ValuesList[Index])   //0 - imagesIfSelected
  else
    Setting.Append('empty.bmp');
  if NamesList.Find('imagesifnotselected', Index) and (Trim(ValuesList[Index]) <> '') then
    Setting.Append(ValuesList[Index])   //1 - imagesIfNotSelected
  else
    Setting.Append('empty.bmp');
  if NamesList.Find('valueifselected', Index) then
    Setting.Append(ValuesList[Index])   //2 - valueIfSelected
  else
    Setting.Append('');
  if NamesList.Find('valueifnotselected', Index) then
    Setting.Append(ValuesList[Index])   //3 - valueIfNotSelected
  else
    Setting.Append('');
  //MsgBox(Name + #13 + Setting.Text, mbInformation, MB_OK);
  case TypeItem of
    iCheckBox:
      SettingsCheckListBox.AddCheckBox(Name, '', ALevel, Checked, True, True, False, Setting);
    iRadioBtn:
      SettingsCheckListBox.AddRadioButton(Name, '', ALevel, Checked, True, Setting);
    iGroup:
      SettingsCheckListBox.AddGroup(Name, '', ALevel, nil);
  end;
  if NamesList.Find('children', Index) then
    GetNamesAndValues(Path + '/children', ALevel + 1, TypeItem);
  
end;

procedure GetNamesAndValues(Path: String; ALevel: Byte; TypeItem : TItems);
var
  RootList, NamesList, ValuesList: TStringList;
  FileName, BufNames, BufValues: string;
  i: integer;
begin
  try    
    FileName := DirTemp + '\' + FNameSettings;
    //MsgBox('FileName = ' + FileName, mbInformation, MB_OK);
    SetLength(BufNames, sizeBuf);
    SetLength(BufValues, sizeBuf);
    JSON_GetNamesAndValuesW(FileName, Path, BufNames, BufValues, sizeBuf);
    RootList := TStringList.Create;
    try
      RootList.Text := Copy(BufNames,0,Pos(#0, BufNames));
      //MsgBox(IntToStr(RootList.Count) + RootList.Text, mbInformation, MB_OK);
      if Trim(Path) <> '' then Path := Path + '/';
      for i := 0 to RootList.Count - 1 do
      begin
        NamesList := TStringList.Create;
        ValuesList := TStringList.Create;
        try
          JSON_GetNamesAndValuesW(FileName, Path + RootList[i], BufNames, BufValues, sizeBuf);
          NamesList.Text := AnsiLowercase(Copy(BufNames,0,Pos(#0, BufNames)));
          ValuesList.Text := Copy(BufValues,0,Pos(#0, BufValues));
          AddItem(Path + RootList[i], NamesList, ValuesList, ALevel, TypeItem);
        finally
          NamesList.Free;
          ValuesList.Free;
        end;
      end;
    finally
      RootList.Free;
    end;
  except
    //ShowExceptionMessage;
  end;
end;

procedure AddToArrayS(Value: string; var j: Integer);
var
  RootList, NamesList, ValuesList: TStringList;
  i, Index: Integer;
  BufNames, BufValues: string;
begin
  SetLength(BufNames, sizeBuf);
  SetLength(BufValues, sizeBuf);
  JSON_GetNamesAndValuesW_S(Value, BufNames, BufValues, sizeBuf);
  RootList := TStringList.Create;
  try
    RootList.Text := Copy(BufValues,0,Pos(#0, BufValues));
    
    for i := 0 to RootList.Count - 1 do
    begin
      NamesList := TStringList.Create;
      ValuesList := TStringList.Create;
      try
        JSON_GetNamesAndValuesW_S(RootList[i], BufNames, BufValues, sizeBuf);
        NamesList.Text := AnsiLowercase(Copy(BufNames,0,Pos(#0, BufNames)));
        ValuesList.Text := Copy(BufValues,0,Pos(#0, BufValues));
        if NamesList.Find('configfilename', Index) then
        begin
          arraySettings[j].NameFile := ValuesList[Index];
          if NamesList.Find('value', Index) then
            arraySettings[j].Value := ValuesList[Index];
        end
        else
        begin
          arraySettings[j].NameFile := '';
          arraySettings[j].Value := '';
        end;
        if NamesList.Find('@files', Index) then
          arraySettings[j].AdditionalFiles := ValuesList[Index]
        else
          arraySettings[j].AdditionalFiles := '';
        if (NamesList.Find('isadd', Index)) and (AnsiLowercase(Trim(ValuesList[Index])) = 'false') then
          arraySettings[j].IsAdd := False
        else
          arraySettings[j].IsAdd := True;

        //MsgBox('AdditionalFiles = ' + AdditionalFiles, mbInformation, MB_OK);
        j:= j + 1;
        if j >= Length(arraySettings) then
          SetLength(arraySettings, j + 20);
      finally
        NamesList.Free;
        ValuesList.Free;
      end;
    end;
  finally
    RootList.Free;
  end;
end;

procedure SetSettings;
var
  i, j: Integer;
  Value: string;
begin
  with SettingsCheckListBox do
  begin
    SetLength(arraySettings, Items.Count);
    j:= 0;
    for i := 0 to Items.Count - 1 do
    begin
      case State[i] of
      cbUnchecked:
        Value := TStringList(ItemObject[i]).Strings[3];
      cbChecked, cbGrayed:
        Value := TStringList(ItemObject[i]).Strings[2];
      end;
      if Trim(Value) <> '' then
        AddToArrayS(Value, j);
    end;
    SetLength(arraySettings, j);
  end;
end;

procedure SettingsCheckListBoxOnClickCheck(Sender: TObject);
var
  ImageName, ImageNameBMP: string;
begin
  with TNewCheckListBox(Sender) do
  begin
    case State[ItemIndex] of
    cbUnchecked:
      ImageName := TStringList(ItemObject[ItemIndex]).Strings[1];
    cbChecked, cbGrayed:
      ImageName := TStringList(ItemObject[ItemIndex]).Strings[0];
    end;
    try
      ImageNameBMP := DirTemp + '\images\' + ChangeFileExt(ImageName, '.bmp');
      if (AnsiLowercase(ExtractFileExt(ImageName)) = '.png') and not FileExists(ImageNameBMP)then
        IMAGEDRAW_PngToBmp(DirTemp + '\images\' + ImageName);
      Image.Bitmap.LoadFromFile(ImageNameBMP);
    except
      //ShowExceptionMessage;
    end;
  end; 
end;

procedure SelectComponentButtonOnClick(Sender: TObject);
var
  SelectComponentForm: TSetupForm;
  
  OKButton, CancelButton: TNewButton;
  Bevel: TBevel;
begin
  init;
  SelectComponentForm := CreateCustomForm();
  try
    SelectComponentForm.ClientWidth := ScaleX(730);
    SelectComponentForm.ClientHeight := ScaleY(500);
    SelectComponentForm.Caption := ExpandConstant('{cm:SettingConfigurationForm}');
    SelectComponentForm.CenterInsideControl(WizardForm, False);

    Bevel := TBevel.Create(SelectComponentForm);
    Bevel.Top := SelectComponentForm.ClientHeight - ScaleY(BTN_HEIGHT + 10 + 14);
    Bevel.Left := ScaleX(0);
    Bevel.Width := SelectComponentForm.ClientWidth;
    Bevel.Height := ScaleY(2);
    Bevel.Parent := SelectComponentForm; 

    OKButton := TNewButton.Create(SelectComponentForm);
    OKButton.Parent := SelectComponentForm;
    OKButton.Width := ScaleX(BTN_WIDTH);
    OKButton.Height := ScaleY(BTN_HEIGHT);
    OKButton.Left := SelectComponentForm.ClientWidth - ScaleX(BTN_WIDTH + 6 + BTN_WIDTH + 10);
    OKButton.Top := SelectComponentForm.ClientHeight - ScaleY(BTN_HEIGHT + 10);
    OKButton.Caption := ExpandConstant('{cm:ButtonOK}');
    OKButton.ModalResult := mrOk;
    OKButton.Default := True;

    CancelButton := TNewButton.Create(SelectComponentForm);
    CancelButton.Parent := SelectComponentForm;
    CancelButton.Width := ScaleX(BTN_WIDTH);
    CancelButton.Height := ScaleY(BTN_HEIGHT);
    CancelButton.Left := SelectComponentForm.ClientWidth - ScaleX(BTN_WIDTH + 10);
    CancelButton.Top := SelectComponentForm.ClientHeight - ScaleY(BTN_HEIGHT + 10);
    CancelButton.Caption := ExpandConstant('{cm:ButtonCancel}');
    CancelButton.ModalResult := mrCancel;
    CancelButton.Cancel := True;

    SettingsCheckListBox := TNewCheckListBox.Create(SelectComponentForm);
    SettingsCheckListBox.Top := ScaleY(BORDER_WIDTH);
    SettingsCheckListBox.Left := ScaleX(BORDER_WIDTH);
    SettingsCheckListBox.Width := ScaleX(300);
    SettingsCheckListBox.Height := Bevel.Top - ScaleY(BORDER_WIDTH + BORDER_WIDTH);
    SettingsCheckListBox.Parent := SelectComponentForm;
    SettingsCheckListBox.OnClickCheck := @SettingsCheckListBoxOnClickCheck;

    FileSize(DirTemp + '\' + FNameSettings, sizeBuf);
    GetNamesAndValues(' ', 0, iCheckBox);

    Image := TBitmapImage.Create(SelectComponentForm);
    Image.Top := ScaleY(BORDER_WIDTH);
    Image.Left := SettingsCheckListBox.Left + SettingsCheckListBox.Width + ScaleX(BORDER_WIDTH);
    Image.Width := SelectComponentForm.ClientWidth - Image.Left - ScaleX(BORDER_WIDTH);
    Image.Height := Bevel.Top - ScaleY(BORDER_WIDTH + BORDER_WIDTH);
    Image.Parent := SelectComponentForm;
    Image.Center := True;
    //ExtractTemporaryFile('big_image.bmp');
    //Image.Bitmap.LoadFromFile(ExpandConstant('{tmp}\big_image.bmp'));

    SelectComponentForm.ActiveControl := SettingsCheckListBox;

    if SelectComponentForm.ShowModal() = mrOk then
      SetSettings;
  finally
    SelectComponentForm.Free();
  end;
end;


procedure AddButtonSelectComponent();
var
  SelectComponentButton: TNewButton;
begin
  with WizardForm do
  begin
    SelectComponentButton := TNewButton.Create(WizardForm);
    SelectComponentButton.Width := ScaleX(145);
    SelectComponentButton.Left := TypesCombo.Left + TypesCombo.Width - SelectComponentButton.Width + ScaleX(1);
    SelectComponentButton.Top := TypesCombo.Top + TypesCombo.Height + ScaleX(15);
    SelectComponentButton.Height := CancelButton.Height;
    SelectComponentButton.Caption := ExpandConstant('{cm:SettingConfigurationBtn}');
    SelectComponentButton.OnClick := @SelectComponentButtonOnClick;
    SelectComponentButton.Parent := SelectComponentsLabel.Parent;
  end;
end;