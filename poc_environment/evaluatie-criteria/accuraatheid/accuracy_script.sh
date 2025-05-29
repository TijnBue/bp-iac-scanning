#!/usr/bin/env bash

# IaC scanning tools docker image tags
checkov_version="3.2.409"
kics_version="v2.1.7"
snyk_version="alpine"
trivy_version="0.62.0"

function time_command {
  tool_name=$1
  shift
  echo "Starting $tool_name scan at $(date)"
  start_time=$(date +%s)
  "$@"
  end_time=$(date +%s)
  execution_time=$((end_time - start_time))
  echo "$tool_name scan completed in $execution_time seconds"
  echo "$tool_name: $execution_time seconds" >> results/timing_results.txt
}

# Verify that the first positional parameter is given, otherwise give error and usage guide
if [ -z "$1" ]; then
    echo "Error: Specify the iac tool to run"
    echo "Usage: $0 <run_all>/<run_checkov>/<run_kics>/<run_snyk>/<run/trivy>"
    exit 1
fi

# Checkov
function run_checkov {
  echo Now running Checkov on all testcases
  docker pull bridgecrew/checkov:$checkov_version

  find . -name "main.tf" -exec dirname {} \; | grep -v "\.terraform" | while read -r test_case; do
    echo $test_case
    ORG_PATH=$PWD
    cd $test_case
    docker run -t -v $PWD:/tf bridgecrew/checkov:$checkov_version --download-external-modules true --quiet -d /tf > checkov_results.txt
    cd $ORG_PATH
  done
}

# KICS
function run_kics {
  echo Now running KICS on all testcases
  docker pull checkmarx/kics:$kics_version

  find . -name "main.tf" -exec dirname {} \; | grep -v "\.terraform" | while read -r test_case; do
    echo $test_case 
    ORG_PATH=$PWD
    cd $test_case
    docker run --rm -v "$PWD:/src" checkmarx/kics:$kics_version scan -p /src | grep -v "Executing queries" > kics_results.txt
    cd $ORG_PATH
  done
}

# Snyk
function run_snyk {
  echo Now running Snyk on all testcases

  if [ -z "$SNYK_TOKEN" ]; then
    echo "To run this script, you'll need to provide the SNYK_TOKEN environment variable."
    exit 1
  fi

  docker pull snyk/snyk:$snyk_version 

  find . -name "main.tf" -exec dirname {} \; | grep -v "\.terraform" | while read -r test_case; do
    echo $test_case
    ORG_PATH=$PWD
    cd $test_case
    docker run --rm -t --env SNYK_TOKEN -v $PWD:/app snyk/snyk:$snyk_version 'snyk iac test /app --report' > snyk_results.txt
    cd $ORG_PATH
  done
}

# Trivy
function run_trivy {
  echo Now running Trivy on all testcases
  docker pull aquasec/trivy:$trivy_version

  find . -name "main.tf" -exec dirname {} \; | grep -v "\.terraform" | while read -r test_case; do
    echo $test_case
    ORG_PATH=$PWD
    cd $test_case
    docker run -t -v $PWD:/myapp aquasec/trivy:$trivy_version config /myapp > trivy_results.txt
    cd $ORG_PATH
  done
}

function run_all {
  time_command "Checkov" run_checkov
  time_command "KICS" run_kics
  time_command "Snyk" run_snyk
  time_command "Trivy" run_trivy
}

echo "===================" >> results/timing_results.txt
echo "Tool Execution Times" >> results/timing_results.txt
echo "===================" >> results/timing_results.txt

# Generate a simple report
echo -e "\nSCAN TIMING RESULTS"
echo "==================="
cat results/timing_results.txt

echo -e "\nDetailed scan results are available in the results directory."

case $1 in
run_checkov)
  time_command "Checkov" run_checkov
  exit
  ;;
run_kics)
  time_command "KICS" run_kics
  exit
  ;;
run_snyk)
  time_command "Snyk" run_snyk
  exit
  ;;
run_trivy)
  time_command "Trivy" run_trivy
  exit
  ;;
run_all)
  run_all
  exit
  ;;
esac