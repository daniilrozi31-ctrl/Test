@echo off
setlocal
cd /d "%~dp0"

if not exist "ragemp-server.exe" (
  echo ERROR: ragemp-server.exe was not found.
  echo Put this file in the RAGE:MP server folder, next to ragemp-server.exe.
  pause
  exit /b 1
)

ragemp-server.exe
if errorlevel 1 (
  echo The server exited with an error.
  pause
)
endlocal
