<?xml version="1.0" encoding="utf-8"?>
<xsl:transform version="1.1" xmlns="http://pentabarf.org/fahrplan/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--

fahrplan2ical.xsl

Pentabarf Fahrplan to iCalender converter

(C) Tim Pritlove 2004

-->

  <xsl:strip-space elements="*"/>
  <xsl:output method="text" encoding="utf-8" />
  
  <xsl:variable name="events" select="/fahrplan/events"/>
  <xsl:variable name="persons" select="/fahrplan/persons" />
  <xsl:variable name="days" select="/fahrplan/days" />
  <xsl:variable name="rooms" select="/fahrplan/rooms" />
  
  <xsl:variable name="languages" select="/fahrplan/languages"/>
  
  <xsl:variable name="fahrplan-release" select="/fahrplan/release" />

  <xsl:variable name="conference-acronym" select="/fahrplan/conference/acronym" />
  <xsl:variable name="conference-title" select="/fahrplan/conference/title" />
  <xsl:variable name="conference-timezone" select="/fahrplan/conference/timezone" />
  <xsl:variable name="conference-url" select="/fahrplan/conference/url" />

  <xsl:template match="/">
    <xsl:apply-templates select="fahrplan/events" />
  </xsl:template>

  <xsl:template match="events">
    <xsl:text>BEGIN:VCALENDAR</xsl:text>
    <xsl:text>&#13;&#10;</xsl:text>
  
    <xsl:text>VERSION:2.0</xsl:text>
    <xsl:text>&#13;&#10;</xsl:text>
  
    <xsl:text>PRODID:-//Chaos Computer Club//</xsl:text>
    <xsl:value-of select="$conference-acronym" />
    <xsl:text> Calendar </xsl:text>
    <xsl:value-of select="$fahrplan-release" />
    <xsl:text>//EN</xsl:text>
    <xsl:text>&#13;&#10;</xsl:text>
  
    <xsl:text>CALSCALE:GREGORIAN</xsl:text>
    <xsl:text>&#13;&#10;</xsl:text>
  
    <xsl:text>METHOD:PUBLISH</xsl:text>
    <xsl:text>&#13;&#10;</xsl:text>
  
    <!-- iCal specific ? -->
    <xsl:text>X-WR-CALDESC;VALUE=TEXT:This calendar contains all lectures and workshops of the</xsl:text>
    <xsl:value-of select="$conference-title" />
    <xsl:text>.</xsl:text>
    <xsl:text>&#13;&#10;</xsl:text>
  
    <xsl:text>X-WR-CALNAME;VALUE=TEXT:</xsl:text>
    <xsl:value-of select="$conference-acronym"/>
    <xsl:text> Fahrplan v</xsl:text>
    <xsl:value-of select="$fahrplan-release"/>
    <xsl:text>&#13;&#10;</xsl:text>
  
    <xsl:text>X-WR-TIMEZONE;VALUE=TEXT:</xsl:text>
    <xsl:value-of select="$conference-timezone"/>
    <xsl:text>&#13;&#10;</xsl:text>
  
    <xsl:text>&#13;&#10;</xsl:text>
  
    <xsl:apply-templates select="event" >
      <xsl:sort select="@room-number" />
    </xsl:apply-templates>
  
    <xsl:text>&#13;&#10;</xsl:text>
    <xsl:text>END:VCALENDAR</xsl:text>
    <xsl:text>&#13;&#10;</xsl:text>
  
  </xsl:template>

  <xsl:template match="event">
    <xsl:variable name="event-id" select="id"/>

    <xsl:variable name="day" select="@day"/>
    <xsl:variable name="month" select="@month"/>
    <xsl:variable name="year" select="@year"/>
  
    <xsl:variable name="time" select="@time"/>
    <xsl:variable name="duration" select="@duration"/>
    <xsl:variable name="hours" select="@hours"/>
    <xsl:variable name="minutes" select="@minutes"/>

    <xsl:variable name="room-id" select="///schedule/day/room[slot/@event-id = $event-id]/@room-id" />
    <xsl:variable name="room" select="$rooms/room[id = $room-id]/name" />

    <xsl:text>BEGIN:VEVENT</xsl:text>
    <xsl:text>&#13;&#10;</xsl:text>
  
    <xsl:text>METHOD:PUBLISH</xsl:text>
    <xsl:text>&#13;&#10;</xsl:text>
  
    <xsl:text>UID:</xsl:text>
    <xsl:value-of select="id" />
    <xsl:text>@pentabarf.org</xsl:text>
    <xsl:text>&#13;&#10;</xsl:text>
  
    <!-- retrieve start date -->
    <xsl:text>DTSTART:</xsl:text>
    <xsl:value-of select="$year" /><xsl:value-of select="$month" /><xsl:value-of select="$day" />
    <xsl:text>T</xsl:text>
    <!-- SHOULD BE CORRECTED TO ZULU TIME -->
    <xsl:value-of select="$time" />
    <xsl:text>00&#13;&#10;</xsl:text>
  
    <!-- specify duration -->
  
    <xsl:text>DURATION:PT</xsl:text>
    <xsl:value-of select="$hours" />
    <xsl:text>H</xsl:text>
    <xsl:value-of select="$minutes" />
    <xsl:text>M</xsl:text>
    <xsl:text>&#13;&#10;</xsl:text>

    <xsl:call-template name="wrap-text">
      <xsl:with-param name="text">
        <xsl:text>SUMMARY:</xsl:text>
        <xsl:value-of select="title" />
      
        <xsl:text> --- </xsl:text>
        <xsl:for-each select="person">
          <xsl:if test="position() != 1">
            <xsl:text>, </xsl:text>
          </xsl:if>
      
          <xsl:variable name="person-id" select="@person-id"/>
          <xsl:for-each select="$persons/person[id = $person-id]">
            <xsl:value-of select="public-name"/>
          </xsl:for-each>
        </xsl:for-each>
      
        <xsl:text> (</xsl:text>
        <xsl:value-of select="$room" />
        <xsl:text>)</xsl:text>
      
        <xsl:text> [</xsl:text>
        <xsl:value-of select="$event-id" />
        <xsl:text>]</xsl:text>
      </xsl:with-param>
      <xsl:with-param name="length" select="70" />
    </xsl:call-template>
    <xsl:text>&#13;&#10;</xsl:text>
  
    <xsl:call-template name="wrap-text">
      <xsl:with-param name="text">
        <xsl:text>DESCRIPTION:</xsl:text>
        <xsl:call-template name="replace-newline">
          <xsl:with-param name="text" select="description" />
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="length" select="70" />
    </xsl:call-template>
    <xsl:text>&#13;&#10;</xsl:text>
  
    <xsl:text>CATEGORY:Lecture</xsl:text>
    <xsl:text>&#13;&#10;</xsl:text>
  
    <xsl:text>CLASS:PUBLIC</xsl:text>
    <xsl:text>&#13;&#10;</xsl:text>
  
    <xsl:text>STATUS:CONFIRMED</xsl:text>
    <xsl:text>&#13;&#10;</xsl:text>
  
    <xsl:text>GEO:50.00000\;15.00000</xsl:text>
    <xsl:text>&#13;&#10;</xsl:text>
  
    <xsl:text>URL:</xsl:text>
    <xsl:value-of select="$conference-url" />
    <xsl:text>fahrplan/event/</xsl:text>
    <xsl:value-of select="event-id" />
    <xsl:text>&#13;&#10;</xsl:text>
  
    <xsl:text>LOCATION:</xsl:text>
    <xsl:value-of select="$room" />
    <xsl:text>&#13;&#10;</xsl:text>
  
    <xsl:text>END:VEVENT</xsl:text>
    <xsl:text>&#13;&#10;</xsl:text>
    <xsl:text>&#13;&#10;</xsl:text>
  
  </xsl:template>
  
  
  <xsl:template name="wrap-text">
    <xsl:param name="text" />
    <xsl:param name="length" />
  
    <xsl:choose>
      <xsl:when test="string-length($text) > $length">
        <xsl:value-of select="substring($text, 0, $length)" />
        <xsl:text>&#13;&#10; </xsl:text>
        <xsl:call-template name="wrap-text">
          <xsl:with-param name="text" select="substring($text, $length)" />
          <xsl:with-param name="length" select="$length" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  
  <xsl:template name="replace-newline">
    <xsl:param name="text" />
  
    <xsl:variable name="newline"><xsl:text>
  </xsl:text></xsl:variable>
  
    <xsl:choose>
      <xsl:when test="contains($text, $newline)">
        <xsl:value-of select="substring-before($text, $newline)" />
        <xsl:value-of select="' '" />
        <xsl:call-template name="replace-newline">
          <xsl:with-param name="text" select="substring-after($text, $newline)" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



</xsl:transform>




