Public Class PM_ResourceBilling
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    '=====================================================================
    ' Page Name             : PM_ResourceBilling
    ' Purpose               : To change the password of the user
    ' Description           : This page is called from the Default.aspx page
    ' Parameters Passed     : 
    ' Assumptions           : 
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js, CommonValidations.js
    ' Author                : AbhijeetD
    ' Created               : 17th March 2004
    ' Revisions             : 
    '=====================================================================

    Private WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Private m_strclsTRColHeader As String = "'clsTRColumnHeader'"
    Private m_strClsTREven As String = "'clsTREven'"
    Private m_strClsTROdd As String = "'clsTROdd'"
    Private m_blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
    Private m_strAction As String

    Private m_strProjectEmployeeRoleID As String = ""
    Private m_strBillingType As String = ""
    Private m_strRateApplied As String = ""
    Private m_strCostApplied As String = ""
    Private m_strMonthlyFee As String = ""
    Private m_strBillingPercentage As String = ""
    Private m_blnIsAddMode As Boolean
    Private m_strRoleRate As String = ""
    Private m_strRoleCost As String = ""
    Private m_strEmployeeRate As String = ""
    Private m_strEmployeeCost As String = ""
    Private m_strUserName As String = ""


    Public Sub PageInit()
        Dim strMenu As String

        'Retrieve the query string parameters
        m_strProjectEmployeeRoleID = Request.QueryString("ProjectEmployeeRoleId")
        m_strAction = Request.QueryString("Action")
        m_strBillingType = Request.QueryString("BillingType")

        'Store the ProjectEmployeeRoleID inside a hidden variable: used while submitting the form
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        ''CommonFunction.HTMLControls.DrawTextBox("hdProjectEmployeeRoleID", "hdProjectEmployeeRoleID", , , , m_strProjectEmployeeRoleID, , , , , , True)
        CommonFunction.HTMLControls.DrawTextBox("hdProjectEmployeeRoleID", "hdProjectEmployeeRoleID", , , , m_strProjectEmployeeRoleID, , , , , , True, EnableHTMLEncode:=True)
        'Handle the actions to be taken on PostBack
        If MyBase.Page.IsPostBack Then
            UpdateData()
        End If

        'Render top menu
        strMenu = DrawMenu()
        Response.Write(strMenu)

        'Read the billing data from the database
        ReadBillingInformation()

        'Render the Page Legend
        Dim arrLegend() As String = {MyBase.GetResourceString("MANDATORY")}
        Dim arrLegendImage() As String = {CommonFunctions.HTMLControls.DrawMandatoryImage(, True)}
        CommonFunction.General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend) + vbCrLf)

        'Draw Header
        Dim objHeader As New WebPage.Templates.HeaderFooter
        objHeader.HeaderFooter = ""
        objHeader.DrawHeaderFooter()
        objHeader = Nothing

        CommonFunction.General.WriteHTML("<BR>")

        'Render page caption
        CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"), m_strUserName, , True))
        CommonFunction.General.WriteHTML("<BR>")

        Response.Write("<DIV ID='PageDiv' Style='Height:300px;WIDTH:100%;OVERFLOW:auto;'>")

        'Render UI for the page
        DrawPage()
        Response.Write("</DIV>")

        'Render botton menu
        Response.Write("<br>" + strMenu)

    End Sub

    Public Sub New()
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
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
        '=====================================================================

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_BACK"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_BACK"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrClientSideFunctions() As String = {"Save_OnClick()", "Back_OnClick()", "Help_OnClick('1060')"}
        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        MyBase.InitializeResources("AppResources.PM_ResourceBilling", "AppResources")
        Return (strMenu)

    End Function

    Private Sub ReadBillingInformation()
        '=====================================================================
        ' Procedure Name        : ReadBillingInformation
        ' Purpose               : To read the billing information for the ProjectEmployeeRoleID from the database
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 20th March 2004
        ' Revisions             :
        '=====================================================================

        Dim drReader As IDataReader
        Dim strRoleID As String
        Dim strEmployeeID As String
        Dim arrTemp As String()

        drReader = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ProjectEmployeeRole " + m_strProjectEmployeeRoleID, m_blnUseSQL)
        If drReader.Read Then
            m_strUserName = CommonFunction.Data.CheckIsDBNull(drReader("UserName")).ToString
            m_strBillingType = CommonFunction.Data.CheckIsDBNull(drReader("BillingType")).ToString
            m_strRateApplied = CommonFunction.Data.CheckIsDBNull(drReader("Rate")).ToString
            m_strCostApplied = CommonFunction.Data.CheckIsDBNull(drReader("Cost")).ToString
            m_strBillingPercentage = CommonFunction.Data.CheckIsDBNull(drReader("BillingPercentage")).ToString
            m_strMonthlyFee = CommonFunction.Data.CheckIsDBNull(drReader("MonthlyFee")).ToString

            'Get the pipe separated values of RoleRate, RoleCost, EmployeeRate ane EmployeeCost
            strRoleID = CommonFunction.Data.CheckIsDBNull(drReader("RoleID")).ToString
            strEmployeeID = CommonFunction.Data.CheckIsDBNull(drReader("EmployeeID")).ToString

            'Split RoleID to get values of RoleRate and RoleCost
            arrTemp = strRoleID.Split("|"c)
            m_strRoleRate = arrTemp(1)
            m_strRoleCost = arrTemp(2)

            'Split EmployeeID to get values of EmployeeRate and EmployeeCost
            arrTemp = strEmployeeID.Split("|"c)
            m_strEmployeeRate = arrTemp(1)
            m_strEmployeeCost = arrTemp(2)

            'Set the mode by checking whether a value is entered for Rate or Cost
            If (m_strRateApplied = "" Or m_strCostApplied = "") Then
                m_blnIsAddMode = True
                'Hidden control to store the mode type:used for adjusting the div height
                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                '    CommonFunction.HTMLControls.DrawTextBox("hdAddMode", "hdAddMode", , , , "1", , , , , , True)
                'Else
                '    CommonFunction.HTMLControls.DrawTextBox("hdAddMode", "hdAddMode", , , , "0", , , , , , True)
                CommonFunction.HTMLControls.DrawTextBox("hdAddMode", "hdAddMode", , , , "1", , , , , , True, EnableHTMLEncode:=True)
            Else
                CommonFunction.HTMLControls.DrawTextBox("hdAddMode", "hdAddMode", , , , "0", , , , , , True, EnableHTMLEncode:=True)
            End If
            ''end of Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        End If
        CommonFunction.Data.DisposeDataReader(drReader)

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
        ' Created               : 20th March 2004
        ' Revisions             :
        '=====================================================================

        'Render the client side tabs for 'Time and Material' and 'Fixed Rate'
        Dim arrTabName As String() = {MyBase.GetResourceString("TIME_AND_MATERIAL"), MyBase.GetResourceString("FIXED_RATE")}
        Dim arrTabToolTip As String() = {MyBase.GetResourceString("TIME_AND_MATERIAL"), MyBase.GetResourceString("FIXED_RATE")}
        Dim arrDIVID() As String = {"divTimeAndMaterial", "divFixedRate"}
        Dim objTab As New WebPage.Templates.ClientSideTabs
        Dim strStyleTimeAndMaterial As String = "WIDTH:100%;OVERFLOW:auto;"
        Dim strStyleFixedRate As String = "WIDTH:100%;OVERFLOW:auto;"

        'Show the div depending upon the billing type
        If m_strBillingType = "T" Then
            strStyleFixedRate = strStyleFixedRate + "DISPLAY:none"
        Else
            strStyleTimeAndMaterial = strStyleTimeAndMaterial + "DISPLAY:none"
        End If

        With objTab
            .TabNameArray = arrTabName
            .TooltipArray = arrTabToolTip
            .TabOnclickFunctionName = "SwitchView"
            .ReturnHTML = False
            .Align = "RIGHT"
            .FormName = "frmResourceBilling"
            If m_strBillingType = "T" Then
                .SelectedTab = MyBase.GetResourceString("TIME_AND_MATERIAL")

            Else
                .SelectedTab = MyBase.GetResourceString("FIXED_RATE")
            End If
            .DIVIDArray = arrDIVID
            CommonFunctions.General.WriteHTML(.DrawTabs())
            Response.Write(.ClientSideScript)
        End With
        objTab = Nothing

        'Render UI for 'Time and Material'
        Response.Write("<DIV ID='divTimeAndMaterial' Style='" + strStyleTimeAndMaterial + "'>")
        DrawTimeAndMaterialUI()
        Response.Write("</DIV>")

        'Render UI for 'Fixed Rate'
        Response.Write("<DIV ID='divFixedRate' Style='" + strStyleFixedRate + "'>")
        DrawFixedRateUI()
        Response.Write("</DIV>")

    End Sub

    Private Sub DrawTimeAndMaterialUI()
        '=====================================================================
        ' Procedure Name        : DrawTimeAndMaterialUI
        ' Purpose               : Renders the UI for Time and Material tab
        ' Description           : This function generates the UI for Time and Material tab. The function generates UI 
        '                         depending upon whether a value exists in m_strProjectEmployeeRoleID or not
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 20th March 2004
        ' Revisions             :
        '=====================================================================

        CommonFunction.General.WriteHTML("<TABLE class='clsSubTagTable' width='99.9%' cellspacing=0 cellpadding=0>")
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTROdd + ">")
        CommonFunction.General.WriteHTML("<td colspan='4'>")
        CommonFunction.General.WriteHTML("<b>")
        If m_blnIsAddMode Then
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("APPLY_RATE_PER_HOUR_AND_COST_PER_HOUR_FOR_THE_ASSIGNED_RESOURCE"))
        Else
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("APPLIED_RATE_AND_COST"))
        End If
        CommonFunction.General.WriteHTML("</b>")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")

        'If the Rate/Hour and Cost/Hour options are not set
        If m_blnIsAddMode Then
            'Render UI for setting 'Time And Material' options
            CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
            CommonFunction.General.WriteHTML("<td  colspan='2'>")
            CommonFunction.HTMLControls.DrawOptionButton("optRate", "optRate", , , , , "Language='JavaScript' onClick=optRate_OnClick(" + m_strRoleRate + ")")
            CommonFunction.General.WriteHTML("&nbsp;" + MyBase.GetResourceString("APPLY_STANDARD_ROLE_RATE_PER_HOUR_TO_THIS_ASSIGNMENT"))
            CommonFunction.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("<td  colspan='2'>")
            CommonFunction.HTMLControls.DrawOptionButton("optCost", "optCost", , , , , "Language='JavaScript' onClick=optCost_OnClick(" + m_strRoleCost + ")")
            CommonFunction.General.WriteHTML("&nbsp;" + MyBase.GetResourceString("APPLY_STANDARD_ROLE_COST_PER_HOUR_TO_THIS_ASSIGNMENT"))
            CommonFunction.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("</tr>")
            CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
            CommonFunction.General.WriteHTML("<td  colspan='2'>")
            CommonFunction.HTMLControls.DrawOptionButton("optRate", "optRate", , , , , "Language='JavaScript' onClick=optRate_OnClick(" + m_strEmployeeRate + ")")
            CommonFunction.General.WriteHTML("&nbsp;" + MyBase.GetResourceString("APPLY_RESOURCE_RATE_PER_HOUR_TO_THIS_ASSIGNMENT"))
            CommonFunction.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("<td  colspan='2'>")
            CommonFunction.HTMLControls.DrawOptionButton("optCost", "optCost", , , , , "Language='JavaScript' onClick=optCost_OnClick(" + m_strEmployeeCost + ")")
            CommonFunction.General.WriteHTML("&nbsp;" + MyBase.GetResourceString("APPLY_RESOURCE_COST_PER_HOUR_TO_THIS_ASSIGNMENT"))
            CommonFunction.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("</tr>")
            CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
            CommonFunction.General.WriteHTML("<td colspan='2'>")
            CommonFunction.HTMLControls.DrawOptionButton("optRate", "optRate", , True, , , "Language='JavaScript' onClick=optRate_OnClick(-1)")
            CommonFunction.General.WriteHTML("&nbsp;" + MyBase.GetResourceString("APPLY_CUSTOM_RATE_PER_HOUR_TO_THIS_ASSIGNMENT"))
            CommonFunction.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("<td colspan='2'>")
            CommonFunction.HTMLControls.DrawOptionButton("optCost", "optCost", , True, , , "Language='JavaScript' onClick=optCost_OnClick(-1)")
            CommonFunction.General.WriteHTML("&nbsp;" + MyBase.GetResourceString("APPLY_CUSTOM_COST_PER_HOUR_TO_THIS_ASSIGNMENT"))
            CommonFunction.General.WriteHTML("</td>")
            CommonFunction.General.WriteHTML("</tr>")
        End If

        'Render UI for setting the values of 'Time And Material' parameters
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("<td align='right'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("RATE_PER_HOUR"))
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td align='left'>")
        'Modified by PrachiK on 9 Mar 2005 for IssueID 16456
        'Purpose:Projects :-> Resource Billing :- Issues for the fields that are present on the page.
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        ''CommonFunction.HTMLControls.DrawTextBox("txtActualRate", "txtActualRate", , 70, 8, m_strRateApplied, "Right", , , , , , , , True)
        CommonFunction.HTMLControls.DrawTextBox("txtActualRate", "txtActualRate", , 70, 8, m_strRateApplied, "Right", , , , , , , , True, EnableHTMLEncode:=True)
        'Modification ended
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td align='right'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COST_PER_HOUR"))
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td align='left' >")
        'Modified by PrachiK on 9 Mar 2005 for IssueID 16456
        'Purpose:Projects :-> Resource Billing :- Issues for the fields that are present on the page.
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        '' CommonFunction.HTMLControls.DrawTextBox("T_txtActualCost", "T_txtActualCost", , 70, 8, m_strCostApplied, "Right", , , , , , , , True)
        CommonFunction.HTMLControls.DrawTextBox("T_txtActualCost", "T_txtActualCost", , 70, 8, m_strCostApplied, "Right", , , , , , , , True, EnableHTMLEncode:=True)
        'Modification ended
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr>")
        CommonFunction.General.WriteHTML("<td>")
        CommonFunction.General.WriteHTML("<div id=divTab1 Style='HEIGHT:300px;WIDTH:100%;OVERFLOW:auto;'>")
        CommonFunction.General.WriteHTML("</div>")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("</TABLE>")

    End Sub

    Private Sub DrawFixedRateUI()
        '=====================================================================
        ' Procedure Name        : DrawFixedRateUI
        ' Purpose               : Renders the UI for Fixed Rate tab
        ' Description           : This function generates the UI for Fixed Rate tab. 
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 20th March 2004
        ' Revisions             :
        '=====================================================================

        'Render UI for setting the values of 'Fixed Rate' parameters
        CommonFunction.General.WriteHTML("<TABLE class='clsSubTagTable' width='99.9%' cellspacing=0 cellpadding=0>")
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTROdd + ">")
        CommonFunction.General.WriteHTML("<td colspan='4' >")
        CommonFunction.General.WriteHTML("<b>")
        If m_blnIsAddMode Then
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("FILL_BILLING_INFORMATION_FOR_THE_ASSIGNED_RESOURCE"))
        Else
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("BILLING_INFORMATION"))
        End If
        CommonFunction.General.WriteHTML("</b>")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("<td align=right>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("MONTHLY_FEE"))
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td>")
        'Modified by PrachiK on 9 Mar 2005 for IssueID 16456
        'Purpose:Projects :-> Resource Billing :- Issues for the fields that are present on the page.
        '' CommonFunction.HTMLControls.DrawTextBox("txtMonthlyFee", "txtMonthlyFee", , 70, 8, m_strMonthlyFee, "Right", , , , , , , , True)
        CommonFunction.HTMLControls.DrawTextBox("txtMonthlyFee", "txtMonthlyFee", , 70, 8, m_strMonthlyFee, "Right", , , , , , , , True, EnableHTMLEncode:=True)
        'Modification ended
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td align=right>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("BILLING_PERCENT"))
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td>")
        'Modified by PrachiK on 9 Mar 2005 for IssueID 16456
        'Purpose:Projects :-> Resource Billing :- Issues for the fields that are present on the page.
        ''CommonFunction.HTMLControls.DrawTextBox("txtBillingPercentage", "txtBillingPercentage", , 70, 8, m_strBillingPercentage, "Right", , , , , , , , True)
        CommonFunction.HTMLControls.DrawTextBox("txtBillingPercentage", "txtBillingPercentage", , 70, 8, m_strBillingPercentage, "Right", , , , , , , , True, EnableHTMLEncode:=True)
        'Modification ended
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("<td align='right'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("COST_PER_HOUR"))
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td align='left'>")
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        ''CommonFunction.HTMLControls.DrawTextBox("F_txtActualCost", "F_txtActualCost", , 70, 8, m_strCostApplied, "Right", , , , , , , , True)
        CommonFunction.HTMLControls.DrawTextBox("F_txtActualCost", "F_txtActualCost", , 70, 8, m_strCostApplied, "Right", , , , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td align='right' >")
        CommonFunction.General.WriteHTML("&nbsp;")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td align='left' >")
        CommonFunction.General.WriteHTML("&nbsp;")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr>")
        CommonFunction.General.WriteHTML("<td>")
        CommonFunction.General.WriteHTML("<div id=divTab2 Style='HEIGHT:300px;WIDTH:100%;OVERFLOW:auto;'>")
        CommonFunction.General.WriteHTML("</div>")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("</TABLE>")

    End Sub

    Private Sub UpdateData()
        '=====================================================================
        ' Procedure Name        : UpdateData
        ' Purpose               : Update the data to the database
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 23rd March 2004
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String
        m_strRateApplied = MyBase.FixString(MyBase.GetFormValue("txtActualRate"), 8, True, True)
        m_strBillingPercentage = MyBase.FixString(MyBase.GetFormValue("txtBillingPercentage"), 8, True, True)
        m_strMonthlyFee = MyBase.FixString(MyBase.GetFormValue("txtMonthlyFee"), 8, True, True)
        m_strCostApplied = MyBase.FixString(MyBase.GetFormValue(m_strBillingType + "_txtActualCost"), 8, True, True)

       
        'Addtion By PrachiK on 7 Mar 2005 for Issue ID. 16456
        'Purpose: Projects :-> Resource Billing :- Issues for the fields that are present on the page.
        Dim intPos As Integer
        Dim intlength As Integer
        If m_strRateApplied = "" Then
            m_strRateApplied = "0"
        Else
            intPos = InStr(1, m_strRateApplied, "+", CompareMethod.Text)
            If intPos >= 1 Then
                intlength = Len(m_strRateApplied)
                m_strRateApplied = Right(m_strRateApplied, intlength - 1)
            End If
        End If
        If m_strBillingPercentage = "" Then
            m_strBillingPercentage = "0"
        Else
            intPos = InStr(1, m_strBillingPercentage, "+", CompareMethod.Text)
            If intPos >= 1 Then
                intlength = Len(m_strBillingPercentage)
                m_strBillingPercentage = Right(m_strBillingPercentage, intlength - 1)
            End If
        End If
        If m_strMonthlyFee = "" Then
            m_strMonthlyFee = "0"
        Else
            intPos = InStr(1, m_strMonthlyFee, "+", CompareMethod.Text)
            If intPos >= 1 Then
                intlength = Len(m_strMonthlyFee)
                m_strMonthlyFee = Right(m_strMonthlyFee, intlength - 1)
            End If
        End If
        If m_strCostApplied = "" Then
            m_strCostApplied = "0"
        Else
            intPos = InStr(1, m_strCostApplied, "+", CompareMethod.Text)
            If intPos >= 1 Then
                intlength = Len(m_strCostApplied)
                m_strCostApplied = Right(m_strCostApplied, intlength - 1)
            End If
        End If
        'Addtion ended
        If m_strBillingType = "T" Then
            strSQL = "usp_Upd_tbl_PM_ProjectEmployeeRole_New " + m_strProjectEmployeeRoleID + ", '" + m_strBillingType + "', " + m_strRateApplied + ", " + m_strCostApplied
        ElseIf m_strBillingType = "F" Then
            strSQL = "usp_Upd_tbl_PM_ProjectEmployeeRole_New " + m_strProjectEmployeeRoleID + ", " + m_strBillingType + ", NULL, " + m_strCostApplied + ", '" + m_strMonthlyFee + "', " + m_strBillingPercentage
        End If
        CommonFunction.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

    End Sub
End Class
