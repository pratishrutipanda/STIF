#!/usr/bin/perl

use strict;
use warnings;

# Checking command line arguments
my $runs = shift or die "Usage: $0 <runs> <normal_input> <cur_working_dir>\n";
my $normal_input = shift or die "Usage: $0 <runs> <normal_input> <cur_working_dir>\n";
my $cur_working_dir = shift or die "Usage: $0 <runs> <normal_input> <cur_working_dir>\n";

open(INTF, "<", $normal_input) or die "Cannot open $normal_input: $!\n";

my $new_gene_flg = 0;
my %tf_colors_dict = ();

open(COLCONF, "tf_colors_conf.tsv.csv") or die "Cannot open tf_colors_conf.tsv.csv: $!\n";

my @tf_col_array = ();
while (my $col_line = <COLCONF>) {
    chomp($col_line);
    my ($tf_name, $tf_color) = split(/\t/, $col_line);
    $tf_colors_dict{$tf_name} = $tf_color;
}
close(COLCONF);

my $run_count = 0;

while (my $line = <INTF>) {
    chomp($line);
    
    if ($line =~ /^\*\*\*/) {
        $new_gene_flg = 1;
        next;
    }

    if ($new_gene_flg == 1) {
        my @gene_lines = ();
        push(@gene_lines, $line);
        
        if ($line =~ /^____/) {
            if (scalar(@gene_lines) < 2) {
                next;
            }
            
            print "Gene\tTF_Name\tZ-Score\tStart\tEnd\n";
            
            my $gene_id;
            my $gene_tf_name;
            my $start_main = 999999;
            my $end_main = -999999;
            my @zscore_lines = ();
            
            foreach my $gene_line (@gene_lines) {
                if ($gene_line =~ />/) {
                    @zscore_lines = ();
                    my @tmp_d = split(/\|/, $gene_line);
                    $gene_tf_name = $tmp_d[-1];
                    $gene_tf_name =~ s/\s*//;
                    
                    my ($chr, $pos) = split(/:/, $tmp_d[1]);
                    $chr =~ s/\s*//;
                    $pos =~ s/(FORWARD|REVERSE)//;
                }
                if ($gene_line =~ /Z-SCORE/) {
                    push(@zscore_lines, $gene_line);
                }
                if ($gene_line =~ /NORMALISATION/) {
                    foreach my $zscore_line (@zscore_lines) {
                        my @zscore_vals = split(/\s/, $zscore_line);
                        my ($zscore_start, $zscore_end) = split(/to/, $zscore_vals[3]);
                        if ($zscore_start < $start_main) {
                            $start_main = $zscore_start;
                        }
                        if ($zscore_end > $end_main) {
                            $end_main = $zscore_end;
                        }
                        
                        print "$gene_id\t$gene_tf_name\t$zscore_vals[1]\t$zscore_start\t$zscore_end\n";
                    }
                }
            }
            
            $start_main += -200;
            $end_main += 200;
            
            $run_count++;
            last if ($runs != 0 and $run_count == $runs);
            
            $new_gene_flg = 0;
        }
    }
}

close(INTF);
print "DONE\n";
