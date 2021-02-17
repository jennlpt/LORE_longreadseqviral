import lore_pipeline_lib
import argparse
parser = argparse.ArgumentParser(description='Extracts out a list of subsequences from the raw sequence in RAWSEQFILE. All subsequences ar eof size SEQSIZE. The start index of each subsequence from the reference sequences starts at START (1-index) and increment by INCREMENT. Output sequence is written to file OUTFILE')

parser.add_argument('--rawseqfile', type=str, help='Input raw sequence file',                                                 required=True)
parser.add_argument('--start',      type=int, help='Start index for generated subsequences. 1-based indexing (first nt i 1)', required=True)
parser.add_argument('--increment',  type=int, help='Increment to apply to extract each subsequence',                          required=True)
parser.add_argument('--seqsize',    type=int, help='Size of subsequences to extract',                                         required=True)
parser.add_argument('--outfile',    type=str, help='Output subsequence list file. 1 sequence per line',                       required=True) 

args = parser.parse_args()

print "Extracting raw sequence from file:"
print "  %s" % args.rawseqfile

refseq = lore_pipeline_lib.read_raw_file(args.rawseqfile)

print "Extracting subsequences. START = %d ; INCREMENT = %d ; SEQSIZE %d" % (args.start, args.increment, args.seqsize)

subseq_lst = lore_pipeline_lib.extract_equally_spaced_subsequences(refseq, args.start, args.increment, args.seqsize)

print "Writing results to file:"
print "  %s" % args.outfile
lore_pipeline_lib.write_seq_lst(subseq_lst, args.outfile)







