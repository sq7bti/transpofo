#!/bin/bash

transfolio -f -t AE_B.BAT b:/autoexec.bat
transfolio -f -t AE_C.BAT b:/
transfolio -f -t CONFIG.SYS b:/
transfolio -f -t prog/*.* b:/prog/
transfolio -f -t system/*.* b:/system/
