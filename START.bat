@echo off
setlocal

:: Define the game executable and repository URL
set "gameExecutable=Lethal Company.exe"  :: Replace with your game's executable name
set "repositoryURL=https://github.com/damianolszewski/PaczkaDoLethala.git"  :: Replace with your repository URL
set "gameDirectory=%CD%"  :: Assumes the script is in the game directory
set "gitExecutable=git"

:: Check if Git is installed by checking the version
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Git is not installed. Please run gitinstaller.exe to install Git.
    echo Press any key to exit...
    pause >nul
    exit /b 1
) else (
    echo Git is installed.
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
