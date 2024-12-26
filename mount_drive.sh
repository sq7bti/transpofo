#!/bin/bash

part=0;
access="rw"
folder=""
fake=""

function help {
	echo "Usage:";
	echo "$0 image.img|/dev/sdX (folder)"
	echo "Options:"
	echo " -p|--part part ID (default #0). Post-fix _diskX will be added to mount folder name.";
	echo " -r|--read-only Mount the filesystem read-only.";
	echo " -f|--fake Causes everything to be done except for the mount-related system calls.";
	exit;
}

if [ $# -lt 1 ]; then
	help;
	exit;
fi
p=0
while [ $# -gt 0 ]
do
	case ${1} in
		-h|--help) help; exit;;
		-p|--part) shift; p=${1};;
		-r|--read_only) access="ro";;
		-f|--fake) fake="--fake";;
		*) break;;
	esac
	shift
done

img=${1}
shift
folder=${1}

PoFoDrives="DEFGHIJKLMNOPQRSTUVWXYZ"
driveID=${PoFoDrives:${p}:1}

if [ "xx" == "x${folder}x" ]; then
	if [ -b ${img} ]; then
		echo "Target mount folder not specified for block device, abort!"
		exit 1
	fi
	if [ -f ${img} ]; then
		#folder=${3-${img}_part${driveID}}
		folder="${img}"
		echo "folder not specified, assumed: ${folder}"
	fi
fi

folder="${folder}_disk${driveID}"

echo -en "mounting partition # ${p} of a "

if [ -b ${img} ]; then
	echo -en "block device "
	imgsize=$( lsblk -n -b -o SIZE ${img} )
	sizemb=$( lsblk -n -o SIZE ${img} )
else
	if [ -f ${img} ]; then
		echo -en "image file "
		imgsize=$( stat -c%s ${img} )
		sizemb=0
		((sizemb = imgsize / 1048576 ))
	else
		echo -en "unknown file "
	fi
fi

echo "\"${img}\" of size ${imgsize} bytes to a folder \"${folder}\""

if [ ! -d "${folder}" ]; then
	echo "creating folder: ${folder}"
	mkdir -p ${folder}
fi

slimit=33423360
offset=0

((offset=slimit*p))

if [ $imgsize -gt 0 ]; then
	#echo "image size ${imgsize}"
	if [ $((offset+slimit)) -gt ${imgsize} ]; then
		((slimit=imgsize-offset-1))
		if [ $slimit -lt 0 ]; then
			echo "Part $p is beyond end of disk. Abort."
			exit -1;
		fi
		echo "End of part ${p} exceeds image boundary. Size limited to ${slimit}. Mounting disabled."
		fake="--fake";
	fi
else
	echo "cannot verify size of block device"
fi

((endpart=offset+slimit))
echo "image size: ${imgsize}"
echo "offset    : ${offset}"
echo "size limit: ${slimit}"
echo "end part  : ${endpart}"
echo "partID    : ${p}"
echo "driveID   : ${driveID}"

uid=`id -u`
echo -en "user      : "; whoami
echo "user id   : ${uid}"
gid=`id -g`
echo "user gid  : ${gid}"

use_sudo=""
if [ $uid -gt 0 ]; then
	use_sudo="sudo "
fi

${use_sudo}mount ${fake} -o loop,${access},user,uid=${uid},gid=${gid},offset=${offset},sizelimit=${slimit} ${img} ${folder}
