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
<xsl:output method="html"/>
<xsl:strip-space elements="*"/>

<xsl:template match="/">
	<xsl:for-each select="//marc:datafield[@tag=100 or @tag=600 or @tag=700]">
<!--		<xsl:apply-templates/>
		<xsl:text>%%</xsl:text>-->
		<xsl:value-of select="marc:subfield[@code='a']"/><xsl:text> </xsl:text>
		<xsl:value-of select="marc:subfield[@code='b']"/><xsl:text> </xsl:text>
		<xsl:value-of select="marc:subfield[@code='q']"/><xsl:text>
</xsl:text>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
