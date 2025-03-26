#!/usr/bin/python3

import sys
import math

def qu_check(a, b, c):
    if a == b:
        q_freq = c
    else:
        q_freq = 1
    return q_freq

def scores(ss):
    global row, lencol, mat, valid_score
    
    spseq = list(ss)
    jobs_prob_no = []
    jq_at = jq_gc = 0
    
    for k in range(row):
        jqq_freq = []
        a = c = g = t = 0
        
        for j in range(lencol):
            jff = 1
            for i in range(row):
                if i != k:
                    if mat[i][j] == 'A':
                        a += 1
                        jfreqa = (a / (row - 1)) + 1
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
    
    incr = 1
    for score in jobs_prob_no:
        incr *= score
    
    jq_apriori = jq_at * (math.log(0.375)) + jq_gc * (math.log(0.125))
    jq_score = math.log(incr) - jq_apriori
    normal = jq_score / lencol
    
    valid_score.append(normal)

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python3 position.py <input_seq_file> <consensus_file>")
        sys.exit(1)
    
    input_seq_file = sys.argv[1]
    consensus_file = sys.argv[2]
    
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
            tmpseq = tmpseq + '-'
            cons[keycon] = tmpseq
    
    # Prepare variables for scoring
    row = 0
    lencol = len(consfile[0].strip())
    mat = [['' for _ in range(lencol)] for _ in range(len(cons))]
    valid_score = []
    
    # Process each sequence and calculate scores
    for key in sorted(seq.keys()):
        print(key)
        seq_key = seq[key].strip()
        winslid_seq = [seq_key[i:i + lencol] for i in range(len(seq_key) - lencol + 1)]
        
        for winslid in winslid_seq:
            print(f"FORWARD\t{winslid}", end='\t')
            scores(winslid)
            validmax = sorted(valid_score, reverse=True)
            if valid_score[0] != 0:
                print(f"{validmax[0]:.4f}")
            else:
                print("0.0000")
            
            winslid_rev = winslid[::-1]
            print(f"REVERSE\t{winslid_rev}", end='\t')
            scores(winslid_rev)
            validmax_rev = sorted(valid_score, reverse=True)
            if valid_score[0] != 0:
                print(f"{validmax_rev[0]:.4f}")
            else:
                print("0.0000")
            
            valid_score = []