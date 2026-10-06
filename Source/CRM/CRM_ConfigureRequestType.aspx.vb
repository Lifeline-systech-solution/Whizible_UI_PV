Imports CommonFunctions

Public Class CRM_ConfigureRequestType
    Inherits WebPage.Templates.WhizTemplate

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
    '=====================================================================
    ' Page Name             : CRM_ConfigureRequestType
    ' Purpose               : Map the Request types to department
    ' Description           : 
    ' Parameters Passed     : 
    ' Assumptions           : 
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : AbhijeetD
    ' Created               : 2nd March, 2004
    ' Revisions             : 
    '=====================================================================

    Private WithEvents m_objMenu As WebPage.Templates.StaticMenu
    Private WithEvents m_objGrid As WebPages.Template.GenericGrid
    Private m_strclsTRColHeader As String = "'clsTRColumnHeader'"
    Private m_strClsTREven As String = "'clsTREven'"
    Private m_strClsTROdd As String = "'clsTROdd'"
    Private m_blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
    Private m_strAction As String
    Private m_strFunctionID As String = ""
    'added by SachinR   On 22 Mar 2004
    Private m_strRequestTypeID As String
    Private m_strRoleID As String
    Protected m_strMode As String
    Private m_strMasterTagID As String
    'adition end

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        If Request.QueryString("FunctionID") <> "" Then
            m_strFunctionID = CommonFunctions.General.CheckIsNothing(Request.QueryString("FunctionID"))
        Else
            m_strFunctionID = MyBase.GetFormValue("hdFunctionID") + ""
        End If
        m_strAction = CommonFunction.General.CheckIsNothing(Request.QueryString("Action"))

        '**************************************************************
        'Modified By SachinR    On 22 Mar 2004
        '**************************************************************
        m_strMode = Request.QueryString("Mode") + ""
        If Request.QueryString("RequestTypeID") <> "" Then
            m_strRequestTypeID = Request.QueryString("RequestTypeID")
        Else
            m_strRequestTypeID = MyBase.GetFormValue("hdRequestTypeID") + ""
        End If
        If Request.QueryString("RoleID") <> "" Then
            m_strRoleID = Request.QueryString("RoleID")
        Else
            m_strRoleID = MyBase.GetFormValue("hdRoleID") + ""
        End If

        'these are taken to refresh the parent, parent will not be refreshed if these are blank.
        If Request.QueryString("MasterTagID") <> "" Then
            m_strMasterTagID = Request.QueryString("MasterTagID") + ""
        Else
            m_strMasterTagID = MyBase.GetFormValue("hdMasterTagID") + ""
        End If
        'Modification end
        '**************************************************************
    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit
        ' Purpose               : Entry to the page
        ' Description           : Called from within the <Form> Tag
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 25th Feb 2004
        ' Revisions             :
        '=====================================================================

        '******************************************************
        'Modified by    SachinR     On 22,23 Mar 2004
        '******************************************************
        Select Case m_strMode.ToUpper
            Case "REQUEST_ROLEMAPPING"
                'This mode of Request type mapping is called for Role mapping

                If m_strAction <> "" Then
                    Call updateDataForSubrequestRoleMapping()
                End If

                Call DrawPageForSubrequestRoleMapping()

            Case "SUBREQUEST"

                If m_strAction <> "" Then
                    Call updateDataForSubrequest()
                End If

                Call DrawPageForSubrequest()

            Case Else
                Select Case m_strAction.ToUpper
                    Case "SAVE"
                        UpdateData()
                End Select

                DrawPage()
        End Select
        'Modification end
        '******************************************************

        'Store the FunctionID inside a hidden control
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        HTMLControls.DrawTextBox("hdFunctionID", "hdFunctionID", , , , m_strFunctionID, , , , , , True, EnableHTMLEncode:=True)
        HTMLControls.DrawTextBox("hdRequestTypeID", "hdRequestTypeID", , , , m_strRequestTypeID, , , , , , True, EnableHTMLEncode:=True)
        HTMLControls.DrawTextBox("hdRoleID", "hdRoleID", , , , m_strRoleID, , , , , , True, EnableHTMLEncode:=True)
        HTMLControls.DrawTextBox("hdMasterTagID", "hdMasterTagID", , , , m_strMasterTagID, , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:05/10/15
    End Sub

    Public Sub New()
        ''MyBase.ApplySecurity()
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As New Exception
        ex.Source = "Configure Request Type->InvalidInput" & UserInput & Cause
        Throw ex
    End Sub

    Private Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage
        ' Purpose               : Renders the UI
        ' Description           : This function generates the html for the page
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 24th Feb 2004
        ' Revisions             :
        '=====================================================================

        Dim strMenu As String
        '******************************************************
        'Added By    SachinR     On 23 Mar 2004
        'get the department name to display
        '******************************************************
        Dim strSQL As String
        Dim strDepartmentName As String
        Dim objDR As IDataReader
        strDepartmentName = ""
        strSQL = "usp_Sel_tbl_PM_DepartmentMaster " + m_strFunctionID.Trim
        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDR.Read Then
            strDepartmentName = Data.CheckIsDBNull(objDR("Department"), "").ToString
        End If
        Data.DisposeDataReader(objDR)
        'addition end
        '******************************************************

        '-- TOP Menu
        strMenu = DrawMenu()
        Response.Write(strMenu + "<br>")

        '-- Draw Page Caption
        CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"), MyBase.GetResourceString("CAP_DEPARTMENT") + " : " + strDepartmentName.Trim, , True))
        Response.Write("<BR>")

        '******************************************************
        'Added By    SachinR     On 22 Mar 2004
        '******************************************************
        'draw page description
        'Dim objHeader As WebPage.Templates.HeaderFooter
        'objHeader = New WebPage.Templates.HeaderFooter
        'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_REQUEST_TYPE") + ""
        'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
        'General.WriteHTML("<BR>")
        'objHeader = Nothing
        'addition end
        '******************************************************

        Response.Write("<DIV ID='divList' Style='Height:300px;WIDTH:100%;OVERFLOW:auto;'>")
        'Plot the grid for Validation Rules
        DrawGrid()
        Response.Write("</DIV>")

        '-- BOTTOM Menu
        Response.Write("<br>" + strMenu)

        '-- Dispose the objects
        DisposeObjects()
    End Sub

    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 24th Feb, 2004   
        ' Revisions             :
        'Modified By            :   SachinR
        'Modified on            :   22 Mar 2004
        'Purpose                :   To use array list to plot diffrent menu for both menu
        '=====================================================================
        Dim arrlstMenu As System.Collections.ArrayList
        Dim arrlstMenuToolTip As System.Collections.ArrayList
        Dim arrlstClientSideFunctions As System.Collections.ArrayList

        arrlstMenu = New System.Collections.ArrayList
        arrlstMenuToolTip = New System.Collections.ArrayList
        arrlstClientSideFunctions = New System.Collections.ArrayList

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        arrlstMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrlstMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrlstClientSideFunctions.Add("Save_OnClick()")
        arrlstMenu.Add(MyBase.GetResourceString("MENU_SELECTALL")) : arrlstMenuToolTip.Add(MyBase.GetResourceString("MENU_SELECTALL")) : arrlstClientSideFunctions.Add("SelectAll_OnClick('frmConfigureRequestType', 'chkSelect')")
        arrlstMenu.Add(MyBase.GetResourceString("MENU_CLEARALL")) : arrlstMenuToolTip.Add(MyBase.GetResourceString("MENU_CLEARALL")) : arrlstClientSideFunctions.Add("ClearAll_OnClick('frmConfigureRequestType', 'chkSelect')")
        If m_strMode = "SUBREQUEST" Then
            arrlstMenu.Add(MyBase.GetResourceString("MENU_BACK")) : arrlstMenuToolTip.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP")) : arrlstClientSideFunctions.Add("Back_OnClick(" + m_strFunctionID.Trim + ")")
        End If
        arrlstMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrlstMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrlstClientSideFunctions.Add("Close_OnClick()")
        arrlstMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrlstMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrlstClientSideFunctions.Add("Help_OnClick('396')")

        Dim arrMenu(arrlstMenu.Count - 1) As String
        Dim arrMenuToolTip(arrlstMenuToolTip.Count - 1) As String
        Dim arrClientSideFunctions(arrlstClientSideFunctions.Count - 1) As String
        arrlstMenu.CopyTo(arrMenu)
        arrlstMenuToolTip.CopyTo(arrMenuToolTip)
        arrlstClientSideFunctions.CopyTo(arrClientSideFunctions)
        arrlstMenu = Nothing
        arrlstMenuToolTip = Nothing
        arrlstClientSideFunctions = Nothing

        m_objMenu = New WebPage.Templates.StaticMenu
        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        MyBase.InitializeResources("AppResources.CRM_ConfigureRequestType", "AppResources")
        Return (strMenu)
    End Function

    Private Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : DrawGrid
        ' Purpose               : Render the UI for showing validation rules
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 2nd March 2004
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String
        Dim arrstrActualList() As String = {"RequestType", ""}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("REQUEST_TYPE"), MyBase.GetResourceString("SELECT")}
        Dim arrCheckBox() As String = {"", "chkSelect"}
        Dim arrstrTDStyle() As String = {" align='left' noWrap ", " align='center' "}
        Dim strGRID As String
        '****************************************************************************
        'Modified BY    SachinR.    To add link to first column
        'Modified On    22 Mar 2004
        '****************************************************************************
        Dim arrRowLink() As String = {"RequestType_OnClick(RequestTypeID)", ""}
        'modification end
        '****************************************************************************

        ' modified by harshada d for showing all requestTypes listed in RequestType Master on 01 02 2006 for issue
        ' strSQL = "EXEC usp_Sel_tbl_CRM_RequestType_Function " + m_strFunctionID

        'Modified by MrugajaB on 8th July 2006 for WhizibleSEM SP7 Issue ID.4262
        'Purpose:The Request Types for which atleast atleast one sub request type is mapped only sholuld be populated else the request type gets unmapped after saving
        'strSQL = " select requestTypeID, requestType from tbl_CRM_RequestType "
        'end of modification by harshada d on 01 02 2006

        ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = " select requestTypeID, requestType from tbl_CRM_RequestType WHERE RequestTypeId IN (SELECT RequestTypeId FROM tbl_CRM_RequestType_SubRequestType WHERE RequestTypeId=tbl_CRM_RequestType.RequestTypeID) "
        strSQL = "Exec usp_sel_tbl_CRM_RequestType_requestType "
        ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        'End Modification by MrugajaB
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'ended by Yogesh J for HTML encoding Date:05/10/15
        m_objGrid = New WebPage.Templates.GenericGrid
        With m_objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            '****************************************************************************
            'Modified by    SachinR     On  22 Mar 2004
            .RowLinkArray = arrRowLink
            'Mofication end
            '****************************************************************************
            .CheckBoxIDArray = arrCheckBox
            .TDStyleArray = arrstrTDStyle
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
            .PrimaryKey = "RequestTypeID"
            .SQL = strSQL
            .DIVHeight = 300
            .returnHTML = True
            .UseSQL = m_blnUseSQL
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode


            strGRID = .DrawGrid()
        End With
        Response.Write(strGRID)
    End Sub

    Public Sub PlotPageHeader()
        '=====================================================================
        ' Procedure Name        : PlotPageHeader
        ' Purpose               : Plot Page Header
        ' Description           : Renders the standard page header. Called from above the <body> tag
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 24th Feb 2004
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.CRM_ConfigureRequestType", "AppResources")
        CommonFunction.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_CAPTION"))
    End Sub

    Private Sub DisposeObjects()
        '=====================================================================
        ' Procedure Name        : DisposeObjects
        ' Purpose               : Dispose Objects
        ' Description           : Dispose the objects allocated with memory
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 1st Mar 2004
        ' Revisions             :
        '=====================================================================
        m_objGrid = Nothing
        m_objMenu = Nothing
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure Name        : m_objGrid_DataRowTD_BeforePrint
        ' Purpose               : To disable the select checkboxes of those Requests that are in use
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 1st Mar 2004
        ' Revisions             :
        'Modified By            :   SachinR
        'Modified On            :    22 Mar 2004
        '=====================================================================
        Dim strSQL As String
        Dim drReader As IDataReader

        '****************************************************************
        'Modified by    SachinR     On  22 Mar 2004
        'if access is given already then check the check the checkbox and disabled
        '****************************************************************
        If Args.ColumnName.ToUpper = "SELECT" Then
            If m_strMode.ToUpper = "SUBREQUEST" Then

                strSQL = "usp_Sel_tbl_CRM_Function_RequestTypes " + m_strFunctionID.Trim + "," + m_strRequestTypeID.Trim + "," + Args.DataReader("SubRequestTypeID").ToString + ""
                drReader = Data.GetDataReader(strSQL, MyBase.UseSQL)
                If drReader.Read Then
                    Data.DisposeDataReader(drReader)

                    Args.IsCheckBoxChecked = True

                    strSQL = "usp_Sel_tbl_CRM_Function_RequestTypes_Check_Dependency " + m_strFunctionID.Trim + "," + m_strRequestTypeID.Trim + "," + Args.DataReader("SubRequestTypeID").ToString + ""
                    drReader = Data.GetDataReader(strSQL, MyBase.UseSQL)
                    If drReader.Read Then
                        Args.IsCheckBoxDisabled = True
                    End If

                End If
                Data.DisposeDataReader(drReader)

            ElseIf m_strMode.ToUpper = "REQUEST_ROLEMAPPING" Then

                strSQL = "usp_Sel_tbl_CRM_Function_Roles_RequestTypes " + m_strFunctionID.Trim + "," + m_strRoleID.Trim + "," + Args.DataReader("RequestTypeID").ToString
                drReader = Data.GetDataReader(strSQL, MyBase.UseSQL)
                If drReader.Read Then
                    Args.IsCheckBoxChecked = True
                End If
                Data.DisposeDataReader(drReader)

                'modification end
                '****************************************************************
            Else

                Dim strRequestTypeID As String = Args.DataReader("RequestTypeID").ToString

                'Set the status of the Select checkbox
                strSQL = "usp_Sel_tbl_CRM_Function_RequestTypes " + m_strFunctionID + "," + strRequestTypeID
                drReader = CommonFunction.Data.GetDataReader(strSQL, m_blnUseSQL)
                If drReader.Read Then
                    Args.IsCheckBoxChecked = True
                End If
                CommonFunction.Data.DisposeDataReader(drReader)

                'If the request is in use then do not allow to change the mapping
                strSQL = "usp_Sel_tbl_CRM_Function_RequestTypes_Check_Dependency " + m_strFunctionID + ", " + strRequestTypeID
                If Not (CommonFunction.Data.GetDataScalar(strSQL, m_blnUseSQL) Is Nothing) Then
                    Args.IsCheckBoxDisabled = True
                End If
            End If
        End If

    End Sub

    Private Sub UpdateData()
        '=====================================================================
        ' Procedure Name        : UpdateData()
        ' Purpose               : To update the Request Type mapping to the database
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 1st Mar 2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim intTotalRecords As Integer
        Dim intCounter As Integer
        Dim strRequestTypeID As String
        Dim arrRequestTypeIDList As String()
        Dim arrComma As Char() = {","c}

        strSQL = "usp_Del_tbl_CRM_Function_RequestTypes " + m_strFunctionID + ",null"
        If MyBase.GetFormValue("chkSelect") = "" Then
            strSQL = strSQL + ",null"
        Else
            strSQL = strSQL + ",'" + MyBase.GetFormValue("chkSelect") & "'"
        End If

        'Delete the old assignment for the Request Types
        CommonFunction.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

        'Split the list of RequestTypeIDs
        arrRequestTypeIDList = MyBase.GetFormValue("chkSelect").Split(arrComma)

        'Assign each Request Type to the Function
        For Each strRequestTypeID In arrRequestTypeIDList
            If strRequestTypeID <> "" Then

                strSQL = "usp_Ins_tbl_CRM_Function_RequestTypes " + m_strFunctionID + "," + strRequestTypeID
                CommonFunction.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

                '******************************************
                'added by   SachinR     on 29 Mar 2004
                '******************************************
                'add new rows into tbl_CRM_Function_Roles for all the applicable
                'roles for this functionID and RequestType.
                strSQL = "usp_Ins_tbl_CRM_Function_Roles_New " + m_strFunctionID.Trim + "," + strRequestTypeID.Trim
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                '******************************************
                'addition end
                '******************************************

            End If
        Next

        '******************************************
        'added by   SachinR     on 30 Mar 2004
        'Refresh parent page after updating data
        '******************************************
        If m_strMasterTagID <> "" Then
            General.WriteHTML("<Script language='javascript'>")
            '' START : Modified By ParagD On 12-Sept-2006
            '' Purpose : Security Change.

            'General.WriteHTML("opener.location.href='../General/CommonPage.aspx?FromCL=1&FromWhere=PRO&DepartmentID_PK=" + m_strFunctionID + "&MasterTagID=" + m_strMasterTagID + "&PagingAlphabet=-1';")
            General.WriteHTML("refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FocusOn=SUBTAG',true);")

            '' END : Modified By ParagD On 12-Sept-2006
            General.WriteHTML("</Script>")
        End If
        '******************************************
        'addition end
        '******************************************

    End Sub

    '=====================================================================
    ' Procedure Name        :   DrawPageForSubrequest()
    ' Purpose               :   To plot the grid for showing the subrequest types.
    ' Description           :   This procdure will plot the grid for showing the subrequest
    '                           types for given RequestID and functionID.
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   SachinR
    ' Created               :   22 Mar 2004
    ' Revisions             :
    '=====================================================================
    Private Sub DrawPageForSubrequest()
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strMenu As String
        Dim strRequestName As String

        'get the name of request type
        strRequestName = ""
        strSQL = "usp_Sel_tbl_CRM_RequestType " + m_strRequestTypeID.Trim
        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDR.Read Then
            strRequestName = Data.CheckIsDBNull(objDR("RequestType"), "").ToString + ""
        End If
        Data.DisposeDataReader(objDR)

        '-- TOP Menu
        strMenu = DrawMenu()
        General.WriteHTML(strMenu + "<br>")

        '-- Draw Page Caption
        General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_SUBREQUEST"), MyBase.GetResourceString("REQUEST_TYPE") + " : " + strRequestName, , True))
        General.WriteHTML("<BR>")

        Dim objHeader As WebPage.Templates.HeaderFooter
        objHeader = New WebPage.Templates.HeaderFooter
        objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_SUBREQUEST") + ""
        General.WriteHTML(objHeader.DrawHeaderFooter(, True))
        General.WriteHTML("<BR>")
        objHeader = Nothing

        Response.Write("<DIV ID='divList' width=100% Style='OVERFLOW:auto;'>")
        'Plot the grid for subrequest Types
        DrawGridForSubrequest()
        Response.Write("</DIV>")

        '-- BOTTOM Menu
        Response.Write("<br>" + strMenu)

        '-- Dispose the objects
        DisposeObjects()
    End Sub

    '=====================================================================
    ' Procedure Name        :   DrawGridForSubrequest()
    ' Purpose               :   To plot the grid for showing the subrequest types.
    ' Description           :   same as above
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   SachinR
    ' Created               :   22 Mar 2004
    ' Revisions             :
    '=====================================================================
    Private Sub DrawGridForSubrequest()
        Dim strSQL As String

        Dim arrstrActualList() As String = {"SubRequestType", ""}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("COL_SUBREQUEST_TYPE"), MyBase.GetResourceString("SELECT")}
        Dim arrCheckBox() As String = {"", "chkSelect"}
        Dim arrstrTDStyle() As String = {"align='left'", "align='center'"}

        strSQL = "usp_Sel_tbl_CRM_SubRequestType_Function " + m_strFunctionID.Trim + "," + m_strRequestTypeID.Trim

        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:05/10/15
        m_objGrid = New WebPage.Templates.GenericGrid
        With m_objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .CheckBoxIDArray = arrCheckBox
            .TDStyleArray = arrstrTDStyle
            .NoOfDataColumns = arrstrUserFriendlyList.Length - 1
            .PrimaryKey = "SubRequestTypeID"
            .SQL = strSQL
            .DIVHeight = 300
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode

            .UseSQL = MyBase.UseSQL
            General.WriteHTML(.DrawGrid())
        End With

    End Sub

    '=====================================================================
    ' Procedure Name        :   updateDataForSubrequest()
    ' Purpose               :   To update the data for the request type.
    ' Description           :   This procdure will update the data for the selected
    '                           subrequests for the given Role ID and function ID.
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   SachinR
    ' Created               :   22 Mar 2004
    ' Revisions             :
    '=====================================================================
    Private Sub updateDataForSubrequest()
        Dim strSQL As String
        Dim arrSubrequestID() As String
        Dim strSubrequestIDList As String

        'get the IDs of selected subrequests
        strSubrequestIDList = MyBase.GetFormValue("chkSelect") + ""
        strSQL = "usp_Del_tbl_CRM_Function_RequestTypes " + m_strFunctionID.Trim + "," + m_strRequestTypeID.Trim + ",NULL"
        If strSubrequestIDList <> "" Then
            strSQL += ",'" + strSubrequestIDList.Trim + "'"
        Else
            strSQL += ",''"
        End If
        'Delete the old assignment for the Sub Request Types to the Function
        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        'insert new rights for the subrequest Types
        If strSubrequestIDList <> "" Then
            arrSubrequestID = Split(strSubrequestIDList, ",")
            Dim i As Integer
            For i = 0 To arrSubrequestID.Length - 1
                If arrSubrequestID(i) <> "" Then
                    strSQL = "usp_Ins_tbl_CRM_Function_RequestTypes " + m_strFunctionID.Trim + "," + m_strRequestTypeID + "," + arrSubrequestID(i).Trim
                    Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                End If
            Next
        End If

    End Sub

    '=====================================================================
    ' Procedure Name        :   DrawPageForSubrequestRoleMapping()
    ' Purpose               :   To plot the grid for showing the subrequest types.
    ' Description           :   This procdure will plot the grid for showing the subrequest
    '                           types for given RoleID and functionID for Role Mapping.
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   SachinR
    ' Created               :   23 Mar 2004
    ' Revisions             :
    '=====================================================================
    Private Sub DrawPageForSubrequestRoleMapping()
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strMenu As String
        Dim strRoleName As String

        'get the name of request type
        strRoleName = ""
        strSQL = "usp_Sel_tbl_PM_Role " + m_strRoleID.Trim
        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDR.Read Then
            strRoleName = Data.CheckIsDBNull(objDR("RoleDescription"), "").ToString + ""
        End If
        Data.DisposeDataReader(objDR)

        '-- TOP Menu
        strMenu = DrawMenu()
        General.WriteHTML(strMenu + "<br>")

        '-- Draw Page Caption
        General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"), MyBase.GetResourceString("CAP_ROLE") + " : " + strRoleName, , True))
        General.WriteHTML("<BR>")

        Dim objHeader As WebPage.Templates.HeaderFooter
        objHeader = New WebPage.Templates.HeaderFooter
        objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_SUBREQUEST_ROLEMAPPING") + ""
        General.WriteHTML(objHeader.DrawHeaderFooter(, True))
        General.WriteHTML("<BR>")
        objHeader = Nothing

        Response.Write("<DIV ID='divList' width=100% Style='OVERFLOW:auto;'>")
        'Plot the grid for subrequest Types
        DrawGridForSubrequestRoleMapping()
        Response.Write("</DIV>")

        '-- BOTTOM Menu
        Response.Write("<br>" + strMenu)

        '-- Dispose the objects
        DisposeObjects()
    End Sub

    '=====================================================================
    ' Procedure Name        :   DrawGridForSubrequestRoleMapping()
    ' Purpose               :   To plot the grid for showing the subrequest types for Role mapping.
    ' Description           :   same as above
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   SachinR
    ' Created               :   23 Mar 2004
    ' Revisions             :
    '=====================================================================
    Private Sub DrawGridForSubrequestRoleMapping()
        Dim strSQL As String

        Dim arrstrActualList() As String = {"RequestType", ""}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("REQUEST_TYPE"), MyBase.GetResourceString("SELECT")}
        Dim arrCheckBox() As String = {"", "chkSelect"}
        Dim arrstrTDStyle() As String = {"align='left'", "align='center'"}
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:05/10/15
        strSQL = "usp_Sel_tbl_CRM_Function_Roles_RequestTypes " + m_strFunctionID.Trim + "," + m_strRoleID.Trim
        m_objGrid = New WebPage.Templates.GenericGrid
        With m_objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .CheckBoxIDArray = arrCheckBox
            .TDStyleArray = arrstrTDStyle
            .NoOfDataColumns = arrstrUserFriendlyList.Length - 1
            .PrimaryKey = "RequestTypeID"
            .SQL = strSQL
            .DIVHeight = 300
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode

            .UseSQL = MyBase.UseSQL
            General.WriteHTML(.DrawGrid())
        End With

    End Sub

    '=====================================================================
    ' Procedure Name        :   updateDataForSubrequestRoleMapping()
    ' Purpose               :   To update the data for the request type for Role mapping.
    ' Description           :   This procdure will update the data for the selected
    '                           subrequests for the given Role ID and function ID for role mapping.
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   SachinR
    ' Created               :   23 Mar 2004
    ' Revisions             :
    '=====================================================================
    Private Sub updateDataForSubrequestRoleMapping()
        Dim strSQL As String
        Dim arrRequestTypeID() As String
        Dim strRequestTypeIDList As String

        'get the IDs of selected subrequests
        strRequestTypeIDList = MyBase.GetFormValue("chkSelect") + ""

        'Delete the old assignment for the Sub Request Types to the Function
        strSQL = "usp_Del_tbl_CRM_Function_Roles " + m_strFunctionID.Trim + "," + m_strRoleID.Trim
        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        'insert new rights for the subrequest Types
        If strRequestTypeIDList <> "" Then
            arrRequestTypeID = Split(strRequestTypeIDList, ",")
            Dim i As Integer
            For i = 0 To arrRequestTypeID.Length - 1
                If arrRequestTypeID(i) <> "" Then
                    strSQL = "usp_Ins_tbl_CRM_Function_Roles " + m_strFunctionID.Trim + "," + m_strRoleID + "," + arrRequestTypeID(i).Trim
                    Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                End If
            Next
        End If

    End Sub
End Class
