#!/usr/bin/env bash

# IaC scanning tools docker image tags
checkov_version="3.2.409"
kics_version="v2.1.7"
snyk_version="alpine"
trivy_version="0.62.0"

# Checkov
function run_checkov {
  echo Now running Checkov on all cases
  docker pull bridgecrew/checkov:$checkov_version

  docker run -t -v $PWD:/tf bridgecrew/checkov --download-external-modules true --quiet -d /tf > results/checkov_results.txt
}

# KICS
function run_kics {
  echo Now running KICS on all cases
  docker pull checkmarx/kics:$kics_version

  docker run --rm -v "$(pwd):/src" checkmarx/kics scan -p /src | grep -v "Executing queries" > results/kics_results.txt
}

# Snyk -> TODO FIX
function run_snyk {
  echo Now running Snyk on all cases

  if [ -z "$SNYK_TOKEN" ]; then
    echo "To run this script, you'll need to provide the SNYK_TOKEN environment variable."
    exit 1
  fi

  docker pull snyk/snyk:$snyk_version 
  docker run --rm -it --env SNYK_TOKEN -v $PWD/terraform:/app snyk/snyk:$snyk_version 'snyk iac test /app --report' > results/snyk_results.txt
}


function run_trivy {
  echo Now running Trivy on all cases
  docker pull aquasec/trivy:$trivy_version
  docker run -t -v $PWD:/tf aquasec/trivy config /tf > results/trivy_results.txt
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
*)
  run_all
  exit
  ;;
esac