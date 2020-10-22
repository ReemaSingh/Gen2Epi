#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use warnings;
use strict;

my $al = "NgStarGenAllele_Profile";
open(OUT, ">","NgStarRes.txt");
open(HAS,$al);
		while(my $has=<HAS>){
		chomp($has);
		$has =~ s/,//g;
		my @all = split(" ",$has);
		#my @samp = grep {/Sample/} @all;
		my @samp = $all[0];
		my @penA = grep {/penA/} @all;
		@penA = grep {s/penA//} @penA ;
		my @mtrR = grep {/mtrR/} @all;
		@mtrR = grep {s/mtrR//} @mtrR;
		my @porB = grep {/porB/} @all;
		@porB = grep {s/porB//} @porB;
		my @ponA = grep {/ponA/} @all;
		@ponA = grep {s/ponA//} @ponA;
		my @gyrA = grep {/gyrA/} @all;
		@gyrA = grep {s/gyrA//} @gyrA;
		my @parC = grep {/parC/} @all;
		@parC = grep {s/parC//} @parC;
		my @TwtT = grep {/23S/} @all;
		@TwtT = grep {s/23S//} @TwtT;
		print OUT "@samp\t@penA\t@mtrR\t@porB\t@ponA\t@gyrA\t@parC\t@TwtT\n";
#		print "@samp\t@penA\t@mtrR\t@porB\t@ponA\t@gyrA\t@parC\t@TwtT\n";
}



