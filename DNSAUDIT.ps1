#Run 'Powershell -Command "c:\temp\DNSaudit.ps1" > c:\temp\dnsout.txt 2>&1'
CLS
$servers = Get-Content "c:\temp\servers.txt" 

foreach($server in $servers){
$Adapters = Get-WmiObject -ComputerName $server Win32_NetworkAdapterConfiguration

	Foreach ($Adapter in ($Adapters | Where {$_.IPEnabled -eq $True})) {
	$Details = "" | Select Description, "Physical address", "IP Address / Subnet Mask", "Default Gateway", "DHCP Enabled", DNS, WINS
		If ($Adapter.DNSServerSearchOrder -ne $Null)	{
			$Details.DNS =  "$($Adapter.DNSServerSearchOrder)"
			Write-Host $server      -ForegroundColor DarkBlue $Details.DNS
					}
					
	}
}