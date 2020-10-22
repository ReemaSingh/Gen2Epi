#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use warnings;
use strict;

my $dir =$ARGV[0];
open(OUT,">","NgMLST.txt");
print OUT "Sample\tST\tabcZ\tadk\taroE\tfumC\tgdh\tpdhC\tpgm\tclonal_complex\n";

opendir(DIR,$dir);
while(my $mlst = readdir(DIR)){
chomp($mlst);
next if ($mlst =~m/^\./);
if ($mlst =~ m/_pubMLST.txt/){
open(FILE,"<$dir/$mlst");
while (my $line = <FILE>){
if($line =~ /ST/){
my $line1 = <FILE>;
chomp($line1);
my($st,$abcZ,$adk,$aroE,$fumC,$gdh,$pdhC,$pgm,$clonal_complex) = split(" ",$line1);
print OUT "$mlst\t$st\t$abcZ\t$adk\t$aroE\t$fumC\t$gdh\t$pdhC\t$pgm\t$clonal_complex\n";
}
}
}}
