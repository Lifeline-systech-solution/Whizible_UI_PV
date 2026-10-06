#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Partial Public Class Home_TextSearch
    Inherits WebPages.Template.WhizTemplate

    Private WithEvents m_objMenu As New StaticMenu
    Protected m_strSearch As String = ""
    Protected m_strParameter As String = ""
    Private strMode As String = ""
    'Protected m_FilterSummaryDetails As Boolean = True
    Private m_strDescription As String = ""
    Private m_strIssueIDs As String = ""

    Protected m_intPageNumber1 As Integer = 1
    Protected m_intPageNumber2 As Integer = 1
    Protected m_intPageNumber3 As Integer = 1
    Protected m_intPageNumber4 As Integer = 1
    Protected m_intPageNumber5 As Integer = 1

    Protected m_intPageNumber As Integer = 1

    Private m_intTotalNoOfRows As Integer
    Private m_strWhichPage As String
    Protected Const PAGE_SIZE As Integer = 20

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
    End Sub

    Protected Sub PageInit()
        If Not Request.QueryString("Mode") Is Nothing OrElse Request.QueryString("Mode") <> "" Then
            strMode = Request.QueryString("Mode")
        End If

        ' page number
        If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("WhichPage"), "") <> "" Then
            m_strWhichPage = Request.QueryString("WhichPage")
        Else
            m_strWhichPage = "NULL"
        End If

        If m_strWhichPage = "1" Then
            If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
                m_intPageNumber1 = CType(Request.QueryString("PageNumber"), Integer)
                m_intPageNumber2 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber2"), "1"), Integer)
                m_intPageNumber3 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber3"), "1"), Integer)
                m_intPageNumber4 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber4"), "1"), Integer)
                m_intPageNumber5 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber5"), "1"), Integer)
            End If
        ElseIf m_strWhichPage = "2" Then
            If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
                m_intPageNumber2 = CType(Request.QueryString("PageNumber"), Integer)
                m_intPageNumber1 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber1"), "1"), Integer)
                m_intPageNumber3 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber3"), "1"), Integer)
                m_intPageNumber4 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber4"), "1"), Integer)
                m_intPageNumber5 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber5"), "1"), Integer)
            End If
        ElseIf m_strWhichPage = "3" Then
            If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
                m_intPageNumber3 = CType(Request.QueryString("PageNumber"), Integer)
                m_intPageNumber1 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber1"), "1"), Integer)
                m_intPageNumber2 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber2"), "1"), Integer)
                m_intPageNumber4 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber4"), "1"), Integer)
                m_intPageNumber5 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber5"), "1"), Integer)
            End If
        ElseIf m_strWhichPage = "4" Then
            If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
                m_intPageNumber4 = CType(Request.QueryString("PageNumber"), Integer)
                m_intPageNumber2 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber2"), "1"), Integer)
                m_intPageNumber3 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber3"), "1"), Integer)
                m_intPageNumber1 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber1"), "1"), Integer)
                m_intPageNumber5 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber5"), "1"), Integer)
            End If
        ElseIf m_strWhichPage = "5" Then
            If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
                m_intPageNumber5 = CType(Request.QueryString("PageNumber"), Integer)
                m_intPageNumber2 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber2"), "1"), Integer)
                m_intPageNumber3 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber3"), "1"), Integer)
                m_intPageNumber4 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber4"), "1"), Integer)
                m_intPageNumber1 = CType(CommonFunction.General.CheckIsNothing(Request.Form("hidPageNumber1"), "1"), Integer)
            End If

        End If


        If Not Request.QueryString("Parameter") Is Nothing OrElse Request.QueryString("Parameter") <> "" Then
            m_strParameter = Request.QueryString("Parameter")
        ElseIf CommonFunction.General.CheckIsNothing(Session("Parameter"), "") <> "" Then
            m_strParameter = Session("Parameter")
        Else
            m_strParameter = ""
        End If

        If strMode = 1 Then
            Call SelectionCheckBox()
        Else
            Call DiplayTables()
        End If


    End Sub

    Private Sub DiplayTables()
        Call DrawMenu()
        CommonFunctions.General.WriteHTML("<BR>")

        Dim dsRecords As DataSet
        Dim drRecords As IDataReader

        Dim dsPagingRecords As DataSet
        Dim drPagingRecords As IDataReader

        Dim drColHeadings As DataRow
        Dim blnFlag As Boolean = False
        Dim strSql As String
        Dim ReadCount As Integer
        Dim iterator As Integer = 0


        If Not Request.QueryString("TextSearch") Is Nothing OrElse Request.QueryString("TextSearch") <> "" Then
            m_strSearch = Replace(HttpContext.Current.Server.UrlDecode(Request.QueryString("TextSearch")), "|", "'")
        Else
            m_strSearch = ""
        End If

        Session("Parameter") = m_strParameter

        'dsPagingRecords = CommonFunctions.Data.GetDataSet(" usp_Sel_Count_ProjectTextSearch " + HttpContext.Current.Session("intProjectID").ToString() + ",'" + CommonFunctions.General.BuildQueryString(m_strSearch) + "','" + CommonFunctions.General.BuildQueryString(m_strParameter) + "'", "PagingRecords", , , MyBase.UseSQL)
        drPagingRecords = CommonFunctions.Data.GetDataReader(" usp_Sel_Count_ProjectTextSearch " + HttpContext.Current.Session("intProjectID").ToString() + ",'" + CommonFunctions.General.BuildQueryString(m_strSearch) + "','" + CommonFunctions.General.BuildQueryString(m_strParameter) + "'", MyBase.UseSQL)


        'dsRecords = CommonFunctions.Data.GetDataSet(" usp_Sel_ProjectTextSearch " + HttpContext.Current.Session("intProjectID").ToString() + ",'" + CommonFunctions.General.BuildQueryString(m_strSearch) + "','" + CommonFunctions.General.BuildQueryString(m_strParameter) + "'," + m_intPageNumber.ToString + "," + m_strWhichPage.ToString, "Records", , , MyBase.UseSQL)
        drRecords = CommonFunctions.Data.GetDataReader(" usp_Sel_ProjectTextSearch " + HttpContext.Current.Session("intProjectID").ToString() + ",'" + CommonFunctions.General.BuildQueryString(m_strSearch) + "','" + CommonFunctions.General.BuildQueryString(m_strParameter) + "'," + m_intPageNumber1.ToString + "," + m_intPageNumber2.ToString + "," + m_intPageNumber3.ToString + "," + m_intPageNumber4.ToString + "," + m_intPageNumber5.ToString + "," + m_strWhichPage.ToString, MyBase.UseSQL)


        CommonFunctions.General.WriteHTML("<DIV Id='divPage' Style='height:600px; overflow:auto; width:99.99%' >")
        Dim intCounter As Integer = 0
        'Issues       
        'If dsRecords.Tables(0).Rows.Count > 0 Then

        If m_strWhichPage = "1" Then
            If m_intPageNumber1 > 0 Then
                For ReadCount = 1 To (20 * (m_intPageNumber1 - 1))
                    drRecords.Read()
                Next
            End If
        End If

        While drRecords.Read
            iterator = iterator + 1  
            If iterator = 1 Then
                CommonFunctions.General.WriteHTML("<table id='tblGridI' width='99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable'>")
                CommonFunctions.General.WriteHTML("<TR class='clsTRBlank' width=99.9% >")
                CommonFunctions.General.WriteHTML("<TD align='left'><B>Issues</B></TD>")
                CommonFunctions.General.WriteHTML("<TD align='right'>")
                While drPagingRecords.Read
                    Call WritePaging(CType(CommonFunctions.Data.CheckIsDBNull(drPagingRecords("Count"), ""), String), 1, m_intPageNumber1)
                End While
                CommonFunctions.General.WriteHTML("</TD></TR>")
                CommonFunctions.General.WriteHTML("</table><BR>")
                CommonFunctions.General.WriteHTML("<DIV Id='divPageIssue' Style='height:300px; overflow:auto; width:99.99%' >")
                CommonFunctions.General.WriteHTML("<table id='tblGridIssue' width='99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable'>")
                CommonFunctions.General.WriteHTML("<TR class='clsTRBlankNEW' width=99.9% >")
                CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                CommonFunctions.General.WriteHTML("<TD><B>Issue ID</B></TD>")
                CommonFunctions.General.WriteHTML("<TD><B>Summary</B></TD>")
                CommonFunctions.General.WriteHTML("<TD><B>Type</B></TD>")
                CommonFunctions.General.WriteHTML("<TD><B>SubType</B></TD>")
                CommonFunctions.General.WriteHTML("<TD><B>Priority</B></TD>")
                CommonFunctions.General.WriteHTML("<TD><B>Status</B></TD>")
                CommonFunctions.General.WriteHTML("<TD><B>ReportedDate</B></TD>")
                CommonFunctions.General.WriteHTML("</TR>")
                intCounter = iterator
            End If
            CommonFunctions.General.WriteHTML("<TR class='clsTRBlank' width=99.9% >")
            CommonFunctions.General.WriteHTML("<TD>")

            CommonFunctions.General.WriteHTML("<a href='javascript:SummaryDetails(" & CType(CommonFunctions.Data.CheckIsDBNull(drRecords("IssueID"), ""), String) & ")'>")
            CommonFunctions.General.WriteHTML("<img Border=0 Src='../../Images/plus.gif' Collapse='N' alt='Summary Details' title='Summary Details' ID='imgSummaryShowHide" & CType(CommonFunctions.Data.CheckIsDBNull(drRecords("IssueID"), ""), String) & "' name='imgSummaryShowHide" & CType(CommonFunctions.Data.CheckIsDBNull(drRecords("IssueID"), ""), String) & "'> </a>")
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("IssueID"), ""), String) + "</TD>")
            CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("Summary"), ""), String) + "</TD>")
            CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("Type"), ""), String) + "</TD>")
            CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("SubType"), ""), String) + "</TD>")
            CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("Priority"), ""), String) + "</TD>")
            CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("Status"), ""), String) + "</TD>")
            CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("ReportedDate"), ""), String) + "</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            CommonFunctions.General.WriteHTML("<TR id='Description" & CType(CommonFunctions.Data.CheckIsDBNull(drRecords("IssueID"), ""), String) & "' name='Description" & CType(CommonFunctions.Data.CheckIsDBNull(drRecords("IssueID"), ""), String) & "' class='clsTRBlank' width=99.9% style=""display:none"">")
            CommonFunctions.General.WriteHTML("<TD align=left colspan=8>")
            CommonFunctions.General.WriteHTML("<DIV id=Summary" & CType(CommonFunctions.Data.CheckIsDBNull(drRecords("IssueID"), ""), String) & " name=Summary" & CType(CommonFunctions.Data.CheckIsDBNull(drRecords("IssueID"), ""), String) & " style=""overflow:auto;display:none"">")
            CommonFunctions.General.WriteHTML("<TABLE ID='Description' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunctions.General.WriteHTML("<tr class = 'clsTRBlank'>")
            CommonFunctions.General.WriteHTML("<td valign=top colspan=1 align='right' width=10%>Description : </td><td valign=top colspan=7 align='left' width=90%>")
            CommonFunctions.General.WriteHTML(CType(CommonFunctions.Data.CheckIsDBNull(drRecords("Description"), ""), String))
            CommonFunctions.General.WriteHTML("</TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("</DIV>")
            CommonFunctions.General.WriteHTML("</TD></TR>")
            m_strIssueIDs = m_strIssueIDs & CType(CommonFunctions.Data.CheckIsDBNull(drRecords("IssueID"), ""), String) & ","
            blnFlag = True
        End While
        If intCounter = 1 Then
                CommonFunctions.General.WriteHTML("</table>")
                CommonFunctions.General.WriteHTML("</DIV>")
        End If
        CommonFunctions.General.WriteHTML("<BR>")
        iterator = 0
        intCounter = 0

        'Task
        If drRecords.NextResult Then
            If m_intPageNumber2 > 0 Then
                For ReadCount = 1 To (20 * (m_intPageNumber2 - 1))
                    drRecords.Read()
                Next
            End If

            While drRecords.Read
                iterator = iterator + 1
                If iterator = 1 Then
                    CommonFunctions.General.WriteHTML("<table id='tblGridT' width='99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable'>")
                    CommonFunctions.General.WriteHTML("<TR class='clsTRBlank' width=99.9% >")
                    CommonFunctions.General.WriteHTML("<TD align='left'><B>Tasks</B></TD>")
                    CommonFunctions.General.WriteHTML("<TD align='right'>")
                    If drPagingRecords.NextResult Then
                        While drPagingRecords.Read
                            Call WritePaging(CType(CommonFunctions.Data.CheckIsDBNull(drPagingRecords("Count"), ""), String), 2, m_intPageNumber2)
                        End While
                    End If
                    CommonFunctions.General.WriteHTML("</TD></TR>")
                    CommonFunctions.General.WriteHTML("</table><BR>")

                    CommonFunctions.General.WriteHTML("<DIV Id='divPageTask' Style='height:300px; overflow:auto; width:99.99%' >")
                    CommonFunctions.General.WriteHTML("<table id='tblGridTask' width='99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable'>")
                    CommonFunctions.General.WriteHTML("<TR class='clsTRBlankNEW' width=99.9% >")
                    CommonFunctions.General.WriteHTML("<TD><B>Task Name</B></TD>")
                    CommonFunctions.General.WriteHTML("<TD><B>Start Date</B></TD>")
                    CommonFunctions.General.WriteHTML("<TD><B>End Date</B></TD>")
                    CommonFunctions.General.WriteHTML("<TD><B>Employee Name</B></TD>")
                    CommonFunctions.General.WriteHTML("</TR>")
                    intCounter = iterator
                End If
                CommonFunctions.General.WriteHTML("<TR class='clsTRBlank' width=99.9% >")
                CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("TaskName"), ""), String) + "</TD>")
                CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunction.Dates.GetDate(CommonFunctions.Data.CheckIsDBNull(drRecords("StartDate"), "")), String) + "</TD>")
                CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunction.Dates.GetDate(CommonFunctions.Data.CheckIsDBNull(drRecords("EndDate"), "")), String) + "</TD>")
                CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("EmployeeName"), ""), String) + "</TD>")
                CommonFunctions.General.WriteHTML("</TR>")
                blnFlag = True
            End While
        End If
       If intCounter = 1 Then
                CommonFunctions.General.WriteHTML("</table>")
                CommonFunctions.General.WriteHTML("</DIV>")
        End If
        CommonFunctions.General.WriteHTML("<BR>")
        iterator = 0
        intCounter = 0


        ''Milestone
        If drRecords.NextResult Then
            If m_intPageNumber3 > 0 Then
                For ReadCount = 1 To (20 * (m_intPageNumber3 - 1))
                    drRecords.Read()
                Next
            End If

            While drRecords.Read
                iterator = iterator + 1
                If iterator = 1 Then
                    CommonFunctions.General.WriteHTML("<table id='tblGridM' width='99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable'>")
                    CommonFunctions.General.WriteHTML("<TR class='clsTRBlank' width=99.9% >")
                    CommonFunctions.General.WriteHTML("<TD align='left'><B>Milestone</B></TD>")
                    CommonFunctions.General.WriteHTML("<TD align='right'>")
                    If drPagingRecords.NextResult Then
                        While drPagingRecords.Read
                            Call WritePaging(CType(CommonFunctions.Data.CheckIsDBNull(drPagingRecords("Count"), ""), String), 3, m_intPageNumber3)
                        End While
                    End If
                    CommonFunctions.General.WriteHTML("</TD></TR>")
                    CommonFunctions.General.WriteHTML("</table><BR>")

                    CommonFunctions.General.WriteHTML("<DIV Id='divPageMilestone' Style='height:300px; overflow:auto; width:99.99%' >")
                    CommonFunctions.General.WriteHTML("<table id='tblGridMilestone' width='99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable'>")
                    CommonFunctions.General.WriteHTML("<TR class='clsTRBlankNEW' width=99.9% >")
                    CommonFunctions.General.WriteHTML("<TD><B>Milestone</B></TD>")
                    CommonFunctions.General.WriteHTML("<TD><B>Baseline Start</B></TD>")
                    CommonFunctions.General.WriteHTML("<TD><B>Baseline End</B></TD>")
                    CommonFunctions.General.WriteHTML("<TD><B>Milestone Status</B></TD>")
                    CommonFunctions.General.WriteHTML("</TR>")
                    intCounter = iterator
                End If
                CommonFunctions.General.WriteHTML("<TR class='clsTRBlank' width=99.9% >")
                CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("Milestone"), ""), String) + "</TD>")
                CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("BaselineStart"), ""), String) + "</TD>")
                CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("BaselineEnd"), ""), String) + "</TD>")
                CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("MilestoneStatus"), ""), String) + "</TD>")
                CommonFunctions.General.WriteHTML("</TR>")
                blnFlag = True
            End While
        End If
        If intCounter = 1 Then
                CommonFunctions.General.WriteHTML("</table>")
                CommonFunctions.General.WriteHTML("</DIV>")
        End If
        CommonFunctions.General.WriteHTML("<BR>")
        iterator = 0
        intCounter = 0


        ''Deliverable
        If drRecords.NextResult Then
            If m_intPageNumber4 > 0 Then
                For ReadCount = 1 To (20 * (m_intPageNumber4 - 1))
                    drRecords.Read()
                Next
            End If

            While drRecords.Read
                iterator = iterator + 1
                If iterator = 1 Then
                    CommonFunctions.General.WriteHTML("<table id='tblGridD' width='99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable'>")
                    CommonFunctions.General.WriteHTML("<TR class='clsTRBlank' width=99.9% >")
                    CommonFunctions.General.WriteHTML("<TD align='left'><B>Deliverable</B></TD>")
                    CommonFunctions.General.WriteHTML("<TD align='right'>")
                    If drPagingRecords.NextResult Then
                        While drPagingRecords.Read
                            Call WritePaging(CType(CommonFunctions.Data.CheckIsDBNull(drPagingRecords("Count"), ""), String), 4, m_intPageNumber4)
                        End While
                    End If
                    CommonFunctions.General.WriteHTML("</TD></TR>")
                    CommonFunctions.General.WriteHTML("</table><BR>")

                    CommonFunctions.General.WriteHTML("<DIV Id='divPageDeliverable' Style='height:300px; overflow:auto; width:99.99%' >")
                    CommonFunctions.General.WriteHTML("<table id='tblGridDeliverable' width='99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable'>")
                    CommonFunctions.General.WriteHTML("<TR class='clsTRBlankNEW' width=99.9% >")
                    CommonFunctions.General.WriteHTML("<TD><B>Title</B></TD>")
                    CommonFunctions.General.WriteHTML("<TD><B>Baseline StartDate</B></TD>")
                    CommonFunctions.General.WriteHTML("<TD><B>Baseline EndDate</B></TD>")
                    CommonFunctions.General.WriteHTML("</TR>")
                    intCounter = iterator
                End If
                CommonFunctions.General.WriteHTML("<TR class='clsTRBlank' width=99.9% >")
                CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("Title"), ""), String) + "</TD>")
                CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("BaselineStartDate"), ""), String) + "</TD>")
                CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("BaselineEndDate"), ""), String) + "</TD>")
                CommonFunctions.General.WriteHTML("</TR>")
                blnFlag = True
            End While
        End If
       If intCounter = 1 Then
                CommonFunctions.General.WriteHTML("</table>")
                CommonFunctions.General.WriteHTML("</DIV>")
        End If
        CommonFunctions.General.WriteHTML("<BR>")
        iterator = 0
        intCounter = 0

        ''Module
        If drRecords.NextResult Then
            If m_intPageNumber5 > 0 Then
                For ReadCount = 1 To (20 * (m_intPageNumber5 - 1))
                    drRecords.Read()
                Next
            End If

            While drRecords.Read
                iterator = iterator + 1
                If iterator = 1 Then
                    CommonFunctions.General.WriteHTML("<table id='tblGridMOD' width='99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable'>")
                    CommonFunctions.General.WriteHTML("<TR class='clsTRBlank' width=99.9% >")
                    CommonFunctions.General.WriteHTML("<TD align='left'><B>Module</B></TD>")
                    CommonFunctions.General.WriteHTML("<TD align='right'>")
                    If drPagingRecords.NextResult Then
                        While drPagingRecords.Read
                            Call WritePaging(CType(CommonFunctions.Data.CheckIsDBNull(drPagingRecords("Count"), ""), String), 5, m_intPageNumber5)
                        End While
                    End If
                    CommonFunctions.General.WriteHTML("</TD></TR>")
                    CommonFunctions.General.WriteHTML("</table><BR>")

                    CommonFunctions.General.WriteHTML("<DIV Id='divPageModule' Style='height:300px; overflow:auto; width:99.99%' >")
                    CommonFunctions.General.WriteHTML("<table id='tblGridModule' width='99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable'>")
                    CommonFunctions.General.WriteHTML("<TR class='clsTRBlankNEW' width=99.9% >")
                    CommonFunctions.General.WriteHTML("<TD><B>Module Name</B></TD>")
                    CommonFunctions.General.WriteHTML("<TD><B>Baseline StartDate</B></TD>")
                    CommonFunctions.General.WriteHTML("<TD><B>Baseline EndDate</B></TD>")
                    CommonFunctions.General.WriteHTML("</TR>")
                    intCounter = iterator
                End If
                CommonFunctions.General.WriteHTML("<TR class='clsTRBlank' width=99.9% >")
                CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("ModuleName"), ""), String) + "</TD>")
                CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("BaselineStartDate"), ""), String) + "</TD>")
                CommonFunctions.General.WriteHTML("<TD>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecords("BaselineEndDate"), ""), String) + "</TD>")
                CommonFunctions.General.WriteHTML("</TR>")
                blnFlag = True
            End While
        End If
        If intCounter = 1 Then
                CommonFunctions.General.WriteHTML("</table>")
                CommonFunctions.General.WriteHTML("</DIV>")
        End If
        CommonFunctions.General.WriteHTML("<BR>")
        iterator = 0
        intCounter = 0

        If blnFlag = False Then
            CommonFunctions.General.WriteHTML("<table id='tblGridNoItem' width='99.9%'  CellSpacing=1 CellPadding=0  class='clsGridTable'>")
            CommonFunctions.General.WriteHTML("<TR class='clsTRBlank' width=99.9% >")
            CommonFunctions.General.WriteHTML("<TD align='center'><B>There are no items to show in this view.</B></TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            CommonFunctions.General.WriteHTML("</table>")
        End If
        CommonFunctions.General.WriteHTML("</DIV>")

        CommonFunctions.General.WriteHTML("<input type=hidden name='hidSummaryDetailIDs' id='hidSummaryDetailIDs' value=" + m_strIssueIDs + ">")
        CommonFunction.Data.DisposeDataReader(drRecords)
        CommonFunction.Data.DisposeDataReader(drPagingRecords)
        Call DrawMenu()

    End Sub
    
    Private Sub DrawMenu()
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
        ' Author                :  NitinVS
        ' Created               :  4 th December 2006
        ' Revisions             :  
        '=====================================================================
        Dim arrMenu As System.Collections.ArrayList = New System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList = New System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList = New System.Collections.ArrayList

        If Request.QueryString("FromWhere") <> "DB" And strMode = 1 Then
            arrMenu.Add("<Img Border=0 src='../../Images/home/Close.png'>")
            arrMenuToolTip.Add("Close")
            arrClientSideFunctions.Add("Close_Click()")
        End If

        If strMode = 2 Then
            arrMenu.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>")
            arrMenuToolTip.Add("Help")
            arrClientSideFunctions.Add("Help_Click()")
        End If

        m_objMenu = New WebPages.Template.StaticMenu
        Dim strmenu As String = m_objMenu.DrawMenuWithEvents(GetArray(arrMenu), GetArray(arrClientSideFunctions), GetArray(arrMenuToolTip), True)
        If strMode = 2 Then
            strmenu = strmenu.Replace("class=clsTRMenu", "class=clsTRBlankNew")
            strmenu = strmenu.Replace("class=Menu", "")
        ElseIf strMode = 1 Then
            strmenu = strmenu.Replace("class=clsTRMenu", "class=clsTRPageCaption")
        End If

        CommonFunctions.General.WriteHTML(strmenu)

        m_objMenu = Nothing
    End Sub
    Private Sub SelectionCheckBox()
        If Not Request.QueryString("TextSearch") Is Nothing OrElse Request.QueryString("TextSearch") <> "" Then
            m_strSearch = Request.QueryString("TextSearch")
        Else
            m_strSearch = ""
        End If
        Call DrawMenu()
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML("<TABLE id='tblCap' cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable><TR class=clsTRPageCaption><TD align=Left>Search In</TD></TR></TABLE><BR>")

        CommonFunctions.General.WriteHTML("<div id='divPage' class='ContextMenu'  style=""overflow:auto;height:240px;width=99.99%"" >")
        CommonFunctions.General.WriteHTML("<table cellspacing='0' cellpadding='3' width=99.99% >")

        CommonFunctions.General.WriteHTML("<tr >")
        CommonFunctions.General.WriteHTML("<td class='CtMn_LeftFill'></td>")
        CommonFunctions.General.WriteHTML("<td class='clsTDChildNavMenu'>")
        If m_strParameter.Contains("I") Then
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawCheckBox("chkIssue", "chkComplete", , True, 1, , , , , , True, , ))
        Else
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawCheckBox("chkIssue", "chkComplete", , False, , , , , , , True, , ))
        End If
        CommonFunctions.General.WriteHTML("Issue</TD>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr><td class='CtMn_LeftFill_Hr'></td><td class='CtMn_Hr'></td></tr>")

        CommonFunctions.General.WriteHTML("<tr >")
        CommonFunctions.General.WriteHTML("<td class='CtMn_LeftFill'></td>")
        CommonFunctions.General.WriteHTML("<td class='clsTDChildNavMenu'>")
        If m_strParameter.Contains("T") Then
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawCheckBox("chkTask", "chkComplete", , True, 1, , , , , , True, , ))
        Else
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawCheckBox("chkTask", "chkComplete", , False, , , , , , , True, , ))
        End If

        CommonFunctions.General.WriteHTML("Task</TD>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr><td class='CtMn_LeftFill_Hr'></td><td class='CtMn_Hr'></td></tr>")

        CommonFunctions.General.WriteHTML("<tr >")
        CommonFunctions.General.WriteHTML("<td class='CtMn_LeftFill'></td>")
        CommonFunctions.General.WriteHTML("<td class='clsTDChildNavMenu'>")
        If m_strParameter.Contains("M") Then
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawCheckBox("chkMilestone", "chkComplete", , True, 1, , , , , , True, , ))
        Else
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawCheckBox("chkMilestone", "chkComplete", , False, , , , , , , True, , ))
        End If
        CommonFunctions.General.WriteHTML("Milestone</TD>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr><td class='CtMn_LeftFill_Hr'></td><td class='CtMn_Hr'></td></tr>")

        CommonFunctions.General.WriteHTML("<tr >")
        CommonFunctions.General.WriteHTML("<td class='CtMn_LeftFill'></td>")
        CommonFunctions.General.WriteHTML("<td class='clsTDChildNavMenu'>")
        If m_strParameter.Contains("D") Then
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawCheckBox("chkDeliverable", "chkComplete", , True, 1, , , , , , True, , ))
        Else
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawCheckBox("chkDeliverable", "chkComplete", , False, , , , , , , True, , ))
        End If

        CommonFunctions.General.WriteHTML("Deliverable</TD>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr><td class='CtMn_LeftFill_Hr'></td><td class='CtMn_Hr'></td></tr>")

        CommonFunctions.General.WriteHTML("<tr >")
        CommonFunctions.General.WriteHTML("<td class='CtMn_LeftFill'></td>")
        CommonFunctions.General.WriteHTML("<td class='clsTDChildNavMenu'>")
        If m_strParameter.Contains("MO") Then
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawCheckBox("chkModule", "chkComplete", , True, 1, , , , , , True, , ))
        Else
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawCheckBox("chkModule", "chkComplete", , False, , , , , , , True, , ))
        End If
        CommonFunctions.General.WriteHTML("Module</TD>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr><td class='CtMn_LeftFill_Hr'></td><td class='CtMn_Hr'></td></tr>")

        CommonFunctions.General.WriteHTML("<TR>")
        CommonFunctions.General.WriteHTML("<TD align='center' colspan=2><input type=button id='btnSearch' width='200px' onclick='OK_OnClik()' value='OK'></TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</div><br>")

        Call DrawMenu()

       

    End Sub

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Private Sub WritePaging(ByVal strCount As Integer, ByVal WhichPage As Integer, ByVal PageNumber As Integer)

        Dim intRecordCount As Integer
        Dim strPaging As String = ""

        'm_intTotalNoOfRows = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(PagingSQL, MyBase.UseSQL), ""), ""), Integer)
        m_intTotalNoOfRows = strCount

        If Math.Ceiling(m_intTotalNoOfRows / 20) < PageNumber Then
            PageNumber = 1
        End If

        strPaging = "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage(" + WhichPage.ToString + ")"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage(" + WhichPage.ToString + ")""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"

        If PageNumber = -1 Or m_intTotalNoOfRows = 0 Then
            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
            '    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + WhichPage.ToString, "txtPageNumber" + WhichPage.ToString, , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + WhichPage.ToString + ")", returnHTML:=True)
            'Else
            '    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + WhichPage.ToString, "txtPageNumber" + WhichPage.ToString, , 50, 4, PageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + WhichPage.ToString + ")", returnHTML:=True)
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + WhichPage.ToString, "txtPageNumber" + WhichPage.ToString, , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + WhichPage.ToString + ")", returnHTML:=True, EnableHTMLEncode:=True)
        Else
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + WhichPage.ToString, "txtPageNumber" + WhichPage.ToString, , 50, 4, PageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + WhichPage.ToString + ")", returnHTML:=True, EnableHTMLEncode:=True)

        End If

        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage(" + WhichPage.ToString + ")"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage(" + WhichPage.ToString + ")"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages" + WhichPage.ToString + " value=" + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString + ">"
        strPaging += "<input type=hidden name='hidPageNumber" + WhichPage.ToString + "' id='hidPageNumber" + WhichPage.ToString + "' value=" + PageNumber.ToString + ">"

        strPaging += " of " + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        'strPaging += "|<A href='javascript:Page_OnClick(""-1""," + WhichPage.ToString + ")' TITLE='Show All Records'><B>All<B></A>"
        '' strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages" + WhichPage.ToString, "txtNoOfPages" + WhichPage.ToString, , , , (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString, returnHTML:=True, DisplayNone:=True)
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages" + WhichPage.ToString, "txtNoOfPages" + WhichPage.ToString, , , , (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)

        Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRBlank'>")

        If Trim(strPaging & "") <> "" Then
            'Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")
            Response.Write("<td align=right>" + strPaging + "</TD>")
        End If

        Response.Write("</TR></TABLE>")

    End Sub
End Class