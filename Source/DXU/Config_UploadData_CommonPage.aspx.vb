Imports CommonEngines.General.cEventHandlers
Public Class Config_UploadData_CommonPage
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

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "Config_UploadData_CommonList.aspx"
        MyBase.strFormPage = "Config_UploadData_CommonPage.aspx"

        MyBase.Page_Load(sender, e)



    End Sub

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cConfig_UploadData_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cConfig_UploadData_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cConfig_UploadData_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cConfig_UploadData_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ClientSideFunctionName.ToUpper = "TEMPLATE_CHANGE" Then
            'If CType(WhizGlobal.FromWhere, String) = "SM" Then
            Args.ToBeInsertedInFunction = "return;"
            'End If
        End If
        If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
            If (Args.PrimaryKeyValue <> "") Then
                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''Dim strSQL As String = "select * from tbl_DXU_UploadRequestsQueue where RequestID = " & Args.PrimaryKeyValue & " And isnull(Status,'T') not in ('C','B','A')"
                Dim strSQL As String = "usp_sel_tbl_DXU_UploadRequestsQueue_RequestID " & Args.PrimaryKeyValue
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
                Dim drStatus As IDataReader
                drStatus = CommonFunctions.Data.GetDataReader(strSQL, True)
                If drStatus.Read Then
                Else
                    Cancel = True
                End If
                CommonFunctions.Data.DisposeDataReader(drStatus)

            End If
        End If
    End Sub

    Protected Overrides Function InitSubTagCLSQL(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cConfig_UploadData_CommonPageSubTagCLSQL(m_objSubTagGlobal)
    End Function

    Protected Overrides Sub Before_ExecutingAction(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)
        'Added by ArchanaN on 31 Jan 2008
        Dim strTemplateID As String
        Dim strSQLTemplate As String
        Dim strSQL As String
        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQLTemplate = "SELECT TemplateID from tbl_DXU_UploadRequestsQueue WHERE RequestID = " + CType(HttpContext.Current.Request("RequestID"), String)
        strSQLTemplate = "usp_se_tbl_DXU_UploadRequestsQueue_TemplateID " + CType(HttpContext.Current.Request("RequestID"), String)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        strTemplateID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQLTemplate, MyBase.UseSQL), "")

        If Args.ClientSideFunctionName.ToUpper = "DOWNLOAD" Then
            Dim strCreatedFileName As String

            'strSQL = "Select SystemFileName from tbl_DXU_Attachments where TemplateID = " & strTemplateID
            strSQL = "usp_sel_tbl_DXU_Attachments_SystemFileName " & strTemplateID


            strCreatedFileName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), "")
            If strCreatedFileName <> "" Then
                Response.Write("<script>window.open('../General/ViewAttachment.aspx?FromWhere=DXU&FileName=" + strCreatedFileName + "', '_popup')</script>")
            End If
        End If

        If Args.ClientSideFunctionName.ToUpper = "VIEWREJECTEDFILE" Then
            Dim strRejectedFileName As String
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'strSQL = "SELECT RejectedRecordsFilePath from tbl_DXU_UploadRequestsQueue WHERE RejectedRecordsFilePath IS NOT NULL AND RequestID = " + CType(HttpContext.Current.Request("RequestID"), String)
            strSQL = "usp_sel_tbl_DXU_UploadRequestsQueue_RejectedRecordsFilePath " + CType(HttpContext.Current.Request("RequestID"), String)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            strRejectedFileName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), "")
            If strRejectedFileName <> "" Then
                Response.Write("<script> window.open ('../General/ViewAttachment.aspx?FromWhere=DXU%5CRejectedFiles%5C&FileName=" + strRejectedFileName + "', '_popup')</script>")
            End If
        End If
        'End of Added by ArchanaN on 31 Jan 2008
    End Sub
End Class

Public Class cConfig_UploadData_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cConfig_UploadData_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub After_SaveAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim objRequest As New DataExchangeLib.Request
        Dim intRequestID As Integer

        intRequestID = CType(HttpContext.Current.Request.Form("foreignkeyvalue"), Integer)
        With objRequest
            .ConnectionString = CommonFunction.General.GetConnectionString
            .LogFilePath = HttpContext.Current.Server.MapPath("../../Attachments/DXU/Logs")
            .RejectedRecordsFilePath = HttpContext.Current.Server.MapPath("../../Attachments/DXU/RejectedFiles")
            .UploadedFilePath = HttpContext.Current.Server.MapPath("../../Attachments/DXU/Requests")
            .SpecialRequestTemplateFilePath = HttpContext.Current.Server.MapPath("../../Attachments/DXU")
            '.RequestID = HttpContext.Current.Request.Form("RequestID_PK") 'this is nothing 
            'as Current.Request.Form is attachments form, get value from Request.Form("foreignkeyvalue")
            .RequestID = CType(HttpContext.Current.Request.Form("foreignkeyvalue"), Integer)
            .Post()
        End With
        objRequest = Nothing

        Dim strSQL As String
        Dim strStatus As String
        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'strSQL = "SELECT Status FROM tbl_DXU_UploadRequestsQueue  where RequestID = " + intRequestID.ToString
        strSQL = "usp_sel_tbl_DXU_UploadRequestsQueue_Status " + intRequestID.ToString
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
        strStatus = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, True), ""), String)
        If strStatus.ToUpper = "I" Then
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQL = "UPDATE Tbl_DXU_UploadrequestsQueue SET Status = 'A' where  RequestID =" + intRequestID.ToString
            strSQL = "usp_upd_Tbl_DXU_UploadrequestsQueue_Status " + intRequestID.ToString
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
        End If
    End Sub
