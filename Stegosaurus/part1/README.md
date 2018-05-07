# Stegosaurus Part 1

Dr. Steg is distributing a secret message using a 'secure' method! You think
he's using this image, but its contents look normal...

## Hint

Metadata holds many secrets.

## Solution

This flag is hidden in the exif metadata of Secure.png. It can be found using
`exiftool`, `strings`, or by searching the file like this:

    LC_ALL=C egrep -ao 'flag{.+}' Secure.png
