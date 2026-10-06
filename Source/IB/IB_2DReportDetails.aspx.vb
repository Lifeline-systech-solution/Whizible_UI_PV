Public Class IB_2DReportDetails
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region " Form Level variables declaration "

    Private m_LoginId As Long 'Login Id
    Private m_LoginType As String 'Login Type
    Private m_RoleId As Long 'RoleId
    Private m_RoleLevel As Integer 'Role Level
    Private m_ProjectId As Long 'ProjectId
    Private m_UserId As Long 'UserId
    Private m_UserName As String 'UserName
    Private m_CultureId As Long 'CultureId

    Private xAxisFieldName As String = ""
    Private yAxisFieldName As String = ""
    Private BasedOnFieldName As String = ""
    Private xAxisFieldValue As String = ""
    Private yAxisFieldValue As String = ""
    Private BasedOnFieldValue As String = ""
    Private xAxisType As String = ""
    Private yAxisType As String = ""
    Private BasedOnType As String = ""
    Private xAxisFromDate As String = ""
    Private xAxisToDate As String = ""
    Private yAxisFromDate As String = ""
    Private yAxisToDate As String = ""
    Private BasedOnFromDate As String = ""
    Private BasedOnToDate As String = ""
    Private intViewID As Integer
    Private strWhereClause As String = ""
    Private strLevel As String = ""

    Private strSQLQuery As String = ""
    Private strFieldList As String = ""
    Private strSortBy As String = ""
    Private strSQL As String = ""

    Private intProjectID As Integer
    Private intProjectGroupID As Integer

    Private rsEmployee As IDataReader
    Private rsView As IDataReader
    Private rsProjectGroup As IDataReader

    Private WithEvents objIssueGrid As New WebPage.Templates.GenericGrid

