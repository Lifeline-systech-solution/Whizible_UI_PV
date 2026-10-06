Public Class PRO_ProjectClosure
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

#Region " Initialized Variables "
    Private WithEvents m_objPaging As New WebPages.Template.Paging
    Private WithEvents m_objPageCaption As New WebPage.UI.cPageCaption
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    'Private cObjSectionTitle As WebPage.Templates.SectionTitle

    Protected intProjClosureAnalysisReportID As Double
    Private m_strPagingAlphabet As String = ""
    Private strMode As String
    Private intErrorNumber As String
    Private intTagID As String = "708"
    Private m_strParamUserName As String
    Private strSQLQuery, strLinkQuery As String
    Private drResult As IDataReader
    Private intUserID, intLevel As String
    Private strASCOrDESC As String = "ASC"
    Private strSortBy As String = "ProjectID"
    Private strPageNumber As String
    Protected intProjectID As String
    Protected intAnalysisID As Integer
    Protected m_strWindowTitle As String
    Private m_strEmployeeID As String
    Protected m_PKToken1 As String = ""
    Protected m_strParamMasterTagID As String
    Protected m_strParamFromWhere As String
    Protected m_PKToken As String = ""
    Protected m_strToken As String = ""
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccess As WebPages.Security.cAccessRights

#End Region

#Region " Constructor "
    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PRO_ProjectClosure", "AppResources")
    End Sub
#End Region

