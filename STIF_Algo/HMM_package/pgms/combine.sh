dir_path=$1

cd $dir_path
for file in `ls -1p *.zsco`
do 
	echo "****$file" >> all_factor.zscore
	cat $file >> all_factor.zscore
	echo "********************************** END OF FILE ********************" >>all_factor.zscore
	echo  >>all_factor.zscore
done
chmod 755 all_factor.zscore
