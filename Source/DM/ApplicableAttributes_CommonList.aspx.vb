Imports CommonEngines.General.cEventHandlers
Public Class ApplicableAttributes_CommonList
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
        MyBase.strListPage = "ApplicableAttributes_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        ''''''<Summary>
        ''''''' Added By : PrashantSJ on 30th Apr 2008
        ''''''''Purpose: To perform save operation for attributes subtab
        '''''''</Summary>
        'If CommonFunction.General.CheckIsNothing(Request.QueryString("Action")).ToUpper = "SAVE" Then
        '    PerformAction()
        'End If
        Dim StringToBeInserted As String = ""
        StringToBeInserted += "<script language=javascript>"
        StringToBeInserted += CommonFunction.OrganizationStructure.GetDependantLocationScript(True, , "cboBG", "cboOU", , )
        StringToBeInserted += CommonFunction.OrganizationStructure.GetDependantResourcePoolScript(True, , "cboOU", "cboDU", , )
        StringToBeInserted += CommonFunction.OrganizationStructure.GetDependantResourceGroupScript(True, , "cboDU", "cboDT", , )
        'KIRAN K K TEST 30-11-15*/
        'StringToBeInserted += CommonFunction.OrganizationStructure.GetDependantResourcePoolScript(True, "cboDT", "cboPT", , )
        'StringToBeInserted += CommonFunction.OrganizationStructure.GetDependantResourcePoolScript(True, "cboDT", "txtHidNOIMappingID", , )
        'KIRAN K K TEST 30-11-15*/

        StringToBeInserted += "</script>"
        CommonFunction.General.WriteHTML(StringToBeInserted)
        ''''''<Summary>
        ''''''' End of addtion By : PrashantSJ on 30th Apr 2008
        '''''''</Summary>
        MyBase.Page_Load(sender, e)
    End Sub

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim NOIID As String = ""
        If Not Request.Form("txtNOIID") Is Nothing Then
            NOIID = Request.Form("txtNOIID").ToString
        Else
            NOIID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("NatureOfDemandID"), "0"), String)
        End If
        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtNOIID", "txtNOIID", , , , NOIID, , , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        If CommonFunction.General.CheckIsNothing(Request.QueryString("Action")).ToUpper = "SAVE" Then
            PerformAction()
            PageListPreRender = "refreshParent('frmCommonPage','DemandTypes_CommonPage.aspx','../DM/DemandTypes_CommonPage.aspx?NatureofDemandID_PK=" + CommonFunction.General.CheckIsNothing(Request.Form("txtNOIID")).ToString + "&MasterTagID=3928&FromWhere=PRO&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1',true);"
            strActionCode = ReturnCodes.ON_LOAD.ToString
        End If

    End Function
    Private Sub PerformAction()
        Dim strSQL As New System.Text.StringBuilder
        Dim i As Integer = 0
        Dim m_iBGID, m_iOUID, m_iDUID, m_iDTID, m_iPTID, m_iPKID As String
        Dim m_intRowCount As Integer = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RowCount"), 0), Integer)

        ''Added by Dhanashri S on 13 Oct 2015
        Dim strOUID As String()
        Dim strDUID As String()
        Dim strDTID As String()
        Dim strPTID As String()
        ''End of Addition by Dhanashri S on 13 Oct 2015

        For i = 1 To m_intRowCount

            m_iBGID = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboBG" + CStr(i)), ""), String)
            m_iOUID = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboOU" + CStr(i)), ""), String)
            m_iDUID = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboDU" + CStr(i)), ""), String)
            m_iDTID = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboDT" + CStr(i)), ""), String)
            m_iPTID = CType(CommonFunction.General.CheckIsNothing(Request.Form("cboPT" + CStr(i)), ""), String)
            m_iPKID = CType(CommonFunction.General.CheckIsNothing(Request.Form("txtHidNOIMappingID" + CStr(i)), ""), String)

            ''Added by Dhanashri S on 13 Oct 2015
            strOUID = m_iOUID.Split(",")
            m_iOUID = strOUID(0)

            strDUID = m_iDUID.Split(",")
            m_iDUID = strDUID(0)
            'Commented And Edited By KIRAN K K for Issue Id: on 31-11-15
            strDTID = m_iDTID.Split(",")
            ' m_iDTID = strDUID(0)
            m_iDTID = strDTID(0)
            'Commented And Edited By KIRAN K K for Issue Id: on 31-11-15
            strPTID = m_iPTID.Split(",")
            m_iPTID = strPTID(0)
            ''End of Addition by Dhanashri S on 13 Oct 2015

            If m_iBGID = "" And m_iOUID = "" And m_iDUID = "" And m_iDTID = "" And m_iPTID = "" Then

            Else
                strSQL.Append("usp_Ins_tbl_IM_NatureofDemand_Mapping " + CType(CommonFunction.General.CheckIsNothing(Request.Form("txtNOIID"), "0"), String) + vbCrLf)

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
    'added by ninad ' Requirement Tag :WAF3_PB_33 
    'Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
    '    MyBase.WhizForm_Init(WhizGlobal, m_intConnectionID)
    'End Sub
    'addition end by ninad ' Requirement Tag :WAF3_PB_33 
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New ApplicableAttributes_CommonList_cPlotGrid(MyBase.m_objGlobal)
    End Function
