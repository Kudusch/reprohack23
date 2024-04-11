render: fig-waffle-1.pdf body.tex ccr.cls
	latexmk -xelatex main.tex
	rm -f *.out *aux *bbl *blg *log *toc *.ptb *.tod *.fls *.fdb_latexmk *.lof *.fff *.run.xml *.bcf *.xdv
fig-waffle-1.pdf:
	quarto render waffle.qmd
body.tex:
	Rscript -e "knitr::knit(\"body.Rtex\", output = \"body.tex\")"
ccr.cls:
	curl -LO https://raw.githubusercontent.com/ccr-journal/ccr-quarto/main/_extensions/ccr/ccr.cls
nuke:
	rm body.tex
	rm fig-waffle-1.pdf
	rm ccr.cls
all: nuke ccr.cls fig-waffle-1.pdf body.tex render
