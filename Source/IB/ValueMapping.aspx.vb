Imports Whizible
Public Class ValueMapping
    Inherits WebPages.Template.WhizTemplate
    Public m_IntegrationID As Integer
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Protected m_Action As String = ""

    Public Sub Page_Init()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        m_Action = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"), "")
        If m_Action.ToUpper = "SHOW_HISTORY" Then
            ShowHistory()
        Else
            DrawPage()
        End If
    End Sub

    Public Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage()	
        ' Purpose               : To draw the grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ArchanaN
        ' Created               : 15-Jul-2010
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String = ""
        Dim drVal As IDataReader
        Dim strSQLVal As String = ""
        Dim drAttr As IDataReader
        Dim strAttributes As String = ""
        Dim strWhizValue As String = ""
        Dim strSysValue As String = ""
        Dim intAttributeID As Integer = 0
        Dim sbHTML As New System.Text.StringBuilder
        Dim intRecCnt As Integer = 1
        Dim intRecCount As Integer = 0
        Dim valCount As Integer = 1
        Dim Count As Integer = 3
        strSQL = "usp_Sel_FCI_AttributeValue_Mapping " & Session("intProjectID").ToString & ",null"
        drAttr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        sbHTML.Append("<div id=DivMain style='align:center;Overflow:auto;width:99.9%;'><Table align=center class=clsTable cellSpacing='1' cellPadding='1' width='99.9%' border='0'>")

        While drAttr.Read
            strAttributes = CommonFunction.Data.CheckIsDBNull(drAttr.Item("UserFriendlyName"), "")
            intAttributeID = CommonFunction.Data.CheckIsDBNull(drAttr.Item("WhizSysAttributeID"), 0)
            If intRecCnt = 2 Then
                sbHTML.Append("<td width=50%>")
            Else
                sbHTML.Append("<tr valign='top'>")
                sbHTML.Append("<td width=50%>")
            End If

            sbHTML.Append("<Table  align=center style='border-color:black;border-width:1px;border-style:Solid' class=clsTable cellSpacing='0' cellPadding='0' width='90%' border='0'>")
            sbHTML.Append("<tr  class=clsTRColumnHeader>")
            sbHTML.Append("<td colspan=2>")
            sbHTML.Append("<b>" & strAttributes & "</b>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")

            strSQLVal = "usp_Sel_FCI_AttributeValue_Mapping " & Session("intProjectID").ToString & "," & intAttributeID.ToString
            drVal = CommonFunction.Data.GetDataReader(strSQLVal, MyBase.UseSQL)
            sbHTML.Append("<TR class=clsTROdd>")
            sbHTML.Append("<td width=40%>")
            'Commented And Added By Parag Patil On 21 NOV 2013 For PMLifeLine
            'sbHTML.Append("<b>Whizible Values</b>")
            sbHTML.Append("<b>PMLifeLine Values</b>")
            'Commented And Added By Parag Patil On 21 NOV 2013 For PMLifeLine
            sbHTML.Append("</td>")
            sbHTML.Append("<td width=40%>")
            sbHTML.Append("<b>System Values</b>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            While drVal.Read
                strWhizValue = CommonFunction.Data.CheckIsDBNull(drVal.Item("WhizValue"), "")
                strSysValue = CommonFunction.Data.CheckIsDBNull(drVal.Item("SysValue"), "")
                sbHTML.Append("<TR class=clsTROdd>")
                sbHTML.Append("<td width=40%>")
                sbHTML.Append(strWhizValue)
                sbHTML.Append("</td>")
                sbHTML.Append("<td width=40%>")
                sbHTML.Append(strSysValue)
                sbHTML.Append("</td>")
                sbHTML.Append("</tr>")
                valCount += 1
                If valCount = 4 Then
                    Exit While
                End If
            End While

            While valCount <= 3
                sbHTML.Append("<TR class=clsTROdd>")
                sbHTML.Append("<td width=40%>")
                'sbHTML.Append(strWhizValue)
                sbHTML.Append("</td>")
                sbHTML.Append("<td width=40%>")
                'sbHTML.Append(strSysValue)
                sbHTML.Append("</td>")
                sbHTML.Append("</tr>")
                valCount += 1
            End While


            valCount = 1

            If intRecCnt = 2 Then
                'sbHTML.Append("</td>")
                'sbHTML.Append("</tr>")
                ' sbHTML.Append("<tr><td>&nbsp;")
                sbHTML.Append("</td></tr>")
                intRecCnt = 1
            Else
                sbHTML.Append("</td>")
                intRecCnt += 1
            End If

            sbHTML.Append("<TR>")
            'sbHTML.Append("<td align=right width=10%>")
            'sbHTML.Append("&nbsp")
            'sbHTML.Append("</td>")

            sbHTML.Append("<td align=right colspan=2>")
            'sbHTML.Append("<a href='javascript:EditValue(" & intAttributeID.ToString & "," & m_IntegrationID.ToString & ")' style='TEXT-DECORATION:none' title='Click to change the mapping values...'><font size=1px color=blue>Edit...</font></a>")
            sbHTML.Append("<a href='../IB/AttributeValueMapping_CommonList.aspx?IntegrationID=" + m_IntegrationID.ToString + "&AttributeID=" + intAttributeID.ToString + "&MasterTagID=8053' style='TEXT-DECORATION:none' title='Click to change the mapping values...'><font size=1px color=blue>Define attribute value mapping...</font></a>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            sbHTML.Append("</table>")
            intRecCount += 1
        End While

        If intRecCount = 0 Then
            sbHTML.Append("<tr  class=clsTRColumnHeader align = center>")
            sbHTML.Append("<td>")
            sbHTML.Append("Please map the Attributes to the Project for Value mapping.")
            sbHTML.Append("</td>")
        End If


        'sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("</table>")
        sbHTML.Append("</div>")
        drVal = Nothing
        drAttr = Nothing
        CommonFunction.General.WriteHTML(sbHTML.ToString)
        sbHTML = Nothing
    End Sub

    Private Sub ShowHistory()
        '=====================================================================
        ' Procedure Name        : ShowHistory()	
        ' Purpose               : To display the history
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ArchanaN
        ' Created               : 17-Jul-2010
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim WhizSysValue As String
        Dim WhizSysID As String
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:07/10/15
        WhizSysValue = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("WhizSysval"), "")
        WhizSysID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("WhizSysID"), "")
        strSQL = " usp_FCI_Value_tbl_PM_AuditTrail '" & WhizSysValue.ToString & "'," + WhizSysID

        Dim arrColumnHeadingList() As String = {"Whizible Value", "Previous System Value", "Modified By", "Modified Date"}
        Dim arrActualColumnNames() As String = {"WhizValue", "OldValue", "ModifiedBy", "Date"}
        Dim arrTDStyle() As String = {"align=left style='width=15%'", "align=left width=15%", "align=left width=15%", "align=Left width=15%"}

        CommonFunction.General.WriteHTML("<TABLE id=tblHead cellspacing=1 height='5%' Width='99.9%' class=clsTable style='visibility:visible;display:none'>")
        CommonFunction.General.WriteHTML("<TR><TD align=center class=clsTRPageCaption>")
        CommonFunction.General.WriteHTML("Show History")
        CommonFunction.General.WriteHTML("</TD></TR>")
        CommonFunction.General.WriteHTML("</TABLE>")

        With m_objGrid
            .ActualColumnArray = arrActualColumnNames
            .UserFriendlyColumnArray = arrColumnHeadingList
            .NoOfDataColumns = 5
            .TDStyleArray = arrTDStyle
            .DIVStyle = "overflow:auto"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivMain"
            .DIVHeight = 330%
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strSQL
            .UseSQL = True
            .PrimaryKey = "LogID"
            '.SortBy = "AttachedBy,DateAttached"
            '.SortOrder = "Desc"
            .DrawGrid()

        End With
        m_objGrid = Nothing
    End Sub
End Class






