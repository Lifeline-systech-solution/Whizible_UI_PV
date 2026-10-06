Public Class PM_ETCApproval
    Inherits WebPages.Template.WhizTemplate
    '**********************************************************************************
    '                  CSPL Code Header
    ' Project Name     :	Bhagirath
    ' Module Name      :	PM_ETCApproval.aspx
    ' Purpose          :	It will display the estimated hours for the employee.
    '						Get approval from the Autheticator for it.
    ' Description      :	
    ' Assumptions      :	
    ' Dependencies     :	None.
    ' Author           :	SuryabirD
    ' Reviewed         :	
    ' Tested           :	
    ' Created          :	Feb 26, 2004
    '**********************************************************************************
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

    Protected m_strPageTitle As String
    Protected m_lngProjectID As Long
    Protected m_lngTagID, m_lngETCID As Long
    Protected m_strSortField, m_strSortOrder As String
    Protected m_blnAddAccess, m_blnDeleteAccess, m_blnEditAccess As Boolean
    Protected m_blnMPPTasks_Selected As Boolean
    Protected m_strFromWhere, m_strSelectedType As String
    Protected m_dblLowerLimit As Double

    'Added by Sagar N. on 01-March-2019 Purpose::Whizible 2 Work field change
    Protected m_RestrictByMinHours As String
    Dim strEtc As String
    'End of adding by Sagar N on 01-March-2019 Purpose::Whizible 2 Work field change

    '' START : Commented & Modified By ParagD On 29-Aug-2006 
    '' Purpose : Whiz SP 7.2 Release
    '' We can authenticate an ETC of a closed / Onhold Project.
    '' User will be given an alert if that Particular Project is "On Hold" OR "Closed"
    Protected m_blnProjectStatus As Boolean
    Dim blnETCNodeAccess As Boolean
    '' END : Commented & Modified By ParagD On 29-Aug-2006 

    Private WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Private WithEvents m_objGrid As New WebPage.Templates.GenericGrid

    Private m_blnUseSQL As Boolean
    Private m_strMode, m_strAction As String
    Private m_objGlobal As WebPages.Template.IGlobal


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        '=====================================================================
        ' Purpose               : Initializes Page level variables.
        ' Description           : 
        '=====================================================================

        'Put user code to initialize the page here
        '-- Initialize 

        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("MODE")).ToString
        m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("ACTION")).ToString
        m_strFromWhere = Trim(Request.QueryString("FromWhere") + "")
        If m_strFromWhere = "" Then
            m_strFromWhere = "PM"
        End If

        '-- This Page can be called from DB and Tree: When called from D, the Project ID is to be taken from the QueryString
        If CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"), "0"), Long) <> 0 Then
            m_lngProjectID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"), "0"), Long)
        Else
            m_lngProjectID = CType(Session("intProjectID"), Long)
        End If

        '-- Task Type (M or O)
        If Trim(CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskType"))) <> "" Then
            If Trim(CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskType"))) = "M" Then
                m_blnMPPTasks_Selected = True
                m_strSelectedType = "M"
            Else
                m_blnMPPTasks_Selected = False
                m_strSelectedType = "O"
            End If
        Else
            m_blnMPPTasks_Selected = True
            m_strSelectedType = "M"
        End If

        '-- Sorting
        If Trim(CommonFunctions.General.CheckIsNothing(Request.QueryString("Field"))) <> "" Then
            m_strSortField = Trim(CommonFunctions.General.CheckIsNothing(Request.QueryString("Field")))
        Else
            m_strSortField = "T.TaskName"
        End If

        If Trim(CommonFunctions.General.CheckIsNothing(Request.QueryString("Order"))) <> "" Then
            m_strSortOrder = Trim(CommonFunctions.General.CheckIsNothing(Request.QueryString("Order")))
        Else
            m_strSortOrder = "ASC"
        End If
        'If m_strSortOrder = "ASC" Then m_strSortOrder = "DESC" Else m_strSortOrder = "ASC"

        Call CreateGlobalObject()

        '' START : Added By ParagD On 31-Aug-2006 
        '' Purpose : Whiz SP 7.2 Release
        Dim drTaskDelegation As IDataReader

        drTaskDelegation = CommonFunctions.Data.GetDataReader("usp_GetAccessRightsForResources " & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'417' ," & m_lngProjectID.ToString, m_blnUseSQL)
        If drTaskDelegation.Read Then
            m_blnAddAccess = CType(CommonFunctions.Data.CheckIsDBNull(drTaskDelegation("A"), "0"), Boolean)
            m_blnDeleteAccess = CType(CommonFunctions.Data.CheckIsDBNull(drTaskDelegation("D"), "0"), Boolean)
            m_blnEditAccess = CType(CommonFunctions.Data.CheckIsDBNull(drTaskDelegation("E"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(drTaskDelegation)
        '' END : Commented & Modified By ParagD On 31-Aug-2006  

        ''Added By Sagar Nipane on 01-March-2019 Purpose::Whizible 2 Work field change
        Dim drCompany As IDataReader
        drCompany = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", True)
        If drCompany.Read() Then
            m_RestrictByMinHours = CommonFunction.Data.CheckIsDBNull(drCompany("RestrictByMinHours"), "0")
        End If
        ''End of Added By Sagar Nipane on 01-March-2019 Purpose::Whizible 2 Work field change

    End Sub

    Public Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage
        ' Purpose               : Function called from the <FORM> tag
        ' Description           : Draws the Page Controls on the page
        ' Parameters Passed     : None
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Feb 26, 2004   
        ' Revisions             :
        '=====================================================================

        Dim strMenu, strCaption As String
        Dim strSQLQuery, strChecked As String
        Dim intETCCount_MPPTasks, intETCCount_AssignedTasks As Integer
        Dim dblETCHours As Double
        Dim lngTaskID As Long
        Dim strTaskName As String
        Dim drETCRequest, drETCHistory As IDataReader

        '' START : Commented & Modified By ParagD On 29-Aug-2006 
        '' Purpose : Whiz SP 7.2 Release
        '' We can authenticate an ETC of a closed / Onhold Project.
        '' User will be given an alert if that Particular Project is "On Hold" OR "Closed"
        Dim strsql1 As String
        strsql1 = "Exec usp_getProjectStatus " & m_lngProjectID.ToString
        m_blnProjectStatus = CBool(CommonFunctions.Data.GetDataScalar(strsql1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
        '' END : Commented & Modified By ParagD On 29-Aug-2006 

        '--Authenticate requests selected
        If m_strMode = "AUTHENTICATE" Then
            Call AuthenticateETC()
        End If

        '--Delete requests selected
        If m_strMode = "DELETE" Then
            Call DeleteRequests()
        End If

        '-- Process Page based on the MODE "CHANGE" or Normal ("")
        '-- Draw Page Caption
        Select Case m_strMode

            '==================================================================================
            '---   POP-UP PAGE: Change the ETC Request                                      ---
            '==================================================================================
        Case "CHANGE"

                m_lngETCID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ETCID")), Long)

                '=====================================================================
                '	SAVE THE MODIFIED ETC HOURS.
                '=====================================================================
                If m_strAction = "SAVE" Then

                    ' Get the ETCID and the Authenticated hours

                    ''Commented & Added By Sagar Nipane on 01-March-2019 Purpose::Whizible 2 Work field change
                    'dblETCHours = CType(CommonFunctions.General.CheckIsNothing(Request.Form("txtETC"), "0"), Double)
                    strEtc = CType(CommonFunctions.General.CheckIsNothing(Request.Form("txtETC"), "0"), String)
                    'strEtc = dblETCHours.ToString
                    'If strEtc = 0 Or strEtc = "" Then
                    '    strEtc = "00:00"
                    'End If


                    Dim strDecimal1 As String = ""
                    Dim strBeforeDecimal1 As String = ""

                    If strEtc.IndexOf(":") = strEtc.Length - 1 Then
                        strEtc = strEtc + "00"
                    End If

                    Dim strInd1 As String = strEtc.IndexOf(":")
                    If strInd1 = -1 Then
                        strEtc = strEtc + ":00"
                    End If

                    strBeforeDecimal1 = strEtc.Substring(0, strEtc.IndexOf(":"))
                    strDecimal1 = strEtc.Substring(strEtc.IndexOf(":") + 1, 2)
                    strEtc = strBeforeDecimal1 + ":" + strDecimal1

                    strEtc = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strEtc + "',2)", True)

                    ' Insert the Authenticated Hours for the Task in the corresponding table			
                    'CommonFunctions.Data.InsertOrUpdateData("Exec usp_tbl_ETCAutheticatedHours " + m_lngETCID.ToString + "," + dblETCHours.ToString, m_blnUseSQL)
                    CommonFunctions.Data.InsertOrUpdateData("Exec usp_tbl_ETCAutheticatedHours " + m_lngETCID.ToString + "," + strEtc.ToString, m_blnUseSQL)

                    ''End of Commented & Added By Sagar Nipane on 01-March-2019 Purpose::Whizible 2 Work field change

                    ' the following code will close the child window and refreshes the parent window
                    ' so that if u make any changes in the child window, those changes are reflected
                    ' back to the parent window	 			
                    Response.Write("<SCRIPT Language=javascript>" + vbCrLf)
                    Response.Write("window.close();" + vbCrLf)

                    Response.Write("window.opener.document.forms['frmETCAuthenticate'].action=" + Chr(34) + "PM_ETCApproval.aspx?ProjectID=" + m_lngProjectID.ToString + "&Mode=&TaskType=" + m_strSelectedType)
                    Response.Write("&MasterTagID=" + m_lngTagID.ToString + "&FromWhere=" + m_strFromWhere)
                    Response.Write(Chr(34) + ";" + vbCrLf)

                    Response.Write("window.opener.document.forms['frmETCAuthenticate'].submit();" + vbCrLf)

                    Response.Write("</SCRIPT>" + vbCrLf)
                End If


                strSQLQuery = "EXEC usp_Sel_tbl_TasksToAutheticate null , null , " + m_lngETCID.ToString
                drETCRequest = CommonFunctions.Data.GetDataReader(strSQLQuery, m_blnUseSQL)
                If drETCRequest.Read Then

                    lngTaskID = CType(CommonFunctions.Data.CheckIsDBNull(drETCRequest("TaskID")), Long)
                    strTaskName = drETCRequest("TaskName").ToString
                    dblETCHours = CType(CommonFunctions.Data.CheckIsDBNull(drETCRequest("ETC")), Double)
                End If
                CommonFunctions.Data.DisposeDataReader(drETCRequest)

                '-- Calculate Allowable Lower limit
                Dim drTask As IDataReader
                If lngTaskID > 0 Then
                    strSQLQuery = "Exec usp_Sel_GetTaskDetails " + lngTaskID.ToString
                    drTask = CommonFunctions.Data.GetDataReader(strSQLQuery, m_blnUseSQL)
                    If Not drTask.Read Then
                        ' Actual Work done.
                        If CType(CommonFunctions.Data.CheckIsDBNull(drTask("ActualWork"), "0"), Double) <> 0 Then
                            m_dblLowerLimit = m_dblLowerLimit + CType(CommonFunctions.Data.CheckIsDBNull(drTask("ActualWork"), "0"), Double)
                        End If
                        ' Minus the Estimated work gives the lower limit of ETC hours that can be requested.
                        If CType(CommonFunctions.Data.CheckIsDBNull(drTask("Work"), "0"), Double) <> 0 Then
                            m_dblLowerLimit = m_dblLowerLimit - CType(CommonFunctions.Data.CheckIsDBNull(drTask("Work"), "0"), Double)
                        End If
                    End If
                    CommonFunctions.Data.DisposeDataReader(drTask)
                End If



                '-- TOP Menu
                strMenu = DrawMenu()
                Response.Write(strMenu + "<br>")

                '-- Caption
                strCaption = MyBase.GetResourceString("PAGE_CAPTION_CHANGE")
                WebPage.Templates.PageCaption.GetPageCaptions(, strCaption, , , False)
                Response.Write("<BR>")

                '-- Task Name
                Response.Write("<Table class=clsTable Cellspacing=0 width='99.9%'><TR class=clsTREven><TD width='10%'><B>" + MyBase.GetResourceString("TASK_NAME") + "</B></TD> ")
                Response.Write("<TD width='85%'>")
                Response.Write(Server.HtmlEncode(Trim(strTaskName + "")))
                Response.Write("</TD></TR>")

                '-- ETC Hours.
                Response.Write("<TR><TD class=clsTDOdd></TD><TD class=clsTDOdd>")
                Response.Write(MyBase.GetResourceString("ETC_HOURS") + " ")
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

                'Added by Sagar Nipane on 01-March-2019 for display efforts in HH:MM Format
                strEtc = dblETCHours
                'If strEtc.IndexOf(".") = -1 Then
                '    HH = strEtc
                '    MM = "00"
                '    strEtc = HH + ":" + MM
                'Else
                '    strEtc = strEtc.Replace(".", ":")
                'End If

               

                strEtc = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + strEtc + "',1)", True)
                'End of Added by Sagar Nipane on 01-March-2019 for display efforts in HH:MM Format

                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

                'Commented by Sagar Nipane on 01-March-2019 for display efforts in HH:MM Format
                'CommonFunctions.HTMLControls.DrawTextBox("txtETC", "txtETC", , 50, 4, dblETCHours.ToString, "Right", , , , , , , , True, EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txtETC", "txtETC", , 50, 8, strEtc.ToString, "Right", , , , , , , , True, EnableHTMLEncode:=True)
                'End of Commented by Sagar Nipane on 01-March-2019 for display efforts in HH:MM Format

                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                Response.Write("</TD></TR></TABLE>")

                ' Response.Write("<Input Type=Text style='height:0px; width:0px' id=txtDummy> ")

                ' ETC History.
                'Modified By VidyaJ - Browser Issue - IssueID - 809 
                ' Response.Write("<DIV ID='divList' Style='height=90%;WIDTH:100%;OVERFLOW:auto;'>")
                'commented added by Shamkant on 18 Nov 2015
                Response.Write("<DIV ID='divList' Style='WIDTH:100%;OVERFLOW:auto;'>")
                Response.Write("<TABLE class=clsTable Cellspacing=0 width='99.9%'><TR class=clsTROdd ><TD align=left><b>" + MyBase.GetResourceString("TASK_HISTORY") + "</B></TD></TR>")

                ' DISPLAY HISTORY OF ETC REQUESTS RAISED FOR THE SELECTED TASK.
                '--------------------------------------------------------------
                strSQLQuery = "EXEC usp_Sel_HistoryFor_Selected_Task " + m_lngProjectID.ToString + "," + m_lngETCID.ToString
                drETCHistory = CommonFunctions.Data.GetDataReader(strSQLQuery, m_blnUseSQL)
                Do While drETCHistory.Read

                    ''Commented and Added By Usha Pandit on 15-March-2019 Purpose::Whizible 2 Work field change
                    'Response.Write("<TR><TD class=clsTDOdd align=right><B>" + CommonFunctions.Data.CheckIsDBNull(drETCHistory("ETC")).ToString + " hrs</B></TD><TD class=clsTDOdd> were requested by " + drETCHistory("UserName").ToString + " - <b>Status : ")
                    Dim HMETC As String = CommonFunctions.Data.CheckIsDBNull(drETCHistory("HMETC")).ToString

                    Dim strBeforeDecimal As String = ""
                    Dim strDecimal As String = ""

                    strBeforeDecimal = HMETC.Substring(0, HMETC.IndexOf(":"))
                    If strBeforeDecimal.Length = 1 Then
                        strBeforeDecimal = "0" + strBeforeDecimal
                    End If
                    strDecimal = HMETC.Substring(HMETC.IndexOf(":") + 1, 2)
                    HMETC = strBeforeDecimal + ":" + strDecimal
                    Response.Write("<TR><TD class=clsTDOdd align=right><B>" + HMETC + " hrs</B></TD><TD class=clsTDOdd> were requested by " + drETCHistory("UserName").ToString + " - <b>Status : ")
                    ''End of Added By Usha Pandit on 15-March-2019 Purpose::Whizible 2 Work field change

                    If Not CType(CommonFunctions.Data.CheckIsDBNull(drETCHistory("Authenticated"), "0"), Boolean) Then
                        Response.Write(MyBase.GetResourceString("NOT_AUTHENTICATED"))

                        ' For every ETC request made so far (excluding the current ETC request) reduce the lower limit.
                        If m_lngETCID <> CType(CommonFunctions.Data.CheckIsDBNull(drETCHistory("ETCID"), "0"), Long) Then
                            m_dblLowerLimit = m_dblLowerLimit - CType(CommonFunctions.Data.CheckIsDBNull(drETCHistory("ETC"), "0"), Double)
                        End If

                    Else
                        Response.Write(" Authenticated.")
                    End If
                    Response.Write("</B></TD></TR>")
                Loop
                CommonFunctions.Data.DisposeDataReader(drETCHistory)

                Response.Write("</TABLE>")

                Response.Write("</DIV>")
                Response.Write("<br>" + strMenu)

                '==================================================================================
                '---   MAIN PAGE: ETC Request List Page (with Task Type Option buttons)         ---
                '==================================================================================
            Case Else '-- Normal Mode (Main Page)

                '-- Page Menu
                strMenu = DrawMenu()
                Response.Write(strMenu)
                Response.Write("<br>")

                strCaption = MyBase.GetResourceString("PAGE_CAPTION_CHANGE")

                WebPage.Templates.PageCaption.GetPageCaptions(m_objGlobal, , , , False)
                Response.Write("<BR>")

                '-- Header/Footer
                Dim objHeaderFooter As New WebPages.Template.HeaderFooter
                objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
                objHeaderFooter.DrawHeaderFooter(m_objGlobal)
                objHeaderFooter = Nothing

                ' Get the ETC count of MPP Tasks.
                strSQLQuery = "usp_Sel_GetETCRequest_Count_ForDB 'M'," + m_lngProjectID.ToString
                intETCCount_MPPTasks = CType(CommonFunctions.Data.GetDataScalar(strSQLQuery, m_blnUseSQL), Integer)

                ' Get the ETC count of Assigned Tasks.
                strSQLQuery = "usp_Sel_GetETCRequest_Count_ForDB 'O'," + m_lngProjectID.ToString
                intETCCount_AssignedTasks = CType(CommonFunctions.Data.GetDataScalar(strSQLQuery, m_blnUseSQL), Integer)

                '-- Table for Selecting option buttons
                Response.Write("<table CellSpacing=0 width='99.9%' class=clsTable>")
                Response.Write("<tr>")
                Response.Write("<td align=left>")
                CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optMPPTasks", , m_blnMPPTasks_Selected, "MPP", , "  onclick=""javascript:optTaskType_onclick('M','" + m_strSortField + "','" + m_strSortOrder + "')""")

                Response.Write("<font face=verdana size=1>")
                Response.Write(MyBase.GetResourceString("MPP_TASKS") + " (" + intETCCount_MPPTasks.ToString + ")")
                Response.Write("</font>")
                Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;")

                CommonFunctions.HTMLControls.DrawOptionButton("optTaskType", "optMPPTasks", , Not (m_blnMPPTasks_Selected), , , strChecked + " onclick=""javascript:optTaskType_onclick('O','" + m_strSortField & "','" + m_strSortOrder + "')""")
                Response.Write("<font face=verdana size=1>")
                Response.Write(MyBase.GetResourceString("ASSIGNED_TASKS") + " (" + intETCCount_AssignedTasks.ToString + ")")
                Response.Write("</font>")

                Response.Write("</td>")
                Response.Write("</tr>")
                Response.Write("</table><br>")
                'Modified By VidyaJ - Browser Issue - IssueID - 809 
                ' Response.Write("<DIV ID='divList' Style='height=90%;WIDTH:100%;OVERFLOW:auto;'>")
                'commented added by Shamkant on 18 Nov 2015
                Response.Write("<DIV ID='divList' Style='WIDTH:100%;OVERFLOW:auto;'>")

                '--Plot Grid (Assigned Task Requests OR MPP Requests)
                Call PlotGrid_ForETCRequests()

                Response.Write("</DIV>")

                '-- Header/Footer
                objHeaderFooter = New WebPages.Template.HeaderFooter
                objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
                objHeaderFooter.DrawHeaderFooter(m_objGlobal)
                objHeaderFooter = Nothing

                Response.Write("<br>")
                Response.Write(strMenu)

        End Select

    End Sub


    Private Sub PlotGrid_ForETCRequests()
        '=====================================================================
        ' Procedure Name        : PlotGrid_ForETCRequests
        ' Purpose               : Show list of ETC Requests dpending upon Task Type selected (M or O)
        ' Description           : uses GenericGrid class
        ' Parameters Passed     : None
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Feb 27, 2004   
        ' Revisions             :
        '=====================================================================

        '-- To Plot the Grid for ETC Requests

        Dim strSQLQuery As String

        Dim arrstrActualList() As String = {"TaskName", "StartDate", "EndDate", "UserName", "BudgetedWork", "ActualWork", "BilledWork", "ETC_Value", "", ""}
        'Commented & Added by Sagar Nipane on 01-March-2019 for display efforts in HH:MM Format
        'Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("TASKNAME"), MyBase.GetResourceString("STARTDATE"), MyBase.GetResourceString("ENDDATE"), MyBase.GetResourceString("USERNAME"), MyBase.GetResourceString("BUDGETEDWORK"), MyBase.GetResourceString("ACTUALWORK"), MyBase.GetResourceString("BILLEDWORK"), MyBase.GetResourceString("ETC"), MyBase.GetResourceString("AUTHENTICATE"), MyBase.GetResourceString("DELETE")}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("TASKNAME"), MyBase.GetResourceString("STARTDATE"), MyBase.GetResourceString("ENDDATE"), MyBase.GetResourceString("USERNAME"), "Work (H:M)", "Actual Work (H:M)", "Billed Work (H:M)", "Estimated Time (H:M)", MyBase.GetResourceString("AUTHENTICATE"), MyBase.GetResourceString("DELETE")}
        'End of Commented & Added by Sagar Nipane on 01-March-2019 for display efforts in HH:MM Format        
        Dim arrstrCheckboxID() As String = {"", "", "", "", "", "", "", "", "chkAuthenticated", "chkDelete"}
        Dim arrstrTDStyle() As String = {"", "", "", "", " align=right ", " align=right ", " align=right ", " align=right "}
        Dim arrRowLink() As String = {"ShowWindow(ETCID)", "", "", "", "", "", "", "", "", ""}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        If m_blnMPPTasks_Selected Then
            strSQLQuery = "usp_Sel_tbl_TasksToAutheticate " + m_lngProjectID.ToString + ",'M',NULL,'" + m_strSortField + "','" + m_strSortOrder + "'"
        Else
            strSQLQuery = "usp_Sel_tbl_TasksToAutheticate " + m_lngProjectID.ToString + ",'O',NULL,'" + m_strSortField + "','" + m_strSortOrder + "'"
        End If

        With m_objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 2
            .PrimaryKey = "ETCID"
            .CheckBoxIDArray = arrstrCheckboxID
            .ColumnHeaderAlignment = "left"
            .SortBy = m_strSortField
            .SortOrder = m_strSortOrder
            .ClientSideSortFunctionName = "SortBy"
            .RowLinkArray = arrRowLink
            .SQL = strSQLQuery
            'Modified By VidyaJ - Browser Issue - IssueID - 809 
            .DIVHeight = 390
            .UseSQL = m_blnUseSQL
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

        'm_objGrid = Nothing

    End Sub

    Private Sub DeleteRequests()
        '=====================================================================
        ' Procedure Name        : DeleteRequests
        ' Purpose               : For Deleting (rejecting) the selected ETC Requests
        ' Description           : Called on Click of Delete link
        ' Parameters Passed     : None
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Feb 27, 2004   
        ' Revisions             :
        '=====================================================================
        Dim drEmailMessage As IDataReader
        Dim blnSendEmail, blnShowPopup As Boolean
        Dim intCtr As Integer
        Dim arrstrRequests() As String
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String
        Dim strSQLQuery As String

        'Fire update query
        If Trim(Request.Form("chkDelete")) <> "" Then

            ' MSG ID : 19
            ' PURPOSE: ETC Request Rejected.
            ' Get the flag status for the messaage. (i.e. 1. Whether the mail has to be sent? 2. Should a popup page must be displayed?)
            drEmailMessage = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 19", m_blnUseSQL)
            If drEmailMessage.Read Then
                blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                ' Popup mail message cannot be shown in this case as multiple mails are being sent at the same time.
                blnShowPopup = False
            End If

            CommonFunctions.Data.DisposeDataReader(drEmailMessage)

            arrstrRequests = Split(Request.Form("chkDelete"), ",")

            For intCtr = 0 To arrstrRequests.Length - 1

                If blnSendEmail = True Then
                    Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_19(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(arrstrRequests(intCtr), Long))
                    'Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                    'Added By VarunA on 2-June-2009 RequestID-20673
                    'Purpose : To have ETC mail for rejected in Slient.
                    CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                    'End By VarunA on 2-June-2009 RequestID-20673
                End If

                ' NOTE: The ETC request is being deleted after the mail is sent, 
                ' because if the record is deleted first, it will not be possible to retrieve the ETC request details for the mail.
                strSQLQuery = "EXEC usp_Del_tbl_PM_ProjectTaskETC '" + arrstrRequests(intCtr) + "'"
                Call CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, m_blnUseSQL)

            Next

            Response.Write("<script LANGUAGE=""javascript"">" + vbCrLf)
            Response.Write("var strParentPage;" + vbCrLf)
            Response.Write("try {	" + vbCrLf)
            Response.Write("strParentPage = new String();" + vbCrLf)
            Response.Write("strParentPage = opener.location.href;" + vbCrLf)
            ' If the document loaded in the parent window is the PMDashBoard.asp, then refresh the page.					
            Response.Write("if (strParentPage.toUpperCase().indexOf(""PMDASHBOARD.ASPX"") != -1)" + vbCrLf)
            Response.Write("{	opener.location.href = ""../DB/PMDashBoard.aspx?Field=ProjectName&Order=ASC&List=5"";}}" + vbCrLf)
            Response.Write("catch(e) {}" + vbCrLf)

            '// This condition will come if the parent page has been closed, of changed.
            '// Do nothing.						

            Response.Write("</script>" + vbCrLf)
        End If
    End Sub

    Private Sub AuthenticateETC()
        '=====================================================================
        ' Procedure Name        : AuthenticateETC
        ' Purpose               : Authenticates the selected ETC Request
        ' Description           : Called on Click of Authenticate link
        ' Parameters Passed     : None
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Feb 27, 2004   
        ' Revisions             :
        '=====================================================================

        Dim drEmailMessage As IDataReader
        Dim blnSendEmail, blnShowPopup As Boolean
        Dim intCtr As Integer
        Dim strSQLQuery As String
        Dim objCheckbox As Object
        Dim arrstrETCIDs() As String
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String

        objCheckbox = Request.Form("chkAuthenticated")
        ' Fire update query

        If Trim(Request.Form("chkAuthenticated")) <> "" Then

            arrstrETCIDs = Split(Request.Form("chkAuthenticated"), ",")

            ' MSG ID : 18
            ' PURPOSE: ETC Authenticated.
            ' Get the flag status for the messaage. (i.e. 1. Whether the mail has to be sent? 2. Should a popup page must be displayed?)
            drEmailMessage = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 18", m_blnUseSQL)
            If drEmailMessage.Read Then
                blnSendEmail = CType(drEmailMessage("SendMail").ToString, Boolean)
                ' Popup mail message cannot be shown in this case as multiple mails are being sent at the same time.
                blnShowPopup = False
            End If

            CommonFunctions.Data.DisposeDataReader(drEmailMessage)
            'Added by PrashantD on on 2 April 2007 for IssueID 11824
            Dim dr As IDataReader
            Dim strAlertMessage As String = ""
            'End of addition by PrashantD on 2 April 2007
            For intCtr = 0 To arrstrETCIDs.Length - 1

                strSQLQuery = "EXEC usp_tbl_ETCAuthenticateInsertion '" + arrstrETCIDs(intCtr) + "'"
                'Modified by PrashantD on 2 April 2007 for IssueID 11824
                'CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, m_blnUseSQL)
                dr = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                If dr.Read Then
                    If Not IsDBNull(dr(0)) Then
                        strAlertMessage += dr(0).ToString
                    End If
                End If
                CommonFunction.Data.DisposeDataReader(dr)
                'End of modification by PrashantD on 2 April 2007

                If blnSendEmail = True Then
                    Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_18(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(arrstrETCIDs(intCtr), Long))
                    'Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                    'Added By VarunA on 2-June-2009 RequestID-20673
                    'Purpose : To have ETC mail for accepted in Slient.
                    CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                    'End By VarunA on 2-June-2009 RequestID-20673
                End If

            Next
            'Added by PrashantD on on 2 April 2007 for IssueID 11824
            If strAlertMessage <> "" Then
                Response.Write("<script LANGUAGE='javascript'>" + vbCrLf)
                Response.Write("alert(""" + strAlertMessage + """)" + vbCrLf)
                Response.Write("</script>")
            End If
            'End of addition by PrashantD on 2 April 2007

            Response.Write("<script LANGUAGE='javascript'>" + vbCrLf)
            Response.Write(" var strParentPage;" + vbCrLf)
            Response.Write("try {" + vbCrLf)
            Response.Write("strParentPage = new String();" + vbCrLf)
            Response.Write("strParentPage = window.opener.location.href;" + vbCrLf)
            '-- If the document loaded in the parent window is the PMDashBoard.asp, then refresh the page.					
            Response.Write("if (strParentPage.toUpperCase().indexOf(""PMDASHBOARD.ASPX"") != -1) {" + vbCrLf)
            Response.Write("window.opener.location.href = ""../DB/PMDashBoard.aspx?Field=ProjectName&Order=ASC&List=5"";" + vbCrLf)
            Response.Write("}}" + vbCrLf)
            Response.Write("catch(e)" + vbCrLf)

            Response.Write("{}" + vbCrLf)
            'This condition will come if the parent page has been closed, of changed.")
            'Do nothing.			
            Response.Write("</script>")

        End If
    End Sub


    Public Sub New()
        '--construtor
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'initialize the resource file for PRO_ProjectTypeConfiguration page.
        MyBase.InitializeResources("AppResources.PM_ETCApproval", "AppResources")
    End Sub

    Private Sub CreateGlobalObject()
        '=====================================================================
        ' Function Name         : CreateGlobalObject
        ' Purpose               : Creates the Global Object for accessing TagID, FrowWhere etc.
        ' Description           : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : SuryabirD
        ' Created               : Feb 16, 2004
        ' Revisions             : 
        '=====================================================================

        'Global object
        Dim objAccess As New WebPage.Templates.AccessRights
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject

        m_lngTagID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("MasterTagID"), "0"), Long)

        If m_lngTagID = 0 Then
            m_lngTagID = m_objGlobal.TagID
        Else
            m_objGlobal.TagID = m_lngTagID
        End If

        '' 31-Aug
        ''objAccess.GetAccess(m_objGlobal)

        ''m_blnAddAccess = objAccess.Add          'If user has AddNew Access
        ''m_blnDeleteAccess = objAccess.Delete    'If User has Delete Access
        ''m_blnEditAccess = objAccess.Edit        'If user has Edit Access
        '' END : 31-Aug

        'destroy global and AccessRights objects
        objAccess = Nothing

    End Sub

    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_AUTHENTICATE"), MyBase.GetResourceString("MENU_DELETE"), MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_AUTHENTICATE"), MyBase.GetResourceString("MENU_DELETE"), MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {"Authenticate_OnClick()", "DeleteETC_OnClick()", "Save_OnClick()", "Close_OnClick()", "Help_OnClick(" + m_lngTagID.ToString + ")"}

        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        MyBase.InitializeResources("AppResources.PM_ETCApproval", "AppResources")
        Return strMenu

    End Function

    Public Sub PlotHead()
        '-- Plots common HTML head of the page
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        '-- AUTHENTICATE
        If Args.MenuColIndex = 0 Then

            If m_strMode = "CHANGE" Then
                Cancel = True
            End If

            If m_blnEditAccess = False And m_blnAddAccess = False Then
                Cancel = True
            End If

        End If

        '-- DELETE 
        If Args.MenuColIndex = 1 Then

            If m_strMode = "CHANGE" Then
                Cancel = True
            End If

            If Not m_blnDeleteAccess Then
                Cancel = True
            End If
        End If

        '-- SAVE
        If Args.MenuColIndex = 2 Then
            If m_strMode <> "CHANGE" Then
                Cancel = True
            End If

            If m_blnEditAccess = False And m_blnAddAccess = False Then
                Cancel = True
            End If

        End If

        '-- CLOSE
        If Args.MenuColIndex = 3 Then
            If (m_strMode <> "CHANGE") Then
                If (m_strFromWhere <> "DB") Then
                    Cancel = True
                End If
            End If
        End If

    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        '-- AUTHENTICATE
        If Args.ColIndex = 8 Then
            If m_blnAddAccess = False And m_blnEditAccess = False Then
                Args.StringToBeInserted = "<TD>&nbsp;</TD>"
                Cancel = True
            End If
            'Added by PrashantD on 28 March 2007 for IssueID 11874
            'Purpose: If task is marked as complete or void, user can not modify task therogh ETC.
            If CType(Args.DataReader("IsTaskComplete"), Boolean) = True Or CType(Args.DataReader("IsActive"), Boolean) = False Then
                Args.IsCheckBoxDisabled = True
            End If

        End If

        '-- DELETE
        If Args.ColIndex = 9 Then
            If m_blnDeleteAccess = False Then
                Args.StringToBeInserted = "<TD>&nbsp;</TD>"
                Cancel = True
            End If
        End If

    End Sub
    'Modified By VidyaJ - Browser Issue - IssueID - 809 
    Private Sub m_objGrid_Table_BeforePrint(ByRef Args As WAF_Table) Handles m_objGrid.Table_BeforePrint
        Args.Width = "99.9%"
    End Sub
End Class
