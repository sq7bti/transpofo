@echo off
CLS
REM pcd.com
ECHO ---------------------------------------
ECHO Portfolio is being set up
ECHO 20 KB Ramdisk ? Y/N (1st time only)
FDISK 20
CLS
REM echo ---------------------------------------
REM echo Set password:
REM \SYSTEM\PW.COM /s
REM echo !
REM cls
ECHO ------------------------------------
ECHO Set time and date
ECHO ------------------------------------
DATE
TIME
CLS
ECHO        Preparing system ...
XCOPY \SYSTEM\*.* C:\SYSTEM >C:\INSTALL.LOG
COPY \CONFIG.SYS C:\  >>C:\INSTALL.LOG
COPY \AUTOEXEC.BAT C:\  >>C:\INSTALL.LOG
COPY \SYSTEM\POFOCF.SYS C:\ >>C:\INSTALL.LOG
COPY \SYSTEM\DOIT.BAT c:\SYSTEM\DONEIT.TXT >>C:\INSTALL.LOG
C:
LABEL RamDriveC
CHKDSK >>C:\LOG.TXT
CLS
ECHO Soft reset is carried out
S-RESET.COM
