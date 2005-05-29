<?xml version="1.0" encoding="utf-8"?>
<xsl:transform version="1.1"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="xhtml" >

  <xsl:strip-space elements="*"/>

  <xsl:output mode="xml" />

  <xsl:template match="/">
    <events>
      <xsl:apply-templates select="//events/event" />
    </events>
  </xsl:template>

  <xsl:template match="event">
    <event>
      <day><xsl:value-of select="@day" /></day>
      <month><xsl:value-of select="@month" /></month>
      <year><xsl:value-of select="@year" /></year>
      <time><xsl:value-of select="@time" /></time>
      <room>
        <xsl:variable name="event-id" select="id" />
        <xsl:variable name="room" select="///schedule/day/room[slot/@event-id = $event-id]" />
        <xsl:variable name="room-id" select="$room/@room-id" />
        <xsl:value-of select="///rooms/room[id = $room-id]/name" />
      </room>
      <id><xsl:value-of select="id" /></id>
      <title><xsl:value-of select="title" /></title>
      <subtitle><xsl:value-of select="subtitle" /></subtitle>
      <track><xsl:value-of select="track" /></track>
      <type><xsl:value-of select="event-type" /></type>
      <state><xsl:value-of select="event-state" /></state>
      <duration><xsl:value-of select="@duration" /></duration>
      <slots><xsl:value-of select="@slots" /></slots>
      <language><xsl:value-of select="language" /></language>
      <abstract><xsl:value-of select="abstract" /></abstract>
      <description>
        <xsl:apply-templates select="description/xhtml:body/xhtml:br|description/xhtml:body/text()" mode="description" />
      </description>
      <person>
        <xsl:for-each select="person">
          <xsl:text></xsl:text>
          <xsl:variable name="person-id" select="@person-id" />
          <xsl:for-each select="//persons/person[id = $person-id]">
            <xsl:value-of select="public-name" />
          </xsl:for-each>
          <xsl:text> (</xsl:text>
          <xsl:value-of select="@role" />
          <xsl:text>)&#x0a;</xsl:text>
        </xsl:for-each>
      </person>
    </event>
  </xsl:template>

  <xsl:template match="text()" mode="description">
     <xsl:value-of select="." />
  </xsl:template>

  <xsl:template match="xhtml:br" mode="description">
     <xsl:text>&#x0a;</xsl:text>
  </xsl:template>

</xsl:transform>	
