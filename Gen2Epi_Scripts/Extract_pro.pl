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
		if ($ngstar =~ m/_partial_hit_merger/){
			my $Rev = $ngstar;
			$Rev =~ s/_partial_hit_merger/.fasta/g;
			open(HAS,"$dir/$ngstar");
			while(my $has = <HAS>){
	        	chomp($has);
			my($gene,$sample,$id,$len,$mis,$gap,$qs,$qe,$ss,$se,$eval,$score,$a,$b,$c,$d,$e,$f,$g,$h,$i,$j,$k)= split("\t",$has);
			#print "$Rev\t$gene\t$sample\t$ss\t$se\t$h\t$i\n";
			my $Revv = join("-",$gene,$Rev);
			#print "$Revv\n";
			my $Rev1 = $Revv;
		        $Rev1 =~ s/.fasta/_Rev.fasta/g;

	###### Case1 (Positive Strand) 
			if (($ss < $se) and ($h < $i)){
				if (($ss < $h) and ($se < $i)) {
					my $regions = join (":",$ss,$i);
				system "extractseq -sequence $PATH/$Rev -regions $regions -outseq $dir/$Revv\n";
				}
				elsif (($ss > $h) and ($se < $i)){
					my $regions = join (":",$h,$i);
				system "extractseq -sequence $PATH/$Rev -regions $regions -outseq $dir/$Revv\n";
				}
				elsif (($ss < $h) and ($se > $i)){
					my $regions = join (":",$ss,$se);
				system "extractseq -sequence $PATH/$Rev -regions $regions -outseq $dir/$Revv\n";
				}
				elsif (($ss > $h) and ($se > $i)){
					my $regions = join (":",$h,$se);
				system "extractseq -sequence $PATH/$Rev -regions $regions -outseq $dir/$Revv\n";
				}		
			}
	##### Case2 (Negative Strand)
			if (($ss > $se) and ($h > $i)){
				if (($ss > $i) and ($ss > $h)){
					my $regions = join (":",$i,$ss);
				system "extractseq -sequence $PATH/$Rev -regions $regions -outseq $dir/$Revv\n";
				system "revseq -sequence $dir/$Revv -outseq $dir/$Rev1\n" ;
				system "rm -rf $dir/$Revv\n";
				}
				elsif (($ss > $i) and ($ss < $h)){
					my $regions = join (":",$i,$h);
				system "extractseq -sequence $PATH/$Rev -regions $regions -outseq $dir/$Revv\n";
				system "revseq -sequence $dir/$Revv -outseq $dir/$Rev1\n" ;
				system "rm -rf $dir/$Revv\n";
				}
				elsif (($ss < $i) and ($ss < $h)){
					my $regions = join (":",$se,$h);
				system "extractseq -sequence $PATH/$Rev -regions $regions -outseq $dir/$Revv\n";
				system "revseq -sequence $dir/$Revv -outseq $dir/$Rev1\n" ;
				system "rm -rf $dir/$Revv\n";
                                }
			}				
}}}
