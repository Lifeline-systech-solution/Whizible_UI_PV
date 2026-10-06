'=====================================================================
' Class	Name	        :	PM_XMLHttp
' Purpose				:	This class is used to handles server side validations
' Description			:	Same as above
' Assumptions			:	None
' Dependencies			:	None
' Author				:	Amit Mahadik
' Created				:	30-Jan-2013
' Revisions				:	
'=====================================================================
Imports System.Xml
Imports System.Text
Imports PbNIT

Public Class PM_XMLHttp
    Inherits WebPages.Template.WhizTemplate

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Put user code to initialize the page here
        'Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)         
        MyBase.ApplySecurity(True)
        'End Of Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        Dim lngTagID As Long
        Dim strMode As String
        lngTagID = CType(Request.QueryString.Get("TagID"), Long)
        Dim strResult As String
        strMode = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode")).ToString()

        Select Case lngTagID
            Case -1 ' 

                If strMode.ToUpper() = "SLA" Then

                    strResult = PlotHtmlAutoRefreshingSLADashboard()

                    Response.Clear()
                    Response.Write(strResult)
                    Response.End()

                    
                End If
                'Added By Amit Mahadik on 04-FEB-2013 for Customization 'Trioka Change Management 2012-2013'
                If strMode.ToUpper() = "OPENINCIDENTSBYPROJECT" Then
                    strResult = PlotHtmlListofOpenIncidentsByProject()

                    Response.Clear()
                    Response.Write(strResult)
                    Response.End()
                End If
                'Added By Amit Mahadik on 04-FEB-2013 for Customization 'Trioka Change Management 2012-2013'


        End Select
        'Added By AshwiniM on 01-FEB-2013 for Customization 'Trioka Change Management 2012-2013'
        If strMode.ToUpper() = "DISCUSSION_THREAD" Then
            strResult = PlotHtmlDiscussionThreadAttachent()
            Response.Clear()
            Response.Write(strResult)
            Response.End()
            'AEnd of dded By AshwiniM on 01-FEB-2013 for Customization 'Trioka Change Management 2012-2013'
        End If
        'Added By AshwiniM on 07-FEB-2013 for Customization 'Trioka Change Management 2012-2013'
        If strMode.ToUpper() = "DISCUSSION_THREAD_ATTACHMENT" Then
            strResult = DeleteDiscussionThreadAttachent()
            Response.Clear()
            Response.Write(strResult)
            Response.End()
            'AEnd of dded By AshwiniM on 07-FEB-2013 for Customization 'Trioka Change Management 2012-2013'
        End If
        
    End Sub

    Public Shared Function PlotHtmlAutoRefreshingSLADashboard() As String
        '=====================================================================
        ' Purpose               : Customization 'Trioka Change Management 2012-2013'
        ' Description           : 
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amit Mahadik
        ' Created               : 30th January 2013
        ' Revisions             : 
        '=====================================================================
        Dim sbDashboardHTML As StringBuilder = New StringBuilder()
        Dim strAccessibleProjectList As String

        'strAccessibleProjectList = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_AccessibleProjects_ForEmployee_SLADashboard " & HttpContext.Current.Session("intUserID").ToString() & ",0,0,NULL,1,'" & HttpContext.Current.Session("LoginType").ToString() & "',1," & CType(HttpContext.Current.Session("intLoginID"), String) & ",0,1", True), "0"), "0")
        strAccessibleProjectList = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT ProjectIDs FROM tbl_PM_SLADashboard_FilterPreferences WHERE EmployeeID = " & HttpContext.Current.Session("intUserID").ToString(), True), "0"), "0")

        Dim dsAutoRefreshingSLADashboard As DataSet
        Dim SQLquerysla As String = "usp_sel_CalculateSLAForProjectIssues_SLADashboard '" & strAccessibleProjectList & "'"
        dsAutoRefreshingSLADashboard = CommonFunctions.Data.GetDataSet(SQLquerysla, "AutoRefreshingSLADashboard")

        sbDashboardHTML.Append("<Table class=clsTableSLA width='99.9%' cellpadding=0 cellspacing=0>")

        sbDashboardHTML.Append("<tr>")
        sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left rowspan='2'>" & "Project" & "</td>")
        sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left rowspan='2'>" & "Region" & "</td>")
        sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left rowspan='2'>" & "Issue No" & "</td>")
        sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left rowspan='2'>" & "Issue Description" & "</td>")
        sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left rowspan='2'>" & "Issue Type" & "</td>")
        sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left rowspan='2'>" & "Status" & "</td>")
        sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left rowspan='2'>" & "Priority" & "</td>")
        sbDashboardHTML.Append("<td  class=clsTDHeaderTitleSLA align=left colspan='5'>" & "Response SLA Elapsed Time" & "</td>")
        sbDashboardHTML.Append("<td  class=clsTDHeaderTitleSLA align=left colspan='5'>" & "Resolution SLA Elapsed Time" & "</td>")
        sbDashboardHTML.Append("</tr>")

        sbDashboardHTML.Append("<tr class=clsTHHeaderSLA>")
        sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left>" & "Upto 20%" & "</td>")
        sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left>" & "21 to 50%" & "</td>")
        sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left>" & "51 to 80%" & "</td>")
        sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left>" & "81 to 90%" & "</td>")
        sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left>" & "Above 100%" & "</td>")

        sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left>" & "Upto 20%" & "</td>")
        sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left>" & "21 to 50%" & "</td>")
        sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left>" & "51 to 80%" & "</td>")
        sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left>" & "81 to 90%" & "</td>")
        sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left>" & "Above 100%" & "</td>")
        sbDashboardHTML.Append("</tr>")
        For Each drRow As DataRow In dsAutoRefreshingSLADashboard.Tables(0).Select("1=1")

            sbDashboardHTML.Append("<tr class=clsTRRow>")
            sbDashboardHTML.Append("<td  class=clsTDWhite align=left>" & drRow("ProjectName") & "</td>")
            sbDashboardHTML.Append("<td  class=clsTDWhite align=left>" & drRow("Region") & "</td>")
            sbDashboardHTML.Append("<td  class=clsTDWhite align=center>" & drRow("IssueID") & "</td>")
            sbDashboardHTML.Append("<td  class=clsTDWhite align=left>" & drRow("Description") & "</td>")
            sbDashboardHTML.Append("<td  class=clsTDWhite align=left>" & drRow("Type") & "</td>")
            sbDashboardHTML.Append("<td  class=clsTDWhite align=left>" & drRow("Status") & "</td>")
            sbDashboardHTML.Append("<td  class=clsTDWhite align=left>" & drRow("Priority") & "</td>")
            ''clsTDPink==Response
            sbDashboardHTML.Append("<td  class=clsTDPink >" & drRow("Response Upto 20%") & "</td>")
            sbDashboardHTML.Append("<td  class=clsTDPink >" & drRow("Response 21 to 50%") & "</td>")
            sbDashboardHTML.Append("<td  class=clsTDPink >" & drRow("Response 51 to 80%") & "</td>")
            sbDashboardHTML.Append("<td  class=clsTDPink >" & drRow("Response 81 to 90%") & "</td>")
            sbDashboardHTML.Append("<td  class=clsTDPink >" & drRow("Response Above 100%") & "</td>")
            ''clsTDGreen==Resolution
            sbDashboardHTML.Append("<td  class=clsTDGreen >" & drRow("Resolution Upto 20%") & "</td>")
            sbDashboardHTML.Append("<td  class=clsTDGreen >" & drRow("Resolution 21 to 50%") & "</td>")
            sbDashboardHTML.Append("<td  class=clsTDGreen >" & drRow("Resolution 51 to 80%") & "</td>")
            sbDashboardHTML.Append("<td  class=clsTDGreen >" & drRow("Resolution 81 to 90%") & "</td>")
            sbDashboardHTML.Append("<td  class=clsTDGreen >" & drRow("Resolution Above 100%") & "</td>")
            sbDashboardHTML.Append("</tr>")


        Next

        sbDashboardHTML.Append("</Table>")

        Return sbDashboardHTML.ToString()
    End Function

    Public Shared Function PlotHtmlListofOpenIncidentsByProject() As String
        '=====================================================================
        ' Purpose               : Customization 'Trioka Change Management 2012-2013'
        ' Description           : 
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AMIT MAHADIK
        ' Created               : 04TH FEBRUARY 2013
        ' Revisions             : 
        '=====================================================================
        Dim sbDashboardHTML As StringBuilder = New StringBuilder()
        Dim strAccessibleProjectList As String

        ''strAccessibleProjectList = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_AccessibleProjects_ForEmployee_SLADashboard " & HttpContext.Current.Session("intUserID").ToString() & ",0,0,NULL,1,'" & HttpContext.Current.Session("LoginType").ToString() & "',1," & CType(HttpContext.Current.Session("intLoginID"), String) & ",0,1", True), "0"), "0")
        strAccessibleProjectList = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT ProjectIDs FROM tbl_PM_SLADashboard_FilterPreferences WHERE EmployeeID = " & HttpContext.Current.Session("intUserID").ToString(), True), "0"), "0")

        Dim dsListofOpenIncidentsByProject As DataSet
        dsListofOpenIncidentsByProject = CommonFunctions.Data.GetDataSet("usp_sel_ListofOpenIncidentsByProject_SLADashboard '" & strAccessibleProjectList & "'", "ListofOpenIncidentsByProject")

        sbDashboardHTML.Append("<Table class=clsTableSLA width='99.9%' cellpadding=0 cellspacing=0>")


        sbDashboardHTML.Append("<tr class=clsTHHeaderSLA>")

        ' Iterate through a collection
        For Each col As DataColumn In dsListofOpenIncidentsByProject.Tables(0).Columns
            If col.ColumnName = "Project Name" Or col.ColumnName = "Region" Then
                sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left>" & col.ColumnName & "</td>")
            Else
                sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=center>" & col.ColumnName & "</td>")
            End If
        Next

        'sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left>" & "Project Name " & "</td>")
        'sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=left>" & "Region" & "</td>")

        'sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=center>" & "P1" & "</td>")
        'sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=center>" & "P2" & "</td>")
        'sbDashboardHTML.Append("<td  class=clsTDHeaderSLA align=center>" & "P3" & "</td>")

        sbDashboardHTML.Append("</tr>")
        For Each drRow As DataRow In dsListofOpenIncidentsByProject.Tables(0).Select("1=1")

            sbDashboardHTML.Append("<tr class=clsTRRow>")

            For Each col As DataColumn In dsListofOpenIncidentsByProject.Tables(0).Columns
                If col.ColumnName = "Project Name" Or col.ColumnName = "Region" Then
                    sbDashboardHTML.Append("<td  class=clsTDWhite align=left>" & drRow(col.ColumnName) & "</td>")
                Else
                    sbDashboardHTML.Append("<td  class=clsTDWhite align=center>" & drRow(col.ColumnName) & "</td>")
                End If
            Next

            sbDashboardHTML.Append("</tr>")


        Next

        sbDashboardHTML.Append("</Table>")

        Return sbDashboardHTML.ToString()
    End Function

    'Added By AshwiniM on 01-FEB-2013 for Customization 'Trioka Change Management 2012-2013'
    Public Shared Function PlotHtmlDiscussionThreadAttachent() As String
        Dim drFile As IDataReader
        Dim sbDTHTML As StringBuilder = New StringBuilder()
        Dim strOrigialFileName, strSystemFileName As String
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        'drFile = CommonFunction.Data.GetDataReader("Select OriginalFileName,FilePath from tbl_IB_Attachments where OriginalFileName IS NOT NULL AND IssueId=" + HttpContext.Current.Request.QueryString("IssueID").ToString + "And AttachmentID=" + HttpContext.Current.Request.QueryString("AttachmentID").ToString, True)
        drFile = CommonFunction.Data.GetDataReader("usp_sel_tbl_IB_Attachments_FilePath " + HttpContext.Current.Request.QueryString("IssueID").ToString + "," + HttpContext.Current.Request.QueryString("AttachmentID").ToString, True)

        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

        If drFile.Read Then
            strOrigialFileName = CommonFunction.Data.CheckIsDBNull(drFile("OriginalFileName"), "").ToString
            strSystemFileName = CommonFunction.Data.CheckIsDBNull(drFile("FilePath"), "").ToString
        End If
        CommonFunction.Data.DisposeDataReader(drFile)
        sbDTHTML.Append("<font color='BLUE'><A href=""JavaScript:ViewAttachment_OnClick('" & strOrigialFileName & "','" & strSystemFileName & "' )"" >'" & strOrigialFileName & "'</A></font>")
        Return sbDTHTML.ToString()
    End Function
    'End of Added By AshwiniM on 01-FEB-2013 for Customization 'Trioka Change Management 2012-2013'

    'Added By AshwiniM on 07-FEB-2013 for Customization 'Trioka Change Management 2012-2013'
    Public Shared Function DeleteDiscussionThreadAttachent()
        Dim drFile As IDataReader
        Dim sbDTHTML As StringBuilder = New StringBuilder()
        Dim strSQL As String
        strSQL = "UPDATE tbl_IB_Attachments SET IsForDT = 0 WHERE AttachmentID=" + HttpContext.Current.Request.QueryString("AttachmentID").ToString
        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
        CommonFunction.Data.DisposeDataReader(drFile)
        Return 1
    End Function
    'End of Added By AshwiniM on 07-FEB-2013 for Customization 'Trioka Change Management 2012-2013'


End Class