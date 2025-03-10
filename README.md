# ASN and Subdomain Processing 

## Overview
This Bash script automates the process of:
1. Fetching **Autonomous System Numbers (ASNs)** for a given company and extracting associated IP ranges.
2. Performing HTTP checks on **subdomains** provided in a file.
3. Running both processes together if selected.

## Features
- Fetch ASNs from **BGPView**
- Extract CIDR IP ranges using `whois` and `mapcidr`
- Perform HTTP checks with `httpx`
- Process subdomains from a given file
- Save results to text files

## Requirements
Ensure the following tools are installed before running the script:
- `curl`
- `whois`
- `mapcidr` ([Install Guide](https://github.com/projectdiscovery/mapcidr))
- `httpx` ([Install Guide](https://github.com/projectdiscovery/httpx))
- `timeout` (built into most Unix/Linux systems)

## Installation
Clone this repository and navigate to the script location:
```sh
chmod +x script.sh
```

## Usage
Run the script:
```sh
./script.sh
```

### Options:
1. **Process ASNs only** – Fetches ASNs for a company, extracts IP ranges, and performs HTTP checks.
2. **Process Subdomains only** – Reads subdomains from a file and performs HTTP checks.
3. **Process Both** – Runs both ASN and subdomain processing.

## Output
- **asn-results.txt** – Contains HTTP responses from ASN-related IPs.
- **subdomain-results.txt** – Contains HTTP responses from subdomains.

## Example
### **Processing ASNs**
```
Enter the company name to search for ASNs: Google
[+] Fetching ASNs for: Google
[+] Found ASNs: 15169 19527
[+] Processing AS:15169
[+] Processing AS:19527
[+] ASN results saved in asn-results.txt
```

### **Processing Subdomains**
```
Enter the subdomain list file name (must be in the same directory): subdomains.txt
[+] Processing subdomains from subdomains.txt
[+] Subdomain results saved in subdomain-results.txt
```

## Notes
- The script uses `timeout 30` for `whois` to prevent hanging requests.
- If `whois` or `httpx` encounters an issue, errors are logged in the output.

## License
This project is open-source under the **MIT License**.

## Contribution
Feel free to submit pull requests or report issues!

---
### **Author**
Developed by sum.

