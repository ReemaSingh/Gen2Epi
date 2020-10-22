#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use strict;
use warnings;

my $In = $ARGV[0];
my $PATH = $ARGV[1];
my $type = $ARGV[2];
my $th = $ARGV[3];

	if ($type =~ /raw/i){
	my $Assem = "Chrom_AssemblyRawReads";
	my $Assem1 = "Plasmid_AssemblyRawReads";
	my $Cstat = "ChromContigAssemblyRStat";
	my $Pstat = "PlasmidContigAssemblyRStat";
	if (!-d $Assem ||$Assem1 || $Cstat || $Pstat){
	system "mkdir $Assem $Assem1 $Cstat $Pstat\n";}

	open(INPUT,$In);
	while ( my $rawData =<INPUT>){
	chomp($rawData);
	chomp($rawData);
	my ($ID,$pair1,$pair2) = split /\t/,$rawData;

	system "spades.py --pe1-1 $PATH/$pair1 --pe1-2 $PATH/$pair2 --cov-cutoff auto --careful -t $th -o $Assem/$ID\n";
	system "plasmidspades.py --pe1-1 $PATH/$pair1 --pe1-2 $PATH/$pair2 --cov-cutoff auto --careful -t $th -o $Assem1/$ID\n";
	my $gchist = join("_",$ID,"GC_hist");
	my $shist = join("_",$ID,"length_hist");
	my $stat = join("_",$ID,"Assembly_Stat");

	system "stats.sh in=$Assem/$ID/contigs.fasta gchist=$Cstat/$gchist shist=$Cstat/$shist >$Cstat/$stat\n";
	system "stats.sh in=$Assem1/$ID/contigs.fasta gchist=$Pstat/$gchist shist=$Pstat/$shist >$Pstat/$stat\n";
	}}

	if($type =~ /trimmed/i){
	my $Assem = "Chrom_AssemblyTrimmedReads";
        my $Assem1 = "Plasmid_AssemblyTrimmedReads";
        my $Cstat = "ChromContigAssemblyTrimmedStat";
        my $Pstat = "PlasmidContigAssemblytrimmedStat";
	if (!-d $Assem ||$Assem1 || $Cstat || $Pstat){
        system "mkdir $Assem $Assem1 $Cstat $Pstat\n";}

	open(INPUT,$In);
        while ( my $rawData =<INPUT>){
        chomp($rawData);	
	my ($ID,$pair1,$pair2) = split /\t/,$rawData;

	my $OUTpair1 = join("_","OutputPaired",$pair1);
	my $OUTUnpair1 = join("_","OutputUnpaired",$pair1);
	my $OUTpair2 = join("_","OutputPaired",$pair2);
	my $OUTUnpair2 = join("_","OutputUnpaired",$pair2);

	system "spades.py --pe1-1 $PATH/$OUTpair1 --pe1-2 $PATH/$OUTpair2 --pe1-s $PATH/$OUTUnpair1 --pe1-s $PATH/$OUTUnpair2 --cov-cutoff auto --careful -t $th -o $Assem/$ID\n";
	system "plasmidspades.py --pe1-1 $PATH/$OUTpair1 --pe1-2 $PATH/$OUTpair2 --pe1-s $PATH/$OUTUnpair1 --pe1-s $PATH/$OUTUnpair2 --cov-cutoff auto --careful -t $th -o $Assem1/$ID\n";
	my $gchist = join("_",$ID,"GC_hist");
        my $shist = join("_",$ID,"length_hist");
        my $stat = join("_",$ID,"Assembly_Stat");
	
	system "stats.sh in=$Assem/$ID/contigs.fasta gchist=$Cstat/$gchist shist=$Cstat/$shist >$Cstat/$stat\n";
        system "stats.sh in=$Assem1/$ID/contigs.fasta gchist=$Pstat/$gchist shist=$Pstat/$shist >$Pstat/$stat\n";
        }}
