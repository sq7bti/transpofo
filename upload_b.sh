#!/bin/bash

sed 's/X:/B:/g' AUTOEXEC.BAT > AE_B.BAT
transfolio -f -t AE_B.BAT B:/AUTOEXEC.BAT
transfolio -f -t AE_C.BAT B:/
transfolio -f -t CONFIG.SYS B:/
transfolio -f -t system/*.* B:/system/ || echo "check if folder prog exists"
for f in `ls -1Sr prog`; do transfolio -f -t prog/${f} B:/prog/; done
