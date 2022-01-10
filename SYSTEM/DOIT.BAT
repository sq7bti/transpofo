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
XCOPY /O \SYSTEM\*.* C:\SYSTEM >C:\INSTALL.LOG
XCOPY /O \CONFIG.SYS C:\  >>C:\INSTALL.LOG
XCOPY /O \AUTOEXEC.BAT C:\  >>C:\INSTALL.LOG
XCOPY /O \SYSTEM\DOIT.BAT C:\SYSTEM\DONEIT.TXT >>C:\INSTALL.LOG
C:
LABEL RamDriveC
CHKDSK >>C:\INSTALL.LOG
B:
CLS
ECHO        System prepared ...
ECHO Soft reset will be carried out
PAUSE
S-RESET.COM
