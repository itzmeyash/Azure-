# Project Name: Cost Optimization in Azure - VM Shutdown

## Introduction:
This project focuses on cost optimization in Azure by implementing a VM shutdown strategy based on time zones. By scheduling Azure Virtual Machines (VMs) to shut down during specific time periods, businesses can effectively reduce their Azure spending without compromising operational efficiency. This README file provides an overview of the project and guides users on how to use and customize the solution.

## Prerequisites:
Before running the script, ensure that you have the following prerequisites in place:

1. Azure Subscription: You must have an active Azure subscription to perform the necessary actions.
2. PowerShell: Make sure you have PowerShell installed on your machine.
3. Azure PowerShell Module: Install the Azure PowerShell module by running the following command in PowerShell:
   ```
   Install-Module -Name Az -AllowClobber -Scope CurrentUser
   ```

## Configuration:
1. Open the script file (e.g., `vm_shutdown.ps1`) in a text editor.

2. Modify the script's parameters to match your environment:

   - `$APP_ID`: Replace with your Azure Active Directory application ID (Service Principal).
   - `$CLIENT_SECRET`: Replace with the client secret of your Azure Active Directory application.
   - `$TENANT_ID`: Replace with the ID of your Azure Active Directory tenant.
   - `$subscription_id`: Replace with the ID of your Azure subscription.

3. Update the VM list:
   - Open the script and locate the line `Import-CSV -Path "filepath"`.
   - Replace `"filepath"` with the path to your CSV file containing the VM names and resource group names. Ensure that the CSV file has columns named "VM_Name" and "Resource_Group".

## Usage:
1. Open PowerShell and navigate to the directory containing the script file (`vm_shutdown.ps1`).

2. Run the script by executing the following command:
   ```
   .\vm_shutdown.ps1
   ```

3. The script will log in to your Azure account using the provided credentials.

4. It will then check the current time and determine whether to start or deallocate each VM based on the specified time zone conditions.

5. The script will display the status of each VM (whether it was started or stopped).

## Customization:
1. Adjust Time Zone Conditions:
   - The script currently includes sample time zone conditions. Modify these conditions as needed to align with your desired VM shutdown schedule. Update the lines:
     ```
     if ("$currentTimeMins" -ge 12 -and "$currentTimeMins" -lt 23) {
         # Start the VM
     }
     if ("$currentTimeMins" -ge 11 -and "$currentTimeMins" -lt 12) {
         # Stop the VM
     }
     ```
   - Change the hours in the conditions (`12`, `23`, `11`, `12`) to match your preferred start and stop times.

2. Advanced Configuration:
   - Feel free to customize the script further to suit your specific requirements. You can add additional logic, error handling, or integrate with other Azure services as needed.

## Conclusion:
By using this script to implement VM shutdown based on time zones, you can optimize your Azure costs effectively. Remember to review and validate the script according to your specific needs and best practices recommended by Azure. With the right configuration and monitoring, you can achieve significant cost savings while maintaining an efficient Azure environment.
