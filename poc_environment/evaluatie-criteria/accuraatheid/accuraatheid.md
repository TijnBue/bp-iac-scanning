# Accuraatheid

De bedoeling van deze test is om de tools een aantal testcases te laten scannen, om zo na te gaan hoeveelheid kwetsbaarheden/misconfiguraties de tools kunnen ophalen.

## Testcases

Voor het uitvoeren van deze test, werden er 20 Terraform testcase opgezet die bewust kwetsbaarheden en misconfiguraties bevatten.
Uitleg over de testcase's is te vinden in [testcases.md](./test_cases/testcases.md), alsook de Terraform code in de map [test_cases/](./test_cases/)

## Uitvoering

```bash
vagrant@poc:/vagrant/evaluatie-criteria/accuraatheid$ ./accuracy_script.sh <run_all>/<run_checkov>/<run_kics>/<run_snyk>/<run/trivy>
```

## Resultaten

Na het uitvoeren van het Bash script worden de resultaten van elke tool opgeslagen in de map van de testcase.
Bijvoorbeeld:

```bash
test_cases/
└── 01_password_secrets/
    ├── checkov_results.txt
    ├── kics_results.txt
    ├── main.tf
    ├── snyk_results.txt
    └── trivy_results.txt
```

### Verwerkte resultaten

Deze tabel geeft een overzicht van de accuraatheid van de IaC scanning tools op basis van 20 testgevallen.

- Een `V` geeft aan dat de tool de misconfiguratie correct detecteerde.
- Een `X` betekent dat de tools de misconfiguratie niet detecteerde
- Superscripts (zoals X 1.) verwijzen naar opmerkingen over de betreffende detectie, bijvoorbeeld afwijkende meldingen, gedeeltelijke detectie. Deze toelichtingen worden verder uitgelegd onderaan de tabel.

| Test Case                          | Checkov | KICS  | Snyk | Trivy |
| ---------------------------------- | :-----: | :---: | :--: | :---: |
| 1_plaintext_secrets                |  X 1.   |   V   |  X   |   X   |
| 2_keyvault_no_soft_delete          |    V    |   X   |  V   |   V   |
| 3_func_app_http_only               |    V    | X 2.  |  X   |   X   |
| 4_func_app_not_latest_tls          |    V    |   X   |  X   |   X   |
| 5_func_app_public_access           |    V    |   X   |  X   |   X   |
| 6_storage_acc_public               |    V    |   V   |  X   |   X   |
| 7_storage_acc_logging              |    V    |   X   |  X   |   X   |
| 8_storage_acc_http                 |    X    |   V   |  X   |   X   |
| 9_aks_no_private_cluster           |    V    |   V   | V 3. | V 3.  |
| 10_aks_cluster_rbac_disabled       |    X    |   x   |  x   |   V   |
| 11_aks_logging                     |    V    |   X   |  X   |   V   |
| 12_network_sec_rule_permit_traffic |    X    | V 4.  | V 4. | V 4.  |
| 13_no_security_contact_enabled     |    V    |   V   |  V   |   V   |
| 14_acr_container_image_quarantine  |    V    |   X   |  V   |   X   |
| 15_acr_public                      |    V    |   X   |  X   |   X   |
| 16_managed_disk_no_encryption      |    V    |   V   |  X   |   X   |
| 17_vm_basic_auth_enabled           |    V    |   V   |  V   |   V   |
| 18_virtual_network_ddos_plan       |    X    |   V   |  V   |   X   |
| 19_acr_admin_enabled               |    V    |   V   |  V   |   X   |
| 20_postgress_db_ssl_enforcement    |    V    |   V   |  V   |   V   |
|                                    |         |       |      |       |
| TOTAL                              |  15/20  | 11/20 | 9/20 | 8/20  |

#### Toelichting opvallende resultaten

1. Beperkte detectie van plaintext wachtwoorden door Checkov
   - Testcase 1, twee plain text secrets, namelijk ``H@Sh1CoR3!` en `4-v3ry-53cr37-p455w0rd`. Opvallend is dat Checkov maar één wachtwoord detecteert.
2. Beperkingen van KICS bij Azure Function Apps
   - Opvallend aan deze testcase is dat KICS op alle testcases die gebruikmaken van Azure Function Apps geen misconfiguraties detecteren.
     Specifiek voor testcase 3, is KICS niet in staat om de een Azure Function app te detecteren die geen HTTPS forceert.
     Dit kan te verklaren zijn vanwege het gebrek aan Terraform regels voor Azure Function Apps
3. Verschillende interpretaties van AKS-beveiliging tussen tools
   - Vervolgens is er bij testcase nr. 9 een verschil te zien tussen de tools Checkov en KICS enerzijds, en Snyk en Trivy anderzijds.
     De eerste twee tools detecteren succesvol dat het aanbevolen is om gebruik te maken van een private Azure Kubernetes Cluster.
     De andere twee tools raden daarentegen aan om een reeks geautoriseerde IP-adressen te configureren, om zo de API-toegang tot het AKS-cluster beter te beveiligen.
4. Verschillen in detectie van publieke netwerktoegang
   - Tot slot, werd er ook opvallende verschillen opgemerkt tussen de tools bij testcase 12.
     Deze testcase maakt gebruik van de Terraform resource `azurerm_network_security_rule` voor een netwerk regel te configureren.
     De regel laat SSH connecties van elk bron toe, wat niet bepaald veilig is.
