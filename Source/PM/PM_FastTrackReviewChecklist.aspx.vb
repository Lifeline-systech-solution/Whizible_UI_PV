'******************************************************************
'           CSPL Code Header
' Project Name     :    PBNIT Enterprise Version
' Module Name      :    Fast Track Review - Checklist 
' Purpose          :    This module is used for getting the checklist items for a fast track review
' Description      :    This page is called from within Fast Track review's checklist tab. 
' Assumptions      :    None
' Dependencies     :    None
' Author           :    ShamkantD
' Reviewed         :    
' Tested           :    
' Created          :    September 10, 2004
' Revisions        :    
'******************************************************************
Imports System.Text
Public Class PM_FastTrackReviewChecklist
    Inherits WebPages.Template.WhizTemplate

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

#Region " Constructor "
    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_FastTrackReviewChecklist", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
#End Region

#Region " Initialized Variables "
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private strQuery As String = ""

    Protected m_sbClientSideScript As New StringBuilder("")
    Protected m_lngProjectID As Long = 0

    Protected m_intChecklistID As Long = 0
    Protected m_lngReviewStatisticsId As Long = 0
    Protected m_strlblCheckList As String = GetCheckListLabelName()
    Protected m_intCReviewTypeId As Long = 0
    Protected m_strAction As String = ""
    Protected m_intMappedToReviewIssue As Integer
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    'Integrated by SuchitraP on 8-May-2009 
    'Added By VarunA on 24-Apr-2009 RequestID-20061
    'Purpose : To have responses depending on resources
    Protected m_strResponseBy As String = ""
    'End By VarunA on 24-Apr-2009 RequestID-20061
    'End of Integration by SuchitraP
#End Region

