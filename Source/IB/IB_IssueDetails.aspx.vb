'=====================================================================
' Module Name       :   IB_IssueDetails

' Purpose           :   Show the details page for issue

' Description       :   Same as above

' Dependencies      :   The resource file for standard Menu and IB_IssueDetails

' Author            :   DipaliS

' Created           :   April 19, 2004

' Revisions         :
'=====================================================================
Imports System.Text
Public Class IB_IssueDetails
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'Added by MrugajaB on 30th June 2006 for Whiziblesem SP7 Issue ID.4507
    Private m_LoginId As Long 'Login Id
    Private m_LoginType As String 'Login type
    Private m_RoleId As Long 'Role Id
    Private m_RoleLevel As Integer 'Role level
    Protected m_ProjectId As Long 'Project Id
    Private m_UserId As Long 'User Id
    Private m_UserName As String 'User Name
    'Protected m_intPageNumber As Integer  'Currently Selected page number
    '(Values set in GetSortingDetails)
    'Protected m_strSortField As String = "" 'Sort field
    'Protected m_strSortOrder As String = "" 'SortOrder
    'End Addition
    'Added by SavitaS on 19 Sept 2006 for Security Issue 6197
    Protected m_strToken As String
    'End of Added by SavitaS on 19 Sept 2006 for Security Issue 6197

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region "Member Varaibles"
    Private m_objGlobal As WebPages.Template.IGlobal
    Protected m_strIssueID As String
    Private m_intProjectID As Integer
    Private m_blnSkipQry As Boolean
    Private m_strViewID As String
    Private WithEvents m_objGrid As WebPages.Template.AdvancedGrid
#End Region

#Region "Constructor"
    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
#End Region

