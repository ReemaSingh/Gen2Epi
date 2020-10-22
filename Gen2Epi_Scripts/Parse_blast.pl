#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use strict;
use warnings;

my $dir = $ARGV[0];
	opendir(DIR,$dir) or die $!;
	while(my $has = readdir(DIR)){
	chomp($has);
	next if ($has =~m/^\./);
	if($has =~ m/.blastn$/){
	#system "chmod 755 $has\n";
	my $out = $has;
	$out =~ s/.blastn/_bestHits.txt/;
	open(OUT,">", "$out");
	open(FILE,"$dir/$has") or die $!; 
	while(my $line = <FILE>){
	chomp($line);

	my $pat= "Query=";
	my $hit = ">";
	my $desc = "Neisseria";
	my $pla = "plasmid";
	
	if ($line =~ /$hit/ || $line =~ /$pat/){	
	my $search = $line;
	my ($query,$hit) = split />/,$search;
	$hit||= "";
	$query =~ s/_cov.*//g;
	$query =~ s/Query=//g;
	$query =~ s/^\s//g;
		if ($hit =~ /$pla/ and $hit =~ /$desc/){
			print OUT "$hit\n";
		}
}
}
system "sort -u $out >$dir/$out\n";
system "rm -rf $out\n";
}}
