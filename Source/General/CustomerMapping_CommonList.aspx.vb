Imports CommonEngines.General.cEventHandlers
Public Class CustomerMapping_CommonList
    Inherits CommonList



#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "CustomerMapping_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        Dim StringToBeInserted As String = ""
        StringToBeInserted += "<script language=javascript>"
        StringToBeInserted += CommonFunction.OrganizationStructure.GetDependantLocationScript(True, , "cboBG", "cboOU", , )
        StringToBeInserted += CommonFunction.OrganizationStructure.GetDependantResourcePoolScript(True, , "cboOU", "cboDU", , )
        StringToBeInserted += CommonFunction.OrganizationStructure.GetDependantResourceGroupScript(True, , "cboDU", "cboDT", , )
        StringToBeInserted += "</script>"
        CommonFunction.General.WriteHTML(StringToBeInserted)
        ''''''<Summary>
        ''''''' End of addtion By : PrashantSJ on 30th Apr 2008
        '''''''</Summary>
        MyBase.Page_Load(sender, e)
    End Sub

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = Whiz.CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = Whiz.CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim NOIID As String = ""
        Dim m_strToken As String


        If Not Request.Form("txtNOIID") Is Nothing Then
            NOIID = Request.Form("txtNOIID").ToString
        Else
            NOIID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("CustomerID"), "0"), String)
        End If

        m_strToken = CommonFunctions.Security.Token.GetToken(Request.Form("txtNOIID") + HttpContext.Current.Session("intUserID").ToString + "0" + "54")

        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtNOIID", "txtNOIID", , , , NOIID, , , , , , True, , True))
        If CommonFunction.General.CheckIsNothing(Request.QueryString("Action")).ToUpper = "SAVE" Then
            PerformAction()
            PageListPreRender = "refreshParent('frmCommonPage','CommonPage.aspx','../General/CommonPage.aspx?Customer_PK=" + CommonFunction.General.CheckIsNothing(Request.Form("txtNOIID")).ToString + "&PKToken=" + m_strToken + "&MasterTagID=54&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1',true);"
            strActionCode = ReturnCodes.ON_LOAD.ToString
        End If
    End Function
    Private Sub PerformAction()
        Dim strSQL As New System.Text.StringBuilder
        Dim i As Integer = 0
        Dim m_iBGID, m_iOUID, m_iDUID, m_iDTID, m_iPTID, m_iPKID As String

        Dim m_intRowCount As Integer = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RowCount"), 0), Integer)

        For i = 1 To m_intRowCount

            m_iBGID = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboBG" + CStr(i)), ""), String)
            m_iOUID = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboOU" + CStr(i)), ""), String)
            m_iDUID = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboDU" + CStr(i)), ""), String)
            m_iDTID = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboDT" + CStr(i)), ""), String)
            m_iPTID = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboPT" + CStr(i)), ""), String)
            m_iPKID = CType(CommonFunction.General.CheckIsNothing(Request.Form("txtHidNOIMappingID" + CStr(i)), ""), String)

            If m_iBGID = "" And m_iOUID = "" And m_iDUID = "" And m_iDTID = "" And m_iPTID = "" Then

            Else
                strSQL.Append("usp_Ins_tbl_PM_Customer_Mapping " + CType(CommonFunction.General.CheckIsNothing(Request.Form("txtNOIID"), "0"), String) + vbCrLf)

                If m_iPKID <> "" Then
                    strSQL.Append("," + m_iPKID.ToString + vbCrLf)
                Else
                    strSQL.Append(",NULL")
                End If

                If m_iBGID <> "" Then
                    strSQL.Append("," + m_iBGID.ToString + vbCrLf)
                Else
                    strSQL.Append(",NULL" + vbCrLf)
                End If
                If m_iOUID <> "" Then
                    strSQL.Append("," + m_iOUID.ToString + vbCrLf)
                Else
                    strSQL.Append(",NULL" + vbCrLf)
                End If
                If m_iDUID <> "" Then
                    strSQL.Append("," + m_iDUID.ToString + vbCrLf)
                Else
                    strSQL.Append(",NULL" + vbCrLf)
                End If
                If m_iDTID <> "" Then
                    strSQL.Append("," + m_iDTID.ToString + vbCrLf)
                Else
                    strSQL.Append(",NULL" + vbCrLf)
                End If
                If m_iPTID <> "" Then
                    strSQL.Append("," + m_iPTID.ToString + vbCrLf)
                Else
                    strSQL.Append(",NULL" + vbCrLf)
                End If

                strSQL.Append(",N'" + Session("strUserName").ToString + "'" + vbCrLf)


                CommonFunction.Data.InsertOrUpdateData(strSQL.ToString, MyBase.UseSQL)
                strSQL.Remove(0, strSQL.Length - 1)
            End If

        Next
        strSQL = Nothing
    End Sub
    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function


    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

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
    ''added by ninad ' Requirement Tag :WAF3_PB_33 
    'Protected Overrides Sub WhizForm_Init()

    'End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New CustomerMapping_CommonList_cPlotGrid(MyBase.m_objGlobal)
    End Function
