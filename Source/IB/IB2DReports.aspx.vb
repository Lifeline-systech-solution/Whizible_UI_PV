Public Class IB2DReports
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents frmIB2dReports As System.Web.UI.HtmlControls.HtmlForm

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region


#Region " Form Level variables declaration "

    Private m_LoginId As Long
    Private m_LoginType As String
    Private m_RoleId As Long
    Private m_RoleLevel As Integer
    Private m_ProjectId As Long
    Private m_UserId As Long
    Private m_UserName As String
    Private m_CultureId As Long
    '***** Added by SandipL on 6 Dec 2005 -- Editable Date Control Issue
    Protected m_blnDateEditable As Boolean
    '***** End addition by SandipL
    Dim strMode As String = ""
    Dim strXAxis As String = ""     'X Axis Field
    Dim strYAxis As String = ""   'Y Axis Field
    Dim strBased As String = ""   ' Based on Field
    Dim strXAxisType As String = ""  ' X Axis Type
    Dim strYAxisType As String = ""  ' Y Axis Type
    Dim strBasedOnType As String = ""  ' Based On Type
    Dim strXAxisFromDate As String = "" ' X Axis From Date
    Dim strXAxisToDate As String = ""  ' X Axis To Date
    Dim strYAxisFromDate As String = "" ' Y Axis From Date
    Dim strYAxisToDate As String = ""  ' Y Axis To Date
    Dim strBasedOnFromDate As String = "" ' Based on To Date
    Dim strBasedOnToDate As String = "" ' Based on From Date

    Dim strXMsg As String = ""    'xAxis Legend Message
    Dim strYMsg As String = ""    'yAxis Legend Message
    Dim strBMsg As String = ""    'Based on legend message

    Dim intDefaultViewID As Long   'get the default view id

    Dim ExitLoop As Boolean = False     'variable to decide the exit loop
    Dim strProjectGroupID As String = "" 'variable to store the project group id

    'Variables for 2D and 3D reports
    Dim strXAxisTypeQR, strYAxisTypeQR, strBasedOnTypeQR, strXAxisFromDateQR, strXAxisToDateQR As String
    Dim strYAxisFromDateQR, strYAxisToDateQR, strBasedOnFromDateQR, strBasedOnToDateQR, strType As String
    Dim intColSum(), intReportSum(), intRowSum, intColCount As Integer


#End Region 'Form level variables declaration