End Class
Public Class cConfig_UploadData_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        'Modified by ArchanaN On 26 Feb 2008 To display all the requests only to the Role = 7
        ''If objGlobal.RoleLevel <> 1 Then
        ''    GetPageSpecificFilters &= " And EmployeeID = " & CStr(objGlobal.UserID)
        ''End If
        If CType(HttpContext.Current.Session("intPostID"), String) <> "7" Then
            If objGlobal.LoginType = "E" Then
                GetPageSpecificFilters &= " And EmployeeID = " & CStr(objGlobal.UserID)
            End If
        End If
    End Function
End Class
Public Class cConfig_UploadData_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub


    Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")
        Select Case Args.ControlName.ToUpper
            Case "PROJECTID"
                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere")).ToString = "SM" Then
                    Cancel = True
                End If

        End Select
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        Select Case Args.ControlName.ToUpper

            Case "TEMPLATEID"

                'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FocusOn")).ToString <> "" And Args.IsEditMode Then
                '    CommonFunction.General.WriteHTML("<script language=javascript>")
                '    CommonFunction.General.WriteHTML("window.location = document.referrer ;document.refresh")
                '    CommonFunction.General.WriteHTML("</script>")
                'End If
                'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere")).ToString = "SM" Then
                'If CommonFunction.General.CheckIsNothing(WhizGlobal.FromWhere).ToString = "SM" Then
                Args.AdditionalInformation = "SELECT Distinct (tbl_DXU_TemplateMaster.TemplateID) , tbl_DXU_TemplateMaster.TemplateName FROM tbl_DXU_TemplateMaster " & _
                               " INNER JOIN Tbl_DXU_TemplateDetails on Tbl_DXU_TemplateDetails.TemplateID = tbl_DXU_TemplateMaster.TemplateID " & _
                               "INNER JOIN tbl_DXU_EntityMaster on tbl_DXU_EntityMaster.EntityID = tbl_DXU_TemplateMaster.EntityID " & _
                                " WHERE Tbl_DXU_TemplateDetails.ActualFieldID Is Not Null and tbl_DXU_EntityMaster.ProjectRequired = 0 ORDER BY TemplateName"
                Args.DropDownEditSQL = Args.AdditionalInformation
                'End If
            Case "PROJECTID"
                'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere")).ToString = "SM" Then
                'If CommonFunction.General.CheckIsNothing(WhizGlobal.FromWhere).ToString = "SM" Then
                Cancel = True
                'End If

        End Select
        If Not HttpContext.Current.Request.Form(Args.ControlName) Is Nothing Then
            Args.IgnoreActualValue = True
            Args.NewValue = HttpContext.Current.Request.Form(Args.ControlName)
        End If
    End Sub

    Protected Overrides Sub After_PlotControl(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")
        'If Not HttpContext.Current.Request.Form("RequestName") Is Nothing And HttpContext.Current.Request.Form("RequestName") <> "" And (Args.ControlName = "RequestName") Then
        '    CommonFunction.General.WriteHTML("<script language=Javascript>")
        '    CommonFunction.General.WriteHTML("var objRequestName = GetObjectReference('frmCommonPage', 'RequestName');")
        '    CommonFunction.General.WriteHTML("if(objRequestName!=null) objRequestName.value = """ + Replace(HttpContext.Current.Request.Form("RequestName"), """", "\""") + """;")
        '    CommonFunction.General.WriteHTML("</script>")
        'End If
        'If Not HttpContext.Current.Request.Form("TemplateID") Is Nothing And HttpContext.Current.Request.Form("TemplateID") <> "" And (Args.ControlName = "TemplateID") Then
        '    CommonFunction.General.WriteHTML("<script language=Javascript>")
        '    CommonFunction.General.WriteHTML("var objTemplateID = GetObjectReference('frmCommonPage', 'TemplateID');")
        '    CommonFunction.General.WriteHTML("if(objTemplateID!=null) objTemplateID.value = " + HttpContext.Current.Request.Form("TemplateID") + ";")
        '    CommonFunction.General.WriteHTML("</script>")
        'End If
        'If Not HttpContext.Current.Request.Form("RequestDescription") Is Nothing And HttpContext.Current.Request.Form("RequestDescription") <> "" And (Args.ControlName = "RequestDescription") Then
        '    CommonFunction.General.WriteHTML("<script language=Javascript>")
        '    CommonFunction.General.WriteHTML("var objRequestDescription = GetObjectReference('frmCommonPage', 'RequestDescription');")
        '    CommonFunction.General.WriteHTML("if(objRequestDescription!=null) objRequestDescription.value = """ + Replace(HttpContext.Current.Request.Form("RequestDescription"), """", "\""") + """;")
        '    CommonFunction.General.WriteHTML("</script>")
        'End If
    End Sub
End Class


