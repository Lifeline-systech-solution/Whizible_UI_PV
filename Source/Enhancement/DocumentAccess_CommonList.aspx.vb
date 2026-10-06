Imports CommonEngines.General.cEventHandlers
Imports CommonFunctions
Imports Whizible
Public Class DocumentAccess_CommonList
    Inherits CommonList
    Protected m_strAction As String
    Protected strList As String
    Protected strRole As String
    Protected strDocument As String

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "DocumentAccess_CommonList.aspx"
        MyBase.strFormPage = "DocumentAccess_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"

        Dim strSql As String
        m_strAction = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"), "")
        If m_strAction.ToUpper = "SAVE" Then
            strList = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkSelectAccess"), "")
            If strList = "" Then
                strList = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), "")
            End If
            strRole = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RoleID"), "")
            strDocument = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("DocumentName"), "")

            If strRole.ToString() <> "" Then
                CommonFunctions.Data.InsertOrUpdateData("Exec usp_Ins_tbl_PM_Documents  '" & strList.ToString & "'," & strRole & ",'" & strDocument & "'", True)
            End If
            'Save_onClick()
        End If
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cDocumentAccess_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
    End Function


    Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    End Sub

    Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    End Sub

    Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    End Sub

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

    End Sub

    Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)

    End Sub

    Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    End Sub


    Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub

    Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub

    Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub

    Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub

    Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub

    Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub

    Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub

    Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub
    Public Sub Save_onClick()
        Dim strDocumentIds As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkSelectAccess"), "")
        If strDocumentIds = "" Then
            strDocumentIds = "0"
        End If
        Dim strSQL As String
        Dim intRowCount As Integer = 0
        Dim strRoleID As String = Request.QueryString("RoleID")
        Dim Isallowed As Integer
        Dim strSQLQuery As New System.Text.StringBuilder

        ' If strDocumentIds <> "" Then
        Dim strArray() As String = strDocumentIds.Split(",")

        ' strSQLQuery.Append(strArray(intRowCount))

        For intRowCount = 0 To strArray.Length - 1
            'strRoleID = HttpContext.Current.Request.Form("HDN_TXT_UNCHEKED" & strArray(intRowCount))
            Isallowed = HttpContext.Current.Request.Form("chkSelectAccess1_" & strArray(intRowCount))

            strSQLQuery = New StringBuilder()
            If intRowCount = strArray.Length - 1 Then
                strSQLQuery.Append("Exec usp_InsertDocumentPrevilagesAccess ")
                strSQLQuery.Append(strArray(intRowCount))
                strSQLQuery.Append("," & strRoleID & ",'" & strDocumentIds & "',1") 'asdfsdf
            Else
                strSQLQuery.Append("Exec usp_InsertDocumentPrevilagesAccess ")
                strSQLQuery.Append(strArray(intRowCount))
                strSQLQuery.Append("," & strRoleID & ",'" & strDocumentIds & "',0") 'asdfsdf

            End If


            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)

        Next

    End Sub
    'Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
    '    Return New PlotDocumentAccess_cCLSQL1(MyBase.m_objGlobal)
    'End Function
End Class
Public Class cDocumentAccess_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public m_StrUnCheckMasterTagID As String = ""
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
         Select WhizGlobal.TagID
            Case 20180
                Dim ChkStatus As Integer
                If Args.ColumnName = "IsAllowedToView" Then

                    'Cancel = True
                    'Args.StringToBeInserted = "<td  align=center><Input type=checkbox name='chkSelectAccess' checked id='chkSelectAccess_" + Args.DataReader("DocumentId").ToString + "' class='clsCheckBox' value=" + Args.DataReader("DocumentId").ToString + " >"
                    ' Args.StringToBeInserted &= "</TD>"
                    Dim strRoleID As String = HttpContext.Current.Request.QueryString("RoleID").ToString()
                    Dim strSQL As String = "usp_sel_tbl_PM_Documents_IsAccessible " + strRoleID + "," + Args.DataReader("DocumentID").ToString
                    Dim strResult As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetSQLDataScalar(strSQL))

                    ChkStatus = CommonFunction.Data.CheckIsDBNull(Args.DataReader("IsAllowedToView"), 0)
                    If strResult = "True" Then
                        'Args.StringToBeInserted = "<td  align=center><Input type=checkbox name='chkSelectAccess' checked='yes' id='chkSelectAccess_" + Args.DataReader("DocumentId").ToString + "' class='clsCheckBox' value=" + Args.DataReader("DocumentId").ToString + " >"
                        'Args.StringToBeInserted &= "</TD>"
                        Args.IsSelected = True

                    Else
                        'Args.StringToBeInserted = "<td  align=center><Input type=checkbox name='chkSelectAccess' id='chkSelectAccess_" + Args.DataReader("DocumentId").ToString + "' class='clsCheckBox' value=" + Args.DataReader("DocumentId").ToString + " >"
                        'Args.StringToBeInserted &= "</TD>"
                        Args.IsSelected = False
                    End If
                    'If (ChkStatus = -1) Then
                    '    Args.StringToBeInserted = "<td  align=center><Input type=checkbox name='chkSelectAccess' checked='yes' id='chkSelectAccess_" + Args.DataReader("DocumentId").ToString + "' class='clsCheckBox' value=" + Args.DataReader("DocumentId").ToString + " >"
                    '    Args.StringToBeInserted &= "</TD>"
                    'Else
                    '    Args.StringToBeInserted = "<td  align=center><Input type=checkbox name='chkSelectAccess' id='chkSelectAccess_" + Args.DataReader("DocumentId").ToString + "' class='clsCheckBox' value=" + Args.DataReader("DocumentId").ToString + " >"
                    '    Args.StringToBeInserted &= "</TD>"
                    'End If
                End If
        End Select
    End Sub

End Class
'Added By Chakshuta H on 9th-July-2015 Purpose::list should show only list of logged in user's employee 
'Public Class PlotDocumentAccess_cCLSQL1
'    Inherits CommonEngine.CommonList.cCLSQL
'    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
'        Call MyBase.New(WhizGlobal)
'    End Sub
'    Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
'        Dim intRoleID As String
'        intRoleID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RoleID"), "")
'        'intRoleID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Session("intPostID"), ""), "")

'        If intRoleID <> "" Then
'            Args.GridSQL = "usp_Sel_PlotAllowedToViewGrid " & intRoleID.ToString & ""
'        End If


'    End Sub

'End Class
'End Of Addition By Chakshuta H on 9th-July-2015 Purpose::list should show only list of logged in user's employee 