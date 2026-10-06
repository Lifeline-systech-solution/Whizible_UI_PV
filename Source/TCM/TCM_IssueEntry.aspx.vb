Public Class TCM_IssueEntry
    Inherits WebPages.Template.WhizTemplate
#Region "Varialbles"
    Private m_strGridSQL As String
    Private m_strTestSessionID As String
    Private m_strProjectTestSetID As String
    Private m_strAction As String
    Private blnIsTestSessionClosed As Boolean = False
    Private m_strForParentIssueDetail_LNK As String = ""
    Private m_strTestSectionID As String
    'Modified By nitinVS on 16 Apr 2007 for WhizibleSEM SP 8 Regression Issue Fixes 13025 
    Protected m_strTypeWithoutDefaultStatus As String = ""
    'End Modification By nitinVS on 16 Apr 2007 for WhizibleSEM SP 8 Regression Issue Fixes 13025 

    'Added by NitinC on 10 April 2012 For WhizibleSEM 11.0 [Issue Fix : 61214]
    Private m_intFlag As Integer
    'End of Added by NitinC on 10 April 2012 For WhizibleSEM 11.0 [Issue Fix : 61214]

#End Region
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
        ''Added by Yogesh J on on 01 Mar 2016 to validate Token
        If Request.QueryString("IsTestSessionClosed") IsNot Nothing And Request.QueryString("TestSessionID") IsNot Nothing And Request.QueryString("TestSectionID") IsNot Nothing Then
            If Request.QueryString("PKToken") IsNot Nothing And Request.QueryString("ProjectTestSetID") IsNot Nothing Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("TestSessionID"), String) + CType(Request.QueryString("ProjectTestSetID"), String) + CType(Request.QueryString("TestSectionID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then

                    ' Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_YearValue, String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If
        End If
        '  End of addition by Yogesh J on 29-Jan-2016 to validate Token 

    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Private Sub InitializeVariables()
        Dim dr As IDataReader
        Dim strType As String
        ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
        ''dr = CommonFunction.Data.GetDataReader("SELECT DISTINCT Type FROM tbl_IB_Project_Type_Status WHERE Type NOT IN(SELECT Type FROM tbl_IB_Project_Type_Status WHERE ProjectID = " + Session("intProjectID").ToString + " AND DefaultStatus=1) AND ProjectID = " + Session("intProjectID").ToString, MyBase.UseSQL)
        dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_IB_Project_Type_Status_DistinctType " + Session("intProjectID").ToString, MyBase.UseSQL)

        While dr.Read
            strType = "'" + dr("Type").ToString.Replace("'", "\'") + "',"
            m_strTypeWithoutDefaultStatus += strType
        End While
        'Modified By nitinVS on 16 Apr 2007 for WhizibleSEM SP 8 Regression Issue Fixes 13025 
        If m_strTypeWithoutDefaultStatus <> "" Then
            m_strTypeWithoutDefaultStatus = m_strTypeWithoutDefaultStatus.Substring(0, m_strTypeWithoutDefaultStatus.Length - 1)
        End If
        'End Modification By nitinVS on 16 Apr 2007 for WhizibleSEM SP 8 Regression Issue Fixes 13025 


        CommonFunction.Data.DisposeDataReader(dr)

        If Not Request.QueryString("TestSessionID") Is Nothing Then
            m_strTestSessionID = Request.QueryString("TestSessionID").ToString
        ElseIf Not Request.Form("TestSessionID") Is Nothing Then
            m_strTestSessionID = Request.Form("TestSessionID").ToString
        Else
            m_strTestSessionID = "0"
        End If

        If Not Request.QueryString("ProjectTestSetID") Is Nothing Then
            m_strProjectTestSetID = Request.QueryString("ProjectTestSetID")
        ElseIf Not Request.Form("ProjectTestSetID") Is Nothing Then
            m_strProjectTestSetID = Request.Form("ProjectTestSetID")
        Else
            m_strProjectTestSetID = "0"
        End If

        If Request.QueryString("TestSectionID") <> "" Then
            m_strTestSectionID = Request.QueryString("TestSectionID")
        ElseIf Request.Form("cboTestSection") <> "" Then
            m_strTestSectionID = Request.Form("cboTestSection").ToString
        Else
            m_strTestSectionID = "0"
        End If


        CommonFunction.General.WriteHTML("<INPUT Type=HIDDEN name=TestSessionID id=TestSessionID value=" + m_strTestSessionID + ">")
        CommonFunction.General.WriteHTML("<INPUT Type=HIDDEN name=ProjectTestSetID id=ProjectTestSetID value=" + m_strProjectTestSetID + ">")


        m_strGridSQL = "usp_Sel_tbl_TCM_TestCaseResponses_IssueEntry " + m_strTestSessionID + "," + m_strProjectTestSetID + "," + m_strTestSectionID

        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action")
        Else
            m_strAction = ""
        End If

        If m_strAction.ToUpper = "SAVE" Then
            SaveData()
        End If


        If Request.Form("hidIsTestSessionClosed") <> "" Then
            blnIsTestSessionClosed = CType(Request.Form("hidIsTestSessionClosed"), Boolean)
        ElseIf Request.QueryString("IsTestSessionClosed") <> "" Then
            blnIsTestSessionClosed = CType(Request.QueryString("IsTestSessionClosed"), Boolean)
        End If

        'Written Info in hidden form
        CommonFunction.General.WriteHTML("<input type=hidden name=hidIsTestSessionClosed id=hidIsTestSessionClosed value='" + blnIsTestSessionClosed.ToString.ToUpper + "'> ")
        CommonFunction.General.WriteHTML("<input type=hidden  id=hidForParentIssueDetail_LNK value='" + m_strForParentIssueDetail_LNK + "'> ")

        'end of written Info in hidden form 

    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    Protected Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()
        ' Purpose               : Start of Page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : This function must be called within FORM tag in aspx page.
        ' Author                : PrashantD
        ' Created               : Feb 3, 2006
        ' Revisions             :
        '=====================================================================
        '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
           MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.TCM_IssueEntry", "AppResources")

        InitializeVariables()
        Dim arrMenu As New System.Collections.ArrayList
        Dim arrMenuToolTip As New System.Collections.ArrayList
        Dim arrCSFunction As New System.Collections.ArrayList
        If blnIsTestSessionClosed = False Then
            arrMenu.Add(MyBase.GetResourceString("MENU_SAVE"))
            arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE"))
            arrCSFunction.Add("Save_Click()")

        End If

        arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenu.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP"))
        arrCSFunction.Add("Close_OnClick()")
        arrCSFunction.Add("Help_OnClick('TCM')")

        With Response

            'Upper menu
            .Write(WebPages.Template.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip)))
            .Write("<BR>")
            'page caption
            .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("LBL_TEST_CASE_ISSUE _ENTRY")))
            .Write("<BR>")
            Call drawPageFilters()
            .Write("<BR>")

            Call DrawPage()

            'Bottom menu
            .Write("<BR>")
            .Write(WebPages.Template.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip)))

        End With


    End Sub
    Private Sub DrawPage()
        Dim strCss As String = "clsTREven"
        Dim strResponseTestCaseID As String
        Dim strSummary As String
        Dim strDescription As String

        CommonFunction.General.WriteHTML("<DIV Id=divPage Style='HEIGHT:400px;OVERFLOW:auto; WIDTH:100%'>")
        CommonFunction.General.WriteHTML("<Table class=clsGridTable cellSpacing=1 cellPadding=0 width='99.9%'> ")
        CommonFunction.General.WriteHTML("<THead class='clsTRColumnHeader'>")

        CommonFunction.General.WriteHTML("<TH  class='divListTag' align='Left' nowrap >")
        CommonFunction.General.WriteHTML("<IMG src='../../Images/pin.gif' >")
        CommonFunction.General.WriteHTML("</TH>")

        CommonFunction.General.WriteHTML("<TH  class='divListTag' align='Left' nowrap >")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_TESTCASECODE"))
        CommonFunction.General.WriteHTML("</TH>")

        CommonFunction.General.WriteHTML("<TH  class='divListTag' align='Left' nowrap >")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_SUMMARY"))
        CommonFunction.General.WriteHTML("</TH>")

        CommonFunction.General.WriteHTML("<TH  class='Sort_divListTag' align='Left' nowrap >")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_DESCRIPTION"))
        CommonFunction.General.WriteHTML("</TH>")

        CommonFunction.General.WriteHTML("<TH  class='Sort_divListTag' align='Left' nowrap >")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_TYPE"))
        CommonFunction.General.WriteHTML("</TH>")

        CommonFunction.General.WriteHTML("<TH  class='Sort_divListTag' align='Left' nowrap >")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_PRIORITY"))
        CommonFunction.General.WriteHTML("</TH>")

        ''CommonFunction.General.WriteHTML("<TH  class='Sort_divListTag' align='Left' nowrap >")
        ''CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_SEVERITY"))
        ''CommonFunction.General.WriteHTML("</TH>")

        CommonFunction.General.WriteHTML("<TH>Select</TH>")
        CommonFunction.General.WriteHTML("</THead>")


        Dim drTestCases As IDataReader
        drTestCases = CommonFunction.Data.GetDataReader(m_strGridSQL, MyBase.UseSQL)

        While drTestCases.Read
            strResponseTestCaseID = drTestCases("TestCaseResponseID").ToString

            If IsDBNull(drTestCases("IssueID")) Then
                'Commented and Modified by SanaS on 9-Dec-2010 for Production
                ''strSummary = "Test Case Code: " + drTestCases("TestCaseCode").ToString + vbNewLine
                'strSummary = drTestCases("Title").ToString + "->" + drTestCases("TestSetName").ToString + "->" + drTestCases("TestCaseCode").ToString + vbNewLine
                'strSummary += "Brief Scenario/Summary: " + drTestCases("BriefScenario").ToString

                'strDescription = "Scenario: " + drTestCases("Scenario").ToString + vbNewLine
                'strDescription += "[" + drTestCases("ResponseDate").ToString + " - " + drTestCases("EmployeeName").ToString + "] " + vbNewLine

                'If drTestCases("Notes").ToString.Trim = "" Then
                '    strDescription += "Notes: -"
                'Else
                '    strDescription += "Notes: " + drTestCases("Notes").ToString
                'End If
                strSummary = "Test Case Code: " + drTestCases("TestCaseCode").ToString + vbNewLine
                strSummary += "Scenario: " + drTestCases("Scenario").ToString
                strDescription = "Test procedure: " + drTestCases("TestProcedure").ToString + vbNewLine
                strDescription += "Verification: " + drTestCases("VerificationProcedure").ToString + vbNewLine
                If drTestCases("Notes").ToString.Trim = "" Then
                    strDescription += "Notes: -"
                Else
                    strDescription += "Notes: " + drTestCases("Notes").ToString
                End If
            Else
                strSummary = ""
                strDescription = ""
                If Not IsDBNull(drTestCases("Summary")) Then
                    strSummary = drTestCases("Summary").ToString
                End If
                If Not IsDBNull(drTestCases("Description")) Then
                    strDescription = drTestCases("Description").ToString
                End If

            End If




                CommonFunction.General.WriteHTML("<TR class=" + strCss + ">")
                'Test Case Code
                CommonFunction.General.WriteHTML("<TD>")
                If CInt(drTestCases("AttachCount")) <> 0 Then
                    CommonFunction.General.WriteHTML("<IMG src='../../Images/pin.gif' >")
                End If
                CommonFunction.General.WriteHTML("</TD>")


                'Test Case Code
                CommonFunction.General.WriteHTML("<TD valign=top>")
                CommonFunction.General.WriteHTML(drTestCases("TestCaseCode").ToString)
                If Not IsDBNull(drTestCases("IssueID")) Then
                    CommonFunction.General.WriteHTML("<BR><BR>IssueID:&nbsp;")
                    CommonFunction.General.WriteHTML("<A href='JavaScript:showIssueDetails_onClick(" + drTestCases("IssueID").ToString + ",""" + CommonFunctions.Security.Token.GetToken(CType(drTestCases("IssueID"), String) + CType(Session("intUserID"), String) + "0" + "0") + """" + _
                        ")' Title='Click here to open Issue Details' >" + drTestCases("IssueID").ToString + "</A>")
                End If
                CommonFunction.General.WriteHTML("</TD>")
                'Summary
                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.General.WriteHTML("<INPUT Type=hidden name=ProjectTestCaseID" + strResponseTestCaseID + " value=" + drTestCases("TestCaseID").ToString + " >")
                'CommonFunction.HTMLControls.DrawTextArea( "txtSummary" + strResponseTestCaseID, "txtSummary" + strResponseTestCaseID, "Summary", , , "frmTestCaseIssueEntry", , , 200, 50, , strSummary, ToBeInserted:=" wrap=off onchange=txtSummary_onChange(" + strResponseTestCaseID + ")", Style:="OVERFLOW:scroll", IsMandatory:=True)
                CommonFunction.General.WriteHTML("<TEXTAREA name='txtSummary" + strResponseTestCaseID + "' id='txtSummary" + strResponseTestCaseID + "' class='clsTextArea' style='width:200px;height:50px;text-align:Left;OVERFLOW:scroll' wrap=off onchange=txtSummary_onChange(" + strResponseTestCaseID + ") >" + strSummary + "</TEXTAREA>")
                CommonFunction.General.WriteHTML("<A Href=""JavaScript:preopentextdialog('frmTestCaseIssueEntry','txtSummary" + strResponseTestCaseID + "','Summary','False','" + strResponseTestCaseID + "')"" tabindex='-1'><img Border=0 valign=Top src='../../images/zoomin.gif' alt='Double click the text area to add more text'></img></a><IMG src='../../Images/Star.gif' border=0>")
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("<TD>")
                'CommonFunction.HTMLControls.DrawTextArea("txtDescription" + strResponseTestCaseID, "txtDescription" + strResponseTestCaseID, "Description", , , "frmTestCaseIssueEntry", , , 200, 50, , strDescription, ToBeInserted:=" wrap=off onchange=txtDescription_onChange(" + strResponseTestCaseID + ")", Style:="OVERFLOW:scroll", IsMandatory:=True)
                CommonFunction.General.WriteHTML("<TEXTAREA name='txtDescription" + strResponseTestCaseID + "' id='txtDescription" + strResponseTestCaseID + "' class='clsTextArea' style='width:200px;height:50px;text-align:Left;OVERFLOW:scroll' wrap=off onchange=txtDescription_onChange(" + strResponseTestCaseID + ") >" + strDescription + "</TEXTAREA>")
                CommonFunction.General.WriteHTML("<A Href=""JavaScript:preopentextdialog('frmTestCaseIssueEntry','txtDescription" + strResponseTestCaseID + "','Description','False','" + strResponseTestCaseID + "')"" tabindex='-1'><img Border=0 valign=Top src='../../images/zoomin.gif' alt='Double click the text area to add more text'></img></a><IMG src='../../Images/Star.gif' border=0>")
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.HTMLControls.DrawComboBox("cboIssueType" + strResponseTestCaseID, "usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " + Session("intProjectID").ToString + ",'T',Null,Null,Null,Null,Null," + Session("intPostID").ToString, 150, drTestCases("Type").ToString, "onchange=cboIssueType_onChange(" + strResponseTestCaseID + ")", True, IsMandatory:=True)
                CommonFunction.General.WriteHTML("</TD>")

                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.HTMLControls.DrawComboBox("cboIssuePriority" + strResponseTestCaseID, "usp_Sel_tbl_IB_Project_Priorities " + Session("intProjectID").ToString, 120, drTestCases("Priority").ToString, "onchange=cboIssuePriority_onChange(" + strResponseTestCaseID + ")", True)
                CommonFunction.General.WriteHTML("</TD>")

                '''Severity
                ''CommonFunction.General.WriteHTML("<TD>")
                ''CommonFunction.HTMLControls.DrawComboBox("cboIssueSeverity" + strResponseTestCaseID, "usp_Sel_tbl_IB_Project_Severity " + Session("intProjectID").ToString, 120, drTestCases("Severity").ToString, "onchange=cboIssueSeverity_onChange(" + strResponseTestCaseID + ")", True)
                ''CommonFunction.General.WriteHTML("</TD>")

                CommonFunction.General.WriteHTML("<TD>")

                If Not IsDBNull(drTestCases("IssueID")) Then
                    CommonFunction.HTMLControls.DrawCheckBox("chkIssueEntry" + strResponseTestCaseID, "chkIssueEntry" + strResponseTestCaseID, , True, drTestCases("IssueID").ToString, True, " align=center onchange=chkIssueEntry_onChange(" + strResponseTestCaseID + ")")
                Else
                    CommonFunction.HTMLControls.DrawCheckBox("chkIssueEntry" + strResponseTestCaseID, "chkIssueEntry" + strResponseTestCaseID, , , "0", , " align=center onchange=chkIssueEntry_onChange(" + strResponseTestCaseID + ")")
                End If

                CommonFunction.General.WriteHTML("</TD>")

                CommonFunction.General.WriteHTML("</TR>")
                If strCss = "clsTREven" Then
                    strCss = "clsTROdd"
                Else
                    strCss = "clsTREven"
                End If
        End While
        CommonFunction.Data.DisposeDataReader(drTestCases)
        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("<INPUT Type=HIDDEN name=hidResponseIDsToSave id=hidResponseIDsToSave>")
        CommonFunction.General.WriteHTML("</DIV>")


    End Sub
    Private Sub SaveData()
        Dim arrStrTestResponseIDs() As String = Request.Form("hidResponseIDsToSave").Split(CChar(","))
        Dim counter As Integer = 0
        Dim strSQL As String

        Dim strSummary As String
        Dim strDescription As String
        Dim strType As String
        Dim strPriority As String
        'Dim strSeverity As String

        Dim strIssueID As String


        While counter < arrStrTestResponseIDs.Length
            If Request.Form("chkIssueEntry" + arrStrTestResponseIDs(counter)) = "0" Or _
                Request.Form("chkIssueEntry" + arrStrTestResponseIDs(counter)) <> "" Then

                strSummary = Request.Form("txtSummary" + arrStrTestResponseIDs(counter))
                strSummary = strSummary.Replace("'", "''")

                strDescription = Request.Form("txtDescription" + arrStrTestResponseIDs(counter))
                strDescription = strDescription.Replace("'", "''")

                strType = Request.Form("cboIssueType" + arrStrTestResponseIDs(counter))
                strType = strType.Replace("'", "''")

                strPriority = Request.Form("cboIssuePriority" + arrStrTestResponseIDs(counter))
                strPriority = strPriority.Replace("'", "''")

                'strSeverity = Request.Form("cboIssueSeverity" + arrStrTestResponseIDs(counter))
                'strSeverity = strSeverity.Replace("'", "''")
            End If

            'Added by NitinC on 10 April 2012 For WhizibleSEM 11.0 [Issue Fix : 61214]
            m_intFlag = CInt(CInt(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + Session("intProjectID").ToString, MyBase.UseSQL)))
            If Request.Form("chkIssueEntry" + arrStrTestResponseIDs(counter)) = "0" And m_intFlag = 1 Then
                'insert 
                'strSQL = "usp_InsUpd_tbl_IB_Issue_TCM NULL," + Session("intProjectID").ToString + ",'" + strSummary + "','" + strDescription + "','" + strType + "','" + strPriority + "','" + strSeverity + "'," + arrStrTestResponseIDs(counter)
                strSQL = "usp_InsUpd_tbl_IB_Issue_TCM NULL," + Session("intProjectID").ToString + ",'" + strSummary + "','" + strDescription + "','" + strType + "','" + strPriority + "'," + arrStrTestResponseIDs(counter) + "," + m_strProjectTestSetID
                strIssueID = CStr(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL))
                m_strForParentIssueDetail_LNK += strIssueID + "," + CommonFunctions.Security.Token.GetToken(strIssueID + CType(Session("intUserID"), String) + "0" + "0") + "," + arrStrTestResponseIDs(counter) + ","
                PerformAttachment(strIssueID, Request.Form("ProjectTestCaseID" + arrStrTestResponseIDs(counter)))
                'End of Added by NitinC on 10 April 2012 For WhizibleSEM 11.0 [Issue Fix : 61214]
            ElseIf Request.Form("chkIssueEntry" + arrStrTestResponseIDs(counter)) = "0" Then
                'insert 
                'strSQL = "usp_InsUpd_tbl_IB_Issue_TCM NULL," + Session("intProjectID").ToString + ",'" + strSummary + "','" + strDescription + "','" + strType + "','" + strPriority + "','" + strSeverity + "'," + arrStrTestResponseIDs(counter)
                strSQL = "usp_InsUpd_tbl_IB_Issue_TCM NULL," + Session("intProjectID").ToString + ",'" + strSummary + "','" + strDescription + "','" + strType + "','" + strPriority + "'," + arrStrTestResponseIDs(counter)
                strIssueID = CStr(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL))
                m_strForParentIssueDetail_LNK += strIssueID + "," + CommonFunctions.Security.Token.GetToken(strIssueID + CType(Session("intUserID"), String) + "0" + "0") + "," + arrStrTestResponseIDs(counter) + ","
                PerformAttachment(strIssueID, Request.Form("ProjectTestCaseID" + arrStrTestResponseIDs(counter)))
            ElseIf Request.Form("chkIssueEntry" + arrStrTestResponseIDs(counter)) <> "" Then
                'update
                strIssueID = Request.Form("chkIssueEntry" + arrStrTestResponseIDs(counter))
                'strSQL = "usp_InsUpd_tbl_IB_Issue_TCM " + strIssueID + "," + Session("intProjectID").ToString + ",'" + strSummary + "','" + strDescription + "','" + strType + "','" + strPriority + "','" + strSeverity + "'," + arrStrTestResponseIDs(counter)
                strSQL = "usp_InsUpd_tbl_IB_Issue_TCM " + strIssueID + "," + Session("intProjectID").ToString + ",'" + strSummary + "','" + strDescription + "','" + strType + "','" + strPriority + "'," + arrStrTestResponseIDs(counter)
                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            End If


            counter += 1
        End While

    End Sub
    Private Sub PerformAttachment(ByVal strIssueID As String, ByVal strProjectTestCaseID As String)
        '=====================================================================
        ' Procedure Name        : PerformActions()	
        ' Purpose               : To take requested actions on the page
        ' Description           : The proc. performs the actions for the page
        '                         Deletes, updates and inserts are done
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : Module variables are set.
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 24,2004
        ' Revisions             :
        '=====================================================================
        Dim Attachedby As String

        Dim strDestinationSysFileName As String
        Dim drAttach As IDataReader
        Dim strInsSQL As String
        Dim strDestinationPath As String
        Dim strSourcePath As String

        drAttach = CommonFunction.Data.GetDataReader("SELECT * FROM tbl_TCM_TestCaseResponsesAttachments  WHERE TestSessionID = " + m_strTestSessionID + " AND ProjectTestCaseID=" + strProjectTestCaseID, MyBase.UseSQL)

        strDestinationPath = Server.MapPath("../../Attachments/BTS")
        strSourcePath = Server.MapPath("../../Attachments/TCM/TestCaseResponses")



        While drAttach.Read
            strInsSQL = "usp_Ins_tbl_IB_Attachments " + strIssueID + "," + Session("intProjectID").ToString + ","

            If Not System.IO.File.Exists(strDestinationPath + "\" + drAttach("SystemFileName").ToString) Then
                strDestinationSysFileName = drAttach("SystemFileName").ToString
            Else
                strDestinationSysFileName = CommonFunctions.FileDirectory.GetUniqueFileName()
                strDestinationSysFileName += drAttach("SystemFileName").ToString.Substring(drAttach("SystemFileName").ToString.IndexOf("."))

            End If

            System.IO.File.Copy(strSourcePath + "\" + drAttach("SystemFileName").ToString, strDestinationPath + "\" + strDestinationSysFileName)

            strInsSQL += drAttach("AttachedBy").ToString + "," + "'E','" + strDestinationSysFileName + "','" + CommonFunction.General.BuildQueryString(drAttach("OriginalFileName").ToString) + "','Attachment by TCM',0"
            CommonFunction.Data.InsertOrUpdateData(strInsSQL, MyBase.UseSQL)
        End While
        CommonFunction.Data.DisposeDataReader(drAttach)
    End Sub
    Private Sub drawPageFilters()
        CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
        CommonFunction.General.WriteHTML("<TR class=clsTRSectionHeader>")
        CommonFunction.General.WriteHTML("<TD  align=Left width='1%'><A href='Javascript:showHide_divFilter()'>")
        CommonFunction.General.WriteHTML("<Img Border=0 id=pageFilterImg Src='../../Images/minus.gif' title=''></A></TD>")
        CommonFunction.General.WriteHTML("<TD> " + MyBase.GetResourceString("LBL_FILTER") + "</TD>")
        CommonFunction.General.WriteHTML("<TD id=TDPaging align=Right><font style='FONT-WEIGHT: normal' >")
        CommonFunction.General.WriteHTML("</TD></TR></TABLE>")
        CommonFunction.General.WriteHTML("<DIV id=pageFilterDiv>")
        CommonFunction.General.WriteHTML("<TABLE ID='PageFilter' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        'Test Section Combo
        CommonFunction.General.WriteHTML("<TD align=right>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LBL_TEST_SECTION"))
        CommonFunction.General.WriteHTML("</TD><TD>")
        CommonFunction.HTMLControls.DrawComboBox("cboTestSection", "usp_Sel_combo_tbl_TCM_TestSection_Execution  " + m_strProjectTestSetID, 200, m_strTestSectionID, "onchange=TestSection_onChange()", True)
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</TABLE></DIV>")
    End Sub
End Class
