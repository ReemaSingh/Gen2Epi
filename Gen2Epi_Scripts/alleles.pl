#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use warnings;
use strict; 

my $dir2 = $ARGV[0];
opendir(DIR2,$dir2);
while(my $line2 = readdir(DIR2)){
chomp($line2);
next if ($line2 =~m/^\./);
if ($line2 =~ m/_nucl_MLSTSeqID_alleles/){
my $OUT1= $line2;
$OUT1 =~ s/_nucl_MLSTSeqID_alleles/.txt/g;
open my $OUT , '>',"MLST/$OUT1" || die "$!";
open(FILE2,"$dir2/$line2");
while (my $ab =<FILE2>){
chomp($ab);
my($first,$sec,$extra) = split("\t",$ab);
my ($g,$n) = split("_",$sec);
my $all = "$g\t$n\n";
print $OUT $all;
}
}
}

