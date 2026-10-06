Imports CommonEngines.General.cEventHandlers
Imports CommonFunctions
Imports System.Web.UI.Page
'Page is inherited by NitinC on 21 April 2011 for WhizibleSEM 10.0

'Public Class cResources_CommonPageDataManagement
'    Inherits CommonEngine.CommonPage.cDataManagement
'    'Constructor
'    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
'        Call MyBase.New(WhizGlobal)
'    End Sub
'End Class
'Public Class cResources_CommonPageSubTagCLSQL
'    Inherits CommonEngine.CommonList.cSubTagCLSQL
'    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
'        'Assign the Parameter values to the local variables
'        Call MyBase.New(WhizGlobal)
'    End Sub

'    'Protected Overrides Sub After_AttachmentDelete(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal global As WebPages.Template.IGlobal)

'    'End Sub

'    'Protected Overrides Sub After_SaveAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal global As WebPages.Template.IGlobal)

'    'End Sub

'    'Protected Overrides Sub After_UploadAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal global As WebPages.Template.IGlobal)

'    'End Sub

'    'Protected Overrides Sub Before_AttachmentDelete(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal global As WebPages.Template.IGlobal)

'    'End Sub

'    'Protected Overrides Sub Before_GetAttachmentFolderPath(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal global As WebPages.Template.IGlobal)

'    'End Sub

'    'Protected Overrides Sub Before_SaveAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal global As WebPages.Template.IGlobal)

'    'End Sub

'    'Protected Overrides Sub Before_UploadAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal global As WebPages.Template.IGlobal)

'    'End Sub

'    'Protected Overrides Sub Before_ViewAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentView, ByVal global As WebPages.Template.IGlobal)

'    'End Sub

