Public Class ML_Provide_ModuleAccess
    Inherits WebPages.Template.WhizTemplate

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
        ''Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Of Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.
    End Sub

#End Region
#Region "Global Variables"
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Protected m_strLoginID As String
    Protected m_strMode As String
    Private m_strAction As String
    Private m_strUniqueID As String = ""
    Protected m_arrUniqueIDList As New ArrayList
    Protected m_FromWhere As String = ""
    Protected m_intTotalRows As Integer = 0
    Protected strModule() As String = {}
    Protected strLicences() As String = {}
    Private strAvailableLicences As String
    Private m_strModules As String
    Private strMenu As String
    Private strXMLPath As String = Server.MapPath("../GENERAL/").ToString + "WhizModules.xml"
    Private m_validXML As String 'Integer
#End Region
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here        
    End Sub
    Protected Sub PageInit()
        InitVariables()

        If m_strAction.ToUpper = "SAVE" Then
            SaveModuleAccess()
        End If
        'InitArray()
        m_validXML = MLCommonFunction.ML_CommonFunction.Validate_Modulexml(strXMLPath)
        If m_validXML = "" Then
            Dim strQuery As String
            InitArray()
            CommonFunctions.General.WriteHTML("<BR>")
            DrawMenu()
            DrawPageCaption()
            CommonFunctions.General.WriteHTML("<BR>")
            Response.Write("<table Style='height:15px;width:99.9%'  class='clsTable' cellspacing=0 cellpadding=0>")
            'Response.Write("<tr class='clsTReven'>")
            Response.Write("<tr class='clsTRPageCaption'>")
            Response.Write("<td align=left ><b>Available Licenses  = Alloted Licences  - Consumed Licenses </b></td>")
            ' Response.Write("<td align=left ><b>Issued Licences:" + m_intAlloted.ToString + "</b></td>")
            Response.Write("</tr>")
            Response.Write("</table>")
            CommonFunctions.General.WriteHTML("<BR>")

            DrawGrid()
        Else
            Response.Write("<DIV ID='PageDiv' Style='Height:400px;WIDTH:100%;OVERFLOW:auto;'>")
            Response.Write("<TABLE class=clsTABLE Width='100%' Height='100%'>")
            Response.Write("<TR><TD align=Center class=clsTDGroupFooter><B>" + m_validXML + "</B></TD></TR>")
            Response.Write("</TABLE></DIV>")
        End If

    End Sub
    Private Sub SaveModuleAccess()
        Dim strQuery As String = ""
        Dim strApplicable As String
        Dim strApplicableArr() As String
        Dim strMandatory As String
        Dim strSQL As String
        strApplicable = Request("chkApplicable")
        strQuery = "usp_ins_upd_tbl_PM_Login_AccessibleModules " & m_strLoginID & ",'" & strApplicable & "'"
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
    End Sub

    Private Sub InitVariables()
        m_strLoginID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("LoginID"))
        m_strAction = HttpContext.Current.Request("Action")
        m_FromWhere = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("FromWhere"), "")

    End Sub
    Private Sub InitArray()
        Dim m_strAvailable As String
        Dim m_intAlloted As Integer
        Dim dXMLSet As New DataSet()
        Dim dXMLRdr As DataTableReader
        Dim i As Integer = 0
       
        'If MLCommonFunction.ML_CommonFunction.Validate_Modulexml(strXMLPath) = True Then
        Try
            If CommonFunctions.FileDirectory.IsFileExists(strXMLPath) Then
                dXMLSet.ReadXml(strXMLPath)
                dXMLRdr = dXMLSet.CreateDataReader()
                While dXMLRdr.Read()
                    ReDim Preserve strModule(UBound(strModule) + 1)
                    ReDim Preserve strLicences(UBound(strLicences) + 1)
                    strLicences(i) = MLCommonFunction.ML_CommonFunction.Decrypt(dXMLRdr("Licences_Text").ToString())
                    strModule(i) = strLicences(i).Substring(strLicences(i).IndexOf("/") + 1, strLicences(i).LastIndexOf("/") - (strLicences(i).IndexOf("/") + 1))
                    strLicences(i) = strLicences(i).Substring(strLicences(i).LastIndexOf("/") + 1)
                    m_intAlloted = CommonFunctions.Data.GetDataScalar("select ISNULL(Count(UniqueID),0) as Alloted FROM tbl_PM_Login_AccessibleModules Where ModuleID=" + strModule(i).ToString + " AND IsActive=1", MyBase.UseSQL)
                    If strLicences(i) = "" Then
                        strLicences(i) = "0"
                    End If
                    m_strAvailable = CType(strLicences(i), Double) - m_intAlloted
                    If i = 0 Then
                        strAvailableLicences = m_strAvailable
                        m_strModules = strModule(i).ToString
                    Else
                        strAvailableLicences = strAvailableLicences + "," + m_strAvailable
                        m_strModules = m_strModules + "," + strModule(i).ToString
                    End If
                    i = i + 1
                End While
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
        End Try

        '   End If

    End Sub
    Private Sub DrawMenu()
        '====================================================================
        ' Procedure Name        : DrawMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the menu
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SanaS
        ' Created               : 
        ' Revisions             :
        '=====================================================================


        Dim arrMenuCaptionsList() As String = {"Save", "Save & Close", "Select All", "Close"}
        Dim arrMenuToolTipsList() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), "Save & close", "Select All", MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
        Dim arrClientSideFunctionList() As String = {"Save_OnClick()", "Saveclose_OnClick()", "SelectAll_OnClick()", "Close_OnClick()"}

        m_objMenu = New WebPages.Template.StaticMenu
        strmenu = m_objMenu.DrawMenuWithEvents(arrMenuCaptionsList, arrClientSideFunctionList, arrMenuToolTipsList, True)
        CommonFunctions.General.WriteHTML(strMenu)

    End Sub
    Private Sub DrawGrid()
        Dim strQuery As String

        Dim arrActualCols() As String = {"ModuleName", "Available", "Issued", "Remaining", "Selected"}
        Dim arrUserFriendlyCols() As String = {"Module Name", "Alloted Licences", "Consumed Licences", "Available Licenses", "Select"}
        Dim arrRowLink() As String = {"", "", ""}
        Dim arrChkBox() As String = {"", "", "", "", "chkSelect"}
        Dim arrstrTDStyle() As String = {"style='width=45%' align=left", "align=right", "align=right", "align=right", "style='width=15%' Title='Select'"}

        strQuery = "Exec usp_sel_Modules_For_Login " + m_strLoginID.ToString + ",'" + m_strModules.ToString + "','" + strAvailableLicences.ToString + "'"
        'Set the Generic Grid Properties
        With m_objGrid
            .NoOfDataColumns = 5
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .RowLinkArray = arrRowLink
            .CheckBoxIDArray = arrChkBox
            .ClientSideSortFunctionName = ""
            .returnHTML = False
            .TDStyleArray = arrstrTDStyle
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVHeight = 490
            .DIVStyle = "overflow:auto"
            .DIVID = "divList"
            .PrimaryKey = "ModuleTagID"
            .DrawGrid()
        End With

        CommonFunctions.General.WriteHTML(strMenu)

    End Sub

    Private Sub DrawPageCaption()
        '====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SanaS
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim strEmployeeName As String = ""
        strEmployeeName = CommonFunctions.Data.GetDataScalar("Select EmployeeName from tbl_PM_Login L Inner Join tbl_PM_Employee E ON L.EmployeeID=E.EmployeeID where LoginID=" + m_strLoginID.ToString, True)
        WebPages.Template.PageCaption.GetPageCaptions(, "Accessible Modules -" + strEmployeeName)
        CommonFunctions.General.WriteHTML("<BR>")
    End Sub

   

    Public Sub New()
        MyBase.New()
        'MyBase.InitializeResources("AppResourcePPM.DM_IntiativeApprovers", "AppResourcePPM")
    End Sub

    

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "SELECTED" Then
            Dim strModuleID As String
            Dim blnDisabled As Boolean = False
            Dim blnSelected As Boolean = False
            If (CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Selected"), "0"), Boolean)) Then
                blnSelected = True
            End If
            Cancel = True
            strModuleID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ModuleTagID")), String)
            Args.StringToBeInserted = "<TD  align=center >" + vbCrLf
            Dim j As Integer = 0

            'For j = 0 To strModule.Length - 1
            '    If Args.DataReader("ModuleTagId") = strModule(j) Then
            '        If strLicences(j) > 0 Then
            '            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawCheckBox("chkApplicable", "chkApplicable", , blnSelected, strModuleID, blnDisabled, , True)
            '        Else
            '            If blnSelected = False Then
            '                blnDisabled = True
            '            End If
            '            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawCheckBox("chkApplicable", "chkApplicable", , blnSelected, strModuleID, blnDisabled, , True)
            '        End If
            '    End If
            'Next
            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Available"), "0"), Integer) > 0 Then
                Args.StringToBeInserted += CommonFunction.HTMLControls.DrawCheckBox("chkApplicable", "chkApplicable", , blnSelected, strModuleID, blnDisabled, , True)
            Else
                If blnSelected = False Then
                    blnDisabled = True
                End If
                Args.StringToBeInserted += CommonFunction.HTMLControls.DrawCheckBox("chkApplicable", "chkApplicable", , blnSelected, strModuleID, blnDisabled, , True)
            End If

            Args.StringToBeInserted += "</Td>"
        End If
        If Args.DataField.ToUpper = "AVAILABLE" Then
            Dim i As Integer = 0

            For i = 0 To strModule.Length - 1
                If CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ModuleTagId")) = strModule(i) Then
                    Args.ReplacementValue = strLicences(i)
                End If
            Next
        End If
        If Args.DataField.ToUpper = "REMAINING" Then
            ' Args.IgnoreActualValue = True
            Dim i As Integer = 0
            Dim intRemLiv As Integer
            For i = 0 To strModule.Length - 1
                If CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ModuleTagId")) = strModule(i) Then
                    Args.ReplacementValue = strLicences(i) - CommonFunction.Data.CheckIsDBNull(Args.DataReader("Issued"), 0)
                End If
            Next
            'Args.StringToBeInserted = "<TD align=center><a href=""Javascript:EmployeeAccess(" + intRemLiv.ToString + ",'" + Args.DataReader("Shortname") + "')"">Employee Access</TD>"
        End If
    End Sub

    End Class
