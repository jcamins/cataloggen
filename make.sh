#!/bin/bash
cat full.xml | perl sanitize.pl > temp.xml
#saxonb-xslt -s:test.xml -xsl:catalog.xsl -o:test.tex
saxonb-xslt -s:temp.xml -xsl:catalog.xsl -o:test.tex
latex test.tex
grep "^%NAMES:" test.tex | sed -e "s/%NAMES://" > names.idx
grep "^%SUBJECT:" test.tex | sed -e "s/%SUBJECT://" > subject.idx
grep "^%GEO:" test.tex | sed -e "s/%GEO://" > geo.idx
makeindex names
makeindex subject
makeindex geo
latex test.tex
latex test.tex
