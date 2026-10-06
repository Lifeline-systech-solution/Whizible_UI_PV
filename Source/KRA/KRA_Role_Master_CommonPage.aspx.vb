Imports CommonEngines.General.cEventHandlers
Public Class cKRA_Role_Master_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cKRA_Role_Master_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cKRA_Role_Master_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cKRA_Role_Master_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class KRA_Role_Master_CommonPage
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
        MyBase.strListPage = "KRA_Role_Master_CommonList.aspx"
        MyBase.strFormPage = "KRA_Role_Master_CommonPage.aspx"
        MyBase.Page_Load(sender, e)
    End Sub
    '===============================================================================================================
    'Added by : ShraddhaJ
    'Date     : 15 Oct 2007
    'description : To save selected value drivers along with its weight
    '=============================================================================================================
    Protected Overrides Sub Before_ExecutingAction(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)
        Select Case UCase(Trim(Args.ClientSideFunctionName & ""))
            'Save Selected  Value Drivers
            Case "SAVEVALUEDRIVER"
                Dim blnUseSQL As Boolean = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
                Dim arrRoleKRAID() As String = Split(Request.Form("hdRoleKRAID"), ",")
                Dim arrDefaultWeight() As String = Split(Request.Form("DefaultWeight"), ",")
                Dim intUBound As Integer = UBound(arrDefaultWeight)
                Dim intCount As Integer
                Dim strRoleID As String = Request.Form("RoleID_PK").ToString
                Dim sbSQL As New System.Text.StringBuilder

                'Update the Role wise Value Driver Details
                For intCount = 0 To intUBound
                    If arrDefaultWeight(intCount) <> "" Then
                        'Update the selected value drivers with weights
                        sbSQL.Append("EXEC [dbo].usp_UPD_tbl_KRA_RoleKRA " + arrRoleKRAID(intCount) + "," + arrDefaultWeight(intCount) + ",'" + CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) + "'" + vbCrLf)
                    End If
                Next
                'sbSQL.Append("EXEC [dbo].usp_UPD_tbl_KRA_RoleKRA " + arrRoleKRAID(intCount) + ",'" + CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) + "'" + vbCrLf)
                CommonFunctions.Data.InsertOrUpdateData(sbSQL.ToString(), blnUseSQL)
                sbSQL = Nothing
        End Select
        '===============================================================================================================
        'Ended by : ShraddhaJ
        'Date     : 15 Oct 2007
        '=============================================================================================================
    End Sub
    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cKRA_Role_Master_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cKRA_Role_Master_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cKRA_Role_Master_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cKRA_Role_Master_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function
    Protected Overloads Function InitSubTagCLSQL() As CommonEngine.CommonList.cSubTagCLSQL
        Return New cKRA_Role_Master_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cPlotGrid
        Return New KRA_Role_Master_CommonPage_SubCommonPage(m_objSubTagGlobal)
    End Function
    Public Sub New()
    End Sub

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)
        Dim strQuery As String = "Select RoleDescription from tbl_PM_Role where RoleID=" + Gen.PrimaryKeyValue
        Dim RoleID As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, True))
        Args.RightPageCaption = "Role:" + RoleID
    End Sub
