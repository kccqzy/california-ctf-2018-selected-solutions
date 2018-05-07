# QQ PDF Syntax

By Tanya Al-Rehani, UCLA.

You are a spy working undercover in an enemy country's government (Rolania)
trying to gather intel on a political party's latest campaign strategies.
However, your boss Andrew is incredibly paranoid and encrypts everything. You
see dozens of encrypted PDFs everyday but haven't been able to tell anything
about the file's information and all the files are closely monitored and not
allowed out of the office. You got lucky and found a USB containing one such
file that your boss left out on a desk before leaving for a date with his wife
Cilly. Get to work!

## Hints
1. I wonder what tools exist for password cracking...
2. Why is there an empty page in this file?

## Solution

Steps to recreate problem:

1.  Install [qpdf](http://qpdf.sourceforge.net), a remarkably good tool to deal
    with simple operations on PDF files.
2.  Run `qpdf --empty --pages pdf-challenge*.pdf -- out.pdf`. This combines the
    two documents together and creates `out.pdf`.
3.  Run `qpdf --qdf out.pdf out-text-challenge.pdf`; this creates a PDF in [QDF
    Mode](http://qpdf.sourceforge.net/files/qpdf-manual.html#ref.qdf), a mode
    especially suited for manual editing of PDF files in ordinary text editors.
4.  Use an editor to change an occurrence of `/Image` into `/image`. According to
    the [PDF
    reference](https://www.adobe.com/content/dam/acom/en/devnet/pdf/pdfs/pdf_reference_archives/PDFReference.pdf),
    section 4.8.4, in an image dictionary, the key `Subtype` must be the name
    `Image` (with a slash in front because that is the syntax for names). 
4.  Run `fix-qdf < out-text-challenge.pdf > out-fixed-challenge.pdf`. In this
    specific case this is unnecessary because we did not alter the lengths of
    anything, so the byte offsets at the end of the file (the `xref` table) need
    not change.
5.  Run `qpdf --encrypt c1lly c1lly 40 -- out-fixed-challenge.pdf
    RolaniaCampaignStrategyMeeting4-4-18.pdf`. This encrypts the PDF.
6.  Distribute the finalized `RolaniaCampaignStrategyMeeting4-4-18.pdf`.

Or use our provided `Makefile` to create the problem.

To Solve:

1.  Install `qpdf`. 
2.  Run `hashcat` or `jtr` to brute force the encryption. The `pdf2john.pl`
    utility is useful for extracting the hash.

        ./JohnTheRipper-bleeding-jumbo/run/pdf2john.pl Rolania*.pdf

    Copy the output after the colon and put it in a file. Or run
    
        ./JohnTheRipper-bleeding-jumbo/run/pdf2john.pl Rolania*.pdf | awk -F: '{print $2}' > h.txt
        
    Next use john the ripper or hashcat to crack it.

        hashcat/hashcat -m 10400 -a 3 -i h.txt

3.  Notice an empty page in the file, again use QPDF to produce a QDF file and
    open it in an text editor. Remember to supply the cracked password to QPDF!
4.  Find `/image` and change into `/Image`. Now the pdf should now display an
    image containing the flag info. Alternatively (easier!) use a tool that can
    extract all resources within a PDF.
