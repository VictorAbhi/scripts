#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

domain="$1"
subdomains_file="subdomains.txt"
output_file="nmap_results.txt"

# Extract subdomains from the file
subdomains=$(cat "$subdomains_file")

# Run Nmap for each subdomain
for subdomain in $subdomains; do
  echo "Scanning $subdomain"
  nmap -sC -sV -A "$subdomain" >> "$output_file"
done

echo "Scanning completed. Results saved to $output_file"