#Region " Private Procedures "

    Private Sub GenerateCliendSideArray()
        '=====================================================================
        ' Procedure Name        : GenerateCliendSideArray()	
        ' Purpose               : To generate client side arrays for Project reports and Proeject group reports 
        '                         to avoid duplicate report name, while saving 
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 6, 2004
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String = "usp_Sel_tbl_IB_Query_3DReports '" + m_LoginType + "', " + m_UserId.ToString + ", " + m_ProjectId.ToString
        Dim script As String, strType As String
        Dim drReportName As IDataReader
        Dim intP As Integer

        script = "<SCRIPT language=javascript>"
        script = script + vbCrLf + "ArrProjectReports=["

        drReportName = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drReportName.Read Then
            strType = drReportName("Scope").ToString
            Do
                If drReportName("Scope").ToString = strType Then
                    script += """" + drReportName("QueryName").ToString.ToUpper + ""","
                Else
                    script = Left(script, Len(script) - 1)
                    script += "];" + vbCrLf + "ArrGroupReports=["
                    strType = drReportName("Scope").ToString
                    script += """" + drReportName("QueryName").ToString.ToUpper + ""","
                End If
            Loop While drReportName.Read
            If InStr(script, "ArrGroupReports", CompareMethod.Text) = 0 Then
                script = Left(script, Len(script) - 1)
                script += "];" + vbCrLf + "ArrGroupReports=[];"
            Else
                script = Left(script, Len(script) - 1)
                script += "];"
            End If
            script = script + vbCrLf + "</SCRIPT>"
            Response.Write(script)
        Else
            script = script + "];" + vbCrLf + "ArrGroupReports=[];" + vbCrLf + "</SCRIPT>"
            Response.Write(script)
        End If
    End Sub

    Private Sub PlotGrid()
        '=====================================================================
        ' Procedure Name        : PlotGrid()	
        ' Purpose               : To plot Issue List grid
        ' Description           : same as above
        ' Parameters Passed     : GridSQL as string - SQL Query for grid
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             :
        '=====================================================================

        'Initialize standard menu resource file 
        MyBase.InitializeResources("AppResources.IB2DReports", "AppResources")

        'generate Actual column headings array
        Dim ArrActualNameList As New ArrayList
        ArrActualNameList.Add("Scope") 'Scope
        ArrActualNameList.Add("QueryName") 'Query name
        ArrActualNameList.Add("CreatedDate") 'Created Date
        ArrActualNameList.Add("ReportCriteria") 'Report Criteria
        ArrActualNameList.Add("") 'QueryText
        ArrActualNameList.Add(MyBase.GetResourceString("GENERATE"))  'Generate
        ArrActualNameList.Add("") 'Delete

        'Convert arraylist to actual array - Actual Column Names
        Dim ArrActualName(ArrActualNameList.Count - 1) As String
        ArrActualNameList.ToArray.CopyTo(ArrActualName, 0)
        ArrActualNameList = Nothing
        '---Actual column headings array generated

        '---------------------------------------------------------------

        'generate User Friendly column headings array
        Dim ArrColHeadings() As String = {"", MyBase.GetResourceString("REPORTNAME"), MyBase.GetResourceString("CREATEDON"), MyBase.GetResourceString("REPORTCRITERIA"), "", MyBase.GetResourceString("GENERATE"), MyBase.GetResourceString("DELETE")}

        'Generate RowLinks array
        Dim ArrRowLinks() As String = {"", "", "", "", "", "GenerateReport_OnClick(QueryText)", ""}

        '---------------------------------------------------------------

        'Generate Delete array
        Dim ArrDelete() As String = {"", "", "", "", "", "", "chkDelete"}

        'Generate Group On array
        Dim ArrGroupOnColumn() As String = {"1"}

        Dim strSQL As String
        strSQL = "usp_Sel_tbl_IB_Query_3DReports '" + m_LoginType + "', " + m_UserId.ToString + ", " + m_ProjectId.ToString

        'Plot Issue List grid 
        Dim objReportsGrid As New WebPage.Templates.GenericGrid
        With objReportsGrid
            .ActualColumnArray = ArrActualName
            .UserFriendlyColumnArray = ArrColHeadings
            .RowLinkArray = ArrRowLinks
            .CheckBoxIDArray = ArrDelete
            .NoOfDataColumns = 4
            .returnHTML = False
            .PrimaryKey = "QueryId"
            .UseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
            ''Commented by Nilesh g on 7/11/2016 Purpose:Add overflow to grid height
            ''.DIVHeight = 230
            ''end of Commented by Nilesh g on 7/11/2016 Purpose:Add overflow to grid height
            .DIVID = "DivReportList"
            .DIVStyle = "Overflow:auto;height:230px;"
            .SQL = strSQL
            .GroupOnColumn = ArrGroupOnColumn
            .DrawGrid()
        End With

        Response.Write("<BR>")

        'Display record count 
        Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTREven'><td align=right><B>" + MyBase.GetResourceString("RECORDCOUNT") + " : " + objReportsGrid.NoOfRowsInPage.ToString + "</B></TD></TR></Table><BR>")

        'Destroy grid object
        objReportsGrid = Nothing

    End Sub

    Private Sub PlotControls()
        '=====================================================================
        ' Procedure Name        : PlotControls()	
        ' Purpose               : To plot controls on this page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 3, 2004
        ' Revisions             :
        '=====================================================================

        'initialize resource file
        MyBase.InitializeResources("AppResources.IB2DReports", "AppResources")

        'Project Type Combo (Only for LoginType = 'E')
        If m_LoginType = "E" Then
            Response.Write("<TABLE cellspacing=0 cellpadding=0 class=clsTable width='99.9%'>")
            ' Response.Write("<TR class=clsTREven><TD align=left> &nbsp;" + MyBase.GetResourceString("SELECTPROJECTGROUP"))
            'commented by Shamkant s
            Response.Write("<TR class=clsTREven><TD align=left> &nbsp;" + MyBase.GetResourceString("SELECTPROJECTGROUP") + "&nbsp;&nbsp;&nbsp;")

            Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboProjectGroup", "EXEC usp_Sel_Resource_ProjectGroup " + m_RoleId.ToString + "," + m_UserId.ToString, 150, , , InsertBlankRow:=True, ReturnAsHTML:=False))
            Response.Write("</TD></TR></TABLE>")
        End If


        Response.Write("<TABLE cellspacing=0 cellpadding=0 class=clsTable width='99.9%'>")

        'Hidden text box for QueryString

        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtQueryString", "txtQueryString", IsHidden:=True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:07/10/15

        Response.Write("<TR class=clsTREven>")
        'Added by PrachiK on 28 Feb 2005 for IssueID 16247
        'Purpose:GUI of this page is not proper
        'X axis combo
        Response.Write("<TD  align=left Width='19%'> &nbsp;" + MyBase.GetResourceString("XAXIS") + "</TD>")
        'Addtion ended
        Response.Write("<TD width='30%' align=left>")
        Response.Write(CommonFunction.HTMLControls.DrawComboBox("cboXAxis", "EXEC usp_Sel_tbl_IB_FieldListFor2DReports " + m_ProjectId.ToString + "," + m_RoleId.ToString, 150, , "OnChange=XAxis_Change()", InsertBlankRow:=True, IsMandatory:=True))
        Response.Write("</TD>")
        '***** Code modified by SandipL on 5 Dec 2005 --IssueID 672 -- Editable Date Control problem
        'X Axis From Date
        'Response.Write("<TD width='10%'><INPUT Type=Text class=clsTextBox Name=txtXAxisFromDate  ReadOnly Style='Width=80;Display:NONE'></TD>")
        'Response.Write("<TD width='10%'><A HREF=JavaScript:callcalendar('frmIB2dReports','txtXAxisFromDate')><IMg Border=0 id=XAxisFromDateImg src='../../Images/Calendar.gif' Style='Display:NONE'></A></tD>")
        Response.Write("<TD width='10%'>")

        ''Commented and Added by Dhanashri S on 26 Nov 2015
        Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtXAxisFromDate", "txtXAxisFromDate", , 80, , , "frmIB2dReports", returnHTML:=True, DisplayNone:=True))
        'Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtXAxisFromDate", "txtXAxisFromDate", , 80, , , "frmIB2dReports", returnHTML:=True))
        ''End of Comment and Addition by Dhanashri S on 26 Nov 2015

        Response.Write("<TD width='10%'><A HREF=JavaScript:callcalendar('frmIB2dReports','txtXAxisFromDate')><IMg Border=0 id=XAxisFromDateImg src='../../Images/Calendar.gif' Style='Display:NONE'></A></tD>")
        'X Axis To Date
        'Response.Write("<TD width='10%'><INPUT Type=Text Name=txtXAxisToDate class=clsTextBox ReadOnly Style='Width=80;Display:NONE'></TD>")
        'Response.Write("<TD width='10%'><A HREF=JavaScript:callcalendar('frmIB2dReports','txtXAxisToDate')><IMg Border=0 id=XAxisToDateImg src='../../Images/Calendar.gif' Style='Display:NONE'></A></tD>")
        Response.Write("<TD width='10%'>")

        ''Commented and Added by Dhanashri S on 26 Nov 2015
        Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtXAxisToDate", "txtXAxisToDate", , 80, , , "frmIB2dReports", returnHTML:=True, DisplayNone:=True))
        'Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtXAxisToDate", "txtXAxisToDate", , 80, , , "frmIB2dReports", returnHTML:=True))
        'End of Comment and Addition by Dhanashri S on 26 Nov 2015

        Response.Write("<TD width='10%'><A HREF=JavaScript:callcalendar('frmIB2dReports','txtXAxisToDate')><IMg Border=0 id=XAxisToDateImg src='../../Images/Calendar.gif' Style='Display:NONE'></A></tD>")
        'Response.Write("<TD width='10%'>")
        'Response.Write("</TD>")

        '***** End Modification by SandipL on 5 Dec 2005
        'X Axis Type
        Response.Write("<TD width='20%'>")
        Response.Write(CommonFunction.HTMLControls.DrawComboBox("cboXAxisType", "EXEC Usp_Sel_tbl_IB_Project_Sub_Type " + m_ProjectId.ToString + ",'t'", 150, strXAxisType, "Style='Display:NONE'"))
        Response.Write("</TD>")

        Response.Write("</TR>")

        Response.Write("<TR class=clsTREven>")

        'Y axis combo
        Response.Write("<TD align=left ; Width='10%'> &nbsp;" + MyBase.GetResourceString("YAXIS") + "</TD>")
        Response.Write("<TD width='25%' align=left>")
        Response.Write(CommonFunction.HTMLControls.DrawComboBox("cboYAxis", "EXEC usp_Sel_tbl_IB_FieldListFor2DReports " + m_ProjectId.ToString + "," + m_RoleId.ToString, 150, , "style='display:block' OnChange=YAxis_Change() disabled", InsertBlankRow:=True))
        Response.Write("</TD>")

        '***** Code modified by SandipL on 5 Dec 2005 --To solve Editable Date Control Issue
        'Y Axis From Date
        'Response.Write("<TD  width='10%' ><INPUT Type=Text class=clsTextBox Name=txtYAxisFromDate  ReadOnly Style='Width=80;Display:NONE'></TD>")
        'Response.Write("<TD  width='10%' ><A HREF=JavaScript:callcalendar('frmIB2dReports','txtYAxisFromDate')><IMg Border=0 id=YAxisFromDateImg src='../../Images/Calendar.gif' Style='Display:NONE'></A></tD>")
        Response.Write("<TD width='10%'>")
        Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtYAxisFromDate", "txtYAxisFromDate", , 80, , , "frmIB2dReports", returnHTML:=True, displaynone:=True))
        Response.Write("<TD  width='10%' ><A HREF=JavaScript:callcalendar('frmIB2dReports','txtYAxisFromDate')><IMg Border=0 id=YAxisFromDateImg src='../../Images/Calendar.gif' Style='Display:NONE'></A></tD>")
        'Y Axis To Date
        'Response.Write("<TD  width='10%' ><INPUT Type=Text class=clsTextBox Name=txtYAxisToDate  ReadOnly Style='Width=80;Display:NONE'></TD>")
        'Response.Write("<TD  width='10%' ><A HREF=JavaScript:callcalendar('frmIB2dReports','txtYAxisToDate')><IMg Border=0 id=YAxisToDateImg src='../../Images/Calendar.gif' Style='Display:NONE'></A></TD>")
        Response.Write("<TD width='10%'>")
        Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtYAxisToDate", "txtYAxisToDate", , 80, , , "frmIB2dReports", returnHTML:=True, displaynone:=True))
        Response.Write("<TD  width='10%' ><A HREF=JavaScript:callcalendar('frmIB2dReports','txtYAxisToDate')><IMg Border=0 id=YAxisToDateImg src='../../Images/Calendar.gif' Style='Display:NONE'></A></TD>")
        '***** End Modification by SandipL on 5 Dec 2005

        'Y Axis Type
        Response.Write("<TD  width='20%'>")
        Response.Write(CommonFunction.HTMLControls.DrawComboBox("cboYAxisType", "EXEC Usp_Sel_tbl_IB_Project_Sub_Type " + m_ProjectId.ToString + ",'t'", 150, strYAxisType, "Style='Display:NONE'"))
        Response.Write("</TD>")

        Response.Write("</TR>")

        Response.Write("<TR class=clsTREven>")

        'Based On combo
        Response.Write("<TD Width='10%';align=left> &nbsp;" + MyBase.GetResourceString("BASEDON") + "</TD>")

        Response.Write("<TD width='25%' align=left>")
        Response.Write(CommonFunction.HTMLControls.DrawComboBox("cboBasedOn", "EXEC usp_Sel_tbl_IB_FieldListFor2DReports " + m_ProjectId.ToString + "," + m_RoleId.ToString, 150, , "style='display:block' OnChange= OnChange=BasedOn_Change() disabled", InsertBlankRow:=True))
        Response.Write("</TD>")
        '***** Code Modified by SandipL on 5 dec 2005 --To solve Problem of editable Date Control Issue
        'Based On From Date
        'Response.Write("<TD width='10%' ><INPUT Type=Text class=clsTextBox Name=txtBasedOnFromDate  ReadOnly Style='Width=80;Display:NONE'></TD>")
        'Response.Write("<TD  width='10%' ><A HREF=JavaScript:callcalendar('frmIB2dReports','txtBasedOnFromDate')><IMg BORDER=0 id=BasedOnFromDateImg src='../../Images/Calendar.gif' Style='Display:NONE'></a></TD>")
        Response.Write("<TD width='10%'>")
        Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtBasedOnFromDate", "txtBasedOnFromDate", , 80, , , "frmIB2dReports", returnHTML:=True, displaynone:=True))
        Response.Write("<TD  width='10%' ><A HREF=JavaScript:callcalendar('frmIB2dReports','txtBasedOnFromDate')><IMg BORDER=0 id=BasedOnFromDateImg src='../../Images/Calendar.gif' Style='Display:NONE'></a></TD>")


        'Based ON To Date
        'Response.Write("<TD width='10%' ><INPUT Type=Text class=clsTextBox Name=txtBasedOnToDate  ReadOnly Style='Width=80;Display:NONE'></TD>")
        'Response.Write("<TD  width='10%' ><A HREF=JavaScript:callcalendar('frmIB2dReports','txtBasedOnToDate')><IMg BORDER=0 id=BasedOnToDateImg src='../../Images/Calendar.gif' Style='Display:NONE'></A></TD>")

        Response.Write("<TD width='10%'>")
        Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtBasedOnToDate", "txtBasedOnToDate", , 80, , , "frmIB2dReports", returnHTML:=True, displaynone:=True))
        Response.Write("<TD  width='10%' ><A HREF=JavaScript:callcalendar('frmIB2dReports','txtBasedOnToDate')><IMg BORDER=0 id=BasedOnToDateImg src='../../Images/Calendar.gif' Style='Display:NONE'></A></TD>")
        '***** End Modification By SandipL on 5 Dec 2005
        Response.Write("<TD width='10%'>")

        'Based On Type
        Response.Write("<TD width='20%'>")
        Response.Write(CommonFunction.HTMLControls.DrawComboBox("cboBasedOnType", "EXEC Usp_Sel_tbl_IB_Project_Sub_Type " + m_ProjectId.ToString + ",'t'", 150, , "Style='Display:NONE'"))
        Response.Write("</TD>")

        Response.Write("</TR>")
        Response.Write("</TABLE>")

        Response.Write("<BR>")

        Response.Write("<TABLE cellspacing=0 cellpadding=0 class=clsTable width='99.9%'>")

        Response.Write("<TR class=clsTREven>")

        'Report name
        Response.Write("<TD align=right>" + MyBase.GetResourceString("ENTERREPORTNAME") + "</TD>")

        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        Response.Write("<TD>" + CommonFunction.HTMLControls.DrawTextBox("txtReportName", "txtReportName", , 300, 75, IsMandatory:=True, returnHTML:=True, EnableHTMLEncode:=True) + "</TD>")
        'ended by Yogesh J for HTML encoding Date:07/10/15
        Response.Write("</TR>")
        Response.Write("</TABLE>")

        Response.Write("<BR>")


    End Sub

    Private Sub GeneratePageLegends()
        '=====================================================================
        ' Procedure Name        : GeneratePageLegends()	
        ' Purpose               : To generate page legends
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 3, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrLegend() As String = {"Prefix '$' indicates the custom field.", "Mandatory"}
        Dim arrLegendImage() As String = {"", "<img src='../../images/star.gif'>"}

        Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend) + vbCrLf)

    End Sub 'Generate Page Legends

    Private Sub GeneratePageCaption()
        '=====================================================================
        ' Procedure Name        : GeneratePageHeader()	
        ' Purpose               : To generate page header
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 3, 2004
        ' Revisions             :
        '=====================================================================

        'Initialize standard menu resource file 
        MyBase.InitializeResources("AppResources.IB2DReports", "AppResources")
        'Modified by by SandipL on 8 Feb 2006 to show current Project Name as right PageCaption
        Dim strProjectName As String

        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        'strProjectName = CType(CommonFunctions.Data.GetDataScalar("Select Isnull(ProjectName,'') From tbl_PM_Project where Projectid = " + CType(Session("IssueProject"), String), True), String)
        strProjectName = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ProjectNameID " + CType(Session("IssueProject"), String), True), String)
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

        Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGECAPTION"), "Project: " & strProjectName, , False) + vbCrLf)
        Response.Write("<BR>")
    End Sub 'Generate page caption

    Private Sub CreateGlobalObject()
        '=====================================================================
        ' Procedure Name        : CreateGlobalObject()	
        ' Purpose               : To get global object and set form level variables
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 3, 2004
        ' Revisions             :
        '=====================================================================

        'Global object
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        With objGlobal
            m_LoginId = .LoginID
            m_LoginType = .LoginType
            m_RoleId = .RoleID
            m_RoleLevel = .RoleLevel
            'm_ProjectId = .ProjectID
            m_ProjectId = CType(Session("IssueProject"), Long)
            'Added By JyotiG for Issue Id : 7193
            'Date : 27-OCt-2006
            'Start
            m_UserId = .UserID
            m_UserName = .UserName
            m_CultureId = .LCID
            'End Of Modification By JyotiG

            'Code added by SandipL on 17 Feb 2006 --IssueID 2145-- Whizsem_whiz2 sp6
            Dim intCorporateRoleLevel As Integer
            'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            'intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = (select PostId from tbl_PM_Employee where EmployeeID=" & CType(Session("intUserID"), String) & ")", MyBase.UseSQL), Integer)
            intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_RoleID " & CType(Session("intUserID"), String), MyBase.UseSQL), Integer)
            'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            If intCorporateRoleLevel <> 1 And intCorporateRoleLevel <> 2 And m_ProjectId <> 0 Then
                'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                'm_RoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ISnull(Role,0) from tbl_PM_ProjectEmployeeRole where ProjectID=" & CType(m_ProjectId, String) & " And EmployeeID=" & CType(m_UserId, String), MyBase.UseSQL), "0"), Long)
                m_RoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectEmployeeRole_Role " & CType(m_ProjectId, String) & "," & CType(m_UserId, String), MyBase.UseSQL), "0"), Long)
                'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                If Not m_RoleId > 0 Then
                    m_RoleId = CType(Session("intPostID"), Long)
                End If
                If m_RoleId > 0 Then
                    objGlobal.RoleID = m_RoleId
                End If
                'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                'm_RoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = " & CType(m_RoleId, String), MyBase.UseSQL)), Integer)
                m_RoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_Level  " & CType(m_RoleId, String), MyBase.UseSQL)), Integer)
                'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                If m_RoleLevel > 0 Then
                    objGlobal.RoleLevel = m_RoleLevel
                End If
            End If
            'End addition by SandipL on 17 Feb 2006
            'Commented By JyotiG for Issue Id : 7193
            'Start
            'm_UserId = .UserID
            'm_UserName = .UserName
            'm_CultureId = .LCID
            'End of Modification By JyotiG
        End With
        '***** Code added by SandipL on 6 Dec 2005 -- To handle conditinal Editable Date Control
        m_blnDateEditable = CommonFunctions.General.GetFrameworkSettings("EDITABLE_DATE_CONTROL", "Enabled")
        '***** End addition by SandipL on 6 Dec
    End Sub 'Get all session variable values

    Private Sub SaveReport()
        '=====================================================================
        ' Procedure Name        : SaveReport()	
        ' Purpose               : To save the report
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 3, 2004
        ' Revisions             :
        '=====================================================================

        Dim drSaveReport As IDataReader, strSQL As String

        'Generate SQL 
        If strProjectGroupID <> "NULL" Then
            strSQL = "EXEC usp_ins_tbl_IB_Query_Report Null," + m_UserId.ToString + ",'" + CommonFunction.General.BuildQueryString(Request("txtQueryString")) + "','" + CommonFunction.General.BuildQueryString(Request("txtReportName")) + "','" + m_LoginType + "'"
        Else
            strSQL = "EXEC usp_ins_tbl_IB_Query_Report " + m_ProjectId.ToString + "," + m_UserId.ToString + ",'" + CommonFunction.General.BuildQueryString(Request("txtQueryString")) + "','" + CommonFunction.General.BuildQueryString(Request("txtReportName")) + "','" + m_LoginType + "'"
        End If

        'Execute SP to save report
        CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

    End Sub 'Save the report

    Private Sub DeleteReports()
        '=====================================================================
        ' Procedure Name        : DeleteReports()	
        ' Purpose               : To delete the selected Report(s)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 3, 2004
        ' Revisions             :
        '=====================================================================
        Dim strSQLQuery As String

        If MyBase.GetFormValue("chkDelete") Is Nothing Or MyBase.GetFormValue("chkDelete") = "" Then Exit Sub

        strSQLQuery = "Exec Usp_Del_tbl_IB_Query '" + MyBase.GetFormValue("chkDelete") + "'"
        CommonFunction.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

    End Sub

    Private Sub GenerateReport()
        '=====================================================================
        ' Procedure Name        : GenerateReport()	
        ' Purpose               : To generate report
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : Generate1DReport, Generate2DReport, Generate3DReport
        ' Author                : AniruddhaD
        ' Created               : Feb 3, 2004
        ' Revisions             :
        '=====================================================================

        'Initialize IB2dReports resource file 
        MyBase.InitializeResources("AppResources.IB2DReports", "AppResources")


        Call GeneratePageLegends()

        'CommonFunction.HTMLControls.DrawTextBox("txtProjectGroupID", "txtProjectGroupID", IsHidden:=True)

        'for showing the detail report
        'start

        If strXAxisType = "" Then
            strXAxisTypeQR = "0"
        Else
            strXAxisTypeQR = Replace(strXAxisType, " ", "+")
            strType = Replace(strXAxisType, " ", "+")
        End If

        If Trim(strYAxisType) = "" Then
            strYAxisTypeQR = "0"
        Else
            strYAxisTypeQR = Replace(strYAxisType, " ", "+")
            If strType = "" Then strType = Replace(strYAxisType, " ", "+")
        End If

        If strBasedOnType = "" Then
            strBasedOnTypeQR = "0"
        Else
            strBasedOnTypeQR = Replace(strBasedOnType, " ", "+")
            If strType = "" Then strType = Replace(strBasedOnType, " ", "+")
        End If

        'xAxis From + To Date
        'start
        If strXAxisFromDate = "" Then
            strXAxisFromDateQR = "0"
        Else
            strXAxisFromDateQR = strXAxisFromDate
        End If
        If strXAxisToDate = "" Then
            strXAxisToDateQR = "0"
        Else
            strXAxisToDateQR = strXAxisToDate
        End If
        'end

        'YAxis From + To Date
        'start
        If strYAxisFromDate = "" Then
            strYAxisFromDateQR = "0"
        Else
            strYAxisFromDateQR = strYAxisFromDate
        End If
        If strYAxisToDate = "" Then
            strYAxisToDateQR = "0"
        Else
            strYAxisToDateQR = strYAxisToDate
        End If
        'end

        'Based on From + To Date
        'start
        If strBasedOnFromDate = "" Then
            strBasedOnFromDateQR = "0"
        Else
            strBasedOnFromDateQR = strBasedOnFromDate
        End If
        If strBasedOnToDate = "" Then
            strBasedOnToDateQR = "0"
        Else
            strBasedOnToDateQR = strBasedOnToDate
        End If
        'end
        'end	

        If Not Request.QueryString("cboProjectGroup") Is Nothing Then
            If Request.QueryString("cboProjectGroup") <> "" Then
                strProjectGroupID = Request.QueryString("cboProjectGroup")
            Else
                strProjectGroupID = "NULL"
            End If
        Else
            strProjectGroupID = "NULL"
        End If

        If strProjectGroupID = "NULL" Then
            'Commented and added by Yogesh J for HTML encoding Date:07/10/15
            CommonFunction.HTMLControls.DrawTextBox("txtProjectGroupID", "txtProjectGroupID", , 100, , "0", IsHidden:=True, EnableHTMLEncode:=True)
        Else
            CommonFunction.HTMLControls.DrawTextBox("txtProjectGroupID", "txtProjectGroupID", , 100, , strProjectGroupID, IsHidden:=True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:07/10/15
        End If

        'Get the default settings for the user.
        Dim drDefaultSettings As IDataReader, strSQL As String
        strSQL = "Exec usp_Sel_tbl_IB_DefaultSettings " + m_ProjectId.ToString + ",'" + m_LoginType + "'," + m_UserId.ToString
        drDefaultSettings = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drDefaultSettings.Read Then
            intDefaultViewID = CType(CommonFunction.Data.CheckIsDBNull(drDefaultSettings("DefaultViewID"), "0"), Long)
        Else
            intDefaultViewID = 0
        End If

        CommonFunction.Data.DisposeDataReader(drDefaultSettings)

        If strProjectGroupID = "NULL" Then
            Dim strProjectName As String
            'strProjectName = CType(CommonFunctions.Data.GetDataScalar("Select Isnull(ProjectName,'') From tbl_PM_Project where Projectid = " + CType(Session("IssueProject"), String), True), String)
            strProjectName = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ProjectNameID " + CType(Session("IssueProject"), String), True), String)
            Response.Write("<TABLE cellspacing=0 cellpadding=0 class=clsTable width=99.9% cellspacing=0><TR class=clsTREven><TD>Report generated for the project</tD><TD>" + strProjectName + "</TD></TR>")
        Else
            Dim drProjectGroup As IDataReader
            'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            'drProjectGroup = CommonFunction.Data.GetDataReader("Select ProjectGroupName FROM tbl_PM_ProjectGroup WHERE ProjectGroupID=" + strProjectGroupID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            drProjectGroup = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_ProjectGroup_ProjectGroupName " + strProjectGroupID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            If drProjectGroup.Read Then
                Response.Write("<TABLE cellspacing=0 cellpadding=0 class=clsTable><TR class=clsTREven><TD>Report generated for the project group</tD><TD >" + drProjectGroup(0).ToString + "</TD></TR>")
            End If

            CommonFunction.Data.DisposeDataReader(drProjectGroup)
        End If
        'end

        Response.Write("<TR class=clsTREven><TD>By</TD><TD>" + m_UserName + "</TD></TR>")
        Response.Write("<TR class=clsTREven><TD>On</tD><TD>" + CommonFunction.Dates.CGetDateTime(Now()) + "</TD></TR></TABLE><BR>")

        Response.Write("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable><TR class=clsTREven><TD align=center>Select view : ")

        strSQL = "Exec usp_Sel_tbl_IB_Project_Views " + m_ProjectId.ToString + ", '" + m_LoginType + "'," + m_UserId.ToString + ", NULL, 4, '-1'"
        Response.Write(CommonFunction.HTMLControls.DrawComboBox("cboView", strSQL, 200, isMandatory:=False))
        Response.Write("</TD></TR></TABLE><BR>")

        'Generate actual report data
        If strBased <> "" And strXAxis <> "" And strYAxis <> "" Then 'Three Diementional Report
            Call Generate3DReport()
        ElseIf strXAxis <> "" And strYAxis <> "" Then 'Two Diementional Report
            Call Generate2DReport()
        ElseIf strYAxis = "" And strBased = "" And strXAxis <> "" Then 'One Diementional Report
            Call Generate1DReport()
        End If

    End Sub

    Private Sub Generate1DReport()
        '=====================================================================
        ' Procedure Name        : Generate1DReport()	
        ' Purpose               : To generate 1D report
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 5, 2004
        ' Revisions             :
        '=====================================================================

        Dim drCustomFieldName, drGetXAxis, drGetYAxis, drGetXYAxisValue As IDataReader
        Dim strSQL As String
        Dim intCol, intColSum(), intRowSum, intColCount As Integer

        Response.Write("<TITLE>Issue Base 1D Reports</TITLE>")

        'if xaxis is custom field then get the user given caption 
        'for the customer field							
        If InStr(strXAxis.ToUpper, "CUSTOMFIELD") > 0 Then
            drCustomFieldName = CommonFunction.Data.GetDataReader("EXEC Usp_Sel_tbl_IB_CustomFields_Master " + m_ProjectId.ToString + ",'" + Replace(CommonFunction.General.BuildQueryString(strXAxis) + "", "$", "") + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drCustomFieldName.Read Then
                strXMsg = CommonFunction.Data.CheckIsDBNull(drCustomFieldName("UserGivenCaption"), strXAxis).ToString
            End If
            CommonFunction.Data.DisposeDataReader(drCustomFieldName)
        Else
            strXMsg = strXAxis
        End If

        If InStr(strXAxis.ToUpper, "DATE") > 0 Then
            If Trim(strXAxisFromDate) <> "" Then
                strXMsg = strXMsg + "(From:" + CommonFunction.Dates.CGetDate(CType(strXAxisFromDate, Date)) + " To:"
            Else
                strXMsg = strXMsg + "(From:'Not Specified'To:"
            End If
            If Trim(strXAxisToDate) <> "" Then
                strXMsg = strXMsg + CommonFunction.Dates.CGetDate(CType(strXAxisToDate, Date)) + ")"
            Else
                strXMsg = strXMsg + "'Not Specified')"
            End If
        End If

        Response.Write("<TABLE cellspacing=0 cellpadding=0 'width=25%'><TR class=clsTREven><TD align=center><B>" + MyBase.GetResourceString("XAXIS") + " : " + strXMsg + "</B></TD></TR></TABLE><BR>")

        ''Added by Dhanashri S on 7 Dec 2015 for IssueID:2531
        Response.Write("<DIV ID='divclsTable' Style='Height:156px;WIDTH:600px;OVERFLOW:auto;'>")
        ''End of Addition by Dhanashri S on 7 Dec 2015

        Response.Write("<BR><TABLE cellspacing=0 cellpadding=0 WIDTH='99.9%' class=clsTable><TR class=clsTREven>")

        'for y axis
        Response.Write("<TD align=center Width=10'%'></TD>")
        If strXAxisType = "" Then
            'Modified By MrugajaB on 7th Feb,2005
            'Added m_strLoginType parameter in SP Usp_Sel_IB_2DRPT_XYAxis in order to recognize the login type
            'so that customer is exposed to only those issues  for which 'ShowToCustomer=1'
            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
        Else
            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",'" + CommonFunction.General.BuildQueryString(strXAxisType) + "',Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
        End If
        If strXAxisFromDate <> "" And strXAxisToDate <> "" Then
            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "','" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
        ElseIf strXAxisFromDate <> "" Then
            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "',Null," + strProjectGroupID + ",'" + m_LoginType + "'"
        ElseIf strXAxisToDate <> "" Then
            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,'" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
        End If
        'End Modification

        'Response.Write strSQL
        drGetXAxis = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        Do While drGetXAxis.Read
            intCol += 1
        Loop
        CommonFunction.Data.DisposeDataReader(drGetXAxis)

        ReDim intColSum(intCol + 1)

        drGetXAxis = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drGetXAxis.Read Then
            Do
                If Not drGetXAxis.IsDBNull(0) Then
                    If InStr(strXAxis.ToUpper, "DATE") > 0 Then
                        Response.Write("<TD align=center><B>" + CommonFunction.Dates.CGetDate(CType(drGetXAxis(0), Date)) + "</B></TD>")
                    Else
                        Response.Write("<TD align=center><B>" + drGetXAxis(0).ToString.Trim + "</B></TD>")
                    End If
                Else
                    Response.Write("<TD align=center><B>&lt;Not Specified&gt;</B></TD>")
                End If
            Loop While drGetXAxis.Read

            Response.Write("<TD align=center><B>" + MyBase.GetResourceString("TOTAL") + "</B></TD>")
            Response.Write("</TR><TR class=clsTREven>")
            Response.Write("<TD align=center>" + MyBase.GetResourceString("TOTAL") + "</TD>")

            CommonFunction.Data.DisposeDataReader(drGetXAxis)

            drGetXAxis = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            intRowSum = 0
            intColCount = 0

            Do While drGetXAxis.Read
                strSQL = "EXEC Usp_Sel_IB_2DRPT_XYAxis_Values " + m_ProjectId.ToString + ",'" + CommonFunction.General.BuildQueryString(drGetXAxis(0).ToString) + "','" + CommonFunction.General.BuildQueryString(drGetXAxis(0).ToString) + "',Null,'" + CommonFunction.General.BuildQueryString(strXAxis) + "','" + CommonFunction.General.BuildQueryString(strXAxis) + "',Null," + strProjectGroupID + ",'" + Replace(strType + "", "+", " ") + "','" + m_LoginType + "'"
                drGetXYAxisValue = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drGetXYAxisValue.Read Then
                    If CType(drGetXYAxisValue(0), Integer) <> 0 Then
                        Response.Write("<TD align=center><A  HREF=" + Chr(34) + "JavaScript:ShowDetails('" + strXAxis + "','0','0','" + Replace(drGetXAxis(0).ToString, "'", "||--||") + "','0','0','" + strXAxisTypeQR + "','" + strYAxisTypeQR + "','" + strBasedOnTypeQR + "','" + strXAxisFromDateQR + "','" + strXAxisToDateQR + "','" + strYAxisFromDateQR + "','" + strYAxisToDateQR + "','" + strBasedOnFromDateQR + "','" + strBasedOnToDateQR + "','T')" + Chr(34) + ">" + drGetXYAxisValue(0).ToString + "</A></TD>")
                    Else
                        Response.Write("<TD align=center>" + drGetXYAxisValue(0).ToString + "</TD>")
                    End If
                    intColSum(intColCount) = intColSum(intColCount) + CType(drGetXYAxisValue(0), Integer)
                    intColCount = intColCount + 1
                    intRowSum = intRowSum + CType(drGetXYAxisValue(0), Integer)
                End If
                CommonFunction.Data.DisposeDataReader(drGetXYAxisValue)
            Loop
            intColSum(intColCount) = intColSum(intColCount) + intRowSum
            Response.Write("<TD align=center><B>" + intRowSum.ToString + "</B></tD>")
            Response.Write("</TR>")

            ''Added by Dhanashri S on 7 Dec 2015 for IssueID:2531
            Response.Write("</table></Div>")
            ''End of Addition by Dhanashri S on 7 Dec 2015

        Else ''no data present
            Response.Write("<TABLE cellspacing=0 cellpadding=0 class=clsTable width='99.9%'><TR class=clsTREven><TD align=center>" + MyBase.GetResourceString("NODATAXAXIS") + "</tD></TR></TABLE>")
        End If
    End Sub

    Private Sub Generate2DReport()
        '=====================================================================
        ' Procedure Name        : Generate2DReport()	
        ' Purpose               : To generate 2D report
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 5, 2004
        ' Revisions             :
        '=====================================================================

        Dim drCustomFieldName, drGetXAxis, drGetYAxis, drGetXYAxisValue As IDataReader
        Dim strSQL As String
        Dim intCol, intColSum(), intRowSum, intColCount As Integer

        Response.Write("<TITLE>Issue Base 2D Reports</TITLE>")
        'if xaxis is custom field then get the user given caption 
        'for the customer field							
        If InStr(strXAxis.ToUpper, "CUSTOMFIELD") > 0 Then
            drCustomFieldName = CommonFunction.Data.GetDataReader("EXEC Usp_Sel_tbl_IB_CustomFields_Master " + m_ProjectId.ToString + ",'" + Replace(CommonFunction.General.BuildQueryString(strXAxis) + "", "$", "") + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drCustomFieldName.Read Then
                strXMsg = CommonFunction.Data.CheckIsDBNull(drCustomFieldName("UserGivenCaption"), strXAxis).ToString
            End If

            CommonFunction.Data.DisposeDataReader(drCustomFieldName)
        Else
            strXMsg = strXAxis
        End If

        'if y-axis is custom field then get the user given caption 
        'for the customer field							
        If InStr(strYAxis.ToUpper, "CUSTOMFIELD") > 0 Then
            drCustomFieldName = CommonFunction.Data.GetDataReader("EXEC Usp_Sel_tbl_IB_CustomFields_Master " + m_ProjectId.ToString + ",'" + Replace(CommonFunction.General.BuildQueryString(strYAxis) + "", "$", "") + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drCustomFieldName.Read Then
                strYMsg = CommonFunction.Data.CheckIsDBNull(drCustomFieldName("UserGivenCaption"), strYAxis).ToString
            End If

            CommonFunction.Data.DisposeDataReader(drCustomFieldName)
        Else
            strYMsg = strYAxis
        End If

        If InStr(strXAxis.ToUpper, "DATE") > 0 Then
            If Trim(strXAxisFromDate) <> "" Then
                strXMsg = strXMsg + "(From:" + CommonFunction.Dates.CGetDate(CType(strXAxisFromDate, Date)) + " To:"
            Else
                strXMsg = strXMsg + "(From:'Not Specified' To: "
            End If
            If Trim(strXAxisToDate) <> "" Then
                strXMsg = strXMsg + CommonFunction.Dates.CGetDate(CType(strXAxisToDate, Date)) + ")"
            Else
                strXMsg = strXMsg + "'Not Specified')"
            End If
        End If

        If InStr(strYAxis.ToUpper, "DATE") > 0 Then
            If Trim(strYAxisFromDate) <> "" Then
                strYMsg = strYMsg + "(From:" + CommonFunction.Dates.CGetDate(CType(strYAxisFromDate, Date)) + " To:"
            Else
                strYMsg = strYMsg + "(From:'Not Specified'To:"
            End If
            If Trim(strYAxisToDate) <> "" Then
                strYMsg = strYMsg + CommonFunction.Dates.CGetDate(CType(strYAxisToDate, Date)) + ")"
            Else
                strYMsg = strYMsg + "'Not Specified')"
            End If
        End If

        Response.Write("<TABLE cellspacing=0 cellpadding=0'width=25%'><TR class=clsTRSectionHeader><TD><B>" + MyBase.GetResourceString("XAXIS") + " : " + strXMsg + "</B></TD></TR>")
        Response.Write("<TR class=clsTRSectionHeader><TD><B>" + MyBase.GetResourceString("YAXIS") + " : " + strYMsg + "<B></TD></TR></table><BR>")

        Response.Write("<BR>")

        ''Added by Dhanashri S on 30 Nov 2015 for IssueID:2531
        Response.Write("<DIV ID='divclsTable' Style='Height:156px;WIDTH:600px;OVERFLOW:auto;'>")
        ''End of Addition by Dhanashri S on 30 Nov 2015

        Response.Write("<TABLE cellspacing=0 cellpadding=0 WIDTH='99.9%' class=clsTable><TR class=clsTREven></TR><TR class=clsTREven>")

        'for y axis
        Response.Write("<TD align=center Width=10'%'></TD>")
        'Modified By MrugajaB on 7th Feb,2005
        'Added m_strLoginType parameter in SP Usp_Sel_IB_2DRPT_XYAxis in order to recognize the login type
        'so that customer is exposed to only those issues  for which 'ShowToCustomer=1'
        If strXAxisType = "" Then
            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
        Else
            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",'" + CommonFunction.General.BuildQueryString(strXAxisType) + "',Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
        End If
        If strXAxisFromDate <> "" And strXAxisToDate <> "" Then
            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "','" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
        ElseIf strXAxisFromDate <> "" Then
            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "',Null," + strProjectGroupID + ",'" + m_LoginType + "'"
        ElseIf strXAxisToDate <> "" Then
            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,'" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
        End If
        'End Modification
        'Response.Write strSQL


        drGetXAxis = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        Do While drGetXAxis.Read
            intCol += 1
        Loop
        CommonFunction.Data.DisposeDataReader(drGetXAxis)

        ReDim intColSum(intCol + 1)

        drGetXAxis = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drGetXAxis.Read Then
            Do
                If Not drGetXAxis.IsDBNull(0) Then
                    If InStr(strXAxis.ToUpper, "DATE") > 0 Then
                        Response.Write("<TD align=center><B>" + CommonFunction.Dates.CGetDate(CType(drGetXAxis(0), Date)) + "</B></TD>")
                    Else
                        Response.Write("<TD align=center><B>" + drGetXAxis(0).ToString.Trim + "</B></TD>")
                    End If
                Else
                    Response.Write("<TD align=center><B>&lt;Not Specified&gt;</B></TD>")
                End If
            Loop While drGetXAxis.Read
            Response.Write("<TD align=center><B>" + MyBase.GetResourceString("TOTAL") + "</B></TD>")
            Response.Write("</TR>")
        Else 'no record present for x axis
            ExitLoop = True
            Response.Write("<TABLE cellspacing=0 cellpadding=0 class=clsTable width='99.9%'><TR class=clsTROdd><TD align=center>" + MyBase.GetResourceString("NODATAXAXIS") + "</tD></TR></TABLE>")
        End If

        If ExitLoop = False Then
            'Modified By MrugajaB on 7th Feb,2005
            'Added m_strLoginType parameter in SP Usp_Sel_IB_2DRPT_XYAxis in order to recognize the login type
            'so that customer is exposed to only those issues  for which 'ShowToCustomer=1'
            If strXAxisType = "" Then
                strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
            Else
                strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",'" + CommonFunction.General.BuildQueryString(strXAxisType) + "',Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
            End If

            If strXAxisFromDate <> "" And strXAxisToDate <> "" Then
                strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "','" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
            ElseIf strXAxisFromDate <> "" Then
                strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "',Null," + strProjectGroupID + ",'" + m_LoginType + "'"
            ElseIf strXAxisToDate <> "" Then
                strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,'" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
            End If        'Response.Write strSQL
            'End Modification

            'Modified By MrugajaB on 7th Feb,2005
            'Added m_strLoginType parameter in SP Usp_Sel_IB_2DRPT_XYAxis in order to recognize the login type
            'so that customer is exposed to only those issues  for which 'ShowToCustomer=1'
            drGetXAxis = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If strYAxisType = "" Then
                strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strYAxis) + "'," + m_ProjectId.ToString + ",Null,Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
            Else
                strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strYAxis) + "'," + m_ProjectId.ToString + ",'" + CommonFunction.General.BuildQueryString(strYAxisType) + "',Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
            End If
            If strYAxisFromDate <> "" And strYAxisToDate <> "" Then
                strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strYAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strYAxisFromDate + "','" + strYAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
            ElseIf strYAxisFromDate <> "" Then
                strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strYAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strYAxisFromDate + "',Null," + strProjectGroupID + ",'" + m_LoginType + "'"
            ElseIf strYAxisToDate <> "" Then
                strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strYAxis) + "'," + m_ProjectId.ToString + ",Null,Null,'" + strYAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
            End If        'Response.Write strSQL
            'End Modification

            drGetYAxis = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            'Response.Write strsQL

            'Response.Write "FC->" + rsGetXAxis.Fields.Count
            If drGetYAxis.Read Then
                Do
                    If Not drGetYAxis.IsDBNull(0) Then
                        If InStr(strYAxis.ToUpper, "DATE") > 0 Then
                            Response.Write("<TR class=clsTROdd><TD align=center>" + CommonFunction.Dates.CGetDate(CType(drGetYAxis(0), Date)) + "</TD>")
                        Else
                            Response.Write("<TR class=clsTROdd><TD align=center><B>" + drGetYAxis(0).ToString + "</B></TD>")
                        End If
                    Else
                        Response.Write("<TR class=clsTROdd><TD align=center><B>&lt;Not Specified&gt;</B></TD>")
                    End If

                    'Modified By MrugajaB on 7th Feb,2005
                    'Added m_strLoginType parameter in SP Usp_Sel_IB_2DRPT_XYAxis in order to recognize the login type
                    'so that customer is exposed to only those issues  for which 'ShowToCustomer=1'
                    If strXAxisType = "" Then
                        strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                    Else
                        strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",'" + CommonFunction.General.BuildQueryString(strXAxisType) + "',Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                    End If
                    'if user has seleted the any date field
                    If strXAxisFromDate <> "" And strXAxisToDate <> "" Then
                        strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "','" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
                    ElseIf strXAxisFromDate <> "" Then
                        strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "',Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                    ElseIf strXAxisToDate <> "" Then
                        strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,'" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
                    End If        'Response.Write strSQL
                    'End Modification

                    drGetXAxis = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    intRowSum = 0
                    intColCount = 0

                    ''plot the actual table for 2d report
                    Do While drGetXAxis.Read
                        strSQL = "EXEC Usp_Sel_IB_2DRPT_XYAxis_Values " + m_ProjectId.ToString & ",'" + CommonFunction.General.BuildQueryString(CType(CommonFunction.Data.CheckIsDBNull(drGetXAxis(0), ""), String)) + "','" + CommonFunction.General.BuildQueryString(CType(CommonFunction.Data.CheckIsDBNull(drGetYAxis(0), ""), String)) + "',Null,'" + CommonFunction.General.BuildQueryString(strXAxis) + "','" + CommonFunction.General.BuildQueryString(strYAxis) + "',Null," + strProjectGroupID + ",'" + Replace(strType + "", "+", " ") + "','" + m_LoginType + "'"

                        drGetXYAxisValue = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        If drGetXYAxisValue.Read Then
                            'if value is non zero then only show the link.
                            If CType(drGetXYAxisValue(0), Integer) <> 0 Then
                                Response.Write("<TD align=center><A HREF=" + Chr(34) + "JavaScript:ShowDetails('" + strXAxis + "','" + strYAxis + "','0','" + Replace(drGetXAxis(0).ToString, "'", "||--||") + "','" + Replace(drGetYAxis(0).ToString, "'", "||--||") + "','0','" + strXAxisTypeQR + "','" + strYAxisTypeQR + "','" + strBasedOnTypeQR + "','" + strXAxisFromDateQR + "','" + strXAxisToDateQR + "','" + strYAxisFromDateQR + "','" + strYAxisToDateQR + "','" + strBasedOnFromDateQR + "','" + strBasedOnToDateQR + "','I')" + Chr(34) + ">" + drGetXYAxisValue(0).ToString + "</A></TD>")
                            Else
                                Response.Write("<TD align=center>" + drGetXYAxisValue(0).ToString + "</TD>")
                            End If
                            intColSum(intColCount) = intColSum(intColCount) + CType(drGetXYAxisValue(0), Integer)
                            intColCount = intColCount + 1
                            intRowSum = intRowSum + CType(drGetXYAxisValue(0), Integer)
                        End If
                        CommonFunction.Data.DisposeDataReader(drGetXYAxisValue)
                    Loop
                    'end
                    intColSum(intColCount) = intColSum(intColCount) + intRowSum
                    Response.Write("<TD align=center><B>" + intRowSum.ToString + "</B></tD>")
                    Response.Write("</TR>")
                Loop While drGetYAxis.Read

                Response.Write("<TR class=clsTREven><TD align=center><B>" + MyBase.GetResourceString("TOTAL") + "</B></TD>")
                'Modified By MrugajaB on 7th Feb,2005
                'Added m_strLoginType parameter in SP Usp_Sel_IB_2DRPT_XYAxis in order to recognize the login type
                'so that customer is exposed to only those issues  for which 'ShowToCustomer=1'

                ''Open XAxis again
                If strXAxisType = "" Then
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                Else
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",'" + CommonFunction.General.BuildQueryString(strXAxisType) + "',Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                End If
                If strXAxisFromDate <> "" And strXAxisToDate <> "" Then
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "','" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
                ElseIf strXAxisFromDate <> "" Then
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "',Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                ElseIf strXAxisToDate <> "" Then
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,'" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
                End If        'Response.Write strSQL
                'End Modification
                'end
                drGetXAxis = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                'x y axis total
                For intCol = 0 To intColCount
                    If drGetXAxis.Read Then
                        'if value is non zero then only show the link													
                        If intCol <> intColCount And intColSum(intCol) <> 0 Then
                            If strYAxisFromDate <> "" Or strYAxisToDate <> "" Then
                                Response.Write("<TD align=center><B><A HREF=" + Chr(34) + "JavaScript:ShowDetails('" + strXAxis + "','" + strYAxis + "','0','" + Replace(drGetXAxis(0).ToString, "'", "||--||") + "','0','0','" + strXAxisTypeQR + "','" + strYAxisTypeQR + "','" + strBasedOnTypeQR + "','" + strXAxisFromDateQR + "','" + strXAxisToDateQR + "','" + strYAxisFromDateQR + "','" + strYAxisToDateQR + "','" + strBasedOnFromDateQR + "','" + strBasedOnToDateQR + "','T')" + Chr(34) + ">" + intColSum(intCol).ToString + "</A></TD>")
                            Else
                                Response.Write("<TD align=center><B><A HREF=" + Chr(34) + "JavaScript:ShowDetails('" + strXAxis + "','0','0','" + Replace(drGetXAxis(0).ToString, "'", "||--||") + "','0','0','" + strXAxisTypeQR + "','" + strYAxisTypeQR + "','" + strBasedOnTypeQR + "','" + strXAxisFromDateQR + "','" + strXAxisToDateQR + "','" + strYAxisFromDateQR + "','" + strYAxisToDateQR + "','" + strBasedOnFromDateQR + "','" + strBasedOnToDateQR + "','T')" + Chr(34) + ">" + intColSum(intCol).ToString + "</A></TD>")
                            End If
                        Else
                            Response.Write("<TD align=center><B>" + intColSum(intCol).ToString + "</B></TD>")
                        End If
                    Else
                        Response.Write("<TD align=center><B>" + intColSum(intCol).ToString + "</B></TD>")
                    End If
                Next
                Response.Write("</TR>")
                Response.Write("</TABLE>")

                ''Added by Dhanashri S on 30 Nov 2015 for IssueID:2531
                Response.Write("</Div>")
                ''End of Addition by Dhanashri S on 30 Nov 2015

            Else 'no record present for y axis
                Response.Write("<TABLE cellspacing=0 cellpadding=0 class=clsTable width='99.9%'><TR class=clsTREven><TD align=center>" + MyBase.GetResourceString("NODATAYAXIS") + "</tD></TR></TABLE>")
            End If
        End If 'exit loop end if	
        ''end two dimensional 			
    End Sub

    Private Sub Generate3DReport()
        '=====================================================================
        ' Procedure Name        : Generate3DReport()	
        ' Purpose               : To generate 3D report
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 5, 2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String

        Response.Write("<TITLE>Issue Base 3D Reports</TITLE>")
        'if xaxis is custom field then get the user given caption 
        'for the customer field							
        If InStr(strXAxis.ToUpper, "CUSTOMFIELD") > 0 Then
            Dim drCustomeFIeldName As IDataReader
            drCustomeFIeldName = CommonFunction.Data.GetDataReader("EXEC Usp_Sel_tbl_IB_CustomFields_Master " + m_ProjectId.ToString + ",'" + Replace(CommonFunction.General.BuildQueryString(strXAxis) + "", "$", "") + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drCustomeFIeldName.Read Then
                strXMsg = drCustomeFIeldName("UserGivenCaption").ToString
            Else
                strXMsg = strXAxis
            End If
            Call CommonFunction.Data.DisposeDataReader(drCustomeFIeldName)
        Else
            strXMsg = strXAxis
        End If

        'if y-axis is custom field then get the user given caption 
        'for the custome field							
        If InStr(strYAxis.ToUpper, "CUSTOMFIELD") > 0 Then
            Dim drCustomeFIeldName As IDataReader
            drCustomeFIeldName = CommonFunction.Data.GetDataReader("EXEC Usp_Sel_tbl_IB_CustomFields_Master " + m_ProjectId.ToString + ",'" + Replace(CommonFunction.General.BuildQueryString(strYAxis) + "", "$", "") + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drCustomeFIeldName.Read Then
                strYMsg = drCustomeFIeldName("UserGivenCaption").tostring
            Else
                strYMsg = strYAxis
            End If
            Call CommonFunction.Data.DisposeDataReader(drCustomeFIeldName)
        Else
            strYMsg = strYAxis
        End If

        'if based on is a custom filed then get the user given caption 
        'for the custom field
        If InStr(strBased.ToUpper, "CUSTOMFIELD") > 0 Then
            Dim drCustomeFIeldName As IDataReader
            drCustomeFIeldName = CommonFunction.Data.GetDataReader("EXEC Usp_Sel_tbl_IB_CustomFields_Master " + m_ProjectId.ToString + ",'" + Replace(CommonFunction.General.BuildQueryString(strBased) + "", "$", "") + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drCustomeFIeldName.Read Then
                strBMsg = drCustomeFIeldName("UserGivenCaption").tostring
            Else
                strBMsg = strBased
            End If
            Call CommonFunction.Data.DisposeDataReader(drCustomeFIeldName)
        Else
            strBMsg = strBased
        End If


        If InStr(strXAxis.ToUpper, "DATE") > 0 Then
            If Trim(strXAxisFromDate) <> "" Then
                strXMsg = strXMsg + "(From:" + CommonFunction.Dates.CGetDate(CType(strXAxisFromDate, Date)) + " To:"
            Else
                strXMsg = strXMsg + "(From:'Not Specified'To:"
            End If

            If Trim(strXAxisToDate) <> "" Then
                strXMsg = strXMsg + CommonFunction.Dates.CGetDate(CType(strXAxisToDate, Date)) + ")"
            Else
                strXMsg = strXMsg + "'Not Specified')"
            End If
        End If

        If InStr(strYAxis.ToUpper, "DATE") > 0 Then
            If Trim(strYAxisFromDate) <> "" Then
                strYMsg = strYMsg + "(From:" + CommonFunction.Dates.CGetDate(CType(strYAxisFromDate, Date)) + " To:"
            Else
                strYMsg = strYMsg + "(From:'Not Specified'To:"
            End If

            If Trim(strYAxisToDate) <> "" Then
                strYMsg = strYMsg + CommonFunction.Dates.CGetDate(CType(strYAxisToDate, Date)) + ")"
            Else
                strYMsg = strYMsg + "'Not Specified')"
            End If
        End If

        If InStr(strBased.ToUpper, "DATE") > 0 Then
            If Trim(strBasedOnFromDate) <> "" Then
                strBMsg = strBMsg + "(From:" + CommonFunction.Dates.CGetDate(CType(strBasedOnFromDate, Date)) + " To:"
            Else
                strBMsg = strBMsg + "(From:'Not Specified' To:"
            End If
            If Trim(strBasedOnToDate) <> "" Then
                strBMsg = strBMsg + CommonFunction.Dates.CGetDate(CType(strBasedOnToDate, Date)) + ")"
            Else
                strBMsg = strBMsg + "'Not Specified')"
            End If
        End If



        Response.Write("<TABLE  cellspacing=0 cellpadding=0 'width=25%'><TR class=clsTREven><TD><B>" + MyBase.GetResourceString("XAXIS") + " : " + strXMsg + "</B></TD></TR>")
        Response.Write("<TR class=clsTREven><TD><B>" + MyBase.GetResourceString("YAXIS") + " : " + strYMsg + "</B></TD></TR>")
        Response.Write("<TR class=clsTREven><TD><B>" + MyBase.GetResourceString("BASEDON") + " : " + strBMsg + "</B></TD></TR></table><BR>")

        'Modified By MrugajaB on 7th Feb,2005
        'Added m_strLoginType parameter in SP Usp_Sel_IB_2DRPT_XYAxis in order to recognize the login type
        'so that customer is exposed to only those issues  for which 'ShowToCustomer=1'
        If strBasedOnType = "" Then
            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strBased) + "'," + m_ProjectId.ToString + ",Null,Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
        Else
            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strBased) + "'," + m_ProjectId.ToString + ",'" + CommonFunction.General.BuildQueryString(strBasedOnType) + "',Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
        End If

        'if user has seleted the any date field
        If strBasedOnFromDate <> "" And strBasedOnToDate <> "" Then
            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strBased) + "'," + m_ProjectId.ToString + ",Null,'" + CommonFunction.General.BuildQueryString(strBasedOnFromDate) + "','" + CommonFunction.General.BuildQueryString(strBasedOnToDate) + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
        ElseIf strBasedOnFromDate <> "" Then
            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strBased) + "'," + m_ProjectId.ToString + ",Null,'" + CommonFunction.General.BuildQueryString(strBasedOnFromDate) + "',Null," + strProjectGroupID + ",'" + m_LoginType + "'"
        ElseIf strBasedOnToDate <> "" Then
            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strBased) + "'," + m_ProjectId.ToString + ",Null,Null,'" + CommonFunction.General.BuildQueryString(strBasedOnToDate) + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
        End If
        'End Modification

        'Response.Write strSQL
        'Dim drBasedOn As IDataReader
        'drBasedOn = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        Dim drBasedOn As IDataReader
        drBasedOn = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

        '**********************************************************************************
        'Code Added By      :   NikhatM     22 Febuary 2005
        'Purpose            :   To display the grand total of the report at the end...
        '                       We need to maintain the 'Based on' count...
        '**********************************************************************************
        Dim intBasedOnTotalCount As Integer
        Dim intBasedOnRowCount As Integer
        intBasedOnTotalCount = 0
        intBasedOnRowCount = 0
        Do While drBasedOn.Read
            intBasedOnTotalCount += 1
        Loop
        CommonFunction.Data.DisposeDataReader(drBasedOn)
        '**********************************************************************************
        'End of Addition    :   NikhatM     22 Febuary 2005
        '**********************************************************************************

        drBasedOn = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))


        ''Added by Dhanashri S on 7 Dec 2015 for IssueID:2531
        Response.Write("<DIV ID='divclsTable' Style='Height:250px;WIDTH:600px;OVERFLOW:auto;'>")
        ''End of Addition by Dhanashri S on 30 Nov 2015


        Response.Write("<TABLE cellspacing=0 cellpadding=0 WIDTH='99.9%' class=clsTable><TR class=clsTREven>")

        'Define the array for report total
        Dim blnFirstLoop As Boolean = True
        If drBasedOn.Read Then
            Do
                'Addition by NikhatM
                intBasedOnRowCount += 1
                'addition ends
                Response.Write("<TR class=clsTREVEN>")
                If CommonFunction.Data.CheckIsDBNull(drBasedOn(0), "").ToString <> "" Then
                    If InStr(strBased.ToUpper, "DATE") > 0 Then
                        Response.Write("<TD valign=center align=center>" + CommonFunction.Dates.GetDate(CType(drBasedOn(0), Date)) + "</TD>")
                    Else
                        Response.Write("<TD valign=center align=center>" + drBasedOn(0).ToString + "</TD>")
                    End If
                Else
                    Response.Write("<TD valign=center align=center>&lt;Not Specified&gt;</TD>")
                End If
                Response.Write("<TD align=center >")

                'for based on
                Response.Write("<TABLE cellspacing=0 cellpadding=0 WIDTH='99.9%' class=clsTable><TR class=clsTREven>")

                'for y axis
                'Modified By MrugajaB on 7th Feb,2005
                'Added m_strLoginType parameter in SP Usp_Sel_IB_2DRPT_XYAxis in order to recognize the login type
                'so that customer is exposed to only those issues  for which 'ShowToCustomer=1'
                Response.Write("<TD Width=10'%'></TD>")
                If strXAxisType = "" Then
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                Else
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",'" + CommonFunction.General.BuildQueryString(strXAxisType) + "',Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                End If
                'if user has seleted the any date field
                If strXAxisFromDate <> "" And strXAxisToDate <> "" Then
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "','" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
                ElseIf strXAxisFromDate <> "" Then
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "',Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                ElseIf strXAxisToDate <> "" Then
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,'" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
                End If
                'End Modification
                'Response.Write strSQL
                Dim drGetXAxis As IDataReader, intCol As Integer
                drGetXAxis = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                Do While drGetXAxis.Read
                    intCol += 1
                Loop
                CommonFunction.Data.DisposeDataReader(drGetXAxis)

                ReDim intColSum(intCol + 1) 'define array for based on total


                drGetXAxis = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If blnFirstLoop = True Then
                    ReDim intReportSum(intCol + 1)
                End If
                'reset the first loop variable 
                blnFirstLoop = False
                If drGetXAxis.Read Then
                    Do
                        If Not drGetXAxis.IsDBNull(0) Then
                            If InStr(strXAxis.ToUpper, "DATE") > 0 Then
                                Response.Write("<TD align=center><B>" + CommonFunction.Dates.CGetDate(CType(drGetXAxis(0), Date)) + "</B></TD>")
                            Else
                                Response.Write("<TD align=center><B>" + Trim(drGetXAxis(0).ToString) + "</B></TD>")
                            End If
                        Else
                            Response.Write("<TD align=center><B>&lt;Not Specified&gt;</B></TD>")
                        End If
                    Loop While drGetXAxis.Read
                    Response.Write("<TD align=center><B>" + MyBase.GetResourceString("TOTAL") + "</B></TD>")
                    Response.Write("</TR>")
                Else 'no record preset for x axis
                    ExitLoop = True
                    Response.Write("<TABLE cellspacing=0 cellpadding=0 class=clsTable width='99.9%'><TR class=clsTREven><TD align=center>" + MyBase.GetResourceString("NODATAXAXIS") + "</tD></TR></TABLE>")
                End If

                'Modified By MrugajaB on 7th Feb,2005
                'Added m_strLoginType parameter in SP Usp_Sel_IB_2DRPT_XYAxis in order to recognize the login type
                'so that customer is exposed to only those issues  for which 'ShowToCustomer=1'
                If strXAxisType = "" Then
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                Else
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",'" + CommonFunction.General.BuildQueryString(strXAxisType) + "',Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                End If

                'if user has seleted the any date field
                If strXAxisFromDate <> "" And strXAxisToDate <> "" Then
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "','" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
                ElseIf strXAxisFromDate <> "" Then
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "',Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                ElseIf strXAxisToDate <> "" Then
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,'" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
                End If        'Response.Write strSQL


                drGetXAxis = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                If strYAxisType = "" Then
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strYAxis) + "'," + m_ProjectId.ToString + ",Null,Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                Else
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strYAxis) + "'," + m_ProjectId.ToString + ",'" + CommonFunction.General.BuildQueryString(strYAxisType) + "',Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                End If

                'if user has seleted the any date field
                If strYAxisFromDate <> "" And strYAxisToDate <> "" Then
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strYAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strYAxisFromDate + "','" + strYAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
                ElseIf strYAxisFromDate <> "" Then
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strYAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strYAxisFromDate + "',Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                ElseIf strYAxisToDate <> "" Then
                    strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strYAxis) + "'," + m_ProjectId.ToString + ",Null,Null,'" + strYAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
                End If
                'Response.Write strSQL
                'End Modification

                'Execute the query to get the recordset
                Dim drGetYAxis As IDataReader
                drGetYAxis = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                If ExitLoop = False Then 'x axis no data
                    'Response.Write "FC->" + rsGetXAxis.Fields.Count
                    If drGetYAxis.Read Then
                        Do
                            If Not drGetYAxis.IsDBNull(0) Then
                                If InStr(strYAxis.ToUpper, "DATE") > 0 Then
                                    Response.Write("<TR class=clsTREven><TD align=center>" + CommonFunctions.Dates.CGetDate(CType(drGetYAxis(0), Date)) + "</TD>")
                                Else
                                    Response.Write("<TR class=clsTREven><TD align=center>" + drGetYAxis(0).ToString.Trim + "</TD>")
                                End If
                            Else
                                Response.Write("<TR class=clsTREven><TD align=center>&lt;Not Specified&gt;</TD>")
                            End If

                            'Modified By MrugajaB on 7th Feb,2005
                            'Added m_strLoginType parameter in SP Usp_Sel_IB_2DRPT_XYAxis in order to recognize the login type
                            'so that customer is exposed to only those issues  for which 'ShowToCustomer=1'
                            If strXAxisType = "" Then
                                strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                            Else
                                strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",'" + CommonFunction.General.BuildQueryString(strXAxisType) + "',Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                            End If

                            'if user has seleted the any date field
                            If strXAxisFromDate <> "" And strXAxisToDate <> "" Then
                                strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "','" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
                            ElseIf strXAxisFromDate <> "" Then
                                strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "',Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                            ElseIf strXAxisToDate <> "" Then
                                strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,'" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
                            End If
                            'Response.Write strSQL
                            'End Modification
                            drGetXAxis = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            intRowSum = 0
                            intColCount = 0

                            Do While drGetXAxis.Read  'y axis

                                strSQL = "EXEC Usp_Sel_IB_2DRPT_XYAxis_Values " + m_ProjectId.ToString + ",'" + CommonFunction.General.BuildQueryString(drGetXAxis(0).ToString) + "','" + CommonFunction.General.BuildQueryString(drGetYAxis(0).ToString) + "','" + CommonFunction.General.BuildQueryString(drBasedOn(0).ToString) + "','" + CommonFunction.General.BuildQueryString(strXAxis) + "','" + CommonFunction.General.BuildQueryString(strYAxis) + "','" + CommonFunction.General.BuildQueryString(strBased) + "'," + strProjectGroupID + ",'" + Replace(strType, "+", " ") + "','" + m_LoginType + "'"

                                'Response.Write strSQL
                                Dim drGetXYAxisValue As IDataReader
                                drGetXYAxisValue = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drGetXYAxisValue.Read Then
                                    'if value is not only 0 then only show the link
                                    If CType(drGetXYAxisValue(0), Integer) <> 0 Then
                                        Response.Write("<TD align=center><A HREF=" + Chr(34) + "JavaScript:ShowDetails('" + strXAxis + "','" + strYAxis + "','" + strBased + "','" + Replace(drGetXAxis(0).ToString, "'", "||--||") + "','" + Replace(drGetYAxis(0).ToString, "'", "||--||") + "','" + Replace(drBasedOn(0).ToString, "'", "||--||") + "','" + strXAxisTypeQR + "','" + strYAxisTypeQR + "','" + strBasedOnTypeQR + "','" + strXAxisFromDateQR + "','" + strXAxisToDateQR + "','" + strYAxisFromDateQR + "','" + strYAxisToDateQR + "','" + strBasedOnFromDateQR + "','" + strBasedOnToDateQR + "','I')" + Chr(34) + ">" + drGetXYAxisValue(0).ToString + "</A></TD>")
                                    Else 'dont show the link
                                        Response.Write("<TD align=center>" + drGetXYAxisValue(0).ToString + "</A></TD>")
                                    End If
                                    'increament the column sum
                                    intColSum(intColCount) = intColSum(intColCount) + CType(drGetXYAxisValue(0), Integer)
                                    'increament the row sum
                                    intReportSum(intColCount) = intReportSum(intColCount) + CType(drGetXYAxisValue(0), Integer)
                                    'increament the count
                                    intColCount = intColCount + 1
                                    intRowSum = intRowSum + CType(drGetXYAxisValue(0), Integer)
                                End If
                                CommonFunction.Data.DisposeDataReader(drGetXYAxisValue)
                            Loop ' y axis loop

                            intColSum(intColCount) = intColSum(intColCount) + intRowSum
                            intReportSum(intColCount) = intReportSum(intColCount) + intRowSum
                            Response.Write("<TD align=center><B>" + intRowSum.ToString + "</B></tD>")
                            Response.Write("</TR>")
                        Loop While drGetYAxis.Read
                        Response.Write("<TR class=clsTREven><TD align=center Width='35%'><B>" + MyBase.GetResourceString("TOTAL") + "</B></TD>")
                        'write the total	

                        'open xaxis again

                        'Modified By MrugajaB on 7th Feb,2005
                        'Added m_strLoginType parameter in SP Usp_Sel_IB_2DRPT_XYAxis in order to recognize the login type
                        'so that customer is exposed to only those issues  for which 'ShowToCustomer=1'
                        ''Open XAxis again
                        If strXAxisType = "" Then
                            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                        Else
                            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",'" + CommonFunction.General.BuildQueryString(strXAxisType) + "',Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                        End If
                        If strXAxisFromDate <> "" And strXAxisToDate <> "" Then
                            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "','" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
                        ElseIf strXAxisFromDate <> "" Then
                            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "',Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                        ElseIf strXAxisToDate <> "" Then
                            strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,'" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
                        End If
                        'End Modification
                        'end
                        drGetXAxis = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                        'end

                        For intCol = 0 To intColCount

                            'if  not eof then move next
                            If Not drGetXAxis.Read Then
                                Response.Write("<TD align=center><B>" + intColSum(intCol).ToString + "</B></TD>")
                                Exit For
                            End If

                            'int sum 0 then dont show the link
                            If intCol <> intColCount And intColSum(intCol) <> 0 Then
                                If strYAxisFromDate <> "" Or strYAxisToDate <> "" Then
                                    Response.Write("<TD align=center><B><A HREF=" + Chr(34) + "JavaScript:ShowDetails('" + strXAxis + "','" + strYAxis + "','" + strBased + "','" + Replace(drGetXAxis(0).ToString, "'", "||--||") + "','0','" + Replace(drBasedOn(0).ToString, "'", "||--||") + "','" + strXAxisTypeQR + "','" + strYAxisTypeQR + "','" + strBasedOnTypeQR + "','" + strXAxisFromDateQR + "','" + strXAxisToDateQR + "','" + strYAxisFromDateQR + "','" + strYAxisToDateQR + "','" + strBasedOnFromDateQR + "','" + strBasedOnToDateQR + "','T')" + Chr(34) + ">" + intColSum(intCol).ToString + "</A></B></TD>")
                                Else
                                    Response.Write("<TD align=center><B><A HREF=" + Chr(34) + "JavaScript:ShowDetails('" + strXAxis + "','0','" + strBased + "','" + Replace(drGetXAxis(0).ToString, "'", "||--||") + "','0','" + Replace(drBasedOn(0).ToString, "'", "||--||") + "','" + strXAxisTypeQR + "','" + strYAxisTypeQR + "','" + strBasedOnTypeQR + "','" + strXAxisFromDateQR + "','" + strXAxisToDateQR + "','" + strYAxisFromDateQR + "','" + strYAxisToDateQR + "','" + strBasedOnFromDateQR + "','" + strBasedOnToDateQR + "','I')" + Chr(34) + ">" + intColSum(intCol).ToString + "</A></B></TD>")
                                End If
                            Else
                                Response.Write("<TD align=center><B>" + intColSum(intCol).ToString + "</B></TD>")
                            End If
                        Next

                        Response.Write("</TR>")
                    Else 'no record present for y axis
                        Response.Write("<TABLE cellspacing=0 cellpadding=0 class=clsTable width='99.9%'><TR class=clsTREven><TD align=center>" + MyBase.GetResourceString("NODATAYAXIS") + "</tD></TR></TABLE>")
                        Exit Do
                    End If
                Else  'x axis no data present
                    Exit Do
                End If 'exit loop x axis no data

                'move main loop
                'drBasedOn.Read()

                'Code changed by NikhatM on 22 Feb 2005
                'Reason: Because of .Read() the report shows alternate records. 
                'If Not drBasedOn.Read() Then
                If intBasedOnRowCount >= intBasedOnTotalCount Then
                    'open xaxis again
                    ''Open XAxis again to get the x axis fields
                    'Modified By MrugajaB on 7th Feb,2005
                    'Added m_strLoginType parameter in SP Usp_Sel_IB_2DRPT_XYAxis in order to recognize the login type
                    'so that customer is exposed to only those issues  for which 'ShowToCustomer=1'
                    If strXAxisType = "" Then
                        strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                    Else
                        strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",'" + CommonFunction.General.BuildQueryString(strXAxisType) + "',Null,Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                    End If
                    If strXAxisFromDate <> "" And strXAxisToDate <> "" Then
                        strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "','" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
                    ElseIf strXAxisFromDate <> "" Then
                        strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,'" + strXAxisFromDate + "',Null," + strProjectGroupID + ",'" + m_LoginType + "'"
                    ElseIf strXAxisToDate <> "" Then
                        strSQL = "Usp_Sel_IB_2DRPT_XYAxis " + "'" + CommonFunction.General.BuildQueryString(strXAxis) + "'," + m_ProjectId.ToString + ",Null,Null,'" + strXAxisToDate + "'," + strProjectGroupID + ",'" + m_LoginType + "'"
                    End If

                    'end Modification
                    drGetXAxis = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    'end

                    'Print report total
                    Response.Write("<TR class=clsTRSectionHeader><TD  align=center Width='25%'><B>" + MyBase.GetResourceString("TOTAL") + "</B></TD>")
                    'rsBasedOn.MoveLast
                    For intCol = 0 To intColCount
                        If Not drGetXAxis.Read() Then
                            Response.Write("<TD align=center height=20><B>" + intReportSum(intCol).ToString + "</B></TD>")
                            Exit For
                        End If
                        'if value is non zero then only show the link
                        If intCol <> intColCount And intReportSum(intCol) <> 0 Then

                            If (strYAxisFromDate <> "" Or strYAxisToDate <> "") And (strBasedOnFromDate <> "" Or strBasedOnToDate <> "") Then
                                'Response.Write "Y HERE"
                                Response.Write("<TD align=center><B><A  HREF=" + Chr(34) + "JavaScript:ShowDetails('" + strXAxis + "','" + strYAxis + "','" + strBased + "','" + Replace(drGetXAxis(0).ToString, "'", "||--||") + "','0','0','" + strXAxisTypeQR + "','" + strYAxisTypeQR + "','" + strBasedOnTypeQR + "','" + strXAxisFromDateQR + "','" + strXAxisToDateQR + "','" + strYAxisFromDateQR + "','" + strYAxisToDateQR + "','" + strBasedOnFromDateQR + "','" + strBasedOnToDateQR + "','T')" + Chr(34) + "><FONT Face=Verdana Size=1 color=white><B>" + intReportSum(intCol).ToString + "</A></B></FONT></TD>")
                            ElseIf strYAxisFromDate <> "" Or strYAxisToDate <> "" Then
                                Response.Write("<TD align=center><B><A  HREF=" + Chr(34) + "JavaScript:ShowDetails('" + strXAxis + "','" + strYAxis + "','0','" + Replace(drGetXAxis(0).ToString, "'", "||--||") + "','0','0','" + strXAxisTypeQR + "','" + strYAxisTypeQR + "','" + strBasedOnTypeQR + "','" + strXAxisFromDateQR + "','" + strXAxisToDateQR + "','" + strYAxisFromDateQR + "','" + strYAxisToDateQR + "','" + strBasedOnFromDateQR + "','" + strBasedOnToDateQR + "','T')" + Chr(34) + "><FONT Face=Verdana Size=1 color=white><B>" + intReportSum(intCol).ToString + "</A></B></FONT></TD>")
                            ElseIf strBasedOnFromDate <> "" Or strBasedOnToDate <> "" Then
                                'Response.Write "Y"
                                Response.Write("<TD align=center><B><A  HREF=" + Chr(34) + "JavaScript:ShowDetails('" + strXAxis + "','0','" + strBased + "','" + Replace(drGetXAxis(0).ToString, "'", "||--||") + "','0','0','" + strXAxisTypeQR + "','" + strYAxisTypeQR + "','" + strBasedOnTypeQR + "','" + strXAxisFromDateQR + "','" + strXAxisToDateQR + "','" + strYAxisFromDateQR + "','" + strYAxisToDateQR + "','" + strBasedOnFromDateQR + "','" + strBasedOnToDateQR + "','T')" + Chr(34) + "><FONT Face=Verdana Size=1 color=white><B>" + intReportSum(intCol).ToString + "</A></B></FONT></TD>")
                            Else
                                Response.Write("<TD align=center><B><A  HREF=" + Chr(34) + "JavaScript:ShowDetails('" + strXAxis + "','0','0','" + Replace(drGetXAxis(0).ToString, "'", "||--||") + "','0','0','" + strXAxisTypeQR + "','" + strYAxisTypeQR + "','" + strBasedOnTypeQR + "','" + strXAxisFromDateQR + "','" + strXAxisToDateQR + "','" + strYAxisFromDateQR + "','" + strYAxisToDateQR + "','" + strBasedOnFromDateQR + "','" + strBasedOnToDateQR + "','T')" + Chr(34) + "><FONT Face=Verdana Size=1 color=white><B>" + intReportSum(intCol).ToString + "</A></B></FONT></TD>")
                            End If
                            'Response.Write("<TD align=center height=20 class=clsTDOdd  ><B>" + intReportSum(intCol).ToString + "</B></TD>")
                        Else
                            Response.Write("<TD align=center height=20><B>" + intReportSum(intCol).ToString + "</B></TD>")
                        End If
                        'drGetXAxis.Read()
                    Next
                End If
                Response.Write("</TABLE></TD></TR>")
                Response.Write("<TR class=clsTREven height=5><TD=colspan=2></TD></TR>")
            Loop While drBasedOn.Read 'based on loop end of main loop		
            Response.Write("</TABLE>")


            ''Added by Dhanashri S on 7 Dec 2015 for IssueID:2531
            Response.Write("</Div>")
            ''End of Addition by Dhanashri S on 7 Dec 2015




        Else 'if no recrod present
            Response.Write("<TABLE cellspacing=0 cellpadding=0 class=clsTable width='99.9%'><TR class=clsTREven><TD align=center>There is no data present for given based on criteria</tD></TR></TABLE>")
        End If
        'End  three dimensional Report 
    End Sub

