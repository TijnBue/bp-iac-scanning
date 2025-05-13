# Accuraatheid

De bedoeling van deze test is om de tools een aantal testcases te laten scannen, om zo na te gaan hoeveelheid kwetsbaarheden/misconfiguraties de tools kunnen ophalen.

## Testcases

1. Plain text wachtwoord voor database
2. function app http only
3. Publiek toegankelijk storage account
4. Keyvault no purge protection
5. AKS no private cluster
6. Network security rule that allows ssh traffic from anywhere
7. No security alert for admin
8. Storage account logging
9. func app not enforcing latest tls version
10. cluster rbac disabled
11. storage account force https on false
12. Public function app
13. ACR public access
14. Ensure container image quarantine, scan, and mark images verified
15. Ensure AKS logging to Azure Monitoring is Configured
16. Azure managed disk not encrypted
17. Azure Instances should use SSH Key instead of basic authentication
18. Virtual Network DDOS plan enabled
19. Azure Container Registry with Admin Account Enabled
20. Postgress database without minimal SSL version

Ensure Terraform module sources use a commit hash

## Workflows

```bash
./accuracy_script.sh run_all /vagrant/own-test/evaluatie-criteria/accuraatheid/test_cases/

```

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
| 12_network_sec_rule_permit_traffic |    X    | V 4.  | V 5. | V 6.  |
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

- If pwd is ""4-v3ry-53cr37-p455w0rd"" - then "Base64 High Entropy String" - https://docs.prismacloud.io/en/enterprise-edition/policy-reference/secrets-policies/secrets-policy-index/git-secrets-6

1. Detects strings with a "high Entropy" is a concept used to assign a numerical score to how unpredictable a password is or the likelihood of highly random data in a string of characters
   \*\* d

2. Does detect storage account not forcing https
   - KICS doesn't support this resource??
3. Says more that the API server allows public acces
4. Specifically about the port (Sensitive Port Is Exposed To Entire Network)
5. Says that networking security rule allows public access
6. Saids that security group rule allows unrestricted ingress form any ip and ingress to ssh port from any address

storage acc tls
