# Check if script is running with admin rights
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { throw "Run as administrator" }

# Define the hosts file location
$hostsFile = "$env:SystemRoot\System32\drivers\etc\hosts"

# Read the current hosts file content
$hostsContent = Get-Content $hostsFile

# Count original number of entries
$initialCount = $hostsContent.Count

# Define unwanted hosts.  Add entries as desired.
$unwantedHosts = @(
	"example1.com",
	"example2.net",
	"example3.org"
)

# Generate new entries with 127.0.0.1 and tab-separated hostname
$newEntries = $unwantedHosts | ForEach-Object {
    "127.0.0.1`t$_"
}

# Convert existing entries to a proper tab-separated list, leaving comments untouched
$existingEntries = $hostsContent | ForEach-Object {
    if ($_ -match "^#") {
        $_
    } else {
        $splitEntry = ($_ -split "`t| ").Where({ $_ -ne "" })
        $splitEntry -join "`t"
    }
}

# Add new entries if not already present
$newEntries | ForEach-Object {
    if ($existingEntries -notcontains $_) {
        Add-Content $hostsFile $_
    }
}

# Read the updated hosts file content
$updatedHostsContent = Get-Content $hostsFile

# Remove duplicate entries and convert them, leaving comments untouched
$uniqueEntries = $updatedHostsContent | Get-Unique -AsString | ForEach-Object {
    if ($_ -match "^#") {
        $_
    } else {
        $splitEntry = ($_ -split "`t| ").Where({ $_ -ne "" })
        $splitEntry -join "`t"
    }
}

# Backup the original hosts file
Copy-Item $hostsFile "$hostsFile.bak"

# Overwrite the hosts file with unique, tab-separated entries
Set-Content $hostsFile $uniqueEntries

# Count the final number of entries
$finalCount = (Get-Content $hostsFile).Count

# Show the number of entries before and after the script execution
Write-Host "Initial number of entries: $initialCount"
Write-Host "Final number of entries: $finalCount"
