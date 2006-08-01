<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:guide="http://www.datenspuren.de/#guide"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:template match="/schedule/conference">
  </xsl:template>

  <xsl:template match='/schedule/day/room'>
    <fo:block padding='10mm 2mm' font-size='14pt' font-family='serif' text-align='center'
              keep-together.within-column="always" keep-with-next.within-column="always">
      <fo:block padding='5mm 0mm'>
        <xsl:choose>
          <xsl:when test='../@index="1"'>Samstag, 13. Mai</xsl:when>
          <xsl:when test='../@index="2"'>Sonntag, 14. Mai</xsl:when>
        </xsl:choose>,
      </fo:block>
      <fo:block padding='5mm 0mm'>
        <xsl:value-of select='@name'/>
      </fo:block>
    </fo:block>

    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match='/schedule/day/room/event'>
    <fo:block font-size='14pt' padding='1mm 1mm'
              border-top-style='solid' border-bottom-style='solid'
              border-top-color='black' border-bottom-color='black'
              border-top-width='0.15mm' border-bottom-width='0.15mm'
              keep-together.within-column="always" keep-with-next.within-column="always"
              text-align='center'>
      <fo:block font-weight='bold' font-size='14pt' font-family='serif'>
        <xsl:value-of select='title'/>
      </fo:block>
      <fo:block font-size='12pt'>
        <xsl:value-of select='subtitle'/>
      </fo:block>
      <fo:block font-size='10pt'>
        <xsl:value-of select='start'/> Uhr
      </fo:block>
    </fo:block>

    <fo:block font-style='italic' padding='2mm 0mm 0mm'
              keep-together.within-column="always" keep-with-next.within-column="always">
      <xsl:for-each select='person'>
        <xsl:if test='position() &gt; 1'>, </xsl:if>
        <xsl:value-of select='.'/>
      </xsl:for-each>
    </fo:block>

    <xsl:if test='string-length(abstract) &gt; 1'>
      <fo:block font-size='10pt' font-weight='bold' padding='5mm 0mm 2mm 2mm'
                keep-together.within-column="always" keep-with-next.within-column="always">
        Abstract
      </fo:block>
      <fo:block font-family='serif' text-align='justify'>
        <xsl:value-of select='abstract'/>
      </fo:block>
    </xsl:if>
    <xsl:if test='string-length(description) &gt; 1'>
      <fo:block font-size='10pt' font-weight='bold' padding='5mm 0mm 2mm 2mm'
                keep-together.within-column="always" keep-with-next.within-column="always">
        Beschreibung
      </fo:block>
      <fo:block font-family='serif' text-align='justify'>
        <xsl:value-of select='description'/>
      </fo:block>
    </xsl:if>

    <fo:block padding='3mm 0mm'>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>
