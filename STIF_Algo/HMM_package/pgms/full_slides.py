#!/usr/bin/python3

import sys
import math

def qu_check(a, b, c):
    if a == b:
        q_freq = c
    else:
        q_freq = 1
    return q_freq

# Function to calculate scores
def scores(ss, mat, row, lencol):
    spseq = list(ss)
    valid_score = []
    
    jq_at = 0  # Initialize jq_at
    jq_gc = 0  # Initialize jq_gc
    jobs_prob_no = []

    for k in range(row):
        jqq_freq = []
        a = c = g = t = 0  # Initialize these variables
        jfreqa = freqc = freqg = jfreqt = None  # Initialize frequency variables
        for j in range(lencol):
            jff = 1
            for i in range(row):
                if i != k:
                    if mat[i][j] == 'A':
                        a += 1
                        jfreqa = (a / (row - 1)) + 1  # pseudocount
                        jff = qu_check(spseq[j], mat[i][j], jfreqa)
                    elif mat[i][j] == 'C':
                        c += 1
                        jfreqc = (c / (row - 1)) + 1
                        jff = qu_check(spseq[j], mat[i][j], jfreqc)
                    elif mat[i][j] == 'G':
                        g += 1
                        jfreqg = (g / (row - 1)) + 1
                        jff = qu_check(spseq[j], mat[i][j], jfreqg)
                    elif mat[i][j] == 'T':
                        t += 1
                        jfreqt = (t / (row - 1)) + 1
                        jff = qu_check(spseq[j], mat[i][j], jfreqt)
                    jqq_freq.append(jff)
        
        jobs_freq = sorted(jqq_freq, reverse=True)
        jobs_prob_no.append(jobs_freq[0])
        
        if spseq[j] == 'A' or spseq[j] == 'T':
            jq_at += 1
        elif spseq[j] == 'G' or spseq[j] == 'C':
            jq_gc += 1
        
        a = c = g = t = 0
        jfreqa = freqc = freqg = jfreqt = None
        jqq_freq = []

    incr = 1
    for score in jobs_prob_no:
        incr *= score
    
    jq_apriori = jq_at * (math.log(0.375)) + jq_gc * (math.log(0.125))
    jq_score = math.log(incr) - jq_apriori
    normal = jq_score / lencol

    valid_score.append(normal)
    
    return valid_score

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage: python3 full_slides.py <input_seq_file> <consensus_file> <output_dir>")
        sys.exit(1)
    
    input_seq_file = sys.argv[1]
    consensus_file = sys.argv[2]
    output_dir = sys.argv[3]
    
    # Open input sequence file
    try:
        with open(input_seq_file, 'r') as seq_fh:
            query_seq_file = seq_fh.readlines()
    except IOError:
        print(f"Error: Could not open {input_seq_file}")
        sys.exit(1)
    
    # Parse sequences from input file
    seq = {}
    key = None
    for line in query_seq_file:
        if line.startswith('>'):
            key = line
            tmp = ''
        else:
            tmp += line.strip()
            seq[key] = tmp
    
    # Open consensus file
    try:
        with open(consensus_file, 'r') as file_fh:
            consfile = file_fh.readlines()
    except IOError:
        print(f"Error: Could not open {consensus_file}")
        sys.exit(1)
    
    # Parse factors from consensus file
    cons = {}
    keycon = None
    tmpseq = ''
    comm = []
    for line in consfile:
        line = line.strip()
        if line.startswith('FACTOR='):
            comm.append(line)
            keycon = line.split('=')[1]
            tmpseq = ''
        else:
            tmpseq += line
            cons[keycon] = tmpseq
    
    # Prepare output files
    row = 0
    lencol = len(consfile[0].strip())
    mat = [['' for _ in range(lencol)] for _ in range(len(cons))]
    
    # Calculate scores for each sequence and write output
    c = 1
    for keycon in sorted(cons.keys()):
        files = f"{keycon}_full{c}"
        out = f"{output_dir}/{files}"
        
        try:
            with open(out, 'w') as out_fh:
                out_fh.write(f"\n****{keycon}\n")
                out_fh.write(f"LEN :: {lencol}\n")
                
                for key in sorted(seq.keys()):
                    out_fh.write(f"{key}\n")
                    seq_key = seq[key].strip()
                    winslid_seq = [seq_key[i:i+lencol] for i in range(len(seq_key) - lencol + 1)]
                    
                    for winslid in winslid_seq:
                        row = 0
                        valid_score = scores(winslid, mat, len(cons), lencol)
                        validmax = sorted(valid_score, reverse=True)
                        
                        if valid_score[0] != 0:
                            out_fh.write(f"FORWARD   + \t{winslid}\t\t\t")
                            out_fh.write(f"{validmax[0]:.4f}\n")
                        
                        winslid_rev = winslid[::-1]
                        valid_score_rev = scores(winslid_rev, mat, len(cons), lencol)
                        validmax_rev = sorted(valid_score_rev, reverse=True)
                        
                        if valid_score_rev[0] != 0:
                            out_fh.write(f"REVERSE   + \t{winslid_rev}\t\t\t")
                            out_fh.write(f"{validmax_rev[0]:.4f}\n")
                        
                out_fh.write("************************ END OF FILE*********8 \n")
        
        except IOError:
            print(f"Error: Could not open {out}")
            sys.exit(1)
        
        c += 1
