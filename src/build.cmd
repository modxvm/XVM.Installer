cd %CD%\SettingsInstall
..\utils\merg_f.exe -mr default -e default\config
..\utils\merg_f.exe -mr default_cb -e default_cb\config
cd ..
"%ProgramFiles(x86)%\Inno Setup 5\ISCC.exe" xvm.iss