#End Region 'All Private Procedures used in code

#Region " Public Procedures "



    Public Sub BuildPage()
        Dim strMenu As String

        Call CreateGlobalObject()

        'Get ProjectGroupId
        If MyBase.GetFormValue("cboProjectGroup") <> "" Then
            strProjectGroupID = MyBase.GetFormValue("cboProjectGroup")
        Else
            strProjectGroupID = "NULL"
        End If

        'Get Mode 
        If Not Request("Mode") Is Nothing Then
            strMode = Request("Mode")
        Else
            strMode = ""
        End If

        'Type Boxes
        'X Axis Type
        If Not Request.QueryString("cboXAxisType") Is Nothing Then strXAxisType = Replace(Request.QueryString("cboXAxisType"), "+", " ")

        'Y Axis Type
        If Not Request.QueryString("cboYAxisType") Is Nothing Then strYAxisType = Replace(Request.QueryString("cboYAxisType"), "+", " ")

        'Based On Type
        If Not Request.QueryString("cboBasedOnType") Is Nothing Then strBasedOnType = Replace(Request.QueryString("cboBasedOnType"), "+", " ")

        'Dates x Axis
        'From Date
        If Not Request.QueryString("txtXAxisFromDate") Is Nothing Then strXAxisFromDate = Replace(Request.QueryString("txtXAxisFromDate"), "+", " ")

        'To Date
        If Not Request.QueryString("txtXAxisToDate") Is Nothing Then strXAxisToDate = Replace(Request.QueryString("txtXAxisToDate"), "+", " ")

        'Dates y axis
        'From Date
        If Not Request.QueryString("txtYAxisFromDate") Is Nothing Then strYAxisFromDate = Replace(Request.QueryString("txtYAxisFromDate"), "+", " ")
        'To Date
        If Not Request.QueryString("txtYAxisToDate") Is Nothing Then strYAxisToDate = Replace(Request.QueryString("txtYAxisToDate"), "+", " ")

        'Dates Based on date
        'From Date
        If Not Request.QueryString("txtBasedOnFromDate") Is Nothing Then strBasedOnFromDate = Replace(Request.QueryString("txtBasedOnFromDate"), "+", " ")

        'To Date
        If Not Request.QueryString("txtBasedOnToDate") Is Nothing Then strBasedOnToDate = Replace(Request.QueryString("txtBasedOnToDate"), "+", " ")

        'get the axis fields
        If Not Request.QueryString("cboXAxis") Is Nothing Then strXAxis = Replace(Request.QueryString("cboXAxis"), "+", " ")
        If Not Request.QueryString("cboYAxis") Is Nothing Then strYAxis = Replace(Request.QueryString("cboYAxis"), "+", " ")
        If Not Request.QueryString("cboBasedOn") Is Nothing Then strBased = Replace(Request.QueryString("cboBasedOn"), "+", " ")

        Select Case strMode.ToUpper
            Case "SAVE"
                Call SaveReport()
            Case "DELETE"
                Call DeleteReports()
            Case "GENERATEREPORT"
                Call GenerateReport()
                Exit Sub
        End Select

        Call GenerateCliendSideArray()

        'Generate menu
        strMenu = GenerateMenu()
        Response.Write(strMenu)

        'Generate Page Legends
        Call GeneratePageLegends()

        'Generate Page Header
        Call GeneratePageCaption()

        Call PlotControls()

        Call PlotGrid()

        Response.Write(strMenu)

    End Sub 'Main Procedure to build the page

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
        ' Created               : Feb 3, 2004
        ' Revisions             :
        '=====================================================================

        'Apply security
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016

        'Initialize standard menu resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

    End Sub 'Constructor for page

    Public Sub PlotPageHeadTag()
        '=====================================================================
        ' Procedure Name         : PlotPageHeadTag()	
        ' Purpose               : To plot page head tag 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             :
        '=====================================================================
        Call CommonFunction.General.PlotPageHeadTag("Issues - Multi-Dimensional Reports")
    End Sub 'Plot Page Head tag

