Public Class MyLeaves_CommonPage
    Inherits CommonPage

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) 'Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    'Added By VarunA on 17-May-2007 Cleanup Activity for Leave WorkFlow
    Dim LeaveStatusID As String = ""
    'End By VarunA on 17-May-2007 

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "MyLeaves_CommonList.aspx"
        MyBase.strFormPage = "MyLeaves_CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
    Public Enum ReturnCodes
        DO_NOTHING
        ON_LOAD
        REDIRECT
        OPEN_WINDOW
        IGNORE_SAVE
        IGNORE_DELETE
        ' ***************************************************************************************
        ' Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_39
        ' ***************************************************************************************
        IGNORE_SAVE_AND_OPEN_WINDOW
        IGNORE_SAVE_AND_REDIRECT
        IGNORE_SAVE_AND_ON_LOAD
        IGNORE_DELETE_AND_OPEN_WINDOW
        IGNORE_DELETE_AND_REDIRECT
        IGNORE_DELETE_AND_ON_LOAD
        ' ***************************************************************************************
        ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_39
        ' ***************************************************************************************

    End Enum
    'Private m_objTemplate As WebPages.Template.WhizTemplate

    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        'Added By VarunA on 10-May-2007 Clean Activity for Leave Workflow
        Dim strQuery As String = ""
        Dim drEmail As IDataReader
        Dim blnSendMail As Boolean = False
        Dim blnShowPopup As Boolean = False
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String
        Dim intLeaveID As Integer = 0
        'End By VarunA on 10-May-2007

        'Integrated by ManishK on 03 Jan 06
        'modified by SachinR    on 30 Nov 2005
        'added condition to send request type 

        'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4192

        'Modified by SandipL on 15 May 2006 for WhizEnggSP6  IssueID 3738

        'Added By VarunA on 10-May-2007 Clean Activity for Leave Workflow
        'Purpose : For handling popup
        drEmail = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 68", MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drEmail) <> "" Then
            If drEmail.Read() Then
                blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("SendMail"), "False"), Boolean)
                blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("ShowPopup"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drEmail)
        'End By VarunA on 10-May-2007

        If PrimaryKey.Trim() <> "" Then
            Dim strSQL As String
            strSQL = "<script language = javascript>"
            ''Added By VarunA on 10-May-2007 Clean Activity for Leave Workflow
            'Purpose : For handling popup
            If blnSendMail = True Then
                If blnShowPopup = True Then
                    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("LeaveOrWFH"), "") = "W" Then
                        'Modified BynitinVS on 2 Apr 2007 forWhizibleSEM SP 8 Regression Issue 11291 
                        ' Added code to set the mail pop in the center 
                        strSQL += "window.open('../General/SendEmail.aspx?MessageID=68&Type=W&LeaveID=" & PrimaryKey & "',null,'status=no,toolbar=no,menubar=no,location=no,width=600,height=500" + " left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 " + ");"
                    Else
                        strSQL += "window.open('../General/SendEmail.aspx?MessageID=68&Type=L&LeaveID=" & PrimaryKey & "',null,'status=no,toolbar=no,menubar=no,location=no,width=600,height=500" + " left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 " + ");"
                    End If
                Else
                    intLeaveID = Convert.ToInt32(PrimaryKey)
                    CommonFunction.EmailMessages.PMMessages.GetEmailMessage_68(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intLeaveID)
                    CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                End If
            End If
            'End By VarunA on 10-May-2007

            ' End Modified BynitinVS on 2 Apr 2007 forWhizibleSEM SP 8 Regression Issue 11291 

            ' strSQL += vbCrLf + "var objCtrl = GetObjectReference('frmcommonpage','FFE29587WHIZ_AppliedDate'); if (objCtrl!= null){objCtrl.focus=false}"

            If IsEditMode = False Then
                strSQL += "window.location.href = 'MyLeaves_CommonList.aspx?FromWhere=DT&MasterTagId=1208';"
            End If
            'Modified by ShraddhaM on Date 11 July,2006 for WhizibleSEM Issue ID.4168


            If IsEditMode = True Then
                Dim strtoken As String

                strtoken = Request.Form("PKToken")
                'Commented and Modified by SavitaS on 15 Sept 2006 for SP7 Integration IssueID 6223
                'Issue : After save in Edit Mode page was showing  another record.
                ' strSQL += "window.location.href = 'MyLeaves_CommonPage.aspx?LeaveID_PK=" + PrimaryKey.Trim + "&PKToken=" + strtoken + "&FromWhere=DT&MasterTagId=1208&ParentTagID=0';"
                strSQL += "window.location.href = 'MyLeaves_CommonPage.aspx?LeaveID_PK=" + PrimaryKey.Trim + "&PKToken=" + strtoken + "&MasterTagId=1208&FromWhere=DT&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1';"
                'End of Commented and Modified by SavitaS on 15 Sept 2006 for SP7 Integration IssueID 6223
            End If

            strSQL += "</script>"
            AfterSave += strSQL
            strActionCode = ReturnCodes.ON_LOAD.ToString
            RedirectToCL = False
            CommonFunction.General.WriteHTML(strSQL)
        End If



        ' End Modification by SandipL on 15 May 2006
        'End Integration
        'modification end   on 30 Nov 2005
        'End of Integrated by ManishK on 03 Jan 06
    End Function



    Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        If m_objGlobal.ParentTagID = 0 Then
            'Initialize the Resources

            'm_objTemplate.InitializeResources("AppResources.EmployeeLeaveApplication", "AppResources")
            MyBase.InitializeResources("AppResources.EmployeeLeaveApplication", "AppResources")
            Dim strScript As String
            'Initialize the varibles used to display validation messages
            strScript = "var strDateMsg='" + MyBase.GetResourceString("LEAVE_APPLICATION_HALFDAY_MESSAGE") + "';" + vbCrLf
            strScript += "var objXHttp;" + vbCrLf
            strScript += "var blnFlag = false;" + vbCrLf
            'Added & Modified By VarunA on 17-Aug-2009 RequestID-22994
            'Purpose : To have validation based on working days instead of From & ToDate.
            strScript += "var blnPeriodFlag = false;" + vbCrLf
            strScript += "var strText = new String();" + vbCrLf
            strScript += "var arrStr = new Array();" + vbCrLf
            strScript += "var objBusinessDaysCount;" + vbCrLf
            strScript += "var objLeaveBalance;" + vbCrLf
            strScript += "var objSecondHalfDayLeave;" + vbCrLf
            strScript += "	function HandlerOnReadyState()" + vbCrLf
            strScript += "{" + vbCrLf
            strScript += "if (objXHttp.readyState==4)" + vbCrLf
            strScript += "{" + vbCrLf
            strScript += "if (objXHttp.responseText != null) " + vbCrLf
            strScript += " {" + vbCrLf
            ''strScript += " if (objXHttp.responseText == 'True')" + vbCrLf
            '''Comment and modification done by SuchitraP on 25-Jun-2007 for IssueID 11887
            '''strScript += " {alert('Employee has already applied for leave between \'' + objfrm.FromDate.value + '\' and \'' + objfrm.ToDate.value + '\'');" + vbCrLf
            ''strScript += " {alert('Employee has already applied for Leave/Work From Home between \'' + objfrm.FromDate.value + '\' and \'' + objfrm.ToDate.value + '\'');" + vbCrLf
            '''End of comment and modification done by SuchitraP on 25-Jun-2007 for IssueID 11887
            ''strScript += " blnFlag = true;" + vbCrLf
            ''strScript += "}" + vbCrLf
            ''strScript += " else" + vbCrLf
            ''strScript += " blnFlag = false;" + vbCrLf
            strScript += "strText = objXHttp.responseText;" + vbCrLf
            strScript += "arrStr = strText.split(""|"");" + vbCrLf
            strScript += "objBusinessDaysCount = arrStr[1];" + vbCrLf
            ''Modified by Amit Mahadik on 19 May 2011 whizible sem 10.0
            strScript += "objSecondHalfDayLeave = GetObjectReference('frmCommonPage', 'SecondHalfDay');" + vbCrLf
            ''End Modified by Amit Mahadik on 19 May 2011 whizible sem 10.0
            strScript += "objLeaveBalance = GetObjectReference('frmCommonPage', 'NonDatabase1');" + vbCrLf
            strScript += " if (arrStr[0] == 'True')" + vbCrLf
            'Comment and modification done by SuchitraP on 25-Jun-2007 for IssueID 11887
            'strScript += " {alert('Employee has already applied for leave between \'' + objfrm.FromDate.value + '\' and \'' + objfrm.ToDate.value + '\'');" + vbCrLf
            strScript += " {alert('Employee has already applied for Leave/Work From Home between \'' + objfrm.FromDate.value + '\' and \'' + objfrm.ToDate.value + '\'');" + vbCrLf
            'End of comment and modification done by SuchitraP on 25-Jun-2007 for IssueID 11887
            strScript += " blnFlag = true;" + vbCrLf
            strScript += " blnPeriodFlag = true;" + vbCrLf
            strScript += "}" + vbCrLf
            strScript += " else {" + vbCrLf
            strScript += " blnFlag = false;" + vbCrLf
            strScript += " blnPeriodFlag = false; }" + vbCrLf
            strScript += "if(objLeaveBalance.value!=''){"
            strScript += "if(objSecondHalfDayLeave.checked==true){"
            strScript += "if(objBusinessDaysCount!=null || objBusinessDaysCount!='') { if (parseFloat(objLeaveBalance.value) < (parseFloat(objBusinessDaysCount) - .5) && blnPeriodFlag == false)" + vbCrLf
            strScript += " { var bConfirmed;" + vbCrLf
            strScript += "bConfirmed = window.confirm('" + MyBase.GetResourceString("LEAVE_APPLICATION_BALANCE_MESSAGE") + "');" + vbCrLf
            strScript += "if (bConfirmed == false) " + vbCrLf
            strScript += "{ objLeaveBalance.disabled = true;"
            strScript += " blnFlag = true;" + vbCrLf
            strScript += "} } }}" + vbCrLf
            strScript += "else {" + vbCrLf
            strScript += "if(objBusinessDaysCount!=null || objBusinessDaysCount!='') { if (parseFloat(objLeaveBalance.value) < parseFloat(objBusinessDaysCount) && blnPeriodFlag == false)" + vbCrLf
            strScript += " { var bConfirmed;" + vbCrLf
            strScript += "bConfirmed = window.confirm('" + MyBase.GetResourceString("LEAVE_APPLICATION_BALANCE_MESSAGE") + "');" + vbCrLf
            strScript += "if (bConfirmed == false) " + vbCrLf
            strScript += "{ objLeaveBalance.disabled = true;"
            strScript += " blnFlag = true;" + vbCrLf
            strScript += "} } }}}" + vbCrLf
            'End By VarunA on 17-Aug-2009 RequestID-22994
            strScript += "}" + vbCrLf
            strScript += "}" + vbCrLf
            strScript += "}" + vbCrLf
            PageUIPreRender = strScript
            'ReInitialize the Resources
            MyBase.InitializeResources("AppResources.EventHandlers", "AppResources")
            'Application standard return code
            strActionCode = ReturnCodes.ON_LOAD.ToString
        Else
        End If

        'Modified By VarunA on 17-May-2007 Cleanup Activity for leave workflow
        'Purpose : To have the leaveStatusID global for performance.
        If strPrimaryKey <> "" Then
            LeaveStatusID = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT LeaveStatusID FROM tbl_PM_EmployeeLeaveDetails WHERE LeaveID = " + strPrimaryKey, MyBase.UseSQL), ""))
        End If
        'End By VarunA on 17-May-2007

    End Function

    Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String

        If m_objGlobal.ParentTagID = 0 Then
            Dim strScript As String
            strScript += "var objLBalance = GetObjectReference('frmCommonPage','NonDatabase1');" + vbCrLf
            strScript += "var objLeave;" + vbCrLf
            'ADDED BY MANGESH ON 7 APRIL 2005 : DEFAULT LEAVE TYPE SHOULD ONLY BE SET IN ADD NEW MODE PCFC ISSUE 17546
            strScript += "var objLeaveId = GetObjectReference('frmCommonPage','LeaveID_PK');" + vbCrLf
            'END ADDITION

            strScript += "objLeave = GetObjectReference('frmCommonPage', 'LeaveTypeID');   " + vbCrLf
            'ADDED BY MANGESH ON 7 APRIL 2005 : DEFAULT LEAVE TYPE SHOULD ONLY BE SET IN ADD NEW MODE PCFC ISSUE 17546
            strScript += "if(objLeaveId!=null) { if (objLeaveId.value == '')" + vbCrLf
            'END ADDITION

            'Modified By VarunA on 15-May-2007 Clean Activity for Leave Workflow
            'strScript += "objLeave.selectedIndex = 1;"
            strScript += "objLeave.selectedIndex = 0; }"
            'End By VarunA on 15-May-2007

            ''Modified by ManishK on 28th Feb 2006 for WFH issues
            'strScript += "objLBalance.selectedIndex = 1;" + vbCrLf
            'Code modified By vidyaj - IssueId - 11510
            ''Comment By VarunA on 9-MAY-2007 Cleanup Activity for Leave WorkFLow
            'Purpose : objLBalance has now been taken as textbox
            'strScript += " if(objLBalance!==null)"
            'strScript += "objLBalance.selectedIndex = objLeave.selectedIndex;" + vbCrLf
            ''End By VarunA on 9-MAY-2007

            ''End of Modified by ManishK on 28th Feb 2006 for WFH issues

            'Added by PrajaktaR on 16 th May 2005 for PCFC IssueID 19235
            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")) = "SAVE" Or strPrimaryKey <> "" Then
                'On saving the Form do net set focus on any of the control 
                ''Modified by Manishk on 27th Feb 2006 for the SP 6 IssueID  1755
                'PageUIPostRender = vbCrLf + "var objCtrl = GetObjectReference('frmcommonpage','AppliedDate'); if (objCtrl!= null){objCtrl.focus=false}"
                strScript += vbCrLf + "var objCtrl = GetObjectReference('frmcommonpage','FFE29587WHIZ_AppliedDate'); if (objCtrl!= null){objCtrl.focus=false}"
                ''End Modified by Manishk on 27th Feb 2006 for the SP 6 IssueID  1755
                '  strActionCode = ReturnCodes.ON_LOAD.ToString
            End If
            'End of Addition by PrajaktaR on 16 th May 2005 for PCFC IssueID 19235

            PageUIPostRender = strScript
            strActionCode = ReturnCodes.ON_LOAD.ToString
        Else
        End If
    End Function

    Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If WhizGlobal.ParentTagID = 0 Then
            'For Master Tag
            If Args.ClientSideFunctionName.ToUpper = "CANCEL_ONCLICK" Then
                Dim strFunction As String
                strFunction = "var bConfirmed;" + vbCrLf
                strFunction += "bConfirmed = window.confirm('Do you want cancel the leave application?');" + vbCrLf
                strFunction += "if (bConfirmed == false) " + vbCrLf
                strFunction += "return;"
                Args.ToBeInserted = strFunction
            End If
        Else
        End If
    End Sub

    Protected Overrides Sub After_ExecutingAction(ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)
        If WhizGlobal.ParentTagID = 0 Then
            'For Master Tag
            Dim strSQL As String

            'Added By VarunA on 10-May-2007 Clean Activity for Leave Workflow
            'Purpose : For handling popup
            Dim strQuery As String = ""
            Dim drEmail As IDataReader
            Dim blnSendMail As Boolean = False
            Dim blnShowPopup As Boolean = False
            Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String
            Dim intLeaveID As Integer = 0

            drEmail = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 84", MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drEmail) <> "" Then
                If drEmail.Read() Then
                    blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("SendMail"), "False"), Boolean)
                    blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("ShowPopup"), "False"), Boolean)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drEmail)
            'End By VarunA on 10-May-2007

            'comment By VarunA on 10-May-2007 Clean Activity for Leave Workflow
            'Purpose : For handling popup
            'strSQL = "<script language = javascript>"
            'strSQL += "window.open('../General/SendEmail.aspx?MessageID=84&LeaveID=" & PrimaryKey & "',null,'status=no,toolbar=no,menubar=no,width=600,height=500" + " left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 " + ");"
            'End By VarunA on 10-May-2007

            'Added BY VarunA on 10-May-2007 Clean Activity for Leave Workflow
            'Purpose : For handling popup
            strSQL = "<script language = javascript>"
            If blnSendMail = True Then
                If blnShowPopup = False Then
                    intLeaveID = Convert.ToInt32(PrimaryKey)
                    CommonFunction.EmailMessages.PMMessages.GetEmailMessage_84(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intLeaveID)
                    CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                End If
            End If
            'End By VarunA on 10-May-2007

            'Added by PrajaktaR on 16 th May 2005 for PCFC IssueID 19235
            'If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")) = "SAVE" Then
            'On saving the Form do net set focus on any of the control 
            ''Modified by Manishk on 27th Feb 2006 for the SP 6 IssueID  1755
            'PageUIPostRender = vbCrLf + "var objCtrl = GetObjectReference('frmcommonpage','AppliedDate'); if (objCtrl!= null){objCtrl.focus=false}"
            strSQL += vbCrLf + "var objCtrl = GetObjectReference('frmcommonpage','FFE29587WHIZ_AppliedDate'); if (objCtrl!= null){objCtrl.focus=false}"
            ''End Modified by Manishk on 27th Feb 2006 for the SP 6 IssueID  1755
            '  strActionCode = ReturnCodes.ON_LOAD.ToString
            'End If
            'End of Addition by PrajaktaR on 16 th May 2005 for PCFC IssueID 19235
            strSQL += "</script>"
            CommonFunction.General.WriteHTML(strSQL)
        Else
        End If
    End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'added by   NileshD     On  08 Apr 2004
        'to insert the client script to ask the user about the confirmation to leave application 
        'when leave balance is less than the applied leaves.
        If WhizGlobal.ParentTagID = 0 Then
            'For Master Tag
            'modified by HarshK on 08 Mar 2006
            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
                If Args.PrimaryKeyValue.ToString <> "" Then
                    'Comment By VarunA on 17-May-2007 Cleanup Activity for leave workflow
                    'Dim strLeaveStatusID As String = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select LeavestatusID from d_tbl_PM_EmployeeLeaveDetails WHERE LeaveID=" & Args.PrimaryKeyValue.ToString, MyBase.UseSQL), ""))
                    'End By VarunA on 17-May-2007 

                    ''Commented By VarunA on 13-Sep-2007 Whizible 7.1 Development & Release
                    ''Purpose : To show Save link on backdated Date For Submitted & Rejected Leave
                    'Added and Modified By VarunA on 21-May-2007 Cleanup activity for leave workflow.
                    'Purpose : To disable SAVE link for the passes todate 
                    ''Dim drToDate As IDataReader
                    ''drToDate = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_LeaveToDate " + Args.PrimaryKeyValue.ToString, MyBase.UseSQL)
                    ''drToDate.Read()
                    ''If CType(drToDate(0), Int32) > 0 Then
                    ''    Cancel = True
                    ''End If
                    ''CommonFunctions.Data.DisposeDataReader(drToDate)
                    'End By VarunA on 21-May-2007 
                    ''End of Comment By VarunA on on 13-Sep-2007 Whizible 7.1

                    ''Modified By VarunA on 21-May-2007 Cleanup activity for leave workflow.
                    ''Purpose : To disable save link while it is Approved, rejected,cancelled .
                    '''Modified By VarunA on 11-Sep-2007 Whizible 7.1 
                    '''Purpose : To have save link when it is submitted and rejected. Not to allow save if it 
                    '''approved and rejected within that time period.
                    '''If LeaveStatusID.Trim <> "1" Then

                    'If LeaveStatusID.Trim <> "1" And LeaveStatusID.Trim <> "3" Then
                    If LeaveStatusID.Trim <> "3" Then

                        'Commented By VarunA on 7-June-2007 Cleanup activity for leave workflow.
                        'If LeaveStatusID.Trim <> "1" And LeaveStatusID.Trim <> "3" Then
                        'End By VarunA on 7-June-2007
                        'ADDED and deleted BY AMIT MAHADIK ON 18 MAY 2011,WHIZIBLESEM 10.0
                        'Purpose : To allow Resubmit leave if applied for half day and want to convert into 1 day.
                        '''''Dim isHalfDay As Boolean = CBool(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT HalfDay from tbl_PM_EmployeeLeaveDetails WHERE LeaveID=" & Args.PrimaryKeyValue.ToString, MyBase.UseSQL), ""))
                        '''''If Not isHalfDay Then
                        Cancel = True
                        '''''End If
                        'END ADDED and deleted BY AMIT MAHADIK ON 18 MAY 2011,WHIZIBLESEM 10.0
                    End If
                    '''End By VarunA on 11-Sep-2007
                    ''End By VarunA on 21-May-2007 

                    'Added By VarunA 0n 18-Sep-2007 Whizible 7.1 Development & Release
                    'Purpose : To have the Resubmit link for the rejected leave.
                    If LeaveStatusID.Trim = "3" Then
                        Args.LinkName = "Resubmit"
                        Args.LinkToolTip = "Resubmit"
                    End If
                    'End By VArunA 0n 18-Sep-2007


                End If
                Dim strFunction As String
                Dim m_objTemplate As New WebPages.Template.WhizTemplate
                m_objTemplate.InitializeResources("AppResources.EmployeeLeaveApplication", "AppResources")
                strFunction = " var objBalance;" + vbCrLf
                'Commented By VarunA on 17-Aug-2009 RequestID-22994
                'Purpose : To have validation based on working days instead of From & ToDate.
                ''strFunction = " var objFrom;" + vbCrLf
                ''strFunction += " var objTo;" + vbCrLf
                '''Added By VarunA on 26-June-2009 RequestID-21413
                '''Purpose : To validate balance leaves when there is halfday and .5 balance leave employee has.
                ''strFunction += " var objHalfDay;" + vbCrLf
                '''End By VarunA on 26-June-2009 RequestID-21413
                ''strFunction += "objFrom = GetObjectReference('frmCommonPage', 'FromDate');" + vbCrLf
                '''Added By VarunA on 26-June-2009 RequestID-21413
                '''Purpose : To validate balance leaves when there is halfday and .5 balance leave employee has.
                ''strFunction += "objHalfDay = GetObjectReference('frmCommonPage', 'HalfDay');" + vbCrLf
                '''End By VarunA on 26-June-2009 RequestID-21413
                '''Modified by ShraddhaM on Date 04 Jully,2006 for WhizibleSEM Issue ID.4168
                '''strFunction += "alert( objFrom.value );" + vbCrLf

                ''strFunction += "objTo = GetObjectReference('frmCommonPage', 'ToDate');" + vbCrLf
                'End By VarunA on 17-Aug-2009 RequestID-22994


                '''strFunction += "alert( objTo.value );" + vbCrLf
                strFunction += "objBalance = GetObjectReference('frmCommonPage', 'NonDatabase1');" + vbCrLf

                'Added By Usha Pandit On 12.05.2020 For validation of already applied leaves for specific date range
                'strFunction += "var objFromDate = GetObjectReference('frmCommonPage' , 'FromDate');" + vbCrLf
                'strFunction += "var objToDate = GetObjectReference('frmCommonPage', 'ToDate'); " + vbCrLf
                'strFunction += "var objNonDatabase6 = GetObjectReference('frmCommonPage', 'NonDatabase6'); " + vbCrLf
                'strFunction += "var dtFromdate = getDateFromFormat(objFromDate.value); " + vbCrLf
                'strFunction += "var dtToDate = getDateFromFormat(objToDate.value);" + vbCrLf
                'strFunction += "if (objNonDatabase6 != null)  {" + vbCrLf
                'strFunction += "for (i=1;i<objNonDatabase6.length;i++)   {" + vbCrLf
                'strFunction += "var dtFrom = getDateFromFormat(objNonDatabase6[i].value); " + vbCrLf
                'strFunction += "var dtTo =   getDateFromFormat(objNonDatabase6[i].text); " + vbCrLf
                'strFunction += "if( (dtFromdate >= dtFrom && dtFromdate <= dtTo) || (dtToDate >= dtFrom && dtToDate <= dtTo) || (dtFromdate < dtFrom && dtToDate > dtTo) || (dtFromdate <= dtFrom && dtToDate > dtFrom )) {  " + vbCrLf
                'strFunction += "alert('Leave is already applied for the given Date Range!!!'); return false;   }}}" + vbCrLf




                strFunction += "var objFromDate = GetObjectReference('frmCommonPage' , 'FromDate');" + vbCrLf
                strFunction += "var objToDate = GetObjectReference('frmCommonPage', 'ToDate'); " + vbCrLf
                strFunction += "var objNonDatabase6 = GetObjectReference('frmCommonPage', 'NonDatabase6'); " + vbCrLf

                strFunction += " var objEmployeeID = GetObjectReference('frmCommonPage', 'EmployeeID'); " + vbCrLf
                strFunction += " var objFirstHalfDay = GetObjectReference('frmCommonPage', 'FirstHalfDay'); " + vbCrLf
                strFunction += " var objSecondHalfDay = GetObjectReference('frmCommonPage', 'SecondHalfDay'); " + vbCrLf

                strFunction += " var IsFirstHalfExists = false; " + vbCrLf
                strFunction += " var IsSecondHalfExists = false; " + vbCrLf
                strFunction += " var blnNoHalfDayChecked = false; " + vbCrLf
                strFunction += " var dtFromdate = objFromDate.value; " + vbCrLf

                strFunction += " var dtToDate = objToDate.value; " + vbCrLf
                strFunction += " if (objFirstHalfDay.checked == false && objSecondHalfDay.checked == false) { " + vbCrLf
                strFunction += " blnNoHalfDayChecked = true; " + vbCrLf
                strFunction += " } " + vbCrLf

                strFunction += " if (objNonDatabase6 != null) " + vbCrLf
                strFunction += " { " + vbCrLf
                strFunction += "     for (i = 1;i<objNonDatabase6.length;i++) " + vbCrLf
                strFunction += "     { " + vbCrLf
                strFunction += "         var dtDates = objNonDatabase6[i].text; " + vbCrLf
                strFunction += "         var arrDates = dtDates.toString().split('#'); " + vbCrLf
                strFunction += "         var curEmployee = objNonDatabase6[i].value; " + vbCrLf
                strFunction += "         var curFirstHalf = arrDates[2]; " + vbCrLf
                strFunction += "         var curSecondHalf = arrDates[3]; " + vbCrLf
                strFunction += "         var dtFrom = arrDates[0]; " + vbCrLf
                strFunction += "         var dtTo = arrDates[1]; " + vbCrLf
                strFunction += "         if (curEmployee == objEmployeeID.value) { " + vbCrLf

                strFunction += " if (curFirstHalf == 0 && curSecondHalf == 0) { " + vbCrLf
                strFunction += " IsFirstHalfExists = true; " + vbCrLf
                strFunction += " IsSecondHalfExists = true; " + vbCrLf
                strFunction += " } " + vbCrLf
                strFunction += " if (curFirstHalf == 1) { " + vbCrLf
                strFunction += " IsFirstHalfExists = true; " + vbCrLf
                strFunction += " } " + vbCrLf
                strFunction += " if (curSecondHalf == 1) { " + vbCrLf
                strFunction += " IsSecondHalfExists = true; " + vbCrLf
                strFunction += " } " + vbCrLf



                strFunction += " if ((Date.parse(dtFromdate.toString().replace(/-/g, ' ')) >= Date.parse(dtFrom.toString().replace(/-/g, ' ')) " + vbCrLf
                strFunction += " && Date.parse(dtFromdate.toString().replace(/-/g, ' ')) <= Date.parse(dtTo.toString().replace(/-/g, ' '))) " + vbCrLf
                strFunction += " || (Date.parse(dtToDate.toString().replace(/-/g, ' ')) >= Date.parse(dtFrom.toString().replace(/-/g, ' ')) " + vbCrLf
                strFunction += " && Date.parse(dtToDate.toString().replace(/-/g, ' ')) <= Date.parse(dtTo.toString().replace(/-/g, ' '))) " + vbCrLf
                strFunction += " || (Date.parse(dtFromdate.toString().replace(/-/g, ' ')) < Date.parse(dtFrom.toString().replace(/-/g, ' ')) " + vbCrLf
                strFunction += " && Date.parse(dtToDate.toString().replace(/-/g, ' ')) > Date.parse(dtTo.toString().replace(/-/g, ' '))) " + vbCrLf
                strFunction += " || (Date.parse(dtFromdate.toString().replace(/-/g, ' ')) <= Date.parse(dtFrom.toString().replace(/-/g, ' ')) " + vbCrLf
                strFunction += " && Date.parse(dtToDate.toString().replace(/-/g, ' ')) > Date.parse(dtFrom.toString().replace(/-/g, ' ')))) " + vbCrLf

                strFunction += " { " + vbCrLf
                strFunction += " if ((IsFirstHalfExists == true && IsSecondHalfExists == true) || (curFirstHalf == 1 && objFirstHalfDay.checked == true) || (curSecondHalf == 1 && objSecondHalfDay.checked == true) " + vbCrLf
                strFunction += " || ((curFirstHalf == 1 && blnNoHalfDayChecked == true) || (curSecondHalf == 1 && blnNoHalfDayChecked == true))) { " + vbCrLf

                strFunction += " alert('Leave is already applied for the given Date Range!!!'); " + vbCrLf
                strFunction += " return false; " + vbCrLf
                strFunction += " } " + vbCrLf
                strFunction += " } " + vbCrLf
                strFunction += " else { " + vbCrLf
                strFunction += " if (IsFirstHalfExists == true && IsSecondHalfExists == true) { " + vbCrLf
                strFunction += " IsFirstHalfExists = false; " + vbCrLf
                strFunction += " IsSecondHalfExists = false; " + vbCrLf

                strFunction += " } " + vbCrLf
                strFunction += " } " + vbCrLf
                strFunction += " } " + vbCrLf
                strFunction += " } " + vbCrLf
                strFunction += " } " + vbCrLf



                'End Of Added By Usha Pandit On 12.05.2020 For validation of already applied leaves for specific date range
                ' strFunction += "alert(objBalance[objBalance.selectedIndex].value);" + vbCrLf

                'Modified By VarunA on 8-May-2007 Cleanup activity for leave workflow
                'Purpose : As Balance leave is taken as textbox
                'strFunction += "if(objBalance[objBalance.selectedIndex].value!=''){"
                'strFunction += "if (objBalance[objBalance.selectedIndex].value < DateDiff(getDate(objFrom.value),getDate(objTo.value),""d"") + 1)" + vbCrLf
                'Commented By VarunA on 17-Aug-2009 RequestID-22994
                'Purpose : To have validation based on working days instead of From & ToDate.
                ''strFunction += "if(objBalance.value!=''){"
                ''''''Modified & Commented By VarunA on 26-June-2009 RequestID-21413
                ''''''Purpose : To validate balance leaves when there is halfday and .5 balance leave employee has.
                ''''''strFunction += "if (objBalance.value < DateDiff(getDate(objFrom.value),getDate(objTo.value),""d"") + 1)" + vbCrLf
                '''''''End By VarunA on 8-May-2007

                ''''''strFunction += " { var bConfirmed;" + vbCrLf
                ''''''strFunction += "bConfirmed = window.confirm('" + m_objTemplate.GetResourceString("LEAVE_APPLICATION_BALANCE_MESSAGE") + "');" + vbCrLf
                ''''''strFunction += "if (bConfirmed == false) " + vbCrLf
                ''''''strFunction += "{ objBalance.disabled = true;"
                '''''''Modified By VarunA on 3-Oct-2007 Whiziblesem 7.1 Development & Release
                '''''''Purpose : Not to disable leave Type in edit mode, if a leave is applied more than leave balance.
                '''''''If Args.PrimaryKeyValue.Trim <> "" Then
                '''''''    strFunction += " var objLeave;" + vbCrLf
                '''''''    strFunction += "objLeave = GetObjectReference('frmCommonPage', 'LeaveTypeID');" + vbCrLf
                '''''''    strFunction += "objLeave.disabled = true;"
                '''''''End If
                '''''''End By VarunA VarunA on 3-Oct-2007
                ''''''strFunction += "return; } }}" + vbCrLf
                ''strFunction += "if(objHalfDay.checked==true){"
                ''strFunction += "if (objBalance.value < DateDiff(getDate(objFrom.value),getDate(objTo.value),""d"") + .5)" + vbCrLf
                ''strFunction += " { var bConfirmed;" + vbCrLf
                ''strFunction += "bConfirmed = window.confirm('" + m_objTemplate.GetResourceString("LEAVE_APPLICATION_BALANCE_MESSAGE") + "');" + vbCrLf
                ''strFunction += "if (bConfirmed == false) " + vbCrLf
                ''strFunction += "{ objBalance.disabled = true;"
                ''strFunction += "return; } }}" + vbCrLf
                ''strFunction += "else {" + vbCrLf
                '''Temp By VarunA
                '''strFunction += "if (objBalance.value < DateDiff(getDate(objFrom.value),getDate(objTo.value),""d"") + 1)" + vbCrLf
                ''strFunction += "if(objBusinessDaysCount!=null || objBusinessDaysCount.value!='') if (objBalance.value < objBusinessDaysCount.value)" + vbCrLf
                '''End By VarunA
                ''strFunction += " { var bConfirmed;" + vbCrLf
                ''strFunction += "bConfirmed = window.confirm('" + m_objTemplate.GetResourceString("LEAVE_APPLICATION_BALANCE_MESSAGE") + "');" + vbCrLf
                ''strFunction += "if (bConfirmed == false) " + vbCrLf
                ''strFunction += "{ objBalance.disabled = true;"
                ''strFunction += "return; } }}}" + vbCrLf
                ''''End By VarunA on 26-June-2009 RequestID-21413
                'End By VarunA on 17-Aug-2009 RequestID-22994
                '***** Code added by SandipL on 24 Nov 2005 
                'Purpose :- server side validations(whether employee has applied for these dates already)
                strFunction += "  var strUrl; " + vbCrLf
                strFunction += " strUrl = new String();" + vbCrLf
                'Code modified by vidyaJ - issueID - 6197 - Security issue
                Dim strToken As String
                strToken = Request.Form("PKToken")
                ''Modified by Amit Mahadik on 19 May 2011 whizible sem 10.0
                strFunction += " strUrl = '../General/XMLHttp.aspx?PKToken=" + strToken + "&TagID=1208&EmployeeID=' + objfrm.EmployeeID.value + '&LeaveID=" & Args.PrimaryKeyValue & "&FromDate='+ objfrm.FromDate.value + '&ToDate=' + objfrm.ToDate.value + '&FirstHalfDay=' + objfrm.FirstHalfDay.checked + '&SecondHalfDay=' + objfrm.SecondHalfDay.checked;" + vbCrLf
                ''End Modified by Amit Mahadik on 19 May 2011 whizible sem 10.0
                strFunction += "if (document.all) " + vbCrLf
                strFunction += " { " + vbCrLf
                strFunction += " objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  " + vbCrLf
                strFunction += " objXHttp.onreadystatechange = HandlerOnReadyState; " + vbCrLf
                strFunction += " objXHttp.open('GET',strUrl, false); " + vbCrLf
                strFunction += " objXHttp.send();           " + vbCrLf
                strFunction += " 	}  " + vbCrLf
                strFunction += "  	else  {" + vbCrLf
                strFunction += " objXHttp = new XMLHttpRequest();  " + vbCrLf
                strFunction += " objXHttp.onreadystatechange = HandlerOnReadyState(); " + vbCrLf
                strFunction += "  objXHttp.open('GET',strUrl, false);" + vbCrLf
                strFunction += " objXHttp.send(null);  }" + vbCrLf
                strFunction += "if (blnFlag == true) " + vbCrLf
                'Added by ManishK on 28th Feb 2006 as Leave Balence combo will get enabled if alert comes
                strFunction += "{objBalance.disabled = true;"
                'End of Added by ManishK on 28th Feb 2006 as Leave Balence combo will get enabled if alert comes
                strFunction += " return;}" + vbCrLf
                '***** End addition by SandipL on 24 Nov 2005

                Args.ToBeInsertedInFunction = strFunction
                'ReInitialize the Resources
                m_objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                m_objTemplate.Dispose()
            End If
            'End modified by HarshK on 08 Mar 2006
        End If
        'addition end

    End Sub

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cMyLeavePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)
        'added by HarshK on 08 Mar 2006
        Dim strLeaveID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("LeaveID_PK"), "0")

        'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4192
        'Added by SandipL on 15 May 2006 For WhizEnggSP6 IssueID 3738
        strLeaveID = Gen.PrimaryKeyValue
        If strLeaveID = "" Then
            strLeaveID = "0"
        End If
        'End addition by SandipL on 15 May 2006
        'End Integration
        Dim strLeaveStatus As String = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select Leavestatus from d_tbl_PM_EmployeeLeaveDetails WHERE LeaveID=" & strLeaveID, MyBase.UseSQL), ""))
        strLeaveStatus = CommonFunctions.General.CheckIsNothing(strLeaveStatus, "")
        If strLeaveStatus.Trim <> "" Then
            Args.RightPageCaption = " Status : " & strLeaveStatus
        End If

        'Added and Modified By VarunA on 7-May-2007 Cleanup activity for leave workflow.
        'Purpose : To Show Approver name in header
        Dim drReportTo As IDataReader
        Dim strReportingTo As String = ""
        drReportTo = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ReportingTo " + WhizGlobal.UserID.ToString(), MyBase.UseSQL)
        If drReportTo.Read Then
            strReportingTo = CommonFunction.Data.CheckIsDBNull(drReportTo("ReportingToName")).ToString
        End If
        CommonFunctions.Data.DisposeDataReader(drReportTo)
        Args.RightPageCaption = " Leave Approver : " & strReportingTo
        'End By VarunA on 7-May-2007 

        'End 'added by HarshK on 08 Mar 2006
    End Sub
    Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)
        'Added by SuchitraP on 19 April 2007 for IssueID-11398
        'Purpose:Legend was not seen previously (* Mandatory)
        Args.Legend = "Mandatory"
        'End of addition by SuchitraP on 19 April 2007
    End Sub


