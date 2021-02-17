# filter out all sequences in SEQ_FILE from FILE_TO_GREP
function usage {
    echo "Usage: filter_seq.sh SEQ_FILE FILE_TO_GREP"
    echo "filters out all lines containing the sequences in SEQ_FILE out of file FILE_TO_GREP. Writes the filtered output to stdout"
}

if [[ ( "$1" == "" ) || ( "$2" == "" )  ]]; then
    usage
    exit
fi

s="grep "
while IFS= read -r line
do
    q="-v -e ${line}"
    s="$s $q"
done < $1

s="$s $2"
eval $s

