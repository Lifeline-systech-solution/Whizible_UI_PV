Option Strict Off

Public Class ProjectProfitablityByCustomer
    Inherits WebPage.Templates.WhizTemplate

#Region "Form Variables"


    Private custID As String = ""
    Private strAction As String = ""
    Protected m_ProjectID As String = ""
    Protected m_strSQLProject As String = ""
    Private m_strProjectID As String = ""
    Private m_ProjectName As String = ""
    Private intRoleLevel As Integer
    Private m_strProjectFilters As String
    Private strProjectIDs As String = ""
    Private m_CurrencySymbol As String = ""
    Private m_BaseCurrencySymbol As String = ""
    Private WithEvents m_objGrid As WebPages.Template.AdvancedGrid
    Private WithEvents objMenu As WebPage.Templates.StaticMenu
    Private m_GPMTrend As String = "0"


    Private m_GroupRevenue As Double = 0
    Private m_GroupCost As Double = 0
    Private m_GroupGPM As Double = 0
    Private m_GroupInvoice As Double = 0

    Private m_TotalRevenue As Double = 0
    Private m_TotalCost As Double = 0
    Private m_TotalGPM As Double = 0
    Private m_TotalInvoice As Double = 0

    Private m_CurrentCustomer As Long = 0
    Private m_recordcount As Long = 0
    Private m_GroupCount As Integer = 0
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
        'Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.ApplySecurity(True)
        'End Of Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Protected Sub WritePage()
        Initialize()

        DrawPage()
        Response.Write("<br>")
        writeMenu()
    End Sub
    Protected Sub CreateCaption()
        '=====================================================================
        ' Procedure Name        : CreateCaption()	
        ' Purpose               : Create Caption of a Page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 07,2008
        ' Revisions             : 
        '                         
        '=====================================================================
        Dim strBusinessGroup As String = ""
        Dim strOrganizationUnit As String = ""

        CommonFunction.General.WriteHTML("<TABLE CellSpacing=0 BORDER=0 class='clsTable' width='99.9%'>")
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=1 class=clsTRPageCaption align='left'>")
        CommonFunctions.General.WriteHTML("<td style='width:17%;text-align:left'><B>&nbsp;Project Profitability By Customer</B>")
        CommonFunctions.General.WriteHTML("</td>")
        'If strAction = "Display" Then
        CommonFunctions.General.WriteHTML("<td style='width:17%;text-align:right ;FONT-WEIGHT: normal;'>&nbsp;( All Figures In : " + m_BaseCurrencySymbol + " )")
        CommonFunctions.General.WriteHTML("</td>")
        'End If
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</TABLE>")
    End Sub
    Protected Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage()	
        ' Purpose               : Draw  a Page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 05,2007
        ' Revisions             : 
        '                         
        '=====================================================================
        'If strAction = "Menu" Then
        Call DrawMenuPage()
        'ElseIf strAction = "Display" Then
        Call DrawDisplayPage()
        'End If
    End Sub
    Protected Sub DrawMenuPage()
        '=====================================================================
        ' Procedure Name        : DrawPage()	
        ' Purpose               : Draw Menu a Page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 07,2008
        ' Revisions             : 
        '                         
        '=====================================================================

        writeMenu()

        CommonFunctions.General.WriteHTML("<br>")


        CommonFunctions.General.WriteHTML("<TABLE id='tblFilter' style='width:99.99%;' class='clsGridTable' cellspacing='0' cellpadding='0'>")

        CommonFunctions.General.WriteHTML("<TR width=99.9%  class=clsTREven align='center'>")
        CommonFunctions.General.WriteHTML("<td  align='right'>Customer ")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align=left colspan=3 >")
        If CType(Session("LoginType"), String) = "C" Then
            custID = CType(Session("intUserID"), String)
        End If
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboCust", "usp_Sel_tbl_PM_Customer " + IIf(CType(Session("LoginType"), String) = "C", custID, "").ToString(), 250, custID, "" + " Langugage=JavaScript OnChange=cboCust_change()", True, True))
        CommonFunctions.General.WriteHTML("</td>")

        'Project combo 

        CommonFunctions.General.WriteHTML("<td style='text-align:right' >Project ")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align=left>")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProjectID", m_strSQLProject, 250, m_ProjectID, "onchange='javascript:cboProject_change()' ", True, True))
        CommonFunctions.General.WriteHTML("</td>")
        ' GPM Trend 
        CommonFunctions.General.WriteHTML("<td style='text-align:right'>")
        CommonFunctions.General.WriteHTML("GPM")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='text-align:left' nowrap>")
        CommonFunctions.General.WriteHTML(CommonFunction.HTMLControls.DrawOptionButton("GPMTrend", "GPMTrend", , CType(IIf(m_GPMTrend = "1", True, False), Boolean), "1", , "onclick='javascript:cboProject_change()'", True))
        CommonFunctions.General.WriteHTML("<img src='../../Images/GREENflag.gif' title='Positive GPM' onclick='javascript:cboProject_change()'>")

        CommonFunctions.General.WriteHTML(CommonFunction.HTMLControls.DrawOptionButton("GPMTrend", "GPMTrend", , CType(IIf(m_GPMTrend = "-1", True, False), Boolean), "-1", , "onclick='javascript:cboProject_change()'", True))
        CommonFunctions.General.WriteHTML("<img src='../../Images/REDflag.gif' title='Negative GPM' onclick='javascript:cboProject_change()'>")

        CommonFunctions.General.WriteHTML(CommonFunction.HTMLControls.DrawOptionButton("GPMTrend", "GPMTrend", , CType(IIf(m_GPMTrend = "0", True, False), Boolean), "0", , "onclick='javascript:cboProject_change()'", True))
        CommonFunctions.General.WriteHTML("<img src='../../Images/grayflag.gif' title='All GPM' onclick='javascript:cboProject_change()'>")

        CommonFunctions.General.WriteHTML("</td></TR>")

        CommonFunctions.General.WriteHTML("</Table>")
        CommonFunctions.General.WriteHTML("<br>")
        CreateCaption()
        CommonFunctions.General.WriteHTML("<br>")

    End Sub
    Protected Sub DrawDisplayPage()
        '=====================================================================
        ' Procedure Name        : DrawPage()	
        ' Purpose               : Draw  a Display Page After Menu is selected
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 07,2008
        ' Revisions             : 
        '                         
        '=====================================================================
        Dim arrUserFriendlyCols() As String = {"Customer", "Project Name", "As On Date", "Accrued Revenue", "Accrued Cost", "Accrued GPM", "Accrued GPM %", "Invoice Revenue"}
        Dim arrActualCols() As String = {"CustomerName", "ProjectName", "ToDate", "AccruedRevenue", "AccruedCost", "AccruedGPM", "AccruedGPMPercent", "InvoiceRevenue"}
        Dim strSQL As String = ""
        Dim strGroupOnColumn() As String = {"CustomerName", "", "", "", "", "", ""}
        Dim strSortByCols() As String = {"CustomerName", "ProjectName", "ToDate", "AccruedRevenue", "AccruedCost", "AccruedGPM", "AccruedGPMPercent", "InvoiceRevenue"}
        Dim strSummaryFunctions() As String = {"", "", "", "SUM", "SUM", "SUM", "AVG", "SUM"}
        Dim strrowLinkArray() As String = {"", "CallGPM(ProjectID)"}
        ' Dim objDR As IDataReader
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        Dim strWhereClause As String = ""
        If custID = "" Then
            strWhereClause = strWhereClause + "Null"
        Else
            strWhereClause = strWhereClause + custID
        End If


        If strProjectIDs = "" Then
            strWhereClause = strWhereClause + ",Null"
        Else
            strWhereClause = strWhereClause + ",'" + strProjectIDs + "'"
        End If

        If m_ProjectID = "" Then
            strWhereClause = strWhereClause + ",Null"
        Else
            strWhereClause = strWhereClause + ",'" + m_ProjectID + "'"
        End If

        If m_GPMTrend <> "" Then
            strWhereClause = strWhereClause + ",'" + m_GPMTrend + "'"
        Else
            strWhereClause = strWhereClause + ",0"
        End If

        strSQL = "usp_SEL_Tbl_PM_ProjectProfitability_ProjectProfitByCustomer  " + strWhereClause
        'objDR = CommonFunction.Data.GetDataReader(strSQL, True)
        m_objGrid = New WebPages.Template.AdvancedGrid
        With m_objGrid

            .NoOfDataColumns = arrUserFriendlyCols.Length
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .returnHTML = False
            .SQL = strSQL
            .UseSQL = True
            .DIVID = "DivMain"
            .DIVStyle = "overflow:auto;width:99.99%;"
            '.DIVHeight = 450
            '.DIVHeight = "99.99%"
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = "-"
            .SortBy = "ProjectName"
            .SortOrder = "Asc"
            .RowLinkArray = strrowLinkArray
            .GroupOnColumn = strGroupOnColumn
            .ShowSummaryFunctions = True
            .SummaryFunctions = strSummaryFunctions
            .GroupSummaryFunc = strSummaryFunctions
            '.CheckboxCheckOnColumnArray = arrCheckboxArray
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
            m_recordcount = .NoOfRows
        End With
        m_objGrid = Nothing
    End Sub
    Protected Sub DrawHiddenFields()
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.HTMLControls.DrawTextBox("txtAction", "txtAction", , 150, , strAction, , , , , , True, , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
    End Sub
    Protected Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : Initialization for a Page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 07,2008
        ' Revisions             : 
        '                         
        '=====================================================================
        Dim drProject As IDataReader
        Dim objDr As IDataReader
        Dim dataReader As IDataReader
        Dim lenProjectID As Integer
        Dim strQuery As String = ""
        Dim strProjectList As String = ""
        strAction = ""
        custID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("cboCust"), ""), String)
        If custID = "" Then
            custID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CustomerID"), ""), String)
        End If
        strAction = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"), "")
        If strAction = "" Then
            strAction = HttpContext.Current.Request.Form("txtAction")
        End If

        m_ProjectID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("cboProjectID"), ""), String)
        If m_ProjectID = "" Then
            m_ProjectID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID"), ""), String)
        End If

        m_GPMTrend = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("GPMTrend"), "0"), String)

        intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)
        '=========================================================================================
        '   Applying Role level Security for Project Filters
        '=========================================================================================
        ' Added By PiyushB On 2:31PM  8/06/2008 For WhizibleSEM 7.1
        ' To show all project on the basis of Login Type  for 'Project Profit as per BG,OU' 
        If CType(Session("LoginType"), String) = "E" Then
            ' End_MV_ 7/19/2007
            If intRoleLevel = 2 Then
                m_strProjectFilters = ""
                Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
                If strFilter <> "" Then
                    m_strProjectFilters += strFilter
                End If
                Dim strRemove As String = "ProjectID IN"
                m_strProjectFilters = m_strProjectFilters.Remove(0, strRemove.Length)
                m_strProjectFilters = m_strProjectFilters.Replace("'", "")
                m_strProjectFilters = m_strProjectFilters.Replace("(", "")
                m_strProjectFilters = m_strProjectFilters.Replace(")", "")
            Else
                m_strProjectFilters = "NULL"
            End If

        ElseIf CType(Session("LoginType"), String) = "C" Then
            strQuery = "usp_Sel_GetProjectNameList_SQERT_Customer " + CType(Session("intUserID"), String)
            drProject = CommonFunctions.Data.GetDataReader(strQuery, True)
            While (drProject.Read())
                strProjectList = strProjectList + "," + drProject("ProjectID").ToString()

            End While
            CommonFunction.Data.DisposeDataReader(drProject)
            strProjectList = strProjectList.Substring(1, strProjectList.Length - 1)
            m_strProjectFilters = strProjectList
        End If

        m_strSQLProject = "usp_Sel_GetProjectNameList_Profitability  "
        m_strSQLProject = m_strSQLProject & "NULL,"
        m_strSQLProject = m_strSQLProject & "NULL,"
        m_strSQLProject = m_strSQLProject & "NULL,"
        m_strSQLProject = m_strSQLProject & "NULL,"
        If m_strProjectFilters <> "NULL" Then
            m_strSQLProject = m_strSQLProject & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "','" & CType(Session("LoginType"), String) & "'"
        Else
            m_strSQLProject = m_strSQLProject & CType(Session("intUserID"), String) & "," & m_strProjectFilters & ",'" & CType(Session("LoginType"), String) & "'"
        End If
        If custID <> "" Then
            m_strSQLProject += ", " + custID
        End If

        dataReader = CommonFunction.Data.GetDataReader(m_strSQLProject, True)
        While dataReader.Read()
            strProjectIDs = strProjectIDs + dataReader("ProjectID").ToString() + ","
        End While
        CommonFunction.Data.DisposeDataReader(dataReader)

        lenProjectID = strProjectIDs.Length
        If lenProjectID > 0 Then
            strProjectIDs = strProjectIDs.Substring(0, lenProjectID - 1)
        End If

        m_BaseCurrencySymbol = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT CurrencySymbol  FROM tbl_PM_CurrencyMaster INNER JOIN tbl_PM_CompanyInformation ON tbl_PM_CurrencyMaster.CurrencyID = tbl_PM_CompanyInformation.BaseCurrencyID", True).ToString(), "-").ToString()

    End Sub
    Protected Sub writeMenu()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : Print Menu for a Page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 07,2008
        ' Revisions             : 
        '                         
        '=====================================================================
        Dim ShowLink As String
        Dim ShowLinkToolTip As String
        Dim ShowLinkFunction As String
        objMenu = New WebPage.Templates.StaticMenu

        'Dim arrMenu() As String = {"<img id='imgHelp' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Help.gif'>"}
        Dim arrMenu() As String = {"?"}
        Dim arrMenuToolTip() As String = {"Help"}
        Dim arrCSFunction() As String = {"Help_OnClick('3947')"}
        objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, False)

    End Sub


    Private Sub m_objGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles m_objGrid.SummaryFunctionsTR_BeforePrint
        If m_recordcount <> 0 Then

            Dim sbhtml As New System.Text.StringBuilder
            sbhtml.Append("<tr class='clsTRSectionHeader' >")
            sbhtml.Append("<td align='left' colspan=3><b>Total</b></td>")
            sbhtml.Append("<td  align='right' nowrap><b>")
            sbhtml.Append(m_BaseCurrencySymbol + " ")
            sbhtml.Append(m_GroupRevenue.ToString("N2"))
            sbhtml.Append("</b></td>")

            sbhtml.Append("<td align='right' nowrap><b>")
            sbhtml.Append(m_BaseCurrencySymbol + " ")
            sbhtml.Append(m_GroupCost.ToString("N2"))
            sbhtml.Append("</b></td>")

            sbhtml.Append("<td  align='right' nowrap><b>")
            sbhtml.Append(m_BaseCurrencySymbol + " ")
            sbhtml.Append(m_GroupGPM.ToString("N2"))
            sbhtml.Append("</b></td>")

            sbhtml.Append("<td  align='right' nowrap><b>")

            If m_GroupRevenue <> 0 Then
                sbhtml.Append(FormatNumber(((m_GroupRevenue - m_GroupCost) / m_GroupRevenue * 100), 2))
            Else
                sbhtml.Append("0.00")
            End If

            sbhtml.Append("</b></td>")

            sbhtml.Append("<td  align='right' nowrap><b>")
            sbhtml.Append(m_BaseCurrencySymbol + " ")
            sbhtml.Append(m_GroupInvoice.ToString("N2"))
            sbhtml.Append("</b></td>")

            sbhtml.Append("</tr>")
            If m_GroupCount = 1 Then

                Args.StringToBeInserted = sbhtml.ToString
                Cancel = True
            Else

                m_TotalRevenue += m_GroupRevenue
                m_TotalGPM += m_GroupGPM
                m_TotalCost += m_GroupCost
                m_TotalInvoice += m_GroupInvoice

                sbhtml.Append("<tr class='clsTRSectionHeader' >")
                sbhtml.Append("<td align='left' colspan=3><b>Grand Total</b></td>")
                sbhtml.Append("<td  align='right' nowrap><b>")
                sbhtml.Append(m_BaseCurrencySymbol + " ")
                sbhtml.Append(m_TotalRevenue.ToString("N2"))
                sbhtml.Append("</b></td>")

                sbhtml.Append("<td align='right' nowrap><b>")
                sbhtml.Append(m_BaseCurrencySymbol + " ")
                sbhtml.Append(m_TotalCost.ToString("N2"))
                sbhtml.Append("</b></td>")

                sbhtml.Append("<td  align='right' nowrap><b>")
                sbhtml.Append(m_BaseCurrencySymbol + " ")
                sbhtml.Append(m_TotalGPM.ToString("N2"))
                sbhtml.Append("</b></td>")

                sbhtml.Append("<td  align='right' nowrap><b>")

                If m_TotalRevenue <> 0 Then
                    sbhtml.Append(FormatNumber(((m_TotalRevenue - m_TotalCost) / m_TotalRevenue * 100), 2))
                Else
                    sbhtml.Append("0.00")
                End If

                sbhtml.Append("</b></td>")

                sbhtml.Append("<td  align='right' nowrap><b>")
                sbhtml.Append(m_BaseCurrencySymbol + " ")
                sbhtml.Append(m_TotalInvoice.ToString("N2"))
                sbhtml.Append("</b></td>")

                sbhtml.Append("</tr>")
                Args.StringToBeInserted = sbhtml.ToString
                Cancel = True
            End If

            sbhtml = Nothing

        Else
            Cancel = True
        End If
    End Sub

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint

        m_recordcount += 1

        If m_CurrentCustomer <> CType(Args.DataReader("Customer"), Long) Then
            m_GroupCount += 1

            If m_CurrentCustomer <> 0 Then

                Dim sbhtml As New System.Text.StringBuilder
                sbhtml.Append("<tr class='clsTRSectionHeader' >")
                sbhtml.Append("<td align='left' colspan=3><b>Total</b></td>")
                sbhtml.Append("<td  align='right' nowrap><b>")
                sbhtml.Append(m_BaseCurrencySymbol + " ")
                sbhtml.Append(m_GroupRevenue.ToString("N2"))
                sbhtml.Append("</b></td>")

                sbhtml.Append("<td align='right' nowrap><b>")
                sbhtml.Append(m_BaseCurrencySymbol + " ")
                sbhtml.Append(m_GroupCost.ToString("N2"))
                sbhtml.Append("</b></td>")

                sbhtml.Append("<td  align='right' nowrap><b>")
                sbhtml.Append(m_BaseCurrencySymbol + " ")
                sbhtml.Append(m_GroupGPM.ToString("N2"))
                sbhtml.Append("</b></td>")


                sbhtml.Append("<td  align='right' nowrap><b>")

                If m_GroupRevenue <> 0 Then
                    sbhtml.Append(FormatNumber(((m_GroupRevenue - m_GroupCost) / m_GroupRevenue * 100), 2))
                Else
                    sbhtml.Append("0.00")
                End If

                sbhtml.Append("</b></td>")
                sbhtml.Append("<td  align='right' nowrap><b>")
                sbhtml.Append(m_BaseCurrencySymbol + " ")
                sbhtml.Append(m_GroupInvoice.ToString("N2"))
                sbhtml.Append("</b></td>")

                sbhtml.Append("</tr>")
                Args.StringToBeInserted = sbhtml.ToString
                sbhtml = Nothing


            End If

            m_TotalRevenue += m_GroupRevenue
            m_TotalGPM += m_GroupGPM
            m_TotalCost += m_GroupCost
            m_TotalInvoice += m_GroupInvoice

            m_GroupCost = CType(Args.DataReader("AccruedCost"), Double)
            m_GroupGPM = CType(Args.DataReader("AccruedGPM"), Double)
            m_GroupInvoice = CType(Args.DataReader("InvoiceRevenue"), Double)
            m_GroupRevenue = CType(Args.DataReader("AccruedRevenue"), Double)
            m_CurrentCustomer = CType(Args.DataReader("Customer"), Long)



        Else
            m_GroupCost += CType(Args.DataReader("AccruedCost"), Double)
            m_GroupGPM += CType(Args.DataReader("AccruedGPM"), Double)
            m_GroupInvoice += CType(Args.DataReader("InvoiceRevenue"), Double)
            m_GroupRevenue += CType(Args.DataReader("AccruedRevenue"), Double)
        End If

    End Sub
    ''Added by Yogesh J on 10-Feb-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_CallGPM_OnClick(Project As String, EmployeeID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(Project, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    ''End of addition by Yogesh J on 10-Feb-2016
End Class
