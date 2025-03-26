#!/usr/bin/env python3

import sys
import os

# Open the file given as the first command-line argument
try:
    with open(sys.argv[1], 'r') as file:
        file_contents = file.readlines()
except IOError:
    print(f"Error: Unable to open file {sys.argv[1]}")
    print("Usage: python sepa_into_single_factor.py x.out")
    sys.exit(1)

c = 1  # Counter for file naming

for line in file_contents:
    line = line.strip()
    if line.startswith('>AT'):
        split_line = line.split()
        file_loc1 = os.path.join(sys.argv[2], f"{split_line[1]}_valid.outout{c}")
        out = f"LL{c}"
        try:
            with open(file_loc1, 'w') as out_file:
                out_file.write(f"{line}\n")
        except IOError:
            print(f"Error: Unable to write to file {file_loc1}")
            sys.exit(1)
        c += 1
    else:
        try:
            with open(out, 'a') as out_file:
                out_file.write(f"{line}\n")
        except UnboundLocalError:
            print("Error: Encountered non-header line before first header.")
            sys.exit(1)

print("Processing complete.")