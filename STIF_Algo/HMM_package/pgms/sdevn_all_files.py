#!/usr/bin/env python3

import os
import sys
import re

# Get Perl script path from command-line argument
perl_script = sys.argv[1]
print(perl_script)

# Open directory given in second command-line argument
dir_path = sys.argv[2]
dir_list = os.listdir(dir_path)

n = 0  # Counter for processed files

for filename in dir_list:
    if re.match(r'(\w+)_full\d*', filename):
        file_name = re.match(r'(\w+)_full\d*', filename).group(1)
        print(f"SS :: {filename} :: {file_name}\n")
        cmd1 = f"perl {perl_script}/sdevn.pl {dir_path}/{filename} > {dir_path}/{file_name}.sd"
        #print(f"{cmd1}\n")
        os.system(cmd1)
        n += 1

print(f"CNT :: {n}\n")