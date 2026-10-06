Public Class PM_UserMapping
    Inherits WebPage.Templates.WhizTemplate
    '=====================================================================
    ' Class Name            :	PM_UserMapping
    ' Purpose               :	Maps MSP users to PBN Users
    ' Description           :	Same as above
    ' Assumptions           :	None.
    ' Dependencies          :	None.
    ' Author                :	SuryabirD
    ' Created               :	Feb 19, 2004
    ' Revisions             :
    '=====================================================================

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
    Protected m_strPageTitle, m_strMode As String
    Protected m_lngTagID As Long
    Protected m_intComboBoxCount As Integer

    Private m_blnUseSQL As Boolean
    Private m_blnAddAccess, m_blnDeleteAccess, m_blnEditAccess As Boolean
    Private WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        Dim intCount As Integer
        Dim strEmployeeID As String
        Dim strMSPID, strSQL As String

        MyBase.InitializeResources("AppResources.PM_UserMapping", "AppResources")

        '-- History Or Errors
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode")).ToString

        '-- m_blnUseSQL
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        Call CreateGlobalObject()
        m_intComboBoxCount = 0

        '-- IN SAVE MODE : COunt- count of combo boxes data posted.
        If m_strMode = "SAVE" Then
            If (CommonFunctions.General.CheckIsNothing(Request.QueryString("Count"), "0") <> "0") Then
                intCount = 0
                'Session("UserMappingFlag") = 1
                Do While (intCount <> CType(Request.QueryString("Count"), Integer))
                    strEmployeeID = MyBase.GetFormValue("cboMSPUserName" + intCount.ToString)
                    strMSPID = Replace(Request.Form("txtMSPID" + intCount.ToString), "+", " ")

                    If strEmployeeID <> "" Then
                        strSQL = "UPDATE tbl_PM_ProjectTasks SET EmployeeID=" + strEmployeeID + _
                                 " WHERE MSPID='" + CommonFunctions.General.BuildQueryString(strMSPID) + "'" + _
                                 " and ProjectID=" + Session("intProjectID").ToString
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

                        'Here I will fire one more query which will update the Project EmployeeRole fields
                        strSQL = "EXEC usp_Update_ProjectEmployeeRole_ForMSP " + strEmployeeID + _
                                 "," + Session("intProjectID").ToString
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

                    End If
                    intCount = intCount + 1
                Loop

            End If
        End If

    End Sub

    Public Sub Plothead()
        '-- Plots html page head
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)

    End Sub


    Public Sub DrawPage()
        '-- Main function which is called from within the <FORM> Tag.

        Dim strMenu As String

        '-- Display proper Title
        m_strPageTitle = MyBase.GetResourceString("PAGE_CAPTION")

        '-- TOP Menu
        strMenu = DrawMenu()
        Response.Write(strMenu + "<br>")

        '-- Draw Page Caption
        CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, m_strPageTitle, , , True))
        Response.Write("<BR>")

        Response.Write("<DIV ID='divList' Style='Height:300px;WIDTH:100%;OVERFLOW:auto;'>")
        Response.Write("<BR>")

        Call PlotUserMappingGrid()

        Response.Write("</DIV>")

        Response.Write("<BR>")
        Response.Write(strMenu)

    End Sub

    Private Sub PlotUserMappingGrid()
        '-- User Mapping Grid
        Dim strSQL As String

        Dim arrstrActualList() As String = {"MSPID", ""}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("GRID_MSPID"), MyBase.GetResourceString("GRID_PBN_USER")}
        Dim arrstrTDStyle() As String = {" align=left width='30%'", " align=left"}
        Dim strGRID As String

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        strSQL = "SELECT DISTINCT MSPID FROM tbl_PM_ProjectTasks WHERE (MSPID <>'' and MSPID is Not null) AND ProjectID = " + Session("intProjectID").ToString + " AND WhichTask = 'M' AND Isactive = 1"

        With m_objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .TDStyleArray = arrstrTDStyle
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
            .SQL = strSQL
            .DIVHeight = 0
            .returnHTML = True
            .UseSQL = m_blnUseSQL
            ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''End of Addition by Dhanashri S on 7 Oct 2015
            strGRID = .DrawGrid()
        End With
        Response.Write(strGRID)

    End Sub

    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_BACK"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_BACK"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrClientSideFunctions() As String = {"Save_OnClick()", "Back_OnClick()", "Help_OnClick(" + m_lngTagID.ToString + ")"}

        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        MyBase.InitializeResources("AppResources.PM_UserMapping", "AppResources")
        Return (strMenu)

    End Function

    Private Sub CreateGlobalObject()
        '=====================================================================
        ' Function Name         : CreateGlobalObject
        ' Purpose               : Creates the Global Object for accessing TagID, FrowWhere etc.
        ' Description           : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : SuryabirD
        ' Created               : Feb 16, 2004
        ' Revisions             : 
        '=====================================================================

        'Global object
        Dim objAccess As New WebPage.Templates.AccessRights
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objGlobal = MyBase.GlobalObject

        m_lngTagID = 29
        If m_lngTagID = 0 Then
            m_lngTagID = objGlobal.TagID
        Else
            objGlobal.TagID = m_lngTagID
        End If

        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add          'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete    'If User has Delete Access
        m_blnEditAccess = objAccess.Edit        'If user has Edit Access

        'destroy global and AccessRights objects
        objAccess = Nothing
        objGlobal = Nothing
    End Sub

    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()        
        MyBase.ApplySecurity(True)
        'End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'initialize the resource file for PRO_ProjectTypeConfiguration page.
        MyBase.InitializeResources("AppResources.PM_UserMapping", "AppResources")
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        '-- Provide a Combobox to map MSP Users to the PBN users (belonging to this project)
        Dim strSQL, strEmployeeSQL As String
        Dim drEmployeeList As IDataReader
        Dim strEmployeeID As String
        Dim strToInsert As String
        Dim strStatus As String

        If Args.ColIndex = 1 Then
            'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
            'strEmployeeSQL = "Select Distinct EmployeeId from tbl_PM_ProjectTasks Where ProjectId = " + _
            '               Session("intProjectId").ToString + " and Whichtask = 'M' and MSPId = '" + _
            '               CommonFunctions.General.BuildQueryString(Args.DataReader("MSPID").ToString) + "' and EmployeeId <> 0 And IsActive=1"

            strEmployeeSQL = "usp_sel_tbl_PM_ProjectTasks_MSP " + Session("intProjectId").ToString + "," + CommonFunctions.General.BuildQueryString(Args.DataReader("MSPID").ToString)
            'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

           
            strEmployeeID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strEmployeeSQL, m_blnUseSQL)).ToString

            strSQL = "EXEC usp_Sel_CurrentTeamMembers " + Session("intProjectID").ToString

            'Insert Hidden Textbox and ComboBox into TD
            If strEmployeeID <> "" Then
                strStatus = " disabled "
            Else
                strStatus = ""
            End If
            strToInsert = CommonFunctions.HTMLControls.DrawComboBox("cboMSPUserName" + Args.NoOfRowsPrinted.ToString, strSQL, , strEmployeeID, strStatus, True, True)

            '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
            strToInsert = strToInsert + " " + CommonFunctions.HTMLControls.DrawTextBox("txtMSPID" + Args.NoOfRowsPrinted.ToString, "txtMSPID" + Args.NoOfRowsPrinted.ToString, , , , Args.DataReader("MSPID").ToString, , , , , , True, , True, EnableHTMLEncode:=True)
            '''End of Modification by Dhanashri S on 7 Oct 2015

            Args.StringToBeInserted = "<TD align=left>" + strToInsert + "</TD>"
            CommonFunctions.Data.DisposeDataReader(drEmployeeList)
            m_intComboBoxCount += 1

            Cancel = True
        End If
    End Sub
    'Code Added
    'Added by   :   DipaliS
    'Date       :   30 Sep 2004
    'Purpose    :   To show the Save link only if User has Add or Edit Access Set
    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If Args.LinkName.ToUpper = MyBase.GetResourceString("MENU_SAVE").ToUpper Then
            If m_blnAddAccess = False And m_blnEditAccess = False Then
                Cancel = True
            End If
        End If

    End Sub
    'End Addition By DipaliS
End Class
