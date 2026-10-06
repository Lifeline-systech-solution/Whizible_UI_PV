Imports ProjectByNet
Namespace CommonEngine
    Namespace General
        Public Class cPageSpecificBehavior
            '=====================================================================
            ' Class	Name	        :	cPageSpecificBehavior
            ' Purpose				:	This class is used for implementing the 
            '                           page specific behavior
            ' Description			:	Will be used by the customisation team
            ' Assumptions			:	None
            ' Dependencies			:	None
            ' Author				:	AshishR, UmeshJ
            ' Created				:	September 01, 2003
            ' Revisions				:	
            '=====================================================================

            Public Shared Shadows Sub GetPageSpecificGlobalObject(ByRef objGlobal As WebPages.Template.IGlobal)
                '=====================================================================
                ' Procedure Name        :	GetPageSpecificGlobalObject
                ' Purpose               :	Modify and Get Page Specific Global Object
                ' Description           :	Same as above
                ' Parameters Passed     :	objGlobal - global object
                ' Parameters Affected   :	objGlobal - global object
                ' Returns               :	None
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	November 03, 2003
                ' Revisions             :
                '=====================================================================
                Select Case objGlobal.TagID
                    Case CommonFunction.Constants.TAG_LIST_OF_PROJECTS
                        objGlobal.TagID = CommonFunction.Constants.TAG_PROJECT_INFORMATION
                End Select
            End Sub


            Public Shared Shadows Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
                '=====================================================================
                ' Procedure Name        :	GetPageSpecificFilters
                ' Purpose               :	Get Page Specific Filters
                ' Description           :	Same as above
                ' Parameters Passed     :	objGlobal - global object
                ' Parameters Affected   :	None
                ' Returns               :	Filter
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	November 26, 2003
                ' Revisions             :
                '=====================================================================
                If objGlobal.ParentTagID = 0 Then
                    Select Case objGlobal.TagID
                        'integrated by harshada d for SP7 for issue id 3763
                        'Integrated By PradeepD For SP3 
                        Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEMASTER

                            'If the ADMIN role (Role ID = 7), then do NOT filter out the records, 

                            'else, for the other roles, filter out the records on ReportingTo field.

                            'Modified by PrashantSJ on 12 july 2005 for IssueID-19700

                            Dim m_intResourceID As Integer

                            Dim strSQLEmpId As String

                            strSQLEmpId = "Select EmployeeId from tbl_PM_Employee_ResourceFullControlUsers where EmployeeId=" & objGlobal.UserID

                            m_intResourceID = CType(CommonFunctions.Data.GetDataScalar(strSQLEmpId, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)

                            ' If CType(CommonFunction.General.CheckIsNothing(objGlobal.RoleID, "0").ToString(), Integer) <> 7 Then

                            'If CType(CommonFunction.General.CheckIsNothing(m_intResourceID, "0").ToString(), Integer) And (CType(CommonFunction.General.CheckIsNothing(objGlobal.RoleID, "0").ToString(), Integer) <> 7) Then

                            If CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(m_intResourceID, "0"), "0").ToString, Integer) = 0 And (CType(CommonFunction.General.CheckIsNothing(objGlobal.RoleID, "0").ToString(), Integer) <> 7) Then

                                'Modification Ends on 12 july 2005 for IssueId-19700

                                GetPageSpecificFilters = " AND ReportingTo = " + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString()

                            End If

                            'End of addition - ShamkantD on 20 Jun 2005 - for Issue ID 19433

                            'Added by PrashantSJ on 11 july 2005 - for Issue ID 19700

                        Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS

                            Dim m_intResourceID As Integer

                            Dim strSQLEmpId As String

                            strSQLEmpId = "Select EmployeeId from tbl_PM_Employee_ResourceFullControlUsers where EmployeeId=" & objGlobal.UserID

                            m_intResourceID = CType(CommonFunctions.Data.GetDataScalar(strSQLEmpId, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)

                            'If the ADMIN role (Role ID = 7), then do NOT filter out the records, 

                            'else, for the other roles, filter out the records on ReportingTo field.

                            ' If CType(CommonFunction.General.CheckIsNothing(objGlobal.RoleID, "0").ToString(), Integer) <> 7 Then

                            If CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(m_intResourceID, "0"), "0").ToString, Integer) = 0 And (CType(CommonFunction.General.CheckIsNothing(objGlobal.RoleID, "0").ToString(), Integer) <> 7) Then

                                GetPageSpecificFilters = " AND ReportingTo = " + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString()

                            End If

                            'End of addition - PrashantSJ on 11 july 2005 - for Issue ID 19700
                            'END Integrated By PradeepD For SP3 
                            'Added by PrashantSJ on 11 july 2005 - for Issue ID 19700
                            'end of integration by harshada d for SP7 for issue id 3763

                            'ADDED BY VIVEKP ON 26 SEP 2005 FOR WHIZIBLESEM SP4
                        Case CommonFunction.Constants.APP_TAG_SQERT_LOCK

                            Dim drSQRT As IDataReader
                            Dim m_strPtojectIDs As String = ""
                            GetPageSpecificFilters = ""

                            drSQRT = CommonFunctions.Data.GetDataReader("usp_Sel_Project_For_DA_Active_InActive_Projects " + HttpContext.Current.Session("intUserID").ToString + "", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            While drSQRT.Read
                                m_strPtojectIDs = m_strPtojectIDs + drSQRT.Item("ProjectID").ToString + ","
                            End While

                            If m_strPtojectIDs <> "" Then
                                m_strPtojectIDs = m_strPtojectIDs + "0"
                                GetPageSpecificFilters += " AND ProjectID IN(" + m_strPtojectIDs + ")"
                            End If
                            CommonFunctions.Data.DisposeDataReader(drSQRT)
                            'END OF ADDITION BY VIVEKP

                        Case CommonFunction.Constants.TAG_PROJECT_INFORMATION
                            'Apply Role Access Filter for Project List
                            GetPageSpecificFilters = ""
                            Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
                            If strFilter <> "" Then
                                GetPageSpecificFilters += " AND " + strFilter
                            End If

                            ''##### Added By AmitD for Project Listing - Added Filters For LocationID and BusinessGroupID of Logged in User
                            'Dim drGetRoleLevelInformation As IDataReader
                            'Dim strSQL As String
                            'Dim strBusinessGroupID As String
                            'Dim strLocationID As String
                            'Dim strRoleLevel As String

                            'strSQL = "usp_Sel_GetRoleLevelInformation " + CType(HttpContext.Current.Session("intUserID"), String)
                            'drGetRoleLevelInformation = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            'If drGetRoleLevelInformation.Read Then
                            '    strBusinessGroupID = CType(CommonFunctions.Data.CheckIsDBNull(drGetRoleLevelInformation("BusinessGroupID"), "0"), String)
                            '    strLocationID = CType(CommonFunctions.Data.CheckIsDBNull(drGetRoleLevelInformation("LocationID"), "0"), String)
                            '    strRoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(drGetRoleLevelInformation("Level"), "0"), String)
                            'End If

                            'CommonFunctions.Data.DisposeDataReader(drGetRoleLevelInformation)

                            'If strRoleLevel = "2" Or strRoleLevel = "3" Then
                            '    GetPageSpecificFilters += " AND " + "BusinessGroupID = " + CType(strBusinessGroupID, String) + " AND " + "LocationID = " + CType(strLocationID, String)
                            'End If
                            '##### End Addition 

                            Exit Function
                        Case CommonFunction.Constants.APP_TAG_CONFIG_TYPE_SECURITY
                            Dim objUICtrlValue() As CommonEngines.HashTables.UITagDefaultFilters
                            Dim intLength As Integer
                            Dim intIndex As Integer
                            GetPageSpecificFilters = ""
                            'Create object of Default Filter hash table
                            objUICtrlValue = CommonEngines.HashTables.GetHashTableObject.GetHashTableDefaultFiltersObject(CType(objGlobal.TagID, Long))
                            'If the object is nothing then exit
                            If objUICtrlValue Is Nothing Then Return ""
                            intLength = objUICtrlValue.Length - 1
                            For intIndex = 0 To intLength
                                'some default value is defined for the control
                                If objUICtrlValue(intIndex).IsQueryStringParameter = False Then
                                    If CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).SessionVariable) <> "" Then
                                        'Get value from the session variable 
                                        GetPageSpecificFilters += " AND " + CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).FieldName) + "='" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session(CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).SessionVariable))).ToString) + "'"
                                    End If
                                ElseIf CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).FieldName).ToUpper = "ROLE" Then
                                    'Do not apply query string parameter for Role
                                Else
                                    'Get the Filter Parameter value from the Query String
                                    GetPageSpecificFilters += " AND " + CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).FieldName) + "='" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request(CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).FieldName)).ToString)) + "'"
                                End If
                            Next
                            'Destroy the object
                            objUICtrlValue = Nothing
                            Exit Function
                            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                            'Added By NileshD on 17 Nov. 2004
                        Case CommonFunction.Constants.TAG_SYSTEM_POOL_LINKS
                            Dim objUICtrlValue() As CommonEngines.HashTables.UITagDefaultFilters
                            Dim intLength As Integer
                            Dim intIndex As Integer
                            GetPageSpecificFilters = ""
                            'Create object of Default Filter hash table
                            objUICtrlValue = CommonEngines.HashTables.GetHashTableObject.GetHashTableDefaultFiltersObject(CType(objGlobal.TagID, Long))
                            'If the object is nothing then exit
                            If objUICtrlValue Is Nothing Then Return ""
                            intLength = objUICtrlValue.Length - 1
                            For intIndex = 0 To intLength
                                'some default value is defined for the control
                                If objUICtrlValue(intIndex).FieldName.ToUpper <> "TAG" And objUICtrlValue(intIndex).FieldName.ToUpper <> "PARENTTAG" Then
                                    'Get the Filter Parameter value from the Query String
                                    GetPageSpecificFilters += " AND " + CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).FieldName) + "='" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request(CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).FieldName)).ToString)) + "'"
                                End If
                            Next
                            'Destroy the object
                            objUICtrlValue = Nothing
                            Exit Function
                            'End OF Addition - IssueID : 672 - Whiz2.0 Integration

                            ''Added by Dhanashri S on 29 Oct 2015

                            'With Ref No : WAF3_GEN_3
                            ' By : SumitS On 15 May 2006
                            ' Where Condition for TENANT & SubTENANT
                        Case CommonFunctions.Constants.TAG_TENANTS
                            GetPageSpecificFilters += " AND TENANTID = SubTENANTID "
                        Case CommonFunctions.Constants.TAG_SUB_TENANTS
                            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("TENANTID")) = "" Then
                                GetPageSpecificFilters += " AND 1 = 2 "
                            Else
                                GetPageSpecificFilters += " AND TENANTID = '" + HttpContext.Current.Session("TENANTID").ToString + "'"
                                GetPageSpecificFilters += " AND TENANTID <> SubTENANTID "
                            End If
                            ' End of Addition : SumitS
                            '--------------------------------------------------------------------------------------------------------------------------------------
                            'Added By Vinay B And Shrikant B On 26 Sep 2008 For WAF_GEN_17
                            'Case CommonFunctions.Constants.TAG_PAGELIST

                            '    Dim objUICtrlValue() As CommonEngines.HashTables.UITagDefaultFilters
                            '    Dim intLength As Integer
                            '    Dim intIndex As Integer
                            '    GetPageSpecificFilters = ""
                            '    'Create object of Default Filter hash table
                            '    objUICtrlValue = CommonEngines.HashTables.GetHashTableObject.GetHashTableDefaultFiltersObject(CType(objGlobal.TagID, Long))
                            '    'If the object is nothing then exit
                            '    If objUICtrlValue Is Nothing Then Return ""
                            '    intLength = objUICtrlValue.Length - 1
                            '    For intIndex = 0 To intLength
                            '        If objUICtrlValue(intIndex).ApplyDataFiltering Then
                            '            'some default value is defined for the control
                            '            If objUICtrlValue(intIndex).IsQueryStringParameter = False Then
                            '                If CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).SessionVariable) <> "" Then
                            '                    'Get value from the session variable 
                            '                    GetPageSpecificFilters += " AND " + CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).FieldName) + "='" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session(CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).SessionVariable))).ToString) + "'"
                            '                End If
                            '            Else
                            '                'Get the Filter Parameter value from the Query String
                            '                GetPageSpecificFilters += " AND " + CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).FieldName) + "='" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request(CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).FieldName)).ToString)) + "'"
                            '            End If
                            '        End If
                            '    Next
                            '    'Destroy the object
                            '    objUICtrlValue = Nothing

                            '    GetPageSpecificFilters += " AND (LCID = 0 OR LCID = " + objGlobal.LCID.ToString + ")"
                            '    'Addition End By Vinay B And Shrikant B On 26 Sep 2008 For WAF_GEN_17
                            '    '--------------------------------------------------------------------------------------------------------------------------------------
                        Case CommonFunctions.Constants.MASTER_TAG_TENANT_USER
                            GetPageSpecificFilters += " AND IsTENANT = 1 "
                        Case CommonFunctions.Constants.TAG_TENANT_USER_SELECTION
                            GetPageSpecificFilters += " AND tbl_PM_Employee.IsTENANT = 1 AND " + _
                                        " tbl_PM_Employee.EmployeeID NOT IN (SELECT EmployeeID " + _
                                                                           " From tbl_PM_Login " + _
                                                                           " WHERE TENANTID = SubTENANTID ) "

                            ''End of Addition by Dhanashri S on 29 Oct 2015

                            ''Added by PrashantSJ on 21st June 2007 For WhizibleSEM 7.0
                            ''Purpose: For this filter now we are going to use multiple Person Responsible for invoice generation and Approver
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_GENERATION
                            GetPageSpecificFilters += " AND ProjectID IN (SELECT ProjectID FROM tbl_PM_InvoiceGenerators  WHERE  ISNULL(GeneratorID,0)= " + HttpContext.Current.Session("intUserID").ToString + ")"
                        Case CommonFunction.Constants.APP_TAG_RFI_APPROVAL
                            GetPageSpecificFilters += " AND ProjectID IN (SELECT ProjectID  FROM  tbl_PM_IRApprovers WHERE  ISNULL(ApproverID,0)=" + HttpContext.Current.Session("intUserID").ToString + ")"
                            ''End of addition by PrashantSJ on 21st June 2007 For WhizibleSEM 7.0
                            'Added By NileshD on 6 August 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_DETAIL_LIST, CommonFunction.Constants.APP_TAG_RFI_SENDINVOICEMAILS
                            Dim drLevel As IDataReader
                            Dim strSQL As String
                            Dim strLevel As String
                            'Get the user's level who is accesing this page
                            strSQL = "usp_Sel_GetRFIAuthorizationLevel " + HttpContext.Current.Session("intUserID").ToString + ", " + HttpContext.Current.Session("intPostID").ToString
                            drLevel = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If drLevel.Read Then
                                strLevel = drLevel("UserType").ToString
                                'Depend on level apply filters.
                                Select Case strLevel.ToUpper
                                    Case "ACCOUNTS"
                                        ''Added by PrashantSJ on 21st June 2007 For WhizibleSEM 7.0
                                        ''Purpose: For this filter now we are going to use different table for Person Responsible for invoice generation
                                        'GetPageSpecificFilters += " AND ProjectID in ( SELECT ProjectID FROM tbl_PM_Project WHERE [Over] = 0 AND TimeSheetAuthenticatorID = " + HttpContext.Current.Session("intUserID").ToString + ")"
                                        GetPageSpecificFilters += " AND ProjectID in (SELECT PR.ProjectID  FROM tbl_PM_Project PR LEFT JOIN tbl_PM_InvoiceGenerators IRG ON PR.ProjectID=IRG.ProjectID WHERE PR.[Over] = 0 AND ISNULL(IRG.GeneratorID,0)= " + HttpContext.Current.Session("intUserID").ToString + ")"
                                        ''End of addition by PrashantSJ on 21st June 2007
                                    Case "COMPANYHEAD"
                                        GetPageSpecificFilters += " AND ProjectID in ( SELECT ProjectID FROM tbl_PM_CompanyMaster CMPY INNER JOIN tbl_PM_Project PRJ ON CMPY.CompanyID = PRJ.CompanyID	WHERE PRJ.[Over] = 0 AND COOID = " + HttpContext.Current.Session("intUserID").ToString + ")"
                                    Case "APPROVER"
                                        ''Added by PrashantSJ on 21st June 2007 For WhizibleSEM 7.0
                                        ''Purpose: For this filter now we are going to use different table for Person Responsible for IR Approver
                                        'GetPageSpecificFilters += " AND ProjectID in ( SELECT ProjectID FROM tbl_PM_Project WHERE [Over] = 0 AND RFIApproverID = " + HttpContext.Current.Session("intUserID").ToString + ")"
                                        GetPageSpecificFilters += " AND ProjectID in (SELECT PR.ProjectID  FROM tbl_PM_Project PR LEFT JOIN tbl_PM_IRApprovers IRA ON PR.ProjectID=IRA.ProjectID WHERE PR.[Over] = 0 AND ISNULL(IRA.ApproverID,0)=" + HttpContext.Current.Session("intUserID").ToString + ")"
                                        ''End of addition by PrashantSJ on 21st June 2007
                                    Case "INITIATOR"
                                        GetPageSpecificFilters += " AND ProjectID in ( SELECT ProjectID FROM tbl_PM_ProjectEmployeeRole WHERE ActualEndDate IS NULL AND EmployeeID = " + HttpContext.Current.Session("intUserID").ToString + ")"
                                End Select
                            End If
                            drLevel.Close()
                            CommonFunction.Data.DisposeDataReader(drLevel)
                            'end of addition

                            'added by SachinR   on 15 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_ADD_PROCESS_TO_OU
                            Dim strOUPoolID As String
                            'here filter is applied to select only those processes which are not mapped woth the OU
                            strOUPoolID = HttpContext.Current.Request.QueryString("OUPoolID") + ""
                            If strOUPoolID = "" Then
                                strOUPoolID = HttpContext.Current.Request.Form("txtOUPoolID") + ""
                            End If
                            If strOUPoolID <> "" Then
                                GetPageSpecificFilters = " And ProcessID Not In (Select ParentProcessID From tbl_PRS_Process_Draft Where OUPoolID= " + strOUPoolID.Trim + ")"
                            End If
                            'addition end
                            'added by SachinR   on 17 Sep 2004

                            'Added by VivekP On 7 Jun 2005
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLES_SELECTION_LIST
                            Dim m_lngProjectId As Long
                            If HttpContext.Current.Request.QueryString("FromTimesheet") = "CreateTask" Then
                                m_lngProjectId = CType(HttpContext.Current.Request.QueryString("ProjectID"), Long)
                                'TempProjectId = CType(Request.QueryString("ProjectID"), Long)
                            ElseIf HttpContext.Current.Request.QueryString("FromWhere") = "IB" Or HttpContext.Current.Request("FromWhere") = "IB" Then
                                'm_lngProjectId = CType(HttpContext.Current.Session("IssueProject"), Long)
                                m_lngProjectId = CType(HttpContext.Current.Session("IssueProject"), Long)

                            Else
                                m_lngProjectId = CType(HttpContext.Current.Session("intProjectID"), Long)
                            End If
                            GetPageSpecificFilters = "  And ProjectID=" + CType(m_lngProjectId, String)
                            'End of addiiton On 7 Jun 2005 By VivekP
                            ''Added by Yogesh Jalamkar on 10-Jan-2016 Purpose:Allegrow Customization
                            ''If HttpContext.Current.Request.QueryString("FromWhere") = "PM" Or HttpContext.Current.Request.QueryString("FromWhere") = "IB" Or HttpContext.Current.Request.QueryString("FromWhere") = "QuickCreate1" Then
                            ''    m_lngProjectId = CType(HttpContext.Current.Session("intProjectID"), Long)
                            ''    Dim strCommercialDetails As String = ""
                            ''    Dim strSQL As String = "usp_Sel_tbl_PM_Project_CommercialDetails "
                            ''    strSQL += CType(m_lngProjectId, String)
                            ''    strCommercialDetails = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "")
                            ''    If (strCommercialDetails = "Fixed Bid") Then
                            ''        GetPageSpecificFilters &= " AND isnull(Status,'') <>'Closed' AND ISNULL(IsBillable,0) <> 1"
                            ''    End If
                            ''End If
                            ''End of addition by Yogesh Jalamkar on 10-Jan-2016 Purpose:Allegrow Customization
                        Case CommonFunction.Constants.APP_TAG_ADD_METRIC_TO_OU
                            Dim strOUPoolID As String
                            'here filter is applied to select only those metrics which are not mapped with the OU
                            strOUPoolID = HttpContext.Current.Request.QueryString("OUPoolID") + ""
                            If strOUPoolID = "" Then
                                strOUPoolID = HttpContext.Current.Request.Form("txtOUPoolID") + ""
                            End If
                            If strOUPoolID <> "" Then
                                GetPageSpecificFilters = " And MetricID Not In (Select ParentMetricID From tbl_PRS_MetricMaster Where OUPoolID= " + strOUPoolID.Trim + ")"
                            End If
                        Case CommonFunction.Constants.APP_TAG_ADD_PMI_TO_OU
                            Dim strOUPoolID As String
                            'here filter is applied to select only those PMIs which are not mapped with the OU
                            strOUPoolID = HttpContext.Current.Request.QueryString("OUPoolID") + ""
                            If strOUPoolID = "" Then
                                strOUPoolID = HttpContext.Current.Request.Form("txtOUPoolID") + ""
                            End If
                            If strOUPoolID <> "" Then
                                GetPageSpecificFilters += " And PMIID Not In (Select ParentPMIID From tbl_PRS_PMIMaster Where OUPoolID= " + strOUPoolID.Trim + ")"
                            End If
                            'addition end
                            'Added by ShamkantD on 17 Sep 2004 - for Select Cost Heads page (called from Project Costs)
                        Case CommonFunction.Constants.APP_TAG_TAB_SELECT_COST_HEADS
                            GetPageSpecificFilters = " AND CostHeadID NOT IN (SELECT DISTINCT CostHeadID FROM tbl_PM_WorkOrderCosts WHERE ProjectID = " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "").ToString & ")"
                            'End of addition - ShamkantD on 17 Sep 2004
                            '----------------------------------------------------------------------------------
                            'Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
                            'Added by GaneshG on 9 Jan 2006 - For Milestone Page
                        Case CommonFunction.Constants.APP_TAG_RFI_MILESTONE
                            GetPageSpecificFilters = " AND Customer = " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Customer"), "").ToString & " AND MilestoneID NOT IN (SELECT DISTINCT ISNULL(MilestoneID,0) FROM tbl_PM_RFI_Items WHERE RFIID =  " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RFIID"), "").ToString & ")"
                            'End of addition - GaneshG

                            'Added by GaneshG on 11 Jan 2006 - For RFI Deliverables Page
                        Case CommonFunction.Constants.APP_TAG_RFI_DELIVERABLES
                            GetPageSpecificFilters = " AND ProjectID = " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "").ToString & " AND ScheduleID NOT IN (SELECT DISTINCT ISNULL(DeliverableID,0) FROM tbl_PM_RFI_Items WHERE RFIID =  " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RFIID"), "").ToString & ")"
                            ''COMMENTED BY GANESHG -- Doesn't need to differentiate on project type.
                            ''Dim drProjectDetails As IDataReader
                            ''Dim strSQL As String
                            ''Dim strProjectORProduct As String
                            ''Dim strCustomerID As String
                            ''strSQL = "usp_sel_tbl_PM_Project_IsProjectORProduct " + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "").ToString
                            ''drProjectDetails = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            ''If drProjectDetails.Read Then
                            ''    strProjectORProduct = drProjectDetails("ProjectORProduct").ToString
                            ''    strCustomerID = drProjectDetails("CustomerID").ToString
                            ''    Select Case strProjectORProduct.ToUpper
                            ''        Case "PRODUCT"
                            ''            GetPageSpecificFilters = " AND ProjectID = " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "").ToString & " AND ScheduleID NOT IN (SELECT DISTINCT ISNULL(DeliverableID,0) FROM tbl_PM_RFI_Items WHERE RFIID =  " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RFIID"), "").ToString & ")"
                            ''        Case "PROJECT"
                            ''            GetPageSpecificFilters = " AND Customer = " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Customer"), "").ToString & " AND ScheduleID NOT IN (SELECT DISTINCT ISNULL(DeliverableID,0) FROM tbl_PM_RFI_Items WHERE RFIID =  " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RFIID"), "").ToString & ")"
                            ''    End Select
                            ''End If
                            ''drProjectDetails.Close()
                            ''CommonFunction.Data.DisposeDataReader(drProjectDetails)
                            'End of addition - GaneshG
                            ''END OF COMMENT BY GANESHG 

                            'End Integration by SavitaS on 13 Mar 2006
                            '----------------------------------------------------------------------------------
                            'Added by ShamkantD on 27 Sep 2004 
                        Case CommonFunction.Constants.APP_TAG_PROJECT_LISTING_FOR_APPROVALS
                            'Add filter for Approvers
                            Dim blnIsApprover As Boolean = False
                            Dim strQuery As String = ""
                            Dim drGetRoleLevelInformation As IDataReader
                            Dim strBusinessGroupID As String = ""
                            Dim strLocationID As String = ""
                            Dim strRoleLevel As String = ""
                            Dim blnIsNewWorkflowON As Boolean = False

                            'Get whether or not the logged in user is approver
                            strQuery = "usp_Sel_tbl_PM_Role_IsApprover " & _
                                CommonFunction.General.CheckIsNothing(objGlobal.UserID, "0").ToString()
                            blnIsApprover = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)

                            ''Get whether or not the current selected project is having old or new workflow.
                            'strQuery = "usp_Sel_IsStageProjectWorkflow " & _
                            '    CommonFunction.General.CheckIsNothing(objGlobal.ProjectID, "0").ToString()
                            'blnIsNewWorkflowON = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)


                            'Add filter for Approvers - the Approver will see the list of all 
                            'Projects in the Project Listing page that have been marked as 
                            '"Sent for Approval" (The projects for which The status of the 
                            'latest revision in tbl_PM_ProjectRevision table is "S").
                            If blnIsApprover = True Then
                                ''''' Commented by purvaj on 10 Aug 2009 To show old as well as new project approvals. Condition handled in SP.
                                '''''GetPageSpecificFilters = " AND BaselineStatus = 'S'"
                                ''''' ENd comment purvaj

                                'strQuery = "usp_Sel_GetRoleLevelInformation " + CType(HttpContext.Current.Session("intUserID"), String)
                                'drGetRoleLevelInformation = CommonFunction.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                'If drGetRoleLevelInformation.Read Then
                                '    strBusinessGroupID = CType(CommonFunctions.Data.CheckIsDBNull(drGetRoleLevelInformation("BusinessGroupID"), "0"), String)
                                '    strLocationID = CType(CommonFunctions.Data.CheckIsDBNull(drGetRoleLevelInformation("LocationID"), "0"), String)
                                '    strRoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(drGetRoleLevelInformation("Level"), "0"), String)
                                'End If

                                'CommonFunctions.Data.DisposeDataReader(drGetRoleLevelInformation)

                                strRoleLevel = objGlobal.RoleLevel.ToString
                                'Added By JyotiG
                                'Start
                                'Issue ID : 6189 (Closed) & 6190(Hold)
                                'GetPageSpecificFilters += " AND ProjectID in ( SELECT ProjectID FROM tbl_PM_Project WHERE isnull([Over],0) = 0 ) "
                                '--- Commented By purvaj on 11 Dec 2008 For whiziblesem 8.0
                                'GetPageSpecificFilters += " AND ProjectID in ( SELECT ProjectID FROM tbl_PM_Project WHERE isnull([Over],0) = 0 ) "
                                '--- End Comment Purvaj
                                '--- Added By purvaj on 11 Dec 2008 For whiziblesem 8.0
                                '--- Project List returned from SP. Show approvals page displayed the projects following old as well as new workflow

                                Dim strProjectIDsList As String = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_ShowApproval_ProjectList " + HttpContext.Current.Session("intUserID").ToString + ",'" + CommonFunction.General.BuildQueryString(HttpContext.Current.Session("strUserName").ToString) + "'", True), ""), "")
                                If strProjectIDsList <> "" And strProjectIDsList <> "," Then
                                    GetPageSpecificFilters += " AND ProjectID in (" + strProjectIDsList + ")"
                                End If

                                'GetPageSpecificFilters += " AND ProjectStatusID not in(select projectstatusID from tbl_cnf_projectStatus where maptoProjectonHold=1) "
                                'End

                                If strRoleLevel = "2" Or strRoleLevel = "3" Then
                                    'Code added By VidyaJ - Approval listing should contain Accessible porojects logic
                                    'code integrated by TruptiK on 8/8/2006
                                    '-- Modified by purvaj on 11 Aug 2009, Show approvals page displayed the projects following old as well as new workflow
                                    '''GetPageSpecificFilters += " AND " + "((BusinessGroupID = " + CType(strBusinessGroupID, String) + " AND " + "LocationID = " + CType(strLocationID, String) + ")"
                                    'GetPageSpecificFilters += " AND " + "((BusinessGroupID = " + CType(strBusinessGroupID, String) + " AND " + "LocationID = " + CType(strLocationID, String) + ")"
                                    '--- End modification purvaj
                                    'Apply Role Access Filter for Project List

                                    ' Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
                                    Dim strFilter As String = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_Project_ForShowApproval " + HttpContext.Current.Session("intUserID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")



                                    If strFilter <> "" Then


                                        Dim strSessionUserName As String
                                        strSessionUserName = CType(HttpContext.Current.Session("strUserName"), String).Replace("'", "''")
                                        'Modified By JyotiG
                                        'Issue ID : 5687
                                        'GetPageSpecificFilters += " AND ( " + strFilter + ")"
                                        '-- Modified by purvaj on 11 Aug 2009, Show approvals page displayed the projects following old as well as new workflow
                                        ''''GetPageSpecificFilters += " OR " + strFilter + ")"
                                        If strProjectIDsList <> "" Then
                                            GetPageSpecificFilters += " OR ( ProjectID IN (" + strFilter + ")  AND Baselinestatus='S' AND SentForApprovalBy <> '" + strSessionUserName + "' AND isnull([Over],0) = 0 ) "
                                        Else
                                            GetPageSpecificFilters += " AND ( ProjectID IN (" + strFilter + ")  AND Baselinestatus='S' AND SentForApprovalBy <> '" + strSessionUserName + "' AND isnull([Over],0) = 0 ) "
                                        End If
                                        '--- End modification purvaj
                                    End If

                                End If

                                'End of integration by TruptiK on 8/8/2006


                                'Added by ShamkantD on 21 Nov 2004
                                'Do not show the projects that are sent to approval by the logged in person.
                                '--- Commented By purvaj on 11 Dec 2008 For whiziblesem 8.0
                                '--- Project List returned from SP. Show approvals page displayed the projects following old as well as new workflow
                                '''''GetPageSpecificFilters &= " AND SentForApprovalBy <> '" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(objGlobal.UserName, "")) & "'"
                                '--- End comment PurvaJ

                                ' Added By MahendraV On 18-Nov-2008 for WhizibleSEM8.0_Whiz3
                                ' Purpose : To display all the project on Show Approval page which are in logged person Inbox for new project workflow.
                                ' Start_MV_18-Nov-2008
                                '''''''''GetPageSpecificFilters &= " OR"
                                '''''''''GetPageSpecificFilters &= " f_tbl_PM_ProjectRevision.PROJECTID IN "
                                '''''''''GetPageSpecificFilters &= " ("
                                '''''''''GetPageSpecificFilters &= " Select tbl_PM_Project.ProjectID"
                                '''''''''GetPageSpecificFilters &= " from tbl_WF_Inbox "
                                '''''''''GetPageSpecificFilters &= " Join tbl_WF_Instance on tbl_WF_Instance.InstanceID = tbl_WF_Inbox.instanceID "
                                '''''''''GetPageSpecificFilters &= " Join tbl_IM_WorkflowInstance ON tbl_IM_WorkflowInstance.WorkflowInstanceID  = tbl_WF_Instance.PrimaryKeyValue "
                                '''''''''GetPageSpecificFilters &= " Join tbl_IM_RequestStage ON tbl_IM_RequestStage.StageID = tbl_WF_Instance.StageID "
                                '''''''''GetPageSpecificFilters &= " Join tbl_IM_ProjectNatureofDemand ON tbl_IM_ProjectNatureofDemand.ProjectNatureofDemandID = tbl_IM_WorkflowInstance.NatureOfDemandID "
                                '''''''''GetPageSpecificFilters &= " Join tbl_PM_Project ON tbl_PM_Project.ProjectID = tbl_IM_WorkflowInstance.PrimaryKeyValue "
                                '''''''''GetPageSpecificFilters &= " WHERE TagID = 32 And tbl_WF_Inbox.userid = '" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(objGlobal.UserID, "")) & "' "
                                '''''''''GetPageSpecificFilters &= " and AlertType='T'  AND tbl_PM_Project.[Over] = 0 "

                                '''''''''GetPageSpecificFilters &= " )"
                                ' End_MV_18-Nov-2008
                                'End of addition - ShamkantD on 21 Nov 2004
                                '--- Added By purvaj on 26 Nov 2008 for Whiziblesem 8.0
                                '--- To show new workflow projects also if IsProjectApprvoer is = 0
                            Else

                                ' Added By MahendraV On 18-Nov-2008 for WhizibleSEM8.0_Whiz3
                                ' Purpose : To display all the project on Show Approval page which are in logged person Inbox for new project workflow.
                                ' Start_MV_18-Nov-2008
                                GetPageSpecificFilters &= " AND"
                                GetPageSpecificFilters &= " f_tbl_PM_ProjectRevision.PROJECTID IN "
                                GetPageSpecificFilters &= " ("
                                GetPageSpecificFilters &= " Select tbl_PM_Project.ProjectID"
                                GetPageSpecificFilters &= " from tbl_WF_Inbox "
                                GetPageSpecificFilters &= " Join tbl_WF_Instance on tbl_WF_Instance.InstanceID = tbl_WF_Inbox.instanceID "
                                GetPageSpecificFilters &= " Join tbl_IM_WorkflowInstance ON tbl_IM_WorkflowInstance.WorkflowInstanceID  = tbl_WF_Instance.PrimaryKeyValue "
                                GetPageSpecificFilters &= " Join tbl_IM_RequestStage ON tbl_IM_RequestStage.StageID = tbl_WF_Instance.StageID "
                                GetPageSpecificFilters &= " Join tbl_IM_ProjectNatureofDemand ON tbl_IM_ProjectNatureofDemand.ProjectNatureofDemandID = tbl_IM_WorkflowInstance.NatureOfDemandID "
                                GetPageSpecificFilters &= " Join tbl_PM_Project ON tbl_PM_Project.ProjectID = tbl_IM_WorkflowInstance.PrimaryKeyValue "
                                GetPageSpecificFilters &= " WHERE TagID = 32 And tbl_WF_Inbox.userid = '" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(objGlobal.UserID, "")) & "' "
                                GetPageSpecificFilters &= " and AlertType='T'  AND tbl_PM_Project.[Over] = 0 "

                                GetPageSpecificFilters &= " )"
                                '--- end adition purvaj
                            End If

                            'End of addition - ShamkantD on 27 Sep 2004

                            'Added by ShamkantD on 29 Sep 2004 - added for Show Revisions page
                        Case CommonFunction.Constants.APP_TAG_TAB_BASELINE_REVISION
                            GetPageSpecificFilters = " AND ProjectId = " & (objGlobal.ProjectID).ToString()
                            'End of addition - ShamkantD on 29 Sep 2004

                            'Added by ShamkantD on 5 Oct 2004
                            'Added for Select Middle Level Resources for Business Group
                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_BUSINESS_GROUP
                            Dim strMasterPrimaryKeyValue As String = ""
                            strMasterPrimaryKeyValue = HttpContext.Current.Request.QueryString("MasterPrimaryKeyValue") + ""
                            If strMasterPrimaryKeyValue = "" Then
                                strMasterPrimaryKeyValue = HttpContext.Current.Request.Form("txtMasterPrimaryKeyValue") + ""
                            End If
                            If strMasterPrimaryKeyValue <> "" Then
                                GetPageSpecificFilters = " AND EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM tbl_CNF_BusinessGroups_MiddleLevelResources WHERE BusinessGroupID = " & strMasterPrimaryKeyValue.Trim & ")"

                                'Code commented by MrugajaB on 19th Jan 2006
                                'Purpose:An employee should be visible on middle level resource page in BU,DU,DU and OU so these filters are removed 
                                'Filter out (do not show) the employees that are selected for Organization Units
                                'GetPageSpecificFilters &= " AND EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM tbl_PM_Location_MiddleLevelResources)"

                                'Filter out (do not show) the employees that are selected for Delivery Units
                                'GetPageSpecificFilters &= " AND EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM tbl_PM_ResourcePool_MiddleLevelResources)"

                                'Filter out (do not show) the employees that are selected for Delivery Teams
                                'GetPageSpecificFilters &= " AND EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM tbl_PM_GroupMaster_MiddleLevelResources)"
                                'End Comment
                            End If
                            'End of addition - ShamkantD on 5 Oct 2004

                            'Added by ShamkantD on 6 Oct 2004
                            'Added for Select Middle Level Resources for Organization Unit
                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_ORGANIZATION_UNIT
                            Dim strMasterPrimaryKeyValue As String = ""
                            strMasterPrimaryKeyValue = HttpContext.Current.Request.QueryString("MasterPrimaryKeyValue") + ""
                            If strMasterPrimaryKeyValue = "" Then
                                strMasterPrimaryKeyValue = HttpContext.Current.Request.Form("txtMasterPrimaryKeyValue") + ""
                            End If
                            If strMasterPrimaryKeyValue <> "" Then
                                GetPageSpecificFilters = " AND EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM tbl_PM_Location_MiddleLevelResources WHERE LocationID = " & strMasterPrimaryKeyValue.Trim & ")"

                                'Code commented by MrugajaB on 19th Jan 2006
                                'Purpose:An employee should be visible on middle level resource page in BU,DU,DU and OU so these filters are removed 
                                'Added by ShamkantD on 16 Oct 2004
                                'Filter out (do not show) the employees that are selected for Business Groups
                                'GetPageSpecificFilters &= " AND EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM tbl_CNF_BusinessGroups_MiddleLevelResources)"

                                'Filter out (do not show) the employees that are selected for Delivery Units
                                'GetPageSpecificFilters &= " AND EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM tbl_PM_ResourcePool_MiddleLevelResources)"

                                'Filter out (do not show) the employees that are selected for Delivery Teams
                                'GetPageSpecificFilters &= " AND EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM tbl_PM_GroupMaster_MiddleLevelResources)"
                                'End of addition - ShamkantD on 16 Oct 2004
                                'End Comment
                            End If

                            'Added for Select Middle Level Resources for Delivery Unit
                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_DELIVERY_UNIT
                            Dim strMasterPrimaryKeyValue As String = ""
                            strMasterPrimaryKeyValue = HttpContext.Current.Request.QueryString("MasterPrimaryKeyValue") + ""
                            If strMasterPrimaryKeyValue = "" Then
                                strMasterPrimaryKeyValue = HttpContext.Current.Request.Form("txtMasterPrimaryKeyValue") + ""
                            End If
                            If strMasterPrimaryKeyValue <> "" Then
                                GetPageSpecificFilters = " AND EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM tbl_PM_ResourcePool_MiddleLevelResources WHERE ResourcePoolID = " & strMasterPrimaryKeyValue.Trim & ")"

                                'Code commented by MrugajaB on 19th Jan 2006
                                'Purpose:An employee should be visible on middle level resource page in BU,DU,DU and OU so these filters are removed 
                                'Added by ShamkantD on 16 Oct 2004
                                'Filter out (do not show) the employees that are selected for Business Groups
                                'GetPageSpecificFilters &= " AND EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM tbl_CNF_BusinessGroups_MiddleLevelResources)"

                                'Filter out (do not show) the employees that are selected for Organization Units
                                'GetPageSpecificFilters &= " AND EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM tbl_PM_Location_MiddleLevelResources)"

                                'Filter out (do not show) the employees that are selected for Delivery Teams
                                'GetPageSpecificFilters &= " AND EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM tbl_PM_GroupMaster_MiddleLevelResources)"
                                'End of addition - ShamkantD on 16 Oct 2004

                                'End Comment
                            End If

                            'Added for Select Middle Level Resources for Delivery Team
                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_DELIVERY_TEAM
                            Dim strMasterPrimaryKeyValue As String = ""
                            strMasterPrimaryKeyValue = HttpContext.Current.Request.QueryString("MasterPrimaryKeyValue") + ""
                            If strMasterPrimaryKeyValue = "" Then
                                strMasterPrimaryKeyValue = HttpContext.Current.Request.Form("txtMasterPrimaryKeyValue") + ""
                            End If
                            If strMasterPrimaryKeyValue <> "" Then
                                GetPageSpecificFilters = " AND EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM tbl_PM_GroupMaster_MiddleLevelResources WHERE GroupID = " & strMasterPrimaryKeyValue.Trim & ")"

                                'Code commented by MrugajaB on 19th Jan 2006
                                'Purpose:An employee should be visible on middle level resource page in BU,DU,DU and OU so these filters are removed 
                                'Added by ShamkantD on 16 Oct 2004
                                'Filter out (do not show) the employees that are selected for Business Groups
                                'GetPageSpecificFilters &= " AND EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM tbl_CNF_BusinessGroups_MiddleLevelResources)"

                                'Filter out (do not show) the employees that are selected for Organization Units
                                'GetPageSpecificFilters &= " AND EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM tbl_PM_Location_MiddleLevelResources)"

                                'Filter out (do not show) the employees that are selected for Delivery Units
                                'GetPageSpecificFilters &= " AND EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM tbl_PM_ResourcePool_MiddleLevelResources)"
                                'End of addition - ShamkantD on 16 Oct 2004
                            End If
                            'End of addition - ShamkantD on 6 Oct 2004
                            'End Comment

                        Case CommonFunction.Constants.APP_TAG_TASK_TYPE_MAINTENANCE_PM
                            GetPageSpecificFilters += " AND ProjectID=" + HttpContext.Current.Request.QueryString("ProjectID").ToString

                        Case CommonFunction.Constants.APP_TAG_RTS_SHOW_HISTORY_APPROVERS
                            GetPageSpecificFilters &= " AND ResourceTimesheetID = " + CType(HttpContext.Current.Request.QueryString("ResourceTimesheetID"), String) + " AND (ApproverID = " + CType(HttpContext.Current.Session("intUserID"), String) + " OR ApproverID IS NULL)"


                            'Added By MrugajaB on 8th Apr 2005 for displaying request approvers for projects business groupid and location 
                        Case CommonFunction.Constants.APP_TAG_REQUEST_APPROVERS

                            Dim strResourceAllocationLevel As String
                            Dim intBusinessGroupID As Integer
                            Dim intLocationID As Integer
                            Dim strPool As String
                            Dim intResourcePoolID As String

                            Dim strSQL As String

                            strSQL = "SELECT ResourceAllocationLevel from tbl_PM_CompanyInformation"
                            strResourceAllocationLevel = CType(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)

                            strSQL = "SELECT BusinessGroupID FROM tbl_PM_Project WHERE ProjectID=" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "").ToString
                            intBusinessGroupID = CType(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)


                            strSQL = "SELECT LocationID FROM tbl_PM_Project WHERE ProjectID=" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "").ToString
                            intLocationID = CType(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)

                            'Added by ArchanaN on 19 Jan 2008 
                            ' To dispaly Resource Pool Manager in the List
                            Dim strRequestID As String
                            strRequestID = HttpContext.Current.Request.QueryString("RequestID")
                            If strRequestID Is Nothing OrElse strRequestID = "" Then
                                strRequestID = HttpContext.Current.Request.Form("hidRequestID")
                            End If
                            strSQL = "SELECT Distinct RP.ResourcePoolID  FROM tbl_PM_ResourcePoolManagers RPM INNER JOIN tbl_PM_ResourceRequest RP ON RPM.ResourcePoolID = RP.ResourcePoolID  where  RP.RequestID =  " + CType(strRequestID, String)
                            intResourcePoolID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), String)
                            If Not intResourcePoolID Is Nothing Then
                                strPool = " OR ResourcePoolID = " + intResourcePoolID.ToString
                            Else
                                strPool = ""
                            End If
                            'Added by TruptiK on 13-Mar-09
                            'Purpose:-To Remove duplicate entry
                            Dim drApprover As IDataReader
                            Dim ApproverID As String
                            If Not intResourcePoolID Is Nothing Then
                                drApprover = CommonFunction.Data.GetDataReader("usp_selL_ResourceRequest_Approvers '" + strResourceAllocationLevel + "'," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "").ToString + "," + intResourcePoolID.ToString, True)
                            Else
                                drApprover = CommonFunction.Data.GetDataReader("usp_selL_ResourceRequest_Approvers '" + strResourceAllocationLevel + "'," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "").ToString, True)
                            End If
                            If drApprover.Read Then
                                ApproverID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(drApprover("ApproverID"), ""), ""), String)
                            End If
                            CommonFunction.Data.DisposeDataReader(drApprover)
                            If ApproverID = "" Then
                                GetPageSpecificFilters &= " AND EmployeeID in (0)"
                            Else
                                GetPageSpecificFilters &= " AND EmployeeID in (" & ApproverID & ")"
                            End If

                            'End of addition by TruptiK on 13-Mar-09
                            'End by ArchanaN
                            'Commented by TruptiK on 13-Mar-09
                            'Purpose:-To Remove duplicate entry
                            'If strResourceAllocationLevel <> "Corporate" Then
                            '    GetPageSpecificFilters &= " AND ResourceAllocationLevel='" & strResourceAllocationLevel & "' AND BusinessGroupID = " & intBusinessGroupID & " AND LocationID= " & intLocationID & strPool

                            'Else
                            '    GetPageSpecificFilters &= " AND ResourceAllocationLevel='" & strResourceAllocationLevel & "' AND BusinessGroupID IS NULL AND LocationID IS NULL" & strPool
                            'End If
                            'End of commented by TruptiK

                            'End Addition
                            'Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888
                            'Check whether request came from Onsite Resource Timesheet
                           
                        Case CommonFunction.Constants.APP_TAG_RTS_SHOW_HISTORY_EMPLOYEE
                            'Commented and Modified By JyotiG
                            'Start_JG_11135_09-Apr-2007
                            'If HttpContext.Current.Request.QueryString("FromWhere") = "Proxy" Then
                            If HttpContext.Current.Request("FromWhere") = "Proxy" Or HttpContext.Current.Request.Form("FromWhere") = "Proxy" Then
                                'End_JG_11135_09-Apr-2007
                                GetPageSpecificFilters &= " AND EmployeeID = " + CType(HttpContext.Current.Request("EmployeeID"), String) + " AND ResourceTimesheetID = " + CType(HttpContext.Current.Request("ResourceTimesheetID"), String)
                            Else
                                GetPageSpecificFilters &= " AND EmployeeID = " + CType(HttpContext.Current.Session("intUserID"), String) + " AND ResourceTimesheetID = " + CType(HttpContext.Current.Request("ResourceTimesheetID"), String)
                            End If
                            'Addition End by SantoshK on 20th March 2006




                        Case Else
                            Dim objUICtrlValue() As CommonEngines.HashTables.UITagDefaultFilters
                            Dim intLength As Integer
                            Dim intIndex As Integer
                            GetPageSpecificFilters = ""
                            'Create object of Default Filter hash table
                            objUICtrlValue = CommonEngines.HashTables.GetHashTableObject.GetHashTableDefaultFiltersObject(CType(objGlobal.TagID, Long))
                            'If the object is nothing then exit
                            If objUICtrlValue Is Nothing Then Return ""
                            intLength = objUICtrlValue.Length - 1
                            For intIndex = 0 To intLength
                                ''Added by Dhanashri S on 29 Oct 2015
                                If objUICtrlValue(intIndex).ApplyDataFiltering Then 'Added By NinadP on 22 Jan 2008, ReqID WAF3_PB_57  
                                    ''End of Addition by Dhanashri S on 29 Oct 2015
                                    'some default value is defined for the control
                                    If objUICtrlValue(intIndex).IsQueryStringParameter = False Then
                                        If CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).SessionVariable) <> "" Then
                                            'Get value from the session variable 
                                            GetPageSpecificFilters += " AND " + CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).FieldName) + "='" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session(CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).SessionVariable))).ToString) + "'"
                                        End If
                                    Else
                                        'Get the Filter Parameter value from the Query String
                                        ''Added by Dhanashri S on 24 Dec 2015
                                        'Commented And Added By Usha Pandit On 13.05.2020 For Issue regarding Process Measurement Indicator not returning metrics specific to selected PMI
                                        'If objGlobal.TagID <> CommonFunction.Constants.APP_TAG_METRICS_REPORT Then
                                        '    GetPageSpecificFilters += " AND " + CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).FieldName) + "='" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request(CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).FieldName)).ToString)) + "'"
                                        'End If
										
                                        'If objGlobal.TagID <> CommonFunction.Constants.APP_TAG_METRICS_REPORT Then
                                        GetPageSpecificFilters += " AND " + CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).FieldName) + "='" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request(CommonFunction.General.CheckIsNothing(objUICtrlValue(intIndex).FieldName)).ToString)) + "'"
                                        'End If
                                        'End Of Added By Usha Pandit On 13.05.2020 For Issue regarding Process Measurement Indicator not returning metrics specific to selected PMI
                                        ''End of Addition by Dhanshri S on 24 Dec 2015

                                    End If
                                        ''Added by Dhanashri S on 29 Oct 2015
                                    End If
                                ''End of Addition by Dhanashri S on 29 Oct 2015
                            Next
                            'Destroy the object
                            objUICtrlValue = Nothing





                    End Select
                Else
                    Select Case objGlobal.TagID

                    End Select
                End If
            End Function

            Public Shared Shadows Function GetCheckDuplicateSQL(ByVal strSQL As String, ByVal objGlobal As WebPages.Template.IGlobal) As String
                '=====================================================================
                ' Procedure Name        :	GetCheckDuplicateSQL
                ' Purpose               :	Get Check Duplicate SQL
                ' Description           :	Same as above
                ' Parameters Passed     :	SQL query for Check Duplicate Rule
                ' Parameters Affected   :	None.
                ' Returns               :	SQL query for Check Duplicate Rule with required where clause
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	December 24, 2003 
                ' Revisions             :
                '=====================================================================
                Dim strDuplidateSQL As String
                Dim intPosition As Integer

                If strSQL.Trim = "" Then Return ""
                GetCheckDuplicateSQL = strSQL
                'If objGlobal.FromWhere = "PM" Then  'And ((objGlobal.ParentTagID = 0 And objGlobal.TagID = CommonFunction.Constants.TAG_LIST_OF_PROJECTS) Or objGlobal.ParentTagID <> 0)

                Dim objPageFilter() As CommonEngines.HashTables.UITagDefaultFilters
                Dim intLength As Integer
                Dim intIndex As Integer
                'Create object of Default Filter hash table
                '###IssueID 9368 Begin
                If objGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    objPageFilter = CommonEngines.HashTables.GetHashTableObject.GetHashTableDefaultFiltersObject(CType(objGlobal.TagID, Long))
                Else
                    'For Sub Tag
                    objPageFilter = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableDefaultFiltersObject(CType(objGlobal.TagID, Long))
                End If
                'End

                'Code Added By VidyaJ on 18th Cot 2004
                'Remove Where clause for Organization Structure entities while checking duplicates
                'This is required as Organization Unit must be unique thro' out organization
                ' and not for the select Business Group.
                'Similar condition should be handled for Delivery Unit and Team
                If (objGlobal.TagID = CommonFunction.Constants.APP_TAG_TAB_ORGANIZATION_STRUCTURE_LOCATIONS Or _
                    objGlobal.TagID = CommonFunction.Constants.APP_TAG_DELIVERY_UNIT_ORGANIZATION_STRUCTURE Or _
                    objGlobal.TagID = CommonFunction.Constants.APP_TAG_TAB_DELIVERY_TEAM_ORGANIZATION_STRUCTURE) Then

                    strDuplidateSQL = strSQL
                    intPosition = strDuplidateSQL.IndexOf("WHERE")
                    If intPosition > 0 Then
                        strDuplidateSQL = strDuplidateSQL.Substring(0, intPosition)
                        GetCheckDuplicateSQL = strDuplidateSQL
                    End If

                Else

                    'If the object is nothing then exit
                    If objPageFilter Is Nothing Then Return GetCheckDuplicateSQL
                    intLength = objPageFilter.Length - 1
                    For intIndex = 0 To intLength
                        ''Added by Dhanashri S on 27 Oct 2015
                        If objPageFilter(intIndex).ApplyDataFiltering Then 'Added By NinadP on 11 Aug 2008, ReqID WAF3_PB_57  
                            ''End of Addition by Dhanashri S on 27 Oct 2015
                            If InStr(1, GetCheckDuplicateSQL, "WHERE", CompareMethod.Text) = 0 Then
                                If objPageFilter(intIndex).IsQueryStringParameter = False Then
                                    GetCheckDuplicateSQL += " WHERE " + CommonFunction.General.CheckIsNothing(objPageFilter(intIndex).FieldName) + "='" + CommonFunction.General.BuildQueryString(HttpContext.Current.Session(CommonFunction.General.CheckIsNothing(objPageFilter(intIndex).SessionVariable)).ToString) + "'"
                                Else
                                    GetCheckDuplicateSQL += " WHERE " + CommonFunction.General.CheckIsNothing(objPageFilter(intIndex).FieldName) + "='" + CommonFunction.General.BuildQueryString(HttpContext.Current.Request(CommonFunction.General.CheckIsNothing(objPageFilter(intIndex).FieldName)).ToString) + "'"
                                End If
                            Else
                                If objPageFilter(intIndex).IsQueryStringParameter = False Then
                                    GetCheckDuplicateSQL += " AND " + CommonFunction.General.CheckIsNothing(objPageFilter(intIndex).FieldName) + "='" + CommonFunction.General.BuildQueryString(HttpContext.Current.Session(CommonFunction.General.CheckIsNothing(objPageFilter(intIndex).SessionVariable)).ToString) + "'"
                                Else
                                    GetCheckDuplicateSQL += " AND " + CommonFunction.General.CheckIsNothing(objPageFilter(intIndex).FieldName) + "='" + CommonFunction.General.BuildQueryString(HttpContext.Current.Request(CommonFunction.General.CheckIsNothing(objPageFilter(intIndex).FieldName)).ToString) + "'"
                                End If
                            End If
                            ''Added by Dhanashri S on 27 Oct 2015
                        End If
                        ''End of Addition by Dhanashri S on 27 Oct 2015
                    Next
                End If

                'Destroy the object
                objPageFilter = Nothing
                'End If
            End Function

            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
            'Integrated by TruptiK on 2-Jun-2007
            Public Shared Shadows Function ExecuteDeletionSP(ByVal strDeletionSP As String, ByVal UniqueID As String, ByVal objGlobal As WebPages.Template.IGlobal, Optional ByVal lngSubTagId As Long = 0, Optional ByVal strConnectionString As String = "") As String
                'Public Shared Shadows Function ExecuteDeletionSP(ByVal strDeletionSP As String, ByVal UniqueID As String, ByVal objGlobal As WebPages.Template.IGlobal, Optional ByVal lngSubTagId As Long = 0) As String
                'End of addition by TruptiK

                'End Of Modifications - IssueID : 672

                '=====================================================================
                ' Procedure Name        :	ExecuteDeletionSP
                ' Purpose               :	Execute Deletion Stored Procedure
                ' Description           :	Same as above
                ' Parameters Passed     :	strDeletionSP - Deletion SP,lngUniqueID - Unique ID, 
                '                           objGlobal - global object
                ' Parameters Affected   :	None
                ' Returns               :	Result
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	November 26, 2003
                ' Revisions             :
                '=====================================================================
                'Execute the Deletion SP
                ExecuteDeletionSP = ""
                Dim objCmd As New SqlClient.SqlCommand
                Try
                    'objCmd.Connection = CommonFunction.Connection.GetSQLConnection(CommonFunctions.Application.ConnectionString)
                    objCmd.CommandText = strDeletionSP
                    objCmd.CommandType = CommandType.StoredProcedure

                    'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration

                    'objCmd.Parameters.Add(New SqlClient.SqlParameter("@intUniqueID", SqlDbType.Int, 40))
                    objCmd.Parameters.Add(New SqlClient.SqlParameter("@intUniqueID", SqlDbType.VarChar, 40)) 'SqlDbType.Int, 40
                    'objCmd.Parameters("@intUniqueID").Value = lngUniqueID
                    objCmd.Parameters("@intUniqueID").Value = UniqueID

                    'End Of Modifications - IssueID : 672


                    If objGlobal.FromWhere = "PM" And lngSubTagId = 0 Then
                        objCmd.Parameters.Add(New SqlClient.SqlParameter("@intProjectID", SqlDbType.Int, 40))
                        objCmd.Parameters("@intProjectID").Value = objGlobal.ProjectID
                    Else
                        ' added by harshada d on 15112005 for directions issue id 49 for removing the error while deleting the task type from global project
                        If objGlobal.ParentTagID = 0 Then
                            Select Case objGlobal.TagID
                                Case CommonFunction.Constants.APP_TAG_TASK_TYPE_MAINTENANCE_PM
                                    If objGlobal.FromWhere.ToUpper <> "PM" Then
                                        objCmd.Parameters.Add(New SqlClient.SqlParameter("@intProjectID", SqlDbType.Int, 40))
                                        objCmd.Parameters("@intProjectID").Value = HttpContext.Current.Request.QueryString("ProjectID").ToString
                                    End If
                            End Select
                            'end of addition by harshada d on 15112005 for directions issue id 49 for removing the error while deleting the task type from global project

                        End If
                    End If
                    objCmd.Parameters.Add(New SqlClient.SqlParameter("@strResult", SqlDbType.VarChar, 1000))
                    objCmd.Parameters("@strResult").Direction = ParameterDirection.Output
                    'Execute the Command and get the Command object
                    'objCmd = CommonFunction.Data.GetSQLCommandExecute(objCmd, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    ''Commented and Added by Dhanashri S on 29 Oct 2015
                    'objCmd = CommonFunction.Data.GetSQLCommandExecute(objCmd, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), strConnectionString)

                    'Req. ID. WAF3_GEN_2,  UJ_13-APR-06
                    If CommonFunctions.General.GetApplicationKeySetting("EnableReportingServices") = "Y" Then
                        Dim args As New CommonFunctions.Data.WAF_SQLCommand
                        args.AddToReportingSeriveQueue = True
                        objCmd = CommonFunction.Data.GetSQLCommandExecute(objCmd, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), args)
                        args = Nothing
                    Else
                        objCmd = CommonFunction.Data.GetSQLCommandExecute(objCmd, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), strConnectionString)
                    End If
                    ''End of Comment and addition by Dhanashri S on 29 Oct 2015

                    ExecuteDeletionSP = objCmd.Parameters("@strResult").Value.ToString()
                Catch ex As Exception
                    ex.Source = "ExecuteDeletionSP"
                    Throw ex
                Finally
                    'Destroy the object
                    objCmd.Dispose()
                    objCmd = Nothing
                End Try
            End Function

            Public Shared Shadows Function GetUIPageWhereClause(ByVal objGlobal As WebPages.Template.IGlobal, ByVal TableName As String, ByVal PrimaryKey As String, Optional ByRef PrimaryKeyValue As String = "") As String
                '=====================================================================
                ' Procedure Name        :	GetUIPageWhereClause
                ' Purpose               :	Get UI Page Where Clause
                ' Description           :	Same as above
                ' Parameters Passed     :	objGlobal - global object, TableName - Table Name
                '                           PrimaryKey , PrimaryKeyValue
                ' Parameters Affected   :	None
                ' Returns               :	Result
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	November 26, 2003
                ' Revisions             :
                '=====================================================================
                If (HttpContext.Current.Request("FromCL") = "1" And objGlobal.ParentTagID = 0) Or (HttpContext.Current.Request("SubTagFromCL") = "1" And objGlobal.ParentTagID <> 0) Then
                    'Common Page is accessed from CommonList
                    GetUIPageWhereClause = " WHERE " + PrimaryKey + "='" + CommonFunction.General.BuildQueryString(PrimaryKeyValue) + "'"
                Else
                    'if the Common Page is directly accessed then
                    If objGlobal.FromWhere = "PM" Then
                        If PrimaryKeyValue.Trim = "" And Not (objGlobal.TagID = CommonFunction.Constants.APP_TAG_CREATE_PROJECT) Then
                            'For Projects Module append then ProjectID
                            GetUIPageWhereClause = " WHERE ProjectID = '" + HttpContext.Current.Session("intProjectID").ToString + "'"
                            PrimaryKeyValue = HttpContext.Current.Session("intProjectID").ToString
                        Else
                            'Common Page is accessed from CommonList
                            GetUIPageWhereClause = " WHERE " + PrimaryKey + "='" + CommonFunction.General.BuildQueryString(PrimaryKeyValue) + "'"
                        End If
                    Else
                        If objGlobal.ParentTagID = 0 Then
                            Select Case objGlobal.TagID
                                Case CommonFunction.Constants.APP_TAG_MYPROFILE
                                    'For My Profile Page append then EmployeeID = Session User ID where clause
                                    PrimaryKeyValue = HttpContext.Current.Session("intUserID").ToString
                                    GetUIPageWhereClause = " WHERE EmployeeID = '" + PrimaryKeyValue + "'"
                                Case CommonFunction.Constants.APP_TAG_RESOURCEREQUEST_VIEW
                                    PrimaryKeyValue = HttpContext.Current.Request.QueryString("RequestID").ToString
                                    GetUIPageWhereClause = " WHERE RequestID = '" + PrimaryKeyValue + "'"
                                Case CommonFunction.Constants.APP_TAG_RESOURCE_REQUEST_ESCALATION
                                    PrimaryKeyValue = HttpContext.Current.Request.QueryString("RequestID").ToString
                                    GetUIPageWhereClause = " WHERE RequestID = '" + PrimaryKeyValue + "'"
                                    'Added by NileshD on 03/06/04
                                Case CommonFunction.Constants.APP_TAG_RESOURCE_REQUEST_ESCALATION_TO_OUPOOL
                                    PrimaryKeyValue = HttpContext.Current.Request.QueryString("RequestID").ToString
                                    GetUIPageWhereClause = " WHERE RequestID = '" + PrimaryKeyValue + "'"
                                    'End of addition
                                    'Added by JayavantK on 07/06/04
                                Case CommonFunction.Constants.APP_TAG_RESOURCE_REQUEST_ESCALATION_TO_GLOBALPOOL
                                    PrimaryKeyValue = HttpContext.Current.Request.QueryString("RequestID").ToString
                                    GetUIPageWhereClause = " WHERE RequestID = '" + PrimaryKeyValue + "'"
                                    'End of addition
                                Case CommonFunction.Constants.APP_TAG_RESOURCE_REQUEST_ESCALATION_TO_BGPOOL
                                    PrimaryKeyValue = HttpContext.Current.Request.QueryString("RequestID").ToString
                                    GetUIPageWhereClause = " WHERE RequestID = '" + PrimaryKeyValue + "'"

                                    'added by SachinR   on 07 Aug 2004
                                Case CommonFunction.Constants.APP_TAG_RFI_CUSTOMER_ADDRESSES
                                    Dim strCustomerID As String
                                    PrimaryKeyValue = HttpContext.Current.Request.QueryString("CustomerAddressID").ToString + ""
                                    strCustomerID = HttpContext.Current.Request.QueryString("CustomerID").ToString + ""
                                    GetUIPageWhereClause = " WHERE CustomerID=" + strCustomerID.Trim
                                    If PrimaryKeyValue <> "" Then
                                        GetUIPageWhereClause += " And CustomerAddressID=" + PrimaryKeyValue
                                    Else
                                        GetUIPageWhereClause += " And CustomerAddressID=0"
                                    End If
                                    'addition end
                                Case Else
                                    'Commented by UmeshJ on 25th July 2006
                                    'Purpose:Due to this code extra parameter was getting added in Where clause
                                    'Dim strSQL As String
                                    'strSQL = "SELECT " + PrimaryKey + " FROM " + TableName + " ORDER BY " + PrimaryKey
                                    'PrimaryKeyValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                                    'GetUIPageWhereClause = " WHERE " + PrimaryKey + "='" + CommonFunction.General.BuildQueryString(PrimaryKeyValue) + "'"
                                    'End If
                            End Select
                        Else
                            Select Case objGlobal.TagID
                                Case Else
                                    'Dim strSQL As String
                                    'strSQL = "SELECT " + PrimaryKey + " FROM " + TableName + " ORDER BY " + PrimaryKey
                                    'PrimaryKeyValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                                    'GetUIPageWhereClause = " WHERE " + PrimaryKey + "='" + CommonFunction.General.BuildQueryString(PrimaryKeyValue) + "'"
                            End Select
                        End If
                    End If
                End If
            End Function

            Public Shared Shadows Function IsSpecialCaseEditMode_UIPage(ByVal objGlobal As WebPages.Template.IGlobal) As Boolean
                '=====================================================================
                ' Procedure Name        :	IsSpecialCaseEditMode_UIPage
                ' Purpose               :	Check Is Special Case Edit Mode UI Page
                ' Description           :	Same as above
                ' Parameters Passed     :	objGlobal - global object
                ' Parameters Affected   :	None
                ' Returns               :	True - if special case else False
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	November 26, 2003
                ' Revisions             :
                '=====================================================================
                Select Case objGlobal.TagID
                    Case CommonFunction.Constants.TAG_PROJECT_INFORMATION
                        Return True
                    Case Else
                        Return False
                End Select
            End Function

            Public Shared Shadows Function GetUIPageURL(ByVal FunctionName As String, ByVal objGlobal As WebPages.Template.IGlobal, ByVal blnEditMode_UIPageOpenInWindow As Boolean, ByVal strUIPage As String) As String
                '=====================================================================
                ' Procedure Name        :	GetUIPageURL
                ' Purpose               :	Get UI Page URL
                ' Description           :	Same as above
                ' Parameters Passed     :	FunctionName , objGlobal - global object, 
                '                           TableName - Table Name,blnEditMode_UIPageOpenInWindow
                ' Parameters Affected   :	None
                ' Returns               :	Result
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	November 26, 2003
                ' Revisions             :
                '=====================================================================
                Select Case objGlobal.TagID
                    Case CommonFunction.Constants.TAG_PROJECT_INFORMATION

                        'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration

                        'Return "Navigation.aspx?subPage=CommonPage.aspx&<UNIQUE_ID>_PK&" + CommonFunction.Constants.DELIMITER_FOR_HYPERLINK_PARAMETERS + "ProjectName" + CommonFunction.Constants.DELIMITER_FOR_HYPERLINK_PARAMETERS
                        '____________Modified By UmeshJ on 01 November 2004_______________
                        'WHY:   Instead of retrieving the Project Name from the Query string get it from SQL
                        '       This will avoid restrictions those we need to apply for the special characters in the Project Name
                        'Return "Navigation.aspx?subPage=CommonPage.aspx&<UNIQUE_ID>&" + CommonFunction.Constants.DELIMITER_FOR_HYPERLINK_PARAMETERS + "ProjectName" + CommonFunction.Constants.DELIMITER_FOR_HYPERLINK_PARAMETERS
                        'Return "Navigation.aspx?subPage=CommonPage.aspx&<UNIQUE_ID>"

                        'Added and commented by ShraddhaM on 3 July for Gadget Functionality
                        ''Added and commented by PrashantSJ on 12th June 2009 Purpose: to call new Home page
                        'Dim drReader As IDataReader
                        'Dim SQL As String
                        'Dim IsActive As Boolean = True

                        'SQL = "usp_Sel_tbl_CNF_GadgetNodes_EmployeePreferences 27," + HttpContext.Current.Session("intUserID").ToString()
                        'drReader = CommonFunction.Data.GetDataReader(SQL, True)
                        'If drReader.Read Then
                        '    IsActive = CType(drReader("Active"), Boolean)
                        'End If
                        'If IsActive = True And HttpContext.Current.Session("LoginType").ToString <> "C" Then
                        '    Return "Navigation.aspx?subPage=Tab_Viewpage.aspx&<UNIQUE_ID>"
                        'Else
                        '    Return "Navigation.aspx?subPage=CommonPage.aspx&<UNIQUE_ID>"
                        'End If
                        Return "Navigation.aspx?subPage=../Home/Home.aspx&<UNIQUE_ID>"
                        ''End of comment and addition by PrashantSJ on 12th June 2009
                        'Ended by ShraddhaM

                        'Return "Navigation.aspx?subPage=CommonPage.aspx&<UNIQUE_ID>"

                        'End of modifications

                        'End Of Modifications - IssueID : 672

                    Case Else
                        If blnEditMode_UIPageOpenInWindow = True Then
                            'Integrated by MrugajaB on 11sept 2006 for Whiziblesem6.0 SP 7 (Security Purpose)
                            'Return "Javascript:" + FunctionName + "('<UNIQUE_ID>')"
                            Return "Javascript:" + FunctionName + "(&quot;<UNIQUE_ID>&quot;)" 'WAF3_PB_26 UJ 23 Aug 2006
                            'End Integration
                        Else
                            If InStr(1, strUIPage, "?", CompareMethod.Text) <> 0 Then
                                Return strUIPage + "&<UNIQUE_ID>"
                            Else
                                Return strUIPage + "?<UNIQUE_ID>"
                            End If
                        End If
                End Select
            End Function
            Public Shared Shadows Function FormatUIPageHrefTag(ByVal objGlobal As WebPages.Template.IGlobal) As String
                '=====================================================================
                ' Procedure Name        :	FormatUIPageHrefTag
                ' Purpose               :	Format UI Page Href Tag
                ' Description           :	Same as above
                ' Parameters Passed     :	objGlobal - global object, 
                ' Parameters Affected   :	None
                ' Returns               :	UI page Href Tag with any additional formatting 
                ' Assumptions           :	None.
                ' Dependencies          :	None.
                ' Author                :	UmeshJ
                ' Created               :	November 26, 2003
                ' Revisions             :
                '=====================================================================
                Select Case objGlobal.TagID
                    Case CommonFunction.Constants.TAG_PROJECT_INFORMATION
                        Return " Target=_top "
                    Case Else
                        Return ""
                End Select
            End Function
            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
            Public Shared Shadows Sub GetPageSpecificAccessRights(ByVal objGlobal As WebPages.Template.IGlobal, ByRef objAccess As WebPage.Templates.AccessRights)
                '=====================================================================
                ' Procedure Name        : GetPageSpecificAccessRights
                ' Purpose               : Get Page Specific Access Rights
                ' Description           : Same as above
                ' Parameters Passed     : objGlobal - global object, By Ref objAccess - Access Object
                ' Parameters Affected   : None
                ' Returns               : None 
                ' Assumptions           : None.
                ' Dependencies          : None.
                ' Author                : PrasannaP
                ' Created               : June 27, 2005
                ' Revisions             :
                ' Requirement ID        : AR_EV_01
                '=====================================================================
                Select Case objGlobal.TagID
                    'Integrated By SanaS on 25-Sep-2009
                    'Added BY NitinVs on 31-AUG-2009 
                    ' If workflow is off and ResourceAllocation is enabled then only show the add edit to ResourceAllocator only
                    Case CommonFunction.Constants.APP_TAG_RESOURCES
                        Dim intAllowResourceAllocation As Integer
                        Dim intEnableProjectResourceAllocation As Integer
                        Dim strRoleId As String = HttpContext.Current.Session("intPostID").ToString()
                        Dim strUserID As String = HttpContext.Current.Session("intUserID").ToString()
                        Dim ShowViewOnly As String = ""
                        If CommonFunction.Application.AllowResourceAllocation Then
                            intAllowResourceAllocation = 1
                        Else
                            intAllowResourceAllocation = 0
                        End If

                        If intAllowResourceAllocation = 0 Then
                            intEnableProjectResourceAllocation = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_IsProjectResourceAllocation " + objGlobal.ProjectID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                        Else
                            intEnableProjectResourceAllocation = 0
                        End If

                        If intAllowResourceAllocation = 0 And intEnableProjectResourceAllocation = 1 Then
                            ShowViewOnly = CommonFunction.Data.GetDataScalar("usp_SEL_EnableProjectResourceAllocation " + strUserID + "," + strRoleId, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            ' if Logged in resource is not  ResourceAllocator plot page in view mode.
                            If ShowViewOnly = "0" Then
                                If objAccess.Add = True Or objAccess.Edit = True Or objAccess.Delete = True Or objAccess.View = True Then
                                    objAccess.View = True
                                End If
                                objAccess.Add = False
                                objAccess.Edit = False
                                objAccess.Delete = False
                            End If
                        End If
                        'End addition By nitinVS on  31-AUG-2009 
                        'End Integration By SanaS on 25-Sep-2009
                    Case Else
                End Select
            End Sub
            'End Of Modifications - IssueID : 672
        End Class

    End Namespace
End Namespace
