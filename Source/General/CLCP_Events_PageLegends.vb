Imports ProjectByNet
Namespace CommonEngine
    Namespace General
        Public Class CLCP_Events_PageLegends

            Public Shared Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As EventHandlers.WAF_General)
                If WhizGlobal.ParentTagID = 0 Then
                    Select Case WhizGlobal.TagID
                        ' Added by DiptiK on 18th Aug 2k4
                        Case CommonFunction.Constants.APP_TAG_CNF_PROJECT_SETTINGS
                            Args.HTMLLegend = " "
                            Cancel = True
                            ' Addition Ends
                            ' Added by DiptiK on 14th Sep 2k4
                        Case CommonFunction.Constants.APP_TAG_CNF_SERVICE_SEGMENATATION
                            Args.HTMLLegend = " "
                            Cancel = True
                            ' Addition Ends

                            'Added by HarshK for sp4 issueid 200
                        Case CommonFunction.Constants.APP_TAG_MODULE_SELECTION_LIST
                            Args.HTMLLegend = "<font color='blue'>(Blue color indicates currently selected Module.)</font> "
                            '---------------------
                        Case CommonFunction.Constants.APP_TAG_MILESTONE_SELECTION_LIST
                            Args.HTMLLegend = "<font color='blue'>(Blue color indicates currently selected MileStone.)</font> "
                            '---------------------
                        Case CommonFunction.Constants.APP_TAG_SUBPROJECT_SELECTION_LIST
                            Args.HTMLLegend = "<font color='blue'>(Blue color indicates currently selected Sub Project.)</font> "
                            '---------------------
                        Case CommonFunction.Constants.APP_TAG_TASKTYPE_SELECTION_LIST
                            Args.HTMLLegend = "<font color='blue'>(Blue color indicates currently selected Task Type.)</font> "
                            '---------------------
                        Case CommonFunction.Constants.APP_TAG_PHASE_SELECTION_LIST
                            Args.HTMLLegend = "<font color='blue'>(Blue color indicates currently selected Phase.)</font> "
                            'End Added by HarshK for sp4 issueid 200

                            'Added by PrachiK on 23 Feb 2005 for IssueID 16336
                            'Purpose:Issues regarding the Deliverable Selection page.
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLES_SELECTION_LIST
                            Args.HTMLLegend = "<font color='blue'>(Blue color indicates currently selected Deliverable.)</font> "
                            'Addtion Ended
                            ' Added by DiptiK on 14th Sep 2k4
                        Case CommonFunction.Constants.APP_TAG_CNF_MARKET_SEGMENATATION
                            Args.HTMLLegend = " "
                            Cancel = True
                            ' Addition Ends

                            'Added by Lakshmi on 21st Aug 2004
                            'Modified (commented) by ShamkantD on 8 Oct 2004
                            'Case CommonFunction.Constants.APP_TAG_PROJECT_DOH
                            'Args.HTMLLegend = " "
                            'Cancel = True
                            'End Addition
                            'End of modification - ShamkantD on 8 Oct 2004

                            ' Added by DiptiK on 20th Sep 2k4
                        Case CommonFunction.Constants.APP_TAG_TAB_SELECT_COST_HEADS
                            Args.HTMLLegend = " "
                            Cancel = True
                            ' Addition Ends

                            'Addition done by SuchitraP on 26-Jun-2007 for IssueID 13969
                            'Purpose:To remove pagelegend "Red colour indicates applied filter" when Filter link is not displayed.
                        Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEMASTER
                            Args.HTMLLegend = " "
                            Cancel = True
                        Case CommonFunction.Constants.APP_TAG_LEAVEAPPROVERS
                            Args.HTMLLegend = " "
                            Cancel = True
                            'End of Addition done by SuchitraP on 26-Jun-2007 for IssueID 13969
                            'Added By ShraddhaM on 13,July 2007 to Remove Legend of Filter from CRM History
                        Case CommonFunction.Constants.APP_TAG_SHOW_CRM_HISTORY
                            Args.HTMLLegend = " "
                            Cancel = True
                            'End of Addition By ShraddhaM on 13,July 2007 to Remove Legend of Filter from CRM History
                        Case CommonFunctions.Constants.TAG_ADVANCE_FILTERS, CommonFunction.Constants.APP_TAG_REVISION_HISTORY, _
                            CommonFunction.Constants.APP_TAG_CONFIG_TYPE_SECURITY, CommonFunction.Constants.APP_TAG_CONFIG_TYPE_SECURITY_ROLES, CommonFunction.Constants.APP_TAG_SDLC_PROCESS, CommonFunctions.Constants.TAG_AUDIT_TRAIL, CommonFunction.Constants.APP_TAG_TASK_TYPE_MAINTENANCE_PM, _
                            CommonFunction.Constants.APP_TAG_GLOBAL_GEN_TASKS
                            'Added By ShraddhaM on 27,July 2007 to Remove Legend of Filter from TimeSheet details Page of PM Dashboard Enhanced View
                        Case CommonFunction.Constants.APP_TAG_TIMESHEET_DETAILS
                            Args.HTMLLegend = " "
                            Cancel = True
                            'End of Addition By ShraddhaM on 27,July 2007 
                            'Addition by SuchitraP on 2-Oct-2008 to remove legend of filter form Project Alerts
                        Case CommonFunction.Constants.APP_TAG_PROJECT_ALERTS
                            Args.HTMLLegend = ""
                            Cancel = True
                            'End of addition by SuchitraP
                        Case 3070, 8040, 2249, 1212, 3003, 8052, 2504, 1020, 2168, 3631, 2146, 9018, 3604, 8071, 312, 586, 1909, 1919, 1920, 1921, 1908, 1916, 1913, 1912,
1914, 1911, 1910, 1915
                            Args.HTMLLegend.Contains("(Red color indicates applied filter)")
                            Cancel = True
                        Case Else

                            If Gen.IsListPage = True And Gen.PrimaryKeyValue.Trim = "" Then
                                Dim objTemplate As WebPages.Template.WhizTemplate
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("Resources.AdvanceFilters", "Resources")
                                Dim strLegend As String = objTemplate.GetResourceString("FILTER_LEGEND")
                                objTemplate = Nothing

                                Args.HTMLLegend += "<font Face='Verdana' color='#cc0000' size='1'>" + strLegend + "</FONT>"
                            End If
                    End Select
                Else
                    Select Case WhizGlobal.TagID

                    End Select
                End If
            End Sub

            Public Shared Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As EventHandlers.WAF_General)
                Cancel = False
                'This Event will occur before printing page legends
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
