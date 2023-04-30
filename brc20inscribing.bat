@echo off
setlocal enabledelayedexpansion

:: Set the number of times to run the command
set NUM_RUNS=<number_of_runs>
set FEE_RATE=<fee_rate>
set FILE_NAME=<file_name>

:: Create a file to store the inscriptions
set INSCRIPTIONS_FILE=inscriptions.txt

:: Remove the previous inscriptions file if it exists
if exist %INSCRIPTIONS_FILE% del %INSCRIPTIONS_FILE%

:: Run the command the specified number of times
for /L %%i in (1, 1, %NUM_RUNS%) do (
  for /F "usebackq tokens=* delims=" %%a in (`ord wallet inscribe --fee-rate %FEE_RATE% %FILE_NAME%`) do (
    set OUTPUT=%%a
    echo !OUTPUT!

    :: Extract the inscription value and save it to the file
    if "!OUTPUT:~1,11!"=="inscription" (
      set INSCRIPTION=!OUTPUT:~15,56!
      echo Saving inscription: !INSCRIPTION!
      echo !INSCRIPTION!>>%INSCRIPTIONS_FILE%
    )
  )
)
