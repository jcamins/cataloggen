#!/bin/bash
saxonb-xslt -s:full_fin.xml -xsl:preprocess.xsl -o:processed.xml
#saxonb-xslt -s:full.xml -xsl:preprocess.xsl -o:processed.xml
cat processed.xml | perl sanitize.pl > temp.xml
saxonb-xslt -s:temp.xml -xsl:catalog.xsl -o:test.tex
latex test.tex
grep "^%NAMES:" test.tex | sed -e "s/%NAMES://" | sed -e "s/|/ /g" > names.idx
grep "^%SUBJECT:" test.tex | sed -e "s/%SUBJECT://" | sed -e "s/|/ /g" > subject.idx
grep "^%GEO:" test.tex | sed -e "s/%GEO://" | sed -e "s/|/ /g" > geo.idx
grep "^%SERIES:" test.tex | sed -e "s/%SERIES://" | sed -e "s/|/ /g" > series.idx
makeindex names
makeindex subject
makeindex geo
makeindex -s series.ist series
latex test.tex
latex test.tex
