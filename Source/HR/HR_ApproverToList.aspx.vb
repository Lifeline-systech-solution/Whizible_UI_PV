Public Class HR_ApproverToList
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region " Variable Declaration "
    '---Private variables--------------------------
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid

    Private m_objPaging As WebPage.Templates.Paging
    Private m_strGridSQL As String
    Private m_strDefaultApproverSQL As String
    Private m_strAction As String
    Private m_strAlphabet As String
    '---Protected Variables------------------------

    Protected m_strApproverID As String

    Protected m_TagShowHistory As String



    Protected m_strIsResApprover As String = "0"
    Protected m_strIsRepApprover As String = "0"
    Protected m_strIsTSApprover As String = "0"

    Protected strEmployeeID As String
    Protected strTSEmployeeID As String
    Private m_strGridTSSQL As String
    'Added by MrugajaB on 1st Dec 2006 for Whiziblesem SP8
    Protected m_strJoiningDate As String
    'End Addition
    'Added By VarunA on 31-Aug-2009 RequestD-22509
    'Purpose : Not to release for those project where resource MPP task is not completed or it is not being marked as void.
    Protected strProjectName As String
    'End By VarunA on 31-Aug-2009 RequestD-22509    
    '--- added By PurvaJ on 10 Oct 2008 for Whiziblesem8.0 Helpdesk workflow 
    Protected m_strNewHDworkflowApprover As String
    Protected intFlag As Integer = 0
    '--- End addition PurvaJ
#End Region

