# Accuraatheid: beschrijving testcases

## Testcase 1: Plain text secret

In de eerste testcase wordt er bewust een plaintext secret gebruikt voor een administratorgebruik in een Azure MySQL Flexible Server.  
Deze testcase bevat namelijk twee verschillende plaintext administrator wachtwoorden.  
Ten eerste wordt er gebruik gemaakt van een willekeurig gegenereerd wachtwoord, zoals `H@Sh1CoR3!`.  
Het tweede wachtwoord dat wordt gebruikt is: `4-v3ry-53cr37-p455w0rd`.

## Testcase 2: Azure Keyvault zonder soft delete

De volgende testcase bestaat uit Terraform code om een Azure Keyvault aan te maken voor het opslaan van wachtwoorden, certificaten, enz.
Hoewel de keyvault niet is geconfigureerd met een soft delete beleid. Dit betekent dat als men per ongeluk een wachtwoord verwijdert, het onmogelijk is om het wachtwoord terug te herstellen.

## Testcase 3: Azure Function App met enkel HTTP

Deze testcase maakt een Azure Linux Function App aan. In de Terraform code is de parameter https_only expliciet ingesteld op false.
Dit betekent dat de Function App zowel HTTP- als HTTPS-verkeer toestaat. Hierdoor wordt verkeer over een onbeveiligd protocol toegelaten,
wat kan leiden tot man-in-the-middle-aanvallen of het onderscheppen van gevoelige gegevens tijdens transport.

## Testcase 4: Function App met oude TLS versie

De volgende testcase bevat Terraform-code om een Azure Linux Function App aan te maken.
De configuratie bevat een misconfiguratie, namelijk: de minimum_tls_version is ingesteld op 1.0.
Dit is volgens Moriarty (2021) een verouderde en ook deprecated versie van het Transport Layer Security-protocol.

## Testcase 5: Function App met publieke toegang

In deze testcase wordt een Linux Function App gedefinieerd met publieke netwerktoegang toegestaan.
De parameter public_network_access_enabled is ingesteld op true, wat betekent dat de Function App publiek toegankelijk is via het internet.
Hierdoor kan iedereen met het juiste endpoint de applicatie benaderen, wat het aanvalsoppervlak vergroot en het risico op ongeautoriseerde toegang verhoogt.

## Testcase 6: Azure Storage Account met publieke toegang

Deze testcase bestaat uit een Azure Storage Account dat publiek toegankelijk is.
Door de parameter public_network_access_enabled op true te zetten is het Storage Account publiek beschikbaar.

## Testcase 7: Azure Storage Account zonder logging

Deze testcase beschrijft een Azure Storage Account waarbij logging niet is geconfigureerd.
Logging is van cruciaal belang omdat het inzicht kan geven in succesvolle én gefaalde verzoeken, zoals time-outs, autorisatiefouten en netwerkproblemen.
Hierdoor kunnen beheerders verdachte activiteiten detecteren, fouten analyseren en de beveiliging en prestaties beter monitoren.

## Testcase 8: Azure Storage Account met HTTP

In deze testcase wordt de parameter https_traffic_only_enabled ingesteld op false voor een Azure Storage Account.

## Testcase 9: Publiek Azure Kubernetes Service cluster

Deze testcase bevat een Azure Kubernetes Service (AKS) cluster configuratie, gemaakt met behulp van de Terraform-resource azurerm_kubernetes_cluster.
Hoewel deze configuratie een AKS-cluster aanmaakt, is de beveiliging niet optimaal.
De Kubernetes API is namelijk publiek toegankelijk.

## Testcase 10: Azure Kubernetes Service zonder RBAC

Deze testcase bevat Terraform-code voor het opzetten van een AKS cluster zonder Role-Based Access Control (RBAC).
RBAC maakt het mogelijk om toegang tot Azure-resources te beheren op basis van rollen.
Zonder RBAC krijgt elke gebruiker standaard volledige beheerdersrechten (cluster-admin) op het cluster.

## Testcase 11: Azure Kubernetes Service zonder logging

Deze testcase bevat Terraform-code voor het opzetten van een AKS-cluster zonder expliciete logging-configuratie.
Logging is essentieel voor het monitoren van prestaties, foutdetectie en het verbeteren van beveiliging.

## Testcase 12: Azure Network regel

Deze testcase definieert een Azure Network Security Group waaraan een netwerkregel wordt gekoppeld via de resource azurerm_network_security_rule.
De netwerkregel laat inkomend verkeer toe van elke bron naar poort 22 (SSH).

## Testcase 13: Security Center zonder alerts

Deze testcase gebruikt de Terraform-resource azurerm_security_center_contact.
De configuratie zet de parameters alert_notifications en alerts_to_admin op false, wat betekent dat er geen waarschuwingen worden verstuurd.

## Testcase 14: Azure Container Registry zonder Image Quarantine

In deze testcase wordt een Azure Container Registry aangemaakt waarbij de optie Image Quarantine is uitgeschakeld.
Deze beveiligingsfunctie blokkeert tijdelijk nieuwe of aangepaste container images totdat ze gescand zijn op kwetsbaarheden.

## Testcase 15: Azure Container Registry met publieke toegang

In deze testcase wordt een publiek toegankelijke Azure Container Registry gedefinieerd.

## Testcase 16: Azure Managed Disk zonder encryptie

Deze testcase definieert een Azure Managed Disk zonder enige vorm van encryptie.
Encryptie van opslagvolumes is een gangbare best practice in cloudbeveiliging.

## Testcase 17: Azure Virtual Machine met basis authenticatie

Deze testcase beschrijft een virtuele machine in Azure waarbij authenticatie gebeurt via gebruikersnaam en wachtwoord.
Er worden geen SSH-sleutels gebruikt, wat een beveiligingsrisico inhoudt.

## Testcase 18: Virtual Network zonder DDoS plan

Deze testcase beschrijft een Azure Virtual Network, maar mist een cruciale configuratie: een Azure DDoS-beschermingsplan.

## Testcase 19: Azure Container Registry met een admin account

Deze testcase bevat een Azure Container Registry waarbij het administrator account is geactiveerd.

## Testcase 20: PostgreSQL DB zonder SSL-enforcement

Deze testcase controleert of een tool een misconfiguratie kan detecteren waarbij SSL-enforcement is uitgeschakeld in een Azure PostgreSQL-server.
