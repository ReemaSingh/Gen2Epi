#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use strict;
use warnings;

my $file = $ARGV[0];
my $kdb = $ARGV[1];
my $PATH = $ARGV[2];
my $OUT = $ARGV[3];

open(FILE,$file);
while ( my $line =<FILE>){
chomp($line);
my($ID,$pair1,$pair2) = split /\t/,$line;
my $log = $ID;
my $Ufile = join("_",$ID,"Unclassified");
my $Cfile = join("_",$ID,"Classified");
my $out = join(".",$ID,"kraken");
my $repo = $out;
$repo =~ s/.kraken/_kraken.report/g;
my $mpaRepo = $out;
$mpaRepo =~ s/.kraken/_kraken.mpa_report/g;
my $thr = join(".",$ID,"output");

system "kraken --fastq-input --gzip-compressed -db $kdb --paired --check-names --threads 30 $PATH/$pair1 $PATH/$pair2 --unclassified-out $OUT/$Ufile --classified-out $OUT/$Cfile --output $OUT/$out 2> $OUT/$log.log\n";
system "kraken-translate --db $kdb $OUT/$out >$OUT/$ID.lable\n";
system "kraken-report -db $kdb $OUT/$out >$OUT/$repo\n";
system "kraken-mpa-report -db $kdb $OUT/$out >$OUT/$mpaRepo\n";
system "kraken-filter --db $kdb --threshold 0.05 $OUT/$out >$OUT/$thr\n";
}

