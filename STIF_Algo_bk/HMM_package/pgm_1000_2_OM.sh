#!/bin/bash


input_path=$1
seq_file=$2
result_path=$3
mkdir $result_path/pgm
mkdir $result_path/pgm/full_slides
mkdir $result_path/pgm/valid_slides

# perl $input_path/pgms/full_slides.pl $seq_file  $input_path/consensus

# cd ../../ 
# perl $input_path/pgms/fin_HMM_fwd_1000.pl $result_path/$file.fwd_1k  $result_path/consensus.txt > $result_path/$seq_FWD.out
# perl pgms/fin_HMM_rev_1000.pl $seq_REV $con > $work/valid_slides/reverse/$seq_REV.out

# echo "............3 PROGRAMS ARE UNDER PROCESS ............."
# echo "....... CHECK WITH top COMMAND .............."
# echo 
# echo "OUTPUT files --> 1)$work/valid_slides/forward/$seq_FWD.out" 
# echo "OUTPUT files --> 2)$work/valid_slides/forward/$seq_REV.out" 
# echo "OUTPUT files --> 3)$work/full_slides/output1/many files as x_full" 


