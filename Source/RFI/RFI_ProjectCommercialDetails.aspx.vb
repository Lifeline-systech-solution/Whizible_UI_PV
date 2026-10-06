'**********************************************************************************
'                  CSPL Code Header
' Project Name     :	Chanakya Enhancements
' Module Name      :	RFI_ProjectCommercialDetails.aspx
' Purpose          :	To fill the details of Project Commercial details based on Commercial details settings
' Description      :	To fill the details of Project Commercial details based on Commercial details settings
' Assumptions      :	None.
' Dependencies     :	
' Author           :	NitinVS
' Reviewed         :	
' Tested           :	
' Created          :	19th jun 2007
' Revisions        :	
'**********************************************************************************

Public Class RFI_ProjectCommercialDetails
    Inherits WebPages.Template.WhizTemplate

#Region "Class Variables"
    Protected m_strMode As String = ""
    Protected m_strAction As String = ""
    Protected m_ProjectID As String = ""
    Protected m_ContractTypeID As String = ""
    Protected m_ProjectName As String = ""
    Protected m_CurrencySymbol As String = ""
    Protected m_ContractType As String = ""
    Protected m_BaseCurrency As String = ""
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    'Menu
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu

#End Region

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

        ' Added By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added  By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Put user code to initialize the page here
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        If m_objGlobal.TagID <> 2087 Then
            m_objGlobal.TagID = 2087
        End If
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

        Call InitVariables()


    End Sub
    Protected Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : This function is get called after form load.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : 19th jun 2007
        ' Revisions             :
        '=====================================================================
        Dim sbSTRHTML As New System.Text.StringBuilder

        If m_strAction = "SAVE" Then
            Call PerformAction()
        End If

        DrawMenu()

        sbSTRHTML.Append("<div id='PageDiv' name='PgeDiv' style='overflow:auto;width:99.99%;height=450'>")
        sbSTRHTML.Append("<TABLE id='tblPorject' CellSpacing=0 width='99.9%' class=clsTable><TR class=clsTRBlank><TD align='Right'><B>(<IMG src=""../../Images/Star.gif"" border=0> Mandatory)</B></TD></TR></TABLE>")
        sbSTRHTML.Append(WebPages.Template.PageCaption.GetPageCaptions(, m_ContractType, , , True))
        sbSTRHTML.Append("<br>")
        sbSTRHTML.Append("<TABLE id='tbllegend' CellSpacing=0 width='99.9%' class=clsTable>")
        sbSTRHTML.Append("<TR class=clsTREven><TD width=20% align='Right'>" + MyBase.GetResourceString("CAP_PROJECT") + "</TD><TD width=80% align='left'>" + m_ProjectName + "</TD></TR>")
        sbSTRHTML.Append("<TR class=clsTREven><TD width=20% align='Right'>" + MyBase.GetResourceString("CAP_PROJECT_CURRENCY") + "</TD><TD width=80% align='left'>" + m_CurrencySymbol + "</TD></TR>")
        sbSTRHTML.Append("</TABLE>")

        ' Hidden elements
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        sbSTRHTML.Append(CommonFunction.HTMLControls.DrawTextBox("RateFor", "RateFor", , 100, 15, m_ContractTypeID, "right", , , , , , , True, , , , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding

        If m_ContractTypeID = "2" Or m_ContractTypeID = "3" Then
            Call DrawCeillingAmountDetails(sbSTRHTML)
        End If

        If m_ContractTypeID = "2" Then
            Call DrawResourceGrid(sbSTRHTML)
        ElseIf m_ContractTypeID = "3" Then
            Call DrawRoleGrid(sbSTRHTML)
        ElseIf m_ContractTypeID = "5" Then
            Call drawFixedFeeGrid(sbSTRHTML)
        End If


        sbSTRHTML.Append("</div>")
        sbSTRHTML.Append("<br>")
        CommonFunction.General.WriteHTML(sbSTRHTML.ToString())

        DrawMenu()
    End Sub
    Private Sub DrawResourceGrid(ByRef sbSTRHTML As System.Text.StringBuilder)
        '=====================================================================
        ' Procedure Name        : DrawResourceGrid()	
        ' Purpose               : This function draws editable grid for resources on project.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : 19th jun 2007
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = "usp_sel_tbl_PM_WorkOrderRateContractDetail " + m_ProjectID + " ,'resource'"
        Dim objDR As IDataReader
        Dim lngCounter As Long = 0
        Dim RateForId As String = ""
        Dim Rate As String = ""
        Dim role As String = ""
        Dim roleRate As String = ""
        Dim RatePerHour As String = ""
        Dim showHistory As String = ""
        Dim RateContractDetailID As String = ""

        objDR = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        sbSTRHTML.Append("<br>")
        sbSTRHTML.Append("<table id='tblresource'   CellSpacing=1 CellPadding=0  width='99.9%' class=clsGridTable>")
        sbSTRHTML.Append("<tr class='clsTRColumnHeader'>")
        sbSTRHTML.Append("<td align=left>")
        sbSTRHTML.Append(MyBase.GetResourceString("CAP_EMPLOYEE_NAME"))
        sbSTRHTML.Append("</td>")
        sbSTRHTML.Append("<td align=left>")
        sbSTRHTML.Append(MyBase.GetResourceString("CAP_ROLE")) ' ToDO 
        sbSTRHTML.Append("</td>")
        sbSTRHTML.Append("<td align=center>")
        sbSTRHTML.Append(MyBase.GetResourceString("CAP_PROJECT_RATE")) ' ToDO 
        sbSTRHTML.Append("</td>")
        sbSTRHTML.Append("<td align=center>")
        sbSTRHTML.Append(MyBase.GetResourceString("CAP_SHOW_HISTORY")) ' 
        sbSTRHTML.Append("</td>")
        sbSTRHTML.Append("</tr>")

        While objDR.Read()

            lngCounter += 1

            RateForId = CType(CommonFunction.Data.CheckIsDBNull(objDR("EmployeeID"), ""), String)
            If CType(CommonFunction.Data.CheckIsDBNull(objDR("RateYear1"), ""), String) <> "" Then
                Rate = FormatNumber(objDR("RateYear1"), 2, , , TriState.False)
            Else
                Rate = "0"
            End If
            role = CType(CommonFunction.Data.CheckIsDBNull(objDR("roleDescription"), ""), String)
            roleRate = CType(CommonFunction.Data.CheckIsDBNull(objDR("Rate"), ""), String)
            RatePerHour = CType(CommonFunction.Data.CheckIsDBNull(objDR("RatePerHour"), ""), String)
            showHistory = CType(CommonFunction.Data.CheckIsDBNull(objDR("showHistory"), ""), String)
            RateContractDetailID = CType(CommonFunction.Data.CheckIsDBNull(objDR("RateContractDetailID"), ""), String)

            If lngCounter / 2 = 0 Then
                sbSTRHTML.Append("<tr class='clsTREven'>")
            Else
                sbSTRHTML.Append("<tr class='clsTROdd'>")
            End If

            sbSTRHTML.Append("<td align=left")
            sbSTRHTML.Append(" Title =""")
            sbSTRHTML.Append(MyBase.GetResourceString("CAP_CORPORATE_CURRENCY"))
            sbSTRHTML.Append(" : " + m_BaseCurrency + vbCrLf)
            sbSTRHTML.Append(MyBase.GetResourceString("CAP_ROLE_STANDARD_BILLING_RATE"))
            sbSTRHTML.Append(" : " + roleRate + vbCrLf)
            sbSTRHTML.Append(MyBase.GetResourceString("CAP_EMPLOYEE_RATE_PER_HR"))
            sbSTRHTML.Append(" : " + RatePerHour + vbCrLf)
            sbSTRHTML.Append(""" >")
            sbSTRHTML.Append(CommonFunction.Data.CheckIsDBNull(objDR("EmployeeName"), ""))  'TODO
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            sbSTRHTML.Append(CommonFunction.HTMLControls.DrawTextBox("RateForID", "RateForID", , 50, 15, RateForId, "right", , , , , , , True, True, , , True, EnableHTMLEncode:=True))    'TODO
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            sbSTRHTML.Append("</td>")

            sbSTRHTML.Append("<td align=left>")
            sbSTRHTML.Append(role)  'TODO
            sbSTRHTML.Append("</td>")

            'sbSTRHTML.Append("<td align=right>")
            'sbSTRHTML.Append(roleRate)  'TODO
            'sbSTRHTML.Append("</td>")

            'sbSTRHTML.Append("<td align=right>")
            'sbSTRHTML.Append(RatePerHour)  'TODO
            'sbSTRHTML.Append("</td>")

            sbSTRHTML.Append("<td align=center>")
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            sbSTRHTML.Append(CommonFunction.HTMLControls.DrawTextBox("Rate", "Rate", , 100, 15, Rate, "right", , , , , , , True, True, EnableHTMLEncode:=True))  'TODO
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            sbSTRHTML.Append(" ")
            sbSTRHTML.Append(m_CurrencySymbol)
            sbSTRHTML.Append("</td>")

            sbSTRHTML.Append("<td align=center>")
            If showHistory = "1" Then
                sbSTRHTML.Append("<a href='javascript:History_OnClick(2058," + RateContractDetailID + ")' title='Show History'>" + MyBase.GetResourceString("CAP_SHOW_HISTORY") + "</a>")
            Else
                sbSTRHTML.Append("")
            End If
            sbSTRHTML.Append("</td>")

            sbSTRHTML.Append("</tr>")


        End While

        If lngCounter = 0 Then
            sbSTRHTML.Append("<tr class='clsTREven'><td colspan=4 align=center>" + MyBase.GetResourceString("MSG_NO_RECORD") + "</td></tr>")
        End If

        sbSTRHTML.Append("</table>")
        sbSTRHTML.Append("<br>")
        CommonFunction.Data.DisposeDataReader(objDR)


    End Sub
    Private Sub drawFixedFeeGrid(ByRef sbSTRHTML As System.Text.StringBuilder)
        '=====================================================================
        ' Procedure Name        : DrawResourceGrid()	
        ' Purpose               : This function draws editable grid for resources on project.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : 19th jun 2007
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = "usp_sel_tbl_PM_WorkOrderRateContractDetail " + m_ProjectID + " ,'FixedFee'"
        Dim objDR As IDataReader
        Dim lngCounter As Long = 0
        Dim RateForId As String = ""
        Dim Rate As String = ""
        Dim rolerate As String = ""
        Dim RatePerHour As String = ""
        Dim role As String = ""
        Dim showHistory As String = ""
        Dim ProjectEmployeeRoleID As String
        objDR = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        sbSTRHTML.Append("<br>")
        sbSTRHTML.Append("<table id='tblresource'   CellSpacing=1 CellPadding=0  width='99.9%' class=clsGridTable>")
        sbSTRHTML.Append("<tr class='clsTRColumnHeader'>")
        sbSTRHTML.Append("<td align=left>")
        sbSTRHTML.Append(MyBase.GetResourceString("CAP_EMPLOYEE_NAME"))
        sbSTRHTML.Append("</td>")
        sbSTRHTML.Append("<td align=left>")
        sbSTRHTML.Append(MyBase.GetResourceString("CAP_ROLE")) ' ToDO 
        sbSTRHTML.Append("</td>")
        sbSTRHTML.Append("<td align=center>")
        sbSTRHTML.Append(MyBase.GetResourceString("CAP_MONTHLY_RATE")) ' ToDO 
        sbSTRHTML.Append("</td>")
        sbSTRHTML.Append("<td align=center>")
        sbSTRHTML.Append(MyBase.GetResourceString("CAP_SHOW_HISTORY")) ' 
        sbSTRHTML.Append("</td>")
        sbSTRHTML.Append("</tr>")

        While objDR.Read()

            lngCounter += 1

            RateForId = CType(CommonFunction.Data.CheckIsDBNull(objDR("EmployeeID"), ""), String)
            If CType(CommonFunction.Data.CheckIsDBNull(objDR("MonthlyFee"), ""), String) <> "" Then
                Rate = FormatNumber(objDR("MonthlyFee"), 2, , , TriState.False)
            Else
                Rate = ""
            End If
            role = CType(CommonFunction.Data.CheckIsDBNull(objDR("roleDescription"), ""), String)
            rolerate = CType(CommonFunction.Data.CheckIsDBNull(objDR("Rate"), ""), String)
            RatePerHour = CType(CommonFunction.Data.CheckIsDBNull(objDR("RatePerHour"), ""), String)
            showHistory = CType(CommonFunction.Data.CheckIsDBNull(objDR("showHistory"), ""), String)
            ProjectEmployeeRoleID = CType(CommonFunction.Data.CheckIsDBNull(objDR("ProjectEmployeeRoleID"), ""), String)

            If lngCounter / 2 = 0 Then
                sbSTRHTML.Append("<tr class='clsTREven'>")
            Else
                sbSTRHTML.Append("<tr class='clsTROdd'>")
            End If

            sbSTRHTML.Append("<td align=left")
            sbSTRHTML.Append(" Title =""")
            sbSTRHTML.Append(MyBase.GetResourceString("CAP_CORPORATE_CURRENCY"))
            sbSTRHTML.Append(" : " + m_BaseCurrency + vbCrLf)
            sbSTRHTML.Append(MyBase.GetResourceString("CAP_ROLE_STANDARD_BILLING_RATE"))
            sbSTRHTML.Append(" : " + rolerate + vbCrLf)
            sbSTRHTML.Append(MyBase.GetResourceString("CAP_EMPLOYEE_RATE_PER_HR"))
            sbSTRHTML.Append(" : " + RatePerHour + vbCrLf)
            sbSTRHTML.Append(""" >")

            sbSTRHTML.Append(CommonFunction.Data.CheckIsDBNull(objDR("EmployeeName"), ""))  'TODO
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            sbSTRHTML.Append(CommonFunction.HTMLControls.DrawTextBox("RateForID", "RateForID", , 50, 15, RateForId, "right", , , , , , , True, True, , , True, EnableHTMLEncode:=True))    'TODO
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            sbSTRHTML.Append("</td>")


            sbSTRHTML.Append("<td align=left>")
            sbSTRHTML.Append(role)  'TODO
            sbSTRHTML.Append("</td>")

            sbSTRHTML.Append("<td align=center>")
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            sbSTRHTML.Append(CommonFunction.HTMLControls.DrawTextBox("Rate", "Rate", , 100, 15, Rate, "right", , , , , , , True, True, EnableHTMLEncode:=True))   'TODO
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            sbSTRHTML.Append(" ")
            sbSTRHTML.Append(m_CurrencySymbol)
            sbSTRHTML.Append("</td>")

            sbSTRHTML.Append("<td align=center>")
            If showHistory = "1" Then
                sbSTRHTML.Append("<a href='javascript:History_OnClick(1060," + ProjectEmployeeRoleID + ")' title='Show History'>" + MyBase.GetResourceString("CAP_SHOW_HISTORY") + "</a>")
            Else
                sbSTRHTML.Append("")
            End If
            sbSTRHTML.Append("</td>")

            sbSTRHTML.Append("</tr>")


        End While

        If lngCounter = 0 Then
            sbSTRHTML.Append("<tr class='clsTREven'><td colspan=4 align=center>" + MyBase.GetResourceString("MSG_NO_RECORD") + "</td></tr>")
        End If

        sbSTRHTML.Append("</table>")
        sbSTRHTML.Append("<br>")
        CommonFunction.Data.DisposeDataReader(objDR)


    End Sub
    Private Sub DrawRoleGrid(ByRef sbSTRHTML As System.Text.StringBuilder)
        '=====================================================================
        ' Procedure Name        : DrawRoleGrid()	
        ' Purpose               : This function draws editable grid for roles on project.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : 19th jun 2007
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = "usp_sel_tbl_PM_WorkOrderRateContractDetail " + m_ProjectID + " ,'role'"
        Dim objDR As IDataReader
        Dim lngCounter As Long = 0
        Dim RateForId As String = ""
        Dim Rate As String = ""
        Dim showHistory As String = ""
        Dim RoleRate As String = ""
        Dim RateContractDetailID As String = ""

        objDR = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        sbSTRHTML.Append("<br>")
        sbSTRHTML.Append("<table id='tblresource'   CellSpacing=1 CellPadding=0  width='99.9%' class=clsGridTable>")
        sbSTRHTML.Append("<tr class='clsTRColumnHeader'>")

        sbSTRHTML.Append("<td align=left>")
        sbSTRHTML.Append(MyBase.GetResourceString("CAP_ROLE"))
        sbSTRHTML.Append("</td>")

        sbSTRHTML.Append("<td align=center>")
        sbSTRHTML.Append(MyBase.GetResourceString("CAP_PROJECT_RATE"))
        sbSTRHTML.Append("</td>")

        sbSTRHTML.Append("<td align=center>")
        sbSTRHTML.Append(MyBase.GetResourceString("CAP_SHOW_HISTORY")) ' ToDO 
        sbSTRHTML.Append("</td>")

        sbSTRHTML.Append("</tr>")

        While objDR.Read()

            lngCounter += 1

            RateForId = CType(CommonFunction.Data.CheckIsDBNull(objDR("roleID"), ""), String)
            If CType(CommonFunction.Data.CheckIsDBNull(objDR("RateYear1"), ""), String) <> "" Then
                Rate = FormatNumber(objDR("RateYear1"), 2, , , TriState.False)
            Else
                Rate = ""
            End If
            RoleRate = CType(CommonFunction.Data.CheckIsDBNull(objDR("Rate"), ""), String)
            RateContractDetailID = CType(CommonFunction.Data.CheckIsDBNull(objDR("RateContractDetailID"), ""), String)
            showHistory = CType(CommonFunction.Data.CheckIsDBNull(objDR("showHistory"), ""), String)

            If lngCounter / 2 = 0 Then
                sbSTRHTML.Append("<tr class='clsTREven'>")
            Else
                sbSTRHTML.Append("<tr class='clsTROdd'>")
            End If

            sbSTRHTML.Append("<td align=left")
            sbSTRHTML.Append(" Title=""")
            sbSTRHTML.Append(MyBase.GetResourceString("CAP_CORPORATE_CURRENCY"))
            sbSTRHTML.Append(" : " + m_BaseCurrency + vbCrLf)
            sbSTRHTML.Append(MyBase.GetResourceString("CAP_ROLE_STANDARD_BILLING_RATE"))
            sbSTRHTML.Append(" : " + RoleRate + vbCrLf)
            sbSTRHTML.Append(""">")
            sbSTRHTML.Append(CommonFunction.Data.CheckIsDBNull(objDR("RoleDescription"), ""))  'TODO
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            sbSTRHTML.Append(CommonFunction.HTMLControls.DrawTextBox("RateForID", "RateForID", , 50, 15, RateForId, "right", , , , , , , True, True, , , True, EnableHTMLEncode:=True))    'TODO
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            sbSTRHTML.Append("</td>")


            sbSTRHTML.Append("<td align=center>")
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            sbSTRHTML.Append(CommonFunction.HTMLControls.DrawTextBox("Rate", "Rate", , 100, 15, Rate, "right", , , , , , , True, True, EnableHTMLEncode:=True))  'TODO
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            sbSTRHTML.Append(" ")
            sbSTRHTML.Append(m_CurrencySymbol)
            sbSTRHTML.Append("</td>")

            sbSTRHTML.Append("<td align=center>")

            If showHistory = "1" Then
                sbSTRHTML.Append("<a href='javascript:History_OnClick(2059," + RateContractDetailID + ")' title='Show History'>" + MyBase.GetResourceString("CAP_SHOW_HISTORY") + "</a>")
            Else
                sbSTRHTML.Append("")
            End If

            sbSTRHTML.Append("</td>")
            sbSTRHTML.Append("</tr>")


        End While

        If lngCounter = 0 Then
            sbSTRHTML.Append("<tr class='clsTREven'><td colspan=3 align=center>" + MyBase.GetResourceString("MSG_NO_RECORD") + "</td></tr>")
        End If

        sbSTRHTML.Append("</table>")
        sbSTRHTML.Append("<br>")
        CommonFunction.Data.DisposeDataReader(objDR)

    End Sub

    Protected Sub drawPageHeader()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : This function Draws the page header
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : 19th jun 2007
        ' Revisions             :
        '=====================================================================
        CommonFunctions.General.PlotPageHeadTag(m_ContractType)
    End Sub
    Private Sub InitVariables()
        Dim strSQL As String
        Dim objDR As IDataReader
        m_strMode = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString.Get("MODE"), "")
        m_strAction = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString.Get("ACTION"), "")
        m_ProjectID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectId"), "")

        If m_ProjectID <> "" Then
            strSQL = "usp_sel_tbl_PM_Project_TaskCaseStructure " + m_ProjectID
            objDR = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

            If objDR.Read Then
                m_ContractTypeID = CommonFunction.Data.CheckIsDBNull(objDR("ContractType"), "").ToString()
                m_ProjectName = CommonFunction.Data.CheckIsDBNull(objDR("ProjectName"), "").ToString()
                m_CurrencySymbol = CommonFunction.Data.CheckIsDBNull(objDR("CurrencySymbol"), "").ToString()
                m_ContractType = CommonFunction.Data.CheckIsDBNull(objDR("NodeLabel"), "").ToString()
            End If
            CommonFunction.Data.DisposeDataReader(objDR)
        End If


        'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        'm_BaseCurrency = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT CurrencySymbol FROM TbL_PM_CurrencyMaster WHERE CurrencyID = " + CommonFunction.Application.BaseCurrencyID.ToString(), MyBase.UseSQL), ""), String)
        m_BaseCurrency = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_TbL_PM_CurrencyMaster_CurrencySymbol " + CommonFunction.Application.BaseCurrencyID.ToString(), MyBase.UseSQL), ""), String)
        'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
    End Sub

    Private Sub DrawMenu()
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : This function Draws menu 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : 19th jun 2007
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        m_objMenu = New WebPages.Template.StaticMenu
        Dim helpID As String = ""
        If m_ContractTypeID = "2" Then
            helpID = "2087-2058"
        ElseIf m_ContractTypeID = "3" Then
            helpID = "2087-2059"
        ElseIf m_ContractTypeID = "5" Then
            helpID = "2087-FixedFee"
        End If

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_SHOWHISTORY"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_SHOWHISTORY_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {"Save_OnClick()", "History_OnClick(2087)", "Close_OnClick()", "Help_OnClick('" + helpID + "')"}
        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        Response.Write(strMenu)
        m_objMenu = Nothing

        MyBase.InitializeResources("AppResources.RFI_ProjectCommercialDetails", "AppResources")
    End Sub

    Private Sub DrawCeillingAmountDetails(ByRef sbstrHTML As System.Text.StringBuilder)
        '=====================================================================
        ' Procedure Name        : DrawCeillingAmountDetails()	
        ' Purpose               : This function draws Ceilling Amount Details.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : 19th jun 2007
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = " usp_Sel_tbl_PM_WorkOrderRateContract " + m_ProjectID
        Dim objDR As IDataReader
        Dim CeilingAmount As String = ""
        Dim basisOfRate As String = ""
        Dim RateMethod As String = ""
        Dim HoursPerDay As String = ""
        Dim HoursPerMonth As String = ""
        Dim RateContractID As String = ""


        objDR = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If objDR.Read() Then

            If CType(CommonFunction.Data.CheckIsDBNull(objDR("CeilingAmount"), ""), String) <> "" Then
                CeilingAmount = FormatNumber(objDR("CeilingAmount"), 2, , , TriState.False)
            End If

            basisOfRate = CType(CommonFunction.Data.CheckIsDBNull(objDR("basisOfRate"), ""), String)
            RateMethod = CType(CommonFunction.Data.CheckIsDBNull(objDR("RateMethod"), "D"), String)
            HoursPerDay = CType(CommonFunction.Data.CheckIsDBNull(objDR("HoursPerDay"), ""), String)
            HoursPerMonth = CType(CommonFunction.Data.CheckIsDBNull(objDR("HoursPerMonth"), ""), String)
            RateContractID = CType(CommonFunction.Data.CheckIsDBNull(objDR("RateContractID"), ""), String)
        End If

        CommonFunction.Data.DisposeDataReader(objDR)

        sbstrHTML.Append("<table id='tbl1' CellSpacing=0 width='99.9%' class=clsTable>")

        sbstrHTML.Append("<tr class='clsTREven'>")
        sbstrHTML.Append("<td align='right'>")
        sbstrHTML.Append("Ceiling Amount") 'TODO
        sbstrHTML.Append("</td>")
        sbstrHTML.Append("<td>&nbsp;")
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        sbstrHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CeilingAmount", "CeilingAmount", , 100, 15, CeilingAmount, "right", , , , , , , True, True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        sbstrHTML.Append(" " + m_CurrencySymbol)
        sbstrHTML.Append("</td>")
        sbstrHTML.Append("</tr>")

        sbstrHTML.Append("<tr class='clsTREven'>")
        sbstrHTML.Append("<td align=right>")
        sbstrHTML.Append("Basis Of Rate") 'TODO
        sbstrHTML.Append("</td>")
        sbstrHTML.Append("<td>&nbsp;")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'sbstrHTML.Append(CommonFunction.HTMLControls.DrawTextArea("BasisOfRate", "BasisOfRate", "Basis Of Rate", , , "frmRFI_ProjectCommercialDetails", , , 400, 80, 300, basisOfRate, , , , , , , , True))
        sbstrHTML.Append(CommonFunction.HTMLControls.DrawTextArea("BasisOfRate", "BasisOfRate", "Basis Of Rate", , , "frmRFI_ProjectCommercialDetails", , , 400, 80, 300, basisOfRate, , , , , , , , True, EnableHTMLEncode:=True))
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        sbstrHTML.Append("</td>")
        sbstrHTML.Append("</tr>")

        sbstrHTML.Append("<tr class='clsTREven'>")
        sbstrHTML.Append("<td align=right>")
        sbstrHTML.Append("Rate Method") 'TODO
        sbstrHTML.Append("</td>")
        sbstrHTML.Append("<td>&nbsp;")
        sbstrHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("RateMethod", "RateMethod", , CType(IIf(RateMethod = "H", True, False), Boolean), "H", , , True))
        sbstrHTML.Append("&nbsp;Person Hour&nbsp;")
        sbstrHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("RateMethod", "RateMethod", , CType(IIf(RateMethod = "D", True, False), Boolean), "D", , , True))
        sbstrHTML.Append("&nbsp;Person Day&nbsp;")
        sbstrHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("RateMethod", "RateMethod", , CType(IIf(RateMethod = "M", True, False), Boolean), "M", , , True))
        sbstrHTML.Append("&nbsp;Person Month")

        sbstrHTML.Append("</td>")
        sbstrHTML.Append("</tr>")

        sbstrHTML.Append("<tr class='clsTREven'>")
        sbstrHTML.Append("<td align=right>")
        sbstrHTML.Append("Hours Per Day") 'TODO
        sbstrHTML.Append("</td>")
        sbstrHTML.Append("<td>&nbsp;")
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        sbstrHTML.Append(CommonFunction.HTMLControls.DrawTextBox("HoursPerDay", "HoursPerDay", , 100, 15, HoursPerDay, "right", , , , , , , True, True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        sbstrHTML.Append("</td>")
        sbstrHTML.Append("</tr>")

        sbstrHTML.Append("<tr class='clsTREven'>")
        sbstrHTML.Append("<td align=right>")
        sbstrHTML.Append("Hours Per Month") 'TODO
        sbstrHTML.Append("</td>")
        sbstrHTML.Append("<td>&nbsp;")
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        sbstrHTML.Append(CommonFunction.HTMLControls.DrawTextBox("HoursPerMonth", "HoursPerMonth", , 100, 15, HoursPerMonth, "right", , , , , , , True, True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        sbstrHTML.Append("</td>")
        sbstrHTML.Append("</tr>")
        'Hidden Variables
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        sbstrHTML.Append(CommonFunction.HTMLControls.DrawTextBox("RateContractID", "RateContractID", , 100, 15, RateContractID, "right", , , , , , , True, True, , , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        sbstrHTML.Append("</table>")


    End Sub

    Private Sub PerformAction()
        '=====================================================================
        ' Procedure Name        : PerformAction()	
        ' Purpose               : This function Saves the Rate details.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : 20th jun 2007
        ' Revisions             :
        '=====================================================================
        Dim RateFor As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form.Get("RateFor"), "")
        Dim sbstrSQL As New System.Text.StringBuilder
        Dim CeilingAmount As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form.Get("CeilingAmount"), "0")
        Dim basisOfRate As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form.Get("basisOfRate"), "")
        Dim RateMethod As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form.Get("RateMethod"), "H")
        Dim HoursPerDay As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form.Get("HoursPerDay"), "0")
        Dim HoursPerMonth As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form.Get("HoursPerMonth"), "0")
        Dim rateforId As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form.Get("RateForID"), "")
        Dim rate As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form.Get("Rate"), "")
        If IsNothing(RateFor) = True Then
            RateFor = ""
        End If

        '2	Rate Contract by Resource
        If RateFor = "2" Or RateFor = "3" Then
            ' Save CelingDetails
            sbstrSQL.Length = 0
            sbstrSQL.Append("usp_Upd_tbl_PM_WorkOrderRateContract ")
            sbstrSQL.Append("'")
            sbstrSQL.Append(FormatNumber(CeilingAmount, 2, , , TriState.False))
            sbstrSQL.Append("',Null,Null,Null")

            If IsNothing(basisOfRate) = True Or basisOfRate = "" Then
                sbstrSQL.Append(",null")
            Else
                sbstrSQL.Append(",'")
                sbstrSQL.Append(basisOfRate)
                sbstrSQL.Append("'")
            End If

            If IsNothing(RateMethod) = True Or RateMethod = "" Then
                sbstrSQL.Append(",null")
            Else
                sbstrSQL.Append(",'")
                sbstrSQL.Append(RateMethod)
                sbstrSQL.Append("',")
            End If

            sbstrSQL.Append(m_ProjectID)
            sbstrSQL.Append(",'")
            sbstrSQL.Append(HttpContext.Current.Session("strUserName"))
            sbstrSQL.Append("'")

            If IsNothing(HoursPerDay) = True Or HoursPerDay = "" Then
                sbstrSQL.Append(",null")
            Else
                sbstrSQL.Append(",'")
                sbstrSQL.Append(HoursPerDay)
                sbstrSQL.Append("'")
            End If


            If IsNothing(HoursPerMonth) = True Or HoursPerMonth = "" Then
                sbstrSQL.Append(",null")
            Else
                sbstrSQL.Append(",'")
                sbstrSQL.Append(HoursPerMonth)
                sbstrSQL.Append("'")
            End If

            CommonFunction.Data.InsertOrUpdateData(sbstrSQL.ToString, MyBase.UseSQL)

            ' Save Resource Rate

            sbstrSQL.Length = 0
            sbstrSQL.Append(" usp_UPD_tbl_PM_WorkOrderRateContractdetail ")
            sbstrSQL.Append(m_ProjectID)
            sbstrSQL.Append(" , '")
            sbstrSQL.Append(RateFor)
            sbstrSQL.Append("' ,'")
            sbstrSQL.Append(rateforId)
            sbstrSQL.Append("' , '")
            sbstrSQL.Append(rate)
            sbstrSQL.Append("' , '")
            sbstrSQL.Append(HttpContext.Current.Session("strUserName"))
            sbstrSQL.Append("'")
            CommonFunction.Data.InsertOrUpdateData(sbstrSQL.ToString, MyBase.UseSQL)

        ElseIf RateFor = "5" Then

            sbstrSQL.Length = 0
            sbstrSQL.Append(" usp_UPD_tbl_PM_WorkOrderRateContractdetail ")
            sbstrSQL.Append(m_ProjectID)
            sbstrSQL.Append(" , '")
            sbstrSQL.Append(RateFor)
            sbstrSQL.Append("' ,'")
            sbstrSQL.Append(rateforId)
            sbstrSQL.Append("' , '")
            sbstrSQL.Append(rate)
            sbstrSQL.Append("' , '")
            sbstrSQL.Append(HttpContext.Current.Session("strUserName"))
            sbstrSQL.Append("'")
            CommonFunction.Data.InsertOrUpdateData(sbstrSQL.ToString, MyBase.UseSQL)

        End If

        sbstrSQL = Nothing
    End Sub
    Public Sub New()
        MyBase.InitializeResources("AppResources.RFI_ProjectCommercialDetails", "AppResources")
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print

        If m_objAccessRights.Edit = False And Args.LinkName.ToLower = "save" Then
            Cancel = True
        End If

        If Args.LinkName.ToLower = "show history" Then

            Dim showHostry As String = ""

            If m_ContractTypeID = "5" Then
                Cancel = True
            End If

            If Cancel = False Then


                'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
                'showHostry = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT TOP 1 TagID FROM tbl_PM_AuditTrail WHERE  TagID='2087' AND IsSubTagID='0' AND ProjectID='" + m_ProjectID + "' AND UniqueID='" + m_ProjectID + "' ", MyBase.UseSQL), ""), String)
                showHostry = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_AuditTrail_TagID '" + m_ProjectID + "'", MyBase.UseSQL), ""), String)
                'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
                If showHostry = "" Then
                    Cancel = True
                End If

            End If
        End If
    End Sub
End Class
