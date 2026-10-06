'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  PbNITE
' Module Name           :  PM_EarnedValueReport.aspx
' Purpose               :  
' Description           :  
' Dependencies          :  None
' Author                :  PrakashR
' Reviewed              :  
' Tested                :  
' Created               :  
' Revisions             :  
'=====================================================================

#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class PM_EarnedValueReport
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    'Protected WithEvents frmTimeSheet As System.Web.UI.HtmlControls.HtmlForm

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
        'Added by Yogesh J on on 04-Feb-2016 to validate Token
        If Request.QueryString("ProjectID") <> "" And Request.QueryString("PKToken") <> "" And Request.QueryString("Mode") = "Generate" And Request.QueryString("strID") <> "" Then

            If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("FromDate"), String) + CType(Request.QueryString("ToDate"), String) + CType(Request.QueryString("ProjectID"), String) + CType(Request.QueryString("strID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Show Earned Value", 0, 0, "Task ID", CType(Request.QueryString("strID"), String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        ''End of addition by Yogesh J on on 04-Feb-2016 to validate Token
    End Sub
#End Region

#Region "Member Variables"

    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0

    Private m_objGlobal As WebPages.Template.IGlobal    ' To store Global object
    Protected m_strProjectID As String                         ' to store selected Project ID
    Protected m_strMode As String                             ' indicates mode of page 'GenerateReport' or ' 
    Protected m_strFromdate As String                         ' to store Project Start Date  
    Protected m_strTodate As String                           ' to strore selected Endate for the Report
    Dim m_strSessionUserID As String                    ' to store session user id
    Public Const GRAPH_DIRECTORY As String = "../../images/DB_Graphs/"  ' EV graph location
    Private m_intGraphHeight As Integer                 'EV graph Height    
    Private m_intGraphWidth As Integer                  ' EV graph width

    'Grid variables
    Private WithEvents objEVDetails As New WebPage.Templates.GenericGrid

    'to store EV status
    Dim m_strStatus As String
    Dim m_strPossibleSolutions As String
    Dim m_strPossibleCauses As String


    Public m_strID As String                               ' Store the Selected Value from second Combo
    Public m_strType As String                             ' Store Type of Second Combo
    Dim m_Phaseselected As Boolean
    Dim m_Subprojectselected As Boolean
    Dim m_Milestoneselected As Boolean
    Dim m_Moduleselected As Boolean

    ' Added By NitinVS on 15 March 2005 for PBNITE SP2
    ' To add filter for Deliverable 
    Dim m_Deliverableselected As Boolean
    Dim m_ReportID As String
    ' End Addition By NitinVS no 15 March 2005 for PBNITE SP2
#End Region

#Region "Functions and Sub-Procedures"

    Public Sub BuildPage()
        '=====================================================================
        ' Procedure Name        : BuildPage()	
        ' Purpose               : Main procedure to build the page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Aug 04, 2004
        ' Revisions             :
        '=====================================================================

        Call SetVariables()

        Response.Write(GenerateMenu())

        'Initialize resource file 
        MyBase.InitializeResources("AppResources.PM_EarnedValueReport", "AppResources")

        Call GeneratePageCaption()

        Call GeneratePageHeader()

        Call DisplayPageDetails()

        Response.Write(GenerateMenu())


    End Sub


    Private Sub DisplayPageDetails()
        Dim strHTML As String
        Dim strCase As String

        Dim strPossibleCauses As String
        Dim strPossibleSolutions As String
        Dim objSection As WebPages.Template.SectionTitle
        Dim strTitle As String
        Dim strProjectName As String
        Dim drProjectInfo As IDataReader
        Dim strFilterValue As String = ""

        '-- Get Project Name
        drProjectInfo = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " + m_strProjectID, MyBase.UseSQL)
        If drProjectInfo.Read Then
            strProjectName = CommonFunctions.Data.CheckIsDBNull(drProjectInfo("ProjectName"), "").ToString
        End If
        CommonFunctions.Data.DisposeDataReader(drProjectInfo)


        'Main Div
        CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:630px'>")

        If m_strMode.ToUpper = "GENERATE" Then
            objSection = New WebPages.Template.SectionTitle
            strTitle = MyBase.GetResourceString("PAGE_HEADER")
            strTitle = strTitle.Replace("[PROJECTNAME]", strProjectName)
            strTitle = strTitle.Replace("[FROMDATE]", CommonFunctions.Dates.CGetDate(CType(m_strFromdate, Date)))
            strTitle = strTitle.Replace("[TODATE]", CommonFunctions.Dates.CGetDate(CType(m_strTodate, Date)))

            ' Added By NitinVS on 15 March 2005 for PBNITE SP2
            ' To Show the details of the filter which is selected 

            If m_strID <> "0" Then
                strFilterValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("EXEC usp_sel_EarnedValueFilterValue " + m_strID + " , " + m_strType, MyBase.UseSQL), "")

                If strFilterValue <> "" Then
                    strTitle = strTitle.Replace("[PARAMETER]", strFilterValue)
                Else
                    strTitle = strTitle.Replace("[PARAMETER]", " ")
                End If
            Else
                strTitle = strTitle.Replace("[PARAMETER]", " ")
            End If

            'End Addition By NitinVS on 15 March 2005 for PBNITE SP2

            Response.Write(objSection.GetSectionTitle(strTitle, "", ""))
        End If
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168


        CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTREven " + ">")

        If m_strMode.ToUpper <> "GENERATE" Then

            CommonFunctions.General.WriteHTML("<TD align=right>" + MyBase.GetResourceString("SELECT_PROJECT") + "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")

            'Modified By VidyaJ - SP4 - IssueID - 362
            Dim intRoleLevel As Integer
            Dim m_strProjectFilters As String
            intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)
            m_strProjectFilters = ""
            'If middle level then apply filter for Projects
            If intRoleLevel = 2 Then
                'Apply Role Access Filter for Project List
                m_strProjectFilters = ""
                Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
                If strFilter <> "" Then
                    m_strProjectFilters += strFilter
                End If

                Dim strRemove As String = "ProjectID IN"
                m_strProjectFilters = m_strProjectFilters.Remove(0, strRemove.Length)

                m_strProjectFilters = m_strProjectFilters.Replace("'", "")
            End If

            'Display Project Combo
            If m_strProjectFilters <> "" Then
                'Commented and Added By ShraddhaM on 21,Aug 2007
                'Purpose : To remove Global Projects from EarnValue Report Project combo
                'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_Project_For_DA_Active_InActive_Projects " & m_strSessionUserID & ",NULL,NULL,'" & m_strProjectFilters & "'", , m_strProjectID, "" + " Langugage=JavaScript OnChange=cboProject_change()", , True, , True))
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_Project_For_DA_Active_InActive_Projects_ForEarnValue " & m_strSessionUserID & ",NULL,NULL,'" & m_strProjectFilters & "'", , m_strProjectID, "" + " Langugage=JavaScript OnChange=cboProject_change()", , True, , True))
            Else
                'Commented and Added By ShraddhaM on 21,Aug 2007
                'Purpose : To remove Global Projects from EarnValue Report Project combo
                'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_Project_For_DA_Active_InActive_Projects " & m_strSessionUserID, , m_strProjectID, "" + " Langugage=JavaScript OnChange=cboProject_change()", , True, , True))
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_Project_For_DA_Active_InActive_Projects_ForEarnValue " & m_strSessionUserID, , m_strProjectID, "" + " Langugage=JavaScript OnChange=cboProject_change()", , True, , True))
            End If

            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD align=Left>")
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("</TR>")

            ' Code Added by RajkumarM on 6th Han 2004

            ' Display Option Buttons

            'Display Phase Option
            CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
            CommonFunctions.General.WriteHTML("<TD></TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optPhase", "optPhase", , m_Phaseselected, , , "" + " Langugage=JavaScript OnClick=optPhase_click()", True, ))
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PHASE"))
            'CommonFunctions.General.WriteHTML("</TD>")
            'CommonFunctions.General.WriteHTML("<TD align=left>")

            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optSubProject", "optSubProject", , m_Subprojectselected, , , "" + " Langugage=JavaScript OnClick=optSubProject_click()", True, ))
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SUBPROJECT"))

            ' Added By NitinVS on 15 March 2005 for PBNITE SP2
            ' To add one more option for Deliverables

            'CommonFunctions.General.WriteHTML("</TD>")

            'CommonFunctions.General.WriteHTML("<TD align=left >")

            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optDeliverable", "optDeliverable", , m_Deliverableselected, , , "" + " Langugage=JavaScript OnClick=optDeliverable_click()", True, ))
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("DELIVERABLE"))

            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD align=Left>")
            CommonFunctions.General.WriteHTML("</TD>")

            ' End addition By NitinVS on 15 March 2005 for PBNITE SP2

            CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
            CommonFunctions.General.WriteHTML("<TD></TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optModule", "optModule", , m_Moduleselected, , , "" + " Langugage=JavaScript OnClick=optModule_click()", True, ))
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("MODULE"))
            'CommonFunctions.General.WriteHTML("</TD>")
            'CommonFunctions.General.WriteHTML("<TD align=left>")

            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optMilestone", "optMilestone", , m_Milestoneselected, , , "" + " Langugage=JavaScript OnClick=optMilestone_click()", True, ))
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("MILESTONE"))

            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD align=Left>")
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("</TR>")

            If m_strType = "1" Then
                'Display Phase Combos

                CommonFunctions.General.WriteHTML("<TR class=clsTREven " + "><TD align=right>" + MyBase.GetResourceString("SELECT_PHASE") + "</TD>")
                CommonFunctions.General.WriteHTML("<TD align=left >")

                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboPhase", "usp_Sel_EV_Filters " & m_strProjectID & ", " & m_strType, 300, m_strID, "" + " Langugage=JavaScript OnChange=cboPhase_change()", True, True, , False))
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD align=Left>")
                CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("</TR>")
            ElseIf m_strType = "2" Then
                'Display SubProject Combo
                CommonFunctions.General.WriteHTML("<TR class=clsTREven " + "><TD align=right>" + MyBase.GetResourceString("SELECT_SUBPROJECT") + "</TD>")
                CommonFunctions.General.WriteHTML("<TD align=left >")

                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboSubProject", "usp_Sel_EV_Filters " & m_strProjectID & ", " & m_strType, 300, m_strID, "" + " Langugage=JavaScript OnChange=cboSubProject_change()", True, True, , False))
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD align=Left>")
                CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("</TR>")
            ElseIf m_strType = "3" Then
                'Display Module Combo m_strPhaseID
                CommonFunctions.General.WriteHTML("<TR class=clsTREven " + "><TD align=right>" + MyBase.GetResourceString("SELECT_MODULE") + "</TD>")
                CommonFunctions.General.WriteHTML("<TD align=left >")

                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "usp_Sel_EV_Filters " & m_strProjectID & ", " & m_strType, 300, m_strID, "" + " Langugage=JavaScript OnChange=cboModule_change()", True, True, , False))
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD align=Left>")
                CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("</TR>")
            ElseIf m_strType = "4" Then
                'Display Milestone Combo
                CommonFunctions.General.WriteHTML("<TR class=clsTREven " + "><TD align=right>" + MyBase.GetResourceString("SELECT_MILESTONE") + "</TD>")
                CommonFunctions.General.WriteHTML("<TD align=left >")

                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboMilestone", "usp_Sel_EV_Filters " & m_strProjectID & ", " & m_strType, 300, m_strID, "" + " Langugage=JavaScript OnChange=cboMilestone_change()", True, True, , False))
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD align=Left>")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD align=Left>")
                CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("</TR>")

                ' Added By NitinVS on 15 March 2005 for PBNITE SP2
                ' To add one more option for Deliverables

            ElseIf m_strType = "5" Then
                'Display Deliverable Combo
                CommonFunctions.General.WriteHTML("<TR class=clsTREven " + "><TD align=right>" + MyBase.GetResourceString("SELECT_DELIVERABLE") + "</TD>")
                CommonFunctions.General.WriteHTML("<TD align=left >")

                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboDeliverable", "usp_Sel_EV_Filters " & m_strProjectID & ", " & m_strType, 300, m_strID, "" + " Langugage=JavaScript OnChange=cboDeliverable_change()", True, True, , False))
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD align=Left>")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("<TD align=Left>")
                CommonFunctions.General.WriteHTML("</TD>")

                CommonFunctions.General.WriteHTML("</TR>")

                ' End addition By NitinVS on 15 March 2005 for PBNITE SP2

            End If

            ' Code Addition Ends
            'Display Start and End Date
            CommonFunctions.General.WriteHTML(" <TR class=clsTREven > ")
            CommonFunctions.General.WriteHTML("<TD align=right>" + MyBase.GetResourceString("FROMDATE") + "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")
            'Start_JG_7960_11-Dec-2006
            'CommonFunction.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , CommonFunction.Dates.GetDate(CType(m_strFromdate, Date)), , "frmPM_EarnedValueReport", , , , True)
            If m_strFromdate <> "" Then
                CommonFunction.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , CommonFunction.Dates.GetDate(CType(m_strFromdate, Date)), , "frmPM_EarnedValueReport", , , , True)
            Else
                CommonFunction.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , m_strFromdate, , "frmPM_EarnedValueReport", , , , True)
            End If
            'End_JG_7960_11-Dec-2006
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("FROMDATE_COMMENT"))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD width=0></TD>")

            CommonFunctions.General.WriteHTML("</TR>")

            CommonFunctions.General.WriteHTML(" <TR class=clsTREven > ")
            CommonFunctions.General.WriteHTML("<TD align=right>" + MyBase.GetResourceString("TODATE") + "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")
            'Start_JG_7960_11-Dec-2006
            'CommonFunction.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , CommonFunction.Dates.GetDate(CType(m_strTodate, Date)), , "frmPM_EarnedValueReport")
            If m_strTodate <> "" Then
                CommonFunction.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , CommonFunction.Dates.GetDate(CType(m_strTodate, Date)), , "frmPM_EarnedValueReport")
            Else
                CommonFunction.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , m_strTodate, , "frmPM_EarnedValueReport")
            End If
            'End_JG_7960_11-Dec-2006
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD align=Left>")
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("</TR>")

        Else
                ' Added By NitinVS on 21 March 2005 for PBNITE SP2 
                ' To Display the Weekly Summary Report for Earned Value Report 

                CommonFunctions.General.WriteHTML(" <TD>")
                Call GenerateReportGraph()
                CommonFunctions.General.WriteHTML(" </TD>")
                CommonFunctions.General.WriteHTML(" <TD>")
                Call DisplayEVDetails()
                CommonFunctions.General.WriteHTML(" </TD></TR>")

            CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTREven " + ">")
                CommonFunctions.General.WriteHTML("<TD align=right valign=top><B>" + MyBase.GetResourceString("STATUS") + "</B></TD>")
                CommonFunctions.General.WriteHTML("<TD align=left valign=top colspan=6>")
                CommonFunctions.General.WriteHTML(m_strStatus + "</TD></TR>")

                CommonFunctions.General.WriteHTML(" <TR class=clsTREven > ")
                CommonFunctions.General.WriteHTML("<TD align=right valign=top><B>" + MyBase.GetResourceString("POSSIBLECAUSES") + "</B></TD>")
                CommonFunctions.General.WriteHTML("<TD align=left valign=top colspan=6>")
                CommonFunctions.General.WriteHTML(m_strPossibleCauses + "</TD></TR>")

                CommonFunctions.General.WriteHTML(" <TR class=clsTREven > ")
                CommonFunctions.General.WriteHTML("<TD align=right valign=top><B>" + MyBase.GetResourceString("POSSIBLESOLUTIONS") + "</B></TD>")
                CommonFunctions.General.WriteHTML("<TD align=left valign=top  colspan=6>")
                CommonFunctions.General.WriteHTML(m_strPossibleSolutions + "</TD></TR>")
                CommonFunctions.General.WriteHTML("</TABLE>")


            End If
            CommonFunctions.General.WriteHTML("</TABLE></DIV>")



    End Sub


    Private Sub DisplayEVDetails()
        '=====================================================================
        ' Procedure Name        : DisplayEVDetails()	
        ' Purpose               : TO display EV deatils
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Aug 05, 2004
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String
        Dim ArrActualFieldNames() As String = {"FieldName", "FieldValue", "EVElementName"}

        Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("FIELDNAME"), " ", "  "}
        Dim ArrTDStyle() As String = {"align=left width=60% colspan=2", "align=right width=40%", ""}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Start_JG_7960_11-Dec-2006
        'strSQL = " EXEC usp_Sel_EarnedValueReport '" + m_strFromdate + "','" + m_strTodate + "'," + m_strProjectID
        strSQL = " EXEC usp_Sel_EarnedValueReport '" + m_strFromdate + "','" + m_strTodate + "'," + m_strProjectID
        'End_JG_7960_11-Dec-2006

        If m_strID <> "0" Then
            '@intPEmployeeID ,@bFromPM ,@intPID ,@blnflag 
            strSQL = strSQL + ", Null , 1 , " + m_strID + " , " + m_strType
        End If

        With objEVDetails
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 2
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With


    End Sub
    Private Sub GenerateReportGraph()
        '=====================================================================
        ' Procedure Name        : GenerateReport()	
        ' Purpose               : to Generate Earned Value Report for selected Project and date range
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Aug 04, 2004
        ' Revisions             :
        '=====================================================================

        Dim dr As IDataReader
        Dim drGraph, drTemp As IDataReader
        Dim objGraph As Graph.Graph
        Dim strChartType As String
        Dim strSQL As String
        Dim strImageFileName As String = ""
        Dim blnShowLegends As Boolean = False
        Dim blnShowCaptions As Boolean = True
        Dim blnShowExplodedPie As Boolean = False
        Dim blnEnable3D As Boolean = False
        Dim lngEntityID As Long = 0
        Dim strNomenclature As String = ""
        Dim arrstrChartType() As String = {}
        Dim strVirtualImgPath As String
        Dim arr(2) As String
        Dim strSQL1 As String
        Dim strSQL2 As String
        Dim arrExtSQL(2) As String
        Dim arrExtType(2) As String
        Dim i As Integer
        Dim strQuery As String

        Dim arrColor() As String = {"blue", "Green"}

        ' Earned value query
        'Start_JG_7960_11-Dec-2006
        'strSQL = "  exec usp_CRW_EarnedValueReportDetails " + m_strProjectID + ",'" & m_strFromdate + "','" + m_strTodate + "'"
        strSQL = "  exec usp_CRW_EarnedValueReportDetails " + m_strProjectID + ",'" & m_strFromdate + "','" + m_strTodate + "'"
        'End_JG_7960_11-Dec-2006
        strSQL1 = strSQL + ",2" ' For EV
        strSQL2 = strSQL + ",3" ' For AC
        strSQL = strSQL + ",1" ' For PV and Total Budget    

        ' Modified BY NitinVS on 7 Jun 2007 for WhzibleSEM 7 
        ' Added Parameter for Company Work HRS 
        ' passed WorkingHRs as parameter
        If m_strID <> "0" Then
            strSQL = strSQL + "," + m_strID + "," + m_strType + " , " + CommonFunction.Application.HoursPerDay.ToString
            ' Added By NitinVS on 17 March 2005 for PBNITE SP2
            ' Added Filter for EV and AC
            strSQL1 = strSQL1 + "," + m_strID + "," + m_strType + " , " + CommonFunction.Application.HoursPerDay.ToString
            strSQL2 = strSQL2 + "," + m_strID + "," + m_strType + " , " + CommonFunction.Application.HoursPerDay.ToString
            ' End Addition By NitinVS on 17 March 2005 for PBNITE SP2
        Else
            strSQL += ",Null,0," + CommonFunction.Application.HoursPerDay.ToString
            strSQL1 += ",Null,0," + CommonFunction.Application.HoursPerDay.ToString
            strSQL2 += ",Null,0," + CommonFunction.Application.HoursPerDay.ToString
        End If

        ' End  Modification BY NitinVS on 7 Jun 2007 for WhzibleSEM 7 
        strImageFileName = "EV" + m_strSessionUserID
        blnShowLegends = True
        strNomenclature = "EV"
        blnShowCaptions = True

        ' create the graph for the item values
        objGraph = New Graph.Graph

        With objGraph
            strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
            .VirtualImagePath = strVirtualImgPath
            .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
            .ConnectionString = CommonFunction.Application.ConnectionString
            arrExtSQL(0) = strSQL1
            arrExtSQL(1) = strSQL2
            .ExtendedSeriesSQL = arrExtSQL
            arrExtType(0) = "LINE"
            arrExtType(1) = "LINE"
            .ExtendedSeriesGraphType = arrExtType
            .VirtualImagePath = ""
            .Enable3D = False
            arr(0) = "LINE"
            arr(1) = "LINE"
            arr(2) = "LINE"
            .ChartType = arr
            .GraphTitleColor = "black"
            .ChartBackColor = "PaleGoldenRod"
            .ChartAreaColor = "White"
            .ShowLegends = True
            .XAxisTitle = "Weeks"
            .Nomenclature = " Man Days "
            .LegendDocking = "bottom"
            .LegendStyle = "column"
            .LegendCaptionColor = "black"
            .PalleteStyle = "EARTHTONES"
            .EnableXAxis = True
            .EnableYAxis = True
            .EnableSmartLabels = False
            .ShowCaptions = False
            .GraphTitleColor = "Green"
            .ShowDataColumnNameAsXAxisTitle = False
            ' Added By NitinVS on 17 March 2005 for PBNITE SP2
            .ExtendedSeriesColor = arrColor

            '-- Fixed Settings
            .GraphTitle = MyBase.GetResourceString("GRAPHTITLE")
            .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
            .SQL = strSQL
            .Width = m_intGraphWidth
            .Height = m_intGraphHeight
            .ShowExplodedPie = False
            .LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)

            .BorderGradientColor = "WHITE"
            .BorderGradientStyle = "TOPBOTTOM"
            .ChartBackGradientColor = "WHITE"
            .ChartBackGradientStyle = "TOPBOTTOM"
            .ChartAreaGradientColor = "WHITE"
            .ChartAreaGradientStyle = "TOPBOTTOM"

            ' return the graph image
            .GenerateImage()
        End With


        '-- Display Graph
        If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY & "EV") & m_strSessionUserID & ".png") Then
            Response.Write("<IMG HEIGHT=" & m_intGraphHeight & " WIDTH=" & m_intGraphWidth & " src='" + GRAPH_DIRECTORY + "EV" & m_strSessionUserID & ".png" & "'>")
        Else
            Response.Write("<IMG src='..\..\images\NoPreview.gif'>")
        End If




    End Sub

    Private Function GenerateMenu() As String
        '=====================================================================
        ' function Name         : GenerateTopMenu()	
        ' Purpose               : To generate top menu
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Aug 06, 2004
        ' Revisions             :
        '=====================================================================


        Dim ArrTopMenuCaptionsList As New ArrayList
        Dim ArrTopMenuToolTipsList As New ArrayList
        Dim ArrTopMenuFunctionsList As New ArrayList

        'Initialize resource file 
        MyBase.InitializeResources("AppResources.PM_EarnedValueReport", "AppResources")
        If m_strMode.ToUpper <> "GENERATE" Then
            'Generate Report
            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_GENERATEREPORT"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_GENERATEREPORT_TOOLTIP"))
            ArrTopMenuFunctionsList.Add("GenerateReport()")
        Else
            'Initialize resource file 

            ' Added By NitinVS on 21 March 2005 for PBNITE SP2
            ' To Show the Weekly Summary Report 
            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("WEEKLY_SUMMARY_REPORT"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("WEEKLY_SUMMARY_REPORT"))
            ArrTopMenuFunctionsList.Add(" WeeklySummary_OnClink()")

            'To Show Weekly Details Report 
            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("WEEKLY_DETAILS_REPORT"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("WEEKLY_DETAILS_REPORT"))
            ArrTopMenuFunctionsList.Add(" WeeklyDetails_OnClink()")

            ' End Addition By NitinVS on 21 March 2005 for PBNITE SP2 

            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
            ArrTopMenuFunctionsList.Add(" Close_OnClink()")

        End If
        'Initialize resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        ArrTopMenuFunctionsList.Add("Help_OnClick(" & m_objGlobal.TagID & ")")

        Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
        ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
        ArrTopMenuCaptionsList = Nothing

        Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String
        ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)
        ArrTopMenuToolTipsList = Nothing

        Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
        ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)
        ArrTopMenuFunctionsList = Nothing

        'Generate menu string and return
        Return WebPage.Templates.StaticMenu.DrawMenu(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True) + "<BR>"
    End Function

    Private Sub GeneratePageHeader()
        '=====================================================================
        ' Procedure Name        : GeneratePageHeader()	
        ' Purpose               : to generate page header
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Aug 04, 2004
        ' Revisions             :
        '=====================================================================

        Dim objHeaderFooter As New WebPage.Templates.HeaderFooter
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing



    End Sub

    Private Sub GeneratePageCaption()
        '=====================================================================
        ' Procedure Name        : GeneratePageCaption()	
        ' Purpose               : to generate page caption
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Aug 04, 2004
        ' Revisions             :
        '=====================================================================
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, , , , True))

    End Sub





    Private Sub SetVariables()
        '=====================================================================
        ' Procedure Name        : SetVariables()	
        ' Purpose               : Set variable values (QueryString and form references)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Aug 04, 2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim drProject As IDataReader

        'Graph variables
        m_intGraphHeight = 350
        m_intGraphWidth = 500 '492

        'Set Global object
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()

        'Mode
        If Not Request.QueryString("Mode") Is Nothing Then
            If Request.QueryString("Mode") <> "" Then
                m_strMode = Request.QueryString("Mode")
            Else
                m_strMode = ""
            End If
        Else
            m_strMode = ""
        End If

        ' Code Added by RajkumarM

        ' Type of Second Combo
        If Not Request.QueryString("Type") Is Nothing Then
            If Request.QueryString("Type") <> "" Then
                m_strType = Request.QueryString("Type")
            Else
                m_strType = "1"
            End If
        Else
            m_strType = "1"
        End If

        If m_strType = "1" Then
            m_Phaseselected = True
        ElseIf m_strType = "2" Then
            m_Subprojectselected = True
        ElseIf m_strType = "3" Then
            m_Moduleselected = True
        ElseIf m_strType = "4" Then
            m_Milestoneselected = True
            ' Added By NitinVS on 15 March 2005 for PBNITE SP2
            ' To add one more option for Deliverables
        ElseIf m_strType = "5" Then
            m_Deliverableselected = True
            ' End addition By NitinVS on 15 March 2005 for PBNITE SP2
        End If

        ' End of Addition
        If m_strMode.ToUpper <> "GENERATE" Then

            'Get ProjectID
            If Not MyBase.GetFormValue("cboProject") Is Nothing Then
                If MyBase.GetFormValue("cboProject") <> "" Then
                    m_strProjectID = MyBase.GetFormValue("cboProject")
                Else
                    m_strProjectID = CType(Session("intProjectID"), String)
                End If
            Else
                m_strProjectID = CType(Session("intProjectID"), String)
            End If


            ' Code Added by RajkumarM for Phase , Milestone,SubProject and Module
            'Get PhaseID
            If Not MyBase.GetFormValue("cboPhase") Is Nothing Then
                If MyBase.GetFormValue("cboPhase") <> "" Then
                    m_strID = MyBase.GetFormValue("cboPhase")
                End If
            End If

            'Get SubProjectID
            If Not MyBase.GetFormValue("cboSubProject") Is Nothing Then
                If MyBase.GetFormValue("cboSubProject") <> "" Then
                    m_strID = MyBase.GetFormValue("cboSubProject")
                End If
            End If

            'Get ModuleID
            If Not MyBase.GetFormValue("cboModule") Is Nothing Then
                If MyBase.GetFormValue("cboModule") <> "" Then
                    m_strID = MyBase.GetFormValue("cboModule")
                End If
            End If

            'Get MilestoneID
            If Not MyBase.GetFormValue("cboMilestone") Is Nothing Then
                If MyBase.GetFormValue("cboMilestone") <> "" Then
                    m_strID = MyBase.GetFormValue("cboMilestone")
                End If
            End If

            ' Added By NitinVS on 15 March 2005 for PBNITE SP2
            ' To add one more option for Deliverables

            'Get DeliverableID
            If Not MyBase.GetFormValue("cboDeliverable") Is Nothing Then
                If MyBase.GetFormValue("cboDeliverable") <> "" Then
                    m_strID = MyBase.GetFormValue("cboDeliverable")
                End If
            End If

            ' End Addition By NitinVS on 15 March 2005 for PBNITE SP2

            If m_strID = "" Then
                m_strID = "0"
            End If

            ' End of Addition

            'From Date
            If Not MyBase.GetFormValue("txtFromDate") Is Nothing Then
                If MyBase.GetFormValue("txtFromDate") <> "" Then
                    m_strFromdate = MyBase.GetFormValue("txtFromDate")
                End If
            End If

            'To Date
            If Not MyBase.GetFormValue("txtToDate") Is Nothing Then
                If MyBase.GetFormValue("txtToDate") <> "" Then
                    m_strTodate = MyBase.GetFormValue("txtToDate")
                End If
            End If




            If m_strMode = "Change" Or m_strMode = "" Then

                'Get project start and End Date for selected Project
                strSQL = " Exec usp_Sel_tbl_PM_ProjectExpectedDates " + m_strProjectID
                drProject = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drProject) <> "" Then
                    If drProject.Read() Then
                        m_strFromdate = drProject.Item("ExpectedStartDate").ToString()
                        'Start_JG_7960_11-Dec-2006
                        'Purpose : Check Blank for FromDate and ToDate
                        If m_strFromdate <> "" Then
                            m_strFromdate = CommonFunctions.Dates.GetDate(CType(m_strFromdate, Date))
                        End If
                        m_strTodate = drProject.Item("ExpectedEndDate").ToString()
                        If m_strTodate <> "" Then
                            m_strTodate = CommonFunctions.Dates.GetDate(CType(m_strTodate, Date))
                        End If
                        'End_JG_7960_11-Dec-2006
                    End If
                End If
                CommonFunctions.Data.DisposeDataReader(drProject)


                ' To Get Dates from the Tasks under Second Combo Element

                If m_strID <> "0" Then
                    strSQL = " Exec usp_Sel_tbl_PM_EVExpectedDates " + m_strProjectID + ",'" + m_strID + "'," + m_strType
                    drProject = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                    If CommonFunctions.General.CheckIsNothing(drProject) <> "" Then
                        If drProject.Read() Then
                            m_strFromdate = drProject.Item("ExpectedStartDate").ToString()
                            m_strFromdate = CommonFunctions.Dates.GetDate(CType(m_strFromdate, Date))
                            m_strTodate = drProject.Item("ExpectedEndDate").ToString()
                            m_strTodate = CommonFunctions.Dates.GetDate(CType(m_strTodate, Date))

                        End If
                    End If
                    CommonFunctions.Data.DisposeDataReader(drProject)
                End If
            End If

            ' End of Addition
        Else
            m_strFromdate = Request.QueryString("FromDate")
            m_strTodate = Request.QueryString("Todate")
            m_strProjectID = Request.QueryString("ProjectID")
            m_strID = Request.QueryString("strID")
            m_strType = Request.QueryString("strType")
            ' Added By NitinVS on 21 March 2005 for PBNITE SP2 
            If Not CommonFunction.General.CheckIsNothing(Request.QueryString("Report"), "") = "" Then
                m_ReportID = CType(Request.QueryString("Report"), String)
            End If
            ' End Addition By NitinVS on 21 March 2005 for PBNITE 
        End If
        m_strSessionUserID = CType(Session("intUserID"), String)

    End Sub



    Public Sub New()

        '=====================================================================
        ' Procedure Name        : New()	
        ' Purpose               : Constructor for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             :
        '=====================================================================

        'Apply security
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'Initialize standard menu resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

    End Sub 'Constructor for the page



    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub objEVDetails_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objEVDetails.ColumnHeaderTD_BeforePrint
        If Args.DataField = "FieldValue" Then
            Args.StringToBeInserted = "<TD></TD>"
            Cancel = True
        End If
        If Args.DataField = "EVElementName" Then
            Cancel = True
        End If
    End Sub

    Private Sub objEVDetails_NoDataCommentTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_NoDataCommentTR) Handles objEVDetails.NoDataCommentTR_BeforePrint

    End Sub

    Private Sub objEVDetails_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles objEVDetails.ColumnHeaderTR_BeforePrint

    End Sub

    Private Sub objEVDetails_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objEVDetails.DataRowTD_BeforePrint
        Dim strColumn As String
        If Args.DataField = "EVElementName" Then
            Cancel = True
        End If

        strColumn = CType(Args.DataReader.Item("EVElementName"), String)
        If (strColumn = "Status") Or (strColumn = "PossibleCauses") Or (strColumn = "PossibleSolutions") Then
            Select Case strColumn
                Case "Status"
                    ' Modified by NitinVS on 30 Mar 2005 for PBNITE SP2 
                    'm_strStatus = CType(Args.DataReader.Item("FieldName"), String)
                    m_strStatus = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("FieldName"), ""), String)

                    m_strStatus = CommonFunctions.General.FormatString(m_strStatus, True)
                Case "PossibleCauses"
                    'm_strPossibleCauses = CType(Args.DataReader.Item("FieldName"), String)
                    m_strPossibleCauses = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("FieldName"), ""), String)
                Case "PossibleSolutions"
                    'm_strPossibleSolutions = CType(Args.DataReader.Item("FieldName"), String)
                    m_strPossibleSolutions = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("FieldName"), ""), String)
                    ' End Modification by NitinVS on 30 Mar 2005 for PBNITE SP2 
            End Select
            Cancel = True
        End If
    End Sub
#End Region
    ''Added by Yogesh J on 04-Feb-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_GenerateToken_OnClick(EmployeeID As String, FromDate As String, ToDate As String, ProjectID As String, strID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String

            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(FromDate, String) + CType(ToDate, String) + CType(ProjectID, String) + CType(strID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of addition by Yogesh J on 04-Feb-2016
End Class
