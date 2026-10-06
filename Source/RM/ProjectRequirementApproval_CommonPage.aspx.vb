Imports CommonEngines.General.cEventHandlers
Public Class cProjectRequirementApproval_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cProjectRequirementApproval_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

End Class
Public Class cProjectRequirementApproval_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class

Public Class cProjectRequirementApproval_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Private m_strProjectID As String
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
        If HttpContext.Current.Request.QueryString("ProjectID") <> "" Then
            m_strProjectID = HttpContext.Current.Request.QueryString("ProjectID")
        Else
            m_strProjectID = HttpContext.Current.Request.Form("hidProjectID")
        End If
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        Dim strUserName As String
        Dim strSQL As String
        Dim strProjectRequirementID As String
        Dim drRev As IDataReader
        Dim drcheck As IDataReader
        Dim strStartDate As String
        Dim strEndDate As String
        Dim intEfforts As Integer
        Dim intCost As Integer
        Dim strClientDate As String
        Dim drQuestion As IDataReader

        'Added by PrashantD for removing session projectID placeholder to queryString ProjectID



        If Args.AdditionalInformation <> "" Then
            Args.AdditionalInformation = Args.AdditionalInformation.Replace("<PROJECT_ID>", m_strProjectID)
        End If

        If Args.AddNewRelativeSource <> "" Then
            Args.AddNewRelativeSource = Args.AddNewRelativeSource.Replace("<PROJECT_ID>", m_strProjectID)
        End If

        If Args.DropDownEditSQL <> "" Then
            Args.DropDownEditSQL = Args.DropDownEditSQL.Replace("<PROJECT_ID>", m_strProjectID)
        End If

        If Args.EditRelativeSource <> "" Then
            Args.EditRelativeSource = Args.EditRelativeSource.Replace("<PROJECT_ID>", m_strProjectID)
        End If



        'End of addition by PrashantD

        strProjectRequirementID = HttpContext.Current.Request.QueryString("ProjectRequirementID")
        strUserName = CStr(HttpContext.Current.Session("strUserName"))
        If Args.ControlName.ToUpper = "REASONFORREVISION" Then

            ''Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
            'strSQL = "Select PlannedStartDate,PlannedEndDate ,EstimatedEfforts,EstimatedCost,EndDateByClient,ApprovedStartDate,ApprovedEndDate,ApprovedEfforts,ApprovedCost,ApprovedClientEndDate From tbl_RM_ProjectRequirements where ProjectRequirementID=" + strProjectRequirementID
            strSQL = "usp_sel_tbl_RM_ProjectRequirements_PlannedStartDate " + strProjectRequirementID
            'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query

            drRev = CommonFunctions.Data.GetDataReader(strSQL, True)

            ''Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
            'strSQL = "Select RevisionReasonId From tbl_RM_ReqRevisionReason where ProjectRequirementID=" + strProjectRequirementID
            strSQL = "usp_sel_tbl_RM_ReqRevisionReason_RevisionReasonId " + strProjectRequirementID
            'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
            drcheck = CommonFunctions.Data.GetDataReader(strSQL, True)

            ''Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
            'strSQL = "Select QuestionID,Question From tbl_RM_ApprovalQuestions "
            strSQL = "usp_sel_tbl_RM_ApprovalQuestions_QuestionID "
            'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
            drQuestion = CommonFunctions.Data.GetDataReader(strSQL, True)


            Args.IgnoreActualValue = True
            Args.NewValue = "Following are the details: " + vbCrLf

            Args.NewValue += "Sender: " + strUserName + vbCrLf
            Args.NewValue += "Date: " + CStr(Now.Date) + vbCrLf + vbCrLf
            If drRev.Read Then
                If drcheck.Read Then
                    If CInt(drcheck.Item("RevisionReasonID")) <> 0 Then
                        Args.NewValue += "Revised Start Date: " + CStr(drRev.Item("PlannedStartDate")) + vbCrLf
                        Args.NewValue += "Revised End Date: " + CStr(drRev.Item("PlannedEndDate")) + vbCrLf
                        Args.NewValue += "Revised Efforts: " + CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("EstimatedEfforts"))) + vbCrLf
                        Args.NewValue += "Revised Cost: " + CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("EstimatedCost"))) + vbCrLf
                        Args.NewValue += "Revised Client End Date: " + CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("EndDateByClient"))) + vbCrLf + vbCrLf

                        Args.NewValue += "===============================================" + vbCrLf
                        Args.NewValue += "Before(Revision)" + vbCrLf
                        If CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("ApprovedStartDate"))) <> "" Then
                            Args.NewValue += "Start Date: " + CStr(CDate(drRev.Item("ApprovedStartDate")).Date) + vbCrLf
                        Else
                            Args.NewValue += "Start Date: " + CStr(CDate(drRev.Item("PlannedStartDate")).Date) + vbCrLf
                        End If

                        If CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("ApprovedEndDate"))) <> "" Then
                            Args.NewValue += "End Date: " + CStr(CDate(drRev.Item("ApprovedEndDate")).Date) + vbCrLf
                        Else
                            Args.NewValue += "End Date: " + CStr(CDate(drRev.Item("PlannedEndDate")).Date) + vbCrLf
                        End If

                        If CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("ApprovedEfforts"), "")) <> "" Then
                            Args.NewValue += "Efforts: " + CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("ApprovedEfforts"))) + vbCrLf
                        Else
                            Args.NewValue += "Efforts: " + CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("EstimatedEfforts"))) + vbCrLf
                        End If

                        If CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("ApprovedCost"), "")) <> "" Then
                            Args.NewValue += "Cost: " + CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("ApprovedCost"))) + vbCrLf
                        Else
                            Args.NewValue += "Cost: " + CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("EstimatedCost"))) + vbCrLf
                        End If

                        If CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("ApprovedClientEndDate"), "")) <> "" Then
                            Args.NewValue += "Client End Date: " + CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("ApprovedClientEndDate"))) + vbCrLf + vbCrLf
                        Else
                            Args.NewValue += "Client End Date: " + CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("EndDateByClient"))) + vbCrLf + vbCrLf
                        End If
                        Args.NewValue += "Following questions needs to be considered" + vbCrLf + vbCrLf
                        While drQuestion.Read
                            Args.NewValue += CStr(drQuestion.Item("QuestionID")) + ") " + CStr(drQuestion.Item("Question")) + vbCrLf + vbCrLf
                        End While
                    End If
                Else
                    ' If CInt(drcheck.Item("RevisionReasonID")) = 0 Then
                    Args.NewValue += "Planned Details : " + vbCrLf
                    Args.NewValue += "Start Date: " + CStr(CDate(drRev.Item("PlannedStartDate"))) + vbCrLf
                    Args.NewValue += "End Date: " + CStr(CDate(drRev.Item("PlannedEndDate")).Date) + vbCrLf
                    If CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("EstimatedEfforts"))) <> "" Then
                        Args.NewValue += "Efforts: " + CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("EstimatedEfforts"))) + vbCrLf
                    End If
                    If CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("EstimatedCost"))) <> "" Then
                        Args.NewValue += "Cost: " + CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("EstimatedCost"))) + vbCrLf
                    End If
                    If CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("EndDateByClient"))) <> "" Then
                        Args.NewValue += "Client End Date: " + CStr(CommonFunctions.General.CheckIsNothing(drRev.Item("EndDateByClient"))) + vbCrLf + vbCrLf
                    End If
                    ' End If

                End If



            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drRev)

        CommonFunctions.Data.DisposeDataReader(drcheck)



    End Sub
