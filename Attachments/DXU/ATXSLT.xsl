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
  <LastAuthor>CL</LastAuthor> 
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
  <Column ss:Width="117" /> 
  <Column ss:Width="75" /> 
  <Column ss:StyleID="s24" ss:Width="75" /> 
  <Column ss:StyleID="s24" ss:Width="75" /> 
  <Column ss:Width="75" /> 
  <Column ss:Width="40" /> 
  <Column ss:Width="115" /> 
  <Column ss:Width="65" /> 
  <Column ss:Width="93" /> 
  <Column ss:Width="85" /> 
  <Column ss:Index="52" ss:Width="91.5" /> 
  <Column ss:Width="90" /> 
  <Column ss:Index="55" ss:Width="51.75" /> 
  <Column ss:Width="60" /> 
  <Column ss:Width="69" /> 
  <Column ss:Width="66.75" /> 
  <Column ss:Width="69" /> 
  <Column ss:Width="90.75" /> 
   <Row>
    <Cell ss:StyleID="s21"><Data ss:Type="String">TaskName</Data><Comment ss:Author="CL"><ss:Data
       xmlns="http://www.w3.org/TR/REC-html40"><B><Font html:Face="Tahoma"
         html:Size="8" html:Color="#000000">CL:</Font></B><Font
        html:Face="Tahoma" html:Size="8" html:Color="#000000">&#10;TaskName is mandatory</Font></ss:Data></Comment></Cell>
    <Cell ss:StyleID="s22"><Data ss:Type="String">EmployeeName</Data><Comment ss:Author="CL"><ss:Data
       xmlns="http://www.w3.org/TR/REC-html40"><B><Font html:Face="Tahoma"
         html:Size="8" html:Color="#000000">CL:</Font></B><Font
        html:Face="Tahoma" html:Size="8" html:Color="#000000">&#10;EmployeeName is mandatory.</Font></ss:Data></Comment></Cell>
    <Cell ss:StyleID="s23"><Data ss:Type="String">StartDate</Data><Comment ss:Author="CL"><ss:Data
       xmlns="http://www.w3.org/TR/REC-html40"><B><Font html:Face="Tahoma"
         html:Size="8" html:Color="#000000">CL:</Font></B><Font
        html:Face="Tahoma" html:Size="8" html:Color="#000000">&#10;StartDate is mandatory. Date format is dd-mmm-yy</Font></ss:Data></Comment></Cell>
    <Cell ss:StyleID="s23"><Data ss:Type="String">EndDate</Data><Comment ss:Author="CL"><ss:Data
       xmlns="http://www.w3.org/TR/REC-html40"><B><Font html:Face="Tahoma"
         html:Size="8" html:Color="#000000">CL:</Font></B><Font
        html:Face="Tahoma" html:Size="8" html:Color="#000000">&#10;EndDate is mandatory. Date format is dd-mmm-yy</Font></ss:Data></Comment></Cell>
    <Cell ss:StyleID="s22"><Data ss:Type="String">Work</Data><Comment ss:Author="CL"><ss:Data
       xmlns="http://www.w3.org/TR/REC-html40"><B><Font html:Face="Tahoma"
         html:Size="8" html:Color="#000000">CL:</Font></B><Font
        html:Face="Tahoma" html:Size="8" html:Color="#000000">&#10;Work is mandatory</Font></ss:Data></Comment></Cell>
    <Cell ss:StyleID="s22"><Data ss:Type="String">TaskType</Data><Comment ss:Author="CL"><ss:Data
       xmlns="http://www.w3.org/TR/REC-html40"><B><Font html:Face="Tahoma"
         html:Size="8" html:Color="#000000">CL:</Font></B><Font
        html:Face="Tahoma" html:Size="8" html:Color="#000000">&#10;TaskType is mandatory</Font></ss:Data></Comment></Cell>
    <Cell ss:StyleID="s22"><Data ss:Type="String">Priority</Data></Cell>
    <Cell ss:StyleID="s22"><Data ss:Type="String">Phase</Data></Cell>
    <Cell ss:StyleID="s22"><Data ss:Type="String">Module</Data></Cell>
    <Cell ss:StyleID="s22"><Data ss:Type="String">SubProject</Data></Cell>
    <Cell ss:StyleID="s22"><Data ss:Type="String">Deliverable</Data></Cell>
    <Cell ss:StyleID="s22"><Data ss:Type="String">Milestone</Data></Cell>
    <Cell ss:StyleID="s22"><Data ss:Type="String">ChangeRequest</Data></Cell>
   </Row>
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
   <Range>R2C2:R1000C2</Range>
   <Type>List</Type>
   <Value>cboEmployee</Value>
  </DataValidation>
  <DataValidation xmlns="urn:schemas-microsoft-com:office:excel">
   <Range>R2C6:R1000C6</Range>
   <Type>List</Type>
   <Value>cboTasktype</Value>
  </DataValidation>
  <DataValidation xmlns="urn:schemas-microsoft-com:office:excel">
   <Range>R2C7:R1000C7</Range>
   <Type>List</Type>
   <Value>cboPriority</Value>
  </DataValidation>
  <DataValidation xmlns="urn:schemas-microsoft-com:office:excel">
   <Range>R2C8:R1000C8</Range>
   <Type>List</Type>
   <Value>cboPhase</Value>
  </DataValidation>
  <DataValidation xmlns="urn:schemas-microsoft-com:office:excel">
   <Range>R2C9:R1000C9</Range>
   <Type>List</Type>
   <Value>cboModule</Value>
  </DataValidation>
  <DataValidation xmlns="urn:schemas-microsoft-com:office:excel">
   <Range>R2C10:R1000C10</Range>
   <Type>List</Type>
   <Value>cboSubProject</Value>
  </DataValidation>
  <DataValidation xmlns="urn:schemas-microsoft-com:office:excel">
   <Range>R2C12:R1000C12</Range>
   <Type>List</Type>
   <Value>cboMilestone</Value>
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
		<xsl:attribute name="ss:Name">cboEmployee</xsl:attribute>
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
		<xsl:attribute name="ss:Name">cboTasktype</xsl:attribute>
		<xsl:attribute name="ss:RefersTo">
			<xsl:text>=Masters!R211C10:R</xsl:text>
			<xsl:choose>
				<xsl:when test="count(PM_Masters1/TaskType) > 0">
					<xsl:value-of select="211+count(PM_Masters1/TaskType)-1" />
				</xsl:when>
				<xsl:otherwise>211</xsl:otherwise>
			</xsl:choose>
			<xsl:text>C10</xsl:text>
		</xsl:attribute>
	</xsl:element>
	<xsl:element name="NamedRange">
		<xsl:attribute name="ss:Name">cboPriority</xsl:attribute>
		<xsl:attribute name="ss:RefersTo">
			<xsl:text>=Masters!R411C10:R</xsl:text>
			<xsl:choose>
				<xsl:when test="count(PM_Masters2/Priority) > 0">
					<xsl:value-of select="411+count(PM_Masters2/Priority)-1" />
				</xsl:when>
				<xsl:otherwise>411</xsl:otherwise>
			</xsl:choose>
			<xsl:text>C10</xsl:text>
		</xsl:attribute>
	</xsl:element>
	<xsl:element name="NamedRange">
		<xsl:attribute name="ss:Name">cboPhase</xsl:attribute>
		<xsl:attribute name="ss:RefersTo">
			<xsl:text>=Masters!R611C10:R</xsl:text>
			<xsl:choose>
				<xsl:when test="count(PM_Masters3/Phase) > 0">
					<xsl:value-of select="611+count(PM_Masters3/Phase)-1" />
				</xsl:when>
				<xsl:otherwise>611</xsl:otherwise>
			</xsl:choose>
			<xsl:text>C10</xsl:text>
		</xsl:attribute>
	</xsl:element>
	<xsl:element name="NamedRange">
		<xsl:attribute name="ss:Name">cboModule</xsl:attribute>
		<xsl:attribute name="ss:RefersTo">
			<xsl:text>=Masters!R811C10:R</xsl:text>
			<xsl:choose>
				<xsl:when test="count(PM_Masters4/ModuleName) > 0">
					<xsl:value-of select="811+count(PM_Masters4/ModuleName)-1" />
				</xsl:when>
				<xsl:otherwise>811</xsl:otherwise>
			</xsl:choose>
			<xsl:text>C10</xsl:text>
		</xsl:attribute>
	</xsl:element>
	<xsl:element name="NamedRange">
		<xsl:attribute name="ss:Name">cboSubProject</xsl:attribute>
		<xsl:attribute name="ss:RefersTo">
			<xsl:text>=Masters!R1011C10:R</xsl:text>
			<xsl:choose>
				<xsl:when test="count(PM_Masters5/SubProjectName) > 0">
					<xsl:value-of select="1011+count(PM_Masters5/SubProjectName)-1" />
				</xsl:when>
				<xsl:otherwise>1011</xsl:otherwise>
			</xsl:choose>
			<xsl:text>C10</xsl:text>
		</xsl:attribute>
	</xsl:element>
	<xsl:element name="NamedRange">
		<xsl:attribute name="ss:Name">cboMilestone</xsl:attribute>
		<xsl:attribute name="ss:RefersTo">
			<xsl:text>=Masters!R1211C10:R</xsl:text>
			<xsl:choose>
				<xsl:when test="count(PM_Masters6/Milestone) > 0">
					<xsl:value-of select="1211+count(PM_Masters6/Milestone)-1" />
				</xsl:when>
				<xsl:otherwise>1211</xsl:otherwise>
			</xsl:choose>
			<xsl:text>C10</xsl:text>
		</xsl:attribute>
	</xsl:element>
