TEX = pdflatex
BIB = bibtex
TEXFLAGS = -interaction nonstopmode -halt-on-error -file-line-error

FILE=proposta
TEX_FILES = $(FILE).tex
AUX_FILES = $(FILE).aux
BIB_FILES = 
IMAGE_FILES = $(shell find 'figures/')
OTHER_FILES = $(BIB_FILES) $(IMAGE_FILES) Makefile
TARGET_FILE = proposta.pdf

RM = rm -f
TEX_TEMPS = *.log *.out *.aux *.fdb_latexmk *.bbl *.dvi *.fls *.spl

all: $(TARGET_FILE)
.ONESHELL:
$(TARGET_FILE): $(TEX_FILES) $(OTHER_FILES)
	x=$$(md5sum $(TARGET_FILE) | awk {' print $$1 '}); \
	y="0"; \
    bibtex_run=1; \
    \
	while [ "$$x" != "$$y" ]; \
    do \
		$(TEX) $(TEXFLAGS) $(TEX_FILES); \
        \
        if [ $$? -ne 0 ]; \
        then \
            exit; \
        fi; \
        \
        if [ $$bibtex_run -eq 1 ]; then \
            $(BIB) $(AUX_FILES); \
            bibtex_run=0; \
        fi; \
        if [ $$? -ne 0 ]; \
        then \
            exit; \
        fi; \
        \
        y=$$x; \
	    x=$$(md5sum $(TARGET_FILE) | awk {' print $$1 '}); \
	done

.PHONY:
clean:
	$(RM) $(TARGET_FILE) $(TEX_TEMPS)

clena: clean
