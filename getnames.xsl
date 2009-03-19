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
