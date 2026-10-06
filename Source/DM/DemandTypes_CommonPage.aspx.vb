'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhizibleSEM 
' Module Name           :  DemandTypes_CommonPage.aspx
' Purpose               :  Design the Nature Of Initiative Page
' Description           :  
' Dependencies          :  None
' Author                :  PurvaJ
' Reviewed              :  
' Tested                :  
' Created               :  25 April 2008
' Revisions             :  
'=====================================================================
Imports CommonEngines.General.cEventHandlers
Public Class DemandTypes_CommonPage
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
        MyBase.strListPage = "DemandTypes_CommonList.aspx"
        MyBase.strFormPage = "DemandTypes_CommonPage.aspx"
        'If (Request.QueryString("IsSubTagDynamicLink") = "1" And Request.QueryString("SubTagid") = "2036") Then
        '    Dim strSQL As String
        '    Dim strLinkID As String = ""
        '    strSQL = " Select UniqueID from tbl_UI_subTag_Dynamic_Links where SubTagid = 2036 and ClientSideFunctionName like 'Save_Fields_OnClick'"
        '    strLinkID = CommonFunctions.Data.GetDataScalar(strSQL, True)
        '    If strLinkID = Request.QueryString("DYNAMIC_LINK_ID") Then
        '        Dim strApplicable As String
        '        Dim strMandatory As String
        '        Dim strEditable As String
        '        Dim strPagingAlbhabet As String
        '        Dim strNatureOfDemandID As String = Request.QueryString("NatureOfDemandID")
        '        strPagingAlbhabet = Request.QueryString("SubTagPagingAlphabet")
        '        strApplicable = Request("chkApplicable")
        '        strMandatory = Request("chkMandatory")
        '        strEditable = Request("chkEditable")
        '        strSQL = "usp_Upd_tbl_CNF_NatureofDemandFieldConfig " & strNatureOfDemandID & ",'" & strApplicable & "','" & strMandatory & "'"
        '        If strPagingAlbhabet <> "" And Not (strPagingAlbhabet Is Nothing) Then
        '            strSQL = "usp_Upd_tbl_CNF_NatureofDemandFieldConfig " & strNatureOfDemandID & ",'" & strApplicable & "','" & strMandatory & "','" & strPagingAlbhabet & "'"
        '        Else
        '            strSQL = "usp_Upd_tbl_CNF_NatureofDemandFieldConfig " & strNatureOfDemandID & ",'" & strApplicable & "','" & strMandatory & "',Null"
        '        End If

        '        strSQL += ",'" + HttpContext.Current.Session("strUserName") + "','" + CommonFunctions.Dates.GetDate(Date.Now) + "'"

        '        strSQL += ",'" & strEditable & "'"
        '        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
        '    End If
        'End If
        '''''''<Summary>
        '''''''' Added By : PrashantSJ on 30th Apr 2008
        '''''''''Purpose: To perform save operation for attributes subtab
        ''''''''</Summary>
        'If CommonFunction.General.CheckIsNothing(Request.QueryString("Action")).ToUpper = "SAVE" Then
        '    PerformAction()
        'End If
        'Dim StringToBeInserted As String = ""
        'StringToBeInserted += "<script language=javascript>"
        'StringToBeInserted += CommonFunction.OrganizationStructure.GetDependantLocationScript(True, , "cboBG", "cboOU", , )
        'StringToBeInserted += CommonFunction.OrganizationStructure.GetDependantResourcePoolScript(True, , "cboOU", "cboDU", , )
        'StringToBeInserted += CommonFunction.OrganizationStructure.GetDependantResourceGroupScript(True, , "cboDU", "cboDT", , )
        'StringToBeInserted += "</script>"
        'CommonFunction.General.WriteHTML(StringToBeInserted)
        '''''''<Summary>
        '''''''' End of addtion By : PrashantSJ on 30th Apr 2008
        ''''''''</Summary>
        MyBase.Page_Load(sender, e)

    End Sub
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
                strSQL.Append("usp_Ins_tbl_IM_NatureofDemand_Mapping " + CType(CommonFunction.General.CheckIsNothing(Request.Form("NatureofDemandID_PK"), "0"), String) + vbCrLf)

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
    Protected Overrides Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cPlotGrid
        Return New cDemandTypes_CommonPageSubTagPlotGrid(m_objSubTagGlobal)
    End Function


    'Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
    '    'Put user code to initialize the page here
    '    Return New cDemandTypes_CommonPagePlotControls(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
    '    Return New cDemandTypes_CommonPagePlotControls(MyBase.m_objGlobal)
    'End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cDemandTypes_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cDemandTypes_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cDemandTypes_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    'Protected Overrides Function InitSubTagCLSQL() As CommonEngine.CommonList.cSubTagCLSQL
    '    Return New cDemandTypes_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    'End Function


    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If WhizGlobal.ParentTagID <> 0 Then

            If Args.LinkName.ToUpper = "SAVE" Then
                Dim objAppResource As WebPages.Template.WhizTemplate
                objAppResource = New WebPages.Template.WhizTemplate
                objAppResource.InitializeResources("AppResources.DemandTypes_CommonPage", "AppResources")

                Args.ToBeInsertedInFunction += "if(confirm('" + objAppResource.GetResourceString("MSG_STAGE_REFLECT") + "')==false)" + vbCrLf
                Args.ToBeInsertedInFunction += "{ return ;}"
                Args.ToBeInsertedInFunction += " enablecontrols();" + vbCrLf
                objAppResource = Nothing
            End If


        End If
    End Sub

    Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If WhizGlobal.ParentTagID = 0 Then

        Else
            Select Case WhizGlobal.TagID

                'Case 2036 ' Nature of Initiative Fields
                '    Cancel = True
            End Select


        End If

    End Sub

    'For Stage level Field Configuration functionality
    Public Overrides Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String
        If WhizGlobal.ParentTagID = 0 Then

        Else
            Select Case WhizGlobal.TagID
                'Case 2036 ' Nature of Initiative Fields
                '    Dim strSQL As String
                '    If CType(ControlsHashTable("Applicable"), String).ToUpper <> "ON" Then
                '        strSQL = " usp_Upd_tbl_CNF_NatureofDemand_StageFields_OnChange '" & PrimaryKey & "',0,'" & CommonFunctions.General.BuildQueryString(Global.UserName) & "'"
                '    Else
                '        strSQL = " usp_Upd_tbl_CNF_NatureofDemand_StageFields_OnChange '" & PrimaryKey & "',1,'" & CommonFunctions.General.BuildQueryString(Global.UserName) & "'"
                '    End If
                '    CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            End Select


        End If
    End Function

End Class
Public Class cDemandTypes_CommonPageSubTagPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    'Constructor
    Public m_HashFixedFields As New Hashtable
    Public m_lngNoofRecords As Long = 0
    Private RowCount As Long = 0
    Private iRC As Long = 0
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
        'If Global.TagID = 2036 Then
        'Dim strSQL As String
        'Dim drIdea As IDataReader
        'Block only those fields for which IsSystemDefined=1
        'strSQL = " Select FieldName From tbl_CNF_NatureofDemandFieldMaster Where IsSystemDefined=1"
        'drIdea = CommonFunctions.Data.GetDataReader(strSQL, True)
        'While (drIdea.Read())
        '    m_HashFixedFields.Add(drIdea("FieldName"), drIdea("FieldName"))
        'End While
        'drIdea.Close()
        'CommonFunctions.Data.DisposeDataReader(drIdea)
        'End If
    End Sub

    
   
    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'MyBase.Before_GridDataRowTD_Print(Cancel, Args, WhizGlobal)
        If WhizGlobal.ParentTagID = 8036 And WhizGlobal.TagID = 3346 Then
            If CType(Args.DataReader("IsActive"), Boolean) = False Then
                If Args.ColumnName.ToUpper = "ROLES" Then
                    Cancel = True
                    Args.StringToBeInserted = "<TD align=left>" + Args.DataReader("StakeHolderNames") + "</TD>"
                End If
                If Args.ColumnName.ToUpper = "APPROVERS" Then
                    Cancel = True
                    Args.StringToBeInserted = "<TD align=left>" + Args.DataReader("Approvers") + "</TD>"
                End If
            End If
        End If
    End Sub

    'Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal global As WebPages.Template.IGlobal)
    '    If Args.DataField.ToUpper = "APPLICABLE" And global.TagID = 2036 Then
    '        Cancel = True
    '        Dim blnDefault As Boolean = False
    '        If (m_HashFixedFields(Args.DataReader("FieldName")) = Args.DataReader("FieldName")) Then
    '            blnDefault = True
    '        End If
    '        Args.StringToBeInserted = "<TD   align=Centre >" + vbCrLf
    '        Args.StringToBeInserted += CommonFunction.HTMLControls.DrawCheckBox("chkApplicable", "chkApplicable", , IIf(blnDefault = True, True, CType(Args.DataReader("Applicable"), Boolean)), CType(Args.DataReader("NatureofDemandFieldConfigID"), String), blnDefault, "Onclick='Javascript:Applicable_Click(id,value)'", True)
    '        Args.StringToBeInserted += "</Td>"
    '    End If
    '    If Args.DataField.ToUpper = "MANDATORY" And global.TagID = 2036 Then
    '        Cancel = True
    '        Dim blnDefault As Boolean = False
    '        If (m_HashFixedFields(Args.DataReader("FieldName")) = Args.DataReader("FieldName")) Then
    '            blnDefault = True
    '        End If
    '        If (Not Args.DataReader("Applicable")) Then
    '            blnDefault = True
    '        End If
    '        Args.StringToBeInserted = "<TD   align=Centre >" + vbCrLf
    '        Args.StringToBeInserted += CommonFunction.HTMLControls.DrawCheckBox("chkMandatory", "chkMandatory", , CType(Args.DataReader("Mandatory"), Boolean), CType(Args.DataReader("NatureofDemandFieldConfigID"), String), blnDefault, , True)
    '        Args.StringToBeInserted += "</Td>"
    '    End If
    '    If Args.DataField.ToUpper = "ISEDITABLE" And global.TagID = 2036 Then
    '        Cancel = True
    '        Dim blnDefault As Boolean = False
    '        If (Not Args.DataReader("Applicable")) Then
    '            blnDefault = True
    '        End If
    '        If (Args.DataReader("FieldName").ToString).ToUpper = "INITIATIVE TITLE" Or (Args.DataReader("FieldName").ToString).ToUpper = "INITIATIVE CODE" Then
    '            blnDefault = True
    '        End If

    '        Args.StringToBeInserted = "<TD   align=Centre >" + vbCrLf
    '        Args.StringToBeInserted += CommonFunction.HTMLControls.DrawCheckBox("chkEditable", "chkEditable", , CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("IsEditable"), "0"), Boolean), CType(Args.DataReader("NatureofDemandFieldConfigID"), String), blnDefault, , True)
    '        Args.StringToBeInserted += "</Td>"
    '    End If
    '    'If global.ParentTagID <> 0 And global.TagID = 30029 Then

    '    '    Select Case Args.DataField.ToUpper
    '    '        Case "BUSINESSGROUPID"
    '    '            Cancel = True
    '    '            Args.StringToBeInserted = "<TD   style='text-align:centre' >" + vbCrLf
    '    '            Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawComboBox("cboBG" + RowCount.ToString, "usp_Sel_tbl_CNF_BusinessGroup 1", 150, CommonFunction.Data.CheckIsDBNull(Args.DataReader("BusinessGroupID")).ToString, "onchange='javascript:BusinessGroup_Change(0," + RowCount.ToString + ")'", True, True, , True, , , )
    '    '            Args.StringToBeInserted += "</Td>"

    '    '        Case "LOCATIONID"
    '    '            Cancel = True
    '    '            Args.StringToBeInserted = "<TD   style='text-align:centre' >" + vbCrLf
    '    '            Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawComboBox("cboOU" + RowCount.ToString, "usp_Sel_PM_LocationList " + CommonFunction.Data.CheckIsDBNull(Args.DataReader("LocationID")).ToString, 150, CommonFunction.Data.CheckIsDBNull(Args.DataReader("LocationID")).ToString, "onchange='javascript:OUPool_OnChange(this,0," + RowCount.ToString + ")'", True, True, , , , , )
    '    '            Args.StringToBeInserted += "</Td>"
    '    '        Case "DELIVERYUNITID"
    '    '            Cancel = True
    '    '            Args.StringToBeInserted = "<TD  style='text-align:centre' >" + vbCrLf
    '    '            Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawComboBox("cboDU" + RowCount.ToString, "usp_Sel_tbl_PM_ResourcePool " + CommonFunction.Data.CheckIsDBNull(Args.DataReader("DeliveryUnitID")).ToString, 150, CommonFunction.Data.CheckIsDBNull(Args.DataReader("DeliveryUnitID")).ToString, "onchange='javascript:DUPool_OnChange(this,0," + RowCount.ToString + ")'", True, True, , , , , )
    '    '            Args.StringToBeInserted += "</Td>"
    '    '        Case "DELIVERYTEAMID"
    '    '            Cancel = True
    '    '            Args.StringToBeInserted = "<TD   style='text-align:centre' >" + vbCrLf
    '    '            Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawComboBox("cboDT" + RowCount.ToString, "usp_Sel_tbl_PM_GroupMaster " + CommonFunction.Data.CheckIsDBNull(Args.DataReader("DeliveryTeamID")).ToString, 150, CommonFunction.Data.CheckIsDBNull(Args.DataReader("DeliveryTeamID")).ToString, , True, True, , , , , )
    '    '            Args.StringToBeInserted += "</Td>"
    '    '        Case "PROJECTTYPEID"
    '    '            Cancel = True
    '    '            Args.StringToBeInserted = "<TD   style='text-align:centre' >" + vbCrLf
    '    '            Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawComboBox("cboPT" + RowCount.ToString, "usp_Sel_tbl_PRS_ProjectTypes", 150, CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectTypeID")).ToString, , True, True, , , , , )
    '    '            Args.StringToBeInserted += "</Td>"

    '    '        Case "IMAGE1"
    '    '            Cancel = True
    '    '            Args.StringToBeInserted = "<TD  style='text-align:centre' >" + vbCrLf
    '    '            Args.StringToBeInserted += "</Td>"
    '    '    End Select
    '    'End If


    'End Sub


    Protected Overrides Sub Finalize()
        MyBase.Finalize()
        m_HashFixedFields.Clear()
        m_HashFixedFields = Nothing
    End Sub



    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'If global.ParentTagID <> 0 And global.TagID = 30029 Then
        '    If Args.ColumnName.ToUpper = "ADD RECORD" Then
        '        Args.ColumnName = ""
        '    End If
        'End If
    End Sub

    'Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal global As WebPages.Template.IGlobal)
    '    Dim m_SBHTML As New System.Text.StringBuilder
    '    m_SBHTML.Append("<tr class=clsTREven id=""TRAdd"" >" + vbCrLf)
    '    m_SBHTML.Append("<td width=10px ALIGN='center' colspan='7'>" + vbCrLf)
    '    m_SBHTML.Append("<A href=""Javascript:ShowHide_SectionTR()""" + vbCrLf)
    '    m_SBHTML.Append(")""><Img Border=0 id=tdShowHide Src='../../Images/right.gif' title='Add New Record'></A>" + vbCrLf)
    '    m_SBHTML.Append("</td>" + vbCrLf)
    '    m_SBHTML.Append("</tr>" + vbCrLf)
    '    Args.ToBeInserted = m_SBHTML.ToString
    '    m_SBHTML = Nothing
    'End Sub


    'Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal global As WebPages.Template.IGlobal)
    '    If global.ParentTagID <> 0 And global.TagID = 30029 Then
    '        m_lngNoofRecords = Args.RecordCount
    '        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtHidRC", "txtHidRC", , , , m_lngNoofRecords.ToString, , , , , , True, , True))
    '    End If
    'End Sub


    'Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal global As WebPages.Template.IGlobal)
    '    If global.ParentTagID <> 0 And global.TagID = 30029 Then
    '        RowCount += 1
    '        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtHid" + Args.PrimaryKeyName + RowCount.ToString, "txtHidPK" + Args.PrimaryKeyName + RowCount.ToString, , , , CommonFunction.Data.CheckIsDBNull(Args.DataReader("NOIMappingID")).ToString, , , , , , True, , True))
    '    End If
    'End Sub


End Class

Public Class cDemandTypes_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cDemandTypes_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

End Class
Public Class cDemandTypes_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
'Public Class cDemandTypes_CommonPagePlotControls
'    Inherits CommonEngine.CommonPage.cPlotControls
'    Public m_HashFixedFields As New Hashtable
'    Public Sub New(ByVal Global As WebPages.Template.IGlobal)
'        ''Assign the Parameter values to the local variables
'        Call MyBase.New(Global)
'        'Dim strSQL As String
'        'Dim drIdea As IDataReader
'        '' Block only those fields for which IsSystemDefined=1
'        'strSQL = " Select FieldName From tbl_CNF_NatureofDemandFieldMaster Where IsSystemDefined=1"
'        'drIdea = CommonFunctions.Data.GetDataReader(strSQL, True)
'        'While (drIdea.Read())
'        '    m_HashFixedFields.Add(drIdea("FieldName"), drIdea("FieldName"))
'        'End While
'        'drIdea.Close()
'        'CommonFunctions.Data.DisposeDataReader(drIdea)
'    End Sub


'    'Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
'    '    If (global.ParentTagID <> 0 And global.TagID = 2036) Then 'Nature of initiative fields
'    '        Select Case Args.ControlName.ToUpper
'    '            Case "APPLICABLE"
'    '                Dim blnDefault As Boolean = True
'    '                If (m_HashFixedFields(drControls("FieldName")) = drControls("FieldName")) Then
'    '                    blnDefault = False
'    '                End If
'    '                Args.Editable = blnDefault
'    '            Case "MANDATORY"
'    '                Dim blnDefault As Boolean = True
'    '                If (m_HashFixedFields(drControls("FieldName")) = drControls("FieldName")) Then
'    '                    blnDefault = False
'    '                End If
'    '                If (Not drControls("Applicable")) Then
'    '                    blnDefault = False
'    '                End If
'    '                Args.Editable = blnDefault
'    '            Case "ISEDITABLE"
'    '                Dim blnDefault As Boolean = True
'    '                If (m_HashFixedFields(drControls("FieldName")) = drControls("FieldName")) Then
'    '                    blnDefault = False
'    '                End If
'    '                If (Not drControls("Applicable")) Then
'    '                    blnDefault = False
'    '                End If
'    '                Args.Editable = blnDefault


'    '        End Select
'    '    End If
'    'End Sub

'    Protected Overrides Sub Finalize()
'        MyBase.Finalize()
'        m_HashFixedFields.Clear()
'        m_HashFixedFields = Nothing
'    End Sub
'End Class
Public Class cDemandTypes_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        'MyBase.Before_PlotControl(Cancel, Args, WhizGlobal, drControls, InsertBeforeControl)
        Dim strSQL As String
        Dim blnIsActive As Boolean

        If WhizGlobal.TagID = 8036 Then
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQL = "SELECT IsActive FROM tbl_IM_ProjectNatureOfDemand WHERE ProjectNatureOfDemandID=" + drControls("ProjectNatureofDemandID").ToString
            strSQL = "usp_sel_tbl_IM_ProjectNatureOfDemand_IsActive " + drControls("ProjectNatureofDemandID").ToString
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            blnIsActive = CommonFunction.Data.GetDataScalar(strSQL, True)
            If blnIsActive = False Then
                If Args.ControlName.ToUpper = "ISACTIVE" Or Args.ControlName.ToUpper = "NATUREOFDEMAND" Then
                    Args.DisableInEditMode = True
                End If
            End If
        End If
    End Sub

End Class