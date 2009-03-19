<!--<?xml version="1.0" encoding="utf-8"?>-->
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
			<xsl:sort select="substring(marc:datafield[@tag='245']/marc:subfield[@code='a'],marc:datafield[@tag='245']/@ind2 + 1)" order="ascending"/>
			<xsl:copy-of select="."/>
		</xsl:for-each>

		<xsl:for-each select="//marc:datafield[@tag='246']">
			<see>
			<datafield tag="245" ind1="0" ind2="0">
			<xsl:for-each select="marc:subfield">
				<xsl:copy-of select="."/>
			</xsl:for-each>
			</datafield>
			</see>
		</xsl:for-each>
		</collection>
	</xsl:template>

</xsl:stylesheet>
