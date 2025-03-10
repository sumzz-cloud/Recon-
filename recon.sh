#!/bin/bash

# Function to process ASNs
process_asns() {
    read -p "Enter the company name to search for ASNs: " company
    echo "[+] Fetching ASNs for: $company"
    
    # Get ASNs from BGPView
    asn_list=$(curl -s "https://bgpview.io/search/$company#results-asns" | grep -oP '(?<=<a href="https://bgpview.io/asn/)\d+')

    if [ -z "$asn_list" ]; then
        echo "[-] No ASNs found for $company."
        return
    fi

    echo "[+] Found ASNs: $asn_list"
    
    # Process each ASN
    for asn in $asn_list; do
        echo "[+] Processing AS:$asn"
        # Use timeout to prevent hanging
        timeout 30 whois -h whois.radb.net -- "-i origin AS$asn" | grep -Eo "([0-9.]+){4}/[0-9]+" | uniq | mapcidr -silent | httpx -status-code -title -content-length >> asn-results.txt
        if [ $? -ne 0 ]; then
            echo "[-] Error processing AS:$asn"
        fi
    done

    echo "[+] ASN results saved in asn-results.txt"
}

# Function to process subdomains
process_subdomains() {
    read -p "Enter the subdomain list file name (must be in the same directory): " subdomain_file
    
    if [ ! -f "$subdomain_file" ]; then
        echo "[-] File not found!"
        return
    fi

    echo "[+] Processing subdomains from $subdomain_file"
    cat "$subdomain_file" | httpx -status-code -title -content-length >> subdomain-results.txt
    echo "[+] Subdomain results saved in subdomain-results.txt"
}

# Main menu
echo "Select an option:"
echo "1 - Process ASNs only"
echo "2 - Process Subdomains only"
echo "3 - Process Both"
read -p "Enter your choice (1/2/3): " choice

case $choice in
    1) process_asns ;;
    2) process_subdomains ;;
    3) 
        process_asns
        process_subdomains
        ;;
    *) echo "Invalid choice. Exiting." ;;
esac
