#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use warnings;
use strict;

my $file =$ARGV[0];
open (OUT,'>>', "NgMAST.txt");
open(FILE,$file);
print OUT "Samples\tNgMAST\tPOR\tTBPB\n";
while(my $line = <FILE>){
if ($line =~ /ID/){
my $line1 = <FILE>;
chomp($line1);
my ($name,$NgMAST,$POR,$TBPB) = split("\t",$line1);
my $samples = $name;
$samples =~ s/^.*\///g;
print OUT "$samples\t$NgMAST\t$POR\t$TBPB\n";
}}
