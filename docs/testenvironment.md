# Test environment
## OVA File

For your convinience, `OVA` files have been built and made available, see details below.

These `OVA` files are provided "AS IS", without warranty of any kind. Please use ONLY in TEST environments.

These can be used to quickly spin up a TrueNas instance and play with the PowerShell module.

>Appliance are create with the Release Candidate 1 TrueNasCore-RC1 iso file.

||Link|Size|SHA256|Specs|
|---|---|---|---|---|
|TrueNasCore_Medium.ova     |[Link](https://www.dropbox.com/s/vk0xaen3jpmtwpz/TrueNasCore_Medium.ova?dl=0)         |**1 GB** |33E873FB56D74315ADC33ACA1F23BE2E28EF0D4C64F81FAEEE27845C6EA597CC|8GB Memory / 4vCpu <br>Disks: #1 OS 30GB #4 iSCSI 50GB|
|TrueNasCore_Small.ova     |[Link](https://www.dropbox.com/s/21qsdyazlduilzu/TrueNasCore_small.ova?dl=0)         |**1 GB**|10D06FE19C059573630473A0406F444DB7E80903D42CB560C6699FA80A1C8512|4GB Memory / 2vCpu <br>Disks: #1 OS 30GB #1 iSCSI 50GB|

**Notes**
* All appliances are configured in DHCP.
* The default password for the root is root. it must be change for security.
* The virtual Hardware is set to run on **ESXI 6.7 min**.