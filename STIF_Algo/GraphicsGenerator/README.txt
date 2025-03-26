Script to generate the TFmap is in same directory. 
Please install all Perl modules required for the files: 
Bio::Perl/Bio::Graphics 

Please run it as perl Stifdb_tfmap_current.pl start end inputfilename.txt

Where:
start = start coordinate
end = end coordinate
inputfilename.txt = output from STIF program. This should be in name of
gene AT000000.

You can get the plot by redirecting output to a PNG file as in

perl Stifdb_tfmap_current.pl start end AT000000_UPS_stif_out.txt >
AT000000_UPS.png