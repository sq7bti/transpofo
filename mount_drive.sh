#!/bin/bash

part=0;
access="rw"
folder=""

function help {
	echo "Usage:";
	echo "$0 image.img"
	echo " -p|--part part ID";
	echo " -r|--read-only restrict write access";
	echo " -f|--folder destination folder";
	exit;
}
while [ $# -gt 0 ]
do
	case ${1} in
		-h|--help) help;;
		-p|--part) shift; part=${1};;
		-r|--read_only) access="ro";;
		-f|--folder) shift; folder=${1};;
		*) img=${1};;
	esac
	shift
done

slimit=33423360
offset=0
p=${part}
echo "image ${img}"
echo "partition num ${p}"
while [ $p -gt 0 ]; do
	((offset=offset+slimit))
	((p=p-1))
done

imgsize=$(stat -c%s "$img")

if [ $imgsize -gt 0 ]; then
	echo "image size ${imgsize}"
	if [ $((offset+slimit)) -gt ${imgsize} ]; then
		echo "end of part ${part} exceeds image boundary"
		((slimit=imgsize-offset-1))
	fi
fi

PoFoDrives="DEFGHIJKLMNOPQRSTUVWXYZ"
driveID=${PoFoDrives:${part}:1}
echo "size limit: ${slimit}"
echo "offset    : ${offset}"
echo "partID    : ${part}"
echo "driveID   : ${driveID}"
if [ "xx" == "x${folder}x" ]; then
	folder=${3-${img}_disk${driveID}}
fi
if [ "zz" == "z${folder}z" ]; then
	echo "creating folder: ${folder}"
	mkdir -p ${folder}
fi
uid=`id -u`
echo "user id   : ${uid}"
gid=`id -g`
echo "user gid  : ${gid}"

sudo mount -o loop,${access},user,uid=${uid},gid=${gid},offset=${offset},sizelimit=${slimit} ${img} ${folder} || rm -rf ${folder}
