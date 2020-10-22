#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use strict;
use warnings;

my $In = $ARGV[0];
my $genomePath = $ARGV[1];
my $Path = $ARGV[2];

my $OUT = "Plasmid_Scaffolds_C1";
        if (!-d $OUT){
        system "mkdir $OUT\n";}

opendir(DIR, $genomePath);
while (my $dir = readdir(DIR)){
	chomp($dir);
	next if ($dir =~m/^\./);
	my $name = $dir;
	$name =~ s/.fasta//g;
	my $ID = $name;
	$ID =~ s/_.*//g;
	open(OUT, ">", "$OUT/$name.rcp");
	print OUT ".references = $name\n.target = contigs\n\n$dir=$genomePath/$dir\ncontigs.fasta=$Path/$ID/contigs.fasta ";
}


