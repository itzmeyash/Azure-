[CmdletBinding()]

param
(

    [string]$APP_ID = "1aaf14e1-fd23-4523-8517-75cd77dd3bba",

    [string]$CLIENT_SECRET = "DuI8Q~_IN1rfznJpNS2rE0voqFBn0Gr5LYOxea6Z",

    [string]$TENANT_ID = "b41b72d0-4e9f-4c26-8a69-f949f367c91d",

    [string]$subscription_id = "c96c59e0-a3f1-4d5e-bd1b-7d9ca8c9ebdb"

)
az login --service-principal --username $APP_ID --password $CLIENT_SECRET --tenant $TENANT_ID


# $vm= (az vm list --query "[].name" -o tsv)



# Set your subscription ID
$subscription_id = "c96c59e0-a3f1-4d5e-bd1b-7d9ca8c9ebdb"

# Start VMs
# start_vm{
#     local vm_id=$1
#     az vm start --ids "$vm_id" --no-wait
#     echo "Started VM: $vm_id"
# }

# # Stop VMs
# stop_vm {
#     local vm_id=$1
#     az vm deallocate --ids "$vm_id" --no-wait
#     Write-Output "Stopped VM: $vm_id"
# }

# Loop through each VM in the subscription
$vms = (az vm list --subscription $subscription_id --query "[].id" -o tsv)

foreach ($vms in $vms) {
    Write-Output "VM: $vms"
    # Check current time against conditions
    # Modify the conditions as per your specific requirements

    # Example condition: Start the VM if the current hour is between 8 AM and 6 PM
    $current_hour = (Get-Date).Hour
    if ( "$current_hour" -ge 23 -and "$current_hour" -lt 24) {
        az vm start --ids "$vms" --no-wait
        Write-Output "Stopped VM: $vms"

    }
    if ( "$current_hour" -ge 23 -and "$current_hour" -lt 24) {

        az vm deallocate --ids "$vms" --no-wait
        Write-Output "Stopped VM: $vms"
    }
}



