; Inno Setup Script для Game Library
; Скачать Inno Setup: https://jrsoftware.org/isdl.php

[Setup]
AppName=Game Library
AppVersion=1.0.0
AppPublisher=Your Name
AppContact=your@email.com
DefaultDirName={autopf}\GameLibrary
DefaultGroupName=Game Library
DisableProgramGroupPage=yes
LicenseFile=
OutputDir=installer_output
OutputBaseFilename=GameLibrary_Setup
Compression=lzma
SolidCompression=yes
WizardStyle=modern
SetupIconFile=compiler:MyIcon.ico
UninstallDisplayIcon={app}\icon.ico

[Languages]
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 6.1; Check: not IsAdminInstallMode

[Files]
Source: "*"; DestDir: "{app}"; Excludes: "*.git*,*.pyc,__pycache__,venv,installer_output,*.bat,setup.py,setup_db.py"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "requirements.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "src\*"; DestDir: "{app}\src"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "database\*"; DestDir: "{app}\database"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "icon.ico"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\Game Library"; Filename: "{app}\run.bat"; IconFilename: "{app}\icon.ico"
Name: "{autodesktop}\Game Library"; Filename: "{app}\run.bat"; IconFilename: "{app}\icon.ico"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Game Library"; Filename: "{app}\run.bat"; IconFilename: "{app}\icon.ico"; Tasks: quicklaunchicon

[Run]
Filename: "{sys}\cmd.exe"; Parameters: "/c ""{app}\venv\Scripts\python.exe -m pip install --upgrade pip"""; Flags: runhidden waituntilterminated
Filename: "{sys}\cmd.exe"; Parameters: "/c ""{app}\venv\Scripts\pip.exe install -r {app}\requirements.txt"""; Flags: runhidden waituntilterminated
Description: "Запустить Game Library"; Filename: "{app}\run.bat"; Flags: postinstall skipifsilent unchecked

[Code]
function InitializeSetup(): Boolean;
var
  ResultCode: Integer;
begin
  Result := True;
  // Можно добавить проверку наличия Python или PostgreSQL
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    // Пост-установочные действия
  end;
end;
