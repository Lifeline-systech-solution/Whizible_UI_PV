Imports CommonEngines.General.cEventHandlers
Public Class cKRA_Employee_Inherit_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cKRA_Employee_Inherit_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cKRA_Employee_Inherit_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cKRA_Employee_Inherit_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class KRA_Employee_Inherit_CommonPage
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
        MyBase.strListPage = "KRA_Employee_Inherit_CommonList.aspx"
        MyBase.strFormPage = "KRA_Employee_Inherit_CommonPage.aspx"
        MyBase.Page_Load(sender, e)
    End Sub
    Protected Overrides Sub After_ExecutingAction(ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)
        Select Case UCase(Trim(Args.ClientSideFunctionName & ""))
            Case "SAVEVALUEDRIVER"
                Dim blnUseSQL As Boolean = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
                ' Dim arrValueDriver() As String = Split(Request.Form("ValueDriver"), ",")
                Dim arrEmployeeKRAID() As String = Split(Request.Form("hdEmployeeKRAID"), ",")
                ' Dim arrValueDriverID() As String = Split(Request.Form("ValueDriverID"), ",")
                Dim arrWeight() As String = Split(Request.Form("Weight"), ",")
                'Dim arrRuleDescription() As String = Split(Request.Form("RuleDescription"), ",")
                Dim intUBound As Integer = UBound(arrEmployeeKRAID)
                Dim intCount As Integer
                ' Dim strEmployeeID As String = Request.Form("EmployeeID").ToString
                'Dim strQuarterID As String = Request.Form("QuarterID").ToString

                Dim sbSQL As New System.Text.StringBuilder
                'Update the Computation Rule Details
                For intCount = 0 To intUBound
                    If arrEmployeeKRAID(intCount) <> "" Then
                        sbSQL.Append("EXEC [dbo].usp_Upd_tbl_KRA_EmployeeKRA " + arrEmployeeKRAID(intCount) + "," + arrWeight(intCount) + ",'" + CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) + "'" + vbCrLf)
                    End If
                Next
                'sbSQL.Append("EXEC [dbo].usp_Upd_tbl_KRA_ComputationRule_Master " + strRuleID + ",'" + CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) + "'")
                CommonFunctions.Data.InsertOrUpdateData(sbSQL.ToString, blnUseSQL)
                sbSQL = Nothing
        End Select
    End Sub


    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cKRA_Employee_Inherit_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cKRA_Employee_Inherit_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cKRA_Employee_Inherit_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cKRA_Employee_Inherit_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function
    Protected Overloads Function InitSubTagCLSQL() As CommonEngine.CommonList.cSubTagCLSQL
        Return New cKRA_Employee_Inherit_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cPlotGrid
        'Return New KRA_Employee_Inheritr_CommonPage_SubCommonPage(MyBase.m_objGlobal)
        Return New KRA_Employee_Inheritr_CommonPage_SubCommonPage(m_objSubTagGlobal)
    End Function

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

        Dim strQuery As String = "Select EmployeeName from tbl_PM_Employee where EmployeeID=" + Gen.PrimaryKeyValue
        Dim EmployeeID As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, True))
        Args.RightPageCaption = "Employee Name :" + EmployeeID
    End Sub
