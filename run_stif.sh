#sh run_stif.sh ~/Desktop/stif/STIF_Algo/HMM_package/ 1.fasta ~/Desktop/stif/Result/ ~/Desktop/stif/
input_path=$1
seq_file=$2
result_path=$3
current_path=$4


# # inputs are $script_dir $sequence_file $result_dir
sh STIF_Algo/HMM_package/1000_seq_1_OM.sh $input_path $seq_file $result_path

mkdir $result_path/pgm
mkdir $result_path/pgm/full_slides
mkdir $result_path/pgm/valid_slides


perl $input_path/pgms/full_slides.pl $seq_file $input_path/consensus $result_path/pgm/full_slides
perl $input_path/pgms/fin_HMM_fwd_1000.pl $result_path/*.fasta.fwd_1k  $input_path/consensus > $result_path/pgm/valid_slides/seq_FWD.out
perl $input_path/pgms/fin_HMM_rev_1000.pl $result_path/*.fasta.rev_1k  $input_path/consensus > $result_path/pgm/valid_slides/seq_REV.out


# # #$script path  $input directory $output directory
perl $input_path/pgms/sdevn_all_files.pl  $input_path/pgms $result_path/pgm/full_slides

# # # merge both FOR and REV files
cat $result_path/pgm/valid_slides/seq_FWD.out $result_path/pgm/valid_slides/seq_REV.out > $result_path/pgm/valid_slides/seq_both.out

# # #
perl $input_path/pgms/valid_single_file.pl $result_path/pgm/valid_slides/seq_both.out $result_path/pgm/valid_slides

mkdir $result_path/pgm/zscores

cp $result_path/pgm/valid_slides/*.outout* $result_path/pgm/zscores/
cp $result_path/pgm/full_slides/*.sd $result_path/pgm/zscores/

# # # $script path $input directory 
perl $input_path/pgms/zscore_all_files.pl $input_path/pgms $result_path/pgm/zscores

# # echo ".................... END .................."

sh $input_path/pgms/combine.sh $result_path/pgm/zscores


perl $input_path/pgms/filter_duplicates.pl $result_path/pgm/zscores/all_factor.zscore > $result_path/pgm/zscores/inp_normal
perl $input_path/pgms/normal_1.pl $result_path/pgm/zscores/inp_normal > $result_path/pgm/zscores/inp
perl $input_path/pgms/normal_2.pl $result_path/pgm/zscores/inp > $result_path/normal.output

perl output2.pl $seq_file $result_path/normal.output $current_path > $result_path/tab_output.tsv