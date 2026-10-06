Public Class RT_VerifyResourceTimesheetDetails
    Inherits WebPages.Template.WhizTemplate

#Region "CSPL Page Header"
    '**********************************************************************************
    '                  CSPL Code Header
    ' Project Name     :	Project By Net V4 - Bhagirath
    ' Module Name      :	VerifyResourceTimesheetDetails.asp
    ' Purpose          :	This page displays details of a resource timesheet 
    '						for verification. Verifier enters Remarks against each 
    '						day activity. These verification remarks, verified by and verification
    '						date are saved to Resource Timesheet and Daily Activity tables
    ' Description      :	This page displays resource timesheet details for verification
    '						and saves verification remarks entered by the verifier to 
    '						corresponding tables
    ' Assumptions      :	The stored procedures, and tables are present.
    ' Dependencies     :	SM_CommonFunctions.asp
    ' Author           :	AmitD
    ' Reviewed         :	
    ' Tested           :	
    ' Created          :	19 JUL 2004
    ' Revisions        :	
    '**********************************************************************************
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
    End Sub

#End Region

#Region "Initialized Variables"
    '##### Private Members
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Protected m_strWindowTitle As String
    Protected m_intTagID As Integer
    Private m_intProjectID As Integer
    Protected m_strEmployeeID As String
    Private m_drTimesheet As IDataReader
    Private m_intTotalAHM As Double
    Private m_intTotalOverTime As Double
    Private m_intIndex As Integer
    Protected m_strTimesheetStatus As String
    Dim m_intAccessAdd As Integer
    Dim m_intAccessDelete As Integer
    Protected m_strTimesheetID As String
    Protected m_strPrevTimesheetID As String

    Private m_blnSentMailForRemarks As Boolean
    Private m_strPrevProjectName As String
    Private m_strProjectName As String
    Private m_dblProjectTotal As Double

    Protected m_TagVerifyTimesheetList As Long = CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET
    Protected m_TimesheetHistoryForApprover As Long = CommonFunction.Constants.APP_TAG_RTS_SHOW_HISTORY_APPROVERS

    '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
    Protected m_strToken As String
    Protected m_strToken_ApproveReject As String
    Protected s_ParentTagID As Long = 0
    '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197

    '##### End 


    '##### Variables Declaration
    '---Variables to store access details
    Dim strQuery As String



    '---Variables to store Request QueryString/Form values
    Dim strMode As String
    Dim strToPage As String
    Dim strSaveWithVerification As String
    'Dim strTimesheetID As String
    Protected strSortByField As String
    Protected strAscOrDesc As String
    Dim strSelectedVerifyCheckBox As String
    Protected strResourceID As String

    Private m_ProjectName As String = ""

    '---Variables to store Timesheet Details



    '---Variables to store Verification details 
    Dim intEntryID As Integer



    '---This flag is True when all "Verified" checkboxes are checked i.e. Daily Activity entries are set as Verified

    Dim blnSendMail As String

    'Added by VidyaJ on 13th Nov 2003
    Dim strDailyActivityIDS As String



    Dim strPrevProject As String
    Dim strCurrentProject As String



    'Added by Lakshmi on 5th Feb 2004 - begin
    Dim drPercentComplete As IDataReader
    Dim drDAComplete As IDataReader
    Dim strSQLQuery As String
    Dim fltTotalDAWork As Double
    Dim fltTotalTaskWork As Double
    Dim strFromDate As String
    Dim strToDate As String
    Dim dblTotalExtraAMH As Double
    Dim dblTotalAMH As Double
    '##### End 
    'Start-AUJ-22Jan2007
    Dim blnAcceptDATYpe As Boolean = False
    'End-AUJ-22Jan2007

    'ShraddhM
    Private strTaskID As String

#End Region

