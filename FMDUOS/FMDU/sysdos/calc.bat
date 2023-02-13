@echo off
wbat save
copy %temp%\wscreen.0 %FMDUDIR%>nul
set wshadow=none
rem -----------小数点位数------------
set digital=10
rem ---------------------------------
if "%1"=="/?" goto _help
echo=>%temp%\temp.txt

:_start
call w.bat FIX box 2,23 @calc.bat:_calc
if "%errorlevel%"=="0" goto _out
if errorlevel 100 goto _out
if "%wbat%"=="J" goto _js
if "%wbat%"=="R" goto _ce
if "%?%"=="1" goto _opinion
if "%?%"=="2" goto _help
if "%?%"=="3" if not "%smath%"=="" set smath=%smath%1
if "%?%"=="3" if "%smath%"=="" set smath=1
if "%?%"=="3" if not "%smath%"=="" set smath_display=%smath_display%1
if "%?%"=="3" if "%smath%"=="" set smath_display=1
if "%?%"=="4" if not "%smath%"=="" set smath=%smath%2
if "%?%"=="4" if "%smath%"=="" set smath=2
if "%?%"=="4" if not "%smath%"=="" set smath_display=%smath_display%2
if "%?%"=="4" if "%smath%"=="" set smath_display=2
if "%?%"=="5" if not "%smath%"=="" set smath=%smath%3
if "%?%"=="5" if "%smath%"=="" set smath=3
if "%?%"=="5" if not "%smath%"=="" set smath_display=%smath_display%3
if "%?%"=="5" if "%smath%"=="" set smath_display=3
if "%?%"=="6" if not "%smath%"=="" set smath=%smath%+
if "%?%"=="6" if "%smath%"=="" set smath=+
if "%?%"=="6" if not "%smath%"=="" set smath_display=%smath_display%+
if "%?%"=="6" if "%smath%"=="" set smath_display=+

