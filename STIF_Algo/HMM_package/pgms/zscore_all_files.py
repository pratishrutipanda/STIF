#!/usr/bin/env python3

import sys
import os
import re

perl_script = sys.argv[1]
directory = sys.argv[2]

try:
    with os.scandir(directory) as dir_entries:
        n = 0
        for entry in dir_entries:
            if entry.is_file() and re.match(r'(\w+.?\w+)_valid.outout\d*', entry.name):
                file_name = entry.name
                base_name = re.match(r'(\w+.?\w+)_valid.outout\d*', file_name).group(1)
                print(f"SS :: {file_name} :: {base_name}")
                cmd1 = f"perl {perl_script}/zscore.pl {directory}/{file_name} {directory} > {directory}/{base_name}.zsco"
                # print(cmd1)
                os.system(cmd1)
                n += 1
        print(f"CNT :: {n}")
except FileNotFoundError:
    print(f"Error: Directory {directory} not found")
    sys.exit(1)
