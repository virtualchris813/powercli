$csv = Import-Csv c:\nets.csv -Header @("name","vlan")
foreach ($rec in $csv) {
   Get-VDSwitch -Name "SWITCH-NAME" | New-VDPortgroup -Name $rec.name -VLanId $rec.vlan
}
