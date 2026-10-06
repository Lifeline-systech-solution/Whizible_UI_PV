'*********************************************************************
'                CSPL Code Header
' Project Name     : PBNIT  
' Module Name      : PM_EmployeeSkillsSearch
' Purpose          : The page for Emploee Skill Search
' Description      : Same as Above   
' Assumptions      :    
' Dependencies     : 
' Author           : DipaliS
' Reviewed         :
' Tested           :
' Created          : April 05, 2004 
' Revisions        :								   
'*********************************************************************
Public Class PM_EmployeeSkillsSearch
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init

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
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region "Constructor"
    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_EmployeeSkillsSearch", "AppResources")
    End Sub
#End Region

#Region "Member Variables"
    Private m_strMode As String = ""
    Private m_objGlobal As WebPages.Template.IGlobal
    Protected m_lngMasterTagID As Long
    Protected m_strViewMode As String  'Employee or Skill]
    Protected m_strPagingAlphabet As String
    Private WithEvents m_objGrid As New WebPages.Template.AdvancedGrid
    Private m_strPreviousValue As String
    Private WithEvents m_objGridForFilter As WebPages.Template.AdvancedGrid
    Private m_blnMatchFound As Boolean
    Private m_strSelectedToolID As String
    Private m_strSelectedYears As String
    Private m_strSelectedMonths As String
    Private m_strSelectedProficiency As String
    Private m_blnSelectedCoreCompetency As Boolean
    Protected m_intCheckBoxCount As Integer
    Private m_intCounter As Integer
    Private m_strToolArray() As String
    Private m_strToolDetailsArray() As String
    Private m_strMenu As String
#End Region

