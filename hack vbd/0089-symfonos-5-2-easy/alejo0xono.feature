## Version 1.4.1
## language: en

Feature:
  TOE:
    vulnhub symfonos: 5
  Location:
    http://192.168.1.124/admin.php
  CWE:
    CWE-89: https://cwe.mitre.org/data/definitions/89.html
  Rule:
    REQ.107: https://docs.fluidattacks.com/criteria/vulnerabilities/107
    REQ.146: https://docs.fluidattacks.com/criteria/vulnerabilities/146
    REQ.359: https://docs.fluidattacks.com/criteria/vulnerabilities/359
  Goal:
    Get root privileges
  Recommendation:
    Upgrade services such as LDAP and try don't save credentials in source code

  Background:

  Hacker's software:
    | <Software name> | <Version>    |
    | Kali linux      | 5.10.28      |
    | Virtualbox      | 6.1.34       |
    | Firefox         | 91.9.0       |
    | Nmap            | 7.92         |
    | Gobuster        | 3.1.0        |
    | Burp suite      | 2022.5.2     |
    | Ldapsearch      | 2.5.11       |
    | OpenSSH         | 9.0p1        |
  TOE information:
    Given a .7z file
    Then I pulled out the .ova file
    Then I ran the file in Virtualbox
    Then I could see the virtual machine was running [evidence](01.png)

  Scenario: Normal use case
    Given access to a PHP site http://192.168.1.124/
    Then I ran the browser
    And I could see just an image [evidence](02.png)

  Scenario: Dynamic detection
    Given an IPv4 address 192.168.1.124
    Then I ran a scan report
    And I execute the following command:
    """
    $ nmap -p- -sV -sC 192.168.1.124
    """
    Then I could see services and which ports are open [evidence](03.png)
    And I decided to explore the different ports
    Then I noted that port 80 was used by HTTP
    And its version Apache httpd 2.4.29
    When looking in the browser, I see a normal web page
    And there was just an image
    Then I noted that port 22 was used by SSH in its version OpenSSH 7.9p1
    Then I noted that port 389 was used by ldap in its version 2.2.X - 2.3.X
    When looking for an OpenLDAP 2.2.X - 2.3.X vulnerability
    Then I found the following article [evidence](04.png)
    """
    https://www.cvedetails.com/vulnerability-list/
    vendor_id-439/Openldap.html
    """
    When I checked it was something interesting
    Then I noted that port 636 was used by ldapssl
    Then I decided to search possible hidden directories with gobuster
    And I execute the following command:
    """
    $ gobuster dir -u http://192.168.1.124
    -w /usr/share/wordlist/dirb/common.txt
    """
    Then I got the next result [evidence](05.png)
    Then I tested the results directories
    Then I found the following directory
    """
    /admin.php
    """
    When I visited the page
    """
    http://192.168.1.124/admin.php
    """
    Then I could see a login form [evidence](06.png)
    Then I caught the request using Burp suite [evidence](07.png)
    When I saw the results
    Then I could conclude that I can use SQL injection on the login form

  Scenario: Exploitation
    Given the site http://192.168.1.124/admin.php
    And the PHP form
    Then I changed my /etc/hosts file
    Then the site can be called http://symfonos.local/ [evidence](08.png)
    Then I could execute an intruder attack using Burp [evidence](09.png)
    Then I got a positive response [evidence](10.png)
    Then I sent it to repeater and get the URL [evidence](11.png)
    Then I visited the page
    """
    http://symfonos.local/admin.php?username=%2a&password=%2a
    """
    Then I could access a new web page
    """
    http://symfonos.local/home.php
    """
    When I visited the page
    Then I could see a new interface [evidence](12.png)
    Then I could see that through the URL I could access the server
    Then I used the Burp suite to explore the files
    Then I could see the source code from:
    """
    home.php
    """
    Then I could see the next file to analyze [evidence](13.png)
    Then I explored watching source code from:
    """
    admin.php
    """
    Then I could see a ldap bind and its credentials [evidence](14.png)
    Then I run the following command: [evidence](15.png)
    """
    $ ldapsearch -x -D "cn=admin,dc=symfonos,dc=local"
    -W -H http://symfonos.local - b "dc=symfonos,dc=local"
    """
    Then I wrote the password obtained in the source code
    When I tested the credentials were valid
    Then I got a new user and a password with shell access [evidence](16.png)
    Then I analyzed the format of the password [evidence](17.png)
    Then I used the following tool to decode: [evidence](18.png)
    """
    https://www.base64decode.org/
    """
    When I got the ssh credentials
    Then I run the following command: [evidence](19.png)
    """
    $ ssh zeus@symfonos.local
    """
    Then I wrote the already decrypted password
    Then I run the following command: [evidence](20.png)
    """
    $ sudo -l
    """
    Then I could see the sudo commands that I can run
    Then I looked for a binary misconfigured from the next site:
    """
    https://gtfobins.github.io/
    """
    When I found the results
    Then I could see some options to escalate privileges [evidence](21.png)
    Then I run the following command:
    """
    $ sudo /usr/bin/dpkg
    """
    Then I wrote the following script: [evidence](22.png)
    """
    !/bin/sh
    """
    Then I got the flag
    And I become the root user [evidence](23.png)

  Scenario: Remediation
    Given that system has a vulnerability
    Then is necessary to upgrade the system and services
    Then is necessary avoid saving credentials in files
    And disable insecure features such as binaries that can be run in sudo
    Then I can confirm that the server is less vulnerable

  Scenario: Scoring
  Severity scoring according to CVSSv3 standard
  Base: Attributes that are constants over time and organizations
    7.5/10 (High) - AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N/
  Temporal: Attributes that measure the exploit's popularity and fixability
    6.5/10 (Medium) - E:P/RL:O/RC:R
  Environmental: Unique and relevant attributes to a specific user environment
    6.5/10 (Medium) - CR:M/IR:M/AR:M

  Scenario: Correlations
    No correlations have been found to this date 2022-06-30
