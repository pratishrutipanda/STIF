open SEQ,"$ARGV[0]" || die "Type x.pl seq_file_upstream list_acc_no--> but the accession no: shud be in CAPITAL LETTER \n";
@seq = <SEQ>;
close (SEQ);

open LIST, "$ARGV[1]" || die "Type x.pl seq_file_upstream list_acc_no--> but the accession no: shud be in CAPITAL LETTER\n";
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

for($i=0;$i<=$#list;$i++)
{	
	chomp($list[$i]);
	#print "LIST :: $list[$i]***\t";
	foreach $seq_k (keys %hash_seq)
	{
		@sp_key1 = split(/>|\s+|\t+|-|:/,$seq_k);
	#	print "$sp_key1[1] \n";
		if($list[$i] eq $sp_key1[1])
		{
			print "$seq_k\n";
			print "$hash_seq{$seq_k}\n";
		}
	}
}
