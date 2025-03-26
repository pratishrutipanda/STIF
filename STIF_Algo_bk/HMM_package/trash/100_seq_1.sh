#!/bin/bash

echo "Type the seq_file to convert from 1000+5UTR to 100+5UTR"
read file
echo ".............  PROCESSING ................."

mkdir seq

perl prepare_pgms/delete_char_4m_1000_100.pl $file > prepare_pgms/inp
perl prepare_pgms/del_fwd.pl prepare_pgms/inp > prepare_pgms/FWD
perl prepare_pgms/del_rev.pl prepare_pgms/inp > prepare_pgms/REV
perl prepare_pgms/chr_pos_fwd.pl prepare_pgms/FWD > seq/$file.fwd_100+utr
perl prepare_pgms/chr_pos_rev.pl prepare_pgms/REV > seq/$file.rev_100+utr
cat seq/$file.fwd_100+utr seq/$file.rev_100+utr >  seq/$file.both_100+utr

echo "............. END ................."
echo "THE OUTPUT FILES --> 'seq/$file.fwd_100+utr' & 'seq/$file.rev_100+utr' & 'seq/$file.both_100+utr'"
