Imports CommonEngines.General.cEventHandlers
Imports PbNIT
'Public Class cPM_ToolsSkill_CommonPageDataManagement
'    Inherits CommonEngine.CommonPage.cDataManagement
'    'Constructor
'    Public Sub New(ByVal Global As WebPages.Template.IGlobal)
'        Call MyBase.New(Global)
'    End Sub
'End Class
'Public Class cPM_ToolsSkill_CommonPageSubTagCLSQL
'    Inherits CommonEngine.CommonList.cSubTagCLSQL
'    Public Sub New(ByVal Global As WebPages.Template.IGlobal)
'        'Assign the Parameter values to the local variables
'        Call MyBase.New(Global)
'    End Sub

'    Protected Overrides Sub After_AttachmentDelete(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal global As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub After_SaveAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal global As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub After_UploadAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal global As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub Before_AttachmentDelete(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal global As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub Before_GetAttachmentFolderPath(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal global As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub Before_SaveAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal global As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub Before_UploadAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal global As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub Before_ViewAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentView, ByVal global As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub BeforePrintDetails_SubTag(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_SubTag, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

'    End Sub
'End Class
'Public Class cPM_ToolsSkill_CommonPageCPSQL
'    Inherits CommonEngine.CommonPage.cCPSQL
'    'Constructor
'    Public Sub New(ByVal Global As WebPages.Template.IGlobal)
'        Call MyBase.New(Global)
'    End Sub


'End Class
'Public Class cPM_ToolsSkill_CommonPagePlotControls
'    Inherits CommonEngine.CommonPage.cPlotControls
'    Public Sub New(ByVal Global As WebPages.Template.IGlobal)
'        ''Assign the Parameter values to the local variables
'        Call MyBase.New(Global)
'    End Sub


'    Protected Overrides Sub After_PlotControl(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")

'    End Sub

'    Protected Overrides Sub After_PlotControlCaption(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterCaption As String = "")

'    End Sub

'    Protected Overrides Sub After_PlotControlCell(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

'    End Sub

'    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")

'    End Sub

'    Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")

'    End Sub

'    Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

'    End Sub

'    Protected Overrides Function GetCheckDuplicateSQL(ByVal strSQL As String, ByVal objGlobal As WebPages.Template.IGlobal) As String

'    End Function


'    Protected Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal global As WebPages.Template.IGlobal)

'    End Sub
'End Class


Public Class PM_ToolsSkill_CommonPage
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
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "PM_ToolsSkill_CommonList.aspx"
        MyBase.strFormPage = "PM_ToolsSkill_CommonPage.aspx"


        MyBase.Page_Load(sender, e)



    End Sub

    Public Overrides Function BeforeSave(ByVal whizglobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String
        If whizglobal.TagID = "35" Then
            Dim ParameterId As String
            Dim Version As String = "NULL"
            Dim PercentageUtilization As String = "NULL"
            Dim IsCustomerSupplied As String = ""
            Dim IsCritical As String = ""
            Dim IsProcured As String = ""
            Dim BriefDescription As String = ""
            Dim NumberOfCopies As String = ""
            Dim PlannedInDate As String = "NULL"
            Dim PlannedOutDate As String = "NULL"
            Dim NonDatabase2 As String
            Dim strQuery As String
            Dim ProjectID As String
            Dim CreatedBy As String

            If PrimaryKey = "" Then

                ProjectID = Session("intProjectID").ToString()
                ParameterId = Request.Form("ParameterId").ToString()
                Version = CommonFunction.General.CheckIsNothing(Request.Form("Version"), "NULL").ToString()
                PercentageUtilization = CommonFunction.General.CheckIsNothing(Request.Form("PercentageUtilization"), "NULL").ToString()
                If PercentageUtilization = "" Then
                    PercentageUtilization = "NULL"
                End If

                If Not Request.Form("IsCustomerSupplied") Is Nothing Then
                    IsCustomerSupplied = Request.Form("IsCustomerSupplied").ToString()
                End If
                If Not Request.Form("IsCritical") Is Nothing Then
                    IsCritical = Request.Form("IsCritical").ToString()
                End If
                If Not Request.Form("IsProcured") Is Nothing Then
                    IsProcured = Request.Form("IsProcured").ToString()
                End If

                BriefDescription = CommonFunction.General.CheckIsNothing(Request.Form("BriefDescription"), "NULL").ToString()
                NumberOfCopies = CommonFunction.General.CheckIsNothing(Request.Form("NumberOfCopies"), "NULL").ToString()
                If NumberOfCopies = "" Then
                    NumberOfCopies = "NULL"
                End If
                PlannedInDate = CommonFunction.General.CheckIsNothing(Request.Form("PlannedInDate"), "NULL").ToString()
                PlannedOutDate = CommonFunction.General.CheckIsNothing(Request.Form("PlannedOutDate"), "NULL").ToString()
                NonDatabase2 = Request.Form("NonDatabase2").ToString()
                CreatedBy = Session("strUserName").ToString()

                strQuery = "usp_INS_tbl_PM_ProjectTools " + ProjectID + "," + ParameterId + ",'" + Version + "'," + PercentageUtilization + ",'" + IsCustomerSupplied + "','" + IsCritical + "','" + IsProcured + "','" + BriefDescription + "'," + NumberOfCopies + ",'" + PlannedInDate + "','" + PlannedOutDate + "','" + NonDatabase2 + "','" + CreatedBy + "'"

                CommonFunction.Data.InsertOrUpdateData(strQuery, True)

                strActionCode = ReturnCodes.IGNORE_SAVE.ToString
            End If
        End If
    End Function

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cPM_ToolsSkill_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    'Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
    '    Return New cPM_ToolsSkill_CommonPagePlotControls(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
    '    Return New cPM_ToolsSkill_CommonPageCPSQL(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
    '    Return New cPM_ToolsSkill_CommonPageDataManagement(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitSubTagCLSQL(ByVal global As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
    '    Return New cPM_ToolsSkill_CommonPageSubTagCLSQL(global)
    'End Function
End Class

Public Class cPM_ToolsSkill_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Dim strQuery As String
    Dim strProjectID As String
    Dim PK As String
    Dim IsSkill As String

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        If WhizGlobal.TagID = "35" Then
            If Args.ControlName.ToUpper() = "NONDATABASE1" Then

                strProjectID = HttpContext.Current.Session("intProjectID").ToString()
                PK = Args.PrimaryKeyValue

                'If Not HttpContext.Current.Request.Form("NonDatabase5") Is Nothing And HttpContext.Current.Request.Form("NonDatabase5") <> "" Then
                '    IsSkill = HttpContext.Current.Request.Form("NonDatabase5").ToString()
                'End If
                If Not PK Is Nothing And PK <> "" Then
                    'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
                    'strQuery = "SELECT tbl_PM_Tools.IsSkill FROM tbl_PM_ProjectTools INNER JOIN tbl_PM_Tools ON tbl_PM_ProjectTools.ToolID = tbl_PM_Tools.ToolID WHERE ProjectID = " + strProjectID + " And ProjectToolID = " + PK + " And tbl_PM_Tools.IsSkill = 1"
                    strQuery = "usp_sel_tbl_PM_ToolsSkills " + strProjectID + "," + PK
                    'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query


                    IsSkill = CommonFunction.Data.GetDataScalar(strQuery, True)
                    Args.ConditionClause = "SELECT 1"
                    If IsSkill = "True" Then

                        Args.ConditionalControlValue = "SELECT 2, 'Skills'"
                    Else
                        Args.ConditionalControlValue = "SELECT 1,'Tools' "
                    End If

                End If

            End If
        End If
    End Sub


End Class