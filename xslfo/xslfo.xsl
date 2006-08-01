<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:guide="http://www.datenspuren.de/#guide"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:include href='schedule.xsl'/>

  <xsl:template match="/guide:guide">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

      <fo:layout-master-set>

        <fo:simple-page-master master-name="TitlePage"
           page-width="210mm"   page-height="297mm"
           margin-top="20mm"  margin-bottom="20mm"
           margin-left="20mm" margin-right="20mm">
          <fo:region-body display-align="center"/>
        <!--fo:region-after
              extent="0.8in"
              display-align="before"/-->
        </fo:simple-page-master>

        <fo:simple-page-master master-name="A4"
           page-width="210mm"   page-height="297mm"
           margin-top="15mm"  margin-bottom="15mm"
           margin-left="15mm" margin-right="15mm">
          <fo:region-body margin-top="10mm" column-count="2" column-gap="10mm"/>
          <fo:region-before extent="10mm"/>
        </fo:simple-page-master>

      </fo:layout-master-set>

      <xsl:apply-templates/>

    </fo:root>
  </xsl:template>

  <xsl:template match='guide:title-page'>
    <fo:page-sequence master-reference="TitlePage">
      <fo:flow flow-name="xsl-region-body">
        <xsl:apply-templates/>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>

  <xsl:template match='guide:title-page/guide:title'>
    <fo:block font-size='48pt' font-weight='bold' text-align='center'>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match='guide:title-page/guide:space'>
    <fo:block>
      <xsl:attribute name='padding'><xsl:value-of select='@height'/> 0mm 0mm 0mm</xsl:attribute>
    </fo:block>
  </xsl:template>

  <xsl:template match='guide:title-page/guide:note'>
    <fo:block font-size='24pt' text-align='center'>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match='guide:title-page/guide:logo'>
    <fo:block text-align='center'>
      <fo:external-graphic content-width='180mm'>
        <xsl:attribute name='src'>
          url('<xsl:value-of select='.'/>')
        </xsl:attribute>
      </fo:external-graphic>
    </fo:block>
  </xsl:template>

  <xsl:template match='guide:page-sequence'>
    <fo:page-sequence master-reference="A4">

      <fo:static-content flow-name="xsl-region-before">
        <fo:list-block provisional-distance-between-starts="4.5in"
                       provisional-label-separation="0pt"
                       font-size="11pt" font-family="Times">
          <fo:list-item>
          <fo:list-item-label end-indent="label-end()">
            <fo:block text-align='start' font-family="serif" font-size="14pt" font-weight="bold" space-after="24pt">
              <xsl:value-of select='@head'/>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <fo:block text-align="end" 
                      font-family='serif'>
               <fo:page-number/>
            </fo:block>
          </fo:list-item-body>

          </fo:list-item>
        </fo:list-block>
      </fo:static-content>

      <fo:flow flow-name="xsl-region-body">
        <xsl:apply-templates/>
      </fo:flow>

    </fo:page-sequence>
  </xsl:template>

  <!-- TOC -->
  <xsl:template match='guide:table-of-contents'>
    <xsl:for-each select="/guide:guide//guide:section">

        <fo:list-block>
          <fo:list-item>
            <fo:list-item-label>
              <fo:block font-family="serif" text-align='left'>
                <xsl:value-of select="@title"/>
              </fo:block>
            </fo:list-item-label>
            <fo:list-item-body>
              <fo:block padding='0mm 0mm' font-family="serif" text-align='right'>
                <fo:page-number-citation ref-id="{generate-id()}"/>
              </fo:block>
            </fo:list-item-body>
          </fo:list-item>
        </fo:list-block>
        <!--fo:block text-align-last="justify">
          <xsl:value-of select="@title"/>
          <fo:leader leader-pattern="dots"/>
          <fo:page-number-citation ref-id="{generate-id()}"/>
        </fo:block-->
    </xsl:for-each>
  </xsl:template>

  <!-- For guide.xml -->
  
  <xsl:template match='guide:section'>
    <xsl:if test='@title'>
      <fo:block padding='5mm 5mm'>
        <fo:block font-size='18pt' font-weight='bold' font-family='serif' text-align='center'
                  border-top-style='solid' border-bottom-style='solid'
                  border-top-color='black' border-bottom-color='black'
                  border-top-width='0.3mm' border-bottom-width='0.3mm'
                  padding='3mm 5mm 2mm' margin='0mm -0.5mm'
                  keep-together.within-column="always" keep-with-next.within-column="always"
                  id="{generate-id()}">
          <xsl:value-of select='@title'/>
        </fo:block>
      </fo:block>
    </xsl:if>

    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match='guide:p'>
    <fo:block font-family='serif' text-align='justify' padding='2mm 0mm'>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- For schedule.xsl -->
  <xsl:template match='guide:pull-schedule'>
    <xsl:apply-templates select='document(concat($exportpath, "/schedule.de.xml"))'/>
  </xsl:template>
</xsl:stylesheet>

