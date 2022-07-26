## Version 1.4.1
## language: en

Feature:
  TOE:
    vulnhub Funbox: Under Construction
  Location:
    http://192.168.1.83/catalog/install/index.php
  CWE:
    CWE-79: https://cwe.mitre.org/data/definitions/79.html
  Rule:
    REQ.004: https://docs.fluidattacks.com/criteria/vulnerabilities/004
    REQ.010: https://docs.fluidattacks.com/criteria/vulnerabilities/010
    REQ.014: https://docs.fluidattacks.com/criteria/vulnerabilities/014
    REQ.061: https://docs.fluidattacks.com/criteria/vulnerabilities/061
    REQ.359: https://docs.fluidattacks.com/criteria/vulnerabilities/359
  Goal:
    Get root privileges
  Recommendation:
    Upgrade the osCommerce tool, don't save and don't share credentials

  Background:

  Hacker's software:
    | <Software name> | <Version>    |
    | Kali linux      | 5.10.28      |
    | Virtualbox      | 6.1.34       |
    | Firefox         | 91.9.0       |
    | Nmap            | 7.92         |
    | Gobuster        | 3.1.0        |
    | arp-scan        | 1.9.7        |
    | msfconsole      | 6.2.3-dev    |
    | pspy            | 1.2.0        |
    | Burp Suite      | 2022.6.1     |
    | linpeas         | 2.6.8        |
  TOE information:
    Given a .ova file
    Then I ran the file in Virtualbox
    Then I could see the virtual machine was running [evidence](01.png)
    And the server is running HTTP version Apache HTTPd 2.4.18
    And SSH version OpenSSH 7.2p2
    And SMTP version Postfix smtpd
    And POP3 version Dovecot pop3d
    And IMAP version Dovecot imapd

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
    http://192.168.1.83/
    """
    When looking in the browser
    Then I saw a web page [evidence](04.png)

  Scenario: Dynamic detection
    Given an IPv4 address 192.168.1.83
    Then I ran a scan report
    And I execute the following command:
    """
    $ nmap -p- -sV -sC 192.168.1.83
    """
    Then I could see services and which ports are open [evidence](05.png)
    And I decided to explore the different ports
    Then I noted that port 22 was used by SSH
    And its version OpenSSH 7.2p2
    Then I noted that port 25 was used by SMTP
    And its version Postfix smtpd
    Then I noted that port 110 was used by POP3
    And its version Dovecot pop3d
    Then I noted that port 143 was used by IMAP
    And its version Dovecot imapd
    Then I noted that port 80 was used by HTTP
    And its version Apache HTTPd 2.4.18
    When looking in the browser, I see a web page
    Then I decided to search possible hidden directories with gobuster
    And I execute the following command:
    """
    $ gobuster dir -u http://192.168.1.83
    -w /usr/share/wordlist/dirb/common.txt
    """
    Then I got the next result [evidence](06.png)
    When looking at the website:
    """
    http://192.168.1.83/catalog
    """
    Then I found an administration tool [evidence](07.png)
    When looking for an osCommerce 2.3.4 vulnerability
    Then I found the following article [evidence](08.png)
    """
    https://www.exploit-db.com/exploits/34582
    """
    When I checked it was something interesting
    And it was a cross-site scripting
    Then I could conclude that I can use msfconsole
    And exploit the osCommerce 2.3.4 vulnerability

  Scenario: Exploitation
    Given the site http://192.168.1.83/catalog/install/index.php
    And the osCommerce 2.3.4 vulnerability
    Then I could execute cross-site scripting using msfconsole
    Then I run the following commands: [evidence](09.png)
    """
    $ msfconsole
    > search osCommerce 2.3.4
    > use exploit/multi/http/oscommerce_installer_unauth_code_exec
    > set RHOSTS 192.168.1.83
    > exploit
    """
    When I got a positive response
    Then I got access to a meterpreter shell [evidence](10.png)
    When looking for interesting data in web service files [evidence](11.png)
    And using Burp Suite for easy reading
    Then I got MySQL user credentials [evidence](12.png)
    When I log in with the new user
    Then I tried to look for a new vulnerability
    Then I used linpeas to escalate permissions [evidence](13.png)
    Then I saw some vulnerabilities
    When I tried to exploit CVE-2021-4034
    And dirtycow 2 vulnerabilities [evidence](14.png)
    Then I got a negative response
    When I could not get good information
    Then I used pspy [evidence](15.png)
    And got data from binaries that my user could see [evidence](16.png)
    Then I got a way to escalate permissions [evidence](17.png)
    When I opened the file
    Then I got a base64 message [evidence](18.png)
    When I used the following web tool:
    """
    https://www.base64decode.org/
    """
    Then I got the root credentials [evidence](19.png)
    When I got a positive response inserting the credentials
    Then I become the root user
    And I got the flag [evidence](20.png)

  Scenario: Remediation
    Given that the system has a vulnerability
    Then is necessary to upgrade the osCommerce tool
    Then is necessary avoid saving credentials in files
    And don't share them in features such as binaries
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
    No correlations have been found to this date 2022-07-08
