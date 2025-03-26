#!/usr/bin/env python3

import sys
import re

# Checking command line arguments
if len(sys.argv) != 2:
    print("Usage: python normalisation.py <input_file>")
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
DE_NU = []
NU_DE = []
entire = 0

# Parsing the input file
for line in file_content:
    line = line.rstrip('\n')
    if re.match(r'^\*\*\*\*(\w+)', line):
        kk = re.match(r'^\*\*\*\*(\w+)', line).group(1)
        DE_NU.append(kk)
    elif re.match(r'^>|^Z-SCORE|^ PAR|^ENTIRE|^TOTAL|^SINGLE', line):
        if kk in full:
            full[kk] += line + "[[["
        else:
            full[kk] = line + "[[["
        
        if re.match(r'^SINGLE', line) or re.match(r'^ENTIRE', line):
            if re.match(r'^SINGLE', line):
                sppp = line.split("::")
                DE_NU.append("-" + sppp[1] + "LLL")
            else:
                spentire = line.split("::")
                entire = spentire[1]
        elif re.match(r'^TOTAL', line):
            TO = line.split("::")
            NU_DE.append(f"{TO[1]}={TO[2]}*")

#print("NU __ DE ::", " ".join(NU_DE))

jonu_de = "".join(NU_DE)
#print("NU _ DE", jonu_de)

spcalcal = jonu_de.split("*")
#print("DE __ NU ::", " ".join(DE_NU))

jode_nu = "".join(DE_NU)
#print("DE_NU ::", jode_nu)
#print("ENTIRE : DE _DE :", entire)

spde_nu = jode_nu.split("LLL")

# Processing each key in 'full'
for kk in full:
    print(f"****{kk}")
    for w in range(len(spde_nu)):
        cal = full[kk].split("[[[")

    for item in cal:
        if item.startswith('>'):
            key = item
    
        elif re.match(r'^ PAR|^Z-SCORE', item):
            if re.match(r'^ PAR', item):
                hash_dict[key] = item + "+++"
            else:
                hash_dict[key] = item + "*"

    for section in spcalcal:
        sp1 = section.split("=")

    for kk in hash_dict:
        for key in hash_dict:
            spkee = key.split("|")
            nu_de = spkee[1]
            fac.append(f"{spkee[6]}*")
            names.append(spkee[6])  
            sp = hash_dict[key].split("+++")

            spnu_de = jonu_de.split("*")
            split_fin = section.split("=")

            for item in spde_nu:
                spppde_nu = item.split("-")
                if spppde_nu[0] == kk:
                    spkee1 = key.split("|")
                    if split_fin[0] == spkee1[6]:
                        print(key)
                        for value in sp:
                            if not re.match(r'^ PAR', value):
                                print(value)
                            if not re.match(r'^Z-SCORE', value):
                                nu_nu = value[6:]
                                normali = (float(nu_nu) / float(split_fin[1])) / (float(spppde_nu[1]) / float(entire))
                                normal = "{:.3f}".format(normali)
                                print(f"NORMALISATION :: {normal}/{entire}")

    print("________________")
    hash_dict.clear()
