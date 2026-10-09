# Nginx Log Analyser

A simple Bash CLI tool that analyses Nginx access logs and identifies the most frequent IP addresses, requested paths, HTTP response status codes, and user agents.

This project was created as part of the [roadmap.sh Nginx Log Analyser project](https://roadmap.sh/projects/nginx-log-analyser).

## Features

* Find the top 5 IP addresses by request count
* Find the top 5 most requested paths
* Find the top 5 HTTP response status codes
* Find the top 5 user agents
* Validate command-line arguments and input files
* Process logs using standard Linux command-line tools

## Requirements

* Linux or Unix-like environment
* Bash
* `awk`
* `sort`
* `uniq`
* `head`
* `curl` (for downloading the sample dataset)

## Installation

Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/nginx-log-analyser.git
cd nginx-log-analyser
```

Download the sample access log:

```bash
curl -fL "https://gist.githubusercontent.com/nilbuild/e66c3b9ea89a1a030d3b739eeeef22d0/raw/77fb3ac837a73c4f0206e78a236d885590b7ae35/nginx-access.log" -o nginx-access.log
```

Make the script executable:

```bash
chmod +x nginx-log-analyser.sh
```

## Usage

```bash
./nginx-log-analyser.sh nginx-access.log
```

You can also analyse another readable access log:

```bash
./nginx-log-analyser.sh /path/to/access.log
```

## How It Works

The script extracts relevant fields from each access log entry, counts occurrences, sorts the results by frequency, and prints the five most frequent values for each category.

### Commands Used

* `awk`: Extracts IP addresses, request paths, status codes, and user agents.
* `sort`: Groups identical values and orders counts.
* `uniq -c`: Counts repeated values.
* `sort -rn`: Sorts counts in descending numeric order.
* `head -n 5`: Selects the five most frequent results.

## Learning Goals

* Bash scripting and command-line arguments
* Pipes and command composition
* Text processing with `awk`
* Counting and sorting log data
* Understanding Nginx access log fields
* Basic input validation

## Project Reference

https://roadmap.sh/projects/nginx-log-analyser

## License

Available for educational and personal learning purposes.
