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
hhh = {}

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
            kkk = item
        elif item.startswith('Z-SCORE'):
            if kkk in hhh:
                hhh[kkk] += item + "+++"
            else:
                hhh[kkk] = item + "+++"
    
    # Processing each key in 'hhh'
    for kkk in hhh:
        print(kkk)
        hhh_split = hhh[kkk].split("+++")
        hash_dict = {}
        
        # Processing each subsection in 'hhh[kkk]'
        for section in hhh_split:
            if section.strip():
                spl_zs = re.split(r'\s+|\t+', section)
                key = spl_zs[3]
                hash_dict[key] = f"{spl_zs[0]}++{spl_zs[1]}++{spl_zs[2]}++{spl_zs[4]}++{spl_zs[5]}**"
        
        # Processing each key in 'hash_dict'
        for key in hash_dict:
            spl_fin = hash_dict[key].split("++")
            print(f"{spl_fin[0]}\t{spl_fin[1]}\t{spl_fin[2]}\t{key}\t{spl_fin[3]}\t{spl_fin[4]}\t{spl_fin[5]}")
        print()

