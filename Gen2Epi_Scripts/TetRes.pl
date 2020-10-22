#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use strict;
use warnings;

my $In = $ARGV[0];
my $NuclSeq = $ARGV[1];
my $tet = "TetResOut";

system "rm -rf $tet\n";
if (!-d $tet){
                system "mkdir $tet\n";}

	opendir(DIR,$NuclSeq);
	while(my $dir = readdir(DIR)){
		chomp($dir);
		if($dir =~ /_scaffolds_nucl.fasta/){
		my $out = $dir;
		$out =~ s/_scaffolds_nucl.fasta/.tblastn/g;
		my $out1 = $out;
		$out1 =~ s/.tblastn/_tblastnFMT/g;
		system "makeblastdb -in $NuclSeq/$dir -dbtype nucl\n";
		system "tblastn -query $In -db $NuclSeq/$dir -out $tet/$out -num_alignments 1\n";
		system "tblastn -query $In -db $NuclSeq/$dir -out $tet/$out1 -outfmt 6 -max_target_seqs 1\n";
		}
}
system "rm -rf $NuclSeq/*.nsq\n";
system "rm -rf $NuclSeq/*.nin\n";
system "rm -rf $NuclSeq/*.nhr\n";

	opendir(DIR1,$tet);
	while (my $has = readdir(DIR1)){
	chomp($has);
	next if ($has =~m/^\./);
	if ($has =~m/_tblastnFMT/){
	my $name = $has;
	$name =~ s/_tblastnFMT//g;
	system "cut -f2 $tet/$has >$tet/$name.ID\n";
	my $one = 'if(/^>(\S+)/){$c=$i{$1}}$c?print:chomp;$i{$_}=1 if @ARGV';
	my $name1 = $name;
	$name1 =~ s/$/_scaffolds_nucl.fasta/g;
	system "perl -ne '$one' $tet/$name.ID $NuclSeq/$name1 >$tet/$name.fasta\n";
	system "cat $tet/$name.fasta >>Nucl_rpsJ.fasta\n";
	}
}
