# Pipeline

This setup is to test the IaC scanning tools in a Bitbucket Pipeline.

## Execution time

| **Runcount** | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   | 10  |
| ------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Checkov      | 21  | 22  | 20  | 19  | 20  | 22  | 22  | 18  | 18  | 19  |
| KICS         | 60  | 55  | 54  | 49  | 54  | 54  | 62  | 56  | 57  | 63  |
| Snyk         | 32  | 26  | 26  | 28  | 30  | 26  | 26  | 26  | 24  | 23  |
| Trivy        | 14  | 13  | 11  | 15  | 12  | 14  | 13  | 12  | 11  | 13  |

| **Runcount** | Gemiddelde | Mediaan |
| ------------ | ---------- | ------- |
| Checkov      | 20.1s      | 20s     |
| KICS         | 56.4s      | 55.5s   |
| Snyk         | 26.7       | 26      |
| Trivy        | 12.8s      | 13s     |
