#!/bin/bash
# Kirtley Wienbroer
# kirtley@osgenie.com

# check if user is root
if [ $UID != 0 ]; then
	echo "You need root privileges"
	exit 2
else	
DRIVE=$1
for i in {1..5}
	do
		hdparm -Tt $DRIVE 
	done
for i in {1..5}
	do
	BLOCKCOUNT=$[2**$i]
	BLOCKSIZE=$[$BLOCKCOUNT*512]
	echo "BLOCKCOUNT = " $BLOCKCOUNT
	echo "BLOCKSIZE = " $BLOCKSIZE
	./flashbench -a $DRIVE --blocksize=$BLOCKSIZE
		for e in 1 2 4 8 16
			do
			ERASESIZE=$[$e*1024*1024]
				for AU in {1..5}
					do
					echo "BLOCKSIZE = $BLOCKSIZE ERASESIZE = $ERASESIZE AU = $AU"
					./flashbench -O --erasesize=$ERASESIZE --blocksize=$BLOCKSIZE $DRIVE  --open-au-nr=$AU
					done
			done
	done
fi