End Class
Class KRA_Role_Master_CommonPage_SubCommonPage
    '==============================================================================================================
    'Description : To display inherited page for configuring value drivers and their corresponding weight and Rule
    'Date : 10 Oct 2007
    'Created By : ShraddhaJ
    '==============================================================================================================
    Inherits CommonEngine.CommonList.cPlotGrid
    Dim count As Integer
    'Public strRoleID As String
    Private m_sbCSScript As New System.Text.StringBuilder("")
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strDrawTextBox As String
        Dim strDefaultWeight As String
        Dim strDefaultRating As String
        Dim strRoleKRAID As String

        'Fetch RoleID from DataReader
        Dim strRoleID As String = Args.DataReader("RoleID").ToString
        'strRoleID = HttpContext.Current.Request.QueryString("RoleID_PK")

        strRoleKRAID = Args.DataReader("RoleKRAID").ToString
        'HttpContext.Current.Request.Form("hdRoleid") = strRoleID
        Select Case UCase(Args.DataField)

            'Text box for Default Weight
            Case "DEFAULTWEIGHT"
                strDefaultWeight = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DefaultWeight")).ToString
                'Commented and added by Shamkant s for HTML encoding Date:07/10/15
                strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("DefaultWeight", "DefaultWeight", , 35, , strDefaultWeight, "Right", , , , , , "onblur='ValidateWeight(this)'", True, EnableHTMLEncode:=True)
                strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdRoleID", "hdRoleID", , 35, , strRoleID, "Right", , , , , True, , True, EnableHTMLEncode:=True)
                strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdRoleKRAID", "hdRoleKRAID", , 35, , strRoleKRAID, "Right", , , , , True, , True, EnableHTMLEncode:=True)
                'Plot Text box instead of grid cell value
                Args.IgnoreActualValue = True
                Args.ReplacementValue = strDrawTextBox

                'Text box for Deafult Ratings
            Case "DEFAULTRATING"
                strDefaultRating = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DefaultRating")).ToString
                strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("DefaultRating", "DefaultRating", , 35, , strDefaultRating, "Right", , , , , , , True, EnableHTMLEncode:=True)
                'ended by Shamkant s  for HTML encoding Date:07/10/15
                Args.IgnoreActualValue = True
                Args.ReplacementValue = strDrawTextBox
                'CommonFunctions.General.WriteHTML("</Table>")
        End Select
        '==========================================================================================================
        'Ended by   : ShraddhaJ
        'Date       : 11 Oct 2007
        '===========================================================================================================
    End Sub

    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        '==============================================================================================================
        'Description : To display inherited page for configuring value drivers and their corresponding weight and Rule
        'Date : 20 Oct 2007
        'Created By : ShraddhaJ
        '==============================================================================================================
        Dim strTotal As String
        Dim strDrawTextBox As String
        Dim stringTotal As String
        Dim strRoleIDtemp As String
        Dim strRoleID As String

        'If Querystring is avaialbe get value of RoleID.
        If Not HttpContext.Current.Request.QueryString("RoleID_PK") Is Nothing AndAlso HttpContext.Current.Request.QueryString("RoleID_PK") <> "" Then
            'TO BE REMOVED
            CommonFunction.General.WriteHTML("<Input type=hidden name=hdRoleID_PK ID=hdRoleID_PK value=" + HttpContext.Current.Request.QueryString("RoleID_PK") + ">")
            strRoleIDtemp = CType(HttpContext.Current.Request.QueryString("RoleID_PK"), String)
        ElseIf Not HttpContext.Current.Request.Form("UniqueID") Is Nothing AndAlso HttpContext.Current.Request.Form("UniqueID") <> "" Then
            CommonFunction.General.WriteHTML("<Input type=hidden name=UniqueID value=" + HttpContext.Current.Request.Form("UniqueID") + ">")
            strRoleID = HttpContext.Current.Request.Form("UniqueID")
        End If
        'If Querystring is not avaialbe get value from hidden field.
        Dim ArrRoles() As String = Split(HttpContext.Current.Request.Form("hdRoleId"), ",")

        If strRoleIDtemp Is Nothing Then
            If (Not ArrRoles(0) Is Nothing) Then
                strRoleIDtemp = ArrRoles(0)
            End If
        End If
        '----------------------------------------------------------------------------------------
        'If strRoleIdTemp gets "" then get it from "Args.CommonQueryString" property 
        'because control doent goes to "Before_GridDataRowTD_Print" event and thats why it doesnt 
        'get the plotted hidden "RoleID" field too.
        '----------------------------------------------------------------------------------------
        If (strRoleIDtemp = "") Then
            Dim str() As String
            Dim i As Integer
            Dim strCatch As String
            'Get RoleID value from commonQuery string as RoleID is not available in
            'Hidden field as well as in url(querystring)
            str = Args.CommonQueryString.Split("&".ToCharArray())
            For i = 0 To str(i).Length
                If str(i).StartsWith("RoleID") Then
                    strCatch = str(i).Substring(str(i).IndexOf("=") + 1)
                    strRoleIDtemp = strCatch
                    Exit For
                End If
            Next
            '==============================================================================================================
            'Date : 23 Oct 2007
            'Ended By : ShraddhaJ
            '==============================================================================================================
        End If

        'To get available balance for assigning weight to Value Drivers.
        Dim strValue As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_KRA_RoleKRA_BalanceWeight " + strRoleIDtemp, True))

        m_sbCSScript.Append("return true" + vbCrLf)
        m_sbCSScript.Append("}" + vbCrLf)
        m_sbCSScript.Append("</SCRIPT>" + vbCrLf)
        '========================================================================================================
        'Created By : ShraddhaJ
        'Date : 17 Oct 2007
        'Description : To Draw textbox for Balancing the weight
        '==========================================================================================================
        HttpContext.Current.Response.Write(m_sbCSScript.ToString)
        'Balance Weight
        HttpContext.Current.Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<Font color='black'> Balance Weight : </Font> ")
        'Commented and added by Shamkant s for HTML encoding Date:07/10/15
        'Draw textbox for Balance weight
        strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("Total", "Total", , 35, , strValue, "Right", , , True, System.Drawing.Color.LightYellow.ToString(), , , False, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:07/10/15
        stringTotal = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("Total"))
        '========================================================================================================
        'Ended By : ShraddhaJ
        'Date : 17 Oct 2007
        '==========================================================================================================
    End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        m_sbCSScript.Append(vbCrLf)
        m_sbCSScript.Append("<script language=javascript>" + vbCrLf)
        m_sbCSScript.Append("function validate_orderNo()" + vbCrLf)
        m_sbCSScript.Append("{" + vbCrLf)
        '    'Added by SwatiM for Reducing space between action links of Subtag and action links of Common Page
        Args.DIVHeight = 350
    End Sub

    Protected Overrides Sub Finalize()
        m_sbCSScript = Nothing
        MyBase.Finalize()
    End Sub
End Class