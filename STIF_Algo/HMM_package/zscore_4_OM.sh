#!/bin/bash

#echo "Type the directory for which zscores calculation has to be done"
input_path=$1
result_path=$2

mkdir $result_path/pgm/zscores
cp $input_path/pgms/moving.pl $result_path/pgm/full_slides/
cp $input_path/pgms/sdevn*.pl $result_path/pgm/full_slides/
cp $input_path/pgms/valid_single_file.pl $result_path/pgm/valid_slides/
cp $input_path/pgms/zscore*.pl $result_path/pgm/zscores/

cd $result_path/pgm/full_slides/
perl moving.pl
perl sdevn_all_files.pl

cd $result_path/pgm/valid_slides/
cat *.out > seq_both.out
mkdir output
perl valid_single_file.pl seq_both.out

cp $result_path/pgm/valid_slides/output/*.outout* $result_path/pgm/zscores/
cp $result_path/pgm/full_slides/*.sd $result_path/pgm/zscores/
cd $result_path/pgm/zscores

perl zscore_all_files.pl

echo ".................... END .................."
