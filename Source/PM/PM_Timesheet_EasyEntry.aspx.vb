
'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  PbNITE
' Module Name           :  RT_ProductivityMetricData.aspx
' Purpose               :  
' Description           :  
' Dependencies          :  None
' Author                :  PrashantD
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
Imports System.Globalization
#End Region

Public Class PM_Timesheet_EasyEntry
    Inherits WebPages.Template.WhizTemplate
#Region "Variables"
#Region "Private"
    Dim WithEvents objGrid As New AdvancedGrid

    Dim m_strUserName As String = ""
    Dim m_strGroupDate As String = ""
    Dim m_strEntryDate As String = ""
    Dim m_GroupTotal As Double = 0
    Dim m_intGroupNumber As Int32 = -1
    Dim strRoleID_Filter As String = "null"
    Dim strEmployeeID_Filter As String = "null"
    Dim str_FromDate_Filter As String = ""
    Dim str_ToDate_Filter As String = ""
    Dim strTimeSheetIDs As String = ""
    Dim blnIsDeletionSP_fired As Boolean = False

    Private strJavafun_SendXMLHTTP As String = "SendXMLHTTP_Save"
    Private WithEvents objMenu As New WebPage.Templates.StaticMenu
#End Region
#Region "Protected"
    Protected strTimeSheetID As String = ""
    Protected IsXMLHTTP_Off As Boolean = False
    Protected MinHoursForDAEntry As String = "0.25"

    'Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
    Protected RestrictByMinHours As String = ""
    'End Of Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change

    '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
    Protected m_strToken_PMTimesheet As String
    Protected m_FromWhere As String
    'shraddhaM
    Protected HiddenContolName As String
    'End ShraddhaM
    '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197    


#Region "Constants"
    Protected strJavafun_Description As String = "Description_onChange"
    Protected strJavafun_Act As String = "ActualWork_onChange"
    Protected strJavafun_Wsr As String = "WSR_onChange"
    Protected strJavafun_Delete As String = "Delete_onChange"
    'Added By SujataK on 21 June 2006 
    Protected strJavafun_Total As String = "TotalWork_onChange"
    'End of Addition By SujataK on 21 June 2006


