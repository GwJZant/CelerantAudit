# Load the configuration file
$configFile = "$PSScriptRoot\config.json"

# Load SQL file
$sqlFilePath = ""

# Output filename formatting
# Check if the folder exists; if not, create it
if (-not (Test-Path -Path "$PSScriptRoot\Output")) {
    # -Force ensures it creates the entire tree if multiple levels are missing
    New-Item -ItemType Directory -Path "$PSScriptRoot\Output" -Force | Out-Null
}

$timestamp = Get-Date -Format "yyyy-MM-dd_HHmm"
$outputFolderPath = "$PSScriptRoot\Output\"
$excelFileName = ""

# Load the config file and ensure it exists
if (Test-Path $configFile) {
    # Read the file and convert JSON into a PowerShell Object
    $config = Get-Content -Path $configFile -Raw | ConvertFrom-Json
} else {
    Write-Host "ERROR: config.json not found!" -ForegroundColor Red
    exit
}

# Menu
Write-Host "What would you like to audit?" -ForegroundColor Cyan
Write-Host "1. Product Tax Status" -ForegroundColor Cyan
Write-Host "2. Inactivity Checker" -ForegroundColor Cyan
Write-Host "3. Exit" -ForegroundColor Cyan
$selection = Read-Host "Enter your selection"

if ($selection -eq "1") {
	Write-Host "A report will be generated displaying tax statuses for all products in $outputFolderPath"
	
	$sqlFilePath = "$PSScriptRoot\Queries\CelerantTaxStatusAudit.sql"
	$excelPath = $outputFolderPath + "TaxStatusAudit_$timestamp.xlsx"
} elseif ($selection -eq "2") {
	Write-Host "A report will be generated displaying all active products with no inventory that has no sales history in the past 12 months."
	
	$sqlFilePath = "$PSScriptRoot\Queries\CelerantInactivityCheckerAudit.sql"
	$excelPath = $outputFolderPath + "CelerantInactivityCheckerAudit_$timestamp.xlsx"
} else {
	exit
}

# Connect to Celerant Database
Write-Host "Connecting to Celerant Database..." -ForegroundColor Cyan

# Ask for Username and Password in the console
$passSecure = Read-Host "Enter $($config.Celerant.Username) SQL Password" -AsSecureString

# Convert to plain text for the SQL Driver
$passPlain = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($passSecure)
)

# Set up SQL parameters
$sqlParams = @{
    ServerInstance         = $config.Celerant.ServerInstance
    Database               = $config.Celerant.Database
	InputFile              = $sqlFilePath
	Username               = $config.Celerant.Username
	Password               = $passPlain
	Encrypt                = "Mandatory"
	TrustServerCertificate = $true
}

try {
    $productData = Invoke-Sqlcmd @sqlParams
	
	$excelPackage = $productData | Select-Object * -ExcludeProperty RowError, RowState, Table, ItemArray, HasErrors | Export-Excel -Path $excelPath -WorksheetName "Sheet1" -AutoSize -BoldTopRow -PassThru
		
	# Format Column B (Product) as Text so text alignment matches
	Set-ExcelRange -Worksheet $excelPackage.Workbook.Worksheets["Sheet1"] -Range "B:B" -NumberFormat "@"
	
	$excelPackage | Close-ExcelPackage
} catch {
    Write-Host "Error: $_" -ForegroundColor DarkRed
}
