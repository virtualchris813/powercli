# Log into vCenter with powercli
Import-Module VMware.VimAutomation.Core
Connect-VIServer

# Get the list of VM's on the port group. Change the port group name in the 1st line
# This will create a file named vm_list.txt that will be used in the later steps.
$pg = Get-View -ViewType Network -Property Name, VM -Filter @{"Name=VLAN999"}
Get-View -Id $pg.Vm -Property Name | Select-Object -ExpandProperty Name| Out-File -FilePath .\vm_list.txt

# Process the list and spit out the results
$results = @()
foreach ($vm in Get-VM (Get-Content vm_list.txt)){
  foreach ($vmharddisk in $vm | get-harddisk) {
     $result = "" | select vmname, harddiskname, harddiskcapacitygb
     $result.vmname = $vm.name
     $result.harddiskname = $vmharddisk.name
     $result.harddiskcapacitygb = [system.math]::Round($vmharddisk.capacitygb, 0)
     $results += $result
  }
}
$results | ft -auto
