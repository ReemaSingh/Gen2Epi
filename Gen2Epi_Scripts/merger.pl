#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use strict;
use warnings;

my $dir =$ARGV[0];
        opendir(DIR,$dir);
        while(my $ngstar = readdir(DIR)){
        chomp($ngstar);
        next if ($ngstar =~m/^\./);
                if ($ngstar =~ m/_NgSTAR.blastn/){
	        my $OUT = $ngstar;
		$OUT =~ s/_NgSTAR.blastn/_partial_hit/g;
	my $cmd = '{if (x[$1]) { x_count[$1]++; print $0; if (x_count[$1] == 1) { print x[$1] } } x[$1] = $0}';
	system  "awk '$cmd' $dir/$ngstar >$dir/$OUT";
	}}
