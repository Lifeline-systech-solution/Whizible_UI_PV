Imports System.IO

Public Class frmImpedimentLog
    Inherits WebPages.Template.WhizTemplate
    Private WithEvents objGrid As New WebPages.Template.GenericGrid
    Private WithEvents objHistoryGrid As New WebPages.Template.GenericGrid

    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Private Shared dtDSCurrentDate As String
    Private Shared m_objAccess As WebPage.Templates.AccessRights
    Protected Shared TagID As Integer = 22236
    Protected Shared m_intRoleID As Integer = 0
    Private m_objGlobal As WebPages.Template.IGlobal
    Protected Shared strLoginType = ""
    'Protected Shared m_lngReportID As Integer = 20143
    'Protected Shared m_lngReportID As Integer = 20144
    Protected Shared m_lngReportID As Integer = 22253


    Protected Shared m_strFileName As String
    Private Shared WithEvents oRpt As AdHocReports.Report.AdHocReport
    Protected Shared m_objIsProjectResource As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)

        m_intRoleID = CommonFunctions.General.CheckIsNothing(CType(Session("intPostID"), Long), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        GetAccessRights()
    End Sub

    Private Sub GetAccessRights()
        '=====================================================================
        ' Procedure Name        :	GetAccessRights
        ' Purpose               :	Get the Access Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Dipali V
        ' Created               :	5th-March-2018
        ' Revisions             :
        '=====================================================================
        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal
        m_objIsProjectResource = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("EXEC usp_NG2_Chk_ResourceAssignedOnProject " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID"), True), "0")
    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function GetProjectRiskId()
        '====================================================================
        ' Function  Name        : GetProjectRiskId
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To get next Project Risk Id for current Project
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Usha Pandit
        ' Created               : 09-Apr-2018
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = ""
        Dim strResult As String
        Dim index As Integer = 0
        Try

            strSQL = "exec Usp_Sel_ProjectRiskCount  " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ""
            strResult = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "0")

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetProjectEndDate()
        '====================================================================
        ' Function  Name        : GetProjectEndDate
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To get ProjectEndDate
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Usha Pandit
        ' Created               : 11-Apr-2018
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = ""
        Dim strResult As String
        Dim index As Integer = 0

        Try

            strSQL = "exec usp_Sel_tbl_PM_Project  " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ""
            'strResult = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataReader(strSQL, True), "0")
            Dim drProjectDetails As IDataReader
            drProjectDetails = CommonFunctions.Data.GetDataReader(strSQL, True)
            If drProjectDetails.Read Then
                strResult = CommonFunctions.Data.CheckIsDBNull(drProjectDetails("ExpectedEndDate"), "")
            End If
            If Not strResult = "" Then
                strResult = DateTime.Parse(Convert.ToDateTime(strResult)).ToString("dd-MMM-yyyy")
            End If
            'Dim CurrentDate As String = DateTime.Parse(DateTime.Now).ToString("dd-MMM-yyyy")
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ExportToExcel(ByVal ReportFormat As String, ByVal WhereFlag As String, ByVal WhereValue As String, ByVal WhereDate As String)
        '====================================================================
        ' Function  Name        : ExportToExcel
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To export Impediment Log Details to excel
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Usha Pandit
        ' Created               : 07-Apr-2018
        ' Revisions             :
        '=====================================================================
        Try
            Dim strSQL As String
            Dim strFilePath As String
            Dim strFormat As String
            Dim strCaptions As String


            Dim strWhereClause As String = ""
            Dim strFromDate As String = ""
            strSQL = "usp_NG2_sel_tbl_NG2_ImpedimentsLog " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")

            strFromDate = WhereDate

            If WhereFlag.ToUpper() = "STATUS" Then
                'If DateValue = "" Then
                strWhereClause = "Status = ''" & WhereValue & "''"
                'Else
                '    strWhereClause = "tbl_NG2_ImpedimentsLog.status = ''" & Value & "''" & " AND Convert(varchar(20),RaisedDate,101) = @dtFromDateNew "
                '    strFromDate = DateValue
                'End If

            ElseIf WhereFlag.ToUpper() = "DSM" Then
                'strWhereClause = "IsConvertedToImpediment = """ & Value & """"
                'If DateValue = "" Then
                strWhereClause = "ScrumMeetingID " & WhereValue & ""
                'Else
                '    strWhereClause = "ScrumMeetingID " & Value & "" & " AND Convert(varchar(20),RaisedDate,101) = @dtFromDateNew "
                '    strFromDate = DateValue
                'End If

            ElseIf WhereFlag.ToUpper() = "SPRINTS" Then
                'If DateValue = "" Then
                strWhereClause = "tbl_NG2_ImpedimentsLog.IterationID = """ & WhereValue & """"
            End If

            If strFromDate <> "" Then
                strSQL += ",'" + strFromDate + "'"
            End If
            If strWhereClause <> "" Then
                If strFromDate = "" Then
                    strSQL += ",NULL,'" + strWhereClause + "'"
                Else
                    strSQL += ",'" + strWhereClause + "'"
                End If

            End If

            ' The reports are created in the "Reports" folder
            strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../Reports/"))
            ' get a unique file name
            m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName.Trim
            ' add extn to file name based on format requested
            Select Case ReportFormat
                Case "PDF" : m_strFileName += ".pdf"
                Case "HTML" : m_strFileName += ".htm"
                Case "RTF" : m_strFileName += ".rtf"
                Case "EXCEL" : m_strFileName += ".xls"
                Case "CSV" : m_strFileName += ".csv"
                Case "TEXT" : m_strFileName += ".txt"
                Case "XML" : m_strFileName += ".xml"
                Case Else : m_strFileName += ".pdf"
            End Select

            Dim frmObjImpedimentLog As New frmImpedimentLog
            ' create object of Adhoc reports
            oRpt = New AdHocReports.Report.AdHocReport(m_lngReportID, strSQL, CommonFunctions.Application.ConnectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../Attachments/Log/")))
            With oRpt
                .UseMSSQL = frmObjImpedimentLog.UseSQL
                .DefaultLCID = CType(frmObjImpedimentLog.DefaultUILCID, Integer)
                .LCID = frmObjImpedimentLog.CurrentThreadUICultureID
                If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                    .UseHashTables = True
                Else
                    .UseHashTables = False
                End If
                '.UIParameters = strCaptions
                '.UIParametersDelimiter = "|"
                '.WatermarkImageFilePath = ""
                .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                .CompanyName = CommonFunctions.Application.CompanyName
                .GraphImageGenerationAbsolutePath = HttpContext.Current.Server.MapPath("../../Images/")

                ' generate the report in requested format

                Select Case ReportFormat
                    Case "PDF" : .GenerateReport(AdHocReports.Format.PDF)
                    Case "HTML" : .GenerateReport(AdHocReports.Format.HTML)
                    Case "RTF" : .GenerateReport(AdHocReports.Format.RTF)
                    Case "EXCEL" : .GenerateReport(AdHocReports.Format.EXCEL)
                    Case "CSV" : .GenerateReport(AdHocReports.Format.CSV)
                    Case "TEXT" : .GenerateReport(AdHocReports.Format.TEXT)
                    Case "XML" : .GenerateReport(AdHocReports.Format.XML)
                    Case Else : .GenerateReport(AdHocReports.Format.PDF)
                End Select
            End With
            oRpt = Nothing

            'With Response
            '.Redirect("../CRW/CRW_ReportOutput.aspx?filename=" + m_strFileName, True)
            'window.open ("../CRW/CRW_ReportOutput.aspx?filename=" + filename, "_report",""); 


            Return (m_strFileName)
        Catch ex As Exception
            Return "Bad Request found"
        End Try


        'End With
    End Function
    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        :	WritePage
        ' Purpose               :	Write The page
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Aniruddh Gujar
        ' Created               :	16-MAR-2018
        ' Revisions             :
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        Dim strColor As String = ""
        Dim strSQL As String = "usp_NG2_GetWeekDates "
        Dim drWeekDates As IDataReader
        drWeekDates = CommonFunctions.Data.GetDataReader(strSQL, True)

        strHTML.Append(PlotFilterSection())
        strHTML.Append("<div class='row' style='width:100%'>")
        strHTML.Append("<div class='col-md-2' style='margin-left: -15px;height: 383px;padding-top: 95.75px;' id='divweekdates'>")
        strHTML.Append("<div>")
        strHTML.Append("<table id='tblweekdates'class='table' style='width: auto;'>")
        strHTML.Append("<thead>")
        strHTML.Append(" <tr>")
        strHTML.Append("<th style='text-align:center'>")
        strHTML.Append("<i class='fa fa-angle-up' style='font-size: 25px; color: grey;cursor: pointer;text-align: center;' tabindex = 1 id='Prev' Title = 'Previous Week' data-toggle='tooltip'></i>")
        strHTML.Append("</th>")
        strHTML.Append(" </tr>")
        strHTML.Append("</thead>")
        strHTML.Append("<tbody id='weekdates' style='overflow-y: auto; display: inline-block;'>")
        While drWeekDates.Read()
            strHTML.Append(" <tr>")

            If (CommonFunctions.Data.CheckIsDBNull(drWeekDates("IsNonWorkingDay"), "") = "1") Then
                strColor = "red"
            Else
                strColor = "#337ab7"
            End If

            If (CommonFunctions.Data.CheckIsDBNull(drWeekDates("IsCurrentDay"), "") = "1") Then
                'dtDSCurrentDate = CommonFunctions.Dates.CGetDate(CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), ""))
                dtDSCurrentDate = CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "")
                'Commented And Added By Usha Pandit On 16.02.2021 For getting date in correct format
                'strHTML.Append("<td class='scrum_date selecteddate' style='border-top-color: transparent;' onclick=WeekDate_onclick('" & CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "") & "',this)><a href='#' style='color:" & strColor & "' onclick=WeekDate_onclick('" & CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "") & "',this)>" & CommonFunctions.Dates.CGetDate(CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "")) & "</a></td>")
                strHTML.Append("<td class='scrum_date selecteddate' style='border-top-color: transparent;' onclick=WeekDate_onclick('" & CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "") & "',this)><a href='#' style='color:" & strColor & "' onclick=WeekDate_onclick('" & CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "") & "',this)>" & CommonFunctions.Dates.CGetDate(CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "")) & "</a><input type ='hidden' id = 'hidSelectedate' value = '" & CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "") & "'></td>")
                'End Of Added By Usha Pandit On 16.02.2021 For getting date in correct format
            Else
                strHTML.Append("<td class='scrum_date'style='border-top-color: transparent;' onclick=WeekDate_onclick('" & CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "") & "',this)><a href='#' style='color:" & strColor & "' onclick=WeekDate_onclick('" & CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "") & "',this)>" & CommonFunctions.Dates.CGetDate(CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "")) & "</a></td>")

            End If

            strHTML.Append(" </tr>")
        End While
        strHTML.Append("</tbody>")
        strHTML.Append("<tfoot>")
        strHTML.Append(" <tr>")

        strHTML.Append("<th style='text-align:center'>")
        strHTML.Append("<i class='fa fa-angle-down' style='font-size: 25px; color: grey;cursor: pointer;' id='Next'  Title = 'Next Week' data-toggle='tooltip'></i>")
        strHTML.Append("</th>")
        strHTML.Append(" </tr>")
        strHTML.Append("</tfoot>")
        strHTML.Append("</table>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='col-md-10' style='margin-top: 25px;'>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-sm-12'>")
        strHTML.Append("<div id='DivList' style='overflow: hidden;width: 100%;'>")
        strHTML.Append(PlotGrid())
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        CommonFunctions.General.WriteHTML(strHTML.ToString)

    End Sub
    Protected Function PlotGrid(Optional strFromDate As String = "", Optional strWhereClause As String = "") As String
        '=====================================================================
        ' Procedure Name        :	PlotGrid
        ' Purpose               :	To plot grid
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Aniruddh Gujar
        ' Created               :	16-MAR-2018
        ' Revisions             :
        '=====================================================================

        Dim strGridHTML As New StringBuilder("")
        Dim strSQLQuery As String = ""
        Dim intNoOfDataColumn As Int16
        Dim strDivID As String = ""

        If m_objAccess.View = True Then
            Dim arrstrActualList() As String
            Dim arrstrUserFriendlyList() As String
            Dim arrWidthArray() As String
            intNoOfDataColumn = 7
            strDivID = "DivImpedimentLogList"
            strSQLQuery = "usp_NG2_sel_tbl_NG2_ImpedimentsLog " & HttpContext.Current.Session("IntProjectID") & ""
            If strFromDate <> "" Then
                strSQLQuery += ",'" + strFromDate + "'"
            End If
            If strWhereClause <> "" Then
                'If strFromDate <> "" Then
                '    strSQLQuery += ",'" + strWhereClause + "'"
                'Else
                strSQLQuery += ",NULL,'" + strWhereClause + "'"
                'End If

            End If
            arrstrActualList = {"ImpedimentNo", "Description", "RaisedDate", "CreatedByImage", "Edit", "Status", "AssignToName"}
            arrstrUserFriendlyList = {"", "", "", "", "", "", ""}

            arrWidthArray = {"align=Center", "align=left", "align=Center", "align=Center class = clsShow", "", "", "class = clsShow"}
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterImpedimentLogList  class=Listcount value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue
            With objGrid
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                '.CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto;margin-top: 10px!important;"
                .ColNameToolTipOnEachRow = True
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = True
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            objGrid = Nothing

        End If
        Return strGridHTML.ToString()




    End Function
    <System.Web.Services.WebMethod>
    Public Shared Function ShowHistoryDetails(ByVal ImpedimentID As String) As String
        '=====================================================================
        ' Procedure Name        : ShowHistoryDetails
        ' Purpose               : 
        ' Description           : To Plot ShowHistory Details
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created Date           :23rd Feb -2018
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objfrmImpedimentLog As New frmImpedimentLog()
            strGridHTML.Append(objfrmImpedimentLog.WriteHistoryGrid(ImpedimentID))
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    Private Function WriteHistoryGrid(ByVal ImpedimentID As String) As String
        '=====================================================================
        ' Procedure Name        : WriteHistoryGrid()	
        ' Purpose               : To Plot the Grids
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                :Yogesh Jalamkar
        ' Created               : 23-MAR-2018
        ' Revisions             : None
        '=====================================================================

        Dim strGridHTML As New StringBuilder("")
        Dim strSQLQuery As String = ""
        Dim intNoOfDataColumn As Int16
        Dim strDivID As String = ""
        Dim arrstrActualList() As String
        Dim arrstrUserFriendlyList() As String
        Dim arrstrLinkArray() As String
        Dim arrCheckBoxArray() As String
        Dim arrWidthArray() As String
        intNoOfDataColumn = 6
        strDivID = "DivGridShowHistory"
        strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumAuditTrail " & ImpedimentID & ",22236"
        arrstrActualList = {"FieldName", "OldValue", "NewValue", "ModifiedBy", "Date"}
        arrstrUserFriendlyList = {"Modified Field", "Old Value", "New Value", "Modified By", "Modified Date"}
        arrstrLinkArray = {"", "", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", "", ""}
        arrWidthArray = {"align=left", "align=center", "align=center", "align=left", "align=left", "align=left"}
        'Added By Dipali V On 24th March 2023 For Datatable Issue
        Dim dtListCount As New DataTable
        dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
        strGridHTML.Append("<input type=hidden id=FilterGridShowHistory value='" & dtListCount.Rows.Count & "'>")
        'End of Added By Dipali V On 24th March 2023 For Datatable Issue
        With objHistoryGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            ' .CheckBoxIDArray = arrCheckBoxArray
            .NoOfDataColumns = intNoOfDataColumn
            .RowLinkArray = arrstrLinkArray
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:auto"
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = (" ")
            .DIVID = strDivID
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            strGridHTML.Append(.DrawGrid())
        End With
        objHistoryGrid = Nothing
        'End If
        Return strGridHTML.ToString


    End Function
    Private Sub objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles objGrid.ColumnHeaderTR_BeforePrint

        'Cancel = True


    End Sub
    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        Dim strRiskID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("RiskID"), "")
        Dim strIssueID As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("IssueID"), "")
        If Args.DataField.ToUpper = "IMPEDIMENTNO" Then
            Cancel = True
            'Args.StringToBeInserted = "<td align='center' ><p Title = 'Serial No.' data-toggle='tooltip' data-placement='bottom' >" & Args.DataReader("ImpedimentNo") & "</p></TD>"

            If strRiskID = "" And strIssueID = "" Then
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Serial No.' data-toggle='tooltip' data-placement='right' >" & Args.DataReader("ImpedimentNo") & "</p></TD>"
            ElseIf strRiskID <> "" Then
                Args.StringToBeInserted = "<td align='center' ><div class='input-group'><p Title = 'Serial No.' data-toggle='tooltip' data-placement='right' >" & Args.DataReader("ImpedimentNo") & "</p><p style='color: #800000;font-size: 11px;font-weight: 749;font-family: helvetica !important;' Title = 'Risk ID' data-toggle='tooltip' data-placement='right'><i class='fa fa-exclamation-triangle'></i> " & " RID" & Args.DataReader("RiskID") & "</p></div></TD>"
            ElseIf strIssueID <> "" Then
                'Args.StringToBeInserted = "<td align='center' ><div class='input-group'><p Title = 'Serial No.' data-toggle='tooltip' data-placement='right' >" & Args.DataReader("ImpedimentNo") & "</p><p style='color: #800000;font-size: 11px;font-weight: 749;font-family: helvetica !important;' Title = 'Issue ID' data-toggle='tooltip' data-placement='right'> <i class='fa fa-bug'></i>" & " IID" & Args.DataReader("IssueID") & "</p></div></TD>"
                'Commented and Added by Usha PAndit on 01 June 2018 for Issue Id display
                'Args.StringToBeInserted = "<td align='center' ><div class='input-group'><p Title = 'Serial No.' data-toggle='tooltip' data-placement='right' >" & Args.DataReader("ImpedimentNo") & "</p><p style='color: #800000;font-size: 11px;font-weight: 749;font-family: helvetica !important;' Title = 'Issue ID' data-toggle='tooltip' data-placement='right'> <i class='fa fa-bug'></i>" & " ID" & Args.DataReader("IssueID") & "</p></div></TD>"
                Args.StringToBeInserted = "<td align='center' ><div class='input-group'><p Title = 'Serial No.' data-toggle='tooltip' data-placement='right' >" & Args.DataReader("ImpedimentNo") & "</p><p style='color: #800000;font-size: 11px;font-weight: 749;font-family: helvetica !important;' Title = 'Issue ID' data-toggle='tooltip' data-placement='right'> <i class='fa fa-bug'></i>" & Args.DataReader("IssueID") & "</p></div></TD>"
                'End of Added by Usha PAndit on 01 June 2018 for Issue Id display
            End If

        End If

        If Args.DataField.ToUpper = "RAISEDDATE" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center' ><p Title = 'Posted Date' data-toggle='tooltip' data-placement='bottom' style = 'color:#3091e4;'>" & CommonFunctions.Dates.CGetDate(Args.DataReader("RaisedDate")) & "</p></TD>"
        End If
        If Args.DataField.ToUpper = "DESCRIPTION" Then
            Cancel = True
            Dim strDescription As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("Description"), "")



            'If strDescription.Contains("'") Then
            '    strDescription = strDescription.Replace("'", "''")
            'End If

            Dim strLessDescription As String = ""
            Dim strRemainingDescription As String = ""

            If strDescription.Length > 200 Then
                strLessDescription = strDescription.Substring(0, 100)
                strRemainingDescription = strDescription.Substring(101, strDescription.Length - 101)
            End If

            If strDescription.Length > 200 Then
                If strDescription.Contains("'") Then
                    Args.StringToBeInserted = "<td align='left' ><p class='tt_large' Title = """ + strDescription + """ data-toggle='tooltip' data-placement='right' style='word-break: break-all;width: 250px;'>" & strLessDescription & "..</p></TD>"
                Else
                    Args.StringToBeInserted = "<td align='left' ><p class='tt_large' Title = '" + strDescription + "' data-toggle='tooltip' data-placement='right' style='word-break: break-all;width: 250px;'>" & strLessDescription & "..</p></TD>"
                End If
            Else
                'Added by Usha Pandit on 18 Apr 2018 for showing tooltip right aligned as data grid gets flicker due to tooltip
                'Args.StringToBeInserted = "<td align='left' ><p Title = 'Action Item/Description' data-toggle='tooltip' data-placement='right'>" & strDescription & "</p></TD>"
                If strDescription.Contains("'") Then
                    Args.StringToBeInserted = "<td align='left' ><p Title = """ + strDescription + """ data-toggle='tooltip' data-placement='right' style='word-break: break-all;width: 250px;'>" & strDescription & "</p></TD>"
                Else
                    Args.StringToBeInserted = "<td align='left' ><p Title = '" + strDescription + "' data-toggle='tooltip' data-placement='right' style='word-break: break-all;width: 250px;'>" & strDescription & "</p></TD>"
                End If
            End If
        End If

        If Args.DataField.ToUpper = "CREATEDBYIMAGE" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center' >"
            Args.StringToBeInserted += "<span class='chat-img float-start'>"
            Dim strAssignedToName As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("AssignToName"), "")
            If strAssignedToName = "" Then
                Args.StringToBeInserted += "<img Title = 'Not Assigned' data-toggle='tooltip' data-placement='bottom' src='../../Images/Photo/no-photo.png' alt='User Avatar' class='img-circle' style='height:30px;width:30px;' />"
            Else
                Args.StringToBeInserted += "<img Title = 'Assigned To : " + Args.DataReader("AssignToName") + "' data-toggle='tooltip' data-placement='bottom' alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px;width:30px;' src='../../Images/Photo/" & Args.DataReader("AssignToImage") & "' />"
            End If

            Args.StringToBeInserted += "</span> </TD>"
        End If
        If Args.DataField.ToUpper = "AssignToName" Then
            Cancel = True
            'Args.StringToBeInserted = "<td align='left' style='display:none;'><p Title = 'Action Item/Description' data-toggle='tooltip' data-placement='bottom'>" & CommonFunction.Data.CheckIsDBNull(Args.DataReader("AssignToName"), "") & "</p></TD>"

        End If


        If Args.DataField.ToUpper = "STATUS" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center'> <button type='button'  class='btn ' style='width: 80px; font-size: 12px; height: 25px; padding-top: 3px; color:white; background-color: " & Args.DataReader("StatusColor") & ";border-radius: 0px;' data-toggle='tooltip' data-placement='bottom' title='Impediment Status'>" & Args.DataReader("Status") & "</button></td>"
        End If
        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True
            'Added by Usha Pandit on 18 Apr 2018 for showing tooltip left aligned as data grid gets flicker due to tooltip
            Args.StringToBeInserted = "<td><div class='btn-group dropdown' style='float: right; padding: 8px;'>"

            'added by ashwini on 21-3-2023 for data-bs-toggle
            Args.StringToBeInserted += "<i class='fa fa-ellipsis-h mydetaildropdown'  data-placement='left' title='Detail' data-bs-toggle='dropdown' style='font-size:18px!important;color:black!important;cursor: pointer;' id='detailDropdown'></i>"
            'End Of added by ashwini On 21-3-2023 for data-bs-toggle

            Args.StringToBeInserted += "<ul class='dropdown-menu' role='menu' style='width: 160px;top: 50%;'>"
            Dim AccessEditFlag As String
            Dim AccessAddFlag As String
            If m_objAccess.Edit = True Then
                AccessEditFlag = "True"
            Else
                AccessEditFlag = "False"
            End If
            If m_objAccess.Add = True Then
                AccessAddFlag = "True"
            Else
                AccessAddFlag = "False"
            End If
            Args.StringToBeInserted += "<li onclick=ShowModal('divAddDS',this,'" & CommonFunction.Data.CheckIsDBNull(Args.DataReader("ImpedimentID"), "") & "','','" & Args.DataReader("Status") & "','','" & AccessEditFlag & "','" & AccessAddFlag & "')>View Details</li>"

            Dim strDescription As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("Description"), "")

            If strDescription.Contains(vbLf) Then
                strDescription = strDescription.Replace(vbLf, "\n")
            End If
            If strDescription.Contains("'") Then
                strDescription = strDescription.Replace("'", "**")
            End If

            If strDescription.Contains("""") Then
                strDescription = strDescription.Replace("""", "")
            End If

            If strRiskID = "" And strIssueID = "" And CommonFunction.Data.CheckIsDBNull(Args.DataReader("Status"), "") = "Open" Then
                If m_objAccess.Add = True And m_objIsProjectResource = "1" Then
                    Dim strCorrectiveAction As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("CorrectiveAction"), "")
                    Dim strPreventiveAction As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("PreventiveAction"), "")
                    Dim strFlag As String = ""
                    If strCorrectiveAction = "" And strPreventiveAction = "" Then
                        strFlag = "True"
                    Else
                        strFlag = "False"
                    End If
                    Args.StringToBeInserted += "<li onclick=""ShowModal('divAddIssue',this,'" & CommonFunction.Data.CheckIsDBNull(Args.DataReader("ImpedimentID"), "") & "','" & strDescription & "','','" + strFlag + "','" & AccessEditFlag & "','" & AccessAddFlag & "')"">Convert to Issue</li>"
                    Args.StringToBeInserted += "<li onclick=""ShowModal('divAddRisk',this,'" & CommonFunction.Data.CheckIsDBNull(Args.DataReader("ImpedimentID"), "") & "','" & strDescription & "','','" + strFlag + "','" & AccessEditFlag & "')"">Convert to Risk</li>"
                End If
            End If
            Args.StringToBeInserted += "<li onclick=ShowHistory('" & CommonFunction.Data.CheckIsDBNull(Args.DataReader("ImpedimentID"), "") & "')>Show History</li>"

            Args.StringToBeInserted += "</ul>"
            Args.StringToBeInserted += "</div>"
            Args.StringToBeInserted += "</td>"
        End If

    End Sub
    Private Sub objHistoryGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objHistoryGrid.DataRowTD_BeforePrint
        Dim blnDelayedStatus As Boolean = False
        Dim blnBlankData As Boolean = False
        Dim strOldValue As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("OldValue"), "")
        Dim strNewValue As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("NewValue"), "")
        Dim strFieldName As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("FieldName"), "")
        'Dim DateFormat As String = getOutputDateFormat()
        Dim strLessCommentOldValue As String = ""
        Dim strRemainingOldValue As String = ""
        Dim strLessCommentNewValue As String = ""
        Dim strRemainingNewValue As String = ""
        'If strOldValue.Contains("'") Then
        '    strOldValue = strOldValue.Replace("'", "''")
        'End If
        'If strNewValue.Contains("'") Then
        '    strNewValue = strNewValue.Replace("'", "''")
        'End If
        If strOldValue.Length > 200 Then
            strLessCommentOldValue = strOldValue.Substring(0, 100)
            strRemainingOldValue = strOldValue.Substring(101, strOldValue.Length - 101)
        End If
        If strNewValue.Length > 200 Then
            strLessCommentNewValue = strNewValue.Substring(0, 100)
            strRemainingNewValue = strNewValue.Substring(101, strNewValue.Length - 101)
        End If

        If strOldValue = "" And strNewValue = "" Then
            blnBlankData = True
        End If
        If strOldValue = "Delayed" Then
            blnDelayedStatus = True
        End If


        If Args.DataField.ToUpper = "DATE" Then
            Cancel = True
            If blnDelayedStatus = False And blnBlankData = False Then
                If CommonFunctions.General.CheckIsNothing(Args.DataReader("DATE"), "") <> "" Then
                    Args.StringToBeInserted = "<td align='center' nowrap ><p Title = 'Modified Date' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Dates.GetDate(Args.DataReader("DATE")) & "</p></TD>"
                Else
                    Args.StringToBeInserted = "<td align='center' ><p Title = 'Modified Date' data-toggle='tooltip' data-placement='bottom'></p></TD>"
                End If

            End If
        End If



        If Args.DataField.ToUpper = "OLDVALUE" Then
            Cancel = True


            If blnDelayedStatus = False And blnBlankData = False Then

                If (CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FIELDNAME"), "").ToString.ToUpper = "TARGET DATE") Then
                    If (CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OldValue"), "").ToString <> "") Then
                        Args.StringToBeInserted = "<td align='center' ><p Title = 'Old Value' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Dates.GetDate(Args.DataReader("OldValue")) & "</p></TD>"
                    Else
                        Args.StringToBeInserted = "<td align='center' ><p Title = 'Old Value' data-toggle='tooltip' data-placement='bottom'></p></TD>"
                    End If
                Else
                    Args.StringToBeInserted = "<td align='center' ><p Title = 'Old Value' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OldValue"), "") & "</p></TD>"
                End If

            End If

        End If
        If Args.DataField.ToUpper = "NEWVALUE" Then
            Cancel = True
            If blnDelayedStatus = False And blnBlankData = False Then
                If (CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FIELDNAME"), "").ToString.ToUpper = "TARGET DATE") Then
                    If (CommonFunctions.Data.CheckIsDBNull(Args.DataReader("NEWVALUE"), "").ToString <> "") Then
                        Args.StringToBeInserted = "<td align='center' ><p Title = 'New Value' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Dates.GetDate(Args.DataReader("NEWVALUE")) & "</p></TD>"
                    Else
                        Args.StringToBeInserted = "<td align='center' ><p Title = 'New Value' data-toggle='tooltip' data-placement='bottom'></p></TD>"
                    End If
                Else
                    Args.StringToBeInserted = "<td align='center' ><p Title = 'New Value' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("NEWVALUE"), "") & "</p></TD>"
                End If
            End If
        End If
        If Args.DataField.ToUpper = "MODIFIEDBY" Then
            Cancel = True
            If blnDelayedStatus = False And blnBlankData = False Then
                Args.StringToBeInserted = "<td align='left' ><p Title = 'Modified By' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MODIFIEDBY"), "") & "</p></TD>"
            End If
        End If

        If Args.DataField.ToUpper = "FIELDNAME" Then
            Cancel = True

            If blnDelayedStatus = False And blnBlankData = False Then
                Args.StringToBeInserted = "<td align='center'><p Title = 'Field Name' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FIELDNAME"), "") & "</p></TD>"
            End If
        End If



        If strFieldName = "Planned Issue Closure Date" Then

            'If Not strOldValue = "" Then

            '    Dim formatOldValue As String = DateTime.Parse(strOldValue).ToString(DateFormat)
            '    strOldValue = formatOldValue
            'End If
            'If Not strNewValue = "" Then
            '    Dim formatNewValue As String = DateTime.Parse(strNewValue).ToString(DateFormat)
            '    strNewValue = formatNewValue
            'End If
            If Args.DataField.ToUpper = "OLDVALUE" Then
                Cancel = True

                'Args.StringToBeInserted = "<td valign='top' align='left' title='Old Value'>" & strOldValue & "</td>"
                If strOldValue = "" Then
                    Args.StringToBeInserted = "<td valign='top' align='center'><p data-toggle='tooltip' data-placement='top' title='Old Value'>" & strOldValue & "</p></td>"
                Else
                    Args.StringToBeInserted = "<td valign='top' align='center'><p data-toggle='tooltip' data-placement='top' title='Old Value'>" & CommonFunctions.Dates.CGetDate(strOldValue) & "</p></td>"
                End If

            End If
            If Args.DataField.ToUpper = "NEWVALUE" Then
                Cancel = True
                'Args.StringToBeInserted = "<td valign='top' align='left' title='New Value'><p>" & strNewValue & "</td>"
                If strNewValue = "" Then
                    Args.StringToBeInserted = "<td valign='top' align='center'><p data-toggle='tooltip' data-placement='top' title='New Value'>" & strNewValue & "</p></td>"
                Else
                    Args.StringToBeInserted = "<td valign='top' align='center'><p data-toggle='tooltip' data-placement='top' title='New Value'>" & CommonFunctions.Dates.CGetDate(strNewValue) & "</p></td>"
                End If

            End If


        ElseIf strFieldName = "Description" Or strFieldName = "Corrective Action" Or strFieldName = "Preventive Action" Then
            If Args.DataField.ToUpper = "OLDVALUE" Then
                Cancel = True
                'Args.StringToBeInserted = "<td valign='top' align='left' title='Old Value'>" & strOldValue & "</td>"
                If blnBlankData = False Then
                    If strOldValue.Length > 200 Then
                        If strOldValue.Contains("'") Then
                            Args.StringToBeInserted = "<td valign='top' align='center'><p class='tt_large' data-toggle='tooltip' data-placement='right' style='word-break: break-all;width: 250px;' title=""" & strOldValue & """>" & strLessCommentOldValue & "..</p></td>"
                        Else
                            Args.StringToBeInserted = "<td valign='top' align='center'><p class='tt_large' data-toggle='tooltip' data-placement='right' style='word-break: break-all;width: 250px;' title='" & strOldValue & "'>" & strLessCommentOldValue & "..</p></td>"
                        End If
                    Else
                        If strOldValue.Contains("'") Then
                            Args.StringToBeInserted = "<td valign='top' align='center'><p data-toggle='tooltip' data-placement='right' style='word-break: break-all;width: 250px;' title=""" & strOldValue & """>" & strOldValue & "</p></td>"
                        Else
                            Args.StringToBeInserted = "<td valign='top' align='center'><p data-toggle='tooltip' data-placement='right' style='word-break: break-all;width: 250px;' title='" & strOldValue & "'>" & strOldValue & "</p></td>"
                        End If
                    End If
                End If
            End If
            If Args.DataField.ToUpper = "NEWVALUE" Then
                Cancel = True
                If blnBlankData = False Then
                    If strNewValue.Length > 200 Then
                        If strNewValue.Contains("'") Then
                            Args.StringToBeInserted = "<td valign='top' align='center'><p class='tt_large' data-toggle='tooltip' data-placement='left' style='word-break: break-all;width: 250px;' title=""" & strNewValue & """>" & strLessCommentNewValue & "..</p></td>"
                        Else
                            Args.StringToBeInserted = "<td valign='top' align='center'><p class='tt_large' data-toggle='tooltip' data-placement='left' style='word-break: break-all;width: 250px;' title='" & strNewValue & "'>" & strLessCommentNewValue & "..</p></td>"
                        End If
                    Else
                        If strNewValue.Contains("'") Then
                            Args.StringToBeInserted = "<td valign='top' align='center'><p data-toggle='tooltip' data-placement='left' style='word-break: break-all;width: 250px;' title=""" & strNewValue & """>" & strNewValue & "</p></td>"
                        Else
                            Args.StringToBeInserted = "<td valign='top' align='center'><p data-toggle='tooltip' data-placement='left' style='word-break: break-all;width: 250px;' title='" & strNewValue & "'>" & strNewValue & "</p></td>"
                        End If
                    End If
                End If
                'Args.StringToBeInserted = "<td valign='top' align='left' title='New Value'>" & strNewValue & "</td>"
            End If
        End If

    End Sub
    Protected Function PlotFilterSection() As String
        '=====================================================================
        ' Procedure Name        :	PlotStatusFilter
        ' Purpose               :	PlotStatusFilter
        ' Description           :	Plot a status for filter
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Aniruddh Gujar
        ' Created               :	16th-March-2018
        ' Revisions             :
        '=====================================================================

        Dim strHTML As New StringBuilder()
        Dim strSQL As String = ""
        Dim drStatus As IDataReader
        Dim strSprintName As String = ""
        drStatus = CommonFunctions.Data.GetDataReader("usp_NG2_GetStatusForDSM 'Impediment'", True)
        'Dim drSprints As IDataReader
        'drSprints = CommonFunctions.Data.GetDataReader("usp_NG2_Sel_Sprints_ForDailyScrum " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID") & ",1", "0"), True)

        Dim SQLSprints As String
        SQLSprints = "usp_NG2_Sel_Sprints_ForDailyScrum NULL," & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",1,0"
        strHTML.Append("<div class='col-sm-12 HeaderFreeze fixed-top' style='width:100%'>")
        strHTML.Append("<div class='col-sm-4 clsDivHeader' style='color: #888888b8; font-weight: 500; font-size: 15px;margin-top: 0px!important;margin-left: 38px;'>Impediment Log</div>")
        strHTML.Append("<div class='col-sm-8 rightdiv' style='float: right;'>")
        strHTML.Append(" <div class='btn-group dropdown' id='divHeaderLeftSection' style='float: right;'>")
        If m_objAccess.View = True Then
            strHTML.Append("<div class='btn-group dropdown' id='divfilterDropdown' style='float: right; padding: 8px;'>")
            'strHTML.Append("<div id ='divFilterTooltip' class = 'clsShowHide' data-toggle='tooltip' data-placement='bottom' title='Filter'>")
            'added by ashwini on 21-3-2023 for data-bs-toggle
            strHTML.Append("<i class='fa fa-filter my-dropdown' data-placement='bottom' title='Filter' data-bs-toggle='dropdown' id='filterDropdown' style='cursor: pointer;'></i>")
            'End Of added by ashwini On 21-3-2023 for data-bs-toggle
            strHTML.Append("<ul id='UlFilter' class='dropdown-menu' style='width: 160px;'>")
            strHTML.Append("<li>")
            strHTML.Append("<i class='fa fa-plus-circle' onclick=ShowStatus(this,'divStatus')></i><span> By Status</span>")
            strHTML.Append("<div id='divStatus' class='clsFilterDiv' style='display:none'>")
            strHTML.Append("<ul class=''>")
            While drStatus.Read()
                strHTML.Append("<li class='' onclick=ShowFilter('" & CommonFunctions.Data.CheckIsDBNull(drStatus("Status"), "") & "','Status')>- " & CommonFunctions.Data.CheckIsDBNull(drStatus("Status"), "") & "</li>")
            End While
            strHTML.Append("<li class='' onclick=ShowFilter('Delayed','Status')>- Delayed</li>")
            strHTML.Append("<li class='' onclick=ShowFilter('Info','Status')>- Info</li>")

            strHTML.Append("</ul>")
            'strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</li>")

            strHTML.Append("<li>")


            strHTML.Append("<i class='fa fa-plus-circle' onclick=ShowStatus(this,'divSprints')></i><span> By Sprints</span>")
            strHTML.Append("<div id='divSprints' class='clsFilterDiv' style='display:none'>")
            strHTML.Append("<div class='form-group row clsScrollHide' style='margin-top:10px'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("DSFilterSprint", SQLSprints, , , "class='form-control' style='width:70%;margin-left: 45px;' onchange=ShowFilter('','Sprints')", True, True))
            strHTML.Append("</div>")


            'strHTML.Append("<ul class=''>")
            'While drSprints.Read()
            '    strSprintName = CommonFunctions.Data.CheckIsDBNull(drSprints("IterationName"), "")
            '    If (strSprintName.Length > 20) Then
            '        strSprintName = strSprintName.Substring(0, 20)
            '    End If

            '    strHTML.Append("<li class='' data-toggle='tooltip' title='" & CommonFunctions.Data.CheckIsDBNull(drSprints("IterationName"), "") & "' onclick=ShowFilter('" & CommonFunctions.Data.CheckIsDBNull(drSprints("IterationID"), "") & "','Sprints')>- " & strSprintName & "</li>")
            'End While
            'strHTML.Append("</ul>")
            strHTML.Append("</div>")
            strHTML.Append("</li>")

            strHTML.Append("<li>")
            strHTML.Append("<i class='fa fa-plus-circle' onclick=ShowStatus(this,'divDailyStandUp')></i><span> Converted from Daily Stand Up meeting.</span>")

            strHTML.Append("<div id='divDailyStandUp' class='clsFilterDiv' style='display:none'>")
            strHTML.Append("<ul class=''>")
            strHTML.Append(" <li class='' onclick=""ShowFilter('IS NOT NULL','DSM')"">- Converted</li>")
            strHTML.Append("<li class='' onclick=""ShowFilter('IS NULL','DSM')"">- Not Converted</li>")
            strHTML.Append("</ul>")
            strHTML.Append("</div>")

            strHTML.Append("</li>")

            strHTML.Append("</ul>")

            strHTML.Append("<div class='btn-group' id='DivfilterClear'  style='padding-left: 8px;float: right;'>")
            strHTML.Append("<i class='fa fa-filter' data-bs-toggle='tooltip'  data-bs-placement='bottom' title='Clear Filter' id='filterClear' onclick=ClearFilter(this)><i class='fa fa-remove'></i></i>")
            strHTML.Append("</div>")

            strHTML.Append("</div>")


            'Added by swapna
            strHTML.Append("<div class='btn-group dropdown' id='divfilterExport'  style='float: right; padding-left: 10px;'>")
            'added by ashwini on 21-3-2023 for data-bs-toggle
            strHTML.Append("<button data-bs-toggle='dropdown' class='btn btn-info' id='filterExport' style='border-radius: 1px;'>Export <i class='fa fa-download'></i> </button>") 'Added by Swapna
            strHTML.Append("<button type='button' class='btn btn-info dropdown-toggle dropdown-toggle-split ' data-bs-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>")
            'End Of added by ashwini On 21-3-2023 for data-bs-toggle
            strHTML.Append("<i class='fa fa-sort-down'></i>")
            strHTML.Append("</button>")

            strHTML.Append("<ul  id='ExcelFilter' class='dropdown-menu'>")

            strHTML.Append("<li class='dropdown-item' onclick=Excel_OnClick('Excel')>Excel</li>")
            strHTML.Append("<li class='dropdown-item' onclick=Excel_OnClick('PDF')>PDF</li>")
            strHTML.Append("</ul>")
            strHTML.Append("</div>")
        End If
        If m_objAccess.Add = True And m_objIsProjectResource = "1" Then

            strHTML.Append("<div class='btn-group dropdown' style='float: right'>")
            If m_objAccess.Add = True Then
                strHTML.Append("<button type='button' class='btn btn-info' style='border-radius: 1px;'>Create</button>")
            Else
                strHTML.Append("<button type='button' class='btn btn-info' disabled>Create</button>")
            End If
            'added by ashwini on 21-3-2023 for data-bs-toggle
            strHTML.Append("<button type='button' class='btn btn-info dropdown-toggle dropdown-toggle-split' data-bs-toggle='dropdown' aria-haspopup='true' aria-expanded='false'><i class='fa fa-sort-down'></i></button>")
            'End Of added by ashwini On 21-3-2023 for data-bs-toggle
            strHTML.Append("<ul class='dropdown-menu'>")

            strHTML.Append("<li class='dropdown-item' onclick=ShowModal('divAddImpediment',this,'')>Create Impediment</li>")
            strHTML.Append("<li class='dropdown-item' onclick=ShowModal('divAddIssue',this,'')>Create Issue</li>")
            strHTML.Append("<li class='dropdown-item' onclick=ShowModal('divAddRisk',this,'')>Create Risk</li>")
            strHTML.Append("</ul>")

            strHTML.Append("</div>")
        End If

        If m_objAccess.View = True Then
            'Dim strBrowser As String = Request.Browser.Browser.ToString()''uncomment
            'If strBrowser = "Firefox" Then''uncomment






            'strHTML.Append("<div class='input-group input-group-sm' style='width: 300px; right: 20px !important; float: right'>")
            'strHTML.Append("<div class='input-group-btn'>")
            'strHTML.Append("<button type='button' class='btn btn-default' onclick='PerformSearchForPTI()'><i class='fa fa-search'></i></button>")
            'strHTML.Append("</div>")

            'strHTML.Append("<div class='form-group has-feedback has-clear'>")
            'strHTML.Append("<input type='search' name='table_search' id='txtSearchDailyScrum' class='txtBox form-control float-end searchboxHeight' value='' onkeyup='PerformSearchForPTI()' placeholder='Search'>")
            'strHTML.Append("<span class='form-control-clear fa fa-close form-control-feedback' style='margin-top: 5px;top: 0%'></span>")
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")


            'Else  ''uncomment
            'strHTML.Append("<div class='input-group input-group-sm' style='width: 300px; right: 20px !important; float: right'>")
            'strHTML.Append("<div class='input-group-btn'>")
            'strHTML.Append("<button type='button' class='btn btn-default' onclick='PerformSearchForPTI()'><i class='fa fa-search'></i></button>")
            'strHTML.Append("</div>")

            'strHTML.Append("<input type='search' name='table_search' id='txtSearchDailyScrum' class='txtBox form-control float-end searchboxHeight' value='' onkeyup='PerformSearchForPTI()' placeholder='Search'>")

            'strHTML.Append("</div>")

            strHTML.Append("<div class='input-group' style='width: 200px;margin-top: 2px;'>")
            strHTML.Append("<div class='input-group-btn'>")
            strHTML.Append("<input type='search' name='table_search' id='txtSearchDailyScrum' class='txtBox form-control float-end' value='' onkeyup='PerformSearchForPTI()' placeholder='Search' style='border-top: none!important; border-left: none!important;border-right: none!important;height:32px'>")
            strHTML.Append(" </div>")
            strHTML.Append("<i class='fa fa-search' style='border-bottom-color: none;margin-left: 10px;/* z-index: 99; */margin-top: 10px;'></i>")
            strHTML.Append("</div>")
            'End If''uncomment
        End If


        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function
    Public Function getDefaultResponsiblePerson() As String
        '=====================================================================
        ' Procedure  Name		:	getDefaultResponsiblePerson
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	get Default Responsible Person for selected project
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   10 APR 2018
        '=====================================================================

        Dim strSQL As String = ""
        Dim strResult As String
        Dim index As Integer = 0



        strSQL = "exec usp_sel_tbl_ib_TypeResponsiblePerson  " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ""
        strResult = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "0")

        Return strResult

    End Function
    'Public Function getOutputDateFormat() As String
    '    '=====================================================================
    '    ' Procedure  Name		:	getOutputDateFormat
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:	get OutputDateFormat from Company Information
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Usha Pandit
    '    ' Created				:   11 APR 2018
    '    '=====================================================================

    '    Dim strSQL As String = ""
    '    Dim strResult As String
    '    Dim index As Integer = 0

    '    Try

    '        strSQL = "exec usp_NG2_sel_tbl_PM_CompanyInformation_OutputFormat  "
    '        strResult = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "0")

    '        Return strResult
    '    Catch ex As Exception
    '        Return ""
    '    End Try
    'End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function AddDailyScrumModal(ImpedimentId As String)
        '=====================================================================
        ' Procedure Name        :	AddDailyScrumModal
        ' Purpose               :	AddDailyScrumModal
        ' Description           :	Open DS
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	YOgesh Jalamkar
        ' Created               :	16th-March-2018
        ' Revisions             :
        '=====================================================================
        Try
            Dim objfrmReleasePlanning As New frmImpedimentLog
            Dim objfrmImpedimentLog As New frmImpedimentLog()
            Dim strHTML As New StringBuilder()
            Dim strSQL As String = ""
            strHTML.Append("<div class='' id='container_impediment'>")
            strHTML.Append("<form id='frmImpedimentDailyModal'>")

            strSQL = "usp_NG2_GetDailyImpedimentDetails " & ImpedimentId
            Dim strActionItems As String = ""
            Dim strTargetDate As String = ""
            Dim strSprint As String = ""
            Dim strAssignedTo As String = ""
            Dim strStatus As String = ""
            Dim strSeverity As String = ""
            Dim strPriority As String = ""
            Dim strCorrectiveAction As String = ""
            Dim strPreventiveAction As String = ""
            Dim strActualCompletionDate As String = ""
            Dim strRemark As String = ""
            Dim strConvertToIssue As String = ""
            Dim strConvertToRisk As String = ""
            Dim strclass As String = ""
            Dim drDSDetails As IDataReader
            If (ImpedimentId <> "") Then


                drDSDetails = CommonFunction.Data.GetDataReader(strSQL, True)
                If drDSDetails.Read Then

                    strActionItems = CommonFunction.Data.CheckIsDBNull(drDSDetails("Description"), "")
                    If TypeOf (drDSDetails("PlannedClosureDate")) Is DateTime Then
                        strTargetDate = CommonFunctions.Dates.GetDate(CommonFunction.Data.CheckIsDBNull(drDSDetails("PlannedClosureDate"), ""))
                    Else
                        strTargetDate = ""
                    End If


                    strSprint = CommonFunction.Data.CheckIsDBNull(drDSDetails("IterationID"), "")
                    'strAssignedTo = CommonFunction.Data.CheckIsDBNull(drDSDetails("AssignToName"), "")
                    strStatus = CommonFunction.Data.CheckIsDBNull(drDSDetails("Status"), "")
                    strActualCompletionDate = CommonFunction.Data.CheckIsDBNull(drDSDetails("ActualClosureDate"), "")
                    strSeverity = CommonFunction.Data.CheckIsDBNull(drDSDetails("Severity"), "")
                    strPriority = CommonFunction.Data.CheckIsDBNull(drDSDetails("Priority"), "")
                    strCorrectiveAction = CommonFunction.Data.CheckIsDBNull(drDSDetails("CorrectiveAction"), "")
                    strPreventiveAction = CommonFunction.Data.CheckIsDBNull(drDSDetails("PreventiveAction"), "")
                    If (strActualCompletionDate <> "") Then
                        strActualCompletionDate = CommonFunctions.Dates.GetDate(strActualCompletionDate)
                    End If

                    'strRemark = CommonFunction.Data.CheckIsDBNull(drDSDetails("Remark"), "")
                    strConvertToIssue = CommonFunction.Data.CheckIsDBNull(drDSDetails("IsConvertedToIssue"), "")
                    strConvertToRisk = CommonFunction.Data.CheckIsDBNull(drDSDetails("IsConvertedToRisk"), "")

                End If
            End If
            'If strTargetDate = "01-Jan-1900" Then
            '    strTargetDate = ""
            'End If
            If (strStatus.ToUpper = "CLOSED") Then
                strclass = "disabled"
            End If




            ''''''''''''''''''''''''
            strHTML.Append("<div class='row form-group'>")
            strHTML.Append("<label class='col-sm-3 col-form-label'>Select Sprint*</label>")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")

            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSprint", "usp_NG2_Sel_tbl_PM_ScrumIteration_Open_Sprints " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), , strSprint, " onchange=""GetSelectedSprint(this)"" class='form-control' style='width:200px;height:32px;' ", False, True))
            strHTML.Append(" </div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            ''''''''''''''''''''''''



            strHTML.Append("<div class='form-group row'>")
            strHTML.Append(" <label id='lblDescription'  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom' title='Action Items' style='margin-top:21px;'> Action Items/Description* </label> ")
            strHTML.Append("<div class='col-sm-9'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtImpedimentDescription", "txtImpedimentDescription", , "form-control", , , , , , 40, 500, , , " margin-left: 45px;overflow:hidden;margin-top:21px;", , , , , "data-autoresize", True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtActionItems", "txtActionItems", , "form-control", , , , , , , 500, strActionItems, , "overflow:hidden;", , , , , "data-autoresize " & strclass, True, EnableHTMLEncode:=True))
            strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;margin-top:-25px;float:right;margin-right:-31px;' id='ActionItems'></p>")
            strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-1'>")

            'strHTML.Append("</div>")
            strHTML.Append("</div>")





            'strHTML.Append("<div class='form-group row'>")
            'strHTML.Append(" <label class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom'> Action Items/Description* </label> ")
            'strHTML.Append("<div class='col-sm-9'>")


            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtActionItems", "txtActionItems", , "form-control", , , , , , , 500, strActionItems, , " margin-left: 45px;overflow:hidden;width: 80%;", True, , , , "data-autoresize" & strclass, True, EnableHTMLEncode:=True))

            'strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;margin-top:-25px;float:right;margin-right:-31px;' id='ActionItems'></p>")
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")

            Dim projectid As String = HttpContext.Current.Session("intProjectID")

            '''''''''''''''''''''''''''''''''''''''''
            'strHTML.Append("<div class='form-group row'>")
            'strHTML.Append(" <label  class='col-sm-1 col-form-label' data-toggle='tooltip' data-placement='bottom' title='Sprint' > Sprint </label> ")
            'strHTML.Append("<div class='col-md-3'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("DSSprint", "usp_NG2_Sel_Sprints_ForDailyImpediment " & ImpedimentId & "," & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",null,0", , strSprint, "class='form-control' style='width:66%;margin-left: 45px;'disabled ", , True))
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")

            ''''''''''''''''''''''''''''''''''''''''''''''''''     


            strHTML.Append("<div class='form-group row'>")

            strHTML.Append(" <label  class='col-sm-3 col-form-label clsIsMandetory' data-toggle='tooltip' data-placement='bottom' > Priority </label> ")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentPriority", "usp_NG2_Sel_tbl_IB_PrioritiesDetails", , strPriority, "class='form-control' style='margin-left: 45px;width:200px;height:34px;' ", True, True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentPriority", "usp_NG2_Sel_tbl_IB_PrioritiesDetails", , strPriority, "class='form-control' style='width:200px;height:34px;' ", True, True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append(" <label  class='col-sm-3 col-form-label clsIsMandetory' data-toggle='tooltip' data-placement='bottom' > Severity </label> ")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentSeverity", "usp_NG2_Sel_tbl_IB_SeverityDetails", , strSeverity, "class='form-control' style='margin-left: 45px;width:200px;height:34px;' ", True, True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentSeverity", "usp_NG2_Sel_tbl_IB_SeverityDetails", , strSeverity, "class='form-control' style='width:200px;height:34px;' ", True, True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-1'>")
            'strHTML.Append("</div>")


            strHTML.Append("</div>")

            ''''''''''''''''''''''''

            strHTML.Append("<div class='form-group row'>")
            strHTML.Append(" <label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom' style='margin-top:21px;'> Corrective Action </label> ")
            strHTML.Append("<div class='col-sm-9'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtImpedimentDescription", "txtImpedimentDescription", , "form-control", , , , , , 40, 500, , , " margin-left: 45px;overflow:hidden;margin-top:21px;", , , , , "data-autoresize", True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtCorrectiveAction", "txtCorrectiveAction", , "form-control", , , , , , , 1000, strCorrectiveAction, , "overflow:hidden;", , , , , "data-autoresize " & strclass, True, EnableHTMLEncode:=True))
            strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;margin-top:-25px;float:right;margin-right:-31px;' id='CorrectiveAction'></p>")
            strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-1'>")

            'strHTML.Append("</div>")
            strHTML.Append("</div>")



            'strHTML.Append("<div class='form-group row'>")
            'strHTML.Append(" <label  class='col-sm-2 col-form-label' data-toggle='tooltip' data-placement='bottom'  > Corrective Action </label> ")
            'strHTML.Append("<div class='col-sm-10'>")

            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtCorrectiveAction", "txtCorrectiveAction", , "form-control", , , , , , , 1000, strCorrectiveAction, , "overflow:hidden;", , , , , "data-autoresize", True, EnableHTMLEncode:=True))

            'strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;margin-top:-25px;float:right;margin-right:-31px;' id='CorrectiveAction'></p>")
            'strHTML.Append("</div>")

            'strHTML.Append("</div>")

            '''''''''''''
            strHTML.Append("<div class='form-group row'>")
            strHTML.Append(" <label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom' style='' > Preventive Action </label> ")
            strHTML.Append("<div class='col-sm-9'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtPreventiveAction", "txtPreventiveAction", , "form-control", , , , , , 40, 1000, strPreventiveAction, , " margin-left: 45px;", , , , , "onkeyup='javascript:Maxlength(this,""PreventiveAction"",1000)'", True, EnableHTMLEncode:=True))
            'If strPreventiveAction.Length > 400 Then
            '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtPreventiveAction", "txtPreventiveAction", , "form-control", , , , , , strPreventiveAction.Length / 2, 1000, strPreventiveAction, , "overflow:hidden;", , , , , "data-autoresize", True, EnableHTMLEncode:=True))
            'ElseIf strPreventiveAction.Length <= 400 And strPreventiveAction.Length >= 50 Then
            '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtPreventiveAction", "txtPreventiveAction", , "form-control", , , , , , strPreventiveAction.Length, 1000, strPreventiveAction, , "overflow:hidden;", , , , , "data-autoresize", True, EnableHTMLEncode:=True))
            'Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtPreventiveAction", "txtPreventiveAction", , "form-control", , , , , , , 1000, strPreventiveAction, , "overflow:hidden;", , , , , "data-autoresize", True, EnableHTMLEncode:=True))
            'End If
            strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;margin-top:-25px;float:right;margin-right:-31px;' id='PreventiveAction'></p>")
            strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-1'>")

            'strHTML.Append("</div>")
            strHTML.Append("</div>")

            '''''''''''

            ''''''''''''''''''''''''''''''''
            'strHTML.Append("<div class='form-group row'>")
            'strHTML.Append("<label  class='col-sm-1 col-form-label' data-toggle='tooltip' data-placement='bottom' title='Remark' >Remark</label>")
            'strHTML.Append("<div class='col-sm-6'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtRemark", "txtRemark", , "form-control", , , , , , , 1000, , , "margin-left: 45px;", , , , , "onkeyup='javascript:Maxlength(this,""DSRemark"",100)'" & strclass, True, EnableHTMLEncode:=True))

            'strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-1'>")
            'strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;margin-left:20px;margin-top:41px;' id='DSRemark'></p>")
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")

            ''''''''''''''''''''''''''''''''''''''''    
            'strHTML.Append("<div class='form-group row'>")
            'strHTML.Append("<label  class='col-sm-1 col-form-label' data-toggle='tooltip' data-placement='bottom'  >Convert To Imepediment</label>")
            'strHTML.Append("<div class='col-sm-10'>")
            'If strConvertToImpediment = "True" Then
            '    strHTML.Append("<input type='checkbox' id='IsConvertedToImpediment' style='margin-left:100px;margin-top:15px'checked value=1 " & strclass & ">")
            'Else
            '    strHTML.Append("<input type='checkbox' id='IsConvertedToImpediment' style='margin-left:100px;margin-top:15px' value=0 " & strclass & ">")
            'End If
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            strHTML.Append("<div class='form-group row'>")
            strHTML.Append(" <label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom'> Planned Issue Closure Date </label> ")
            strHTML.Append(" <div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DSTargetDate", "DSTargetDate", "form-control clsDisableColor", , , strTargetDate, , "margin-left: 43px", , , , , "onclick=""$('#DSTargetDate').datepicker({dateFormat: 'dd-M-yy', startDate: new Date()});$('#DSTargetDate').datepicker('show');""" & strclass, True, , , , , , True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DSTargetDate", "DSTargetDate", "form-control clsDisableColor", , , strTargetDate, , "width: 220px;", , , , , "onclick=""$('#DSTargetDate').datepicker({dateFormat: 'dd-M-yy', minDate: 0});$('#DSTargetDate').datepicker('show');""" & strclass, True, , , , , , True))

            strHTML.Append("<span class='input-group-addon' style='background-color: transparent;border: none;display: inline;'>")
            strHTML.Append("<i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px;color:#0099CC;margin-top: 17px;' onclick=""$('#DSTargetDate').datepicker({dateFormat: 'dd-M-yy', minDate: 0});$('#DSTargetDate').datepicker('show');""></i>")
            strHTML.Append("</span>")


            strHTML.Append("</div>")
            strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-1'>")
            'strHTML.Append("<i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px;color:#0099CC;margin-top: 17px;' onclick=""$('#DSTargetDate').datepicker({dateFormat: 'dd-M-yy', minDate: 0});$('#DSTargetDate').datepicker('show');""></i>")
            'strHTML.Append("</div>")

            strHTML.Append(" <label class='col-sm-3 col-form-label'  data-toggle='tooltip' data-placement='bottom'>Status</label> ")

            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")

            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("DSStatus", "usp_NG2_GetStatusForDSM 'Meeting'", , strStatus, "class='form-control' style='height: 33px;' onchange=getselectedDStatus(this)" & strclass, False, True, "clsDisableColor"))

            strHTML.Append(" </div>")
            strHTML.Append("</div>")
            strHTML.Append(" </div>")
            ''''''''''''''''''''''''''''''''''''''''''''''''''''


            ''''''''''''''''''''''''''''''''''
            strHTML.Append("<div class='form-group row'>")
            strHTML.Append("<label class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom'>Convert To</label>")

            strHTML.Append(" <div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")
            If strConvertToIssue <> "" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentConvertTo", "usp_NG2_Sel_ConvertTo_For_Impediment ", , "Issue", " onchange=""GetSelectedConvertTo(this)"" class='form-control clsDisableColor' disabled style='width:200px;height:32px;' ", True, True))
            End If
            If strConvertToRisk <> "" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentConvertTo", "usp_NG2_Sel_ConvertTo_For_Impediment ", , "Risk", " onchange=""GetSelectedConvertTo(this)"" class='form-control clsDisableColor' disabled style='width:200px;height:32px;' ", True, True))
            End If
            If strConvertToIssue = "" And strConvertToRisk = "" Then
                If strStatus = "Open" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentConvertTo", "usp_NG2_Sel_ConvertTo_For_Impediment ", , , " onchange=""GetSelectedConvertTo(this)"" class='form-control' style='width:200px;height:32px;' ", True, True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentConvertTo", "usp_NG2_Sel_ConvertTo_For_Impediment ", , , " onchange=""GetSelectedConvertTo(this)"" class='form-control clsDisableColor' disabled style='width:200px;height:32px;' ", True, True))

                End If
            End If
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            If (ImpedimentId <> "") Then


                strHTML.Append("<label for='inputEmail3' class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom'>Actual Completion Date</label></label> ")
                strHTML.Append(" <div class='col-sm-3'>")
                strHTML.Append("<div class='input-group'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DSActualStartDateDate", "DSActualStartDateDate", "form-control clsDisableColor", , , strActualCompletionDate, , "width:170px;margin-left: 21px;", , , , , " onclick=""$('#DSActualStartDateDate').datepicker({dateFormat: 'dd-M-yy', startDate: new Date()});$('#DSActualStartDateDate').datepicker('show');"" disabled ", True, , , , , , True))

                strHTML.Append("<span class='input-group-addon' style='background-color: transparent;border: none;display: inline;'>")
                strHTML.Append("<i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; color:#0099CC;margin-left: 20px;  margin-top: 17px;'></i>")
                strHTML.Append("</span>")

                strHTML.Append("</div>")
                strHTML.Append("</div>")
                'strHTML.Append("<div class='col-md-1'>")
                'strHTML.Append("<i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; color:#0099CC;margin-left: 20px;  margin-top: 17px;'></i>")
                'strHTML.Append("</div>")

            End If



            strHTML.Append("</div>")

            '''''''''''

            '''''''''''''''''''
            strHTML.Append("<div class='form-group row'>")

            'strHTML.Append("<div id='divResponsePerson' class='clsShow form-group clsShow'>")
            'strHTML.Append("<div class='col-md-6'>")
            strHTML.Append("<label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom' > Responsible Person* </label> ")
            'strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-6'>")
            strHTML.Append("<div class='col-md-3'>")
            strHTML.Append("<div class='input-group'>")

            Dim strDefaultResponsiblePerson As String = objfrmImpedimentLog.getDefaultResponsiblePerson()

            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("ResponsiblePerson", "usp_Sel_IB_IssueEntry_EmployeeList 'AssignTo', " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), , strDefaultResponsiblePerson, " onchange=""GetSelectedConvertTo(this)"" class='form-control' style='margin-left: 45px;width:200px;height:32px;' ", True, True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("ResponsiblePerson", "usp_Sel_IB_IssueEntry_EmployeeList 'AssignTo', " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), , strDefaultResponsiblePerson, " class='form-control' style='margin-left: 45px;width:200px;height:32px;' ", True, True))

            'strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append(" </div>")

            'strHTML.Append("<div id='divRiskCategory' class='clsShow form-group clsShow'>")
            'strHTML.Append("<div class='col-md-6'>")
            strHTML.Append(" <label class='col-sm-2 col-form-label' data-toggle='tooltip' data-placement='bottom'>Risk Category*</label> ")
            'strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append("<div class='input-group'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("RiskCategory", "usp_Sel_tbl_PM_RiskCategories", , , "class='form-control' style='height: 33px;' ", True, True))
            'strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append(" </div>")

            strHTML.Append("</div>")
            '''''''''''''''''''
            ''''''''''''''''''''''''

            strHTML.Append("<div id='divRiskFields' class='clsShow form-group row'>")
            strHTML.Append(" <label  class='col-sm-2 col-form-label' data-toggle='tooltip' data-placement='bottom'> Impact* </label> ")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Impact", "Impact", "form-control", , , , , "", , , , , " onkeypress='return validatedatatype(event,""Impact"")' ", True, , , , , , True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Impact", "Usp_Whizible2_Sel_Probability_Impact_Data 'Impact'", , , "onchange=calculateMagnitude() class='form-control' style='height: 33px;' ", False, True))

            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append(" <label  class='col-sm-2 col-form-label' data-toggle='tooltip' data-placement='bottom' style='margin-left: -8%;'> Probability* </label> ")
            strHTML.Append("<div class='col-md-4'>")
            strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Probability", "Probability", "form-control", , , , , "margin-left: 39%;", , , , , " onkeypress='return validatedatatype(event,""Probability"")' maxlength='8'", True, , , , , , True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Probability", "Usp_Whizible2_Sel_Probability_Impact_Data 'Probability'", , , "onchange=calculateMagnitude() class='form-control' style='height: 33px;' ", False, True))

            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            ''''''''''''''''''''''''

            strHTML.Append("</form>")
            strHTML.Append("</div>")
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    Protected Function AssignToResourceList() As String
        '=====================================================================
        ' Procedure Name        : AssignToResourceList
        ' Description           : For Plotting Assign To employee list
        ' Created Date           : 24th-OCT-2017
        '=====================================================================

        Dim dtTable As DataTable

        Dim strListHTML As New StringBuilder("")

        Dim intEmployeeID As Integer = 0

        dtTable = CommonFunction.Data.GetDataTable("usp_NG2_Sel_AssinedTo_ForDailyScrum " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), True)

        'strListHTML.Append('<a class='dropdown-item' href='#' onclick=''AssignToListClick('')'' > &nbsp; </a><br>' & vbCrLf)

        For Each drRow As DataRow In dtTable.Rows
            intEmployeeID = CInt(CommonFunction.Data.CheckIsDBNull(drRow.Item("EmployeeID"), "0"))

            strListHTML.Append("<li class='clsAssignedListItem dropdown-item'name='" & CommonFunction.Data.CheckIsDBNull(drRow.Item("EmployeeName"), "") & "'>")
            strListHTML.Append("<a href='#' id='" & CommonFunction.Data.CheckIsDBNull(drRow.Item("EmployeeID"), "") & "'name='" & CommonFunction.Data.CheckIsDBNull(drRow.Item("EmployeeName"), "") & "'  onclick='AssignToListClick(this)' >" & vbCrLf)
            'strListHTML.Append('<img id='imgUser' & intEmployeeID.ToString & '' src='' & strEmployeeImage & '' alt='No Image' style='height:30px;width:30px;border-radius:50%;' /> &nbsp; ')
            strListHTML.Append("<img  id='imgUser" & intEmployeeID.ToString & "' data-toggle='tooltip' data-placement='bottom' alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px;width:30px;' src='../../Images/Photo/" & drRow.Item("EmployeeImage") & "' />")
            strListHTML.Append(CommonFunction.Data.CheckIsDBNull(drRow.Item("EmployeeName"), "") & "</a>" & vbCrLf)
            strListHTML.Append("</li>")
        Next

        Return strListHTML.ToString

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DefaultIssueExist() As String
        '=====================================================================
        ' Procedure  Name		:	DefaultIssueExist
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Check if Default Issue Type is mapped or not
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   29 MAR 2018
        '=====================================================================

        Dim strSQL As String = ""
        Dim strResult As String
        Dim index As Integer = 0

        Try

            strSQL = "exec usp_NG2_chk_DefaultSettingForIssueMapped  " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ""
            strResult = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "0")

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetWeekDates(strFlag As String) As String
        '=====================================================================
        ' Procedure Name        :	GetWeekDates
        ' Purpose               :	GetWeekDates
        ' Description           :	Open DS
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	YOgesh Jalamkar
        ' Created               :	16th-March-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim strSql As String
            Dim strHTML As New StringBuilder("")
            Dim strColor As String = ""
            If strFlag = "Prev" Then
                dtDSCurrentDate = CommonFunctions.Dates.GetDate(Date.Parse(DateAdd("d", -7, dtDSCurrentDate)))
            ElseIf strFlag = "Next" Then
                dtDSCurrentDate = CommonFunctions.Dates.GetDate(Date.Parse(DateAdd("d", 7, dtDSCurrentDate)))
            End If

            strSql = "usp_NG2_GetWeekDates '" & dtDSCurrentDate & "'"
            Dim drWeekDates As IDataReader
            drWeekDates = CommonFunctions.Data.GetDataReader(strSql, True)
            Dim strCurrentDate As String = ""
            While drWeekDates.Read()
                strHTML.Append(" <tr>")
                If CommonFunctions.Data.CheckIsDBNull(drWeekDates("IsNonWorkingDay"), "0") = "1" Then
                    strColor = "red"
                Else
                    strColor = "#337ab7"
                End If

                'strHTML.Append("<input type='hidden' id='hdnDSCurrentDate' value='' & CurrentDate & ''>')
                If (CommonFunctions.Data.CheckIsDBNull(drWeekDates("IsCurrentDay"), "") = "1") Then
                    strHTML.Append("<td class='scrum_date selecteddate' style='border-top-color: transparent;'><a href='#' style='color:" & strColor & "' onclick=WeekDate_onclick('" & CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "") & "',this)>" & CommonFunctions.Dates.CGetDate(CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "")) & "</a></td>")
                Else
                    strHTML.Append("<td class='scrum_date' style='border-top-color: transparent;'><a href='#' style='color:" & strColor & "' onclick=WeekDate_onclick('" & CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "") & "',this)>" & CommonFunctions.Dates.CGetDate(CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "")) & "</a></td>")

                End If
                strCurrentDate = CommonFunctions.Dates.CGetDate(CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), ""))
                strHTML.Append(" </tr>")
            End While
            'strHTML.Append("&&'' & strCurrentDate & ''')
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveDailyScrum(MeetingID As String, ActionItems As String, Sprint As String, TargetDate As String, AssignedTo As String, Status As String, Remark As String, IsConvertedToImpediment As String) As String
        '=====================================================================
        ' Procedure Name        :	SaveDailyScrum
        ' Purpose               :	SaveDailyScrum
        ' Description           :	Open DS
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	YOgesh Jalamkar
        ' Created               :	16th-March-2018
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = "usp_NG2_INS_tbl_NG2_DailyScrumMeetingDetails "
        Dim strFlag As String = "0"
        Try


            If (MeetingID <> "") Then
                strSQL += MeetingID
            Else
                strSQL += "NULL"
            End If
            strSQL += "," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")
            strSQL += ",'" + ActionItems + "'"
            strSQL += "," + Sprint
            strSQL += ",'" + TargetDate + "'"
            strSQL += "," + AssignedTo
            strSQL += ",'" + Status + "'"
            strSQL += ",'" + Remark + "'"
            strSQL += "," + IsConvertedToImpediment
            strSQL += ",'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") + "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            strFlag = "1"
            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DrawGrid(Flag As String, Value As String, DateValue As String) As String
        '=====================================================================
        ' Procedure Name        :	DrawGrid()
        ' Purpose               :	DrawGrid by Dates
        ' Description           :	
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	YOgesh Jalamkar
        ' Created               :	16th-March-2018
        ' Revisions             :
        '=====================================================================
        Try
            Dim objImpedimentLog As New frmImpedimentLog
            Dim strHTML As New StringBuilder("")
            Dim strWhereClause As String = ""
            Dim strFromDate As String = ""
            If (Flag.ToUpper() = "WEEKDATE") Then
                strFromDate = Value

            ElseIf Flag.ToUpper() = "STATUS" Then
                'If DateValue = "" Then
                strWhereClause = "Status = ''" & Value & "''"
                'Else
                '    strWhereClause = "tbl_NG2_ImpedimentsLog.status = ''" & Value & "''" & " AND Convert(varchar(20),RaisedDate,101) = @dtFromDateNew "
                '    strFromDate = DateValue
                'End If

            ElseIf Flag.ToUpper() = "DSM" Then
                'strWhereClause = "IsConvertedToImpediment = """ & Value & """"
                'If DateValue = "" Then
                strWhereClause = "ScrumMeetingID " & Value & ""
                'Else
                '    strWhereClause = "ScrumMeetingID " & Value & "" & " AND Convert(varchar(20),RaisedDate,101) = @dtFromDateNew "
                '    strFromDate = DateValue
                'End If

            ElseIf Flag.ToUpper() = "SPRINTS" And Not Value = "" Then
                'If DateValue = "" Then
                strWhereClause = "tbl_NG2_ImpedimentsLog.IterationID = """ & Value & """"
                'Else
                '    strWhereClause = "tbl_NG2_ImpedimentsLog.IterationID = """ & Value & """" & " AND Convert(varchar(20),RaisedDate,101) = @dtFromDateNew "
                '    strFromDate = DateValue
                'End If
                'Added by Usha PAndit on 07 June 2018 for showing filter wise data
            ElseIf Flag.ToUpper() = "SPRINTS" And Value = "" Then
                strFromDate = DateValue
            ElseIf Flag = "" And Value = "" Then
                strFromDate = DateValue
                'End of Added by Usha PAndit on 07 June 2018 for showing filter wise data
            ElseIf Flag.ToUpper() = "AssignTo" Then

                strWhereClause = "AssignToName = """ & Value & """"

            ElseIf Flag.ToUpper() = "SAVEGRID" Then

            End If

            strHTML.Append(objImpedimentLog.PlotGrid(strFromDate, strWhereClause))
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function AddImpedimentModal()
        '=====================================================================
        ' Procedure Name        :	AddImpedimentModal
        ' Purpose               :	AddImpedimentModal
        ' Description           :	Open DS
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	YOgesh Jalamkar
        ' Created               :	16th-March-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim strHTML As New StringBuilder()
            Dim objfrmImpedimentLog As New frmImpedimentLog()
            strHTML.Append("<div class='' id='container_impediment'>")
            strHTML.Append(" <form>")

            ''''''''''''''''''''''''
            strHTML.Append("<div class='row form-group'>")
            strHTML.Append("<label class='col-sm-3 col-form-label'>Select Sprint*</label>")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")

            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSprint", "usp_NG2_Sel_tbl_PM_ScrumIteration_Open_Sprints " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), , , " onchange=""GetSelectedSprint(this)"" class='form-control' style='width:200px;height:32px;' ", False, True))
            strHTML.Append(" </div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            ''''''''''''''''''''''''

            '''''''''''      


            strHTML.Append("<div class='form-group row'>")
            strHTML.Append(" <label id='lblDescription'  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom' title='Action Items' style='margin-top:21px;'> Action Items/Description* </label> ")
            strHTML.Append("<div class='col-sm-9'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtImpedimentDescription", "txtImpedimentDescription", , "form-control", , , , , , 40, 500, , , " margin-left: 45px;overflow:hidden;margin-top:21px;", , , , , "data-autoresize", True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtImpedimentDescription", "txtImpedimentDescription", , "form-control", , , , , , , 500, , , "overflow:hidden;", , , , , "data-autoresize", True, EnableHTMLEncode:=True))
            strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;margin-top:-25px;float:right;margin-right:-31px;' id='ImpedimentDescription'></p>")
            strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-1'>")

            'strHTML.Append("</div>")
            strHTML.Append("</div>")

            '''''''''''

            strHTML.Append("<div class='form-group row'>")

            strHTML.Append(" <label  class='col-sm-3 col-form-label clsIsMandetory' data-toggle='tooltip' data-placement='bottom' > Priority </label> ")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentPriority", "usp_NG2_Sel_tbl_IB_PrioritiesDetails", , , "class='form-control' style='margin-left: 45px;width:200px;height:34px;' ", True, True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentPriority", "usp_NG2_Sel_tbl_IB_PrioritiesDetails", , , "class='form-control' style='width:200px;height:34px;' ", True, True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")


            'strHTML.Append("<label  class='col-sm-1 col-form-label clsIsMandetory' data-toggle='tooltip' data-placement='bottom' style='margin-left: 43px;'> Severity </label> ")
            strHTML.Append("<label  class='col-sm-3 col-form-label clsIsMandetory' data-toggle='tooltip' data-placement='bottom'> Severity </label> ")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentSeverity", "usp_NG2_Sel_tbl_IB_SeverityDetails", , , "class='form-control' style='margin-left: 45px;width:200px;height:34px;' ", True, True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentSeverity", "usp_NG2_Sel_tbl_IB_SeverityDetails", , , "class='form-control' style='width:200px;height:34px;' ", True, True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")



            strHTML.Append("</div>")

            ''''''''''''''''''''''''
            strHTML.Append("<div class='form-group row'>")
            strHTML.Append(" <label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom' > Corrective Action </label> ")
            strHTML.Append("<div class='col-sm-9'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtCorrectiveAction", "txtCorrectiveAction", , "form-control", , , , , , 40, 1000, , , "margin-left: 45px;", , , , , "data-autoresize", True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtCorrectiveAction", "txtCorrectiveAction", , "form-control", , , , , , , 1000, , , "overflow:hidden;", , , , , "data-autoresize", True, EnableHTMLEncode:=True))
            strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;margin-top:-25px;float:right;margin-right:-31px;' id='CorrectiveAction'></p>")
            strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-1'>")

            'strHTML.Append("</div>")
            strHTML.Append("</div>")

            '''''''''''''
            strHTML.Append("<div class='form-group row'>")
            strHTML.Append(" <label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom'  > Preventive Action </label> ")
            strHTML.Append("<div class='col-sm-9'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtPreventiveAction", "txtPreventiveAction", , "form-control", , , , , , 40, 1000, , , "  margin-left: 45px;", , , , , "data-autoresize", True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtPreventiveAction", "txtPreventiveAction", , "form-control", , , , , , , 1000, , , "overflow:hidden;", , , , , "data-autoresize", True, EnableHTMLEncode:=True))
            strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;margin-top:-25px;float:right;margin-right:-31px;' id='PreventiveAction'></p>")
            strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-1'>")

            'strHTML.Append("</div>")
            strHTML.Append("</div>")

            '''''''''''

            strHTML.Append("<div class='form-group row'>")
            strHTML.Append(" <label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom'> Planned Issue Closure Date </label> ")
            strHTML.Append(" <div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("dtPlannedIssueDate", "dtPlannedIssueDate", "form-control", , , , , "margin-left: 43px", , , , , " onchange=""checkProjectEndDate(this)"" onclick=""$('#dtPlannedIssueDate').datepicker({dateFormat: 'dd-M-yy', startDate: new Date()});$('#dtPlannedIssueDate').datepicker('show');""", True, , , , , , True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("dtPlannedIssueDate", "dtPlannedIssueDate", "form-control", , , , , "width:150px", , , , , " onchange=""checkProjectEndDate(this)"" onclick=""$('#dtPlannedIssueDate').datepicker({dateFormat: 'dd-M-yy', minDate: 0});$('#dtPlannedIssueDate').datepicker('show');""", True, , , , , , True))

            strHTML.Append("<span class='input-group-addon' style='background-color: transparent;border: none;display:inline;'>")
            strHTML.Append("<i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; color:#0099CC;margin-top: 17px;' onclick=""$('#dtPlannedIssueDate').datepicker({dateFormat: 'dd-M-yy', minDate: 0});$('#dtPlannedIssueDate').datepicker('show');""></i>")
            strHTML.Append("</span>")

            strHTML.Append("</div>")
            strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-1'>")
            'strHTML.Append("<i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; color:#0099CC;margin-top: 17px;' onclick=""$('#dtPlannedIssueDate').datepicker({dateFormat: 'dd-M-yy', minDate: 0});$('#dtPlannedIssueDate').datepicker('show');""></i>")
            'strHTML.Append("</div>")
            'Added by Usha Pandit on 18 Apr for adding raised date in popup
            Dim CurrentDate As String = CommonFunctions.Dates.CGetDate(DateTime.Now) 'DateTime.Parse(DateTime.Now).ToString("dd-MMM-yyyy")
            strHTML.Append(" <label  class='col-sm-3 col-form-label'> Raised Date </label> ")
            strHTML.Append(" <div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("dtRaisedDate", "dtRaisedDate", "form-control clsDisableColor", , , CurrentDate, , "margin-left: 21px;", True, , , , "  onclick=""$('#dtRaisedDate').datepicker({dateFormat: 'dd-M-yy', startDate: new Date()});$('#dtRaisedDate').datepicker('show');""", True, , , , , , True))

            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("dtRaisedDate", "dtRaisedDate", "form-control clsDisableColor", , , CurrentDate, , "width:150px", True, , , , "  onclick=""$('#dtRaisedDate').datepicker({dateFormat: 'dd-M-yy', minDate: 0});$('#dtRaisedDate').datepicker('show');""", True, , , , , , True))

            strHTML.Append("<span class='input-group-addon' style='background-color: transparent;border: none;display:inline;'>")
            strHTML.Append("<i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; color:#0099CC;margin-top: 17px;'></i>")
            strHTML.Append("</span>")

            strHTML.Append("</div>")
            strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-1'>")
            'strHTML.Append("<i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; color:#0099CC;margin-top: 17px;'></i>")
            'strHTML.Append("</div>")
            'End of Added by Usha Pandit on 18 Apr for hide scroll
            strHTML.Append("</div>")

            '''''''''''''''''''''''''''''''''''''


            'strHTML.Append("<div class='form-group row'>")
            'strHTML.Append(" <label  class='col-sm-1 col-form-label' data-toggle='tooltip' data-placement='bottom' > Raised Date </label> ")
            'strHTML.Append(" <div class='col-md-3'>")
            'strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("dtRaisedDate", "dtRaisedDate", "form-control", , , , , "margin-left: 43px", , , , , "onclick=$('#dtRaisedDate').datepicker();$('#dtRaisedDate').datepicker('show');", True, , , , , , True))
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-1'>")
            'strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; color:#0099CC;margin-left: 20px;  margin-top: 17px;'></i>")
            'strHTML.Append("</div>")


            'strHTML.Append(" <label  class='col-sm-1 col-form-label' data-toggle='tooltip' data-placement='bottom' > Actual Closure Date </label> ")
            'strHTML.Append(" <div class='col-md-3'>")
            'strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("dtActualIssueDate", "dtActualIssueDate", "form-control", , , , , "margin-left: 43px", , , , , "onclick=$('#dtActualIssueDate').datepicker();$('#dtActualIssueDate').datepicker('show');", True, , , , , , True))
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-1'>")
            'strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; color:#0099CC;margin-left: 20px;  margin-top: 17px;'></i>")
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            '''''''''''''''
            strHTML.Append("<div class='row form-group'>")
            strHTML.Append("<label class='col-sm-3 col-form-label'>Convert To</label>")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")

            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentConvertTo", "usp_NG2_Sel_ConvertTo_For_Impediment ", , , " onchange=""GetSelectedConvertTo(this)"" class='form-control' style='width:200px;height:32px;' ", True, True))
            strHTML.Append(" </div>")
            strHTML.Append("</div>")



            'strHTML.Append("<div id='divResponsePerson' class='clsShow col-md-6'>")
            'strHTML.Append("<div class='col-md-6'>")
            'strHTML.Append("<label  class='col-sm-2 col-form-label' data-toggle='tooltip' data-placement='bottom' > Responsible Person* </label> ")
            'strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-6'>")
            'strHTML.Append("<div class='input-group'>")
            'Dim strDefaultResponsiblePerson As String = objfrmImpedimentLog.getDefaultResponsiblePerson()

            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("ResponsiblePerson", "usp_Sel_IB_IssueEntry_EmployeeList 'AssignTo', " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), , strDefaultResponsiblePerson, " onchange=""GetSelectedConvertTo(this)"" class='form-control' style='margin-left: 45px;width:200px;height:34px;' ", True, True))

            ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ResponsiblePerson", "ResponsiblePerson", "form-control", , , , , "margin-left: 43px", , , , , , True, , , , , , True))
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            'strHTML.Append(" </div>")

            'strHTML.Append("<div id='divResponsePerson' class='clsShow'>")

            strHTML.Append("<label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom' > Responsible Person* </label> ")

            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")
            Dim strDefaultResponsiblePerson As String = objfrmImpedimentLog.getDefaultResponsiblePerson()

            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("ResponsiblePerson", "usp_Sel_IB_IssueEntry_EmployeeList 'AssignTo', " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), , strDefaultResponsiblePerson, " onchange=""GetSelectedConvertTo(this)"" class='form-control' style='width:200px;height:34px;' ", True, True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("ResponsiblePerson", "usp_Sel_IB_IssueEntry_EmployeeList 'AssignTo', " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), , strDefaultResponsiblePerson, " class='form-control' style='width:200px;height:34px;' ", True, True))

            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ResponsiblePerson", "ResponsiblePerson", "form-control", , , , , "margin-left: 43px", , , , , , True, , , , , , True))
            'strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append(" </div>")


            'strHTML.Append("<div id='divRiskCategory' class='clsShow col-md-6'>")
            'strHTML.Append("<div class='col-md-6'>")
            'strHTML.Append(" <label class='col-sm-2 col-form-label' style='margin-left: 36px;'  data-toggle='tooltip' data-placement='bottom' title='Risk Category'>Risk Category*</label> ")
            'strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-6'>")
            'strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("RiskCategory", "usp_Sel_tbl_PM_RiskCategories", , , "class='form-control' style='margin-left: 43px;height: 33px;' ", True, True))
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            'strHTML.Append(" </div>")


            'strHTML.Append("<div id='divRiskCategory' class='clsShow'>")

            strHTML.Append(" <label class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom' title='Risk Category'>Risk Category*</label> ")

            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("RiskCategory", "usp_Sel_tbl_PM_RiskCategories", , , "class='form-control' style='height: 33px;' ", True, True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            'strHTML.Append(" </div>")

            strHTML.Append(" </div>")
            ''''''''''''''''''''''''

            strHTML.Append("<div id='divRiskFields' class='clsShow form-group row'>")
            strHTML.Append(" <label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom'> Impact* </label> ")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Impact", "Impact", "form-control", , , , , "margin-left: 21px", , , , , " onkeypress='return validatedatatype(event,""Impact"")' ", True, , , , , , True))
            ' strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Impact", "Impact", "form-control", , , , , "", , , , , " onkeypress='return validatedatatype(event,""Impact"")' ", True, , , , , , True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Impact", "Usp_Whizible2_Sel_Probability_Impact_Data 'Impact'", , , "onchange=calculateMagnitude() class='form-control' style='height: 33px;' ", False, True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")


            strHTML.Append(" <label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom'  style='margin-left:-8%'> Probability* </label> ")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Probability", "Probability", "form-control", , , , , "margin-left: 43px", , , , , " onkeypress='return validatedatatype(event,""Probability"")' ", True, , , , , , True))
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Probability", "Probability", "form-control", , , , , "margin-left: 37%;", , , , , " onkeypress='return validatedatatype(event,""Probability"")' maxlength='8' ", True, , , , , , True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Probability", "Usp_Whizible2_Sel_Probability_Impact_Data 'Probability'", , , "onchange=calculateMagnitude() class='form-control' style='height: 33px;' ", False, True))

            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            ''''''''''''''''''''''''

            '''''''''''''''''''''''''''''''''''''

            strHTML.Append("<div class='form-group row'>")
            strHTML.Append(" <label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom'  > Status </label> ")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentStatus", "usp_NG2_GetStatusForDSM 'Impediment'", , "Open", "class='form-control' style='margin-left: 45px;width:200px;height:34px;' onchange=getselectedDStatus(this) ", True, True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentStatus", "usp_NG2_GetStatusForDSM 'Impediment'", , "Open", "class='form-control' style='width:200px;height:34px;' onchange=getselectedDStatus(this) ", True, True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            ''''''''''''''''''''''''''''''''''''''''

            strHTML.Append("</form>")
            strHTML.Append("</div>")
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function checkIssueStatus(ImpedimentID As String)
        '=====================================================================
        ' Procedure  Name		:	checkIssueStatus
        ' Parameters Passed		:	Type
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Check Whether Issue Status is closed or not for Issue assigned to selected ImpedimentID
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   6 APR 2018
        '=====================================================================
        Try

            Dim strFlag As String = ""
            Dim strSQL As String = ""

            Dim strScript As String()

            strSQL = "usp_NG2_sel_tbl_NG2_ImpedimentIssueStatus " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & "," & ImpedimentID

            strFlag = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function checkRiskStatus(ImpedimentID As String)
        '=====================================================================
        ' Procedure  Name		:	checkRiskStatus
        ' Parameters Passed		:	Type
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Check Whether Risk Status is closed or not for Risk assigned to selected ImpedimentID
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   6 APR 2018
        '=====================================================================
        Try

            Dim strFlag As String = ""
            Dim strSQL As String = ""

            Dim strScript As String()

            strSQL = "usp_NG2_sel_tbl_NG2_ImpedimentRiskStatus " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & "," & ImpedimentID

            strFlag = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function getDefaultIssueType()
        '=====================================================================
        ' Procedure  Name		:	getDefaultIssueType
        ' Parameters Passed		:	Type
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To get Default Issue Type
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   6 APR 2018
        '=====================================================================
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim strDefaultIssue As String = ""
            Dim strDefaultIssueSubType As String = ""
            Dim strDefaultIssueStatus As String = ""

            Dim strScript As String()

            strSQL = "usp_NG2_sel_DefaultIssueType " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")


            Dim drDefaultIssue As IDataReader
            drDefaultIssue = CommonFunctions.Data.GetDataReader(strSQL, True)
            If drDefaultIssue.Read Then
                strDefaultIssue = CommonFunctions.Data.CheckIsDBNull(drDefaultIssue("IssueType"), "")
                strDefaultIssueSubType = CommonFunctions.Data.CheckIsDBNull(drDefaultIssue("IssueSubType"), "")
                strDefaultIssueStatus = CommonFunctions.Data.CheckIsDBNull(drDefaultIssue("Status"), "")
            End If
            strResult = strDefaultIssue & "|" & strDefaultIssueSubType & "|" & strDefaultIssueStatus
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetSubType(Type As String)
        '=====================================================================
        ' Procedure  Name		:	GetSubType
        ' Parameters Passed		:	Type
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Sub Type for selected Type
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   3 APR 2018
        '=====================================================================
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()

            ' Dim m_strUserID As String

            strSQL = "usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ", 'S','" & Type & "'"

            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            strScript = strResult.Split("|")

            strHTML.Append(strScript(0) + vbCrLf)
            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    'Added By Usha Pandit On 09.11.2020 For getting correct status
    <System.Web.Services.WebMethod()>
    Public Shared Function GetStatus(Type As String)
        '=====================================================================
        ' Procedure  Name		:	GetStatus
        ' Parameters Passed		:	Type
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Status for selected Type
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   09 Nov 2020
        '=====================================================================
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()

            ' Dim m_strUserID As String

            strSQL = "usp_Sel_tbl_IB_Project_Type_Status_OpenStatus " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ", '" & Type & "', " & CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intPostID"), 0), Long)

            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            strScript = strResult.Split("|")

            strHTML.Append(strScript(0) + vbCrLf)
            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    'End Of Added By Usha Pandit On 09.11.2020 For getting correct status
    <System.Web.Services.WebMethod()>
    Public Shared Function GetIteration(ReleaseId As String)
        '=====================================================================
        ' Procedure  Name		:	GetIteration
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Iteration for selected ReleaseId
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   3 APR 2018
        '=====================================================================
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()

            ' Dim m_strUserID As String

            strSQL = "usp_sel_tbl_PM_ScrumIteration_ReleaseIDWise_IterationID_IterationName " & ReleaseId

            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            strScript = strResult.Split("|")

            strHTML.Append(strScript(0) + vbCrLf)
            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetUserStory(IterationId As String)
        '=====================================================================
        ' Procedure  Name		:	GetUserStories
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get User Stories for selected IterationId
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   3 APR 2018
        '=====================================================================
        Try

            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()

            ' Dim m_strUserID As String

            strSQL = "usp_sel_tbl_PM_ScrumUserStory_IterationWise_UserStoryID_UserStoryName " & IterationId

            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            strScript = strResult.Split("|")

            strHTML.Append(strScript(0) + vbCrLf)
            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    Public Shared Function GetSerialized(dt As DataTable) As String
        Try

            Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
            Dim rows As New List(Of Dictionary(Of String, Object))()
            Dim row As Dictionary(Of String, Object)
            For Each dr As DataRow In dt.Rows
                row = New Dictionary(Of String, Object)()
                For Each col As DataColumn In dt.Columns
                    row.Add(col.ColumnName, dr(col))
                Next
                rows.Add(row)
            Next
            Return serializer.Serialize(rows)
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function AddIssueModal(ByVal ImpedimentId As String)
        '=====================================================================
        ' Procedure Name        :	AddIssueModal
        ' Purpose               :	AddIssueModal
        ' Description           :	
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Usha Pandit
        ' Created               :	27th-March-2018
        ' Revisions             :
        '=====================================================================

        Try

            Dim strHTML As New StringBuilder()
            Dim objfrmImpedimentLog As New frmImpedimentLog()
            strHTML.Append("<div class='' id='container_issue'>")
            strHTML.Append(" <form>")

            If ImpedimentId = "" Then
                strHTML.Append("<div class='form-group row'>")
                'strHTML.Append("<div class=''>")
                strHTML.Append(" <label id='lbltxtSummary'  class='col-form-label col-md-3' data-toggle='tooltip' data-placement='bottom'> Summary* </label> ")
                'strHTML.Append("</div>")
                strHTML.Append("<div class='col-sm-9'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtSummary", "txtSummary", , "form-control", , , , , , , 500, , , "overflow:hidden;", , , , , "data-autoresize ", True, EnableHTMLEncode:=True))
                strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;margin-top:-25px;float:right;margin-right:-31px;' id='Summary'></p>")
                strHTML.Append("</div>")
                'strHTML.Append("<div class='col-md-1'>")

                'strHTML.Append("</div>")
                strHTML.Append("</div>")
            End If

            strHTML.Append("<div class='form-group row'>")
            'strHTML.Append("<div class=''>")
            strHTML.Append(" <label id='lblDescription'  class='col-form-label col-md-3' data-toggle='tooltip' data-placement='bottom'> Description* </label> ")
            'strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-9'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtImpedimentDescription", "txtImpedimentDescription", , "form-control", , , , , , 40, 500, , , "  margin-left: 21px;overflow:hidden;", , , , , "data-autoresize ", True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtImpedimentDescription", "txtImpedimentDescription", , "form-control", , , , , , , 500, , , "overflow:hidden;width:90%;", , , , , "data-autoresize ", True, EnableHTMLEncode:=True))
            strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;margin-top:-25px;float:right;margin-right:-31px;' id='ImpedimentDescription'></p>")
            strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-1'>")

            'strHTML.Append("</div>")
            strHTML.Append("</div>")

            '''''''''''''''''''''''''''''''''
            If ImpedimentId = "" Then
                '''''''''''''''''''''''''''''''''
                strHTML.Append("<div class='form-group row'>")

                strHTML.Append(" <label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom'> Type* </label> ")
                strHTML.Append("<div class='col-sm-3'>")
                strHTML.Append("<div class='input-group'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("txtType", "usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ", 'T',Null,Null,Null,Null,Null," & CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intPostID"), 0), Long), , , " onchange=""GetSelectedType(this)"" class='form-control' style='width:200px;height:34px;' ", True, True))
                strHTML.Append("</div>")
                strHTML.Append("</div>")


                strHTML.Append(" <label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom'> Sub Type* </label> ")
                strHTML.Append("<div class='col-sm-3'>")
                strHTML.Append("<div class='input-group'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("txtSubType", "usp_Sel_tbl_IB_Project_Sub_Type_ProjectGroup " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ", 'S', 'Enhancement'", , , "class='form-control' style='margin-left: 93px;width:150px;height:34px;' ", True, True))
                strHTML.Append("</div>")
                strHTML.Append("</div>")



                strHTML.Append("</div>")

                '''''''''''''''''''''''''''''''''
            End If



            '''''''''''

            strHTML.Append("<div class='form-group row'>")

            strHTML.Append(" <label  class='col-sm-3 col-form-label clsIsMandetory' data-toggle='tooltip' data-placement='bottom' > Priority* </label> ")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentPriority", "usp_NG2_Sel_tbl_IB_PrioritiesDetails", , , "class='form-control' style='margin-left: 21px;width:200px;height:34px;' ", True, True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentPriority", "usp_NG2_Sel_tbl_IB_PrioritiesDetails", , , "class='form-control' style='width:200px;height:34px;' ", True, True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")


            strHTML.Append(" <label  class='col-sm-3 col-form-label clsIsMandetory' data-toggle='tooltip' data-placement='bottom'> Severity* </label> ")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentSeverity", "usp_NG2_Sel_tbl_IB_SeverityDetails", , , "class='form-control' style='margin-left: 45px;width:200px;height:34px;' ", True, True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentSeverity", "usp_NG2_Sel_tbl_IB_SeverityDetails", , , "class='form-control' style='width:200px;height:34px;margin-left: 93px;' ", True, True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-1'>")
            'strHTML.Append("</div>")


            strHTML.Append("</div>")

            ''''''''''''''''''''''''
            strHTML.Append("<div class='form-group row'>")

            'strHTML.Append(" <label  class='col-sm-1 col-form-label' data-toggle='tooltip' data-placement='bottom'> Reported Date* </label> ")
            'strHTML.Append("<div class='col-md-3'>")
            'strHTML.Append("<div class='input-group'>")

            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReportedDate", "txtReportedDate", "form-control", , , , , "margin-left: 43px;width: 150px;", , , , , "onclick=""$('#txtReportedDate').datepicker({dateFormat: 'dd-M-yy', minDate: 0, setDate: new Date()});$('#txtReportedDate').datepicker('show');""", True, , , , , , True))


            ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("txtReportedDate", "usp_NG2_Sel_tbl_IB_SeverityDetails", , , "class='form-control' style='margin-left: 44px;width:150px;height:34px;' ", True, True))
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")


            'strHTML.Append(" <label  class='col-sm-1 col-form-label' data-toggle='tooltip' data-placement='bottom' > Reported Time* </label> ")
            'strHTML.Append("<div class='col-md-3'>")
            'strHTML.Append("<div class='input-group'>")

            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtReportedTime", "txtReportedTime", "form-control", , , , , "margin-left: 43px;width: 150px;", , , , , " onkeypress='return validatedatatype(event,""Impact"")' ", True, , , , , , True))

            ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("txtReportedTime", "usp_NG2_Sel_tbl_IB_PrioritiesDetails", , , "class='form-control' style='margin-left: 40px;width:150px;height:34px;' ", True, True))
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            If ImpedimentId = "" Then
                strHTML.Append(" <label  class='col-sm-3 col-form-label clsIsMandetory' data-toggle='tooltip' data-placement='bottom' > Reported By* </label> ")
                strHTML.Append("<div class='col-sm-3'>")
                strHTML.Append("<div class='input-group'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("txtReportedBy", "usp_Sel_IB_IssueEntry_EmployeeList 'ReportedBy', " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",  " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0") & ", 1, NULL, NULL , 'E','New',0", , CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), ""), "class='form-control' style='width:200px;height:34px' ", True, True))
                strHTML.Append("</div>")
                strHTML.Append("</div>")
            End If
            'strHTML.Append("<div class=''>")
            strHTML.Append("<label  class='col-form-label col-sm-3' data-toggle='tooltip' data-placement='bottom'> Responsible Person* </label> ")
            'strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append("<div class='input-group'>")
            Dim strDefaultResponsiblePerson As String = objfrmImpedimentLog.getDefaultResponsiblePerson()

            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("ResponsiblePerson", "usp_Sel_IB_IssueEntry_EmployeeList 'AssignTo', " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), , strDefaultResponsiblePerson, " onchange=""GetSelectedConvertTo(this)"" class='form-control' style='margin-left: 21px;width:200px;height:34px;' ", True, True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("ResponsiblePerson", "usp_Sel_IB_IssueEntry_EmployeeList 'AssignTo', " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), , strDefaultResponsiblePerson, " class='form-control' style='margin-left: 21px;width:200px;height:34px;' ", True, True))

            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("</div>")
            '''''''''''''''''''''''''''''''''

            ''''''''''''''''''''''''
            If ImpedimentId = "" Then
                strHTML.Append("<div class='form-group row'>")
                strHTML.Append(" <label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom' > Status* </label> ")
                strHTML.Append("<div class='col-sm-3'>")
                strHTML.Append("<div class='input-group'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("txtStatus", "usp_Sel_tbl_IB_Project_Type_Status_OpenStatus " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",'Enhancement'," & CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intPostID"), 0), Long), , , "class='form-control' style='width:110px;height:34px;' ", True, True))
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
            End If
            strHTML.Append("</form>")
            strHTML.Append("</div>")
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function AddRiskModal(ByVal ImpedimentId As String)
        '=====================================================================
        ' Procedure Name        :	AddRiskModal
        ' Purpose               :	AddRiskModal
        ' Description           :	
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Usha Pandit
        ' Created               :	27th-March-2018
        ' Revisions             :
        '=====================================================================
        Try

            Dim strHTML As New StringBuilder()
            strHTML.Append("<div class='' id='container_risk'>")
            strHTML.Append(" <form>")

            ''''''''''''''''''''''''
            strHTML.Append("<div class='form-group row'>")
            strHTML.Append("<div class='col-sm-2'>")
            strHTML.Append(" <label id='lblDescription'  class='col-form-label' data-toggle='tooltip' data-placement='bottom'> Project Risk ID </label> ")
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-2'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("ProjectRiskID", "ProjectRiskID", , "form-control", , , , , , , 500, , , " ", True, , , , "data-autoresize", True, EnableHTMLEncode:=True))
            'strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;margin-top:-25px;float:right;margin-right:-31px;' id='ImpedimentDescription'></p>")

            strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-1'>")
            'strHTML.Append("</div>")
            strHTML.Append("</div>")
            ''''''''''''''''''''''''
            '''''''''''      

            strHTML.Append("<div class='form-group row'>")
            strHTML.Append("<div class='col-sm-2'>")
            strHTML.Append(" <label id='lblDescription'  class='col-form-label' data-toggle='tooltip' data-placement='bottom'> Description* </label> ")
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-10'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtImpedimentDescription", "txtImpedimentDescription", , "form-control", , , , , , 40, 1000, , , " margin-left: 21px;", , , , , "onkeyup='javascript:Maxlength(this,""ImpedimentDescription"",1000)'", True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtImpedimentDescription", "txtImpedimentDescription", , "form-control", , , , , , , 500, , , "overflow:hidden;", , , , , "data-autoresize", True, EnableHTMLEncode:=True))
            strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;margin-top:-25px;float:right;margin-right:-31px;' id='ImpedimentDescription'></p>")

            strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-1'>")
            'strHTML.Append("</div>")
            strHTML.Append("</div>")

            If ImpedimentId = "" Then
                strHTML.Append("<div class='form-group row'>")
                strHTML.Append("<div class='col-sm-2'>")
                strHTML.Append(" <label id='lblDescription'  class='col-form-label' data-toggle='tooltip' data-placement='bottom'> Impact Description* </label> ")
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-sm-10'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtImpactDescription", "txtImpactDescription", , "form-control", , , , , , , 500, , , "overflow:hidden;", , , , , "data-autoresize", True, EnableHTMLEncode:=True))
                strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;margin-top:-25px;float:right;margin-right:-31px;' id='ImpactDescription'></p>")

                strHTML.Append("</div>")
                'strHTML.Append("<div class='col-md-1'>")
                'strHTML.Append("</div>")
                strHTML.Append("</div>")
            End If

            strHTML.Append("<div class='form-group row'>")

            strHTML.Append("<div class='col-sm-2'>")
            strHTML.Append(" <label class='col-form-label' data-toggle='tooltip' data-placement='bottom'>Risk Category*</label> ")
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append("<div class='input-group'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("RiskCategory", "usp_Sel_tbl_PM_RiskCategories", , , "class='form-control' style='height: 33px;' ", True, True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            If ImpedimentId = "" Then
                strHTML.Append("<div class='col-sm-2'>")
                strHTML.Append(" <label class='col-form-label' data-toggle='tooltip' data-placement='bottom'>Status*</label> ")
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-sm-4'>")
                strHTML.Append("<div class='input-group'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("RiskStatus", "usp_sel_PM_RiskStatus", , "Identified", "class='form-control' style='height: 33px;' ", True, True))
                strHTML.Append("</div>")
                strHTML.Append("</div>")
            End If

            strHTML.Append(" </div>")

            ''''''''''''''''''''''''

            strHTML.Append("<div class='form-group row'>")
            strHTML.Append("<div class='col-sm-2'>")
            strHTML.Append(" <label  class='col-form-label' data-toggle='tooltip' data-placement='bottom'> Impact* </label> ")
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Impact", "Impact", "form-control", , , , , " ", , , , , " onkeypress='return validatedatatype(event,""Impact"")' onkeyup=calculateMagnitude()", True, , , , , , True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Impact", "Usp_Whizible2_Sel_Probability_Impact_Data 'Impact'", , , "onchange=calculateMagnitude() class='form-control' style='height: 33px;' ", False, True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            'strHTML.Append("</div>")


            'strHTML.Append("<div class='form-group row'>")
            strHTML.Append("<div class='col-sm-2'>")
            strHTML.Append(" <label  class='col-form-label' data-toggle='tooltip' data-placement='bottom' > Probability* </label> ")
            strHTML.Append("</div>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append("<div class='input-group'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Probability", "Probability", "form-control", , , , , " ", , , , , " onkeypress='return validatedatatype(event,""Probability"")' onkeyup=calculateMagnitude() maxlength='8'", True, , , , , , True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Probability", "Usp_Whizible2_Sel_Probability_Impact_Data 'Probability'", , , "onchange=calculateMagnitude() class='form-control' style='height: 33px;' ", False, True))

            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")


            ''''''''''''''''''''''''
            If ImpedimentId = "" Then

                ''''''''''''''''''''''''
                Dim CurrentDate As String = DateTime.Parse(DateTime.Now).ToString("dd-MMM-yyyy")
                strHTML.Append("<div class='form-group row'>")

                strHTML.Append("<div class='col-sm-2'>")
                strHTML.Append(" <label  class='col-form-label' data-toggle='tooltip' data-placement='bottom' > Magnitude </label> ")
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-sm-4'>")
                strHTML.Append("<div class='input-group'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Magnitude", "Magnitude", "form-control clsDisableColor", , , , , " ", True, , , , "  ", True, , , , , , True))
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='col-sm-2'>")
                strHTML.Append(" <label  class='col-form-label' data-toggle='tooltip' data-placement='bottom' > Date Identified* </label> ")
                strHTML.Append("</div>")
                strHTML.Append("<div class='col-sm-4'>")
                strHTML.Append("<div class='input-group'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("IdentifiedDate", "IdentifiedDate", "form-control", , , CurrentDate, , " ", , , , , "  onclick=""$('#IdentifiedDate').datepicker({dateFormat: 'dd-M-yy', minDate: 0, setDate : new Date()});$('#IdentifiedDate').datepicker('show');""", True, , , , , , True))
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("<div class=''>")
                strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; color:#0099CC;margin-top: 13px;' onclick=""$('#IdentifiedDate').datepicker({dateFormat: 'dd-M-yy', minDate: 0});$('#IdentifiedDate').datepicker('show');""></i>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                ''''''''''''''''''''''''

            End If

            strHTML.Append("</form>")
            strHTML.Append("</div>")
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveImpedimentRisk(Probability As String, Impact As String, Description As String, RiskCategoryId As String, ImpedimentID As String, ImpactDescription As String, RiskStatus As String, DateIdentified As String) As String
        '=====================================================================
        ' Procedure Name        :	SaveImpedimentRisk
        ' Purpose               :	Save Impediment Risk
        ' Description           :	
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Usha Pandit
        ' Created               :	29 MAR 2018
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = ""
        Dim strFlag As String = "0"
        Try
            If Probability = "" Or Probability Is Nothing Then
                Probability = "0"
            End If
            If Impact = "" Or Impact Is Nothing Then
                Impact = "0"
            End If
            If RiskCategoryId = "" Or RiskCategoryId Is Nothing Then
                RiskCategoryId = "0"
            End If
            If ImpedimentID = "" Or ImpedimentID Is Nothing Then
                ImpedimentID = "0"
            End If
            If Description.Contains("'") Then
                Description = Description.Replace("'", "''")
            End If
            If ImpactDescription.Contains("'") Then
                ImpactDescription = ImpactDescription.Replace("'", "''")
            End If
            If ImpedimentID = "0" Then
                strSQL = "usp_NG2_Ins_tbl_PM_Risks " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",'" & Description & "','" & ImpactDescription & "'," & RiskCategoryId & "," & Probability & "," & Impact & ",'" & RiskStatus & "','" & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") & "','" + DateIdentified + "'"
            Else
                strSQL = "usp_NG2_Ins_tbl_PM_ImpedimentRisks '" & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") & "'," & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & "," & Probability & "," & Impact & ",'" & Description & "'," & RiskCategoryId & "," & ImpedimentID
            End If

            strFlag = CommonFunctions.Data.GetDataScalar(strSQL, True)
            strFlag = "Success"
            Return strFlag
        Catch ex As Exception
            strFlag = ex.Message
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveImpedimentIssue(Description As String, ImpedimentID As String, AssignTo As String, Type As String, SubType As String, Status As String, ReportedBy As String, Summary As String, Priority As String, Severity As String) As String
        '=====================================================================
        ' Procedure Name        :	SaveImpedimentIssue
        ' Purpose               :	Save Impediment Issue
        ' Description           :	
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Usha Pandit
        ' Created               :	30 MAR 2018
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = ""
        Dim strFlag As String = "0"
        Try
            If ImpedimentID = "" Or ImpedimentID Is Nothing Then
                ImpedimentID = "0"
            End If

            If AssignTo = "" Or AssignTo Is Nothing Then
                AssignTo = "0"
            End If

            If Description.Contains("'") Then
                Description = Description.Replace("'", "''")
            End If
            If Summary.Contains("'") Then
                Summary = Summary.Replace("'", "''")
            End If

            If ImpedimentID = "0" Then
                strSQL = "usp_NG2_Ins_tbl_IB_Issue " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",'" & Summary & "','" & Description & "','" & Type & "','" & SubType & "','" & Status & "','" & ReportedBy & "'," & AssignTo & ",'" & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") & "'"

            Else
                strSQL = "usp_NG2_Ins_tbl_IB_ImpedimentIssue '" & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") & "'," & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",'" & Description & "'," & ImpedimentID & "," & AssignTo & ",'" & Priority & "','" & Severity & "'"

            End If

            strFlag = CommonFunctions.Data.GetDataScalar(strSQL, True)
            strFlag = "Success"
            Return strFlag
        Catch ex As Exception
            strFlag = ex.Message
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveImpediment(ImpedimentID As String, ImpedimentDescription As String, ImpedimentSeverity As String, ImpedimentPriority As String, CorrectiveAction As String, PreventiveAction As String, PlannedIssueDate As String, impedimentStatus As String, ConvertedTo As String, IterationID As String) As String
        '=====================================================================
        ' Procedure Name        :	SaveImpediment
        ' Purpose               :	SaveImpediment
        ' Description           :	
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	YOgesh Jalamkar
        ' Created               :	16th-March-2018
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = "usp_NG2_INS_tbl_NG2_ImpedimentsLog "
        Dim strFlag As String = "0"
        Try
            If (ImpedimentID <> "") Then
                strSQL += ImpedimentID
            Else
                strSQL += "NULL"
            End If
            If ImpedimentDescription.Contains("'") Then
                ImpedimentDescription = ImpedimentDescription.Replace("'", "''")
            End If
            If CorrectiveAction.Contains("'") Then
                CorrectiveAction = CorrectiveAction.Replace("'", "''")
            End If

            If PreventiveAction.Contains("'") Then
                PreventiveAction = PreventiveAction.Replace("'", "''")
            End If
            strSQL += "," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")
            strSQL += ",'" + ImpedimentDescription + "'"
            strSQL += ",'" + ImpedimentSeverity + "'"
            strSQL += ",'" + ImpedimentPriority + "'"
            strSQL += ",'" + CorrectiveAction + "'"
            strSQL += ",'" + PreventiveAction + "'"

            If PlannedIssueDate = "" Then
                strSQL += ",NULL"
            Else
                strSQL += ",'" + PlannedIssueDate + "'"
            End If

            If impedimentStatus = "Info" Then
                strSQL += ",'" + impedimentStatus + "'"
            ElseIf impedimentStatus = "Delayed" Then
                strSQL += ", NULL"
            Else
                strSQL += ",'" + impedimentStatus + "'"
            End If

            strSQL += ",'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") + "'"
            If (ConvertedTo <> "") Then
                strSQL += ",'" + ConvertedTo + "'"
            Else
                strSQL += "," + "NULL"
            End If

            strSQL += "," + IterationID
            strFlag = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strFlag
        Catch ex As Exception
            strFlag = ex.Message
            Return "Bad Request found"
        End Try

    End Function

End Class
