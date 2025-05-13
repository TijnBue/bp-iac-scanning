# Evaluatiecriteria: tijd

## Workflow

Run the script by the following

```bash
# ./tijd_script.sh <terraform_path>
```

Used dataset for this test: `datasets/terraform_stage` using the following command

```bash
./tijd_script.sh /vagrant/datasets/terraform_stage/
```

## Results

Time in seconds

| **Runcount** | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   | 10  |
| ------------ | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Checkov      | 7   | 6   | 6   | 6   | 6   | 6   | 7   | 7   | 6   | 6   |
| KICS         | 62  | 58  | 60  | 58  | 60  | 60  | 60  | 60  | 63  | 63  |
| Snyk         | 13  | 15  | 14  | 15  | 13  | 13  | 13  | 13  | 14  | 13  |
| Trivy        | 6   | 6   | 5   | 5   | 6   | 5   | 6   | 5   | 5   | 5   |

| **Runcount** | Gemiddelde | Mediaan |
| ------------ | ---------- | ------- |
| Checkov      | 6.30s      | 6s      |
| KICS         | 60.40s     | 60s     |
| Snyk         | 13.60s     | 13s     |
| Trivy        | 5.40s      | 5s      |

Grafiek: zie Excel
