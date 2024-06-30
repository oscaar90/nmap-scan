# Nmap Scan Script

Este es un script de bash para realizar escaneos de puertos y vulnerabilidades utilizando Nmap.

## Uso

Para ejecutar el script, usa el siguiente comando:

```bash
./escaneo.sh <dirección IP>
```


## Descripción
El script realiza las siguientes tareas:

1. Escanea todos los puertos de la dirección IP proporcionada.
```bash
ports=$(nmap -p- -sS -n -Pn --min-rate=$RATE $TARGET | grep '^[0-9]' | cut -d '/' -f 1 | tr '\n' ',' | sed 's/,$//')
```
- Utiliza un escaneo SYN (-sS) para detectar puertos abiertos.
- No resuelve nombres DNS (-n) y asume que el host está activo (-Pn).
- Los puertos abiertos se recogen y formatean en una lista separada por comas.

2. Realiza un escaneo detallado en los puertos abiertos.
```bash
nmap -p$ports -sCV -oN detailed_scan_$TARGET.txt $TARGET
```
- Escanea los puertos abiertos detectados.
- Utiliza scripts de detección (-sC) y detección de versiones (-sV).
- Los resultados se guardan en un archivo de texto llamado detailed_scan_$TARGET.txt.

3. Realiza un escaneo de vulnerabilidades en los puertos abiertos.
```bash
nmap -p$ports --script vuln -oN vuln_scan_$TARGET.txt $TARGET
```
- Ejecuta scripts de vulnerabilidades predeterminados en los puertos abiertos.
- Los resultados se guardan en un archivo de texto llamado vuln_scan_$TARGET.txt.

## Requisitos
1. Nmap
2. Bash

Ejemplo de Escaneo a Metasploit 

```bash
sudo ./escaneo.sh 192.168.1.48
Escaneando todos los puertos en 192.168.1.48...
Escaneando puertos específicos: 21,22,80,445,631,3000,3306,3500,6697,8080,8181 en 192.168.1.48...
Starting Nmap 7.94SVN ( https://nmap.org ) at 2024-06-30 17:01 CEST
Nmap scan report for 192.168.1.48
Host is up (0.0013s latency).

PORT     STATE  SERVICE     VERSION
21/tcp   open   ftp         ProFTPD 1.3.5
22/tcp   open   ssh         OpenSSH 6.6.1p1 Ubuntu 2ubuntu2.13 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   1024 2b:2e:1f:a4:54:26:87:76:12:26:59:58:0d:da:3b:04 (DSA)
|   2048 c9:ac:70:ef:f8:de:8b:a3:a3:44:ab:3d:32:0a:5c:6a (RSA)
|   256 c0:49:cc:18:7b:27:a4:07:0d:2a:0d:bb:42:4c:36:17 (ECDSA)
|_  256 a0:76:f3:76:f8:f0:70:4d:09:ca:e1:10:fd:a9:cc:0a (ED25519)
80/tcp   open   http        Apache httpd 2.4.7 ((Ubuntu))
|_http-title: Index of /
| http-ls: Volume /
| SIZE  TIME              FILENAME
| -     2020-10-29 19:37  chat/
| -     2011-07-27 20:17  drupal/
| 1.7K  2020-10-29 19:37  payroll_app.php
| -     2013-04-08 12:06  phpmyadmin/
|_
|_http-server-header: Apache/2.4.7 (Ubuntu)
445/tcp  open   netbios-ssn Samba smbd 4.3.11-Ubuntu (workgroup: WORKGROUP)
631/tcp  open   ipp         CUPS 1.7
| http-methods: 
|_  Potentially risky methods: PUT
|_http-server-header: CUPS/1.7 IPP/2.1
| http-robots.txt: 1 disallowed entry 
|_/
|_http-title: Home - CUPS 1.7.2
3000/tcp closed ppp
3306/tcp open   mysql       MySQL (unauthorized)
3500/tcp open   http        WEBrick httpd 1.3.1 (Ruby 2.3.8 (2018-10-18))
|_http-title: Ruby on Rails: Welcome aboard
| http-robots.txt: 1 disallowed entry 
|_/
|_http-server-header: WEBrick/1.3.1 (Ruby/2.3.8/2018-10-18)
6697/tcp open   irc         UnrealIRCd
| irc-info: 
|   users: 1
|   servers: 1
|   lusers: 1
|   lservers: 0
|_  server: irc.TestIRC.net
8080/tcp closed http-proxy
8181/tcp closed intermapper
MAC Address: 08:00:27:A8:D3:2F (Oracle VirtualBox virtual NIC)
Service Info: Hosts: METASPLOITABLE3-UB1404, irc.TestIRC.net; OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

Host script results:
|_clock-skew: mean: 1m56s, deviation: 2s, median: 1m54s
| smb2-time: 
|   date: 2024-06-30T15:03:25
|_  start_date: N/A
| smb-security-mode: 
|   account_used: guest
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled but not required
| smb-os-discovery: 
|   OS: Windows 6.1 (Samba 4.3.11-Ubuntu)
|   Computer name: metasploitable3-ub1404
|   NetBIOS computer name: METASPLOITABLE3-UB1404\x00
|   Domain name: \x00
|   FQDN: metasploitable3-ub1404
|_  System time: 2024-06-30T15:03:24+00:00
Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 47.90 seconds
Escaneo detallado completo. Resultados guardados en detailed_scan_192.168.1.48.txt
```
Finaliza el primer escaneo **nmap -sCV** a los puertos abiertos detectados, y,automaticamente, empieza un nuevo **nmap --script vuln** a los mismos puertos


