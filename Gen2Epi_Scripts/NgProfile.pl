#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use warnings;
use strict;

my $dir =$ARGV[0];
my $al = $ARGV[1];
#system "makeblastdb -in $al -dbtype nucl\n";
        opendir(DIR,$dir);
        while(my $ngstar = readdir(DIR)){
        chomp($ngstar);
        next if ($ngstar =~m/^\./);
                if ($ngstar =~ m/.fasta/){
		my $OUT = $ngstar;
		$OUT =~ s/.fasta/_profile_blastn/g;
		system "blastn -query $dir/$ngstar -db $al -out $dir/$OUT -outfmt 6 -max_target_seqs 1\n";
	}
}
print "NgSTAR allele search finish\n";

print "Now Parsing the output files\n";

	opendir(DIR1,$dir);
	while(my $ngstar1 = readdir(DIR1)){
	chomp($ngstar1);
	next if ($ngstar1 =~m/^\./);
		if ($ngstar1 =~ m/_profile_blastn/){
		open(FILE,"$dir/$ngstar1");
		while (my $has =<FILE>){
		chomp($has);
		my ($sample,$gene,$extra) = split("\t",$has);
		open( my $profile,">>","NgStar-Profile.txt");
		print $profile "$sample\t$gene\n";
}}
}
my $cmd = 'push @{$k{$F[0]}},$F[1];END{$"=", ";print "$_ @{$k{$_}}" for sort keys(%k)}';
system "perl -lane '$cmd' NgStar-Profile.txt >NgStarGenAllele_Profile\n";
system "rm -rf NgStar-Profile.txt\n";
