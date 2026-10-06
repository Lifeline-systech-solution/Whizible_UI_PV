Imports ProjectByNet
Namespace CommonEngine
    Namespace General
        Public Class CLCP_Events_Sections

            Public Shared Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
                'This event will occur before ploting each of the Common Page Sections
                Cancel = False

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case Args.SectionID
                        Case CommonFunction.Constants.SECTION_HEADER
                            'Header Section
                            Select Case WhizGlobal.TagID
                                ' Case CommonFunction.Constants.APP_TAG_COMPANY_INFORMATION
                                'If (Args.SectionID = 1) Then
                                ''Selec't Case Args.TagSectionID.ToString
                                'Case "DELETE"
                                'Cancel = True
                                ' End Select
                                ' End If
                            End Select
                            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                            'Case CommonFunction.Constants.SECTION_SUBTAG
                            '    'Added by DipaliS_23122004
                            '    'Integreated by MrugajaB on 3 Mar 2005 for WhizibleSEM SP2 Issue ID.16639
                            '    'Purpose    :   To check if there is access for the subTags for given Tag.
                            '    'If there is no access do not plot the subtag section
                            '    Dim strSQLForSubTag As String = "usp_sel_Tbl_UI_SubTagMaster_IsSubTagAccessible " + WhizGlobal.TagID.ToString + "," + CommonFunction.General.CheckIsNothing(WhizGlobal.RoleID.ToString, "NULL") + "," + CommonFunction.General.CheckIsNothing(WhizGlobal.UserID.ToString, "NULL") + "," + CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID.ToString, "NULL")
                            '    Dim blnIsSinlgeSubTagAccessible As Boolean
                            '    'blnIsSinlgeSubTagAccessible = CType(CommonFunction.Data.GetDataScalar(strSQLForSubTag, CommonFunction.General.GetApplicationKeySetting("UseSQL")), Boolean)
                            '    blnIsSinlgeSubTagAccessible = Convert.ToBoolean(CommonFunction.Data.GetDataScalar(strSQLForSubTag, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                            '    If blnIsSinlgeSubTagAccessible = False Then
                            '        Cancel = True
                            '        Exit Sub
                            '    End If
                            '    'End addition by DipaliS_23122004

                            'End Of Modifications - IssueID : 672
                            'Footer Section
                            Select Case WhizGlobal.TagID

                                Case CommonFunction.Constants.APP_TAG_TAB_RATE_CONTRACT
                                    'Added By Paresh B on August 10, 2004
                                    'Purpose : To Hide the details section if no master record exists

                                    'Declarations
                                    Dim strSQL As String                        'The Query to fire
                                    Dim drWorkOrderRateContract As IDataReader  'Datareader to hold the result of the stored Proc

                                    'Set the name of the stored proc
                                    strSQL = "usp_Sel_tbl_PM_WorkOrderRateContract " & HttpContext.Current.Session("intProjectID").ToString

                                    'Execute the query and get data into datareader
                                    drWorkOrderRateContract = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    'If Mandatory Field (Contract Validity Date) exists then show the details section otherwise hide the details section
                                    If drWorkOrderRateContract.Read = True Then
                                        'If CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drWorkOrderRateContract.Item("ContractValidityDate")), ""), "") = "" Then
                                        If CommonFunctions.Data.CheckIsDBNull(drWorkOrderRateContract.Item("ContractValidityDate"), "").ToString = "" Then
                                            '  Cancel = True 'Commented by PAresh B on sep. 21, 2004 because contract validity date is removed

                                        End If
                                    End If
                                    ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                    'drWorkOrderRateContract = Nothing
                                    CommonFunction.Data.DisposeDataReader(drWorkOrderRateContract)
                                    ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745



                                Case CommonFunction.Constants.APP_TAG_TAB_CONTRACT_CLAUSES
                                    Dim drRoleAccess As IDataReader
                                    Dim strSQL As String = "usp_sel_tbl_pm_WOUSerAccess " & WhizGlobal.RoleID & ",'" & CommonFunction.General.BuildQueryString(Args.SectionTitle) & "'"
                                    drRoleAccess = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If Not (drRoleAccess.Read) Then
                                        Cancel = True
                                    End If
                                    CommonFunction.Data.DisposeDataReader(drRoleAccess)
                                Case CommonFunction.Constants.APP_TAG_RATECONTRACTBYROLE
                                    Dim strSQL As String = "SELECT ContractValidityDate FROM tbl_PM_WorkOrderRateContract WHERE ProjectID =" + PrimaryKey
                                    Dim dtValidityDate As Object
                                    dtValidityDate = CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If IsDBNull(dtValidityDate) Then
                                        Cancel = True
                                    End If
                                    'Commented By VidyaJ - IssueID - 11097
                                    'Case CommonFunction.Constants.APP_TAG_MODULES
                                    '    'If ChangeRequest is disabled for the Project Type of the Project in session 
                                    '    'then do not plot the Tasks tab
                                    '    Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                                    '    Dim strSQL As String = "usp_Sel_PM_ShowTaskTab " + intProjectID.ToString + ", 'MODULE'"
                                    '    If (CommonFunction.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) Is Nothing) Then
                                    '        Cancel = True
                                    '    End If

                                    'Case CommonFunction.Constants.APP_TAG_SUB_PROJECTS
                                    '    'If ChangeRequest is disabled for the Project Type of the Project in session 
                                    '    'then do not plot the Tasks tabfile
                                    '    Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                                    '    Dim strSQL As String = "usp_Sel_PM_ShowTaskTab " + intProjectID.ToString + ", 'SUBPROJECT'"
                                    '    If (CommonFunction.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) Is Nothing) Then
                                    '        Cancel = True
                                    '    End If

                                    'Added by JayavantK on 14-Sep-2004
                                Case CommonFunction.Constants.APP_TAG_DESIGNATION_MASTER
                                    'Commented By HarshK on 14 April 2006  
                                    'Dim strQuery As String = ""
                                    'Dim blnAllowLeaveWorkflow As Boolean = False

                                    'strQuery = "SELECT AllowLeaveWorkFlow FROM tbl_PM_CompanyInformation"
                                    'blnAllowLeaveWorkflow = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), Boolean)
                                    'If blnAllowLeaveWorkflow = False Then
                                    '    'Cancel = True
                                    'End If
                                    'End Commented By HarshK on 14 April 2006 
                                    'End Addition
                                    'Integrated by MrugajaB on 23rd March 2006 for WhizibleSEM 6.0 Expense WorkFlow - Issue ID.2886
                                Case CommonFunction.Constants.APP_TAG_PROJECT_DOH

                                    Dim strSQL As String
                                    Dim ExpenseWorkFlow As String

                                    If (PrimaryKey <> "") And (Args.SectionID = 2) Then
                                        strSQL = "SELECT ExpenseWorkFlow FROM tbl_PM_CompanyInformation "
                                        ExpenseWorkFlow = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0")

                                        If ExpenseWorkFlow.ToUpper = "FALSE" Then
                                            Cancel = True
                                        End If
                                    End If
                                    'End Integaration

                            End Select
                        Case CommonFunction.Constants.SECTION_RELATED_DATA
                            'Related Data Section
                            Select Case WhizGlobal.TagID
                                Case CommonFunction.Constants.PM_PROJECT_LISTING
                                    If WhizGlobal.RoleID = CommonFunction.Constants.ROLE_CUSTOMER Then
                                        'Do not show Data section to the Customer
                                        Cancel = True
                                    End If
                            End Select
                        Case CommonFunction.Constants.SECTION_GRAPH
                            'Graph Section
                            Select Case WhizGlobal.TagID
                                Case CommonFunction.Constants.PM_PROJECT_LISTING
                                    If WhizGlobal.RoleID = CommonFunction.Constants.ROLE_CUSTOMER Then
                                        'Do not show Data section to the Customer
                                        Cancel = True
                                    End If
                            End Select
                        Case CommonFunction.Constants.SECTION_FOOTER
                            'Footer Section
                            Select Case WhizGlobal.TagID

                            End Select

                            ''Added by Dhanashri S on 29 Oct 2015
                        Case CommonFunction.Constants.TAG_ROLE_MAINTENANCE
                            'Role Maintenance
                            If Args.SectionID = CommonFunction.Constants.SECTION_SUBTAG And PrimaryKey.Trim = CommonFunction.Constants.ROLE_CUSTOMER.ToString Then
                                'For Customer Role do not show the Sub Tag Section
                                Cancel = True
                            End If
                            ''End of Addition by Dhanashri S on 29 Oct 2015
                    End Select

                Else
                    'For Details Tag
                    Select Case Args.SectionID
                        Case CommonFunction.Constants.SECTION_HEADER
                            'Header Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_SUBTAG
                            'Footer Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_RELATED_DATA
                            'Related Data Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_GRAPH
                            'Graph Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_FOOTER
                            'Footer Section
                            Select Case WhizGlobal.TagID

                            End Select
                    End Select
                End If
            End Sub

            Public Shared Sub After_PlotSection(ByVal Args As EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
                'This event will occur After ploting each of the Common Page Sections

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case Args.SectionID
                        Case CommonFunction.Constants.SECTION_HEADER
                            'Header Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_SUBTAG
                            'Footer Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_RELATED_DATA
                            'Related Data Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_GRAPH
                            'Graph Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_FOOTER
                            'Footer Section
                            Select Case WhizGlobal.TagID

                            End Select
                    End Select

                Else
                    'For Details Tag
                    Select Case Args.SectionID
                        Case CommonFunction.Constants.SECTION_HEADER
                            'Header Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_SUBTAG
                            'Footer Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_RELATED_DATA
                            'Related Data Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_GRAPH
                            'Graph Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_FOOTER
                            'Footer Section
                            Select Case WhizGlobal.TagID

                            End Select
                    End Select
                End If
            End Sub

            Public Shared Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
                'This event will occur before plotting the Section Title
                'This event will occur before ploting each of the Common Page Sections' Title
                Cancel = False

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case Args.SectionID
                        Case CommonFunction.Constants.SECTION_HEADER
                            'Header Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_SUBTAG
                            'Footer Section
                            Select Case WhizGlobal.TagID
                                'Integrated by MrugajaB on 20th March 2006 for WhizibleSEM 6.0 Expense WorkFlow - Issue ID.2886
                                'Case CommonFunction.Constants.APP_TAG_PROJECT_DOH
                                '        If PrimaryKey <> "" And Args.SectionID = 2 Then
                                '            Cancel = True
                                '        End If
                                'End Integration


                            End Select
                        Case CommonFunction.Constants.SECTION_RELATED_DATA
                            'Related Data Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_GRAPH
                            'Graph Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_FOOTER
                            'Footer Section
                            Select Case WhizGlobal.TagID

                            End Select
                    End Select

                Else
                    'For Details Tag
                    Select Case Args.SectionID
                        Case CommonFunction.Constants.SECTION_HEADER
                            'Header Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_SUBTAG
                            'Footer Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_RELATED_DATA
                            'Related Data Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_GRAPH
                            'Graph Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_FOOTER
                            'Footer Section
                            Select Case WhizGlobal.TagID

                            End Select
                    End Select
                End If
            End Sub

            Public Shared Sub After_PlotSectionTitle(ByVal Args As EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
                'This event will occur after plotting the Section Title

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case Args.SectionID
                        Case CommonFunction.Constants.SECTION_HEADER
                            'Header Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_SUBTAG
                            'Footer Section
                            Select Case WhizGlobal.TagID
                                Case CommonFunction.Constants.TAG_ROLE_MAINTENANCE


                            End Select
                        Case CommonFunction.Constants.SECTION_RELATED_DATA
                            'Related Data Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_GRAPH
                            'Graph Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_FOOTER
                            'Footer Section
                            Select Case WhizGlobal.TagID

                            End Select
                    End Select

                Else
                    'For Details Tag
                    Select Case Args.SectionID
                        Case CommonFunction.Constants.SECTION_HEADER
                            'Header Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_SUBTAG
                            'Footer Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_RELATED_DATA
                            'Related Data Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_GRAPH
                            'Graph Section
                            Select Case WhizGlobal.TagID

                            End Select
                        Case CommonFunction.Constants.SECTION_FOOTER
                            'Footer Section
                            Select Case WhizGlobal.TagID

                            End Select
                    End Select
                End If
            End Sub

            Public Shared Sub Section_Title_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_SectionTitle, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Cancel = False
                'This Event will occur before printing Section Title
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID

                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID

                    End Select
                End If
            End Sub

            Public Shared Sub Section_Title_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_SectionLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Cancel = False
                'This Event will occur before printing Section Title
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID

                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID
                    End Select
                End If
            End Sub
        End Class
    End Namespace
End Namespace
