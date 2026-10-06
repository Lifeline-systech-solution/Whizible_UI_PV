Imports CommonEngines.General.cEventHandlers
Imports WorkFlowCommonEngine

Public Class ClassMyDynamicMenu
    Inherits WebPage.UI.cDynamicMenu

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

End Class

Public Class cMyDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cMySubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    'Protected Overrides Sub After_AttachmentDelete(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_SaveAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_UploadAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_AttachmentDelete(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_GetAttachmentFolderPath(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_SaveAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_UploadAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_ViewAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentView, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub BeforePrintDetails_SubTag(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_SubTag, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Public Overrides Sub DeleteRecords()

    'End Sub

    'Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String

    'End Function

    'Protected Overrides Function GetUIPageURL(ByVal FunctionName As String, ByVal objGlobal As WebPages.Template.IGlobal, ByVal blnEditMode_UIPageOpenInWindow As Boolean, ByVal strUIPage As String) As String

    'End Function

    'Protected Overrides Sub Initialize_AttachmentDelete(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteInitialize, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub
End Class
Public Class cMyCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
Public Class cInheritedWorkFlowCommonPagePlotControl
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class

Public Class InheritedWorkFlowCommonPage
    Inherits CommonPage

    Protected WithEvents objWorkFlowDefinition As WorkFlowGeneral.DefinitionDetails.Definition
    Protected m_strNonDataBase As String
    Protected m_strStageConditionError As String
    Protected m_blnShowPopup As Boolean

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        MyBase.ApplySecurity(True)

        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
        objWorkFlowDefinition = New WorkFlowGeneral.DefinitionDetails.Definition
    End Sub

