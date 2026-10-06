Public Partial Class PM_OutlookConfiguration
    Inherits WebPages.Template.WhizTemplate
    Protected strHTML As New System.Text.StringBuilder
    Protected WithEvents m_objMenu As WebPage.Templates.StaticMenu
    Private m_intUserID As Integer
    Protected m_strEntityIDs As String = ""
    Dim m_strCopy As String = "0"
    'Dim m_strSelectValue As String
    'Dim arrSelectValue() As String
    Dim m_strSelectValue As String
    Private sbICSFile As StringBuilder = New StringBuilder()
    Protected m_strFlag As String = "0"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ''Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        If Not IsPostBack Then
            Dim dtNow As DateTime = DateTime.Parse(DateTime.Now.ToShortDateString())
        End If
        Call InitVariables()
    End Sub
    Public Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To draw page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : NA
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Sonal Danej
        ' Created               : 5,August 2008
        ' Revisions             :
        '=====================================================================
        Dim strMenu As String

        strMenu = GenerateMenu()
        strHTML.Append(strMenu)

        If Request.QueryString("Action") = "SAVE" Then
            Call SaveData()
        End If

        If Request.QueryString("Action") = "RESET" Then
            Call ResetData()
        End If

        Call DrawPage()
        Call drawHiddenControls()

        strHTML.Append(strMenu)
        Response.Write(strHTML.ToString())
    End Sub
    Private Function GenerateMenu()
        Dim arrMenuList As New ArrayList
        Dim arrMenuToolTipList As New ArrayList
        Dim arrClientSideFunctionsList As New ArrayList

        arrMenuList.Add("<img border=0 src='..\..\Images\cssImages\Link images\save.gif'>&nbsp;&nbsp;Save Settings&nbsp;")
        arrMenuToolTipList.Add("Save Settings")
        arrClientSideFunctionsList.Add("Save_OnClick()")

        arrMenuList.Add("<img border=0 src='..\..\Images\cssImages\Link images\clearall.gif'>&nbsp;&nbsp;Disable Alerts&nbsp;")
        arrMenuToolTipList.Add("Disable Alerts")
        arrClientSideFunctionsList.Add("Reset_OnClick()")

        arrMenuList.Add("<img border=0 src='..\..\Images\cssImages\Link images\approve.gif'>&nbsp;&nbsp;Create Calender Entries&nbsp;")
        arrMenuToolTipList.Add("Create Calender Entries")
        arrClientSideFunctionsList.Add("IntegrateNow_OnClick()")

        arrMenuList.Add("<img border=0 src='..\..\Images\cssImages\Link images\showhistory.gif'>&nbsp;&nbsp;Show History&nbsp;")
        arrMenuToolTipList.Add("Show History")
        arrClientSideFunctionsList.Add("ShowHistory_Onclick()")

        arrMenuList.Add("<Img Border=0 src='..\..\Images\cssImages\Link images\help.gif'>")
        arrMenuToolTipList.Add("Help")
        arrClientSideFunctionsList.Add("Help_OnClick('ConfigureOutlook')")

        Dim arrMenu() As String = GetArray(arrMenuList)
        Dim arrMenuToolTip() As String = GetArray(arrMenuToolTipList)
        Dim arrClientSideFunctions() As String = GetArray(arrClientSideFunctionsList)

        m_objMenu = New WebPage.Templates.StaticMenu
        GenerateMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
    End Function
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function
    Private Sub InitVariables()
        Dim strEntityList As String
        Dim arrSelEntity() As String
        Dim Iterator As Integer
        m_intUserID = HttpContext.Current.Session("intUserID")

        If CommonFunctions.General.CheckIsNothing(Request.Form("hidEntityIDs"), "") <> "" Then
            strEntityList = Request.Form("hidEntityIDs")
            arrSelEntity = strEntityList.Split(",c")
            For Iterator = 0 To arrSelEntity.Length - 1
                If CommonFunctions.General.CheckIsNothing(Request.Form("chkEntity_" + arrSelEntity(Iterator)), "") <> "" Then
                    m_strSelectValue = m_strSelectValue + Request.Form("chkEntity_" + arrSelEntity(Iterator)) + ","
                End If
            Next
        End If
        If Len(m_strSelectValue) > 0 Then
            m_strSelectValue = Left(m_strSelectValue, Len(m_strSelectValue) - 1)
        End If
        m_strCopy = CommonFunction.General.CheckIsNothing(Request.QueryString("Copy"), "0")
        If CommonFunction.General.CheckIsNothing(Request.Form("hidEntityIDs"), "") <> "" Then
            m_strEntityIDs = CommonFunctions.General.CheckIsNothing(Request.Form("hidEntityIDs"), "")
        End If
    End Sub
    Private Sub SaveData()
        Dim strSQL As String
        Dim arrSelectValue() As String
        Dim txtStartingInDays As String
        Dim txtEndingInDays As String
        Dim i As Integer

        If m_strSelectValue <> "" Then
            arrSelectValue = m_strSelectValue.Split(","c)
            'make entry in tbl_PM_OutLookConfigureEntityDetail for all the entities selected by employee
            For i = 0 To arrSelectValue.Length - 1
                'txtStartingInDays = CommonFunction.General.CheckIsNothing(Request.Form("txtEntityStart_" + arrSelectValue(i)), 0)
                txtEndingInDays = CommonFunction.General.CheckIsNothing(Request.Form("txtEntityEnd_" + arrSelectValue(i)), 0)
                'If txtStartingInDays = "" Then
                '    txtStartingInDays = "null"
                'End If
                If txtEndingInDays = "" Then
                    txtEndingInDays = "null"
                End If
                'strSQL = "usp_INS_tbl_PM_OutLookConfigureEntityDetail " + m_intUserID.ToString + "," + arrSelectValue(i) + "," + txtStartingInDays + "," + txtEndingInDays + ""
                strSQL = "usp_INS_tbl_PM_OutLookConfigureEntityDetail " + m_intUserID.ToString + "," + arrSelectValue(i) + "," + txtEndingInDays + ""
                CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            Next
            'to delete entry if checkbox is deselected
            strSQL = "usp_Del_tbl_PM_OutLookConfigureEntityDetail " + m_intUserID.ToString + ",'" + m_strSelectValue + "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
        End If

        m_strFlag = "1"
        'If m_strSelectValue = "" Then
        '    strSQL = "DELETE FROM tbl_PM_OutLookConfigureEntityDetail WHERE EmployeeID=" + m_intUserID.ToString
        '    CommonFunction.Data.InsertOrUpdateData(strSQL, True)
        'End If
    End Sub
    Private Sub ResetData()
        Dim strSQL As String
        Dim selectedvalues As String
        selectedvalues = "null"
        'strSQL = "DELETE FROM tbl_PM_OutLookConfigureEntityDetail WHERE EmployeeID=" + m_intUserID.ToString
        strSQL = "usp_Del_tbl_PM_OutLookConfigureEntityDetail " + m_intUserID.ToString + "," + selectedvalues
        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
    End Sub
    Private Sub DrawPage()
        Dim strSQL As String
        Dim strEntityName As String
        Dim intEntityID As Integer
        Dim dr As IDataReader
        Dim IsChecked As Boolean
        Dim StartingInDays As String
        Dim EndingInDays As String
        m_strEntityIDs = ""
        strSQL = "usp_sel_tbl_PM_OutLookConfigureEntityDetail " + m_intUserID.ToString
        dr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        strHTML.Append("<div ID='PageDiv' Style='HEIGHT:99.99%;OVERFLOW:auto; WIDTH:100%'>")
        strHTML.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>" + vbCrLf)
        strHTML.Append("<br>")
        'strHTML.Append("<tr class='clsTRBody'>")
        'strHTML.Append("'Starting in days' & 'Ending in days' will be added to current date at the time of integration to determine start date & end date respectively.")
        'strHTML.Append("</tr>")
        strHTML.Append("<br>")
        While dr.Read()
            strEntityName = dr("EntityName")
            intEntityID = dr("EntityID")
            IsChecked = dr("IsChecked")
            StartingInDays = CommonFunction.General.CheckIsNothing(dr("StartingInDays"), "")
            EndingInDays = CommonFunction.General.CheckIsNothing(dr("EndingInDays"), "")
            strHTML.Append("<tr class='clsTREven'>" + vbCrLf)
            strHTML.Append("<td WIDTH=80 align=right>")
            strHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkEntity_" + intEntityID.ToString, "chkEntity_" + intEntityID.ToString, , IsChecked, intEntityID.ToString, , "Onclick='Javascript:Chk_Select(id,value)' ", True))
            strHTML.Append("</td>")
            strHTML.Append("<td WIDTH=140 ALIGN=LEFT>")
            strHTML.Append(strEntityName)
            strHTML.Append("</td>")
            'strHTML.Append("<td WIDTH=60 ALIGN=LEFT>")
            'strHTML.Append("Starting in ")
            'strHTML.Append("</td>")
            'strHTML.Append("<td WIDTH=30 ALIGN=LEFT>")
            'strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtEntityStart_" + intEntityID.ToString, "txtEntityStart_" + intEntityID.ToString, "clsTextBox", 30, 3, StartingInDays, "right", , False, , , , , True))
            'strHTML.Append("</td>")
            'strHTML.Append("<td ALIGN=LEFT>")
            'strHTML.Append(" days")
            'strHTML.Append("</td>")
            'strHTML.Append("</tr>")

            'strHTML.Append("<tr class='clsTROdd'>" + vbCrLf)
            'strHTML.Append("<td></td>")
            'strHTML.Append("<td ></td>")
            strHTML.Append("<td WIDTH=70 ALIGN=LEFT>")
            strHTML.Append("Due in next ")
            strHTML.Append("</td>")
            strHTML.Append("<td WIDTH=30 ALIGN=LEFT>")
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtEntityEnd_" + intEntityID.ToString, "txtEntityEnd_" + intEntityID.ToString, "clsTextBox", 30, 3, EndingInDays, "right", , False, , , , , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTML.Append("</td>")
            strHTML.Append("<td ALIGN=LEFT>")
            strHTML.Append(" days")
            strHTML.Append("</td>")
            strHTML.Append("</tr>")
            m_strEntityIDs = m_strEntityIDs + intEntityID.ToString + ","
        End While
        strHTML.Append("</table>")
        strHTML.Append("</div>")
        CommonFunction.Data.DisposeDataReader(dr)
    End Sub

    Protected Function FormatDateTimeValue(ByVal DateValue As Int16) As String
        If DateValue < 10 Then
            Return "0" + DateValue.ToString()
        Else
            Return DateValue.ToString()
        End If
    End Function
    Private Sub drawHiddenControls()
        'm_strEntityIDs holds list of all the Entity ids
        strHTML.Append("<input type=hidden name=hidEntityIDs id=hidEntityIDs value=" + m_strEntityIDs + ">" + vbCrLf)
        'm_strSelectValue holds list of selected Entity ids
        strHTML.Append("<input type=hidden name=hidSelectedEntityIDs id=hidSelectedEntityIDs value=" + m_strSelectValue + ">" + vbCrLf)
    End Sub
End Class