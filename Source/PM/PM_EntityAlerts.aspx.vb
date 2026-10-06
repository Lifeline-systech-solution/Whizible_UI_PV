Public Partial Class PM_EntityAlerts
    Inherits WebPages.Template.WhizTemplate
    Private strHTML As New System.Text.StringBuilder
    Private WithEvents m_objMenu As WebPage.Templates.StaticMenu
    Protected m_intRefreshParent As Integer
    'Private strAlertName As String
    'Private strDescription As String
    'Private Active As Integer
    Private EmployeeAlertID As String
    'Private strAlertEntityID As String
    Protected strAlertEntityID As String
    Private strUserID As String
    Protected m_TokenKEY As String
    'Added by tejal D Purpose PKToken on 13/8/2016
    Private m_blnValidate As Boolean = True

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
          MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        Call InitVariables()
        If Request.QueryString("action") = "SAVE" Then
            Call SaveData()
        ElseIf Request.QueryString("action") = "SAVEADD" Then
            Call SaveData()
            EmployeeAlertID = ""
        End If
    End Sub
    Private Sub InitVariables()

        'strAlertName = CommonFunction.General.CheckIsNothing(Request.Form("txtAlertName"), "").ToString()
        'strDescription = CommonFunction.General.CheckIsNothing(Request.Form("txtDescription"), "").ToString()
        'Active = CType(CommonFunction.General.CheckIsNothing(Request.Form("chkActive"), 0), Integer)
        EmployeeAlertID = CommonFunction.General.CheckIsNothing(Request.QueryString("EmployeeAlertID"), "").ToString()


        If EmployeeAlertID Is Nothing OrElse EmployeeAlertID = "" Then
            EmployeeAlertID = CommonFunction.General.CheckIsNothing(Request.Form("hidEmployeeAlertID"), "")
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("AlertEntityID"), "") <> "" Then
            strAlertEntityID = Request.QueryString("AlertEntityID")
        ElseIf CommonFunction.General.CheckIsNothing(Request.Form("hidAlertEntityID"), "") <> "" Then
            strAlertEntityID = Request.Form("hidAlertEntityID")
        End If
        If CommonFunction.General.CheckIsNothing(Request.QueryString("PKToken"), "") <> "" Then
            m_TokenKEY = Request.QueryString("PKToken")
        End If
        ''added by Nilesh g on 1/3/2016 for check Token
        If (m_TokenKEY = "" And HttpContext.Current.Session("intUserID") <> 0) Then
            m_blnValidate = False
        ElseIf (strAlertEntityID <> "0") Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(strAlertEntityID, String) + CType(Session("intUserID"), String) + "0" + "0", m_TokenKEY) = False) Then
                m_blnValidate = False
            End If
        End If
        ''end of added by Nilesh g on 1/3/2016 for check Token
        'added by Tejal D purpose pk token Validate 13/8/2016
        If (m_blnValidate = False) Then
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'End of addtion by Tejal D purpose pk token Validate 13/8/2016

        strUserID = HttpContext.Current.Session("intUserID")

        m_TokenKEY = CommonFunctions.Security.Token.GetToken(CType(strAlertEntityID, String) + CType(Session("intUserID"), String) + "0" + "0")
        m_intRefreshParent = 0
    End Sub
    Protected Sub WritePage()
        Dim strMenu As String

        strMenu = GenerateMenu()
        strHTML.Append(strMenu)

        Call DrawControls()
        Call drawHiddenControls()

        strHTML.Append(GenerateMenu())

        Response.Write(strHTML.ToString())
    End Sub
    Private Sub DrawControls()
        Dim dr As IDataReader
        Dim strQuery As String

        Dim AlertName As String = ""
        Dim Description As String = ""
        Dim Active As Boolean
        Dim objHref As New WebPages.UI.cDynamicLink
        Dim strProject_FieldList As String
        Dim strSelectedProjects As String
        Dim m_strOldProjectIDs As String
        Dim strReleasedProj As String


        ''strQuery = "usp_sel_tbl_EmployeeAlerts " & EmployeeAlertID
        ''dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        ''If dr.Read() Then
        ''    AlertName = dr("AlertName").ToString()
        ''    Description = dr("AlertDescription").ToString()
        ''    Active = CType(dr("Active"), Boolean)
        ''End If

        '''Mandatory Image
        ''strHTML.Append("<TABLE CellSpacing=0 width='100%' class=clsTable>" + vbCrLf)
        ''strHTML.Append("<TR class=clsTRBlank>" + vbCrLf)
        ''strHTML.Append("<TD align='Right'><B>(<IMG src='../../Images/Star.gif' border=0> Mandatory)</B>" + vbCrLf)
        ''strHTML.Append("</TD>" + vbCrLf)
        ''strHTML.Append("</TR>" + vbCrLf)
        ''strHTML.Append("</TABLE>" + vbCrLf)
        ''strHTML.Append("<BR>" + vbCrLf)
        '''Page Caption
        ''strHTML.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
        ''strHTML.Append("<TR class=clsTRPageCaption><TD align=Left>Alert</TD>" + vbCrLf)
        ''strHTML.Append("</TR>" + vbCrLf)
        ''strHTML.Append("</TABLE>" + vbCrLf)
        ''strHTML.Append("<BR>" + vbCrLf)
        '''Controls
        ''strHTML.Append("<DIV Id=PageDiv Style='OVERFLOW:auto;WIDTH:99.9%;'>" + vbCrLf)

        ''strHTML.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable align=center>" + vbCrLf)
        ''strHTML.Append("<TR class=clsTRBody>" + vbCrLf)
        ''strHTML.Append("<TD align='Right'>Alert Name" + vbCrLf)
        ''strHTML.Append("</TD>" + vbCrLf)
        ''strHTML.Append("&nbsp;<TD align='left'>" + vbCrLf)
        ''strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtAlertName", "txtAlertName", , 450, 200, AlertName, returnHTML:=True, IsMandatory:=True) + vbCrLf)
        ''strHTML.Append("</TD>" + vbCrLf)
        ''strHTML.Append("</TR>" + vbCrLf)

        ''strHTML.Append("<TR class=clsTRBody>" + vbCrLf)
        ''strHTML.Append("<TD align='Right'>Description" + vbCrLf)
        ''strHTML.Append("</TD>" + vbCrLf)
        ''strHTML.Append("<TD align='left'>&nbsp;" + vbCrLf)
        ''strHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtDescription", "txtDescription", value:=Description, widthInPixel:=450, heightInPixel:=70, returnHTML:=True) + vbCrLf)
        ''strHTML.Append("</TD>" + vbCrLf)
        ''strHTML.Append("</TR>" + vbCrLf)

        ''strHTML.Append("<TR class=clsTRBody>" + vbCrLf)
        ''strHTML.Append("<TD align='Right'>Active" + vbCrLf)
        ''strHTML.Append("</TD>" + vbCrLf)
        ''strHTML.Append("<TD align='left'>&nbsp;" + vbCrLf)
        ''strHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkActive", "chkActive", , Active, 1, , , True) + vbCrLf)
        ''strHTML.Append("</TD>" + vbCrLf)
        ''strHTML.Append("</TR>" + vbCrLf)

        ''strHTML.Append("<TR class=clsTRBody>" + vbCrLf)
        ''strHTML.Append("<td></td>")
        ''strHTML.Append("<TD align='left'>&nbsp;<A HREF='JAVASCRIPT:selectAlerts(" + EmployeeAlertID + ")'>Select Alert Entity</A>" + vbCrLf)
        ''strHTML.Append("</TD>" + vbCrLf)
        '''strHTML.Append("&nbsp;<TD align='left'>" + vbCrLf)
        '''strHTML.Append("Selected Alerts" + vbCrLf)
        '''strHTML.Append("</TD>" + vbCrLf)
        ''strHTML.Append("</TR>" + vbCrLf)

        ''strHTML.Append("</TABLE>" + vbCrLf)

        'Project ListBoxes

        'strHTML.Append("<HR>" + vbCrLf)

        strHTML.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
        strHTML.Append("<TR class=clsTRPageCaption><TD align=Left>Project Selection</TD>" + vbCrLf)
        strHTML.Append("</TR>" + vbCrLf)
        strHTML.Append("</TABLE>" + vbCrLf)
        strHTML.Append("<BR>" + vbCrLf)

        strHTML.Append("<table cellspacing='0' class='clsTable' width='99.9%'>")
        strHTML.Append("<tr class='clsTRBody'><td align='middle'>")
        strHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;List of Projects")
        strHTML.Append("</td><td></td>")
        strHTML.Append("<td colspan='2' width='150px' align='left'>")
        strHTML.Append("Selected Projects")
        strHTML.Append("</td></tr>")

        strHTML.Append("<tr class='clsTRBody'><td style='width:30%' rowspan='4' align='right' >")

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strReleasedProj = CType(CommonFunction.Data.GetDataScalar("SELECT ShowEvenReleaseFromProject FROM tbl_PM_CompanyInformation", MyBase.UseSQL), Integer)
        strReleasedProj = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_ShowEvenReleaseFromProject", MyBase.UseSQL), Integer)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        If EmployeeAlertID = "" Then
            strProject_FieldList = "usp_Sel_AccessibleProjects_ForProjectAlerts " + Session("intUserID").ToString() + ",0,0,NULL,0,'E'," + strReleasedProj + ",NULL,0,0,NULL," + strAlertEntityID
        Else
            strProject_FieldList = "usp_Sel_AccessibleProjects_ForProjectAlerts " + Session("intUserID").ToString() + ",0,0,NULL,0,'E'," + strReleasedProj + ",NULL,0,0,NULL," + EmployeeAlertID
        End If


        'strTemp = "OnDblClick = 'lstTest_FieldList_OnDblClick_Custom()'" ' Onfocus= 'lstTest_FieldList_onfocus()'"
        strHTML.Append(CommonFunctions.HTMLControls.DrawListBox("lstProject_FieldList", strProject_FieldList, 260, 350, , "OnDblClick = 'lstProject_FieldList_OnDblClick_Custom()'", , True))
        strHTML.Append("</td>")

        'Commented And Added By Chakshuta H on 16th-Oct-2015 Purpose::QA issue fixing
        'strHTML.Append("<td align='middle' style='width: 20%;'>")
        strHTML.Append("<td align='middle' style='width: 20%; vertical-align: middle;'>")
        'End Of Commented And Added By Chakshuta H on 16th-Oct-2015 Purpose::QA issue fixing

        objHref.FunctionName = "btnProject_AddAll_OnClick_Custom()"
        objHref.LinkName = "<img src='../../images/allright.gif' border='0' height='14' width='18'>"
        objHref.ReturnHTML = True
        strHTML.Append(objHref.GetDynamicLink())
        strHTML.Append("</td>")

        strHTML.Append("<td style='width:30%' rowspan='4'>")

        'Commented and modified by SuchitraP on 5-Nov-2008
        'strSelectedProjects = "usp_Sel_tbl_PM_AlertWiseProjects " + EmployeeAlertID
        'm_strOldProjectIDs = "usp_Sel_tbl_PM_AlertWiseProjects " + EmployeeAlertID

        strSelectedProjects = "usp_Sel_tbl_PM_AlertWiseProjects " + strAlertEntityID + "," + strUserID
        m_strOldProjectIDs = "usp_Sel_tbl_PM_AlertWiseProjects " + strAlertEntityID + "," + strUserID
        'End by SuchitraP


        'strTemp = "OnDblClick = 'lstProject_SelectedFields_OnDblClick_Custom()'" ' Onfocus= 'lstTest_SelectedFields_onfocus()'"
        strHTML.Append(CommonFunctions.HTMLControls.DrawListBox("lstProject_SelectedFields", strSelectedProjects, 260, 350, , "OnDblClick = 'lstProject_SelectedFields_OnDblClick_Custom()'", , True))
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txthidSelectedProjectFields", "txthidSelectedProjectFields", , , , m_strOldProjectIDs, , , , , , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML.Append("</td>")
        strHTML.Append("</tr>")

        strHTML.Append("<tr class='clsTRBody'><td align='middle'>")
        objHref.FunctionName = "btnProject_AddSelected_OnClick_Custom()"
        objHref.LinkName = "<img src='../../images/right.gif' border='0' height='14' width='18'>"
        objHref.ReturnHTML = True
        strHTML.Append(objHref.GetDynamicLink())
        strHTML.Append("</td>")
        strHTML.Append("</tr>")

        strHTML.Append("<tr class='clsTRBody'><td align='middle'>")
        objHref.FunctionName = "btnProject_RemoveSelected_OnClick_Custom()"
        objHref.LinkName = "<img src='../../images/left.gif' border='0' height='14' width='18'>"
        objHref.ReturnHTML = True
        strHTML.Append(objHref.GetDynamicLink())
        strHTML.Append("</td>")
        strHTML.Append("</tr>")

        strHTML.Append("<tr class='clsTRBody'><td align='middle'>")
        objHref.FunctionName = "btnProject_RemoveAll_OnClick_Custom()"
        objHref.LinkName = "<img src='../../images/allleft.gif' border='0' height='14' width='18'>"
        objHref.ReturnHTML = True
        strHTML.Append(objHref.GetDynamicLink())
        strHTML.Append("</td>")
        strHTML.Append("</tr>")
        strHTML.Append("</table>")


        strHTML.Append("</DIV>" + vbCrLf)

    End Sub

    Private Function GenerateMenu()

        Dim arrMenuList As New ArrayList
        Dim arrMenuToolTipList As New ArrayList
        Dim arrClientSideFunctionsList As New ArrayList

        arrMenuList.Add("<img border=0 src='..\..\Images\cssImages\Link images\save.gif'>Save")
        arrMenuToolTipList.Add("Save")
        arrClientSideFunctionsList.Add("Save_OnClick()")

        'arrMenuList.Add("<img border=0 src='..\..\Images\cssImages\Link images\saveadd.gif'> Save and Add")
        'arrMenuToolTipList.Add("Save and Add")
        'arrClientSideFunctionsList.Add("SaveandAdd_OnClick()")

        'arrMenuList.Add("<Img Border=0 src='../../Images/cssImages/Link images/back.gif'>Back")
        'arrMenuToolTipList.Add("Back")
        'arrClientSideFunctionsList.Add("Back_OnClick()")

        arrMenuList.Add("<Img Border=0 src='../../Images/cssImages/Link images/Close.gif'>Close")
        arrMenuToolTipList.Add("Close")
        arrClientSideFunctionsList.Add("Close_OnClick()")

        arrMenuList.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>")
        arrMenuToolTipList.Add("Help")
        arrClientSideFunctionsList.Add("Help_OnClick('ProjectAlert')")

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

    Private Sub drawHiddenControls()
        strHTML.Append("<input type=hidden name=hidEmployeeAlertID id=hidEmployeeAlertID value=" + EmployeeAlertID + ">" + vbCrLf)
        strHTML.Append("<input type=hidden name=hidAlertEntityID id=hidAlertEntityID value=" + Request.QueryString("AlertEntityID") + ">" + vbCrLf)
    End Sub

    Private Sub SaveData()
        Dim strQuery As String
        Dim EmployeeAlertIDForSP As String
        Dim strProjectIDs As String

        If EmployeeAlertID = "" OrElse EmployeeAlertID Is Nothing Then
            EmployeeAlertIDForSP = "NULL"
        Else
            EmployeeAlertIDForSP = EmployeeAlertID
        End If

        strProjectIDs = CommonFunction.General.CheckIsNothing(Request.Form("lstProject_SelectedFields"), "")

        strQuery = "usp_INS_tbl_EmployeeAlerts " & EmployeeAlertIDForSP & ",'" & strProjectIDs & "'," & strAlertEntityID & "," & strUserID
        EmployeeAlertID = CType(CommonFunction.Data.GetDataScalar(strQuery, MyBase.UseSQL), String)

        'added by sonalD on 16th Sept 2008
        ' refresh parent? set the flag and refresh in window_onload event
        m_intRefreshParent = 1
        'end of addition
    End Sub
End Class