#!/bin/bash

# LORE pipeline:
# Stage A1:
#
# Generate a set of identifiers by scanning through a reference genome

shopt -s expand_aliases
source ~/.bash_profile

# edit these
stride=1800
length=20
ref_genome_file="./data/reference_genome_wuhan_covid19.txt"
identifier_file="./data/identifiers.stride_${stride}.length_${length}.out"

python extract_equally_spaced_subseq.py \
    --rawseqfile ${ref_genome_file}            \
    --start      1                             \
    --increment  ${stride}                     \
    --seqsize    ${length}                     \
    --outfile    ${identifier_file}

echo done
