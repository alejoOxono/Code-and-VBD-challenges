## Version 1.4.1
## language: en

Feature:
  TOE:
    vulnhub hacksudo: L.P.E.
  Location:
    http://192.168.1.129/login.php
  CWE:
    CWE-615: https://cwe.mitre.org/data/definitions/615.html
  Rule:
    REQ.014: https://docs.fluidattacks.com/criteria/vulnerabilities/014
    REQ.020: https://docs.fluidattacks.com/criteria/vulnerabilities/020
    REQ.359: https://docs.fluidattacks.com/criteria/vulnerabilities/359
  Goal:
    Get flag from root or get root privileges
  Recommendation:
    Don't save credentials in source code

  Background:

  Hacker's software:
    | <Software name> | <Version> |
    | Kali linux      | 5.10.28   |
    | Virtualbox      | 6.1.34    |
    | Firefox         | 91.9.0    |
    | Nmap            | 7.92      |
    | Burp suite      | 2022.5.2  |
  TOE information:
    Given a .ova file
    Then I ran the file in Virtualbox
    Then I could see the virtual machine was running [evidence](01.png)
    And the server is running SSH version OpenSSH 7.9p1
    And HTTP version Apache httpd 2.4.38
    And SSL/HTTP version ShellInABox

  Scenario: Normal use case
    Given access to a PHP site http://192.168.1.129
    Then I decided to visit the site:
    """
    http://192.168.1.129
    """
    When looking in the browser
    Then I saw a web page and a login form [evidence](02.png)

  Scenario: Dynamic detection
    Given an IPv4 address 192.168.1.129
    Then I ran a scan report
    And I execute the following command:
    """
    $ nmap -p- -sV -sC 192.168.1.129
    """
    Then I could see services and which ports were open [evidence](03.png)
    And I decided to explore the different ports
    Then I noted that port 4200 was used by SSL/HTTP in its version ShellInABox
    Then I noted that port 22 was used by SSH in its version OpenSSH 7.9p1
    Then I noted that port 80 was used by HTTP
    And its version Apache httpd 2.4.38
    When looking in the browser, I see a login form
    Then I caught the request from the form using Burp suite [evidence](04.png)
    Then I get a username and a password [evidence](05.png)
    Then I log in with the given credentials
    And I gained access to the admin panel
    When looking for information within the panel
    Then I get a new username and a new password [evidence](06.png)
    Then I could conclude that I can use the credentials stored in plain text
    And exploit the non-encrypted confidential information vulnerability

  Scenario: Exploitation
    Given the site http://192.168.1.129/login.php
    And the non-encrypted confidential information vulnerability
    And the given credentials
    Then I execute the following command:
    """
    $ ssh user1@192.168.1.129
    """
    When I tested the credentials were valid
    Then I run the following command: [evidence](07.png)
    """
    $ sudo -l
    """
    Then I could see the sudo commands that I can run
    And the only one was "/usr/bin/apt-get"
    Then I looked for a binary misconfigured from the following site:
    """
    https://gtfobins.github.io/
    """
    When I found the results
    Then I could see some options to escalate privileges [evidence](08.png)
    Then I run the following command:
    """
    $ sudo apt-get changelog apt
    """
    Then I wrote the following script:
    """
    !/bin/sh
    """
    Then I got the flag
    And I become the root user [evidence](09.png)

  Scenario: Remediation
    Given that system has a vulnerability
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
    No correlations have been found to this date 2022-08-04
