open FWD, "$ARGV[0]" || die "Type 'perl del_fwd.pl x.seq'\n";
@fwd = <FWD>;
close(FWD);

foreach(@fwd)
{
	chomp($_);
	if($_ =~ /^>/)
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
	@sp = split(/\s+/,$key);
#	print "$sp[3]\n";
	if ($sp[3] =~ /^REVERSE/)
	{
		print "$key\n$hash{$key}\n";
	}
}
