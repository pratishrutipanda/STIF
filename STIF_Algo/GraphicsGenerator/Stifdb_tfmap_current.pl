#!/net/bin/perl -w
# Authors: K Shameer & R Sowdhamini 
# Modified version of BLAST output visualization program from BioPerl::HOWTO (2007 
# Edited 2008 
# Edited & adapted 2010 for 20q project  
# SK / For TFMAP Project 
# start  / end / input_filename as input

use strict;
use Bio::Graphics;
use Bio::SeqFeature::Generic;
my $start_in = shift; 
my $end_in = shift; 
my $start = $start_in + '-100';
my $end = $end_in + '100'; 
# Start / End of the scale track
my $full_length = Bio::SeqFeature::Generic->new(-start=>$start,-end=>$end, );
# img_canvas
my $panel = Bio::Graphics::Panel->new(-length => 300,
				      -width  => 800,
				      -pad_top => 10,
				      -pad_bottom =>10, 	
				      -pad_left => 10,
				      -pad_right => 10,
				      -key_style => 'left',
				      -grid => 'true',	
				      -gridcolor => 'lightcyan',
				      -segment => $full_length,
			              -label => "TFmap",		 
				     );
# _end_img_canvass 

# Scale Parameters : 
$panel->add_track($full_length,
		  -glyph   => 'arrow',
		  -hilite  => 'yellow',
		  -tick    => 2,
		  -double  => 2,
		  -linewidth => 1,
		 );
# _end_Scale_Parameters

#TF track 
my $track = $panel->add_track(
			      -label => 1,	 	
			      -glyph => 'generic',
			      -fgcolor=>'brown',	 	
			      -bgcolor => 'brown',	
			      -font2color => 'red',	
			      -height => 11,
			      -sort_order => 'low_score',
			      -description => sub {
                              my $feature = shift;
                              my $score   = $feature->score;
                              return "Z-Score = $score";
 						   } );

while (<>) { # read blast file
  chomp;
  next if /^\#/;  # ignore comments
  my($name,$score,$start,$end) = split /\s+/;
  my $feature = Bio::SeqFeature::Generic->new(-display_name=> $name,
					      -score       => $score,
					      -start       => $start,
					      -end         => $end,
					      -sort_order  => 'low_score'
);
  $track->add_feature($feature);
}

print $panel->png;