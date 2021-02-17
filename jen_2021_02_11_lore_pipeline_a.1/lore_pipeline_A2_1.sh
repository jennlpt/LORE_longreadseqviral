#!/bin/bash

# LORE pipeline:
# Stage A2-1
#
# Takes an input identifiers file and a reads file
# and looks for reads which match sequential pairwise combinations (in order, separated by anything)
# of the sequences found in the reads file
#
# matching : S1<ANYTHING>S2 for pair (S1,S2)
#
# Usage:
# ./lore_pipeline_A2_1.sh
#   IN_FILE_IDENTIFIERS
#   IN_FILE_READS
#   OUT_FILE_FILTERED_READS
#   OUT_FILE_FILTERED_READS_SUMMARY

# output files:
#
# OUT_FILE_FILTERED_READS
# OUT_FILE_FILTERED_READS_SUMMARY

function usage () {
    echo "usage: ./lore_pipeline_A2_1.sh IN_FILE_IDENTIFIERS IN_FILE_READS OUT_FILE_FILTERED_READS OUT_FILE_FILTERED_READS_SUMMARY"
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

if [[ "${out_file_filtered_reads_summary}" == "" ]]; then
    echo "ARG OUT_FILE_FILTERED_READS_SUMMARY required"
    usage
    echo "Exiting"
    exit
fi

# clear files
echo -n > ${out_file_filtered_reads}
echo -n > ${out_file_filtered_reads_summary}

echo "Generating output filtered reads file:"
echo ${out_file_filtered_reads}
echo "Generating output summary file file:"
echo ${out_file_filtered_reads_summary}
echo

i=0
last=""
while read -r line1
do 
    #echo "$i $last $line1"
    if [[ $i > 0 ]]; then        
        wc12=$( grep -e "${lastk}.*${line1}" ${in_file_reads} | tee -a ${out_file_filtered_reads} | wc -l )
        #grep -e "${last}.*${line1}" ${in_file_reads} 
        echo "$last $line1 $wc12" | tee -a ${out_file_filtered_reads_summary}  
    fi
    i=$(( $i + 1 ))
    last=${line1}
done < ${in_file_identifiers}

