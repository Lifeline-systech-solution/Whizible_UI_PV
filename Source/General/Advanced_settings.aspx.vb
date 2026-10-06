Public Class Advanced_settings
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub



    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        'Added By Dipali V On 20th April 2017 For Unauthenticated User Restrications
        Dim strUserID As String = Session("intUserID").ToString()
        'End of Added By Dipali V On 20th April 2017 For Unauthenticated User Restrications
    End Sub
#End Region

    Private m_strAllocationLevel As String
    Private m_strEnableAllocation As String
    Private m_strResAllocationValue As String
    'Private ResourceAllocation As Boolean
    Private m_strResourcePool As String
    Private resPool As Boolean
    'For bench related changes
    Private m_strBenchInternalProj As String
    Private m_strBenchGlobalProj As String
    Private m_strBenchResStatus As String
    Private m_strBenchNonDeployable As String


    Public Sub BuildPage()
        '=====================================================================
        ' Procedure Name        : BuildPage()	
        ' Purpose               : Main procedure to build the page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuchitraP
        ' Created               : Feb 15, 2008
        ' Revisions             :
        '=====================================================================

        ''Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.

        If Not Request.QueryString("Action") Is Nothing OrElse Request.QueryString("Action") <> "" Then
            If Request.QueryString("Action").ToUpper = "SAVE" Then
                Call SaveData()
            End If
        End If

        Call SetVariables()
        Response.Write(GenerateMenu())
        Response.Write("<BR>")
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Advanced Settings", , , True))
        Response.Write("<BR>")
        Call DisplayPageDetails()
        Response.Write(GenerateMenu())



    End Sub
    Private Sub SaveData()
        Dim strQuery As String
        Dim strSQL As String
        Dim strQry As String
        Dim Before_Upd_AllowResourceAllocation As String
        Dim ExpenseWF As String
        'Added by PrashantD
        Dim drCompanyInfo As IDataReader
        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        ''drCompanyInfo = CommonFunction.Data.GetDataReader("SELECT CAST(ISNULL(AllowResourceAllocation,0) AS INT) AllowResourceAllocation ,CAST(ISNULL(ExpenseWorkflow,0) AS INT) ExpenseWorkflow  FROM tbl_PM_CompanyInformation", MyBase.UseSQL)
        drCompanyInfo = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation_AllowResourceAllocation", MyBase.UseSQL)
        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        drCompanyInfo.Read()
        Before_Upd_AllowResourceAllocation = CType(drCompanyInfo("AllowResourceAllocation"), String)
        ExpenseWF = CType(drCompanyInfo("ExpenseWorkflow"), String)
        CommonFunction.Data.DisposeDataReader(drCompanyInfo)
        'End of addition by PrashantD

        If Not Request.Form("cboResourceAllocationLevel") Is Nothing OrElse Request.Form("cboResourceAllocationLevel") <> "" Then
            m_strAllocationLevel = Request.Form("cboResourceAllocationLevel")
        End If

        If Not Request.Form("chkResourceAllocation") Is Nothing Then
            m_strEnableAllocation = Request.Form("chkResourceAllocation")
        Else
            m_strEnableAllocation = "0"
        End If

        If Not Request.Form("chkResourcePool") Is Nothing OrElse Request.Form("chkResourcePool") <> "" Then
            m_strResourcePool = Request.Form("chkResourcePool")
        Else
            m_strResourcePool = "0"
        End If


        If Not Request.Form("txtResAllocationValue") Is Nothing OrElse Request.Form("txtResAllocationValue") <> "" Then
            m_strResAllocationValue = Request.Form("txtResAllocationValue")
            'Else
            '    m_strResAllocationValue = "0"
        End If

        'addition For bench related data
        If Not Request.Form("chkInternalProj") Is Nothing OrElse Request.Form("chkInternalProj") <> "" Then
            m_strBenchInternalProj = Request.Form("chkInternalProj")
        Else
            m_strBenchInternalProj = "0"
        End If

        If Not Request.Form("chkGlobalProj") Is Nothing OrElse Request.Form("chkGlobalProj") <> "" Then
            m_strBenchGlobalProj = Request.Form("chkGlobalProj")
        Else
            m_strBenchGlobalProj = "0"
        End If

        If Not Request.Form("chkResourceStatus") Is Nothing OrElse Request.Form("chkResourceStatus") <> "" Then
            m_strBenchResStatus = Request.Form("chkResourceStatus")
        Else
            m_strBenchResStatus = "0"
        End If

        If Not Request.Form("chkNonDeployable") Is Nothing OrElse Request.Form("chkNonDeployable") <> "" Then
            m_strBenchNonDeployable = Request.Form("chkNonDeployable")
        Else
            m_strBenchNonDeployable = "0"
        End If
        'End for bench related data


        strQuery = "UPDATE tbl_PM_CompanyInformation SET "
        If Not m_strAllocationLevel Is Nothing OrElse m_strAllocationLevel <> "" Then
            strQuery += "ResourceAllocationLevel='" + m_strAllocationLevel + "',"
        End If
        strQuery += "AllowResourceAllocation =" + m_strEnableAllocation
        CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

        'strSQL = "UPDATE tbl_SEM_Settings SET SettingValue=" + m_strResAllocationValue + " WHERE SettingName='RESOURCE_ALLOCATION'"
        'CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        'strQry = "UPDATE tbl_SEM_Settings SET SettingValue=" + m_strResourcePool + " WHERE SettingName='RESOURCEPOOLMANDATORY'"

        strSQL = "usp_upd_tbl_SEM_Settings " + m_strResAllocationValue + "," + m_strResourcePool + "," + m_strBenchInternalProj + "," + m_strBenchGlobalProj + "," + m_strBenchResStatus + "," + m_strBenchNonDeployable
        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        CommonEngines.HashTables.GetHashTableObject.ClearTreeHashTable()



        'Added by PrashantD on 21 Feb 2007 
        If Before_Upd_AllowResourceAllocation <> m_strEnableAllocation Then
            CommonFunction.Data.InsertOrUpdateData("usp_tbl_PM_CompanyInformation_afterUpdateTriggers 1,0,0,0,0,0,0,0," + ExpenseWF + ",0", MyBase.UseSQL)
        End If

        'Reload Application Settings
        Call CommonFunctions.General.GetCorporateSettings(True)
        Call CommonFunction.General.LoadCompanyApplicationSettings()

        'Purpose    :   To Refresh the hashtable for Project Settings and Customer maintainance
        CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CommonFunction.Constants.APP_TAG_PROJECT_SETTINGS)
        CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CommonFunction.Constants.APP_TAG_CUSTOMER_MASTER)

        'Purpose    :   To Refresh the hashtable for Project Creation workflow
        CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CommonFunction.Constants.TAG_ROLE_MAINTENANCE)

        'Purpose    :   To Refresh the hashtable for Product Reprots
        CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CommonFunction.Constants.APP_TAG_TAB_PRODUCT_REPORTS)

        ''Purpose: To refresh the hashtable while checking or unchecking of IR Workflow Checkbox
        CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CommonFunction.Constants.APP_TAG_CORPORATE_SETTINGS)

        'End of addition by PrashantD on 21 Feb 2007



    End Sub
    Private Sub SetVariables()
        Dim strQuery As String
        Dim strSQL As String
        Dim CmpInfReader As IDataReader
        Dim SettingReader As IDataReader

        strQuery = "usp_sel_tbl_PM_CompanyInformation"
        CmpInfReader = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
        CmpInfReader.Read()
        m_strAllocationLevel = CType(CommonFunction.Data.CheckIsDBNull(CmpInfReader("ResourceAllocationLevel"), ""), String)
        m_strEnableAllocation = CType(CommonFunction.Data.CheckIsDBNull(CmpInfReader("AllowResourceAllocation"), ""), String)

        strQuery = ""
        strQuery = "usp_sel_tbl_SEM_Settings NULL"
        SettingReader = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While SettingReader.Read()
            Select Case SettingReader("SettingName").ToString.ToUpper
                Case "RESOURCE_ALLOCATION"
                    m_strResAllocationValue = CType(SettingReader("SettingValue"), String)
                Case "RESOURCEPOOLMANDATORY"
                    m_strResourcePool = CType(CommonFunction.Data.CheckIsDBNull(SettingReader("SettingValue"), ""), String)
                Case "BENCH_INTERNALPROJECTS"
                    m_strBenchInternalProj = CType(CommonFunction.Data.CheckIsDBNull(SettingReader("SettingValue"), ""), String)
                Case "BENCH_GLOBALPROJECTS"
                    m_strBenchGlobalProj = CType(CommonFunction.Data.CheckIsDBNull(SettingReader("SettingValue"), ""), String)
                Case "BENCH_RESOURCESTATUS"
                    m_strBenchResStatus = CType(CommonFunction.Data.CheckIsDBNull(SettingReader("SettingValue"), ""), String)
                Case "BENCH_NONDEPLOYABLE"
                    m_strBenchNonDeployable = CType(CommonFunction.Data.CheckIsDBNull(SettingReader("SettingValue"), ""), String)
            End Select
        End While

        'strQuery = ""
        'strQuery = "usp_sel_tbl_SEM_Settings 'RESOURCEPOOLMANDATORY'"
        'SettingResPoolReader = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
        'SettingResPoolReader.Read()
        'm_strResourcePool = CType(CommonFunction.Data.CheckIsDBNull(SettingResPoolReader("SettingValue"), ""), String)


        'strSQL = "usp_sel_tbl_SEM_Settings 'RESOURCE_ALLOCATION'"
        'SettingResAllocReader = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        'SettingResAllocReader.Read()
        'm_strResAllocationValue = CType(SettingResAllocReader("SettingValue"), String)

        'strSQL = ""
        'strSQL = "usp_sel_tbl_SEM_Settings 'BENCH_INTERNALPROJECTS'"
        'SettingBenchInternalProj = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)


        CommonFunction.Data.DisposeDataReader(CmpInfReader)
        CommonFunction.Data.DisposeDataReader(SettingReader)

    End Sub

    Private Function GenerateMenu() As String
        '=====================================================================
        ' function Name         : GenerateTopMenu()	
        ' Purpose               : To generate top menu
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuchitraP
        ' Created               : Feb 15, 2008
        ' Revisions             :
        '=====================================================================

        Dim ArrTopMenuCaptionsList As New ArrayList
        Dim ArrTopMenuToolTipsList As New ArrayList
        Dim ArrTopMenuFunctionsList As New ArrayList

        ArrTopMenuCaptionsList.Add("Save")
        ArrTopMenuToolTipsList.Add("Save")
        ArrTopMenuFunctionsList.Add("Save_OnClink()")

        ArrTopMenuCaptionsList.Add("?")
        ArrTopMenuToolTipsList.Add("Help")
        ArrTopMenuFunctionsList.Add("Help_OnClick('3914')")

        Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
        ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
        ArrTopMenuCaptionsList = Nothing

        Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String
        ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)
        ArrTopMenuToolTipsList = Nothing

        Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
        ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)
        ArrTopMenuFunctionsList = Nothing

        'Generate menu string and return
        Return WebPage.Templates.StaticMenu.DrawMenu(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True)

    End Function

    Public Sub DisplayPageDetails()
        '====================================================================
        ' Procedure Name        : DisplayPageDetails
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the page
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SuchitraP
        ' Created               : Feb 15, 2008
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String
        CommonFunctions.General.WriteHTML("<div id='AdvSettingsdiv' style='Overflow:auto;width:100%;Height:370px' >")
        CommonFunctions.General.WriteHTML("<table cellSpacing='0' class='clsTable' width='99.9%'>")
        CommonFunctions.General.WriteHTML("<TR width=99.9% class=clsTRPageCaption >")
        CommonFunctions.General.WriteHTML("<TD align='left' colspan=2>Resource Allocation Workflow Settings</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align=right> Enable Resource Allocation Workflow")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD align=left>&nbsp;")
        CommonFunction.HTMLControls.DrawCheckBox("chkResourceAllocation", "chkResourceAllocation", "clsCheckBox", CType(m_strEnableAllocation, Boolean), "1", , "onclick =Javascript:ResAlloc_Click()", , , , , )
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")


        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align=right> Resource Allocation Level")
        strSQL = "EXEC usp_Sel_tbl_PM_ResourceAllocationLevel "
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD align=left>&nbsp;")
        CommonFunction.HTMLControls.DrawComboBox("cboResourceAllocationLevel", strSQL, 150, m_strAllocationLevel, , True, , "clsComboBox", , , )
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")


        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align=right> Follow Centre of Excellence model")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD align=left>&nbsp;")
        CommonFunction.HTMLControls.DrawCheckBox("chkResourcePool", "chkResourcePool", "clsCheckBox", CType(m_strResourcePool, Boolean), "1", , , , , , , )
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD></TD>")
        CommonFunctions.General.WriteHTML("<TD align=left>[When checked,selection of Resource Pool will be mandatory while posting resource requisition request.]</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        CommonFunctions.General.WriteHTML("<TR width=99.9% class=clsTRPageCaption >")
        CommonFunctions.General.WriteHTML("<TD align='left' colspan=2>Resource Allocation Percentage</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align=right> Extend Upto")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD align=left>&nbsp;")
        ''  CommonFunction.HTMLControls.DrawTextBox("txtResAllocationValue", "txtResAllocationValue", "clsTextBox", 80, 3, m_strResAllocationValue, "right", , False, , , , )
        CommonFunction.HTMLControls.DrawTextBox("txtResAllocationValue", "txtResAllocationValue", "clsTextBox", 80, 3, m_strResAllocationValue, "right", , False, , , , , EnableHTMLEncode:=True)
        CommonFunctions.General.WriteHTML("(e.g. 100,120,140)</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        'CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD></TD><TD align=left >[Standard Allocation percentage is 100% <BR> This is applicable when Resource Allocation Workflow is off.]</TD>")
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD></TD><TD align=left >[Standard Allocation percentage is 100%.]</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        'Commented by SonalD on 12th Dec 2008
        'CommonFunctions.General.WriteHTML("<TR width=99.9% class=clsTRPageCaption >")
        'CommonFunctions.General.WriteHTML("<TD align='left' colspan=2>Bench Settings</TD>")
        'CommonFunctions.General.WriteHTML("</TR>")

        'Internal projects
        'CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        'CommonFunctions.General.WriteHTML("<TD align=right>Internal Project Resources")
        'CommonFunctions.General.WriteHTML("</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left>&nbsp;")
        'CommonFunction.HTMLControls.DrawCheckBox("chkInternalProj", "chkInternalProj", "clsCheckBox", CType(m_strBenchInternalProj, Boolean), "1", , , , , , , )
        'CommonFunctions.General.WriteHTML("</TD>")
        'CommonFunctions.General.WriteHTML("</TR>")
        'CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD></TD><TD align=left >[If checked, consider resources assigned on Internal Projects as 'On Bench']</TD>")
        'CommonFunctions.General.WriteHTML("</TR>")

        'Global projects
        'CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        'CommonFunctions.General.WriteHTML("<TD align=right> Global Project Resources")
        'CommonFunctions.General.WriteHTML("</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left>&nbsp;")
        'CommonFunction.HTMLControls.DrawCheckBox("chkGlobalProj", "chkGlobalProj", "clsCheckBox", CType(m_strBenchGlobalProj, Boolean), "1", , , , , , , )
        'CommonFunctions.General.WriteHTML("</TD>")
        'CommonFunctions.General.WriteHTML("</TR>")
        'CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD></TD><TD align=left >[If checked, consider resources assigned on Global Projects as 'On Bench']</TD>")
        'CommonFunctions.General.WriteHTML("</TR>")

        'Resource status
        'CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        'CommonFunctions.General.WriteHTML("<TD align=right>On Bench Project Resource")
        'CommonFunctions.General.WriteHTML("</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left>&nbsp;")
        'CommonFunction.HTMLControls.DrawCheckBox("chkResourceStatus", "chkResourceStatus", "clsCheckBox", CType(m_strBenchResStatus, Boolean), "1", , , , , , , )
        'CommonFunctions.General.WriteHTML("</TD>")
        'CommonFunctions.General.WriteHTML("</TR>")
        'CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD></TD><TD align=left >[If checked, consider resources assigned on projects with resource status mapped to 'On Bench']</TD>")
        'CommonFunctions.General.WriteHTML("</TR>")

        'Non Deployable 
        'CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        'CommonFunctions.General.WriteHTML("<TD align=right> Include Non-deployable resources")
        'CommonFunctions.General.WriteHTML("</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left>&nbsp;")
        'CommonFunction.HTMLControls.DrawCheckBox("chkNonDeployable", "chkNonDeployable", "clsCheckBox", CType(m_strBenchNonDeployable, Boolean), "1", , , , , , , )
        'CommonFunctions.General.WriteHTML("</TD>")
        'CommonFunctions.General.WriteHTML("</TR>")
        'CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD></TD><TD align=left >[If checked, consider non-deployable resources as 'On Bench']</TD>")
        'CommonFunctions.General.WriteHTML("</TR>")
        'End of comment by SonalD on 12th Dec 2008
        CommonFunctions.General.WriteHTML("</table>")

        CommonFunctions.General.WriteHTML("</div>")

    End Sub



End Class


