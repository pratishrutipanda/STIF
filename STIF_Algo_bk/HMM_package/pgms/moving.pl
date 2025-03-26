#!/usr/bin/perl

opendir DIR,".";
@dir = <DIR>;

while ($i = readdir(DIR))
{
        if($i =~ /(\w+)_full\d*/)
        {
                print "SS :: $i :: $1\n";
                `mv $i $1_full`;
                $n++;
        }
}
print "CNT :: $n\n";
closedir(DIR);
