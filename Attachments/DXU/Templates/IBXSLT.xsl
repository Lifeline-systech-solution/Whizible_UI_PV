<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:msdata="urn:schemas-microsoft-com:xml-msdata" >
<xsl:output method="xml" indent="no"/>

<xsl:template match="/">
<Workbook  xmlns="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:o="urn:schemas-microsoft-com:office:office"
 xmlns:x="urn:schemas-microsoft-com:office:excel"
 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:html="http://www.w3.org/TR/REC-html40">
 <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
  <Author>CL</Author>
<!--  <LastAuthor>SwapnilR</LastAuthor> -->
  <Created>2006-08-30T10:19:50Z</Created>
  <LastSaved>2006-09-14T10:38:35Z</LastSaved>
  <Version>10.3501</Version>
 </DocumentProperties>
 <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">
  <DownloadComponents/>
  <LocationOfComponents HRef="file:///E:\"/>
 </OfficeDocumentSettings>
 <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
  <WindowHeight>9345</WindowHeight>
  <WindowWidth>15180</WindowWidth>
  <WindowTopX>120</WindowTopX>
  <WindowTopY>60</WindowTopY>
  <ProtectStructure>False</ProtectStructure>
  <ProtectWindows>False</ProtectWindows>
 </ExcelWorkbook>
 <Styles>
  <Style ss:ID="Default" ss:Name="Normal">
   <Alignment ss:Vertical="Bottom"/>
   <Borders/>
   <Font/>
   <Interior/>
  </Style>
  <Style ss:ID="s21">
   <Font/>
   <NumberFormat ss:Format="[$$-409]#,##0.00;[Red]\-[$$-409]#,##0.00"/>
  </Style>
  <Style ss:ID="s22">
   <Font/>
  </Style>
   <Style ss:ID="s23">
   <Font/>
   <NumberFormat ss:Format="[ENG][$-409]d\-mmm\-yy;@"/>
  </Style>
  <Style ss:ID="s24">
   <NumberFormat ss:Format="[ENG][$-409]d\-mmm\-yy;@"/>
  </Style>
  <Style ss:ID="s25">
   <Font/>
   <NumberFormat ss:Format="h:mm;@"/>
  </Style>
  <Style ss:ID="s26">
   <NumberFormat ss:Format="h:mm;@"/>
  </Style>
 </Styles>
 <Names>
 	<xsl:apply-templates mode="getcount"/>
 	<!--
	<NamedRange ss:Name="cboEmployee" ss:RefersTo="=Masters!R10C11:R10C60"/>
	<NamedRange ss:Name="cboTasktype" ss:RefersTo="=Masters!R11C11:R11C60"/>
	<NamedRange ss:Name="cboPriority" ss:RefersTo="=Masters!R12C11:R12C60"/>
	<NamedRange ss:Name="cboPhase" ss:RefersTo="=Masters!R13C11:R13C60"/>
	<NamedRange ss:Name="cboModule" ss:RefersTo="=Masters!R14C11:R14C60"/>
	<NamedRange ss:Name="cboSubProject" ss:RefersTo="=Masters!R15C11:R15C60"/>
	<NamedRange ss:Name="cboMilestone" ss:RefersTo="=Masters!R16C11:R16C60"/>
	-->
 </Names>
 <Worksheet ss:Name="Sheet1">
  <Table x:FullColumns="1" x:FullRows="1">
  <Column ss:Width="123" /> 
  <Column ss:Width="284" /> 
  <Column ss:Width="96" /> 
  <Column ss:StyleID="s24" ss:Width="96" /> 
  <Column ss:StyleID="s26" ss:Width="96" /> 
  <Column ss:Width="80" /> 
  <Column ss:Width="70" /> 
  <Column ss:Width="70" /> 
  <Column ss:Width="136" /> 
  <Column ss:Width="96" /> 
  <Column ss:Width="96" /> 
  <Column ss:StyleID="s24" ss:Width="96" /> 
  <Column ss:StyleID="s26" ss:Width="96" /> 
  <Column ss:Index="52" ss:Width="91.5" /> 
  <Column ss:Width="60" /> 
  <Column ss:Index="55" ss:Width="69" /> 
  <Column ss:Width="69" /> 
  <Column ss:Width="69" /> 
  <Column ss:Width="66.75" /> 
  <Column ss:Width="69" /> 
  <Column ss:Width="90.75" /> 
   <Row>
   <Cell ss:StyleID="s21"><Data ss:Type="String">Summary</Data><Comment
      ss:Author="compulink"><ss:Data xmlns="http://www.w3.org/TR/REC-html40"><B><Font
         html:Face="Tahoma" html:Size="8" html:Color="#000000">Summary is mandatory</Font></B><Font
        html:Face="Tahoma" html:Size="8" html:Color="#000000">&#10;</Font></ss:Data></Comment></Cell>
    <Cell ss:StyleID="s21"><Data ss:Type="String">Description</Data><Comment
      ss:Author="compulink"><ss:Data xmlns="http://www.w3.org/TR/REC-html40"><B><Font
         html:Face="Tahoma" html:Size="8" html:Color="#000000">Description is mandatory&#10;</Font></B></ss:Data></Comment></Cell>
    <Cell ss:StyleID="s21"><Data ss:Type="String">ReportedBy</Data><Comment
      ss:Author="compulink"><ss:Data xmlns="http://www.w3.org/TR/REC-html40"><B><Font
         html:Face="Tahoma" html:Size="8" html:Color="#000000">ReportedBy is mandatory&#10;</Font></B><Font
        html:Face="Tahoma" html:Size="8" html:Color="#000000">&#10;</Font></ss:Data></Comment></Cell>
    <Cell ss:StyleID="s23"><Data ss:Type="Date">ReportedDate</Data><Comment
      ss:Author="CL"><ss:Data xmlns="http://www.w3.org/TR/REC-html40"><B><Font
         html:Face="Tahoma" html:Size="8" html:Color="#000000">ReportedDate is mandatory&#10;Date format is                     dd-mmm-yy</Font></B></ss:Data></Comment></Cell>
    <Cell ss:StyleID="s25"><Data ss:Type="String">ReportedTime</Data><Comment
      ss:Author="CL"><ss:Data xmlns="http://www.w3.org/TR/REC-html40"><B><Font
         html:Face="Tahoma" html:Size="8" html:Color="#000000">ReportedTime  is mandatory.</Font></B><Font
        html:Face="Tahoma" html:Size="8" html:Color="#000000"> </Font><B><Font
         html:Face="Tahoma" x:Family="Swiss" html:Size="8" html:Color="#000000">Time format is HH:MM (24 hour format)</Font></B></ss:Data></Comment></Cell>
    <Cell ss:StyleID="s22"><Data ss:Type="String">Type</Data><Comment
      ss:Author="compulink"><ss:Data xmlns="http://www.w3.org/TR/REC-html40"><B><Font
         html:Face="Tahoma" html:Size="8" html:Color="#000000">Type is mandatory</Font></B></ss:Data></Comment></Cell>
    <Cell ss:StyleID="s22"><Data ss:Type="String">Status</Data><Comment
      ss:Author="compulink"><ss:Data xmlns="http://www.w3.org/TR/REC-html40"><B><Font
         html:Face="Tahoma" html:Size="8" html:Color="#000000">Status  is mandatory.</Font></B><Font
        html:Face="Tahoma" html:Size="8" html:Color="#000000">&#10;</Font></ss:Data></Comment></Cell>
    <Cell ss:StyleID="s22"><Data ss:Type="String">SubType</Data><Comment
      ss:Author="compulink"><ss:Data xmlns="http://www.w3.org/TR/REC-html40"><B><Font
         html:Face="Tahoma" html:Size="8" html:Color="#000000">SubType  is mandatory.</Font></B><Font
        html:Face="Tahoma" html:Size="8" html:Color="#000000">&#10;</Font></ss:Data></Comment></Cell>
    <Cell ss:StyleID="s22"><Data ss:Type="String">ResponsiblePerson</Data></Cell>
    <Cell ss:StyleID="s22"><Data ss:Type="String">Priority</Data></Cell>
    <Cell ss:StyleID="s22"><Data ss:Type="String">Severity</Data></Cell>
    <Cell ss:StyleID="s23"><Data ss:Type="String">StatusChangeDate</Data><Comment
      ss:Author="CL"><ss:Data xmlns="http://www.w3.org/TR/REC-html40"><B><Font
         html:Face="Tahoma" x:Family="Swiss" html:Size="8" html:Color="#000000">StatusChangeDate is  mandatory when SLA is applicable. &#10;Date format is                             dd-mmm-yy</Font></B></ss:Data></Comment></Cell>
    <Cell ss:StyleID="s25"><Data ss:Type="String">StatusChangeTime</Data><Comment
      ss:Author="CL"><ss:Data xmlns="http://www.w3.org/TR/REC-html40"><B><Font
         html:Face="Tahoma" x:Family="Swiss" html:Size="8" html:Color="#000000">Time format is HH:MM (24 hour format)</Font></B></ss:Data></Comment></Cell>   </Row>
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <Selected/>
   <Panes>
    <Pane>
     <Number>3</Number>
     <ActiveRow>1</ActiveRow>
     <ActiveCol>11</ActiveCol>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
  <DataValidation xmlns="urn:schemas-microsoft-com:office:excel">
   <Range>R2C3:R1000C3</Range>
   <Type>List</Type>
   <Value>cboReportedBy</Value>
  </DataValidation>
  <DataValidation xmlns="urn:schemas-microsoft-com:office:excel">
   <Range>R2C6:R1000C6</Range>
   <Type>List</Type>
   <Value>cboType</Value>
  </DataValidation>
  <DataValidation xmlns="urn:schemas-microsoft-com:office:excel">
   <Range>R2C9:R1000C9</Range>
   <Type>List</Type>
   <Value>cboResponsiblePerson</Value>
  </DataValidation>
  <DataValidation xmlns="urn:schemas-microsoft-com:office:excel">
   <Range>R2C10:R1000C10</Range>
   <Type>List</Type>
   <Value>cboPriority</Value>
  </DataValidation>
  <DataValidation xmlns="urn:schemas-microsoft-com:office:excel">
   <Range>R2C11:R1000C11</Range>
   <Type>List</Type>
   <Value>cboSeverity</Value>
  </DataValidation>
 </Worksheet>
 <Worksheet ss:Name="Masters">
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <Visible>SheetHidden</Visible>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
  <Table x:FullColumns="1" x:FullRows="1">
	<xsl:apply-templates />
  </Table>
 </Worksheet>