if "%?%"=="8" if not "%smath%"=="" set smath=%smath%4
if "%?%"=="8" if "%smath%"=="" set smath=4
if "%?%"=="8" if not "%smath%"=="" set smath_display=%smath_display%4
if "%?%"=="8" if "%smath%"=="" set smath_display=4
if "%?%"=="9" if not "%smath%"=="" set smath=%smath%5
if "%?%"=="9" if "%smath%"=="" set smath=5
if "%?%"=="9" if not "%smath%"=="" set smath_display=%smath_display%5
if "%?%"=="9" if "%smath%"=="" set smath_display=5
if "%?%"=="10" if not "%smath%"=="" set smath=%smath%6
if "%?%"=="10" if "%smath%"=="" set smath=6
if "%?%"=="10" if not "%smath%"=="" set smath_display=%smath_display%6
if "%?%"=="10" if "%smath%"=="" set smath_display=6
if "%?%"=="11" if not "%smath%"=="" set smath=%smath%-
if "%?%"=="11" if "%smath%"=="" set smath=-
if "%?%"=="11" if not "%smath%"=="" set smath_display=%smath_display%-
if "%?%"=="11" if "%smath%"=="" set smath_display=-
if "%?%"=="12" if not "%smath%"=="" set smath=%smath%(
if "%?%"=="12" if "%smath%"=="" set smath=(
if "%?%"=="12" if not "%smath%"=="" set smath_display=%smath_display%(
if "%?%"=="12" if "%smath%"=="" set smath_display=(
if "%?%"=="13" if not "%smath%"=="" set smath=%smath%sqr(
if "%?%"=="13" if "%smath%"=="" set smath=sqr(
if "%?%"=="13" if not "%smath%"=="" set smath_display=%smath_display%√(
if "%?%"=="13" if "%smath%"=="" set smath_display=√(

if "%?%"=="14" if not "%smath%"=="" set smath=%smath%7
if "%?%"=="14" if "%smath%"=="" set smath=7
if "%?%"=="14" if not "%smath%"=="" set smath_display=%smath_display%7
if "%?%"=="14" if "%smath%"=="" set smath_display=7
if "%?%"=="15" if not "%smath%"=="" set smath=%smath%8
if "%?%"=="15" if "%smath%"=="" set smath=8
if "%?%"=="15" if not "%smath%"=="" set smath_display=%smath_display%8
if "%?%"=="15" if "%smath%"=="" set smath_display=8
if "%?%"=="16" if not "%smath%"=="" set smath=%smath%9
if "%?%"=="16" if "%smath%"=="" set smath=9
if "%?%"=="16" if not "%smath%"=="" set smath_display=%smath_display%9
if "%?%"=="16" if "%smath%"=="" set smath_display=9
if "%?%"=="17" if not "%smath%"=="" set smath=%smath%*
if "%?%"=="17" if "%smath%"=="" set smath=*
if "%?%"=="17" if not "%smath%"=="" set smath_display=%smath_display%X
if "%?%"=="17" if "%smath%"=="" set smath_display=X
if "%?%"=="18" if not "%smath%"=="" set smath=%smath%)
if "%?%"=="18" if "%smath%"=="" set smath=)
if "%?%"=="18" if not "%smath%"=="" set smath_display=%smath_display%)
if "%?%"=="18" if "%smath%"=="" set smath_display=)
if "%?%"=="19" if not "%smath%"=="" set smath=%smath%mem
if "%?%"=="19" if "%smath%"=="" set smath=mem
if "%?%"=="19" if not "%smath%"=="" set smath_display=%smath_display%ans
if "%?%"=="19" if "%smath%"=="" set smath_display=ans

if "%?%"=="20" if not "%smath%"=="" set smath=%smath%0
if "%?%"=="20" if "%smath%"=="" set smath=0
if "%?%"=="20" if not "%smath%"=="" set smath_display=%smath_display%0
if "%?%"=="20" if "%smath%"=="" set smath_display=0
if "%?%"=="21" if not "%smath%"=="" set smath=%smath%.
if "%?%"=="21" if not "%smath%"=="" set smath_display=%smath_display%.
if "%?%"=="22" if not "%smath%"=="" set smath=%smath%/
if "%?%"=="22" if "%smath%"=="" set smath=/
if "%?%"=="22" if not "%smath%"=="" set smath_display=%smath_display%/
if "%?%"=="22" if "%smath%"=="" set smath_display=/
goto _start

:_start-sci
call w.bat FIX box 2,80 @calc.bat:_calc-sci
if "%errorlevel%"=="0" goto _out
if errorlevel 100 goto _out
if "%wbat%"=="J" goto _js
if "%wbat%"=="R" goto _ce
if not "%smath_display%" == "" strings dfm=right %smath_display%, 2
if "%?%"=="1" goto _opinion
if "%?%"=="2" goto _help
if "%?%"=="3" goto n1
if "%?%"=="4" goto n2
if "%?%"=="5" goto n3
if "%?%"=="6" set minus=
if "%?%"=="6" if not "%smath%"=="" set smath=%smath%+
if "%?%"=="6" if "%smath%"=="" set smath=+
if "%?%"=="6" if not "%smath%"=="" set smath_display=%smath_display%+
if "%?%"=="6" if "%smath%"=="" set smath_display=+
if "%?%"=="7" if not "%smath%"=="" set smath=%smath%^
if "%?%"=="7" if "%smath%"=="" set smath=^
if "%?%"=="7" if not "%smath%"=="" set smath_display=%smath_display%^
if "%?%"=="7" if "%smath%"=="" set smath_display=^
if "%?%"=="8" if not "%smath%"=="" set smath=%smath%int(
if "%?%"=="8" if "%smath%"=="" set smath=int(
if "%?%"=="8" if not "%smath%"=="" set smath_display=%smath_display%int(
if "%?%"=="8" if "%smath%"=="" set smath_display=int(
if "%?%"=="9" if not "%smath%"=="" set smath=%smath%log(
if "%?%"=="9" if "%smath%"=="" set smath=log(
if "%?%"=="9" if not "%smath%"=="" set smath_display=%smath_display%lg(
if "%?%"=="9" if "%smath%"=="" set smath_display=lg(
if "%?%"=="10" if not "%smath%"=="" set smath=%smath%asin(
if "%?%"=="10" if "%smath%"=="" set smath=asin(
if "%?%"=="10" if not "%smath%"=="" set smath_display=%smath_display%asin(
if "%?%"=="10" if "%smath%"=="" set smath_display=asin(
if "%?%"=="11" if not "%smath%"=="" set smath=%smath%sqr(
if "%?%"=="11" if "%smath%"=="" set smath=sqr(
if "%?%"=="11" if not "%smath%"=="" set smath_display=%smath_display%√(
if "%?%"=="11" if "%smath%"=="" set smath_display=√(
if "%?%"=="12" goto log-create

if "%?%"=="13" goto n4
if "%?%"=="14" goto n5
if "%?%"=="15" goto n6
if "%?%"=="16" set minus=1
if "%?%"=="16" if not "%smath%"=="" set smath=%smath%-
if "%?%"=="16" if "%smath%"=="" set smath=-
if "%?%"=="16" if not "%smath%"=="" set smath_display=%smath_display%-
if "%?%"=="16" if "%smath%"=="" set smath_display=-
if "%?%"=="17" if not "%smath%"=="" set smath=%smath%(
if "%?%"=="17" if "%smath%"=="" set smath=(
if "%?%"=="17" if not "%smath%"=="" set smath_display=%smath_display%(
if "%?%"=="17" if "%smath%"=="" set smath_display=(
if "%?%"=="18" if not "%smath%"=="" set smath=%smath%sin(
if "%?%"=="18" if "%smath%"=="" set smath=sin(
if "%?%"=="18" if not "%smath%"=="" set smath_display=%smath_display%sin(
if "%?%"=="18" if "%smath%"=="" set smath_display=sin(
if "%?%"=="19" if not "%smath%"=="" set smath=%smath%ln(
if "%?%"=="19" if "%smath%"=="" set smath=ln(
if "%?%"=="19" if not "%smath%"=="" set smath_display=%smath_display%ln(
if "%?%"=="19" if "%smath%"=="" set smath_display=ln(
if "%?%"=="20" if not "%smath%"=="" set smath=%smath%acos(
if "%?%"=="20" if "%smath%"=="" set smath=acos(
if "%?%"=="20" if not "%smath%"=="" set smath_display=%smath_display%acos(
if "%?%"=="20" if "%smath%"=="" set smath_display=acos(
if "%?%"=="21" if not "%smath%"=="" set smath=%smath%abs(
if "%?%"=="21" if "%smath%"=="" set smath=abs(
if "%?%"=="21" if not "%smath%"=="" set smath_display=%smath_display%abs(
if "%?%"=="21" if "%smath%"=="" set smath_display=abs(

if "%?%"=="22" goto n7
if "%?%"=="23" goto n8
if "%?%"=="24" goto n9
if "%?%"=="25" if not "%smath%"=="" set smath=%smath%*
if "%?%"=="25" if "%smath%"=="" set smath=*
if "%?%"=="25" if not "%smath%"=="" set smath_display=%smath_display%X
if "%?%"=="25" if "%smath%"=="" set smath_display=X
if "%?%"=="26" if not "%smath%"=="" set smath=%smath%)
if "%?%"=="26" if "%smath%"=="" set smath=)
if "%?%"=="26" if not "%smath%"=="" set smath_display=%smath_display%)
if "%?%"=="26" if "%smath%"=="" set smath_display=)
if "%?%"=="27" if not "%smath%"=="" set smath=%smath%cos(
if "%?%"=="27" if "%smath%"=="" set smath=cos(
if "%?%"=="27" if not "%smath%"=="" set smath_display=%smath_display%cos(
if "%?%"=="27" if "%smath%"=="" set smath_display=cos(
if "%?%"=="28" goto baspi
if "%?%"=="29" if not "%smath%"=="" set smath=%smath%atan(
if "%?%"=="29" if "%smath%"=="" set smath=atan(
if "%?%"=="29" if not "%smath%"=="" set smath_display=%smath_display%atan(
if "%?%"=="29" if "%smath%"=="" set smath_display=atan(
if "%?%"=="30" if not "%smath%"=="" set smath=%smath%sign(
if "%?%"=="30" if "%smath%"=="" set smath=sign(
if "%?%"=="30" if not "%smath%"=="" set smath_display=%smath_display%sgn(
if "%?%"=="30" if "%smath%"=="" set smath_display=sgn(
if "%?%"=="31" set num=
if "%?%"=="32" set num=1

if "%?%"=="33" goto n0
if "%?%"=="34" if not "%smath%"=="" set smath=%smath%e
if "%?%"=="34" if "%smath%"=="" set smath=e
if "%?%"=="34" if not "%smath%"=="" set smath_display=%smath_display%e
if "%?%"=="34" if "%smath%"=="" set smath_display=e
if "%?%"=="35" goto baspoint
if "%?%"=="36" if not "%smath%"=="" set smath=%smath%/
if "%?%"=="36" if "%smath%"=="" set smath=/
if "%?%"=="36" if not "%smath%"=="" set smath_display=%smath_display%/
if "%?%"=="36" if "%smath%"=="" set smath_display=/
if "%?%"=="37" if not "%smath%"=="" set smath=%smath%tan(
if "%?%"=="37" if "%smath%"=="" set smath=tan(
if "%?%"=="37" if not "%smath%"=="" set smath_display=%smath_display%tan(
if "%?%"=="37" if "%smath%"=="" set smath_display=tan(
if "%?%"=="38" if not "%smath%"=="" set smath=%smath%rnd(
if "%?%"=="38" if "%smath%"=="" set smath=rnd(
if "%?%"=="38" if not "%smath%"=="" set smath_display=%smath_display%rnd(
if "%?%"=="38" if "%smath%"=="" set smath_display=rnd(
if "%?%"=="40" if not "%smath%"=="" set smath=%smath%mem
if "%?%"=="40" if "%smath%"=="" set smath=mem
if "%?%"=="40" if not "%smath%"=="" set smath_display=%smath_display%ans
if "%?%"=="40" if "%smath%"=="" set smath_display=ans

if "%?%"=="42" if not "%smath%"=="" set smath=%smath%*pi/180
if "%?%"=="42" if "%smath%"=="" set smath=pi/180
if "%?%"=="42" if not "%smath%"=="" set smath_display=%smath_display%°
if "%?%"=="42" if "%smath%"=="" set smath_display=°
if "%?%"=="43" if not "%smath%"=="" set smath=%smath%*pi/10800
if "%?%"=="43" if "%smath%"=="" set smath=pi/10800
if "%?%"=="43" if not "%smath%"=="" set smath_display=%smath_display%′
if "%?%"=="43" if "%smath%"=="" set smath_display=′
if "%?%"=="44" if not "%smath%"=="" set smath=%smath%*pi/648000
if "%?%"=="44" if "%smath%"=="" set smath=pi/648000
if "%?%"=="44" if not "%smath%"=="" set smath_display=%smath_display%″
if "%?%"=="44" if "%smath%"=="" set smath_display=″
if "%?%"=="45" goto dfmconfig
if "%?%"=="46" goto angle
goto _start-sci

:log-create
set num=
if not "%bas%"=="" if not "%smath%"=="" set smath=%smath%1/lg(%bas%)*lg(
if not "%bas%"=="" if "%smath%"=="" set smath=1/lg(%bas%)*lg(
if "%bas%"=="" if not "%smath%"=="" set smath=%smath%log(
if "%bas%"=="" if "%smath%"=="" set smath=log(
if not "%smath%"=="" set smath_display=%smath_display%log%bas%(
if "%smath%"=="" set smath_display=log%bas%(
goto _start-sci

rem -----数字判断-----
:n1
if "%num%"=="1" goto bas1
if not "%dfm%"=="°" if not "%dfm%"=="′" if not "%smath%"=="" set smath=%smath%1
if not "%dfm%"=="°" if not "%dfm%"=="′" if "%smath%"=="" set smath=1
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+1
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="" set smath=+1
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+1
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="" set smath=+1
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-1
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="1" set smath=-1
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-1
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="1" set smath=-1
if not "%smath%"=="" set smath_display=%smath_display%1
if "%smath%"=="" set smath_display=1
goto _start-sci

:n2
if "%num%"=="1" goto bas2
if not "%dfm%"=="°" if not "%dfm%"=="′" if not "%smath%"=="" set smath=%smath%2
if not "%dfm%"=="°" if not "%dfm%"=="′" if "%smath%"=="" set smath=2
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+2
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="" set smath=+2
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+2
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="" set smath=+2
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-2
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="1" set smath=-2
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-2
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="1" set smath=-2
if not "%smath%"=="" set smath_display=%smath_display%2
if "%smath%"=="" set smath_display=2
goto _start-sci

:n3
if "%num%"=="1" goto bas3
if not "%dfm%"=="°" if not "%dfm%"=="′" if not "%smath%"=="" set smath=%smath%3
if not "%dfm%"=="°" if not "%dfm%"=="′" if "%smath%"=="" set smath=3
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+3
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="" set smath=+3
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+3
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="" set smath=+3
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-3
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="1" set smath=-3
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-3
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="1" set smath=-3
if not "%smath%"=="" set smath_display=%smath_display%3
if "%smath%"=="" set smath_display=3
goto _start-sci

:n4
if "%num%"=="1" goto bas4
if not "%dfm%"=="°" if not "%dfm%"=="′" if not "%smath%"=="" set smath=%smath%4
if not "%dfm%"=="°" if not "%dfm%"=="′" if "%smath%"=="" set smath=4
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+4
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="" set smath=+4
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+4
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="" set smath=+4
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-4
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="1" set smath=-4
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-4
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="1" set smath=-4
if not "%smath%"=="" set smath_display=%smath_display%4
if "%smath%"=="" set smath_display=4
goto _start-sci

:n5
if "%num%"=="1" goto bas5
if not "%dfm%"=="°" if not "%dfm%"=="′" if not "%smath%"=="" set smath=%smath%5
if not "%dfm%"=="°" if not "%dfm%"=="′" if "%smath%"=="" set smath=5
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+5
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="" set smath=+5
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+5
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="" set smath=+5
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-5
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="1" set smath=-5
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-5
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="1" set smath=-5
if not "%smath%"=="" set smath_display=%smath_display%5
if "%smath%"=="" set smath_display=5
goto _start-sci

:n6
if "%num%"=="1" goto bas6
if not "%dfm%"=="°" if not "%dfm%"=="′" if not "%smath%"=="" set smath=%smath%6
if not "%dfm%"=="°" if not "%dfm%"=="′" if "%smath%"=="" set smath=6
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+6
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="" set smath=+6
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+6
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="" set smath=+6
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-6
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="1" set smath=-6
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-6
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="1" set smath=-6
if not "%smath%"=="" set smath_display=%smath_display%6
if "%smath%"=="" set smath_display=6
goto _start-sci

:n7
if "%num%"=="1" goto bas7
if not "%dfm%"=="°" if not "%dfm%"=="′" if not "%smath%"=="" set smath=%smath%7
if not "%dfm%"=="°" if not "%dfm%"=="′" if "%smath%"=="" set smath=7
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+7
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="" set smath=+7
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+7
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="" set smath=+7
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-7
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="1" set smath=-7
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-7
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="1" set smath=-7
if not "%smath%"=="" set smath_display=%smath_display%7
if "%smath%"=="" set smath_display=7
goto _start-sci

:n8
if "%num%"=="1" goto bas8
if not "%dfm%"=="°" if not "%dfm%"=="′" if not "%smath%"=="" set smath=%smath%8
if not "%dfm%"=="°" if not "%dfm%"=="′" if "%smath%"=="" set smath=8
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+8
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="" set smath=+8
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+8
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="" set smath=+8
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-8
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="1" set smath=-8
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-8
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="1" set smath=-8
if not "%smath%"=="" set smath_display=%smath_display%8
if "%smath%"=="" set smath_display=8
goto _start-sci

:n9
if "%num%"=="1" goto bas9
if not "%dfm%"=="°" if not "%dfm%"=="′" if not "%smath%"=="" set smath=%smath%9
if not "%dfm%"=="°" if not "%dfm%"=="′" if "%smath%"=="" set smath=9
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+9
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="" set smath=+9
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+9
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="" set smath=+9
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-9
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="1" set smath=-9
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-9
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="1" set smath=-9
if not "%smath%"=="" set smath_display=%smath_display%9
if "%smath%"=="" set smath_display=9
goto _start-sci

:n0
if "%num%"=="1" goto bas0
if not "%dfm%"=="°" if not "%dfm%"=="′" if not "%smath%"=="" set smath=%smath%0
if not "%dfm%"=="°" if not "%dfm%"=="′" if "%smath%"=="" set smath=0
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+0
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="" set smath=+0
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="" set smath=%smath%+0
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="" set smath=+0
if "%dfm%"=="°" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-0
if "%dfm%"=="°" if "%smath%"=="" if "%minus%"=="1" set smath=-0
if "%dfm%"=="′" if not "%smath%"=="" if "%minus%"=="1" set smath=%smath%-0
if "%dfm%"=="′" if "%smath%"=="" if "%minus%"=="1" set smath=-0
if not "%smath%"=="" set smath_display=%smath_display%0
if "%smath%"=="" set smath_display=0
goto _start-sci
rem ------------------

rem ------------对数之底-------------
:bas0
if not "%bas%"=="" set bas=%bas%0
if "%bas%"=="" set bas=0
goto _start-sci

:bas1
if not "%bas%"=="" set bas=%bas%1
if "%bas%"=="" set bas=1
goto _start-sci

:bas2
if not "%bas%"=="" set bas=%bas%2
if "%bas%"=="" set bas=2
goto _start-sci

:bas3
if not "%bas%"=="" set bas=%bas%3
if "%bas%"=="" set bas=3
goto _start-sci

:bas4
if not "%bas%"=="" set bas=%bas%4
if "%bas%"=="" set bas=4
goto _start-sci

:bas5
if not "%bas%"=="" set bas=%bas%5
if "%bas%"=="" set bas=5
goto _start-sci

:bas6
if not "%bas%"=="" set bas=%bas%6
if "%bas%"=="" set bas=6
goto _start-sci

:bas7
if not "%bas%"=="" set bas=%bas%7
if "%bas%"=="" set bas=7
goto _start-sci

:bas8
if not "%bas%"=="" set bas=%bas%8
if "%bas%"=="" set bas=8
goto _start-sci

:bas9
if not "%bas%"=="" set bas=%bas%9
if "%bas%"=="" set bas=9
goto _start-sci

:baspoint
if "%num%"=="" if not "%smath%"=="" set smath=%smath%.
if "%num%"=="" if not "%smath%"=="" set smath_display=%smath_display%.
if "%num%"=="1" if not "%bas%"=="" set bas=%bas%.
goto _start-sci

:baspi
if "%num%"=="" if not "%smath%"=="" set smath=%smath%pi
if "%num%"=="" if "%smath%"=="" set smath=pi
if "%num%"=="" if not "%smath%"=="" set smath_display=%smath_display%π
if "%num%"=="" if "%smath%"=="" set smath_display=π
if "%num%"=="1" if not "%bas%"=="" set bas=%bas%*pi
if "%num%"=="1" if "%bas%"=="" set bas=pi
goto _start-sci
rem ---------------------------------

:dfmconfig
if "%smath%"=="" goto _start-sci
strings cfg=findc %smath%,mem
if not "%cfg%"=="0" set num=2
if not "%cfg%"=="0" goto _js

:dfmconfigmain
if not "%cfg%"=="0" strings smath=read %temp%\temp.txt,1
calcmd %smath%>nul
calcmd 180*mem/pi+10^-18>%temp%\temp.txt
echo.>>%temp%\temp.txt
calcmd abs(mem-int(mem))*60>>%temp%\temp.txt
echo.>>%temp%\temp.txt
calcmd abs(mem-int(mem))*60>>%temp%\temp.txt
strings result=read %temp%\temp.txt,1
echo.>>%temp%\temp.txt
calcmd int(%result%)>>%temp%\temp.txt
strings result=read %temp%\temp.txt,2
echo.>>%temp%\temp.txt
calcmd int(%result%)>>%temp%\temp.txt
strings result=read %temp%\temp.txt,4
strings dfm=read %temp%\temp.txt,5
strings dfm=left %dfm%,2
set result=%result%°%dfm%
strings dfm=read %temp%\temp.txt,3
strings dfm=left %dfm%,8
if "%dfm%"=="60" set dfm=0
set result=%result%′%dfm%″
calcmd %smath%>nul
set dfm=
set num=
goto _start-sci

:_calc "计算器" [x]
[选项][关于]
------------------------
[$smath_display,100    ]
例如 2X5+√(7)-3/894.21
计算结果~%result%~
------------------------
[1] [2] [3] [+] [R 归零]

[4] [5] [6] [-] [(] [√]

[7] [8] [9] [X] [)] [M+]

[0] [．] [÷] [J 计算]
------------------------
::

:_calc-sci "计算器" [x]
[选项][关于]
------------------------------------------------------
[$smath_display,100                                  ]
例如 log5(2)+4X2^10-5/4+eXcos(π/6)
计算结果~%result%~
------------------------------------------------------
[1] [2] [3] [+] [^] [int] [lg] [arcsin] [√] [log (x)]
                                                 ↑
[4] [5] [6] [-] [(] [sin] [ln] [arccos] [||] [$bas,10] 

[7] [8] [9] [X] [)] [cos] [π] [arctan] [sgn] [↑][↓]

[0] [e] [．] [÷] [tan] [round] [R 归零] [M+] [J 计算]
------------------------------------------------------
[°] ['] ["] [°'"] [角度]
::

:_calc-opinion " "
[选项]
--------
[标准型]
[科学型]
:

:_ce
if "%num%"=="" set smath=
if "%num%"=="" set smath_display=
if "%num%"=="" set dfm=
if "%num%"=="" set result=
if "%num%"=="1" set bas=
set minus=
if "%opi%"=="" goto _start
if "%opi%"=="1" goto _start-sci

:_js
strings cfg=findc %smath%,mem
if "%smath%"=="" goto _start-sci
calcmd %smath%*(1+10^-15)>%temp%\temp.txt
strings result=read %temp%\temp.txt,1
if not "%digital%"=="" goto _jsw
set dfm=
if "%opi%"=="" goto _start
if "%opi%"=="1" goto _start-sci

:_jsw
echo.>>%temp%\temp.txt
calcmd rnd(abs(mem-int(mem))*10^%digital%)>>%temp%\temp.txt
echo.>>%temp%\temp.txt
calcmd int(abs(%result%))>>%temp%\temp.txt
strings dfm=left %result%,1 
strings result=read %temp%\temp.txt,3
strings result=left %result%,%digital%
if "%dfm%"=="-" set result=%dfm%%result%
strings dfm=read %temp%\temp.txt,2
strings dfm=left %dfm%,%digital%
set result=%result%.%dfm%
if not "%cfg%"=="0" calcmd %result%>nul
if "%cfg%"=="0" calcmd %smath%>nul
set cfg=
set dfm=
echo %result%>%temp%\temp.txt
if "%num%"=="2" goto dfmconfigmain
if "%num%"=="3" goto anglemain
if "%opi%"=="" goto _start
if "%opi%"=="1" goto _start-sci

:angle
if "%smath%"=="" goto _start-sci
strings cfg=findc %smath%,mem
if not "%cfg%"=="0" set num=3
if not "%cfg%"=="0" goto _js

:anglemain
if not "%cfg%"=="0" strings smath=read %temp%\temp.txt,1
calcmd %smath%>nul
calcmd mem*180/pi>%temp%\temp.txt
strings result=read %temp%\temp.txt,1
set result=%result%°
set dfm=
set num=
goto _start-sci

:_about "关于计算器" [x]
计算器 何世恒制作
[确定]
:

:_opinion
copy %FMDUDIR%\wscreen.0 %temp%\>nul
call w.bat FIX box 2,23 @calc.bat:_calc-opinion
if "%?%"=="2" set opi=
if "%?%"=="2" wbat restore
if "%?%"=="2" copy %FMDUDIR%\wscreen.0 %temp%\>nul
if "%?%"=="3" set opi=1
if "%?%"=="2" goto _start
if "%?%"=="3" goto _start-sci
if "%opi%"=="" goto _start
if "%opi%"=="1" goto _start-sci
goto _start

:_help
if exist wbat.com wbat box @calc.bat:_about
if "%errorlevel%"=="0" if exist %temp%\temp.txt if "%opi%"=="" goto _start
if "%errorlevel%"=="0" if exist %temp%\temp.txt if "%opi%"=="1" goto _start-sci
if "%errorlevel%"=="0" if not exist %temp%\temp.txt goto _out
if errorlevel 100 if exist %temp%\temp.txt if "%opi%"=="" goto _start
if errorlevel 100 if exist %temp%\temp.txt if "%opi%"=="1" goto _start-sci
if errorlevel 100 if not exist %temp%\temp.txt goto _out
if not exist wbat.com echo 计算器 何世恒制作
if exist %temp%\temp.txt if "%opi%"=="" goto _start
if exist %temp%\temp.txt if "%opi%"=="1" goto _start-sci
goto _out

:_out
set ?=
set result=
set smath=
set smath_display=
set dfm=
set num=
set bas=
set opi=
set minus=
for %%a in (result smath wbat wboxhi wboxtitle WSourceFile) do set %%a=
if exist %temp%\temp.txt del %temp%\temp.txt>NUL
wbat restore