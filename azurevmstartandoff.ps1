[CmdletBinding()]

param
(
    [Parameter(Mandatory = $true)]
    [string]$APP_ID = "",
    [Parameter(Mandatory = $true)]
    [string]$CLIENT_SECRET = "",
    [Parameter(Mandatory = $true)]
    [string]$TENANT_ID = "",
    [Parameter(Mandatory = $true)]
    [string]$subscription_id = ""

)

# Current Australia Eastern Time
$ISTTime = [System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId( (Get-date), 'India Standard Time')
[String]$currentTime = $ISTTime
$currentTime
$currentTimeMins = ([datetime]$currentTime).Hour
Write-Output "Current time is $currentTimeMins"
$currentDay = $ISTTime.DayOfWeek.ToString().Substring(0, 2)
$currentDay

Try {
    # Get the connection "AzureRunAsConnection "

    $connectionName = az login --service-principal --username $APP_ID --password $CLIENT_SECRET --tenant $TENANT_ID
}

Catch {
    If (!$connectionName) {
        $ErrorMessage = "Connection $connectionName not found."
        throw $ErrorMessage
    }
    Else {
        Write-Error -Message $_.Exception
        throw $_.Exception
    }
}


# $vm= (az vm list --query "[].name" -o tsv)


# Loop through each VM in the subscription
# $vms = (az vm list --subscription $subscription_id --query "[].id" -o tsv)

$vms = Import-CSV -Path "filepath"


foreach ($vm in $vms) {

    $vmName = $vm.VM_Name

    Write-Output "Virtual Machine Name is $vmName"

    $rg=$vm.Resource_Group

    Write-Output "Resource Group Name is $rg"

    # Get the resource ID of the virtual machine
    $vm_id=(az vm show --name "$vmName" --resource-group "$rg" --query "id" --output tsv)

    # Print the resource ID
    Write-Output "Resource ID: $vm_id"

    # Check current time against conditionss

    # Example condition: Start the VM if the current hour is between 8 AM and 6 PM
    # $current_hour = (Get-Date).Hour
    if ( "$currentTimeMins" -ge 12 -and "$currentTimeMins" -lt 23) {
        az vm start --ids "$vm_id" --no-wait
        Write-Output "Restart of VM: $vmName is succesful "

    }
    if ( "$currentTimeMins" -ge 11 -and "$currentTimeMins" -lt 12) {

        az vm deallocate --ids "$vm_id" --no-wait
        Write-Output "Stopped VM: $vmName is succesful"
    }
}
