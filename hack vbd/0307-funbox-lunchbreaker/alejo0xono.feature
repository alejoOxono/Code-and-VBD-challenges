## Version 1.4.1
## language: en

Feature:
  TOE:
    vulnhub Funbox: Lunchbreaker
  Location:
    192.168.1.19:21
  CWE:
    CWE-307: https://cwe.mitre.org/data/definitions/307.html
  Rule:
    REQ.026: https://docs.fluidattacks.com/criteria/vulnerabilities/026
    REQ.053: https://docs.fluidattacks.com/criteria/vulnerabilities/053
    REQ.330: https://docs.fluidattacks.com/criteria/vulnerabilities/330
    REQ.385: https://docs.fluidattacks.com/criteria/vulnerabilities/385

  Goal:
    Get root privileges and the root flag
  Recommendation:
    Use of common protection mechanisms and don't save confidential information

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
    And the server is running FTP version vsftpd 3.0.3
    And SSH version OpenSSH 8.2p1
    And HTTP version Apache httpd 2.4.41

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
    http://192.168.1.19/
    """
    When looking in the browser
    Then I could see just an image [evidence](04.png)
    And information about a possible user [evidence](05.png)

  Scenario: Dynamic detection
    Given an IPv4 address 192.168.1.19
    Then I ran a scan report
    And I execute the following command:
    """
    $ nmap -p- -sV -sC 192.168.1.19
    """
    Then I could see services and which ports are open [evidence](06.png)
    And I decided to explore the different ports
    Then I noted that port 22 was used by SSH
    And its version OpenSSH 8.2p1
    Then I noted that port 21 was used by FTP
    And its version vsftpd 3.0.3
    Then I noted that port 80 was used by HTTP
    And its version Apache HTTPd 2.4.41
    When looking in the browser, I saw just an image
    And information about a possible user called "jane"
    Then I decided to search possible hidden directories with gobuster
    And I execute the following command:
    """
    $ gobuster dir -u http://192.168.1.19
    -w /usr/share/wordlist/dirb/common.txt
    """
    Then I got the next result [evidence](06.png)
    When I checked, it was not something interesting
    Then I decided to search for files using the anonymous user on FTP
    And I execute the following command:
    """
    $ ftp 192.168.1.19
    """
    Then I noted that there were a lot of files [evidence](08.png)
    When looking at their contents
    Then it was not something interesting
    Then I could conclude that I can use the given user
    And ran a force attack on FTP and/or SSH service
    And exploit the improper authentication vulnerability

  Scenario: Exploitation
    Given the FTP service 192.168.1.19:21
    And the improper authentication vulnerability
    And the user called "jane"
    Then I could execute a brute force attack command using hydra on FTP
    Then I run the following command:
    """
    $ hydra -l jane
    -P /usr/share/wordlists/metasploit/unix_passwords.txt
    ftp://192.168.1.19 -vV -f
    """
    When I got jane's password [evidence](9.png)
    Then I execute the following command using the given credentials:
    """
    $ ftp 192.168.1.19
    """
    Then I got access to a file
    When I checked, there was just a pair of keys [evidence](10.png)
    Then I decided to look for directories that I can access
    Then I saw some additionals users [evidence](11.png)
    """
    jim
    john
    jules
    """
    When I repeated the same process from "jane" to "jim"
    Then I got jim's password [evidence](12.png)
    And I execute the following command using the given credentials:
    """
    $ ftp 192.168.1.19
    """
    Then I got the next result [evidence](13.png)
    When I checked, there was just a pair of ssh files
    Then I decided to repeat the same process from "jim" to "jules"
    Then I got jules' password [evidence](14.png)
    When I execute the following command using the given credentials:
    """
    $ ftp 192.168.1.19
    """
    Then I got a pair of files [evidence](15.png)
    Then there were password dictionaries [evidence](16.png)
    Then I add a dictionary to the other [evidence](17.png)
    Then I run the following command using the last username:
    """
    $ hydra -l john
    -P .bad.passwds ssh://192.168.1.19 -vV -f
    """
    Then I got john's password [evidence](18.png)
    Then I run the following command:
    """
    $ ssh john@192.168.1.19
    """
    Then I got a positive response
    And I become the "john" user [evidence](19.png)
    When I was looking for confidential information saved in files
    Then I got a file called "todo.list" [evidence](20.png)
    When looking at its content
    Then I could see information about the root password
    When I execute the command
    """
    $ su -
    """
    And introduce the password given
    Then I become the root user
    And I got the flag [evidence](21.png)

  Scenario: Remediation
    Given that the system has a vulnerability
    Then is necessary to use libraries with authentication capabilities
    And got a well-developed architectural security tactic and a correct design
    And implementing a timeout
    And disconnecting the user after a small number of failed attempts
    And is necessary to avoid saving confidential info in files or source code
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
    No correlations have been found to this date 2022-07-29
