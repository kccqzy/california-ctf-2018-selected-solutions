# Saffy And Rosy Ice Cream

By Joe Qian, UCLA.

Note: There are three questions here, but we only deploy once.

Also note that the questions are solved in order: if you haven't solved
question 1 or 2, you definitely can't solve question 3; if you haven't solved
question 1, you definitely can't solve question 2 to 3.

# Question 1

Everyone's favorite ice cream store Saffy & Rosy recently just made a website!
Unfortunately their website is extremely basic and insecure.

As a hacker, you decided to explore their website.

You noticed that you can't register as the user `admin`. Perhaps it's already
been registered. Can you obtain the admin user's profile picture?

## Solution

There is no security protecting the profile picture endpoint. Simply register
as any user and you will notice the profile picture is at URL
`/profile-pic/xxx` where `xxx` is your chosen user name. Then visit
`/profile-pic/admin` to get the flag. The flag is in the picture.

Note: Many web apps do not properly perform authentication on all of their
endpoints. Some endpoints that should be secured are actually accessible by
anyone. This is a common vulnerability in web apps.

## Hint

Try registering as a user, and then explore a bit!


# Question 2

This website is written in a fancy language that compiles all code into a single
executable. Find the SHA1 hash of this executable. Express your answer in
hexadecimal, with uppercase A-F, enclosed in curly braces and with the word
"flag" prepended.

## Solution

Register a user with the profile picture URL set to `file:///proc/self/exe`.
Then log in and fetch the profile picture.

This is quite hard because contestants need to know several things: (1) `file`
URLs; (2) the `/proc` file system.

## Hint

1. You can provide a URL in a form. I wonder what kind of URL it supports.
2. I heard about this magical thing called /proc. I wonder what it does?

# Question 3

Having obtained the admin user's profile picture, obtain the admin user's
password. The password has at least 16 characters so you can't brute force it.
Luckily they are all ASCII characters; no Unicode funniness!

## Solution

This is not hard after having completed Q2. Basically, the participants need
to run `strings` on the executable and look for all ASCII strings at least 16
characters long. Finally, they should write a script to test each possibility,
because `strings -n 16 app | wc -l` shows almost 3,000 possibilities! (Although
some of them can readily be dismissed as unlikely.)

## Hint

Given the site is so insecure, don't you think the developer is the kind of
person who likes to hardcode credentials?