#Region " Generic Functions "
    Private Function GetCheckListLabelName() As String
        '=====================================================================
        ' Procedure Name        : GetCheckListLabelName()	
        ' Purpose               : Function to get the caption for Checklist
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : ShamkantD
        ' Created               : September 13, 2004
        ' Revisions             : None
        '=====================================================================
        Dim drFieldLabels As IDataReader
        Dim strlblCheckList As String = ""
        ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strQuery = "SELECT * FROM tbl_CNF_ConfigFieldName "
        strQuery = "usp_Sel_tbl_CNF_ConfigFieldName "
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        drFieldLabels = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        While drFieldLabels.Read
            Select Case CType(CommonFunction.Data.CheckIsDBNull(drFieldLabels("FieldName"), ""), String)
                Case "CheckList"
                    strlblCheckList = CType(CommonFunction.Data.CheckIsDBNull(drFieldLabels("Label"), ""), String)
            End Select
        End While
        CommonFunction.Data.DisposeDataReader(drFieldLabels)

        Return strlblCheckList.ToString().Trim()
    End Function
    Private Function GetReviewDetails() As Boolean
        '=====================================================================
        ' Procedure Name        : GetReviewDetails()	
        ' Purpose               : Function to get the review details
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : ShamkantD
        ' Created               : September 13, 2004
        ' Revisions             : None
        '=====================================================================
        Dim drReviewDetails As IDataReader
        ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strQuery = "SELECT * FROM tbl_PM_ReviewStatistics WHERE ReviewStatisticsID = " & m_lngReviewStatisticsId.ToString()
        strQuery = "usp_sel_tbl_PM_ReviewStatistics_ReviewStatisticsId " & m_lngReviewStatisticsId.ToString()
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        drReviewDetails = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        If drReviewDetails.Read Then
            m_intChecklistID = CType(CommonFunction.Data.CheckIsDBNull(drReviewDetails("ChecklistTypeId"), "0"), Long)
            m_intCReviewTypeId = CType(CommonFunction.Data.CheckIsDBNull(drReviewDetails("CReviewTypeID"), "0"), Long)
            'm_blnMappedToReviewIssue = CType(CommonFunction.Data.CheckIsDBNull(drReviewDetails("MappedToReviewIssue"), "false"), Boolean)
        End If

        CommonFunction.Data.DisposeDataReader(drReviewDetails)
        'Added by DipaliS
        strQuery = "usp_Sel_CheckIsReviewTypeMapped " + m_intCReviewTypeId.ToString
        m_intMappedToReviewIssue = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strQuery, MyBase.UseSQL)), Integer)
        'End addition by DipaliS

        Return True
    End Function
    Private Sub SaveChecklistResponses()
        Dim strIssueType As String = CommonFunction.General.CheckIsNothing(Request.Form("hdnCHKIssueType"), "")
        Dim strIssueSubType As String = CommonFunction.General.CheckIsNothing(Request.Form("hdnIssueSubType"), "")
        Dim strIssueCorpSubType As String = CommonFunction.General.CheckIsNothing(Request.Form("hdnIssueCorpSubType"), "")
        Dim strIssueCorpStatus As String = CommonFunction.General.CheckIsNothing(Request.Form("hdnIssueCorpStatus"), "")
        Dim strIssueStatus As String = CommonFunction.General.CheckIsNothing(Request.Form("hdnIssueStatus"), "")
        Dim strIssueCorpSeverity As String = CommonFunction.General.CheckIsNothing(Request.Form("hdnIssueCorpSeverity"), "")
        Dim strIssueSeverity As String = CommonFunction.General.CheckIsNothing(Request.Form("hdnIssueSeverity"), "")
        Dim intRadioButtons As String = CommonFunction.General.CheckIsNothing(Request.Form("hdnRadioButtonsCount"), "")
        Dim intCheckBoxes As String = CommonFunction.General.CheckIsNothing(Request.Form("hdnCheckBoxesCount"), "")
        Dim intDelCheckboxresponses As Integer = 0
        Dim blnRadioSelected As Boolean = False
        Dim blnCheckboxSelected As Boolean = False
        Dim intCtr As Integer = 0
        Dim intCtr2 As Integer = 0
        Dim intProjectChecklistItemId As Integer = 0
        Dim intNegativeResponseId As Integer = 0
        Dim intResponseId As Integer
        'Code added by Syamantak Chavan on 29/August/2011 for Whizible 10.0 Integration
        Dim strRemarkSave As String
        'End Code added by Syamantak Chavan on 29/August/2011 for Whizible 10.0 Integration

        For intCtr = 0 To Request.Form.GetValues("hdnProjectChecklistItemId").Length - 1
            strQuery = ""
            intProjectChecklistItemId = CType(Left(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnProjectChecklistItemId")(intCtr), "0"), Len(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnProjectChecklistItemId")(intCtr), "  ")) - 2), Integer)

            If CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnNegativeResponseId")(intCtr), "") <> "" Then
                intNegativeResponseId = CType(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnNegativeResponseId")(intCtr), "0"), Integer)
            Else
                intNegativeResponseId = 0
            End If
            ''MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
            'OLD VALUE ==>>NEW VALUE  1==>>2 , Left  function added to get R or C
            If Left(Right(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnProjectChecklistItemId")(intCtr), " "), 2), 1) = "R" Then
                ''END MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
                intResponseId = CType(CommonFunction.General.CheckIsNothing(Request.Form("optOption" & intProjectChecklistItemId), "0"), Integer)
				'Code added by Syamantak Chavan on 29/August/2011
                strRemarkSave = CType(CommonFunction.General.CheckIsNothing(Request.Form("RemarkTxt" & intProjectChecklistItemId), ""), String)
            	'Code added by Syamantak Chavan on 29/August/2011
                'INSERT THE CHECK POINT IF ITS NOT AN ISSUE
                If intResponseId <> 0 Then
                    blnRadioSelected = True
                    If intCtr = 0 And intDelCheckboxresponses = 0 Then
                        intDelCheckboxresponses = 1
                    Else
                        intDelCheckboxresponses = 0
                    End If
					'Code added by Syamantak Chavan on 29/August/2011
                    'Modified By VidyaJ - IssueID 11580
                    strQuery = "Exec usp_Ins_Upd_tbl_PM_ChecklistResponses " & m_lngProjectID.ToString() & "," & m_lngReviewStatisticsId.ToString() & ",'R'," & intProjectChecklistItemId.ToString()
                    strQuery &= "," & intResponseId.ToString() & ",'" & strRemarkSave.ToString() & "',null,null,'" & CommonFunction.General.CheckIsNothing(Session("strUserName"), "").ToString() & "'," & intNegativeResponseId.ToString() & ",'" & CommonFunction.General.BuildQueryString(strIssueType) & "'"
                    strQuery &= ",'" & CommonFunction.General.BuildQueryString(strIssueSubType) & "','" & CommonFunction.General.BuildQueryString(strIssueCorpSubType) & "','" & CommonFunction.General.BuildQueryString(strIssueStatus) & "','" & CommonFunction.General.BuildQueryString(strIssueCorpStatus) & "'"
                    strQuery &= ",NULL , NULL,"
                    strQuery &= intDelCheckboxresponses.ToString()
                    CommonFunction.Data.GetDataScalar(strQuery, MyBase.UseSQL)
                    'Commented By Vaijat K ON 09/12/2015 Issue ID-2680
                    'Else
                    '                strQuery = "Exec usp_Upd_tbl_PM_ChecklistResponses_Remarks " & m_lngReviewStatisticsId.ToString() & ",'R'," & intProjectChecklistItemId.ToString()
                    '                strQuery &= ",'" & strRemarkSave.ToString() & "','" & CommonFunction.General.CheckIsNothing(Session("strUserName"), "").ToString() & "'"
                    '                CommonFunction.Data.GetDataScalar(strQuery, MyBase.UseSQL)
              
                End If
                'End of Code added by Syamantak Chavan on 23 June 2011 for Socrates customisation

            End If

            ''MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
            'OLD VALUE ==>>NEW VALUE  1==>>2 , Left  function added to get R or C
            If Left(Right(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnProjectChecklistItemId")(intCtr), " "), 2), 1) = "C" Then
                If Not IsNothing(Request.Form.GetValues("chkOption" & Left(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnProjectChecklistItemId")(intCtr), "0"), Len(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnProjectChecklistItemId")(intCtr), "  ")) - 1))) Then
                    For intCtr2 = 0 To Request.Form.GetValues("chkOption" & Left(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnProjectChecklistItemId")(intCtr), "0"), Len(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnProjectChecklistItemId")(intCtr), "  ")) - 1)).Length - 1
                        blnCheckboxSelected = True
                        If intCtr2 = 0 And intCtr = 0 And intDelCheckboxresponses = 0 Then
                            intDelCheckboxresponses = 1
                        Else
                            intDelCheckboxresponses = 0
                        End If

                        intResponseId = CType(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("chkOption" & Left(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnProjectChecklistItemId")(intCtr), "0"), Len(CommonFunction.General.CheckIsNothing(Request.Form.GetValues("hdnProjectChecklistItemId")(intCtr), "  ")) - 1))(intCtr2), "0"), Integer)
                        intNegativeResponseId = -1

                        'INSERT THE CHECK POINT IF ITS NOT AN ISSUE
                        If intResponseId <> 0 Then
                            strQuery = "Exec usp_Ins_Upd_tbl_PM_ChecklistResponses " & m_lngProjectID.ToString & "," & m_lngReviewStatisticsId.ToString() & ",'R'," & intProjectChecklistItemId.ToString()
                            strQuery &= "," & intResponseId.ToString() & ",'" & strRemarkSave.ToString() & "',null,null,'" & CommonFunction.General.CheckIsNothing(Session("strUserName"), "").ToString() & "'," & intNegativeResponseId.ToString() & ",'" & CommonFunction.General.BuildQueryString(strIssueType) & "'"
                            strQuery &= ",'" & CommonFunction.General.BuildQueryString(strIssueSubType) & "','" & CommonFunction.General.BuildQueryString(strIssueCorpSubType) & "','" & CommonFunction.General.BuildQueryString(strIssueStatus) & "','" & CommonFunction.General.BuildQueryString(strIssueCorpStatus) & "'"
                            strQuery &= "," & intDelCheckboxresponses.ToString()
                            CommonFunction.Data.GetDataScalar(strQuery, MyBase.UseSQL)
                        End If
                    Next
                End If
            End If

            If (Not blnRadioSelected) And (Not blnCheckboxSelected) Then
                strQuery = "DELETE  FROM tbl_PM_ChecklistResponses WHERE ContextId = " & m_lngReviewStatisticsId.ToString() & " and ContextType = 'R' "
                strQuery &= " and RespondedBy = '" & CommonFunction.General.CheckIsNothing(Session("strUserName"), "").ToString() & "' and UniqueId Is Null and ResponseId Is Not Null"
                CommonFunction.Data.GetDataScalar(strQuery, MyBase.UseSQL)
            End If

        Next


        'Added by DipaliS
        'Commneted By Vaijat K ON 17/12/2015 Issue ID -2680
        'Dim strScript As String = ""
        'strScript += "<SCRIPT>" + vbCrLf
        ''Modified by VidyaJ - Security Changes - IssueID - 6197
        'Dim strToken As String
        'strToken = CommonFunctions.Security.Token.GetToken(m_lngReviewStatisticsId.ToString + CType(HttpContext.Current.Session("intUserID"), String) + "0" + "2191")
        ''strScript += "window.parent.location.href = ""../General/CommonPage.aspx?ReviewStatisticsID_PK=" + m_lngReviewStatisticsId.ToString + "&PKToken=" & strToken & "&MasterTagID=2191&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1"""


        'strScript += "</SCRIPT>"
        'Response.Write(strScript)
        'End of Comment By Vaijat K ON 17/12/2015 Issue ID -2680
        'End addition by DipaliS

    End Sub
    Private Sub DrawMenu(Optional ByVal blnShowPaging As Boolean = True)
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShamkantD
        ' Created               : Sep 15, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML
        Dim objPaging As WebPage.Templates.Paging
        Dim strPagingHTML As String

        Dim drReviewStatus As IDataReader
        Dim strQuery As String
        'Modified by NitinVS on 28 Mar 2007 for WhizibleSEM SP 8 Regression Issue 12339 
        ' Added Default value 
        Dim m_strReviewStatus As String = ""
        ' End Modification by NitinVS on 28 Mar 2007 for WhizibleSEM SP 8 Regression Issue 12339 
        m_objMenu = New WebPages.Template.StaticMenu


        'Integrated by MrugajaB on 31st May 2005 for WhizibleSEM SP3
        'Code Added by RajkumarM ONSITE on 21st March 2005 to Disallow Closed Reviews to MOdify


        If m_lngReviewStatisticsId.ToString() <> "" Then
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strQuery = "Select ReviewStatus from tbl_pm_reviewstatistics Where ReviewStatisticsID= " + m_lngReviewStatisticsId.ToString()
            strQuery = "usp_sel_tbl_pm_reviewstatistics_ReviewStatus " + m_lngReviewStatisticsId.ToString()
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            drReviewStatus = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If CommonFunctions.General.CheckIsNothing(drReviewStatus, "") <> "" Then
                If drReviewStatus.Read() Then
                    m_strReviewStatus = CType(CommonFunctions.Data.CheckIsDBNull(drReviewStatus("ReviewStatus"), ""), String)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drReviewStatus)
        End If
        'Modified by NitinVS on 28 Mar 2007 for WhizibleSEM SP 8 Regression Issue 12339 
        'if  m_lngReviewStatisticsId = "" do not plot save link 
        ' Modified By MahendraV On 10:11 AM 7/17/2007 For WhizibleSEM 7
        ' To enable & disable save link on the basis of there access rights.
        ' Start_MV_7/17/2007
        If m_objAccessRights.Edit = True Or m_objAccessRights.Add = True Then

            If m_lngReviewStatisticsId.ToString() <> "" And m_strReviewStatus.ToUpper <> "CLOSED" Then
                ' end Modification by NitinVS on 28 Mar 2007 for WhizibleSEM SP 8 Regression Issue 12339 
                'Integrated by SuchitraP on 8-May-2009 
                'Added By VarunA on 24-Apr-2009 RequestID-20061
                'Purpose : To have save link depending upon logged InUser and the resouce which is logged in not present in Checklist Response table
                If m_strResponseBy = "" Or Session("strUserName").ToString = m_strResponseBy Or (CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT DISTINCT 1 FROM tbl_PM_ChecklistResponses WHERE ContextId = " + m_lngReviewStatisticsId.ToString() + " AND RespondedBy = '" + Session("strUserName").ToString() + "'", MyBase.UseSQL)), String) <> "1" And Session("strUserName").ToString = m_strResponseBy) Then
                    'End By VarunA on 24-Apr-2009 RequestID-20061
                    'End of Integration by SuchitraP
                    arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
                    arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
                    arrClientSideFunctionList.Add("Save_OnClick()")
                    'Integrated by SuchitraP on 8-May-2009 
                    'Added By VarunA on 24-Apr-2009 RequestID-20061
                    'Purpose : To have close link depending upon which is not a logged InUser 
                Else
                    arrMenuCaptionsList.Add("Close")
                    arrMenuToolTipsList.Add("Close")
                    arrClientSideFunctionList.Add("Close_OnClick()")
                End If
                'End By VarunA on 24-Apr-2009 RequestID-20061
                'End of Integration by SuchitraP
            End If
            ' End of Addition

        End If
        'Added By Vaijat K ON 17/12/2015 Issue ID -2680
        If Not arrMenuCaptionsList.Contains("Close") Then
            arrMenuCaptionsList.Add("Close")
            arrMenuToolTipsList.Add("Close")
            arrClientSideFunctionList.Add("Close_OnClick()")
        End If
        'End of Addition By Vaijat K ON 17/12/2015 Issue ID -2680
        ' End_MV_7/17/2007
        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("Help_OnClick('1577')")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu + "<BR>")
    End Sub
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
        ' Author                : ShamkantD
        ' Created               : Sep 15, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function

#End Region

#Region " Page Load Functions "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        ' Modified By MahendraV On 10:11 AM 7/17/2007 For WhizibleSEM 7
        ' To enable & disable save link on the basis of there access rights.
        ' Start_MV_7/17/2007
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.ParentTagID = 2191
        m_objAccessRights.TagID = 2094
        m_objAccessRights.GetAccess()
        ' End_MV_7/17/2007

        m_lngProjectID = CType("0" & CommonFunctions.General.CheckIsNothing(Session("intProjectID")), Long)
        m_lngReviewStatisticsId = CType("0" & CommonFunctions.General.CheckIsNothing(Request.QueryString("ReviewStatisticsID")), Long)
        Dim m_strAction As String = ""
        m_strAction = CommonFunction.General.CheckIsNothing(Request.QueryString("Action"), "").ToString()
        'Integrated by SuchitraP on 8-May-2009 
        'Added By VarunA on 24-Apr-2009 RequestID-20061
        'Purpose : To have the value of Logged InUser in the dropdown
        If CommonFunction.General.CheckIsNothing(Request.QueryString("ResponseBy"), "") <> "" Then
            m_strResponseBy = CommonFunction.General.CheckIsNothing(Request.QueryString("ResponseBy"), "").ToString()
        End If
        If m_strResponseBy = "" Then
            m_strResponseBy = Session("strUserName").ToString
        End If
        'End By VarunA on 24-Apr-2009 RequestID-20061
        'End of Integration by SuchitraP

        'Get Review Details
        GetReviewDetails()

        If m_strAction.ToUpper = "SAVE" Then
            SaveChecklistResponses()
        End If
        ''Added  By Shamkant s 31/12/2015
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
        'Ended By Shamkant s 31/12/2015
    End Sub
    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : the main function to initialize the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : ShamkantD
        ' Created               : September 10, 2004
        ' Revisions             : None
        '=====================================================================
        DrawMenu(False)

        DrawPage()

        DrawMenu(False)
    End Sub
#End Region

#Region " Draw Page "
    Private Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : ShowPageHeader()	
        ' Purpose               : Draw HTML for page 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShamkantD
        ' Created               : September 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim sbHTML As New StringBuilder("")
        Dim drQuestionlist As IDataReader

        Dim drDummy As IDataReader
        Dim strIssueType As String = ""
        Dim strIssueCorpStatus As String = ""
        Dim strIssueStatus As String = ""
        Dim strIssueSubType As String
        Dim strIssueCorpSubType As String
        Dim strIssueSeverity As String = ""
        Dim strIssueCorpSeverity As String = ""
        Dim intCounter As Integer = 0
        Dim intSrNo As Integer = 0
        Dim lngPrevSectionId As Long = 0
        Dim lngNextSectionId As Long = 0
        Dim intRadioButtons As Integer = 0
        Dim intCheckBoxes As Integer = 0
        Dim intTextBoxes As Integer = 0
        Dim lngTempQuestionID As Long = 0
        Dim lngTempRemarkID As Long = 0
        Dim lngReviewStatisticsId As Long = 0


        Dim strRadioChecked As String = ""
        Dim strCheckboxSelected As String = ""
        Dim strRadioDisabled As String = ""
        Dim strRowClass As String = ""
        Dim strQuestionnaire As String = ""
        Dim strHiddenValuesId As String = ""
        Dim strRadioOrCheck As String = ""
        Dim strCheckListItemName As String = ""
        Dim intCheckListItemIDForRemark As String = ""
        Dim strQuestionWithOption As String = ""
        'Added by syamantak chavan on  29/August/2011 
        Dim strRemark As String = ""
        Dim strRemarkText As String = ""
        'End Added by syamantak chavan on  29/August/2011 
        Dim strReviewer As String = ""
        Dim blnMappedToReviewIssue As String = ""
        Dim strHiddenValuesNegative As String = ""
        Dim strHiddenValuesName As String = ""
        Dim strSingleSelectionWtCheckBox As String = ""

        Dim blnFirstQ As Boolean = False
        Dim blnComment As Boolean = False
        Dim strBtnName As String = ""
        Dim lngQuestionOptionID As Long = 0
        Dim strChecklistShortName As String = ""
        Dim intChecklistItemCount As Integer = 0

        Dim intRecordCount As Integer = 0
        Dim intCurrentCount As Integer = 0
        ''ADDED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
        Dim isCheckListMandatory As Boolean = False
        Dim CheckListMandatoryOneorZero As String
        ''END ADDED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
        Dim intRemarkCount As Integer = 0
        'Integrated by SuchitraP on 8-May-2009 
        'Added By VarunA on 24-Apr-2009 RequestID-20061
        'Purpose : To have the value of Logged InUser in the dropdown and to pass the value depending upon selection.
        'strQuery = "Exec usp_tbl_PM_GetProjectChecklistItems  " & m_intChecklistID.ToString() & ","
        'strQuery &= m_lngReviewStatisticsId.ToString() & ",'R',Null"
        'If CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT DISTINCT 1 FROM tbl_PM_ChecklistResponses WHERE ContextId = " + m_lngReviewStatisticsId.ToString() + " AND RespondedBy = '" + Session("strUserName").ToString() + "'", MyBase.UseSQL)), String) <> "1" And m_strResponseBy.ToString = "" Then
        '    strQuery = "Exec usp_tbl_PM_GetProjectChecklistItems  " & m_intChecklistID.ToString() & ","
        '    strQuery &= m_lngReviewStatisticsId.ToString() & ",'R',Null"
        'Else
        strQuery = "Exec usp_tbl_PM_GetProjectChecklistItems  " & m_intChecklistID.ToString() & ","
        strQuery &= m_lngReviewStatisticsId.ToString() & ",'R','" + CommonFunction.General.BuildQueryString(m_strResponseBy.ToString) + "'"
        'End If
        'End By VarunA on 24-Apr-2009 RequestID-20061
        'End of Integration by SuchitraP


        '=========================================================
        ' DISPLAYING CHECKLIST
        '=========================================================
        drQuestionlist = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        ' Get the record count
        While drQuestionlist.Read
            intRecordCount += 1
        End While

        CommonFunction.Data.DisposeDataReader(drQuestionlist)

        drQuestionlist = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        sbHTML.Append("<div id=DivMain style=""width:100%;overflow:auto;height:100%"">")

        ''MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
        ''99.9 ==>>99.99
        sbHTML.Append("<TABLE class=clsTable cellspacing=0 cellpadding=0 width='99.99%'>")
        ''END MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
        intSrNo = 0
        lngPrevSectionId = 0
        lngNextSectionId = 0
        intRadioButtons = 0
        intCheckBoxes = 0
        intTextBoxes = 0
        blnFirstQ = True

        '''<IMG src="../../Images/Star.gif" border=0>
        While drQuestionlist.Read
            intCurrentCount += 1
            If intCounter = 0 Then
                strChecklistShortName = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("ChecklistShortName"), ""), String)
                sbHTML.Append("<TR class=clsTRPageCaption>")
                sbHTML.Append("<TD width=25%  style='border:thin' align=""left"">")
                sbHTML.Append(m_strlblCheckList & " : " & strChecklistShortName)
                'Code Commented by Noble K on 15th Jan 2005 
                'sbHTML.Append("</TD>")
                'sbHTML.Append("<TD width=75%  style='border:thin' align=""left"">")
                'sbHTML.Append(strChecklistShortName)

                'This hidden textbox is used when Save link is clicked and page is refreshed
                sbHTML.Append("<Input Type=Hidden Name=txtSaveFlag id=txtSaveFlag value=""0"">")
                'Changed to check .Please revert back REMEMBER......
                'sbHTML.Append("<Input Type=Text Name=txtSaveFlag id=txtSaveFlag value=""0"">")

                sbHTML.Append("</TD>")
                sbHTML.Append("</TR>")

                sbHTML.Append("<TR class=clsTREven>")
                sbHTML.Append("<TD align=""right"" colspan=2>")
                sbHTML.Append("(Note : Responses in bold characters represent negative responses.)")
                sbHTML.Append("</TD>")
                sbHTML.Append("</TR>")
                'Integrated by SuchitraP on 8-May-2009 
                'Modified and Added By VarunA on 24-Apr-2009 RequestID-20061
                'Purpose : To have dropdown for Response BY.
                'sbHTML.Append("</TABLE><BR>")
                sbHTML.Append("<BR><TR class=clsTREven>")
                sbHTML.Append("<TD align=""Center"" colspan=2>")
                sbHTML.Append("Responded By")
                sbHTML.Append("&nbsp;")

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboRespondedBy", "SELECT DISTINCT RespondedBy AS ResponseID,RespondedBy FROM tbl_PM_ChecklistResponses WHERE ContextId =" + m_lngReviewStatisticsId.ToString(), 150, m_strResponseBy, " onChange=ResponseBy_OnChange(this) ", True, True))
                sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboRespondedBy", "usp_tbl_PM_ChecklistResponses_ResponseID_RespondedBy " + m_lngReviewStatisticsId.ToString(), 150, m_strResponseBy, " onChange=ResponseBy_OnChange(this) ", True, True))
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                sbHTML.Append("</TD>")
                sbHTML.Append("</TR>")
                sbHTML.Append("</TABLE><BR>")
                'End By VarunA on 24-Apr-2009 RequestID-20061
                'End of Integration by SuchitraP
                ''MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
                ''99.9 ==>>99.99
                sbHTML.Append("<TABLE class=clsTable cellspacing=0 cellpadding=0 width='99.99%' id=tblChecklist>")
                ''END MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780

                sbHTML.Append("<TR class=clsTRColumnHeader>")
                'sbHTML.Append("<TD align=""center"" nowrap width=""10%"">")
                'sbHTML.Append("Sr")
                'sbHTML.Append("</TD>")
                'Added By Syamantak Chavan On 14-Oct-2011 for Whizible 10.0 Issue
                sbHTML.Append("<TD>")
                sbHTML.Append("</TD>")
                'End added By Syamantak Chavan On 14-Oct-2011 for Whizible 10.0 Issue
                sbHTML.Append("<TD nowrap>")
                sbHTML.Append(m_strlblCheckList & " Item")
                sbHTML.Append("</TD>")
                'Code Added by Noble K 15th Jan 2005 to insert a blank cell

                ''MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780

                ''''sbHTML.Append("<TD width = 20%>&nbsp;</TD>")
                ''''sbHTML.Append("<TD width = 40% align = left>&nbsp;&nbsp;Responses</TD>")
                sbHTML.Append("<TD >&nbsp;</TD>")
                sbHTML.Append("<TD align = left>&nbsp;&nbsp;Responses</TD>")
                'sbHTML.Append("<TD >&nbsp;</TD>")
                sbHTML.Append("<TD width = 40% align = left>&nbsp;&nbsp;Remarks</TD>")
                'Code Added by Noble K 15th Jan 2005 to insert a blank cell
                'Code Commented by Noble K 15th Jan 2005
                'sbHTML.Append("<TD >&nbsp;Responses</TD>")
                'sbHTML.Append("<TD align=center width=""10%"">Comments</TD>")
                sbHTML.Append("</TR>")

                ''END MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780

                '=======================================================
                'GET THE ISSUE TYPE OF THE SELECTED REVIEW TYPE
                '=======================================================
                strQuery = "EXEC usp_sel_tbl_PM_CorporateReviewIssueMapping " & m_intCReviewTypeId.ToString()
                drDummy = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If drDummy.Read Then
                    strIssueType = CType(CommonFunction.Data.CheckIsDBNull(drDummy("Type"), ""), String)
                End If
                CommonFunction.Data.DisposeDataReader(drDummy)

                ' Modified By NitinVS on 2 Apr 2007 for whizibleSEM SP 8 regression Issue 11580 
                ' Handled single quote 

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'strQuery = "SELECT TYPE FROM tbl_IB_Project_Sub_Type WHERE PROJECTID = " & m_lngProjectID.ToString() & " AND CORPORATETYPE = '" & CommonFunction.General.BuildQueryString(strIssueType) & "'"
                strQuery = "usp_tbl_IB_Project_Sub_Type_TYPE " & m_lngProjectID.ToString() & ",'" & CommonFunction.General.BuildQueryString(strIssueType) & "'"
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                ' End Modification By NitinVS on 2 Apr 2007 for whizibleSEM SP 8 regression Issue 11580 

                drDummy = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If drDummy.Read Then
                    strIssueType = CType(CommonFunction.Data.CheckIsDBNull(drDummy("Type"), ""), String)
                End If
                CommonFunction.Data.DisposeDataReader(drDummy)

                'GETTING DEFAULT ISSUE SUB TYPE  IF ANY
                'Modified By VidyaJ - IssueID - 11580
                strQuery = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'ST'," & m_lngProjectID.ToString() & ",'" & CommonFunction.General.BuildQueryString(strIssueType) & "'"
                drDummy = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If drDummy.Read Then
                    strIssueCorpStatus = CType(CommonFunction.Data.CheckIsDBNull(drDummy("CorporateStatus"), ""), String)
                    strIssueStatus = CType(CommonFunction.Data.CheckIsDBNull(drDummy("Status"), ""), String)
                End If
                CommonFunction.Data.DisposeDataReader(drDummy)

                'GETTING DEFAULT ISSUE STATUS IF ANY
                'Modified By VidyaJ - IssueID - 11580
                strQuery = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'S'," & m_lngProjectID.ToString() & ",'" & CommonFunction.General.BuildQueryString(strIssueType) & "'"
                drDummy = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If drDummy.Read Then
                    strIssueSubType = CType(CommonFunction.Data.CheckIsDBNull(drDummy("SubType"), ""), String)
                    strIssueCorpSubType = CType(CommonFunction.Data.CheckIsDBNull(drDummy("CorporateSubType"), ""), String)
                End If
                CommonFunction.Data.DisposeDataReader(drDummy)


                'GETTING DEFAULT ISSUE SEVERITY IF ANY
                strQuery = "Exec USP_SEL_tbl_IB_Project_Severity  " & m_lngProjectID.ToString() & ",1"

                drDummy = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If drDummy.Read Then
                    strIssueSeverity = CType(CommonFunction.Data.CheckIsDBNull(drDummy("Severity"), ""), String)
                    strIssueCorpSeverity = CType(CommonFunction.Data.CheckIsDBNull(drDummy("CorporateSeverity"), ""), String)
                End If
                CommonFunction.Data.DisposeDataReader(drDummy)

                'Modified By VarunA on 23-Sep-2008 IssueID-22512
                'Purpose : To have id with input fields (Mozilla)
                'sbHTML.Append("<Input Type=Hidden Name=hdnCHKIssueType value=""" & strIssueType & """>")
                'sbHTML.Append("<Input Type=Hidden Name=hdnIssueSubType value=""" & strIssueSubType & """>")
                'sbHTML.Append("<Input Type=Hidden Name=hdnIssueCorpSubType value=""" & strIssueCorpSubType & """>")
                'sbHTML.Append("<Input Type=Hidden Name=hdnIssueCorpStatus value=""" & strIssueCorpStatus & """>")
                'sbHTML.Append("<Input Type=Hidden Name=hdnIssueStatus value=""" & strIssueStatus & """>")
                'sbHTML.Append("<Input Type=Hidden Name=hdnIssueCorpSeverity value=""" & strIssueCorpSeverity & """>")
                'sbHTML.Append("<Input Type=Hidden Name=hdnIssueSeverity value=""" & strIssueSeverity & """>")
                sbHTML.Append("<Input Type=Hidden id=hdnCHKIssueType Name=hdnCHKIssueType value=""" & strIssueType & """>")
                sbHTML.Append("<Input Type=Hidden id=hdnIssueSubType Name=hdnIssueSubType value=""" & strIssueSubType & """>")
                sbHTML.Append("<Input Type=Hidden id=hdnIssueCorpSubType Name=hdnIssueCorpSubType value=""" & strIssueCorpSubType & """>")
                sbHTML.Append("<Input Type=Hidden id=hdnIssueCorpStatus Name=hdnIssueCorpStatus value=""" & strIssueCorpStatus & """>")
                sbHTML.Append("<Input Type=Hidden id=hdnIssueStatus Name=hdnIssueStatus value=""" & strIssueStatus & """>")
                sbHTML.Append("<Input Type=Hidden id=hdnIssueCorpSeverity Name=hdnIssueCorpSeverity value=""" & strIssueCorpSeverity & """>")
                sbHTML.Append("<Input Type=Hidden id=hdnIssueSeverity Name=hdnIssueSeverity value=""" & strIssueSeverity & """>")
                'End By VarunA on 23-Sep-2008 IssueID-22512

                'Added by DipaliS 
                lngTempQuestionID = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("ProjectCheckListItemID"), "0"), Long)
                lngTempRemarkID = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("ProjectCheckListItemID"), "0"), Long)
                'Added by syamantak chavan on  29/August/2011
                strBtnName = "RemarkTxt" & lngTempQuestionID
                strRemarkText = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("Remarks"), ""), String)
                'strRemarkText = CType(CommonFunction.General.CheckIsNothing(Request.Form("RemarkTxt" & lngTempQuestionID), ""), String)
                ''strRemark &= "&nbsp;<INPUT id=" & strBtnName & _
                ''" name=" & strBtnName & " type=textarea class=clsTextBox value=""" & strRemarkText & """" & " >"
                ''Commented added by Shamkant S on 30 Nov 2015 
                '' strRemark &= "&nbsp;<Textarea wrap='Hard'  id=" & strBtnName & _
                '' " maxlength=200 name=" & strBtnName & " class='clsTextArea'  style='width:250px  ; height:50px  ; text-align:Left'; rows=5; cols =20>" & strRemarkText & "</Textarea>"
                strRemark &= "&nbsp;<Textarea wrap='Hard'  id=" & strBtnName & _
              " maxlength=200 name=" & strBtnName & " class='clsTextArea'  style='width:220px  ; height:50px  ; text-align:Left'; rows=5; cols =20>" & strRemarkText & "</Textarea>"

                'End Added by syamantak chavan on  29/August/2011              
                'end addition
            End If


            '--- Check for the question ID
            intCounter = intCounter + 1
            strRadioChecked = ""
            strCheckboxSelected = ""
            strRadioDisabled = ""



            If lngTempQuestionID <> CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("ProjectCheckListItemID"), "0"), Long) Then
                intSrNo += 1
                ''Following Comment added by Amit Mahadik on 04 May 2011
                ''YOU WILL GET NEXT ProjectChecklistItem HERE, AS RECORDSET CAN HAVE MULTIPLE RECORDS HAVING SAME 
                ''ProjectChecklistItemID you will get next here...(i.e. next row to display on UI)

                ''ADDED BY AMIT MAHADIK ON 04 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780

                isCheckListMandatory = False
                CheckListMandatoryOneorZero = "0"
                Dim strSQLCheckListMandatory As String
                Dim strToBeInsertImage As String = ""
                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'strSQLCheckListMandatory = "SELECT Compulsory FROM  tbl_PM_WorkOrderChecklistItem_Published WHERE ProjectCheckListItemID = " & CommonFunction.General.CheckIsNothing(lngTempQuestionID, "0")
                strSQLCheckListMandatory = "usp_sel_tbl_PM_WorkOrderChecklistItem_Published_Compulsory " & CommonFunction.General.CheckIsNothing(lngTempQuestionID, "0")
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                isCheckListMandatory = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLCheckListMandatory, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")
                If isCheckListMandatory Then
                    CheckListMandatoryOneorZero = "1"
                    'Commented By Syamantak Chavan On 14-Oct-2011 for Whizible 10.0 Issue
                    'strToBeInsertImage = "&nbsp;&nbsp;<IMG src=""../../Images/Star.gif"" border=0></td></TR>"
                    'Added By Syamantak Chavan On 14-Oct-2011 for Whizible 10.0 Issue
                    strToBeInsertImage = "<td width=8px><IMG src=""../../Images/Star.gif"" border=0></td>"
                Else
                    CheckListMandatoryOneorZero = "0"
                    'strToBeInsertImage = "</td></TR>"
                    strToBeInsertImage = "<td width=8px></td>"
                End If

                ''END ADDED BY AMIT MAHADIK ON 04 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780

                If intSrNo Mod 2 = 0 Then
                    strRowClass = "clsTREven"
                Else
                    strRowClass = "clsTROdd"
                End If

                lngTempQuestionID = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("ProjectCheckListItemID"), "0"), Long)

                'lngNextSectionId = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("CaytegoryID"), "0"), Long)

                '--Display the section for checklist items
                If lngNextSectionId <> lngPrevSectionId Then
                    strQuestionnaire &= "<TR class=clsTRSectionHeader>"
                    ''MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
                    strQuestionnaire &= "<TD style='border:thin' align=""left"" COLSPAN=5>"
                    ''END MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
                    strQuestionnaire &= CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("Description"), ""), String)
                    strQuestionnaire &= "</TD>"
                    strQuestionnaire &= "</TR>"
                    lngPrevSectionId = lngNextSectionId
                    'strRowClass = "clsTROdd"
                    intCounter = 1
                End If

                '--- Display the questions and options in the table.		
                strQuestionnaire &= "<TR class=" & strRowClass & ">"

                'Modified By VarunA on 23-Sep-2008 IssueID-22512
                'Purpose : To have id with input fields (Mozilla)
                'strQuestionnaire &= "<Input Type=Hidden Name=hdnProjectChecklistItemId value=" & strHiddenValuesId & strRadioOrCheck & ">"
                'strQuestionnaire &= "<Input Type=Hidden Name=hdnNegativeResponseId value=" & strHiddenValuesNegative & ">"
                'strQuestionnaire &= "<Input Type=Hidden Name=hdnChecklistItemName value=" & strHiddenValuesName & ">"
                strQuestionnaire &= "<Input Type=Hidden id=hdnProjectChecklistItemId Name=hdnProjectChecklistItemId value=" & strHiddenValuesId & strRadioOrCheck & CheckListMandatoryOneorZero & ">"
                strQuestionnaire &= "<Input Type=Hidden id=hdnNegativeResponseId Name=hdnNegativeResponseId value=" & strHiddenValuesNegative & ">"
                strQuestionnaire &= "<Input Type=Hidden id=hdnChecklistItemName Name=hdnChecklistItemName value=" & strHiddenValuesName & ">"


                'End By VarunA on 23-Sep-2008 IssueID-22512
                'Added By Syamantak Chavan On 14-Oct-2011 for Whizible 10.0 Issue
                strQuestionnaire &= strToBeInsertImage
                'End Added By Syamantak Chavan On 14-Oct-2011 for Whizible 10.0 Issue
                '--- Display Column Sr. No.
                'strQuestionnaire &= "<TD align=center valign=Top><B>" & intSrNo & "</B></TD>"
                'strQuestionnaire &= "<TD align=center valign=Top>" & "</TD>"
                '--- Display column for Question and its option
                strQuestionnaire &= "<TD align=left>" & strCheckListItemName & "</TD>"

                'Code Added by Noble K on 15th Jan 2005 to insert a blank cell
                ''MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
                strQuestionnaire &= "<TD ></TD>" '''width = 20% amit m
                ''END MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
                'Code Addition by Noble K 15th Jan 2005 Ends
                ''MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
                strQuestionnaire &= "<TD align=left>" & strQuestionWithOption ''''''& "</TD>" amit m
                ''END MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
                strQuestionnaire &= "<TD align=left>" & strRemark & "</TD>"

                'strQuestionnaire &= "<TD align=Center>"

                'If blnComment = True Then
                'strQuestionnaire &= "<a href=""javascript:EnterComments_OnClick(" & strHiddenValuesId & "," & lngReviewStatisticsId & ",'" & strReviewer & "','" & blnMappedToReviewIssue & "') "">Enter</a>"
                'End If
                'strQuestionnaire &= "&nbsp;</TD>"

                'Displaying the options for the above question with respect to the
                '-Parameters assigned for the question for eg. Question type-Single selection,
                '-multiple selection etc.

                strCheckListItemName = ""
                strQuestionWithOption = ""
                strRemark = ""
                strSingleSelectionWtCheckBox = ""

                strHiddenValuesId = ""
                strHiddenValuesName = ""
                strHiddenValuesNegative = ""

                blnComment = False

                ''ADDED BY AMIT MAHADIK ON 04 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
                'Commented By Syamantak Chavan On 14-Oct-2011 for Whizible 10.0 Issue
                'strQuestionnaire &= strToBeInsertImage
                ''END ADDED BY AMIT MAHADIK ON 04 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780

                '--- Generate the string for questions and options
                '--- Generate the string for Question and its realated option with the respective control
                '--- (option btn / check box)
                strCheckListItemName = HttpUtility.HtmlEncode(CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("CheckListItemName"), ""), String))
                blnComment = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("ShowComment"), "False"), Boolean)

                '--- Append the Option to the question
                strHiddenValuesId = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("ProjectCheckListItemID"), ""), String)
                strHiddenValuesName = HttpUtility.HtmlEncode(CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("CheckListItemName"), ""), String))

                If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("IsNegative"), "False"), Boolean) = True Then
                    strHiddenValuesNegative = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), ""), String)
                End If

                If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("SingleSelection"), "False"), Boolean) = True Then
                    intRadioButtons = intRadioButtons + 1
                    intTextBoxes = intTextBoxes + 1
                    '--- Set the radio button to the option.
                    '												If drQuestionlist.Fields("QuestionnaireOptionID").value = drQuestionlist.Fields("ResponseID").value Then
                    If InStr(CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("Responses"), ""), String), "," & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), ""), String) & ",") > 0 Then
                        strRadioChecked = " Checked "
                    End If

                    If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("UniqueId"), ""), String) <> "0" Then
                        strRadioDisabled = " Disabled "
                    End If


                    strBtnName = "optOption" & lngTempQuestionID
                    lngQuestionOptionID = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), "0"), Long)
                    strQuestionWithOption &= "&nbsp;<INPUT id=" & strBtnName & _
                    " name=" & strBtnName & " type=radio class=clsOptionButton value=""" & lngQuestionOptionID & """" & strRadioChecked & " " & strRadioDisabled & _
                    " >"
                    'Added by syamantak chavan on  29/August/2011
                    strBtnName = "RemarkTxt" & lngTempQuestionID
                    strRemarkText = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("Remarks"), ""), String)
                    'strRemarkText = CType(CommonFunction.General.CheckIsNothing(Request.Form("RemarkTxt" & lngTempQuestionID), ""), String)
                    'strRemark &= "&nbsp;<INPUT id=" & strBtnName & _
                    '" name=" & strBtnName & " type=text class=clsTextBox value=""" & strRemarkText & """" & " >"
                    'Commentd added by Shamkant S on 30 Nov 2015
                    ' strRemark &= "&nbsp;<Textarea wrap='Hard'  id=" & strBtnName & _
                    ' " maxlength=10 name=" & strBtnName & " class='clsTextArea'  style='width:250px  ; height:50px  ; text-align:Left'; rows=5; cols =20>" & strRemarkText & "</Textarea>"
                    strRemark &= "&nbsp;<Textarea wrap='Hard'  id=" & strBtnName & _
                   " maxlength=10 name=" & strBtnName & " class='clsTextArea'  style='width:220px  ; height:50px  ; text-align:Left'; rows=5; cols =20>" & strRemarkText & "</Textarea>"
                    'End added by Shamkant S on 30 Nov 2015
                    'End Added by syamantak chavan on  29/August/2011
                    '--- Set option description
                    If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("IsNegative"), "False"), Boolean) = True Then
                        strQuestionWithOption &= "<B>" & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("OptionDescription"), ""), String) & "</b>"
                    Else
                        strQuestionWithOption &= CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("OptionDescription"), ""), String)
                    End If

                    strBtnName = ""
                    lngQuestionOptionID = 0

                ElseIf CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("MultipleSelection"), "False"), Boolean) = True Then
                    intCheckBoxes += 1

                    If InStr(CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("Responses"), ""), String), "," & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), ""), String) & ",") > 0 Then
                        strCheckboxSelected = " Checked "
                    End If

                    '--- Set the check boxes to the option.
                    strBtnName = "chkOption" & lngTempQuestionID.ToString()
                    lngQuestionOptionID = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), "0"), Long)
                    strQuestionWithOption &= "&nbsp;<INPUT id=" & strBtnName & _
                    " name=" & strBtnName & " type=checkbox class=clsCheckBox value=""" & lngQuestionOptionID & """ " & strCheckboxSelected & _
                    " >"

                    '--- Set option description
                    'If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("IsNegative"), "False"), Boolean) = True Then
                    'strQuestionWithOption &= "<B>" & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("OptionDescription"), ""), String) & "</b>"
                    'Else
                    strQuestionWithOption &= CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("OptionDescription"), ""), String)
                    'End If

                    strBtnName = ""
                    lngQuestionOptionID = 0

                ElseIf CBool(CommonFunction.Data.CheckIsDBNull(drQuestionlist("SingleSelectionWithCheckBox"), "False")) = True Then
                    strQuestionWithOption = ""
                    strBtnName = "chkOption" & lngTempQuestionID
                    lngQuestionOptionID = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("ProjectCheckListItemID"), "0"), Long)
                    strSingleSelectionWtCheckBox = "&nbsp;<INPUT id=" & strBtnName & " name=" & strBtnName & " type=checkbox class=clsCheckBox value=""" & lngQuestionOptionID & """" & " >"
                    strBtnName = ""
                    lngQuestionOptionID = 0
                End If
            Else
                ''Following Comment added by Amit Mahadik on 04 May 2011
                ''YOU WILL GET consecutive same ProjectChecklistItemID HERE, AS RECORDSET CAN HAVE MULTIPLE RECORDS HAVING SAME 
                ''ProjectChecklistItemID you will get next consecutive same ProjectChecklistItemID HERE...(i.e. same row on UI and you can append rediobuttons or checkboxes here...)

                lngNextSectionId = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("CaytegoryID"), "0"), Long)
                '--- Generate the string for questions and options
                '--- Generate the string for Question and its realated option with the respective control
                '--- (option btn / check box)
                strCheckListItemName = HttpUtility.HtmlEncode(CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("CheckListItemName"), ""), String))
                blnComment = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("ShowComment"), "False"), Boolean)

                '--- Append the Option to the question
                strHiddenValuesId = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("ProjectCheckListItemID"), ""), String)
                strHiddenValuesName = HttpUtility.HtmlEncode(CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("CheckListItemName"), ""), String) & "")
                If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("IsNegative"), "False"), Boolean) = True Then
                    strHiddenValuesNegative = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), ""), String)
                End If

                If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("SingleSelection"), "False"), Boolean) = True Then
                    strRadioOrCheck = "R"
                    If intRadioButtons = 0 Then
                        intRadioButtons = 1
                    End If
                    '												If drQuestionlist.Fields("QuestionnaireOptionID").value = drQuestionlist.Fields("ResponseID").value Then
                    If InStr(CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("Responses"), ""), String), "," & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), ""), String) & ",") > 0 Then
                        strRadioChecked = " Checked "
                    End If

                    If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("UniqueId"), ""), String) <> "0" Then
                        strRadioDisabled = " Disabled "
                    End If


                    '--- Set the radio button to the option.
                    strBtnName = "optOption" & lngTempQuestionID
                    lngQuestionOptionID = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), "0"), Long)
                    strQuestionWithOption &= "&nbsp;<INPUT id=" & strBtnName & _
                    " name=" & strBtnName & " type=radio class=clsOptionButton value=""" & lngQuestionOptionID & """" & strRadioChecked & " " & strRadioDisabled & _
                    " >"

                    '--- Set option description
                    If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("IsNegative"), "False"), Boolean) Then
                        strQuestionWithOption &= "<B>" & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("OptionDescription"), ""), String) & "</b>"

                    Else
                        strQuestionWithOption &= CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("OptionDescription"), ""), String)
                    End If

                    strBtnName = ""
                    lngQuestionOptionID = 0
                ElseIf CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("MultipleSelection"), "False"), Boolean) = True Then
                    '--- Set the check boxes to the option.
                    strRadioOrCheck = "C"
                    If intCheckBoxes = 0 Then
                        intCheckBoxes = intCheckBoxes + 1
                    End If

                    If InStr(CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("Responses"), ""), String), "," & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), ""), String) & ",") > 0 Then
                        strCheckboxSelected = " Checked "
                    End If

                    strBtnName = "chkOption" & lngTempQuestionID
                    lngQuestionOptionID = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), "0"), Long)
                    strQuestionWithOption &= "&nbsp;<INPUT id=" & strBtnName & _
                        " name=" & strBtnName & " type=checkbox class=clsCheckBox value=""" & lngQuestionOptionID & """ " & strCheckboxSelected & _
                        " >"

                    '--- Set option description
                    'If CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("IsNegative"), "False"), Boolean) = True Then
                    'strQuestionWithOption &= "<B>" & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("OptionDescription"), ""), String) & "</b>"
                    'Else
                    strQuestionWithOption &= CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("OptionDescription"), ""), String)
                    ' End If

                    strBtnName = ""
                    lngQuestionOptionID = 0

                ElseIf CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("SingleSelectionWithCheckBox"), "False"), Boolean) = True Then
                    strQuestionWithOption = ""
                    strBtnName = "chkOption" & lngTempQuestionID
                    lngQuestionOptionID = CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("QuestionnaireOptionID"), "0"), Long)
                    strSingleSelectionWtCheckBox = "&nbsp;<INPUT id=" & strBtnName & " name=" & strBtnName & " type=checkbox class=clsCheckBox value=""" & lngQuestionOptionID & """" & " >"
                    strBtnName = ""
                    lngQuestionOptionID = 0
                End If
            End If

            'Process the last Record
            If intCurrentCount = intRecordCount Then
                'intCounter = intCounter + 1
                intSrNo = intSrNo + 1

                If intSrNo Mod 2 = 0 Then
                    'strRowClass = "clsTDEven"
                    strRowClass = "clsTREven"
                Else
                    'strRowClass = "clsTDOdd"
                    strRowClass = "clsTROdd"
                End If

                '--Display the section for checklist items
                If lngNextSectionId <> lngPrevSectionId Then
                    strQuestionnaire &= "<TR class=clsTRSectionHeader>"
                    strQuestionnaire &= "<TD style='border:thin' align=""left"" COLSPAN=4>"
                    strQuestionnaire &= CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("Description"), ""), String)
                    strQuestionnaire &= "</TD>"
                    strQuestionnaire &= "</TR>"
                    lngPrevSectionId = lngNextSectionId
                    'strRowClass = "clsTDOdd"
                    'strRowClass = "clsTROdd"
                    intCounter = 1
                End If

                ''MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
                isCheckListMandatory = False
                CheckListMandatoryOneorZero = "0"
                Dim strSQLCheckListMandatory As String

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strSQLCheckListMandatory = "SELECT Compulsory FROM  tbl_PM_WorkOrderChecklistItem_Published WHERE ProjectCheckListItemID = " & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("ProjectCheckListItemID"), ""), String)
                strSQLCheckListMandatory = "usp_sel_tbl_PM_WorkOrderChecklistItem_Published_Compulsory " & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("ProjectCheckListItemID"), ""), String)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                isCheckListMandatory = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLCheckListMandatory, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")
                If isCheckListMandatory Then
                    CheckListMandatoryOneorZero = "1"
                Else
                    CheckListMandatoryOneorZero = "0"
                End If
                ''END MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780

                strQuestionnaire &= "<TR class=" & strRowClass & ">"
                'Modified By VarunA on 23-Sep-2008 IssueID-22512
                'Purpose : To have id with input fields (Mozilla)
                'strQuestionnaire &= "<Input Type=Hidden Name=hdnProjectChecklistItemId value=" & strHiddenValuesId & strRadioOrCheck & ">"
                'strQuestionnaire &= "<Input Type=Hidden Name=hdnNegativeResponseId value=" & strHiddenValuesNegative & ">"
                'strQuestionnaire &= "<Input Type=Hidden Name=hdnChecklistItemName value=" & strHiddenValuesName & ">"
                strQuestionnaire &= "<Input Type=Hidden id=hdnProjectChecklistItemId Name=hdnProjectChecklistItemId value=" & strHiddenValuesId & strRadioOrCheck & CheckListMandatoryOneorZero & ">"
                strQuestionnaire &= "<Input Type=Hidden id=hdnNegativeResponseId Name=hdnNegativeResponseId value=" & strHiddenValuesNegative & ">"
                strQuestionnaire &= "<Input Type=Hidden id=hdnChecklistItemName Name=hdnChecklistItemName value=" & strHiddenValuesName & ">"
                'End By VarunA on 23-Sep-2008 IssueID-22512

                'Added By syamantak Chavan On 14-Oct-2011 for whizible 10.0 Issue
                If isCheckListMandatory Then
                    'Commented By Syamantak Chavan On 14-Oct-2011 for Whizible 10.0 Issue
                    'strQuestionnaire &= "&nbsp;&nbsp;<IMG src=""../../Images/Star.gif"" border=0></td></TR>"
                    'Added By Syamantak Chavan On 14-Oct-2011 for Whizible 10.0 Issue
                    strQuestionnaire &= "<td width=8px><IMG src=""../../Images/Star.gif"" border=0></td>"
                Else
                    'strQuestionnaire &= "</td></TR>"
                    strQuestionnaire &= "<td width=8px></td>"
                End If
                'End Added By syamantak Chavan On 14-Oct-2011 for whizible 10.0 Issue
                '--- Display Column Sr. No.
                'strQuestionnaire &= "<TD align=center><b>" & intSrNo & "</b></TD>"
                'Code Commented by Noble  K 15th Jan 2005
                'strQuestionnaire &= "<TD align=center>" & "</TD>"

                '--- Display column for Question and its option//
                'Commented by Shamkant Sapkale 30 Nov 2015
                'strQuestionnaire &= "<TD align=left>" & strCheckListItemName & "</TD>"
                strQuestionnaire &= "<TD align=left>" & HttpUtility.HtmlEncode(strCheckListItemName) & "</TD>"
                'Commented ended by Shamkant S 30 Nov 2015

                'Code Added by Noble K on 15th Jan 2005 to insert a blank cell
                strQuestionnaire &= "<TD width = 20%></TD>"
                'Code Addition by Noble K 15th Jan 2005 Ends

                strQuestionnaire &= "<TD align=left >" & strQuestionWithOption
                'strQuestionnaire &= "<TD align=Center>"
                strQuestionnaire &= "<TD align=left>" & strRemark & "</TD>"

                'If blnComment = True Then
                'strQuestionnaire &= "<a href=""javascript:EnterComments_OnClick(" & strHiddenValuesId & "," & lngReviewStatisticsId & ",'" & strReviewer & "','" & blnMappedToReviewIssue & "') "">Enter</a>"
                'End If

                'strQuestionnaire &= "&nbsp;</TD>"

                ''Following Comment added by Amit Mahadik on 04 May 2011
                ''clear variable for next row...
                strCheckListItemName = ""
                strQuestionWithOption = ""
                strSingleSelectionWtCheckBox = ""
                strRemark = ""
                ''ADDED BY AMIT MAHADIK ON 04 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780

                '''isCheckListMandatory = False
                '''CheckListMandatoryOneorZero = "0"
                '''Dim strSQLCheckListMandatory As String
                '''strSQLCheckListMandatory = "SELECT Compulsory FROM  tbl_PM_WorkOrderChecklistItem_Published WHERE ProjectCheckListItemID = " & CType(CommonFunction.Data.CheckIsDBNull(drQuestionlist("ProjectCheckListItemID"), ""), String)
                '''CheckListMandatoryOneorZero = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLCheckListMandatory, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")
                '''isCheckListMandatory = CheckListMandatoryOneorZero
                'Commented By Syamantak Chavan On 14-Oct-2011 for Whizible 10.0 Issue
                'If isCheckListMandatory Then
                '    'Commented By Syamantak Chavan On 14-Oct-2011 for Whizible 10.0 Issue
                '    'strQuestionnaire &= "&nbsp;&nbsp;<IMG src=""../../Images/Star.gif"" border=0></td></TR>"
                '    'Added By Syamantak Chavan On 14-Oct-2011 for Whizible 10.0 Issue
                '    strQuestionnaire &= "<td width=10px><IMG src=""../../Images/Star.gif"" border=0></td>"
                'Else
                '    'strQuestionnaire &= "</td></TR>"
                '    strQuestionnaire &= "<td width=10px></td>"
                'End If
                'End Commented By Syamantak Chavan On 14-Oct-2011 for Whizible 10.0 Issue
                ''END ADDED BY AMIT MAHADIK ON 04 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780


            End If
            '--- Display the comment box under the question options

        End While

        CommonFunction.Data.DisposeDataReader(drQuestionlist)

        If intRecordCount > 0 Then
            ''--- Display the questions and options in the table.
            sbHTML.Append(strQuestionnaire)

            intChecklistItemCount = intRecordCount
            'Modified By VarunA on 23-Sep-2008 IssueID-22512
            'Purpose : To have id with input fields (Mozilla)
            'sbHTML.Append("<Input Type=Hidden Name=hdnChecklistItemCount value=""" & intChecklistItemCount & """>")
            'sbHTML.Append("<Input Type=Hidden  Name=hdnRadioButtonsCount value=""" & intRadioButtons & """>")
            'sbHTML.Append("<Input Type=Hidden Name=hdnCheckBoxesCount value=""" & intCheckBoxes & """>")
            sbHTML.Append("<Input Type=Hidden id=hdnChecklistItemCount Name=hdnChecklistItemCount value=""" & intChecklistItemCount & """>")
            sbHTML.Append("<Input Type=Hidden  id=hdnRadioButtonsCount Name=hdnRadioButtonsCount value=""" & intRadioButtons & """>")
            sbHTML.Append("<Input Type=Hidden id=hdnCheckBoxesCount Name=hdnCheckBoxesCount value=""" & intCheckBoxes & """>")
            'End By VarunA on 23-Sep-2008 IssueID-22512
        Else
            intChecklistItemCount = 0
            sbHTML.Append("<TABLE class=clsTable cellspacing=0 cellpadding=0 width='99.9%' id=tblChecklist>")
            sbHTML.Append("<TR class=clsTRColumnHeader>")
            'sbHTML.Append("<TD align=""center"" nowrap width=""10%"">")
            'sbHTML.Append("Sr")
            'sbHTML.Append("</TD>")
            'Added By Syamantak Chavan On 14-Oct-2011 for Whizible 10.0 Issue
            sbHTML.Append("<TD>")
            sbHTML.Append("</TD>")
            'End added By Syamantak Chavan On 14-Oct-2011 for Whizible 10.0 Issue
            sbHTML.Append("<TD align=""left"" nowrap>")
            sbHTML.Append(m_strlblCheckList & " Item")
            sbHTML.Append("</TD>")
            'Code Added by Noble K 15th Jan 2005 to insert a blank cell
            sbHTML.Append("<TD width = 20%>&nbsp;</TD>")
            ''MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
            '' OLD VALUE:40%
            sbHTML.Append("<TD width = 20% align = left>&nbsp;&nbsp;Responses</TD>")
            ''END MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
            'Code Added by Noble K 15th Jan 2005 to insert a blank cell
            'Code Commented by Noble K 15th Jan 2005
            'sbHTML.Append("<TD align=center width=""20%"">&nbsp;Responses</TD>")
            'sbHTML.Append("<TD align=center width=""10%"">Comments</TD>")
            sbHTML.Append("</TR>")

            sbHTML.Append("<TR class=clsTROdd>")
            sbHTML.Append("<TD align=center colspan=4>There are no items to show in this view.</td>")
            sbHTML.Append("</TR>")
        End If

        sbHTML.Append("</TABLE>")
        sbHTML.Append("<BR><BR>")
        sbHTML.Append("</div>")

        CommonFunctions.General.WriteHTML(sbHTML.ToString())
    End Sub
#End Region

    Private Sub m_objGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_AfterPrint

    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print


    End Sub
End Class
