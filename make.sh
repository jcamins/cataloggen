#!/bin/bash
saxonb-xslt -s:full_fin.xml -xsl:preprocess.xsl -o:processed.xml
#saxonb-xslt -s:full.xml -xsl:preprocess.xsl -o:processed.xml
cat processed.xml | perl sanitize.pl > temp.xml
saxonb-xslt -s:temp.xml -xsl:catalog.xsl -o:catalog.tex
latex catalog.tex
grep "^%NAMES:" catalog.tex | sed -e "s/%NAMES://" | sed -e "s/|/ /g" > names.idx
grep "^%SUBJECT:" catalog.tex | sed -e "s/%SUBJECT://" | sed -e "s/|/ /g" > subject.idx
grep "^%GEO:" catalog.tex | sed -e "s/%GEO://" | sed -e "s/|/ /g" > geo.idx
grep "^%SERIES:" catalog.tex | sed -e "s/%SERIES://" | sed -e "s/|/ /g" > series.idx
makeindex names
makeindex subject
makeindex geo
makeindex -s series.ist series
latex catalog.tex
latex catalog.tex
gs -q -dCompatibilityLevel=1.4 -dSubsetFonts=false -dPDFSETTINGS=/printer -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=catalog_final.pdf catalog.pdf -c '.setpdfwrite'
