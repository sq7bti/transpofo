#!/bin/bash

part=0;

while [ $# -gt 0 ]
do
	case ${1} in
		-h|--help)
			echo "Usage:";
			echo "$0 image.img"
			echo " -p|--part part ID";
			echo " -f|--folder destination folder";;
		-p|--part) shift; part=${1};;
		-f|--folder) shift; folder=${1};;
		*) img=${1};;
	esac
	shift
done

slimit=33423360
offset=0
p=${part}
while [ $p -gt 0 ]; do
	((offset=offset+slimit))
	((p=p-1))
done

PoFoDrives="DEFGHIJKLMNOPQRSTUVWXYZ"
driveID=${PoFoDrives:${part}:1}
echo "size limit: ${slimit}"
echo "offset    : ${offset}"
echo "partID    : ${part}"
echo "driveID   : ${driveID}"

folder=${3-${img}_disk${driveID}}
if [ "zz" == "z${3}z" ]; then
	echo "creating folder: ${folder}"
	mkdir ${folder}
fi

sudo mount -o loop,offset=${offset},sizelimit=${slimit} ${img} ${folder} || rm -rf ${folder}
