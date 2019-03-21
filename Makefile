LATEX     = pdflatex

FILE=proposta

$(FILE).pdf: $(FILE).tex
	$(LATEX) $<
	$(LATEX) $<

.PHONY: clean
clean:
	rm -f $(FILE).log $(FILE).out $(FILE).pdf $(FILE).aux