End Class
Public Class ApplicableAttributes_CommonList_cPlotGrid
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
                'Commented And Added By Usha Pandit On 18.05.2020 For getting Active/Inactive BG
                'Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawComboBox("cboBG" + RowCount.ToString, "usp_Sel_tbl_CNF_BusinessGroup 1", 150, CommonFunction.Data.CheckIsDBNull(Args.DataReader("BusinessGroupID")).ToString, "onchange='javascript:BusinessGroup_Change(0," + RowCount.ToString + ")'", True, True, , , , , )
                Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawComboBox("cboBG" + RowCount.ToString, "usp_Sel_tbl_CNF_BusinessGroup 1, 0, " & CommonFunction.Data.CheckIsDBNull(Args.DataReader("NatureOfDemandID")).ToString & ", 'PRO'", 150, CommonFunction.Data.CheckIsDBNull(Args.DataReader("BusinessGroupID")).ToString, "onchange='javascript:BusinessGroup_Change(0," + RowCount.ToString + ")'", True, True, , , , , )
                'End Of Added By Usha Pandit On 18.05.2020 For getting Active/Inactive BG
                Args.StringToBeInserted += "</Td>"

            Case "LOCATIONID"
                Cancel = True
                Args.StringToBeInserted = "<TD   style='text-align:centre' >" + vbCrLf 'added "usp_Sel_tbl_PM_Location_For_BG 1" original-> "usp_Sel_tbl_PM_Location_For_BG "
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
                strSQL = "usp_Sel_Delivery_Team NULL"

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
    'Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal global As WebPages.Template.IGlobal)
    '    Dim m_SBHTML As New System.Text.StringBuilder
    '    m_SBHTML.Append("<tr class=clsTREven id=""TRAdd"" >" + vbCrLf)
    '    m_SBHTML.Append("<td width=10px ALIGN='center' colspan='7'>" + vbCrLf)
    '    m_SBHTML.Append("<A href=""Javascript:ShowHide_SectionTR()""" + vbCrLf)
    '    m_SBHTML.Append(")""><Img Border=0 id=tdShowHide Src='../../Images/right.gif' title='Click here to add new record'></A>" + vbCrLf)
    '    m_SBHTML.Append("</td>" + vbCrLf)
    '    m_SBHTML.Append("</tr>" + vbCrLf)
    '    Args.ToBeInserted = m_SBHTML.ToString
    '    m_SBHTML = Nothing
    'End Sub
    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        m_lngNoofRecords = Args.RecordCount
        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtHidRC", "txtHidRC", , , , m_lngNoofRecords.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
    End Sub
    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        RowCount += 1
        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtHid" + Args.PrimaryKeyName + RowCount.ToString, "txtHid" + Args.PrimaryKeyName + RowCount.ToString, , , , CommonFunction.Data.CheckIsDBNull(Args.DataReader("NOIMappingID")).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
    End Sub
End Class

