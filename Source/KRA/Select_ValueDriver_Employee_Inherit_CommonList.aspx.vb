Imports CommonEngines.General.cEventHandlers
Public Class Select_ValueDriver_Employee_Inherit_CommonList
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
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "Select_ValueDriver_Employee_Inherit_CommonList.aspx"
        'MyBase.strFormPage = "CommonPage.aspx"
        'MyBase.strFormPage = "Select_ValueDriver_Employee_Inherit_CommonList.aspx"
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

    'Added by   : MANOJ DAGDE
    'Date       : 12 Oct 2007
    'Description : To fetch selected value drivers from Value Drivers list and Assign it to selected Employee.
    '===========================================================================================================

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        'get reference of delete checkbox
        Dim intEmployeeID As Integer
        Dim intQuarterID As Integer

        If HttpContext.Current.Request.QueryString("select") = "True" Then
            Dim ValDrvID() As String
            Dim i As Integer
            Dim strRoleID() As String
            Dim strRequiredIDArray As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"))
            Dim STR() As String
            Dim strQuarterID() As String

            'Take Value Driver's IDs into array in comma seperated format
            ValDrvID = strRequiredIDArray.Split(Convert.ToChar(","))

            STR = HttpContext.Current.Request.QueryString.GetValues("UniqueID")
            strQuarterID = HttpContext.Current.Request.QueryString.GetValues("QuarterID")

            intEmployeeID = Convert.ToInt32(STR(0))
            intQuarterID = Convert.ToInt32(strQuarterID(0))

            'For loop to pass value drivers ids from ValDrvID array to selected RoleID
            For i = 0 To ValDrvID.Length - 1

                'Insert role,value drivers in role kra table
                Dim strSQL As String
                If ValDrvID(i) <> "" Then
                    strSQL = "usp_INS_tbl_KRA_EmployeeKRA " & intEmployeeID & "," & Convert.ToInt32(ValDrvID(i)) & "," & intQuarterID & ",'" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'"
                    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                End If


                strSQL = Nothing
            Next

            'To Refresh the parent page with selected value drivers and close the child window 
            CommonFunction.General.WriteHTML(vbCrLf + "<Script language=javascript>")
            CommonFunction.General.WriteHTML(vbCrLf + "   refreshParent('frmCommonPage','KRA_Employee_Inherit_CommonPage.aspx','../../Source/KRA/KRA_Employee_Inherit_CommonPage.aspx');")
            CommonFunction.General.WriteHTML(" window.close();")
            CommonFunction.General.WriteHTML("</SCRIPT>")
        End If
        '==========================================================================================================
        'Ended by   : MANOJ DAGDE
        'Date       : 12 Oct 2007
        '===========================================================================================================
    End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
    End Function
    Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    End Sub

    '==========================================================================================================

    'Added by   : MANOJ DAGDE
    'Date       : 12 Oct 2007
    'Description : To Display Link
    '===========================================================================================================

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim intEmployeeID As Integer

        Dim intQuarterID As Integer
        Select Case Args.ClientSideFunctionName
            Case "ADD_NEW"
                Cancel = True

                'iF SAVEVALUE Link 
            Case "SAVEVALUE"
                If Args.ClientSideFunctionName = "SAVEVALUE" Then
                    Dim STR As String
                    Dim strQuarterID As String
                    'CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("UniqueID"))
                    STR = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("UniqueID"))
                    strQuarterID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("QuarterID"))

                    intEmployeeID = Convert.ToInt32(STR)
                    intQuarterID = Convert.ToInt32(strQuarterID)

                    Args.ToBeInsertedInFunction = "var objCompanyName = GetObjectReference('frmCommonList','ValueDriverID');"
                    Args.ToBeInsertedInFunction += "var objChkDelete = GetObjectReference('frmCommonList','chkDelete',true);"
                    Args.ToBeInsertedInFunction += "var icount;"
                    Args.ToBeInsertedInFunction += "for(icount=0;icount<objChkDelete.length;icount++)  {"
                    Args.ToBeInsertedInFunction += " if(objChkDelete[icount].checked==true)   break; }"
                    Args.ToBeInsertedInFunction += "if(icount==objChkDelete.length) {"
                    Args.ToBeInsertedInFunction += "alert('Please select at least one record');  return;  }"
                    Args.ToBeInsertedInFunction += "objfrm.action=""../KRA/Select_ValueDriver_Employee_Inherit_CommonList.aspx?MasterTagID=3878&UniqueID=" & intEmployeeID & "&QuarterID=" & intQuarterID & "&select=True"";"
                    'Args.ToBeInsertedInFunction += "objfrm.action=""../KRA/SelectValueDriver_CommonList.aspx?MasterTagID=30063&Action=save"";"
                    Args.ToBeInsertedInFunction += "objfrm.submit(); return;"
                End If
        End Select

        '==========================================================================================================
        'Ended by   : MANOJ DAGDE
        'Date       : 12 Oct 2007
        '===========================================================================================================


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

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Dim objGrid As New Display_Grid(MyBase.m_objGlobal)

        Return objGrid

    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New SelectValueDriver_Employee_CommonListCLSQL(MyBase.m_objGlobal)
    End Function
