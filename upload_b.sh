#!/bin/bash

sed 's/X:/B:/g' AUTOEXEC.BAT > AE_B.BAT
transfolio -f -t AE_B.BAT B:/AUTOEXEC.BAT
error=$?
if [ ${error} -gt 0 ]; then
  echo "Error : ${error}"
  exit
fi
for f in AE_C.BAT CONFIG.SYS; do
  transfolio -f -t "${f}" B:/
  error=$?
  if [ ${error} -gt 0 ]; then
    echo error
    exit
  fi
done
for f in `ls -1Sr SYSTEM`; do
  transfolio -f -t SYSTEM/${f} B:/SYSTEM/
  error=$?
  if [ ${error} -gt 0 ]; then
    echo "check if folder SYSTEM and prog exists"
    exit
  fi
done
for f in `ls -1Sr PROG`; do
  transfolio -f -t PROG/${f} B:/PROG/;
  error=$?
  if [ ${error} -gt 0 ]; then
    echo "check if folder PROG and prog exists"
    exit
  fi
done
