#Region "Imports"
Imports System.Xml
Imports WhizTemplate
#End Region

Public Class AJAXHttp
    Inherits WebPages.Template.WhizTemplate
#Region "Member Varaibles"
    Protected m_lngTagID As Long
    Protected sbHTML As StringBuilder
    Protected m_strFrom As String = ""
    Protected m_strSQL As String = ""
    Protected m_strUserID As String = ""

#End Region
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        Initialize_Variables()

        Select Case m_lngTagID
            Case CommonFunction.Constants.APP_TAG_ASSIGNED_TASK
                If m_strFrom = "" Then
                    DrawSubActivityList()
                End If
            Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                GetDeliverableTaskEfforts()
        End Select
        If m_strFrom.ToUpper = "DEFAULTTHEME" Then
            PerformDefaultTheme()
        End If

    End Sub
    Protected Sub Initialize_Variables()
        m_lngTagID = CType(CommonFunction.General.CheckIsNothing(Request("MasterTagID")), Long)
        m_strFrom = CType(CommonFunction.General.CheckIsNothing(Request("From")), String)
        m_strUserID = CommonFunction.General.CheckIsNothing(Session("intUserID"))
    End Sub
    Private Sub DrawSubActivityList()
        sbHTML = New StringBuilder("")
        Dim drDIV As IDataReader
      
        Dim sText As String = ""
        Dim sID As String = ""
        Dim strTaskTypeID As String = CommonFunction.General.CheckIsNothing(Request("TaskTypeID"))
        Dim strProjectID As String = CommonFunction.General.CheckIsNothing(Session("intProjectID"))

        If strProjectID = "" Then
            Exit Sub
        End If

        m_strSQL = "EXEC usp_Sel_tbl_PM_Project_SubTaskTypes " & strProjectID & "," & strTaskTypeID
        drDIV = CommonFunction.Data.GetDataReader(m_strSQL, MyBase.UseSQL)


        sbHTML.Append("<table cellpadding=0 cellspacing=1 class='clsGridTable'  width=100% >")
        While drDIV.Read

            sText = CType(CommonFunction.Data.CheckIsDBNull(drDIV("SubTaskType")), String)
            sID = CType(CommonFunction.Data.CheckIsDBNull(drDIV("SubTaskTypeID")), String)


            sText = sText.Replace("'", "&#39;")

            sbHTML.Append("<tr class='clsTRBlank' valign='left'>")
            sbHTML.Append("<td align='left'   class='clsTDBlank'>")
            sbHTML.Append("<a style='text-decoration:none;FONT-FAMILY: Verdana, Arial, sans-serif;' href='javascript:Attribute_OnClick(""" + sID + """,""" + sText + """,""hrASTA"")'>")
            sbHTML.Append(sText)
            sbHTML.Append("</a>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")

        End While

        CommonFunction.Data.DisposeDataReader(drDIV)
        sbHTML.Append("</table>")
        Response.Clear()
        Response.Write(sbHTML.ToString)
        Response.End()
        sbHTML = Nothing
    End Sub
    Private Sub PerformDefaultTheme()
        Dim m_strThemeID As String = CommonFunction.General.CheckIsNothing(Request("ThemeID"))

        If m_strThemeID = "" Then
            m_strThemeID = "4"
        End If

        m_strSQL = "usp_Ins_Upd_Home_DefaultTheme " & m_strUserID & "," & m_lngTagID.ToString & "," & m_strThemeID & ",N'" & CommonFunction.General.CheckIsNothing(Session("strUserName")) & "'"

        Try
            CommonFunction.Data.InsertOrUpdateData(m_strSQL, MyBase.UseSQL)
        Catch

        End Try
     
    End Sub
    Private Sub GetDeliverableTaskEfforts()
        sbHTML = New StringBuilder("")
        Dim dblWorkHrs As Double = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("WorkHrs"), "0"), Double)
        Dim dblTotalTaskWorkHra As Double = 0.0

        m_strSQL = " usp_Sel_WBS_TotalTaskEfforts " & CommonFunction.General.CheckIsNothing(Request.QueryString("ScheduleID"), "0") & "," + CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString
        dblTotalTaskWorkHra = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(m_strSQL, MyBase.UseSQL), "0"), Double)
        'If dblWorkHrs < dblTotalTaskWorkHra Then
        '    sbHTML.Append("alert('Work (" + dblWorkHrs.ToString + ") should not be less than sum of estimated task efforts(" + dblTotalTaskWorkHra.ToString + "');")

        'End If
        sbHTML.Append(dblTotalTaskWorkHra.ToString)

        Response.Clear()
        Response.Write(sbHTML.ToString)
        Response.End()
        sbHTML = Nothing

    End Sub
End Class