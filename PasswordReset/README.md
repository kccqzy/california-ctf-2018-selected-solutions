# Password Reset

By Clark Minor, UCLA.

Andy forgot his BookFace login again. He has been sent a link to reset his
password. A 5-digit verification code was sent to his cell phone, but
unfortunately, he lost that too. Can you help Andy retrieve his password?

## Solution

The problem can be solved by brute forcing. You can write a simple bash script,
or a Python script to do so. You can try using the script `bruteforce.py` in
this folder (you may have to adjust the target url).

## Addendum

The inspiration for this problem came from a real vulnerability in Facebook's
beta login page. Anand Prakash, the whitehat who found the vulnerability, was
awarded a $15,000 bug bounty for finding it. He showed a solution to the problem
using BurpSuite. Read
[here](https://medium.freecodecamp.org/responsible-disclosure-how-i-could-have-hacked-all-facebook-accounts-f47c0252ae4d)
for a full description.

## Interesting Tidbit

This also contains an XSS vulnerability. Whatever that is present in the URL
query parameter will be echoed in the page itself. The CTF contains another
problem ("Phantom Bot") that utilizes this XSS issue.
