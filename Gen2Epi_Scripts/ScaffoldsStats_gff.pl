#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use strict;
use warnings;

my $In = $ARGV[0];
my $genomePath = $ARGV[1];

open(FILE,$In);
open (OUT,">>","GenomeStats.txt");
print OUT "samples\tN50\tGenFra\tCompGene\tPartgene\tNA50\n";
open (OUT1,">>","GenomeStats1.txt");
print OUT1 "samples\tNGA50\n";

	while(my $file =<FILE>){
	chomp($file);
	my($ID,$Extra) = split /\t/,$file;
	open(FILE1,"$genomePath/$ID/combined_reference/report.txt");
	while(my $rep =<FILE1>){
	chomp($rep);
	if ($rep =~ m/Assembly/){
	$rep =~ s/Assembly\s+//g;
        $rep =~s/_scaffolds//g;
	print OUT "$rep\t";
	}	
	elsif ($rep =~ m/N50/){
	$rep =~ s/N50\s+//g;
	$rep =~ s/\s*$//;
	print OUT "$rep\t";
	}
	elsif ($rep =~ m/Genome fraction/){
        $rep =~ s/Genome fraction \(\%\)\s+//g;
	$rep =~ s/\s*$//;
	print OUT "$rep\t";
	}
	elsif ($rep =~ m/NA50/){
	$rep =~ s/NA50\s+//g;
	$rep =~ s/\s*$//;
	print OUT "$rep\n";
	}
	elsif ($rep =~ m/# genes/){
	$rep =~ s/# genes\s+//g;
	$rep =~ s/part//g;
	my($com,$par) = split(/\+/,$rep);
	$com =~ s/\s*$//;
	$par=~ s/\s*$//;
	print OUT "$com\t$par\t";
	}}	

	open(FILE2,"$genomePath/$ID/summary/TXT/NGA50.txt");
        while(my $rep1 =<FILE2>){
        chomp($rep1);
	if ($rep1 =~ m/Assemblies/){
	$rep1 =~ s/Assemblies//g;
        $rep1 =~s/_scaffolds//g;
	$rep1 =~s/^\s+//g;
	$rep1 =~ s/\s*$//;
        print OUT1 "$rep1\t";
	}
	elsif ($rep1 =~ m/NCCP11945_NG/){
	$rep1 =~ s/NCCP11945_NG\s+//g;
	$rep1 =~ s/\s*$//;
        print OUT1 "$rep1\n";
	}}
	}
system "Rscript Parse.R";
system "rm -rf GenomeStats.txt\n";
system "rm -rf GenomeStats1.txt\n";
