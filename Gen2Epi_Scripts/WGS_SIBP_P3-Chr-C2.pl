#!/usr/bin/perl

#################################################
# Written by Dr. Reema Singh #
# Final Release: 2018 #
#################################################

use strict;
use warnings;

my $In = $ARGV[0];
my $genomePath = $ARGV[1];
my $genFas = $genomePath;
$genFas =~ s/^.*\///g;
my $genFas1 = $genFas;
$genFas1 =~ s/.fasta//g;
my $Path = $ARGV[2];
my $gff = $ARGV[3];
my $th = $ARGV[4];


##### Scaffolding


	my $OUT = "Chr_Scaffolds_Multref";
	if (!-d $OUT){
        system "mkdir $OUT\n";}

	open(HAS,$In);
	while(my $has = <HAS>){
	chomp($has);
	my ($ID,$pair1,$pair2) = split /\t/,$has;
	if (!-d $ID){
                system "mkdir $OUT/$ID\n";}
	open(OUT, ">", "$OUT/$ID.rcp");
	print OUT ".references = $genFas1\n.target = contigs\n\n$genFas=$genomePath\ncontigs.fasta=$Path/$ID/contigs.fasta ";
	system "ragout.py $OUT/$ID.rcp --refine -t $th -o $OUT/$ID\n";
	

##### Annotation and Quality assessment

	opendir(DIR,"$OUT/$ID");
	my $name = join("_",$ID,"scaffolds.fasta");
	while(my $line = readdir(DIR)){
	chomp($line);
	next if ($line =~m/^\./);
	if ($line=~ m/_scaffolds.fasta$/){
	system "cp $OUT/$ID/$line $OUT/$ID/$name\n";
	my $OUT1 = $name;
	$OUT1 =~ s/.fasta//g;
	my $prot = join("_",$OUT1,"prot.fasta");
	my $nucl = join("_",$OUT1,"nucl.fasta");
	my $annot = join("_",$OUT1,"annot-genes");
	system "prodigal -a $OUT/$ID/$prot -d $OUT/$ID/$nucl -f gff -i $OUT/$ID/$name -o $OUT/$ID/$OUT.gff -p meta -s $OUT/$ID/$annot\n";
	system "metaquast.py $OUT/$ID/$name -R $genomePath -G $gff -o $OUT/$ID \n";
		}
	}
}
system "perl ScaffoldsStats_gff.pl $In $OUT\n"; 
