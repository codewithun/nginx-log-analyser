
#!/usr/bin/env bash

# Nginx Log Analyser
# Analyse the most frequent IPs, paths, status codes, and user agents.

set -o pipefail

# Validate arguments
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <log-file>"
    echo "Example: $0 nginx-access.log"
    exit 1
fi

LOG_FILE="$1"

# Validate input file
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: File '$LOG_FILE' does not exist."
    exit 1
fi

if [[ ! -r "$LOG_FILE" ]]; then
    echo "Error: File '$LOG_FILE' is not readable."
    exit 1
fi

if [[ ! -s "$LOG_FILE" ]]; then
    echo "Error: File '$LOG_FILE' is empty."
    exit 1
fi

# Print a section heading
print_header() {
    echo
    echo "========================================"
    echo "$1"
    echo "========================================"
}

# 1. Top 5 IP addresses
print_header "TOP 5 IP ADDRESSES BY REQUESTS"

awk '{print $1}' "$LOG_FILE" |
    sort |
    uniq -c |
    sort -rn |
    head -n 5 |
    awk '{printf "%-20s - %s requests\n", $2, $1}'

# 2. Top 5 requested paths
print_header "TOP 5 REQUESTED PATHS"

awk -F'"' 'NF >= 2 {
    split($2, request, " ")
    if (request[2] != "") print request[2]
}' "$LOG_FILE" |
    sort |
    uniq -c |
    sort -rn |
    head -n 5 |
    awk '{count=$1; $1=""; sub(/^ /, ""); printf "%-35s - %s requests\n", $0, count}'

# 3. Top 5 response status codes
print_header "TOP 5 RESPONSE STATUS CODES"

awk -F'"' 'NF >= 3 {
    split($3, response, " ")
    if (response[2] ~ /^[0-9][0-9][0-9]$/) print response[2]
}' "$LOG_FILE" |
    sort |
    uniq -c |
    sort -rn |
    head -n 5 |
    awk '{printf "%-10s - %s requests\n", $2, $1}'

# 4. Top 5 user agents
print_header "TOP 5 USER AGENTS"

awk -F'"' 'NF >= 6 && $6 != "" {
    print $6
}' "$LOG_FILE" |
    sort |
    uniq -c |
    sort -rn |
    head -n 5 |
    awk '{
        count=$1
        $1=""
        sub(/^ /, "")
        printf "%s - %s requests\n", $0, count
    }'

echo
echo "Analysis completed: $LOG_FILE"