open FILE,"$ARGV[0]" || die "Type 'perl coverage.pl x.zsco'\n";
@file= <FILE>;
close (FILE);

foreach(@file)
{
	chomp ($_);
	if($_ =~/^\*\*\*\*(\w+)/)
	{
		$kk = $1;
	}
	elsif($_ =~ /^>/ || $_ =~/^Z-SCORE/)
	{	
		$full{$kk} .= $_ ;
		$full{$kk} .= "[[[";
	}
}

foreach $kk (keys %full)
{
	#print "$kk ==== $full{$kk}\n";
	print "****$kk\n";
	@cal = split (/\[\[\[/,$full{$kk});	
	foreach(@cal)
	{
	if ($_ =~ /^>/)
	{
		$key = $_;
	}
	elsif($_ =~/^Z-SCORE/)
	{	
		$hash{$key} .=$_;
		$hash{$key} .="UUU";
	}
	}

foreach $key (keys %hash)
{
#	print "$key ++++++++++ $hash{$key}\n";
	print "$key\n";
	@spkee = split(/\||--/,$key);
	push(@names,$spkee[6]);
	$nu_de = $spkee[2];
#	print "$spkee[2]\n";
	push(@fac,$spkee[6].'*');
	#print "NAMES :: @names\n";
	#print "$hash{$key}\n";
	@sp=split(/UUU/,$hash{$key});
#	print "KKK@sp\n";
	foreach(@sp)
	{
#		print "$_\n";
		@split = split(/\s+|\t+|::/,$_);
		#print "!!!!!!!!@split\n";
	#	print "~~~~~~~~~~~~~~~~~~~~~$split[2] ~~~~~~ $split[7]\n";
		push(@zsco,$split[2]);
		push(@zsco_full,$split[0]."Y".$split[2]."Y".$split[3]."Y".$split[4]."Y".$split[5]."Y".$split[6]."Y");
	}
	#print "ZSC :: @zsco \n";
	@sort = sort {$b <=> $a} @zsco;	
#	print "MAX :: $sort[0]\n";
#	print "FULL :: @zsco_full\n";
	foreach(@zsco_full)
	{
	#	print "$_\n";
		@spl_zs = split(/Y/,$_);
	#	print "SCORE :: $spl_zs[1]\n";
		push(@zsc_thre,$spl_zs[1]);
		if($sort[0] eq $spl_zs[1])
		{
			print "@spl_zs\n";
			$hits++;
			$gene_hits++;
			$entire++;
		}
	}
#		print " PAR::$hits\n";
		push(@fac,$hits."[[");
		$jofff = join(/ /,@fac);
	        $NU_DE{$nu_de} = $jofff;
#		print "JOJOJJ :: $jofff\n";
$hits = ();
@zsco = @zsco_full=();
}
@fac =();
@minsort = sort {$a <=> $b} @zsc_thre;
@maxsort=sort {$b <=> $a} @zsc_thre;
print "ZZZZZZZZSSSSSSSSOOOORRREEE :: @zsc_thre || $minsort[0] == $maxsort[0]\n";
@zsc_thre=();
$gene_hits = ();
undef(%hash);
}
=d
undef %seen1;
#print "@names\n";
@uniq_names = grep {! $seen1{$_} ++} @names;


for($i=0;$i<=$#uniq_names;$i++)
{
        foreach $nu_de (keys %NU_DE)
        {
#               print "$nu_de +++++++++++++++++ $NU_DE{$nu_de}\n";
                foreach ($nu_de)
                {
 #                      print "KKK$NU_DE{$nu_de}\n";
                        @splivalue = split(/\[\[/,$NU_DE{$nu_de});
                        foreach(@splivalue)
                        {
                        #       print "SSSSSSSSSSSS $_\n";
                                @spcal = split (/\*/,$_);
               #                 print "$spcal[0] }}}} $spcal[1] \n";
                                if($uniq_names[$i] eq $spcal[0])
                                {
                                        $sum += $spcal[1];
                                }
                        }
                }
        }
        print "TOTAL HITS OF A SINGLE GENE :: $uniq_names[$i] :: $sum\n";
                                $sum = 0;
#print "\n";
}




=d
		 if ($_ =~ /^>/)
	        {
        	        $key = $_;
	        }
        	elsif($_ =~/^Z-SCORE/)
	        {
        	        $hash{$key} .=$_;
                	$hash{$key} .="UUU";
	        }
	}
	
	foreach $key (keys %hash)
	{
#	print "$key ++++++++++ $hash{$key}\n";
	print "JJ$key\n";
	@sp=split(/UUU/,$hash{$key});
#	print "KKK@sp\n";
	foreach(@sp)
	{
		print "{{{{{{{$_\n";
		@split = split(/\s+|\t+|::/,$_);
                #print "!!!!!!!!@split\n";
                #print "~~~~~~~~~~~~~~~~~~~~~$split[2] ~~~~~~ $split[7]\n";
                #if($split[7] =~ /lit/)
                {
                       push(@zsco,$split[0]."Y".$split[2]."Y".$split[3]."Y".$split[4]."Y".$split[5]."Y".$split[6]."Y".$split[7]."*");
                       print "!!!!!!!@zsco\n";
                       push(@zsco_full,@zsco);
                }
	@zsco =();
	}
	}
		print "IIIIIIIIIII@zsco_full\n";
			$jo = join(/ /,@zsco_full);
		#print "JOJO :: $jo\n";
		if($jo =~ /lit/)
		{
	#		print "???????$key\n";
	#		print "AAAAAAA :: $jo\n";
			@spzsc= split(/\*/,$jo);
			foreach (@spzsc)
			{
				$allTF_oneseq++;
#				print "WWWWWWWWWW $_\n";
				@spspsp = split(/Y/,$_);
				#print "$spspsp[6] +++ $spspsp[1]\n";
				
				if($spspsp[6] =~ //)
				{
					$a++;
					$whole_library++;
					#print "PPPPP$_\n";
					@spspsp = split(/Y/,$_);
				#	print "$spspsp[0] ~~~~~ $spspsp[1]\n"
		#			print "$spspsp[0]=$spspsp[1]\t\t$spspsp[2]\t$spspsp[3]\t $spspsp[4] $spspsp[5]\t $spspsp[6]\n";
					push(@sort_list,$spspsp[1]);
				}
			}
#					print "SORT :@sort_list\n";
					@srting = sort {$b <=> $a} @sort_list;
					if($srting[1] != 0)
					{
			#			print "\nTOP 3 Z-SCORE RANKS ::$srting[0]  $srting[1]  $srting[2]\n";
					}
					@sort_list =();
			print " PAR :: $allTF_oneseq\n";

			$n=$a=0;
		}
		@zsco_full = ();
			print "ENTIRE ::  $whole_library\n";
	undef (%hash);
}
=d
		@split = split(/\s+|\t+|::/,$_);
		#print "!!!!!!!!@split\n";
		#print "~~~~~~~~~~~~~~~~~~~~~$split[2] ~~~~~~ $split[7]\n";
		#if($split[7] =~ /lit/)
		{
			push(@zsco,$split[0]."Y".$split[2]."Y".$split[3]."Y".$split[4]."Y".$split[5]."Y".$split[6]."Y".$split[7]."*");
#			print "!!!!!!!@zsco\n";	
			push(@zsco_full,@zsco);
		}
	}
		@zsco =();
	}
}
=d
#		print "IIIIIIIIIII@zsco_full\n";
			$jo = join(/ /,@zsco_full);
#		print "JOJO :: $jo\n";
		if($jo =~ /lit/)
		{
	#		print "$key\n";
#			print "AAAAAAA :: $jo\n";
			@spzsc= split(/\*/,$jo);
			foreach (@spzsc)
			{
				$allTF_oneseq++;
#				print "WWWWWWWWWW $_\n";
				@spspsp = split(/Y/,$_);
				#print "$spspsp[6] +++ $spspsp[1]\n";
				
				if($spspsp[6] =~ //)
				{
					$a++;
					$whole_library++;
					#print "PPPPP$_\n";
					@spspsp = split(/Y/,$_);
				#	print "$spspsp[0] ~~~~~ $spspsp[1]\n"
		#			print "$spspsp[0]=$spspsp[1]\t\t$spspsp[2]\t$spspsp[3]\t $spspsp[4] $spspsp[5]\t $spspsp[6]\n";
					push(@sort_list,$spspsp[1]);
				}
			}
#					print "SORT :@sort_list\n";
					@srting = sort {$b <=> $a} @sort_list;
					if($srting[1] != 0)
					{
			#			print "\nTOP 3 Z-SCORE RANKS ::$srting[0]  $srting[1]  $srting[2]\n";
					}
					@sort_list =();
			print " PAR :: $allTF_oneseq\n";

			$n=$a=0;
		}
		@zsco_full = ();
			print "ENTIRE ::  $whole_library\n";
}

=d
	if ($_ =~ /^>/)
	{
		$key = $_;
	}
	elsif($_ =~/^Z-SCORE/)
	{	
		$hash{$key} .=$_;
		$hash{$key} .="UUU";
	}
}

foreach $key (keys %hash)
{
	#print "$key ++++++++++ $hash{$key}\n";
	print "$key\n";
	@sp=split(/UUU/,$hash{$key});
#	print "KKK@sp\n";
}
	foreach(@sp)
	{
		#print "$_\n";
		@split = split(/\s+|\t+|::/,$_);
		#print "!!!!!!!!@split\n";
		#print "~~~~~~~~~~~~~~~~~~~~~$split[2] ~~~~~~ $split[7]\n";
		#if($split[7] =~ /lit/)
		{
			push(@zsco,$split[0]."Y".$split[2]."Y".$split[3]."Y".$split[4]."Y".$split[5]."Y".$split[6]."Y".$split[7]."*");
#			print "!!!!!!!@zsco\n";	
			push(@zsco_full,@zsco);
		}
		@zsco =();
	}
#		print "IIIIIIIIIII@zsco_full\n";
			$jo = join(/ /,@zsco_full);
#		print "JOJO :: $jo\n";
		if($jo =~ /lit/)
		{
			print "$key\n";
#			print "AAAAAAA :: $jo\n";
			@spzsc= split(/\*/,$jo);
			foreach (@spzsc)
			{
				$allTF_oneseq++;
#				print "WWWWWWWWWW $_\n";
				@spspsp = split(/Y/,$_);
				#print "$spspsp[6] +++ $spspsp[1]\n";
				
				if($spspsp[6] =~ //)
				{
					$a++;
					$whole_library++;
					#print "PPPPP$_\n";
					@spspsp = split(/Y/,$_);
				#	print "$spspsp[0] ~~~~~ $spspsp[1]\n"
					print "$spspsp[0]=$spspsp[1]\t\t$spspsp[2]\t$spspsp[3]\t $spspsp[4] $spspsp[5]\t $spspsp[6]\n";
					push(@sort_list,$spspsp[1]);
				}
			}
#					print "SORT :@sort_list\n";
					@srting = sort {$b <=> $a} @sort_list;
					if($srting[1] != 0)
					{
			#			print "\nTOP 3 Z-SCORE RANKS ::$srting[0]  $srting[1]  $srting[2]\n";
					}
					@sort_list =();
			print " PAR :: $allTF_oneseq\n";

			$n=$a=0;
		}
		@zsco_full = ();
}
			print "ENTIRE ::  $whole_library\n";
