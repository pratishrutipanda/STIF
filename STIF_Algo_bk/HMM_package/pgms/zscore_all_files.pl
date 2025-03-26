#!/usr/bin/perl

$perl_script = $ARGV[0];

opendir DIR,"$ARGV[1]";

@dir = <DIR>;

while ($i = readdir(DIR))
{
        if($i =~ /(\w+.?\w+)_valid.outout\d*/)

        {
              print "SS :: $i :: $1\n";
              $file_name = $1;
              $cmd1 = "perl $perl_script\/zscore.pl $ARGV[1]\/$i $ARGV[1] \> $ARGV[1]\/$file_name\.zsco";
              # print "$cmd1\n";
              system($cmd1);

              $n++;
        }
}
print "CNT :: $n\n";
closedir(DIR);

