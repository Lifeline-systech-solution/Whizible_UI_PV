Partial Public Class CRM_InheritDefaultSLA
    Inherits WebPages.Template.WhizTemplate

    Private m_sbHTML As System.Text.StringBuilder
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private m_SubRequestTypeID As String = ""
    Private m_RequestTypeID As String = ""
    Private m_DepartmentID As String = ""
    Private m_CustomerID As String = ""
    Private m_CustomerName As String = ""
    Private m_strCreatedBy As String = ""
    'Private m_FromSubTypeID_SP As String
    'Private m_ToSubTypeID_SP As String
    Private m_Action As String


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting

    End Sub

    Protected Sub PageInit()

        Call InitializeVariables()
        Call GenerateMenu()

        If Request.QueryString("CustomerID") <> "" Then
            m_CustomerID = Request.QueryString("CustomerID")
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''m_CustomerName = CommonFunctions.Data.GetDataScalar("Select CustomerName from tbl_PM_Customer where Customer='" & m_CustomerID & "'", True)
            m_CustomerName = CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Customer_CustomerName '" & m_CustomerID & "'", True)
            ''''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        End If
        Call DrawPageCaption()
        If m_Action = "APPLY" Then
            Call ApplySLA()
        End If

        If Request.QueryString("FromXML") = "1" Then
            Response.Clear()
            Select Case Request.QueryString("From")
                Case "Dept"
                    Response.Write(GetDeptwiseRequestTypes())
                Case "RequestType"
                    Response.Write(GetReqTypeWiseSubTypes())
            End Select
            Response.End()
        End If
        

        Call DrawPage()
        Call GenerateMenu()


        Response.Write(m_sbHTML.ToString())

    End Sub

    Private Sub InitializeVariables()
        m_sbHTML = New System.Text.StringBuilder

        If Not Request.Form("cboDepartment") Is Nothing Then
            m_DepartmentID = Request.Form("cboDepartment").ToString()
        End If

        If Not Request.Form("cboRequestType") Is Nothing Then
            m_RequestTypeID = Request.Form("cboRequestType").ToString()
        End If

        If Not Request.Form("cboSubrequestType") Is Nothing Then
            m_SubRequestTypeID = Request.Form("cboSubrequestType").ToString()
        End If
        If Not Request.Form("txtHidCustomerID") Is Nothing Then
            m_CustomerID = Request.Form("txtHidCustomerID").ToString()
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

        arrMenu.Add("&nbsp;Apply")
        arrMenuToolTip.Add("Apply")
        arrClientSideFunctions.Add("Apply_onClick()")

        arrMenu.Add("<Img Border=0 src='../../Images/cssImages/Link images/close.gif'>&nbsp;Close")
        arrMenuToolTip.Add("Close")
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
        m_sbHTML.Append("<td>Apply Default SLA For :  ")
        m_sbHTML.Append(m_CustomerName)
        m_sbHTML.Append("</td>")
        'm_sbHTMLDIV.Append("<td align=right><a href ='Javascript:CloseDiv()'><img border=0 src = '../../Images/RM/Close.gif' > </a></td>")
        m_sbHTML.Append("</tr>")
        m_sbHTML.Append("</Table><BR>")
    End Sub

    Private Sub DrawPage()

        Dim strClass As String = "clsTRBody"

        m_sbHTML.Append("<div id='PageDiv' style='width:99.99%;height:450px;overflow:auto'>")
        m_sbHTML.Append("<TABLE id='tblHeader' cellpadding=0 cellspacing=0 class='clsTable'  width=99.9% >" + vbCrLf)

        m_sbHTML.Append("<TR class=" + strClass + ">")
        m_sbHTML.Append("<TD align=right>Department</TD>")
        m_sbHTML.Append("<TD>")
        m_sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboDepartment", "USP_sel_DepartmentsForCustomerSLA 1", 200, , "onchange=cboDepartment_onChange()", True, True, , True))
        m_sbHTML.Append("</TD>")
        m_sbHTML.Append("<TD>")
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        m_sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtHidCustomerID", "txtHidCustomerID", , , , m_CustomerID, , , , , , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:05/10/15
        m_sbHTML.Append("</TD>")
        m_sbHTML.Append("</TR>")

        m_sbHTML.Append("<TR class=" + strClass + ">")
        m_sbHTML.Append("<TD align=right>Request Type</TD>")
        m_sbHTML.Append("<TD>")
        m_sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboRequestType", "select '' where 1=2", 200, , " onchange=cboRequestType_onChange() ", True, True, , True))

        m_sbHTML.Append("</TD>")
        m_sbHTML.Append("</TR>")

        m_sbHTML.Append("<TR class=" + strClass + ">")
        m_sbHTML.Append("<TD align=right>Sub Request Type</TD>")
        m_sbHTML.Append("<TD>")
        m_sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboSubRequestType", "select '' where 1=2", 200, , , True, True, , True))
        m_sbHTML.Append("</TD>")
        m_sbHTML.Append("</TR>")

        m_sbHTML.Append("</Table>")
        m_sbHTML.Append("</div>")


    End Sub

    Private Sub ApplySLA()
        Dim strQuery As String
        Dim strScript As String = ""
        strQuery = "usp_INS_ApplyALLSLA " + m_CustomerID + "," + m_DepartmentID + "," + m_RequestTypeID + "," + m_SubRequestTypeID + ",'" + Session("strUserName").ToString() + "'"
        CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        strScript = vbCrLf + "<Script language=javascript>"
        'strScript += vbCrLf + "window.opener.document.forms[0].action='../General/CommonList.aspx?MasterTagID=919&FromWhere=SM';"
        'strScript += vbCrLf + "window.opener.document.forms[0].submit();"
        strScript += vbCrLf + "window.close();"
        strScript += vbCrLf + "</Script>"
        CommonFunction.General.WriteHTML(strScript)

    End Sub
    Private Function GetReqTypeWiseSubTypes() As String
        Dim dr As IDataReader
        Dim strQuery As String
        Dim strRequestTypeID As String
        Dim strDepartmentID As String
        Dim strJscript As String = "RequestType"
        If Request.QueryString("RequestTypeID") Is Nothing OrElse Request.QueryString("RequestTypeID") = "" Then
            strRequestTypeID = "NULL"
        Else
            strRequestTypeID = Request.QueryString("RequestTypeID")
        End If

        If Request.QueryString("DepartmentID") Is Nothing OrElse Request.QueryString("DepartmentID") = "" Then
            strDepartmentID = "NULL"
        Else
            strDepartmentID = Request.QueryString("DepartmentID")
        End If
        strQuery = "usp_sel_SubRequestTypes_RequestTypeWise " + strDepartmentID + ", " + strRequestTypeID + ""
        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            strJscript = strJscript + "$___#" + CType(dr("SubRequestTypeID"), String) + "$___#" + CType(dr("SubRequestType"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript

    End Function
    Private Function GetDeptwiseRequestTypes() As String
        Dim dr As IDataReader
        Dim strQuery As String
        Dim strDeptID As String
        Dim strJscript As String = "Dept"
        If Request.QueryString("DepartmentID") Is Nothing OrElse Request.QueryString("DepartmentID") = "" Then
            strDeptID = "NULL"
        Else
            strDeptID = Request.QueryString("DepartmentID")
        End If
        strQuery = "usp_sel_RequestTypes_DepartmentWise " + strDeptID
        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            ' strJscript = strJscript + "$___#" + CType(dr("RequestTypeID"), String) + "$___#" + CType(dr("RequestType"), String)
            strJscript = strJscript + "$___#" + CType(dr("RequestTypeID"), String) + "$___#" + CType(dr("RequestType"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript

    End Function
End Class