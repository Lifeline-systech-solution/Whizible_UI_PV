Imports CommonEngines.General.cEventHandlers
Public Class IB_CustomField_RoleAccess_CommonList
    Inherits CommonList

    Private m_strAction As String
    Protected m_CustomFieldID As String
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
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cIB_CustomField_RoleAccess_CommonList_PlotGrid(MyBase.m_objGlobal)
    End Function
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) 'Handles MyBase.Load
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "IB_CustomField_RoleAccess_CommonList.aspx"
        'Put user code to initialize the page here
        m_CustomFieldID = CType(Request.QueryString("CustomFieldID"), String)
        If Not CType(Request.QueryString("Action"), String) Is Nothing Then
            m_strAction = CType(Request.QueryString("Action"), String)
        Else
            m_strAction = ""
        End If

        If m_strAction.ToUpper = "SAVE" Then
            saveRoleAccess()
        End If

        MyBase.Page_Load(sender, e)
    End Sub
#End Region

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal whizglobal As WebPages.Template.IGlobal)
        If Args.ClientSideFunctionName.ToUpper = "CLOSE" Then
            Args.ToBeInsertedInFunction = "window.open('commonList.aspx?MasterTagID=5052&close=1','_self');"
            Args.ToBeInsertedInFunction += "window.close(); return;"
        End If
        If Args.ClientSideFunctionName.ToUpper = "SAVECLICK" Then
            Args.ToBeInsertedInFunction = " var objForm;" + vbCrLf
            Args.ToBeInsertedInFunction += " objForm = GetFormReference('frmCommonList');" + vbCrLf
            'Modified by vidyak on 30 Aug 2010 --TAGID 20012 Changed to 2626
            Args.ToBeInsertedInFunction += " objForm.action='IB_CustomField_RoleAccess_CommonList.aspx?CustomFieldID=" + m_CustomFieldID + "&MasterTagId=2626&Action=Save'" + vbCrLf
            Args.ToBeInsertedInFunction += " objForm.submit();" + vbCrLf
            Args.ToBeInsertedInFunction += " return;" + vbCrLf
        End If

    End Sub
    Public Class cIB_CustomField_RoleAccess_CommonList_PlotGrid
        Inherits CommonEngine.CommonList.cPlotGrid
        Public Sub New(ByVal whizGlobal As WebPages.Template.IGlobal)
            Call MyBase.New(whizGlobal)
        End Sub


        Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal whizglobal As WebPages.Template.IGlobal)
            If Args.ColumnName.ToUpper = "ROLE" Then
                'Do not show link for the description column
                Args.EnableLink = False
            ElseIf Args.ColumnName.ToUpper = "SELECT" Then
                Dim strCustomFieldID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("CustomFieldID"), "")
                If strCustomFieldID = "" Then
                    strCustomFieldID = CType(HttpContext.Current.Session("CustomFieldID"), String)
                End If
                'If the Access is set for the Project Role, then show the status as SELECTED
                Dim strSQL As String = "usp_sel_tbl_IB_CustomFields_RoleSecurity_IsApplicable " + whizglobal.ProjectID.ToString + "," + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Role"), "0").ToString + "," + strCustomFieldID.Trim
                Dim strResult As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetSQLDataScalar(strSQL))
                If strResult = "1" Then Args.IsSelected = True
            End If
        End Sub

        Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal whizglobal As WebPages.Template.IGlobal)
            Dim strUniqueID As String
            strUniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("CustomFieldID"))
            If strUniqueID = "" Then
                strUniqueID = CType(HttpContext.Current.Session("CustomFieldID"), String)
            Else
                HttpContext.Current.Session.Remove("CustomFieldID")
                HttpContext.Current.Session.Add("CustomFieldID", strUniqueID)
            End If
            If CommonFunctions.General.CheckIsNothing(strUniqueID, "") <> "" Then

                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("CustomFieldID", "CustomFieldID", , , , strUniqueID.Trim, , , , , , True, , True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
            End If
        End Sub
    End Class

    Private Sub saveRoleAccess()
        Dim strSP As String = ""
        'first delete all the entries for current project and custom field ID, then insert new 
        strSP = "usp_del_tbl_IB_CustomFields_RoleSecurity " + CType(HttpContext.Current.Session("intProjectID"), String) + "," + m_CustomFieldID.Trim + ",'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("PagingAlphabet"), "-1")) + "'"
        CommonFunctions.Data.InsertOrUpdateData(strSP, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        'insert new records for the selected custom field for current project and RoleIDs
        Dim strRoles As String() = Split(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")), ",")
        Dim strRoleID As String
        For Each strRoleID In strRoles
            If strRoleID <> "" Then
                strSP = "usp_ins_tbl_IB_CustomFields_RoleSecurity " + CType(HttpContext.Current.Session("intProjectID"), String) + "," + m_CustomFieldID.Trim + "," + strRoleID.Trim
                CommonFunctions.Data.InsertOrUpdateData(strSP, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            End If
        Next
    End Sub

End Class
