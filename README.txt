CelerantAudit
Requirements: ImportExcel

***************************************************************************************************************************************************************************
* To use this tool you need to install the ImportExcel and SqlServer modules. All you need to do is run the below commands in Powershell.                                 *
* It does not require Administrator credentials.                                                                                                                          *
*                                                                                                                                                                         *
* Install-Module -Name ImportExcel -Scope CurrentUser -Force                                                                                                              *     
* Install-Module -Name SqlServer -Scope CurrentUser - Force                                                                                                               *
***************************************************************************************************************************************************************************

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