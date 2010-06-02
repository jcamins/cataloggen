<!--<?xml version="1.0" encoding="utf-8"?>-->
<!-- Copyright (c) 2010 Jared Camins-Esakov
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
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
<xsl:strip-space elements="*"/>

	<xsl:template match="marc:collection">
<collection
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd"
  xmlns="http://www.loc.gov/MARC21/slim">
<!--		<collection
			<xsl:attribute namespace="xmlns" name="xsi">http://www.w3.org/2001/XMLSchema-instance"</xsl:attribute>
			<xsl:attribute namespace="xsi" name="schemaLocation">http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd</xsl:attribute>
			<xsl:attribute name="xmlns">http://www.loc.gov/MARC21/slim</xsl:attribute>-->
		<xsl:for-each select="marc:record">
			<xsl:sort select="lower-case(substring(marc:datafield[@tag='245']/marc:subfield[@code='a'],marc:datafield[@tag='245']/@ind2 + 1))" order="ascending"/>
			<xsl:variable name="pos" select="position()"/>
			<record>
				<ref><xsl:value-of select="$pos"/></ref>
				<xsl:copy-of select="./*"/>
			</record>

			<xsl:for-each select="marc:datafield[@tag='246']">
				<xsl:variable name="subfield246a" select="marc:subfield[@code='a']/text()"/>
				<xsl:if test="count(preceding-sibling::marc:datafield[@tag='246']/marc:subfield[@code='a' and text()=$subfield246a])=0 and not(contains($subfield246a,'&amp;')) and not(contains($subfield246a,'%26'))">
					<see>
					<datafield tag="245" ind1="0">
					<xsl:choose>
					<xsl:when test="matches(marc:subfield[@code='a'],'^A ')">
						<xsl:attribute name="ind2">2</xsl:attribute>
					</xsl:when>
					<xsl:when test="matches(marc:subfield[@code='a'],'^The ')">
						<xsl:attribute name="ind2">4</xsl:attribute>
					</xsl:when>
					<xsl:otherwise><xsl:attribute name="ind2">0</xsl:attribute></xsl:otherwise>
					</xsl:choose>
					<xsl:for-each select="marc:subfield">
						<xsl:copy-of select="."/>
					</xsl:for-each>
					</datafield>
					<title><xsl:copy-of select="preceding-sibling::marc:datafield[@tag='245']/*"/></title>
					<ref><xsl:value-of select="$pos"/></ref>
					</see>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>

		<xsl:for-each select="//marc:datafield[@tag='246']">
		</xsl:for-each>
		</collection>
	</xsl:template>

</xsl:stylesheet>