#Region " Page Load Functions "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'm_strWindowTitle = MyBase.GetResourceString("PAGE_TITLE")
    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : the main function to initialize the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 25, 2004
        ' Revisions             :
        '=====================================================================

        m_strParamUserName = CType(Request.QueryString("UserName"), String)

        '--Following variables are used to process the data in different modes
        Dim intHelpId, strSql, rsResult, strQuery As String
        Dim drStatus As IDataReader

        GetGlobalObject()
        m_objAccess = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccess.GetAccess()

        intProjClosureAnalysisReportID = CommonFunction.Application.ProjectClosureAnalysisReportID
        'strMode = Request("Mode")
        strMode = Request.QueryString("Mode")

        '--If Request Mode is blank then pass the mode as Showlist	
        If Trim(strMode) = "" Then
            strMode = "ShowList"
        End If

        '--Extract the values from query string	
        intProjectID = Request("ProjectID")
        If (intProjectID = "") Then
            intProjectID = MyBase.GetFormValue("txthdnProjectID")
        End If

        strPageNumber = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("PageNumber"))
        intLevel = CType(Session("intRoleLevel"), String)
        intUserID = CType(Session("intUserID"), String)
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txthdnProjectID", "txthdnProjectID", , , , intProjectID, , , , , , True, , True, EnableHTMLEncode:=True))
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        '--Set the values to the sort by field and sort order
        'If strMode="ShowList" Then
        '--Set the values to the variables for ascending or descending order and sortby 
        strSortBy = Request("txtSortByFieldName")
        strASCOrDESC = Request("txtASCorDESC")
        If strPageNumber = "" Then strPageNumber = "-1"
        If strSortBy = "" Then strSortBy = "ProjectName"
        If strASCOrDESC = "" Then strASCOrDESC = "ASC"
        'End IF


        If strMode <> "ShowList" And strMode <> "CloseProject" Then

            '--To check if entry is already made into tbl_Pdb_QuantitativeGoals then show the links 
            strSql = "Exec usp_Sel_AreQuantitativeGoalsSet " & intProjectID
            drResult = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
            'Response.Write "Query : " & strSql 
            If drResult.Read Then
                If CType(CommonFunctions.Data.CheckIsDBNull(drResult("Status"), ""), String) = "Yes" Then
                    strMode = "Edit"
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drResult)
        End If

        '--mode is gather data
        If Trim(strMode) = "GatherData" Or strMode = "Edit" Or strMode = "CloseProject" Then
            '--To insert the new record into the table tbl_PDB_ProjectAnalysis
            If strMode = "GatherData" Then
                strSql = "Exec usp_PDB_ProjectAnalysis_MileStoneAndProjectClosureAnalysis " & intProjectID
                CommonFunction.Data.InsertOrUpdateData(strSql, MyBase.UseSQL)

            End If

            '--to get the new analysis id 
            strSql = "Exec usp_Sel_PDB_GetAnalysisID " & intProjectID
            drResult = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
            If drResult.Read Then
                intAnalysisID = CType(CommonFunctions.Data.CheckIsDBNull(drResult("AnalysisID"), "0"), Integer)
            End If
            CommonFunctions.Data.DisposeDataReader(drResult)
            '--if mode is close project then first check if all necessary entries are done then only allow to close the project
            If strMode = "CloseProject" Then
                strSql = "Exec usp_CheckProjectClosuredetailsEntered " & intAnalysisID
                drStatus = CommonFunction.Data.GetDataReader(strSql, MyBase.UseSQL)

                If drStatus.Read Then
                    Do
                        intErrorNumber = intErrorNumber & CType(CommonFunctions.Data.CheckIsDBNull(drStatus("Status"), ","), String) & ","
                    Loop While drStatus.Read
                    strMode = "Error"
                Else
                    'Code to be written for the project closure process

                    strSql = "Exec usp_UpdateProjectstatusToCloseProject " & intProjectID
                    CommonFunctions.Data.InsertOrUpdateData(strSql, MyBase.UseSQL)
                    strMode = "ShowList"
                End If
                CommonFunction.Data.DisposeDataReader(drStatus)
            End If
        End If

        If Not Page.IsPostBack Then
            strPageNumber = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidPageNo"))
        Else
            strPageNumber = CommonFunctions.General.CheckIsNothing(Request.QueryString("PageNumber"))
        End If
        If strPageNumber = "" Then strPageNumber = "-1"
        If strMode = "ShowList" Then
            DrawMenu("Top")
        Else
            DrawMenu("Details")
        End If

        If strMode = "ShowList" Then
            DrawGrid()
        ElseIf (strMode = "AnalysisDetails" Or strMode = "GatherData" Or strMode = "Edit" Or strMode = "Error") Then
            DrawPage()
        End If
        'Closed Main PageDiv
        CommonFunction.General.WriteHTML("</div>")
        DrawMenu("Bottom")

        If strMode = "Error" Then
            Dim strMessage As String
            Dim intIndex As String()
            Dim intCountError As Integer
            strMessage = "Select the respective link to enter the analysis details data for \n"
            intIndex = Split(intErrorNumber, ",")
            For intCountError = 0 To UBound(intIndex)
                Select Case intIndex(intCountError)
                    Case "1"
                        strMessage = strMessage & "Status of quantitative goals \n"
                    Case "2"
                        strMessage = strMessage & "Conclusions\n"
                    Case "3"
                        strMessage = strMessage & "Process assets\n"
                    Case "4"
                        strMessage = strMessage & "Information about archivals"
                End Select
            Next
            CommonFunctions.General.WriteHTML("<script Language=Javascript>")
            CommonFunctions.General.WriteHTML("alert('" + strMessage + "');")
            CommonFunctions.General.WriteHTML("</script>")
        End If

        m_objGlobal = Nothing
        m_objAccess = Nothing
        m_objMenu = Nothing
        m_objPaging = Nothing
        m_objPageCaption = Nothing
    End Sub
#End Region

