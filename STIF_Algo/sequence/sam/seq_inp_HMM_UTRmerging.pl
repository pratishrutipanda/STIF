open SEQ,"$ARGV[0]" || die "Type x.pl seq_file_upstream seq_file_utr list_acc_no--> but the accession no: shud be in CAPITAL LETTER \n";
@seq = <SEQ>;
close (SEQ);

open UTR, "$ARGV[1]" || die "Type x.pl seq_file_upstream seq_file_utr list_acc_no--> but the accession no: shud be in CAPITAL LETTER\n";
@utr =<UTR>;
close (UTR);

open LIST, "$ARGV[2]" || die "Type x.pl seq_file_upstream seq_file_utr list_acc_no--> but the accession no: shud be in CAPITAL LETTER\n";
@list =<LIST>;
close (LIST);

#print "@seq\n";

foreach	(@seq)
{
	chomp($_);
	if($_ =~ /^>/)
	{
		$seq_k = $_;	
	}
	else
	{
		$hash_seq{$seq_k} .= $_ ;
	}
}

foreach (@utr)
{
	chomp($_);
	if($_ =~ /^>/)
	{
		$utrr = $_;
	}
	else
	{
		$hash_utr{$utrr} .= $_;
	}
}

for($i=0;$i<=$#list;$i++)
{	
	chomp($list[$i]);
#	print "LIST :: $list[$i]***\t";
	foreach $seq_k (keys %hash_seq)
	{
	#	print "$seq_k\n";
		@sp_key1 = split(/>|\s+|\t+|-|:/,$seq_k);
		#print "$sp_key1[1] \n";
		if($list[$i] eq $sp_key1[1])
		{
		#	print "^^^^^^^^^^^^$list[$i] eq $sp_key1[1]\n";	
	#	print "AFT ::: $seq_k\n";
			foreach $utrr (keys %hash_utr)
			{	
				@sp_key2=split(/\[|\]|\s+|\t|>/,$utrr);	
	#			print "$sp_key2[1] || $sp_key2[2] || $sp_key1[1]\n";
				$add = $sp_key1[1]."\.".1;
				#print "ADD :: $add\n";		
			if($add eq $sp_key2[1])
			{
#				print "UPSTREM :: $seq_k\n";
				foreach(@sp_key2)
				{
					if($_ =~ /^FORWARD/)
					{
#						print "FWDUTRRRRRR :: $utrr\n";
						@spp = split(/\s+|\t+/,$utrr);
						foreach(@spp)
						{
							if($_ =~ /^chr/)
							{
								@split_chr = split(/:|-/,$_);
								#print "########### $split_chr[2]\n";		
							}
						}		
						print ">$sp_key1[0]$sp_key1[1] $sp_key1[2] $sp_key1[3]:$sp_key1[4]-$split_chr[2] $sp_key1[6]\n";
					}
					elsif($_ =~ /^REVERSE/)
					{
#						print "REVUTRRRRR :: $utrr\n";
						@spp1 = split(/\s+|\t+/,$utrr);
						foreach(@spp1)
                                                {
                                                        if($_ =~ /^chr/)
                                                        {
                                                                @split_chr1 = split(/:|-/,$_);
                                                                #print "########### $split_chr1[1]\n";
                                                        }
                                                }
						print ">$sp_key1[0]$sp_key1[1] $sp_key1[2] $sp_key1[3]:$sp_key1[4]-$split_chr1[1] $sp_key1[6]\n";
					}
				}

#				print "$sp_key2[1] || $sp_key2[5] \n";
#					print "$utrr\n";
	#				print "$sp_key2[5]\n";
					@utr_nos = split(/-/,$sp_key2[5]);
					$utr_seq = substr($hash_utr{$utrr}, $utr_nos[0]-1,$utr_nos[1]+1);
			#		print "FULL ::$hash_utr{$utrr}\n";
					print "$hash_seq{$seq_k}";
					print "$hash_utr{$utrr}\n";
				}
			}
		}
	}
}
