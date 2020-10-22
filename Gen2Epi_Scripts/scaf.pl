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

	open(HAS,$In);
	while(my $has = <HAS>){
	chomp($has);
	opendir(DIR,$Path); 
	while(my $dir = readdir(DIR)){
		chomp($dir);
		next if ($dir =~m/^\./);
		next if ($dir =~m/.blastn/);
		next if ($dir =~m/.bestHits.txt/);
		if ($dir =~ m/$has/){
		opendir(FAS,"$Path/$dir");
		while(my $fas = readdir(FAS)){
		chomp($fas);
		next if ($fas =~m/^\./);
		if($fas =~m /.fasta/){
		my $Fas = $fas;
		$Fas =~ s/.fasta//g;
			if (!-d "$Path/$dir/$Fas"){
			system "mkdir $Path/$dir/$Fas\n";}
		my $rcp = $fas;
		$rcp =~ s/.fasta/.rcp/g;
		system "ragout.py $Path/$dir/$rcp --refine -t $th -o $Path/$dir/$Fas\n";
			}	}	
	}	}
}

