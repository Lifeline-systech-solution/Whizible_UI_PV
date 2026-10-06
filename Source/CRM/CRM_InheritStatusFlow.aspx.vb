Partial Public Class CRM_InheritStatusFlow
    Inherits WebPages.Template.WhizTemplate

    Private m_sbHTML As System.Text.StringBuilder
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private m_FromSubTypeID As String = ""
    Private m_ToSubTypeID As String = ""
    Private m_FromSubTypeID_SP As String
    Private m_ToSubTypeID_SP As String
    Private m_Action As String


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        ''commented by nilesh g on 31/12/2015 for Security
        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            Response.Write(vbCrLf + "<script>")
            Response.Write(vbCrLf + "		if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
            Response.Write(vbCrLf + "</script>")
        End If
        ''end of commented by nilesh g on 31/12/2015 for Security
    End Sub

    Protected Sub PageInit()

        Call InitializeVariables()
        Call GenerateMenu()
        Call DrawPageCaption()

        If m_Action = "INHERIT" Then
            Call InheritTypes()
        End If


        Call DrawPage()
        Call GenerateMenu()


        Response.Write(m_sbHTML.ToString())

    End Sub

    Private Sub InitializeVariables()
        m_sbHTML = New System.Text.StringBuilder

        If Not Request.Form("cboFromType") Is Nothing Then
            m_FromSubTypeID = Request.Form("cboFromType").ToString()
        End If

        If Not Request.Form("cboToType") Is Nothing Then
            m_ToSubTypeID = Request.Form("cboToType").ToString()

        End If
        m_ToSubTypeID_SP = m_ToSubTypeID

        If m_ToSubTypeID = "" Then
            m_ToSubTypeID_SP = "NULL"
        Else
            m_ToSubTypeID_SP = "'" + m_ToSubTypeID + "'"
        End If

        If Not Request.QueryString("Action") Is Nothing Then
            m_Action = Request.QueryString("Action").ToUpper()
        End If

    End Sub

    Private Sub GenerateMenu()
        '====================================================================
        ' Procedure Name        :  GenerateMenu
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To getnerate Menu
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  ShraddhaM
        ' Created               :  27,Oct 2009
        '=====================================================================
        Dim arrMenu As System.Collections.ArrayList = New System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList = New System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList = New System.Collections.ArrayList

        arrMenu.Add("&nbsp;Inherit")
        arrMenuToolTip.Add("Inherit")
        arrClientSideFunctions.Add("Inherit_onClick()")

        arrMenu.Add("<Img Border=0 src='../../Images/cssImages/Link images/close.gif'>&nbsp;Close")
        arrMenuToolTip.Add("Clsoe")
        arrClientSideFunctions.Add("Close_onClick()")


        m_objMenu = New WebPages.Template.StaticMenu
        Dim strmenu As String = m_objMenu.DrawMenuWithEvents(GetArray(arrMenu), GetArray(arrClientSideFunctions), GetArray(arrMenuToolTip), True)
        m_sbHTML.Append(strmenu)

        m_objMenu = Nothing
    End Sub

    Private Function GetArray(ByVal arrList As ArrayList) As String()

        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Private Sub DrawPageCaption()
        m_sbHTML.Append("<Table  cellpadding=0 cellspacing=0 width=100%>")
        m_sbHTML.Append("<tr class='clsTRPageCaption'>")
        m_sbHTML.Append("<td>Inherit Status Flow</td>")
        'm_sbHTMLDIV.Append("<td align=right><a href ='Javascript:CloseDiv()'><img border=0 src = '../../Images/RM/Close.gif' > </a></td>")
        m_sbHTML.Append("</tr>")
        m_sbHTML.Append("</Table><BR>")
    End Sub

    Private Sub DrawPage()

        Dim strClass As String = "clsTRBody"

        m_sbHTML.Append("<div id='PageDiv' style='width:99.99%;height:450px;overflow:auto'>")
        m_sbHTML.Append("<TABLE id='tblHeader' cellpadding=0 cellspacing=0 class='clsTable'  width=99.9% >" + vbCrLf)

        m_sbHTML.Append("<TR class=" + strClass + ">")
        m_sbHTML.Append("<TD align=right>From Sub Request Type</TD>")
        m_sbHTML.Append("<TD>")
        m_sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboFromType", "usp_Sel_InheritRequestTypes 'FromSubType'", 200, m_FromSubTypeID, , True, True, , True))
        m_sbHTML.Append("</TD>")
        m_sbHTML.Append("</TR>")

        m_sbHTML.Append("<TR class=" + strClass + ">")
        m_sbHTML.Append("<TD align=right>To Sub Request Type</TD>")
        m_sbHTML.Append("<TD>")
        m_sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboToType", "usp_Sel_InheritRequestTypes 'ToSubType'," + m_ToSubTypeID_SP, 200, m_ToSubTypeID, , True, True, , True))
        m_sbHTML.Append("</TD>")
        m_sbHTML.Append("</TR>")

        m_sbHTML.Append("</div>")
        m_sbHTML.Append("</Table>")

    End Sub

    Private Sub InheritTypes()
        Dim strQuery As String
        Dim strScript As String = ""
        strQuery = "usp_INS_InheritStatusFlow_tbl_CRM_StatusFlow " + m_FromSubTypeID + "," + m_ToSubTypeID
        CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        strScript = vbCrLf + "<Script language=javascript>"
        strScript += vbCrLf + "window.opener.document.forms[0].action='../General/CommonList.aspx?MasterTagID=919&FromWhere=SM';"
        strScript += vbCrLf + "window.opener.document.forms[0].submit();"
        strScript += vbCrLf + "window.close();"
        strScript += vbCrLf + "</Script>"
        CommonFunction.General.WriteHTML(strScript)

    End Sub
End Class