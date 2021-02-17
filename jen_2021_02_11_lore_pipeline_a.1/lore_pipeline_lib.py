#  This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#  
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#  
#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <https://www.gnu.org/licenses/>.
# LORE pipeline_partA-v1 
import re

def read_raw_file(filepath):
    """ read a raw file and return as a string
    """    
    fp = open(filepath,'rt')
    raw_s = ''
    line = fp.readline()
    c = 0
    cmax = 10
    while (line):
        #print line
        # strip out everything except [ATGC]|[atgc]
        s = line
        s = re.sub(r'[^atgcATGC]','',s)
        #print s
        raw_s += s
        #print raw_s
        line = fp.readline()
        c += 1
    fp.close()
    return raw_s

def write_seq_lst(seq_lst, filepath):
    fp = open(filepath, 'wb')
    for (i,s) in enumerate(seq_lst):
        #print("%02d %s" % (i,s))
        fp.write(s + '\n')
    fp.close()
        
def extract_equally_spaced_subsequences(refseq, start, increment, seqsize):
    """Take refseq string and extract out seqsize subsequence starting at every increment positions
       return a list of sequence strings
       NOTE: start is 1-based (i.e. first is at 1) to conform to standard genomic notation
    """
    nt = len(refseq)
    i = start - 1 # python strings are 0-indexed
    s = []
    done = False
    while not done:
        i_next = i + increment
        if i_next > nt:
            done = True
            continue
        s.append(refseq[i:i+seqsize])
        i = i_next
    return s
       
