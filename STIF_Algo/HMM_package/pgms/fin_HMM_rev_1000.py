#!/usr/bin/env python3

import sys
import math

# Function to read sequence file
def read_sequence_file(filename):
    with open(filename, 'r') as seq_file:
        query_seq_file = seq_file.readlines()
    seq = {}
    key = ''
    tmp = ''
    for line in query_seq_file:
        if line.startswith('>'):
            if key:
                seq[key] = tmp
            key = line.strip()
            tmp = ''
        else:
            tmp += line.strip()
            seq[key] = tmp
    return seq

# Function to read consensus file
def read_consensus_file(filename):
    with open(filename, 'r') as cons_file:
        consfile = cons_file.readlines()
    cons = {}
    keycon = ''
    tmpseq = ''
    for line in consfile:
        line = line.strip()
        if line.startswith('FACTOR='):
            keycon = line.split('=')[1]
            cons[keycon] = ''
        else:
            tmpseq += line
            cons[keycon] = tmpseq
    return cons

# Function to calculate scores
def scores(ss, filecc, mat, row, lencol):
    spseq = list(ss)
    valid_score = []
    jq_at = jq_gc = jq_apriori = jq_score = 0
    
    for k in range(row):
        if ss == filecc[k]:
            jqq_freq = []
            for j in range(lencol):
                a = c = g = t = 0
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
                jobs_prob_no = jobs_freq[0]
                if spseq[j] == 'A' or spseq[j] == 'T':
                    jq_at += 1
                elif spseq[j] == 'G' or spseq[j] == 'C':
                    jq_gc += 1
                a = c = g = t = 0
                jfreqa = jfreqc = jfreqg = jfreqt = None
                jqq_freq = []
            incr = 1
            for score in jobs_prob_no:
                incr *= score
            jq_apriori = jq_at * (math.log(0.375)) + jq_gc * (math.log(0.125))
            jq_score = math.log(incr) - jq_apriori
            normal = jq_score / lencol
            valid_score.append(normal)
            jq_at = jq_gc = jq_apriori = jq_score = 0
    return valid_score

# Function to check frequencies
def qu_check(a, b, c):
    if a == b:
        q_freq = c
    else:
        q_freq = 1
    return q_freq

# Main script
if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: python position.py x.seq x.con")
        sys.exit(1)
    
    seq_filename = sys.argv[1]
    cons_filename = sys.argv[2]

    seq = read_sequence_file(seq_filename)
    cons = read_consensus_file(cons_filename)

    for key in seq:
        print(key)
        splqu_seq = list(seq[key].strip())
        len_seq = len(seq[key].strip())
        kspl = key.split()
        kagain = kspl[2].split('-')
        wini = len(cons[list(cons.keys())[0]].split('-')[0])
        for keycon in cons:
            print("****" + keycon)
            filecc = cons[keycon].split('-')
            row = len(filecc)
            lencol = len(filecc[0])
            valid_score = scores(seq[key], filecc, [], row, lencol)
            validmax = sorted(valid_score, reverse=True)
            if len(validmax) > 0 and validmax[0] != 0:
                print(f"FORWARD\t\t{keycon}\t\t{wini}\t\t{validmax[0]}")
                # Additional logic can be added here for printing results for reverse, com, comrev
        print("************************ END OF FILE*********8 \n\n")
