Public Class PRO_ProjectType
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
    End Sub

#End Region
    Protected m_strPageTitle As String
    Protected m_lngTagID As Long
    Protected m_blnUseSQL As Boolean

    '' Added By ParagD On 30-Nov-2005
    '' Purpose : Check whether selected PMI has metrics defined for it.
    Protected m_IsMetricsDefined As String
    Protected m_strPMI As String
    '' End Of Addition By ParagD On 30-Nov-2005

    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_lngProjectTypeID, m_lngPMIID As Long
    Private m_blnAddAccess, m_blnDeleteAccess, m_blnEditAccess As Boolean
    Private m_bln_PMPCreated As Boolean
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        Dim strSQL As String
        Dim drTemp As IDataReader

        '-- Initialize variables
        MyBase.InitializeResources("AppResources.PRO_ProjectType", "AppResources")
        m_strPageTitle = MyBase.GetResourceString("PAGE_CAPTION")
        m_lngTagID = CType(Request.QueryString("MasterTagID"), Long) '686
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        m_bln_PMPCreated = False

        '-- Set Access rights variables
        Call CreateGlobalObject()

        '-- Get Project Type ID
        'Put check for the ProjectTypeID
        If (MyBase.GetFormValue("cboProjectType") = "") Then
            strSQL = "EXEC usp_Sel_ProjectType 1," + Session("intProjectID").ToString
            drTemp = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
            If drTemp.Read Then
                m_lngProjectTypeID = CType(CommonFunctions.Data.CheckIsDBNull(drTemp("ProjectTypeId")), Long)
            Else
                m_lngProjectTypeID = 0
            End If

            CommonFunctions.Data.DisposeDataReader(drTemp)
        Else
            m_lngProjectTypeID = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboProjectType"), "0"), Long)
        End If

        '-- DELETE Mode Operation
        If (CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode")).Trim.ToUpper = "DELETE") Then
            strSQL = "EXEC usp_del_PMP " + Session("intProjectID").ToString
            drTemp = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

            '-- Alert user
            If drTemp.Read Then
                Response.Write("<script language=""javaScript"">" + vbCrLf)
                Response.Write("alert('" + drTemp("MSG").ToString + "');" + vbCrLf)
                Response.Write("</script>" + vbCrLf)
            End If
            CommonFunctions.Data.DisposeDataReader(drTemp)
        End If

        '-- SAVE Mode Operation
        If (CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode")).Trim.ToUpper = "SAVE") Then
            strSQL = "EXEC usp_ins_Project_SDLC " + MyBase.GetFormValue("cboProjectType") + "," + Session("intProjectID").ToString
            strSQL = strSQL + "," + MyBase.GetFormValue("txtPMIID")

            If (MyBase.GetFormValue("txtPMIID") <> "") Then
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

            End If

        End If


    End Sub

    Public Sub PlotHead()
        '--Plots HTML Head tag
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Public Sub DrawPage()
        Dim strSQL As String
        Dim strMenu As String
        Dim strPMI, strProjectID As String
        Dim strTobeInserted As String
        Dim drPMI As IDataReader
        Dim objGrid As WebPages.Template.GenericGrid

        'EXEC usp_sel_ProjectTypeRelated_Informaion 4,NULL,NULL
        Response.Write("<DIV ID=divList Style='WIDTH:100%;OVERFLOW:auto'>")

        '-- Here you will get the PMIID for the selected project type
        strSQL = "EXEC usp_Sel_PMIOfProjecttype " + m_lngProjectTypeID.ToString
        drPMI = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If Not drPMI.Read Then
            strPMI = MyBase.GetResourceString("PMI_NOT_EXISTS")     'Not Mentioned in Project Template configuration
            m_lngPMIID = 0
        Else
            strPMI = drPMI("ProjectPMI").ToString
            m_lngPMIID = CType(drPMI("PMIID"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(drPMI)

        '' By ParagD On 5-Nov-2005
        m_strPMI = strPMI
        '' End By ParagD On 5-Nov-2005

        '-- find outwhther the PMP is created for the selected project

        strProjectID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_ProjectType 2," + Session("intProjectID").ToString, m_blnUseSQL)).ToString

        If (strProjectID <> "") Then
            strTobeInserted = "Disabled OnChange='ProjectType_Changed()'"   '-- for Status Of Combo box 'Project Type'
            m_bln_PMPCreated = True
        Else
            strTobeInserted = " OnChange='ProjectType_Changed()'"
        End If

        '-- Draw TOP Menu
        strMenu = DrawMenu()
        Response.Write(strMenu + "<BR>")

        '-- Page Caption
        CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PROJECT_TYPE"), , , True))
        Response.Write("<BR>")

        '--2. PMI Information
        If (m_lngProjectTypeID <> 0) Then

            '--1st Table: Project Type
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TABLE class=clsTable width=99.9% border=0 cellPadding=0 cellSpacing = 0>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TR class=clsTREven >")
            Response.Write("<TD align=right>")
            Response.Write(MyBase.GetResourceString("PROJECT_TYPE"))
            Response.Write("</TD><TD align=Left style='padding-left:6px;' >")
            'Commented and Modified By JyotiG
            'Start_JG_7581_10-Nov-2006
            'CommonFunctions.HTMLControls.DrawComboBox("cboProjectType", "usp_sel_ProjectTypeRelated_Informaion 4,NULL,NULL", , m_lngProjectTypeID.ToString, strTobeInserted, , , , True)
            If m_bln_PMPCreated = True Then
                CommonFunctions.HTMLControls.DrawComboBox("cboProjectType", "usp_sel_ProjectTypeRelated_Informaion 4,NULL,NULL", , m_lngProjectTypeID.ToString, strTobeInserted, , , , True)
            Else
                CommonFunctions.HTMLControls.DrawComboBox("cboProjectType", "usp_sel_ProjectTypeRelated_Informaion 15,NULL,NULL", , m_lngProjectTypeID.ToString, strTobeInserted, , , , True)
            End If
            'End_JG_7581_10-Nov-2006
            Response.Write("</TD></TR>")

            '-- Associated PMI
            Response.Write("<TR class=clsTREven >")
            Response.Write("<TD align=right>")
            Response.Write(MyBase.GetResourceString("PMI"))
            Response.Write("</TD><TD align=Left style='padding-left:6px;'  >")
            Response.Write(Server.HtmlEncode(strPMI))
            Response.Write("</TD></TR>")
            Response.Write("</TABLE>")
            Response.Write("<BR>")

            '-- PMI Information Caption
            CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PMI_INFO"), , , True))
            Response.Write("<BR>")

            '-- Vertical Grid for Other Information about PMI
            strSQL = "EXEC usp_Sel_PMI_OtherInfo " + m_lngPMIID.ToString

            '-- Hidden Control for storing PMI ID 
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ''CommonFunctions.HTMLControls.DrawTextBox("txtPMIID", "txtPMIID", , , , m_lngPMIID.ToString, , , , , , True)
            CommonFunctions.HTMLControls.DrawTextBox("txtPMIID", "txtPMIID", , , , m_lngPMIID.ToString, , , , , , True, EnableHTMLEncode:=True)
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

            '-- Arrays needed for Plotting Grid
            Dim arrstrActualList() As String = {"Name", "description", "Notes", "Active"}
            Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("PMI_NAME"), MyBase.GetResourceString("PMI_DESC"), MyBase.GetResourceString("PMI_NOTES"), MyBase.GetResourceString("PMI_ACTIVE")}
            Dim arrstrTDStyle() As String = {" width='20%' align=Left ", " align=Left ", " align=Left ", " align=Left "}
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            Dim arrIgnoreHtml() As String = {"0"}
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

            objGrid = New WebPages.Template.GenericGrid
            With objGrid
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                .TDStyleArray = arrstrTDStyle
                .NoOfDataColumns = 4
                .DIVHeight = 0
                .ColumnHeaderAlignment = "right"
                .VerticalDisplay = True
                .UseSQL = m_blnUseSQL
                .SQL = strSQL
                .ColNameToolTipOnEachRow = True
                'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                .IgnoreHTMLEncode = arrIgnoreHtml
                'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

                .DrawGrid()
            End With
            objGrid = Nothing

            Response.Write("<br>")

            '-- 3. Data Grid for Metric Details

            Dim arrstrActualList_Det() As String = {"CategoryName", "Name", "UCL", "LCL", "STATUS"}
            Dim arrstrUserFriendlyList_Det() As String = {"", MyBase.GetResourceString("GRID_METRICS"), MyBase.GetResourceString("GRID_UCL"), MyBase.GetResourceString("GRID_LCL"), MyBase.GetResourceString("GRID_STATUS")}
            Dim arrstrTDStyle_Det() As String = {" width='0%'", " width='40%' align=Left ", " align=Right ", " align=Right ", " align=Left width='10%'"}
            Dim arrGroupField() As String = {"1"}
            


            '' Added By ParagD On 30-Nov-2005
            '' Purpose : Check whether selected PMI has metrics defined for it.
            m_IsMetricsDefined = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("SELECT COUNT(*) FROM tbl_PRS_PMIMetrics WHERE PMIID = " + m_lngPMIID.ToString, m_blnUseSQL)).ToString
            '' End By ParagD On 30-Nov-2005

            strSQL = "EXEC usp_Sel_PMI_Information_ForGrid " + m_lngPMIID.ToString

            With m_objGrid
                .ActualColumnArray = arrstrActualList_Det
                .UserFriendlyColumnArray = arrstrUserFriendlyList_Det
                .GroupOnColumn = arrGroupField
                .TDStyleArray = arrstrTDStyle_Det
                .NoOfDataColumns = 5
                .DIVHeight = 0
                .ColumnHeaderAlignment = "left"
                .UseSQL = m_blnUseSQL
                .SQL = strSQL
                .ColNameToolTipOnEachRow = True
                'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                .IgnoreHTMLEncode = arrIgnoreHtml
                'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

                .DrawGrid()
            End With
            m_objGrid = Nothing

            Response.Write("</DIV>")
            Response.Write("<BR>")
            Response.Write(strMenu)

        End If
    End Sub

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
        Dim objGlobal As WebPages.Template.IGlobal
        Dim objAccess As New WebPage.Templates.AccessRights
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objGlobal = MyBase.GlobalObject

        m_lngTagID = 686
        objGlobal.TagID = m_lngTagID

        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add          'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete    'If User has Delete Access
        m_blnEditAccess = objAccess.Edit        'If user has Edit Access

        'destroy global and AccessRights objects
        objAccess = Nothing
        objGlobal = Nothing

    End Sub
    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : PrepareMenu
        ' Purpose               : Function used to draw the Bottom menu..
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.PRO_ProjectType", "AppResources")

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CREATE_PMP"), MyBase.GetResourceString("MENU_DELETE_PMP"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CREATE_PMP"), MyBase.GetResourceString("MENU_DELETE_PMP"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrClientSideFunctions() As String = {"PMP_OnClick()", "Delete_OnClick()", "Help_OnClick('PROJECTTYPE')"}
        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        Return strMenu
        m_objMenu = Nothing


    End Function

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print

        '-- CREATE PMP
        If Args.MenuColIndex = 0 Then
            If m_bln_PMPCreated Then
                Cancel = True
            End If

            If Not (m_blnAddAccess Or m_blnEditAccess) Then
                Cancel = True
            End If
        End If

        '-- DELETE PMP
        If Args.MenuColIndex = 1 Then
            If Not m_blnDeleteAccess Then
                Cancel = True
            End If

            If Not m_bln_PMPCreated Then
                Cancel = True
            End If
        End If
    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'initialize the resource file for PRO_ProjectTypeConfiguration page.
        MyBase.InitializeResources("AppResources.PRO_ProjectType", "AppResources")
    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 0 Then
            Args.ColumnName = ""

        End If

        If Args.ColIndex = 2 Then
            Args.Alignment = "Right"

        End If

        If Args.ColIndex = 3 Then
            Args.Alignment = "Right"

        End If
    End Sub
End Class
