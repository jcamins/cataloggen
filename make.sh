#!/bin/sh

# Copyright (c) 2010 C & P Bibliography Services, Jared Camins-Esakov
# Cataloggen is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# Cataloggen is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with Cataloggen.  If not, see <http://www.gnu.org/licenses/>.

saxonb-xslt -s:$1 -xsl:preprocess.xsl -o:processed.xml
cat processed.xml | perl sanitize.pl > temp.xml
saxonb-xslt -s:temp.xml -xsl:catalog.xsl -o:catalog.tex
touch names.idx subject.idx geo.idx series.idx names.ind subject.ind geo.ind series.ind
xelatex catalog.tex
grep "^%NAMES:" catalog.tex | sed -e "s/%NAMES://" | sed -e "s/|/ /g" > names.idx
grep "^%SUBJECT:" catalog.tex | sed -e "s/%SUBJECT://" | sed -e "s/|/ /g" > subject.idx
grep "^%GEO:" catalog.tex | sed -e "s/%GEO://" | sed -e "s/|/ /g" > geo.idx
grep "^%SERIES:" catalog.tex | sed -e "s/%SERIES://" | sed -e "s/|/ /g" > series.idx
makeindex names
makeindex subject
makeindex geo
makeindex -s series.ist series
xelatex catalog.tex
xelatex catalog.tex
gs -q -dCompatibilityLevel=1.4 -dSubsetFonts=false -dPDFSETTINGS=/printer -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=catalog_final.pdf catalog.pdf -c '.setpdfwrite'
