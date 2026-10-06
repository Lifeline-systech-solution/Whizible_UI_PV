Partial Public Class HR_ResourceAllocationDashboardDetails
    Inherits WebPages.Template.WhizTemplate

    Private m_sbHTML As System.Text.StringBuilder
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private DateForPeriod As String
    Private m_LocationID As String = ""
    Private dtFromDate As String = ""
    Private m_LocationID_SP As String = ""
    Private dtFromDate_SP As String = ""
    Private m_FinancialPeriodCount As String
    Private RoleID As String
    Private FromWhere As String
    Private dsEmp As DataSet
    Private m_intTotalNoOfRows As Integer
    Protected m_intPageNumber As Integer = 1
    Private strQuery As String
    Private m_EmpName_SP As String = ""
    Private m_EmpName As String = ""
    Private Role As String
    Private FormWhereCaption As String
    Private PageSize As Integer = 10



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
    End Sub
    Protected Sub PageInit()

        Call InitializeVariables()
        Call GenerateMenu()
        Call DrawPageCaption()
        Call DrawFilter()
        Call WritePaging()


        If Not FromWhere Is Nothing Then

            Select Case FromWhere.ToUpper
                Case "TOTALRES"
                    m_sbHTML.Append(DrawDtlEmpDiv())
                Case "BENCH"
                    m_sbHTML.Append(DrawDtlEmpDiv())
                Case "NONBILLABLE"
                    m_sbHTML.Append(DrawDtlEmpPRJDiv())
                Case Else '"1", "2", "3", "4", "5", "TOTALALLOCATION"
                    m_sbHTML.Append(DrawDtlEmpPRJDiv())
            End Select

        End If

        Call DrawTotalRec()

        Response.Write(m_sbHTML.ToString())

    End Sub

    Private Sub InitializeVariables()
        Dim CurrentIndex As Integer

        m_sbHTML = New System.Text.StringBuilder

        If Not Request.QueryString("Location") Is Nothing Or Request.QueryString("Location") <> "" Then
            m_LocationID = Request.QueryString("Location").ToString()
        ElseIf Not Request.Form("hidLocation") Is Nothing OrElse Request.Form("hidLocation") <> "" Then
            m_LocationID = Request.Form("hidLocation").ToString()
        End If

        If dtFromDate Is Nothing OrElse dtFromDate = "" Then
            dtFromDate = Now.Date
            DateForPeriod = dtFromDate
        End If

        If Not Request.QueryString("FromDate") Is Nothing Then
            dtFromDate = Request.QueryString("FromDate").ToString()
            DateForPeriod = dtFromDate
        ElseIf Not Request.Form("hidFromDate") Is Nothing OrElse Request.Form("hidFromDate") <> "" Then
            dtFromDate = Request.Form("hidFromDate").ToString()
            DateForPeriod = dtFromDate
        End If

        If Not Request.QueryString("RoleID") Is Nothing Then
            RoleID = Request.QueryString("RoleID").ToString()
        ElseIf Not Request.Form("hidRoleID") Is Nothing OrElse Request.Form("hidRoleID") <> "" Then
            RoleID = Request.Form("hidRoleID").ToString()
        End If

        If Not Request.QueryString("FromWhere") Is Nothing Then
            FromWhere = Request.QueryString("FromWhere")
        ElseIf Not Request.Form("hidFromWhere") Is Nothing OrElse Request.Form("hidFromWhere") <> "" Then
            FromWhere = Request.Form("hidFromWhere").ToString()
        End If

        If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        End If

        If Not Request.Form("txtEMPName") Is Nothing Then
            m_EmpName = Request.Form("txtEMPName").ToString()
            m_EmpName_SP = m_EmpName
            m_EmpName_SP = "'" + m_EmpName_SP.Replace("'", "''") + "'"
        End If

        If m_EmpName = "" Then
            m_EmpName_SP = "NULL"
        End If

        
        strQuery = "usp_Sel_EmployeeInformation " + RoleID + ",'" + dtFromDate + "'," + m_LocationID + ",'" + FromWhere.ToUpper + "'," + Session("intUserID").ToString() + "," + m_EmpName_SP

        If m_intPageNumber > 0 Then
            CurrentIndex = (m_intPageNumber - 1) * PageSize
        Else
            CurrentIndex = 0
        End If



        If m_intPageNumber < 0 Then
            dsEmp = CommonFunction.Data.GetDataSet(strQuery, "EMPINFO", m_intTotalNoOfRows, MyBase.UseSQL)
        Else
            dsEmp = CommonFunction.Data.GetDataSet(strQuery, "EMPINFO", m_intTotalNoOfRows, CurrentIndex, PageSize, MyBase.UseSQL)
        End If


        If Page.IsPostBack = False Then
            For Each dr As DataRow In dsEmp.Tables(0).Rows
                Role = dr("Role").ToString()
                FormWhereCaption = CommonFunction.Data.CheckIsDBNull(dr("FromWhere"), "-").ToString()
                Exit For
            Next
        End If

        If Not Request.Form("hidRole") Is Nothing Then
            Role = Request.Form("hidRole").ToString()
        End If

        If Not Request.Form("hidFromWhereCaption") Is Nothing Then
            FormWhereCaption = Request.Form("hidFromWhereCaption").ToString()
        End If

        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidRoleID' id='hidRoleID' value='" + RoleID + "'>")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidFromDate' id='hidFromDate' value='" + dtFromDate + "'>")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidLocation' id='hidLocation' value='" + m_LocationID + "'>")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidFromWhere' id='hidFromWhere' value='" + FromWhere + "'>")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidRole' id='hidRole' value='" + Role + "'>")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidFromWhereCaption' id='hidFromWhereCaption' value='" + FormWhereCaption + "'>")


    End Sub
    Private Sub GenerateMenu()
        '====================================================================
        ' Procedure Name        :  GenerateMenu
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To getnerate Menu
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  ShraddhaM
        ' Created               :  27,Oct 2009
        '=====================================================================
        Dim arrMenu As System.Collections.ArrayList = New System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList = New System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList = New System.Collections.ArrayList

        arrMenu.Add("<Img Border=0 src='../../Images/cssImages/Link images/close.gif'>&nbsp;Close")
        arrMenuToolTip.Add("Clsoe")
        arrClientSideFunctions.Add("Close_onClick()")


        m_objMenu = New WebPages.Template.StaticMenu
        Dim strmenu As String = m_objMenu.DrawMenuWithEvents(GetArray(arrMenu), GetArray(arrClientSideFunctions), GetArray(arrMenuToolTip), True)
        m_sbHTML.Append(strmenu)

        m_objMenu = Nothing
    End Sub

    Private Function GetArray(ByVal arrList As ArrayList) As String()

        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Private Sub DrawFilter()

        m_sbHTML.Append("</BR>")

        m_sbHTML.Append("<TABLE id='tblHeader' cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable  >" + vbCrLf)
        m_sbHTML.Append("<TR class=clsTRPageFilters>")
        m_sbHTML.Append("<TD title='Starts with'>Employee Name&nbsp;")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        m_sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtEMPName", "txtEMPName", , 150, , m_EmpName, , , , , , , "onkeypress='javascript:setEmpFilter(event)' ", True, EnableHTMLEncode:=True))
        'ended by Shamkant s  for HTML encoding Date:06/10/15
        m_sbHTML.Append("</TD>")
        m_sbHTML.Append("</TR>")
        m_sbHTML.Append("</TABLE>")

    End Sub


    Private Sub DrawPageCaption()


        m_sbHTML.Append("<Table  cellpadding=0 cellspacing=0 width=100%>")
        m_sbHTML.Append("<tr class='clsTRPageCaption'>")
        m_sbHTML.Append("<td>" + FormWhereCaption + " For Role : " + Role + "</td>")
        'm_sbHTMLDIV.Append("<td align=right><a href ='Javascript:CloseDiv()'><img border=0 src = '../../Images/RM/Close.gif' > </a></td>")
        m_sbHTML.Append("</tr>")
        m_sbHTML.Append("</Table><BR>")
    End Sub
    Private Function DrawDtlEmpDiv()

        Dim EmployeeName As String
        Dim Role As String
        Dim Location As String
        Dim FormWhereCaption As String
        Dim strClass As String = "clsTREven"
        Dim Cnt As Integer = 1
        Dim BG As String
        Dim EmailID As String
        Dim m_sbHTMLDIV As System.Text.StringBuilder
        m_sbHTMLDIV = New System.Text.StringBuilder

       
        m_sbHTMLDIV.Append("<div id='PageDiv' style='width:99.99%;height:450px;overflow:auto'>")
        m_sbHTMLDIV.Append("<TABLE id='tblHeader' cellpadding=0 cellspacing=1 class='clsGridTable'  width=99.9% >" + vbCrLf)
        m_sbHTMLDIV.Append("<THead class='clsTRColumnHeader' >" + vbCrLf)
        m_sbHTMLDIV.Append("<TH align=left>Employee</TH>" + vbCrLf)
        m_sbHTMLDIV.Append("<TH align=left>Business Group</TH>" + vbCrLf)
        m_sbHTMLDIV.Append("<TH align=left>Organization Unit</TH>" + vbCrLf)
        m_sbHTMLDIV.Append("<TH align=left>Email ID</TH>" + vbCrLf)
        m_sbHTMLDIV.Append("</THead>" + vbCrLf)

        For Each dr As DataRow In dsEmp.Tables(0).Rows
            EmployeeName = dr("EmployeeName").ToString()
            Location = dr("Location").ToString()
            Role = dr("Role").ToString()
            BG = dr("BusinessGroup").ToString()
            EmailID = CommonFunction.Data.CheckIsDBNull(dr("EmailID"), "-").ToString()
            FormWhereCaption = CommonFunction.Data.CheckIsDBNull(dr("FromWhere"), "-").ToString()

             

            m_sbHTMLDIV.Append("<TR class=" + strClass + ">")
            m_sbHTMLDIV.Append("<TD>" + EmployeeName + "</TD>")
            m_sbHTMLDIV.Append("<TD>" + BG + "</TD>")
            m_sbHTMLDIV.Append("<TD>" + Location + "</TD>")
            m_sbHTMLDIV.Append("<TD>" + EmailID + "</TD>")
            m_sbHTMLDIV.Append("</TR>")


            If strClass = "clsTROdd" Then
                strClass = "clsTREven"
            Else
                strClass = "clsTROdd"
            End If


        Next

        m_sbHTMLDIV.Append("</TABLE>" + vbCrLf)
        m_sbHTMLDIV.Append("</Div>" + vbCrLf)

        Return m_sbHTMLDIV


    End Function


    Private Function DrawDtlEmpPRJDiv()
        Dim strQuery As String
        Dim RoleID As String
        Dim dtFromDate As String
        Dim EmployeeName As String
        Dim Role As String
        Dim Location As String
        Dim FormWhereQS As String
        Dim strClass As String = "clsTREven"
        Dim Cnt As Integer = 1
        Dim BG As String
        Dim EmailID As String
        Dim Project As String
        Dim StartDate As String
        Dim EndDate As String
        Dim Per As String
        Dim EmployeeID As String
        Dim oldEmployeeName As String = ""
        Dim oldProjectName As String = ""


        Dim m_sbHTMLDIV As System.Text.StringBuilder
        m_sbHTMLDIV = New System.Text.StringBuilder




        m_sbHTMLDIV.Append("<div id='PageDiv' style='width:99.99%;height:450px;overflow:auto'>")
        m_sbHTMLDIV.Append("<TABLE id='tblHeader' cellpadding=0 cellspacing=1 class='clsGridTable'  width=99.9% >" + vbCrLf)
        m_sbHTMLDIV.Append("<THead class='clsTRColumnHeader' >" + vbCrLf)
        m_sbHTMLDIV.Append("<TH align=left>Employee</TH>" + vbCrLf)
        m_sbHTMLDIV.Append("<TH align=left>Project</TH>" + vbCrLf)
        m_sbHTMLDIV.Append("<TH align=left>Start Date</TH>" + vbCrLf)
        m_sbHTMLDIV.Append("<TH align=left>End Date</TH>" + vbCrLf)
        m_sbHTMLDIV.Append("<TH align=right>Allocation %</TH>" + vbCrLf)
        m_sbHTMLDIV.Append("</THead>" + vbCrLf)



        For Each dr As DataRow In dsEmp.Tables(0).Rows

            EmployeeName = dr("EmployeeName").ToString()
            'Location = dr("Location").ToString()
            Role = dr("Role").ToString()
            Project = dr("ProjectName").ToString()
            StartDate = CommonFunction.Dates.CGetDate(CType(dr("ExpectedStartDate"), Date)).ToString()
            EndDate = CommonFunction.Dates.CGetDate(CType(dr("ExpectedEndDate"), Date)).ToString()
            Per = CommonFunction.Data.CheckIsDBNull(dr("ResourcePercentage"), "-").ToString()
            'BG = dr("BusinessGroup").ToString()
            'EmailID = dr("EmailID").ToString()
            EmployeeID = dr("EmployeeID").ToString()
            FromWhere = dr("FromWhere").ToString()

 

            If DateForPeriod = "" Then
                DateForPeriod = CType(Now.Date, String)
            End If

            m_FinancialPeriodCount = DateDiff("m", Now.Date, DateForPeriod)

            m_sbHTMLDIV.Append("<TR class=" + strClass + ">")

            If oldEmployeeName <> EmployeeName Then
                m_sbHTMLDIV.Append("<TD><A onclick=ShowAllocation_onClick(" + EmployeeID + ",'" + m_FinancialPeriodCount + "')><U>" + EmployeeName + "</U></A></TD>")
            Else
                m_sbHTMLDIV.Append("<TD>&nbsp;</TD>")
            End If

            If oldProjectName <> Project OrElse (oldEmployeeName <> EmployeeName And oldProjectName = Project) Then
                m_sbHTMLDIV.Append("<TD>" + Project + "</TD>")
            Else
                m_sbHTMLDIV.Append("<TD>&nbsp;</TD>")
            End If

            m_sbHTMLDIV.Append("<TD>" + StartDate + "</TD>")
            m_sbHTMLDIV.Append("<TD>" + EndDate + "</TD>")
            m_sbHTMLDIV.Append("<TD align=right>" + Per + "</TD>")

            m_sbHTMLDIV.Append("</TR>")


            If strClass = "clsTROdd" Then
                strClass = "clsTREven"
            Else
                strClass = "clsTROdd"
            End If

            oldEmployeeName = EmployeeName
            oldProjectName = Project

        Next




        m_sbHTMLDIV.Append("</TABLE>" + vbCrLf)
        m_sbHTMLDIV.Append("</Div>" + vbCrLf)


        Return m_sbHTMLDIV

    End Function

    Private Sub DrawTotalRec()

        m_sbHTML.Append("<TABLE class=clsTable cellpadding=0 cellspacing=0 width='100%'>")
        m_sbHTML.Append("<TR class=clsTREven>")
        m_sbHTML.Append("<TD  width='100%' align='right'>Total Records :" + m_intTotalNoOfRows.ToString())
        m_sbHTML.Append("</TD></TR></TABLE>")

    End Sub

    Private Sub WritePaging()

        Dim strPaging As String = ""
        Dim strSectionTag As String = "divGrid"
        Dim strFunctionName As String = "ShowHide_divGrid"
        

        If Math.Ceiling(m_intTotalNoOfRows / PageSize) < m_intPageNumber Then
            m_intPageNumber = 1
        End If

        m_sbHTML.Append("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>")
        m_sbHTML.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        m_sbHTML.Append("<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>")
        m_sbHTML.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        m_sbHTML.Append("<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>")

        If m_intPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
            'Commented and added by Shamkant s for HTML encoding Date:06/10/15
            m_sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True))
        Else
            m_sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True))
            'ended by Shamkant s  for HTML encoding Date:06/10/15
        End If
        m_sbHTML.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        m_sbHTML.Append("<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>")
        m_sbHTML.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        m_sbHTML.Append("<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> ")
        m_sbHTML.Append("<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intTotalNoOfRows / PageSize)).ToString + ">")

        m_sbHTML.Append(" of " + (Math.Ceiling(m_intTotalNoOfRows / PageSize)).ToString)
        m_sbHTML.Append("|<A href='javascript:Page_OnClick(""-1"")' TITLE='Show All Records'><B>All</B> </A>")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        m_sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / PageSize)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True))
        'ended by Shamkant s  for HTML encoding Date:06/10/15
        m_sbHTML.Append("</TD></TR></Table>")

    End Sub

End Class