#!/bin/bash

f=${1##./}
d=${2-E}

transfolio -t ${f} ${d}:${f}
