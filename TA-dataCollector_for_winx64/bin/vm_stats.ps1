$vm_name = $env:COMPUTERNAME
$datetime = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
$os_version = (Get-WmiObject Win32_OperatingSystem).Caption
$ip_address = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -notlike "*Loopback*" -and $_.IPAddress -notlike "169.*"} | Select-Object -First 1).IPAddress

$cpu_cores = (Get-WmiObject Win32_ComputerSystem).NumberOfLogicalProcessors
$cpu_load = (Get-WmiObject Win32_Processor).LoadPercentage
$mem_total = [math]::Round((Get-WmiObject Win32_ComputerSystem).TotalPhysicalMemory / 1MB, 0)
$mem_free = [math]::Round((Get-WmiObject Win32_OperatingSystem).FreePhysicalMemory / 1024, 0)
$mem_used = $mem_total - $mem_free
$disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"
$disk_total = [math]::Round($disk.Size / 1GB, 2)
$disk_free = [math]::Round($disk.FreeSpace / 1GB, 2)
$disk_used = [math]::Round($disk_total - $disk_free, 2)
$uptime = (Get-Date) - (gcim Win32_OperatingSystem).LastBootUpTime
$uptime_seconds = [math]::Round($uptime.TotalSeconds, 0)

$json = @{
    vm_name = $vm_name
    datetime = $datetime
    os_version = $os_version
    ip_address = $ip_address
    cpu_cores = $cpu_cores
    cpu_load_percent = $cpu_load
    memory_total_mb = $mem_total
    memory_used_mb = $mem_used
    disk_total_gb = $disk_total
    disk_used_gb = $disk_used
    uptime_seconds = $uptime_seconds
} | ConvertTo-Json -Compress

Write-Output $json