#End Region

    Public Sub PageInit()
        '######### Page Code starts here
        Call SetVariables()
        Call ShowReportDetails()
    End Sub

    Public Sub New()
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.IB_2DReportDetails", "AppResources")
    End Sub ' Constructor of page

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
        ' Created               : Mar 10, 2004
        ' Revisions             :
        '=====================================================================

        'Global object
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        m_LoginId = objGlobal.LoginID
        m_LoginType = objGlobal.LoginType
        m_RoleId = objGlobal.RoleID
        m_RoleLevel = objGlobal.RoleLevel
        'm_ProjectId = objGlobal.ProjectID
        m_ProjectId = CType(Session("IssueProject"), Long)
        'Code added by SandipL on 17 Feb 2006 --IssueID 2145-- Whizsem_whiz2 sp6
        Dim intCorporateRoleLevel As Integer
        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = (select PostId from tbl_PM_Employee where EmployeeID=" & CType(Session("intUserID"), String) & ")", MyBase.UseSQL), Integer)
        intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_RoleID " & CType(Session("intUserID"), String) & "", MyBase.UseSQL), Integer)
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        If intCorporateRoleLevel <> 1 And intCorporateRoleLevel <> 2 And m_ProjectId <> 0 Then
            'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            'm_RoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ISnull(Role,0) from tbl_PM_ProjectEmployeeRole where ProjectID=" & CType(m_ProjectId, String) & " And EmployeeID=" & CType(m_UserId, String), MyBase.UseSQL), "0"), Long)
            m_RoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectEmployeeRole_Role " & CType(m_ProjectId, String) & "," & CType(m_UserId, String), MyBase.UseSQL), "0"), Long)
            'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            If Not m_RoleId > 0 Then
                m_RoleId = CType(Session("intPostID"), Long)
            End If
            If m_RoleId > 0 Then
                objGlobal.RoleID = m_RoleId
            End If
            'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            'm_RoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = " & CType(m_RoleId, String), MyBase.UseSQL)), Integer)
            m_RoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_Level " & CType(m_RoleId, String), MyBase.UseSQL)), Integer)
            'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            If m_RoleLevel <> 0 Then
                objGlobal.RoleLevel = m_RoleLevel
            End If
        End If
        'End addition by SandipL on 17 Feb 2006
        m_UserId = objGlobal.UserID
        m_UserName = objGlobal.UserName
        m_CultureId = objGlobal.LCID
    End Sub

    Private Sub ShowReportDetails()
        '=====================================================================
        ' Procedure Name        : ShoReportDetails()	
        ' Purpose               : To generate the query for Issues to be displayed
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 11, 2004
        ' Revisions             :
        '=====================================================================

        If intProjectGroupID = 0 Then
            Dim strProjectName As String
            'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            'strProjectName = CType(CommonFunctions.Data.GetDataScalar("Select Isnull(ProjectName,'') From tbl_PM_Project where Projectid = " + CType(Session("IssueProject"), String), True), String)
            strProjectName = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ProjectName_ID " + CType(Session("IssueProject"), String), True), String)
            'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            Response.Write("<TABLE class=clsTable cellspacing=0><TR class='clsTROdd'><TD>" + MyBase.GetResourceString("REPORTFORPROJECT") + "</tD><TD >" + strProjectName + "</TD></TR>")
        Else
            'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            'rsProjectGroup = CommonFunction.Data.GetDataReader("Select ProjectGroupName FROM tbl_PM_ProjectGroup WHERE ProjectGroupID=" + intProjectGroupID.ToString, MyBase.UseSQL)
            rsProjectGroup = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_ProjectGroup_ProjectGroupName " + intProjectGroupID.ToString, MyBase.UseSQL)
            'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            If rsProjectGroup.Read Then
                Response.Write("<TABLE class=clsTable cellspacing=0><TR class='clsTROdd'><TD>" + MyBase.GetResourceString("REPORTFORGROUP") + "</tD><TD >" + rsProjectGroup(0).ToString + "</TD></TR>")
            End If
            CommonFunction.Data.DisposeDataReader(rsProjectGroup)
        End If

        Response.Write("<TR class='clsTROdd'><TD >" + MyBase.GetResourceString("BY") + "</TD><TD >" + Session("strUserName").ToString + "</TD></TR>")
        Response.Write("<TR class='clsTROdd'><TD >" + MyBase.GetResourceString("ON") + "</tD><TD >" + CommonFunction.Dates.CGetDateTime(Now()) + "</TD></TR></TABLE><BR><BR>")

        strWhereClause = "WHERE 1=1 "

        'check for XAxis
        If UCase(xAxisFieldName) = "ASSIGNTO" Or UCase(xAxisFieldName) = "CODEDBY" Then
            'in issue base we are storing the id's but while reporting we are using the user names
            'to get the id's from employee table
            rsEmployee = CommonFunction.Data.GetDataReader("EXEC usp_sel_IB_tbl_PM_Employee '" + xAxisFieldValue + "'", MyBase.UseSQL)
            If rsEmployee.Read Then
                xAxisFieldValue = rsEmployee(0).ToString + ""
            Else
                xAxisFieldValue = ""
            End If
            CommonFunction.Data.DisposeDataReader(rsEmployee)
        End If

        'check for y Axis
        If UCase(yAxisFieldName) = "ASSIGNTO" Or UCase(yAxisFieldName) = "CODEDBY" Then
            'in issue base we are storing the id's but while reporting we are using the user names
            'to get the id's from employee table
            rsEmployee = CommonFunction.Data.GetDataReader("EXEC usp_sel_IB_tbl_PM_Employee '" + yAxisFieldValue + "'", MyBase.UseSQL)
            If rsEmployee.Read Then
                yAxisFieldValue = rsEmployee(0).ToString + ""
            Else
                yAxisFieldValue = ""
            End If
            CommonFunction.Data.DisposeDataReader(rsEmployee)
        End If

        'check for Based on 
        If UCase(BasedOnFieldName) = "ASSIGNTO" Or UCase(BasedOnFieldName) = "CODEDBY" Then
            'in issue base we are storing the id's but while reporting we are using the user names
            'to get the id's from employee table
            rsEmployee = CommonFunction.Data.GetDataReader("EXEC usp_sel_IB_tbl_PM_Employee '" + BasedOnFieldValue + "'", MyBase.UseSQL)
            If rsEmployee.Read Then
                BasedOnFieldValue = rsEmployee(0).ToString + ""
            Else
                BasedOnFieldValue = ""
            End If
            CommonFunction.Data.DisposeDataReader(rsEmployee)
        End If

        If xAxisType <> "0" Then
            strWhereClause = strWhereClause + " AND Type='" + CommonFunction.General.BuildQueryString(xAxisType) + "'"
        End If

        If InStr(xAxisFieldName.ToUpper, "DATE") = 0 Then
            If xAxisFieldName <> "0" Then
                If xAxisFieldName = "TypeAndStatus" Then
                    If Trim(xAxisFieldValue) <> "" Then
                        strWhereClause = strWhereClause + " AND Type='" + CommonFunction.General.BuildQueryString(xAxisType) + "' AND v_tbl_IB_Issue.Status='" + CommonFunction.General.BuildQueryString(xAxisFieldValue) + "'"
                    Else
                        strWhereClause = strWhereClause + " AND Type='" + CommonFunction.General.BuildQueryString(xAxisType) + "' AND v_tbl_IB_Issue.Status IS NULL"
                    End If
                ElseIf xAxisFieldName = "SubType" Then
                    If Trim(xAxisFieldValue) <> "" Then
                        strWhereClause = strWhereClause + " AND Type='" + CommonFunction.General.BuildQueryString(xAxisType) + "' AND SubType='" + CommonFunction.General.BuildQueryString(xAxisFieldValue) + "'"
                    Else
                        strWhereClause = strWhereClause + " AND Type='" + CommonFunction.General.BuildQueryString(xAxisType) + "' AND SubType IS NULL "
                    End If
                Else
                    If Trim(xAxisFieldValue) <> "" Then
                        'Response.Write "HERE"
                        strWhereClause = strWhereClause + " AND " + xAxisFieldName + "='" + CommonFunction.General.BuildQueryString(xAxisFieldValue) + "'"
                    Else
                        strWhereClause = strWhereClause + " AND " + xAxisFieldName + " IS NULL  "
                    End If
                End If
            Else
                strWhereClause = strWhereClause + " AND  1=1  "
            End If

        Else 'if date field occures

            'if both dates have been specified
            If strLevel = "I" Then
                If Trim(xAxisFieldValue) <> "0" Then
                    strWhereClause = strWhereClause + " AND Convert(Varchar(10)," + xAxisFieldName + ",101)='" + xAxisFieldValue + "'"
                Else
                    strWhereClause = strWhereClause + " AND " + xAxisFieldName + " IS NULL "
                End If
            Else
                If xAxisFromDate <> "0" And xAxisToDate <> "0" Then
                    strWhereClause = strWhereClause + " AND " + xAxisFieldName + ">='" + xAxisFromDate.ToString + "' AND " + xAxisFieldName + "<='" + xAxisToDate.ToString + "'"
                End If
                'if no to date specified
                If xAxisFromDate <> "0" And xAxisToDate = "0" Then
                    strWhereClause = strWhereClause + " AND " + xAxisFieldName + ">='" + xAxisFromDate.ToString + "'"
                End If
                'if no From date specified
                If xAxisFromDate = "0" And xAxisToDate.ToString <> "0" Then
                    strWhereClause = strWhereClause + " AND " + xAxisFieldName + "<='" + xAxisToDate.ToString + "'"
                End If
                If Trim(xAxisFieldValue) <> "0" Then
                    strWhereClause = strWhereClause + " AND Convert(Varchar(10)," + xAxisFieldName + ",101)='" + xAxisFieldValue + "'"
                Else
                    strWhereClause = strWhereClause + " AND " + xAxisFieldName + " IS NULL "
                End If


            End If
        End If

        'yAxis field
        'building the query for y-axis fields
        If yAxisType <> "0" Then

            strWhereClause = strWhereClause + " AND Type='" + CommonFunction.General.BuildQueryString(yAxisType) + "'"

        End If


        If InStr(yAxisFieldName.ToUpper, "DATE") = 0 Then
            If yAxisFieldName <> "0" Then
                If yAxisFieldName = "TypeAndStatus" Then
                    If Trim(yAxisFieldValue) <> "" Then
                        strWhereClause = strWhereClause + " AND Type='" + CommonFunction.General.BuildQueryString(yAxisType) + "' AND v_tbl_IB_Issue.Status='" + CommonFunction.General.BuildQueryString(yAxisFieldValue) + "'"
                    Else
                        strWhereClause = strWhereClause + " AND Type='" + CommonFunction.General.BuildQueryString(yAxisType) + "' AND v_tbl_IB_Issue.Status IS NULL"
                    End If
                ElseIf yAxisFieldName = "SubType" Then
                    If Trim(yAxisFieldValue) <> "" Then
                        strWhereClause = strWhereClause + " AND Type='" + CommonFunction.General.BuildQueryString(yAxisType) + "' AND SubType='" + CommonFunction.General.BuildQueryString(yAxisFieldValue) + "'"
                    Else
                        strWhereClause = strWhereClause + " AND Type='" + CommonFunction.General.BuildQueryString(yAxisType) + "' AND SubType IS NULL "
                    End If
                Else
                    If Trim(yAxisFieldValue) <> "" Then
                        strWhereClause = strWhereClause + " AND " + yAxisFieldName + "='" + CommonFunction.General.BuildQueryString(yAxisFieldValue) + "'"
                    Else
                        strWhereClause = strWhereClause + " AND " + yAxisFieldName + " IS NULL  "
                    End If
                End If
            Else
                strWhereClause = strWhereClause + " AND  1=1  "
            End If
        Else 'if date field occures
            'Convert(Varchar(10),Convert(datetime,' + char(39) + @dtFromDate + char(39) +',101),101)'
            'if both dates have been specified
            If strLevel = "I" Then
                'if date field is null
                If Trim(yAxisFieldValue) <> "0" Then
                    strWhereClause = strWhereClause + " AND Convert(Varchar(10)," + yAxisFieldName + ",101)='" + yAxisFieldValue + "'"
                Else
                    strWhereClause = strWhereClause + " AND " + yAxisFieldName + " IS NULL "
                End If

            Else
                'Response.Write "YESI"
                'Response.Write "FD" +  yAxisFromDate + "<BR>"

                'Response.Write "TD" +  yAxistODate + "<BR>"
                If yAxisFromDate <> "0" And yAxisToDate <> "0" Then
                    strWhereClause = strWhereClause + " AND " + yAxisFieldName + ">='" + yAxisFromDate.ToString + "' AND " + yAxisFieldName + "<='" + yAxisToDate.ToString + "'"
                End If
                'if no to date specified
                If yAxisFromDate <> "0" And yAxisToDate = "0" Then
                    strWhereClause = strWhereClause + " AND " + yAxisFieldName + ">='" + yAxisFromDate.ToString + "'"
                End If
                'if no From date specified
                If yAxisFromDate = "0" And yAxisToDate <> "0" Then
                    strWhereClause = strWhereClause + " AND " + yAxisFieldName + "<='" + yAxisToDate.ToString + "'"
                End If
                'if date field is null
                If Trim(yAxisFieldValue) <> "0" Then
                    strWhereClause = strWhereClause + " AND Convert(Varchar(10)," + yAxisFieldName + ",101)='" + yAxisFieldValue + "'"
                ElseIf Trim(yAxisFieldValue) = "" Then
                    strWhereClause = strWhereClause + " AND " + yAxisFieldName + " IS NULL "
                End If

            End If
        End If

        'based on filed
        'building the query for Based On fields
        'Response.Write BasedOnFieldName
        'type
        If BasedOnType <> "0" Then

            strWhereClause = strWhereClause + " AND Type='" + CommonFunction.General.BuildQueryString(BasedOnType) + "'"

        End If
        'type end
        If InStr(BasedOnFieldName.ToUpper, "DATE") = 0 Then

            If BasedOnFieldName <> "0" Then
                If BasedOnFieldName = "TypeAndStatus" Then
                    If Trim(BasedOnFieldValue) <> "" Then
                        strWhereClause = strWhereClause + " AND Type='" + CommonFunction.General.BuildQueryString(BasedOnType) + "' AND v_tbl_IB_Issue.Status='" + CommonFunction.General.BuildQueryString(BasedOnFieldValue) + "'"
                    Else
                        strWhereClause = strWhereClause + " AND Type='" + CommonFunction.General.BuildQueryString(BasedOnType) + "' AND v_tbl_IB_Issue.Status IS NULL"
                    End If
                ElseIf BasedOnFieldName = "SubType" Then
                    'Response.Write  "Y"
                    If Trim(BasedOnFieldValue) <> "" Then
                        strWhereClause = strWhereClause + " AND Type='" + CommonFunction.General.BuildQueryString(BasedOnType) + "' AND SubType='" + CommonFunction.General.BuildQueryString(BasedOnFieldValue) + "'"
                    Else
                        strWhereClause = strWhereClause + " AND Type='" + CommonFunction.General.BuildQueryString(BasedOnType) + "' AND SubType IS NULL "
                    End If
                Else
                    If Trim(BasedOnFieldValue) <> "" Then
                        strWhereClause = strWhereClause + " AND " + BasedOnFieldName + "='" + CommonFunction.General.BuildQueryString(BasedOnFieldValue) + "'"
                    Else
                        strWhereClause = strWhereClause + " AND " + BasedOnFieldName + " IS NULL  "
                    End If
                End If
            Else
                strWhereClause = strWhereClause + " AND  1=1  "
            End If
        Else 'if date field occures
            'Response.Write "Y"	
            'Convert(Varchar(10),Convert(datetime,' + char(39) + @dtFromDate + char(39) +',101),101)'
            'if both dates have been specified
            If strLevel = "I" Then
                'if based on date field is  null
                If Trim(BasedOnFieldValue) <> "0" Then
                    strWhereClause = strWhereClause + " AND Convert(Varchar(10)," + BasedOnFieldName + ",101)='" + BasedOnFieldValue + "'"
                Else
                    strWhereClause = strWhereClause + " AND " + BasedOnFieldName + " IS NULL "
                End If
            Else
                If BasedOnFromDate <> "0" And BasedOnToDate <> "0" Then
                    strWhereClause = strWhereClause + " AND " + BasedOnFieldName + ">='" + BasedOnFromDate.ToString + "' AND " + BasedOnFieldName + "<='" + BasedOnToDate.ToString + "'"
                End If
                'if no to date specified
                'Response.Write BasedOnFromDate
                If BasedOnFromDate <> "0" And BasedOnToDate = "0" Then
                    strWhereClause = strWhereClause + " AND " + BasedOnFieldName + ">='" + BasedOnFromDate.ToString + "'"
                End If
                'if no From date specified
                If BasedOnFromDate = "0" And BasedOnToDate <> "0" Then
                    strWhereClause = strWhereClause + " AND " + BasedOnFieldName + "<='" + BasedOnToDate.ToString + "'"
                End If
                'if based on date field is  null
                If Trim(BasedOnFieldValue) <> "0" And Trim(BasedOnFieldValue) <> "0" Then
                    strWhereClause = strWhereClause + " AND Convert(Varchar(10)," + BasedOnFieldName + ",101)='" + BasedOnFieldValue + "'"
                ElseIf Trim(BasedOnFieldValue) = "" Then
                    strWhereClause = strWhereClause + " AND " + BasedOnFieldName + " IS NULL "
                End If
            End If
        End If

        'get the view for given view id
        If intViewID > 0 Then
            strSQLQuery = "EXEC usp_Sel_tbl_IB_Project_Views NULL,NULL,NULL," + intViewID.ToString
            'execute the query
            rsView = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            'check for eof
            If rsView.Read Then
                strFieldList = rsView("Fields").ToString
                strSortBy = rsView("SortBy").ToString
            Else 'if the user does't have any view then apply the corporate level view
                strFieldList = CommonFunction.Application.IBDefaultView
            End If
            'close the recordset object
            CommonFunction.Data.DisposeDataReader(rsView)
        Else 'If no view defined for project, apply default view
            strFieldList = CommonFunction.Application.IBDefaultView
        End If


        If InStr("," + strFieldList + ",", ",IssueID,") > 0 Then
            strSQL = "SELECT " + strFieldList
        Else 'if in the view does't select the issue id field then append this field as first field 
            strSQL = "SELECT IssueID," + strFieldList
        End If

        strSQL = strSQL + " FROM v_tbl_IB_Issue "

        If InStr(strSortBy, "tbl_IB_Priorities.OrderNumber") <> 0 Then
            strSQL = strSQL + " LEFT JOIN tbl_IB_Priorities ON v_tbl_IB_Issue.CorporatePriority=tbl_IB_Priorities.Priority "

        End If
        If InStr(strSortBy, "tbl_IB_Severity.OrderNumber") <> 0 Then
            strSQL = strSQL + " LEFT JOIN tbl_IB_Severity ON v_tbl_IB_Issue.CorporateSeverity=tbl_IB_Severity.Severity "
        End If

        '
        'attach the session project id	
        If intProjectGroupID = 0 Then
            strSQL = strSQL + strWhereClause + " AND ProjectID=" + intProjectID.ToString
        Else
            strSQL = strSQL + strWhereClause + " AND ProjectID IN (SELECT ProjectID FROM tbl_PM_Project WHERE  ShareIBWithInProjectGroup=1 AND  ProjectGroupID=" + intProjectGroupID.ToString + ")"
        End If

        If Session("LoginType").ToString = "C" Then strSQL = strSQL + " AND ShowToCustomer=1 "

        Call PlotIssueListGrid()

    End Sub

    Private Sub PlotIssueListGrid()
        '=====================================================================
        ' Procedure Name        : PlotIssueListGrid()	
        ' Purpose               : To plot Issue list when clicked on cell
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 11, 2004
        ' Revisions             :
        '=====================================================================


        'generate Actual column headings array
        Dim ArrActualNameList As New ArrayList, inti As Integer, ArrTemp() As String
        Dim blnIssueIdPresent As Boolean = False

        If InStr("," + strFieldList + ",", ",IssueID,") > 0 Then
            blnIssueIdPresent = True
        Else 'if in the view does't select the issue id field then append this field as first field 
            blnIssueIdPresent = False
        End If

        If Not blnIssueIdPresent Then
            strFieldList = Replace("," + strFieldList + ",", ",IssueID,", "")
            strFieldList = Left(strFieldList, Len(strFieldList) - 1)
        End If

        ArrTemp = Split(strFieldList, ",")

        For inti = 0 To UBound(ArrTemp)
            If InStr(ArrTemp(inti), " AS ", CompareMethod.Text) > 0 Then
                ArrActualNameList.Add(Replace(Right(ArrTemp(inti), Len(ArrTemp(inti)) - InStr(ArrTemp(inti), " AS ") - 3).Trim, """", ""))
            Else
                ArrActualNameList.Add(ArrTemp(inti).Trim)
            End If
        Next inti

        'Convert arraylist to actual array - Actual Column Names
        Dim ArrActualName(ArrActualNameList.Count - 1) As String
        ArrActualNameList.ToArray.CopyTo(ArrActualName, 0)
        ArrActualNameList = Nothing
        '---Actual column headings array generated

        'generate User Friendly column headings array
        Dim ArrColHeadingsList As New ArrayList

        For inti = 0 To UBound(ArrTemp)
            If InStr(ArrTemp(inti), " AS ", CompareMethod.Text) > 0 Then
                ArrColHeadingsList.Add("$" + Replace(Right(ArrTemp(inti), Len(ArrTemp(inti)) - InStr(ArrTemp(inti), " AS ") - 3).Trim, """", "").Trim)
            Else
                ArrColHeadingsList.Add(GetUserFriendlyName((ArrTemp(inti).Trim)))
            End If
        Next inti

        'Convert arraylist to actual array - User Friendly column headings
        Dim ArrColHeadings(ArrColHeadingsList.Count - 1) As String
        ArrColHeadingsList.ToArray.CopyTo(ArrColHeadings, 0)
        ArrColHeadingsList = Nothing
        '--User friendly column headings array generated.

        'Plot Issue List grid 

        With objIssueGrid
            .ActualColumnArray = ArrActualName
            .UserFriendlyColumnArray = ArrColHeadings
            .NoOfDataColumns = UBound(ArrTemp) + 4
            .returnHTML = False
            .UseSQL = MyBase.UseSQL
            .DIVHeight = 425
            .ColNameToolTipOnEachRow = True
            .DIVID = "PageDiv"
            .DIVStyle = "Overflow:auto;width=100%"
            .SQL = strSQL
            .DrawGrid()
        End With

        Response.Write("<BR>")

        'Display record count (Total number of Issues for qury applied)
        Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTREven'><td align=right>" + MyBase.GetResourceString("RECORDCOUNT") + " : " + objIssueGrid.NoOfRowsInPage.ToString + "</TD></TR></Table><BR>")

    End Sub

    Private Sub SetVariables()
        '=====================================================================
        ' Procedure Name        : SetVariables()	
        ' Purpose               : To set the variables being used in this page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 11, 2004
        ' Revisions             :
        '=====================================================================

        intProjectID = CType(Session("IssueProject"), Integer)

        If Request.QueryString("cboView").ToString <> "" Then
            intViewID = CType(Request.QueryString("cboView"), Integer)
        Else
            intViewID = 0
        End If

        If Not Request.QueryString("ProjectGroupID") Is Nothing Then
            If Request.QueryString("ProjectGroupID") <> "" Then
                intProjectGroupID = CType(Request.QueryString("ProjectGroupID"), Integer)
            End If
        End If

        If Not Request.QueryString("xAxisFieldName") Is Nothing Then
            If Request.QueryString("xAxisFieldName") <> "" Then
                xAxisFieldName = Request.QueryString("xAxisFieldName")
            End If
        End If

        If Not Request.QueryString("yAxisFieldName") Is Nothing Then
            If Request.QueryString("yAxisFieldName") <> "" Then
                yAxisFieldName = Request.QueryString("yAxisFieldName")
            End If
        End If

        If Not Request.QueryString("BasedOnFieldName") Is Nothing Then
            If Request.QueryString("BasedOnFieldName") <> "" Then
                BasedOnFieldName = Request.QueryString("BasedOnFieldName").ToString
            End If
        End If

        If Not Request.QueryString("xAxisFieldValue") Is Nothing Then
            If Request.QueryString("xAxisFieldValue") <> "" Then
                xAxisFieldValue = Replace(Request.QueryString("xAxisFieldValue"), "*", "&")
                xAxisFieldValue = Replace(xAxisFieldValue, "||--||", "'")
            End If
        End If

        If Not Request.QueryString("yAxisFieldValue") Is Nothing Then
            If Request.QueryString("yAxisFieldValue") <> "" Then
                yAxisFieldValue = Replace(Request.QueryString("yAxisFieldValue"), "*", "&")
                yAxisFieldValue = Replace(yAxisFieldValue, "||--||", "'")
            End If
        End If

        If Not Request.QueryString("BasedOnFieldValue") Is Nothing Then
            If Request.QueryString("BasedOnFieldValue") <> "" Then
                BasedOnFieldValue = Replace(Request.QueryString("BasedOnFieldValue") + "", "*", "&")
                BasedOnFieldValue = Replace(BasedOnFieldValue, "||--||", "'")
            End If
        End If

        If Not Request.QueryString("xAxisType") Is Nothing Then
            If Request.QueryString("xAxisType") <> "" Then
                xAxisType = Replace(Request.QueryString("xAxisType") + "", "*", "&")
            End If
        End If

        If Not Request.QueryString("yAxisType") Is Nothing Then
            If Request.QueryString("yAxisType") <> "" Then
                yAxisType = Replace(Request.QueryString("yAxisType") + "", "*", "&")
            End If
        End If

        If Not Request.QueryString("BasedOnType") Is Nothing Then
            If Request.QueryString("BasedOnType") <> "" Then
                BasedOnType = Replace(Request.QueryString("BasedOnType") + "", "*", "&")
            End If
        End If

        If Not Request.QueryString("xAxisFromDate") Is Nothing Then
            If Request.QueryString("xAxisFromDate") <> "" Then
                xAxisFromDate = Request.QueryString("xAxisFromDate")
            End If
        End If

        If Not Request.QueryString("xAxisToDate") Is Nothing Then
            If Request.QueryString("xAxisToDate") <> "" Then
                xAxisToDate = Request.QueryString("xAxisToDate")
            End If
        End If

        If Not Request.QueryString("yAxisFromDate") Is Nothing Then
            If Request.QueryString("yAxisFromDate") <> "" Then
                yAxisFromDate = Request.QueryString("yAxisFromDate")
            End If
        End If

        If Not Request.QueryString("yAxisToDate") Is Nothing Then
            If Request.QueryString("yAxisToDate") <> "" Then
                yAxisToDate = Request.QueryString("yAxisToDate")
            End If
        End If

        If Not Request.QueryString("BasedOnFromDate") Is Nothing Then
            If Request.QueryString("BasedOnFromDate") <> "" Then
                BasedOnFromDate = Request.QueryString("BasedOnFromDate")
            End If
        End If

        If Not Request.QueryString("BasedOnToDate") Is Nothing Then
            If Request.QueryString("BasedOnToDate") <> "" Then
                BasedOnToDate = Request.QueryString("BasedOnToDate")
            End If
        End If

        If Not Request.QueryString("Level") Is Nothing Then
            If Request.QueryString("Level") <> "" Then
                strLevel = Request.QueryString("Level")
            End If
        End If

        If xAxisFieldValue.ToUpper = "TRUE" Then
            xAxisFieldValue = "1"
        ElseIf xAxisFieldValue.ToUpper = "FALSE" Then
            xAxisFieldValue = "0"
        End If

        If yAxisFieldValue.ToUpper = "TRUE" Then
            yAxisFieldValue = "1"
        ElseIf yAxisFieldValue.ToUpper = "FALSE" Then
            yAxisFieldValue = "0"
        End If

        If BasedOnFieldValue.ToUpper = "TRUE" Then
            BasedOnFieldValue = "1"
        ElseIf BasedOnFieldValue.ToUpper = "FALSE" Then
            BasedOnFieldValue = "0"
        End If
    End Sub

    Private Function GetUserFriendlyName(ByVal strFieldName As String) As String
        '=====================================================================
        ' Procedure Name        : GetUserFriendlyName()	
        ' Purpose               : To get user friendly field name for given field
        ' Description           : same as above
        ' Parameters Passed     : strFieldName - Actual Field name
        ' Returns               : user friendly field name (string)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String

        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_CultureId Then
            strSQL = "EXEC usp_Sel_tbl_IB_DataDictionary '" + Trim(strFieldName) + "'"
        Else
            strSQL = "EXEC usp_Sel_tbl_IB_DataDictionary_Culture '" + Trim(strFieldName) + "'," + m_CultureId.ToString
        End If

        Dim drUserFriendlyName As IDataReader

        drUserFriendlyName = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_IB_DataDictionary '" + Trim(strFieldName) + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drUserFriendlyName.Read Then
            Return drUserFriendlyName("USerFriendlyName").ToString
        Else
            Return "Not Specified"
        End If
        CommonFunctions.Data.DisposeDataReader(drUserFriendlyName)
    End Function 'Get user friendly name for field

    Private Sub objIssueGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objIssueGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure Name        : objIssueGrid_DataRowTD_BeforePrint()	
        ' Purpose               : To remove comma from IssueId
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 11, 2004
        ' Revisions             :
        '=====================================================================


        If Args.DataField.ToUpper = "ISSUEID" Then
            Args.ReplacementValue = FormatNumber(Args.DataReader("IssueID"), 0, TriState.False, TriState.False, TriState.False)
        End If
    End Sub
End Class
