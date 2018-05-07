# Math Shenanigans 

By Timothy Rediehs, UCLA.

Your math teacher recently deducted full points for a missing negative sign on
your test. A missing sign! You totally understood the concept, but he just
took off all the points anyways! Completely unreasonable! As a result, you
decided to try and hack his website and use sql injection to discover his deep
secret.

## Hints
1. This is a login form, check for vulnerabilities in input fields
2. There is another query happening here, but it's based on a button click.
   However, there is somewhere in your browser where you can change or specify
   the input for the query.


## Solution
1.  Type `admin' -- ` into the username field. 
2.  On the search animals page, type `' UNION SELECT password FROM users WHERE username = 'admin` 
    in the url bar after `type=` (which makes it a query
    parameter). On some browsers, you may need to manually percent-encode that
    string. In any case, Chrome is recommended.
