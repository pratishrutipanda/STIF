open FILE, "$ARGV[0]" || die "Type 'perl this.pl x.seq'\n";
@file = <FILE>;
close(FILE);

foreach (@file)
{
	chomp($_);
	if($_ =~/^>/)
	{
		$key = $_;		
	}
	else
	{
		$hash{$key}.=$_;
	}
}

foreach $key (keys %hash)
{
	#print "$key :::: $hash{$key}\n";
	print "$key\n";
	$substr = substr($hash{$key},900, );
	print "$substr\n";
}

