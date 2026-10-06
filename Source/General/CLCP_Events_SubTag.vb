Imports ProjectByNet
Namespace CommonEngine
    Namespace General
        Public Class CLCP_Events_SubTag
            Public Shared Sub InitializeTAB_SubTag(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_TabSettings, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
            End Sub
            Public Shared Sub BeforePlotTAB_SubTag(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_Tab, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

                ' integrated by harshada d on 19092005 for issue id 291
                ''Added by PrajaktaR on 15 June for Aspire IssueID 18830

                Dim strSubTagQuery As String
                Dim blnBitA, blnBitE, blnBitD, blnBitV As Boolean
                Dim drSelectQuery As IDataReader

                If HttpContext.Current.Session("intProjectID") Is Nothing Then
                    strSubTagQuery = "EXEC usp_Sel_tbl_UI_SubNodeAccess '" + CType(Args.TabName, String) + "', " + CType(WhizGlobal.RoleID, String) + ", " + CType(WhizGlobal.UserID, String) + ", '" + CType(WhizGlobal.LoginType, String) + "', NULL , " + CType(WhizGlobal.TagID, String)
                Else
                    strSubTagQuery = "EXEC usp_Sel_tbl_UI_SubNodeAccess '" + CType(Args.TabName, String) + "', " + CType(WhizGlobal.RoleID, String) + ", " + CType(WhizGlobal.UserID, String) + ", '" + CType(WhizGlobal.LoginType, String) + "', " + CType(HttpContext.Current.Session("intProjectID"), String) + ", " + CType(WhizGlobal.TagID, String)
                End If

                drSelectQuery = CommonFunctions.Data.GetDataReader(strSubTagQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drSelectQuery.Read Then
                    blnBitA = CType(drSelectQuery("A"), Boolean)
                    blnBitD = CType(drSelectQuery("D"), Boolean)
                    blnBitE = CType(drSelectQuery("E"), Boolean)
                    blnBitV = CType(drSelectQuery("V"), Boolean)

                    If blnBitA = False And blnBitE = False And blnBitD = False And blnBitV = False Then
                        Cancel = True
                    End If
                Else
                    Cancel = True
                End If
                CommonFunction.Data.DisposeDataReader(drSelectQuery)
                drSelectQuery = Nothing
                'End of Addition by PrajaktaR on 15 June for Aspire IssueID 18830
                'end of integration by harshada d on 19092005 for issue id 291
            End Sub
            Public Shared Sub BeforePlotDetails_SubTag(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_SubTag, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
                Select Case Args.SubTagID
                    Case CommonFunction.Constants.APP_SUBTAG_ROLE, CommonFunction.Constants.APP_SUBTAG_RESOURCE
                        'Added By Paresh B on August 09, 2004
                        'Purpose : If Contract Type of project is Rate Contract By Resource hide role subtab
                        'If Contract Type of project is Rate Contract By Role hide resource subtab

                        'Variable Declaration
                        Dim strSQL As String                    'Variable to Hold SQL Query
                        Dim drContractType As IDataReader       'To Hold the recordset in datareader
                        Dim intContractType As Integer           ' To hold the Contract Type of the Project
                        Dim strNodeLabel As String = ""         'Node label for a contract type

                        'Execute the stored Procedure
                        strSQL = "usp_Sel_tbl_PM_ProjectRevision " & HttpContext.Current.Session("intProjectID").ToString

                        'Take the data into datareader
                        drContractType = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                        'If DataReader is not Empty then Take the value of Contract Type in the variable
                        If drContractType.Read = True Then
                            intContractType = CType(drContractType.Item("ContractType"), Integer)
                        End If


                        'hide the tab of role if Contract type is Rate Contract By Resource
                        Select Case Args.SubTagID
                            Case CommonFunction.Constants.APP_SUBTAG_ROLE
                                If intContractType = CommonFunction.Constants.RATECONTRACTTYPE.CONTRACT_BY_RESOURCE Then
                                    Cancel = True
                                End If
                            Case CommonFunction.Constants.APP_SUBTAG_RESOURCE
                                If intContractType = CommonFunction.Constants.RATECONTRACTTYPE.CONTRACT_BY_ROLE Then
                                    Cancel = True
                                End If
                        End Select
                        ' Select Case Args.SubTagID
                        'Case CommonFunction.Constants.APP_TAG_COMPANY_INFORMATION
                        'If Args.SelectedSubTagID = CommonFunction.Constants.DAPP_TAG_TAB_ASSIGN_GLOBAL_PROJECTS Then
                        'Cancel = True
                        ' End If
                        'End Select
                        'Added by ShamkantD on 13 Oct 2004
                        CommonFunction.Data.DisposeDataReader(drContractType)

                        strSQL = "usp_Sel_GetContractType_NodeLabel_ForProject " & HttpContext.Current.Session("intProjectID").ToString
                        strNodeLabel = CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")).ToString()
                        If strNodeLabel.Trim() <> "" Then
                            Args.Name = strNodeLabel
                        End If
                        CommonFunction.Data.DisposeDataReader(drContractType)
                        'End of addition - ShamkantD on 13 Oct 2004


                    Case CommonFunction.Constants.APP_TAG_TAB_ASSIGN_GLOBAL_PROJECTS
                        If PrimaryKey.Trim = CommonFunction.Constants.ROLE_CUSTOMER.ToString.Trim Then
                            'For Customer Role Do not show Assign Global Projects Sub Tag
                            If Args.SelectedSubTagID = CommonFunction.Constants.APP_TAG_TAB_ASSIGN_GLOBAL_PROJECTS Then
                                'Reset Selected Sub Tag ID
                                Args.SelectedSubTagID = 0
                            End If
                            Cancel = True
                        End If
                        'Added by PrachiK on 17 Feb 2005 for IssueID 16161
                        'Purpose:The Sub tab 'Associated Review Type' should be Removed in the node Review Type.
                        'Case CommonFunction.Constants.APP_TAG_TAB_Associated_Review_Type
                        '    If Args.SelectedSubTagID = CommonFunction.Constants.APP_TAG_TAB_Associated_Review_Type Then
                        '        Args.SelectedSubTagID = 0

                        '    End If
                        '    Cancel = True
                        'Addtion Ended
                    Case CommonFunction.Constants.APP_TAG_TAB_REPORTING_TO
                        Dim strLevel As String
                        'Show this sub tag only of middle level employees
                        strLevel = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_tbl_PM_Employee_Level " + PrimaryKey, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))).ToString
                        If Not (strLevel = "2") Then
                            If Args.SelectedSubTagID = CommonFunction.Constants.APP_TAG_TAB_REPORTING_TO Then
                                Args.SelectedSubTagID = 0
                            End If
                            Cancel = True
                        Else
                            Dim drUserName As IDataReader
                            drUserName = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_Employee " + PrimaryKey, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If drUserName.Read Then
                                Args.Name = Args.Name.Replace("USER_NAME", CommonFunction.Data.CheckIsDBNull(drUserName("UserName")).ToString)
                                Args.Tooltip = Args.Name
                            End If
                            CommonFunction.Data.DisposeDataReader(drUserName)
                        End If
                    Case CommonFunction.Constants.APP_TAG_TAB_ROLE_MAPPING
                        'If no request types are mapped to the department then do not show the Role Mapping sub tag
                        Dim strSQL As String = "SELECT FunctionRequestTypeID FROM tbl_CRM_Function_RequestTypes WHERE FunctionID =" + PrimaryKey
                        Dim drReader As IDataReader
                        drReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        If Not (drReader.Read) Then
                            If Args.SelectedSubTagID = CommonFunction.Constants.APP_TAG_TAB_ROLE_MAPPING Then
                                Args.SelectedSubTagID = 0
                            End If
                            Cancel = True
                        End If
                        CommonFunction.Data.DisposeDataReader(drReader)
                        'Modified By VidyaJ - IssueID - 11097
                    Case CommonFunction.Constants.APP_TAG_TAB_CHANGEREQUEST_TASKS
                        'If ChangeRequest is disabled for the Project Type of the Project in session 
                        'then do not plot the Tasks tab
                        Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                        Dim strSQL As String = "usp_Sel_PM_ShowTaskTab " + intProjectID.ToString + ", 'CHANGEREQUEST'"
                        If (CommonFunction.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) Is Nothing) Then
                            If Args.SelectedSubTagID = CommonFunction.Constants.APP_TAG_TAB_CHANGEREQUEST_TASKS Then
                                Args.SelectedSubTagID = 0
                            End If
                            Cancel = True
                        End If

                    Case CommonFunction.Constants.APP_TAG_TAB_SUBPROJECT_TASKS
                        'If SubProject is disabled for the Project Type of the Project in session 
                        'then do not plot the Tasks tab
                        Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                        Dim strSQL As String = "usp_Sel_PM_ShowTaskTab " + intProjectID.ToString + ", 'SUBPROJECT'"
                        If (CommonFunction.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) Is Nothing) Then
                            If Args.SelectedSubTagID = CommonFunction.Constants.APP_TAG_TAB_SUBPROJECT_TASKS Then
                                Args.SelectedSubTagID = 0
                            End If
                            Cancel = True
                        End If
                    Case CommonFunction.Constants.APP_TAG_TAB_MODULE_TASKS
                        'If Module is disabled for the Project Type of the Project in session 
                        'then do not plot the Tasks tab
                        Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                        Dim strSQL As String = "usp_Sel_PM_ShowTaskTab " + intProjectID.ToString + ", 'MODULE'"
                        If (CommonFunction.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) Is Nothing) Then
                            If Args.SelectedSubTagID = CommonFunction.Constants.APP_TAG_TAB_MODULE_TASKS Then
                                Args.SelectedSubTagID = 0
                            End If
                            Cancel = True
                        End If
                    Case CommonFunction.Constants.APP_TAG_TAB_MILESTONE_TASKS
                        'If Milestone is disabled for the Project Type of the Project in session 
                        'then do not plot the Tasks tab
                        Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                        Dim strSQL As String = "usp_Sel_PM_ShowTaskTab " + intProjectID.ToString + ", 'MILESTONE'"
                        If (CommonFunction.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) Is Nothing) Then
                            If Args.SelectedSubTagID = CommonFunction.Constants.APP_TAG_TAB_MILESTONE_TASKS Then
                                Args.SelectedSubTagID = 0
                            End If
                            Cancel = True
                        End If

                        ' Added By NitinVS on 2 Apr 2007 for WhizibleSEM SP 8 regression Issue 11860 
                    Case CommonFunction.Constants.APP_TAG_TAB_PHASE_TASKS
                        'If SubProject is disabled for the Project Type of the Project in session 
                        'then do not plot the Tasks tab
                        Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                        Dim strSQL As String = "usp_Sel_PM_ShowTaskTab " + intProjectID.ToString + ", 'PHASE'"
                        If (CommonFunction.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) Is Nothing) Then
                            If Args.SelectedSubTagID = CommonFunction.Constants.APP_TAG_TAB_SUBPROJECT_TASKS Then
                                Args.SelectedSubTagID = 0
                            End If
                            Cancel = True
                        End If
                        'End Addition By NitinVS on 2 Apr 2007 for WhizibleSEM SP 8 regression Issue 11860 

                        ' Added By JayavantK on 02-Jul-2004 - Start
                    Case CommonFunction.Constants.APP_TAG_TAB_CLOSEREQUEST, CommonFunction.Constants.APP_TAG_TAB_CLOSEEXTENDREQUEST
                        Dim strStatus As String = ""
                        Dim lngRequestID As Long = 0
                        Dim strQuery As String = ""
                        Dim objTemplate As WebPages.Template.WhizTemplate

                        objTemplate = New WebPages.Template.WhizTemplate
                        objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                        lngRequestID = CType(CommonFunctions.General.CheckIsNothing(PrimaryKey, "0"), Long)
                        strQuery = "Exec usp_Sel_tbl_PM_ResourceRequest_GetStatus " & lngRequestID.ToString()
                        strStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                        If strStatus.Trim().ToUpper() = "C" Then
                            Args.Name = objTemplate.GetResourceString("CLOSED_COMMENTS")
                        End If
                        objTemplate = Nothing
                        'Modified by TruptiK on 19-Jan-2008

                    Case CommonFunction.Constants.APP_TAG_TAB_DECLINECOMMENTS
                        Dim strStatus As String = ""
                        Dim lngRequestID As Long = 0
                        Dim strQuery As String = ""

                        lngRequestID = CType(CommonFunctions.General.CheckIsNothing(PrimaryKey, "0"), Long)
                        strQuery = "Exec usp_Sel_tbl_PM_ResourceRequest_GetStatus " & lngRequestID.ToString()
                        strStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                        If strStatus.Trim().ToUpper() <> "REJECT" Then
                            If Args.SelectedSubTagID = CommonFunction.Constants.APP_TAG_TAB_DECLINECOMMENTS Then
                                Args.SelectedSubTagID = 0
                            End If
                            Cancel = True
                        End If

                    Case CommonFunction.Constants.APP_TAG_TAB_DECLINEEXTENDCOMMENTS
                        Dim strStatus As String = ""
                        Dim lngRequestID As Long = 0
                        Dim strQuery As String = ""

                        lngRequestID = CType(CommonFunctions.General.CheckIsNothing(PrimaryKey, "0"), Long)
                        strQuery = "Exec usp_Sel_tbl_PM_ResourceRequest_GetStatus " & lngRequestID.ToString()
                        strStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                        If strStatus.Trim().ToUpper() <> "REJECT" Then
                            If Args.SelectedSubTagID = CommonFunction.Constants.APP_TAG_TAB_DECLINEEXTENDCOMMENTS Then
                                Args.SelectedSubTagID = 0
                            End If
                            Cancel = True
                        End If
                        'End of modification by TruptiK on 19-Jan-2008

                        'Revert the resources which are allocated against request but not assigned to project within configured days
                        'Modified by TruptiK on 19-Jan-2008
                    Case CommonFunction.Constants.APP_TAG_TAB_ASSIGNEDRESOURCES, CommonFunction.Constants.APP_TAG_TAB_EXTENDASSIGNEDRESOURCES
                        'End of modification by TruptiK
                        CommonFunctions.Data.InsertOrUpdateData("Exec usp_Upd_tbl_PM_AssignedResources_RevertResources", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        ' Added By JayavantK on 02-Jul-2004 - End

                        ' Added By JayavantK on 31-Aug-2004 - Start
                    Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEREQUEST_SKILLS
                        If CType(HttpContext.Current.Session.Item("SELECT_SUBTAG"), Integer) = 1 Then
                            Args.SelectedSubTagID = CommonFunction.Constants.APP_TAG_TAB_RESOURCEREQUEST_SKILLS
                            HttpContext.Current.Session.Item("SELECT_SUBTAG") = 0
                        End If
                    Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEEXTENDREQUEST_SKILLS
                        If CType(HttpContext.Current.Session.Item("SELECT_SUBTAG"), Integer) = 1 Then
                            Args.SelectedSubTagID = CommonFunction.Constants.APP_TAG_TAB_RESOURCEEXTENDREQUEST_SKILLS
                            HttpContext.Current.Session.Item("SELECT_SUBTAG") = 0
                        End If
                        ' Added By JayavantK on 31-Aug-2004 - End

                        ' Added By JayavantK on 26-Aug-2004 - Start
                        'Case CommonFunction.Constants.APP_TAG_TAB_BUSINESSGROUP_OUPOOLS, _
                        '     CommonFunction.Constants.APP_TAG_TAB_BGPOOLMASTER_OUPOOLS
                        '    Dim strQuery As String = ""
                        '    Dim strResourceAllocationLevel As String = ""

                        '    strQuery = "SELECT ResourceAllocationLevel FROM tbl_PM_CompanyInformation"
                        '    strResourceAllocationLevel = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                        '    If strResourceAllocationLevel.Trim().ToUpper() <> "ODC" Then
                        '        If Args.SelectedSubTagID = CommonFunction.Constants.APP_TAG_TAB_BUSINESSGROUP_OUPOOLS Or _
                        '           Args.SelectedSubTagID = CommonFunction.Constants.APP_TAG_TAB_BGPOOLMASTER_OUPOOLS Then
                        '            Args.SelectedSubTagID = 0
                        '        End If
                        '        Cancel = True
                        '    End If
                        ' Added By JayavantK on 26-Aug-2004 - End

                        'added by SachinR   on 09 Sep 2004
                        'to hide the add Existing OU Tab from the organization structure tag(2184)
                    Case CommonFunction.Constants.APP_TAG_TAB_EXISTING_OU
                        Cancel = True
                        'addition end

                        'Added by JayavantK on 14-Sep-2004
                    Case CommonFunction.Constants.APP_TAG_TAB_LEAVES
                        Dim strQuery As String = ""
                        Dim blnAllowLeaveWorkflow As Boolean = False

                        strQuery = "SELECT AllowLeaveWorkFlow FROM tbl_PM_CompanyInformation"
                        blnAllowLeaveWorkflow = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), Boolean)
                        If blnAllowLeaveWorkflow = False Then
                            If Args.SelectedSubTagID = CommonFunction.Constants.APP_TAG_TAB_LEAVES Then
                                Args.SelectedSubTagID = 0
                            End If
                            Cancel = True
                        End If
                        'End Addition

                        'Added by ShamkantD on 14th Sep 2004 for Checklist tab on Fast Track Review page
                        'Suppress the record count shown in the tag Title
                    Case CommonFunction.Constants.APP_SUBTAG_CHECKLIST_FASTTRACK_REVIEW
                        Args.Information = ""
                        ' To Do
                        ' Added By MahendraV On 12:37 PM 7/12/2007 For WhizibleSEM 7 
                        ' To canceling 'Checklist' tab from fast track review.Now this link will displayed as UI Link
                        ' Start_MV_7/12/2007
                        Cancel = True
                        ' End_MV_7/12/2007
                        'End of addition - ShamkantD on 14th Sep 2004 
                        'Added By JyotiG
                        'Start_JG_CR_7630_23-Nov-2006
                    Case CommonFunction.Constants.APP_SUBTAG_EMPLOYEE_CURRENT_ASSIGNMNETS
                        Args.Information = ""
                        'End_JG_CR_7630_23-Nov-2006
                        'Integrated by MrugajaB on 20th March 2006 for WhizibleSEM 6.0 Expense WorkFlow - Issue ID.2886
                    Case CommonFunction.Constants.APP_TAG_TAB_PROJECT_COST_DETAILS

                        Dim strSQL As String
                        Dim ExpenseWorkFlow As String

                        StrSQL = "SELECT ExpenseWorkFlow FROM tbl_PM_CompanyInformation "
                        ExpenseWorkFlow = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0")

                        If ExpenseWorkFlow.ToUpper = "FALSE" Then
                            Args.SelectedSubTagID = 0
                            Args.Information = ""
                            Cancel = True
                        End If
                        'End Integration
                        'Added by ShraddhaM on 11,Jul 2008
                        'Purpose : To integrate Risk Registration from Whizible 2007 
                    Case CommonFunction.Constants.APP_SUB_TAG_P12PROJECT_RISKS_CONTINEGENCY_PLAN
                        Dim strategy As String
                        Dim riskresponse As String
                        Dim acceptance As String
                        Dim drStrategy As IDataReader
                        Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                        Dim strSQL As String = "usp_Sel_tbl_PM_Risks " + intProjectID.ToString + "," + PrimaryKey
                        drStrategy = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        If drStrategy.Read Then
                            strategy = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drStrategy("CustomFieldText2"), ""), "")
                            riskresponse = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drStrategy("CustomFieldText1"), ""), "")
                            acceptance = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drStrategy("CustomFieldText5"), ""), "")
                        End If
                        CommonFunctions.Data.DisposeDataReader(drStrategy)
                        If strategy.ToUpper = "CONTINGENCY PLAN" And acceptance.ToUpper = "ACTIVE" Then
                        Else
                            If Args.SelectedSubTagID = CommonFunction.Constants.APP_SUB_TAG_P12PROJECT_RISKS_CONTINEGENCY_PLAN Then
                                Args.SelectedSubTagID = 20015
                                Args.Information = ""
                            End If
                            Cancel = True
                        End If

                    Case CommonFunction.Constants.APP_SUB_TAG_P12PROJECT_RISKS_MITIGATION_PLAN
                        Dim strategy As String
                        Dim riskresponse As String
                        Dim acceptance As String
                        Dim drStrategy As IDataReader
                        Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                        Dim strSQL As String = "usp_Sel_tbl_PM_Risks " + intProjectID.ToString + "," + PrimaryKey
                        drStrategy = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        If drStrategy.Read Then
                            strategy = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drStrategy("CustomFieldText2"), ""), "")
                            riskresponse = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drStrategy("CustomFieldText1"), ""), "")
                            acceptance = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drStrategy("CustomFieldText5"), ""), "")
                        End If
                        CommonFunctions.Data.DisposeDataReader(drStrategy)
                        If strategy.ToUpper = "MITIGATION PLAN" Then
                        Else
                            If Args.SelectedSubTagID = CommonFunction.Constants.APP_SUB_TAG_P12PROJECT_RISKS_MITIGATION_PLAN Then
                                Args.SelectedSubTagID = 20019
                                Args.Information = ""
                            End If
                            Cancel = True
                        End If
                        'End of addition by ShraddhaM
                End Select
            End Sub
            ' Code added by SwapnilR on 12th Oct 2006
            ' Purpose : Integrated CORE patch and code for the sub-tag access through task delegation
            '           w.r.t. IssueID #7105
            Public Shared Function BeforeCheck_IsSubTagSectionAccessible(ByRef Cancel As Boolean, ByVal WhizGlobal As WebPages.Template.IGlobal) As Boolean
                Cancel = False
                BeforeCheck_IsSubTagSectionAccessible = False
                'Write Code here to override the system logic to check Is Sub Tag Accessible.
                Dim strSQLForSubTag As String = "usp_sel_Tbl_UI_SubTagMaster_IsSubTagAccessible " + WhizGlobal.TagID.ToString + "," + CommonFunction.General.CheckIsNothing(WhizGlobal.RoleID.ToString, "NULL") + "," + CommonFunction.General.CheckIsNothing(WhizGlobal.UserID.ToString, "NULL") + "," + CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID.ToString, "NULL")
                Dim blnIsSinlgeSubTagAccessible As Boolean
                BeforeCheck_IsSubTagSectionAccessible = Convert.ToBoolean(CommonFunction.Data.GetDataScalar(strSQLForSubTag, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                'After that, set Cancel = True to cancel the system check and also return value of IsSubTagSectionAccessible as True/False
            End Function
            ' End of code addition by SwapnilR on 12th Oct 2006
        End Class
    End Namespace
End Namespace