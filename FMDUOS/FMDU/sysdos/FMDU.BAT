@echo off
cls
echo Starting FreemenduetOS...
if "%comspec%"=="%windir%\system32\cmd.exe" goto THerror
alias chcp=call CP.bat
alias graftabl=call CP.bat /G
alias lfndir=lfncmd /c dir
alias gbkcd=lfncmd /c cd
SET TEMP=C:
SET SYSDRV=C:
SET FMDUDIR=C:\FMDU\SYSDOS
SET PATH=%SYSDRV%\FMDU\NTFS;%SYSDRV%\FMDU\SYSX86;%FMDUDIR%
if exist wbat.ini ren wbat.ini gui.ini
if not exist w.bat goto blackscreen
if not exist wbat.com goto blackscreen
if not exist GBKDOS.exe goto bluescreen_missCN
alias type=call UTYPE.bat
if exist LFNON.ini DOSLFN -Z:CP936UNI.GBK >nul
echo 936>chcp.ini
GBKDOS.EXE /03>nul
if not exist strings.com goto bluescreen
if not exist fdapm.com goto bluescreen_missSR
if not exist restart.com goto bluescreen_missSR
ctmouse /N>nul
if exist %FMDUDIR%\metroio\onmetro.ini goto metroio
rem -------------非metro启动方式----------------------
ren startup.ini wbat.ini
:startup
call w.bat FIX box 1,1 @fmdu.bat:startup_d #1,3
if "%?%" == "1" goto zcqd
if "%?%" == "2" goto gjxx
if "%?%" == "0" goto shutdown_p
if errorlevel 100 goto shutdown_p
goto zcqd

:startup_d "FMDUOS启动菜单" [x]
[正常启动操作系统](利用该选项启动FMDUOS将正常加载所有驱动)                    
[高级选项](包括安全模式等)
离操作时间还剩#?秒









:

:zcqd
cls
echo 正在启动FMDUOS.
set fc=
rem -------------ntfs----
set hdpmi=16384
lh hdpmi32>nul
cls
echo 正在启动FMDUOS..
lh ndos -lfn -mountall -cp:936>nul
rem ---------------------
cls
echo 正在启动FMDUOS...
goto main

:gjxx
call w.bat FIX box 1,1 @fmdu.bat:gjxx_d #1,3
if "%?%" == "1" goto safemode
if "%?%" == "2" goto safemoden
if "%?%" == "3" goto safemodec
if "%?%" == "4" goto recordlog
if "%?%" == "0" goto startup
if errorlevel 100 goto startup
goto safemode

:gjxx_d "FMDUOS启动菜单高级选项" [x]
[安全模式](仅加载核心驱动程序)
[网络安全模式](加载核心驱动程序及基本网络服务)
[带终端的安全模式](加载核心驱动程序并启动终端)

[使用启动日志](导出所加载程序显示内容至jtstart.txt)                           
离操作时间还剩#?秒






:

rem -------------metro启动方式------------------------
:metroio
if exist metro.ini ren metro.ini wbat.ini
wbat fill (+white on green)
call w.bat box @fmdu.bat:metroio_d
if "%?%" == "1" goto zcqd
if "%?%" == "2" goto zcqd
if "%?%" == "4" goto zcqd
if "%?%" == "3" goto metrogjxx
if "%?%" == "5" goto otherosconfig
if "%?%" == "6" goto otherosconfig
if "%?%" == "7" goto otherosconfig
if "%?%" == "0" goto shutdown_p
if errorlevel 100 goto shutdown_p

:metroio_d "启动选项" [X]
[┌───┐               ]
[│ FMDU │FMDUOS2.0][*...]
[└───┘               ]
[┌───┐               ]
[│others│ 其他操作系统  ]
[└───┘               ]
:

:otherosconfig
if exist otheros.ini goto otheros
if not exist otheros.ini wbat box "操作系统列表暂无操作系统，请手动添加。" 返回
goto metroio

:otheros
call w.bat list @otheros.ini:oslabel
if "%?%" == "0" goto metroio
if errorlevel 100 goto metroio

:metrogjxx
call w.bat box @fmdu.bat:metrogjxx_d
if "%?%" == "1" goto safemode
if "%?%" == "4" goto safemode
if "%?%" == "7" goto safemode
if "%?%" == "2" goto safemoden
if "%?%" == "5" goto safemoden
if "%?%" == "8" goto safemoden
if "%?%" == "3" goto safemodec
if "%?%" == "6" goto safemodec
if "%?%" == "9" goto safemodec
if "%?%" == "10" goto recordlog
if "%?%" == "12" goto recordlog
if "%?%" == "14" goto recordlog
if "%?%" == "11" goto metrohelp
if "%?%" == "13" goto metrohelp
if "%?%" == "15" goto metrohelp
if "%?%" == "0" goto metroio
if errorlevel 100 goto metroio

