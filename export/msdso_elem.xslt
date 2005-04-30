<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<!--
File: msdso_elem.xslt

Transforms data in an ELEMENT based MSDSO grammar 
into the FMPXMLRESULT grammar, suitable for import.
      
===============================================================

Copyright © 2002 FileMaker, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or
without modification, are permitted provided that the following
conditions are met:

* Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in 
  the documentation and/or other materials provided with the
  distribution.

* Neither the name of the FileMaker, Inc. nor the names of its 
  contributors may be used to endorse or promote products derived
  from this software without specific prior written
  permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR 
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
    
===============================================================
-->
       
	<xsl:template match="/*">
		<FMPXMLRESULT xmlns="http://www.filemaker.com/fmpxmlresult">
			<ERRORCODE>0</ERRORCODE>
			<PRODUCT BUILD="" NAME="" VERSION=""/>
			<DATABASE DATEFORMAT="M/d/yyyy" LAYOUT="" NAME="" RECORDS="{count(/*/*)}" TIMEFORMAT="h:mm:ss a"/>
			<METADATA>
				<xsl:for-each select="/*/*[position()=1]/*">
					<FIELD>
						<xsl:attribute name="EMPTYOK">YES</xsl:attribute>
						<xsl:attribute name="MAXREPEAT">1</xsl:attribute>
						<xsl:attribute name="NAME"><xsl:value-of select="name()"/></xsl:attribute>
						<xsl:attribute name="TYPE">TEXT</xsl:attribute>
					</FIELD>
				</xsl:for-each>
			</METADATA>
			<RESULTSET>
				<xsl:attribute name="FOUND"><xsl:value-of select="count(child::*)"/></xsl:attribute>
				<xsl:for-each select="child::*">
					<ROW>
						<xsl:attribute name="MODID">0</xsl:attribute>
						<xsl:attribute name="RECORDID">0</xsl:attribute>
						<xsl:for-each select="child::*">
							<COL>
								<DATA>
									<xsl:value-of select="."/>
								</DATA>
							</COL>
						</xsl:for-each>
					</ROW>
				</xsl:for-each>
			</RESULTSET>
		</FMPXMLRESULT>
	</xsl:template>
</xsl:stylesheet>
