format b:
md b:\prog
copy a:\prog b:\prog\
md b:\system
copy a:\system b:\system\
rem copy a:\*.* b:\
copy a:\AE_B.BAT b:\AUTOEXEC.BAT
copy a:\AE_C.BAT b:\
copy a:\AUTOEXEC.BAT b:\AE_A.BAT
copy a:\CONFIG.SYS b:\
rem copy a:\INITB.BAT b:\
