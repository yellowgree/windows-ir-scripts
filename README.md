# Windows Incident Response Toolkit   

Windows 환경에서 **포렌식 수집 & 초기 사고 대응**을 자동화하기 위한 PowerShell 기반 스크립트 모음입니다.  

전통적인 Windows 유틸리티(`ipconfig`, `netstat`, `tasklist` 등)와 최신 Sysinternals 도구(`Autoruns`, `Process Explorer`, `TCPView` 등)를 활용하여  
**시스템 상태, 네트워크 연결, 사용자 활동, 악성 흔적**을 빠르게 수집할 수 있도록 설계되었습니다.  

---

## 주요 기능  

| 범주 | 수집 항목 | 사용 도구/명령어 |
|------|-----------|----------------|
| 시스템 정보 | OS 버전, 설치 SW, 서비스 상태 | `systeminfo`, `net start`, `Get-WmiObject` |
| 프로세스/핸들 | 실행 중인 프로세스, DLL, 파일 핸들 | Sysinternals `pslist`, `listdlls`, `handle`, `procexp` |
| 네트워크 | 열려있는 포트, 세션, TCP/UDP 연결 | `netstat -an`, Sysinternals `tcpview`, `fport`, `ipconfig` |
| 사용자 & 로그인 | 계정, 그룹, 세션 정보, 원격 접속 로그 | `net user`, `net localgroup`, `ntlast` |
| 자동 실행 & 레지스트리 | 시작 프로그램, 예약 작업, DLL 인젝션 | Sysinternals `autoruns`, `autostart viewer` |
| 루트킷 탐지 | 숨겨진 프로세스/서비스/레지스트리 | Sysinternals `RootkitRevealer`, `IceSword` |
| 파일/레지스트리 모니터링 | FS/Registry 변경 추적 | Sysinternals `filemon`, `regmon` |
| 네트워크 트래픽 | 패킷 캡처 및 분석 | Wireshark |
| DB 관련 | SQL Injection 탐지/테스트 | `sqlpoke.exe`, `HDSI`, `D-SQL` |

---

## 스크립트 로직  

1. **시스템 기본 정보 수집**  
   - 날짜/시간, 업타임, 설치 SW, 실행 중인 서비스  

2. **프로세스 및 파일 핸들 확인**  
   - 실행 중인 프로세스 + DLL + 열린 파일 핸들 기록  

3. **네트워크 상태 기록**  
   - 열린 포트, 세션 연결 상태, Promiscuous Mode 여부  

4. **사용자/계정 관련 로그 수집**  
   - 로컬 계정, 그룹, 공유 세션, 원격 로그인 기록  

5. **자동 실행 항목 분석**  
   - Autoruns + 레지스트리 기반 AutoStart 프로그램 추출  

6. **의심 흔적 탐지**  
   - 루트킷, 웹쉘, 비정상 DB 테이블(t_Jiaozhu 등) 탐색  

7. **결과 저장**  
   - 모든 로그를 `C:\IR_Collection\YYYYMMDD` 폴더에 저장  

---

## 사용 방법  

```powershell
# 관리자 권한 PowerShell 실행 후
git clone https://github.com/yellowgree/windows-ir-scripts.git
cd windows-ir-toolkit

# 스크립트 실행
.\IR_Collection.ps1
