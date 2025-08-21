# IR_Collection.ps1

param(
    [string]$OutputDir = "$env:USERPROFILE\IR_Collection"
)

# 1. 수집 디렉터리 생성
New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null

# 2. 시스템 정보 수집
Get-Date | Out-File "$OutputDir\date.txt"
Get-Uptime | Out-File "$OutputDir\uptime.txt"
systeminfo | Out-File "$OutputDir\systeminfo.txt"

# 3. Autoruns (via KAPE 모듈 예시)
# kape.exe -m Autoruns -o $OutputDir

# 4. 네트워크 정보
ipconfig /all | Out-File "$OutputDir\net_ipconfig.txt"
netstat -an | Out-File "$OutputDir\net_stat.txt"

# 5. 프로세스 및 파일 핸들
Get-Process | Out-File "$OutputDir\process_list.txt"
# fport / tcpview 활용 시 외부 툴 필요

# 6. 이벤트 로그 수집 (Security, Application, System)
wevtutil qe Security /c:1000 /f:text > "$OutputDir\events_security.txt"
wevtutil qe Application /c:1000 /f:text > "$OutputDir\events_app.txt"

# 7. 레지스트리 아티팩트 (Kansa 모듈 예시)
# kansa.ps1 -ModulePath .\Modules -Target $env:COMPUTERNAME -OutputPath $OutputDir

Write-Output "Incident response artifacts collected at: $OutputDir"
