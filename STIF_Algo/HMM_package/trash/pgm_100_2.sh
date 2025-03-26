#!/bin/bash

echo "Type the directory name where your output files has to be placed"
read work
echo "Type the sequence file name which has both FWD & REV seq"
read seq
echo "Type the sequence file name which has FWD alone"
read seq_FWD
echo "Type the sequence file name which has REV alone"
read seq_REV
echo "Type the consensus file name "
read con


mkdir $work
mkdir $work/full_slides $work/valid_slides   
mkdir $work/full_slides/output1 $work/valid_slides/forward $work/valid_slides/reverse 

cp pgms/full_slides.pl $work/full_slides/
cp $seq $work/full_slides/
cp $con $work/full_slides/

cd $work/full_slides/
perl full_slides.pl $seq $con&
cd ../../ 
perl pgms/fin_HMM_fwd.pl $seq_FWD $con > $work/valid_slides/forward/$seq_FWD.out&
perl pgms/fin_HMM_rev.pl $seq_REV $con > $work/valid_slides/reverse/$seq_REV.out&

echo "............3 PROGRAMS ARE UNDER PROCESS ............."
echo "....... CHECK WITH top COMMAND .............."
echo 
echo "OUTPUT files --> 1)$work/valid_slides/forward/$seq_FWD.out" 
echo "OUTPUT files --> 2)$work/valid_slides/forward/$seq_REV.out" 
echo "OUTPUT files --> 3)$work/full_slides/output1/many files as x_full" 