#Region " Menu and Grid "

    Private Sub DrawMenu(ByVal IsLower As Boolean)
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : 06/10/2005
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList
        Dim arrMenuToolTipsList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strMenu As String, strPagingHTML As String                          'Used to store the Menu List as HTML
        Dim strSQLQuery As String
        Dim drCount As IDataReader

        'strSQLQuery = m_strGridSQL + " ,'" & m_strAlphabet & "',1"
        strSQLQuery = m_strGridSQL + " ,'" & m_strAlphabet


        arrMenuCaptionsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_SAVE"), "Save"))
        arrMenuToolTipsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), "Save"))
        arrClientSideFunctionList.Add("Save_OnClick()")



        arrMenuCaptionsList.Add("Close")
        arrMenuToolTipsList.Add("Close")
        arrClientSideFunctionList.Add("Close_OnClick()")

        arrMenuCaptionsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_HELP"), "?"))
        arrMenuToolTipsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_HELP_TOOLTIP"), "Help"))


        arrClientSideFunctionList.Add("Help_OnClick('COR_RES_RELEASE')")



        m_objMenu = New WebPages.Template.StaticMenu
        If IsLower = False Then
            strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        Else
            strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        End If

        CommonFunctions.General.WriteHTML(strMenu)

    End Sub

    Private Sub DrawPageRepToCaption()
        'WebPages.Template.PageCaption.GetPageCaptions(, CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("PAGE_CAPTION"), "Set Employee Reporting To"), , )
        WebPages.Template.PageCaption.GetPageCaptions(, "&nbsp;", , )
    End Sub
    Private Sub DrawBlankGrid()
        Dim sbHtml As New System.Text.StringBuilder
        Dim STRHtml As New System.Text.StringBuilder
        Dim strSQL As String
        Dim dr As IDataReader
        Dim drProjcombo As IDataReader
        Dim drApprovalcombo As IDataReader
        Dim drIRGcombo As IDataReader
        Dim drIRAcombo As IDataReader
        Dim strProject As String
        Dim strProjectManager As String
        Dim strProjectID As String
        Dim strClass As String
        Dim HaveResponsibility As Boolean
        Dim strCombo As String
        Dim strWriteHTML As String

        Dim blnIsProjRes As Boolean
        Dim blnIsApprovalRes As Boolean
        Dim blnIsIRGenerator As Boolean
        Dim blnIsIRApprover As Boolean
        Dim PER_DA_Date As String
        'Added By VarunA on 31-Aug-2009 RequestD-22509
        'Purpose : Not to release for those project where resource MPP task is not completed or it is not being marked as void.
        Dim strTaskStatus As String
        Dim dr1 As IDataReader
        'End By VarunA on 31-Aug-2009 RequestD-22509

        '-------- Added By PurvaJ on 26 May 2008 Configurable workflow
        Dim blnIsWorkflowapprover As Boolean
        '-------- End Addition PurvaJ

        strClass = "clsTREven"
        m_strApproverID = CommonFunctions.General.CheckIsNothing(Request("ApproverID"), "0")


        ' To get Project List Of the Approval
        strSQL = "usp_Sel_Approvers_List_ToRelease " & m_strApproverID
        dr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If Not dr.Read Then
            Exit Sub
        End If
        sbHtml.Append("<div ID=divNote style='overflow:none; width:100%;height:20px'>")
        sbHtml.Append("<TABLE id='tblForm023' CellSpacing=0 class='clsTable' width='99.9%'><br><TR class='clsTRPageCaption'><TD valign=top align=left>")
        sbHtml.Append("Set New Approver</td></tr>")
        sbHtml.Append("<br><TR class='clsTREven'><TD valign=top align=left>")

        sbHtml.Append("<b> Note: &nbsp;</b><ol>")
        'Integrated by Sonal for IssueId 28160.. Added "and Timesheet/Expense Approver" to thr comment
        sbHtml.Append("<li><b>Transfer Project Responsibilities To</b> dropdown lists all employees who can be set as Responsible person for Timesheet blocking, Responsible person for issue and MSP File Owner, default Timesheet/Expense Approver and Responsible person for deliverable." + vbCrLf + "</li>")
        'End of integration by Sonal
        sbHtml.Append("<li><b>Transfer Approval Responsibilities To</b> dropdown lists all employees who can be set as Timesheet Approvers, Expense Approvers and Project Timesheet Approvers.</li>")
        sbHtml.Append("<li><b>Transfer Invoice Generator Responsibilities To</b> dropdown lists all employees who can be set as Invoice generators.</li>")
        sbHtml.Append("<li><b>Transfer IR/PIR Approvers Responsibilities To</b> dropdown lists all employees who can be set as IR/PIR approvers.</li>")
        '-------- Added By PurvaJ on 26 May 2008 Configurable workflow
        sbHtml.Append("<li><b>Transfer Workflow Approval Responsibilities To</b> dropdown lists all employees who can be set as Workflow approvers.</li>")
        '-------- End Addition PurvaJ
        'Commented by SuchitraP on 28-Apr-2009 for IssueID : 30263
        'Purpose : Separate Note of Default Timesheet/ Expense Approver should be removed and add the same in the 1st note mentioned
        ''-------- Added By PurvaJ on 26 May 2008 Whiziblesem 8.0 
        ''--- Only project resources can be selected if the resource to be released is default approver
        'sbHtml.Append("<li><b>Please Select project resources, if resource to be released is set as default Timesheet/Expense Approver.</li>")
        ''-------- End Addition PurvaJ
        'End of comment by SuchitraP on 28-Apr-2009
        sbHtml.Append("</ol>")
        ' sbHtml.Append("<br>Current Approver is the Approver for the following projects :- ")
        sbHtml.Append("</TD></TR></table>")
        sbHtml.Append("<TABLE id='tblForm023' CellSpacing=0 class='clsTable' width='99.9%'><TR class='clsTREven'>") '<TD valign=top align=left>")
        sbHtml.Append("<TD align=left><b>Set Project Release Date : </b>")
        Dim m_strCurrentDate As String = CType(CommonFunction.Data.GetDataScalar("select getdate()", MyBase.UseSQL), String)
        m_strCurrentDate = CommonFunctions.Dates.GetDate(Date.Parse(CommonFunctions.Data.CheckIsDBNull(m_strCurrentDate, "").ToString))

        sbHtml.Append(CommonFunctions.HTMLControls.DrawDateControl("txtProjectActualEndDate", "txtProjectActualEndDate", , 80, m_strCurrentDate, , "frmHR_ApproverToList", returnHTML:=True, IsMandatory:=True, TabIndex:=8))

        sbHtml.Append("</TD></TR></Table><BR>")
        '--- added By purvaj on 10 Nov 2008 for Whiziblesem8.0 Helpdesk workflow resource release
        'm_strNewHDworkflowApprover = CommonFunctions.General.CheckIsNothing(Request.Form("cboEmployeeforworkflow"), "0")
        m_strNewHDworkflowApprover = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_IsHelpDeskWorkflowApprover " + CType(m_strApproverID, String), True), "0"), "0")
        intFlag = 1
        If m_strNewHDworkflowApprover = "1" Then
            sbHtml.Append("<TABLE ID='HelpDeskworkflow' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>") '<DIV id='DivHD' name='DivHD' style='Overflow:auto;height:50px;width:100%;'><BR>
            sbHtml.Append("<tr>")
            sbHtml.Append("<td align='Left' width=80%>")
            sbHtml.Append("Resource is responsible for Knowledge Management workflow approvals. Select the new approver")
            sbHtml.Append("</td>")

            sbHtml.Append("<td align='Left' width=20%>")
            sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboEmployeeforHDworkflow", "usp_sel_tbl_PM_Employee ", 200, , , True, True))
            sbHtml.Append("</td>")
            sbHtml.Append("</tr></table>") '</DIV>
            sbHtml.Append("<br>")
        End If
        '--- End adddition PurvaJ


        sbHtml.Append("<div ID=divTblGrid style='overflow:auto; width:100%;'>")
        sbHtml.Append("<Table name='Approver' id='Approver' class='clsGridTable' width=100%  cellspacing=1 cellpadding=0><THead class='clsTRColumnHeader'>" + vbCrLf)
        sbHtml.Append("<TH class='clsTRColumnHeader' align='center' style='width:2%;'></TH>")
        sbHtml.Append("<TH class='clsTRColumnHeader' align='Left' style='width:14%;'>Project Name </TH>")
        sbHtml.Append("<TH class='clsTRColumnHeader' align='Left' style='width:14%;'>Project Manager</TH>")

        sbHtml.Append("<TH class='clsTRColumnHeader' align='Left' style='width:14%;'>Transfer Project Responsibilities To</TH>")
        sbHtml.Append("<TH class='clsTRColumnHeader' align='Left' style='width:14%;'>Transfer Approval Responsibilities To</TH>")

        ' End If

        sbHtml.Append("<TH class='clsTRColumnHeader' align='Left' style='width:14%;'>Transfer Invoice Generation Responsibilities To</TH>")
        ' End If

        sbHtml.Append("<TH class='clsTRColumnHeader' align='Left' style='width:14%;'>Transfer IR/PIR Approval Responsibilities To</TH>")
        '  End If

        sbHtml.Append("<TH class='clsTRColumnHeader' align='Left' style='width:14%;'>Transfer Workflow Approval Responsibilities To</TH>")

        strCombo = "Select ' ',' '"
        '        STRHtml = "<td align=left style='width:20%;'>"
        Dim cnt As Integer = 0
        While 1 = 1
            sbHtml.Append("<tr class='" + strClass + "'>")
            strProject = CommonFunctions.General.CheckIsNothing(dr("ProjectName"), "")
            strProjectManager = CommonFunctions.General.CheckIsNothing(dr("PM"), "")
            strProjectID = CommonFunctions.General.CheckIsNothing(dr("ProjectID"), "")
            'strApprover = CommonFunctions.General.CheckIsNothing(dr("ApproverName"), "")
            blnIsProjRes = CType(CommonFunctions.General.CheckIsNothing(dr("IsProjectRes"), ""), Boolean)
            blnIsApprovalRes = CType(CommonFunctions.General.CheckIsNothing(dr("IsApprovalRes"), ""), Boolean)
            blnIsIRGenerator = CType(CommonFunctions.General.CheckIsNothing(dr("IsInvoiceGenRes"), ""), Boolean)
            blnIsIRApprover = CType(CommonFunctions.General.CheckIsNothing(dr("IsIR_PIRAppRes"), ""), Boolean)
            HaveResponsibility = CType(CommonFunctions.General.CheckIsNothing(dr("HaveResponsibility"), ""), Boolean)
            PER_DA_Date = CType(dr("PER_DA_MAX_Date"), DateTime).ToString("dd-MMM-yyyy")
            '-------- Added By PurvaJ on 26 May 2008 Configurable workflow
            blnIsWorkflowapprover = CType(CommonFunctions.General.CheckIsNothing(dr("IsWorkflowApprovalRes"), ""), Boolean)
            '-------- End Addition PurvaJ

            If HaveResponsibility = True Then
                'sbHtml.Append("<td align=center style='width:2%;'> <Input type=checkbox name='chkSelect' id='chkSelect' class='clsCheckBox' onclick='chkSelect_onclick(" + cnt.ToString + ")'></td>")
                sbHtml.Append("<td align=center style='width:2%;'> <Input type=checkbox name=chkSelect" + strProjectID + " id=chkSelect" + strProjectID + " class='clsCheckBox' value = " + strProjectID + " onclick='chkSelect_onclick(" + strProjectID.ToString + ")'></td>")
                sbHtml.Append("<td align=left style='width:14%;' id=PrjName" + strProjectID + ">" + strProject + "</td>")
                sbHtml.Append("<td align=left style='width:14%;'>" + strProjectManager + "</td>")

                If blnIsProjRes = True Then
                    'Commented And Added By Vaijat K ON 2/12/2015 IssueID-1791
                    'sbHtml.Append("<td align=left style='width:14%;' id=TDProjectResp" + strProjectID + " name=TDProjectResp" + strProjectID + ">" + CommonFunctions.HTMLControls.DrawComboBox("cboBlank" & strProjectID, strCombo, 150, , "disabled", True, True, , True) + "</td>")
                    sbHtml.Append("<td align=left style='width:14%;white-space:nowrap' id=TDProjectResp" + strProjectID + " name=TDProjectResp" + strProjectID + ">" + CommonFunctions.HTMLControls.DrawComboBox("cboBlank" & strProjectID, strCombo, 150, , "disabled", True, True, , True) + "</td>")


                Else

                    sbHtml.Append("<td align=center style='width:14%;' id=TDProjectResp" + strProjectID + " name=TDProjectResp" + strProjectID + "> - </td>")


                End If
                ' sbHtml.Append("<td align=left style='width:20%;'>" + CommonFunctions.HTMLControls.DrawComboBox("cboApprovalResp", "usp_Sel_Approvers_List " & strProjectID & "," & m_strApproverID, 150, , , True, True, , True, "../../Images/Star.gif") + "</td>")
                'drApprovalcombo = CommonFunction.Data.GetDataReader("usp_Sel_Approvers_List " & strProjectID & "," & m_strApproverID & ",1", MyBase.UseSQL)
                'If drApprovalcombo.Read Then
                If blnIsApprovalRes = True Then
                    'Commented And Added By Vaijat K ON 2/12/2015 IssueID-1791
                    'Commented and Added By Chakshuta H on 22nd-Dec-2016 Purpose::Qa issue fixing
                    'sbHtml.Append("<td align=left style='width:14%;white-space:nowrap' id=TDApprovalResp" + strProjectID + " name=TDApprovalResp" + strProjectID + ">" + CommonFunctions.HTMLControls.DrawComboBox("cboBlank" & strProjectID, strCombo, 150, , "disabled", True, True, , True) + "</td>")
                    sbHtml.Append("<td align=left style='width:14%;white-space:nowrap' id=TDApprovalResp" + strProjectID + " name=TDApprovalResp" + strProjectID + ">" + CommonFunctions.HTMLControls.DrawComboBox("cboBlank" & strProjectID, strCombo, 150, , "disabled", True, True, , True) + "</td>")
                    'End Of Commented and Added By Chakshuta H on 22nd-Dec-2016 Purpose::Qa issue fixing
                Else

                    sbHtml.Append("<td align=center style='width:14%;' id=TDApprovalResp" + strProjectID + " name=TDApprovalResp" + strProjectID + "> - </td>")
                   
                End If
                'End If

                If blnIsIRGenerator = True Then
                    'Commented And Added By Vaijat K ON 2/12/2015 IssueID-1791
                    sbHtml.Append("<td align=left style='width:14%;white-space:nowrap' id='TDIRGenerator" + strProjectID + "' name='TDIRGenerator" + strProjectID + "'>" + CommonFunctions.HTMLControls.DrawComboBox("cboBlank" & strProjectID, strCombo, 150, , "disabled", True, True, , True) + "</td>")


                Else
                    sbHtml.Append("<td align=center style='width:14%;' id='TDIRGenerator" + strProjectID + "' name='TDIRGenerator" + strProjectID + "'> - </td>")
                End If
                'End If

                If blnIsIRApprover = True Then
                    'Commented And Added By Vaijat K ON 2/12/2015 IssueID-1791
                    sbHtml.Append("<td align=left style='width:14%;white-space:nowrap' id='TDIRApprover" + strProjectID + "' name='TDIRApprover" + strProjectID + "'>" + CommonFunctions.HTMLControls.DrawComboBox("cboBlank" & strProjectID, strCombo, 150, , "disabled", True, True, , True) + "</td>")


                    'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                    sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("cboProjectID", "cboProjectID", , , , strProjectID, , , , , , True, , True, EnableHTMLEncode:=True))
                Else
                    sbHtml.Append("<td align=center style='width:14%;' id='TDIRApprover" + strProjectID + "' name='TDIRApprover" + strProjectID + "'> - </td>")
                    sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("cboProjectID", "cboProjectID", , , , strProjectID, , , , , , True, , True, EnableHTMLEncode:=True))
                    'ended by Shamkant s  for HTML encoding Date:06/10/15
                End If

                '-------- Added By PurvaJ on 26 May 2008 Configurable workflow
                If blnIsWorkflowapprover = True Then
                    'Commented And Added By Vaijat K ON 2/12/2015 IssueID-1791
                    'sbHtml.Append("<td align=left style='width:14%;' id='TDWorkflowapprover" + strProjectID + "' name='TDWorkflowapprover" + strProjectID + "'>" + CommonFunctions.HTMLControls.DrawComboBox("cboBlank" & strProjectID, strCombo, 120, , "disabled", True, True, , True) + "</td>")
                    sbHtml.Append("<td align=left style='width:14%;white-space:nowrap' id='TDWorkflowapprover" + strProjectID + "' name='TDWorkflowapprover" + strProjectID + "'>" + CommonFunctions.HTMLControls.DrawComboBox("cboBlank" & strProjectID, strCombo, 120, , "disabled", True, True, , True) + "</td>")

                    'Commented by Shraddha M on 2,Jul 2009
                    'cboProjectID is already present and no need to plot project combo again
                    'sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("cboProjectID", "cboProjectID", , , , strProjectID, , , , , , True, , True))
                    'End of comment by Shraddha M
                Else
                    sbHtml.Append("<td align=center style='width:14%;' id='TDWorkflowapprover" + strProjectID + "' name='TDWorkflowapprover" + strProjectID + "'> - </td>")
                    'Commented by Shraddha M on 2,Jul 2009
                    'cboProjectID is already present and no need to plot project combo again
                    'sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("cboProjectID", "cboProjectID", , , , strProjectID, , , , , , True, , True))
                    'End of comment by Shraddha M
                End If
                '-------- End Addition PurvaJ


            Else
                sbHtml.Append("<td align=center style='width:2%;'> <Input type=checkbox name='chkSelect" + strProjectID + "' id='chkSelect" + strProjectID + "' checked class='clsCheckBox' disabled>")

                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                sbHtml.Append(CommonFunctions.HTMLControls.DrawTextBox("cboProjectID", "cboProjectID", , , , strProjectID, , , , , , True, EnableHTMLEncode:=True) + "</td>")
                'ended by Shamkant s  for HTML encoding Date:06/10/15


                sbHtml.Append("<input type=hidden id=PER_DA_Date" + strProjectID + " name=PER_DA_Date" + strProjectID + " value='" + PER_DA_Date + "' >")
                sbHtml.Append("<td align=left style='width:14%;' id=PrjName" + strProjectID + " >" + strProject + "</td>")
                sbHtml.Append("<td align=left style='width:14%;'>" + strProjectManager + "</td>")
                sbHtml.Append("<td align=center style='width:14%;'> - </td>")
                sbHtml.Append("<td align=center style='width:14%;'> - </td>")
                sbHtml.Append("<td align=center style='width:14%;'> - </td>")
                sbHtml.Append("<td align=center style='width:14%;'> - </td>")
                '-------- Added By PurvaJ on 26 May 2008 Configurable workflow
                sbHtml.Append("<td align=center style='width:14%;'> - </td>")
                '-------- End Addition PurvaJ
            End If

            sbHtml.Append("</tr>")
            'Added By VarunA on 31-Aug-2009 RequestD-22509
            'Purpose : Not to release for those project where resource MPP task is not completed or it is not being marked as void.
            If strProjectID <> "" And m_strApproverID <> "" Then
                strSQL = "usp_sel_GetMppTaskStatus " + strProjectID + "," + m_strApproverID
                dr1 = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
                While dr1.Read
                    strTaskStatus = CType(CommonFunctions.General.CheckIsNothing(dr1("MppStatus"), ""), String)
                    If strTaskStatus = "1" Then
                        strProjectName = strProjectName + "\n" + CType(CommonFunctions.General.CheckIsNothing(dr1("ProjectName"), ""), String)
                    End If
                End While
                'Commented and added by Shamkant s for HTML encoding Date:06/10/15
                CommonFunctions.HTMLControls.DrawTextBox("txthidMppTask" & strProjectID, "txthidMppTask" & strProjectID, , , , strTaskStatus, , , , , , True, EnableHTMLEncode:=True)
                'ended by Shamkant s  for HTML encoding Date:06/10/15
                CommonFunction.Data.DisposeDataReader(dr1)
            End If
            'End By VarunA on 31-Aug-2009 RequestD-22509
            If Not dr.Read Then
                Exit While
            End If
            cnt += 1
        End While
        sbHtml.Append("<br>")
        sbHtml.Append("</Div>")
        sbHtml.Append("<br>")
        CommonFunction.General.WriteHTML(sbHtml.ToString)
        CommonFunction.Data.DisposeDataReader(dr)
        CommonFunction.Data.DisposeDataReader(drIRAcombo)
        CommonFunction.Data.DisposeDataReader(drIRGcombo)
        CommonFunction.Data.DisposeDataReader(drApprovalcombo)
        CommonFunction.Data.DisposeDataReader(drProjcombo)



    End Sub

    Private Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : DrawGrid()	
        ' Purpose               : Plots the grid 
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 06/10/2005
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String
        Dim strTempEmployeeID As String, strTempStatusCode As String, strTempDateID As String, strTempLastID As String
        Dim strTempsortby As String, strTempsortorder As String

        '----------To store the column Headings(user friendly name)-------
        Dim arrColumnHeadingList() As String = {CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("COL_EMPLOYEE"), "Employee") _
                                                , CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("COL_APPROVER"), "Approver") _
                                                , CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("COL_LAST_APPROVER"), "Last Approver") _
                                                }

        '---------Atual column name  -------------------------------------
        Dim arrActualColumnNames() As String = {"EmployeeName" _
                                                , "Approver" _
                                                , "LastApprover" _
                                               }
        '-----------------------------------------------------------------

        Dim arrTDStyle() As String = {"align=left" _
                                            , "align=left" _
                                            , "align=left" _
                                            }
        '-----------------------------------------------------------------

        strQuery = m_strGridSQL & ",'" & m_strAlphabet & "'"
        CommonFunctions.General.WriteHTML("<DIV id='DivList' style='Overflow:auto;width=100%'>")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Shamkant s  for HTML encoding Date:06/10/15

        With m_objGrid
            .ActualColumnArray = arrActualColumnNames
            .UserFriendlyColumnArray = arrColumnHeadingList
            .NoOfDataColumns = 3
            .TDStyleArray = arrTDStyle
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 100%
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strQuery
            .UseSQL = True
            .PrimaryKey = "EmployeeID"
            .DrawGrid()
        End With
        m_objGrid = Nothing
        CommonFunctions.General.WriteHTML("</DIV>")

    End Sub

    Private Sub DrawDefaultApprover()
        Response.Write("<Table Class=clsTable Width='99.9%'>")
        Response.Write("<TR align=center>")
        Response.Write("<TD align=center>")
        Response.Write(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("CAP_DEFAULT_APPROVER"), "Select Default Approver"))
        Response.Write("&nbsp;")
        CommonFunctions.HTMLControls.DrawComboBox("ReportingTo", m_strDefaultApproverSQL, , , , True, , , True)

        Response.Write("</TD>")
        Response.Write("</TR>")
        Response.Write("</Table>")
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
        ' Author                : HarshK
        ' Created               : 06/10/2005
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function
#End Region

