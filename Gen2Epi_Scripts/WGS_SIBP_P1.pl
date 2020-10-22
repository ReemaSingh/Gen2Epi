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
my $OUT = "QualityControl";
my $Trim = "Trimming";
my $Trim1 = "Trimmed_QC";
my $MQC = "MultiQC-Raw";
my $MQC1 = "MultiQC-Trimmed";

if ($type =~ /QualityCheck/i){
	if (!-d $OUT ||$MQC){
	system "mkdir $OUT\t$MQC\n";}
open(INPUT,$In);
while ( my $rawData =<INPUT>){
chomp($rawData);
my ($ID,$pair1,$pair2) = split /\t/,$rawData;
system "fastqc $PATH/$pair1 $PATH/$pair2 -o $OUT -f fastq\n";
}
system "multiqc $OUT/*_fastqc.zip -o $MQC\n";
}

elsif ($type =~ /Trimming/i){
 	if (!-d $Trim||$Trim1||$MQC1){
	system "mkdir $Trim\t$Trim1\t$MQC1\n";}
open(INPUT,$In);
while ( my $rawData =<INPUT>){
chomp($rawData);
my ($ID,$pair1,$pair2) = split /\t/,$rawData;

my $OUTpair1 = join("_","OutputPaired",$pair1);
my $OUTUnpair1 = join("_","OutputUnpaired",$pair1);
my $OUTpair2 = join("_","OutputPaired",$pair2);
my $OUTUnpair2 = join("_","OutputUnpaired",$pair2);

my $lead = $ARGV[3];
my $trail = $ARGV[4];
my $SlidWin = $ARGV[5];
my $MinLen = $ARGV[6];

system "java -jar /usr/local/bin/trimmomatic.jar PE -phred33 $PATH/$pair1 $PATH/$pair2 $Trim/$OUTpair1 $Trim/$OUTUnpair1 $Trim/$OUTpair2 $Trim/$OUTUnpair2 LEADING:$lead TRAILING:$trail SLIDINGWINDOW:$SlidWin MINLEN:$MinLen\n";
system "fastqc $Trim/$OUTpair1 $Trim/$OUTpair2 -o $Trim1 -f fastq\n";
}
system "multiqc $Trim1/*_fastqc.zip -o $MQC1\n";
print "Finish Data Cleaning\n";
}

elsif ($type =~ /both/i){
	if (!-d $OUT ||$MQC ||$Trim||$Trim1||$MQC1){
	system "mkdir $OUT\t$MQC\t$Trim\t$Trim1\t$MQC1\n";}
open(INPUT,$In);
while ( my $rawData =<INPUT>){
chomp($rawData);
my ($ID,$pair1,$pair2) = split /\t/,$rawData;

my $OUTpair1 = join("_","OutputPaired",$pair1);
my $OUTUnpair1 = join("_","OutputUnpaired",$pair1);
my $OUTpair2 = join("_","OutputPaired",$pair2);
my $OUTUnpair2 = join("_","OutputUnpaired",$pair2);

my $lead = $ARGV[3];
my $trail = $ARGV[4];
my $SlidWin = $ARGV[5];
my $MinLen = $ARGV[6];

system "fastqc $PATH/$pair1 $PATH/$pair2 -o $OUT -f fastq\n";
system "java -jar /usr/local/bin/trimmomatic.jar PE -phred33 $PATH/$pair1 $PATH/$pair2 $Trim/$OUTpair1 $Trim/$OUTUnpair1 $Trim/$OUTpair2 $Trim/$OUTUnpair2 LEADING:$lead TRAILING:$trail SLIDINGWINDOW:$SlidWin MINLEN:$MinLen\n";
system "fastqc $Trim/$OUTpair1 $Trim/$OUTpair2 -o $Trim1 -f fastq\n";
}
system "multiqc $OUT/*_fastqc.zip -o $MQC\n";
system "multiqc $Trim1/*_fastqc.zip -o $MQC1\n";
print "Finish Data Cleaning\n";
}
