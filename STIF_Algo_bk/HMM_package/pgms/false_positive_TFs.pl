open FILE,"$ARGV[0]" || die "type x.pl all_zscore_file threshold_value\n";
$thre =$ARGV[1] ||  die "type x.pl all_zscore_file threshold_value\n";
@file = <FILE>;
close(FILE);


foreach(@file)
{
	chomp($_);
	if($_ =~ /\*{4}(\w+)/)
	{
		$key = $1;
	}
	elsif($_ =~ /^>/ || $_ =~/^Z-SCORE/)
	{
		$hash{$key} .= $_ ."***";
	}
}

foreach $key (keys %hash)
{
#	print "$key\n";
	@split=split(/\*\*\*/,$hash{$key});
	foreach(@split)
	{
		if($_ =~ /^>/)
		{
			@sp_key = split(/\|/,$_);
	#		print "$sp_key[1] :: $sp_key[6] :: $sp_key[7] :: $sp_key[12]\n";
			$k = $sp_key[5];	
		}
		else
		{
			$hh{$k} .= $_ . "^^^";
		}
	}
	foreach $k (keys %hh)
	{
		@sp_val2 = split(/\^\^\^/,$hh{$k});
		foreach(@sp_val2)
		{
		#	print "$_\n";
			@spp = split(/::|\t+|\s+/,$_);
		#	print "$spp[2] || $spp[7]\n";
			if($spp[7] !~ /lit/)
			{
			 	if($spp[2] > $thre)
				{
					
					print "$key\n$k\n$_\n";
				}			
			}
		}
	}
print "*************************************************************************\n";
undef %hh;	
}
