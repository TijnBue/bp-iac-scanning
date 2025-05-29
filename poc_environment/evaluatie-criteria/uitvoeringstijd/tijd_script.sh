#!/usr/bin/env bash
# IaC scanning tools docker image tags
checkov_version="3.2.409"
kics_version="v2.1.7"
snyk_version="alpine"
trivy_version="0.62.0"

# Create results directory if it doesn't exist
mkdir -p results

# Pull Docker Images
echo "Pulling all of the Docker Images for the tools"
echo "==============================================" 
docker pull bridgecrew/checkov:$checkov_version
docker pull checkmarx/kics:$kics_version
docker pull snyk/snyk:$snyk_version 
docker pull aquasec/trivy:$trivy_version

# Verify that the absolute path is given as the second postional parameter, otherwise give error and show usage
terraform_path=$1
if [ -z "$terraform_path" ]; then
    echo "Error: Specify the Terraform directory to scan!"
    echo "Usage: $0 <run_all>/<run_checkov>/<run_kics>/<run_snyk>/<run/trivy> <iac-absolute-path>"
    exit 1
fi

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

# Checkov
function run_checkov {
  echo "Now running Checkov on all cases"
  docker run -t -v $terraform_path:/tf bridgecrew/checkov:$checkov_version --download-external-modules true -d /tf > results/checkov_results.txt 
}

# KICS
function run_kics {
  echo "Now running KICS on all cases"
  docker run --rm -v $terraform_path:/src checkmarx/kics:$kics_version scan -p /src > results/kics_results.txt
}

# Snyk
function run_snyk {
  echo Now running Snyk on Terraform code

  if [ -z "$SNYK_TOKEN" ]; then
    echo "To run this script, you'll need to provide the SNYK_TOKEN environment variable."
    exit 1
  fi

  docker run --rm -it --env SNYK_TOKEN -v $terraform_path:/app snyk/snyk:$snyk_version 'snyk iac test /app --report' > results/snyk_results.txt
}

# Trivy
function run_trivy {
  echo "Now running Trivy on all cases"
  docker run --rm -v $terraform_path:/tf aquasec/trivy:$trivy_version config /tf > results/trivy_results.txt
}

echo "===================" >> results/timing_results.txt
echo "Tool Execution Times" >> results/timing_results.txt
echo "===================" >> results/timing_results.txt

# Run all tools with timing
time_command "Checkov" run_checkov
time_command "KICS" run_kics
time_command "Snyk" run_snyk
time_command "Trivy" run_trivy

# Generate a simple report
echo -e "\nSCAN TIMING RESULTS"
echo "==================="
cat results/timing_results.txt

echo -e "\nDetailed scan results are available in the results directory."