</Workbook>
</xsl:template>

<xsl:template match="NewDataSet" mode="getcount" xmlns="urn:schemas-microsoft-com:office:spreadsheet">
	<xsl:element name="NamedRange">
		<xsl:attribute name="ss:Name">cboReportedBy</xsl:attribute>
		<xsl:attribute name="ss:RefersTo">
			<xsl:text>=Masters!R11C10:R</xsl:text>
			<xsl:choose>
				<xsl:when test="count(PM_Masters/UserName) > 0">
					<xsl:value-of select="11+count(PM_Masters/UserName)-1" />
				</xsl:when>
				<xsl:otherwise>11</xsl:otherwise>
			</xsl:choose>
			<xsl:text>C10</xsl:text>
		</xsl:attribute>
	</xsl:element>
	<xsl:element name="NamedRange">
		<xsl:attribute name="ss:Name">cboType</xsl:attribute>
		<xsl:attribute name="ss:RefersTo">
			<xsl:text>=Masters!R211C10:R</xsl:text>
			<xsl:choose>
				<xsl:when test="count(PM_Masters1/FieldName) > 0">
					<xsl:value-of select="211+count(PM_Masters1/FieldName)-1" />
				</xsl:when>
				<xsl:otherwise>211</xsl:otherwise>
			</xsl:choose>
			<xsl:text>C10</xsl:text>
		</xsl:attribute>
	</xsl:element>
	<xsl:element name="NamedRange">
		<xsl:attribute name="ss:Name">cboResponsiblePerson</xsl:attribute>
		<xsl:attribute name="ss:RefersTo">
			<xsl:text>=Masters!R411C10:R</xsl:text>
			<xsl:choose>
				<xsl:when test="count(PM_Masters2/UserName) > 0">
					<xsl:value-of select="411+count(PM_Masters2/UserName)-1" />
				</xsl:when>
				<xsl:otherwise>411</xsl:otherwise>
			</xsl:choose>
			<xsl:text>C10</xsl:text>
		</xsl:attribute>
	</xsl:element>
	<xsl:element name="NamedRange">
		<xsl:attribute name="ss:Name">cboPriority</xsl:attribute>
		<xsl:attribute name="ss:RefersTo">
			<xsl:text>=Masters!R611C10:R</xsl:text>
			<xsl:choose>
				<xsl:when test="count(PM_Masters3/FieldName) > 0">
					<xsl:value-of select="611+count(PM_Masters3/FieldName)-1" />
				</xsl:when>
				<xsl:otherwise>611</xsl:otherwise>
			</xsl:choose>
			<xsl:text>C10</xsl:text>
		</xsl:attribute>
	</xsl:element>
	<xsl:element name="NamedRange">
		<xsl:attribute name="ss:Name">cboSeverity</xsl:attribute>
		<xsl:attribute name="ss:RefersTo">
			<xsl:text>=Masters!R811C10:R</xsl:text>
			<xsl:choose>
				<xsl:when test="count(PM_Masters4/FieldName) > 0">
					<xsl:value-of select="811+count(PM_Masters4/FieldName)-1" />
				</xsl:when>
				<xsl:otherwise>811</xsl:otherwise>
			</xsl:choose>
			<xsl:text>C10</xsl:text>
		</xsl:attribute>
	</xsl:element>
