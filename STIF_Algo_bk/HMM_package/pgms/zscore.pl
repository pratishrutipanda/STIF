#!/usr/bin/perl

open VALSCORES,"$ARGV[0]" ||die "Type perl validationfile \n";
@val=<VALSCORES>;
close @val;
#print "@val\n";


sub z_score
{
	my($me_res)=shift;
	my($scores)=shift;
#	print "ININPUINPU == $me_res :::::::: $scores\n";
	@sdsdsp = split(/MEAN :: |\t+|\s+|SD :: /,$me_res);
	@spll = split(/\t+/,$scores);
#	print "SDFADFDF == @sdsdsp :::::::: @spll\n";
	foreach(@spll)
	{
		if($_ !~ "  ")
		{
#			print "DDDDDDDDDDDDDDDDDDDDDD :: $_\n";
			if($_ =~ /^(\d+(\.+)\d)/)
			{
#				print "DDDDDDDD$_\n";
			#	print "$_ ++++++++++++++++++ $sdsdsp[1] +++++++++++++ $sdsdsp[3]\n";
				$z_sco = ($_-$sdsdsp[1])/$sdsdsp[3];
				print "\nZ-SCORE ::";
				printf "%.4f", $z_sco;
			#print "\n";
			}
			elsif($_ =~ /^_5UTR/)
			{
				print "   __$_";
			}
			elsif($_ =~ /^[ATGC]/)
			{
				print " \t $_";
			}
			elsif($_ =~ /^(-?\d+to-?\d+)/)
			{
				print "\t$_";
			}
			elsif($_ =~ /^FORWARD|^REVERSE/)
			{
				print " \t $_";
			}
			elsif($_ =~ /^\d+-\d+/)
			{
				print "\t$_\t";
			}
		}
	}
}

undef %valval;
foreach (@val)
{
	chomp($_);
	if($_ =~ /^>(AT\w*)/)
	{
		#print "WWWWWWWWWW ::$1 \n";
		$acc = $_;	
	}
	if($_ =~ /\*{4}(\w+)/)
	{
#		print "SSSSSSSSSSSS ::: $1 ||||| $acc \n";	
		$key1 = $1 ."\t". $acc ;
	}
	elsif ($_ =~ /^FORWARD|^REVERSE/)
	{
#		print "%%%%% :: $_\n";
		@sep_val = split(/\t+|\s+/, $_);	
#	print "LLLLLLLLL ::::: @sep_val\n";
#		print "LLLLLLLLL ::::: $sep_val[2]\n";
#		print "sdfggfgfL ::::: $sep_val[3]\n";
		@splittt = split(/__/,$sep_val[3]);
		#print "$splittt[0]:::::::::::::::::::: $splittt[1]\n";
		#print "\t".$sep_val[4]."\t"."LLL$splittt[1]"."\t"."$sep_val[2]"."\t"."$sep_val[0]"."\t"."$sep_val[3]","\n"; 
		$valval{$key1}.="\t".$sep_val[4]."\t"."$sep_val[2]"."\t"."$sep_val[3]"."\t"."$sep_val[0]"."\t"."$sep_val[1]"; 
	}		
}

foreach $key1 (keys %valval)
{
#	print " $key1 ___________ $valval{$key1}\n";
	@spl_key = split (/\t/,$key1);
	print "\n$spl_key[1] ||||  $spl_key[0]";
	@acc_no = split(/>|\||\s/,$spl_key[1]);
	#print "$acc_no[0] ++++++++ $acc_no[1] ++++++++++ $acc_no[2] \n";

	$file_path = $ARGV[1]."/"."$spl_key[0].sd";
	# print "$file_path";
	open FILE, $file_path || die "could not the open the file\n";
	@file = <FILE>;
	# print "LINE1:@file~~\n";
	close (FILE);

	foreach(@file)
	{
		chomp($_);
		if($_ =~/(AT\w+)/)
		{
	#		print "COOCOCOCOCOCO :: $_ ++++++++++++++++++ $1\n";
			$key = $1;
		}
		elsif($_ =~/^MEAN/)
		{
	#		print "REMMMM :: $_\n";
			$sd{$key} = $_ ;
		}
	}
	foreach $key (keys %sd)
	{
#				print "^^^$key ________ $spl_key[1]\n";
				if($key eq $acc_no[1])
				{
#					print "((((((( $split[$d] = $sd{$key} ===== $valval{$key1} \n";
					 &z_score($sd{$key},$valval{$key1});
					print "\n";
				}
	}
undef %sd;	
}
