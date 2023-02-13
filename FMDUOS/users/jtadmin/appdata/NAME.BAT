@echo off
strings len=linesize list.txt
strings len=add %len%,2

:choumain
random.com 1 %len%>chouqv.tmp
set /p name=<chouqv.tmp
strings name=read list.txt,%name%
call w.bat box @%0:chouqv
if "%errorlevel%"=="0" goto exit
if errorlevel 100 goto exit
goto choumain

:chouqv "µãÃûÆ÷" [x]
 %name%
[³éÃû×Ö]
:

:exit
if exist chouqv.tmp del chouqv.tmp
cls