#Region " Plots the Menu and Section Title"
    Private Sub DrawMenu(ByVal strLocation As String)
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 25, 2004
        ' Revisions             :
        '=====================================================================


        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML
        Dim strTitle As String = ""                     'Used to store the title of the page
        Dim strPageAlphabets As String = ""             'Stores paging alphabets in this var

        If strLocation = "Top" And strMode = "ShowList" Then
            If Trim(strPageNumber) = "" Then strPageNumber = ""
            'Commented and Added by Vidya Jadhav on 16th-Aug-2016 purpose::Pagination not coming properly
            'strLinkQuery = "Exec usp_sel_Project_Closure " & intUserID & "," & intLevel
            'strLinkQuery = strLinkQuery & ",'-1','ProjectName','ASC'"
            strLinkQuery = "Exec usp_sel_Project_Closure_Forpaging " & intUserID & "," & intLevel
            strLinkQuery = strLinkQuery & ",'-1','ProjectName','ASC'"
            'End Of Commented and Added by Vidya Jadhav on 16th-Aug-2016 purpose::Pagination not coming properly
            
            strPageAlphabets = m_objPaging.DrawPagingWithEvents(strPageNumber, strLinkQuery, "Select ", , "ProjectName", True)
            If strPageAlphabets = "" Then strPageNumber = "-1"
        End If

        If strMode <> "ShowList" Then
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_BACK"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("TOOLTIP_MENU_BACK"))
            arrClientSideFunctionList.Add("Back_OnClick('" & strPageNumber & "')")
        End If

        arrMenuCaptionsList.Add("?")
        arrMenuToolTipsList.Add(MyBase.GetResourceString("TOOLTIP_MENU_HELP"))
        arrClientSideFunctionList.Add("Help_OnClick('708')")

        m_objMenu = New WebPages.Template.StaticMenu

        If strLocation = "Top" Then
            strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True, strPageAlphabets)
        Else
            strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        End If

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing


        CommonFunctions.General.WriteHTML(strMenu)

        If strLocation <> "Bottom" Then
            DrawPageCaption()
        End If

    End Sub

    Private Sub DrawPageCaption()
        '=====================================================================
        ' Procedure Name        : DrawPageCaption()	
        ' Purpose               : To plot the page caption
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : March 16, 2004
        ' Revisions             :
        '=====================================================================

        Dim objHeaderFooter As New WebPages.Template.HeaderFooter
        CommonFunctions.General.WriteHTML("<DIV id='PageDiv' style='Overflow:auto;width:100%'><br>")
        If strMode = "ShowList" Then
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        Else
            '--To display thre page name
            m_objPageCaption.LeftPageCaption = MyBase.GetResourceString("SECTION_TITLE")
            m_objPageCaption.returnHTML = True
            CommonFunctions.General.WriteHTML(m_objPageCaption.DrawPageCaption())
        End If

        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        CommonFunctions.General.WriteHTML(objHeaderFooter.DrawHeaderFooter(m_objGlobal, True))
        objHeaderFooter = Nothing
    End Sub

#End Region

#Region " Generic Functions "
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
        ' Author                : PrasannaP
        ' Created               : Feb 24, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
#End Region