End Class

'=====================================================================
' Class Name	        :	SelectValueDriver_Employee_CommonListCLSQL
' Purpose				:	To show ValueDriver already assign to Employee 
' Description			:	as above
' Assumptions			:	None
' Dependencies			:	None
' Author				:	MANOJ DAGDE
' Created				:	19-oct-2007
' Revisions				:	
'=====================================================================

#Region "Grid_Class"
Public Class SelectValueDriver_Employee_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Use the Stored Procedure instead of the dynamic SQL for these web forms to avoid the
        Args.GridSQL = "usp_Sel_tbl_KRA_ValueDriver_Master_ForEmployee  " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("UniqueID"))
    End Sub

End Class
#End Region



'=====================================================================
' Class Name	        :	Display_Grid
' Purpose				:	To show ValueDriver List 
' Description			:	as above
' Assumptions			:	None
' Dependencies			:	None
' Author				:	MANOJ DAGDE
' Created				:	16-oct-2007
' Revisions				:	
'=====================================================================

#Region "Grid_Class"

'This class methods are overrided to call grid related events

Class Display_Grid

    Inherits CommonEngine.CommonList.cPlotGrid

#Region "Variables"
    'Public EmployeeID As Integer = 211
    'Public QuarterID As Integer = 4
#End Region

    Public Sub New(ByVal Global1 As WebPages.Template.IGlobal)

        Call MyBase.New(Global1)

    End Sub



    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)

        'Dim ValDrvID() As String
        '' Dim dr As IDataReader
        'Dim strSql As String = "Select ValueDriverID from v_tbl_KRA_EmployeeKRA where EmployeeID=" & EmployeeID & " and QuarterID=" & QuarterID
        '' dr = CommonFunction.Data.GetDataReader("Select ValueDriverID from v_tbl_KRA_EmployeeKRA where EmployeeID=" & EmployeeID & " and QuarterID=" & QuarterID, True)
        'Dim str As Object = CommonFunction.Data.GetDataScalar(strSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        'ValDrvID = str.ToString.Split(Convert.ToChar(","))


    End Sub

    Protected Overrides Sub After_GridDataRowTD_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

        'MyBase.After_GridDataRowTD_Print(Args, WhizGlobal)

    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)



    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

        If UCase(Args.ColumnName) = "SELECT" Then
            If Args.DataReader("IsAssignedToRole").ToString = "1" Then
                Args.IsCheckBoxDisabled = True
                Args.IsSelected = True
            End If
        End If

    End Sub

    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)



    End Sub

End Class

#End Region

