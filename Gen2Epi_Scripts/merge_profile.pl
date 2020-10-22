#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use strict;
use warnings;

my $dir =$ARGV[0];
system "find $dir -empty -type f -delete\n";
        opendir(DIR,$dir);
	while(my $ngstar = readdir(DIR)){
        chomp($ngstar);
	next if ($ngstar =~m/^\./);
        if ($ngstar =~ m/_partial_hit$/){
        open my $ifh, "<", "$dir/$ngstar" or die $!;
        my $OUT1 = $ngstar;
        $OUT1 =~ s/_partial_hit/_partial_hit_merger/g;
        my $cmd1 = 's != $1 || NR ==1{s=$1;if(p){print p};p=$0;next} {sub($1,"",$0);p=p""$0;}END{print p}';
        my $sp = '-F " "';
        system "awk $sp '$cmd1' $dir/$ngstar >$dir/$OUT1\n";

}}

