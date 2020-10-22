#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use strict;
use warnings;

my $OUT = $ARGV[0];
my $PlSeq = $ARGV[1];
my $Path = $ARGV[2];
my $th = $ARGV[3];

system "Parse_blast.pl $OUT\n";

opendir(DIR ,$OUT);
while(my $dir = readdir(DIR)){
chomp($dir);
next if ($dir =~m/^\./);
next if ($dir =~m/.blastn$/);
	open(FILE,"$OUT/$dir");
	while(my $has = <FILE>){
	chomp($has);
	$has =~ s/^ //g;
	my ($acc,$desc) = split / /, $has;
	my $out = $acc;
	my $dir1 = $dir;
	$dir1 =~ s/_bestHits.txt//g;
	if (!-d "$OUT/$dir1"){
        system "mkdir $OUT/$dir1\n";} 
	$out =~ s/.\d$/.fasta/g;
	my $Seqfetch = 'if(/^>(\S+)/){$c=grep{/^$1$/}';
	my $Seqfetch1 = "qw($acc)}";
	my $Seqfetch2 = 'print if $c';
	system "perl -ne '$Seqfetch$Seqfetch1$Seqfetch2' $PlSeq >$OUT/$dir1/$out\n";
	my $OutP = $out;
        $OutP =~ s/.fasta/.rcp/g;
	my $OutP1 = $out;
	$OutP1 =~ s/.fasta//g;
	
	open(OUT1,">","$OUT/$dir1/$OutP");
        print OUT1 ".references = $OutP1\n.target = contigs\n\n$out=$OUT/$dir1/$out\ncontigs.fasta=$Path/$dir1/contigs.fasta";

	if(!-d "$OUT/$dir1/$OutP1"){
	system "mkdir $OUT/$dir1/$OutP1\n";}
	
        system "ragout.py $OUT/$dir1/$OutP --refine -t $th -o $OUT/$dir1/$OutP1\n";
	
}}