#Region " Init  Functions "
    Private Sub Init_Variables()
        If CommonFunctions.General.CheckIsNothing(Request("Alphabet")) <> "" Then
            m_strAlphabet = Request("Alphabet") + ""
        Else
            m_strAlphabet = "-1"
        End If
        m_strApproverID = CommonFunctions.General.CheckIsNothing(Request.QueryString("ApproverID"), "0")
        m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action"), "")
        '--------------------------------------

        m_strGridSQL = "usp_sel_tbl_PM_Employee_GetApproveToList  " & m_strApproverID

        m_strDefaultApproverSQL = "usp_Sel_Other_tbl_PM_Employee_High_Medium " & m_strApproverID


        m_TagShowHistory = "3081"

        'Added by ArchanaN
        m_strIsRepApprover = Request.QueryString("IsRepApprover")
        'End by ArcahnaN




        'Added by MrugajaB on 1st Dec 2006 doe Whiziblesem SP8
        'Modified By ShraddhaM on 23,Feb 2007 ( Handled Null Case of Joining Date to avoid crash on Employee Mainatainance --> Release Link )
        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        ''' m_strJoiningDate = CType(CommonFunction.Data.GetDataScalar("SELECT isNull(JoiningDate,'') FROM tbl_PM_Employee WHERE EmployeeID=" & m_strApproverID, MyBase.UseSQL), String)
        m_strJoiningDate = CType(CommonFunction.Data.GetDataScalar("usp_sel_JoiningDate_tbl_PM_Employee " & m_strApproverID, MyBase.UseSQL), String)
        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        m_strJoiningDate = CommonFunctions.Dates.GetDate(Date.Parse(CommonFunctions.Data.CheckIsDBNull(m_strJoiningDate, "").ToString))
        'End Addition by ShraddhaM
    End Sub
    Protected Sub NewInitPage()
        If Request.QueryString("FromXML") = "1" Then
            Response.Clear()
            DrawHTML()
            Response.End()
            Exit Sub
        End If

        Init_Variables()

        ReleaseResource()

        If m_strIsRepApprover Is Nothing Then
            ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
            ''m_strIsRepApprover = CType(CommonFunction.Data.GetDataScalar("SELECT Top 1 1 FROM tbl_PM_Employee WHERE ReportingTo=" + m_strApproverID + " AND Status=0", MyBase.UseSQL), String)
            'Commented and added by Yogesh Jalamkar on 10-NOV-2016 Purpose: Pass Paremeter to SP
            'm_strIsRepApprover = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_Employee_ReportingTo ", MyBase.UseSQL), String)
            m_strIsRepApprover = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_Employee_ReportingTo " & m_strApproverID, MyBase.UseSQL), String)
            ''End of addition by Yogesh Jalamkar on 10-NOV-2016
            ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        End If
        DrawMenu(True)


        CommonFunctions.General.WriteHTML("<DIV id='DivMain' name='DivMain' style='Overflow:auto;height:99.9%;width:100%;'>")


        CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtJoiningDate", "txtJoiningDate", , 80, m_strJoiningDate, , "frmHR_ApproverToList", returnHTML:=True, IsMandatory:=True, DisplayNone:=True))



        DrawBlankGrid()

        DrawConfigureEmployeeApproversSection()
        CommonFunctions.General.WriteHTML("</DIV>")


    End Sub
    Private Sub DrawHTML()
        Dim sbHtml As New System.Text.StringBuilder
        Dim strSQL As String
        Dim dr As IDataReader
        Dim drProjcombo As IDataReader
        Dim drApprovalcombo As IDataReader
        Dim drIRGcombo As IDataReader
        Dim drIRAcombo As IDataReader
        Dim strProject As String
        Dim strProjectManager As String
        Dim strProjectID As String
        Dim strClass As String
        Dim IsApproverPresent As Boolean
        Dim blnIsProjRes As Boolean
        Dim blnIsApprovalRes As Boolean
        Dim blnIsIRGenerator As Boolean
        Dim blnIsIRApprover As Boolean
        Dim PER_DA_Date As String
        '-------- Added By PurvaJ on 26 May 2008 Configurable workflow
        Dim blnIsWorkflowapprover As Boolean
        '-------- End Addition PurvaJ


        m_strApproverID = Request.QueryString("ApproverID")
        strProjectID = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"), "0")


        strSQL = "usp_Sel_Approvers_List_ToRelease " & m_strApproverID & "," & strProjectID
        dr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If dr.Read = True Then
            blnIsProjRes = CType(CommonFunctions.General.CheckIsNothing(dr("IsProjectRes"), ""), Boolean)
            blnIsApprovalRes = CType(CommonFunctions.General.CheckIsNothing(dr("IsApprovalRes"), ""), Boolean)
            blnIsIRGenerator = CType(CommonFunctions.General.CheckIsNothing(dr("IsInvoiceGenRes"), ""), Boolean)
            blnIsIRApprover = CType(CommonFunctions.General.CheckIsNothing(dr("IsIR_PIRAppRes"), ""), Boolean)
            PER_DA_Date = CType(dr("PER_DA_MAX_Date"), DateTime).ToString("dd-MMM-yyyy")
            '-------- Added By PurvaJ on 26 May 2008 Configurable workflow
            blnIsWorkflowapprover = CType(CommonFunctions.General.CheckIsNothing(dr("IsWorkflowApprovalRes"), ""), Boolean)
            '-------- End Addition PurvaJ
            '  strIsAllocatedOnProj = CType(CommonFunctions.General.CheckIsNothing(dr("IsAllocatedOnProj"), ""), Boolean)
        End If
        'CommonFunctions.General.WriteHTML(strWriteHTML.ToString)
        Dim GroupingColName As CommonFunctions.HTMLControls.WAF_DropDown = New CommonFunctions.HTMLControls.WAF_DropDown
        GroupingColName.DropdownGroupingColumn = "IsExternal"
        'GroupingColName.ConnectionString = "usp_Sel_Approvers_List " & strProjectID & "," & m_strApproverID
        GroupingColName.WidthInPixel = 120
        GroupingColName.InsertBlankRow = True
        GroupingColName.ReturnHTML = True
        GroupingColName.IsMandatory = True

        GroupingColName.MandatoryImagePath = "../../Images/Star.gif"""

        '  drProjcombo = CommonFunction.Data.GetDataReader("usp_Sel_Approvers_List " & strProjectID & "," & m_strApproverID, MyBase.UseSQL)
        'drApprovalcombo = CommonFunction.Data.GetDataReader("usp_Sel_Approvers_List " & strProjectID & "," & m_strApproverID & ",1", MyBase.UseSQL)
        'If drApprovalcombo.Read Then
        If blnIsProjRes = True Then
            sbHtml.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProjectResp" + strProjectID, "usp_Sel_Approvers_List " & strProjectID & "," & m_strApproverID & ",1", 150, , , True, True, , True) + "$___#")
        Else
            sbHtml.Append("-$___#")
        End If
        'If drProjcombo.Read Then
        If blnIsApprovalRes = True Then
            sbHtml.Append(CommonFunctions.HTMLControls.DrawComboBox("cboApprovalResp" + strProjectID, "usp_Sel_Approvers_List " & strProjectID & "," & m_strApproverID, GroupingColName) + "$___#")
        Else
            sbHtml.Append("-$___#")
        End If


        If blnIsIRGenerator = True Then
            sbHtml.Append(CommonFunctions.HTMLControls.DrawComboBox("cboInvoiceGenerator" + strProjectID, "usp_sel_PM_AccountPersonList " & strProjectID, 150, , , True, True, , True) + "$___#")
        Else
            sbHtml.Append("-$___#")
        End If
        ' End If

        If blnIsIRApprover = True Then
            sbHtml.Append(CommonFunctions.HTMLControls.DrawComboBox("cboIRApprover" + strProjectID, "usp_Sel_tbl_PM_Role_RFIApprover " & strProjectID, 150, , , True, True, , True))
            sbHtml.Append("<input type=hidden id=PER_DA_Date" + strProjectID + " name=PER_DA_Date" + strProjectID + " value='" + PER_DA_Date + "' >")
        Else
            sbHtml.Append("<input type=hidden id=PER_DA_Date" + strProjectID + " name=PER_DA_Date" + strProjectID + " value='" + PER_DA_Date + "' >")
            sbHtml.Append("-$___#")
        End If
        '  End If

        '-------- Added By PurvaJ on 26 May 2008 Configurable workflow
        If blnIsWorkflowapprover = True Then
            sbHtml.Append(CommonFunctions.HTMLControls.DrawComboBox("cboEmployeeforworkflow" + strProjectID, "usp_Sel_Approvers_List " & strProjectID & "," & m_strApproverID, GroupingColName))
        Else
            sbHtml.Append("-$___#")
        End If
        '-------- End Addition PurvaJ


        CommonFunction.General.WriteHTML(sbHtml.ToString)
        CommonFunction.Data.DisposeDataReader(drIRAcombo)
        CommonFunction.Data.DisposeDataReader(drIRGcombo)
        CommonFunction.Data.DisposeDataReader(drApprovalcombo)
        CommonFunction.Data.DisposeDataReader(drProjcombo)
        CommonFunction.Data.DisposeDataReader(dr)
    End Sub


    Private Sub DrawConfigureEmployeeApproversSection()
        '=====================================================================
        ' Procedure Name        : DrawApproverForReportingTo()	
        ' Purpose               : Plots the grid 
        ' Returns               : None
        ' Author                : ArchanaN
        ' Created               : 03/01/2008
        ' Revisions             :
        '=====================================================================

        DrawPageRepToCaption()


        Dim strRepToList As String
        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        ''strRepToList = " SELECT EmployeeID,UserName FROM  V_tbl_PM_Resource_Selection WHERE EmployeeID != " + m_strApproverID + " Order by EmployeeName"
        strRepToList = "usp_sel_V_tbl_PM_Resource_Selection_UserName " + m_strApproverID
        ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        ' Dim strRepToList As String = CType(CommonFunction.Data.GetDataScalar(strQuery, MyBase.UseSQL), String)

        If intFlag = 0 Then
            '--- added By purvaj on 10 Nov 2008 for Whiziblesem8.0 Helpdesk workflow resource release
            m_strNewHDworkflowApprover = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_IsHelpDeskWorkflowApprover " + CType(m_strApproverID, String), True), "0"), "0")
            If m_strNewHDworkflowApprover = "1" Then
                CommonFunction.General.WriteHTML("<TABLE ID='HelpDeskworkflow' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>") '<DIV id='DivHD' name='DivHD' style='Overflow:auto;height:50px;width:100%;'><BR>
                CommonFunction.General.WriteHTML("<tr>")
                CommonFunction.General.WriteHTML("<td align='Left' width=80%>")
                CommonFunction.General.WriteHTML("Resource is responsible for Knowledge Management workflow approvals. Select the new approver")
                CommonFunction.General.WriteHTML("</td>")

                CommonFunction.General.WriteHTML("<td align='Left' width=20%>")
                CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("cboEmployeeforHDworkflow", "usp_sel_tbl_PM_Employee ", 200, , , True, True))
                CommonFunction.General.WriteHTML("</td>")
                CommonFunction.General.WriteHTML("</tr></table>") '</DIV>
                CommonFunction.General.WriteHTML("<br>")
            End If
        End If

        '--- End adddition PurvaJ


        If m_strIsRepApprover = "1" Then
            CommonFunction.General.WriteHTML("<br><TABLE id='tblNoteRep' CellSpacing=0 class='clsTable' width='99.9%'>")


            Response.Write("<TR class='clsTREven'>")
            Response.Write("<TD valign=top align=left>")
            CommonFunction.General.WriteHTML("<b>Note:</b>&nbsp; The resource is 'Reporting To' for the following Resources." + vbCrLf)
            CommonFunction.General.WriteHTML("</TD></TR>")
            CommonFunction.General.WriteHTML("<TR>")
            CommonFunction.General.WriteHTML("<TD align=left><b>Select New Reporting To : </b>")
            CommonFunctions.HTMLControls.DrawComboBox("ReportingTo", strRepToList, , , , True)
            CommonFunction.General.WriteHTML("<A Href=""javascript:ResourceSelection()""  Title='Select New Reporting To'><IMG src='../../Images/Lookup.gif' id='ResourceSelection' border=0></A></TD></TR></table>")


            DrawGridForReportingTo()
        End If
        'm_strApproverID
        CommonFunction.General.WriteHTML("<TABLE id='tblForm023' CellSpacing=0 class='clsTable' width='99.9%'><TR class='clsTREven'>") '<TD valign=top align=left>")
        CommonFunction.General.WriteHTML("<TD align=left><b>Set Leaving Date : </b>")
        Dim m_strCurrentDate As String = CType(CommonFunction.Data.GetDataScalar("select getdate()", MyBase.UseSQL), String)
        m_strCurrentDate = CommonFunctions.Dates.GetDate(Date.Parse(CommonFunctions.Data.CheckIsDBNull(m_strCurrentDate, "").ToString))

        CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtLeavingDate", "txtLeavingDate", , 80, , , "frmHR_ApproverToList", returnHTML:=True, TabIndex:=8))
        CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtCurrentDate", "txtCurrentDate", , 80, m_strCurrentDate, , "frmHR_ApproverToList", returnHTML:=True, DisplayNone:=True))
        CommonFunction.General.WriteHTML("</TD></TR></Table><BR>")
        Dim MAxDAEntryDate As String
        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        ''MAxDAEntryDate = CType(CommonFunction.Data.GetDataScalar("SELECT ISNULL(MAX(EntryDate),'1-Jan-1979') FROM tbl_PM_DailyActivity WHERE EmployeeID =" + m_strApproverID, MyBase.UseSQL), DateTime).ToString("dd-MMM-yyyy")
        MAxDAEntryDate = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_DailyActivity_EntryDate " + m_strApproverID, MyBase.UseSQL), DateTime).ToString("dd-MMM-yyyy")
        ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        CommonFunction.General.WriteHTML("<INPUT type=hidden id=MAXDA value='" + MAxDAEntryDate + "'>")

    End Sub
    Private Sub DrawGridForReportingTo()
        '=====================================================================
        ' Procedure Name        : DrawGrid()	
        ' Purpose               : Plots the grid 
        ' Returns               : None
        ' Author                : ArchanaN
        ' Created               : 03/01/2008
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String
        Dim strTempEmployeeID As String, strTempStatusCode As String, strTempDateID As String, strTempLastID As String
        Dim strTempsortby As String, strTempsortorder As String

        Dim arrColumnHeadingList() As String = {CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("COL_EMPLOYEE"), "Employee")}
        ', CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("COL_APPROVER"), "Approver") _


        Dim arrActualColumnNames() As String = {"EmployeeName"}

        Dim arrTDStyle() As String = {"align=left", "align=left"}
        m_objGrid = New WebPages.Template.GenericGrid
        strQuery = m_strGridSQL ' & ",'" & m_strAlphabet & "'"
        CommonFunctions.General.WriteHTML("<DIV id='DivListRepTO' style='Overflow:auto;width=100%'>")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Shamkant s  for HTML encoding Date:06/10/15

        With m_objGrid
            .ActualColumnArray = arrActualColumnNames
            .UserFriendlyColumnArray = arrColumnHeadingList
            .NoOfDataColumns = 1
            .TDStyleArray = arrTDStyle
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivListRepTO"
            .DIVHeight = 100%
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strQuery
            .UseSQL = True
            .PrimaryKey = "EmployeeID"
            .DrawGrid()
        End With
        m_objGrid = Nothing

        CommonFunctions.General.WriteHTML("</DIV>")

    End Sub

    Private Sub ReleaseResource()
        If Request.QueryString("Action") Is Nothing OrElse Request.QueryString("Action") <> "SAVE" Then
            Exit Sub
        End If
        Dim checkProjects As String
        Dim ProjectReleaseDate As String
        Dim LeavingDate As String
        Dim ProjectResp As String
        Dim ApproverResp As String
        Dim InvoiceGenerator As String
        Dim IRApprover As String
        Dim CorpNewReportingTo As String
        '-------- Added By PurvaJ on 26 May 2008 Configurable workflow
        Dim WorkflowApprover As String = ""
        '-------- End Addition PurvaJ

        Dim arrProjectID As String()
        Dim counter As Integer = 0
        Dim strSQL As String
        Dim dr As IDataReader

        ProjectReleaseDate = Request.Form("txtProjectActualEndDate")
        checkProjects = Request.Form("cboProjectID") + ""

        If checkProjects <> "" Then
            arrProjectID = checkProjects.Split(","c)
            While counter < arrProjectID.Length
                If Not Request.Form("chkSelect" + arrProjectID(counter)) Is Nothing Then

                    strSQL = "EXEC Usp_Upd_Released_Resource "

                    ProjectResp = Request.Form("cboProjectResp" + arrProjectID(counter))
                    If ProjectResp Is Nothing OrElse ProjectResp = "" Then
                        ProjectResp = "NULL"
                    End If


                    ApproverResp = Request.Form("cboApprovalResp" + arrProjectID(counter))
                    If ApproverResp Is Nothing OrElse ApproverResp = "" Then
                        ApproverResp = "NULL"
                    End If

                    InvoiceGenerator = Request.Form("cboInvoiceGenerator" + arrProjectID(counter))
                    If InvoiceGenerator Is Nothing OrElse InvoiceGenerator = "" Then
                        InvoiceGenerator = "NULL"
                    End If

                    IRApprover = Request.Form("cboIRApprover" + arrProjectID(counter))
                    If IRApprover Is Nothing OrElse IRApprover = "" Then
                        IRApprover = "NULL"
                    End If

                    '-------- Added By PurvaJ on 26 May 2008 Configurable workflow

                    WorkflowApprover = Request.Form("cboEmployeeforworkflow" + arrProjectID(counter))
                    If WorkflowApprover Is Nothing OrElse WorkflowApprover = "" Then
                        WorkflowApprover = "NULL"
                    End If
                    '-------- End Addition PurvaJ

                    strSQL += m_strApproverID + "," 'EmployeeID
                    strSQL += arrProjectID(counter) + "," 'ProjectID
                    strSQL += ProjectResp + "," ' Project Responsibilities
                    strSQL += ApproverResp + "," 'Approval Responsibilities
                    strSQL += InvoiceGenerator + "," 'Invoice Generator
                    strSQL += IRApprover + "," ' IR Approver
                    strSQL += "'" + ProjectReleaseDate + "'," 'Project Release Date
                    strSQL += "'" + Session("strUserName").ToString + "'"
                    '-------- Added By PurvaJ on 26 May 2008 Configurable workflow
                    strSQL += "," + WorkflowApprover.ToString
                    '-------- End Addition PurvaJ

                    CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                End If
                counter += 1
            End While

        End If

        '--- Added By PurvaJ on 10 Nov 2008 for Whiziblesem 8.0 Helpdesk workflow resource release
        m_strNewHDworkflowApprover = CommonFunction.General.CheckIsNothing(Request.Form("cboEmployeeforHDworkflow"), "0")
        CommonFunction.Data.InsertOrUpdateData("usp_UPD_Workflow_ReleaseProjectResource " + m_strApproverID + "," + m_strNewHDworkflowApprover + ",-1", True)
        '--- End addition PurvaJ

        strSQL = "usp_Sel_Approvers_List_ToRelease " & m_strApproverID
        dr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If Not dr.Read Then
            'm_strApproverID
            CorpNewReportingTo = Request.Form("ReportingTo")
            If CorpNewReportingTo Is Nothing Then
                CorpNewReportingTo = "null"
            End If
            LeavingDate = Request.Form("txtLeavingDate")
            CommonFunction.Data.InsertOrUpdateData("usp_Upd_tbl_PM_Employee_ReportingTo " + m_strApproverID + "," + CorpNewReportingTo + ",'" + LeavingDate + "'", MyBase.UseSQL)
            Response.Write("<script>alert('Resource is released successfully');</script>")
        End If
        CommonFunction.Data.DisposeDataReader(dr)
        Response.Write("<script>refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FocusOn=SUBTAG',true); window.close();</script>")
    End Sub

#End Region

#Region " Constructor "
    Public Sub New()

        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'MyBase.InitializeResources("AppResources.HR_ApproverToList", "AppResources")
        MyBase.InitializeResources("AppResources.HR_ApproverToList", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here

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

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "APPROVER" Then
            strEmployeeID = strEmployeeID + CStr(Args.DataReader.Item("EmployeeID")) + ","
            Args.StringToBeInserted = "<TD Align='Left'> " + CommonFunctions.HTMLControls.DrawComboBox("cboNewApprover" & CStr(Args.DataReader.Item("EmployeeID")), m_strDefaultApproverSQL, , , , True, True) + "</TD>"
            Cancel = True
        End If
    End Sub

End Class

