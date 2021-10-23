@ECHO OFF
REM CLS
PATH=c:\prog;\prog;c:\system;\system
PROMPT $p$g
SYSTEM\UPDATE
REM CLS
REM APP
REM ram_test.com
if exist c:\config.sys goto done
copy config.sys c:\
copy ansi.sys c:\
date
time
:done
ver
