#!/bin/bash

echo "Type the 1000+5UTR seq_file to split FWD & REV as separate files"
read file
echo ".............  PROCESSING ................."

mkdir seq

perl prepare_pgms/del_fwd.pl $file > seq/$file.fwd_1000+utr 
perl prepare_pgms/del_rev.pl $file > seq/$file.rev_1000+utr

echo "............. END ................."
echo "THE OUTPUT FILES --> 'seq/$file.fwd_1000+utr' & 'seq/$file.rev_1000+utr'"
