#!/bin/bash

for f in `find . -type d`; do echo "MD ${f##./}"; done | tr '/' '\\' > MFOLDER.BAT

transfolio -t MFOLDER.BAT E:
