#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use warnings;
use strict;

my $dir =$ARGV[0];
my $PATH = $ARGV[1];
	opendir(DIR,$dir);
	while(my $ngstar = readdir(DIR)){
	chomp($ngstar);
	next if ($ngstar =~m/^\./);
		if ($ngstar =~ m/_NgSTAR.blastn/){
		my $OUT = $ngstar;
		$OUT =~ s/_NgSTAR.blastn/_bbhits/g;
		system "sort -k1,1 -k12,12gr -k11,11g -k3,3gr $dir/$ngstar |sort -u -k1,1 --merge >$dir/$OUT\n";
}}

	opendir(DIR1,$dir);
        while(my $ngstar1 = readdir(DIR1)){
        chomp($ngstar1);
        next if ($ngstar1 =~m/^\./);
	if($ngstar1 =~ m/_bbhits/){
	my $Rev = $ngstar1;
        $Rev =~ s/_bbhits/.fasta/g;
	open(HAS,"$dir/$ngstar1");
	while(my $has = <HAS>){
	chomp($has);
	my($gene,$sample,$id,$len,$mis,$gap,$qs,$qe,$ss,$se,$eval,$score) = split("\t",$has);
	my $Revv = join("-",$gene,$Rev);
	my $Rev1 = $Revv;
	$Rev1 =~ s/.fasta/_Rev.fasta/g;
	my $regions = join(":",$ss,$se);
		if ($ss > $se){
			my $regions1 = join(":",$se,$ss);
			system "extractseq -sequence $PATH/$Rev -regions $regions1 -outseq $dir/$Revv\n";
			system "revseq -sequence $dir/$Revv -outseq $dir/$Rev1\n" ;
			system "rm -rf $dir/$Revv\n";
		}
		elsif ($ss < $se){
			system "extractseq -sequence $PATH/$Rev -regions $regions -outseq $dir/$Revv\n";	
	}
	
  }
}
}
