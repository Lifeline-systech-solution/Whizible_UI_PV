Imports ProjectByNet
Namespace CommonEngine
    Namespace General
        Public Class CLCP_Events_Grid

            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
            'Added By SandeepA on 14 Nov,2005 for IssueID--676
            Public Shared m_intRoleAccess As Integer = 0
            'End of addition by SandepA on 14 Nov,2005 for IssueID--676
            'End Integration

            ''------------------------------------------------------------------------------------------
            ''Code added by RohiniK on 21 August 2006 for Role wise Access to All ISsues Tab in Issues Module  for Whiziblesem SP 7 Issue ID 5688 
            Public Shared m_strRole As String = ""
            ''End of Code addition by RohiniK on 21 August 2006 for Role wise Access to All ISsues Tab in Issues Module
            ''------------------------------------------------------------------------------------------
            ''Added by PrashantSJ on 6th June 2007 For WhiziblesEM 7.0 Build 3
            ''Purpose: To display Proper sr.no for TagID=2069 (RFI Checklist)
            Public Shared m_iRowCount As Integer = 0
            ''Enf of addition by PrashantSJ on 6th June 2007
            Public Shared m_Employee_Approver As String = ""
            'WAF3_PB_38 Issue Fix April 24, 2007 UmeshJ 2.0.08-SP7-WAF START
            Public Shared Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag

                    Select Case WhizGlobal.TagID

                        'Code Added By KapilK on 16-Jul-09 [RequesTID:21548 Helpdesk 'Show history' Sort by Date & Time displays inacurate]
                        Case CommonFunction.Constants.APP_TAG_SHOW_CRM_HISTORY
                            If Args.SortBy = "ModifiedDate" Then
                                Dim strSortOrder As String = ""
                                strSortOrder = Args.OrderClause
                                strSortOrder += ",ModifiedTime " + Args.SortOrder
                                Args.OrderClause = strSortOrder
                            End If

                            If Args.SortBy = "ModifiedTime" Then
                                Dim strSortOrder As String = ""
                                strSortOrder = "ModifiedDate " + Args.SortOrder
                                strSortOrder += "," + Args.OrderClause
                                Args.OrderClause = strSortOrder
                            End If
                            'End;Code Added By KapilK on 16-Jul-09 [RequesTID:21548 Helpdesk 'Show history' Sort by Date & Time displays inacurate]

                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_SUBTAG_CUSTOMER_SUPPORT
                            Dim strPeriod As String = ""
                            Dim strSQL As String = ""


                            strPeriod = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("IsFilter20507"))
                            If strPeriod = "" Then
                                strSQL = "SELECT TOP 1 FixedValue FROM tbl_UI_SubTag_EmployeeFilterSettings_FieldDetails WHERE SubTagID=" + CommonFunction.Constants.APP_SUBTAG_CUSTOMER_SUPPORT.ToString + " AND UPPER(ControlName)='ISFILTER' AND UserID=" + WhizGlobal.UserID.ToString + " AND LoginType='" + WhizGlobal.LoginType + "'"
                                strPeriod = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))), String)
                            End If

                            If strPeriod <> "" Then
                                Dim strFromDate As String = ""
                                Dim strToDate As String = ""
                                Dim drSupport As IDataReader

                                strSQL = "usp_Sel_CustomerSupport_DateFilter " + strPeriod
                                drSupport = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drSupport.Read Then
                                    strFromDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drSupport("FromDate"), ""), Date))
                                    strToDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drSupport("ToDate"), ""), Date))
                                End If

                                CommonFunction.Data.DisposeDataReader(drSupport)

                                Args.WhereClause = " 1=1 AND '" + strFromDate + "'<= SubmittedDate AND '" + strToDate + "' >=SubmittedDate "
                            End If
                    End Select
                End If
            End Sub
            'WAF3_PB_38 Issue Fix April 24, 2007 UmeshJ 2.0.08-SP7-WAF END

            Public Shared Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Cancel = False
                'This Event will occur before 
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag

                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_TAG_PROCESS_MEASUREMENT_INDICATOR_REPORT
                            Args.PrimaryColumn = "Name"
                        Case CommonFunction.Constants.APP_TAG_PROCESSES_REPORT
                            Args.PrimaryColumn = "ProcessName"
                        Case CommonFunction.Constants.APP_TAG_ACTIVITIES_REPORT
                            Args.PrimaryColumn = "Title"
                        Case CommonFunction.Constants.APP_TAG_ASSIGNED_TASK
                            Dim ActCols As String() = {"Work", "BaselineWork", "ActualWork"}
                            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                            'Dim SummFunc As EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions() = {EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions.Sum, _
                            '        EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions.Sum, _
                            '        EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions.Sum}
                            Dim SummFunc As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_SUM, CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_SUM, CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_SUM}
                            Dim SummFuncLevel As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_LEVEL_BOTH, CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_LEVEL_BOTH, CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_LEVEL_BOTH}

                            With Args
                                .SummaryFuncActualColumnArray = ActCols
                                .SummaryFuncNameArray = SummFunc
                                ' .SummaryFuncLevel = EventHandlers.WAF_Grid.WAF_InitializeGrid.Level.Both
                                .SummaryFuncLevel = SummFuncLevel
                                .SummaryGroupTitle = ""
                                .SummaryTotalTitle = ""
                                .SummaryGroupTR = "clsTRColumnHeader"
                                .SummaryTotalTR = "clsTRColumnHeader"
                            End With
                            'Set the Width
                            'Modified by ShraddhaM on Date 21 June,2006 for WhizibleSEM Issue ID.4168
                            Args.TableWidth = "99.9%"
                            'End Of Modifications - IssueID : 672
                        Case CommonFunction.Constants.APP_TAG_MODULES
                            Dim ActCols As String() = {"EstimatedEfforts"}
                            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                            'Dim SummFunc As EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions() = {EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions.Sum}
                            Dim SummFunc As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_SUM}
                            Dim SummFuncLevel As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_LEVEL_FOOTER}
                            With Args
                                .SummaryFuncActualColumnArray = ActCols
                                .SummaryFuncNameArray = SummFunc
                                ' .SummaryFuncLevel = EventHandlers.WAF_Grid.WAF_InitializeGrid.Level.Total
                                .SummaryFuncLevel = SummFuncLevel
                                .SummaryGroupTitle = ""
                                .SummaryTotalTitle = ""
                                .SummaryGroupTR = "clsTRColumnHeader"
                                .SummaryTotalTR = "clsTRColumnHeader"
                            End With
                            'End Of Modifications - IssueID : 672
                        Case CommonFunction.Constants.APP_TAG_COMPUTE_PMI
                            'For Compute PMI --Remove Delete Access
                            Args.Delete = False
                        Case CommonFunctions.Constants.TAG_ADVANCE_FILTERS
                            'Do not apply access rights for advance filters
                            Args.Delete = True
                        Case CommonFunction.Constants.APP_TAG_CUSTOM_PAGE_MAINTENANCE, CommonFunction.Constants.APP_TAG_SDLC_PROCESS
                            'For Custom Page Maintenance - remove delete access
                            Args.Delete = False
                        Case CommonFunction.Constants.APP_TAG_PARENT_TAG_MAINTENANCE
                            'For Parent Tag Maintenance - remove delete access
                            Args.Delete = False
                        Case CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT
                            'Set the Width
                            'Modified by ShraddhaM on Date 21 June,2006 for WhizibleSEM Issue ID.4168
                            Args.TableWidth = "99.9%"
                        Case CommonFunction.Constants.APP_TAG_RISKS
                            'Set the Width
                            'Modified by ShraddhaM on Date 21 June,2006 for WhizibleSEM Issue ID.4168
                            Args.TableWidth = "99.9%"
                            '-------------Added by PrakashR--------------
                        Case CommonFunction.Constants.APP_TAG_COMMERCIAL_CONTRACT_STATUS
                            'Remove delete access
                            Args.Delete = False
                        Case CommonFunction.Constants.APP_TAG_FIXED_BID_REVISION_HISTORY
                            Args.Delete = False
                            '----------------------End of Addition-------------------------
                            ''Added by PrashantSJ on 6th June 2007 For WhizibleSEM 7.0 Build 3
                            ''Purpose: To display proper sr.no. (i.e 1,2..etc)
                        Case CommonFunction.Constants.APP_TAG_RFI_CHECKLIST_VIEW
                            m_iRowCount = 0

                            ''End of addition by PrashantSJ on 6th June 2007 
                        Case CommonFunction.Constants.APP_TAG_BACKDATING_CONFIGURATION
                            Args.Delete = False
                            'added by SachinR   on 07 Jul 2004
                            'store the custom field ID in the hidden control to persist it
                        Case CommonFunction.Constants.APP_TAG_PROJECT_CUSTOM_FIELD_MAINTENANCE
                            Dim strUniqueID As String
                            strUniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("CustomFieldID"))
                            '***** code added by SandipL on 23 Nov 2005
                            'Purpose:- Preserve CustomFieldID 
                            If strUniqueID = "" Then
                                strUniqueID = CType(HttpContext.Current.Session("CustomFieldID"), String)
                            Else
                                HttpContext.Current.Session.Remove("CustomFieldID")
                                HttpContext.Current.Session.Add("CustomFieldID", strUniqueID)
                            End If
                            '***** End addition by SandipL on 23 Nov 2005

                            If CommonFunctions.General.CheckIsNothing(strUniqueID, "") <> "" Then
                                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                ''Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("CustomFieldID", "CustomFieldID", , , , strUniqueID.Trim, , , , , , True, , True)
                                Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("CustomFieldID", "CustomFieldID", , , , strUniqueID.Trim, , , , , , True, , True, EnableHTMLEncode:=True)
                            End If
                            'addition end

                            '***** Code added by SandipL on 19 Jan 2006
                        Case CommonFunction.Constants.APP_TAG_PROJECT_TASK_CUSTOM_FIELD_MAINTENANCE
                            Dim strUniqueID As String
                            strUniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("CustomFieldID"))
                            If strUniqueID = "" Then
                                strUniqueID = CType(HttpContext.Current.Session("CustomFieldID"), String)
                            Else
                                HttpContext.Current.Session.Remove("CustomFieldID")
                                HttpContext.Current.Session.Add("CustomFieldID", strUniqueID)
                            End If
                            If CommonFunctions.General.CheckIsNothing(strUniqueID, "") <> "" Then
                                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                ''Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("CustomFieldID", "CustomFieldID", , , , strUniqueID.Trim, , , , , , True, , True)
                                Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("CustomFieldID", "CustomFieldID", , , , strUniqueID.Trim, , , , , , True, , True, EnableHTMLEncode:=True)
                            End If
                            '***** End addition by SandipL on 19 Jan 2006

                            'Added by ShamkantD on 26th July 2004 - added to hide Delete column
                        Case CommonFunction.Constants.APP_TAG_CONFIG_COMMERICAL_CONTRACT_TYPE
                            Args.Delete = False
                            'End of addition - ShamkantD on 26th July 2004 
                            'Case CommonFunction.Constants.APP_TAG_RFI_INITIATOR
                            '    Dim ActCols As String() = {"EquivAmount"}
                            '    'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                            '    'Dim SummFunc As EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions() = {EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions.Sum}
                            '    Dim SummFunc As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_SUM}
                            '    Dim SummFuncLevel As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_LEVEL_FOOTER}

                            '    With Args
                            '        .SummaryFuncActualColumnArray = ActCols
                            '        .SummaryFuncNameArray = SummFunc
                            '        '.SummaryFuncLevel = EventHandlers.WAF_Grid.WAF_InitializeGrid.Level.Total
                            '        .SummaryFuncLevel = SummFuncLevel
                            '        .SummaryGroupTitle = ""
                            '        .SummaryTotalTitle = ""
                            '        .SummaryGroupTR = "clsTRColumnHeader"
                            '        .SummaryTotalTR = "clsTRColumnHeader"
                            '    End With
                            'End Of Modifications - IssueID : 672
                            'Added By NileshD on 9 August 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_APPROVAL
                            Dim ActCols As String() = {"EquivAmount"}
                            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                            'Dim SummFunc As EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions() = {EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions.Sum}
                            Dim SummFunc As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_SUM}
                            Dim SummFuncLevel As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_LEVEL_BOTH}
                            With Args
                                .SummaryFuncActualColumnArray = ActCols
                                .SummaryFuncNameArray = SummFunc
                                '.SummaryFuncLevel = EventHandlers.WAF_Grid.WAF_InitializeGrid.Level.Both
                                .SummaryFuncLevel = SummFuncLevel
                                .SummaryGroupTitle = ""
                                '.SummaryTotalTitle = "Total Amount"
                                .SummaryTotalTitle = ""
                                .SummaryGroupTR = "clsTRColumnHeader"
                                .SummaryTotalTR = "clsTRColumnHeader"
                            End With
                            'End Of Modifications - IssueID : 672
                            ''Added by PrashantSJ on 29th June 2007 For WhizibleSEM 7.0
                            ''Purpose: To Persist delete access
                        Case CommonFunction.Constants.APP_TAG_RFI_SENDINVOICEMAILS
                            Args.Delete = True
                            ''End of addition by PrashantSJ on 27th June 2007
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_DETAIL_LIST, CommonFunction.Constants.APP_TAG_RFI_SENDINVOICEMAILS
                            Dim ActCols As String() = {"EquivAmount"}
                            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                            'Dim SummFunc As EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions() = {EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions.Sum}
                            Dim SummFunc As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_SUM}
                            Dim SummFuncLevel As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_LEVEL_BOTH}
                            With Args
                                .SummaryFuncActualColumnArray = ActCols
                                .SummaryFuncNameArray = SummFunc
                                '.SummaryFuncLevel = EventHandlers.WAF_Grid.WAF_InitializeGrid.Level.Both
                                .SummaryFuncLevel = SummFuncLevel
                                .SummaryGroupTitle = ""
                                .SummaryTotalTitle = "Total Amount"
                                .SummaryGroupTR = "clsTRColumnHeader"
                                .SummaryTotalTR = "clsTRColumnHeader"
                            End With
                            'End Of Modifications - IssueID : 672
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_GENERATION
                            Dim ActCols As String() = {"EquivAmount"}
                            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                            'Dim SummFunc As EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions() = {EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions.Sum}
                            Dim SummFunc As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_SUM}
                            Dim SummFuncLevel As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_LEVEL_BOTH}

                            With Args
                                .SummaryFuncActualColumnArray = ActCols
                                .SummaryFuncNameArray = SummFunc
                                '.SummaryFuncLevel = EventHandlers.WAF_Grid.WAF_InitializeGrid.Level.Both
                                .SummaryFuncLevel = SummFuncLevel
                                .SummaryGroupTitle = ""
                                .SummaryTotalTitle = "Total Amount"
                                .SummaryGroupTR = "clsTRColumnHeader"
                                .SummaryTotalTR = "clsTRColumnHeader"
                            End With
                            'End Of Modifications - IssueID : 672
                            'End Of Addition
                        Case CommonFunctions.Constants.TAG_AUDIT_TRAIL
                            Args.Delete = False
                            Args.ApplySorting = False

                            '##### Cases Added For Resource Timesheet Flow On 10 AUG 2004
                        Case CommonFunction.Constants.APP_Tag_TIMESHEET_SHOW_REMARKS

                            '_____________________________________________________________________________________________________
                            '____________Added By AmitD on 5th Aug 2004  
                            'Set the column names for which total is to be calculated
                            Dim ActCols As String() = {"Duration"}
                            'Set the function as Sum
                            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                            'Dim SummFunc As EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions() = {EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions.Sum, EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions.Sum}
                            Dim SummFunc As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_SUM, CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_SUM}
                            Dim SummFuncLevel As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_LEVEL_BOTH, CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_LEVEL_BOTH}

                            Dim objTemplate As New WebPage.Templates.WhizTemplate
                            objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                            With Args
                                .SummaryFuncActualColumnArray = ActCols
                                .SummaryFuncNameArray = SummFunc
                                '.SummaryFuncLevel = EventHandlers.WAF_Grid.WAF_InitializeGrid.Level.Both
                                .SummaryFuncLevel = SummFuncLevel
                                .SummaryGroupTitle = "Total Work (hrs)"
                                'Add the caption 'Total' from the resource file for event handlers
                                .SummaryTotalTitle = "Total Work (hrs) for the Period"
                                .SummaryGroupTR = "clsTRColumnHeader"
                                ' .SummaryTotalTR = "clsTRSectionHeader"
                                .SummaryTotalTR = "clsTRColumnHeader"
                            End With
                            objTemplate = Nothing
                            'End Of Modifications - IssueID : 672

                        Case CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET
                            'For verify resource timesheet rename the delete column
                            If Args.CaptionForDeleteColumn = "Delete" Then
                                Args.CaptionForDeleteColumn = "Approve"
                                'Args.DeletionCheckboxName = "chkVerify"
                            End If

                            '##### End of Cases For Resource Timesheet Flow

                            'Added For Work Order Facilties on 19 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_WORKORDER_FACILITIES
                            If Args.CaptionForDeleteColumn = "Delete" Then
                                Args.CaptionForDeleteColumn = "Select"
                                'Args.DeletionCheckboxName = "chkVerify"
                            End If
                            'End addition

                            'Added For Question Selection List
                        Case CommonFunction.Constants.APP_TAG_QUESTION_SELECTION_LIST
                            If Args.CaptionForDeleteColumn = "Delete" Then
                                Args.CaptionForDeleteColumn = "Select"

                            End If
                            'End Addition


                            'Added by ShamkantD on 20th August 2004
                        Case CommonFunction.Constants.APP_TAG_WORKORDER_CONTRACT_CLAUSES
                            If Args.CaptionForDeleteColumn = "Delete" Then
                                Args.CaptionForDeleteColumn = "Select"
                            End If
                            'End of addition - ShamkantD on 20th August 2004
                            'Added by LakshmiN on 20th August 2004
                        Case CommonFunction.Constants.APP_TAG_PROJECT_DOH
                            'Modified by ShamkantD on 17 Sep 2004 - enable Delete checkbox in Project Costs page
                            'Args.Delete = False
                            'Modification ends - ShamkantD on 17 Sep 2004

                            'Set the column names for which total is to be calculated
                            Dim ActCols As String() = {"CostToCompany", "Reimbersable"}
                            'Set the function as Sum
                            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                            'Dim SummFunc As EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions() = {EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions.Sum, EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions.Sum}
                            Dim SummFunc As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_SUM, CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_SUM}
                            Dim SummFuncLevel As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_LEVEL_BOTH, CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_LEVEL_BOTH}

                            Dim objTemplate As New WebPage.Templates.WhizTemplate
                            objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                            With Args
                                .SummaryFuncActualColumnArray = ActCols
                                .SummaryFuncNameArray = SummFunc
                                '.SummaryFuncLevel = EventHandlers.WAF_Grid.WAF_InitializeGrid.Level.Both
                                .SummaryFuncLevel = SummFuncLevel
                                .SummaryGroupTitle = "Total at Cost Group Level"
                                'Add the caption 'Total' 
                                .SummaryTotalTitle = "Total "
                                .SummaryGroupTR = "clsTRColumnHeader"
                                '.SummaryTotalTR = "clsTRSectionHeader"
                                .SummaryTotalTR = "clsTRColumnHeader"
                            End With
                            objTemplate = Nothing
                            'End Of Modifications - IssueID : 672
                            'End of addition 

                            'Added by ShamkantD on 23rd August 2004
                        Case CommonFunction.Constants.APP_TAG_ANSWER_SET_PREVIEW
                            Args.Delete = False
                            'End of addition - ShamkantD on 23rd August 2004

                            '    'added by DiptiK   on 15 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_CNF_SERVICE_SEGMENATATION
                            '    'Select Case Args.ColumnName.ToUpper
                            '    'Case "SERVICEOFFERINGNAME", " SUBSERVICEOFFERINGNAME"
                            Args.ApplySorting = False
                            '    'End Select
                            '    'addition end

                            '    'added by DiptiK   on 15 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_CNF_MARKET_SEGMENATATION
                            '    'Select Case Args.ColumnName.ToUpper
                            '    'Case "SERVICEOFFERINGNAME", " SUBSERVICEOFFERINGNAME"
                            Args.ApplySorting = False
                            '    'End Select
                            '    'addition end

                            'Added by ShamkantD on 27 Sep 2004 - added for 'Project Listing for Approvals' tab
                        Case CommonFunction.Constants.APP_TAG_PROJECT_LISTING_FOR_APPROVALS
                            Args.Delete = False
                            'End of addition - ShamkantD on 27 Sep 2004

                            'Added by ShamkantD on 29 Sep 2004 - added for Show Revisions (Project Information) page
                        Case CommonFunction.Constants.APP_TAG_TAB_BASELINE_REVISION
                            Args.Delete = False
                            'End of addition - ShamkantD on 29 Sep 2004
                            'Added by DipaliS 15 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_FIELD_CAPTIONS, CommonFunction.Constants.APP_TAG_STATUS_OF_STATUS
                            Args.Delete = False
                            'End addition by DipaliS

                            ''Commented by Manishk on 3rd Jan 06 as new inherited page is added for this 

                            '''    'Added By JayavantK On 15-Oct-2004
                            '''Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEAPPLICATION
                            '''    'Modified By SandeepA on 7 Dec,2005 for IssueID-672:the Change of DIV height for Whiz2.0 Integration (Earlier height:350px)
                            '''    CommonFunctions.General.WriteHTML("<DIV Id=divList Style='HEIGHT:400px; OVERFLOW:auto; WIDTH:100%'>")
                            '''    'End of Modification by SandeepA on 7 dEC,2005.
                            '''    'End Addition
                            ''End of comment by Manishk on 3rd Jan 06

                            'Added By MrugajaB on 21st March 2005 for 'Show Project Approver' functionality
                        Case CommonFunction.Constants.APP_TAG_PROJECT_APPROVERS
                            'For 'Show Project Approver' functionality - remove delete access
                            Args.Delete = False
                            'End Addition
                            'Added By MrugajaB on 8th April 2005 for 'Show Request Approver' functionality
                        Case CommonFunction.Constants.APP_TAG_REQUEST_APPROVERS
                            'For 'Show Request Approvers' functionality - remove delete access
                            Args.Delete = False
                            '    'Addition by Harshada D For SRIT IssueID: 19240 on 18 th May 2005
                        Case CommonFunction.Constants.APP_TAG_PROJECT_DOCUMENTCATEGORY
                            Dim strSQL As String = Args.GridSQL
                            'm_intIndex stores the index of first character of the string "AND LEFT(category)='C'"
                            Dim m_intIndex As Integer = strSQL.IndexOf("AND LEFT", 0)
                            'If string left found then
                            If m_intIndex > 0 Then
                                Dim m_intIndex1 As Integer = strSQL.IndexOf(",1) = '")
                                ' strCategory stores the full string "AND LEFT(category,1)='C'"
                                Dim strCategory As String = strSQL.Substring(m_intIndex, ((m_intIndex1 + 9) - m_intIndex))
                                strSQL = strSQL.Replace(strCategory, "")
                            End If
                            Args.GridSQL = strSQL
                            'End of addition by Harshada D on 18 Th May 2005 

                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID
                        '    'Added By JyotiG (29-Nov-2006)
                        'Case CommonFunction.Constants.APP_SUBTAG_EMPLOYEE_ASSIGNMNETS
                        '        Dim strEmployeeID As String
                        '        Dim intRole As Long
                        '        Dim strSQL As String = Args.GridSQL
                        '        Dim intlen As Integer
                        '        Dim str1 As String
                        '        intlen = InStr(strSQL, "ORDER BY")
                        '        If intlen <> 0 Then
                        '            strSQL = Left(strsql, intlen - 1)
                        '        End If

                        '        Dim strNewSql As String = ""
                        '        str1 = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("EmployeeID"), ""), String)

                        '        If str1 = "" Then
                        '            HttpContext.Current.Session.Add("EmployeeID", HttpContext.Current.Request.QueryString("EmployeeID_PK").ToString)
                        '            strEmployeeID = CType(HttpContext.Current.Session("EmployeeID"), String)
                        '        Else
                        '            'strEmployeeID = HttpContext.Current.Request.QueryString("EmployeeID_PK").ToString + ""
                        '            strEmployeeID = CType(HttpContext.Current.Session("EmployeeID"), String)
                        '        End If
                        '        If strEmployeeID <> "" Then
                        '            strNewSql = " UNION select EMP.EmployeeID , ProjectName,RL.RoleDescription,NULL,NULL,0,0,"
                        '            strNewSql = strNewSql & " Case RL.[Level] when 1 then 'High' when 2  then 'Middle' When 3 then 'Low' end as Level ,"
                        '            strNewSql = strNewSql & " CASE PM.[Over] when 0 then 'Open' else 'Close' end as Status ,'Yes' as Active, EMP.EmployeeID"
                        '            strNewSql = strNewSql & " from dbo.udf_GetAccessibleProjectList(" + CType(strEmployeeID, String) + ""
                        '            strNewSql = strNewSql & " ) T, tbl_PM_Project PM , tbl_PM_Employee EMP ,tbl_PM_Role RL"
                        '            strNewSql = strNewSql & " where(PM.Projectid = T.ProjectID) and PM.GlobalProject = 0 and RL.RoleID = EMP.PostId"
                        '            strNewSql = strNewSql & " and EMP.EmployeeID = " + CType(strEmployeeID, String) + ""
                        '            strNewSql = strNewSql & " and T.Projectid not in (Select d_tbl_PM_Project_CurrentAssignment.Projectid from d_tbl_PM_Project_CurrentAssignment where EmployeeId = " + CType(strEmployeeID, String) + ""
                        '            strNewSql = strNewSql & ")"
                        '        End If
                        '        strSQL = strSQL & strNewSql
                        '        Args.GridSQL = strSQL
                        'End Of Addition By JyotiG
                        Case CommonFunction.Constants.APP_TAG_TAB_SCM_PLAN_CONFIGURABLE_ITEMS
                            'Set the column names for which total is to be calculated
                            Dim ActCols As String() = {"NoOfConfigItems", "NoOfItemsBaselined"}
                            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                            'Set the function as Sum
                            'Dim SummFunc As EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions() = {EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions.Sum, EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions.Sum}
                            Dim SummFunc As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_SUM, CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_SUM}
                            Dim SummFuncLevel As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_LEVEL_FOOTER, CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_LEVEL_FOOTER}

                            Dim objTemplate As New WebPage.Templates.WhizTemplate
                            objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                            With Args
                                .SummaryFuncActualColumnArray = ActCols
                                .SummaryFuncNameArray = SummFunc
                                '.SummaryFuncLevel = EventHandlers.WAF_Grid.WAF_InitializeGrid.Level.Total
                                .SummaryFuncLevel = SummFuncLevel
                                .SummaryGroupTitle = ""
                                'Add the caption 'Total' from the resource file for event handlers
                                .SummaryTotalTitle = objTemplate.GetResourceString("TOTAL")
                                .SummaryGroupTR = "clsTRColumnHeader"
                                .SummaryTotalTR = "clsTRColumnHeader"
                            End With
                            objTemplate = Nothing
                            'End Of Modifications - IssueID : 672
                            'added by SachinR   on 23 Aug 2004
                            'issue 12528
                        Case CommonFunction.Constants.APP_TAG_TAB_SOFTEX_FORM
                            'Set the column names for which total is to be calculated
                            Dim ActCols As String() = {"BillingCurrencyAmount"}
                            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                            'Set the function as Sum
                            'Dim SummFunc As EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions() = {EventHandlers.WAF_Grid.WAF_InitializeGrid.SummaryFunctions.Sum}
                            Dim SummFunc As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_SUM}
                            Dim SummFuncLevel As String() = {CommonFunctions.Constants.CLCP_LIST_SUMMARY_FUNCTION_LEVEL_FOOTER}

                            With Args
                                .SummaryFuncActualColumnArray = ActCols
                                .SummaryFuncNameArray = SummFunc
                                .SummaryFuncLevel = SummFuncLevel
                                .SummaryGroupTitle = ""
                                'Add the caption 'Total' from the resource file for event handlers
                                '.SummaryTotalTitle = "Total Amount : "
                                .SummaryTotalTitle = ""
                                .SummaryGroupTR = "clsTRColumnHeader"
                                .SummaryTotalTR = "clsTRColumnHeader"
                            End With
                            'End Of Modifications - IssueID : 672
                            'addition end
                            'Added by ShamkantD on 25th Aug 2004
                        Case CommonFunction.Constants.APP_SUB_TAG_CHECKLIST_ITEMS
                            Args.Delete = False
                            'End Of addition - ShamkantD on 25th Aug 2004

                            'Added by ShamkantD on 13th Sep 2004 for Checklist subtag on Fast Track Review page
                            ' Commented By MahendraV On 12:06 PM 7/12/2007 For WhizibleSEM 7 
                            ' To remove 'Checklist' tab from fast track review.Now this link will displayed as UI Link
                            ' Start_MV_7/12/2007
                            'Case CommonFunction.Constants.APP_SUBTAG_CHECKLIST_FASTTRACK_REVIEW
                            '    Cancel = True
                            '    Dim strFunction As String = ""
                            '    strFunction = "<iframe"
                            '    strFunction &= " src=""../PM/PM_FastTrackReviewChecklist.aspx"
                            '    strFunction &= "?ReviewStatisticsID=" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("ReviewStatisticsId"), "").ToString() & """"
                            '    strFunction &= " frameborder=0 scrolling=yes width=100% align=middle>"
                            '    strFunction &= "</iframe>"
                            '    Args.ToBeInserted = strFunction
                            '    Cancel = True
                            '    HttpContext.Current.Session("ReviewStatisticsId") = Nothing
                            '    'End of addition - ShamkantD on 13th Sep 2004 
                            '    '  Case CommonFunction.Constants.APP_TAG_TAB_PROJECT_CHECKLISTITEM
                            '    'Modified by MrugajaB on 25th Aug 2006 for Issue ID.3736
                            '    'Delete column should be displayed when checklist type is 'Project Specific'
                            '    'Args.Delete = False
                            '    'End Modification
                            ' End_MV_7/12/2007

                            'Added By JyotiG
                            'Start_JG_CR_7630_23-Nov-2006

                        Case CommonFunction.Constants.APP_SUBTAG_EMPLOYEE_CURRENT_ASSIGNMNETS
                            Dim strFunction As String = ""
                            Dim strId As String
                            'strId = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("EmployeeID_PK"), "").ToString()
                            strId = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("EmployeeId"), "0"), String)
                            If strId = "0" Then
                                strId = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("EmployeeID_PK"), "").ToString
                            End If
                            strFunction = "<iframe"
                            strFunction &= " src=""../HR/HR_CurrentAssignments.aspx"
                            strFunction &= "?PageNumber=-1&EmployeeID_PK=" & strId.ToString & """"
                            strFunction &= " frameborder=0 scrolling=no width=100% height=300  align=middle>"
                            strFunction &= "</iframe>"
                            Args.ToBeInserted = strFunction
                            Cancel = True
                            HttpContext.Current.Session("EmployeeID") = Nothing
                            'End_JG_CR_7360_23-Nov-2006

                            ''Added by Dhanashri S on 29 Oct 2015
                            'Added By NileshD on 16 Sept. 2004
                        Case CommonFunctions.Constants.TAG_TAB_CLCPEXTENSION_CUSTOMECODE
                            Args.ApplySorting = False
                            Args.Delete = False
                        Case CommonFunctions.Constants.TAG_TAB_CLCPEXTENSION_INPUTPARAMETER
                            Args.Delete = False
                            'End Of Addition

                            ''End of Addition by Dhanashri S on 29 Oct 2015

                    End Select
                End If
            End Sub

            Public Shared Sub Before_GridColumnHeaderTR_Print(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Grid.WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Cancel = False
                'This Event will occur before 

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

            Public Shared Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim objTemplate As WebPages.Template.WhizTemplate

                Cancel = False
                'This Event will occur before 
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID


                         'Added by Vyankat B. on 20th April 2026 to set the dynamic currency symbol
                        ' --- Added to set currency logo for Cost column header when TagID is 53 ---
                        Case 53
                            If Args.ColumnName.Trim().Equals("Cost", StringComparison.OrdinalIgnoreCase) Then
                                Dim strCurrencyLogo As String = ""
                                Try
                                    Dim objLogo As Object = CommonFunction.Data.GetDataScalar("EXEC use_Whizible2_Currency_logo", True)
                                    strCurrencyLogo = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objLogo, ""), ""), String).Trim()
                                Catch ex As Exception
                                End Try

                                If strCurrencyLogo <> "" Then
                                    Args.ColumnName = "Cost (" & strCurrencyLogo & ")"
                                End If
                            End If
                        ' --------------------------------------------------------------------------
                        'End of Added by Vyankat B. on 20th April 2026 to set the dynamic currency symbol

                        '----------------------------------------------------------------------------------
                        'Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
                        ' Added by GaneshG on 12 Jan 2006 
                        ' Modification for RFI Deliverable and RFI Milestone Page.
                        Case CommonFunction.Constants.APP_TAG_RFI_DELIVERABLES
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Select"
                            End If

                            'To change ClientSideSortFuctionName
                            If Args.ClientSideSortFunctionName = "SortBy" Then
                                Args.ClientSideSortFunctionName = "SortByColumn"
                            End If

                        Case CommonFunction.Constants.APP_TAG_RFI_MILESTONE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Select"
                            End If

                            'To change ClientSideSortFuctionName
                            If Args.ClientSideSortFunctionName = "SortBy" Then
                                Args.ClientSideSortFunctionName = "SortByColumn"
                            End If
                            'End of Addition
                            'End Integration by SavitaS on 13 Mar 2006
                            '----------------------------------------------------------------------------------
                            'Integrated by SavitaS on 02 Jan 2006 for Help Desk.
                        Case CommonFunction.Constants.APP_TAG_SHOW_CRM_HISTORY
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End Integration by SavitaS

                            'This code is not required in Whiz2
                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2

                            'Added By SandeepA on 14 Nov,2005 for IssueIS -- 676
                            'Page:ProjectInfor Role Access TagID-3083
                            ' Case CommonFunction.Constants.APP_TAG_ProjectInfoRoleAccess
                            'Purpose: Configure 'Delete' link as 'Select' link
                            'If Args.ColumnName.ToUpper = "DELETE" Then
                            'Args.ColumnName = "Select"
                            'End If
                            'End of addition by SandeepA on 14 Nov,2005 for IssueID --676
                            'End Integration

                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                            'Added by SandeepA on 15 nov,2005 for IssueID -- 677
                            'Page: Middle Level Resource -Project Access BG, TagID:3087
                        Case CommonFunction.Constants.APP_TAG_BG_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            'Purpose:Configure 'Delete' link as 'Select' link
                            'If Args.ColumnName.ToUpper = "DELETE" Then
                            'Args.ColumnName = "Select"
                            'End If
                            'End of addition by SandeepA on 15 Nov,2005 for IssueID -- 677
                            'End Integration

                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                            'Added by SandeepA on 15 nov,2005 for IssueID -- 679
                            'Page: Middle Level Resource -Project Access OU, TagID:3088
                        Case CommonFunction.Constants.APP_TAG_OU_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            'Purpose:Configure 'Delete' link as 'Select' link
                            'If Args.ColumnName.ToUpper = "DELETE" Then
                            '    Args.ColumnName = "Select"
                            'End If
                            'End of addition by SandeepA on 15 Nov,2005 for IssueID -- 679
                            'End Integration

                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                            'Added by SandeepA on 16 nov,2005 for IssueID -- 680
                            'Page: Middle Level Resource -Project Access DU, TagID:3090
                        Case CommonFunction.Constants.APP_TAG_DU_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            'Purpose:Configure 'Delete' link as 'Select' link
                            'If Args.ColumnName.ToUpper = "DELETE" Then
                            '    Args.ColumnName = "Select"
                            'End If
                            'End of addition by SandeepA on 16 Nov,2005 for IssueID -- 680
                            'End Integration

                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                            'Added by SandeepA on 16 nov,2005 for IssueID -- 681
                            'Page: Middle Level Resource -Project Access DT, TagID:3092
                        Case CommonFunction.Constants.APP_TAG_DT_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            'Purpose:Configure 'Delete' link as 'Select' link
                            'If Args.ColumnName.ToUpper = "DELETE" Then
                            '    Args.ColumnName = "Select"
                            'End If
                            'End of addition by SandeepA on 16 Nov,2005 for IssueID -- 681
                            'End Integration



                            ' Added by NitinVS on 22 Oct 2005 for WhizibleSEM SP4 IssueID 593 
                        Case CommonFunction.Constants.APP_TAG_SQERT_RANGES
                            If (Args.ColumnName.ToUpper = "DELETE") Then
                                Cancel = True
                            End If
                            'End Addition By NitinVs on 22 Oct 2005 for WhizibleSEM SP4 IssueID 593  

                            ' Added by NitinVS on 22 Oct 2005 for WhizibleSEM SP4 IssueID 593 

                            'added by HarshK for sp4 issueid 536
                        Case CommonFunction.Constants.APP_TAG_TAB_APPROVER_HISTORY
                            If (Args.ColumnName.ToUpper = "DELETE") Then
                                Cancel = True
                            End If
                            'End added by HarshK for sp4 issueid 536
                            'Added by VivekP on 02 sep 2005- for Select Projects for SQERT Locking 
                            'Added by Mangesh Y on 6 Jan 2005 - for Select Projects for SQERT Locking
                        Case CommonFunction.Constants.APP_TAG_SQERT_LOCK
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Lock"
                            End If
                            'End of addition - Mangesh Y on 6 Jan 2005 
                            'End of addition - VivekP on 02 sep 2005

                        Case CommonFunction.Constants.APP_TAG_TEMPLATES
                        Case CommonFunction.Constants.APP_TAG_PROJECT_TEMPLATE
                            'Select Case Args.Args.DataField.ToUpper
                            '    Case "CONFIGURE PLANS", "CONFIGURE SDLC", "CONFIGURE PHASES", _
                            '         "CONFIGURE TASK TYPES", "CONFIGURE TASK ATTRIBUTES", _
                            '         "CONFIGURE ISSUE TYPES", "CONFIGURE REVIEW TYPES", _
                            '         "CONFIGURE GENERIC TASKS", "CONFIGURE RISKS"
                            Args.ApplyNoWrap = False
                            'End Select
                        Case CommonFunction.Constants.APP_TAG_ASSIGNED_TASK
                            If Args.ColumnName.ToUpper = "TASK NAME" Then
                                Args.TDStyle = " width='35%' "
                            End If
                        Case CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT
                            If Args.ColumnName.ToUpper = "CHANGE REQUEST" Then
                                Args.TDStyle = " width='25%' "
                            End If
                        Case CommonFunction.Constants.APP_TAG_RISKS
                            If Args.ColumnName.ToUpper = "DESCRIPTION" Then
                                Args.TDStyle = " width='25%' "
                            End If
                        Case CommonFunction.Constants.APP_TAG_RESOURCE_BILLING
                            If (Args.ColumnName.ToUpper = "DELETE") Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEMASTER
                            If (Args.ColumnName.ToUpper = "DELETE") Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEBALANCE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_ASSIGNEDRESOURCES
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Select"
                            End If
                            'Code commented by PrashantD on 19 Jan 2008 for Resource Demand Enhancment
                            'Case CommonFunction.Constants.APP_TAG_RESOURCEREQUEST
                            '    If Args.ColumnName.ToUpper = "DELETE" Then
                            '        Cancel = True
                            '    ElseIf Args.DataField.ToUpper = "STATUS" Then
                            '        Args.ApplySorting = False
                            '    End If
                            'End of comment by PrashantD on 19 Jan 2008 for  Resource Demand Enhancment
                        Case CommonFunction.Constants.APP_TAG_SCM_PLAN
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                        Case CommonFunctions.Constants.TAG_OUTPUT_FORMAT_SETTINGS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            ''Commented By ManishK on 3rd Jan 2006 as new inherited page is added for Employee Leaves page
                            ''''Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS
                            ''''    If Args.ColumnName.ToUpper = "DELETE" Then
                            ''''        Cancel = True
                            ''''    End If
                            ''End of Commented by ManishK on 3rd Jan 2006

                        Case CommonFunction.Constants.APP_TAG_LEAVEMASTER
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_REVISION_HISTORY
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_CONFIG_TYPE_SECURITY_ROLES
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                ''------------------------------------------------------------------------------------------
                                ''Code added by RohiniK on 21 August 2006 for Role wise Access to All ISsues Tab in Issues Module  for Whiziblesem SP 7 Issue ID 5688 
                                ''code commented and added by RohiniK on 21 August 2006 for displaying delete checkbox and renaming delete coulmn as Disable All Issues Tab
                                'Cancel = True
                                Args.ColumnName = "Hide All Issues Tab"
                                ''End of Code addition by RohiniK on 21 August 2006 for Role wise Access to All ISsues Tab in Issues Module
                                ''------------------------------------------------------------------------------------------
                            ElseIf Args.ColumnName.ToUpper = "ROLELINK" Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_CONFIG_TYPE_SECURITY
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.IB_IssueTypes", "AppResources")
                                Args.ColumnName = objTemplate.GetResourceString("TYPE_CONFIG_ACCESS")
                                objTemplate = Nothing
                            End If
                            'added by SachinR   on 05 Jul 2004
                            'To make the delete column as select column
                        Case CommonFunction.Constants.APP_TAG_PROJECT_ROOT_CAUSE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.PM_RootCauses", "AppResources")
                                Args.ColumnName = objTemplate.GetResourceString("COL_SELECT")
                                objTemplate = Nothing
                            End If
                            'addition end

                            'added by SachinR   on 06 Jul 2004
                            'To make the delete column as select column
                        Case CommonFunction.Constants.APP_TAG_PROJECT_CUSTOM_FIELD_MAINTENANCE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.PM_RootCauses", "AppResources")
                                Args.ColumnName = objTemplate.GetResourceString("COL_SELECT")
                                objTemplate = Nothing
                            End If
                            'addition end
                            'added by SachinR   on 15 Jul 2004

                            '***** Code added by SandipL on 19 Jan 2006
                        Case CommonFunction.Constants.APP_TAG_PROJECT_TASK_CUSTOM_FIELD_MAINTENANCE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.PM_RootCauses", "AppResources")
                                Args.ColumnName = objTemplate.GetResourceString("COL_SELECT")
                                objTemplate = Nothing
                            End If
                            '***** End addition by SandipL

                        Case CommonFunction.Constants.APP_TAG_SDLC_PROCESS
                            Select Case Args.DataField.ToUpper
                                Case "ISREQUIRED", "ISPERFORMED", "ISTAILORING", "ISDEVIATION"
                                    Args.ApplySorting = False
                            End Select
                            'addition end
                            'Added by ShamkantD on 26th July 2004 - added to hide Delete column
                        Case CommonFunction.Constants.APP_TAG_CONFIG_COMMERICAL_CONTRACT_TYPE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End of addition - ShamkantD on 26th July 2004 
                        Case CommonFunction.Constants.APP_TAG_RFI_INITIATOR, CommonFunction.Constants.APP_TAG_RFI_INVOICE_DETAIL_LIST
                            If Args.DataField.ToUpper = "EQUIVAMOUNT" Then
                                'Get the Base Currency Code
                                Dim drBaseCurrency As IDataReader
                                Dim strColName As String

                                drBaseCurrency = CommonFunction.Data.GetDataReader("usp_InvoiceDB_GetBaseCurrencyInfo", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drBaseCurrency.Read Then
                                    strColName = CType(CommonFunction.General.CheckIsNothing(drBaseCurrency.Item("CurrencyCode")), String)
                                Else
                                    strColName = ""
                                End If

                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                Args.ColumnName = objTemplate.GetResourceString("RFI_COL_NAME").Replace("<code>", strColName)
                                objTemplate = Nothing
                                CommonFunction.Data.DisposeDataReader(drBaseCurrency)
                            End If
                            'Added By JayavantK On 30-Jul-2004 - Start
                        Case CommonFunction.Constants.APP_TAG_OUPOOL_MASTER
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_TAG_OUPools
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            'Added By VidyaJ - DA Performance Issue - 89 (SP4)
                        Case CommonFunction.Constants.APP_TAG_UPDATEACTUALS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If


                            'End Of addition

                        Case CommonFunction.Constants.APP_TAG_TEAMPOOLS_EDIT
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_TAG_GLOBAL_RESOURCE_POOL
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_TAG_RESOURCE_POOL_VIEW
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            'End Addition
                            'Added By NileshD On 30 July 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_STATUS_HISTORY
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_LIST
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_RFI_TOOL
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Select"
                            End If
                        Case CommonFunction.Constants.APP_TAG_RFI_OS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Select"
                            End If
                        Case CommonFunction.Constants.APP_TAG_RFI_CHECKLIST_VIEW
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_RFI_SALES_PERSON
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Select"
                            End If
                            'End Of Addition
                        Case CommonFunction.Constants.APP_TAG_EMPLOYEE_ACCESS_TO_CUSTOMER_REQUEST
                            ''added by Nilesh g on 27/11/2015 
                            If Args.ColumnName.ToUpper = "ALLOW TO SEE HELPDESK DASHBOARD" Then
                                Args.TDStyle = "style='text-align:center !important'"
                            End If
                            ''end of added by Nilesh g on 27/11/2015 
                            If Args.ColumnName.ToUpper = "USER ACCESS" Then
                                '' Args.Alignment = "center !important"
                                Args.TDStyle = "style='text-align:center !important'"
                                'Args.StringToBeInserted = "<TD  nowrap vAlign=top title='Selected Check List will be added to the project' width='50%'><A href=""JavaScript:Hyperlink1('" + strCheckList + "','" + CType(Args.DataReader("QuestionnaireID"), String) + "');"">" + "Select CheckList" + "</A></td>"
                                'Cancel = True
                            End If

                            'Added by ShamkantD on 28th July 2004 - added to show / hide grid according to the value selected in Role combobox
                        Case CommonFunction.Constants.APP_TAG_CONFIG_WORKORDER_FIELD_ACCESS
                            'If no Role selected, do not paint the grid header
                            If HttpContext.Current.Request.Form("RoleID") = Nothing Then
                                Cancel = True
                            Else
                                'Change the caption of "Delete" column to "Select"
                                If Args.ColumnName.ToUpper = "DELETE" Then
                                    Args.ColumnName = "Select"
                                    Args.TDStyle = " width='30%' "
                                End If
                            End If
                            'End of addition - ShamkantD on 28th July 2004 
                            'Added By NileshD on 31 July 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_APPROVAL
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.DataField.ToUpper = "EQUIVAMOUNT" Then
                                'Get the Base Currency Code
                                Dim drBaseCurrency As IDataReader
                                Dim strColName As String

                                drBaseCurrency = CommonFunction.Data.GetDataReader("usp_InvoiceDB_GetBaseCurrencyInfo", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drBaseCurrency.Read Then
                                    strColName = CType(CommonFunction.General.CheckIsNothing(drBaseCurrency.Item("CurrencyCode")), String)
                                Else
                                    strColName = ""
                                End If

                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                Args.ColumnName = objTemplate.GetResourceString("RFI_COL_NAME").Replace("<code>", strColName)
                                objTemplate = Nothing
                                CommonFunction.Data.DisposeDataReader(drBaseCurrency)
                            End If
                            'End Of Addition

                            'Added By JayavantK on 31 July 2004
                        Case CommonFunction.Constants.APP_TAG_BUSINESSGROUP
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End Of Addition
                            'Added By NileshD on 2 August 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_GENERATION
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.DataField.ToUpper = "EQUIVAMOUNT" Then
                                'Get the Base Currency Code
                                Dim drBaseCurrency As IDataReader
                                Dim strColName As String

                                drBaseCurrency = CommonFunction.Data.GetDataReader("usp_InvoiceDB_GetBaseCurrencyInfo", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drBaseCurrency.Read Then
                                    strColName = CType(CommonFunction.General.CheckIsNothing(drBaseCurrency.Item("CurrencyCode")), String)
                                Else
                                    strColName = ""
                                End If

                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                Args.ColumnName = objTemplate.GetResourceString("RFI_COL_NAME").Replace("<code>", strColName)
                                objTemplate = Nothing
                                CommonFunction.Data.DisposeDataReader(drBaseCurrency)
                            End If
                            'End Of Addition

                            'Added By JayavantK on 4 August 2004
                        Case CommonFunction.Constants.APP_TAG_BGPOOL_MASTER
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End Of Addition

                            'Added By VidyaJ on 16th Dec 2004
                        Case CommonFunction.Constants.APP_TAG_EMPLOYEESITEDETAILS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Site Transfer"
                            End If
                            'End Of Addition

                        Case CommonFunction.Constants.APP_TAG_PM_SERVICE_SEGMENTATION
                            'Added by ShamkantD on 9th August 2004
                            'Change the caption of "Delete" column to "Select"
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Select"
                            End If
                            'End of addition - ShamkantD on 9th August 2004

                        Case CommonFunction.Constants.APP_TAG_PM_MARKET_SEGMENTATION
                            'Added by Paresh B on September 06, 2004
                            'Change the caption of "Delete" column to "Select"
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Select"
                            End If
                            'End of addition - Paresh B on September 06, 2004


                            '##### Cases Added For Resource Timesheet Flow On 10 AUG 2004
                        Case CommonFunction.Constants.APP_TAG_RES_TMSHEET_TASK_DETAILS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_Tag_ROWWISE_APPROVERS_HISTORY
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_Tag_TIMESHEET_SHOW_REMARKS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_TAG_RTS_SHOW_HISTORY_EMPLOYEE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_RTS_SHOW_HISTORY_APPROVERS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            '##### End Of Cases For Resource Timesheet Flow

                            'added by SachinR   on 13 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLES
                            'here dummy column is canceled so as to apply the hyperlink given to the control
                            If Args.DataField = "LabelScheduleAlias" Then
                                Cancel = True
                            End If
                            'addition end
                            'added by SachinR   on 13 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                            ''grid columns are hidden if field is not applicable to deliverable type 
                            'Dim strSQL As String
                            'Dim objDr As IDataReader
                            Dim strScheduleID As String
                            'Dim blnUseSQL As Boolean
                            'blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

                            'Modified By VidyaJ - Performance Issue - Deliverable - SP4 - IssueID -84

                            'Initialized DeliverableTypeID in session variable in UI list Pre Render  event

                            'strSQL = "Select isnull(FixedValue,0) As 'FixedValue' From tbl_ui_EmployeeFilterSettings_FieldDetails Where TagID=" + CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString
                            'strSQL += " And ControlName='DeliverableTypeID' And UserID=" + WhizGlobal.UserID.ToString
                            'strSQL += " And LoginType='" + WhizGlobal.LoginType.Trim + "'"
                            'objDr = CommonFunction.Data.GetDataReader(strSQL, blnUseSQL)
                            'If objDr.Read Then
                            '    strScheduleID = CommonFunction.Data.CheckIsDBNull(objDr("FixedValue"), "").ToString + ""
                            'End If
                            'CommonFunction.Data.DisposeDataReader(objDr)
                            'If strScheduleID = "" Then strScheduleID = "0"
                            ''strScheduleID = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, blnUseSQL), "").tostring

                            'added by SachinR   on 02 Nov 2004
                            'hashtable implementation for the deliverable field configuration
                            Select Case UCase(Args.DataField)
                                Case "DELIVERABLETYPEID"
                                    Cancel = True

                                Case "CUSTOMERREFNO", "DELIVERABLELCE", "PERCENTAGECOMPLETE", "LATESTCOMPLETIONDATE"
                                    'Modified By VidyaJ - Performance Issue - Deliverable - SP4 - IssueID -84

                                    'Initialize DeliverableTypeID from session variable
                                    strScheduleID = CType(HttpContext.Current.Session("DeliverableType"), String)
                                    'End Of Modifications

                                    Dim blnIsApplicable As Boolean = False
                                    Dim objDeliverableField As New CommonEngine.HashTables.DeliverableField
                                    objDeliverableField = CommonEngine.HashTables.Deliverable.GetHashTableDeliverableFieldObject(CType(strScheduleID, Long), Args.DataField)
                                    If Not objDeliverableField Is Nothing Then
                                        blnIsApplicable = objDeliverableField.Applicable
                                    End If
                                    objDeliverableField = Nothing

                                    If blnIsApplicable = False Then
                                        Cancel = True
                                    End If

                                    '' START : Added By ParagD On 6-Oct-2006
                                    '' Purpose : WHiz SP7 Issue - When no ADD access for Deliverable node ,then hide "Copy" link on list page.
                                Case "IMAGE1"
                                    Dim drAccessRights As IDataReader
                                    Dim strQuery As String
                                    Dim intPostId As Integer
                                    Dim intUserId As Integer
                                    Dim strLoginType As String
                                    Dim intProjectID As Integer
                                    Dim blnAddRight As Boolean
                                    Dim blnEditRight As Boolean

                                    intPostId = CType(HttpContext.Current.Session("intPostID"), Integer)
                                    intUserId = CType(HttpContext.Current.Session("intUserID"), Integer)
                                    strLoginType = CType(HttpContext.Current.Session("LoginType"), String)
                                    intProjectID = CType(HttpContext.Current.Session("intProjectID"), Integer)

                                    strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " & WhizGlobal.TagID & "," & intPostId.ToString & "," & intUserId.ToString & ",'" & strLoginType & "'," & intProjectID.ToString
                                    drAccessRights = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If CommonFunctions.General.CheckIsNothing(drAccessRights) <> "" Then
                                        drAccessRights.Read()
                                        blnAddRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("A"), "False"), Boolean)
                                        blnEditRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("E"), "False"), Boolean)
                                    End If
                                    If (blnAddRight = False) Then
                                        Cancel = True
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(drAccessRights)
                                    '' END : Added By ParagD On 6-Oct-2006

                            End Select
                            'addition end   on 02 Nov 2004

                            '' START : Added By ParagD On 6-Oct-2006
                            '' Purpose : WHiz SP7 Issue - When no ADD access for Module/Sub Projects/Milestone Details node ,then hide "Copy" link on list page.
                        Case CommonFunction.Constants.APP_TAG_MODULES, CommonFunction.Constants.APP_TAG_SUB_PROJECTS, CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS
                            Select Case UCase(Args.DataField)
                                Case "IMAGE1"
                                    Dim drAccessRights As IDataReader
                                    Dim strQuery As String
                                    Dim intPostId As Integer
                                    Dim intUserId As Integer
                                    Dim strLoginType As String
                                    Dim intProjectID As Integer
                                    Dim blnAddRight As Boolean
                                    Dim blnEditRight As Boolean

                                    intPostId = CType(HttpContext.Current.Session("intPostID"), Integer)
                                    intUserId = CType(HttpContext.Current.Session("intUserID"), Integer)
                                    strLoginType = CType(HttpContext.Current.Session("LoginType"), String)
                                    intProjectID = CType(HttpContext.Current.Session("intProjectID"), Integer)

                                    strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " & WhizGlobal.TagID & "," & intPostId.ToString & "," & intUserId.ToString & ",'" & strLoginType & "'," & intProjectID.ToString
                                    drAccessRights = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If CommonFunctions.General.CheckIsNothing(drAccessRights) <> "" Then
                                        drAccessRights.Read()
                                        blnAddRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("A"), "False"), Boolean)
                                        blnEditRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("E"), "False"), Boolean)
                                    End If
                                    If (blnAddRight = False) Then
                                        Cancel = True
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(drAccessRights)
                            End Select
                            '' END : Added By ParagD On 6-Oct-2006

                            'added by DiptiK on 17 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_CNF_PROJECT_SETTINGS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_TAG_RFI_SENDINVOICEMAILS
                            If Args.DataField.ToUpper = "EQUIVAMOUNT" Then
                                'Get the Base Currency Code
                                Dim drBaseCurrency As IDataReader
                                Dim strColName As String

                                drBaseCurrency = CommonFunction.Data.GetDataReader("usp_InvoiceDB_GetBaseCurrencyInfo", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drBaseCurrency.Read Then
                                    strColName = CType(CommonFunction.General.CheckIsNothing(drBaseCurrency.Item("CurrencyCode")), String)
                                Else
                                    strColName = ""
                                End If

                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                Args.ColumnName = objTemplate.GetResourceString("RFI_COL_NAME").Replace("<code>", strColName)
                                objTemplate = Nothing
                                CommonFunction.Data.DisposeDataReader(drBaseCurrency)
                            End If
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                Args.ColumnName = objTemplate.GetResourceString("SELECT")
                                objTemplate = Nothing
                            End If
                            ' addition ends
                            'Added by HarshK for sp4 issueid 200 on 14/09/2005 (module selection List)
                        Case CommonFunction.Constants.APP_TAG_MODULE_SELECTION_LIST
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.ColIndex = 1 Then
                                Dim strHTML As String = ""
                                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                ''strHTML = CommonFunctions.HTMLControls.DrawTextBox("ModuleID", "ModuleID", value:="" & HttpContext.Current.Request("ModuleID"), IsHidden:=True, returnHTML:=True)
                                strHTML = CommonFunctions.HTMLControls.DrawTextBox("ModuleID", "ModuleID", value:="" & HttpContext.Current.Request("ModuleID"), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
                                CommonFunctions.General.WriteHTML(strHTML)
                            End If
                            '-------------------------------------------
                        Case CommonFunction.Constants.APP_TAG_MILESTONE_SELECTION_LIST
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.ColIndex = 1 Then
                                Dim strHTML As String = ""
                                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                ''strHTML = CommonFunctions.HTMLControls.DrawTextBox("MileStoneID", "MileStoneID", value:="" & HttpContext.Current.Request("MileStoneID"), IsHidden:=True, returnHTML:=True)
                                strHTML = CommonFunctions.HTMLControls.DrawTextBox("MileStoneID", "MileStoneID", value:="" & HttpContext.Current.Request("MileStoneID"), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
                                CommonFunctions.General.WriteHTML(strHTML)
                            End If
                            '-------------------------------------------
                        Case CommonFunction.Constants.APP_TAG_SUBPROJECT_SELECTION_LIST
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.ColIndex = 1 Then
                                Dim strHTML As String = ""
                                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                ''strHTML = CommonFunctions.HTMLControls.DrawTextBox("SubProjectID", "SubProjectID", value:="" & HttpContext.Current.Request("SubProjectID"), IsHidden:=True, returnHTML:=True)
                                strHTML = CommonFunctions.HTMLControls.DrawTextBox("SubProjectID", "SubProjectID", value:="" & HttpContext.Current.Request("SubProjectID"), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
                                CommonFunctions.General.WriteHTML(strHTML)
                            End If
                            '-------------------------------------------
                        Case CommonFunction.Constants.APP_TAG_TASKTYPE_SELECTION_LIST
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.ColIndex = 1 Then
                                Dim strHTML As String = ""
                                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                ''strHTML = CommonFunctions.HTMLControls.DrawTextBox("TaskTypeID", "TaskTypeID", value:="" & HttpContext.Current.Request("TaskTypeID"), IsHidden:=True, returnHTML:=True)
                                strHTML = CommonFunctions.HTMLControls.DrawTextBox("TaskTypeID", "TaskTypeID", value:="" & HttpContext.Current.Request("TaskTypeID"), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
                                CommonFunctions.General.WriteHTML(strHTML)
                            End If
                            '-------------------------------------------
                        Case CommonFunction.Constants.APP_TAG_PHASE_SELECTION_LIST
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.ColIndex = 1 Then
                                Dim strHTML As String = ""
                                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                ''strHTML = CommonFunctions.HTMLControls.DrawTextBox("ProjectPhaseID", "ProjectPhaseID", value:="" & HttpContext.Current.Request("ProjectPhaseID"), IsHidden:=True, returnHTML:=True)
                                strHTML = CommonFunctions.HTMLControls.DrawTextBox("ProjectPhaseID", "ProjectPhaseID", value:="" & HttpContext.Current.Request("ProjectPhaseID"), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
                                CommonFunctions.General.WriteHTML(strHTML)
                            End If
                            'End Added by HarshK for sp4 issueid 200
                            '##### Case Added By AmitD on 25 Aug 2004 For Deliverables Selection List
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLES_SELECTION_LIST
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            'Added By JayavantK on 21-Sep-2004
                            If Args.ColIndex = 1 Then
                                Dim strHTML As String = ""
                                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                ''strHTML = CommonFunctions.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", value:="" & HttpContext.Current.Request("DeliverableID"), IsHidden:=True, returnHTML:=True)
                                strHTML = CommonFunctions.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", value:="" & HttpContext.Current.Request("DeliverableID"), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
                                CommonFunctions.General.WriteHTML(strHTML)
                            End If
                            'End Addition
                            '##### End Addition
                            'added by SachinR   on 26 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_PRACTICE_SELECTION, CommonFunction.Constants.APP_TAG_ASSOCIATED_ACTIVITIES
                            'Added by vidyaJ - issueID - 11093
                            Dim drAccessRights As IDataReader
                            Dim strQuery As String
                            Dim intPostId As Integer
                            Dim intUserId As Integer
                            Dim strLoginType As String
                            Dim intProjectID As Integer
                            Dim blnAddRight As Boolean
                            Dim blnEditRight As Boolean
                            intPostId = CType(HttpContext.Current.Session("intPostID"), Integer)
                            intUserId = CType(HttpContext.Current.Session("intUserID"), Integer)
                            strLoginType = CType(HttpContext.Current.Session("LoginType"), String)
                            intProjectID = CType(HttpContext.Current.Session("intProjectID"), Integer)

                            strQuery = "Exec usp_Sel_tbl_UI_NodeAccess 2175 ," & intPostId.ToString & "," & intUserId.ToString & ",'" & strLoginType & "'," & intProjectID.ToString
                            drAccessRights = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If CommonFunctions.General.CheckIsNothing(drAccessRights) <> "" Then
                                drAccessRights.Read()
                                blnAddRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("A"), "False"), Boolean)
                                blnEditRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("E"), "False"), Boolean)

                            End If
                            If Args.ColumnName.ToUpper = "COPY" Then
                                If blnAddRight = False Then
                                    Cancel = True
                                End If
                            End If
                            'Added By JyotiG
                            'Start_JG_11498_15-Mar-2007
                            'Issue : Role Asscess is not working for Execution Template
                            If Args.DataField.ToLower = "hyperlink1" Then
                                If (blnAddRight = False) And (blnEditRight = False) Then
                                    Cancel = True
                                End If
                            End If
                            'End_JG_11498_15-Mar-2007
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            CommonFunctions.Data.DisposeDataReader(drAccessRights)
                        Case CommonFunction.Constants.APP_TAG_SELECT_TEMPLATE
                            'change the caption of the delete column to select to select template 
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Select"
                            End If
                            'addition end

                            'added by SachinR   on 10 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_PHASETASK_REVISION
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_PHASETASK_TEMPLATE_REVISION_1, CommonFunction.Constants.APP_TAG_PHASETASK_TEMPLATE_REVISION_2
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'addition end

                            '    'added by DiptiK   on 15 Sep 2004
                            'Case CommonFunction.Constants.APP_TAG_CNF_SERVICE_SEGMENATATION
                            '    Select Case Args.ColumnName.ToUpper
                            '        Case "SERVICEOFFERINGNAME", " SUBSERVICEOFFERINGNAME"
                            '            Args.ApplySorting = False
                            '    End Select
                            '    'addition end
                            'added by SachinR   on 14 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_CONFIGURE_OU
                            If Args.ColumnName.ToUpper = "LOCATIONNAME" Then
                                Cancel = True
                            ElseIf Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'addition end
                            'added by SachinR   on 15 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_ADD_PROCESS_TO_OU
                            If Args.ColumnName.ToUpper = "DUMMYCOLUMN" Then
                                Cancel = True
                            ElseIf Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Select"
                            End If
                            'addition end

                            'Added by ShamkantD on 16 Sep 2004 - for Select Cost Heads page (called from Project Costs)
                        Case CommonFunction.Constants.APP_TAG_TAB_SELECT_COST_HEADS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Select"
                            End If
                            'End of addition - ShamkantD on 16 Sep 2004

                            'added by SachinR   on 17 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_ADD_METRIC_TO_OU
                            If Args.ColumnName.ToUpper = "DUMMYCOLUMN" Then
                                Cancel = True
                            ElseIf Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Select"
                            End If
                        Case CommonFunction.Constants.APP_TAG_ADD_PMI_TO_OU
                            If Args.ColumnName.ToUpper = "DUMMYCOLUMN" Then
                                Cancel = True
                            ElseIf Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Select"
                            End If
                            'addition end

                            'Added by ShamkantD on 5 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_BUSINESS_GROUP
                            'Added for Select Middle Level Resources for Business Group
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Select"
                            End If
                            'End of addition - ShamkantD on 5 Oct 2004

                            'Added by ShamkantD on 6 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_ORGANIZATION_UNIT
                            'Added for Select Middle Level Resources for Organization Unit
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Select"
                            End If

                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_DELIVERY_UNIT
                            'Added for Select Middle Level Resources for Delivery Unit
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Select"
                            End If

                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_DELIVERY_TEAM
                            'Added for Select Middle Level Resources for Delivery Team
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = "Select"
                            End If
                            'End of addition - ShamkantD on 6 Oct 2004
                            'added by SachinR   on 12 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_MAIN_DELIVERABLE_TYPES
                            'hide the dummy column to show custom link on another column
                            If Args.ColumnName.ToUpper = "DUMMYCOLUMN" Or Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'addition end

                            'Code added By VidyaJ on 16th Oct 2004
                            'Remove Delete checkbox
                        Case CommonFunction.Constants.APP_TAG_ISSUE_CODEGENERATION
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End of addition
                            'Added By JayavantK on 18-Oct-2004  --- Issue ID = 12723
                        Case CommonFunction.Constants.APP_TAG_BUSINESS_GROUP, CommonFunction.Constants.APP_TAG_ORGANIZATION_UNIT,
                             CommonFunction.Constants.APP_TAG_DELIVERY_UNIT, CommonFunction.Constants.APP_TAG_DELIVERY_TEAM
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End Addition 

                            'added by SachinR   on 20 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLETYPE_RESOURCE_ACCESS
                            'change the caption of Delete column to select
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                Args.ColumnName = objTemplate.GetResourceString("SELECT")
                                objTemplate = Nothing

                                'added by SachinR   on 17 Nov 2004
                                'issue - 13955
                            ElseIf Args.ColumnName.ToUpper = "DUMYCOLUMN" Then
                                Cancel = True
                                'addition end
                            End If
                            'addition end
                            ' added by NitinVS on 18 Nov 2004
                            ' To remove sorting on Mandatory Field

                        Case CommonFunction.Constants.APP_TAG_QUESTION_SELECTION_LIST
                            If Args.DataField.ToUpper = "MANDATORY" Then
                                Args.ApplySorting = False
                            End If
                            'addition end
                            ' Added By NitinVS on 7 Dec 2004 
                            ' To Remove Delete Colummn  Header
                        Case CommonFunction.Constants.APP_TAG_SELECT_TEMPLATE_FOR_PROJECT
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            ' End Addition NitinVS 7 Dec 2004

                            ' Added By PrachiK on 28 Mar 2005 
                            ' To Remove Link for CheckList name column
                        Case CommonFunction.Constants.APP_TAG_SELECT_CHECKLIST_FOR_PROJECT
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If


                            ' End Addition PrachiK

                            ' Code added by SwapnilR on 13th Dec 2004
                        Case CommonFunction.Constants.APP_TAG_ROLE_ACCESS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            ' End of code addtion by SwapnilR

                            'Added by MrugajaB on 2 Mar,2005 for Project Document Category
                        Case CommonFunction.Constants.APP_TAG_PROJECT_DOCUMENTCATEGORY
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                'Modified By NitinVS on 2 Apr 2005 for PBNTIE SP2 IssueId = 17136 
                                ' Changed the Column Caption from Configure to Select
                                Args.ColumnName = "Select"
                                'End Modification By NitinVS on 2 Apr 2005 for PBNITE SP2 IssueID = 17136
                            End If
                            If Args.ColumnName.ToUpper = "USED" Then
                                Cancel = True
                            End If

                            If Args.ColumnName.ToUpper = "DOCUMENT CATEGORY" Then
                                Args.ApplySorting = False
                            End If
                            'End Addition
                            ' added by harshada d for checklist issue fixes if role doesnt have add or delete access rhen copy and publish links should not be displayed
                        Case CommonFunction.Constants.APP_TAG_PROJECT_CHECKLIST
                            Dim drAccessRights As IDataReader
                            Dim strQuery As String
                            Dim intPostId As Integer
                            Dim intUserId As Integer
                            Dim strLoginType As String
                            Dim intProjectID As Integer
                            Dim blnAddRight As Boolean
                            Dim blnEditRight As Boolean
                            intPostId = CType(HttpContext.Current.Session("intPostID"), Integer)
                            intUserId = CType(HttpContext.Current.Session("intUserID"), Integer)
                            strLoginType = CType(HttpContext.Current.Session("LoginType"), String)
                            intProjectID = CType(HttpContext.Current.Session("intProjectID"), Integer)

                            strQuery = "Exec usp_Sel_tbl_UI_NodeAccess 2263 ," & intPostId.ToString & "," & intUserId.ToString & ",'" & strLoginType & "'," & intProjectID.ToString
                            drAccessRights = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If CommonFunctions.General.CheckIsNothing(drAccessRights) <> "" Then
                                drAccessRights.Read()
                                blnAddRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("A"), "False"), Boolean)
                                blnEditRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("E"), "False"), Boolean)

                            End If
                            CommonFunctions.Data.DisposeDataReader(drAccessRights)

                            ' Modified By NitinVs on 23 Apr 2007 for WhizibleSEM SP 8 regression Fiexes Issue 12367 
                            ' Tocheck add access for COPY and EDIT Access for PUBLISH 

                            If Args.ColumnName.ToUpper = "COPY" Then
                                If (blnAddRight = True) Then
                                Else
                                    Cancel = True
                                End If
                            End If
                            'end of addition by harshada
                            If Args.ColumnName.ToUpper = "PUBLISH" Then
                                If (blnEditRight = True) Then
                                Else
                                    Cancel = True
                                End If
                            End If
                            ' End Addition  By NitinVs on 23 Apr 2007 for WhizibleSEM SP 8 regression Fiexes Issue 12367 

                            'Code Integrated by MrugajaB on 4th May,2005 for WhizibleSEM SP3 Task Progress feature
                            ' Code added by SwapnilR on 5th April 2005
                        Case CommonFunction.Constants.APP_TAG_PENDING_DELIVERABLE_TASK_DETAILS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            ' End of code addition by SwapnilR on 5th April 2005
                            ' Code added by PradipK on 8th April 2005
                        Case CommonFunction.Constants.APP_TAG_PENDING_TASK_PROGRESS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            ' End of code addition by PradipK on 8th April 2005

                            'End Integration



                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_SUBTAG_ROLE, CommonFunction.Constants.APP_SUBTAG_RESOURCE
                            'Added By Paresh B on August 4, 2004
                            Dim strSQL As String
                            Dim drRateContractLabel As IDataReader

                            If Args.ColumnName = "RateForID" Then

                                strSQL = "SELECT Case Contracttype When 2 THEN 'Resource' WHEN 3 THEN 'Role' End FROM tbl_PM_Project WHERE ProjectID = " & HttpContext.Current.Session("intProjectId").ToString

                                drRateContractLabel = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drRateContractLabel.Read() Then
                                    If Not IsDBNull(drRateContractLabel(0)) Then Args.ColumnName = drRateContractLabel(0).ToString
                                End If
                                drRateContractLabel = Nothing
                            End If
                            If Args.ColumnName = "Rate" Then

                                strSQL = "SELECT Case RateMethod When 'H' THEN 'Man Hour Rate' WHEN 'D' THEN 'Man Day Rate' WHEN 'M' THEN 'Man Month Rate' End FROM tbl_PM_WorkOrderRateContract WHERE ProjectID = " & HttpContext.Current.Session("intProjectId").ToString

                                drRateContractLabel = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drRateContractLabel.Read() Then
                                    If Not IsDBNull(drRateContractLabel(0)) Then
                                        Args.ColumnName = drRateContractLabel(0).ToString
                                    Else
                                        Args.ColumnName = "Man Hour Rate"
                                    End If

                                End If

                                ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                'drRateContractLabel = Nothing
                                CommonFunction.Data.DisposeDataReader(drRateContractLabel)
                                ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                            End If
                        Case CommonFunction.Constants.APP_TAG_TAB_TEMPLATES
                            If Args.DataField.ToLower = "description" Then Cancel = True
                        Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEREQUEST_SKILLS_VIEW
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_TAB_CAPTIONS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            '' ***************************************************************************/
                            '' Integrated On 10-Feb-2006 By ParagD for Whiz 2   

                            '' Added By ParagD On 27-Dec-2005
                            '' Purpose : 22067 Nucleus - Role access for parent tag in project module.(Taining plan)
                        Case CommonFunction.Constants.APP_TAG_TAB_TRAINING_RESOURCES
                            If Args.DataField.ToUpper = "HYPERLINK1" Then
                                Dim strSql As String
                                Dim strIsRoleAccess As String
                                strSql = "usp_GetRoleAccessDetails_ForResourceTab " & CType(HttpContext.Current.Session("intProjectId"), String) & "," & CType(HttpContext.Current.Session("intUserID"), String)
                                strIsRoleAccess = CType(CommonFunctions.Data.GetDataScalar(strSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
                                If strIsRoleAccess = "0" Then
                                    Cancel = True
                                End If
                            End If
                            '' END : Added By ParagD On 27-Dec-2005 

                            '' Integrated On 10-Feb-2006 By ParagD for Whiz 2
                            '' ***************************************************************************/

                            'Added by DipaliS
                        Case CommonFunction.Constants.APP_TAG_TAB_RATECONTRACTBYROLE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            Dim strSQL As String
                            Dim drContractType As IDataReader
                            'Get the caption for RateForName depending upon contract type
                            If Args.ColumnName.ToUpper = "RATEFORNAME" Then
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                Dim strRateFor As String = ""
                                Dim strProjectID As String
                                Dim intContractType As Integer
                                strProjectID = HttpContext.Current.Session("intProjectID").ToString
                                strSQL = "SELECT ContractType FROM tbl_PM_Project WHERE ProjectID = " & CommonFunctions.General.BuildQueryString(strProjectID)
                                drContractType = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drContractType.Read Then
                                    intContractType = CType(CommonFunctions.General.CheckIsNothing(drContractType("ContractType")), Integer)
                                    Select Case intContractType
                                        Case CommonFunction.Constants.RATECONTRACTTYPE.CONTRACT_BY_ROLE
                                            strRateFor = objTemplate.GetResourceString("PROJECT_RATE_CONTRACT_ROLE")
                                        Case CommonFunction.Constants.RATECONTRACTTYPE.CONTRACT_BY_RESOURCE
                                            strRateFor = objTemplate.GetResourceString("PROJECT_RATE_CONTRACT_RESOURCE")
                                    End Select
                                End If

                                ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                CommonFunction.Data.DisposeDataReader(drContractType)
                                ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                If strRateFor <> "" Then
                                    Cancel = True
                                    Args.StringToBeInserted = "<td>" & strRateFor & "</td>"
                                End If
                                objTemplate = Nothing
                            End If
                            'Get the caption for RATEYEAR1 depending upon rate type
                            If Args.ColumnName.ToUpper = "RATE FOR CONTRACT YEAR" Then
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                Dim strRateType As String = ""
                                Dim strProjectID As String
                                Dim strRate As String
                                strProjectID = HttpContext.Current.Session("intProjectID").ToString
                                strSQL = "SELECT RateMethod FROM tbl_pm_workorderratecontract WHERE ProjectID = " & CommonFunctions.General.BuildQueryString(strProjectID)
                                drContractType = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drContractType.Read Then
                                    strRate = CType(CommonFunctions.General.CheckIsNothing(drContractType("RateMethod")), String)
                                    Select Case strRate
                                        Case "D"
                                            strRateType = objTemplate.GetResourceString("PROJECT_RATE_CONTRACT_MANDAYRATE")
                                        Case "H"
                                            strRateType = objTemplate.GetResourceString("PROJECT_RATE_CONTRACT_MANHOURRATE")
                                        Case "M"
                                            strRateType = objTemplate.GetResourceString("PROJECT_RATE_CONTRACT_MANMONTHRATE")
                                    End Select
                                End If
                                If strRateType <> "" Then
                                    Cancel = True
                                    Args.StringToBeInserted = "<td>" & strRateType & "</td>"
                                End If
                                objTemplate = Nothing
                            End If
                            CommonFunctions.Data.DisposeDataReader(drContractType)

                            '' Commented By ParagD On 10-Nov-2005
                            '' Empower - IssueID 20249 - Delete button does not exists on Employee Leave Details
                            'Case CommonFunction.Constants.APP_TAG_TAB_EMPLOYEE_LEAVE_DETAILS
                            '    If Args.ColumnName.ToUpper = "DELETE" Then
                            '        Cancel = True
                            '    End If
                            '' End of comments By ParagD On 10-Nov-2005
                            'Case CommonFunction.Constants.APP_TAG_TAB_CONFIGURE_RFI_ITEM_ATTRIBUTES
                            '    If Args.ColumnName.ToUpper = "DELETE" Then
                            '        Cancel = True
                            '    End If

                            'Added By JayavantK on 30/07/04
                        Case CommonFunction.Constants.APP_TAG_TAB_OUPOOLMASTER_RESOURCE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_OUPOOL_RESOURCE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            ''' '''Added by PrashantSJ on 17th July 2007 For WhizibleSEM 7.0
                            ''Purpose: To change the Amount column with currencycode
                        Case CommonFunction.Constants.APP_SUBTAG_INVOICE_PAYMENT_RECEIPT
                            If Args.ColumnName.ToUpper = "AMOUNT" Then
                                Dim m_strCurrencyCode As String = ""
                                Dim sSQL As String = ""

                                sSQL = "usp_Sel_InvoiceDetails " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("InvoiceID_PK"), "0") & " ,'BIL_CUR_CODE'"
                                m_strCurrencyCode = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(sSQL, True), ""), String)
                                Args.ColumnName = "Amount (" & m_strCurrencyCode & ")"
                            End If
                            ''End of addition by PrashantSJ on 17th July 2007 For WhizibleSEM 7.0
                            'Modified by TruptiK on 19-Jan-2008
                        Case CommonFunction.Constants.APP_TAG_TAB_ASSIGNEDRESOURCES, CommonFunction.Constants.APP_TAG_TAB_EXTENDASSIGNEDRESOURCES
                            'End of modification by TruptiK
                            objTemplate = New WebPage.Templates.WhizTemplate
                            objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Args.ColumnName = objTemplate.GetResourceString("SELECT")
                            End If
                            objTemplate = Nothing

                        Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEPOOL_RESOURCES
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_TEAMPOOL_RESOURCES
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEPOOL_TEAM
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            'Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEPOOL_MANAGER
                            '    If Args.ColumnName.ToUpper = "DELETE" Then
                            '        Cancel = True
                            '    End If

                        Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEPOOL_RESOURCE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            'End Of addition

                            'Added By JayavantK on 31/07/04
                        Case CommonFunction.Constants.APP_TAG_TAB_BUSINESSGROUP_RESOURCES
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End Of addition
                            'Added By JayavantK on 4-Aug-04
                        Case CommonFunction.Constants.APP_TAG_TAB_BGPOOL_RESOURCE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End Of addition
                            'Added By NileshD on 6 August 2004
                            'To resolve issueid = 12240
                        Case CommonFunction.Constants.APP_TAG_TAB_CONTRACT_ATTACHAMENTS
                            If Args.DataField.ToUpper = "DESCRIPTION" Then
                                Args.ApplySorting = False
                            End If
                            'End Of Addition
                            'Added By NileshD on 12 August 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_CONTRACT_VIEW_ATTACHMENT
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.DataField.ToUpper = "DESCRIPTION" Then
                                Args.ApplySorting = False
                            End If
                            'End Of Addition
                            'added by SachinR   on 21 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_DELIVERABLES_TASKS
                            If Args.ColumnName.ToUpper = "TASKID" Then
                                Cancel = True
                            ElseIf Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'addition end

                            ''integration by harshada d on 15th june 2006
                            '		'Integrated By PrajaktaR for WhizibleSEM 6.0.1 IssueID 3736
                            '                     'added by harshk on 21/07/2005
                            '                     'to remove delete caption from grid header for inherited checkList
                        Case CommonFunction.Constants.APP_TAG_TAB_PROJECT_CHECKLISTITEM
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Dim drIsInherited As IDataReader
                                Dim strSQLQuery As String
                                Dim strProjectCheckListID_PK As String
                                strProjectCheckListID_PK = CType(HttpContext.Current.Session("ProjectCheckListID_PK"), String)
                                If Args.ColumnName.ToUpper = "DELETE" Then
                                    strSQLQuery = "EXEC usp_Sel_tbl_PM_WorkOrderChecklist_IsInherited " & strProjectCheckListID_PK
                                    drIsInherited = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
                                    If drIsInherited.Read Then
                                        Cancel = True
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(drIsInherited)
                                End If
                            End If
                            '                     'end harshk on 21/07/2005
                            '                     'added by harshk on 22/07/2005
                            '                     'to remove delete caption from grid header for inherited checkList
                        Case CommonFunction.Constants.APP_TAG_TAB_PROJECT_CHECKLIST_SECTIONS
                            'end harshk on 22/07/2005
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Dim drIsInherited As IDataReader
                                Dim strSQLQuery As String
                                Dim strProjectCheckListID_PK As String
                                strProjectCheckListID_PK = CType(HttpContext.Current.Session("ProjectCheckListID_PK"), String)
                                If Args.ColumnName.ToUpper = "DELETE" Then
                                    strSQLQuery = "EXEC usp_Sel_tbl_PM_WorkOrderChecklist_IsInherited " & strProjectCheckListID_PK
                                    drIsInherited = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
                                    If drIsInherited.Read Then
                                        Cancel = True
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(drIsInherited)
                                End If
                            End If

                            'END Of Integration by PrajaktaR for WhizibleSEM 6.0.1 IssueID 3736 

                            ''end of integration by harshada d on 15th june 2006
                            'added by SachinR   on 26 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_ASSOCIATED_PHASE_TASK
                            '--- Code added by Nilesh on 19 May 
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Dim strCopyTemplateID As String
                                Dim drTemplate As IDataReader
                                Dim strSQLtemp As String
                                Dim blnIsCopyTemplate As Boolean = False

                                'strCopyTemplateID = HttpContext.Current.Request.QueryString("ProjectPhaseTaskTemplateID_PK")      'CommonFunctions.General.GetQuerySrtingValues 

                                strCopyTemplateID = CType(HttpContext.Current.Session("ProjectPhaseTaskTemplateID_PK_Copy"), String)

                                strSQLtemp = "Select IsCopyTemplate from tbl_PM_Project_PhaseTask_Template "
                                strSQLtemp = strSQLtemp & " Where ProjectPhaseTaskTemplateID = " & strCopyTemplateID

                                drTemplate = CommonFunctions.Data.GetDataReader(strSQLtemp, True)
                                If drTemplate.Read Then
                                    blnIsCopyTemplate = CType(CommonFunctions.Data.CheckIsDBNull(drTemplate.Item("IsCopyTemplate"), "0"), Boolean)
                                End If

                                ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                CommonFunction.Data.DisposeDataReader(drTemplate)
                                ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                If blnIsCopyTemplate = False Then
                                    Cancel = True
                                End If
                            End If
                            '--- Addition ends

                            'addition end
                            'added by SachinR   on 31 Aug 2004

                            'PBNITE SP2
                            ' Added By NitinVS on 9 Feb 2005 
                            ' To hide the distriution link 
                            If Args.ColumnName.ToUpper = "DISTRIBUTION" Then

                                Dim blnHaveSubTaskTypes As Boolean
                                Dim strSQL As String

                                strSQL = "SELECT HaveSubTaskTypes FROM tbl_PM_Project WHERE ProjectID = " + HttpContext.Current.Session("intProjectId").ToString

                                blnHaveSubTaskTypes = CType(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Boolean)

                                If blnHaveSubTaskTypes = False Then
                                    Cancel = True
                                End If
                            End If
                            'PBNITE SP2
                            ' End Addition By nitinVS on 9 Feb 2005 

                        Case CommonFunction.Constants.APP_TAG_TAB_SOFTEX_FORM
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'addition end

                            'added by SachinR   on 1 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_PHASETASK_ACTIVITY
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'addition end
                            'added by SachinR   on 03 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_DELIVERABLE_FIELDS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'addition end

                            'Added BY JayavantK, On 7-Sep-2004
                        Case CommonFunction.Constants.APP_TAG_TAB_OUPOOL_DELIVERYUNIT
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_TAB_BUSINESSGROUP_OUPOOLS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End Addition
                            'added by SachinR   on 10 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_PHASETASK_REVISION, CommonFunction.Constants.APP_TAG_TAB_PHASETASK_TEMPLATE_REVISION
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_PUBLISH_PHASETASK_DOCUMENTS
                            If Args.ColumnName.ToUpper = "FILENAME" Then
                                Cancel = True
                            End If
                            'addition end

                            '##### Onsite Offshore functionality
                        Case CommonFunction.Constants.APP_TAG_TAB_SITESROLERATE
                            'Code Added By VidyaJ on Aug 12th 2004
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_TAB_SITESROLERATE
                            'Code Added By VidyaJ on Aug 12th 2004
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'Added By VidyaJ on 10th Feb 2005 - For IssueID - 15374
                        Case CommonFunction.Constants.APP_TAG_TAB_FASTTRACKREVIEW_ISSUES
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End of Addition

                            'Integrated By MrugajaB on 25th Apr 2005 for WhizibleSEM SP3
                            ' Code Added by RajkumarM ONSITE on 21st March 05
                        Case CommonFunction.Constants.APP_TAG_TAB_REVIEW_ACTIONS
                            Dim strQuery As String = ""
                            Dim drReviewDetails As IDataReader
                            Dim m_strReviewstatisticsID As String
                            Dim m_strReviewStatus As String = ""
                            m_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ReviewStatisticsID_PK")
                            If m_strReviewstatisticsID = "" Then
                                m_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ForeignKeyValue")
                            End If
                            If m_strReviewstatisticsID = "" Then
                                m_strReviewstatisticsID = HttpContext.Current.Request("ReviewStatisticsID_PK")
                            End If



                            If m_strReviewstatisticsID <> "" Then
                                strQuery = "Select ReviewStatus from tbl_pm_reviewstatistics Where ReviewStatisticsID= " + m_strReviewstatisticsID
                                drReviewDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If CommonFunctions.General.CheckIsNothing(drReviewDetails, "") <> "" Then
                                    If drReviewDetails.Read() Then
                                        m_strReviewStatus = CType(CommonFunctions.Data.CheckIsDBNull(drReviewDetails("ReviewStatus"), ""), String)
                                    End If
                                End If
                                CommonFunctions.Data.DisposeDataReader(drReviewDetails)
                            End If

                            If Args.DataField.ToUpper = "ADD ISSUE" Or Args.DataField.ToUpper = "ADD TASK" Then
                                If m_strReviewStatus.ToUpper = "CLOSED" Then
                                    Cancel = True
                                End If
                            End If
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                If m_strReviewStatus.ToUpper = "CLOSED" Then
                                    Cancel = True
                                End If
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_REVIEW_OBSERVATIONS

                            Dim strQuery As String = ""
                            Dim drReviewDetails As IDataReader
                            Dim m_strReviewstatisticsID As String
                            Dim m_strReviewStatus As String = ""
                            m_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ReviewStatisticsID_PK")
                            If m_strReviewstatisticsID = "" Then
                                m_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ForeignKeyValue")
                            End If
                            If m_strReviewstatisticsID = "" Then
                                m_strReviewstatisticsID = HttpContext.Current.Request("ReviewStatisticsID_PK")
                            End If

                            If m_strReviewstatisticsID <> "" Then
                                strQuery = "Select ReviewStatus from tbl_pm_reviewstatistics Where ReviewStatisticsID= " + m_strReviewstatisticsID
                                drReviewDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If CommonFunctions.General.CheckIsNothing(drReviewDetails, "") <> "" Then
                                    If drReviewDetails.Read() Then
                                        m_strReviewStatus = CType(CommonFunctions.Data.CheckIsDBNull(drReviewDetails("ReviewStatus"), ""), String)
                                    End If
                                End If
                                CommonFunctions.Data.DisposeDataReader(drReviewDetails)
                            End If

                            If Args.DataField.ToUpper = "CONVERT TO ACTION POINT" Then
                                If m_strReviewStatus.ToUpper = "CLOSED" Then
                                    Cancel = True
                                End If

                            End If

                            If Args.ColumnName.ToUpper = "DELETE" Then
                                If m_strReviewStatus.ToUpper = "CLOSED" Then
                                    Cancel = True
                                End If
                            End If

                            ' End of Addition ONSITE on 21st March 05
                            'End Integration

                            'Added By MrugajaB on 31st May 2005 for WhizibleSEM SP3 Issue ID.18126
                        Case CommonFunction.Constants.APP_TAG_TAB_FASTTRACKREVIEW_ACTIONS

                            Dim strQuery As String = ""
                            Dim drReviewDetails As IDataReader
                            Dim m_strReviewstatisticsID As String
                            Dim m_strReviewStatus As String = ""
                            m_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ReviewStatisticsID_PK")
                            If m_strReviewstatisticsID = "" Then
                                m_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ForeignKeyValue")
                            End If
                            If m_strReviewstatisticsID = "" Then
                                m_strReviewstatisticsID = HttpContext.Current.Request("ReviewStatisticsID_PK")
                            End If

                            If m_strReviewstatisticsID <> "" Then
                                strQuery = "Select ReviewStatus from tbl_pm_reviewstatistics Where ReviewStatisticsID= " + m_strReviewstatisticsID
                                drReviewDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If CommonFunctions.General.CheckIsNothing(drReviewDetails, "") <> "" Then
                                    If drReviewDetails.Read() Then
                                        m_strReviewStatus = CType(CommonFunctions.Data.CheckIsDBNull(drReviewDetails("ReviewStatus"), ""), String)
                                    End If
                                End If
                                CommonFunctions.Data.DisposeDataReader(drReviewDetails)
                            End If

                            If Args.DataField.ToUpper = "HYPERLINK1" Or Args.DataField.ToUpper = "HYPERLINK2" Then
                                If m_strReviewStatus.ToUpper = "CLOSED" Then
                                    Cancel = True
                                End If
                            End If

                            If Args.ColumnName.ToUpper = "DELETE" Then
                                If m_strReviewStatus.ToUpper = "CLOSED" Then
                                    Cancel = True
                                End If
                            End If

                            'Modified By VidyaJ - DA Performance Issue - IssueID - 89
                        Case CommonFunction.Constants.APP_TAG_TAB_PHASE_TASKS, CommonFunction.Constants.APP_TAG_TAB_MODULE_TASKS, CommonFunction.Constants.APP_TAG_TAB_MILESTONE_TASKS, CommonFunction.Constants.APP_TAG_TAB_SUBPROJECT_TASKS, CommonFunction.Constants.APP_TAG_TAB_DELIVERABLE_TASKS, CommonFunction.Constants.APP_TAG_TAB_CHANGEREQUEST_TASKS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End Of Modifications - IssueID - 89

                        Case CommonFunction.Constants.APP_TAG_TAB_FAST_TRACK_REVIEW_DOCUMENTS
                            'Dim strQuery As String = ""
                            'Dim drReviewDetails As IDataReader
                            'Dim m_strReviewstatisticsID As String
                            'Dim m_strReviewStatus As String = ""
                            'm_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ReviewStatisticsID_PK")
                            'If m_strReviewstatisticsID = "" Then
                            '    m_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ForeignKeyValue")
                            'End If
                            'If m_strReviewstatisticsID = "" Then
                            '    m_strReviewstatisticsID = HttpContext.Current.Request("ReviewStatisticsID_PK")
                            'End If

                            'If m_strReviewstatisticsID <> "" Then
                            '    strQuery = "Select ReviewStatus from tbl_pm_reviewstatistics Where ReviewStatisticsID= " + m_strReviewstatisticsID
                            '    drReviewDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '    If CommonFunctions.General.CheckIsNothing(drReviewDetails, "") <> "" Then
                            '        If drReviewDetails.Read() Then
                            '            m_strReviewStatus = CType(CommonFunctions.Data.CheckIsDBNull(drReviewDetails("ReviewStatus"), ""), String)
                            '        End If
                            '    End If
                            '    CommonFunctions.Data.DisposeDataReader(drReviewDetails)
                            'End If

                            'If Args.DataField.ToUpper = "HYPERLINK1" Or Args.DataField.ToUpper = "HYPERLINK2" Then
                            '    If m_strReviewStatus.ToUpper = "CLOSED" Then
                            '        Cancel = True
                            '    End If
                            'End If

                            'If Args.ColumnName.ToUpper = "DELETE" Then
                            '    If m_strReviewStatus.ToUpper = "CLOSED" Then
                            '        Cancel = True
                            '    End If
                            'End If

                            'End Addition

                        Case CommonFunction.Constants.APP_TAG_TAB_PROJECT_MAPPING
                            If Args.ColumnName.ToUpper = "ALLOWDELETE" Then
                                Cancel = True
                            End If

                            'Addition done by SuchitraP on 16-MAY-2007 for Cleanup Activity
                        Case CommonFunction.Constants.APP_TAG_TAB_LEAVES
                            'Dim myQuery As String = ""
                            'Dim blnIsProRataEnabled As Boolean = False
                            'myQuery = "SELECT ISNULL(IsProRataEnabled,0) FROM tbl_PM_CompanyInformation"
                            'blnIsProRataEnabled = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(myQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Boolean)
                            'If blnIsProRataEnabled = False Then
                            If CommonFunction.Application.IsProRataEnabled = False Then
                                If Args.ColumnName = "Pro-Rata" Then
                                    Cancel = True
                                End If
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_EMPLOYEE_LEAVE_DETAILS
                            'Dim myQuery As String = ""
                            'Dim blnIsProRataEnabled As Boolean = False
                            'myQuery = "SELECT ISNULL(IsProRataEnabled,0) FROM tbl_PM_CompanyInformation"
                            'blnIsProRataEnabled = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(myQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Boolean)
                            'If blnIsProRataEnabled = False Then
                            If CommonFunction.Application.IsProRataEnabled = False Then
                                If Args.ColumnName = "Pro-Rata" Then
                                    Cancel = True
                                End If
                            End If
                            'End of addition done by SuchitraP for Cleanup Activity


                    End Select
                End If
            End Sub

            Public Shared Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)

                Cancel = False

                'This Event will occur before 
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID


                        'Added Case For Quesitons List Page 21 Aug 2004
                        'Added by TruptiK on 9-Dec-08
                        'Purpose:-To remove double names.
                        'Case CommonFunction.Constants.APP_TAG_REQUEST_APPROVERS

                        '    If m_Employee_Approver <> Args.DataReader("EmployeeName").ToString.Trim Then
                        '        m_Employee_Approver = Args.DataReader("EmployeeName").ToString.Trim + ""
                        '    Else
                        '        Cancel = True
                        '    End If

                        'End of addition by TruptiK on 9-Dec-08
                        Case CommonFunction.Constants.APP_TAG_QUESTION_SELECTION_LIST
                            Dim strSQL As String
                            Dim drGetQuestions As IDataReader
                            Dim strQuestionIDs As String
                            Dim strQuestionireID As String
                            'If CType(HttpContext.Current.Session("strQuestionireID"), String) = "" Then
                            'HttpContext.Current.Session("strQuestionireID") = CType(HttpContext.Current.Request.QueryString("QuestionireID"), String)
                            'End If

                            If CType(HttpContext.Current.Request.QueryString("QuestionireID"), String) <> "" Then
                                HttpContext.Current.Session("strQuestionireID") = CType(HttpContext.Current.Request.QueryString("QuestionireID"), String)
                            End If

                            If CType(HttpContext.Current.Session("strQuestionireID"), String) = "" Then
                                HttpContext.Current.Session("strQuestionireID") = "0"
                            End If

                            'If CType(strQuestionireID, String) = "" Then
                            '    strQuestionireID = "0"
                            'End If

                            'Integrated by NitinVS on 8 Aug 2007 for WhizibleSEM 7 
                            'Modified By GaneshG on 08-Aug-2007 For RequestID - 8183 
                            strSQL = "Select QuestionID from tbl_Q_QuestionnaireQuestion Where QuestionnaireID=" + CType(HttpContext.Current.Session("strQuestionireID"), String) + " AND QuestionID=" + CType(Args.DataReader("QuestionID"), String)
                            If CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))) <> "" Then
                                Cancel = True
                            End If

                            'strSQL = "Select * from tbl_Q_QuestionnaireQuestion Where QuestionnaireID=" + CType(HttpContext.Current.Session("strQuestionireID"), String)
                            'drGetQuestions = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            'While drGetQuestions.Read
                            '    strQuestionIDs = strQuestionIDs + CType(CommonFunctions.Data.CheckIsDBNull(drGetQuestions("QuestionID"), ""), String) + ","
                            'End While

                            'CommonFunctions.Data.DisposeDataReader(drGetQuestions)
                            'If strQuestionIDs = "" Then
                            '    strQuestionIDs = ","
                            'End If

                            'If InStr(strQuestionIDs, CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("QuestionID"), ""), String)) <> 0 Then
                            '    Cancel = True
                            'End If
                            'End Modification By GaneshG
                            'End Integrated by NitinVS on 8 Aug 2007 for WhizibleSEM 7 


                            'Added By VidyaJ - issueID - 11173
                        Case CommonFunction.Constants.APP_TAG_PROJECT_APPROVERS
                            If CStr(CommonFunction.Data.CheckIsDBNull(Args.DataReader("SentForApprovalBy"), "")) = CStr(CommonFunction.Data.CheckIsDBNull(Args.DataReader("UserName"), "")) Then
                                Cancel = True
                            End If



                            'End addition
                            ''Added by PrashantSJ on 6th June 2007 For WhizibleSEM 7.0 Build 3
                            ''Purpose: To display proper sr.no. (i.e 1,2..etc)
                        Case CommonFunction.Constants.APP_TAG_RFI_CHECKLIST_VIEW
                            m_iRowCount = m_iRowCount + 1

                            ''End of addition by PrashantSJ on 6th June 2007 
                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID



                    End Select
                End If
            End Sub

            Public Shared Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim objTemplate As WebPages.Template.WhizTemplate

                Cancel = False
                'This Event will occur before 
                If WhizGlobal.ParentTagID = 0 Then
                    If WhizGlobal.TagID = 32 Then

                        ''Added by Vaijat K ON 06/05/2106 For Performance Issue on Project List Page
                        If Args.ColumnName.ToUpper = "PROJECT PROGRESS" Then

                            Cancel = True
                            Dim strsql1 As String
                            Dim dr As IDataReader
                            Dim flag As Integer = 0
                            'Args.StringToBeInserted = "<TD align='center'><A href='javascript:myFunction(" & CStr(Args.DataReader.Item("ProjectID")) & ",'../Home/ShowProjectDetails.aspx','1234'," & CStr(Args.DataReader.Item("ProjectID")) & ");'> Quick view</A></TD>"
                            Dim intRoleAccessQuickview As Integer = 0
                            strsql1 = "usp_Sel_tbl_pm_role_QuickView_CheckAccess " & CommonFunction.General.CheckIsNothing(WhizGlobal.RoleID.ToString(), 0)
                            intRoleAccessQuickview = Convert.ToInt32(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strsql1, True), 0))

                            If intRoleAccessQuickview = 0 Then
                                'Args.ColumnName.Remove("PROJECT PROGRESS")
                                Args.StringToBeInserted = "<TD align='center' width='105px'><a style='text-decoration:none;' href='javascript:myFunction(" & CStr(Args.DataReader.Item("ProjectID")) & ",""" & " ../Home/ShowProjectDetails.aspx" & """,""" & "ProjectProgress" & """," & CStr(Args.DataReader.Item("ProjectID")) & ");'><img src='../../img/1920/Quickview.jpg' style='height:23px;width:23px' alt='Quick View' title='Quick View' /></a></td>"
                            ElseIf intRoleAccessQuickview = 1 Then

                            End If


                        End If
                        ''End of Addition Vaijat K
                        ''Commented By Vaijat K ON 06/05/2016 For Performance Issue
                        ' ''Added by Nilesh Gundecha on 27/10/2015 for quick View Plot access checking
                        'If Args.ColumnName.ToUpper = "PROJECT PROGRESS" Then
                        '    Dim strsql2 As String
                        '    Dim dr As IDataReader
                        '    Dim strsql4 As String
                        '    Dim blnAdd As Boolean
                        '    Dim blnDelete As Boolean
                        '    Dim blnEdit As Boolean
                        '    Dim blnView As Boolean
                        '    Dim blnRole As Integer

                        '    strsql4 = "usp_SelQuickView_tbl_PM_ROLE " & WhizGlobal.RoleID & ""
                        '    blnRole = CType(CommonFunctions.Data.GetDataScalar(strsql4, True), Integer)

                        '    strsql2 = "Exec usp_Sel_RoleAccess  " & WhizGlobal.RoleID.ToString() & "," & WhizGlobal.ParentTagID.ToString() & "," & WhizGlobal.TagID.ToString() & "," & WhizGlobal.UserID.ToString() & ""
                        '    dr = CommonFunctions.Data.GetDataReader(strsql2, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        '    While dr.Read()

                        '        blnAdd = CType(CommonFunctions.Data.CheckIsDBNull(dr("A"), "0"), Boolean)
                        '        blnDelete = CType(CommonFunctions.Data.CheckIsDBNull(dr("D"), "0"), Boolean)
                        '        blnEdit = CType(CommonFunctions.Data.CheckIsDBNull(dr("E"), "0"), Boolean)
                        '        blnView = CType(CommonFunctions.Data.CheckIsDBNull(dr("V"), "0"), Boolean)
                        '    End While

                        '    If (blnRole = 1 Or blnAdd = True Or blnEdit = True) Then

                        '        Dim ColumnName As String = Args.PrimaryKeyName
                        '        Dim PrimaryKeyValue As Integer = CStr(Args.DataReader.Item("" & ColumnName & ""))
                        '        ' Dim PrimaryKeyValue As String = Args.PrimaryKeyName

                        '        Dim strsql1 As String
                        '        Dim dr1 As IDataReader
                        '        Dim flag As Integer = 0
                        '        Dim ProjectID As Integer
                        '        strsql1 = "select TagID,PageName from tbl_PM_QuickView"
                        '        dr1 = CommonFunctions.Data.GetDataReader(strsql1, True)
                        '        While dr1.Read()
                        '            flag = 1
                        '            Dim temp As Integer
                        '            temp = CType(CommonFunctions.Data.CheckIsDBNull(dr1("TagID"), "0"), Integer)
                        '            If temp = WhizGlobal.TagID Then
                        '                If Args.ColumnName.ToUpper = "PROJECT PROGRESS" Then
                        '                    Cancel = True
                        '                    If WhizGlobal.TagID Then
                        '                        ProjectID = CStr(Args.DataReader.Item("ProjectID"))
                        '                    Else
                        '                        ProjectID = HttpContext.Current.Session("intProjectID")
                        '                    End If

                        '                    Dim PageName As String = CType(CommonFunctions.Data.CheckIsDBNull(dr1("PageName"), "0"), String)
                        '                    'Args.StringToBeInserted = "<TD align='center'><a href='javascript:myFunction(1,""../Home/ShowProjectDetails.aspx"");');'><img src='..\..\Images\PM.jpg' alt='Smiley'/></a></td>"
                        '                    ''Commented And Added By Vaijat K ON 22/02/2016
                        '                    'Args.StringToBeInserted = "<TD align='center'><a href='javascript:myFunction(" & ProjectID & ",""" & PageName & """,""" & ColumnName & """," & PrimaryKeyValue & ");'><img src='..\..\Images\PM.jpg' alt='Smiley'/></a></td>"
                        '                    Dim strbackcolor As String = ""
                        '                    Dim strPercent As Decimal = 0
                        '                    Dim arrDecimal(2) As Decimal

                        '                    arrDecimal(0) = Convert.ToDecimal(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_Effort_Variance_Quickview " & ProjectID & ",'Project',1," & WhizGlobal.UserID.ToString(), True), 0))
                        '                    arrDecimal(1) = Convert.ToDecimal(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_UD_Sel_OnTimedelivery " & ProjectID & ",1," & WhizGlobal.UserID.ToString(), True), 0))

                        '                    Dim StrSQL As String
                        '                    StrSQL = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_INS_tbl_PM_ProjectSV_SnapShot " & CommonFunction.General.CheckIsNothing(ProjectID, 0) & "," & WhizGlobal.UserID.ToString(), True), 0)
                        '                    StrSQL = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_INS_tbl_SV_Temp 'Project', " & CommonFunction.General.CheckIsNothing(ProjectID, 0) & ",1," & WhizGlobal.UserID.ToString(), True), 0)
                        '                    arrDecimal(2) = Convert.ToDecimal(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT ScheduleVariance FROM  tbl_SV_Temp", True), 0))


                        '                    strPercent = arrDecimal(0)
                        '                    For i As Integer = 0 To arrDecimal.Length - 1
                        '                        If arrDecimal(i) > strPercent Then
                        '                            strPercent = arrDecimal(i)
                        '                        End If
                        '                    Next

                        '                    'If ProjectID = 64 Then
                        '                    '    strPercent = 65
                        '                    'ElseIf ProjectID = 36 Then
                        '                    '    strPercent = 40
                        '                    'ElseIf ProjectID = 3075 Then
                        '                    '    strPercent = 85
                        '                    'End If
                        '                    If strPercent > 5 Then
                        '                        strbackcolor = "#F05E3D"
                        '                    ElseIf strPercent >= 0 And strPercent < 6 Then
                        '                        strbackcolor = "#EBC620"
                        '                    ElseIf strPercent < 0 Then
                        '                        strbackcolor = "#47BC7C"
                        '                    End If

                        '                    Args.StringToBeInserted = "<TD align='right' width='105px'><a style='text-decoration:none;' href='javascript:myFunction(" & ProjectID & ",""" & PageName & """,""" & ColumnName & """," & PrimaryKeyValue & ");'><div class=divStyleForQuickview style='background-color:" + strbackcolor + ";text-align:center;display:inline-block;width:65px'>" & strPercent & "%</div></a></td>"
                        '                    'Ended
                        '                End If
                        '            End If
                        '        End While
                        '    Else
                        '        '' CommonFunctions.General.WriteHTML("<script type=text/javascript> alert('you are not authorize to view this record'); </script>")                            
                        '        Cancel = True
                        '        Args.StringToBeInserted = "<TD align='center' width='105px'><a href='javascript:ErrorMessage();'><img src='..\..\Images\PM.jpg' alt='Smiley'/></a></td>"
                        '        'Dim MSg = "You are not Authorize to view this record"
                        '        'MsgBox(MSg)
                        '    End If
                        'End If

                        'If (flag = 0) Then
                        '    Cancel = True

                        'End If
                    End If
                    ''End by Nilesh Gundecha on 27 July 2015 
                    ''End of Commented by Vaijat K

                    'For Master Tag
                    Select Case WhizGlobal.TagID

                        'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                        'Added By SandeepA on 14 Nov,2005 for IssueID= 676

                        'Page:ProjectInfoRoleAccess TagID= 3083

                        Case CommonFunction.Constants.APP_TAG_ProjectInfoRoleAccess
                            Dim strSQL As String
                            Dim intResult As Integer
                            'Purpose: Use the existing delete column as a select list column
                            If Args.ColumnName.ToUpper = "SELECT" Then
                                Args.IsCheckBoxDisabled = False
                                If WhizGlobal.ProjectID <> 0 Then
                                    strSQL = "If Exists(Select 1 from tbl_PM_ProjectInfoRoleAccess where ProjectID=" & WhizGlobal.ProjectID & " and RoleID= " & CStr(Args.DataReader.Item("RoleID")) & ")Select 1 Else Select 0"
                                    intResult = CInt(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                                    If intResult = 1 Then
                                        Args.IsSelected = True
                                    Else
                                        Args.IsSelected = False
                                    End If
                                    'If no Project is selected unselect all the CheckBoxes
                                Else
                                    Args.IsSelected = False
                                End If
                            End If
                            'Purpose:Remove the link for Role in CL page
                            If Args.DataField.ToUpper = "ROLEDESCRIPTION" Then
                                Args.EnableLink = False
                            End If
                            'End of Addition by SandeepA on 14 Nov,2005 for IssueID --676
                            'End Integration

                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                            'Added by SandeepA on 15 nov,2005 for IssueID -- 677
                            'Page: Business Groups Middle level Resoucrce Project Access
                        Case CommonFunction.Constants.APP_TAG_BG_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            Dim strSQL As String
                            Dim intResult As Integer
                            Dim strBusinessGroupEmployeeID As String
                            'Purpose: Use the existing delete column as a select list column
                            If Args.ColumnName.ToUpper = "SELECT" Then
                                strBusinessGroupEmployeeID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupEmployeeID"), ""))
                                If (strBusinessGroupEmployeeID = "") Then
                                    strBusinessGroupEmployeeID = CStr(HttpContext.Current.Session("BusinessGroupEmployeeID"))
                                End If
                                HttpContext.Current.Session("BusinessGroupEmployeeID") = strBusinessGroupEmployeeID
                                strSQL = "If Exists(Select 1 from tbl_CNF_BusinessGroups_ResourceProjectAccess where ProjectID=" & CStr(Args.DataReader.Item("ProjectID")) & " and BusinessGroupEmployeeID= " & strBusinessGroupEmployeeID & ")Select 1 Else Select 0"
                                intResult = CInt(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                                If intResult = 1 Then
                                    Args.IsSelected = True
                                Else
                                    Args.IsSelected = False
                                End If
                            End If
                            'Purpose:Remove the link for Project Name in CL page
                            If Args.DataField.ToUpper = "PROJECTNAME" Then
                                Args.EnableLink = False
                            End If
                            'End of addition by SandeepA on 15 Nov,2005 for IssueID --677
                            'End Integration

                            'Integrated by SavitaS on 02 Jan 2006 for Help Desk.
                            'added by harshada d on 29 th Nov 2005 for Helpdesk Patch :
                        Case CommonFunction.Constants.APP_TAG_SHOW_CRM_HISTORY
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.DataField.ToUpper = "FIELDNAME" Then
                                '  Cancel = True
                                Args.EnableLink = False

                            End If

                            If Args.DataField.ToUpper() = "MODIFIEDDATETIME" Then
                                Dim dtModifiedDateTime As String

                                If IsDBNull(Args.DataReader("ModifiedDateTime")) Then
                                    dtModifiedDateTime = "-"
                                Else
                                    dtModifiedDateTime = CommonFunction.Dates.CGetDateTime(CType(Args.DataReader("ModifiedDateTime"), DateTime)).ToString()
                                End If

                                Cancel = True
                                Args.StringToBeInserted = "<TD align=left>" + dtModifiedDateTime + "</TD>"

                            End If

                            'end of addition by harshada d on 29 th Nov 2005 for Helpdesk Patch 
                            'End Integration by SavitaS


                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                            'Added by SandeepA on 15 nov,2005 for IssueID -- 679
                            'Page: Organization Unit Middle level Resoucrce Project Access
                        Case CommonFunction.Constants.APP_TAG_OU_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            Dim strSQL As String
                            Dim intResult As Integer
                            Dim strLocationEmployeeID As String
                            'Purpose: Use the existing delete column as a select list column
                            If Args.ColumnName.ToUpper = "SELECT" Then
                                strLocationEmployeeID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("LocationEmployeeID"), ""))
                                If (strLocationEmployeeID = "") Then
                                    strLocationEmployeeID = CStr(HttpContext.Current.Session("LocationEmployeeID"))
                                End If
                                HttpContext.Current.Session("LocationEmployeeID") = strLocationEmployeeID
                                strSQL = "If Exists(Select 1 from tbl_PM_Location_ResourceProjectAccess where ProjectID=" & CStr(Args.DataReader.Item("ProjectID")) & " and LocationEmployeeID= " & strLocationEmployeeID & ")Select 1 Else Select 0"
                                intResult = CInt(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                                If intResult = 1 Then
                                    Args.IsSelected = True
                                Else
                                    Args.IsSelected = False
                                End If
                            End If
                            'Purpose:Remove the link for Project name in CL page
                            If Args.DataField.ToUpper = "PROJECTNAME" Then
                                Args.EnableLink = False
                            End If
                            'End of addition by SandeepA on 15 Nov,2005 for IssueID --679
                            'End Integration
                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                            'Added by SandeepA on 16 nov,2005 for IssueID -- 680
                            'Page: Delivery Unit Middle level Resoucrce Project Access TagID:3090
                        Case CommonFunction.Constants.APP_TAG_DU_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            Dim strSQL As String
                            Dim intResult As Integer
                            Dim strResourcePoolEmployeeID As String
                            'Purpose: Use the existing delete column as a select list column
                            If Args.ColumnName.ToUpper = "SELECT" Then
                                strResourcePoolEmployeeID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ResourcePoolEmployeeID"), ""))
                                If (strResourcePoolEmployeeID = "") Then
                                    strResourcePoolEmployeeID = CStr(HttpContext.Current.Session("ResourcePoolEmployeeID"))
                                End If
                                HttpContext.Current.Session("ResourcePoolEmployeeID") = strResourcePoolEmployeeID
                                strSQL = "If Exists(Select 1 from tbl_PM_ResourcePool_ResourceProjectAccess where ProjectID=" & CStr(Args.DataReader.Item("ProjectID")) & " and ResourcePoolEmployeeID= " & strResourcePoolEmployeeID & ")Select 1 Else Select 0"
                                intResult = CInt(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                                If intResult = 1 Then
                                    Args.IsSelected = True
                                Else
                                    Args.IsSelected = False
                                End If
                            End If
                            'Purpose:Remove the link for Project Name in CL page
                            If Args.DataField.ToUpper = "PROJECTNAME" Then
                                Args.EnableLink = False
                            End If
                            'End of addition by SandeepA on 15 Nov,2005 for IssueID --680
                            'End Integration
                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2

                            'Added by SandeepA on 16 nov,2005 for IssueID -- 681
                            'Page: Delivery Team Middle level Resoucrce Project Access
                        Case CommonFunction.Constants.APP_TAG_DT_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            Dim strSQL As String
                            Dim intResult As Integer
                            Dim strGroupEmployeeID As String
                            'Purpose: Use the existing delete column as a select list column
                            If Args.ColumnName.ToUpper = "SELECT" Then
                                strGroupEmployeeID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("GroupEmployeeID"), ""))
                                If (strGroupEmployeeID = "") Then
                                    strGroupEmployeeID = CStr(HttpContext.Current.Session("GroupEmployeeID"))
                                End If
                                HttpContext.Current.Session("GroupEmployeeID") = strGroupEmployeeID
                                strSQL = "If Exists(Select 1 from tbl_PM_GroupMaster_ResourceProjectAccess where ProjectID=" & CStr(Args.DataReader.Item("ProjectID")) & " and GroupEmployeeID= " & strGroupEmployeeID & ")Select 1 Else Select 0"
                                intResult = CInt(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                                If intResult = 1 Then
                                    Args.IsSelected = True
                                Else
                                    Args.IsSelected = False
                                End If
                            End If
                            'Purpose:Remove the link for Project Name in CL page
                            If Args.DataField.ToUpper = "PROJECTNAME" Then
                                Args.EnableLink = False
                            End If
                            'End of addition by SandeepA on 15 Nov,2005 for IssueID --681
                            'End Integration


                            ' Added by NitinVS on 22 Oct 2005 for WhizibleSEM SP4 IssueID 593 
                        Case CommonFunction.Constants.APP_TAG_SQERT_RANGES
                            If (Args.ColumnName.ToUpper = "DELETE") Then
                                Cancel = True
                            End If
                            'End Addition By NitinVs on 22 Oct 2005 for WhizibleSEM SP4 IssueID 593

                            'added by HarshK for sp4 issueid 536 on 07/10/2005
                        Case CommonFunction.Constants.APP_TAG_TAB_APPROVER_HISTORY
                            If (Args.ColumnName.ToUpper = "DELETE") Then
                                Cancel = True
                            End If
                            If Args.DataField.Trim.ToUpper = "EMPLOYEENAME" Then
                                Args.EnableLink = False
                            End If
                            'End added by HarshK for sp4 issueid 536 on 07/10/2005
                            'Added by VivekP on 02-Sep-2005 - Removing hyerlink in SQERT Locking
                            'Added by Mangesh Y on 6 Jan 2005- Removing hyerlink in SQERT Locking
                        Case CommonFunction.Constants.APP_TAG_SQERT_LOCK
                            'Suppress the hyperlink
                            If Args.DataField.Trim.ToUpper = "PROJECTNAME" Then
                                Args.EnableLink = False
                            End If

                            If Args.ColumnName.ToUpper = "DELETE" Then
                                If CType(Args.DataReader("LOCKED"), Boolean) = True Then
                                    Args.IsSelected = True
                                Else
                                    Args.IsSelected = False
                                End If
                            End If
                            'End of addition - Mangesh Y on 6 Jan 2005
                            'End of addition - VivekP on 02 sep 2005

                        Case CommonFunction.Constants.APP_TAG_PROCESS
                            If Args.DataField.ToLower = "hyperlink1" And CommonFunction.Data.CheckIsDBNull(Args.DataReader("Status"), "").ToString.Trim = "P" Then
                                'If the Process is published thendo not show the link..
                                Args.IgnoreActualValue = True
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                Args.ReplacementValue = "<FONT color='RED'>" + objTemplate.GetResourceString("PUBLISHED") + "</FONT>"
                                Args.EnableLink = False
                                objTemplate = Nothing
                            End If
                            'Code added by SwatiC on 12 Jun 2007 for IssueID  : 12833
                            If Args.ColumnName.ToUpper = "PUBLISH" Then
                                Dim m_objAccessRights As WebPages.Security.cAccessRights
                                m_objAccessRights = New WebPages.Security.cAccessRights(WhizGlobal)
                                m_objAccessRights.GetAccess()
                                If Not (m_objAccessRights.Edit Or m_objAccessRights.Add) Then
                                    Args.EnableLink = False
                                End If
                                m_objAccessRights = Nothing
                            End If
                            ' End of Code addition by SwatiC on 12 Jun 2007 for IssueID  : 12833
                        Case CommonFunction.Constants.APP_TAG_PROJECT_TEMPLATE
                            'Select Case Args.DataField.ToUpper
                            '    Case "CONFIGURE PLANS", "CONFIGURE SDLC", "CONFIGURE PHASES", _
                            '         "CONFIGURE TASK TYPES", "CONFIGURE TASK ATTRIBUTES", _
                            '         "CONFIGURE ISSUE TYPES", "CONFIGURE REVIEW TYPES", _
                            '         "CONFIGURE GENERIC TASKS", "CONFIGURE RISKS", _
                            '         "CONFIGURE TEMPLATES"  'added by SachinR   on 16 Sep 2004
                            Args.ApplyNoWrap = False
                            'End Select
                        Case CommonFunction.Constants.APP_TAG_PROCESS_MEASUREMENT_INDICATOR_REPORT
                            Select Case Args.DataField.ToUpper
                                Case "SHORTNAME"
                                    Args.EnableLink = False
                            End Select
                        Case CommonFunction.Constants.APP_TAG_PROCESSES_REPORT
                            Select Case Args.DataField.ToUpper
                                Case "REVISIONNO"
                                    Args.EnableLink = False
                            End Select
                        Case CommonFunction.Constants.APP_TAG_METRICS_REPORT
                            Select Case Args.DataField.ToUpper
                                Case "NAME"
                                    Args.EnableLink = False
                            End Select
                        Case CommonFunction.Constants.APP_TAG_ACTIVITIES_REPORT
                            Select Case Args.DataField.ToUpper
                                Case "ACTIVITYSTAGEID"
                                    Args.EnableLink = False
                            End Select
                        Case CommonFunction.Constants.APP_TAG_PMI_HISTORY
                            Select Case Args.DataField.ToUpper
                                Case "FIELDNAME"
                                    Args.EnableLink = False
                            End Select
                        Case CommonFunction.Constants.APP_TAG_CHECKLISTS
                            If Args.DataField.ToLower = "hyperlink1" Then
                                If CommonFunction.Data.CheckIsDBNull(Args.DataReader("Status"), "").ToString.Trim = "P" Then
                                    'If the Checklist is published then do not show the link..
                                    Args.IgnoreActualValue = True
                                    'Create object of the ProjectByNet Template Class
                                    objTemplate = New WebPages.Template.WhizTemplate
                                    'Initialize the Resources
                                    objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                    Args.ReplacementValue = "<FONT color='RED'>" + objTemplate.GetResourceString("PUBLISHED") + "</FONT>"
                                    Args.EnableLink = False
                                    objTemplate = Nothing
                                    'Added By NileshD on 26 July 2004
                                    'TO resolve issue id 12105
                                ElseIf CommonFunction.Data.CheckIsDBNull(Args.DataReader("Status"), "").ToString.Trim = "N" Then
                                    'If the Checklist is published then do not show the link..
                                    Args.IgnoreActualValue = True
                                    'Create object of the ProjectByNet Template Class
                                    objTemplate = New WebPages.Template.WhizTemplate
                                    'Initialize the Resources
                                    objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                    Args.ReplacementValue = "<FONT color='BLACK'>" + objTemplate.GetResourceString("NOT_APPLICABLE") + "</FONT>"
                                    Args.EnableLink = False
                                    objTemplate = Nothing
                                    'End of Addition
                                End If
                            End If
                        Case CommonFunction.Constants.APP_TAG_RESOURCE_BILLING
                            If (Args.ColumnName.ToUpper = "DELETE") Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEMASTER
                            If (Args.ColumnName.ToUpper = "DELETE") Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_LEAVEMASTER
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            ''Commented by ManishK  On 3rd Jan 06 as new page is added for Leave page
                            ''''Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS
                            ''''    Dim lngLeaveID As Long = 0
                            ''''    Dim lngLeaveStatusID As Long = 0
                            ''''    lngLeaveID = CType(Args.DataReader.Item("LeaveID"), Long)
                            ''''    lngLeaveStatusId = CType(Args.DataReader.Item("LeaveStatusID"), Long)

                            ''''    If (Args.ColumnName.ToUpper = "APPROVE") Then
                            ''''        If lngLeaveStatusId = 1 Or lngLeaveStatusId = 3 Then
                            ''''        Else
                            ''''            Args.StringToBeInserted = "<TD align='center'>-</TD>"
                            ''''            Cancel = True
                            ''''        End If
                            ''''    ElseIf (Args.ColumnName.ToUpper = "REJECT") Then
                            ''''        If lngLeaveStatusId <> 1 Then
                            ''''            Args.StringToBeInserted = "<TD align='center'>-</TD>"
                            ''''            Cancel = True
                            ''''        End If
                            ''''    ElseIf Args.ColumnName.ToUpper = "DELETE" Then
                            ''''        Cancel = True
                            ''''    End If
                            'Added By Chakshuta H on 12th Aug 2014
                            'Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEAPPLICATION
                            '    Dim lngLeaveStatusId As Long
                            '    lngLeaveStatusId = CType("0" & CommonFunctions.General.CheckIsNothing(Args.DataReader.Item("LeaveStatusID"), "0"), Long)
                            '    'if status is not submmitted then disable the link
                            '    If lngLeaveStatusId <> 1 Then
                            '        If Args.DataField.ToUpper = "LEAVESTATUS" Then
                            '            Args.EnableLink = False
                            '        End If
                            '    End If
                            ''End of Comment by Manishk On 3rd Jan 06
                            'Ended By Chakshuta H on 12th Aug 2014

                        Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEBALANCE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            Args.EnableLink = False

                        Case CommonFunction.Constants.APP_TAG_ASSIGNEDRESOURCES
                            If Args.DataField.ToUpper = "EMPLOYEENAME" Then
                                Args.EnableLink = False
                            End If
                            'disable the reject link for rejected and assigned resources.
                            If Args.ColumnName.ToUpper = "REJECT" Then
                                If Not Args.DataReader("EmployeeID") Is Nothing Then
                                    Dim strEmployeeID As String = Args.DataReader("EmployeeID").ToString
                                    Dim strStatus As String
                                    Dim strSQL As String
                                    strSQL = "SELECT status FROM tbl_PM_AssignedResources where RequestID = " + HttpContext.Current.Request("RequestID").ToString + " and EmployeeID = " + strEmployeeID
                                    strStatus = CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                                    If strStatus.Trim.ToUpper <> "A" Then
                                        Args.IgnoreActualValue = True
                                        Args.ReplacementValue = "-"
                                        Args.EnableLink = False
                                    End If
                                End If
                            End If
                            'show the view comment link to only rejected record.
                            If Args.ColumnName.ToUpper = "COMMENTS" Then
                                If Not Args.DataReader("EmployeeID") Is Nothing Then
                                    Dim strEmployeeID As String = Args.DataReader("EmployeeID").ToString
                                    Dim strStatus As String
                                    Dim strSQL As String
                                    strSQL = "SELECT status FROM tbl_PM_AssignedResources where RequestID = " + HttpContext.Current.Request("RequestID").ToString + " and EmployeeID = " + strEmployeeID
                                    strStatus = CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                                    If strStatus.Trim.ToUpper = "R" Then
                                        Args.IgnoreActualValue = True
                                        Args.ReplacementValue = "View Comments"
                                    Else
                                        Args.IgnoreActualValue = True
                                        Args.ReplacementValue = "-"
                                        Args.EnableLink = False
                                    End If
                                End If
                            End If

                            'Code commented by PrashantD on 19 Jan 2008 for Resource Demand Enhancment

                            'Case CommonFunction.Constants.APP_TAG_RESOURCEREQUEST
                            '    If Args.ColumnName.ToUpper = "DELETE" Then
                            '        Cancel = True
                            '        ' Added By JayavantK on 19-Jun-2004 - Start
                            '    ElseIf Args.DataField.ToUpper = "STATUS" Then
                            '        Dim strRequestStatus As String = ""
                            '        Dim lngRequestID As Long = 0
                            '        Dim strQuery As String = ""

                            '        Args.IgnoreActualValue = True
                            '        lngRequestID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RequestID"), "0"), Long)
                            '        strQuery = "Exec usp_Sel_tbl_PM_ResourceRequest_GetStatusString " & lngRequestID.ToString()
                            '        strRequestStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                            '        Args.ReplacementValue = strRequestStatus
                            '        ' Added By JayavantK on 19-Jun-2004 - End
                            '    End If
                            'End of comment by PrashantD on 19 Jan 2008 for  Resource Demand Enhancment
                        Case CommonFunction.Constants.APP_TAG_SCM_PLAN
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                        Case CommonFunctions.Constants.TAG_OUTPUT_FORMAT_SETTINGS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            ' commented By NitinVS on 21 Sep 2006 for WhizibleSEM SP7 IssueID 6348 

                            '    'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                            '    'Added By SandeepA on 14 Nov,2005 for Issue ID --676
                            '    'Page: Project Listing , TagID= 32
                            'Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING


                            '    'Purpose: If the user is (Customer) or has restricted access then Redirect to the Restricted Access Project Information Page
                            '    If Args.DataField.ToUpper = "PROJECTNAME" Then
                            '        Dim strSQL As String
                            '        Dim intResult As Integer
                            '        Dim strProjectName As String
                            '        Dim drRole As IDataReader
                            '        Dim intRole As Integer

                            '        strSQL = "EXEC usp_Sel_EmployeeProjectRole " & CType(Args.DataReader("ProjectID"), String) & "," & CType(HttpContext.Current.Session("intUserID"), String) & ",'" & CType(HttpContext.Current.Session("intLoginType"), Integer) & "'"
                            '        drRole = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            '        If drRole.Read Then
                            '            intRole = CType(CommonFunction.Data.CheckIsDBNull(drRole("Role"), "0"), Integer)
                            '        End If

                            '        CommonFunction.Data.DisposeDataReader(drRole)

                            '        'strsql = "If Exists(Select 1 from tbl_PM_ProjectInfoRoleAccess where ProjectID=" & WhizGlobal.ProjectID & " and RoleID= " & WhizGlobal.RoleID & ")Select 1 Else Select 0"
                            '        'strsql = "If Exists(Select 1 from tbl_PM_ProjectInfoRoleAccess where ProjectID=" & CType(Args.DataReader("ProjectID"), String) & " and RoleID= " & WhizGlobal.RoleID & ")Select 1 Else Select 0"

                            '        strsql = "If Exists(Select 1 from tbl_PM_ProjectInfoRoleAccess where ProjectID=" & CType(Args.DataReader("ProjectID"), String) & " and RoleID= " & intRole & ")Select 1 Else Select 0"
                            '        intResult = CInt(CommonFunctions.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                            '        If intResult = 1 Then
                            '            Cancel = True
                            '            'Code added by vidyaJ - Security issue - 6197
                            '            Dim strtoken As String
                            '            strtoken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("ProjectID"), String) + CType(HttpContext.Current.Session("intUserID"), String) + "0" + "3086")

                            '            'Purpose: Replcae blank space with '+' since QueryString can not accept blank spaces
                            '            strProjectName = Replace(CType(Args.DataReader("ProjectName"), String), " ", "+")
                            '            'Replace the Link and redirect to Restricted Project Information Page if the user has restricted access
                            '            Args.StringToBeInserted = "<TD   nowrap  align=Left Title=""Column Name : Project Name""><A href=""Navigation.aspx?subPage=CommonPage.aspx&ProjectID_PK=" & CType(Args.DataReader("ProjectID"), String) & "&PKToken=" & strtoken & "&ProjectName=" & strProjectName & "&MasterTagID=3086&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1"" Title=""""  Target=_top >" & CType(Args.DataReader("ProjectName"), String) & " </A></TD>"
                            '        End If
                            '    End If
                            '    'End of Addition by SandeepA on 14 Nov,2005 for IssueID-676
                            '    'End Integration

                            ' End Commented By NitinVS on 21 Sep 2006 for WhizibleSEM SP7 IssueID 6348 

                            'If Args.ColumnName.ToUpper = "PROJECT NAME" Then
                            'Cancel = True
                            'Args.StringToBeInserted = "<TD><A href='CommonPage.aspx?MasterTagID=32&ProjectID=" + CType(Args.DataReader("ProjectID"), String) + "'>" + CType(Args.DataReader("ProjectName"), String) + "</A></TD>"
                            'End If
                            'Commented by JyotiG
                            'Start_JG_11457_15-Mar-2007
                            'Issue : Configuration -> Application Administration -> Report -> Report Designer  :- Open a record in edit mode. CLick on the link ''Output Format Settings''. Page crashes
                            'If Args.ColumnName.ToUpper = "DELETE" Then
                            '    'Do not allow to delete the selected project
                            '    If Args.DataReader("ProjectID").ToString = WhizGlobal.ProjectID.ToString Then Args.IsCheckBoxDisabled = True
                            'End If
                            'End_JG_11457_15-Mar-2007
                        Case CommonFunction.Constants.APP_TAG_REVISION_HISTORY
                            If Args.ColumnName.ToUpper = "REVISION NUMBER" Then
                                Args.EnableLink = False
                            End If
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'Added by PrasannaP on 20th May 2004
                        Case CommonFunction.Constants.APP_TAG_BACKDATING_CONFIGURATION
                            Dim strReplacementValue As String
                            If Args.ColumnName.ToUpper = "PROJECT CODE" Then
                                Args.EnableLink = False
                            End If
                            If Args.ColumnName.ToUpper = "ALLOW BACK DATED TIMESHEET?" Then
                                Args.IgnoreActualValue = True

                                strReplacementValue = "<input type=checkbox id=chkDelete name=chkDelete value='" + CType(Args.DataReader("ProjectID"), String) + "'"
                                If CType(Args.DataReader("IsBackDating"), Boolean) = True Then
                                    strReplacementValue += " checked >"
                                Else
                                    strReplacementValue += ">"
                                End If
                                Args.ReplacementValue = strReplacementValue
                            End If

                            If Args.ColumnName.ToUpper = "ALLOW FORWARD DATED TIMESHEET?" Then
                                Args.IgnoreActualValue = True

                                strReplacementValue = "<input type=checkbox id=chkFwd name=chkFwd value='" + CType(Args.DataReader("ProjectID"), String) + "'"
                                If CType(Args.DataReader("IsForwardDating"), Boolean) = True Then
                                    strReplacementValue += " checked >"
                                Else
                                    strReplacementValue += ">"
                                End If
                                Args.ReplacementValue = strReplacementValue
                            End If

                            'End Addition
                        Case CommonFunction.Constants.APP_TAG_FIXED_BID_REVISION_HISTORY
                            If Args.ColumnName.ToUpper = "ID" Then Args.EnableLink = False
                            If Args.ColumnName.ToUpper = "APPROVED DATE" Then Args.ShowTimeWithDate = True
                        Case CommonFunction.Constants.APP_TAG_CONFIG_TYPE_SECURITY_ROLES
                            ''------------------------------------------------------------------------------------------
                            ''Code added by RohiniK on 21 August 2006 for Role wise Access to All ISsues Tab in Issues Module  for Whiziblesem SP 7 Issue ID 5688 
                            '' commented(if condition) and added by RohiniK on 21 August 2006 for displaying delete checkbox and renaming delete coulmn as Disable All Issues Link

                            ' If Args.ColumnName.ToUpper = "ROLELINK" Or Args.ColumnName.ToUpper = "DELETE" Then
                            If Args.ColumnName.ToUpper = "ROLELINK" Then
                                Cancel = True
                            End If
                            If Args.ColumnName.ToUpper = "ROLE" Then
                                If CType(Args.DataReader("Role"), Double) = 23.0 Then
                                    m_strRole = "Customer"
                                End If
                            End If
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                If m_strRole = "Customer" Then
                                    Args.IsCheckBoxDisabled = True
                                    m_strRole = ""
                                End If
                                If CBool(Args.DataReader("disableAllIssuesLink")) Then
                                    Args.IgnoreActualValue = True
                                    Args.IsSelected = True
                                End If
                            End If
                            ''End of Code addition by RohiniK on 21 August 2006 for Role wise Access to All ISsues Tab in Issues Module
                            ''------------------------------------------------------------------------------------------
                            'Added By ShraddhaM on 3,July 2007
                            If Args.ColumnName.ToUpper = "HIDE ""BATCH UPDATE""" And Args.ColIndex = 3 Then
                                Cancel = True
                                If m_strRole = "Customer" Then
                                    Args.StringToBeInserted = "<TD align='center'><input type=checkbox name ='chkBatch' id ='chkBatch' class='clsCheckBox' disabled value=" + Args.DataReader("Role").ToString + "></td>"
                                Else
                                    If Args.DataReader("HideBatchUpdateLink").ToString = "1" Then
                                        Args.StringToBeInserted = "<TD align='center'><input type=checkbox name ='chkBatch' id ='chkBatch' class='clsCheckBox' checked value=" + Args.DataReader("Role").ToString + "></td>"
                                    Else
                                        Args.StringToBeInserted = "<TD align='center'><input type=checkbox name ='chkBatch' id ='chkBatch' class='clsCheckBox' value=" + Args.DataReader("Role").ToString + "></td>"
                                    End If
                                End If


                            End If
                            'Ended By ShraddhaM on 3,July 2007

                        Case CommonFunction.Constants.APP_TAG_CONFIG_TYPE_SECURITY
                            If Args.ColumnName.ToUpper = "STATUS" Then
                                'Do not show link for the Status column
                                Args.EnableLink = False
                            ElseIf Args.ColumnName.ToUpper = "DELETE" Then
                                'If the Access is set for the Project Role, then show the status as SELECTED
                                'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                                'Modified Args.datafield to Args.PrimaryKeyName
                                Dim strSQL As String = "usp_sel_tbl_ib_IsStatusAccessible " + WhizGlobal.ProjectID.ToString + "," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("Role"), "0") + "," + CommonFunctions.General.CheckIsNothing(Args.DataReader(Args.PrimaryKeyName))
                                'End Of Modifications - IssueID : 672
                                Dim strResult As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetSQLDataScalar(strSQL))
                                If strResult = "1" Then Args.IsSelected = True
                            End If
                            'added by SachinR   on 05 jul 2004
                        Case CommonFunction.Constants.APP_TAG_PROJECT_ROOT_CAUSE
                            If Args.DataField.ToUpper = "ROOTCAUSE" Or Args.DataField.ToUpper = "ROOTCAUSECODE" Then
                                'Do not show link for the description column
                                Args.EnableLink = False
                            ElseIf Args.ColumnName.ToUpper = "DELETE" Then
                                'If the Access is set for the Project Role, then show the status as SELECTED
                                Dim strSQL As String = "usp_sel_tbl_IB_Project_RootCause_IsApplicable " + WhizGlobal.ProjectID.ToString + "," + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RootCauseID"), "0").ToString
                                Dim strResult As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetSQLDataScalar(strSQL))
                                If strResult = "1" Then Args.IsSelected = True
                            End If
                            'addition end
                            'added By   SachinR     on 12 Jul 2004
                            'Issue - 11825
                        Case CommonFunction.Constants.APP_TAG_PROJECT_ROOT_CAUSEMAPPING
                            If Args.DataField.ToUpper = "ROOTCAUSECODE" Or Args.DataField.ToUpper = "ROOTCAUSE" Then
                                'Do not show link for the description column
                                Args.EnableLink = False
                            End If
                            'addition end

                            'added by SachinR   on 06 jul 2004
                        Case CommonFunction.Constants.APP_TAG_PROJECT_CUSTOM_FIELD_MAINTENANCE
                            If Args.ColumnName.ToUpper = "ROLE" Then
                                'Do not show link for the description column
                                Args.EnableLink = False
                            ElseIf Args.ColumnName.ToUpper = "DELETE" Then
                                Dim strCustomFieldID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("CustomFieldID"), "")
                                '***** Code added by SandipL on 23 nov 2005
                                If strCustomFieldID = "" Then
                                    'Dim strQueryString As String
                                    'strQueryString = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.UrlReferrer.Query, "")
                                    'strCustomFieldID = strQueryString.Substring(15, strQueryString.IndexOf("&", 16) - 15)
                                    strCustomFieldID = CType(HttpContext.Current.Session("CustomFieldID"), String)
                                End If
                                '***** End addition by SandipL
                                'If the Access is set for the Project Role, then show the status as SELECTED
                                Dim strSQL As String = "usp_sel_tbl_IB_RoleCustomFieldSecurity_IsApplicable " + WhizGlobal.ProjectID.ToString + "," + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Role"), "0").ToString + "," + strCustomFieldID.Trim
                                Dim strResult As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetSQLDataScalar(strSQL))
                                If strResult = "1" Then Args.IsSelected = True
                            End If
                            'addition end
                            'added by SachinR   on 15 Jul 2004

                            '***** Code added by SandipL on 19 Jan 2006
                        Case CommonFunction.Constants.APP_TAG_PROJECT_TASK_CUSTOM_FIELD_MAINTENANCE
                            If Args.ColumnName.ToUpper = "ROLE" Then
                                'Do not show link for the description column
                                Args.EnableLink = False
                            ElseIf Args.ColumnName.ToUpper = "DELETE" Then
                                Dim strCustomFieldID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("CustomFieldID"), "")
                                If strCustomFieldID = "" Then
                                    strCustomFieldID = CType(HttpContext.Current.Session("CustomFieldID"), String)
                                End If
                                'If the Access is set for the Project Role, then show the status as SELECTED
                                Dim strSQL As String = "usp_sel_tbl_PM_RoleCustomFieldSecurity_IsApplicable " + WhizGlobal.ProjectID.ToString + "," + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Role"), "0").ToString + "," + strCustomFieldID.Trim
                                Dim strResult As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetSQLDataScalar(strSQL))
                                If strResult = "1" Then Args.IsSelected = True
                            End If
                            '***** End addition by SandipL on 19 Jan 2006

                        Case CommonFunction.Constants.APP_TAG_SDLC_PROCESS
                            If Args.DataField.ToUpper = "ISREQUIRED" Then
                                Dim strChecked As String = ""
                                Dim strSDLCID As String = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SDLCId")).ToString
                                If CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsRequired")).ToString.ToUpper = "TRUE" Then strChecked = " checked "
                                Args.IgnoreActualValue = True
                                Args.ReplacementValue = "<Input Type=checkbox id='IsRequired' name='IsRequired' class='clsCheckBox' value='" + strSDLCID + "'" + strChecked + ">"
                                'Code added by SwatiC on 12 Jun 2007 for IssueID : 12857
                                Args.TDStyle = "Title=""Column Name : Required (Yes/No)"""
                                'End of code addition by SwatiC BY SwatiC from IssueID : 12857 
                            ElseIf Args.DataField.ToUpper = "ISPERFORMED" Then
                                Dim strChecked As String = ""
                                Dim strSDLCID As String = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SDLCId")).ToString
                                If CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsPerformed")).ToString.ToUpper = "TRUE" Then strChecked = " checked "
                                Args.IgnoreActualValue = True
                                Args.ReplacementValue = "<Input Type=checkbox id='IsPerformed' name='IsPerformed' class='clsCheckBox' value='" + strSDLCID + "'" + strChecked + ">"
                                'Code added by SwatiC on 12 Jun 2007 for IssueID : 12857
                                Args.TDStyle = "Title=""Column Name : Has this been performed?"""
                                'End of code addition by SwatiC BY SwatiC from IssueID : 12857
                                'addition end

                                'Integrated by MrugajaB on 3rd Jan 2006 for Whiz2 Processes - Build 29
                                ''Added by ManishK on 30th Aug

                                'Purpose        :   To Add Synchronize column in the grid.
                            ElseIf Args.DataField.ToUpper = "ISREMOVED" Then
                                Dim strActivityID As String = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ActivityID")).ToString
                                Dim strEnableDisable As String = ""
                                If Args.DataReader("IsRemoved").ToString.ToUpper = "NO" Then strEnableDisable = " disabled "
                                Args.IgnoreActualValue = True
                                Args.ReplacementValue = "<Input Type=checkbox id='chkSynchronize' name='chkSynchronize' class='clsCheckBox' value='" + strActivityID + "'" + strEnableDisable + ">"
                            End If
                            ''End of addition by ManishK on 30th Aug 2005
                            'End of addition by ManishK on 29th Aug 2005
                            'End Integration
                            ''Code added by SwatiC on 6 Jun 2007 for IssueID : 12856
                            Dim m_objAccessRights As WebPages.Security.cAccessRights
                            m_objAccessRights = New WebPages.Security.cAccessRights(WhizGlobal)
                            m_objAccessRights.GetAccess()
                            If Args.DataField.ToUpper = "TITLE" Then
                                If Not (m_objAccessRights.Edit) Then
                                    Args.EnableLink = False
                                End If
                                'Code added by SwatiC on 12 Jun 2007 for IssueID : 12857
                                Args.TDStyle = "Title=""Column Name : Activity"""
                                'End of code addition by SwatiC BY SwatiC from IssueID : 12857
                            End If

                            m_objAccessRights = Nothing
                            ''End of Code addition by SwatiC on 6 Jun 2007 for IssueID : 12856
                            'Code added by SwatiC on 12 Jun 2007 for IssueID : 12857
                            If Args.DataField.ToUpper = "HYPERLINK1" Then
                                Args.TDStyle = "Title=""Column Name : Show Details"""
                            End If
                            If Args.DataField.ToUpper = "ISDEVIATION" Then
                                Args.TDStyle = "Title=""Column Name : Deviation"""
                            End If
                            If Args.DataField.ToUpper = "ISTAILORING" Then
                                Args.TDStyle = "Title=""Column Name : Tailoring"""
                            End If
                            If Args.DataField.ToUpper = "ACTIVITYORDERNUMBER" Then
                                Args.TDStyle = "Title=""Column Name : Order Number"""
                            End If
                            ''End of Code addition by SwatiC for IssueID : 12857

                            Select Case Args.ColumnName.ToUpper
                                Case "APPLICABLE TEMPLATES"
                                    If CommonFunction.Data.CheckIsDBNull(Args.DataReader("SDLCID"), "").ToString.Trim <> "" Then
                                        Dim drApplicableTemplates As IDataReader
                                        Dim intloopCounter As Integer = 0
                                        Dim strTemplateFileName As String

                                        Cancel = True
                                        Args.StringToBeInserted = "<TD align=Center Title=""Column Name : Applicable Templates"">"

                                        drApplicableTemplates = CommonFunctions.Data.GetDataReader("SELECT TemplateID, Name, ProjectID, ProcessID FROM v_tbl_PRS_SDLC_Templates  WHERE SDLCId = " + Args.DataReader("SDLCID").ToString, True)
                                        While drApplicableTemplates.Read
                                            intloopCounter += 1
                                            strTemplateFileName = CommonFunction.General.funcReturnOriginalFileName("TPT", CType(drApplicableTemplates.Item("TemplateID"), Long))

                                            Args.StringToBeInserted += "<A href='../General/ViewAttachment.aspx?FromWhere=TPT&FileName=" + strTemplateFileName.Trim + "','pp','MENUBAR=no,TITLEBAR=yes,TOOLBAR=no,RESIZABLE=yes'>"
                                            Args.StringToBeInserted += drApplicableTemplates.Item("Name").ToString + "</A><BR>"
                                        End While
                                        CommonFunctions.Data.DisposeDataReader(drApplicableTemplates)

                                        Args.StringToBeInserted += "</TD>"
                                    End If
                                Case "APPLICABLE CHECKLISTS"
                                    If CommonFunction.Data.CheckIsDBNull(Args.DataReader("SDLCID"), "").ToString.Trim <> "" Then
                                        Dim drApplicableChecklists As IDataReader

                                        Cancel = True
                                        'Code Commented and added by SwatiC on 12 Jub 2007 for IssueID : 12847
                                        'Args.StringToBeInserted = "<TD align=Center Title=""Column Name : Applicable Templates"">"
                                        Args.StringToBeInserted = "<TD align=Center Title=""Column Name : Applicable Checklists"">"
                                        'End of Addition by SwatiC on 12 Jub 2007 for IssueID : 12847

                                        drApplicableChecklists = CommonFunctions.Data.GetDataReader("SELECT CheckListID, Title FROM v_tbl_PRS_SDLC_Checklists  WHERE SDLCId = " + Args.DataReader("SDLCID").ToString, True)
                                        While drApplicableChecklists.Read
                                            Args.StringToBeInserted += "<A href='JavaScript:CheckList_OnClick(" + drApplicableChecklists.Item("CheckListID").ToString + ")' >"
                                            Args.StringToBeInserted += drApplicableChecklists.Item("Title").ToString + "</A><BR>"
                                        End While
                                        CommonFunctions.Data.DisposeDataReader(drApplicableChecklists)

                                        Args.StringToBeInserted += "</TD>"
                                        Args.StringToBeInserted += "<Script language='JavaScript'>"
                                        Args.StringToBeInserted += " function CheckList_OnClick(CID) { "
                                        'Args.StringToBeInserted += " window.open('../Process/PRO_ChecklistForm.aspx?Mode=PUBLISH&ChecklistID=' + CID, '', 'resizable=yes,menubar=yes,scrollbars=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 600)/2 + ',width=800,height=600');"
                                        Args.StringToBeInserted += " window.open('../Process/PRO_ChecklistPreview.aspx?QuestionnaireID=' + CID, '', 'resizable=yes,menubar=yes,scrollbars=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 600)/2 + ',width=800,height=600');"
                                        Args.StringToBeInserted += " }"
                                        Args.StringToBeInserted += "</Script>"
                                    End If
                            End Select

                            ' added by harshada d for whiziblesem SP 7. 4 for chklist enhancements : if no items are there then alert before publishing it.
                        Case CommonFunction.Constants.APP_TAG_QUESTION_CHECKLIST
                            If Args.ColumnName.ToUpper = "PUBLISH" Then

                                Dim drCntOfQuestionaire As IDataReader
                                Dim strSQLCntOfQuestionaireID As String
                                Dim intCntOfQuestionaireID As Integer
                                Dim strFunction As String
                                If CommonFunction.Data.CheckIsDBNull(Args.DataReader("QuestionnaireID"), "").ToString.Trim <> "" Then
                                    Dim drApplicableChecklists As IDataReader
                                    strSQLCntOfQuestionaireID = "select ISNULL(count(QuestionnaireQuestionID),0) AS CountQuestionaireID from tbl_Q_QuestionnaireQuestion  where QuestionnaireID =  " + Args.DataReader("QuestionnaireID").ToString
                                    intCntOfQuestionaireID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLCntOfQuestionaireID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Integer)
                                    If intCntOfQuestionaireID = 0 Then
                                        Cancel = True
                                        Args.StringToBeInserted = "<TD align=Center Title=""Column Name : Publish"">"
                                        Args.StringToBeInserted += "<A href='JavaScript:PublishNoItems_OnClick()' >Publish"
                                        Args.StringToBeInserted += "</A>"
                                        Args.StringToBeInserted += "</TD>"
                                        Args.StringToBeInserted += "<Script language='JavaScript'>"
                                        Args.StringToBeInserted += " function PublishNoItems_OnClick() { "
                                        Args.StringToBeInserted += " alert('There are no checklist items present against this checklist, cannot Publish it');"
                                        Args.StringToBeInserted += " }"
                                        Args.StringToBeInserted += "</Script>"
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(drCntOfQuestionaire)
                                End If
                            End If
                            'end of addition by harshada d

                            'added by SachinR   on 22 Jul 2004
                            'purpose    To implement Process definition workflow
                        Case CommonFunction.Constants.APP_TAG_PROCESS_PHASETASK
                            Dim strPhaseTaskID As String
                            'Dim strRevisionNo As String
                            'Dim intActivityAssociated As Integer
                            'Dim strTemplateNames As String
                            Dim strSQL As String
                            'Dim objDR As IDataReader
                            Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

                            strPhaseTaskID = CommonFunction.Data.CheckIsDBNull(Args.DataReader("PhaseTaskID"), "").ToString + ""

                            'if status="D" then display link as publish,else dont display link
                            If Args.DataField.ToLower = "hyperlink1" Then
                                'strSQL = "usp_Sel_Prs_CheckIsPhaseTaskPublished " + strPhaseTaskID.Trim

                                If CommonFunction.Data.CheckIsDBNull(Args.DataReader("Status"), "").ToString = "P" Then
                                    'If the Process is published thendo not show the link.
                                    Args.IgnoreActualValue = True
                                    'Create object of the ProjectByNet Template Class
                                    objTemplate = New WebPages.Template.WhizTemplate
                                    'Initialize the Resources
                                    objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                    Args.ReplacementValue = "<FONT color='RED'>" + objTemplate.GetResourceString("PUBLISHED") + "</FONT>"
                                    Args.EnableLink = False
                                    objTemplate = Nothing
                                End If
                            End If

                            If Args.ColumnName.ToUpper = "DELETE" Then
                                'if phase task is published(if templates are associated with it) then can not be deleted
                                strSQL = "usp_Sel_Prs_CheckIsPhaseTaskPublished " + strPhaseTaskID.Trim
                                If CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, blnUseSQL), "0"), Integer) > 0 Then
                                    Args.IsCheckBoxDisabled = True
                                End If
                            End If
                            'addition end

                            'added by SachinR   on 27 jul 2004
                        Case CommonFunction.Constants.APP_TAG_PROCESS_PHASETASK_TEMPLATES
                            Dim strTemplateID As String
                            Dim strSQL As String
                            Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
                            strTemplateID = CommonFunction.Data.CheckIsDBNull(Args.DataReader("TemplateID"), "").ToString + ""

                            'if status="D" then display link as publish,else dont display link
                            If Args.DataField.ToLower = "hyperlink1" Then
                                strSQL = "usp_Sel_tbl_PRS_PhaseTask_Template_IsPublished " + strTemplateID.Trim

                                If CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, blnUseSQL), "0"), Integer) > 0 Then
                                    'If the template is published then do not show the link..
                                    Args.IgnoreActualValue = True
                                    'Create object of the ProjectByNet Template Class
                                    objTemplate = New WebPages.Template.WhizTemplate
                                    'Initialize the Resources
                                    objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                    Args.ReplacementValue = "<FONT color='RED'>" + objTemplate.GetResourceString("PUBLISHED") + "</FONT>"
                                    Args.EnableLink = False
                                    objTemplate = Nothing
                                End If
                            End If

                            If Args.ColumnName.ToUpper = "DELETE" Then
                                'if phase task is published(if templates are associated with it) then can not be deleted
                                strSQL = "usp_Sel_CheckIsPhaseTaskTemplatePublished_ForDelete " + strTemplateID.Trim
                                If CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, blnUseSQL), "0"), Integer) > 0 Then
                                    Args.IsCheckBoxDisabled = True
                                End If
                            End If
                            'addition end

                            'Added by ShamkantD on 26th July 2004 - added to hide Delete column
                        Case CommonFunction.Constants.APP_TAG_CONFIG_COMMERICAL_CONTRACT_TYPE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End of addition - ShamkantD on 26th July 2004 

                            '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197 
                        Case CommonFunction.Constants.APP_TAG_CRM_TASKS_LIST
                            Dim m_strToken As String
                            m_strToken = CommonFunctions.Security.Token.GetToken(CType(HttpContext.Current.Request.QueryString("CRMQueryID"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0")

                            If Args.DataField.ToUpper = "EMPLOYEENAME" Then
                                ''Args.StringToBeInserted = "<TD Align='Center'><A href='../RFI/RFI_RFI.aspx?Mode=Edit&UserType=Initiator&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & m_strToken & "'>" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("RFI"), ""), "").ToString() & "</a> </TD>"
                                Args.StringToBeInserted = "<TD Align='Center'><A href='../CRM/CRM_RequestAssignment.aspx?Mode=ASSIGN_TASK&Action=EDIT&TaskID=" & CType(Args.DataReader("TaskID"), Long) & "&FromWhere=CRM&PagingAlphabet=&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&CRMQueryID=" & CType(HttpContext.Current.Request.QueryString("CRMQueryID"), String) & "&PKToken=" & m_strToken & "'>" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EmployeeName"), ""), "").ToString() & "</a> </TD>"
                                Cancel = True
                            End If
                            '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197  

                        Case CommonFunction.Constants.APP_TAG_RFI_INITIATOR
                            'Added by MonikaI on 28-Sep-2006 .IssueID : 6492 (Security)
                            'Dim drIR As IDataReader
                            Dim m_sQuery As String
                            Dim m_blnIsProjectOver As Boolean

                            Dim m_objAccessRights As WebPages.Security.cAccessRights
                            m_objAccessRights = New WebPages.Security.cAccessRights(WhizGlobal)
                            m_objAccessRights.GetAccess()

                            m_blnIsProjectOver = CType(Args.DataReader("IsProjectOver"), Boolean)

                            'm_sQuery = "usp_sel_tbl_PM_Project_TaskCaseStructure " & CType(HttpContext.Current.Session("intProjectID"), String)
                            'drIR = CommonFunction.Data.GetDataReader(m_sQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            'If drIR.Read() Then
                            '    m_blnIsProjectOver = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drIR("Over"), "0"), "0"), Boolean)
                            'End If

                            'CommonFunction.Data.DisposeDataReader(drIR)


                            If Args.DataField.ToUpper = "COPY IR" Then

                                If m_blnIsProjectOver = True Or m_objAccessRights.Add = False Then
                                    'Args.EnableLink = False
                                    Args.IgnoreActualValue = True
                                    Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/Copy.gif' title='Copy IR' ></A></TD>"
                                    Cancel = True
                                    Args.EnableLink = False
                                Else
                                    'Added by TruptiK on 30-May-2007
                                    Dim objAppResource As WebPages.Template.WhizTemplate
                                    objAppResource = New WebPages.Template.WhizTemplate
                                    objAppResource.InitializeResources("AppResources.EventHandlers", "AppResources")
                                    Dim m_strToken As String
                                    Dim strSqlQuery As String
                                    Dim str As String
                                    Dim m_strRFID As String
                                    m_strRFID = CType(Args.DataReader.Item("RFIID"), String)
                                    'strSqlQuery = "EXEC usp_Validation_BillingCurrencyConversionRate " + CType(HttpContext.Current.Session("intProjectID"), String) + "," + m_strRFID
                                    ' str = CType(CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), ""), ""), String)
                                    str = Args.DataReader("msgConversionRate").ToString
                                    m_strToken = CommonFunctions.Security.Token.GetToken(CType(0, String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))
                                    'If str.ToUpper = "" Then
                                    'Args.IgnoreActualValue = True
                                    Cancel = True
                                    'Args.ReplacementValue = "<A href='../RFI/RFI_RFI.aspx?Mode=New&Action=Copy&UserType=Initiator&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & m_strToken & "'>Copy IR</a>"
                                    'Args.ReplacementValue = "<A href='javascript: var objChild=window.open (""../RFI/RFI_RFIChecklist.aspx?FromList=1&ReSubmit=1&SubmitRFI=1&RFIID=" + CType(Args.DataReader.Item("RFIID"), String) + "&PKToken=" + m_strToken + ""","""",""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 700)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=700,height=500""); '>ReSubmit IR</a>"
                                    'End of addition by TruptiK
                                    '    Args.IgnoreActualValue = True
                                    'Added by TruptiK on 19-Jun-2007
                                    'Purpose:-To give alert before copy any RFI.
                                    Args.StringToBeInserted = "<TD align=Center Title=""Column Name : Copy IR"">"
                                    Args.StringToBeInserted += "<A href='javascript:CopyRFI1(""" + m_strRFID + """,""" + m_strToken + """,""" + str + """)' ><IMG Border=0  SRC='../../Images/Copy.gif' title='Copy IR' >"
                                    Args.StringToBeInserted += "</A>"
                                    Args.StringToBeInserted += "</TD>"
                                    'Args.StringToBeInserted = "<A href='javascript:CopyRFI(""" + m_strRFID + """,""" + m_strToken + """)'>Copy IR</A>"
                                    Args.StringToBeInserted += "<Script language='JavaScript'>"
                                    Args.StringToBeInserted += "function CopyRFI1(STRRFIID,token,str) { "
                                    Args.StringToBeInserted += "var ans;" + vbCrLf
                                    '''''''''''''''''''''
                                    'Args.StringToBeInserted += "var str='" + str + "';" + vbCrLf
                                    Args.StringToBeInserted += "if(str==""NO_IRCOMPANY_BASE_CONVERSRIONRATE"") {" + vbCrLf
                                    Args.StringToBeInserted += "alert('" + objAppResource.GetResourceString("IRCOMPANY_BASE_CONVERSRIONRATE") + "');" + vbCrLf
                                    Args.StringToBeInserted += "return; }" + vbCrLf

                                    Args.StringToBeInserted += "if(str==""NO_CORPORATE_BASE_CONVERSRIONRATE"")" + vbCrLf
                                    Args.StringToBeInserted += " {"
                                    Args.StringToBeInserted += "alert('" + objAppResource.GetResourceString("CORPORATE_BASE_CONVERSRIONRATE") + "');" + vbCrLf
                                    Args.StringToBeInserted += "return; }" + vbCrLf

                                    '''''''''''''''''''
                                    Args.StringToBeInserted += "ans=window.confirm('Do you want to Copy this IR?');" + vbCrLf
                                    Args.StringToBeInserted += "if(ans==false)" + vbCrLf
                                    Args.StringToBeInserted += "return;" + vbCrLf
                                    Args.StringToBeInserted += "else" + vbCrLf

                                    ''Commented and Added by Dhanashri S on 21 Dec 2015 For IssueID:2809
                                    ''Args.StringToBeInserted += "window.location.href (""../RFI/RFI_RFI.aspx?Mode=New&Action=Copy&UserType=Initiator&RFIID=""+ STRRFIID + "" &PKToken="" + token);" + vbCrLf
                                    Args.StringToBeInserted += "window.location.href = ""../RFI/RFI_RFI.aspx?Mode=New&Action=Copy&UserType=Initiator&RFIID=""+ STRRFIID + "" &PKToken="" + token;" + vbCrLf
                                    ''End of Comment and Addition by Dhanashri S on 21 Dec 2015

                                    'Args.StringToBeInserted += "<A href='../RFI/RFI_RFI.aspx?Mode=New&Action=Copy&UserType=Initiator&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & m_strToken & "'>Copy IR</a>"
                                    Args.StringToBeInserted += " }"
                                    Args.StringToBeInserted += "</Script>"
                                    'End of addition by TruptiK on 19-Jun-2007
                                    'End by MonikaI
                                    'End If


                                End If
                            End If
                            'End of addition by MonikaI

                            'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                            If Args.DataField.ToUpper = "RFI" Then
                                Dim m_strToken As String
                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))
                                'Commented and added by MonikaI on 13th Oct 2006 IssueID : 6498
                                'Args.StringToBeInserted = "<TD Align='Center'><A href='../RFI/RFI_RFI.aspx?Mode=Edit&UserType=Initiator&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & m_strToken & "'>" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("RFI"), ""), "").ToString() & "</a> </TD>"
                                'Cancel = True
                                Args.IgnoreActualValue = True
                                Args.ReplacementValue = "<A href='../RFI/RFI_RFI.aspx?Mode=Edit&UserType=Initiator&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & m_strToken & "'>" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("RFI"), ""), "").ToString() & "</a>"

                                '" + strToBeInsearted + "
                                'End by MonikaI
                            End If
                            'End of addition by Monika

                            If Args.DataField.ToUpper = "RFIID" Then
                                Args.EnableLink = False
                            End If
                            If Args.DataField.ToUpper = "CURRENTSTATUS" Then
                                'Modified by SavitaS on 06 Oct 06 for crash Issue
                                'If CType(Args.DataReader.Item("CurrentStatus"), String) = "Draft" Then
                                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("CurrentStatus"), ""), String) = "DRAFT" Then
                                    'End of Modified by SavitaS on 06 Oct 06 for crash Issue
                                    Args.EnableLink = False
                                End If
                            End If
                            ''Added and commetned by PrashantSJ on 02 july 2007 for WhizibleSEM 7.0
                            ''Changed the column name Show invoice to Print Invoice
                            'If Args.ColumnName.ToUpper = "SHOW INVOICE(S)" Then
                            If Args.ColumnName.ToUpper = "PRINT INVOICE(S)" Then
                                ''End of addition by PrashantSJ on 02 july 2007 For WhizibleSEM 7.0
                                If CType(Args.DataReader.Item("InvoiceGenerated"), Boolean) = False Then
                                    If Not Args.ShowInContextMenu Then
                                        Args.IgnoreActualValue = True
                                        'Create object of the ProjectByNet Template Class
                                        objTemplate = New WebPages.Template.WhizTemplate
                                        'Initialize the Resources
                                        objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                        Args.ReplacementValue = objTemplate.GetResourceString("NOT_APPLICABLE")
                                        Args.EnableLink = False
                                        objTemplate = Nothing
                                    Else
                                        Args.ContextMenuNode_FunctionCall = "&quot;&quot;"
                                        Args.ReplacementValue = "Print Invoice(s)"
                                        Args.EnableLink = False
                                    End If

                                End If
                            End If
                            If Args.DataField.ToUpper = "HYPERLINK2" Then
                                If m_blnIsProjectOver = True Or m_objAccessRights.Edit = False Then
                                    Args.EnableLink = False
                                    Args.IgnoreActualValue = True

                                    If CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("CurrentStatus")).ToString.ToLower = "rejected" Then
                                        Args.ReplacementValue = "ReSubmit IR"
                                    ElseIf CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("CurrentStatus")).ToString.ToLower = "draft" Then
                                        Args.ReplacementValue = "Submit IR"
                                    End If

                                Else
                                    Dim m_strToken As String
                                    m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String) + "Submitted")
                                    ''Added by PrashantSJ on 22 June 2007 For WhizibleSEM 7.0 
                                    ''Purpose: To check IR Approver before submitting IR
                                    'Dim m_iFlag As Integer
                                    'Dim drRFI As IDataReader
                                    'Dim m_sSQL As String = ""
                                    Dim m_sHTML As String = ""

                                    'm_sSQL = "usp_Validation_IR_BillingBaseLocalCompanyBaseCurrency " & CType(HttpContext.Current.Session("intProjectID"), String)
                                    'drRFI = CommonFunction.Data.GetDataReader(m_sSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    'If drRFI.Read() Then
                                    '    m_iFlag = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drRFI("IRApprover"), "0"), "0"), Integer)
                                    'End If

                                    'CommonFunction.Data.DisposeDataReader(drRFI)

                                    'Commented and modified by MonikaI on 21-Sep-2006. IssueID : 6197 (Security)
                                    If CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("CurrentStatus")).ToString.ToLower = "rejected" Then
                                        ''Create object of the ProjectByNet Template Class
                                        'objTemplate = New WebPages.Template.WhizTemplate
                                        ''Initialize the Resources
                                        'objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                        'Args.IgnoreActualValue = True
                                        'Args.ReplacementValue = objTemplate.GetResourceString("RFI_RESUBMIT")
                                        'objTemplate = Nothing
                                        'Modified by SavitaS on 06 Oct 06 for crash Issue
                                        'Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Initiator&Comments=Details&RFIMode=Submit&MasterTagID=2073&ChecklistInstanceID=" & CType(Args.DataReader.Item("ChecklistInstanceID"), String) & "&CurrentStatus=" & CType(Args.DataReader.Item("CurrentStatus"), String) & "&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & m_strToken & ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-300)/2 + "",width=500,height=300"");'>ReSubmit IR</a> </TD>"

                                        'Commented and added by MonikaI on 13th Oct 2006 IssueID : 6498
                                        'Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Initiator&Comments=Details&RFIMode=Submit&MasterTagID=2073&ChecklistInstanceID=" & CType(Args.DataReader.Item("ChecklistInstanceID"), String) & "&CurrentStatus=" & CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("CurrentStatus"), ""), String) & "&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & m_strToken & ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-300)/2 + "",width=500,height=300"");'>ReSubmit IR</a> </TD>"
                                        'Cancel = True
                                        Args.IgnoreActualValue = True
                                        ''Added and commented by PrashantSJ on 27th Apr 2006
                                        ''Purpose: To open Checklist page while clicking Submit IR link if that IR already doesn't have checklists
                                        ' Args.ReplacementValue = "<A href='javascript: var objChild= window.open(""../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Initiator&Comments=Details&RFIMode=Submit&MasterTagID=2073&ChecklistInstanceID=" & CType(Args.DataReader.Item("ChecklistInstanceID"), String) & "&CurrentStatus=" & CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("CurrentStatus"), ""), String) & "&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & m_strToken & ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-300)/2 + "",width=500,height=300"");'>ReSubmit IR</a>"
                                        If CType(Args.DataReader("IsApproverExists"), Boolean) = False Then
                                            Args.ReplacementValue = "<A href='javascript: alert(""Please set the IR Approver for project!""); '>ReSubmit IR</a>"
                                        Else
                                            Args.ReplacementValue = "<A href='javascript: var objChild=window.open (""../RFI/RFI_RFIChecklist.aspx?FromList=1&ReSubmit=1&SubmitRFI=1&RFIID=" + CType(Args.DataReader.Item("RFIID"), String) + "&PKToken=" + m_strToken + ""","""",""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 700)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=700,height=500""); '>ReSubmit IR</a>"
                                        End If
                                    ElseIf CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("CurrentStatus")).ToString.ToLower = "draft" Then
                                        'End by MonikaI
                                        'Else
                                        'Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Initiator&Comments=Details&RFIMode=Submit&MasterTagID=2073&ChecklistInstanceID=" & CType(Args.DataReader.Item("ChecklistInstanceID"), String) & "&CurrentStatus=" & CType(Args.DataReader.Item("CurrentStatus"), String) & "&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & CType(m_strToken, String) & ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-300)/2 + "",width=500,height=300"");'>Submit IR</a> </TD>"

                                        'Commented and added by MonikaI on 13th Oct 2006 IssueID : 6498
                                        'Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Initiator&Comments=Details&RFIMode=Submit&MasterTagID=2073&ChecklistInstanceID=" & CType(Args.DataReader.Item("ChecklistInstanceID"), String) & "&CurrentStatus=" & CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("CurrentStatus"), ""), String) & "&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & CType(m_strToken, String) & ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-300)/2 + "",width=500,height=300"");'>Submit IR</a> </TD>"
                                        'Cancel = True
                                        'End of Modified by SavitaS on 06 Oct 06 for crash Issue
                                        Args.IgnoreActualValue = True
                                        If CType(Args.DataReader("IsApproverExists"), Boolean) = False Then
                                            Args.ReplacementValue = "<A href='javascript: alert(""Please set the IR Approver for project ! ""); '>Submit IR</a>"
                                        Else

                                            If CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("ChecklistInstanceID")).ToString = "0" Then
                                                Args.ReplacementValue = "<A href='javascript:  var objChild= window.open (""../RFI/RFI_RFIChecklist.aspx?FromList=1&SubmitRFI=1&RFIID=" + CType(Args.DataReader.Item("RFIID"), String) + "&PKToken=" + m_strToken + ""","""",""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 700)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=700,height=500""); '>Submit IR</a>"
                                            Else
                                                Args.ReplacementValue = "<A href='javascript: var objChild= window.open(""../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Initiator&Comments=Details&RFIMode=Submit&MasterTagID=2073&ChecklistInstanceID=" & CType(Args.DataReader.Item("ChecklistInstanceID"), String) & "&CurrentStatus=" & CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("CurrentStatus"), ""), String) & "&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & CType(m_strToken, String) & ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-300)/2 + "",width=500,height=300"");'>Submit IR</a>"
                                            End If
                                        End If
                                        'End by MonikaI
                                        ''End of comment and addition  by PrashantSJ on 27th Apr 2006
                                    End If
                                    'End by MonikaI
                                End If
                            End If

                            ' Code added by SwapnilR on 25th Sept 2006
                            ' Purpose : Adding token id to the javascript function for security purpose
                            If Args.DataField.ToUpper = "HYPERLINK1" Then
                                Dim m_strToken As String
                                Dim m_strRFID As String
                                Dim m_strReportID As String
                                Dim strToBeInsearted As String

                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + "02044")
                                m_strRFID = CType(Args.DataReader.Item("RFIID"), String)
                                m_strReportID = CType(Args.DataReader.Item("ReportID"), String)

                                strToBeInsearted = "Javascript:Hyperlink1(&quot;" + m_strRFID + "&quot;,&quot;" + m_strReportID + "&quot;,&quot;" + m_strToken + "&quot;)"
                                'Commented and added by MonikaI on 13th Oct 2006 IssueID : 6498
                                'Cancel = True
                                'Args.StringToBeInserted = "<TD align=Left><A href= 'Javascript:Hyperlink1(""" + m_strRFID + """,""" + m_strReportID + """,""" + m_strToken + """)'>Show Report</A></TD>"
                                Args.IgnoreActualValue = True

                                ''Added and commetned by PrashantSJ on 02 july 2007 for WhizibleSEM 7.0
                                ''Changed the column name Show Report to Print IR Report
                                'Args.ReplacementValue = "<A href= 'Javascript:Hyperlink1(""" + m_strRFID + """,""" + m_strReportID + """,""" + m_strToken + """)'>Show Report</A>"
                                If Not Args.ShowInContextMenu Then
                                    Args.ReplacementValue = "<A href= '" + strToBeInsearted + "'>Print IR Report</A>"
                                Else
                                    Cancel = True
                                    Args.ContextMenuNode_ToolTip = "Print IR Report"
                                    Args.ContextMenuNode_FunctionCall = strToBeInsearted
                                    Args.ReplacementValue = "Print IR Report"
                                End If
                                ''End of addition by PrashantSJ on 02 july 2007 For WhizibleSEM 7.0
                                'End by MonikaI
                            End If
                            ' End of code addition by SwapnilR on 25th Sept 2006
                            m_objAccessRights = Nothing
                            'Added By VidyaJ - DA Performance Issue - 89 (SP4)
                        Case CommonFunction.Constants.APP_TAG_UPDATEACTUALS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.DataField.ToUpper = "LASTUPDATE" Then
                                Args.EnableLink = False
                            End If
                            'End Of addition


                            'Added By JayavantK On 30-Jul-2004 - Start
                        Case CommonFunction.Constants.APP_TAG_OUPOOL_MASTER
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_TAG_OUPools
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_TAG_TEAMPOOLS_EDIT
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_TAG_GLOBAL_RESOURCE_POOL
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_TAG_RESOURCE_POOL_VIEW
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            'End Addition
                            'Added By NileshD On 30 July 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_STATUS_HISTORY
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.DataField.ToUpper = "CURRENTRFISTATUS" Then
                                Args.EnableLink = False
                            End If
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_LIST
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.DataField.ToUpper = "INVOICEID" Then
                                Args.EnableLink = False
                            End If
                        Case CommonFunction.Constants.APP_TAG_RFI_TOOL
                            If Args.DataField.ToUpper = "DESCRIPTION" Then
                                Args.EnableLink = False
                            End If

                            '----------------------------------------------------------------------------------
                            'Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
                            'Added by GaneshG on 11 Jan 2006 -- Suppress the hyperlink
                        Case CommonFunction.Constants.APP_TAG_RFI_DELIVERABLES
                            If Args.DataField.Trim.ToUpper = "TITLE" Then
                                Args.EnableLink = False
                            End If
                            'End of addition - GaneshG 

                            'Added by GaneshG on 9 Jan 2006 -- Suppress the hyperlink
                        Case CommonFunction.Constants.APP_TAG_RFI_MILESTONE
                            If Args.DataField.Trim.ToUpper = "MILESTONE" Then
                                Args.EnableLink = False
                            End If
                            'End of addition - GaneshG 
                            'End Integration by SavitaS on 13 Mar 2006
                            '----------------------------------------------------------------------------------
                        Case CommonFunction.Constants.APP_TAG_RFI_OS
                            If Args.DataField.ToUpper = "OS" Then
                                Args.EnableLink = False
                            End If
                            'End Of Addition

                            'Added by ShamkantD on 28th July 2004 
                            '- added to show / hide grid according to the value selected in Role combobox
                            '  and to show the Select checkbox as checked for the selected attributes
                        Case CommonFunction.Constants.APP_TAG_CONFIG_WORKORDER_FIELD_ACCESS
                            Dim strReplacementValue As String
                            'If no Role selected, do not paint the grid columns
                            If HttpContext.Current.Request.Form("RoleID") = Nothing Then
                                Cancel = True
                            Else
                                'Remove link of the Attribut Name column
                                If Args.ColumnName.ToUpper = "FIELD / ATTRIBUTE NAME" Then
                                    Args.EnableLink = False
                                End If

                                If Args.ColumnName.ToUpper = "DELETE" Then
                                    'Show the Select checkbox as checked depending upon the selected attributes
                                    If Not IsDBNull(Args.DataReader("CheckAttribute")) Then
                                        If CType(Args.DataReader("CheckAttribute"), Boolean) = True Then
                                            Args.IgnoreActualValue = True
                                            Args.IsSelected = True
                                        End If
                                    End If
                                End If
                            End If
                            'End of addition - ShamkantD on 28th July 2004 
                            'Added By NileshD on 31 July 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_APPROVAL
                            'Added by JyotiG on 19-Sep-2006 .IssueID : 6197 (Security)
                            If Args.DataField.ToUpper = "RFI" Then
                                Dim m_strToken As String
                                Dim strToBeInsearted As String

                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2074, String) + CType(0, String) + CType(Args.DataReader.Item("ProjectID"), String))
                                'Commented and added by MonikaI on 13th Oct 2006 IssueID : 6498
                                'Args.StringToBeInserted = "<TD Align='Center'><A href='../RFI/RFI_RFI.aspx?Mode=Edit&UserType=Approver&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & m_strToken & "'>" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("RFI"), ""), "").ToString() & "</a> </TD>"
                                'Cancel = True

                                Args.IgnoreActualValue = True
                                Args.ReplacementValue = "<A href='../RFI/RFI_RFI.aspx?Mode=Edit&UserType=Approver&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & m_strToken & "'>" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("RFI"), ""), "").ToString() & "</a>"

                                'End by MonikaI
                            End If

                            If Args.DataField.ToUpper = "HYPERLINK2" Then
                                Dim m_strToken As String
                                Args.IgnoreActualValue = True
                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2074, String) + CType(0, String) + CType(Args.DataReader.Item("ProjectID"), String))
                                'Commented and added by MonikaI on 13th Oct 2006 IssueID : 6498
                                'Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Approver&Comments=Details&MasterTagID=2073&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & CType(m_strToken, String) & ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>Change Status</a> </TD>"
                                'Cancel = True
                                Args.IgnoreActualValue = True
                                'Modified by TruptiK on 9-May-2007
                                Args.ReplacementValue = "<A href='javascript: var objChild= window.open(""../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Approver&Comments=Approver&MasterTagID=2073&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & CType(m_strToken, String) & ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>Change Status</a>"
                                'End of Modification by TruptiK on 9-May-2007

                                'End by MonikaI
                            End If
                            'End of addition by JyotiG

                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.DataField.ToUpper = "RFIID" Then
                                Args.EnableLink = False
                            End If
                            'End Of Addition
                            'Added By JayavantK on 31 July 2004
                        Case CommonFunction.Constants.APP_TAG_BUSINESSGROUP
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End Of Addition
                            'Added By NileshD on 2 August 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_GENERATION
                            'Added by JyotiG on 19-Sep-2006 .IssueID : 6197 (Security)
                            If Args.DataField.ToUpper = "RFI" Then
                                Dim m_strToken As String
                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2083, String) + CType(0, String) + CType(Args.DataReader.Item("ProjectID"), String))
                                'Commented and added by MonikaI on 13th Oct 2006 IssueID : 6498
                                'Args.StringToBeInserted = "<TD Align='Center'><A href='../RFI/RFI_RFI.aspx?Mode=Edit&UserType=Accounts&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & m_strToken & "'>" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("RFI"), ""), "").ToString() & "</a> </TD>"
                                'Cancel = True
                                Args.IgnoreActualValue = True
                                Args.ReplacementValue = "<A href='../RFI/RFI_RFI.aspx?Mode=Edit&UserType=Accounts&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & m_strToken & "'>" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("RFI"), ""), "").ToString() & "</a>"
                                'End by MonikaI
                            End If
                            If Args.DataField.ToUpper = "HYPERLINK2" Then
                                Dim m_strToken As String
                                Args.IgnoreActualValue = True
                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2074, String) + CType(0, String) + CType(Args.DataReader.Item("ProjectID"), String))
                                'Commented and added by MonikaI on 13th Oct 2006 IssueID : 6498
                                'Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Approver&Comments=Details&MasterTagID=2073&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & CType(m_strToken, String) & ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>Change Status</a> </TD>"
                                'Cancel = True
                                Args.IgnoreActualValue = True
                                ''Added and commented by PrashantSJ on 5th June 2007 For WhizibleSEM 7.0 Build 3
                                ''Purpose: added one querystring parameter:-RFIMODE=Cancel
                                'Args.ReplacementValue = "<A href='javascript: var objChild= window.open(""../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Approver&Comments=Details&MasterTagID=2073&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & CType(m_strToken, String) & ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>Change Status</a>"
                                Args.ReplacementValue = "<A href='javascript: var objChild= window.open(""../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Approver&Comments=Details&&RFIMode=Cancel&MasterTagID=2073&RFIID=" & CType(Args.DataReader.Item("RFIID"), String) & "&PKToken=" & CType(m_strToken, String) & ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>Change Status</a>"
                                'End of addition by PrashantSJ on 5th June 2007
                                'End by MonikaI
                            End If
                            'End of addition by JyotiG
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.DataField.ToUpper = "RFIID" Then
                                Args.EnableLink = False
                            End If
                            'End Of Addition
                            'Added By NileshD on 3 August 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_DETAIL_LIST
                            ''Added by JyotiG on 19-Sep-2006 .IssueID : 6197 (Security)
                            If Args.DataField.ToUpper = "INVOICENUMBER" Then
                                Dim m_strToken As String
                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("InvoiceID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2084, String) + CType(0, String) + CType(Args.DataReader.Item("ProjectID"), String))
                                'Args.StringToBeInserted = "<TD Align='Center'><A href='../RFI/RFI_InvoiceGeneration.aspx?Mode=Edit&UserType=Accounts&InvoiceID=" & CType(Args.DataReader.Item("InvoiceID"), String) & "&PKToken=" & m_strToken & "','_blank'>" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("InvoiceNumber"), ""), "").ToString() & "</a> </TD>"

                                'Commented and added by MonikaI on 13th Oct 2006 IssueID : 6498
                                'Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../RFI/RFI_InvoiceGeneration.aspx?Mode=Edit&UserType=Accounts&InvoiceID=" & CType(Args.DataReader.Item("InvoiceID"), String) & "&PKToken=" & CType(m_strToken, String) & ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("InvoiceNumber"), ""), "").ToString() & "</a> </TD>"
                                'Cancel = True
                                Args.IgnoreActualValue = True
                                Args.ReplacementValue = "<A href='javascript: var objChild= window.open(""../RFI/RFI_InvoiceGeneration.aspx?Mode=Edit&UserType=Accounts&InvoiceID=" & CType(Args.DataReader.Item("InvoiceID"), String) & "&PKToken=" & CType(m_strToken, String) & ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=780,height=500"");'>" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("InvoiceNumber"), ""), "").ToString() & "</a>"
                                'End by MonikaI
                            End If
                            ''End of addition by JyotiG
                            If Args.DataField.ToUpper = "INVOICEID" Then
                                Args.EnableLink = False
                            End If
                            'End Of Addition
                            'Added By JyotiG
                            'Start
                            'Date : 21-Sep-2006
                        Case CommonFunction.Constants.APP_TAG_RFI_SENDINVOICEMAILS
                            ''Added by JyotiG on 19-Sep-2006 .IssueID : 6197 (Security)
                            If Args.DataField.ToUpper = "INVOICENUMBER" Then
                                Dim m_strToken As String
                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("InvoiceID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2173, String) + CType(0, String) + CType(Args.DataReader.Item("ProjectID"), String))
                                'Args.StringToBeInserted = "<TD Align='Center'><A href='../RFI/RFI_InvoiceGeneration.aspx?Mode=Edit&UserType=Accounts&InvoiceID=" & CType(Args.DataReader.Item("InvoiceID"), String) & "&PKToken=" & m_strToken & "','_blank'>" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("InvoiceNumber"), ""), "").ToString() & "</a> </TD>"

                                'Commented and added by MonikaI on 13th Oct 2006 IssueID : 6498
                                'Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../RFI/RFI_InvoiceGeneration.aspx?Mode=Edit&LoadFrom=Mail&UserType=Accounts&InvoiceID=" & CType(Args.DataReader.Item("InvoiceID"), String) & "&PKToken=" & CType(m_strToken, String) & ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("InvoiceNumber"), ""), "").ToString() & "</a> </TD>"
                                'Cancel = True
                                Args.IgnoreActualValue = True
                                Args.ReplacementValue = "<A href='javascript: var objChild= window.open(""../RFI/RFI_InvoiceGeneration.aspx?Mode=Edit&LoadFrom=Mail&UserType=Accounts&InvoiceID=" & CType(Args.DataReader.Item("InvoiceID"), String) & "&PKToken=" & CType(m_strToken, String) & ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("InvoiceNumber"), ""), "").ToString() & "</a>"
                                'End by MonikaI
                            End If
                            ''End of addition by JyotiG
                            If Args.DataField.ToUpper = "INVOICEID" Then
                                Args.EnableLink = False
                            End If
                            'End Of Addition
                            'End (JyotiG)
                        Case CommonFunctions.Constants.TAG_AUDIT_TRAIL
                            Args.EnableLink = False
                            If Args.DataField.ToUpper = "DATE" Then Args.ShowTimeWithDate = True

                            'Added By JayavantK on 4 August 2004
                        Case CommonFunction.Constants.APP_TAG_BGPOOL_MASTER
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End Of Addition

                            'Added By NileshD on 6 August 2004
                            'To Resolve IssueID 12266
                        Case CommonFunction.Constants.APP_TAG_RFI_CHECKLIST_VIEW
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.DataField.ToUpper = "RFICHECKLISTITEMID" Then
                                Args.EnableLink = False
                                ''Added by PrashantSJ on 6th June 2007 For WhizibleSEM 7.0 Build 3
                                ''Purpose: To display proper sr.no. (i.e 1,2..etc)
                                Args.IgnoreActualValue = True
                                Args.ReplacementValue = m_iRowCount.ToString

                                'End of addition by PrashantSJ on 6th June 2007
                            End If
                            'end Of Addition
                        Case CommonFunction.Constants.APP_TAG_RFI_SALES_PERSON
                            If Args.DataField.ToUpper = "USERNAME" Then
                                Args.EnableLink = False
                            End If

                            'Added by ShamkantD on 9th August 2004
                        Case CommonFunction.Constants.APP_TAG_PM_SERVICE_SEGMENTATION
                            If Args.DataField.ToUpper = "SERVICESSEGMENTATION" Then
                                Args.EnableLink = False
                            End If

                            If Args.DataField.ToUpper = "SERVICESSEGMENTATION" Then
                                'Suppress repeated Segmentation name
                                If CommonFunction.General.CheckIsNothing(Args.DataReader("ServiceOfferingID")).ToString <> "" _
                                    Or CommonFunction.General.CheckIsNothing(Args.DataReader("SubServiceOfferingID")).ToString <> "" Then
                                    Args.IgnoreActualValue = True
                                    Args.ReplacementValue = ""
                                End If
                            End If

                            If Args.DataField.ToUpper = "SERVICEOFFERINGNAME" Then
                                'Suppress repeated Service offering name
                                If CommonFunction.General.CheckIsNothing(Args.DataReader("SubServiceOfferingID")).ToString <> "" Then
                                    Args.IgnoreActualValue = True
                                    Args.ReplacementValue = ""
                                End If
                            End If

                            If Args.ColumnName.ToUpper = "DELETE" Then
                                'Render checkbox for Segmentation
                                If CommonFunction.General.CheckIsNothing(Args.DataReader("ServiceOfferingID")).ToString = "" _
                                    And CommonFunction.General.CheckIsNothing(Args.DataReader("SubServiceOfferingID")).ToString = "" Then

                                    Dim intServicesSegmentationID As String = Args.DataReader("ServicesSegmentationID").ToString.Trim

                                    Args.IgnoreActualValue = True
                                    Args.StringToBeInserted = "<TD align=center><input type = checkbox name=chkDomain id=chkDomain class='clsCheckBox'" _
                                        & " value = " & intServicesSegmentationID

                                    'If the Service Segmentation is selected for the current project, show the "Select" checkbox checked
                                    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strServicesSegmentationIDs")).ToString <> "" Then
                                        If InStr(HttpContext.Current.Session("strServicesSegmentationIDs").ToString, "," & intServicesSegmentationID & ",") > 0 Then
                                            Args.StringToBeInserted += " checked"
                                        End If
                                    End If

                                    Args.StringToBeInserted += " onclick=""javascript:chkDomain_OnClick(" _
                                        & intServicesSegmentationID & ")""></TD>"
                                    Cancel = True
                                End If

                                'Render checkbox for Service Offering
                                If CommonFunction.General.CheckIsNothing(Args.DataReader("ServiceOfferingID")).ToString <> "" _
                                    And CommonFunction.General.CheckIsNothing(Args.DataReader("SubServiceOfferingID")).ToString = "" Then

                                    Dim intServicesSegmentationID As String = Args.DataReader("ServicesSegmentationID").ToString.Trim
                                    Dim intServiceOfferingID As String = Args.DataReader("ServiceOfferingID").ToString.Trim

                                    Args.IgnoreActualValue = True
                                    Args.StringToBeInserted = "<TD align=center><input type = checkbox name=chkMarket id=chkMarket class='clsCheckBox'" _
                                        & " VALUE = " & intServicesSegmentationID & ":" & intServiceOfferingID

                                    'If the Service Offering is selected for the current project, show the "Select" checkbox checked
                                    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strServiceOfferingIDs")).ToString <> "" Then
                                        If InStr(HttpContext.Current.Session("strServiceOfferingIDs").ToString, "," & intServiceOfferingID & ",") > 0 Then
                                            Args.StringToBeInserted += " checked"
                                        End If
                                    End If

                                    Args.StringToBeInserted += " onclick=""javascript:chkMarket_OnClick(" _
                                        & intServicesSegmentationID & "," & intServiceOfferingID _
                                        & ")""></TD>"
                                    Cancel = True
                                End If

                                'Render checkbox for Sub Service Offering
                                If CommonFunction.General.CheckIsNothing(Args.DataReader("SubServiceOfferingID")).ToString <> "" Then

                                    Dim intServicesSegmentationID As String = Args.DataReader("ServicesSegmentationID").ToString.Trim
                                    Dim intServiceOfferingID As String = Args.DataReader("ServiceOfferingID").ToString.Trim
                                    Dim intSubServiceOfferingID As String = Args.DataReader("SubServiceOfferingID").ToString.Trim

                                    Args.IgnoreActualValue = True
                                    Args.StringToBeInserted = "<TD align=center><input type = checkbox name=chkSubMarket id=chkSubMarket class='clsCheckBox'" _
                                        & " VALUE = " & intServicesSegmentationID & ":" & intServiceOfferingID & ":" & intSubServiceOfferingID

                                    'If the Sub Service Offering is selected for the current project, show the "Select" checkbox checked
                                    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strSubServiceOfferingIDs")).ToString <> "" Then
                                        If InStr(HttpContext.Current.Session("strSubServiceOfferingIDs").ToString, "," & intSubServiceOfferingID & ",") > 0 Then
                                            Args.StringToBeInserted += " checked"
                                        End If
                                    End If

                                    Args.StringToBeInserted += " onclick=""javascript:chkSubMarket_OnClick(" _
                                        & intServicesSegmentationID & "," & intServiceOfferingID & "," & intSubServiceOfferingID _
                                        & ")""></TD>"
                                    Cancel = True
                                End If
                            End If
                            'End of addition - ShamkantD on 9th August 2004
                            '*********************
                            'Added by ShamkantD on 9th August 2004
                        Case CommonFunction.Constants.APP_TAG_PM_MARKET_SEGMENTATION
                            If Args.DataField.ToUpper = "DOMAINNAME" Then
                                Args.EnableLink = False
                            End If

                            If Args.DataField.ToUpper = "DOMAINNAME" Then
                                'Suppress repeated Segmentation name
                                If CommonFunction.General.CheckIsNothing(Args.DataReader("MarketID")).ToString <> "" _
                                    Or CommonFunction.General.CheckIsNothing(Args.DataReader("SubMarketId")).ToString <> "" Then
                                    Args.IgnoreActualValue = True
                                    Args.ReplacementValue = ""
                                End If
                            End If

                            If Args.DataField.ToUpper = "MARKETNAME" Then
                                'Suppress repeated Service offering name
                                If CommonFunction.General.CheckIsNothing(Args.DataReader("SubMarketID")).ToString <> "" Then
                                    Args.IgnoreActualValue = True
                                    Args.ReplacementValue = ""
                                End If
                            End If

                            If Args.ColumnName.ToUpper = "DELETE" Then
                                'Render checkbox for Segmentation
                                If CommonFunction.General.CheckIsNothing(Args.DataReader("MarketID")).ToString = "" _
                                    And CommonFunction.General.CheckIsNothing(Args.DataReader("SubMarketID")).ToString = "" Then

                                    Dim intDomainId As String = Args.DataReader("DomainID").ToString.Trim

                                    Args.IgnoreActualValue = True
                                    Args.StringToBeInserted = "<TD align=center><input type = checkbox name=chkDomain id=chkDomain class='clsCheckBox'" _
                                        & " value = " & intDomainId

                                    'If the market Segmentation is selected for the current project, show the "Select" checkbox checked
                                    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strDomainIDs")).ToString <> "" Then
                                        If InStr(HttpContext.Current.Session("strDomainIDs").ToString, "," & intDomainId & ",") > 0 Then
                                            Args.StringToBeInserted += " checked"
                                        End If
                                    End If

                                    Args.StringToBeInserted += " onclick=""javascript:chkDomain_OnClick(" _
                                        & intDomainId & ")""></TD>"
                                    Cancel = True
                                End If

                                'Render checkbox for Market
                                If CommonFunction.General.CheckIsNothing(Args.DataReader("MarketID")).ToString <> "" _
                                    And CommonFunction.General.CheckIsNothing(Args.DataReader("SubMarketID")).ToString = "" Then

                                    Dim intDomainID As String = Args.DataReader("DomainID").ToString.Trim
                                    Dim intMarketID As String = Args.DataReader("MarketID").ToString.Trim

                                    Args.IgnoreActualValue = True
                                    Args.StringToBeInserted = "<TD align=center><input type = checkbox name=chkMarket id=chkMarket class='clsCheckBox'" _
                                        & " VALUE = " & intDomainID & ":" & intMarketID

                                    'If the Market is selected for the current project, show the "Select" checkbox checked
                                    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strMarketIDs")).ToString <> "" Then
                                        If InStr(HttpContext.Current.Session("strMarketIDs").ToString, "," & intMarketID & ",") > 0 Then
                                            Args.StringToBeInserted += " checked"
                                        End If
                                    End If

                                    Args.StringToBeInserted += " onclick=""javascript:chkMarket_OnClick(" _
                                        & intDomainID & "," & intMarketID _
                                        & ")""></TD>"
                                    Cancel = True
                                End If

                                'Render checkbox for Sub Market
                                If CommonFunction.General.CheckIsNothing(Args.DataReader("SubMarketID")).ToString <> "" Then

                                    Dim intDomainID As String = Args.DataReader("DomainID").ToString.Trim
                                    Dim intMarketID As String = Args.DataReader("MarketID").ToString.Trim
                                    Dim intSubMarketID As String = Args.DataReader("SubMarketID").ToString.Trim

                                    Args.IgnoreActualValue = True
                                    Args.StringToBeInserted = "<TD align=center><input type = checkbox name=chkSubMarket id=chkSubMarket class='clsCheckBox'" _
                                        & " VALUE = " & intDomainID & ":" & intMarketID & ":" & intSubMarketID

                                    'If the Sub Service Offering is selected for the current project, show the "Select" checkbox checked
                                    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strSubMarketIDs")).ToString <> "" Then
                                        If InStr(HttpContext.Current.Session("strSubMarketIDs").ToString, "," & intSubMarketID & ",") > 0 Then
                                            Args.StringToBeInserted += " checked"
                                        End If
                                    End If

                                    Args.StringToBeInserted += " onclick=""javascript:chkSubMarket_OnClick(" _
                                        & intDomainID & "," & intMarketID & "," & intSubMarketID _
                                        & ")""></TD>"
                                    Cancel = True
                                End If
                            End If
                            'End of addition - Paresh B on September 06, 2004.

                            '*********************


                            '##### Cases For Resource Timesheet Flow on 10 AUG 2004
                        Case CommonFunction.Constants.APP_TAG_RES_TMSHEET_TASK_DETAILS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            If Args.ColumnName.ToUpper = "ENTRY DATE" Then
                                Args.EnableLink = False
                            End If


                        Case CommonFunction.Constants.APP_Tag_ROWWISE_APPROVERS_HISTORY
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            If Args.ColumnName.ToUpper = "RESOURCE NAME" Then
                                Args.EnableLink = False
                            End If


                        Case CommonFunction.Constants.APP_Tag_TIMESHEET_SHOW_REMARKS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            If Args.ColumnName.ToUpper = "ENTRY DATE" Then
                                Args.EnableLink = False
                            End If

                        Case CommonFunction.Constants.APP_TAG_RTS_SHOW_HISTORY_EMPLOYEE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            If Args.ColumnName.ToUpper = "ACTION TAKEN" Then
                                Args.EnableLink = False
                            End If

                            If Args.ColumnName.ToUpper = "GENERATION DATE" Then
                                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CreatedDate"), ""), String) <> "" Then
                                    Cancel = True
                                    Args.StringToBeInserted = "<TD nowrap  align=Right >" + CType(CommonFunctions.Dates.CGetDateTime(CDate(Args.DataReader("CreatedDate"))), String) + "</TD>"
                                End If
                            End If

                            If Args.ColumnName.ToUpper = "UPDATED DATE" Then
                                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("UpdatedDate"), ""), String) <> "" Then
                                    Cancel = True
                                    Args.StringToBeInserted = "<TD nowrap  align=Right >" + CType(CommonFunctions.Dates.CGetDateTime(CDate(Args.DataReader("UpdatedDate"))), String) + "</TD>"
                                End If
                            End If

                        Case CommonFunction.Constants.APP_TAG_RTS_SHOW_HISTORY_APPROVERS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            If Args.ColumnName.ToUpper = "ACTION TAKEN" Then
                                Args.EnableLink = False
                            End If

                            If Args.ColumnName.ToUpper = "GENERATION DATE" Then
                                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CreatedDate"), ""), String) <> "" Then
                                    Cancel = True
                                    Args.StringToBeInserted = "<TD nowrap  align=Right >" + CType(CommonFunctions.Dates.CGetDateTime(CDate(Args.DataReader("CreatedDate"))), String) + "</TD>"
                                End If
                            End If

                            If Args.ColumnName.ToUpper = "UPDATED DATE" Then
                                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("UpdatedDate"), ""), String) <> "" Then
                                    Cancel = True
                                    Args.StringToBeInserted = "<TD nowrap  align=Right >" + CType(CommonFunctions.Dates.CGetDateTime(CDate(Args.DataReader("UpdatedDate"))), String) + "</TD>"
                                End If
                            End If


                        Case CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET
                            Dim strSQL As String
                            Dim strStatus As String
                            Dim strStatusDescription As String
                            Dim drResourceTimesheetStatus As IDataReader
                            strSQL = "SELECT Status AS StatusCode,StatusDescription FROM tbl_PM_ResourceTimesheetStatus RTS, tbl_PM_Timesheet_Status TS WHERE RTS.Status = TS.StatusCode AND ResourceTimesheetID = " + CType(Args.DataReader.Item("TimesheetID"), String) + " AND ApproverID = " + CType(HttpContext.Current.Session("intUserID"), String)
                            drResourceTimesheetStatus = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            If drResourceTimesheetStatus.Read Then
                                strStatus = CType(CommonFunctions.Data.CheckIsDBNull(drResourceTimesheetStatus("StatusCode"), ""), String)
                                strStatusDescription = CType(CommonFunctions.Data.CheckIsDBNull(drResourceTimesheetStatus("StatusDescription"), ""), String)

                            Else
                                strStatus = CType(Args.DataReader("StatusCode"), String)
                                strStatusDescription = CType(Args.DataReader("StatusDescription"), String)
                            End If
                            CommonFunctions.Data.DisposeDataReader(drResourceTimesheetStatus)

                            If Args.ColumnName.ToUpper = "STATUS" Then
                                Args.IgnoreActualValue = True
                                Args.ReplacementValue = strStatusDescription
                            End If

                            If Args.ColumnName.ToUpper = "EMPLOYEE NAME" Then
                                'If CType(Args.DataReader.Item("StatusCode"), String) = "N" Then
                                '    Args.StringToBeInserted = "<TD Align='Center'>" + Args.DataReader.Item("EmployeeName") + " </TD>"
                                'Else
                                '    If CType(Args.DataReader.Item("StatusCode"), String) = "V" Then
                                '        'Args.StringToBeInserted = "<TD Align='Center'> <a href=../../AE/PM/PM_VerifyResourceTimesheetDetails.aspx?TimesheetID=" + CType(Args.DataReader.Item("TimesheetID"), String) + "&EmployeeID=" + CType(Args.DataReader.Item("EmployeeID"), String) + "&Status=" + CType(Args.DataReader.Item("StatusCode"), String) + ">" + Args.DataReader.Item("EmployeeName") + " </a> </TD>"
                                '        Args.StringToBeInserted = "<TD Align='Center'> <a href=../../AE/PM/PM_VerifyResourceTimesheetDetails.aspx?TimesheetID=" + CType(Args.DataReader.Item("TimesheetID"), String) + "&EmployeeID=" + CType(Args.DataReader.Item("EmployeeID"), String) + "&TimesheetStatus=V" + ">" + Args.DataReader.Item("EmployeeName") + " </a> </TD>"
                                '    Else
                                '        Args.StringToBeInserted = "<TD Align='Center'> <a href=../../AE/PM/PM_VerifyResourceTimesheetDetails.aspx?TimesheetID=" + CType(Args.DataReader.Item("TimesheetID"), String) + "&EmployeeID=" + CType(Args.DataReader.Item("EmployeeID"), String) + "&TimesheetStatus=N" + CType(Args.DataReader.Item("StatusCode"), String) + ">" + Args.DataReader.Item("EmployeeName") + " </a> </TD>"
                                '    End If
                                'End If

                                If strStatus = "N" Or strStatus = "J" Then

                                    Args.StringToBeInserted = "<TD Align='Left'> " + CType(Args.DataReader.Item("EmployeeName"), String) + "</TD>"
                                Else
                                    Args.StringToBeInserted = "<TD Align='Left'> <a href=../RT/RT_VerifyResourceTimesheetDetails.aspx?TimesheetID=" + CType(Args.DataReader.Item("TimesheetID"), String) + "&EmployeeID=" + CType(Args.DataReader.Item("EmployeeID"), String) + "&TimesheetStatus=" + CType(strStatus, String) + ">" + CType(Args.DataReader.Item("EmployeeName"), String) + " </a> </TD>"
                                End If

                                Cancel = True
                            End If

                            If Args.ColumnName.ToUpper = "ACTUAL WORK (HRS)" Then
                                Dim strResourceTimesheetID As String
                                Dim strQuery As String
                                Dim drGetDADetails As IDataReader
                                Dim dblTotalAMH As Double
                                dblTotalAMH = 0
                                strResourceTimesheetID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TimesheetID"), ""), String)
                                strQuery = "usp_Sel_ResourceTimesheetDADetails " + CType(strResourceTimesheetID, String) + "," + CType(HttpContext.Current.Session("intUserID"), String)
                                drGetDADetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                While drGetDADetails.Read
                                    dblTotalAMH = dblTotalAMH + CType(CommonFunction.Data.CheckIsDBNull(drGetDADetails("TotalAMH"), "0"), Double)
                                End While

                                CommonFunction.Data.DisposeDataReader(drGetDADetails)

                                Args.IgnoreActualValue = True
                                Args.ReplacementValue = CType(FormatNumber(dblTotalAMH, 2), String)

                            End If

                            '##### End Of Cases For Resource Timesheet Flow

                            '-----Added by DiptiK on 25 Sep 2k4
                        Case CommonFunction.Constants.APP_TAG_TAB_BASELINE_REVISION
                            'Added by ShamkantD on 29 Sep 2004 - added for Show Revisions (Project Information) page
                            If Args.DataField.ToUpper() = "BASELINENUMBER" Then
                                Args.EnableLink = False
                            End If
                            'End of addition - ShamkantD on 29 Sep 2004

                            'Modified by ShamkantD on 29 Sep 2004
                            If Args.DataField.ToUpper = "HYPERLINK1" Then
                                Dim strRevisionReasonID As String = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("RevisionReasonID"), "0"), "0").ToString()
                                Dim strMode As String = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("RevisionReason"), ""), "").ToString().ToUpper()
                                Args.StringToBeInserted = "<TD Align='Center'> <a href=""javascript:ShowReason(" & strRevisionReasonID & ",'" & strMode & "')"">" + "Show Reason </A> </TD>"
                                'End of modification - ShamkantD on 29 Sep 2004
                                'Added by ShamkantD on 27 Sep 2004
                                Cancel = True
                                'End of addition - ShamkantD on 27 Sep 2004
                            End If
                            'Modified By JyotiG
                            'Date :24-Aug-2006
                            'Issue ID : 5687
                            'Start
                            If Args.DataField.ToUpper = "HYPERLINK2" Then
                                Dim strRevisionReasonID As String = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("RevisionReasonID"), "0"), "0").ToString()
                                Dim strMode As String = "S"
                                Args.StringToBeInserted = "<TD Align='Center'> <a href=""javascript:SenderComment(" & strRevisionReasonID & ",'" & strMode & "')"">" + "Sender Comments</A> </TD>"
                                Cancel = True
                            End If
                            'End
                            'added by SachinR   on 13 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLES
                            'here dummy column is canceled so as to apply the hyperlink given to the control
                            If Args.DataField = "LabelScheduleAlias" Then
                                Args.EnableLink = False
                                Cancel = True
                            End If
                            'addition end
                            'added by SachinR   on 13 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                            ''grid columns are hidden if field is not applicable to deliverable type 
                            'Dim strSQL As String
                            'Dim objDr As IDataReader
                            Dim strScheduleID As String
                            'Dim blnUseSQL As Boolean
                            'blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

                            'Modified By VidyaJ - Performance Issue - Deliverable - SP4 - IssueID -84

                            'Initialized DeliverableTypeID in session variable in UI list Pre Render  event

                            'strSQL = "Select isnull(FixedValue,0) 'FixedValue' From tbl_ui_EmployeeFilterSettings_FieldDetails Where TagID=" + CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString
                            'strSQL += " And ControlName='DeliverableTypeID' And UserID=" + WhizGlobal.UserID.ToString
                            'strSQL += " And LoginType='" + WhizGlobal.LoginType.Trim + "'"
                            'objDr = CommonFunction.Data.GetDataReader(strSQL, blnUseSQL)
                            'If objDr.Read Then
                            '    strScheduleID = CommonFunction.Data.CheckIsDBNull(objDr("FixedValue"), "").ToString + ""
                            'End If
                            'CommonFunction.Data.DisposeDataReader(objDr)
                            'If strScheduleID = "" Then strScheduleID = "0"
                            ''strScheduleID = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, blnUseSQL), "NULL").tostring

                            'added by SachinR   on 02 Nov 2004
                            'hashtable implementation for the deliverable field configuration
                            Select Case UCase(Args.DataField)
                                Case "DELIVERABLETYPEID"
                                    Cancel = True

                                Case "CUSTOMERREFNO", "DELIVERABLELCE", "PERCENTAGECOMPLETE", "LATESTCOMPLETIONDATE"
                                    'Modified By VidyaJ - Performance Issue - Deliverable - SP4 - IssueID -84
                                    strScheduleID = CType(HttpContext.Current.Session("DeliverableType"), String)

                                    Dim blnIsApplicable As Boolean = False
                                    Dim objDeliverableField As New CommonEngine.HashTables.DeliverableField
                                    objDeliverableField = CommonEngine.HashTables.Deliverable.GetHashTableDeliverableFieldObject(CType(strScheduleID, Long), Args.DataField)
                                    If Not objDeliverableField Is Nothing Then
                                        blnIsApplicable = objDeliverableField.Applicable
                                    End If
                                    objDeliverableField = Nothing

                                    If blnIsApplicable = False Then
                                        Cancel = True
                                    End If

                                    '' START : Added By ParagD On 6-Oct-2006
                                    '' Purpose : WHiz SP7 Issue - When no ADD access for Deliverable node ,then hide "Copy" link on list page.
                                Case "IMAGE1"
                                    Dim drAccessRights As IDataReader
                                    Dim strQuery As String
                                    Dim intPostId As Integer
                                    Dim intUserId As Integer
                                    Dim strLoginType As String
                                    Dim intProjectID As Integer
                                    Dim blnAddRight As Boolean
                                    Dim blnEditRight As Boolean

                                    intPostId = CType(HttpContext.Current.Session("intPostID"), Integer)
                                    intUserId = CType(HttpContext.Current.Session("intUserID"), Integer)
                                    strLoginType = CType(HttpContext.Current.Session("LoginType"), String)
                                    intProjectID = CType(HttpContext.Current.Session("intProjectID"), Integer)

                                    strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " & WhizGlobal.TagID & "," & intPostId.ToString & "," & intUserId.ToString & ",'" & strLoginType & "'," & intProjectID.ToString
                                    drAccessRights = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If CommonFunctions.General.CheckIsNothing(drAccessRights) <> "" Then
                                        drAccessRights.Read()
                                        blnAddRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("A"), "False"), Boolean)
                                        blnEditRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("E"), "False"), Boolean)
                                    End If
                                    If (blnAddRight = False) Then
                                        Cancel = True
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(drAccessRights)
                                    '' END : Added By ParagD On 6-Oct-2006

                            End Select

                            ''Added By Sagar Niapne on 21-Feb-2019 Purpose::Project Work field level changes 

                            If WhizGlobal.TagID = 2133 Then
                                If UCase(Args.DataField) = "ESTIMATEDEFFORTS" Then
                                    Cancel = True
                                    Dim WorkHourMinute As String
                                    WorkHourMinute = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("EXEC usp_Whizible2_GetEstimatedEffortsInHourMinuteForWBS 'Deliverable'," & Args.DataReader("ScheduleID"), True), "")
                                    Args.StringToBeInserted = "<TD nowrap  align=right >" + WorkHourMinute + "</TD>"
                                End If
                            End If
                            ''End of Added By Sagar Nipane on 21-Feb-2019 Purpose::Project Work field level changes

                            '' START : Added By ParagD On 6-Oct-2006
                            '' Purpose : WHiz SP7 Issue - When no ADD access for Module/Sub Projects/Milestone Details node ,then hide "Copy" link on list page.
                        Case CommonFunction.Constants.APP_TAG_MODULES, CommonFunction.Constants.APP_TAG_SUB_PROJECTS, CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS
                            Select Case UCase(Args.DataField)
                                Case "IMAGE1"
                                    Dim drAccessRights As IDataReader
                                    Dim strQuery As String
                                    Dim intPostId As Integer
                                    Dim intUserId As Integer
                                    Dim strLoginType As String
                                    Dim intProjectID As Integer
                                    Dim blnAddRight As Boolean
                                    Dim blnEditRight As Boolean

                                    intPostId = CType(HttpContext.Current.Session("intPostID"), Integer)
                                    intUserId = CType(HttpContext.Current.Session("intUserID"), Integer)
                                    strLoginType = CType(HttpContext.Current.Session("LoginType"), String)
                                    intProjectID = CType(HttpContext.Current.Session("intProjectID"), Integer)

                                    strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " & WhizGlobal.TagID & "," & intPostId.ToString & "," & intUserId.ToString & ",'" & strLoginType & "'," & intProjectID.ToString
                                    drAccessRights = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If CommonFunctions.General.CheckIsNothing(drAccessRights) <> "" Then
                                        drAccessRights.Read()
                                        blnAddRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("A"), "False"), Boolean)
                                        blnEditRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("E"), "False"), Boolean)
                                    End If
                                    If (blnAddRight = False) Then
                                        Cancel = True
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(drAccessRights)
                            End Select
                            '' END : Added By ParagD On 6-Oct-2006

                            ''Added By Aniruddh Gujar on 18-Feb-2019 Purpose::Project Work field level changes 
                            If WhizGlobal.TagID = 454 Then
                                If UCase(Args.DataField) = "ESTIMATEDEFFORTS" Then
                                    Cancel = True
                                    Dim WorkHourMinute As String
                                    WorkHourMinute = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("EXEC usp_Whizible2_GetEstimatedEffortsInHourMinuteForWBS 'Module'," & Args.DataReader("ModuleID"), True), "")
                                    Args.StringToBeInserted = "<TD nowrap  align=right >" + WorkHourMinute + "</TD>"
                                End If
                            End If
                            ''End of Added By Aniruddh Gujar on 18-Feb-2019 Purpose::Project Work field level changes 

                            'addition end   on 02 Nov 2004

                            ' Commented By NitinVS on 21 Sep 2006 for WhizibleSEM SP7 IssueID 6348 
                            ' Javascript is added to show alert and return in client side script hence commenting                                 this code 
                            ''Addedby HarshK for sp4 issueid 587
                            'If Args.ColumnName.ToUpper = "COPY" Then
                            '    Dim strSql As String
                            '    Dim strResult As String
                            '    strSql = "usp_sel_tbl_PM_OtherSchedules_IsOnHold_OR_Void " & CStr(Args.DataReader("ScheduleID"))
                            '    strResult = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSql, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""))
                            '    If strResult = "" Or strResult Is Nothing Then
                            '        Args.IgnoreActualValue = True
                            '        objTemplate = New WebPages.Template.WhizTemplate
                            '        objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                            '        Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/Copy.gif' title='" & objTemplate.GetResourceString("DELIVERABLE_COPY_TOOLTIP") & "' ></A></TD>"
                            '        Cancel = True
                            '        Args.EnableLink = False
                            '        'Args.TDStyle = "title='Deliverable is OnHold or Void.Cannot be copied'"
                            '        objTemplate = Nothing
                            '    End If
                            'End If
                            ''End Addedby HarshK for sp4 issueid 587
                            ' end Commented By NitinVS on 21 Sep 2006 for WhizibleSEM SP7 IssueID 6348 

                            ''Added By Sagar Niapne on 21-Feb-2019 Purpose::Project Work field level changes 
                        Case CommonFunction.Constants.APP_TAG_PHASE_DETAILS
                            If WhizGlobal.TagID = 516 Then
                                If UCase(Args.DataField) = "ESTIMATEDEFFORTS" Then
                                    Cancel = True
                                    Dim WorkHourMinute As String
                                    WorkHourMinute = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("EXEC usp_Whizible2_GetEstimatedEffortsInHourMinuteForWBS 'Phase'," & Args.DataReader("ProjectPhaseID"), True), "")
                                    Args.StringToBeInserted = "<TD nowrap  align=right >" + WorkHourMinute + "</TD>"
                                End If
                            End If
                        ''End of Added By Sagar Nipane on 21-Feb-2019 Purpose::Project Work field level changes

                            'added by DiptiK on 17 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_CNF_PROJECT_SETTINGS
                            Dim strSQL As String
                            Dim strURL As String
                            Dim drPrjSettings As IDataReader
                            Dim strLink As String = " "

                            If Args.ColumnName.ToUpper = "SETTINGS" Then
                                Dim blnAccess As Boolean
                                Dim lngActualTagID As Long = WhizGlobal.TagID
                                WhizGlobal.TagID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TagID"), "0"), Long)

                                'Added By VidyaJ for IssueID -15714
                                'Check Deleteed Access Also
                                Dim drAccessRights As IDataReader
                                Dim strQuery As String
                                Dim intPostId As Integer
                                Dim intUserId As Integer
                                Dim strLoginType As String
                                Dim intProjectID As Integer
                                Dim blnAddRight As Boolean
                                Dim blnEditRight As Boolean
                                'Commented BY VarunA on 11-Aug-2008 RequestID-14439
                                'Purpose : To have link in View and Delete Access also.
                                Dim blnDeleteRight As Boolean
                                Dim blnViewRight As Boolean
                                'End By VarunA on 11-Aug-2008 RequestID-14439
                                intPostId = CType(HttpContext.Current.Session("intPostID"), Integer)
                                intUserId = CType(HttpContext.Current.Session("intUserID"), Integer)
                                strLoginType = CType(HttpContext.Current.Session("LoginType"), String)
                                intProjectID = CType(HttpContext.Current.Session("intProjectID"), Integer)

                                strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " & WhizGlobal.TagID & "," & intPostId.ToString & "," & intUserId.ToString & ",'" & strLoginType & "'," & intProjectID.ToString
                                drAccessRights = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If CommonFunctions.General.CheckIsNothing(drAccessRights) <> "" Then
                                    drAccessRights.Read()
                                    blnAddRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("A"), "False"), Boolean)
                                    blnEditRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("E"), "False"), Boolean)
                                    'Commented BY VarunA on 11-Aug-2008 RequestID-14439
                                    'Purpose : To have link in View and Delete Access also.
                                    blnDeleteRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("D"), "False"), Boolean)
                                    blnViewRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("V"), "False"), Boolean)
                                    'End By VarunA on 11-Aug-2008 RequestID-14439
                                End If
                                CommonFunctions.Data.DisposeDataReader(drAccessRights)

                                'Dim objAccess As New WebPage.Templates.AccessRights
                                ''Get the Access Rights 
                                'objAccess.GetAccess(global, True)
                                'blnAccess = objAccess.Access
                                'objAccess = Nothing
                                WhizGlobal.TagID = lngActualTagID
                                strURL = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("URL"), "").ToString.Trim
                                Cancel = True
                                'Modified By VarunA on 11-Aug-2008 RequestID-14439
                                'Purpose : To have link in all the access.
                                'If (blnAddRight = True Or blnEditRight = True) And strURL <> "" Then
                                If (blnAddRight = True Or blnEditRight = True Or blnDeleteRight = True Or blnViewRight = True) And strURL <> "" Then
                                    'End By VarunA on 11-Aug-2008 RequestID-14439
                                    'Args.StringToBeInserted = "<TD Align='Left'> <a href=" + strURL + ">" + CType(Args.DataReader("Settings"), String) + "</a> </TD>"
                                    'Modification by PrachiK on 8 Mar 2005 for IssueID 16724
                                    'Purpose:GUI of Configure Timesheet blocking
                                    Args.StringToBeInserted = "<TD Align='Left'><A Href='javascript: var objChild=window.open(""" + Replace(strURL, "ProjectID=<PROJECT_ID>", "ProjectID=" + CStr(WhizGlobal.ProjectID) + "&TaskProjectID=" + CStr(WhizGlobal.ProjectID)) + """,""_blank"",""resizable=yes,scrollbars=no,Left=100,Top=100,height=550,width=850"")'>" + CType(Args.DataReader("Settings"), String) + "</a> </TD>"
                                    'Modification ended
                                Else
                                    Args.StringToBeInserted = "<TD Align='Left'>" + CType(Args.DataReader("Settings"), String) + "</TD>"
                                End If
                            End If
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            'end of addition

                            'Added For Work Order Facilties 
                        Case CommonFunction.Constants.APP_TAG_WORKORDER_FACILITIES
                            If Args.ColumnName.ToUpper = "FACILITY" Then
                                Args.EnableLink = False
                            End If

                            If Args.ColumnName.ToUpper = "SELECT" Then
                                Dim strSQL As String
                                Dim drGetProjectFacilities As IDataReader
                                Dim strProjectFacilities As String
                                strSQL = "Select * from tbl_PM_WorkOrderFacilities Where ProjectID = " + CType(HttpContext.Current.Session("intProjectID"), String)
                                drGetProjectFacilities = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                While drGetProjectFacilities.Read
                                    strProjectFacilities = strProjectFacilities + CType(CommonFunctions.Data.CheckIsDBNull(drGetProjectFacilities("FacilityID"), ""), String) + ","
                                End While



                                CommonFunction.Data.DisposeDataReader(drGetProjectFacilities)
                                If CType(InStr(strProjectFacilities, CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FacilityID"), ""), String)), Boolean) Then
                                    Cancel = True
                                    Args.StringToBeInserted = "<td  align='center' Title='Facility :" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Facility"), ""), String) + "'><Input type='checkbox' name='chkDelete' id='chkDelete' class='clsCheckBox' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FacilityID"), ""), String) + "' checked></td>"
                                End If

                            End If
                            'End Addition


                            'Added For Question Selection List By AmitD On 20 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_QUESTION_SELECTION_LIST
                            If Args.ColumnName.ToUpper = "DESCRIPTION" Then
                                Args.EnableLink = False
                            End If

                            If Args.ColumnName.ToUpper = "SELECT" Then

                                Cancel = True
                                Args.StringToBeInserted = "<script language='javascript'>"
                                Args.StringToBeInserted += "function EnableMandatory()" + vbCrLf
                                Args.StringToBeInserted += "{" + vbCrLf
                                Args.StringToBeInserted += "objChk = GetObjectReference('frmCommonList','chkDelete',true);"
                                Args.StringToBeInserted += "objChkMan = GetObjectReference('frmCommonList','chkMandatory',true);"
                                Args.StringToBeInserted += "intLen = objChk.length;"
                                Args.StringToBeInserted += "if(intLen > 0)"
                                Args.StringToBeInserted += "{ for(intCnt=0;intCnt<intLen;intCnt++)"
                                Args.StringToBeInserted += " { if(objChk[intCnt].checked==true)"
                                Args.StringToBeInserted += " objChkMan[intCnt].disabled=false;   "
                                Args.StringToBeInserted += " else {objChkMan[intCnt].disabled=true; }}} "
                                Args.StringToBeInserted += "}" + vbCrLf
                                Args.StringToBeInserted += "</script>"
                                Args.StringToBeInserted += "<td  align='center' Title='Question :" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Description"), ""), String) + "'><Input type='checkbox' name='chkDelete' id='chkDelete' class='clsCheckBox' value='" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("QuestionID"), ""), String) + "'  onClick='javascript:EnableMandatory();'></td>"



                            End If

                            If Args.ColumnName.ToUpper = "MANDATORY" Then
                                Cancel = True
                                Args.StringToBeInserted = "<td  align=center ><Input type=checkbox name='chkMandatory' id='chkMandatory' disabled class='clsCheckBox' value='" + CType(Args.DataReader("QuestionID"), String) + "' ></td>"

                            End If

                            'End Addition

                            'Added by ShamkantD on 20th August 2004
                        Case CommonFunction.Constants.APP_TAG_WORKORDER_CONTRACT_CLAUSES
                            If Args.ColumnName.ToUpper = "CONTRACT CLAUSE" Then
                                Args.EnableLink = False
                            End If

                            If Args.ColumnName.ToUpper = "SELECT" Then
                                Dim strSQL As String
                                Dim drGetProjectContractClauses As IDataReader
                                Dim strProjectContractClauses As String
                                strSQL = "Select ContractClauseID From tbl_PM_WorkOrderContractClauses Where ProjectID = " + CType(HttpContext.Current.Session("intProjectID"), String)
                                drGetProjectContractClauses = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                While drGetProjectContractClauses.Read
                                    strProjectContractClauses += CType(CommonFunctions.Data.CheckIsDBNull(drGetProjectContractClauses("ContractClauseID"), ""), String) + ","
                                End While

                                CommonFunction.Data.DisposeDataReader(drGetProjectContractClauses)
                                If CType(InStr(strProjectContractClauses, CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ContractClauseID"), ""), String)), Boolean) Then
                                    Args.IsSelected = True
                                End If
                            End If
                            'End of Addition - ShamkantD on 20th August 2004
                            'Added by ShamkantD on 23rd August 2004
                        Case CommonFunction.Constants.APP_TAG_ANSWER_SET_PREVIEW
                            If Args.DataField.ToUpper = "ANSWERDESCRIPTION" Then
                                Args.EnableLink = False
                            End If
                            'End of addition - ShamkantD on 23rd August 2004

                            'Added by HarshK for sp4 issueid 200
                        Case CommonFunction.Constants.APP_TAG_MODULE_SELECTION_LIST
                            Dim strModuleID As String = "0"

                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.DataField.ToUpper = "MODULENAME" Then
                                Cancel = True
                                Dim strTemp As String
                                Dim strTemp2 As String
                                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ModuleName"), ""), String) <> "" Then
                                    strTemp2 = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ModuleName"), ""), String)
                                    strTemp = Replace(strTemp2, "'", "\'")
                                End If

                                If (Not (HttpContext.Current.Request.Form("ModuleID")) Is Nothing) Then
                                    If (HttpContext.Current.Request.Form("ModuleID") = "") Then
                                        strModuleID = "0"
                                    Else
                                        strModuleID = CType(HttpContext.Current.Request.Form("ModuleID"), String)
                                    End If
                                Else
                                    strModuleID = CType(HttpContext.Current.Request.QueryString("ModuleID"), String)
                                End If
                                Args.StringToBeInserted = "<TD  nowrap vAlign=top title='Title' width='20%'><A href=""JavaScript:Module_OnClick('" + CType(Args.DataReader("ModuleID"), String) + "','" + strTemp + "');"">" + strTemp + "</A></td>"
                                If strModuleID <> "" And strModuleID.Trim <> "0" Then
                                    If CType(strModuleID, Long) =
                                        CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ModuleID"), "0"), Long) Then
                                        Args.StringToBeInserted = "<TD style='color=blue' nowrap vAlign=top title='Module' width='20%'><A style='color=blue' href=""JavaScript:Module_OnClick('" + CType(Args.DataReader("ModuleID"), String) + "','" + strTemp + "');"">" + strTemp2 + "</A></td>"
                                    End If
                                End If
                            End If
                            '---------------------------------------------------------
                        Case CommonFunction.Constants.APP_TAG_MILESTONE_SELECTION_LIST
                            Dim strMileStoneID As String = "0"

                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.DataField.ToUpper = "MILESTONE" Then
                                Cancel = True
                                Dim strTemp As String
                                Dim strTemp2 As String
                                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MileStone"), ""), String) <> "" Then
                                    strTemp2 = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MileStone"), ""), String)
                                    strTemp = Replace(strTemp2, "'", "\'")
                                End If
                                If (Not (HttpContext.Current.Request.Form("MileStoneID")) Is Nothing) Then
                                    If (HttpContext.Current.Request.Form("MileStoneID") = "") Then
                                        strMileStoneID = "0"
                                    Else
                                        strMileStoneID = CType(HttpContext.Current.Request.Form("MileStoneID"), String)
                                    End If
                                Else
                                    strMileStoneID = CType(HttpContext.Current.Request.QueryString("MileStoneID"), String)
                                End If
                                Args.StringToBeInserted = "<TD  nowrap vAlign=top title='Title' width='20%'><A href=""JavaScript:MileStone_OnClick('" + CType(Args.DataReader("MileStoneID"), String) + "','" + strTemp + "');"">" + strTemp + "</A></td>"
                                If strMileStoneID <> "" And strMileStoneID.Trim <> "0" Then
                                    If CType(strMileStoneID, Long) =
                                        CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MileStoneID"), "0"), Long) Then
                                        Args.StringToBeInserted = "<TD style='color=blue' nowrap vAlign=top title='Module' width='20%'><A style='color=blue' href=""JavaScript:MileStone_OnClick('" + CType(Args.DataReader("MileStoneID"), String) + "','" + strTemp + "');"">" + strTemp2 + "</A></td>"
                                    End If
                                End If
                            End If
                            '---------------------------------------------------------
                        Case CommonFunction.Constants.APP_TAG_SUBPROJECT_SELECTION_LIST
                            Dim strSubProjectID As String = "0"

                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.DataField.ToUpper = "SUBPROJECTNAME" Then
                                Cancel = True
                                Dim strTemp As String
                                Dim strTemp2 As String
                                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SubProjectName"), ""), String) <> "" Then
                                    strTemp2 = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SubProjectName"), ""), String)
                                    strTemp = Replace(strTemp2, "'", "\'")
                                End If
                                If (Not (HttpContext.Current.Request.Form("SubProjectID")) Is Nothing) Then
                                    If (HttpContext.Current.Request.Form("SubProjectID") = "") Then
                                        strSubProjectID = "0"
                                    Else
                                        strSubProjectID = CType(HttpContext.Current.Request.Form("SubProjectID"), String)
                                    End If
                                Else
                                    strSubProjectID = CType(HttpContext.Current.Request.QueryString("SubProjectID"), String)
                                End If

                                Args.StringToBeInserted = "<TD  nowrap vAlign=top title='Title' width='20%'><A href=""JavaScript:SubProject_OnClick('" + CType(Args.DataReader("SubProjectID"), String) + "','" + strTemp + "');"">" + strTemp + "</A></td>"
                                If strSubProjectID <> "" And strSubProjectID.Trim <> "0" Then
                                    If CType(strSubProjectID, Long) =
                                        CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SubProjectID"), "0"), Long) Then
                                        Args.StringToBeInserted = "<TD style='color=blue' nowrap vAlign=top title='Module' width='20%'><A style='color=blue' href=""JavaScript:SubProject_OnClick('" + CType(Args.DataReader("SubProjectID"), String) + "','" + strTemp + "');"">" + strTemp2 + "</A></td>"
                                    End If
                                End If
                            End If
                            '---------------------------------------------------------
                        Case CommonFunction.Constants.APP_TAG_TASKTYPE_SELECTION_LIST
                            Dim strTaskTypeID As String = "0"

                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.DataField.ToUpper = "TASKTYPE" Then
                                Cancel = True
                                Dim strTemp As String
                                Dim strTemp2 As String
                                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskType"), ""), String) <> "" Then
                                    strTemp2 = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskType"), ""), String)
                                    strTemp = Replace(strTemp2, "'", "\'")
                                End If
                                If (Not (HttpContext.Current.Request.Form("TaskTypeID")) Is Nothing) Then
                                    If (HttpContext.Current.Request.Form("TaskTypeID") = "") Then
                                        strTaskTypeID = "0"
                                    Else
                                        strTaskTypeID = CType(HttpContext.Current.Request.Form("TaskTypeID"), String)
                                    End If
                                Else
                                    strTaskTypeID = CType(HttpContext.Current.Request.QueryString("TaskTypeID"), String)
                                End If

                                Args.StringToBeInserted = "<TD  nowrap vAlign=top title='Title' width='20%'><A href=""JavaScript:TaskType_OnClick('" + CType(Args.DataReader("TaskTypeID"), String) + "','" + strTemp + "');"">" + strTemp + "</A></td>"
                                If strTaskTypeID <> "" And strTaskTypeID.Trim <> "0" Then
                                    If CType(strTaskTypeID, Long) =
                                        CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TaskTypeID"), "0"), Long) Then
                                        Args.StringToBeInserted = "<TD style='color=blue' nowrap vAlign=top title='Module' width='20%'><A style='color=blue' href=""JavaScript:TaskType_OnClick('" + CType(Args.DataReader("TaskTypeID"), String) + "','" + strTemp + "');"">" + strTemp2 + "</A></td>"
                                    End If
                                End If
                            End If
                            '---------------------------------------------------------
                        Case CommonFunction.Constants.APP_TAG_PHASE_SELECTION_LIST
                            Dim strPhaseID As String = "0"

                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.DataField.ToUpper = "PHASE" Then
                                Cancel = True
                                Dim strTemp As String
                                Dim strTemp2 As String
                                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Phase"), ""), String) <> "" Then
                                    strTemp2 = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Phase"), ""), String)
                                    strTemp = Replace(strTemp2, "'", "\'")
                                End If
                                If (Not (HttpContext.Current.Request.Form("ProjectPhaseID")) Is Nothing) Then
                                    If (HttpContext.Current.Request.Form("ProjectPhaseID") = "") Then
                                        strPhaseID = "0"
                                    Else
                                        strPhaseID = CType(HttpContext.Current.Request.Form("ProjectPhaseID"), String)
                                    End If
                                Else
                                    strPhaseID = CType(HttpContext.Current.Request.QueryString("ProjectPhaseID"), String)
                                End If

                                Args.StringToBeInserted = "<TD  nowrap vAlign=top title='Title' width='20%'><A href=""JavaScript:Phase_OnClick('" + CType(Args.DataReader("ProjectPhaseID"), String) + "','" + strTemp + "');"">" + strTemp + "</A></td>"
                                If strPhaseID <> "" And strPhaseID.Trim <> "0" Then
                                    If CType(strPhaseID, Long) =
                                        CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectPhaseID"), "0"), Long) Then
                                        Args.StringToBeInserted = "<TD style='color=blue' nowrap vAlign=top title='Module' width='20%'><A style='color=blue' href=""JavaScript:Phase_OnClick('" + CType(Args.DataReader("ProjectPhaseID"), String) + "','" + strTemp + "');"">" + strTemp2 + "</A></td>"
                                    End If
                                End If
                            End If
                            'End Added by HarshK for sp4 issueid 200
                            '##### Case Added By AmitD on 25 Aug 2004 For Deliverables Selection List
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLES_SELECTION_LIST
                            Dim strDeliverableID As String = "0"
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            If CType(HttpContext.Current.Request.QueryString("DeliverableID"), String) = "" Then
                                strDeliverableID = "0"
                            Else
                                strDeliverableID = CType(HttpContext.Current.Request.QueryString("DeliverableID"), String)
                            End If

                            If Args.DataField.ToUpper = "TITLE" Then
                                Cancel = True

                                'Added By JayavantK on 21-Sep-2004
                                'If CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("DeliverableID"), "0"), Long) <> "0" Then
                                'If CType(HttpContext.Current.Request.QueryString("DeliverableID"), String) = "" Then
                                '    strDeliverableID = "0"
                                'End If
                                'Added by PrachiK on 16 Mar  2005 for IssueID 16903
                                'Purpose:When Single Quotes are used in Deliverable Title, we cannot associate this Deliverable with any other tasks etc...
                                Dim strDeliverable As String = ""
                                Dim strTemp As String
                                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Title"), ""), String) <> "" Then
                                    strDeliverable = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Title"), ""), String)
                                    'Modified by SiddharthS on 4 Apr 2005 for IssueID 16903
                                    strTemp = Replace(strDeliverable, "'", "\'")
                                    'End comment.
                                End If


                                'Added by PrachiK on 23 Feb 2005 for IssueID 16336
                                'Purpose:Issues regarding the Deliverable Selection page.
                                If (Not (HttpContext.Current.Request.Form("DeliverableID")) Is Nothing) Then
                                    If (HttpContext.Current.Request.Form("DeliverableID") = "") Then
                                        strDeliverableID = "0"
                                    Else
                                        strDeliverableID = CType(HttpContext.Current.Request.Form("DeliverableID"), String)
                                    End If
                                Else
                                    strDeliverableID = CType(HttpContext.Current.Request.QueryString("DeliverableID"), String)
                                End If


                                'Addtion Ended

                                '---- Added By purvaj on 23 Apr 2009 task validation done against deliverable baseline efforts and dates.
                                Dim dr As IDataReader
                                Dim strBaselinestartdate As String = ""
                                Dim strBaselineenddate As String = ""
                                Dim strBaselinework As String = ""
                                Dim strPlannedTaskEfforts As String = ""
                                dr = CommonFunction.Data.GetDataReader("usp_sel_DeliverableDetails_Taskvalidation " + CType(Args.DataReader("ScheduleID"), String) + ",null," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0").ToString, True)
                                While dr.Read()
                                    strBaselinestartdate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("BaselineStartDate"), ""), "")
                                    'If strBaselinestartdate <> "" Then
                                    '    strBaselinestartdate = CommonFunction.Dates.CGetDate(strBaselinestartdate)
                                    'End If
                                    strBaselineenddate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("BaselineEndDate"), ""), "")
                                    'If strBaselineenddate <> "" Then
                                    '    strBaselineenddate = CommonFunction.Dates.CGetDate(strBaselineenddate)
                                    'End If
                                    strBaselinework = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("BaselineWork"), "0"), "0")
                                    strPlannedTaskEfforts = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("PlannedTasksEfforts"), "0"), "0")
                                End While
                                CommonFunction.Data.DisposeDataReader(dr)
                                '---- End addition purvaj

                                'Modified by SiddharthS on 4 Apr 2005 for IssueID 16903
                                '--- Modified by purvaj on 23 Apr 2009
                                '--- 4 Parameters added in the function 
                                'Args.StringToBeInserted = "<TD  nowrap vAlign=top title='Title' width='20%'><A  href=""JavaScript:Deliverable_OnClick('" + CType(Args.DataReader("ScheduleID"), String) + "','" + strTemp + "');"">" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Title"), ""), String) + "</A></td>"
                                Args.StringToBeInserted = "<TD  nowrap vAlign=top title='Title' width='20%'><A  href=""JavaScript:Deliverable_OnClick('" + CType(Args.DataReader("ScheduleID"), String) + "','" + strTemp + "','" + strBaselinestartdate.ToString + "','" + strBaselineenddate.ToString + "','" + strBaselinework.ToString + "','" + strPlannedTaskEfforts.ToString + "');"">" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Title"), ""), String) + "</A></td>"
                                '--- End modification purvaj
                                'End modification.
                                If strDeliverableID <> "" Then
                                    If CType(strDeliverableID, Long) =
                                        CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ScheduleID"), "0"), Long) Then
                                        'Modified by SiddharthS on 4 Apr 2005 for IssueID 16903
                                        'Commented and modified by MonikaI on 28-Sep-2006 IssueID : 6484
                                        'Args.StringToBeInserted = "<TD nowrap vAlign=top title='Title' width='20%'><A  href=""JavaScript:Deliverable_OnClick('" + CType(Args.DataReader("ScheduleID"), String) + "','" + strTemp + "');""><FONT color='Blue'>" + strDeliverable + "</FONT></A></td>"
                                        '--- Modified by purvaj on 23 Apr 2009
                                        '--- 4 Parameters added in the function 
                                        'Args.StringToBeInserted = "<TD nowrap vAlign=top title='Title' width='20%'><A  href=""JavaScript:Deliverable_OnClick('" + CType(Args.DataReader("ScheduleID"), String) + "','" + strTemp + "');""><FONT color='Blue'>" + strDeliverable + "</FONT></A></td>"
                                        Args.StringToBeInserted = "<TD nowrap vAlign=top title='Title' width='20%'><A  href=""JavaScript:Deliverable_OnClick('" + CType(Args.DataReader("ScheduleID"), String) + "','" + strTemp + "','" + strBaselinestartdate.ToString + "','" + strBaselineenddate.ToString + "','" + strBaselinework.ToString + "','" + strPlannedTaskEfforts.ToString + "');""><FONT color='Blue'>" + strDeliverable + "</FONT></A></td>"
                                        '--- End modification purvaj
                                        'End of modification by MonikaI
                                        'End modification.
                                    End If
                                End If

                                'Addtion ended for issue 16903

                                'End Addition
                            End If
                            'Added by PrachiK on 24 Feb 2005 for IssueID 16336
                            'Purpose:Issues regarding the Deliverable Selection page.
                            If (Not (HttpContext.Current.Request.Form("DeliverableID")) Is Nothing) Then
                                If (HttpContext.Current.Request.Form("DeliverableID") = "") Then
                                    strDeliverableID = "0"
                                Else
                                    strDeliverableID = CType(HttpContext.Current.Request.Form("DeliverableID"), String)
                                End If
                            Else
                                strDeliverableID = CType(HttpContext.Current.Request.QueryString("DeliverableID"), String)
                            End If



                            If strDeliverableID <> "" Then
                                'End Addition
                                'Added By JayavantK on 21-Sep-2004
                                If CType(strDeliverableID, Long) =
                                    CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ScheduleID"), "0"), Long) Then
                                    'Modified by SantoshK on Date June 8, 2006 for WhizibleSEM Issue ID.4168
                                    'Purpose : Firefox Support, = changed to :
                                    'Args.TDStyle = "style='color=blue'"
                                    Args.TDStyle = "style='color:blue'"
                                    'Modification Ends by SantoshK on June 8, 2006
                                End If
                            End If
                            'End Addition
                            '##### End Addition

                            'added by SachinR   on 26 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_ASSOCIATED_ACTIVITIES
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_TAG_SELECT_TEMPLATE
                            'here default link on the revision no column is canceled
                            Dim strSQL As String

                            If Args.DataField.ToUpper = "REVISIONNO" Then
                                Args.EnableLink = False
                            ElseIf Args.ColumnName.ToUpper = "DELETE" Then
                                strSQL = "usp_Sel_tbl_PM_Project_PhaseTask_Template " + WhizGlobal.ProjectID.ToString + "," + CommonFunction.Data.CheckIsDBNull(Args.DataReader("TemplateID"), "0").ToString
                                If CType(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Long) > 0 Then
                                    Args.IsSelected = True
                                    Args.IsCheckBoxDisabled = True
                                End If
                            End If
                            'addition end



                            'added by SachinR   on 26 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_PRACTICE_SELECTION
                            Dim strTemplateID As String
                            Dim strSQL As String
                            Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
                            strTemplateID = CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectPhaseTaskTemplateID"), "").ToString + ""
                            'Added By JyotiG
                            'Start_JG_11498_15-Mar-2007
                            'Issue Details: Role Access is not working for Execution Template
                            'Added by vidyaJ - issueID - 11093
                            Dim drAccessRights As IDataReader
                            Dim strQuery As String
                            Dim intPostId As Integer
                            Dim intUserId As Integer
                            Dim strLoginType As String
                            Dim intProjectID As Integer
                            Dim blnAddRight As Boolean
                            Dim blnEditRight As Boolean
                            intPostId = CType(HttpContext.Current.Session("intPostID"), Integer)
                            intUserId = CType(HttpContext.Current.Session("intUserID"), Integer)
                            strLoginType = CType(HttpContext.Current.Session("LoginType"), String)
                            intProjectID = CType(HttpContext.Current.Session("intProjectID"), Integer)

                            strQuery = "Exec usp_Sel_tbl_UI_NodeAccess 2175 ," & intPostId.ToString & "," & intUserId.ToString & ",'" & strLoginType & "'," & intProjectID.ToString
                            drAccessRights = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If CommonFunctions.General.CheckIsNothing(drAccessRights) <> "" Then
                                drAccessRights.Read()
                                blnAddRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("A"), "False"), Boolean)
                                blnEditRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("E"), "False"), Boolean)

                            End If
                            CommonFunctions.Data.DisposeDataReader(drAccessRights)
                            'End_JG_11498_15-Mar-2007
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            '--- Code added by NileshJ on 20 May to display image for copy template.
                            '--- Do not display link for unpublished templates.
                            If Args.ColumnName.ToUpper = "COPY" Then
                                'Commented by JyotiG
                                'Same code is added above.
                                'Start_JG_11498_15-Mar-2007
                                ''Added by vidyaJ - issueID - 11093
                                'Dim drAccessRights As IDataReader
                                'Dim strQuery As String
                                'Dim intPostId As Integer
                                'Dim intUserId As Integer
                                'Dim strLoginType As String
                                'Dim intProjectID As Integer
                                'Dim blnAddRight As Boolean
                                'Dim blnEditRight As Boolean
                                'intPostId = CType(HttpContext.Current.Session("intPostID"), Integer)
                                'intUserId = CType(HttpContext.Current.Session("intUserID"), Integer)
                                'strLoginType = CType(HttpContext.Current.Session("LoginType"), String)
                                'intProjectID = CType(HttpContext.Current.Session("intProjectID"), Integer)

                                'strQuery = "Exec usp_Sel_tbl_UI_NodeAccess 2175 ," & intPostId.ToString & "," & intUserId.ToString & ",'" & strLoginType & "'," & intProjectID.ToString
                                'drAccessRights = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'If CommonFunctions.General.CheckIsNothing(drAccessRights) <> "" Then
                                '    drAccessRights.Read()
                                '    blnAddRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("A"), "False"), Boolean)
                                '    blnEditRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("E"), "False"), Boolean)

                                'End If
                                'CommonFunctions.Data.DisposeDataReader(drAccessRights)
                                'End_JG_11498_15-Mar-2007

                                strSQL = "usp_Sel_tbl_PM_Project_PhaseTask_Template_IsPublished " + strTemplateID.Trim

                                If blnAddRight = False Then
                                    Cancel = True
                                Else
                                    If CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, blnUseSQL), "0"), Integer) = 0 Then
                                        'If the template is published then do not show the link..
                                        Args.IgnoreActualValue = True
                                        'Create object of the ProjectByNet Template Class
                                        'objTemplate = New WebPages.Template.WhizTemplate
                                        Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/Copy.gif' title='Please publish the template to use for Copy template.' ></A></TD>"
                                        Cancel = True
                                        'Args.ReplacementValue = "<FONT color='RED'>" + objTemplate.GetResourceString("PUBLISHED") + "</FONT>"
                                        Args.EnableLink = False
                                        ' objTemplate = Nothing
                                    End If
                                End If
                            End If
                            '--- Addition ends

                            'if status="D" then display link as publish,else dont display link
                            If Args.DataField.ToLower = "hyperlink1" Then
                                strSQL = "usp_Sel_tbl_PM_Project_PhaseTask_Template_IsPublished " + strTemplateID.Trim
                                'Start_JG_11498_15-Mar-2007
                                If (blnAddRight = False) And (blnEditRight = False) Then
                                    Cancel = True
                                Else
                                    'End_JG_11498_15-Mar-2007
                                    If CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, blnUseSQL), "0"), Integer) > 0 Then
                                        'If the template is published then do not show the link..
                                        Args.IgnoreActualValue = True
                                        'Create object of the ProjectByNet Template Class
                                        objTemplate = New WebPages.Template.WhizTemplate
                                        'Initialize the Resources
                                        objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                        Args.ReplacementValue = "<FONT color='RED'>" + objTemplate.GetResourceString("PUBLISHED") + "</FONT>"
                                        Args.EnableLink = False
                                        objTemplate = Nothing
                                    End If
                                End If
                            End If
                            'addition end

                            ' Added By NitinVS on 18 Feb 2005 
                            ' To Remove the the Getlatest Link if 
                            ' the Revision No of template at Project level and Process Level are the same 
                            Dim strSQLQuery As String
                            Dim objDR As IDataReader
                            Dim drCheckCopyTemplate As IDataReader
                            Dim blnIsCopyTemplate As Boolean = False
                            Dim isRevised As Long
                            Dim strQueryString As String

                            If Args.ColumnName.ToUpper = "GET LATEST REVISION" Then


                                If Args.DataReader("ProjectPhaseTaskTemplateID").ToString <> "" Then
                                    '--- Code Added By Nilesh on 20 May to display Latest Version 
                                    '--- link only for non copied templates.
                                    strSQLQuery = "Select IsCopyTemplate from tbl_PM_Project_PhaseTask_Template "
                                    strSQLQuery = strSQLQuery & " Where projectphasetasktemplateid = " & CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectPhaseTaskTemplateID"), "0"), String)
                                    drCheckCopyTemplate = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
                                    If drCheckCopyTemplate.Read Then
                                        blnIsCopyTemplate = CType(CommonFunctions.Data.CheckIsDBNull(drCheckCopyTemplate.Item("IsCopyTemplate"), "0"), Boolean)
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(drCheckCopyTemplate)

                                    If blnIsCopyTemplate = False Then
                                        strSQLQuery = " usp_sel_Execution_Template_Revision " + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectPhaseTaskTemplateID"), "0"), String)
                                        objDR = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                        If objDR.Read Then
                                            isRevised = CType(CommonFunction.Data.CheckIsDBNull(objDR("isRevised"), "0"), Long)
                                        End If

                                        ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                        CommonFunction.Data.DisposeDataReader(objDR)
                                        ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                        If isRevised = 0 Then
                                            Args.IgnoreActualValue = True
                                            Args.EnableLink = False
                                            Args.ReplacementValue = "<FONT color='RED'>" + "Latest" + "</FONT>"
                                        End If
                                    Else
                                        Args.IgnoreActualValue = True
                                        Args.EnableLink = False
                                        Args.ReplacementValue = ""
                                    End If
                                End If
                            End If

                            If Args.ColumnName.ToUpper = "TEMPLATE TYPE" Then
                                strSQLQuery = "Select IsCopyTemplate from tbl_PM_Project_PhaseTask_Template "
                                strSQLQuery = strSQLQuery & " Where projectphasetasktemplateid = " & CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectPhaseTaskTemplateID"), "0"), String)
                                drCheckCopyTemplate = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
                                If drCheckCopyTemplate.Read Then
                                    blnIsCopyTemplate = CType(CommonFunctions.Data.CheckIsDBNull(drCheckCopyTemplate.Item("IsCopyTemplate"), "0"), Boolean)
                                End If
                                CommonFunctions.Data.DisposeDataReader(drCheckCopyTemplate)
                                If blnIsCopyTemplate = True Then
                                    Args.IgnoreActualValue = True
                                    Args.EnableLink = False
                                    Args.ReplacementValue = "Project Specific"
                                Else
                                    Args.IgnoreActualValue = True
                                    Args.EnableLink = False
                                    Args.ReplacementValue = "Inherited"
                                End If
                            End If

                            ' End Addition By NitinVS on 198 Feb 2005 

                            ''integration by harshada d on 15th june 2006
                            '				'Integrated by PrajaktaR on 15th May 2006 for WhizibleSEM 6.0.1 IssueID 3736
                            '                     '-----------------Added By HarshK On 14/07/2005--------------------------
                            '                     '-----------------Start--------------------------------------------------
                        Case CommonFunction.Constants.APP_TAG_PROJECT_CHECKLIST
                            ' added by harshada d for checklist issue fixes if role doesnt have add or delete access rhen copy and publish links should not be displayed
                            Dim drAccessRights As IDataReader
                            Dim strQuery As String
                            Dim intPostId As Integer
                            Dim intUserId As Integer
                            Dim strLoginType As String
                            Dim intProjectID As Integer
                            Dim blnAddRight As Boolean
                            Dim blnEditRight As Boolean
                            intPostId = CType(HttpContext.Current.Session("intPostID"), Integer)
                            intUserId = CType(HttpContext.Current.Session("intUserID"), Integer)
                            strLoginType = CType(HttpContext.Current.Session("LoginType"), String)
                            intProjectID = CType(HttpContext.Current.Session("intProjectID"), Integer)

                            strQuery = "Exec usp_Sel_tbl_UI_NodeAccess 2263 ," & intPostId.ToString & "," & intUserId.ToString & ",'" & strLoginType & "'," & intProjectID.ToString
                            drAccessRights = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If CommonFunctions.General.CheckIsNothing(drAccessRights) <> "" Then
                                drAccessRights.Read()
                                blnAddRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("A"), "False"), Boolean)
                                blnEditRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("E"), "False"), Boolean)

                            End If
                            CommonFunctions.Data.DisposeDataReader(drAccessRights)

                            'end of addition by harshada

                            Dim strSQLQuery As String
                            Dim drCompareRevision As IDataReader
                            Dim strIsCopyCheckList As String
                            strSQLQuery = ""
                            If Args.ColumnName.ToUpper = "CHECKLIST TYPE" Then
                                strIsCopyCheckList = Args.DataReader("IsCopyCheckList").ToString
                                If strIsCopyCheckList.ToUpper = "TRUE" Then
                                    Args.IgnoreActualValue = True
                                    Args.ReplacementValue = "Project Specific"
                                Else
                                    Args.IgnoreActualValue = True
                                    Args.ReplacementValue = "Inherited"
                                End If
                            End If
                            If Args.ColumnName.ToUpper = "GET LATEST REVISION" Then
                                strIsCopyCheckList = Args.DataReader("IsCopyCheckList").ToString
                                If strIsCopyCheckList.ToUpper = "TRUE" Then
                                    Args.IgnoreActualValue = True
                                    Args.EnableLink = False
                                    Args.ReplacementValue = ""
                                Else
                                    If Args.DataReader("ProjectCheckListID").ToString <> "" Then
                                        strSQLQuery = "EXEC usp_Sel_tbl_PM_WorkOrderChecklist_CheckLatest " & CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectCheckListID"), "0"), String)
                                        drCompareRevision = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
                                        If drCompareRevision.Read Then
                                            Args.IgnoreActualValue = True
                                            Args.EnableLink = False
                                            Args.ReplacementValue = "<FONT color='RED'>" + "Latest" + "</FONT>"
                                        End If
                                        CommonFunctions.Data.DisposeDataReader(drCompareRevision)
                                    End If
                                End If
                            End If
                            '-----------------End----------------------------------------------------
                            '--------Added by HarshK on 18/07/2005
                            Dim strProjectCheckListID As String = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectCheckListID"), "0"), String) & ""
                            Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
                            If Args.ColumnName.ToUpper = "COPY" Then
                                ' added by harshada d for checklist issue fixes if role doesnt have add or delete access rhen copy and publish links should not be displayed
                                If (blnAddRight = True Or blnEditRight = True) Then
                                    'end of addition by harshada .
                                    strSQLQuery = "usp_Sel_tbl_PM_WorkOrderChecklist_IsPublished " + strProjectCheckListID.Trim
                                    If CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, blnUseSQL), "0"), Integer) = 0 Then
                                        Args.IgnoreActualValue = True
                                        Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/Copy.gif' title='Please publish the checklist to use for Copy checklist.' ></A></TD>"
                                        Cancel = True
                                        Args.EnableLink = False
                                    End If
                                Else

                                    Cancel = True

                                End If

                            End If

                            'if Revisionstatus="D" then display link as publish,else dont display link
                            If Args.DataField.ToLower = "hyperlink1" Then
                                ' added by harshada d for checklist issue fixes if role doesnt have add or delete access rhen copy and publish links should not be displayed
                                If (blnAddRight = True Or blnEditRight = True) Then
                                    'end of addition by harshada
                                    strSQLQuery = "usp_Sel_tbl_PM_WorkOrderChecklist_IsPublished " + strProjectCheckListID.Trim
                                    If CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, blnUseSQL), "0"), Integer) > 0 Then
                                        'If the checklist is published then do not show the link..
                                        Args.IgnoreActualValue = True
                                        Args.ReplacementValue = "<FONT color='RED'>" + "Published" + "</FONT>"
                                        Args.EnableLink = False
                                        'added by harshada d for whiziblesem SP 7.4 for chkList issue . if no items present then chklist will be published
                                    Else
                                        Dim drCntOfQuestionaire As IDataReader
                                        Dim strSQLCntOfQuestionaireID As String
                                        Dim intCntOfprojectChecklistItemID As Integer
                                        Dim strFunction As String
                                        'If CommonFunction.Data.CheckIsDBNull(Args.DataReader("QuestionnaireID"), "").ToString.Trim <> "" Then
                                        Dim drApplicableChecklists As IDataReader
                                        strSQLCntOfQuestionaireID = "select ISNULL(count(projectChecklistItemID),0) AS CountprojectChecklistItemID from tbl_PM_WorkOrderCheckListItem  where projectChecklistID =  " + Args.DataReader("projectChecklistID").ToString
                                        intCntOfprojectChecklistItemID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLCntOfQuestionaireID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Integer)
                                        If intCntOfprojectChecklistItemID = 0 Then
                                            Cancel = True
                                            Args.StringToBeInserted = "<TD align=left Title=""Column Name : Publish"">"
                                            Args.StringToBeInserted += "<A href='JavaScript:PublishNoItems_OnClick()' >Publish"
                                            Args.StringToBeInserted += "</A>"
                                            Args.StringToBeInserted += "</TD>"
                                            Args.StringToBeInserted += "<Script language='JavaScript'>"
                                            Args.StringToBeInserted += " function PublishNoItems_OnClick() { "
                                            Args.StringToBeInserted += " alert('There are no checklist items present against this checklist , cannot publish it');"
                                            Args.StringToBeInserted += " }"
                                            Args.StringToBeInserted += "</Script>"
                                            CommonFunctions.Data.DisposeDataReader(drCntOfQuestionaire)
                                            ' End If
                                        End If
                                    End If
                                Else

                                    Cancel = True

                                End If

                            End If
                            '---------END HarshK on 18/07/2005----------------------------------------------------------------

                            ' Modified By NitinVs on 23 Apr 2007 for WhizibleSEM SP 8 regression Fiexes Issue 12367 
                            ' Tocheck add access for COPY and EDIT Access for PUBLISH 

                            If Args.ColumnName.ToUpper = "COPY" Then
                                If (blnAddRight = True) Then
                                Else
                                    Cancel = True
                                End If
                            End If
                            'end of addition by harshada
                            If Args.ColumnName.ToUpper = "PUBLISH" Then
                                If (blnEditRight = True) Then
                                Else
                                    Cancel = True
                                End If
                            End If
                            ' End Addition  By NitinVs on 23 Apr 2007 for WhizibleSEM SP 8 regression Fiexes Issue 12367 

                            'END Of Integration by PrajaktaR on 15th May 2006 for WhizibleSEM 6.0.1 IssueID 3736
                            'end of integration by harshada d on 15th june 2006
                            'added by SachinR   on 10 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_PHASETASK_REVISION
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_PHASETASK_TEMPLATE_REVISION_1, CommonFunction.Constants.APP_TAG_PHASETASK_TEMPLATE_REVISION_2
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'addition end
                            'added by SachinR   on 14 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_CONFIGURE_OU
                            If Args.ColumnName.ToUpper = "LOCATIONNAME" Then
                                Cancel = True
                            ElseIf Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'addition end
                            'added by SachinR   on 15 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_ADD_PROCESS_TO_OU
                            If Args.ColumnName.ToUpper = "DUMMYCOLUMN" Then
                                Cancel = True
                            End If
                            'addition end

                            'Added by ShamkantD on 16 Sep 2004 - for Select Cost Heads page (called from Project Costs)
                        Case CommonFunction.Constants.APP_TAG_TAB_SELECT_COST_HEADS
                            'Suppress the hyperlink
                            If Args.DataField.Trim.ToUpper = "COSTHEAD" Then
                                Args.EnableLink = False
                            End If
                            'End of addition - ShamkantD on 16 Sep 2004

                            'added by SachinR   on 17 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_ADD_METRIC_TO_OU
                            If Args.ColumnName.ToUpper = "DUMMYCOLUMN" Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_ADD_PMI_TO_OU
                            If Args.ColumnName.ToUpper = "DUMMYCOLUMN" Then
                                Cancel = True
                            End If
                            'addition end
                            'added by SachinR   on 21 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_MAIN_PROJECT_TYPE
                            Dim strSQL As String
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                strSQL = "usp_Sel_IsProjectTypeAssociatedToPractice " + Args.DataReader("ProjectTypeID").ToString
                                If CType(CommonFunction.Data.GetDataScalar(strSQL, True), Boolean) Then
                                    Args.IsCheckBoxDisabled = True
                                End If
                            End If
                            'addition end

                            'Added by ShamkantD on 27 Sep 2004 - added for 'Project Listing for Approvals' page
                        Case CommonFunction.Constants.APP_TAG_PROJECT_LISTING_FOR_APPROVALS
                            If Args.DataField.ToUpper() = "PROJECTNAME" Then
                                Dim strPrjName As String

                                'Code Added By VidyaJ - Security Issue - 
                                Dim strToken As String
                                strToken = CommonFunctions.Security.Token.GetToken(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectID"), "0"), "0").ToString() + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString + "0" + "32")

                                ''Modified By JyotiG
                                'Issue ID : 6184
                                'Date : 11-Sep-2006
                                'Start
                                strPrjName = Replace(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectName"), ""), "").ToString(), "'", "\'")
                                'End
                                Args.IgnoreActualValue = True
                                Args.StringToBeInserted = "<TD  nowrap align=Left Title=""Column Name : Project Name"">"
                                Args.StringToBeInserted &= "<A href=""javascript:ShowProjectInfo("
                                Args.StringToBeInserted &= CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectID"), "0"), "0").ToString()
                                ''Modified By JyotiG
                                'Issue ID : 6184
                                'Date : 11-Sep-2006
                                'Start
                                'Args.StringToBeInserted &= ",'" & HttpContext.Current.Server.HtmlEncode(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectName"), ""), "").ToString()) & "'"
                                'Args.StringToBeInserted &= ")"">" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectName"), ""), "").ToString() & "</A>"

                                'Modifed By NitinVS on 9 Mar 2007 for WhizibleSEM SP8 Regressssion Issues ISsueID 11101
                                Args.StringToBeInserted &= ",'" & HttpContext.Current.Server.UrlEncode(strPrjName) & "'"
                                'End Modification By NitinVS on 9 Mar 2007 for WhizibleSEM SP8 Regressssion Issues ISsueID 11101

                                'Code Added By VidyaJ - Security Issue - 
                                Args.StringToBeInserted &= ",'" + strToken + "')"">" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectName"), ""), "").ToString() & "</A>"
                                'End 
                                Args.StringToBeInserted &= "</TD>"
                                Cancel = True

                            End If
                            'End of addition - ShamkantD on 27 Sep 2004

                            'Added by ShamkantD on 5 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_BUSINESS_GROUP
                            'Added for Select Middle Level Resources for Business Group
                            If Args.DataField.ToUpper = "EMPLOYEENAME" Then
                                Args.EnableLink = False
                            End If
                            'End of addition - ShamkantD on 5 Oct 2004

                            'Added by ShamkantD on 6 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_ORGANIZATION_UNIT
                            'Added for Select Middle Level Resources for organization unit
                            If Args.DataField.ToUpper = "EMPLOYEENAME" Then
                                Args.EnableLink = False
                            End If

                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_DELIVERY_UNIT
                            'Added for Select Middle Level Resources for Delivery unit
                            If Args.DataField.ToUpper = "EMPLOYEENAME" Then
                                Args.EnableLink = False
                            End If

                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_DELIVERY_TEAM
                            'Added for Select Middle Level Resources for Delivery Team
                            If Args.DataField.ToUpper = "EMPLOYEENAME" Then
                                Args.EnableLink = False
                            End If
                            'End of addition - ShamkantD on 6 Oct 2004
                            'added by SachinR   on 12 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_MAIN_DELIVERABLE_TYPES
                            'hide the dummy column to show custom link on another column
                            If Args.ColumnName.ToUpper = "DUMMYCOLUMN" Or Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            ElseIf Args.ColumnName.ToUpper = "DELIVERABLE TYPE" Then
                                Args.IgnoreActualValue = True
                                Args.StringToBeInserted = "<TD  nowrap align=Left Title=""Column Name : Deliverable Type"">"
                                Args.StringToBeInserted += "<A href=""javascript:Deliverable_OnClick('"
                                Args.StringToBeInserted += CommonFunction.Data.CheckIsDBNull(Args.DataReader("ScheduleID"), "0").ToString() + "')"">"
                                Args.StringToBeInserted += CommonFunction.Data.CheckIsDBNull(Args.DataReader("LabelSchedule"), "").ToString() + "</A>"
                                Args.StringToBeInserted += "</TD>"

                                Cancel = True
                            End If
                            'addition end

                            'Code added By VidyaJ on 16th Oct 2004
                            'Remove Delete checkbox
                        Case CommonFunction.Constants.APP_TAG_ISSUE_CODEGENERATION
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'Addition 

                            'Added By JayavantK on 18-Oct-2004  --- Issue ID = 12723
                        Case CommonFunction.Constants.APP_TAG_BUSINESS_GROUP, CommonFunction.Constants.APP_TAG_ORGANIZATION_UNIT,
                             CommonFunction.Constants.APP_TAG_DELIVERY_UNIT, CommonFunction.Constants.APP_TAG_DELIVERY_TEAM
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End Addition 
                            'End Addition

                            'added by SachinR   on 20 Oct 2004
                            'show all the checkbox selected bydefault
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLETYPE_RESOURCE_ACCESS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Args.IsSelected = True

                                'added by SachinR   on 17 Nov 2004
                                'issue - 13955
                            ElseIf Args.ColumnName.ToUpper = "DUMYCOLUMN" Then
                                Cancel = True
                                'addition end
                            End If
                            'addition end
                        Case CommonFunction.Constants.APP_TAG_GLOBAL_GEN_TASKS
                            Args.EnableLink = False

                            ' integrated by harshada d for whizible sem SP7.2 for Issue ID 4518*/
                            '' Modified By ParagD On 3-July-2006
                            '' Purpose : Sierra 2529 - void tasks are not shown in "Show void Tasks" page.

                        Case CommonFunction.Constants.APP_TAG_VOIDED_TASKS
                            If Args.DataField.ToUpper = "USERNAME" Then
                                Args.EnableLink = False
                            End If
                            ''Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                            Dim m_strdispWork As String
                            If Args.DataField.ToUpper = "PLANNEDWORK" Then
                                Cancel = True
                                m_strdispWork = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + Args.DataReader("PlannedWork").ToString() + "',1)", True)
                                Args.StringToBeInserted = "<td valign='top' align='right'>" + m_strdispWork + "</td>"
                            End If
                            If Args.DataField.ToUpper = "ACTUALWORK" Then
                                Cancel = True
                                m_strdispWork = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + Args.DataReader("ActualWork").ToString() + "',1)", True)
                                Args.StringToBeInserted = "<td valign='top' align='right'>" + m_strdispWork + "</td>"
                            End If
                            ''End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change

                            '' END : Modified By ParagD On 3-July-2006.


                            'end of integration
                            ' Added By NitinVS on 7 Dec 2004 
                            ' To Remove Link for Template name column
                        Case CommonFunction.Constants.APP_TAG_SELECT_TEMPLATE_FOR_PROJECT
                            If Args.ColumnName.ToUpper = "TEMPLATE TITLE" Then
                                Args.EnableLink = False
                            End If
                            'Remove delete check box 
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            ' End Addition NitinVS 7 Dec 2004

                            ' Added By PrachiK on 28 Mar 2005 
                            ' To Remove Link for CheckList name column
                        Case CommonFunction.Constants.APP_TAG_SELECT_CHECKLIST_FOR_PROJECT
                            If Args.ColumnName.ToUpper = "CHECK LIST" Then
                                Args.EnableLink = False
                            End If
                            'Remove delete check box 
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            'Added by PrachiK on 29 Mar 2005
                            'When Single Quotes are used in Check list name then to suppress single quote following line is added.
                            ' If Args.DataField.ToUpper = "CHECKLISTSHORTNAME" Then

                            If Args.ColumnName.ToUpper = "SELECT CHECK LIST" Then
                                Dim strCheckList As String = ""
                                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CheckListShortName"), ""), String) <> "" Then
                                    strCheckList = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CheckListShortName"), ""), String)
                                    strCheckList = Replace(strCheckList, "'", "\'")
                                End If
                                Args.Alignment = "left"
                                Args.StringToBeInserted = "<TD  nowrap vAlign=top title='Selected Check List will be added to the project' width='50%'><A href=""JavaScript:Hyperlink1('" + strCheckList + "','" + CType(Args.DataReader("QuestionnaireID"), String) + "');"">" + "Select CheckList" + "</A></td>"
                                Cancel = True
                            End If
                            'End of addtion by prachiK

                            ' Code added by SwapnilR on 13th Dec 2004
                        Case CommonFunction.Constants.APP_TAG_ROLE_ACCESS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            ' End of code addtion by SwapnilR 
                            'Added By MrugajaB on 2 Mar 2005 for Project Document category
                        Case CommonFunction.Constants.APP_TAG_PROJECT_DOCUMENTCATEGORY
                            If Args.ColumnName.ToUpper = "DOCUMENT CATEGORY" Then
                                Args.EnableLink = False
                            End If

                            If Args.ColumnName.ToUpper = "USED" Then
                                Cancel = True
                            End If
                            'Modified By NitinVS on 10 MArch 2005 for PBNITE SP2 
                            ' Changed the ColIndex from 2 to 1 
                            'If Args.Colindex = 2 Then
                            If Args.ColIndex = 1 Then
                                ' End Modification By NitinVS on 10 MArch 2005 PBNITE SP2

                                If (CType(Args.DataReader.Item("Used"), Integer)) > 0 Then
                                    Args.IsSelected = True
                                    Args.IsCheckBoxDisabled = True
                                End If
                                'If Args.ColIndex = 2 Then
                                Dim objDr As IDataReader
                                Dim strQuery As String
                                Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                                Dim strCategoryID As String
                                strCategoryID = CType(Args.DataReader("CategoryID"), String)
                                strQuery = "SELECT CategoryID FROM tbl_PM_projectDocumentCategory WHERE ProjectID = " + intProjectID.ToString + " AND CategoryID= " + strCategoryID
                                objDr = CommonFunction.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If objDr.Read Then
                                    Args.IsSelected = True
                                End If

                                ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                CommonFunction.Data.DisposeDataReader(objDr)
                                ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                'End If
                            End If
                            'End Addition

                            'Added By MrugajaB on 28th March 2005
                            'purpose:For disabling the link for EmployeeName column displayed on 'Sho Project Approvers' Page
                        Case CommonFunction.Constants.APP_TAG_PROJECT_APPROVERS
                            If Args.ColumnName.ToUpper = "EMPLOYEE NAME" Then
                                Args.EnableLink = False

                            End If
                            'End Addition

                            'Added By MrugajaB on 8th April 2005
                            'purpose:For disabling the link for EmployeeName column displayed on 'Show Request Approvers' Page
                        Case CommonFunction.Constants.APP_TAG_REQUEST_APPROVERS
                            Dim m_Employee As String
                            'm_Employee = Args.DataReader("EmployeeName").ToString.Trim
                            If Args.ColumnName.ToUpper = "EMPLOYEE NAME" Then
                                Args.EnableLink = False
                            End If

                            'End Addition

                            'Code Integrated by MrugajaB on 4th May,2005 for WhizibleSEM SP3 Task Progress feature
                        Case CommonFunction.Constants.APP_TAG_PENDING_DELIVERABLE_PROGRESS
                            Select Case Args.ColumnName.ToUpper
                                Case "FROM DATE"
                                    Args.EnableLink = False
                            End Select
                            ' End of code addtion by SwapnilR on 8th April 2005

                        Case (CommonFunction.Constants.APP_TAG_PENDING_DELIVERABLE_TASK_DETAILS)
                            Select Case Args.ColumnName.ToUpper
                                Case "DELETE"
                                    Cancel = True
                                Case "FROM DATE"
                                    Args.EnableLink = False
                                Case "DISPLAY TASK PROGRESS"
                                    If CommonFunction.Data.CheckIsDBNull(Args.DataReader("LinkDummy"), "").ToString.Trim = "0" Then
                                        Cancel = True
                                        Args.StringToBeInserted += "<td></td>"
                                    End If
                            End Select
                            ' End of code addtion by SwapnilR on 5th April 2005
                            ' Code added by PradipK on 7th April 2005
                            ' Purpose : To hide the delete checkbox, to disable the link 
                        Case CommonFunction.Constants.APP_TAG_PENDING_TASK_PROGRESS
                            Select Case Args.ColumnName.ToUpper
                                Case "DELETE"
                                    Cancel = True
                                Case "FROM DATE"
                                    Args.EnableLink = False
                            End Select
                            ' End of code addtion by PradipK on 7th April 2005
                            ' Code added by PradipK on 8th April 2005
                            ' Purpose : To disable the link of From Date
                        Case CommonFunction.Constants.APP_TAG_PROJECT_PERCENT_PROGRESS
                            Select Case Args.ColumnName.ToUpper
                                Case "FROM DATE"
                                    Args.EnableLink = False
                            End Select
                            ' End added by PradipK on 8th April 2005
                            'End Integration
                        Case CommonFunction.Constants.APP_TAG_REVIEW_PLANNING
                            'Added by MrugajaB on 1st Feb 2005 for Multiple reviewees feATURE (iSSUE id.1835)
                            'Purpose:Remove the link for Reviewee in CL page
                            If Args.DataField.ToUpper = "REVIEWEE" Then
                                Args.EnableLink = False
                            End If
                            'End of Addition by MrugajaB on 14 Nov,2005 for IssueID --1835

                        Case CommonFunction.Constants.APP_TAG_REVIEWS
                            'Added by MrugajaB on 1st Feb 2005 for Multiple reviewees feATURE (iSSUE id.1835)
                            'Purpose:Remove the link for Reviewee in CL page
                            If Args.DataField.ToUpper = "REVIEWEE" Then
                                Args.EnableLink = False
                            End If
                            'End of Addition by MrugajaB on 14 Nov,2005 for IssueID --676

                            'Added by MrugajaB on 16th Feb 2006 for Issue ID. 671
                            'Purpose:When code template is not defined or IsCodeTemplateEditable is true then code template should npt be displayed
                        Case CommonFunction.Constants.APP_TAG_PRS_DELIVERABLE_TYPES
                            If Args.ColumnName.ToUpper = "CODE TEMPLATE" Then

                                Dim blnIsCodeTempEditable As Boolean
                                Dim strSQL As String
                                Dim strCodeTemplate As String

                                blnIsCodeTempEditable = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("IsCodeTemplateEditable"), "0"), Boolean)
                                strCodeTemplate = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("CodeTemplate"), ""), String)

                                If blnIsCodeTempEditable = True Then

                                    Args.IgnoreActualValue = True
                                    Args.ReplacementValue = "-"
                                Else
                                    If strCodeTemplate = "" Then
                                        Args.IgnoreActualValue = True
                                        Args.ReplacementValue = "-"
                                    End If
                                End If
                            End If
                            '''----------------------------------------------------------------------------------
                            '''Code Added by SajiU on 5th Dec 2006
                            '''--------------------------------------------------
                        Case CommonFunction.Constants.App_Tag_Login_Maintenance
                            Dim strSelection As String
                            Dim strSelectionValue As String
                            Dim strSelectSQL As String
                            Dim drSelectionValue As IDataReader


                            If Not IsNothing(HttpContext.Current.Request.Form("Selection")) Then
                                strSelection = HttpContext.Current.Request.Form("Selection")
                                If strSelection = "Login Not Created" Or strSelection = "" Then
                                    If Args.DataField.Trim.ToUpper = "USERNAME" Then
                                        Args.EnableLink = False
                                    End If

                                End If
                            Else


                                strSelectSQL = "select FixedValue from tbl_UI_employeefiltersettings_fielddetails where tagid=3702 and Controlname= 'Selection' and userid = " + HttpContext.Current.Session("intUserID").ToString
                                drSelectionValue = CommonFunctions.Data.GetDataReader(strSelectSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If CommonFunctions.General.CheckIsNothing(drSelectionValue, "") <> "" Then
                                    If drSelectionValue.Read() Then
                                        strSelectionValue = CType(CommonFunctions.Data.CheckIsDBNull(drSelectionValue("FixedValue"), ""), String)
                                    End If
                                End If
                                CommonFunctions.Data.DisposeDataReader(drSelectionValue)
                                If strSelectionValue = "Login Not Created" Then
                                    If Args.DataField.Trim.ToUpper = "USERNAME" Then
                                        Args.EnableLink = False
                                    End If

                                End If
                                If strSelectionValue = "Login is Active" Then
                                    If Args.DataField.Trim.ToUpper = "USERNAME" Then
                                        Args.EnableLink = True
                                    End If

                                End If
                                If strSelectionValue = "Login is Inactive" Then
                                    If Args.DataField.Trim.ToUpper = "USERNAME" Then
                                        Args.EnableLink = True
                                    End If

                                End If
                                If strSelectionValue = "" Then
                                    If Args.DataField.Trim.ToUpper = "USERNAME" Then
                                        Args.EnableLink = False
                                    End If

                                End If
                            End If


                            '''----------------------------------------------------------------------------------
                            '''End of Addition by SajiU on 5th Dec 2006
                            '''----------------------------------------------------------------------------------

                            'End Addition
                            ' Added By SrikanthY on 22 Nov 2006
                            'Case CommonFunction.Constants.App_Tag_Flagtrack
                            '    If Args.ColumnName.ToUpper = "FLAG" Then
                            '        Dim Contextid As String
                            '        Dim Projectid As String
                            '        Dim Employeeid As String
                            '        Dim Contexttype As String
                            '        Dim EntityName As String

                            '        Contextid = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Contextid"), "0"), String)
                            '        Projectid = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Projectid"), "0"), String)
                            '        Employeeid = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Employeeid"), "0"), String)
                            '        Contexttype = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Contexttype"), "0"), String)
                            '        EntityName = ""

                            '        Cancel = True
                            '        If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("DueDateState"), ""), String) = "S" Then

                            '            Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/YellowFlag.gif'  title='YellowFlag' onclick=""javascript:FlagSet(" + Projectid + "," + Contextid + "," + Employeeid + "," + "'" + Contexttype + "'" + "," + "'" + EntityName + "'" + " )"" ></A></TD>"

                            '        ElseIf CType(Args.DataReader("DueDateState"), String) = "L" Then
                            '            Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/RedFlag.gif' title='RedFlag' onclick=""javascript:FlagSet(" + Projectid + "," + Contextid + "," + Employeeid + "," + "'" + Contexttype + "'" + "," + "'" + EntityName + "'" + " )"" ></A></TD>"


                            '        ElseIf CType(Args.DataReader("DueDateState"), String) = "G" Then
                            '            Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/GreenFlag.gif' title='GreenFlag' onclick=""javascript:FlagSet(" + Projectid + "," + Contextid + "," + Employeeid + "," + "'" + Contexttype + "'" + "," + "'" + EntityName + "'" + " )"" ></A></TD>"
                            '        End If
                            '    End If

                            '    If Args.DataField.ToUpper = "CONTEXTTYPECHAR" Then
                            '        Dim ContextC As String
                            '        ContextC = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ContextTypeChar"), ""), String)
                            '        Cancel = True
                            '        Select Case ContextC
                            '            Case "D"
                            '                Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/D.gif'  title='D' ></A></TD>"
                            '            Case "H"
                            '                Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/H.gif'  title='H' ></A></TD>"
                            '            Case "I"
                            '                Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/I.gif'  title='I' ></A></TD>"
                            '            Case "M"
                            '                Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/M.gif'  title='M' ></A></TD>"
                            '            Case "R"
                            '                Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/R.gif'  title='R' ></A></TD>"
                            '            Case "T"
                            '                Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/T.gif'  title='T' ></A></TD>"
                            '            Case "W"
                            '                Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/W.gif'  title='W' ></A></TD>"

                            '        End Select
                            '    End If
                            '    ' End of Addition by SrikanthY

                            'Added by PrashantD on 21 March 2007 for CleanUp Activity
                        Case CommonFunction.Constants.APP_TAG_RESOURCES
                            If Args.ColumnName = "Delegate Tasks" Then
                                If HttpContext.Current.Session("intUserID").ToString.Trim = Args.DataReader("EmployeeID").ToString.Trim Then
                                    Cancel = True
                                    Args.StringToBeInserted = "<TD align=center>-</TD>"
                                End If

                            End If
                            'End of addition by PrashantD on 21 March 2007
                            'Added by VarunA on 26-Sep-2008 
                            'Purpose : Security Issue
                        Case CommonFunction.Constants.APP_TAG_Task_View_Report
                            If Args.ColumnName.ToUpper = "INDICATOR" Then
                                Args.ApplyHTMLEncode = False
                            End If
                            'End by VarunA on 26-Sep-2008 

                            ''Added by Dhanashri S on 29 Oct 2015
                        Case CommonFunctions.Constants.MASTER_TAG_CONFIGURATION
                            ' For Ref. No : WAF3_GEN_3
                            If UCase(Args.DataField) = "TAGDESCRIPTION" Then
                                Dim strSQL As String = "usp_Sel_tbl_SaaS_UI_TagMaster_Tenant " + Args.DataReader("TagID").ToString + ",'" + HttpContext.Current.Session("TenantID").ToString + "'"
                                Dim newTagID As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True))
                                If newTagID = "" Then
                                    Args.EnableLink = False
                                Else
                                    Cancel = True
                                    Args.StringToBeInserted = "<TD nowrap  align=Left ><A href=""Javascript:TagDescription('" + newTagID + "')"">" + Args.DataReader("TagDescription").ToString + "</A></TD>"
                                End If
                            End If
                            ''End of Addition by Dhanashri S on 29 Oct 2015

                    End Select
                Else
                    'Details Tag


                    Select Case WhizGlobal.TagID
                        'Added By ShraddhaM on 28 Sep 2006 for IssueID : 6502

                        Case CommonFunction.Constants.APP_TAG_TAB_REVIEW_DOCUMENTS
                            If Args.DataField.ToUpper = "HYPERLINK1" Then
                                Cancel = True
                                Dim m_strToken As String
                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("UniqueID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(1026, String))

                                Args.IgnoreActualValue = True
                                Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../PM/PM_ProjectDocuments.aspx?Mode=REVIEW&MasterTagID=1026&FromWhere=PM&DocumentID=" & CType(Args.DataReader.Item("DocumentID"), String) & "&UniqueID=" & CType(Args.DataReader.Item("UniqueID"), String) & "&ParentToken=" & m_strToken & ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=300"");'>Review</a> </TD>"

                            End If
                            'Added By JyotiG
                            'Start_JG_12486_06-Apr-2007
                            If Args.DataField.ToUpper = "HYPERLINK2" Then
                                Cancel = True
                                Dim m_strToken As String
                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("UniqueID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(1026, String))
                                Args.IgnoreActualValue = True
                                Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../PM/PM_ProjectDocuments.aspx?Mode=HISTORY&IsReview=Y&MasterTagID=1026&FromWhere=PM&DocumentID=" & CType(Args.DataReader.Item("DocumentRefID"), String) & "&UniqueID=" & CType(Args.DataReader.Item("UniqueID"), String) & "&PkToken=" & m_strToken & ""","""",""resizable=yes,menubar=no,scrollbars=no,left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-600)/2 + "",width=500,height=600"");'>History</a> </TD>"
                            End If
                            'End_JG_12486_06-Apr-2007
                            'Added By VarunA on 18-Aug-2008 RequestID-10309
                            'Purpose : To have view of the attached contents and view attach URL
                            If Args.DataField.ToUpper = "FILENAME" Then
                                Dim DocumentID As String
                                DocumentID = Args.DataReader("DocumentID").ToString
                                Args.IgnoreActualValue = True
                                If CType(Args.DataReader("IsURL"), Boolean) = True Then
                                    Args.ReplacementValue = "<A href = '" + Args.DataReader("FileName").ToString + "' target=_new > " + Args.DataReader("FileName").ToString + " </A>"
                                Else
                                    Args.ReplacementValue = "<A href='javascript: var objChild= window.open(""../PM/PM_ViewDocument.aspx?MasterTagID=1026&FromWhere=PM&DocumentID=" + DocumentID + ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=300"");'>" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("FileName").ToString, ""), "") + "</A>"
                                End If
                            End If
                            'End By VarunA on 18-Aug-2008 RequestID-10309
                        Case CommonFunction.Constants.APP_TAG_TAB_FAST_TRACK_REVIEW_DOCUMENTS
                            If Args.DataField.ToUpper = "HYPERLINK1" Then
                                Cancel = True
                                Dim m_strToken As String
                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("UniqueID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(2191, String))

                                Args.IgnoreActualValue = True
                                Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../PM/PM_ProjectDocuments.aspx?Mode=REVIEW&MasterTagID=2191&FromWhere=PM&DocumentID=" & CType(Args.DataReader.Item("DocumentID"), String) & "&UniqueID=" & CType(Args.DataReader.Item("UniqueID"), String) & "&ParentToken=" & m_strToken & ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=300"");'>Review</a> </TD>"

                            End If
                            'Endded By ShraddhaM on 28 Sep 2006 for IssueID : 6502
                            'Added By JyotiG
                            'Start_JG_12486_06-Apr-2007
                            If Args.DataField.ToUpper = "HYPERLINK2" Then
                                Cancel = True
                                Dim m_strToken As String
                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("UniqueID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(2191, String))
                                Args.IgnoreActualValue = True
                                Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../PM/PM_ProjectDocuments.aspx?Mode=HISTORY&IsReview=Y&MasterTagID=2191&FromWhere=PM&DocumentID=" & CType(Args.DataReader.Item("DocumentRefID"), String) & "&UniqueID=" & CType(Args.DataReader.Item("UniqueID"), String) & "&PkToken=" & m_strToken & ""","""",""resizable=yes,menubar=no,scrollbars=no,left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-600)/2 + "",width=500,height=600"");'>History</a> </TD>"
                            End If
                            'End_JG_12486_06-Apr-2007
                            'Added By VarunA on 18-Aug-2008 RequestID-10309
                            'Purpose : To have view of the attached contents and view attach URL
                            If Args.DataField.ToUpper = "FILENAME" Then
                                Dim DocumentID As String
                                DocumentID = Args.DataReader("DocumentID").ToString
                                Args.IgnoreActualValue = True
                                If CType(Args.DataReader("IsURL"), Boolean) = True Then
                                    Args.ReplacementValue = "<A href = '" + Args.DataReader("FileName").ToString + "' target=_new > " + Args.DataReader("FileName").ToString + " </A>"
                                Else
                                    Args.ReplacementValue = "<A href='javascript: var objChild= window.open(""../PM/PM_ViewDocument.aspx?MasterTagID=2191&FromWhere=PM&DocumentID=" + DocumentID + ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=300"");'>" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("FileName").ToString, ""), "") + "</A>"
                                End If
                            End If
                            'End By VarunA on 18-Aug-2008 RequestID-10309
                        Case CommonFunction.Constants.APP_TAG_TAB_TEMPLATES
                            If Args.DataField.ToLower = "description" Then Cancel = True
                            'Added by MonikaI on 27-Sep-2006 .IssueID : 6460 (Security)
                        Case CommonFunction.Constants.APP_TAG_TAB_MILESTONE_DOCUMENTS
                            If Args.DataField.ToUpper = "HYPERLINK1" Then
                                Dim m_strToken As String
                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("UniqueID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(34, String))

                                Args.IgnoreActualValue = True
                                Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../PM/PM_ProjectDocuments.aspx?Mode=REVIEW&MasterTagID=34&FromWhere=PM&DocumentID=" & CType(Args.DataReader.Item("DocumentID"), String) & "&UniqueID=" & CType(Args.DataReader.Item("UniqueID"), String) & "&ParentToken=" & m_strToken & ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=300"");'>Review</a> </TD>"
                                Cancel = True
                            End If
                            'End of addition by Monika
                            'Added By VarunA on 18-Aug-2008 RequestID-10309
                            'Purpose : To have view of the attached contents and view attach URL
                            If Args.DataField.ToUpper = "FILENAME" Then
                                Dim DocumentID As String
                                DocumentID = Args.DataReader("DocumentID").ToString
                                Args.IgnoreActualValue = True
                                If CType(Args.DataReader("IsURL"), Boolean) = True Then
                                    Args.ReplacementValue = "<A href = '" + Args.DataReader("FileName").ToString + "' target=_new > " + Args.DataReader("FileName").ToString + " </A>"
                                Else
                                    Args.ReplacementValue = "<A href='javascript: var objChild= window.open(""../PM/PM_ViewDocument.aspx?MasterTagID=34&FromWhere=PM&DocumentID=" + DocumentID + ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=300"");'>" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("FileName").ToString, ""), "") + "</A>"
                                End If
                            End If
                            'End By VarunA on 18-Aug-2008 RequestID-10309
                            'Added by Yogesh Jalamkar on 22-Aug-2016 For PKToken Security
                            If Args.DataField.ToUpper = "HYPERLINK2" Then
                                Dim m_strToken As String
                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("UniqueID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(34, String))
                                Args.IgnoreActualValue = True
                                Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../PM/PM_ProjectDocuments.aspx?Mode=HISTORY&MasterTagID=34&FromWhere=PM&DocumentID=" & CType(Args.DataReader.Item("DocumentID"), String) & "&DocumentRefID=" & CType(Args.DataReader.Item("DocumentRefID"), String) & "&UniqueID=" & CType(Args.DataReader.Item("UniqueID"), String) & "&ParentToken=" & m_strToken & ""","""",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 500)/2 + "",top="" + (window.screen.height - 600)/2 + "",width=500,height=600"");'>History</a> </TD>"
                                Cancel = True
                            End If
                            'End of addition by Yogesh Jalamkar on 22-Aug-2016 For PKToken Security
                            'Added by MonikaI on 28-Sep-2006 .IssueID : 6453 (Security)
                        Case CommonFunction.Constants.APP_TAG_TAB_PHASE_DOCUMENTS
                            If Args.DataField.ToUpper = "HYPERLINK1" Then
                                Dim m_strToken As String
                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("UniqueID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(516, String))

                                Args.IgnoreActualValue = True
                                'Commented by Yogesh J on 30-Nov-2015
                                '  Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../PM/PM_ProjectDocuments.aspx?Mode=REVIEW&MasterTagID=516&FromWhere=PM&DocumentID=" & CType(Args.DataReader.Item("DocumentID"), String) & "&UniqueID=" & CType(Args.DataReader.Item("UniqueID"), String) & "&ParentToken=" & m_strToken & ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=300"");'>Review</a> </TD>"
                                Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../PM/PM_ProjectDocuments.aspx?Mode=REVIEW&MasterTagID=516&FromWhere=PM&DocumentID=" & CType(Args.DataReader.Item("DocumentID"), String) & "&UniqueID=" & CType(Args.DataReader.Item("UniqueID"), String) & "&ParentToken=" & m_strToken & ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=550,height=300"");'>Review</a> </TD>"
                                'End of Comment by Yogesh J on 30-NOV-2015
                                Cancel = True
                            End If
                            'Added By VarunA on 18-Aug-2008 RequestID-10309
                            'Purpose : To have view of the attached contents and view attach URL
                            If Args.DataField.ToUpper = "FILENAME" Then
                                Dim DocumentID As String
                                DocumentID = Args.DataReader("DocumentID").ToString
                                Args.IgnoreActualValue = True
                                If CType(Args.DataReader("IsURL"), Boolean) = True Then
                                    Args.ReplacementValue = "<A href = '" + Args.DataReader("FileName").ToString + "' target=_new > " + Args.DataReader("FileName").ToString + " </A>"
                                Else
                                    Args.ReplacementValue = "<A href='javascript: var objChild= window.open(""../PM/PM_ViewDocument.aspx?MasterTagID=516&FromWhere=PM&DocumentID=" + DocumentID + ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=300"");'>" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("FileName").ToString, ""), "") + "</A>"
                                End If
                            End If
                            'End By VarunA on 18-Aug-2008 RequestID-10309
                            'Added by Yogesh Jalamkar on 22-Aug-2016 For PKToken Security
                            If Args.DataField.ToUpper = "HYPERLINK2" Then
                                Dim m_strToken As String
                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("UniqueID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(516, String))
                                Args.IgnoreActualValue = True
                                Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../PM/PM_ProjectDocuments.aspx?Mode=HISTORY&MasterTagID=516&FromWhere=PM&DocumentID=" & CType(Args.DataReader.Item("DocumentID"), String) & "&DocumentRefID=" & CType(Args.DataReader.Item("DocumentRefID"), String) & "&UniqueID=" & CType(Args.DataReader.Item("UniqueID"), String) & "&ParentToken=" & m_strToken & ""","""",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 500)/2 + "",top="" + (window.screen.height - 600)/2 + "",width=500,height=600"");'>History</a> </TD>"
                                Cancel = True
                            End If
                            'End of addition by Yogesh Jalamkar on 22-Aug-2016 For PKToken Security
                        Case CommonFunction.Constants.APP_TAG_TAB_CHANGE_REQUEST_DOCUMENTS
                            If Args.DataField.ToUpper = "HYPERLINK1" Then
                                Dim m_strToken As String
                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("UniqueID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(1039, String))

                                Args.IgnoreActualValue = True
                                Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../PM/PM_ProjectDocuments.aspx?Mode=REVIEW&MasterTagID=1039&FromWhere=PM&DocumentID=" & CType(Args.DataReader.Item("DocumentID"), String) & "&UniqueID=" & CType(Args.DataReader.Item("UniqueID"), String) & "&ParentToken=" & m_strToken & ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=300"");'>Review</a> </TD>"
                                Cancel = True
                            End If
                            'End of addition by Monika
                            'Added By VarunA on 18-Aug-2008 RequestID-10309
                            'Purpose : To have view of the attached contents and view attach URL
                            If Args.DataField.ToUpper = "FILENAME" Then
                                Dim DocumentID As String
                                DocumentID = Args.DataReader("DocumentID").ToString
                                Args.IgnoreActualValue = True
                                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsURL"), "false"), Boolean) = True Then
                                    Args.ReplacementValue = "<A href = '" + Args.DataReader("FileName").ToString + "' target=_new > " + Args.DataReader("FileName").ToString + " </A>"
                                Else
                                    Args.ReplacementValue = "<A href='javascript: var objChild= window.open(""../PM/PM_ViewDocument.aspx?MasterTagID=1039&Operation=VIEW_ATTACHMENT&FromWhere=PM&DocumentID=" + DocumentID + ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=300"");'>" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("FileName").ToString, ""), "") + "</A>"
                                End If
                            End If
                            'End By VarunA on 18-Aug-2008 RequestID-10309
                            'Added by Yogesh Jalamkar on 22-Aug-2016 For PKToken Security
                            If Args.DataField.ToUpper = "HYPERLINK2" Then
                                Dim m_strToken As String
                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("UniqueID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(1039, String))
                                Args.IgnoreActualValue = True
                                Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../PM/PM_ProjectDocuments.aspx?Mode=HISTORY&MasterTagID=1039&FromWhere=PM&DocumentID=" & CType(Args.DataReader.Item("DocumentID"), String) & "&DocumentRefID=" & CType(Args.DataReader.Item("DocumentRefID"), String) & "&UniqueID=" & CType(Args.DataReader.Item("UniqueID"), String) & "&ParentToken=" & m_strToken & ""","""",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 500)/2 + "",top="" + (window.screen.height - 600)/2 + "",width=500,height=600"");'>History</a> </TD>"
                                Cancel = True
                            End If
                            'End of addition by Yogesh Jalamkar on 22-Aug-2016 For PKToken Security
                            'Integrated by MrugajaB on 26th April 2005 for WhizibleSEM SP3
                            ' Code Added by RajkumarM ONSITE on 21st March 05
                        Case CommonFunction.Constants.APP_TAG_TAB_REVIEW_ACTIONS
                            Dim strQuery As String = ""
                            Dim drReviewDetails As IDataReader
                            Dim m_strReviewstatisticsID As String
                            Dim m_strReviewStatus As String = ""
                            ''Added and commented by PrashantSJ on 24th June 2009 for SEM 8.0  Hotfix 8.0.030
                            Dim blnIsOfflineReview As Boolean = False
                            ''End of addition and comment by PrashantSJ on 24th June 2009
                            Dim drTaskDetails As IDataReader

                            m_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ReviewStatisticsID_PK")
                            If m_strReviewstatisticsID = "" Then
                                m_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ForeignKeyValue")
                            End If
                            If m_strReviewstatisticsID = "" Then
                                m_strReviewstatisticsID = HttpContext.Current.Request("ReviewStatisticsID_PK")
                            End If

                            If Not Args.DataReader("ReviewStatisticsID") Is Nothing Then
                                m_strReviewstatisticsID = Args.DataReader("ReviewStatisticsID").ToString()
                            End If

                            If m_strReviewstatisticsID <> "" Then
                                ''Added and commented by PrashantSJ on 24th June 2009 for SEM 8.0  Hotfix 8.0.030
                                'strQuery = "Select ReviewStatus from tbl_pm_reviewstatistics Where ReviewStatisticsID= " + m_strReviewstatisticsID
                                strQuery = "Select IsOfflineReview,ReviewStatus from tbl_pm_reviewstatistics Where ReviewStatisticsID= " + m_strReviewstatisticsID
                                ''End of addition and comment by PrashantSJ on 24th June 2009
                                drReviewDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If CommonFunctions.General.CheckIsNothing(drReviewDetails, "") <> "" Then
                                    If drReviewDetails.Read() Then
                                        m_strReviewStatus = CType(CommonFunctions.Data.CheckIsDBNull(drReviewDetails("ReviewStatus"), ""), String)
                                        blnIsOfflineReview = CType(CommonFunctions.Data.CheckIsDBNull(drReviewDetails("IsOfflineReview"), "0"), Boolean)
                                    End If
                                End If
                                CommonFunctions.Data.DisposeDataReader(drReviewDetails)
                            End If

                            If Args.DataField.ToUpper = "ADD ISSUE" Or Args.DataField.ToUpper = "ADD TASK" Then

                                If m_strReviewStatus.ToUpper = "CLOSED" Then
                                    Cancel = True
                                Else

                                    'Added by MrugajaB on 14th Sept 2006 for whiziblesem SP7 issue ID.6197
                                    If Args.DataField.ToUpper = "ADD TASK" Then
                                        Dim strActionID As String
                                        strActionID = CommonFunctions.General.CheckIsNothing(Args.DataReader(Args.PrimaryKeyName))
                                        Cancel = True
                                        ''Added and commented by PrashantSJ on 24th June 2009 for SEM 8.0  Hotfix 8.0.030
                                        If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("IssueAssignedResource"), ""), String) = "" And Not blnIsOfflineReview Then
                                            ''End of addition and comment by PrashantSJ on 24th June 2009
                                            strQuery = "Exec usp_Sel_tbl_PM_ReviewActions " + CommonFunction.Data.CheckIsDBNull(Args.DataReader("ReviewActionID"), "0").ToString
                                            drTaskDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                            If drTaskDetails.Read() Then
                                                Dim m_strToken As String
                                                Dim intParentTaskID As Long
                                                Dim intChildTaskID As Long = 0
                                                Dim intReviewee As Long
                                                Dim drChildTaskDetails As IDataReader
                                                Dim intTempEmployeeId As Integer

                                                Dim drProjectSettings As IDataReader
                                                Dim blnUseActivities As Boolean = False
                                                Dim blnApplyEffortDistribution As Boolean = False




                                                'strQuery = "SELECT HaveSubTaskTypes, ApplyEffortDistribution"
                                                'strQuery &= " FROM tbl_PM_Project WHERE ProjectID = " & HttpContext.Current.Session("intProjectID").ToString()

                                                'drProjectSettings = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                                'If drProjectSettings.Read() Then
                                                '    blnUseActivities = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("HaveSubTaskTypes"), "False"), Boolean)
                                                '    blnApplyEffortDistribution = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ApplyEffortDistribution"), "False"), Boolean)
                                                'End If
                                                'CommonFunctions.Data.DisposeDataReader(drProjectSettings)

                                                intParentTaskID = CType(CommonFunction.Data.CheckIsDBNull(drTaskDetails("TaskID"), "0"), Long)
                                                intReviewee = CType(CommonFunction.Data.CheckIsDBNull(drTaskDetails("Reviewee"), "0"), Long)

                                                'If blnApplyEffortDistribution = False And blnUseActivities = False Then
                                                ' Modified By MahendraV On 11:08 AM 8/17/2007 For WhizibleSEM 7.0
                                                ' To IssueID (14756) : Project > Execute > Review > Conduct Review > Actions[Subtab] > Click on Task Details link : Invalid Access displayed
                                                ' Start_MV_8/17/2007 
                                                ' strQuery = "SELECT TaskID FROM tbl_PM_ProjectTasks WHERE ParentTask_UID = " & intParentTaskID.ToString() & " AND EmployeeID=" & intReviewee.ToString
                                                strQuery = "SELECT TaskID FROM tbl_PM_ProjectTasks WHERE ParentTask_UID = " & intParentTaskID.ToString()
                                                ' End_MV_8/17/2007 

                                                drChildTaskDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                                If drChildTaskDetails.Read() Then
                                                    intChildTaskID = CType(CommonFunction.Data.CheckIsDBNull(drChildTaskDetails("TaskID"), "0"), Long)

                                                Else
                                                    intChildTaskID = intParentTaskID
                                                End If

                                                If intChildTaskID <> 0 Then
                                                    m_strToken = CommonFunctions.Security.Token.GetToken(CType(CommonFunction.Data.CheckIsDBNull(intChildTaskID, "0"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(1038, String))
                                                    'Commented and modified by MonikaI on 5th Oct 2006 IssueID : 6636
                                                    'Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../PM/PM_TaskAssignment.aspx?MasterTagID=1038&FromWhere=PM&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ReviewActionID=" + strActionID + "&TaskID=" + intParentTaskID.ToString + "&PkToken=" + m_strToken + ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>Task Details</a> </TD>"
                                                    '-- if condition added by purvaj on 6 Jul 2009
                                                    '-- task details link was also getting displayed if the task is voided
                                                    If CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskAssignedResource"), "") <> "" Then
                                                        '-- End addition purvaj
                                                        Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../PM/PM_TaskAssignment.aspx?PageType=Review&MasterTagID=1038&FromWhere=PM&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ReviewActionID=" + strActionID + "&TaskID=" + intParentTaskID.ToString + "&PkToken=" + m_strToken + ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>Task Details</a> </TD>"
                                                    Else
                                                        Args.StringToBeInserted = "<TD Align='Center'>- </TD>"
                                                    End If

                                                    'End by MonikaI
                                                Else
                                                    'Commented and modified by MonikaI on 5th Oct 2006 IssueID : 6636
                                                    'Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../PM/PM_TaskAssignment.aspx?MasterTagID=1038&FromWhere=PM&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ReviewActionID=" + strActionID + "&TaskID=" + ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>Add Task</a> </TD>"
                                                    Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../PM/PM_TaskAssignment.aspx?PageType=Review&MasterTagID=1038&FromWhere=PM&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ReviewActionID=" + strActionID + "&TaskID=" + ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>Add Task</a> </TD>"
                                                    'End by MonikaI
                                                End If
                                                CommonFunction.Data.DisposeDataReader(drTaskDetails)
                                                CommonFunction.Data.DisposeDataReader(drChildTaskDetails)
                                            End If
                                        Else
                                            Args.StringToBeInserted = "<TD Align='Center'>- </TD>"
                                        End If

                                        If m_strReviewStatus.ToUpper = "CLOSED" Then
                                            Cancel = True
                                        End If
                                    End If
                                    'End Addition

                                    'Added by SavitaS on 28 Sept 2006 for SP7 Security issue ID 6197
                                    If Args.DataField.ToUpper = "ADD ISSUE" Then
                                        Dim strReviewAction As String
                                        Dim drIssue As IDataReader
                                        Dim strActionID As String
                                        Dim strIssueID As String = "0"
                                        Dim strReviewStatisticsID As String = "0"
                                        Dim m_strToken As String
                                        Dim strReviewee As String
                                        Dim strSQL As String
                                        Dim drUserName As IDataReader
                                        Dim strUserName As String = ""

                                        Cancel = True

                                        strActionID = CommonFunctions.General.CheckIsNothing(Args.DataReader(Args.PrimaryKeyName))
                                        ''Added and commented by PrashantSJ on 24th June 2009 for SEM 8.0  Hotfix 8.0.030
                                        If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskAssignedResource"), ""), String) = "" And Not blnIsOfflineReview Then
                                            ''End of addition and comment by PrashantSJ on 24th June 2009
                                            strReviewAction = "Exec usp_Sel_tbl_PM_ReviewActions " + CommonFunction.Data.CheckIsDBNull(Args.DataReader("ReviewActionID"), "0").ToString
                                            drIssue = CommonFunctions.Data.GetDataReader(strReviewAction, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                            If drIssue.Read() Then
                                                strIssueID = CType(CommonFunction.Data.CheckIsDBNull(drIssue("IssueID"), "0"), String)
                                                strReviewStatisticsID = CType(CommonFunction.Data.CheckIsDBNull(drIssue("ReviewStatisticsID"), "0"), String)
                                                strReviewee = CType(CommonFunction.Data.CheckIsDBNull(drIssue("Reviewee"), "0"), String)
                                            End If

                                            strSQL = "Select UserName from tbl_pm_employee where employeeid=" & strReviewee.ToString

                                            drUserName = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                            If drUserName.Read() Then
                                                strUserName = CType(CommonFunction.Data.CheckIsDBNull(drUserName("UserName"), "0"), String)
                                            End If

                                            If strIssueID <> "0" Then
                                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(CommonFunction.Data.CheckIsDBNull(strIssueID, "0"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(0, String))
                                                'Modified by PrashantD on 15 March 2007 for IssueID 11420
                                                'Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objIssue= window.open(""../IB/IB_IssueEntry.aspx?ReviewType=Reviews&IssueID=" + strIssueID + "&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ReviewActionID=" + strActionID + "&ReviewStatisticsID=" + strReviewStatisticsID + "&OrderBy=IssueID&FromReview=1&PkToken=" + m_strToken + ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>" + strUserName + "</a> </TD>"
                                                Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objIssue= window.open(""../IB/IB_IssueEntry.aspx?FromWhere=Review&ReviewType=Reviews&IssueID=" + strIssueID + "&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ReviewActionID=" + strActionID + "&ReviewStatisticsID=" + strReviewStatisticsID + "&OrderBy=IssueID&FromReview=1&PkToken=" + m_strToken + ""","""", ""resizable=yes,scrollbars=no,left="" + (window.screen.width - 800)/2 + "",top="" + (window.screen.height - 600)/2 + "",width=800,height=600"");'>" + strUserName + "</a> </TD>"
                                                'End of modification by PrashantD on 15 March 2007 
                                            Else
                                                'Modified by PrashantD on 15 March 2007 for IssueID 11420
                                                'Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objIssue= window.open(""../IB/IB_IssueEntry.aspx?ReviewType=Reviews&IssueID=" + strIssueID + "&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ReviewActionID=" + strActionID + "&ReviewStatisticsID=" + strReviewStatisticsID + "&OrderBy=IssueID&FromReview=1&PkToken=" + m_strToken + ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>Add Issue</a> </TD>"
                                                Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objIssue= window.open(""../IB/IB_IssueEntry.aspx?FromWhere=Review&ReviewType=Reviews&IssueID=" + strIssueID + "&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ReviewActionID=" + strActionID + "&ReviewStatisticsID=" + strReviewStatisticsID + "&OrderBy=IssueID&FromReview=1&PkToken=" + m_strToken + ""","""",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 800)/2 + "",top="" + (window.screen.height - 600)/2 + "",width=800,height=600"");'>Add Issue</a> </TD>"
                                                'End of modification by PrashantD on 15 March 2007 

                                            End If
                                            CommonFunction.Data.DisposeDataReader(drIssue)
                                        Else
                                            Args.StringToBeInserted = "<TD Align='Center'>- </TD>"
                                        End If


                                    End If
                                    'End of Added by SavitaS on 28 Sept 2006 for SP7 Security issue ID 6197

                                End If
                            End If
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                If m_strReviewStatus.ToUpper = "CLOSED" Then
                                    Cancel = True
                                End If
                            End If
                            ' End of Addition ONSITE
                            'End Integration

                        Case CommonFunction.Constants.APP_TAG_TAB_REVIEW_OBSERVATIONS
                            'Integrated by MrugajaB on 26th April 2005 for WhizibleSEM SP3
                            ' Code Added by RajkumarM ONSITE on 21st March 05
                            Dim strQuery As String = ""
                            Dim drReviewDetails As IDataReader
                            Dim m_strReviewstatisticsID As String
                            Dim m_strReviewStatus As String = ""
                            m_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ReviewStatisticsID_PK")
                            If m_strReviewstatisticsID = "" Then
                                m_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ForeignKeyValue")
                            End If
                            If m_strReviewstatisticsID = "" Then
                                m_strReviewstatisticsID = HttpContext.Current.Request("ReviewStatisticsID_PK")
                            End If

                            If m_strReviewstatisticsID <> "" Then
                                strQuery = "Select ReviewStatus from tbl_pm_reviewstatistics Where ReviewStatisticsID= " + m_strReviewstatisticsID
                                drReviewDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If CommonFunctions.General.CheckIsNothing(drReviewDetails, "") <> "" Then
                                    If drReviewDetails.Read() Then
                                        m_strReviewStatus = CType(CommonFunctions.Data.CheckIsDBNull(drReviewDetails("ReviewStatus"), ""), String)
                                    End If
                                End If
                                CommonFunctions.Data.DisposeDataReader(drReviewDetails)
                            End If
                            ' End of Addition ONSITE
                            'End Integration

                            If Args.DataField.ToUpper = "CONVERT TO ACTION POINT" Then
                                'Integrated by MrugajaB on 26th April 2005 for WhizibleSEM SP3
                                ' Added BY RajkumarM ONSITE on 21st March 05
                                If m_strReviewStatus.ToUpper = "CLOSED" Then
                                    Cancel = True
                                End If
                                ' End of Addition ONSITE
                                'End Integration
                                If CommonFunction.Data.CheckIsDBNull(Args.DataReader("ReviewActionID"), "0").ToString <> "0" Then
                                    Args.EnableLink = False
                                    Args.IgnoreActualValue = True

                                    'Create object of the ProjectByNet Template Class
                                    objTemplate = New WebPages.Template.WhizTemplate
                                    'Initialize the Resources
                                    objTemplate.InitializeResources("Resources.StandardMessages", "Resources")
                                    Args.ReplacementValue = objTemplate.GetResourceString("NOT_APPLICABLE")
                                    objTemplate = Nothing
                                End If
                            ElseIf Args.DataField.ToUpper = "REVIEWOBSERVATIONID" Then
                                If CommonFunction.Data.CheckIsDBNull(Args.DataReader("ReviewActionID"), "0").ToString <> "0" Then
                                    'if the observation is converted to Action then do not allow to Track it to next review
                                    Args.IsCheckBoxDisabled = True
                                End If
                            End If

                            'Integrated by MrugajaB on 26th April 2005 for WhizibleSEM SP3
                            ' Added BY RajkumarM ONSITE on 21st March 05
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                If m_strReviewStatus.ToUpper = "CLOSED" Then
                                    Cancel = True
                                End If
                            End If
                            ' End of Addition ONSITE on 21st March 05
                            'End Integration
                        Case CommonFunction.Constants.APP_TAG_TAB_FASTTRACKREVIEW_ACTIONS
                            Dim strQuery As String = ""
                            Dim drReviewDetails As IDataReader
                            Dim m_strReviewstatisticsID As String
                            Dim m_strReviewStatus As String = ""
                            m_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ReviewStatisticsID_PK")
                            If m_strReviewstatisticsID = "" Then
                                m_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ForeignKeyValue")
                            End If
                            If m_strReviewstatisticsID = "" Then
                                m_strReviewstatisticsID = HttpContext.Current.Request("ReviewStatisticsID_PK")
                            End If




                            If m_strReviewstatisticsID <> "" Then
                                strQuery = "Select ReviewStatus from tbl_pm_reviewstatistics Where ReviewStatisticsID= " + m_strReviewstatisticsID
                                drReviewDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If CommonFunctions.General.CheckIsNothing(drReviewDetails, "") <> "" Then
                                    If drReviewDetails.Read() Then
                                        m_strReviewStatus = CType(CommonFunctions.Data.CheckIsDBNull(drReviewDetails("ReviewStatus"), ""), String)
                                    End If
                                End If
                                CommonFunctions.Data.DisposeDataReader(drReviewDetails)
                            End If

                            If Args.DataField.ToUpper = "HYPERLINK1" Or Args.DataField.ToUpper = "HYPERLINK2" Then
                                If m_strReviewStatus.ToUpper = "CLOSED" Then
                                    Cancel = True
                                    'Added by MrugajaB on 14th Sept 2006 for whiziblesem SP7 issue ID.6197
                                    'Dim drTaskDetails As IDataReader
                                    'Dim m_strToken As String
                                    'Dim intTaskID As Long

                                    'If Args.DataField.ToUpper = "HYPERLINK2" Then
                                    '    strQuery = " SELECT ReviewActionID, TaskID FROM tbl_PM_ReviewActions WHERE ReviewActionID = " + CommonFunction.Data.CheckIsDBNull(Args.DataReader("ReviewActionID"), "0").ToString + " AND  ISNULL(TaskID,0) <> 0 "
                                    '    drTaskDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    '    If CommonFunctions.General.CheckIsNothing(drTaskDetails, "") <> "" Then
                                    '        If drTaskDetails.Read() Then

                                    '            intTaskID = CType(drTaskDetails("TaskID"), Long)
                                    '            m_strToken = CommonFunctions.Security.Token.GetToken(CType(CommonFunction.Data.CheckIsDBNull(m_strReviewstatisticsID, "0"), String) + HttpContext.Current.Session("intUserID").ToString + CType(10, String) + CType(1038, String))
                                    '            Cancel = True
                                    '            Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../PM/PM_TaskAssignment.aspx?MasterTagID=1038&FromWhere=PM&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ReviewActionID=" + m_strReviewstatisticsID + "&TaskID=" + intTaskID.ToString + "&PkToken=" + m_strToken + ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>Task Details</a> </TD>"

                                    '        End If
                                    '    End If
                                    '    CommonFunction.Data.DisposeDataReader(drTaskDetails)
                                    'End If

                                    'Added by MrugajaB on 14th Sept 2006 for whiziblesem SP7 issue ID.6197
                                Else
                                    If Args.DataField.ToUpper = "HYPERLINK2" Then
                                        Dim strActionID As String
                                        Dim drTaskDetails As IDataReader
                                        strActionID = CommonFunctions.General.CheckIsNothing(Args.DataReader(Args.PrimaryKeyName))

                                        strQuery = "Exec usp_Sel_tbl_PM_ReviewActions " + CommonFunction.Data.CheckIsDBNull(Args.DataReader("ReviewActionID"), "0").ToString
                                        drTaskDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                        If drTaskDetails.Read() Then
                                            Dim m_strToken As String
                                            Dim intParentTaskID As Long
                                            Dim intChildTaskID As Long = 0
                                            Dim intReviewee As Long
                                            Dim drChildTaskDetails As IDataReader
                                            Dim intTempEmployeeId As Integer
                                            'Dim drProjectSettings As IDataReader
                                            'Dim blnUseActivities As Boolean = False
                                            'Dim blnApplyEffortDistribution As Boolean = False


                                            Cancel = True
                                            intParentTaskID = CType(CommonFunction.Data.CheckIsDBNull(drTaskDetails("TaskID"), "0"), Long)
                                            If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("IssueAssignedResource"), ""), String) = "" Then
                                                'strQuery = "SELECT HaveSubTaskTypes, ApplyEffortDistribution"
                                                'strQuery &= " FROM tbl_PM_Project WHERE ProjectID = " & HttpContext.Current.Session("intProjectID").ToString()

                                                'drProjectSettings = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                                'If drProjectSettings.Read() Then
                                                '    blnUseActivities = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("HaveSubTaskTypes"), "False"), Boolean)
                                                '    blnApplyEffortDistribution = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ApplyEffortDistribution"), "False"), Boolean)
                                                'End If
                                                'CommonFunctions.Data.DisposeDataReader(drProjectSettings)


                                                'If blnApplyEffortDistribution = False And blnUseActivities = False Then

                                                strQuery = "SELECT ISNULL(EmployeeID,0) AS EmployeeID FROM tbl_PM_ProjectTasks WHERE TaskID=" & intParentTaskID.ToString
                                                drChildTaskDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                                If drChildTaskDetails.Read Then
                                                    intTempEmployeeId = CType(drChildTaskDetails("EmployeeID"), Integer)
                                                End If

                                                CommonFunctions.Data.DisposeDataReader(drChildTaskDetails)

                                                If intTempEmployeeId = 0 Then
                                                    strQuery = "SELECT TaskID FROM tbl_PM_ProjectTasks WHERE ParentTask_UID = " & intParentTaskID.ToString() '& " AND EmployeeID=" & intReviewee.ToString
                                                    drChildTaskDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                                    If drChildTaskDetails.Read() Then
                                                        intChildTaskID = CType(CommonFunction.Data.CheckIsDBNull(drChildTaskDetails("TaskID"), "0"), Long)
                                                    End If
                                                    'End If
                                                Else
                                                    intChildTaskID = intParentTaskID
                                                End If


                                                If intChildTaskID <> 0 Then
                                                    m_strToken = CommonFunctions.Security.Token.GetToken(CType(CommonFunction.Data.CheckIsDBNull(intChildTaskID, "0"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(1038, String))
                                                    Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../PM/PM_TaskAssignment.aspx?MasterTagID=1038&FromWhere=PM&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ReviewActionID=" + strActionID + "&TaskID=" + intParentTaskID.ToString + "&PkToken=" + m_strToken + ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>Task Details</a> </TD>"
                                                Else
                                                    Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../PM/PM_TaskAssignment.aspx?MasterTagID=1038&FromWhere=PM&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ReviewActionID=" + strActionID + "&TaskID=" + ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>Add Task</a> </TD>"
                                                End If

                                                CommonFunction.Data.DisposeDataReader(drTaskDetails)
                                                CommonFunction.Data.DisposeDataReader(drChildTaskDetails)
                                            Else
                                                Args.StringToBeInserted = "<TD Align='Center'>- </TD>"
                                            End If
                                        End If
                                    End If

                                    'End Addition

                                    'Added by SavitaS on 05 Oct 2006
                                    If Args.DataField.ToUpper = "HYPERLINK1" Then
                                        Dim strReviewAction As String
                                        Dim drIssue As IDataReader
                                        Dim strActionID As String
                                        Dim strIssueID As String = "0"
                                        Dim strReviewStatisticsID As String = "0"
                                        Dim m_strToken As String
                                        Dim strReviewee As String
                                        Dim strSQL As String
                                        Dim drUserName As IDataReader
                                        Dim strUserName As String = ""
                                        Dim strCReviewType As String = ""

                                        Cancel = True

                                        strActionID = CommonFunctions.General.CheckIsNothing(Args.DataReader(Args.PrimaryKeyName))
                                        If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskAssignedResource"), ""), String) = "" Then
                                            strReviewAction = "Exec usp_Sel_tbl_PM_ReviewActions " + CommonFunction.Data.CheckIsDBNull(Args.DataReader("ReviewActionID"), "0").ToString
                                            drIssue = CommonFunctions.Data.GetDataReader(strReviewAction, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                            If drIssue.Read() Then
                                                strIssueID = CType(CommonFunction.Data.CheckIsDBNull(drIssue("IssueID"), "0"), String)
                                                strReviewStatisticsID = CType(CommonFunction.Data.CheckIsDBNull(drIssue("ReviewStatisticsID"), "0"), String)
                                                'strReviewee = CType(CommonFunction.Data.CheckIsDBNull(drIssue("Reviewee"), "0"), String)
                                                strCReviewType = CType(CommonFunction.Data.CheckIsDBNull(drIssue("CReviewType"), "0"), String)
                                            End If

                                            strSQL = "Select Reviewee from tbl_PM_ReviewStatistics where ReviewStatisticsID=" & strReviewStatisticsID.ToString

                                            drUserName = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                            If drUserName.Read() Then
                                                strUserName = CType(CommonFunction.Data.CheckIsDBNull(drUserName("Reviewee"), ""), String)
                                            End If

                                            If strIssueID <> "0" Then
                                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(CommonFunction.Data.CheckIsDBNull(strIssueID, "0"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(0, String))
                                                If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("IssueAssignedResource"), ""), String) <> "" Then
                                                    'Modified by PrashantD on 15 March 2007 for IssueID 11420
                                                    'Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objIssue= window.open(""../IB/IB_IssueEntry.aspx?ReviewType=FTR&CReviewType=" + strCReviewType + "&IssueID=" + strIssueID + "&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ReviewActionID=" + strActionID + "&ReviewStatisticsID=" + strReviewStatisticsID + "&OrderBy=IssueID&FromReview=1&PkToken=" + m_strToken + ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("IssueAssignedResource"), ""), String) + "</a> </TD>"
                                                    Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objIssue= window.open(""../IB/IB_IssueEntry.aspx?FromWhere=Review&ReviewType=FTR&CReviewType=" + strCReviewType + "&IssueID=" + strIssueID + "&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ReviewActionID=" + strActionID + "&ReviewStatisticsID=" + strReviewStatisticsID + "&OrderBy=IssueID&FromReview=1&PkToken=" + m_strToken + ""","""",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 800)/2 + "",top="" + (window.screen.height - 600)/2 + "",width=800,height=600"");'>" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("IssueAssignedResource"), ""), String) + "</a> </TD>"
                                                    'End of modification by PrashantD on 15 March 2007 
                                                Else
                                                    'Modified by PrashantD on 15 March 2007 for IssueID 11420
                                                    'Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objIssue= window.open(""../IB/IB_IssueEntry.aspx?ReviewType=FTR&CReviewType=" + strCReviewType + "&IssueID=" + strIssueID + "&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ReviewActionID=" + strActionID + "&ReviewStatisticsID=" + strReviewStatisticsID + "&OrderBy=IssueID&FromReview=1&PkToken=" + m_strToken + ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>" + strUserName.ToString + "</a> </TD>"
                                                    Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objIssue= window.open(""../IB/IB_IssueEntry.aspx?FromWhere=Review&ReviewType=FTR&CReviewType=" + strCReviewType + "&IssueID=" + strIssueID + "&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ReviewActionID=" + strActionID + "&ReviewStatisticsID=" + strReviewStatisticsID + "&OrderBy=IssueID&FromReview=1&PkToken=" + m_strToken + ""","""",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 800)/2 + "",top="" + (window.screen.height - 600)/2 + "",width=800,height=600"");'>" + strUserName.ToString + "</a> </TD>"
                                                    'End of modification by PrashantD on 15 March 2007 
                                                End If
                                            Else
                                                'Modified by PrashantD on 15 March 2007 for IssueID 11420
                                                'Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objIssue= window.open(""../IB/IB_IssueEntry.aspx?ReviewType=FTR&CReviewType=" + strCReviewType + "&IssueID=" + strIssueID + "&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ReviewActionID=" + strActionID + "&ReviewStatisticsID=" + strReviewStatisticsID + "&OrderBy=IssueID&FromReview=1&PkToken=" + m_strToken + ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>Add Issue</a> </TD>"
                                                Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objIssue= window.open(""../IB/IB_IssueEntry.aspx?FromWhere=Review&ReviewType=FTR&CReviewType=" + strCReviewType + "&IssueID=" + strIssueID + "&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ReviewActionID=" + strActionID + "&ReviewStatisticsID=" + strReviewStatisticsID + "&OrderBy=IssueID&FromReview=1&PkToken=" + m_strToken + ""","""",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 800)/2 + "",top="" + (window.screen.height - 600)/2 + "",width=800,height=600"");'>Add Issue</a> </TD>"
                                                'End of modification by PrashantD on 15 March 2007 
                                            End If
                                            CommonFunction.Data.DisposeDataReader(drIssue)
                                        Else
                                            Args.StringToBeInserted = "<TD Align='Center'>- </TD>"
                                        End If
                                    End If
                                    'End of Added by SavitaS on 28 Sept 2006 for SP7 Security issue ID 6197

                                    'End Addition
                                End If
                            End If
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                If m_strReviewStatus.ToUpper = "CLOSED" Then
                                    Cancel = True
                                End If
                            End If


                        Case CommonFunction.Constants.APP_TAG_TAB_TRAINING_RESOURCES
                            Dim strSql As String
                            Dim strIsRoleAccess As String
                            strSql = "usp_GetRoleAccessDetails_ForResourceTab " & CType(HttpContext.Current.Session("intProjectId"), String) & "," & CType(HttpContext.Current.Session("intUserID"), String)
                            strIsRoleAccess = CType(CommonFunctions.Data.GetDataScalar(strSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)

                            If Args.DataField.ToLower = "hyperlink1" And CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskID"), "").ToString.Trim <> "" Then
                                'Modified by MrugajaB on 20th Sept 2006 for Whiziblesem SP7 Issue ID.6197

                                'If a task is assigned then change the link to View Assigned Task
                                '    Args.IgnoreActualValue = True
                                '    'Create object of the ProjectByNet Template Class
                                '    objTemplate = New WebPages.Template.WhizTemplate
                                '    'Initialize the Resources
                                '    objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                '    Args.ReplacementValue = objTemplate.GetResourceString("TRAINING_RESOURCES_VIEW_ASSIGNED_TASK")
                                'objTemplate = Nothing

                                '***************
                                Dim m_strToken As String
                                Dim intParentTaskID As Long
                                Dim intChildTaskID As Long
                                Dim intEmployeeID As Long
                                Dim drChildTaskDetails As IDataReader
                                Dim strQuery As String
                                Dim strTrainingID As String
                                Dim strTrainingResourceID As String
                                Dim strTempEmployeeId As String
                                Dim drProjectSettings As IDataReader
                                Dim blnUseActivities As Boolean = False
                                Dim blnApplyEffortDistribution As Boolean = False

                                Cancel = True
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                'objTemplate = Nothing
                                strTrainingResourceID = CommonFunctions.General.CheckIsNothing(Args.DataReader(Args.PrimaryKeyName))
                                strTrainingID = CommonFunctions.General.CheckIsNothing(Args.DataReader("TrainingID"))

                                intParentTaskID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), Long)
                                intEmployeeID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EmployeeID"), "0"), Long)

                                strQuery = "SELECT TaskID FROM tbl_PM_ProjectTasks WHERE ParentTask_UID = " & intParentTaskID.ToString() & " AND EmployeeID=" & intEmployeeID.ToString
                                drChildTaskDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                If drChildTaskDetails.Read() Then
                                    intChildTaskID = CType(CommonFunction.Data.CheckIsDBNull(drChildTaskDetails("TaskID"), "0"), Long)
                                End If
                                CommonFunctions.Data.DisposeDataReader(drChildTaskDetails)

                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(CommonFunction.Data.CheckIsDBNull(intChildTaskID, "0"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(1038, String))

                                If strIsRoleAccess <> "0" Then
                                    Args.StringToBeInserted = "<TD Align='Left'><A href='javascript: var objChild= window.open(""../PM/PM_TaskAssignment.aspx?MasterTagID=1038&FromWhere=PM&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&TrainingID=" + strTrainingID + "&TrainingResourceID=" + strTrainingResourceID + "&TaskID=" + intChildTaskID.ToString + "&PkToken=" + m_strToken + ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>" + objTemplate.GetResourceString("TRAINING_RESOURCES_VIEW_ASSIGNED_TASK") + "</A>"
                                End If

                                'End Modification by MrugajaB

                                'Added By JayavantK, On 20-Aug-2004
                            ElseIf Args.DataField.ToUpper = "EMPLOYEENAME" And CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskID"), "").ToString.Trim <> "" Then
                                Args.EnableLink = False
                            End If
                            'End Addition

                            '' ***************************************************************************/
                            '' Integrated On 10-Feb-2006 By ParagD for Whiz 2   

                            '' Added By ParagD On 27-Dec-2005
                            '' Purpose : 22067 Nucleus - Role access for parent tag in project module.(Taining plan)
                            If Args.DataField.ToUpper = "HYPERLINK1" Then
                                If strIsRoleAccess = "0" Then
                                    Cancel = True
                                End If
                            End If
                            '' END : Added By ParagD On 27-Dec-2005

                            '' Integrated On 10-Feb-2006 By ParagD for Whiz 2
                            '' ***************************************************************************/


                            'Added by SiddharthS on 20 Feb 2005 for issue id 15846
                            'Purpose:The check box should be disabled if transfer date is less than current date.

                        Case CommonFunction.Constants.APP_TAG_TAB_SITE_HISTORY
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Dim dt As DateTime = Date.Now
                                Dim startdate As DateTime
                                startdate = CType(Args.DataReader("StartDate"), Date)
                                If startdate < dt Then 'CType(CommonFunctions.Dates.GetDate(CType(startdate, Date)), String) <= CType(CommonFunctions.Dates.GetDate(CType(dt, Date)), String) Then
                                    Args.IsCheckBoxDisabled = True
                                End If
                            End If
                            'End addition. 

                        Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEREQUEST_SKILLS_VIEW
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            Args.EnableLink = False
                        Case CommonFunction.Constants.APP_TAG_TAB_RELEASES
                            If Args.ColIndex = 3 Then
                                'Display size of the attachment....
                                'Get Attachment Folder Name from database
                                Dim strSQL As String = "usp_Sel_tbl_PM_ReleaseFiles_DirName " + Args.DataReader("FileID").ToString
                                Args.AttachmentFolderPath = CommonFunctions.FileDirectory.CleanPath(Args.AttachmentFolderPath) + CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                            End If

                            ' Commented By NitinVS on 9 Apr 2007 for WhizibleSEM SP 8 Regression Issue Fixes 
                            ' Duplicate entry in case statement hence commenting 
                            'Case CommonFunction.Constants.APP_TAG_TAB_SUBPROJECT_TASKS, CommonFunction.Constants.APP_TAG_TAB_MODULE_TASKS, CommonFunction.Constants.APP_TAG_TAB_CHANGEREQUEST_TASKS
                            '    If Args.DataField.ToUpper = "TASKNAME" Then
                            '        If Not Args.DataReader("WhichTask").ToString.ToUpper = "O" Then
                            '            Args.EnableLink = False
                            '        End If
                            '    End If
                            ' End Modifiction  By NitinVS on 9 Apr 2007 for WhizibleSEM SP 8 Regression Issue Fixes 

                            'Modified By VidyaJ - DA Performance issue - IssueID - 89 (SP4)
                        Case CommonFunction.Constants.APP_TAG_TAB_PHASE_TASKS, CommonFunction.Constants.APP_TAG_TAB_MODULE_TASKS, CommonFunction.Constants.APP_TAG_TAB_MILESTONE_TASKS, CommonFunction.Constants.APP_TAG_TAB_SUBPROJECT_TASKS, CommonFunction.Constants.APP_TAG_TAB_DELIVERABLE_TASKS, CommonFunction.Constants.APP_TAG_TAB_CHANGEREQUEST_TASKS
                            If Args.DataField.ToUpper = "EMPLOYEENAME" Then

                                'Modified By NitinVS on 15 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11363
                                'Added check for Not help desk task 
                                If Args.DataReader("WhichTask").ToString.ToUpper <> "O" Or CInt(Args.DataReader("ReviewStatisticsID")) <> 0 Or CInt(Args.DataReader("TrainingResourceID")) <> 0 Or CInt(Args.DataReader("MitigationPlanID")) <> 0 Or CInt(Args.DataReader("CRMQueryID")) <> 0 Then
                                    'End Modification  By NitinVS on 15 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11363

                                    Args.EnableLink = False
                                Else
                                    'Added by MrugajaB on 18th Sept 2006 for Whiziblesem Issue ID.6197
                                    'purpose: Added additional parameter 'Token' for TaskName
                                    Dim m_strToken As String
                                    Dim strPK As String
                                    Dim intParentTaskID As Long
                                    Dim intChildTaskID As Long
                                    Dim intEmployeeID As Long
                                    Dim strEmployeeName As String
                                    Dim drChildTaskDetails As IDataReader
                                    Dim drProjectSettings As IDataReader
                                    Dim blnUseActivities As Boolean = False
                                    Dim blnApplyEffortDistribution As Boolean = False
                                    Dim strQuery As String

                                    Cancel = True

                                    strQuery = "SELECT HaveSubTaskTypes, ApplyEffortDistribution"
                                    strQuery &= " FROM tbl_PM_Project WHERE ProjectID = " & HttpContext.Current.Session("intProjectID").ToString()

                                    drProjectSettings = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If drProjectSettings.Read() Then
                                        blnUseActivities = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("HaveSubTaskTypes"), "False"), Boolean)
                                        blnApplyEffortDistribution = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ApplyEffortDistribution"), "False"), Boolean)
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(drProjectSettings)

                                    intParentTaskID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), Long)
                                    strEmployeeName = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EmployeeName"), "0"), String)

                                    'Modified By nitinVs on 18 Apr 2007 for WhizibleSEM SP 8 regression Issue 13029 
                                    'Handled single quote in username 
                                    If blnApplyEffortDistribution = False And blnUseActivities = False Then
                                        strQuery = "SELECT TaskID FROM tbl_PM_ProjectTasks WHERE ParentTask_UID = " & intParentTaskID.ToString() & " AND EmployeeID IN (SELECT EmployeeID FROM tbl_pm_Employee Where UserName ='" & CommonFunction.General.BuildQueryString(strEmployeeName) & "')"
                                        'End Modification By nitinVs on 18 Apr 2007 for WhizibleSEM SP 8 regression Issue 13029 

                                        drChildTaskDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                        If drChildTaskDetails.Read() Then
                                            intChildTaskID = CType(CommonFunction.Data.CheckIsDBNull(drChildTaskDetails("TaskID"), "0"), Long)
                                        End If
                                    Else
                                        intChildTaskID = intParentTaskID
                                    End If

                                    m_strToken = CommonFunctions.Security.Token.GetToken(CType(CommonFunction.Data.CheckIsDBNull(intChildTaskID, "0"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(1038, String))
                                    strPK = CommonFunctions.General.CheckIsNothing(Args.DataReader(Args.PrimaryKeyName))

                                    Args.StringToBeInserted = "<TD align=Left ><A href=Javascript:SubTagEditOnclick" & WhizGlobal.TagID & "('" & strPK & "','" & m_strToken & "')>"
                                    Args.StringToBeInserted = Args.StringToBeInserted & CommonFunctions.General.CheckIsNothing(Args.DataReader("EmployeeName")) & "</A></TD>"
                                    Args.ApplyHTMLEncode = False

                                    CommonFunction.Data.DisposeDataReader(drChildTaskDetails)

                                    'End Addition
                                End If
                                'Added By AmitJ For SHB IssueId 2620 : Access to deliverable has problem.
                                Dim strSql As String
                                Dim strIsRoleAccess As String
                                Dim drRoleAceess As IDataReader
                                strSql = "usp_Sel_tbl_UI_NodeAccess " & CType(WhizGlobal.ParentTagID, Integer) & "," & CType(WhizGlobal.RoleID, Integer)
                                drRoleAceess = CommonFunctions.Data.GetDataReader(strSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drRoleAceess.Read Then
                                    If (CType(CommonFunctions.Data.CheckIsDBNull(drRoleAceess(0), "0"), Integer) = 0 And CType(CommonFunctions.Data.CheckIsDBNull(drRoleAceess(1), "0"), Integer) = 0 And CType(CommonFunctions.Data.CheckIsDBNull(drRoleAceess(2), "0"), Integer) = 0 And CType(CommonFunctions.Data.CheckIsDBNull(drRoleAceess(3), "0"), Integer) <> 0) Then
                                        Args.EnableLink = False
                                    End If
                                End If
                                'End of Additon By AmitJ
                            End If

                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End Of Modifications - IssueID - 89



                        Case CommonFunction.Constants.APP_TAG_TAB_CAPTIONS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            '' Commented By ParagD On 10-Nov-2005
                            '' Empower - IssueID 20249 - Delete button does not exists on Employee Leave Details

                            'Case CommonFunction.Constants.APP_TAG_TAB_EMPLOYEE_LEAVE_DETAILS
                            '    If Args.ColumnName.ToUpper = "DELETE" Then
                            '        Cancel = True
                            '    End If

                            '' End of comments By ParagD On 10-Nov-2005   

                            'Addition done by SuchitraP on 16-MAY-2007 for Cleanup Activity
                        Case CommonFunction.Constants.APP_TAG_TAB_LEAVES
                            'Dim myQuery As String = ""
                            'Dim blnIsProRataEnabled As Boolean = False
                            'myQuery = "SELECT ISNULL(IsProRataEnabled,0) FROM tbl_PM_CompanyInformation"
                            'blnIsProRataEnabled = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(myQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Boolean)
                            'If blnIsProRataEnabled = False Then
                            If CommonFunction.Application.IsProRataEnabled = False Then
                                If Args.ColumnName = "Pro-Rata" Then
                                    Cancel = True
                                End If
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_EMPLOYEE_LEAVE_DETAILS
                            'Dim myQuery As String = ""
                            'Dim blnIsProRataEnabled As Boolean = False
                            'myQuery = "SELECT ISNULL(IsProRataEnabled,0) FROM tbl_PM_CompanyInformation"
                            'blnIsProRataEnabled = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(myQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Boolean)
                            'If blnIsProRataEnabled = False Then
                            If CommonFunction.Application.IsProRataEnabled = False Then
                                If Args.ColumnName = "Pro-Rata" Then
                                    Cancel = True
                                End If
                            End If
                            'End of addition done by SuchitraP for Cleanup Activity

                        Case CommonFunction.Constants.APP_TAG_TAB_ATTRIBUTE_ACCESS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                If CType(Args.DataReader.Item("IsMandatory"), Boolean) = True Then
                                    Args.IsCheckBoxDisabled = True
                                End If
                            End If
                        Case CommonFunction.Constants.APP_TAG_TAB_RATECONTRACTBYROLE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'Case CommonFunction.Constants.APP_TAG_TAB_CONFIGURE_RFI_ITEM_ATTRIBUTES
                            '    If Args.ColumnName.ToUpper = "DELETE" Then
                            '        Cancel = True
                            '    End If
                            'Added By NileshD on 29 July 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_TAX_DETAILS
                            Dim strRFITypeTaxID As String
                            'This will disable the all the checkboxes except for last tax entry
                            If HttpContext.Current.Session("RFITAXID") Is Nothing Then
                                strRFITypeTaxID = Args.DataReader("RFITypeID").ToString
                                strRFITypeTaxID = CommonFunction.Data.GetDataScalar("SELECT MAX(RFITypeTaxID) FROM tbl_PM_RFITypes_TaxDetails WHERE RFITypeID = " + strRFITypeTaxID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                                HttpContext.Current.Session("RFITAXID") = strRFITypeTaxID
                            Else
                                If HttpContext.Current.Session("RFITAXID").ToString <> Args.DataReader("RFITypeTaxID").ToString Then
                                    Args.IsCheckBoxDisabled = True
                                Else
                                    HttpContext.Current.Session("RFITAXID") = Nothing
                                End If
                            End If
                            'End of Addition
                            'Added By JayavantK on 30/07/04
                        Case CommonFunction.Constants.APP_TAG_TAB_OUPOOLMASTER_RESOURCE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_OUPOOL_RESOURCE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            'End Of addition

                            ' Added By JayavantK on 18-Jun-2004 - Start
                            'Modified by TruptiK on 19-Jan-2008
                        Case CommonFunction.Constants.APP_TAG_TAB_ASSIGNEDRESOURCES, CommonFunction.Constants.APP_TAG_TAB_EXTENDASSIGNEDRESOURCES
                            'End of modification by TruptiK
                            Dim strResourceStatus As String = ""
                            Dim strQuery As String = ""
                            Dim strLink As String = ""
                            Dim lngAssignmentID As Long = 0

                            objTemplate = New WebPage.Templates.WhizTemplate
                            objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                            If Args.DataField.ToUpper = "STATUS" Then
                                Args.IgnoreActualValue = True
                                strResourceStatus = CommonFunctions.General.CheckIsNothing(Args.DataReader.Item("Status"), "")
                                strResourceStatus = strResourceStatus.Trim().ToUpper()
                                If strResourceStatus = "A" Then     'Allocated by Resource Allocator
                                    Args.ReplacementValue = objTemplate.GetResourceString("ALLOCATED")
                                ElseIf strResourceStatus = "R" Then     'Rejected By PM
                                    lngAssignmentID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("AssignmentID"), "0"), Long)
                                    strLink = "<A Href='javascript: var objChild=window.open(""../HR/HR_AddComments.aspx?From=PM&Mode=REJECT_RESOURCE_VIEW&AssignmentID=" & lngAssignmentID.ToString() & """,""_blank"",""resizable=yes,scrollbars=no,Left=100,Top=100,height=250,width=550"")'>"
                                    Args.ReplacementValue = strLink & objTemplate.GetResourceString("REJECTED") & "</A>"
                                ElseIf strResourceStatus = "L" Then     'Assigned To Project
                                    Args.ReplacementValue = objTemplate.GetResourceString("ASSIGNED_TO_PROJECT")
                                ElseIf strResourceStatus = "REVERT" Then     'Reverted as not assigned within configured days
                                    Args.ReplacementValue = objTemplate.GetResourceString("REVERTED")
                                End If
                            ElseIf Args.ColumnName.ToUpper = "DELETE" Then
                                strResourceStatus = CommonFunctions.General.CheckIsNothing(Args.DataReader.Item("Status"), "")
                                strResourceStatus = strResourceStatus.Trim().ToUpper()
                                If strResourceStatus <> "A" Then
                                    Args.IsCheckBoxDisabled = True
                                End If
                            End If
                            objTemplate = Nothing
                            'Integration by SanaS on 25-Sep-2009 for Resource Allocation Workflow Changes
                            'Added By GaneshG On 22-Aug-09 
                            'Purpose : To allow resouce assignment for future date allocation only after reallocation date arrives
                            If Args.DataField.ToUpper = "FROMDATE" Then

                                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                'Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawTextBox("txthidFromDate_" + Args.DataReader.Item("EmployeeID").ToString, "txthidFromDate_" + Args.DataReader.Item("EmployeeID").ToString, , , , CommonFunction.Dates.GetDate(CType(Args.DataReader.Item("FromDate").ToString, Date)), IsHidden:=True, returnHTML:=True)
                                'Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawTextBox("txthidCurrentDate_" + Args.DataReader.Item("EmployeeID").ToString, "txthidCurrentDate_" + Args.DataReader.Item("EmployeeID").ToString, , , , CommonFunction.Dates.GetDate(Now.Today), IsHidden:=True, returnHTML:=True)
                                Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawTextBox("txthidFromDate_" + Args.DataReader.Item("EmployeeID").ToString, "txthidFromDate_" + Args.DataReader.Item("EmployeeID").ToString, , , , CommonFunction.Dates.GetDate(CType(Args.DataReader.Item("FromDate").ToString, Date)), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
                                Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawTextBox("txthidCurrentDate_" + Args.DataReader.Item("EmployeeID").ToString, "txthidCurrentDate_" + Args.DataReader.Item("EmployeeID").ToString, , , , CommonFunction.Dates.GetDate(Now.Today), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)

                            End If
                            'End Addition By GaneshG
                            'End Integration by SanaS on 25-Sep-2009 for Resource Allocation Workflow Changes

                        Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEPOOL_RESOURCES
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_TEAMPOOL_RESOURCES
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEPOOL_TEAM
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            'Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEPOOL_MANAGER
                            '        If Args.ColumnName.ToUpper = "DELETE" Then
                            '            Cancel = True
                            '        End If

                        Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEPOOL_RESOURCE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If

                            ' Added By JayavantK on 18-Jun-2004 - End

                            ' Added By JayavantK on 31-Jul-2004 - Start
                        Case CommonFunction.Constants.APP_TAG_TAB_BUSINESSGROUP_RESOURCES
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            ' Added By JayavantK on 31-Jul-2004 - End
                            ' Added By JayavantK on 4-Aug-2004 - Start
                        Case CommonFunction.Constants.APP_TAG_TAB_BGPOOL_RESOURCE
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            ' Added By JayavantK on 31-Jul-2004 - End
                            'Added By NileshD on 12 August 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_CONTRACT_VIEW_ATTACHMENT
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'end Of Addition
                            'Added By JayavantK, On 20-Aug-2004
                        Case CommonFunction.Constants.APP_TAG_TAB_RISKS_MITIGATION_PLANS
                            If Args.DataField.ToUpper = "ACTION" And CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), Long) > 0 Then
                                Args.EnableLink = False
                            End If

                            If Args.DataField.ToUpper = "HYPERLINK1" And CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), Long) > 0 Then
                                Dim m_strToken As String
                                Dim intParentTaskID As Long
                                Dim intChildTaskID As Long = 0
                                Dim intEmployeeID As Long
                                Dim drChildTaskDetails As IDataReader
                                Dim strQuery As String
                                Dim strRiskID As String
                                Dim strMitigationPlanID As String
                                Dim strTempEmployeeId As String
                                Dim drProjectSettings As IDataReader
                                Dim blnUseActivities As Boolean = False
                                Dim blnApplyEffortDistribution As Boolean = False

                                Cancel = True

                                strMitigationPlanID = CommonFunctions.General.CheckIsNothing(Args.DataReader(Args.PrimaryKeyName))
                                strRiskID = CommonFunctions.General.CheckIsNothing(Args.DataReader("RiskID"))

                                intParentTaskID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskID"), "0"), Long)
                                'intEmployeeID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EmployeeID"), "0"), Long)

                                strQuery = "SELECT TaskID FROM tbl_PM_ProjectTasks WHERE ParentTask_UID = " & intParentTaskID.ToString() '& " AND EmployeeID=" & intEmployeeID.ToString
                                drChildTaskDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                If drChildTaskDetails.Read() Then
                                    intChildTaskID = CType(CommonFunction.Data.CheckIsDBNull(drChildTaskDetails("TaskID"), "0"), Long)
                                End If
                                CommonFunctions.Data.DisposeDataReader(drChildTaskDetails)

                                m_strToken = CommonFunctions.Security.Token.GetToken(CType(CommonFunction.Data.CheckIsDBNull(intChildTaskID, "0"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(1038, String))

                                'Modified By NitinVS on 25 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 
                                Args.StringToBeInserted = "<TD Align='Left'><A href='javascript: var objChild= window.open(""../PM/PM_TaskAssignment.aspx?PageType=Risk&Mode=Edit&MasterTagID=1038&FromWhere=PM&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&RiskID=" + strRiskID + "&MitigationPlanID=" + strMitigationPlanID + "&TaskID=" + intChildTaskID.ToString + "&PkToken=" + m_strToken + ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>" + "Task Details" + "</A>"
                                'End Modification By NitinVS on 25 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 

                                'End Modification by MrugajaB
                            End If
                            'End Addition

                            'added by SachinR   on 21 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_DELIVERABLES_TASKS
                            If Args.ColumnName.ToUpper = "TASKID" Then
                                Cancel = True
                            ElseIf Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'addition end

                            'added by SachinR   on 23 Aug 2004
                            'issue 12528
                        Case CommonFunction.Constants.APP_TAG_TAB_SOFTEX_FORM
                            If Args.DataField.ToUpper = "INVOICEID" Then
                                Args.EnableLink = False
                            ElseIf Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'addition end
                            'Added by ShamkantD on 25th Aug 2004
                        Case CommonFunction.Constants.APP_SUB_TAG_CHECKLIST_ITEMS
                            If Args.DataField.ToUpper = "ANSWERDESCRIPTION" Then
                                Args.EnableLink = False
                            End If
                            'End Of addition - ShamkantD on 25th Aug 2004

                            'added by SachinR   on 26 Aug 2004
                            'Added by TruptiK ON 26-Aug-2008
                        Case CommonFunction.Constants.APP_SUB_TAG_AlertLevel
                            Dim dr As IDataReader
                            Dim strSQL As String
                            Dim strDrawTable As String

                            ' replace the TD with TD having palette color sequence 
                            If UCase(Trim(Args.DataField & "")) = "COLOR" Then
                                Cancel = True
                                Args.EnableLink = False
                                strSQL = "usp_sel_AlertLevel " + CommonFunctions.Data.CheckIsDBNull((Args.DataReader("AlertID")), "0").ToString
                                dr = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                strDrawTable = "<TD><table cellpadding=""1"" cellspacing=""1"" bordercolor=""BLACK"" bgColor=""black"" ><tr>"
                                Do While dr.Read()
                                    strDrawTable += "<td bgcolor=" & dr.Item("Color").ToString & " width=40 height=12 align=centre ></td>"
                                Loop
                                CommonFunctions.Data.DisposeDataReader(dr)
                                strDrawTable += "</tr></table></TD>"

                                Args.StringToBeInserted = strDrawTable
                            End If


                            'End of addition by TruptiK
                        Case CommonFunction.Constants.APP_TAG_TAB_ASSOCIATED_PHASE_TASK
                            '--- Code added by Nilesh on 19 May
                            '--- Check and enable/disable delete link accordingly.
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Dim strCopyTemplateID As String
                                Dim drTemplate As IDataReader
                                Dim strSQLtemp As String
                                Dim blnIsCopyTemplate As Boolean = False

                                strCopyTemplateID = CommonFunction.Data.CheckIsDBNull(Args.DataReader("TemplateID"), "").ToString + ""

                                strSQLtemp = "Select IsCopyTemplate from tbl_PM_Project_PhaseTask_Template "
                                strSQLtemp = strSQLtemp & " Where ProjectPhaseTaskTemplateID = " & strCopyTemplateID

                                drTemplate = CommonFunctions.Data.GetDataReader(strSQLtemp, True)
                                If drTemplate.Read Then
                                    blnIsCopyTemplate = CType(CommonFunctions.Data.CheckIsDBNull(drTemplate.Item("IsCopyTemplate"), "0"), Boolean)
                                End If

                                If blnIsCopyTemplate = False Then
                                    Cancel = True
                                End If
                            End If
                            'addition end

                            'added by SachinR   on 1 Sep 2004

                            'PBNITE SP2
                            ' Added By NitinVS on 9 Feb 2005 
                            ' To hide the distriution link 
                            If Args.ColumnName.ToUpper = "DISTRIBUTION" Then

                                Dim blnHaveSubTaskTypes As Boolean
                                Dim strSQL As String

                                strSQL = "SELECT HaveSubTaskTypes FROM tbl_PM_Project WHERE ProjectID = " + HttpContext.Current.Session("intProjectId").ToString

                                blnHaveSubTaskTypes = CType(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Boolean)

                                If blnHaveSubTaskTypes = False Then
                                    Cancel = True
                                End If
                            End If
                            'PBNITE SP2
                            ' End Addition By nitinVS on 9 Feb 2005 


                        Case CommonFunction.Constants.APP_TAG_TAB_PHASETASK_ACTIVITY
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'addition end

                            'added by SachinR   on 03 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_DELIVERABLE_FIELDS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'addition end

                            'Added BY JayavantK, On 7-Sep-2004
                        Case CommonFunction.Constants.APP_TAG_TAB_OUPOOL_DELIVERYUNIT
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_TAB_BUSINESSGROUP_OUPOOLS
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End Addition
                            'added by SachinR   on 10 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_PHASETASK_REVISION, CommonFunction.Constants.APP_TAG_TAB_PHASETASK_TEMPLATE_REVISION
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_TAB_PUBLISH_PHASETASK_DOCUMENTS
                            If Args.ColumnName.ToUpper = "FILENAME" Then
                                Cancel = True
                            End If
                            'addition end

                            'Added by ShamkantD on 5 Oct 2004
                        Case CommonFunction.Constants.APP_SUB_TAG_MIDDLE_LEVEL_RESOURCES_FOR_BUSINESS_GROUP
                            'Added for Middle Level Resources in Business Group
                            If Args.DataField.ToUpper = "EMPLOYEENAME" Then
                                Args.EnableLink = False
                            End If
                            'End of addition - ShamkantD on 5 Oct 2004

                            'Added by ShamkantD on 6 Oct 2004
                        Case CommonFunction.Constants.APP_SUB_TAG_MIDDLE_LEVEL_RESOURCES_FOR_ORGANIZATION_UNIT
                            'Added for Middle Level Resources in organization unit
                            If Args.DataField.ToUpper = "EMPLOYEENAME" Then
                                Args.EnableLink = False
                            End If

                        Case CommonFunction.Constants.APP_SUB_TAG_MIDDLE_LEVEL_RESOURCES_FOR_DELIVERY_UNIT
                            'Added for Middle Level Resources in Delivery unit
                            If Args.DataField.ToUpper = "EMPLOYEENAME" Then
                                Args.EnableLink = False
                            End If

                        Case CommonFunction.Constants.APP_SUB_TAG_MIDDLE_LEVEL_RESOURCES_FOR_DELIVERY_TEAM
                            'Added for Middle Level Resources in Delivery Team
                            If Args.DataField.ToUpper = "EMPLOYEENAME" Then
                                Args.EnableLink = False
                            End If
                            'End of addition - ShamkantD on 6 Oct 2004

                            '##### Onsite Offshore functionality
                        Case CommonFunction.Constants.APP_TAG_TAB_SITESROLERATE
                            'Code Added By VidyaJ on Aug 12th 2004
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End addition    
                            'Added By VidyaJ on 10th Feb 2005 - For IssueID - 15374
                        Case CommonFunction.Constants.APP_TAG_TAB_FASTTRACKREVIEW_ISSUES
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                Cancel = True
                            End If
                            'End of Addition

                            ' Added By NitinVS on 8 March 2005 
                            ' To Display the contents of the file when clicked on the file name 
                            ' TO Hide the Review and History Link for URL's

                        Case CommonFunction.Constants.APP_TAG_TAB_REVIEW_DOCUMENTS

                            If Args.DataField.ToUpper = "FILENAME" Then
                                Dim DocumentID As String

                                DocumentID = Args.DataReader("DocumentID").ToString
                                Args.IgnoreActualValue = True


                                If CType(Args.DataReader("IsURL"), Boolean) = True Then
                                    Args.ReplacementValue = "<A href = '" + Args.DataReader("FileName").ToString + "' target=_new > " + Args.DataReader("FileName").ToString + " </A>"
                                Else

                                    Args.ReplacementValue = "<A href='javascript: var objChild= window.open(""../PM/PM_ViewDocument.aspx?MasterTagID=1026&FromWhere=PM&DocumentID=" + DocumentID + ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=300"");'>" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("FileName").ToString, ""), "") + "</A>"
                                End If

                            End If

                            If Args.ColumnName.ToUpper = "REVIEW" Or Args.ColumnName.ToUpper = "HISTORY" Then
                                If CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("IsURL"), "0"), "0"), Boolean) = True Then
                                    Args.IgnoreActualValue = True
                                End If
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_MILESTONE_DOCUMENTS

                            If Args.DataField.ToUpper = "FILENAME" Then
                                Dim DocumentID As String

                                DocumentID = Args.DataReader("DocumentID").ToString
                                Args.IgnoreActualValue = True

                                If CType(Args.DataReader("IsURL"), Boolean) = True Then
                                    Args.ReplacementValue = "<A href = '" + Args.DataReader("FileName").ToString + "' target=_new > " + Args.DataReader("FileName").ToString + " </A>"
                                Else
                                    Args.ReplacementValue = "<A href='javascript: var objChild= window.open(""../PM/PM_ViewDocument.aspx?MasterTagID=34&FromWhere=PM&DocumentID=" + DocumentID + ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=300"");'>" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("FileName").ToString, ""), "") + "</A>"
                                End If
                            End If

                            If Args.ColumnName.ToUpper = "REVIEW" Or Args.ColumnName.ToUpper = "HISTORY" Then
                                If CType(Args.DataReader("IsURL"), Boolean) = True Then
                                    Args.IgnoreActualValue = True
                                End If
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_CHANGE_REQUEST_DOCUMENTS

                            If Args.DataField.ToUpper = "FILENAME" Then
                                Dim DocumentID As String

                                DocumentID = Args.DataReader("DocumentID").ToString
                                Args.IgnoreActualValue = True
                                If CType(Args.DataReader("IsURL"), Boolean) = True Then
                                    Args.ReplacementValue = "<A href = '" + Args.DataReader("FileName").ToString + "' target=_new > " + Args.DataReader("FileName").ToString + " </A>"
                                Else
                                    Args.ReplacementValue = "<A href='javascript: var objChild= window.open(""../PM/PM_ViewDocument.aspx?MasterTagID=1039&FromWhere=PM&DocumentID=" + DocumentID + ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=300"");'>" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("FileName").ToString, ""), "") + "</A>"
                                End If

                            End If

                            If Args.ColumnName.ToUpper = "REVIEW" Or Args.ColumnName.ToUpper = "HISTORY" Then
                                If CType(Args.DataReader("IsURL"), Boolean) = True Then
                                    Args.IgnoreActualValue = True
                                End If
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_PHASE_DOCUMENTS

                            If Args.DataField.ToUpper = "FILENAME" Then
                                Dim DocumentID As String

                                DocumentID = Args.DataReader("DocumentID").ToString
                                Args.IgnoreActualValue = True
                                If CType(Args.DataReader("IsURL"), Boolean) = True Then
                                    Args.ReplacementValue = "<A href = '" + Args.DataReader("FileName").ToString + "' target=_new > " + Args.DataReader("FileName").ToString + " </A>"
                                Else
                                    Args.ReplacementValue = "<A href='javascript: var objChild= window.open(""../PM/PM_ViewDocument.aspx?MasterTagID=516&FromWhere=PM&DocumentID=" + DocumentID + ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=300"");'>" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("FileName").ToString, ""), "") + "</A>"
                                End If

                            End If

                            If Args.ColumnName.ToUpper = "REVIEW" Or Args.ColumnName.ToUpper = "HISTORY" Then
                                If CType(Args.DataReader("IsURL"), Boolean) = True Then
                                    Args.IgnoreActualValue = True
                                End If
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_FAST_TRACK_REVIEW_DOCUMENTS

                            If Args.DataField.ToUpper = "FILENAME" Then
                                Dim DocumentID As String

                                DocumentID = Args.DataReader("DocumentID").ToString
                                Args.IgnoreActualValue = True
                                If CType(Args.DataReader("IsURL"), Boolean) = True Then
                                    Args.ReplacementValue = "<A href = '" + Args.DataReader("FileName").ToString + "' target=_new > " + Args.DataReader("FileName").ToString + " </A>"
                                Else
                                    Args.ReplacementValue = "<A href='javascript: var objChild= window.open(""../PM/PM_ViewDocument.aspx?MasterTagID=2191&FromWhere=PM&DocumentID=" + DocumentID + ""","""",""left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=300"");'>" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("FileName").ToString, ""), "") + "</A>"
                                End If

                            End If

                            If Args.ColumnName.ToUpper = "REVIEW" Or Args.ColumnName.ToUpper = "HISTORY" Then
                                If CType(Args.DataReader("IsURL"), Boolean) = True Then
                                    Args.IgnoreActualValue = True
                                End If
                            End If

                            'End Addition By NitinVS on 8 March 2005 




                            'Dim strQuery As String = ""
                            'Dim drReviewDetails As IDataReader
                            'Dim m_strReviewstatisticsID As String
                            'Dim m_strReviewStatus As String = ""
                            'm_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ReviewStatisticsID_PK")
                            'If m_strReviewstatisticsID = "" Then
                            '    m_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ForeignKeyValue")
                            'End If
                            'If m_strReviewstatisticsID = "" Then
                            '    m_strReviewstatisticsID = HttpContext.Current.Request("ReviewStatisticsID_PK")
                            'End If

                            'If m_strReviewstatisticsID <> "" Then
                            '    strQuery = "Select ReviewStatus from tbl_pm_reviewstatistics Where ReviewStatisticsID= " + m_strReviewstatisticsID
                            '    drReviewDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '    If CommonFunctions.General.CheckIsNothing(drReviewDetails, "") <> "" Then
                            '        If drReviewDetails.Read() Then
                            '            m_strReviewStatus = CType(CommonFunctions.Data.CheckIsDBNull(drReviewDetails("ReviewStatus"), ""), String)
                            '        End If
                            '    End If
                            '    CommonFunctions.Data.DisposeDataReader(drReviewDetails)
                            'End If

                            'If Args.DataField.ToUpper = "HYPERLINK1" Or Args.DataField.ToUpper = "HYPERLINK2" Then
                            '    If m_strReviewStatus.ToUpper = "CLOSED" Then
                            '        Cancel = True
                            '    End If
                            'End If
                            'If Args.ColumnName.ToUpper = "DELETE" Then
                            '    If m_strReviewStatus.ToUpper = "CLOSED" Then
                            '        Cancel = True
                            '    End If
                            'End If
                        Case CommonFunction.Constants.APP_TAG_TAB_PROJECT_MAPPING
                            If Args.ColumnName.ToUpper = "ALLOWDELETE" Then
                                Cancel = True
                                Args.StringToBeInserted = "<input type=hidden name=allowDelete id=allowDelete value='" + Args.DataReader("AllowDelete").ToString + "' />"
                                Args.StringToBeInserted += "<input type=hidden name=Project id=Project value='" + Args.DataReader("ProjectName").ToString + "' />"
                            End If


                            'integration by harshada d on 15th june 2006
                            '---Added by harshk on 20/07/2005
                            '---If checklist is inherited then disable delete
                        Case CommonFunction.Constants.APP_TAG_TAB_PROJECT_CHECKLISTITEM
                            Dim drIsInherited As IDataReader
                            Dim strSQLQuery As String
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                strSQLQuery = "EXEC usp_Sel_tbl_PM_WorkOrderChecklist_IsInherited " & CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectCheckListID"), "0"), String)
                                drIsInherited = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
                                If drIsInherited.Read Then
                                    Cancel = True
                                End If
                                CommonFunctions.Data.DisposeDataReader(drIsInherited)
                            End If
                            '---End Added by harshk on 20/07/2005
                            '---Added by harshk on 22/07/2005
                            '---If checklist is inherited then disable delete
                        Case CommonFunction.Constants.APP_TAG_TAB_PROJECT_CHECKLIST_SECTIONS
                            Dim drIsInherited As IDataReader
                            Dim strSQLQuery As String
                            If Args.ColumnName.ToUpper = "DELETE" Then
                                strSQLQuery = "EXEC usp_Sel_tbl_PM_WorkOrderChecklist_IsInherited " & CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectCheckListID"), "0"), String)
                                drIsInherited = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
                                If drIsInherited.Read Then
                                    Cancel = True
                                End If
                                CommonFunctions.Data.DisposeDataReader(drIsInherited)
                            End If
                            '---End Added by harshk on 22/07/2005
                            'end of integration by harshada d on 15th june 2006


                    End Select
                End If
            End Sub

            Public Shared Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID
                        'Added By NileshD on 2 August on 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_SALES_PERSON
                            Dim strScript As String
                            strScript = "<Script language=javascript >"
                            strScript += "if (opener.frmRFI_RFI.txtRFISalesPersonIDs.value != null)"
                            strScript += "{ var objChk;"
                            strScript += "objChk = GetObjectReference('frmCommonList','chkDelete',true);"
                            strScript += "var intCnt;"
                            strScript += "intLen = objChk.length;"
                            strScript += "if(intLen > 0)"
                            strScript += "{ for(intCnt=0;intCnt<intLen;intCnt++)"
                            strScript += " { if(opener.frmRFI_RFI.txtRFISalesPersonIDs.value.indexOf(objChk[intCnt].value) > -1)"
                            strScript += " objChk[intCnt].checked=true } } }"
                            strScript += "</Script>"
                            Args.ToBeInserted = strScript
                        Case CommonFunction.Constants.APP_TAG_RFI_OS
                            Dim strScript As String
                            strScript = "<Script language=javascript >"
                            strScript += "if (opener.frmRFI_RFI.txtRFIOSIDs.value != null)"
                            strScript += "{ var objChk;"
                            strScript += "objChk = GetObjectReference('frmCommonList','chkDelete',true);"
                            strScript += "var intCnt;"
                            strScript += "intLen = objChk.length;"
                            strScript += "if(intLen > 0)"
                            strScript += "{ for(intCnt=0;intCnt<intLen;intCnt++)"
                            strScript += " { if(opener.frmRFI_RFI.txtRFIOSIDs.value.indexOf(objChk[intCnt].value) > -1)"
                            strScript += " objChk[intCnt].checked=true } } }"
                            strScript += "</Script>"
                            Args.ToBeInserted = strScript
                        Case CommonFunction.Constants.APP_TAG_RFI_TOOL
                            Dim strScript As String
                            strScript = "<Script language=javascript >"
                            strScript += "if (opener.frmRFI_RFI.txtRFIToolIDs.value != null)"
                            strScript += "{ var objChk;"
                            strScript += "objChk = GetObjectReference('frmCommonList','chkDelete',true);"
                            strScript += "var intCnt;"
                            strScript += "intLen = objChk.length;"
                            strScript += "if(intLen > 0)"
                            strScript += "{ for(intCnt=0;intCnt<intLen;intCnt++)"
                            strScript += " { if(opener.frmRFI_RFI.txtRFIToolIDs.value.indexOf(objChk[intCnt].value) > -1)"
                            strScript += " objChk[intCnt].checked=true } } }"
                            strScript += "</Script>"
                            Args.ToBeInserted = strScript
                            'End Of Addition

                            'Added by ShamkantD on 9th August 2004
                        Case CommonFunction.Constants.APP_TAG_PM_SERVICE_SEGMENTATION, CommonFunction.Constants.APP_TAG_PM_MARKET_SEGMENTATION
                            Dim strScript As String
                            'Modified by NiranjanK on Date June 07,2006 for WhizibleSEM Issue ID.4168
                            strScript = "<SCRIPT LANGUAGE=javascript>" & vbCrLf
                            strScript += "<!--" & vbCrLf
                            strScript += "function chkDomain_OnClick(intDomainID)" & vbCrLf
                            strScript += "{" & vbCrLf
                            strScript += "	var intCount;" & vbCrLf
                            strScript += "  var objForm = GetFormReference('frmCommonList');" & vbCrLf
                            strScript += "	var intMarketCount;" & vbCrLf
                            strScript += "	var objchkDomain;" & vbCrLf
                            strScript += "	var strMarketValue;" & vbCrLf
                            strScript += "	for(intCount=0;intCount<=objForm.elements.length - 1;intCount++)" & vbCrLf
                            strScript += "	{" & vbCrLf
                            strScript += "		if(isFinite(objForm.elements[intCount].value) && objForm.elements[intCount].type==""checkbox"")" & vbCrLf
                            strScript += "		{" & vbCrLf
                            strScript += "			if(eval(objForm.elements[intCount].value)==intDomainID)" & vbCrLf
                            strScript += "			{" & vbCrLf
                            strScript += "				if(objForm.elements[intCount].checked==false)" & vbCrLf
                            strScript += "				{		" & vbCrLf
                            strScript += "					for(intMarketCount=0;intMarketCount<=objForm.elements.length - 1;intMarketCount++)" & vbCrLf
                            strScript += "					{" & vbCrLf
                            strScript += "						strMarketValue = objForm.elements[intMarketCount].value;" & vbCrLf
                            strScript += "						if((strMarketValue.indexOf(intDomainID + "":"") != -1) && objForm.elements[intMarketCount].checked==true)" & vbCrLf
                            strScript += "							objForm.elements[intMarketCount].checked=false;		" & vbCrLf
                            strScript += "					}" & vbCrLf
                            strScript += "				}" & vbCrLf
                            strScript += "			}" & vbCrLf
                            strScript += "		}" & vbCrLf
                            strScript += "	}" & vbCrLf
                            strScript += "}" & vbCrLf
                            strScript += "function chkMarket_OnClick(intDomainID, intMarketID)	" & vbCrLf
                            strScript += "{" & vbCrLf
                            strScript += "  var objForm = GetFormReference('frmCommonList');" & vbCrLf
                            strScript += "	var blnChecked;" & vbCrLf
                            strScript += "	var strMarket;" & vbCrLf
                            strScript += "	var objoptSubMarket;" & vbCrLf
                            strScript += "	var intSubCount;" & vbCrLf
                            strScript += "	var K;" & vbCrLf
                            strScript += "	var strMarketValue;" & vbCrLf
                            strScript += "	//Code to check whether a market value is true or not" & vbCrLf
                            strScript += "	strMarket=intDomainID + "":"" + intMarketID;" & vbCrLf
                            strScript += "	for(intCount=1;intCount<=objForm.elements.length - 1;intCount++)" & vbCrLf
                            strScript += "	{" & vbCrLf
                            strScript += "		if(objForm.elements[intCount].value==strMarket)" & vbCrLf
                            strScript += "		{" & vbCrLf



                            strScript += "			if(objForm.elements[intCount].checked==true)" & vbCrLf
                            strScript += "				blnChecked=true;" & vbCrLf
                            strScript += "			else" & vbCrLf
                            strScript += "			{" & vbCrLf
                            strScript += "				intSubCount=0;" & vbCrLf
                            strScript += "				for(K = 0;K<=objForm.elements.length-1;K++)" & vbCrLf
                            strScript += "				{" & vbCrLf
                            strScript += "					if(objForm.elements[K].name==""chkSubMarket"")" & vbCrLf
                            strScript += "						intSubCount++;" & vbCrLf
                            strScript += "				}" & vbCrLf
                            strScript += "				objoptSubMarket = objForm.elements[""chkSubMarket""];" & vbCrLf

                            strScript += "				if(typeof(objoptSubMarket)=='object')" & vbCrLf
                            strScript += "				{		" & vbCrLf
                            strScript += "					if(intSubCount==1)" & vbCrLf
                            strScript += "					{" & vbCrLf
                            strScript += "						strMarketValue = objoptSubMarket.value;" & vbCrLf

                            strScript += "						if(strMarketValue.indexOf(strMarket + "":"") != -1)" & vbCrLf
                            strScript += "							objoptSubMarket.checked=false;" & vbCrLf
                            strScript += "					}" & vbCrLf
                            strScript += "					else" & vbCrLf
                            strScript += "					{" & vbCrLf
                            strScript += "						for(K = 0; K<=objoptSubMarket.length - 1;K++)" & vbCrLf
                            strScript += "						{" & vbCrLf

                            strScript += "							strMarketValue = objoptSubMarket[K].value;" & vbCrLf
                            strScript += "							if(strMarketValue.indexOf(strMarket + "":"") != -1)" & vbCrLf
                            strScript += "								objoptSubMarket[K].checked=false;" & vbCrLf
                            strScript += "						}" & vbCrLf
                            strScript += "					}" & vbCrLf
                            strScript += "				}" & vbCrLf
                            strScript += "				break;" & vbCrLf
                            strScript += "			}" & vbCrLf
                            strScript += "		}" & vbCrLf
                            strScript += "	}" & vbCrLf
                            strScript += "	//If Market vlue is true then corrsponding external market values are to be cheked" & vbCrLf
                            strScript += "	if(blnChecked=true)" & vbCrLf
                            strScript += "	{" & vbCrLf
                            strScript += "		for(intCount=1;intCount<=objForm.elements.length - 1;intCount++)" & vbCrLf
                            strScript += "		{" & vbCrLf
                            strScript += "			if(objForm.elements[intCount].type==""checkbox"" &&  objForm.elements[intCount].name==""chkDomain"")" & vbCrLf
                            strScript += "			{" & vbCrLf
                            strScript += "				if(eval(objForm.elements[intCount].value)==eval(intDomainID))" & vbCrLf
                            strScript += "				{" & vbCrLf
                            strScript += "					objForm.elements[intCount].checked=true;" & vbCrLf
                            strScript += "					break;" & vbCrLf
                            strScript += "				}" & vbCrLf
                            strScript += "			}" & vbCrLf
                            strScript += "		}" & vbCrLf
                            strScript += "	}" & vbCrLf
                            strScript += "}	" & vbCrLf
                            strScript += "function chkSubMarket_OnClick(intDomainID,intMarketID,intSubMarketID)" & vbCrLf
                            strScript += "{" & vbCrLf
                            strScript += "  var objForm = GetFormReference('frmCommonList');" & vbCrLf
                            strScript += "	var strMarket;" & vbCrLf
                            strScript += "	var blnChecked;" & vbCrLf
                            strScript += "	var intCount;" & vbCrLf
                            strScript += "	strMarket="""";" & vbCrLf
                            strScript += "  strMarket=intDomainID + "":"" + intMarketID + "":"" + intSubMarketID;" & vbCrLf
                            strScript += "	for(intCount=0;intCount<=objForm.elements.length - 1;intCount++)" & vbCrLf
                            strScript += "	{" & vbCrLf
                            strScript += "		if(objForm.elements[intCount].value==strMarket)" & vbCrLf
                            strScript += "		{" & vbCrLf
                            strScript += "			if(objForm.elements[intCount].checked==true)	" & vbCrLf
                            strScript += "			{" & vbCrLf
                            strScript += "				blnChecked =true;" & vbCrLf
                            strScript += "				break;" & vbCrLf
                            strScript += "			}" & vbCrLf
                            strScript += "		}" & vbCrLf
                            strScript += "	}" & vbCrLf
                            strScript += "	strMarket="""";" & vbCrLf
                            strScript += "	strMarket = intDomainID + "":"" + intMarketID" & vbCrLf
                            strScript += "" & vbCrLf
                            strScript += "	if (blnChecked==true)" & vbCrLf
                            strScript += "	{" & vbCrLf

                            strScript += "				for(intCount=0;intCount<=objForm.elements.length - 1;intCount++)" & vbCrLf
                            strScript += "				{" & vbCrLf
                            strScript += "					if(objForm.elements[intCount].type==""checkbox"")" & vbCrLf
                            strScript += "					{" & vbCrLf
                            strScript += "						if(objForm.elements[intCount].value==strMarket)" & vbCrLf
                            strScript += "						{" & vbCrLf

                            strScript += "							objForm.elements[intCount].checked=true;" & vbCrLf
                            strScript += "							break;" & vbCrLf
                            strScript += "						}" & vbCrLf
                            strScript += "					}" & vbCrLf
                            strScript += "				}" & vbCrLf
                            strScript += "				" & vbCrLf
                            strScript += "				chkMarket_OnClick(intDomainID, intMarketID);" & vbCrLf
                            strScript += "	}" & vbCrLf
                            strScript += "}" & vbCrLf
                            strScript += "//-->" & vbCrLf
                            strScript += "</SCRIPT>" & vbCrLf
                            Args.ToBeInserted = strScript
                            'End of Addition - ShamkantD on 9th August 2004
                            'End of modification by NiranjanK on June 07,2006 Issue ID.4168
                            'Added by ShamkantD on 10th August 2004
                            strScript = "<input type=""hidden"" id=""txtHidden"" name=""txtHidden"">" & vbCrLf
                            Args.ToBeInserted += strScript
                            'End of Addition - ShamkantD on 10th August 2004

                            'Added by ShamkantD on 11th August 2004 - release the session variables
                            HttpContext.Current.Session("strServicesSegmentationIDs") = Nothing
                            HttpContext.Current.Session("strServiceOfferingIDs") = Nothing
                            HttpContext.Current.Session("strSubServiceOfferingIDs") = Nothing
                            'End of Addition - ShamkantD on 11th August 2004

                            HttpContext.Current.Session("strDomainIDs") = Nothing
                            HttpContext.Current.Session("strMarketIDs") = Nothing
                            HttpContext.Current.Session("strSubmarketIDs") = Nothing


                            'Added By AmitD For Question Selection List on 26 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_QUESTION_SELECTION_LIST
                            Dim strQuestionireID As String
                            If CType(HttpContext.Current.Request.QueryString("QuestionireID"), String) <> "" Then
                                strQuestionireID = CType(HttpContext.Current.Request.QueryString("QuestionireID"), String)
                            Else
                                strQuestionireID = CType(HttpContext.Current.Request.Form("txtQuestionireID"), String)
                            End If

                            CommonFunctions.General.WriteHTML("<input type='hidden' name='txtQuestionireID' id='txtQuestionireID' value='" + CType(strQuestionireID, String) + "'>")

                            'End Addition

                            'Added by ShamkantD on 27 Sep 2004 - added for 'Project Listing for Approvals' page
                        Case CommonFunction.Constants.APP_TAG_PROJECT_LISTING_FOR_APPROVALS
                            Dim strScript As String = ""

                            '' START : Added By ParagD 03-Oct-2006
                            Dim strPagingAlphabet As String = ""
                            If Trim(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PagingAlphabet"), "")) <> "" Then
                                strPagingAlphabet = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PagingAlphabet"), "-1")
                            End If
                            '' END : Added By ParagD 03-Oct-2006

                            strScript = vbCrLf & "<SCRIPT LANGUAGE=javascript>" & vbCrLf
                            strScript &= "function ShowProjectInfo(intProjectID, strProjectName,strToken)" & vbCrLf
                            strScript &= "{  "
                            strScript += "var objParentObj;" & vbCrLf
                            strScript += "objParentObj = GetParentFormReference(""frmCommonList"");" & vbCrLf
                            strScript += "if (typeof(objParentObj) != ""object"" || objParentObj == null)" & vbCrLf
                            strScript += "  objParentObj = GetParentFormReference(""frmCommonPage"");" & vbCrLf
                            strScript += "if (typeof(objParentObj) == ""object"" && objParentObj != null)" & vbCrLf
                            'Added By JyotiG
                            'Start
                            'Issue ID : 6236
                            'strScript += "{ objParentObj.action='../General/Navigation.aspx?subPage=CommonPage.aspx&ProjectID_PK=' + intProjectID + '&ProjectName=' + strProjectName + '&MasterTagID=32&FromWhere=PM" & "&PagingAlphabet=" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PagingAlphabet"), "-1") & "&SortBy=" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SortBy"), "") & "&SortOrder=" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SortOrder"), "") & "&ParentTagID=0&FromCL=1&PKToken=' + strToken;" & vbCrLf

                            '' START : Commented and Modified By ParagD 03-Oct-2006
                            '' strScript += "{ objParentObj.action='../General/Navigation.aspx?subPage=CommonPage.aspx&ProjectID_PK=' + intProjectID + '&ProjectName=' + strProjectName + '&MasterTagID=32&FromWhere=PM&LoadFrom=SHOWAPPROVAL" & "&PagingAlphabet=" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PagingAlphabet"), "-1") & "&SortBy=" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SortBy"), "") & "&SortOrder=" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SortOrder"), "") & "&ParentTagID=0&FromCL=1&PKToken=' + strToken;" & vbCrLf

                            'Modifed By NitinVS on 9 Mar 2007 for WhizibleSEM SP8 Regressssion Issues ISsueID 11101
                            'Removed the Project Name from Query string as it is not required

                            '''''Added by ShraddhaM on 3,July 2008 for Gadget functionality
                            ''''' To change Edit mode URL
                            ''''Dim drReader As IDataReader
                            ''''Dim SQL As String
                            ''''Dim IsActive As Boolean = True
                            ''''Dim strSubPage As String

                            ''''SQL = "usp_Sel_tbl_CNF_GadgetNodes_EmployeePreferences 27," + HttpContext.Current.Session("intUserID").ToString()
                            ''''drReader = CommonFunction.Data.GetDataReader(SQL, True)
                            ''''If drReader.Read Then
                            ''''    IsActive = CType(drReader("Active"), Boolean)
                            ''''End If
                            ''''If IsActive = True Then
                            ''''    strSubPage = "Tab_Viewpage.aspx"
                            ''''Else
                            ''''    strSubPage = "CommonPage.aspx"
                            ''''End If
                            'commented and added by ShraddhaM on 7,July for gagdet functionality
                            strScript += "{ var strTemp = escape(""" + strPagingAlphabet + """);  objParentObj.action='../General/Navigation.aspx?subPage=CommonPage.aspx&ProjectID_PK=' + intProjectID + '&MasterTagID=32&FromWhere=PM&LoadFrom=SHOWAPPROVAL" & "&PagingAlphabet=' + strTemp + '&SortBy=" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SortBy"), "") & "&SortOrder=" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SortOrder"), "") & "&ParentTagID=0&FromCL=1&PKToken=' + strToken;" & vbCrLf
                            ''''strScript += "{ var strTemp = escape(""" + strPagingAlphabet + """);  objParentObj.action='../General/Navigation.aspx?subPage=" + strSubPage + "&ProjectID_PK=' + intProjectID + '&MasterTagID=32&FromWhere=PM&LoadFrom=SHOWAPPROVAL" & "&PagingAlphabet=' + strTemp + '&SortBy=" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SortBy"), "") & "&SortOrder=" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SortOrder"), "") & "&ParentTagID=0&FromCL=1&PKToken=' + strToken;" & vbCrLf
                            'End of comment and addition by ShraddhaM on 7,July for gagdet functionality

                            'End Modification  By NitinVS on 9 Mar 2007 for WhizibleSEM SP8 Regressssion Issues ISsueID 11101

                            '' END : Commented and Modified By ParagD 03-Oct-2006

                            'End  

                            strScript += "  objParentObj.target='_top';" & vbCrLf
                            strScript += "  objParentObj.submit();    }" & vbCrLf

                            strScript &= "window.close();" & vbCrLf
                            strScript &= "return;   }" & vbCrLf
                            strScript &= "</SCRIPT>" & vbCrLf

                            Args.ToBeInserted = strScript
                            'End of addition - ShamkantD on 27 Sep 2004

                            'Added by ShamkantD on 29 Sep 2004 - added for Show Revisions (Project Information) page
                        Case CommonFunction.Constants.APP_TAG_TAB_BASELINE_REVISION
                            Dim strScript As String = ""
                            strScript = vbCrLf & "<SCRIPT LANGUAGE=javascript>" & vbCrLf

                            strScript &= "function ShowReason(intReavisionReasonID, strMode)" & vbCrLf
                            strScript &= "{  "
                            'Modified By JyotiG (31-Aug-2006)
                            'Start
                            'strScript &= "window.open('../General/CommonPage.aspx?FromWhere=PM&MasterTagID=2224&RevisionReasonID=' + intReavisionReasonID + '&Mode=' + strMode,'_blank','resizable=yes,scrollbars=no,left=' + (window.screen.width - 450)/2 + ',top=' + (window.screen.height - 250)/2 + ',width=450,height=250');" & vbCrLf
                            strScript &= "window.open('../General/CommonPage.aspx?FromWhere=PM&MasterTagID=2224&RevisionReasonID=' + intReavisionReasonID + '&Mode=' + strMode,'_blank','resizable=yes,scrollbars=no,left=' + (window.screen.width - 700)/2 + ',top=' + (window.screen.height - 300)/2 + ',width=600,height=350');" & vbCrLf
                            'End
                            strScript &= "return;   }" & vbCrLf
                            'Modified By JyotiG
                            'Date :24-Aug-2006
                            'Issue ID : 5687
                            'Start
                            strScript &= "function SenderComment(intReavisionReasonID, strMode)" & vbCrLf
                            strScript &= "{  "
                            'Modified By JyotiG (31-Aug-2006)
                            'Start
                            'strScript &= "window.open('../General/CommonPage.aspx?FromWhere=PM&MasterTagID=2224&RevisionReasonID=' + intReavisionReasonID + '&Mode='+ strMode,'_blank','resizable=yes,scrollbars=no,left=' + (window.screen.width - 450)/2 + ',top=' + (window.screen.height - 250)/2 + ',width=450,height=250');" & vbCrLf
                            strScript &= "window.open('../General/CommonPage.aspx?FromWhere=PM&MasterTagID=2224&RevisionReasonID=' + intReavisionReasonID + '&Mode='+ strMode,'_blank','resizable=yes,scrollbars=no,left=' + (window.screen.width - 700)/2 + ',top=' + (window.screen.height - 300)/2 + ',width=600,height=350');" & vbCrLf
                            'End
                            strScript &= "return;   }" & vbCrLf
                            'End        
                            strScript &= "</SCRIPT>" & vbCrLf

                            Args.ToBeInserted = strScript
                            'End of addition - ShamkantD on 29 Sep 2004

                            'added by SachinR   on 12 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_MAIN_DELIVERABLE_TYPES

                            'plot the javascript for the function
                            Args.ToBeInserted = vbCrLf + "<SCRIPT LANGUAGE=javascript>" + vbCrLf
                            Args.ToBeInserted += "function Deliverable_OnClick(SID){" + vbCrLf
                            ''Added by Manishk on 10th Jan 06 to add Deliverable link on Help desk, Issues, Change management
                            If CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper = "SM" Then
                                Args.ToBeInserted += "opener.location.href='CommonPage.aspx?Mode=ADD_NEW&MasterTagID=2133&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&ScheduleTypeID=' + SID;" + vbCrLf
                                Args.ToBeInserted += "window.close();" + vbCrLf
                            Else
                                'Args.ToBeInserted += "window.close();" + vbCrLf
                                Args.ToBeInserted += "window.open('../General/CommonPage.aspx?Mode=ADD_NEW&MasterTagID=2133&FromWhere=" + CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")) + "&PagingAlphabet=-1&FunctionID=" + CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FunctionID"), "")) + "&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&ScheduleTypeID=' + SID ,'_self','resizable=yes,scrollbars=no,left=' + (window.screen.width - 650)/2 + ',top=' + (window.screen.height - 600)/2 + ',width=700,height=600');" & vbCrLf
                            End If
                            ''End of Added by Manishk on 10th Jan 06 to add Deliverable link on Help desk, Issues, Change management
                            Args.ToBeInserted += "}" + vbCrLf
                            Args.ToBeInserted += "</Script>" + vbCrLf
                            'addition end

                            ''Commented by ManishK On 3rd Jan 06 as New page is added for the leave page
                            '''    'Added By JayavantK On 15-Oct-2004
                            '''Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEAPPLICATION
                            '''    PlotLeavesGraph(WhizGlobal.UserID)
                            '''    CommonFunctions.General.WriteHTML("</Div>")
                            '''    'End Addition
                            ''End of commented by Manishk on 3rd Jan 06 

                            ' Added By SrikanthY on 23 Nov 2006
                            'Case CommonFunction.Constants.App_Tag_Flagtrack
                            '    Dim strScript As String = ""
                            '    strScript = vbCrLf & "<Script Language=Javascript>" & vbCrLf
                            '    strScript &= "function FlagSet(intProjectID,intContextid,intEmployeeid,strContexttype,strEntityName)" & vbCrLf
                            '    strScript &= "{  " & vbCrLf
                            '    'strScript &= "window.open (""../DB/DB_TrackingDetails.aspx?ProjectID=123,_blank,resizable=yes,scrollbars=no,left="" + (window.screen.width - 540)/2 + "",top="" + (window.screen.height - 430)/2 + "",width=420,height=300"" );" & vbCrLf
                            '    strScript &= " window.open (""../DB/DB_TrackingDetails.aspx?ProjectID="" + intProjectID + ""&ContextID="" + intContextid + ""&EmployeeID="" + intEmployeeid + ""&ContextType=""+ strContexttype +""&FromWhich=FlagTrack&ContextName="" + strEntityName ,""_blank"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 540)/2 + "",top="" + (window.screen.height - 430)/2 + "",width=420,height=300"" ); " & vbCrLf
                            '    strScript &= "}  " & vbCrLf
                            '    strScript = strScript & vbCrLf & "</Script >" & vbCrLf
                            '    Args.ToBeInserted = strScript
                            '    ' End Of Addition by SrikanthY
                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID

                    End Select
                End If
            End Sub

            Public Shared Sub After_GridColumnHeaderTR_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
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

            Public Shared Sub After_GridColumnHeaderTD_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
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

            Public Shared Sub After_GridDataRowTR_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID
                        'OnSiteOffshore Functionality
                        Case CommonFunction.Constants.APP_TAG_EMPLOYEESITEDETAILS
                            Args.StringToBeInserted = "<input name='EmployeeID' type='hidden' id='EmployeeID' value=" + CType(Args.DataReader("EmployeeID"), String) + ">"
                            'End Addition
                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID

                    End Select
                End If
            End Sub

            Public Shared Sub After_GridDataRowTD_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID
                        'Added by MrugajaB on 30th April,2005 for integrating PBNV4 SP6 Hotfix ID.4.0.116-WAF in WhizibleSEM Sp3
                        Case CommonFunctions.Constants.TAG_AUDIT_TRAIL
                            Args.EnableLink = False
                            If Args.DataField.ToUpper = "DATE" Then Args.ShowTimeWithDate = True
                            'End Addition
                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID

                    End Select
                End If
            End Sub

            Public Shared Sub InitializeListPage_SubTag(ByRef Cancel As Boolean, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal PrimaryKey As String)
                Cancel = False
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


            Public Shared Sub BeforePrintListPage_SubTag(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_SubTag, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal PrimaryKey As String)
                Cancel = False

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

            Private Shared Sub PlotLeavesGraph(ByVal lngUserID As Long)
                '====================================================================
                ' Procedure Name       : PlotLeavesGraph
                ' Parameters Passed    : lngUserID = User ID
                ' Returns              : None
                ' Parameters Affected  : None
                ' Purpose              : To Plot the Balance Leaves Vs.Total Leaves graph.
                ' Description          : Since the graph need to plot on the list page (not on form) need to write
                '                        this procedure.
                ' Assumptions          : 
                ' Dependencies         : 
                ' Author               : JayavantK
                ' Created              : October 15, 2004
                ' Revisions            : 
                '=====================================================================
                Dim objGraph As New Graph.Graph
                Dim strVirtualImgPath As String = ""
                Dim strImageFileName As String = ""
                Dim strQuery As String = ""
                Dim arrChartType As String() = {"Column", "Column", "Column", "Column", "Column"}
                Dim objSectionHead As WebPages.Template.SectionTitle
                Dim objTemplate As New WebPage.Templates.WhizTemplate
                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                objSectionHead = New WebPages.Template.SectionTitle
                With objSectionHead
                    CommonFunctions.General.WriteHTML(.GetSectionTitle(objTemplate.GetResourceString("GRAPH_SECTION"), "divGraphSection", "ShowHide_divGraphSection", , , , , , , ))
                    CommonFunctions.General.WriteHTML(System.Environment.NewLine + "<SCRIPT language=javascript>" + System.Environment.NewLine)
                    CommonFunctions.General.WriteHTML(.ClientsideScript())
                    CommonFunctions.General.WriteHTML(System.Environment.NewLine + "</SCRIPT>" + System.Environment.NewLine)
                End With
                objSectionHead = Nothing

                CommonFunctions.General.WriteHTML("<DIV Id='divGraphSection' Style='HEIGHT:150px;'>")
                CommonFunction.General.WriteHTML("<Table class=clsTable cellspacing=1 cellpadding=0 border=0>")
                CommonFunction.General.WriteHTML("<TR><TD>")

                strImageFileName = CommonFunction.FileDirectory.GetUniqueFileName
                strVirtualImgPath = CommonFunction.Constants.CLCP_IMAGES_FOLDER_PATH + "/" + strImageFileName

                strQuery = "select LeaveType AS [Leave Type], NoOfLeaves AS [Total Leaves], LeaveBalance "
                strQuery = strQuery + " AS [Balance Leaves] from d_tbl_PM_EmployeeLeaveMaster "
                strQuery = strQuery + " where EmployeeID=" + lngUserID.ToString() + " Order By LeaveType "

                With objGraph
                    .AbsoluteImagePath = HttpContext.Current.Server.MapPath(strVirtualImgPath)
                    .BorderColor = "white"
                    .BorderGradientColor = "Blue"
                    .BorderGradientStyle = "TopBottom"
                    .BorderStyle = "FRAMETITLE5"
                    .ChartAreaColor = "skyBlue"
                    .ChartAreaGradientColor = "white"
                    .ChartAreaGradientStyle = "TopBottom"
                    .ChartBackColor = "Beige"
                    .ChartBackGradientColor = "White"
                    .ChartBackGradientStyle = "TopBottom"
                    .ChartType = arrChartType
                    .ConnectionString = CommonFunction.Application.ConnectionString
                    .Enable3D = False
                    .GraphTitle = objTemplate.GetResourceString("GRAPH_TITLE")
                    .GraphTitleColor = "Black"
                    .Height = 300
                    .LegendCaptionColor = "Black"
                    .LegendFont = New System.Drawing.Font("Microsoft Sans Serif", 9, System.Drawing.FontStyle.Regular)
                    .PalleteStyle = "excel"
                    .PieChartLabelStyle = ""
                    .ShowExplodedPie = False
                    .ShowLegends = True
                    .SQL = strQuery
                    .TitleFont = New System.Drawing.Font("Microsoft Sans Serif", 9, System.Drawing.FontStyle.Bold)
                    .VirtualImagePath = strVirtualImgPath
                    .Width = 600
                    .EnableSmartLabels = True
                    .ShowCaptions = True
                    .GenerateImage()
                End With
                CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawImage(strVirtualImgPath + ".png", , , , , , , True))

                CommonFunction.General.WriteHTML("</TD></TR></TABLE></DIV>")
                objGraph = Nothing
                objTemplate = Nothing
            End Sub
        End Class
    End Namespace
End Namespace

