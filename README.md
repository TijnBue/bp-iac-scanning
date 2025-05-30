# IaC scanning tools - Proof of Concept repository

Deze repository bevat de proof-of-conceptomgeving die wordt gebruikt om de Infrastructure as Code-scantools Checkov, KICS, Snyk en Trivy te vergelijken.

# Gebruikte tools en versies

| Technologie                 | Tool         | Version   |
| --------------------------- | ------------ | --------- |
| Virtualisatie               | `VirtualBox` | `7.1.8`   |
| Automatisatie Virtualisatie | `Vagrant`    | `2.4.5`   |
| Containerisatie             | `Docker`     | `28.1.1 ` |

|             | VM specs             |
| ----------- | -------------------- |
| OS          | `Ubuntu 24.04 LTS`   |
| Vagrant box | `bento/ubuntu-24.04` |
| CPU's       | `2`                  |
| RAM         | `4096 MB`            |
| Adapters    | `NAT & Host-only`    |
| IP Address  | `192.168.56.10`      |

## Omgeving opzetten

Voer de volgende commando's uit in de `poc_environment/` map

```bash
# List vagrant machines
vagrant status

# Create vagrant machine
vagrant up

# Connect to vagrant machine
vagrant ssh poc
```

## Overzicht van de gebruikte Docker Images voor de IaC scanning tools

| Tool    | Docker Image version |
| ------- | -------------------- |
| Checkov | `3.2.409 `           |
| KICS    | `v2.1.7`             |
| Snyk    | `alpine`\*           |
| Trivy   | `0.62.0`             |

\* with Snyk CLI version 1.1296.2

## Proof of concept overzicht

De vergelijking van de IaC scanning tools gebeurt aan de hand van vier evaluatiecriteria.

1. [Accuraatheid](./poc_environment/evaluatie-criteria/accuraatheid/accuraatheid.md)
2. [Bitbucket Pipeline](./poc_environment/evaluatie-criteria/bitbucket_pipeline/bitbucket_pipeline.md)
3. [Output](./poc_environment/evaluatie-criteria/output/output.md)
4. [Uitvoeringstijd](./poc_environment/evaluatie-criteria/uitvoeringstijd/uitvoeringstijd.md)



