Public Partial Class CRM_ProjectMapping
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
    Protected CustHTML As String
    Protected ProjHTML As String
    Protected DelHTML As String
    Protected EmpHTML_EmpCustPage As String
    Protected CustHTML_EmpCustPage As String
    Protected ProjHTML_EmpCustPage As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting

    End Sub

    Protected Sub PageInit()

        If Request.QueryString("FromXML") = "1" Then
            Response.Clear()
            Select Case Request.QueryString("From")
                Case "BG"
                    Response.Write(GetBGwiseOU())
                Case "ProjectChange"
                    Response.Write(GetProjWiseDeliverable())
                Case "CustomerChange"
                    Response.Write(GetCustomerWiseProject())
                Case "EmployeeChange"
                    Response.Write(GetCustomerWiseProject())
                Case "DeliverableChange"
                    Response.Write(GetDeliverableDates())
                Case "DuplicateCheck"
                    Response.Write(GetDuplicateRecords())

            End Select
            Response.End()
        Else
            'EmployeeID
            If Request.Form("txtResource") <> "" Then
                m_strEmployee = CType(Request.Form("txtResource"), String)
            Else
                m_strEmployee = ""
            End If

            'Role ID
            If Request.Form("cboRole") <> "" Then
                m_strRoleID = CType(Request.Form("cboRole"), String)
            Else
                m_strRoleID = "NULL"
            End If

            'BG ID
            If Request.Form("cboBG") <> "" Then
                m_strBGID = CType(Request.Form("cboBG"), String)
            Else
                m_strBGID = "NULL"
            End If
            'OU ID
            If Request.Form("cboOU") <> "" Then
                m_strOUID = CType(Request.Form("cboOU"), String)
            Else
                m_strOUID = "NULL"
            End If

            ' page number
            If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
                m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
            End If

            If Request.QueryString("Action") = "SAVECust" Then
                Call SaveCustData()
            ElseIf Request.QueryString("Action") = "SAVEEMPCUSTPRJ" Then
                Call SaveEmpCustProjectData()
            Else
                Call SaveData()
            End If

            If Request.QueryString("Action") = "DELETE" Then
                Call DeleteRecords()
            End If


            Call DrawPage()

        End If



    End Sub

    Private Sub DeleteRecords()
        Dim strDeleteIDS As String
        Dim strQuery As String

        If Not Request.Form("chkDelete") Is Nothing And Request.Form("chkDelete") <> "" Then
            strDeleteIDS = Request.Form("chkDelete").ToString()
            strQuery = "USP_DEL_tbl_CRM_Customer_ProjectDeliverables '" + strDeleteIDS + "'"

            CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        End If

      


    End Sub
    Private Sub DrawOptions()
        Dim IsemployeeSelected As Boolean
        Dim IsCustomerSelected As Boolean
        Dim IsEmployeeCustomerSelected As Boolean
        Dim strQuery As String
        Dim strLevel As String

        'If Not Request.QueryString("IsEmployeeBase") Is Nothing And Request.QueryString("IsEmployeeBase") <> "" Then
        '    IsEmployeeBase = Request.QueryString("IsEmployeeBase").ToString()
        'ElseIf Not Request.Form("optMapping") Is Nothing OrElse Request.Form("optMapping") <> "" Then
        '    IsEmployeeBase = Request.Form("optMapping").ToString()
        'End If

        If Not Request.QueryString("SelectedOption") Is Nothing And Request.QueryString("SelectedOption") <> "" Then
            SelectedOption = Request.QueryString("SelectedOption").ToString()
        ElseIf Not Request.Form("optMapping") Is Nothing And Request.Form("optMapping") <> "" Then
            SelectedOption = Request.Form("optMapping")
        End If

        If SelectedOption = 1 Then
            IsemployeeSelected = True
            IsCustomerSelected = False
            IsEmployeeCustomerSelected = False
        ElseIf SelectedOption = 2 Then
            IsemployeeSelected = False
            IsCustomerSelected = True
            IsEmployeeCustomerSelected = False
        ElseIf SelectedOption = 3 Then
            IsemployeeSelected = False
            IsCustomerSelected = False
            IsEmployeeCustomerSelected = True
        End If

        If Session("LoginType").ToString() = "E" Then

            strQuery = "usp_Sel_EmployeeRoleLevel " + Session("intUserID").ToString() + ",'E'"

            strLevel = CommonFunction.Data.GetDataScalar(strQuery, MyBase.UseSQL).ToString()


            sbHTML.Append("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0>")
            sbHTML.Append("<TR class='clsTREven'>")

            sbHTML.Append("<td align=left> ")
            sbHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("optMapping", "optMapping", , IsemployeeSelected, "1", , "onclick=javascript:OptEmpCust_OnChange(1)", True))
            sbHTML.Append(" Employee Project Mapping &nbsp;&nbsp;&nbsp;&nbsp;")
            'If strLevel = "1" OrElse strLevel = "2" Then
            '    sbHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("optMapping", "optMapping", , IsCustomerSelected, "2", , "onclick=javascript:OptEmpCust_OnChange(2)", True))
            '    sbHTML.Append("Customer Deliverable Mapping")
            'End If
        End If
        'sbHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("optMapping", "optMapping", , IsEmployeeCustomerSelected, "3", , "onclick=javascript:OptEmpCust_OnChange(3)", True))
        'sbHTML.Append("Employee Customer Project Mapping </td >")

        sbHTML.Append("</TR>")
        sbHTML.Append("</Table></BR>")

    End Sub
    Protected Sub DrawEmployeeCustomerPage()
        Dim strClass As String
        Dim m_intPageNumberForSP As String
        Dim ReadCount As Integer
        Dim PK As String
        Dim strCustomerID As String
        Dim strProjectID As String
        Dim strEmployeeID As String

        Dim strQuery As String
        Dim dr As IDataReader

        strClass = "clsTREven"


        Call DrawMenu()
        Call DrawPageName()
        Call WritePaging()


        sbHTML.Append("<BR>")

        sbHTML.Append("<DIV Id='divPage' Style='overflow:auto;width:99.99%' >")
        sbHTML.Append("<Table class=clsGridTable width='99.9%' id='EmpCustomerProjectMapping' cellpadding=0 cellspacing=1>")

        sbHTML.Append("<THead class='clsTRColumnHeader' >")
        sbHTML.Append("<TH align=center style='BORDER-RIGHT:blue 0px groove' ></TH>")
        sbHTML.Append("<TH align=center >Resource</TH>")
        sbHTML.Append("<TH align=center >Customer</TH>")
        sbHTML.Append("<TH align=center >Project</TH>")
        sbHTML.Append("</THead>")

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'EmpHTML_EmpCustPage = CommonFunction.HTMLControls.DrawComboBox("cboEmployee" + ControlIDIterator.ToString(), "SELECT EmployeeID ,EmployeeName FROM tbl_PM_Employee WHERE Status = 0 OR LeavingDate IS NULL ORDER BY EmployeeName", 220, , "onchange=cboEmployee_onChange(" + ControlIDIterator.ToString() + ")", True, True, , False)
        EmpHTML_EmpCustPage = CommonFunction.HTMLControls.DrawComboBox("cboEmployee" + ControlIDIterator.ToString(), "usp_sel_tbl_PM_Employee_EmployeeID_EmployeeName", 220, , "onchange=cboEmployee_onChange(" + ControlIDIterator.ToString() + ")", True, True, , False)
        ''''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        CustHTML_EmpCustPage = CommonFunction.HTMLControls.DrawComboBox("cboCustomer" + ControlIDIterator.ToString(), "usp_Sel_tbl_PM_Customer_ForProject", 200, , , True, True)
        ProjHTML_EmpCustPage = CommonFunction.HTMLControls.DrawComboBox("cboProject" + ControlIDIterator.ToString(), "select '' where 1=2", 200, , , True, True, , False)

        sbHTML.Append("<TR class='" + strClass + "'>")

        sbHTML.Append("<TD align=center style='BORDER-RIGHT:blue 0px groove'>")
        sbHTML.Append("</TD>")

        sbHTML.Append("<TD align=center>")
        sbHTML.Append(EmpHTML_EmpCustPage)
        sbHTML.Append("</TD>")
        sbHTML.Append("<TD align=center>")
        sbHTML.Append(CustHTML_EmpCustPage)
        sbHTML.Append("</TD>")
        sbHTML.Append("<TD align=center>")
        sbHTML.Append(ProjHTML_EmpCustPage)
        sbHTML.Append("</TD>")

        sbHTML.Append("</TR>")

        sbHTML.Append("<TR class='" + strClass + "' >")
        sbHTML.Append("<TD style='BORDER-RIGHT:blue 0px groove'><Img Border=0 id=tdShowHide Src='../../Images/Home/AddSection.gif' title='Add blank Row' onclick='createNewRow(3)'>")
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
        sbHTML.Append("</TR>")


        If m_intPageNumber > 0 Then
            m_intPageNumberForSP = m_intPageNumber
        Else
            m_intPageNumberForSP = "NULL"
        End If

        strQuery = "USP_SEL_tbl_CRM_Employee_Customer_ProjectMapping " + m_intPageNumberForSP

        dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        If m_intPageNumber > 0 Then
            For ReadCount = 1 To (20 * (m_intPageNumber - 1))
                dr.Read()
            Next
        End If


        While dr.Read()
            PK = dr("ProjectMappingID").ToString()
            strCustomerID = dr("CustomerID").ToString()
            strProjectID = dr("ProjectID").ToString()
            strEmployeeID = dr("EmployeeID").ToString()

            strQuery = "Exec usp_Sel_AccessibleProjects_ForEmployee " & strEmployeeID & ",0,0,NULL,0,'E',0," & CType(Session("intLoginID"), String) & ",0,0"


            ControlIDIterator = ControlIDIterator + 1

            sbHTML.Append("<TR class='" + strClass + "'>")

            sbHTML.Append("<TD style='BORDER-RIGHT:blue 0px groove'>")
            sbHTML.Append("<input type=hidden id=PK" + ControlIDIterator.ToString() + " name=PK" + ControlIDIterator.ToString() + " value=" + PK + ">")
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=center>")

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboEmployee" + ControlIDIterator.ToString(), "SELECT EmployeeID ,EmployeeName FROM tbl_PM_Employee WHERE Status = 0 OR LeavingDate IS NULL  ", 220, strEmployeeID, " disabled ", True, True, , False))
            sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboEmployee" + ControlIDIterator.ToString(), "usp_sel_tbl_PM_Employee_EmployeeID_EmployeeName", 220, strEmployeeID, " disabled ", True, True, , False))
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=center>")
            sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboCustomer" + ControlIDIterator.ToString(), "usp_Sel_tbl_PM_Customer_ForProject", 200, strCustomerID, "   PK=" + PK, True, True))
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=center>")
            sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboProject" + ControlIDIterator.ToString(), strQuery, 200, strProjectID, , True, True, , False))
            sbHTML.Append("</TD>")

            sbHTML.Append("</TR>")

        End While

        sbHTML.Append("</Table>")
        sbHTML.Append("</Div>")

        Response.Write(sbHTML.ToString)

        sbHTML = Nothing
        CommonFunction.Data.DisposeDataReader(dr)
    End Sub
    Protected Sub DrawCustomerPage()

        Dim strCustomerID As String
        Dim strProjectID As String
        Dim strDeliverableID As String
        Dim strQuery As String
        Dim dr As IDataReader
        Dim StartDate As String
        Dim EndDate As String
        Dim strClass As String
        Dim m_intPageNumberForSP As String
        Dim ReadCount As Integer
        Dim PK As String

        strClass = "clsTREven"


        Call DrawMenu()
        Call DrawPageName()
        Call WritePaging()


        sbHTML.Append("<BR>")

        sbHTML.Append("<DIV Id='divPage' Style='overflow:auto;width:99.99%' >")
        sbHTML.Append("<Table class=clsGridTable width='99.9%' id='CustomerDelMapping' cellpadding=0 cellspacing=1>")

        sbHTML.Append("<THead class='clsTRColumnHeader' >")
        sbHTML.Append("<TH align=center style='BORDER-RIGHT:blue 0px groove' ></TH>")

        sbHTML.Append("<TH align=center >Customer</TH>")
        sbHTML.Append("<TH align=center >Project</TH>")
        sbHTML.Append("<TH align=center >Deliverable</TH>")
        sbHTML.Append("<TH align=center>Start Date - End Date</TH>")

        sbHTML.Append("</THead>")


        CustHTML = CommonFunction.HTMLControls.DrawComboBox("cboCustomer" + ControlIDIterator.ToString(), "usp_Sel_tbl_PM_Customer_ForProject", 200, , "onchange=cboCustomer_onChange(" + ControlIDIterator.ToString() + ")", True, True)
        ProjHTML = CommonFunction.HTMLControls.DrawComboBox("cboProject" + ControlIDIterator.ToString(), "select '' where 1=2", 200, , " onchange=cboProject_onChange(" + ControlIDIterator.ToString() + ") ", True, True, , False)
        DelHTML = CommonFunction.HTMLControls.DrawComboBox("cboDeliverable" + ControlIDIterator.ToString(), "select '' where 1=2", 220, , "onchange=cboDeliverable_onChange(" + ControlIDIterator.ToString() + ")", True, True, , False)

        sbHTML.Append("<TR class='" + strClass + "'>")

        sbHTML.Append("<TD align=center style='BORDER-RIGHT:blue 0px groove'>")
        sbHTML.Append("</TD>")

        sbHTML.Append("<TD align=center>")
        sbHTML.Append(CustHTML)
        sbHTML.Append("</TD>")
        sbHTML.Append("<TD align=center>")
        sbHTML.Append(ProjHTML)
        sbHTML.Append("</TD>")
        sbHTML.Append("<TD align=center>")
        sbHTML.Append(DelHTML)
        sbHTML.Append("</TD>")

        sbHTML.Append("<TD align=center id=Deldate" + ControlIDIterator.ToString() + ">")
        sbHTML.Append("Dates")
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

        sbHTML.Append("</TR>")


        If m_intPageNumber > 0 Then
            m_intPageNumberForSP = m_intPageNumber
        Else
            m_intPageNumberForSP = "NULL"
        End If

        strQuery = "USP_SEL_tbl_CRM_Customer_ProjectDeliverables " + m_intPageNumberForSP

        dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        If m_intPageNumber > 0 Then
            For ReadCount = 1 To (20 * (m_intPageNumber - 1))
                dr.Read()
            Next
        End If


        While dr.Read()
            PK = dr("CustProjectDelID").ToString()
            strCustomerID = dr("CustomerID").ToString()
            strProjectID = dr("ProjectID").ToString()
            strDeliverableID = dr("DeliverableID").ToString()

            strQuery = "Exec usp_Sel_AccessibleProjects_HelpDeskMapping " & Session("intUserID").ToString() & ",0,0,NULL,0,'E',0," & CType(Session("intLoginID"), String) & ",0,0,NULL," + strProjectID


            ControlIDIterator = ControlIDIterator + 1

            If IsDBNull(dr("StartDate")) Then
                StartDate = "-"
            Else
                StartDate = CommonFunction.Dates.CGetDate(CType(dr("StartDate"), Date))
            End If

            If IsDBNull(dr("EndDate")) Then
                EndDate = "-"
            Else
                EndDate = CommonFunction.Dates.CGetDate(CType(dr("EndDate"), Date))
            End If

            sbHTML.Append("<TR class='" + strClass + "'>")

            sbHTML.Append("<TD style='BORDER-RIGHT:blue 0px groove'>")
            sbHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , PK, , , True))

            sbHTML.Append("<input type=hidden id=PK" + ControlIDIterator.ToString() + " name=PK" + ControlIDIterator.ToString() + " value=" + PK + ">")
            sbHTML.Append("</TD>")

            sbHTML.Append("<TD align=center>")
            sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboCustomer" + ControlIDIterator.ToString(), "usp_Sel_tbl_PM_Customer_ForProject", 200, strCustomerID, " disabled  PK=" + PK, True, True))
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=center>")
            sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboProject" + ControlIDIterator.ToString(), strQuery, 200, strProjectID, " onchange=cboProject_onChange(" + ControlIDIterator.ToString() + ")  ", True, True, , False))
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=center>")

            ''sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboDeliverable" + ControlIDIterator.ToString(), "select ScheduleID,Title from tbl_PM_OtherSchedules WHERE ProjectID = " + strProjectID + " AND (ISNULL(Void,0) = 0 AND ISNULL(IsOnHold,0) = 0 OR (ScheduleID = " + strDeliverableID + ")) ORDER BY Title", 220, strDeliverableID, " onchange=cboDeliverable_onChange(" + ControlIDIterator.ToString() + ")", True, True, , False))
            sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboDeliverable" + ControlIDIterator.ToString(), "usp_tbl_PM_OtherSchedules_void_isonhold_Deliverable " + strProjectID + "," + strDeliverableID, 220, strDeliverableID, " onchange=cboDeliverable_onChange(" + ControlIDIterator.ToString() + ")", True, True, , False))

            sbHTML.Append("</TD>")

            sbHTML.Append("<TD align=center id=Deldate" + ControlIDIterator.ToString() + ">")
            sbHTML.Append(StartDate + " To " + EndDate)
            sbHTML.Append("</TD>")

            sbHTML.Append("</TR>")

        End While

        sbHTML.Append("</Table>")
        sbHTML.Append("</Div>")

        Response.Write(sbHTML.ToString)

        sbHTML = Nothing
        CommonFunction.Data.DisposeDataReader(dr)

    End Sub
    Protected Sub DrawPage()

        Call DrawOptions()

        If SelectedOption = 2 Then
            Call DrawCustomerPage()
        ElseIf SelectedOption = 1 Then
            Call DrawMenu()
            Call DrawFilter()
            Call DrawPageName()
            Call WritePaging()
            Call MainPage()
            Response.Write(sbHTML.ToString)
            Call DrawMenu()
            sbHTML = Nothing
        ElseIf SelectedOption = 3 Then
            Call DrawEmployeeCustomerPage()
        End If

    End Sub

    Private Sub DrawFilter()
        'Filter Table 
        CommonFunctions.General.WriteHTML("<TABLE id='tblFilter' style='display:none;width:99.99%;position:absolute;border:1' class='clsGridTable' cellspacing='1' cellpadding='1'>")


        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right'align=right>Resource")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=left title='Starts with' >")
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtResource", "txtResource", , 200, 50, m_strEmployee, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:05/10/15
        CommonFunctions.General.WriteHTML("</td>")
        'Fo Role Filter
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Role")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left>")

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''CommonFunctions.HTMLControls.DrawComboBox("cboRole", "Select RoleID, RoleDescription From tbl_PM_Role Where IsNull(IsUserGroup, 0) = 0 AND RoleID <> 23 Order by RoleDescription", 200, m_strRoleID.ToString, True, True)
        CommonFunctions.HTMLControls.DrawComboBox("cboRole", "usp_sel_tbl_PM_Role_RoleID_RoleDescription", 200, m_strRoleID.ToString, True, True)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        CommonFunctions.General.WriteHTML("</td></TR>")

        'For BG Filter 
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Business Group")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=left >")
        CommonFunctions.HTMLControls.DrawComboBox("cboBG", "usp_sel_BusinessGroups_LevelWise_RCV " + Session("intUserID").ToString, 200, m_strBGID, "onChange= BG_onChange()", True)
        CommonFunctions.General.WriteHTML("</td>")
        'For OU Filter 
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Organization Unit")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;' align=Left >")
        CommonFunctions.HTMLControls.DrawComboBox("cboOU", "usp_sel_OrganizationUnits_LevelWise_RCV " + m_strBGID + "," + Session("intUserID").ToString, 200, m_strOUID, , True)
        CommonFunctions.General.WriteHTML("</td></TR>")

        'Apply Button
        CommonFunctions.General.WriteHTML("<tr class='clsTRPageCaption'><td colspan='4'  style='text-align:center;' width=4% height=15%>")
        'CommonFunctions.General.WriteHTML("<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;' href='javascript:applyFilter()' ><Font Size=1>Apply</Font></a>&nbsp;&nbsp;&nbsp;&nbsp;")
        'CommonFunctions.General.WriteHTML("<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;' href='javascript:ClearFilter()' ><Font Size=1>Clear</Font></a></TD>")
        CommonFunctions.General.WriteHTML("<input type=button id=btnApply onclick='applyFilter()' value=""Apply"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        CommonFunctions.General.WriteHTML("<input type=button id=btnClose onclick='ClearFilter()' value=""Clear""></TD>")


        CommonFunctions.General.WriteHTML("</TR></TABLE>")

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

        If SelectedOption = 1 Then
            arrMenuCaptionsList.Add("<img id='imgFilter' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Filter.gif'")
            arrMenuToolTipsList.Add("Filter")
            arrClientSideFunctionList.Add("showFilters(1)")
        End If


        arrMenuCaptionsList.Add("Save")
        arrMenuToolTipsList.Add("Save")
        arrClientSideFunctionList.Add("Save_OnClick()")

        'arrMenuCaptionsList.Add("History")
        'arrMenuToolTipsList.Add("History")
        'arrClientSideFunctionList.Add("History_onClick()")
        If SelectedOption = 2 Then
            arrMenuCaptionsList.Add("Delete")
            arrMenuToolTipsList.Add("Delete")
            arrClientSideFunctionList.Add("DeleteReocrds()")
        End If


        arrMenuCaptionsList.Add("?")
        arrMenuToolTipsList.Add("Help")
        arrClientSideFunctionList.Add("Help_OnClick('RequestProject')")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)


        'Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)

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

    Private Sub DrawPageName()

        sbHTML.Append("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0>")
        sbHTML.Append("<TR class='clsTREven'>")
        sbHTML.Append("<TD align=left><B>HelpDesk Activity Project<B>")
        sbHTML.Append("</TD>")
        sbHTML.Append("</TR>")
        sbHTML.Append("</Table>")

    End Sub

    Private Sub MainPage()

        Dim strQuery As String
        Dim ProjectID As String
        Dim dr As IDataReader
        Dim strQueryRes As String
        Dim EmployeeName As String
        Dim EmployeeID As String
        Dim strClass As String = "clsTROdd"
        Dim m_intPageNumberForSP As String
        Dim ReadCount As Integer
        Dim Reportingname As String
        Dim oldReportingname As String = ""

        ' Modified By NitinVS on 7 May 2009 To show projects where logged in resource is acive resource.

        ' strQuery = "Exec usp_Sel_AccessibleProjects_ForEmployee " & Session("intUserID").ToString() & ",0,0,NULL,0,'E',0," & CType(Session("intLoginID"), String) & ",0,0"
        ' End Modification By NitinVS on 7 May 2009 
        sbHTML.Append("<BR>")

        sbHTML.Append("<DIV Id='divPage' Style='overflow:auto;width:99.99%' >")
        sbHTML.Append("<Table class=clsGridTable width='99.9%' cellpadding=0 cellspacing=1>")

        sbHTML.Append("<THead class='clsTRColumnHeader' >")
        sbHTML.Append("<TH align=left width=30%>Resource Name</TH>")
        sbHTML.Append("<TH align=left width=50%>Project</TH>")
        sbHTML.Append("<TH width=20%>&nbsp;</TH>")
        sbHTML.Append("</THead>")

        If m_intPageNumber > 0 Then
            m_intPageNumberForSP = m_intPageNumber
        Else
            m_intPageNumberForSP = "'" + "-1" + "'"
        End If
        strQueryRes = "usp_Sel_Resources_HelpdeskActivity_ProjectMapping " + Session("intUserID").ToString() + "," + m_intPageNumberForSP + ",'" + m_strEmployee + "'," + m_strBGID + "," + m_strOUID + "," + m_strRoleID

        dr = CommonFunction.Data.GetDataReader(strQueryRes, MyBase.UseSQL)

        If m_intPageNumber > 0 Then
            For ReadCount = 1 To (20 * (m_intPageNumber - 1))
                dr.Read()
            Next
        End If

        While dr.Read()

            EmployeeName = dr("EmployeeName").ToString()
            EmployeeID = dr("EmployeeID").ToString()
            Reportingname = CommonFunction.Data.CheckIsDBNull(dr("Reportingname"), "N/A").ToString()

            EmployeeName = EmployeeName.Replace("'", "''")

            ProjectID = CommonFunction.Data.GetDataScalar("usp_Sel_HelpDesk_Project " + EmployeeID, MyBase.UseSQL)

            If ProjectID Is Nothing Then
                ProjectID = ""
            End If

            strQuery = "Exec usp_Sel_ProjectForHelpDeskProject " + EmployeeID + ",'" + CType(Session("LoginType"), String) + "'"

            If Reportingname <> oldReportingname Then

                Reportingname = Reportingname.Replace("'", "''")

                sbHTML.Append("<TR class='" + strClass + "'>")
                sbHTML.Append("<TD colspan=3> <B>[" + Reportingname + "]</B>")
                sbHTML.Append("</TD>")
                sbHTML.Append("</TR>")

            End If

            sbHTML.Append("<TR class='" + strClass + "'>")
            sbHTML.Append("<TD>" + EmployeeName)
            sbHTML.Append("</TD>")
            sbHTML.Append("<TD align=left>")
            sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboProject", strQuery, 300, ProjectID, " EmployeeID=" + EmployeeID, True, True, , False))
            sbHTML.Append("</TD>")
            ''Commented and Modified By Aniruddh Gujar on 27-Nov-2015 Purpose::SEM Issue fixing
            ''sbHTML.Append("<TD title=" + EmployeeName + " align=center><U><A onclick='History_onClick(" + EmployeeID + ")'>History</A></U>")
            sbHTML.Append("<TD title=" + EmployeeName + " align=center><U><A style='cursor:pointer;' onclick='History_onClick(" + EmployeeID + ")'>History</A></U>")
            ''End of Commented and Modified By Aniruddh Gujar on 27-Nov-2015 Purpose::SEM Issue fixing
            sbHTML.Append("</TD>")
            sbHTML.Append("</TR>")

            If strClass = "clsTREven" Then
                strClass = "clsTROdd"
            Else
                strClass = "clsTREven"
            End If

            oldReportingname = Reportingname
        End While



        sbHTML.Append("</Table>")
        sbHTML.Append("</DIV >")

        sbHTML.Append("<BR>")
        CommonFunction.Data.DisposeDataReader(dr)
    End Sub

    Private Sub SaveData()

        Dim ProjectID As String = ""
        Dim EmployeeIDs As String = ""
        Dim ProjectIDs As String = ""

        If Not Request.Form("cboProject") Is Nothing Then
            ProjectID = Request.Form("cboProject").ToString()
        End If

        If Not Request.QueryString("EmployeeIDs") Is Nothing Or Request.QueryString("EmployeeIDs") <> "" Then
            EmployeeIDs = Request.QueryString("EmployeeIDs").ToString()
            ProjectIDs = Request.QueryString("ProjectIDs").ToString()
        End If


        'CommonFunction.Data.InsertOrUpdateData("Usp_Ins_tbl_CRM_Employee_ProjectMapping " + Session("intUserID").ToString() + "," + ProjectID, MyBase.UseSQL)

        CommonFunction.Data.InsertOrUpdateData("Usp_Ins_tbl_CRM_Employee_ProjectMapping '" + EmployeeIDs + "','" + ProjectIDs + "'", MyBase.UseSQL)


    End Sub

    Private Sub WritePaging()
        '=====================================================================
        ' Procedure Name        : WritePaging
        ' Description           : To write the paging for the request grid
        ' Purpose               : 
        ' Parameters Passed     : SQL for paging
        ' Returns               : NA
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 17,2004
        ' Revisions             : NitinVS on 26 July 2005 for PSPL 
        '                         Inplace of Paging Search paging is implemented
        '=====================================================================
        Dim ds As DataSet
        Dim intRecordCount As Integer
        'Dim strPaging As String = WebPages.Template.Paging.DrawPaging(m_intPageNumber.ToString, PagingSQL, MyBase.GetResourceString("PAGING_CAPTION"), "Page_OnClick", "", True, , , True, 20)
        Dim strPaging As String = ""
        Dim strSectionTag As String = "divGrid"
        Dim strFunctionName As String = "ShowHide_divGrid"
        Dim PagingSQL As String

        If SelectedOption = 1 Then
            PagingSQL = "usp_Count_Resources_HelpdeskActivity_ProjectMapping " + Session("intUserID").ToString() + ",'" + m_strEmployee + "'," + m_strBGID + "," + m_strOUID + "," + m_strRoleID
        Else
            PagingSQL = "USP_CNT_tbl_CRM_Customer_ProjectDeliverables"
        End If



        m_intTotalNoOfRows = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(PagingSQL, MyBase.UseSQL), ""), ""), Integer)

        If Math.Ceiling(m_intTotalNoOfRows / 20) < m_intPageNumber Then
            m_intPageNumber = 1
        End If


        strPaging = "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"

        If m_intPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
        Else
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:05/10/15
        End If
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString + ">"

        strPaging += " of " + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString
        strPaging += "|<A href='javascript:Page_OnClick(""-1"")' TITLE='Show All Records'><B>All</B> </A>"
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:05/10/15
        If Trim(strPaging & "") <> "" Then
            sbHTML.Append("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")
        End If


    End Sub

    Private Function GetBGwiseOU() As String
        Dim dr As IDataReader
        Dim strQuery As String
        Dim strBGID As String
        Dim strJscript As String = "BG"
        If Request.QueryString("BGID") Is Nothing OrElse Request.QueryString("BGID") = "" Then
            strBGID = "NULL"
        Else
            strBGID = Request.QueryString("BGID")
        End If
        strQuery = "usp_sel_OrganizationUnits_LevelWise_RCV " + strBGID + "," + Session("intUserID").ToString
        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            strJscript = strJscript + "$___#" + CType(dr("LocationID"), String) + "$___#" + CType(dr("Location"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript

    End Function


    Private Function GetProjWiseDeliverable() As String

        Dim dr As IDataReader
        Dim strQuery As String
        Dim strProjectID As String
        Dim strJscript As String = "Project"

        If Request.QueryString("ProjectID") Is Nothing OrElse Request.QueryString("ProjectID") = "" Then
            strProjectID = "NULL"
        Else
            strProjectID = Request.QueryString("ProjectID")
        End If

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strQuery = "select ScheduleID,Title from tbl_PM_OtherSchedules WHERE ProjectID = " + strProjectID + " AND ISNULL(Void,0) = 0 AND ISNULL(IsOnHold,0) = 0 ORDER BY Title "
        strQuery = "usp_sel_tbl_PM_OtherSchedules_void_onhold " + strProjectID
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            strJscript = strJscript + "$___#" + CType(dr("ScheduleID"), String) + "$___#" + CType(dr("Title"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript

    End Function

    Private Function GetDuplicateRecords() As String

        Dim dr As IDataReader
        Dim strQuery As String
        Dim strCustomerIDs As String
        Dim strProjectIDs As String
        Dim strDeliverableIDs As String
        Dim strPKIDs As String

        Dim strJscript As String = "DuplicateRecord"

        strCustomerIDs = Request.QueryString("CustomerIDs").ToString()
        strProjectIDs = Request.QueryString("ProjectIDs").ToString()
        strDeliverableIDs = Request.QueryString("DeliverableIDs").ToString()
        strPKIDs = Request.QueryString("PK").ToString()

        strQuery = "USP_SEL_tbl_CRM_Customer_ProjectDeliverables_Validation '" + strCustomerIDs + "','" + strProjectIDs + "','" + strDeliverableIDs + "','" + strPKIDs + "'"

        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            strJscript = strJscript + "$___#" + CType(dr("DuplicateReords"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript

    End Function

    Private Function GetCustomerWiseProject() As String

        Dim dr As IDataReader
        Dim strQuery As String
        Dim strCustomerID As String
        Dim strJscript As String = "Customer"
        Dim UserID As String

        'If Request.QueryString("CustomerID") Is Nothing OrElse Request.QueryString("CustomerID") = "" Then
        '    strCustomerID = "NULL"
        'Else
        '    strCustomerID = Request.QueryString("CustomerID")
        'End If

        'strQuery = "select ProjectID,ProjectName from tbl_PM_Project where [over] = 0 AND CustomerID = " + strCustomerID + " ORDER BY ProjectName "

        If Request.QueryString("From") = "CustomerChange" Then
            UserID = Session("intUserID").ToString()
        ElseIf Request.QueryString("From") = "EmployeeChange" Then
            UserID = Request.QueryString("EmployeeId").ToString()
        End If

        strQuery = "Exec usp_Sel_AccessibleProjects_ForEmployee " & UserID & ",0,0,NULL,0,'E',0," & CType(Session("intLoginID"), String) & ",0,0"

        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)

        While dr.Read
            strJscript = strJscript + "$___#" + CType(dr("ProjectID"), String) + "$___#" + CType(dr("ProjectName"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript

    End Function

    Private Function GetDeliverableDates() As String

        Dim dr As IDataReader
        Dim strQuery As String
        Dim strDeliverableID As String
        Dim strJscript As String = "Deliverable"
        Dim startDate As String
        Dim endDate As String

        If Request.QueryString("DeliverableID") Is Nothing OrElse Request.QueryString("DeliverableID") = "" Then
            strDeliverableID = "NULL"
        Else
            strDeliverableID = Request.QueryString("DeliverableID")
        End If

        strQuery = "usp_Sel_DeleverableDates " + strDeliverableID
        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)

        While dr.Read

            If IsDBNull(dr("StartDate")) Then
                StartDate = "-"
            Else
                StartDate = CommonFunction.Dates.CGetDate(CType(dr("StartDate"), Date))
            End If

            If IsDBNull(dr("EndDate")) Then
                EndDate = "-"
            Else
                EndDate = CommonFunction.Dates.CGetDate(CType(dr("EndDate"), Date))
            End If

            strJscript = strJscript + "$___#" + startDate + "$___#" + endDate
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript

    End Function



    Private Sub SaveCustData()

        Dim TableRows As Integer
        Dim strQuery As String
        Dim strCustomerIDs As String = ""
        Dim strProjectIDs As String = ""
        Dim strDeliverableIDs As String = ""
        Dim counter As Integer
        Dim PK As String = ""

        TableRows = CType(Request.QueryString("TableRows"), Integer)

        For counter = 1 To TableRows - 2

            If Not Request.Form("PK" + counter.ToString()) Is Nothing And Request.Form("PK" + counter.ToString()) <> "" Then
                PK = PK + Request.Form("PK" + counter.ToString()).ToString() + ","
            Else
                PK = PK + ","
            End If

            strCustomerIDs = strCustomerIDs + Request.Form("cboCustomer" + counter.ToString()) + ","
            strProjectIDs = strProjectIDs + Request.Form("cboProject" + counter.ToString()) + ","
            strDeliverableIDs = strDeliverableIDs + Request.Form("cboDeliverable" + counter.ToString()) + ","
        Next



        strQuery = "USP_INS_tbl_CRM_Customer_ProjectDeliverables " + Session("intUserID").ToString() + ",'" + strCustomerIDs + "','" + strProjectIDs + "','" + strDeliverableIDs + "','" + PK + "'"

        CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

    End Sub
    Private Sub SaveEmpCustProjectData()

        Dim TableRows As Integer
        Dim strQuery As String
        Dim strCustomerIDs As String = ""
        Dim strProjectIDs As String = ""
        Dim strEmployeeIDs As String = ""
        Dim counter As Integer
        Dim PK As String = ""

        TableRows = CType(Request.QueryString("TableRows"), Integer)

        For counter = 1 To TableRows - 2

            If Not Request.Form("PK" + counter.ToString()) Is Nothing And Request.Form("PK" + counter.ToString()) <> "" Then
                PK = PK + Request.Form("PK" + counter.ToString()).ToString() + ","
            Else
                PK = PK + ","
            End If

            strEmployeeIDs = strEmployeeIDs + Request.Form("cboEmployee" + counter.ToString()) + ","
            strCustomerIDs = strCustomerIDs + Request.Form("cboCustomer" + counter.ToString()) + ","
            strProjectIDs = strProjectIDs + Request.Form("cboProject" + counter.ToString()) + ","

        Next

        strQuery = "USP_INS_tbl_CRM_Employee_Customer_ProjectMapping " + Session("intUserID").ToString() + ",'" + strEmployeeIDs + "','" + strCustomerIDs + "','" + strProjectIDs + "','" + PK + "'"

        CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

    End Sub
End Class