#Region "Page Load Functions"
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Use Resources Solution
        m_strWindowTitle = MyBase.GetResourceString("VERIFY_RESOURCE_TIMESHEET_DTLS")
        m_intIndex = 1
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
        ' Author                : AmitD
        ' Created               : Jul 19 , 2004
        ' Revisions             :
        '=====================================================================
        'Addition by SnehalV 2nd Nov 2006 for WhizibleSEM SP8 Integration
        'AUJ
        'Modified by ShraddhaM on 2,Apr 2008 for Task ToolTip 
        If Request.QueryString("FromXML") = "1" Then
            strTaskID = Request.QueryString("TaskID")
            Response.Clear()
            Call getToolTipInfo()
            Response.End()
        Else

            Dim strTemp As System.Text.StringBuilder
            Dim cntTSIDLen As Integer
            Dim strTSIDLen As String
            Dim cntInd As Integer
            'Start-AUJ-22Jan2007

            'Commented and added by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
            'blnAcceptDATYpe = CType(CommonFunction.Data.GetDataScalar("select isnull(AcceptDAType, 0) from tbl_PM_CompanyInformation with (nolock)", MyBase.UseSQL), Boolean)
            blnAcceptDATYpe = CType(CommonFunction.Data.GetDataScalar("usp_tbl_PM_CompanyInformation_AcceptDAType", MyBase.UseSQL), Boolean)
            'End of addition by Yogesh Jalamkar on 08-Aug-2016 To Remove Inline Query
            'End-AUJ-22Jan2007
            'End of addition by SnehalV

            m_intProjectID = CType(Session("intProjectID"), Integer)

            'Get Values From Query String
            'Get Request querystring/form variables
            strDailyActivityIDS = ""
            'Wherever 'AUJ is written code is added/commented by AmrutaJ on 16-Nov-2006 for placing the dropdown on UI page and related functionality.
            'AUJ'm_strTimesheetID = CType(Request.QueryString("TimesheetID"), String)
            m_strEmployeeID = CType(Session("intUserID"), String)
            'AUJ'strResourceID = CType(Request.QueryString("EmployeeID"), String)
            strSortByField = CType(Request.QueryString("SortField"), String)
            strAscOrDesc = CType(Request.QueryString("SortOrder"), String)
            strMode = CType(Request.QueryString("Mode"), String)
            strSaveWithVerification = CType(Request.QueryString("Verification"), String)
            'AUJ'm_strTimesheetStatus = CType(Request.QueryString("TimesheetStatus"), String)
            'm_strTimesheetStatus = "V"

            'AUJ
            If (CType(Request.QueryString("Mode"), String) Is Nothing) Then
                m_strTimesheetID = CType(Request.QueryString("TimesheetID"), String)
                Dim IdrTemp As IDataReader = CommonFunction.Data.GetDataReader("usp_sel_WSEM_TimesheetDetails " + m_strTimesheetID + ", " + CType(m_strEmployeeID, String), True)
                If IdrTemp.Read Then
                    'strFromDate = CType(CommonFunctions.Data.CheckIsDBNull(IdrTemp("FromDate"), CType(Now(), String)), String)
                    'strToDate = CType(CommonFunctions.Data.CheckIsDBNull(IdrTemp("ToDate"), CType(Now(), String)), String)
                    m_strTimesheetStatus = CType(CommonFunctions.Data.CheckIsDBNull(IdrTemp("StatusCode"), ""), String)
                    'strResourceID = CType(CommonFunctions.Data.CheckIsDBNull(IdrTemp("EmployeeID"), ""), String)
                End If
                CommonFunction.Data.DisposeDataReader(IdrTemp)
                IdrTemp = Nothing
                '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                If Request.QueryString("PKToken") <> "" Then
                    m_strToken = Request.QueryString("PKToken") & ""
                Else
                    m_strToken_ApproveReject = CommonFunctions.Security.Token.GetToken(m_strTimesheetID + CType(m_strEmployeeID, String) + CType(s_ParentTagID, String) + CType(m_TagVerifyTimesheetList, String))
                End If
                '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
            ElseIf (CType(Request.QueryString("Mode"), String).ToUpper = "VERIFY" Or CType(Request.QueryString("Mode"), String).ToUpper = "UNVERIFY") Then
                m_strTimesheetID = CType(Request.Form("cboTSIDs"), String)

                Dim IdrTemp As IDataReader = CommonFunction.Data.GetDataReader("usp_sel_WSEM_TimesheetDetails " + m_strTimesheetID + ", " + CType(m_strEmployeeID, String), True)
                If IdrTemp.Read Then
                    strFromDate = CType(CommonFunctions.Data.CheckIsDBNull(IdrTemp("FromDate"), CType(Now(), String)), String)
                    strToDate = CType(CommonFunctions.Data.CheckIsDBNull(IdrTemp("ToDate"), CType(Now(), String)), String)
                    m_strTimesheetStatus = CType(CommonFunctions.Data.CheckIsDBNull(IdrTemp("StatusCode"), ""), String)
                    strResourceID = CType(CommonFunctions.Data.CheckIsDBNull(IdrTemp("EmployeeID"), ""), String)
                End If
                CommonFunction.Data.DisposeDataReader(IdrTemp)
                IdrTemp = Nothing
                '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                If Request.QueryString("PKToken") <> "" Then
                    m_strToken = Request.QueryString("PKToken") & ""
                Else
                    m_strToken_ApproveReject = CommonFunctions.Security.Token.GetToken(m_strTimesheetID + CType(m_strEmployeeID, String) + CType(s_ParentTagID, String) + CType(m_TagVerifyTimesheetList, String))
                End If
                '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                HandleModesAndActions()
                If m_strPrevTimesheetID Is Nothing Then
                    m_strPrevTimesheetID = "0"
                End If
                'Modified By VarunA on 26-June-2008 RequestID-9568
                'Purpose : To have Approve & Review Next functionality
                'If m_strTimesheetID Is Nothing Or m_strPrevTimesheetID <> m_strTimesheetID Then
                If m_strTimesheetID Is Nothing And m_strPrevTimesheetID <> m_strTimesheetID Then
                    'End By VarunA on 26-June-2008 RequestID-9568
                    CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                    CommonFunctions.General.WriteHTML("window.location.href = '../RT/RT_TimesheetApproval.aspx?MasterTagID=" + CType(m_TagVerifyTimesheetList, String) + "';")
                    CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                    Exit Sub
                End If
                'Added By VarunA on 7-Oct-2008 IssueID-23382
                'Purpose : After clicking on reject link, it should come to list page.
                If strSaveWithVerification = "0" Or strMode = "Unverify" Then
                    CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                    CommonFunctions.General.WriteHTML("window.location.href = '../RT/RT_TimesheetApproval.aspx?MasterTagID=" + CType(m_TagVerifyTimesheetList, String) + "';")
                    CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                    Exit Sub
                End If
                'End By VarunA on 7-Oct-2008 IssueID-23382
                IdrTemp = CommonFunction.Data.GetDataReader("usp_sel_WSEM_TimesheetDetails " + m_strTimesheetID + ", " + CType(m_strEmployeeID, String), True)
                If IdrTemp.Read Then
                    strFromDate = CType(CommonFunctions.Data.CheckIsDBNull(IdrTemp("FromDate"), CType(Now(), String)), String)
                    strToDate = CType(CommonFunctions.Data.CheckIsDBNull(IdrTemp("ToDate"), CType(Now(), String)), String)
                    m_strTimesheetStatus = CType(CommonFunctions.Data.CheckIsDBNull(IdrTemp("StatusCode"), ""), String)
                    strResourceID = CType(CommonFunctions.Data.CheckIsDBNull(IdrTemp("EmployeeID"), ""), String)
                End If
                CommonFunction.Data.DisposeDataReader(IdrTemp)
                IdrTemp = Nothing
            End If
            'AUJ

            strSelectedVerifyCheckBox = CType(MyBase.GetFormValue("chkVerify"), String)
            strSelectedVerifyCheckBox = CType(",", String) + CType(strSelectedVerifyCheckBox, String) + CType(",", String)
            blnSendMail = CType(Request.QueryString("SendMail"), String)
            m_intTagID = 2016

            '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
            If Request.QueryString("PKToken") <> "" Then
                m_strToken = Request.QueryString("PKToken") & ""
            Else
                m_strToken_ApproveReject = CommonFunctions.Security.Token.GetToken(m_strTimesheetID + CType(m_strEmployeeID, String) + CType(s_ParentTagID, String) + CType(m_TagVerifyTimesheetList, String))
            End If
            '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197

            CommonFunctions.General.WriteHTML("<DIV id='DivMain' name='DivMain' style='Overflow:auto;width:100%;'>")
            ' DrawMenu()
            ' WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("VERIFY_RESOURCE_TIMESHEET_DTLS"))



            '##### Get Activity record details for the resource timesheet
            strQuery = "usp_Sel_ResourceTimesheetDADetails " + CType(m_strTimesheetID, String) + "," + CType(Session("intUserID"), String)
            m_drTimesheet = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If m_drTimesheet.Read Then
                strFromDate = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("FromDate"), CType(Now(), String)), String)
                strToDate = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("ToDate"), CType(Now(), String)), String)
                dblTotalAMH = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("TotalAMH"), ""), Double)
                dblTotalExtraAMH = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("TotalExtraAMH"), ""), Double)
            End If

            ' Modified By nitinVS on 20 Sep 2006 for WhizibleSEM SP 7 Resource Timesheet Performance. IssueID 6341 
            ' Moved the dispose datareader to the page init as it is not used here 
            CommonFunctions.Data.DisposeDataReader(m_drTimesheet)
            ' End Modification By nitinVS on 20 Sep 2006 for WhizibleSEM SP 7 Resource Timesheet Performance. IssueID 6341 

            '##### End 
            CheckRoleAccess()
            DrawMenu()
            ' DrawPageLegend()
            'Start_AJ_16-Oct-2006
            'Addition By SnehalV 2nd Nov 2006 for WhizibleSEM SP8 Integration
            strTSIDLen = HttpContext.Current.Session("TSIDs").ToString
            cntTSIDLen = Len(strTSIDLen)
            strTSIDLen = Left(strTSIDLen, cntTSIDLen - 1)
            If cntTSIDLen > 8000 Then
                strTSIDLen = Left(strTSIDLen, 8000)
                cntInd = InStrRev(strTSIDLen, ",")
                strTSIDLen = Left(strTSIDLen, cntInd - 1)
            End If
            'Added By VarunA on 3-Dec-2007 DSS RequestID-10747
            'Purpose : If TimesheeID is more than 8000 characters
            Dim strTSIDS As String = HttpContext.Current.Session("TSIDs").ToString
            Dim strArray(2) As String
            Dim maxStringLength As Integer = 6000
            Dim i As Integer = 0
            Dim strTargetString As String = strTSIDS
            Dim strIndex As Integer = 0
            Dim strToken As String
            If strTSIDS.Length / maxStringLength < 3 Then
                For i = 0 To 2
                    If (strTargetString.Length <= maxStringLength) Then
                        strArray(i) = strTargetString
                        Exit For
                    End If
                    strToken = strTargetString.Substring(strIndex, maxStringLength)
                    strToken = strToken.Substring(0, strToken.LastIndexOf(",") + 1)
                    strArray(i) = strToken
                    strTargetString = strTargetString.Substring(strToken.Length)
                Next
            Else
                Response.Write("<script>alert('Error....\n Action is abnormally terminated.'); </script>")
            End If
            'End By VarunA on 3-Dec-2007

            strTemp = New System.Text.StringBuilder
            strTemp.Append("Timesheet For: ")
            'Modified By VarunA on 3-Dec-2007 DSS RequestID-10747
            'Purpose : If TimesheeID is more than 8000 characters
            'strTemp.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTSIDs", "usp_sel_WSEM_TSIDS '" & HttpContext.Current.Session("TSIDs").ToString & "', " + HttpContext.Current.Session("intUserID").ToString + ", 0", 300, m_strTimesheetID.ToString, "onchange=""cboTSID_OnChange()""", , True))
            'strTemp.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTSIDsHidden", "usp_sel_WSEM_TSIDS '" & HttpContext.Current.Session("TSIDs").ToString & "', " + HttpContext.Current.Session("intUserID").ToString + ",1", 300, m_strTimesheetID.ToString, , , True, , , , True))
            strTemp.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTSIDs", "usp_sel_WSEM_TSIDS '" & strArray(0) & "','" & strArray(1) & "','" & strArray(2) & "', " + HttpContext.Current.Session("intUserID").ToString + ", 0", 300, m_strTimesheetID.ToString, "onchange=""cboTSID_OnChange()""", , True))
            strTemp.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTSIDsHidden", "usp_sel_WSEM_TSIDS '" & strArray(0) & "','" & strArray(1) & "','" & strArray(2) & "', " + HttpContext.Current.Session("intUserID").ToString + ",1", 300, m_strTimesheetID.ToString, , , True, , , , True))
            'End By VarunA on 3-Dec-2007
            strTemp.Append("<a style='TEXT-DECORATION:None' ")
            strTemp.Append(" href='javascript:Previous_OnClick()' ><Font Size=1 face=Arial;verdana color=black>|")
            'Commented and Added By Bharat T on 27th-Oct-2015
            'strTemp.Append("<Font Size=1 face=Arial;verdana color=Black>&nbsp;<b id=lblThisMonth>")
            'Commented And Added By Vaijat K On 18/11/2015
            'strTemp.Append("<Font Size=2 face=Arial;verdana color=Black>&nbsp;<b id=lblThisMonth>")
            strTemp.Append("<Font Size=2 face=Arial;verdana color=Black>&nbsp;")
            'Commented and Added By Bharat T on 27th-Oct-2015
            'Commented And Added By Vaijat K On 18/11/2015
            'strTemp.Append("Previous" + "</font></b></font>")
            strTemp.Append("Previous" + "</font></font>")
            strTemp.Append("</a><Font Size=2 face=Arial;verdana color=black>")

            strTemp.Append("<a style='TEXT-DECORATION:None' ")
            strTemp.Append(" href='javascript:Next_OnClick()' ><Font Size=1 face=Arial;verdana color=black>|")
            'Commented and Added By Bharat T on 27th-Oct-2015
            'strTemp.Append("<Font Size=1 face=Arial;verdana color=Black>&nbsp;<b id=lblAssignedTasks>")
            'Commented And Added By Vaijat K On 18/11/2015
            'strTemp.Append("<Font Size=3 face=Arial;verdana color=Black>&nbsp;<b id=lblAssignedTasks>")
            strTemp.Append("<Font Size=2 face=Arial;verdana color=Black>&nbsp;")
            'Commented and Added By Bharat T on 27th-Oct-2015
            'Commented And Added By Vaijat K On 18/11/2015
            'strTemp.Append("Next" + "</font></b></font>")
            strTemp.Append("Next" + "</font></font>")
            'End of Addition by SnehalV
            'End_AJ_16-Oct-2006

            WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("VERIFY_RESOURCE_TIMESHEET_DTLS"), strTemp.ToString) 'SnehalV- Added strTemp to plot TimesheetFor Combo
            CommonFunctions.General.WriteHTML("<BR>")
            DrawGridOfEmployeeProfile()
            DrawTimesheetGrid()

            CommonFunctions.General.WriteHTML("</DIV>")
            DrawMenu()
            'If m_blnSentMailForRemarks = True Then
            'Response.Redirect("../../Source/General/CommonList.aspx?FromWhere=SM&MasterTagID=2054&SendMailForRearks=1&VerifiedBy=" + CType(Session("intUserID"), String) + "&ResourceID=" & CType(m_strEmployeeID, String) + "&SortField=" + CType(strSortByField, String) + "&SortOrder=" + CType(strAscOrDesc, String))
            'End If


            '##### Writing Back_OnClick() Function
            'CommonFunctions.General.WriteHTML("function Back_OnClick()" + vbCrLf)
            'CommonFunctions.General.WriteHTML("{" + vbCrLf)
            'CommonFunctions.General.WriteHTML("window.location.href = '../../Source/General/CommonList.aspx?FromWhere=SM&MasterTagID=50054';" + vbCrLf)
            'CommonFunctions.General.WriteHTML("}" + vbCrLf)
            ''##### End 
        End If
    End Sub

    Public Sub CheckRoleAccess()
        Dim drAccess As IDataReader
        'Check if Project is Selected
        If Not CType(Session("intProjectID"), String) = "" Then
            strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " + CType(m_intTagID, String) + "," + CType(Session("intPostID"), String) + "," + CType(Session("intUserID"), String) + ",'" + CType(Session("LoginType"), String) + "'," + CType(Session("intProjectID"), String)
        Else
            strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " + CType(m_intTagID, String) + "," + CType(Session("intPostID"), String) + "," + CType(Session("intUserID"), String) + ",'" + CType(Session("LoginType"), String) + "'"
        End If

        '##### Get the Default Approver
        drAccess = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If drAccess.Read Then
            m_intAccessAdd = CType(CommonFunctions.Data.CheckIsDBNull(drAccess("A"), "0"), Integer)
        End If
        CommonFunctions.Data.DisposeDataReader(drAccess)
        '##### End 
    End Sub
#End Region

#Region "Handling Modes And Actions"
    Public Sub HandleModesAndActions()
        Dim intVerifiedBy As Integer
        Dim dtVerificationDate As String
        Dim blnVerifiedAll As Boolean
        Dim blnRemarks As Boolean
        Dim intCtr As Integer
        Dim intRowCount As Integer
        ' RajkumarM on 6th Oct 2008
        Dim intChkCount As Integer
        ' RajkumarM on 6th Oct 2008
        Dim strRemarks As String
        Dim intVerified As Integer
        Dim drVerify As IDataReader
        Dim strVerifiedActivities As String
        Dim arrVerifiedActivities As String()
        Dim arrVerifiedActivitiesLength As Integer
        Dim drResourceTimesheetstatus As IDataReader
        'Variables for sending E-mail
        Dim drEmailMessage As IDataReader
        Dim blnSendEmail As Boolean
        Dim blnShowPopup As Boolean
        Dim strOnloadClientScript As String
        Dim strFromEmailID As String
        Dim strToEmailID As String
        Dim strCCEmailID As String
        Dim strSubject As String
        Dim strMessage As String
        Dim drUnVerify As IDataReader
        Dim strRemarksIDs As String

        m_strPrevTimesheetID = "0"

        'Added By VarunA on 3-Dec-2007 DSS RequestID-10747
        'Purpose : If TimesheeID is more than 8000 characters
        Dim strTSIDS As String = HttpContext.Current.Session("TSIDs").ToString
        Dim strArray(2) As String
        Dim maxStringLength As Integer = 6000
        Dim i As Integer = 0
        Dim strTargetString As String = strTSIDS
        Dim strIndex As Integer = 0
        Dim strToken As String
        If strTSIDS.Length / maxStringLength < 3 Then
            For i = 0 To 2
                If (strTargetString.Length <= maxStringLength) Then
                    strArray(i) = strTargetString
                    Exit For
                End If
                strToken = strTargetString.Substring(strIndex, maxStringLength)
                strToken = strToken.Substring(0, strToken.LastIndexOf(",") + 1)
                strArray(i) = strToken
                strTargetString = strTargetString.Substring(strToken.Length)
            Next
        Else
            Response.Write("<script>alert('Error....\n Action is abnormally terminated.'); </script>")
        End If
        'End By VarunA on 3-Dec-2007

        strVerifiedActivities = Request.Form("chkVerify")
        If strVerifiedActivities <> "" Then
            arrVerifiedActivities = Split(strVerifiedActivities, ",")
        End If

        If Not IsNothing(arrVerifiedActivities) Then
            arrVerifiedActivitiesLength = arrVerifiedActivities.Length
        Else
            arrVerifiedActivitiesLength = 0
        End If

        intRowCount = CType(Request.Form("RowCount"), Integer)
        'Added by RajkumarM on 6-Oct-2008
        'Purpose:-For Line manager functionality.
        intChkCount = CType(Request.QueryString("Chkcount"), Integer) 'CType(Request.Form("RowCount"), Integer)
        'End of addition by TrupitK

        Select Case UCase(strMode)
            Case "VERIFY"
                '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                '' m_strToken = Request.QueryString("PKToken") & ""
                If (CommonFunctions.Security.Token.ValidateToken(CType(m_strTimesheetID, String) + CType(CType(m_strEmployeeID, String), String) + CType(s_ParentTagID, String) + CType(m_TagVerifyTimesheetList, String), m_strToken_ApproveReject) = True) Then
                    '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197 

                    intVerifiedBy = CType(Session("intUserID"), Integer)
                    dtVerificationDate = CType(Now(), String)
                    'date verification details of all Daily activity entries for the Resource timesheet. 
                    blnVerifiedAll = True
                    blnRemarks = False

                    For intCtr = 1 To intRowCount
                        intEntryID = CType(Request.Form("txtEntryID" + CType(intCtr, String)), Integer)
                        strRemarks = Trim(Request.Form("txtRemarks" + CType(intEntryID, String)))

                        intVerified = 0

                        strQuery = "Exec usp_Upd_PM_ResourceTimesheetVerification " + CType(intEntryID, String) + "," + CType(intVerified, String)
                        strQuery = strQuery + "," + CType(intVerifiedBy, String) + ",'" + CType(dtVerificationDate, String) + "','" + Trim(Replace(strRemarks, "'", "''")) + "'"

                        drVerify = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                        CommonFunctions.Data.DisposeDataReader(drVerify)

                        If strRemarks <> "" Then
                            blnRemarks = True
                        End If
                    Next

                    'Update Verified Activities
                    If arrVerifiedActivitiesLength > 0 Then
                        For intCtr = 1 To arrVerifiedActivities.Length
                            intEntryID = CType(arrVerifiedActivities(intCtr - 1), Integer)
                            intVerified = 1
                            strRemarks = ""
                            '--- Execute sp to update verification details to Daily Activity Table
                            strQuery = "Exec usp_Upd_PM_ResourceTimesheetVerification " + CType(intEntryID, String) + "," + CType(intVerified, String)
                            strQuery = strQuery + "," + CType(intVerifiedBy, String) + ",'" + CType(dtVerificationDate, String) + "','" + Trim(Replace(strRemarks, "'", "''")) + "'"

                            drVerify = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                            CommonFunctions.Data.DisposeDataReader(drVerify)
                        Next
                    End If

                    'Check if all activities are verified
                    'Modified by RajkumarM on 06-Oct-08
                    'If arrVerifiedActivitiesLength <> intRowCount Then
                    If arrVerifiedActivitiesLength <> intChkCount Then
                        'End of modification by TrupitK

                        'If all activities are not selected then
                        'Update verification status for logged in approver in tbl_PM_ResourceTimesheetStatus
                        ' for selected timesheet to 'G' - indicating that timesheet is Generated but not completed verified 
                        blnVerifiedAll = False
                        If arrVerifiedActivitiesLength > 0 Then
                            'If all activities are not verified then the status of the resource timsheet will be updated to J
                            strQuery = " Exec usp_Upd_tbl_PM_ResourceTimesheetStatus " + CType(m_strTimesheetID, String) + "," + CType(intVerifiedBy, String) + "," + "R"
                            drVerify = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                            CommonFunctions.Data.DisposeDataReader(drVerify)
                        End If
                    Else
                        blnVerifiedAll = True
                        blnRemarks = False
                    End If

                    '#########
                    'Retrieve the details of the message to be sent to the Resource.
                    'If all "verified" check boxes are True, update Resource Timesheet Table to 
                    'set timesheet status as verified and Send Mail to Resource
                    If blnVerifiedAll = True Then
                        'Update tbl_PM_ProjectTasks Actual Percent Complete Column
                        '##### Commented By AmitD on 27 Oct 2004 - For Making Resource Timesheet
                        ' from the task completion flow

                        'For intCtr = 1 To arrVerifiedActivities.Length
                        '    intEntryID = CType(arrVerifiedActivities(intCtr - 1), Integer)
                        '    intVerified = 1
                        '    strRemarks = ""
                        '    '--- Execute sp to update verification details to Daily Activity Table
                        '    strQuery = "Exec usp_Upd_Tbl_PM_ProjectTasks_VerifiedActivities " + CType(intEntryID, String)
                        '    drVerify = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                        '    CommonFunctions.Data.DisposeDataReader(drVerify)
                        'Next
                        '##### End Comment
                        'Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
                        strSQLQuery = "Exec usp_Upd_tbl_PM_ResourceTimesheetStatus " + m_strTimesheetID + "," + CType(intVerifiedBy, String) + "," + "V"
                        drVerify = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                        CommonFunctions.Data.DisposeDataReader(drVerify)
                        '-- Check if all tasks for Resource TimeSheet are verified 
                        '-- if Yes then change the status to 'verified' 
                        strSQLQuery = "Exec usp_Sel_ResourceTimesheet_GetVerifiedTasksStatus " + CType(m_strTimesheetID, String)
                        drVerify = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

                        If drVerify.Read = False Then
                            strQuery = "Exec usp_Upd_ResouceTimesheetStatus " + CType(m_strTimesheetID, String) + ",'V'"
                            drResourceTimesheetstatus = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                            CommonFunctions.Data.DisposeDataReader(drResourceTimesheetstatus)
                        End If
                        CommonFunctions.Data.DisposeDataReader(drVerify)

                        If blnRemarks = False Then
                            m_strTimesheetStatus = "V"
                        Else
                            m_strTimesheetStatus = "J"
                        End If


                        strSQLQuery = "usp_Sel_tbl_PM_EmailMessages 435"
                        drEmailMessage = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

                        If drEmailMessage.Read Then
                            blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                            blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                        End If
                        CommonFunctions.Data.DisposeDataReader(drEmailMessage)

                        ' Check if the mail has to be sent.
                        If blnSendEmail = True Then
                            ' Check if a popup message has to be shown.
                            If blnShowPopup = True Then
                                CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                                'CommonFunctions.General.WriteHTML("window.open('../../Source/General/SendEmail.aspx?MessageID=435&VerifiedBy=" + CType(intVerifiedBy, String) + "&ResourceID=" + CType(m_strEmployeeID, String) + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left='" + "(window.screen.width - 600) / 2" + "',top='" + "(window.screen.height - 500) / 2" + "',width=600,height=500')" + vbCrLf)
                                'Modify by HarshK on 11/08/2005 - IssueID - 86 - SP4
                                'CommonFunctions.General.WriteHTML("window.location.href = '../../Source/General/CommonList.aspx?FromWhere=SM&MasterTagID=" + CType(m_TagVerifyTimesheetList, String) + "';")
                                'AUJ'Commented the following line. Do not redirect to RT_TimesheetApproval.aspx
                                'CommonFunctions.General.WriteHTML("window.location.href = '../../Source/RT/RT_TimesheetApproval.aspx?MasterTagID=" + CType(m_TagVerifyTimesheetList, String) + "';")
                                'end HarshK on 11/08/2005
                                'CommonFunctions.General.WriteHTML("window.location.href = '../../Source/General/CommonList.aspx?FromWhere=SM&MasterTagID=" + CType(m_TagVerifyTimesheetList, String) + "';")
                                'AUJ'CommonFunctions.General.WriteHTML("window.open('../../Source/General/SendEmail.aspx?MessageID=435&VerifiedBy=" + CType(intVerifiedBy, String) + "&ResourceID=" + CType(Request.QueryString("EmployeeID"), String) + "&FromDate=" + strFromDate + "&ToDate=" + strToDate + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                                CommonFunctions.General.WriteHTML("window.open('../../Source/General/SendEmail.aspx?MessageID=435&VerifiedBy=" + CType(intVerifiedBy, String) + "&ResourceID=" + strResourceID + "&FromDate=" + strFromDate + "&ToDate=" + strToDate + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                                CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                                ' Else, if the mail has to be sent silently, then...
                            Else
                                'TO DO: SEND EMAIL MESSAGE WITH CC
                                'CommonFunction.EmailMessages.PMMessages. CRMMessages.GetEmailMessage_45(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intVerifiedBy, m_strEmployeeID)
                                'AUJ'CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_435(strFromEmailID, strToEmailID, strCCEmailID, strSubject, strMessage, intVerifiedBy, CType(Request.QueryString("EmployeeID"), Integer), CType(strFromDate, Date), CType(strToDate, Date))
                                CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_435(strFromEmailID, strToEmailID, strCCEmailID, strSubject, strMessage, intVerifiedBy, CType(strResourceID, Integer), CType(strFromDate, Date), CType(strToDate, Date))
                                Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCEmailID, strFromEmailID, strSubject, strMessage)
                            End If
                        End If
                    End If

                    If blnRemarks = True Then

                        'Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
                        strSQLQuery = "Exec usp_Upd_tbl_PM_ResourceTimesheetStatus " + CType(m_strTimesheetID, String) + "," + CType(intVerifiedBy, String) + "," + "'J'"
                        drResourceTimesheetstatus = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                        CommonFunctions.Data.DisposeDataReader(drResourceTimesheetstatus)


                        strQuery = "Exec usp_Upd_ResouceTimesheetStatus " + CType(m_strTimesheetID, String) + ",'J'"
                        drResourceTimesheetstatus = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                        CommonFunctions.Data.DisposeDataReader(drResourceTimesheetstatus)

                        m_strTimesheetStatus = "J"
                        m_strPrevTimesheetID = m_strTimesheetID
                        'AUJ, get the next TimesheetID after current one is processed(i.e. Rejected)
                        'm_strTimesheetID = CType(CommonFunction.Data.GetDataScalar("usp_sel_WSEM_TSIDS '" & HttpContext.Current.Session("TSIDs").ToString & "', " + HttpContext.Current.Session("intUserID").ToString + ", 2", True), String)
                        'Modified By VarunA on 3-Dec-2007 DSS RequestID-10747
                        'Purpose : If TimesheeID is more than 8000 characters
                        'm_strTimesheetID = CType(CommonFunction.Data.GetDataScalar("usp_sel_WSEM_TSIDS '" & HttpContext.Current.Session("TSIDs").ToString & "', " + HttpContext.Current.Session("intUserID").ToString + ", 2, " + m_strTimesheetID.ToString, True), String)
                        m_strTimesheetID = CType(CommonFunction.Data.GetDataScalar("usp_sel_WSEM_TSIDS '" & strArray(0) & "','" & strArray(1) & "','" & strArray(2) & "', " + HttpContext.Current.Session("intUserID").ToString + ", 2, " + m_strTimesheetID.ToString, True), String)
                        'End By VarunA on 3-Dec-2007
                        'AUJ
                        strSQLQuery = "usp_Sel_tbl_PM_EmailMessages 436"
                        drEmailMessage = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

                        If drEmailMessage.Read Then
                            blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                            blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                        End If
                        CommonFunctions.Data.DisposeDataReader(drEmailMessage)

                        ' Check if the mail has to be sent.
                        If blnSendEmail = True Then
                            ' Check if a popup message has to be shown.
                            If blnShowPopup = True Then
                                CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                                'CommonFunctions.General.WriteHTML("window.open('../../Source/General/SendEmail.aspx?MessageID=435&VerifiedBy=" + CType(intVerifiedBy, String) + "&ResourceID=" + CType(m_strEmployeeID, String) + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left='" + "(window.screen.width - 600) / 2" + "',top='" + "(window.screen.height - 500) / 2" + "',width=600,height=500')" + vbCrLf)
                                ' CommonFunctions.General.WriteHTML("window.location.href = '../General/CommonList.aspx?FromWhere=SM&MasterTagID=" + CType(m_TagVerifyTimesheetList, String) + "';")
                                'modified by HarshK on 11/08/05 - IssueID - 86 - SP4
                                'CommonFunctions.General.WriteHTML("window.location.href = '../General/CommonList.aspx?FromWhere=SM&MasterTagID=" + CType(m_TagVerifyTimesheetList, String) + "';")
                                'AUJ,Following line Commented. Do not redirect to list page.(i.e. RT_TimesheetApproval.aspx)
                                'CommonFunctions.General.WriteHTML("window.location.href = '../RT/RT_TimesheetApproval.aspx?MasterTagID=" + CType(m_TagVerifyTimesheetList, String) + "';")
                                'End HarshK on 11/08/05

                                'AUJ'CommonFunctions.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=436&VerifiedBy=" + CType(intVerifiedBy, String) + "&ResourceID=" + CType(Request.QueryString("EmployeeID"), String) + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500');" + vbCrLf)
                                CommonFunctions.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=436&VerifiedBy=" + CType(intVerifiedBy, String) + "&ResourceID=" + strResourceID + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500');" + vbCrLf)
                                'CommonFunctions.General.WriteHTML("window.location.herf = '../../Source/General/CommonList.aspx?FromWhere=SM&MasterTagID=50054&SendMailForRearks=1&VerifiedBy=" + CType(Session("intUserID"), String) + "&ResourceID=" & CType(m_strEmployeeID, String) + "&SortField=" + CType(strSortByField, String) + "&SortOrder=" + CType(strAscOrDesc, String) + "';")
                                CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                                ' Else, if the mail has to be sent silently, then...
                            Else
                                'TO DO: SEND EMAIL MESSAGE WITH CC
                                'CommonFunction.EmailMessages.PMMessages. CRMMessages.GetEmailMessage_45(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intVerifiedBy, m_strEmployeeID)
                                'CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_45(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                                'AUJ,Commented and added below, instead of taking EmployeeID from Querystring take it from variable.
                                'CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_436(strFromEmailID, strToEmailID, strCCEmailID, strSubject, strMessage, intVerifiedBy, CType(Request.QueryString("EmployeeID"), Integer))
                                CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_436(strFromEmailID, strToEmailID, strCCEmailID, strSubject, strMessage, intVerifiedBy, CType(strResourceID, Integer))
                                Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCEmailID, strFromEmailID, strSubject, strMessage)
                            End If
                        End If

                        'm_blnSentMailForRemarks = True
                    Else
                        'Commented By JyotiG
                        'Start_JG_8809_20-Dec-2006
                        ''AUJ, get the next TimesheetID after current one is processed(i.e. Rejected)
                        ''m_strTimesheetID = CType(CommonFunction.Data.GetDataScalar("usp_sel_WSEM_TSIDS '" & HttpContext.Current.Session("TSIDs").ToString & "', " + HttpContext.Current.Session("intUserID").ToString + ", 2", True), String)
                        'm_strTimesheetID = CType(CommonFunction.Data.GetDataScalar("usp_sel_WSEM_TSIDS '" & HttpContext.Current.Session("TSIDs").ToString & "', " + HttpContext.Current.Session("intUserID").ToString + ", 2, " + m_strTimesheetID.ToString, True), String)
                        ''AUJ
                        'End_JG_8809_20-Dec-2006
                        CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                        'modofied by HarshK on 11/08/05 - IssueID - 86 - SP4
                        'CommonFunctions.General.WriteHTML("window.location.href = '../General/CommonList.aspx?FromWhere=SM&MasterTagID=" + CType(m_TagVerifyTimesheetList, String) + "';")
                        'AUJ, Commented the following line. Do not redirect it to List page 
                        'CommonFunctions.General.WriteHTML("window.location.href = '../RT/RT_TimesheetApproval.aspx?MasterTagID=" + CType(m_TagVerifyTimesheetList, String) + "';")
                        'End HarshK on 11/08/05
                        CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                    End If

                    If blnVerifiedAll = False And blnRemarks = False Then
                        strSQLQuery = "Exec usp_Upd_tbl_PM_ResourceTimesheetStatus " + CType(m_strTimesheetID, String) + "," + CType(intVerifiedBy, String) + "," + "'R'"
                        drResourceTimesheetstatus = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                        CommonFunctions.Data.DisposeDataReader(drResourceTimesheetstatus)
                    End If
                    'Added By JyotiG
                    'Start_JG_8809_20-Dec-2006
                    m_strPrevTimesheetID = m_strTimesheetID
                    If CommonFunction.General.CheckIsNothing(m_strTimesheetID, "") <> "" Then
                        'Modified By VarunA on 3-Dec-2007 DSS RequestID-10747
                        'Purpose : If TimesheeID is more than 8000 characters
                        'm_strTimesheetID = CType(CommonFunction.Data.GetDataScalar("usp_sel_WSEM_TSIDS '" & HttpContext.Current.Session("TSIDs").ToString & "', " + HttpContext.Current.Session("intUserID").ToString + ", 2, " + m_strTimesheetID.ToString, True), String)
                        m_strTimesheetID = CType(CommonFunction.Data.GetDataScalar("usp_sel_WSEM_TSIDS '" & strArray(0) & "','" & strArray(1) & "','" & strArray(2) & "', " + HttpContext.Current.Session("intUserID").ToString + ", 2, " + m_strTimesheetID.ToString, True), String)
                        'End By VarunA on 3-Dec-2007
                    End If
                    'End_JG_8809_20-Dec-2006
                    '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                Else
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Timesheet Approval : Verification", m_intTagID, 0, "Timesheet ID", CType(m_strTimesheetID, String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
                '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197

            Case "UNVERIFY"

                '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                If (CType(m_strTimesheetID, String) <> "0") And (CommonFunctions.Security.Token.ValidateToken(CType(m_strTimesheetID, String) + CType(m_strEmployeeID, String) + CType(s_ParentTagID, String) + CType(m_TagVerifyTimesheetList, String), m_strToken_ApproveReject) = True) Then
                    '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197

                    'Get list of all verified activities		
                    strDailyActivityIDS = ""
                    If arrVerifiedActivitiesLength <> 0 Then
                        For intCtr = 1 To arrVerifiedActivitiesLength
                            intEntryID = CType(arrVerifiedActivities(intCtr - 1), Integer)

                            strDailyActivityIDS = strDailyActivityIDS + CType(intEntryID, String) + ","

                            'CommonFunctions.General.WriteHTML(strDailyActivityIDS)
                        Next
                    End If

                    If strDailyActivityIDS = "" Then
                        strDailyActivityIDS = "0"
                    End If

                    'Update Remarks
                    dtVerificationDate = CType(Now(), String)

                    For intCtr = 1 To intRowCount
                        intEntryID = CType(Request.Form("txtEntryID" + CType(intCtr, String)), Integer)
                        strRemarks = CType(Server.HtmlEncode(Request.Form("txtRemarks" + CType(intEntryID, String))), String)
                        'Modified Code By VidyaJ - IssueID - 86 - SP4
                        'Commented OR Condition
                        If strRemarks <> "" Then  'Or InStr(intEntryID & ",", strDailyActivityIDS) <= 0 Then
                            intVerified = 0
                            strQuery = "Exec usp_Upd_PM_ResourceTimesheetVerification " + CType(intEntryID, String) + "," + CType(intVerified, String)
                            strQuery = strQuery + "," + CType(Session("intUserID"), String) + ",'" + CType(dtVerificationDate, String) + "','" + Trim(Replace(strRemarks, "'", "''")) & "'"
                            drUnVerify = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                            CommonFunctions.Data.DisposeDataReader(drUnVerify)
                            strRemarksIDs = strRemarksIDs + CType(intEntryID, String) + ","
                        End If
                    Next

                    If strDailyActivityIDS = "0" Then
                        If IsNothing(strRemarksIDs) Then
                            strRemarksIDs = "0"
                        End If
                        strDailyActivityIDS = CType(strRemarksIDs, String)

                    End If

                    'Unverify all Unchecked Activities
                    'Added UserID to SP Paramtere
                    'Modified Code By VidyaJ - IssueID - 20550
                    'Change status of only for actvities which are rejected and not all activities
                    'Changed ID list From strDailyActivityIDS to strRemarksIDs
                    strQuery = "usp_Upd_UnverifyResouceTimesheetStatus " + m_strTimesheetID + "," + CType(Session("intUserID"), String) + ",'" + CType(strRemarksIDs, String) + "'"
                    drUnVerify = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                    CommonFunctions.Data.DisposeDataReader(drUnVerify)

                    'Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
                    strSQLQuery = "Exec usp_Upd_tbl_PM_ResourceTimesheetStatus " + CType(m_strTimesheetID, String) + "," + CType(Session("intUserID"), String) + "," + "'J'"
                    drUnVerify = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                    CommonFunctions.Data.DisposeDataReader(drUnVerify)


                    '##### Send Mail For Rejection
                    strSQLQuery = "usp_Sel_tbl_PM_EmailMessages 437"
                    drEmailMessage = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

                    If drEmailMessage.Read Then
                        blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                        blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                    End If
                    CommonFunctions.Data.DisposeDataReader(drEmailMessage)
                    'AUJ, get the next TimesheetID after current one is processed(i.e. Rejected)
                    m_strPrevTimesheetID = m_strTimesheetID
                    'Modified By VarunA on 3-Dec-2007 DSS RequestID-10747
                    'Purpose : If TimesheeID is more than 8000 characters
                    'm_strTimesheetID = CType(CommonFunction.Data.GetDataScalar("usp_sel_WSEM_TSIDS '" & HttpContext.Current.Session("TSIDs").ToString & "', " + HttpContext.Current.Session("intUserID").ToString + ", 2, " + m_strTimesheetID.ToString, True), String)
                    m_strTimesheetID = CType(CommonFunction.Data.GetDataScalar("usp_sel_WSEM_TSIDS '" & strArray(0) & "','" & strArray(1) & "','" & strArray(2) & "', " + HttpContext.Current.Session("intUserID").ToString + ", 2, " + m_strTimesheetID.ToString, True), String)
                    'End By VarunA on 3-Dec-2007
                    'AUJ
                    ' Check if the mail has to be sent.
                    If blnSendEmail = True Then
                        ' Check if a popup message has to be shown.
                        If blnShowPopup = True Then
                            CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("window.open('../../Source/General/SendEmail.aspx?MessageID=435&VerifiedBy=" + CType(intVerifiedBy, String) + "&ResourceID=" + CType(m_strEmployeeID, String) + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left='" + "(window.screen.width - 600) / 2" + "',top='" + "(window.screen.height - 500) / 2" + "',width=600,height=500')" + vbCrLf)
                            'Modofied By HarshK on 11/08/05 - IssueID - 86 - SP4
                            'CommonFunctions.General.WriteHTML("window.location.href = '../General/CommonList.aspx?FromWhere=SM&MasterTagID=" + CType(m_TagVerifyTimesheetList, String) + "';")
                            'AUJ,Following line Commented. Do not redirect to list page.(i.e. RT_TimesheetApproval.aspx)
                            'CommonFunctions.General.WriteHTML("window.location.href = '../RT/RT_TimesheetApproval.aspx?MasterTagID=" + CType(m_TagVerifyTimesheetList, String) + "';")
                            'end HarshK on 11/08/05
                            'AUJ,Commented and added below, instead of taking EmployeeID from Querystring take it from variable.
                            'CommonFunctions.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=437&VerifiedBy=" + CType(Session("intUserID"), String) + "&ResourceID=" + CType(Request.QueryString("EmployeeID"), String) + "&FromDate=" + strFromDate + "&ToDate=" + strToDate + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                            CommonFunctions.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=437&VerifiedBy=" + CType(Session("intUserID"), String) + "&ResourceID=" + strResourceID + "&FromDate=" + strFromDate + "&ToDate=" + strToDate + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                            CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                            ' Else, if the mail has to be sent silently, then...
                        Else
                           
                            'Commented & Modified By amitJ On 23-June-2010 for WhizibleSEM9 SP1 For HotFix 9.0.053 
                            'Page Crash while rejecting approved timesheet. (Set mail id 437 sendmail = true,showpopup =false and 435 send mail=false,showpopup =false)
                            'Wrong Email function was called also timesheet approverid was not passed to the funciton.
                            'CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_435(strFromEmailID, strToEmailID, strCCEmailID, strSubject, strMessage, intVerifiedBy, CType(strResourceID, Integer), CType(strFromDate, Date), CType(strToDate, Date))
                            CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_437(strFromEmailID, strToEmailID, strCCEmailID, strSubject, strMessage, CType(Session("intUserID"), Integer), CType(strResourceID, Integer), CType(strFromDate, Date), CType(strToDate, Date))
                            'End Of Modificaiton By Amit J
                            Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCEmailID, strFromEmailID, strSubject, strMessage)
                        End If
                    End If
                    '##### End

                    '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                Else
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Timesheet Approval : Rejection", m_TagVerifyTimesheetList, 0, "Timesheet ID", CType(m_strTimesheetID, String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
                '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                'Response.Redirect("../../Source/General/CommonList.aspx?FromWhere=SM&MasterTagID=50054&SortField=")
        End Select
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
        ' Author                : AmitD
        ' Created               : Jul 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
#End Region

#Region " Plots the Menu and legend"
    Private Sub DrawMenu()
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 09, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML
        Dim strPageAlphabets As String

        m_objMenu = New WebPages.Template.StaticMenu

        'Use Resources Solution
        If m_strTimesheetStatus <> "V" Then
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_VERIFY"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_VERIFY_TOOLTIP"))
            'arrMenuCaptionsList.Add("Approve and Review Next")
            'arrMenuToolTipsList.Add("Approve and Review Next")
            arrClientSideFunctionList.Add("Save_OnClick('1')")

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE_REMARKS"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_REMARKS_TOOLTIP"))
            arrClientSideFunctionList.Add("Save_OnClick('0')")
        Else
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_UNVERIFY"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_UNVERIFY_TOOLTIP"))
            arrClientSideFunctionList.Add("UnverifyTimesheet()")
        End If

        arrMenuCaptionsList.Add("Show History")
        arrMenuToolTipsList.Add("Show History")
        arrClientSideFunctionList.Add("ShowHistory_OnClick(" + CType(m_strTimesheetID, String) + ")")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SELECT_ALL"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SELECT_ALL_TOOLTIP"))
        arrClientSideFunctionList.Add("VerifyAll()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLEAR_ALL"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLEAR_ALL_TOOLTIP"))
        arrClientSideFunctionList.Add("ClearAll()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_BACK"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP"))
        arrClientSideFunctionList.Add("Back_OnClick()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("ShowHelp()")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)

        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)
        'strPageAlphabets = ""
    End Sub

    Private Sub DrawPageLegend()
        Dim arrLegend() As String = {MyBase.GetResourceString("MANDATORY")}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        'Write page legend
        Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend) + vbCrLf)
    End Sub
#End Region

#Region "Plottting Of Grids"
    Public Sub DrawGridOfEmployeeProfile()
        '=====================================================================
        ' Procedure Name        : DrawGridOfEmployeeProfile()	
        ' Purpose               : Plots the grid displaying information of employee
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 20,20004
        ' Revisions             :
        '=====================================================================

        '--- Variables related to Employee Details
        Dim drEmployee As IDataReader
        Dim strEmployeeCode As String
        Dim strEmployeeName As String
        Dim strRole As String
        Dim strDepartment As String
        Dim strWorkingOffice As String
        '---Variables to store Timesheet Details
        Dim strDAEntryID As String

        'Grid For Employee Details
        strSQLQuery = "usp_sel_tbl_PM_RowWiseApprovers " + CType(m_intProjectID, String)

        '##### Get Employee Details of the current user
        'Start_AUJ
        If strResourceID = "" Then
            'End_AUJ
            strQuery = "Exec usp_Sel_tbl_PM_EmployeeProfile " + CType(Request.QueryString("EmployeeID"), String)
            'Start_AUJ
        Else
            strQuery = "Exec usp_Sel_tbl_PM_EmployeeProfile " + strResourceID
        End If
        'End_AUJ
        drEmployee = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If drEmployee.Read Then
            strEmployeeCode = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("EmployeeCode"), ""), String)
            strEmployeeName = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("EmployeeName"), ""), String)
            strRole = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("RoleDescription"), ""), String)
            strDepartment = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("Department"), ""), String)
            strWorkingOffice = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("Location"), ""), String)
        End If
        CommonFunctions.Data.DisposeDataReader(drEmployee)
        '##### End    

        '##### Plotting The Table For Header Of Timesheet Period
        CommonFunctions.General.WriteHTML("<DIV id='DivTimesheetInfo' style='Overflow:auto;width=100%;'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<table cellSpacing='0' cellPadding='0' width='99.9%' border='0' id='TABLE1'>" + vbCrLf)
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<tbody>" + vbCrLf)
        CommonFunctions.General.WriteHTML("<tr class='clsTRPageHeader'>" + vbCrLf)
        'Use Resources Solution
        CommonFunctions.General.WriteHTML("<td height='22' align='left'><B>" + MyBase.GetResourceString("VERIFY_RESOURCE_TIMESHEET_PERIOD") + " " + strEmployeeName + " &nbsp;&nbsp;" + "</B></td>" + vbCrLf)
        CommonFunctions.General.WriteHTML("<td height='22' align='right'><B>" + MyBase.GetResourceString("PERIOD") + CommonFunctions.Dates.CGetDate(CType(strFromDate, Date)) + "&nbsp;" + MyBase.GetResourceString("TO") + "&nbsp;" + CommonFunctions.Dates.CGetDate(CType(strToDate, Date)) + "</B></td>")
        CommonFunctions.General.WriteHTML("</tr>" + vbCrLf)
        CommonFunctions.General.WriteHTML("</tbody>" + vbCrLf)
        CommonFunctions.General.WriteHTML("</table>" + vbCrLf)
        CommonFunction.General.WriteHTML("</div>" + vbCrLf)
        '##### End Employee Grid Plotting
        '--- Added By Purvaj on 1 Oct 2008 for Whiziblesem 8.0
        '--- To display holidays and leave in the generated timesheet period
        Dim drHoliday As IDataReader
        Dim OldType As String = ""
        Dim NewType As String = ""
        Dim strHTML As String = ""
        Dim intFlag As Integer = 0
        drHoliday = CommonFunction.Data.GetDataReader("usp_sel_TimesheetApproval_HolidayORLeaveStatus " + m_strTimesheetID.ToString, True)
        strHTML = strHTML + "<TABLE class='clsTable' border=0 width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTREven'><TD align=left  style='color:red'>"
        While drHoliday.Read()
            intFlag = 1
            NewType = CommonFunction.Data.CheckIsDBNull(drHoliday("Type"), "")
            If NewType <> OldType And OldType <> "" Then
                strHTML = strHTML + "</TD></TR><TR class='clsTREven'><TD align=left  style='color:red'>"
            End If
            If NewType <> OldType Then
                strHTML = strHTML + NewType + " on : "
            End If

            strHTML = strHTML + CommonFunction.Dates.CGetDate(CommonFunction.Data.CheckIsDBNull(drHoliday("dtDate"), "")) + "; "
            OldType = NewType
        End While
        strHTML = strHTML + "</TD></TR></TABLE>"
        If intFlag = 1 Then
            CommonFunction.General.WriteHTML(strHTML.ToString)
        End If
        CommonFunction.Data.DisposeDataReader(drHoliday)
        '--- End addition Purvaj

        '##### Plotting The grid For Employee Details
        '' CommonFunctions.General.WriteHTML("<BR><DIV id='DivEmployeeProfile' style='Overflow:auto;width=100%;'>" + vbCrLf)
        '' CommonFunctions.General.WriteHTML("<table cellSpacing='0' cellPadding='0' width='100%' border='0'>" + vbCrLf)
        ''CommonFunctions.General.WriteHTML("<tbody>" + vbCrLf)
        ''CommonFunctions.General.WriteHTML("<tr>" + vbCrLf)
        ''Use Resources Solution
        ''CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='15%'>" + MyBase.GetResourceString("RESOURCE_NAME") + "</td>" + vbCrLf)
        ''CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='25%'>" + strEmployeeName + "</td>" + vbCrLf)
        ''Use Resources Solution
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='15%'>" + MyBase.GetResourceString("ROLE") + "</td>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='25%'>" + strRole + "</td>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("</tr>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("<tr>" + vbCrLf)
        ''Use Resource Solution
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='15%'>" + MyBase.GetResourceString("EMPLOYEE_NO") + "</td>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='25%'>" + strEmployeeCode + "</td>" + vbCrLf)
        ''Use Resources Solution
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='15%'>" + MyBase.GetResourceString("WORKING_DEPT") + "</td>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='25%'>" + strDepartment + "</td>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("</tr>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("<tr>" + vbCrLf)
        ''Use Resources Solution
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='15%'>" + MyBase.GetResourceString("WORKING_OFFICE") + "</td>")
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='25%'>" + strWorkingOffice + "</td>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='15%'></td>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("<td class='clsTDEven' width='25%'></td>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("</tr>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("</tbody>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("</table>" + vbCrLf)
        'CommonFunction.General.WriteHTML("</div>")

        ' Modified By nitinVS on 20 Sep 2006 for WhizibleSEM SP 7 Resource Timesheet Performance.IssueID 6341 
        ' Moved the dispose datareader to the page init as it is not used here 
        '   CommonFunctions.Data.DisposeDataReader(m_drTimesheet)
        ' End Modification By nitinVS on 20 Sep 2006 for WhizibleSEM SP 7 Resource Timesheet Performance.IssueID 6341 
        '##### End 
    End Sub

    Public Sub DrawTimesheetGrid()
        '=====================================================================
        ' Procedure Name        : DrawTimesheetGrid()	
        ' Purpose               : Plots the grid displaying timesheets of employee
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 20,20004
        ' Revisions             :
        '=====================================================================
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim arrGroupColumnNames As New ArrayList        'To store grouping column names

        'To store the link details while clicking on Links in grid
        'Start-AUJ-22Jan2007, commented and added below.
        ''Dim arrWidthArray() As String = {"", "style='width:13%' align='left'", "style='width:21%' align='left'", "style='width:22%' align='left'", "style='width:8%' align='right'", "style='width:8%' align='right'", "style='width:8%' align='center'", "style='width:20%' align='center'"}
        'Dim arrWidthArray() As String = {"", "style='width:13%' align='left'", "style='width:21%' align='left'", "style='width:25%' align='left'", "style='width:13%' align='right'", "style='width:8%' align='center'", "style='width:20%' align='center'"}
        ''Dim arrWidthArray() As String = {"style='width:40%'", "align=center", "align=center"}
        'Dim arrColRowLinks() As String = {"", "", "", "", "", ""}
        'Dim arrAlignment() As String = {"left", "left", "left", "right", "center", "center"}
        'Dim sbFooterHTML As New System.Text.StringBuilder("")
        'Dim arrGroupSummaryFunc() As String = {"Sum"}

        Dim arrWidthArray() As String = {"style='width:1%'", "style='width:13%' align='left'", "style='width:19%' align='left'", "style='width:20%' align='left'", "style='width:10%' align='right'", "style='width:10%' align ='left'", "style='width:8%' align='center'", "style='width:20%' align='center'"}
        Dim arrColRowLinks() As String = {"", "", "", "", "", "", ""}
        Dim arrAlignment() As String = {"left", "left", "left", "right", "left", "center", "center"}
        Dim sbFooterHTML As New System.Text.StringBuilder("")
        Dim arrGroupSummaryFunc() As String = {"Sum"}
        'End-AUJ-22Jan2007
        strQuery = "usp_Sel_ResourceTimesheetDADetails " + CType(m_strTimesheetID, String) + "," + CType(Session("intUserID"), String)
        CommonFunctions.General.WriteHTML("<br><DIV id='DivList' style='Overflow:auto;width=100%;Height:400'>")

        ''Plots the Table for Rowwise Approvers
        ''-------------------------------------------------------------------
        'TO DO: 
        '##### Get Column Headings from Resources 
        arrColumnHeadingList.Add(MyBase.GetResourceString("PROJECT_NAME"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("DATE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("TASK_NAME"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("DESCRIPTION"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("ACTUAL_HOURS"))
        'Start-AUJ-22Jan2007
        arrColumnHeadingList.Add("DA Type")
        'End-AUJ-22Jan2007
        'arrColumnHeadingList.Add(MyBase.GetResourceString("EXTRA_AMH"))
        'If m_strTimesheetStatus <> "V" Then
        arrColumnHeadingList.Add(MyBase.GetResourceString("VERIFY"))
        'Else
        '   arrColumnHeadingList.Add(MyBase.GetResourceString("UNVERIFY"))
        'End If
        arrColumnHeadingList.Add(MyBase.GetResourceString("REMARKS"))
        '##### End 

        '##### Actual Column Names List
        arrActualColumnNames.Add("ProjectName")
        arrActualColumnNames.Add("EntryDate")
        arrActualColumnNames.Add("TaskName")
        arrActualColumnNames.Add("Description")
        arrActualColumnNames.Add("TotalDuration")
        'Start-AUJ-22Jan2007
        arrActualColumnNames.Add("DAType")
        'End-AUJ-22Jan2007
        'arrActualColumnNames.Add("TotalOvertimeDuration")
        arrActualColumnNames.Add("Verified")
        arrActualColumnNames.Add("Remarks")
        '##### End

        '##### Grouping column names list
        'arrGroupColumnNames.Add("Project Name")
        '##### End 
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .NoOfDataColumns = 7 'Start-AUJ-22Jan2007, Previous value = 6, changed to 7
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 0
            .SQL = strQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            '.GroupOnColumn = GetArray(arrGroupColumnNames)
            '.GroupSummaryFunc = arrGroupSummaryFunc
            '.ColumnHeaderAlignment = arrAlignment
            '.FooterHTML = sbFooterHTML.ToString
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        m_objGrid = Nothing
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("RowCount", "RowCount", , , , CType(m_intIndex - 1, String), , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.General.WriteHTML("</div>")
    End Sub

#End Region
    'Added by ShraddhaM on 2,Apr 2008 for Task popup
    Private Sub getToolTipInfo()

        Dim sbHtml As New System.Text.StringBuilder
        Dim strClass As String = "clsTROdd"
        Dim strSQL As String
        Dim dr As IDataReader
        Dim DivWidth As String
        Dim DivHt As String
        Dim TaskName As String
        Dim StartDate As String
        Dim EndDate As String
        Dim PlannedHrs As String
        Dim RemaningHrs As String
        Dim ActualTillTodayHrs As String

        DivWidth = "100px" '"690px"
        DivHt = "128px" '"154px"


        strSQL = "usp_sel_TaskDetails_ForToolTip " + strTaskID
        dr = CommonFunction.Data.GetDataReader(strSQL, True)
        ''Commented by nilesh G on 14/10/2015 for show window properly
        ''sbHtml.Append("<Div id='divTaskDetails' style=""width:500px;height:" + DivHt + ";overflow:auto;POSITION: relative;BORDER-COLOR:#35afe8;BORDER-STYLE:groove;"">")
        sbHtml.Append("<Div id='divTaskDetails' style=""width:510px;height:" + DivHt + ";overflow:auto;POSITION: relative;BORDER-COLOR:#35afe8;BORDER-STYLE:groove;"">")
        'sbHtml.Append("<div id=divFilter style='OVERFLOW:auto;DISPLAY:none;BORDER-COLOR:#35afe8;BORDER-STYLE:groove;WIDTH:80%;POSITION:absolute;Z-INDEX:19000'>")
        'Filter Table 
        '--- Commetned by purvaj on 30 Jun 2009  for 8.1 issue fixes
        ''sbHtml.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable >" + vbCrLf)
        ''sbHtml.Append("<TR class= clsTRColumnHeader >" + vbCrLf)
        ''sbHtml.Append("<TD  align='Left'><B>Task Details</B></TD>" + vbCrLf)
        ''sbHtml.Append("<td align=right><a href ='Javascript:CloseDiv()'><img border=0 src = '../../Images/RM/Close.png' > </a>" + vbCrLf)
        ''sbHtml.Append("</TR></TABLE>" + vbCrLf)
        ''sbHtml.Append("</BR>" + vbCrLf)
        '--- ENd comment purvaj

        sbHtml.Append("<table id='tbl_Div' width='99.9%' CellPadding=0 CellSpacing=0 class=clsTable border = 0 >" + vbCrLf)
        '--- Added by purvaj on 30 Jun 2009 for 8.1 issue fixes
        '---if the task name is long then white space gets displayed, as width of the two tables does not match.
        '--- so instead if two tables, header is also added in the same(tbl_Div) table.
        '--- above header table commented.
        sbHtml.Append("<TR class= clsTRColumnHeader>" + vbCrLf)
        sbHtml.Append("<TD  align='Left' colspan=3 ><B>Task Details</B></TD>" + vbCrLf)
        sbHtml.Append("<td align=right><a href ='Javascript:CloseDiv()'><img border=0 src = '../../Images/RM/Close.gif' > </a>" + vbCrLf)
        sbHtml.Append("</TD></TR><TR height='2px'><TD colspan=4></TD></TR>")
        '--- End addition purvaj
        If dr.Read() Then
            TaskName = CType(dr("TaskName"), String)
            If IsDBNull(dr("PlanStartDate")) Then
                StartDate = "-"
            Else
                StartDate = CommonFunction.Dates.CGetDate(CType(dr("PlanStartDate"), Date))
            End If

            If IsDBNull(dr("PlanEndDate")) Then
                EndDate = "-"
            Else
                EndDate = CommonFunction.Dates.CGetDate(CType(dr("PlanEndDate"), Date))
            End If
            PlannedHrs = CType(dr("Work"), String)
            RemaningHrs = CType(dr("RemainingHrs"), String)
            ActualTillTodayHrs = CType(dr("ActualsTillToday"), String)


            sbHtml.Append("<TR class='clsTRSectionHeader'>" + vbCrLf)
            sbHtml.Append("<TD  align='Right' ><B>Task Name&nbsp;</B></TD>" + vbCrLf)
            sbHtml.Append("<TD  align='Left' nowrap >" + TaskName + "</TD>" + vbCrLf)
            sbHtml.Append("<TD></TD><TD></TD>")
            sbHtml.Append("</TR>" + vbCrLf)

            sbHtml.Append("<TR class='clsTRSectionHeader'>" + vbCrLf)
            sbHtml.Append("<TD  align='Right' nowrap ><B>Start Date&nbsp;</B></TD>" + vbCrLf)
            sbHtml.Append("<TD  align='Left' nowrap >" + StartDate + "</TD>" + vbCrLf)
            sbHtml.Append("<TD  align='Right' nowrap ><B>End date&nbsp;</B></TD>" + vbCrLf)
            sbHtml.Append("<TD  align='Left' nowrap >" + EndDate + "</TD>" + vbCrLf)
            sbHtml.Append("</TR>" + vbCrLf)

            sbHtml.Append("<TR class='clsTRSectionHeader'>" + vbCrLf)
            sbHtml.Append("<TD  align='Right' nowrap ><B>Planned Work(hrs)&nbsp;</B></TD>" + vbCrLf)
            sbHtml.Append("<TD  align='Left' nowrap >" + PlannedHrs + "</TD>" + vbCrLf)
            sbHtml.Append("<TD  align='Right' nowrap ><B>Remaining Work(hrs)&nbsp;</B></TD>" + vbCrLf)
            sbHtml.Append("<TD  align='Left' nowrap >" + RemaningHrs + "</TD>" + vbCrLf)
            sbHtml.Append("</TR>" + vbCrLf)

            sbHtml.Append("<TR class='clsTRSectionHeader'>" + vbCrLf)
            sbHtml.Append("<TD  align='Right' nowrap ><B>Actual Work(hrs)&nbsp;</B></TD>" + vbCrLf)
            sbHtml.Append("<TD  align='Left' nowrap>" + ActualTillTodayHrs + "</TD>" + vbCrLf)
            sbHtml.Append("<TD></TD><TD></TD>")
            sbHtml.Append("</TR>" + vbCrLf)

        End If

        sbHtml.Append("</Table>" + vbCrLf)

        sbHtml.Append("</Div>" + vbCrLf)
        CommonFunction.Data.DisposeDataReader(dr)
        Response.Write(sbHtml)


    End Sub
    'End of additon by ShraddhaM
#Region " Event Handling "
    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 0 Then
            Args.ColumnName = ""
        End If
        'Start-AUJ-22Jan2007
        If Args.DataField.ToUpper = "DATYPE" Then
            If blnAcceptDATYpe = False Then
                Cancel = True
            End If
        End If
        'End-AUJ-22Jan2007
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        Dim strRemarks As String
        Dim blnVerified As Boolean
        Dim strClass As String

        'If Args.ColumnName = "" Then
        'Cancel = True
        'End If

        If Args.ColIndex = 0 Then

            'Determine stylesheet for row
            If Args.NoOfRowsPrinted Mod 2 = 0 Then
                Args.StringToBeInserted = "<TD align='left'></TD>"
            Else
                Args.StringToBeInserted = "<TD align='left'></TD>"
            End If
            Cancel = True
        End If
        If m_intIndex Mod 2 = 0 Then
            strClass = "clsTREven"
        Else
            strClass = "clsTROdd"
        End If

        m_strPrevProjectName = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectName"), ""), String)

        If Args.DataField = "Verified" And Args.DataReader("IsDisabled") = 0 Then

            Cancel = True
            blnVerified = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Verified"), "0"), Boolean)
            If blnVerified = True Then
                'Commented And Added By Vaijat K ON 18/11/2015
                'Args.StringToBeInserted = "<td class='" + strClass + "' height='22' align='middle'>" + "<input type='checkbox' id='chkVerify' name='chkVerify' onClick='chkVerify_OnClick(" + CType(m_intIndex, String) + "," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + ")' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "' style='WIDTH: 40px; HEIGHT: 20px' size='79' checked></td>"
                Args.StringToBeInserted = "<td class='" + strClass + "' height='22' align='middle'>" + "<input type='checkbox' id='chkVerify' name='chkVerify' onClick='chkVerify_OnClick(" + CType(m_intIndex, String) + "," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + ")' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "'  size='79' checked></td>"
            Else
                'Args.StringToBeInserted = "<td class='" + strClass + "' height='22' align='middle'>" + "<input type='checkbox' id='chkVerify'  name='chkVerify' onClick='chkVerify_OnClick(" + CType(m_intIndex, String) + "," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + ")'  value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "' style='WIDTH: 40px; HEIGHT: 20px' size='79'></td>"
                'Commented And Added By Vaijat K ON 18/11/2015
                'Args.StringToBeInserted = "<td class='" + strClass + "' height='22' align='middle'>" + "<input type='checkbox' id='chkVerify'  name='chkVerify' onClick='chkVerify_OnClick(" + CType(m_intIndex, String) + "," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + ")'  value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "' style='WIDTH: 40px; HEIGHT: 20px' size='79' checked></td>"
                Args.StringToBeInserted = "<td class='" + strClass + "' height='22' align='middle'>" + "<input type='checkbox' id='chkVerify'  name='chkVerify' onClick='chkVerify_OnClick(" + CType(m_intIndex, String) + "," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + ")'  value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "' size='79' checked></td>"
            End If
        ElseIf Args.DataField = "Verified" And Args.DataReader("IsDisabled") = 1 Then
            Cancel = True
            blnVerified = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Verified"), "0"), Boolean)
            If blnVerified = True Then
                Args.StringToBeInserted = "<td class='" + strClass + "' height='22' align='middle'> Yes </td>"
            Else
                Args.StringToBeInserted = "<td class='" + strClass + "' height='22' align='middle'> No </td>"
            End If
           

        End If

        If Args.DataField = "Remarks" And Args.DataReader("IsDisabled") = 0 Then

            Cancel = True
            blnVerified = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Verified"), "0"), Boolean)
            strRemarks = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Remarks"), ""), String)
            'If blnVerified = True Then
            '    Args.StringToBeInserted = "<td class='" + strClass + "' height='22'><input class='clsTextBox' id='txtRemarks" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "' name='txtRemarks" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "' disabled style='WIDTH: 150px; HEIGHT: 22px' size='16' maxlength='200' value=" + strRemarks + "> <input type='hidden' id='txtEntryID" + CType(m_intIndex, String) + "' name='txtEntryID" + CType(m_intIndex, String) + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "'></td>"
            'Else
            '    Args.StringToBeInserted = "<td class='" + strClass + "' height='22'><input class='clsTextBox' id='txtRemarks" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "' name='txtRemarks" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "' style='WIDTH: 150px; HEIGHT: 22px' size='16' maxlength='200' value=" + strRemarks + "> <input type='hidden' id='txtEntryID" + CType(m_intIndex, String) + "' name='txtEntryID" + CType(m_intIndex, String) + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "'></td>"
            'End If
            If blnVerified = True Then
                '' Integrated By ParagD On 10-Feb-2006
                '' Commented & Modififed By ParagD On 5-Nov-2005.
                '' To resolve Issue/Request 252 - DSS - 
                '' When TimeSheet is sent again for approval,Remarks are truncated after blank spaces.
                '' Code Change : Single Quotes added for strRemarks so that it would hold the spaces.
                '' Args.StringToBeInserted = "<td class='" + strClass + "' height='22'><input class='clsTextBox' id='txtRemarks" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "' name='txtRemarks" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "' onClick='txtRemarks_OnClick(" + CType(m_intIndex, String) + ")' style='WIDTH: 150px; HEIGHT: 22px' size='16' maxlength='200' value=" + strRemarks + "> <input type='hidden' id='txtEntryID" + CType(m_intIndex, String) + "' name='txtEntryID" + CType(m_intIndex, String) + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "'></td>"
                '--- modified by purvaj on 2 Jul 2009 8.1 issue fixes
                '--- Replace("'", "&#39;") added.If single quote entered in the remarks, remarks were getting truncated at single quote.
                Args.StringToBeInserted = "<td class='" + strClass + "' height='22'><input class='clsTextBox' id='txtRemarks" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "' name='txtRemarks" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "' onClick='txtRemarks_OnClick(" + CType(m_intIndex, String) + ")' style='WIDTH: 150px; HEIGHT: 22px' size='16' maxlength='200' value='" + strRemarks.Replace("'", "&#39;") + "'> <input type='hidden' id='txtEntryID" + CType(m_intIndex, String) + "' name='txtEntryID" + CType(m_intIndex, String) + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "'></td>"
            Else
                '' Args.StringToBeInserted = "<td class='" + strClass + "' height='22'><input class='clsTextBox' id='txtRemarks" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "' name='txtRemarks" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "' onClick='txtRemarks_OnClick(" + CType(m_intIndex, String) + ")' style='WIDTH: 150px; HEIGHT: 22px' size='16' maxlength='200' value=" + strRemarks + "> <input type='hidden' id='txtEntryID" + CType(m_intIndex, String) + "' name='txtEntryID" + CType(m_intIndex, String) + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "'></td>"
                Args.StringToBeInserted = "<td class='" + strClass + "' height='22'><input class='clsTextBox' id='txtRemarks" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "' name='txtRemarks" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "' onClick='txtRemarks_OnClick(" + CType(m_intIndex, String) + ")' style='WIDTH: 150px; HEIGHT: 22px' size='16' maxlength='200' value='" + strRemarks.Replace("'", "&#39;") + "'> <input type='hidden' id='txtEntryID" + CType(m_intIndex, String) + "' name='txtEntryID" + CType(m_intIndex, String) + "' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DailyActivityEntryID"), "0"), String) + "'></td>"

                '' END : Integrated By ParagD On 10-Feb-2006
            End If
        ElseIf Args.DataField = "Remarks" And Args.DataReader("IsDisabled") = 1 Then
            Cancel = True

            strRemarks = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Remarks"), ""), String)
            If strRemarks <> "" Then
                Args.StringToBeInserted = "<td class='" + strClass + "' height='22' align='middle'> " + strRemarks + " </td>"

            Else
                Args.StringToBeInserted = "<td class='" + strClass + "' height='22' align='middle'> </td>"
            End If

        End If
        'Start-AUJ-22Jan2007
        If Args.DataField.ToUpper = "DATYPE" Then
            If blnAcceptDATYpe = False Then
                Cancel = True
            End If
        End If
        'End-AUJ-22Jan2007

        'Added by ShraddhaM on 2,Apr 2008 for Graphical view of task


        If Args.DataField.ToUpper = "ENTRYDATE" Then
            Dim ActualsTillToday As Double
            Dim TotalHrs As Double
            Dim HrsPercentage As Double
            Dim LeftWidth As Double
            Dim RightWidth As Double
            Dim LeftTDColor As String = "Green"
            Dim WhichTask As String
            Dim strStyle As String

            WhichTask = CType(Args.DataReader("WhichTask"), String)

            ActualsTillToday = CType(Args.DataReader("ActualsTillToday"), Double)
            TotalHrs = CType(Args.DataReader("TotalHrs"), Double)
            HrsPercentage = (ActualsTillToday / TotalHrs) * 100
            If HrsPercentage > 100 Then
                HrsPercentage = 100
                LeftTDColor = "Red"
            End If
            LeftWidth = HrsPercentage
            RightWidth = 100 - HrsPercentage
            'If Task is not General Task
            If WhichTask <> "D" Then
                Cancel = True
                Args.StringToBeInserted = "<TD>" + CommonFunction.Dates.CGetDate(CType(Args.DataReader("EntryDate"), Date))
                Args.StringToBeInserted += "<BR><BR>"
                Args.StringToBeInserted += "<Table width=99.99% style='cursor:hand;' onclick='ShowTaskPopUp(event," + CType(Args.DataReader("TaskID"), String) + ")' cellspacing=0 cellpadding=0 >"
                Args.StringToBeInserted += "<TR height=10px style='font-size: 2pt;font-family: Verdana, Arial' >"
                If HrsPercentage >= 100 Then
                    strStyle = " border-right: 1px groove black; colspan=2 "
                Else
                    strStyle = ""
                End If
                Args.StringToBeInserted += "<TD width=" + LeftWidth.ToString() + "% bgcolor='" + LeftTDColor + "' style='border-bottom: 1px groove black;border-left: 1px groove black;border-top: 1px groove black; " + strStyle + "' >"
                Args.StringToBeInserted += "&nbsp;</TD>"

                If strStyle = "" Then
                    Args.StringToBeInserted += "<TD width=" + RightWidth.ToString() + "% bgcolor='white' style='border-right: 1px groove black;border-bottom: 1px groove black;border-top: 1px groove black' >"
                End If

                Args.StringToBeInserted += "&nbsp;</TD>"
                Args.StringToBeInserted += "</TR>"
                Args.StringToBeInserted += "<TR style='font-size: 8pt;font-family: Verdana, Arial;text-align:center;text-decoration:underline;color:black;'>"
                Args.StringToBeInserted += "<TD colspan=2 style='color:black;text-decoration:underline;'><Font color=" + LeftTDColor + "> " + ActualsTillToday.ToString() + "</Font> / " + TotalHrs.ToString()
                Args.StringToBeInserted += "</TD>"
                Args.StringToBeInserted += "</TR>"
                Args.StringToBeInserted += "</Table>"
                Args.StringToBeInserted += "</TD>"
            Else 'If General Task then display only Actual Hrs
                Cancel = True
                LeftTDColor = "Green"
                Args.StringToBeInserted = "<TD>" + CommonFunction.Dates.CGetDate(CType(Args.DataReader("EntryDate"), Date))
                Args.StringToBeInserted += "<BR><BR>"
                Args.StringToBeInserted += "<Table width=99.99% cellspacing=0 cellpadding=0 >"
                Args.StringToBeInserted += "<TR style='font-size: 8pt;font-family: Verdana, Arial;text-align:center;'>"
                Args.StringToBeInserted += "<TD colspan=2><Font color=" + LeftTDColor + "> General Task : " + ActualsTillToday.ToString() + "</Font>"
                Args.StringToBeInserted += "</TD>"
                Args.StringToBeInserted += "</TR>"
                Args.StringToBeInserted += "</Table>"
                Args.StringToBeInserted += "</TD>"
            End If
        End If
        'End of addtion by ShraddhaM
    End Sub

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint

        Dim strEntryDate As String
        strEntryDate = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EntryDate"), ""), String)



        'Trupti
        If m_ProjectName <> Args.DataReader("ProjectName").ToString.Trim Then
            '    m_ProjectName = Args.DataReader("ProjectName").ToString.Trim + ""

            '    Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left' colspan=7>" + Args.DataReader("ProjectName").ToString + "</FONT></TD></TR>"
            'End If
            'end

            If strEntryDate = "" Then
                Cancel = True
            End If
            Dim strClass As String
            If m_intIndex Mod 2 = 0 Then
                strClass = "clsTREven"
            Else
                strClass = "clsTROdd"
            End If
            Dim sbProjectTotal As New System.Text.StringBuilder("")
            If m_strPrevProjectName <> CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectName"), ""), String) And m_strPrevProjectName <> "" Then
                'sbProjectTotal.Append("<tr width='100%' class='clsTRColumnHeader'>")
                sbProjectTotal.Append("<tr class='" + strClass + "'><TD  align=left></TD>")
                sbProjectTotal.Append("<td align='left'  width='58%' colspan='3'>" + "Total Work (hrs): " + m_strPrevProjectName + "</td>")
                'sbFooterHTML.Append("<td align='right' width='8%'>" + CType(FormatNumber(m_intTotalOverTime, 2), String) + "</td>")
                sbProjectTotal.Append("<td align='right' width='8%'>" + CType(FormatNumber(m_dblProjectTotal, 2), String) + "</td>")
                'Start-AUJ-22Jan2007
                If blnAcceptDATYpe = True Then
                    sbProjectTotal.Append("<td align='right' width='28%' colspan='3'>&nbsp;&nbsp;</td>")
                Else
                    sbProjectTotal.Append("<td align='right' width='28%' colspan='2'>&nbsp;&nbsp;</td>")
                End If
                'End-AUJ-22Jan2007

                sbProjectTotal.Append("</tr>")
                Args.StringToBeInserted = sbProjectTotal.ToString
                m_strPrevProjectName = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectName"), ""), String)
                m_dblProjectTotal = 0
            End If
            m_ProjectName = Args.DataReader("ProjectName").ToString.Trim + ""
            If blnAcceptDATYpe = False Then
                Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left' colspan=7>" + Args.DataReader("ProjectName").ToString + "</FONT></TD></TR>"
            Else
                Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left' colspan=8>" + Args.DataReader("ProjectName").ToString + "</FONT></TD></TR>"
            End If
        End If
    End Sub

    Private Sub m_objGrid_DataRowTD_AfterPrint(ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_AfterPrint
        If Args.DataField = "Description" Then
            m_intTotalAHM = m_intTotalAHM + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TotalDuration"), "0"), Double)
            m_intTotalOverTime = m_intTotalOverTime + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TotalOvertimeDuration"), "0"), Double)
            m_dblProjectTotal = m_dblProjectTotal + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TotalDuration"), "0"), Double)
        End If
    End Sub

    Private Sub m_objGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_AfterPrint
        m_intIndex = m_intIndex + 1
    End Sub

    Private Sub m_objGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles m_objGrid.SummaryFunctionsTR_BeforePrint
        Dim sbProjectTotal As New System.Text.StringBuilder("")
        Dim sbFooterHTML As New System.Text.StringBuilder("")
        Dim dblTotalHours As Double
        Dim strClass As String
        If m_intIndex Mod 2 = 0 Then
            strClass = "clsTREven"
        Else
            strClass = "clsTROdd"
        End If
        'sbProjectTotal.Append("<tr width='100%' class='clsTRColumnHeader'>")
        sbProjectTotal.Append("<tr class='" + strClass + "'><TD  align=left></TD>")
        sbProjectTotal.Append("<td align='left'  width='58%' colspan='3'>" + "Total Work (hrs): " + m_strPrevProjectName + "</td>")
        'sbFooterHTML.Append("<td align='right' width='8%'>" + CType(FormatNumber(m_intTotalOverTime, 2), String) + "</td>")
        sbProjectTotal.Append("<td align='right' width='8%'>" + CType(FormatNumber(m_dblProjectTotal, 2), String) + "</td>")
        'Start-AUJ-22Jan2007
        If blnAcceptDATYpe = True Then
            sbProjectTotal.Append("<td align='right' width='28%' colspan='3'>&nbsp;&nbsp;</td>")
        Else
            sbProjectTotal.Append("<td align='right' width='28%' colspan='2'>&nbsp;&nbsp;</td>")
        End If
        'End-AUJ-22Jan2007
        sbProjectTotal.Append("</tr>")

        m_dblProjectTotal = 0

        'Writing TR for Period Total
        sbFooterHTML.Append("<tr width='100%' class='clsTRSectionHeader'>")
        'sbFooterHTML.Append("<tr class='" + strClass + "'><TD  align=left></TD>")
        dblTotalHours = m_intTotalAHM '+ m_intTotalOverTime
        sbFooterHTML.Append("<td align='left'  width='64%' colspan='4'>" + MyBase.GetResourceString("TOTAL_WORK_HOURS") + "</td>")
        'sbFooterHTML.Append("<td align='right' width='8%'>" + CType(FormatNumber(m_intTotalOverTime, 2), String) + "</td>")
        sbFooterHTML.Append("<td align='right' width='8%'>" + CType(FormatNumber(m_intTotalAHM, 2), String) + "</td>")
        'Start-AUJ-22Jan2007
        If blnAcceptDATYpe = True Then
            sbFooterHTML.Append("<td align='right' width='28%' colspan='3'>&nbsp;&nbsp;</td>")
        Else
            sbFooterHTML.Append("<td align='right' width='28%' colspan='2'>&nbsp;&nbsp;</td>")
        End If
        'End-AUJ-22Jan2007
        sbFooterHTML.Append("</tr>")

        Args.StringToBeInserted = sbProjectTotal.ToString + sbFooterHTML.ToString

    End Sub

#End Region

#Region " Constructor "
    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.RT_VerifyResourceTimesheetDetails", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
#End Region

End Class