'    'Protected Overrides Sub BeforePrintDetails_SubTag(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_SubTag, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

'    'End Sub
'End Class
'Public Class cResources_CommonPageCPSQL
'    Inherits CommonEngine.CommonPage.cCPSQL
'    'Constructor
'    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
'        Call MyBase.New(WhizGlobal)
'    End Sub


'End Class

Public Class cResources_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Shared m_lngProjectEmployeeRoleID As Long = 0
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub


    'Protected Overrides Sub After_PlotControl(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotControlCaption(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterCaption As String = "")

    'End Sub

    Protected Overrides Sub After_PlotControlCell(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)
        If Args.ControlName = "IsDefaultApprover" Then
            If Args.PrimaryKeyValue <> "" Then
                m_lngProjectEmployeeRoleID = Args.PrimaryKeyValue
            Else
                m_lngProjectEmployeeRoleID = 0
            End If
        End If
    End Sub

    'Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

    'End Sub

    'Protected Overrides Function GetCheckDuplicateSQL(ByVal strSQL As String, ByVal objGlobal As WebPages.Template.IGlobal) As String

    'End Function


    'Protected Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal global As WebPages.Template.IGlobal)

    'End Sub
End Class


Public Class Resources_CommonPage
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
    Protected declarevariables As String = "" 'Custom Fields objects Declaration script
    Protected strDefaultScript As String 'Script to store values of custom fields from another Controls
    Protected strClientSideScript As String 'Validation script for custom fields
    Protected m_strCustomFieldList As String = ""
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "Resources_CommonList.aspx"
        MyBase.strFormPage = "Resources_CommonPage.aspx"


        MyBase.Page_Load(sender, e)



    End Sub

    'Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String


    'End Function

    'Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String

    'End Function




    'Protected Overrides Sub After_ExecutingAction(ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)

    'End Sub

    'Protected Overrides Sub Before_ExecutingAction(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)

    'End Sub



    'Protected Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        If Args.DivSectionTag = "divSection1" Then
            PlotCustomFields()
        End If
    End Sub
    Private Sub PlotCustomFields(Optional ByVal UserID As Integer = 0, Optional ByVal LoginType As String = "")
        '=====================================================================
        ' Proceduere  Name	    :	PlotCustomFields
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw custom fields section
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	Nitin Chaudhari
        ' Created				:	21 April 2011
        ' Revisions				:	
        '=====================================================================

        Dim ObjCustomFieldsSection As New WebPage.Templates.SectionTitle
        With ObjCustomFieldsSection
            CommonFunction.General.WriteHTML("<BR>")
            CommonFunction.General.WriteHTML(.GetSectionTitle("Custom Fields", "DivCustomFieldsSection", "HideShowCustomFieldsSection"))
            CommonFunction.General.WriteHTML("<BR>")
            'Write ClientsideScript in order to show hide the section
            CommonFunction.General.WriteHTML("<SCRIPT Language=javascript>")
            CommonFunction.General.WriteHTML(.ClientsideScript)
            CommonFunction.General.WriteHTML("</SCRIPT>")
        End With
        CommonFunction.General.WriteHTML("<DIV id=DivCustomFieldsSection width='99.9%' style='overflow:auto'>")

        Dim objCustomFields As New PM_CustomFields()

        With objCustomFields

            .EntityName = "Resource Master"
            .FormName = "frmCommonPage"
            .PrimaryKey = "ProjectEmployeeRoleID"
            .PrimaryTable = "tbl_PM_ProjectEmployeeRole"
            .TypeID = "9"
            If Request.QueryString("Mode") = "ADD_NEW" And Request.QueryString("Operation") Is Nothing Then
                .IsAddNewMode = True
            Else
                .IsAddNewMode = IIf(cResources_CommonPagePlotControls.m_lngProjectEmployeeRoleID = 0, True, False)
            End If
            .PrimaryKeyValue = cResources_CommonPagePlotControls.m_lngProjectEmployeeRoleID
            '.QueryStringForTypeChange = "SubRequestTypeID"
            .m_lngProjectId = CType(HttpContext.Current.Session("intProjectID"), Integer) 'Modified By Syamantak Chavan On 21 Sept 2011 for custom field addition
            .PlotCustomFields(UserID, LoginType)
            declarevariables = .VariableDeclarationScript
            strClientSideScript = .ValidationScript
            strDefaultScript = .DefaultValueScript
            m_strCustomFieldList = .AccesibleCustomFields
        End With

        CommonFunction.General.WriteHTML("</DIV>")

        'Purpose: To render Custom Field validations
        CommonFunctions.General.WriteHTML(vbCrLf)
        CommonFunctions.General.WriteHTML("<script language=javascript>")
        CommonFunctions.General.WriteHTML(vbCrLf)
        CommonFunctions.General.WriteHTML("function ValidateCustomFields(){")
        If Not declarevariables Is Nothing Then
            CommonFunctions.General.WriteHTML(vbCrLf)
            CommonFunctions.General.WriteHTML(declarevariables)
        End If
        If Not strClientSideScript Is Nothing Then
            CommonFunctions.General.WriteHTML(vbCrLf)
            CommonFunctions.General.WriteHTML(strClientSideScript)
        End If
        If Not strDefaultScript Is Nothing Then
            CommonFunctions.General.WriteHTML(vbCrLf)
            CommonFunctions.General.WriteHTML(strDefaultScript)
        End If
        CommonFunctions.General.WriteHTML(vbCrLf)
        CommonFunctions.General.WriteHTML("return true;}")
        CommonFunctions.General.WriteHTML(vbCrLf)
        CommonFunctions.General.WriteHTML("</script>")
        'End Addition

    End Sub

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Sub Section_Title_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_SectionTitle, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataGrid(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataGrid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends, ByVal global As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends, ByVal global As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal global As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    'Protected Overrides Sub After_Link_Print(ByRef Args As WAF_DynamicMenu_Link, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_NavLink_Print(ByRef Args As WAF_DynamicMenu_NavLink, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_NavLinks_Print(ByRef Args As WAF_DynamicMenu_NavLinks, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_Paging_Print(ByRef Args As WAF_DynamicMenu_Paging, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        'Added By NitinC on 21 April 2011 for WhizbibleSEM 10.0
        'Purpose: To save custom fields
        Dim strTypeInaccessibleCustomFieldList As String
        m_strCustomFieldList = HttpContext.Current.Request.Form("CustomFieldList")
        strTypeInaccessibleCustomFieldList = HttpContext.Current.Request.Form("TypeInaccessibleCustomFieldList")
        If m_strCustomFieldList <> "" Then
            Dim arrCustomFields() As String = Split(m_strCustomFieldList, ",")
            Dim intCount As Integer
            Dim strSQL As String

            If Convert.ToInt32(PrimaryKey) > 0 Then
                strSQL = " Update tbl_PM_ProjectEmployeeRole set "
                For intCount = 0 To arrCustomFields.Length - 1
                    If HttpContext.Current.Request.Form("Dummy" + arrCustomFields(intCount)) Is Nothing Then
                        If InStr(1, arrCustomFields(intCount), "CustomFieldDate") > 0 And HttpContext.Current.Request.Form(arrCustomFields(intCount)) = "" Then
                            strSQL = strSQL & arrCustomFields(intCount) & "=NULL,"
                        Else
                            strSQL = strSQL & arrCustomFields(intCount) & "='" & CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form(arrCustomFields(intCount))) + "',"
                        End If
                    Else
                        If InStr(1, arrCustomFields(intCount), "CustomFieldDate") > 0 And HttpContext.Current.Request.Form("Dummy" + arrCustomFields(intCount)) = "" Then
                            strSQL = strSQL & arrCustomFields(intCount) & "=NULL,"
                        Else
                            strSQL = strSQL & arrCustomFields(intCount) & "='" & CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form("Dummy" + arrCustomFields(intCount))) + "',"
                        End If
                    End If
                Next
                If strTypeInaccessibleCustomFieldList <> "" Then
                    Dim arrInaccessibleCustomFields() As String = Split(strTypeInaccessibleCustomFieldList, ",")
                    For intCount = 0 To arrInaccessibleCustomFields.Length - 1
                        strSQL = strSQL & arrInaccessibleCustomFields(intCount) & "=NULL,"
                    Next
                End If
                strSQL = strSQL.Substring(0, strSQL.Length - 1)
                'If (m_strTaskIDList <> "" And Not m_strTaskIDList Is Nothing) Then
                '    strSQL = strSQL + " where TaskID IN (" & m_strTaskIDList & ") OR TaskID IN (Select ParentTask_UID From tbl_PM_ProjectTasks Where TaskID IN (" & m_strTaskIDList & ")) OR ParentTask_UID  IN (" & m_strTaskIDList & ")"
                'Else
                '    strSQL = strSQL + " where TaskID = " & m_lngTaskId & " OR TaskID = (Select ParentTask_UID From tbl_PM_ProjectTasks Where TaskID = " & m_lngTaskId & ") OR ParentTask_UID = " & m_lngTaskId
                'End If
                strSQL = strSQL + " where ProjectEmployeeRoleID = " & Convert.ToInt32(PrimaryKey)
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            End If
        End If
        'End Addition By NitinC 
        ''Added By Aniruddh Gujar on 01-Mar-2018 Purpose::To update the Product Owner
        Dim IsAgile As String
        IsAgile = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("EXEC usp_NG2_chk_IsAgileProject " & HttpContext.Current.Session("intProjectID"), True), "1")
        If IsAgile <> 0 Then
            Dim IsProductOwner As String
            IsProductOwner = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("NonDatabase9"), "")

            If IsProductOwner.ToLower = "on" Then
                IsProductOwner = 1
            Else
                IsProductOwner = 0
            End If
            Dim strQuery As String
            strQuery = "EXEC usp_NG2_INS_tbl_NG2_AgileTeam " & HttpContext.Current.Session("intProjectID") & "," & Convert.ToInt32(PrimaryKey) & "," & IsProductOwner
            CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
        End If
        ''End of Added By Aniruddh Gujar on 01-Mar-2018 Purpose::To update the Product Owner
        'Code Added By Bharat Tekade on 26th-Nov-2015 To Refresh Parent Parent Page
        Response.Write("<script language= javascript> " + vbCrLf)

        'Commented and Added By Chakshuta H on 1st-Sept-2016 Purpose::MasterCard Issue Fixing
        'CommonFunctions.General.WriteHTML("window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?MasterTagID=1019&FromWhere=PM';" + vbCrLf)
        'CommonFunctions.General.WriteHTML("window.opener.document.forms['frmCommonList'].submit();" + vbCrLf)

        'Commented And Added By Usha Pandit On 07.04.2020 For checking if window opener exists
        'CommonFunctions.General.WriteHTML("window.opener.document.forms[0].action = '../General/CommonList.aspx?MasterTagID=1019&FromWhere=PM';" + vbCrLf)
        'CommonFunctions.General.WriteHTML("window.opener.document.forms[0].submit();" + vbCrLf)
        CommonFunctions.General.WriteHTML(" if(window.opener && !window.opener.closed) { window.opener.document.forms[0].action = '../General/CommonList.aspx?MasterTagID=1019&FromWhere=PM'; }" + vbCrLf)
        CommonFunctions.General.WriteHTML("if(window.opener && !window.opener.closed) { window.opener.document.forms[0].submit(); }" + vbCrLf)
        'End Of Added By Usha Pandit On 07.04.2020 For checking if window opener exists


        'End Of Commented and Added By Chakshuta H on 1st-Sept-2016 Purpose::MasterCard Issue Fixing
        'Commented by Usha Pandit on 13.06.2019 for prevent window close on save and add button click
        'CommonFunctions.General.WriteHTML("window.close(); " + vbCrLf)
        'End of Commented by Usha Pandit on 13.06.2019 for prevent window close on save and add button click
        Response.Write("</script>")
        'Ended By Bharat Tekade

        ''Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 
        If Convert.ToInt32(PrimaryKey) > 0 Then

            Dim strSQLQuery As String
            Dim WorkHourMinute As String
            Dim WorkHour As String
            Dim WorkMinute As String

            WorkHourMinute = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase10"))

            If WorkHourMinute = "" Then
                WorkHourMinute = "00:00"
            End If

            WorkHour = WorkHourMinute.Substring(0, WorkHourMinute.IndexOf(":"))
            WorkMinute = WorkHourMinute.Substring(WorkHourMinute.IndexOf(":") + 1)

            If WorkHour = "" Then
                WorkHour = "0"
            End If
            If WorkMinute = "" Then
                WorkMinute = "0"
            End If
            If WorkMinute.Length = 1 Then
                WorkMinute = WorkMinute + "0"
            End If

            strSQLQuery = "EXEC usp_Whizible2_upd_EstimatedEffortsForWBS " & PrimaryKey & ",'" & WorkHour & "','" & WorkMinute & "',14"
            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, True)
        End If
        ''End of Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes
    End Function

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter, ByVal global As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_NavLink_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLink, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_NavLinks_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLinks, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PagingLink, ByVal global As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub BeforePlotTAB_SubTag(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_Tab, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Public Overrides Function BeforeSave(ByVal Global As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String

    'End Function

    'Protected Overrides Sub DataRowTD_AfterPrint(ByRef Args As WAF_DataRowTD, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal global As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub

    'Protected Overrides Sub InitializeTAB_SubTag(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_TabSettings, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Section_Title_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_SectionLinks, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cResources_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cResources_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    'Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
    '    Return New cResources_CommonPageCPSQL(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
    '    Return New cResources_CommonPageDataManagement(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitSubTagCLSQL(ByVal WhizGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
    '    Return New cResources_CommonPageSubTagCLSQL(WhizGlobal)
    'End Function
End Class
