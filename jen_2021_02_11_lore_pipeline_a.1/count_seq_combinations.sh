# count sequence combinations counts occurrence of all pairs of patterns
# from SEQ_FILE1 and SEQ_FILE2 in READS_FILE 
function usage {
    echo "Usage: count_seq_combinations.sh SEQ_FILE1 SEQ_FILE2 READS_FILE"
    echo "For all pairs of sequences in SEQ_FILE1 and SEQ_FILE2 count the occurrence of that combination in READS_FILE"
}

if [[ ( "$1" == "" ) || ( "$2" == "" ) || ( "$3" == "" ) ]]; then
    usage
    exit
fi

while read -r line1
do
    while read -r line2
    do
        wc=$( grep -e "${line1}.*${line2}" -e "${line2}.*${line1}" $3 | wc -l )
        printf "%s %s %d\n" $line1 $line2 $wc
    done < $2
done < $1



