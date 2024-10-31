# input computer new name
$newComputerName = Read-Host "Enter new PC name"

# input new workgroup name
$newWorkgroup = Read-Host "Enter new workgroup"

# input new static ip
$newIPAddress = Read-Host "Enter new ip (eg. 192.168.1.100):"
# input prefix
$subnetMask = Read-Host "Enter subnet mask prefix (eg 8, 16, 24)"

# Prompt for new folder name
$newFolderName = Read-Host "Enter new folder name:"

# rename computer
Rename-Computer -NewName $newComputerName

# assign new workgrup
Add-computer -WorkGroupName $newWorkgroup

# set static ip
$currentIP = (Get-NetIPConfiguration -InterfaceIndex 6).IPv4Address.IPAddress
Remove-NetIPAddress -InterfaceIndex 6 -Confirm:$false
Remove-NetIPAddress -InterfaceIndex 6 -Confirm:$false
New-NetIPAddress -InterfaceIndex 6 -IPAddress $newIPAddress -AddressFamily IPv4 -PrefixLength $subnetMask


# create folder
$folderpath = -join("~/Desktop/", $newFolderName)

New-Item -Path "~/Desktop" -Name $newFolderName -ItemType Directory
New-Item -Path $folderpath -type file -Name rcheulishvili.txt -value "gamarjoba"

$sharepath = $folderpath
$Acl = Get-ACL $SharePath
$AccessRule= New-Object System.Security.AccessControl.FileSystemAccessRule("everyone","FullControl","ContainerInherit,Objectinherit","none","Allow")
$Acl.AddAccessRule($AccessRule)
Set-Acl $SharePath $Acl

# share folder?? doesn't work

New-SmbShare -Path $folderpath -Name "Shared Folder" -FullAccess "Everyone"


Restart-Computer
