#!/bin/bash

# Check if the file containing domain names is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <domain_list_file>"
    exit 1
fi

# Check if amass is installed
if ! command -v subfinder &> /dev/null; then
    echo "Error: subfinder is not installed. Please install it before running this script."
    exit 1
fi

# Store the input file containing domain names
domain_list_file=$1

# Check if the input file exists
if [ ! -f "$domain_list_file" ]; then
    echo "Error: $domain_list_file does not exist."
    exit 1
fi

# Perform subdomain enumeration for each domain in the input file
while IFS= read -r domain; do
    echo "Enumerating subdomains for $domain..."
    subfinder -d "$domain" -o "$domain.txt"
    echo "Subdomain enumeration for $domain complete. Results saved in $domain.txt"
done < "$domain_list_file"

echo "All subdomain enumeration tasks completed."
