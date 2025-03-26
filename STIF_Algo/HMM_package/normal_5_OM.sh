#!/bin/bash


#echo "Type the directory name to calculate normalization for your all zscore files"
input_path=$1
result_path=$2

cd $result_path/pgm/zscores
rm all_factor.zscore

cp $input_path/pgms/combine.sh $result_path/pgm/zscores
sh combine.sh

cp $input_path/pgms/ $result_path/pgm/zscores
cp $input_path/pgms/normal_1.pl $result_path/pgm/zscores
cp $input_path/pgms/normal_2.pl $result_path/pgm/zscores

perl filter_duplicates.pl all_factor.zscore > inp_normal
perl normal_1.pl inp_normal > inp
perl normal_2.pl inp > normal.output

echo "The ouput is in '$work/normal.output'"