</xsl:template>

<xsl:template match="NewDataSet" xmlns="urn:schemas-microsoft-com:office:spreadsheet">
<Row ss:Index="10">
    <Cell ss:Index="10"><Data ss:Type="String">cboEmployee</Data></Cell>
</Row>
    <xsl:for-each select="PM_Masters/UserName">
		<xsl:element name="Row">
			<xsl:attribute name="ss:Index"><xsl:value-of select="10+position()"/></xsl:attribute>
			<Cell ss:Index="10"><Data ss:Type="String"><xsl:value-of select="."/></Data><NamedCell ss:Name="cboEmployee"/></Cell>
		</xsl:element>
	</xsl:for-each>
<Row ss:Index="210">
    <Cell ss:Index="10"><Data ss:Type="String">cboTasktype</Data></Cell>
</Row>
    <xsl:for-each select="PM_Masters1/TaskType">
		<xsl:element name="Row">
			<xsl:attribute name="ss:Index"><xsl:value-of select="210+position()"/></xsl:attribute>
			<Cell ss:Index="10"><Data ss:Type="String"><xsl:value-of select="."/></Data><NamedCell ss:Name="cboTasktype"/></Cell>
		</xsl:element>
	</xsl:for-each>
<Row ss:Index="410">
    <Cell ss:Index="10"><Data ss:Type="String">cboPriority</Data></Cell>
