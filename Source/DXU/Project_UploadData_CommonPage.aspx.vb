Imports CommonEngines.General.cEventHandlers
Public Class Project_UploadData_CommonPage
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
        MyBase.strListPage = "Project_UploadData_CommonList.aspx"
        MyBase.strFormPage = "Project_UploadData_CommonPage.aspx"
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cProject_UploadData_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cProject_UploadData_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cProject_UploadData_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cProject_UploadData_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function


    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

        Dim strFunctionName As String = Args.ClientSideFunctionName.ToUpper
        'Added By Syamantak Chavan on 07-Oct-2011 for whizible sem 10.0
        Dim Flag As String
        If Not HttpContext.Current.Request.QueryString("Flag") Is Nothing Then
            Flag = HttpContext.Current.Request.QueryString("Flag").ToString
        Else
            Flag = ""
        End If
        If Flag = "UserStory" Then
            If Args.LinkName.ToUpper = "ADVANCED TEMPLATE" Then
                Cancel = True
            End If
        End If
        'End Added By Syamantak Chavan on 07-Oct-2011 for whizible sem 10.0
        If strFunctionName = "TEMPLATE_CHANGE" Then
            If CType(WhizGlobal.FromWhere, String) = "SM" Then
                Args.ToBeInsertedInFunction = "return;"
            End If
        End If
        If strFunctionName = "SAVE_ONCLICK" Or strFunctionName = "SAVEADD_ONCLICK" Then
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
        If strFunctionName = "DOWNLOAD" Or strFunctionName = "DOWNLOADXML" Or _
            strFunctionName = "VIEWREJECTEDFILE" Then
            If Args.PrimaryKeyValue = "" Then
                Cancel = True
            End If
        End If
    End Sub

    'Protected Overrides Function InitSubTagCPSQL(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonPage.cSubTagCPSQL
    '    Return New cProject_UploadData_CommonPageSubTagCLSQL(m_objSubTagGlobal)
    'End Function

    Protected Overrides Function InitSubTagCLSQL(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cProject_UploadData_CommonPageSubTagCLSQL(m_objSubTagGlobal)
    End Function



    Protected Overrides Sub Before_ExecutingAction(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)

        Dim strFunctionName As String = Args.ClientSideFunctionName.ToUpper
        Dim strProjectID As String = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), ""), String)
        'Commented and Modified By JyotiG
        'Start_JG_11995_09-Apr-2007
        Dim strTemplateID As String '= ControlsHashTable("TemplateID").ToString
        Dim strTemplateSql As String

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strTemplateSql = "SELECT TemplateID from tbl_DXU_UploadRequestsQueue WHERE RequestID = " + CType(HttpContext.Current.Request("RequestID_PK"), String)
        strTemplateSql = "usp_se_tbl_DXU_UploadRequestsQueue_TemplateID " + CType(HttpContext.Current.Request("RequestID_PK"), String)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        strTemplateID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strTemplateSql, MyBase.UseSQL), "")
        'End_JG_11995_09-Apr-2007
        If strFunctionName = "DOWNLOADXML" Then

            ' Dim strProjectID As String = ControlsHashTable("ProjectID").ToString
            Dim strCreatedFileName As String

            Dim objUpload As New DataExchangeLib.XML2Excel
            With objUpload
                .ConnectionString = CommonFunction.General.GetConnectionString
                .ProjectID = strProjectID
                .ExistingTemplateFilePath = HttpContext.Current.Server.MapPath("../../Attachments/DXU/Templates")
                .CreatedTemplateFilePath = HttpContext.Current.Server.MapPath("../../Attachments/DXU/Templates")
                '.RequestID = HttpContext.Current.Request.Form("RequestID_PK") 'this is nothing 
                'as Current.Request.Form is attachments form, get value from Request.Form("foreignkeyvalue")
                .TemplateID = CType(strTemplateID, Integer)
                'strCreatedFileName = .CreateTemplate()
                strCreatedFileName = .CreateTemplateForXL2K()
            End With
            Response.Write("<script>window.open('../General/ViewAttachment.aspx?FromWhere=DXU%5CTemplates%5C&FileName=" + strCreatedFileName + "', '_popup')</script>")
            'Args.CustomLink = "../General/ViewAttachment.aspx?FromWhere=DXU%5CTemplates%5C&FileName=" + strCreatedFileName + ");"
        End If

        If strFunctionName = "DOWNLOAD" Then
            Dim strCreatedFileName As String
            Dim strSQL As String
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'strSQL = "Select SystemFileName from tbl_DXU_Attachments where TemplateID = " & strTemplateID
            strSQL = "usp_sel_tbl_DXU_Attachments_SystemFileName " & strTemplateID
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            strCreatedFileName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), "")
            If strCreatedFileName <> "" Then
                Response.Write("<script>window.open('../General/ViewAttachment.aspx?FromWhere=DXU&FileName=" + strCreatedFileName + "', '_popup')</script>")
            End If
            'Args.CustomLink = "../General/ViewAttachment.aspx?FromWhere=DXU%5CTemplates%5C&FileName=" + strCreatedFileName + ");"
        End If

        If strFunctionName = "VIEWREJECTEDFILE" Then

            Dim strSQL As String
            Dim strRejectedFileName As String
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'strSQL = "SELECT RejectedRecordsFilePath from tbl_DXU_UploadRequestsQueue WHERE RejectedRecordsFilePath IS NOT NULL AND RequestID = " + CType(HttpContext.Current.Request("RequestID_PK"), String)
            strSQL = "usp_sel_tbl_DXU_UploadRequestsQueue_RejectedRecordsFilePath " + CType(HttpContext.Current.Request("RequestID_PK"), String)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            strRejectedFileName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), "")
            If strRejectedFileName <> "" Then
                Response.Write("<script> window.open ('../General/ViewAttachment.aspx?FromWhere=DXU%5CRejectedFiles%5C&FileName=" + strRejectedFileName + "', '_popup')</script>")
            End If

        End If


    End Sub

    Protected Overrides Sub BeforePlotTAB_SubTag(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_Tab, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Cancel = True
    End Sub
End Class

Public Class cProject_UploadData_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cProject_UploadData_CommonPageSubTagCLSQL
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
            .RequestID = intRequestID
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
Public Class cProject_UploadData_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        GetPageSpecificFilters &= " AND ProjectID is Not NULL "
        GetPageSpecificFilters &= "  AND ProjectID=" & HttpContext.Current.Session("intProjectID").ToString
        If objGlobal.RoleLevel <> 1 Then
            GetPageSpecificFilters &= " And EmployeeID = " & CStr(objGlobal.UserID)
        End If
    End Function
End Class
Public Class cProject_UploadData_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")
        'Select Case Args.ControlName.ToUpper
        '    'Case "PROJECTID"
        '    '    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere")).ToString = "SM" Then
        '    '        Cancel = True
        '    '    End If

        'End Select
    End Sub
    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        Dim strProjectID As String = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), ""), String)
        Dim Flag As String
        If Not HttpContext.Current.Request.QueryString("Flag") Is Nothing Then
            Flag = HttpContext.Current.Request.QueryString("Flag").ToString
        Else
            Flag = ""
        End If
        Select Case Args.ControlName.ToUpper

            Case "TEMPLATEID"

                'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FocusOn")).ToString <> "" And Args.IsEditMode Then
                '    CommonFunction.General.WriteHTML("<script language=javascript>")
                '    CommonFunction.General.WriteHTML("window.location = document.referrer ;document.refresh")
                '    CommonFunction.General.WriteHTML("</script>")
                'End If
                'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere")).ToString = "SM" Then
                'If CommonFunction.General.CheckIsNothing(WhizGlobal.FromWhere).ToString = "SM" Then
                '    Args.AdditionalInformation = "SELECT Distinct (tbl_DXU_TemplateMaster.TemplateID) , tbl_DXU_TemplateMaster.TemplateName FROM tbl_DXU_TemplateMaster " & _
                '                   " INNER JOIN Tbl_DXU_TemplateDetails on Tbl_DXU_TemplateDetails.TemplateID = tbl_DXU_TemplateMaster.TemplateID " & _
                '                   "INNER JOIN tbl_DXU_EntityMaster on tbl_DXU_EntityMaster.EntityID = tbl_DXU_TemplateMaster.EntityID " & _
                '                    " WHERE Tbl_DXU_TemplateDetails.ActualFieldID Is Not Null and tbl_DXU_EntityMaster.ProjectRequired = 0 ORDER BY TemplateName"
                '    Args.DropDownEditSQL = Args.AdditionalInformation
                'End If
                'Case "PROJECTID"
                '    'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere")).ToString = "SM" Then
                '    If CommonFunction.General.CheckIsNothing(WhizGlobal.FromWhere).ToString = "SM" Then
                '        Cancel = True
                '    End If
        End Select
        'Added by Syamantak Chavan on 09 August 2011 for WhizibleSEM v10.0 To add Excel Upload For Agile Methodology
        'Flag = HttpContext.Current.Request.QueryString("Flag").ToString
        If Args.ControlCaption = "Template to be used" Then
            Dim m_intFlag As Integer
            m_intFlag = CInt(CInt(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + strProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))))
            If Flag = "UserStory" Then
                If m_intFlag = 1 Then
                    Args.AdditionalInformation = "SELECT Distinct (T.TemplateID),T.TemplateName FROM tbl_DXU_TemplateMaster T INNER JOIN Tbl_DXU_TemplateDetails  D on D.TemplateID = T.TemplateID INNER JOIN tbl_DXU_EntityMaster E on E.EntityID = T.EntityID WHERE(D.ActualFieldID Is Not Null) and E.ProjectRequired = 1 AND T.TemplateName  Not like '%Test%Case%' AND ScrumEntityType=3 ORDER BY TemplateName"
                    Args.DropDownEditSQL = Args.AdditionalInformation
                Else
                    Args.AdditionalInformation = "SELECT Distinct (T.TemplateID),T.TemplateName FROM tbl_DXU_TemplateMaster T INNER JOIN Tbl_DXU_TemplateDetails  D on D.TemplateID = T.TemplateID INNER JOIN tbl_DXU_EntityMaster E on E.EntityID = T.EntityID WHERE(D.ActualFieldID Is Not Null) and E.ProjectRequired = 1 AND T.TemplateName  Not like '%Test%Case%' AND T.TemplateID NOT IN (select TemplateID from Tbl_DXU_Templatemaster where ScrumEntityType is not null) ORDER BY TemplateName"
                    Args.DropDownEditSQL = Args.AdditionalInformation
                End If
            Else
                If m_intFlag = 1 Then
                    Args.AdditionalInformation = "SELECT Distinct (T.TemplateID),T.TemplateName FROM tbl_DXU_TemplateMaster T INNER JOIN Tbl_DXU_TemplateDetails  D on D.TemplateID = T.TemplateID INNER JOIN tbl_DXU_EntityMaster E on E.EntityID = T.EntityID WHERE(D.ActualFieldID Is Not Null) and E.ProjectRequired = 1 AND T.TemplateName  IN ('Issue_Upload_With_Customfield','Product based Issue Upload Template','Scrum Tasks Creation Template') ORDER BY TemplateName"
                    Args.DropDownEditSQL = Args.AdditionalInformation
                Else
                    Args.AdditionalInformation = "SELECT Distinct (T.TemplateID),T.TemplateName FROM tbl_DXU_TemplateMaster T INNER JOIN Tbl_DXU_TemplateDetails  D on D.TemplateID = T.TemplateID INNER JOIN tbl_DXU_EntityMaster E on E.EntityID = T.EntityID WHERE(D.ActualFieldID Is Not Null) and E.ProjectRequired = 1 AND T.TemplateName  IN ('Issue_Upload_With_Customfield','Product based Issue Upload Template','Tasks Creation Template') AND T.TemplateID NOT IN (select TemplateID from Tbl_DXU_Templatemaster where ScrumEntityType is not null) ORDER BY TemplateName"
                    Args.DropDownEditSQL = Args.AdditionalInformation
                End If
            End If
        End If
            'End of by Syamantak Chavan on 09 August 2011 for WhizibleSEM v10.0 (Agile Methodology)
            If Not HttpContext.Current.Request.QueryString("IsComboChange") Is Nothing Then
                If Args.ControlName = "ProjectID" Then
                    'Args.IgnoreActualValue = True
                    Args.AdditionalInformation = "usp_Sel_Project_For_Upload_Data   " & CType(HttpContext.Current.Session("intUserID"), String) & "," & CType(HttpContext.Current.Request.Form("TemplateID"), String)
                    Args.DropDownEditSQL = Args.AdditionalInformation
                End If
                If Not HttpContext.Current.Request.Form(Args.ControlName) Is Nothing And Args.ControlName <> "ProjectID" Then
                    Args.IgnoreActualValue = True
                    Args.NewValue = HttpContext.Current.Request.Form(Args.ControlName)
                End If
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
        '    Dim strDescription As String = HttpContext.Current.Request.Form("RequestDescription")
        '    strDescription = Replace(Replace(HttpContext.Current.Request.Form("RequestDescription"), """", "\"""), Chr(13), "\n")

        '    CommonFunction.General.WriteHTML("<script language=Javascript>")
        '    CommonFunction.General.WriteHTML("var objRequestDescription = GetObjectReference('frmCommonPage', 'RequestDescription');")
        '    CommonFunction.General.WriteHTML("if(objRequestDescription!=null) objRequestDescription.value = """ + strDescription + """;")
        '    CommonFunction.General.WriteHTML("</script>")
        'End If
    End Sub

End Class