</xsl:template>

<xsl:template match="NewDataSet" xmlns="urn:schemas-microsoft-com:office:spreadsheet">
<Row ss:Index="10">
    <Cell ss:Index="10"><Data ss:Type="String">cboReportedBy</Data></Cell>
</Row>
    <xsl:for-each select="PM_Masters/UserName">
		<xsl:element name="Row">
			<xsl:attribute name="ss:Index"><xsl:value-of select="10+position()"/></xsl:attribute>
			<Cell ss:Index="10"><Data ss:Type="String"><xsl:value-of select="."/></Data><NamedCell ss:Name="cboReportedBy"/></Cell>
		</xsl:element>
	</xsl:for-each>
<Row ss:Index="210">
    <Cell ss:Index="10"><Data ss:Type="String">cboType</Data></Cell>
</Row>
    <xsl:for-each select="PM_Masters1/FieldName">
		<xsl:element name="Row">
			<xsl:attribute name="ss:Index"><xsl:value-of select="210+position()"/></xsl:attribute>
			<Cell ss:Index="10"><Data ss:Type="String"><xsl:value-of select="."/></Data><NamedCell ss:Name="cboType"/></Cell>
		</xsl:element>
	</xsl:for-each>
<Row ss:Index="410">
    <Cell ss:Index="10"><Data ss:Type="String">cboResponsiblePerson</Data></Cell>
