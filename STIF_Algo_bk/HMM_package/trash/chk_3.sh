#!/bin/bash


echo "This program is to check whether given input seq & input consensus are fully processed by the HMM program"
echo "So please give the input sequence same as given to previous program 'pgm.sh'"

echo "Type the directory name to check the your output files"
read work

echo "Type the sequence file name which has FWD alone"
read seq_FWD

grep -c ">" $seq_FWD
grep -c ">" $work/valid_slides/forward/*.out

echo "Type the sequence file name which has REV alone"
read seq_REV

grep -c ">" $seq_REV
grep -c ">" $work/valid_slides/reverse/*.out

echo "Type the consensus file name "
read con

grep -c "FACTOR" $con
ls $work/full_slides/output1/*full* | wc -l


#echo "The no 


