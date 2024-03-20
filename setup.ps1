$ProgressPreference = 'Continue'
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 2.0

New-Variable -Name curdir  -Option Constant -Value $PSScriptRoot
Write-Host "[INFO] script directory: $curdir"

New-Variable -Name curdir_with_slashes -Option Constant -Value ($curdir -Replace '\\','/')

[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor 'Tls12'
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

$certs_dir = Join-Path -Path $curdir -ChildPath 'certs Евгений'
$data_dir = Join-Path -Path $curdir -ChildPath 'data Евгений'

$ssl_dist_optfile_rmq0_conf_in = Join-Path -Path $data_dir -ChildPath 'ssl_dist_optfile.rmq0.conf.in'
$ssl_dist_optfile_rmq0_conf_out = Join-Path -Path $curdir -ChildPath 'ssl_dist_optfile.rmq0.conf'

$ssl_dist_optfile_rmq1_conf_in = Join-Path -Path $data_dir -ChildPath 'ssl_dist_optfile.rmq1.conf.in'
$ssl_dist_optfile_rmq1_conf_out = Join-Path -Path $curdir -ChildPath 'ssl_dist_optfile.rmq1.conf'

(Get-Content -Raw -LiteralPath $ssl_dist_optfile_rmq0_conf_in) -Replace '@@CURDIR@@', $curdir_with_slashes `
    | Set-Content -LiteralPath $ssl_dist_optfile_rmq0_conf_out
(Get-Content -Raw -LiteralPath $ssl_dist_optfile_rmq1_conf_in) -Replace '@@CURDIR@@', $curdir_with_slashes `
    | Set-Content -LiteralPath $ssl_dist_optfile_rmq1_conf_out
