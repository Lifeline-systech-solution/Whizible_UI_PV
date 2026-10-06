Public Class Requirement_Tracking
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        MyBase.ApplySecurity(True)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region "Member Variables"
    Private m_strProjectID As String
    Private m_strViewID As String
    Private m_strProjReqmtId As String
#End Region

    'Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
    '    'Put user code to initialize the page here
    'End Sub

    Private Sub InitializeVariables()
        If Request.Form("cboView") <> "" Then
            m_strViewID = Request.Form("cboView")
        Else
            m_strViewID = "0"
        End If

        If Request.Form("cboProject") <> "" Then
            m_strProjectID = Request.Form("cboProject")
        ElseIf Not Session("intProjectID") Is Nothing Then
            m_strProjectID = Session("intProjectID").ToString
        Else
            m_strProjectID = "0"
        End If

        m_strProjReqmtId = Request.QueryString("ProjectRequirementId") + ""
        If Not Request.QueryString("ProjectID") Is Nothing Then
            m_strProjectID = Request.QueryString("ProjectID")
        End If
    End Sub

    Protected Sub InitPage()
        InitializeVariables()
        'MyBase.InitializeResources("AppResources.RM_Tracking", "AppResources")

        'ExecuteActions()

        If m_strProjReqmtId = "" Then DrawDashboardCombo()
        If m_strProjReqmtId = "" Then DrawMenu()
        DrawPageFilters()
        Call DrawGrid()

        'Dim strProjectRequirementID As String
        'Dim strFileNames As String
        'Dim dr As IDataReader

        'If Request.QueryString("Action") = "GETDOCUMENTS" Then
        '    strProjectRequirementID = Request.QueryString("ProjectRequirementID")
        '    dr = CommonFunction.Data.GetDataReader("usp_Sel_tbl_RM_ProjectReqDocuments " + strProjectRequirementID, MyBase.UseSQL)
        '    If dr.Read Then
        '        strFileNames = dr("FileNames").ToString
        '    Else
        '        strFileNames = ""
        '    End If
        '    CommonFunction.Data.DisposeDataReader(dr)
        '    If strFileNames.Length <> 0 Then
        '        strFileNames = strFileNames.Substring(0, strFileNames.Length - 1)
        '    End If

        '    Response.Clear()
        '    Response.Write(strFileNames)
        '    Response.End()
        'Else
        '    DrawMenu()

        '    DrawPageFilters()

        '    If m_strProjectID <> "0" Then
        '        drawGrid()
        '    End If
        'End If
    End Sub

    Private Sub DrawGrid()
        Dim sbHTML As New System.Text.StringBuilder
        Dim strSQL, strReqTitle, strProjectRequirementID, strCurrentRequirementRowNo, strOldRequirementRowNo, strReqTRPhaseID, strParentProjectRequirementID As String
        Dim strTRClass, strTRID, strImgID, strTDHeight As String
        Dim intTotalPhaseCount, intColumnNumber, intPhaseColumnNumber As Integer
        Dim dr As IDataReader
        Dim blnIsParent, blnHasChild As Boolean
        Dim blnTREndPlot As Boolean

        blnTREndPlot = True
        strTDHeight = "100px"

        strSQL = "usp_sel_Project_TRPhases " + m_strProjectID
        dr = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        If (dr.Read) Then
            intTotalPhaseCount = 1

            sbHTML.Append("<DIV id=divListTag style='OVERFLOW: auto; WIDTH: 100%; HEIGHT: 450px'>" + vbCrLf)
            sbHTML.Append("<TABLE class='clsGridTable' cellpadding=0 cellspacing=1 width=100%>" + vbCrLf)
            sbHTML.Append("<THead class='clsTRColumnHeader'>" + vbCrLf)
            sbHTML.Append("<TH align='left' class='divListTag'>Requirement</TH>" + vbCrLf)
            sbHTML.Append("<TH align='left' class='divListTag'>" + dr.Item("TRPhaseName").ToString + "</TH>" + vbCrLf)
            While (dr.Read)
                sbHTML.Append("<TH align='left' class='divListTag'>" + dr.Item("TRPhaseName").ToString + "</TH>" + vbCrLf)
                intTotalPhaseCount = intTotalPhaseCount + 1
            End While
            sbHTML.Append("</THead>" + vbCrLf)

            'Added by AbhijitD on 25-Jul-07 to remove javascript error on page load if no project is selected in session
        Else
            sbHTML.Append("<DIV id=divListTag style='OVERFLOW: auto; WIDTH: 100%; HEIGHT: 450px'>" + vbCrLf)
            sbHTML.Append("<TABLE class='clsGridTable' cellpadding=0 cellspacing=1 width=100%><TR><TD></TD></TR>" + vbCrLf)
        End If
        CommonFunction.Data.DisposeDataReader(dr)
        'End of addition by AbhijitD on 25-Jul-07

        strSQL = "usp_sel_tbl_RTM_Req_TRPhase " + m_strProjectID + "," + m_strViewID
        If m_strProjReqmtId = "" Then
            If Request.Form("cboView") = "6" Then
                strSQL += "," + Session("intUserID").ToString
            End If
        Else
            strSQL += ",Null," + m_strProjReqmtId
        End If

        dr = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        While (dr.Read)
            strCurrentRequirementRowNo = dr.Item("RowNumber").ToString.Trim
            strProjectRequirementID = dr.Item("ProjectRequirementID").ToString
            strParentProjectRequirementID = CommonFunctions.Data.CheckIsDBNull(dr.Item("ParentProjectRequirementID")).ToString

            'Comment BY VarunA on 5-Sep-2007
            'intPhaseColumnNumber = dr.Item("ColumnNumber")
            intPhaseColumnNumber = CType(dr.Item("ColumnNumber"), Integer)
            'End by VarunA on 5-Sep-2007
            strReqTRPhaseID = dr.Item("ReqTRPhaseID").ToString
            strReqTitle = dr.Item("ReqTitle").ToString

            If strCurrentRequirementRowNo <> strOldRequirementRowNo Then

                If blnTREndPlot = False Then
                    While (intColumnNumber < intTotalPhaseCount)
                        sbHTML.Append("<TD height=" + strTDHeight + ">&nbsp;</TD>" + vbCrLf)
                        intColumnNumber = intColumnNumber + 1
                    End While
                    sbHTML.Append("</TR>" + vbCrLf)
                End If

                blnIsParent = CType(dr.Item("IsParent"), Boolean)
                blnHasChild = CType(dr.Item("HasChild"), Boolean)

                If blnIsParent = True Then
                    strTRClass = "clsTRSectionHeader"
                    sbHTML.Append("<TR class='" + strTRClass + "'>" + vbCrLf)
                Else
                    strTRClass = "clsTREven"
                    strTRID = """TR" + strParentProjectRequirementID + """"
                    sbHTML.Append("<TR id=" + strTRID + " class='" + strTRClass + "'>" + vbCrLf)
                End If

                blnTREndPlot = False

                If blnHasChild = True Then
                    strTRID = """TR" + strProjectRequirementID + """"
                    strImgID = """Img" + strProjectRequirementID + """"
                    sbHTML.Append("<TD height=" + strTDHeight + "> <a href='Javascript:TRShowHide(" + strTRID + "," + strImgID + ")'><Img Border=0 id=" + strImgID + " src='../../Images/minus.gif'></a><b>&nbsp;" + strReqTitle + "</b></TD>" + vbCrLf)
                ElseIf blnIsParent = True Then
                    sbHTML.Append("<TD height=" + strTDHeight + "><b>" + strReqTitle + "</b></TD>" + vbCrLf)
                Else
                    sbHTML.Append("<TD height=" + strTDHeight + ">" + strReqTitle + "</TD>" + vbCrLf)
                End If

                intColumnNumber = 1

                If intPhaseColumnNumber = 0 Then
                    While (intColumnNumber <= intTotalPhaseCount)
                        sbHTML.Append("<TD height=" + strTDHeight + ">&nbsp;</TD>" + vbCrLf)
                        intColumnNumber = intColumnNumber + 1
                    End While
                Else
                    While (intColumnNumber < intPhaseColumnNumber)
                        sbHTML.Append("<TD height=" + strTDHeight + ">&nbsp;</TD>" + vbCrLf)
                        intColumnNumber = intColumnNumber + 1
                    End While

                    sbHTML.Append("<TD height=" + strTDHeight + "><TABLE class='clsGridTable' width=100% cellpadding=0 cellspacing=0>")
                    sbHTML.Append("<TR class='" + strTRClass + "'>" + vbCrLf)
                    'sbHTML.Append("<TD>" + CommonFunctions.HTMLControls.DrawTextArea("txtPhaseDetails", "txtPhaseDetails", FormName:="frmRMTracking", widthInPixel:=150, heightInPixel:=50, value:=dr.Item("Reference").ToString, returnHTML:=True) + "</TD>")
                    'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                    'sbHTML.Append("<TD>" + CommonFunctions.HTMLControls.DrawTextArea(strReqTRPhaseID, strReqTRPhaseID, "Phase Details", FormName:="frmRMTracking", widthInPixel:=150, heightInPixel:=50, value:=dr.Item("Reference").ToString, returnHTML:=True) + "</TD>")
                    sbHTML.Append("<TD>" + CommonFunctions.HTMLControls.DrawTextArea(strReqTRPhaseID, strReqTRPhaseID, "Phase Details", FormName:="frmRMTracking", widthInPixel:=150, heightInPixel:=50, value:=dr.Item("Reference").ToString, returnHTML:=True, EnableHTMLEncode:=True) + "</TD>")
                    'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                    sbHTML.Append("</TR>")
                    sbHTML.Append("<TR class='" + strTRClass + "'>" + vbCrLf)
                    sbHTML.Append("<TD align=left><a href='javascript:Mapping_OnClick(" + m_strProjectID + "," + strProjectRequirementID + "," + strReqTRPhaseID + ")'>Mapping</a></TD>")
                    sbHTML.Append("</TR>")
                    sbHTML.Append("<TR class='" + strTRClass + "'>" + vbCrLf)
                    sbHTML.Append("<TD align=left><a href='javascript:Issues_OnClick(" + m_strProjectID + "," + strProjectRequirementID + "," + strReqTRPhaseID + ")'>Issues</a></TD>")
                    sbHTML.Append("</TR>")
                    sbHTML.Append("</TABLE></TD>" + vbCrLf)
                End If

                strOldRequirementRowNo = strCurrentRequirementRowNo
            Else
                While (intColumnNumber < intPhaseColumnNumber - 1)
                    sbHTML.Append("<TD height=" + strTDHeight + ">&nbsp;</TD>" + vbCrLf)
                    intColumnNumber = intColumnNumber + 1
                End While

                sbHTML.Append("<TD height=" + strTDHeight + "><TABLE class='clsGridTable' width=100% cellpadding=0 cellspacing=0>")
                sbHTML.Append("<TR class='" + strTRClass + "'>" + vbCrLf)
                'sbHTML.Append("<TD>" + CommonFunctions.HTMLControls.DrawTextArea("txtPhaseDetails", "txtPhaseDetails", FormName:="frmRMTracking", widthInPixel:=150, heightInPixel:=50, value:=dr.Item("Reference").ToString, returnHTML:=True) + "</TD>")
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                ' sbHTML.Append("<TD>" + CommonFunctions.HTMLControls.DrawTextArea(strReqTRPhaseID, strReqTRPhaseID, "Phase Details", FormName:="frmRMTracking", widthInPixel:=150, heightInPixel:=50, value:=dr.Item("Reference").ToString, returnHTML:=True) + "</TD>")
                sbHTML.Append("<TD>" + CommonFunctions.HTMLControls.DrawTextArea(strReqTRPhaseID, strReqTRPhaseID, "Phase Details", FormName:="frmRMTracking", widthInPixel:=150, heightInPixel:=50, value:=dr.Item("Reference").ToString, returnHTML:=True, EnableHTMLEncode:=True) + "</TD>")
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                sbHTML.Append("</TR>")
                sbHTML.Append("<TR class='" + strTRClass + "'>" + vbCrLf)
                sbHTML.Append("<TD align=left><a href='javascript:Mapping_OnClick(" + m_strProjectID + "," + strProjectRequirementID + "," + strReqTRPhaseID + ")'>Mapping</a></TD>")
                sbHTML.Append("</TR>")
                sbHTML.Append("<TR class='" + strTRClass + "'>" + vbCrLf)
                sbHTML.Append("<TD align=left><a href='javascript:Issues_OnClick(" + m_strProjectID + "," + strProjectRequirementID + "," + strReqTRPhaseID + ")'>Issues</a></TD>")
                sbHTML.Append("</TR>")
                sbHTML.Append("</TABLE></TD>" + vbCrLf)

                intColumnNumber = intColumnNumber + 1
            End If
        End While
        CommonFunction.Data.DisposeDataReader(dr)
        If blnTREndPlot = False Then
            While (intColumnNumber < intTotalPhaseCount)
                sbHTML.Append("<TD height=" + strTDHeight + ">&nbsp;</TD>" + vbCrLf)
                intColumnNumber = intColumnNumber + 1
            End While
            sbHTML.Append("</TR>" + vbCrLf)
        End If

        sbHTML.Append("</TABLE></Div>" + vbCrLf)
        CommonFunctions.General.WriteHTML(sbHTML.ToString)
        sbHTML = Nothing
    End Sub

    Private Sub DrawMenu()
        CommonFunction.General.WriteHTML("<Table border=0 cellspacing=0 cellpadding=0 width='99.9%' class='clsTable' >")
        CommonFunction.General.WriteHTML("<TR class='clsTRMenu' valign=middle > ")
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML("View")
        CommonFunction.HTMLControls.DrawComboBox("cboView", "usp_Sel_RMTrackingView", 200, m_strViewID, "OnChange='Javascript:cboView_onchange();'")
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</TABLE>")
    End Sub

    Private Sub DrawPageFilters()
        CommonFunction.General.WriteHTML("")
        CommonFunction.General.WriteHTML("<DIV id=pageFilterDiv>")
        CommonFunction.General.WriteHTML("<TABLE ID='PageFilter' cellspacing=0 cellpadding=0 style=""border-top:thin solid gray;border-bottom:thin solid gray;"" Width=99.9% class=clsTable>")
        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunction.General.WriteHTML("<TD align=center>")

        'Comment BY VarunA on 5-Sep-2007
        'Dim strIsDisabled As String = IIf(m_strProjReqmtId = "", "", " Disabled ")
        Dim strIsDisabled As String = CType(IIf(m_strProjReqmtId = "", "", " Disabled "), String)
        'End by VarunA on 5-Sep-2007
        CommonFunction.General.WriteHTML("Project")
        CommonFunction.HTMLControls.DrawComboBox("cboProject", "usp_Sel_AccessibleProjects_ForEmployee " + Session("intUserID").ToString + ",0,0,0,0,'" + Session("LoginType").ToString + "',0," + Session("intLoginID").ToString + ",0,1", 300, m_strProjectID, "onchange=cboProject_onChange()" + strIsDisabled, InsertBlankRow:=True, IsMandatory:=True)
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</DIV>")

    End Sub

    'Private Sub drawGrid()
    '    CommonFunction.General.WriteHTML("<div id=divTbl style=""HEIGHT:450px;width:99.9%;OVERFLOW:auto "">")
    '    CommonFunction.General.WriteHTML("</div>")
    'End Sub


    Private Sub DrawDashboardCombo()
        Dim sbHTML As New System.Text.StringBuilder

        sbHTML.Append("")
        sbHTML.Append("<TABLE Class=clsGridTable cellpadding=0 cellspacing=0 Width=100%>")
        sbHTML.Append("<TR class=clsTREven><TD>&nbsp;e-Dashboard&nbsp;")

        If Trim(Session("intPostID").ToString) <> "" Then
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", "usp_CDB_GetUserDashboardsForCombo " & Session("intUserID").ToString & "," & Session("intPostID").ToString, , "../RM/Requirement_Tracking.aspx|0", "OnChange='JavaScript:cboDashboard_OnChange()'", , True))
        Else
            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", "usp_CDB_GetUserDashboardsForCombo " & Session("intUserID").ToString, , "../RM/Requirement_Tracking.aspx|0", "OnChange='JavaScript:cboDashboard_OnChange()'", , True))
        End If

        sbHTML.Append("</td></tr></table><BR>")

        CommonFunction.General.WriteHTML(sbHTML.ToString)
    End Sub

    Public Sub New()
        ' Added and Commented By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        ' MyBase.ApplySecurity()

        MyBase.ApplySecurity(True)
        ' End Added and Commented By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
    End Sub

End Class
