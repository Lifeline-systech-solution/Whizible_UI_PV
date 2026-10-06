Imports CommonEngines.General.cEventHandlers
Public Class SelectValueDriver_CommonList
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
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "SelectValueDriver_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
#End Region


    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function
    '==========================================================================================================
    'Added by   : ShraddhaJ
    'Date       : 11 Oct 2007
    'Description : To fetch selected value drivers from Value Drivers list and Assign it to selected Role.
    '===========================================================================================================
    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim intRoleID As Integer
        Dim intValueDriverID As Integer
        Dim str As String
        str = Request.Form("chkDelete")
        If Not HttpContext.Current.Request.QueryString("UniqueID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("UniqueID") <> "" Then

            'strProgramID = CommonFunctions.General.CheckIsNothing(Request("ProgramID"), "0")

            'PageListPreRender += "<input type='hidden' id='ProgramID' name = 'ProgramID' value='" + strProgramID + "'/>"

            CommonFunction.General.WriteHTML("<Input type=hidden name=UniqueID value=" + HttpContext.Current.Request.QueryString("UniqueID") + ">")

        ElseIf Not HttpContext.Current.Request.Form("UniqueID") Is Nothing AndAlso HttpContext.Current.Request.Form("UniqueID") <> "" Then

            CommonFunction.General.WriteHTML("<Input type=hidden name=UniqueID value=" + HttpContext.Current.Request.Form("UniqueID") + ">")

        End If

        'If "Select" Column is having checked values
        If HttpContext.Current.Request.QueryString("select") = "True" Then
            Dim ValDrvID() As String
            Dim i As Integer
            Dim strRoleID() As String
            Dim strRequiredIDArray As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"))

            'Take Value Driver's IDs into array in comma seperated format
            ValDrvID = strRequiredIDArray.Split(Convert.ToChar(","))

            'Pass roleId in strRoleID() array and then convert it to integer
            strRoleID = HttpContext.Current.Request.QueryString.GetValues("UniqueID")
            intRoleID = Convert.ToInt32(strRoleID(0))

            'For loop to pass value drivers ids from ValDrvID array to selected RoleID
            For i = 0 To ValDrvID.Length - 1


                'Insert role,value drivers in role kra table
                Dim strSQL As String
                strSQL = "usp_INS_tbl_KRA_RoleKRA " & intRoleID & "," & Convert.ToInt32(ValDrvID(i)) & ",'" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'"
                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                strSQL = Nothing
            Next
            'To Refresh the parent page with selected value drivers and close the child window 
            CommonFunction.General.WriteHTML(vbCrLf + "<Script language=javascript>")
            CommonFunction.General.WriteHTML(vbCrLf + "   refreshParent('frmCommonPage','KRA_Role_Master_CommonPage.aspx','../../Source/KRA/KRA_Role_Master_CommonPage.aspx');")
            CommonFunction.General.WriteHTML(" window.close();")
            CommonFunction.General.WriteHTML("</SCRIPT>")
        End If
        '==========================================================================================================
        'Ended by   : ShraddhaJ
        'Date       : 12 Oct 2007
        '===========================================================================================================
    End Function


    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
    End Function


    Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Added by : ShraddhaJ
        'Date : 12 Oct 2007
        'Description : To Save selected(Checked) value drivers and pass it to parent page.
        '----------------------------------------------------------------------------------
        'Dim intRoleID As Integer
        Select Case Args.SystemLinkType.ToUpper
            Case "ADD_NEW"
                Cancel = True
        End Select
        'iF SAVEVALUDVR Link 
        ' Dim intRoleID As Integer
        'Dim STR As String
        'STR = HttpContext.Current.Request("UniqueID").ToString
        ' intRoleID = Convert.ToInt32(STR)
        'Added in Page_load
        ' CommonFunctions.HTMLControls.DrawTextBox("UniqueID", "UniqueID", , 35, , STR, "Right", , , , , True, , True)
        '  End If

        '-------------------------------------------------------------------------------------
        'This Code can be written in "Insert Dynamic Function" property in Whiz Application.
        'Case "SAVEVALUDVR"
        If Args.ClientSideFunctionName = "SAVEVALUDVR" Then
            Dim strRoleID As String
            strRoleID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("UniqueID"))
            Args.ToBeInsertedInFunction = "var objCompanyName = GetObjectReference('frmCommonList','ValueDriverID');"
            Args.ToBeInsertedInFunction += "var objChkDelete = GetObjectReference('frmCommonList','chkDelete',true);"
            Args.ToBeInsertedInFunction += "var icount;"
            Args.ToBeInsertedInFunction += "for(icount=0;icount<objChkDelete.length;icount++)  {"
            Args.ToBeInsertedInFunction += " if(objChkDelete[icount].checked==true)   break; }"
            Args.ToBeInsertedInFunction += "if(icount==objChkDelete.length) {"
            Args.ToBeInsertedInFunction += "alert('Please select at least one record');  return;  }"
            Args.ToBeInsertedInFunction += "objfrm.action=""../KRA/SelectValueDriver_CommonList.aspx?MasterTagID=3879&UniqueID=" & strRoleID & "&select=True"";"
            Args.ToBeInsertedInFunction += "objfrm.submit(); return;"
        End If
        'Ended by : ShraddhaJ
        'Date : 12 Oct 2007
        '----------------------------------------------------------------------------------
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
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New SelectValueDriver_CommonListCLSQL(MyBase.m_objGlobal)
    End Function


    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New SelectValueDriver_Grid(MyBase.m_objGlobal)
    End Function
End Class

Public Class SelectValueDriver_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Use the Stored Procedure instead of the dynamic SQL for these web forms
        ' to avoid the already selected value drivers and show it in the form of disabled and checked.
        Args.GridSQL = "usp_Sel_tbl_KRA_ValueDriver_Master_ForRole " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("UniqueID"))
    End Sub

End Class

Public Class SelectValueDriver_Grid
    'Added By : UmeshJ
    'Date : 18 Oct 2007
    'Newly added class to plot the grid for value driver dynamically.
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub
    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Added By : UmeshJ
        'Date : 18 Oct 2007
        '"IsAssignedToRole" is used to indicate that whether the value driver is already assigned to selected role or not.
        ' 1 indicates already selected value driver otherwise it is 0.
        If UCase(Args.ColumnName) = "SELECT" Then

            If Args.DataReader("IsAssignedToRole").ToString = "1" Then
                Args.IsCheckBoxDisabled = True

                Args.IsSelected = True
            End If
        End If
    End Sub
End Class
