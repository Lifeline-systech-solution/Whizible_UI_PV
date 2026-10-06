Public Class ML_Modulewise_EmployeeAccessList
    Inherits WebPages.Template.WhizTemplate
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    

#End Region
#Region "Global Variables"
    Private WithEvents m_objgrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private strXMLPath As String = Server.MapPath("../GENERAL/").ToString + "WhizModules.xml"
    Private m_validXML As String 'Integer
    Private strmenu As String = ""
    Private strModule As String = ""
    Private m_strAction As String = ""
    Private m_intAvailable As Integer = 0
    Protected strLicences As String
    Protected m_intLicences As String
    Protected m_intModuleTagID As Integer = 0
#End Region
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
    End Sub

    Protected Sub PageInit()
        InitVariable()
        If m_strAction.ToUpper = "SAVE" Then
            SaveEmployeeAccess()
        End If
        m_validXML = MLCommonFunction.ML_CommonFunction.Validate_Modulexml(strXMLPath)
        If m_validXML = "" Then
            GetAvailableLicences()
            CommonFunctions.General.WriteHTML("<BR>")
            DrawMenu()
            DrawPageCaption()
            DrawGrid()
        End If
    End Sub
    Private Sub InitVariable()
        m_intModuleTagID = Request.QueryString("ModuleTagID")
        m_strAction = Request.QueryString("Action")
    End Sub
    Private Sub GetAvailableLicences()
        Dim m_intAlloted As Integer
        Dim dXMLSet As New DataSet()
        Dim dXMLRdr As DataTableReader
        Dim i As Integer = 0
        Try
            If CommonFunctions.FileDirectory.IsFileExists(strXMLPath) Then
                dXMLSet.ReadXml(strXMLPath)
                dXMLRdr = dXMLSet.CreateDataReader()
                While dXMLRdr.Read()
                    strLicences = MLCommonFunction.ML_CommonFunction.Decrypt(dXMLRdr("Licences_Text").ToString())
                    strModule = strLicences.Substring(strLicences.IndexOf("/") + 1, strLicences.LastIndexOf("/") - (strLicences.IndexOf("/") + 1))
                    strLicences = strLicences.Substring(strLicences.LastIndexOf("/") + 1)
                    If strModule = m_intModuleTagID.ToString Then
                        m_intAlloted = CommonFunctions.Data.GetDataScalar("select ISNULL(Count(UniqueID),0) as Alloted FROM tbl_PM_Login_AccessibleModules Where ModuleID=" + strModule.ToString + " AND IsActive=1", MyBase.UseSQL)
                        m_intAvailable = strLicences - m_intAlloted
                        m_intLicences = strLicences
                        Exit While
                    End If
                End While
                dXMLRdr.Close()
                dXMLSet.Dispose()
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
        End Try
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


        Dim arrMenuCaptionsList() As String = {"Save", "Select All", "Close"}
        Dim arrMenuToolTipsList() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), "Select All", MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
        Dim arrClientSideFunctionList() As String = {"Save_OnClick()", "SelectAll_OnClick()", "Close_OnClick()"}

        m_objMenu = New WebPages.Template.StaticMenu
        strmenu = m_objMenu.DrawMenuWithEvents(arrMenuCaptionsList, arrClientSideFunctionList, arrMenuToolTipsList, True)
        CommonFunctions.General.WriteHTML(strmenu)

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
        Dim strModuleName As String = ""
        strModuleName = CommonFunctions.Data.GetDataScalar("Select ModuleName from tbl_PM_SystemModules where ModuleTagID=" + m_intModuleTagID.ToString, True)
        WebPages.Template.PageCaption.GetPageCaptions(, "Module Name : " + strModuleName, "Available Licences : " + m_intAvailable.ToString)

        CommonFunctions.General.WriteHTML("<BR>")
    End Sub
    Private Sub DrawGrid()
        Dim strQuery As String

        Dim arrActualCols() As String = {"EmployeeName", "LoginName", "RoleDescription", "IsActive"}
        Dim arrUserFriendlyCols() As String = {"Employee Name", "Login Name", "Role", "Select"}
        Dim arrRowLink() As String = {"", "", ""}
        Dim arrChkBox() As String = {"", "", "", "chkSelect"}
        Dim arrstrTDStyle() As String = {"align=left", "align=left", "align=left", "style='width=15%' Title='Select'"}

        strQuery = "Exec usp_sel_Modulewise_Access_EmployeeList " + m_intModuleTagID.ToString
        'Set the Generic Grid Properties
        With m_objgrid
            .NoOfDataColumns = 3
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
            .PrimaryKey = "LoginID"
            .DrawGrid()
        End With

        'CommonFunctions.General.WriteHTML(strMenu)

    End Sub
    Private Sub SaveEmployeeAccess()

        Dim strApplicable As String
        Dim strQuery As String = ""
        strApplicable = Request("chkApplicable")
        strQuery = "usp_ins_upd_tbl_PM_Login_AccessibleModules_ModuleWise " & m_intModuleTagID.ToString & ",'" & strApplicable & "'"
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
    End Sub

    Private Sub m_objgrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objgrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "ISACTIVE" Then
            Dim strLoginID As String
            Dim blnDisabled As Boolean = False
            Dim blnSelected As Boolean = False
            If (CType(Args.DataReader("ISACTIVE"), Boolean)) Then
                blnSelected = True
            Else
                If m_intAvailable = 0 Then
                    blnDisabled = True
                End If
            End If
            strLoginID = CType(Args.DataReader("LoginID"), String)
            Cancel = True
            
            Args.StringToBeInserted = "<TD  align=center >" + vbCrLf
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawCheckBox("chkApplicable", "chkApplicable", , blnSelected, strLoginID, blnDisabled, , True)
            Args.StringToBeInserted += "</Td>"
        End If
    End Sub

End Class