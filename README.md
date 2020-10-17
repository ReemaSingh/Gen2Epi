# Gen2Epi
An automated whole-genome sequencing pipeline for linking full genomes to antimicrobial susceptibility and molecular epidemiological data in Neisseria gonorrhoeae.

# Requirements

1. Perl V5.16.3 or higher
2. Install the following programs and make them executable

        a.	FastQC 
        b.	MultiQC
        c.	Trimmomatic
        d.	Kraken
        e.	Bowtie2
        f.	SPAdes
        g.	BBMap
        h.	Ragout
        i.	Prodigal
        j.	QUAST
        k.	BLAST
        l.	EMBOSS
        m.	NGMASTER
  
  3. If the installed programs are not executable, then all required softwares should be in path
  
    a.	export PATH=$PATH:/installation-path/FastQC
    b.	export PATH=$PATH:/installation-path/Trimmomatic-0.36
    c.	export PATH=$PATH:/installation-path/SPAdes-3.11.1-Linux/bin
    d.	export PATH=$PATH:/installation-path/SPAdes-3.11.1-Linux/share
    e.	export PATH=$PATH:/installation-path/bbmap/
    f.	export PATH=$PATH:/installation-path/ngmaster/
    g.	export PATH=$PATH:/installation-path/x86_64
    h.	export PATH=$PATH:/installation-path/ncbi-blast-2.6.0+/bin/
    i.	export PATH=$PATH:/installation-path/EMBOSS-6.6.0/bin
    j.	export PATH=$PATH:/installation-path/Sibelia-master
    k.	export PATH=$PATH:/installation-path/Sibelia-master/bin
    l.	export PATH=$PATH:/installation-path/Sibelia-master/bin/bin
    m.	export PATH=$PATH:/installation-path/Sibelia-master/bin/lib
    n.	export PATH=$PATH:/installation-path/Sibelia-master/bin/share
    o.	export PATH=$PATH:/installation-path/fenderglass-Ragout-71562fc
    p.	export PATH=$PATH:/installation-path/quast-4.5
    q.	export PATH=$PATH:/installation-path/Prodigal-2.6.3
    r.	export PATH=$PATH:/installation-path/bowtie2-2.3.2
    
    Alternately, users can also copy the above-mentioned commands [a-r] in “.bashrc” and then set the path in the current 
    working directory by running the following command
  
  	“source .bashrc” 

4. Copy the test dataset in the current working directory under

        “/home/user/Desktop/Test_DATA”
        
5. Copy the Gen2Epi_Scripts folder in your current working directory.
