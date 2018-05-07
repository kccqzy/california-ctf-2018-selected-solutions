RolaniaCampaignStrategyMeeting4-4-18.pdf: step4.pdf
	qpdf --encrypt c1lly c1lly 40 -- $< $@

step1.pdf: pdf-challenge-flag.pdf pdf-challenge-in.pdf
	qpdf --empty --pages $^ -- $@

step2.pdf: step1.pdf
	qpdf --qdf $< $@

step3.pdf: step2.pdf
	LC_ALL=C sed 's!/Image$$!/image!' $< > $@ || ( rm -f $@ && false )

step4.pdf: step3.pdf
	fix-qdf < $< > $@

.PHONY: clean

clean:
	-rm -f step*.pdf RolaniaCampaignStrategyMeeting4-4-18.pdf
