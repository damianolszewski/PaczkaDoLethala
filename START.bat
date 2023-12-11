@echo off
setlocal

echo:
echo:
echo              _    _               _ _          _             
echo        /\   ^| ^|  ^| ^|             ^| (_)        ^| ^|            
echo       /  \  ^| ^| _^| ^|_ _   _  __ _^| ^|_ ______ _^| ^|_ ___  _ __ 
echo      / /\ \ ^| ^|/ / __^| ^| ^| ^|/ _` ^| ^| ^|_  / _` ^| __/ _ \^| '__^|
echo     / ____ \^|   ^<^| ^|_^| ^|_^| ^| (_^| ^| ^| ^|/ / (_^| ^| ^|^| (_) ^| ^|   
echo    /_/    \_\_^|\_\\__^|\__,_^|\__,_^|_^|_/___\__,_^|\__\___/^|_^|                        
echo:
echo:
echo:
echo:

:: Define the game executable and repository URL
set "gameExecutable=Lethal Company.exe"
set "repositoryURL=https://github.com/damianolszewski/PaczkaDoLethala.git"
set "gameDirectory=%CD%"
set "gitExecutable=git"

:: Check if Git is installed by checking the version
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Git nie jest zainstalowany!
    echo Wcisnij dowolny przycisk aby wyjsc...
    pause >nul
    exit /b 1
) else (
    echo Git jest zainstalowany.
)

:: Change to the game directory
cd /d "%gameDirectory%"

:: Initialize the directory as a Git repository if not already a repository
if not exist ".git" (
    echo Inicjalizuje repozytorium w folderze gry...
	echo -----------------------------------------------
    git init
    git remote add origin "%repositoryURL%"
	echo -----------------------------------------------
    
    echo Pobieram informacje o repozytorium...
	echo -----------------------------------------------
    git fetch
	echo -----------------------------------------------

    echo Pobieram pliki z repozytorium...
	echo -----------------------------------------------
    git checkout -t origin/main
	echo -----------------------------------------------

    echo Repozytorium zostalo poprawnie sklonowane.
) else (
    echo Repozytorium bylo juz klonowane. Pobieram aktualizacje...
	echo -----------------------------------------------
    git pull origin main
	echo -----------------------------------------------
)

echo Pliki zaktualizowane.

:: Check if a parameter was passed to the script
if not "%~1"=="" (
    echo Startuje gre...
    %1
) else (
    echo Wcisnij dowolny przycisk aby wyjsc...
    pause >nul
)

endlocal