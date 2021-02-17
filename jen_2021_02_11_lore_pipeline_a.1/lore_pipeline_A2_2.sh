#!/bin/bash

# LORE pipeline:
# Stage A2-2
#
# Takes an input identifiers file and a reads file
# and looks for reads which match sequential pairwise combinations (in order, separated by anything)
# of the sequences found in the reads file
#
# matching : S1<ANYTHING>S2 for pair (S1,S2)
#
# and removes those reads

# Usage:
# ./lore_pipeline_A2_2.sh
#   IN_FILE_IDENTIFIERS
#   IN_FILE_READS
#   OUT_FILE_FILTERED_READS

#
# output files:
#
# <LABEL>.isoforms_excl.out

function usage () {
    echo "usage: ./lore_pipeline_A2_2.sh IN_FILE_IDENTIFIERS IN_FILE_READS OUT_FILE_FILTERED_READS"
}
   
shopt -s expand_aliases
source ~/.bash_profile
#alias

in_file_identifiers="$1"
in_file_reads="$2"
out_file_filtered_reads="$3"
out_file_filtered_reads_summary="$4"

if [[ ! -e "${in_file_identifiers}" ]]; then
    echo "IN_FILE_IDENTIFIERS:"
    echo " ${in_file_identifiers}"
    echo "Does not exist"
    usage
    echo "Exiting"
    exit
fi

if [[ ! -e "${in_file_reads}" ]]; then
    echo "IN_FILE_READS:"
    echo " ${in_file_reads}"
    echo "Does not exist"
    usage
    echo "Exiting"
    exit
fi

if [[ "${out_file_filtered_reads}" == "" ]]; then
    echo "ARG OUT_FILE_FILTERED_READS required"
    usage
    echo "Exiting"
    exit
fi

# clear files
echo -n > ${out_file_filtered_reads}
echo -n > ${out_file_filtered_reads_summary}

echo "Generating output filtered reads file:"
echo ${out_file_filtered_reads}
echo

tmp1_file=pipeline_a2_2.tmp1
cp -f ${in_file_reads} ${tmp1_file}

tmp2_file=pipeline_a2_2.tmp2
echo -n > ${tmp2_file}

i=0
while read -r line1
do
    if [[ $(( $i % 2 )) == 0 ]]; then
        tmp_a=${tmp2_file}
        tmp_b=${tmp1_file}
    else 
        tmp_a=${tmp1_file}
        tmp_b=${tmp2_file}
    fi

    if [[ $i > 0 ]]; then
        #echo "$i $last $line1"        
        wc12=$( grep -v "${last}.*${line1}" ${tmp_a} | tee ${tmp_b}  | wc -l )
        printf "%s %s %d\n" $last $line1 $wc12   
    fi
    i=$(( $i + 1 ))    
    #printf "%s %s %d\n" $line2 $line1 $wc21 | tee -a ${out_summary_file}  
    last=${line1}
done < ${in_file_identifiers}

cp -f ${tmp_b} ${out_file_reads}

rm -f ${tmp1_file} 
rm -f ${tmp2_file} 

