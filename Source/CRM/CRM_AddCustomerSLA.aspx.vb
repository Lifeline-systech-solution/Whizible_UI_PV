Public Partial Class CRM_AddCustomerSLA
    Inherits WebPages.Template.WhizTemplate
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private sbHTML As New System.Text.StringBuilder
    Private m_intTotalNoOfRows As Integer
    Protected m_intPageNumber As Integer = 1
    Private m_strEmployee As String
    Private m_strBGID As String
    Private m_strOUID As String
    Private m_strRoleID As String
    Private m_strDesignationID As String
    Protected ControlIDIterator As Integer = 1
    Protected IsEmployeeBase As String = "0"
    Protected SelectedOption As Integer = 1
    Protected SubRequestTypeHTML As String
    Protected RequestTypeHTML As String
    Protected DeptHTML As String
    Protected SLAHTML As String
    Protected EmpHTML_EmpCustPage As String
    Protected CustHTML_EmpCustPage As String
    Protected ProjHTML_EmpCustPage As String

    Protected Sub PageInit()

        If Request.QueryString("FromXML") = "1" Then
            Response.Clear()
            Select Case Request.QueryString("From")
                Case "Dept"
                    Response.Write(GetDeptwiseRequestTypes())
                Case "RequestType"
                    Response.Write(GetReqTypeWiseSubTypes())
                    'Case "SubRequestType"
                    '    Response.Write(GetCustomerWiseProject())
                    'Case "EmployeeChange"
                    '    Response.Write(GetCustomerWiseProject())
                    'Case "DeliverableChange"
                    '    Response.Write(GetDeliverableDates())
                    'Case "DuplicateCheck"
                    '    Response.Write(GetDuplicateRecords())

            End Select
            Response.End()
        End If
        'Else
        '    'EmployeeID
        '    If Request.Form("txtResource") <> "" Then
        '        m_strEmployee = CType(Request.Form("txtResource"), String)
        '    Else
        '        m_strEmployee = ""
        '    End If

        '    'Role ID
        '    If Request.Form("cboRole") <> "" Then
        '        m_strRoleID = CType(Request.Form("cboRole"), String)
        '    Else
        '        m_strRoleID = "NULL"
        '    End If

        '    'BG ID
        '    If Request.Form("cboBG") <> "" Then
        '        m_strBGID = CType(Request.Form("cboBG"), String)
        '    Else
        '        m_strBGID = "NULL"
        '    End If
        '    'OU ID
        '    If Request.Form("cboOU") <> "" Then
        '        m_strOUID = CType(Request.Form("cboOU"), String)
        '    Else
        '        m_strOUID = "NULL"
        '    End If

        '    ' page number
        '    If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
        '        m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        '    End If

        If Request.QueryString("Action") = "SAVE" Then
            Call SaveData()
            CommonFunction.General.WriteHTML("<SCRIPT Language=JavaScript>")
            CommonFunction.General.WriteHTML("alert('SLA/s has been added successfully');")
            'CommonFunction.General.WriteHTML("window.close();")
            CommonFunction.General.WriteHTML("</SCRIPT>")
        End If

        '    If Request.QueryString("Action") = "DELETE" Then
        '        ' Call DeleteRecords()
        '    End If
        If Request.QueryString("Action") = "DELETE" Then
            Call DeleteRecords()
        End If

        Call DrawPage()

        'End If



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
    Protected Sub DrawPage()

        Dim strCustomerID As String
        Dim strQuery As String
        Dim dr As IDataReader
        Dim strClass As String
        Dim strCustomerHTML As String = ""
        Dim strHiddenHTML As String = ""
        Dim strFilterDeptID As String = ""
        Dim PK As Integer
        Dim DepartmentId, RequestTypeID, SubRequestTypeID, SLAMasterID As Integer
        Dim StrQueryReq As String = ""


        Dim objDynamicLink As WebPages.UI.cDynamicLink

        strClass = "clsTREven"


        Call DrawMenu()
        Call DrawPageName()
        sbHTML.Append("<TR class='" + strClass + "'>")
        sbHTML.Append("<TD align=left>Customer ")
        'sbHTML.Append("<TD align=left>")
        If Request.QueryString("CustomerID") Is Nothing OrElse Request.QueryString("CustomerID") = "" Then
            strCustomerID = "NULL"
        Else
            strCustomerID = Request.QueryString("CustomerID")
        End If
        If strCustomerID = "NULL" Then
            strCustomerHTML = CommonFunction.HTMLControls.DrawComboBox("cboCustomer", "usp_sel_tbl_PM_Customer_forSLA", 200, , "onchange=cboCustomer_onChange()", True, True, , True)
        Else
            strCustomerHTML = CommonFunction.HTMLControls.DrawComboBox("cboCustomer", "usp_sel_tbl_PM_Customer_forSLA", 200, strCustomerID, "onchange=cboCustomer_onChange()", True, True, , True)
            strHiddenHTML = CommonFunction.HTMLControls.DrawComboBox("cboSLACombination", "usp_get_ExistingSLAs_Customer " & strCustomerID & "", 200, strCustomerID, , True, True, , True, , True)
        End If
        sbHTML.Append(strCustomerHTML)
        objDynamicLink = New WebPages.UI.cDynamicLink
        objDynamicLink.LinkName = "Show SLA"
        objDynamicLink.Tooltip = "Show SLA"
        objDynamicLink.FunctionName = "ShowSLA_OnClick()"
        objDynamicLink.ReturnHTML = True
        sbHTML.Append(" |<B>" + objDynamicLink.GetDynamicLink() + "</B>| ")
        objDynamicLink = Nothing
        sbHTML.Append(strHiddenHTML)
        'sbHTML.Append("</TD>")
        'sbHTML.Append("<TD align=left>Department ")
        sbHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <B> Filter : <B>&nbsp;&nbsp;&nbsp  Department ")
        If Request.QueryString("FilterDeptID") Is Nothing OrElse Request.QueryString("FilterDeptID") = "" Then
            strFilterDeptID = "NULL"
        Else
            strFilterDeptID = Request.QueryString("FilterDeptID")
        End If
        If strFilterDeptID = "NULL" Then
            DeptHTML = CommonFunction.HTMLControls.DrawComboBox("cboDepartment", "USP_sel_DepartmentsForCustomerSLA 1", 200, , "onchange=cboDepartmentFilter_onChange()", True, True)
        Else
            DeptHTML = CommonFunction.HTMLControls.DrawComboBox("cboDepartment", "USP_sel_DepartmentsForCustomerSLA 1", 200, strFilterDeptID, "onchange=cboDepartmentFilter_onChange()", True, True)
        End If
        sbHTML.Append(DeptHTML)
        sbHTML.Append("</TD>")

        ''sbHTML.Append("</TD>")

        'sbHTML.Append("<td align=left>")
        'objDynamicLink = New WebPages.UI.cDynamicLink
        'objDynamicLink.LinkName = "Show SLA"
        'objDynamicLink.Tooltip = "Show SLA"
        'objDynamicLink.FunctionName = "ShowSLA_OnClick()"
        'objDynamicLink.ReturnHTML = True
        'sbHTML.Append(" |<B>" + objDynamicLink.GetDynamicLink() + "</B>| ")
        'objDynamicLink = Nothing
        'sbHTML.Append("</td>")
        sbHTML.Append("</TR>")

        sbHTML.Append("</Table>")

        sbHTML.Append("<BR>")
        sbHTML.Append("<DIV Id='divPage' Style='overflow:auto;width:99.99%' >")
        sbHTML.Append("<Table class=clsGridTable width='99.9%' id='CustomerSLA' cellpadding=0 cellspacing=1>")

        sbHTML.Append("<THead class='clsTRColumnHeader' >")
        sbHTML.Append("<TH align=center style='BORDER-RIGHT:blue 0px groove' ></TH>")

        sbHTML.Append("<TH align=center >Department</TH>")
        sbHTML.Append("<TH align=center >Request Type</TH>")
        sbHTML.Append("<TH align=center >Sub Request Type</TH>")
        sbHTML.Append("<TH align=center>SLA</TH>")
        sbHTML.Append("<TH align=center>Select</TH>")

        sbHTML.Append("</THead>")
        If Request.QueryString("DrawSLATable") = 1 Then
            '****************************************************************
            dr = CommonFunctions.Data.GetDataReader("usp_Get_All_SLAsDefined " & strCustomerID & "," & strFilterDeptID & "", True)
            While dr.Read()
                PK = dr("SLADetailID").ToString()
                DepartmentId = dr("DepartmentId").ToString()
                RequestTypeID = dr("RequestTypeID").ToString()
                SubRequestTypeID = dr("SubRequestTypeID").ToString()
                SLAMasterID = dr("SLAMasterID").ToString()
                'StrQueryReq = "usp_sel_RequestTypes_DepartmentWise '" + DepartmentId.ToString + "'"
                DeptHTML = CommonFunction.HTMLControls.DrawComboBox("cboDepartment_" + PK.ToString(), "USP_sel_DepartmentsForCustomerSLA 0", 200, DepartmentId, "disabled ", True, True, , True)
                RequestTypeHTML = CommonFunction.HTMLControls.DrawComboBox("cboRequestType_" + PK.ToString(), "SELECT RequestTypeID,RequestType from tbl_CRM_RequestType ", 200, RequestTypeID, " disabled ", True, True, , True)
                SubRequestTypeHTML = CommonFunction.HTMLControls.DrawComboBox("cboSubRequestType_" + PK.ToString(), "SELECT SubRequestTypeID,SubRequestType from tbl_CRM_SubRequestType", 220, SubRequestTypeID, " disabled ", True, True, , True)
                SLAHTML = CommonFunction.HTMLControls.DrawComboBox("cboSLA_" + PK.ToString(), "usp_Sel_tbl_CNF_SLAMaster ", 220, SLAMasterID, " disabled ", True, True, , True)

                sbHTML.Append("<TR class='" + strClass + "'>")

                sbHTML.Append("<TD align=center style='BORDER-RIGHT:blue 0px groove'>")
                sbHTML.Append("</TD>")

                sbHTML.Append("<TD align=center>")
                sbHTML.Append(DeptHTML)
                sbHTML.Append("</TD>")
                sbHTML.Append("<TD align=center>")
                sbHTML.Append(RequestTypeHTML)
                sbHTML.Append("</TD>")
                sbHTML.Append("<TD align=center>")
                sbHTML.Append(SubRequestTypeHTML)
                sbHTML.Append("</TD>")

                sbHTML.Append("<TD align=center>")
                sbHTML.Append(SLAHTML)
                sbHTML.Append("</TD>")

                ' Added for Delete check box
                sbHTML.Append("<TD align=center>")
                sbHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , PK, , , True))
                sbHTML.Append("</TD>")

                sbHTML.Append("</TR>")

            End While
            '**************************************************************
            DeptHTML = CommonFunction.HTMLControls.DrawComboBox("cboDepartment" + ControlIDIterator.ToString(), "USP_sel_DepartmentsForCustomerSLA 1", 200, , "onchange=cboDepartment_onChange(" + ControlIDIterator.ToString() + ")", True, True, , True)
            RequestTypeHTML = CommonFunction.HTMLControls.DrawComboBox("cboRequestType" + ControlIDIterator.ToString(), "select '' where 1=2", 200, , " onchange=cboRequestType_onChange(" + ControlIDIterator.ToString() + ") ", True, True, , True)
            SubRequestTypeHTML = CommonFunction.HTMLControls.DrawComboBox("cboSubRequestType" + ControlIDIterator.ToString(), "select '' where 1=2", 220, , , True, True, , True)
            SLAHTML = CommonFunction.HTMLControls.DrawComboBox("cboSLA" + ControlIDIterator.ToString(), "usp_Sel_tbl_CNF_SLAMaster ", 220, , , True, True, , True)

            sbHTML.Append("<TR class='" + strClass + "'>")

            sbHTML.Append("<TD align=center style='BORDER-RIGHT:blue 0px groove'>")
            sbHTML.Append("</TD>")

            sbHTML.Append("<TD align=center>")
            sbHTML.Append(DeptHTML)
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=center>")
            sbHTML.Append(RequestTypeHTML)
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=center>")
            sbHTML.Append(SubRequestTypeHTML)
            sbHTML.Append("</TD>")

            sbHTML.Append("<TD align=center>")
            sbHTML.Append(SLAHTML)
            sbHTML.Append("</TD>")

            ' Added for Delete check box
            sbHTML.Append("<TD align=center>")
            sbHTML.Append("</TD>")

            sbHTML.Append("</TR>")

            sbHTML.Append("<TR class='" + strClass + "' >")
            sbHTML.Append("<TD style='BORDER-RIGHT:blue 0px groove'><Img Border=0 id=tdShowHide Src='../../Images/Home/AddSection.gif' title='Add blank Row' onclick='createNewRow(2)'>")
            sbHTML.Append("</TD>")

            sbHTML.Append("<TD>")
            'sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboCustomer", "usp_Sel_tbl_PM_Customer_ForProject", 200, , , True, True))
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=left>")
            'sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboProject", "select ProjectID,ProjectName from tbl_PM_Project where CustomerID IS NOT NULL", 300, , , True, True, , False))
            sbHTML.Append("</TD>")
            'sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboDeliverable", "", 300, , , True, True, , False))
            sbHTML.Append("<TD>")
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD>")
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD>")
            sbHTML.Append("</TD>")


            sbHTML.Append("</TR>")

        End If
        sbHTML.Append("</Table>")
        sbHTML.Append("</Div>")
        Response.Write(sbHTML.ToString)

        sbHTML = Nothing

        Call DrawMenu()
    End Sub
    Private Sub DeleteRecords()
        Dim strDeleteIDS As String
        Dim strQuery As String

        If Not Request.Form("chkDelete") Is Nothing And Request.Form("chkDelete") <> "" Then
            strDeleteIDS = Request.Form("chkDelete").ToString()
            strQuery = "usp_del_tbl_CNF_HelpDeskSLADetails '" + strDeleteIDS + "'"

            CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        End If

    End Sub
    Private Sub DrawMenu()
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Shraddha M
        ' Created               : 15,APR 2009
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String                           'Used to store the Menu List as HTML

        m_objMenu = New WebPages.Template.StaticMenu
        If Request.QueryString("DrawSLATable") = 1 Then
            arrMenuCaptionsList.Add("Apply Default SLAs")
            arrMenuToolTipsList.Add("Apply Default SLAs")
            arrClientSideFunctionList.Add("ApplyAllSLA_OnClick()")

            arrMenuCaptionsList.Add("Save")
            arrMenuToolTipsList.Add("Save")
            arrClientSideFunctionList.Add("Save_OnClick()")

            arrMenuCaptionsList.Add("Delete")
            arrMenuToolTipsList.Add("Delete")
            arrClientSideFunctionList.Add("DeleteRecords()")
        End If

        arrMenuCaptionsList.Add("Close")
        arrMenuToolTipsList.Add("Close")
        arrClientSideFunctionList.Add("Close_OnClick()")

        arrMenuCaptionsList.Add("?")
        arrMenuToolTipsList.Add("Help")
        arrClientSideFunctionList.Add("Help_OnClick('0')")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)


        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)

    End Sub
    Private Sub DrawPageName()

        sbHTML.Append("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0>")
        sbHTML.Append("<TR class='clsTREven'>")
        sbHTML.Append("<TD align=left><B>Add Customer SLA <B>")
        sbHTML.Append("</TD>")
        sbHTML.Append("</TR>")


    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 18, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    Private Sub SaveData()

        Dim TableRows As Integer
        Dim strQuery As String
        Dim strCustomerID As String = ""
        Dim strDepartmentID As String = ""
        Dim strRequestTypeID As String = ""
        Dim strSubRequestTypeID As String = ""
        Dim strSLAID As String = ""
        Dim counter As Integer
        Dim PK As String = ""

        TableRows = CType(Request.QueryString("NoOfRows"), Integer)

        For counter = 1 To TableRows

            If Not Request.Form("cboDepartment" + counter.ToString()) Is Nothing And Request.Form("cboDepartment" + counter.ToString()) <> "" Then
                strDepartmentID = Request.Form("cboDepartment" + counter.ToString()).ToString()
                strRequestTypeID = Request.Form("cboRequestType" + counter.ToString()).ToString()
                strSubRequestTypeID = Request.Form("cboSubRequestType" + counter.ToString()).ToString()
                strSLAID = Request.Form("cboSLA" + counter.ToString()).ToString()
                strCustomerID = Request.Form("cboCustomer").ToString
                strQuery = "USP_INS_tbl_CNF_HelpDeskSLA_AND_SLADetails '" + strCustomerID + "','" + strDepartmentID + "','" + strRequestTypeID + "','" + strSubRequestTypeID + "','" + strSLAID + "','" + Session("strUserName").ToString() + "'"
                CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            End If
        Next

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
    End Sub

End Class