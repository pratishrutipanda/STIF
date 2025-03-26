#!/usr/bin/perl

#use Bio::Graphics;
#use Bio::SeqFeature::Generic;

$runs = shift;
$normal_input = shift;
$cur_working_dir = shift;

open(INTF, "$normal_input");

$new_gene_flg = 0;
$new_tf_flg = 0;

my %tf_colors_dict = ();

open(COLCONF, "tf_colors_conf.tsv.csv");

@tf_col_array = ();
while ($col_line = <COLCONF>)
    {
    chomp($col_line);
    ($tf_name, $tf_color) = split(/\t/, $col_line);
    push(@tf_col_array, $tf_name);
    push(@tf_col_array, $tf_color);
    }
close(COLCONF);

%tf_colors_dict = @tf_col_array;

$run_count = 0;

while ($line = <INTF>)
	{
        print '>>>>>>lll';
        chomp($line);
        print $line;
	if ($line =~ /^\*\*\*/)	
		{
                $new_gene_flg = 1;
                @gene_lines = ();
		#print $line;
		}
        if ($new_gene_flg == 1)
            {
            push(@gene_lines, $line);
            }
        if ($line =~ /^____/)	
		{
                if (length(@gene_lines) < 2) {
                    print "<<<<<<<", "\n";
                    next;
                }
                
                open(TOFH, ">>$cur_working_dir/tab_output.tsv");
                print TOFH "Gene\t TF_Name\t Z-Score\t Start\t End\n";
                @gene_feature_collection = ();
                $new_gene_flg = 0;
                $gene_id = $gene_lines[0];
                $gene_id =~ s/\*//g;
                #print $gene_id;
                $start_main = 999999;
                $end_main = -999999;
                foreach $gene_line (@gene_lines)
                    {
                    #print "$gene_line\n";
                    if ($gene_line =~ />/)
                        {
                        $new_tf_flg = 1;
                        @zscore_lines = ();
                        @tmp_d = split(/\|/, $gene_line);
                        $gene_tf_name = $tmp_d[-1];
                        $gene_tf_name =~ s/\s*//;
                        
                        ($chr, $pos) = split(/:/, $tmp_d[1]);
                        $chr =~ s/\s*//;
                        $pos =~ s/(FORWARD|REVERSE)//;
                        
                        #($start, $end) = split(/-/, $pos);
                        #$start =~ s/\s*//;
                        #$end =~ s/\s*//;
                        }
                    if ($gene_line =~ /Z-SCORE/)
                        {
                        push(@zscore_lines, $gene_line);
                        }
                    if ($gene_line =~ /NORMALISATION/)
                        {
                        $new_tf_flg = 0;
                        foreach $zscore_line (@zscore_lines)
                            {
                            @zscore_vals = split(/\s/, $zscore_line);
                            ($zscore_start, $zscore_end) = split(/to/, $zscore_vals[3]);
                            if ($zscore_start < $start_main)
                                {
                                $start_main = $zscore_start;
                                }
                            if ($zscore_end > $end_main)
                                {
                                $end_main = $zscore_end;
                                }
                            
                            print TOFH $gene_id, "\t", $gene_tf_name, "\t", $zscore_vals[1], "\t", $zscore_start, "\t", $zscore_end, "\n";
                            
                            # my $feature = Bio::SeqFeature::Generic->new(-display_name=> $gene_tf_name,
                            #                                             -score       => $zscore_vals[1],
                            #                                             -start       => $zscore_start,
                            #                                             -end         => $zscore_end,
                            #                                             -sort_order  => 'low_score'
                            #                                             );
                            # #print "$gene_tf_name\t $zscore_start \t $zscore_end\n";
                            push(@gene_feature_collection, $feature);
                            }
                        #$track->add_feature($feature);
                        }
                    }
                
                
                $start_main = $start_main + '-200';
                $end_main = $end_main + '200';
                #print "$gene_id \t $start_main \t $end_main\n";
                # Start / End of the scale track
                #my $full_length = Bio::SeqFeature::Generic->new(-start=>$start_main,-end=>$end_main, );
                # img_canvas
                # my $panel = Bio::Graphics::Panel->new(-length => 300,
                #                                       -width  => 800,
                #                                       -pad_top => 10,
                #                                       -pad_bottom =>10, 	
                #                                       -pad_left => 10,
                #                                       -pad_right => 10,
                #                                       -key_style => 'left',
                #                                       -grid => 'true',	
                #                                       -gridcolor => 'lightcyan',
                #                                       -segment => $full_length,
                #                                       -label => "TFmap",		 
                #                                      );
                # _end_img_canvass 
                
                # Scale Parameters : 
                # $panel->add_track($full_length,
                #                   -glyph   => 'arrow',
                #                   -hilite  => 'yellow',
                #                   -tick    => 2,
                #                   -double  => 2,
                #                   -linewidth => 1,
                #                  );
                # _end_Scale_Parameters

                #TF track
                #print $gene_id, "\n";
                # foreach $gene_feature(@gene_feature_collection)
                #     {
                #     $tf_n = $gene_feature->display_name();
                #     if (exists $tf_colors_dict{$tf_n})
                #         {
                #         $fg_color = $tf_colors_dict{$tf_n};
                #         #print "$tf_n\t $fg_color\n";
                #         }
                #     else
                #         {
                #         #print "COLOR MISSING FOR $tf_n\n";
                #         }
                #     #print "\t", $tf_n, ">>>Color>>$fg_color\n";
                #     $track = $panel->add_track(
                #               -label => 1,	 	
                #               -glyph => 'generic',
                #                 -fgcolor=> $fg_color,	 	
                #                 -bgcolor => $fg_color,	
                #                 -font2color => 'red',
                #               -height => 11,
                #               -sort_order => 'low_score',
                #               -description => sub {
                #               my $feature = shift;
                #               my $score   = $feature->score;
                #               return "Z-Score = $score";
                #                                    } );
                #     $track->add_feature($gene_feature);
                #     }
                #print "OOMM"."_100.png\n";
                #print $panel->png;
                #open(OUTTF, "OMM"."_100.png");
                #print OUTTF $panel->png;
                #close(OUTTF);
                #$panel->finished;
                
                $run_count++;
                if (($runs != 0) and ($run_count == $runs))
                    {
                    last;
                    }                
		}
        close(TOFH);
	}
close(INTF);
print "DONE";