End Class
Class KRA_Employee_Inheritr_CommonPage_SubCommonPage
    Inherits CommonEngine.CommonList.cPlotGrid

    Public strEmployeeID As String

    Private m_sbCSScript As New System.Text.StringBuilder("")
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strDrawTextBox As String
        Dim strDefaultWeight As String
        Dim strDefaultRating As String
        Dim strEmployeeKRAID As String
        'Fetch EmployeeKRAID from DataReader
        strEmployeeID = Args.DataReader("EmployeeID").ToString
        strEmployeeKRAID = Args.DataReader("EmployeeKRAID").ToString

        Select Case UCase(Args.DataField)
            'Text box for Default Weight
            Case "WEIGHT"
                strDefaultWeight = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Weight")).ToString
                'Commented and added by Shamkant s for HTML encoding Date:07/10/15
                strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Weight", "Weight", , 35, , strDefaultWeight, "Right", , , , , , "onblur='ValidateEmployeeWeight(this)'", True, EnableHTMLEncode:=True)
                ''''''''
                strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdEmployeeID", "hdEmployeeID", , 35, , strEmployeeID, "Right", , , , , True, , True, EnableHTMLEncode:=True)
                ''''''''''''''
                strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdEmployeeKRAID", "hdEmployeeKRAID", , 35, , strEmployeeKRAID, "Right", , , , , True, , True, EnableHTMLEncode:=True)
                'ended by Shamkant s  for HTML encoding Date:07/10/15
                'Plot Text box instead of grid cell value
                Args.IgnoreActualValue = True
                Args.ReplacementValue = strDrawTextBox


        End Select
        '==========================================================================================================
        'Ended by   : Manoj Dagde
        'Date       : 12 Oct 2007
        '===========================================================================================================


    End Sub

    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)

        Dim strTotal As String
        Dim strDrawTextBox As String
        Dim stringTotal As String
        Dim strEmployeeIDtemp As String
        Dim strEmployeeID1 As String

        'EmployeeID_PK

        'If Querystring is avaialbe get value of RoleID.
        If Not HttpContext.Current.Request.QueryString("EmployeeID_PK") Is Nothing AndAlso HttpContext.Current.Request.QueryString("EmployeeID_PK") <> "" Then
            'TO BE REMOVED
            CommonFunction.General.WriteHTML("<Input type=hidden name=hdEmployeeID_PK ID=hdEmployeeID_PK value=" + HttpContext.Current.Request.QueryString("EmployeeID_PK") + ">")
            strEmployeeIDtemp = CType(HttpContext.Current.Request.QueryString("EmployeeID_PK"), String)
        ElseIf Not HttpContext.Current.Request.Form("UniqueID") Is Nothing AndAlso HttpContext.Current.Request.Form("UniqueID") <> "" Then
            CommonFunction.General.WriteHTML("<Input type=hidden name=UniqueID value=" + HttpContext.Current.Request.Form("UniqueID") + ">")
            strEmployeeID1 = HttpContext.Current.Request.Form("UniqueID")
        End If
        'If Querystring is not avaialbe get value from hidden field.
        Dim ArrRoles() As String = Split(HttpContext.Current.Request.Form("hdEmployeeID"), ",")

        If strEmployeeIDtemp Is Nothing Then
            If (Not ArrRoles(0) Is Nothing) Then
                strEmployeeIDtemp = ArrRoles(0)
            End If
        End If
        '----------------------------------------------------------------------------------------
        'If strEmployeeIDtemp gets "" then get it from "Args.CommonQueryString" property 
        'because control doent goes to "Before_GridDataRowTD_Print" event and thats why it doesnt 
        'get the plotted hidden "RoleID" field too.
        '----------------------------------------------------------------------------------------
        If (strEmployeeIDtemp = "") Then
            Dim str() As String
            Dim i As Integer
            Dim strCatch As String
            'Get RoleID value from commonQuery string as RoleID is not available in
            'Hidden field as well as in url(querystring)
            str = Args.CommonQueryString.Split("&".ToCharArray())
            For i = 0 To str(i).Length
                If str(i).StartsWith("EmployeeID") Then
                    strCatch = str(i).Substring(str(i).IndexOf("=") + 1)
                    strEmployeeIDtemp = strCatch
                    Exit For
                End If
            Next
            '==============================================================================================================
            'Date : 23 Oct 2007
            'Ended By : MANOJD 
            '==============================================================================================================
        End If


        '
        Dim strValue As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_KRA_EmployeeKRA_BalanceWeight " + strEmployeeIDtemp, True))


        m_sbCSScript.Append("return true" + vbCrLf)
        m_sbCSScript.Append("}" + vbCrLf)
        m_sbCSScript.Append("</SCRIPT>" + vbCrLf)
        '========================================================================================================
        'Created By : MANOJ DAGDE
        'Date : 19 Oct 2007
        'Description : To Draw textbox for Balancing the weight
        '==========================================================================================================
        HttpContext.Current.Response.Write(m_sbCSScript.ToString)
        'Balance Weight
        '  HttpContext.Current.Response.Write("<Table ><Tr><th>       </th>     <th></th><th>")
        HttpContext.Current.Response.Write(" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<Font size='1'color='BLACK'>Balance Weight :</Font>")
        'Draw textbox for Balance weight 
        'Commented and added by Shamkant s for HTML encoding Date:07/10/15
        strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Total", "Total", , 35, , strValue, "Right", , , True, System.Drawing.Color.LightYellow.ToString(), , , False, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:07/10/15
        stringTotal = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("Total"))
        ' HttpContext.Current.Response.Write("</Th></TR></Table>")
        '========================================================================================================
        'Ended By : MANOJ DAGDE
        'Date : 19 Oct 2007
        '==========================================================================================================

    End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        m_sbCSScript.Append(vbCrLf)
        m_sbCSScript.Append("<script language=javascript>" + vbCrLf)
        m_sbCSScript.Append("function validate_orderNo()" + vbCrLf)
        m_sbCSScript.Append("{" + vbCrLf)
        'Added by SwatiM for Reducing space between action links of Subtag and action links of Common Page
        Args.DIVHeight = 350
    End Sub

    Protected Overrides Sub Finalize()
        m_sbCSScript = Nothing
        MyBase.Finalize()
    End Sub
End Class