</Row>
    <xsl:for-each select="PM_Masters2/UserName">
		<xsl:element name="Row">
			<xsl:attribute name="ss:Index"><xsl:value-of select="410+position()"/></xsl:attribute>
			<Cell ss:Index="10"><Data ss:Type="String"><xsl:value-of select="."/></Data><NamedCell ss:Name="cboResponsiblePerson"/></Cell>
		</xsl:element>
	</xsl:for-each>
<Row ss:Index="610">
    <Cell ss:Index="10"><Data ss:Type="String">cboPriority</Data></Cell>
</Row>
    <xsl:for-each select="PM_Masters3/FieldName">
		<xsl:element name="Row">
			<xsl:attribute name="ss:Index"><xsl:value-of select="610+position()"/></xsl:attribute>
			<Cell ss:Index="10"><Data ss:Type="String"><xsl:value-of select="."/></Data><NamedCell ss:Name="cboPriority"/></Cell>
		</xsl:element>
	</xsl:for-each>
<Row ss:Index="810">
    <Cell ss:Index="10"><Data ss:Type="String">cboSeverity</Data></Cell>
</Row>
    <xsl:for-each select="PM_Masters4/FieldName">
		<xsl:element name="Row">
			<xsl:attribute name="ss:Index"><xsl:value-of select="810+position()"/></xsl:attribute>
			<Cell ss:Index="10"><Data ss:Type="String"><xsl:value-of select="."/></Data><NamedCell ss:Name="cboSeverity"/></Cell>
		</xsl:element>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>