</Row>
    <xsl:for-each select="PM_Masters2/Priority">
		<xsl:element name="Row">
			<xsl:attribute name="ss:Index"><xsl:value-of select="410+position()"/></xsl:attribute>
			<Cell ss:Index="10"><Data ss:Type="String"><xsl:value-of select="."/></Data><NamedCell ss:Name="cboPriority"/></Cell>
		</xsl:element>
	</xsl:for-each>
<Row ss:Index="610">
    <Cell ss:Index="10"><Data ss:Type="String">cboPhase</Data></Cell>
</Row>
    <xsl:for-each select="PM_Masters3/Phase">
		<xsl:element name="Row">
			<xsl:attribute name="ss:Index"><xsl:value-of select="610+position()"/></xsl:attribute>
			<Cell ss:Index="10"><Data ss:Type="String"><xsl:value-of select="."/></Data><NamedCell ss:Name="cboPhase"/></Cell>
		</xsl:element>
	</xsl:for-each>
<Row ss:Index="810">
    <Cell ss:Index="10"><Data ss:Type="String">cboModule</Data></Cell>
</Row>
    <xsl:for-each select="PM_Masters4/ModuleName">
		<xsl:element name="Row">
			<xsl:attribute name="ss:Index"><xsl:value-of select="810+position()"/></xsl:attribute>
			<Cell ss:Index="10"><Data ss:Type="String"><xsl:value-of select="."/></Data><NamedCell ss:Name="cboModule"/></Cell>
		</xsl:element>
	</xsl:for-each>
<Row ss:Index="1010">
    <Cell ss:Index="10"><Data ss:Type="String">cboSubProject</Data></Cell>
</Row>
    <xsl:for-each select="PM_Masters5/SubProjectName">
		<xsl:element name="Row">
			<xsl:attribute name="ss:Index"><xsl:value-of select="1010+position()"/></xsl:attribute>
			<Cell ss:Index="10"><Data ss:Type="String"><xsl:value-of select="."/></Data><NamedCell ss:Name="cboSubProject"/></Cell>
		</xsl:element>
	</xsl:for-each>
<Row ss:Index="1210">
    <Cell ss:Index="10"><Data ss:Type="String">cboMilestone</Data></Cell>
</Row>
    <xsl:for-each select="PM_Masters6/Milestone">
		<xsl:element name="Row">
			<xsl:attribute name="ss:Index"><xsl:value-of select="1210+position()"/></xsl:attribute>
			<Cell ss:Index="10"><Data ss:Type="String"><xsl:value-of select="."/></Data><NamedCell ss:Name="cboMilestone"/></Cell>
		</xsl:element>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>