#!/usr/local/bin/perl

#### This program creates JackKnifing models for given consensus sequence ####
#### Input file should contain consensus sequence alone####

#system("clear");
open(FILE,"$ARGV[0]") || die "******TYPE perl JACKkniff_hmm.pl x.con******\n";
foreach (<FILE>)
{
	chomp($_);				# each line of consensus 
	@temp=split(//,$_);			# splting into each letters
	$lencol=length();			# length of each line
	for(my $j=0;$j<$lencol;$j++)
	{
		$mat[$row][$j]=$temp[$j];	# consensus into 2D array, $temp[$j]= $mat[$j]
	}
	$row++;					# $row == row is incremented
}
for($i=0;$i<$row;$i++)
{
	for($j=0;$j<$lencol;$j++)
	{
		print "$mat[$i][$j]";		# printing all consus seq
	}	
	print "\n";
}

$obs_prob=1;
for($k=0;$k<$row;$k++)
{
#	print "KKKKKKKKKKKKKKKKKK :: $k\n";
	for($j=0;$j<$lencol;$j++)
	{
#		print "JJJJJJJJJJJJJ :: $j\n";
		for($i=0;$i<$row;$i++)
		{
#			print "IIIIIIIIIIIIII :: $i\n";
			if($i!=$k)
			{
#			print "INNNNNNININNNNIININII :: $i\n";
				if( $mat[$i][$j] eq 'A')
				{
					$a++;
				}
				elsif($mat[$i][$j] eq 'C')
				{
					$c++;
				}
				elsif($mat[$i][$j] eq 'G')
				{
					$g++;
				}
				elsif($mat[$i][$j] eq 'T')
				{
					$t++;
				}
				#print "AA:: $a\t CC :: $c\t GG :: $g\t TT :: $t\n";
			}
		}
		
		$score[0][$j]=$a/($row-1);
		$score[1][$j]=$c/($row-1);
		$score[2][$j]=$g/($row-1);
		$score[3][$j]=$t/($row-1);
		
		$a=$c=$g=$t=0;
	}
#	print "\n";

	for($i=0;$i<$row;$i++)
	{
		if($i!=$k)
		{
        		for(my $j=0;$j<$lencol;$j++)
			{
#		print "JJJJJJJJJJJJJJJ ::$j\n";
        	        	if($mat[$i][$j] eq 'A')
	        	        {
        	        	        $freq=$score[0][$j];
					$AT++; 
	                	}
		                elsif($mat[$i][$j] eq 'C')
        		        {
                		        $freq=$score[1][$j];
					$GC++; 
		                }
        		        elsif($mat[$i][$j] eq 'G')
                		{
                        		$freq=$score[2][$j];
					$GC++; 
		                }
        		        else
	        	        {
                        		$freq=$score[3][$j];
					$AT++; 
	                	}
			#	print "FREEEQQQ::";
				$freq+=1;				
	        	       	printf "%6.2f",$freq;
				$obs_prob*=$freq;
			#	print "$obs_prob\t";

        		 }
			$apriori=$AT*(log(0.375))+$GC*(log(0.125));
		        $score = log($obs_prob) - $apriori;
		        print "\t $score || || || $lencol\t";
			$normal = $score/$lencol;
			print "\t =$normal\n";
			push (@jscorr,$normal);
		        $score=0;
			$AT=$GC=0;
        		$obs_prob=1;
		}
		else 
		{
			next;	
		}
	}
print "************************************************************************\n";
}

 
@jsortmin=sort{$a <=> $b} @jscorr;
print "THRESHOLD of JACKKNIFING MODELS ::";# `$jsortmin[0]
printf "%4.4f", $jsortmin[0];
@jsortmax=sort{$b <=> $a} @jscorr;
print "\nMAXIMUM of JACKKNIFING MODELS ::";#$jsortmax[0]\n";
printf "%4.4f", $jsortmax[0];
print "\n";
