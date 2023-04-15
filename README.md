# Block Unwanted Hosts
Powershell script to block unwanted hosts.  The script must be run by a user with administrative rights on the computer.

# Usage
Follow the steps below to use the PowerShell script.

1.  Download `block_unwated_hosts.ps1` script, or clone the repository.
2.  Open in the script in a text editor.
3.  Add entries to be blocked in the `$unwantedHosts` variable.
4.  Open elavated PowerShell.
5.  Navigate to the location of the script.
6.  Run the script using `.\block_unwated_hosts.ps1`.
7.  Done.

# Features
1.  Add the list of hosts to be blocked in an array.
2.  Reformats the rest of the `hosts` file so that it consistently uses tab across all entries.
