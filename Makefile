FIGURES_FOLDER := figures
PDFS := \
$(filter-out $(wildcard $(FIGURES_FOLDER)/*-crop.pdf),$(wildcard $(FIGURES_FOLDER)/*.pdf)) \
$(filter-out $(wildcard $(FIGURES_FOLDER)/**/*-crop.pdf),$(wildcard $(FIGURES_FOLDER)/**/*.pdf))
CROPPED_PDFS := $(PDFS:.pdf=-crop.pdf)

all: main.pdf

%.pdf: %.tex Makefile $(CROPPED_PDFS)
	pdflatex -synctex=1 -interaction=nonstopmode $<

.PHONY: figures
figures: $(CROPPED_PDFS)

.PRECIOUS: $(CROPPED_PDFS)
%-crop.pdf: %.pdf Makefile
	pdfcrop $<

.PHONY: clean upgrade
clean:
	find . -maxdepth 1 \
		\( -name "*.aux" -o -name "*.bbl" -o -name "*.blg" -o \
	           -name "*.log" -o -name "*.out" -o -name "*.pdf" -o \
		   -name "*.synctex.gz" \) | xargs $(RM)
	find $(FIGURES_FOLDER) -name "*-crop.pdf" | xargs $(RM)

DCS_LETTER_VERSION := 20160129

upgrade:
	curl -O https://support.cs.toronto.edu/software/dcsletter-${DCS_LETTER_VERSION}.tgz
	tar xzvf dcsletter-${DCS_LETTER_VERSION}.tgz
	$(RM) dcsletter-${DCS_LETTER_VERSION}.tgz \
		*.eps *.jpg \
		dcsletter.tex \
		README
