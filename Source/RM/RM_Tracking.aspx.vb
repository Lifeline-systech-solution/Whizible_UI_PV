Public Class RM_Tracking
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
#Region "Member Variables"
    Private m_strProjectID As String
    Private m_strViewID As String
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
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
    End Sub

    Protected Sub CreateTableData()
        If m_strProjectID = "0" Then
            Exit Sub
        End If
        Dim dr As IDataReader
        Dim counter As Integer = 0
        Dim strReqS As System.Text.StringBuilder = New System.Text.StringBuilder

        Dim strSQL As String = "usp_Sel_tbl_RM_ProjectRequirements_Tracking " + m_strProjectID + "," + m_strViewID
        If Request.Form("cboView") = "6" Then
            strSQL += "," + Session("intUserID").ToString
        End If
        dr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        While dr.Read

            'CommonFunction.General.WriteHTML("ReqS[" + counter.ToString + "]=""" + dr("ProjectRequirementID").ToString + "|" + dr("ParentProjectRequirementID").ToString + "|" + dr("ReqTitle").ToString + "|" + dr("PSD").ToString + "|" + dr("PED").ToString + "|" + dr("Documents").ToString + "|" + dr("IsExpand").ToString + "|" + _
            '    CommonFunctions.Security.Token.GetToken(dr("ProjectRequirementID").ToString + CType(Session("intUserID"), String) + "0" + "0") + """;")


            'ProjectRequirementID|ParentProjectRequirementID|ReqTitle|PSD|PED|Documents|IsExpand|PKToken of ProjectRequirementID
            '|Color|Requirement Code | ASD | AED | PHRS | AHRS | Priority | Status | ImpactID | PKToken of ImpactID
            ' | BSD | BED | BHRS 
            strReqS.Append("ReqS[" + counter.ToString + "]=""")
            strReqS.Append(dr("ProjectRequirementID").ToString + "|")
            strReqS.Append(dr("ParentProjectRequirementID").ToString + "|")

            strReqS.Append(dr("ReqTitle").ToString + "|")
            strReqS.Append(dr("PSD").ToString + "|")
            strReqS.Append(dr("PED").ToString + "|")
            strReqS.Append(dr("Documents").ToString + "|")
            strReqS.Append(dr("IsExpand").ToString + "|")
            strReqS.Append(CommonFunctions.Security.Token.GetToken(dr("ProjectRequirementID").ToString + CType(Session("intUserID"), String) + "0" + "0") + "|")
            strReqS.Append(dr("ColorCode").ToString + "|")

            strReqS.Append(dr("RequirementCode").ToString + "|")
            strReqS.Append(dr("ASD").ToString + "|")
            strReqS.Append(dr("AED").ToString + "|")
            strReqS.Append(dr("PHRS").ToString + "|")
            strReqS.Append(dr("AHRS").ToString + "|")
            strReqS.Append(dr("Priority").ToString + "|")
            strReqS.Append(dr("Status").ToString + "|")
            strReqS.Append(dr("ImpactID").ToString + "|")
            strReqS.Append(CommonFunctions.Security.Token.GetToken(dr("ImpactID").ToString + CType(Session("intUserID"), String) + "0" + "0") + "|")
            strReqS.Append(dr("BSD").ToString + "|")
            strReqS.Append(dr("BED").ToString + "|")
            strReqS.Append(dr("BHRS").ToString + "|")

            strReqS.Append(""";" + vbNewLine)

            counter += 1
        End While
        CommonFunction.General.WriteHTML(strReqS.ToString)
        CommonFunction.Data.DisposeDataReader(dr)
    End Sub
    Protected Sub InitPage()
        ' Added  Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added  Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        '--- Added By purvaj on 15 Jul 2009
        Dim m_blnHideCombo As Boolean = False
        Dim m_strDashboardID As String = ""
        '--- Added By purvaj on 15 Jul 2009
        m_strDashboardID = CommonFunction.General.CheckIsNothing(Request.QueryString("DashboardID"), "0")
        If m_strDashboardID.ToString <> "" And m_strDashboardID.ToString <> "0" Then
            m_blnHideCombo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_ShowOrHide_DashboardCombo " + m_strDashboardID.ToString, True), False), False)
        End If

        If m_blnHideCombo = False Then
            '--- End addition purvaj
            DrawDashboardCombo()
        End If
        InitializeVariables()
        ExecuteActions()
        MyBase.InitializeResources("AppResources.RM_Tracking", "AppResources")

        Dim strProjectRequirementID As String
        Dim strFileNames As String
        Dim dr As IDataReader




        If Request.QueryString("Action") = "GETDOCUMENTS" Then
            strProjectRequirementID = Request.QueryString("ProjectRequirementID")
            dr = CommonFunction.Data.GetDataReader("usp_Sel_tbl_RM_ProjectReqDocuments " + strProjectRequirementID, MyBase.UseSQL)
            If dr.Read Then
                strFileNames = dr("FileNames").ToString
            Else
                strFileNames = ""
            End If
            CommonFunction.Data.DisposeDataReader(dr)
            If strFileNames.Length <> 0 Then
                strFileNames = strFileNames.Substring(0, strFileNames.Length - 1)
            End If

            Response.Clear()
            Response.Write(strFileNames)
            Response.End()
        Else
            DrawMenu()

            DrawPageFilters()

            If m_strProjectID <> "0" Then
                drawGrid()
                DrawPopupMenu()
                DrawDocPopupMenu()
            End If
        End If
    End Sub
    Private Sub DrawMenu()
        If m_strProjectID = "0" Then
            CommonFunction.General.WriteHTML("<Table border=0 cellspacing=0 cellpadding=0 width='99.9%' class='clsTable' >")
            CommonFunction.General.WriteHTML("<TR class='clsTRMenu' valign=middle > <TD align=left>")
            CommonFunction.General.WriteHTML("<button disabled style=""border:0;BACKGROUND-COLOR:transparent;FONT-FAMILY: Arial, Verdana;font-weight: normal;	font-size: 8pt;color: black"" >New<img src='../../Images/RM/MenuDown.gif'></button> |")
            CommonFunction.General.WriteHTML("<button disabled style=""border:0;BACKGROUND-COLOR:transparent;FONT-FAMILY: Arial, Verdana;font-weight: normal;	font-size: 8pt;color: black"" >Action<img src='../../Images/RM/MenuDown.gif'></button> ")
            CommonFunction.General.WriteHTML("</TD>")


        Else
            CommonFunction.General.WriteHTML("<Table border=0 cellspacing=0 cellpadding=0 width='99.9%' class='clsTable' >")
            CommonFunction.General.WriteHTML("<TR class='clsTRMenu' valign=middle > <TD align=left>")
            CommonFunction.General.WriteHTML("<button  type='button' style=""border:0;BACKGROUND-COLOR:transparent;FONT-FAMILY: Arial, Verdana;font-weight: normal;	font-size: 8pt;color: black"" onclick=showMenu(event,'divMNNew')>New<img src='../../Images/RM/MenuDown.gif'></button> |")
            CommonFunction.General.WriteHTML("<button  type='button' style=""border:0;BACKGROUND-COLOR:transparent;FONT-FAMILY: Arial, Verdana;font-weight: normal;	font-size: 8pt;color: black"" onclick=showMenu(event,'divMNAction') >Action<img src='../../Images/RM/MenuDown.gif'></button> ")
            CommonFunction.General.WriteHTML("</TD>")

        End If
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML("View")
        CommonFunction.HTMLControls.DrawComboBox("cboView", "usp_Sel_RMTrackingView", 200, m_strViewID)
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</TABLE>")

        'Drawing Menu ActionItems

        CommonFunction.General.WriteHTML("<div id=divMNNew style='DISPLAY:none'>")
        CommonFunction.General.WriteHTML("<table cellpadding=0 cellspacing=1 class=clsGridTable>")
        CommonFunction.General.WriteHTML("<tr class=clsTRColumnHeader onmouseover=mouseOverPopupMenu(event) id=MNRequTR onmousedown=mouseDownPopupMainMenu('MNRequTR')  ><td><img src='../../Images/RM/MNReqNew.gif'>Requirement&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>")
        CommonFunction.General.WriteHTML("<tr class=clsTROdd onmouseover=mouseOverPopupMenu(event) id=MNTempTR onmousedown=mouseDownPopupMainMenu('MNTempTR')  ><td><img src='../../Images/RM/MNTempNew.gif'>Template</td></tr>")
        ''added by RohiniK on 21 Jun 07 - For Weserve RTM change -added TR Phase Master 
        CommonFunction.General.WriteHTML("<tr class=clsTROdd onmouseover=mouseOverPopupMenu(event) id=MNTRPhase onmousedown=mouseDownPopupMainMenu('MNTRPhase')  ><td><img src='../../Images/RM/MNTempNew.gif'>TR Phase Master</td></tr>")
        ''End of addition by RohiniK on 21 Jun 07 --For Weserve RTM change

        CommonFunction.General.WriteHTML("</table>")
        CommonFunction.General.WriteHTML("</div>")

        CommonFunction.General.WriteHTML("<div id=divMNAction style='DISPLAY:none'>")
        CommonFunction.General.WriteHTML("<table cellpadding=0 cellspacing=1 class=clsGridTable>")
        CommonFunction.General.WriteHTML("<tr class=clsTRColumnHeader onmouseover=mouseOverPopupMenu(event) onmousedown=mouseDownPopupMainMenu('MNDeleTR')  ><td><img src='../../Images/RM/MNDelete.gif'>Delete&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>")
        CommonFunction.General.WriteHTML("<tr class=clsTROdd onmouseover=mouseOverPopupMenu(event) onmousedown=mouseDownPopupMainMenu('MNViewTempTR')  ><td><img src='../../Images/RM/MNTempNew.gif'>View Template</td></tr>")
        ''added by RohiniK on 16 Aug 07 --for Project -all requirement Tamplate display
        CommonFunction.General.WriteHTML("<tr class=clsTROdd onmouseover=mouseOverPopupMenu(event) onmousedown=mouseDownPopupMainMenu('MNViewPrjTemp')  ><td><img src='../../Images/RM/MNTempNew.gif'>View Project Template</td></tr>")
        ''end of addition by RohiniK on 16 Aug 07 --for Project -all requirement Tamplate display
        CommonFunction.General.WriteHTML("</table>")
        CommonFunction.General.WriteHTML("</div>")

    End Sub
    Private Sub DrawPageFilters()
        CommonFunction.General.WriteHTML("")
        CommonFunction.General.WriteHTML("<DIV id=pageFilterDiv>")
        CommonFunction.General.WriteHTML("<TABLE ID='PageFilter' cellspacing=0 cellpadding=0 style=""border-top:thin solid gray;border-bottom:thin solid gray;"" Width=99.9% class=clsTable>")
        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunction.General.WriteHTML("<TD align=center>")
        CommonFunction.General.WriteHTML("Project")
        CommonFunction.HTMLControls.DrawComboBox("cboProject", "usp_Sel_AccessibleProjects_ForEmployee " + Session("intUserID").ToString + ",0,0,0,0,'" + Session("LoginType").ToString + "',0," + Session("intLoginID").ToString + ",0,1", 300, m_strProjectID, "onchange=cboProject_onChange()", InsertBlankRow:=True, IsMandatory:=True)
        CommonFunction.General.WriteHTML("</TD>")


        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</DIV>")

    End Sub
    Private Sub drawGrid()
        CommonFunction.General.WriteHTML("<div id=divTbl style=""HEIGHT:450px;width:99.9%;OVERFLOW:auto "">")
        CommonFunction.General.WriteHTML("</div>")
    End Sub
    Private Sub DrawPopupMenu()
        CommonFunction.General.WriteHTML("<div id=divMNPopup style=""DISPLAY:none"">")
        CommonFunction.General.WriteHTML("<table id=tblMNPopup class=clsGridTable cellpadding=0 cellspacing=1 >")
        CommonFunction.General.WriteHTML("<tr class=clsTRColumnHeader id=RequTR Style='cursor:hand' onmouseover=mouseOverPopupMenu(event) onmousedown=mouseDownPopupMenu('RequTR')  ><td > <img src='../../Images/RM/PopReq.gif'>" + MyBase.GetResourceString("POPUP_MENU_REQUIREMENT") + "</td></tr>")
        CommonFunction.General.WriteHTML("<tr class=clsTROdd id=DetaTR Style='cursor:hand' onmouseover=mouseOverPopupMenu(event) onmousedown=mouseDownPopupMenu('DetaTR') ><td > <img src='../../Images/RM/PopDetails.gif'>" + MyBase.GetResourceString("POPUP_MENU_DETAILS") + "</td></tr>")

        ''Commented by RohiniK on 29 Jun 07 --For WeServe
        ''Purpose: To remove "Imapct" and "Mapping" from the popup
        'CommonFunction.General.WriteHTML("<tr class=clsTROdd id=ImpaTR onmouseover=mouseOverPopupMenu(event) onmousedown=mouseDownPopupMenu('ImpaTR') ><td > <img src='../../Images/RM/PopImpact.gif'>" + MyBase.GetResourceString("POPUP_MENU_IMPACT") + "</td></tr>")
        'CommonFunction.General.WriteHTML("<tr class=clsTROdd id=MappTR onmouseover=mouseOverPopupMenu(event) onmousedown=mouseDownPopupMenu('MappTR') ><td > <img src='../../Images/RM/PopMapping.gif'>" + MyBase.GetResourceString("POPUP_MENU_MAPPING") + "</td></tr>")
        ''End of Comment by RohiniK on 29 Jun 07 --For WeServe

        'Following line added by AbhijitD on 26-Jul-07 for (WeServe) RTM Enhancement V2
        CommonFunction.General.WriteHTML("<tr class=clsTROdd id=ShowTR Style='cursor:hand' onmouseover=mouseOverPopupMenu(event) onmousedown=mouseDownPopupMenu('ShowTR') ><td > <img src='../../Images/RM/PopTraceability.gif'>Traceability</td></tr>")

        CommonFunction.General.WriteHTML("<tr class=clsTROdd id=UploTR Style='cursor:hand' onmouseover=mouseOverPopupMenu(event) onmousedown=mouseDownPopupMenu('UploTR') ><td > <img src='../../Images/RM/PopUpload.gif'>" + MyBase.GetResourceString("POPUP_MENU_UPLOAD") + "</td></tr>")
        CommonFunction.General.WriteHTML("</table>")
        CommonFunction.General.WriteHTML("</div>")
    End Sub
    Private Sub DrawDocPopupMenu()
        CommonFunction.General.WriteHTML("<div id=divDocMNPopup style=""DISPLAY:none"">")
        CommonFunction.General.WriteHTML("<table id=tblDocMNPopup class=clsGridTable cellpadding=0 cellspacing=1>")
        CommonFunction.General.WriteHTML("</table>")
        CommonFunction.General.WriteHTML("</div>")
    End Sub
    Private Sub ExecuteActions()
        If Request.Form("chk") = "" Then
            Return
        End If
        Dim strProjectRequirementIDsToDelete() As String
        Dim strMessage As String = ""
        Dim c As Integer = 0
        Dim strSQL As String
        Dim dr As IDataReader


        strProjectRequirementIDsToDelete = Request.Form("chk").Split(","c)
        While c < strProjectRequirementIDsToDelete.Length
            strSQL = "DECLARE @strResult VARCHAR(200) EXEC usp_Del_tbl_RM_ProjectRequirements " + strProjectRequirementIDsToDelete(c) + ",@strResult OUTPUT SELECT @strResult"
            dr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If dr.Read Then
                If Not IsDBNull(dr(0)) Then
                    strMessage += dr(0).ToString + "\n"
                End If
            End If
            CommonFunction.Data.DisposeDataReader(dr)
            c += 1
        End While

        If strMessage <> "" Then
            CommonFunction.General.WriteHTML("<script>")
            CommonFunction.General.WriteHTML("alert(""" + strMessage + """)")
            CommonFunction.General.WriteHTML("</script>")
        End If
    End Sub
    Private Sub DrawDashboardCombo()

        Dim sbHTML As System.Text.StringBuilder = New System.Text.StringBuilder
        sbHTML.Append("")

        sbHTML.Append("<TABLE Class=clsGridTable cellpadding=0 cellspacing=0 Width=100%>")

        sbHTML.Append("<TR class=clsTREven><TD>&nbsp;e-Dashboard&nbsp;")

        If Trim(Session("intPostID").ToString) <> "" Then

            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", "usp_CDB_GetUserDashboardsForCombo " & Session("intUserID").ToString & "," & Session("intPostID").ToString, , "../RM/RM_Tracking.aspx|0", "OnChange='JavaScript:cboDashboard_OnChange()'", , True))

        Else

            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", "usp_CDB_GetUserDashboardsForCombo " & Session("intUserID").ToString, , "../RM/RM_Tracking.aspx|0", "OnChange='JavaScript:cboDashboard_OnChange()'", , True))

        End If

        sbHTML.Append("</td></tr></table><BR>")

        CommonFunction.General.WriteHTML(sbHTML.ToString)

    End Sub

End Class
