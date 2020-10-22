#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use strict;
use warnings;

my $In = $ARGV[0];
my $Path = $ARGV[1];
my $th = $ARGV[2];
my $db = $ARGV[3];

##### Scaffolding

	my $OUT1 = "Plasmid_Scaffolds_C1";
	if (!-d $OUT1){
	system "mkdir $OUT1\n";}

	open(HAS,$In);
	while(my $line = <HAS>){
	chomp($line);
	my($has,$pair1,$pair2) = split /\t/,$line;
	my $out = $has;
	$out = join (".",$has,"blastn");
	system "blastn -query $Path/$has/contigs.fasta -db $db -out $OUT1/$out -num_threads $th -num_descriptions 1 -num_alignments 1\n";
 	}
