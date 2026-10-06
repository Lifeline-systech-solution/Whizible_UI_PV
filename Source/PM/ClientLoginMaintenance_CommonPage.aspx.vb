Imports CommonEngines.General.cEventHandlers
Imports PbNIT
'Public Class cClientLoginMaintenance_CommonPageDataManagement
'    Inherits CommonEngine.CommonPage.cDataManagement
'    'Constructor
'    Public Sub New(ByVal Global As WebPages.Template.IGlobal)
'        Call MyBase.New(Global)
'    End Sub
'End Class
'Public Class cClientLoginMaintenance_CommonPageSubTagCLSQL
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
'Public Class cClientLoginMaintenance_CommonPageCPSQL
'    Inherits CommonEngine.CommonPage.cCPSQL
'    'Constructor
'    Public Sub New(ByVal Global As WebPages.Template.IGlobal)
'        Call MyBase.New(Global)
'    End Sub


'End Class
Public Class cClientLoginMaintenance_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub


    'Protected Overrides Sub After_PlotControl(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotControlCaption(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterCaption As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotControlCell(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

    'End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        If Whizglobal.LoginType.Trim.ToString() = "C" Then

            If Args.ControlName.ToUpper = "CUSTOMERID" Then
                Cancel = True
            End If
        End If
    End Sub

    Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")
        If Whizglobal.LoginType.Trim.ToString() = "C" Then

            If Args.ControlCaption.ToUpper = "CUSTOMER" Then
                Cancel = True
            End If
        End If
    End Sub

    'Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

    'End Sub

    'Protected Overrides Function GetCheckDuplicateSQL(ByVal strSQL As String, ByVal objGlobal As WebPages.Template.IGlobal) As String

    'End Function


    'Protected Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal global As WebPages.Template.IGlobal)

    'End Sub
End Class


