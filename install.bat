@echo 0ff

set /a count = 1
set /a list
echo %cd%

setlocal enableextensions enabledelayedexpansion
for /f %%a in ('type "set_preferred_time.txt" ^| findstr /R "[0-9]" set_preferred_time.txt') do (
  set /a count += 1
  set "list=!List! %%a"
)
set /a count = -1
for %%I in (%list%) do (
    set /a count += 1
    call set "arr[%%count%%]=%%~I"
)

cls

SCHTASKS /CREATE /SC DAILY /TN "Theme Changer\Light Theme" /TR "%CD%\Source\changeLight.bat" /ST %arr[0]% /DU 00:30 /K
SCHTASKS /CREATE /SC DAILY /TN "Theme Changer\Dark Theme" /TR "%CD%\Source\changeDark.bat" /ST %arr[1]% /DU 00:30 /K

cd Source
call "setup.bat"

endlocal