open ZSCO,"$ARGV[0]"  || die "type x.pl zscore_file\n";
@zs = <ZSCO>;
close (ZSCO);

print "Type the threshold value ::";
$thre =<STDIN>;

foreach(@zs)
{
	chomp($_);
	if($_ =~ /^Z-SCORE/)
	{
		@spl = split(/::|\s+|\t+/,$_);
		print "$spl[2]\n";
		 if($spl[2] > $thre)
                {
             #           print "GRE :: $spl[2]\n";
			$all_gre_2 ++ ;
			if($spl[7] =~ /lit/)
                	{
        	                $tp++;
	                }
                }
		if($spl[7] =~ /lit/)
		{
			$tot_val++;
		}
	}
}

print "TOTAL VALIDATED HITS :: $tot_val\n";
print "TRUE POSITIVES ::$tp\n";
$fp=$all_gre_2 - $tp;
print "FALSE POSITIVES ::$fp \n";
$fn = $tot_val-$tp;
print "FALSE NEGATIVES::$fn\n";

$cov = $tp/$tot_val;
print "COVERAGE :: $cov\n";

$spec = $tp/($tp+$fp);
print "SPECIFICITY :: $spec\n";

$sensi = $tp/($tp+$fn);
print "SENSITIVITY :: $sensi\n";



