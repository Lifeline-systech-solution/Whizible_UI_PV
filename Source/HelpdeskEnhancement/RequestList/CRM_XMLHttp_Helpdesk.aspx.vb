Imports System.Text

Partial Public Class CRM_XMLHttp_Helpdesk
    Inherits WebPages.Template.WhizTemplate

    Private strAction As String
    Private dsRecords As DataSet
    Private dsRecordsInnerLoop As DataSet
    Private drRecords As IDataReader

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)

        '=====================================================================
        ' Procedure Name        : Page_Load()	
        ' Purpose               : This page is created To call procedures from XML call.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          :  
        ' Author                : Shraddha M
        ' Created               : 13,Apr 2009
        ' Revisions             :
        '=====================================================================

        If Not Request.QueryString("Action") Is Nothing And Request.QueryString("Action") <> "" Then
            strAction = Request.QueryString("Action").ToString()
        End If
        If Request.QueryString("FromXML") = 1 And strAction = "SaveActivity" Then
            Response.Clear()
            Call SaveActivity(Request.QueryString("QueryID"))
            Response.End()
        End If

        If Request.QueryString("FromXML") = 1 And strAction = "Assign" Then
            Response.Clear()
            Call AssignRequestToSelf(Request.QueryString("QueryID"))
            Response.End()
        End If
        'ElseIf Request.QueryString("FromXML") = 1 And strAction = "SaveActivity" Then
        '    Response.Clear()
        '    Call SaveActivity(Request.QueryString("QueryID"))
        '    Response.End()
        'ElseIf Request.QueryString("FromXML") = 1 And strAction = "SearchActivity" Then
        '    Response.Clear()
        '    Call SearchActivity(Request.QueryString("QueryID"))
        '    Response.End()
        'ElseIf Request.QueryString("FromXML") = 1 And strAction = "ShowStatus" Then
        '    Response.Clear()
        '    Call ShowStatus(Request.QueryString("QueryID"))
        '    Response.End()
        'ElseIf Request.QueryString("FromXML") = 1 And strAction = "ShowDetailActivity" Then
        '    Response.Clear()
        '    Call ShowDetailActivity(Request.QueryString("QueryID"))
        '    Response.End()
        'ElseIf Request.QueryString("FromXML") = 1 And strAction = "ShowView" Then
        '    Response.Clear()
        '    Call DrawView(Request.QueryString("From"))
        '    Response.End()
        'ElseIf Request.QueryString("FromXML") = 1 And strAction = "ShowRequestorDetails" Then
        '    Response.Clear()
        '    Call ShowRequestorDetails(Request.QueryString("QueryID"), Request.QueryString("RequestorType"))
        '    Response.End()
        'ElseIf Request.QueryString("FromXML") = 1 And strAction = "ShowStatistics" Then
        '    Response.Clear()
        '    Call ShowStatistics(Request.QueryString("QueryID"), Request.QueryString("RequestorType"))
        '    Response.End()
        'End If

        'ShowStatistics


    End Sub
    Private Sub AssignRequestToSelf(ByVal QueryID As String)
        '=====================================================================
        ' Procedure Name        : AssignRequestToSelf()	
        ' Purpose               : To Assign help request to self.
        ' Description           : same as above
        ' Parameters Passed     : QueryID
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          :  
        ' Author                : Shraddha M
        ' Created               : 13,Apr 2009
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String
        Dim dr As IDataReader
        Dim blnShowPopup As Boolean
        Dim blnSendMail As Boolean
        Dim strFromEmailID As String
        Dim strToMailID As String
        Dim strCCToMailID As String
        Dim strSubject, strMessage As String


        strQuery = "usp_INS_tbl_CRM_Query_Master_AssignToSelf " + QueryID + "," + Session("intUserID").ToString()
        CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

        ' Assign To change mail

        blnSendMail = False : blnShowPopup = False
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 43", MyBase.UseSQL)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
            blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        If blnSendMail Then
            If blnShowPopup Then
                With Response
                    .Write("<script language=javascript>")
                    .Write("window.open (""../General/SendEmail.aspx?MessageID=43&MultipleRequests=0&QueryID=" & QueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                    .Write("</script>")
                End With
            Else
                ' silent mail
                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_43(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, QueryID.ToString, False)
                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
            End If
        End If

        Response.Clear()
        Response.Write("Assign$_$" + QueryID)

    End Sub

    Private Sub SaveActivity(ByVal QueryID As String)
        '=====================================================================
        ' Procedure Name        : SaveActivity()	
        ' Purpose               : To Save activity against help request.
        ' Description           : same as above
        ' Parameters Passed     : QueryID
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          :  
        ' Author                : Shraddha M
        ' Created               : 13,Apr 2009
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String
        Dim ActivityID As String = "NULL"
        Dim Time As String = "NULL"
        Dim TimeUnit As String = "NULL"
        Dim statusID As String
        Dim FeedBackID As String
        Dim FeedBackComment As String
        ' Added by GaneshD for WhizibleSem 9.0 IssueID-32667
        Dim strValid As String = ""
        ' End of addition and modification by GaneshD on 01 Sep 2009
        If Not Request.QueryString("ActivityID") Is Nothing And Request.QueryString("ActivityID") <> "" Then
            ActivityID = Replace(Request.QueryString("ActivityID"), "'", "''")
        End If

        If Not Request.QueryString("Time") Is Nothing And Request.QueryString("Time") <> "" Then
            Time = Request.QueryString("Time")
        End If

        If Not Request.QueryString("statusID") Is Nothing And Request.QueryString("statusID") <> "" Then
            statusID = Replace(Request.QueryString("statusID"), "'", "''")
        End If

        If Not Request.QueryString("FeedBackID") Is Nothing And Request.QueryString("FeedBackID") <> "" Then
            FeedBackID = Request.QueryString("FeedBackID")
        Else
            FeedBackID = "null"
        End If

        If Not Request.QueryString("FeedBackComment") Is Nothing And Request.QueryString("FeedBackComment") <> "" Then
            FeedBackComment = Replace(Request.QueryString("FeedBackComment"), "'", "''")
        Else
            FeedBackComment = ""
        End If

        ' Added by GaneshD for WhizibleSem 9.0 IssueID-32667
        ' Code Commented by GaneshD on 05 Oct 2009 [As the status dropdown shows only configured statuses]
        ' No alert is required
        'strQuery = "usp_CRM_getInValidStatusAlert " + QueryID + "," + statusID
        'strValid = CommonFunctions.Data.GetDataScalar(strQuery, True)
        'If strValid = "" Then
        ' End of addition and modification by GaneshD on 01 Sep 2009
        strQuery = "usp_INS_tbl_CRM_Query_Activity " + QueryID + "," + Session("intUserID").ToString() + ","
        strQuery += "" + ActivityID + "," + Time + "," + statusID + "," + FeedBackID + ",'" + FeedBackComment + "'"

        CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        Response.Clear()
        Response.Write("SaveActivity$_$" + QueryID)
        ' Added by GaneshD for WhizibleSem 9.0 IssueID-32667
        'Else
        'Response.Write("NotValidStatus$_$" + QueryID + "$_$" + strValid)
        'End If
        ' End of modification by GaneshD on 05 Oct 2009
        ' End of addition and modification by GaneshD on 01 Sep 2009
    End Sub
    'Private Sub SearchActivity(ByVal QueryID As String)
    '    '=====================================================================
    '    ' Procedure Name        : SearchActivity()	
    '    ' Purpose               : To search activities against help request.
    '    ' Description           : same as above
    '    ' Parameters Passed     : QueryID
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          :  
    '    ' Author                : Shraddha M
    '    ' Created               : 13,Apr 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strQuery As String
    '    Dim Activity As String = ""
    '    Dim ActivityID As String
    '    Dim Time As String = "NULL"
    '    Dim TimeUnit As String = "NULL"
    '    Dim dr As IDataReader
    '    Dim sbHTML As New StringBuilder("")
    '    Dim iterator As Integer = 1

    '    'If Not Request.QueryString("Activity") Is Nothing And Request.QueryString("Activity") <> "" Then
    '    '    Activity = Replace(Request.QueryString("Activity"), "'", "''")
    '    'End If       

    '    strQuery = "usp_Sel_tbl_CRM_Query_Activity " '+ QueryID + "," + Session("intUserID").ToString() + ","
    '    'strQuery += "'" + Activity + "'"

    '    dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)


    '    While dr.Read()
    '        Activity = dr("Activity").ToString()
    '        ActivityID = dr("ActivityID").ToString()

    '        If iterator = 1 Then
    '            sbHTML.Append("<table id='tblContextMenu' cellpadding=0 cellspacing=1 class='clsGridTable'  width=100% >")
    '        End If
    '        'sbHTML.Append("<tr class='clsTRBlank' valign='left' onkeydown=""copytext(event,'txtActivity','" + Replace(dr("Activity").ToString(), "'", "''") + "'," + QueryID.ToString() + ")"" onclick=""copytext(event,'txtActivity','" + Replace(dr("Activity").ToString(), "'", "''") + "'," + QueryID.ToString() + ")""  onmouseover=""DisplayColor(this," + (iterator - 1).ToString() + ")"" onmouseout=""RemoveColor(this," + (iterator - 1).ToString() + ")"" >")
    '        sbHTML.Append("<tr class='clsTRBlank' valign='left' onclick=""copytext(event,'txtActivity','" + Replace(Activity, "'", "''") + "'," + QueryID.ToString() + "," + ActivityID + ")""  onmouseover=""DisplayColor(this," + (iterator - 1).ToString() + ")"" onmouseout=""RemoveColor(this," + (iterator - 1).ToString() + ")"" >")
    '        sbHTML.Append("<td align='left' class='clsTDBlank'><a style='text-decoration:none;FONT-FAMILY: Verdana, Arial, sans-serif;'>" + Activity + "</a>")

    '        sbHTML.Append("</td>")
    '        sbHTML.Append("</tr>")

    '        iterator = iterator + 1
    '    End While
    '    If iterator > 1 Then
    '        sbHTML.Append("</table>")
    '    End If
    '    CommonFunctions.Data.DisposeDataReader(dr)

    '    'sbHTML.Append("<input type=hidden id=txtQueryID name=txtQueryID value=" + QueryID + ">")
    '    Response.Write(sbHTML.ToString + "$_$" + QueryID)
    '    sbHTML = Nothing
    '    'Response.Clear()
    '    'Response.Write("_" + QueryID)

    'End Sub


    'Private Sub ShowStatus(ByVal QueryID As String)
    '    '=====================================================================
    '    ' Procedure Name        : ShowStatus()	
    '    ' Purpose               : To show status against help request.
    '    ' Description           : same as above
    '    ' Parameters Passed     : QueryID
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          :  
    '    ' Author                : Shraddha M
    '    ' Created               : 13,Apr 2009
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strQuery As String
    '    Dim status As String
    '    Dim statusID As String
    '    Dim strCurrentDate As String
    '    Dim strTime As String
    '    Dim strOldStatusDate As String
    '    Dim strOldStatusTime As String
    '    Dim OldStatusID As String

    '    Dim dr As IDataReader
    '    Dim sbHTML As New StringBuilder("")
    '    Dim iterator As Integer = 1

    '    'If Not Request.QueryString("status") Is Nothing And Request.QueryString("status") <> "" Then
    '    '    status = Replace(Request.QueryString("status"), "'", "''")
    '    'End If

    '    strQuery = "usp_Sel_HelpDesk_StatusDate_Time " + QueryID

    '    dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

    '    While dr.Read()
    '        strCurrentDate = dr("StatusChangeDate").ToString()
    '        strTime = dr("StatusChangeTime").ToString()
    '        strOldStatusDate = dr("OldStatusChangeDate").ToString()
    '        strOldStatusTime = dr("OldStatusChangeTime").ToString()
    '        OldStatusID = dr("OldStatusID").ToString()
    '    End While
    '    CommonFunction.Data.DisposeDataReader(dr)
    '    'Commented And Added by NitinC on 25 March 2011 for WhizibleSEM 10.0 to provide Role wise Acces to Reuest status
    '    ' Added/Modified by GaneshD on 05 Oct 2009 For Showing only those statuses which are configured
    '    ' strQuery = "usp_CRM_Get_RequestStatus"
    '    'strQuery = "usp_CRM_Get_RequestStatus " + QueryID ' RequestId parameter has been passsed.
    '    ' End of modification by GaneshD on 05 Oct 2009
    '    Dim RoleId As String = Session("intPostId")
    '    strQuery = "usp_CRM_Get_RequestStatus " + QueryID + "," + RoleId ' RequestId parameter has been passsed.
    '    'End of Commented And Added by NitinC on 25 March 2011 for WhizibleSEM 10.0 to provide Role wise Acces to Reuest status
    '    dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

    '    While dr.Read()
    '        status = dr("status").ToString()
    '        statusID = dr("statusID").ToString()

    '        If iterator = 1 Then
    '            sbHTML.Append("<table id='tblContextMenu' cellpadding=0 cellspacing=1 class='clsGridTable'  width=100% >")
    '        End If
    '        sbHTML.Append("<tr class='clsTRBlank' valign='left' onkeydown=""copytext(event,'txtStatus','" + Replace(status, "'", "''") + "'," + QueryID.ToString() + "," + statusID + ")"" onclick=""copytext(event,'txtStatus','" + Replace(status, "'", "''") + "'," + QueryID.ToString() + "," + statusID + ")""  onmouseover=""DisplayColor(this," + (iterator - 1).ToString() + ")"" onmouseout=""RemoveColor(this," + (iterator - 1).ToString() + ")"" >")
    '        'sbHTML.Append("<tr class='clsTRBlank' valign='left' onkeydown=""copytext(event,'" + Replace(dr("Activity").ToString(), "'", "''") + "'," + QueryID.ToString() + ")"" >")
    '        sbHTML.Append("<td align='left' class='clsTDBlank'><a style='text-decoration:none;FONT-FAMILY: Verdana, Arial, sans-serif;' statusID=" + statusID + ">" + status + "</a>")
    '        'sbHTML.Append("<td align='left' class='clsTDBlank'><a href="""" style='text-decoration:none;FONT-FAMILY: Verdana, Arial, sans-serif;' >" + dr("Activity").ToString() + "</a>")
    '        sbHTML.Append("</td>")
    '        sbHTML.Append("</tr>")

    '        iterator = iterator + 1
    '    End While

    '    If iterator > 1 Then
    '        sbHTML.Append("</table>")

    '        CommonFunction.General.WriteHTML("<input type=hidden name=hidStatusChangeDate id=hidStatusChangeDate value='" + strOldStatusDate + "'>")
    '        CommonFunction.General.WriteHTML("<input type=hidden name=hidStatusChangeTime id=hidStatusChangeTime value='" + strOldStatusTime + "'>")
    '        CommonFunction.General.WriteHTML("<input type=hidden name=hidCurrentDate id=hidCurrentDate value='" + strCurrentDate + "'>")
    '        CommonFunction.General.WriteHTML("<input type=hidden name=hidCurrentTime id=hidCurrentTime value='" + strTime + "'>")
    '        CommonFunction.General.WriteHTML("<input type=hidden name=hidoldStatusID id=hidoldStatusID value='" + OldStatusID + "'>")

    '    End If

    '    CommonFunctions.Data.DisposeDataReader(dr)
    '    'sbHTML.Append("<input type=hidden id=txtQueryID name=txtQueryID value=" + QueryID + ">")
    '    Response.Write(sbHTML.ToString + "$_$" + QueryID)
    '    sbHTML = Nothing
    '    'Response.Clear()
    '    'Response.Write("_" + QueryID)

    'End Sub

    'Private Sub ShowDetailActivity(ByVal QueryID As String)

    '    '=====================================================================
    '    ' Procedure Name        : ShowDetailActivity()	
    '    ' Purpose               : To show activity details against help request.
    '    ' Description           : same as above
    '    ' Parameters Passed     : QueryID
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          :  
    '    ' Author                : Shraddha M
    '    ' Created               : 13,Apr 2009
    '    ' Revisions             :
    '    '=====================================================================

    '    Dim strQuery As String
    '    Dim strEmployeename As String
    '    Dim strActivity As String
    '    Dim strTimeSpent As String
    '    Dim strCreatedDate As String
    '    Dim strQueryID As String
    '    Dim strClass As String = "clsTREven"
    '    Dim dblTotalSpend As Double = 0.0

    '    Dim dr As IDataReader
    '    Dim sbHTML As New StringBuilder("")

    '    Dim strSubject As String

    '    strQuery = "usp_Sel_EmployeeActivity " + QueryID

    '    dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

    '    'sbHTML.Append("<div id='divActivityDtls' style='OVERFLOW:auto;BORDER-COLOR:#35afe8;BORDER-STYLE:groove;POSITION:absolute;Z-INDEX:19000'>")
    '    strSubject = CommonFunction.Data.GetDataScalar("SELECT Subject FROM tbl_CRM_Query_Master WHERE QueryID = " + QueryID.ToString, MyBase.UseSQL)
    '    sbHTML.Append("<Table  cellpadding=0 cellspacing=0 width=100%>")
    '    sbHTML.Append("<tr class='clsTRPageCaption'><td>")
    '    sbHTML.Append("Request ID : <font size=2>" + QueryID + "</font>:&nbsp;&nbsp;&nbsp;")
    '    sbHTML.Append("Subject : " + strSubject + "</TD>")
    '    sbHTML.Append("<td align=right><a href ='Javascript:CloseDiv()'><img border=0 src = '../../Images/RM/Close.gif' > </a></td>")
    '    sbHTML.Append("</tr>")
    '    ''sbHTML.Append("<tr class='clsTRPageCaption'><td colspan=2>Subject : " + strSubject + "</TD></TR>")
    '    sbHTML.Append("<tr class='clsTRPageCaption'><td colspan=2></td></TR>")
    '    sbHTML.Append("</Table>")

    '    sbHTML.Append("<table id='tblActivityDtls' cellpadding=0 cellspacing=1 class='clsGridTable'  width=100% >")
    '    sbHTML.Append("<TR class='clsTRColumnHeader' style='FONT-WEIGHT:bold' >")

    '    sbHTML.Append("<TD >Date</TD>" + vbCrLf)
    '    sbHTML.Append("<TD >Employee Name</TD>" + vbCrLf)
    '    sbHTML.Append("<TD > Activity Name</TD>" + vbCrLf)
    '    sbHTML.Append("<TD  align=right>Time Spent (Min)</TD>" + vbCrLf)

    '    sbHTML.Append("</TR>" + vbCrLf)



    '    While dr.Read()

    '        strEmployeename = dr("EmployeeName").ToString()
    '        strActivity = dr("Activity").ToString()
    '        strTimeSpent = dr("TimeSpent").ToString()
    '        strCreatedDate = CommonFunctions.Dates.CGetDate(CType(dr("CreatedDate"), Date)) 'dr("CreatedDate").ToString()
    '        dblTotalSpend += CType(CommonFunction.Data.CheckIsDBNull(dr("TimeSpent"), "0"), Double)

    '        sbHTML.Append("<TR class=" + strClass + " > ")

    '        sbHTML.Append("<TD>" + strCreatedDate + "</TD>" + vbCrLf)

    '        sbHTML.Append("<TD>" + strEmployeename + "</TD>" + vbCrLf)
    '        sbHTML.Append("<TD>" + strActivity + "</TD>" + vbCrLf)
    '        sbHTML.Append("<TD align=right>" + strTimeSpent + "</TD>" + vbCrLf)

    '        If strClass = "clsTROdd" Then
    '            strClass = "clsTREven"
    '        Else
    '            strClass = "clsTROdd"
    '        End If

    '        sbHTML.Append("</TR>" + vbCrLf)


    '    End While
    '    sbHTML.Append("<TR class='clsTRGroupHeader' > ")
    '    sbHTML.Append("<TD align='left'>Total Time Spent</TD>" + vbCrLf)

    '    sbHTML.Append("<TD></TD>" + vbCrLf)
    '    sbHTML.Append("<TD></TD>" + vbCrLf)
    '    sbHTML.Append("<TD align='right' text-align='right'>")
    '    sbHTML.Append(FormatNumber(dblTotalSpend, 2))
    '    sbHTML.Append("</TD>")
    '    sbHTML.Append("</TR>" + vbCrLf)
    '    sbHTML.Append("</Table>" + vbCrLf)

    '    'sbHTML.Append("</Div>" + vbCrLf)
    '    'sbHTML.Append("<Table style='Z-INDEX: 1001;'>")
    '    'sbHTML.Append("<tr class='clsTRPageCaption'><td style='text-align:center;'>")
    '    'sbHTML.Append("<input type=button id=btnClose onclick='CloseDiv()' value=""Close""></TD>")
    '    'sbHTML.Append("</TR>")
    '    'sbHTML.Append("</Table>")


    '    CommonFunctions.Data.DisposeDataReader(dr)
    '    Response.Write(sbHTML.ToString + "$_$")
    '    sbHTML = Nothing

    'End Sub

    'Private Sub ShowRequestorDetails(ByVal QueryID As String, ByVal RequestorType As String)

    '    '=====================================================================
    '    ' Procedure Name        : ShowDetailActivity()	
    '    ' Purpose               : To show activity details against help request.
    '    ' Description           : same as above
    '    ' Parameters Passed     : QueryID
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          :  
    '    ' Author                : Shraddha M
    '    ' Created               : 13,Apr 2009
    '    ' Revisions             :
    '    '=====================================================================

    '    Dim strQuery As String
    '    Dim strRequestorName As String
    '    Dim oldstrRequestorName As String = ""

    '    Dim EmailID As String
    '    Dim Location As String
    '    Dim CurrentPhone As String
    '    Dim Phone As String
    '    Dim CommunicationID As String
    '    Dim ContactPersion As String
    '    Dim Position As String

    '    Dim strQueryID As String
    '    Dim strClass As String = "clsTREven"
    '    Dim dblTotalSpend As Double = 0.0

    '    Dim dr As IDataReader
    '    Dim sbHTML As New StringBuilder("")

    '    Dim strSubject As String

    '    strQuery = "usp_Sel_RequestorDetails " + QueryID + ",'" + RequestorType + "'"

    '    dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

    '    strSubject = CommonFunction.Data.GetDataScalar("SELECT Subject FROM tbl_CRM_Query_Master WHERE QueryID = " + QueryID.ToString, MyBase.UseSQL)
    '    sbHTML.Append("<Table  cellpadding=0 cellspacing=0 width=100%>")
    '    sbHTML.Append("<tr class='clsTRPageCaption'><td>")
    '    sbHTML.Append("Request ID : <font size=2>" + QueryID + "</font>:&nbsp;&nbsp;&nbsp;")
    '    sbHTML.Append("Subject : " + strSubject + "</TD>")
    '    sbHTML.Append("<td align=right><a href ='Javascript:CloseDiv()'><img border=0 src = '../../Images/RM/Close.gif' > </a></td>")
    '    sbHTML.Append("</tr>")
    '    sbHTML.Append("<tr class='clsTRPageCaption'><td colspan=2></td></TR>")
    '    sbHTML.Append("</Table>")

    '    'sbHTML.Append("<div id='divActivityDtls' style='OVERFLOW:auto;BORDER-COLOR:#35afe8;BORDER-STYLE:groove;POSITION:absolute;Z-INDEX:19000'>")
    '    If RequestorType = "E" Then

    '        sbHTML.Append("<table id='tblRequestorDtls' cellpadding=0 cellspacing=1 class='clsGridTable'  width=100% >")
    '        sbHTML.Append("<TR class='clsTRColumnHeader' style='FONT-WEIGHT:bold' >")

    '        sbHTML.Append("<TD >Requestor</TD>" + vbCrLf)
    '        sbHTML.Append("<TD >Email ID</TD>" + vbCrLf)
    '        sbHTML.Append("<TD >Organization Unit</TD>" + vbCrLf)
    '        sbHTML.Append("<TD >Contact No</TD>" + vbCrLf)
    '        sbHTML.Append("<TD >Instant Messenger IDs</TD>" + vbCrLf)

    '        sbHTML.Append("</TR>" + vbCrLf)


    '        While dr.Read()

    '            strRequestorName = dr("RequestorName").ToString()
    '            EmailID = dr("EmailID").ToString()
    '            Location = dr("Location").ToString()
    '            CurrentPhone = dr("CurrentPhone").ToString()
    '            Phone = dr("Phone").ToString()
    '            CommunicationID = dr("CommunicationID").ToString()

    '            If CurrentPhone <> "-" And Phone <> "-" Then
    '                Phone = CurrentPhone + " ; " + "Ext No : " + Phone
    '            End If

    '            If CurrentPhone = "-" And Phone <> "-" Then
    '                Phone = "Ext No : " + Phone
    '            End If

    '            If Phone = "-" And CurrentPhone <> "-" Then
    '                Phone = CurrentPhone
    '            End If


    '            sbHTML.Append("<TR class=" + strClass + " > ")

    '            sbHTML.Append("<TD>" + strRequestorName + "</TD>" + vbCrLf)

    '            sbHTML.Append("<TD>" + EmailID + "</TD>" + vbCrLf)
    '            sbHTML.Append("<TD>" + Location + "</TD>" + vbCrLf)
    '            sbHTML.Append("<TD>" + Phone + "</TD>" + vbCrLf)
    '            sbHTML.Append("<TD>" + CommunicationID + "</TD>" + vbCrLf)


    '            If strClass = "clsTROdd" Then
    '                strClass = "clsTREven"
    '            Else
    '                strClass = "clsTROdd"
    '            End If

    '            sbHTML.Append("</TR>" + vbCrLf)


    '        End While

    '        sbHTML.Append("</Table>" + vbCrLf)

    '    Else

    '        sbHTML.Append("<table id='tblRequestorDtls' cellpadding=0 cellspacing=1 class='clsGridTable'  width=100% >")
    '        sbHTML.Append("<TR class='clsTRColumnHeader' style='FONT-WEIGHT:bold' >")

    '        sbHTML.Append("<TD >Requestor</TD>" + vbCrLf)
    '        sbHTML.Append("<TD >Contact Person</TD>" + vbCrLf)
    '        sbHTML.Append("<TD >Contact Type</TD>" + vbCrLf)
    '        sbHTML.Append("<TD >Email ID</TD>" + vbCrLf)
    '        'sbHTML.Append("<TD >Location</TD>" + vbCrLf)
    '        sbHTML.Append("<TD >Contact No</TD>" + vbCrLf)
    '        sbHTML.Append("<TD >Instant Messenger IDs</TD>" + vbCrLf)

    '        sbHTML.Append("</TR>" + vbCrLf)


    '        While dr.Read()

    '            strRequestorName = dr("RequestorName").ToString()
    '            ContactPersion = dr("ContactPerson").ToString()
    '            Position = dr("Position").ToString()
    '            EmailID = dr("EmailID").ToString()
    '            'Location = dr("Location").ToString()
    '            CurrentPhone = dr("Mobile").ToString()
    '            Phone = dr("Phone").ToString()
    '            CommunicationID = dr("OnLineContact").ToString()

    '            If CurrentPhone <> "-" And Phone <> "-" Then
    '                Phone = CurrentPhone + " ; " + Phone
    '            End If

    '            If CurrentPhone = "-" And Phone <> "-" Then
    '                Phone = Phone
    '            End If

    '            If Phone = "-" And CurrentPhone <> "-" Then
    '                Phone = CurrentPhone
    '            End If


    '            sbHTML.Append("<TR class=" + strClass + " > ")

    '            If oldstrRequestorName <> strRequestorName Then
    '                sbHTML.Append("<TD>" + strRequestorName + "</TD>" + vbCrLf)
    '            Else
    '                sbHTML.Append("<TD>&nbsp;</TD>" + vbCrLf)
    '            End If

    '            sbHTML.Append("<TD>" + ContactPersion + "</TD>" + vbCrLf)
    '            sbHTML.Append("<TD>" + Position + "</TD>" + vbCrLf)

    '            sbHTML.Append("<TD>" + EmailID + "</TD>" + vbCrLf)
    '            'sbHTML.Append("<TD>" + Location + "</TD>" + vbCrLf)
    '            sbHTML.Append("<TD>" + Phone + "</TD>" + vbCrLf)
    '            sbHTML.Append("<TD>" + CommunicationID + "</TD>" + vbCrLf)


    '            If strClass = "clsTROdd" Then
    '                strClass = "clsTREven"
    '            Else
    '                strClass = "clsTROdd"
    '            End If

    '            sbHTML.Append("</TR>" + vbCrLf)

    '            oldstrRequestorName = strRequestorName

    '        End While
    '        sbHTML.Append("</Table>" + vbCrLf)

    '    End If



    '    CommonFunctions.Data.DisposeDataReader(dr)
    '    Response.Write(sbHTML.ToString + "$_$")
    '    sbHTML = Nothing

    'End Sub

    'Private Sub ShowStatistics(ByVal QueryID As String, ByVal RequestorType As String)


    '    '=====================================================================
    '    ' Procedure Name        : ShowDetailActivity()	
    '    ' Purpose               : To show activity details against help request.
    '    ' Description           : same as above
    '    ' Parameters Passed     : QueryID
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          :  
    '    ' Author                : Shraddha M
    '    ' Created               : 13,Apr 2009
    '    ' Revisions             :
    '    '=====================================================================

    '    Dim strQuery As String
    '    Dim strEmployeename As String
    '    Dim strActivity As String
    '    Dim strTimeSpent As String
    '    Dim strCreatedDate As String
    '    Dim strQueryID As String
    '    Dim strClass As String = "clsTREven"
    '    Dim dblTotalSpend As Double = 0.0
    '    Dim Requestor As String
    '    Dim iterator As Integer
    '    Dim sbHTML As New StringBuilder("")

    '    Dim strSubject As String
    '    Dim TotalCols As Integer

    '    strQuery = "usp_Sel_CrossTab_RequestorRequests " + QueryID + ",'" + RequestorType + "'"

    '    dsRecords = CommonFunctions.Data.GetDataSet(strQuery, "RequestCount", , , MyBase.UseSQL)

    '    For Each drRecords As DataRow In dsRecords.Tables(0).Rows

    '        Requestor = drRecords("Requestor").ToString()

    '    Next

    '    TotalCols = dsRecords.Tables(1).Rows.Count

    '    'sbHTML.Append("<div id='divActivityDtls' style='OVERFLOW:auto;BORDER-COLOR:#35afe8;BORDER-STYLE:groove;POSITION:absolute;Z-INDEX:19000'>")
    '    'strSubject = CommonFunction.Data.GetDataScalar("SELECT Subject FROM tbl_CRM_Query_Master WHERE QueryID = " + QueryID.ToString, MyBase.UseSQL)
    '    ''sbHTML.Append("<Table id=tblHeading cellpadding=0 cellspacing=0 width=100%>")
    '    ''sbHTML.Append("<tr class='clsTRPageCaption'><td >")
    '    ''sbHTML.Append("Summary Of Request Posted By : " + Requestor + "</TD>")

    '    ''For iterator = 0 To TotalCols + 1
    '    ''    sbHTML.Append("<TD>&nbsp;</TD>" + vbCrLf)
    '    ''Next

    '    ''sbHTML.Append("<td align=right ><a href ='Javascript:CloseDiv()'><img border=0 src = '../../Images/RM/Close.png' > </a></td>")
    '    ''sbHTML.Append("</tr>")
    '    ''''sbHTML.Append("<tr class='clsTRPageCaption'><td colspan=2>Subject : " + strSubject + "</TD></TR>")
    '    ''sbHTML.Append("<tr class='clsTRPageCaption'><td >&nbsp;</td>")

    '    ''For iterator = 0 To TotalCols
    '    ''    sbHTML.Append("<TD>&nbsp;</TD>" + vbCrLf)
    '    ''Next

    '    ''sbHTML.Append("</TR></Table>")

    '    sbHTML.Append("<table id='tblStatistic' cellpadding=0 cellspacing=1 class='clsGridTable'  width=100% >")


    '    sbHTML.Append("<tr class='clsTRPageCaption'><td colspan=" + TotalCols.ToString() + ">")

    '    sbHTML.Append("Summary Of Request Posted By : " + Requestor)

    '    sbHTML.Append("</td><td align=right ><a href ='Javascript:CloseDiv()'><img border=0 src = '../../Images/RM/Close.gif' > </a></td>")
    '    sbHTML.Append("</tr>")

    '    'sbHTML.Append("<tr class='clsTRPageCaption'><td colspan=" + (TotalCols + 1).ToString() + ">&nbsp;</td>")
    '    'sbHTML.Append("</TR>")


    '    sbHTML.Append("<TR class='clsTRColumnHeader' style='FONT-WEIGHT:bold' >")

    '    sbHTML.Append("<TD>Request Type</TD>" + vbCrLf)

    '    Dim ToolTip As String

    '    For Each drRecords As DataRow In dsRecords.Tables(1).Rows

    '        sbHTML.Append("<TD align=center >" + drRecords("Status").ToString() + "</TD>" + vbCrLf)

    '    Next

    '    sbHTML.Append("</TR>" + vbCrLf)


    '    For Each drRecords As DataRow In dsRecords.Tables(2).Rows

    '        sbHTML.Append("<TR class=" + strClass + " > ")

    '        sbHTML.Append("<TD >" + drRecords("RequestType").ToString() + "</TD>" + vbCrLf)

    '        For Each dsRecordsInnerLoop As DataRow In dsRecords.Tables(1).Rows

    '            ToolTip = "Request Type : " + drRecords("RequestType").ToString() + vbCrLf
    '            ToolTip = ToolTip + "Status : " + dsRecordsInnerLoop("Status").ToString()

    '            sbHTML.Append("<TD align=center title='" + ToolTip + "'>" + drRecords(dsRecordsInnerLoop("Status").ToString()).ToString() + "</TD>" + vbCrLf)

    '        Next

    '        sbHTML.Append("</TR>" + vbCrLf)
    '    Next


    '    sbHTML.Append("</table>")

    '    Response.Write(sbHTML.ToString + "$_$ShowStatistic")

    '    sbHTML = Nothing



    'End Sub
    'Protected Sub DrawView(ByVal FromTab As String)
    '    Dim sbHTML As New System.Text.StringBuilder
    '    Dim intCount As Integer = 0
    '    Dim strValue As String = ""
    '    Dim strQuery As String = ""
    '    Dim strFieldName As String
    '    Dim dr As IDataReader
    '    Dim strSelectedValues As String
    '    Dim IsChecked As Boolean = False
    '    Dim strFormName As String
    '    Dim width As String
    '    Dim SelectClearAllX As Boolean = False
    '    Dim orderNo As String
    '    Dim IsDisabled As Boolean = False

    '    If Not Request.Form("chkAll") Is Nothing Then
    '        SelectClearAllX = CType(Request.Form("chkAll"), Boolean)
    '    End If


    '    If FromTab = "MD" Then
    '        strQuery = "usp_Sel_MyDashboardColumns"
    '        'width = "25%"
    '        width = "100%"
    '    ElseIf FromTab = "DB" Then
    '        strQuery = "usp_Sel_EDashboardColumns "
    '        'Added By Amol Changle On: 23 Jul 2009
    '        'Purpose: To select custom fields as well with default columns
    '        strQuery += CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID")).ToString()
    '        strQuery += "," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intPostID")).ToString()
    '        strQuery += ",N'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LoginType")).ToString() + "'"
    '        'End Addition
    '        strFormName = "frmDashboard"
    '        width = "100%"
    '    ElseIf FromTab = "SR" Then
    '        'Modified by bharat tekade
    '        ''strQuery = "usp_Sel_SubmittedColumns"
    '        ''width = "25%"

    '        strQuery = "usp_Sel_EDashboardColumns_cust "
    '        'Added By Amol Changle On: 23 Jul 2009
    '        'Purpose: To select custom fields as well with default columns
    '        strQuery += CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID")).ToString()
    '        strQuery += "," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intPostID")).ToString()
    '        strQuery += ",N'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LoginType")).ToString() + "'"
    '        'End Addition
    '        strFormName = "frmRequestList"
    '        'width = "25%"
    '        width = "100%"

    '        'end by bharat tekade
    '    ElseIf FromTab = "AR" Then
    '        strQuery = "usp_Sel_AssignedColumns"
    '        'width = "35%"
    '        width = "100%"
    '    End If

    '    dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

    '    strSelectedValues = CommonFunction.Data.GetDataScalar("usp_Sel_tbl_CRM_HelpDesk_Views " + Session("intUserID").ToString() + ",'" + FromTab + "'", MyBase.UseSQL)

    '    strValue = SelectClearAllX 'CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("chkAll"), "").ToString()

    '    'sbHTML.Append("<div id=""divTblX""  style='overflow:auto;width:25%;position:absolute;border-right: black 1px outset;border-top: black 1px outset;border-left: black 1px outset;border-bottom: black 1px outset;' >")

    '    sbHTML.Append("<table id=""TblBX""  class='clsGridTable' cellpadding=0 cellspacing=1 width='" + width + "'>")
    '    sbHTML.Append("<TR class='clsTREven'>")
    '    sbHTML.Append("<td align='left' nowrap>")
    '    sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkAll", "chkAll", , strValue, , , "onClick='javascript:SelectAndClearAll_OnClick()'", True))
    '    sbHTML.Append("<B>Select/Clear All</B></td>")
    '    sbHTML.Append("</TR>")
    '    sbHTML.Append("</table>")

    '    'sbHTML.Append("<div id=""divTblXX""  style='overflow:auto;' >")

    '    sbHTML.Append("<table id=""TblXX""  class='clsGridTable' cellpadding=0 cellspacing=1  width='" + width + "' >")

    '    While dr.Read()

    '        strFieldName = dr("FieldName").ToString()
    '        orderNo = dr("OrderNO").ToString()



    '        If Not strSelectedValues Is Nothing OrElse strSelectedValues <> "" Then
    '            If strSelectedValues.Contains("," + strFieldName + ",") Then
    '                IsChecked = True
    '                IsDisabled = False
    '            End If
    '        Else
    '            IsChecked = True
    '        End If

    '        If strFieldName = "Request ID" OrElse strFieldName = "Flag" OrElse strFieldName = "Attachment" OrElse strFieldName = "Discussion" OrElse strFieldName = "Subject" Then
    '            IsChecked = True
    '            IsDisabled = True
    '        End If

    '        sbHTML.Append("<TR class='clsTROdd'>")
    '        sbHTML.Append("<td align='left' nowrap >")
    '        sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkField", "chkField", , IsChecked, strFieldName, IsDisabled, , True))
    '        'sbHTML.Append("<td align='left' nowrap >" + strFieldName)
    '        sbHTML.Append(strFieldName + "</td>")
    '        'sbHTML.Append("</td>")
    '        sbHTML.Append("</TR>")

    '        IsChecked = False
    '        IsDisabled = False

    '    End While

    '    sbHTML.Append("</table>")
    '    'sbHTML.Append("</div>")


    '    sbHTML.Append("<table id=""TblBX""  class='clsGridTable' cellpadding=0 cellspacing=1 width='" + width + "'>")
    '    sbHTML.Append("<tr class='clsTREven'><td  style='text-align:center;' nowrap>")
    '    'sbHTML.Append("<A style = 'text-decoration:none;valign:middle;' HREF='Javascript:applyFilter()' Title='Apply X-Axis Filter' ><Img Border=0  src='../../Images/Check.gif' ><b>Apply</b></A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
    '    'sbHTML.Append("<A style = 'text-decoration:none;valign:middle;' HREF='Javascript:CloseFilter()' Title='Close X-Axis Filter' ><Img Border=0  src='../../Images/delete.gif' ><b>Close</b></A>")
    '    sbHTML.Append("<span onclick='applyFilter()' style='cursor:pointer' title='Apply Filter'><Img Border=0  src='../../Images/Check.gif' ><b>Apply</b></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
    '    sbHTML.Append("<span onclick='CloseFilter()' style='cursor:pointer' title='Close Filter'><Img Border=0  src='../../Images/delete.gif' ><b>Close</b></span>")

    '    sbHTML.Append("</td></tr>")

    '    sbHTML.Append("</table>")
    '    'sbHTML.Append("</div>")



    '    Response.Write(sbHTML.ToString + "$_$ShowView")
    '    sbHTML = Nothing
    '    CommonFunctions.Data.DisposeDataReader(dr)


    'End Sub

End Class