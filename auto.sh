#!/bin/bash/

max=2
for i in `seq 1 $max`
do
echo $i;

sh run_stif.sh STIF_Algo/HMM_package $i.fasta Result .;

done
