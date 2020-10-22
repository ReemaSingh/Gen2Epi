#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use strict;
use warnings;
use WWW::Mechanize;
use LWP::Simple;
use File::Basename;


my $html = "https://pubmlst.org/bigsdb?db=pubmlst_neisseria_seqdef";

my $mech = get $html;
my $tree = HTML::TreeBuilder->new;
$tree->parse($mech);
print "$tree\n";

