# Evaluatiecriteria: tijd

## Workflow

Voer het script als volgt uit

```bash
vagrant@poc:/vagrant/evaluatie-criteria/output$# ./tijd_script.sh <terraform_path>
```

## Resultaten

### Terraform project

Voor deze test wordt er gebruik gemaakt van een Terraform project voor het provisioneren van een Azure infrastructuur.
Het Terraform project kan gebruikt worden voor de volgende Azure resources aan te maken:

- Azure Storage Accounts met Storage Containerisatie
- Azure Kubernetes Service
- Azure Automation Account met Runbooks
- Azure Container registry
- MySQL Flexible server met MySQL Database
- Azure Keyvault
- Entra ID App registrations

Time in seconds

| **Runcount** | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   | 10  |
| ------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Checkov (s)  | 7   | 6   | 6   | 6   | 6   | 6   | 7   | 7   | 6   | 6   |
| KICS (s)     | 62  | 58  | 60  | 58  | 60  | 60  | 60  | 60  | 63  | 63  |
| Snyk (s)     | 13  | 15  | 14  | 15  | 13  | 13  | 13  | 13  | 14  | 13  |
| Trivy (s)    | 6   | 6   | 5   | 5   | 6   | 5   | 6   | 5   | 5   | 5   |

| **Runcount** | Gemiddelde | Mediaan | Standaardafwijking (s) |
| ------------ | ---------- | ------- | ---------------------- |
| Checkov      | 6.30s      | 6s      | 0.48s                  |
| KICS         | 60.40s     | 60s     | 1.78s                  |
| Snyk         | 13.60s     | 13s     | 0.84s                  |
| Trivy        | 5.40s      | 5s      | 0.52s                  |

## Klein terraform project

Gebruikte dataset: `datasets/klein_terraform_project`. Dit bevat een `main.tf` bestand met Terraform code voor het aanmaken van een Azure Kubernetes Cluster.

| **Runcount** | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   | 10  |
| ------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Checkov (s)  | 6   | 7   | 8   | 8   | 7   | 6   | 7   | 8   | 7   | 7   |
| KICS (s)     | 61  | 63  | 62  | 58  | 61  | 63  | 62  | 63  | 65  | 60  |
| Snyk (s)     | 12  | 11  | 12  | 12  | 14  | 12  | 12  | 14  | 12  | 12  |
| Trivy (s)    | 3   | 4   | 3   | 3   | 2   | 3   | 2   | 3   | 3   | 3   |

| **Runcount** | Gemiddelde | Mediaan | Standaardafwijking (s) |
| ------------ | ---------- | ------- | ---------------------- |
| Checkov      | 6.30s      | 6s      | 0.48s                  |
| KICS         | 60.40s     | 60s     | 1.78s                  |
| Snyk         | 13.60s     | 13s     | 0.84s                  |
| Trivy        | 5.40s      | 5s      | 0.52s                  |
