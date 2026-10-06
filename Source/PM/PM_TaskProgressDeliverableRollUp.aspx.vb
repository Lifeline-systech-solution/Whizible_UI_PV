'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhizEngg
' Module Name           :  PM_TaskProgressDeliverableRollUp.aspx
' Purpose               :  
' Description           :  
' Dependencies          :  None
' Author                :  PrakashR
' Reviewed              :  
' Tested                :  
' Created               :  
' Revisions             :  
'=====================================================================

#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class PM_TaskProgressDeliverableRollUp
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

#Region "Member Variables"
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0
    Private WithEvents m_objGrid As New WebPages.Template.AdvancedGrid
    Protected m_strDepartmet As String
    'Protected m_strDeliverableType As String
    '  Protected m_strProjectID As String
    Protected m_Date As String
    ' Protected m_strFromDate As String
    ' Protected m_strToDate As String
    ' Protected m_strFreeze As String
    Protected m_DepartmentID As String
    '  Protected m_strFreeseDisable As String
    Protected m_dblDepartmentEffords As Double
    Protected m_dblProjectEffords As Double
    Protected m_dblDepartmentCalcPercent As Double
    Protected m_dblProjectCalcPercent As Double
    Protected m_dblPlannedEfforts As Double
    Protected m_dblCalcActualEfforts As Double
    Protected WithEvents frmPM_TaskProgressDeliverableRollUp As System.Web.UI.HtmlControls.HtmlForm
    Protected m_dblCalPercentage As Double
    Protected m_ProjectID As Integer
    Protected m_dblProCalActEff As Double

#End Region

