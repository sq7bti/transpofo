@ECHO OFF
REM CLS
PATH=d:\prog;b:\prog;c:\prog;\prog;b:\system;c:\system;\system
SYSTEM\UPDATE
REM CLS
REM APP
REM ram_test.com
if exist c:\config.sys goto done
fdisk 16
md c:\system
copy b:\config.sys c:\
copy b:\ae_c.bat c:\autoexec.bat
copy b:\system\*.* c:\system\
date
time
:done
B:\SYSTEM\MDEXTERN C:\SYSTEM\ATMD.COM
PROMPT $p$g
ver