#Region "Procedures"
    Public Sub PageInit()
        'Added by SavitaS on 19 Sept 2006 for Security Issue 6197 
        'If Trim(Request.QueryString("PKToken")) <> "" Then
        'm_strToken = Request.QueryString("PKToken").ToString
        'Else
        '    m_strToken = CommonFunctions.Security.Token.GetToken(m_strIssueID.ToString + CType(Session("intUserID"), String) + "0" + "0")
        'End If
        If CType(m_strToken, String) <> "0" Then
            If Request.QueryString("PkToken") Is Nothing Then
                m_strToken = Request.Form("txtPkToken").ToString
            Else
                m_strToken = Request.QueryString("PkToken").ToString
            End If
        End If

        If ((m_strToken = "") And (m_strIssueID.ToString <> "0")) Or _
 ((m_strIssueID.ToString <> "0") And (CommonFunctions.Security.Token.ValidateToken(CType(m_strIssueID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), m_strToken) = False)) Then
            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Details", 0, 0, "Issue ID", CType(m_strIssueID, String))
            'Token is Invalid now redirect to the Invalid Access Page
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'End of Added by SavitaS on 19 Sept 2006 for Security Issue 6197 

        Dim strSQL As String
        Dim dr As IDataReader
        Dim strProjectName As String

        '######### Page Code starts here
        'GetGlobalObject()
        'Plot the Page Menus
        GetMenu()

        Response.Write("<BR>")

        m_blnSkipQry = False

        m_strViewID = MyBase.GetFormValue("cboView")

        'Commented by MrugajaB on 10th March 2006 (Issue ID.685)
        'If Request("Mode") = "" Then
        '    If m_strViewID = "" Then m_strViewID = CType(CommonFunctions.General.CheckIsNothing(Session("intViewID")), String)
        'End If
        'End Comment


        'Modified by MrugajaB on 30th June 2006 for Whiziblesem SP7 Issue ID.4507
        'Purpose:1)When view was not set for issue list page,page gets crashed
        '2)Through show details link user can view issues which do not belong to projects accessible to him
        Dim drIssueDetails As IDataReader
        Dim strScript As String

        Call CreateGlobalObject()

        strSQL = "Exec usp_Sel_tbl_IB_Issue_Project " + m_ProjectId.ToString + ", " + m_strIssueID & ", '" + m_LoginType + "'," + m_UserId.ToString + "," + CType(Session("intLoginID"), String)
        drIssueDetails = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        'End Modification by SandipL on 21 Feb 2006
        ' If no record is found, then display the message, and redirect the person to the Issue List screen.
        If drIssueDetails.Read Then
            'Code Modified by SandipL on 17 Feb 2006 -- IssueID 2142 -- WhizSem_Whiz2 sp6
            'm_intProjectID = CType(CommonFunctions.General.CheckIsNothing(Session("intProjectID")), Integer)
            'm_intProjectID = CType(CommonFunctions.General.CheckIsNothing(Session("IssueProject")), Integer)

            'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            'strSQL = " Select ProjectID,ProjectName From tbl_PM_Project where  Projectid=(Select ProjectID From tbl_IB_Issue Where IssueID=" & m_strIssueID & ")"

            ''Commented and Added by Dhanashri S on 22 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
            ''strSQL = "usp_sel_tbl_PM_Project_IssueID " & m_strIssueID & ")"
            strSQL = "usp_sel_tbl_PM_Project_IssueID " & m_strIssueID
            ''End of comment and addition by Dhanashri S on 22 Aug 2016 

            'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

            'execute the query
            dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

            If dr.Read Then
                m_intProjectID = CType(dr.Item("ProjectID"), Integer)
                strProjectName = CType(dr.Item("ProjectName"), String)
                'Added by by SandipL on 17 Feb 2006 to show current Project Name as  PageCaption -- IssueID 2144
                Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, "Project: " + strProjectName, , , False))
            Else
                m_intProjectID = 0 'CType(Session("IssueProject"), Integer)
            End If
            CommonFunction.Data.DisposeDataReader(dr)

            'Added by MrugajaB on 10th March 2006 (Issue ID.685)
            'Purpose:Whenever this page is visited , view displayed in combo should be the view applied to the project of the current issue
            'Previously, this view was taken from session
            If Request("Mode") = "" Then
                If m_strViewID = "" Then
                    'if ViewId not available in Session, Check for default view for user, if any
                    Dim drDefaultView As IDataReader
                    strSQL = "Exec usp_Sel_tbl_IB_DefaultView " + CType(Session("intUserID"), String) + ", " + m_intProjectID.ToString + ", '" & CType(Session("LoginType"), String) + "'"
                    drDefaultView = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    If drDefaultView.Read Then
                        'set session variable 
                        m_strViewID = CType(CommonFunctions.Data.CheckIsDBNull(drDefaultView("ProjectViewId"), ""), String)

                        'Destroy DataReaders
                        CommonFunctions.Data.DisposeDataReader(drDefaultView)
                    Else
                        m_strViewID = "0"
                    End If
                End If
            End If
            'End Addition

            'End Addition by SandipL

            GetUIForIssueDetails()

        Else

            strScript = "<script LANGUAGE=javascript>" + vbCrLf
            strScript += "alert('This issue does not belong to any of the projects accessible to you!');" + vbCrLf
            strScript += "window.close();"
            strScript += "</script>"
            Response.Write(strScript)

        End If
        'End Modification by MrugajaB
        ' Added by GaneshD on 17 Sep 2009 for Clean-up activity
        CommonFunction.Data.DisposeDataReader(drIssueDetails)
        ' End of addition by GaneshD
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        GetMenu()
    End Sub

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_strIssueID = Request.QueryString("IssueID")
    End Sub

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
        ' Created               : Feb 7, 2004
        ' Revisions             :
        '=====================================================================

        'Global object
        'Added by MrugajaB on 30th June 2006 for Whiziblesem SP7 Issue ID.4507
        Dim objGlobal As WebPages.Template.IGlobal

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        With objGlobal
            m_LoginId = .LoginID
            m_LoginType = .LoginType
            m_RoleId = .RoleID
            m_RoleLevel = .RoleLevel
            m_UserId = .UserID
        End With
    End Sub 'Get all session variable values

    'Private Sub GetSortingDetails()
    '    '=====================================================================
    '    ' Procedure Name        : GetSortingDetails()	
    '    ' Purpose               : to get sorting details
    '    ' Description           : same as above
    '    ' Parameters Passed     : none
    '    ' Returns               : none
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : AniruddhaD
    '    ' Created               : Feb 10, 2004
    '    ' Revisions             :
    '    '=====================================================================
    '    'Added by MrugajaB on 30th June 2006 for Whiziblesem SP7 Issue ID.4507
    '    ' if querystring has OrderBy
    '    If Not Request.QueryString("OrderBy") Is Nothing Then
    '        If Request.QueryString("OrderBy").Trim <> "" Then
    '            m_strSortField = Request.QueryString("OrderBy").Trim
    '        Else ' By default, sort on IssueId
    '            'Code Commented by DipaliS 30 Sep 2004 and added the following line
    '            'Purpose    :   To Remove the Default sorting on Issue ID
    '            'm_strSortField = "IssueID"
    '            m_strSortField = ""
    '        End If
    '    ElseIf Not MyBase.GetFormValue("txtSortField") Is Nothing Then
    '        If MyBase.GetFormValue("txtSortField").Trim <> "" Then
    '            m_strSortField = MyBase.GetFormValue("txtSortField").Trim
    '        End If
    '    Else
    '        'Code Commented by DipaliS 30 Sep 2004 and added the following line
    '        'Purpose    :   To Remove the Default sorting on Issue ID
    '        ' m_strSortField = "IssueID"
    '        m_strSortField = ""
    '    End If

    '    ' If querystring has sort order
    '    'Modified By Parag
    '    If CommonFunction.General.CheckIsNothing(Request.QueryString("ASCDESC"), "") <> "" Then
    '        If Request.QueryString("ASCDESC").Trim <> "" Then
    '            m_strSortOrder = Request.QueryString("ASCDESC").Trim
    '        Else ' By default sort order is desc
    '            m_strSortOrder = "DESC"
    '        End If
    '        ' By default sort order is desc
    '    Else
    '        m_strSortOrder = Request.Form("txtSortOrder")
    '    End If
    '    'End Addition
    'End Sub 'Get Sorting details 
    '====================================================================
    ' Procedure Name        : GetMenu
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Purpose               : To Plot the Page Menu for Issue Details Page
    ' Description           : Same as Above  
    ' Assumptions           : Related Resource file Exists
    ' Dependencies          : Resource file for Standard Menu
    ' Author                : DipaliS
    ' Created               : April 19, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetMenu()
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuClientFun() As String = {"Close_OnClick()", "Help_OnClick('IB_ISSUE_DETAILS_RPT')"}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim objMenu As WebPages.Template.StaticMenu
        objMenu = New WebPages.Template.StaticMenu
        objMenu.DrawMenu(arrMenu, arrMenuClientFun, arrMenuToolTip, False)
        objMenu = Nothing
    End Sub
    '====================================================================
    ' Procedure Name        : GetGlobalObject
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Purpose               : Function To Fill Global Object
    ' Description           : Same as Above  
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : April 19, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject
    End Sub

    '==================================================================================
    ' Procedure Name		:	GetUserFriendlyName
    ' Parameters Passed		:	strFieldName :- The field name whose user friendly name must be returned.
    ' Returns				:	Returns the User Friendly name of the field specified.
    ' Parameters Affected	:	None.
    ' Purpose				:	To return the user friendly name of the database field passed.
    ' Description			:	Same as above.
    ' Assumptions			:	
    ' Dependencies			:	None
    ' Author				:	DipaliS
    ' Created				:	April 19, 2004
    ' Revisions				:	
    '==================================================================================
    Protected Function GetUserFriendlyName(ByVal strFieldName As String) As String
        Dim drUserFriendly As IDataReader
        Dim strName As String = ""
        drUserFriendly = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_IB_DataDictionary '" & strFieldName & "'", MyBase.UseSQL)

        If drUserFriendly.Read Then
            strName = Trim(CType(drUserFriendly.Item("UserFriendlyName"), String) & "")
        End If

        'drUserFriendly.Dispose()
        CommonFunction.Data.DisposeDataReader(drUserFriendly)
        Return strName
    End Function
    '==================================================================================
    ' Procedure Name		:	GetUIForIssueDetails
    ' Parameters Passed		:	None
    ' Returns				:	None
    ' Parameters Affected	:	None.
    ' Purpose				:	To Plot the UI For Issue Details
    ' Description			:	Same as above.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	DipaliS
    ' Created				:	April 19, 2004
    ' Revisions				:	
    '==================================================================================
    Private Sub GetUIForIssueDetails()
        MyBase.InitializeResources("AppResources.IB_IssueDetails", "AppResources")
        Dim strHTML As New StringBuilder
        Dim strSQLQuery As String
        If m_intProjectID > 0 Then
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            strHTML.Append("<TABLE Width=99.9% class=clsTable><TR><TD class=clsTDEven align=center>" & MyBase.GetResourceString("SELECTVIEW") & " ")
            strSQLQuery = "Exec usp_Sel_tbl_IB_Project_Views " & m_intProjectID & ", '" & CType(CommonFunctions.General.CheckIsNothing(Session("LoginType")), String) & "'," & CType(CommonFunctions.General.CheckIsNothing(Session("intUserID")), String) & ", NULL, 4, '-1'"
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboView", strSQLQuery, , m_strViewID, "Language=VBSCript OnChange=ViewChange(" & m_strIssueID & ")", True, True))
            strHTML.Append("</TD></TR></TABLE><BR>")
            CommonFunctions.General.WriteHTML(strHTML.ToString)
        End If

        'Added by SavitaS on 20 Sept 2006
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_strToken, , , , , , , , , , , , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'End Addition by SvaitaS

        Dim drIssue As IDataReader
        Dim drView As IDataReader
        Dim strFieldList As String
        Dim strSQL As String
        Dim m_roleid As Integer
        Dim strType As String


        'Get the Types accessible for given Role and Project
        Dim drTypeAccess As IDataReader
        Dim strSQLForRole As String
        Dim strListOfTypes As String

        strListOfTypes = ""

        If CType(Session("intRoleLevel"), Integer) = CommonFunction.Constants.ACCESS_LEVEL_LOW Or CType(Session("LoginType"), String) = "E" Then

            Dim drGetRole As IDataReader
            drGetRole = CommonFunction.Data.GetDataReader("EXEC usp_Sel_EmployeeProjectRole " & m_intProjectID & "," & CType(Session("intUserID"), Long), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            If drGetRole.Read Then
                m_roleid = CType(drGetRole(0), Integer)
            End If
            'Close the object
            ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 
            'Close the object
            'drGetRole.Close()
            CommonFunction.Data.DisposeDataReader(drGetRole)

            ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

        Else
            m_roleid = CType(Session("intPostID"), Integer)

        End If
        strSQLForRole = "Exec usp_sel_tbl_ib_typerolesecurity_GetRecordSet " & m_intProjectID & "," & m_roleid
        drTypeAccess = CommonFunctions.Data.GetDataReader(strSQLForRole, MyBase.UseSQL)

        'If any record found that means security is explicitly set for the Role for that project
        While drTypeAccess.Read
            strListOfTypes = strListOfTypes + "'" + CommonFunctions.General.BuildQueryString(CType(CommonFunctions.General.CheckIsNothing(drTypeAccess.Item("TypeName")), String)) + "',"
        End While

        'Remove the last comma
        If strListOfTypes <> "" Then
            strListOfTypes = Left(strListOfTypes, strListOfTypes.Length - 1)
        End If
        CommonFunctions.Data.DisposeDataReader(drTypeAccess)



        'Modified by SandipL on 21 FEB 2006 -- whizsem_whiz2 sp6 IssueID 2101 -- Addde parameteres userID and LoginID
        drIssue = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_tbl_IB_Issue_Project " & m_intProjectID & "," & m_strIssueID & ",'" & CType(Session("LoginType"), String) & "'," & CType(Session("intUserID"), String) & "," & CType(Session("intLoginID"), String), MyBase.UseSQL)
        'End Modification by SandipL on 21 FEB 2006
        If drIssue.Read Then

            strType = "'" & CType(drIssue("Type"), String) & "'"

            Dim drCompanyInfo As IDataReader
            'get the view for given view id
            If m_strIssueID <> "" And m_strViewID <> "" And InStr(strListOfTypes, strType) > 0 Then
                strSQLQuery = "EXEC usp_Sel_tbl_IB_Project_Views NULL,NULL,NULL," & m_strViewID
                'execute the query
                drView = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

                If drView.Read Then
                    strFieldList = CType(drView.Item("Fields"), String)

                Else 'if the user does't have any view then apply the corporate level view

                    drCompanyInfo = CommonFunctions.Data.GetDataReader("EXEC usp_sel_tbl_PM_CompanyInformation", MyBase.UseSQL)

                    If drCompanyInfo.Read Then
                        strFieldList = CType(drCompanyInfo.Item("IBDefaultView"), String)
                    End If
                    CommonFunction.Data.DisposeDataReader(drCompanyInfo)
                    'drCompanyInfo.Dispose()

                End If
                CommonFunction.Data.DisposeDataReader(drView)
                'drView.Dispose()

                'if in view there is no issue id
                If CheckFieldInString2(Replace(strFieldList, ",", "|"), "|", "IssueID") = True Then
                    strSQL = "SELECT " & strFieldList
                Else 'if in the view does't select the issue id field then append this field as first field 
                    strSQL = "SELECT IssueID," & strFieldList
                End If

                strSQL = strSQL & " FROM v_tbl_IB_Issue "

                strSQL = strSQL & " WHERE IssueID=" & m_strIssueID

            Else

                drCompanyInfo = CommonFunctions.Data.GetDataReader("EXEC usp_sel_tbl_PM_CompanyInformation", MyBase.UseSQL)

                If drCompanyInfo.Read Then
                    strFieldList = CType(drCompanyInfo.Item("IBDefaultView"), String)
                End If
                CommonFunction.Data.DisposeDataReader(drCompanyInfo)
                'drCompanyInfo.Dispose()

                strSQL = "SELECT " & strFieldList & " FROM v_tbl_IB_Issue WHERE ProjectID=" & m_intProjectID & " AND IssueID=" & m_strIssueID

            End If

            If InStr(strListOfTypes, strType) > 0 Then
                Dim drIssueTableFields As IDataReader
                Dim strFieldName As String

                drIssueTableFields = CommonFunctions.Data.GetDataReader("SELECT * FROM v_tbl_IB_Issue WHERE 1 = 0", MyBase.UseSQL)

                Dim seperator As String = ","
                Dim sepCharArray() As Char = seperator.ToCharArray
                Dim intCount As Integer
                Dim strFieldListForGrid() As String
                strFieldListForGrid = strFieldList.Split(sepCharArray)

                Dim arrActualColumnArray(strFieldListForGrid.Length) As String
                Dim arrUserFriendlyArray(strFieldListForGrid.Length) As String
                Dim arrTDStyle() As String = {"width=50%;", "width=50%"}

                For intCount = 0 To strFieldListForGrid.Length - 1
                    Dim strActualName As String
                    Dim strUerFriendlyName As String
                    strActualName = Trim(strFieldListForGrid(intCount))
                    strUerFriendlyName = Trim(strFieldListForGrid(intCount))
                    'Build the Actual Column Name
                    If InStr(1, strActualName, "Custom", CompareMethod.Binary) <> 0 Then
                        If InStr(1, strActualName, "AS") > 0 Then
                            Dim strLeft As String
                            strLeft = Left(strActualName, Len(strActualName) - 1)
                            strActualName = Right(strLeft, (Len(strActualName) - 2 - InStr(1, strActualName, "AS") - 2))
                            strUerFriendlyName = strActualName
                        End If
                    ElseIf InStr(1, strUerFriendlyName, "Custom", CompareMethod.Binary) = 0 Then
                        If IsValidField(drIssueTableFields, strUerFriendlyName) Then
                            strUerFriendlyName = GetUserFriendlyName(strUerFriendlyName)
                        End If
                    End If
                    arrActualColumnArray(intCount) = strActualName
                    arrUserFriendlyArray(intCount) = strUerFriendlyName
                Next

                Response.Write("<DIV ID='PageDiv' style='overflow:auto;width=99.9%'>")

                m_objGrid = New WebPages.Template.AdvancedGrid
                m_objGrid.ActualColumnArray = arrActualColumnArray
                m_objGrid.UserFriendlyColumnArray = arrUserFriendlyArray
                m_objGrid.UseSQL = MyBase.UseSQL
                m_objGrid.SQL = strSQL
                m_objGrid.NoOfDataColumns = strFieldListForGrid.Length
                m_objGrid.DIVStyle = "'overflow:auto;height=100%;width:99.9%;'"
                'Commented by GaneshD on 16 Sep 2009 for changing the page layout
                'm_objGrid.TDStyleArray = arrTDStyle
                'm_objGrid.VerticalDisplay = True
                ' end of modification by GaneshD on 16 Sep 2009
                m_objGrid.EmptyValueReplacement = "-"

                m_objGrid.DrawGrid()
                Response.Write("</DIV>")
                CommonFunction.Data.DisposeDataReader(drIssueTableFields)
                CommonFunction.Data.DisposeDataReader(drIssue)

                'drIssueTableFields.Dispose()
                'drIssue.Dispose()
            Else
                Response.Write("<DIV ID='PageDiv' style='overflow:auto;width=100%'>")
                Dim strNoData As String
                strNoData = " Issue does not belong to your accessible list" 'MyBase.GetResourceString("NODATA")
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                strNoData = strNoData.Replace("<issueid>", GetUserFriendlyName("IssueID"))
                Response.Write("<TABLE class=clsTABLE width='99.9%'><TR><TD align=center class=clsTDODD>" & strNoData & "</TD></TR></TABLE>")
                Response.Write("</DIV>")
            End If

        Else
            Response.Write("<DIV ID='PageDiv' style='overflow:auto;width=100%'>")
            Dim strNoData As String
            strNoData = MyBase.GetResourceString("NODATA")
            strNoData = strNoData.Replace("<issueid>", GetUserFriendlyName("IssueID"))
            Response.Write("<TABLE class=clsTABLE width='99.9%'><TR><TD align=center class=clsTDODD>" & strNoData & "</TD></TR></TABLE>")
            Response.Write("</DIV>")
        End If


        Response.Write("<BR>")
        CommonFunction.Data.DisposeDataReader(drIssue)
    End Sub
#End Region

#Region "Functions"
    Private Function IsValidField(ByVal Fields As IDataReader, ByVal FieldName As String) As Boolean
        '==================================================================================
        ' Procedure Name		:	IsValidField
        ' Parameters Passed		:	Fields	 :- The recordset.
        '							FieldName :- The field name.
        ' Returns				:	Boolean
        ' Parameters Affected	:	None
        ' Purpose				:	To check whether the field name specified, is a valid field in the recordset.
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	DipaliS
        ' Created				:	19th April 2004
        ' Revisions				:	
        '==================================================================================

        Dim intCount As Integer
        Dim blnResult As Boolean
        blnResult = False
        ' For each field in the recordset, check if the field name matches with the field name that was passed.
        For intCount = 0 To Fields.FieldCount - 1
            If Fields.GetName(intCount) = FieldName Then
                blnResult = True
                Exit For
            End If
        Next
        Return blnResult
    End Function

    '==================================================================================
    ' Procedure Name		:	CheckFieldInString2
    ' Parameters Passed		:	The FiledLIst
    '                           Seperator
    '                           FieldName to match
    ' Returns				:	Boolean
    ' Parameters Affected	:	None
    ' Purpose				:	Checks whether the Field passed exists in given field list
    ' Description			:	Same as above.
    ' Assumptions			:	
    ' Dependencies			:	None
    ' Author				:	DipaliS
    ' Created				:	19th April 2004
    ' Revisions				:	
    '==================================================================================

    Private Function CheckFieldInString2(ByVal PFieldList As String, ByVal Seperator As String, ByVal FieldNameToCompare As String) As Boolean

        Dim sepCharArray() As Char = Seperator.ToCharArray
        Dim result As Boolean
        Dim strFieldListAry() As String
        Dim intCount As Integer
        strFieldListAry = PFieldList.Split(sepCharArray)

        result = False
        For intCount = 0 To UBound(strFieldListAry)
            If Trim(strFieldListAry(intCount)) = Trim(FieldNameToCompare) Then
                result = True
                Exit For
            End If
        Next

        Return result

    End Function

#End Region

#Region "Grid Events"
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.DataType.ToLower = "int" Then
            Args.ReplacementValue = FormatNumber(Args.DataReader(Args.ColIndex), 0, TriState.False, TriState.False, TriState.False)
        End If
    End Sub
#End Region

    
End Class