#Region " Grid and Page Plotting "

    Private Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : PlotPage()	
        ' Purpose               : Plots the project closure details on the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Mar 11, 2004
        ' Revisions             :
        '=====================================================================
        Dim drPMAnalysis As IDataReader
        Dim drReadyForClosure As IDataReader
        Dim strStatus As String

        strSQLQuery = "Exec usp_Sel_Prs_tbl_Pm_Project " & CStr(intProjectID)
        drResult = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drResult.Read Then
            CommonFunctions.General.WriteHTML("<Div id='DivProjects' style='Overflow:auto;width:100%;Height:460px'>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE class=clsTable cellspacing=0 width='99.9%' style='WIDTH: 100%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<Tr>")
            CommonFunction.General.WriteHTML("<TD class=clsTDOdd align=left>")
            CommonFunction.General.WriteHTML("<B>" + MyBase.GetResourceString("PROJECT_NAME") + " :</B> " + CType(CommonFunctions.Data.CheckIsDBNull(drResult("ProjectName"), ""), String))
            CommonFunction.General.WriteHTML("</Td>	")
            CommonFunction.General.WriteHTML("</Tr>")
            CommonFunction.General.WriteHTML("<Tr>")
            CommonFunction.General.WriteHTML("<TD class=clsTDOdd align=left>")
            CommonFunction.General.WriteHTML("<B>" + MyBase.GetResourceString("PROJECT_MANAGER") + " : </B>" + CType(CommonFunctions.Data.CheckIsDBNull(drResult("ProjectManager"), ""), String))
            CommonFunction.General.WriteHTML("</Td>	")
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("</Tr>")
            CommonFunction.General.WriteHTML("</Table>")
        End If
        CommonFunction.Data.DisposeDataReader(drResult)
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunction.General.WriteHTML("<TABLE class=clsTable width='99.9%' style='WIDTH: 100%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        If strMode = "GatherData" Or strMode = "Edit" Or strMode = "Error" Then
            DrawSection(MyBase.GetResourceString("STEP1"), "1")
            CommonFunction.General.WriteHTML("<div id=DivStep1>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE Class=clsTable cellspacing=0 width='99.9%'>	")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            CommonFunction.General.WriteHTML("<TR>")
            CommonFunction.General.WriteHTML("<TD class = clsTdODD align = left >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")

            CommonFunction.General.WriteHTML("<A  href='JavaScript:CallGatherData()'>")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("STEP1_GATHER_DATA") + "</A></FONT> </TD></TR>")
            CommonFunction.General.WriteHTML("</TABLE></BR></div>")

            DrawSection(MyBase.GetResourceString("STEP2"), "2")
            CommonFunction.General.WriteHTML("<div id=DivStep2>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE Class=clsTable cellspacing=0 width='99.9%'>	")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TD class=clsTDODD align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A href ='Javascript:ShowProjectCLosureReport(" + intProjectID + ")'>" + MyBase.GetResourceString("STEP2_CLOSURE_REPORT") + " </A></Td>	")
            CommonFunction.General.WriteHTML("</TR>")
            CommonFunction.General.WriteHTML("</TABLE></div></BR>")

            DrawSection(MyBase.GetResourceString("STEP3"), "3")
            CommonFunction.General.WriteHTML("<div id=DivStep3>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE Class=clsTable cellspacing=0 width='99.9%' >")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            ''Added by Yogesh J on 10-Feb-2016 to generate token
            m_PKToken = CommonFunctions.Security.Token.GetToken(CType(intAnalysisID, String) + CType(Session("intUserID"), String) + "0" + "0" + CType(intProjectID, String))

            ' m_PKToken = CommonFunctions.Security.Token.GetToken(CType(Session("intUserID"), String) + CType(intAnalysisID, String) + CType(intProjectID, String) + "0" + "0")
            ''End of addition by Yogesh J on  10-Feb-2016 to generate token
            CommonFunction.General.WriteHTML("<Tr>")
            CommonFunction.General.WriteHTML("<TD class=clsTDODD align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A href = 'javascript:LinkOnclick(""Assets""," + CStr(intAnalysisID) + "," + CStr(intProjectID) + " )'>" + MyBase.GetResourceString("STEP3_PROCESS_ASSETS") + " </A></Td>")
            CommonFunction.General.WriteHTML("</Tr>")
            CommonFunction.General.WriteHTML("<Tr>")

            CommonFunction.General.WriteHTML("<TD class=clsTDODD align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A href = 'javascript:LinkOnclick(""Archivals""," + CStr(intAnalysisID) + "," + CStr(intProjectID) + ")'>" + MyBase.GetResourceString("STEP3_INFO_ARCHIVAL") + " </A></Td>")
            CommonFunction.General.WriteHTML("</Tr>")
            CommonFunction.General.WriteHTML("<Tr>")

            CommonFunction.General.WriteHTML("<TD class=clsTDODD align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A href = 'javascript:LinkOnclick(""Goals""," + CStr(intAnalysisID) + "," + CStr(intProjectID) + ")'>" + MyBase.GetResourceString("STEP3_STATUS_GOALS") + "</A></Td>")
            CommonFunction.General.WriteHTML("</Tr>")
            CommonFunction.General.WriteHTML("<Tr>")

            ''Added by Yogesh J on 10-Feb-2016 to generate token
            m_strToken = CommonFunctions.Security.Token.GetToken(CType(intAnalysisID, String) + CType(Session("intUserID"), String) + "0" + "0")
            ''End of addition by Yogesh J on  10-Feb-2016 to generate token   intUserID

            CommonFunction.General.WriteHTML("<TD class=clsTDODD align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A href = 'javascript:TotalLOC(" + CStr(intAnalysisID) + ")'>" + MyBase.GetResourceString("STEP3_TOTAL_LOC") + "</A></Td>	")
            CommonFunction.General.WriteHTML("</TR>")

            CommonFunction.General.WriteHTML("</table></div></BR>")
            strSQLQuery = "Exec usp_Sel_tbl_PDB_ProjectAnalysis " & intAnalysisID
            drPMAnalysis = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)


            DrawSection(MyBase.GetResourceString("STEP4"), "4")
            CommonFunction.General.WriteHTML("<div id=DivStep4>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TABLE Class=clsTable cellspacing=0 width='99.9%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            m_PKToken1 = CommonFunctions.Security.Token.GetToken(CType(intAnalysisID, String) + CType(Session("intUserID"), String) + "0" + "0")
            If drPMAnalysis.Read Then
                If CType(CommonFunctions.Data.CheckIsDBNull(drPMAnalysis("LOC"), ""), String) = "" Then
                    Response.Write("<TR><TD class = clsTdODD align = left >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("STEP4_CAUSAL_ANALYSIS") + "</TD>")
                    Response.Write("</TR>")
                Else
                    Response.Write("<TR><TD class = clsTdODD align = left >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF = 'JavaScript: CausalAnalysis(" & CStr(intAnalysisID) & ")'>" + MyBase.GetResourceString("STEP4_CAUSAL_ANALYSIS") + "</A></TD>")
                    Response.Write("</TR>")
                End If
            Else
                Response.Write("<TR><TD class = clsTdODD align = left >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("STEP4_CAUSAL_ANALYSIS") + "</TD>")
                Response.Write("</TR>")
            End If

            CommonFunctions.Data.DisposeDataReader(drPMAnalysis)

            CommonFunction.General.WriteHTML("<Tr>")

            CommonFunction.General.WriteHTML("<TD class=clsTDODD align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A href = 'javascript:LinkMileStone(""" + CStr(intAnalysisID) + """)'>" + MyBase.GetResourceString("STEP4_CONCLUSION") + " </A></Td>")
            CommonFunction.General.WriteHTML("</TR>")
            CommonFunction.General.WriteHTML("</table></div></br>")

            DrawSection(MyBase.GetResourceString("STEP5"), "5")
            CommonFunction.General.WriteHTML("<div id=DivStep5>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE Class=clsTable cellspacing=0 width='99.9%'>	")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TR>")

            CommonFunction.General.WriteHTML("<TD class=clsTDODD align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")

            strSQLQuery = "EXEC usp_PDB_CheckReadyForClosure " & intAnalysisID
            drReadyForClosure = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

            If drReadyForClosure.Read Then
                strStatus = CType(CommonFunctions.Data.CheckIsDBNull(drReadyForClosure("Status"), ""), String)
            Else
                strStatus = "NOT COMPLETE"
            End If

            CommonFunction.Data.DisposeDataReader(drReadyForClosure)

            If Trim(strStatus) = "COMPLETE" Then

                Response.Write("<A  href='JavaScript:CloseProject(" + CStr(intProjectID) + ")'>")
                Response.Write(MyBase.GetResourceString("STEP5_CLOSE_PROJECT") + "&nbsp;</A></FONT></TD></TR>")

            Else
                Response.Write(MyBase.GetResourceString("STEP5_CLOSE_PROJECT") + "</TD></TR>")
            End If
            CommonFunction.General.WriteHTML("</table></div></br>")


        Else

            DrawSection(MyBase.GetResourceString("STEP1"), "1")
            CommonFunction.General.WriteHTML("<div id=DivStep1>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE Class=clsTable cellspacing=0 width='99.9%'>	")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TR>")

            CommonFunction.General.WriteHTML("<TD class = clsTdODD align = left >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")

            CommonFunction.General.WriteHTML("<A  href='JavaScript:CallGatherData()'>" + MyBase.GetResourceString("STEP1_GATHER_DATA") + "</A></FONT> </TD></TR>")
            CommonFunction.General.WriteHTML("</TABLE></div></BR>")

            DrawSection(MyBase.GetResourceString("STEP2"), "2")
            CommonFunction.General.WriteHTML("<div id=DivStep2>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE Class=clsTable cellspacing=0 width='99.9%'>	")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<Tr>")

            CommonFunction.General.WriteHTML("<TD class=clsTDODD align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("STEP2_CLOSURE_REPORT") + "</Td>	")
            CommonFunction.General.WriteHTML("</TR>")
            CommonFunction.General.WriteHTML("</TABLE></div></BR>")


            DrawSection(MyBase.GetResourceString("STEP3"), "3")
            CommonFunction.General.WriteHTML("<div id=DivStep3>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE Class=clsTable cellspacing=0 width='99.9%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<Tr>")

            CommonFunction.General.WriteHTML("<TD class=clsTDODD align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("STEP3_PROCESS_ASSETS") + "</Td>")
            CommonFunction.General.WriteHTML("</Tr>")
            CommonFunction.General.WriteHTML("<Tr>")

            CommonFunction.General.WriteHTML("<TD class=clsTDODD align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("STEP3_INFO_ARCHIVAL") + "</Td>")
            CommonFunction.General.WriteHTML("</Tr>")
            CommonFunction.General.WriteHTML("<Tr>")

            CommonFunction.General.WriteHTML("<TD class=clsTDODD align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("STEP3_STATUS_GOALS") + "</A></Td>")
            CommonFunction.General.WriteHTML("</Tr>")

            CommonFunction.General.WriteHTML("<Tr>")

            CommonFunction.General.WriteHTML("<TD class=clsTDODD align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("STEP3_TOTAL_LOC") + "</Td>	")
            CommonFunction.General.WriteHTML("</TR>	")
            CommonFunction.General.WriteHTML("</TABLE></div></BR>")


            DrawSection(MyBase.GetResourceString("STEP4"), "4")
            CommonFunction.General.WriteHTML("<div id=DivStep4>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE Class=clsTable cellspacing=0 width='99.9%'>	")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<Tr>")
            CommonFunction.General.WriteHTML("<TD class=clsTDODD align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("STEP4_CAUSAL_ANALYSIS") + "</Td>	")
            CommonFunction.General.WriteHTML("</Tr>")

            CommonFunction.General.WriteHTML("<Tr>")

            CommonFunction.General.WriteHTML("<TD class=clsTDODD align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("STEP4_CONCLUSION") + "</Td>")
            CommonFunction.General.WriteHTML("</Tr>")
            CommonFunction.General.WriteHTML("</TABLE></div></BR>")

            DrawSection(MyBase.GetResourceString("STEP5"), "5")
            CommonFunction.General.WriteHTML("<div id=DivStep5>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE Class=clsTable cellspacing=0 width='99.9%'>	")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TR>")
            CommonFunction.General.WriteHTML("<TD class=clsTDODD align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("STEP5") + "</TD></TR>")
            CommonFunction.General.WriteHTML("</table></div></br> ")

        End If
        CommonFunction.General.WriteHTML("</Table></Div>")

    End Sub

    Private Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : DrawGrid()	
        ' Purpose               : Plots the grid on the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 25, 2004
        ' Revisions             :
        '=====================================================================

        Dim drEmployeeID As IDataReader
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        'To store the link details while clicking on Links in grid
        Dim arrWidthArray() As String = {"style='width:40%'", "align=center", "align=center"}
        Dim arrColRowLinks() As String = {"ShowDetails(ProjectID)"}

        strSortBy = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortBy"))
        strSortBy = CommonFunctions.General.UnBuildQueryString(strSortBy)
        strASCOrDESC = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortOrder"))
        strASCOrDESC = CommonFunctions.General.UnBuildQueryString(strASCOrDESC)
        If strSortBy = "" Then strSortBy = "ProjectName"
        If strASCOrDESC = "" Then strASCOrDESC = "ASC"

        '' Set EmployeeID to 0 if not found so that no error occurs.
        'Added & Commented By Dipali V On 29th May 2020 Fir Scoll bar isssue
        'CommonFunctions.General.WriteHTML("<DIV id='PageDiv' style='Overflow:auto;width:100%;Height:460px'>")
        CommonFunctions.General.WriteHTML("<DIV id='PageDiv' style='Overflow:auto;width:100%;Height:auto'>")
        strSQLQuery = "Exec usp_sel_Project_Closure " & intUserID & "," & intLevel & ",'" & strPageNumber & "','" & strSortBy & "','" & strASCOrDESC & "'"
        'CommonFunctions.General.WriteHTML("<br><DIV id=DivList style='Overflow:auto;width=100%;Height:450'>")
        CommonFunctions.General.WriteHTML("<br><DIV id=DivList style='Overflow:auto;width=100%;Height:auto'>")
        'End of Added & Commented By Dipali V On 29th May 2020 Fir Scoll bar isssue
        ''Plots the Table for Daily Activity .
        ''-------------------------------------------------------------------
        arrColumnHeadingList.Add(MyBase.GetResourceString("PROJECT_NAME"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("LOCATION"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("EXPECTED_START_DATE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("EXPECTED_END_DATE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("TYPE"))

        arrActualColumnNames.Add("ProjectName")
        arrActualColumnNames.Add("Location")
        arrActualColumnNames.Add("ExpectedStartDate")
        arrActualColumnNames.Add("ExpectedEndDate")
        arrActualColumnNames.Add("Type")
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .NoOfDataColumns = 5
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 0
            .SortBy = strSortBy
            .SortOrder = strASCOrDESC
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .ClientSideSortFunctionName = "Sort_OnClick"
            .UseSQL = True
            .PrimaryKey = "ProjectID"
            .RowLinkArray = arrColRowLinks
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .DrawGrid()
        End With
        m_objGrid = Nothing
        CommonFunction.General.WriteHTML("<br></div>")
        CommonFunction.General.WriteHTML("</div>")

        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        'CommonFunctions.HTMLControls.DrawTextBox("txthidPageNo", "txthidPageNo", , , , strPageNumber, , , , , , True)
        'CommonFunctions.HTMLControls.DrawTextBox("txthidSortBy", "txthidSortBy", , , , strSortBy, , , , , , True)
        'CommonFunctions.HTMLControls.DrawTextBox("txthidSortOrder", "txthidSortOrder", , , , strASCOrDESC, , , , , , True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidPageNo", "txthidPageNo", , , , strPageNumber, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortBy", "txthidSortBy", , , , strSortBy, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortOrder", "txthidSortOrder", , , , strASCOrDESC, , , , , , True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
    End Sub

#End Region

#Region " Event Handling "
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
    End Sub
#End Region

    Private Sub DrawSection(ByVal strSectionTitle As String, ByVal strSectionCount As String)
        Dim cObjSectionTitle As New WebPage.Templates.SectionTitle
        CommonFunctions.General.WriteHTML("<br>" + cObjSectionTitle.GetSectionTitle(strSectionTitle, "DivStep" + strSectionCount, "DivStep" + strSectionCount + "_OnExpand", , , , , , , , True, , True, True))
        CommonFunctions.General.WriteHTML("<script language=javascript>")
        CommonFunctions.General.WriteHTML(cObjSectionTitle.ClientsideScript())
        CommonFunctions.General.WriteHTML("</script>")
        cObjSectionTitle = Nothing
    End Sub

    Private Sub m_objPaging_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PagingLink) Handles m_objPaging.Before_Link_Print
        If m_strPagingAlphabet = "" Then
            m_strPagingAlphabet = Args.CurrentLink
        ElseIf m_strPagingAlphabet = Args.CurrentLink Then
            Cancel = True
        Else
            m_strPagingAlphabet = Args.CurrentLink
        End If
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject
    End Sub

End Class
