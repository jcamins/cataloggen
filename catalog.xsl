<!--<?xml version="1.0" encoding="utf-8"?>-->
<!-- Copyright (c) 2010 C & P Bibliography Services, Jared Camins-Esakov
     Cataloggen is free software: you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation, either version 3 of the License, or
     (at your option) any later version.
     
     Cataloggen is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
     
     You should have received a copy of the GNU General Public License
     along with Cataloggen.  If not, see <http://www.gnu.org/licenses/>. -->
<xsl:stylesheet version="2.0" xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>
<xsl:strip-space elements="*"/>

	<xsl:template match="/">
		<xsl:text>\input{./preamble.tex}
\begin{document}
\maxtocdepth{section}
\pagestyle{empty}
\pagenumbering{roman}

\input{./title.tex}
\input{./copyright.tex}
\cleardoublepage
\input{./dedication.tex}

\tableofcontents 

\cleardoublepage
\input{./intro.tex}
\cleardoublepage

\pagenumbering{arabic}
\leftskip 2em
\parindent -2em

\part{Catalog}
\pagestyle{headings}
\settocdepth{chapter}&#10;</xsl:text>

			<xsl:apply-templates select="marc:collection/marc:record | marc:collection/marc:see">
				<xsl:sort select="lower-case(substring(marc:datafield[@tag='245']/marc:subfield[@code='a']/text(),marc:datafield[@tag='245']/@ind2 + 1))" order="ascending"/>
			</xsl:apply-templates>

		<xsl:text>\part{Indexes}
\settocdepth{section}
\printindex{names}{Name index}
\printindex{subject}{Subject index}
\printindex{geo}{Geographical index}
\printindex{series}{Series index}
\end{document}</xsl:text>
	</xsl:template>

	<xsl:template match="marc:collection/marc:see">
		<xsl:text>\seeentry{</xsl:text><xsl:value-of select="replace(concat(marc:datafield[@tag=245]/marc:subfield[@code='a'],marc:datafields[@tag=245]/marc:subfield[@code='b']),'[\s.:;]+$','')"/><xsl:text>}{</xsl:text><xsl:value-of select="marc:ref/text()"/><xsl:text>}{</xsl:text>
		<xsl:for-each select="marc:title/marc:subfield">
			<xsl:call-template name="subfield-245"/>
		</xsl:for-each>
		<xsl:text>}&#10;</xsl:text>
	</xsl:template>

	<xsl:template match="marc:collection/marc:record">
		<xsl:variable name="pos"><xsl:number level="single" count="marc:record"/></xsl:variable>
		<xsl:apply-templates select="marc:datafield[@tag=245]"/> <!-- Title -->
		<xsl:text>\label{</xsl:text><xsl:value-of select="marc:ref/text()"/><xsl:text>}&#10;</xsl:text>
		<xsl:text>\begin{minipage}[t]{.73\textwidth}&#10;</xsl:text>
		<xsl:apply-templates select="marc:datafield[@tag=250]"/> <!-- Edition -->
		<xsl:apply-templates select="marc:datafield[@tag=260]"/> <!-- Imprint -->
		<xsl:apply-templates select="marc:datafield[@tag=300]"/> <!-- Physical desc -->
		<xsl:text>\end{minipage}&#10;</xsl:text>
		<xsl:text>\begin{minipage}[t]{.25\textwidth}&#10;\begin{flushright}&#10;</xsl:text>
		<xsl:apply-templates select="marc:datafield[@tag=020]"/> <!-- ISBN -->
		<xsl:text>\end{flushright}&#10;\end{minipage}&#10;\par&#10;\smallskip&#10;</xsl:text>

		<xsl:for-each select="marc:datafield[@tag=440 or @tag=490 or @tag=830 or @tag=840]">
			<xsl:text>\hspace*{1em}(</xsl:text>
			<xsl:variable name="series">
				<xsl:for-each select="marc:subfield">
					<xsl:call-template name="subfield-generic"/>
				</xsl:for-each>
			</xsl:variable>
			<xsl:value-of select="replace($series,'[\s.:;]+$','')"/>
			<xsl:text>)\par&#10;</xsl:text>
			<xsl:call-template name="index-series">
				<xsl:with-param name="number" select="$pos"/>
			</xsl:call-template>
		</xsl:for-each>
	
		<!-- Notes -->
		<xsl:for-each select="marc:datafield[@tag &gt; 499 and @tag &lt; 590]">
			<xsl:call-template name="note-generic"/>
		</xsl:for-each>

		<!-- Indexes -->
		<xsl:for-each select="marc:datafield[@tag=100 or @tag=600 or @tag=700]">
			<xsl:call-template name="index-personal-name">
				<xsl:with-param name="number" select="$pos"/>
			</xsl:call-template>
		</xsl:for-each>
		<xsl:for-each select="marc:datafield[@tag=110 or @tag=610 or @tag=710]">
			<xsl:call-template name="index-corporate-name">
				<xsl:with-param name="number" select="$pos"/>
			</xsl:call-template>
		</xsl:for-each>
		<xsl:for-each select="marc:datafield[@tag=650 or @tag=651]">
			<xsl:call-template name="index-subject">
				<xsl:with-param name="number" select="$pos"/>
			</xsl:call-template>
		</xsl:for-each>
		<xsl:for-each select="marc:datafield[@tag=650 or @tag=651 or @tag=751]">
			<xsl:call-template name="index-geographical">
				<xsl:with-param name="number" select="$pos"/>
			</xsl:call-template>
		</xsl:for-each>

	</xsl:template>

	<xsl:template name="subfield-generic">
		<xsl:if test="@code!='6' and @code!='8' and @code!='5'">
			<xsl:value-of select="text()"/><xsl:text> </xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template name="note-generic">
		<xsl:text> --- </xsl:text>
		<xsl:for-each select="marc:subfield">
			<xsl:call-template name="subfield-generic"/>
		</xsl:for-each>
		<xsl:text>\par&#10;</xsl:text>
	</xsl:template>

	<xsl:template name="subfield-pn">
		<xsl:if test="@code='a' or @code='b'">
			<xsl:choose>
