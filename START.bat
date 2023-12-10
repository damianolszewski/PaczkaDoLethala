@echo off
setlocal

:: Define the game executable and repository URL
set "gameExecutable=Lethal Company.exe"
set "repositoryURL=https://github.com/damianolszewski/PaczkaDoLethala.git"
set "gameDirectory=%CD%"
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

:: Initialize the directory as a Git repository if not already a repository
if not exist ".git" (
    echo Initializing repository in the current directory...
    git init
    git remote add origin "%repositoryURL%"
    
    echo Fetching repository data...
    git fetch

    echo Checking out files from the repository...
    git checkout -t origin/main

    echo Repository cloned into existing directory.
) else (
    echo Repository already cloned. Pulling updates...
    git pull origin main
)

echo Press any key to continue...
pause 

endlocal