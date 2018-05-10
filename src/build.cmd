cd %CD%\SettingsInstall
..\utils\merg_f.exe -mr default -e default\config
cd ..
"%ProgramFiles(x86)%\Inno Setup 5\ISCC.exe" xvm.iss