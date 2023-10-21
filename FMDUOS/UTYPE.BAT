@echo off
if "%1"=="" goto help
if "%1"=="/?" goto help
if "%1"=="-?" goto help
if "%1"=="-h" goto help
set wshadow=none
set codeu=%2
if "%2"=="" set codeu=gbk
if exist %SYSDRV%\FMDU\SYSX86\hxldr32.exe hxldr32.exe -q>nul
iconv -c -f UTF-8 -t gbk %1>nul
if errorlevel 1 goto noutf8
iconv -c -f UTF-8 -t %codeu% %1>mtemp.tmp
wbat list mtemp.tmp
if exist mtemp.tmp del mtemp.tmp
goto exit

:noutf8
wbat list %1
goto exit

:help
echo UTYPE [file]
echo use this to config the codepage of the file and read file in set codepage.
goto exit

:exit
set codeu=
if exist %SYSDRV%\FMDU\SYSX86\hxldr32.exe hxldr32.exe -u>nul