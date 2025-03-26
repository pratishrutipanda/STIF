#!/bin/bash


echo "Type the directory name to calculate normalization for your all zscore files"
read work


cd $work
rm all_factor.zscore

sh ../pgms/combine.sh

cp ../pgms/filter_duplicates.pl .
cp ../pgms/normal_1.pl .
cp ../pgms/normal_2.pl .

perl filter_duplicates.pl all_factor.zscore > inp_normal
perl normal_1.pl inp_normal > inp
perl normal_2.pl inp > normal.output

echo "The ouput is in '$work/normal.output'"
