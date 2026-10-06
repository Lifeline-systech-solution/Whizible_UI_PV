Public Class HR_PipelineGraphicalView
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    Protected Enum PageType
        OPPORTUNITY
        PROJECT_STAFFINGPLAN
        PASS1
        PASS2

    End Enum

    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Protected m_PageType As Integer
    Protected m_ReqType As String
    Private tblHTML As New System.Text.StringBuilder("")
    Private Iterator As Integer
    'Protected iRoleCounter As Integer
    'Protected jMonCounter As Integer
    Private arrRVerticals As String = ""
    Private arrRightVerticals() As String
    Private strMonthEndIDs As String

    Private arrLVerticals As String = ""
    Private arrLeftVerticals() As String
    Private strIsFreezed As String = ""
    Private arrIsFreezed() As String
    Private strMonthStartIDs As String
    Protected m_strMasterPK As String
    Private strFillColor As String = "Red"
    Private strNotFillColor As String = "White"
    Private strRangeColor As String = ""

    Private strVertRightRBs As String = ""
    Private arrVertRightRB() As String
    Private strVertLeftLBs As String = ""
    Private arrVertLeftLB() As String

    Private m_strMonthQuery As String
    Private GantView_StartDt As Date
    Private GantView_EndDt As Date
    Private RB_validateDT As Date
    Private MonDiff As Integer
    Private YearIncrement As Integer
    Private m_strBGID As String
    Private m_strOUID As String
    Private m_strSkillID As String
    Private m_strRoleID As String
    Private m_EditAccess As Boolean
    Private m_AddAccess As Boolean
    Protected m_SettingValueResAll As String
    Public Shared blnOnBenchForPlotting As Boolean
    Protected IsRoleBase As String = "0"

    Private m_TypeSelected As String ''added by RohiniK on 28 Oct 09 for S1 Changes

    Private Sub DisposeObjects()
        m_objMenu = Nothing

        tblHTML = Nothing
    End Sub

    Protected Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        'DiplayTables()

        ''commented by nilesh g on 31/12/2015 for Security
        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            Response.Write(vbCrLf + "<script>")
            Response.Write(vbCrLf + "		if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
            Response.Write(vbCrLf + "</script>")
        End If
        ''end of commented by nilesh g on 31/12/2015 for Security

    End Sub
    Protected Sub PageInit()
        'If Not (Request.QueryString("FromXML") = "1" AndAlso Request.QueryString("For").ToUpper = "OU") Then
        If Not (Request.QueryString("FromXML") = "1" AndAlso Request.QueryString("For").ToUpper = "OU") And _
     Not (Request.QueryString("FromXML") = "1" AndAlso Request.QueryString("For").ToUpper = "SOFTBOOK") Then
            InitializePage()
        End If

        If Not Request.QueryString("IsRoleBase") Is Nothing OrElse Request.QueryString("IsRoleBase") <> "" Then
            IsRoleBase = Request.QueryString("IsRoleBase").ToString()
        End If

        If Request.QueryString("ACTION") = "SAVE" Or Request.QueryString("ACTION") = "SAVECLOSE" Then
            Call Save()
        End If

        If Not Request.QueryString("FromXML") Is Nothing Then
            If Request.QueryString("FromXML") = "1" Then
                Select Case Request.QueryString("For").ToUpper
                    Case "OU"
                        Response.Clear()
                        Response.Write(GetBGwiseOU())
                        Response.End()
                    Case "PASS1"
                        Response.Clear()
                        GenerateForeCastSectionPass1()
                        Response.End()
                    Case "PASS2"
                        Response.Clear()
                        GenerateForeCastSectionPass2()
                        Response.End()
                    Case "SOFTBOOK"
                        Response.Clear()
                        ProcessSoftBooking()
                        Response.End()
                End Select
            End If
        End If
        m_SettingValueResAll = CType(CommonFunctions.Data.GetDataScalar("usp_Sel_ResAllocation_SettingValue", True), String)
        If CType(m_SettingValueResAll, Double) = 0 Then
            m_SettingValueResAll = "100"
        End If

        Call GenerateFilterMenu()

        Call DiplayTables()


        Call DisposeObjects()
    End Sub
    Private Sub InitializePage()
        Dim drMonth As IDataReader
        'Added By ShraddhaM on 14,Feb 2008
        Dim strFromWhere As String
        Dim strForAccess As String
        'End of addition by ShraddhaM


        If Not Request.QueryString("OpportunityID") Is Nothing Then
            m_PageType = PageType.OPPORTUNITY
            m_strMasterPK = Request.QueryString("OpportunityID")

        ElseIf Not Request.Form("HidOpportunityID") Is Nothing Then
            m_PageType = PageType.OPPORTUNITY
            m_strMasterPK = Request.Form("HidOpportunityID")

        ElseIf Not Request.QueryString("ProjectID") Is Nothing Then
            m_PageType = PageType.PROJECT_STAFFINGPLAN
            m_strMasterPK = Request.QueryString("ProjectID")

        ElseIf Not Request.Form("HidProjectID") Is Nothing Then
            m_PageType = PageType.PROJECT_STAFFINGPLAN
            m_strMasterPK = Request.Form("HidProjectID")

        ElseIf Not Request.QueryString("For") Is Nothing Then
            If Request.QueryString("For").ToUpper = "PASS1" Then
                m_PageType = PageType.PASS1
            ElseIf Request.QueryString("For").ToUpper = "PASS2" Then
                m_PageType = PageType.PASS2
            End If
            m_strMasterPK = Request.QueryString("For")


        ElseIf Not Request.Form("HidFor") Is Nothing Then
            If Request.Form("HidFor") = "PASS1" Then
                m_PageType = PageType.PASS1
            ElseIf Request.Form("HidFor") = "PASS2" Then
                m_PageType = PageType.PASS2
            End If
            m_strMasterPK = Request.Form("HidFor")
        End If



        If Request.Form("YearIncr") Is Nothing Then
            If Request.QueryString("YearIncr") Is Nothing Then
                YearIncrement = 0
            Else
                YearIncrement = CType(Request.QueryString("YearIncr"), Integer)
            End If

        Else
            YearIncrement = CType(Request.Form("YearIncr"), Integer)
        End If

        If m_PageType = PageType.OPPORTUNITY Then
            ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
            ''m_strMonthQuery = "SELECT OpportunityID,ApproxStartDate,ApproxEndDate,DATEDIFF(mm,'1-'+ DATENAME(mm,ApproxStartDate) + '-' + CAST(Year(ApproxStartDate) AS VARCHAR),'1-'+ DATENAME(mm,ApproxEndDate) + '-' + CAST(Year(ApproxEndDate) AS VARCHAR))+1 MonDiff FROM tbl_RM_Opportunity WHERE OpportunityID = " + m_strMasterPK
            m_strMonthQuery = "usp_sel_tbl_RM_Opportunity_OpportunityID " + m_strMasterPK
            ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
            drMonth = CommonFunctions.Data.GetDataReader(m_strMonthQuery, MyBase.UseSQL)

            If drMonth.Read Then
                GantView_StartDt = CType(drMonth("ApproxStartDate"), Date)
                GantView_EndDt = CType(drMonth("ApproxEndDate"), Date)
                RB_validateDT = GantView_EndDt
                MonDiff = CType(drMonth("MonDiff"), Integer)
            End If
            CommonFunction.General.WriteHTML("<input type=hidden name=HidOpportunityID id=HidOpportunityID value=" + m_strMasterPK + ">")
            If Not Request.QueryString("For") Is Nothing Then
                m_ReqType = Request.QueryString("For")
            ElseIf Not Request.Form("HidFor") Is Nothing Then
                m_ReqType = Request.Form("HidFor")
            End If
            CommonFunction.General.WriteHTML("<input type=hidden name=HidFor id=HidFor value=" + m_ReqType + ">")
            CommonFunction.Data.DisposeDataReader(drMonth)
        ElseIf m_PageType = PageType.PROJECT_STAFFINGPLAN Then
            Dim m_strProjectStartDate As String
            Dim m_strProjectEndDate As String

            m_strMonthQuery = "usp_Sel_Project_StaffingPlan_GanttDates " + m_strMasterPK

            drMonth = CommonFunctions.Data.GetDataReader(m_strMonthQuery, MyBase.UseSQL)

            If drMonth.Read Then
                GantView_StartDt = CType(drMonth("ExpectedStartDate"), Date)
                m_strProjectStartDate = GantView_StartDt.ToString("dd-MMM-yyyy")
                GantView_EndDt = CType(drMonth("ExpectedEndDate"), Date)
                m_strProjectEndDate = GantView_EndDt.ToString("dd-MMM-yyyy")

                MonDiff = CType(drMonth("MonDiff"), Integer)
                If MonDiff > 12 Then
                    If Request.Form("YearIncr") Is Nothing AndAlso Request.QueryString("YearIncr") Is Nothing Then
                        YearIncrement = CType(drMonth("YearIncr"), Integer)
                    End If
                End If
            End If
            m_ReqType = "PROJECT"
            CommonFunction.General.WriteHTML("<input type=hidden name=HidProjectID id=HidProjectID value=" + m_strMasterPK + ">")
            CommonFunction.General.WriteHTML("<input type=hidden name=HidProjectStartDate id=HidProjectStartDate value=" + m_strProjectStartDate + ">")
            CommonFunction.General.WriteHTML("<input type=hidden name=HidProjectEndDate id=HidProjectEndDate value=" + m_strProjectEndDate + ">")

            CommonFunction.Data.DisposeDataReader(drMonth)
        ElseIf m_PageType = PageType.PASS1 Then
            m_strMonthQuery = "usp_Sel_GraphicalView_PassI_II_SD_ED " + YearIncrement.ToString
            drMonth = CommonFunctions.Data.GetDataReader(m_strMonthQuery, MyBase.UseSQL)

            If drMonth.Read Then
                GantView_StartDt = CType(drMonth("StartDate"), Date)
                GantView_EndDt = CType(drMonth("EndDate"), Date)
                MonDiff = CType(drMonth("MonthDiff"), Integer)
            End If
            CommonFunctions.Data.DisposeDataReader(drMonth)
            CommonFunction.General.WriteHTML("<input type=hidden name=HidFor id=HidFor value=" + m_strMasterPK + ">")

        ElseIf m_PageType = PageType.PASS2 Then
            m_strMonthQuery = "usp_Sel_GraphicalView_PassI_II_SD_ED " + YearIncrement.ToString
            drMonth = CommonFunctions.Data.GetDataReader(m_strMonthQuery, MyBase.UseSQL)

            If drMonth.Read Then
                GantView_StartDt = CType(drMonth("StartDate"), Date)
                GantView_EndDt = CType(drMonth("EndDate"), Date)
                MonDiff = CType(drMonth("MonthDiff"), Integer)
            End If
            CommonFunctions.Data.DisposeDataReader(drMonth)
            CommonFunction.General.WriteHTML("<input type=hidden name=HidFor id=HidFor value=" + m_strMasterPK + ">")

        Else
            Response.End()

        End If

        'Added ShraddhaM
        m_strBGID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboBG"), ""), String)
        m_strOUID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboOU"), ""), String)
        m_strRoleID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboRole")), String)
        m_strSkillID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboSkill")), String)
        'End of additon by ShraddhaM
        ''added by RohiniK on 28 Oct 09 for S1 Changes
        If Not CommonFunctions.General.CheckIsNothing(Request.Form("optType")) Is Nothing Then
            m_TypeSelected = CType(CommonFunctions.General.CheckIsNothing(Request.Form("optType")), String)
        Else
            m_TypeSelected = ""
        End If

        ''End of addition by RohiniK on 28 Oct 09 for S1 Changes

        tblHTML.Append("<input type=hidden name=YearIncr id=YearIncr value=" + YearIncrement.ToString + ">")

        'Added by ShraddhaM on 14,Feb 2008 for Role Access
        Dim ProjectID As String
        If Not Session("intProjectID") Is Nothing Then
            ProjectID = Session("intProjectID").ToString
        Else
            ProjectID = "0"
        End If

        If m_PageType = PageType.OPPORTUNITY Or m_PageType = PageType.PROJECT_STAFFINGPLAN Then
            strForAccess = "usp_sel_ResourceDemand_RoleAccess " & Session("intUserID").ToString() & ",'" & m_ReqType & "'," + ProjectID
            drMonth = CommonFunctions.Data.GetDataReader(strForAccess, MyBase.UseSQL)

            While drMonth.Read()

                m_EditAccess = CType(drMonth("E"), Boolean)
                m_AddAccess = CType(drMonth("A"), Boolean)

            End While
            CommonFunctions.Data.DisposeDataReader(drMonth)
        End If

        'End of addition by ShraddhaM

    End Sub
    Private Function GenerateMenu(ByVal isUp As Boolean) As String

        Dim arrMenu As New System.Collections.ArrayList
        Dim arrMenuToolTip As New System.Collections.ArrayList
        Dim arrCSFunction As New System.Collections.ArrayList
        Dim strImage As String
        'Dim dtStartDate As String
        'Dim dtEndDate As String
        Dim TodaysDate As Date

        TodaysDate = Now

        Dim dtStartDate As New Date(TodaysDate.Year, TodaysDate.Month, 1)
        Dim dtEndDate As New Date(TodaysDate.Year, TodaysDate.Month, TodaysDate.DaysInMonth(TodaysDate.Year, TodaysDate.Month))


        If m_PageType = PageType.PASS1 Or m_PageType = PageType.PASS2 Then
            If isUp Then
                strImage = "<img id='imgFilterUp' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Filter.gif'"
            Else
                strImage = "<img id='imgFilterDown' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Filter.gif'"
            End If

            arrMenu.Add(strImage)
            arrMenuToolTip.Add("Filters")
            arrCSFunction.Add("Filters_OnClick()")
        End If

        arrMenu.Add("Project Allocation")
        arrMenuToolTip.Add("Project Allocation")
        arrCSFunction.Add("ProjectAllocation_OnClick('" + dtStartDate.ToString("dd-MMM-yyyy") + "','" + dtEndDate.ToString("dd-MMM-yyyy") + "')")
        'arrCSFunction.Add("ProjectAllocation_OnClick()")

        arrMenu.Add("Previous")
        arrMenuToolTip.Add("Previous")
        arrCSFunction.Add("previousYear_OnClick()")

        arrMenu.Add("Next")
        arrMenuToolTip.Add("Next")
        arrCSFunction.Add("NextYear_OnClick()")

        arrMenu.Add("Add")
        arrMenuToolTip.Add("Add")
        arrCSFunction.Add("Add_OnClick()")

        arrMenu.Add("Save")
        arrMenuToolTip.Add("Save")
        arrCSFunction.Add("Save_OnClick()")

        arrMenu.Add("Save and Close")
        arrMenuToolTip.Add("Save and Close")
        arrCSFunction.Add("SaveAndClose_OnClick()")

        arrMenu.Add("Close")
        arrMenuToolTip.Add("Close")
        arrCSFunction.Add("Close_OnClick()")

        arrMenu.Add("?")
        arrMenuToolTip.Add("Help")
        Select Case m_PageType
            Case PageType.OPPORTUNITY
                arrCSFunction.Add("Help_OnClick('OPP_GRAPHICAL')")
            Case PageType.PASS1
                arrCSFunction.Add("Help_OnClick('PASS1')")
            Case PageType.PASS2
                arrCSFunction.Add("Help_OnClick('PASS2')")
            Case PageType.PROJECT_STAFFINGPLAN
                arrCSFunction.Add("Help_OnClick('PRJ_GRAPHICAL')")

        End Select


        m_objMenu = New WebPage.Templates.StaticMenu

        GenerateMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip), True)

        m_objMenu = Nothing

    End Function
    Private Sub DiplayTables()

        Dim objGanttChart_Month As cGanttChart_Month
        Dim arrStartDates_MonthWise As ArrayList
        Dim arrEndDates_MonthWise As ArrayList
        Dim strMenuHTML As String
        Dim hidRecPKIDs As String

        Dim drRole As IDataReader

        Dim strRecPKID As String
        Dim Record_StartDt As Date
        Dim Record_EndDt As Date

        Dim strFirstColumnHTML As String
        Dim strFirstColumnHTML_hold As String = ""


        Dim strSecondColumnHTML As String
        Dim strSecondColumnHTML_hold As String = ""
        Dim strCheckBoxForPass_value As String

        Dim vertIndex As Integer = 0

        Dim strClass As String = "clsTREven"
        'Addition by SuchitraP on 18-Nov-2008 for Resource demand changes
        Dim strType As String = ""
        'End by SuchitraP
        Dim IsFreezed As Boolean

        Dim IsRoleSelected As Boolean
        Dim IsSkillSelected As Boolean

        Dim strOptType As String = "" ''added by RohiniK on 28 Oct 09 for S1 changes

        'Commented by SanaS on 21-Oct-2009 
        'Purpose: As filter is provided for Role and Skill there is no need for Radio Button Selection
        'If Not Request.Form("optRoleBase") Is Nothing OrElse Request.Form("optRoleBase") <> "" Then
        '    IsRoleBase = Request.Form("optRoleBase").ToString()
        'End If



        'If IsRoleBase = "1" Then
        '    IsRoleSelected = True
        '    IsSkillSelected = False
        'Else
        '    IsRoleSelected = False
        '    IsSkillSelected = True
        'End If
        'End Comment by SanaS on 21-Oct-2009 
        IsRoleSelected = False
        IsSkillSelected = True

        strMenuHTML = GenerateMenu(True)


        tblHTML.Append(strMenuHTML + vbCrLf)


        If MonDiff > 12 Then
            MonDiff = 12

            If YearIncrement <> 0 Then
                GantView_StartDt = GantView_StartDt.AddMonths((12 * YearIncrement) - YearIncrement)
                GantView_StartDt = New Date(GantView_StartDt.Year, GantView_StartDt.Month, 1)
            End If

            GantView_EndDt = GantView_StartDt.AddMonths(11)
            GantView_EndDt = New Date(GantView_EndDt.Year, GantView_EndDt.Month, GantView_EndDt.DaysInMonth(GantView_EndDt.Year, GantView_EndDt.Month))

        End If

        'Addition by SuchitraP on 18-Nov-2008 for Resource Demand changes
        If m_strMasterPK = "PASS1" Then
            tblHTML.Append("<br><table id='tblCaption' border = 0 width=100% cellspacing=0 cellpadding = 0 >" + vbCrLf)
            tblHTML.Append("<tr class=clsTRPageCaption><td>Search Joining Pool</td>" + vbCrLf)
            'Commented by SanaS on 21-Oct-2009 
            'Purpose: As filter is provided for Role and Skill there is no need for Radio Button Selection
            'tblHTML.Append("<td align=right> ")
            'tblHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("optRoleBase", "optRoleBase", , IsRoleSelected, "1", , "onclick=javascript:OptRoleSkill_OnChange(1)", True))
            'tblHTML.Append(" Role Base &nbsp;&nbsp;&nbsp;&nbsp;")
            'tblHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("optRoleBase", "optRoleBase", , IsSkillSelected, "0", , "onclick=javascript:OptRoleSkill_OnChange(0)", True))
            'tblHTML.Append("Skill Base </td >")
            'End Comment by SanaS on 21-Oct-2009 
            tblHTML.Append("</tr></table><br>" + vbCrLf)

        ElseIf m_strMasterPK = "PASS2" Then

            tblHTML.Append("<br><table id='tblCaption' border = 0 width=100% cellspacing=0 cellpadding = 0 >" + vbCrLf)
            tblHTML.Append("<tr class=clsTRPageCaption><td>Resource Requests</td>" + vbCrLf)
            'Commented by SanaS on 21-Oct-2009 
            'tblHTML.Append("<td align=right> ")
            'tblHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("optRoleBase", "optRoleBase", , IsRoleSelected, "1", , "onclick=javascript:OptRoleSkill_OnChange(1)", True))
            'tblHTML.Append(" Role Base &nbsp;&nbsp;&nbsp;&nbsp;")
            'tblHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("optRoleBase", "optRoleBase", , IsSkillSelected, "0", , "onclick=javascript:OptRoleSkill_OnChange(0)", True))
            'tblHTML.Append("Skill Base </td >")
            'End Commented by SanaS on 21-Oct-2009 

            ''added by RohiniK on 30 Oct 09 for S1 Changes
            tblHTML.Append("<td align=right>Type</TD>")
            tblHTML.Append("<td align=Left' >")
            tblHTML.Append(CommonFunction.HTMLControls.DrawComboBox("optType", "select 'Demand' , 'Opportunity' union select 'Execution', 'Execution'", 100, m_TypeSelected, , True, True))
            tblHTML.Append("</td>")
            tblHTML.Append("<td align=right>Role</TD>")
            tblHTML.Append("<td align=Left >")
            tblHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRole", "usp_sel_Role_for_SearchResource", 200, m_strRoleID.ToString, , True, True))
            tblHTML.Append("</td>")
            tblHTML.Append("<td align=right>Skill</TD>")
            tblHTML.Append("<td align=Left >")
            tblHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSkill", " usp_sel_Skill_for_SearchResource", 200, m_strSkillID.ToString, , True, True))
            tblHTML.Append("</td>")
            tblHTML.Append("<td align=right><a href='Javascript:Apply_OnClick()'><B>Apply</B></a></TD>")
            tblHTML.Append("</TR>")
            ''End of addition by RohiniK on 30 Oct 09 for S1 Changes

            tblHTML.Append("</tr></table><br>" + vbCrLf)

        End If
        'End by SuchitraP

        tblHTML.Append("<DIV id=divList style=""width:100%;height:380;OverFlow:auto"" >")


        tblHTML.Append("<table style=""border-right: thin solid gray;border-bottom: thin solid gray;border-left: thin solid gray;border-top: thin solid gray""  id='tblMain' border = 0 width=100% cellspacing=0 cellpadding = 0 >" + vbCrLf)
        tblHTML.Append("<TR class='clsTRColumnHeader' style='FONT-WEIGHT:bold'  >")

        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        If m_PageType = PageType.PASS1 OrElse m_PageType = PageType.PASS2 Then
            tblHTML.Append("<TD style=""border-right: thin solid gray;border-bottom: thin solid gray"" id='Role' align=Left > Role </TD>" + vbCrLf)
            tblHTML.Append("<TD style=""border-right: thin solid gray;border-bottom: thin solid gray"" id='Role' align=Left > Skill </TD>" + vbCrLf)
            tblHTML.Append("<TD style=""border-right: thin solid gray;border-bottom: thin solid gray"" id='Role' align=Left > Requirement	</TD>" + vbCrLf)
        ElseIf m_PageType = PageType.OPPORTUNITY OrElse m_PageType = PageType.PROJECT_STAFFINGPLAN Then
            tblHTML.Append("<TD style=""border-right: thin solid gray;border-bottom: thin solid gray"" id='Role' align=Left > Role-Skill </TD>" + vbCrLf)
        End If
        ''''''''''''''''''''''''''''''''''''''

        ''''''''''''''''Drawing Table's Column  Headings
        ''''''''''''''''TR and First columns must be plotted before call this method. 
        ''''''''''''''''It plots only month name headings in TD.
        drawMonthNameHeadings(tblHTML)

        tblHTML.Append("</TR>" + vbCrLf)


        If m_PageType = PageType.OPPORTUNITY Then
            drRole = CommonFunctions.Data.GetDataReader("usp_sel_Role_GraphicalView  " + m_strMasterPK, MyBase.UseSQL)
        ElseIf m_PageType = PageType.PROJECT_STAFFINGPLAN Then
            drRole = CommonFunctions.Data.GetDataReader("usp_sel_TeamStructure_GraphicalView  " + m_strMasterPK, MyBase.UseSQL)
        ElseIf m_PageType = PageType.PASS1 Or m_PageType = PageType.PASS2 Then
            Dim BGID As String = "NULL"
            Dim OUID As String = "NULL"
            Dim SkillID As String = "NULL"
            Dim RoleID As String = "NULL"

            If Not Request.Form("cboBG") Is Nothing AndAlso Request.Form("cboBG") <> "" Then
                BGID = Request.Form("cboBG")
            End If
            If Not Request.Form("cboOU") Is Nothing AndAlso Request.Form("cboOU") <> "" Then
                OUID = Request.Form("cboOU")
            End If
            If Not Request.Form("cboRole") Is Nothing AndAlso Request.Form("cboRole") <> "" Then
                RoleID = Request.Form("cboRole")
            End If
            If Not Request.Form("cboSkill") Is Nothing AndAlso Request.Form("cboSkill") <> "" Then
                SkillID = Request.Form("cboSkill")
            End If

            Select Case m_PageType
                Case PageType.PASS1
                    If IsRoleBase = "0" Then
                        drRole = CommonFunctions.Data.GetDataReader("usp_Sel_GraphicalView_PassI " + YearIncrement.ToString + "," + BGID + "," + OUID + "," + RoleID + "," + SkillID + "," + Session("intUserID").ToString, MyBase.UseSQL)
                    Else
                        drRole = CommonFunctions.Data.GetDataReader("usp_Sel_GraphicalView_PassI_RoleBase " + YearIncrement.ToString + "," + BGID + "," + OUID + "," + RoleID + "," + SkillID + "," + Session("intUserID").ToString, MyBase.UseSQL)
                    End If

                Case PageType.PASS2
                    If IsRoleBase = "0" Then
                        ''commented and added by RohiniK on 28 Oct 09 for S1 changes
                        'drRole = CommonFunctions.Data.GetDataReader("usp_Sel_GraphicalView_PassII " + YearIncrement.ToString + "," + BGID + "," + OUID + "," + RoleID + "," + SkillID + "," + Session("intUserID").ToString, MyBase.UseSQL)
                        Dim strSQL As String = ""

                        'If RoleID = "," Then
                        '    RoleID = "NULL"
                        'End If

                        'If SkillID = "," Then
                        '    SkillID = "NULL"
                        'End If


                        If m_TypeSelected <> "" Then
                            strSQL = "usp_Sel_GraphicalView_PassII " + YearIncrement.ToString + "," + BGID + "," + OUID + "," + RoleID + "," + SkillID + "," + Session("intUserID").ToString + ",'" + m_TypeSelected + "'"
                        Else
                            strSQL = "usp_Sel_GraphicalView_PassII " + YearIncrement.ToString + "," + BGID + "," + OUID + "," + RoleID + "," + SkillID + "," + Session("intUserID").ToString
                        End If


                        drRole = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                        ''End of comment and addition by RohiniK on 28 Oct 09 for S1 changes
                    Else
                        drRole = CommonFunctions.Data.GetDataReader("usp_Sel_GraphicalView_PassII_RoleBase " + YearIncrement.ToString + "," + BGID + "," + OUID + "," + RoleID + "," + SkillID + "," + Session("intUserID").ToString, MyBase.UseSQL)
                    End If

            End Select

        End If



        While drRole.Read()
            If m_PageType = PageType.OPPORTUNITY Then
                strRecPKID = CType(drRole("PipeLineID"), String)
                strFirstColumnHTML = CType(drRole("Role"), String) + " <BR> " + CType(drRole("Skill"), String)
                Record_StartDt = CType(drRole("TentativeStartDate"), Date)
                Record_EndDt = CType(drRole("TentativeEndDate"), Date)
            ElseIf m_PageType = PageType.PROJECT_STAFFINGPLAN Then
                strRecPKID = CType(drRole("TeamStructureID"), String)
                strFirstColumnHTML = CType(drRole("Role"), String) + " <BR> " + CType(drRole("Skill"), String)
                Record_StartDt = CType(drRole("TentativeStartDate"), Date)
                Record_EndDt = CType(drRole("TentativeEndDate"), Date)
                IsFreezed = CType(drRole("IsFreezed"), Boolean)
                strIsFreezed = strIsFreezed + CType(IsFreezed, String) + ","
            ElseIf m_PageType = PageType.PASS1 Then
                strRecPKID = CType(drRole("UniqueID"), String)
                Record_StartDt = CType(drRole("TentativeStartDate"), Date)
                Record_EndDt = CType(drRole("TentativeEndDate"), Date)
                strFirstColumnHTML = CType(drRole("Role"), String)
                strSecondColumnHTML = CType(drRole("Skill"), String)

                strCheckBoxForPass_value = CType(drRole("Type"), String)
                If strCheckBoxForPass_value.ToUpper = "DEMAND" Then
                    strCheckBoxForPass_value = "D|" + strRecPKID + "|" + CType(drRole("RoleID"), String) + "|" + CType(drRole("ToolID"), String) + "|" + CType(drRole("PK"), String)
                ElseIf strCheckBoxForPass_value.ToUpper = "EXECUTION" Then
                    strCheckBoxForPass_value = "P|" + strRecPKID + "|" + CType(drRole("RoleID"), String) + "|" + CType(drRole("ToolID"), String) + "|" + CType(drRole("PK"), String)
                End If

            ElseIf m_PageType = PageType.PASS2 Then
                strRecPKID = CType(drRole("UniqueID"), String)
                Record_StartDt = CType(drRole("TentativeStartDate"), Date)
                Record_EndDt = CType(drRole("TentativeEndDate"), Date)
                strFirstColumnHTML = CType(drRole("Role"), String)
                strSecondColumnHTML = CType(drRole("Skill"), String)

                strCheckBoxForPass_value = CType(drRole("Type"), String)
                If strCheckBoxForPass_value.ToUpper = "DEMAND" Then
                    strCheckBoxForPass_value = "D|" + strRecPKID + "|" + CType(drRole("RoleID"), String) + "|" + CType(drRole("ToolID"), String) + "|" + CType(drRole("PK"), String)
                ElseIf strCheckBoxForPass_value.ToUpper = "EXECUTION" Then
                    strCheckBoxForPass_value = "P|" + strRecPKID + "|" + CType(drRole("RoleID"), String) + "|" + CType(drRole("ToolID"), String) + "|" + CType(drRole("PK"), String)
                End If

            End If


            If strClass = "clsTROdd" Then
                strClass = "clsTREven"
            Else
                strClass = "clsTROdd"
            End If


            If m_PageType = PageType.PASS1 OrElse m_PageType = PageType.PASS2 Then
                Dim Title As String
                Dim TT_Title As String
                Title = drRole("Title").ToString
                If drRole("Type").ToString = "Execution" Then
                    TT_Title = "Project : " + Title
                    'Addition by SuchitraP on 18-Nov-2008 for Resource Demand Changes
                    strType = "Execution"
                    'End by SuchitraP
                Else
                    TT_Title = "Resource Opportunity : " + Title
                    'Addition by SuchitraP on 18-Nov-2008 for Resource Demand Changes
                    strType = "Demand"
                    'End by SuchitraP
                End If

                If Title.Length > 25 Then
                    Title = Title.Substring(0, 22) + "..."
                End If

                'Addition by SuchitraP on 18-Nov-2008 for Resource Demand Changes
                If strType = "Execution" Then
                    Title = Title + " [Project]"
                Else
                    Title = Title + " [Opportunity]"
                End If
                'End by SuchitraP

                If strFirstColumnHTML_hold <> strFirstColumnHTML Then 'strFirstColumnHTML_hold = "" OrElse 

                    tblHTML.Append("<TR class=clsTRGroupheader >")
                    tblHTML.Append("<TD colspan=15> " + strFirstColumnHTML + " </TD> </TR>" + vbCrLf)
                    tblHTML.Append("<TR class='clsTRGroupheader' >")

                    If IsRoleBase = "0" Then
                        tblHTML.Append("<TD></TD><TD colspan=14>  " + strSecondColumnHTML + " </TD>" + vbCrLf)
                    End If

                    'This TR has vertical bars, so putting vertIndex property
                    tblHTML.Append("<TR vertIndex=" + vertIndex.ToString + " class='" + strClass + "' onmouseover=""showToolTip(this,event)"" onmouseout=""hideToolTip(this,event)"" >")
                    vertIndex += 1
                    ''commented and added by RohiniK on 30 Oct 09 for S1 Changes
                    'tblHTML.Append("<TD colspan=2 ><input type=checkbox id=chkSelect name=chkSelect onclick='chkSelect_onclick(this)' class='clsCheckBox' value='" + strCheckBoxForPass_value + "' >")
                    ''Comment and modification by SuchitraP on 19-Nov-2008 for Resource Demand Changes
                    'tblHTML.Append("<A href='Javascript:Forecast_OnClick()' ><Img onmouseover=ChangeRefreshEnabledImg(this,event) onmouseout=ChangeRefreshDisabledImg(this,event) name=refImg  id=refImg border=0 src='../../images/RefreshDisabled.gif' title='Refresh Forecast' style='visibility: hidden' ></A>")
                    'tblHTML.Append("<A href='Javascript:Forecast_OnClick()' ><Img onmouseover=ChangeRefreshEnabledImg(this,event) onmouseout=ChangeRefreshDisabledImg(this,event) name=refImg  id=refImg border=0 src='../../images/search_img.gif' title='search' style='visibility: hidden' ></A>")
                    'End by SuchitraP
                    tblHTML.Append("</TD>")

                    tblHTML.Append("<TD colspan=2>")
                    tblHTML.Append("<input type=checkbox id=chkSelect name=chkSelect style='visibility: hidden' onclick='chkSelect_onclick(this)' class='clsCheckBox' value='" + strCheckBoxForPass_value + "' >")
                    tblHTML.Append("<A href='Javascript:Search_OnClick(this,""" & strCheckBoxForPass_value & """)' >Search</A>")
                    tblHTML.Append("</TD>")

                    ''End of comment and addition by RohiniK on 30 Oct 09 for S1 Changes
                    tblHTML.Append("<TD style='text-align:left;padding-right: 2pt;' title=""" + TT_Title + """ >" + Title + "</TD>" + vbCrLf)

                ElseIf strFirstColumnHTML_hold = strFirstColumnHTML Then
                    If strSecondColumnHTML_hold <> strSecondColumnHTML Then
                        tblHTML.Append("<TR class='clsTRGroupheader' >")
                        tblHTML.Append("<TD></TD><TD colspan=14>  " + strSecondColumnHTML + " </TD>" + vbCrLf)
                        'This TR has vertical bars, so putting vertIndex property
                        tblHTML.Append("<TR vertIndex=" + vertIndex.ToString + " class='" + strClass + "' onmouseover=""showToolTip(this,event)"" onmouseout=""hideToolTip(this,event)"" >")
                        vertIndex += 1
                        ''commented and added by RohiniK on 30 Oct 09 for S1 Changes
                        'tblHTML.Append("<TD colspan=2><input type=checkbox id=chkSelect name=chkSelect onclick='chkSelect_onclick(this)' class='clsCheckBox' value='" + strCheckBoxForPass_value + "' >")
                        'tblHTML.Append("<A href='Javascript:Forecast_OnClick()' ><Img onmouseover=ChangeRefreshEnabledImg(this,event) onmouseout=ChangeRefreshDisabledImg(this,event) name=refImg id=refImg border=0 src='../../images/search_img.gif' title='search' style='visibility: hidden' ></A>")
                        'tblHTML.Append("</TD>")

                        tblHTML.Append("<TD colspan=2>")
                        tblHTML.Append("<input type=checkbox id=chkSelect name=chkSelect style='visibility: hidden' onclick='chkSelect_onclick(this)' class='clsCheckBox' value='" + strCheckBoxForPass_value + "' >")
                        tblHTML.Append("<A href='Javascript:Search_OnClick(this,""" & strCheckBoxForPass_value & """)' >Search</A>")
                        tblHTML.Append("</TD>")

                        ''End of comment and addition by RohiniK on 30 Oct 09 for S1 Changes
                        tblHTML.Append("<TD style='text-align:left;padding-right: 2pt;' title=""" + TT_Title + """ >" + Title + "</TD>" + vbCrLf)
                    Else
                        'This TR has vertical bars, so putting vertIndex property
                        tblHTML.Append("<TR vertIndex=" + vertIndex.ToString + " class='" + strClass + "' onmouseover=""showToolTip(this,event)"" onmouseout=""hideToolTip(this,event)"" >")
                        vertIndex += 1
                        ''commented and added by RohiniK on 30 Oct 09 for S1 Changes
                        'tblHTML.Append("<TD colspan=2><input type=checkbox id=chkSelect name=chkSelect onclick='chkSelect_onclick(this)' class='clsCheckBox' value='" + strCheckBoxForPass_value + "' >")
                        'tblHTML.Append("<A href='Javascript:Forecast_OnClick()' ><Img onmouseover=ChangeRefreshEnabledImg(this,event) onmouseout=ChangeRefreshDisabledImg(this,event) name=refImg id=refImg border=0 src='../../images/search_img.gif' title='search' style='visibility: hidden' ></A>")
                        'tblHTML.Append("</TD>")

                        tblHTML.Append("<TD colspan=2>")
                        tblHTML.Append("<input type=checkbox id=chkSelect name=chkSelect style='visibility: hidden' onclick='chkSelect_onclick(this)' class='clsCheckBox' value='" + strCheckBoxForPass_value + "' >")
                        tblHTML.Append("<A href='Javascript:Search_OnClick(this,""" & strCheckBoxForPass_value & """)' >Search</A>")
                        tblHTML.Append("</TD>")
                        ''End of comment and addition by RohiniK on 30 Oct 09 for S1 Changes
                        tblHTML.Append("<TD style='text-align:left;padding-right: 2pt;' title=""" + TT_Title + """ >" + Title + "</TD>" + vbCrLf)
                    End If
                End If
                strFirstColumnHTML_hold = strFirstColumnHTML
                strSecondColumnHTML_hold = strSecondColumnHTML

            Else
                'This TR has vertical bars, so putting vertIndex property
                'Putting Right Tooltip text as attribute RTooltip, same for LTooltip

                tblHTML.Append("<TR vertIndex=" + vertIndex.ToString + " class='" + strClass + "' onmouseover=""showToolTip(this,event)"" onmouseout=""hideToolTip(this,event)"" >")
                tblHTML.Append("<TD > " + strFirstColumnHTML + " </TD>" + vbCrLf)
                vertIndex += 1
            End If




            strMonthStartIDs = ""
            strMonthEndIDs = ""

            ''''''''''''''Drawing Table's row ( from Jan to Dec ) as gantt/progress. Plotting only TD's 
            ''''''''''''''TR must start with First columns before call this function
            'drawMonths(strRecPKID, Record_StartDt, Record_EndDt, GantView_StartDt.Year, tblHTML)
            objGanttChart_Month = New cGanttChart_Month(GantView_StartDt, GantView_EndDt, MonDiff, strRecPKID, tblHTML)
            arrStartDates_MonthWise = New ArrayList(1)
            arrEndDates_MonthWise = New ArrayList(1)
            arrStartDates_MonthWise.Add(Record_StartDt)
            arrEndDates_MonthWise.Add(Record_EndDt)
            objGanttChart_Month.PlottingStartDates = arrStartDates_MonthWise
            objGanttChart_Month.PlottingEndDates = arrEndDates_MonthWise
            objGanttChart_Month.drawMonthGantt(False)

            objGanttChart_Month = Nothing
            arrStartDates_MonthWise = Nothing
            arrEndDates_MonthWise = Nothing

            If Record_EndDt >= GantView_StartDt And Record_EndDt <= GantView_EndDt Then
                arrRVerticals = arrRVerticals + strRecPKID + "|" + Record_EndDt.Month.ToString + "|" + Record_EndDt.Day.ToString + ","
            Else
                arrRVerticals = arrRVerticals + "0,"
            End If

            If Record_StartDt >= GantView_StartDt And Record_StartDt <= GantView_EndDt Then
                arrLVerticals = arrLVerticals + strRecPKID + "|" + Record_StartDt.Month.ToString + "|" + Record_StartDt.Day.ToString + ","
            Else
                arrLVerticals = arrLVerticals + "0,"
            End If
            If m_PageType = PageType.PROJECT_STAFFINGPLAN Then
                strVertLeftLBs = strVertLeftLBs + strRecPKID + "|" + Record_StartDt.Month.ToString + "|" + Record_StartDt.Day.ToString + ","
            Else
                strVertLeftLBs = strVertLeftLBs + strRecPKID + "|" + GantView_StartDt.Month.ToString + "|" + GantView_StartDt.Day.ToString + ","
            End If
            If m_PageType <> PageType.OPPORTUNITY Then
                RB_validateDT = GantView_EndDt
            Else
                If Not (RB_validateDT <= GantView_EndDt And RB_validateDT >= GantView_StartDt) Then
                    RB_validateDT = GantView_EndDt
                End If

            End If
            strVertRightRBs = strVertRightRBs + strRecPKID + "|" + RB_validateDT.Month.ToString + "|" + RB_validateDT.Day.ToString + ","


            'Hidden Controls 
            'strRecPKID, strRoleID, strSkillID
            hidRecPKIDs = hidRecPKIDs + strRecPKID + ","
            tblHTML.Append("<input type=hidden name='L|" + strRecPKID + "' id='L|" + strRecPKID + "' value='" + Record_StartDt.ToString("dd-MMM-yyyy") + "' >")
            tblHTML.Append("<input type=hidden name='R|" + strRecPKID + "' id='R|" + strRecPKID + "' value='" + Record_EndDt.ToString("dd-MMM-yyyy") + "' >")

            tblHTML.Append("</TR>" + vbCrLf)
        End While
        'End of While loop

        CommonFunction.Data.DisposeDataReader(drRole)

        'Hiiden control for Pipeline IDs
        tblHTML.Append("<input type=hidden name=hidPKID value='" + hidRecPKIDs + "' >")
        tblHTML.Append("</Table>" + vbCrLf)
        tblHTML.Append("</DIV>" + vbCrLf)


        If m_PageType = PageType.PASS1 Then
            DrawForeCastSectionPass1()
        ElseIf m_PageType = PageType.PASS2 Then
            DrawForeCastSectionPass2()
        End If

        strMenuHTML = GenerateMenu(False)

        tblHTML.Append(strMenuHTML + vbCrLf)

        'If arrRVerticals <> "" OrElse Not arrRVerticals Is Nothing Then
        arrRightVerticals = arrRVerticals.Split(","c)
        arrLeftVerticals = arrLVerticals.Split(","c)
        arrVertLeftLB = strVertLeftLBs.Split(","c)
        arrVertRightRB = strVertRightRBs.Split(","c)

        arrIsFreezed = strIsFreezed.Split(","c)

        Dim arrCnt As Integer

        CommonFunctions.General.WriteHTML(tblHTML.ToString())
        CommonFunction.General.WriteHTML("<script>")
        CommonFunction.General.WriteHTML("var arrVertRight = new Array();")
        CommonFunction.General.WriteHTML("var arrVertLeft = new Array();")
        CommonFunction.General.WriteHTML("var arrVertLeftLB = new Array();")
        CommonFunction.General.WriteHTML("var arrVertRightRB = new Array();")

        For arrCnt = 0 To arrRightVerticals.Length - 2
            CommonFunction.General.WriteHTML("arrVertRight[" + CType(arrCnt, String) + "]=""" + arrRightVerticals(arrCnt) + """;")
            CommonFunction.General.WriteHTML("arrVertLeft[" + CType(arrCnt, String) + "]=""" + arrLeftVerticals(arrCnt) + """;")
            CommonFunction.General.WriteHTML("arrVertLeftLB[" + CType(arrCnt, String) + "]=""" + arrVertLeftLB(arrCnt) + """;")
            CommonFunction.General.WriteHTML("arrVertRightRB[" + CType(arrCnt, String) + "]=""" + arrVertRightRB(arrCnt) + """;")

        Next

        CommonFunction.General.WriteHTML("var GantViewEndMon=" + GantView_EndDt.Month.ToString + ";")
        CommonFunction.General.WriteHTML("var GantViewEndDay=" + DateTime.DaysInMonth(GantView_EndDt.Year, GantView_EndDt.Month).ToString + ";")
        CommonFunction.General.WriteHTML("var GantViewStartDay=1;")
        CommonFunction.General.WriteHTML("var GantViewStartMon=" + GantView_StartDt.Month.ToString + ";")

        CommonFunction.General.WriteHTML("</script>")

        If m_PageType = PageType.PROJECT_STAFFINGPLAN Then
            For arrCnt = 0 To arrRightVerticals.Length - 2
                If arrIsFreezed(arrCnt) = False Then
                    CommonFunction.General.WriteHTML("<div id='verL" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 2px blue' onmousedown=""clickDownVert(event)""></div>")
                    CommonFunction.General.WriteHTML("<div id='verR" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 2px blue' onmousedown=""clickDownVert(event)""></div>")
                Else
                    CommonFunction.General.WriteHTML("<div id='verL" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 2px blue' ></div>")
                    CommonFunction.General.WriteHTML("<div id='verR" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 2px blue' ></div>")
                End If
            Next
        Else
            For arrCnt = 0 To arrRightVerticals.Length - 2
                CommonFunction.General.WriteHTML("<div id='verL" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 2px blue' onmousedown=""clickDownVert(event)""></div>")
                CommonFunction.General.WriteHTML("<div id='verR" + arrCnt.ToString + "' style='cursor:e-resize;position:absolute;top:1px;left:1px;height:1x;width:1px;font-size:1px;border-left:groove 2px blue' onmousedown=""clickDownVert(event)""></div>")
            Next
        End If


        tblHTML = Nothing

    End Sub

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    Private Sub Save()
        Dim RowCnt As Integer
        Dim startDate As String
        Dim EndDate As String
        Dim UpdateQuery As String
        Dim hidPKIDs As String
        Dim arrPKIDs As String()
        Dim strSQL As String
        Dim dr As IDataReader

        hidPKIDs = Request.Form("hidPKID")

        If hidPKIDs Is Nothing OrElse hidPKIDs = "" Then
            Exit Sub
        End If

        RowCnt = 0
        arrPKIDs = hidPKIDs.Split(","c)
        While RowCnt <= arrPKIDs.Length - 2
            startDate = Request.Form("L|" + arrPKIDs(RowCnt))
            EndDate = Request.Form("R|" + arrPKIDs(RowCnt))
            If m_PageType = PageType.OPPORTUNITY And startDate <> "DONTSAVE" Then
                'If Not Request.QueryString("OpportunityID") Is Nothing And startDate <> "DONTSAVE" Then

                UpdateQuery = "UPDATE tbl_RM_Pipeline SET TentativeStartDate='" + startDate + "', TentativeEndDate='" + EndDate + "' WHERE PipelineID=" + arrPKIDs(RowCnt)

                CommonFunctions.Data.InsertOrUpdateData(UpdateQuery, MyBase.UseSQL)


                strSQL = "usp_Ins_tbl_RM_Pipeline_Distribution " + arrPKIDs(RowCnt) + ",'" + startDate + "'"
                strSQL += ",'" + EndDate + "'"
                CommonFunction.Data.InsertOrUpdateData(strSQL, True)


                strSQL = "UPDATE tbl_RM_SoftBooking SET ResourceInDate='" + startDate + "'"
                strSQL += ",ResourceOutDate ='" + EndDate + "'"
                strSQL += " WHERE PipelineID =" + arrPKIDs(RowCnt)
                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                '' dr = CommonFunction.Data.GetDataReader("select BookingID from tbl_RM_SoftBooking where PipeLineID = " + arrPKIDs(RowCnt), MyBase.UseSQL)
                dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_RM_SoftBooking " + arrPKIDs(RowCnt), MyBase.UseSQL)
                ''end of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                While dr.Read
                    CommonFunction.Data.InsertOrUpdateData("usp_Ins_tbl_RM_SoftBooking_Distribution " + dr("BookingID").ToString + ",'" + startDate + "','" + EndDate + "'", MyBase.UseSQL)
                End While
                CommonFunction.Data.DisposeDataReader(dr)
                'ElseIf Not Request.QueryString("ProjectID") Is Nothing And startDate <> "DONTSAVE" Then
            ElseIf m_PageType = PageType.PROJECT_STAFFINGPLAN And startDate <> "DONTSAVE" Then
                UpdateQuery = " usp_Upd_tbl_PM_TeamStructure_GraphicalView " + arrPKIDs(RowCnt) + ",'" + startDate + "','" + EndDate + "'"

                CommonFunctions.Data.InsertOrUpdateData(UpdateQuery, MyBase.UseSQL)

                strSQL = "usp_Ins_tbl_PM_TeamStructure_Distribution " + arrPKIDs(RowCnt) + ",'" + startDate + "'"
                strSQL += ",'" + EndDate + "'"
                CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            End If




            RowCnt = RowCnt + 1

        End While
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        'Addition by SuchitraP on 17-Dec-2008 for Showing Save,Add and SaveAndClose links only when opportunity is not closed
        Dim strSQL As String
        Dim IsOpen As Boolean = False
        'End by SuchitraP on 17-Dec-2008

        Select Case m_PageType
            Case PageType.OPPORTUNITY

                Select Case Args.LinkName.ToUpper
                    Case "PREVIOUS"
                        If Not (MonDiff > 12 And YearIncrement > 0) Then Cancel = True
                    Case "NEXT"
                        If Not (MonDiff > 12 And ((YearIncrement + 1) * 12) <= MonDiff) Then Cancel = True
                    Case "FORECAST"
                        Cancel = True
                    Case "ADD"
                        If m_AddAccess = False Then
                            Cancel = True
                        End If
                        'Addition by SuchitraP on 17-Dec-2008 for Showing Save,Add and SaveAndClose links only when opportunity is not closed
                        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                        ''strSQL = "SELECT 1 FROM tbl_RM_Opportunity INNER JOIN tbl_CNF_OpportunityStatus OS ON tbl_RM_Opportunity.StatusID = OS.OpportunityStatusID AND ISNULL(MapToReadyForClosure,0) = 0 WHERE OpportunityID = " + m_strMasterPK '+ Request.QueryString("OpportunityID")
                        strSQL = "usp_sel_OpportunityID_tbl_RM_Opportunity " + m_strMasterPK '+ Request.QueryString("OpportunityID")
                        ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                        IsOpen = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, True), "0")
                        If IsOpen = False Then
                            Cancel = True
                        End If
                    Case "SAVE", "SAVE AND CLOSE"
                        If m_EditAccess = False Then
                            Cancel = True
                        End If
                        'Addition by SuchitraP on 17-Dec-2008 for Showing Save,Add and SaveAndClose links only when opportunity is not closed
                        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                        ''strSQL = "SELECT 1 FROM tbl_RM_Opportunity INNER JOIN tbl_CNF_OpportunityStatus OS ON tbl_RM_Opportunity.StatusID = OS.OpportunityStatusID AND ISNULL(MapToReadyForClosure,0) = 0 WHERE OpportunityID = " + m_strMasterPK '+ Request.QueryString("OpportunityID")
                        strSQL = "usp_sel_OpportunityID_tbl_RM_Opportunity " + m_strMasterPK '+ Request.QueryString("OpportunityID")
                        ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                        IsOpen = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, True), "0")
                        If IsOpen = False Then
                            Cancel = True
                        End If
                    Case "PROJECT ALLOCATION"
                        Cancel = True


                End Select
            Case PageType.PROJECT_STAFFINGPLAN
                Select Case Args.LinkName.ToUpper
                    Case "PREVIOUS"
                        If Not (MonDiff > 12 And YearIncrement > 0) Then Cancel = True
                    Case "NEXT"
                        If Not (MonDiff > 12 And ((YearIncrement + 1) * 12) <= MonDiff) Then Cancel = True
                    Case "FORECAST"
                        Cancel = True
                    Case "ADD"
                        Cancel = True
                    Case "SAVE", "SAVE AND CLOSE"
                        If m_EditAccess = False Then Cancel = True
                    Case "PROJECT ALLOCATION"
                        Cancel = True

                End Select
            Case PageType.PASS1
                Select Case Args.LinkName.ToUpper
                    Case "SAVE", "ADD", "SAVE AND CLOSE", "CLOSE"
                        Cancel = True
                    Case "PROJECT ALLOCATION"
                        Cancel = True

                End Select
            Case PageType.PASS2
                Select Case Args.LinkName.ToUpper
                    Case "SAVE", "ADD", "SAVE AND CLOSE", "CLOSE"
                        Cancel = True

                End Select

        End Select

    End Sub

    Private Sub DrawForeCastSectionPass1()
        'Dim ForcastSectionTitle As WebPages.UI.cSectionTitle = New WebPages.UI.cSectionTitle

        tblHTML.Append("<div id=divForecast style='OVERFLOW:auto;DISPLAY:none;BORDER-COLOR:#35afe8;BORDER-STYLE:groove;WIDTH:80%;POSITION:absolute;Z-INDEX:19000'>")
        'tblHTML.Append(ForcastSectionTitle.DrawSectionTitle("Forecast", "View </TD><TD>" + CommonFunction.HTMLControls.DrawComboBox("cboForecast", "SELECT 'Joining Pool','Joining Pool' UNION SELECT 'Training','Training' UNION SELECT 'On Bench','On Bench'", , , " onChange=ForeCastView_onChange() ", True, True) + "</TD>") + vbCrLf)
        tblHTML.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable >")
        'tblHTML.Append("<TR class= clsTRSectionHeader ><TD align=Left>Forecast</TD><TD align=Right>View </TD>")
        tblHTML.Append("<TR class= clsTRSectionHeader ><TD align=Left>&nbsp;</TD><TD align=Right>&nbsp; </TD>")
        'tblHTML.Append("<TD>")
        'tblHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboForecast", "SELECT 'Bench','On Bench',1 UNION SELECT 'Train','Training',2 UNION SELECT 'Join','Joining Pool',3 ORDER BY 3 ", , , " onChange=ForeCastView_onChange() ", True, True))
        'tblHTML.Append("</TD>")
        'Added by SanaS on 17-Sep-2009 for adding Role and Skill Filters
        tblHTML.Append("<TD align=Right>Role</TD>")
        tblHTML.Append("<TD>")
        tblHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboRolePass2", "usp_sel_Role_for_SearchResource", , m_strRoleID.ToString, " onChange=ForeCastView_onChange() ", False, True))
        tblHTML.Append("</TD>")
        tblHTML.Append("<TD align=Right>Skill</TD>")
        tblHTML.Append("<TD>")
        tblHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboSkillPass2", "usp_sel_Skill_for_SearchResource", , m_strSkillID.ToString, " onChange=ForeCastView_onChange() ", True, True))
        tblHTML.Append("</TD>")

        'End Addition by SanaS on 17-Sep-2009 for adding Role and Skill Filters

        tblHTML.Append("<td align=right><a href ='Javascript:ForeCast_onClose()'><img border=0 src = '../../Images/RM/Close.gif' > </a>")
        tblHTML.Append("</TR></TABLE>")

        'tblHTML.Append("<BR>")
        tblHTML.Append("<DIV id=secForecast >" + vbCrLf)
        'tblHTML.Append("<Table width=99.9% class=clsGridTable ><THead class='clsTRColumnHeader'>" + vbCrLf)
        'tblHTML.Append("<TH align=left width=30%>Resource Name </TH><TH align=left width=30% > Role</TH>" + vbCrLf)
        'tblHTML.Append("<TH align=right width=10% >Total Exp (Yrs)</TH><TH align=left width=15%   >Primary Skills</TH>")
        'tblHTML.Append("<TH align=left width=15%  >Other Skills</TH>")
        'tblHTML.Append("</THead>")
        'tblHTML.Append("</Table>")

        tblHTML.Append("</DIV>")

        tblHTML.Append("</DIV>")


    End Sub
    Private Sub DrawForeCastSectionPass2()

        tblHTML.Append("<div id=divForecast style='OVERFLOW:auto;DISPLAY:none;BORDER-COLOR:#35afe8;BORDER-STYLE:groove;WIDTH:90%;POSITION:absolute;Z-INDEX:19000'>")
        'tblHTML.Append(ForcastSectionTitle.DrawSectionTitle("Forecast", "View </TD><TD>" + CommonFunction.HTMLControls.DrawComboBox("cboForecast", "SELECT 'Joining Pool','Joining Pool' UNION SELECT 'Training','Training' UNION SELECT 'On Bench','On Bench'", , , " onChange=ForeCastView_onChange() ", True, True) + "</TD>") + vbCrLf)
        tblHTML.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable >")
        ' tblHTML.Append("<TR class= clsTRSectionHeader ><TD align=Left>Forecast</TD><TD align=Right>Project Commercial Details</TD>")
        tblHTML.Append("<TR class= clsTRSectionHeader ><TD align=Left>&nbsp;</TD><TD align=Right>Project Commercial Details</TD>")
        tblHTML.Append("<TD>")
        tblHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboForecast", "usp_Sel_GetContractTypes", , , " onChange=ForeCastView_onChange() ", True, True))
        tblHTML.Append("</TD>")
        'Added by SanaS on 17-Sep-2009 for adding Role and Skill Filters
        tblHTML.Append("<TD align=Right>Role</TD>")
        tblHTML.Append("<TD>")
        tblHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboRolePass2", "usp_sel_Role_for_SearchResource", 200, m_strRoleID.ToString, " onChange=ForeCastView_onChange() ", False, True))
        tblHTML.Append("</TD>")
        tblHTML.Append("<TD align=Right>Skill</TD>")
        tblHTML.Append("<TD>")
        tblHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboSkillPass2", "usp_sel_Skill_for_SearchResource", 200, m_strSkillID.ToString, " onChange=ForeCastView_onChange() ", True, True))
        tblHTML.Append("</TD>")

        'End Addition by SanaS on 17-Sep-2009 for adding Role and Skill Filters
        tblHTML.Append("<td align=right><a href ='Javascript:ForeCast_onClose()'><img border=0 src = '../../Images/RM/Close.gif' > </a>")
        tblHTML.Append("</TR></TABLE>")
        ''added by RohiniK on 16 Oct 09 for S1 Changes
        tblHTML.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable >")
        tblHTML.Append("<TR class= clsTRSectionHeader align=right>")
        tblHTML.Append("<TD align=right width=20%>Legends </TD>")
        tblHTML.Append("<TD align=right width=5% height=1px bgcolor=red nowrap></TD><TD align=left width=15% nowrap>Opportunity Period</TD>")
        tblHTML.Append("<TD align=right width=5%  height=1px bgcolor=green></TD><TD align=left width=15% nowrap>On Bench</TD>")
        tblHTML.Append("<TD align=right width=5%  height=1px bgcolor=blue></TD><TD align=left width=15% nowrap>Available Period</TD>")
        tblHTML.Append("<TD align=right width=5% height=1px bgcolor=red nowrap></TD><TD align=left width=15% nowrap>Project Allocation</TD>")
        tblHTML.Append("</TR></TABLE>")
        ''End of addition by RohiniK on 16 Oct 09 for S1 Changes
        'tblHTML.Append("<BR>")
        tblHTML.Append("<DIV id=secForecast >" + vbCrLf)


        tblHTML.Append("</DIV>")

        tblHTML.Append("</DIV>")


    End Sub
    Private Sub GenerateForeCastSectionPass1()
        Dim StartDate As String
        Dim EndDate As String
        Dim Type As String = ""
        Dim RoleID As String
        Dim SkillID As String
        Dim strCssClass As String = "clsTREven"
        Dim Type_Hold As String = ""
        Dim strSkills As String
        Dim strOtherSkills As String
        Dim strFromDate As String
        Dim strToDate As String
        Dim IsDorP As String
        Dim PK As String
        Dim strRecPKID As String

        Dim Record_StartDt As Date
        Dim Record_EndDt As Date

        Dim TT_StartDt As ArrayList
        Dim TT_EndDt As ArrayList
        Dim TT_HTML As String

        Dim strClass As String = "clsTREven"
        Dim strFirstColumnHTML_hold As String
        Dim strFirstColumnHTML As String

        Dim objGanttChart_Month As cGanttChart_Month
        Dim arrStartDates_MonthWise As ArrayList
        Dim arrEndDates_MonthWise As ArrayList

        Dim objStrB As System.Text.StringBuilder = New System.Text.StringBuilder

        IsDorP = Request.QueryString("IsDorP")
        Type = Request.QueryString("Type")
        StartDate = Request.QueryString("SD")
        EndDate = Request.QueryString("ED")
        RoleID = Request.QueryString("RoleID")
        SkillID = Request.QueryString("SkillID")
        PK = Request.QueryString("PK")

        Dim strSQL As String
        Dim dr As IDataReader


        Dim P_OR_D_PK As String
        Dim Pipe_OR_Team_PK As String
        Dim strTitle As String
        Dim strRole As String
        Dim strSkill As String

        Dim strMainSQL As String
        Dim drMain As IDataReader

        strMainSQL = "usp_Sel_ForeCast_PassI_MainRecord " + PK + ",'" + StartDate + "','" + EndDate + "'," + RoleID + "," + SkillID + ",'" + IsDorP + "'," + Session("intUserID").ToString + "," + IsRoleBase

        drMain = CommonFunction.Data.GetDataReader(strMainSQL, MyBase.UseSQL)

        If drMain.Read() Then
            strTitle = CType(drMain("Title"), String)
            strRole = CType(drMain("RoleDescription"), String)
            If IsRoleBase = 0 Then
                strSkill = CType(drMain("Skill"), String)
            End If
            P_OR_D_PK = CType(drMain("P_OR_D_PK"), String)
            Pipe_OR_Team_PK = CType(drMain("Pipe_OR_Team_PK"), String)
        End If
        CommonFunction.Data.DisposeDataReader(drMain)
        'If Type = "" Or Type = "Train" Or Type = "Bench" Then
        '    strSQL = "usp_Sel_Forecast_PassI '" + Type + "','" + StartDate + "','" + EndDate + "'," + RoleID + "," + SkillID + ",'BT'," + Session("intUserID").ToString + "," + P_OR_D_PK + "," + Pipe_OR_Team_PK + "," + IsDorP

        '    dr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        '    Response.Write("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable >")
        '    Response.Write("<TR class= clsTRSectionHeader ><TD align=Left>On Bench and Training Resources</TD>")
        '    Response.Write("</TR></TABLE>")

        '    Response.Write("<Table width=99.9% class=clsGridTable ><THead class='clsTRColumnHeader'>" + vbCrLf)
        '    'Response.Write("<TH></TH><TH align=left width=20% >Resource Name </TH><TH align=left width=10% >&nbsp;</TH><TH align=left width=20% > Role</TH>" + vbCrLf)
        '    Response.Write("<TH></TH><TH align=left width=20% >Resource Name </TH><TH align=left width=20% > Role</TH>" + vbCrLf)
        '    Response.Write("<TH align=left width=10% > From Date</TH>")
        '    Response.Write("<TH align=left width=10% > To Date</TH>")
        '    Response.Write("<TH align=right width=10% >Total Exp (Yrs)</TH><TH align=left width=15% >Primary Skills</TH>")
        '    Response.Write("<TH align=left width=15% >Other Skills</TH>")
        '    Response.Write("</THead>")
        '    If Not dr.Read Then
        '        Response.Write("<TR class='clsTREvenRow'><TD align=Center colspan=9>There are no items to show in this view.</TD></TR>")
        '    Else
        '        While 1 = 1
        '            If strCssClass = "clsTREven" Then
        '                strCssClass = "clsTROdd"
        '            Else
        '                strCssClass = "clsTREven"
        '            End If
        '            Type = dr("Type").ToString
        '            If Type <> Type_Hold Then
        '                Response.Write("<tr class=clsTRGroupheader width='99.9%'><td colspan=9>" + Type + "</td>	</tr>")
        '            End If

        '            strFromDate = CommonFunction.Dates.CGetDate(CType(dr("FromDate"), DateTime))
        '            'strToDate = CType(dr("ToDate"), String)

        '            If IsDBNull(dr("ToDate")) Then
        '                strToDate = "-"
        '            Else
        '                strToDate = CommonFunction.Dates.CGetDate(CType(dr("ToDate"), DateTime))
        '            End If

        '            strSkills = dr("PrimarySkills").ToString
        '            If strSkills.Length > 18 Then
        '                strSkills = strSkills.Substring(0, 18) + "..."
        '            End If

        '            strOtherSkills = dr("OtherSkills").ToString
        '            If strOtherSkills.Length > 18 Then
        '                strOtherSkills = strOtherSkills.Substring(0, 18) + "..."
        '            End If

        '            Response.Write("<tr class=" + strCssClass + ">")
        '            Response.Write("<td></td><td>" + dr("EmployeeName").ToString + "</td>")
        '            'If IsDorP = "P" Then
        '            '    Response.Write("<td><A href='javascript:allocate(&quot;" + IsDorP + "&quot;,&quot;" + P_OR_D_PK + "&quot;,&quot;" + StartDate + "&quot;,&quot;" + EndDate + "&quot;,&quot;" + Server.HtmlEncode(CType(dr("EmployeeName"), String)) + "&quot;,&quot;" + CType(dr("EmployeeId"), String) + "&quot;,&quot;" + RoleID + "&quot;,&quot;" + CType(dr("Total_ResourcePercentage"), String) + "&quot;,&quot;" + CType(dr("TentativeDateOfRelieving"), String) + "&quot;,&quot;" + CType(dr("JoiningDate"), String) + "&quot;," + Pipe_OR_Team_PK + ",0)'<B>Allocate</B></A></td>")
        '            'Else
        '            '    Response.Write("<td><A href='javascript:allocate(&quot;" + IsDorP + "&quot;,&quot;" + P_OR_D_PK + "&quot;,&quot;" + StartDate + "&quot;,&quot;" + EndDate + "&quot;,&quot;" + Server.HtmlEncode(CType(dr("EmployeeName"), String)) + "&quot;,&quot;" + CType(dr("EmployeeId"), String) + "&quot;,&quot;" + RoleID + "&quot;,&quot;" + CType(dr("Total_ResourcePercentage"), String) + "&quot;,&quot;" + CType(dr("TentativeDateOfRelieving"), String) + "&quot;,&quot;" + CType(dr("JoiningDate"), String) + "&quot;," + Pipe_OR_Team_PK + ",0)'<B>Soft Booking</B></A></td>")
        '            'End If

        '            Response.Write("<td>" + dr("RoleDescription").ToString + "</td>")
        '            Response.Write("<td>" + strFromDate + "</td>")
        '            Response.Write("<td>" + strToDate + "</td>")
        '            Response.Write("<td align=right >" + dr("TotalExp").ToString + "</td>")
        '            Response.Write("<td>" + strSkills + "</td>")
        '            Response.Write("<td>" + strOtherSkills + "</td>")
        '            Response.Write("</tr>")

        '            Type_Hold = Type
        '            If Not dr.Read Then
        '                Exit While
        '            End If
        '        End While
        '        CommonFunction.Data.DisposeDataReader(dr)
        '    End If
        '    Response.Write("</Table>")
        '    Response.Write("<BR>")
        'End If
        If Not Request.QueryString("Type") Is Nothing Then
            Type = Request.QueryString("Type")
        End If

        If Type = "" Or Type = "Join" Then
            strSQL = "usp_Sel_Forecast_PassI '" + Type + "','" + StartDate + "','" + EndDate + "'," + RoleID + "," + SkillID + ",'JOIN'," + Session("intUserID").ToString + "," + IsRoleBase

            dr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
            'Response.Write("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable >")
            'Response.Write("<TR class= clsTRSectionHeader ><TD align=Left>Joining Pool Resources</TD>")
            'Response.Write("</TR></TABLE>")

            ''objStrB.Append("<table style=""border-right: thin solid gray;border-bottom: thin solid gray;border-left: thin solid gray;border-top: thin solid gray""  id='tblMain' border = 0 width=100% cellspacing=0 cellpadding = 0 >" + vbCrLf)
            objStrB.Append("<table  id='tblMain' class=clsTable border = 0 width=100% cellspacing=0 cellpadding=0 >" + vbCrLf)

            'objStrB.Append("<TR class='clsTRColumnHeader' style='FONT-WEIGHT:bold'  >")
            'objStrB.Append("<TD align=center style=""border-right: thin solid gray;border-bottom: thin solid gray""   > &nbsp;" + vbCrLf)
            'objStrB.Append("</TD>")
            'drawMonthNameHeadings(objStrB)
            'objStrB.Append("</TR>" + vbCrLf)

            'objStrB.Append("<TR class='clsTRColumnHeader' style='FONT-WEIGHT:bold'  >")
            'objStrB.Append("<TD align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"">Distribution" + vbCrLf)
            'objStrB.Append("</TD>")
            'drawMonthlyDistribution(objStrB, Pipe_OR_Team_PK, IsDorP, StartDate, EndDate)
            'objStrB.Append("</TR>" + vbCrLf)



            'Response.Write("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable >")
            ''objStrB.Append("<TR class= clsTRSectionHeader >")
            ''objStrB.Append("<TD colspan=7>")

            ''If strTitle.Length > 35 Then
            ''    strTitle = strTitle.Substring(0, 33) + "..."
            ''End If

            ''objStrB.Append("<PRE>")
            ''If IsDorP = "D" Then
            ''    objStrB.Append("Resource Demand : " + strTitle + vbCrLf + "Role : " + strRole + vbCrLf + "Skill : " + strSkill) ' + vbCrLf + "Engagement Probabilty : " + EngProb)
            ''Else
            ''    objStrB.Append("Project : " + strTitle + vbCrLf + "Role : " + strRole + vbCrLf + "Skill : " + strSkill) ' + vbCrLf + "Engagement Probabilty : " + EngProb)
            ''End If

            ''objStrB.Append("</PRE>")
            ''objStrB.Append("</TD>")

            '''''''''''''''''Start of TR plot
            strRecPKID = "REF0"
            Record_StartDt = CType(StartDate, DateTime)
            Record_EndDt = CType(EndDate, DateTime)
            TT_StartDt = Nothing
            TT_EndDt = Nothing
            TT_StartDt = New ArrayList
            TT_EndDt = New ArrayList
            If (Record_StartDt < GantView_StartDt) Then
                TT_StartDt.Add(GantView_StartDt)
            Else
                TT_StartDt.Add(Record_StartDt)
            End If

            If (Record_EndDt > GantView_EndDt) Then
                TT_EndDt.Add(GantView_EndDt)
            Else
                TT_EndDt.Add(Record_EndDt)
            End If

            If (Record_StartDt < GantView_StartDt And Record_EndDt > GantView_EndDt) _
                Or (Record_StartDt < GantView_StartDt And Record_EndDt < GantView_StartDt) _
                Or (Record_StartDt > GantView_EndDt And Record_EndDt > GantView_EndDt) Then
                TT_HTML = " "
            Else
                TT_HTML = " R_TT_TD_ID='" + strRecPKID + "|" + CType(TT_EndDt(0), DateTime).Month.ToString + "|" + CType(TT_EndDt(0), DateTime).Day.ToString + "' onmouseover=""showToolTip(this,event)"" onmouseout=""hideToolTip(this,event)"""
                TT_HTML += " L_TT_TD_ID='" + strRecPKID + "|" + CType(TT_StartDt(0), DateTime).Month.ToString + "|" + CType(TT_StartDt(0), DateTime).Day.ToString + "' onmouseover=""showToolTip(this,event)"" onmouseout=""hideToolTip(this,event)"""
            End If

            objStrB.Append("<TR " + TT_HTML + " class='" + strClass + "' >")
            objStrB.Append("<TD title='" + strTitle + "'>")

            If Not strTitle Is Nothing And strTitle <> "" Then
                If strTitle.Length > 35 Then
                    strTitle = strTitle.Substring(0, 33) + "..."
                End If
            End If

            ''Commented and added by Yogesh J on 22-Jan-2016
            'objStrB.Append("<PRE>")

            objStrB.Append("<P>")
            ''End of comment by Yogesh J on 22-jan-2016
            If IsRoleBase = 0 Then
                If IsDorP = "D" Then
                    objStrB.Append("Resource Opportunity : " + strTitle + vbCrLf + "Role : " + strRole + vbCrLf + "Skill : " + strSkill) ' + vbCrLf + "Engagement Probabilty : " + EngProb)
                Else
                    objStrB.Append("Project : " + strTitle + vbCrLf + "Role : " + strRole + vbCrLf + "Skill : " + strSkill) ' + vbCrLf + "Engagement Probabilty : " + EngProb)
                End If
            Else
                If IsDorP = "D" Then
                    objStrB.Append("Resource Opportunity : " + strTitle + vbCrLf + "Role : " + strRole + vbCrLf) ' + vbCrLf + "Engagement Probabilty : " + EngProb)
                Else
                    objStrB.Append("Project : " + strTitle + vbCrLf + "Role : " + strRole + vbCrLf) ' + vbCrLf + "Engagement Probabilty : " + EngProb)
                End If

            End If


            'objStrB.Append("</PRE>")
            objStrB.Append("</P>")
            objStrB.Append("</TD>")

            '''drawMonths("0", CType(StartDate, DateTime), CType(EndDate, DateTime), GantView_StartDt.Year, objStrB)
            objGanttChart_Month = New cGanttChart_Month(GantView_StartDt, GantView_EndDt, MonDiff, "REF0", objStrB)
            arrStartDates_MonthWise = New ArrayList(1)
            arrEndDates_MonthWise = New ArrayList(1)
            arrStartDates_MonthWise.Add(CType(StartDate, DateTime))
            arrEndDates_MonthWise.Add(CType(EndDate, DateTime))
            objGanttChart_Month.PlottingStartDates = arrStartDates_MonthWise
            objGanttChart_Month.PlottingEndDates = arrEndDates_MonthWise

            objGanttChart_Month.drawMonthGantt(False)

            objGanttChart_Month = Nothing
            arrStartDates_MonthWise = Nothing
            arrEndDates_MonthWise = Nothing


            'objStrB.Append("</TR>")

            objStrB.Append("</TR></TABLE>")
            'objStrB.Append("<BR>")

            objStrB.Append("<Table width=99.9% class=clsGridTable ><THead class='clsTRColumnHeader'>" + vbCrLf)
            objStrB.Append("<TH></TH><TH align=left width=25% >Resource Name </TH><TH align=left width=25% > Role</TH>" + vbCrLf)
            objStrB.Append("<TH align=left width=10% > Joining Date</TH>")
            objStrB.Append("<TH align=right width=10% >Total Exp (Yrs)</TH><TH align=left width=15% >Primary Skills</TH>")
            objStrB.Append("<TH align=left width=15% >Other Skills</TH>")
            objStrB.Append("</THead>")
            If Not dr.Read Then
                objStrB.Append("<TR class='clsTREvenRow'><TD align=Center colspan=8>There are no items to show in this view.</TD></TR>")
            Else
                While 1 = 1
                    If strCssClass = "clsTREven" Then
                        strCssClass = "clsTROdd"
                    Else
                        strCssClass = "clsTREven"
                    End If
                    Type = dr("Type").ToString
                    If Type <> Type_Hold Then
                        objStrB.Append("<tr class=clsTRGroupheader width='99.9%'><td colspan=8>" + Type + "</td>	</tr>")
                    End If


                    strSkills = dr("PrimarySkills").ToString
                    If strSkills.Length > 18 Then
                        strSkills = strSkills.Substring(0, 18) + "..."
                    End If

                    strOtherSkills = dr("OtherSkills").ToString
                    If strOtherSkills.Length > 18 Then
                        strOtherSkills = strOtherSkills.Substring(0, 18) + "..."
                    End If

                    objStrB.Append("<tr class=" + strCssClass + ">")
                    objStrB.Append("<td></td><td>" + dr("EmployeeName").ToString + "</td>")
                    ''Added by ShraddhaM on 17,Sept 2008
                    ''Purpose : Resource Allocation from searched resources in Whiziblesem8.0
                    'If CommonFunction.Application.AllowResourceAllocation = False Then
                    '    Response.Write("<TD> <I><A href='javascript:allocate(&quot;JP&quot;,&quot;" + PK + "&quot;,&quot;" + StartDate + "&quot;,&quot;" + EndDate + "&quot;,&quot;" + dr("EmployeeName").ToString + "&quot;,&quot;" + dr("EmployeeID").ToString + "&quot;,&quot;" + RoleID + "&quot;,&quot;0&quot;,&quot;" + CType(dataTable_ForeCast.Rows(Iterator)("TentativeDateOfRelieving"), String) + "&quot;,&quot;" + CType(dataTable_ForeCast.Rows(Iterator)("JoiningDate"), String) + "&quot;," + Pipe_OR_Team_PK + ")' >Allocate</A> </I> (Project Allocation) </TD> " + vbCrLf)
                    'End If
                    ''End of comment and addition by ShraddhaM

                    objStrB.Append("<td>" + dr("RoleDescription").ToString + "</td>")
                    objStrB.Append("<td>" + CommonFunction.Dates.CGetDate(CType(dr("JoiningDate"), DateTime)) + "</td>")
                    objStrB.Append("<td align=right >" + dr("TotalExp").ToString + "</td>")
                    objStrB.Append("<td>" + strSkills + "</td>")
                    objStrB.Append("<td>" + strOtherSkills + "</td>")
                    objStrB.Append("</tr>")

                    Type_Hold = Type
                    If Not dr.Read Then
                        Exit While
                    End If
                End While
                CommonFunction.Data.DisposeDataReader(dr)
            End If
            objStrB.Append("</Table>")

        End If
        Response.Write(objStrB.ToString)
    End Sub
    Private Sub GenerateForeCastSectionPass2()
        Dim StartDate As String
        Dim EndDate As String
        Dim RoleID As String
        Dim SkillID As String
        Dim PK As String
        Dim Type As String
        Dim strCssClass As String = "clsTREven"
        Dim Resource As String
        Dim Resource_Hold As String = ""
        Dim ProjectName As String
        Dim IsDorP As String
        Dim RoleDesc As String
        Dim SkillDesc As String
        Dim Title As String
        Dim ToolTip As String
        Dim EngProb As String
        Dim strRecPKID As String
        Dim IsNewWF As Boolean
        Dim Record_StartDt As Date
        Dim Record_EndDt As Date

        Dim TT_StartDt As ArrayList
        Dim TT_EndDt As ArrayList
        Dim TT_HTML As String

        Dim strClass As String = "clsTREven"
        Dim strFirstColumnHTML_hold As String
        Dim strFirstColumnHTML As String

        Dim objGanttChart_Month As cGanttChart_Month
        Dim arrStartDates_MonthWise As ArrayList
        Dim arrEndDates_MonthWise As ArrayList
        Dim arrblnOnBench_Monthwise As ArrayList
        Dim blnOnBench As Boolean
        Dim Iterator1 As Integer

        Dim objStrB As System.Text.StringBuilder = New System.Text.StringBuilder

        Dim P_OR_D_PK As String
        Dim Pipe_OR_Team_PK As String
        Dim MapToProjectOnHold As String
        Dim IsProjectApproved As String
        Dim IsApprovalWF As Boolean
        Dim EmpID As Integer
        Dim strEmployeeName As String
        Dim dataTable_ForeCast As DataTable
        Dim IsSoftBookedOld As Boolean = False
        Dim IsSoftBookedCurr As Boolean = False
        Dim strSQL As String
        Dim dr As IDataReader
        Dim strPKToken As String
        Dim DemandedRole As String
        Dim DataForecast_DS As DataSet
        StartDate = Request.QueryString("SD")
        EndDate = Request.QueryString("ED")
        RoleID = Request.QueryString("RoleID")
        SkillID = Request.QueryString("SkillID")
        PK = Request.QueryString("PK")
        IsDorP = Request.QueryString("IsDorP")
        Type = Request.QueryString("Type")
        EmpID = Request.QueryString("EmpID")

        If Type = "" Then
            Type = "NULL"
        End If
        If RoleID = "0" Then
            RoleID = "NULL"
        End If
        If SkillID = "0" Then
            SkillID = "NULL"
        End If





        'GantView_StartDt = GantView_StartDt.AddMonths(-1)
        'GantView_EndDt = GantView_StartDt.AddMonths(1)
        'MonDiff += 2

        strSQL = "usp_Sel_ForeCast_PassII_MainRecord " + PK + ",'" + StartDate + "','" + EndDate + "'," + RoleID + "," + SkillID + ",'" + IsDorP + "'," + Session("intUserID").ToString + "," + IsRoleBase

        dr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If dr.Read Then
            'Added by ShraddhaM on 17,Sept 2008
            'Purpose : Resource Allocation from advanced searched resources in Whiziblesem8.0
            P_OR_D_PK = CType(dr("P_OR_D_PK"), String)
            Pipe_OR_Team_PK = CType(dr("Pipe_OR_Team_PK"), String)
            'End of addition by ShraddhaM on 17,Sept 2008

            RoleDesc = CType(dr("RoleDescription"), String)

            If IsRoleBase = 0 Then
                SkillDesc = CType(dr("Skill"), String)
            End If

            Title = CType(dr("Title"), String)
            EngProb = CType(dr("EngagementProbability"), String)
            MapToProjectOnHold = CType(dr("MapToProjectOnHold"), String)
            IsProjectApproved = CType(dr("IsApproved"), String)
            IsNewWF = CType(dr("IsNewProjectWF"), Boolean)

        End If

        CommonFunction.Data.DisposeDataReader(dr)

        objStrB.Append("<table style=""border-right: thin solid gray;border-bottom: thin solid gray;border-left: thin solid gray;border-top: thin solid gray""  id='tblMain' border = 0 width=100% cellspacing=0 cellpadding = 0 >" + vbCrLf)
        objStrB.Append("<TR class='clsTRColumnHeader' style='FONT-WEIGHT:bold'  >")
        objStrB.Append("<TD align=center style=""border-right: thin solid gray;border-bottom: thin solid gray""   > &nbsp;" + vbCrLf)
        objStrB.Append("</TD>")
        drawMonthNameHeadings(objStrB)
        objStrB.Append("</TR>" + vbCrLf)

        objStrB.Append("<TR class='clsTRColumnHeader' style='FONT-WEIGHT:bold'  >")
        'Modified by SanaS on 24-Oct-2009
        'objStrB.Append("<TD align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"">Distribution" + vbCrLf)
        objStrB.Append("<TD align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"">FTE" + vbCrLf)
        'End Modification by SanaS on 24-Oct-2009
        objStrB.Append("</TD>")
        drawMonthlyDistribution(objStrB, Pipe_OR_Team_PK, IsDorP, StartDate, EndDate)
        objStrB.Append("</TR>" + vbCrLf)

        '''''''''''''''''Start of TR plot
        strRecPKID = "REF0"
        Record_StartDt = CType(StartDate, DateTime)
        Record_EndDt = CType(EndDate, DateTime)
        TT_StartDt = Nothing
        TT_EndDt = Nothing
        TT_StartDt = New ArrayList
        TT_EndDt = New ArrayList
        If (Record_StartDt < GantView_StartDt) Then
            TT_StartDt.Add(GantView_StartDt)
        Else
            TT_StartDt.Add(Record_StartDt)
        End If

        If (Record_EndDt > GantView_EndDt) Then
            TT_EndDt.Add(GantView_EndDt)
        Else
            TT_EndDt.Add(Record_EndDt)
        End If

        If (Record_StartDt < GantView_StartDt And Record_EndDt > GantView_EndDt) _
            Or (Record_StartDt < GantView_StartDt And Record_EndDt < GantView_StartDt) _
            Or (Record_StartDt > GantView_EndDt And Record_EndDt > GantView_EndDt) Then
            TT_HTML = " "
        Else
            TT_HTML = " R_TT_TD_ID='" + strRecPKID + "|" + CType(TT_EndDt(0), DateTime).Month.ToString + "|" + CType(TT_EndDt(0), DateTime).Day.ToString + "' onmouseover=""showToolTip(this,event)"" onmouseout=""hideToolTip(this,event)"""
            TT_HTML += " L_TT_TD_ID='" + strRecPKID + "|" + CType(TT_StartDt(0), DateTime).Month.ToString + "|" + CType(TT_StartDt(0), DateTime).Day.ToString + "' onmouseover=""showToolTip(this,event)"" onmouseout=""hideToolTip(this,event)"""
        End If

        objStrB.Append("<TR " + TT_HTML + " class='" + strClass + "' >")
        '''''''''''''''''End of TR plot

        objStrB.Append("<TD title='" + Title + "'>")

        If Not Title Is Nothing And Title <> "" Then
            If Title.Length > 35 Then
                Title = Title.Substring(0, 33) + "..."
            End If
        End If

        ''Commented and added by Yogesh J on 22-Jan-2016
        ' objStrB.Append("<PRE>")
        objStrB.Append("<P>")
        ''End of comment by Yogesh J on 22-jan-2016
        If IsRoleBase = 0 Then
            If IsDorP = "D" Then
                objStrB.Append("Resource Opportunity : " + Title + vbCrLf + "Role : " + RoleDesc + vbCrLf + "Skill : " + SkillDesc) ' + vbCrLf + "Engagement Probabilty : " + EngProb)
            Else
                objStrB.Append("Project : " + Title + vbCrLf + "Role : " + RoleDesc + vbCrLf + "Skill : " + SkillDesc) ' + vbCrLf + "Engagement Probabilty : " + EngProb)
            End If
        Else
            If IsDorP = "D" Then
                objStrB.Append("Resource Opportunity : " + Title + vbCrLf + "Role : " + RoleDesc + vbCrLf) ' + vbCrLf + "Engagement Probabilty : " + EngProb)
            Else
                objStrB.Append("Project : " + Title + vbCrLf + "Role : " + RoleDesc + vbCrLf) ' + vbCrLf + "Engagement Probabilty : " + EngProb)
            End If
        End If


        'objStrB.Append("</PRE>")
        objStrB.Append("</P>")
        objStrB.Append("</TD>")

        '''drawMonths("0", CType(StartDate, DateTime), CType(EndDate, DateTime), GantView_StartDt.Year, objStrB)
        objGanttChart_Month = New cGanttChart_Month(GantView_StartDt, GantView_EndDt, MonDiff, "REF0", objStrB)
        arrStartDates_MonthWise = New ArrayList(1)
        arrEndDates_MonthWise = New ArrayList(1)
        arrStartDates_MonthWise.Add(CType(StartDate, DateTime))
        arrEndDates_MonthWise.Add(CType(EndDate, DateTime))
        objGanttChart_Month.PlottingStartDates = arrStartDates_MonthWise
        objGanttChart_Month.PlottingEndDates = arrEndDates_MonthWise

        objGanttChart_Month.drawMonthGantt(False)

        objGanttChart_Month = Nothing

        arrEndDates_MonthWise = Nothing


        objStrB.Append("</TR>")

        'strSQL = "usp_Sel_Forecast_PassII '" + StartDate + "','" + EndDate + "'," + RoleID + "," + SkillID + "," + Type + "," + Session("intUserID").ToString
        If IsRoleBase = 0 Then
            strSQL = "usp_Sel_Forecast_PassII '" + StartDate + "','" + EndDate + "'," + RoleID + "," + SkillID + "," + Type + "," + Session("intUserID").ToString + "," + P_OR_D_PK + ",'" + IsDorP + "'," + Pipe_OR_Team_PK.ToString

        Else
            strSQL = "usp_Sel_Forecast_PassII_RoleBase '" + StartDate + "','" + EndDate + "'," + RoleID + "," + SkillID + "," + Type + "," + Session("intUserID").ToString + "," + P_OR_D_PK + ",'" + IsDorP + "'," + Pipe_OR_Team_PK.ToString
        End If
        'dr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)


        DataForecast_DS = CommonFunction.Data.GetDataSet(strSQL, "dataTable_ForeCast", 0, 0, True)
        dataTable_ForeCast = DataForecast_DS.Tables(0)

        'Added by Sanas on 18-Sep-2009
        If dataTable_ForeCast.Rows.Count > 0 Then
            IsSoftBookedOld = CType(dataTable_ForeCast.Rows(0)("IsSoftBook"), Boolean)
            IsSoftBookedCurr = CType(dataTable_ForeCast.Rows(0)("IsSoftBook"), Boolean)
        End If
        If IsSoftBookedOld = True Then
            objStrB.Append("<TR class='clsTRColumnHeader' style='FONT-WEIGHT:bold'  >")
            If IsDorP = "D" Then
                objStrB.Append("<TD align=center style=""border-right: thin solid gray;border-bottom: thin solid gray""  colspan=7  > Soft Booked Resources" + vbCrLf)
            Else
                objStrB.Append("<TD align=center style=""border-right: thin solid gray;border-bottom: thin solid gray""  colspan=7  > Soft Booked/Allocated Resources" + vbCrLf)
            End If
            objStrB.Append("</TD></TR>" + vbCrLf)
        End If
        'End Addiiton by Sanas on 18-Sep-2009
        For Iterator = 0 To dataTable_ForeCast.Rows.Count - 1 'dr.Read()

            If strClass = "clsTROdd" Then
                strClass = "clsTREven"
            Else
                strClass = "clsTROdd"
            End If
            'Added by SanaS on 23-Nov-2009
            DemandedRole = CType(dataTable_ForeCast.Rows(Iterator)("DemandedRole"), String)
            'End by SanaS on 23-Nov-2009
            'Added by Sanas on 18-Sep-2009
            IsSoftBookedCurr = CType(dataTable_ForeCast.Rows(Iterator)("IsSoftBook"), Boolean)
            If IsSoftBookedCurr <> IsSoftBookedOld Then
                IsSoftBookedOld = IsSoftBookedCurr
                objStrB.Append("<TR class='clsTRColumnHeader' style='FONT-WEIGHT:bold'  >")

                objStrB.Append("<TD align=center style=""border-right: thin solid gray;border-bottom: thin solid gray""  colspan=7  > Searched Resources" + vbCrLf)
                objStrB.Append("</TD></TR>" + vbCrLf)

            End If
            'End Addition by Sanas on 18-Sep-2009
            'strFirstColumnHTML = CType(dr("EmployeeName"), String)
            strFirstColumnHTML = CType(dataTable_ForeCast.Rows(Iterator)("EmployeeName"), String)
            ProjectName = dataTable_ForeCast.Rows(Iterator)("ProjectName").ToString()
            If ProjectName.Length > 50 Then
                ProjectName = ProjectName.Substring(0, 47) + "..."
            End If

            If dataTable_ForeCast.Rows(Iterator)("ProjectName").ToString() <> "" Then

                ToolTip = "Project : " + dataTable_ForeCast.Rows(Iterator)("ProjectName").ToString() + Environment.NewLine
                ToolTip = ToolTip + "Role : " + dataTable_ForeCast.Rows(Iterator)("RoleDescription").ToString + "  " + "Status  : " + dataTable_ForeCast.Rows(Iterator)("ResourceStatus").ToString + Environment.NewLine
                ToolTip = ToolTip + "Reporting To : " + dataTable_ForeCast.Rows(Iterator)("ReportingToName").ToString + "   " + dataTable_ForeCast.Rows(Iterator)("Project_IntExt").ToString + Environment.NewLine
                ToolTip = ToolTip + "% Allocation : " + dataTable_ForeCast.Rows(Iterator)("ResourcePercentage").ToString + Environment.NewLine
                If IsDBNull(dataTable_ForeCast.Rows(Iterator)("ExpectedStartDate")) = False Then
                    ToolTip = ToolTip + "Start Date: " + CommonFunctions.Dates.CGetDate(dataTable_ForeCast.Rows(Iterator)("ExpectedStartDate")) + Environment.NewLine
                Else
                    ToolTip = ToolTip + "Start Date: " + Environment.NewLine
                End If
                If IsDBNull(dataTable_ForeCast.Rows(Iterator)("ExpectedEndDate")) = False Then
                    ToolTip = ToolTip + "End Date: " + CommonFunctions.Dates.CGetDate(dataTable_ForeCast.Rows(Iterator)("ExpectedEndDate")) + Environment.NewLine
                Else
                    ToolTip = ToolTip + "End Date: " + Environment.NewLine
                End If
            End If

            blnOnBenchForPlotting = CType(dataTable_ForeCast.Rows(Iterator)("OnBench"), Boolean)

            If strFirstColumnHTML_hold <> strFirstColumnHTML Then 'strFirstColumnHTML_hold = "" OrElse 

                objGanttChart_Month = New cGanttChart_Month(GantView_StartDt, GantView_EndDt, MonDiff, "P2_" + Iterator.ToString, objStrB)
                arrStartDates_MonthWise = New ArrayList
                arrEndDates_MonthWise = New ArrayList
                arrblnOnBench_Monthwise = New ArrayList

                For Iterator1 = Iterator To dataTable_ForeCast.Rows.Count - 1
                    If strFirstColumnHTML <> CType(dataTable_ForeCast.Rows(Iterator1)("EmployeeName"), String) Then
                        Exit For
                    End If
                    If Not IsDBNull(dataTable_ForeCast.Rows(Iterator1)("ExpectedStartDate")) Then
                        Record_StartDt = CType(dataTable_ForeCast.Rows(Iterator1)("ExpectedStartDate"), DateTime)
                    End If

                    If Not IsDBNull(dataTable_ForeCast.Rows(Iterator1)("ExpectedEndDate")) Then
                        Record_EndDt = CType(dataTable_ForeCast.Rows(Iterator1)("ExpectedEndDate"), DateTime)
                    End If
                    blnOnBench = CType(dataTable_ForeCast.Rows(Iterator1)("OnBench"), Boolean)

                    arrStartDates_MonthWise.Add(Record_StartDt)
                    arrEndDates_MonthWise.Add(Record_EndDt)
                    arrblnOnBench_Monthwise.Add(blnOnBench)

                Next


                objGanttChart_Month.PlottingStartDates = arrStartDates_MonthWise
                objGanttChart_Month.PlottingEndDates = arrEndDates_MonthWise
                objGanttChart_Month.OnBench = arrblnOnBench_Monthwise

                objStrB.Append("<TR R_TT_TD_ID='P2_" + Iterator.ToString + "|" + Record_EndDt.Month.ToString + "|" + Record_EndDt.Day.ToString + "' L_TT_TD_ID='" + strRecPKID + "|" + Record_StartDt.Month.ToString + "|" + Record_StartDt.Day.ToString + "' class='clsTRGroupheader' >") 'onmouseover=""showToolTip(this,event)"" onmouseout=""hideToolTip(this,event)"" >")
                'Commented and Added by ShraddhaM on 17,Sept 2008
                'Purpose : Resource Allocation from searched resources in Whiziblesem8.0
                'objStrB.Append("<TD>" + strFirstColumnHTML + "(Project Allocation) </TD> " + vbCrLf)

                strEmployeeName = Server.HtmlEncode(CType(dataTable_ForeCast.Rows(Iterator)("EmployeeName"), String))

                If CommonFunction.Application.AllowResourceAllocation = True Then
                    'objStrB.Append("<TD>" + strFirstColumnHTML + "(Project Allocation) </TD> " + vbCrLf)
                    If IsDorP = "D" Then
                        If CType(dataTable_ForeCast.Rows(Iterator)("IsSoftBook"), Boolean) = False Then
                            objStrB.Append("<TD>" + strFirstColumnHTML + "  <I>&nbsp;&nbsp;<A href='javascript:allocate(&quot;" + IsDorP + "&quot;,&quot;" + P_OR_D_PK + "&quot;,&quot;" + StartDate + "&quot;,&quot;" + EndDate + "&quot;,&quot;" + Server.HtmlEncode(CType(dataTable_ForeCast.Rows(Iterator)("EmployeeName"), String)) + "&quot;,&quot;" + CType(dataTable_ForeCast.Rows(Iterator)("EmployeeId"), String) + "&quot;,&quot;" + RoleID + "&quot;,&quot;" + CType(dataTable_ForeCast.Rows(Iterator)("Total_ResourcePercentage"), String) + "&quot;,&quot;" + CType(dataTable_ForeCast.Rows(Iterator)("TentativeDateOfRelieving"), String) + "&quot;,&quot;" + CType(dataTable_ForeCast.Rows(Iterator)("JoiningDate"), String) + "&quot;," + Pipe_OR_Team_PK + "," + CType(dataTable_ForeCast.Rows(Iterator)("IsSoftBook"), String) + ",0,&quot;" + Title + "&quot;,&quot;&quot;,&quot;0&quot;)' ><B>Soft Booking</B></A> </I>&nbsp;&nbsp;(Project Allocation) </TD> " + vbCrLf)
                        Else
                            objStrB.Append("<TD>" + strFirstColumnHTML + "  &nbsp;&nbsp;(Project Allocation) </TD>" + Environment.NewLine)
                        End If
                    Else
                        objStrB.Append("<TD>" + strFirstColumnHTML + "  &nbsp;&nbsp;(Project Allocation) </TD>" + Environment.NewLine)
                    End If
                Else
                    If IsDorP = "P" Then
                        'Added by SanaS 0n 18-Sep-2009
                        If CType(dataTable_ForeCast.Rows(Iterator)("IsAllocated"), Boolean) = False Then
                            'Modified by SanaS on 23-Nov-2009
                            'objStrB.Append("<TD>" + strFirstColumnHTML + "  <I>&nbsp;&nbsp;<A href='javascript:allocate(&quot;" + IsDorP + "&quot;,&quot;" + P_OR_D_PK + "&quot;,&quot;" + StartDate + "&quot;,&quot;" + EndDate + "&quot;,&quot;" + Server.HtmlEncode(CType(dataTable_ForeCast.Rows(Iterator)("EmployeeName"), String)) + "&quot;,&quot;" + CType(dataTable_ForeCast.Rows(Iterator)("EmployeeId"), String) + "&quot;,&quot;" + RoleID + "&quot;,&quot;" + CType(dataTable_ForeCast.Rows(Iterator)("Total_ResourcePercentage"), String) + "&quot;,&quot;" + CType(dataTable_ForeCast.Rows(Iterator)("TentativeDateOfRelieving"), String) + "&quot;,&quot;" + CType(dataTable_ForeCast.Rows(Iterator)("JoiningDate"), String) + "&quot;," + Pipe_OR_Team_PK + ",0,&quot;" + MapToProjectOnHold + "&quot;,&quot;" + Title + "&quot;,&quot;" + IsProjectApproved + "&quot;,&quot;" + IsNewWF.ToString() + "&quot;)' ><B>Allocate</B></A> </I>&nbsp;&nbsp;(Project Allocation) </TD> " + vbCrLf)
                            objStrB.Append("<TD>" + strFirstColumnHTML + "  <I>&nbsp;&nbsp;<A href='javascript:allocate(&quot;" + IsDorP + "&quot;,&quot;" + P_OR_D_PK + "&quot;,&quot;" + StartDate + "&quot;,&quot;" + EndDate + "&quot;,&quot;" + Server.HtmlEncode(CType(dataTable_ForeCast.Rows(Iterator)("EmployeeName"), String)) + "&quot;,&quot;" + CType(dataTable_ForeCast.Rows(Iterator)("EmployeeId"), String) + "&quot;,&quot;" + DemandedRole + "&quot;,&quot;" + CType(dataTable_ForeCast.Rows(Iterator)("Total_ResourcePercentage"), String) + "&quot;,&quot;" + CType(dataTable_ForeCast.Rows(Iterator)("TentativeDateOfRelieving"), String) + "&quot;,&quot;" + CType(dataTable_ForeCast.Rows(Iterator)("JoiningDate"), String) + "&quot;," + Pipe_OR_Team_PK + ",0,&quot;" + MapToProjectOnHold + "&quot;,&quot;" + Title + "&quot;,&quot;" + IsProjectApproved + "&quot;,&quot;" + IsNewWF.ToString() + "&quot;)' ><B>Allocate</B></A> </I>&nbsp;&nbsp;(Project Allocation) </TD> " + vbCrLf)
                             'End modification by SanaS on 23-Nov-2009
                        Else
                            objStrB.Append("<TD>" + strFirstColumnHTML + "  &nbsp;&nbsp; </TD>" + Environment.NewLine)
                        End If
                        'End  Addition by SanaS 0n 18-Sep-2009
                    Else
                        'Added by SanaS 0n 18-Sep-2009
                        If CType(dataTable_ForeCast.Rows(Iterator)("IsSoftBook"), Boolean) = False Then
                            objStrB.Append("<TD>" + strFirstColumnHTML + "  <I>&nbsp;&nbsp;<A href='javascript:allocate(&quot;" + IsDorP + "&quot;,&quot;" + P_OR_D_PK + "&quot;,&quot;" + StartDate + "&quot;,&quot;" + EndDate + "&quot;,&quot;" + Server.HtmlEncode(CType(dataTable_ForeCast.Rows(Iterator)("EmployeeName"), String)) + "&quot;,&quot;" + CType(dataTable_ForeCast.Rows(Iterator)("EmployeeId"), String) + "&quot;,&quot;" + RoleID + "&quot;,&quot;" + CType(dataTable_ForeCast.Rows(Iterator)("Total_ResourcePercentage"), String) + "&quot;,&quot;" + CType(dataTable_ForeCast.Rows(Iterator)("TentativeDateOfRelieving"), String) + "&quot;,&quot;" + CType(dataTable_ForeCast.Rows(Iterator)("JoiningDate"), String) + "&quot;," + Pipe_OR_Team_PK + "," + CType(dataTable_ForeCast.Rows(Iterator)("IsSoftBook"), String) + ",0,&quot;" + Title + "&quot;,&quot;&quot;,&quot;0&quot;)' ><B>Soft Booking</B></A> </I>&nbsp;&nbsp;(Project Allocation) </TD> " + vbCrLf)
                        Else
                            objStrB.Append("<TD>" + strFirstColumnHTML + "  &nbsp;&nbsp; </TD>" + Environment.NewLine)
                        End If
                        'End  Addition by SanaS 0n 18-Sep-2009
                    End If
                End If
                'End of comment and addition by ShraddhaM

                objGanttChart_Month.Ref_GanttStartDate = CType(StartDate, DateTime)
                objGanttChart_Month.Ref_GanttEndDate = CType(EndDate, DateTime)

                objGanttChart_Month.drawMonthGantt(False)

                objGanttChart_Month = Nothing
                arrStartDates_MonthWise = Nothing
                arrEndDates_MonthWise = Nothing
                arrblnOnBench_Monthwise = Nothing
                'Putting R_TT_TD_ID as it does not have Vert, same as L_TT_TD_ID.
                'Putting RTooltio and LTooltip becoz it does not have vert.

                strRecPKID = CType(dataTable_ForeCast.Rows(Iterator)("ProjectEmployeeRoleID"), String)
                If Not IsDBNull(dataTable_ForeCast.Rows(Iterator)("ExpectedStartDate")) Then
                    Record_StartDt = CType(dataTable_ForeCast.Rows(Iterator)("ExpectedStartDate"), DateTime)
                End If
                If Not IsDBNull(dataTable_ForeCast.Rows(Iterator)("ExpectedEndDate")) Then
                    Record_EndDt = CType(dataTable_ForeCast.Rows(Iterator)("ExpectedEndDate"), DateTime)
                End If
                TT_StartDt = Nothing
                TT_EndDt = Nothing
                TT_StartDt = New ArrayList
                TT_EndDt = New ArrayList
                If (Record_StartDt < GantView_StartDt) Then
                    TT_StartDt.Add(GantView_StartDt)
                Else
                    TT_StartDt.Add(Record_StartDt)
                End If

                If (Record_EndDt > GantView_EndDt) Then
                    TT_EndDt.Add(GantView_EndDt)
                Else
                    TT_EndDt.Add(Record_EndDt)
                End If

                If (Record_StartDt < GantView_StartDt And Record_EndDt > GantView_EndDt) _
                    Or (Record_StartDt < GantView_StartDt And Record_EndDt < GantView_StartDt) _
                    Or (Record_StartDt > GantView_EndDt And Record_EndDt > GantView_EndDt) Then
                    TT_HTML = " "
                Else
                    TT_HTML = " R_TT_TD_ID='" + strRecPKID + "|" + CType(TT_EndDt(0), DateTime).Month.ToString + "|" + CType(TT_EndDt(0), DateTime).Day.ToString + "' onmouseover=""showToolTip(this,event)"" onmouseout=""hideToolTip(this,event)"""
                    TT_HTML += " L_TT_TD_ID='" + strRecPKID + "|" + CType(TT_StartDt(0), DateTime).Month.ToString + "|" + CType(TT_StartDt(0), DateTime).Day.ToString + "' onmouseover=""showToolTip(this,event)"" onmouseout=""hideToolTip(this,event)"""
                End If


                '' added by RohiniK on 16 Oct 09 for S1 Changes
                TT_HTML = ""
                ''End of addition by RohiniK on 16 Oct 09 for S1 Changes

                objStrB.Append("<TR " + TT_HTML + " class='" + strClass + "' >")

                ''commented and added by RohiniK on 16 Oct 09 for S1 Changes
                objStrB.Append("<TD>")
                'objStrB.Append("<TD title='" + ToolTip + "'>")
                ''End of comment and addition by RohiniK on 16 Oct 09 for S1 Changes
                If blnOnBenchForPlotting = True Then
                    objStrB.Append("<FONT color=green>")
                End If
                ''added by RohiniK on 30 Oct 09 for S1 Changes
                If blnOnBenchForPlotting = False Then
                    objStrB.Append(ProjectName + " " + "<img title='" + ToolTip + "' src='../../Images/Sort_down.gif' )>" + vbCrLf)

                End If
                ''End of addition by RohiniK on 30 Oct 09 for S1 Changes
                If blnOnBenchForPlotting = True Then
                    'Added by SanaS on 18-Nov-2009
                    If ProjectName <> "Bench" Then
                        objStrB.Append(ProjectName + " " + "<img title='" + ToolTip + "' src='../../Images/Sort_down.gif' )>" + vbCrLf)
                    End If
                    'End Addition by SanaS on 18-Nov-2009
                    objStrB.Append("[On Bench]" + vbCrLf)
                    objStrB.Append("</FONT>")
                End If

                objStrB.Append("</TD>")

            Else
                strRecPKID = CType(dataTable_ForeCast.Rows(Iterator)("ProjectEmployeeRoleID"), String)
                If Not IsDBNull(dataTable_ForeCast.Rows(Iterator)("ExpectedStartDate")) Then
                    Record_StartDt = CType(dataTable_ForeCast.Rows(Iterator)("ExpectedStartDate"), DateTime)
                End If
                If Not IsDBNull(dataTable_ForeCast.Rows(Iterator)("ExpectedEndDate")) Then
                    Record_EndDt = CType(dataTable_ForeCast.Rows(Iterator)("ExpectedEndDate"), DateTime)
                End If
                TT_StartDt = Nothing
                TT_EndDt = Nothing
                TT_StartDt = New ArrayList
                TT_EndDt = New ArrayList
                If (Record_StartDt < GantView_StartDt) Then
                    TT_StartDt.Add(GantView_StartDt)
                Else
                    TT_StartDt.Add(Record_StartDt)
                End If

                If (Record_EndDt > GantView_EndDt) Then
                    TT_EndDt.Add(GantView_EndDt)
                Else
                    TT_EndDt.Add(Record_EndDt)
                End If

                If (Record_StartDt < GantView_StartDt And Record_EndDt > GantView_EndDt) _
                    Or (Record_StartDt < GantView_StartDt And Record_EndDt < GantView_StartDt) _
                    Or (Record_StartDt > GantView_EndDt And Record_EndDt > GantView_EndDt) Then
                    TT_HTML = " "
                Else
                    TT_HTML = " R_TT_TD_ID='" + strRecPKID + "|" + CType(TT_EndDt(0), DateTime).Month.ToString + "|" + CType(TT_EndDt(0), DateTime).Day.ToString + "' onmouseover=""showToolTip(this,event)"" onmouseout=""hideToolTip(this,event)"""
                    TT_HTML += " L_TT_TD_ID='" + strRecPKID + "|" + CType(TT_StartDt(0), DateTime).Month.ToString + "|" + CType(TT_StartDt(0), DateTime).Day.ToString + "' onmouseover=""showToolTip(this,event)"" onmouseout=""hideToolTip(this,event)"""
                End If

                '' added by RohiniK on 16 Oct 09 for S1 Changes
                TT_HTML = ""
                ''End of addition by RohiniK on 16 Oct 09 for S1 Changes

                objStrB.Append("<TR " + TT_HTML + " class='" + strClass + "' >")

                ''commented and added by RohiniK on 16 Oct 09 for S1 Changes
                objStrB.Append("<TD>")
                'objStrB.Append("<TD title='" + ToolTip + "'>")
                ''End of comment and addition by RohiniK on 16 Oct 09 for S1 Changes


                If blnOnBenchForPlotting = True Then
                    objStrB.Append("<FONT color=green>")
                End If
                ''added by RohiniK on 30 Oct 09 for S1 Changes
                If blnOnBenchForPlotting = False Then
                    objStrB.Append(ProjectName + " " + "<img title='" + ToolTip + "' src='../../Images/Sort_down.gif' )>" + vbCrLf)
                End If
                ''End of addition by RohiniK on 30 Oct 09 for S1 Changes
                If blnOnBenchForPlotting = True Then
                    objStrB.Append("[On Bench]" + vbCrLf)
                    objStrB.Append("</FONT>")
                End If

                objStrB.Append("</TD>")
            End If
            strFirstColumnHTML_hold = strFirstColumnHTML
            strRecPKID = CType(dataTable_ForeCast.Rows(Iterator)("ProjectEmployeeRoleID"), String)
            If Not IsDBNull(dataTable_ForeCast.Rows(Iterator)("ExpectedStartDate")) Then
                Record_StartDt = CType(dataTable_ForeCast.Rows(Iterator)("ExpectedStartDate"), DateTime)
            End If
            If Not IsDBNull(dataTable_ForeCast.Rows(Iterator)("ExpectedEndDate")) Then
                Record_EndDt = CType(dataTable_ForeCast.Rows(Iterator)("ExpectedEndDate"), DateTime)
            End If


            ''''''''''''''Drawing Table's row ( from Jan to Dec ) as gantt/progress. Plotting only TD's 
            ''''''''''''''TR must start with First columns before call this function
            'drawMonths(strRecPKID, Record_StartDt, Record_EndDt, GantView_StartDt.Year, objStrB)
            objGanttChart_Month = New cGanttChart_Month(GantView_StartDt, GantView_EndDt, MonDiff, strRecPKID, objStrB)
            arrStartDates_MonthWise = New ArrayList(1)
            arrEndDates_MonthWise = New ArrayList(1)
            arrblnOnBench_Monthwise = New ArrayList(1)

            arrStartDates_MonthWise.Add(Record_StartDt)
            arrEndDates_MonthWise.Add(Record_EndDt)
            arrblnOnBench_Monthwise.Add(blnOnBench)

            objGanttChart_Month.PlottingStartDates = arrStartDates_MonthWise
            objGanttChart_Month.PlottingEndDates = arrEndDates_MonthWise
            objGanttChart_Month.OnBench = arrblnOnBench_Monthwise

            objGanttChart_Month.drawMonthGantt(blnOnBenchForPlotting)

            objGanttChart_Month = Nothing
            arrStartDates_MonthWise = Nothing
            arrEndDates_MonthWise = Nothing
            arrblnOnBench_Monthwise = Nothing


            objStrB.Append("</TR>")
        Next


        objStrB.Append("</TABLE>")
        Response.Write(objStrB.ToString)
        dataTable_ForeCast.Dispose()
        DataForecast_DS.Dispose()




    End Sub

    Private Sub GenerateFilterMenu()

        tblHTML.Append("<div id=divFilter style='OVERFLOW:auto;DISPLAY:none;BORDER-COLOR:#35afe8;BORDER-STYLE:groove;WIDTH:80%;POSITION:absolute;Z-INDEX:19000'>")
        'Filter Table 
        tblHTML.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable >")
        tblHTML.Append("<TR class= clsTRSectionHeader >")
        tblHTML.Append("<td align=right><a href ='Javascript:ForeCast_onClose()'><img border=0 src = '../../Images/RM/Close.png' > </a>")
        tblHTML.Append("</TR></TABLE>")

        tblHTML.Append("<TABLE id='tblFilter' style='width:99.99%;' class='clsGridTable' >")
        'For BG Filter 
        tblHTML.Append("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        tblHTML.Append("<td style='width:25%;text-align:right' align=right>Business Group")
        tblHTML.Append("</td>")
        tblHTML.Append("<td style='width:25%' align=left >")
        tblHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboBG", "usp_sel_BusinessGroups_LevelWise_PassI_II " + Session("intUserID").ToString, 200, m_strBGID.ToString, "onChange= BG_onChange()", True, True))
        tblHTML.Append("</td>")
        'For OU Filter 
        tblHTML.Append("<td style='width:25%;text-align:right' align=right>Organization Unit")
        tblHTML.Append("</td>")
        tblHTML.Append("<td style='width:25%;' align=Left >")
        If m_strBGID <> "" Then
            tblHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboOU", "usp_sel_OrganizationUnits_LevelWise_PassI_II " + m_strBGID + "," + Session("intUserID").ToString, 200, m_strOUID.ToString, , True, True))
        Else
            tblHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboOU", "usp_sel_OrganizationUnits_LevelWise_PassI_II NULL," + Session("intUserID").ToString, 200, m_strOUID.ToString, , True, True))
        End If

        tblHTML.Append("</td></TR>")

        ''commented by RohiniK on 30 Oct 09 for S1 Changes
        ''Fo Role Filter
        'tblHTML.Append("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        'tblHTML.Append("<td style='width:25%;text-align:right' align=right>Role")
        'tblHTML.Append("</td>")
        'tblHTML.Append("<td style='width:25%' align=Left>")
        ''Modified by SanaS on 17-Sep-2009 
        ''tblHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRole", "Select RoleID, RoleDescription From tbl_PM_Role Where IsNull(IsUserGroup, 0) = 0 AND RoleID <> 23 Order by RoleDescription", 200, m_strRoleID.ToString, , True, True))
        'tblHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRole", "usp_sel_Role_for_SearchResource", 200, m_strRoleID.ToString, , True, True))
        ''End Modification by SanaS on 17-Sep-2009 
        'tblHTML.Append("</td>")

        'tblHTML.Append("<td style='width:25%;text-align:right' align=right>Skill")
        'tblHTML.Append("</td>")
        'tblHTML.Append("<td style='width:25%' align=Left >")
        ''Modified by SanaS on 17-Sep-2009 
        ''tblHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSkill", "select distinct T.ToolID,[Description] from tbl_PM_Tools T ORDER BY [Description]", 200, m_strSkillID.ToString, , True, True))
        'tblHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSkill", " usp_sel_Skill_for_SearchResource", 200, m_strSkillID.ToString, , True, True))
        ''End Modification by SanaS on 17-Sep-2009 
        'tblHTML.Append("</td></TR>")

        '''added by RohiniK on 28 Oct 09 for S1 Changes
        'tblHTML.Append("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        'tblHTML.Append("<td style='width:25%;text-align:right' align=right>Type</TD>")
        'tblHTML.Append("<td style='width:25%' align=Left >")
        ''tblHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("optType", "optType", , TypeSelected, "Demand", False, , True))
        ''tblHTML.Append("Corporate")
        ''tblHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("optType", "optType", , TypeSelected, "Execution", False, , True))
        ''tblHTML.Append("Project</td>")
        'tblHTML.Append(CommonFunction.HTMLControls.DrawComboBox("optType", "select 'Demand' , 'Opportunity' union select 'Execution', 'Execution'", 100, m_TypeSelected, , True, True))
        'tblHTML.Append("<td></td><td></td>")
        'tblHTML.Append("</TR>")
        '''End of addition by RohiniK on 28 Oct 09 for S1 Changes
        ''End of comment by RohiniK on 30 Oct 09 for S1 Changes

        'Apply and close buttons
        'CommonFunction.General.WriteHTML("<TABLE id='tblButton' class='clsGridTable' cellspacing='0' cellpadding='0'>")
        tblHTML.Append("<tr class='clsTRPageCaption'><td colspan='4'  style='text-align:center;' width=4% height=15%>")
        'CommonFunctions.General.WriteHTML("<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;' href='javascript:Apply_OnClick()' ><Font Size=1>Apply</Font></a>&nbsp;&nbsp;&nbsp;&nbsp;")
        'CommonFunctions.General.WriteHTML("<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;' href='javascript:Clear_OnClick()' ><Font Size=1>Clear</Font></a></TD>")

        tblHTML.Append("<input class=ButtonStyle type=button id=btnApply onclick='Apply_OnClick()' value=""Apply"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")


        tblHTML.Append("</TR>")
        tblHTML.Append("</Table>")
        tblHTML.Append("</div>")

    End Sub
    Private Function GetBGwiseOU() As String
        Dim dr As IDataReader
        Dim strQuery As String
        Dim strBGID As String
        Dim strJscript As String = "BG"
        If Request.QueryString("BGID") Is Nothing OrElse Request.QueryString("BGID") = "" Then
            strBGID = "NULL"
        Else
            strBGID = Request.QueryString("BGID")
        End If

        strQuery = "usp_sel_OrganizationUnits_LevelWise_PassI_II  " + strBGID + "," + Session("intUserID").ToString
        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            strJscript = strJscript + "$___#" + CType(dr("LocationID"), String) + "$___#" + CType(dr("Location"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript
    End Function
    Private Sub drawMonthNameHeadings(ByRef objStringBuilder As System.Text.StringBuilder)
        Dim Iterator As Integer
        Dim StartYear As Integer
        Dim StartMonth As Integer
        Iterator = 1

        StartYear = GantView_StartDt.Year
        StartMonth = GantView_StartDt.Month

        While Iterator <= MonDiff
            Select Case StartMonth
                Case 1
                    objStringBuilder.Append("<TD id='Month1' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Jan(" + StartYear.ToString + ") </TD>" + vbCrLf)
                Case 2
                    objStringBuilder.Append("<TD id='Month2' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Feb(" + StartYear.ToString + ") </TD>" + vbCrLf)
                Case 3
                    objStringBuilder.Append("<TD id='Month3' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Mar(" + StartYear.ToString + ")</TD>" + vbCrLf)
                Case 4
                    objStringBuilder.Append("<TD id='Month4' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Apr(" + StartYear.ToString + ")</TD>" + vbCrLf)
                Case 5
                    objStringBuilder.Append("<TD id='Month5' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > May(" + StartYear.ToString + ")</TD>" + vbCrLf)
                Case 6
                    objStringBuilder.Append("<TD id='Month6' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Jun(" + StartYear.ToString + ")</TD>" + vbCrLf)
                Case 7
                    objStringBuilder.Append("<TD id='Month7' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Jul(" + StartYear.ToString + ")</TD>" + vbCrLf)
                Case 8
                    objStringBuilder.Append("<TD id='Month8' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Aug(" + StartYear.ToString + ")</TD>" + vbCrLf)
                Case 9
                    objStringBuilder.Append("<TD id='Month9' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Sep(" + StartYear.ToString + ")</TD>" + vbCrLf)
                Case 10
                    objStringBuilder.Append("<TD id='Month10' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Oct(" + StartYear.ToString + ")</TD>" + vbCrLf)
                Case 11
                    objStringBuilder.Append("<TD id='Month11' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Nov(" + StartYear.ToString + ")</TD>" + vbCrLf)
                Case 12
                    objStringBuilder.Append("<TD id='Month12' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Dec(" + StartYear.ToString + ")</TD>" + vbCrLf)
            End Select
            If StartMonth = 12 Then
                StartMonth = 1
                StartYear += 1
            Else
                StartMonth = StartMonth + 1
            End If
            Iterator += 1
        End While
    End Sub

    'Added by ShraddhaM on 17,Sept 2008
    'Purpose : Resource Allocation from advanced searched resources in Whiziblesem8.0
    Private Sub drawMonthlyDistribution(ByRef objStringBuilder As System.Text.StringBuilder, ByVal Pipe_OR_Team_PK As String, ByVal IsDorP As String, ByVal StartDate As String, ByVal EndDate As String)
        Dim Iterator As Integer
        Dim StartYear As Integer
        Dim StartMonth As Integer
        Dim strQuery As String
        Dim strMonthDistribution As String
        Dim arrMonthDistribution() As String
        Dim strDistribution As String
        Dim arrDistribution() As String
        Dim drDistribution As IDataReader
        Dim i As Integer
        Iterator = 1

        StartYear = GantView_StartDt.Year
        StartMonth = GantView_StartDt.Month

        'strQuery = "usp_Sel_MonthlyDistribution 9,'',''," + StartYear.ToString()
        strQuery = "usp_Sel_MonthlyDistribution " + Pipe_OR_Team_PK + ",'" + IsDorP + "','" + StartDate + "','" + EndDate + "'," + StartYear.ToString()

        strMonthDistribution = CommonFunction.Data.GetDataScalar(strQuery, MyBase.UseSQL).ToString()
        arrMonthDistribution = strMonthDistribution.Split(",")
        'commented by Sanas on 16-Oct-2009
        'For i = 0 To arrMonthDistribution.Length - 1
        '    strDistribution = arrMonthDistribution(i).ToString()
        '    arrDistribution = strDistribution.Split("|")

        '    'If arrDistribution(1).ToString() <> "-" Then
        '    If arrDistribution(0) = StartMonth Then

        '        If Iterator <= MonDiff Then

        '            objStringBuilder.Append("<TD id='Month1' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > " + arrDistribution(1).ToString() + "</TD>" + vbCrLf)

        '            'Select Case arrDistribution(0) 'StartMonth
        '            '    Case 1
        '            '        objStringBuilder.Append("<TD id='Month1' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > " + arrDistribution(1).ToString() + "</TD>" + vbCrLf)
        '            '    Case 2
        '            '        objStringBuilder.Append("<TD id='Month2' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > " + arrDistribution(1).ToString + " </TD>" + vbCrLf)
        '            '    Case 3
        '            '        objStringBuilder.Append("<TD id='Month3' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > " + arrDistribution(1).ToString + "</TD>" + vbCrLf)
        '            '    Case 4
        '            '        objStringBuilder.Append("<TD id='Month4' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > " + arrDistribution(1).ToString + "</TD>" + vbCrLf)
        '            '    Case 5
        '            '        objStringBuilder.Append("<TD id='Month5' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > " + arrDistribution(1).ToString + "</TD>" + vbCrLf)
        '            '    Case 6
        '            '        objStringBuilder.Append("<TD id='Month6' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > " + arrDistribution(1).ToString + "</TD>" + vbCrLf)
        '            '    Case 7
        '            '        objStringBuilder.Append("<TD id='Month7' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > " + arrDistribution(1).ToString + "</TD>" + vbCrLf)
        '            '    Case 8
        '            '        objStringBuilder.Append("<TD id='Month8' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > " + arrDistribution(1).ToString + "</TD>" + vbCrLf)
        '            '    Case 9
        '            '        objStringBuilder.Append("<TD id='Month9' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > " + arrDistribution(1).ToString + "</TD>" + vbCrLf)
        '            '    Case 10
        '            '        objStringBuilder.Append("<TD id='Month10' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > " + arrDistribution(1).ToString + "</TD>" + vbCrLf)
        '            '    Case 11
        '            '        objStringBuilder.Append("<TD id='Month11' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > " + arrDistribution(1).ToString + "</TD>" + vbCrLf)
        '            '    Case 12
        '            '        objStringBuilder.Append("<TD id='Month12' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > " + arrDistribution(1).ToString + "</TD>" + vbCrLf)
        '            'End Select
        '            If StartMonth = 12 Then
        '                StartMonth = 1
        '                StartYear += 1
        '            Else
        '                StartMonth = StartMonth + 1
        '            End If
        '            Iterator += 1
        '        End If
        '    End If
        'Next
        'end Commented by SanaS on 16-Oct-2009
        'Added by SanaS on 16-Oct-2009
        strDistribution = arrMonthDistribution(0).ToString()
        arrDistribution = strDistribution.Split("|")
        If arrDistribution(0) <> StartMonth Then
            While arrDistribution(0) <> StartMonth
                objStringBuilder.Append("<TD id='Month1' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" >  - </TD>" + vbCrLf)
                If StartMonth = 12 Then
                    StartMonth = 1
                    StartYear += 1
                Else
                    StartMonth = StartMonth + 1
                End If
                Iterator += 1
            End While
        End If
        For i = 0 To arrMonthDistribution.Length - 1
            strDistribution = arrMonthDistribution(i).ToString()
            arrDistribution = strDistribution.Split("|")
            If arrDistribution(0) = StartMonth Then
                If Iterator <= MonDiff Then
                    objStringBuilder.Append("<TD id='Month1' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > " + arrDistribution(1).ToString() + "</TD>" + vbCrLf)
                End If
            End If
            If StartMonth = 12 Then
                StartMonth = 1
                StartYear += 1
            Else
                StartMonth = StartMonth + 1

            End If
            Iterator += 1
        Next
        If Iterator < MonDiff Then
            While Iterator <= MonDiff
                objStringBuilder.Append("<TD id='Month1' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" >  - </TD>" + vbCrLf)
                Iterator += 1
            End While
        End If


        'End Addition by SanaS on 16-Oct-2009
    End Sub

    Private Sub ProcessSoftBooking()
        Dim strQuery As String
        Dim OpportunityID As String
        Dim Pipe_OR_Team_PK As String
        Dim EmployeeID As String
        Dim ResourceInDate As String
        Dim ResourceOutDate As String

        OpportunityID = Request.QueryString("PRJID").ToString()
        Pipe_OR_Team_PK = Request.QueryString("Pipe_OR_Team_PK").ToString()
        EmployeeID = Request.QueryString("EmpID").ToString()
        ResourceInDate = Request.QueryString("SD").ToString()
        ResourceOutDate = Request.QueryString("ED").ToString()


        strQuery = "usp_INS_tbl_RM_SoftBooking_AllocateResource " + OpportunityID + "," + Pipe_OR_Team_PK + "," + EmployeeID + ",'" + ResourceInDate + "','" + ResourceOutDate + "','" + Session("strUserName").ToString() + "'"
        CommonFunction.Data.InsertOrUpdateData(strQuery, True)

        'strQuery = "usp_upd_AllocatedResource_Distribution 'D'," + Pipe_OR_Team_PK + ",'" + ResourceInDate + "','" + ResourceOutDate + "'"
        'CommonFunction.Data.InsertOrUpdateData(strQuery, True)

        'CommonFunction.General.WriteHTML("<script>")
        'CommonFunction.General.WriteHTML("alert('Resource successfully soft booked');")
        'CommonFunction.General.WriteHTML("</script>")

    End Sub
    'End of addition by ShraddhaM on 17,Sept 2008
End Class
Class cGanttChart_Month

    Private m_PKID As String
    Private m_arrStartDt As System.Collections.ArrayList
    Private m_arrEndDt As System.Collections.ArrayList
    Private m_arrBench As System.Collections.ArrayList
    Private m_PlottingPeriod_BookPeriod_Color As String = "Red"
    Private m_PlottingPeriod_AvailabilityPeriod_Color As String = "Blue"
    Private m_AvailabilityPeriod_Color As String = "White"
    Private m_GanttStartDt As DateTime
    Private m_GanttEndDt As DateTime
    Private m_MonDiff As Integer
    Private m_ResponseWriter As System.Text.StringBuilder
    Private m_Ref_GanttStartDt As DateTime
    Private m_Ref_GanttEndDt As DateTime





    Sub New(ByVal GanttStartDate As DateTime, ByVal GanttEndDate As DateTime, ByVal MonDiff As Integer, ByVal PrimaryKey As String, ByRef ResponseWriter As System.Text.StringBuilder)
        m_GanttStartDt = GanttStartDate
        m_GanttEndDt = GanttEndDate
        m_MonDiff = MonDiff
        m_PKID = PrimaryKey
        m_ResponseWriter = ResponseWriter
    End Sub
    Public WriteOnly Property Ref_GanttStartDate() As DateTime
        Set(ByVal Value As DateTime)
            m_Ref_GanttStartDt = Value
        End Set
    End Property
    Public WriteOnly Property Ref_GanttEndDate() As DateTime
        Set(ByVal Value As DateTime)
            m_Ref_GanttEndDt = Value
        End Set
    End Property
    Public WriteOnly Property PlottingStartDates() As ArrayList
        Set(ByVal Value As ArrayList)
            m_arrStartDt = Value
        End Set
    End Property

    Public WriteOnly Property PlottingEndDates() As ArrayList
        Set(ByVal Value As ArrayList)
            m_arrEndDt = Value
        End Set
    End Property

    Public WriteOnly Property OnBench() As ArrayList
        Set(ByVal Value As ArrayList)
            m_arrBench = Value
        End Set
    End Property

    Public Sub drawMonthGantt(ByVal BenchColor As Boolean)

        If BenchColor = True Then
            'If HR_PipelineGraphicalView.blnOnBenchForPlotting = True Then
            m_PlottingPeriod_BookPeriod_Color = "Green"
            'End If
        End If

        If m_arrStartDt Is Nothing OrElse m_arrEndDt Is Nothing Then
            Throw New Exception("Gantt Start Dates or End Dates are not initialized")
        End If
        If m_arrStartDt.Count <> m_arrEndDt.Count OrElse m_arrStartDt.Count = 0 Then
            Throw New Exception("Gantt Start Dates or End Dates are not properly initialized")
        End If
        If m_arrStartDt.Count > 1 And (m_Ref_GanttEndDt = New DateTime Or m_Ref_GanttStartDt = New DateTime) Then
            Throw New Exception("Gantt Reference chart Start Dates or End Dates are not initialized")
        End If

        drawMonths()

    End Sub

    Private Sub drawMonths()
        Dim Iterator As Integer
        Dim StartMonth As Integer
        Dim Year As Integer
        StartMonth = m_GanttStartDt.Month
        Year = m_GanttStartDt.Year

        Iterator = 1
        While Iterator <= m_MonDiff
            'tblHTML.Append("<TD style=""border-bottom: thin solid gray"" id='MonthValues" + CType(jMonCounter, String) + "'>" + vbCrLf)
            'tblHTML.Append("<TD style=""border-bottom: thin solid gray;padding-right: 0pt;padding-left: 0pt;padding-bottom: 0pt;padding-top: 0pt;"" >" + vbCrLf)
            m_ResponseWriter.Append("<TD style=""padding-right: 0pt;padding-left: 0pt;padding-bottom: 0pt;padding-top: 0pt;"" >" + vbCrLf)
            'Jan

            Select Case StartMonth
                Case 1
                    Call DrawJan(Year)
                Case 2
                    Call DrawFeb(Year)
                Case 3
                    Call DrawMar(Year)
                Case 4
                    Call DrawApr(Year)
                Case 5
                    Call DrawMay(Year)
                Case 6
                    Call DrawJun(Year)
                Case 7
                    Call DrawJul(Year)
                Case 8
                    Call DrawAug(Year)
                Case 9
                    Call DrawSep(Year)
                Case 10
                    Call DrawOct(Year)
                Case 11
                    Call DrawNov(Year)
                Case 12
                    Call drawDec(Year)
            End Select
            'jMonCounter += 1
            m_ResponseWriter.Append("</TD>" + vbCrLf)

            If StartMonth = 12 Then
                Year = Year + 1
                StartMonth = 1
            Else
                StartMonth = StartMonth + 1
            End If
            Iterator += 1

        End While 'End of Month while Loop
    End Sub

    Private Sub DrawJan(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        'If m_arrStartDt.Count = 1 Then
        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 1, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 1, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    'If ((dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And HR_PipelineGraphicalView.blnOnBench = False)) Then
                    If (dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime)) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        Exit For
                    End If

                    If (dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime)) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    'If ((dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt) OrElse (HR_PipelineGraphicalView.blnOnBench = True And dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt)) Then
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
            Next
        End If
        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawFeb(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To DateTime.DaysInMonth(Year, 2)
                dtForToolTip = New Date(Year, 2, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|2|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|2|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To DateTime.DaysInMonth(Year, 2)
                dtForToolTip = New Date(Year, 2, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
            Next
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawMar(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 3, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|3|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|3|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 3, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
            Next
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawApr(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 30
                dtForToolTip = New Date(Year, 4, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|4|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|4|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 30
                dtForToolTip = New Date(Year, 4, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
            Next
        End If


        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawMay(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 5, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|5|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|5|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 5, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
            Next
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawJun(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 30
                dtForToolTip = New Date(Year, 6, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|6|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|6|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 30
                dtForToolTip = New Date(Year, 6, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        '    Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
            Next
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawJul(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 7, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|7|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|7|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 7, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        '    Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
            Next
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawAug(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 8, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|8|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|8|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 8, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        '    Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
            Next
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawSep(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 30
                dtForToolTip = New Date(Year, 9, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|9|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|9|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 30
                dtForToolTip = New Date(Year, 9, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        '    Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
            Next
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawOct(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 10, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|10|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|10|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 10, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
            Next
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub DrawNov(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime

        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 30
                dtForToolTip = New Date(Year, 11, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|11|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|11|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 30
                dtForToolTip = New Date(Year, 11, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        Exit For
                    End If

                    If dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If


                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
            Next
        End If

        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub
    Private Sub drawDec(ByVal Year As Integer)
        Dim strForToolTip As String
        Dim dtForToolTip As Date
        Dim cntDay As Integer
        Dim Color As String

        Dim iterator As Integer
        Dim minOfRecStartDt As DateTime
        Dim maxOfRecEndDt As DateTime


        m_ResponseWriter.Append("<TABLE border=0 width=100% cellspacing=0>" + vbCrLf)

        m_ResponseWriter.Append("<TR width=33% Year='" + Year.ToString + "' height=45%>" + vbCrLf)

        If m_Ref_GanttStartDt = New DateTime Then

            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 12, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)
                'If cntDay >= MonthStartDay And cntDay <= MonthEndDay Then
                If dtForToolTip >= CType(m_arrStartDt(0), DateTime) And dtForToolTip <= CType(m_arrEndDt(0), DateTime) Then
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|12|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_PlottingPeriod_BookPeriod_Color + "></TD>" + vbCrLf)
                Else
                    m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|12|" + CType(cntDay, String) + "' height=2px bgcolor=" + m_AvailabilityPeriod_Color + "></TD>" + vbCrLf)
                End If

            Next
        Else
            For cntDay = 1 To 31
                dtForToolTip = New Date(Year, 12, cntDay)
                strForToolTip = CommonFunction.Dates.CGetDate(dtForToolTip)

                Color = m_AvailabilityPeriod_Color

                For iterator = 0 To m_arrStartDt.Count - 1
                    If (dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime)) And CType(m_arrBench(iterator), Boolean) = False Then
                        Color = m_PlottingPeriod_BookPeriod_Color
                        Exit For
                    End If

                    If (dtForToolTip >= CType(m_arrStartDt(iterator), DateTime) And dtForToolTip <= CType(m_arrEndDt(iterator), DateTime)) And CType(m_arrBench(iterator), Boolean) = True Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If

                Next
                If Color <> m_PlottingPeriod_BookPeriod_Color Then
                    'For iterator = 0 To m_arrStartDt.Count - 1
                    If dtForToolTip >= m_Ref_GanttStartDt And dtForToolTip <= m_Ref_GanttEndDt Then
                        Color = m_PlottingPeriod_AvailabilityPeriod_Color
                        'Exit For
                    End If
                    'Next
                End If

                m_ResponseWriter.Append("<TD Date='" + dtForToolTip.ToString("dd-MMM-yyyy") + "' Title='" + strForToolTip + "' id='" + m_PKID + "|1|" + CType(cntDay, String) + "' height=2px bgcolor=" + Color + "></TD>" + vbCrLf)
            Next

        End If
        m_ResponseWriter.Append("</tr></table>" + vbCrLf)
    End Sub

End Class