End Class

Public Class cMyLeavePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    'Added By VarunA on 18-Sep-2007 Whizible 7.1 Development & Release
    'Purpose : To check the access for an control which is a nondatabase (LeaveBalance) at the time of View Mode
    Private m_objViewOnlyAccessChk As WebPage.Templates.AccessRights
    'End By VarunA on 18-Sep-2007

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
        'Get the Access Rights 
        'Added By VarunA on 18-Sep-2007 Whizible 7.1 Development & Release
        'Purpose : To check the access for an control which is a nondatabase (LeaveBalance) at the time of View Mode
        m_objViewOnlyAccessChk = New WebPage.Templates.AccessRights
        m_objViewOnlyAccessChk.GetAccess(WhizGlobal)
        'End By VarunA on 18-Sep-2007
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        If WhizGlobal.ParentTagID = 0 Then
            'Added By Usha Pandit On 12.05.2020 For validation of already applied leaves for specific date range
            If Args.ControlName.ToUpper = "NONDATABASE6" Then
                Args.AdditionalInformation = "usp_Get_ReportingEmployeeLeaveDates " & HttpContext.Current.Session("intUserID")
            End If
            'End Of Added By Usha Pandit On 12.05.2020 For validation of already applied leaves for specific date range
            'disable the leave balance combo box
            If Args.ControlName.ToUpper = "NONDATABASE1" Then

                If Args.IsEditMode = True Then
                    'Cancel = True
                    'Integrated By Manishk on 02 Jan 2006
                    'Modified by SachinR    on 30 Nov 2005
                    Dim intIndex As Integer
                    intIndex = 0
                    If IsDBNull(drControls("leavetypeid")) = False Then
                        intIndex = CType(drControls("leavetypeid"), Integer)
                    End If
                    '  Dim intIndex As Integer = CType(drControls("leavetypeid"), Integer)
                    'end modification   on 30 Nov 2005
                    'End of Integrated By Manishk on 02 Jan 2006

                    ''Added by ManishK on 15th Feb 2006 For SP WFH 
                    Dim LeaveOrWFH As String = CType(CommonFunctions.Data.CheckIsDBNull(drControls("LeaveOrWFH"), ""), String)
                    'If LeaveOrWFH.ToUpper = "W" Then
                    '    Args.IgnoreActualValue = True
                    '    Args.DropDownEditSQL = "SELECT ''"
                    'Else
                    ''End Of Added by ManishK on 15th Feb 2006 For SP WFH 
                    Args.IsEditMode = True
                    Args.IgnoreActualValue = True
                    Args.DropDownEditSQL = "usp_Sel_tbl_PM_EmployeeLeaveMaster " + WhizGlobal.UserID.ToString + "," + intIndex.ToString
                    'Args.StoredProcedureName = "usp_Sel_tbl_PM_EmployeeLeaveMaster " + WhizGlobal.UserID.ToString + "," + intIndex.ToString
                    'Args.DefaultValue = "usp_Sel_tbl_PM_EmployeeLeaveMaster " + WhizGlobal.UserID.ToString + "," + intIndex.ToString
                    'Args.NewValue = "usp_Sel_tbl_PM_EmployeeLeaveMaster " + WhizGlobal.UserID.ToString + "," + intIndex.ToString
                    'End If
                End If
                Args.Editable = False

            ElseIf Args.ControlName.ToUpper = "APPROVER" Then
                Cancel = True
                ''''''Added by Manishk on 28th Feb 2006 For SP 6 WFH issues
            ElseIf Args.ControlName.ToUpper = "LEAVETYPEID" Then
                If Args.IsEditMode = True Then
                    Dim LeaveOrWFH As String = CType(CommonFunctions.Data.CheckIsDBNull(drControls("LeaveOrWFH"), ""), String)
                    If LeaveOrWFH.ToUpper = "W" Then
                        'Comment By VarunA on 18-May-2007 Cleanup Activity for leave workflow
                        'Purpose : In edit mode the leave type was disable
                        'Args.Editable = False
                        'End By VarunA on 18-May-2007
                    End If
                End If

            End If


            '''''End of addition by Manishk 
            'Added By VarunA on 18-Sep-2007 Whizible 7.1 Development & Release
            'Purpose : To check the access for an control which is a nondatabase (LeaveBalance) at the time of View Mode
            If Args.IsEditMode = True AndAlso Args.PrimaryKeyValue <> "" AndAlso Args.ControlName.ToUpper = "NONDATABASE1" Then
                If m_objViewOnlyAccessChk.Add = False AndAlso m_objViewOnlyAccessChk.Edit = False Then
                    'User Has view only access
                    Args.IgnoreActualValue = True
                    Dim strLeaveBalance As String = ""
                    Dim blnUseSQL As Boolean = True

                    If drControls("LeaveOrWFH").ToString = "L" Then
                        blnUseSQL = CBool(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), "True"))
                        ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion
                        '  strLeaveBalance = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT LeaveBalance FROM tbl_PM_EmployeeLeaveMaster WHERE EmployeeID=" & drControls("EmployeeID").ToString & " AND LeaveTypeID=" & drControls("LeaveTypeID").ToString, blnUseSQL), ""))
                        strLeaveBalance = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_EmployeeLeaveMaster_LeaveBalance " & drControls("EmployeeID").ToString & "," & drControls("LeaveTypeID").ToString, blnUseSQL), ""))
                        '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
                        Args.NewValue = strLeaveBalance
                    Else
                        Args.NewValue = "-"
                    End If
                End If
            End If

            'Purpose : To show HalfDay data at the time of View Mode
            If Args.IsEditMode = True AndAlso Args.PrimaryKeyValue <> "" AndAlso Args.ControlName.ToUpper = "HALFDAY" Then
                If m_objViewOnlyAccessChk.Add = False AndAlso m_objViewOnlyAccessChk.Edit = False Then
                    'User Has view only access
                    Args.IgnoreActualValue = True
                    Args.ControlTypeID = CommonFunctions.Constants.CONTROL_TYPE_TEXT_BOX
                    Dim intHalfDay As Integer
                    Dim blnUseSQL As Boolean = True

                    blnUseSQL = CBool(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), "True"))
                    ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion
                    'intHalfDay = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT HalfDay FROM tbl_PM_EmployeeLeaveDetails WHERE LeaveID=" & drControls("LeaveID").ToString, blnUseSQL), ""))
                    intHalfDay = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_EmployeeLeaveDetails_HalfDay " & drControls("LeaveID").ToString, blnUseSQL), ""))
                    '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
                    If intHalfDay = 0 Then
                        Args.NewValue = "No"
                    Else
                        Args.NewValue = "Yes"
                    End If
                End If
            End If

            'Purpose : To have leave type in View Mode.
            If Args.IsEditMode = True AndAlso Args.PrimaryKeyValue <> "" AndAlso Args.ControlName.ToUpper = "LEAVETYPEID" Then
                If m_objViewOnlyAccessChk.Add = False AndAlso m_objViewOnlyAccessChk.Edit = False Then
                    'User Has view only access
                    Args.IgnoreActualValue = True
                    Dim strLeaveType As String = ""
                    Dim blnUseSQL As Boolean = True
                    Args.ControlTypeID = CommonFunctions.Constants.CONTROL_TYPE_TEXT_BOX

                    If drControls("LeaveOrWFH").ToString = "L" Then
                        blnUseSQL = CBool(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), "True"))
                        strLeaveType = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT LeaveType FROM tbl_PM_LeaveTypeMaster WHERE LeaveTypeID=" & drControls("LeaveTypeID").ToString, blnUseSQL), ""))
                        Args.NewValue = strLeaveType
                    Else
                        Args.NewValue = "Leave type is not applicable. Work from home is selected."
                    End If
                End If
            End If
            'End By VarunA on 18-Sep-2007

        Else

        End If

    End Sub

    Protected Overrides Sub After_PlotControl(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")
        If WhizGlobal.ParentTagID = 0 Then
            'Master Tag
            '    'Added By JayavantK on 12-Oct-2004
            If Args.ControlName.ToUpper = "APPROVER" Then
                Dim strQuery As String = ""
                Dim strReportingTo As String = ""
                strQuery = "SELECT E2.EmployeeName AS ReportingToName FROM tbl_PM_Employee E1"
                strQuery = strQuery + " INNER JOIN tbl_PM_Employee E2 ON E2.EmployeeID = E1.ReportingTo"
                strQuery = strQuery + " WHERE E1.EmployeeID = " + WhizGlobal.UserID.ToString()
                strReportingTo = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                InsertAfterControl = strReportingTo
            End If
            '    'End Addition
            '    'Added by DipaliS 15 Oct 2004
        Else
            'Sub Tag
        End If
    End Sub

    Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")
        If WhizGlobal.ParentTagID = 0 Then
            'Added by NileshD 8 April 2004
            'Hide the lable of leave balance in edit mode.
            'do not shoe the caption in edit mode.
            If Args.ControlName.ToUpper = "NONDATABASE1" Then
                If Args.IsEditMode = True Then
                    'Cancel = True
                End If
            End If
            'Addition End
        Else
        End If
    End Sub
End Class



