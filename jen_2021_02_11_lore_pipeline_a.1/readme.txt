LORE pipeline_v1 (jlpt-November 2020)
System requirements: 
GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin18)
Python 2.7.16

Section A1:

Extract out identifiers from a reference genome

Usage:

./pipeline_a1.sh

Inputs:
Reference genome in stripped raw format (wuhan_genome_raw.txt)
Stride and window length args (in script)

Outputs: 
Identifiers file  (identifiers.stride_1800.length_20.out)

Section A2-1:

Takes an input identifiers file and a reads file and looks for reads which match 
sequential pairwise combinations (in order, separated by anything) of the 
sequences found in the reads file

matching : S1<ANYTHING>S2 for pair (S1,S2)

Usage:
./pipeline_a2_1.sh
  LABEL 
  IN_IDENTIFIERS_FILE 
  IN_READS_FILE

output files:

<LABEL>.isoforms_incl.out
<LABEL>.isoforms_incl.summary

Section A2-2:

LORE pipeline:
Stage A2-2

Takes an input identifiers file and a reads file
and looks for reads which match sequential pairwise combinations (in order, separated by anything)
of the sequences found in the reads file

matching : S1<ANYTHING>S2 for pair (S1,S2)

and removes those reads

Usage:
./pipeline_a2_1.sh
  LABEL 
  IN_IDENTIFIERS_FILE 
  IN_READS_FILE

output files:

<LABEL>.isoforms_excl.out