<!--				<xsl:when test="following-sibling::marc:subfield[position()=1]/@code='b' or following-sibling::marc:subfield[position()=1]/@code='q' or following-sibling::marc:subfield[position()=1]/@code='c' or following-sibling::marc:subfield[position()=1]/@code='a'">-->
				<xsl:when test="following-sibling::marc:subfield[position()=1]/@code='b' or following-sibling::marc:subfield[position()=1]/@code='a'">
					<xsl:value-of select="replace(replace(replace(text(),'([\s.][a-zA-Z])\.[\s;:]*$','$1#'),'[\s.:;]+$',''),'#','.')"/><xsl:text> </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="replace(replace(replace(text(),'([\s.][a-zA-Z])\.[\s,;:]*$','$1#'),'[\s.,:;]+$',''),'#','.')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<xsl:template name="index-personal-name">
		<xsl:param name="number"/>
		<xsl:text>%NAMES:\indexentry{</xsl:text>
		<xsl:for-each select="marc:subfield">
			<xsl:call-template name="subfield-pn"/>
		</xsl:for-each>
		<xsl:text>}{</xsl:text><xsl:value-of select="$number"/><xsl:text>}&#10;</xsl:text>
	</xsl:template>

	<xsl:template name="subfield-cn">
		<xsl:if test="@code='a' or @code='b' or @code='c'">
			<xsl:choose>
				<xsl:when test="following-sibling::marc:subfield[position()=1]/@code='a' or following-sibling::marc:subfield[position()=1]/@code='b' or following-sibling::marc:subfield[position()=1]/@code='c'">
					<xsl:value-of select="text()"/><xsl:text> </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="replace(replace(replace(text(),'([\s.][a-zA-Z])\.[\s,;:]*$','$1#'),'[\s.,:;]+$',''),'#','.')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<xsl:template name="index-corporate-name">
		<xsl:param name="number"/>
		<xsl:text>%NAMES:\indexentry{</xsl:text>
		<xsl:for-each select="marc:subfield">
			<xsl:call-template name="subfield-cn"/>
		</xsl:for-each>
		<xsl:text>}{</xsl:text><xsl:value-of select="$number"/><xsl:text>}&#10;</xsl:text>
	</xsl:template>

	<xsl:template name="subfield-subj">
		<xsl:if test="@code='a' or @code='v' or @code='x' or @code='y' or @code='z' or @code='b' or @code='c' or @code='d' or @code='p'">
			<xsl:variable name="lastsubfield" select="preceding-sibling::marc:subfield[position()=1]/@code"/>
			<xsl:if test="$lastsubfield='a' or $lastsubfield='v' or $lastsubfield='x' or $lastsubfield='y' or $lastsubfield='z' or $lastsubfield='b' or $lastsubfield='c' or $lastsubfield='d' or $lastsubfield='p'">
				<xsl:text>!</xsl:text>
			</xsl:if>
			<xsl:value-of select="replace(replace(replace(text(),'([\s.][a-zA-Z])\.[\s,;:]*$','$1#'),'[\s.,:;]+$',''),'#','.')"/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="index-subject">
		<xsl:param name="number"/>
		<xsl:text>%SUBJECT:\indexentry{</xsl:text>
		<xsl:for-each select="marc:subfield">
			<xsl:call-template name="subfield-subj"/>
		</xsl:for-each>
		<xsl:text>}{</xsl:text><xsl:value-of select="$number"/><xsl:text>}&#10;</xsl:text>
	</xsl:template>

	<xsl:template name="index-geographical">
		<xsl:param name="number"/>
		<xsl:text>%GEO:\indexentry{</xsl:text>
		<xsl:if test="@tag=651 or @tag=751">
			<xsl:value-of select="replace(marc:subfield[@code='a']/text(),'[\s.,;:]+$','')"/>
		</xsl:if>
		<xsl:for-each select="marc:subfield[@code='z']">
			<xsl:if test="not(position()=1) or @tag=651 or @tag=751">
				<xsl:text>!</xsl:text>
			</xsl:if>
			<xsl:value-of select="replace(text(),'[\s.,;:]+$','')"/>
		</xsl:for-each>
		<xsl:text>}{</xsl:text><xsl:value-of select="$number"/><xsl:text>}&#10;</xsl:text>
	</xsl:template>

	<xsl:template name="index-series">
		<xsl:param name="number"/>
		<xsl:text>%SERIES:\indexentry{</xsl:text>
		<xsl:for-each select="marc:subfield">
			<xsl:if test="not(position()=1)">
				<xsl:text>!</xsl:text>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="not(@code='v')">
					<xsl:text>z</xsl:text><xsl:value-of select="replace(text(),'[\s.,;:/]+$','')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="replace(replace(text(),'^[^0-9]+([0-9])','$1'),'[\s.,;:/]+$','')"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>@</xsl:text>
			<xsl:if test="@code='v' and matches(text(),'^\W*[0-9]')">
				<xsl:text>(no.) </xsl:text>
			</xsl:if>
			<xsl:value-of select="replace(text(),'[\s.,;:/]+$','')"/>
		</xsl:for-each>
		<xsl:text>}{</xsl:text><xsl:value-of select="$number"/><xsl:text>}&#10;</xsl:text>
	</xsl:template>
	
	<xsl:template name="subfield-245">
		<xsl:if test="@code!='6' and @code!='8'">
			<xsl:choose>
				<xsl:when test="following-sibling::marc:subfield[position()=1]/@code='b'">
					<xsl:value-of select="replace(text(),'[\s.,;:/]+$',' :')"/><xsl:text> </xsl:text>
				</xsl:when>
				<xsl:when test="following-sibling::marc:subfield[position()=1]/@code='c'">
					<xsl:value-of select="replace(text(),'[\s.,;:/]+$',' /')"/><xsl:text> </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="text()"/>
					<xsl:if test="exists(following-sibling::marc:subfield[position()=1])"><xsl:text> </xsl:text></xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<xsl:template name="subfield-260">
		<xsl:if test="@code!='6' and @code!='8'">
			<xsl:choose>
				<xsl:when test="following-sibling::marc:subfield[position()=1]/@code='b'">
					<xsl:value-of select="replace(text(),'[\s,;:/]+$',' :')"/><xsl:text> </xsl:text>
				</xsl:when>
				<xsl:when test="following-sibling::marc:subfield[position()=1]/@code='c'">
					<xsl:value-of select="replace(text(),'[\s.,;:/]+$',',')"/><xsl:text> </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="text()"/><xsl:text> </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<xsl:template name="subfield-300">
		<xsl:if test="@code!='6' and @code!='8'">
			<xsl:choose>
				<xsl:when test="following-sibling::marc:subfield[position()=1]/@code='b'">
					<xsl:value-of select="replace(text(),'[\s,;:/]+$','')"/>
					<xsl:if test="substring(normalize-space(following-sibling::marc:subfield[position()=1]/text()),1,1)!='('"><xsl:text> :</xsl:text></xsl:if>
					<xsl:text> </xsl:text>
				</xsl:when>
				<xsl:when test="following-sibling::marc:subfield[position()=1]/@code='c'">
					<xsl:value-of select="replace(text(),'[\s,;:/]+$','')"/>
					<xsl:if test="substring(normalize-space(following-sibling::marc:subfield[position()=1]/text()),1,1)!='('"><xsl:text> ;</xsl:text></xsl:if>
					<xsl:text> </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="text()"/><xsl:text> </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>

	<xsl:template match="marc:datafield[@tag='245']">
		<xsl:text>\section[</xsl:text>
		<xsl:variable name="firstfive" select="replace(substring(marc:subfield[@code='a'],@ind2 + 1),'((\w+[\s./,:;=+!?]+){4}\w+).*','$1')"/>
		<xsl:variable name="noparens" select="replace($firstfive,'(.*)[(]','$1')"/>
		<xsl:choose>
			<xsl:when test="contains($noparens,'[')">
				<xsl:value-of select="replace(substring-before($noparens,'['),'[\s.,;:/]+$','')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="replace($noparens,'[\s.,;:/]+$','')"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>]{</xsl:text>
		<xsl:for-each select="marc:subfield">
			<xsl:call-template name="subfield-245"/>
		</xsl:for-each>
		<xsl:text>}&#10;</xsl:text>
		<!-- <xsl:if test="not(ends-with(normalize-space(child::subfield[last()]/text()),'\.'))"><xsl:text>.</xsl:text></xsl:if>-->
	</xsl:template>

	<xsl:template match="marc:datafield[@tag=250]">
		<xsl:text>\ed{</xsl:text>
		<xsl:for-each select="marc:subfield">
			<xsl:call-template name="subfield-generic"/>
		</xsl:for-each>
		<xsl:text>}&#10;</xsl:text>
	</xsl:template>

	<xsl:template match="marc:datafield[@tag='260']">
		<xsl:text>\imprint{</xsl:text>
		<xsl:for-each select="marc:subfield">
			<xsl:call-template name="subfield-260"/>
		</xsl:for-each>
		<xsl:text>}&#10;</xsl:text>
	</xsl:template>

	<xsl:template match="marc:datafield[@tag='300']">
		<xsl:text>\physdesc{</xsl:text>
		<xsl:for-each select="marc:subfield">
			<xsl:call-template name="subfield-300"/>
		</xsl:for-each>
		<xsl:text>}&#10;</xsl:text>
	</xsl:template>

	<xsl:template match="marc:datafield[@tag=020]">
		<xsl:for-each select="marc:subfield[@code='a']">
			<!-- International Standard Book Number -->
			<xsl:text>\isbn{</xsl:text><xsl:if test="not(matches(substring(normalize-space(text()),11,1),'[0-9X]'))"><xsl:value-of select="substring(normalize-space(text()),1,10)"/></xsl:if><xsl:text>}&#10;</xsl:text>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
