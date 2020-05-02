# TrueNas

With This Powershell module we can interact with Freenas and TrueNas System. This module use the `FreeNas` **API** to configure all the servers. Depend on the version of your `Powershell Module` you don't use the same **API**.


|API      |PowerShell Module | GitHub|
|---------|---------|---------|
|**v2.0**     | **Next Release**        | Branch ***dev***|
|v1.0     |  2.0.2 and prior version       |Branch **master**|

In the next Release the API v1.0 will be drop, only the API v2 will be `available`. When FreeNas release the 11.3 version the API v2.0 will be available and it will be full functionality.

## Getting Started

Install from the PSGallery

    Install-Module Freenas -Scope CurrentUser
    Import-Module Freenas


## More Information

* [github.com/JM2K69/FreeNas](https://github.com/JM2K69/FreeNas)

* [JM2K69.github.io](https://JM2K69.github.io)

## Ready and to do list

API v1 Link : [api.freenas.org](http://api.freenas.org)

- [X] Global Configuation (Partial)
    - [x] NTP
    - [x] Email
- [x] Storage
    - [x] Create
    - [x] Deletion
    - [x] Update (Partial)
- [x] Services
    - [X] Status
- [x] Share (Partial)
    - [x] ISCSI
         - [x] Create
         - [x] Configuration
         - [ ] Deletetion
         - [x] Update (Partial)

## Breaking Change

Several Powershell functions have been renamed to better reflect the **FreeNas** server configuration screens.


## Tested On

* Windows 10 - Windows PowerShell 5.1
* Windows 10 - PowerShell Core 6.2.3
* Windows 10 - Powershell Core 7 RC


## Usage

Here the first release.

https://youtu.be/JpkEP9nkiN4

## Contribute

- We need to fork the repository
- Submit a Pull and request

Thank you for your contribution.
