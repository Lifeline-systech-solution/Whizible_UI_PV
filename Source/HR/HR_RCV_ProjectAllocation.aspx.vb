Option Strict Off
Public Class HR_RCV_ProjectAllocation
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
    Private m_sbHTML As System.Text.StringBuilder
    Private m_strEmployee As String
    Private m_strBGID As String
    Private m_strOUID As String
    Private m_strRoleID As String
    Private m_strDesignationID As String
    Private m_strSkillID As String
    Private m_strDUID As String
    Private m_strDTID As String
    Private m_strEmpType As String
    Private m_strDepartmentID As String
    Private m_strDeployable As String
    Private m_strResourcePoolID As String
    Private m_strPageNumber As String
    Private m_dtFromDate As String
    Private m_dtToDate As String
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Protected m_ProjectCount As Integer
    Private m_strFromWhere As String
    Private m_strFrom As String = 0
    Protected m_intPageNumber As Integer = 1
    Private m_intTotalNoOfRows As Integer
    Protected m_PKToken_FromRequestDetail As String







    Public Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        '=====================================================================
        ' Page Name             : HR_RCV_ProjectAllocation
        ' Purpose               : Project Allocation of My Team Resources
        ' Description           : Project Allocation of My Team Resources
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js 
        ' Author                : ShraddhaM
        ' Created               : 20,Feb 2008
        ' Revisions             : 
        '=====================================================================

        'To plot Table of Data


    End Sub
    Protected Sub PageInit()
        ''Added by Dhanashri S on 2 Aug 2016
        If (Request.QueryString("From") = "RPool") Then
            If (Request.QueryString("PkToken") = "" And HttpContext.Current.Session("intUserID").ToString <> "0") Then
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            Else
                If (Request.QueryString("PkToken") <> "" And Request.QueryString("ResourcePoolID") <> "") Then
                    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("EmployeeID"), String) + CType(Request.QueryString("BGID"), String) + CType(Request.QueryString("OUID"), String) + CType(Request.QueryString("DUID"), String) + CType(Request.QueryString("DTID"), String) + CType(Request.QueryString("DeptID"), String) + CType(Request.QueryString("RoleID"), String) + CType(Request.QueryString("DesignationID"), String) + CType(Request.QueryString("SkillID"), String) + CType(Request.QueryString("ResourcePoolID"), String) + CType(("0"), String) + CType(("0"), String), Request.QueryString("PkToken")) = False) Then

                        '''Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("UniqueID"), String))
                        'Token is Invalid now redirect to the Invalid Access Page
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")


                    End If

                End If
            End If
        End If

            If (Request.QueryString("From") = "MyCalendar") Then
                If (Request.QueryString("PkToken") = "" And HttpContext.Current.Session("intUserID").ToString <> "0") Then
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                Else
                    If (Request.QueryString("PkToken") <> "") Then
                        If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("EmployeeID"), String) + CType(Request.QueryString("BGID"), String) + CType(Request.QueryString("OUID"), String) + CType(Request.QueryString("DUID"), String) + CType(Request.QueryString("DTID"), String) + CType(Request.QueryString("DeptID"), String) + CType(Request.QueryString("RoleID"), String) + CType(Request.QueryString("DesignationID"), String) + CType(Request.QueryString("SkillID"), String) + CType(Request.QueryString("ResourcePoolID"), String) + CType(("0"), String) + CType(("0"), String), Request.QueryString("PkToken")) = False) Then

                            '''Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("UniqueID"), String))
                            'Token is Invalid now redirect to the Invalid Access Page
                            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")


                        End If

                    End If
                End If
            End If
            ''End of Addition by Dhanashri S on 2 Aug 2016

            Call InitializeVariables()
            Call GenerateMenu()
            Call DrawContextMenu()
            Call DrawPage()
            Call DrawNote()
            Call GenerateMenu()
            Response.Write(m_sbHTML.ToString())
    End Sub
    Private Sub DrawPage()
        Dim strQuery As String
        Dim dr As IDataReader
        Dim dtGridTableProjects As DataTable
        Dim dtGridTableEmployees As DataTable
        Dim oDataRow As DataRow
        Dim ds As DataSet
        Dim IteratorForProjects As Integer
        Dim IteratorForEmployees As Integer
        Dim strEmployeeName As String
        Dim strEmployeeName_old As String
        Dim strProjectName As String
        Dim strClass As String = "clsTREven"
        Dim IsRecordPresent As Boolean
        Dim strSql As String
        Dim strEmployeeID As String
        Dim browser = Request.Browser.Browser
        If Not Request.QueryString("EmployeeID") Is Nothing And Request.QueryString("EmployeeID") <> "" Then
            strEmployeeID = Request.QueryString("EmployeeID").ToString()
        Else
            strEmployeeID = "NULL"
        End If

        IsRecordPresent = False


        If m_strFromWhere.ToUpper() = "EMPLOYEE" Then
            m_strFrom = 0
        ElseIf m_strFromWhere.ToUpper() = "MYTEAM" Then
            m_strFrom = 1
        ElseIf m_strFromWhere.ToUpper() = "RPOOL" Then
            m_strFrom = 2
        ElseIf m_strFromWhere.ToUpper() = "ADVANCEDSEARCH" Then
            'Comment and modification by SuchitraP on 15-Jan-2009 for IssueID : 26527
            'Prupose : sort by Employee Name when numeric paging is applied
            'm_strFrom = 0
            m_strFrom = 3
            'End of Comment and modification by SuchitraP on 15-Jan-2009
        ElseIf m_strFromWhere.ToUpper() = "MYCALENDAR" Then
            m_strFrom = 4
        ElseIf m_strFromWhere.ToUpper() = "RESGANTTVIEW" Then
            m_strFrom = 5
        End If


        If m_strFromWhere.ToUpper() = "ADVANCEDSEARCH" Then
            strSql = "usp_sel_CNT_ResourceWise_ProjectAllocation_RCV NULL,NULL,'" & m_dtFromDate & "','" & m_dtToDate & "',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL," _
             & "NULL," + Session("intUserID").ToString + "," + m_strFrom + ",NULL,NULL"
            Call WritePaging(strSql)

            strQuery = "usp_sel_ResourceWise_ProjectAllocation_RCV " & m_strPageNumber & ",NULL,'" & m_dtFromDate & "','" & m_dtToDate & "',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL," _
            & "NULL," + Session("intUserID").ToString + "," + m_strFrom + ",NULL,NULL"
        Else
            If m_strFromWhere.ToUpper() = "RESGANTTVIEW" Then
                strQuery = "usp_sel_ResourceWise_ProjectAllocation_RCV " & m_strPageNumber & "," & m_strEmployee & ",'" & m_dtFromDate & "','" & m_dtToDate & "'," & m_strBGID & "," & m_strOUID & "," & m_strRoleID & "," & m_strDesignationID _
                                         & "," & m_strSkillID & "," & m_strDUID & "," & m_strDTID & "," & m_strEmpType & "," & m_strDepartmentID _
                                         & "," & Session("intUserID").ToString & "," + m_strFrom + "," & m_strResourcePoolID & "," & m_strDeployable & "," & strEmployeeID
            Else
                strQuery = "usp_sel_ResourceWise_ProjectAllocation_RCV " & m_strPageNumber & "," & m_strEmployee & ",'" & m_dtFromDate & "','" & m_dtToDate & "'," & m_strBGID & "," & m_strOUID & "," & m_strRoleID & "," & m_strDesignationID _
                                         & "," & m_strSkillID & "," & m_strDUID & "," & m_strDTID & "," & m_strEmpType & "," & m_strDepartmentID _
                                         & "," & Session("intUserID").ToString & "," + m_strFrom + "," & m_strResourcePoolID & "," & m_strDeployable
            End If

        End If

        dtGridTableProjects = New DataTable("Projects")

        dtGridTableProjects.Columns.Add(New System.Data.DataColumn("ProjectID", System.Type.GetType("System.Int32")))
        dtGridTableProjects.Columns.Add(New System.Data.DataColumn("ProjectName", System.Type.GetType("System.String")))

        dtGridTableProjects.NewRow()

        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            IsRecordPresent = True
            oDataRow = dtGridTableProjects.NewRow()
            oDataRow.Item(0) = dr("ProjectID")
            oDataRow.Item(1) = dr("ProjectName")
            dtGridTableProjects.Rows.Add(oDataRow)
        End While

        dtGridTableEmployees = New DataTable("Employees")

        dtGridTableEmployees.Columns.Add(New System.Data.DataColumn("EmployeeID", System.Type.GetType("System.Int32")))
        dtGridTableEmployees.Columns.Add(New System.Data.DataColumn("EmployeeName", System.Type.GetType("System.String")))
        dtGridTableEmployees.Columns.Add(New System.Data.DataColumn("ProjectID", System.Type.GetType("System.Int32")))
        dtGridTableEmployees.Columns.Add(New System.Data.DataColumn("ProjectName", System.Type.GetType("System.String")))

        dtGridTableEmployees.NewRow()


        If dr.NextResult() Then
            While dr.Read
                IsRecordPresent = True
                oDataRow = dtGridTableEmployees.NewRow()
                oDataRow.Item(0) = dr("EmployeeID")
                oDataRow.Item(1) = dr("EmployeeName")
                oDataRow.Item(2) = dr("ProjectID")
                oDataRow.Item(3) = dr("ProjectName")
                dtGridTableEmployees.Rows.Add(oDataRow)
            End While
        End If


        CommonFunction.Data.DisposeDataReader(dr)

        m_sbHTML.Append("<BR>")

        m_sbHTML.Append("<DIV Id=DivMain Style='HEIGHT:400px;OVERFLOW:auto; WIDTH:100%'>" + vbCrLf)
        m_sbHTML.Append("<STYLE type=text/css> {TABLE  {TABLE-LAYOUT: fixed;}" + vbCrLf)
        m_sbHTML.Append("THEAD TH.DivSub1Tag {POSITION: relative;}" + vbCrLf)
        m_sbHTML.Append("THEAD TH.DivSub1Tag.locked {Z-INDEX: 30} " + vbCrLf)
        m_sbHTML.Append("THEAD TH.DivSub1Tag {Z-INDEX: 10; ; TOP:expression(document.getElementById('DivMain').scrollTop -1)} " + vbCrLf)
        m_sbHTML.Append(" TH.DivSub1Tag.locked {Z-INDEX: 10; ; LEFT:expression(document.getElementById('DivMain').scrollLeft); POSITION:relative()} }" + vbCrLf)
        m_sbHTML.Append("</STYLE>" + vbCrLf)
        m_sbHTML.Append(" <STYLE type=text/css>" + vbCrLf)
        m_sbHTML.Append("Td.Locked, th.Locked {" + vbCrLf)
        m_sbHTML.Append(" left: expression(document.getElementById('DivMain').scrollLeft);" + vbCrLf)
        m_sbHTML.Append("position: relative;" + vbCrLf)
        m_sbHTML.Append(" z-index: 5;" + vbCrLf)
        m_sbHTML.Append(" }" + vbCrLf)
        m_sbHTML.Append("</STYLE>" + vbCrLf)
        m_sbHTML.Append("<STYLE type=text/css>{" + vbCrLf)
        m_sbHTML.Append("TABLE {TABLE-LAYOUT: fixed;}" + vbCrLf)
        m_sbHTML.Append(" THEAD TH.DivList_Column {POSITION: relative;}" + vbCrLf)
        m_sbHTML.Append(" THEAD TH.DivList_Column.locked {POSITION: relative;}" + vbCrLf)
        m_sbHTML.Append(" THEAD TH.DivList_Column.locked {Z-INDEX: 30}" + vbCrLf)
        m_sbHTML.Append(" THEAD TH.DivList_Column {Z-INDEX: 20;; TOP: expression(document.getElementById('DivMain').scrollTop -1)}" + vbCrLf)
        m_sbHTML.Append(" TH.DivList_Column {Z-INDEX: 10;; LEFT: expression(document.getElementById('DivMain').scrollLeft); POSITION:relative()}" + vbCrLf)
        m_sbHTML.Append(" }</STYLE>" + vbCrLf)

        If browser = "Firefox" Then
            m_sbHTML.Append("<TABLE id='tblHeader' cellspacing=1 cellpadding=0 Width='99.99%' style='table-layout: fixed' class=clsGridTable >" + vbCrLf) ''Added By Vaijat K ON 04/12/2015
        Else
            m_sbHTML.Append("<TABLE id='tblHeader' cellspacing=1 cellpadding=0 Width='99.99%' class=clsGridTable >" + vbCrLf)
        End If

        m_sbHTML.Append("<THead class='clsTRColumnHeader' >" + vbCrLf)

        ''m_sbHTML.Append("<TH align=left class=DivList_Column height=5px >Resource Name </TH>" + vbCrLf)
        m_sbHTML.Append("<TH align='left' class='DivList_Column' height='5px' width='100px' >Resource Name </TH>" + vbCrLf)
        'm_sbHTML.Append("<TH align=left  height=5px >Resource Name </TH>" + vbCrLf)
        'To Plot project name columns
        IteratorForProjects = 0
        While IteratorForProjects < dtGridTableProjects.Rows.Count
            strProjectName = dtGridTableProjects.Rows(IteratorForProjects).Item("ProjectName").ToString
            'm_sbHTML.Append("<TH align=left valign=top class=DivSub1Tag height=5px width=5px style='writing-mode:tb-rl;font-size=11px' Title='" + strProjectName + "' >" + strProjectName + "</TH>" + vbCrLf)      'Commented BY Puneet M ON 18-11-2015
            'Added By Bharat T on 27th-Nov-2015
            ''Commented And Added By Vaijat K ON 14/11/2016 For Issue ID - 5452
            'If browser = "Firefox" Then
            '    'm_sbHTML.Append("<TH align=left  class=DivSub1Tag height=100px width=70px style='padding:6px; word-wrap:break-word;writing-mode:vertical-rl;font-size:11px' Title='" + strProjectName + "' >" + strProjectName + "</TH>" + vbCrLf)       'Added By Puneet M ON 18-11-2015
            '    m_sbHTML.Append("<TH align=left  class=DivSub1Tag width=70px style='word-wrap:break-word;transform:rotate(90deg);height:100px;' Title='" + strProjectName + "' >" + strProjectName + "</TH>" + vbCrLf)       'Added By Vaijat K ON 01/12/2015
            'ElseIf browser = "Chrome" Then
            '    m_sbHTML.Append("<TH align=left  class=DivSub1Tag  style='width:70px; height:100px; transform:rotate(90deg);font-size:11px' Title='" + strProjectName + "' >" + strProjectName + "</TH>" + vbCrLf)       'Added By Puneet M ON 18-11-2015
            'Else
            '    m_sbHTML.Append("<TH align=left  class=DivSub1Tag  width=70px style='word-wrap:break-word;writing-mode:tb-rl;font-size:11px;height:100px' Title='" + strProjectName + "' >" + strProjectName + "</TH>" + vbCrLf)       'Added By Puneet M ON 18-11-2015
            'End If


            'If browser = "Firefox" Then
            '    'm_sbHTML.Append("<TH align=left  class=DivSub1Tag height=100px width=70px style='padding:6px; word-wrap:break-word;writing-mode:vertical-rl;font-size:11px' Title='" + strProjectName + "' >" + strProjectName + "</TH>" + vbCrLf)       'Added By Puneet M ON 18-11-2015
            '    m_sbHTML.Append("<TH align=left  class=DivSub1Tag  style='word-wrap:break-word;height:100px;' Title='" + strProjectName + "' ><label style='width:85px;transform:rotate(90deg);'>" + strProjectName + "</label></TH>" + vbCrLf)       'Added By Vaijat K ON 01/12/2015
            'ElseIf browser = "Chrome" Then
            '    m_sbHTML.Append("<TH align=left  class=DivSub1Tag  style=' height:100px; font-size:11px' Title='" + strProjectName + "' ><label style='width:85px;transform:rotate(90deg);'>" + strProjectName + "</label></TH>" + vbCrLf)       'Added By Puneet M ON 18-11-2015
            'Else
            '    m_sbHTML.Append("<TH align=left  class=DivSub1Tag  style='word-wrap:break-word;font-size:11px;height:100px' Title='" + strProjectName + "' ><label style='width:85px;transform:rotate(90deg);'>" + strProjectName + "</label></TH>" + vbCrLf)       'Added By Puneet M ON 18-11-2015
            'End If
            If browser = "Firefox" Then
                'm_sbHTML.Append("<TH align=left  class=DivSub1Tag height=100px width=70px style='padding:6px; word-wrap:break-word;writing-mode:vertical-rl;font-size:11px' Title='" + strProjectName + "' >" + strProjectName + "</TH>" + vbCrLf)       'Added By Puneet M ON 18-11-2015
                'Added And Commented By By Sanyogeeta R on 8-12-2016 For Design Issue
                'm_sbHTML.Append("<TH align=left  class=DivSub1Tag  style='word-wrap:break-word; height:100px;' Title='" + strProjectName + "' ><label style='word-wrap:break-word; width:85px;transform:rotate(90deg);'>" + strProjectName + "</label></TH>" + vbCrLf)       'Added By Vaijat K ON 01/12/2015
                m_sbHTML.Append("<TH align=left  class=DivSub1Tag  style='word-wrap:break-word; height:100px; width: 64px;' Title='" + strProjectName + "' ><label style='word-wrap:break-word; width:85px;font-stretch: semi-condensed;transform:rotate(90deg);'>" + strProjectName + "</label></TH>" + vbCrLf)       'Added By Vaijat K ON 01/12/2015

            ElseIf browser = "Chrome" Then
                m_sbHTML.Append("<TH align=left  class=DivSub1Tag  style='word-wrap:break-word; height:100px; font-size:11px' Title='" + strProjectName + "' ><label style='word-wrap:break-word; width:85px;transform:rotate(90deg);'>" + strProjectName + "</label></TH>" + vbCrLf)       'Added By Puneet M ON 18-11-2015
            Else
                m_sbHTML.Append("<TH align=left  class=DivSub1Tag  style='word-wrap:break-word;font-size:11px;height:100px' Title='" + strProjectName + "' ><label style='word-wrap:break-word; width:85px;transform:rotate(90deg);'>" + strProjectName + "</label></TH>" + vbCrLf)       'Added By Puneet M ON 18-11-2015
                'End Of Addition And Comment By Sanyogeeta R on 8-12-2016 For Design Issue
            End If
            ''End of addition by vaijat K

            'End of Added By Bharat T on 27th-Nov-2015
            'm_sbHTML.Append("<TH align=left  class=DivSub1Tag style='width:70px; height:70px; mword-wrap:break-word;transform:rotate(90deg);font-size:11px' Title='" + strProjectName + "' >" + strProjectName + "</TH>" + vbCrLf)       'Added By Puneet M ON 18-11-2015
            'm_sbHTML.Append("<TH align=left valign=top height=5px width=5px style='writing-mode:tb-rl;font-size=11px' Title='" + strProjectName + "' >" + strProjectName + "</TH>" + vbCrLf)
            IteratorForProjects += 1

        End While
        m_ProjectCount = IteratorForProjects
        'm_sbHTML.Append("</TR>" + vbCrLf)

        m_sbHTML.Append("</THead>" + vbCrLf)

        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        IteratorForProjects = 0
        IteratorForEmployees = 0
        strEmployeeName_old = ""
        Dim intProjectID_Project As Integer
        Dim intProjectID1_Employee As Integer
        Dim strEmployeeIdForContextMenu As String

        While IteratorForEmployees < dtGridTableEmployees.Rows.Count
            'dtGridTableEmployees.Rows(IteratorForEmployees).Item("EmployeeName").ToString
            strEmployeeName = dtGridTableEmployees.Rows(IteratorForEmployees).Item("EmployeeName").ToString
            strEmployeeIdForContextMenu = dtGridTableEmployees.Rows(IteratorForEmployees).Item("EmployeeID").ToString

            If strEmployeeName <> strEmployeeName_old And strEmployeeName_old <> "" Then
                While IteratorForProjects < dtGridTableProjects.Rows.Count
                    m_sbHTML.Append("<td align='center' height=5px > </td>" + vbCrLf)
                    IteratorForProjects += 1
                End While
                m_sbHTML.Append("</TR>" + vbCrLf)
                'To change TR Class
                If strClass = "clsTROdd" Then
                    strClass = "clsTREven"
                Else
                    strClass = "clsTROdd"
                End If

                IteratorForProjects = 0
                strEmployeeName_old = ""
            End If

            If strEmployeeName <> strEmployeeName_old Then
                m_sbHTML.Append("<TR class='" + strClass + "'>" + vbCrLf)
                m_sbHTML.Append("<td align='left' height=5px onMouseOver=this.style.cursor='hand'  onclick='ShowContextMenu(event,this ," + strEmployeeIdForContextMenu + ",""" + m_dtFromDate + """ , """ + m_dtToDate + """ )' > <U>" + strEmployeeName + "</U> </td>" + vbCrLf)

            End If

            While IteratorForProjects < dtGridTableProjects.Rows.Count
                intProjectID_Project = CommonFunction.Data.CheckIsDBNull(dtGridTableProjects.Rows(IteratorForProjects).Item("ProjectID"), "0")
                intProjectID1_Employee = CommonFunction.Data.CheckIsDBNull(dtGridTableEmployees.Rows(IteratorForEmployees).Item("ProjectID"), "0")

                If intProjectID1_Employee = intProjectID_Project Then
                    m_sbHTML.Append("<td align='center'  height=5px style='width:auto' > <Img Border=0 src='../../Images/Calender Images/select.jpg'> </td>" + vbCrLf)
                    'IteratorForEmployees += 1
                    IteratorForProjects += 1
                    Exit While
                Else
                    m_sbHTML.Append("<td align='center' height=5px style='width:70px'> </td>" + vbCrLf)
                End If

                If intProjectID1_Employee = "0" Then
                    IteratorForProjects += 1
                    Exit While
                End If

                IteratorForProjects += 1
            End While
            strEmployeeName_old = strEmployeeName

            'If IteratorForProjects = dtGridTableProjects.Rows.Count Then
            '    Exit While
            'End If
            If IteratorForEmployees = dtGridTableEmployees.Rows.Count - 1 Then
                While IteratorForProjects < dtGridTableProjects.Rows.Count
                    m_sbHTML.Append("<td align='center' height=5px > </td>" + vbCrLf)
                    IteratorForProjects += 1
                End While
                m_sbHTML.Append("</TR>" + vbCrLf)
            End If

            IteratorForEmployees += 1


        End While


        m_sbHTML.Append("</TABLE>" + vbCrLf)

        'If record is not present
        If IsRecordPresent = False Then
            m_sbHTML.Append("<Table width=99.9%><TR class='clsTREvenRow'><TD align=Center colspan=9>There are no items to show in this view.</TD></TR></Table>")
        End If

        m_sbHTML.Append("</DIV>" + vbCrLf)
        'm_sbHTML.append("</DIV>")
        m_sbHTML.Append("<BR>" + vbCrLf)


    End Sub
    Private Sub InitializeVariables()
        '=====================================================================
        ' Page Name             : InitializeVariables
        ' Purpose               : To Initializa variables comes from query string 
        ' Description           : To Initializa variables comes from query string 
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js 
        ' Author                : ShraddhaM
        ' Created               : 20,Feb 2008
        ' Revisions             : 
        '=====================================================================
        'Added By Shamkant S on 28 Jan 2016
        m_PKToken_FromRequestDetail = CommonFunctions.Security.Token.GetToken(CType(Session("intUserID"), String) + "0" + "0")
        'Ended By Shamkant S on 28 Jan 2016

        m_sbHTML = New System.Text.StringBuilder
        
        m_strPageNumber = Request.QueryString("PageNumber")

        If m_strPageNumber Is Nothing OrElse m_strPageNumber = "" Then
            m_strPageNumber = Request.Form("hidPageNumber")
        End If
        If m_strPageNumber Is Nothing OrElse m_strPageNumber = "" Then
            m_strPageNumber = "1"
        End If

        m_dtFromDate = Request.QueryString("FromDate")

        If m_dtFromDate Is Nothing OrElse m_dtFromDate = "" Then
            m_dtFromDate = Request.Form("hidFromDate")
        End If
        If m_dtFromDate Is Nothing OrElse m_dtFromDate = "" Then
            m_dtFromDate = "NULL"
        End If

        m_dtToDate = Request.QueryString("ToDate")

        If m_dtToDate Is Nothing OrElse m_dtToDate = "" Then
            m_dtToDate = Request.Form("hidToDate")
        End If
        If m_dtToDate Is Nothing OrElse m_dtToDate = "" Then
            m_dtToDate = "NULL"
        End If

        m_strEmployee = Request.QueryString("EmployeeName")

        If m_strEmployee Is Nothing OrElse m_strEmployee = "" Then
            m_strEmployee = Request.Form("hidEmployeeName")
        End If
        If m_strEmployee Is Nothing OrElse m_strEmployee = "" Then
            m_strEmployee = "NULL"
        Else
            m_strEmployee = "'" + m_strEmployee + "'"
        End If

        m_strBGID = Request.QueryString("BGID")

        If m_strBGID Is Nothing OrElse m_strBGID = "" Then
            m_strBGID = Request.Form("hidBGID")
        End If
        If m_strBGID Is Nothing OrElse m_strBGID = "" Then
            m_strBGID = "NULL"
        End If

        m_strOUID = Request.QueryString("OUID")

        If m_strOUID Is Nothing OrElse m_strOUID = "" Then
            m_strOUID = Request.Form("hidOUID")
        End If
        If m_strOUID Is Nothing OrElse m_strOUID = "" Then
            m_strOUID = "NULL"
        End If

        m_strDUID = Request.QueryString("DUID")

        If m_strDUID Is Nothing OrElse m_strDUID = "" Then
            m_strDUID = Request.Form("hidDUID")
        End If
        If m_strDUID Is Nothing OrElse m_strDUID = "" Then
            m_strDUID = "NULL"
        End If

        m_strDTID = Request.QueryString("DTID")

        If m_strDTID Is Nothing OrElse m_strDTID = "" Then
            m_strDTID = Request.Form("hidDTID")
        End If
        If m_strDTID Is Nothing OrElse m_strDTID = "" Then
            m_strDTID = "NULL"
        End If

        m_strRoleID = Request.QueryString("RoleID")

        If m_strRoleID Is Nothing OrElse m_strRoleID = "" Then
            m_strRoleID = Request.Form("hidRoleID")
        End If
        If m_strRoleID Is Nothing OrElse m_strRoleID = "" Then
            m_strRoleID = "NULL"
        End If

        m_strDesignationID = Request.QueryString("DesignationID")

        If m_strDesignationID Is Nothing OrElse m_strDesignationID = "" Then
            m_strDesignationID = Request.Form("hidDesignationID")
        End If
        If m_strDesignationID Is Nothing OrElse m_strDesignationID = "" Then
            m_strDesignationID = "NULL"
        End If

        m_strSkillID = Request.QueryString("SkillID")

        If m_strSkillID Is Nothing OrElse m_strSkillID = "" Then
            m_strSkillID = Request.Form("hidSkillID")
        End If
        If m_strSkillID Is Nothing OrElse m_strSkillID = "" Then
            m_strSkillID = "NULL"
        End If

        m_strEmpType = Request.QueryString("EmpType")

        If m_strEmpType Is Nothing OrElse m_strEmpType = "" Then
            m_strEmpType = Request.Form("hidEmpType")
        End If
        If m_strEmpType Is Nothing OrElse m_strEmpType = "" Then
            m_strEmpType = "NULL"
        Else
            m_strEmpType = "'" + m_strEmpType + "'"
        End If

        m_strDepartmentID = Request.QueryString("DeptID")

        If m_strDepartmentID Is Nothing OrElse m_strDepartmentID = "" Then
            m_strDepartmentID = Request.Form("hidDepartmentID")
        End If
        If m_strDepartmentID Is Nothing OrElse m_strDepartmentID = "" Then
            m_strDepartmentID = "NULL"
        End If

        m_strDeployable = Request.QueryString("Deployable")

        If m_strDeployable Is Nothing OrElse m_strDeployable = "" Then
            m_strDeployable = Request.Form("hidDeployable")
        End If
        If m_strDeployable Is Nothing OrElse m_strDeployable = "" Then
            m_strDeployable = "NULL"
        Else
            m_strDeployable = "'" + m_strDeployable + "'"
        End If

        m_strResourcePoolID = Request.QueryString("ResourcePoolID")

        If m_strResourcePoolID Is Nothing OrElse m_strResourcePoolID = "" Then
            m_strResourcePoolID = Request.Form("hidResourcePoolID")
        End If
        If m_strResourcePoolID Is Nothing OrElse m_strResourcePoolID = "" Then
            m_strResourcePoolID = "NULL"
        End If

        m_strFromWhere = Request.QueryString("From")
        If m_strFromWhere Is Nothing OrElse m_strFromWhere = "" Then
            m_strFromWhere = Request.Form("hidFromWhere")
        End If

        m_sbHTML.Append("<input type=hidden name='hidEmployeeName' id='hidEmployeeName' value='" + m_strEmployee + "'>")
        m_sbHTML.Append("<input type=hidden name='hidBGID' id='hidBGID' value=" + m_strBGID + ">")
        m_sbHTML.Append("<input type=hidden name='hidOUID' id='hidOUID' value=" + m_strOUID + ">")
        m_sbHTML.Append("<input type=hidden name='hidDUID' id='hidDUID' value=" + m_strDUID + ">")
        m_sbHTML.Append("<input type=hidden name='hidDTID' id='hidDTID' value=" + m_strDTID + ">")
        m_sbHTML.Append("<input type=hidden name='hidRoleID' id='hidRoleID' value=" + m_strRoleID + ">")
        m_sbHTML.Append("<input type=hidden name='hidDesignationID' id='hidDesignationID' value=" + m_strDesignationID + ">")
        m_sbHTML.Append("<input type=hidden name='hidSkillID' id='hidSkillID' value=" + m_strSkillID + ">")
        m_sbHTML.Append("<input type=hidden name='hidDepartmentID' id='hidDepartmentID' value=" + m_strDepartmentID + ">")
        m_sbHTML.Append("<input type=hidden name='hidEmpType' id='hidEmpType' value='" + m_strEmpType + "'>")
        m_sbHTML.Append("<input type=hidden name='hidDeployable' id='hidDeployable' value='" + m_strDeployable + "'>")
        m_sbHTML.Append("<input type=hidden name='hidResourcePoolID' id='hidResourcePoolID' value=" + m_strResourcePoolID + ">")

        m_sbHTML.Append("<input type=hidden name='hidFromDate' id='hidFromDate' value='" + m_dtFromDate + "'>")
        m_sbHTML.Append("<input type=hidden name='hidToDate' id='hidToDate' value='" + m_dtToDate + "'>")
        m_sbHTML.Append("<input type=hidden name='hidPageNumber' id='hidPageNumber' value=" + m_strPageNumber + ">")
        m_sbHTML.Append("<input type=hidden name='hidFromWhere' id='hidFromWhere' value=" + m_strFromWhere + ">")


    End Sub
    ' Added By Shamkant S on 11 Feb 2016
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateToken__OnClick(ResourceID As String, DateRangeID As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        ResourceID = Utilities.Security.SecurityBuilder.CheckUserInput(ResourceID, 2, True, False, False)
        DateRangeID = Utilities.Security.SecurityBuilder.CheckUserInput(DateRangeID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try

            Dim m_PKToken_Request_Filter As String
            m_PKToken_Request_Filter = CommonFunctions.Security.Token.GetToken(CType(ResourceID, String) + CType(DateRangeID, String) + "0" + "0")

            Return m_PKToken_Request_Filter
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    'Ended By Shamkant S on 11 Feb 2016
    ' Added By Shamkant S on 11 Feb 2016
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateTask__OnClick(EmployeeID As String, FromDate As String, ToDate As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        EmployeeID = Utilities.Security.SecurityBuilder.CheckUserInput(EmployeeID, 2, True, False, False)
        FromDate = Utilities.Security.SecurityBuilder.CheckUserInput(FromDate, 2, True, False, False)
        ToDate = Utilities.Security.SecurityBuilder.CheckUserInput(ToDate, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try

            Dim m_PKToken_Request_Task As String
            m_PKToken_Request_Task = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(FromDate, String) + CType(ToDate, String) + "0" + "0")

            Return m_PKToken_Request_Task
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    'Ended By Shamkant S on 11 Feb 2016
    Private Sub GenerateMenu()
        '====================================================================
        ' Procedure Name        :  GenerateMenu
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To getnerate Menu
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  ShraddhaM
        ' Created               :  21,Feb 2008
        '=====================================================================
        Dim arrMenu As System.Collections.ArrayList = New System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList = New System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList = New System.Collections.ArrayList

        arrMenu.Add("<Img Border=0 src='../../Images/cssImages/Link images/close.gif'>&nbsp;Close")
        arrMenuToolTip.Add("Close")
        arrClientSideFunctions.Add("Close_Click()")

        arrMenu.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>&nbsp;Help")
        arrMenuToolTip.Add("Help")
        arrClientSideFunctions.Add("Help_OnClick('RCV_PRJ_ALLOCATION')")

        m_objMenu = New WebPages.Template.StaticMenu
        Dim strmenu As String = m_objMenu.DrawMenuWithEvents(GetArray(arrMenu), GetArray(arrClientSideFunctions), GetArray(arrMenuToolTip), True)
        m_sbHTML.Append(strmenu)

        m_objMenu = Nothing

    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()

        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    Private Sub DrawContextMenu()
        m_sbHTML.Append("<Div id='divContextMenu' class='DropdownMenu'>" + vbCrLf)
        m_sbHTML.Append("<Table cellspacing='0' cellpadding='3' >" + vbCrLf)
        m_sbHTML.Append("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>" + vbCrLf)
        m_sbHTML.Append("<td class='CtMn_LeftFill' ></td>" + vbCrLf)
        m_sbHTML.Append("<td id='tdShowTasks' title='Show Tasks' >&nbsp;&nbsp;&nbsp;Show All Tasks" + vbCrLf)
        m_sbHTML.Append("</td></tr>" + vbCrLf)
        m_sbHTML.Append("<TR><td class='CtMn_LeftFill' ></td>" + vbCrLf)
        m_sbHTML.Append("<td class='CtMn_Hr'></td></tr>" + vbCrLf)

        m_sbHTML.Append("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>" + vbCrLf)
        m_sbHTML.Append("<td class='CtMn_LeftFill' ></td>" + vbCrLf)
        m_sbHTML.Append("<td id='tdResourceUtilization' title='Resource Utilization' >&nbsp;&nbsp;&nbsp;Resource Utilization" + vbCrLf)
        m_sbHTML.Append("</td></tr>" + vbCrLf)
        m_sbHTML.Append("<TR><td class='CtMn_LeftFill' ></td>" + vbCrLf)
        m_sbHTML.Append("<td class='CtMn_Hr'></td></tr>" + vbCrLf)

        m_sbHTML.Append("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>" + vbCrLf)
        m_sbHTML.Append("<td class='CtMn_LeftFill' ></td>" + vbCrLf)
        m_sbHTML.Append("<td id='tdProjectAllocation' title='Project Allocation' >&nbsp;&nbsp;&nbsp;Project Allocation" + vbCrLf)
        m_sbHTML.Append("</td></tr>" + vbCrLf)
        m_sbHTML.Append("<TR><td class='CtMn_LeftFill' ></td>" + vbCrLf)
        m_sbHTML.Append("<td class='CtMn_Hr'></td></tr>" + vbCrLf)

        m_sbHTML.Append("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>" + vbCrLf)
        m_sbHTML.Append("<td class='CtMn_LeftFill' ></td>" + vbCrLf)
        m_sbHTML.Append("<td id='tdSkillView' title='Gantt View' >&nbsp;&nbsp;&nbsp;Skill Details" + vbCrLf)
        m_sbHTML.Append("</td></tr>" + vbCrLf)
        m_sbHTML.Append("<TR><td class='CtMn_LeftFill' ></td>" + vbCrLf)
        m_sbHTML.Append("<td class='CtMn_Hr'></td></tr>" + vbCrLf)

        m_sbHTML.Append("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>" + vbCrLf)
        m_sbHTML.Append("<td class='CtMn_LeftFill' ></td>" + vbCrLf)
        m_sbHTML.Append("<td id='tdLeavDetails' title='Leave Details' >&nbsp;&nbsp;&nbsp;Leave Details" + vbCrLf)
        m_sbHTML.Append("</td></tr>" + vbCrLf)
        m_sbHTML.Append("</table></Div>" + vbCrLf)

    End Sub
    Private Sub DrawNote()
        m_sbHTML.Append("<Table width=99.9%><TR class='clsTREvenRow'><TD align=Left><B>Note :   </B> Closed,OnHold and Global Projects are not considered.</TD></TR></Table>")
    End Sub

    Private Sub WritePaging(ByVal PagingSQL As String)

        Dim intRecordCount As Integer
        Dim strPaging As String = ""

        m_intTotalNoOfRows = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(PagingSQL, MyBase.UseSQL), ""), ""), Integer)

        If Math.Ceiling(m_intTotalNoOfRows / 20) < m_strPageNumber Then
            m_strPageNumber = 1
        End If

        strPaging = "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"

        If m_strPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
            'Commented and added by Shamkant s for HTML encoding Date:06/10/15
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            'ended by Shamkant s  for HTML encoding Date:06/10/15
        Else
            'Commented and added by Shamkant s for HTML encoding Date:06/10/15
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_strPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            'ended by Shamkant s  for HTML encoding Date:06/10/15
        End If

        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString + ">"

        strPaging += " of " + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString
        strPaging += "|<A href='javascript:Page_OnClick(""-1"")' TITLE='Show All Records'><B>All<B></A>"
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15
        m_sbHTML.Append("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'>")

        If Trim(strPaging & "") <> "" Then
            'Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")
            m_sbHTML.Append("<td align=right>" + strPaging + "</TD>")
        End If

        m_sbHTML.Append("</TR></TABLE>")

    End Sub

End Class
