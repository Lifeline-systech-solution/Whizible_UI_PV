Public Class PRO_Milestones
    Inherits WebPages.Template.WhizTemplate

    '=====================================================================
    ' Page Name             : PRO_Milestones
    ' Purpose               : Milestone Analysis Page
    ' Description           : 1. Milestones List Page (MODE=LIST)
    '                         2. Milestone Details Page (MODE=DETAIL) The Selected Milestone ID is passed as 
    '                            a Querystring parameter 
    '                         3. PMI Detail Page (MODE=PMI_DETAIL). Here we show the details of the Selected PMI for this Milestone.
    '                         4. Slippage And Reasoning Entry Page (MODE=SLIP_N_REASON) A Popup Page called from this page 
    '                            is for Accepting the Slippage and Reason and Saving them
    '                         5. LOC Entry Popup Page (MODE=TOTAL_LOC) Popup page accepts Total LOC from User.
    ' Parameters Passed     : Mode = LIST; DETAIL; PMI_DETAIL; SLIP_N_REASON; TOTAL_LOC 
    '                         Action = SAVE; GATHER_DET (gather Details of this Milestone); CLOSE_MS (Close Milestone);
    '                         CALC_PMI (Calculate PMI)
    ' Assumptions           : AppResources.PRO_Milestones Resource file exists
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : SuryabirD
    ' Created               : Mar 12th, 2004
    '=====================================================================

    Protected m_strPageTitle, m_strMode, m_strAction As String
    Protected m_lngProjectID, m_lngMilestoneID, m_lngTagID As Long
    Protected m_strSortField, m_strSortOrder As String
    Protected m_lngCurrentPage, m_lngAnalysisID As Long
    Protected m_strQueryString, strFromWhere As String
    Protected m_lngResultID As Long
    Protected m_blnValidate As Boolean = True
    'Added by MahendraV On 2:20 PM 5/23/2007 for desable the Back link at project level
    ' Start_MV_5/23/2007
    Protected m_lngIsProject As Long
    ' End_MV_5/23/2007
    Protected m_PKToken
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_blnAddAccess, m_blnDeleteAccess, m_blnEditAccess As Boolean
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private WithEvents m_objMetricGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objCausalGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objCausalDetailsGrid As New WebPages.Template.GenericGrid

    Private m_blnGatheredDetails, m_blnIsReadyClosure As Boolean
    Private intCounter As Integer = 0
    Protected strToken As String



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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ''Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.

        ' ''commented by nilesh g on 31/12/2015 for Security
        'If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
        '    Response.Write(vbCrLf + "<script>")
        '    Response.Write(vbCrLf + "		if (window.opener == null)")
        '    Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
        '    If strRedirectToPage.Trim = "" Then
        '        Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
        '    Else
        '        Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
        '    End If
        '    Response.Write(vbCrLf + "</script>")
        'End If
        ' ''end of commented by nilesh g on 31/12/2015 for Security

        ''Added by Yogesh J on 10-Feb-2016 to validate Token
        'If Request.QueryString("ANAL_ID") IsNot Nothing And Request.QueryString("PKToken") IsNot Nothing Then
        '    If Request.QueryString("MODE") = "CONCLUSION" Or Request.QueryString("MODE") = "TOTAL_LOC" Then
        '        If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ANAL_ID"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then
        '            '  Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Milestone Analysis", 0, 0, "AnalysisID", CType(Request.QueryString("ANAL_ID"), String))
        '            'Token is Invalid now redirect to the Invalid Access Page
        '            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '        End If

        '    End If
        'End If
        If Request.QueryString("MODE") = "SLIP_N_REASON" Or Request.QueryString("MODE") = "TOTAL_LOC" Or Request.QueryString("MODE") = "CONCLUSION" Then
            'If (Request.QueryString("Token") Is Nothing) Then
            '    m_blnValidate = True
            'ElseIf (Request.QueryString("Token") = "" And HttpContext.Current.Session("intUserID") <> 0) Then
            '    m_blnValidate = False
            '    ElseIf (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("ANAL_ID"), String) + CType(Request.QueryString("ProjectID"), String) + CType(Request.QueryString("MilestoneID"), String) + CType(Request.QueryString("IsProject"), String) + CType(0, String) + CType(0, String), Request.QueryString("Token")) = False) Then 
            'ElseIf (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ANAL_ID"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String) + CType(Request.QueryString("ProjectID"), String) + CType(Request.QueryString("MilestoneID"), String) + CType(Request.QueryString("IsProject"), String), Request.QueryString("Token")) = False) Then

            'End If
            ''Commented and Added by Tejal D purpose  validate token 12/8/2016
            If (Request.QueryString("ACTION") <> "SAVE") Then
                If (Request.QueryString("PKToken") = "" And HttpContext.Current.Session("intUserID") <> 0) Then
                    m_blnValidate = False
                ElseIf Request.QueryString("ANAL_ID") <> "" And Request.QueryString("PKToken") <> "" And Request.QueryString("ProjectID") <> "" And Request.QueryString("MilestoneID") <> "" Then
                    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ANAL_ID"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String) + CType(Request.QueryString("ProjectID"), String) + CType(Request.QueryString("MilestoneID"), String) + CType(Request.QueryString("IsProject"), String), Request.QueryString("PKToken")) = False) Then
                        m_blnValidate = False
                    End If
                ElseIf Request.QueryString("ANAL_ID") IsNot Nothing Then
                    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ANAL_ID"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then
                        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Milestone Analysis", 0, 0, "AnalysisID", CType(Request.QueryString("ANAL_ID"), String))
                        ''    Token is Invalid now redirect to the Invalid Access Page
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    End If
                End If
                '' End of addtion by Tejal D purpose  validate token 12/8/2016
                If (m_blnValidate = False) Then
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If
        End If

        'If Request.QueryString("ANAL_ID") IsNot Nothing And Request.QueryString("Token") IsNot Nothing And Request.QueryString("MilestoneID") IsNot Nothing Then
        '    If Request.QueryString("MODE") = "SLIP_N_REASON" Or Request.QueryString("MODE") = "TOTAL_LOC" Or Request.QueryString("MODE") = "CONCLUSION" Then
        '        If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("ANAL_ID"), String) + CType(Request.QueryString("ProjectID"), String) + CType(Request.QueryString("MilestoneID"), String) + CType(Request.QueryString("IsProject"), String) + CType(0, String) + CType(0, String), Request.QueryString("Token")) = False) Then
        '            '  Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Milestone Analysis", 0, 0, "AnalysisID", CType(Request.QueryString("ANAL_ID"), String))
        '            'Token is Invalid now redirect to the Invalid Access Page
        '            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '        End If

        '    End If
        'End If

        ''End of addition by Yogesh J on on 10-Feb-2016 to validate Token

        'Put user code to initialize the page here
        Dim strQuery As String
        Dim drMilestones As IDataReader

        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")
        m_lngProjectID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"), "0"), Long)
        m_lngMilestoneID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("MilestoneID"), "0"), Long)
        m_lngAnalysisID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ANAL_ID"), "0"), Long)
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("MODE"), "LIST")
        m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("ACTION"), "")
        m_lngResultID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ResultID"), "0"), Long)
        'Added by MahendraV On 2:20 PM 5/23/2007 for desable the Back link at project level
        ' Start_MV_5/23/2007
        m_lngIsProject = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("IsProject"), "0"), Long)
        ' End_MV_5/23/2007


        m_strSortField = CommonFunctions.General.CheckIsNothing(Request.QueryString("SortField"), "ProjectName")
        m_strSortOrder = CommonFunctions.General.CheckIsNothing(Request.QueryString("SortOrder"), "ASC")
        Call CreateGlobalObject()
        strFromWhere = CommonFunctions.General.CheckIsNothing(Request.QueryString("FormName"), "frmMilestones").ToString

        If strFromWhere <> "frmMilestones" Then
            '-- Means page is called from Project Closure
            m_strQueryString = Request.QueryString.ToString

        End If

        '-- Depending on ACTION : GATHER DETAILS, CLOSE MS, CALCULATE PMI, SAVE (Conclusion, LOC, Slippage, Causal Anal.)
        Select Case m_strAction
            Case "GATHER_DET"
                'if Action is GATHER_DET then changes the status of the Milestone 'Analysis in progess'

                'Gathers data for the Milestone
                strQuery = "Exec usp_PDB_ProjectAnalysis_MilestoneAndProjectClosureAnalysis  " + m_lngProjectID.ToString + "," + m_lngMilestoneID.ToString
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

                'Changes the status if the milestone			
                strQuery = "Exec usp_Upd_ChangeMilestoneStatus  " + m_lngMilestoneID.ToString + ",'P'"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            Case "CLOSE_MS"
                'if Action is CLOSE_MS ('Close Analysis') then changes the status of the Milestone 'Analysis completed'	
                strQuery = "Exec usp_Upd_ChangeMilestoneStatus  " + m_lngMilestoneID.ToString + ",'C'"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                CommonFunctions.General.WriteHTML("<SCRIPT Language=javascript>")
                'Added by MahendraV On 2:20 PM 5/23/2007 for desable the Back link at project level
                ' Start_MV_5/23/2007
                If (m_lngIsProject = 1) And (m_strMode = "DETAIL") Then
                    CommonFunctions.General.WriteHTML("window.opener.document.forms[0].action='../General/CommonPage.aspx?MilestoneID_PK=" + m_lngMilestoneID.ToString() + "&MasterTagID=34&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1';")
                    CommonFunctions.General.WriteHTML("window.opener.document.forms[0].submit();")
                    CommonFunctions.General.WriteHTML("window.close();")
                Else
                    ' End_MV_5/23/2007
                    CommonFunctions.General.WriteHTML("location.href = 'PRO_Milestones.aspx?MasterTagID=" + m_lngTagID.ToString + " &MODE=LIST';")
                End If
                CommonFunctions.General.WriteHTML("</SCRIPT>")
            Case "CALC_PMI"
                '-- When Calculate PMI is Clicked From the Causal Analysis Page
                strQuery = "EXEC usp_Sel_tbl_PDB_ProjectAnalysis " + m_lngAnalysisID.ToString

                'Commented By NitinVs on 1 OCT 2009 unused datareader hence commenting 
                'drMilestones = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                'end Commenting by NitinVS on 1 oct 2009 
                strQuery = "EXEC usp_PDB_PMICalculation_MilestoneAndProjectClosureAnalysis " + m_lngAnalysisID.ToString + "," + m_lngProjectID.ToString

                If m_lngMilestoneID.ToString = "" Then
                    strQuery = strQuery & ",NULL"
                Else
                    strQuery = strQuery & "," & m_lngMilestoneID.ToString
                End If
                strQuery = strQuery & ",'" + CommonFunctions.General.BuildQueryString(Session("strUserName").ToString) + "'"

                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            Case "SAVE"
                '-- When SAVE is Clicked
                '-- When save is clicked for saving Slippage and Reason
                Select Case m_strMode
                    Case "SLIP_N_REASON"
                        Call Save_SlippageReason()

                    Case "TOTAL_LOC"
                        '-- When save is clicked for saving LOC
                        Call Save_TotalLOC()

                    Case "CONCLUSION"
                        '-- When save is clicked for saving Conclusion
                        Call Save_Conclusion()

                    Case "CAUSAL_DETAILS"
                        '-- When save is clicked for saving Casual Analysis
                        Call Save_Causal_Details()

                    Case Else

                End Select

                '-- Refresh Parent Page and Close Surrent Popup window
                CommonFunctions.General.WriteHTML("<SCRIPT Language=javascript>")

                '-- This Page is Also Called from Project Closure.. Depending on where its called from
                '-- we refresh the Parent Page..

                If strFromWhere <> "frmMilestones" Then
                    m_strQueryString = MyBase.GetFormValue("txtQS")
                    CommonFunctions.General.WriteHTML("window.opener.document.forms['" + strFromWhere + "'].action='PRO_ProjectClosure.aspx?" + m_strQueryString + "';")
                Else
                    '-- For Causal Analysis page we refresh he Causal Analysis List page
                    If m_strMode <> "CAUSAL_DETAILS" Then
                        CommonFunctions.General.WriteHTML("window.opener.document.forms['" + strFromWhere + "'].action='PRO_Milestones.aspx?MasterTagID=" + m_lngTagID.ToString + "&MODE=DETAIL&ProjectID=" + m_lngProjectID.ToString + "&MilestoneID=" + m_lngMilestoneID.ToString + "&SortField=" + m_strSortField + "&SortOrder=" + m_strSortOrder + "&IsProject=" + m_lngIsProject.ToString() + "';")
                    Else
                        CommonFunctions.General.WriteHTML("window.opener.document.forms['" + strFromWhere + "'].action='PRO_Milestones.aspx?MasterTagID=" + m_lngTagID.ToString + "&MODE=CAUSAL_ANAL&ANAL_ID=" + m_lngAnalysisID.ToString + "&ProjectID=" + m_lngProjectID.ToString + "&MilestoneID=" + m_lngMilestoneID.ToString + "&SortField=" + m_strSortField + "&SortOrder=" + m_strSortOrder + "&IsProject=" + m_lngIsProject.ToString() + "';")
                    End If
                End If

                CommonFunctions.General.WriteHTML("window.opener.document.forms['" + strFromWhere + "'].submit();")
                'Commented By Usha Pandit On 15.05.2020 to prevent close popup on save
                'CommonFunctions.General.WriteHTML("window.close();")
                'End Of Commented By Usha Pandit On 15.05.2020 to prevent close popup on save
                CommonFunctions.General.WriteHTML("</SCRIPT>")

        End Select

    End Sub

    Private Sub Save_Causal_Details()
        '=====================================================================
        ' Procedure Name        : Save_Causal_Details
        ' Purpose               : Function for Saving the Selected(Checked) causes.
        ' Description           : same as above
        ' Parameters Passed     : Mode= CAUSAL_DETAILS; ACTION=SAVE
        ' Returns               : None
        ' Author                : SuryabirD
        ' Created               : Monday, 15 March, 2004
        '=====================================================================
        Dim strQuery As String
        Dim drMilestones As IDataReader
        Dim lngResultID As Long
        Dim intCounter As Integer
        Dim strCauseID() As String = Split(Request.Form("chkCause"), ",")

        lngResultID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ResultID"), "0"), Long)

        strQuery = "EXEC usp_Del_tbl_PDB_Deviation " + lngResultID.ToString
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

        For intCounter = 0 To strCauseID.Length - 1
            If CommonFunctions.General.CheckIsNothing(strCauseID(intCounter), "").Trim <> "" Then
                strQuery = "EXEC usp_Ins_tbl_PDB_Deviation " + lngResultID.ToString + "," + strCauseID(intCounter)
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            End If
        Next

    End Sub

    Private Sub Save_SlippageReason()
        '=====================================================================
        ' Procedure Name        : Save_SlippageReason
        ' Purpose               : Function for Saving the Entered Slippage Reason from the Popup Entry page
        ' Description           : if the mode is 'SLIP_N_REASON' and Action is SAVE then saves the 
        '                         slippage and reason for slippage for the Milestone in the Database
        ' Parameters Passed     : Mode= SLIP_N_REASON; ACTION=SAVE
        ' Returns               : None
        ' Author                : SuryabirD
        ' Created               : Monday, 15 March, 2004
        '=====================================================================

        Dim strSlippageReason, strActionTaken, strQuery As String
        Dim lngAnalysisID As Long

        strSlippageReason = MyBase.GetFormValue("txtSlippageReason")
        strActionTaken = MyBase.GetFormValue("txtActionTaken")
        lngAnalysisID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ANAL_ID"), "0"), Long)

        strQuery = "Exec usp_Upd_tbl_PDB_EffortScheduleDeviations_SlippageAndReasoning '" + strSlippageReason + "','" + strActionTaken + "'," + lngAnalysisID.ToString
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

    End Sub

    Private Sub Save_TotalLOC()
        '=====================================================================
        ' Procedure Name        : Save_TotalLOC
        ' Purpose               : Function for Saving the Entered Total LOC from the Popup Entry page
        ' Description           : if the mode is 'TOTAL_LOC' and Action is SAVE then saves the 
        '                         Total LOC for the Milestone in the Database
        ' Parameters Passed     : Mode= TOTAL_LOC; ACTION=SAVE
        ' Returns               : None
        ' Author                : SuryabirD
        ' Created               : Monday, 15 March, 2004
        '=====================================================================

        Dim lngAnalysisID As Long
        Dim strQuery As String
        Dim dblLOC As Double

        lngAnalysisID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ANAL_ID"), "0"), Long)
        dblLOC = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtLOC"), "0"), Double)

        strQuery = "EXEC usp_Upd_tbl_PDB_ProjectAnalysis_LOC " + dblLOC.ToString + "," + lngAnalysisID.ToString
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

        strQuery = "EXEC usp_PDB_ProjectSizeByTool_MilestoneAndProjectClosureAnalysis  " + lngAnalysisID.ToString
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

    End Sub

    Private Sub Save_Conclusion()
        '=====================================================================
        ' Procedure Name        : Save_Conclusion
        ' Purpose               : Saves the Conclusion, comments posted for the milestones 
        ' Description           : if the mode is 'CONCLUSION' and Action is SAVE then saves the 
        '                         Conclusion for the Milestone in the Database
        ' Parameters Passed     : Mode= CONCLUSION; ACTION=SAVE
        ' Author                : SuryabirD
        ' Created               : Monday, 15 March, 2004
        '=====================================================================
        Dim strConclusion, strSuggForImprovement, strProjFeedback, strPracticesFollowed As String
        Dim strQuery, strShortComings As String

        '-- Get the posted Data
        strConclusion = MyBase.GetFormValue("txtConclusion")
        strSuggForImprovement = MyBase.GetFormValue("txtSuggForImprovement")
        strProjFeedback = MyBase.GetFormValue("txtProjFeedback")
        strPracticesFollowed = MyBase.GetFormValue("txtPracticesFollowed")
        strShortComings = MyBase.GetFormValue("txtShortComings")

        strQuery = "Exec usp_Upd_tbl_PDB_ProjectAnalysis_Conclusion '" + strConclusion + "'," + m_lngAnalysisID.ToString

        If CommonFunctions.General.CheckIsNothing(strSuggForImprovement, "") <> "" Then
            strQuery = strQuery & ",'" + strSuggForImprovement + "'"
        Else
            strQuery = strQuery + ",NULL"
        End If

        If CommonFunctions.General.CheckIsNothing(strProjFeedback, "") <> "" Then
            strQuery = strQuery + ",'" + strProjFeedback + "'"
        Else
            strQuery = strQuery + ",NULL"
        End If

        If CommonFunctions.General.CheckIsNothing(strPracticesFollowed, "") <> "" Then
            strQuery = strQuery + ",'" + strPracticesFollowed + "'"
        Else
            strQuery = strQuery + ",NULL"
        End If

        If CommonFunctions.General.CheckIsNothing(strShortComings, "") <> "" Then
            strQuery = strQuery + ",'" + strShortComings + "'"
        Else
            strQuery = strQuery + ",NULL"
        End If

        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

    End Sub


    Protected Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage
        ' Purpose               : Main function to plot the Controls on the page
        ' Description           : Called from within the Form from within the <Form> Tag
        '                         Depending on the Passed MODE, this Function calls the 
        '                         Appropriate Function to Plot the page
        ' Parameters Passed     : N/A
        ' Assumptions           : None
        ' Author                : SuryabirD
        ' Created               : Monday, 08 March, 2004
        '=====================================================================
        Dim strMenu As String
        Dim objHeaderFooter As New WebPages.Template.HeaderFooter
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''  CommonFunctions.HTMLControls.DrawTextBox("txtQS", "txtQS", , , , m_strQueryString, , , , , , True)
        CommonFunctions.HTMLControls.DrawTextBox("txtQS", "txtQS", , , , m_strQueryString, , , , , , True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        '-- Display Menu
        strMenu = DrawMenu()
        Response.Write(strMenu + "<BR>")

        '-- Display Caption

        If m_strMode = "LIST" Then
            Response.Write(WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, , , , True))
            Response.Write("<BR>")

            '-- Display header
            objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
            objHeaderFooter.DrawHeaderFooter(m_objGlobal)
            objHeaderFooter = Nothing
        Else
            Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_TITLE"), , , True))
            Response.Write("<BR>")

        End If

        Response.Write("<DIV ID='DivList' Style='WIDTH:100%;OVERFLOW:auto;'>")
        '-- Call Appropriate Function To Plot the Page Depending upon MODE
        Select Case m_strMode
            '-- Main Milestone LIST Page
            Case "LIST"
                Call DisplayMainMilestoneList()

                '-- Milestone DETAIL Page
            Case "DETAIL"
                Call DisplayMilestoneAnalysis_Detail()

                '-- PMI DETAIL Page
            Case "PMI_DETAIL"
                Call DisplayPMI_Detail()

                '-- POPUP Page for Accepting the Slippage and Reason
            Case "SLIP_N_REASON"
                Call Display_Slippage_Reasoning()

                '-- POPUP Page for Accepting the Total LOC
            Case "TOTAL_LOC"
                Call Display_TotalLOC_Page()

                '-- POPUP Page for Accepting the Conclusion
            Case "CONCLUSION"
                Call Display_Conclusion_Page()

                '-- Detail Page for Listing the Causal Analysis Details
            Case "CAUSAL_ANAL"
                Call Display_CausalAnalysis_Page()

                '-- POP-UP Page for Listing the various Causes along with checkboxes
            Case "CAUSAL_DETAILS"
                Call Display_CausalDetails_Page()

            Case Else
        End Select

        Response.Write("</DIV>")

        If m_strMode = "LIST" Then
            '-- Display Footer
            objHeaderFooter = New WebPages.Template.HeaderFooter
            objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
            objHeaderFooter.DrawHeaderFooter(m_objGlobal)
            objHeaderFooter = Nothing
        End If

        Response.Write("<BR>" + strMenu)

        '-- Destroy Objects
        m_objGlobal = Nothing

    End Sub

    Private Sub Display_CausalDetails_Page()
        '=====================================================================
        ' Procedure Name        : Display_CausalDetails_Page
        ' Purpose               : function to plot the Popup Page for Listing Causes
        ' Description           : Called from Clicking the Link 'Add Causes' On the Causal Anal. List Page
        ' Parameters Passed     : MODE=CAUSAL_DETAILS ; ResultID=2834 ; ProjectID=268 ; ANAL_ID=67 ; MilestoneID=4978
        ' Assumptions           : None
        ' Author                : SuryabirD
        ' Created               : Monday, 15 March, 2004
        '=====================================================================

        '-- Show List of Causes with Checkboxes for selecting causes 
        Dim strSQL As String
        Dim arrstrActualList() As String = {"Cause", "Present"}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("CAUSES"), "Select"}
        Dim arrCheckboxOnColumn() As String = {"", "Present"}
        Dim arrCheckBoxID() As String = {"", "chkCause"}
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim lngResultID As Long
        lngResultID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ResultID"), "0"), Long)

        strSQL = "EXEC usp_Sel_GetDeviationCauses " + lngResultID.ToString + ",'M'"

        With m_objCausalDetailsGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
            .CheckboxCheckOnColumnArray = arrCheckboxOnColumn
            .CheckBoxIDArray = arrCheckBoxID
            .PrimaryKey = "CauseID"
            .SQL = strSQL
            .DIVHeight = 0
            .UseSQL = MyBase.UseSQL
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .DrawGrid()
        End With
        m_objCausalDetailsGrid = Nothing

    End Sub

    Private Sub Display_CausalAnalysis_Page()
        '=====================================================================
        ' Procedure Name        : Display_CausalDetails_Page
        ' Purpose               : Main function to plot the Causal Analysis Main List Page
        ' Description           : Called from Clicking the Link 'Causal Analysis' On the Milestone Details Page
        ' Parameters Passed     : MODE=CAUSAL_ANAL; ANAL_ID=67; ProjectID=268 ; MilestoneID=4978
        ' Assumptions           : None
        ' Author                : SuryabirD
        ' Created               : Monday, 08 March, 2004
        '=====================================================================

        Dim strSQL As String
        Dim arrstrActualList() As String = {"MetricName", "AnalysisID", ""}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("DEVIATION"), MyBase.GetResourceString("CAUSES"), MyBase.GetResourceString("ADD_CAUSES")}
        Dim arrRowLink() As String = {"", "", "AddCauses(ResultID)"}
        Dim arrGroupList() As String = {"1"}
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        strSQL = "EXEC usp_Sel_tbl_PDB_Results_MetricName " + m_lngAnalysisID.ToString

        With m_objCausalGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .GroupOnColumn = arrGroupList
            .RowLinkArray = arrRowLink
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
            .SQL = strSQL
            .DIVHeight = 0
            .UseSQL = MyBase.UseSQL
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

            .DrawGrid()
        End With
        m_objCausalGrid = Nothing

    End Sub

    Private Sub Display_Slippage_Reasoning()
        '--Display Slippage and Reasoning page

        Dim strSlippageReason, strActionTaken, strQuery As String
        Dim drTemp As IDataReader

        m_lngAnalysisID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ANAL_ID"), "0"), Long)

        strQuery = "Exec usp_Sel_tbl_PDB_EffortScheduleDeviations " + m_lngAnalysisID.ToString
        drTemp = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)

        If drTemp.Read Then
            strSlippageReason = CommonFunctions.Data.CheckIsDBNull(drTemp("SlippageReasons")).ToString
            strActionTaken = CommonFunctions.Data.CheckIsDBNull(drTemp("ActionTaken")).ToString
        End If
        CommonFunctions.Data.DisposeDataReader(drTemp)
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TABLE Class=clsTable cellspacing=0 width='99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TR class=clsTREven><TD Align=Right vAlign=top>")
        Response.Write(MyBase.GetResourceString("ROOT_CAUSE") + "</TD>")
        Response.Write("<TD Align=Left>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''CommonFunctions.HTMLControls.DrawTextArea("txtSlippageReason", "txtSlippageReason", MyBase.GetResourceString("ROOT_CAUSE"), , , "frmMilestones", , , 400, 75, 2000, strSlippageReason)
        CommonFunctions.HTMLControls.DrawTextArea("txtSlippageReason", "txtSlippageReason", MyBase.GetResourceString("ROOT_CAUSE"), , , "frmMilestones", , , 400, 75, 2000, strSlippageReason, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        CommonFunctions.General.WriteHTML("<SCRIPT Language=javascript>")
        CommonFunctions.General.WriteHTML("var objTemp = GetObjectReference('frmMilestones','txtSlippageReason');")
        CommonFunctions.General.WriteHTML("objTemp.focus();")
        CommonFunctions.General.WriteHTML("</SCRIPT>")
        Response.Write("</TD></TR>")

        Response.Write("<TR class=clsTREven><TD Align=Right vAlign=top>")
        Response.Write(MyBase.GetResourceString("ROOT_CAUSE_SV") + "</TD>")
        Response.Write("<TD Align=Left>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''CommonFunctions.HTMLControls.DrawTextArea("txtActionTaken", "txtActionTaken", MyBase.GetResourceString("ROOT_CAUSE_SV"), , , "frmMilestones", , , 400, 75, 2000, strActionTaken)
        CommonFunctions.HTMLControls.DrawTextArea("txtActionTaken", "txtActionTaken", MyBase.GetResourceString("ROOT_CAUSE_SV"), , , "frmMilestones", , , 400, 75, 2000, strActionTaken, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Response.Write("</TD></TR>")
        Response.Write("</TABLE>")

    End Sub

    Private Sub Display_TotalLOC_Page()
        Dim drMilestones As IDataReader
        Dim dblLOC As Double = 0
        Dim strQuery As String

        strQuery = "Exec usp_Sel_tbl_PDB_ProjectAnalysis " + m_lngAnalysisID.ToString

        drMilestones = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If drMilestones.Read Then
            dblLOC = CType(CommonFunctions.Data.CheckIsDBNull(drMilestones("LOC"), "0"), Double)
        End If
        CommonFunctions.Data.DisposeDataReader(drMilestones)

        '--Display Total LOC page
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TABLE Class=clsTable cellspacing=0 width='99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TR class=clsTREven><TD Align=Right>")
        Response.Write(MyBase.GetResourceString("TOTAL_LOC"))
        Response.Write("</TD><TD Align=Left>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        '' CommonFunctions.HTMLControls.DrawTextBox("txtLOC", "txtLOC", , 100, 8, dblLOC.ToString, "Right", , , , , , , , True)
        CommonFunctions.HTMLControls.DrawTextBox("txtLOC", "txtLOC", , 100, 8, dblLOC.ToString, "Right", , , , , , , , True, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        '-- set focus to First Textbox
        CommonFunctions.General.WriteHTML("<SCRIPT Language=javascript>")
        CommonFunctions.General.WriteHTML("var objTemp = GetObjectReference('frmMilestones','txtLOC');")
        CommonFunctions.General.WriteHTML("objTemp.focus();")
        CommonFunctions.General.WriteHTML("</SCRIPT>")
        Response.Write("</TD></TR>")
        Response.Write("</TABLE>")

    End Sub

    Private Sub Display_Conclusion_Page()
        Dim strQuery, strShortComings As String
        Dim strConclusion, strSuggForImprovement, strProjFeedback, strPracticesFollowed As String
        Dim drMilestones As IDataReader

        strQuery = "Exec usp_Sel_tbl_PDB_ProjectAnalysis " + m_lngAnalysisID.ToString

        drMilestones = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If drMilestones.Read Then
            strConclusion = drMilestones("Conclusion").ToString
            strSuggForImprovement = drMilestones("SuggestionForImprovement").ToString
            strProjFeedback = drMilestones("ProjectFeedback").ToString
            strPracticesFollowed = drMilestones("BestPracticesFollowed").ToString
            strShortComings = drMilestones("Shortcomings").ToString
        Else
            strConclusion = "" : strSuggForImprovement = "" : strProjFeedback = "" : strPracticesFollowed = ""
            strShortComings = ""
        End If
        CommonFunctions.Data.DisposeDataReader(drMilestones)

        '--Display Conclusion entry page
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TABLE Class=clsTRTable cellspacing=0 width='99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TR class=clsTREven><TD Align=Right vAlign=top>")
        Response.Write(MyBase.GetResourceString("CONCLUSION"))
        Response.Write("</TD><TD Align=Left>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        '' CommonFunctions.HTMLControls.DrawTextArea("txtConclusion", "txtConclusion", MyBase.GetResourceString("CONCLUSION"), , , "frmMilestones", , , 400, 75, 2000, strConclusion)
        CommonFunctions.HTMLControls.DrawTextArea("txtConclusion", "txtConclusion", MyBase.GetResourceString("CONCLUSION"), , , "frmMilestones", , , 400, 75, 2000, strConclusion, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Response.Write("</TD></TR>")

        Response.Write("<TR class=clsTREven><TD Align=Right vAlign=top>")
        Response.Write(MyBase.GetResourceString("SUGG_IMPROVE"))
        Response.Write("</TD><TD Align=Left>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''CommonFunctions.HTMLControls.DrawTextArea("txtSuggForImprovement", "txtSuggForImprovement", MyBase.GetResourceString("SUGG_IMPROVE"), , , "frmMilestones", , , 400, 75, 2000, strSuggForImprovement)
        CommonFunctions.HTMLControls.DrawTextArea("txtSuggForImprovement", "txtSuggForImprovement", MyBase.GetResourceString("SUGG_IMPROVE"), , , "frmMilestones", , , 400, 75, 2000, strSuggForImprovement, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Response.Write("</TD></TR>")

        Response.Write("<TR class=clsTREven><TD Align=Right vAlign=top>")
        Response.Write(MyBase.GetResourceString("PROJ_FEEDBACK"))
        Response.Write("</TD><TD Align=Left>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''CommonFunctions.HTMLControls.DrawTextArea("txtProjFeedback", "txtProjFeedback", MyBase.GetResourceString("PROJ_FEEDBACK"), , , "frmMilestones", , , 400, 75, 2000, strProjFeedback)
        CommonFunctions.HTMLControls.DrawTextArea("txtProjFeedback", "txtProjFeedback", MyBase.GetResourceString("PROJ_FEEDBACK"), , , "frmMilestones", , , 400, 75, 2000, strProjFeedback, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Response.Write("</TD></TR>")

        Response.Write("<TR class=clsTREven><TD Align=Right vAlign=top>")
        Response.Write(MyBase.GetResourceString("BEST_PRACTICES"))
        Response.Write("</TD><TD Align=Left>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''CommonFunctions.HTMLControls.DrawTextArea("txtPracticesFollowed", "txtPracticesFollowed", MyBase.GetResourceString("BEST_PRACTICES"), , , "frmMilestones", , , 400, 75, 2000, strPracticesFollowed)
        CommonFunctions.HTMLControls.DrawTextArea("txtPracticesFollowed", "txtPracticesFollowed", MyBase.GetResourceString("BEST_PRACTICES"), , , "frmMilestones", , , 400, 75, 2000, strPracticesFollowed, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Response.Write("</TD></TR>")

        Response.Write("<TR class=clsTREven><TD Align=Right vAlign=top>")
        Response.Write(MyBase.GetResourceString("SHORTCOMINGS"))
        Response.Write("</TD><TD Align=Left>")
        'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        ''CommonFunctions.HTMLControls.DrawTextArea("txtShortComings", "txtShortComings", MyBase.GetResourceString("SHORTCOMINGS"), , , "frmMilestones", , , 400, 75, 2000, strShortComings)
        CommonFunctions.HTMLControls.DrawTextArea("txtShortComings", "txtShortComings", MyBase.GetResourceString("SHORTCOMINGS"), , , "frmMilestones", , , 400, 75, 2000, strShortComings, EnableHTMLEncode:=True)
        'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Response.Write("</TD></TR>")
        Response.Write("</TABLE>")

        '-- set focus to First Textbox
        CommonFunctions.General.WriteHTML("<SCRIPT Language=javascript>")
        CommonFunctions.General.WriteHTML("var objTemp = GetObjectReference('frmMilestones','txtConclusion');")
        CommonFunctions.General.WriteHTML("objTemp.focus();")
        CommonFunctions.General.WriteHTML("</SCRIPT>")
    End Sub


    Private Sub DisplayPMI_Detail()
        '-- Display details of the selected PMI
        '-- Has 2 Grids: 1 Vertical header grid and 1 Details Normal Grid
        '=====================================================================
        ' Procedure Name        : DisplayPMI_Detail
        ' Purpose               : Header for the selected PMI
        ' Description           : Displays the 2 grids containing details of the selected PMI
        ' Parameters Passed     : N/A
        ' Returns               : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : SuryabirD
        ' Created               : Friday, 12 March, 2004
        '=====================================================================

        Dim strSQL As String
        Dim arrstrActualList() As String = {"Name", "description", "Notes", "Active"}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("PMI_NAME"), MyBase.GetResourceString("PMI_DESC"), MyBase.GetResourceString("PMI_NOTES"), MyBase.GetResourceString("PMI_ACTIVE")}
        Dim lngPMIID, lngTypeID As Long
        lngTypeID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("TYPEID"), "0"), Long)
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        strSQL = "EXEC usp_Sel_PMIOfProjecttype " + lngTypeID.ToString

        lngPMIID = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), Long)

        'Following query will find out the PMIID for the selected Project TYpe
        strSQL = "EXEC usp_Sel_PMI_OtherInfo " + lngPMIID.ToString

        Dim objGrid As New WebPages.Template.GenericGrid
        With objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .VerticalDisplay = True
            .SQL = strSQL
            .DIVHeight = 0
            .UseSQL = MyBase.UseSQL
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .DrawGrid()
        End With
        objGrid = Nothing

        Response.Write("<BR>")

        '-- 2nd Grid: 
        Dim arrstrMetActualList() As String = {"CategoryName", "Name", "Above", "Below", "Active"}
        Dim arrstrMetUserFriendlyList() As String = {"", MyBase.GetResourceString("METRICS"), MyBase.GetResourceString("UCL"), MyBase.GetResourceString("LCL"), MyBase.GetResourceString("ACTIVE")}
        Dim arrGroupList() As String = {"1"}
        'Dim arrTDStyle() As String = {"width='0%'", "", "", "", "", "Align=Left"}
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        '' Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        strSQL = "EXEC usp_Sel_PMI_Information " + lngPMIID.ToString + "," + m_lngProjectID.ToString

        With m_objMetricGrid
            .ActualColumnArray = arrstrMetActualList
            .UserFriendlyColumnArray = arrstrMetUserFriendlyList
            .GroupOnColumn = arrGroupList
            '   .TDStyleArray = arrTDStyle
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .SQL = strSQL
            .DIVHeight = 0
            .UseSQL = MyBase.UseSQL
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .DrawGrid()
        End With
        m_objMetricGrid = Nothing

    End Sub

    Private Sub DisplayMainMilestoneList()
        '-- Display the Main List of Milestone Analysis...
        Dim objGrid As New WebPages.Template.GenericGrid

        Dim arrstrActualList() As String = {"ProjectName", "MileStone"}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("PROJECT_NAME"), MyBase.GetResourceString("MILESTONE")}
        Dim arrRowLink() As String = {"", "MilestoneDetails(ProjectID,MilestoneID)"}
        Dim arrGroupBy() As String = {"1"}
        Dim strSQLQuery As String
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        strSQLQuery = "Exec usp_PRS_GetMilestonesForAnalysis " + m_objGlobal.UserID.ToString + "," + m_objGlobal.RoleLevel.ToString + ",NULL"

        With objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .ColumnHeaderAlignment = "left"
            ' .SortBy = m_strSortField
            ' .SortOrder = m_strSortOrder
            '.ClientSideSortFunctionName = "SortBy"
            .RowLinkArray = arrRowLink
            .GroupOnColumn = arrGroupBy
            .PageSize = CommonFunctions.Application.MaximumItemsToShowInList
            .CurrentPage = m_lngCurrentPage
            .SQL = strSQLQuery
            .DIVHeight = 0
            .UseSQL = MyBase.UseSQL
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .DrawGrid()
        End With

        objGrid = Nothing

    End Sub

    Private Sub DisplayMilestoneAnalysis_Detail()
        '-- Detail Main page
        Dim strProjectManager, strPMIName As String
        Dim drProjectDet As IDataReader
        Dim intAnalysisID As Integer
        Dim drMilestones As IDataReader
        Dim strQuery, strStatus As String
        Dim lngTypeID, lngLOC As Long
        Dim strSlippageReason, strActionTaken As String
        Dim strConclusion, strSuggForImprovement, strProjFeedback, strPracticesFollowed, strShortComings As String

        '-- Display Header
        strQuery = "EXEC usp_Sel_PRS_tbl_PM_Project " + m_lngProjectID.ToString
        drProjectDet = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)

        If drProjectDet.Read Then
            lngTypeID = CType(CommonFunctions.Data.CheckIsDBNull(drProjectDet("ProjectTypeID"), "0"), Long)
            strProjectManager = drProjectDet("ProjectManager").ToString

            CommonFunctions.Data.DisposeDataReader(drProjectDet)

            'Gets the PMI for the project
            strQuery = "EXEC usp_Sel_PMIOfProjecttype " + lngTypeID.ToString
            drProjectDet = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)

            If drProjectDet.Read Then
                strPMIName = drProjectDet("ProjectPMI").ToString
            Else
                strPMIName = ""
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drProjectDet)

        strQuery = "Exec usp_Sel_PDB_GetAnalysisID  " + m_lngProjectID.ToString + "," + m_lngMilestoneID.ToString

        drMilestones = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If drMilestones.Read Then
            m_blnGatheredDetails = True
            intAnalysisID = CType(CommonFunctions.Data.CheckIsDBNull(drMilestones("AnalysisID"), "0"), Integer)

            CommonFunctions.Data.DisposeDataReader(drMilestones)

            strQuery = "Exec usp_PDB_CheckReadyForClosure " + intAnalysisID.ToString
            strStatus = CType(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), String)

            If Not strStatus Is Nothing Then
                If strStatus.Trim.ToUpper = "COMPLETE" Then
                    m_blnIsReadyClosure = True
                Else
                    m_blnIsReadyClosure = False
                End If

            Else
                m_blnIsReadyClosure = False
            End If
        Else
            m_blnGatheredDetails = False
        End If
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TABLE Class=clsTable cellspacing=0 width='99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TR class=clsTROdd><TD align = left ><B>" + MyBase.GetResourceString("PROJECT_MGR") + "</B>" + strProjectManager + "</TD>")
        Response.Write("</TR>")
        Response.Write("<TR class=clsTROdd><TD align = left ><B>Process Measurement Indicator : </B> ")
        If strPMIName <> "" Then
            'if the PMI is not defined for the project, executes this part
            Response.Write("<A HREF = 'JavaScript: ViewPMI(" + lngTypeID.ToString + ")'> " + strPMIName + "</A></TD>")
        Else
            'if the PMI is  defined for the project, executes this part
            Response.Write(" " + MyBase.GetResourceString("PMI_NOT_SEL") + " </TD>")
        End If
        Response.Write("</TR>")
        Response.Write("</TABLE><BR>")


        If m_blnGatheredDetails Then
            'If the data is already gathered for the Milestone then executes this part	

            '-- Step 1: Gather Data For Milestone Analysis
            Dim objStep1 As New WebPages.Template.SectionTitle
            With objStep1
                Response.Write(.GetSectionTitle(MyBase.GetResourceString("STEP_1"), "DivStep1", "ShowHideStep1"))
                Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
                Response.Write(.ClientsideScript())
                Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
            End With
            objStep1 = Nothing

            Response.Write("<DIV ID='DivStep1' Style='WIDTH:100%;OVERFLOW:auto;'>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TABLE class=clsTable cellspacing=0 width='99.9%'><TR class =clsTREven ><TD align = left >")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<A  HREF='javascript:GatherDetails()'>")
            Response.Write(MyBase.GetResourceString("GATHER_DET") + "</A></TD></TR>")
            Response.Write("</table>")

            Response.Write("</DIV><BR>")

            '-- Step 2: Milestone Analysis Report 
            Dim objStep2 As New WebPages.Template.SectionTitle
            With objStep2
                Response.Write(.GetSectionTitle(MyBase.GetResourceString("STEP_2"), "DivStep2", "ShowHideStep2"))
                Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
                Response.Write(.ClientsideScript())
                Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
            End With
            objStep2 = Nothing

            Response.Write("<DIV ID='DivStep2' Style='WIDTH:100%;OVERFLOW:auto;'>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TABLE Class=clsTable cellspacing=0 width='99.9%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TR class=clsTREven><TD align = left ><A HREF = 'JavaScript:MilestoneAnalysisReport(" + intAnalysisID.ToString + ")'>" + MyBase.GetResourceString("MS_ANAL_REP") + "</A></TD></TR>")
            Response.Write("</Table>")
            Response.Write("</DIV><BR>")

            '-- Step 3: 
            strQuery = "Exec usp_Sel_tbl_PDB_EffortScheduleDeviations " + intAnalysisID.ToString
            drMilestones = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)

            If drMilestones.Read Then
                strSlippageReason = CommonFunctions.Data.CheckIsDBNull(drMilestones("SlippageReasons")).ToString
                strActionTaken = CommonFunctions.Data.CheckIsDBNull(drMilestones("ActionTaken")).ToString
            End If
            CommonFunctions.Data.DisposeDataReader(drMilestones)

            Dim objStep3 As New WebPages.Template.SectionTitle
            With objStep3
                Response.Write(.GetSectionTitle(MyBase.GetResourceString("STEP_3"), "DivStep3", "ShowHideStep3"))
                Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
                Response.Write(.ClientsideScript())
                Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
            End With
            objStep3 = Nothing

            Response.Write("<DIV ID='DivStep3' Style='WIDTH:100%;OVERFLOW:auto;'>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TABLE Class=clsTable cellspacing=0 width='99.9%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            ''Added by Yogesh J on 10-Feb-2016 to generate token
            'm_PKToken = CommonFunctions.Security.Token.GetToken(CType(Session("intUserID"), String) + CType(intAnalysisID, String) + CType(m_lngProjectID, String) + CType(m_lngMilestoneID, String) + CType(m_lngIsProject, String) + "0" + "0")
            'Added by Tejal D on 12/8/2016 to generate token
            m_PKToken = CommonFunctions.Security.Token.GetToken(CType(intAnalysisID, String) + CType(Session("intUserID"), String) + "0" + "0" + CType(m_lngProjectID, String) + CType(m_lngMilestoneID, String) + CType(m_lngIsProject, String))
            'End of addition Tejal D on 12/8/2016 to generate token 
            ''End of addition by Yogesh J on  10-Feb-2016 to generate token
            Response.Write("<TR class=clsTREven><TD align = left ><A HREF = 'JavaScript:SlippageAndReasoning(" + intAnalysisID.ToString + ")'>" + MyBase.GetResourceString("SLIPPAGE_REASON") + "</A></TD>")
            Response.Write("</TR>")

            If Trim(strSlippageReason) <> "" Then
                Response.Write("<TR class=clsTREven><TD align = left ><B>" + MyBase.GetResourceString("ROOT_CAUSE") + "</B></TD></TR>")
                Response.Write("<TR class=clsTREven><TD align = left >" & Replace(Server.HtmlEncode(strSlippageReason), Chr(13), "<BR>") & "</TD></TR>")
            End If
            If Trim(strActionTaken) <> "" Then
                Response.Write("<TR class=clsTREven><TD align = left ><B>" + MyBase.GetResourceString("ROOT_CAUSE_SV") + "</B></TD></TR>")
                Response.Write("<TR class=clsTREven><TD align = left >" & Replace(Server.HtmlEncode(strActionTaken), Chr(13), "<BR>") & "</TD></TR>")
            End If

            Response.Write("<TR class=clsTREven><TD align = left >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF = 'JavaScript:TotalLOC(" + intAnalysisID.ToString + ")'>Total LOC</A></TD>")
            Response.Write("</TR>")

            strQuery = "Exec usp_Sel_tbl_PDB_ProjectAnalysis " + intAnalysisID.ToString
            drMilestones = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If drMilestones.Read Then
                lngLOC = CType(CommonFunctions.Data.CheckIsDBNull(drMilestones("LOC"), "0"), Long)
            End If
            CommonFunctions.Data.DisposeDataReader(drMilestones)

            If lngLOC <> 0 Then
                Response.Write("<TR class=clsTREven><TD align = left ><B> " + MyBase.GetResourceString("TOTAL_LOC") + " " + lngLOC.ToString + "</B></TD></TR>")
            End If

            Response.Write("</TABLE></DIV></BR>")

            '-- STEP 4: 
            Dim objStep4 As New WebPages.Template.SectionTitle
            With objStep4
                Response.Write(.GetSectionTitle(MyBase.GetResourceString("STEP_4"), "DivStep4", "ShowHideStep4"))
                Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
                Response.Write(.ClientsideScript())
                Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
            End With
            objStep4 = Nothing

            Response.Write("<DIV ID='DivStep4' Style='WIDTH:100%;OVERFLOW:auto;'>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TABLE Class=clsTable cellspacing=0 width='99.9%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            strQuery = "Exec usp_Sel_tbl_PDB_ProjectAnalysis " + intAnalysisID.ToString
            drMilestones = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If drMilestones.Read Then
                If CommonFunctions.Data.CheckIsDBNull(drMilestones("LOC"), "0").ToString = "0" Then
                    Response.Write("<TR class=clsTREven><TD align = left >Causal Analysis</TD>")
                    Response.Write("</TR>")
                Else
                    Response.Write("<TR class=clsTREven><TD align = left ><A HREF = 'JavaScript: CausalAnalysis(" + intAnalysisID.ToString + ")'>Causal Analysis</A></TD>")
                    Response.Write("</TR>")
                End If
            Else
                Response.Write("<TR class=clsTREven><TD align = left >Causal Analysis</TD>")
                Response.Write("</TR>")
            End If

            CommonFunctions.Data.DisposeDataReader(drMilestones)
            Response.Write("<TR class=clsTREven><TD align = left ><A HREF = 'JavaScript:Conclusion(" + intAnalysisID.ToString + ")'>Conclusion</A></TD>")
            Response.Write("</TR>")

            strQuery = "Exec usp_Sel_tbl_PDB_ProjectAnalysis " + intAnalysisID.ToString
            drMilestones = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If drMilestones.Read Then
                strConclusion = drMilestones("Conclusion").ToString
                strSuggForImprovement = drMilestones("SuggestionForImprovement").ToString
                strProjFeedback = drMilestones("ProjectFeedback").ToString
                strPracticesFollowed = drMilestones("BestPracticesFollowed").ToString
                strShortComings = drMilestones("Shortcomings").ToString

            End If
            CommonFunctions.Data.DisposeDataReader(drMilestones)

            If Trim(strConclusion) <> "" Then
                Response.Write("<TR class=clsTREven><TD align = left ><B>Conclusion</B></TD></TR>")
                Response.Write("<TR class=clsTREven><TD align = left >" + Replace(Server.HtmlEncode(strConclusion), Chr(13), "<BR>") + "</TD></TR>")
            End If

            If Trim(strSuggForImprovement) <> "" Then
                Response.Write("<TR class=clsTREven><TD align = left ><B>Suggestions for Improvement</B></TD></TR>")
                Response.Write("<TR class=clsTREven><TD align = left >" + Replace(Server.HtmlEncode(strSuggForImprovement), Chr(13), "<BR>") + "</TD></TR>")
            End If

            If Trim(strProjFeedback) <> "" Then
                Response.Write("<TR class=clsTREven><TD align = left ><B>Project Feedback</B></TD></TR>")
                Response.Write("<TR class=clsTREven><TD align = left >" + Replace(Server.HtmlEncode(strProjFeedback), Chr(13), "<BR>") + "</TD></TR>")
            End If

            If Trim(strPracticesFollowed) <> "" Then
                Response.Write("<TR class=clsTREven><TD align = left ><B>Practices Followed</B></TD></TR>")
                Response.Write("<TR class=clsTREven><TD align = left >" + Replace(Server.HtmlEncode(strPracticesFollowed), Chr(13), "<BR>") + "</TD></TR>")
            End If

            If Trim(strShortComings) <> "" Then
                Response.Write("<TR class=clsTREven><TD align = left ><B>Shortcomings</B></TD></TR>")
                Response.Write("<TR class=clsTREven><TD align = left >" + Replace(Server.HtmlEncode(strShortComings), Chr(13), "<BR>") + "</TD></TR>")
            End If
            Response.Write("</TABLE></DIV></BR>")

            '-- STEP 5: 
            Dim objStep5 As New WebPages.Template.SectionTitle
            With objStep5
                Response.Write(.GetSectionTitle(MyBase.GetResourceString("STEP_5"), "DivStep5", "ShowHideStep5"))
                Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
                Response.Write(.ClientsideScript())
                Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
            End With
            objStep5 = Nothing

            Response.Write("<DIV ID='DivStep5' Style='WIDTH:100%;OVERFLOW:auto;'>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TABLE Class=clsTable cellspacing=0 width='99.9%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TR class=clsTREven><TD align = left >")
            ' Modified By MahendraV On 12:21 PM 5/23/2007 for chnage the Caption 'Close Milestone' to 'Milestone Analysis Closure'
            ' Response.Write("<A  HREF='javascript:CloseAnalysis()'>Close Milestone </A>")
            ' Response.Write("Close Milestone ")
            If m_blnIsReadyClosure = True Then
                Response.Write("<A  HREF='javascript:CloseAnalysis()'>Milestone Analysis Closure </A>")
            Else
                Response.Write("Milestone Analysis Closure")
            End If

            Response.Write("</TD></TR></TABLE></DIV>")

        Else

            'If the data is not gathered for the Milestone then executes this part	

            '-- Step 1: Gather Data For Milestone Analysis
            Dim objStep1 As New WebPages.Template.SectionTitle
            With objStep1
                Response.Write(.GetSectionTitle(MyBase.GetResourceString("STEP_1"), "DivStep1", "ShowHideStep1"))
                Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
                Response.Write(.ClientsideScript())
                Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
            End With
            objStep1 = Nothing

            Response.Write("<DIV ID='DivStep1' Style='WIDTH:100%;OVERFLOW:auto;'>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TABLE Class=clsTable cellspacing=0 width='99.9%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TR class=clsTREven><TD align = left >")
            Response.Write("<A  HREF='javascript:GatherDetails()'>")
            Response.Write(" Gather Details </font></A>")
            Response.Write("</TD></TR>")
            Response.Write("</table></DIV></BR>")

            '-- Step 2:  Milestone Analysis Report 
            Dim objStep2 As New WebPages.Template.SectionTitle
            With objStep2
                Response.Write(.GetSectionTitle(MyBase.GetResourceString("STEP_2"), "DivStep2", "ShowHideStep2"))
                Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
                Response.Write(.ClientsideScript())
                Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
            End With
            objStep2 = Nothing

            Response.Write("<DIV ID='DivStep2' Style='WIDTH:100%;OVERFLOW:auto;'>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TABLE Class=clsTable cellspacing=0 width='99.9%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            'Response.Write("<TR><TD align=left class=clsTDColumnHeader ><B>Step 2. Milestone Analysis Report <B></TD></TR>")
            Response.Write("<TR class=clsTREven><TD align = left >Milestone Analysis Report</TD>")
            Response.Write("</TR>")
            Response.Write("</table></DIV></BR>")

            '-- Step 3:  
            Dim objStep3 As New WebPages.Template.SectionTitle
            With objStep3
                Response.Write(.GetSectionTitle(MyBase.GetResourceString("STEP_3"), "DivStep3", "ShowHideStep3"))
                Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
                Response.Write(.ClientsideScript())
                Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
            End With
            objStep3 = Nothing

            Response.Write("<DIV ID='DivStep3' Style='WIDTH:100%;OVERFLOW:auto;'>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TABLE Class=clsTable cellspacing=0 width='99.9%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TR class=clsTREven><TD align = left >Slippage And Reasoning</TD>")
            Response.Write("</TR>")
            Response.Write("<TR class=clsTREven><TD align = left >Total LOC</TD>")
            Response.Write("</TR>")
            Response.Write("</table></DIV></br>")

            '-- Step 4:  
            Dim objStep4 As New WebPages.Template.SectionTitle
            With objStep4
                Response.Write(.GetSectionTitle(MyBase.GetResourceString("STEP_4"), "DivStep4", "ShowHideStep4"))
                Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
                Response.Write(.ClientsideScript())
                Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
            End With
            objStep4 = Nothing

            Response.Write("<DIV ID='DivStep4' Style='WIDTH:100%;OVERFLOW:auto;'>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TABLE Class=clsTable cellspacing=0 width='99.9%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TR class=clsTREven><TD align = left >Causal Analysis</TD>")
            Response.Write("</TR>")

            Response.Write("<TR class=clsTREven><TD align = left >Conclusion</TD>")
            Response.Write("</TR>")
            Response.Write("</table></DIV></BR>")

            'Step 5
            '-- Step 5:  
            Dim objStep5 As New WebPages.Template.SectionTitle
            With objStep5
                Response.Write(.GetSectionTitle(MyBase.GetResourceString("STEP_5"), "DivStep5", "ShowHideStep5"))
                Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
                Response.Write(.ClientsideScript())
                Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
            End With
            objStep5 = Nothing

            Response.Write("<DIV ID='DivStep5' Style='WIDTH:100%;OVERFLOW:auto;'>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TABLE Class=clsTable cellspacing=0 width='99.9%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TR class=clsTREven><TD align = left >")
            Response.Write("Close Milestone ")
            Response.Write("</TD></TR></table></DIV>")

        End If

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

        objAccess.GetAccess(m_objGlobal)
        m_lngTagID = m_objGlobal.TagID
        m_blnAddAccess = objAccess.Add          'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete    'If User has Delete Access
        m_blnEditAccess = objAccess.Edit        'If user has Edit Access

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
        MyBase.InitializeResources("AppResources.PRO_Milestones", "AppResources")

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CALC_PMI"), MyBase.GetResourceString("MENU_BACK"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CALC_PMI_TOOLTIP"), MyBase.GetResourceString("MENU_BACK_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {"Save_OnClick()", "CalculatePMI()", "Back_OnClick()", "Close_OnClick()", "Help_OnClick(" + m_objGlobal.TagID.ToString + ")"}

        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        m_objMenu = Nothing

        Return strMenu

    End Function

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'initialize the resource file for PRO_ProjectTypeConfiguration page.
        MyBase.InitializeResources("AppResources.PRO_Milestones", "AppResources")
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        '-- Control Access to Menu Links Depending upon MODE 

        If (m_strMode <> "SLIP_N_REASON" And m_strMode <> "TOTAL_LOC" And m_strMode <> "CONCLUSION" And m_strMode <> "CAUSAL_DETAILS") Then
            '-- Don't show 'Save' link on List page
            If Args.MenuColIndex = 0 Then Cancel = True
        End If

        '--Calculate PMI
        If m_strMode <> "CAUSAL_ANAL" Then
            If Args.MenuColIndex = 1 Then Cancel = True
        End If

        If (m_strMode <> "DETAIL" And m_strMode <> "PMI_" And m_strMode <> "CAUSAL_ANAL") Then
            '-- Don't show 'Back' link on List page
            If Args.MenuColIndex = 2 Then Cancel = True
        End If

        '-- Close Link
        If Args.MenuColIndex = 3 Then
            If (m_strMode <> "SLIP_N_REASON" And m_strMode <> "TOTAL_LOC" And m_strMode <> "CONCLUSION" And m_strMode <> "CAUSAL_DETAILS") Then
                Cancel = True
            End If
        End If

        If m_strMode = "DETAIL" Then

        End If
        'Added by MahendraV On 2:20 PM 5/23/2007 for desable the Back link at project level
        ' Start_MV_5/23/2007
        If (m_lngIsProject = 1) And (m_strMode = "DETAIL") And (MyBase.GetResourceString("MENU_BACK") = "Back") Then
            Cancel = True
        End If



        ' End_MV_5/23/2007



    End Sub

    Private Sub m_objMetricGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objMetricGrid.ColumnHeaderTD_BeforePrint
        '-- Settings of PMI Metric Details Page Grid
        If Args.ColIndex = 0 Then
            Args.ColumnName = ""
            Args.TDStyle = "Width:0%"
        End If

        If Args.ColIndex = 1 Then
            Args.Alignment = "Left"
        End If

    End Sub

    Private Sub m_objCausalGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objCausalGrid.DataRowTD_BeforePrint
        '-- Settings of Causal Grid Details Page 
        Dim strHTML, strQuery, strClass As String
        Dim drTemp As IDataReader

        If intCounter Mod 2 = 0 Then
            strClass = "clsTREven"
        Else
            strClass = "clsTROdd"
        End If

        '-- Deviation
        If Args.ColIndex = 0 Then
            strHTML = "<B>" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MetricName"), "").ToString + "</B><BR>"
            strHTML = strHTML + "Norms (" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Below"), "0.00").ToString + "-" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Above"), "0.00").ToString + ")<BR>"
            strHTML = strHTML + "Target = " + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TargetValue"), "0.00").ToString + "<BR>"
            strHTML = strHTML + "Actual Value =" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ActualValue"), "0.00").ToString
            Args.StringToBeInserted = "<TR Class=" + strClass + "><TD vAlign=Top " + Args.TDStyle + " >" + strHTML + "</TD>"
            Cancel = True

        End If

        '-- Causes
        strHTML = ""
        If Args.ColIndex = 1 Then
            strQuery = "Exec usp_Sel_GetDeviationCauses " + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ResultID"), "0").ToString + ",'M'"
            drTemp = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)

            If drTemp.Read Then
                Do
                    If CType(CommonFunctions.Data.CheckIsDBNull(drTemp("Present"), ""), Boolean) Then
                        strHTML = strHTML + drTemp("Cause").ToString + "<BR>"
                    End If

                Loop While drTemp.Read
            Else
                strHTML = ""
            End If
            CommonFunctions.Data.DisposeDataReader(drTemp)
            Args.StringToBeInserted = "<TD Align=Left vAlign=Top>" + strHTML + "</TD>"

            Cancel = True

        End If

        '-- Add Causes
        If Args.ColIndex = 2 Then
            Args.StringToBeInserted = "<TD Align=Left vAlign=Top><A Href='javascript:AddCauses(" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ResultID"), "0").ToString + ")'>" + MyBase.GetResourceString("ADD_CAUSES") + "</A></TD>"
            Cancel = True
        End If

        intCounter = intCounter + 1
    End Sub

    Private Sub m_objCausalGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objCausalGrid.ColumnHeaderTD_BeforePrint
        Args.Alignment = "Left"
    End Sub

    Private Sub m_objMetricGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objMetricGrid.DataRowTD_BeforePrint
        '-- Settings of PMI Metric Details Page Grid
        Dim strHTML As String

        '-- We Append the Unit Name with the UCL and LCL Values
        If Args.ColIndex = 2 Then
            strHTML = FormatNumber(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Above"), "0").ToString, 2) + "" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("UnitName"), "0").ToString
        End If

        If Args.ColIndex = 3 Then
            strHTML = FormatNumber(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Below"), "0").ToString, 2) + "" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("UnitName"), "0").ToString
        End If

        If Args.ColIndex = 2 Or Args.ColIndex = 3 Then
            strHTML = "<TD Align=Right>" + strHTML + "</TD>"
            Args.StringToBeInserted = strHTML
            Cancel = True
        End If

    End Sub
End Class