End Class


Public Class ProjectRequirementApproval_CommonPage
    Inherits CommonPage
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
#Region "Global Variables"
    Protected m_strProjectRequirementID As String
#End Region
    Private m_strProjectID As String
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "ProjectRequirementApproval_CommonList.aspx"
        MyBase.strFormPage = "ProjectRequirementApproval_CommonPage.aspx"
        If HttpContext.Current.Request.QueryString("ProjectID") <> "" Then
            m_strProjectID = HttpContext.Current.Request.QueryString("ProjectID")
        Else
            m_strProjectID = HttpContext.Current.Request.Form("hidProjectID")
        End If

        MyBase.Page_Load(sender, e)



    End Sub
    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        Dim StrSQl As String
        Dim intProjectRequirementId As Integer
        Dim drReqApprover As IDataReader
        Dim intRevisionReasonId As Integer

        intProjectRequirementId = CType(HttpContext.Current.Request.QueryString("ProjectRequirementId"), Integer)

        CommonFunction.General.WriteHTML("<Script language=javascript>")
        CommonFunction.General.WriteHTML("window.open('../RM/RM_SendEmail.aspx?MessageID=475&ProjectID=" + m_strProjectID + "&ProjectRequirementId=" + intProjectRequirementId.ToString + "&RevisionReasonID=" + PrimaryKey.ToString + "','','resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")

        CommonFunction.General.WriteHTML("if (window.opener)")
        CommonFunction.General.WriteHTML("if (window.opener.opener)")
        CommonFunction.General.WriteHTML("{ ")
        CommonFunction.General.WriteHTML("window.opener.opener.document.forms[0].action=""../RM/RM_Tracking.aspx"";")
        CommonFunction.General.WriteHTML("window.opener.opener.document.forms[0].submit();")

        CommonFunction.General.WriteHTML("}")
        ''''''CommonFunction.General.WriteHTML("window.close();")
        CommonFunction.General.WriteHTML("</Script>")
    End Function
    Public Overrides Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String
        Dim intProjectRequirementId As Integer
        Dim drApprover As IDataReader
        Dim strSql As String
        Dim strScript As String
        Dim strRevisionReasonId As String

        intProjectRequirementId = CType(HttpContext.Current.Request.QueryString("ProjectRequirementId"), Integer)
        'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        'strSql = "Select max(RevisionReasonId) RevisionReasonId from tbl_RM_ReqRevisionReason where ProjectRequirementId=" + CStr(intProjectRequirementId)
        strSql = "usp_sel_tbl_RM_ReqRevisionReason_RevisionReasonIdMax " + CStr(intProjectRequirementId)
        'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        'commeneted by PrashantD on 6 Feb 2006
        'drApprover = CommonFunctions.Data.GetDataReader(strSql, True)
        'end of comment by PrashantD on 6 Feb 2006
        drApprover = CommonFunction.Data.GetDataReader(strSql, MyBase.UseSQL)
        If drApprover.Read() Then
            strRevisionReasonId = CStr(CommonFunctions.Data.CheckIsDBNull(drApprover("RevisionReasonId"), "0"))
            'Added by PrashantD on 6 Feb 2006
        Else
            strRevisionReasonId = "0"
            'End of addition by PrashantD on 6 Feb 2006
        End If
        CommonFunctions.Data.DisposeDataReader(drApprover)
        strSql = "usp_RM_Upd_tbl_RM_Upd_SentForApproval " + CStr(intProjectRequirementId) + "," + strRevisionReasonId
        drApprover = CommonFunctions.Data.GetDataReader(strSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        CommonFunction.Data.DisposeDataReader(drApprover)


    End Function
    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls

        CommonFunction.General.WriteHTML("<input type=hidden name=hidProjectID id=hidProjectID value=" + m_strProjectID + ">")

        'Put user code to initialize the page here
        Return New cProjectRequirementApproval_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    'Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
    '    Return New cproject PlotControls(MyBase.m_objGlobal)
    'End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cProjectRequirementApproval_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cProjectRequirementApproval_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagCLSQL(ByVal WhizGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cProjectRequirementApproval_CommonPageSubTagCLSQL(WhizGlobal)
    End Function

    Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        Dim strScript As String
        Dim strSenderComment As String
        strSenderComment = CType(HttpContext.Current.Request.Form("ReasonForRevision"), String)
        Dim intProjectRequirementId As Integer

        intProjectRequirementId = CType(HttpContext.Current.Request.QueryString("ProjectRequirementId"), Integer)

        If Request.QueryString("Operation") = "SAVE" Then
            strScript = " refreshParent('frmCommonPage','ProjectRequirements_CommonPage.aspx?','ProjectRequirements_CommonPage.aspx?Mode=SendMail&ProjectID=" + m_strProjectID + "&FromWhere=RM&MasterTagID=3714&ModeFrom=SENDFORAPPROVAL&ProjectRequirementId=" + intProjectRequirementId.ToString + "');"

            strScript += "window.close();"


            PageUIPreRender = strScript
            strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.ON_LOAD.ToString
        End If
    End Function
End Class
