Imports CommonEngines.General.cEventHandlers
'Imports CommonEngines.EventHandlers.WAF_DynamicLink

Public Class RFI_Milestone_CommonList
    Inherits CommonList



#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)

        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "RFI_Milestone_CommonList.aspx"
        ' MyBase.strFormPage = "RFI_Milestone_CommonPage.aspx"
        'MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        If HttpContext.Current.Request.QueryString.ToString.IndexOf("Operation") > 0 Then
            If HttpContext.Current.Request.QueryString.Item("Operation") = "Save" Then
                Save_Data()
            Else
                MyBase.Page_Load(sender, e)
            End If
        Else
            MyBase.Page_Load(sender, e)
        End If


    End Sub

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        PageListPreRender += "function Paging_Onclick(strPagingAlphabet)" & vbCrLf & _
                                                   "{objfrm.action = 'RFI_Milestone_CommonList.aspx?Customer=" & HttpContext.Current.Request.QueryString("Customer").ToString & _
                                                   "&RFIID=" & HttpContext.Current.Request.QueryString("RFIID").ToString & _
                                                   "&PagingAlphabet=' + strPagingAlphabet;" & vbCrLf & _
                                                   "objfrm.submit(); }" + vbCrLf

        PageListPreRender += vbCrLf & _
                                "function SortByColumn(strFieldName,strAscDesc)" & vbCrLf & _
                                "{ objfrm.action = 'RFI_Milestone_CommonList.aspx?Customer=" & HttpContext.Current.Request.QueryString("Customer").ToString & _
                                "&RFIID=" & HttpContext.Current.Request.QueryString("RFIID").ToString & _
                                "&SortBy=' + strFieldName + " & "'&SortOrder=' + strAscDesc;" & vbCrLf & _
                                "objfrm.submit(); }" + vbCrLf

        strActionCode = ReturnCodes.ON_LOAD.ToString
    End Function

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function


    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Select Case Args.SystemLinkType.ToUpper
            Case "ADD_NEW", "DELETE", "SELECT_ALL"
                Cancel = True
        End Select


        'If Args.ClientSideFunctionName.ToUpper = "CLOSE" Then
        '    Args.ToBeInsertedInFunction = "window.close();//"
        'End If

        If Args.IsListPageLink Then
            If Args.ClientSideFunctionName.ToUpper = "SAVE" Then
                'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                Dim m_strToken As String
                m_strToken = CommonFunctions.Security.Token.GetToken(CType(HttpContext.Current.Request.QueryString("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))

                'End by MonikaI
                Dim strSQL As String
                Dim strLinkID As String = ""
                'Dim strRequiredIDArray As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"))
                'strSQL = "Select UniqueID from tbl_UI_Dynamic_Links where Tagid = 3585 and ClientSideFunctionName like 'Save'"
                strSQL = "usp_sel_tbl_UI_Dynamic_Links_UniqueID"
                strLinkID = CommonFunctions.Data.GetDataScalar(strSQL, True).ToString
                Args.ToBeInsertedInFunction = "var objList;" + vbCrLf
                Args.ToBeInsertedInFunction += "objList = GetObjectReference('frmCommonList','chkDelete');" + vbCrLf
                Args.ToBeInsertedInFunction += "if (objList == null) {return;}" + vbCrLf

                Args.ToBeInsertedInFunction += "var blnIsRecordSelected=false;blnIsRecordSelected=IsCheckboxSelected('RFI_Milestone_CommonList','chkDelete');"
                Args.ToBeInsertedInFunction += "if (blnIsRecordSelected == false) {" + vbCrLf
                Args.ToBeInsertedInFunction += " alert('Please select at least one milestone');" + vbCrLf
                Args.ToBeInsertedInFunction += "return;" + vbCrLf
                Args.ToBeInsertedInFunction += "}" + vbCrLf

                'Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
                Args.ToBeInsertedInFunction += "objfrm.action = 'RFI_Milestone_CommonList.aspx?PKToken=" + m_strToken + "&Operation=Save&DYNAMIC_LINK_ID=" & strLinkID & "&UniqueValue=' + intUniqueID + '&IsListPageLink=1&MasterTagID=3585&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&Customer=" & HttpContext.Current.Request.QueryString("Customer") & "&RFIID=" & HttpContext.Current.Request.QueryString("RFIID") & "';" + vbCrLf
                Args.ToBeInsertedInFunction += "objfrm.submit();" + vbCrLf

                Args.ToBeInsertedInFunction += "var intIndex;" + vbCrLf
                Args.ToBeInsertedInFunction += "var strhRef;" + vbCrLf

                Args.ToBeInsertedInFunction += "window.opener.document.forms[0].cboRFITypeID.disabled = false;" + vbCrLf
                Args.ToBeInsertedInFunction += "window.opener.document.forms[0].cboCustomerID.disabled = false;" + vbCrLf
                Args.ToBeInsertedInFunction += "window.opener.document.forms[0].cboBillingCurrencyID.disabled = false;" + vbCrLf

                Args.ToBeInsertedInFunction += "var objform = window.opener.document.forms[0];" + vbCrLf
                Args.ToBeInsertedInFunction += "strhRef = window.opener.location.href;" + vbCrLf

                Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/Mode=New/,'Mode=Edit');" + vbCrLf
                Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/&Action=DeleteItem/,'');" + vbCrLf
                Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/&Action=Save/,'');" + vbCrLf
                Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/&Action=ChangeCustomer/,'');" + vbCrLf
                Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/&Action=Copy/,'');"

                'Integrated and uncommented by SavitaS on 14 Mar 2006 for IssueID-2836
                'cOMMENTED BY tRUPTI
                Args.ToBeInsertedInFunction += "intIndex= strhRef.indexOf('&RFIID');" + vbCrLf
                Args.ToBeInsertedInFunction += "if(intIndex!=-1)" + vbCrLf
                Args.ToBeInsertedInFunction += "strhRef = strhRef.substring(0,intIndex)" + vbCrLf
                'Args.ToBeInsertedInFunction += "strhRef += '&SelectionFlag=1&NewRFIID=" & HttpContext.Current.Request.QueryString("RFIID") & "';" + vbCrLf
                Args.ToBeInsertedInFunction += "strhRef += '&RFIID=" & HttpContext.Current.Request.QueryString("RFIID") & "';" + vbCrLf
                'eND OF COMMENTED BY TRUPTIK
                'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                'Args.ToBeInsertedInFunction += "intIndex= strhRef.indexOf('&PKToken');" + vbCrLf
                'Args.ToBeInsertedInFunction += "if(intIndex!=-1)" + vbCrLf
                'Args.ToBeInsertedInFunction += "strhRef = strhRef.substring(0,intIndex-1)" + vbCrLf
                Args.ToBeInsertedInFunction += "strhRef += '&NewPKToken=" & m_strToken & "';" + vbCrLf
                'End of addition

                Args.ToBeInsertedInFunction += "objform.action = strhRef;" & vbCrLf
                'Args.ToBeInsertedInFunction += "window.opener.location.href = strhRef;" & vbCrLf

                Args.ToBeInsertedInFunction += "objform.submit();" & vbCrLf
                Args.ToBeInsertedInFunction += "return;" & vbCrLf
                'End Integration on 14 Mar 2006
                'Args.ToBeInsertedInFunction += "window.close();return;"
                'Args.ToBeInsertedInFunction += "return;" + vbCrLf
            End If
        End If
    End Sub
    Public Shared Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.DataField.Trim.ToUpper = "MILESTONE" Then
            Args.EnableLink = False
        End If
    End Sub
    Public Shared Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ColumnName.ToUpper = "DELETE" Then
            Args.ColumnName = "Select"
        End If
    End Sub

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub
    Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)
        If Args.ClientSideFunctionName = "Page_Onclick" Then
            Args.ClientSideFunctionName = "Paging_Onclick"
        End If
    End Sub
    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub


    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    ' trupti
    'Public Sub Before_ExecutingAction(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As Hashtable = Nothing)
    '    If Args.ClientSideFunctionName.ToUpper = "SAVE" Then

    '    End If
    'End Sub
    Public Function PageUIPreRender(ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal strPrimaryKey As String = "") As String
        Dim m_strToken As String
        m_strToken = HttpContext.Current.Request.QueryString("PKToken").ToString
        If CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String), m_strToken) = False Then
            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("IR/PIR", CType(2044, Long), CType(0, Long), "RFIID", HttpContext.Current.Request.QueryString("RFIID").ToString)

            'Token is Invalid now redirect to the Invalid Access Page
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'Added By JyotiG
        'Start
        'Issue Id : 6197
    End Function

    Protected Overrides Sub GetPageSpecificGlobalClass(ByRef WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Private Sub Save_Data()
        'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
        Dim m_strToken As String
        m_strToken = HttpContext.Current.Request.QueryString("PKToken").ToString
        If CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String), m_strToken) = False Then
            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("IR/PIR", CType(2044, Long), CType(0, Long), "RFIID", HttpContext.Current.Request.QueryString("RFIID").ToString)

            'Token is Invalid now redirect to the Invalid Access Page
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        Else
            'Dim strRequiredIDArray() As String = Split(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")), ",")
            Dim strRequiredIDArray As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"))
            'Dim drTools As IDataReader
            'Dim strTools As String 
            Dim strSQL As String
            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")) <> "" Then


                strSQL = "usp_ins_tbl_PM_RFI_ItemswithMilestone " + HttpContext.Current.Request.QueryString("RFIID") + ", '" + strRequiredIDArray + "'"

                'strSQL += "," + strSalesPeriodID.Trim + "," + strCompanyID.Trim
                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                strSQL = ""
            Else
                CommonFunction.General.WriteHTML("<script language=javascript>")
                CommonFunction.General.WriteHTML("alert('Please select at least one milestone'); return;")
                CommonFunction.General.WriteHTML("</script>")
            End If
            'Cancel = True
        End If

        'End Of addition MohitS
        'End Integration by SavitaS on 13 Mar 2006
        '--------------------------------------------------------------------------------------
        'Dim strScript As String
        'strScript = "<script>" + vbCrLf
        HttpContext.Current.Response.Write("<SCRIPT Language=javascript> window.close(); </SCRIPT>")

    End Sub
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cRFI_Milestone_CommonListSQL(MyBase.m_objGlobal)
    End Function

End Class

Public Class cRFI_Milestone_CommonListSQL
    Inherits CommonEngine.CommonList.cCLSQL

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal WhizGlobal As WebPages.Template.IGlobal) As String

        GetPageSpecificFilters = " AND ProjectID = " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "").ToString & " AND MilestoneID NOT IN (SELECT DISTINCT ISNULL(MilestoneID,0) FROM tbl_PM_RFI_Items WHERE RFIID =  " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RFIID"), "").ToString & ")"

    End Function
End Class
