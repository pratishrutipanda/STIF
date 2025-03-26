#!/bin/bash

echo "Type the directory for which zscores calculation has to be done"
read work

mkdir $work/full_slides/output1/sd_output_files/ $work/valid_slides/fwd_rev_both/ $work/zscores
mkdir $work/valid_slides/fwd_rev_both/output

cp pgms/moving.pl $work/full_slides/output1/
cp pgms/sdevn*.pl $work/full_slides/output1/
cp pgms/valid_single_file.pl $work/valid_slides/fwd_rev_both/
cp pgms/zscore*.pl $work/zscores

cd $work/full_slides/output1/
perl moving.pl
perl sdevn_all_files.pl
mv *.sd sd_output_files/
cd ../../../ 

cd $work/valid_slides/fwd_rev_both/
cat ../forward/*.out ../reverse/*.out > seq_both.out
perl valid_single_file.pl seq_both.out
cd ../../

cp valid_slides/fwd_rev_both/output/*.outout* zscores/
cp full_slides/output1/sd_output_files/*.sd zscores/
cd zscores

perl zscore_all_files.pl
mkdir zsco_output_files
mv *.zsco zsco_output_files

echo ".................... END .................."