End Class
Public Class CustomerMapping_CommonList_cPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public m_lngNoofRecords As Long = 0
    Private RowCount As Long = 0
    Private iRC As Long = 0
    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strSQL As String = ""
        Select Case Args.DataField.ToUpper
            Case "BUSINESSGROUPID"
                Cancel = True
                Args.StringToBeInserted = "<TD   style='text-align:centre' >" + vbCrLf
                Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawComboBox("cboBG" + RowCount.ToString, "usp_Sel_tbl_CNF_BusinessGroup 1", 150, CommonFunction.Data.CheckIsDBNull(Args.DataReader("BusinessGroupID")).ToString, "onchange='javascript:BusinessGroup_Change(0," + RowCount.ToString + ")'", True, True, , , , , )
                Args.StringToBeInserted += "</Td>"

            Case "LOCATIONID"
                Cancel = True
                Args.StringToBeInserted = "<TD   style='text-align:centre' >" + vbCrLf
                Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawComboBox("cboOU" + RowCount.ToString, "usp_Sel_tbl_PM_Location_For_BG " + CommonFunction.Data.CheckIsDBNull(Args.DataReader("BusinessGroupID")).ToString, 150, CommonFunction.Data.CheckIsDBNull(Args.DataReader("LocationID")).ToString, "onchange='javascript:OUPool_OnChange(this,0," + RowCount.ToString + ")'", True, True, , , , , )
                Args.StringToBeInserted += "</Td>"
            Case "DELIVERYUNITID"
                strSQL = "usp_Sel_tbl_PM_ResourcePool "
                If CommonFunction.Data.CheckIsDBNull(Args.DataReader("LocationID")).ToString <> "" Then
                    strSQL += Args.DataReader("LocationID").ToString
                Else
                    strSQL += " NULL"
                End If

                Cancel = True
                Args.StringToBeInserted = "<TD  style='text-align:centre' >" + vbCrLf
                Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawComboBox("cboDU" + RowCount.ToString, strSQL, 150, CommonFunction.Data.CheckIsDBNull(Args.DataReader("DeliveryUnitID")).ToString, "onchange='javascript:DUPool_OnChange(this,0," + RowCount.ToString + ")'", True, True, , , , , )
                Args.StringToBeInserted += "</Td>"
            Case "DELIVERYTEAMID"
                strSQL = "usp_Sel_Delivery_Team NULL "
                If CommonFunction.Data.CheckIsDBNull(Args.DataReader("DeliveryUnitID")).ToString <> "" Then
                    strSQL += "," + Args.DataReader("DeliveryUnitID").ToString
                Else
                    strSQL += ",NULL"
                End If

                Cancel = True
                Args.StringToBeInserted = "<TD   style='text-align:centre' >" + vbCrLf
                Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawComboBox("cboDT" + RowCount.ToString, strSQL, 150, CommonFunction.Data.CheckIsDBNull(Args.DataReader("DeliveryTeamID")).ToString, , True, True, , , , , )
                Args.StringToBeInserted += "</Td>"
            Case "PROJECTTYPEID"
                Cancel = True
                Args.StringToBeInserted = "<TD   style='text-align:centre' >" + vbCrLf
                Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawComboBox("cboPT" + RowCount.ToString, "usp_Sel_Practice " & CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectTypeID")).ToString, 150, CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectTypeID")).ToString, , True, True, , , , , )
                Args.StringToBeInserted += "</Td>"

            Case "IMAGE1"
                Cancel = True
                Args.StringToBeInserted = "<TD  style='text-align:centre;width:20px' >" + vbCrLf
                Args.StringToBeInserted += "</Td>"
        End Select
    End Sub
    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.DataField.ToUpper = "IMAGE1" Then
            Args.ColumnName = ""
        End If
    End Sub
    'addition end by ninad ' Requirement Tag :WAF3_PB_33 
    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        m_lngNoofRecords = Args.RecordCount
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtHidRC", "txtHidRC", , , , m_lngNoofRecords.ToString, , , , , , True, , True))
    End Sub
    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        RowCount += 1
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtHid" + Args.PrimaryKeyName + RowCount.ToString, "txtHid" + Args.PrimaryKeyName + RowCount.ToString, , , , CommonFunction.Data.CheckIsDBNull(Args.DataReader("NOIMappingID")).ToString, , , , , , True, , True))
    End Sub
End Class
Public Class cCustomerMapping_CommonListSQL
    Inherits CommonEngine.CommonList.cCLSQL

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal WhizGlobal As WebPages.Template.IGlobal) As String
        Dim NOIID As String = ""
        Dim m_strToken As String
        m_strToken = CommonFunctions.Security.Token.GetToken(CType(HttpContext.Current.Request.QueryString("CustomerID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(54, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))

        If Not HttpContext.Current.Request.Form("txtNOIID") Is Nothing Then
            NOIID = HttpContext.Current.Request.Form("txtNOIID").ToString
        Else
            NOIID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CustomerID"), "0"), String)
        End If
        'If Not HttpContext.Current.Request.QueryString("CustomerID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("CustomerID") <> "" Then
        '    Custid = HttpContext.Current.Request.QueryString("CustomerID")
        'ElseIf Not HttpContext.Current.Request.Form("hidCustID") Is Nothing AndAlso HttpContext.Current.Request.Form("hidCustID") <> "" Then
        '    Custid = HttpContext.Current.Request.Form("hidCustID")
        'End If
        If NOIID <> "" Then
            GetPageSpecificFilters = " AND CustomerID = " + NOIID
        End If

    End Function

End Class
