#!/usr/bin/perl

open FILE, "$ARGV[0]" || die "Type 'perl x.pl input_of_sep_seq.pl'\n";
@file = <FILE>;
close (FILE);

`mkdir seq_files`;

foreach (@file)
{
        chomp ($_);
        if($_ =~/^COUNT/)
        {
#               print "KKKKKKKKKKKK :: $_\n";
                $files = "set".$c.".seq";             #name of the files + its increment
                $out="LL".$c;                  #Defining output in string variable
                open"$out",">seq_files/$files";
                $c++;
#                print $out "$_\n";
        }
        else 
        {
                print $out "$_\n";
        }
}

print "The outputs are on the 'seq_files' sub-directory\n";
