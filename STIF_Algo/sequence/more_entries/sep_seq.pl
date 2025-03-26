open SEQ, "$ARGV[0]" || die "Type x.pl SEQ_FILE no:--> this no: is the query for divding the whole number of sequences into small parts\n";
@seq = <SEQ>;
close (SEQ);

$no = "$ARGV[1]" || die "Type x.pl SEQ_FILE no:--> this no: is the query for divding the whole number of sequences into small parts\n";

foreach(@seq)
{
	chomp($_);
	if($_=~/^>/)
	{
		$key = $_;
	}
	else
	{
		$hash{$key} .= $_;
	}
}

foreach $key (keys %hash)
{
#	print "$key\n$hash{$key}\n";
	if($key)
	{
		if($n == 0)
		{
			print "COUNT\n";
		}
		$n++;
               print "$key\n";
	       print "$hash{$key}\n";
		if($n >= $no)
		{
			$n = 0;
		}
	}
}
