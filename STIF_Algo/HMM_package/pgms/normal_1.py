#!/usr/bin/env python3

import sys
import re

# Checking command line arguments
if len(sys.argv) != 2:
    print("Usage: python coverage.py <input_file>")
    sys.exit(1)

input_file = sys.argv[1]

try:
    with open(input_file, 'r') as file:
        file_content = file.readlines()
except FileNotFoundError:
    print(f"Error: File '{input_file}' not found")
    sys.exit(1)

full = {}
hash_dict = {}
names = []
fac = []
zsco = []
zsco_full = []
hits = 0
gene_hits = 0
entire = 0
NU_DE = {}
sum = 0

# Parsing the input file
for line in file_content:
    line = line.rstrip('\n')
    if re.match(r'^\*\*\*\*(\w+)', line):
        kk = re.match(r'^\*\*\*\*(\w+)', line).group(1)
    elif re.match(r'^>|^Z-SCORE', line):
        if kk in full:
            full[kk] += line + "[[["
        else:
            full[kk] = line + "[[["

# Processing each group in 'full'
for kk in full:
    print(f"****{kk}")
    cal = full[kk].split("[[[")
    
    # Processing each subsection in 'cal'
    for item in cal:
        if item.startswith('>'):
            key = item
        elif item.startswith('Z-SCORE'):
            if key in hash_dict:
                hash_dict[key] += item + "+++"
            else:
                hash_dict[key] = item + "+++"

# Processing each key in 'hash_dict'
for key in hash_dict:
    print(key)
    spkee = re.split(r'\||>', key)
    names.append(spkee[6])
    nu_de = spkee[1]
    fac.append(f"{spkee[6]}*")
    
    # Splitting sections in 'hash_dict[key]'
    hhh_split = hash_dict[key].split("+++")
    
    # Processing each subsection in 'hhh_split'
    for section in hhh_split:
        if section.strip():
            split_section = re.split(r'\s+|\t+|::', section)
            zsco.append(split_section[2])
            zsco_full.append(f"{split_section[0]}Y{split_section[2]}Y{split_section[3]}Y{split_section[4]}Y{split_section[5]}Y{split_section[6]}Y")
    
    # Sorting 'zsco' and processing 'zsco_full'
    sort = sorted(zsco, reverse=True)
    for zsco_item in zsco_full:
        spl_zs = zsco_item.split("Y")
        if sort[0] == spl_zs[1]:
            print(" ".join(spl_zs))
            hits += 1
            gene_hits += 1
            entire += 1
    
    print(f" PAR::{hits}")
    fac.append(f"{hits}[[")
    jofff = " ".join(fac)
    NU_DE[nu_de] = jofff
    
    # Resetting lists and variables for next iteration
    hits = 0
    zsco = []
    zsco_full = []
    fac = []

# Printing results for single gene hits
print(f"SINGLE GENE :: {gene_hits}")
gene_hits = 0

# Processing unique gene names and calculating total hits
uniq_names = list(set(names))
for uniq_name in uniq_names:
    for nu_de in NU_DE:
        for nu_de_key in [nu_de]:
            splivalue = NU_DE[nu_de_key].split("[[")
            for item in splivalue:
                spcal = item.split("*")
                if uniq_name == spcal[0]:
                    sum += int(spcal[1])
    
    print(f"TOTAL HITS OF A SINGLE GENE :: {uniq_name} :: {sum}")
    sum = 0

