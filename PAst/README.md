# PAst

Note: this software can analyze several genomes in a row
perl ./PAst.pl /Users/marinepottier/Outils/PAst/ncbi-blast-2.2.29+/bin output input OSAdb.fasta

<b>OVERVIEW</b>

The <i>Pseudomonas aeruginosa</i> serotyper (PAst) is a command-line-tool for fast and reliable <i>in silico</i> serotyping of <i>P. aeruginosa</i> isolates, based on whole genome sequence assembly data. 

PAst is distributed as a Perl script (for batch analysis of multiple genomes) as well as a web service tool for analysis of single isolates hosted by the Center for Genomic Epidemiology at Center for Biological Sequence Analysis DTU: https://cge.cbs.dtu.dk/services/PAst-1.0/


<b>USAGE</b>

Usage:        "./PAst.pl path/to/BLASTbin path/to/output/directory path/to/input/directory path/to/OSAdb"

- BLAST bin:    Path to the bin containing blasts executables (ex. /usr/bin/ncbi-blast-2.2.29+/bin/)
- Output dir:   Directory where blast reports, OSA multifasta files and result summary (serotyping.txt) are placed
- Input dir:    Directory containing assembled input genomes in multifasta format (and nothing else)
- OSA database: Path to OSA database file (downloadable from Github)

To print help message: "./PAst.pl help"


<b>SETUP</b>

Download the Perl script and OSA database file. PAst is dependent on the installation of Perl and blastn (blast+ 2.2.29: https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download)


<b>DESCRIPTION OF OUTPUT FILES</b>

- Result summary with predicted serogroups (serotyping.txt)
- BLAST reports for each input genome
- Multifasta file of extracted OSA clusters from each input genome

<b>CITATION</b>

PAst is currently being prepared for publication, a citation will be available shortly.