#Region "Functions and Sub-Procedures"

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        :   PageInit
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw all controls on the page
        ' Description           :   This is main procedure on this page which actually draw the page with its 
        '                           controls on it. This procedure is called from the HTML body tag of the page.
        '                           this procedure gives the call to other procedures and functions in the class.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   PrakashR
        ' Created               :   
        ' Revisions             :   
        '=====================================================================
        Call GetGlobalObject()
        DisplaySelectionHeader()
        DisplayGrid()

    End Sub

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        :  GetGlobalObject
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get an instance of the global object
        ' Description           :  This sub-routine fills the global object and 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub
    Private Sub DisplaySelectionHeader()
        Dim blnIsChecked As Boolean
        Dim strSQLQuery As String
        Dim objDynamicLink As WebPages.UI.cDynamicLink
        Dim departmentID As Integer
        Dim drFromDate As IDataReader

        m_ProjectID = CType(CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0"), Integer)
        '--- Display the Page Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"), , , True))
        CommonFunctions.General.WriteHTML("<BR>")
        'Modified by ShraddhaM on Date 21 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td colspan=2>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("DEPARTMENT"))
        CommonFunctions.General.WriteHTML("&nbsp;")
        If (Request.QueryString("DepartmentID") <> "") Then
            m_DepartmentID = Request.QueryString("DepartmentID").ToString
        Else
            m_DepartmentID = ""
        End If
        If (Request.QueryString("DateValue") <> "") Then
            m_Date = Request.QueryString("DateValue").ToString
        Else
            'strSQLQuery = "SELECT Distinct FromDate,CAST(REPLACE(CONVERT(CHAR(20),FromDate,106),' ',' ') AS CHAR(11))+'-'+CAST( REPLACE(CONVERT(CHAR(20),ToDate,106),' ',' ')AS CHAR(11) ) AS dtDate FROM tbl_pm_taskprogress "
            'strSQLQuery = strSQLQuery + "WHERE ProjectID='" + m_ProjectID.ToString + "'  ORDER BY FromDate  ASC"
            strSQLQuery = "usp_sel_tbl_pm_taskprogress_FromDate_ToDate " + m_ProjectID.ToString
            drFromDate = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
            If (drFromDate.Read()) Then
                m_Date = drFromDate("FromDate").ToString
            End If
            CommonFunction.Data.DisposeDataReader(drFromDate)
        End If
        'strSQLQuery = "SELECT DepartmentID,Department FROM tbl_PM_DepartmentMaster"
        strSQLQuery = "usp_sel_tbl_PM_DepartmentMaster_DepartmentID"
        CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", strSQLQuery, 200, CType(m_DepartmentID, String), "onChange=ApplyDepartmentFilter()", True)
        CommonFunctions.General.WriteHTML("<td align='Left'>")
        CommonFunctions.General.WriteHTML("</td><td colspan=2>")

        'strSQLQuery = "SELECT Distinct FromDate,CAST(REPLACE(CONVERT(CHAR(20),FromDate,106),' ',' ') AS CHAR(11))+'-'+CAST( REPLACE(CONVERT(CHAR(20),ToDate,106),' ',' ')AS CHAR(11) ) AS dtDate FROM tbl_pm_taskprogress "
        'strSQLQuery = strSQLQuery + "WHERE ProjectID='" + m_ProjectID.ToString + "'  ORDER BY FromDate  ASC"
        strSQLQuery = "usp_sel_tbl_pm_taskprogress_FromDate_ToDate " + m_ProjectID.ToString
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PERIOD"))
        CommonFunctions.General.WriteHTML("&nbsp;")

        CommonFunctions.HTMLControls.DrawComboBox("cboDate", strSQLQuery, 200, m_Date, "onChange=ApplyDateFilter()")
        CommonFunctions.General.WriteHTML("</td></tr></table></BR>")

    End Sub
    Private Sub DisplayGrid()
        Dim strSQLQuery As String = ""
        Dim strWhereClause As String = ""
        strSQLQuery = "Exec usp_sel_TaskProgressDelRollUp  '" + m_Date + "','" + m_ProjectID.ToString + "','" + m_DepartmentID.ToString + "'"
        Dim arrActualColumns() As String = {"Department", "DelName", _
                                            "LabelSchedule", "BudgetedEfforts", "PlannedEfforts", "CalcPercent"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("DEPARTMENT"), MyBase.GetResourceString("DELIVERABLE_NAME"), MyBase.GetResourceString("DELIVERABLE_TYPE"), MyBase.GetResourceString("BUDGETED_EFFORTS"), MyBase.GetResourceString("PLANNED_EFFORTS"), MyBase.GetResourceString("PERCENT_PROGRESS")}
        Dim arrstrTDStyle() As String = {"align='left' width=15%", "align='left' width=15%", "align='left' width=7%", "align='right' width=7%", "align='right' width=7%", "align='right' width=7%"}
        Dim arrGroupOnFunction() As String = {"1", "", "", "", "", ""}
        Dim arrGroupSummaryFunc() As String = {"", "", "", "", "", "SUM"}
        Dim summaryfunction() As String = {"", "", "", "SUM", "SUM", "SUM"}

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        'Set the Advanced Grid Properties
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            '  .EmptyValueReplacement = "&nbsp;"
            .SQL = strSQLQuery
            .DIVID = "divList"
            .DIVHeight = 400
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = 6
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .GroupOnColumn = arrGroupOnFunction
            .GroupSummaryFunc = arrGroupSummaryFunc
            .SummaryFunctions = summaryfunction
            .ShowSummaryFunctions = True
            ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''End of Addition by Dhanashri S on 7 Oct 2015
            .DrawGrid()
        End With

    End Sub
#End Region
    Public Sub New()
        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.InitializeResources("AppResources.PM_TaskProgressDeliverableRollUp", "AppResources")
    End Sub

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
        Dim strDepartment As String
        strDepartment = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Department"), "Not Defined"), String)
        If m_strDepartmet <> strDepartment.Trim Then
            strDepartment = ""
            If CType(m_strDepartmet, String) <> "" Then
                m_dblCalPercentage = 100 * (m_dblCalcActualEfforts / m_dblPlannedEfforts)
                Args.StringToBeInserted += "<tr class='clsTRGroupHeader'><td colspan=2></td><td></td><td align=right>"
                Args.StringToBeInserted += FormatNumber(CType(m_dblDepartmentEffords, String), 2)
                Args.StringToBeInserted += "</td><td align=right>"
                Args.StringToBeInserted += FormatNumber(CType(m_dblPlannedEfforts, String), 2)
                Args.StringToBeInserted += "</td><td align=right>"
                Args.StringToBeInserted += FormatNumber(CType(m_dblCalPercentage, String), 2)
                Args.StringToBeInserted += "</td></tr>"
                m_dblDepartmentEffords = 0
                m_dblDepartmentCalcPercent = 0
                m_dblPlannedEfforts = 0
                m_dblCalPercentage = 0
                m_dblCalcActualEfforts = 0
            End If
            m_strDepartmet = CommonFunction.Data.CheckIsDBNull(Args.DataReader("Department"), "Not Defined").ToString + ""
        End If
    End Sub
    Private Sub m_objGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_AfterPrint
        Dim dblEffords As Double
        Dim dblCalPercent As Double
        Dim dblPlannedEfforts As Double
        Dim dblCalPercentage As Double
        Dim dblCalcActualEfforts As Double
        'Find where Department Has Records or Not
        dblEffords = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("BudgetedEfforts"), "0"), Double)
        dblPlannedEfforts = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("PlannedEfforts"), "0"), Double)
        dblCalPercentage = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("CalcPercent"), "0"), Double)
        dblCalcActualEfforts = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("CalcActualEfforts"), "0"), Double)
        m_dblPlannedEfforts = m_dblPlannedEfforts + dblPlannedEfforts
        m_dblDepartmentEffords = m_dblDepartmentEffords + dblEffords
        m_dblCalcActualEfforts = m_dblCalcActualEfforts + dblCalcActualEfforts
        m_dblProjectEffords = m_dblProjectEffords + dblPlannedEfforts
        m_dblProCalActEff = m_dblProCalActEff + dblCalcActualEfforts
    End Sub
    Private Sub m_objGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles m_objGrid.SummaryFunctionsTR_BeforePrint
        Dim strSQLQuery As String
        Dim rsTaskPresent As IDataReader
        strSQLQuery = "Exec usp_sel_TaskProgressDelRollUp  '" + m_Date + "','" + m_ProjectID.ToString + "','" + m_DepartmentID.ToString + "'"
        rsTaskPresent = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
        If rsTaskPresent.Read() Then
            'Display Summary Function only if Records are present for selected  Project and Period.
            Dim strFilterDepartmentID As String
            m_dblCalPercentage = 100 * (m_dblCalcActualEfforts / m_dblPlannedEfforts)
            Args.StringToBeInserted += "<tr class='clsTRGroupHeader'><td colspan=2></td><td></td><td align=right>"
            Args.StringToBeInserted += FormatNumber(CType(m_dblDepartmentEffords, String), 2)
            Args.StringToBeInserted += "</td><td align=right>"
            Args.StringToBeInserted += FormatNumber(CType(m_dblPlannedEfforts, String), 2)
            Args.StringToBeInserted += "</td><td align=right>"
            Args.StringToBeInserted += FormatNumber(CType(m_dblCalPercentage, String), 2)
            Args.StringToBeInserted += "</td></tr>"
            If m_DepartmentID.ToString <> "" Then
                Cancel = True
            End If
        Else
            Cancel = True
        End If
        CommonFunction.Data.DisposeDataReader(rsTaskPresent)
    End Sub
    Private Sub m_objGrid_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles m_objGrid.SummaryFunctionsTD_BeforePrint
        If Args.ColumnName = "Deliverable Name" Then
            Cancel = True
            Args.StringToBeInserted = "<td align=left class=''><B>"
            Args.StringToBeInserted += MyBase.GetResourceString("GRAND_TOTAL_PROJECT")
            Args.StringToBeInserted += "</B></td>"
        End If
        If Args.ColumnName = "Percent Progress" Then
            Cancel = True
            Args.StringToBeInserted = "<td align=right class=''><B>"
            Args.StringToBeInserted += FormatNumber(CType(100 * (m_dblProCalActEff / m_dblProjectEffords), String), 2)
            Args.StringToBeInserted += "</B></td>"
        End If
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.ColumnName = "Department" Then
            'Cancel = True
            If CommonFunction.Data.CheckIsDBNull(Args.DataFieldValue, "").ToString <> "" Then
                Args.DataFieldValue = MyBase.GetResourceString("DEPARTMENT") + " : " + CommonFunction.Data.CheckIsDBNull(Args.DataFieldValue, "").ToString
            Else
                Args.DataFieldValue = MyBase.GetResourceString("DEPARTMENT") + " : Not Defined"
            End If

            'Args.StringToBeInserted = "<td>"
            'Args.StringToBeInserted += "Department: " '+ CType(Args.DataFieldValue, String)
            'Args.StringToBeInserted += "</td>"
        End If
    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If Args.ColumnName = "Department" Then
            Cancel = True
            Args.StringToBeInserted = "<td width=1%></td>"

        End If

    End Sub
End Class
