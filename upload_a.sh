#!/bin/bash

sed 's/X:/A:/g' AUTOEXEC.BAT > AE_A.BAT
transfolio -f -t AE_A.BAT A:/AUTOEXEC.BAT
transfolio -f -t AE_C.BAT A:/
transfolio -f -t CONFIG.SYS A:/
transfolio -f -t ANSI.SYS A:/
transfolio -f -t POFOCF.SYS A:/
transfolio -f -t DOS/*.* A:/DOS/ || echo "check if folder DOS and prog exists"
for f in `ls -1Sr PROG`; do transfolio -f -t PROG/${f} A:/PROG/; done
