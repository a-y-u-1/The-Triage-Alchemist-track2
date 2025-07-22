$vm_name = $env:COMPUTERNAME
$datetime = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

# Get top 5 processes by CPU usage
$topProcs = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5

foreach ($p in $topProcs) {
  $obj = @{
    vm_name = $vm_name
    datetime = $datetime
    pid = $p.Id
    proc_name = $p.ProcessName
    cpu_seconds = [math]::Round($p.CPU, 2)
    memory_mb = [math]::Round($p.WorkingSet / 1MB, 2)
    user = (try { (Get-WmiObject Win32_Process -Filter "ProcessId=$($p.Id)").GetOwner().User } catch { "N/A" })
  }

  $obj | ConvertTo-Json -Compress
}
