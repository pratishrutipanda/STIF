#!/usr/bin/perl
open FILE,$ARGV[0] || die "Type 'perl del_character.pl x.seq'\n";
@file = <FILE>;
close (FILE);

foreach(@file)
{	
	chomp($_);
	if($_ =~/^>/)
	{
		$key = $_;
	}
	else
	{
		$hash{$key} = $_;
	}
}

foreach $key (sort keys %hash)
{
#	print "$key ::::::::::: $hash{$key}\n";
	$cnt=$hash{$key}=~tr/ATGC/ATGC/;
	@spl = split (/\s+|\t+|-|:/,$key);
#	print "SSSSSSSSSSSSSSSSSSSSSS :: $spl[3] \n";
	$add = $spl[3] -900;
#	print "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA :: $add\n";
	#$alt = $add + 900;
#	print "FFFFFFFFFF :: $alt :: $spl[4]\n";
	$fin = ($add-$cnt) + 1;
	print "$spl[0] $spl[1] $spl[2]:$add-$fin $spl[5]\n";
	print "$hash{$key}\n";
}
=d
foreach $key (keys %hash)
{
	print "$key :::::::: $hash{$key}\n";
	$cnt=$hash{$key}=~tr/ATGC/ATGC/;
#	print "CNT :: $cnt\n";
	if($key =~ /^>(\w*) \| chr(\d):(\w*\-)\w*\s? (\w*\s?\-\-)/)
	{
#		print "$1::::::::$2::::$3::::::$4::::$5\n";
		@sp = split(/\s+|\t+|-/,$key);
#		print "44444444444 :: $sp[5]\n";
		$fin = ($3+$cnt) - 1;
		print ">$1 | chr$2:$3$fin $4$sp[7]\n";
	}
	print "$hash{$key}\n";
	
}
