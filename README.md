# Attach-San-Volume-to-server-profile-template
  The script attachs a SAN volume to an existing server profile template and update the serverv rpofile accordingly.



## How to get Support
Simple scripts or tools posted on github are provided AS-IS and support is based on best effort provided by the author. If you encounter problems with the script, please submit an issue.

## Prerequisites
The script requires:
   * the latest OneView PowerShell library on PowerShell gallery


## To install OneView PowerShell library

```
    install-module HPEOneView.5xx  -scope currentuser
   

```

## To get list of servers with ilo Firmware
```
    # For POSH version greater than 5.3
    .\OV-attach-SANvolume-to-SPT.ps1 -hostname <OV-name> -username <OV-admin> -password <OV-password> -sanVolumeName myVol

    # For POSH v 5.2
    .\HPOV-attach-SANvolume-to-SPT.ps1 -hostname <OV-name> -username <OV-admin> -password <OV-password> -sanVolumeName myVol

```
