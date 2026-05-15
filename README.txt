CelerantAudit
Created by: David Barnes
Requirements: ImportExcel, SqlServer

*******************************************************************************
* To use this tool you need to install the ImportExcel and SqlServer modules. * 
* All you need to do is run the below commands in Powershell.                 *
* It does not require Administrator credentials.                              *
*                                                                             *
* Install-Module -Name ImportExcel -Scope CurrentUser -Force                  *     
* Install-Module -Name SqlServer -Scope CurrentUser -Force                    *
*******************************************************************************

This is a reporting tool meant to collect information about several topics.

Product Tax Status:
This report contains typical product information as well as the tax status of the item (Taxable, Non-taxable). Use this information to identify any items with incorrect tax statuses.

Inactivity Checker:
This report contains all products matching a selection of criteria to indicate they can be marked as Inactive. The following criteria is used:

1. Product is Active
2. Quantity On Hand is 0 (summed from all stores)
3. Quantity On Order is 0 (when a product is on a PO, I think it affects the On Order quantity. On a run before I added this, I found some Ariat boots from FALL26 that were in a PO and I don't see them anymore)
4. Last Sold date is at least 1 year ago
5. Last Received date is at least 1 year ago

HOW TO RUN:
Right-click CelerantAudit.ps1 and select "Run with PowerShell"

Alternatively, Shift + Right-click anywhere in the folder (don't Shift + Right-click the file itself) and select "Open PowerShell window here" to open a PowerShell window first. This will make it so the command prompt window won't close as soon as this tool finishes which will let you inspect the output if you wish. To run the script with this method, type (or copy and paste) the following:

./CelerantAudit.ps1

HOW TO INSTALL MODULES:
Open PowerShell by searching for it with the Start menu or shift + right-click the whitespace of any folder's window and click "Open PowerShell window here"
Copy and paste the Install-Module commands into PowerShell. If the modules are already installed, they will be ignored.