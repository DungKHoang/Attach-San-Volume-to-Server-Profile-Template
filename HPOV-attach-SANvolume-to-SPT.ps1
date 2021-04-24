# ------------------ Parameters
Param (                    
        [string]$hostName                  = "", 
        [string]$userName                  = "", 
        [string]$password                  = "",
        [string]$authLoginDomain           = "local",
        [string]$sanVolumeName                                                                                   
      )

if ($sanVolumeName)
{
    
    $serverProfileName          = Read-Host "Enter Server Profile Name: "
    $serverProfileTemplateName  = Read-Host "Enter Server Profile Template Name: "

    if ($serverProfileTemplateName)
    {
        connect-HPOVmgmt -hostname $hostName -username $userName -Password $password -AuthLoginDomain $authLoginDomain

        # get Storage volume
        $volume                 = Get-HPOVStorageVolume -name $sanVolumeName 
        if ($volume)
        {
            # get SPT object 
            $spt = Get-HPOVServerProfileTemplate -name $serverProfileTemplateName
            if ($spt)
            {
                New-HPOVServerProfileAttachVolume -VolumeID 1 -LunIDType auto -Volume $volume -ServerProfile $spt | Wait-HPOVTaskComplete
                if ($serverProfileName)
                {
                    # shutdown SP and Update from Template
                    $sp = get-HPOVserverprofile -name $serverProfileName
                    if ($sp)
                    {
                        stop-HPOVserver -inputobject $sp -force -confirm:$false
                        $sp | Update-HPOVServerProfile  -confirm:$false
                    }

                }

            }
            else 
            {
                write-host -foreground YELLOW "No spt with name $serverProfileTemplateName. Exiting the script"
            }
        }
        else 
        {
            write-host -foreground YELLOW "No san volume with name $sanVolumeName. Exiting the script"
        }

    }
    else 
    {
        write-host -foreground YELLOW "No server profile template specified. Exiting the script"
    }
}
else 
{
    write-host -foreground YELLOW "No SAN volume specified. Exiting the script" 
}