#Region "Procedures"
    Public Sub PageInit()
        ''Added By Vidya Jadhav ON 20/04/2017 For Unauthenticated user can view this page. 
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Of Added By Vidya Jadhav ON 20/04/2017 For Unauthenticated user can view this page. 

        'Get the View Mode i.e. either by Employee or by Skill
        'If By Employee then 'E' else 'T'
        If Trim(Request.QueryString("ViewMode")) = "" Then
            m_strViewMode = "E"
        Else
            m_strViewMode = Trim(Request.QueryString("ViewMode"))
        End If

        'Get the Page Number
        If Trim(Request.QueryString("PageNumber")) = "" Then
            m_strPagingAlphabet = "-1"
        Else
            m_strPagingAlphabet = Trim(Request.QueryString("PageNumber"))
            ' Added by MahendraV On 11:29 AM 9/4/2007 For WhizibleSEM 7.1
            ' To replace 'PLUS' to '+' for paging
            ' Start_MV_9/4/2007
            If m_strPagingAlphabet = "PLUS" Then
                m_strPagingAlphabet = m_strPagingAlphabet.Replace("PLUS", "+")
            End If
            ' End_MV_9/4/2007

        End If

        'Get the Mode i.e. View Mode or Apply Filter or Clear Filter Mode
        m_strMode = Request.QueryString("Mode")

        'If mode is ClearFilter, clear the session and set mode to ""
        If m_strMode = "ClearFilter" Then
            Session("HR_Filter") = ""
            m_strMode = ""
        End If

        '######### Page Code starts here
        'Initially when Page is loaded first time then display the Skills
        'Mode is view


        GetGlobalObject()

        m_lngMasterTagID = m_objGlobal.TagID

        If m_strMode = "" Then

            GetMenu(True)

            GetPageCaption(0)

            GetUI()

            Response.Write("</DIV>")
            Response.Write("<BR>")
            GetMenu(False)
            'Mode is Apply Filter
        ElseIf m_strMode = "ApplyFilter" Then

            GetMenuForSetFilter()

            GetPageLegend()

            GetPageCaption(1)

            GetUIForFilter()

            Response.Write("</DIV>")
            Response.Write("<BR>")
            GetMenuForSetFilter()

        End If

    End Sub

    '=====================================================================
    ' Procedure Name        : GetGlobalObject()	
    ' Purpose               : Function To Fill Global Object
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : April 2, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject
    End Sub

    '=====================================================================
    ' Procedure Name        : GetMenu()	
    ' Purpose               : Function To Draw the Menu
    ' Description           : same as above
    ' Parameters Passed     : DrawPaging as Boolean
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : April 3, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetMenu(ByVal DrawPaging As Boolean)
        Dim objMenu As WebPages.Template.StaticMenu
        Dim strPager As String
        objMenu = New WebPages.Template.StaticMenu

        'Get the Pager String
        Dim objPager As WebPages.Template.Paging
        objPager = New WebPages.Template.Paging

        If CType(CommonFunctions.General.CheckIsNothing(Session("HR_Filter")), String) <> "" Then
            ' Depending on the view mode show the alphabetical list.
            Dim strQuery As String
            strQuery = CType(Session("HR_Filter"), String)
            Dim strSpNameForPaging As String
            If m_strViewMode = "E" Then
                strSpNameForPaging = strQuery & ",-1,0"
            Else
                strSpNameForPaging = strQuery & ",-1,1"
            End If
            strSpNameForPaging = strSpNameForPaging.Replace("usp_Sel_EmployeesBasedOnSkillCriteriaChanged", "usp_Sel_tbl_PM_EmployeeSkillMatrix_for_paging")

            CheckIfAlphabetExists(strSpNameForPaging)

            strPager = objPager.DrawPaging(m_strPagingAlphabet, strSpNameForPaging)
        Else
            Dim blnToSetAlphabet As Boolean
            If m_strViewMode = "E" Then
                CheckIfAlphabetExists("exec usp_Sel_tbl_PM_EmployeeSkillMatrix_for_paging null,null,null,null,null,null,null,0")
                strPager = objPager.DrawPaging(m_strPagingAlphabet, "exec usp_Sel_tbl_PM_EmployeeSkillMatrix_for_paging null,null,null,null,null,null,null,0")
            Else
                CheckIfAlphabetExists("exec usp_Sel_tbl_PM_EmployeeSkillMatrix_for_paging null,null,null,null,null,null,null,1")
                strPager = objPager.DrawPaging(m_strPagingAlphabet, "exec usp_Sel_tbl_PM_EmployeeSkillMatrix_for_paging null,null,null,null,null,null,null,1")
            End If
        End If

        If strPager <> "" Then
            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
            strPager = MyBase.GetResourceString("PAGING_SELECT") + strPager
            MyBase.InitializeResources("AppResources.PM_EmployeeSkillsSearch", "AppResources")
        End If


        objPager = Nothing

        'Plot the Menu and the pager
        Dim arrMenu() As String = {"", _
                         MyBase.GetResourceString("MENU_CLEARFILTER"), _
                          MyBase.GetResourceString("MENU_HELP")}

        Dim arrClientSideFunctions() As String = {"SetFilter_OnClick()", "ClearFilter_OnClick()", "Help_OnClick('" & m_objGlobal.TagID & "')"}

        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_IB_APPLYFILTER_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_IB_CLEARFILTER_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_HELP_TOOLTIP")}

        'If Filter is applied ,then Change Filter,otherwise Set Filter
        If CType(CommonFunctions.General.CheckIsNothing(Session("HR_Filter")), String) <> "" Then
            arrMenu(0) = MyBase.GetResourceString("CHANGEFILTER")
        Else
            arrMenu(0) = MyBase.GetResourceString("MENU_SETFILTER")
        End If

        If DrawPaging = True Then
            objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, False, strPager)
        Else
            objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, False)
        End If

        objMenu = Nothing


    End Sub

    '=====================================================================
    ' Procedure Name        : GetMenu()	
    ' Purpose               : Function To Page Caption
    ' Description           : same as above
    ' Parameters Passed     : View
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : April 3, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetPageCaption(ByVal View As Integer)
        'If View Mode
        If View = 0 Then
            Response.Write("<BR>")
            WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal)
        End If
        'If Apply Filter Mode
        If View = 1 Then
            WebPages.Template.PageCaption.GetPageCaptions(Nothing, MyBase.GetResourceString("PAGECAPTIONFORFILTER"))
        End If
    End Sub

    '=====================================================================
    ' Procedure Name        : GetUI()	
    ' Purpose               : Function To Draw the UI for Employee Skills
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : April 3, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetUI()
        Dim strSQLQuery As String
        Response.Write("<BR>")
        Response.Write("<table CellSpacing=" & "'0'" & "width=" & "'99.9%'" & "class=" & "'clsTable'" & "><tr><td align=" & "'left'" & ">")
        'Set the Option Button for Employee depending upon the ViewMode
        If m_strViewMode = "E" Then
            CommonFunctions.HTMLControls.DrawOptionButton("optViewMode", "optEmployeeWise", , True, , , "onclick=" & "'optViewMode_onclick(&quot;E&quot;)'" & ")")
        Else
            CommonFunctions.HTMLControls.DrawOptionButton("optViewMode", "optEmployeeWise", , False, , , "onclick=" & "'optViewMode_onclick(&quot;E&quot;)'" & ")")
        End If

        'Label for Employee Option Button
        Response.Write("<font face=" & "'verdana'" & "size=" & "'1'" & ">")
        Response.Write(MyBase.GetResourceString("OPTIONEMLOYEE"))
        Response.Write("</font>")
        Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;")

        'Set the Option Button for Employee depending upon the ViewMode
        If m_strViewMode = "E" Then
            CommonFunctions.HTMLControls.DrawOptionButton("optViewMode", "optToolWise", , False, , , "onclick=" & "'optViewMode_onclick(&quot;T&quot;)'" & ")")
        Else
            CommonFunctions.HTMLControls.DrawOptionButton("optViewMode", "optToolWise", , True, , , "onclick=" & "'optViewMode_onclick(&quot;T&quot;)'" & ")")
        End If

        'Label for Skill Option Button
        Response.Write("<font face=" & "'verdana'" & "size=" & "'1'" & ">")
        Response.Write(MyBase.GetResourceString("OPTIONSKILLS"))
        Response.Write("</font>")
        Response.Write("</td></tr></table>")

        Response.Write("<DIV ID='PageDiv' style='overflow:auto;width=100%'>")

        'Set SQL for Grid=if Session has the filter appllied, then set the SQL accordingly,else do not apply filter 
        If CType(CommonFunctions.General.CheckIsNothing(Session("HR_Filter")), String) <> "" Then
            If m_strViewMode = "E" Then
                strSQLQuery = CType(CommonFunctions.General.CheckIsNothing(Session("HR_Filter")), String) & ",'" & CommonFunctions.General.BuildQueryString(m_strPagingAlphabet) & "',0"
            Else
                strSQLQuery = CType(CommonFunctions.General.CheckIsNothing(Session("HR_Filter")), String) & ",'" & CommonFunctions.General.BuildQueryString(m_strPagingAlphabet) & "',1"
            End If
        Else
            If m_strViewMode = "E" Then
                strSQLQuery = "Exec usp_Sel_tbl_PM_EmployeeSkillMatrixHyp NULL,'" & CommonFunctions.General.BuildQueryString(m_strPagingAlphabet) & "',0"
            Else
                strSQLQuery = "Exec usp_Sel_tbl_PM_EmployeeSkillMatrixHyp NULL,'" & CommonFunctions.General.BuildQueryString(m_strPagingAlphabet) & "',1"
            End If
        End If


        Dim arrActualColumnArray() As String = {"ResourceName", _
                                                "Description", _
                                                "YearsOfExperience", _
                                                "Proficiency"}

        Dim arrUserFriendlyArray() As String = {MyBase.GetResourceString("RESOURCE"), _
                                                MyBase.GetResourceString("SKILL"), _
                                                MyBase.GetResourceString("EXPERIENCE"), _
                                                MyBase.GetResourceString("PROFICIENCY")}

        'Array for Grouping by Resource
        Dim arrColumnGroup() As String = {"1", "", "", ""}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'If ViewMode Changes to "BySkill" i.e. 'T' change the arrays for grid accordingly
        If m_strViewMode = "T" Then
            arrColumnGroup(0) = "1"
            arrColumnGroup(1) = ""
            arrUserFriendlyArray(0) = MyBase.GetResourceString("SKILL")
            arrUserFriendlyArray(1) = MyBase.GetResourceString("RESOURCE")
            arrActualColumnArray(0) = "Description"
            arrActualColumnArray(1) = "ResourceName"
        End If

        'Plot the Grid

        Dim arrTDStyle() As String = {"align=left", "align=left", "align=left", "align=left"}
        If m_strViewMode = "T" Then
            arrTDStyle(0) = "align=left width=25%"
            arrTDStyle(1) = "align=left width=30%"
            arrTDStyle(2) = "align=left width=20%"
            arrTDStyle(3) = "align=left width=30%"
        End If
        Dim strGrid As String
        m_objGrid.ActualColumnArray = arrActualColumnArray
        m_objGrid.UserFriendlyColumnArray = arrUserFriendlyArray
        m_objGrid.TDStyleArray = arrTDStyle
        m_objGrid.returnHTML = True
        m_objGrid.UseSQL = MyBase.UseSQL
        m_objGrid.SQL = strSQLQuery
        m_objGrid.NoOfDataColumns = 4
        m_objGrid.GroupOnColumn = arrColumnGroup
        m_objGrid.EmptyValueReplacement = " "
        m_objGrid.DIVStyle = "'overflow:auto;Height:400'"
        'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        m_objGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strGrid = m_objGrid.DrawGrid()

        m_objGrid = Nothing
        Response.Write("<BR>")
        Response.Write(strGrid)
    End Sub
    '=====================================================================
    ' Procedure Name        : GetMenuForSetFilter()	
    ' Purpose               : Function To Draw the menu for Set Filter
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : April 3, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetMenuForSetFilter()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        Dim objMenu As WebPages.Template.StaticMenu
        objMenu = New WebPages.Template.StaticMenu

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_IB_APPLYFILTER"), _
                                        MyBase.GetResourceString("MENU_CLOSE"), _
                                         MyBase.GetResourceString("MENU_HELP")}

        Dim arrClientSideFunctions() As String = {"Show_OnClick()", "Close_OnClick()", "Help_OnClick('" & m_objGlobal.TagID & "')"}

        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_IB_APPLYFILTER_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_HELP_TOOLTIP")}

        objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, False)

        objMenu = Nothing

        MyBase.InitializeResources("AppResources.PM_EmployeeSkillsSearch", "AppResources")
    End Sub
    '=====================================================================
    ' Procedure Name        : GetPageLegend()	
    ' Purpose               : Function To Draw the page legend
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : April 3, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetPageLegend()
        Dim arrLegend() As String = {MyBase.GetResourceString("PAGE_LEGEND")}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        Response.Write(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend, True))
    End Sub
    '=====================================================================
    ' Procedure Name        : GetUIForFilter()	
    ' Purpose               : Function To Draw the UI for Set Filter
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : April 3, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetUIForFilter()
        Dim blnFilterCriteriaSet As Boolean
        Dim strSQLQuery As String
        Dim strTools() As String
        Dim strYears() As String
        Dim strMonths() As String
        Dim strProficieny() As String
        Dim strToolsRequired() As String
        Dim strCompetency() As String
        Dim intAndOrMode As Integer = 0
        Dim strTempArray() As String
        Dim sepArray As String = ","
        Dim sepCharArray() As Char = sepArray.ToCharArray
        Dim strLocationID As String = ""
        Dim strDepartmentID As String = ""
        Dim strRoleID As String = ""
        Dim strDate As String = ""
        Dim strToolList As String = ""

        m_intCheckBoxCount = 0
        If Request.QueryString("Action") = "Show" Then

            blnFilterCriteriaSet = False

            ' Build the query for the filter.				
            strSQLQuery = strSQLQuery & "Exec usp_Sel_EmployeesBasedOnSkillCriteriaChanged "

            ' The selected Location ID. 
            If Request.Form("cboLocation") = "" Then
                strSQLQuery = strSQLQuery & "NULL,"
            Else
                strSQLQuery += Request.Form("cboLocation") & ","
                blnFilterCriteriaSet = True
            End If

            ' The selected Department ID.					
            If Request.Form("cboDepartment") = "" Then
                strSQLQuery += "NULL,"
            Else
                strSQLQuery += Request.Form("cboDepartment") & ","
                blnFilterCriteriaSet = True
            End If

            ' The selected Role ID.
            If Request.Form("cboRole") = "" Then
                strSQLQuery += "NULL,"
            Else
                strSQLQuery += Request.Form("cboRole") & ","
                blnFilterCriteriaSet = True
            End If

            ' The Date by which the resource is expected to be free.
            If Request.Form("txtFreeByDate") = "" Then
                strSQLQuery += "NULL,"
            Else
                strSQLQuery += "'" & Request.Form("txtFreeByDate") & "',"
                blnFilterCriteriaSet = True
            End If

            ' The list of tools that are required to be known by the employee.
            If CommonFunctions.General.CheckIsNothing(Request.Form("chkToolRequired"), "").Length = 0 Then
                strSQLQuery = strSQLQuery & "NULL,"
            Else

                ' Build the comma separated tool list.
                ' The string should be in the following format.
                '	"Tool_ID|Years|Month|Proficiency|CoreComptency,Tool_ID|Years|Month|Proficiency|CoreComptency,...."

                strSQLQuery = strSQLQuery & "'"


                'Mybase.getformvalue("chkToolRequired")??

                'strTools = Request.Form("chkToolRequired").Split(sepCharArray)
                'strYears = Request.Form("cboYears").Split(sepCharArray)
                'strMonths = Request.Form("cboMonths").Split(sepCharArray)
                'strProficieny = Request.Form("cboProficiency").Split(sepCharArray)
                'strToolsRequired = Request.Form("chkToolRequired").Split(sepCharArray)
                strTools = MyBase.GetFormValue("chkToolRequired").Split(sepCharArray)
                strYears = MyBase.GetFormValue("cboYears").Split(sepCharArray)
                strMonths = MyBase.GetFormValue("cboMonths").Split(sepCharArray)
                strProficieny = MyBase.GetFormValue("cboProficiency").Split(sepCharArray)
                strToolsRequired = MyBase.GetFormValue("chkToolRequired").Split(sepCharArray)

                If Not (MyBase.GetFormValue("chkCoreCompetency") Is Nothing) Then
                    strCompetency = MyBase.GetFormValue("chkCoreCompetency").Split(sepCharArray)
                End If

                Dim intCount As Integer

                For intCount = 0 To strToolsRequired.Length - 1
                    strSQLQuery = strSQLQuery & strTools(intCount) & "|"
                    strSQLQuery = strSQLQuery & strYears(intCount) & "|"
                    strSQLQuery = strSQLQuery & strMonths(intCount) & "|"
                    strSQLQuery = strSQLQuery & strProficieny(intCount) & "|"
                    Dim blnExistsInComp As Boolean
                    Dim intCnt As Integer
                    If Not strCompetency Is Nothing Then
                        For intCnt = 0 To strCompetency.Length - 1
                            If strTools(intCount) = strCompetency(intCnt) Then
                                blnExistsInComp = True
                            End If
                        Next
                    End If
                    If blnExistsInComp = True Then
                        strSQLQuery = strSQLQuery & "1"
                    Else
                        strSQLQuery = strSQLQuery & "0"
                    End If
                    strSQLQuery = strSQLQuery & ","
                    blnExistsInComp = False
                Next

                strSQLQuery = Left(strSQLQuery, Len(strSQLQuery) - 1)
                strSQLQuery = strSQLQuery & "',"

                blnFilterCriteriaSet = True
            End If

            ' The option, whether all the tools must be known by the employee, 
            ' or it is enough if at least one of the tools is known.			
            If Request.Form("optAndOrMode") = "" Then
                strSQLQuery = strSQLQuery & "NULL"
            Else
                strSQLQuery = strSQLQuery & Request.Form("optAndOrMode")
            End If

            If blnFilterCriteriaSet = True Then
                Session("HR_Filter") = strSQLQuery
            Else
                Session("HR_Filter") = ""
            End If

            'Write the Script that closes current window and refreshes the parent with the filter selected
            Dim strScript As String

            strScript = "<script language=" & """javascript""" & ">" & _
                        "var objParent;" & vbCrLf & _
                        "objParent=GetParentFormReference(" & "'frmPM_EmployeeSkillsSearch'" & ");" & vbCrLf & _
                        "objParent.action=" & """PM_EmployeeSkillsSearch.aspx?PageNumber=" & m_strPagingAlphabet & "&ViewMode=" & m_strViewMode & "&MasterTagID=" & m_lngMasterTagID & """" & _
                        vbCrLf & "objParent.submit();" & _
                        vbCrLf & "window.close();" & _
                        vbCrLf & "</script>)"
            '"objparentform=GetParentFormReference(objform);" & _
            'PageNumber=""" & "+" & """<%=m_strPagingAlphabet%>""" & " +" & """&ViewMode= +" & """<%=m_strViewMode%>""" & ";" & _    
            ' "objparentform.action =" & """PM_EmployeeSkillsSearch.aspx?PageNumber=""" & "+" & """<%=m_strPagingAlphabet%>""" & " +" & """&ViewMode= +" & """<%=m_strViewMode%>""" & ";" & _
            'vbCrLf & "objform.submit();" & _

            Response.Write(strScript)
        End If

        intAndOrMode = 0

        'Get the LocationID,DepartmentID,RoleId,Date,And AndOrMode for SQL
        If CType(CommonFunctions.General.CheckIsNothing(Session("HR_Filter")), String) <> "" Then

            strTempArray = CType(Session("HR_Filter"), String).Split(sepCharArray, 5)

            strLocationID = Trim(Mid(strTempArray(0), InStrRev(strTempArray(0), " "), Len(strTempArray(0))))
            If strLocationID = "NULL" Then
                strLocationID = ""
            End If

            strDepartmentID = Trim(strTempArray(1))
            If strDepartmentID = "NULL" Then
                strDepartmentID = ""
            End If

            strRoleID = Trim(strTempArray(2))
            If strRoleID = "NULL" Then
                strRoleID = ""
            End If

            strDate = Trim(strTempArray(3))
            If strDate = "NULL" Then
                strDate = ""
            Else
                strDate = CommonFunctions.Dates.GetDate(CType(Mid(strDate, 2, Len(strDate) - 2), Date))
            End If

            strTempArray(4) = Trim(strTempArray(4))
            intAndOrMode = CType(Mid(strTempArray(4), InStrRev(strTempArray(4), ",") + 1, 1), Integer)

            If InStr(1, strTempArray(4), "'") <> 0 Then
                strToolList = Mid(strTempArray(4), InStr(1, strTempArray(4), "'") + 1, InStrRev(strTempArray(4), "'") - 2)
            End If

        End If
        Response.Write("<BR>")
        'Build the UI to set the Filter
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        Response.Write("<table WIDTH=" & "'99.9%'" & " cellspacing=" & "'0'" & " class=" & "'clsTable'" & "><tr><td class=" & "'clsTDOdd'" & "align=" & "'left'" & "colspan=" & "'6'" & ">")
        'Date for free resource
        Response.Write(MyBase.GetResourceString("RESOURCE_FREE"))
        CommonFunctions.HTMLControls.DrawDateControl("txtFreeByDate", "txtFreeByDate", , , strDate, , "frmPM_EmployeeSkillsSearch")
        Response.Write("</td></tr><tr><td colspan='6'>&nbsp;</td></tr><tr><td colspan='6'><font face=" & "'Verdana'" & " size=" & "'1'" & ">")
        'Additional Filtering Criteria
        Response.Write(MyBase.GetResourceString("CRITERIA"))
        Response.Write("</font></td></tr><tr><td class='clsTDOdd' align='right'>")
        'Location
        Response.Write(MyBase.GetResourceString("LOCATION"))
        Response.Write("</td><td class='clsTDOdd'>")
        CommonFunctions.HTMLControls.DrawComboBox("cboLocation", "usp_Sel_PM_LocationList", 100, strLocationID, , True)
        Response.Write("</td><td class=" & "'clsTDOdd'" & ">")
        'Department
        Response.Write(MyBase.GetResourceString("DEPARTMENT"))
        Response.Write("</td><td class=" & "'clsTDOdd'" & ">")
        CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "usp_Sel_PM_DepartmentList", 100, strDepartmentID, , True)
        Response.Write("</td><td class=" & "'clsTDOdd'" & " align=" & "'right'" & ">")
        'Role
        Response.Write(MyBase.GetResourceString("ROLE"))
        Response.Write("</td><td class=" & "'clsTDOdd'" & ">")
        CommonFunctions.HTMLControls.DrawComboBox("cboRole", "usp_Sel_tbl_PM_Role", 160, strRoleID, , True)
        Response.Write("</td></tr></table>")
        Response.Write("<table CellSpacing=" & "'0'" & "width=" & "'99.9%'" & "class=" & "'clsTable'" & ">" & "<tr><td align=" & "'left'" & " width=" & "'5%'" & " valign=" & "'top'" & ">")
        'And Or Mode
        If intAndOrMode = 0 Then
            CommonFunctions.HTMLControls.DrawOptionButton("optAndOrMode", "optAndMode", , True, "0")
        Else
            CommonFunctions.HTMLControls.DrawOptionButton("optAndOrMode", "optAndMode", , False, "0")
        End If
        Response.Write("</td><td align=" & "'left'" & " width=" & "'45%'" & " valign=" & "'top'" & "><font face=" & "'verdana'" & " size=" & "'1'" & ">")
        Response.Write(MyBase.GetResourceString("FILTEROPT1"))
        Response.Write("</font></td><td align=" & "'left'" & " width=" & "'5%'" & " valign=" & "'top'" & ">")
        If intAndOrMode = 1 Then
            CommonFunctions.HTMLControls.DrawOptionButton("optAndOrMode", "optOrMode", , True, "1")
        Else
            CommonFunctions.HTMLControls.DrawOptionButton("optAndOrMode", "optOrMode", , False, "1")
        End If
        Response.Write("</td><td align=" & "'left'" & " width=" & "'45%'" & " valign=" & "'top'" & "><font face=" & "'verdana'" & " size=" & "'1'" & ">")
        Response.Write(MyBase.GetResourceString("FILTEROPT2"))
        Response.Write("</font></td></tr></table><br><font face=" & "'verdana'" & " size=" & "'1'" & ">")
        'Criterila Label
        Response.Write(MyBase.GetResourceString("SKILLCRITERA"))
        Response.Write("</font>")
        m_intCounter = 0

        m_strToolArray = strToolList.Split(sepCharArray)

        'Get the selected values for the first row if any 
        If m_intCounter <= m_strToolArray.GetUpperBound(0) And strToolList <> "" Then
            m_strToolDetailsArray = Split(m_strToolArray(m_intCounter), "|")
            m_strSelectedToolID = m_strToolDetailsArray(0)
            m_strSelectedYears = m_strToolDetailsArray(1)
            m_strSelectedMonths = m_strToolDetailsArray(2)
            m_strSelectedProficiency = m_strToolDetailsArray(3)
            If m_strToolDetailsArray(4) = "1" Then
                m_blnSelectedCoreCompetency = True
            Else
                m_blnSelectedCoreCompetency = False
            End If
        End If

        Response.Write("<DIV ID='PageDiv' style='overflow:auto;width=100%'>")

        'Draw the Grid
        Dim strSQL As String
        strSQL = "Exec usp_Sel_tbl_PM_Tools"
        Dim arrActualColumnArray() As String = {"Description", _
                                                "", _
                                                "", _
                                                "", _
                                                "", _
                                                ""}

        Dim arrUserFriendlyArray() As String = {MyBase.GetResourceString("SKILL"), _
                                                MyBase.GetResourceString("YEARS"), _
                                                MyBase.GetResourceString("MONTHS"), _
                                                MyBase.GetResourceString("PROFICIENCY"), _
                                                MyBase.GetResourceString("COMP"), _
                                                MyBase.GetResourceString("SELECT")}

        'Column Grouping
        Dim arrCheckBox() As String = {"", "", "", "", "chkCoreCompetency", ""}
        Dim arrTDStyle() As String = {"align=left", "align=center", "align=center", "align=center", "align=center", "align=center"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        m_objGridForFilter = New WebPages.Template.AdvancedGrid
        m_objGridForFilter.ActualColumnArray = arrActualColumnArray
        m_objGridForFilter.UserFriendlyColumnArray = arrUserFriendlyArray
        m_objGridForFilter.CheckBoxIDArray = arrCheckBox
        m_objGridForFilter.BooleanFalseHTML = "No" '|false | <img src='../../images/cross.gif'>
        m_objGridForFilter.BooleanTrueHTML = "Yes" '|true | <img src='../../images/check.gif'>
        m_objGridForFilter.NoOfDataColumns = 1
        m_objGridForFilter.UseSQL = MyBase.UseSQL
        m_objGridForFilter.PrimaryKey = "ToolID"
        m_objGridForFilter.SQL = "Exec usp_Sel_tbl_PM_Tools"
        m_objGridForFilter.TDStyleArray = arrTDStyle
        m_objGridForFilter.DIVStyle = "'overflow:auto;Height:400'"
        m_objGridForFilter.EmptyValueReplacement = " "
        'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        m_objGridForFilter.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        m_objGridForFilter.DrawGrid()
        m_objGridForFilter = Nothing

    End Sub
    '=====================================================================
    ' Procedure Name        : CheckIfAlphabetExists()	
    ' Purpose               : If alphabet does not exist in current selected list, then set it to -1
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : April 8, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub CheckIfAlphabetExists(ByVal SQL As String)
        Dim drPaging As IDataReader
        Dim blnToSetAlphabet As Boolean = False
        drPaging = CommonFunctions.Data.GetDataReader(SQL, MyBase.UseSQL)
        While drPaging.Read
            If m_strPagingAlphabet.ToLower = CType(drPaging.Item(0), String).ToLower Then
                blnToSetAlphabet = True
            End If
        End While
        If blnToSetAlphabet = False Then
            m_strPagingAlphabet = "-1"
        End If
        CommonFunction.Data.DisposeDataReader(drPaging)
    End Sub
#End Region

#Region "Grid Events"
    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
        'If experience is 0 do not display the row
        If CType(Args.DataReader("YearsOfExperience"), Integer) = 0 And CType(Args.DataReader("MonthsOfExperience"), Integer) = 0 Then
            Cancel = True
        End If
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        'Build the String for Experience
        If Args.ColIndex = 2 Then
            Dim strToBeReplaced As String = ""
            If CType(Args.DataReader("YearsOfExperience"), Integer) > 1 Then
                strToBeReplaced = strToBeReplaced & CType(Args.DataReader("YearsOfExperience"), String) & " years "
            ElseIf CType(Args.DataReader("YearsOfExperience"), Integer) = 1 Then
                strToBeReplaced = strToBeReplaced & CType(Args.DataReader("YearsOfExperience"), String) & " year "
            End If
            If CType(Args.DataReader("MonthsOfExperience"), Integer) > 1 Then
                strToBeReplaced = strToBeReplaced & CType(Args.DataReader("MonthsOfExperience"), String) & " months "
            ElseIf CType(Args.DataReader("MonthsOfExperience"), Integer) = 1 Then
                strToBeReplaced = strToBeReplaced & CType(Args.DataReader("MonthsOfExperience"), String) & " month "
            End If

            If strToBeReplaced <> "" Then
                Cancel = True
                Args.StringToBeInserted = "<td >" & strToBeReplaced & "</td>"
            End If
        End If

        'For the Hyperlink of Show Details
        If Args.ColIndex = 0 And m_strViewMode <> "T" Then
            Args.ApplyHTMLEncode = False
        End If
        If Args.ColIndex = 3 Then

        End If
    End Sub
    Private Sub m_objGridForFilter_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGridForFilter.DataRowTD_BeforePrint

        Dim strComboYears As String
        Dim strComboMonths As String
        Dim strComboProficieny As String
        Dim strCheckBoxForSelect As String

        m_blnMatchFound = False

        'Build the Strings for the combo box to be inserted
        If CType(Args.DataReader("ToolID"), String) = m_strSelectedToolID Then
            m_blnMatchFound = True
        End If

        If m_blnMatchFound = True Then
            strComboYears = CommonFunctions.HTMLControls.DrawComboBox("cboYears", "Exec usp_Sel_GetYears 0,30", , m_strSelectedYears, "", False, True)
            strComboMonths = CommonFunctions.HTMLControls.DrawComboBox("cboMonths", "Exec usp_Sel_GetYears 0,11", , m_strSelectedMonths, "", False, True)
            strComboProficieny = CommonFunctions.HTMLControls.DrawComboBox("cboProficiency", "Exec usp_Sel_tbl_HR_Parameters 7", 180, m_strSelectedProficiency, "", True, True)
        Else
            strComboYears = CommonFunctions.HTMLControls.DrawComboBox("cboYears", "Exec usp_Sel_GetYears 0,30", , "0", "disabled", False, True)
            strComboMonths = CommonFunctions.HTMLControls.DrawComboBox("cboMonths", "Exec usp_Sel_GetYears 0,11", , "0", "disabled", False, True)
            strComboProficieny = CommonFunctions.HTMLControls.DrawComboBox("cboProficiency", "Exec usp_Sel_tbl_HR_Parameters 7", 180, "0", "disabled", True, True)
        End If

        'Insert hidden text box for description Field
        If Args.ColIndex = 0 Then
            Dim strHiddenTextBox As String
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHiddenTextBox = CommonFunctions.HTMLControls.DrawTextBox("txtToolDescription", "txtToolDescription", , , , CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("Description")), String), , , , , , True, , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Args.StringToBeInserted = strHiddenTextBox
        End If

        'Years
        If Args.ColIndex = 1 Then
            Cancel = True
            Args.StringToBeInserted = "<td align=center>" & strComboYears & "</td>"
        End If
        'Months
        If Args.ColIndex = 2 Then
            Cancel = True
            Args.StringToBeInserted = "<td align=center>" & strComboMonths & "</td>"
        End If
        'Proficiency
        If Args.ColIndex = 3 Then
            Cancel = True
            Args.StringToBeInserted = "<td align=center>" & strComboProficieny & "</td>"
        End If
        'Disable or check the check box for Core Competency
        If Args.ColIndex = 4 Then
            If m_blnSelectedCoreCompetency = True And m_blnMatchFound = True Then
                Args.IsCheckBoxChecked = True
            End If
            If Not m_blnMatchFound Then
                Args.IsCheckBoxDisabled = True
            End If
        End If

        'Draw the checkbox for Select
        If Args.ColIndex = 5 Then
            Dim strOnClick As String
            Cancel = True
            strOnClick = "onclick= " & "'chkToolRequired_onclick(" & m_intCheckBoxCount & ")'"
            If m_blnMatchFound Then
                strOnClick = strOnClick & " checked"
            End If
            strCheckBoxForSelect = CommonFunctions.HTMLControls.DrawCheckBox("chkToolRequired", "chkToolRequired", , , CType(Args.DataReader("ToolID"), String), , strOnClick, True)
            Args.StringToBeInserted = "<td align=center>" & strCheckBoxForSelect & "</td>"
        End If


    End Sub

    Private Sub m_objGridForFilter_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGridForFilter.DataRowTR_AfterPrint
        'Get the Selected values for next row to be drawn
        m_intCheckBoxCount = m_intCheckBoxCount + 1
        If m_blnMatchFound = True Then
            m_intCounter = m_intCounter + 1
            If m_intCounter <= m_strToolArray.GetUpperBound(0) Then
                m_strToolDetailsArray = Split(m_strToolArray(m_intCounter), "|")
                m_strSelectedToolID = m_strToolDetailsArray(0)
                m_strSelectedYears = m_strToolDetailsArray(1)
                m_strSelectedMonths = m_strToolDetailsArray(2)
                m_strSelectedProficiency = m_strToolDetailsArray(3)
                If m_strToolDetailsArray(4) = "1" Then
                    m_blnSelectedCoreCompetency = True
                Else
                    m_blnSelectedCoreCompetency = False
                End If
            End If
        End If

    End Sub
    Private Sub m_objGridForFilter_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles m_objGridForFilter.ColumnHeaderTR_BeforePrint
        'Column Header for grouping
        Args.StringToBeInserted = "<TR class=clsTrColumnHeader><TD></TD><TD colspan=2 align=center>" & MyBase.GetResourceString("MINEXP") & "</TD><TD></TD> <TD></TD> <TD></TD></TR>"
    End Sub
    ''Added by Yogesh J on 10-Feb-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_ProjectDetails_OnClick(EmployeeID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of addition by Yogesh J on 10-Feb-2016
#End Region





End Class
