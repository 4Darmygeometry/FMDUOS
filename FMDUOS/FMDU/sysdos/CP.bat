@echo off
if "%1"=="/G" goto graftabl
if "%1"=="help" goto help
if "%1"=="/?" goto help
if "%1"=="437" goto ASCII
if "%1"=="936" goto GBK
if "%1"=="20936" goto GB2312
set /p code=<chcp.ini
if "%code%"=="437" echo The current code page is 437
if not "%code%"=="437" echo ��ǰ����ҳ %code%
goto exitcp

:graftabl
if "%2"=="help" goto helpg
if "%2"=="/?" goto helpg
if "%2"=="437" goto ASCII
if "%2"=="936" goto GBK
if "%2"=="20936" goto GB2312
set /p code=<chcp.ini
if "%code%"=="437" echo The current code page in graphic mode is 437
if not "%code%"=="437" echo ��ǰͼ��ģʽ����ҳ %code%

:ASCII
set /p code=<chcp.ini
if "%code%"=="437" goto exitcp
if "%code%"=="936" GBKDOS>nul
TW /q>nul
echo 437>chcp.ini
goto exitcp

:GBK
set /p code=<chcp.ini
if "%code%"=="936" goto exitcp
if "%code%"=="437" TW /np>nul
if "%code%"=="437" KEY PY LX>nul
GBKDOS>nul
echo 936>chcp.ini
cls
goto exitcp

:GB2312
set /p code=<chcp.ini
if "%code%"=="20936" goto exitcp
if "%code%"=="936" GBKDOS>nul
if "%code%"=="437" TW /np>nul
if "%code%"=="437" KEY PY LX>nul
echo 20936>chcp.ini
goto exitcp

:help
set /p code=<chcp.ini
if "%code%"=="437" goto help_en
if not "%code%"=="437" goto help_cn

:help_en
echo CHCP [nnn/nnnnn]
echo nnn/nnnnn Specifies a code page number.
echo Type CHCP without a parameter to display the current code page number.
goto exitcp

:help_cn
echo CHCP [nnn/nnnnn]
echo nnn/nnnnn ָ������ҳ���
echo ������������ CHCP ����ʾ��ǰ����ҳ��š�
goto exitcp

:helpg
set /p code=<chcp.ini
if "%code%"=="437" goto helpg_en
if not "%code%"=="437" goto helpg_cn

:helpg_en
echo GRAFTABL [nnn/nnnnn]
echo nnn/nnnnn Specifies a code page number in graphic mode.
echo Type GRAFTABL without a parameter to display the current code page number in graphic mode.
goto exitcp

:helpg_cn
echo GRAFTABL [nnn/nnnnn]
echo nnn/nnnnn ָ��ͼ��ģʽ����ҳ���
echo ������������ GRAFTABL ����ʾ��ǰͼ��ģʽ����ҳ��š�
goto exitcp

:exitcp