#End Region
#End Region

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
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        'if query String has xmlHttp=1 means browser supports xmlHttp.
        'if query String has fromXML=1 means request is xmlHttp type..
        'Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.ApplySecurity(True)
        'End Of Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        If (Request.QueryString("xmlhttp") & "" = "1") Or (Request.QueryString("FromXML") & "" = "1") Or (Request.Form("hidxmlhttp") & "" = "1") Then
            IsXMLHTTP_Off = False
        Else
            IsXMLHTTP_Off = True
        End If
    End Sub
    Protected Sub WritePage()

        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : to check request action. 
        ' Description           : if request is xmlHttp, call SaveXML method.
        '                         if request is not xmlHttp, plot page and 
        '                                Save the data if Action = SAVE  
        '                                Delete record if Action = DELETE   
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantD
        ' Created               : 24 May 2006
        ' Revisions             :
        '=====================================================================

        'Setting javascript functions of control depends upon IsXMLHTTP_Off
        If IsXMLHTTP_Off = False Then
            strJavafun_Description = strJavafun_SendXMLHTTP
            strJavafun_Act = strJavafun_SendXMLHTTP
            strJavafun_Wsr = strJavafun_SendXMLHTTP
            ' Added By SujataK on 21 June 2006
            strJavafun_Total = strJavafun_SendXMLHTTP
            ' End of Addition By SujataK on 21 June 2006
        End If


        If CType(Session("intProjectID"), String) & "" = "" Then
            Response.Clear()
            Response.Write("<HTML><BODY></BODY></SCRIPT>alert('session has expired');window.close();</SCRIPT></HTML>")
            Response.End()
        End If
        If (Request.QueryString("FromXML") & "").Trim <> "1" Or IsXMLHTTP_Off = True Then

            If IsXMLHTTP_Off = True Then
                CommonFunction.General.WriteHTML("<input type=hidden name=hidxmlhttp id=hidxmlhttp value=0 >")
            Else
                CommonFunction.General.WriteHTML("<input type=hidden name=hidxmlhttp id=hidxmlhttp value=1 >")
            End If
            'set MinHoursForDAEntry
            MinHoursForDAEntry = CType(CommonFunction.Data.GetDataScalar("select MinHoursForDAEntry from tbl_PM_CompanyInformation", MyBase.UseSQL), String).Trim

            'Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
            'set RestrictByMinHours
            RestrictByMinHours = CType(CommonFunction.Data.GetDataScalar("select RestrictByMinHours from tbl_PM_CompanyInformation", MyBase.UseSQL), String).Trim
            'End Of Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change

            If Request.Form("cboRole") & "" <> "" Then
                strRoleID_Filter = Request.Form("cboRole")
            End If
            If Request.Form("cboResource") & "" <> "" Then
                strEmployeeID_Filter = Request.Form("cboResource")
            End If
            If Request.Form("txtFromDate") & "" <> "" Then
                str_FromDate_Filter = Request.Form("txtFromDate")
            End If
            If Request.Form("txtToDate") & "" <> "" Then
                str_ToDate_Filter = Request.Form("txtToDate")
            End If


            strTimeSheetID = Request.QueryString("TimeSheetID") & ""

            If (Request.QueryString("Action") & "").ToUpper = "DELETE" Then
                DeleteData()
            ElseIf (Request.QueryString("Action") & "").ToUpper = "SAVE" Then  'And IsXMLHTTP_Off = True
                SaveData()
            End If


            CommonFunction.General.WriteHTML("<BR>")
            CommonFunction.General.WriteHTML(DrawMenu()) 'Top menu
            CommonFunction.General.WriteHTML("<BR>")
            DrawPageCaption()
            CommonFunction.General.WriteHTML("<BR>")
            DrawPageFilters()
            CommonFunction.General.WriteHTML("<BR>")

            '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
            If Request.QueryString("PKToken") <> "" Then
                m_strToken_PMTimesheet = Request.QueryString("PKToken")
                HttpContext.Current.Session("TimeSheetID") = strTimeSheetID
            Else
                strTimeSheetID = CType(HttpContext.Current.Session("TimeSheetID"), String)
                m_strToken_PMTimesheet = CommonFunctions.Security.Token.GetToken(strTimeSheetID + CType(Session("UserID"), String) + "0" + "1049")
            End If
            '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

            DrawGrid()
            CommonFunction.General.WriteHTML("<BR>")
            CommonFunction.General.WriteHTML("<BR>")
            CommonFunction.General.WriteHTML(DrawMenu()) 'Bottom menu
            CommonFunction.General.WriteHTML("<BR>")

            If CommonFunction.General.CheckIsNothing(m_strToken_PMTimesheet, "0") = "0" Then
                m_strToken_PMTimesheet = Request.Form("txtPKToken").ToString
            End If

            '' START : Added By ParagD On 14-Sept-2006 : Security Issue 6197   
            If (Trim(m_strToken_PMTimesheet & "") = "" And CommonFunctions.Security.Token.ValidateToken(strTimeSheetID + CType(Session("intUserID"), String) + "0" + "1049", m_strToken_PMTimesheet) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Project Timesheet Easy Edit", 0, 0, "Timesheet No", strTimeSheetID)
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
            '' END : Added By ParagD On 14-Sept-2006 : Security Issue 6197

            If blnIsDeletionSP_fired = True Then
                CommonFunction.General.WriteHTML("<script>alert('Selected task(s) deleted successfully');</script>")
            End If

        Else
            SaveData_XML()
        End If
    End Sub
    'Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
    <System.Web.Services.WebMethod()>
    Public Shared Function getDecimalHours(ByVal HMHours As String) As String
        Try
            Dim fltHours As Decimal

            If HMHours = "0" Or HMHours = "" Then
                HMHours = "00:00"
            End If

            If HMHours.IndexOf(":") = HMHours.Length - 1 Then
                HMHours = HMHours + "00"
            End If

            Dim strDecimal As String = ""
            Dim strBeforeDecimal As String = ""
            strBeforeDecimal = HMHours.Substring(0, HMHours.IndexOf(":"))
            strDecimal = HMHours.Substring(HMHours.IndexOf(":") + 1, 2)
            HMHours = strBeforeDecimal + ":" + strDecimal

            fltHours = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + HMHours + "',2)", True)

            Return fltHours.ToString()
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    'End Of Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
    Private Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : DrawGrid()	
        ' Purpose               : to plot grid. 
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantD
        ' Created               : 24 May 2006
        ' Revisions             :
        '=====================================================================


        Dim strTimeSheetIDs_seperator As String
        Dim strTempHold As String
        Dim dr As IDataReader
        Dim strTRClass As String = "'clsTREven'"
        Dim count_hidTimeSheetControls As Int32 = 1
        Dim strHiddenName As String = ""
        Dim SQL As String = "usp_Sel_TimeSheetForGivenTimeSheetNo_EasyEntry " + strTimeSheetID + "," + strRoleID_Filter + "," + strEmployeeID_Filter
        If str_FromDate_Filter = "" Then
            SQL += ",null"
        Else
            SQL += ",'" + str_FromDate_Filter + "'"
        End If
        If str_ToDate_Filter = "" Then
            SQL += ",null"
        Else
            SQL += ",'" + str_ToDate_Filter + "'"
        End If

        ''Plotting DIV DIVSTYLE AND TABLE STYLE

        CommonFunction.General.WriteHTML("<DIV Id=divListPageTag Style=""HEIGHT:465px;OVERFLOW:auto; WIDTH:100%"">")
        CommonFunction.General.WriteHTML("<DIV id=DivListTag style='Overflow:scroll;width=100%;Height:465px;z-index=2;' >")
        CommonFunction.General.WriteHTML("<STYLE type=text/css>")
        CommonFunction.General.WriteHTML("{TABLE ")
        CommonFunction.General.WriteHTML("{TABLE-LAYOUT: fixed;}")
        CommonFunction.General.WriteHTML("THEAD TH.divListTag {POSITION: relative;}")
        CommonFunction.General.WriteHTML("THEAD TH.divListTag.locked {POSITION: relative;}")
        CommonFunction.General.WriteHTML("THEAD TH.divListTag {Z-INDEX: 10; ; TOP:expression(document.getElementById('divListTag').scrollTop -1)}")
        CommonFunction.General.WriteHTML("THEAD TH.divListTag.locked {Z-INDEX: 30}")
        CommonFunction.General.WriteHTML("TH.divListTag.locked {Z-INDEX: 10; ; LEFT:expression(document.getElementById('divListTag').scrollLeft); POSITION:relative()}")
        CommonFunction.General.WriteHTML("}")
        CommonFunction.General.WriteHTML("</STYLE>")
        CommonFunction.General.WriteHTML("")
        CommonFunction.General.WriteHTML("")
        CommonFunction.General.WriteHTML("")
        CommonFunction.General.WriteHTML("")
        CommonFunction.General.WriteHTML("")


        'End of plotting style and div


        'Column headers


        CommonFunction.General.WriteHTML("<TABLE class='clsGridTable' cellpadding=0 cellspacing=1 width='100%' ID=""Table4"">")
        CommonFunction.General.WriteHTML("<THEAD class='clsTRColumnHeader'>")
        CommonFunction.General.WriteHTML("<TH class='divListTag' align=left width=4%>Employee Name</TH>")
        CommonFunction.General.WriteHTML("<TH class='divListTag' align=left width=4%>Date</TH>")
        CommonFunction.General.WriteHTML("<TH class='divListTag' align=left width=30%>Task Name</TH>")
        CommonFunction.General.WriteHTML("<TH class='divListTag' align=right width=4% >Work [Hrs]</TH>")
        CommonFunction.General.WriteHTML("<TH class='divListTag' align=left width=50%>Description</TH>")
        CommonFunction.General.WriteHTML("<TH class='divListTag' align=right width=4%>Actual Work [Hrs]</TH>")
        CommonFunction.General.WriteHTML("<TH class='divListTag' align=centre width=2%>WSR</TH>")
        CommonFunction.General.WriteHTML("<TH class='divListTag' align=centre width=2%>Delete</TH>")
        CommonFunction.General.WriteHTML("</THEAD>")

        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197 
        Response.Write("<TD>")

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_strToken_PMTimesheet, , , , , , , , , , , , True, , EnableHTMLEncode:=True)
        '''End of Modification by Dhanashri S on 7 Oct 2015 

        Response.Write("</TD>")
        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197  




        If strTimeSheetID & "" <> "" Then
            dr = CommonFunction.Data.GetDataReader(SQL, MyBase.UseSQL)
        Else
            Response.End()
        End If

        While dr.Read


            'Employee Row
            If m_strUserName = "" Or m_strUserName <> dr("EmployeeName").ToString Then
                'Summary by Employee
                If m_strUserName <> "" Then
                    CommonFunction.General.WriteHTML("<TR class='clsTRColumnHeader'>")
                    CommonFunction.General.WriteHTML("<TD align='right' colspan=5>")
                    CommonFunction.General.WriteHTML("Total Actual Work(hrs) for " + m_strUserName)
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("<TD align='right'>")
                    'Commented And Added By Usha Pandit On 15.02.2021 Purpose::Whizible 2 Work field change
                    'CommonFunction.General.WriteHTML(m_GroupTotal.ToString)
                    CommonFunction.General.WriteHTML(CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_GroupTotal.ToString + "',1)", True))
                    'End Of Added By Usha Pandit On 15.02.2021 Purpose::Whizible 2 Work field change
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("<TD></TD><TD></TD>")
                    CommonFunction.General.WriteHTML("</TR>")
                    m_GroupTotal = 0

                    strHiddenName = "hidTimesheetIDs" + (count_hidTimeSheetControls - 1).ToString
                    CommonFunction.General.WriteHTML("<input type=hidden name=" + strHiddenName + " id=" + strHiddenName + " value='" + strTimeSheetIDs_seperator + "' >")
                    strTimeSheetIDs_seperator = ""
                End If

                CommonFunction.General.WriteHTML("<TR class='clsTRSectionHeader'>")
                CommonFunction.General.WriteHTML("<TD align='left' colspan=8>")
                CommonFunction.General.WriteHTML(dr("EmployeeName").ToString)
                'Modified by PrajaktaR on 16th June 2006 for Bristlecone IssueID 4226
                'CommonFunction.General.WriteHTML("&nbsp;&nbsp;&nbsp; <A class='Menu' style='' HREF=""Javascript:editAll_onClick(" + count_hidTimeSheetControls.ToString + ")"" Title='Multiedit for resource' >Multi_Edit</A> </TD>")
                CommonFunction.General.WriteHTML("&nbsp;&nbsp;&nbsp; <A HREF=""Javascript:editAll_onClick(" + count_hidTimeSheetControls.ToString + ")"" Title='Multi Edit for Resource' >Multi_Edit</A> </TD>")
                'Modified by PrajaktaR on 16th June 2006 for Bristlecone IssueID 4226

                'CommonFunction.General.WriteHTML("<TD align='left' colspan=5><input type=button value='Edit All' id=btnEditAll name=btnEditAll onclick=editAll_onClick(" + count_hidTimeSheetControls.ToString + ") </TD>")

                m_strGroupDate = ""
                CommonFunction.General.WriteHTML("</TR>")

                count_hidTimeSheetControls += 1
            End If
            If m_strGroupDate = "" Or m_strGroupDate <> CommonFunction.Dates.CGetDate(CType(dr("EntryDate"), Date)) Then
                m_strUserName = dr("EmployeeName").ToString
                'Date Row
                CommonFunction.General.WriteHTML("<TR class='clsTRGroupHeader'>")
                CommonFunction.General.WriteHTML("<TD></TD>")
                CommonFunction.General.WriteHTML("<TD align='left' colspan=7>")
                CommonFunction.General.WriteHTML(CommonFunction.Dates.CGetDate(CType(dr("EntryDate"), Date)))
                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("</TR>")
                strTRClass = "'clsTREven'"
            End If
            m_strGroupDate = CommonFunction.Dates.CGetDate(CType(dr("EntryDate"), Date))


            strTimeSheetIDs_seperator += dr("TimeSheetID").ToString + ","
            'Task Name and folder image
            If strTRClass = "'clsTREven'" Then
                strTRClass = "'clsTROdd'"
            Else
                strTRClass = "'clsTREven'"
            End If
            CommonFunction.General.WriteHTML("<TR class=" + strTRClass + " onclick=PlotControls(" + dr("TimeSheetID").ToString + ")>")
            CommonFunction.General.WriteHTML("<TD colspan=2 align=center > <img title='Click to edit' id=folderimg" + dr("TimeSheetID").ToString + " src='../../Images/TreeNodeImages/folder.gif' align=absmiddle  height=15> </TD>")
            CommonFunction.General.WriteHTML("<TD align='left'> ")
            CommonFunction.General.WriteHTML(dr("TaskName").ToString)
            CommonFunction.General.WriteHTML("</TD>")

            'Planned Work
            CommonFunction.General.WriteHTML("<TD align='right' width=5%> ")
            CommonFunction.General.WriteHTML(dr("PlannedWork").ToString)
            CommonFunction.General.WriteHTML("</TD>")

            'Descritpion
            strTempHold = dr("Description").ToString
            strTempHold = strTempHold.Replace("""", "&quot;")
            CommonFunction.General.WriteHTML("<TD align='left' id=TDDes" + dr("TimeSheetID").ToString + "> ")
            'Commented and Modified by JyotiG
            'Start_JG_11229_23-Mar-2007
            'Issue : Project -&gt; Project Timesheet -&gt; Open a PT in edit mode. Click on the link 
            'Easy Edit'. The column 'Description' is a text area. Enter a description with 
            'Enter newline Values. AFter saving it, data does not get saved with newline values.
            'CommonFunction.General.WriteHTML("<LABEL id=lblDes" + dr("TimeSheetID").ToString + ">" + strTempHold + " </LABEL>")
            ''Commented and added by Yogesh J on 22-Jan-2016
            'CommonFunction.General.WriteHTML("<LABEL id=lblDes" + dr("TimeSheetID").ToString + "><pre>" + strTempHold + " </pre></LABEL>")
            CommonFunction.General.WriteHTML("<LABEL id=lblDes" + dr("TimeSheetID").ToString + "><p>" + strTempHold + " </p></LABEL>")
            ''End of comment by Yogesh J on 22-jan-2016
            'End_JG_11229_23-Mar-2007
            'CommonFunction.General.WriteHTML("<INPUT TYPE=hidden id=hidLblDes" + dr("TimeSheetID").ToString + " value=""" + strTempHold + """ >")
            CommonFunction.General.WriteHTML("</TD>")

            'Actual Work[Hrs]
            CommonFunction.General.WriteHTML("<TD align='right' width=5% id=TDAct" + dr("TimeSheetID").ToString + "> ")
            'Commented And Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
            CommonFunction.General.WriteHTML("<LABEL id=lblAct" + dr("TimeSheetID").ToString + ">" + dr("Duration").ToString + " </LABEL>")
            'CommonFunction.General.WriteHTML("<LABEL id=lblAct" + dr("TimeSheetID").ToString + ">" + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + CommonFunctions.Data.CheckIsDBNull(dr("Duration").ToString, "0") + "',2)", True) + " </LABEL>")
            'End Of Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
            'CommonFunction.General.WriteHTML("<INPUT TYPE=hidden  id=hidLblAct" + dr("TimeSheetID").ToString + " value=""" + dr("Duration").ToString + """ >")
            CommonFunction.General.WriteHTML("</TD>")
            'Commented And Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
            'm_GroupTotal += CType(dr("Duration"), Double)
            m_GroupTotal += CType(CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + CommonFunctions.Data.CheckIsDBNull(dr("Duration").ToString, "0") + "',2)", True), Double)
            'End Of Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
            'WSR
            CommonFunction.General.WriteHTML("<TD align='center' id=TDWsr" + dr("TimeSheetID").ToString + "> ")
            CommonFunction.General.WriteHTML("<LABEL id=lblWsr" + dr("TimeSheetID").ToString + ">" + dr("WeeklyStatusEntry").ToString + " </LABEL>")
            'CommonFunction.General.WriteHTML("<INPUT TYPE=hidden id=hidLblWsr" + dr("TimeSheetID").ToString + " value=""" + dr("WeeklyStatusEntry").ToString + """ >")
            CommonFunction.General.WriteHTML("</TD>")

            'Delete
            CommonFunction.General.WriteHTML("<TD align='center' id=TDDel" + dr("TimeSheetID").ToString + "> ")
            CommonFunction.General.WriteHTML("")
            CommonFunction.General.WriteHTML("</TD>")

            CommonFunction.General.WriteHTML("</TR>")



            CommonFunction.General.WriteHTML("<input type=hidden name=hidDel" + dr("TimeSheetID").ToString + " id=hidDel" + dr("TimeSheetID").ToString + ">")
            ' Added By SujataK On 21 june 2006
            Dim drDate As Date = CType(dr("EntryDate"), Date)
            Dim strDate As String
            strDate = drDate.ToString("dd-MMM-yyyy").TrimEnd

            HiddenContolName = "hidHrs_" + dr("EmployeeID").ToString + "_" + strDate
            'CommonFunction.General.WriteHTML("<input type=hidden name=hidHrs_" + dr("TimeSheetID").ToString + " id=hidHrs_" + dr("TimeSheetID").ToString + " value = " + dr("Duration").ToString + " >")
            'Commented And Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
            'CommonFunction.General.WriteHTML("<input type=hidden name=hidHrs_" + dr("EmployeeID").ToString + "_" + strDate + " id=hidHrs_" + dr("TimeSheetID").ToString + " value = " + dr("Duration").ToString + " >")
            CommonFunction.General.WriteHTML("<input type=hidden name=hidHrs_" + dr("EmployeeID").ToString + "_" + strDate + " id=hidHrs_" + dr("TimeSheetID").ToString + " value = " + CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + CommonFunctions.Data.CheckIsDBNull(dr("Duration").ToString, "0") + "',2)", True) + " >")
            'End Of Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
            ' End of Addition By SujataK On 21 june 2006



        End While

        CommonFunction.Data.DisposeDataReader(dr)

        If m_strUserName <> "" Then
            CommonFunction.General.WriteHTML("<TR class='clsTRColumnHeader'>")
            CommonFunction.General.WriteHTML("<TD align='right' colspan=5>")
            CommonFunction.General.WriteHTML("Total Actual Work(hrs) for " + m_strUserName)
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("<TD align='right'>")
            'Commented And Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
            'CommonFunction.General.WriteHTML(m_GroupTotal.ToString)
            CommonFunction.General.WriteHTML(CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + m_GroupTotal.ToString + "',1)", True))
            'End Of Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("<TD></TD><TD></TD>")
            CommonFunction.General.WriteHTML("</TR>")
            m_GroupTotal = 0

            strHiddenName = "hidTimesheetIDs" + (count_hidTimeSheetControls - 1).ToString
            CommonFunction.General.WriteHTML("<input type=hidden name=" + strHiddenName + " id=" + strHiddenName + " value='" + strTimeSheetIDs_seperator + "' >")
            strTimeSheetIDs_seperator = ""
        End If

        CommonFunction.General.WriteHTML("<input type=hidden name=hid_Total_TS_Ctrls id=hid_Total_TS_Ctrls value=" + (count_hidTimeSheetControls - 1).ToString + ">")
        CommonFunction.General.WriteHTML("</TABLE></DIV></DIV>")

    End Sub
    Private Sub DrawPageFilters()
        '=====================================================================
        ' Procedure Name        : DrawPageFilters()	
        ' Purpose               : to plot page filters
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantD
        ' Created               : 24 May 2006
        ' Revisions             :
        '=====================================================================


        CommonFunction.General.WriteHTML("<input type=hidden name=hidFilterDivStatus id=hidFilterDivStatus value='Open' />")
        CommonFunction.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href='Javascript:showHide_div()'><Img Border=0 id=imgShowHide Src='../../Images/minus.gif' title=''></A>&nbsp;&nbsp; Filters </TD></TR></TABLE>")
        CommonFunction.General.WriteHTML("<DIV id='FliterShow' name='FliterShow' height=20 style""'overflow:auto;display:''"">")
        CommonFunction.General.WriteHTML("<TABLE  cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunction.General.WriteHTML("<TD align='right' >Role</TD><TD align='left' >")
        CommonFunction.HTMLControls.DrawComboBox("cboRole", "usp_Sel_TimeSheetForGivenTimeSheetNo_EasyEntry_PageFilter " + strTimeSheetID + ",2," + strEmployeeID_Filter, 200, strRoleID_Filter, "onchange=filterChange()", True)
        CommonFunction.General.WriteHTML("</TD><TD align='right'>Employee Name</TD><TD align='left' >")

        CommonFunction.HTMLControls.DrawComboBox("cboResource", "usp_Sel_TimeSheetForGivenTimeSheetNo_EasyEntry_PageFilter " + strTimeSheetID + ",1," + strRoleID_Filter, 200, strEmployeeID_Filter, "onchange=filterChange()", True)
        CommonFunction.General.WriteHTML("</TD><TD></TD>")
        CommonFunction.General.WriteHTML("</TR><TR class='clsTREven'>")
        CommonFunction.General.WriteHTML("<TD align='right' >From Date </TD><TD align='left' >")
        'CommonFunction.HTMLControls.DrawDateControl("dtFrom", "dtFrom", , , , , "frmTimeSheetEasyEntry")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , 80, str_FromDate_Filter, , "frmTimeSheetEasyEntry", returnHTML:=True, IsMandatory:=False))
        CommonFunction.General.WriteHTML("</TD><TD align='right' >To Date </TD><TD align='left' >")
        'CommonFunction.HTMLControls.DrawDateControl("dtFrom", "dtFrom", , , , , "frmTimeSheetEasyEntry", , , , True)
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , 80, str_ToDate_Filter, , "frmTimeSheetEasyEntry", returnHTML:=True, IsMandatory:=False))
        CommonFunction.General.WriteHTML("</TD><TD><A class='Menu' style='' HREF=""Javascript:filterChange()"" Title='Show tasks between From date and To date' >|Show|</A><A class='Menu' style='' HREF=""Javascript:clearFilter()"" Title='Clear' >|Clear|</A></TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</Table>")
        CommonFunction.General.WriteHTML("</DIV>")

    End Sub
    Private Sub DrawPageCaption()
        '=====================================================================
        ' Procedure Name        : DrawPageCaption()	
        ' Purpose               : to plot page caption
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantD
        ' Created               : 24 May 2006
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim TimesheetStatus As String
        Dim strFromDate As String = ""
        Dim strToDate As String = ""

        Dim ID As String = ""
        If strTimeSheetID <> "" Then
            ID = " ID : " + strTimeSheetID + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
        End If

        dr = CommonFunction.Data.GetDataReader("SELECT TimesheetStatus,* FROM v_tbl_PM_TimeSheetInvoice WHERE TimesheetNo=" + strTimeSheetID, MyBase.UseSQL)
        If dr.Read Then
            If Not IsDBNull(dr("TimesheetStatus")) Then
                TimesheetStatus = CStr(dr("TimesheetStatus"))
            Else
                TimesheetStatus = "Generated"
            End If
            If Not IsDBNull(dr("FromDate")) Then
                strFromDate = CommonFunction.Dates.CGetDate(CType(dr("FromDate"), Date))
            Else
                strFromDate = ""
            End If
            If Not IsDBNull(dr("ToDate")) Then
                strToDate = CommonFunction.Dates.CGetDate(CType(dr("ToDate"), Date))
            Else
                strFromDate = ""
            End If

        End If
        CommonFunction.Data.DisposeDataReader(dr)
        CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, "Timesheet" + ID, "Status" + " : " + TimesheetStatus, , True) + vbCrLf)
        CommonFunction.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML("<TABLE  Width='100%' cellspacing=0 class=clsTable><TR class=clsTRPageHeader><TD align=Left>Project Timesheet for the period&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;From Date&nbsp;:&nbsp;" + strFromDate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To Date&nbsp;:&nbsp;" + strToDate + "</TD></TR></TABLE>")

    End Sub
    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : to plot menu
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantD
        ' Created               : 24 May 2006
        ' Revisions             :
        '=====================================================================
        Dim ArrTopMenuCaptionsList As New System.Collections.ArrayList
        Dim ArrTopMenuToolTipsList As New System.Collections.ArrayList
        Dim ArrTopMenuFunctionsList As New System.Collections.ArrayList

        ArrTopMenuCaptionsList.Add("Save")
        ArrTopMenuToolTipsList.Add("Save")
        ArrTopMenuFunctionsList.Add("Save_OnClick()")


        ArrTopMenuCaptionsList.Add("Delete")
        ArrTopMenuToolTipsList.Add("Delete tasks")
        ArrTopMenuFunctionsList.Add("Delete_OnClick()")



        ArrTopMenuCaptionsList.Add("Close")
        ArrTopMenuToolTipsList.Add("Close ")
        ArrTopMenuFunctionsList.Add("Close_OnClick()")

        ArrTopMenuCaptionsList.Add("?")
        ArrTopMenuToolTipsList.Add("Help ")
        ArrTopMenuFunctionsList.Add("Help_OnClick('EasyEntryTS')")

        Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
        Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
        Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String

        ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
        ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)
        ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)

        Return objMenu.DrawMenu(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True)

    End Function
    Private Sub SaveData_XML()
        '=====================================================================
        ' Procedure Name        : SaveData_XML()	
        ' Purpose               : to save data coming from xmlHttp request. and clear and end  response.
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantD
        ' Created               : 24 May 2006
        ' Revisions             :
        '=====================================================================
        Dim updateSQL As String = "UPDATE tbl_PM_TimeSheet SET "
        Dim strPK As String
        Dim strField As String

        strPK = Request.Params("ctrlID") & ""
        strField = strPK.Substring(3, 3)
        strPK = strPK.Substring(6)

        If strPK <> "" And (Request.Params("Value") & "") <> "" Then
            Select Case strField.ToUpper

                Case "DES"
                    updateSQL += "Description = '" + Request.Params("Value").Replace("'", "''") + "' where TimesheetID = " + strPK
                Case "ACT"
                    updateSQL += "Duration = '" + Request.Params("Value") + "' where TimesheetID = " + strPK
                Case "WSR"

                    updateSQL += "WeeklyStatusEntry = '" + Request.Params("Value") + "' where TimesheetID = " + strPK

            End Select

            Try
                CommonFunction.Data.InsertOrUpdateData(updateSQL, MyBase.UseSQL)
            Catch ex As Exception
            Finally
                Response.Clear()
                Response.End()


            End Try

        End If

    End Sub
    Private Sub SaveData()
        '=====================================================================
        ' Procedure Name        : SaveData()	
        ' Purpose               : to save edited  data. 
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantD
        ' Created               : 24 May 2006
        ' Revisions             :
        '=====================================================================
        Dim count_TimeSheetIDs_Ctrls As Int32
        Dim arr_TimeSheetIDs() As String
        Dim count_TimeSheetIDs As Int32
        Dim strUPD_SQL As String
        Dim blnIsUpdate As Boolean = False

        count_TimeSheetIDs_Ctrls = CType(Request.Form("hid_Total_TS_Ctrls"), Int32)
        While count_TimeSheetIDs_Ctrls > 0
            strTimeSheetIDs = Request.Form("hidTimesheetIDs" + count_TimeSheetIDs_Ctrls.ToString)
            count_TimeSheetIDs = 0
            arr_TimeSheetIDs = strTimeSheetIDs.Split(","c)
            While count_TimeSheetIDs < arr_TimeSheetIDs.Length - 1
                blnIsUpdate = False
                strUPD_SQL = "usp_Upd_tbl_PM_TimeSheet_EasyEdit "

                If arr_TimeSheetIDs(count_TimeSheetIDs) <> "" Then
                    strUPD_SQL += arr_TimeSheetIDs(count_TimeSheetIDs) + ","
                    If (Request.Form("ctrDes" + arr_TimeSheetIDs(count_TimeSheetIDs)) & "" <> "") Then
                        strUPD_SQL += "'" + Request.Form("ctrDes" + arr_TimeSheetIDs(count_TimeSheetIDs)).Replace("'", "''") & "',"
                        blnIsUpdate = True
                    Else
                        strUPD_SQL += "null,"
                    End If
                    If (Request.Form("ctrAct" + arr_TimeSheetIDs(count_TimeSheetIDs)) & "" <> "") Then
                        'Commented And Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
                        'strUPD_SQL += Request.Form("ctrAct" + arr_TimeSheetIDs(count_TimeSheetIDs)) & ","
                        strUPD_SQL += CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + CommonFunctions.Data.CheckIsDBNull(Request.Form("ctrAct" + arr_TimeSheetIDs(count_TimeSheetIDs)), "0") + "',2)", True) & ","
                        'End Of Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
                        blnIsUpdate = True
                    Else
                        strUPD_SQL += "null,"
                    End If
                    If (Request.Form("ctrWsr" + arr_TimeSheetIDs(count_TimeSheetIDs)) & "" <> "") Then
                        strUPD_SQL += Request.Form("ctrWsr" + arr_TimeSheetIDs(count_TimeSheetIDs))
                        blnIsUpdate = True
                    Else
                        strUPD_SQL += "null"
                    End If

                    If blnIsUpdate = True Then
                        CommonFunction.Data.InsertOrUpdateData(strUPD_SQL, MyBase.UseSQL)
                    End If


                End If


                count_TimeSheetIDs += 1
            End While
            count_TimeSheetIDs_Ctrls -= 1
        End While

    End Sub
    Private Sub DeleteData()
        '=====================================================================
        ' Procedure Name        : DeleteData()	
        ' Purpose               : to delete selected records. 
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantD
        ' Created               : 24 May 2006
        ' Revisions             :
        '=====================================================================
        Dim count_TimeSheetIDs_Ctrls As Int32
        Dim count_TimeSheetIDs As Int32
        Dim arr_TimeSheetIDs() As String


        count_TimeSheetIDs_Ctrls = CType(Request.Form("hid_Total_TS_Ctrls"), Int32)
        While count_TimeSheetIDs_Ctrls > 0
            strTimeSheetIDs = Request.Form("hidTimesheetIDs" + count_TimeSheetIDs_Ctrls.ToString)
            arr_TimeSheetIDs = strTimeSheetIDs.Split(","c)
            count_TimeSheetIDs = 0
            While count_TimeSheetIDs < arr_TimeSheetIDs.Length - 1
                If arr_TimeSheetIDs(count_TimeSheetIDs) <> "" Then
                    If Request.Form("hidDel" + arr_TimeSheetIDs(count_TimeSheetIDs)).ToUpper & "" = "1" Then
                        blnIsDeletionSP_fired = True
                        CommonFunction.Data.InsertOrUpdateData("usp_Del_tbl_PM_TimeSheet_ForTimeSheetID " + arr_TimeSheetIDs(count_TimeSheetIDs), MyBase.UseSQL)
                    End If
                End If
                count_TimeSheetIDs += 1
            End While
            count_TimeSheetIDs_Ctrls -= 1
        End While
    End Sub


End Class
