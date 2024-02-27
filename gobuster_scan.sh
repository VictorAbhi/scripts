#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <urls_file>"
    exit 1
fi

urls_file="$1"

if [ ! -f "$urls_file" ]; then
    echo "Error: File not found: $urls_file"
    exit 1
fi

# Specify the wordlist and extensions
wordlist="/usr/share/wordlists/wfuzz/others/iis.txt"
#extensions=".aspx,.txt,.php,.html,.asp,.ashx,.wsdl,.wadl,.asmx,.xml,.zip"

# Create a directory to store the results
output_dir="gobuster_results"
mkdir -p "$output_dir"

# Loop through each URL in the file
while IFS= read -r url; do
    # Extracting domain is not necessary for Gobuster
    # Run Gobuster for each URL
    echo "Running Gobuster for $url..."
    gobuster dir -u "$url" -w "$wordlist" -o "$output_dir/gobuster_$(echo "$url" | sed 's/[^a-zA-Z0-9]/_/g').txt"
done < "$urls_file"

echo "Gobuster scan completed."
