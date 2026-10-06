Imports Whizible
Imports System.Text

Partial Public Class FCI_IntegrationSetup
    Inherits WebPages.Template.WhizTemplate

    Private strAction As String = ""
    Private m_ProjectID As String
    Private m_SysID As String
    Public m_IntegrationID As String = ""
    Public m_ActiveFilter As String = ""
    Protected IntegrationID As String = ""
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    'Added by Archanan on 15-Jul-2010
    Private frmValueMap As New ValueMapping
    'en of Added by Archanan on 15-Jul-2010
    Protected m_strDeletedIDList As String = ""
    Public Enum SelectedTab
        INTEGRATION
        ATTRIBUTES
        VALUES
    End Enum


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        
    End Sub

    Protected Sub Page_Init()
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        Dim sbTabSection As New StringBuilder
        If Not Request.QueryString("Action") Is Nothing And Request.QueryString("Action") <> "" Then
            strAction = Request.QueryString("Action").ToString()
        ElseIf Not Request.Form("hidAction") Is Nothing And Request.Form("hidAction") <> "" Then
            strAction = Request.Form("hidAction").ToString()
        End If

        If Not Request.QueryString("SysID") Is Nothing And Request.QueryString("SysID") <> "" Then
            m_SysID = Request.QueryString("SysID").ToString()
        ElseIf Not Request.Form("hidSysID") Is Nothing And Request.Form("hidSysID") <> "" Then
            m_SysID = Request.Form("hidSysID").ToString()
        End If

        m_ProjectID = Session("intProjectID").ToString()
        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'm_IntegrationID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(" select IntegrationID from tbl_FCI_IntegrationDetails Where Projectid = " + m_ProjectID.ToString, True), "")
        m_IntegrationID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_FCI_IntegrationDetails_IntegrationID " + m_ProjectID.ToString, True), "")
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

        'And Request.QueryString("ShowActive") <> "" 

        If Not Request.QueryString("ShowActive") Is Nothing Then
            m_ActiveFilter = CommonFunction.General.CheckIsNothing(Request.QueryString("ShowActive").ToString(), "")
            Session("strActiveFilter") = m_ActiveFilter
            'ElseIf Not Request.Form("hidtxtIsActive") Is Nothing And Request.Form("hidtxtIsActive") <> "" Then
            '    m_ActiveFilter = Request.Form("hidtxtIsActive").ToString()
        End If

        If m_ActiveFilter = "" Then
            m_ActiveFilter = CommonFunction.General.CheckIsNothing(Session("strActiveFilter"), "")
        End If

        Response.Write("<input type=hidden id='hidAction' name='hidAction' value=" + strAction + ">")
        Response.Write("<input type=hidden id='hidSysID' name='hidSysID' value=" + m_SysID + ">")
        Response.Write("<input type=hidden id='hidIntegrationId' name='hidIntegrationId' value=" + m_IntegrationID + ">")
        If Not Request.QueryString("PerformAction") Is Nothing And Request.QueryString("PerformAction") <> "" Then
            If Request.QueryString("PerformAction").ToUpper() = "SAVE_INTEGRATIONDTLS" Then
                SaveIntegrationDtls()
            ElseIf Request.QueryString("PerformAction").ToUpper() = "DELETE" Then
                DeleteMapping()
            End If
        Else
            If (strAction = "" And m_IntegrationID.ToString <> "") Then
                strAction = "ATTRIBUTE"
            ElseIf (strAction = "" And m_IntegrationID.ToString = "") Then
                strAction = "INTEGRATIONDTLS"
            End If

            DrawTabSection(strAction)
            DrawMenu()
            If strAction.ToUpper() = "ATTRIBUTE" Then
                DrawFilter()
            End If
            DrawPageCaption(strAction)

            If strAction.ToUpper() = "INTEGRATIONDTLS" Or strAction = "" Then
                DrawIntegrationDetails()
            ElseIf strAction.ToUpper() = "ATTRIBUTE" Then
                DrawAttributeDetails()
            ElseIf strAction.ToUpper() = "ATTRIBUTEVALUE" Then
                'Added by Archanan on 15-Jul-2010
                frmValueMap.m_IntegrationID = m_IntegrationID.ToString
                frmValueMap.Page_Init()
                'end of Added by Archanan on 15-Jul-2010
            End If
        End If
        DrawMenu()
    End Sub
    Private Sub DeleteMapping()
        Dim strDelSQL As String = ""
        Dim strDeletedIDList As String = ""
        strDeletedIDList = CommonFunctions.General.CheckIsNothing(Request.QueryString("DeletedIDList").ToString, ",")
        strDelSQL = " usp_Del_tbl_FCI_ExternalSysAttribute_Mapping " + m_IntegrationID + "," + strDeletedIDList
        CommonFunction.Data.InsertOrUpdateData(strDelSQL, True)

    End Sub
    Private Sub DrawTabSection(ByVal Action As String)

        Dim sbTabSection As New StringBuilder


        sbTabSection.Append("<div id='Headtbl'><TABLE cellpadding=0 cellspacing=0 class=clsTableNavLinks width='100%'>")
        sbTabSection.Append("<TR class=clsTRNavLinks  valign=middle>")
        sbTabSection.Append("<TR class='clsTRblank'><TD valign=center align=left>")
        sbTabSection.Append("<TABLE  cellspacing=0   class=clsTable><TR style='float:left;'>")
        sbTabSection.Append("<TD id =""ignoreRight""></TD>")
        ' sbTabSection.Append("<TD noWrap>")
        'Added by Archanan on 15-Jul-2010
        If m_IntegrationID = "" Then
            sbTabSection.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='Integration Details' href='javascript:ItemTab_OnClick(""IntegrationDtls"")' IntegrationDtls?)?>Integration Details</a>")
        Else
            'end of Added by Archanan on 15-Jul-2010
            If Action.ToUpper() = "INTEGRATIONDTLS" Or (strAction = "") Then
                sbTabSection.Append("<TD id =""sec1"" align=center noWrap Title=""Integration Details""><span id='selected'>Integration Details</span></A></TD>")
                sbTabSection.Append("<TD id =""sec2"" align=center noWrap Title=""Attribute Mapping""><A class='clsSelected' href='javascript:ItemTab_OnClick(""Attribute"")'>Attribute Mapping</A></TD>")
                sbTabSection.Append("<TD id =""sec3"" align=center noWrap Title=""Value Mapping""><A class='clsSelected' href='javascript:ItemTab_OnClick(""AttributeValue"")'>Value Mapping</A></TD>")
                sbTabSection.Append("</TR></TABLE>")
                sbTabSection.Append("</TR></TABLE>")
                Response.Write(sbTabSection.ToString())
            ElseIf strAction.ToUpper() = "ATTRIBUTE" Then
                sbTabSection.Append("<TD id =""sec1"" align=center noWrap Title=""Integration Details""><A class='clsSelected'  href='javascript:ItemTab_OnClick(""IntegrationDtls"")'>Integration Details</A></TD>")
                sbTabSection.Append("<TD id =""sec2"" align=center noWrap Title=""Attribute Mapping""><span id='selected'>Attribute Mapping</span></TD>")
                sbTabSection.Append("<TD id =""sec3"" align=center noWrap Title=""Value Mapping""><A class='clsSelected' href='javascript:ItemTab_OnClick(""AttributeValue"")'>Value Mapping</A></TD>")
                sbTabSection.Append("</TR></TABLE>")
                sbTabSection.Append("</TR></TABLE>")
                Response.Write(sbTabSection.ToString())
            ElseIf strAction.ToUpper() = "ATTRIBUTEVALUE" Then
                sbTabSection.Append("<TD id =""sec1"" align=center noWrap Title=""Integration Details""><A class='clsSelected'  href='javascript:ItemTab_OnClick(""IntegrationDtls"")'>Integration Details</A></TD>")
                sbTabSection.Append("<TD id =""sec2"" align=center noWrap Title=""Attribute Mapping""><A class='clsSelected' href='javascript:ItemTab_OnClick(""Attribute"")'>Attribute Mapping</A></TD>")
                sbTabSection.Append("<TD id =""sec3"" align=center noWrap Title=""Value Mapping""><span id='selected'>Value Mapping</span></TD>")
                'sbTabSection.Append("</TR></TABLE>")
                sbTabSection.Append("</TR></TABLE>")
                sbTabSection.Append("</TR></TABLE>")
                Response.Write(sbTabSection.ToString())
                ''    sbTabSection.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='Integration Details' href='javascript:ItemTab_OnClick(""IntegrationDtls"")' IntegrationDtls?)?><Font Color=black>Integration Details</font></a>")
                ''    sbTabSection.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='Attribute Mapping' href='javascript:ItemTab_OnClick(""Attribute"")' Attribute?)?><Font Color=black>Attribute Mapping</font></a>")
                ''    sbTabSection.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='Value Mapping' href='javascript:ItemTab_OnClick(""AttributeValue"")' AttributeValue?)?><Font Color=black>Value Mapping</font></a></TD> </TR>")
                ''ElseIf strAction.ToUpper() = "ATTRIBUTE" Then
                ''    sbTabSection.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='Integration Details' href='javascript:ItemTab_OnClick(""IntegrationDtls"")' IntegrationDtls?)?><Font Color=black>Integration Details</font></a>")
                ''    sbTabSection.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='Attribute Mapping' href='javascript:ItemTab_OnClick(""Attribute"")' Attribute?)?><Font Color=black>Attribute Mapping</font></a>")
                ''    sbTabSection.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='Value Mapping' href='javascript:ItemTab_OnClick(""AttributeValue"")' AttributeValue?)?><Font Color=black>Value Mapping</font></a></TD> </TR>")
                ''ElseIf strAction.ToUpper() = "ATTRIBUTEVALUE" Then
                ''    sbTabSection.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='Integration Details' href='javascript:ItemTab_OnClick(""IntegrationDtls"")' IntegrationDtls?)?><Font Color=black>Integration Details</font></a>")
                ''    sbTabSection.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='Attribute Mapping' href='javascript:ItemTab_OnClick(""Attribute"")' Attribute?)?><Font Color=black>Attribute Mapping</font></a>")
                ''    sbTabSection.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='Value Mapping' href='javascript:ItemTab_OnClick(""AttributeValue"")' AttributeValue?)?><Font Color=black>Value Mapping</font></a></TD> </TR>")
            End If
        End If
        'sbTabSection.Append("</td></TR>")
        ' sbTabSection.Append("</TABLE>")
        sbTabSection.Append("</div>")

        'Response.Write(sbTabSection.ToString())

    End Sub

    Private Sub DrawIntegrationDetails()
        Dim sbIntegrationDetails As New StringBuilder
        Dim strQuery As String
        Dim dr As IDataReader
        ' Dim IntegrationID As String = ""
        Dim SystemID As String = ""
        Dim FilePath As String = ""
        Dim TimeZone As String = ""
        Dim DateFormat As String = ""
        Dim SysName As String = ""
        Dim IsSingleFLDForDAteTime As Integer
        Dim DisableReassignment As Integer

        'I.IntegrationID,I.SystemID,I.ProjectID,I.FilePath,I.TimeZone,I.DateFormat,SM.SysName

        strQuery = "usp_Sel_tbl_FCI_IntegrationDetails " + m_ProjectID
        dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        While dr.Read()
            IntegrationID = CommonFunction.Data.CheckIsDBNull(dr("IntegrationID").ToString(), "")
            SystemID = dr("SystemID").ToString()
            FilePath = dr("FilePath").ToString()
            TimeZone = dr("TimezoneID").ToString()
            DateFormat = dr("DateFormat").ToString()
            SysName = dr("SysName").ToString()
            IsSingleFLDForDAteTime = CommonFunction.Data.CheckIsDBNull(dr("IsSingleFLDForDAteTime"), "0")
            DisableReassignment = CommonFunction.Data.CheckIsDBNull(dr("DisableReassignment"), "0")
        End While

        sbIntegrationDetails.Append("<DIV id='DivMain' style='Overflow:auto;width:99.9%;'>")
        sbIntegrationDetails.Append("<Table class=clsTable cellSpacing='0' cellPadding='0' width='99.9%' border='0'>")
        sbIntegrationDetails.Append("<TR>")
        sbIntegrationDetails.Append("<TD align=right width=30%>")
        sbIntegrationDetails.Append("Source Type&nbsp;&nbsp;")
        sbIntegrationDetails.Append("</TD>")
        sbIntegrationDetails.Append("<TD align=left width=70%>")
        'If IntegrationID = "" Then

        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'sbIntegrationDetails.Append(CommonFunction.HTMLControls.DrawComboBox("cboSourceType", "SELECT SysID,SysCode FROM tbl_FCI_SystemMaster", 300, SystemID, , True, True, , True))
        sbIntegrationDetails.Append(CommonFunction.HTMLControls.DrawComboBox("cboSourceType", "usp_sel_tbl_FCI_SystemMaster", 300, SystemID, , True, True, , True))
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

        'Else
        'sbIntegrationDetails.Append(CommonFunction.HTMLControls.DrawComboBox("cboSourceType", "SELECT SysID,SysName FROM tbl_FCI_SystemMaster", 300, SystemID, "disabled", True, True, , True))
        'End If
        sbIntegrationDetails.Append("</TD>")
        sbIntegrationDetails.Append("</TR>")
        'sbIntegrationDetails.Append("<TR>")
        'sbIntegrationDetails.Append("<TD align=right width=30%>")
        'sbIntegrationDetails.Append("Path&nbsp;&nbsp;")
        'sbIntegrationDetails.Append("</TD>")
        'sbIntegrationDetails.Append("<TD align=left width=70%>")
        ' sbIntegrationDetails.Append(CommonFunction.HTMLControls.DrawTextBox("txtPath", "txtPath", , 300, 500, FilePath, , , , , , , , True))
        ' sbIntegrationDetails.Append("</TD>")
        ' sbIntegrationDetails.Append("</TR>")
        sbIntegrationDetails.Append("<TR>")
        sbIntegrationDetails.Append("<TD align=right width=30%>")
        sbIntegrationDetails.Append("Time Zone&nbsp;&nbsp;")
        sbIntegrationDetails.Append("</TD>")
        sbIntegrationDetails.Append("<TD align=left width=70%>")
        'sbIntegrationDetails.Append(CommonFunction.HTMLControls.DrawTextBox("txtZone", "txtZone", , 200, 500, TimeZone, , , , , , , , True))
        'If IntegrationID = "" Then
        sbIntegrationDetails.Append(CommonFunction.HTMLControls.DrawComboBox("cboZone", "usp_SEL_tbl_FCI_ZoneGMTSettings", 300, TimeZone, , True, True, , True))
        'Else
        '    sbIntegrationDetails.Append(CommonFunction.HTMLControls.DrawComboBox("cboZone", "usp_SEL_tbl_FCI_ZoneGMTSettings", 300, TimeZone, "disabled", True, True, , True))
        'End If
        sbIntegrationDetails.Append("</TD>")
        sbIntegrationDetails.Append("</TR>")

        sbIntegrationDetails.Append("<TR>")
        sbIntegrationDetails.Append("<TD align=right width=30%>")
        sbIntegrationDetails.Append("Single Field For Date & Time&nbsp;&nbsp;")
        sbIntegrationDetails.Append("</TD>")

        sbIntegrationDetails.Append("<TD width=70%>")
        sbIntegrationDetails.Append(CommonFunction.HTMLControls.DrawCheckBox("chkSingleFLDDateTime", "chkSingleFLDDateTime", , IsSingleFLDForDAteTime.ToString, IsSingleFLDForDAteTime.ToString, , " Language=Javascript onclick=chkSingleFLDDateTime_OnClick() ", True))
        sbIntegrationDetails.Append("</TD>")
        sbIntegrationDetails.Append("</TR>")
        sbIntegrationDetails.Append("<TR>")
        sbIntegrationDetails.Append("<TD align=right width=30%>")
        sbIntegrationDetails.Append("Do not update issue assignment information &nbsp;&nbsp;")
        sbIntegrationDetails.Append("</TD>")
        sbIntegrationDetails.Append("<TD width=70%>")
        sbIntegrationDetails.Append(CommonFunction.HTMLControls.DrawCheckBox("chkUpdateAssignto", "chkUpdateAssignto", , DisableReassignment.ToString, DisableReassignment.ToString, , " Language=Javascript onclick=chkUpdateAssignto_OnClick() ", True))
        sbIntegrationDetails.Append("</TD>")
        sbIntegrationDetails.Append("</TR>")
        'sbIntegrationDetails.Append("<TR>")
        'sbIntegrationDetails.Append("<TD align=right>")
        'sbIntegrationDetails.Append("Date Format&nbsp;&nbsp;")
        'sbIntegrationDetails.Append("</TD>")
        'sbIntegrationDetails.Append("<TD align=left>")
        'sbIntegrationDetails.Append(CommonFunction.HTMLControls.DrawComboBox("cboDateFormat", "SELECT FormatDate,FormatDate FROM tbl_PM_DateFormats", 100, DateFormat, , True, True, , True))
        'sbIntegrationDetails.Append("</TD>")
        'sbIntegrationDetails.Append("</TR>")

        sbIntegrationDetails.Append("</Table>")

        sbIntegrationDetails.Append("</DIV>")

        Response.Write(sbIntegrationDetails.ToString())

    End Sub

    Private Sub DrawAttributeDetails()
        Dim sbIntegrationDetails As New StringBuilder
        Dim strQuery As String
        Dim dr As IDataReader
        Dim IntegrationID As String = ""
        Dim SystemID As String = ""
        Dim FilePath As String = ""
        Dim SysAttributeName As String = ""
        Dim WhizAttributeName As String = ""
        Dim WhizsysAttriuteID As String = "0"
        Dim SysName As String = ""
        Dim cnt As Int16 = 0
        Dim isActive As String

        'strQuery = "usp_Sel_FCI_AttributeMapping " + m_ProjectID + "," + m_SysID
        If m_ActiveFilter <> "" Then
            strQuery = "usp_Sel_FCI_AttributeMapping " + m_IntegrationID + "," + m_ActiveFilter
        Else
            strQuery = "usp_Sel_FCI_AttributeMapping " + m_IntegrationID
        End If

        dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        sbIntegrationDetails.Append("<DIV id='DivMain' style='Overflow:auto;width:99.9%;'>")
        sbIntegrationDetails.Append("<Table class='clsGridTable' width=99.9% cellpadding=0 CELLSPACING='1' border=0>")
        sbIntegrationDetails.Append("<TR class='clsTRColumnHeader'>")
        sbIntegrationDetails.Append("<TD>")
        'Commented And Added By Parag Patil On 21 NOV 2013 For PMLifeLine
        'sbIntegrationDetails.Append("<b>Whizible Attribute</b>")
        sbIntegrationDetails.Append("<b>PMLifeLine Attribute</b>")
        'Commented And Added By Parag Patil On 21 NOV 2013 For PMLifeLine
        sbIntegrationDetails.Append("</TD>")
        sbIntegrationDetails.Append("<TD>")
        sbIntegrationDetails.Append("<b>System Attribute</b>")
        sbIntegrationDetails.Append("</TD>")
        'sbIntegrationDetails.Append("<TD>")
        'sbIntegrationDetails.Append("<b><Delete</b>")
        'sbIntegrationDetails.Append("</TD>")
        sbIntegrationDetails.Append("</TR>")
        sbIntegrationDetails.Append("<BR>")
        sbIntegrationDetails.Append("<TR class='clsTRColumnHeader'>")
        sbIntegrationDetails.Append("<TD colspan=3>Issue Attributes")
        sbIntegrationDetails.Append("</TD></TR>")

        While dr.Read()
            isActive = CommonFunction.Data.CheckIsDBNull(dr("IsActive"), 0).ToString
            SysAttributeName = dr("SysAttributeName").ToString()
            If dr("IsCustomField").ToString() = "True" Then
                WhizAttributeName = dr("WhizAttributeName").ToString()
            Else
                WhizAttributeName = dr("UserFriendlyName").ToString()
            End If
            WhizsysAttriuteID = dr("WhizSysAttributeID").ToString
            If dr("IsCustomField").ToString() = "True" And cnt = "0" Then
                cnt = 1
                sbIntegrationDetails.Append("<BR>")
                sbIntegrationDetails.Append("<TR class='clsTRColumnHeader'>")
                sbIntegrationDetails.Append("<TD colspan=3>Custom Attributes")
                sbIntegrationDetails.Append("</TD></TR>")
            End If
            sbIntegrationDetails.Append("<TR class='clsTREven'>")
            sbIntegrationDetails.Append("<TD>")
            'If SysAttributeName.ToUpper = "CUSTOMERISSUEID" Then
            '    ' sbIntegrationDetails.Append("<font color=Red>")
            '    sbIntegrationDetails.Append(WhizAttributeName)
            '    'sbIntegrationDetails.Append("</font>")
            'Else
            If isActive = False Then
                sbIntegrationDetails.Append("<font color=Blue>")
                sbIntegrationDetails.Append(WhizAttributeName)
                sbIntegrationDetails.Append("</font>")
            Else
                sbIntegrationDetails.Append(WhizAttributeName)
            End If
            'End If

            sbIntegrationDetails.Append("</TD>")
            ' sbIntegrationDetails.Append("<TD>")
            'sbIntegrationDetails.Append(SysAttributeName)
            'If SysAttributeName.ToUpper = "CUSTOMERISSUEID" Then
            '    sbIntegrationDetails.Append("<TD align=Left Title=" + SysAttributeName + " ><font color=Red>" + SysAttributeName + "  (Unique Key)</font></TD>")
            'Else
          
            If isActive = False Then
                'Commented and Added By Vidya J on 16-11-2015
                ' sbIntegrationDetails.Append("<TD align=Left Title='" + SysAttributeName + "'><A href='Javascript:SysAttributeName_OnClick(" + WhizsysAttriuteID + ")'> <font color=Blue>" + SysAttributeName + "</font></A></TD>")
                sbIntegrationDetails.Append("<TD align=Left Title='" + HttpUtility.HtmlEncode(SysAttributeName) + "'><A href='Javascript:SysAttributeName_OnClick(" + WhizsysAttriuteID + ")'> <font color=Blue>" + HttpUtility.HtmlEncode(SysAttributeName) + "</font></A></TD>")
                'End of Commented and Added By Vidya J on 16-11-2015
            Else
                'Commented and Added By Vidya J on 16-11-2015
                '    sbIntegrationDetails.Append("<TD align=Left Title='" + SysAttributeName + "'><A href='Javascript:SysAttributeName_OnClick(" + WhizsysAttriuteID + ")'>" + SysAttributeName + "</A></TD>")
                sbIntegrationDetails.Append("<TD align=Left Title='" + HttpUtility.HtmlEncode(SysAttributeName) + "'><A href='Javascript:SysAttributeName_OnClick(" + WhizsysAttriuteID + ")'>" + HttpUtility.HtmlEncode(SysAttributeName) + "</A></TD>")
                'End of Commented and Added By Vidya J on 16-11-2015
            End If
            'End If
            'sbIntegrationDetails.Append("<TD>")
            'sbIntegrationDetails.Append(CommonFunction.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , False, WhizsysAttriuteID, , " Language=Javascript onclick=chkDelete_OnClick() ", True))
            'sbIntegrationDetails.Append("</TD>")
            ' sbIntegrationDetails.Append("</TD>")
            sbIntegrationDetails.Append("</TR>")
        End While
        dr.Close()
        dr.Dispose()
        sbIntegrationDetails.Append("</Table>")

        sbIntegrationDetails.Append("</DIV>")

        Response.Write(sbIntegrationDetails.ToString())

    End Sub
    Private Sub DrawFilter()
        Dim sbHTML As StringBuilder = New StringBuilder
        sbHTML.Append("<table id='tblFilter' CellSpacing=1 CellPadding=0 class='clsTable' width='99.9%'>")
        sbHTML.Append("<TR class='clsTRPageFilters'>")
        sbHTML.Append("<Td align='right' valign='top' width='50%'>")
        sbHTML.Append("Show Active Attributes : </Td>")
        sbHTML.Append("<Td align='left' valign='top' width='50%'>")
        sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboIsActive", "usp_Sel_tbl_UI_ControlTagMaster_SPForCheckBox", 50, m_ActiveFilter, "onChange=""javascript:setDateFilter()""", True, True))
        sbHTML.Append("</Td>")
        sbHTML.Append("</TR>")
        sbHTML.Append("</table>")
        Response.Write(sbHTML.ToString)
    End Sub

    Private Sub DrawPageCaption(ByVal strAction As String)
        '====================================================================
        ' Procedure Name    :      DrawPageCaption
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw Page caption.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      Shraddha M
        ' Created           :      14,Jul 2010
        ' Revisions         :
        '=====================================================================
        Dim m_SBHTML As StringBuilder
        m_SBHTML = New StringBuilder

        m_SBHTML.Append("<br>")
        If strAction.ToUpper = "ATTRIBUTE" Then
            m_SBHTML.Append(WebPages.Template.PageCaption.GetPageCaptions(, "Attribute Mapping", "<font color=blue>Inactive attributes are displayed in blue color</font>", , True))
        ElseIf strAction.ToUpper = "ATTRIBUTEVALUE" Then
            m_SBHTML.Append(WebPages.Template.PageCaption.GetPageCaptions(, "Value Mapping", , , True))
        Else
            m_SBHTML.Append(WebPages.Template.PageCaption.GetPageCaptions(, "Integration Details", , , True))
        End If
        m_SBHTML.Append("<br>")
        Response.Write(m_SBHTML.ToString)

        m_SBHTML = Nothing


        'Dim objSectionPhases As New Whiz.WebPage.Templates.SectionTitle
        'With objSectionPhases
        '    '.GetSectionTitle("<B>" & " " & "Integration Details" & "s</B>", "", "", , "&nbsp;|&nbsp;" & "<a class='Menu' Title='Save' href='javascript:""Add_OnClick()""'>Add</a>" & "&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        '    '.GetSectionTitle("<B>" & " " & "Integration Details" & "s</B>", "", "", , "&nbsp;|&nbsp;" & "<a class='Menu' Title='Save' href='javascript:Add_OnClick("")'>Save</a>" & "&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        '    .GetSectionTitle("<B>" & " " & "Integration Details" & "</B>", "", "", , "&nbsp;|&nbsp;" & "<a class='Menu' Title='Save' href='javascript:" &  "Save_OnClick(" ")'>Save</a>" & "&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        '    CommonFunctions.General.WriteHTML("<SCRIPT Language=javascript>")
        '    CommonFunctions.General.WriteHTML(.ClientsideScript)
        '    CommonFunctions.General.WriteHTML("</SCRIPT>")
        'End With



    End Sub

    Private Sub DrawMenu(Optional ByVal blnShowPaging As Boolean = True)
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 09, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList     'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList     'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String         'Used to store the Menu List as HTML
        Dim strPageAlphabets As String
        Dim objPaging As WebPage.Templates.Paging
        Dim strPagingHTML As String
        Dim Access_Add As Boolean
        Dim Access_Edit As Boolean
        Dim Access_View As Boolean
        Dim Access_Del As Boolean

        m_objMenu = New WebPages.Template.StaticMenu
        'Added for access
        Dim strSQL As String
        Dim drAccess As IDataReader
        strSQL = "Exec usp_Sel_tbl_UI_NodeAccess " & 8056 & "," & CType(HttpContext.Current.Session("intPostID"), Integer) & "," & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'" & CType(HttpContext.Current.Session("LoginType"), String) & "'"
        drAccess = CommonFunctions.Data.GetDataReader(strSQL, True)
        If drAccess.Read() Then
            Access_Add = CType(drAccess.Item("A"), Boolean)
            Access_Edit = CType(drAccess.Item("E"), Boolean)
            Access_View = CType(drAccess.Item("V"), Boolean)
            Access_Del = CType(drAccess.Item("D"), Boolean)
        End If



        If strAction.ToUpper = "INTEGRATIONDTLS" Or m_IntegrationID = "" Then
            If Access_Add = True Or Access_Edit = True Then
                arrMenuCaptionsList.Add("Save")
                arrMenuToolTipsList.Add("Save")
                arrClientSideFunctionList.Add("Save_OnClick('" + strAction + "')")
            End If
        
            If m_IntegrationID <> "" Then
                arrMenuCaptionsList.Add("Show History")
                arrMenuToolTipsList.Add("Show History")
                arrClientSideFunctionList.Add("ShowHistory_OnClick('" + m_IntegrationID + "'," & m_ProjectID.ToString & ")")
            End If
        ElseIf strAction.ToUpper = "ATTRIBUTE" Then
            If Access_Add = True Or Access_Edit = True Then
                arrMenuCaptionsList.Add("Map Attributes")
                arrMenuToolTipsList.Add("Map Attributes")
                arrClientSideFunctionList.Add("AddAttribute_OnClick('" + strAction + "','" + m_IntegrationID + "')")
            End If
          
            'arrMenuCaptionsList.Add("Delete")
            'arrMenuToolTipsList.Add("Delete")
            'arrClientSideFunctionList.Add("Delete_OnClick()")
            'arrMenuCaptionsList.Add("SelectAll")
            'arrMenuToolTipsList.Add("Select All")
            'arrClientSideFunctionList.Add("SelectAll_OnClick('" + strAction + "','" + m_IntegrationID + "')")
            'arrMenuCaptionsList.Add("ClearAll")
            'arrMenuToolTipsList.Add("Clear All")
            'arrClientSideFunctionList.Add("SelectAll_OnClick('" + strAction + "','" + m_IntegrationID + "')")

        End If


        arrMenuCaptionsList.Add("?")
        arrMenuToolTipsList.Add("Help")
        arrClientSideFunctionList.Add("Help_OnClick(8056)")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)
        strPageAlphabets = ""
    End Sub

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Private Sub SaveIntegrationDtls()
        Dim strQuery As String
        Dim dr As IDataReader
        Dim SystemID As String = ""
        Dim FilePath As String = ""
        Dim TimeZone As String = ""
        Dim DateFormat As String = ""
        Dim SysName As String = ""
        Dim IntegrationIDForSP As String
        Dim IsSingleFLDForDAteTime As Integer
        Dim UpdateAssignto As Integer
        IntegrationID = m_IntegrationID
        If IntegrationID = "" Then
            IntegrationIDForSP = "NULL"
        Else
            IntegrationIDForSP = IntegrationID
        End If

        SystemID = Request.Form("cboSourceType")
        FilePath = Request.Form("txtPath")
        TimeZone = Request.Form("cboZone")
        IsSingleFLDForDAteTime = CommonFunction.General.CheckIsNothing(Request.Form("chkSingleFLDDateTime"), "0")
        UpdateAssignto = CommonFunction.General.CheckIsNothing(Request.Form("chkUpdateAssignto"), "0")
        ' DateFormat = Request.Form("cboDateFormat")


        strQuery = "usp_INS_tbl_FCI_IntegrationDetails " + IntegrationIDForSP + "," + SystemID + "," + m_ProjectID + ",'" + FilePath + "'," + TimeZone + "," + IsSingleFLDForDAteTime.ToString + "," + UpdateAssignto.ToString + ",'" + Session("strUserName").ToString() + "'"
        ''+ ",'" + DateFormat + "'"

        dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        If dr.Read() Then
            IntegrationID = dr("IntegrationID")
        End If
        'Added by Archanan on 15-Jul-2010
        CommonFunction.General.WriteHTML("<Script>")
        'Commented & Added By Dipali V On 9th June 2020 For Refresh Issues 
        'CommonFunction.General.WriteHTML("window.location.href='../IB/FCI_IntegrationSetup.aspx?Action=Attribute&SysID=" + SystemID + "';")
        CommonFunction.General.WriteHTML("window.location.href='../IB/FCI_IntegrationSetup.aspx?Action=INTEGRATIONDTLS&SysID=" + SystemID + "';")
        'End of Commented & Added By Dipali V On 9th June 2020 For Refresh Issues 
        CommonFunction.General.WriteHTML("</Script>")
        'End of Added by Archanan on 15-Jul-2010
    End Sub
End Class