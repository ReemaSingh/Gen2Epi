#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use strict;
use warnings;

my $dir = $ARGV[0];
my $str = $ARGV[1];

open(OUT,">Test_Inp");
opendir(DIR,$dir);

while(my $files = readdir(DIR)){
chomp($files);
next if ($files =~m/^\./);
my $name = substr($files,0,$str);
print OUT "$name\t$files\n";
system "sort Test_Inp >Test_Inp1";
my $cmd1 = 's != $1 || NR ==1{s=$1;if(p){print p};p=$0;next} {sub($1,"",$0);p=p""$0;}END{print p}';
my $sp = '-F " "';
system "awk $sp '$cmd1' Test_Inp1 >Prepare_Input.txt\n";
}
system "rm -rf Test_Inp\n";
system "rm -rf Test_Inp1\n";

