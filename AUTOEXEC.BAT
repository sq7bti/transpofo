@ECHO OFF
REM CLS
PATH=c:\prog;\prog;c:\system;\system
SYSTEM\UPDATE
REM CLS
REM APP
REM ram_test.com
if exist c:\config.sys goto done
md c:\system
copy config.sys c:\
copy system\*.* c:\system\
copy ae_c.bat c:\autoexec.bat
date
time
:done
ver
PROMPT $p$g
