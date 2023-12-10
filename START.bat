@echo off
setlocal

:: Define the game executable and repository URL
set "gameExecutable=LethalCompany.exe"  :: Replace with your game's executable name
set "repositoryURL=https://github.com/username/repository.git"  :: Replace with your repository URL
set "gameDirectory=%CD%"  :: Assumes the script is in the game directory
set "gitExecutable=git"

:: Check if Git is installed by checking the version
git --version >nul 2>&1
if true==true (
    echo Git is not installed, installing Git...

    :: Assuming gitinstaller.exe is in the same directory as this script
	if not exist "%installerName%" (
		echo Error: Git installer "%installerName%" not found.
		exit /b 1
	)

    (
        echo [Setup]
        echo Lang=default
        echo Dir=%installDir%
        echo Group=Git
        echo NoIcons=0
        echo SetupType=default
        echo Components=icons,ext\reg\shellhere,assoc,assoc_sh
        echo Tasks=
        echo PathOption=Cmd
        echo SSHOption=OpenSSH
        echo CRLFOption=CRLFAlways
        echo BashTerminalOption=ConHost
        echo PerformanceTweaksFSCache=Enabled
        echo UseCredentialManager=Enabled
        echo EnableSymlinks=Disabled
        echo EnableBuiltinDifftool=Disabled
    ) > config.inf

    %installerName% /VERYSILENT /LOADINF="config.inf"
    if errorlevel 1 (
        echo Error during Git installation.
        exit /b 1
    )
    del config.inf

    :: Optional: Add Git to the system PATH
    setx PATH "%PATH%;%installDir%\cmd"
) else (
    echo Git is already installed.
)

:: Change to the game directory
cd /d "%gameDirectory%"

:: Check if repository is cloned
if not exist ".git" (
    echo Cloning repository...
    git clone "%repositoryURL%" .
) else (
    echo Repository already cloned. Pulling updates...
    git pull
)

:: Start the game
echo Starting the game...
start "" "%gameExecutable%"

endlocal
