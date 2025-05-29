# Evaluatiecriteria: Output van IaC Scanning Tools

Deze map bevat een Terraform project en een script dat meerdere IaC scanningtools uitvoerd om het project te scannen. 
Het doel is om de outputkwaliteit van deze tools objectief te vergelijken volgens vooraf gedefinieerde criteria.

## Overzicht

```bash
evaluatie-criteria/
└── output/
    ├── results/
    │   ├── checkov_results.tf
    │   └── ...
    ├── terraform/
    │   └── main.tf
    └── output_script.tf
```

## Uitvoering

```bash
vagrant@poc:/vagrant/evaluatie-criteria/output$ ./output_script.sh
```