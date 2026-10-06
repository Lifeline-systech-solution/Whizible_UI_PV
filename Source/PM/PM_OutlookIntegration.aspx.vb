Partial Public Class PM_OutlookIntegration
    Inherits WebPages.Template.WhizTemplate
    Private sbICSFile As StringBuilder = New StringBuilder()
    Dim m_strCopy As String = "0"
    Private m_intUserID As Integer
    Dim m_strEntityIDs As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'If Not IsPostBack Then
        Dim dtNow As DateTime = DateTime.Parse(DateTime.Now.ToShortDateString())
        'End If
        Call InitVariables()
        If Request.QueryString("Action") = "INTEGRATENOW" Then
            Call Integrate()
        End If
    End Sub
    Private Sub InitVariables()
        m_strCopy = CommonFunction.General.CheckIsNothing(Request.QueryString("Copy"), "0")
        m_intUserID = HttpContext.Current.Session("intUserID")
        m_strEntityIDs = Request.QueryString("EntityIds")
       
    End Sub
    Private Sub Integrate()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : integrate tasks, milestones & deliverables by generating ICS file
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : NA
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Sonal Danej
        ' Created               : 10th,August 2008
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim strAccessibleProjectIDs As String = ""
        Dim dr As IDataReader
        Dim drRecords As IDataReader
        Dim bln As Boolean = False
        Dim blnRecords As Boolean = False
        Dim StartDate As DateTime
        Dim EndDate As DateTime
        Dim EntityName As String
        Dim ProjectName As String
        Dim HoursPerDay As Integer
        Dim intEndTime As Integer
        Dim strStatus As String
        Dim str As String
        Response.Clear()
        'm_strSelectValue = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkEntity"), "")

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''HoursPerDay = CommonFunction.Data.GetDataScalar("SELECT HoursPerDay FROM tbl_PM_CompanyInformation", True)
        HoursPerDay = CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_HoursPerDay", True)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        'START TIME 9 AM PLUS HOURSPER DAY . IT WILL BE THE END TIME
        intEndTime = 9 + HoursPerDay
        'get comma seperated list of project ids
        strSQL = "usp_Sel_AccessibleProjects_ForEmployee " + m_intUserID.ToString
        dr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        While dr.Read()
            strAccessibleProjectIDs = strAccessibleProjectIDs + dr("ProjectID").ToString + ","
        End While
        CommonFunction.Data.DisposeDataReader(dr)
        '***
        strSQL = "usp_sel_OutLookConfigurationDetails " + m_intUserID.ToString + ",'" + m_strEntityIDs + "','" + strAccessibleProjectIDs + "',1,0"
        drRecords = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drRecords.Read Then
            blnRecords = True
        End If

        drRecords.NextResult()
        If drRecords.Read Then
            blnRecords = True
        End If

        drRecords.NextResult()
        If drRecords.Read Then
            blnRecords = True
        End If
        CommonFunction.Data.DisposeDataReader(drRecords)
        If blnRecords = False Then
            CommonFunction.General.WriteHTML("<Script Language=JavaScript>")
            CommonFunction.General.WriteHTML("alert('There are no items to import');")
            CommonFunction.General.WriteHTML("window.close();")
            CommonFunction.General.WriteHTML("</Script>")
            Return
        End If
        '***

        'strSQL = "usp_sel_OutLookConfigurationDetails " + m_intUserID.ToString + ",'" + m_strSelectValue + "','" + strAccessibleProjectIDs + "'"
        strSQL = "usp_sel_OutLookConfigurationDetails " + m_intUserID.ToString + ",'" + m_strEntityIDs + "','" + strAccessibleProjectIDs + "'," + m_strCopy + ",1"
        dr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)


        Dim dtNow As DateTime = DateTime.Now

        sbICSFile.AppendLine("BEGIN:VCALENDAR")
        sbICSFile.AppendLine("PRODID:-//Microsoft Corporation//Outlook 9.0 MIMEDIR//EN")
        sbICSFile.AppendLine("VERSION:2.0")
        sbICSFile.AppendLine("METHOD:PUBLISH")


        'for task
        While dr.Read()
            bln = True
            StartDate = CommonFunction.Data.CheckIsDBNull(dr("StartDate"), "")
            EndDate = CommonFunction.Data.CheckIsDBNull(dr("EndDate"), "")
            EntityName = CommonFunction.Data.CheckIsDBNull(dr("TaskName"), "")
            ProjectName = CommonFunction.Data.CheckIsDBNull(dr("ProjectName"), "")
            strStatus = CommonFunction.Data.CheckIsDBNull(dr("Status"), "")
            sbICSFile.AppendLine("BEGIN:VEVENT")
            sbICSFile.AppendLine("ORGANIZER:MAILTO:")

            If strStatus.ToUpper = "START" Then
                str = "Starts on " + StartDate
            End If

            If strStatus.ToUpper = "DUE" Then
                str = "due on " + EndDate
            End If

            If strStatus.ToUpper = "START AND DUE" Then
                str = "Starts on " + StartDate + " and Due on " + EndDate
            End If

            sbICSFile.Append("DTSTART:" + StartDate.Year.ToString())
            sbICSFile.Append(FormatDateTimeValue(StartDate.Month))
            sbICSFile.Append(FormatDateTimeValue(StartDate.Day) + "T")
            'set startDate hour as 09 i.e. 9 am
            sbICSFile.AppendLine("090000Z")
            'sbICSFile.Append(FormatDateTimeValue(StartDate.Hour))
            'sbICSFile.AppendLine(FormatDateTimeValue(StartDate.Minute) + "00Z")

            sbICSFile.Append("DTEND:" + EndDate.Year.ToString())
            sbICSFile.Append(FormatDateTimeValue(EndDate.Month))
            sbICSFile.Append(FormatDateTimeValue(EndDate.Day) + "T")
            'EndDate hour will be set as val of intEndTime
            sbICSFile.Append(intEndTime)
            sbICSFile.AppendLine("0000Z")
            'sbICSFile.Append(FormatDateTimeValue(EndDate.Hour))
            'sbICSFile.AppendLine(FormatDateTimeValue(EndDate.Minute) + "00Z")

            sbICSFile.AppendLine("TRANSP:OPAQUE")
            sbICSFile.AppendLine("SEQUENCE:0")
            sbICSFile.AppendLine("UID:040000008200E00074C5B7101A82E00800000000100D1FE025F3C801000000000000000010000000240BB0220A12AD4F8DB9997FF50F6622")

            sbICSFile.Append("DTSTAMP:" + dtNow.Year.ToString())
            sbICSFile.Append(FormatDateTimeValue(dtNow.Month))
            sbICSFile.Append(FormatDateTimeValue(dtNow.Day) + "T")
            sbICSFile.Append(FormatDateTimeValue(dtNow.Hour))
            sbICSFile.AppendLine(FormatDateTimeValue(dtNow.Minute) + "00")

            sbICSFile.Append("DESCRIPTION:" + EntityName)
            sbICSFile.AppendLine(":" + str)
            sbICSFile.AppendLine("SUMMARY:Task:" + ProjectName + ":" + EntityName)
            sbICSFile.AppendLine("PRIORITY:5")
            sbICSFile.AppendLine("CLASS:PUBLIC")
            sbICSFile.AppendLine("BEGIN:VALARM")
            sbICSFile.AppendLine("TRIGGER:PT2D")
            sbICSFile.AppendLine("ACTION:DISPLAY")
            sbICSFile.AppendLine("DESCRIPTION:Reminder")
            sbICSFile.AppendLine("END:VALARM")
            sbICSFile.AppendLine("END:VEVENT")
        End While

        'for Milestone
        If dr.NextResult Then
            While dr.Read()
                bln = True
                StartDate = CommonFunction.Data.CheckIsDBNull(dr("PlannedCompletionDate"), "")
                EndDate = CommonFunction.Data.CheckIsDBNull(dr("ActualCompletionDate"), "")
                EntityName = CommonFunction.Data.CheckIsDBNull(dr("MileStone"), "")
                ProjectName = CommonFunction.Data.CheckIsDBNull(dr("ProjectName"), "")
                strStatus = CommonFunction.Data.CheckIsDBNull(dr("Status"), "")

                If strStatus.ToUpper = "START" Then
                    str = "Starts on " + StartDate
                End If

                If strStatus.ToUpper = "DUE" Then
                    str = "due on " + EndDate
                End If

                If strStatus.ToUpper = "START AND DUE" Then
                    str = "Starts on " + StartDate + " and Due on " + EndDate
                End If

                sbICSFile.AppendLine("BEGIN:VEVENT")
                sbICSFile.AppendLine("ORGANIZER:MAILTO:")

                sbICSFile.Append("DTSTART:" + StartDate.Year.ToString())
                sbICSFile.Append(FormatDateTimeValue(StartDate.Month))
                sbICSFile.Append(FormatDateTimeValue(StartDate.Day) + "T")
                sbICSFile.AppendLine("090000Z")

                sbICSFile.Append("DTEND:" + EndDate.Year.ToString())
                sbICSFile.Append(FormatDateTimeValue(EndDate.Month))
                sbICSFile.Append(FormatDateTimeValue(EndDate.Day) + "T")
                sbICSFile.Append(intEndTime)
                sbICSFile.AppendLine("0000Z")

                sbICSFile.AppendLine("TRANSP:OPAQUE")
                sbICSFile.AppendLine("SEQUENCE:0")
                sbICSFile.AppendLine("UID:040000008200E00074C5B7101A82E00800000000100D1FE025F3C801000000000000000010000000240BB0220A12AD4F8DB9997FF50F6622")
                sbICSFile.Append("DTSTAMP:" + dtNow.Year.ToString())
                sbICSFile.Append(FormatDateTimeValue(dtNow.Month))
                sbICSFile.Append(FormatDateTimeValue(dtNow.Day) + "T")
                sbICSFile.Append(FormatDateTimeValue(dtNow.Hour))
                sbICSFile.AppendLine(FormatDateTimeValue(dtNow.Minute) + "00")

                sbICSFile.Append("DESCRIPTION:" + EntityName)
                sbICSFile.AppendLine(":" + str)
                sbICSFile.AppendLine("SUMMARY:MileStone:" + ProjectName + ":" + EntityName)
                sbICSFile.AppendLine("PRIORITY:5")
                sbICSFile.AppendLine("CLASS:PUBLIC")
                sbICSFile.AppendLine("BEGIN:VALARM")
                sbICSFile.AppendLine("TRIGGER:PT2D")
                sbICSFile.AppendLine("ACTION:DISPLAY")
                sbICSFile.AppendLine("DESCRIPTION:Reminder")
                sbICSFile.AppendLine("END:VALARM")
                sbICSFile.AppendLine("END:VEVENT")
            End While
            'End If
        End If

        'for Deliverable
        If dr.NextResult Then
            While dr.Read()
                bln = True
                StartDate = CommonFunction.Data.CheckIsDBNull(dr("StartDate"), "")
                EndDate = CommonFunction.Data.CheckIsDBNull(dr("EarliestStartDate"), "")
                EntityName = CommonFunction.Data.CheckIsDBNull(dr("Title"), "")
                ProjectName = CommonFunction.Data.CheckIsDBNull(dr("ProjectName"), "")
                strStatus = CommonFunction.Data.CheckIsDBNull(dr("Status"), "")

                If strStatus.ToUpper = "START" Then
                    str = "Starts on " + StartDate
                End If

                If strStatus.ToUpper = "DUE" Then
                    str = "due on " + EndDate
                End If

                If strStatus.ToUpper = "START AND DUE" Then
                    str = "Starts on " + StartDate + " and Due on " + EndDate
                End If

                sbICSFile.AppendLine("BEGIN:VEVENT")
                sbICSFile.AppendLine("ORGANIZER:MAILTO:")

                sbICSFile.Append("DTSTART:" + StartDate.Year.ToString())
                sbICSFile.Append(FormatDateTimeValue(StartDate.Month))
                sbICSFile.Append(FormatDateTimeValue(StartDate.Day) + "T")
                sbICSFile.AppendLine("090000Z")

                sbICSFile.Append("DTEND:" + EndDate.Year.ToString())
                sbICSFile.Append(FormatDateTimeValue(EndDate.Month))
                sbICSFile.Append(FormatDateTimeValue(EndDate.Day) + "T")
                sbICSFile.Append(intEndTime)
                sbICSFile.AppendLine("0000Z")

                sbICSFile.AppendLine("TRANSP:OPAQUE")
                sbICSFile.AppendLine("SEQUENCE:0")
                sbICSFile.AppendLine("UID:040000008200E00074C5B7101A82E00800000000100D1FE025F3C801000000000000000010000000240BB0220A12AD4F8DB9997FF50F6622")
                sbICSFile.Append("DTSTAMP:" + dtNow.Year.ToString())
                sbICSFile.Append(FormatDateTimeValue(dtNow.Month))
                sbICSFile.Append(FormatDateTimeValue(dtNow.Day) + "T")
                sbICSFile.Append(FormatDateTimeValue(dtNow.Hour))
                sbICSFile.AppendLine(FormatDateTimeValue(dtNow.Minute) + "00")

                sbICSFile.Append("DESCRIPTION:" + EntityName)
                sbICSFile.AppendLine(":" + str)
                sbICSFile.AppendLine("SUMMARY:Deliverable:" + ProjectName + ":" + EntityName)
                sbICSFile.AppendLine("PRIORITY:5")
                sbICSFile.AppendLine("CLASS:PUBLIC")
                sbICSFile.AppendLine("BEGIN:VALARM")
                sbICSFile.AppendLine("TRIGGER:PT2D")
                sbICSFile.AppendLine("ACTION:DISPLAY")
                sbICSFile.AppendLine("DESCRIPTION:Reminder")
                sbICSFile.AppendLine("END:VALARM")
                sbICSFile.AppendLine("END:VEVENT")
            End While
        End If

        If bln = False Then
            'Dim strScript As System.Text.StringBuilder
            CommonFunction.General.WriteHTML("<input type=hidden name=hidEntityIDs id=hidEntityIDs value=" + m_strEntityIDs + ">" + vbCrLf)
            CommonFunction.General.WriteHTML("<Script Language=JavaScript>")
            'CommonFunction.General.WriteHTML("alert('There are no items to import');")
            CommonFunction.General.WriteHTML("if(confirm('There are no items to import.Calender entries are already created in your outlook.Do you want to create copy?'))")
            CommonFunction.General.WriteHTML("{")
            CommonFunction.General.WriteHTML("window.open('PM_OutlookIntegration.aspx?Action=INTEGRATENOW&Copy=1&EntityIds=" + m_strEntityIDs + "','_self');")
            CommonFunction.General.WriteHTML("}else {")
            CommonFunction.General.WriteHTML("window.close();}")
            CommonFunction.General.WriteHTML("</Script>")
            bln = True
            Return
            'CommonFunction.General.WriteHTML
        End If
        CommonFunction.Data.DisposeDataReader(dr)
        sbICSFile.AppendLine("END:VCALENDAR")

        'Dim w As System.IO.StreamWriter = New System.IO.StreamWriter(Server.MapPath("../../Reports/CalendarEvent1.ics"))
        'w.WriteLine(sbICSFile)
        'w.Dispose()
        'w.Close()
        'Response.Redirect("../CRW/CRW_ReportExport.aspx?FileName=" + CommonFunctions.General.EncryptString(CommonFunctions.General.EncryptString("CalendarEvent1.ics")))

        '***
        Dim iStream As System.IO.Stream
        Dim buffer(10000) As Byte
        Dim length As Integer
        Dim dataToRead As Long
        Dim strFilePath As String = ""
        Response.Clear()
        Response.ContentType = "text/calendar"
        strFilePath = Server.MapPath("..\..\Reports\CalendarEvent1.ics")
        Response.AddHeader("Content-Disposition", "attachment;filename=CalendarEvent1.ics") '***********
        iStream = New System.IO.FileStream(strFilePath, System.IO.FileMode.Open, IO.FileAccess.Read, IO.FileShare.Read)
        dataToRead = iStream.Length
        While dataToRead > 0
            If Response.IsClientConnected Then
                length = iStream.Read(buffer, 0, 10000)
                Response.OutputStream.Write(buffer, 0, length)
                Response.Flush()

                ReDim buffer(10000)
                dataToRead = dataToRead - length
            Else
                dataToRead = -1
            End If
        End While
        If IsNothing(iStream) = False Then
            iStream.Close()
            iStream = Nothing
        End If
        '***
    End Sub
    Protected Function FormatDateTimeValue(ByVal DateValue As Int16) As String
        If DateValue < 10 Then
            Return "0" + DateValue.ToString()
        Else
            Return DateValue.ToString()
        End If
    End Function
End Class