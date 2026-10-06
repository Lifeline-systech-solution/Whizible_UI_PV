Option Strict Off
Public Class HR_Employee_ApplicableSections
    'Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate

#Region "Variable Declaration"
    Private m_intEmployeeID As Integer = 0
    Private m_strEmployeeName As String = ""
    Protected WithEvents m_objMenu As WebPage.Templates.StaticMenu
    Private m_strMenuGroupIDs As String = ""
    Private m_strModuleShortName As String = "" 'Added By KapilGK on 13-Aug-2008
#End Region


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
    End Sub
    Public Sub InitPage()
        '=====================================================================
        ' Procedure Name        : InitPage()
        ' Purpose               : To initialise page
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SujitG
        ' Created               : 01 Aug 2008
        ' Revisions             :
        '=====================================================================
        Dim strMenu As String = ""
        Dim strHTML As New System.Text.StringBuilder

        m_intEmployeeID = HttpContext.Current.Session("intUserID")
        m_strEmployeeName = HttpContext.Current.Session("strUserName")

        'Added by KapilGK on 13-Aug-2008
        m_strModuleShortName = HttpContext.Current.Session("strShortName")
        'End of Addition By KapilGK on 13-Aug-2008

        If Not HttpContext.Current.Request.QueryString("Mode") Is Nothing Then
            If HttpContext.Current.Request.QueryString("Mode").ToUpper = "SAVE" Then
                SaveResponse()
                RefreshParent()
            End If
        End If

        strMenu = DrawMenu()
        CommonFunction.General.WriteHTML(strMenu)
        strHTML.Append("<div ID=PageDiv style='overflow:auto;width:100%;height:100%;'>")
        strHTML.Append("<BR><TABLE cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
        strHTML.Append("<TR class=clsTRPageCaption width=100%><TD align=Left width=50%>")
        strHTML.Append("Employee Sections")
        strHTML.Append("</TD><TD align=Right width=50%>Employee Name : ")
        strHTML.Append(m_strEmployeeName)
        strHTML.Append("</TD></TR></Table><BR>")
        CommonFunction.General.WriteHTML(strHTML.ToString)
        DrawGrid()
        DrawHidden()
        CommonFunction.General.WriteHTML("</DIV>")
        CommonFunction.General.WriteHTML(strMenu)
        strHTML = Nothing
    End Sub
#Region "Grid"
    Private Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : DrawGrid()
        ' Purpose               : To draw grid
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SujitG
        ' Created               : 01 Aug 2008
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = ""
        Dim drGrid As IDataReader
        Dim strHTML As New System.Text.StringBuilder
        Dim strClass As String = "clsTROdd"
        strSQL = "usp_Sel_tbl_UI_ControlMenuGroup_User " & m_intEmployeeID.ToString

        If m_strModuleShortName <> "" Then
            strSQL += ",'" + m_strModuleShortName + "'"
        Else
            strSQL += ",NULL"
        End If

        drGrid = CommonFunction.Data.GetDataReader(strSQL, True)

        strHTML.Append("<BR><TABLE class='clsGridTable' cellspacing='1' cellpadding=0 width='99.9%'>")
        strHTML.Append("<TR class = 'clsTRColumnHeader'>")
        strHTML.Append("<TD align='center'>Show</TD>")
        strHTML.Append("<TD align='left'>Section Name</TD>")
        ' strHTML.Append("<TD align='center'>Order Number</TD>")
        '''strHTML.Append("<TD align='center'>Maximum Items</TD>")
        strHTML.Append("</TR>")

        While drGrid.Read()
            strHTML.Append("<TR class = '" & strClass & "'>")
            'strHTML.Append("<TD align='center'>" & CommonFunction.HTMLControls.DrawCheckBox("chkIsAppicable_" + drGrid("MenuGroupID").ToString, "chkIsAppicable_" + drGrid("MenuGroupID").ToString, , CommonFunction.Data.CheckIsDBNull(drGrid("IsApplicable"), "0"), drGrid("MenuGroupID").ToString, , " Onclick=Javascript:Applicable_OnCheck(" & drGrid("MenuGroupID").ToString & ")", True, ) & "</TD>")

            strHTML.Append("<TD align='center'>" & CommonFunction.HTMLControls.DrawCheckBox("chkIsAppicable_" + drGrid("MenuGroupID").ToString, "chkIsAppicable_" + drGrid("MenuGroupID").ToString, , CommonFunction.Data.CheckIsDBNull(drGrid("IsApplicable"), "0"), drGrid("MenuGroupID").ToString, , , True) & "</TD>")
            strHTML.Append("<TD align='left'>" & CommonFunction.Data.CheckIsDBNull(drGrid("MenuGroup"), "") & "</TD>")
            ' strHTML.Append("<TD align='center'>" & CommonFunction.HTMLControls.DrawTextBox("txtOrderNumber_" + drGrid("MenuGroupID").ToString, "txtOrderNumber_" + drGrid("MenuGroupID").ToString, , 50, 4, IIf(CommonFunction.Data.CheckIsDBNull(drGrid("IsApplicable"), "0") = "0", "", CommonFunction.Data.CheckIsDBNull(drGrid("OrderNumber"), "").ToString), "right", , IIf(CommonFunction.Data.CheckIsDBNull(drGrid("IsApplicable"), "0") = "0", "true", "false"), , , , , True) & "</TD>")
            '''strHTML.Append("<TD align='center'>" & CommonFunction.HTMLControls.DrawTextBox("txtMaxControlLimit_" + drGrid("MenuGroupID").ToString, "txtMaxControlLimit_" + drGrid("MenuGroupID").ToString, , 50, 4, IIf(CommonFunction.Data.CheckIsDBNull(drGrid("IsApplicable"), "0") = "0", "", CommonFunction.Data.CheckIsDBNull(drGrid("MaxControlLimit"), "").ToString), "right", , IIf(CommonFunction.Data.CheckIsDBNull(drGrid("IsApplicable"), "0") = "0", "true", "false"), , , , , True) & "</TD>")
            strHTML.Append("</TR>")
            m_strMenuGroupIDs = m_strMenuGroupIDs + drGrid("MenuGroupID").ToString + ","
            If strClass = "clsTROdd" Then
                strClass = "clsTREven"
            Else
                strClass = "clsTROdd"
            End If
        End While

        strHTML.Append("</Table>")
        CommonFunctions.Data.DisposeDataReader(drGrid)
        CommonFunction.General.WriteHTML(strHTML.ToString)
        strHTML = Nothing
    End Sub
    Private Sub DrawHidden()
        '=====================================================================
        ' Procedure Name        : DrawHidden()
        ' Purpose               : To draw hidden controls
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SujitG
        ' Created               : 01 Aug 2008
        ' Revisions             :
        '=====================================================================
        If m_strMenuGroupIDs <> "" Then
            m_strMenuGroupIDs = m_strMenuGroupIDs.Substring(0, m_strMenuGroupIDs.Length - 1)
        End If
        ''CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtHidMenuGroupIDs", "txtHidMenuGroupIDs", , , , m_strMenuGroupIDs, , , , , , True, , True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtHidMenuGroupIDs", "txtHidMenuGroupIDs", , , , m_strMenuGroupIDs, , , , , , True, , True, EnableHTMLEncode:=True))
    End Sub
