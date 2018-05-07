# File Concatenation Flag

Dr. Steg is back at it again, trying to send out a secret key by hijacking this
video game advertisement. You think he probably won't use his old trick, but
it's got to be here somewhere.

## Hint
Let's go on a walk past some bins.

## Solution

This flag is hidden as an image concatenated to the end of the image file. It
was created as follows:

    cat steg.orig.gif key.png > steg.gif

This creates the file `steg.gif` which appears to be a normal GIF-format image.
The file `key.png` can be discovered by using a forensics tool such as `binwalk`,
or by looking for the GIF file terminator byte in the file. Once the location
is discovered, it can be extracted using `binwalk` or `dd`.

    dd if=steg.gif bs=1 skip=25780 of=foo.png

## Fun Fact

It turns out that the number `0` and the uppercase `O` is hard to distinguish
with our font!
