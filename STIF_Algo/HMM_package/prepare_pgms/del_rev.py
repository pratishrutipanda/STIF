import sys

# Check if the script is called with the correct arguments
if len(sys.argv) != 2:
    print("Type 'python script_name.py x.seq'")
    sys.exit(1)

input_file = sys.argv[1]

try:
    with open(input_file, 'r') as fwd:
        fwd_lines = fwd.readlines()
except FileNotFoundError:
    print(f"Error: File '{input_file}' not found.")
    sys.exit(1)

hash = {}
key = None

# Process each line in the file
for line in fwd_lines:
    line = line.strip()
    if line.startswith('>'):
        key = line
    else:
        if key:
            if key not in hash:
                hash[key] = ''
            hash[key] += line

# Output sequences with keys starting with 'REVERSE'
for key in hash:
    if key.split()[3] == 'REVERSE':
        print(f"{key}\n{hash[key]}")