#End Region
    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu()
        ' Purpose               : To draw menu
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SujitG
        ' Created               : 01 Aug 2008
        ' Revisions             :
        '=====================================================================
        Dim arrMenu() As String = {"<Img Border=0 src='../../Images/cssImages/Link images/save.gif'> Save", "<Img Border=0 src='../../Images/cssImages/Link images/Close.gif'> Close", "<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>"}
        Dim arrMenuToolTip() As String = {"Save", "Close", "Help"}
        Dim arrClientSideFunctions() As String = {"Save_onClick()", "Close_OnClick()", "OpenHelpPage('EmployeeSections')"}
        m_objMenu = New WebPage.Templates.StaticMenu
        DrawMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
    End Function
    Private Sub SaveResponse()
        '=====================================================================
        ' Procedure Name        : SaveResponse()
        ' Purpose               : To save the user response
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SujitG
        ' Created               : 04 Aug 2008
        ' Revisions             :
        '=====================================================================
        Dim strHidMenuGroupIDs As String = ""
        Dim intOrderNumber As Integer = 0
        Dim intMaxControlLimit As Integer = 0
        Dim objChkIsAppicable As String = ""
        Dim intCount As Integer = 0
        Dim intMaxControlNumber As Integer = 0
        Dim strSQL As String = ""

        strHidMenuGroupIDs = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtHidMenuGroupIDs"), "").ToString
        Dim arrHidMenuGroupIDs As String() = strHidMenuGroupIDs.Split(",")
        For intCount = 0 To arrHidMenuGroupIDs.Length - 1
            intMaxControlNumber = 0
            intOrderNumber = 0
            objChkIsAppicable = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkIsAppicable_" + arrHidMenuGroupIDs(intCount)), "0").ToString
            If objChkIsAppicable <> "0" Then
                'intMaxControlNumber = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtMaxControlLimit_" + arrHidMenuGroupIDs(intCount)), "0").ToString, Integer)
                ' intOrderNumber = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtOrderNumber_" + arrHidMenuGroupIDs(intCount)), "0").ToString, Integer)
                ' strSQL = "usp_Ins_Upd_tbl_UI_ControlMenuGroup_User " + m_intEmployeeID.ToString + "," + arrHidMenuGroupIDs(intCount) + "," + objChkIsAppicable + "," + intOrderNumber.ToString + "," + intMaxControlNumber.ToString + ",0"
                strSQL = "usp_Ins_Upd_tbl_UI_ControlMenuGroup_User " + m_intEmployeeID.ToString + "," + arrHidMenuGroupIDs(intCount) + "," + objChkIsAppicable + ",NULL," + intMaxControlNumber.ToString + ",0"
                CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            Else
                'strSQL = "usp_Ins_Upd_tbl_UI_ControlMenuGroup_User " + m_intEmployeeID.ToString + "," + arrHidMenuGroupIDs(intCount) + "," + objChkIsAppicable + "," + intOrderNumber.ToString + "," + intMaxControlNumber.ToString + ",1"
                strSQL = "usp_Ins_Upd_tbl_UI_ControlMenuGroup_User " + m_intEmployeeID.ToString + "," + arrHidMenuGroupIDs(intCount) + "," + objChkIsAppicable + ",NULL," + intMaxControlNumber.ToString + ",1"
                CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            End If
        Next
    End Sub
    Private Sub RefreshParent()
        '=====================================================================
        ' Procedure Name        : InitPage()
        ' Purpose               : To refresh the parent page
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SujitG
        ' Created               : 04 Aug 2008
        ' Revisions             :
        '=====================================================================
        Response.Write("<script language= javascript> " + vbCrLf)
        CommonFunctions.General.WriteHTML("window.opener.document.forms['frmHome_TabUI'].action = '../Home/MyHome_TabUI.aspx?ShortName=TabUI&FromWhere=TABUI';" + vbCrLf)
        CommonFunctions.General.WriteHTML("window.opener.document.forms['frmHome_TabUI'].submit();" + vbCrLf)
        CommonFunctions.General.WriteHTML("window.close(); " + vbCrLf)
        Response.Write("</script>")

    End Sub
End Class