Public Class ClientLoginMaintenance_CommonPage
    Inherits CommonPage

    'Public m_strLoginID As String

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
        MyBase.strListPage = "ClientLoginMaintenance_CommonList.aspx"
        MyBase.strFormPage = "ClientLoginMaintenance_CommonPage.aspx"

        'If Request.QueryString("ForeignKeyValue") <> "" Then
        '    CommonFunction.HTMLControls.DrawTextBox("txtLoginID", "txtLoginID", , , , Request.QueryString("ForeignKeyValue").ToString, , , , , , True)
        'End If
        If Request.QueryString("Customer") <> "" Then
            Dim strSql As String
            Dim Customer As Integer
            Dim value As String
            value = ""
            Customer = CInt(Request.QueryString("Customer"))
            strSql = "usp_Sel_ClientsByCustomer " + Customer.ToString()
            Dim drClients As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strSql)
            Dim Clients As New System.Text.StringBuilder
            If (drClients.HasRows) Then
                While (drClients.Read())
                    value = drClients("ClientName").ToString
                    If (value <> "") Then
                        Clients.Append(drClients("ClientName").ToString)
                        Clients.Append(",")
                    End If
                End While
            End If
            CommonFunctions.Data.DisposeDataReader(CType(drClients, SqlClient.SqlDataReader))
            Response.Write(Clients.ToString)

        ElseIf Request.QueryString("ClientId") <> "" Then
            Dim strSql As String
            Dim ClientId As Integer
            Dim ClientCode As String
            ClientId = CInt(Request.QueryString("ClientId"))
            strSql = "usp_Sel_ClientCodeById " + ClientId.ToString()
            Dim drClients As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strSql)
            If (drClients.Read) Then
                ClientCode = drClients("ClientCode").ToString
            Else
                Exit Sub
            End If
            CommonFunctions.Data.DisposeDataReader(CType(drClients, SqlClient.SqlDataReader))
            Response.Write(ClientCode)
        Else
            MyBase.Page_Load(sender, e)
        End If



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

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

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
        Dim str As String
        If WhizGlobal.TagID = 1032 Then
            str = "UPDATE tbl_PM_Login set ClientId=" + GetFormValue("ClientID").ToString() + " WHERE LoginName='" + GetFormValue("LoginName").ToString() + "' AND CustomerId=" + Session("intUserId").ToString()
            CommonFunction.Data.InsertOrUpdateData(str, True)


            CommonFunction.General.WriteHTML("<script>")
            CommonFunction.General.WriteHTML("window.close();")
            CommonFunction.General.WriteHTML("</script>")
        End If
        If WhizGlobal.TagID = 96 Then
            str = "UPDATE tbl_pm_customerloginproject set CustomerId=" + WhizGlobal.UserID.ToString + " WHERE UniqueID=" + PrimaryKey
            CommonFunction.Data.InsertOrUpdateData(str, True)
        End If

        'Added By Bharat T on 22nd-Nov-2016 to send mail
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode")) = "ADD_NEW" Then
            Try
                Dim strFromEmailId As String
                Dim strToEmailId As String
                Dim strCCToEmailId As String
                Dim strSubject As String
                Dim strEmailMessage As String
                Dim strbuildpassword As String
                Dim strlogin As String = ""
                Dim strSqlquery As String = ""
                Dim strloginName As String = MyBase.GetFormValue("LoginName")
                strbuildpassword = MyBase.GetFormValue("Password")
                ''Added By Vaijat K ON 24/02/2017 For password encryption
                Dim strCount As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("NonDatabase3"))
                Dim strencryptedkey As String = ""
                Dim strencryptedlength As String = ""
                Dim struniqueid As String = ""
                Dim IsValid As Boolean = False


                'Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
                struniqueid = XMLHttp.m_LoginHashTable.Item(strloginName)
                'End of Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
                ''Added By Vaijat K ON 24/02/2017 For password encryption
                strencryptedkey = strbuildpassword.Substring(1, strCount)

                Dim strpwd1 As String() = strbuildpassword.Split("|")
                strbuildpassword = ""
                For i As Integer = 0 To strpwd1.Length - 2
                    strbuildpassword &= strpwd1(i).Substring(0, 1)
                Next
                strbuildpassword = StrReverse(strbuildpassword)

                Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_443(strFromEmailId, strToEmailId, strSubject, strEmailMessage, strloginName, strbuildpassword)
                strEmailMessage = strEmailMessage.Replace("reset", "created")
                strSubject = strSubject.Replace("reset", "created")
                Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailId, strCCToEmailId, strFromEmailId, strSubject, strEmailMessage)

            Catch ex As Exception

            End Try
        ElseIf IsEditMode = True Then
            Try
                Dim strFromEmailId As String
                Dim strToEmailId As String
                Dim strCCToEmailId As String
                Dim strSubject As String
                Dim strEmailMessage As String
                Dim strbuildpassword As String
                Dim strlogin As String = ""
                Dim strSqlquery As String = ""
                Dim strloginName As String = MyBase.GetFormValue("LoginName")
                strbuildpassword = MyBase.GetFormValue("Password")
                ''Added By Vaijat K ON 24/02/2017 For password encryption
                Dim strCount As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("NonDatabase3"))
                Dim strencryptedkey As String = ""
                Dim strencryptedlength As String = ""
                Dim struniqueid As String = ""
                Dim IsValid As Boolean = False


                'Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
                struniqueid = XMLHttp.m_LoginHashTable.Item(strloginName)
                'End of Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
                ''Added By Vaijat K ON 24/02/2017 For password encryption
                strencryptedkey = strbuildpassword.Substring(1, strCount)

                Dim strpwd1 As String() = strbuildpassword.Split("|")
                strbuildpassword = ""
                For i As Integer = 0 To strpwd1.Length - 2
                    strbuildpassword &= strpwd1(i).Substring(0, 1)
                Next
                strbuildpassword = StrReverse(strbuildpassword)
                Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_443(strFromEmailId, strToEmailId, strSubject, strEmailMessage, strloginName, strbuildpassword)
                Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailId, strCCToEmailId, strFromEmailId, strSubject, strEmailMessage)

            Catch ex As Exception

            End Try
        End If
        'End of Added By Bharat T on 22nd-Nov-2016 to send mail
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
        Return New cClientLoginMaintenance_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    'Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
    '    Return New cClientLoginMaintenance_CommonPagePlotControls(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
    '    Return New cClientLoginMaintenance_CommonPageCPSQL(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
    '    Return New cClientLoginMaintenance_CommonPageDataManagement(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitSubTagCLSQL(ByVal global As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
    '    Return New cClientLoginMaintenance_CommonPageSubTagCLSQL(global)
    'End Function
End Class