```bash
Escaneando vulnerabilidades en puertos específicos: 21,22,80,445,631,3000,3306,3500,6697,8080,8181 en 192.168.1.48...
Starting Nmap 7.94SVN ( https://nmap.org ) at 2024-06-30 17:02 CEST
Pre-scan script results:
| broadcast-avahi-dos: 
|   Discovered hosts:
|     224.0.0.251
|   After NULL UDP avahi packet DoS (CVE-2011-1002).
|_  Hosts are all up (not vulnerable).
Stats: 0:02:36 elapsed; 0 hosts completed (1 up), 1 undergoing Script Scan
NSE Timing: About 99.04% done; ETC: 17:04 (0:00:01 remaining)
Stats: 0:03:32 elapsed; 0 hosts completed (1 up), 1 undergoing Script Scan
NSE Timing: About 99.04% done; ETC: 17:05 (0:00:02 remaining)
Nmap scan report for 192.168.1.48
Host is up (0.0021s latency).

PORT     STATE  SERVICE
21/tcp   open   ftp
22/tcp   open   ssh
80/tcp   open   http
| http-slowloris-check: 
|   VULNERABLE:
|   Slowloris DOS attack
|     State: LIKELY VULNERABLE
|     IDs:  CVE:CVE-2007-6750
|       Slowloris tries to keep many connections to the target web server open and hold
|       them open as long as possible.  It accomplishes this by opening connections to
|       the target web server and sending a partial request. By doing so, it starves
|       the http server's resources causing Denial Of Service.
|       
|     Disclosure date: 2009-09-17
|     References:
|       https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-6750
|_      http://ha.ckers.org/slowloris/
| http-sql-injection: 
|   Possible sqli for queries:
|     http://192.168.1.48:80/?C=M%3BO%3DA%27%20OR%20sqlspider
|     http://192.168.1.48:80/?C=N%3BO%3DD%27%20OR%20sqlspider
|     http://192.168.1.48:80/?C=S%3BO%3DA%27%20OR%20sqlspider
|     http://192.168.1.48:80/?C=D%3BO%3DA%27%20OR%20sqlspider
|     http://192.168.1.48:80/?C=N%3BO%3DA%27%20OR%20sqlspider
|     http://192.168.1.48:80/?C=S%3BO%3DA%27%20OR%20sqlspider
|     http://192.168.1.48:80/?C=D%3BO%3DA%27%20OR%20sqlspider
|     http://192.168.1.48:80/?C=M%3BO%3DD%27%20OR%20sqlspider
|     http://192.168.1.48:80/?C=N%3BO%3DA%27%20OR%20sqlspider
|     http://192.168.1.48:80/?C=S%3BO%3DA%27%20OR%20sqlspider
|     http://192.168.1.48:80/?C=D%3BO%3DA%27%20OR%20sqlspider
|     http://192.168.1.48:80/?C=M%3BO%3DA%27%20OR%20sqlspider
|     http://192.168.1.48:80/?C=N%3BO%3DA%27%20OR%20sqlspider
|     http://192.168.1.48:80/?C=D%3BO%3DA%27%20OR%20sqlspider
|     http://192.168.1.48:80/?C=M%3BO%3DA%27%20OR%20sqlspider
|     http://192.168.1.48:80/?C=S%3BO%3DD%27%20OR%20sqlspider
|     http://192.168.1.48:80/?C=N%3BO%3DA%27%20OR%20sqlspider
|     http://192.168.1.48:80/?C=S%3BO%3DA%27%20OR%20sqlspider
|     http://192.168.1.48:80/?C=D%3BO%3DD%27%20OR%20sqlspider
|_    http://192.168.1.48:80/?C=M%3BO%3DA%27%20OR%20sqlspider
|_http-dombased-xss: Couldn't find any DOM based XSS.
|_http-stored-xss: Couldn't find any stored XSS vulnerabilities.
| http-enum: 
|   /: Root directory w/ listing on 'apache/2.4.7 (ubuntu)'
|   /phpmyadmin/: phpMyAdmin
|_  /uploads/: Potentially interesting directory w/ listing on 'apache/2.4.7 (ubuntu)'
| http-csrf: 
| Spidering limited to: maxdepth=3; maxpagecount=20; withinhost=192.168.1.48
|   Found the following possible CSRF vulnerabilities: 
|     
|     Path: http://192.168.1.48:80/payroll_app.php
|     Form id: 
|     Form action: 
|     
|     Path: http://192.168.1.48:80/drupal/
|     Form id: user-login-form
|     Form action: /drupal/?q=node&destination=node
|     
|     Path: http://192.168.1.48:80/chat/
|     Form id: name
|_    Form action: index.php
445/tcp  open   microsoft-ds
631/tcp  open   ipp
| http-enum: 
|   /admin.php: Possible admin folder
|   /admin/: Possible admin folder
|   /admin/admin/: Possible admin folder
|   /administrator/: Possible admin folder
|   /adminarea/: Possible admin folder
|   /adminLogin/: Possible admin folder
|   /admin_area/: Possible admin folder
|   /administratorlogin/: Possible admin folder
|   /admin/account.php: Possible admin folder
|   /admin/index.php: Possible admin folder
|   /admin/login.php: Possible admin folder
|   /admin/admin.php: Possible admin folder
|   /admin_area/admin.php: Possible admin folder
|   /admin_area/login.php: Possible admin folder
|   /admin/index.html: Possible admin folder
|   /admin/login.html: Possible admin folder
| ............................. etc
3000/tcp closed ppp
3306/tcp open   mysql
3500/tcp open   rtmp-port
6697/tcp open   ircs-u
| irc-botnet-channels: 
|_  ERROR: Closing Link: [192.168.1.47] (Throttled: Reconnecting too fast) -Email admin@TestIRC.net for more information.
|_ssl-ccs-injection: No reply from server (TIMEOUT)
8080/tcp open   http-proxy
| http-slowloris-check: 
|   VULNERABLE:
|   Slowloris DOS attack
|     State: LIKELY VULNERABLE
|     IDs:  CVE:CVE-2007-6750
|       Slowloris tries to keep many connections to the target web server open and hold
|       them open as long as possible.  It accomplishes this by opening connections to
|       the target web server and sending a partial request. By doing so, it starves
|       the http server's resources causing Denial Of Service.
|       
|     Disclosure date: 2009-09-17
|     References:
|       https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-6750
|_      http://ha.ckers.org/slowloris/
8181/tcp closed intermapper
MAC Address: 08:00:27:A8:D3:2F (Oracle VirtualBox virtual NIC)

Host script results:
|_smb-vuln-ms10-054: false
| smb-vuln-regsvc-dos: 
|   VULNERABLE:
|   Service regsvc in Microsoft Windows systems vulnerable to denial of service
|     State: VULNERABLE
|       The service regsvc in Microsoft Windows 2000 systems is vulnerable to denial of service caused by a null deference
|       pointer. This script will crash the service if it is vulnerable. This vulnerability was discovered by Ron Bowes
|       while working on smb-enum-sessions.
|_          
|_smb-vuln-ms10-061: false

Nmap done: 1 IP address (1 host up) scanned in 374.49 seconds
Escaneo de vulnerabilidades completo. Resultados guardados en vuln_scan_192.168.1.48.txt
```

Una vez finalizado, realizamos un **ls -l** y tenemos un log de los resultados. Podemos visualizarlos con nuestro editor para darle formato "nvim" o un cat xxxx -l java


```bash
.rw-r--r-- root root 2.7 KB Sun Jun 30 17:02:06 2024  detailed_scan_192.168.1.48.txt
.rw-r--r-- root root  16 KB Sun Jun 30 17:08:20 2024  vuln_scan_192.168.1.48.txt
```


## Contribuciones


Las contribuciones son bienvenidas. Por favor, abre un issue o envía un pull request.


## Agradecimientos

Quiero agradecer a la comunidad de [TheHackersLabs](https://thehackerslabs.com/) por toda la ayuda, información, y apoyo que se recibe diariamente.

Y al PingüinodeMario  por los [cursos](https://elrincondelhacker.es/), gracias a ellos estoy aprendiendo mucho, y he creado este script.