#End Region 'All Public Procedures used in code

#Region " Private Functions "
    Private Function GenerateMenu() As String
        '=====================================================================
        ' Function Name         : GenerateMenu()	
        ' Purpose               : To generate Menu for the Issue Filters page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 3, 2004
        ' Revisions             :
        '=====================================================================

        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips

        'Generate Report
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_GENERATEREPORT"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_GENERATEREPORT_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Show_OnClick()")

        'Save Report
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVEREPORT"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVEREPORT_TOOLTIP"))
        ArrClientSideFunctionsList.Add("SaveReport_OnClick()")

        'Delete
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DELETE"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DELETE_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Delete_OnClick()")

        'Close
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Close_OnClick()")

        'Help 
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Help_OnClick('IB_REPORTS')")

        'Convert arraylist to array - Menu captions
        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing

        'Generate menu string and return
        Return WebPage.Templates.StaticMenu.DrawMenu(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)

    End Function 'Menu generation

#End Region 'All Private Functions used in code

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        '' ''Added by Yogesh J on 02-Feb-2016 for security
        ''If Request.Browser.Browser <> "IE" And Request.Browser.Browser <> "InternetExplorer" Then
        ''    If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
        ''        Response.Write(vbCrLf + "<script>")
        ''        Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
        ''        If strRedirectToPage.Trim = "" Then
        ''            Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
        ''        Else
        ''            Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
        ''        End If
        ''        Response.Write(vbCrLf + "</script>")
        ''    End If
        ''    'End of addition by Yogesh J on 02-Feb-2016 for security
        ''End If
    End Sub
End Class
