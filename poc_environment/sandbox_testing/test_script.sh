#!/usr/bin/env bash

# IaC scanning tools docker image tags
checkov_version="3.2.409"
kics_version="v2.1.7"
snyk_version="alpine"
trivy_version="0.62.0"



# Verify that the first positional parameter is given, otherwise give error and usage guide
if [ -z "$1" ]; then
    echo "Error: Specify the iac tool to run"
    echo "Usage: $0 <run_all>/<run_checkov>/<run_kics>/<run_snyk>/<run/trivy> <iac-absolute-path>"
    exit 1
fi

# Verify that the absolute path is given as the second postional parameter, otherwise give error and show usage
terraform_path=$2
if [ -z "$terraform_path" ]; then
    echo "Error: Specify the Terraform directory to scan!"
    echo "Usage: $0 <run_all>/<run_checkov>/<run_kics>/<run_snyk>/<run/trivy> <iac-absolute-path>"
    exit 1
fi

# Checkov
function run_checkov {
  echo Now running Checkov on Terraform code
  docker pull bridgecrew/checkov:$checkov_version
  docker run -t -v $terraform_path:/tf bridgecrew/checkov:$checkov_version --version > versions/version_checkov.txt

  docker run -t -v $terraform_path:/tf bridgecrew/checkov:$checkov_version --download-external-modules true --quiet -d /tf > results/checkov_results.txt
}

# KICS
function run_kics {
  echo Now running KICS on Terraform code
  docker pull checkmarx/kics:$kics_version
  docker run -t -v $terraform_path:/tf checkmarx/kics:$kics_version version | awk '{print $NF}' > versions/version_kics.txt
 
  docker run --rm -v "$terraform_path:/src" checkmarx/kics:$kics_version scan -p /src | grep -v "Executing queries" > results/kics_results.txt
}

# Snyk
function run_snyk {
  echo Now running Snyk on Terraform code

  if [ -z "$SNYK_TOKEN" ]; then
    echo "To run this script, you'll need to provide the SNYK_TOKEN environment variable."
    exit 1
  fi

  docker pull snyk/snyk:$snyk_version 
  docker run --rm -it --env SNYK_TOKEN -v $terraform_path:/app snyk/snyk:$snyk_version 'snyk version' > versions/version_snyk.txt
  docker run --rm -it --env SNYK_TOKEN -v $terraform_path:/app snyk/snyk:$snyk_version 'snyk iac test /app --report' > results/snyk_results.txt
}

# Trivy
function run_trivy {
  echo Now running Trivy on Terraform code
  docker pull aquasec/trivy:$trivy_version
  docker run -t -v $terraform_path:/tf aquasec/trivy:$trivy_version --version > versions/version_trivy.txt
  
  docker run -t -v $terraform_path:/tf aquasec/trivy:$trivy_version config /tf > results/trivy_results.txt
}

function run_all {
  run_checkov
  run_kics
  run_snyk
  run_trivy
}

case $1 in
run_checkov)
  "$@"
  exit
  ;;
run_kics)
  "$@"
  exit
  ;;
run_snyk)
  "$@"
  exit
  ;;
run_trivy)
  "$@"
  exit
  ;;
run_all)
  run_all
  exit
  ;;
esac