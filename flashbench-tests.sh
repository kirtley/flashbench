DRIVE=$1
for i in 1 2 4 8 16
do
BLOCKSIZE=[i * 512]
./home/kirtley/git/flashbench -a $DRIVE --blocksize=$BLOCKSIZE
	for e in 1 2 4 8 16
	do
	ERASESIZE=[e * 1024 * 1024]
		for AU in 1 2 3 4 5 6 7 8
		do
		./home/kirtley/git/flashbench -O --erasesize=$ERASESIZE --blocksize=$BLOCKSIZE $DRIVE  --open-au-nr=$AU
		done
	done
done