:metrogjxx_d "高级选项" [X]
 [┌──┐] [ ┌─／ ] [┌──┐]
 [│SAFE│] [ │＠│ ] [│C:\>│]
 [└──┘] [ ／─┘ ] [└──┘]
  安全模式 网络安全模式   终端
 [┌─┐ *] [ ┌─┐ ]
 [│..│／] [   ┌┘ ]
 [└─┘" ] [   ·   ]
使用启动日志 启动帮助
:

:metrohelp
call w.bat box @fmdu.bat:metrohelp_d
if "%?%" == "1" goto metrogjxx
if "%?%" == "0" goto metrogjxx
if errorlevel 100 goto metrogjxx

:metrohelp_d "帮助" [X]
安全模式:(仅加载核心驱动程序)
网络安全模式:(加载核心驱动程序及基本网络服务)
终端:(加载核心驱动程序并启动终端)
使用启动日志:(导出所加载程序显示内容至jtstart.txt)
[返回启动项]
:
rem --------------------------------------------------

:safemode
echo safemode>safemode.txt
goto main

:safemoden
echo=>safemode.txt
goto main

:safemodec
echo=>safemode.txt
echo=>com.ini
if not exist %FMDUDIR%\metroio\onmetro.ini ren wbat.ini startup.ini
if exist %FMDUDIR%\metroio\onmetro.ini ren wbat.ini metro.ini
ren gui.ini wbat.ini
goto cmd_p

:recordlog
echo 正在导出启动记录...
cd %SYSDRV%\FMDU\ntfs
set hdpmi=16384
lh hdpmi32 >%FMDUDIR%\jtstart.txt
lh ndos -lfn -mountall -cp:936 >>%FMDUDIR%\jtstart.txt
cd %FMDUDIR%\
goto main

:main
cls
if not exist %FMDUDIR%\metroio\onmetro.ini ren wbat.ini startup.ini
if exist %FMDUDIR%\metroio\onmetro.ini ren wbat.ini metro.ini
ren gui.ini wbat.ini
strings $dtc=read %SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt,1
strings $wnc=read %SYSDRV%\FMDU\colors\wincolor\wincor.txt,1
strings $wtc=read %SYSDRV%\FMDU\colors\wincolor\txtcor.txt,1
if "%$dtc%"=="" set $dtc=+white
if "%$wnc%"=="" set $wnc=+white
if "%$wtc%"=="" set $wtc=black
wbat fill (%$wtc% on %$dtc%)
goto main_m

:main_m
%SYSDRV%
cd %FMDUDIR%
set fc=
if exist safemode.txt set fc=安全模式
if exist safemode.txt strings fk1=read safemode.txt,1
if "%fk1%"=="safemode" goto main_safemode
set fk1=
set WBoxFrame="         "
if exist temp.txt del temp.txt
call w.bat FIX box 1,40 (%$wtc% on %$dtc%) @fmdu.bat:desktop_m
wbat save
move %TEMP%\WSCREEN.0 %FMDUDIR%>nul
set WBoxFrame="|~|| ||_|"
if "%?%" == "1" goto startmenu
if "%?%" == "2" goto srf
if "%?%" == "3" goto admin
if "%?%" == "4" goto admin
if "%?%" == "5" goto findhd
if "%?%" == "6" goto findhd
if "%?%" == "7" goto network
if "%?%" == "8" goto network
if "%?%" == "9" goto recycle
if "%?%" == "10" goto recycle
if "%?%" == "11" goto tdzh
if "%?%" == "12" goto foldera
if "%?%" == "13" goto foldera
goto main_m

:desktop_m
[TH]                                                       [〓]%fc%
------------------------------------------------------------------------------
[┬┐]
[■┃]
admin
[┃■]
[┃┴]
电脑
[┌／]
[／┘]
网络
[││]
[└┘]
回收站
[3D]
3D圆锥
[┬┐]
[■┃]                                    
几何




:

:main_safemode
set WBoxFrame="         "
if exist temp.txt del temp.txt
call w.bat FIX box 1,40 (%$wtc% on %$dtc%) @fmdu.bat:desktop_safemode
wbat save
move %TEMP%\WSCREEN.0 %FMDUDIR%>nul
set WBoxFrame="|~|| ||_|"
if "%?%" == "1" goto startmenu
if "%?%" == "2" goto srf
if "%?%" == "3" goto admin
if "%?%" == "4" goto admin
if "%?%" == "5" goto findhd
if "%?%" == "6" goto findhd
if "%?%" == "7" goto recycle
if "%?%" == "8" goto recycle
if "%?%" == "9" goto foldera
if "%?%" == "10" goto foldera
goto main_safemode

:desktop_safemode
[TH]                                                       [〓]安全模式
------------------------------------------------------------------------------
[┬┐]
[■┃]
admin
[┃■]
[┃┴]
电脑
[││]
[└┘]
回收站
[┬┐]
[■┃]
几何









:

:srf
call w.bat box 1,60 (%$wtc% on %$wnc%) @fmdu.bat:srf_m
if "%?%" == "1" goto main_m
if "%?%" == "2" call w.bat box (%$wtc% on %$wnc%) @fmdu.bat:src_m
if "%?%" == "3" chcp 437
goto main_m

:srf_m
[〓][中文-中国]
[英语-美国]

:src_m
区位:Alt+F1 英文:Alt+F10 兼容内核拼音输入:Alt+F2
在GBK汉字显示驱动下,拼音:Alt+F4(每次只能输入一个GBK汉字)
拼音流输入法下,按<Ctrl+左Shift>进行输入法切换,在ASCII状态可输入英文
[确定]

:admin
set fc=0
set folder=TH用户
cd %SYSDRV%\users\jtadmin\
if not exist %FMDUDIR%\temp.txt echo=>%FMDUDIR%\temp.txt
goto admin_x

:admin_c
if exist cfg.tmp del cfg.tmp
call w.bat list 4,1 @%FMDUDIR%\temp.txt:r_all
if "%?%" == "1" goto admin_m
if errorlevel 254 goto main_m
set gfile=%wbat%
strings len=length %fk0%
if "%len%"=="3" strings fk0=left %fk0% , 2
strings len=fileext %gfile%
if "%len%"=="" goto admin_f
set WBoxFrame=
set fk1=
set hdpmi=
set $dtc=
set $wnc=
set $wtc=
set ?=
set wbat=
if exist wbat.ini ren wbat.ini gui.ini
if "%len%" == "TXT" goto notepad
if "%len%" == "INI" goto notepad
if not "%len%" == "BAT" GBKDOS.EXE /03>nul
if "%len%" == "JPG" goto picview
if "%len%" == "PNG" goto picview
if "%len%" == "BMP" goto picview
if "%len%" == "GIF" goto picview
if "%len%" == "PPT" goto pptconfig
if "%len%" == "DOC" goto docconfig
if "%len%" == "PDF" goto pdfconfig
if "%len%" == "EXE" call %fk0%\%gfile%
if "%len%" == "COM" call %fk0%\%gfile%
if not "%len%" == "BAT" GBKDOS.EXE /03>nul
if "%len%" == "BAT" call %fk0%\%gfile%
if exist gui.ini ren gui.ini wbat.ini
set WBoxFrame="|~|| ||_|"
set hdpmi=16384
set SYSDRV=C:
if "%$dtc%"=="" set $dtc=+white
if "%$wnc%"=="" set $wnc=+white
if "%$wtc%"=="" set $wtc=black
ctmouse>nul
wbat fill (%$wtc% on %$dtc%)
copy %FMDUDIR%\WSCREEN.0 %TEMP%\>nul
wbat restore
gbkcd "%fk0%"
goto admin_x

:admin_f
set folder=%wbat%
if exist %FMDUDIR%\temp.txt del %FMDUDIR%\temp.txt
GBKCD>cfg.tmp
strings cfg=read cfg.tmp,1
if "%cfg%" == "A:\" strings fc=sub %fc% , 1
if "%cfg%" == "B:\" strings fc=sub %fc% , 1
if "%cfg%" == "C:\" strings fc=sub %fc% , 1
if "%cfg%" == "D:\" strings fc=sub %fc% , 1
if "%cfg%" == "E:\" strings fc=sub %fc% , 1
if "%cfg%" == "F:\" strings fc=sub %fc% , 1
if "%cfg%" == "G:\" strings fc=sub %fc% , 1
if "%cfg%" == "H:\" strings fc=sub %fc% , 1
if "%cfg%" == "I:\" strings fc=sub %fc% , 1
if "%cfg%" == "J:\" strings fc=sub %fc% , 1
if "%cfg%" == "K:\" strings fc=sub %fc% , 1
if "%cfg%" == "L:\" strings fc=sub %fc% , 1
if "%cfg%" == "M:\" strings fc=sub %fc% , 1
if "%cfg%" == "N:\" strings fc=sub %fc% , 1
if "%cfg%" == "O:\" strings fc=sub %fc% , 1
if "%cfg%" == "P:\" strings fc=sub %fc% , 1
if "%cfg%" == "Q:\" strings fc=sub %fc% , 1
if "%cfg%" == "R:\" strings fc=sub %fc% , 1
if "%cfg%" == "S:\" strings fc=sub %fc% , 1
if "%cfg%" == "T:\" strings fc=sub %fc% , 1
if "%cfg%" == "U:\" strings fc=sub %fc% , 1
if "%cfg%" == "V:\" strings fc=sub %fc% , 1
if "%cfg%" == "W:\" strings fc=sub %fc% , 1
if "%cfg%" == "X:\" strings fc=sub %fc% , 1
if "%cfg%" == "Y:\" strings fc=sub %fc% , 1
if "%cfg%" == "Z:\" strings fc=sub %fc% , 1
if exist cfg.tmp del cfg.tmp
strings len=length %fk0%
if "%len%"=="3" strings fk0=left %fk0% , 2
gbkcd "%fk0%\%folder%"
goto admin_x

:admin_m
gbkcd "%fk0%"
GBKCD>cfg.tmp
strings cfg=read cfg.tmp,1
if exist cfg.tmp del cfg.tmp
if "%cfg%" == "A:\" goto findhd_CFG
if "%cfg%" == "B:\" goto findhd_CFG
if "%cfg%" == "C:\" goto findhd_CFG
if "%cfg%" == "D:\" goto findhd_CFG
if "%cfg%" == "E:\" goto findhd_CFG
if "%cfg%" == "F:\" goto findhd_CFG
if "%cfg%" == "G:\" goto findhd_CFG
if "%cfg%" == "H:\" goto findhd_CFG
if "%cfg%" == "I:\" goto findhd_CFG
if "%cfg%" == "J:\" goto findhd_CFG
if "%cfg%" == "K:\" goto findhd_CFG
if "%cfg%" == "L:\" goto findhd_CFG
if "%cfg%" == "M:\" goto findhd_CFG
if "%cfg%" == "N:\" goto findhd_CFG
if "%cfg%" == "O:\" goto findhd_CFG
if "%cfg%" == "P:\" goto findhd_CFG
if "%cfg%" == "Q:\" goto findhd_CFG
if "%cfg%" == "R:\" goto findhd_CFG
if "%cfg%" == "S:\" goto findhd_CFG
if "%cfg%" == "T:\" goto findhd_CFG
if "%cfg%" == "U:\" goto findhd_CFG
if "%cfg%" == "V:\" goto findhd_CFG
if "%cfg%" == "W:\" goto findhd_CFG
if "%cfg%" == "X:\" goto findhd_CFG
if "%cfg%" == "Y:\" goto findhd_CFG
if "%cfg%" == "Z:\" goto findhd_CFG
gbkcd ..
GBKCD>cfg.tmp
strings cfg=read cfg.tmp,1
if "%cfg%" == "A:\" goto findhd_CFG
if "%cfg%" == "B:\" goto findhd_CFG
if "%cfg%" == "C:\" goto findhd_CFG
if "%cfg%" == "D:\" goto findhd_CFG
if "%cfg%" == "E:\" goto findhd_CFG
if "%cfg%" == "F:\" goto findhd_CFG
if "%cfg%" == "G:\" goto findhd_CFG
if "%cfg%" == "H:\" goto findhd_CFG
if "%cfg%" == "I:\" goto findhd_CFG
if "%cfg%" == "J:\" goto findhd_CFG
if "%cfg%" == "K:\" goto findhd_CFG
if "%cfg%" == "L:\" goto findhd_CFG
if "%cfg%" == "M:\" goto findhd_CFG
if "%cfg%" == "N:\" goto findhd_CFG
if "%cfg%" == "O:\" goto findhd_CFG
if "%cfg%" == "P:\" goto findhd_CFG
if "%cfg%" == "Q:\" goto findhd_CFG
if "%cfg%" == "R:\" goto findhd_CFG
if "%cfg%" == "S:\" goto findhd_CFG
if "%cfg%" == "T:\" goto findhd_CFG
if "%cfg%" == "U:\" goto findhd_CFG
if "%cfg%" == "V:\" goto findhd_CFG
if "%cfg%" == "W:\" goto findhd_CFG
if "%cfg%" == "X:\" goto findhd_CFG
if "%cfg%" == "Y:\" goto findhd_CFG
if "%cfg%" == "Z:\" goto findhd_CFG
if exist %fk0%\cfg.tmp del %fk0%\cfg.tmp
strings len=length %cfg%
strings folder=add %len% , 1
goto loop

:loop
strings dircfg=mid %cfg% , %len% , 1
if "%dircfg%" == "\" goto fileadmin
strings len=sub %len% , 1
goto loop

:findhd_CFG
strings fc=add %fc% , 1
if "%fc%" == "2" goto findhd
strings folder=left %cfg% , 1
set folder=%folder%盘
goto admin_x

rem -----------根目录-----------
:findhd
echo :find      "计算机"     [x]>%FMDUDIR%\findhd.txt
echo [$address               ][→][$search                  ][搜]>>%FMDUDIR%\findhd.txt
strings err=filedrive %0
strings err=left %err% , 1
set err=[%err%]
set dve=
:A
if not exist dready.com goto finish
dready A: /w
if errorlevel 1 goto b
set dve=[A]
set err=
:B
if not exist dready.com goto finish
dready B: /w
if errorlevel 1 goto c
set dve=%dve% [B]
set err=
:C
if not exist dready.com goto finish
dready C: /w
if errorlevel 1 goto d
set dve=%dve% [C]
set err=
:d
if not exist dready.com goto finish
dready d: /w
if errorlevel 1 goto e
set dve=%dve% [D]
set err=
:e
if not exist dready.com goto finish
dready e: /w
if errorlevel 1 goto f
set dve=%dve% [E]
set err= 
:f
if not exist dready.com goto finish
dready f: /w
if errorlevel 1 goto g
set dve=%dve% [F]
set err=
:g
if not exist dready.com goto finish
dready g: /w
if errorlevel 1 goto h
set dve=%dve% [G]
set err=
:h
if not exist dready.com goto finish
dready h: /w
if errorlevel 1 goto i
set dve=%dve% [H]
set err=
:i
if not exist dready.com goto finish
dready i: /w
if errorlevel 1 goto J
set dve=%dve% [I]
set err=
:j
if not exist dready.com goto finish
dready j: /w
if errorlevel 1 goto K
set dve=%dve% [J]
set err=
:K
if not exist dready.com goto finish
dready k: /w
if errorlevel 1 goto L
set dve=%dve% [K]
set err=
:L
if not exist dready.com goto finish
dready l: /w
if errorlevel 1 goto M
set dve=%dve% [L]
set err=
:M
if not exist dready.com goto finish
dready m: /w
if errorlevel 1 goto N
set dve=%dve% [M]
set err=
:N
if not exist dready.com goto finish
dready N: /w
if errorlevel 1 goto O
set dve=%dve% [N]
set err=
:O
if not exist dready.com goto finish
dready O: /w
if errorlevel 1 goto P
set dve=%dve% [O]
set err=
:P
if not exist dready.com goto finish
dready P: /w
if errorlevel 1 goto Q
set dve=%dve% [P]
set err=
:Q
if not exist dready.com goto finish
dready Q: /w
if errorlevel 1 goto R
set dve=%dve% [Q]
set err=
:R
if not exist dready.com goto finish
dready R: /w
if errorlevel 1 goto S
set dve=%dve% [R]
set err=
:S
if not exist dready.com goto finish
dready S: /w
if errorlevel 1 goto T
set dve=%dve% [S]
set err=
:T
if not exist dready.com goto finish
dready T: /w
if errorlevel 1 goto U
set dve=%dve% [T]
set err=
:U
if not exist dready.com goto finish
dready U: /w
if errorlevel 1 goto V
set dve=%dve% [U]
set err=
:V
if not exist dready.com goto finish
dready V: /w
if errorlevel 1 goto W
set dve=%dve% [V]
set err=
:W
if not exist dready.com goto finish
dready W: /w
if errorlevel 1 goto X
set dve=%dve% [W]
set err=
:X
if not exist dready.com goto finish
dready X: /w
if errorlevel 1 goto Y
set dve=%dve% [X]
set err=
:Y
if not exist dready.com goto finish
dready Y: /w
if errorlevel 1 goto Z
set dve=%dve% [Y]
set err=
:Z
if not exist dready.com goto finish
dready Z: /w
if errorlevel 1 goto finish
set dve=%dve% [Z]
set err=
:finish
echo 磁盘：>>%FMDUDIR%\findhd.txt
echo %dve%%err%>>%FMDUDIR%\findhd.txt
call w.bat menu @%FMDUDIR%\findhd.txt:find
if exist %FMDUDIR%\findhd.txt del %FMDUDIR%\findhd.txt
CD %SYSDRV%\
if "%?%" == "100" goto main_m
if not "%?%"=="100" %wbat%:
set dve=
set err=
set folder=%wbat%盘
set fc=1
goto admin_x
rem -------------根目录结束--------------

:fileadmin
strings len=sub %folder% , %len%
strings folder=right %cfg% , %len%
set len=
set dircfg=
set cfg=
goto admin_x

:admin_x
if exist cfg.tmp del cfg.tmp
echo :r_all "%folder%" [x]>%FMDUDIR%\temp.txt
echo 返回上级目录>>%FMDUDIR%\temp.txt
LFNDIR /AD /B >>%FMDUDIR%\temp.txt
if exist *.* LFNDIR /A-D /B >>%FMDUDIR%\temp.txt
echo :>>%FMDUDIR%\temp.txt
GBKCD>%FMDUDIR%\path.txt
strings fk0=read %FMDUDIR%\path.txt,1
goto admin_c

:picview
call %FMDUDIR%\pictview.exe %fk0%\%gfile% --l
if exist gui.ini ren gui.ini wbat.ini
set WBoxFrame="|~|| ||_|"
set hdpmi=16384
if "%$dtc%"=="" set $dtc=+white
if "%$wnc%"=="" set $wnc=+white
if "%$wtc%"=="" set $wtc=black
copy %FMDUDIR%\WSCREEN.0 %TEMP%\ >nul
ctmouse >nul
GBKDOS.EXE /03>nul
wbat fill (%$wtc% on %$dtc%)
wbat restore
gbkcd "%fk0%"
goto admin_x

:pptconfig
ctmouse /u
if not exist %SYSDRV%\FMDUpro\office\pptview.exe goto pptchoice
ren %SYSDRV%\wine\wine.ini win.ini
ren %SYSDRV%\wine windows
%SYSDRV%\WINDOWS\SMARTDRV.EXE
SET PATH=%SYSDRV%\WINDOWS
SET TEMP=%SYSDRV%\WINDOWS\TEMP
wine.com %SYSDRV%\FMDUpro\office\pptview.exe %fk0%\%gfile%
ren %SYSDRV%\windows wine
ren %SYSDRV%\wine\win.ini wine.ini
SET PATH=%SYSDRV%\FMDU\NTFS;%SYSDRV%\FMDU\SYSX86;%FMDUDIR%
SET TEMP=C:
ctmouse>nul
GBKDOS.EXE /03>nul
goto main

:pptchoice
%SYSDRV%
CD %FMDUDIR%\
if exist gui.ini ren gui.ini wbat.ini
call w.bat box @fmdu.bat:pptchoice_m
if "%?%" == "0" goto main_m
if errorlevel 100 goto main_m
if "%?%" == "1" goto officesetup
goto main_m

:pptchoice_m [x]
你想用什么应用来打开PPT文件？
[文档插件]
[浏览...]
:

:docconfig
ctmouse /u
if not exist %SYSDRV%\FMDUpro\office\wordview.exe goto docchoice
ren %SYSDRV%\wine\wine.ini win.ini
ren %SYSDRV%\wine windows
%SYSDRV%\WINDOWS\SMARTDRV.EXE
SET PATH=%SYSDRV%\WINDOWS
SET TEMP=%SYSDRV%\WINDOWS\TEMP
wine.com %SYSDRV%\FMDUpro\office\wordview.exe %fk0%\%gfile%
ren %SYSDRV%\windows wine
ren %SYSDRV%\wine\win.ini wine.ini
SET PATH=%SYSDRV%\FMDU\NTFS;%SYSDRV%\FMDU\SYSX86;%FMDUDIR%
SET TEMP=C:
ctmouse>nul
GBKDOS.EXE /03>nul
goto main

:docchoice
%SYSDRV%
CD %FMDUDIR%\
if exist gui.ini ren gui.ini wbat.ini
call w.bat box @fmdu.bat:docchoice_m
if "%?%" == "0" goto main_m
if errorlevel 100 goto main_m
if "%?%" == "1" goto officesetup
goto main_m

:docchoice_m [x]
你想用什么应用来打开DOC文件？
[文档插件]
[浏览...]
:

:pdfconfig
ctmouse /u
if not exist %SYSDRV%\FMDUpro\office\acrord16.exe goto pdfchoice
ren %SYSDRV%\wine\wine.ini win.ini
ren %SYSDRV%\wine windows
%SYSDRV%\WINDOWS\SMARTDRV.EXE
SET PATH=%SYSDRV%\WINDOWS
SET TEMP=%SYSDRV%\WINDOWS\TEMP
wine.com %SYSDRV%\FMDUpro\office\acrord16.exe %fk0%\%gfile%
ren %SYSDRV%\windows wine
ren %SYSDRV%\wine\win.ini wine.ini
SET PATH=%SYSDRV%\FMDU\NTFS;%SYSDRV%\FMDU\SYSX86;%FMDUDIR%
SET TEMP=C:
ctmouse>nul
GBKDOS.EXE /03>nul
goto main

:pdfchoice
%SYSDRV%
CD %FMDUDIR%\
if exist gui.ini ren gui.ini wbat.ini
call w.bat box @fmdu.bat:pdfchoice_m
if "%?%" == "0" goto main_m
if errorlevel 100 goto main_m
if "%?%" == "1" goto officesetup
goto main_m

:pdfchoice_m [x]
你想用什么应用来打开PDF文件？
[文档插件]
[浏览...]
:

:officesetup
lh hdpmi32.exe >nul
cls
echo starting unpackage document plus(0/2)
%FMDUDIR%\unzip.exe %SYSDRV%\fmdu\package\gui.zip >nul
CD %SYSDRV%\FMDUpro
lh hdpmi32.exe >nul
cls
echo starting unpackage document plus(1/2)
%FMDUDIR%\unzip.exe %SYSDRV%\fmdu\package\office.zip >nul
cls
echo starting unpackage document plus(2/2)
strings $dtc=read %SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt,1
if "%$dtc%" == "black" ren %SYSDRV%\wine\black.bmp wallpr.bmp
if "%$dtc%" == "+black" ren %SYSDRV%\wine\degray.bmp wallpr.bmp
if "%$dtc%" == "blue" ren %SYSDRV%\wine\blue.bmp wallpr.bmp
if "%$dtc%" == "+blue" ren %SYSDRV%\wine\brblue.bmp wallpr.bmp
if "%$dtc%" == "green" ren %SYSDRV%\wine\green.bmp wallpr.bmp
if "%$dtc%" == "+green" ren %SYSDRV%\wine\brgreen.bmp wallpr.bmp
if "%$dtc%" == "cyan" ren %SYSDRV%\wine\decyan.bmp wallpr.bmp
if "%$dtc%" == "+cyan" ren %SYSDRV%\wine\cyan.bmp wallpr.bmp
if "%$dtc%" == "red" ren %SYSDRV%\wine\dered.bmp wallpr.bmp
if "%$dtc%" == "+red" ren %SYSDRV%\wine\red.bmp wallpr.bmp
if "%$dtc%" == "magenta" ren %SYSDRV%\wine\purple.bmp wallpr.bmp
if "%$dtc%" == "+magenta" ren %SYSDRV%\wine\pink.bmp wallpr.bmp
if "%$dtc%" == "brown" ren %SYSDRV%\wine\brown.bmp wallpr.bmp
if "%$dtc%" == "+brown" ren %SYSDRV%\wine\yellow.bmp wallpr.bmp
if "%$dtc%" == "white" ren %SYSDRV%\wine\brgray.bmp wallpr.bmp
if "%$dtc%" == "+white" ren %SYSDRV%\wine\white.bmp wallpr.bmp
GBKDOS.EXE /03>nul
goto main

:network
call w.bat box 1,1 (%$wtc% on %$wnc%) @fmdu.bat:network_m
if "%?%" == "1" goto network_x
goto main_m

:network_m "网络" [x]
[1.进入浏览器]

:network_x
GBKDOS.EXE /03>nul
call %SYSDRV%\FMDUpro\DILLO\dillo.bat
ctmouse>nul
GBKDOS.EXE /03>nul
goto main

:recycle
if not exist %FMDUDIR%\temp.txt echo=>%FMDUDIR%\temp.txt
echo :r_dir "回收站" [x]>%FMDUDIR%\temp.txt
LFNDIR %SYSDRV%\recycle\*.* /B>>%FMDUDIR%\temp.txt
call w.bat list 4,1 @%FMDUDIR%\temp.txt:r_dir
if errorlevel 254 goto main_m
set gfile=%wbat%
goto recycle_c

:recycle_c
call w.bat list (%$wtc% on %$wnc%) @fmdu.bat:recycle_m
if "%?%" == "1" del %SYSDRV%\recycle\%gfile%>nul
if "%?%" == "2" copy /y %SYSDRV%\recycle\%gfile% %SYSDRV%\users\jtadmin\desktop>nul
if not "%?%"=="" goto main_m
goto main_m

:recycle_m [x]
%gfile%
[1.删除]
[2.恢复]

:tdzh
rem ----------debug实现GUI效果----------
echo E100  B0 13 CD 10 68 00 A0 0F A1 E8 3C 00 BB 01 00 33>tdzh.tmp
echo E110  ED BE D7 02 8B 0E BF 02 E8 10 01 E2 FB FF 06 C1>>tdzh.tmp 
echo E120  02 FF 06 C3 02 01 1E C5 02 E5 40 3D A0 0F 72 04>>tdzh.tmp
echo E130  90 90 F7 DB BA DA 03 EC A8 08 75 F8 E4 60 FE C8>>tdzh.tmp
echo E140  75 CD B8 03 00 CD 10 C3 BF D7 02 BB 01 00 89 1E>>tdzh.tmp
echo E150  B7 02 C7 06 BF 02 00 00 B8 68 01 A3 C7 02 33 D2>>tdzh.tmp
echo E160  F7 F3 E8 60 00 E8 4E 00 FF 06 BF 02 29 06 C7 02>>tdzh.tmp
echo E170  79 F0 43 43 FF 06 B7 02 FF 06 B9 02 83 3E B7 02>>tdzh.tmp
echo E180  3C 90 72 D4 43 B8 68 01 A3 C7 02 33 D2 F7 F3 E8>>tdzh.tmp
echo E190  33 00 E8 21 00 FF 06 BF 02 29 06 C7 02 79 F0 4B>>tdzh.tmp
echo E1A0  4B FF 0E B7 02 FF 06 B9 02 83 3E B7 02 01 7F D5>>tdzh.tmp
echo E1B0  83 2E BF 02 04 C3 50 A1 C9 02 AB A1 CB 02 AB A1>>tdzh.tmp
echo E1C0  B9 02 AB 58 C3 D9 EB DE 36 B5 02 DE 0E C7 02 D9>>tdzh.tmp
echo E1D0  FB DE 0E B7 02 DF 1E C9 02 DE 0E B7 02 DF 1E CB>>tdzh.tmp
echo E1E0  02 C3 D9 EB DE 36 B5 02 DE 8D C1 02 D9 16 D3 02>>tdzh.tmp
echo E1F0  D9 FB D9 C9 DE 0E CD 02 DF 1E D1 02 DE 0E CB 02>>tdzh.tmp
echo E200  DE 26 D1 02 DF 1E CF 02 FF 36 CF 02 D9 06 D3 02>>tdzh.tmp
echo E210  D9 FB DE 0E CD 02 DF 1E D1 02 DE 0E CB 02 DE 06>>tdzh.tmp
echo E220  D1 02 DF 1E CD 02 8F 06 CB 02 C3 51 53 BF C9 02>>tdzh.tmp
echo E230  A5 A5 AD AB 05 3C 00 90 8A C8 BF 00 00 E8 A2 FF>>tdzh.tmp
echo E240  A1 CD 02 87 06 C9 02 87 06 CB 02 87 06 CD 02 BF>>tdzh.tmp
echo E250  02 00 E8 8D FF A1 CD 02 87 06 C9 02 87 06 CB 02>>tdzh.tmp
echo E260  87 06 CD 02 BF 04 00 E8 78 FF B0 00 8B 9E B4 BE>>tdzh.tmp
echo E270  64 88 07 83 3E CD 02 01 7C 38 90 90 8B 1E CB 02>>tdzh.tmp
echo E280  03 1E BD 02 78 2C 90 90 81 FB C8 00 7F 24 90 90>>tdzh.tmp
echo E290  69 DB 40 01 A1 C9 02 03 06 BB 02 78 15 90 90 3D>>tdzh.tmp
echo E2A0  3E 01 7F 0E 90 90 03 D8 89 9E B4 BE 83 C5 02 64>>tdzh.tmp
echo E2B0  88 0F 5B 59 C3 B4 00 01 00 C4 FF A0 00 64 00 F4>>tdzh.tmp
echo E2C0  FF                                                .>>tdzh.tmp
echo g 10>>tdzh.tmp
echo rcx>>tdzh.tmp
echo 001>>tdzh.tmp
echo n1.com>>tdzh.tmp
echo w>>tdzh.tmp
echo q>>tdzh.tmp
call debug<tdzh.tmp
del tdzh.tmp
rem -----end-----
goto main_m

:foldera
set fc=0
set folder=几何
cd %SYSDRV%\users\jtadmin\desktop\jh
goto admin_x

:startmenu
call w.bat box 1,1 (%$wtc% on %$wnc%) @fmdu.bat:startmenu_m
if "%?%" == "1" goto main_m
if "%?%" == "2" goto jsb
if "%?%" == "3" goto calc
if "%?%" == "4" goto calendar
if "%?%" == "5" goto cmd_p
if "%?%" == "6" goto controlpanel
if "%?%" == "7" goto shutdown
if "%?%" == "8" goto restart

:startmenu_m
[TH]
------------
[1记事本]
[2计算器]
[3日历]
[4终端]
[5设置]
[Φ][(*)]

:notepad
HXLDR32.EXE -q>nul
iconv -c -f UTF-8 -t gbk %fk0%\%gfile%>nul
if errorlevel 1 goto notepad_GBK
iconv -c -f UTF-8 -t gbk %fk0%\%gfile%>%fk0%\mtemp.tmp
HXLDR32.EXE -u>nul
wbat list %fk0%\mtemp.tmp
if errorlevel 100 goto notepad_EXIT
if not exist %SYSDRV%\FMDU\PYL\PYL.YAZ call %SYSDRV%\FMDU\PYL\PYL.EXE>nul
if not exist %SYSDRV%\FMDU\PYL\PYL.YAZ call %SYSDRV%\FMDU\GBKIN\GBKIN.EXE>nul
echo.>%SYSDRV%\FMDU\PYL\PYL.YAZ
cls
call edit.exe %fk0%\mtemp.tmp>nul
HXLDR32.EXE -q>nul
iconv -c -f gbk -t UTF-8 %fk0%\mtemp.tmp>%fk0%\%gfile%
HXLDR32.EXE -u>nul
goto notepad_EXIT

:notepad_GBK
HXLDR32.EXE -u>nul
wbat list %fk0%\%gfile%
if errorlevel 100 goto notepad_EXIT
if not exist %SYSDRV%\FMDU\PYL\PYL.YAZ call %SYSDRV%\FMDU\PYL\PYL.EXE>nul
if not exist %SYSDRV%\FMDU\PYL\PYL.YAZ call %SYSDRV%\FMDU\GBKIN\GBKIN.EXE>nul
echo.>%SYSDRV%\FMDU\PYL\PYL.YAZ
cls
call edit.exe %fk0%\%gfile%>nul
goto notepad_EXIT

:notepad_EXIT
if exist mtemp.tmp del mtemp.tmp
rem call %SYSDRV%\FMDU\GBKIN\GBKIN.EXE /u>nul
if exist gui.ini ren gui.ini wbat.ini
set WBoxFrame="|~|| ||_|"
set hdpmi=16384
if "%$dtc%"=="" set $dtc=+white
if "%$wnc%"=="" set $wnc=+white
if "%$wtc%"=="" set $wtc=black
wbat fill (%$wtc% on %$dtc%)
copy %FMDUDIR%\WSCREEN.0 %TEMP%\>nul
wbat restore
gbkcd "%fk0%"
goto admin_x


:jsb
if not exist %SYSDRV%\FMDU\PYL\PYL.YAZ call %SYSDRV%\FMDU\PYL\PYL.EXE>nul
if not exist %SYSDRV%\FMDU\PYL\PYL.YAZ call %SYSDRV%\FMDU\GBKIN\GBKIN.EXE>nul
echo.>%SYSDRV%\FMDU\PYL\PYL.YAZ
cls
call edit.exe>nul
rem %SYSDRV%\FMDU\GBKIN\GBKIN.EXE /u>nul
goto main_m

:calc
call calc.bat
goto main_m

:calendar
strings Y=date 1
strings M=parse %Y%,1,-
strings Y=parse %Y%,3,-
echo :calendar "日历" [x]>temp.txt
echo [$Y]年 [$M]月 [转到]>>temp.txt
command.com /c set /p fc=[←]            [→][退出]<nul>>temp.txt
cal>>temp.txt
call w.bat box @temp.txt:calendar
if exist temp.txt del temp.txt
if "%?%" == "2" goto calleft
if "%?%" == "3" goto calright
if "%?%" == "4" goto main_m
if "%?%" == "0" goto main_m
if errorlevel 100 goto main_m
goto calendar_main

:calendar_main
echo :calendar "日历" [x]>temp.txt
echo [$Y]年 [$M]月 [转到]>>temp.txt
command.com /c set /p fc=[←]            [→][退出]<nul>>temp.txt
cal %M%/%Y%>>temp.txt
call w.bat box @temp.txt:calendar
if exist temp.txt del temp.txt
if "%?%" == "2" goto calleft
if "%?%" == "3" goto calright
if "%?%" == "4" goto main_m
if "%?%" == "0" goto main_m
if errorlevel 100 goto main_m
goto :calendar_main

:calleft
strings M=sub %M%,1
if "%M%"=="0" strings Y=sub %Y%,1
if "%M%"=="0" set M=12
goto :calendar_main

:calright
strings M=add %M%,1
if "%M%"=="13" strings Y=add %Y%,1
if "%M%"=="13" set M=1
goto :calendar_main

:cmd_p
cls
echo -------->cmd.ini
set folder=
set fc=
set fk1=
set wrb=
set len=
set wbat=
set fk0=cmd
if exist com.ini echo 安全模式
goto cmd

:cmd
RANDOM.com 65535>%FMDUDIR%\random.txt
strings random=read %FMDUDIR%\random.txt,1
strings code=read chcp.ini,1
if "%code%"=="437" call w.bat box @fmdu.bat:cmd_en
if not "%code%"=="437" call w.bat box @fmdu.bat:cm_d
if "%?%" == "2" goto tablet
if "%?%" == "3" goto history
echo %folder%>>cmd.ini
if "%folder%" == "exit" goto exit1
strings code=findc %folder%,/?
if "%code%"=="0" call %folder%
if not "%code%"=="0" %folder%
if "%?%" == "1" goto cmd
if "%?%" == "100" goto cmd_io
if not "%?%" == "" goto cmd_io
goto cmd

:cmd_en "Terminal"[x]
-------------------------------------
%folder%
FMDUOS@FMDUOS#[$ folder,100          ]
[1 OK][2 Use Tablet PC Keyboard] [See historial commands]
:

:cm_d "终端"[x]
-------------------------------------
%folder%
FMDUOS@FMDUOS#[$ folder,100          ]
[1确定][2调用软键盘] [查看历史命令]
:

:history
wbat list cmd.ini
goto cmd

:cmd_io
strings $dtc=read %SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt,1
set fc=.
cls
set random=
set len=
chcp 936
if exist com.ini goto shutdown
if not exist com.ini goto main_m

:controlpanel
set yessymbol1=
set yessymbol2=
call w.bat box 1,1 (%$wtc% on %$wnc%) @fmdu.bat:controlpanel_m
if errorlevel 254 goto main_m
if "%?%" == "1" goto desc
if "%?%" == "2" goto winc
if "%?%" == "3" goto zswj
if "%?%" == "4" goto ioscreen
if "%?%" == "5" goto inputsetting
if "%?%" == "6" goto mainmenu
goto main_m

:controlpanel_m "设置" [x]
[1.桌面颜色][2.窗口/文本颜色][3.系统版本]
[4.启动界面选项][5.输入法设置][6.内核调试模式]

:desc
call w.bat box 1,1 (%$wtc% on %$wnc%) @fmdu.bat:desc_m
if errorlevel 254 goto main_m
if "%?%" == "1" goto dtc1
if "%?%" == "2" goto dtc2
if "%?%" == "3" goto dtc3
if "%?%" == "4" goto dtc4
if "%?%" == "5" goto dtc5
if "%?%" == "6" goto dtc6
if "%?%" == "7" goto dtc7
if "%?%" == "8" goto dtc8
if "%?%" == "9" goto dtc9
if "%?%" == "10" goto dtc10
if "%?%" == "11" goto dtc11
if "%?%" == "12" goto dtc12
if "%?%" == "13" goto dtc13
if "%?%" == "14" goto dtc14
if "%?%" == "15" goto dtc15
if "%?%" == "16" goto dtc16
goto main_m

:desc_m "桌面颜色选择" [x]
[1.黑色][2.深灰色]
[3.蓝色][4.亮蓝色]
[5.绿色][6.浅绿色]
[7.深青色][8.青色]
[9.深红色][a.红色]
[b.紫色][c.粉红色]
[d.棕色]  [e.黄色]
[f.亮灰色][g.白色]

:dtc1
rem /*---------desktop color setting panel----------
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "black" ren %SYSDRV%\wine\wallpr.bmp black.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+black" ren %SYSDRV%\wine\wallpr.bmp degray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "blue" ren %SYSDRV%\wine\wallpr.bmp blue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+blue" ren %SYSDRV%\wine\wallpr.bmp brblue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "green" ren %SYSDRV%\wine\wallpr.bmp green.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+green" ren %SYSDRV%\wine\wallpr.bmp brgreen.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "cyan" ren %SYSDRV%\wine\wallpr.bmp decyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+cyan" ren %SYSDRV%\wine\wallpr.bmp cyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "red" ren %SYSDRV%\wine\wallpr.bmp dered.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+red" ren %SYSDRV%\wine\wallpr.bmp red.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "magenta" ren %SYSDRV%\wine\wallpr.bmp purple.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+magenta" ren %SYSDRV%\wine\wallpr.bmp pink.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "brown" ren %SYSDRV%\wine\wallpr.bmp brown.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+brown" ren %SYSDRV%\wine\wallpr.bmp yellow.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "white" ren %SYSDRV%\wine\wallpr.bmp brgray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+white" ren %SYSDRV%\wine\wallpr.bmp white.bmp
echo black>%SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt
if exist %SYSDRV%\wine\black.bmp ren %SYSDRV%\wine\black.bmp wallpr.bmp
goto main

:dtc2
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "black" ren %SYSDRV%\wine\wallpr.bmp black.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+black" ren %SYSDRV%\wine\wallpr.bmp degray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "blue" ren %SYSDRV%\wine\wallpr.bmp blue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+blue" ren %SYSDRV%\wine\wallpr.bmp brblue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "green" ren %SYSDRV%\wine\wallpr.bmp green.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+green" ren %SYSDRV%\wine\wallpr.bmp brgreen.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "cyan" ren %SYSDRV%\wine\wallpr.bmp decyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+cyan" ren %SYSDRV%\wine\wallpr.bmp cyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "red" ren %SYSDRV%\wine\wallpr.bmp dered.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+red" ren %SYSDRV%\wine\wallpr.bmp red.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "magenta" ren %SYSDRV%\wine\wallpr.bmp purple.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+magenta" ren %SYSDRV%\wine\wallpr.bmp pink.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "brown" ren %SYSDRV%\wine\wallpr.bmp brown.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+brown" ren %SYSDRV%\wine\wallpr.bmp yellow.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "white" ren %SYSDRV%\wine\wallpr.bmp brgray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+white" ren %SYSDRV%\wine\wallpr.bmp white.bmp
echo +black>%SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt
if exist %SYSDRV%\wine\degray.bmp ren %SYSDRV%\wine\degray.bmp wallpr.bmp
goto main

:dtc3
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "black" ren %SYSDRV%\wine\wallpr.bmp black.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+black" ren %SYSDRV%\wine\wallpr.bmp degray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "blue" ren %SYSDRV%\wine\wallpr.bmp blue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+blue" ren %SYSDRV%\wine\wallpr.bmp brblue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "green" ren %SYSDRV%\wine\wallpr.bmp green.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+green" ren %SYSDRV%\wine\wallpr.bmp brgreen.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "cyan" ren %SYSDRV%\wine\wallpr.bmp decyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+cyan" ren %SYSDRV%\wine\wallpr.bmp cyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "red" ren %SYSDRV%\wine\wallpr.bmp dered.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+red" ren %SYSDRV%\wine\wallpr.bmp red.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "magenta" ren %SYSDRV%\wine\wallpr.bmp purple.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+magenta" ren %SYSDRV%\wine\wallpr.bmp pink.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "brown" ren %SYSDRV%\wine\wallpr.bmp brown.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+brown" ren %SYSDRV%\wine\wallpr.bmp yellow.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "white" ren %SYSDRV%\wine\wallpr.bmp brgray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+white" ren %SYSDRV%\wine\wallpr.bmp white.bmp
echo blue>%SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt
if exist %SYSDRV%\wine\blue.bmp ren %SYSDRV%\wine\blue.bmp wallpr.bmp
goto main

:dtc4
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "black" ren %SYSDRV%\wine\wallpr.bmp black.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+black" ren %SYSDRV%\wine\wallpr.bmp degray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "blue" ren %SYSDRV%\wine\wallpr.bmp blue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+blue" ren %SYSDRV%\wine\wallpr.bmp brblue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "green" ren %SYSDRV%\wine\wallpr.bmp green.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+green" ren %SYSDRV%\wine\wallpr.bmp brgreen.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "cyan" ren %SYSDRV%\wine\wallpr.bmp decyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+cyan" ren %SYSDRV%\wine\wallpr.bmp cyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "red" ren %SYSDRV%\wine\wallpr.bmp dered.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+red" ren %SYSDRV%\wine\wallpr.bmp red.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "magenta" ren %SYSDRV%\wine\wallpr.bmp purple.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+magenta" ren %SYSDRV%\wine\wallpr.bmp pink.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "brown" ren %SYSDRV%\wine\wallpr.bmp brown.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+brown" ren %SYSDRV%\wine\wallpr.bmp yellow.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "white" ren %SYSDRV%\wine\wallpr.bmp brgray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+white" ren %SYSDRV%\wine\wallpr.bmp white.bmp
echo +blue>%SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt
if exist %SYSDRV%\wine\brblue.bmp ren %SYSDRV%\wine\brblue.bmp wallpr.bmp
goto main

:dtc5
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "black" ren %SYSDRV%\wine\wallpr.bmp black.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+black" ren %SYSDRV%\wine\wallpr.bmp degray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "blue" ren %SYSDRV%\wine\wallpr.bmp blue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+blue" ren %SYSDRV%\wine\wallpr.bmp brblue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "green" ren %SYSDRV%\wine\wallpr.bmp green.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+green" ren %SYSDRV%\wine\wallpr.bmp brgreen.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "cyan" ren %SYSDRV%\wine\wallpr.bmp decyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+cyan" ren %SYSDRV%\wine\wallpr.bmp cyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "red" ren %SYSDRV%\wine\wallpr.bmp dered.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+red" ren %SYSDRV%\wine\wallpr.bmp red.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "magenta" ren %SYSDRV%\wine\wallpr.bmp purple.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+magenta" ren %SYSDRV%\wine\wallpr.bmp pink.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "brown" ren %SYSDRV%\wine\wallpr.bmp brown.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+brown" ren %SYSDRV%\wine\wallpr.bmp yellow.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "white" ren %SYSDRV%\wine\wallpr.bmp brgray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+white" ren %SYSDRV%\wine\wallpr.bmp white.bmp
echo green>%SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt
if exist %SYSDRV%\wine\green.bmp ren %SYSDRV%\wine\green.bmp wallpr.bmp
goto main

:dtc6
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "black" ren %SYSDRV%\wine\wallpr.bmp black.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+black" ren %SYSDRV%\wine\wallpr.bmp degray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "blue" ren %SYSDRV%\wine\wallpr.bmp blue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+blue" ren %SYSDRV%\wine\wallpr.bmp brblue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "green" ren %SYSDRV%\wine\wallpr.bmp green.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+green" ren %SYSDRV%\wine\wallpr.bmp brgreen.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "cyan" ren %SYSDRV%\wine\wallpr.bmp decyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+cyan" ren %SYSDRV%\wine\wallpr.bmp cyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "red" ren %SYSDRV%\wine\wallpr.bmp dered.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+red" ren %SYSDRV%\wine\wallpr.bmp red.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "magenta" ren %SYSDRV%\wine\wallpr.bmp purple.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+magenta" ren %SYSDRV%\wine\wallpr.bmp pink.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "brown" ren %SYSDRV%\wine\wallpr.bmp brown.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+brown" ren %SYSDRV%\wine\wallpr.bmp yellow.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "white" ren %SYSDRV%\wine\wallpr.bmp brgray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+white" ren %SYSDRV%\wine\wallpr.bmp white.bmp
echo +green>%SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt
if exist %SYSDRV%\wine\brgreen.bmp ren %SYSDRV%\wine\brgreen.bmp wallpr.bmp
goto main

:dtc7
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "black" ren %SYSDRV%\wine\wallpr.bmp black.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+black" ren %SYSDRV%\wine\wallpr.bmp degray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "blue" ren %SYSDRV%\wine\wallpr.bmp blue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+blue" ren %SYSDRV%\wine\wallpr.bmp brblue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "green" ren %SYSDRV%\wine\wallpr.bmp green.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+green" ren %SYSDRV%\wine\wallpr.bmp brgreen.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "cyan" ren %SYSDRV%\wine\wallpr.bmp decyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+cyan" ren %SYSDRV%\wine\wallpr.bmp cyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "red" ren %SYSDRV%\wine\wallpr.bmp dered.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+red" ren %SYSDRV%\wine\wallpr.bmp red.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "magenta" ren %SYSDRV%\wine\wallpr.bmp purple.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+magenta" ren %SYSDRV%\wine\wallpr.bmp pink.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "brown" ren %SYSDRV%\wine\wallpr.bmp brown.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+brown" ren %SYSDRV%\wine\wallpr.bmp yellow.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "white" ren %SYSDRV%\wine\wallpr.bmp brgray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+white" ren %SYSDRV%\wine\wallpr.bmp white.bmp
echo cyan>%SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt
if exist %SYSDRV%\wine\decyan.bmp ren %SYSDRV%\wine\decyan.bmp wallpr.bmp
goto main

:dtc8
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "black" ren %SYSDRV%\wine\wallpr.bmp black.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+black" ren %SYSDRV%\wine\wallpr.bmp degray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "blue" ren %SYSDRV%\wine\wallpr.bmp blue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+blue" ren %SYSDRV%\wine\wallpr.bmp brblue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "green" ren %SYSDRV%\wine\wallpr.bmp green.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+green" ren %SYSDRV%\wine\wallpr.bmp brgreen.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "cyan" ren %SYSDRV%\wine\wallpr.bmp decyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+cyan" ren %SYSDRV%\wine\wallpr.bmp cyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "red" ren %SYSDRV%\wine\wallpr.bmp dered.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+red" ren %SYSDRV%\wine\wallpr.bmp red.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "magenta" ren %SYSDRV%\wine\wallpr.bmp purple.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+magenta" ren %SYSDRV%\wine\wallpr.bmp pink.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "brown" ren %SYSDRV%\wine\wallpr.bmp brown.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+brown" ren %SYSDRV%\wine\wallpr.bmp yellow.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "white" ren %SYSDRV%\wine\wallpr.bmp brgray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+white" ren %SYSDRV%\wine\wallpr.bmp white.bmp
echo +cyan>%SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt
if exist %SYSDRV%\wine\cyan.bmp ren %SYSDRV%\wine\cyan.bmp wallpr.bmp
goto main

:dtc9
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "black" ren %SYSDRV%\wine\wallpr.bmp black.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+black" ren %SYSDRV%\wine\wallpr.bmp degray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "blue" ren %SYSDRV%\wine\wallpr.bmp blue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+blue" ren %SYSDRV%\wine\wallpr.bmp brblue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "green" ren %SYSDRV%\wine\wallpr.bmp green.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+green" ren %SYSDRV%\wine\wallpr.bmp brgreen.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "cyan" ren %SYSDRV%\wine\wallpr.bmp decyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+cyan" ren %SYSDRV%\wine\wallpr.bmp cyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "red" ren %SYSDRV%\wine\wallpr.bmp dered.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+red" ren %SYSDRV%\wine\wallpr.bmp red.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "magenta" ren %SYSDRV%\wine\wallpr.bmp purple.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+magenta" ren %SYSDRV%\wine\wallpr.bmp pink.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "brown" ren %SYSDRV%\wine\wallpr.bmp brown.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+brown" ren %SYSDRV%\wine\wallpr.bmp yellow.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "white" ren %SYSDRV%\wine\wallpr.bmp brgray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+white" ren %SYSDRV%\wine\wallpr.bmp white.bmp
echo red>%SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt
if exist %SYSDRV%\wine\dered.bmp ren %SYSDRV%\wine\dered.bmp wallpr.bmp
goto main

:dtc10
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "black" ren %SYSDRV%\wine\wallpr.bmp black.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+black" ren %SYSDRV%\wine\wallpr.bmp degray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "blue" ren %SYSDRV%\wine\wallpr.bmp blue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+blue" ren %SYSDRV%\wine\wallpr.bmp brblue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "green" ren %SYSDRV%\wine\wallpr.bmp green.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+green" ren %SYSDRV%\wine\wallpr.bmp brgreen.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "cyan" ren %SYSDRV%\wine\wallpr.bmp decyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+cyan" ren %SYSDRV%\wine\wallpr.bmp cyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "red" ren %SYSDRV%\wine\wallpr.bmp dered.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+red" ren %SYSDRV%\wine\wallpr.bmp red.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "magenta" ren %SYSDRV%\wine\wallpr.bmp purple.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+magenta" ren %SYSDRV%\wine\wallpr.bmp pink.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "brown" ren %SYSDRV%\wine\wallpr.bmp brown.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+brown" ren %SYSDRV%\wine\wallpr.bmp yellow.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "white" ren %SYSDRV%\wine\wallpr.bmp brgray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+white" ren %SYSDRV%\wine\wallpr.bmp white.bmp
echo +red>%SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt
if exist %SYSDRV%\wine\red.bmp ren %SYSDRV%\wine\red.bmp wallpr.bmp
goto main

:dtc11
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "black" ren %SYSDRV%\wine\wallpr.bmp black.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+black" ren %SYSDRV%\wine\wallpr.bmp degray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "blue" ren %SYSDRV%\wine\wallpr.bmp blue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+blue" ren %SYSDRV%\wine\wallpr.bmp brblue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "green" ren %SYSDRV%\wine\wallpr.bmp green.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+green" ren %SYSDRV%\wine\wallpr.bmp brgreen.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "cyan" ren %SYSDRV%\wine\wallpr.bmp decyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+cyan" ren %SYSDRV%\wine\wallpr.bmp cyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "red" ren %SYSDRV%\wine\wallpr.bmp dered.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+red" ren %SYSDRV%\wine\wallpr.bmp red.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "magenta" ren %SYSDRV%\wine\wallpr.bmp purple.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+magenta" ren %SYSDRV%\wine\wallpr.bmp pink.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "brown" ren %SYSDRV%\wine\wallpr.bmp brown.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+brown" ren %SYSDRV%\wine\wallpr.bmp yellow.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "white" ren %SYSDRV%\wine\wallpr.bmp brgray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+white" ren %SYSDRV%\wine\wallpr.bmp white.bmp
echo magenta>%SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt
if exist %SYSDRV%\wine\purple.bmp ren %SYSDRV%\wine\purple.bmp wallpr.bmp
goto main

:dtc12
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "black" ren %SYSDRV%\wine\wallpr.bmp black.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+black" ren %SYSDRV%\wine\wallpr.bmp degray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "blue" ren %SYSDRV%\wine\wallpr.bmp blue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+blue" ren %SYSDRV%\wine\wallpr.bmp brblue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "green" ren %SYSDRV%\wine\wallpr.bmp green.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+green" ren %SYSDRV%\wine\wallpr.bmp brgreen.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "cyan" ren %SYSDRV%\wine\wallpr.bmp decyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+cyan" ren %SYSDRV%\wine\wallpr.bmp cyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "red" ren %SYSDRV%\wine\wallpr.bmp dered.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+red" ren %SYSDRV%\wine\wallpr.bmp red.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "magenta" ren %SYSDRV%\wine\wallpr.bmp purple.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+magenta" ren %SYSDRV%\wine\wallpr.bmp pink.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "brown" ren %SYSDRV%\wine\wallpr.bmp brown.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+brown" ren %SYSDRV%\wine\wallpr.bmp yellow.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "white" ren %SYSDRV%\wine\wallpr.bmp brgray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+white" ren %SYSDRV%\wine\wallpr.bmp white.bmp
echo +magenta>%SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt
if exist %SYSDRV%\wine\pink.bmp ren %SYSDRV%\wine\pink.bmp wallpr.bmp
goto main

:dtc13
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "black" ren %SYSDRV%\wine\wallpr.bmp black.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+black" ren %SYSDRV%\wine\wallpr.bmp degray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "blue" ren %SYSDRV%\wine\wallpr.bmp blue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+blue" ren %SYSDRV%\wine\wallpr.bmp brblue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "green" ren %SYSDRV%\wine\wallpr.bmp green.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+green" ren %SYSDRV%\wine\wallpr.bmp brgreen.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "cyan" ren %SYSDRV%\wine\wallpr.bmp decyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+cyan" ren %SYSDRV%\wine\wallpr.bmp cyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "red" ren %SYSDRV%\wine\wallpr.bmp dered.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+red" ren %SYSDRV%\wine\wallpr.bmp red.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "magenta" ren %SYSDRV%\wine\wallpr.bmp purple.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+magenta" ren %SYSDRV%\wine\wallpr.bmp pink.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "brown" ren %SYSDRV%\wine\wallpr.bmp brown.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+brown" ren %SYSDRV%\wine\wallpr.bmp yellow.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "white" ren %SYSDRV%\wine\wallpr.bmp brgray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+white" ren %SYSDRV%\wine\wallpr.bmp white.bmp
echo brown>%SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt
if exist %SYSDRV%\wine\brown.bmp ren %SYSDRV%\wine\brown.bmp wallpr.bmp
goto main

:dtc14
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "black" ren %SYSDRV%\wine\wallpr.bmp black.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+black" ren %SYSDRV%\wine\wallpr.bmp degray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "blue" ren %SYSDRV%\wine\wallpr.bmp blue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+blue" ren %SYSDRV%\wine\wallpr.bmp brblue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "green" ren %SYSDRV%\wine\wallpr.bmp green.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+green" ren %SYSDRV%\wine\wallpr.bmp brgreen.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "cyan" ren %SYSDRV%\wine\wallpr.bmp decyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+cyan" ren %SYSDRV%\wine\wallpr.bmp cyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "red" ren %SYSDRV%\wine\wallpr.bmp dered.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+red" ren %SYSDRV%\wine\wallpr.bmp red.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "magenta" ren %SYSDRV%\wine\wallpr.bmp purple.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+magenta" ren %SYSDRV%\wine\wallpr.bmp pink.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "brown" ren %SYSDRV%\wine\wallpr.bmp brown.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+brown" ren %SYSDRV%\wine\wallpr.bmp yellow.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "white" ren %SYSDRV%\wine\wallpr.bmp brgray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+white" ren %SYSDRV%\wine\wallpr.bmp white.bmp
echo +brown>%SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt
if exist %SYSDRV%\wine\yellow.bmp ren %SYSDRV%\wine\yellow.bmp wallpr.bmp
goto main

:dtc15
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "black" ren %SYSDRV%\wine\wallpr.bmp black.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+black" ren %SYSDRV%\wine\wallpr.bmp degray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "blue" ren %SYSDRV%\wine\wallpr.bmp blue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+blue" ren %SYSDRV%\wine\wallpr.bmp brblue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "green" ren %SYSDRV%\wine\wallpr.bmp green.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+green" ren %SYSDRV%\wine\wallpr.bmp brgreen.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "cyan" ren %SYSDRV%\wine\wallpr.bmp decyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+cyan" ren %SYSDRV%\wine\wallpr.bmp cyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "red" ren %SYSDRV%\wine\wallpr.bmp dered.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+red" ren %SYSDRV%\wine\wallpr.bmp red.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "magenta" ren %SYSDRV%\wine\wallpr.bmp purple.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+magenta" ren %SYSDRV%\wine\wallpr.bmp pink.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "brown" ren %SYSDRV%\wine\wallpr.bmp brown.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+brown" ren %SYSDRV%\wine\wallpr.bmp yellow.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "white" ren %SYSDRV%\wine\wallpr.bmp brgray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+white" ren %SYSDRV%\wine\wallpr.bmp white.bmp
echo white>%SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt
if exist %SYSDRV%\wine\brgray.bmp ren %SYSDRV%\wine\brgray.bmp wallpr.bmp
goto main

:dtc16
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "black" ren %SYSDRV%\wine\wallpr.bmp black.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+black" ren %SYSDRV%\wine\wallpr.bmp degray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "blue" ren %SYSDRV%\wine\wallpr.bmp blue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+blue" ren %SYSDRV%\wine\wallpr.bmp brblue.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "green" ren %SYSDRV%\wine\wallpr.bmp green.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+green" ren %SYSDRV%\wine\wallpr.bmp brgreen.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "cyan" ren %SYSDRV%\wine\wallpr.bmp decyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+cyan" ren %SYSDRV%\wine\wallpr.bmp cyan.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "red" ren %SYSDRV%\wine\wallpr.bmp dered.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+red" ren %SYSDRV%\wine\wallpr.bmp red.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "magenta" ren %SYSDRV%\wine\wallpr.bmp purple.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+magenta" ren %SYSDRV%\wine\wallpr.bmp pink.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "brown" ren %SYSDRV%\wine\wallpr.bmp brown.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+brown" ren %SYSDRV%\wine\wallpr.bmp yellow.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "white" ren %SYSDRV%\wine\wallpr.bmp brgray.bmp
if exist %SYSDRV%\wine\wallpr.bmp if "%$dtc%" == "+white" ren %SYSDRV%\wine\wallpr.bmp white.bmp
echo +white>%SYSDRV%\FMDU\colors\dtcolor\dtcolor.txt
if exist %SYSDRV%\wine\white.bmp ren %SYSDRV%\wine\white.bmp wallpr.bmp
goto main
rem ---------------------------------------------*/

rem set fk0=

:winc
call w.bat box 1,1 (%$wtc% on %$wnc%) @fmdu.bat:winc_m
if errorlevel 254 goto main_m
if "%wrb%" == "1" set fn1=wincor
if "%wrb%" == "2" set fn1=txtcor
if "%?%" == "1" goto wnc1
if "%?%" == "2" goto wnc2
if "%?%" == "3" goto wnc3
if "%?%" == "4" goto wnc4
if "%?%" == "5" goto wnc5
if "%?%" == "6" goto wnc6
if "%?%" == "7" goto wnc7
if "%?%" == "8" goto wnc8
if "%?%" == "9" goto wnc9
if "%?%" == "10" goto wnc10
if "%?%" == "11" goto wnc11
if "%?%" == "12" goto wnc12
if "%?%" == "13" goto wnc13
if "%?%" == "14" goto wnc14
if "%?%" == "15" goto wnc15
if "%?%" == "16" goto wnc16
goto main_m

:winc_m "窗口/文本颜色选择" [x]
[.]窗口颜色[.]文本颜色
[1.黑色][2.深灰色]
[3.蓝色][4.亮蓝色]
[5.绿色][6.浅绿色]
[7.深青色][8.青色]
[9.深红色][a.红色]
[b.紫色][c.粉红色]
[d.棕色]  [e.黄色]
[f.亮灰色][g.白色]

:wnc1
rem /*---------window color setting panel----------
echo black>%SYSDRV%\FMDU\colors\wincolor\%fn1%.txt
goto main

:wnc2
echo +black>%SYSDRV%\FMDU\colors\wincolor\%fn1%.txt
goto main

:wnc3
echo blue>%SYSDRV%\FMDU\colors\wincolor\%fn1%.txt
goto main

:wnc4
echo +blue>%SYSDRV%\FMDU\colors\wincolor\%fn1%.txt
goto main

:wnc5
echo green>%SYSDRV%\FMDU\colors\wincolor\%fn1%.txt
goto main

:wnc6
echo +green>%SYSDRV%\FMDU\colors\wincolor\%fn1%.txt
goto main

:wnc7
echo cyan>%SYSDRV%\FMDU\colors\wincolor\%fn1%.txt
goto main

:wnc8
echo +cyan>%SYSDRV%\FMDU\colors\wincolor\%fn1%.txt
goto main

:wnc9
echo red>%SYSDRV%\FMDU\colors\wincolor\%fn1%.txt
goto main

:wnc10
echo +red>%SYSDRV%\FMDU\colors\wincolor\%fn1%.txt
goto main

:wnc11
echo magenta>%SYSDRV%\FMDU\colors\wincolor\%fn1%.txt
goto main

:wnc12
echo +magenta>%SYSDRV%\JFMDU\colors\wincolor\%fn1%.txt
goto main

:wnc13
echo brown>%SYSDRV%\FMDU\colors\wincolor\%fn1%.txt
goto main

:wnc14
echo +brown>%SYSDRV%\FMDU\colors\wincolor\%fn1%.txt
goto main

:wnc15
echo white>%SYSDRV%\FMDU\colors\wincolor\%fn1%.txt
goto main

:wnc16
echo +white>%SYSDRV%\FMDU\colors\wincolor\%fn1%.txt
goto main
rem ---------------------------------------------*/

:zswj
call jtsm.bat
goto main

:ioscreen
if exist %FMDUDIR%\metroio\onmetro.ini set yessymbol1=*
if not exist %FMDUDIR%\metroio\onmetro.ini set yessymbol2=*
call w.bat box @fmdu.bat:ioscreen_d
if %?% == 1 goto traditional
if %?% == 2 del %FMDUDIR%\metroio\onmetro.ini
if "%?%" == "0" goto controlpanel
if "%?%" == "100" goto controlpanel
if errorlevel 100 goto controlpanel
set yessymbol1=
set yessymbol2=
goto ioscreen

:traditional
echo metro>%FMDUDIR%\metroio\onmetro.ini
if "%?%" == "100" goto controlpanel
if "%?%" == "0" goto controlpanel
if errorlevel 100 goto controlpanel
set yessymbol1=
set yessymbol2=
goto ioscreen

:ioscreen_d "开机界面选项" [X]
[metro开机界面]%yessymbol1%
[传统开机界面]%yessymbol2%
:

:inputsetting
call w.bat box @fmdu.bat:inputsetting_d
if "%?%" == "1" goto defineword
if "%?%" == "2" goto automemword
if "%?%" == "0" goto controlpanel
if "%?%" == "100" goto controlpanel
if errorlevel 100 goto controlpanel
goto inputsetting

:inputsetting_d "输入法设置" [X]
[1.编辑用户定义词库]
[2.编辑自动记忆词库]
:

:defineword
cd %SYSDRV%\FMDU\PYL
call DEFI.EXE
cd %SYSDRV%\
cls
copy %FMDUDIR%\WSCREEN.0 %TEMP%\>nul
wbat restore
goto inputsetting

:automemword
cd %SYSDRV%\FMDU\PYL
call MEMO.EXE
cd %SYSDRV%\
cls
copy %FMDUDIR%\WSCREEN.0 %TEMP%\>nul
wbat restore
goto inputsetting

rem ----------结束控制面板----------

rem ------------内核板块------------
:kernel_m
-=-=-=-=FMDUOS微内核=-=-
┌─────────────────┐
│内核版本:2.0                      │
│build TH v2.0                     │
│语言:batch                        │
│内核位数:16/32                    │
│命令执行速度:~1000command/s        │
│支持硬件:普通型大内存,硬盘设备    │
│制作人 何世恒                     │
│copyright(c) by TH public account │
└─────────────────┘
[确定]
:

:mainmenu
wbat box @FMDU.bat:mainmenu_m
if "%?%"=="1" goto kerinf
if "%?%"=="2" goto factorymode
if "%?%"=="3" goto information
if "%?%" == "0" goto controlpanel
if "%?%"=="100" goto controlpanel
goto exitkernel

:kerinf
wbat box @FMDU.bat:kernel_m
goto mainmenu
          
:information
wbat box "THJT corporation all rights reserved" 确定
goto mainmenu

:mainmenu_m "内核调试主菜单"[x]
[1.内核信息》]  
[2.工厂模式》]  
[3.企业信息》]

:factorymode
call w.bat box @FMDU.bat:factorymode_m
if "%?%"=="1" goto sndtest
if "%?%"=="2" goto rgbtest
if "%?%"=="3" goto toutest
if "%?%"=="4" goto imgtest
if "%?%"=="5" goto costest
if "%?%"=="6" goto tottest
if "%?%" == "0" goto mainmenu
if "%?%"=="100" goto mainmenu

:factorymode_m "工厂模式"[x]
[1.音响测试》]  
[2.RGB栅条测试》]  
[3.触摸屏测试》]
[4.图像测试》]  
[5.代码速度测试》]  
[6+.综合测试》]

:sndtest
beep
call w.bat box @FMDU.bat:sndtest_m
if "%?%"=="1" goto soundhelp
if "%?%"=="2" goto sndtest
if "%?%" == "0" goto factorymode
if "%?%"=="100" goto factorymode
goto factorymode

:sndtest_m "音响测试" [x]
音响测试，若听到蜂鸣声,音响正常，反之，音响异常
[音响异常][重新测试]
:

:soundhelp
call w.bat box @FMDU.bat:soundhelp_m
if "%?%" == "0" goto factorymode
if "%?%"=="100" goto factorymode
goto factorymode

:soundhelp_m "声音异常疑难解答" [x]
若音响异常，请检查：
1.扬声器插头是否松动
2.声卡驱动是否安装或加载错误
[确定]
:

:rgbtest
wbat cls (black on +white)
wbat text "RGBtest"
wbat fill 2,1 (1,58) "+"
wbat fill 3,1 (16,1) "+"
wbat fill 3,58 (16,1) "+"
wbat fill 19,1 (1,58) "+"
wbat fill 3,2 (4,56) (white on black)
wbat fill 7,2 (4,8) (black on red)
wbat fill 7,10 (4,8) (black on Brown)
wbat fill 7,18 (4,8) (black on green)
wbat fill 7,26 (4,8) (black on cyan)
wbat fill 7,34 (4,8) (black on blue)
wbat fill 7,42 (4,8) (black on magenta)
wbat fill 7,50 (4,8) (black on +black)
wbat fill 11,2 (4,8) (black on +red)
wbat fill 11,10 (4,8) (black on +Brown)
wbat fill 11,18 (4,8) (black on +green)
wbat fill 11,26 (4,8) (black on +cyan)
wbat fill 11,34 (4,8) (black on +blue)
wbat fill 11,42 (4,8) (black on +magenta)
wbat fill 11,50 (4,8) (black on White)
wbat fill 15,2 (4,56) (black on +White)
wbat box 18,60 "颜色是否正常" 正常,异常
wbat cls (%$wtc% on %$dtc%)
copy %FMDUDIR%\WSCREEN.0 %TEMP%\>nul
wbat restore
goto factorymode

:toutest
wbat FIX box @FMDU.bat:toutest_m1
wbat FIX box @FMDU.bat:toutest_m2
wbat FIX box @FMDU.bat:toutest_m3
wbat FIX box @FMDU.bat:toutest_m4
wbat FIX box @FMDU.bat:toutest_m5
wbat FIX box @FMDU.bat:toutest_m6
wbat FIX box @FMDU.bat:toutest_m7
wbat FIX box @FMDU.bat:toutest_m8
wbat cls (%$wtc% on %$dtc%)
copy %FMDUDIR%\WSCREEN.0 %TEMP%\>nul
wbat restore
goto factorymode

:toutest_m1
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:

:toutest_m2
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:

:toutest_m3
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:

:toutest_m4
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:

:toutest_m5
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:

:toutest_m6
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:

:toutest_m7
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
:

:toutest_m8
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
[][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][][]
:

:imgtest
goto factorymode

:costest
goto factorymode

:tottest
call w.bat box @fmdu.bat:test_GBK
if "%?%"=="1" goto factorymode
if "%?%"=="2" goto factorymode
if "%?%" == "0" goto factorymode
if errorlevel 100 goto factorymode
goto factorymode

:test_GBK "GBK汉字显示能力测试" [X]
金木水火土又屮月牛石吉喜十气√
鍂林沝炎圭双艸朋牪砳喆囍卄氕乄
鑫森淼焱垚叒芔　犇磊嚞　卅氘×
　　　燚　叕茻朤　　　　卌氚○
勠力同心 嗞嗞响 古譞 瞭望 啰嗦
嘚瑟 牛丼 叆叇 西塱 椪糖 刌民 囧 峧 卝 衎 嬲 嫐
[全部汉字显示正常] [出现乱码]
:
rem --------------------------------
:tablet
chcp 936
set folder=
goto cfsf

:backspace
strings len=length %folder%
strings len=sub %len%,1
strings folder=left %folder% , %len%
strings inputconfig=read %FMDUDIR%\inputcfg.tmp,1
if "%inputconfig%"=="cfsf" goto cfsf
if "%inputconfig%"=="cosf" goto cosf
if "%inputconfig%"=="cfso" goto cfso
if "%inputconfig%"=="coso" goto coso

:cfsf
set inputconfig=
echo cfsf>%FMDUDIR%\inputcfg.tmp
strings len=length %folder%
strings cur=left ............................... , %len%
set cur=%cur%^
call w.bat box @fmdu.bat:cfsf_d
if "%?%" == "0" goto exit
if "%?%"=="100" goto exit
if "%?%"=="43" goto enter_config
rem ---------esc与退格-----------
if "%?%"=="1" goto cmd_io
if "%?%"=="15" goto backspace
rem ---------字母及数字-----------
if "%?%"=="17" set folder=%folder%q
if "%?%"=="18" set folder=%folder%w
if "%?%"=="19" set folder=%folder%e
if "%?%"=="20" set folder=%folder%r
if "%?%"=="21" set folder=%folder%t
if "%?%"=="22" set folder=%folder%y
if "%?%"=="23" set folder=%folder%u
if "%?%"=="24" set folder=%folder%i
if "%?%"=="25" set folder=%folder%o
if "%?%"=="26" set folder=%folder%p
if "%?%"=="32" set folder=%folder%a
if "%?%"=="33" set folder=%folder%s
if "%?%"=="34" set folder=%folder%d
if "%?%"=="35" set folder=%folder%f
if "%?%"=="36" set folder=%folder%g
if "%?%"=="37" set folder=%folder%h
if "%?%"=="38" set folder=%folder%j
if "%?%"=="39" set folder=%folder%k
if "%?%"=="40" set folder=%folder%l
if "%?%"=="45" set folder=%folder%z
if "%?%"=="46" set folder=%folder%x
if "%?%"=="47" set folder=%folder%c
if "%?%"=="48" set folder=%folder%v
if "%?%"=="49" set folder=%folder%b
if "%?%"=="50" set folder=%folder%n
if "%?%"=="51" set folder=%folder%m
if "%?%"=="60" set folder=%folder% 
if "%?%"=="2" set folder=%folder%`
if "%?%"=="3" set folder=%folder%1
if "%?%"=="4" set folder=%folder%2
if "%?%"=="5" set folder=%folder%3
if "%?%"=="6" set folder=%folder%4
if "%?%"=="7" set folder=%folder%5
if "%?%"=="8" set folder=%folder%6
if "%?%"=="9" set folder=%folder%7
if "%?%"=="10" set folder=%folder%8
if "%?%"=="11" set folder=%folder%9
if "%?%"=="12" set folder=%folder%0
rem --------------符号------------
if "%?%"=="13" set folder=%folder%-
if "%?%"=="14" set folder=%folder%=
if "%?%"=="27" set folder=%folder%[
if "%?%"=="28" set folder=%folder%]
if "%?%"=="29" set folder=%folder%\
if "%?%"=="41" set folder=%folder%;
if "%?%"=="42" set folder=%folder%'
if "%?%"=="52" set folder=%folder%,
if "%?%"=="53" set folder=%folder%.
if "%?%"=="54" set folder=%folder%/
rem ---------ctrl and shift-------
if "%?%"=="56" goto cfso
if "%?%"=="44" goto cfso
if "%?%"=="31" goto cosf
goto cfsf

:cosf
set inputconfig=
echo cosf>%FMDUDIR%\inputcfg.tmp
strings len=length %folder%
strings cur=left ............................... , %len%
set cur=%cur%^
call w.bat box @fmdu.bat:cosf_d
if "%?%" == "0" goto exit
if "%?%"=="100" goto exit
if "%?%"=="43" goto enter_config
rem ---------esc与退格-----------
if "%?%"=="1" goto cmd_io
if "%?%"=="15" goto backspace
rem ---------字母及数字-----------
if "%?%"=="17" set folder=%folder%Q
if "%?%"=="18" set folder=%folder%W
if "%?%"=="19" set folder=%folder%E
if "%?%"=="20" set folder=%folder%R
if "%?%"=="21" set folder=%folder%T
if "%?%"=="22" set folder=%folder%Y
if "%?%"=="23" set folder=%folder%U
if "%?%"=="24" set folder=%folder%I
if "%?%"=="25" set folder=%folder%O
if "%?%"=="26" set folder=%folder%P
if "%?%"=="32" set folder=%folder%A
if "%?%"=="33" set folder=%folder%S
if "%?%"=="34" set folder=%folder%D
if "%?%"=="35" set folder=%folder%F
if "%?%"=="36" set folder=%folder%G
if "%?%"=="37" set folder=%folder%H
if "%?%"=="38" set folder=%folder%J
if "%?%"=="39" set folder=%folder%K
if "%?%"=="40" set folder=%folder%L
if "%?%"=="45" set folder=%folder%Z
if "%?%"=="46" set folder=%folder%X
if "%?%"=="47" set folder=%folder%C
if "%?%"=="48" set folder=%folder%V
if "%?%"=="49" set folder=%folder%B
if "%?%"=="50" set folder=%folder%N
if "%?%"=="51" set folder=%folder%M
if "%?%"=="60" set folder=%folder% 
if "%?%"=="2" set folder=%folder%`
if "%?%"=="3" set folder=%folder%1
if "%?%"=="4" set folder=%folder%2
if "%?%"=="5" set folder=%folder%3
if "%?%"=="6" set folder=%folder%4
if "%?%"=="7" set folder=%folder%5
if "%?%"=="8" set folder=%folder%6
if "%?%"=="9" set folder=%folder%7
if "%?%"=="10" set folder=%folder%8
if "%?%"=="11" set folder=%folder%9
if "%?%"=="12" set folder=%folder%0
rem --------------符号------------
if "%?%"=="13" set folder=%folder%-
if "%?%"=="14" set folder=%folder%=
if "%?%"=="27" set folder=%folder%[
if "%?%"=="28" set folder=%folder%]
if "%?%"=="29" set folder=%folder%\
if "%?%"=="41" set folder=%folder%;
if "%?%"=="42" set folder=%folder%'
if "%?%"=="52" set folder=%folder%,
if "%?%"=="53" set folder=%folder%.
if "%?%"=="54" set folder=%folder%/
rem ---------ctrl and shift-------
if "%?%"=="56" goto coso
if "%?%"=="44" goto coso
if "%?%"=="31" goto cfsf
goto cosf

:cfso
set inputconfig=
echo cfso>%FMDUDIR%\inputcfg.tmp
strings len=length %folder%
strings cur=left ............................... , %len%
set cur=%cur%^
call w.bat box @fmdu.bat:cfso_d
if "%?%" == "0" goto exit
if "%?%"=="100" goto exit
if "%?%"=="43" goto enter_config
rem ---------esc与退格-----------
if "%?%"=="1" goto cmd_io
if "%?%"=="15" goto backspace
rem ---------字母及数字-----------
if "%?%"=="17" set folder=%folder%q
if "%?%"=="18" set folder=%folder%w
if "%?%"=="19" set folder=%folder%e
if "%?%"=="20" set folder=%folder%r
if "%?%"=="21" set folder=%folder%t
if "%?%"=="22" set folder=%folder%y
if "%?%"=="23" set folder=%folder%u
if "%?%"=="24" set folder=%folder%i
if "%?%"=="25" set folder=%folder%o
if "%?%"=="26" set folder=%folder%p
if "%?%"=="32" set folder=%folder%a
if "%?%"=="33" set folder=%folder%s
if "%?%"=="34" set folder=%folder%d
if "%?%"=="35" set folder=%folder%f
if "%?%"=="36" set folder=%folder%g
if "%?%"=="37" set folder=%folder%h
if "%?%"=="38" set folder=%folder%j
if "%?%"=="39" set folder=%folder%k
if "%?%"=="40" set folder=%folder%l
if "%?%"=="45" set folder=%folder%z
if "%?%"=="46" set folder=%folder%x
if "%?%"=="47" set folder=%folder%c
if "%?%"=="48" set folder=%folder%v
if "%?%"=="49" set folder=%folder%b
if "%?%"=="50" set folder=%folder%n
if "%?%"=="51" set folder=%folder%m
if "%?%"=="60" set folder=%folder% 
if "%?%"=="2" set folder=%folder%~
if "%?%"=="3" set folder=%folder%!
if "%?%"=="4" set folder=%folder%@
if "%?%"=="5" set folder=%folder%#
if "%?%"=="6" set folder=%folder%$
if "%?%"=="7" set folder=%folder%%
if "%?%"=="8" set folder=%folder%^
if "%?%"=="9" set folder=%folder%&
if "%?%"=="10" set folder=%folder%*
if "%?%"=="11" set folder=%folder%(
if "%?%"=="12" set folder=%folder%)
rem --------------符号------------
if "%?%"=="13" set folder=%folder%_
if "%?%"=="14" set folder=%folder%+
if "%?%"=="27" set folder=%folder%{
if "%?%"=="28" set folder=%folder%}
if "%?%"=="29" set folder=%folder%│
if "%?%"=="41" set folder=%folder%:
if "%?%"=="42" set folder=%folder%"
if "%?%"=="52" set folder=%folder%〈
if "%?%"=="53" set folder=%folder%〉
if "%?%"=="54" set folder=%folder%?
rem ---------ctrl and shift-------
if "%?%"=="56" goto cfsf
if "%?%"=="44" goto cfsf
if "%?%"=="31" goto coso
goto cfsf

:coso
set inputconfig=
echo coso>%FMDUDIR%\inputcfg.tmp
strings len=length %folder%
strings cur=left ............................... , %len%
set cur=%cur%^
call w.bat box @fmdu.bat:coso_d
if "%?%" == "0" goto exit
if "%?%"=="100" goto exit
if "%?%"=="43" goto enter_config
rem ---------esc与退格-----------
if "%?%"=="1" goto cmd_io
if "%?%"=="15" goto backspace
rem ---------字母及数字-----------
if "%?%"=="17" set folder=%folder%Q
if "%?%"=="18" set folder=%folder%W
if "%?%"=="19" set folder=%folder%E
if "%?%"=="20" set folder=%folder%R
if "%?%"=="21" set folder=%folder%T
if "%?%"=="22" set folder=%folder%Y
if "%?%"=="23" set folder=%folder%U
if "%?%"=="24" set folder=%folder%I
if "%?%"=="25" set folder=%folder%O
if "%?%"=="26" set folder=%folder%P
if "%?%"=="32" set folder=%folder%A
if "%?%"=="33" set folder=%folder%S
if "%?%"=="34" set folder=%folder%D
if "%?%"=="35" set folder=%folder%F
if "%?%"=="36" set folder=%folder%G
if "%?%"=="37" set folder=%folder%H
if "%?%"=="38" set folder=%folder%J
if "%?%"=="39" set folder=%folder%K
if "%?%"=="40" set folder=%folder%L
if "%?%"=="45" set folder=%folder%Z
if "%?%"=="46" set folder=%folder%X
if "%?%"=="47" set folder=%folder%C
if "%?%"=="48" set folder=%folder%V
if "%?%"=="49" set folder=%folder%B
if "%?%"=="50" set folder=%folder%N
if "%?%"=="51" set folder=%folder%M
if "%?%"=="60" set folder=%folder% 
if "%?%"=="2" set folder=%folder%~
if "%?%"=="3" set folder=%folder%!
if "%?%"=="4" set folder=%folder%@
if "%?%"=="5" set folder=%folder%#
if "%?%"=="6" set folder=%folder%$
if "%?%"=="7" set folder=%folder%%
if "%?%"=="8" set folder=%folder%^
if "%?%"=="9" set folder=%folder%&
if "%?%"=="10" set folder=%folder%*
if "%?%"=="11" set folder=%folder%(
if "%?%"=="12" set folder=%folder%)
rem --------------符号------------
if "%?%"=="13" set folder=%folder%_
if "%?%"=="14" set folder=%folder%+
if "%?%"=="27" set folder=%folder%{
if "%?%"=="28" set folder=%folder%}
if "%?%"=="29" set folder=%folder%│
if "%?%"=="41" set folder=%folder%:
if "%?%"=="42" set folder=%folder%"
if "%?%"=="52" set folder=%folder%〈
if "%?%"=="53" set folder=%folder%〉
if "%?%"=="54" set folder=%folder%?
rem ---------ctrl and shift-------
if "%?%"=="56" goto cosf
if "%?%"=="44" goto cosf
if "%?%"=="31" goto cfso
goto cosf

:cfsf_d "软键盘" [x]
[.]英文[.]中文{%folder%}
              %cur%
[Esc][`][１][2][3][４][5][6][７][8][9][0][-][=][Bksp]
[Tab][q][w][e][r][t][y][u][i][o][p][［][］][＼][ Del]
[CapsLk ][a][s][d][f][g][h][j][k][l][;]['][  Enter┘]
[Shift ][z][x][c][v][b][n][m][,][·][/][↑][  Shift ]
[Ctrl][TH][Alt][     ][Alt][〓][Ctrl][←][↓][→][Fn]
:
:cosf_d "软键盘" [x]
[.]英文[.]中文{%folder%}
              %cur%
[Esc][`][１][2][3][４][5][6][７][8][9][0][-][=][Bksp]
[Tab][Q][W][E][R][T][Y][U][I][O][P][［][］][＼][ Del]
[CapsLk*][A][S][D][F][G][H][J][K][L][;]['][  Enter┘]
[Shift ][Z][X][C][V][B][N][M][,][·][/][↑][  Shift ]
[Ctrl][TH][Alt][     ][Alt][〓][Ctrl][←][↓][→][Fn]
:
:cfso_d "软键盘" [x]
[.]英文[.]中文{%folder%}
              %cur%
[Esc][~][！][@][#][＄][%][^][＆][*][(][)][_][+][Bksp]
[Tab][q][w][e][r][t][y][u][i][o][p][｛][｝][│][ Del]
[CapsLk ][a][s][d][f][g][h][j][k][l][:]["][  Enter┘]
[Shift*][z][x][c][v][b][n][m][<][>][？][↑][  Shift*]
[Ctrl][TH][Alt][     ][Alt][〓][Ctrl][←][↓][→][Fn]
:
:coso_d "软键盘" [x]
[.]英文[.]中文{%folder%}
              %cur%
[Esc][~][！][@][#][＄][%][^][＆][*][(][)][_][+][Bksp]
[Tab][Q][W][E][R][T][Y][U][I][O][P][｛][｝][│][ Del]
[CapsLk*][A][S][D][F][G][H][J][K][L][:]["][  Enter┘]
[Shift*][Z][X][C][V][B][N][M][<][>][？][↑][  Shift*]
[Ctrl][TH][Alt][     ][Alt][〓][Ctrl][←][↓][→][Fn]
:

:exit
set folder=
set inputconfig=
set len=
goto cmd

:enter_config
if "%fk0%"=="cmd" goto cmd
goto cmd

rem ----------蓝屏代码----------
:bluescreen
set whotkey=none
set wbar=+white on blue
set wdivider=+white
set wbutton=+white on blue
wbat cls (+white on blue)
wbat fix box 1,1 (+white on blue) @bluescr.txt:bluescreen_cn
wbat cls (+white on blue)
wbat text (+white on blue) @bluescr.txt:bluescreen_en
pause>nul
goto bluescreen

:bluescreen_missCN
wbat cls (+white on blue)
wbat text (+white on blue) @bluescr.txt:bluescreen_missCN
pause>nul
goto bluescreen_missCN

:bluescreen_missSR
if not exist fdapm.com set SRfile=fdapm.com
if not exist restart.com set SRfile=restart.com
set whotkey=none
set wbar=+white on blue
set wdivider=+white
set wbutton=+white on blue
wbat cls (+white on blue)
if not exist fdapm.com set SRtext=关机
if not exist restart.com set SRtext=重启
wbat fix box 1,1 (+white on blue) @bluescr.txt:bluescreen_missSR_cn
wbat cls (+white on blue)
if not exist fdapm.com set SRtext=shutdown
if not exist restart.com set SRtext=restart
wbat text (+white on blue) @bluescr.txt:bluescreen_missSR_en
pause>nul
goto bluescreen_missSR
rem ----------蓝屏代码结束----------

:blackscreen
cls
if not exist w.bat set GUI=w.bat
if not exist wbat.com set GUI=wbat.com
echo FMDUOS GUI core is missing! In order to prevent your computer damage, FMDUOS has been shut down.
echo.
echo Restart your computer when this is the first time you've seen this stop error screen,follow these steps when this screen appears again:
echo.
echo Check the averable space to be sure you have adequate disk space, and copy
echo %GUI% to <Drive>:\FMDU\SYSDOS and restart the computer.
echo Techical information:missing %GUI%
pause>nul
goto blackscreen

:shutdown_p
if exist %FMDUDIR%\metroio\onmetro.ini ren wbat.ini metro.ini
if not exist %FMDUDIR%\metroio\onmetro.ini ren wbat.ini startup.ini
goto shutdown

:shutdown
cls
echo 正在关机...
if exist %SYSDRV%\FMDU\PYL\PYL.YAZ del %SYSDRV%\FMDU\PYL\PYL.YAZ
if exist %FMDUDIR%\WSCREEN.0 del %FMDUDIR%\WSCREEN.0>nul
if exist safemode.txt del safemode.txt >nul
if exist cmd.ini del cmd.ini >nul
if exist com.ini del com.ini >nul
if exist 1.com del 1.com >nul
if exist wbat.ini ren wbat.ini gui.ini
%SYSDRV%\FMDU\sysdos\fdapm pureoff>nul

:restart
cls
chcp 437
if exist %SYSDRV%\FMDU\PYL\PYL.YAZ del %SYSDRV%\FMDU\PYL\PYL.YAZ
if exist %FMDUDIR%\WSCREEN.0 del %FMDUDIR%\WSCREEN.0>nul
if exist safemode.txt del safemode.txt >nul
if exist cmd.ini del cmd.ini >nul
if exist com.ini del com.ini >nul
if exist 1.com del 1.com >nul
if exist wbat.ini ren wbat.ini gui.ini
%SYSDRV%\FMDU\sysdos\restart.com

:exit1
cls
if exist %SYSDRV%\FMDU\PYL\PYL.YAZ del %SYSDRV%\FMDU\PYL\PYL.YAZ
chcp 437
echo start to go to the real cmd
prompt FMDU@FMDU-PC:$P$$>nul
if exist %FMDUDIR%\WSCREEN.0 del %FMDUDIR%\WSCREEN.0>nul
if exist safemode.txt del safemode.txt >nul
if exist cmd.ini del cmd.ini >nul
if exist com.ini del com.ini >nul
if exist 1.com del 1.com >nul
if exist wbat.ini ren wbat.ini gui.ini
set inputconfig=
set cfg=
set code=
set wrb=
set len=
set random=
set WBoxFrame=
set gfile=
set folder=
set fc=
set fk0=
set fk1=
set hdpmi=
set SYSDRV=
set $dtc=
set $wnc=
set $wtc=
set ?=
set wbat=
goto exit2

:THerror
echo 此操作系统不能在命令提示符下运行！
pause
exit

:exit2
