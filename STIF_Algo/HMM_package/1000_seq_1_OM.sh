#!/bin/bash

#echo "Type the 1000+5UTR seq_file to split FWD & REV as separate files"

input_path=$1
file=$2
result_path=$3
echo ".............  PROCESSING ................."


python3 $input_path/prepare_pgms/del_fwd.pl $file > $result_path/$file.fwd_1k 
python3 $input_path/prepare_pgms/del_rev.pl $file > $result_path/$file.rev_1k

echo "............. END ................."
echo "THE OUTPUT FILES --> '$result_path/$file.fwd_1k' & '$result_path/$file.rev_1k'"
