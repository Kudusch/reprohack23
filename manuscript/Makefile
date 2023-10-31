render: fig-waffle-1.pdf
	Rscript -e "knitr::knit(\"body.Rtex\", output = \"body.tex\")"
	Rscript -e "knitr::knit(\"main.Rtex\", output = \"main.tex\")"
	latexmk -cd main.tex
	rm -f *.out *aux *bbl *blg *log *toc *.ptb *.tod *.fls *.fdb_latexmk *.lof *.fff *.run.xml *.bcf
	rm main.tex
	rm body.tex
fig-waffle-1.pdf:
	quarto render waffle.qmd