#End Region

    Public Overridable Sub WorkFlowInstance_After_Approve(ByRef Args As WorkFlowCommonEngine.DefinationStructures.WAF_ProcessStageDetails, ByVal Whizglobal As WebPages.Template.IGlobal) Handles objWorkFlowDefinition.After_Approve
        'Call WorkFlowEvents.DefinitionDetail.WorkFlow_Event_Approve.After_Approve(Args, global)
    End Sub

    Public Overridable Sub WorkFlowInstance_After_Reject(ByRef Args As WorkFlowCommonEngine.DefinationStructures.WAF_ProcessStageDetails, ByVal Whizglobal As WebPages.Template.IGlobal) Handles objWorkFlowDefinition.After_Reject
        'Call WorkFlowEvents.DefinitionDetail.WorkFlow_Event_Reject.After_Reject(Args, global)
    End Sub

    Public Overridable Sub WorkFlowInstance_After_Submit(ByRef Args As WorkFlowCommonEngine.DefinationStructures.WAF_ProcessStageDetails, ByVal Whizglobal As WebPages.Template.IGlobal) Handles objWorkFlowDefinition.After_Submit
        'Call WorkFlowEvents.DefinitionDetail.WorkFlow_Event_Submit.After_Submit(Args, global)
    End Sub

    Public Overridable Sub WorkFlowInstance_Before_Approve(ByRef Cancel As Boolean, ByRef Args As WorkFlowCommonEngine.DefinationStructures.WAF_ProcessStageDetails, ByVal Whizglobal As WebPages.Template.IGlobal) Handles objWorkFlowDefinition.Before_Approve
        'Call WorkFlowEvents.DefinitionDetail.WorkFlow_Event_Approve.Before_Approve(Cancel, Args, global)
    End Sub

    Public Overridable Sub WorkFlowInstance_Before_Reject(ByRef Cancel As Boolean, ByRef Args As WorkFlowCommonEngine.DefinationStructures.WAF_ProcessStageDetails, ByVal Whizglobal As WebPages.Template.IGlobal) Handles objWorkFlowDefinition.Before_Reject
        'Call WorkFlowEvents.DefinitionDetail.WorkFlow_Event_Reject.Before_Reject(Cancel, Args, global)
    End Sub

    Protected Overridable Sub WorkFlowInstance_Before_Submit(ByRef Cancel As Boolean, ByRef Args As WorkFlowCommonEngine.DefinationStructures.WAF_ProcessStageDetails, ByVal Whizglobal As WebPages.Template.IGlobal) Handles objWorkFlowDefinition.Before_Submit
        'Before_Submit(Cancel, Args, global)
    End Sub

    'Protected Overridable Sub Before_Submit(ByRef Cancel As Boolean, ByRef Args As WorkFlowCommonEngine.DefinationStructures.WAF_ProcessStageDetails, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    Private Sub objWorkFlowDefinition_MailSend(ByVal e As WorkFlowCommonEngine.DefinationStructures.WorkflowEmails, ByVal InstanceID As String, ByVal Args As WorkFlowCommonEngine.DefinationStructures.WAF_ProcessStageDetails, ByVal Action As String, ByVal PrimaryKeyValue As String) Handles objWorkFlowDefinition.MailSend
        Dim blnCancel As Boolean = False
        Call Before_SendMail(blnCancel, e, Action)
        If blnCancel = False Then
            SendWorkflow_Email(e, InstanceID, Args, Action, PrimaryKeyValue)
        End If

    End Sub
    Protected Overridable Sub Before_SendMail(ByRef Cancel As Boolean, ByRef e As WorkFlowCommonEngine.DefinationStructures.WorkflowEmails, ByVal Action As String)

    End Sub
    Protected Overridable Sub SendWorkflow_Email(ByVal e As WorkFlowCommonEngine.DefinationStructures.WorkflowEmails, ByVal InstanceID As String, ByVal Args As WorkFlowCommonEngine.DefinationStructures.WAF_ProcessStageDetails, ByVal Action As String, ByVal PrimaryKeyValue As String)
        Dim strTo As String
        Dim strFrom As String
        Dim strCC As String
        Dim strBody As String
        Dim strSubject As String

        Select Case UCase(Action)
            Case "SUBMIT"
                If e.ShowPopup = False Then
                    WorkFlows.CommonEmails.SubmitSilentMail(strFrom, strTo, strCC, strSubject, strBody, e, InstanceID, Args, PrimaryKeyValue)
                    CommonFunction.Emails.SendEmailWithCC(strTo, strCC, strFrom, strSubject, strBody)
                Else
                    CommonFunctions.General.WriteHTML("<SCRIPT Language=javascript> window.open(""../General/SendEmail.aspx?Workflow=1&MessageID=" + "70478A07-EF57-492B-9AB4-CC31F50783AB" + "&InstanceID=" + InstanceID + "&ProcessID=" + Args.ProcessID.ToString + "&NextStageID=" + Args.NextStageID.ToString + "&PrimaryKeyValue=" + PrimaryKeyValue + ""","""",""resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 460)/2 + "",width=600,height=460"");</SCRIPT>")
                End If
            Case "RESUBMIT"
                If e.ShowPopup = False Then
                    WorkFlows.CommonEmails.ReSubmitSilentMail(strFrom, strTo, strCC, strSubject, strBody, e, InstanceID, Args, PrimaryKeyValue)
                    CommonFunction.Emails.SendEmailWithCC(strTo, strCC, strFrom, strSubject, strBody)
                Else
                    CommonFunctions.General.WriteHTML("<SCRIPT Language=javascript> window.open(""../General/SendEmail.aspx?Workflow=1&MessageID=" + "A8697C62-BCF9-46BC-ADD7-A6799179315A" + "&InstanceID=" + InstanceID + "&ProcessID=" + Args.ProcessID.ToString + "&NextStageID=" + Args.NextStageID.ToString + "&PrimaryKeyValue=" + PrimaryKeyValue + ""","""",""resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 460)/2 + "",width=600,height=460"");</SCRIPT>")
                End If
            Case "APPROVE"
                If e.ShowPopup = False Then
                    WorkFlows.CommonEmails.ApproveSilentMail(strFrom, strTo, strCC, strSubject, strBody, e, InstanceID, Args, PrimaryKeyValue)
                    CommonFunction.Emails.SendEmailWithCC(strTo, strCC, strFrom, strSubject, strBody)
                Else
                    CommonFunctions.General.WriteHTML("<SCRIPT Language=javascript> window.open(""../General/SendEmail.aspx?Workflow=1&MessageID=" + "37E64B21-ACE3-48A9-A9F2-73A31B944987" + "&InstanceID=" + InstanceID + "&ProcessID=" + Args.ProcessID.ToString + "&NextStageID=" + Args.NextStageID.ToString + "&CurrentStageID=" + Args.StageID.ToString + "&PrimaryKeyValue=" + PrimaryKeyValue + ""","""",""resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 460)/2 + "",width=600,height=460"");</SCRIPT>")
                End If
            Case "REJECT"
                If e.ShowPopup = False Then
                    WorkFlows.CommonEmails.RejectSilentMail(strFrom, strTo, strCC, strSubject, strBody, e, InstanceID, Args, PrimaryKeyValue)
                    CommonFunction.Emails.SendEmailWithCC(strTo, strCC, strFrom, strSubject, strBody)
                Else
                    CommonFunctions.General.WriteHTML("<SCRIPT Language=javascript> window.open(""../General/SendEmail.aspx?Workflow=1&MessageID=" + "559B9008-00BC-4C95-99F5-5AD4F5CE66FD" + "&InstanceID=" + InstanceID + "&ProcessID=" + Args.ProcessID.ToString + "&NextStageID=" + Args.NextStageID.ToString + "&CurrentStageID=" + Args.StageID.ToString + "&PrimaryKeyValue=" + PrimaryKeyValue + ""","""",""resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 460)/2 + "",width=600,height=460"");</SCRIPT>")
                End If

        End Select

    End Sub

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        If UCase(MyBase.strListPage) = "COMMONLIST.ASPX" Then
            MyBase.strListPage = "InheritedWorkFlowCommonList.aspx"
        End If
        If UCase(MyBase.strFormPage) = "COMMONPAGE.ASPX" Then
            MyBase.strFormPage = "InheritedWorkFlowCommonPage.aspx"
        End If
        MyBase.Page_Load(sender, e)
        objWorkFlowDefinition.Initialize()
        m_blnShowPopup = True

    End Sub
    Protected Overrides Sub OnUnload(ByVal e As System.EventArgs)

        'Dispose all the workflow related objects.
        objWorkFlowDefinition = Nothing
    End Sub

    Protected NotOverridable Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        'Call FillWorkFlowDefinition(m_objGlobal, strPrimaryKey)
        If m_objGlobal.ParentTagID = 0 Then
            objWorkFlowDefinition.FillWorkFlowDefinition(m_objGlobal, strPrimaryKey)
        End If
        Call PageUI_PreRender(m_objGlobal, strActionCode, strPrimaryKey)

    End Function

    Protected Overridable Function PageUI_PreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String

    End Function

    Protected NotOverridable Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        If m_objGlobal.ParentTagID = 0 Then
            If Not Request.QueryString("Mode") Is Nothing Then
                If UCase(Request.QueryString("Mode")) = "ADD_NEW" Then
                    'If Not UCase(Request.QueryString("WorkflowOption")) Is Nothing Then
                    '    If UCase(Request.QueryString("WorkflowOption")) = "SUBMIT" Then
                    '        UpdateWorkFlowData(m_objGlobal, strPrimaryKey)
                    '    End If
                    'End If
                Else
                    If Request.QueryString("Operation") Is Nothing Then
                        UpdateWorkFlowData(m_objGlobal, strPrimaryKey)
                    ElseIf UCase(Request.QueryString("Operation")) <> "SAVE" Then
                        UpdateWorkFlowData(m_objGlobal, strPrimaryKey)
                    End If
                End If
            End If
            'UpdateWorkFlowData(m_objGlobal, strPrimaryKey)
        End If

        Call PageUI_PostRender(m_objGlobal, strActionCode, strPrimaryKey)
        If m_objGlobal.ParentTagID = 0 Then
            If UCase(Request.QueryString("WorkflowOption")) = "APPROVE" Or UCase(Request.QueryString("WorkflowOption")) = "REJECT" Then
                Dim strScript As String
                strScript = "window.opener.document.forms['frmCommonList'].action = 'WorkFlowInbox.aspx?FromWhere=IX&MasterTagID=1577';" + vbCrLf
                strScript += "window.opener.document.forms['frmCommonList'].submit();" + vbCrLf
                strScript += "window.close();"
                PageUIPostRender = strScript
                strActionCode = ReturnCodes.ON_LOAD.ToString
            Else
                PageUIPostRender = PlotClientSideScriptForFunctionCalls(objWorkFlowDefinition.m_lngPageID)
                strActionCode = ReturnCodes.ON_LOAD.ToString
            End If
        End If

    End Function

    Protected Overridable Function PageUI_PostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String

    End Function

    'Protected Overrides Sub After_ExecutingAction(ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)

    'End Sub

    'Protected Overrides Sub Before_ExecutingAction(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)

    'End Sub

    Protected NotOverridable Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

        Call Before_Plot_Section(Cancel, Args, Whizglobal, PrimaryKey)
        If Whizglobal.ParentTagID = 0 Then
            If Args.OrderNumber = 1 Then
                If objWorkFlowDefinition.m_strInstanceID <> "" Then
                    If UCase(objWorkFlowDefinition.m_strMessageType) = "DISPLAY" Then
                        Dim strScript As String
                        Dim strUserID As String
                        Dim strSQL As String
                        strSQL = "SELECT UserID FROM tbl_WF_Instance WHERE InstanceID = '" + objWorkFlowDefinition.m_strInstanceID + "'"
                        strUserID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                        If strUserID <> Whizglobal.UserID.ToString Then
                            strScript = "<DIV Id=divMsg Style=""OVERFLOW:auto; WIDTH:100%;"">"
                            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                            strScript += "<TABLE id='tblmsg' CellSpacing=0 class='clsTable' width='99.9%'><TR class='clsTREven'><TD title="""" valign=top align=left>"
                            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                            strScript += "<pre><B><I>" + objWorkFlowDefinition.m_strMessageDescription + "</I></B></pre>" ' m_strMessageDescription
                            strScript += "</TD></TR></TABLE></DIV>"
                            CommonFunction.General.WriteHTML(strScript)
                        End If
                    End If
                End If
            End If
        End If


        Call Before_Plot_Section(Cancel, Args, Whizglobal, PrimaryKey)

    End Sub

    Protected Overridable Sub Before_Plot_Section(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        If Whizglobal.ParentTagID = 0 Then
            If Args.SectionID = 1 Then
                If m_strNonDataBase <> "" Then
                    CommonFunction.General.WriteHTML(m_strNonDataBase)
                End If

            End If
        End If

    End Sub

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function

    'Protected Overrides Sub Section_Title_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_SectionTitle, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataGrid(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataGrid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends, ByVal Whizglobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends, ByVal Whizglobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal Whizglobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    'Protected Overrides Sub After_Link_Print(ByRef Args As WAF_DynamicMenu_Link, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_NavLink_Print(ByRef Args As WAF_DynamicMenu_NavLink, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_NavLinks_Print(ByRef Args As WAF_DynamicMenu_NavLinks, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_Paging_Print(ByRef Args As WAF_DynamicMenu_Paging, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    Public NotOverridable Overrides Function AfterSave(ByVal Whizglobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        'RedirectToCL = False
        Dim strScript As String
        If Whizglobal.ParentTagID = 0 Then
            strActionCode = ReturnCodes.DO_NOTHING.ToString
            UpdateWorkFlowData(Whizglobal, PrimaryKey)
        End If


        Call After_Save(Whizglobal, ControlsHashTable, PrimaryKey, strActionCode, IsEditMode, RedirectToCL)

        If Whizglobal.ParentTagID = 0 Then
            If m_strStageConditionError <> "" Then
                AfterSave = "window.alert('" + CommonFunction.General.BuildQueryString(m_strStageConditionError) + "');"
                strActionCode = ReturnCodes.ON_LOAD.ToString
            ElseIf UCase(Request.QueryString("WorkflowOption")) = "APPROVE" Or UCase(Request.QueryString("WorkflowOption")) = "REJECT" Then
                strScript = "window.opener.document.forms['frmCommonList'].action = 'WorkFlowInbox.aspx?FromWhere=IX&MasterTagID=1577';" + vbCrLf
                strScript += "window.opener.document.forms['frmCommonList'].submit();" + vbCrLf
                AfterSave = strScript
                strActionCode = ReturnCodes.ON_LOAD.ToString
            ElseIf UCase(Request.QueryString("WorkflowOption")) = "SUBMIT" Then
                If UCase(Request.QueryString("Mode")) = "" Then
                    strScript = "window.opener.document.forms['frmCommonList'].action = 'WorkFlowInbox.aspx?FromWhere=IX&MasterTagID=1577';" + vbCrLf
                    strScript += "window.opener.document.forms['frmCommonList'].submit();" + vbCrLf
                    AfterSave = strScript
                    strActionCode = ReturnCodes.ON_LOAD.ToString
                ElseIf UCase(Request.QueryString("Mode")) = "ADD_NEW" Then
                    'AfterSave = "window.close();"
                    'strActionCode = ReturnCodes.ON_LOAD.ToString
                    RedirectToCL = False
                End If
            End If
        End If

    End Function

    Public Overridable Function After_Save(ByVal Whizglobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String

    End Function


    'Public Overrides Function BeforeSave(ByVal Whizglobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String
    '    'RedirectToCL = False
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter, ByVal Whizglobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    Protected NotOverridable Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal Whizglobal As WebPages.Template.IGlobal)

        Before_LinkPrint(Cancel, Args, Whizglobal)
        If Whizglobal.ParentTagID = 0 Then
            If Args.SystemLinkType = "SAVE" Then
                If Not Request.QueryString("FromWorkFlow") Is Nothing Then
                    Cancel = True
                Else
                    If objWorkFlowDefinition.m_strInstanceID <> "" Then
                        If UCase(objWorkFlowDefinition.m_strAlertType) <> "A" Then
                            If UCase(objWorkFlowDefinition.m_strAlertType) = "W" Then
                                Cancel = True
                            Else
                                If objWorkFlowDefinition.m_strAlertType = "" And objWorkFlowDefinition.m_strInstanceID <> "" Then
                                    Cancel = True
                                ElseIf objWorkFlowDefinition.m_strInstanceID <> "" And UCase(objWorkFlowDefinition.m_strAlertType) = "T" And objWorkFlowDefinition.m_blnDisplaySaveLink = False Then
                                    Cancel = True
                                ElseIf objWorkFlowDefinition.m_blnDisplaySaveLink = True And UCase(objWorkFlowDefinition.m_strAlertType) = "T" Then
                                    Dim intLenght As Integer = objWorkFlowDefinition.m_objAryActions.Length
                                    Dim intIndex As Integer
                                    Dim blnDisplaySave As Boolean = True
                                    For intIndex = 0 To intLenght - 1
                                        If objWorkFlowDefinition.m_objAryActions(intIndex).DefaultSaveAction = False Then
                                            blnDisplaySave = False
                                            Exit For
                                        End If
                                    Next
                                    If blnDisplaySave = False Then
                                        Cancel = True
                                    End If
                                End If
                            End If
                        Else
                            Cancel = True
                        End If
                    ElseIf objWorkFlowDefinition.m_blnDisplaySaveLink = False Then
                        Cancel = True
                    End If
                End If
            End If
        End If

        Before_LinkPrint(Cancel, Args, Whizglobal)

    End Sub

    Protected Overridable Sub Before_LinkPrint(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal Whizglobal As WebPages.Template.IGlobal)

    End Sub

    'Protected Overrides Sub Before_NavLink_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLink, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    Protected NotOverridable Overrides Sub Before_NavLinks_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLinks, ByVal Whizglobal As WebPages.Template.IGlobal)
        If Whizglobal.ParentTagID = 0 Then
            Cancel = True
        End If

        Call Before_NavLinksPrint(Cancel, Args, Whizglobal)

    End Sub

    Protected Overridable Sub Before_NavLinksPrint(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLinks, ByVal Whizglobal As WebPages.Template.IGlobal)

    End Sub

    'Protected Overrides Sub Before_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PagingLink, ByVal Whizglobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub BeforePlotTAB_SubTag(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_Tab, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub


    'Protected Overrides Sub DataRowTD_AfterPrint(ByRef Args As WAF_DataRowTD, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal Whizglobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub

    'Protected Overrides Sub InitializeTAB_SubTag(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_TabSettings, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Section_Title_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_SectionLinks, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    Protected NotOverridable Overrides Sub Before_Menu_Print(ByRef Cancel As Boolean, ByRef Args As WAF_MenuLinks, ByVal Whizglobal As WebPages.Template.IGlobal)
        Dim strScript As String = ""
        Dim intIndex As Integer
        Dim strSQL As String
        Dim intAryLength As Integer
        Dim strUserID As String

        m_strNonDataBase = ""

        Call Before_MenuPrint(Cancel, Args, Whizglobal)

        If Whizglobal.ParentTagID = 0 Then
            If Request.QueryString("WorkflowOption") Is Nothing Then
                If objWorkFlowDefinition.m_strAlertType <> "W" Then
                    If objWorkFlowDefinition.m_strAlertType = "" And Trim(objWorkFlowDefinition.m_strInstanceID + "") <> "" Then

                    Else
                        If Not objWorkFlowDefinition.m_objAryActions Is Nothing Then
                            intAryLength = objWorkFlowDefinition.m_objAryActions.Length - 1
                            For intIndex = 0 To intAryLength
                                'if it is Add new Mode
                                If Args.PrimaryKeyValue = "" Then
                                    If objWorkFlowDefinition.m_objAryActions(intIndex).ActionType = "SYS_SUBMIT" Then
                                        strScript += "| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Submit_Onclick(" + Whizglobal.TagID.ToString + ",'Y','" + objWorkFlowDefinition.m_objAryActions(intIndex).ActionID + "','" + CommonFunction.General.BuildQueryString(Args.PrimaryKeyValue) + "','" + objWorkFlowDefinition.m_strPrimaryKeyName + "','ADD_NEW')"" Title=""Submit"" >" + objWorkFlowDefinition.m_objAryActions(intIndex).UserActionName + "</A> "
                                    End If
                                Else
                                    'If it is Edit mode
                                    If objWorkFlowDefinition.m_objAryActions(intIndex).ActionType = "SYS_SUBMIT" Then
                                        strScript += "| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Submit_Onclick(" + Whizglobal.TagID.ToString + ",'Y','" + objWorkFlowDefinition.m_objAryActions(intIndex).ActionID + "','" + CommonFunction.General.BuildQueryString(Args.PrimaryKeyValue) + "','" + objWorkFlowDefinition.m_strPrimaryKeyName + "','Edit')"" Title=""Submit"" >" + objWorkFlowDefinition.m_objAryActions(intIndex).UserActionName + "</A> "
                                    ElseIf objWorkFlowDefinition.m_objAryActions(intIndex).ActionType = "SYS_APPROVE" Then
                                        If objWorkFlowDefinition.m_strAlertType <> "A" Then
                                            If objWorkFlowDefinition.m_blnDisplaySaveLink = True Then
                                                strScript += "| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Approve_Onclick(" + Whizglobal.TagID.ToString + ",'Y','" + objWorkFlowDefinition.m_objAryActions(intIndex).ActionID + "','" + CommonFunction.General.BuildQueryString(Args.PrimaryKeyValue) + "','" + objWorkFlowDefinition.m_strPrimaryKeyName + "','" + objWorkFlowDefinition.m_strInstanceID + "')"" Title=""Approve"" >" + objWorkFlowDefinition.m_objAryActions(intIndex).UserActionName + "</A> "
                                            Else
                                                strScript += "| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Approve_Onclick(" + Whizglobal.TagID.ToString + ",'N','" + objWorkFlowDefinition.m_objAryActions(intIndex).ActionID + "','" + CommonFunction.General.BuildQueryString(Args.PrimaryKeyValue) + "','" + objWorkFlowDefinition.m_strPrimaryKeyName + "','" + objWorkFlowDefinition.m_strInstanceID + "')"" Title=""Approve"" >" + objWorkFlowDefinition.m_objAryActions(intIndex).UserActionName + "</A> "
                                            End If
                                        Else
                                            strSQL = "SELECT top 1 UserID FROM tbl_WF_Event WHERE tbl_WF_Event.InstanceID ='" + objWorkFlowDefinition.m_strInstanceID + "' ORDER BY instanceEventid ASC"
                                            strUserID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0")
                                            If strUserID = Whizglobal.UserID.ToString Then
                                                If objWorkFlowDefinition.m_blnDisplaySaveLink = True Then
                                                    strScript += "| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Approve_Onclick(" + Whizglobal.TagID.ToString + ",'Y','" + objWorkFlowDefinition.m_objAryActions(intIndex).ActionID + "','" + CommonFunction.General.BuildQueryString(Args.PrimaryKeyValue) + "','" + objWorkFlowDefinition.m_strPrimaryKeyName + "','" + objWorkFlowDefinition.m_strInstanceID + "')"" Title=""Approve"" >" + objWorkFlowDefinition.m_objAryActions(intIndex).UserActionName + "</A> "
                                                Else
                                                    strScript += "| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Approve_Onclick(" + Whizglobal.TagID.ToString + ",'N','" + objWorkFlowDefinition.m_objAryActions(intIndex).ActionID + "','" + CommonFunction.General.BuildQueryString(Args.PrimaryKeyValue) + "','" + objWorkFlowDefinition.m_strPrimaryKeyName + "','" + objWorkFlowDefinition.m_strInstanceID + "')"" Title=""Approve"" >" + objWorkFlowDefinition.m_objAryActions(intIndex).UserActionName + "</A> "
                                                End If
                                            End If

                                        End If

                                        'Plote the text area for capturing the comments
                                        If m_strNonDataBase = "" Then
                                            If objWorkFlowDefinition.m_blnIsCommentsAllowed = True Then
                                                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                                                m_strNonDataBase = "<DIV Id=divSectionWorkFlow Style=""OVERFLOW:auto; WIDTH:100%;""><TABLE id='tblFormWorkFlow" + Whizglobal.TagID.ToString + "' CellSpacing=0 class='clsTable' width='99.9%'>"
                                                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                                                m_strNonDataBase += "<TR class='clsTREven'>"
                                                m_strNonDataBase += "<TD title="""" valign=top align=left>"
                                                ''Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                                                ' m_strNonDataBase += CommonFunction.HTMLControls.DrawTextArea("NonDataBase_workflowcomments", "NonDataBase_workflowcomments", "", , , , , , 400, 100, 500, , , , , , , True, , True, , , , , , True, "off")
                                                m_strNonDataBase += CommonFunction.HTMLControls.DrawTextArea("NonDataBase_workflowcomments", "NonDataBase_workflowcomments", "", , , , , , 400, 100, 500, , , , , , , True, , True, , , , , , True, "off", , True)
                                                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                                                m_strNonDataBase += "</TD></TR></TABLE></DIV>"
                                            End If

                                        End If

                                    ElseIf objWorkFlowDefinition.m_objAryActions(intIndex).ActionType = "SYS_REJECT" Then
                                        If objWorkFlowDefinition.m_strAlertType <> "A" Then
                                            If objWorkFlowDefinition.m_blnDisplaySaveLink = True Then
                                                strScript += "| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Reject_Onclick(" + Whizglobal.TagID.ToString + ",'Y','" + objWorkFlowDefinition.m_objAryActions(intIndex).ActionID + "','" + CommonFunction.General.BuildQueryString(Args.PrimaryKeyValue) + "','" + objWorkFlowDefinition.m_strPrimaryKeyName + "','" + objWorkFlowDefinition.m_strInstanceID + "')"" Title=""Reject"" >" + objWorkFlowDefinition.m_objAryActions(intIndex).UserActionName + "</A> "
                                            Else
                                                strScript += "| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Reject_Onclick(" + Whizglobal.TagID.ToString + ",'N','" + objWorkFlowDefinition.m_objAryActions(intIndex).ActionID + "','" + CommonFunction.General.BuildQueryString(Args.PrimaryKeyValue) + "','" + objWorkFlowDefinition.m_strPrimaryKeyName + "','" + objWorkFlowDefinition.m_strInstanceID + "')"" Title=""Reject"" >" + objWorkFlowDefinition.m_objAryActions(intIndex).UserActionName + "</A> "
                                            End If
                                        Else
                                            strSQL = "SELECT top 1 UserID FROM tbl_WF_Event WHERE tbl_WF_Event.InstanceID ='" + objWorkFlowDefinition.m_strInstanceID + "' ORDER BY instanceEventid ASC"
                                            strUserID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0")
                                            If strUserID = Whizglobal.UserID.ToString Then
                                                If objWorkFlowDefinition.m_blnDisplaySaveLink = True Then
                                                    strScript += "| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Reject_Onclick(" + Whizglobal.TagID.ToString + ",'Y','" + objWorkFlowDefinition.m_objAryActions(intIndex).ActionID + "','" + CommonFunction.General.BuildQueryString(Args.PrimaryKeyValue) + "','" + objWorkFlowDefinition.m_strPrimaryKeyName + "','" + objWorkFlowDefinition.m_strInstanceID + "')"" Title=""Reject"" >" + objWorkFlowDefinition.m_objAryActions(intIndex).UserActionName + "</A> "
                                                Else
                                                    strScript += "| <A class='Menu' style='TEXT-DECORATION:NONE' HREF=""Javascript:Reject_Onclick(" + Whizglobal.TagID.ToString + ",'N','" + objWorkFlowDefinition.m_objAryActions(intIndex).ActionID + "','" + CommonFunction.General.BuildQueryString(Args.PrimaryKeyValue) + "','" + objWorkFlowDefinition.m_strPrimaryKeyName + "','" + objWorkFlowDefinition.m_strInstanceID + "')"" Title=""Reject"" >" + objWorkFlowDefinition.m_objAryActions(intIndex).UserActionName + "</A> "
                                                End If
                                            End If
                                        End If

                                        'Plote the text area for capturing the comments
                                        If m_strNonDataBase = "" Then
                                            If objWorkFlowDefinition.m_blnIsCommentsAllowed = True Then
                                                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                                                m_strNonDataBase = "<DIV Id=divSectionWorkFlow Style=""OVERFLOW:auto; WIDTH:100%;""><TABLE id='tblFormWorkFlow" + Whizglobal.TagID.ToString + "' CellSpacing=0 class='clsTable' width='99.9%'>"

                                                'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                                                m_strNonDataBase += "<TR class='clsTREven'>"
                                                m_strNonDataBase += "<TD title="""" valign=top align=left>"
                                                m_strNonDataBase += CommonFunction.HTMLControls.DrawTextArea("NonDataBase_workflowcomments", "NonDataBase_workflowcomments", "", , , , , , 400, 100, 500, , , , , , , True, , True, , , , , , True, "off")
                                                m_strNonDataBase += "</TD></TR></TABLE></DIV>"
                                            End If
                                        End If
                                    End If

                                End If
                            Next
                        End If

                    End If
                End If
                Args.ToBeInserted = strScript
            End If
        End If



        Call Before_MenuPrint(Cancel, Args, Whizglobal)

    End Sub

    Protected Overridable Sub Before_MenuPrint(ByRef Cancel As Boolean, ByRef Args As WAF_MenuLinks, ByVal Whizglobal As WebPages.Template.IGlobal)

    End Sub

    Protected Overrides Sub After_Menu_Print(ByRef Args As WAF_MenuLinks, ByVal Whizglobal As WebPages.Template.IGlobal)

    End Sub

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cInheritedWorkFlowCommonPagePlotControl(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cInheritedWorkFlowCommonPagePlotControl(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cMyCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cMyDataManagement(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagCLSQL(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cMySubTagCLSQL(MyBase.m_objGlobal)
    End Function

    Private Sub UpdateWorkFlowData(ByVal m_objGlobal As WebPages.Template.IGlobal, ByVal PrimaryKeyValue As String)
        Dim strActionID As String = ""
        Dim strInstanceID As String = ""

        If PrimaryKeyValue <> "" Then
            If Not Request.QueryString("WorkflowOption") Is Nothing Then
                If UCase(Request.QueryString("WorkflowOption")) = "SUBMIT" Then
                    strActionID = UCase(CommonFunction.General.CheckIsNothing(Request.QueryString("ActionID"), ""))
                    m_strStageConditionError = objWorkFlowDefinition.UpdateWorkFlowData(m_objGlobal, PrimaryKeyValue, "SUBMIT", strActionID, "")
                ElseIf UCase(Request.QueryString("WorkflowOption")) = "APPROVE" Then
                    strActionID = UCase(CommonFunction.General.CheckIsNothing(Request.QueryString("ActionID"), ""))
                    strInstanceID = UCase(CommonFunction.General.CheckIsNothing(Request.QueryString("InstanceID"), ""))
                    m_strStageConditionError = objWorkFlowDefinition.UpdateWorkFlowData(m_objGlobal, PrimaryKeyValue, "APPROVE", strActionID, strInstanceID)
                    If objWorkFlowDefinition.m_blnIsCommentsAllowed = True Then
                        If UCase(CommonFunction.General.CheckIsNothing(Request.QueryString("InstanceID"), "")) <> "" Then
                            UpdateEvent(UCase(CommonFunction.General.CheckIsNothing(Request.QueryString("InstanceID"), "")), CommonFunction.General.BuildQueryString(Request.Form.GetValues("NonDataBase_workflowcomments")(0)))
                        End If
                    End If

                ElseIf UCase(Request.QueryString("WorkflowOption")) = "REJECT" Then
                    strActionID = UCase(CommonFunction.General.CheckIsNothing(Request.QueryString("ActionID"), ""))
                    strInstanceID = UCase(CommonFunction.General.CheckIsNothing(Request.QueryString("InstanceID"), ""))
                    m_strStageConditionError = objWorkFlowDefinition.UpdateWorkFlowData(m_objGlobal, PrimaryKeyValue, "REJECT", strActionID, strInstanceID)
                    If objWorkFlowDefinition.m_blnIsCommentsAllowed = True Then
                        If UCase(CommonFunction.General.CheckIsNothing(Request.QueryString("InstanceID"), "")) <> "" Then
                            UpdateEvent(UCase(CommonFunction.General.CheckIsNothing(Request.QueryString("InstanceID"), "")), CommonFunction.General.BuildQueryString(Request.Form.GetValues("NonDataBase_workflowcomments")(0)))
                        End If
                    End If
                End If
            End If

        End If
    End Sub

    Private Sub UpdateEvent(ByVal InstanceID As String, ByVal Comments As String)
        Dim strSQL As String
        strSQL = "usp_upd_tbl_WF_Event '" + InstanceID + "', '" + Comments + "'"
        CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

    End Sub

    Private Function PlotClientSideScriptForFunctionCalls(ByVal TagID As Long) As String
        Dim sbScript As New System.Text.StringBuilder
        Dim strPageName As String
        Dim strSQL As String
        strSQL = "SELECT AddNewMode_UIPage FROM tbl_UI_TagMaster WHERE TagID =" + TagID.ToString
        strPageName = CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
        'strPageName = strPageName.Substring(strPageName.ToUpper.LastIndexOf("/"), strPageName.Length - 1)

        'SUBMIT function script
        sbScript.Append("function Submit_Onclick(TagID,IsSave,ActionID,PrimaryKey,PrimaryKeyName,Mode)" + vbCrLf + "{" + vbCrLf)
        sbScript.Append("if (!ValidateForm_HeaderSection()) { return;}" + vbCrLf)
        sbScript.Append("EnableControlsHeaderSection();" + vbCrLf)
        sbScript.Append("if (Mode == 'ADD_NEW')" + vbCrLf + "{" + vbCrLf)
        sbScript.Append("if (IsSave == 'Y')" + vbCrLf + "{" + vbCrLf)
        sbScript.Append("objfrm.action = """ + strPageName + "?Operation=SAVE&Mode=ADD_NEW&FromCL=1&MasterTagID="" + TagID + ""&FromWhere=SM&ParentTagID=0&WorkflowOption=SUBMIT&ActionID="" + ActionID + ""&"" + PrimaryKeyName + ""="";" + vbCrLf + "}")
        sbScript.Append("else" + vbCrLf + "{" + vbCrLf)
        sbScript.Append("objfrm.action = """ + strPageName + "?MasterTagID="" + TagID + ""&FromWhere=SM&ParentTagID=0&WorkflowOption=SUBMIT&ActionID="" + ActionID+ ""&"" + PrimaryKeyName + ""="" + PrimaryKey;" + vbCrLf + "}" + vbCrLf + "}" + vbCrLf)
        sbScript.Append("else" + vbCrLf + "{" + vbCrLf)
        sbScript.Append("if (IsSave == 'Y')" + vbCrLf + "{" + vbCrLf)
        sbScript.Append("objfrm.action = """ + strPageName + "?Operation=SAVE&Mode=&FromCL=1&MasterTagID="" + TagID + ""&FromWhere=SM&ParentTagID=0&WorkflowOption=SUBMIT&ActionID="" + ActionID + ""&"" + PrimaryKeyName + ""_PK="" + PrimaryKey ;" + vbCrLf + "}" + vbCrLf)
        sbScript.Append("else" + vbCrLf + "{" + vbCrLf)
        sbScript.Append("objfrm.action = """ + strPageName + "?Mode=&FromCL=1&MasterTagID="" + TagID + ""&FromWhere=SM&ParentTagID=0&WorkflowOption=SUBMIT&ActionID="" + ActionID+ ""&"" + PrimaryKeyName + ""_PK="" + PrimaryKey;" + vbCrLf + "}" + vbCrLf + "}" + vbCrLf)
        sbScript.Append("objfrm.submit();" + vbCrLf + "}" + vbCrLf)

        'APPROVE function script
        sbScript.Append(vbCrLf + "function Approve_Onclick(TagID,IsSave,ActionID,PrimaryKey,PrimaryKeyName,InstanceID)" + vbCrLf + "{" + vbCrLf)

        If objWorkFlowDefinition.m_blnIsCommentsAllowed = True Then
            If objWorkFlowDefinition.m_blnDisplaySaveLink = True Then
                sbScript.Append("if (!ValidateForm_HeaderSection()) { return;}" + vbCrLf)
            End If
            sbScript.Append("window.open(""../WorkFlow/WorkFlowComments.aspx?MasterTagID=1599&PageTagID="" + TagID + ""&IsSave="" + IsSave + ""&ActionID="" + ActionID +""&PrimaryKey="" + PrimaryKey + ""&PrimaryKeyName="" + PrimaryKeyName + ""&InstanceID="" + InstanceID + ""&Option=Approve"","""", ""resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 400)/2 + "",width=600,height=400"" );" + vbCrLf + "}" + vbCrLf)
        Else
            sbScript.Append("if (IsSave == 'Y')" + vbCrLf + "{" + vbCrLf)
            sbScript.Append("if (!ValidateForm_HeaderSection()) { return;}" + vbCrLf)
            sbScript.Append("objfrm.action = """ + strPageName + "?Operation=SAVE&Mode=&FromCL=1&MasterTagID="" + TagID + ""&FromWhere=SM&ParentTagID=0&WorkflowOption=APPROVE&ActionID="" + ActionID + ""&"" + PrimaryKeyName + ""_PK="" + PrimaryKey + ""&InstanceID="" + InstanceID ;" + vbCrLf + "}" + vbCrLf)
            sbScript.Append("else" + vbCrLf + "{" + vbCrLf)
            sbScript.Append("objfrm.action = """ + strPageName + "?Mode=&FromCL=1&MasterTagID="" + TagID + ""&FromWhere=SM&ParentTagID=0&WorkflowOption=APPROVE&ActionID="" + ActionID+ ""&"" + PrimaryKeyName + ""_PK="" + PrimaryKey + ""&InstanceID="" + InstanceID ;" + vbCrLf + "}" + vbCrLf)
            sbScript.Append("objfrm.submit();" + vbCrLf + "}" + vbCrLf)

        End If


        'REJECT function script
        sbScript.Append(vbCrLf + "function Reject_Onclick(TagID,IsSave,ActionID,PrimaryKey,PrimaryKeyName,InstanceID)" + vbCrLf + "{" + vbCrLf)
        If objWorkFlowDefinition.m_blnIsCommentsAllowed = True Then
            If objWorkFlowDefinition.m_blnDisplaySaveLink = True Then
                sbScript.Append("if (!ValidateForm_HeaderSection()) { return;}" + vbCrLf)
            End If
            sbScript.Append("window.open(""../WorkFlow/WorkFlowComments.aspx?MasterTagID=1599&PageTagID="" + TagID + ""&IsSave="" + IsSave + ""&ActionID="" + ActionID +""&PrimaryKey="" + PrimaryKey + ""&PrimaryKeyName="" + PrimaryKeyName + ""&InstanceID="" + InstanceID + ""&Option=Reject"","""", ""resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 400)/2 + "",width=600,height=400"" );" + vbCrLf + "}" + vbCrLf)
        Else
            sbScript.Append("if (IsSave == 'Y')" + vbCrLf + "{" + vbCrLf)
            sbScript.Append("if (!ValidateForm_HeaderSection()) { return;}" + vbCrLf)
            sbScript.Append("objfrm.action = """ + strPageName + "?Operation=SAVE&Mode=&FromCL=1&MasterTagID="" + TagID + ""&FromWhere=SM&ParentTagID=0&WorkflowOption=REJECT&ActionID="" + ActionID + ""&"" + PrimaryKeyName + ""_PK="" + PrimaryKey + ""&InstanceID="" + InstanceID ;" + vbCrLf + "}" + vbCrLf)
            sbScript.Append("else" + vbCrLf + "{" + vbCrLf)
            sbScript.Append("objfrm.action = """ + strPageName + "?Mode=&FromCL=1&MasterTagID="" + TagID + ""&FromWhere=SM&ParentTagID=0&WorkflowOption=REJECT&ActionID="" + ActionID+ ""&"" + PrimaryKeyName + ""_PK="" + PrimaryKey + ""&InstanceID="" + InstanceID ;" + vbCrLf + "}" + vbCrLf)
            sbScript.Append("objfrm.submit();" + vbCrLf + "}" + vbCrLf)

        End If


        Return sbScript.ToString

    End Function


End Class
