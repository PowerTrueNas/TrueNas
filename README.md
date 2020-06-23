# TrueNas

With This Powershell module we can interact with Freenas and TrueNas System. This module use the `TrueNas` **API** to configure all the servers. Depend on the version of your `Powershell Module` you don't use the same **API**.

This version isn't available yet on the `PowerShell Gallery.

I decide to make a transition a used only the **API v2.0**

There is no `OVA` file available for TrueNas and FreeNas. So I create them :

|  |Link  |Size  |MD5  |
|---------|---------|---------|---------|
|FreeNas_Large.ova     |[Link](https://www.dropbox.com/s/gcd06u23fxnx94x/FreeNas_Large.ova?dl=0)         |**833 MB** |659F4C3217F3B15C99011B508F67ED15|
|FreeNas_Small.ova     |[Link](https://www.dropbox.com/s/iqwzjvf3fq1cqfm/FreeNas_Small.ova?dl=0)         |**932 MB**|D16D8D8D8559B9C223859311FF3F38EE|
|TrueNas     |  Not Available Yet  | Not Available Yet |  Not Available Yet  |

All the Appliance are configured in DHCP.

**FreeNas_Small Appliance** :
* **RAM** : 4Go
* **vCPU** : 2
* **1 DD**: 30 Go for OS
* **2 DD**: 50 Go for Storage iSCSI

**FreeNas_Large Appliance** :
* **RAM** : 16Go
* **vCPU** : 5
* **1 DD**: 30 Go for OS
* **4 DD**: 50 Go for Storage iSCSI

The virtual Hardware is set to run on **ESXI 6.7 min**.

##  1.Getting Started

You must fork my project or download the source a try to import Module.

```powershell
Import-module TrueNas.psm1
```

## More Information

* [github.com/JM2K69/FreeNas](https://github.com/JM2K69/FreeNas)

* [JM2K69.github.io](https://JM2K69.github.io)

## Ready and to do list

API v2 Link : [API v2.0](https://api.ixsystems.com/freenas/?__hstc=54333623.241142f386e1258ca53f3c147ee68408.1592915010750.1592915010750.1592915010750.1&__hssc=54333623.1.1592915010750&__hsfp=3538617992)
And `click` on **RESTFull 2.0**

- [X] Global Configuation **(Partial)**
    - [x] NTP
    - [x] Email
- [x] Storage
    - [x] Create
    - [x] Deletion
    - [x] Update **(Partial)**
- [x] Services
    - [X] Status
    - [X] Start / Stop / Restart
- [x] Share (Partial)
    - [x] ISCSI
         - [x] Create
         - [x] Configuration
         - [ ] Delete
         - [x] Update **(Partial)**
- [x] Volumes
    - [X] Pool
    - [X] Dataset
    - [X] ZVol
        - [X] Create / Modify
- [x] Certificates
    - [X] List certificates
    - [X] List CA
- [x] System
    - [X] Configuration
    - [X] Update
    - [X] Settings

## Breaking Change

All the command are renamed due to the `ixsystems` change the products name to **FreeNas** to **TrueNas**


## Tested On

* Windows 10 - Windows PowerShell 5.1
* Windows 10 - PowerShell Core 6.2.3
* Windows 10 - Powershell Core 7.x


## Usage

Here the release with the previous powershell module.

https://youtu.be/JpkEP9nkiN4

## Contribute

- We need to fork the repository
- Submit a Pull and request

Thank you for your contribution.
