Imports ProjectByNet
Namespace CommonEngine
    Namespace General
        Public Class CLCP_Events_DynamicActions

            'Added By PrasannaP on 26th April 2005
            'This facilitates the New Link to be printed before or after the CommonEngine Menu. 
            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
            Public Shared Sub Before_Menu_Print(ByRef Cancel As Boolean, ByRef Args As WAF_MenuLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim strEvent As String
                strEvent = "Before_Menu_Print"
                Dim blnUseRouter As Boolean = False
                blnUseRouter = WAF.EventRouter.CheckRouterUse(WhizGlobal.TagID, WhizGlobal.ParentTagID, strEvent)

                If blnUseRouter = True Then
                    Dim objParameters(3) As Object
                    objParameters(0) = CType(Cancel, Object)
                    objParameters(1) = CType(Args, Object)
                    objParameters(2) = CType(WhizGlobal, Object)
                    WAF.EventRouter.RouteRequest(objParameters, strEvent, CType(WhizGlobal.TagID, String), WhizGlobal.ParentTagID)
                    Cancel = CType(objParameters(0), Boolean)
                    Args = CType(objParameters(1), WAF_MenuLinks)
                    WhizGlobal = CType(objParameters(2), WebPages.Template.IGlobal)
                    Return
                End If

                '------- added By PurvaJ on 1 July 2008 Generic workflow
                If WhizGlobal.ParentTagID = 0 Then
                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING, CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS, CommonFunction.Constants.APP_TAG_MODULES, CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT, CommonFunction.Constants.APP_TAG_SUB_PROJECTS, CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                            Args.ToBeInserted = CommonFunction.WhizibleWorkflow.PlotWorkflowLinks(WhizGlobal.TagID, Args.PrimaryKeyValue, WhizGlobal)
                    End Select
                End If
                '------ end addition Purvaj


                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID

                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID

                    End Select
                End If
                'End Addition
            End Sub

            Public Shared Sub After_Menu_Print(ByRef Args As WAF_MenuLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim strEvent As String
                strEvent = "After_Menu_Print"
                Dim blnUseRouter As Boolean = False
                blnUseRouter = WAF.EventRouter.CheckRouterUse(WhizGlobal.TagID, WhizGlobal.ParentTagID, strEvent)

                If blnUseRouter = True Then
                    Dim objParameters(2) As Object
                    objParameters(0) = CType(Args, Object)
                    objParameters(1) = CType(WhizGlobal, Object)
                    WAF.EventRouter.RouteRequest(objParameters, strEvent, CType(WhizGlobal.TagID, String), WhizGlobal.ParentTagID)
                    Args = CType(objParameters(1), WAF_MenuLinks)
                    WhizGlobal = CType(objParameters(2), WebPages.Template.IGlobal)
                    Return
                End If

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID

                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID

                    End Select
                End If
                'End Addition
            End Sub
            'End Of Modifications - IssueID : 672

            Public Shared Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Cancel = False
                'This Event will occur before printing navigation links
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_TAG_PROCESS
                            If Args.ClientSideFunctionName.ToUpper = "HYPERLINK1" Then
                                Dim strFunction As String
                                Dim objTemplate As WebPages.Template.WhizTemplate
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                'For this case the client side function called on the link click is written manually for
                                'showing the alert dialog conditionally
                                strFunction = "RevisionNo = RevisionNo + 1;"
                                strFunction += "if (ActivityAssociated==0)"
                                strFunction += "{"
                                strFunction += "if (confirm(""" + objTemplate.GetResourceString("PROCESS_ACTIVITY") + """))"
                                strFunction += "{"
                                strFunction += "window.open(""CommonPage.aspx?FromWhere=PRO&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&Mode=ADD_NEW&MasterTagID=1043&ActivityAssociated=""+ActivityAssociated+""&ProcessID=""+ProcessID+""&RevisionNo=""+RevisionNo+""&OUPoolID=""+OUPoolID, """", ""resizable=yes,scrollbars=no,left="" + (window.screen.width - 500)/2 + "",top="" + (window.screen.height - 200)/2 + "",width=550,height=350""); "
                                strFunction += "}"
                                strFunction += "}"
                                strFunction += "else"
                                strFunction += "{"
                                strFunction += "window.open(""CommonPage.aspx?FromWhere=PRO&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&Mode=ADD_NEW&MasterTagID=1043&ActivityAssociated=""+ActivityAssociated+""&ProcessID=""+ProcessID+""&RevisionNo=""+RevisionNo+""&OUPoolID=""+OUPoolID, """", ""resizable=yes,scrollbars=no,left="" + (window.screen.width - 500)/2 + "",top="" + (window.screen.height - 200)/2 + "",width=550,height=350"");"
                                strFunction += "}"
                                strFunction += "return;"
                                Args.ToBeInserted = strFunction
                                objTemplate = Nothing
                            End If
                        Case CommonFunction.Constants.APP_TAG_RESOURCES
                            If Args.ClientSideFunctionName.ToUpper = "NONDATABASE101019" Then
                                Dim strFunction As String
                                strfunction = "objRole = GetObjectReference('frmCommonPage', 'Role');" + vbCrLf
                                'Added By PrachiK on 24 Mar 2005 for Issue ID 16434. 
                                'Purpose: The value of Billable Field changes from true to false when project is revised.
                                'Integrated by PrashantSJ on 06 Nov 2006
                                'Purpose: For Multi attachement Enhacements
                                'strfunction += "window.open (""../HR/HR_EmployeeSelection.aspx?FromWhere=PM&RoleID=""+objRole.value, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 400)/2 + "",width=750,height=400"");" + vbCrLf
                                'Added by ArchanaN on 11 Aug 2006
                                'Purpose : Performance Issue
                                strfunction += "window.open (""../HR/ResourceSelection_CommonList.aspx?MasterTagID=3633&PTagID=" & WhizGlobal.TagID.ToString & "&FromWhere=PM&RoleID=""+objRole.value, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 800)/2 + "",top="" + (window.screen.height - 400)/2 + "",width=900,height=400"");" + vbCrLf
                                'End of Added by ArchanaN on 11 Aug 2006
                                'End of Integration by PrashantSJ on 06 Nov 2006
                                'Addtion ended
                                strFunction += "return;"
                                Args.ToBeInserted = strFunction
                            End If
                            ''Commented by Manishk On 3rd Jan 06 as new inherited page is added for leave page
                            '''Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEAPPLICATION
                            '''    If Args.ClientSideFunctionName.ToUpper = "CANCEL_ONCLICK" Then
                            '''        Dim strFunction As String
                            '''        strFunction = "var bConfirmed;" + vbCrLf
                            '''        strFunction += "bConfirmed = window.confirm('Do you want cancel the leave application?');" + vbCrLf
                            '''        strFunction += "if (bConfirmed == false) " + vbCrLf
                            '''        strFunction += "return;"
                            '''        Args.ToBeInserted = strFunction
                            '''    End If
                            ''End of commented by Manishk on 3rd Jan 06

                        Case CommonFunction.Constants.APP_TAG_ASSIGNEDRESOURCES
                            'add the URL for reject link. we pass the requestid and employeeid.
                            If Args.ClientSideFunctionName.ToUpper = "REJECT_ONCLICK" Then
                                Dim strFunction As String
                                strFunction = "../HR/HR_AddComments.aspx?Mode=REJECT_RESOURCE&RequestID=" + HttpContext.Current.Request.QueryString("RequestID").ToString + "&EmployeeID=<UNIQUE_ID>"","""",""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 400)/2 + "",width=550,height=250"
                                Args.HREF_URL = strFunction
                            End If
                            'add the URL for comment link. we pass the requestid and employeeid.
                            If Args.ClientSideFunctionName.ToUpper = "COMMENTS_ONCLICK" Then
                                Dim strFunction As String
                                strFunction = "../HR/HR_AddComments.aspx?Mode=REJECT_RESOURCE_VIEW&RequestID=" + HttpContext.Current.Request.QueryString("RequestID").ToString + "&EmployeeID=<UNIQUE_ID>"","""",""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 400)/2 + "",width=550,height=250"
                                Args.HREF_URL = strFunction
                            End If
                            'addition end
                            'added by SachinR   on 22 Jul 2004
                            'purpose    To implement Process definition workflow
                        Case CommonFunction.Constants.APP_TAG_PROCESS_PHASETASK
                            If Args.ClientSideFunctionName.ToUpper = "HYPERLINK1" Then
                                Dim strFunction As String
                                Dim objTemplate As WebPages.Template.WhizTemplate
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                'For this case the client side function called on the link click is written manually for
                                'showing the alert dialog conditionally
                                strFunction = "var intRevisionNo = Number(RevisionNo);" + vbCrLf
                                strFunction += "intRevisionNo += 1;" + vbCrLf
                                strFunction += "var blnShow=true;" + vbCrLf
                                strFunction += "if (ActivityAssociated==0)" + vbCrLf
                                strFunction += "{ blnShow=false; " + vbCrLf
                                strFunction += "if (confirm(""" + objTemplate.GetResourceString("PHASE_ACTIVITY") + """))" + vbCrLf
                                strFunction += "{ blnShow=true; }" + vbCrLf
                                strFunction += "}" + vbCrLf
                                strFunction += "else" + vbCrLf
                                strFunction += "{" + vbCrLf
                                strFunction += " if (TemplatesAssociated > 0)" + vbCrLf
                                strFunction += "{ blnShow=false; " + vbCrLf
                                strFunction += "if (confirm(""" + objTemplate.GetResourceString("PHASE_TEMPLATE") + """))" + vbCrLf
                                strFunction += "{ blnShow=true; } " + vbCrLf
                                strFunction += "}" + vbCrLf
                                strFunction += "else" + vbCrLf
                                strFunction += "{ blnShow=true; }" + vbCrLf
                                strFunction += "}" + vbCrLf
                                strFunction += "if(blnShow==true)" + vbCrLf
                                strFunction += "{" + vbCrLf
                                strFunction += "window.open(""CommonPage.aspx?FromWhere=PRO&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&Mode=ADD_NEW&MasterTagID=2011&&PhaseTaskID=""+ PhaseTaskID + ""&RevisionNo="" + intRevisionNo, """", ""resizable=yes,scrollbars=no,left="" + (window.screen.width - 500)/2 + "",top="" + (window.screen.height - 200)/2 + "",width=550,height=350"");" + vbCrLf
                                strFunction += "}" + vbCrLf
                                strFunction += "return;" + vbCrLf
                                Args.ToBeInserted = strFunction
                                objTemplate = Nothing
                            End If
                            'addition end

                            'added by SachinR   on 30 Jul 2004
                        Case CommonFunction.Constants.APP_TAG_PROCESS_PHASETASK_TEMPLATES
                            If Args.ClientSideFunctionName.ToUpper = "HYPERLINK1" Then
                                Dim strFunction As String

                                'For this case the client side function called on the link click is written manually for
                                'showing the alert dialog conditionally
                                strFunction = "var intRevisionNo = Number(RevisionNo);" + vbCrLf
                                strFunction += "intRevisionNo += 1;" + vbCrLf
                                strFunction += "window.open(""CommonPage.aspx?FromWhere=PRO&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&Mode=ADD_NEW&MasterTagID=2052&TemplateId=""+ TemplateId + ""&RevisionNo="" + intRevisionNo, """", ""resizable=yes,scrollbars=no,left="" + (window.screen.width - 500)/2 + "",top="" + (window.screen.height - 200)/2 + "",width=550,height=350"");" + vbCrLf
                                strFunction += "return;" + vbCrLf
                                Args.ToBeInserted = strFunction
                            End If
                            'addition end


                        Case CommonFunction.Constants.APP_TAG_RFI_INITIATOR
                            'Added by TruptiK on 7-Jun-2007
                            If Args.ClientSideFunctionName.ToUpper = "HYPERLINK2" Then

                                Dim strFunction As String = ""


                                strFunction += "if (CurrentStatus==""Draft"") {" + vbCrLf
                                strFunction += "if (ChecklistInstanceID == 0) " + vbCrLf
                                strFunction += "window.open (""../RFI/RFI_RFIChecklist.aspx?FromList=1&SubmitRFI=1&RFIID="" + RFIID,"""",""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 700)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=700,height=500"");" + vbCrLf
                                strFunction += "else " + vbCrLf
                                strFunction += "window.open (""../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Initiator&Comments=CheckList&RFIMode=Submit&MasterTagID=2073&RFIID="" + RFIID,"""",""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 500)/2 + "",top="" + (window.screen.height - 300)/2 + "",width=500,height=300"");" + vbCrLf
                                strFunction += "}" + vbCrLf
                                strFunction += "else " + vbCrLf
                                strFunction += "window.open (""../RFI/RFI_RFIChecklist.aspx?FromList=1&ReSubmit=1&SubmitRFI=1&RFIID="" + RFIID,"""",""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 700)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=700,height=500"");" + vbCrLf
                                strFunction += "return;" + vbCrLf
                                Args.ToBeInserted = strFunction
                            End If
                            'Added by TruptiK on 30-May-2007 to give alert if no rate is defined for any currency.
                            'If Args.ClientSideFunctionName.ToUpper = "COPYRFI" Then
                            '    Dim Strfunction As String

                            '    Dim strSqlQuery As String
                            '    Dim str As String
                            '    Dim objTemplate As WebPages.Template.WhizTemplate
                            '    objTemplate = New WebPages.Template.WhizTemplate

                            '    strSqlQuery = "EXEC usp_Validation_BillingCurrencyConversionRate " + CType(HttpContext.Current.Session("intProjectID"), String) + "," + Args.UniqueID.ToString
                            '    str = CType(CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), ""), ""), String)
                            '    Dim m_strToken As String = CommonFunctions.Security.Token.GetToken(CType(0, String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))
                            '    'Initialize the Resources
                            '    objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                            '    strFunction += "var str='" + str + "';" + vbCrLf
                            '    strFunction += "var token='" + m_strToken + "';" + vbCrLf
                            '    strFunction += "if(str==""NO_IRCOMPANY_BASE_CONVERSRIONRATE"") {" + vbCrLf
                            '    strFunction += "alert('" + objTemplate.GetResourceString("IRCOMPANY_BASE_CONVERSRIONRATE") + "');" + vbCrLf
                            '    strFunction += "return; }" + vbCrLf
                            '    'Commented by TruptiK on 25-Jun-2007
                            '    'Purpose:-To remove Local Currency Validation.
                            '    'strFunction += "if(str==""NO_CORPORATE_LOCAL_CONVERSRIONRATE"")" + vbCrLf
                            '    'strFunction += "{"
                            '    'strFunction += "alert('" + objTemplate.GetResourceString("CORPORATE_LOCAL_CONVERSRIONRATE") + "');" + vbCrLf
                            '    'strFunction += "return; }" + vbCrLf
                            '    'End of commented by TruptiK on 25-Jun-2007 
                            '    strFunction += "if(str==""NO_CORPORATE_BASE_CONVERSRIONRATE"")" + vbCrLf
                            '    strFunction += "{"
                            '    strFunction += "alert('" + objTemplate.GetResourceString("CORPORATE_BASE_CONVERSRIONRATE") + "');" + vbCrLf
                            '    strFunction += "return; }" + vbCrLf
                            '    Args.ToBeInserted = strFunction
                            '    'End of addition by TruptiK on 30-May-2007

                            'End If

                            'added by SachinR   on 27 Aug 2004
                            'purpose    To implement deliverable template publish

                        Case CommonFunction.Constants.APP_TAG_PRACTICE_SELECTION
                            Dim strFunction As String
                            If Args.ClientSideFunctionName.ToUpper = "HYPERLINK1" Then
                                'For this case the client side function called on the link click is written manually for
                                'showing the alert dialog conditionally
                                strFunction = "var intRevisionNo = Number(ProjectRevisionNo);" + vbCrLf
                                strFunction += "intRevisionNo += 1;" + vbCrLf
                                strFunction += "window.open('CommonPage.aspx?FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&Mode=ADD_NEW&MasterTagID=2182&TemplateID='+ ProjectPhaseTaskTemplateID + '&RevisionNo=' + intRevisionNo, '', 'resizable=yes,scrollbars=no,left=' + (window.screen.width - 550)/2 + ',top=' + (window.screen.height - 350)/2 + ',width=550,height=350');" + vbCrLf
                                strFunction += "return;" + vbCrLf
                                Args.ToBeInserted = strFunction

                                'added by SachinR   on 09 Nov 2004
                            ElseIf Args.ClientSideFunctionName.ToUpper = "GETLATEST_ONCLICK" Then
                                ' Modified By NitinVS on 5 March 2005 
                                ' WhizibleE SP2 
                                'strFunction = "alert('This will over write existing template data by modified template data.');" + vbCrLf
                                strfunction = "if (confirm('This will over write existing template data by modified template data.\n Do you want to continue?')== false)" + vbCrLf
                                strfunction += "{return;} "
                                ' End Modification By NitinVS on 5 MArch 2005 
                                ' WhizibleE SP2
                                Args.ToBeInserted = strFunction

                            End If
                            'addition end
                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID
                        'Case CommonFunction.Constants.APP_TAG_TAB_REVIEW_ACTIONS
                    End Select
                End If
            End Sub

            Public Shared Sub Before_ExecutingAction(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As Hashtable = Nothing)
                'This event will occur before executing dynamic action
                Cancel = False

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID
                        Case CommonFunctions.Constants.TAG_ADVANCE_FILTERS
                            Dim strTagID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("TagID"))
                            If strTagID.Trim <> "" Then
                                HttpContext.Current.Session("AdvanceFilter" + strTagID) = ""
                                Args.CommonQueryString += "&RefreshCL=1"
                                Args.SpToExecute = Replace(Args.SpToExecute, "<PAGE_TAGID>", strTagID)

                            End If
                        Case CommonFunction.Constants.APP_TAG_RESOURCES
                            If Args.ClientSideFunctionName.ToLower = "reassign" Then
                                'Reassign the resource
                                Cancel = True
                                Dim lngEmployeeID As Long = CType(CommonFunctions.General.CheckIsNothing(ControlsHashTable("EmployeeID"), "0"), Long)
                                Dim lngRoleID As Long = CType(CommonFunctions.General.CheckIsNothing(ControlsHashTable("Role"), "0"), Long)
                                Call ReassignResource(lngEmployeeID, lngRoleID, ControlsHashTable)
                                'Head Tag
                                HttpContext.Current.Response.Write(CommonFunctions.General.PlotPageHeadTag("", , , , , True))
                                'Send mail 
                                HttpContext.Current.Response.Write(vbCrLf + ReassignResource_SendEmail(lngEmployeeID, lngRoleID))
                                'Refresh and Close the window
                                HttpContext.Current.Response.Write(vbCrLf + "<Script language=javascript>")
                                HttpContext.Current.Response.Write(vbCrLf + "   refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx?MasterTagID=1019',true);")
                                HttpContext.Current.Response.Write(vbCrLf + "</Script>" + vbCrLf)
                            End If
                            '    'Trupti
                            'Case CommonFunction.Constants.APP_TAG_RFI_INITIATOR
                            'If Args.ClientSideFunctionName.ToUpper = "ADD_NEW" Then
                            '    Dim strSqlQuery As String
                            '    Dim drDetails As IDataReader
                            '    Dim str As String
                            '    strSqlQuery = "EXEC usp_Validation_BillingCurrencyConversionRate '" & CType(HttpContext.Current.Session("intProjectID"), String) & "'"
                            '    str = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), ""), String)
                            'End If

                            'End
                            'Added By PrasannaP on 20th May 2004
                        Case CommonFunction.Constants.APP_TAG_BACKDATING_CONFIGURATION
                            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                                Dim strBackDatedEntries As String
                                Dim intProjectID As String
                                Dim intCounter As Integer = 0
                                Dim strSQL As String
                                strSQL = "Update tbl_PM_Project set IsBackDating = 0, IsForwardDating = 0 Where BackDatingEmployeeID = " + CType(HttpContext.Current.Session("intUserID"), String)
                                If Trim(HttpContext.Current.Request.QueryString("PagingAlphabet")) <> "-1" Then
                                    strSQL = strSQL + " AND ProjectCode Like '" + Trim(HttpContext.Current.Request.QueryString("PagingAlphabet")) + "%'"
                                End If
                                CommonFunction.Data.InsertOrUpdateData(strSQL, True)

                                For Each intProjectID In Split(HttpContext.Current.Request.Form("chkDelete"), ",")
                                    If Trim(intProjectID) <> "" Then
                                        CommonFunction.Data.InsertOrUpdateData("Exec usp_Upd_tbl_PM_BackdatingConfiguration " + CType(HttpContext.Current.Session("intUserID"), String) + "," & intProjectID + ", 1, 'Back'", True)
                                    End If
                                Next

                                For Each intProjectID In Split(HttpContext.Current.Request.Form("chkFwd"), ",")
                                    If Trim(intProjectID) <> "" Then
                                        CommonFunction.Data.InsertOrUpdateData("Exec usp_Upd_tbl_PM_BackdatingConfiguration " + CType(HttpContext.Current.Session("intUserID"), String) + "," & intProjectID + ", 1, 'Fwd'", True)
                                    End If
                                Next
                            End If


                            'END ADDITION
                            '------------------Commented Out by AbhijeetD on 25th May 2004---------------
                            '---------for reverting the changes done for Project Creation Workflow------- 
                            'Case CommonFunction.Constants.TAG_PROJECT_INFORMATION
                            '    If Args.ClientSideFunctionName.ToUpper = "SENDFORAPPROVAL" Then
                            '        Dim drStatus As IDataReader
                            '        drStatus = CommonFunction.Data.GetDataReader("usp_Sel_PM_IsProjectSettingComplete " + PrimaryKey, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '        If drStatus.Read Then
                            '            If CType(drStatus("Status"), Boolean) = False Then
                            '                Dim strMessage As String = drStatus("Message").ToString
                            '                strMessage = strMessage.Replace(CommonFunction.Constants.DELIMITER_FOR_HYPERLINK_PARAMETERS, "\r\n")
                            '                CommonFunction.General.WriteHTML("<SCRIPT language='JavaScript'>" + vbCrLf)
                            '                CommonFunction.General.WriteHTML("alert('" + strMessage + "');" + vbCrLf)
                            '                CommonFunction.General.WriteHTML("</SCRIPT>")
                            '                Cancel = True
                            '            End If
                            '        End If
                            '    End If
                            '------------------------Commenting Ends----------------------
                        Case CommonFunction.Constants.APP_TAG_CONFIG_TYPE_SECURITY
                            If Args.ClientSideFunctionName.ToUpper.Trim = "SETACCESS" Then
                                '----Step 1 : Delete the existing Access Mapping for the seleted Project,Role and Paging and filter
                                Dim intProjectID As Long = WhizGlobal.ProjectID
                                Dim strRoleID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("Role"), "0")
                                Dim strPaging As String = CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("PagingAlphabet"), "-1"))
                                Dim strType As String = CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("Type")))
                                Call CommonFunctions.Data.InsertOrUpdateData("usp_del_tbl_ib_typerolesecurity " + intProjectID.ToString + "," + strRoleID + ",'" + strPaging + "','" + strType + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                '-----Step 2 : One by one insert the Access entries for the Project, Role, type and Status mapping
                                Dim strDeletionIDArray As String() = Split(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")), ",")
                                Dim intIndex As Integer
                                Dim intUBound As Integer = strDeletionIDArray.GetUpperBound(0)
                                Dim strResult As String
                                If intUBound = 0 And strDeletionIDArray(0).Trim = "" Then
                                    'Remove all access for the selected Filter (Project-Role-Paging-Type)
                                Else
                                    For intIndex = 0 To intUBound
                                        'One by one Set the Access
                                        Call CommonFunctions.Data.InsertOrUpdateData("usp_ins_tbl_ib_typerolesecurity " + intProjectID.ToString + "," + strRoleID + "," + strDeletionIDArray(intIndex), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    Next
                                End If
                            End If

                            'added by SachinR   on 06 Jul 2004
                            'To save the selected root causes for the project
                        Case CommonFunction.Constants.APP_TAG_PROJECT_ROOT_CAUSE
                            If Args.ClientSideFunctionName.ToUpper.Trim = "SAVE_ONCLICK" Then
                                Dim strSP As String
                                'first delete all the entries for current project, then insert new 
                                strSP = "usp_del_tbl_Project_RootCause " + WhizGlobal.ProjectID.ToString + ",'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("PagingAlphabet"), "-1")) + "'"
                                CommonFunctions.Data.InsertOrUpdateData(strSP, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'insert new records for the selected root causes for current project
                                Dim strRootCauses As String() = Split(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")), ",")
                                Dim strRootCauseID As String
                                For Each strRootCauseID In strRootCauses
                                    If strRootCauseID <> "" Then
                                        strSP = "usp_ins_tbl_Project_RootCause " + WhizGlobal.ProjectID.ToString + "," + strRootCauseID.Trim + ",'" + WhizGlobal.UserName + "'"
                                        CommonFunctions.Data.InsertOrUpdateData(strSP, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    End If
                                Next
                                'Set a session variable to indicate the SAVE operation is performed
                                HttpContext.Current.Session("RootCausesSave") = "1"
                            End If

                            'To save the Project Role and custom field mapping for custom field security
                        Case CommonFunction.Constants.APP_TAG_PROJECT_CUSTOM_FIELD_MAINTENANCE
                            '***** Code added by SandipL on 23 Nov 2005
                            If Args.ClientSideFunctionName.ToUpper.Trim = "CLOSE" Then
                                HttpContext.Current.Session.Remove("CustomFieldID")
                            End If
                            '***** End additon by SandipL on 23 Nov 2005
                            If Args.ClientSideFunctionName.ToUpper.Trim = "SAVE_ONCLICK" Then
                                Dim strUniqueID As String
                                strUniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("CustomFieldID"))
                                '***** Code added by SandipL on 23 Nov 2005
                                If strUniqueID = "" Then
                                    strUniqueID = CType(HttpContext.Current.Session("CustomFieldID"), String)
                                End If
                                '***** End additon by SandipL on 23 Nov 2005
                                If CommonFunctions.General.CheckIsNothing(strUniqueID, "") <> "" Then
                                    ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                    ''Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("CustomFieldID", "CustomFieldID", , , , strUniqueID.Trim, , , , , , True, , True)
                                    Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("CustomFieldID", "CustomFieldID", , , , strUniqueID.Trim, , , , , , True, , True, EnableHTMLEncode:=True)
                                End If
                                Dim strSP As String
                                Dim strCustomFieldID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("CustomFieldID"), "")
                                '***** Code added by SandipL on 23 Nov 2005
                                If strCustomFieldID = "" Then
                                    strCustomFieldID = CType(HttpContext.Current.Session("CustomFieldID"), String)
                                End If
                                '***** End additon by SandipL on 23 Nov 2005
                                'first delete all the entries for current project and custom field ID, then insert new 
                                strSP = "usp_del_tbl_IB_RoleCustomFieldSecurity " + WhizGlobal.ProjectID.ToString + "," + strCustomFieldID.Trim + ",'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("PagingAlphabet"), "-1")) + "'"
                                CommonFunctions.Data.InsertOrUpdateData(strSP, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'insert new records for the selected custom field for current project and RoleIDs
                                Dim strRoles As String() = Split(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")), ",")
                                Dim strRoleID As String
                                For Each strRoleID In strRoles
                                    If strRoleID <> "" Then
                                        strSP = "usp_ins_tbl_IB_RoleCustomFieldSecurity " + WhizGlobal.ProjectID.ToString + "," + strCustomFieldID.Trim + "," + strRoleID.Trim
                                        CommonFunctions.Data.InsertOrUpdateData(strSP, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    End If
                                Next
                            End If
                            'addition end

                            '***** Code added by SandipL on 19 Jan 2006
                        Case CommonFunction.Constants.APP_TAG_PROJECT_TASK_CUSTOM_FIELD_MAINTENANCE

                            If Args.ClientSideFunctionName.ToUpper.Trim = "CLOSE" Then
                                HttpContext.Current.Session.Remove("CustomFieldID")
                            End If

                            'Added By Bharat T on 30th-Aug-2017 for custom field saving entity name to insert in table
                            Dim strEntityName As String = ""
                            strEntityName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("CustomEntityName"))
                            'End of Added By Bharat T on 30th-Aug-2017 for custom field saving entity name to insert in table


                            If Args.ClientSideFunctionName.ToUpper.Trim = "SAVE_ONCLICK" Then
                                Dim strUniqueID As String
                                strUniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("CustomFieldID"))
                                If strUniqueID = "" Then
                                    strUniqueID = CType(HttpContext.Current.Session("CustomFieldID"), String)
                                End If
                                If CommonFunctions.General.CheckIsNothing(strUniqueID, "") <> "" Then
                                    ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                    ''Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("CustomFieldID", "CustomFieldID", , , , strUniqueID.Trim, , , , , , True, , True)
                                    Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("CustomFieldID", "CustomFieldID", , , , strUniqueID.Trim, , , , , , True, , True, EnableHTMLEncode:=True)
                                End If
                                Dim strSP As String
                                Dim strCustomFieldID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("CustomFieldID"), "")
                                If strCustomFieldID = "" Then
                                    strCustomFieldID = CType(HttpContext.Current.Session("CustomFieldID"), String)
                                End If
                                'first delete all the entries for current project and custom field ID, then insert new                                 

                                'Added By Bharat T on 30th-Aug-2017 for custom field saving entity name to insert in table
                                'strSP = "usp_del_tbl_PM_RoleCustomFieldSecurity " + WhizGlobal.ProjectID.ToString + "," + strCustomFieldID.Trim + ",'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("PagingAlphabet"), "-1")) + "'"
                                strSP = "usp_del_tbl_PM_RoleCustomFieldSecurity " & WhizGlobal.ProjectID.ToString & "," & strCustomFieldID.Trim & ",'" & CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("PagingAlphabet"), "-1")) & "','" & strEntityName & "'"
                                'End of Added By Bharat T on 30th-Aug-2017 for custom field saving entity name to insert in table

                                CommonFunctions.Data.InsertOrUpdateData(strSP, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'insert new records for the selected custom field for current project and RoleIDs
                                Dim strRoles As String() = Split(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")), ",")
                                Dim strRoleID As String
                                For Each strRoleID In strRoles
                                    If strRoleID <> "" Then                                        
                                        'Added By Bharat T on 30th-Aug-2017 for custom field saving entity name to insert in table
                                        'strSP = "usp_ins_tbl_PM_RoleCustomFieldSecurity " + WhizGlobal.ProjectID.ToString + "," + strCustomFieldID.Trim + "," + strRoleID.Trim
                                        strSP = "usp_ins_tbl_PM_RoleCustomFieldSecurity " & WhizGlobal.ProjectID.ToString & "," & strCustomFieldID.Trim & "," & strRoleID.Trim & ",'" & strEntityName & "'"
                                        'End of Added By Bharat T on 30th-Aug-2017 for custom field saving entity name to insert in table

                                        CommonFunctions.Data.InsertOrUpdateData(strSP, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    End If
                                Next
                            End If
                            '***** End additon by SandipL on 19 Jan 2006

                            'added by SachinR   on 15 Jul 2004
                        Case CommonFunction.Constants.APP_TAG_SDLC_PROCESS
                            If Args.ClientSideFunctionName.ToLower = "listsave" Then
                                Cancel = True
                                '_____________IS PERFORMED
                                'Step 1 : remove the values
                                Dim strProjectID As String = WhizGlobal.ProjectID.ToString
                                Dim strProcessID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("ProcessID"), "0")
                                Dim strPaging As String = CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("PagingAlphabet"), "-1"))
                                Dim strSQL As String = "usp_Upd_tbl_PRS_Project_SDLC_IsPerformed null," + strProjectID + "," + strProcessID + ",'" + CommonFunction.General.BuildQueryString(strPaging) + "'"
                                Call CommonFunctions.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'Step 2 : set the values
                                Dim strIsPerformedIDArray As String() = Split(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("IsPerformed")), ",")
                                Dim intIndex As Integer
                                Dim intUBound As Integer = strIsPerformedIDArray.GetUpperBound(0)
                                If intUBound = 0 And strIsPerformedIDArray(0).Trim = "" Then
                                    'Remove all values
                                Else
                                    For intIndex = 0 To intUBound
                                        'One by one Set the Is Performed Values
                                        strSQL = "usp_Upd_tbl_PRS_Project_SDLC_IsPerformed " + strIsPerformedIDArray(intIndex)
                                        Call CommonFunctions.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    Next
                                End If
                                '_____________IS REQUIRED
                                'Step 1 : remove the values
                                strSQL = "usp_Upd_tbl_PRS_Project_SDLC_IsRequired null," + strProjectID + "," + strProcessID + ",'" + CommonFunction.General.BuildQueryString(strPaging) + "'"
                                Call CommonFunctions.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'Step 2 : set the values
                                Dim strIsRequiredIDArray As String() = Split(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("IsRequired")), ",")
                                intUBound = strIsRequiredIDArray.GetUpperBound(0)
                                If intUBound = 0 And strIsRequiredIDArray(0).Trim = "" Then
                                    'Remove all values
                                Else
                                    For intIndex = 0 To intUBound
                                        'One by one Set the Is Required Values
                                        strSQL = "usp_Upd_tbl_PRS_Project_SDLC_IsRequired " + strIsRequiredIDArray(intIndex)
                                        Call CommonFunctions.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    Next
                                End If
                            End If
                            'addition end

                            'Added by ShamkantD on 29th July 2004 - added to save Work Order Fields selection
                        Case CommonFunction.Constants.APP_TAG_CONFIG_WORKORDER_FIELD_ACCESS
                            If Args.ClientSideFunctionName.ToUpper.Trim = "SAVE_ONCLICK" Then
                                Dim intProjectID As String
                                Dim strSQL As String
                                Dim strAttributeID As String
                                Dim intRoleID As String

                                strAttributeID = ""
                                intRoleID = HttpContext.Current.Request.Form("RoleID")
                                For Each intProjectID In Split(HttpContext.Current.Request.Form("chkDelete"), ",")
                                    If Trim(intProjectID) <> "" Then
                                        strAttributeID += intProjectID + ","
                                    End If
                                Next

                                If Trim(strAttributeID) <> "" Then
                                    strSQL = "Exec usp_Upd_tbl_PM_WOUserAccess '" + strAttributeID + "'," + intRoleID + ",1"
                                End If
                                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                Cancel = True
                            End If
                            'End of addition - ShamkantD on 29th July 2004 
                            'Added By NIleshD On 31 July 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_SALES_PERSON
                            If Args.ClientSideFunctionName.ToUpper = "SELECT" Then
                                'Code Commented by SandipL on 7 Dec 2005 -- To solve Issue of IR/PIR (Done through XMLHttp
                                'Dim strIsRequiredIDArray As String() = Split(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")), ",")
                                'Dim drSalesPerson As IDataReader
                                'Dim strSalesPersons As String
                                'Dim strSQL As String
                                'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")) <> "" Then
                                '    'change from employeename to username for IssueID 12487
                                '    strsql = "SELECT UserName from v_tbl_PM_Project_SalesPersons WHERE SalesPersonID in (" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")) + ") AND ProjectID = " + WhizGlobal.ProjectID.ToString
                                '    drSalesPerson = CommonFunction.Data.GetDataReader(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                '    strSalesPersons = ""
                                '    While drSalesPerson.Read
                                '        strSalesPersons += drSalesPerson("UserName").ToString + ","
                                '    End While

                                '    ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                '    CommonFunction.Data.DisposeDataReader(drSalesPerson)
                                '    ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                '    strSalesPersons = strSalesPersons.Remove(strSalesPersons.Length - 1, 1)
                                '    CommonFunction.General.WriteHTML("<Script language=javascript >")
                                '    CommonFunction.General.WriteHTML("opener.frmRFI_RFI.txtRFISalesPersonIDs.value=""" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")) + """;")
                                '    CommonFunction.General.WriteHTML("opener.frmRFI_RFI.txtRFISalesPersonNames.value=""" + strSalesPersons + """;")
                                '    CommonFunction.General.WriteHTML("window.close();")
                                '    CommonFunction.General.WriteHTML("</Script>")
                                'Else
                                '    CommonFunction.General.WriteHTML("<Script language=javascript >")
                                '    CommonFunction.General.WriteHTML("opener.frmRFI_RFI.txtRFISalesPersonIDs.value="""";")
                                '    CommonFunction.General.WriteHTML("opener.frmRFI_RFI.txtRFISalesPersonNames.value="""";")
                                '    CommonFunction.General.WriteHTML("window.close();")
                                '    CommonFunction.General.WriteHTML("</Script>")
                                'End If

                                'End Commenting by SandipL on 7 Dec 2005
                                Cancel = True
                            End If
                        Case CommonFunction.Constants.APP_TAG_RFI_OS
                            If Args.ClientSideFunctionName.ToUpper = "SELECT" Then
                                'Code Commented by SandipL on 7 Dec 2005 -- To solve Issue of IR/PIR (Done through XMLHttp

                                'Dim strIsRequiredIDArray As String() = Split(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")), ",")
                                'Dim drOS As IDataReader
                                'Dim strOSs As String
                                'Dim strSQL As String
                                'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")) <> "" Then
                                '    strsql = "SELECT OS from v_tbl_IB_Project_OS WHERE ProjectOSID in (" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")) + ")"
                                '    drOS = CommonFunction.Data.GetDataReader(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                '    strOSs = ""
                                '    While drOS.Read
                                '        strOSs += drOS("OS").ToString + ","
                                '    End While
                                '    ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                '    CommonFunction.Data.DisposeDataReader(drOS)
                                '    ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                '    strOSs = strOSs.Remove(strOSs.Length - 1, 1)
                                '    CommonFunction.General.WriteHTML("<Script language=javascript >")
                                '    CommonFunction.General.WriteHTML("opener.frmRFI_RFI.txtRFIOSIDs.value=""" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")) + """;")
                                '    CommonFunction.General.WriteHTML("opener.frmRFI_RFI.txtRFIOSNames.value=""" + strOSs + """;")
                                '    CommonFunction.General.WriteHTML("window.close();")
                                '    CommonFunction.General.WriteHTML("</Script>")

                                'Else
                                '    CommonFunction.General.WriteHTML("<Script language=javascript >")
                                '    CommonFunction.General.WriteHTML("opener.frmRFI_RFI.txtRFIOSIDs.value="""";")
                                '    CommonFunction.General.WriteHTML("opener.frmRFI_RFI.txtRFIOSNames.value="""";")
                                '    CommonFunction.General.WriteHTML("window.close();")
                                '    CommonFunction.General.WriteHTML("</Script>")
                                'End If

                                'End Commenting by SandipL on 7 Dec 2005
                                Cancel = True
                            End If

                            '--------------------------------------------------------------------------------------
                            'Integrated by SavitaS on 13 Mar 2006 for IssueID-2836 (For RFI Milestone and RFI Deliverable Pages.)
                            'Added By GaneshG on 11 Jan 2006 --To show Save link on RFI Deliverable page.
                        Case CommonFunction.Constants.APP_TAG_RFI_DELIVERABLES
                            If Args.ClientSideFunctionName.ToUpper = "SAVE" Then
                                'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                                Dim m_strToken As String
                                Dim strFunction As String
                                m_strToken = HttpContext.Current.Request.QueryString("PKToken").ToString
                                If CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String), m_strToken) = False Then
                                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("IR/PIR", CType(2044, Long), CType(0, Long), "RFIID", HttpContext.Current.Request.QueryString("RFIID").ToString)

                                    'Token is Invalid now redirect to the Invalid Access Page
                                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                                Else
                                    'End of addition
                                    Dim strRequiredIDArray As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"))
                                    Dim strSQL As String
                                    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")) <> "" Then
                                        strSQL = "usp_ins_tbl_PM_RFI_ItemswithDeliverable " + HttpContext.Current.Request.QueryString("RFIID") + ", '" + strRequiredIDArray + "'"
                                        CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        strSQL = ""
                                        'End of addition by TruptiK on 30-May-2007
                                    End If
                                End If
                                Cancel = True
                            End If
                            'End of Addition 

                            'Added By Mohit S On 3rd Jan 2006
                        Case CommonFunction.Constants.APP_TAG_RFI_MILESTONE '3084 
                            If Args.ClientSideFunctionName.ToUpper = "SAVE" Then
                                'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                                Dim m_strToken As String
                                m_strToken = HttpContext.Current.Request.QueryString("PKToken").ToString
                                If CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String), m_strToken) = False Then
                                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("IR/PIR", CType(2044, Long), CType(0, Long), "RFIID", HttpContext.Current.Request.QueryString("RFIID").ToString)

                                    'Token is Invalid now redirect to the Invalid Access Page
                                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                                Else
                                    'Dim strRequiredIDArray() As String = Split(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")), ",")
                                    Dim strRequiredIDArray As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"))
                                    'Dim drTools As IDataReader
                                    'Dim strTools As String
                                    Dim strSQL As String
                                    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")) <> "" Then
                                        'strsql = "SELECT Description from v_tbl_PM_ProjectTools WHERE ProjectToolID in (" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")) + ")"
                                        'strsql = "select MilestoneId from v_tbl_select_milestones WHERE MilestoneID in (" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")) + ")"
                                        'drTools = CommonFunction.Data.GetDataReader(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        'strTools = ""
                                        'While drTools.Read
                                        '    strTools += drTools("Milestoneid").ToString + ","
                                        'End While
                                        'CommonFunction.Data.DisposeDataReader(drTools)

                                        'strTools = strTools.Remove(strTools.Length - 1, 1)
                                        'CommonFunction.General.WriteHTML("<Script language=javascript >")
                                        'CommonFunction.General.WriteHTML("opener.frmRFI_RFI.txtRFIMilestoneIDs.value=""" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")) + """;")
                                        ''CommonFunction.General.WriteHTML("opener.frmRFI_RFI.txtRFIMilestone.value=""" + strTools + """;")
                                        'CommonFunction.General.WriteHTML("window.close();")
                                        'CommonFunction.General.WriteHTML("</Script>")

                                        'Else
                                        '    CommonFunction.General.WriteHTML("<Script language=javascript >")
                                        '    CommonFunction.General.WriteHTML("opener.frmRFI_RFI.txtRFIMilestoneIDs.value="""";")
                                        '    'CommonFunction.General.WriteHTML("opener.frmRFI_RFI.txtRFIMilestone.value="""";")
                                        '    CommonFunction.General.WriteHTML("window.close();")
                                        '    CommonFunction.General.WriteHTML("</Script>")

                                        strSQL = "usp_ins_tbl_PM_RFI_ItemswithMilestone " + HttpContext.Current.Request.QueryString("RFIID") + ", '" + strRequiredIDArray + "'"

                                        'strSQL += "," + strSalesPeriodID.Trim + "," + strCompanyID.Trim
                                        CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                        strSQL = ""

                                        'CommonFunction.General.WriteHTML("<Script language='javascript'>")
                                        'CommonFunction.General.WriteHTML("window.opener.location='../RFI/RFI_RFI.aspx?PKToken=" + m_strToken + "&Mode=New&UserType=Initiator';")
                                        'CommonFunction.General.WriteHTML("window.close();")
                                        'CommonFunction.General.WriteHTML("</Script>")

                                    End If
                                    Cancel = True
                                End If

                                'End Of addition MohitS
                                'End Integration by SavitaS on 13 Mar 2006
                                '--------------------------------------------------------------------------------------
                            End If
                        Case CommonFunction.Constants.APP_TAG_RFI_TOOL
                            If Args.ClientSideFunctionName.ToUpper = "SELECT" Then
                                'Code Commented by SandipL on 7 Dec 2005 -- To solve Issue of IR/PIR (Done through XMLHttp

                                'Dim strIsRequiredIDArray As String() = Split(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")), ",")
                                'Dim drTools As IDataReader
                                'Dim strTools As String
                                'Dim strSQL As String
                                'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")) <> "" Then
                                '    strsql = "SELECT Description from v_tbl_PM_ProjectTools WHERE ProjectToolID in (" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")) + ")"
                                '    drTools = CommonFunction.Data.GetDataReader(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                '    strTools = ""
                                '    While drTools.Read
                                '        strTools += drTools("Description").ToString + ","
                                '    End While
                                '    ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                '    CommonFunction.Data.DisposeDataReader(drTools)
                                '    ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                '    strTools = strTools.Remove(strTools.Length - 1, 1)
                                '    CommonFunction.General.WriteHTML("<Script language=javascript >")
                                '    CommonFunction.General.WriteHTML("opener.frmRFI_RFI.txtRFIToolIDs.value=""" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")) + """;")
                                '    CommonFunction.General.WriteHTML("opener.frmRFI_RFI.txtRFIToolNames.value=""" + strTools + """;")
                                '    CommonFunction.General.WriteHTML("window.close();")
                                '    CommonFunction.General.WriteHTML("</Script>")
                                'Else
                                '    CommonFunction.General.WriteHTML("<Script language=javascript >")
                                '    CommonFunction.General.WriteHTML("opener.frmRFI_RFI.txtRFIToolIDs.value="""";")
                                '    CommonFunction.General.WriteHTML("opener.frmRFI_RFI.txtRFIToolNames.value="""";")
                                '    CommonFunction.General.WriteHTML("window.close();")
                                '    CommonFunction.General.WriteHTML("</Script>")
                                'End If

                                'End Commenting by SandipL on 7 Dec 2005
                                Cancel = True
                            End If
                            'End OF Addition

                            'added by SachinR   on 3 aug 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_SOFTEX_BATCH_GENERATION_PERIOD, CommonFunction.Constants.APP_TAG_RFI_SOFTEX_BATCH_GENERATION_DATES
                            If Args.ClientSideFunctionName.ToUpper = "GENERATERTF" Or Args.ClientSideFunctionName.ToUpper = "GENERATEPDF" Then
                                Dim strCustomerID As String
                                Dim strContractID As String
                                Dim strSalesPeriodID As String
                                Dim strCompanyID As String
                                Dim strSQL As String
                                Dim objDr As IDataReader
                                Dim strStartDate As String
                                Dim strEndDate As String
                                Dim blnFormGenerated As Boolean = False
                                Dim objTemplate As WebPages.Template.WhizTemplate

                                strSQL = "usp_Sel_tbl_PM_RFIInvoices_BatchSoftexGeneration "
                                If WhizGlobal.TagID = CommonFunction.Constants.APP_TAG_RFI_SOFTEX_BATCH_GENERATION_PERIOD Then
                                    strSalesPeriodID = HttpContext.Current.Request.Form("SalesPeriodID") + ""
                                    strSQL += strSalesPeriodID.Trim
                                Else
                                    'CommonFunction.Constants.APP_TAG_RFI_SOFTEX_BATCH_GENERATION_DATES
                                    strStartDate = HttpContext.Current.Request.Form("StartDate") + ""
                                    strEndDate = HttpContext.Current.Request.Form("EndDate") + ""
                                    strSQL += "NULL,'" + strStartDate.Trim + "','" + strEndDate.Trim + "'"
                                End If

                                objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                While objDr.Read
                                    strCustomerID = CommonFunction.Data.CheckIsDBNull(objDr("CustomerID"), "").ToString
                                    strSalesPeriodID = CommonFunction.Data.CheckIsDBNull(objDr("SalesPeriodID"), "").ToString
                                    strContractID = CommonFunction.Data.CheckIsDBNull(objDr("ContractID"), "").ToString
                                    strCompanyID = CommonFunction.Data.CheckIsDBNull(objDr("CompanyID"), "").ToString

                                    strSQL = "usp_tbl_PM_SoftexMaster_AddOrEdit "
                                    strSQL += strCustomerID.Trim + "," + strContractID.Trim
                                    strSQL += "," + strSalesPeriodID.Trim + "," + strCompanyID.Trim
                                    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    blnFormGenerated = True
                                End While
                                CommonFunction.Data.DisposeDataReader(objDr)

                                If blnFormGenerated = False Then
                                    objTemplate = New WebPages.Template.WhizTemplate
                                    objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                    Dim strMsg As String = objTemplate.GetResourceString("NO_SOFTEX_GENERATED") + ""
                                    CommonFunction.General.WriteHTML("<Script language=javascript >")
                                    CommonFunction.General.WriteHTML("alert('" + strMsg.Trim + "');")
                                    CommonFunction.General.WriteHTML("</Script>")
                                    objTemplate = Nothing
                                End If

                            End If
                            Cancel = True
                            'addition end

                            'Added by ShamkantD on 10th August 2004
                        Case CommonFunction.Constants.APP_TAG_PM_SERVICE_SEGMENTATION, CommonFunction.Constants.APP_TAG_PM_MARKET_SEGMENTATION
                            If Args.ClientSideFunctionName.ToUpper.Trim = "SAVE_ONCLICK" Then
                                Dim intProjectID As String
                                Dim intServiceMarketID As String
                                Dim strSQL As String

                                intProjectID = HttpContext.Current.Session("intProjectID").ToString
                                intServiceMarketID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT ServiceMarketID FROM tbl_PM_ServiceMarketMapping WHERE ProjectID = " & intProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))).ToString
                                If intServiceMarketID = "" Then
                                    intServiceMarketID = "Null"
                                End If

                                If WhizGlobal.TagID = CommonFunction.Constants.APP_TAG_PM_MARKET_SEGMENTATION Then
                                    strSQL = "EXEC usp_Ins_tbl_pm_ServiceMarketMapping " & intServiceMarketID
                                    strSQL += "," & intProjectID & ",'" & HttpContext.Current.Request.Form("txtHidden") & "','Market'"

                                Else
                                    strSQL = "EXEC usp_Ins_tbl_pm_ServiceMarketMapping " & intServiceMarketID
                                    strSQL += "," & intProjectID & ",'" & HttpContext.Current.Request.Form("txtHidden") & "','Services'"
                                End If



                                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                Cancel = True
                            End If
                            'Code commented by SandipL on 8 Dec 2005 -- Done through Before Link Print event (single Comment)

                            'Case CommonFunction.Constants.APP_TAG_RFI_SENDINVOICEMAILS
                            '    If Args.ClientSideFunctionName.ToUpper.Trim = "SENDEMAIL" Then
                            '        Dim strIsRequiredIDArray As String() = Split(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")), ",")
                            '        Dim lngCustomerID As Long
                            '        Dim lngCompanyID As Long
                            '        Dim strSQL As String
                            '        'Get the Customer ID and Company ID From the Filter Settings
                            '        '  Apply the Project filter.
                            '        strSQL = "usp_sel_tbl_UI_EmployeeFiletrsetting " + CommonFunction.Constants.APP_TAG_RFI_SENDINVOICEMAILS.ToString + ",'" + WhizGlobal.LoginType + "'," + WhizGlobal.UserID.ToString + ",'CustomerID'"
                            '        lngCustomerID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Long)
                            '        strsql = "usp_sel_tbl_UI_EmployeeFiletrsetting " + CommonFunction.Constants.APP_TAG_RFI_SENDINVOICEMAILS.ToString + ",'" + WhizGlobal.LoginType + "'," + WhizGlobal.UserID.ToString + ",'CompanyID'"
                            '        lngCompanyID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Long)
                            '        ''If lngCustomerID <> 0 And lngCompanyID <> 0 Then
                            '        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")) <> "" Then
                            '            Dim strInvoiceIDs As String
                            '            strInvoiceIDs = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"))
                            '            CommonFunction.General.WriteHTML("<Script language=javascript >")
                            '            CommonFunction.General.WriteHTML("window.open('../General/SendEmail_Attatchment.aspx?MessageID=57&CustomerID=" + lngCustomerID.ToString + "&CompanyID=" + lngCompanyID.ToString + "&INVOICEID=" + strInvoiceIDs + "',null,'status=no,toolbar=no,menubar=no,width=600,height=500');" + vbCrLf)
                            '            CommonFunction.General.WriteHTML("</Script>")
                            '            ''Else
                            '            ''    Dim objAppResource As WebPages.Template.WhizTemplate
                            '            ''    objAppResource = New WebPages.Template.WhizTemplate
                            '            ''    objAppResource.InitializeResources("AppResources.EventHandlers", "AppResources")
                            '            ''    CommonFunction.General.WriteHTML("<Script language=javascript >")
                            '            ''    CommonFunction.General.WriteHTML("alert('" + objAppResource.GetResourceString("MSG_SELECT_INVOICE") + "');" + vbCrLf)
                            '            ''    CommonFunction.General.WriteHTML("</Script>")
                            '            ''    objAppResource = Nothing
                            '        End If
                            '        ''Else
                            '        ''Dim objAppResource As WebPages.Template.WhizTemplate
                            '        ''objAppResource = New WebPages.Template.WhizTemplate
                            '        ''objAppResource.InitializeResources("AppResources.EventHandlers", "AppResources")

                            '        ''If lngCustomerID = 0 Then
                            '        ''    CommonFunction.General.WriteHTML("<Script language=javascript >")
                            '        ''    CommonFunction.General.WriteHTML("alert('" + objAppResource.GetResourceString("MSG_RFI_CUST_BLANK") + "');" + vbCrLf)
                            '        ''    CommonFunction.General.WriteHTML("</Script>")
                            '        ''End If
                            '        ''If lngCompanyID = 0 Then
                            '        ''    CommonFunction.General.WriteHTML("<Script language=javascript >")
                            '        ''    CommonFunction.General.WriteHTML("alert('" + objAppResource.GetResourceString("MSG_RFI_COMP_BLANK") + "');" + vbCrLf)
                            '        ''    CommonFunction.General.WriteHTML("</Script>")
                            '        ''End If
                            '        ''objAppResource = Nothing
                            '        ''End If
                            '        Cancel = True

                            '    End If

                            'End of addition - ShamkantD on 10th August 2004 

                            'End Commenting by SandipL on 8 Dec 2005

                            'added by SachinR   on 26 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_SELECT_TEMPLATE
                            'get the selected template from the process level to project level
                            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                                Dim strSQL As String
                                Dim strTemplateID As String
                                Dim strTemplateIDList As String

                                'get the selected template ID's
                                strTemplateIDList = HttpContext.Current.Request.Form("chkDelete") + ""
                                If strTemplateIDList <> "" Then
                                    Dim strarrTemplateID() As String = strTemplateIDList.Split(","c)
                                    For Each strTemplateID In strarrTemplateID
                                        If strTemplateID <> "" Then
                                            strSQL = "usp_Ins_Project_SelectDeliverableTemplate " + WhizGlobal.ProjectID.ToString
                                            strSQL += "," + strTemplateID.Trim + ",'" + WhizGlobal.UserName.Trim + "'"
                                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        End If
                                    Next
                                End If

                            End If
                            'addition end
                            'added by SachinR   on 15 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_ADD_PROCESS_TO_OU
                            'here selected process are mapped to the OUPoolID which is passed by query string and
                            'kept in hidden control
                            Dim strOUPoolID As String
                            Dim strProcessID As String
                            Dim strProcessIDList() As String
                            Dim strSQL As String

                            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then

                                strOUPoolID = HttpContext.Current.Request.Form("txtOUPoolID") + ""
                                strProcessID = HttpContext.Current.Request.Form("chkDelete") + ""

                                If strProcessID <> "" Then
                                    strProcessIDList = strProcessID.Split(","c)
                                    For Each strProcessID In strProcessIDList
                                        If strProcessID <> "" Then
                                            strSQL = "usp_Ins_tbl_PRS_Process_Draft_AddToOU " + strProcessID.Trim + "," + strOUPoolID.Trim
                                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                        End If
                                    Next

                                    'refresh parent page
                                    CommonFunction.General.WriteHTML("<Script language=javascript >")
                                    CommonFunction.General.WriteHTML("window.opener.location='CommonList.aspx?FromWhere=PRO&MasterTagId=1040&OUPoolID=" + strOUPoolID.Trim + "';")
                                    CommonFunction.General.WriteHTML("</Script>")
                                End If

                                Cancel = True
                            End If
                            'addition end
                            'added by SachinR   on 17 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_ADD_METRIC_TO_OU
                            'here selected Metrics are mapped to the OUPoolID which is passed by query string and
                            'kept in hidden control
                            Dim strOUPoolID As String
                            Dim strMetricID As String
                            Dim strMetricIDList() As String
                            Dim strSQL As String

                            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then

                                strOUPoolID = HttpContext.Current.Request.Form("txtOUPoolID") + ""
                                strMetricID = HttpContext.Current.Request.Form("chkDelete") + ""

                                If strMetricID <> "" Then
                                    strMetricIDList = strMetricID.Split(","c)
                                    For Each strMetricID In strMetricIDList
                                        If strMetricID <> "" Then
                                            strSQL = "usp_Ins_tbl_PRS_MetricMaster_AddToOU " + strMetricID.Trim + "," + strOUPoolID.Trim + ",'" + WhizGlobal.UserName.Trim + "'"
                                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                        End If
                                    Next

                                    'refresh parent page
                                    CommonFunction.General.WriteHTML("<Script language=javascript >")
                                    CommonFunction.General.WriteHTML("window.opener.location='CommonList.aspx?FromWhere=PRO&MasterTagId=676&OUPoolID=" + strOUPoolID.Trim + "';")
                                    CommonFunction.General.WriteHTML("</Script>")
                                End If

                                Cancel = True
                            End If

                        Case CommonFunction.Constants.APP_TAG_ADD_PMI_TO_OU
                            'here selected PMIs are mapped to the OUPoolID which is passed by query string and
                            'kept in hidden control
                            Dim strOUPoolID As String
                            Dim strPMIID As String
                            Dim strPMIIDList() As String
                            Dim strSQL As String

                            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then

                                strOUPoolID = HttpContext.Current.Request.Form("txtOUPoolID") + ""
                                strPMIID = HttpContext.Current.Request.Form("chkDelete") + ""

                                If strPMIID <> "" Then
                                    strPMIIDList = strPMIID.Split(","c)
                                    For Each strPMIID In strPMIIDList
                                        If strPMIID <> "" Then
                                            strSQL = "usp_Ins_tbl_PRS_PMIMaster_AddToOU " + strPMIID.Trim + "," + strOUPoolID.Trim + ",'" + WhizGlobal.UserName.Trim + "'"
                                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                        End If
                                    Next

                                    'refresh parent page
                                    CommonFunction.General.WriteHTML("<Script language=javascript >")
                                    CommonFunction.General.WriteHTML("window.opener.location='CommonList.aspx?FromWhere=PRO&MasterTagId=1020&OUPoolID=" + strOUPoolID.Trim + "';")
                                    CommonFunction.General.WriteHTML("</Script>")
                                End If

                                Cancel = True
                            End If
                            'addition end

                            'added by SachinR   on 20 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLETYPE_RESOURCE_ACCESS
                            'delete the previous mapping of deliverable type and resource mapping records
                            'for the current ScheduleTypeID and projectID 
                            'Then insert records for new resources selected
                            Dim strSQL As String
                            Dim strScheduleTypeID As String
                            strScheduleTypeID = HttpContext.Current.Request.QueryString("ScheduleTypeID") + ""

                            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                                Dim strMappingIDList As String

                                If strScheduleTypeID <> "" Then
                                    strMappingIDList = HttpContext.Current.Request.Form("chkDelete") + ""

                                    strSQL = "usp_Del_tbl_PM_DeliverableType_RoleMapping " + WhizGlobal.ProjectID.ToString + "," + strScheduleTypeID.Trim
                                    If strMappingIDList <> "" And strMappingIDList <> "," Then
                                        strSQL += ",'" + strMappingIDList + "'"
                                    End If
                                    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    Cancel = True
                                End If
                            ElseIf Args.ClientSideFunctionName.ToUpper = "REFRESH_ONCLICK" Then

                                If strScheduleTypeID <> "" Then
                                    strSQL = "usp_Ins_tbl_PM_DeliverableType_RoleMapping_Refresh " + WhizGlobal.ProjectID.ToString + "," + strScheduleTypeID.Trim + ",'" + WhizGlobal.UserName.Trim + "'"
                                    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                End If
                            End If
                            'addition end
                        Case CommonFunction.Constants.APP_TAG_TASK_TYPE_MAINTENANCE_PM
                            'Added by DipaliS 25 Oct 2004
                            'If not called from projects
                            If WhizGlobal.FromWhere.ToUpper <> "PM" Then
                                If Args.LinkName.ToUpper = "SET AS DEFAULT" Then
                                    'integrated by harshada d on 10112005 for SP4.01 hotfixes
                                    'modified by harshada d on 09112005 for Directions Help Request ID 53 Error on Global Projects screen 
                                    'Args.SpToExecute = Replace(Args.SpToExecute, WhizGlobal.ProjectID.ToString, HttpContext.Current.Request("ProjectID"))
                                    Dim strSQL As String = Args.SpToExecute
                                    Dim m_intIndex As Integer = strSQL.IndexOf(",", 0)
                                    If m_intIndex > 0 Then
                                        Dim strtemp As String = strSQL.Substring(1, m_intIndex)
                                        ' this will replace whole SP name and project ID from selected global project 
                                        strSQL = strSQL.Replace(strtemp, "sp_Upd_tbl_PM_Project_TaskTypes_SetDefaultTaskType_New " + HttpContext.Current.Request("ProjectID") + ",")
                                    End If
                                    Args.SpToExecute = strSQL
                                    'end of modification by harshada on 09112005 for Directions Help Request ID 53 Error on Global Projects screen 
                                    'end of integration by harshada d on 10112005 for SP4.01 hotfixes
                                End If
                            End If
                            'End addition by DipaliS

                        Case CommonFunction.Constants.APP_TAG_GLOBAL_GEN_TASKS
                            If Args.ClientSideFunctionName.ToUpper = "SAVE" Then
                                Dim strSQL As String
                                If HttpContext.Current.Request.Form("NonDatabase1") <> "" Then
                                    strSQL = "usp_ins_tbl_PM_OtherTasks_Global " + HttpContext.Current.Request.Form("NonDatabase1") + "," + HttpContext.Current.Request.QueryString("ProjectID")
                                    CommonFunction.Data.InsertOrUpdateData(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    CommonFunction.General.WriteHTML("<Script language=javascript >")
                                    CommonFunction.General.WriteHTML("window.location='CommonList.aspx?MasterTagId=2257&ProjectID=" + HttpContext.Current.Request.QueryString("ProjectID") + "';")
                                    CommonFunction.General.WriteHTML("</Script>")
                                Else
                                    Dim objTemplate As WebPages.Template.WhizTemplate
                                    'Create object of the ProjectByNet Template Class
                                    objTemplate = New WebPages.Template.WhizTemplate
                                    'Initialize the Resources
                                    objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                    CommonFunction.General.WriteHTML("<Script language=javascript >")
                                    CommonFunction.General.WriteHTML("alert('" + objTemplate.GetResourceString("MSG_GEN_MANDATORY") + "');")
                                    CommonFunction.General.WriteHTML("</Script>")
                                    objTemplate = Nothing
                                End If
                                Cancel = True
                            End If

                            '--------------------------------------------------

                            'Code Added by SajiU on 5th Dec 2006
                            '--------------------------------------------------
                        Case CommonFunction.Constants.App_Tag_Login_Maintenance
                            If Args.ClientSideFunctionName.ToUpper = "CREATELOGIN_ONCLICK" Then
                                Cancel = True
                                Dim strChkDelete As String
                                Dim strArrSelect() As String
                                Dim intCount As Integer
                                Dim strSQL As String
                                Dim strResult As Boolean
                                Dim intLoginsCreated As Integer

                                If Not IsNothing(HttpContext.Current.Request.Form("chkDelete")) Then
                                    strChkDelete = HttpContext.Current.Request.Form("chkDelete")
                                    If strChkDelete <> "" Then
                                        strArrSelect = strChkDelete.Split(CType((","), Char))
                                    End If
                                    'Check for Tampering of encrypted date for licensing
                                    Dim intActualUser As Long
                                    Dim intAllowedUser As Long
                                    Dim lngEmployeeID As Long
                                    Dim strLoginName As String
                                    Dim strbuildpassword As String

                                    'If Data is not tampred and logins can be created
                                    'If CheckForTamperingOfData(intAllowedUser, intActualUser) = True Then
                                    'For each employee selected,create the login
                                    For intCount = 0 To strArrSelect.Length - 1
                                        strResult = CreateLogin(CType(strArrSelect(intCount).ToString, Long))
                                        If strResult <> True Then
                                            Exit For
                                        Else

                                            'intLoginsCreated += 1

                                        End If


                                    Next

                                    'End If


                                End If
                                'Cancel = True
                            End If
                            If Args.ClientSideFunctionName.ToUpper = "ACTIVATE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "DEACTIVATE_ONCLICK" Then

                                Dim strChkDelete As String
                                Dim strArrSelect() As String
                                Dim intCount As Integer
                                Dim strSQL As String
                                Dim strResult As Boolean
                                Dim intActiveLogin As Integer

                                If Not IsNothing(HttpContext.Current.Request.Form("chkDelete")) Then
                                    strChkDelete = HttpContext.Current.Request.Form("chkDelete")
                                    If strChkDelete <> "" Then
                                        strArrSelect = strChkDelete.Split(CType((","), Char))
                                    End If
                                    For intCount = 0 To strArrSelect.Length - 1
                                        strResult = ActivateLogin(CType(strArrSelect(intCount).ToString, Long))
                                        If strResult <> True Then
                                            Exit For
                                        Else
                                            intActiveLogin += 1
                                        End If
                                    Next
                                End If
                                Cancel = True
                            End If
                            If Args.ClientSideFunctionName.ToUpper = "RESETPWD_ONCLICK" Then

                                Dim strChkDelete As String
                                Dim strArrSelect() As String
                                Dim intCount As Integer
                                Dim strSQL As String
                                Dim strResult As Boolean
                                Dim intResetPWD As Integer
                                Dim lngEmployeeID As Long
                                Dim strLoginName As String
                                Dim strbuildpassword As String

                                If Not IsNothing(HttpContext.Current.Request.Form("chkDelete")) Then
                                    strChkDelete = HttpContext.Current.Request.Form("chkDelete")
                                    If strChkDelete <> "" Then
                                        strArrSelect = strChkDelete.Split(CType((","), Char))
                                    End If
                                    For intCount = 0 To strArrSelect.Length - 1
                                        strResult = ResetPWD(CType(strArrSelect(intCount).ToString, Long))
                                        If strResult <> True Then
                                            Exit For
                                        Else
                                            intResetPWD += 1
                                        End If

                                        'HttpContext.Current.Response.Write(CommonFunctions.General.PlotPageHeadTag("", , , , , True))
                                        'HttpContext.Current.Response.Write(vbCrLf + SendEmailForNewLogin(lngEmployeeID, strLoginName, strbuildpassword, "E"))
                                        '' Refresh and Close the window
                                        'HttpContext.Current.Response.Write(vbCrLf + "<Script language=javascript>")
                                        'HttpContext.Current.Response.Write(vbCrLf + "   refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx',false);")

                                        'HttpContext.Current.Response.Write(vbCrLf + "</Script>" + vbCrLf)
                                    Next
                                End If

                                Cancel = True
                            End If
                            'End of Addition by SajiU on 5th Dec  2006

                            '--------------------------------------------------
                    End Select
                Else
                    'For Details Tag
                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_TAG_TAB_REVIEW_ACTIONS
                            If Args.ClientSideFunctionName.ToLower = "saveastask" Or Args.ClientSideFunctionName.ToLower = "saveasissue" Then
                                'Review Action
                                If Args.ClientSideFunctionName.ToLower = "saveastask" Then
                                    'Dynamic Action Save as Tasks
                                    Call SaveActionDetails(PrimaryKey, Args.MasterPrimaryKey, ControlsHashTable)
                                    'Task entry
                                    CommonFunction.General.WriteHTML(SaveActionDetailsAsTask(PrimaryKey, ControlsHashTable))
                                ElseIf Args.ClientSideFunctionName.ToLower = "saveasissue" Then
                                    'Dynamic Action Save as Issue
                                    Call SaveActionDetails(PrimaryKey, Args.MasterPrimaryKey, ControlsHashTable)
                                    'Issue entry
                                    CommonFunction.General.WriteHTML(SaveActionDetailsAsIssue(PrimaryKey, ControlsHashTable))
                                End If
                                If Args.Mode = "ADD_NEW" Then
                                    'if ReviewObservationID = 0 then set it as null
                                    If CommonFunction.General.CheckIsNothing(ControlsHashTable("ReviewObservationID")) = "0" Then
                                        'Update the Action table..set ReviewObservationID as null
                                        Dim strSQL As String = "usp_upd_tbl_PM_ReviewActions_ReviewObservationID " + PrimaryKey
                                        CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    Else
                                        'else the Observation is converted as task so close the observation
                                        Dim strSQL As String = "usp_upd_tbl_PM_ReviewObservations_ReviewActionID " + PrimaryKey + "," + CommonFunction.General.CheckIsNothing(ControlsHashTable("ReviewObservationID"))
                                        CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    End If
                                End If

                                Cancel = True
                            End If


                    End Select
                End If
            End Sub

            Public Shared Sub After_ExecutingAction(ByRef Args As EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As Hashtable = Nothing)
                'This event will occur After executing dynamic action

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID
                        ''Code Commented by Manishk on 3rd Jan 06 as new page is added for this 
                        '''Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEAPPLICATION
                        '''    Dim strSQL As String
                        '''    strSQL = "<script language = javascript>"
                        '''    strSQL += "window.open('SendEmail.aspx?MessageID=84&LeaveID=" & PrimaryKey & "',null,'status=no,toolbar=no,menubar=no,width=600,height=500');"
                        '''    strSQL += "</script>"
                        '''    CommonFunction.General.WriteHTML(strSQL)
                        ''End of commented by Manishk on 3rd Jan 2006


                        '''''''''''''''''''Added by Dhanashri S on 29 Oct 2015
                        Case CommonFunctions.Constants.TAG_ADVANCE_FILTERS
                            Dim strTagID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("TagID"))
                            If strTagID.Trim <> "" Then
                                'Refresh Hash Table 
                                Call CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CType(CommonFunction.General.CheckIsNothing(strTagID), Long))
                            End If
                            'With Ref No : WAF3_GEN_3
                        Case CommonFunctions.Constants.MASTER_TAG_CONFIGURATION
                            If (UCase(Args.ClientSideFunctionName) = "COPYTAG_ONCLICK") Then
                                Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
                                Dim strSQL As String = "usp_Sel_tbl_SaaS_UI_TagMaster_Tenant " + PrimaryKey + ",'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("TenantID")) + "'"
                                Dim intNewTagID As Long = CType(CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQL), Long)
                                'Add Tag to hash table
                                CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(intNewTagID)

                                CommonEngines.HashTables.GetHashTableObject.ClearRoleHashTable()
                                Dim strRole As String
                                Dim drRoleID As IDataReader
                                'Loop Start
                                drRoleID = CommonFunction.Data.GetDataReader("usp_SaaS_Sel_tbl_PM_Login_TenantRoles '" + HttpContext.Current.Session("TenantID").ToString + "'", blnUseSQL)
                                While drRoleID.Read()
                                    strRole = CType(drRoleID("RoleID"), String)
                                    'clear the hashtable entries for all the user who have selected role.
                                    CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'R','PRO'," + strRole)
                                End While
                                'Loop End
                                Call CommonFunction.Data.DisposeDataReader(drRoleID)
                                'For Sharepoint navigation schema
                                If CommonFunctions.General.GetFrameworkSettings("GEN_ENABLE_NAVMENU_PANE", "Enabled") = True Then
                                    CommonEngines.HashTables.CreateHashTables.CreateNavMenuNodesHashTable(intNewTagID)
                                    If CommonEngines.HashTables.Culture.GetSupportedCulturIDs.ToString.Trim <> "" Then
                                        CommonEngines.HashTables.CreateHashTables.CreateNavMenuNodesCultureHashTable(CommonEngines.HashTables.Culture.GetSupportedCulturIDs, intNewTagID)
                                    End If
                                End If
                            End If

                            ''''''''''''''''''''End of Addition by Dhanashri S on 29 Oct 2015

                        Case CommonFunction.Constants.APP_TAG_ASSIGNEDRESOURCES
                            Dim strEmployeeids As String
                            Dim strSQL As String
                            'insert selected employees from grid to tbl_PM_ProjectEmployeeRole table
                            If HttpContext.Current.Request.Form("chkdelete") <> Nothing Then
                               
                                'Added by GokulP on 19 May 2010 for SP 1 Resource should not be allocation if Project End Date is less than resource end date
                                Dim strInValidResourcesMessage As String = ""
                                Dim drResourceMessage As IDataReader

                                drResourceMessage = CommonFunction.Data.GetDataReader("Exec usp_Sel_CheckResourceToAssign " + HttpContext.Current.Request.QueryString("RequestID").ToString + ",'" + HttpContext.Current.Request.Form("chkdelete").ToString + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drResourceMessage.Read Then
                                    strEmployeeids = CType(CommonFunctions.Data.CheckIsDBNull(drResourceMessage("ValidEmployeeIDs"), ""), String)
                                    strInValidResourcesMessage = CType(CommonFunctions.Data.CheckIsDBNull(drResourceMessage("EmployeeMessage"), ""), String)
                                End If

                                CommonFunction.Data.DisposeDataReader(drResourceMessage)

                                If strInValidResourcesMessage <> "" Then
                                    strSQL += "<Script language=javascript>" + vbCrLf
                                    strSQL &= "alert('" + strInValidResourcesMessage.ToString + "');" & vbCrLf
                                    strSQL += "</Script>" + vbCrLf
                                End If
                                'End of Addition by GokulP on 19 May 2010 for SP 1 Resource should not be allocation if Project End Date is less than resource end date
                                If strEmployeeids <> "" Then
                                    'Commneted & added by GokulP on 19 May 2010 for SP 1 Resource should not be allocation if Project End Date is less than resource end date
                                    'strSQL = "usp_Ins_tbl_PM_ProjectEmployeeRole_Assigned " + HttpContext.Current.Request.QueryString("RequestID").ToString + ",'" + HttpContext.Current.Request.Form("chkdelete").ToString + "'"
                                    strSQL = "usp_Ins_tbl_PM_ProjectEmployeeRole_Assigned " + HttpContext.Current.Request.QueryString("RequestID").ToString + ",'" + strEmployeeids + "'"
                                    'End of Commnet & Addition by GokulP on 19 May 2010 for SP 1 Resource should not be allocation if Project End Date is less than resource end date
                                    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                End If
                                
                            End If
                        Case CommonFunction.Constants.APP_TAG_RESOURCES
                            If Args.ClientSideFunctionName.ToLower = "release" Then
                                'Release the resource
                                Dim lngProjectEmployeeRoleID As Long = CType(CommonFunctions.General.CheckIsNothing(PrimaryKey, "0"), Long)
                                'Send mail for Release Resource
                                HttpContext.Current.Response.Write(vbCrLf + ReleaseResource_SendEmail(lngProjectEmployeeRoleID))
                            End If

                            'Code added by PrashantD on 19 Jan 2008 for Resource Demand Enhancment
                            'Case CommonFunction.Constants.APP_TAG_RESOURCEREQUEST
                        Case CommonFunction.Constants.APP_TAG_RESOURCEREQUEST
                            If Args.TagID = CommonFunction.Constants.APP_TAG_TAB_ASSIGNEDRESOURCES And _
                                Args.ClientSideFunctionName.Trim().ToUpper() = "ASSIGN_ONCLICK" Then
                                'If Args.TagID = CommonFunction.Constants.APP_TAG_TAB_ASSIGNEDRESOURCES Or CommonFunction.Constants.APP_TAG_TAB_EXTENDASSIGNEDRESOURCES Then
                                '    If Args.ClientSideFunctionName.Trim().ToUpper() = "ASSIGN_ONCLICK" Then
                                Dim strEmployeeIds As String = ""
                                Dim strCheckboxName As String = ""
                                Dim strsql As String = ""
                                Dim strQuery As String = ""
                                Dim strFunction As String
                                Dim m_intRequestID As String
                                Dim strRequiredIDArray As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"))
                                m_intRequestID = HttpContext.Current.Request.QueryString("RequestID").ToString
                                strCheckboxName = "chkDelete" & CommonFunction.Constants.APP_TAG_TAB_ASSIGNEDRESOURCES.ToString()
                                strEmployeeIds = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request(strCheckboxName), "")

                                'Added by GokulP on 19 May 2010 for SP 1 Resource should not be allocation if Project End Date is less than resource end date
                                Dim strInValidResourcesMessage As String = ""
                                Dim drResourceMessage As IDataReader
                                '

                                drResourceMessage = CommonFunction.Data.GetDataReader("Exec usp_Sel_CheckResourceToAssign " + HttpContext.Current.Request.QueryString("RequestID").ToString + ",'" + strEmployeeIds + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drResourceMessage.Read Then
                                    strEmployeeIds = CType(CommonFunctions.Data.CheckIsDBNull(drResourceMessage("ValidEmployeeIDs"), ""), String)
                                    strInValidResourcesMessage = CType(CommonFunctions.Data.CheckIsDBNull(drResourceMessage("EmployeeMessage"), ""), String)
                                End If

                                CommonFunction.Data.DisposeDataReader(drResourceMessage)

                                If strInValidResourcesMessage <> "" Then
                                    strsql += "<Script language=javascript>" + vbCrLf
                                    strsql &= "alert('" + strInValidResourcesMessage.ToString + "');" & vbCrLf
                                    strsql += "</Script>" + vbCrLf
                                End If
                                'End of Addition by GokulP on 19 May 2010 for SP 1 Resource should not be allocation if Project End Date is less than resource end date

                                If strEmployeeIds <> "" Then
                                    strQuery = "usp_Ins_tbl_PM_ProjectEmployeeRole_Assigned " + HttpContext.Current.Request.QueryString("RequestID").ToString + ",'" + strEmployeeIds + "'"
                                    CommonFunction.Data.InsertOrUpdateData(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    'Commented by GokulP on 19 May 2010 for SP 1 Resource should not be allocation if Project End Date is less than resource end date
                                    'End If
                                    'End of Commet by GokulP on 19 May 2010 for SP 1 Resource should not be allocation if Project End Date is less than resource end date
                                    'Added By JayavantK, On - 30-Aug-2004
                                    HttpContext.Current.Session.Item("AssignResource") = 1
                                    'End Addition

                                    'Added by TruptiK on 9-Feb-2008
                                    strsql += "<Script language=javascript>" + vbCrLf
                                    ' "window.open (" + Chr(34) + "../General/SendEmail.aspx?MessageID=12&UserType=" + strUserType + "&UserID=" + lngUserId.ToString + "&LoginName=" + strLoginName + "&Password=" + strPassword + Chr(34) + ",null,""resizable=yes,scrollbars=no,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=600,height=500"");" + vbCrLf
                                    'strsql += "	window.open(""../General/SendEmail.aspx?MessageID=503&RequestID=" & m_intRequestID.ToString()"&EmployeeIDS=" & strEmployeeIds.ToString() & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");" + vbCrLf
                                    'CommonFunctions.General.WriteHTML("window.open('SendEmail.aspx?MessageID=503&RequestID=" & m_intRequestID.ToString() "',null,'status=no,toolbar=no,menubar=no,width=600,height=500');"
                                    'HttpContext.Current.Response.Write(vbCrLf + "   refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx',true);")
                                    'strsql &= vbCrLf + "   refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx',true);" + vbCrLf
                                    'strsql &= " window.opener.opener.location.href=window.opener.opener.location.href;" + vbCrLf
                                    'strsql &= "window.close();" + vbCrLf
                                    strsql &= "window.open(""../General/SendEmail.aspx?MessageID=503&RequestID=" & m_intRequestID.ToString()
                                    strsql &= "&EmployeeIDS=" & "'" & strEmployeeIds.ToString() & "'" & """ ,'',"
                                    strsql &= "'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left='"
                                    strsql &= " + (window.screen.width - 600)/2 + ',top='"
                                    strsql &= " + (window.screen.height - 500)/2 + ',width=600,height=500')" & vbCrLf
                                    strsql += "</Script>" + vbCrLf
                                    'Added by GokulP on 19 May 2010 for SP 1 Resource should not be allocation if Project End Date is less than resource end date
                                End If
                                'End of Addition by GokulP on 19 May 2010 for SP 1 Resource should not be allocation if Project End Date is less than resource end date

                                CommonFunction.General.WriteHTML(strsql)
                            End If
                'End of addition by TruptiK on 9-Feb-2008
                        Case CommonFunction.Constants.APP_TAG_EXTENDRESOURCEREQUEST
                            If Args.TagID = CommonFunction.Constants.APP_TAG_TAB_EXTENDASSIGNEDRESOURCES And _
                                Args.ClientSideFunctionName.Trim().ToUpper() = "ASSIGN_ONCLICK" Then
                                Dim strEmployeeIds As String = ""
                                Dim strCheckboxName As String = ""
                                Dim strQuery As String = ""

                                strCheckboxName = "chkDelete" & CommonFunction.Constants.APP_TAG_TAB_EXTENDASSIGNEDRESOURCES.ToString()
                                strEmployeeIds = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request(strCheckboxName), "")
                                'Added by GokulP on 19 May 2010 for SP 1 Resource should not be allocation if Project End Date is less than resource end date
                                Dim strInValidResourcesMessage As String = ""
                                Dim drResourceMessage As IDataReader
                                Dim strsql As String = ""

                                drResourceMessage = CommonFunction.Data.GetDataReader("Exec usp_Sel_CheckResourceToAssign " + HttpContext.Current.Request.QueryString("RequestID").ToString + ",'" + strEmployeeIds + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drResourceMessage.Read Then
                                    strEmployeeIds = CType(CommonFunctions.Data.CheckIsDBNull(drResourceMessage("ValidEmployeeIDs"), ""), String)
                                    strInValidResourcesMessage = CType(CommonFunctions.Data.CheckIsDBNull(drResourceMessage("EmployeeMessage"), ""), String)
                                End If

                                CommonFunction.Data.DisposeDataReader(drResourceMessage)

                                If strInValidResourcesMessage <> "" Then
                                    strsql += "<Script language=javascript>" + vbCrLf
                                    strsql &= "alert('" + strInValidResourcesMessage.ToString + "');" & vbCrLf
                                    strsql += "</Script>" + vbCrLf
                                End If
                                CommonFunction.General.WriteHTML(strsql)
                                'End of Addition by GokulP on 19 May 2010 for SP 1 Resource should not be allocation if Project End Date is less than resource end date

                                If strEmployeeIds <> "" Then
                                    strQuery = "usp_Ins_tbl_PM_ProjectEmployeeRole_Assigned " + HttpContext.Current.Request.QueryString("RequestID").ToString + ",'" + strEmployeeIds + "'"
                                    CommonFunction.Data.InsertOrUpdateData(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    'Commneted by GokulP on 19 May 2010 for SP 1 Resource should not be allocation if Project End Date is less than resource end date
                                    'End If
                                    'End of Commnet by GokulP on 19 May 2010 for SP 1 Resource should not be allocation if Project End Date is less than resource end date
                                    'Added By JayavantK, On - 30-Aug-2004
                                    HttpContext.Current.Session.Item("AssignResource") = 1
                                    'End Addition
                                    'Added by GokulP on 19 May 2010 for SP 1 Resource should not be allocation if Project End Date is less than resource end date
                                End If
                                'End of Addition by GokulP on 19 May 2010 for SP 1 Resource should not be allocation if Project End Date is less than resource end date
                            End If

                        Case CommonFunction.Constants.APP_TAG_FAST_TRACK_REVIEWS
                            If Args.ClientSideFunctionName.ToUpper = "CLOSEREVIEW" Then
                                Dim strFromEmailID As String = "", strToMailID As String = "", strCCToMailID As String = ""
                                Dim strToEmailID As String = "", strCCToEmailID As String = ""
                                Dim strEmailMessage As String = "", strSubject As String = "", strMessage As String = ""
                                Dim drEmailMessage As IDataReader
                                Dim blnSendEmail As Boolean
                                Dim blnShowPopup As Boolean
                                drEmailMessage = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmailMessages 73", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drEmailMessage.Read Then
                                    blnSendEmail = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("SendMail"), "0"), Boolean)
                                    blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("ShowPopup"), "0"), Boolean)
                                End If

                                ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                CommonFunction.Data.DisposeDataReader(drEmailMessage)
                                ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                If blnShowPopup Then
                                    Dim strScript As String
                                    strScript = "<script language = javascript>"
                                    strScript += "window.open('SendEmail.aspx?MessageID=73&ReviewStatisticsID=" & PrimaryKey & "',null,'status=no,toolbar=no,menubar=no,width=600,height=500');"
                                    strScript += "</script>"
                                    CommonFunction.General.WriteHTML(strScript)
                                Else
                                    CommonFunction.EmailMessages.PMMessages.GetEmailMessage_73(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(PrimaryKey, Long))
                                    CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                                End If

                            End If
                        'Added By Nikhl A On 29.05.2020 For Refresh issue for Softex Form Generation
                        Case CommonFunction.Constants.APP_TAG_RFI_SOFTEX_BATCH_GENERATION_PERIOD
                            Dim strScript As String
                            strScript = "<script language = javascript>"
                            strScript += "window.opener.location.href = '../General/CommonList.aspx?MasterTagID=2082&FromWhere=FA;'"
                            strScript += "</script>"
                            CommonFunction.General.WriteHTML(strScript)
                        Case CommonFunction.Constants.APP_TAG_RFI_SOFTEX_BATCH_GENERATION_DATES
                            Dim strScript As String
                            strScript = "<script language = javascript>"
                            strScript += "window.opener.location.href = '../General/CommonList.aspx?MasterTagID=2082&FromWhere=FA;'"
                            strScript += "</script>"
                            CommonFunction.General.WriteHTML(strScript)
                            'End Of Added By Nikhl A On 29.05.2020 For Refresh issue for Softex Form Generation
                    End Select
                Else
                    'For Details Tag
                    Select Case WhizGlobal.TagID
                        ' Added By JayavantK on 18-Jun-2004 - Start
                        Case CommonFunction.Constants.APP_TAG_TAB_CLOSEREQUEST, CommonFunction.Constants.APP_TAG_TAB_CLOSEEXTENDREQUEST
                            Dim strQuery As String = ""
                            Dim lngRequestId As Long = 0
                            Dim strComments As String = ""
                            Dim strScript As String = ""

                            lngRequestId = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("RequestID"), "0"), Long)
                            strComments = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("CancelComment"), "")
                            strComments = CommonFunctions.General.UnBuildQueryString(strComments)
                            If strComments <> "" Then
                                strQuery = "EXEC usp_Upd_tbl_PM_ResourceRequest_CloseRequest " & lngRequestId.ToString()
                                strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strComments) & "'"
                                CommonFunctions.Data.InsertOrUpdateData(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                strScript = "<Script Language='javascript'>" & vbCrLf
                                strScript &= "var objfrm = GetFormReference('frmCommonPage');" & vbCrLf
                                strScript &= "objfrm.submit();" & vbCrLf
                                strScript &= "</Script>" & vbCrLf
                                CommonFunction.General.WriteHTML(strScript)
                            End If
                            ' Added By JayavantK on 18-Jun-2004 - End
                    End Select
                End If
            End Sub

            Public Shared Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Dim objTemplate As WebPages.Template.WhizTemplate

                Cancel = False
                'This Event will occur before link print
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    If Args.IsListPageLink = True And Args.SystemLinkType = "FILTERS" Then
                        Dim strAdvanceFilter As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("AdvanceFilter" + WhizGlobal.TagID.ToString))
                        If strAdvanceFilter.Trim <> "" Then
                            Args.LinkToolTip = strAdvanceFilter
                            Args.LinkName = "<FONT color='#cc0000'>" + Args.LinkName + "</FONT>"
                        End If
                    End If
                    ' Modified By MahendraV On 24-Nov-2008 for Whiziblesem8.0_Whiz3
                    ' Purpose : to hide back link if all taged page opend from workflow approvals page 
                    ' Start_MV_24-Nov-2008
                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_TAG_SUB_PROJECTS, CommonFunction.Constants.APP_TAG_DELIVERABLES, CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT, CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING, CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS, CommonFunction.Constants.APP_TAG_MODULES, CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT, CommonFunction.Constants.APP_TAG_SUB_PROJECTS
                            If Not HttpContext.Current.Request.QueryString("ForWorkflowFrom") Is Nothing Then
                                If HttpContext.Current.Request.QueryString("ForWorkflowFrom").ToUpper() = "WF" Then
                                    Select Case Args.ClientSideFunctionName.ToUpper 'Args.SystemLinkType.ToUpper.Trim
                                        Case "BACK_ONCLICK"
                                            Cancel = True
                                        Case "SHOW_APPROVALS"
                                            Cancel = True
                                    End Select
                                End If
                            Else
                                If Not HttpContext.Current.Request.Form("txtFromforWF") Is Nothing Then
                                    If CType(HttpContext.Current.Request.Form("txtFromforWF"), String).ToUpper() = "WF" Then
                                        Select Case Args.ClientSideFunctionName.ToUpper  'SystemLinkType.ToUpper.Trim
                                            Case "BACK_ONCLICK"
                                                Cancel = True
                                            Case "SHOW_APPROVALS"
                                                Cancel = True
                                        End Select
                                    End If
                                End If
                            End If
                    End Select
                    ' End_MV_24-Nov-2008
                    Select Case WhizGlobal.TagID


                        'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                        'Added By SandeepA on 14 Nov,2005 for IssueID--676


                        'Added By SandeepA on 14 Nov,2005 for IssueID--676
                        'Page: (Restricted Access)Project Information : TagID=3086
                        Case CommonFunction.Constants.APP_TAG_RestrictedAccessProjectInfo
                            'Purpose: Configure Back link to the existing Project Listing Page
                            If Args.LinkName.ToUpper = "BACK" Then

                                Args.ToBeInsertedInFunction = "window.location.href=""CommonList.aspx?Show=0&FromWhere=PM&MasterTagId=32"";return;"
                            End If
                            'Page: ProjectInformation Role Access :TagID-3083
                            'Added By archanaN on 10 Aug 2006
                            'Case CommonFunction.Constants.APP_TAG_TAB_EMPLOYEE_SELECTION
                            '    If Args.LinkName.ToUpper = "CLOSE" Then
                            '        Args.ToBeInsertedInFunction = "window.close();return;"
                            '    End If
                            'End of Added By archanaN on 10 Aug 2006
                        Case CommonFunction.Constants.APP_TAG_ProjectInfoRoleAccess
                            'Purpose:Inset code into the client side functions of Save(i.e.Delete) link for Saveing the selection
                            If Args.LinkName.ToUpper = "SAVE" Then
                                Args.ToBeInsertedInFunction = "objfrm.action=""Commonlist.aspx?Operation=DELETE&MasterTagID=3083&FromWhere=PM&SortBy=&SortOrder=&ParentTagID=0&FromCL=1"";objfrm.submit();return;"
                            End If
                            'Purpose:Configure Close link
                            If Args.LinkName.ToUpper = "CLOSE" Then
                                Args.ToBeInsertedInFunction = "window.close();return;"
                            End If
                            'End of addition by SandeepA on 14 Nov,2005 for IssueID-676
                            'End Integration

                            'Added by SavitaS on 12 Sept 2006 for SP 7 IssueID 4896
                        Case CommonFunction.Constants.APP_TAG_MYPROFILE
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If
                            'End of Added by SavitaS on 12 Sept 2006 for SP 7 IssueID 4896


                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                            'Added by SandeepA on 15 Nov,2005 for IssueID -- 677
                            'Page: Middlevel resource project access (BG)
                        Case CommonFunction.Constants.APP_TAG_BG_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            'Purpose:Inset code into the client side functions of Save(i.e.Delete) link for Saveing the selection
                            Dim strBusinessGroupID As String
                            Dim strBusinessGroupEmployeeID As String

                            strBusinessGroupID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID"), "")
                            'If strBusinessGroupID = "" Then
                            'strBusinessGroupID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("BusinessGroupID"), "0"))
                            'End If
                            'HttpContext.Current.Session("BusinessGroupID") = strBusinessGroupID

                            strBusinessGroupEmployeeID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupEmployeeID"), ""))
                            'If (strBusinessGroupEmployeeID = "") Then
                            'strBusinessGroupEmployeeID = CStr(HttpContext.Current.Session("BusinessGroupEmployeeID"))
                            'End If
                            'HttpContext.Current.Session("BusinessGroupEmployeeID") = strBusinessGroupEmployeeID

                            If Args.LinkName.ToUpper = "SAVE" Then
                                Args.ToBeInsertedInFunction = "objfrm.action=""Commonlist.aspx?Operation=DELETE&MasterTagID=3087&FromWhere=PM&BusinessGroupID=" & strBusinessGroupID & "&BusinessGroupEmployeeID=" & strBusinessGroupEmployeeID & "&SortBy=&SortOrder=&ParentTagID=0&FromCL=1"";objfrm.submit();return;"
                            End If
                            'Purpose:Configure Close link
                            If Args.LinkName.ToUpper = "CLOSE" Then
                                Args.ToBeInsertedInFunction = "window.close();return;"
                            End If
                            'Trupti
                            If Args.LinkName.ToUpper = "CLEAR ALL" Then
                                'Args.ToBeInsertedInFunction = "ClearAll_OnClick('frmCommonList','chkDelete')"

                                Args.ToBeInsertedInFunction = "var objCheckbox = GetObjectReference('frmCommonList','chkDelete',true);" + vbCrLf
                                Args.ToBeInsertedInFunction += "var intItems;" + vbCrLf
                                Args.ToBeInsertedInFunction += "var intCtr;" + vbCrLf
                                Args.ToBeInsertedInFunction += "if(objCheckbox != null){" + vbCrLf
                                Args.ToBeInsertedInFunction += "intItems = objCheckbox.length;" + vbCrLf
                                Args.ToBeInsertedInFunction += "if(intItems > 1){" + vbCrLf
                                Args.ToBeInsertedInFunction += "for (intCtr = 0;intCtr <= intItems - 1; intCtr++){" + vbCrLf
                                Args.ToBeInsertedInFunction += "if (objCheckbox[intCtr].disabled == false)" + vbCrLf
                                Args.ToBeInsertedInFunction += "objCheckbox[intCtr].checked = false;}}" + vbCrLf
                                Args.ToBeInsertedInFunction += "else if(intItems == 1){" + vbCrLf
                                Args.ToBeInsertedInFunction += "objCheckbox = GetObjectReference('frmCommonList','chkDelete');" + vbCrLf
                                Args.ToBeInsertedInFunction += "if (objCheckbox.disabled == false)objCheckbox.checked = false;}}" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;"


                            End If
                            'End
                            'End of addition by SandeepA on 15 Nov,2005 for IssueID-677
                            'End Integration


                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                            'Added by SandeepA on 15 Nov,2005 for IssueID -- 679
                            'Page: Middlevel resource project access (OU)
                            '------------------------------------------------------
                            'Code added by SajiU on 4th Dec 2006
                        Case CommonFunction.Constants.App_Tag_Login_Maintenance

                            Dim strSelection As String
                            Dim strSelectionValue As String
                            Dim strSelectSQL As String
                            Dim drSelectionValue As IDataReader
                            Dim lngViewAccess As Boolean

                            If CType(HttpContext.Current.Session("LoginViewAccess"), Boolean) Then
                                lngViewAccess = CType(HttpContext.Current.Session("LoginViewAccess"), Boolean)

                                If lngViewAccess = True Then
                                    'Select Case Args.LinkName.ToUpper
                                    '    Case "DELETE"
                                    '        Cancel = True
                                    'End Select

                                End If
                            End If


                            If Not IsNothing(HttpContext.Current.Request.Form("Selection")) Then
                                strSelection = HttpContext.Current.Request.Form("Selection")

                                If strSelection = "Login is Inactive" Then
                                    Select Case Args.LinkName.ToUpper
                                        Case "DEACTIVATE", "RESET PASSWORD", "CREATE LOGIN"
                                            Cancel = True
                                    End Select

                                End If

                                If strSelection = "Login is Active" Then
                                    Select Case Args.LinkName.ToUpper
                                        Case "CREATE LOGIN", "ACTIVATE"
                                            Cancel = True
                                    End Select

                                End If
                                If strSelection = "Login Not Created" Then
                                    Select Case Args.LinkName.ToUpper
                                        Case "DEACTIVATE", "RESET PASSWORD", "ACTIVATE", "DELETE"
                                            Cancel = True
                                    End Select

                                End If
                                If strSelection = "" Then
                                    Select Case Args.LinkName.ToUpper
                                        Case "DEACTIVATE", "RESET PASSWORD", "ACTIVATE", "CREATE LOGIN", "DELETE"
                                            Cancel = True
                                    End Select

                                End If
                            Else

                                strSelectSQL = "select FixedValue from tbl_UI_employeefiltersettings_fielddetails where tagid=3702 and Controlname= 'Selection' and userid =" + HttpContext.Current.Session("intUserID").ToString
                                drSelectionValue = CommonFunctions.Data.GetDataReader(strSelectSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If CommonFunctions.General.CheckIsNothing(drSelectionValue, "") <> "" Then
                                    If drSelectionValue.Read() Then
                                        strSelectionValue = CType(CommonFunctions.Data.CheckIsDBNull(drSelectionValue("FixedValue"), ""), String)
                                    End If
                                End If

                                CommonFunctions.Data.DisposeDataReader(drSelectionValue)

                                If strSelectionValue = "Login is Inactive" Then
                                    Select Case Args.LinkName.ToUpper
                                        Case "DEACTIVATE", "RESET PASSWORD", "CREATE LOGIN"
                                            Cancel = True
                                    End Select

                                End If

                                If strSelectionValue = "Login is Active" Then
                                    Select Case Args.LinkName.ToUpper
                                        Case "CREATE LOGIN", "ACTIVATE"
                                            Cancel = True
                                    End Select

                                End If
                                If strSelectionValue = "Login Not Created" Then
                                    Select Case Args.LinkName.ToUpper
                                        Case "DEACTIVATE", "RESET PASSWORD", "ACTIVATE", "DELETE"
                                            Cancel = True
                                    End Select

                                End If
                                If strSelectionValue = "" Then
                                    Select Case Args.LinkName.ToUpper
                                        Case "DEACTIVATE", "RESET PASSWORD", "ACTIVATE", "CREATE LOGIN", "DELETE"
                                            Cancel = True
                                    End Select

                                End If
                                '''If Not IsNothing(HttpContext.Current.Request.Form("Selection_UserFriendlyValue")) Then
                                '''    strSelectionValue = HttpContext.Current.Request.Form("Selection_UserFriendlyValue")
                                '''    Select Case Args.LinkName.ToUpper
                                '''        Case "DEACTIVATE", "RESET PASSWORD", "ACTIVATE", "CREATE LOGIN"
                                '''            Cancel = True
                                '''    End Select
                                '''    Select Case Args.SystemLinkType.ToUpper
                                '''        Case "DELETE", "FILTERS"
                                '''            Cancel = True
                                '''    End Select
                                '''End If


                            End If
                            'End Select

                            'End of addition by SajiU on 4th Dec 2006
                            '--------------------------------------------------


                        Case CommonFunction.Constants.APP_TAG_OU_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            'Purpose:Inset code into the client side functions of Save(i.e.Delete) link for Saveing the selection
                            Dim strLocationID As String
                            Dim strLocationEmployeeID As String
                            strLocationID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("LocationID"), "")
                            'If strLocationID = "" Then
                            'strLocationID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LocationID"), "0"))
                            'End If
                            'HttpContext.Current.Session("LocationID") = strLocationID

                            strLocationEmployeeID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("LocationEmployeeID"), "")

                            If Args.LinkName.ToUpper = "SAVE" Then

                                Args.ToBeInsertedInFunction = "objfrm.action=""Commonlist.aspx?Operation=DELETE&MasterTagID=3088&FromWhere=PM&LocationID=" & strLocationID & "&LocationEmployeeID=" & strLocationEmployeeID & "&SortBy=&SortOrder=&ParentTagID=0&FromCL=1"";objfrm.submit();return;"
                            End If
                            'Purpose:Configure Close link
                            If Args.LinkName.ToUpper = "CLOSE" Then
                                Args.ToBeInsertedInFunction = "window.close();return;"
                            End If
                            'End of addition by SandeepA on 15 Nov,2005 for IssueID-679
                            'End Integration

                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                            'Added by SandeepA on 16 Nov,2005 for IssueID -- 680
                            'Page: Middlevel resource project access (DU)
                        Case CommonFunction.Constants.APP_TAG_DU_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            'Purpose:Inset code into the client side functions of Save(i.e.Delete) link for Saveing the selection
                            Dim strResourcePoolID As String
                            Dim strResourcePoolEmployeeID As String

                            strResourcePoolID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ResourcePoolID"), "")
                            'If strResourcePoolID = "" Then
                            'strResourcePoolID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("ResourcePoolID"), "0"))
                            'End If
                            'HttpContext.Current.Session("ResourcePoolID") = strResourcePoolID

                            strResourcePoolEmployeeID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ResourcePoolEmployeeID"), "")

                            If Args.LinkName.ToUpper = "SAVE" Then
                                Args.ToBeInsertedInFunction = "objfrm.action=""Commonlist.aspx?Operation=DELETE&MasterTagID=3090&FromWhere=PM&ResourcePoolID=" & strResourcePoolID & "&ResourcePoolEmployeeID=" & strResourcePoolEmployeeID & "&SortBy=&SortOrder=&ParentTagID=0&FromCL=1"";objfrm.submit();return;"
                            End If
                            'Purpose:Configure Close link
                            If Args.LinkName.ToUpper = "CLOSE" Then
                                Args.ToBeInsertedInFunction = "window.close();return;"
                            End If
                            'End of addition by SandeepA on 16 Nov,2005 for IssueID-680
                            'End Integration

                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2

                            'Added by SandeepA on 16 Nov,2005 for IssueID -- 681
                            'Page: Middlevel resource project access (DT)
                        Case CommonFunction.Constants.APP_TAG_DT_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            'Purpose:Inset code into the client side functions of Save(i.e.Delete) link for Saveing the selection
                            Dim strGroupID As String

                            Dim strGroupEmployeeID As String
                            'Modified by SandipL on 16 Feb 2006 --IssueID 2132
                            strGroupID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ResourceGroupID"), "")
                            'If strGroupID = "" Then
                            'strGroupID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("GroupID"), "0"))
                            'End If
                            'HttpContext.Current.Session("GroupID") = strGroupID

                            strGroupEmployeeID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("GroupEmployeeID"), "")
                            If Args.LinkName.ToUpper = "SAVE" Then
                                Args.ToBeInsertedInFunction = "objfrm.action=""Commonlist.aspx?Operation=DELETE&MasterTagID=3092&FromWhere=PM&ResourceGroupID=" & strGroupID & "&GroupEmployeeID=" & strGroupEmployeeID & "&SortBy=&SortOrder=&ParentTagID=0&FromCL=1"";objfrm.submit();return;"
                            End If
                            'End Modification by SandipL on 16 Feb 2006

                            'Purpose:Configure Close link
                            If Args.LinkName.ToUpper = "CLOSE" Then
                                Args.ToBeInsertedInFunction = "window.close();return;"
                            End If
                            'End of addition by SandeepA on 16 Nov,2005 for IssueID-681
                            'End Integration
                            'Added by VivekP on 02 sep-2005-For SQERT Locking
                            'Added by Mangesh Y on 6 Jan 2005- For SQERT Locking
                        Case CommonFunction.Constants.APP_TAG_SQERT_LOCK
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE_ADD", "FILTERS", "SHOW_HISTORY"
                                    Cancel = True
                            End Select

                            Select Case Args.LinkName.ToUpper
                                Case "CLOSE"
                                    Args.ToBeInsertedInFunction = "window.close();" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;"
                                Case "SAVE"
                                    Args.ToBeInsertedInFunction = "objForm = GetFormReference('frmCommonList');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "objForm.action='../General/CommonList.aspx?FromWhere=PRO&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_SQERT_LOCK, String) + " &Action=Save';" + vbCrLf
                                    Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf
                                    ' Args.ToBeInsertedInFunction += "window.opener.location.href = window.opener.location.href;" & vbCrLf
                                    Args.ToBeInsertedInFunction += "return;" + vbCrLf
                            End Select
                            'End Addition - Mangesh Y on 6 Jan 2005
                            'End Addition - VivekP on 02 sep 2005

                            'Added By VidyaJ - DA Performance IssueID - 89
                        Case CommonFunction.Constants.APP_TAG_UPDATEACTUALS

                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If
                            'End Of Addition 


                            'Added by VivekP On 3 August 2005 For WhizibleSEm SP4 IssueID-87
                        Case CommonFunction.Constants.APP_TAG_PROJECTTIMESHEET_COMMENT
                            Select Case Args.SystemLinkType.ToUpper.Trim
                                Case "SAVE"
                                    If HttpContext.Current.Request.QueryString("FROM") = "ProjectTimesheet" Then
                                        Cancel = True
                                    End If
                                    If HttpContext.Current.Request.QueryString("ViewComment") = "ViewComment" Then
                                        Cancel = True
                                    End If
                            End Select
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If
                            'End Of Addition by VivekP On 3 August 2005 For WhizibleSEm SP4 IssueID-87


                            'Case CommonFunction.Constants.APP_TAG_TASK_TYPE_MAINTENANCE_PM
                            'Added By Paresh Bhatewara On Sep 09, 2004 For Select Link from Corporate Projects Page
                            'If IsNothing(HttpContext.Current.Request.QueryString("ProjectID")) = False Then
                            '    Args.CommonQueryString = Replace(Args.CommonQueryString, "FromWhere=PM&", "") & "&ProjectID=" & HttpContext.Current.Request.QueryString("ProjectID").ToString
                            'End If




                            'Code Added by Noble K on 18th Jan 2005 
                            'To Add Validations for Reviewed Date to enforce it between Project Start Date and Project End Date


                            'Added By VivekP On 5 May 2005 For Copy Functionality WHIZIBLESEM SP3

                        Case CommonFunction.Constants.APP_TAG_MODULES
                            If HttpContext.Current.Request.QueryString("COPYDATA") = "1" Then
                                Select Case Args.LinkName.ToUpper
                                    Case "SAVE"
                                        'Added by SavitaS on 06 Oct 06   for SP7 IssueID 6423                  
                                        Args.ToBeInsertedInFunction = "var objStartDate;" & vbCrLf
                                        Args.ToBeInsertedInFunction += "var objEndDate;" & vbCrLf
                                        Args.ToBeInsertedInFunction += "objStartDate=GetObjectReference('frmCommonPage','EstimatedStartDate');" & vbCrLf
                                        Args.ToBeInsertedInFunction += "objEndDate=GetObjectReference('frmCommonPage','EstimatedEndDate');" & vbCrLf
                                        'Commented And Modified by JyotiG
                                        'Date : 03-Oct-2006
                                        'Start
                                        'strJavaScript &= "if (getDate(objEndDate.value,'dd-MMM-yyyy') < getDate(objStartDate.value,'dd-MMM-yyyy')) {" & vbCrLf
                                        Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objStartDate,objEndDate))  {" & vbCrLf
                                        'End
                                        Args.ToBeInsertedInFunction += " alert('End Date cannot be less than Start Date')" & vbCrLf
                                        Args.ToBeInsertedInFunction += "  return;" & vbCrLf
                                        'End of Added by SavitaS on 06 Oct 06  for SP7 IssueID 6423                   
                                        Args.ToBeInsertedInFunction += "}" & vbCrLf
                                        Args.ToBeInsertedInFunction += "else{" & vbCrLf
                                        ''Added By Chakshuta H on 8th-Nov-2016 for Double Save Issue
                                        Args.ToBeInsertedInFunction += "var MenuTags = document.getElementsByTagName('A');" + vbCrLf
                                        Args.ToBeInsertedInFunction += "  for(i = 0; i < MenuTags.length; i++)" + vbCrLf
                                        Args.ToBeInsertedInFunction += "{" + vbCrLf
                                        Args.ToBeInsertedInFunction += " if (MenuTags[i].className == 'Menu')" + vbCrLf
                                        Args.ToBeInsertedInFunction += " {" + vbCrLf
                                        Args.ToBeInsertedInFunction += " MenuTags[i].parentNode.parentNode.style.display= 'none';" + vbCrLf
                                        Args.ToBeInsertedInFunction += " MenuTags[i].style.display= 'none';" + vbCrLf
                                        Args.ToBeInsertedInFunction += " }" + vbCrLf
                                        Args.ToBeInsertedInFunction += " }" + vbCrLf
                                        ''End Of Added By Chakshuta H on 8th-Nov-2016 for Double Save Issue
                                        Args.ToBeInsertedInFunction += " objForm = GetFormReference('frmCommonPage');" + vbCrLf
                                        Args.ToBeInsertedInFunction += "        objForm.action='../General/CommonPage.aspx?Operation=SAVE&Mode=ADD_NEW&FromWhere=PM&PagingAlphabet=-1&ParentTagID=0&COPYDATA=1&UNIQUEID=" + HttpContext.Current.Request.QueryString("UNIQUEID") + "&MasterTagID=" + CType(CommonFunction.Constants.APP_TAG_MODULES, String) + "';" + vbCrLf

                                       
                                        Args.ToBeInsertedInFunction += "        objForm.submit();" + vbCrLf
                                        Args.ToBeInsertedInFunction += "        return;}" + vbCrLf
                                End Select

                                Select Case Args.SystemLinkType.ToUpper.Trim
                                    Case "BACK"
                                        Cancel = True
                                    Case "SAVE_ADD"
                                        Cancel = True
                                End Select
                            End If

                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If

                            If HttpContext.Current.Request.QueryString("COPYDATA") <> "1" Then
                                If Args.LinkName.ToUpper = "CLOSE" Then
                                    Cancel = True
                                End If
                                'Added By VijayD On 3Rd Sept
                                'Purpose:To Hide Back Link If page called from GanttChart
                                If HttpContext.Current.Request.QueryString("FROMGANTTCHART") = "1" Then
                                    If Args.LinkName.ToUpper = "BACK" Then
                                        Cancel = True
                                    End If
                                End If
                                'End addition By VijayD On 3Rd Sept
                                'Added by SavitaS on 06 Oct 06  for SP7 IssueID 6423   
                                If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then

                                    Args.ToBeInsertedInFunction = "var objStartDate;" & vbCrLf
                                    Args.ToBeInsertedInFunction += "var objEndDate;" & vbCrLf
                                    Args.ToBeInsertedInFunction += "objStartDate=GetObjectReference('frmCommonPage','EstimatedStartDate');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "objEndDate=GetObjectReference('frmCommonPage','EstimatedEndDate');" & vbCrLf
                                    'Commented And Modified by JyotiG
                                    'Date : 03-Oct-2006
                                    'Start
                                    'strJavaScript &= "if (getDate(objEndDate.value,'dd-MMM-yyyy') < getDate(objStartDate.value,'dd-MMM-yyyy')) {" & vbCrLf
                                    Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objStartDate,objEndDate))  {" & vbCrLf
                                    'End
                                    Args.ToBeInsertedInFunction += " alert('End Date cannot be less than Start Date')" & vbCrLf
                                    Args.ToBeInsertedInFunction += "  return;" & vbCrLf
                                    Args.ToBeInsertedInFunction += "}"
                                    'End of Added by SavitaS on 06 Oct 06  for SP7 IssueID 6423
                                End If
                            End If

                            'Added By MonikaI on 23-June-2009 RequestID-21303
                            'Purpose : To have validation of Project StartDate and EndDate on phases.
                        Case CommonFunction.Constants.APP_TAG_PHASE_DETAILS
                                If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
                                    Dim strSQL As String
                                    Dim ProjectEndDate As String
                                    Dim ProjectStartDate As String
                                    strSQL = "select expectedStartdate,expectedenddate from tbl_PM_project where ProjectID= " & HttpContext.Current.Session("intProjectID").ToString
                                    Dim drReader As IDataReader
                                    drReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    If (drReader.Read) Then
                                        ProjectEndDate = CommonFunction.Dates.GetDate(CType(drReader("expectedenddate"), Date))
                                        ProjectStartDate = CommonFunction.Dates.GetDate(CType(drReader("expectedStartdate"), Date))
                                    End If
                                CommonFunction.Data.DisposeDataReader(drReader)
                                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                'Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("ProjectDate", "ProjectDate", , , , ProjectEndDate.ToString, , , , , , True, , True)
                                'Args.ToBeInserted += CommonFunction.HTMLControls.DrawTextBox("StartProjectDate", "StartProjectDate", , , , ProjectStartDate.ToString, , , , , , True, , True)
                                Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("ProjectDate", "ProjectDate", , , , ProjectEndDate.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
                                Args.ToBeInserted += CommonFunction.HTMLControls.DrawTextBox("StartProjectDate", "StartProjectDate", , , , ProjectStartDate.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
                                    Args.ToBeInsertedInFunction = "var objtxtToDate =GetObjectReference('frmCommonPage','EstimatedEndDate');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "var objtxtFromDate =GetObjectReference('frmCommonPage','EstimatedStartDate');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "var objProjectdate=GetObjectReference('frmCommonPage','ProjectDate');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "var objProjectStartdate=GetObjectReference('frmCommonPage','StartProjectDate');" & vbCrLf

                                    Args.ToBeInsertedInFunction += "if (objtxtToDate.value!=null) {" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "if (objtxtFromDate.value=='') {" & vbCrLf
                                    ' Args.ToBeInsertedInFunction += "alert('Please enter Start Date'); return; } " & vbCrLf
                                    Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2( objtxtFromDate,objtxtToDate))  {" & vbCrLf
                                    Args.ToBeInsertedInFunction += "alert('Start Date should not be greater than End Date.');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "return; } }"

                                Args.ToBeInsertedInFunction += "if (objtxtToDate.value!=null) {" & vbCrLf
                                Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objtxtToDate, objProjectdate))  {" & vbCrLf
                                    Args.ToBeInsertedInFunction += "alert('\'End Date\' should not be greater than \'Project End Date\' (' + objProjectdate.value + ')');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "return; } "
                                    Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objProjectStartdate,objtxtToDate))  {" & vbCrLf
                                    Args.ToBeInsertedInFunction += "alert('\'End Date\' should not be less than \'Project Start Date\' (' + objProjectStartdate.value + ')');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "return; } }"

                                    Args.ToBeInsertedInFunction += "if (objtxtFromDate.value!=null) {" & vbCrLf
                                    Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objProjectStartdate, objtxtFromDate))  {" & vbCrLf
                                    Args.ToBeInsertedInFunction += "alert('\'Start Date\' should not be less than \'Project Start Date\' (' + objProjectStartdate.value + ')');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "return; }  "
                                    Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objtxtFromDate,objProjectdate))  {" & vbCrLf
                                    Args.ToBeInsertedInFunction += "alert('\'Start Date\' should not be greater than \'Project End Date\' (' + objProjectdate.value + ')');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "return; }  } "

                                End If
                                'End By MonikaI on 23-June-2009 RequestID-21303



                        Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS

                                'Added By Monika on 23-June-2009 RequestID-21331
                                'Purpose : To have validation of Project StartDate and EndDate on Milestone.
                                If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
                                    Dim strSQL As String
                                    Dim ProjectEndDate As String
                                    Dim ProjectStartDate As String
                                    strSQL = "select expectedStartdate,expectedenddate from tbl_PM_project where ProjectID= " & HttpContext.Current.Session("intProjectID").ToString
                                    Dim drReader As IDataReader
                                    drReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    If (drReader.Read) Then
                                        ProjectEndDate = CommonFunction.Dates.GetDate(CType(drReader("expectedenddate"), Date))
                                        ProjectStartDate = CommonFunction.Dates.GetDate(CType(drReader("expectedStartdate"), Date))
                                    End If
                                CommonFunction.Data.DisposeDataReader(drReader)
                                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                'Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("ProjectDate", "ProjectDate", , , , ProjectEndDate.ToString, , , , , , True, , True)
                                'Args.ToBeInserted += CommonFunction.HTMLControls.DrawTextBox("StartProjectDate", "StartProjectDate", , , , ProjectStartDate.ToString, , , , , , True, , True)
                                Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("ProjectDate", "ProjectDate", , , , ProjectEndDate.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
                                Args.ToBeInserted += CommonFunction.HTMLControls.DrawTextBox("StartProjectDate", "StartProjectDate", , , , ProjectStartDate.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
                                Args.ToBeInsertedInFunction = "var objtxtToDate =GetObjectReference('frmCommonPage','ActualCompletionDate');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "var objtxtFromDate =GetObjectReference('frmCommonPage','PlannedCompletionDate');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "var objProjectdate=GetObjectReference('frmCommonPage','ProjectDate');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "var objProjectStartdate=GetObjectReference('frmCommonPage','StartProjectDate');" & vbCrLf

                                    Args.ToBeInsertedInFunction += "if (objtxtToDate.value!=null) {" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "if (objtxtFromDate.value=='') {" & vbCrLf
                                    ' Args.ToBeInsertedInFunction += "alert('Please enter Start Date'); return; } " & vbCrLf
                                    Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2( objtxtFromDate,objtxtToDate))  {" & vbCrLf
                                    Args.ToBeInsertedInFunction += "alert('Start Date should not be greater than End Date.');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "return; } }"

                                    Args.ToBeInsertedInFunction += "if (objtxtToDate.value!=null) {" & vbCrLf
                                    Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objtxtToDate, objProjectdate))  {" & vbCrLf
                                    Args.ToBeInsertedInFunction += "alert('\'End Date\' should not be greater than \'Project End Date\' (' + objProjectdate.value + ')');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "return; } "
                                    Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objProjectStartdate,objtxtToDate))  {" & vbCrLf
                                    Args.ToBeInsertedInFunction += "alert('\'End Date\' should not be less than \'Project Start Date\' (' + objProjectStartdate.value + ')');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "return; } }"

                                    Args.ToBeInsertedInFunction += "if (objtxtFromDate.value!=null) {" & vbCrLf
                                    Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objProjectStartdate, objtxtFromDate))  {" & vbCrLf
                                    Args.ToBeInsertedInFunction += "alert('\'Start Date\' should not be less than \'Project Start Date\' (' + objProjectStartdate.value + ')');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "return; }  "
                                    Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objtxtFromDate,objProjectdate))  {" & vbCrLf
                                    Args.ToBeInsertedInFunction += "alert('\'Start Date\' should not be greater than \'Project End Date\' (' + objProjectdate.value + ')');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "return; }  } "

                                End If
                                'End By Monika on 23-June-2009 RequestID-21331

                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close(); return;"
                                End If
                                If HttpContext.Current.Request.QueryString("COPYDATA") <> "1" Then
                                    If Args.LinkName.ToUpper = "CLOSE" Then
                                        Cancel = True
                                    End If
                                End If
                                If HttpContext.Current.Request.QueryString("COPYDATA") = "1" Then

                                    Select Case Args.SystemLinkType.ToUpper.Trim
                                        Case "BACK"
                                            Cancel = True
                                        Case "SAVE_ADD"
                                            Cancel = True
                                    End Select
                                'Added By VijayD On 3Rd Sept
                                'Purpose:To Hide Back Link If page called from GanttChart
                                If HttpContext.Current.Request.QueryString("FROMGANTTCHART") = "1" Then
                                    If Args.LinkName.ToUpper = "BACK" Then
                                        Cancel = True
                                    End If
                                End If
                                'End addition By VijayD On 3Rd Sept
                                'Added by SavitaS on 06 Oct 06  for SP7 IssueID 6423
                                    Select Case Args.LinkName.ToUpper
                                    Case "SAVE"
                                        ''Added By Chakshuta H on 8th-Nov-2016 for Double Save Issue
                                        Args.ToBeInsertedInFunction += "var MenuTags = document.getElementsByTagName('A');" + vbCrLf
                                        Args.ToBeInsertedInFunction += "  for(i = 0; i < MenuTags.length; i++)" + vbCrLf
                                        Args.ToBeInsertedInFunction += "{" + vbCrLf
                                        Args.ToBeInsertedInFunction += " if (MenuTags[i].className == 'Menu')" + vbCrLf
                                        Args.ToBeInsertedInFunction += " {" + vbCrLf
                                        Args.ToBeInsertedInFunction += " MenuTags[i].parentNode.parentNode.style.display= 'none';" + vbCrLf
                                        Args.ToBeInsertedInFunction += " }" + vbCrLf
                                        Args.ToBeInsertedInFunction += " }" + vbCrLf
                                        ''End Of Added By Chakshuta H on 8th-Nov-2016 for Double Save Issue
                                        'Commented and added by Yogesh Jalamkar on 14-NOV-2016 Purpose: Multiple Save Issue
                                        'Args.ToBeInsertedInFunction = " objForm = GetFormReference('frmCommonPage');" + vbCrLf
                                        Args.ToBeInsertedInFunction += " objForm = GetFormReference('frmCommonPage');" + vbCrLf
                                        'End of addition by Yogesh Jalamkar on 14-NOV-2016
                                        Args.ToBeInsertedInFunction += "        objForm.action='../General/CommonPage.aspx?Operation=SAVE&Mode=ADD_NEW&FromWhere=PM&PagingAlphabet=-1&ParentTagID=0&COPYDATA=1&UNIQUEID=" + HttpContext.Current.Request.QueryString("UNIQUEID") + "&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS, String) + "';" + vbCrLf
                                        Args.ToBeInsertedInFunction += "        objForm.submit();" + vbCrLf
                                        Args.ToBeInsertedInFunction += "        return;" + vbCrLf
                                End Select

                                End If

                                'End If Addition On 5 May 2005 For Copy Functionality



                                'Added by PrachiK on 17 Feb 2005 for IssueID 15334
                                'Purpose:Should not Allow to add task if the Project is not Baselined
                        Case CommonFunction.Constants.APP_TAG_Issue, CommonFunction.Constants.APP_TAG_REVIEW_PLANNING, CommonFunction.Constants.APP_TAG_REVIEWS
                                ', CommonFunction.Constants.APP_TAG_Project_FTR
                                'CommonFunction.Constants.APP_TAG_Project_Reviews
                                If Args.ClientSideFunctionName.ToUpper = "NEW_ONCLICK" Then


                                    Dim m_blnIsProjectCreationWorkflowReqd As Boolean = False
                                    Dim m_intBaselineNumber As Integer = 0
                                    m_blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
                                    Dim strQuery As String = ""
                                    Dim drProjectStatus As IDataReader

                                    'Modified By VidyaJ - Performance Issue - Resources - IssueID - 85
                                    'Get Baseline info only if Creation workflow is applicable
                                    If m_blnIsProjectCreationWorkflowReqd = True Then
                                        strQuery = "EXEC usp_Sel_tbl_CNF_Project_Status " & HttpContext.Current.Session("intProjectID").ToString

                                        drProjectStatus = CommonFunction.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        If CommonFunctions.General.CheckIsNothing(drProjectStatus) <> "" Then
                                            If drProjectStatus.Read() Then
                                                m_intBaselineNumber = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectStatus("BaselineNumber"), "0"), "0"), Integer)
                                            End If
                                        End If
                                        CommonFunctions.Data.DisposeDataReader(drProjectStatus)
                                        If m_blnIsProjectCreationWorkflowReqd = True Then
                                            If m_intBaselineNumber = 0 Then
                                                Args.ToBeInsertedInFunction += "alert('Project related activities such as adding Task/Resource/Timesheet entry cannot be performed as the Project is not Approved.');" & vbCrLf
                                                Args.ToBeInsertedInFunction += "return;"
                                            End If
                                        End If
                                    End If
                                    'End Of Modification

                                End If
                                'Addtion Ended

                                'Integrated by MrugajaB on 26th April 2005 for WhizibleSEM SP3

                                'Modified By VidyaJ for SP4 - IssueID - 83
                                'Added below If Condition
                                If (Args.SystemLinkType.ToUpper = "SAVE" Or Args.SystemLinkType.ToUpper = "SAVE_ADD" Or Args.SystemLinkType.ToUpper = "MAP REVIEW TASKS TO MPP TASKS") Then

                                    Dim strQueryStatus As String = ""
                                    Dim drProjectDetails As IDataReader
                                    Dim m_strReviewStatus As String = ""

                                    'Code Added by RajkumarM ONSITE on 21st March 2005 to Disallow Closed Reviews to MOdify
                                    If Args.PrimaryKeyValue.ToString() <> "" Then
                                        strQueryStatus = "Select ReviewStatus from tbl_pm_reviewstatistics Where ReviewStatisticsID= " + Args.PrimaryKeyValue.ToString()
                                        drProjectDetails = CommonFunctions.Data.GetDataReader(strQueryStatus, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        If CommonFunctions.General.CheckIsNothing(drProjectDetails, "") <> "" Then
                                            If drProjectDetails.Read() Then
                                                m_strReviewStatus = CType(CommonFunctions.Data.CheckIsDBNull(drProjectDetails("ReviewStatus"), ""), String)
                                            End If
                                        End If

                                        CommonFunctions.Data.DisposeDataReader(drProjectDetails)
                                    End If
                                    ' End of Addition ONSITE

                                    Select Case Args.SystemLinkType.ToUpper
                                        Case "SAVE", "SAVE_ADD"
                                            ' Code Added by RajkumarM on 22nd March ONSITE
                                            If m_strReviewStatus.ToUpper = "CLOSED" Then
                                                Cancel = True
                                            End If
                                            'End of Addition ONSITE
                                    End Select
                                    ' Added by RajkumarM on 22nd March ONSITE
                                    Select Case Args.LinkName.ToUpper
                                        Case "MAP REVIEW TASKS TO MPP TASKS"
                                            If m_strReviewStatus.ToUpper = "CLOSED" Then
                                                Cancel = True
                                            End If
                                    End Select
                                    ' End of Addition ONSITE
                                    'End Integration

                                    'Modified By VidyaJ for SP4 - IssueID - 83
                                    'Added end If
                                End If
                                'End Of Modification
                        Case CommonFunction.Constants.APP_TAG_FAST_TRACK_REVIEWS
                                Dim strQuery As String = ""

                                ' Added By MahendraV On 6:03 PM 7/13/2007 For WhizibleSEM 7
                                ' To Display 'Checklist Details' link on the basis of there access rights
                                ' Start_MV_7/13/2007
                                Dim drIsTagAccessible As IDataReader
                                Dim intIsTagAccessible As Integer = 0

                                If Args.ClientSideFunctionName.ToUpper = "CHECKLIST_ONCLICK" Then

                                    Dim objWebPages As New WebPages.Template.WhizTemplate
                                    Dim objGlobal As WebPages.Template.IGlobal
                                    Dim objAccessRights As WebPages.Security.cAccessRights
                                    objWebPages.FillGlobalObject(objWebPages.CurrentThreadUICultureID)
                                    objGlobal = objWebPages.GlobalObject()
                                    objAccessRights = New WebPages.Security.cAccessRights(objGlobal)
                                    objAccessRights.ParentTagID = 2191
                                    objAccessRights.TagID = 2094
                                    objAccessRights.GetAccess()
                                    If (objAccessRights.Add = False And objAccessRights.Edit = False And objAccessRights.Delete = False And objAccessRights.View = False) Then
                                        Cancel = True
                                    End If

                                End If
                                ' End_MV_7/13/2007
                                'Added by PrachiK on 17 Feb 2005 for IssueID 15334
                                'Purpose:Should not Allow to add task if the Project is not Baselined
                                If Args.ClientSideFunctionName.ToUpper = "NEW_ONCLICK" Then

                                    Dim m_blnIsProjectCreationWorkflowReqd As Boolean = False
                                    Dim m_intBaselineNumber As Integer = 0
                                    m_blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)

                                    Dim drProjectStatus As IDataReader
                                    'Modified By VidyaJ - Performance Issue - Resources - IssueID - 85
                                    'Get Baseline info only if Creation workflow is applicable

                                    If m_blnIsProjectCreationWorkflowReqd = True Then

                                        strQuery = "EXEC usp_Sel_tbl_CNF_Project_Status " & HttpContext.Current.Session("intProjectID").ToString

                                        drProjectStatus = CommonFunction.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        If CommonFunctions.General.CheckIsNothing(drProjectStatus) <> "" Then
                                            If drProjectStatus.Read() Then
                                                m_intBaselineNumber = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectStatus("BaselineNumber"), "0"), "0"), Integer)
                                            End If
                                        End If
                                        CommonFunctions.Data.DisposeDataReader(drProjectStatus)
                                        If m_blnIsProjectCreationWorkflowReqd = True Then
                                            If m_intBaselineNumber = 0 Then
                                                Args.ToBeInsertedInFunction += "alert('Project related activities such as adding Task/Resource/Timesheet entry cannot be performed as the Project is not Approved.');" & vbCrLf
                                                Args.ToBeInsertedInFunction += "return;"
                                            End If
                                        End If
                                    End If
                                    'End Of Modification

                                End If
                                'Addtion Ended

                                'Integrated by MrugajaB on 26th April 2005 for WhizibleSEM SP3

                                Dim strQueryStatus As String = ""
                                Dim drReviewDetails As IDataReader
                                Dim m_strReviewStatus As String = ""

                                'Code Added by RajkumarM ONSITE on 21st March 2005 to Disallow Closed Reviews to MOdify
                                If Args.PrimaryKeyValue.ToString() <> "" Then
                                    strQueryStatus = "Select ReviewStatus from tbl_pm_reviewstatistics Where ReviewStatisticsID= " + Args.PrimaryKeyValue.ToString()
                                    drReviewDetails = CommonFunctions.Data.GetDataReader(strQueryStatus, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If CommonFunctions.General.CheckIsNothing(drReviewDetails, "") <> "" Then
                                        If drReviewDetails.Read() Then
                                            m_strReviewStatus = CType(CommonFunctions.Data.CheckIsDBNull(drReviewDetails("ReviewStatus"), ""), String)
                                        End If
                                    End If

                                    CommonFunctions.Data.DisposeDataReader(drReviewDetails)
                                End If
                                ' End of Addition ONSITE

                                Select Case Args.SystemLinkType.ToUpper

                                    Case "SAVE", "SAVE_ADD"
                                        ' Code Added by RajkumarM on 22nd March ONSITE
                                        If m_strReviewStatus.ToUpper = "CLOSED" Then
                                            Cancel = True
                                        End If
                                        'End of Addition ONSITE

                                        strQuery = ""
                                        Dim drProjectDetails As IDataReader
                                        Dim strProjectStartDate As String = ""
                                        Dim strProjectEndDate As String = ""
                                        'Create object of the ProjectByNet Template Class
                                        objTemplate = New WebPages.Template.WhizTemplate
                                        'Initialize the Resources
                                        objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                        strQuery = "SELECT ExpectedStartDate, ExpectedEndDate FROM tbl_PM_Project WHERE ProjectID = " & HttpContext.Current.Session("intProjectID").ToString
                                        drProjectDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        If drProjectDetails.Read() Then
                                            strProjectStartDate = CommonFunctions.General.CheckIsNothing(drProjectDetails.Item("ExpectedStartDate"), "")
                                            strProjectEndDate = CommonFunctions.General.CheckIsNothing(drProjectDetails.Item("ExpectedEndDate"), "")
                                            If strProjectStartDate <> "" Then strProjectStartDate = CommonFunctions.Dates.GetDate(CType(strProjectStartDate, Date))
                                            If strProjectEndDate <> "" Then strProjectEndDate = CommonFunctions.Dates.GetDate(CType(strProjectEndDate, Date))
                                        End If
                                        CommonFunctions.Data.DisposeDataReader(drProjectDetails)

                                        Args.ToBeInsertedInFunction = " var strMsg, dtProjectStartDate,  dtProjectEndDate;" + vbCrLf
                                        Args.ToBeInsertedInFunction += " var dtReviewedDate;" + vbCrLf
                                        Args.ToBeInsertedInFunction += " var objReviewedDate;" + vbCrLf
                                        Args.ToBeInsertedInFunction += "dtProjectStartDate = getDate('" & strProjectStartDate & "');" + vbCrLf
                                        Args.ToBeInsertedInFunction += "dtProjectEndDate = getDate('" & strProjectEndDate & "');" + vbCrLf
                                        Args.ToBeInsertedInFunction += "objReviewedDate = GetObjectReference('frmCommonPage','ReviewedDate');" + vbCrLf
                                        Args.ToBeInsertedInFunction += "dtReviewedDate = getDate(objReviewedDate.value);" + vbCrLf
                                        'Args.ToBeInsertedInFunction += "alert(dtProjectStartDate);"
                                        'Args.ToBeInsertedInFunction += "alert(dtProjectEndDate);"
                                        'Args.ToBeInsertedInFunction += "alert(dtReviewedDate);"
                                        'Args.ToBeInsertedInFunction += "objCurrentEndDate = GetObjectReference('frmCommonPage','EndDate');" + vbCrLf
                                        'Args.ToBeInsertedInFunction += "dtCurrentEndDate = getDate(objCurrentEndDate.value);" + vbCrLf
                                        Args.ToBeInsertedInFunction += "if((dtProjectStartDate != null) && (dtProjectEndDate != null) && (dtReviewedDate != null) && (dtReviewedDate != null)){" + vbCrLf
                                        Args.ToBeInsertedInFunction += "if((dtReviewedDate < dtProjectStartDate) || (dtReviewedDate > dtProjectEndDate)){" + vbCrLf
                                        'Commented by MrugajaB on 3rd Feb 2005 in order to add new resource string
                                        'Args.ToBeInsertedInFunction += "strMsg='" & objTemplate.GetResourceString("DATES_BETWEEN_PROJECTDATES") & "';" + vbCrLf
                                        'Code modified by MrugajaB on 3rd Feb 2005
                                        'Added code for new resource string which is used while displaying message when Reviewed date does not lie between project start and end dates
                                        Args.ToBeInsertedInFunction += "strMsg='" & objTemplate.GetResourceString("REVIEWDATE_BETWEEN_PROJECTDATES") & "';" + vbCrLf
                                        'End Modification
                                        Args.ToBeInsertedInFunction += "strMsg = replaceSubstring(strMsg, '<=>', '" & strProjectStartDate & "');" + vbCrLf
                                        Args.ToBeInsertedInFunction += "strMsg = replaceSubstring(strMsg, '<==>', '" & strProjectEndDate & "');" + vbCrLf
                                        Args.ToBeInsertedInFunction += "alert(strMsg);" + vbCrLf
                                        Args.ToBeInsertedInFunction += "return;}}" + vbCrLf

                                        objTemplate = Nothing
                                End Select

                                ' Added by RajkumarM on 22nd March ONSITE
                                Select Case Args.LinkName.ToUpper
                                    Case "MAP REVIEW TASKS TO MPP TASKS"
                                        If m_strReviewStatus.ToUpper = "CLOSED" Then
                                            Cancel = True
                                        End If
                                End Select
                                ' End of Addition ONSITE
                                'End Integration

                                'Code Added by Noble K on 18th Jan 2005 Ends




                                '    'Modified By PrachiK on 17 Feb 2005 for Issue ID. 15334
                                '    'Purpose: Not allow to do any activity if Project is not baselined
                                'Case CommonFunction.Constants.APP_TAG_Project_Reviews

                                '    If Args.ClientSideFunctionName.ToUpper = "NEW_ONCLICK" Then
                                '        Dim m_blnIsProjectCreationWorkflowReqd As Boolean = False
                                '        Dim m_intBaselineNumber As Integer = 0
                                '        m_blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
                                '        Dim strQuery As String = ""
                                '        Dim drProjectStatus As IDataReader

                                '        strQuery = "EXEC usp_Sel_tbl_CNF_Project_Status " & HttpContext.Current.Session("intProjectID").ToString

                                '        drProjectStatus = CommonFunction.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                '        If CommonFunctions.General.CheckIsNothing(drProjectStatus) <> "" Then
                                '            If drProjectStatus.Read() Then
                                '                m_intBaselineNumber = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectStatus("BaselineNumber"), "0"), "0"), Integer)
                                '            End If
                                '        End If
                                '        CommonFunctions.Data.DisposeDataReader(drProjectStatus)
                                '        If m_blnIsProjectCreationWorkflowReqd = True Then
                                '            If m_intBaselineNumber = 0 Then
                                '                Args.ToBeInsertedInFunction += "alert('Project related activities such as adding Task/Resource/Timesheet entry cannot be performed as the Project is not Baselined.');" & vbCrLf
                                '                Args.ToBeInsertedInFunction += "return;"
                                '            End If
                                '        End If


                                '    End If

                                'Case CommonFunction.Constants.APP_TAG_Project_FTR

                                '    If Args.ClientSideFunctionName.ToUpper = "NEW_ONCLICK" Then
                                '        Dim m_blnIsProjectCreationWorkflowReqd As Boolean = False
                                '        Dim m_intBaselineNumber As Integer = 0
                                '        m_blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
                                '        Dim strQuery As String = ""
                                '        Dim drProjectStatus As IDataReader

                                '        strQuery = "EXEC usp_Sel_tbl_CNF_Project_Status " & HttpContext.Current.Session("intProjectID").ToString

                                '        drProjectStatus = CommonFunction.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                '        If CommonFunctions.General.CheckIsNothing(drProjectStatus) <> "" Then
                                '            If drProjectStatus.Read() Then
                                '                m_intBaselineNumber = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectStatus("BaselineNumber"), "0"), "0"), Integer)
                                '            End If
                                '        End If
                                '        CommonFunctions.Data.DisposeDataReader(drProjectStatus)
                                '        If m_blnIsProjectCreationWorkflowReqd = True Then
                                '            If m_intBaselineNumber = 0 Then
                                '                Args.ToBeInsertedInFunction += "alert('Project related activities such as adding Task/Resource/Timesheet entry cannot be performed as the Project is not Baselined.');" & vbCrLf
                                '                Args.ToBeInsertedInFunction += "return;"
                                '            End If
                                '        End If


                                '    End If
                                '    'Addtion Ended


                                '        'Added by SiddharthS on 17 Feb 2005 for IssueID 16009
                                '        'Purpose:To validate Min.Response Time < Max. Response Time
                                'Case CommonFunction.Constants.APP_TAG_SUB_REQUEST
                                '        If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                                '            Args.ToBeInsertedInFunction += "var MinTime,MaxTime;" & vbCrLf
                                '            Args.ToBeInsertedInFunction += "MinTime=GetObjectReference('frmCommonPage','Min_Response_Time');" & vbCrLf
                                '            Args.ToBeInsertedInFunction += "MaxTime=GetObjectReference('frmCommonPage','Max_Response_Time');" & vbCrLf
                                '            Args.ToBeInsertedInFunction += "if (MinTime.value > MaxTime.value){" & vbCrLf
                                '            Args.ToBeInsertedInFunction += "alert('Min.Response Time can not be greater than Max. Response Time')" & vbCrLf
                                '            Args.ToBeInsertedInFunction += "return;}" & vbCrLf
                                '        End If
                                '        'End Addition.

                                'Added by SiddharthS on 21 Feb 2005 for Issue ID 15900
                                'Case CommonFunction.Constants.APP_TAG_REVIEW_PLANNING
                                '    If Args.ClientSideFunctionName.ToUpper.Trim = "SAVE_ONCLICK" Then
                                '        'Dim MinDAHrs As Double
                                '        ' MinDAHrs = CommonFunctions.Application.MinHoursForDAEntry
                                '        Args.ToBeInsertedInFunction += "var objCurrentWork,dblTotalWork;" & vbCrLf
                                '        Args.ToBeInsertedInFunction += "alert('hi');" & vbCrLf
                                '        'Args.ToBeInsertedInFunction += "alert('hi');objCurrentWork = GetObjectReference('frmCommonPage','ReviewEffort');" & vbCrLf
                                '        'Args.ToBeInsertedInFunction += "dblTotalWork=objCurrentWork.value;" & vbCrLf
                                '        'Args.ToBeInsertedInFunction += "if((dblTotalWork / <%=CommonFunctions.Application.MinHoursForDAEntry%>) != parseInt(dblTotalWork / <%=CommonFunctions.Application.MinHoursForDAEntry%>)) {" & vbCrLf
                                '        'Args.ToBeInsertedInFunction += "alert('Invalid work hrs'); setFocus(objCurrentWork);return false;}"
                                '    End If
                                'End addition.

                        Case CommonFunction.Constants.APP_TAG_CORPORATE_PROJECTS
                                If Args.ClientSideFunctionName.ToUpper.Trim = "SAVE_ONCLICK" Then
                                    'Added By paresh B on 08 Sep 2004
                                    Dim strSQL As String                'To Hold the SQL String
                                    Dim drProjectCode As IDataReader    'To Hold the recordset
                                    Dim strAllProjectCodes As String    'To Hold the list of All the Project Codes
                                    Dim strAllProjectNames As String    'To Hold the list of All the Project Names
                                    Dim intPos As Integer
                                    ' Added By NitinVS To Build ProjectCode and ProjectName Array 
                                    Dim strProjectName As String
                                    Dim strProjectCode As String

                                    'Modified By VidyaJ on 24th Nov - exclude currently selected project in edit mode
                                    If Args.PrimaryKeyValue.Trim <> "" Then
                                        strSQL = "SELECT ProjectCode,ProjectName from tbl_PM_Project Where ProjectID<> " + Args.PrimaryKeyValue.Trim  'Select All the Project Codes From 
                                    Else
                                        strSQL = "SELECT ProjectCode,ProjectName from tbl_PM_Project  "   'Select All the Project Codes From 
                                    End If

                                    strAllProjectCodes = ""
                                    strAllProjectNames = ""

                                    drProjectCode = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))     ' Gets the recordset

                                    Do While drProjectCode.Read
                                        ' Added By NitinVS on 26 November 2004
                                        ' To Add Quotes before and after each Project
                                        strProjectName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectCode("ProjectName"), ""), "").ToString().Trim()
                                        If strProjectName <> "" Then
                                            If strAllProjectNames <> "" Then
                                                strAllProjectNames &= ","
                                            End If
                                            strAllProjectNames &= """" & strProjectName & """"
                                        End If
                                        strProjectCode = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectCode("ProjectCode"), ""), "").ToString().Trim()
                                        If strProjectCode <> "" Then
                                            If strAllProjectCodes <> "" Then
                                                strAllProjectCodes &= ","
                                            End If
                                            strAllProjectCodes &= """" & strProjectCode & """"
                                        End If

                                        'strAllProjectCodes = strAllProjectCodes & UCase(drProjectCode("ProjectCode").ToString) & ","
                                        'strAllProjectNames = strAllProjectNames & UCase(drProjectCode("ProjectName").ToString) & ","

                                    Loop
                                    ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                    'drProjectCode = Nothing
                                    CommonFunction.Data.DisposeDataReader(drProjectCode)
                                    ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745


                                    'Args.ToBeInsertedInFunction += "var intPos ;" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "var strAllProjectCodes;" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "var strAllProjectNames;" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "intPos = 0;" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "strAllProjectCodes =  strAllProjectCodes & ";" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "strAllProjectNames =  strAllProjectNames & ";" & vbCrLf
                                    ' Updated the If Condition to set intPos = 1 when either ProjectName or ProjectCode is Present
                                    'Args.ToBeInsertedInFunction += "    if((strAllProjectNames.indexOf(Trim(frmCommonPage.ProjectName.value.toUpperCase()) ) != -1) && (strAllProjectCodes.indexOf(Trim(frmCommonPage.ProjectCode.value.toUpperCase() )) != -1))  " & vbCrLf
                                    'Args.ToBeInsertedInFunction += "    {" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "        intPos = 1;" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "    }" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "if(intPos != 0){" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "alert('A Project Code/ Project Name already exists.') ;" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "frmCommonPage.ProjectCode.focus() ;" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "return ;}" & vbCrLf

                                    Args.ToBeInsertedInFunction += "var arrAllProjectNames=new Array(" & strAllProjectNames & ");" & vbCrLf
                                    Args.ToBeInsertedInFunction += "var arrAllProjectCodes=new Array(" & strAllProjectCodes & ");" & vbCrLf
                                    Args.ToBeInsertedInFunction &= "if (disallowDuplicates(GetObjectReference(""frmCommonPage"",""ProjectName""),arrAllProjectNames,'&#39;Project Name&#39; already exists.',true,false))" & vbCrLf
                                    Args.ToBeInsertedInFunction &= "{ return; }" & vbCrLf
                                    Args.ToBeInsertedInFunction &= "if (disallowDuplicates(GetObjectReference(""frmCommonPage"",""ProjectCode""),arrAllProjectCodes,'&#39;Project Code&#39; already exists.',true,false))" & vbCrLf
                                    Args.ToBeInsertedInFunction &= "{ return; }" & vbCrLf


                                    ' End Addition BY NitinVS on 26 November 2004

                                ElseIf Args.ClientSideFunctionName.ToUpper.Trim = "SELECT" Or Args.ClientSideFunctionName.ToUpper.Trim = "TASK" Then
                                    If Args.CommonQueryString.IndexOf("ADD_NEW") <> -1 Then
                                        Cancel = True
                                    ElseIf Args.ClientSideFunctionName.ToUpper.Trim = "SELECT" Then
                                        'Dim intPtrojectID As Integer
                                        'Dim strString As String
                                        'Dim intPosition As Integer

                                        'strString = Args.CommonQueryString

                                        'intPosition = CInt(strString.IndexOf("ProjectID")) + Len("ProjectID") + 2
                                        'intPtrojectID = CType(Mid(strString, intPosition, (InStr(intPosition + 1, strString, "&") - intPosition)), Integer)

                                        'Args.CustomLink = "../General/CommonList.aspx?FromWhere=PM&MasterTagId=1027&ProjectId=" & intPtrojectID
                                    ElseIf Args.ClientSideFunctionName.ToUpper.Trim = "TASK" Then
                                        'Dim intPtrojectID As Integer
                                        'Dim strString As String
                                        'Dim intPosition As Integer

                                        'strString = Args.CommonQueryString

                                        'intPosition = CInt(strString.IndexOf("ProjectID")) + Len("ProjectID") + 2
                                        'intPtrojectID = CType(Mid(strString, intPosition, (InStr(intPosition + 1, strString, "&") - intPosition)), Integer)

                                        'Args.CustomLink = "../PM/PM_ProjectTask.aspx?MasterTagId=406&Mode=New&PageNumber=-1&SubPage=1&SortByField=TaskName&ASCorDESC=ASC&ProjectId=" & intPtrojectID

                                    End If
                                End If
                                'Added by ShraddhaM on 17,Sept 2008
                                'Purpose : Create Customer of closed resource demand in Whiziblesem8.0
                                '           To hide close link when page is not open from resource demand
                        Case CommonFunction.Constants.APP_TAG_CUSTOMER_MASTER
                                If Args.ClientSideFunctionName.ToUpper.Trim = "CLOSE_CLICK" Then
                                    Dim FromWhere As String

                                    FromWhere = HttpContext.Current.Request.QueryString("From")
                                    If FromWhere Is Nothing Then
                                        FromWhere = HttpContext.Current.Request.Form("hidFrom")
                                    End If
                                    If FromWhere <> "DEMAND" Then
                                        Cancel = True
                                    End If

                                End If

                                If Args.ClientSideFunctionName.ToUpper.Trim = "SAVEADD_ONCLICK" Then
                                    Dim FromWhere As String

                                    FromWhere = HttpContext.Current.Request.QueryString("From")
                                    If FromWhere Is Nothing Then
                                        FromWhere = HttpContext.Current.Request.Form("hidFrom")
                                    End If
                                    If FromWhere = "DEMAND" Then
                                        Cancel = True
                                    End If

                                End If   'End of addition by ShraddhaM

                        Case CommonFunction.Constants.APP_TAG_CREATE_PROJECT
                                'Added by ShraddhaM on 17,Sept 2008
                                'Purpose : Create Project of closed resource demand in Whiziblesem8.0
                                '           To hide close link when page is not open from resource demand
                                If Args.ClientSideFunctionName.ToUpper.Trim = "CLOSE_CLICK" Then
                                    Dim FromWhere As String

                                    FromWhere = HttpContext.Current.Request.QueryString("From")
                                    If FromWhere Is Nothing Then
                                        FromWhere = HttpContext.Current.Request.Form("hidFrom")
                                    End If
                                    If FromWhere <> "DEMAND" Then
                                        Cancel = True
                                    End If

                                    'End of addition by shraddhaM
                                ElseIf Args.ClientSideFunctionName.ToUpper.Trim = "SAVE_ONCLICK" Then

                                    'Commented by MrugajaB on 1th April 2006
                                    'This check is added as clientsidescript in controltagmaster

                                    'Added By Paresh B. On August 9 For 
                                    '1. If contract type is fixed bid then contract value should be mandatory 
                                    '2. If Contract Value is entered then currency should be mandatory
                                    'Args.ToBeInsertedInFunction = " var objContractType =GetObjectReference('frmCommonPage','ContractType');"
                                    'Args.ToBeInsertedInFunction += " var objContractValue =GetObjectReference('frmCommonPage','ContractValue');"
                                    'Args.ToBeInsertedInFunction += " var objBaseCurrency =GetObjectReference('frmCommonPage','BaseCurrency');"
                                    'Args.ToBeInsertedInFunction += "if (objContractType.value == ""1"")" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "     {if (objContractType.value == """")" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "            {alert(""Please enter Project Value for Fixed Bid Project !"");" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "            objContractType.focus();" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "            return;}}" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "if (objContractValue.value != """")" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "   {" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "        if (objBaseCurrency.value == """") " & vbCrLf
                                    'Args.ToBeInsertedInFunction += "        {" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "            alert(""Please enter the currency !"");" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "            objBaseCurrency.focus()" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "            return;" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "        } " & vbCrLf
                                    'Args.ToBeInsertedInFunction += "    }" & vbCrLf
                                    'End Comment

                                    'Added by ShamkantD on 25 Sep 2004 - added to check whether the project name already exists
                                    Dim strToBeInserted As String = ""
                                    Dim drProjects As IDataReader
                                    Dim strProjectName As String = ""
                                    strToBeInserted = ""

                                    'Modified By VidyaJ on 24th Nov - exclude currently selected project in edit mode
                                    If Args.PrimaryKeyValue.Trim <> "" Then
                                        'Get the project names
                                        drProjects = CommonFunction.Data.GetDataReader("SELECT DISTINCT ProjectName FROM tbl_PM_Project Where ProjectID<>" + Args.PrimaryKeyValue.Trim, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    Else
                                        drProjects = CommonFunction.Data.GetDataReader("SELECT DISTINCT ProjectName FROM tbl_PM_Project", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    End If
                                    While drProjects.Read
                                        strProjectName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjects("ProjectName"), ""), "").ToString().Trim()
                                        If strProjectName <> "" Then
                                            If strToBeInserted <> "" Then
                                                strToBeInserted &= ","
                                            End If
                                            strToBeInserted &= """" & strProjectName & """"
                                        End If
                                    End While
                                    CommonFunction.Data.DisposeDataReader(drProjects)

                                    If strToBeInserted <> "" Then
                                    'Write script that will check whether the entered project name exists 
                                    'in the Project Names array. If it does, it will return false.

                                    ''Added by NitinC on 19 April 2012 for WhizibleSEM 11.0 [Issue Fix : 61258 Custom Field]
                                    'Args.ToBeInsertedInFunction = "if(ValidateCustomFields()==false){return;} " & vbCrLf
                                    ''End of Added by NitinC on 19 April 2012 for WhizibleSEM 11.0 [Issue Fix : 61258 Custom Field]
                                    strToBeInserted = "var arrProjectName=new Array(" & strToBeInserted & ");" & vbCrLf
                                        strToBeInserted &= "if (disallowDuplicates(GetObjectReference(""frmCommonPage"",""ProjectName""),arrProjectName,'&#39;Project Name&#39; already exists.',true,false))" & vbCrLf
                                        strToBeInserted &= "{ return; }" & vbCrLf

                                        Args.ToBeInsertedInFunction += strToBeInserted
End If
                                ' -------------------------'added by Dipali V On 8th July 2020 For Check Validation of duplication


                                Dim strToBeAbbInserted As String = ""
                                Dim drstrShortJobTitle As IDataReader
                                Dim strShortJobTitle As String = ""
                                strToBeAbbInserted = ""

                                'Modified By VidyaJ on 24th Nov - exclude currently selected project in edit mode
                                If Args.PrimaryKeyValue.Trim <> "" Then
                                    'Get the project names
                                    drstrShortJobTitle = CommonFunction.Data.GetDataReader("SELECT DISTINCT ShortJobTitle FROM tbl_PM_Project Where ProjectID <>" + Args.PrimaryKeyValue.Trim, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                Else
                                    drstrShortJobTitle = CommonFunction.Data.GetDataReader("SELECT DISTINCT ShortJobTitle FROM tbl_PM_Project", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                End If
                                While drstrShortJobTitle.Read
                                    strShortJobTitle = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drstrShortJobTitle("ShortJobTitle"), ""), "").ToString().Trim()
                                    If strShortJobTitle <> "" Then
                                        If strToBeAbbInserted <> "" Then
                                            strToBeAbbInserted &= ","
                                        End If
                                        strToBeAbbInserted &= """" & strShortJobTitle & """"
                                    End If
                                End While
                                CommonFunction.Data.DisposeDataReader(drstrShortJobTitle)

                                If strToBeAbbInserted <> "" Then
                                    'Write script that will check whether the entered project name exists 
                                    'in the Project Names array. If it does, it will return false.

                                    ''Added by NitinC on 19 April 2012 for WhizibleSEM 11.0 [Issue Fix : 61258 Custom Field]
                                    'Args.ToBeInsertedInFunction = "if(ValidateCustomFields()==false){return;} " & vbCrLf
                                    ''End of Added by NitinC on 19 April 2012 for WhizibleSEM 11.0 [Issue Fix : 61258 Custom Field]
                                    strToBeAbbInserted = "var arrShortJobTitle=new Array(" & strToBeAbbInserted & ");" & vbCrLf
                                    strToBeAbbInserted &= "if (disallowDuplicates(GetObjectReference(""frmCommonPage"",""ShortJobTitle""),arrShortJobTitle,'&#39;Abbreviated Name &#39; already exists.',true,false))" & vbCrLf
                                    strToBeAbbInserted &= "{ return; }" & vbCrLf

                                    Args.ToBeInsertedInFunction += strToBeAbbInserted
                                End If

                                'End of added by Dipali V On 8th July 2020 For Check Validation of duplication
                                    'End of addition - ShamkantD on 25 Sep 2004
                                End If

                                '    '                      integrated by harshada d on 15 th june 2006 
                                '    '                      Integrated by PrajaktaR on 12th May for WhizibleSEM 6.0.1 IssueID 3736
                                '    '                      '--added by harshk on 18/07/05 
                                'Case CommonFunction.Constants.APP_TAG_PUBLISH_DELIVERABLE_PROJECT_CHECKLIST
                                '    If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                '        Args.ToBeInsertedInFunction = "window.close(); return;"
                                '    End If
                                '    '                      'end harshk on 18/07/05
                                '    '                      'END OF Integration by PrajaktaR on 12th May for WhizibleSEM 6.0.1 IssueID 3736
                                '    'end of integration by harshada d on 15 th june 2006

                                'Added by SiddharthS on 15 Feb 2005 For IssueID 15603
                                'Purpose:To validate change requested field in the project date range.
                        Case CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT
                                If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
                                    Dim strQuery As String = ""
                                    Dim drProjectDetails As IDataReader
                                    Dim strProjectStartDate As String = ""
                                    Dim strProjectEndDate As String = ""
                                    strQuery = "SELECT ExpectedStartDate, ExpectedEndDate FROM tbl_PM_Project WHERE ProjectID = " & HttpContext.Current.Session("intProjectID").ToString
                                    drProjectDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If drProjectDetails.Read() Then
                                        strProjectStartDate = CommonFunctions.General.CheckIsNothing(drProjectDetails.Item("ExpectedStartDate"), "")
                                        strProjectEndDate = CommonFunctions.General.CheckIsNothing(drProjectDetails.Item("ExpectedEndDate"), "")
                                        If strProjectStartDate <> "" Then strProjectStartDate = CommonFunctions.Dates.GetDate(CType(strProjectStartDate, Date))
                                        If strProjectEndDate <> "" Then strProjectEndDate = CommonFunctions.Dates.GetDate(CType(strProjectEndDate, Date))
                                    End If

                                    CommonFunctions.Data.DisposeDataReader(drProjectDetails)

                                    'Addition By PrachiK on 17 Feb 2005 for Issue ID. 16012
                                    'Purpose: To restrict Approved or Rejected Date less than Change Requested Date.
                                    Args.ToBeInsertedInFunction = "var objRejectedDate =GetObjectReference('frmCommonPage','RejectedDate');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "var objApprovedDate =GetObjectReference('frmCommonPage','ApprovedDate');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "var objChangeRequestDate =GetObjectReference('frmCommonPage','ChangeRequestDate');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objChangeRequestDate,objRejectedDate))  {" & vbCrLf

                                    'Modofied By MrugajaB on 4th April 2005
                                    'Purpose:Modified the message to be displayed
                                    'Args.ToBeInsertedInFunction += "alert('Please enter Rejected Date greater than Change Requested Date');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "alert('Rejected Date should not be less than Change Requested Date');" & vbCrLf
                                    'End Modification
                                    Args.ToBeInsertedInFunction += "return; }"
                                    Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objChangeRequestDate,objApprovedDate))  {" & vbCrLf

                                    'Modofied By MrugajaB on 4th April 2005
                                    'Purpose:Modified the message to be displayed
                                    'Args.ToBeInsertedInFunction += "alert('Please enter Approved Date greater than Change Requested Date');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "alert('Approved Date should not be less than Change Requested Date');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "return; }"
                                    'Addition Ended

                                    Args.ToBeInsertedInFunction += " var strMsg, dtProjectStartDate,  dtProjectEndDate, objChangeRequestDate,temp1,temp2;" + vbCrLf
                                    Args.ToBeInsertedInFunction += " var dtChangeRequestDate;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "dtProjectStartDate = getDate('" & strProjectStartDate & "');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "dtProjectEndDate = getDate('" & strProjectEndDate & "');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "objChangeRequestDate = GetObjectReference('frmCommonPage','ChangeRequestDate');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "dtChangeRequestDate = getDate(objChangeRequestDate.value);" + vbCrLf
                                    Args.ToBeInsertedInFunction += "if((dtChangeRequestDate < dtProjectStartDate) || (dtChangeRequestDate > dtProjectEndDate)){" + vbCrLf
                                    Args.ToBeInsertedInFunction += "alert('Change Requested Date should be between Project Start Date (" + strProjectStartDate + ") and Project End Date (" + strProjectEndDate + ")'  );" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;}" + vbCrLf
                                End If
                                'Addition ends. 

                                ''Added by ManishK on 12th jan 06 for Deliverable link on Change Management for Create Deliverables
                                If CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "")).ToUpper = "ADD_NEW" And CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), "")).ToUpper <> "SAVE" Then
                                    If Args.LinkName.ToUpper.Trim = "CONVERT TO DELIVERABLE" Then
                                        Cancel = True
                                    End If
                                End If
                                'Added by PrashantD on 9 March 2007 for IssueID 11443
                                If Args.LinkName.ToUpper.Trim = "CONVERT TO DELIVERABLE" Then
                                    If CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), "")).ToUpper = "SAVE" And CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubOperation"), "")).ToUpper = "ADD" Then
                                        Cancel = True
                                    End If
                                End If
                                'End of addition by PrashantD on 9 March 2007
                                If Args.ClientSideFunctionName.ToLower = "deliverable_onclick" Then
                                    Args.ToBeInsertedInFunction = "var objDeliverableID = GetObjectReference('frmCommonPage','DeliverableID');"
                                    Args.ToBeInsertedInFunction += "var objPK = GetObjectReference('frmCommonPage','ChangeRequestID_PK');"
                                    'Added By JyotiG
                                    'Start_JG_11490_15-Mar-2007
                                    'Issue : 1. Go to Project --> Chnage Request 2. Open a record in Edit mode 3. Collapse the section and Click on Convert to Deliverables link 
                                    ' Actual Result : Java Script Error displayed as Object Expected 
                                    'Added by ArchanaN on 7 Mar 2007 for Hexaware SP8 Upgrade Issue ID =11254
                                    Dim strQuery As String = ""
                                    Dim drDelDetails As IDataReader
                                    Dim strDeliverableID As String = ""

                                    strQuery = "SELECT DeliverableID FROM tbl_PM_ChangeRequest_Master WHERE ChangeRequestID='" & CType(Args.PrimaryKeyValue, String) & "'" '& HttpContext.Current.Request.QueryString("ChangeRequestID") & "'"

                                    drDelDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If drDelDetails.Read() Then
                                        strDeliverableID = CommonFunctions.General.CheckIsNothing(drDelDetails.Item("DeliverableID"), "")
                                    End If
                                CommonFunction.Data.DisposeDataReader(drDelDetails)
                                    Dim intSectionIDValue As String
                                    intSectionIDValue = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SectionIDValue"), "")
                                    'CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("SectionIDValue"))) 
                                    Args.ToBeInsertedInFunction += "intSectionIDValue='" & intSectionIDValue & "';"
                                    'Commented and Modified By JyotiG
                                    'Start_JG_11988_03-Apr-2007
                                    'Args.ToBeInsertedInFunction += "if((intSectionIDValue == '' || intSectionIDValue == '0') && ('" & strDeliverableID & "'=='' || '" & strDeliverableID & "'=='0')) {"
                                Args.ToBeInsertedInFunction += "if((intSectionIDValue == '' || intSectionIDValue == '0' || intSectionIDValue == '1') && ('" & strDeliverableID & "'=='' || '" & strDeliverableID & "'=='0')) {"
                                'End_JG_11988_03-Apr-2007
                                Args.ToBeInsertedInFunction += "window.open ('../PM/Create_Deliverables.aspx?FromWhere=PM&ChangeRequestID=' + objPK.value, '', 'resizable=yes,scrollbars=yes,left=' + ((window.screen.width - 700)/2) + ',top=' + ((window.screen.height - 600)/2) + ',width=700,height=300');return;}"
                                'Args.ToBeInsertedInFunction += "if(flag!=1){alert('Deliverable is already mapped to this request! '); return;}"

                                Args.ToBeInsertedInFunction += "else"
                                    Args.ToBeInsertedInFunction += "{"
                                    Args.ToBeInsertedInFunction += "alert('Deliverable is already mapped to this request! ');"
                                    Args.ToBeInsertedInFunction += "window.close(); return;} "
                                    'End by ArchanaN
                                    'End_JG_11490_15-Mar-2007

                                    'Args.ToBeInsertedInFunction += "alert(objPK.value);"
                                Args.ToBeInsertedInFunction += "if(objDeliverableID.value == ''|| objDeliverableID.value == 0) "
                                Args.ToBeInsertedInFunction += "{window.open ('../PM/Create_Deliverables.aspx?FromWhere=PM&ChangeRequestID=' + objPK.value, '', 'resizable=yes,scrollbars=yes,left=' + ((window.screen.width - 700)/2) + ',top=' + ((window.screen.height - 600)/2) + ',width=700,height=300');"
                                    Args.ToBeInsertedInFunction += "return;"
                                    Args.ToBeInsertedInFunction += "}else"
                                    Args.ToBeInsertedInFunction += "{"
                                    Args.ToBeInsertedInFunction += "alert('Deliverable is already mapped to this request! ');"
                                    Args.ToBeInsertedInFunction += "window.close(); return;} "
                                End If
                                ''End of Added by ManishK on 12th jan 06 for Deliverable link on Change Management for  Create Deliverables


                        Case CommonFunction.Constants.APP_TAG_RESOURCES

                                Dim intAllowResourceAllocation As Integer
                                'Integrated by SanaS on 25-Sep-2009
                            Dim intEnableProjectResourceAllocation As Integer
                            'End Integration by SanaS on 25-Sep-2009
                                'Modified By VidyaJ - Performance Issue - Resources - IssueID - 85
                                'Get whethere resource allocation workflow is applicable or not from application variable
'Integration by SanaS on 25-Sep-2009
                            'intAllowResourceAllocation = CType(CommonFunction.Application.AllowResourceAllocation, Integer)  'CType(CommonFunction.Data.GetDataScalar("SELECT AllowResourceAllocation from tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)
                            If CommonFunction.Application.AllowResourceAllocation Then
                                intAllowResourceAllocation = 1
                            Else
                                intAllowResourceAllocation = 0
                            End If

                            intEnableProjectResourceAllocation = intAllowResourceAllocation
                            If intAllowResourceAllocation = 0 Then
                                intEnableProjectResourceAllocation = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_IsProjectResourceAllocation " + WhizGlobal.ProjectID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                            End If
                            'End Integration by SanaS on 25-Sep-2009
                                'End Of Modifications
                                'Added By JyotiG
                                'Start_JG_12218_28-Mar-2007
                                'Issue : Project -> Project Management -> Plan -> Resource Management -> Resource :-
                                '1. Open a record in Edit Mode who has been released from Project.
                                '2. Collapse all the sections
                                '3. Click on the Re-assign link.
                                '4. Java Script error displayed.

                                Dim strKey As String
                                'UserID-LoginType-Identifier-ItemID
                                strKey = HttpContext.Current.Session("intUserID").ToString + "-" + WhizGlobal.LoginType.ToString + "-" + "SECTION_1" + "-" + WhizGlobal.TagID.ToString
                                If CommonEngines.HashTables.GetHashTableObject.GetHashTableUPFCache(strKey) = "0" Then
                                    If Args.ClientSideFunctionName.ToLower = "reassign" Then
                                        Cancel = True
                                    End If
                                End If
                            'End_JG_12218_28-Mar-2007
                            'Added By Chakshuta H on 11th-Apr-2016 Purpose:Resource Reallocation enhancement
                            If intAllowResourceAllocation = 1 Then
                                If Args.LinkName.ToUpper = "RESOURCE REALLOCATION" Then
                                    Cancel = True
                                End If
                            End If
                            'End Of Added By Chakshuta H on 11th-Apr-2016 Purpose:Resource Reallocation enhancement
                                If Args.ClientSideFunctionName.ToLower = "release" Then
                                    Dim ProjectDate As String

                                    ' Code Added by RajkumarM on 25th Sep 2006 to integrate changes for Release Resource Functionality
                                    Dim strSqlQuery As String
                                    strSqlQuery = "Select ISNULL(ResourceReleaseWorkFlow,0) FROM tbl_PM_CompanyInformation"
                                    'Get the status of 'Release resource WorkFlow  required' flag
                                    Dim intReleaseresourceWorkFlow As Boolean = False
                                    intReleaseresourceWorkFlow = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSqlQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
                                    If intReleaseresourceWorkFlow = False Then

                                        ' End of Code Addition by RajkumarM on 25th Sep 2006 to integrate changes 

                                        'Added by PrachiK on 17 Feb 2005 for IssueID 15570
                                        'Purpose:While releasing a user giving alert that if some  task are assigned to him and not allow  him to release in that case.
                                        'integrated by harshada d for issue id 288 on 19092005
                                        'Modified by PrajaktaR on 26th Aug 2005 for Alliance IssueID 20829. Added the condition for Tasks having "NULL" ReviewStatisticsID 
                                        'Dim strSQL As String = "select tbl_PM_ProjectEmployeeRole.employeeid from tbl_PM_ProjectEmployeeRole inner join tbl_PM_Projecttasks on tbl_PM_Projecttasks.employeeid = tbl_PM_ProjectEmployeeRole.employeeid where  isTaskComplete=0 and isactive=1 and tbl_PM_ProjectEmployeeRole.ProjectEmployeeRoleid=" & Args.PrimaryKeyValue & "and tbl_PM_Projecttasks.projectid= " & HttpContext.Current.Session("intProjectID").ToString
                                        'Added by ShraddhaM on 17,Sept 2008
                                        'Purpose : Resource Allocation from advanced searched resources in Whiziblesem8.0
                                        Dim ProjectID As String
                                        Dim PKValue As String

                                        PKValue = HttpContext.Current.Request.QueryString("PRJID")

                                        If PKValue Is Nothing Then
                                            PKValue = HttpContext.Current.Request.Form("hidPKValue")
                                        End If

                                        If PKValue <> "" Then
                                            ProjectID = PKValue
                                        Else
                                            ProjectID = HttpContext.Current.Session("intProjectID").ToString
                                        End If

                                        'End of addition by ShraddhaM on 17,Sept 2008
                                        'commented and added by ShraddhaM on 17,Sept 2008
                                        'Dim strSQL As String = "select tbl_PM_ProjectEmployeeRole.employeeid from tbl_PM_ProjectEmployeeRole inner join tbl_PM_Projecttasks on tbl_PM_Projecttasks.employeeid = tbl_PM_ProjectEmployeeRole.employeeid where isTaskComplete = 0 and isactive = 1 AND ReviewStatisticsID IS NULL and tbl_PM_ProjectEmployeeRole.ProjectEmployeeRoleid=" & Args.PrimaryKeyValue & "and tbl_PM_Projecttasks.projectid= " & HttpContext.Current.Session("intProjectID").ToString
                                        Dim strSQL As String = "select tbl_PM_ProjectEmployeeRole.employeeid from tbl_PM_ProjectEmployeeRole inner join tbl_PM_Projecttasks on tbl_PM_Projecttasks.employeeid = tbl_PM_ProjectEmployeeRole.employeeid where isTaskComplete = 0 and isactive = 1 AND ReviewStatisticsID IS NULL and tbl_PM_ProjectEmployeeRole.ProjectEmployeeRoleid=" & Args.PrimaryKeyValue & "and tbl_PM_Projecttasks.projectid= " & ProjectID
                                        'End of comment and addtion by ShraddhaM
                                        'End of Modification by PrajaktaR on 26th Aug 2005  for Alliance IssueID 20829
                                        'end of integration by harshada d for issue id 288 on 19092005
                                        Dim drReader As IDataReader
                                        Dim intRoleID As String
                                        If Args.PrimaryKeyValue = "" Then
                                            'integrated by harshada d for issue id 288 on 19092005
                                            'Modified by PrajaktaR on 26th Aug 2005 for Alliance IssueID 20829. Added the condition for Tasks having "NULL" ReviewStatisticsID 
                                            'strSQL = "select tbl_PM_ProjectEmployeeRole.employeeid from tbl_PM_ProjectEmployeeRole inner join tbl_PM_Projecttasks on tbl_PM_Projecttasks.employeeid = tbl_PM_ProjectEmployeeRole.employeeid where  isTaskComplete=0 and isactive=1 and tbl_PM_ProjectEmployeeRole.ProjectEmployeeRoleid=null and tbl_PM_Projecttasks.projectid= " & HttpContext.Current.Session("intProjectID").ToString
                                            strSQL = "select tbl_PM_ProjectEmployeeRole.employeeid from tbl_PM_ProjectEmployeeRole inner join tbl_PM_Projecttasks on tbl_PM_Projecttasks.employeeid = tbl_PM_ProjectEmployeeRole.employeeid where isTaskComplete = 0 and isactive = 1 AND ReviewStatisticsID IS NULL  and tbl_PM_ProjectEmployeeRole.ProjectEmployeeRoleid=null and tbl_PM_Projecttasks.projectid= " & ProjectID
                                            'End of Modification by PrajaktaR on 26th Aug 2005 for Alliance IssueID 20829
                                            'end of integration by harshada d for issue id 288 on 19092005
                                        End If
                                        drReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        If (drReader.Read) Then
                                            Args.ToBeInsertedInFunction = "alert('Please either Reallocate the task to some other resource or Mark the task as complete or Void the active tasks before releasing the resource');" & vbCrLf
                                            Args.ToBeInsertedInFunction += "{return;}" & vbCrLf
                                        End If
                                        CommonFunction.Data.DisposeDataReader(drReader)
                                        'End of Addtion

                                        'Review Type is not configured so...exit
                                        'Create object of the ProjectByNet Template Class
                                        objTemplate = New WebPages.Template.WhizTemplate
                                        'Initialize the Resources
                                        objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                        Dim strReleaseMsg As String = objTemplate.GetResourceString("RESOURCES_RELEASE")
                                        Dim strUpdateSkillsMsg As String = objTemplate.GetResourceString("RESOURCES_UPDATE_SKILLS")
                                        Args.ToBeInsertedInFunction += "if (!confirm(" + Chr(34) + strReleaseMsg + Chr(34) + ")) {return;} " + vbCrLf
                                        Args.ToBeInsertedInFunction += "if (confirm(" + Chr(34) + strUpdateSkillsMsg + Chr(34) + ")) {" + vbCrLf
                                        Args.ToBeInsertedInFunction += "objfrm.action=""../PM/PM_UpdateEmployeeSkills.aspx?ProjectEmployeeRoleID="" + intUniqueID ;" + vbCrLf
                                        Args.ToBeInsertedInFunction += "objfrm.submit();" + vbCrLf
                                        Args.ToBeInsertedInFunction += "return;} " + vbCrLf
                                        objTemplate = Nothing

                                        ' Code Added by RajkumarM on 25th Sep 2006 to integrate changes for Release Resource Functionality
                                    Else
                                        Dim strSQL As String
                                        Dim intReleaseresourceRelease As Boolean = False
                                        If Args.PrimaryKeyValue <> "" Then
                                            strSQL = "Usp_Sel_Isallowedtoreleaseresource_ReleaseResource " + Args.PrimaryKeyValue
                                            intReleaseresourceRelease = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
                                        End If
                                        If intReleaseresourceRelease = False Then
                                            'Review Type is not configured so...exit
                                            'Create object of the ProjectByNet Template Class
                                            objTemplate = New WebPages.Template.WhizTemplate
                                            'Initialize the Resources
                                            objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                            Dim strReleaseMsg As String = objTemplate.GetResourceString("RESOURCES_RELEASE")
                                            Dim strUpdateSkillsMsg As String = objTemplate.GetResourceString("RESOURCES_UPDATE_SKILLS")
                                            Args.ToBeInsertedInFunction += "if (!confirm(" + Chr(34) + strReleaseMsg + Chr(34) + ")) {return;} " + vbCrLf
                                            Args.ToBeInsertedInFunction += "if (confirm(" + Chr(34) + strUpdateSkillsMsg + Chr(34) + ")) {" + vbCrLf
                                            Args.ToBeInsertedInFunction += "objfrm.action=""../PM/PM_UpdateEmployeeSkills.aspx?ProjectEmployeeRoleID="" + intUniqueID ;" + vbCrLf
                                            Args.ToBeInsertedInFunction += "objfrm.submit();" + vbCrLf
                                            Args.ToBeInsertedInFunction += "return;} " + vbCrLf
                                            objTemplate = Nothing
                                        Else
                                            '  Args.ToBeInsertedInFunction = "window.open(""../PM/PM_ReleaseResource.aspx?UniqueID=" + Args.PrimaryKeyValue + """ "", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"", """", ""resizable=yes,scrollbars=no,left="" + ((window.screen.width - 800)/2) + "",top="" + ((window.screen.height - 600)/2) + "",width=800,height=600");""" + vbCrLf
                                            Args.ToBeInsertedInFunction = "window.open('../PM/PM_ReleaseResource.aspx?UniqueID=" & Args.PrimaryKeyValue.ToString & _
                                            "',"""", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + ((window.screen.width - 600)/2) + "",top="" + ((window.screen.height - 350)/2) + "",width=800,height=400"");return;"
                                        End If
                                    End If

                                    ' End of Code Addition by RajkumarM on 25th Sep 2006 to integrate changes 

                                ElseIf Args.ClientSideFunctionName.ToLower = "reassign" Then
                                    'REASSIGN THE RESOURCE
                                    ' added by harshada d for whiziblesem SP 7 issue , reassign link shud not be seen in add new mode on 10 july 2006
                                    Dim strmode As String
                                    'If Args.ClientSideFunctionName.ToLower = "reassign" Then
                                    strmode = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("mode"), "")
                                    'Modified by ShraddhaM on Date 17 July,2006 for WhizibleSEM Issue ID.4866
                                    Dim strOperation As String
                                    strOperation = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), "")
                                    Dim strSubOperation As String

                                    strSubOperation = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubOperation"), "")

                                    If (strmode.ToUpper = "ADD_NEW") Or (strOperation = "SAVE") Then
                                        Cancel = True
                                    Else
                                        ' end of addition by harshada d on 10 july 2006
                                        'End If
                                        'Integrated by SandipL SP8 to SP9

                                        'Added By JyotiG
                                        'Start_JG_9244_08-Jan-2007
                                        'Added by TruptiK on 28-Mar-2008 for Tentative releaving DatedtTentReleave
                                        Args.ToBeInsertedInFunction += "var dtTentReleave,objEndDate ;" + vbCrLf
                                        Args.ToBeInsertedInFunction += "dtTentReleave = GetObjectReference('frmCommonPage','NonDatabase6');" + vbCrLf
                                        Args.ToBeInsertedInFunction += "var objEndDate = GetObjectReference('frmCommonPage','ExpectedEndDate');" & vbCrLf
                                        'end of addition by TruptiK on 28-Mar-2008
                                        Args.ToBeInsertedInFunction += vbCrLf + "if (GetObjectReference('frmCommonPage', 'ReportingTo') != null){"
                                        'End_JG_9244_08-Jan-2007
                                        Args.ToBeInsertedInFunction += vbCrLf + "if (!ValidateForm_HeaderSection()) { return;}"
                                        'Added by TruptiK on 28-Mar-2008 for Tentative releaving DatedtTentReleave
                                        Args.ToBeInsertedInFunction += "if (disallowDate1LessThanOrEqualToDate2(dtTentReleave,objEndDate ,'Resource End Date on Project should be less than Resource Tentative Relieving Date (' + dtTentReleave.value + ')'))return;" + vbCrLf
                                        'End of Added TruptiK on 28-Mar-2008 for Tentative releaving DatedtTentReleave
                                        Args.ToBeInsertedInFunction += vbCrLf + "EnableControlsHeaderSection();"
                                        'Start_JG_9244_08-Jan-2007
                                        Args.ToBeInsertedInFunction += vbCrLf + "}"
                                        'End_JG_9244_08-Jan-2007
                                        'End Integration by SandipL SP8 to SP9
                                        '''Added by PrashantSJ on 17th Aug 2009 Purpose: SEM 9.0 Re-Assign resource below joining date issue
                                        Dim oTemplate As New WebPages.Template.WhizTemplate
                                        'Initialize the Resources
                                        oTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                        Args.ToBeInsertedInFunction += "var objStartDate = GetObjectReference('frmCommonPage','ExpectedStartDate');" + vbCrLf
                                        Args.ToBeInsertedInFunction += "var objUserName = GetObjectReference('frmCommonPage','UserName');" + vbCrLf
                                        Args.ToBeInsertedInFunction += "var dtStartDate = getDate(objStartDate.value);" + vbCrLf
                                        Args.ToBeInsertedInFunction += " var dtJoiningDate,ObjJoiningDate;" + vbCrLf
                                        Args.ToBeInsertedInFunction += "ObjJoiningDate = GetObjectReference('frmCommonPage','NonDatabase3');" + vbCrLf
                                        Args.ToBeInsertedInFunction += "dtJoiningDate = getDate(ObjJoiningDate.value);" + vbCrLf
                                        Args.ToBeInsertedInFunction += "if((dtStartDate != null) && (dtJoiningDate != null)){" + vbCrLf
                                        Args.ToBeInsertedInFunction += "if(dtStartDate < dtJoiningDate){" + vbCrLf
                                        Args.ToBeInsertedInFunction += "strMsg='" & oTemplate.GetResourceString("MSG_RESOURCE_JOINING_DATE") & "';" + vbCrLf
                                        Args.ToBeInsertedInFunction += "strMsg = replaceSubstring(strMsg, '<=>', ObjJoiningDate.value);" + vbCrLf
                                        Args.ToBeInsertedInFunction += "strMsg = replaceSubstring(strMsg, '<==>',objUserName.value  );" + vbCrLf
                                        Args.ToBeInsertedInFunction += "alert(strMsg);" + vbCrLf
                                        Args.ToBeInsertedInFunction += "return;}}" + vbCrLf

                                        oTemplate = Nothing
                                        '''End of addition by PrashantSJ on 17th Aug 2009 Purpose: SEM 9.0 Re-Assign resource below joining date issue

                                    End If
                                    '##### Condition Added For Resource Timesheet Flow
                                    'Code added by MangeshY on 24 July 2004
                                ElseIf Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then

                                    Dim strPrevScript As String
                                    Dim objAppResource As WebPages.Template.WhizTemplate
                                    Dim ProjectID As String
                                    Dim PKValue As String

                                    objAppResource = New WebPages.Template.WhizTemplate
                                    objAppResource.InitializeResources("AppResources.EventHandlers", "AppResources")
                                    'Added by ShraddhaM on 17,Sept 2008
                                    'Purpose : Resource Allocation from advanced searched resources in Whiziblesem8.0
                                    PKValue = HttpContext.Current.Request.QueryString("PRJID")

                                    If PKValue Is Nothing Then
                                        PKValue = HttpContext.Current.Request.Form("hidPKValue")
                                    End If

                                    If PKValue <> "" Then
                                        ProjectID = PKValue
                                    Else
                                        ProjectID = HttpContext.Current.Session("intProjectID").ToString
                                    End If

                                    'End of addition by ShraddhaM on 17,Sept 2008
                                    With Args
                                        strPrevScript = .ToBeInsertedInFunction
                                        .ToBeInsertedInFunction = " var objApprover ,objReportingTo, objApproverDisabled , strDisable; " + vbCrLf
                                        .ToBeInsertedInFunction += " objApprover = GetObjectReference('frmCommonPage','IsDefaultApprover'); " + vbCrLf

                                        .ToBeInsertedInFunction += " objApproverDisabled = GetObjectReference('frmCommonPage','NonDatabase2'); " + vbCrLf
                                        .ToBeInsertedInFunction += " strDisable = new String(objApproverDisabled.value) ; " + vbCrLf
                                        .ToBeInsertedInFunction += " if(objApprover!=null) { " + vbCrLf
                                        .ToBeInsertedInFunction += " strVal= new String(objApprover.checked); " + vbCrLf
                                        'Commented and Modified By JyotiG
                                        'Date : 05-Oct-2006
                                        'Issue ID : 6654
                                        'Purpose : for default approver reporting to is compulsory
                                        'Start
                                        '.ToBeInsertedInFunction += " if( (strVal.toUpperCase() != 'TRUE') && (strDisable.length == 0) )  { " + vbCrLf
                                        .ToBeInsertedInFunction += " if(1)  { " + vbCrLf
                                        'End of modification By JyotiG    
                                        .ToBeInsertedInFunction += " objReportingTo = GetObjectReference('frmCommonPage','ReportingTo'); " + vbCrLf

                                        .ToBeInsertedInFunction += " if(objReportingTo!=null) { " + vbCrLf

                                        .ToBeInsertedInFunction += " strVal= new String(objReportingTo.selectedIndex); " + vbCrLf
                                        'Modified by PrashantD on 21 March 2007 for Cleanup Acrivity
                                        'Dim strSQLQuery As String = "SELECT Count(ProjectEmployeeRoleId) ProjectEmployeeRoleId FROM d_tbl_PM_ProjectEmployeeRole WHERE ProjectId = " + CType(HttpContext.Current.Session("intProjectID"), String)

                                        'commented and added by ShraddhaM on 17,Sept 2008
                                        'Dim strSQLQuery As String = "SELECT TOP 1 1  ProjectEmployeeRoleId FROM d_tbl_PM_ProjectEmployeeRole WHERE ProjectId = " + CType(HttpContext.Current.Session("intProjectID"), String)
                                        Dim strSQLQuery As String = "SELECT TOP 1 1  ProjectEmployeeRoleId FROM d_tbl_PM_ProjectEmployeeRole WHERE ProjectId = " + ProjectID
                                        'End of commented and added by ShraddhaM on 17,Sept 2008
                                        'End of modification by PrashantD on 21 March 2007
                                        Dim drReportingTo As IDataReader = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                        If drReportingTo.Read Then
                                            If CType(CommonFunctions.Data.CheckIsDBNull(drReportingTo("ProjectEmployeeRoleId"), "0"), Integer) > 0 Then
                                                .ToBeInsertedInFunction += " if(strVal == '0' ) { " + vbCrLf
                                                .ToBeInsertedInFunction += " alert('Please enter value for Reporting To.')  " + vbCrLf
                                                'Added By VarunA on 20-June-2007 Whizible Regeression Project Issue-12321
                                                'Purpose : To have the focus on ReportingTo
                                                .ToBeInsertedInFunction += "objReportingTo.focus(); "
                                            'End By VarunA on 20-June-2007 Issue-12321
                                            .ToBeInsertedInFunction += "return false;" + vbCrLf
                                            .ToBeInsertedInFunction += " } " + vbCrLf
                                        End If
                                    End If

                                    CommonFunctions.Data.DisposeDataReader(drReportingTo)

                                    .ToBeInsertedInFunction += " } " + vbCrLf
                                    .ToBeInsertedInFunction += " } " + vbCrLf
                                    .ToBeInsertedInFunction += " } " + vbCrLf
                                    .ToBeInsertedInFunction += strPrevScript
                                    'Added by PrachiK on 23 Feb 2005 for IssueID 16383
                                    'Purpose:To Validate the date fields
                                    Args.ToBeInsertedInFunction += "var objStartDate = GetObjectReference('frmCommonPage','ExpectedStartDate');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "var objEndDate = GetObjectReference('frmCommonPage','ExpectedEndDate');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objStartDate,objEndDate))  {" & vbCrLf
                                    Args.ToBeInsertedInFunction += "alert('Please enter End Date greater than Start Date');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "return; }"
                                    'Addtion Ended
                                End With
                                'End Addition
                                '##### End Of Condiiton added For Resource Timesheet Flow

                                'Code Added by Noble K on 19th Jan 2005 To enforce Validation of Start Date and End Date between 
                                'Project Start Date and Project End Date
                                Dim strQuery As String = ""
                                Dim drProjectDetails As IDataReader
                                Dim strProjectStartDate As String = ""
                                Dim strProjectEndDate As String = ""
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")


                                'End of addition by ShraddhaM on 17,Sept 2008
                                'commented and added by ShraddhaM on 17,Sept 2008
                                'strQuery = "SELECT ExpectedStartDate, ExpectedEndDate FROM tbl_PM_Project WHERE ProjectID = " & HttpContext.Current.Session("intProjectID").ToString
                                strQuery = "SELECT ExpectedStartDate, ExpectedEndDate FROM tbl_PM_Project WHERE ProjectID = " & ProjectID
                                'End of comment and addition by ShraddhaM on 17,Sept 2008

                                drProjectDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drProjectDetails.Read() Then
                                    strProjectStartDate = CommonFunctions.General.CheckIsNothing(drProjectDetails.Item("ExpectedStartDate"), "")
                                    strProjectEndDate = CommonFunctions.General.CheckIsNothing(drProjectDetails.Item("ExpectedEndDate"), "")
                                    If strProjectStartDate <> "" Then strProjectStartDate = CommonFunctions.Dates.GetDate(CType(strProjectStartDate, Date))
                                    If strProjectEndDate <> "" Then strProjectEndDate = CommonFunctions.Dates.GetDate(CType(strProjectEndDate, Date))
                                End If
                                CommonFunctions.Data.DisposeDataReader(drProjectDetails)

                                Args.ToBeInsertedInFunction += " var strMsg, dtProjectStartDate,  dtProjectEndDate, dtStartDate, dtEndDate,dtTentReleave;" + vbCrLf
                                Args.ToBeInsertedInFunction += " var objStartDate, objEndDate;" + vbCrLf
                                Args.ToBeInsertedInFunction += "dtProjectStartDate = getDate('" & strProjectStartDate & "');" + vbCrLf
                                Args.ToBeInsertedInFunction += "dtProjectEndDate = getDate('" & strProjectEndDate & "');" + vbCrLf
                                Args.ToBeInsertedInFunction += "objStartDate = GetObjectReference('frmCommonPage','ExpectedStartDate');" + vbCrLf
                                Args.ToBeInsertedInFunction += "dtStartDate = getDate(objStartDate.value);" + vbCrLf
                                Args.ToBeInsertedInFunction += "objEndDate = GetObjectReference('frmCommonPage','ExpectedEndDate');" + vbCrLf
                                Args.ToBeInsertedInFunction += "dtEndDate = getDate(objEndDate.value);" + vbCrLf
                                Args.ToBeInsertedInFunction += "dtTentReleave = GetObjectReference('frmCommonPage','NonDatabase6');" + vbCrLf
                                Args.ToBeInsertedInFunction += "if((dtProjectStartDate != null) && (dtProjectEndDate != null) && (dtStartDate != null) && (dtEndDate != null)){" + vbCrLf
                                Args.ToBeInsertedInFunction += "if((dtStartDate < dtProjectStartDate) || (dtStartDate > dtProjectEndDate) || (dtEndDate > dtProjectEndDate)){" + vbCrLf
                                Args.ToBeInsertedInFunction += "strMsg='" & objTemplate.GetResourceString("DATES_BETWEEN_PROJECTDATES") & "';" + vbCrLf
                                Args.ToBeInsertedInFunction += "strMsg = replaceSubstring(strMsg, '<=>', '" & strProjectStartDate & "');" + vbCrLf
                                Args.ToBeInsertedInFunction += "strMsg = replaceSubstring(strMsg, '<==>', '" & strProjectEndDate & "');" + vbCrLf
                                Args.ToBeInsertedInFunction += "alert(strMsg);" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;}}" + vbCrLf
                                'addedby harshk for sp4 issueID 120,121 on 22/08/05
                                'Added by ArchanaN on 13 Fen 2008 for Tentative releaving DatedtTentReleave
                                Args.ToBeInsertedInFunction += "if (disallowDate1LessThanOrEqualToDate2(dtTentReleave,objEndDate ,'Resource End Date on Project should be less than Resource Tentative Relieving Date (' + dtTentReleave.value + ')'))return;" + vbCrLf
                                'End of Added by ArchanaN on 13 Fen 2008 for Tentative releaving DatedtTentReleave
                                Args.ToBeInsertedInFunction += " var dtJoiningDate,ObjJoiningDate;" + vbCrLf
                                Args.ToBeInsertedInFunction += "ObjJoiningDate = GetObjectReference('frmCommonPage','NonDatabase3');" + vbCrLf
                                Args.ToBeInsertedInFunction += "dtJoiningDate = getDate(ObjJoiningDate.value);" + vbCrLf
                                Args.ToBeInsertedInFunction += "if((dtStartDate != null) && (dtJoiningDate != null)){" + vbCrLf
                                Args.ToBeInsertedInFunction += "if(dtStartDate < dtJoiningDate){" + vbCrLf
                                Args.ToBeInsertedInFunction += "strMsg='" & objTemplate.GetResourceString("MSG_RESOURCE_JOINING_DATE") & "';" + vbCrLf
                                Args.ToBeInsertedInFunction += "strMsg = replaceSubstring(strMsg, '<=>', ObjJoiningDate.value);" + vbCrLf
                                ' Modified By NitinVS on 13 Apr 2007 for WhizibleSEM SP 8 Regression Issues 
                                ' To remove dependancy on nondatabase 1 field as it will not be shown in edit mode
                                Dim strUserName As String
                                If Args.PrimaryKeyValue <> "" Then
                                    strUserName = CType(CommonFunctions.Data.GetDataScalar("SELECT IsNull( UserName , '') as UserName FROM tbl_PM_Employee E join Tbl_PM_ProjectEmployeeRole PE on E.employeeID =PE.EmployeeID WHERE ProjectEmployeeroleID = " + Args.PrimaryKeyValue.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
                                    'Args.ToBeInsertedInFunction += "strMsg = replaceSubstring(strMsg, '<==>', GetObjectReference('frmCommonPage','NonDatabase1').value);" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strMsg = replaceSubstring(strMsg, '<==>', '" + Replace(strUserName, "'", "\'") + "' );" + vbCrLf
                                Else
                                    Args.ToBeInsertedInFunction += " var objnde1value='', objnd1 = GetObjectReference('frmCommonPage','NonDatabase1'); " + vbCrLf
                                    Args.ToBeInsertedInFunction += " if(objnd1 != null ) { objnde1value = objnd1.value ;}" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strMsg = replaceSubstring(strMsg, '<==>', objnde1value );" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strMsg = replaceSubstring(strMsg, '<==>', '" + Replace(strUserName, "'", "\'") + "' );" + vbCrLf
                                End If



                                'End Modification By NitinVS on 13 Apr 2007 for WhizibleSEM SP 8 Regression Issues 

                                Args.ToBeInsertedInFunction += "alert(strMsg);" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;}}" + vbCrLf

                                'end added by harshk for sp4 issueID 120,121  on 22/08/05
                                ' Added By PradeepD on 8-Dec-2005 to resolve Tavant Issue 17713 Duplicated Resources on project

                                'Dim From As String
                                'From = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("From"), "PM")
                                'If From = "RCV" Then
                                'Args.ToBeInsertedInFunction += "if (blnIsSaveClicked == 1){ "
                                'Args.ToBeInsertedInFunction += "window.opener.location='CommonList.aspx?FromWhere=PM&MasterTagId=1019&From=RCV'; return;}" + vbCrLf
                                'Args.ToBeInsertedInFunction += "blnIsSaveClicked =1;" + vbCrLf
                                'Else

                                Args.ToBeInsertedInFunction += "if (blnIsSaveClicked == 1){ "
                                ''''''''''''''''''''''''''''''

                                'Args.ToBeInsertedInFunction += "if(window.opener!=null) {" + vbCrLf
                                'Args.ToBeInsertedInFunction += "var strParentPage;" + vbCrLf
                                'Args.ToBeInsertedInFunction += "strParentPage = new String();" + vbCrLf

                                'Args.ToBeInsertedInFunction += "strParentPage = opener.location.href;" + vbCrLf

                                'Args.ToBeInsertedInFunction += "if (strParentPage.toUpperCase().indexOf('GanttChartView.aspx') != -1)" + vbCrLf
                                'Args.ToBeInsertedInFunction += "{" + vbCrLf
                                'Args.ToBeInsertedInFunction += "window.opener.location = '../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" & CommonFunction.Constants.APP_TAG_RESOURCES.ToString + "';" + vbCrLf
                                ''Args.ToBeInsertedInFunction += "try{window.opener.document.forms['frmGanttChartView'].submit();}catch(e){}" + vbCrLf
                                'Args.ToBeInsertedInFunction += "}" + vbCrLf
                                'Args.ToBeInsertedInFunction += "else" + vbCrLf
                                Args.ToBeInsertedInFunction += "window.opener.location='CommonList.aspx?FromWhere=PM&MasterTagId=1019';" + vbCrLf
                                'Args.ToBeInsertedInFunction += "}" + vbCrLf
                                '''''''''''''''''''''''''''''''
                                Args.ToBeInsertedInFunction += " return;}" + vbCrLf
                                Args.ToBeInsertedInFunction += "blnIsSaveClicked =1;" + vbCrLf

                                'End If

                                ' End: Added By PradeepD on 8-Dec-2005 to resolve Tavant Issue 17713 Duplicated Resources on project  
                                objTemplate = Nothing
                                'Code Added by Noble K on 19th Jan 2005 Ends

                                '--- Added for Priyanka, 6th Sep 2004
                                '--- Check for Project Status. If On Hold, do not allow to add resources
                                'Modified By VidyaJ - Performance Issue - Resources - IssueID - 85
                                ''Added by shraddhaM on 18 july 2006 for for WhizibleSEM
                                ''Args.ToBeInsertedInFunction += "alert(Args.ClientSideFunctionName.ToLower);" + vbCrLf
                                ''Args.ToBeInsertedInFunction += "alert('hi');" + vbCrLf
                                'Dim drStatus As IDataReader
                                'Dim blnProjectOnHold As Boolean, strOnHoldMessage As String
                                ''Added by ShamkantD on Friday, September 24, 2004
                                'Dim intBaselineNumber As Integer = 0, strBaselineMessage As String = ""
                                ''End of addition - ShamkantD on Friday, September 24, 2004
                                'drStatus = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_CNF_Project_Status " & HttpContext.Current.Session("intProjectID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'If drStatus.Read() Then
                                '    blnProjectOnHold = CType(CommonFunction.Data.CheckIsDBNull(drStatus("ProjectOnHold"), "False"), Boolean)
                                '    strOnHoldMessage = CType(CommonFunction.Data.CheckIsDBNull(drStatus("ProjectOnHoldMsg"), ""), String)

                                '    'Added by ShamkantD on Friday, September 24, 2004
                                '    intBaselineNumber = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drStatus("BaselineNumber"), "0"), "0"), Integer)
                                '    strBaselineMessage = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drStatus("BaseLineMessage"), ""), ""), String)
                                '    'End of addition - ShamkantD on Friday, September 24, 2004
                                'End If
                                'CommonFunction.Data.DisposeDataReader(drStatus)

                                'If blnProjectOnHold = True Then
                                '    Args.ToBeInsertedInFunction = "alert('" & strOnHoldMessage & "'); " & vbCrLf
                                '    Args.ToBeInsertedInFunction &= "return;"
                                'End If

                                ''Added by ShamkantD on Friday, September 24, 2004
                                ''Get the status of 'Project creation workflow required' flag
                                'Dim blnIsProjectCreationWorkflowReqd As Boolean = False
                                'blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
                                'If blnIsProjectCreationWorkflowReqd = True Then
                                '    If intBaselineNumber = 0 Then
                                '        Args.ToBeInsertedInFunction = "alert('" & strBaselineMessage & "'); " & vbCrLf
                                '        Args.ToBeInsertedInFunction &= "return;"
                                '    End If
                                'End If
                                ''End of addition - ShamkantD on Friday, September 24, 2004
                                ''--- End Of Addition

                                ''End If
                                'Modified By ShraddhaM on 20 July 2006
                            ElseIf Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then

                                'Added by ShraddhaM on 17,Sept 2008
                                'Purpose : Resource Allocation from advanced searched resources in Whiziblesem8.0
                                '           To hide link when we assign resource
                                Dim PKValues As String

                                PKValues = HttpContext.Current.Request.QueryString("PRJID")

                                If PKValues Is Nothing Then
                                    PKValues = HttpContext.Current.Request.Form("hidPKValue")
                                End If

                                If PKValues <> "" Then
                                    Cancel = True
                                    Exit Select
                                End If

                                'End of addition by ShraddhaM

                                Dim strPrevScript As String
                                Dim objAppResource As WebPages.Template.WhizTemplate
                                objAppResource = New WebPages.Template.WhizTemplate
                                objAppResource.InitializeResources("AppResources.EventHandlers", "AppResources")

                                With Args
                                    strPrevScript = .ToBeInsertedInFunction
                                    .ToBeInsertedInFunction = " var objApprover ,objReportingTo, objApproverDisabled , strDisable,dtTentReleave; " + vbCrLf
                                    .ToBeInsertedInFunction += " objApprover = GetObjectReference('frmCommonPage','IsDefaultApprover'); " + vbCrLf

                                    .ToBeInsertedInFunction += " objApproverDisabled = GetObjectReference('frmCommonPage','NonDatabase2'); " + vbCrLf
                                    .ToBeInsertedInFunction += " strDisable = new String(objApproverDisabled.value) ; " + vbCrLf
                                    'Added by TruptiK on 28-Mar-2008
                                    Args.ToBeInsertedInFunction += "dtTentReleave = GetObjectReference('frmCommonPage','NonDatabase6');" + vbCrLf
                                    'End of addition by TruptiK
                                    .ToBeInsertedInFunction += " if(objApprover!=null) { " + vbCrLf
                                    .ToBeInsertedInFunction += " strVal= new String(objApprover.checked); " + vbCrLf

                                    .ToBeInsertedInFunction += " if( (strVal.toUpperCase() != 'TRUE') && (strDisable.length == 0) )  { " + vbCrLf

                                    .ToBeInsertedInFunction += " objReportingTo = GetObjectReference('frmCommonPage','ReportingTo'); " + vbCrLf

                                    .ToBeInsertedInFunction += " if(objReportingTo!=null) { " + vbCrLf

                                    .ToBeInsertedInFunction += " strVal= new String(objReportingTo.selectedIndex); " + vbCrLf

                                    Dim strSQLQuery As String = "SELECT Count(ProjectEmployeeRoleId) ProjectEmployeeRoleId FROM d_tbl_PM_ProjectEmployeeRole WHERE ProjectId = " + CType(HttpContext.Current.Session("intProjectID"), String)
                                    Dim drReportingTo As IDataReader = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    If drReportingTo.Read Then
                                        If CType(CommonFunctions.Data.CheckIsDBNull(drReportingTo("ProjectEmployeeRoleId"), "0"), Integer) > 0 Then
                                            .ToBeInsertedInFunction += " if(strVal == '0' ) { " + vbCrLf
                                            .ToBeInsertedInFunction += " alert('Please enter value for Reporting To.')  " + vbCrLf
                                            'Added By VarunA on 20-June-2007 Whizible Regeression Project Issue-12321
                                            'Purpose : To have the focus on ReportingTo
                                            .ToBeInsertedInFunction += "objReportingTo.focus(); "
                                            'End By VarunA on 20-June-2007 Issue-12321
                                            .ToBeInsertedInFunction += "return ;" + vbCrLf
                                            .ToBeInsertedInFunction += " } " + vbCrLf
                                        End If
                                    End If

                                    CommonFunctions.Data.DisposeDataReader(drReportingTo)

                                    .ToBeInsertedInFunction += " } " + vbCrLf
                                    .ToBeInsertedInFunction += " } " + vbCrLf
                                    .ToBeInsertedInFunction += " } " + vbCrLf
                                    .ToBeInsertedInFunction += strPrevScript
                                    'Added by PrachiK on 23 Feb 2005 for IssueID 16383
                                    'Purpose:To Validate the date fields
                                    Args.ToBeInsertedInFunction += "var objStartDate = GetObjectReference('frmCommonPage','ExpectedStartDate');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "var objEndDate = GetObjectReference('frmCommonPage','ExpectedEndDate');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objStartDate,objEndDate))  {" & vbCrLf
                                    Args.ToBeInsertedInFunction += "alert('Please enter End Date greater than Start Date');" & vbCrLf
                                    Args.ToBeInsertedInFunction += "return; }"
                                    'Added by TruptiK on 28-Mar-2008 for Tentative releaving DatedtTentReleave
                                    Args.ToBeInsertedInFunction += "if (disallowDate1LessThanOrEqualToDate2(dtTentReleave,objEndDate ,'Resource End Date on Project should be less than Resource Tentative Relieving Date (' + dtTentReleave.value + ')'))return;" + vbCrLf
                                    'End of Added TruptiK on 28-Mar-2008 for Tentative releaving DatedtTentReleave
                                    'Addtion Ended
                                End With
                                'End Addition
                                '##### End Of Condiiton added For Resource Timesheet Flow

                                'Code Added by Noble K on 19th Jan 2005 To enforce Validation of Start Date and End Date between 
                                'Project Start Date and Project End Date
                                Dim strQuery As String = ""
                                Dim drProjectDetails As IDataReader
                                Dim strProjectStartDate As String = ""
                                Dim strProjectEndDate As String = ""
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                'Added by ShraddhaM on 17,Sept 2008
                                'Purpose : Resource Allocation from advanced searched resources in Whiziblesem8.0
                                Dim ProjectID As String
                                Dim PKValue As String

                                PKValue = HttpContext.Current.Request.QueryString("PRJID")

                                If PKValue Is Nothing Then
                                    PKValue = HttpContext.Current.Request.Form("hidPKValue")
                                End If

                                If PKValue <> "" Then
                                    ProjectID = PKValue
                                Else
                                    ProjectID = HttpContext.Current.Session("intProjectID").ToString
                                End If

                                'End of addition by ShraddhaM on 17,Sept 2008
                                'commented and added by ShraddhaM on 17,Sept 2008
                                strQuery = "SELECT ExpectedStartDate, ExpectedEndDate FROM tbl_PM_Project WHERE ProjectID = " & ProjectID
                                'strQuery = "SELECT ExpectedStartDate, ExpectedEndDate FROM tbl_PM_Project WHERE ProjectID = " & HttpContext.Current.Session("intProjectID").ToString
                                'End of comment and addition by ShraddhaM on 17,Sept 2008

                                drProjectDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drProjectDetails.Read() Then
                                    strProjectStartDate = CommonFunctions.General.CheckIsNothing(drProjectDetails.Item("ExpectedStartDate"), "")
                                    strProjectEndDate = CommonFunctions.General.CheckIsNothing(drProjectDetails.Item("ExpectedEndDate"), "")
                                    If strProjectStartDate <> "" Then strProjectStartDate = CommonFunctions.Dates.GetDate(CType(strProjectStartDate, Date))
                                    If strProjectEndDate <> "" Then strProjectEndDate = CommonFunctions.Dates.GetDate(CType(strProjectEndDate, Date))
                                End If
                                CommonFunctions.Data.DisposeDataReader(drProjectDetails)

                                Args.ToBeInsertedInFunction += " var strMsg, dtProjectStartDate,  dtProjectEndDate, dtStartDate, dtEndDate;" + vbCrLf
                                Args.ToBeInsertedInFunction += " var objStartDate, objEndDate;" + vbCrLf
                                Args.ToBeInsertedInFunction += "dtProjectStartDate = getDate('" & strProjectStartDate & "');" + vbCrLf
                                Args.ToBeInsertedInFunction += "dtProjectEndDate = getDate('" & strProjectEndDate & "');" + vbCrLf
                                Args.ToBeInsertedInFunction += "objStartDate = GetObjectReference('frmCommonPage','ExpectedStartDate');" + vbCrLf
                                Args.ToBeInsertedInFunction += "dtStartDate = getDate(objStartDate.value);" + vbCrLf
                                Args.ToBeInsertedInFunction += "objEndDate = GetObjectReference('frmCommonPage','ExpectedEndDate');" + vbCrLf
                                Args.ToBeInsertedInFunction += "dtEndDate = getDate(objEndDate.value);" + vbCrLf
                                Args.ToBeInsertedInFunction += "if((dtProjectStartDate != null) && (dtProjectEndDate != null) && (dtStartDate != null) && (dtEndDate != null)){" + vbCrLf
                                Args.ToBeInsertedInFunction += "if((dtStartDate < dtProjectStartDate) || (dtStartDate > dtProjectEndDate) || (dtEndDate > dtProjectEndDate)){" + vbCrLf
                                Args.ToBeInsertedInFunction += "strMsg='" & objTemplate.GetResourceString("DATES_BETWEEN_PROJECTDATES") & "';" + vbCrLf
                                Args.ToBeInsertedInFunction += "strMsg = replaceSubstring(strMsg, '<=>', '" & strProjectStartDate & "');" + vbCrLf
                                Args.ToBeInsertedInFunction += "strMsg = replaceSubstring(strMsg, '<==>', '" & strProjectEndDate & "');" + vbCrLf
                                Args.ToBeInsertedInFunction += "alert(strMsg);" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;}}" + vbCrLf
                                'addedby harshk for sp4 issueID 120,121 on 22/08/05
                                Args.ToBeInsertedInFunction += " var dtJoiningDate,ObjJoiningDate;" + vbCrLf
                                Args.ToBeInsertedInFunction += "ObjJoiningDate = GetObjectReference('frmCommonPage','NonDatabase3');" + vbCrLf
                                Args.ToBeInsertedInFunction += "dtJoiningDate = getDate(ObjJoiningDate.value);" + vbCrLf
                                Args.ToBeInsertedInFunction += "if((dtStartDate != null) && (dtJoiningDate != null)){" + vbCrLf
                                Args.ToBeInsertedInFunction += "if(dtStartDate < dtJoiningDate){" + vbCrLf
                                Args.ToBeInsertedInFunction += "strMsg='" & objTemplate.GetResourceString("MSG_RESOURCE_JOINING_DATE") & "';" + vbCrLf
                                Args.ToBeInsertedInFunction += "strMsg = replaceSubstring(strMsg, '<=>', ObjJoiningDate.value);" + vbCrLf
                                Args.ToBeInsertedInFunction += "strMsg = replaceSubstring(strMsg, '<==>', GetObjectReference('frmCommonPage','NonDatabase1').value);" + vbCrLf
                                Args.ToBeInsertedInFunction += "alert(strMsg);" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;}}" + vbCrLf
                                'end added by harshk for sp4 issueID 120,121  on 22/08/05
                                ' Integration by SanaS on 25-Sep-2009
                                ''Added by PrashantSJ on 29th Aug 2009 For S1-%allocation validation
                                'If intEnableProjectResourceAllocation = 1 Then
                                '    Args.ToBeInsertedInFunction += "var StartDate=GetObjectReference('frmCommonPage','ExpectedStartDate');"
                                '    Args.ToBeInsertedInFunction += "var EndDate=GetObjectReference('frmCommonPage','ExpectedEndDate');"
                                '    Args.ToBeInsertedInFunction += "var objEmployeeID=GetObjectReference('frmCommonPage','EmployeeID');"
                                '    Args.ToBeInsertedInFunction += "strURL='../General/XMLHttp.aspx?TagID=1019&Action=ALLOCATIONVALIDATION&ProjectID=" + ProjectID.ToString + "&FromDate='+encodeURIComponent(StartDate.value)+'&ToDate='+encodeURIComponent(EndDate.value)+'&EmployeeID='+objEmployeeID.value;"
                                '    Args.ToBeInsertedInFunction += " if(loadAllocXMLDoc(strURL,'')!= true && Msgg !='') {"
                                '    Args.ToBeInsertedInFunction += "alert(Msgg); return;}"
                                'Else
                                '    Args.ToBeInsertedInFunction += "var objRP=GetObjectReference('','ResourcePercentage');"
                                '    Args.ToBeInsertedInFunction += "if(parseFloat(objRP.value) < 0 || parseFloat(objRP.value) > 100)"
                                '    Args.ToBeInsertedInFunction += "{alert('% Allocation should be between 0 and 100 !');return;}"
                                'End If
                                '''//////////////////////////////////////////////////////////////////
                                ''End Integration by SanaS on 25-Sep-2009
                                ' Added By PradeepD on 8-Dec-2005 to resolve Tavant Issue 17713 Duplicated Resources on project
                                Args.ToBeInsertedInFunction += "if (blnIsSaveClicked == 1){ "
                                Args.ToBeInsertedInFunction += "window.opener.location='CommonList.aspx?FromWhere=PM&MasterTagId=1019'; return;}" + vbCrLf
                                Args.ToBeInsertedInFunction += "blnIsSaveClicked =1;" + vbCrLf
                                ' End: Added By PradeepD on 8-Dec-2005 to resolve Tavant Issue 17713 Duplicated Resources on project  
                                objTemplate = Nothing
                                'Code Added by Noble K on 19th Jan 2005 Ends

                                '--- Added for Priyanka, 6th Sep 2004
                                '--- Check for Project Status. If On Hold, do not allow to add resources
                                'Modified By VidyaJ - Performance Issue - Resources - IssueID - 85
                                'Added by shraddhaM on 18 july 2006 for for WhizibleSEM
                                'Args.ToBeInsertedInFunction += "alert(Args.ClientSideFunctionName.ToLower);" + vbCrLf
                                'Args.ToBeInsertedInFunction += "alert('hi');" + vbCrLf
                                Dim drStatus As IDataReader
                                Dim blnProjectOnHold As Boolean, strOnHoldMessage As String
                                'Added by ShamkantD on Friday, September 24, 2004
                                Dim intBaselineNumber As Integer = 0, strBaselineMessage As String = ""
                                'End of addition - ShamkantD on Friday, September 24, 2004

                                'drStatus = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_CNF_Project_Status " & HttpContext.Current.Session("intProjectID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                drStatus = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_CNF_Project_Status " & ProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                If drStatus.Read() Then
                                    blnProjectOnHold = CType(CommonFunction.Data.CheckIsDBNull(drStatus("ProjectOnHold"), "False"), Boolean)
                                    strOnHoldMessage = CType(CommonFunction.Data.CheckIsDBNull(drStatus("ProjectOnHoldMsg"), ""), String)

                                    'Added by ShamkantD on Friday, September 24, 2004
                                    intBaselineNumber = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drStatus("BaselineNumber"), "0"), "0"), Integer)
                                    strBaselineMessage = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drStatus("BaseLineMessage"), ""), ""), String)
                                    'End of addition - ShamkantD on Friday, September 24, 2004
                                End If
                                CommonFunction.Data.DisposeDataReader(drStatus)

                                If blnProjectOnHold = True Then
                                    Args.ToBeInsertedInFunction = "alert('" & strOnHoldMessage & "'); " & vbCrLf
                                    Args.ToBeInsertedInFunction &= "return;"
                                End If

                                'Added by ShamkantD on Friday, September 24, 2004
                                'Get the status of 'Project creation workflow required' flag
                                Dim blnIsProjectCreationWorkflowReqd As Boolean = False
                                blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
                                If blnIsProjectCreationWorkflowReqd = True Then
                                    If intBaselineNumber = 0 Then
                                        Args.ToBeInsertedInFunction = "alert('" & strBaselineMessage & "'); " & vbCrLf
                                        Args.ToBeInsertedInFunction &= "return;"
                                    End If
                                End If
                                'End of addition - ShamkantD on Friday, September 24, 2004
                                '--- End Of Addition

                                'End If

                                'Ended By shraddhaM on 20 July 2006
                                'Modified by TruptiK on 30-sep-2008
                                'ElseIf ((Args.ClientSideFunctionName.ToLower = "new_onclick" And intAllowResourceAllocation = 0) Or (Args.ClientSideFunctionName.ToLower = "newresource_onclick" And intAllowResourceAllocation = -1) Or (Args.ClientSideFunctionName.ToLower = "reqresources_onclick" And intAllowResourceAllocation = -1) Or (Args.ClientSideFunctionName.ToLower = "saveadd_onclick")) Then
                            ElseIf ((Args.ClientSideFunctionName.ToLower = "new_onclick" And intAllowResourceAllocation = 0) Or (Args.ClientSideFunctionName.ToLower = "newresource_onclick" And intAllowResourceAllocation = -1) Or (Args.ClientSideFunctionName.ToLower = "reqresources_onclick" And intAllowResourceAllocation = -1) Or (Args.ClientSideFunctionName.ToLower = "saveadd_onclick") Or (Args.ClientSideFunctionName.ToLower = "reaourceallocation" And intAllowResourceAllocation = 0)) Then
                                'End of modification by TruptiK on on 30-sep-2008

                                'Args.ToBeInsertedInFunction += "alert(Args.ClientSideFunctionName.ToLower);" + vbCrLf
                                'Args.ToBeInsertedInFunction += "alert('hi');" + vbCrLf

                                Dim drStatus As IDataReader
                                Dim blnProjectOnHold As Boolean, strOnHoldMessage As String
                                'Added by ShamkantD on Friday, September 24, 2004
                                Dim intBaselineNumber As Integer = 0, strBaselineMessage As String = ""
                                'End of addition - ShamkantD on Friday, September 24, 2004
                                'Added by ShraddhaM on 17,Sept 2008
                                'Purpose : Resource Allocation from advanced searched resources in Whiziblesem8.0
                                Dim ProjectID As String
                                Dim PKValue As String

                                PKValue = HttpContext.Current.Request.QueryString("PRJID")

                                If PKValue Is Nothing Then
                                    PKValue = HttpContext.Current.Request.Form("hidPKValue")
                                End If

                                If PKValue <> "" Then
                                    ProjectID = PKValue
                                Else
                                    ProjectID = HttpContext.Current.Session("intProjectID").ToString
                                End If

                                'End of addition by ShraddhaM on 17,Sept 2008
                                'Commented and added by ShraddhaM 
                                'drStatus = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_CNF_Project_Status " & HttpContext.Current.Session("intProjectID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                drStatus = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_CNF_Project_Status " & ProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'End of comment and addition by ShraddhaM
                                If drStatus.Read() Then
                                    blnProjectOnHold = CType(CommonFunction.Data.CheckIsDBNull(drStatus("ProjectOnHold"), "False"), Boolean)
                                    strOnHoldMessage = CType(CommonFunction.Data.CheckIsDBNull(drStatus("ProjectOnHoldMsg"), ""), String)

                                    'Added by ShamkantD on Friday, September 24, 2004
                                    intBaselineNumber = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drStatus("BaselineNumber"), "0"), "0"), Integer)
                                    strBaselineMessage = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drStatus("BaseLineMessage"), ""), ""), String)
                                    'End of addition - ShamkantD on Friday, September 24, 2004
                                End If
                                CommonFunction.Data.DisposeDataReader(drStatus)

                                If blnProjectOnHold = True Then
                                    Args.ToBeInsertedInFunction = "alert('" & strOnHoldMessage & "'); " & vbCrLf
                                    Args.ToBeInsertedInFunction &= "return;"
                                End If

                                'Added by ShamkantD on Friday, September 24, 2004
                                'Get the status of 'Project creation workflow required' flag
                                Dim blnIsProjectCreationWorkflowReqd As Boolean = False
                                blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
                                If blnIsProjectCreationWorkflowReqd = True Then
                                    If intBaselineNumber = 0 Then
                                        Args.ToBeInsertedInFunction = "alert('" & strBaselineMessage & "'); " & vbCrLf
                                        Args.ToBeInsertedInFunction &= "return;"
                                    End If
                                End If
                                'End of addition - ShamkantD on Friday, September 24, 2004
                                '--- End Of Addition
                                'Added by PrashantD on 21 March 2007 for CelanUp Activity
                                'ElseIf Args.ClientSideFunctionName.ToUpper = "DELEGATETASKS_CLICK" Then

                                '    Dim strEmployeeID As String
                                '    strEmployeeID = CType(CommonFunction.Data.GetDataScalar("SELECT EmployeeID FROM tbl_PM_ProjectEmployeeRole WHERE ProjectEmployeeRoleID = " + Args.PrimaryKeyValue, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
                                '    If strEmployeeID.Trim = HttpContext.Current.Session("intUserID").ToString.Trim Then
                                '        Cancel = True
                                '''''    End If

                                'End of addition by PrashantD 21 AMrch 2007
                            End If

                            'Modified By VidyaJ - Performance Issue - Resources - IssueID - 85
                            ''Get whethere resource allocation workflow is applicable or not from application variable

                            'intAllowResourceAllocation = CType(CommonFunction.Application.AllowResourceAllocation, Integer)  'CType(CommonFunction.Data.GetDataScalar("SELECT AllowResourceAllocation from tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)
                            ''End Of Modifications

                            If intAllowResourceAllocation = 0 Then
                                If Args.LinkName.ToUpper = "ADD NEW REQUEST" And Args.LinkType.ToUpper <> "S" Then
                                    Cancel = True
                                End If
                                If Args.LinkName.ToUpper = "REQUESTED RESOURCES" Then
                                    Cancel = True
                                End If
                                'Modified by SanaS on 30-Sep-2009 for ProjectLevel Resource Allocation 
                                If Args.LinkName.ToUpper = "EXTEND BOOKING" And intEnableProjectResourceAllocation = 0 Then
                                    Cancel = True
                                End If
                                'Added by TruptiK on 21-Jna-2008
                                If Args.LinkName.ToUpper = "PREPONE RELEASE" And intEnableProjectResourceAllocation = 0 Then
                                    Cancel = True
                                End If
                                'End Modification by SanaS on 30-Sep-2009 for ProjectLevel Resource Allocation 
                                'Added by SanaS on 30-Sep-2009 for Change Allocation
                                If Args.LinkName.ToUpper = "Change Allocation" And intEnableProjectResourceAllocation = 0 Then
                                    Cancel = True
                                End If
                                'End addition by SanaS on 30-Sep-2009 for Change Allocation

                                'End of addition by TrupitK
                                'Added By ShraddhaM to remove Save_Add Link on 3,July 2007

                                If HttpContext.Current.Request.QueryString("From") <> "" And Args.SystemLinkType.ToUpper = "SAVE_ADD" Then
                                    Cancel = True
                                ElseIf HttpContext.Current.Request.Form("hidFrom") <> "" And Args.SystemLinkType.ToUpper = "SAVE_ADD" Then
                                    Cancel = True
                                End If

                            Else
                                'Added by NileshD 29/04/04
                                'hide the add link
                                Select Case Args.SystemLinkType.ToUpper
                                    Case "ADD_NEW"
                                        Cancel = True
                                End Select
                                'End addition
                                If Args.LinkName.ToUpper = "REASSIGN" Then
                                    Cancel = True
                                End If

                                'Code Added by Noble K on 27th Jan 2005 to hide the Link "Save And Add" 
                                'if AllowResourceAllocation(in tbl_PM_CompanyInformation)= 1 
                                If Args.SystemLinkType.ToUpper = "SAVE_ADD" Then
                                    Cancel = True
                                End If
                                'Code Added by Noble K on 27th Jan 2005 Ends
                                'Added By ShraddhaM to remove Save_Add Link on 3,July 2007
                                If HttpContext.Current.Request.QueryString("From") <> "" And Args.SystemLinkType.ToUpper = "SAVE_ADD" Then
                                    Cancel = True
                                ElseIf HttpContext.Current.Request.Form("hidFrom") <> "" And Args.SystemLinkType.ToUpper = "SAVE_ADD" Then
                                    Cancel = True
                                End If
                                'Ended By ShraddhaM to remove Save_Add Link on 3,July 2007

                            End If
                            ' Integration by SanaS on 25-Sep-2009
                            If intEnableProjectResourceAllocation = 0 Then
                                If Args.LinkName.ToUpper = "EXTEND BOOKING" Then
                                    Cancel = True
                                End If
                                'Added by TruptiK on 21-Jna-2008
                                If Args.LinkName.ToUpper = "PREPONE RELEASE" Then
                                    Cancel = True
                                End If
                                If Args.LinkName.ToUpper = "CHANGE ALLOCATION" Then
                                    Cancel = True
                                End If
                            End If
                                'End Integration by SanaS on 25-Sep-2009
                        Case CommonFunction.Constants.APP_TAG_RESOURCE_BILLING
                            'Remove the links Add and Delete
                            Select Case Args.LinkName.ToUpper
                                Case "ADD", "DELETE", "SELECT ALL"
                                    Cancel = True
                            End Select
                        Case CommonFunction.Constants.APP_TAG_LEAVEMASTER
                            'Remove the links Save, Add and Delete
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD"
                                    Cancel = True
                            End Select

                        Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEMASTER
                            'Remove the links Save, Add and Delete
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD", "FILTERS", "SHOW_HISTORY"
                                    Cancel = True
                            End Select

                        Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEBALANCE
                            'Remove the links Add and Delete
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD", "FILTERS", "SHOW_HISTORY", "CONFIGURE"
                                    Cancel = True
                            End Select

                            'Added by JayavantK on 15-Sep-2004
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If
                                'End of addition
                                'Added by DiptiK on 22 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_BASELINE_COMMENTS
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If
                            'End of Addition
                            'Added by ShamkantD on Friday, September 24, 2004
                            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                                Dim strFunction As String
                                Dim strFormAction As String = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FormAction"), ""), String).Trim()

                                strFunction &= "var objfrm = GetFormReference('frmCommonPage');" & vbCrLf
                                strFunction &= "objfrm.action=""CommonPage.aspx?Operation=SAVE&FromWhere=PM&MasterTagId=2220&FormAction=" & strFormAction & """;" & vbCrLf
                                strFunction &= "objfrm.submit();" & vbCrLf
                                strFunction &= "return;" & vbCrLf
                                Args.ToBeInsertedInFunction = strFunction
                            End If
                                'End of addition - ShamkantD on Friday, September 24, 2004

                                'added by   SachinR     On  08 Apr 2004
                                'to insert the client script to ask the user about the confirmation to update the 
                                'projectTasks with contingencyplans record for the current RiskID and projectID

                                'Added by PrachiK on 19 Feb 2005 for IssueID 16053
                                'Purpose:To Validate the date fields in the node hardware Used under the Projects Tab.
                        Case CommonFunction.Constants.APP_TAG_Project_HardwareUsed
                            'Modified By VarunA on 6-May-2008 RequestID-13074
                            'Purpose : To validate for 'Save and Add' also.
                            'If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
                                'End By VarunA on 6-May-2008 RequestID-13074
                                Dim strSQL As String
                                Dim ProjectEndDate As String
                                Dim ProjectStartDate As String
                                strSQL = "select expectedStartdate,expectedenddate from tbl_PM_project where ProjectID= " & HttpContext.Current.Session("intProjectID").ToString
                                Dim drReader As IDataReader
                                drReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                If (drReader.Read) Then
                                    ProjectEndDate = CommonFunction.Dates.GetDate(CType(drReader("expectedenddate"), Date))
                                    ProjectStartDate = CommonFunction.Dates.GetDate(CType(drReader("expectedStartdate"), Date))
                                End If
                                CommonFunction.Data.DisposeDataReader(drReader)
                                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                'Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("ProjectDate", "ProjectDate", , , , ProjectEndDate.ToString, , , , , , True, , True)
                                'Args.ToBeInserted += CommonFunction.HTMLControls.DrawTextBox("StartProjectDate", "StartProjectDate", , , , ProjectStartDate.ToString, , , , , , True, , True)
                                Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("ProjectDate", "ProjectDate", , , , ProjectEndDate.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
                                Args.ToBeInserted += CommonFunction.HTMLControls.DrawTextBox("StartProjectDate", "StartProjectDate", , , , ProjectStartDate.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
                                Args.ToBeInsertedInFunction = "var objtxtToDate =GetObjectReference('frmCommonPage','PlannedOutDate');" & vbCrLf
                                Args.ToBeInsertedInFunction += "var objtxtFromDate =GetObjectReference('frmCommonPage','PlannedInDate');" & vbCrLf
                                Args.ToBeInsertedInFunction += "var objProjectdate=GetObjectReference('frmCommonPage','ProjectDate');" & vbCrLf
                                Args.ToBeInsertedInFunction += "var objProjectStartdate=GetObjectReference('frmCommonPage','StartProjectDate');" & vbCrLf
                                Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objProjectStartdate,objtxtToDate))  {" & vbCrLf
                                Args.ToBeInsertedInFunction += "alert('Planned Out Date should not be less than Project Start Date (' + objProjectStartdate.value + ')');" & vbCrLf
                                Args.ToBeInsertedInFunction += "return; }"
                                Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objtxtFromDate, objtxtToDate))  {" & vbCrLf
                                Args.ToBeInsertedInFunction += "alert('Planned Out Date  should not be less than Planned In Date.');" & vbCrLf
                                Args.ToBeInsertedInFunction += "return; }"
                                Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objtxtToDate, objProjectdate))  {" & vbCrLf
                                Args.ToBeInsertedInFunction += "alert('Planned Out Date should not be greater than Project End Date (' + objProjectdate.value + ')');" & vbCrLf
                                Args.ToBeInsertedInFunction += "return; }"
                                Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objProjectStartdate, objtxtFromDate))  {" & vbCrLf
                                Args.ToBeInsertedInFunction += "alert('Planned In Date should not be less than Project Start Date (' + objProjectStartdate.value + ')');" & vbCrLf
                                Args.ToBeInsertedInFunction += "return; }"
                                'Added By MrugajaB on 8th Apr 2005 for Issue ID.16053
                                Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objtxtFromDate, objProjectdate))  {" & vbCrLf
                                Args.ToBeInsertedInFunction += "alert('Planned In Date should not be greater than Project End Date (' + objProjectdate.value + ')');" & vbCrLf
                                Args.ToBeInsertedInFunction += "return; }"
                                'End Addition

                            End If
                                'End of Addition
                                'Added by PrachiK on 5 Mar 2005 for IssueID 16448
                                'Purpose:Projects - > Sub Projects . Date validations are not provided
                        Case CommonFunction.Constants.APP_TAG_SUB_PROJECTS
                            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
                                Dim strSQL As String
                                Dim ProjectEndDate As String
                                Dim ProjectStartDate As String
                                strSQL = "select expectedStartdate,expectedenddate from tbl_PM_project where ProjectID= " & HttpContext.Current.Session("intProjectID").ToString
                                Dim drReader As IDataReader
                                drReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                If (drReader.Read) Then
                                    ProjectEndDate = CommonFunction.Dates.GetDate(CType(drReader("expectedenddate"), Date))
                                    ProjectStartDate = CommonFunction.Dates.GetDate(CType(drReader("expectedStartdate"), Date))
                                End If
                                CommonFunction.Data.DisposeDataReader(drReader)
                                ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                '    Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("ProjectDate", "ProjectDate", , , , ProjectEndDate.ToString, , , , , , True, , True)
                                'Args.ToBeInserted += CommonFunction.HTMLControls.DrawTextBox("StartProjectDate", "StartProjectDate", , , , ProjectStartDate.ToString, , , , , , True, , True)
                                Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("ProjectDate", "ProjectDate", , , , ProjectEndDate.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
                                Args.ToBeInserted += CommonFunction.HTMLControls.DrawTextBox("StartProjectDate", "StartProjectDate", , , , ProjectStartDate.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
                                ''Added by NitinC on 19 April 2012 for WhizibleSEM 11.0 [Issue Fix : 61258 Custom Field]
                                Args.ToBeInsertedInFunction = "if(ValidateCustomFields()==false){return;}" & vbCrLf
                                ''End of Added by NitinC on 19 April 2012 for WhizibleSEM 11.0 [Issue Fix : 61258 Custom Field]
                                Args.ToBeInsertedInFunction += "var objtxtToDate =GetObjectReference('frmCommonPage','EstimatedEndDate');" & vbCrLf
                                Args.ToBeInsertedInFunction += "var objtxtFromDate =GetObjectReference('frmCommonPage','EstimatedStartDate');" & vbCrLf
                                Args.ToBeInsertedInFunction += "var objProjectdate=GetObjectReference('frmCommonPage','ProjectDate');" & vbCrLf
                                Args.ToBeInsertedInFunction += "var objProjectStartdate=GetObjectReference('frmCommonPage','StartProjectDate');" & vbCrLf

                                Args.ToBeInsertedInFunction += "if (objtxtToDate.value!=null) {" & vbCrLf
                                'Args.ToBeInsertedInFunction += "if (objtxtFromDate.value=='') {" & vbCrLf
                                ' Args.ToBeInsertedInFunction += "alert('Please enter Start Date'); return; } " & vbCrLf
                                Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2( objtxtFromDate,objtxtToDate))  {" & vbCrLf
                                Args.ToBeInsertedInFunction += "alert('Start Date should not be greater than End Date.');" & vbCrLf
                                Args.ToBeInsertedInFunction += "return; } }"

                                'Modified by SiddharthS on 4 Apr 2005 for issue id 16448
                                'Purpose:To provide consistent alerts.
                                Args.ToBeInsertedInFunction += "if (objtxtToDate.value!=null) {" & vbCrLf
                                Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objtxtToDate, objProjectdate))  {" & vbCrLf
                                Args.ToBeInsertedInFunction += "alert('\'End Date\' should not be greater than \'Project End Date\' (' + objProjectdate.value + ')');" & vbCrLf
                                Args.ToBeInsertedInFunction += "return; } "
                                Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objProjectStartdate,objtxtToDate))  {" & vbCrLf
                                Args.ToBeInsertedInFunction += "alert('\'End Date\' should not be less than \'Project Start Date\' (' + objProjectStartdate.value + ')');" & vbCrLf
                                Args.ToBeInsertedInFunction += "return; } }"

                                Args.ToBeInsertedInFunction += "if (objtxtFromDate.value!=null) {" & vbCrLf
                                Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objProjectStartdate, objtxtFromDate))  {" & vbCrLf
                                Args.ToBeInsertedInFunction += "alert('\'Start Date\' should not be less than \'Project Start Date\' (' + objProjectStartdate.value + ')');" & vbCrLf
                                Args.ToBeInsertedInFunction += "return; }  "
                                Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objtxtFromDate,objProjectdate))  {" & vbCrLf
                                Args.ToBeInsertedInFunction += "alert('\'Start Date\' should not be greater than \'Project End Date\' (' + objProjectdate.value + ')');" & vbCrLf
                                Args.ToBeInsertedInFunction += "return; }  } "

                                'End modification.
                            End If

                            ' Added By NitinVS on 9 May 2005 for WhizibleSEM SP3  
                            ' Implementing Copy Functionality 
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If

                            If HttpContext.Current.Request.QueryString("COPYDATA") <> "1" Then

                                If Args.LinkName.ToUpper = "CLOSE" Then
                                    Cancel = True
                                End If

                            End If

                            If HttpContext.Current.Request.QueryString("COPYDATA") = "1" Then
                                If Args.LinkName.ToUpper = "SAVE" Then
                                    ''Added By Chakshuta H on 8th-Nov-2016 for Double Save Issue
                                    Args.ToBeInsertedInFunction += "var MenuTags = document.getElementsByTagName('A');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "  for(i = 0; i < MenuTags.length; i++)" + vbCrLf
                                    Args.ToBeInsertedInFunction += "{" + vbCrLf
                                    Args.ToBeInsertedInFunction += " if (MenuTags[i].className == 'Menu')" + vbCrLf
                                    Args.ToBeInsertedInFunction += " {" + vbCrLf
                                    Args.ToBeInsertedInFunction += " MenuTags[i].parentNode.parentNode.style.display= 'none';" + vbCrLf
                                    Args.ToBeInsertedInFunction += " }" + vbCrLf
                                    Args.ToBeInsertedInFunction += " }" + vbCrLf
                                    ''End Of Added By Chakshuta H on 8th-Nov-2016 for Double Save Issue
                                    Args.ToBeInsertedInFunction += " objForm = GetFormReference('frmCommonPage');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "        objForm.action='../General/CommonPage.aspx?Operation=SAVE&Mode=ADD_NEW&SubProjectId=&FromWhere=PM&PagingAlphabet=-1&ParentTagID=0&COPYDATA=1&UNIQUEID=" + HttpContext.Current.Request.QueryString("UNIQUEID") + "&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_SUB_PROJECTS, String) + "';" + vbCrLf
                                    Args.ToBeInsertedInFunction += "        objForm.submit();" + vbCrLf
                                    Args.ToBeInsertedInFunction += "        return;" + vbCrLf
                                End If


                                Select Case Args.SystemLinkType.ToUpper.Trim
                                    Case "BACK"
                                        Cancel = True
                                    Case "SAVE_ADD"
                                        Cancel = True
                                End Select

                            End If

                            ' End Addition By NitinVS on 9 May 2005 for WhizibleSEM SP3 
                            ' Implementing copy Functionality 

                            'Added By VijayD On 3Rd Sept
                            'Purpose:To Hide Back Link If page called from GanttChart
                            If HttpContext.Current.Request.QueryString("FROMGANTTCHART") = "1" Then
                                If Args.LinkName.ToUpper = "BACK" Then
                                    Cancel = True
                                End If
                            End If
                            'End addition By VijayD On 3Rd Sept
                            'Added by SavitaS on 06 Oct 06  for SP7 IssueID 6423


                            'End of Addition
                        Case CommonFunction.Constants.APP_TAG_RISKS

                            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
                                Dim objAppResource As WebPages.Template.WhizTemplate
                                objAppResource = New WebPages.Template.WhizTemplate
                                objAppResource.InitializeResources("AppResources.EventHandlers", "AppResources")

                                With Args
                                    .ToBeInsertedInFunction = "if(blnIsStatusChanged==true) {"
                                    .ToBeInsertedInFunction += " var objStatus,objTxt; "
                                    .ToBeInsertedInFunction += " objStatus = GetObjectReference('frmCommonPage','Status'); "
                                    .ToBeInsertedInFunction += " if(objStatus!=null) { "
                                    .ToBeInsertedInFunction += " strVal= new String(objStatus.value); "
                                    .ToBeInsertedInFunction += " if(strVal.toUpperCase()=='OCCURRED') { "
                                    .ToBeInsertedInFunction += " if(window.confirm('" + objAppResource.GetResourceString("RISKS_MSG_INVOKE_CONTINGENCYPLAN") + "')==true) { "
                                    .ToBeInsertedInFunction += " objTxt = GetObjectReference('frmCommonPage','NonDatabase1'); "
                                    .ToBeInsertedInFunction += " objTxt.value='Yes'; "
                                    .ToBeInsertedInFunction += " } "
                                    .ToBeInsertedInFunction += " } "
                                    .ToBeInsertedInFunction += " } "
                                    .ToBeInsertedInFunction += " } "
                                End With
                                objAppResource = Nothing
                            End If
                            'addition end
                            ''Commented by ManishK On 3rd Jan 06 as new inherited page is added for this
                            '''    'added by   NileshD     On  08 Apr 2004
                            '''    'to insert the client script to ask the user about the confirmation to leave application 
                            '''    'when leave balance is less than the applied leaves.
                            '''Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEAPPLICATION
                            '''    If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
                            '''        Dim strFunction As String
                            '''        Dim m_objTemplate As New WebPages.Template.WhizTemplate
                            '''        m_objTemplate.InitializeResources("AppResources.EmployeeLeaveApplication", "AppResources")
                            '''        strFunction = " var objFrom;" + vbCrLf
                            '''        strFunction += " var objTo;" + vbCrLf
                            '''        strFunction += " var objBalance;" + vbCrLf
                            '''        strFunction += "objFrom = GetObjectReference('frmCommonPage', 'FromDate');" + vbCrLf
                            '''        strFunction += "objTo = GetObjectReference('frmCommonPage', 'ToDate');" + vbCrLf
                            '''        strFunction += "objBalance = GetObjectReference('frmCommonPage', 'NonDataBase1');" + vbCrLf
                            '''        strFunction += "if (objBalance[objBalance.selectedIndex].value < DateDiff(getDate(objFrom.value),getDate(objTo.value),""d"") + 1)" + vbCrLf
                            '''        strFunction += " { var bConfirmed;" + vbCrLf
                            '''        strFunction += "bConfirmed = window.confirm('" + m_objTemplate.GetResourceString("LEAVE_APPLICATION_BALANCE_MESSAGE") + "');" + vbCrLf
                            '''        strFunction += "if (bConfirmed == false) " + vbCrLf
                            '''        strFunction += "{ objBalance.disabled = true;"
                            '''        If Args.PrimaryKeyValue.Trim <> "" Then
                            '''            strFunction += " var objLeave;" + vbCrLf
                            '''            strFunction += "objLeave = GetObjectReference('frmCommonPage', 'LeaveTypeID');" + vbCrLf
                            '''            strFunction += "objLeave.disabled = true;"
                            '''        End If
                            '''        strFunction += "return; } }" + vbCrLf
                            '''        '***** Code added by SandipL on 24 Nov 2005 
                            '''        'Purpose :- server side validations(whether employee has applied for these dates already)
                            '''        strFunction += " var strUrl; " + vbCrLf
                            '''        strFunction += " strUrl = new String();" + vbCrLf
                            '''        strFunction += " strUrl = 'XMLHttp.aspx?TagID=1208&EmployeeID=' + objfrm.EmployeeID.value + '&LeaveID=" & Args.PrimaryKeyValue & "&FromDate='+ objfrm.FromDate.value + '&ToDate=' + objfrm.ToDate.value ;" + vbCrLf
                            '''        strFunction += "if (document.all) " + vbCrLf
                            '''        strFunction += " { " + vbCrLf
                            '''        strFunction += " objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  " + vbCrLf
                            '''        strFunction += " objXHttp.onreadystatechange = HandlerOnReadyState; " + vbCrLf
                            '''        strFunction += " objXHttp.open('GET',strUrl, false); " + vbCrLf
                            '''        strFunction += " objXHttp.send();           " + vbCrLf
                            '''        strFunction += " 	}  " + vbCrLf
                            '''        strFunction += "  	else  {" + vbCrLf
                            '''        strFunction += " objXHttp = new XMLHttpRequest();  " + vbCrLf
                            '''        strFunction += " objXHttp.onreadystatechange = HandlerOnReadyState(); " + vbCrLf
                            '''        strFunction += "  objXHttp.open('GET',strUrl, false);" + vbCrLf
                            '''        strFunction += " objXHttp.send(null);  }" + vbCrLf
                            '''        strFunction += "if (blnFlag == true) " + vbCrLf
                            '''        strFunction += " return;" + vbCrLf
                            '''        '***** End addition by SandipL on 24 Nov 2005

                            '''        Args.ToBeInsertedInFunction = strFunction
                            '''        'ReInitialize the Resources
                            '''        m_objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                            '''        m_objTemplate.Dispose()
                            '''    End If
                            '''    'addition end
                            ''End of comment by ManishK on 3rd Jan 06

                        Case CommonFunction.Constants.APP_TAG_ASSIGNEDRESOURCES
                            'Remove the links Add and Delete
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD", "FILTERS", "SHOW_HISTORY", "CONFIGURE"
                                    Cancel = True
                            End Select
                            Dim strFunction As String
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                strFunction = "window.close();"
                                strFunction += "return;"
                                Args.ToBeInsertedInFunction = strFunction
                            End If

                            'comment out later
                            'If Args.ClientSideFunctionName.ToUpper = "ASSIGN_ONCLICK" Then
                            '    Dim intRevisionNo As Integer
                            '    intRevisionNo = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("select RevisionNo from tbl_pm_project", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Integer)
                            '    strFunction = "var objRevision;" + vbCrLf
                            '    strFunction += "objRevision =" + intRevisionNo.ToString + ";" + vbCrLf
                            '    strFunction += " if ( objRevision <= 0)" + vbCrLf
                            '    strFunction += "{window.alert('The Project is not yet baselined so can not add resource.');" + vbCrLf
                            '    strFunction += "return;}"
                            '    Args.ToBeInsertedInFunction = strFunction
                            'End If

                            'Case CommonFunction.Constants.APP_TAG_RESOURCEREQUEST
                        Case CommonFunction.Constants.APP_TAG_RESOURCEREQUEST, CommonFunction.Constants.APP_TAG_EXTENDRESOURCEREQUEST
                            'Remove the Delete links
                            Select Case Args.SystemLinkType.ToUpper
                                Case "DELETE", "SELECT_ALL", "ADD_NEW"
                                    Cancel = True

                                Case "BACK"
                                    If Args.IsListPageLink = True Or CType(CommonFunctions.General.CheckIsNothing("0" & Args.PrimaryKeyValue, "0"), Long) = 0 Then
                                        Cancel = True
                                    End If
                            End Select
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                'Changes On 12-Jul-2004 for IssueID=11821 - Start
                                Dim strFunction As String
                                strFunction = "window.close();"
                                strFunction += "return;"
                                Args.ToBeInsertedInFunction = strFunction
                                'Changes On 12-Jul-2004 for IssueID=11821 - End
                            ElseIf (Args.SystemLinkType.ToUpper = "SAVE" Or
                                    Args.SystemLinkType.ToUpper = "SAVE_ADD" Or
                                    Args.ClientSideFunctionName.ToUpper = "EMAILSEND_ONCLICK") And
                                    Args.PrimaryKeyValue.ToString <> "" Then
                                Dim strSQL As String
                                strSQL = "SELECT RequestID FROM tbl_PM_ResourceRequest WHERE RequestID = " + Args.PrimaryKeyValue.ToString
                                strSQL = strSQL + " AND (STATUS = 'C' OR STATUS = 'REJECT')"
                                If CommonFunctions.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "") <> "" Then
                                    'Do not show the Save and 'Save and Add' menu links when request is either closed or declined.
                                    Cancel = True
                                    'Added By JayavantK, On - 26-Aug-2004 - Start
                                Else
                                    Dim intResources As Integer = 0
                                    strSQL = "SELECT Count(EmployeeID) FROM tbl_PM_AssignedResources WHERE Status IN ('L', 'A') AND RequestID=" + Args.PrimaryKeyValue.ToString
                                    intResources = CType(CommonFunctions.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Integer)
                                    'Do not show the Save and 'Save and Add' menu links when resources are Assigned/Allocated against the request.
                                    If intResources > 0 Then Cancel = True
                                    'End Addition
                                End If
                            End If

                            'Added By MrugajaB on 8th Apr 2005 for hiding 'Show Request Approvers' link in edit mode
                            If Args.ClientSideFunctionName.ToUpper = "REQAPPROVERS_ONCLICK" Then
                                If Args.PrimaryKeyValue.Trim = "" Then
                                    Cancel = True
                                End If

                            End If
                            'End Addition

                            If (Args.SystemLinkType.ToUpper = "SAVE" Or
                                    Args.SystemLinkType.ToUpper = "SAVE_ADD") Then

                                'Code added by MrugajaB on 7th Feb,2005
                                Dim strQuery As String = ""
                                Dim drProjectDetails As IDataReader
                                Dim strProjectStartDate As String = ""

                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.PM_ResourceAllocation", "AppResources")

                                strQuery = "SELECT ExpectedStartDate FROM tbl_PM_Project WHERE ProjectID = " & HttpContext.Current.Session("intProjectID").ToString
                                drProjectDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drProjectDetails.Read() Then
                                    strProjectStartDate = CommonFunctions.General.CheckIsNothing(drProjectDetails.Item("ExpectedStartDate"), "")
                                    If strProjectStartDate <> "" Then strProjectStartDate = CommonFunctions.Dates.GetDate(CType(strProjectStartDate, Date))

                                End If
                                CommonFunctions.Data.DisposeDataReader(drProjectDetails)

                                Args.ToBeInsertedInFunction = " var strMsg, dtProjectStartDate;" + vbCrLf
                                Args.ToBeInsertedInFunction += " var dtRequestDate;" + vbCrLf

                                Args.ToBeInsertedInFunction += " var objRequestDate;" + vbCrLf
                                Args.ToBeInsertedInFunction += "dtProjectStartDate = getDate('" & strProjectStartDate & "');" + vbCrLf
                                Args.ToBeInsertedInFunction += "objRequestDate = GetObjectReference('frmCommonPage','FromDate');" + vbCrLf
                                Args.ToBeInsertedInFunction += "dtRequestDate = getDate(objRequestDate.value);" + vbCrLf

                                Args.ToBeInsertedInFunction += "if((dtProjectStartDate != null) &&  (dtRequestDate != null)){" + vbCrLf
                                Args.ToBeInsertedInFunction += "if((dtRequestDate < dtProjectStartDate)){" + vbCrLf
                                'Integrated by TruptiK on 21-May-09
                                'commented by sonalD on 8th April 2009 for IssueID 29943
                                'Args.ToBeInsertedInFunction += "strMsg='" & objTemplate.GetResourceString("PROJECT_START_DATE_MESSAGE") & "';" + vbCrLf
                                'Args.ToBeInsertedInFunction += "strMsg = replaceSubstring(strMsg, '<=>', '" & strProjectStartDate & "');" + vbCrLf
                                'End of comment by SonalD on 8th APril 2009

                                'Modified by SonalD on 8th April 2009 for IssueID 29943
                                'Args.ToBeInsertedInFunction += "alert(strMsg);" + vbCrLf
                                Args.ToBeInsertedInFunction += "alert(""Please enter 'From Date' greater than or equal to 'Project Start Date' (" + strProjectStartDate + ")"");" + vbCrLf
                                'End of modification by SonalD on 8th April 2009
                                'End of integrated by TruptiK
                                Args.ToBeInsertedInFunction += "return;}}" + vbCrLf

                                objTemplate = Nothing

                                'End Addition

                            End If

                        Case CommonFunction.Constants.APP_TAG_RESOURCEREQUEST_VIEW
                            'Remove the links Add and Delete
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD", "FILTERS", "SHOW_HISTORY", "CONFIGURE"
                                    Cancel = True
                            End Select
                        Case CommonFunction.Constants.APP_TAG_TASK_TYPE_MAINTENANCE_PM
                            'Remove the links For SAVE
                            If Args.PrimaryKeyValue.Trim <> "" Then
                                'Edit Mode
                                Select Case Args.SystemLinkType.ToUpper
                                    Case "SAVE", "SAVE_ADD"
                                        Cancel = True
                                End Select
                            End If
                            'Added by DipaliS 
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If
                            'End Adddition by DipaliS
                        Case CommonFunctions.Constants.TAG_OUTPUT_FORMAT_SETTINGS
                            'Remove links Add, Delete, SelectAll
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL"
                                    Cancel = True
                            End Select

                        Case CommonFunction.Constants.APP_TAG_CUSTOM_PAGE_MAINTENANCE, CommonFunction.Constants.APP_TAG_PARENT_TAG_MAINTENANCE
                            'Remove the SelectAll link for Custom Page Maintenance and Parent Tag Details pages
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "SELECT_ALL"
                                    Cancel = True
                            End Select

                        Case CommonFunction.Constants.APP_TAG_ASSIGNED_TASK
                            'Send the EmployeeID selected in the filter to the TaskAssignment page
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW"
                                    Args.ToBeInsertedInFunction = "var objEmployeeID = GetObjectReference('frmCommonPage', 'EmployeeID');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "if (objEmployeeID != null)" + vbCrLf
                                    Args.ToBeInsertedInFunction += "window.location.href=""../PM/PM_TaskAssignment.aspx?Mode=ADD_NEW&MasterTagID=1038&FromWhere=PM&PagingAlphabet=-1ParentTagID=0&FromCL=1&ResourceID=""+objEmployeeID[objEmployeeID.selectedIndex].value;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;"
                            End Select
                        Case CommonFunctions.Constants.TAG_ADVANCE_FILTERS, CommonFunction.Constants.APP_TAG_PROJECT_ROOT_CAUSE, CommonFunction.Constants.APP_TAG_SDLC_SAVE_WITH_REVISION
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If
                            '***** Code added by SandipL on 22 Nov 2005--Removed 'APP_TAG_PROJECT_CUSTOM_FIELD_MAINTENANCE' from upper case list
                            'Purpose :- remove customfieldID session variable before closing
                        Case CommonFunction.Constants.APP_TAG_PROJECT_CUSTOM_FIELD_MAINTENANCE
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE" Then
                                Args.ToBeInsertedInFunction = "window.open('commonList.aspx?MasterTagID=2007&close=1','_self');"
                                Args.ToBeInsertedInFunction += "window.close(); return;"
                            End If
                            'If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                            '    Dim strFunction As String
                            '    Dim strCustomFieldID As String
                            '    strCustomFieldID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CustomFieldID"), ""), String).Trim()
                            '    If strCustomFieldID = "" Then
                            '        Dim strQueryString As String
                            '        strQueryString = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.UrlReferrer.Query, "")
                            '        strCustomFieldID = strQueryString.Substring(15, strQueryString.IndexOf("&", 16) - 15)
                            '    End If
                            '    'strFunction &= "var objfrm = GetFormReference('frmCommonPage');" & vbCrLf
                            '    ' strFunction &= "alert(opener.location)" + vbCrLf
                            '    strFunction &= "objfrm.action='CommonPage.aspx?Operation=DYNAMIC_LINK&DYNAMIC_LINK_ID=10561&UniqueValue=' + intUniqueID + '&IsListPageLink=1&CustomFieldID=" & strCustomFieldID & "&" & Args.CommonQueryString & "';" & vbCrLf '&FromWhere=PM&MasterTagId=2007&CustomFieldID=" & strCustomFieldID & "';" & vbCrLf
                            '    strFunction &= "objfrm.submit();" & vbCrLf
                            '    strFunction &= "return;" & vbCrLf
                            '    Args.ToBeInsertedInFunction = strFunction
                            'End If
                            '***** End addition by SandipL on 22 Nov 2005
                        Case CommonFunction.Constants.APP_TAG_PROJECT_TASK_CUSTOM_FIELD_MAINTENANCE
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE" Then
                                Args.ToBeInsertedInFunction = "window.open('commonList.aspx?MasterTagID=5052&close=1','_self');"
                                Args.ToBeInsertedInFunction += "window.close(); return;"
                            End If



                        Case CommonFunction.Constants.APP_TAG_EXPENSELIST
                            If Args.ClientSideFunctionName.ToUpper = "SHOW_EXPENSEREPORT" Then
                                If HttpContext.Current.Request.QueryString("DADate") <> Nothing Then
                                    HttpContext.Current.Session("ExpenseDate") = HttpContext.Current.Request.QueryString("DADate").ToString
                                End If
                                Args.ToBeInsertedInFunction = "window.open('../FA/FA_ExpenseReport.aspx?ReportType=1&rdPeriod=Daily&DADate=" _
                                & HttpContext.Current.Session("ExpenseDate").ToString &
                                "',"""", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - 600)/2) + "",top="" + ((window.screen.height - 350)/2) + "",width=800,height=400"");return;"
                            End If
                            ''Commented By ManishK on 3rd Jan 06 as new inherited page is added for Employee Leaves
                            ''''Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS
                            ''''    If Args.SystemLinkType.Trim.ToUpper = "DELETE" Or Args.SystemLinkType.Trim.ToUpper = "SELECT_ALL" Then
                            ''''        Cancel = True
                            ''''    End If
                            ''''    'Added By JayavantK on 15-Sep-2004
                            ''''    'Hide the Save and 'Save and Add' menu links when the leave status is not submitted 
                            ''''    If Args.SystemLinkType.Trim.ToUpper = "SAVE" Or Args.SystemLinkType.Trim.ToUpper = "SAVE_ADD" Then
                            ''''        If Args.PrimaryKeyValue.Trim <> "" Then
                            ''''            Dim strQuery As String = ""
                            ''''            strQuery = "SELECT LeaveID FROM tbl_PM_EmployeeLeaveDetails WHERE LeaveStatusID = 1 AND LeaveID = " & Args.PrimaryKeyValue
                            ''''            If CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "") = "" Then
                            ''''                Cancel = True
                            ''''            End If
                            ''''        End If
                            ''''    End If
                            ''''    'End Addition
                            ''''    '***** Code added by SandipL on 24 Nov 2005 
                            ''''    'Purpose - server side validation whether Employee has already applied for leaves for these dates 
                            ''''    If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
                            ''''        Args.ToBeInsertedInFunction = " var strUrl; " + vbCrLf
                            ''''        Args.ToBeInsertedInFunction += " strUrl = new String();" + vbCrLf
                            ''''        Args.ToBeInsertedInFunction += " " + vbCrLf
                            ''''        Args.ToBeInsertedInFunction += " strUrl = 'XMLHttp.aspx?TagID=1209&EmployeeID=" & WhizGlobal.UserID & "&LeaveID=" & Args.PrimaryKeyValue & "&FromDate='+ objfrm.FromDate.value + '&ToDate=' + objfrm.ToDate.value ;" + vbCrLf
                            ''''        Args.ToBeInsertedInFunction += "if (document.all) " + vbCrLf
                            ''''        Args.ToBeInsertedInFunction += " { " + vbCrLf
                            ''''        Args.ToBeInsertedInFunction += " objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  " + vbCrLf
                            ''''        Args.ToBeInsertedInFunction += " objXHttp.onreadystatechange = HandlerOnReadyState; " + vbCrLf
                            ''''        Args.ToBeInsertedInFunction += " objXHttp.open('GET',strUrl, false); " + vbCrLf
                            ''''        Args.ToBeInsertedInFunction += " objXHttp.send();           " + vbCrLf
                            ''''        Args.ToBeInsertedInFunction += " 	}  " + vbCrLf
                            ''''        Args.ToBeInsertedInFunction += "  	else  {" + vbCrLf
                            ''''        Args.ToBeInsertedInFunction += " objXHttp = new XMLHttpRequest();  " + vbCrLf
                            ''''        Args.ToBeInsertedInFunction += " objXHttp.onreadystatechange = HandlerOnReadyState(); " + vbCrLf
                            ''''        Args.ToBeInsertedInFunction += "  objXHttp.open('GET',strUrl, false);" + vbCrLf
                            ''''        Args.ToBeInsertedInFunction += " objXHttp.send(null);  }" + vbCrLf
                            ''''        Args.ToBeInsertedInFunction += "if (blnFlag == true) " + vbCrLf
                            ''''        Args.ToBeInsertedInFunction += " return;" + vbCrLf
                            ''''    End If
                            ''''    '***** End addition by SandipL on 24 Nov 2005
                            ''End Of Commented By ManishK on 3 rd Jan 06

                        Case CommonFunction.Constants.APP_TAG_WORKORDER
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If
                        Case CommonFunction.Constants.APP_TAG_REVISION_HISTORY
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If
                        Case CommonFunction.Constants.App_TAG_FIXED_BID
                            'Hide the Approve link if Rev ID is NULL
                            If Args.LinkName.ToUpper = "APPROVE" Then
                                Dim dblAmount As Double = 0
                                Dim strSQL As String = "select amount from tbl_pm_projectfixedbid where projectid=" & WhizGlobal.ProjectID.ToString
                                If Not IsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))) Then
                                    dblAmount = CType(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)
                                End If
                                If dblAmount = 0 Then
                                    Cancel = True
                                End If
                            End If
                        Case CommonFunction.Constants.App_TAG_FACILITY
                            Select Case Args.SystemLinkType.ToUpper.Trim
                                Case "SAVE", "SHOW_HISTORY"
                                    Cancel = True
                            End Select
                            'Case CommonFunction.Constants.TAG_PROJECT_INFORMATION
                            '    If Args.SystemLinkType.ToUpper.Trim = "ADD_NEW" Then
                            '        Args.ToBeInsertedInFunction = "window.location.href=""CommonPage.aspx?Mode=ADD_NEW&MasterTagID=1263&FromWhere=PM"";"
                            '        Args.ToBeInsertedInFunction += "return;"
                            '    End If
                            'Added By PrasannaP on 20th May 2004
                        Case CommonFunction.Constants.APP_TAG_BACKDATING_CONFIGURATION
                            If Args.SystemLinkType.ToUpper.Trim = "ADD_NEW" Then
                                Cancel = True
                            End If
                            If Args.SystemLinkType.ToUpper.Trim = "DELETE" Then
                                Cancel = True
                            End If
                            If Args.SystemLinkType.ToUpper.Trim = "SELECT_ALL" Then
                                Cancel = True
                            End If
                            'End Addition
                            'Added by NitinVS To close the window when clicked on close Link
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close();return;"
                            End If
                            'End Addition
                        Case CommonFunction.Constants.APP_TAG_CONFIG_TYPE_SECURITY_ROLES
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close();return;"
                            End If
                            ''------------------------------------------------------------------------------------------
                            ''Code added by RohiniK on 21 August 2006 for Role wise Access to All ISsues Tab in Issues Module  for Whiziblesem SP 7 Issue ID 5688 
                            '' Purpsoe: displaying delete checkbox and renaming delete coulmn as Disable All Issues Link
                            If Args.ClientSideFunctionName.ToUpper = "DELETE_ONCLICK" Then
                                Dim strFunction As String
                                strFunction = "var objForm; var objRef;" + vbCrLf
                                strFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
                                strFunction += "objRef = GetObjectReference('frmCommonList','chkDelete',true);" + vbCrLf
                                strFunction += "var i;" + vbCrLf
                                strFunction += "var chkSelectedFlag = 0;" + vbCrLf
                                strFunction += "for(i=0 ; i<objRef.length;i++ )"
                                strFunction += "{" + vbCrLf
                                strFunction += "if(objRef[i].checked==true)"
                                strFunction += "  {" + vbCrLf
                                strFunction += "    chkSelectedFlag = 1; " + vbCrLf
                                strFunction += "    break;"
                                strFunction += "   }"
                                strFunction += "}" + vbCrLf
                                strFunction += "if(chkSelectedFlag == 1)"
                                strFunction += "{" + vbCrLf
                                strFunction += "objForm.action = 'CommonList.aspx?Operation=DELETE&MasterTagID=" + CommonFunction.Constants.APP_TAG_CONFIG_TYPE_SECURITY_ROLES.ToString + "&chkSelected=1&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1'" + vbCrLf
                                strFunction += "}"
                                strFunction += "else "
                                strFunction += "{" + vbCrLf
                                strFunction += "objForm.action = 'CommonList.aspx?Operation=DELETE&MasterTagID=" + CommonFunction.Constants.APP_TAG_CONFIG_TYPE_SECURITY_ROLES.ToString + "&chkSelected=0&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1'" + vbCrLf
                                strFunction += "}"
                                strFunction += "objForm.submit();" + vbCrLf
                                strFunction += "return;"

                                Args.ToBeInsertedInFunction = strFunction
                            End If
                            ''End of Code addition by RohiniK on 21 August 2006 for Role wise Access to All ISsues Tab in Issues Module
                            ''------------------------------------------------------------------------------------------
                        Case CommonFunction.Constants.APP_TAG_CONFIG_TYPE_SECURITY
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close();return;"
                            ElseIf Args.ClientSideFunctionName.ToUpper = "CLEARALLCLICK" Then
                                Args.ToBeInsertedInFunction = "ClearAll_OnClick('frmCommonList','chkDelete');return;"
                            End If
                            'added by SachinR   on 15 Jul 2004
                        Case CommonFunction.Constants.APP_TAG_SDLC_PROCESS
                            'Remove links Delete, SelectAll, Filter
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "DELETE", "SELECT_ALL", "FILTERS"
                                    Cancel = True
                            End Select
                            'addition end

                            'Integrated by MrugajaB on 3rd Jan 2006 for Whiz2 Processes - Build 29
                            'addition by ManishK on 30th Aug 2005
                            If Args.ClientSideFunctionName.ToUpper = "SYNCPROCESSACTIVITY" Then
                                Dim strFunction As String
                                strFunction = "var objForm; var objRef;" + vbCrLf

                                strFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf

                                strFunction += "objRef = GetObjectReference('frmCommonList','chkSynchronize',true);" + vbCrLf
                                strFunction += "var i;" + vbCrLf
                                strFunction += "for(i=0 ; i<objRef.length;i++ ){" + vbCrLf
                                strFunction += "if(objRef[i].checked==true){" + vbCrLf
                                strFunction += "if(confirm('Activiti(es) will be deleted permanantly from Project.\nDo you want to continue?\n')==true)" + vbCrLf
                                strFunction += "{" + vbCrLf

                                strFunction += "objForm.action = 'CommonList.aspx?ProcessID=" + HttpContext.Current.Request.QueryString("ProcessID") + "&FromWhere=PM&MasterTagId=" + CommonFunction.Constants.APP_TAG_SDLC_PROCESS.ToString + "&ToDo=Sync'" + vbCrLf
                                strFunction += "objForm.submit();" + vbCrLf
                                strFunction += "return;}}} return;" + vbCrLf

                                strFunction += "return;"

                                Args.ToBeInsertedInFunction = strFunction
                            End If

                            'End of addition by ManishK on 30th Aug 2005
                            'End Integration

                            'Checklist in PV Integration by Padmnabh A
                            If Args.ClientSideFunctionName.ToUpper = "LNKCHECKLIST_ONCLICK" Then
                                Dim strProcessID As String
                                strProcessID = Args.CommonQueryString.Substring(Args.CommonQueryString.LastIndexOf("=") + 1)
                                Args.ToBeInsertedInFunction = "var objForm;"
                                Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonPage');"
                                Args.ToBeInsertedInFunction += "objForm.action='../PV/PM_Checklist_CommonList.aspx?FromWhere=PM&MasterTagID=3607&SDLCID=" + Args.PrimaryKeyValue.Trim.ToString + "&ProcessID=" + strProcessID + "'; "
                                Args.ToBeInsertedInFunction += "objForm.submit();"
                                Args.ToBeInsertedInFunction += "return;"
                            End If
                            'End  Integration
                            If Args.ClientSideFunctionName.ToUpper = "PROCESSDETAILS_CLICK" Then
                                Args.ToBeInsertedInFunction = "window.open('../PV/PV_ShowProcessDetails.aspx?Mode=PROCESSDETAILS&ProcessID=" + HttpContext.Current.Request.QueryString("ProcessID") + "', '', 'resizable=yes,menubar=yes,scrollbars=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 600)/2 + ',width=800,height=600');//"
                            End If

                            'Added by ShamkantD on 26th July 2004 - added to hide all links except save

                            ' Addition By NitinVS on 9 Apr 2007 for WhizibleSEM SP 8 Regression Issue 12842
                            ' to hide save with revision when header section is closed 

                            If Args.ClientSideFunctionName.ToUpper = "SAVEWITHREVISION" Then
                                Dim strKey As String
                                strKey = CType(HttpContext.Current.Session("intUserID"), String) + "-"
                                strKey += CType(HttpContext.Current.Session("LoginType"), String) + "-"
                                strKey += CType(CommonFunctions.Constants.SECTION_USER_PREFERENCES_VALUE_HEADER, String) + "-"
                                strKey += CType(CommonFunction.Constants.APP_TAG_SDLC_PROCESS, String)
                                If (CommonFunctions.General.CheckIsNothing(CommonEngines.HashTables.GetHashTableObject.GetHashTableUPFCache(strKey), "1") = "0") Then
                                    Cancel = True
                                End If
                            End If
                            ' End Addition By NitinVS on 9 Apr 2007 for WhizibleSEM SP 8 Regression Issue 

                        Case CommonFunction.Constants.APP_TAG_CONFIG_COMMERICAL_CONTRACT_TYPE
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE_ADD", "FILTERS", "SHOW_HISTORY", "CONFIGURE"
                                    Cancel = True
                            End Select
                            'End of addition - ShamkantD on 26th July 2004 
                        Case CommonFunction.Constants.APP_TAG_RFI_TAX_BUILDER
                            Select Case Args.SystemLinkType.ToUpper
                                Case "SAVE"
                                    Dim objAppResource As WebPages.Template.WhizTemplate
                                    objAppResource = New WebPages.Template.WhizTemplate
                                    objAppResource.InitializeResources("AppResources.EventHandlers", "AppResources")

                                    Args.ToBeInsertedInFunction = "var objFormula = GetObjectReference(""frmCommonPage"",""Formula"");" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strFormula=objFormula.value;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strFormula=trimString(strFormula);" + vbCrLf
                                    Args.ToBeInsertedInFunction += "if (disallowBlank(objFormula,'" + objAppResource.GetResourceString("RFI_FORMULA_NOTBLANK") + "',true) == true) {"
                                    Args.ToBeInsertedInFunction += "var objFormula=GetObjectReference('frmCommonPage','Formula');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "if (objFormula!=null) {" + vbCrLf
                                    Args.ToBeInsertedInFunction += "objFormula.disabled=true;}" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;}" + vbCrLf
                                    Args.ToBeInsertedInFunction += "if(strFormula.substring(strFormula.length-1,strFormula.length) == ""+"" || strFormula.substring(strFormula.length-1,strFormula.length) == ""-"")" + vbCrLf
                                    Args.ToBeInsertedInFunction += "{" + vbCrLf
                                    Args.ToBeInsertedInFunction += "alert('" + objAppResource.GetResourceString("RFI_FORMULA_INVALID") + "')" + vbCrLf
                                    Args.ToBeInsertedInFunction += "var objFormula=GetObjectReference('frmCommonPage','Formula');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "if (objFormula!=null) {" + vbCrLf
                                    Args.ToBeInsertedInFunction += "objFormula.disabled=true;}" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "}" + vbCrLf

                                    objAppResource = Nothing
                                Case "SAVE_ADD"
                                    Cancel = True
                                Case "BACK"
                                    Args.ToBeInsertedInFunction = "window.close();return;"
                            End Select
                        Case CommonFunction.Constants.APP_TAG_RFI_INITIATOR
                            If Args.LinkName.ToUpper = "ADD" Then
                                Cancel = True
                            End If
                            'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                            If Args.LinkName.ToUpper = "ADD NEW" Then
                                'Added by TruptiK on 25-May-2007 
                                'Purpose:To give alert for conversionrate of currency.
                                Dim objAppResource As WebPages.Template.WhizTemplate
                                objAppResource = New WebPages.Template.WhizTemplate
                                objAppResource.InitializeResources("AppResources.EventHandlers", "AppResources")
                                Dim m_strToken As String
                                Dim strSqlQuery As String
                                Dim str As String

                                'Added by PrashantSJ on 5th June 2007 For WhizibleSEM 7.0 Build 3
                                'Purpose: To validate the Project BillingCurrency,Person responsible for invoice and Corporate Base and local
                                'currency,Company Base Currency while raising RFI.
                                Dim drRFI As IDataReader
                                Dim m_iBillingCurrencyID, m_iBaseCurrencyID, m_iCompanyBaseCurrencyID, m_iLocalCurrencyID, m_iInvoiceResponsiblePerson As Integer
                                Dim m_iIRApprover As Integer

                                strSqlQuery = "usp_Validation_IR_BillingBaseLocalCompanyBaseCurrency " & CType(HttpContext.Current.Session("intProjectID"), String)
                                drRFI = CommonFunction.Data.GetDataReader(strSqlQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drRFI.Read() Then
                                    m_iBillingCurrencyID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drRFI("BillingCurrencyID"), "0"), "0"), Integer)
                                    m_iBaseCurrencyID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drRFI("BaseCurrencyID"), "0"), "0"), Integer)
                                    m_iLocalCurrencyID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drRFI("LocalCurrencyID"), "0"), "0"), Integer)
                                    m_iCompanyBaseCurrencyID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drRFI("CompanyBaseCurrencyID"), "0"), "0"), Integer)
                                    m_iInvoiceResponsiblePerson = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drRFI("InvoiceResponsiblePerson"), "0"), "0"), Integer)
                                    m_iIRApprover = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drRFI("IRApprover"), "0"), "0"), Integer)
                                End If
                                CommonFunction.Data.DisposeDataReader(drRFI)

                                If m_iBillingCurrencyID = 0 Then
                                    Args.ToBeInsertedInFunction += "alert('" + objAppResource.GetResourceString("MSG_NO_BILLING") + "');" + "return;"
                                ElseIf m_iBaseCurrencyID = 0 Then
                                    Args.ToBeInsertedInFunction += "alert('" + objAppResource.GetResourceString("MSG_NO_BASECODE") + "');" + "return;" + vbCrLf
                                    ''Commeneted By PrashantSJ on 21st June 2007 For WhizibleSEM 7.0
                                    ''Purpose: To remove local currency feature from IR Work flow
                                    'ElseIf m_iLocalCurrencyID = 0 Then
                                    '    Args.ToBeInsertedInFunction += "alert('" + objAppResource.GetResourceString("MSG_NO_LOCALCODE") + "');" + "return;" + vbCrLf
                                    ''End of comment by PrashantSJ on 21st June 2007
                                ElseIf m_iCompanyBaseCurrencyID = 0 Then
                                    Args.ToBeInsertedInFunction += "alert('" + objAppResource.GetResourceString("MSG_NO_COMPANYBASECODE") + "');" + "return;" + vbCrLf
                                ElseIf m_iIRApprover = 0 Then
                                    Args.ToBeInsertedInFunction += "alert('" + objAppResource.GetResourceString("MSG_NO_IR_APPROVER") + "');" + "return;" + vbCrLf
                                ElseIf m_iInvoiceResponsiblePerson = 0 Then
                                    Args.ToBeInsertedInFunction += "alert('" + objAppResource.GetResourceString("MSG_NO_RESP_PERSON") + "');" + "return;" + vbCrLf
                                Else

                                    strSqlQuery = ""
                                    'End of addition by PrashantSJ on 5th June 2007
                                    'Trupti
                                    strSqlQuery = "EXEC usp_Validation_BillingCurrencyConversionRate '" & CType(HttpContext.Current.Session("intProjectID"), String) & "'"
                                    str = CType(CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), ""), ""), String)
                                    'CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("BaseLineMessage"), ""), ""), String)
                                    m_strToken = CommonFunctions.Security.Token.GetToken(CType(0, String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))
                                    If str.ToUpper = "NO_IRCOMPANY_BASE_CONVERSRIONRATE" Then
                                        Args.ToBeInsertedInFunction = "alert('" + objAppResource.GetResourceString("IRCOMPANY_BASE_CONVERSRIONRATE") + "');" + "return;"
                                        'Args.ToBeInsertedInFunction += "return;"
                                        ''Commeneted By PrashantSJ on 21st June 2007 For WhizibleSEM 7.0
                                        ''Purpose: To remove local currency feature from IR Work flow
                                        'ElseIf str.ToUpper = "NO_CORPORATE_LOCAL_CONVERSRIONRATE" Then
                                        '    Args.ToBeInsertedInFunction = "alert('" + objAppResource.GetResourceString("CORPORATE_LOCAL_CONVERSRIONRATE") + "');" + "return;"
                                        ''End of comment by PrashantSJ on 21st June 2007
                                    ElseIf str.ToUpper = "NO_CORPORATE_BASE_CONVERSRIONRATE" Then
                                        Args.ToBeInsertedInFunction = "alert('" + objAppResource.GetResourceString("CORPORATE_BASE_CONVERSRIONRATE") + "');" + "return;"
                                    Else
                                        Args.ToBeInsertedInFunction = "window.open('../RFI/RFI_RFI.aspx?Mode=New&UserType=Initiator&PKToken=" + m_strToken + "', '_self', 'resizable=yes,scrollbars=no,left=' + ((window.screen.width - 600)/2) + ',top=' + ((window.screen.height - 600)/2) + ',width=650,height=600', '', 'resizable=yes,scrollbars=no,left=' + ((window.screen.width - 0)/2) + ',top=' + ((window.screen.height - 0)/2) + ',width=0,height=0');" + "return;"
                                        'Args.ToBeInsertedInFunction = "window.open('../RFI/RFI_RFI.aspx?Mode=New&UserType=Initiator&PKToken=" + m_strToken + "', 'resizable=yes,scrollbars=no,left=' + ((window.screen.width - 0)/2) + ',top=' + ((window.screen.height - 0)/2) + ',width=0,height=0');"
                                        ' Args.ToBeInsertedInFunction += "return;"
                                    End If
                                End If
                            End If
                            'End of modification by TruptiK on 25-May-2007 
                            'End of addition by MonikaI
                            'Added by ShamkantD on 28th July 2004 - added to hide all links excelpt select all and save
                        Case CommonFunction.Constants.APP_TAG_CONFIG_WORKORDER_FIELD_ACCESS
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SAVE_ADD", "FILTERS", "SHOW_HISTORY"
                                    Cancel = True
                            End Select
                            'End of addition - ShamkantD on 28th July 2004 

                            'Added By JayavantK On 30-Jul-2004 - Start
                        Case CommonFunction.Constants.APP_TAG_OUPOOL_MASTER
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD"
                                    Cancel = True
                            End Select

                        Case CommonFunction.Constants.APP_TAG_OUPools
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD"
                                    Cancel = True
                            End Select

                        Case CommonFunction.Constants.APP_TAG_TEAMPOOLS_EDIT
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD"
                                    Cancel = True
                            End Select

                        Case CommonFunction.Constants.APP_TAG_RESOURCE_REQUEST_ESCALATION
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Dim strFunction As String
                                strFunction = "window.close();return;"
                                Args.ToBeInsertedInFunction = strFunction
                            End If
                        Case CommonFunction.Constants.APP_TAG_RESOURCE_REQUEST_ESCALATION_TO_OUPOOL
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Dim strFunction As String
                                strFunction = "window.close();return;"
                                Args.ToBeInsertedInFunction = strFunction
                            End If

                        Case CommonFunction.Constants.APP_TAG_RESOURCE_REQUEST_ESCALATION_TO_BGPOOL
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Dim strFunction As String
                                strFunction = "window.close();return;"
                                Args.ToBeInsertedInFunction = strFunction
                            End If

                        Case CommonFunction.Constants.APP_TAG_RESOURCE_REQUEST_ESCALATION_TO_GLOBALPOOL
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Dim strFunction As String
                                strFunction = "window.close();return;"
                                Args.ToBeInsertedInFunction = strFunction
                            End If

                        Case CommonFunction.Constants.APP_TAG_GLOBAL_RESOURCE_POOL
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD"
                                    Cancel = True
                            End Select

                        Case CommonFunction.Constants.APP_TAG_RESOURCE_POOL_VIEW
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD"
                                    Cancel = True
                            End Select

                            'End Addition

                            'Added By NileshD On 30 July 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_STATUS_HISTORY
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL"
                                    Cancel = True
                            End Select
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE" Then
                                Args.ToBeInsertedInFunction = "window.close();return;"
                            End If
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_LIST
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL"
                                    Cancel = True
                            End Select
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE" Then
                                Args.ToBeInsertedInFunction = "window.close();return;"
                            End If
                            '***** Code Modified and Commented by SandipL on 7 Dec 2005 
                        Case CommonFunction.Constants.APP_TAG_RFI_TOOL, CommonFunction.Constants.APP_TAG_RFI_OS, CommonFunction.Constants.APP_TAG_RFI_SALES_PERSON
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL"
                                    Cancel = True
                            End Select
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE" Then
                                Args.ToBeInsertedInFunction = "window.close();return;"
                            End If
                            If Args.ClientSideFunctionName.ToUpper = "SELECT" Then

                                'Purpose :- refresh parent page with descriptions 
                                Args.ToBeInsertedInFunction = " var strUrl,i; " + vbCrLf
                                Args.ToBeInsertedInFunction += " strUrl = new String();" + vbCrLf
                                Args.ToBeInsertedInFunction += "if(objfrm.chkDelete != null)"
                                Args.ToBeInsertedInFunction += " { " + vbCrLf
                                Args.ToBeInsertedInFunction += "if (objfrm.chkDelete.length > 1)" + vbCrLf
                                Args.ToBeInsertedInFunction += " { " + vbCrLf
                                Args.ToBeInsertedInFunction += "   for(i=0;i<objfrm.chkDelete.length;i++) " + vbCrLf
                                Args.ToBeInsertedInFunction += "     { " + vbCrLf
                                Args.ToBeInsertedInFunction += "       if (objfrm.chkDelete[i].checked)" + vbCrLf
                                Args.ToBeInsertedInFunction += "          strID += objfrm.chkDelete[i].value + ',' ;" + vbCrLf
                                Args.ToBeInsertedInFunction += " 	  }  " + vbCrLf
                                Args.ToBeInsertedInFunction += "   if (strID != '') " + vbCrLf
                                Args.ToBeInsertedInFunction += "   strID = strID.substring(0,strID.length-1) ; " + vbCrLf
                                Args.ToBeInsertedInFunction += " }  " + vbCrLf
                                Args.ToBeInsertedInFunction += "else " + vbCrLf
                                Args.ToBeInsertedInFunction += "    if (objfrm.chkDelete.checked)" + vbCrLf
                                Args.ToBeInsertedInFunction += "          strID += objfrm.chkDelete.value  ;" + vbCrLf
                                Args.ToBeInsertedInFunction += " 	  }  " + vbCrLf
                                Args.ToBeInsertedInFunction += "if (strID == '')  " + vbCrLf
                                Args.ToBeInsertedInFunction += " strID = '0';" + vbCrLf

                                Args.ToBeInsertedInFunction += " strUrl = 'XMLHttp.aspx?TagID=" & CType(WhizGlobal.TagID, String) & "&chkDelete='+ strID " + vbCrLf
                                ''Commented and added by Nilesh g on 21/12/2015 for load error
                                'Args.ToBeInsertedInFunction += "if (document.all) " + vbCrLf
                                'Args.ToBeInsertedInFunction += " { " + vbCrLf
                                'Args.ToBeInsertedInFunction += "     objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  " + vbCrLf
                                'Args.ToBeInsertedInFunction += "     objXHttp.onreadystatechange = HandlerOnReadyState; " + vbCrLf
                                'Args.ToBeInsertedInFunction += "     objXHttp.open('GET',strUrl, false); " + vbCrLf
                                'Args.ToBeInsertedInFunction += "     objXHttp.send();           " + vbCrLf
                                'Args.ToBeInsertedInFunction += "  }  " + vbCrLf
                                'Args.ToBeInsertedInFunction += " else  {" + vbCrLf
                                'Args.ToBeInsertedInFunction += "       objXHttp = new XMLHttpRequest();  " + vbCrLf
                                'Args.ToBeInsertedInFunction += "       objXHttp.onreadystatechange = HandlerOnReadyState(); " + vbCrLf
                                'Args.ToBeInsertedInFunction += "       objXHttp.open('GET',strUrl, false);" + vbCrLf
                                ''Modified & Added By VarunA on 23-Mar-2009 IssueID-29343
                                ''Purpose : To have sale person in Mozilla
                                ''Args.ToBeInsertedInFunction += "        objXHttp.send(null); }" + vbCrLf
                                'Args.ToBeInsertedInFunction += "        objXHttp.send(null); " + vbCrLf
                                'Args.ToBeInsertedInFunction += "       if (objXHttp.responseText != null)" + vbCrLf
                                'Args.ToBeInsertedInFunction += "       {xmlDoc= document.implementation.createDocument('','',null);" + vbCrLf
                                'Args.ToBeInsertedInFunction += "       xmlDoc.async=false;" + vbCrLf
                                'Args.ToBeInsertedInFunction += "       xmlDoc.load(objXHttp.responseXML);" + vbCrLf
                                Args.ToBeInsertedInFunction += "var Browser =isIE();" + vbCrLf
                                Args.ToBeInsertedInFunction += "if (Browser == 'IE') " + vbCrLf
                                Args.ToBeInsertedInFunction += " { " + vbCrLf
                                Args.ToBeInsertedInFunction += "     objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  " + vbCrLf
                                Args.ToBeInsertedInFunction += "     objXHttp.onreadystatechange = HandlerOnReadyState; " + vbCrLf
                                Args.ToBeInsertedInFunction += "     objXHttp.open('GET',strUrl, false); " + vbCrLf
                                Args.ToBeInsertedInFunction += "     objXHttp.send();           " + vbCrLf
                                Args.ToBeInsertedInFunction += "  }  " + vbCrLf
                                Args.ToBeInsertedInFunction += " else  {" + vbCrLf
                                Args.ToBeInsertedInFunction += "       objXHttp = new XMLHttpRequest();  " + vbCrLf
                                Args.ToBeInsertedInFunction += "       objXHttp.onreadystatechange = HandlerOnReadyState(); " + vbCrLf
                                Args.ToBeInsertedInFunction += "       objXHttp.open('GET',strUrl, false);" + vbCrLf
                                'Modified & Added By VarunA on 23-Mar-2009 IssueID-29343
                                'Purpose : To have sale person in Mozilla
                                'Args.ToBeInsertedInFunction += "        objXHttp.send(null); }" + vbCrLf
                                Args.ToBeInsertedInFunction += "        objXHttp.send(null); " + vbCrLf
                                Args.ToBeInsertedInFunction += "       if (objXHttp.responseText != null)" + vbCrLf
                                Args.ToBeInsertedInFunction += "       {xmlDoc= document.implementation.createDocument('','',null);" + vbCrLf
                                Args.ToBeInsertedInFunction += "       xmlDoc.async=false;" + vbCrLf
                                Args.ToBeInsertedInFunction += "        if (Browser == 'FF')" + vbCrLf
                                Args.ToBeInsertedInFunction += "       xmlDoc.load(objXHttp.responseXML);" + vbCrLf
                                ''end of Commented and added by Nilesh g on 21/12/2015 for load error
                                Args.ToBeInsertedInFunction += "       HandlerOnReadyState(); } }" + vbCrLf
                                'End By VarunA By VarunA on 23-Mar-2009 IssueID-29343
                                Args.ToBeInsertedInFunction += " return; " + vbCrLf

                            End If
                            '-----------------------------------------------------------------------------
                            'Integrated by SavitaS on 13 Mar 2006 for IssueID-2836 (For RFI Milestone and RFI Deliverable Pages.)
                            'Added by MohitS on 3rd Jan 2006
                            'Modified by GaneshG on 11 Jan 2006 
                        Case CommonFunction.Constants.APP_TAG_RFI_MILESTONE '3585
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL"
                                    Cancel = True
                            End Select

                            If Args.ClientSideFunctionName.ToUpper = "CLOSE" Then
                                Args.ToBeInsertedInFunction = "window.close();return;"
                            End If

                            If Args.IsListPageLink Then
                                If Args.ClientSideFunctionName.ToUpper = "SAVE" Then
                                    'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                                    Dim m_strToken As String
                                    m_strToken = CommonFunctions.Security.Token.GetToken(CType(HttpContext.Current.Request.QueryString("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))

                                    'End by MonikaI
                                    Dim strSQL As String
                                    Dim strLinkID As String = ""
                                    strSQL = "Select UniqueID from tbl_UI_Dynamic_Links where Tagid = 3585 and ClientSideFunctionName like 'Save'"
                                    strLinkID = CommonFunctions.Data.GetDataScalar(strSQL, True).ToString

                                    Args.ToBeInsertedInFunction = "var objList;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "objList = GetObjectReference('frmCommonList','chkDelete');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "if (objList == null) {return;}" + vbCrLf
                                    'Code Added by TruptiK on 6-Jun-2007 For issueid
                                    Args.ToBeInsertedInFunction += "if (objList.status == false) {" + vbCrLf
                                    Args.ToBeInsertedInFunction += " alert('Please select at least one deliverable');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "}"
                                    'End of code added by TruptiK on 6-Jun-2007
                                    Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "objForm.action = 'CommonPage.aspx?PKToken=" + m_strToken + "&Operation=DYNAMIC_LINK&DYNAMIC_LINK_ID=" & strLinkID & "&UniqueValue=' + intUniqueID + '&IsListPageLink=1&MasterTagID=3585&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&Customer=" & HttpContext.Current.Request.QueryString("Customer") & "&RFIID=" & HttpContext.Current.Request.QueryString("RFIID") & "';" + vbCrLf
                                    Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf

                                    Args.ToBeInsertedInFunction += "var intIndex;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "var strhRef;" + vbCrLf

                                    Args.ToBeInsertedInFunction += "window.opener.document.forms[0].cboRFITypeID.disabled = false;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "window.opener.document.forms[0].cboCustomerID.disabled = false;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "window.opener.document.forms[0].cboBillingCurrencyID.disabled = false;" + vbCrLf

                                    Args.ToBeInsertedInFunction += "var objform = window.opener.document.forms[0];" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strhRef = window.opener.location.href;" + vbCrLf

                                    Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/Mode=New/,'Mode=Edit');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/&Action=DeleteItem/,'');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/&Action=Save/,'');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/&Action=ChangeCustomer/,'');" + vbCrLf


                                    'Integrated and uncommented by SavitaS on 14 Mar 2006 for IssueID-2836
                                    Args.ToBeInsertedInFunction += "intIndex= strhRef.indexOf('&RFIID');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "if(intIndex!=-1)" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strhRef = strhRef.substring(0,intIndex-1)" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "strhRef += '&SelectionFlag=1&NewRFIID=" & HttpContext.Current.Request.QueryString("RFIID") & "';" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strhRef += '&RFIID=" & HttpContext.Current.Request.QueryString("RFIID") & "';" + vbCrLf

                                    'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                                    'Args.ToBeInsertedInFunction += "intIndex= strhRef.indexOf('&PKToken');" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "if(intIndex!=-1)" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "strhRef = strhRef.substring(0,intIndex-1)" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strhRef += '&NewPKToken=" & m_strToken & "';" + vbCrLf
                                    'End of addition

                                    Args.ToBeInsertedInFunction += "objform.action = strhRef;" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "window.opener.location.href = strhRef;" & vbCrLf

                                    Args.ToBeInsertedInFunction += "objform.submit();" & vbCrLf
                                    'End Integration on 14 Mar 2006
                                    Args.ToBeInsertedInFunction += "window.close();" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;" + vbCrLf
                                End If
                            End If
                            'End of Modification by GaneshG 
                            'End of Addition MohitS

                            'Added by GaneshG on 11 Jan 2006 --To save selected Deliverable/s for perticular RFI
                        Case CommonFunction.Constants.APP_TAG_RFI_DELIVERABLES
                            Select Case Args.ClientSideFunctionName.ToUpper
                                Case "CLOSE"
                                    Args.ToBeInsertedInFunction = "window.close();return;"
                            End Select

                            If Args.IsListPageLink Then
                                If Args.ClientSideFunctionName.ToUpper = "SAVE" Then
                                    Dim strSQL As String
                                    Dim strLinkID As String = ""
                                    'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                                    Dim m_strToken As String
                                    m_strToken = CommonFunctions.Security.Token.GetToken(CType(HttpContext.Current.Request.QueryString("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))

                                    'End by MonikaI
                                    strSQL = "Select UniqueID from tbl_UI_Dynamic_Links where Tagid = 3586 and ClientSideFunctionName like 'Save'"
                                    strLinkID = CommonFunctions.Data.GetDataScalar(strSQL, True).ToString
                                    Args.ToBeInsertedInFunction = "var objList;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "objList = GetObjectReference('frmCommonList','chkDelete');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "if (objList == null) {return;}" + vbCrLf

                                    'Added by by TruptiK on 7-Jun-2007 to give alert if user has not selected any record.
                                    Args.ToBeInsertedInFunction += "var blnIsRecordSelected=false;blnIsRecordSelected=IsCheckboxSelected('frmCommonList','chkDelete');"
                                    Args.ToBeInsertedInFunction += "if (blnIsRecordSelected == false) {" + vbCrLf
                                    Args.ToBeInsertedInFunction += " alert('Please select at least one deliverable');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "}" + vbCrLf
                                    'End of addition by TruptiK on 7-Jun-2007 

                                    Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "objForm.action = 'CommonPage.aspx?PKToken=" + m_strToken + "&Operation=DYNAMIC_LINK&DYNAMIC_LINK_ID=" & strLinkID & "&UniqueValue=' + intUniqueID + '&IsListPageLink=1&MasterTagID=3586&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&Customer=" & HttpContext.Current.Request.QueryString("Customer") & "&RFIID=" & HttpContext.Current.Request.QueryString("RFIID") & "';" + vbCrLf
                                    Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf

                                    Args.ToBeInsertedInFunction += "var strhRef;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "var intIndex;" + vbCrLf

                                    'Commented And Added By Usha Pandit On 22.07.2020 For Save issue for deliverable as RFI item in chrome 
                                    'Args.ToBeInsertedInFunction += "window.opener.document.forms[0].cboRFITypeID.disabled = false;" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "window.opener.document.forms[0].cboCustomerID.disabled = false;" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "window.opener.document.forms[0].cboBillingCurrencyID.disabled = false;" + vbCrLf

                                    'Args.ToBeInsertedInFunction += "var objform = window.opener.document.forms[0];" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "strhRef = window.opener.location.href;" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/Mode=New/,'Mode=Edit');" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/&Action=DeleteItem/,'');" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/&Action=Save/,'');" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/&Action=ChangeCustomer/,'');" + vbCrLf
                                    ''Added by TruptiK on 23-May-2007
                                    'Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/&Action=Copy/,'');"
                                    ''End of addition by TruptiK

                                    ''Integrated and uncommented by SavitaS on 14 Mar 2006 for IssueID-2836
                                    'Args.ToBeInsertedInFunction += "intIndex= strhRef.indexOf('&RFIID');" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "if(intIndex!=-1)" + vbCrLf
                                    ''commented and Modified by TruptiK on 15-May-2007
                                    ''Args.ToBeInsertedInFunction += "strhRef = strhRef.substring(0,intIndex-1)" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "strhRef = strhRef.substring(0,intIndex)" + vbCrLf
                                    ''Args.ToBeInsertedInFunction += "strhRef += '&SelectionFlag=1&NewRFIID=" & HttpContext.Current.Request.QueryString("RFIID") & "';" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "strhRef += '&RFIID=" & HttpContext.Current.Request.QueryString("RFIID") & "';" + vbCrLf

                                    ''Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                                    ''Args.ToBeInsertedInFunction += "intIndex= strhRef.indexOf('&PKToken');" + vbCrLf
                                    ''Args.ToBeInsertedInFunction += "if(intIndex!=-1)" + vbCrLf
                                    ''Args.ToBeInsertedInFunction += "strhRef = strhRef.substring(0,intIndex-1)" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "strhRef += '&NewPKToken=" & m_strToken & "';" + vbCrLf
                                    ''End of addition

                                    'Args.ToBeInsertedInFunction += "objform.action = strhRef;" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "objform.submit();" & vbCrLf
                                    ''End Integration by SavitaS 

                                    'Args.ToBeInsertedInFunction += "objform.action = strhRef;" & vbCrLf
                                    'Args.ToBeInsertedInFunction += "objform.submit();" & vbCrLf
                                    ''Args.ToBeInsertedInFunction += "window.opener.location.href = strhRef;" & vbCrLf

                                    'Args.ToBeInsertedInFunction += " window.close();" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "return;" + vbCrLf

                                    Args.ToBeInsertedInFunction += "window.onunload = function(){ " + vbCrLf

                                    'Args.ToBeInsertedInFunction += " function refreshMyParent() { " + vbCrLf

                                    Args.ToBeInsertedInFunction += "var strhRef;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "var intIndex;" + vbCrLf

                                    Args.ToBeInsertedInFunction += " window.opener.document.forms[0].cboRFITypeID.disabled = false;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "window.opener.document.forms[0].cboCustomerID.disabled = false;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "window.opener.document.forms[0].cboBillingCurrencyID.disabled = false;" + vbCrLf

                                    Args.ToBeInsertedInFunction += "var objform = window.opener.document.forms[0];" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strhRef = window.opener.location.href;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/Mode=New/,'Mode=Edit');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/&Action=DeleteItem/,'');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/&Action=Save/,'');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/&Action=ChangeCustomer/,'');" + vbCrLf

                                    Args.ToBeInsertedInFunction += "strhRef = strhRef.replace(/&Action=Copy/,'');"

                                    Args.ToBeInsertedInFunction += "intIndex= strhRef.indexOf('&RFIID');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "if(intIndex!=-1)" + vbCrLf

                                    Args.ToBeInsertedInFunction += "strhRef = strhRef.substring(0,intIndex)" + vbCrLf

                                    Args.ToBeInsertedInFunction += "strhRef += '&RFIID=" & HttpContext.Current.Request.QueryString("RFIID") & "';" + vbCrLf

                                    Args.ToBeInsertedInFunction += "strhRef += '&NewPKToken=" & m_strToken & "';" + vbCrLf

                                    Args.ToBeInsertedInFunction += "objform.action = strhRef;" & vbCrLf
                                    Args.ToBeInsertedInFunction += "objform.submit();" & vbCrLf

                                    Args.ToBeInsertedInFunction += "objform.action = strhRef;" & vbCrLf
                                    Args.ToBeInsertedInFunction += "objform.submit();" & vbCrLf

                                    Args.ToBeInsertedInFunction += " window.close();" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;" + vbCrLf
                                    Args.ToBeInsertedInFunction += " } " + vbCrLf
                                    Args.ToBeInsertedInFunction += " return; " + vbCrLf

                                    'End Of Added By Usha Pandit On 22.07.2020 For Save issue for deliverable as RFI item in chrome
                                End If
                            End If
                            'End of Addition

                            'End Integration by SavitaS on 13 Mar 2006
                            '-----------------------------------------------------------------------------
                            'Case CommonFunction.Constants.APP_TAG_RFI_OS
                            '    Select Case Args.SystemLinkType.ToUpper
                            '        Case "ADD_NEW", "DELETE", "SELECT_ALL"
                            '            Cancel = True
                            '    End Select
                            '    If Args.ClientSideFunctionName.ToUpper = "CLOSE" Then
                            '        Args.ToBeInsertedInFunction = "window.close();return;"
                            '    End If
                            'Case CommonFunction.Constants.APP_TAG_RFI_SALES_PERSON
                            '    Select Case Args.SystemLinkType.ToUpper
                            '        Case "ADD_NEW", "DELETE", "SELECT_ALL"
                            '            Cancel = True
                            '    End Select
                            '    If Args.ClientSideFunctionName.ToUpper = "CLOSE" Then
                            '        Args.ToBeInsertedInFunction = "window.close();return;"
                            '    End If

                            '***** End Modification and Comment  by SandipL on 7 Dec 2005
                        Case CommonFunction.Constants.APP_TAG_RFI_CHECKLIST_VIEW
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL"
                                    Cancel = True
                            End Select
                            'Added Code To Resolve IssueID 12266 on 6 August 2004
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE" Then
                                Args.ToBeInsertedInFunction = "window.close();return;"
                            End If
                            'End Of Addition

                            'End Of Addition
                            'Added By NileshD on 31 July 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_APPROVAL
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL"
                                    Cancel = True
                            End Select
                            'End Of Addition

                            'Added By JayavantK on 31 July 2004
                        Case CommonFunction.Constants.APP_TAG_BUSINESSGROUP
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD"
                                    Cancel = True
                            End Select
                            'End Of Addition
                            'Added by ShamkantD on 31st July 2004 
                        Case CommonFunction.Constants.APP_TAG_PM_DISPLAY_CUSTOMER
                            'Remove all links on Customer Information page
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD", "FILTERS", "SHOW_HISTORY"
                                    Cancel = True
                            End Select

                            'Code for Close link
                            Dim strFunction As String
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                strFunction = "window.close(); return;"
                                Args.ToBeInsertedInFunction = strFunction
                            End If
                            'End of addition - ShamkantD on 31st July 2004

                            'Added by ShamkantD on 2nd August 2004 
                        Case CommonFunction.Constants.APP_TAG_PM_FIXED_BID
                            'Remove all links 
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE_ADD", "FILTERS", "SHOW_HISTORY"
                                    Cancel = True
                            End Select

                            Dim strFunction As String
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                strFunction = "window.close(); return;"
                                Args.ToBeInsertedInFunction = strFunction
                            End If


                        Case CommonFunction.Constants.APP_TAG_PM_BILLING_ADDRESS
                            'Remove all links 
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE_ADD", "FILTERS", "SHOW_HISTORY"
                                    Cancel = True
                            End Select

                            Dim strFunction As String
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                strFunction = "window.close(); return;"
                                Args.ToBeInsertedInFunction = strFunction
                            End If
                            'End of addition - ShamkantD on 2nd August 2004 
                            'Added By NileshD on 2 August 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_GENERATION
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL"
                                    Cancel = True
                            End Select
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_DETAIL_LIST
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW"
                                    Cancel = True
                            End Select
                            ' End Of Addition
                            'added by SachinR   on 2 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_SOFTEX_FORM_GENERATION
                            'here Save link is hidden in edit mode,as it is 
                            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                                If Args.PrimaryKeyValue <> "" Then
                                    Cancel = True
                                End If
                            End If
                            'addition end

                            'added by SachinR   on 3 aug 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_SOFTEX_BATCH_GENERATION_PERIOD, CommonFunction.Constants.APP_TAG_RFI_SOFTEX_BATCH_GENERATION_DATES
                            If Args.ClientSideFunctionName.ToUpper = "GENERATERTF" Or Args.ClientSideFunctionName.ToUpper = "GENERATEPDF" Then
                                Dim strFunction As String
                                strFunction = "if(ValidateForm_HeaderSection()==false) return;"
                                Args.ToBeInsertedInFunction = strFunction
                                'modified by SachinR   on 23 Aug 2004
                                'issue 12530
                            ElseIf Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Dim strFunction As String
                                strFunction = "window.close(); return;"
                                Args.ToBeInsertedInFunction = strFunction
                            End If
                            'modification end
                            'addition end
                        Case CommonFunction.Constants.TAG_AUDIT_TRAIL
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Dim strFunction As String
                                strFunction = "window.close();return;"
                                Args.ToBeInsertedInFunction = strFunction
                            End If

                            'Integrated by SavitaS on 22 Dec 2005 for IssueID 1936
                            'added by harshada d on 29 nov 2005 for show history page in helpdesk
                        Case CommonFunction.Constants.APP_TAG_SHOW_CRM_HISTORY
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "SAVE", "SAVE_ADD", "DELETE", "SELECT_ALL", "FILTERS", "CONFIGURE"
                                    Cancel = True
                            End Select

                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Dim strFunction As String
                                strFunction = "window.close();return;"
                                Args.ToBeInsertedInFunction = strFunction
                            End If
                            'end of addition by harshada d on 29 nov 2005 for show history page in helpdesk

                            'added by harshada d on 30 nov 2005 for helpdesk  whiziblesem 6 issue id 1936
                        Case CommonFunction.Constants.APP_TAG_SELECT_REQUEST_CATEGORY
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "SAVE"
                                    Cancel = True
                            End Select
                            'Integrated by SandipL SP8 to SP9

                            'Modified by SrikanthY on 16 Jan 2007 For issue 9419
                            'Modified by SrikanthY on 03 Jan 2007 Changed the control name in the below code to validate Customer Selection
                            If Args.ClientSideFunctionName.ToUpper = "NEXT_ONCLICK" Then
                                Dim strFunction As String
                                Args.ToBeInsertedInFunction = " var objOpt = GetObjectReference('frmCommonPage','NonDatabase1',true); " + vbCrLf
                                Args.ToBeInsertedInFunction += " if(objOpt[0].checked==true){ " + vbCrLf
                                'Args.ToBeInsertedInFunction += " var objCbo = GetObjectReference('frmCommonPage','CustomerName'); " + vbCrLf
                                Args.ToBeInsertedInFunction += " var objCbo = GetObjectReference('frmCommonPage','NonDatabase4'); " + vbCrLf
                                Args.ToBeInsertedInFunction += " if(disallowBlank(objCbo,'Please select the Customer!',true)) return; " + vbCrLf
                                Args.ToBeInsertedInFunction += " } " + vbCrLf
                                'SrikanthY on 29 Dec 2006 Added code to be insertd in function for validating newly added employee combobox
                                Args.ToBeInsertedInFunction += " else if(objOpt[1].checked==true){ " + vbCrLf
                                Args.ToBeInsertedInFunction += " var objCbo = GetObjectReference('frmCommonPage','NonDatabase3'); " + vbCrLf
                                Args.ToBeInsertedInFunction += " if(disallowBlank(objCbo,'Please select the Employee Name!',true)) return; " + vbCrLf
                                Args.ToBeInsertedInFunction += " } " + vbCrLf
                                'End of addition by SrikanthY
                                'End of modification by SrikanthY on 16 Jan 2007
                                'End Integration by SandipL SP8 to SP9


                                'Args.ToBeInsertedInFunction += "window.style.visibility='hidden'; " + vbCrLf
                                'Args.ToBeInsertedInFunction = strFunction
                            End If
                            'end of addition by harshada d on 29 nov 2005 for show history page in helpdesk whiziblesem 6 issue id 1936
                            'End Integration by SavitaS on 22 Dec 2005

                            'Added By JayavantK on 4 August 2004
                        Case CommonFunction.Constants.APP_TAG_BGPOOL_MASTER
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD"
                                    Cancel = True
                            End Select
                            'End Of Addition

                            'added by SachinR   On 4 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLE_CODE_DEFINITION, CommonFunction.Constants.APP_TAG_PROCESS_PHASETASK_TEMPLATE_PUBLISH, CommonFunction.Constants.APP_TAG_PROCESS_PHASETASK_PUBLISH
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Dim strFunction As String
                                strFunction = "window.close();return;"
                                Args.ToBeInsertedInFunction = strFunction
                            End If
                            'addition end

                            'added by SachinR   On 06 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_SERIES_GENERATION
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Dim strFunction As String
                                strFunction = "window.close();return;"
                                Args.ToBeInsertedInFunction = strFunction
                            End If
                            'addition end

                            'Added by ShamkantD on 6th August 2004
                        Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING
                            If Args.ClientSideFunctionName.ToUpper = "ADD_ONCLICK" Then
                                Dim strFunction As String
                                strFunction &= "var objfrm = GetFormReference('frmCommonList');" & vbCrLf
                                'Commented and added by NitinC on 20 April 2011 for WhizibleSEM 10.0 after sub projects page is inherited 		    
                                'strFunction &= "objfrm.action=""CommonPage.aspx?Mode=ADD_NEW&FromWhere=PM&MasterTagId=1263"";" & vbCrLf\
                                strFunction &= "objfrm.action=""../PM/CreateProject_CommonPage.aspx?Mode=ADD_NEW&FromWhere=PM&MasterTagId=1263"";" & vbCrLf
                                'End of Commented and added by NitinC on 20 April 2011 for WhizibleSEM 10.0 after sub projects page is inherited 
                                strFunction &= "objfrm.submit();" & vbCrLf
                                strFunction &= "return;" & vbCrLf
                                Args.ToBeInsertedInFunction = strFunction
                            End If
                            'End of addition - ShamkantD on 6th August 2004
                            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM SP 8 Regression IssueID 13163
                            ' Added if condition for Args.ClientSideFunctionName.ToUpper() = "SETBASELINE_CLICK" , "REJECTREV_ONCLICK"
                            If Args.ClientSideFunctionName.ToUpper() = "SETBASELINE_CLICK" Or Args.ClientSideFunctionName.ToUpper() = "REJECTREV_ONCLICK" Then

                                'Added By JyotiG
                                'CRID_7086 for SP8
                                'Start_JG_7086_30-Oct-2006
                                'Start_AJ_10-Oct-2006, If BaselineNumber = 0 then rename Approve/Reject Revision links as Approve/Reject Project Else Show existing titles as it is.
                                If Not IsNothing(HttpContext.Current.Session("intProjectID")) Then
                                    Dim str As String = "EXEC usp_Sel_tbl_CNF_Project_Status " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID").ToString, "0")
                                    Dim dr As IDataReader
                                    Dim m_intBaselineNumber As Integer
                                    dr = CommonFunction.Data.GetDataReader(str, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If CommonFunctions.General.CheckIsNothing(dr) <> "" Then
                                        If dr.Read() Then
                                            m_intBaselineNumber = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("BaselineNumber"), "0"), "0"), Integer)
                                        End If
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(dr)

                                    '--- modified By purvaj on 3 Dec 2008 for whiziblesem 8.0
                                    '--- if old workflow is in progress and new workflow made on. then display old links only till the revision gets completed
                                    '--- condition added Or (m_intBaselineNumber = 1 And WFInstance = 0)
                                    Dim WFInstance As Integer = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("select 1 from tbl_IM_Workflowinstance where projectid= " + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID")).ToString + " and primarykeyvalue= " + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID")).ToString + " and Tagid = 32", True), 0), 0)
                                    If m_intBaselineNumber = 0 Or (m_intBaselineNumber = 1 And WFInstance = 0) Then
                                        Select Case Args.ClientSideFunctionName.ToUpper()
                                            Case "SETBASELINE_CLICK"
                                                Args.LinkName = "Approve Project"
                                                Args.LinkToolTip = "Approve Project"
                                            Case "REJECTREV_ONCLICK"
                                                Args.LinkName = "Reject Project"
                                                Args.LinkToolTip = "Reject Project"
                                        End Select
                                    End If
                                End If
                                'End_AJ_10-Oct-2006
                                'End_JG_7086_30-Oct-2006

                            End If
                            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM SP 8 Regression IssueID 13163

                            'Added by Lakshmi on 21st Aug 2004
                            'While editing Project detaills..
                            '1. If contract type is fixed bid then contract value should be mandatory 
                            '2. If Contract Value is entered then currency should be mandatory
                            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                                '''''''''''''''''''''''''''''''''''''''''''''''''''''''

                                '''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                                ''Added by NitinC on 19 April 2012 for WhizibleSEM 11.0 [Issue Fix : 61258 Custom Field]
                                'Args.ToBeInsertedInFunction = "if(ValidateCustomFields()==false){return;}" & vbCrLf
                                ''End of Added by NitinC on 19 April 2012 for WhizibleSEM 11.0 [Issue Fix : 61258 Custom Field]
                                Args.ToBeInsertedInFunction += "if (frmCommonPage.ContractType.value == ""1"")" & vbCrLf
                                Args.ToBeInsertedInFunction += "     {if (frmCommonPage.ContractValue.value == """")" & vbCrLf
                                Args.ToBeInsertedInFunction += "            {alert(""Please enter Project Value for Fixed Bid Project !"");" & vbCrLf
                                Args.ToBeInsertedInFunction += "            frmCommonPage.ContractValue.focus();" & vbCrLf
                                Args.ToBeInsertedInFunction += "            return;}}" & vbCrLf
                                Args.ToBeInsertedInFunction += "if (frmCommonPage.ContractValue.value != """")" & vbCrLf
                                Args.ToBeInsertedInFunction += "   {" & vbCrLf
                                Args.ToBeInsertedInFunction += "        if (frmCommonPage.BaseCurrency.value == """") " & vbCrLf
                                Args.ToBeInsertedInFunction += "        {" & vbCrLf
                                Args.ToBeInsertedInFunction += "            alert(""Please enter the currency !"");" & vbCrLf
                                Args.ToBeInsertedInFunction += "            frmCommonPage.BaseCurrency.focus()" & vbCrLf
                                Args.ToBeInsertedInFunction += "            return;" & vbCrLf
                                Args.ToBeInsertedInFunction += "        } " & vbCrLf
                                Args.ToBeInsertedInFunction += "    }" & vbCrLf
                                'Added by NitinC on 22 Dec 2011 for WhizibleSEM 11.0 (Agile Module)
                                'Purpose : Project dates validate with scrum release dates, Project work hrs validate with release total estimation under scrum project only.
                                Args.ToBeInsertedInFunction += "var IsScumProj = GetObjectReference('frmCommonPage','NonDatabase4').value;" & vbCrLf
                                Args.ToBeInsertedInFunction += "if (IsScumProj == ""1"")" & vbCrLf
                                Args.ToBeInsertedInFunction += "var objCurrentProjectStartDate =GetObjectReference('frmCommonPage','ExpectedStartDate').value;" & vbCrLf
                                Args.ToBeInsertedInFunction += "var objCurrentProjectEndDate =GetObjectReference('frmCommonPage','ExpectedEndDate').value;" & vbCrLf
                                Args.ToBeInsertedInFunction += "var objRelMinStartDate = GetObjectReference('frmCommonPage','NonDatabase5').value;" & vbCrLf
                                Args.ToBeInsertedInFunction += "var objRelMaxEndDate = GetObjectReference('frmCommonPage','NonDatabase6').value;" & vbCrLf
                                Args.ToBeInsertedInFunction += "var objCurrentProjWork = GetObjectReference('frmCommonPage','EstimatedEfforts').value;" & vbCrLf
                                Args.ToBeInsertedInFunction += "var objTotalRelWork = GetObjectReference('frmCommonPage','NonDatabase7').value;" & vbCrLf
                                Args.ToBeInsertedInFunction += "if (compareDates(objRelMaxEndDate,objCurrentProjectEndDate)==1)  {" & vbCrLf
                                Args.ToBeInsertedInFunction += "alert('Project End Date should not be less than active Scrum Release(s) Max End Date (' + objRelMaxEndDate + ') on Project.');" & vbCrLf
                                Args.ToBeInsertedInFunction += "return; }"
                                Args.ToBeInsertedInFunction += "if (compareDates(objCurrentProjectStartDate,objRelMinStartDate)==1)  {" & vbCrLf
                                Args.ToBeInsertedInFunction += "alert('Project Start Date should not be greater than active Scrum Release(s) Min Start Date (' + objRelMinStartDate + ') on Project.');" & vbCrLf
                                Args.ToBeInsertedInFunction += "return; }"
                                Args.ToBeInsertedInFunction += "if (parseInt(objCurrentProjWork) < parseInt(objTotalRelWork))  {" & vbCrLf
                                Args.ToBeInsertedInFunction += "alert('Project Work (hrs) should not be less than active Scrum Release(s) Work (hrs) (' + objTotalRelWork + ') on Project.');" & vbCrLf
                                Args.ToBeInsertedInFunction += "return; }"
                                'End of Added by NitinC on 22 Dec 2011 for WhizibleSEM 11.0 (Agile Module)
                                'Added by GokulP on 17 May 2010 for Service Pack1 
                                'Purpose : Project End Date & Resource Date Validation
                                Dim strSQL As String = ""
                                Dim ResourceStartDate As String = ""
                                Dim ResourceEndDate As String = ""
                                Dim strProjectID As String = "0"

                                strProjectID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID"), "")

                                If strProjectID = "" Then
                                    strProjectID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") 'HttpContext.Current.Session("intProjectID").ToString()
                                End If

                                If strProjectID <> "0" Then
                                    strSQL = "SELECT MIN(ExpectedStartDate) AS ResourceStartDate,MAX(ExpectedEndDate) AS ResourceEndDate FROM tbl_PM_ProjectEmployeeRole WITH (NOLOCK) WHERE ProjectID = " & strProjectID & " AND ActualEndDate IS NULL "

                                    Dim drReader As IDataReader
                                    drReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    If (drReader.Read) Then
                                        ResourceStartDate = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drReader("ResourceStartDate"), ""), ""), String)
                                        ResourceEndDate = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drReader("ResourceEndDate"), ""), ""), String)
                                        If ResourceStartDate <> "" Then
                                            ResourceStartDate = CommonFunction.Dates.GetDate(CType(drReader("ResourceStartDate"), Date))
                                        End If
                                        If ResourceEndDate <> "" Then
                                            ResourceEndDate = CommonFunction.Dates.GetDate(CType(drReader("ResourceEndDate"), Date))
                                        End If
                                    End If

                                    CommonFunction.Data.DisposeDataReader(drReader)

                                    If ResourceStartDate <> "" And ResourceEndDate <> "" Then
                                        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                        'Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("ResourceMaxEndDate", "ResourceMaxEndDate", , , , ResourceEndDate.ToString, , , , , , True, , True)
                                        'Args.ToBeInserted += CommonFunction.HTMLControls.DrawTextBox("ResourceMinStartDate", "ResourceMinStartDate", , , , ResourceStartDate.ToString, , , , , , True, , True)
                                        Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("ResourceMaxEndDate", "ResourceMaxEndDate", , , , ResourceEndDate.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
                                        Args.ToBeInserted += CommonFunction.HTMLControls.DrawTextBox("ResourceMinStartDate", "ResourceMinStartDate", , , , ResourceStartDate.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
                                        Args.ToBeInsertedInFunction += "var objCurrentProjectStartDate =GetObjectReference('frmCommonPage','ExpectedStartDate');" & vbCrLf
                                        Args.ToBeInsertedInFunction += "var objCurrentProjectEndDate =GetObjectReference('frmCommonPage','ExpectedEndDate');" & vbCrLf
                                        Args.ToBeInsertedInFunction += "var objResourceMinStartDate=GetObjectReference('frmCommonPage','ResourceMinStartDate');" & vbCrLf
                                        Args.ToBeInsertedInFunction += "var objResourceMaxEndDate=GetObjectReference('frmCommonPage','ResourceMaxEndDate');" & vbCrLf
                                        Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objResourceMaxEndDate,objCurrentProjectEndDate))  {" & vbCrLf
                                        Args.ToBeInsertedInFunction += "alert('Project End Date should not be less than active Resource(s) Max End Date(' + objResourceMaxEndDate.value + ') on Project.');" & vbCrLf
                                        Args.ToBeInsertedInFunction += "return; }"
                                        Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objCurrentProjectStartDate,objResourceMinStartDate))  {" & vbCrLf
                                        Args.ToBeInsertedInFunction += "alert('Project Start Date should not be greater than active Resource(s) Min Start Date(' + objResourceMinStartDate.value + ') on Project.');" & vbCrLf
                                        Args.ToBeInsertedInFunction += "return; }"
                                    End If
                                End If
                                'End of Addition by GokulP on 17 May 2010 for Service pack1 Issue : Project End Date & Resource Date Validation

                            End If
                            'End Addition


                            'Modified by ShamkantD on 01 Oct 2004
                            'Get the status of 'Project creation workflow required' flag
                            Dim blnIsProjectCreationWorkflowReqd As Boolean = False
                            blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("blnIsProjectCreationWorkflowReqd"), "False"), Boolean)

                            Dim blnIsApprover As Boolean = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("blnIsApprover"), "False"), Boolean)

                            'Added by ShamkantD on 29 Sep 2004 - added for Project Information page
                            'Check whether the Project for which information is shown is opened for Approval,
                            'so that accordingly links should be hidden 
                            Dim blnProjectForApprovalFlag As Boolean = False
                            blnProjectForApprovalFlag = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("blnProjectForApprovalFlag"), "False"), Boolean)
                            'End of addition - ShamkantD on 29 Sep 2004
                            'Added By JyotiG
                            'Start
                            Dim strLoadFrom As String
                            Dim drPrjInfo As IDataReader
                            Dim strSqlPrjInfo As String
                            Dim strProjectOver As String
                            'End(JyotiG)    

                            If blnIsProjectCreationWorkflowReqd = True Then
                                'Added by ShamkantD on 24 Sep 2004
                                If blnIsApprover = True And blnProjectForApprovalFlag = True Then
                                    'Hide project links for Approver for Approval Project
                                    'Added by ShamkantD on 11 Oct 2004
                                    'Hide links depending upon the Project Baseline Status 
                                    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strProjectBaselineStatus"), "").ToString() = "B" Then
                                        'If the status is Baselined, do not show Project Information related links
                                        Select Case Args.ClientSideFunctionName.ToUpper()
                                            Case "FIXEDBID_CLICK", "RATECONTRACT_CLICK", "DOH_CLICK"
                                                Cancel = True
                                        End Select
                                    End If
                                    'End of addition - ShamkantD on 11 Oct 2004

                                    Select Case Args.ClientSideFunctionName.ToUpper()
                                        ' modified by harshada d for showing history to project approvers for whiziblesem 6 on 29 march 2006 Issue ID.3110
                                        'Case "SENDAPPROVAL_CLICK", "REVISION_ONCLICK", "SAVE_ONCLICK", "CONTRACTCLAUSE_CLICK", "FACILITY_CLICK", "INERTIT_DATE", "PROJECTINFOREPORT", "HISTORY_ONCLICK", "SHOWREVISION_CLICK"

                                        Case "SENDAPPROVAL_CLICK", "REVISION_ONCLICK", "CONTRACTCLAUSE_CLICK", "FACILITY_CLICK", "INERTIT_DATE", "PROJECTINFOREPORT", "SHOWREVISION_CLICK", "SAVE_ONCLICK"
                                            ' modified by harshada d for showing history to project approvers for whiziblesem 6 on 29 march 2006 Issue ID.3110
                                            Cancel = True
                                    End Select
                                Else
                                    If blnIsApprover = False Then
                                        'Hide project links for Project Manager
                                        Select Case Args.ClientSideFunctionName.ToUpper()
                                            '---SHOW_APPROVALS Commented by purvaj on 11 Dec 2008
                                            '--- show approvals displayed both the projects following old or new workflows.
                                            Case "SETBASELINE_CLICK", "REJECTREV_ONCLICK" ', "SHOW_APPROVALS"
                                                Cancel = True
                                        End Select
                                    End If

                                    'Added by ShamkantD on 21 Oct 2004
                                    'If the project is not for approval, hide the approve and reject links
                                    If blnProjectForApprovalFlag = False Then
                                        Select Case Args.ClientSideFunctionName.ToUpper()
                                            Case "SETBASELINE_CLICK", "REJECTREV_ONCLICK"
                                                Cancel = True
                                        End Select
                                    End If

                                    'End of addition - ShamkantD on 21 Oct 2004
                                End If

                                'Added By JyotiG
                                'Start
                                'Issue Id : 6236

                                'Modified By VidayJ - IssueID - 11658
                                'strLoadFrom = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("LoadFrom"), "LISTING").ToString()

                                If blnIsApprover = False Then
                                    Select Case Args.ClientSideFunctionName.ToUpper()
                                        Case "SETBASELINE_CLICK", "REJECTREV_ONCLICK"
                                            Cancel = True
                                    End Select
                                End If
                                'End

                                ' Modified By NitinVS on 8 May 2007 for WhizibleSEM SP 8 Regression IssueID 13163
                                ' Added if condition for FunctionName = SENDAPPROVAL_CLICK or REVISION_ONCLICK
                                If Cancel = False And (Args.ClientSideFunctionName.ToUpper() = "SENDAPPROVAL_CLICK" Or Args.ClientSideFunctionName.ToUpper() = "REVISION_ONCLICK") Then


                                    ''Added By JyotiG
                                    ''Start
                                    ''Issue Id : 6236
                                    strSqlPrjInfo = "Select [Over] from tbl_PM_Project where ProjectID =" & HttpContext.Current.Session("intProjectID").ToString
                                    'drPrjInfo = CommonFunction.Data.GetDataReader(strSqlPrjInfo, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    'If drPrjInfo.Read Then
                                    '    strProjectOver = CType(CommonFunction.Data.CheckIsDBNull(drPrjInfo("Over"), "False"), String)
                                    'End If
                                    strProjectOver = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSqlPrjInfo, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0").ToString

                                    If strProjectOver = "True" Then
                                        Select Case Args.ClientSideFunctionName.ToUpper()
                                            Case "SENDAPPROVAL_CLICK", "REVISION_ONCLICK"
                                                Cancel = True
                                        End Select
                                    End If
                                    'End
                                    'CommonFunction.Data.DisposeDataReader(drPrjInfo)

                                End If

                                ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM SP 8 Regression IssueID 13163

                                'Added By JyotiG
                                'Date : 25-Sep-2006
                                'Start
                                'Issue ID : 6190
                                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strProjectBaselineStatus"), "").ToString() <> "B" Then
                                    Select Case Args.ClientSideFunctionName.ToUpper()
                                        Case "INERTIT_DATE"
                                            Cancel = True
                                    End Select
                                End If
                                'End
                            Else
                                'Hide links for Project Creation Workflow
                                Select Case Args.ClientSideFunctionName.ToUpper()
                                    Case "SENDAPPROVAL_CLICK", "REVISION_ONCLICK", "SETBASELINE_CLICK", "REJECTREV_ONCLICK", "SHOWREVISION_CLICK"
                                        Cancel = True
                                End Select

                                If blnIsApprover = True And blnProjectForApprovalFlag = True Then
                                    'Hide project links for Approver 
                                    Select Case Args.ClientSideFunctionName.ToUpper()
                                        ' modified by harshada d for showing history to project approvers for whiziblesem 6 on 29 march 2006 Issue ID.3110
                                        'Case "SAVE_ONCLICK", "CONTRACTCLAUSE_CLICK", "FACILITY_CLICK", "INERTIT_DATE", "PROJECTINFOREPORT", "HISTORY_ONCLICK"

                                        Case "CONTRACTCLAUSE_CLICK", "FACILITY_CLICK", "INERTIT_DATE", "PROJECTINFOREPORT", "SAVE_ONCLICK"
                                            'end of modified by harshada d for showing history to project approvers for whiziblesem 6 on 29 march 2006 Issue ID.3110
                                            Cancel = True
                                    End Select
                                End If
                                '---- Code commented by purvaj on 26 Nov 2008 for whiziblesem 8.0
                                '----condition handled in conditional clause for the link
                                'If blnIsApprover = False Then
                                '    'Hide Show Approvals link for Project Manager
                                '    If Args.ClientSideFunctionName.ToUpper() = "SHOW_APPROVALS" Then
                                '        Cancel = True
                                '    End If
                                'End If
                                '--- End comment purvaj
                            End If
                            'End of modification - ShamkantD on 01 Oct 2004

                            'Addition by SuchitraP on 20-Mar-2009 for IssueID : (29640 -8.0 IssueID) (28405 -7.2 IssueID)
                            'Purpose : Project cost access link will be seen only if that node has edit access
                            If Args.ClientSideFunctionName.ToUpper = "DOH_CLICK" Then
                                Dim drAccess As IDataReader
                                Dim strAddAccess As String
                                Dim strEditAccess As String
                                Dim strDeleteAccess As String
                                Dim strViewAccess As String

                                drAccess = CommonFunction.Data.GetDataReader("usp_Check_Role_Access 2158," + HttpContext.Current.Session("intPostID").ToString + "," + HttpContext.Current.Session("intUserID").ToString + "," + HttpContext.Current.Session("LoginType").ToString, True)
                                If drAccess.Read Then
                                    strAddAccess = drAccess("A").ToString
                                    strEditAccess = drAccess("E").ToString
                                    strDeleteAccess = drAccess("D").ToString
                                    strViewAccess = drAccess("V").ToString
                                End If
                                ' Added By NitinVS on 3 July 2005 
                                CommonFunction.Data.DisposeDataReader(drAccess)
                                ' End addition by NitinVS on 3 July 2009 
                                If strEditAccess = "0" Then
                                    Cancel = True
                                End If
                            End If
                            'End of addition by SuchitraP on 20-Mar-2009 for IssueID : 28405
                            Select Case Args.ClientSideFunctionName.ToUpper()
                                'Added by ShamkantD on 27 Sep 2004 
                                Case "Show_Approvals".ToUpper()
                                    If Cancel = False Then
                                        Dim strFunction As String
                                        Dim strPagingAlphabet As String = "-1"
                                        If Trim(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PagingAlphabet"), "")) <> "" Then
                                            strPagingAlphabet = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PagingAlphabet"), "-1")
                                        End If
                                        '' START : Commented and Modified By ParagD 03-Oct-2006 
                                        ''strFunction &= " var strTemp = escape(""" + strPagingAlphabet + """); alert(strTemp); window.open('CommonList.aspx?MasterTagID=2225&PagingAlphabet='&SortBy=" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SortBy"), "") & "&SortOrder=" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SortOrder"), "") & "', '_blank', 'resizable=no,scrollbars=no,left=60,top=60,height=600,width=900');" & vbCrLf
                                        ''Added ../General/ in below line by NitinC on 12 Dec 2011 for WhizibleSEM 11.0.
                                        strFunction &= " var strTemp = escape(""" + strPagingAlphabet + """); window.open('../General/CommonList.aspx?MasterTagID=2225&PagingAlphabet=' + strTemp + '&SortBy=" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SortBy"), "") & "&SortOrder=" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SortOrder"), "") & "', '_blank', 'resizable=no,scrollbars=no,left=60,top=60,height=600,width=900');" & vbCrLf
                                        ''End of Added ../General/ in below line by NitinC on 12 Dec 2011 for WhizibleSEM 11.0.
                                        '' END : Commented and Modified By ParagD 03-Oct-2006    
                                        strFunction &= "return;" & vbCrLf
                                        Args.ToBeInsertedInFunction = strFunction
                                        'End of addition - ShamkantD on 27 Sep 2004
                                    End If
                                Case "SendApproval_Click".ToUpper()
                                    If Cancel = False Then
                                        Dim strFunction As String
                                        Dim strPagingAlphabet As String = "-1"

                                        'Added by ShamkantD on 24 Nov 2004
                                        Dim strQuery As String = ""
                                        Dim intBusinessGroupID As Integer = 0
                                        Dim intLocationID As Integer = 0
                                        Dim drProjectInformation As IDataReader
                                        Dim drApproversList As IDataReader
                                        'Added By JyotiG
                                        'Issue ID : 5687
                                        Dim intProjectID As String
                                        'End of addition - ShamkantD on 24 Nov 2004
                                        Dim strProjectStatus As String
                                        Dim drPrjStatus As IDataReader
                                        If Trim(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PagingAlphabet"), "")) <> "" Then
                                            strPagingAlphabet = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PagingAlphabet"), "-1")
                                        End If

                                        'Added by ShamkantD on 24 Nov 2004
                                        'Addition was made to display Alert to the user while sending the project 
                                        'for Approval if there are no approvers configured for that project

                                        'Get Business Group ID and Location ID
                                        drProjectInformation = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Project " & WhizGlobal.ProjectID.ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        If drProjectInformation.Read Then
                                            intBusinessGroupID = CType(CommonFunction.Data.CheckIsDBNull(drProjectInformation("BusinessGroupID"), "0"), Integer)
                                            intLocationID = CType(CommonFunction.Data.CheckIsDBNull(drProjectInformation("LocationID"), "0"), Integer)
                                            '  'added by TrupitK for hexaware request no 2447
                                            'Modified By JyotiG
                                            'Issue ID : 5687
                                            intProjectID = HttpContext.Current.Session("intProjectID").ToString
                                            'strProjectStatus = CType(CommonFunction.Data.CheckIsDBNull(drProjectInformation("ProjectStatus"), ""), String)
                                            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM SP 8 Regression IssueID 13163
                                            ' Replaced select with the sp and datareader with dataset 
                                            'Added By JyotiG
                                            'Issue ID 6190
                                            'Start
                                            strProjectStatus = "usp_Sel_tbl_CNF_Project_Status " & HttpContext.Current.Session("intProjectID").ToString
                                            'drPrjStatus = CommonFunction.Data.GetDataReader(strProjectStatus, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                            'If drPrjStatus.Read Then
                                            '    strProjectStatus = CType(CommonFunction.Data.CheckIsDBNull(drPrjStatus("ProjectStatus"), ""), String)
                                            'Else
                                            '    strProjectStatus = ""
                                            'End If
                                            strProjectStatus = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strProjectStatus, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")
                                            'End(JyotiG)

                                            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM SP 8 Regression IssueID 13163

                                            ''end of addition by TruptiK
                                        End If
                                        CommonFunction.Data.DisposeDataReader(drProjectInformation)
                                        'Added By JyotiG
                                        'Issue ID 6190
                                        'Start
                                        If strProjectStatus = "1" Then
                                            strFunction = "alert('Project is On Hold. Cannot send for approval.');" & vbCrLf
                                            strFunction &= "return;" & vbCrLf
                                        Else
                                            'End
                                            CommonFunction.Data.DisposeDataReader(drProjectInformation)
                                            'added by TrupitK for hexaware request no 2447
                                            'Modified By JyotiG(22-Aug-2006)(Remove ProjectID from SP param.)
                                            'Issue ID : 5687
                                            strQuery = "EXEC usp_Sel_tbl_PM_Employee_Approvers " & intBusinessGroupID.ToString() & "," & intLocationID.ToString() & "," & intProjectID.ToString()
                                            'strQuery = "EXEC usp_Sel_tbl_PM_Employee_Approvers " & intBusinessGroupID.ToString() & "," & intLocationID.ToString()
                                            'end of addition by TruptiK

                                            drApproversList = CommonFunction.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                            If drApproversList.Read Then
                                                strFunction = "var objfrm = GetFormReference('frmCommonPage');" & vbCrLf
                                                'Modified By JyotiG
                                                'Date :23-Aug-2006
                                                'Issue Id : 5687
                                                'Start
                                                'strFunction &= "if (confirm('Are you sure you want to send this project for approval?')==true)" & vbCrLf
                                                strFunction &= "{"
                                                'strFunction &= "   objfrm.action=""CommonPage.aspx?Operation=SENDFORAPPROVAL&Mode=&ProjectID=" & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString() & "&MasterTagID=32&FromWhere=PM&PagingAlphabet=" & strPagingAlphabet & "&ParentTagID=0"";" & vbCrLf
                                                'strFunction &= "   objfrm.submit();"

                                                'Modified By JyotiG (Date : 31-Aug-2006)
                                                'Start
                                                'strFunction &= "window.open('CommonPage.aspx?FromWhere=PM&MasterTagId=2220&FormAction=S&Operation=SENDFORAPPROVAL&Mode=','_blank','resizable=yes,scrollbars=no,left=' + (window.screen.width - 450)/2 + ',top=' + (window.screen.height - 250)/2 + ',width=500,height=250');" & vbCrLf
                                                ''Commented and Added by NitinC on WhizibleSEM 11.0 [Issue Fix : For Old workflow on project information page whn click on action links e.g. send for approval,show 
                                                ''revisions,show project approvers etc page is crashed. ]
                                                'strFunction &= "window.open('CommonPage.aspx?FromWhere=PM&MasterTagId=2220&FormAction=S&Operation=SENDFORAPPROVAL&Mode=','_blank','resizable=yes,scrollbars=no,left=' + (window.screen.width - 500)/2 + ',top=' + (window.screen.height - 400)/2 + ',width=700,height=400');" & vbCrLf
                                                strFunction &= "window.open('../General/CommonPage.aspx?FromWhere=PM&MasterTagId=2220&FormAction=S&Operation=SENDFORAPPROVAL&Mode=','_blank','resizable=yes,scrollbars=no,left=' + (window.screen.width - 500)/2 + ',top=' + (window.screen.height - 400)/2 + ',width=700,height=400');" & vbCrLf
                                                ''End of Commented and Added by NitinC on WhizibleSEM 11.0 [Issue Fix : For Old workflow on project information page whn click on action links e.g. send for approval,show 
                                                ''revisions,show project approvers etc page is crashed. ]
                                                'End

                                                strFunction &= "return;" & vbCrLf
                                                strFunction &= "}" & vbCrLf
                                                'strFunction &= "return;" & vbCrLf
                                                'End
                                            Else
                                                'Display Alert to the user while sending the project for Approval if 
                                                'there are no approvers configured for that project
                                                strFunction = "alert('There are no Project Approvers configured.');" & vbCrLf
                                                strFunction &= "return;" & vbCrLf
                                            End If
                                            CommonFunction.Data.DisposeDataReader(drApproversList)
                                        End If
                                        'End of addition - ShamkantD on 24 Nov 2004
                                        Args.ToBeInsertedInFunction = strFunction
                                    End If
                                Case "SetBaseline_Click".ToUpper()
                                    If Cancel = False Then
                                        Dim strFunction As String
                                        'Added By JyotiG
                                        'Start
                                        'Date : 18-Sep-2006
                                        Dim drPrjInformation As IDataReader
                                        Dim intBGId As Integer
                                        Dim intLOCId As Integer
                                        Dim drApprover As IDataReader
                                        Dim strApprover As String
                                        Dim strMSG As String
                                        objTemplate = New WebPages.Template.WhizTemplate
                                        objTemplate.InitializeResources("AppResources.CLCP_Events_DynamicActions", "AppResources")
                                        strMSG = objTemplate.GetResourceString("PROJECT_APPROVER_ALERT") + ""

                                        'Get Business Group ID and Location ID
                                        drPrjInformation = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Project " & HttpContext.Current.Session("intProjectID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        If drPrjInformation.Read Then
                                            intBGId = CType(CommonFunction.Data.CheckIsDBNull(drPrjInformation("BusinessGroupID"), "0"), Integer)
                                            intLOCId = CType(CommonFunction.Data.CheckIsDBNull(drPrjInformation("LocationID"), "0"), Integer)
                                        End If
                                        CommonFunction.Data.DisposeDataReader(drPrjInformation)
                                        drApprover = CommonFunction.Data.GetDataReader("EXEC usp_Sel_IsProjectApprover " & intBGId.ToString() & "," & intLOCId.ToString & "," & HttpContext.Current.Session("intProjectID").ToString & "," & HttpContext.Current.Session("intUserId").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        If drApprover.Read Then
                                            strApprover = CType(CommonFunction.Data.CheckIsDBNull(drApprover("Result"), "0"), String)
                                        End If
                                        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM SP 8 Regression IssueID 13163
                                        CommonFunction.Data.DisposeDataReader(drApprover)
                                        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM SP 8 Regression IssueID 13163

                                        If strApprover = "1" Then
                                            'End
                                            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM SP 8 Regression IssueID 13163
                                            ' Replaced Datareader With datascaler 
                                            'Added By JyotiG
                                            'Issue ID 6190
                                            'Start
                                            Dim strProjectStatus As String = ""
                                            'Dim drPrjStatus As IDataReader

                                            strProjectStatus = "usp_Sel_tbl_CNF_Project_Status " & HttpContext.Current.Session("intProjectID").ToString
                                            'drPrjStatus = CommonFunction.Data.GetDataReader(strProjectStatus, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                            'If drPrjStatus.Read Then
                                            '    strProjectStatus = CType(CommonFunction.Data.CheckIsDBNull(drPrjStatus("ProjectStatus"), ""), String)
                                            'Else
                                            '    strProjectStatus = ""
                                            'End If
                                            strProjectStatus = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strProjectStatus, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")

                                            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM SP 8 Regression IssueID 13163


                                            If strProjectStatus = "1" Then
                                                strFunction = "alert('Project is On Hold. Cannot approve.');" & vbCrLf
                                                strFunction &= "return;" & vbCrLf
                                            Else
                                                'End(JyotiG)
                                                'Modified By JyotiG (Date : 31-Aug-2006)
                                                'Start
                                                'strFunction &= "window.open('CommonPage.aspx?FromWhere=PM&MasterTagId=2220&FormAction=A','_blank','resizable=yes,scrollbars=no,left=' + (window.screen.width - 450)/2 + ',top=' + (window.screen.height - 250)/2 + ',width=500,height=250');" & vbCrLf
                                                ''Commented and added by NitinC on 24 April 2012 for WhizibleSEM 11.0 [Issue Fix ; For Old workflow on project information page whn click on action links e.g. send for approval,show 
                                                ''revisions,show project approvers etc page is crashed.]
                                                'strFunction &= "window.open('CommonPage.aspx?FromWhere=PM&MasterTagId=2220&FormAction=A','_blank','resizable=yes,scrollbars=no,left=' + (window.screen.width - 500)/2 + ',top=' + (window.screen.height - 400)/2 + ',width=700,height=400');" & vbCrLf
                                                strFunction &= "window.open('../General/CommonPage.aspx?FromWhere=PM&MasterTagId=2220&FormAction=A','_blank','resizable=yes,scrollbars=no,left=' + (window.screen.width - 500)/2 + ',top=' + (window.screen.height - 400)/2 + ',width=700,height=400');" & vbCrLf
                                                ''Commented and added by NitinC on 24 April 2012 for WhizibleSEM 11.0 [Issue Fix ; For Old workflow on project information page whn click on action links e.g. send for approval,show 
                                                ''revisions,show project approvers etc page is crashed.]

                                                'End
                                                strFunction &= "return;" & vbCrLf
                                            End If
                                            'Added By JyotiG
                                            'Start
                                            'Date : 18-Sep-2006
                                        Else
                                            strFunction = "alert('" + strMSG.Trim + "');" & vbCrLf
                                            strFunction &= "return;" & vbCrLf
                                        End If
                                        'End
                                        Args.ToBeInsertedInFunction = strFunction
                                    End If
                                Case "RejectRev_OnClick".ToUpper()
                                    If Cancel = False Then
                                        Dim strFunction As String
                                        'Added By JyotiG
                                        'Start
                                        'Date : 18-Sep-2006
                                        Dim drPrjInformation As IDataReader
                                        Dim intBGId As Integer
                                        Dim intLOCId As Integer
                                        Dim drApprover As IDataReader
                                        Dim strApprover As String
                                        Dim strMSG As String
                                        objTemplate = New WebPages.Template.WhizTemplate
                                        objTemplate.InitializeResources("AppResources.CLCP_Events_DynamicActions", "AppResources")
                                        strMSG = objTemplate.GetResourceString("PROJECT_APPROVER_ALERT") + ""
                                        'Get Business Group ID and Location ID
                                        drPrjInformation = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Project " & HttpContext.Current.Session("intProjectID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        If drPrjInformation.Read Then
                                            intBGId = CType(CommonFunction.Data.CheckIsDBNull(drPrjInformation("BusinessGroupID"), "0"), Integer)
                                            intLOCId = CType(CommonFunction.Data.CheckIsDBNull(drPrjInformation("LocationID"), "0"), Integer)
                                        End If
                                        CommonFunction.Data.DisposeDataReader(drPrjInformation)
                                        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM SP 8 Regression IssueID 13163
                                        ' Replaced Datareader with datascaler 
                                        'drApprover = CommonFunction.Data.GetDataReader("EXEC usp_Sel_IsProjectApprover " & intBGId.ToString() & "," & intLOCId.ToString & "," & HttpContext.Current.Session("intProjectID").ToString & "," & HttpContext.Current.Session("intUserId").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        'If drApprover.Read Then
                                        '    strApprover = CType(CommonFunction.Data.CheckIsDBNull(drApprover("Result"), "0"), String)
                                        'End If
                                        strApprover = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("EXEC usp_Sel_IsProjectApprover " & intBGId.ToString() & "," & intLOCId.ToString & "," & HttpContext.Current.Session("intProjectID").ToString & "," & HttpContext.Current.Session("intUserId").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0").ToString()
                                        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM SP 8 Regression IssueID 13163

                                        If strApprover = "1" Then
                                            'End
                                            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM SP 8 Regression IssueID 13163
                                            ' Replaced Datareader with datascaler  and select with the sp this sp returns onholdstatus as first column 

                                            'Added By JyotiG
                                            'Issue ID 6190
                                            'Start
                                            Dim strProjectStatus As String = ""
                                            'Dim drPrjStatus As IDataReader
                                            'strProjectStatus = "Select ProjectStatus from tbl_PM_Project where ProjectStatusID in (select projectstatusID from tbl_cnf_projectStatus where maptoProjectonHold=1) And ProjectID =" & HttpContext.Current.Session("intProjectID").ToString
                                            strProjectStatus = "usp_Sel_tbl_CNF_Project_Status " & HttpContext.Current.Session("intProjectID").ToString
                                            'drPrjStatus = CommonFunction.Data.GetDataReader(strProjectStatus, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                            'If drPrjStatus.Read Then
                                            '    strProjectStatus = CType(CommonFunction.Data.CheckIsDBNull(drPrjStatus("ProjectStatus"), ""), String)
                                            'Else
                                            '    strProjectStatus = ""
                                            'End If
                                            strProjectStatus = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strProjectStatus, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString()


                                            If strProjectStatus = "1" Then
                                                strFunction = "alert('Project is On Hold. Cannot Reject.');" & vbCrLf
                                                strFunction &= "return;" & vbCrLf
                                            Else
                                                'Modified By JyotiG (Date : 31-Aug-2006)
                                                'Start
                                                'strFunction &= "window.open('CommonPage.aspx?FromWhere=PM&MasterTagId=2220&FormAction=R','_blank','resizable=yes,scrollbars=no,left=' + (window.screen.width - 450)/2 + ',top=' + (window.screen.height - 250)/2 + ',width=450,height=250');" & vbCrLf
                                                ''Commented and added by NitinC on 24 April 2012 for WhizibleSEM 11.0 [Issue Fix ; For Old workflow on project information page whn click on action links e.g. send for approval,show 
                                                ''revisions,show project approvers etc page is crashed.]
                                                'strFunction &= "window.open('CommonPage.aspx?FromWhere=PM&MasterTagId=2220&FormAction=R','_blank','resizable=yes,scrollbars=no,left=' + (window.screen.width - 500)/2 + ',top=' + (window.screen.height - 400)/2 + ',width=700,height=400');" & vbCrLf
                                                strFunction &= "window.open('../General/CommonPage.aspx?FromWhere=PM&MasterTagId=2220&FormAction=R','_blank','resizable=yes,scrollbars=no,left=' + (window.screen.width - 500)/2 + ',top=' + (window.screen.height - 400)/2 + ',width=700,height=400');" & vbCrLf
                                                ''End of Commented and added by NitinC on 24 April 2012 for WhizibleSEM 11.0 [Issue Fix ; For Old workflow on project information page whn click on action links e.g. send for approval,show 
                                                ''revisions,show project approvers etc page is crashed.]
                                                'End
                                                strFunction &= "return;" & vbCrLf
                                            End If
                                            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM SP 8 Regression IssueID 13163
                                            'Added By JyotiG
                                            'Start
                                            'Date : 18-Sep-2006
                                        Else
                                            strFunction = "alert('" + strMSG.Trim + "');" & vbCrLf
                                            strFunction &= "return;" & vbCrLf
                                        End If
                                        'End
                                        Args.ToBeInsertedInFunction = strFunction
                                    End If
                                Case "Revision_OnClick".ToUpper()
                                    If Cancel = False Then
                                        Dim strFunction As String
                                        Dim strPagingAlphabet As String = "-1"
                                        If Trim(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PagingAlphabet"), "")) <> "" Then
                                            strPagingAlphabet = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PagingAlphabet"), "-1")
                                        End If
                                        'Modified BY nitinVS on 19 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 13037 
                                        ' Added check of object existance of BG combo 
                                        'MODIFIED BY VIVEKP ON 26 SEP 2005 FOR ISSUEID -111
                                        strFunction &= "var objBusinessGroup=GetObjectReference('frmCommonPage','BusinessGroupID'); " & vbCrLf
                                        strFunction &= " if ( objBusinessGroup == null ) return; " & vbCrLf
                                        strFunction &= "var BusinessGroupID=objBusinessGroup.value;" & vbCrLf
                                        strFunction &= "var objfrm = GetFormReference('frmCommonPage');" & vbCrLf
                                        ''Commented and added by NitinC on 24 April 2012 for WhizibleSEM 11.0 [Issue Fix ; For Old workflow on project information page whn click on action links e.g. send for approval,show 
                                        ''revisions,show project approvers etc page is crashed.]
                                        'strFunction &= "objfrm.action=""CommonPage.aspx?Operation=REVISION&BusinessGroupID=""+BusinessGroupID+""&Mode=&ProjectID=" & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString() & "&MasterTagID=32&FromWhere=PM&PagingAlphabet=" & strPagingAlphabet & "&ParentTagID=0"";" & vbCrLf
                                        strFunction &= "objfrm.action=""../PM/ProjectInformation_CommonPage.aspx?Operation=REVISION&BusinessGroupID=""+BusinessGroupID+""&Mode=&ProjectID=" & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString() & "&MasterTagID=32&FromWhere=PM&PagingAlphabet=" & strPagingAlphabet & "&ParentTagID=0"";" & vbCrLf
                                        ''End of Commented and added by NitinC on 24 April 2012 for WhizibleSEM 11.0 [Issue Fix ; For Old workflow on project information page whn click on action links e.g. send for approval,show 
                                        ''revisions,show project approvers etc page is crashed.]

                                        strFunction &= "objfrm.submit();" & vbCrLf
                                        'END OF MODIFICATION BY VIVEKP
                                        'End Modification BY nitinVS on 19 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 13037 
                                        strFunction &= "return;" & vbCrLf
                                        Args.ToBeInsertedInFunction = strFunction
                                    End If
                                    ' Added by ShraddhaM on 4,July for Whiziblesem8 
                                    ' Purpose : To plot conditional back function 
                                Case "Back_OnClick".ToUpper()
                                    Dim strFunction As String
                                    Dim strFrom As String
                                    strFrom = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("From"), "")

                                    If strFrom Is Nothing OrElse strFrom = "" Then
                                        strFrom = HttpContext.Current.Request.Form("hidFrom")
                                    End If

                                    If strFrom = "TabView" Then
                                        strFunction &= "if(ShowNavigationAlert()==false) return;" & vbCrLf
                                        strFunction &= "window.parent.location.href='CommonList.aspx?Show=0&FromWhere=PM&MasterTagId=32';" & vbCrLf
                                        strFunction &= "return;" & vbCrLf
                                    End If

                                    Args.ToBeInsertedInFunction = strFunction
                                    ' End of addition by ShraddhaM on 4,July for Whiziblesem8 

                            End Select
                            'End of addition - ShamkantD on 24 Sep 2004

                            'Added by ShamkantD on 13 Oct 2004
                            Select Case Args.ClientSideFunctionName.ToUpper()
                                Case "FIXEDBID_CLICK"
                                    If Cancel = False Then
                                        'Get the node label and print it as link
                                        Dim strNodeLabel As String = ""
                                        Dim strQuery As String = "usp_Sel_GetContractType_NodeLabel_ForProject " & HttpContext.Current.Session("intProjectID").ToString
                                        strNodeLabel = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
                                        If strNodeLabel.Trim() <> "" Then
                                            Args.LinkName = strNodeLabel
                                        End If
                                    End If
                                Case "RATECONTRACT_CLICK"
                                    If Cancel = False Then
                                        'Get the node label and print it as link
                                        Dim strNodeLabel As String = ""
                                        Dim strQuery As String = "usp_Sel_GetContractType_NodeLabel_ForProject " & HttpContext.Current.Session("intProjectID").ToString
                                        strNodeLabel = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
                                        If strNodeLabel.Trim() <> "" Then
                                            Args.LinkName = strNodeLabel
                                        End If
                                    End If
                            End Select

                            'End of addition - ShamkantD on 13 Oct 2004

                            ' Added By Nitinvs on 3 Dec 2008 for Moving Graphs and Related data to new page 
                            If Args.ClientSideFunctionName.ToLower = "viewgraphs" Then

                                Dim m_strToken As New System.Text.StringBuilder
                                m_strToken.Append("../General/CommonPage.aspx?ProjectID_PK=")
                                m_strToken.Append(HttpContext.Current.Session("intProjectID").ToString)
                                m_strToken.Append("&PKToken=")
                                m_strToken.Append(CommonFunctions.Security.Token.GetToken(HttpContext.Current.Session("intProjectID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(3969, String)))
                                m_strToken.Append("&MasterTagID=3969&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1")
                                m_strToken.Append(""", ""ProjectGraphs"", ""resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 800)/2 + "",top="" + (window.screen.height - 600)/2 + "",width=800,height=600")

                                Args.CustomLink = m_strToken.ToString() ' "../General/CommonPage.aspx?ProjectID_PK=" + HttpContext.Current.Session("intProjectID").ToString + "&PKToken=" + m_strToken + "&MasterTagID=3969&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1"
                                m_strToken = Nothing
                            End If

                            'End Addition By nitinvs on 3 Dec 2008
                            'added by SachinR   on 07 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_CUSTOMER_ADDRESSES
                            'here client side script is added to assign the selected address to the combo
                            'on parent page
                            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                                If HttpContext.Current.Request.QueryString("ReadOnly") = "1" Then
                                    Cancel = True
                                Else
                                    Dim strFunction As String
                                    strFunction = "var objAdrs=GetObjectReference('frmCommonPage','AddressCode');" + vbCrLf
                                    'strFunction &= "opener.frmRFI_RFI.txtCustomerAddressID.value=objAdrs.value;" + vbCrLf
                                    'issue - 12367 
                                    'modified by SachinR    on 17 Aug 2004
                                    strFunction &= "opener.document.forms[0].txtCustomerAddressID.value=objAdrs.value;" + vbCrLf
                                    'modification end
                                    strFunction &= "window.close();" + vbCrLf
                                    strFunction &= "return;" + vbCrLf
                                    Args.ToBeInsertedInFunction = strFunction
                                End If
                                'added by SachinR   on 17 Aug 2004
                            ElseIf Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If
                            'addition end

                            'Added By NileshD on 9 August 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_DISPATCHED_DETAILS, CommonFunction.Constants.APP_TAG_RFI_CHANGE_STATUS
                            Dim strFunction As String
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE" Then
                                strFunction = "window.close(); return;"
                                Args.ToBeInsertedInFunction = strFunction
                            End If
                            'End Of Addition

                            '##### Tag Cases For Resource Timesheet Flow Added on 10 AUG 2004
                            'Cases Added by AmitD 10 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_RES_TMSHEET_TASK_DETAILS
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "CONFIGURE", "FILTERS"
                                    Cancel = True
                            End Select

                            Select Case Args.LinkName.ToUpper
                                Case "CLOSE"
                                    Args.ToBeInsertedInFunction = "window.close();" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;"
                            End Select
                            'Case Added By AmitD on 10 Aug 2004
                        Case CommonFunction.Constants.APP_Tag_ROWWISE_APPROVERS_HISTORY
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "FILTERS", "CONFIGURE"
                                    Cancel = True

                            End Select

                            Select Case Args.LinkName.ToUpper
                                Case "CLOSE"
                                    Args.ToBeInsertedInFunction = "window.close();" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;"
                            End Select
                            'Case Added By AmitD on 10 AUG 2004

                        Case CommonFunction.Constants.APP_Tag_TIMESHEET_SHOW_REMARKS
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "FILTERS", "CONFIGURE"
                                    Cancel = True
                            End Select

                            Select Case Args.LinkName.ToUpper
                                Case "CLOSE"
                                    Args.ToBeInsertedInFunction = "window.close();" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;"
                            End Select
                            'End Addition

                            'Added by Amitd For RTS history for Employee
                        Case CommonFunction.Constants.APP_TAG_RTS_SHOW_HISTORY_EMPLOYEE
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "FILTERS", "CONFIGURE"
                                    Cancel = True
                            End Select

                            Select Case Args.LinkName.ToUpper
                                Case "CLOSE"
                                    Args.ToBeInsertedInFunction = "window.close();" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;"
                            End Select

                        Case CommonFunction.Constants.APP_TAG_RTS_SHOW_HISTORY_APPROVERS
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "FILTERS", "CONFIGURE"
                                    Cancel = True
                            End Select

                            Select Case Args.LinkName.ToUpper
                                Case "CLOSE"
                                    Args.ToBeInsertedInFunction = "window.close();" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;"
                            End Select
                            'End Addition


                            'Added For Work Order Facilities On 17 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_WORKORDER_FACILITIES
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE_ADD", "FILTERS", "SHOW_HISTORY"
                                    Cancel = True
                            End Select

                            Select Case Args.LinkName.ToUpper
                                Case "CLOSE"
                                    Args.ToBeInsertedInFunction = "window.close();" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;"
                                Case "SAVE"
                                    Args.ToBeInsertedInFunction = " objForm = GetFormReference('frmCommonList');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "        objForm.action='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_WORKORDER_FACILITIES, String) + " &Save=True';" + vbCrLf
                                    Args.ToBeInsertedInFunction += "        objForm.submit();" + vbCrLf
                                    Args.ToBeInsertedInFunction += "        return;" + vbCrLf


                            End Select


                            'End Addition

                            'Added For Question Selection List On 20 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_QUESTION_SELECTION_LIST
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE_ADD", "FILTERS", "SHOW_HISTORY"
                                    Cancel = True
                            End Select

                            Select Case Args.LinkName.ToUpper
                                Case "CLOSE"
                                    'Args.ToBeInsertedInFunction += " refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FocusOn=SUBTAG',true); " + vbCrLf
                                    Args.ToBeInsertedInFunction = "window.close();" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;"
                                Case "SAVE"
                                    Args.ToBeInsertedInFunction = " objForm = GetFormReference('frmCommonList');" + vbCrLf
                                    Args.ToBeInsertedInFunction += " objQuestionireID = GetObjectReference('frmCommonList','txtQuestionireID');" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "        objForm.action='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_QUESTION_SELECTION_LIST, String) + "&Save=True&QuestionireID=" + CType(HttpContext.Current.Request.QueryString("QuestionireID"), String) + "';" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "        objForm.action='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_QUESTION_SELECTION_LIST, String) + "&Save=True&QuestionireID=" + CType(HttpContext.Current.Request.Form("txtQuestionireID"), String) + "';" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "  if(isIE() == 'IE'){"
                                    Args.ToBeInsertedInFunction += "        objForm.action='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_QUESTION_SELECTION_LIST, String) + "&Save=True&QuestionireID='+objQuestionireID.value;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "        objForm.submit();" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "}"
                                    'Args.ToBeInsertedInFunction += "else{"
                                    'Args.ToBeInsertedInFunction += "document.getElementById('frmCommonList').action = '../General/CommonList.aspx?FromWhere=PM&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_QUESTION_SELECTION_LIST, String) + "&Save=True&QuestionireID='+objQuestionireID.value;document.getElementById('frmCommonList').submit();" + vbCrLf
                                    ''Args.ToBeInsertedInFunction += "window.opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_QUESTION_SELECTION_LIST, String) + "&Save=True&QuestionireID='+objQuestionireID.value;" + vbCrLf
                                    'Args.ToBeInsertedInFunction += "}"
                                    Args.ToBeInsertedInFunction += "  if(isIE() == 'IE'){" 'Added By Vaijat K ON 12/12/2015 Issue ID-2498
                                    Args.ToBeInsertedInFunction += "       window.close();" + vbCrLf
                                    Args.ToBeInsertedInFunction += " refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FocusOn=SUBTAG',true); " + vbCrLf
                                    Args.ToBeInsertedInFunction += "}"
                                    'Args.ToBeInsertedInFunction += "setTimeout(function(){ alert('Hello'); }, 3000);"
                                    'Args.ToBeInsertedInFunction += "document.body.onunload = function() { refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FocusOn=SUBTAG',true); }"
                                    '' START : Modified By ParagD on 12-Sept-2006
                                    '' Purpose : When record saved ,refresh parent page.
                                    '' Args.ToBeInsertedInFunction += "      opener.location.href='CommonPage.aspx?QuestionnaireID_PK=' + objQuestionireID.value + '&MasterTagID=2160&FromWhere=PRO&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1'" + vbCrLf

                                    '' END : Modified By ParagD on 12-Sept-2006

                                    ''Added by Usha Pandit on 10.06.2019 for parent refresh issue
                                    Args.ToBeInsertedInFunction += "else{" ''Commented and Added By Nikhil A for Solving You are not authorized issue on Checklist
                                    Args.ToBeInsertedInFunction += " window.onunload = refreshMyParent; "
                                    Args.ToBeInsertedInFunction += " function refreshMyParent() {     window.opener.document.forms['frmCommonPage'].action='../General/CommonPage.aspx?SubTagId=" + CType(CommonFunction.Constants.APP_TAG_TAB_CHECKLIST_ITEMS, String) + "&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_QUESTION_CHECKLIST, String) + "&QuestionireID='+objQuestionireID.value;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "       window.opener.document.forms['frmCommonPage'].submit(); window.close();  " + vbCrLf
                                    Args.ToBeInsertedInFunction += "    }" + vbCrLf
                                    Args.ToBeInsertedInFunction += "}"
                                    ''End of Added by Usha Pandit on 10.06.2019 for parent refresh issue

                                    Args.ToBeInsertedInFunction += "        return;" + vbCrLf



                            End Select
                            'End Addition
                            'Args.ToBeInserted += "<script src='../../responsive/jquery/jquery-2.1.3.min
                            '></script>" & _
                            '                     "<script type='text/javascript'></script>" & _
                            '                     "$('#SaveQuestion_OnClickLIST_HEAD0-2168').click(function(){" & _
                            '                     "refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FocusOn=SUBTAG',true);}).delay(3000);"

                        Case CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET
                            'Remove the links Verify if no records are present to show
                            Select Case Args.ClientSideFunctionName.ToUpper
                                Case "VERIFY_ONCLICK"
                                    Dim strSQLQuery As String = "SELECT * FROM v_tbl_PM_ResourceTimesheetForVerification WHERE ApproverID = " + HttpContext.Current.Session("intUserID").ToString
                                    Dim drTimesheet As IDataReader = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    If Not drTimesheet.Read Then
                                        Cancel = True
                                    Else
                                        Cancel = False
                                    End If
                                    CommonFunction.Data.DisposeDataReader(drTimesheet)
                            End Select
                            'Remove the links Save, Add and Delete
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE"
                                    Cancel = True
                            End Select

                            If Args.ClientSideFunctionName.ToUpper = "VERIFY_ONCLICK" Then
                                Dim strFunction As String

                                With Args
                                    .ToBeInsertedInFunction += " var objVerify;" + vbCrLf
                                    .ToBeInsertedInFunction += " var intctr;" + vbCrLf
                                    .ToBeInsertedInFunction += " var objForm;" + vbCrLf
                                    .ToBeInsertedInFunction += " var strVal; " + vbCrLf
                                    .ToBeInsertedInFunction += " var bSubmit; " + vbCrLf
                                    .ToBeInsertedInFunction += " bSubmit = false; " + vbCrLf

                                    .ToBeInsertedInFunction += " objForm = GetFormReference('frmCommonList');" + vbCrLf
                                    .ToBeInsertedInFunction += " objVerify = GetObjectReference('frmCommonList','chkDelete',true); " + vbCrLf

                                    .ToBeInsertedInFunction += "    if(objVerify!=null) " + vbCrLf
                                    .ToBeInsertedInFunction += "    { " + vbCrLf

                                    .ToBeInsertedInFunction += "    if(objVerify.length == 0)" + vbCrLf
                                    .ToBeInsertedInFunction += "        return;" + vbCrLf

                                    .ToBeInsertedInFunction += "        if(objVerify.length > 1)" + vbCrLf
                                    .ToBeInsertedInFunction += "        { " + vbCrLf
                                    .ToBeInsertedInFunction += "            for(i=0;i<=objVerify.length-1;i++)" + vbCrLf
                                    .ToBeInsertedInFunction += "            { " + vbCrLf
                                    .ToBeInsertedInFunction += "                if (objVerify[i].checked == true) " + vbCrLf
                                    .ToBeInsertedInFunction += "                { " + vbCrLf
                                    .ToBeInsertedInFunction += "                    bSubmit = true; " + vbCrLf
                                    .ToBeInsertedInFunction += "                    break; " + vbCrLf
                                    .ToBeInsertedInFunction += "                } " + vbCrLf
                                    .ToBeInsertedInFunction += "            } " + vbCrLf
                                    .ToBeInsertedInFunction += "        } " + vbCrLf
                                    .ToBeInsertedInFunction += "        else " + vbCrLf
                                    .ToBeInsertedInFunction += "        { " + vbCrLf
                                    .ToBeInsertedInFunction += "            if (frmCommonList.chkDelete.checked == true) " + vbCrLf
                                    .ToBeInsertedInFunction += "                bSubmit = true; " + vbCrLf
                                    .ToBeInsertedInFunction += "        } " + vbCrLf

                                    .ToBeInsertedInFunction += " if (bSubmit==true) " + vbCrLf
                                    .ToBeInsertedInFunction += " { " + vbCrLf
                                    .ToBeInsertedInFunction += "    var bConfirmed; " + vbCrLf
                                    .ToBeInsertedInFunction += "    bConfirmed = window.confirm('Do you want to approve the selected timesheets?');" + vbCrLf
                                    .ToBeInsertedInFunction += "    if (bConfirmed == false) " + vbCrLf
                                    .ToBeInsertedInFunction += "        return;" + vbCrLf
                                    .ToBeInsertedInFunction += "    else " + vbCrLf
                                    .ToBeInsertedInFunction += "    {" + vbCrLf
                                    .ToBeInsertedInFunction += "        objForm.action='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET, String) + " &Verify=True';" + vbCrLf
                                    .ToBeInsertedInFunction += "        objForm.submit();" + vbCrLf
                                    '.ToBeInsertedInFunction += "        return;" + vbCrLf
                                    .ToBeInsertedInFunction += "    } " + vbCrLf
                                    .ToBeInsertedInFunction += "} " + vbCrLf
                                    .ToBeInsertedInFunction += " else " + vbCrLf
                                    .ToBeInsertedInFunction += " { " + vbCrLf
                                    .ToBeInsertedInFunction += "    alert('Please select the timesheet to approve.')  " + vbCrLf
                                    .ToBeInsertedInFunction += "    return; " + vbCrLf
                                    .ToBeInsertedInFunction += " } " + vbCrLf

                                    .ToBeInsertedInFunction += " } " + vbCrLf  'objverify!=null 
                                    .ToBeInsertedInFunction += " return; " + vbCrLf
                                End With

                            End If

                            '##### End of Tag Cases For Resource Timesheet 
                            ' Added By PrachiK on 28 Mar 2005 
                            ' To Remove Link for CheckList name column
                        Case CommonFunction.Constants.APP_TAG_SELECT_CHECKLIST_FOR_PROJECT
                            If Args.ClientSideFunctionName.ToUpper = "CLOSEONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If
                            'Addtion ended
                            'Added by ShamkantD on 10th August 2004
                        Case CommonFunction.Constants.APP_TAG_PM_SERVICE_SEGMENTATION, CommonFunction.Constants.APP_TAG_PM_MARKET_SEGMENTATION
                            'Remove the links Add and Delete
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "CLEAR_ALL", "SAVE_ADD", "FILTERS", "SHOW_HISTORY"
                                    Cancel = True
                            End Select

                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If

                            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                                Dim strScript As String
                                'Modified by NiranjanK on Date June 08,2006 for WhizibleSEM Issue ID.4168
                                'Added by ShamkantD on 10th August 2004
                                strScript = "  var objForm = GetFormReference('frmCommonList');" & vbCrLf
                                strScript += "	var intCount;" & vbCrLf
                                strScript += "	var intDomainCount;" & vbCrLf
                                strScript += "	var arrValue;" & vbCrLf
                                strScript += "	var blnDomainFound;" & vbCrLf
                                strScript += "	var blnMarketFound;" & vbCrLf
                                strScript += "	var strMarket; " & vbCrLf
                                strScript += "	var strDomain;" & vbCrLf
                                strScript += "	var strSubMarket;" & vbCrLf
                                strScript += "	var strUpdateStr;" & vbCrLf
                                strScript += "	var strTempDomain;" & vbCrLf
                                strScript += "	var strTempMarket;" & vbCrLf
                                strScript += "	var strTempSubMarket;" & vbCrLf
                                strScript += "	var arrTempValue;" & vbCrLf
                                strScript += "	var I;" & vbCrLf
                                strScript += "	var J;" & vbCrLf
                                strScript += "	var K;" & vbCrLf
                                strScript += "	var blnPageOKToSubmit;" & vbCrLf
                                strScript += "	var objchkSubMarket;" & vbCrLf
                                strScript += "	blnDomainFound=false;" & vbCrLf
                                strScript += "	blnMarketFound=false;" & vbCrLf
                                strScript += "	strUpdateStr="""";" & vbCrLf
                                strScript += "	blnPageOKToSubmit=0;" & vbCrLf
                                strScript += "	for(intCount=0;intCount<=objForm.elements.length - 1;intCount++)" & vbCrLf
                                strScript += "	{" & vbCrLf
                                strScript += "		if(blnDomainFound==false)" & vbCrLf
                                strScript += "		{" & vbCrLf
                                strScript += "			if(objForm.elements[intCount].type==""checkbox"" && objForm.elements[intCount].name==""chkMarket"" && objForm.elements[intCount].checked==true)" & vbCrLf
                                strScript += "			{" & vbCrLf
                                strScript += "				arrValue=objForm.elements[intCount].value.split("":"");" & vbCrLf
                                strScript += "				for(intDomainCount=0;intDomainCount<=objForm.elements.length - 1;intDomainCount++)" & vbCrLf
                                strScript += "				{" & vbCrLf
                                strScript += "					if(objForm.elements[intDomainCount].value==arrValue[0] && objForm.elements[intDomainCount].type==""checkbox"")" & vbCrLf
                                strScript += "					{	" & vbCrLf
                                strScript += "						if(objForm.elements[intDomainCount].checked==false)" & vbCrLf
                                strScript += "						{" & vbCrLf
                                strScript += "							alert(""Select Service corrosponding to the Service Offering."");" & vbCrLf
                                strScript += "							blnDomainFound=true;" & vbCrLf
                                strScript += "							break;" & vbCrLf
                                strScript += "						}" & vbCrLf
                                strScript += "					}" & vbCrLf
                                strScript += "				}" & vbCrLf
                                strScript += "			}" & vbCrLf
                                strScript += "		}" & vbCrLf
                                strScript += "	}" & vbCrLf
                                strScript += "	for(intCount=0;intCount<=objForm.elements.length - 1;intCount++)" & vbCrLf
                                strScript += "	{" & vbCrLf
                                strScript += "		if(blnMarketFound==false)" & vbCrLf
                                strScript += "		{" & vbCrLf
                                strScript += "			if(objForm.elements[intCount].type==""checkbox"" && objForm.elements[intCount].name==""chkSubMarket"" && objForm.elements[intCount].checked==true)" & vbCrLf
                                strScript += "			{" & vbCrLf
                                strScript += "				arrValue=objForm.elements[intCount].value.split("":"");" & vbCrLf
                                strScript += "				strMarket=arrValue[0]+"":""+arrValue[1];" & vbCrLf
                                strScript += "				for(intDomainCount=0;intDomainCount<=objForm.elements.length - 1;intDomainCount++)" & vbCrLf
                                strScript += "				{" & vbCrLf
                                strScript += "					if(objForm.elements[intDomainCount].value==strMarket && objForm.elements[intDomainCount].type==""checkbox"")" & vbCrLf
                                strScript += "					{	" & vbCrLf
                                strScript += "						if(objForm.elements[intDomainCount].checked==false)" & vbCrLf
                                strScript += "						{" & vbCrLf
                                strScript += "							alert(""Select Service Offering corrosponding to the Sub Service Offering."");" & vbCrLf
                                strScript += "							blnMarketFound=true;" & vbCrLf
                                strScript += "							break;" & vbCrLf
                                strScript += "						}" & vbCrLf
                                strScript += "					}" & vbCrLf
                                strScript += "				}" & vbCrLf
                                strScript += "			}" & vbCrLf
                                strScript += "		}" & vbCrLf
                                strScript += "	}" & vbCrLf
                                strScript += "	strMarket="""";" & vbCrLf
                                strScript += "	strUpdateStr="""";" & vbCrLf
                                strScript += "	if((blnDomainFound==false) && (blnMarketFound==false))" & vbCrLf
                                strScript += "	{" & vbCrLf
                                'Added by Dipali
                                '************
                                'UnCommented By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007 (Checked ObjSubMarket is not null)
                                strScript += "var obj=GetObjectReference(""frmCommonList"",""chkDomain"",true);" & vbCrLf
                                'Commented By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007 (Checked ObjSubMarket is not null)
                                'strScript += "var obj= document.forms['frmCommonList'].elements['chkDomain'];" + vbCrLf
                                'Ended By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007 (Checked ObjSubMarket is not null)

                                'Added By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007 (Checked ObjSubMarket is not null)
                                strScript += "if(obj != null) { "
                                'End of Addition By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007 (Checked ObjSubMarket is not null)

                                strScript += "var len=obj.length;" + vbCrLf
                                'End Addition
                                'Commented by DipaliS 18 Oct and Added the Following line
                                'strScript += "		for(I=0;I<=frmCommonList.chkDomain.length - 1;I++)" & vbCrLf
                                strScript += "		for(I=0;I<=len - 1;I++)" & vbCrLf
                                strScript += "		{" & vbCrLf
                                strScript += "			if(I != 0)" & vbCrLf
                                strScript += "				strUpdateStr=strUpdateStr+"","";" & vbCrLf
                                'Code Commented by DipaliS and added following
                                'strScript += "			strDomain = frmCommonList.chkDomain(I).value;" & vbCrLf
                                strScript += "			strDomain = obj[I].value;" & vbCrLf
                                strScript += "			strTempDomain = strDomain;" & vbCrLf
                                'Code Commented by DipaliS and added following
                                'strScript += "			if(frmCommonList.chkDomain(I).checked==true)" & vbCrLf
                                strScript += "			if(obj[I].checked==true)" & vbCrLf
                                strScript += "			{" & vbCrLf
                                strScript += "				strDomain= strDomain+"":""+""1"";" & vbCrLf
                                strScript += "				strUpdateStr= strUpdateStr+strTempDomain+"":""+""1"";" & vbCrLf
                                strScript += "			}" & vbCrLf
                                strScript += "			else" & vbCrLf
                                strScript += "			{" & vbCrLf
                                strScript += "				strUpdateStr= strUpdateStr+strTempDomain+"":""+""0"";" & vbCrLf
                                strScript += "				strDomain= strDomain+"":""+""0"";" & vbCrLf
                                strScript += "			}" & vbCrLf

                                'Code Added by DipaliS 18 Oct 2004
                                'Purpose    :   For IssueID 13439
                                '*************
                                'strScript += "			if(frmCommonList.chkMarket!=null)" & vbCrLf
                                strScript += "			if(objForm.chkMarket!=null)" & vbCrLf
                                strScript += "			{" & vbCrLf
                                'UnCommented By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007 (Checked ObjSubMarket is not null)

                                strScript += "			var objMarket=GetObjectReference(""frmCommonList"",""chkMarket"",true);" & vbCrLf
                                'Commented By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007 (Checked ObjSubMarket is not null)

                                '''strScript += "			var objMarket= document.forms['frmCommonList'].elements['chkMarket'];" & vbCrLf
                                'Added By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007 (Checked ObjSubMarket is not null)
                                strScript += "if(objMarket != null) { "
                                'End of Addition By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007 (Checked ObjSubMarket is not null)

                                strScript += "			var MarketLength=objMarket.length;" & vbCrLf
                                'End Addition by DipaliS
                                ' Code Commented by DipaliS and added following
                                'strScript += "			if(frmCommonList.chkMarket.length > 0)" & vbCrLf
                                strScript += "			if(MarketLength > 0)" & vbCrLf
                                strScript += "			{" & vbCrLf
                                ' Code Commented by DipaliS and added following
                                'strScript += "				for(J = 0;J<=frmCommonList.chkMarket.length - 1;J++)" & vbCrLf
                                strScript += "				for(J = 0;J<=MarketLength - 1;J++)" & vbCrLf
                                strScript += "				{" & vbCrLf
                                ' Code Commented by DipaliS and added following
                                'strScript += "					strMarket = frmCommonList.chkMarket(J).value;" & vbCrLf
                                strScript += "					strMarket = objMarket[J].value;" & vbCrLf
                                strScript += "					strTempMarket=strMarket;" & vbCrLf
                                strScript += "					arrValue=strMarket.split("":"");" & vbCrLf
                                strScript += "					if(arrValue[0]==strTempDomain)" & vbCrLf
                                strScript += "					{" & vbCrLf
                                strScript += "						if( J != 0)" & vbCrLf
                                strScript += "							strUpdateStr=strUpdateStr+"",""+strDomain;" & vbCrLf
                                ' Code Commented by DipaliS and added following
                                'strScript += "						if(frmCommonList.chkMarket(J).checked==true)" & vbCrLf
                                strScript += "						if(objMarket[J].checked==true)" & vbCrLf
                                strScript += "						{" & vbCrLf
                                strScript += "							strMarket=strMarket+"":""+""1"";" & vbCrLf
                                strScript += "							strUpdateStr=strUpdateStr+""~""+strTempDomain+"":""+arrValue[1]+"":""+""1"";" & vbCrLf
                                strScript += "						}" & vbCrLf
                                strScript += "						else" & vbCrLf
                                strScript += "						{" & vbCrLf
                                strScript += "							strMarket=strMarket+"":""+""0"";" & vbCrLf
                                strScript += "							strUpdateStr= strUpdateStr+""~""+strTempDomain+"":""+arrValue[1]+"":""+""0"";" & vbCrLf
                                strScript += "						}" & vbCrLf
                                ''Modified by NiranjanK on Date June 08,2006 for WhizibleSEM Issue ID.4168
                                'strScript += "						objchkSubMarket=frmCommonList.all(""chkSubMarket"");" & vbCrLf
                                'Commented By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007 (Checked ObjSubMarket is not null)
                                'strScript += "						objchkSubMarket= document.forms['frmCommonList'].elements['chkSubMarket'];" & vbCrLf
                                'UnCommented By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007 (Checked ObjSubMarket is not null)
                                strScript += "						objchkSubMarket=GetObjectReference(""frmCommonList"",""chkSubMarket"",true);" & vbCrLf

                                'Code Added by DipaliS
                                ''Modified by NiranjanK on Date June 08,2006 for WhizibleSEM Issue ID.4168
                                strScript += "						var objSubMarket=GetObjectReference(""frmCommonList"",""chkSubMarket"",true);" & vbCrLf
                                'strScript += "						var objSubMarket= document.forms['frmCommonList'].elements['chkSubMarket'];" & vbCrLf
                                'Added By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007 (Checked ObjSubMarket is not null)
                                strScript += "if(objSubMarket != null) { "

                                'End of Addition By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007 (Checked ObjSubMarket is not null)
                                strScript += "						var SubMarketLength=objSubMarket.length;" & vbCrLf


                                'end Addition by DipaliS
                                strScript += "						if (typeof(objchkSubMarket)=='object')" & vbCrLf
                                strScript += "						{" & vbCrLf
                                ' Code Commented by DipaliS and added following

                                'strScript += "							if(frmCommonList.chkSubMarket.length > 0)" & vbCrLf
                                strScript += "							if(SubMarketLength > 0)" & vbCrLf
                                strScript += "							{" & vbCrLf
                                ' Code Commented by DipaliS and added following
                                'strScript += "								for(K=0;K<=frmCommonList.chkSubMarket.length -1;K++)" & vbCrLf
                                strScript += "								for(K=0;K<=SubMarketLength -1;K++)" & vbCrLf
                                strScript += "								{" & vbCrLf
                                ' Code Commented by DipaliS and added following
                                'strScript += "									strSubMarket=frmCommonList.chkSubMarket(K).value;" & vbCrLf
                                strScript += "									strSubMarket=objSubMarket[K].value;" & vbCrLf
                                'strScript += "									strSubMarket=objSubMarket.value;" & vbCrLf
                                strScript += "									arrTempValue=strSubMarket.split("":"");" & vbCrLf
                                strScript += "									strTempSubMarket=arrTempValue[0]+"":""+arrTempValue[1];" & vbCrLf
                                strScript += "									if(strTempSubMarket==strTempMarket)" & vbCrLf
                                strScript += "									{" & vbCrLf
                                strScript += "										if(K != 0)" & vbCrLf
                                strScript += "											strUpdateStr=strUpdateStr+"",""+strDomain+""~""+strMarket;" & vbCrLf
                                ' Code Commented by DipaliS and added following

                                'strScript += "										if(frmCommonList.chkSubMarket(K).checked==true)" & vbCrLf
                                strScript += "										if(objSubMarket[K].checked==true){" & vbCrLf
                                'strScript += "										if(objSubMarket.checked==true){" & vbCrLf


                                strScript += "											strUpdateStr=strUpdateStr+""~""+strTempDomain+"":""+arrValue[1]+"":""+arrTempValue[2]+"":""+""1""; }" & vbCrLf
                                strScript += "										else" & vbCrLf
                                strScript += "											strUpdateStr=strUpdateStr+""~""+strTempDomain+"":""+arrValue[1]+"":""+arrTempValue[2]+"":""+""0"";" & vbCrLf
                                strScript += "									}" & vbCrLf
                                strScript += "								}" & vbCrLf
                                strScript += "							}" & vbCrLf
                                strScript += "						}" & vbCrLf
                                'Added By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007 (Checked ObjSubMarket is not null)
                                strScript += "						}" & vbCrLf
                                'End of Addition By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007
                                strScript += "					}" & vbCrLf
                                strScript += "				}" & vbCrLf
                                strScript += "			}" & vbCrLf

                                'Added By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007 (Checked ObjSubMarket is not null)
                                strScript += "						}" & vbCrLf
                                'End of Addition By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007

                                'Added by DipaliS 18 Oct 2004
                                'Purpose    :   IssueID 13439
                                strScript += "			}" & vbCrLf
                                'End addition by DipaliS
                                strScript += "		}" & vbCrLf
                                'Added By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007 (Checked ObjSubMarket is not null)
                                strScript += "						}" & vbCrLf
                                'End of Addition By ShraddhaM for PTC Issue Id : 6128 on 27,Mar 2007

                                strScript += "		if(strUpdateStr != '')" & vbCrLf
                                strScript += "		{" & vbCrLf
                                'strScript += "			frmCommonList.txtHidden.value=strUpdateStr;" & vbCrLf
                                strScript += "			GetObjectReference('frmCommonList','txtHidden').value=strUpdateStr;" & vbCrLf
                                strScript += "			blnPageOKToSubmit=1;" & vbCrLf
                                strScript += "		}" & vbCrLf
                                strScript += "	}" & vbCrLf
                                strScript += "	if(blnPageOKToSubmit==0)" & vbCrLf
                                strScript += "	    return;" & vbCrLf
                                Args.ToBeInsertedInFunction += strScript
                            End If
                            'End of modification by NiranjanK June 08,2006 for WhzibleSEM Issue ID.4168
                            'End of addition - ShamkantD on 10th August 2004
                        Case CommonFunction.Constants.APP_TAG_CONTRACT_VIEW
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE_ADD", "FILTERS", "SHOW_HISTORY", "SAVE"
                                    Cancel = True

                            End Select
                            If Args.ClientSideFunctionName.ToUpper = "BACK_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If

                            'added by SachinR   On 17 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_ISSUE_CODEGENERATION, CommonFunction.Constants.APP_TAG_DELIVERABLE_DISCUSSION_THREAD
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Dim strFunction As String
                                strFunction = "window.close();return;"
                                Args.ToBeInsertedInFunction = strFunction
                            End If
                            'addition end

                            'added by SachinR   On 18 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                            ''Added by Dhanashri S on 23 Dec 2015
                            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then

                                Args.ToBeInsertedInFunction += "var objtxtFromDate =GetObjectReference('frmCommonPage','StartDate');" & vbCrLf
                                Args.ToBeInsertedInFunction += "var objtxtToDate =GetObjectReference('frmCommonPage','EarliestStartDate');" & vbCrLf

                                Args.ToBeInsertedInFunction += "if (objtxtToDate.value!=null) {" & vbCrLf
                                'Args.ToBeInsertedInFunction += "if (objtxtFromDate.value=='') {" & vbCrLf
                                ' Args.ToBeInsertedInFunction += "alert('Please enter Start Date'); return; } " & vbCrLf
                                Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2( objtxtFromDate,objtxtToDate ))  {" & vbCrLf
                                Args.ToBeInsertedInFunction += "alert('Start Date should not be greater than End Date.');" & vbCrLf
                                Args.ToBeInsertedInFunction += "return; } }"
                            End If

                            ''End of Addition by Dhanashri S on 23 Dec 2015
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            ElseIf Args.ClientSideFunctionName.ToUpper = "NEW_ONCLICK" Then
                                Dim strClientScript As String
                                Dim strMsg As String
                                'Initialize the Resources
                                objTemplate = New WebPages.Template.WhizTemplate
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                strMsg = objTemplate.GetResourceString("DELIVERABLE_NOT_SELECTED") + ""
                                objTemplate = Nothing

                                strClientScript = " var objCbo=GetObjectReference('frmCommonList','DeliverableTypeID');" + vbCrLf
                                strClientScript += " if(objCbo.value=='' || objCbo.value==null)" + vbCrLf
                                strClientScript += " { alert('" + strMsg.Trim + "'); return; }" + vbCrLf
                                Args.ToBeInsertedInFunction = strClientScript

                            End If
                            'addition end
                            'Added By VivekP On 5 May 2005 For Copy Deliverable Functionality WHIZIBLESEM SP3
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If
                            If HttpContext.Current.Request.QueryString("COPYDATA") <> "1" Then
                                If Args.LinkName.ToUpper = "CLOSE" Then
                                    Cancel = True
                                End If
                            End If
                            If HttpContext.Current.Request.QueryString("COPYDATA") = "1" Then
                                Select Case Args.SystemLinkType.ToUpper.Trim
                                    Case "BACK"
                                        Cancel = True
                                    Case "SAVE_ADD"
                                        Cancel = True
                                End Select
                                'Added By VijayD On 3Rd Sept
                                'Purpose:To Hide Back Link If page called from GanttChart
                                If HttpContext.Current.Request.QueryString("FROMGANTTCHART") = "1" Then
                                    If Args.LinkName.ToUpper = "BACK" Then
                                        Cancel = True
                                    End If
                                End If
                                'End addition By VijayD On 3Rd Sept
                                'Added by SavitaS on 06 Oct 06  for SP7 IssueID 6423
                                Select Case Args.LinkName.ToUpper
                                    Case "SAVE"
                                        ''Added By Chakshuta H on 8th-Nov-2016 for Double Save Issue
                                        Args.ToBeInsertedInFunction += "var MenuTags = document.getElementsByTagName('A');" + vbCrLf
                                        Args.ToBeInsertedInFunction += "  for(i = 0; i < MenuTags.length; i++)" + vbCrLf
                                        Args.ToBeInsertedInFunction += "{" + vbCrLf
                                        Args.ToBeInsertedInFunction += " if (MenuTags[i].className == 'Menu')" + vbCrLf
                                        Args.ToBeInsertedInFunction += " {" + vbCrLf
                                        Args.ToBeInsertedInFunction += " MenuTags[i].parentNode.parentNode.style.display= 'none';" + vbCrLf
                                        Args.ToBeInsertedInFunction += " }" + vbCrLf
                                        Args.ToBeInsertedInFunction += " }" + vbCrLf
                                        ''End Of Added By Chakshuta H on 8th-Nov-2016 for Double Save Issue
                                        Args.ToBeInsertedInFunction = " objForm = GetFormReference('frmCommonPage');" + vbCrLf
                                        Args.ToBeInsertedInFunction += "        objForm.action='../General/CommonPage.aspx?Operation=SAVE&Mode=ADD_NEW&FromWhere=PM&PagingAlphabet=-1&ParentTagID=0&COPYDATA=1&UNIQUEID=" + HttpContext.Current.Request.QueryString("UNIQUEID") + "&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE, String) + "';" + vbCrLf
                                        Args.ToBeInsertedInFunction += "        objForm.submit();" + vbCrLf
                                        Args.ToBeInsertedInFunction += "        return;" + vbCrLf
                                End Select

                            End If
                            'End Of addition On 5 May 2005 For Copy Delivearble Functionality

                            'Added by ShamkantD on 27th August 2004
                            If Args.ClientSideFunctionName.ToUpper = "PLANDELIVERABLES" Then
                                Dim strFunction As String = ""
                                Dim strSQL As String = ""
                                Dim strScheduleID As String = ""
                                Dim strScheduleTypeID As String = ""
                                Dim strEarliestStartDate As String = ""
                                Dim strDepartmentID As String = ""
                                Dim strProjectSystemID As String = ""
                                Dim strProjectSiteID As String = ""
                                Dim strPackageID As String = ""
                                Dim strHaveSubTaskTypes As String = "", strApplyEffortDistribution As String = ""
                                Dim drProjectInfo As IDataReader
                                Dim strSQLQuery As String = ""
                                Dim drOtherSchedules As IDataReader
                                Dim intTotalNoOfTasks As Integer = 0
                                Dim intVoidOrOnHold As Integer = 0

                                Dim drStatus As IDataReader
                                Dim blnProjectOnHold As Boolean, strOnHoldMessage As String
                                'Added by Prachi on 21 Feb 2005 For Issue Id 16116
                                Dim intBaselineNumber As Integer = 0, strBaselineMessage As String = ""

                                ' Modified By   : NitinVS on 22 Feb 2005 
                                ' Purpose       : To set the Default value for Template as the Template for the Deliverable 
                                Dim strTemplateID As String
                                ' End Modification BY NitinVS On 22 Feb 2005 

                                drStatus = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_CNF_Project_Status " & HttpContext.Current.Session("intProjectID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drStatus.Read() Then
                                    blnProjectOnHold = CType(CommonFunction.Data.CheckIsDBNull(drStatus("ProjectOnHold"), "False"), Boolean)
                                    strOnHoldMessage = CType(CommonFunction.Data.CheckIsDBNull(drStatus("ProjectOnHoldMsg"), ""), String)

                                    'Added by Prachi on 21 Feb 2005 For Issue Id 15334
                                    intBaselineNumber = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drStatus("BaselineNumber"), "0"), "0"), Integer)
                                    strBaselineMessage = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drStatus("BaseLineMessage"), ""), ""), String)
                                    'End of addition - 
                                End If
                                CommonFunction.Data.DisposeDataReader(drStatus)



                                'Added by ShamkantD on Friday, September 24, 2004
                                'Get the status of 'Project creation workflow required' flag
                                Dim blnIsProjectCreationWorkflowReqd As Boolean = False
                                blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)

                                'End of addition - ShamkantD on Friday, September 24, 2004
                                '--- End Of Addition




                                ' WhizibleE SP2
                                ' Commented By NitinVS on 10 Feb 2005 
                                ' The Link 'Plan Deliverable' is to be shown in all situations

                                'If values of HaveSubTaskTypes, ApplyEffortDistribution are 1, then only 
                                'display Plan Deliverable link
                                'strSQLQuery = "Select HaveSubTaskTypes, ApplyEffortDistribution " & _
                                '    "From tbl_PM_Project Where Projectid = " & _
                                '    HttpContext.Current.Session("intProjectID").ToString

                                'drProjectInfo = CommonFunction.Data.GetDataReader(strsqlquery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                'If drProjectInfo.Read Then
                                '    strHaveSubTaskTypes = CType(CommonFunction.Data.CheckIsDBNull(drProjectInfo("HaveSubTaskTypes"), ""), String)
                                '    strApplyEffortDistribution = CType(CommonFunction.Data.CheckIsDBNull(drProjectInfo("ApplyEffortDistribution"), ""), String)
                                'End If

                                'CommonFunction.Data.DisposeDataReader(drProjectInfo)

                                'If Not (strHaveSubTaskTypes.ToUpper.Trim = "TRUE" And strApplyEffortDistribution.ToUpper.Trim = "TRUE") Then
                                '    Cancel = True
                                'End If

                                ' End Commenting By NitinVS on 10 Feb 2005 
                                ' WhizibleE SP2

                                'Generate code to call Plan Deliverables page
                                If Cancel = False Then
                                    strScheduleID = CommonFunction.General.CheckIsNothing(Args.PrimaryKeyValue, "").ToString.Trim

                                    If strScheduleID.Trim <> "" Then

                                        strSQL = "SELECT * FROM tbl_PM_OtherSchedules " &
                                        " WHERE tbl_PM_OtherSchedules.ScheduleID = " & strScheduleID &
                                            " AND ProjectID = " & HttpContext.Current.Session("intProjectID").ToString

                                        drOtherSchedules = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        If drOtherSchedules.Read Then
                                            strScheduleTypeID = CType(CommonFunction.Data.CheckIsDBNull(drOtherSchedules("ScheduleTypeID"), ""), String)
                                            strEarliestStartDate = CType(CommonFunction.Data.CheckIsDBNull(drOtherSchedules("EarliestStartDate"), ""), String)
                                            strDepartmentID = CType(CommonFunction.Data.CheckIsDBNull(drOtherSchedules("DepartmentID"), ""), String)
                                            strProjectSystemID = CType(CommonFunction.Data.CheckIsDBNull(drOtherSchedules("ProjectSystemID"), ""), String)
                                            strProjectSiteID = CType(CommonFunction.Data.CheckIsDBNull(drOtherSchedules("ProjectSiteID"), ""), String)
                                            strPackageID = CType(CommonFunction.Data.CheckIsDBNull(drOtherSchedules("PackageID"), ""), String)
                                        End If

                                        CommonFunction.Data.DisposeDataReader(drOtherSchedules)

                                        ' Added By NitinVS on 22 Feb 2005 
                                        ' To Get the TemplateID from 'tbl_PM_ProjectSchedules' i.e. deliverable Type 
                                        'Modified By VidyaJ - 26th May 2005
                                        strSQL = " SELECT 	tbl_PM_Project_PhaseTask_Template_Published.ProjectPhaseTaskTemplateID "
                                        strSQL += "  FROM tbl_PM_Project_PhaseTask_Template_Published Join "
                                        strSQL += " tbl_PM_ProjectSchedules ON tbl_PM_Project_PhaseTask_Template_Published.ProjectPhaseTaskTemplateID = tbl_PM_ProjectSchedules.TemplateID "
                                        strSQL += " where tbl_PM_ProjectSchedules.ProjectID  = " + HttpContext.Current.Session("intProjectID").ToString
                                        strSQL += " AND tbl_PM_ProjectSchedules.ScheduleID = " + strScheduleTypeID.Trim

                                        strTemplateID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")

                                        'End Addition by NitinVS on 22 Feb 2005

                                        If strScheduleTypeID.Trim <> "" Then
                                            strSQL = "EXEC usp_Sel_Check_For_ActiveTasks_For_Deliverable " & HttpContext.Current.Session("intProjectID").ToString & ", " & strScheduleID & ", " & strScheduleTypeID
                                            intTotalNoOfTasks = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Integer)

                                            strSQL = ""
                                            strSQL = "EXEC usp_Sel_Check_For_OnHold_Or_OnVoid " & HttpContext.Current.Session("intProjectID").ToString & ", " & strScheduleID & ", " & strScheduleTypeID
                                            intVoidOrOnHold = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Integer)

                                            'Check if the tasks are already created for this schedule
                                            'If the tasks are already selected, display alert and do not
                                            'display the plan deliverables page
                                            If intTotalNoOfTasks > 0 Then
                                                strFunction = "alert(""Planning is already done for this deliverable."");" & vbCrLf
                                                strFunction &= "return;" + vbCrLf
                                                Args.ToBeInsertedInFunction = strFunction
                                            ElseIf intVoidOrOnHold = 1 Then
                                                strFunction = "alert(""Planning is not allowed when deliverable is Void or OnHold."");" & vbCrLf
                                                strFunction &= "return;" + vbCrLf
                                                Args.ToBeInsertedInFunction = strFunction
                                            Else
                                                'Also add parameters of Deliverable Details page so that when Plan Deliverables 
                                                'finishes, it is used while refreshing the Deliverable Details page
                                                ' Modified  By  : NitinVS on 22 Feb 2005
                                                ' Purpose       : To set the Default value for Template 
                                                '                 Added Query String Parameter TemplateID 

                                                With HttpContext.Current.Request
                                                    strFunction &= "window.open(""../PM/PM_PlanDeliverable.aspx?" &
                                                        "Mode=EDIT" &
                                                        "&MasterTagID=" & CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE &
                                                        "&ScheduleID=" & strScheduleID &
                                                        "&ScheduleTypeID=" & strScheduleTypeID &
                                                        "&DeliverableID=" & strScheduleID &
                                                        "&DeliverableTypeID=" & strScheduleTypeID &
                                                        "&EarliestStartDate=" & strEarliestStartDate &
                                                        "&DepartmentID=" & strDepartmentID &
                                                        "&ProjectSystemID=" & strProjectSystemID &
                                                        "&ProjectSiteID=" & strProjectSiteID &
                                                        "&PackageID=" & strPackageID &
                                                        "&TemplateID=" & strTemplateID &
                                                        "&FromWhere=" & CommonFunction.General.CheckIsNothing(.QueryString("FromWhere"), "") &
                                                        "&PagingAlphabet=" & CommonFunction.General.CheckIsNothing(.QueryString("PagingAlphabet"), "") &
                                                        "&SortBy=" & CommonFunction.General.CheckIsNothing(.QueryString("SortBy"), "") &
                                                        "&SortOrder=" & CommonFunction.General.CheckIsNothing(.QueryString("SortOrder"), "") &
                                                        "&ParentTagID=" & CommonFunction.General.CheckIsNothing(.QueryString("ParentTagID"), "") &
                                                        "&FromCL=1" &
                                                        """, ""_new"", ""resizable=yes,scrollbars=no,left="" + ((window.screen.width - 850)/2) + "",top="" + ((window.screen.height - 650)/2) + "",width=850,height=650"");" + vbCrLf
                                                    strFunction &= "return;" + vbCrLf

                                                    ' End Modification By NitinVS on 22 Feb 2005 

                                                    If blnIsProjectCreationWorkflowReqd = True Then
                                                        If intBaselineNumber = 0 Then
                                                            Args.ToBeInsertedInFunction = "alert('" & strBaselineMessage & "'); " & vbCrLf
                                                            Args.ToBeInsertedInFunction += "return;"
                                                        End If
                                                    End If
                                                    If blnProjectOnHold = True Then
                                                        Args.ToBeInsertedInFunction += "alert('" & strOnHoldMessage & "'); " & vbCrLf
                                                        Args.ToBeInsertedInFunction += "return;"
                                                    End If
                                                    Args.ToBeInsertedInFunction += strFunction

                                                End With
                                            End If
                                        Else
                                            Cancel = True
                                        End If
                                    Else
                                        Cancel = True
                                    End If
                                End If
                            End If
                            'End of addition - ShamkantD on 27th August 2004                      
                            'Added by HarshK for sp4 issueid 517 on 05/10/2005
                            If Args.ClientSideFunctionName.ToUpper = "SETBASELINE_ONCLICK" Then
                                Dim strClientScript As String
                                Dim strMsg As String
                                'Initialize the Resources
                                objTemplate = New WebPages.Template.WhizTemplate
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                strMsg = CommonFunctions.General.CheckIsNothing(objTemplate.GetResourceString("MSG_ENDDATE_NOTSET"), "Please enter Completion Date") + ""
                                objTemplate = Nothing

                                strClientScript = " var objEndDate=GetObjectReference('frmCommonPage','NonDatabase7');" + vbCrLf
                                strClientScript += " var objDate=GetObjectReference('frmCommonPage','EarliestStartDate');" + vbCrLf
                                strClientScript += " if(objEndDate != null && objDate != null){" + vbCrLf
                                strClientScript += " if(objEndDate.value == '' || objDate.value == ''){" + vbCrLf
                                strClientScript += " alert('" + strMsg.Trim + "'); return; }}" + vbCrLf
                                Args.ToBeInsertedInFunction = strClientScript

                            End If
                            'End Added by HarshK for sp4 issueid 517 on 05/10/2005 

                            ''Added by ManishK for AddDeliverable link on 11th Jan 06

                            If CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper = "IB" And (CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "")).ToUpper = "ADD_NEW" Or CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), "")).ToUpper = "SAVE") Then
                                If Args.ClientSideFunctionName.ToUpper = "BACK_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.open ('../General/CommonList.aspx?FromWhere=IB&MasterTagID=2246', '_popup', 'resizable=yes,scrollbars=no,left=' + ((window.screen.width - 600)/2) + ',top=' + ((window.screen.height - 600)/2) + ',width=650,height=600', '', 'resizable=yes,scrollbars=no,left=' + ((window.screen.width - 0)/2) + ',top=' + ((window.screen.height - 0)/2) + ',width=0,height=0');"
                                    Args.ToBeInsertedInFunction += "return;"
                                End If
                            End If
                            If CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper = "CRM" And (CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "")).ToUpper = "ADD_NEW" Or CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), "")).ToUpper = "SAVE") Then
                                If Args.ClientSideFunctionName.ToUpper = "BACK_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.open ('../General/CommonList.aspx?FromWhere=CRM&MasterTagID=2246', '_popup', 'resizable=yes,scrollbars=no,left=' + ((window.screen.width - 600)/2) + ',top=' + ((window.screen.height - 600)/2) + ',width=650,height=600', '', 'resizable=yes,scrollbars=no,left=' + ((window.screen.width - 0)/2) + ',top=' + ((window.screen.height - 0)/2) + ',width=0,height=0');"
                                    Args.ToBeInsertedInFunction += "return;"
                                End If
                            End If

                            If CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper = "PMCM" And (CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "")).ToUpper = "ADD_NEW" Or CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), "")).ToUpper = "SAVE") Then
                                If Args.ClientSideFunctionName.ToUpper = "BACK_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.open ('../General/CommonList.aspx?FromWhere=PMCM&MasterTagID=2246', '_self', 'resizable=yes,scrollbars=no,left=' + ((window.screen.width - 600)/2) + ',top=' + ((window.screen.height - 600)/2) + ',width=650,height=600', '', 'resizable=yes,scrollbars=no,left=' + ((window.screen.width - 0)/2) + ',top=' + ((window.screen.height - 0)/2) + ',width=0,height=0');"
                                    Args.ToBeInsertedInFunction += "return;"
                                End If
                            End If
                            ''End Added by ManishK for AddDeliverable link on 11th Jan 06

                            'Integrated by MrugajaB on 21th June 2006 for WhizibleSEM Issue ID.4262
                            'Added by ShitalN
                            'If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                            '    Dim strSQL As String
                            '    Dim strDate As String
                            '    Dim strStatus As String
                            '    'Dim drDetails As IDataReader
                            '    Dim strOldStatus As String
                            '    Dim strOldDate As String
                            '    Dim strOldTime As String
                            '    'Args.ToBeInsertedInFunction = ""
                            '    'Args.ToBeInsertedInFunction = "var objStatusChangeDate=GetObjectReference('frmCommonPage','StatusChangeDate');" + vbCrLf
                            '    'Args.ToBeInsertedInFunction += "var objStatusChangeTime=GetObjectReference('frmCommonPage','StatusChangeTime');" + vbCrLf

                            '    Args.ToBeInsertedInFunction = "var objStatusChangeDate=GetObjectReference('frmCommonPage','StatusChangeDate');" + vbCrLf
                            '    Args.ToBeInsertedInFunction += "var objStatusChangeTime=GetObjectReference('frmCommomPage','StatusChangeTime');" + vbCrLf

                            '    Args.ToBeInsertedInFunction += "var objStartDate=GetObjectReference('frmCommonPage','StartDate');" + vbCrLf
                            '    Args.ToBeInsertedInFunction += "var objEndDate=GetObjectReference('frmCommonPage','EarliestStartDate');" + vbCrLf
                            '    Args.ToBeInsertedInFunction += "var objStartTime=GetObjectReference('frmCommonPage','RequestedTime');" + vbCrLf
                            '    Args.ToBeInsertedInFunction += "var objEndTime=GetObjectReference('frmCommonPage','ExpectedCompletionTime');" + vbCrLf
                            '    Args.ToBeInsertedInFunction += "var objNewStatus=GetObjectReference('frmCommonPage','Status');" + vbCrLf



                            '    '''''Validation of Status Change Time

                            '    Args.ToBeInsertedInFunction += "if (!isTime(objStatusChangeTime))" + vbCrLf
                            '    Args.ToBeInsertedInFunction += "{ alert('Status Change Time is Not valid Time');" + vbCrLf
                            '    Args.ToBeInsertedInFunction += "setFocus(objStatusChangeTime); return;}" + vbCrLf


                            '    If Args.PrimaryKeyValue <> "" Then '''''EDIT Mode
                            '        'Args.ToBeInsertedInFunction += "alert('Edit Mode');" + vbCrLf

                            '        '''' New Status Should not be Same as Old Status
                            '        strSQL = "SELECT Status FROM tbl_PM_OtherSchedules WHERE ScheduleID='" & Args.PrimaryKeyValue.ToString & "'"
                            '        strOldStatus = CType(CommonFunction.Data.GetDataScalar(strSQL, True).ToString, String)
                            '        '= CommonFunction.Data.CheckIsDBNull(CommonFunction.Dates.GetDate(CType(drDetails("Status"), Date)), "").ToString
                            '        CommonFunction.HTMLControls.DrawTextBox("OldStatus", "OldStatus", , , , strOldStatus, IsHidden:=True)
                            '        Args.ToBeInsertedInFunction += "var objOldStatus=GetObjectReference('frmCommonPage','OldStatus');" + vbCrLf


                            '        ''''Old Status Change Date 
                            '        strSQL = "select REPLACE((convert(varchar(50),cast(StatusChangeDate as smallDatetime),106)),' ','-') FROM tbl_PM_OtherSchedules WHERE ScheduleID='" & Args.PrimaryKeyValue.ToString & "'"
                            '        'strSQL = "select StatusChangeDate FROM tbl_PM_OtherSchedules WHERE ScheduleID='" & Args.PrimaryKeyValue.ToString & "'"
                            '        strOldDate = CType(CommonFunction.Data.GetDataScalar(strSQL, True).ToString, String)
                            '        'CommonFunction.HTMLControls.DrawDateControl("OldDate", "OldDate", , , strOldDate, , "dd.mm.yyyy", , , , , , , , , , , True)
                            '        CommonFunction.HTMLControls.DrawDateControl("OldDate", "OldDate", , , strOldDate, , , , , , , , , , , , , True)
                            '        Args.ToBeInsertedInFunction += "var objOldDate=GetObjectReference('frmCommonPage','OldDate');" + vbCrLf

                            '        ''''Old Status Change Time 
                            '        strSQL = "SELECT StatusChangeTime FROM tbl_PM_OtherSchedules WHERE ScheduleID='" & Args.PrimaryKeyValue.ToString & "'"
                            '        strOldTime = CType(CommonFunction.Data.GetDataScalar(strSQL, True).ToString, String)
                            '        CommonFunction.HTMLControls.DrawTextBox("OldTime", "OldTime", , , , strOldTime, IsHidden:=True)
                            '        Args.ToBeInsertedInFunction += "var objOldTime=GetObjectReference('frmCommonPage','OldTime');" + vbCrLf

                            '        Args.ToBeInsertedInFunction += "if (objOldStatus.value==objNewStatus.value)" + vbCrLf
                            '        Args.ToBeInsertedInFunction += "{ if (objOldDate.value!=objStatusChangeDate.value || objOldTime.value !=objStatusChangeTime.value )" + vbCrLf
                            '        Args.ToBeInsertedInFunction += "{ alert('Status change date and/or time will be not be changed for this status!');" + vbCrLf
                            '        Args.ToBeInsertedInFunction += " setFocus(objNewStatus); return; } }" + vbCrLf
                            '        'Args.ToBeInsertedInFunction += "{ alert('hi'+<%=MyBase.GetResourceString('SAME_STATUS')%>); return; } }" + vbCrLf

                            '        Args.ToBeInsertedInFunction += "else" + vbCrLf

                            '        ''Mrugaja
                            '        Args.ToBeInsertedInFunction += "{ if(disAllowDateTime1GreaterThanDateTime2(objOldDate,objOldTime,objStatusChangeDate,objStatusChangeTime,'Status Change Date & Time should Not be less than Previous Status Date & Time.'))" + vbCrLf
                            '        Args.ToBeInsertedInFunction += "return; " + vbCrLf

                            '        'Args.ToBeInsertedInFunction += "return; " + vbCrLf
                            '        Args.ToBeInsertedInFunction += " if (objOldDate.value==objStatusChangeDate.value && objOldTime.value==objStatusChangeTime.value )" + vbCrLf
                            '        Args.ToBeInsertedInFunction += "{ alert('Status Change Date & Time should Not Equal to Previous Status Date & Time.'); " + vbCrLf
                            '        Args.ToBeInsertedInFunction += "setFocus(objStatusChangeTime); return; }}" + vbCrLf

                            '    End If

                            '    '
                            '    'strSQL = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
                            '    'strDate = CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

                            '    'CommonFunction.HTMLControls.DrawTextBox("CurrentDate", "CurrentDate", , , , CType(CommonFunction.Dates.GetDate(Date.Now), String), IsHidden:=True)
                            '    'CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strDate, IsHidden:=True)


                            '    CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , CommonFunction.Dates.GetDate(Now()), DisplayNone:=True)
                            '    CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , Now.Hour.ToString + ":" + Now.Minute.ToString, IsHidden:=True)

                            '    Args.ToBeInsertedInFunction += "var objCurrentDate=GetObjectReference('frmCommonPage','CurrentDate');" + vbCrLf
                            '    Args.ToBeInsertedInFunction += "var objCurrentTime=GetObjectReference('frmCommonPage','CurrentTime');" + vbCrLf


                            '    ''''Start Date Should be Greater Than End Date
                            '    Args.ToBeInsertedInFunction += "if(disAllowDateTime1GreaterThanDateTime2(objStartDate,objStartTime,objEndDate,objEndTime,'Scheduled Start  Date & Time should Not be Greater than Earliest Completion Date & Time.'))" + vbCrLf
                            '    Args.ToBeInsertedInFunction += "{setFocus(objStatusChangeDate); return;}" + vbCrLf


                            '    ''''Status Change Date/Time Should Not be Greater Than Current Date/Time
                            '    ' Args.ToBeInsertedInFunction += "alert(objStatusChangeDate.value);"
                            '    ' Args.ToBeInsertedInFunction += "alert(objStatusChangeTime.value);"
                            '    ' Args.ToBeInsertedInFunction += "alert(objCurrentDate.value);"
                            '    ' Args.ToBeInsertedInFunction += "alert(objCurrentTime.value);"
                            '    Args.ToBeInsertedInFunction += "if(disAllowDateTime1GreaterThanDateTime2(objStatusChangeDate,objStatusChangeTime,objCurrentDate,objCurrentTime,'Status Change Date & Time should Not be Greater than Current Date & Time.'))" + vbCrLf
                            '    Args.ToBeInsertedInFunction += "{setFocus(objStatusChangeTime); return;}" + vbCrLf


                            '    ''''Status Change Date/Time Should be Less Than Start Date/Time
                            '    Args.ToBeInsertedInFunction += "if(disAllowDateTime1GreaterThanDateTime2(objStartDate,objStartTime,objStatusChangeDate,objStatusChangeTime,'Status Change Date & Time should Not be Less than Scheduled Start Date & Time.'))" + vbCrLf
                            '    Args.ToBeInsertedInFunction += "{setFocus(objStatusChangeTime); return;}" + vbCrLf


                            '    ''''Status Change Date Should be Greater Than End Date
                            '    Args.ToBeInsertedInFunction += "if(disAllowDateTime1GreaterThanDateTime2(objStatusChangeDate,objStatusChangeTime,objEndDate,objEndTime,'Status Change Date & Time should Not be Greater than Earliest Completion Date & Time.'))" + vbCrLf
                            '    Args.ToBeInsertedInFunction += "{setFocus(objStartDate); return;}" + vbCrLf

                            'End If

                            'End Added by ShitalN
                            'End Integration

                            'Added by ShamkantD on 20th August 2004
                        Case CommonFunction.Constants.APP_TAG_WORKORDER_CONTRACT_CLAUSES
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE_ADD", "FILTERS", "SHOW_HISTORY"
                                    Cancel = True
                            End Select

                            Select Case Args.LinkName.ToUpper
                                Case "CLOSE"
                                    Args.ToBeInsertedInFunction = "window.close();" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;"
                                Case "SAVE"
                                    Args.ToBeInsertedInFunction = " objForm = GetFormReference('frmCommonList');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "        objForm.action='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_WORKORDER_CONTRACT_CLAUSES, String) + " &Save=True';" + vbCrLf
                                    Args.ToBeInsertedInFunction += "        objForm.submit();" + vbCrLf
                                    Args.ToBeInsertedInFunction += "        return;" + vbCrLf
                            End Select
                            'End Addition - ShamkantD on 20th August 2004

                            'Added by ShamkantD on 20th August 2004
                        Case CommonFunction.Constants.APP_TAG_PROJECT_DOH
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "SAVE_ADD", "SHOW_HISTORY"
                                    Cancel = True
                            End Select

                            Dim strFunction As String
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                strFunction = "window.close();"
                                strFunction += "return;"
                                Args.ToBeInsertedInFunction = strFunction
                            End If
                            'End Addition - ShamkantD on 20th August 2004                           

                            'added by SachinR   On 21 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_PRS_DELIVERABLE_TYPES
                            If Args.PrimaryKeyValue = "" And Args.ClientSideFunctionName.ToUpper = "DEFINESERIES" Then
                                Cancel = True
                            End If
                            'addition end 
                            'Added by ShamkantD on 23rd August 2004
                        Case CommonFunction.Constants.APP_TAG_ANSWER_SET_PREVIEW
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "SAVE", "SAVE_ADD", "DELETE", "SELECT_ALL", "FILTERS", "SHOW_HISTORY", "CONFIGURE"
                                    Cancel = True
                            End Select

                            Select Case Args.LinkName.ToUpper
                                Case "CLOSE"
                                    Args.ToBeInsertedInFunction = "window.close();" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;"
                            End Select
                            'End of addition - ShamkantD on 23rd August 2004
                            'Added by HarshK for sp4 issueid 200 
                        Case CommonFunction.Constants.APP_TAG_MODULE_SELECTION_LIST
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "SAVE", "SAVE_ADD", "DELETE", "SELECT_ALL", "FILTERS"
                                    Cancel = True
                            End Select
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;"
                            ElseIf Args.ClientSideFunctionName.ToUpper = "UNSELECT_ONCLICK" Then
                                Args.ToBeInsertedInFunction += "if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='TaskMap' ){" + vbCrLf
                                Args.ToBeInsertedInFunction += "opener.frmTaskDetails.cboColModule.selectedIndex = -1;" + vbCrLf
                                Args.ToBeInsertedInFunction += "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;}" + vbCrLf
                            End If

                        Case CommonFunction.Constants.APP_TAG_MILESTONE_SELECTION_LIST
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "SAVE", "SAVE_ADD", "DELETE", "SELECT_ALL", "FILTERS"
                                    Cancel = True
                            End Select
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;"
                            ElseIf Args.ClientSideFunctionName.ToUpper = "UNSELECT_ONCLICK" Then
                                Args.ToBeInsertedInFunction += "if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='TaskMap' ){" + vbCrLf
                                Args.ToBeInsertedInFunction += "opener.frmTaskDetails.cboColMilestone.selectedIndex = -1;" + vbCrLf
                                Args.ToBeInsertedInFunction += "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;}" + vbCrLf
                            End If
                            '-------------------------------------------------
                        Case CommonFunction.Constants.APP_TAG_SUBPROJECT_SELECTION_LIST
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "SAVE", "SAVE_ADD", "DELETE", "SELECT_ALL", "FILTERS"
                                    Cancel = True
                            End Select
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;"
                            ElseIf Args.ClientSideFunctionName.ToUpper = "UNSELECT_ONCLICK" Then
                                Args.ToBeInsertedInFunction += "if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='TaskMap' ){" + vbCrLf
                                Args.ToBeInsertedInFunction += "opener.frmTaskDetails.cboColSubProject.selectedIndex = -1;" + vbCrLf
                                Args.ToBeInsertedInFunction += "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;}" + vbCrLf
                            End If
                            '-------------------------------------------------
                        Case CommonFunction.Constants.APP_TAG_TASKTYPE_SELECTION_LIST
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "SAVE", "SAVE_ADD", "DELETE", "SELECT_ALL", "FILTERS"
                                    Cancel = True
                            End Select
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;"
                            ElseIf Args.ClientSideFunctionName.ToUpper = "UNSELECT_ONCLICK" Then
                                Args.ToBeInsertedInFunction += "if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='TaskMap' ){" + vbCrLf
                                Args.ToBeInsertedInFunction += "opener.frmTaskDetails.cboColTaskType.selectedIndex = -1;" + vbCrLf
                                Args.ToBeInsertedInFunction += "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;}" + vbCrLf
                            End If
                            '-------------------------------------------------
                        Case CommonFunction.Constants.APP_TAG_PHASE_SELECTION_LIST
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "SAVE", "SAVE_ADD", "DELETE", "SELECT_ALL", "FILTERS"
                                    Cancel = True
                            End Select
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;"
                            ElseIf Args.ClientSideFunctionName.ToUpper = "UNSELECT_ONCLICK" Then
                                Args.ToBeInsertedInFunction += "if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='TaskMap' ){" + vbCrLf
                                Args.ToBeInsertedInFunction += "opener.frmTaskDetails.cboColPhase.selectedIndex = -1;" + vbCrLf
                                Args.ToBeInsertedInFunction += "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;}" + vbCrLf
                            End If
                            'End Added by HarshK for sp4 issueid 200 
                            '##### Case Added By AmitD on 25 Aug 2004 For Deliverables Selection List
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLES_SELECTION_LIST
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "SAVE", "SAVE_ADD", "DELETE", "SELECT_ALL", "FILTERS"
                                    Cancel = True
                            End Select
                            'Added By JayavantK on 21-Sep-2004
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;"
                            ElseIf Args.ClientSideFunctionName.ToUpper = "UNSELECT_ONCLICK" Then

                                Args.ToBeInsertedInFunction += "if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='PM' ){" + vbCrLf

                                'Modified by ShraddhaM on Date 07 Jully,2006 for WhizibleSEM Issue ID.4168
                                'Changed For Firefox
                                Args.ToBeInsertedInFunction += "var objNDB1 = GetParentObjectReference('frmTaskAssignment','txtDeliverableID');" + vbCrLf

                                Args.ToBeInsertedInFunction += "objNDB1.value='';" + vbCrLf


                                Args.ToBeInsertedInFunction += "var objDelID = GetParentObjectReference('frmTaskAssignment','txtHidDeliverableID');" + vbCrLf

                                Args.ToBeInsertedInFunction += "objDelID.value='0';" + vbCrLf
                                'Args.ToBeInsertedInFunction += "opener.frmTaskAssignment.txtDeliverableID.value = '';" + vbCrLf


                                'Args.ToBeInsertedInFunction += "opener.frmTaskAssignment.txtHidDeliverableID.value = '0';" + vbCrLf
                                Args.ToBeInsertedInFunction += "window.close();" + vbCrLf
                                'Added By NitinVS on 25 November 2004 
                                'To unselect deliverable from IBIssueEntry Page
                                Args.ToBeInsertedInFunction += "return;}" + vbCrLf
                                Args.ToBeInsertedInFunction += "if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='IB' )  {" + vbCrLf

                                'Modified by ShraddhaM on Date 07 Jully,2006 for WhizibleSEM Issue ID.4168
                                'Changed For Firefox
                                Args.ToBeInsertedInFunction += "var objNDB1 = GetParentObjectReference('frmIBIssueEntry','txtDeliverableName');" + vbCrLf

                                Args.ToBeInsertedInFunction += "objNDB1.value='';" + vbCrLf


                                Args.ToBeInsertedInFunction += "var objDelID = GetParentObjectReference('frmIBIssueEntry','DeliverableID');" + vbCrLf

                                Args.ToBeInsertedInFunction += "objDelID.value='0';" + vbCrLf
                                'Args.ToBeInsertedInFunction += "opener.frmIBIssueEntry.txtDeliverableName.value = '';" + vbCrLf
                                'Args.ToBeInsertedInFunction += "opener.frmIBIssueEntry.DeliverableID.value = '0';" + vbCrLf
                                Args.ToBeInsertedInFunction += "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;}" + vbCrLf
                                'End Addition - NitinVS on 25 November 2004

                                ''Added by Manishk On 11thJan 2006 to add deliverable link On Helpdesk page
                                Args.ToBeInsertedInFunction += "if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='CRM' )  {" + vbCrLf

                                'Modified by ShraddhaM on Date 07 Jully,2006 for WhizibleSEM Issue ID.4168
                                'Changed For Firefox
                                Args.ToBeInsertedInFunction += "var objNDB1 = GetParentObjectReference('frmRequestDetails','txtDeliverableName');" + vbCrLf

                                Args.ToBeInsertedInFunction += "objNDB1.value='';" + vbCrLf


                                Args.ToBeInsertedInFunction += "var objDelID = GetParentObjectReference('frmRequestDetails','DeliverableID');" + vbCrLf

                                Args.ToBeInsertedInFunction += "objDelID.value='0';" + vbCrLf

                                'Args.ToBeInsertedInFunction += "opener.frmRequestDetails.txtDeliverableName.value = '';" + vbCrLf
                                'Args.ToBeInsertedInFunction += "opener.frmRequestDetails.DeliverableID.value = '0';" + vbCrLf
                                Args.ToBeInsertedInFunction += "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;}" + vbCrLf

                                ''End of Added by Manishk On 11thJan 2006 to add deliverable link On Helpdesk page

                                'Modified By VidyaJ - For IssueID - 382 - SP4    
                                Args.ToBeInsertedInFunction += "if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='ReviewAction' )  {" + vbCrLf

                                'Modified by ShraddhaM on Date 07 Jully,2006 for WhizibleSEM Issue ID.4168
                                'Changed For Firefox
                                Args.ToBeInsertedInFunction += "var objNDB1 = GetParentObjectReference('frmIssueEntryForReview','txtDeliverable');" + vbCrLf

                                Args.ToBeInsertedInFunction += "objNDB1.value='';" + vbCrLf


                                Args.ToBeInsertedInFunction += "var objDelID = GetParentObjectReference('frmIssueEntryForReview','DeliverableID');" + vbCrLf

                                Args.ToBeInsertedInFunction += "objDelID.value='0';" + vbCrLf

                                'Args.ToBeInsertedInFunction += "opener.frmIssueEntryForReview.txtDeliverable.value = '';" + vbCrLf
                                'Args.ToBeInsertedInFunction += "opener.frmIssueEntryForReview.DeliverableID.value = '0';" + vbCrLf
                                Args.ToBeInsertedInFunction += "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;}" + vbCrLf
                                'End Of Modifications


                                'Added by HarshK for sp4 issueid 200 (Deliverable mapping on change menangement)

                                Args.ToBeInsertedInFunction += "if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='ChgMng' ){" + vbCrLf


                                'Modified by ShraddhaM on Date 07 Jully,2006 for WhizibleSEM Issue ID.4168
                                'Changed For Firefox
                                Args.ToBeInsertedInFunction += "var objNDB1 = GetParentObjectReference('frmCommonPage','NonDatabase1');" + vbCrLf

                                Args.ToBeInsertedInFunction += "objNDB1.value='';" + vbCrLf


                                Args.ToBeInsertedInFunction += "var objDelID = GetParentObjectReference('frmCommonPage','DeliverableID');" + vbCrLf

                                Args.ToBeInsertedInFunction += "objDelID.value='0';" + vbCrLf
                                'Args.ToBeInsertedInFunction += "opener.frmCommonPage.DeliverableID.value = '0';" + vbCrLf
                                Args.ToBeInsertedInFunction += "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;}" + vbCrLf

                                Args.ToBeInsertedInFunction += "if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='TaskMap' ){" + vbCrLf

                                'Modified by ShraddhaM on Date 07 Jully,2006 for WhizibleSEM Issue ID.4168
                                'Changed For Firefox
                                Args.ToBeInsertedInFunction += "var objNDB1 = GetParentObjectReference('frmTaskDetails','cboColDeliverable');" + vbCrLf

                                Args.ToBeInsertedInFunction += "objNDB1.selectedIndex = -1;" + vbCrLf
                                'Args.ToBeInsertedInFunction += "opener.frmTaskDetails.cboColDeliverable.selectedIndex = -1;" + vbCrLf
                                Args.ToBeInsertedInFunction += "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;}" + vbCrLf
                                'End Added by HarshK for sp4 issueid 200

                                'Added by SwapnilR on 13th Dec 2004
                                'To unselect deliverable from review page
                                'MODIFIED BY VIVEKP ON 27 SEP 2005 For ISSUEID -382
                                Args.ToBeInsertedInFunction += "if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='Reviews' ){" + vbCrLf

                                'Modified by ShraddhaM on Date 07 Jully,2006 for WhizibleSEM Issue ID.4168
                                'Changed For Firefox
                                Args.ToBeInsertedInFunction += "var objNDB1 = GetParentObjectReference('frmCommonPage','NonDatabase2');" + vbCrLf

                                Args.ToBeInsertedInFunction += "objNDB1.value='';" + vbCrLf


                                Args.ToBeInsertedInFunction += "var objDelID = GetParentObjectReference('frmCommonPage','DeliverableID');" + vbCrLf

                                Args.ToBeInsertedInFunction += "objDelID.value='0';" + vbCrLf

                                'Args.ToBeInsertedInFunction += "opener.frmCommonPage.NonDatabase2.value = '';" + vbCrLf


                                'Args.ToBeInsertedInFunction += "opener.frmCommonPage.DeliverableID.value = '0';" + vbCrLf

                                Args.ToBeInsertedInFunction += "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;}" + vbCrLf
                                Args.ToBeInsertedInFunction += "if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='Review' ){" + vbCrLf

                                'Modified by ShraddhaM on Date 07 Jully,2006 for WhizibleSEM Issue ID.4168
                                'Changed For Firefox
                                Args.ToBeInsertedInFunction += "var objNDB1 = GetParentObjectReference('frmCommonPage','NonDatabase7');" + vbCrLf

                                Args.ToBeInsertedInFunction += "objNDB1.value='';" + vbCrLf


                                Args.ToBeInsertedInFunction += "var objDelID = GetParentObjectReference('frmCommonPage','DeliverableID');" + vbCrLf

                                Args.ToBeInsertedInFunction += "objDelID.value='0';" + vbCrLf
                                'Args.ToBeInsertedInFunction += "opener.frmCommonPage.NonDatabase7.value = '';" + vbCrLf
                                'Args.ToBeInsertedInFunction += "opener.frmCommonPage.DeliverableID.value = '0';" + vbCrLf
                                Args.ToBeInsertedInFunction += "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;}" + vbCrLf
                                'END OF MODIFICATION BY VIVEKP ON 27 SEP 2005 FOR ISSUEID -382
                                'End of addtion by SwapnilR on 13th Dec 2004
                                'Added By Bharat Tekade on 11th-jan-2016 for Quick Create Page Deliverable unselection

                                Args.ToBeInsertedInFunction += "if('" + CType(InStr(HttpContext.Current.Request("FromWhere").ToString.Trim, "QuickCreate", CompareMethod.Text), String) + "' > '0')" + vbCrLf
                                Args.ToBeInsertedInFunction += "{ " + vbCrLf

                                ''Added by Dhanashri S on 27 Jan 2016 For Index out of Bound error on Assigned Tasks Deliverable
                                Dim RowNumber As String
                                If Split(HttpContext.Current.Request("FromWhere"), "QuickCreate").Length > 1 Then
                                    ''Commented and Added by Dhanashri S on 27 Jan 2016
                                    ''Dim RowNumber As String = Split(HttpContext.Current.Request("FromWhere"), "QuickCreate")(1)
                                    RowNumber = Split(HttpContext.Current.Request("FromWhere"), "QuickCreate")(1)
                                    ''End of Comment and Addition by Dhanashri S on 27 Jan 2016
                                End If
                                ''End of Addition by Dhanashri S on 27 Jan 2016

                                'CommonFunctions.General.WriteHTML("var obje=window.opener.document.forms['frmQuickTask']['txtDeliverableID" + CType(HttpContext.Current.Request("RowCount"), String) + "']; " + vbCrLf)
                                Args.ToBeInsertedInFunction += "var objDeliverableName = GetParentObjectReference('frmQuickTask','txtDeliverableID" + RowNumber + "');" + vbCrLf
                                Args.ToBeInsertedInFunction += "objDeliverableName.value = '';" + vbCrLf
                                Args.ToBeInsertedInFunction += "var objDeliverableID = GetParentObjectReference('frmQuickTask','txtHidDeliverableID" + RowNumber + "');" + vbCrLf
                                Args.ToBeInsertedInFunction += "objDeliverableID.value = '0';" + vbCrLf
                                Args.ToBeInsertedInFunction += "window.close();" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;}" + vbCrLf
                                'Commented By Chakshuta H on 11th-Nov-2016 Purpose::'}'  bracket should not be present on top and bottom of the page
                                'CommonFunctions.General.WriteHTML("}" + vbCrLf)
                                'End Of Commented By Chakshuta H on 11th-Nov-2016 Purpose::'}'  bracket should not be present on top and bottom of the page
                                'End of Added By Bharat Tekade on 11th-jan-2016 for Quick Create Page Deliverable unselection
                            End If

                                'End Addition
                                '##### End Addition

                                'added by SachinR   on 26 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_ASSOCIATED_PHASE_TASK, CommonFunction.Constants.APP_TAG_ASSOCIATED_ACTIVITIES, CommonFunction.Constants.APP_TAG_ASSOCIATED_ACTIVITIES_DISTRIBUTION, CommonFunction.Constants.APP_TAG_TAB_ASSOCIATED_PHASE_TASK
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If
                        Case CommonFunction.Constants.APP_TAG_SELECT_TEMPLATE
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            ElseIf Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "var i; var blnSelected=false; " + vbCrLf
                                Args.ToBeInsertedInFunction += "var objChk=GetObjectReference('frmCommonList','chkDelete',true);" + vbCrLf
                                Args.ToBeInsertedInFunction += "if(objChk==null){ return; }" + vbCrLf
                                Args.ToBeInsertedInFunction += "var intRowCount = objChk.length;" + vbCrLf
                                Args.ToBeInsertedInFunction += "for(i=0;i<intRowCount;i++){" + vbCrLf
                                Args.ToBeInsertedInFunction += "if(objChk[i].disabled==false){" + vbCrLf
                                Args.ToBeInsertedInFunction += "if(objChk[i].checked==true){" + vbCrLf
                                Args.ToBeInsertedInFunction += "blnSelected=true;	break; }" + vbCrLf
                                Args.ToBeInsertedInFunction += " }" + vbCrLf
                                Args.ToBeInsertedInFunction += " }" + vbCrLf
                                Args.ToBeInsertedInFunction += " if(blnSelected==false){ return; } " + vbCrLf

                            End If
                                'addition end

                        Case CommonFunction.Constants.APP_TAG_RFI_SENDINVOICEMAILS
                            If Args.ClientSideFunctionName.ToUpper = "NEW_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "DELETE_ONCLICK" Then
                                Cancel = True
                            End If
                            If Args.ClientSideFunctionName.ToUpper = "SENDEMAIL" Then
                                'Code added by SandipL on 8 Dec 2005 -- for showing send mail Page
                                Dim strIsRequiredIDArray As String() = Split(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")), ",")
                                Dim lngCustomerID As Long
                                Dim lngCompanyID As Long
                                Dim strSQL As String
                                'Get the Customer ID and Company ID From the Filter Settings
                                '  Apply the Project filter.
                                strSQL = "usp_sel_tbl_UI_EmployeeFiletrsetting " + CommonFunction.Constants.APP_TAG_RFI_SENDINVOICEMAILS.ToString + ",'" + WhizGlobal.LoginType + "'," + WhizGlobal.UserID.ToString + ",'CustomerID'"
                                lngCustomerID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Long)
                                strSQL = "usp_sel_tbl_UI_EmployeeFiletrsetting " + CommonFunction.Constants.APP_TAG_RFI_SENDINVOICEMAILS.ToString + ",'" + WhizGlobal.LoginType + "'," + WhizGlobal.UserID.ToString + ",'CompanyID'"
                                lngCompanyID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Long)
                                'If lngCustomerID <> 0 And lngCompanyID <> 0 Then

                                'End addition by SandipL on 8 Dec 2005

                                Dim objAppResource As WebPages.Template.WhizTemplate
                                objAppResource = New WebPages.Template.WhizTemplate
                                objAppResource.InitializeResources("AppResources.EventHandlers", "AppResources")
                                Dim strFunction As String = ""
                                strFunction = "var objCust=GetObjectReference('frmCommonList','CustomerID_UserFriendlyValue');" + vbCrLf
                                strFunction += "var objComp=GetObjectReference('frmCommonList','CompanyID_UserFriendlyValue');" + vbCrLf
                                strFunction += "if(objCust!=null)" + vbCrLf
                                strFunction += "{" + vbCrLf
                                strFunction += "if(objCust.value=="""")" + vbCrLf
                                strFunction += "{" + vbCrLf
                                strFunction += "alert('" + objAppResource.GetResourceString("MSG_RFI_CUST_BLANK") + "');" + vbCrLf
                                strFunction += "return;" + vbCrLf
                                strFunction += "}" + vbCrLf
                                strFunction += "}" + vbCrLf
                                strFunction += "if(objComp!=null)" + vbCrLf
                                strFunction += "{" + vbCrLf
                                strFunction += "if(objComp.value=="""")" + vbCrLf
                                strFunction += "{" + vbCrLf
                                strFunction += "alert('" + objAppResource.GetResourceString("MSG_RFI_COMP_BLANK") + "');" + vbCrLf
                                strFunction += "return;" + vbCrLf
                                strFunction += "}" + vbCrLf
                                strFunction += "}" + vbCrLf
                                strFunction += "var objInv=GetObjectReference('frmCommonList','chkDelete',true);" + vbCrLf
                                strFunction += "var blnRecordSelected=false;" + vbCrLf
                                strFunction += "if(objInv!=null)" + vbCrLf
                                strFunction += "var Len=objInv.length;" + vbCrLf
                                strFunction += "else" + vbCrLf
                                strFunction += "var Len=0;" + vbCrLf
                                strFunction += "if(Len==0)" + vbCrLf
                                strFunction += "return;" + vbCrLf
                                strFunction += "else if(Len==1)" + vbCrLf
                                strFunction += "{" + vbCrLf
                                strFunction += "var objInv=GetObjectReference('frmCommonList','chkDelete');" + vbCrLf
                                strFunction += "if(objInv.checked==true)" + vbCrLf
                                strFunction += "blnRecordSelected=true;" + vbCrLf
                                strFunction += "}" + vbCrLf
                                strFunction += "else" + vbCrLf
                                strFunction += "{" + vbCrLf
                                strFunction += "for(intCnt = 0;intCnt<=(Len-1);intCnt++)" + vbCrLf
                                strFunction += "{" + vbCrLf
                                strFunction += "if(objInv[intCnt].checked==true)" + vbCrLf
                                strFunction += "{" + vbCrLf
                                strFunction += "blnRecordSelected=true;break;" + vbCrLf
                                strFunction += "}" + vbCrLf
                                strFunction += "}" + vbCrLf
                                strFunction += "}" + vbCrLf
                                strFunction += "if(blnRecordSelected== false ) " + vbCrLf
                                strFunction += "{" + vbCrLf
                                strFunction += "alert('" + objAppResource.GetResourceString("MSG_SELECT_INVOICE") + "');" + vbCrLf
                                strFunction += "return;" + vbCrLf
                                strFunction += "}" + vbCrLf
                                'Code added by SandipL on 8 Dec 2005 -- for showing send mail Page
                                strFunction += " var strID = ''; " + vbCrLf
                                strFunction += " var i ; " + vbCrLf
                                strFunction += "if (objfrm.chkDelete.length > 1)" + vbCrLf
                                strFunction += " { " + vbCrLf
                                strFunction += "   for(i=0;i<objfrm.chkDelete.length;i++) " + vbCrLf
                                strFunction += "     { " + vbCrLf
                                strFunction += "       if (objfrm.chkDelete[i].checked)" + vbCrLf
                                strFunction += "          strID += objfrm.chkDelete[i].value + ',' ;" + vbCrLf
                                strFunction += " 	  }  " + vbCrLf
                                strFunction += "   if (strID != '') " + vbCrLf
                                strFunction += "   strID = strID.substring(0,strID.length-1) ; " + vbCrLf
                                strFunction += " }  " + vbCrLf
                                strFunction += "else " + vbCrLf
                                strFunction += "    if (objfrm.chkDelete.checked)" + vbCrLf
                                strFunction += "          strID += objfrm.chkDelete.value  ;" + vbCrLf
                                strFunction += "   if (strID != '') " + vbCrLf
                                strFunction += "window.open('../General/SendEmail_Attatchment.aspx?MessageID=57&CustomerID=" + lngCustomerID.ToString + "&CompanyID=" + lngCompanyID.ToString + "&INVOICEID='+ strID,null,'status=no,toolbar=no,menubar=no,width=600,height=500');" + vbCrLf
                                strFunction += "return;" + vbCrLf
                                'End addition by SandipL on 8 Dec 2008
                                objAppResource = Nothing
                                Args.ToBeInsertedInFunction = strFunction
                            End If

                                'added by SachinR   on 27 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_PUBLISH_DELIVERABLE_PROJECT_TEMPLATE
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If
                                'addition end
                                'Mrugaja
                                '    'integrated by harshada d on 15 th june 2006
                                '    'Integrated by PrajaktaR on 12th May2006 for Whizible 6.0.1 IssueID 3736
                                '    '--added by harshk on 18/07/05
                                'Case CommonFunction.Constants.APP_TAG_PUBLISH_DELIVERABLE_PROJECT_CHECKLIST
                                '    If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                '        Args.ToBeInsertedInFunction = "window.close(); return;"
                                '    End If
                                '    'end harshk on 18/07/05
                                '    'END Of Integration by PrajaktaR on 12th May2006 for Whizible 6.0.1 IssueID 3736
                                '    'end of integration by on 15 th june 2006

                                'added by SachinR   on 30 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_DELIVERY_UNIT_ORGANIZATION_STRUCTURE
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If
                                'addition end

                                'added by SachinR   on 10 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_PHASETASK_REVISION
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If
                                'addition end
                        Case CommonFunction.Constants.APP_TAG_PHASETASK_TEMPLATE_REVISION_1, CommonFunction.Constants.APP_TAG_PHASETASK_TEMPLATE_REVISION_2
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If
                                'addition end

                                'added by SachinR   on 15 Sep 2004
                                'This page is called from configure OU and Process tag.This page has two Add links
                                'Based on from where page is been called Add links are shown.
                                'when page is called from Process Tag then OUPoolID=0 else it has OUPoolID.
                        Case CommonFunction.Constants.APP_TAG_PROCESS
                            Dim lngOUPoolID As Long
                            lngOUPoolID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("OUPoolID"), "0"), Long)

                            'when OUPoolID is not zero then hide original Add link.
                            If Args.ClientSideFunctionName.ToUpper = "NEW_ONCLICK" Then
                                If lngOUPoolID > 0 Then
                                    Cancel = True
                                End If
                            ElseIf Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
                                If lngOUPoolID > 0 Then
                                    Cancel = True
                                End If
                            ElseIf Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                If lngOUPoolID <= 0 Then
                                    Cancel = True
                                Else
                                    Args.ToBeInsertedInFunction = "window.close(); return;"
                                End If
                            ElseIf Args.ClientSideFunctionName.ToUpper = "ADDEXISTING" Then
                                'when OUPoolID is zero then hide new Add link.
                                If lngOUPoolID <= 0 Then
                                    Cancel = True
                                Else
                                    Args.ToBeInsertedInFunction = "window.open('CommonList.aspx?FromWhere=PRO&MasterTagId=2205&OUPoolID=" + lngOUPoolID.ToString + "','','resizable=yes,scrollbars=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 400)/2 + ',width=600,height=400');  return;"
                                End If
                            End If

                        Case CommonFunction.Constants.APP_TAG_ADD_PROCESS_TO_OU
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If
                                'addition end

                                'added by SachinR   on 17 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_METRIC_LIST
                            Dim lngOUPoolID As Long
                            lngOUPoolID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("OUPoolID"), "0"), Long)

                            'when OUPoolID is not zero then hide original Add link.
                            If Args.ClientSideFunctionName.ToUpper = "NEW_ONCLICK" Then
                                Cancel = True
                            ElseIf Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
                                Cancel = True
                            ElseIf Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                If lngOUPoolID <= 0 Then
                                    Cancel = True
                                Else
                                    Args.ToBeInsertedInFunction = "window.close(); return;"
                                End If
                            ElseIf Args.ClientSideFunctionName.ToUpper = "ADDEXISTING" Then
                                'when OUPoolID is zero then hide new Add link.
                                If lngOUPoolID <= 0 Then
                                    Cancel = True
                                Else
                                    Args.ToBeInsertedInFunction = "window.open('CommonList.aspx?FromWhere=PRO&MasterTagId=2217&OUPoolID=" + lngOUPoolID.ToString + "','','resizable=yes,scrollbars=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 400)/2 + ',width=600,height=400');  return;"
                                End If
                            End If

                                'added by SachinR   on 17 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_ADD_METRIC_TO_OU, CommonFunction.Constants.APP_TAG_ADD_PMI_TO_OU
                            If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                Args.ToBeInsertedInFunction = "window.close(); return;"
                            End If

                        Case CommonFunction.Constants.APP_TAG_PROCESS_MEASUREMENT_INDICATOR
                            Dim lngOUPoolID As Long
                            lngOUPoolID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("OUPoolID"), "0"), Long)

                            'when OUPoolID is not zero then hide original Add link.
                            If Args.ClientSideFunctionName.ToUpper = "NEW_ONCLICK" Then
                                If lngOUPoolID > 0 Then
                                    Cancel = True
                                End If
                            ElseIf Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
                                If lngOUPoolID > 0 Then
                                    Cancel = True
                                End If
                            ElseIf Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                If lngOUPoolID <= 0 Then
                                    Cancel = True
                                Else
                                    Args.ToBeInsertedInFunction = "window.close(); return;"
                                End If
                            ElseIf Args.ClientSideFunctionName.ToUpper = "ADDEXISTING" Then
                                'when OUPoolID is zero then hide new Add link.
                                If lngOUPoolID <= 0 Then
                                    Cancel = True
                                Else
                                    Args.ToBeInsertedInFunction = "window.open('CommonList.aspx?FromWhere=PRO&MasterTagId=2218&OUPoolID=" + lngOUPoolID.ToString + "','','resizable=yes,scrollbars=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 400)/2 + ',width=600,height=400');  return;"
                                End If
                            End If
                                'addition end

                                'Added by ShamkantD on 17 Sep 2004 - for Select Cost Heads page (called from Project Costs)
                        Case CommonFunction.Constants.APP_TAG_TAB_SELECT_COST_HEADS
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE_ADD", "FILTERS", "SHOW_HISTORY"
                                    Cancel = True
                            End Select

                            Select Case Args.LinkName.ToUpper
                                Case "CLOSE"
                                    Args.ToBeInsertedInFunction = "window.close();" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;"
                                Case "SAVE"
                                    Args.ToBeInsertedInFunction = "objForm = GetFormReference('frmCommonList');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "objForm.action='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_TAB_SELECT_COST_HEADS, String) + " &Action=Save';" + vbCrLf
                                    Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf

                                    ' Args.ToBeInsertedInFunction += "window.opener.location.href=window.opener.location.href;"
                                    ' Args.ToBeInsertedInFunction += " refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FromWhere=PM&MasterTagID=2158',true); "

                                    Args.ToBeInsertedInFunction += "window.opener.location.href = '../General/Commonlist.aspx?FromWhere=PM&MasterTagID=2158'; //window.opener.location.href;" & vbCrLf

                                    'Added By Usha Pandit On 05.11.2020 For Refresh issue
                                    Args.ToBeInsertedInFunction += " window.onunload = refreshParent; "
                                    Args.ToBeInsertedInFunction += " function refreshParent() { "
                                    Args.ToBeInsertedInFunction += " window.opener.location.reload(); "
                                    Args.ToBeInsertedInFunction += " } "
                                    'End Of Added By Usha Pandit On 05.11.2020 For Refresh issue

                                    Args.ToBeInsertedInFunction += "return;" + vbCrLf
                            End Select
                                'End Addition - ShamkantD on 17 Sep 2004

                                'Added by ShamkantD on 27 Sep 2004 - added for 'Project Listing for Approvals' page
                        Case CommonFunction.Constants.APP_TAG_PROJECT_LISTING_FOR_APPROVALS
                                'Remove the links 
                                Select Case Args.SystemLinkType.ToUpper
                                    Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD", "SHOW_HISTORY"
                                        Cancel = True
                                End Select

                                If Args.ClientSideFunctionName.ToUpper() = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close();" & vbCrLf & "return;" & vbCrLf
                                End If
                                'End of addition - ShamkantD on 27 Sep 2004

                                'Added by ShamkantD on 29 Sep 2004 - added for Show Revisions page
                        Case CommonFunction.Constants.APP_TAG_TAB_BASELINE_REVISION
                                'Remove the links 
                                Select Case Args.SystemLinkType.ToUpper
                                    'Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD", "SHOW_HISTORY"
                                    Case "ADD_NEW", "DELETE", "SENDAPPROVAL_CLICK", "SELECT_ALL", "SAVE", "SAVE_ADD", "SHOW_HISTORY"
                                        Cancel = True
                                End Select

                                If Args.ClientSideFunctionName.ToUpper() = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close();" & vbCrLf & "return;" & vbCrLf
                                End If
                                'SP3_COPYTEMPLATE
                                '--- Code added by Nilesh on 20 May 2005
                        Case CommonFunction.Constants.APP_TAG_COPY_EXECUTION_TEMPLATE
                                Select Case Args.ClientSideFunctionName.ToUpper
                                    Case "SAVE_ONCLICK"
                                        Dim objstrSB As New System.Text.StringBuilder
                                        '    Args.ToBeInsertedInFunction = " objfrm.action =""CommonPage.aspx?Operation=SAVE&Mode=ADD_NEW&MasterTagID=3029&FromWhere=PM&PagingAlphabet=&ParentTagID=0"""
                                        '    Args.ToBeInsertedInFunction += vbCrLf + " objfrm.submit(); " + vbCrLf
                                        '    Args.ToBeInsertedInFunction += vbCrLf + " return; " + vbCrLf

                                        '***** Code added by SandipL on 24 Nov 2005 
                                        'Purpose :- refresh parent page (Templates list) after copying Template
                                        objstrSB.Append(" var strUrl; " + vbCrLf)
                                        objstrSB.Append(" strUrl = new String();" + vbCrLf)
                                        objstrSB.Append(" " + vbCrLf)
                                        'Modified By NitinVS on 6 Mar 2007 for WhizibleSEM SP8 Regreesion Issues IssueID 11138
                                        ' Added  to handle ' in tempalte name and description 
                                        objstrSB.Append(" var objTemplateName = objfrm.TemplateName.value;" + vbCrLf)
                                        objstrSB.Append(" var objTemplateName = objTemplateName.replace(""/'/g"" , ""\'"");" + vbCrLf)
                                        objstrSB.Append(" var objTemplateDescription = objfrm.TemplateDescription.value;" + vbCrLf)
                                        objstrSB.Append(" var objTemplateDescription = objTemplateDescription.replace(""/'/g"" , ""\'"");" + vbCrLf)
                                        objstrSB.Append(" var objNonDatabase1 = objfrm.NonDatabase1.value;" + vbCrLf)
                                        objstrSB.Append(" var objNonDatabase1 = objNonDatabase1.replace(""/'/g"" , ""\'"");" + vbCrLf)
                                        objstrSB.Append(" strUrl = 'XMLHttp.aspx?TagID=3029&TemplateName='+objTemplateName+'&TemplateDescription='+objTemplateDescription+'&NonDatabase1='+ objNonDatabase1;" + vbCrLf)
                                        'end Modified By NitinVS on 6 Mar 2007 for WhizibleSEM SP8 Regreesion Issues IssueID 11138
                                        objstrSB.Append("if (document.all) " + vbCrLf)
                                        objstrSB.Append(" { " + vbCrLf)
                                        objstrSB.Append(" objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  " + vbCrLf)
                                        objstrSB.Append(" objXHttp.onreadystatechange = HandlerOnReadyState; " + vbCrLf)
                                        objstrSB.Append(" objXHttp.open('GET',strUrl, false); " + vbCrLf)
                                        objstrSB.Append(" objXHttp.send();           " + vbCrLf)
                                        objstrSB.Append(" 	}  " + vbCrLf)
                                        objstrSB.Append("  	else  {" + vbCrLf)
                                        objstrSB.Append(" objXHttp = new XMLHttpRequest();  " + vbCrLf)
                                        objstrSB.Append(" objXHttp.onreadystatechange = HandlerOnReadyState(); " + vbCrLf)
                                        objstrSB.Append("  objXHttp.open('GET',strUrl, false);" + vbCrLf)
                                        objstrSB.Append(" objXHttp.send(null);  }" + vbCrLf)
                                        Args.ToBeInsertedInFunction = objstrSB.ToString()
                                        '***** End addition by SandipL on 24 Nov 2005

                                    Case "CLOSE_ONCLICK"
                                        Args.ToBeInsertedInFunction = "window.close();" & vbCrLf & "return;" & vbCrLf
                                End Select
                                '--- Addition Ends


                                '' START : Commented and Modified by ParagD 14-Sept-2006 : Security Issue 6197 
                                ' added by harshada d for whiziblesem 6.0 issue id 1936 helpdesk Enhancements
                        Case CommonFunction.Constants.APP_TAG_CRM_TASKS_LIST
                                If Args.ClientSideFunctionName.ToUpper = "NEW_ONCLICK" Then
                                    Dim m_strToken As String
                                    m_strToken = CommonFunctions.Security.Token.GetToken(CType(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("CRMQueryID"), "0"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + "0")
                                    '' Args.ToBeInsertedInFunction = "window.location.href='../CRM/CRM_RequestAssignment.aspx?Mode=ASSIGN_TASK&Action=ADD_NEW&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&functionID=" + CType(HttpContext.Current.Request.QueryString("functionID"), String) + "&CRMQueryID=" + CType(HttpContext.Current.Request.QueryString("CRMQueryID"), String) + "';" + vbCrLf
                                    Args.ToBeInsertedInFunction = "window.location.href='../CRM/CRM_RequestAssignment.aspx?Mode=ASSIGN_TASK&Action=ADD_NEW&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&functionID=" + CType(HttpContext.Current.Request.QueryString("functionID"), String) + "&CRMQueryID=" + CType(HttpContext.Current.Request.QueryString("CRMQueryID"), String) + "&PKToken=" + m_strToken + "';" + vbCrLf
                                    '' END : Commented and Modified by ParagD 14-Sept-2006 : Security Issue 6197 
                                    Args.ToBeInsertedInFunction += "return;"
                                End If
                                'end of  addition by harshada d for whiziblesem 6.0 issue id 1936 helpdesk Enhancements


                                '' START : Added by ParagD 25-Sept-2006 : Security Issue 6197 
                        Case CommonFunction.Constants.APP_TAG_PROJECT_TIMESHEET
                                If Args.ClientSideFunctionName.ToUpper = "NEW_ONCLICK" Then
                                    Dim m_strToken As String
                                    m_strToken = CommonFunctions.Security.Token.GetToken(CType(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Session("intProjectID").ToString, "0"), String) + HttpContext.Current.Session("intUserID").ToString + "0" + CommonFunction.Constants.APP_TAG_PROJECT_TIMESHEET.ToString)
                                    Args.ToBeInsertedInFunction = "window.location.href='../PM/PM_Timesheet.aspx?Mode=ADD_NEW&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&PKToken=" + m_strToken + "';" + vbCrLf
                                    '' END : Commented and Modified by ParagD 14-Sept-2006 : Security Issue 6197 
                                    Args.ToBeInsertedInFunction += "return;"
                                End If
                                '' END : Added by ParagD 25-Sept-2006 : Security Issue 6197 

                                'Added for Show Revisions Reason page
                        Case CommonFunction.Constants.APP_TAG_TAB_BASELINE_REVISION_REASON
                                'Remove the links Add and Delete
                                Select Case Args.SystemLinkType.ToUpper
                                    Case "SAVE", "FILTERS", "SHOW_HISTORY"
                                        Cancel = True
                                End Select

                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close();" & vbCrLf & "return;" & vbCrLf
                                End If
                                'End of addition - ShamkantD on 29 Sep 2004

                                'Added by ShamkantD on 5 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_BUSINESS_GROUP
                                Select Case Args.ClientSideFunctionName.ToUpper
                                    Case "SAVE_ONCLICK"
                                        Args.ToBeInsertedInFunction = "var objForm;" + vbCrLf
                                        Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
                                        Args.ToBeInsertedInFunction += "objForm.action='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_BUSINESS_GROUP, String) + " &Action=Save';" + vbCrLf
                                        Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf
                                        Args.ToBeInsertedInFunction += "return;" + vbCrLf

                                    Case "CLOSE_ONCLICK"
                                        Args.ToBeInsertedInFunction = "window.close();" & vbCrLf & "return;" & vbCrLf
                                End Select
                                'End of addition - ShamkantD on 5 Oct 2004

                                'Added by ShamkantD on 6 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_ORGANIZATION_UNIT
                                Select Case Args.ClientSideFunctionName.ToUpper
                                    Case "SAVE_ONCLICK"
                                        Args.ToBeInsertedInFunction = "var objForm;" + vbCrLf
                                        Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
                                        Args.ToBeInsertedInFunction += "objForm.action='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_ORGANIZATION_UNIT, String) + " &Action=Save';" + vbCrLf
                                        Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf
                                        Args.ToBeInsertedInFunction += "return;" + vbCrLf

                                    Case "CLOSE_ONCLICK"
                                        Args.ToBeInsertedInFunction = "window.close();" & vbCrLf & "return;" & vbCrLf
                                End Select

                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_DELIVERY_UNIT
                                Select Case Args.ClientSideFunctionName.ToUpper
                                    Case "SAVE_ONCLICK"
                                        Args.ToBeInsertedInFunction = "var objForm;" + vbCrLf
                                        Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
                                        Args.ToBeInsertedInFunction += "objForm.action='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_DELIVERY_UNIT, String) + " &Action=Save';" + vbCrLf
                                        Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf
                                        Args.ToBeInsertedInFunction += "return;" + vbCrLf

                                    Case "CLOSE_ONCLICK"
                                        Args.ToBeInsertedInFunction = "window.close();" & vbCrLf & "return;" & vbCrLf
                                End Select

                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_DELIVERY_TEAM
                                Select Case Args.ClientSideFunctionName.ToUpper
                                    Case "SAVE_ONCLICK"
                                        Args.ToBeInsertedInFunction = "var objForm;" + vbCrLf
                                        Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
                                        Args.ToBeInsertedInFunction += "objForm.action='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_DELIVERY_TEAM, String) + " &Action=Save';" + vbCrLf
                                        Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf
                                        Args.ToBeInsertedInFunction += "return;" + vbCrLf

                                    Case "CLOSE_ONCLICK"
                                        Args.ToBeInsertedInFunction = "window.close();" & vbCrLf & "return;" & vbCrLf
                                End Select
                                'End of addition - ShamkantD on 6 Oct 2004
                                'Start of addition - JayavantK on 7 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_EXPENSES
                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close(); return;"
                                End If


                                If Args.ClientSideFunctionName.ToUpper = "NEW_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.location.href='CommonPage.aspx?Mode=ADD_NEW&MasterTagID=2170&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&DADate=" + CType(HttpContext.Current.Request.QueryString("DADate"), String) + "';" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;"
                                End If

                                'End of addition - JayavantK on 7 Oct 2004

                                'Added by PrachiK on 19 Feb 2005 for IssueID 15339
                                'Purpose:Validations are not provided on the date field in the TimeSheet Tab for Project Costs.

                                'Modified By NitinVs On 8 Apr 2005 for WhizibleE SP2 
                                'the start date and end date of the selected project is to be considered
                                ' The validation for project end date is to be removed as 
                                ' Expences can occur after project end date.

                                If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                                    Dim strSQL As String
                                    Dim ProjectEndDate As String
                                    Dim ProjectStartDate As String
                                    Dim strProjectID As String

                                    strProjectID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID"), "")

                                    If strProjectID = "" Then
                                        'Modified By VidyaJ on 30th May 2005 - IssueID - 17721
                                        strProjectID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") 'HttpContext.Current.Session("intProjectID").ToString()
                                    End If

                                    If strProjectID <> "0" Then
                                        'strSQL = "select expectedStartdate,expectedenddate from tbl_PM_project where ProjectID= " & HttpContext.Current.Session("intProjectID").ToString
                                        strSQL = "select expectedStartdate,expectedenddate from tbl_PM_project where ProjectID= " & strProjectID

                                        Dim drReader As IDataReader
                                        drReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                        If (drReader.Read) Then
                                            ProjectEndDate = CommonFunction.Dates.GetDate(CType(drReader("expectedenddate"), Date))
                                            ProjectStartDate = CommonFunction.Dates.GetDate(CType(drReader("expectedStartdate"), Date))
                                        End If
                                    CommonFunction.Data.DisposeDataReader(drReader)
                                    ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                    'Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("ProjectDate", "ProjectDate", , , , ProjectEndDate.ToString, , , , , , True, , True)
                                    'Args.ToBeInserted += CommonFunction.HTMLControls.DrawTextBox("StartProjectDate", "StartProjectDate", , , , ProjectStartDate.ToString, , , , , , True, , True)
                                    Args.ToBeInserted = CommonFunction.HTMLControls.DrawTextBox("ProjectDate", "ProjectDate", , , , ProjectEndDate.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
                                    Args.ToBeInserted += CommonFunction.HTMLControls.DrawTextBox("StartProjectDate", "StartProjectDate", , , , ProjectStartDate.ToString, , , , , , True, , True, EnableHTMLEncode:=True)
                                    Args.ToBeInsertedInFunction = "var objtxtEntryDate =GetObjectReference('frmCommonPage','EntryDate');" & vbCrLf
                                        Args.ToBeInsertedInFunction += "var objProjectdate=GetObjectReference('frmCommonPage','ProjectDate');" & vbCrLf
                                        Args.ToBeInsertedInFunction += "var objProjectStartdate=GetObjectReference('frmCommonPage','StartProjectDate');" & vbCrLf
                                        'Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objtxtEntryDate, objProjectdate))  {" & vbCrLf
                                        'Args.ToBeInsertedInFunction += "alert('Please enter Entry Date date less than Project End Date (' + objProjectdate.value + ')');" & vbCrLf
                                        'Args.ToBeInsertedInFunction += "return; }"
                                        Args.ToBeInsertedInFunction += "if (disallowDate1GreaterThanDate2(objProjectStartdate,objtxtEntryDate))  {" & vbCrLf
                                        Args.ToBeInsertedInFunction += "alert('Entry Date should not be less than Project Start Date (' + objProjectStartdate.value + ')');" & vbCrLf
                                        Args.ToBeInsertedInFunction += "return; }"

                                    End If
                                    'End Of Modifications for IssueID-17721

                                End If
                                'End Modification By NitinVS on 8 Apr 2005 for WhizibleE SP2 

                                'End of Addition
                                'added by SachinR   on 12 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_MAIN_DELIVERABLE_TYPES
                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close(); return;"
                                End If


                                'addition end

                                'Added by ShamkantD on 13 Oct 2004 - added for Rate Contract page
                        Case CommonFunction.Constants.APP_TAG_TAB_RATE_CONTRACT
                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close(); " & vbCrLf & "return;" & vbCrLf
                                End If
                                'End of addition - ShamkantD on 13 Oct 2004

                                '##### Onsite Offshore functionality
                        Case CommonFunction.Constants.APP_TAG_EMPLOYEESITEDETAILS
                                'Code Added By VidyaJ on 24th Aug 2004 
                                Select Case Args.LinkName.ToUpper
                                    Case "ADD NEW", "DELETE"
                                        Cancel = True
                                End Select

                                If Args.ClientSideFunctionName.ToUpper = "SITETRANSFER_CLICK" Then
                                    Dim strFunction As String
                                    With Args
                                        .ToBeInsertedInFunction += " var objSiteTransfer;" + vbCrLf
                                        .ToBeInsertedInFunction += " var intctr;" + vbCrLf
                                        .ToBeInsertedInFunction += " var objForm;" + vbCrLf
                                        .ToBeInsertedInFunction += " var objEmpID;" + vbCrLf
                                        .ToBeInsertedInFunction += " var strVal; " + vbCrLf
                                        .ToBeInsertedInFunction += " var bSubmit; " + vbCrLf
                                        .ToBeInsertedInFunction += " bSubmit = false; " + vbCrLf
                                        .ToBeInsertedInFunction += " strVal='';"
                                        .ToBeInsertedInFunction += " objForm = GetFormReference('frmCommonList');" + vbCrLf
                                        .ToBeInsertedInFunction += " objSiteTransfer = GetObjectReference('frmCommonList', 'chkDelete',true); " + vbCrLf
                                        .ToBeInsertedInFunction += " objEmpID = GetObjectReference('frmCommonList', 'EmployeeID',true); " + vbCrLf
                                        .ToBeInsertedInFunction += "    if(objSiteTransfer!=null) " + vbCrLf
                                        .ToBeInsertedInFunction += "    { " + vbCrLf

                                        .ToBeInsertedInFunction += "    if(objSiteTransfer.length == 0)" + vbCrLf
                                        .ToBeInsertedInFunction += "        return;" + vbCrLf

                                        .ToBeInsertedInFunction += "        if(objSiteTransfer.length > 1)" + vbCrLf
                                        .ToBeInsertedInFunction += "        { " + vbCrLf
                                        .ToBeInsertedInFunction += "            for(i=0;i<=objSiteTransfer.length-1;i++)" + vbCrLf
                                        .ToBeInsertedInFunction += "            { " + vbCrLf
                                        .ToBeInsertedInFunction += "                if (objSiteTransfer[i].checked == true) " + vbCrLf
                                        .ToBeInsertedInFunction += "                { " + vbCrLf
                                        .ToBeInsertedInFunction += "                    strVal = strVal + objEmpID[i].value + ','; " + vbCrLf
                                        .ToBeInsertedInFunction += "                    bSubmit = true; " + vbCrLf
                                        .ToBeInsertedInFunction += "                } " + vbCrLf
                                        .ToBeInsertedInFunction += "            } " + vbCrLf
                                        .ToBeInsertedInFunction += "        } " + vbCrLf
                                        .ToBeInsertedInFunction += "        else " + vbCrLf
                                        .ToBeInsertedInFunction += "        { " + vbCrLf
                                        .ToBeInsertedInFunction += "            if (frmCommonList.chkDelete.checked == true) " + vbCrLf
                                        .ToBeInsertedInFunction += "            { " + vbCrLf
                                        .ToBeInsertedInFunction += "                    strVal = strVal + objEmpID[0].value + ','; " + vbCrLf
                                        .ToBeInsertedInFunction += "                    bSubmit = true; " + vbCrLf
                                        .ToBeInsertedInFunction += "            } " + vbCrLf
                                        .ToBeInsertedInFunction += "        } " + vbCrLf
                                        .ToBeInsertedInFunction += " if (bSubmit==true) " + vbCrLf
                                        .ToBeInsertedInFunction += "    {" + vbCrLf
                                        '.ToBeInsertedInFunction += "    alert(strVal);" + vbCrLf
                                        '.ToBeInsertedInFunction += "        window.open('../General/CommonPage.aspx?FromWhere=PM&MasterTagID=2061&Emp=''' + strVal + '''','','resizable=yes,scrollbars=yes,left=' + ((window.screen.width - 600) / 2) + ',top=' + ((window.screen.height - 350)/2) + ',width=800,height=400');" + vbCrLf
                                        .ToBeInsertedInFunction += "        window.open('../General/CommonPage.aspx?FromWhere=PM&MasterTagID=" + CType(CommonFunction.Constants.APP_TAG_SITE_TRANSFER, String) + "&Emp=' + strVal ,'','resizable=yes,scrollbars=yes,left=100,top=100,width=800,height=400');" + vbCrLf
                                        .ToBeInsertedInFunction += "    } " + vbCrLf
                                        .ToBeInsertedInFunction += " else " + vbCrLf
                                        .ToBeInsertedInFunction += " { " + vbCrLf
                                        .ToBeInsertedInFunction += "    alert('Please select at least one employee for site transfer.')  " + vbCrLf
                                        .ToBeInsertedInFunction += "    return; " + vbCrLf
                                        .ToBeInsertedInFunction += " } " + vbCrLf
                                        .ToBeInsertedInFunction += " } " + vbCrLf
                                        .ToBeInsertedInFunction += " return; " + vbCrLf
                                    End With

                                End If
                                'End Addition

                        Case CommonFunction.Constants.APP_TAG_PROJECTSITES
                                'Code Added By VidyaJ on 17th Aug 2004
                                'Check that there can be only 1 offshore site
                                If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then

                                    'Dim objTemplate As WebPages.Template.WhizTemplate
                                    'Create object of the ProjectByNet Template Class
                                    objTemplate = New WebPages.Template.WhizTemplate
                                    'Initialize the Resources

                                    'commented by siddharths on 18 feb 2005
                                    'objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                    ' Dim strOffshoreSite As String = objTemplate.GetResourceString("OFFSHORE_VALIDATION")
                                    'comment ends

                                    'Get current offshore site selected for the project
                                    Dim drProjectSites As IDataReader
                                    Dim intSiteID As Integer
                                    Dim blnOffshoreSelected As Boolean
                                    Dim strUniqueID As String
                                    'Added by Siddharths on 18 feb 2005 
                                    Dim strSqlQuery As String
                                    Dim intResult As Integer = 1
                                    'Added by Siddharths on 22 feb 2005
                                    If Args.PrimaryKeyValue.Trim <> "" Then
                                        strSqlQuery = "select count(*) from v_tbl_PM_ProjectSites where projectid = " + CType(HttpContext.Current.Session("intProjectId"), String) + " and isoffshore=1 and projectsiteid <> " + CType(Args.PrimaryKeyValue, String)
                                        intResult = CType(CommonFunction.Data.GetDataScalar(strSqlQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)
                                    End If
                                    'Modification ends.

                                    'strSqlQuery = "select count(*) from v_tbl_PM_ProjectSites where projectid = " + CType(HttpContext.Current.Session("intProjectId"), String) + " and isoffshore=1 and projectsiteid <> " + CType(Args.PrimaryKeyValue, String)
                                    'intResult = CType(CommonFunction.Data.GetDataScalar(strSqlQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)
                                    'end

                                    'Get Offshore Site ID for this project
                                    drProjectSites = CommonFunction.Data.GetDataReader(" usp_sel_tbl_PM_ProjectSite " + CType(HttpContext.Current.Session("intProjectId"), String) + ",1", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If (drProjectSites.Read) Then
                                        intSiteID = CType(CommonFunction.General.CheckIsNothing(drProjectSites("ProjectSiteID")), Integer)
                                    Else
                                        intSiteID = 0
                                    End If
                                    CommonFunction.Data.DisposeDataReader(drProjectSites)
                                    strUniqueID = Args.PrimaryKeyValue.ToString
                                    If intSiteID <> 0 Then
                                        'For edit mode
                                        If strUniqueID <> intSiteID.ToString Then
                                            With Args
                                                .ToBeInsertedInFunction += " objOffshore = GetObjectReference('frmCommonPage', 'IsOffshore'); " + vbCrLf
                                                'Modified by SiddharthS on 18 Feb 2005 for IssueID 15868
                                                .ToBeInsertedInFunction += " if(objOffshore.checked==true) {if (confirm('On setting this site as an offshore site,offshore site setting of previous site will be removed.')==false) return;}" + vbCrLf ' { alert(' " + strOffshoreSite + "'); return; } " + vbCrLf
                                                'Modification ends.
                                            End With
                                        End If

                                    End If
                                    'Added by Siddharths on 18 Feb 2005 for IssueID 15868
                                    If intResult = 0 Then
                                        Args.ToBeInsertedInFunction += " objOffshore = GetObjectReference('frmCommonPage', 'IsOffshore'); " + vbCrLf
                                        Args.ToBeInsertedInFunction += " if(objOffshore.checked==false) {alert('There must be atleast one offshore site present.');objOffshore.checked==true;return;}" + vbCrLf
                                    End If
                                    'End

                                End If

                                'Commented by siddharths.17 Feb 2005
                                'Code Added By VidyaJ on 24th Aug 2004

                                'Case CommonFunction.Constants.APP_TAG_SITE_TRANSFER 
                                '    'Code Added By VidyaJ on 24th Aug 2004
                                '    If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                                '        With Args
                                '            .ToBeInsertedInFunction += " objresources = GetObjectReference('frmCommonPage', 'NonDatabase1'); " + vbCrLf
                                '            .ToBeInsertedInFunction += " if (objresources != null)" + vbCrLf
                                '            'If Not CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Emp")) Then
                                '            .ToBeInsertedInFunction += "  objresources.value='" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Emp")).ToString + "'" + vbCrLf
                                '            'End If
                                '        End With

                                '    End If

                                '    If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                '        Args.ToBeInsertedInFunction += "window.close();"
                                '        Args.ToBeInsertedInFunction += "return;"
                                '    End If

                                'End .17 Feb 2005

                                'Code Added By VidyaJ on 24th Aug 2004



                        Case CommonFunction.Constants.APP_TAG_SITE_TRANSFER
                                'Code Added By VidyaJ on 24th Aug 2004
                                If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                                    With Args
                                        .ToBeInsertedInFunction += " objresources = GetObjectReference('frmCommonPage', 'NonDatabase1'); " + vbCrLf
                                        .ToBeInsertedInFunction += " if (objresources != null)" + vbCrLf
                                        'If Not CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Emp")) Then
                                        .ToBeInsertedInFunction += "  objresources.value='" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Emp")).ToString + "'" + vbCrLf
                                        'End If
                                        .ToBeInsertedInFunction += " objfrm.action =  ""CommonPage.aspx?Operation=SAVE&Mode=&=&MasterTagID=2253&FromWhere=PM&PagingAlphabet=&ParentTagID=0&Emp=" + CType(HttpContext.Current.Request("Emp"), String) + """" + vbCrLf
                                        .ToBeInsertedInFunction += " objfrm.submit(); return" + vbCrLf

                                    End With

                                End If

                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction += "window.close();"
                                    Args.ToBeInsertedInFunction += "return;"
                                End If
                                'Siddharths



                                'added by SachinR   on 20 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLETYPE_RESOURCE_ACCESS
                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction += "window.close();"
                                    Args.ToBeInsertedInFunction += "return;"
                                End If
                                'addition end

                                'Added By JayavantK On 21-Oct-2004. IssueID = 13512
                        Case CommonFunction.Constants.APP_TAG_CORPORATE_SETTINGS
                                If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                                    objTemplate = New WebPages.Template.WhizTemplate
                                    objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                    'Code Modified by VidyaJ on 10th Feb 2004 - For IssueID - 15937
                                    Args.ToBeInsertedInFunction += " var objAllowResourceAllocation, objResAllocLevel;" + vbCrLf
                                    Args.ToBeInsertedInFunction += " objAllowResourceAllocation = GetObjectReference('frmCommonPage', 'AllowResourceAllocation'); " + vbCrLf
                                    Args.ToBeInsertedInFunction += " if (objAllowResourceAllocation!=null) {"
                                    Args.ToBeInsertedInFunction += " objResAllocLevel = GetObjectReference('frmCommonPage', 'ResourceAllocationLevel'); " + vbCrLf
                                    Args.ToBeInsertedInFunction += " if ((objAllowResourceAllocation.checked == true) && (objResAllocLevel.value == '')){" + vbCrLf
                                    Args.ToBeInsertedInFunction += "  alert('" + objTemplate.GetResourceString("MSG_SELECT_RESOURCEALLOCATION_LEVEL") + "');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "  setFocus(objResAllocLevel); return;}" + vbCrLf
                                    Args.ToBeInsertedInFunction += " } "
                                    ' End of Modification
                                    objTemplate = Nothing
                                End If

                        Case CommonFunction.Constants.APP_TAG_EMPLOYEE_MAINTENANCE
                                'Added by TruptiK on 31-July-2007
                                'Purpose:-To disappear release link when we Collapse section.
                                Dim strKey As String
                                'UserID-LoginType-Identifier-ItemID
                                strKey = HttpContext.Current.Session("intUserID").ToString + "-" + WhizGlobal.LoginType.ToString + "-" + "SECTION_1" + "-" + WhizGlobal.TagID.ToString
                                If CommonEngines.HashTables.GetHashTableObject.GetHashTableUPFCache(strKey) = "0" Then
                                    If Args.ClientSideFunctionName.ToUpper = "RELEASE_ONCLICK" Then
                                        Cancel = True
                                    End If
                                End If
                                'End of addition by TruptiK on 31-July-2007
                                If Args.PrimaryKeyValue <> "" Then
                                    'Added By JyotiG
                                    'Start_JG_30-Nov-2006
                                    HttpContext.Current.Session.Add("EmployeeId", Args.PrimaryKeyValue.ToString)
                                    'End_JG_30-Nov-2006
                                    If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or _
                                    Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
                                        Dim strQuery As String = ""
                                        Dim drEmployee As IDataReader
                                        Dim lngLocationId As Long = 0
                                        Dim lngBGId As Long = 0
                                        Dim blnBGManager As Boolean = False
                                        Dim blnOUManager As Boolean = False
                                        Dim drGetApproverStatus As IDataReader
                                        Dim intCnt As Integer

                                        strQuery = "SELECT ManagerID FROM tbl_CNF_BusinessGroup_Managers WHERE ManagerID = " + Args.PrimaryKeyValue.ToString()
                                        If CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "") <> "" Then
                                            blnBGManager = True
                                        End If

                                        strQuery = "SELECT ManagerID FROM tbl_PM_OUPool_Managers WHERE ManagerID = " + Args.PrimaryKeyValue.ToString()
                                        If CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "") <> "" Then
                                            blnOUManager = True
                                        End If

                                        If blnBGManager = True Or blnOUManager = True Then
                                            strQuery = "SELECT LocationID, BusinessGroupID FROM tbl_PM_Employee WHERE EmployeeID = " + Args.PrimaryKeyValue.ToString()
                                            drEmployee = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                            If CommonFunctions.General.CheckIsNothing(drEmployee, "") <> "" Then
                                                If drEmployee.Read() Then
                                                    lngLocationId = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("LocationID"), "0"), Long)
                                                    lngBGId = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("BusinessGroupID"), "0"), Long)
                                                End If
                                            End If
                                            CommonFunctions.Data.DisposeDataReader(drEmployee)

                                            objTemplate = New WebPages.Template.WhizTemplate
                                            objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                            Args.ToBeInsertedInFunction += " var lngOldBG, lngOldOU, objNewBG, objNewOU;" + vbCrLf
                                            Args.ToBeInsertedInFunction += " lngOldBG = " + lngBGId.ToString() + "; " + vbCrLf
                                            Args.ToBeInsertedInFunction += " lngOldOU = " + lngLocationId.ToString() + "; " + vbCrLf
                                            Args.ToBeInsertedInFunction += " objNewBG = document.getElementById('BusinessGroupID'); " + vbCrLf
                                            Args.ToBeInsertedInFunction += " objNewOU = document.getElementById('LocationID'); " + vbCrLf
                                            If blnOUManager = True Then
                                                Args.ToBeInsertedInFunction += " if (lngOldOU != objNewOU.value){" + vbCrLf
                                                'Integrated By ChaitraliH On 21 May 09
                                                'Purpose: Change in the alert msg for changing the OU of the resource
                                                'Modified by TruptiK on 15-Apr-09
                                                'Purpose:-change in alert message.
                                                'Args.ToBeInsertedInFunction += "  alert('" + objTemplate.GetResourceString("MSG_RESOURCE_OU_CHANGE") + "');" + vbCrLf
                                                Args.ToBeInsertedInFunction += "  alert('Can not change the Organization Unit,as the Resource is assigned as a Manager in the Organization Structure');" + vbCrLf
                                                'End of modification by TrupitK on 15-Apr-09
                                                'End Of Integration By ChaitraliH On 21 May 09
                                                Args.ToBeInsertedInFunction += "  objNewBG.value = lngOldBG; objNewOU.value = lngOldOU; OUPool_OnChange(objNewOU); " + vbCrLf
                                                Args.ToBeInsertedInFunction += "  setFocus(objNewOU); return;}" + vbCrLf
                                            End If
                                            If blnBGManager = True Then
                                                Args.ToBeInsertedInFunction += " if (lngOldBG != objNewBG.value){" + vbCrLf
                                                Args.ToBeInsertedInFunction += "  alert('" + objTemplate.GetResourceString("MSG_RESOURCE_BG_CHANGE") + "');" + vbCrLf
                                                Args.ToBeInsertedInFunction += "  objNewBG.value = lngOldBG;  objNewOU.value = lngOldOU; OUPool_OnChange(objNewOU); " + vbCrLf
                                                Args.ToBeInsertedInFunction += "  setFocus(objNewBG); return;}" + vbCrLf
                                            End If
                                            objTemplate = Nothing
                                        End If

                                        'Commented Code For IssueID - 523 - SP4
                                        'strQuery = "usp_GetStatusOfCorporateReportingTo " + CType(Args.PrimaryKeyValue, String)
                                        'drGetApproverStatus = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                        'If drGetApproverStatus.Read Then
                                        '    intCnt = CType(CommonFunctions.Data.CheckIsDBNull(drGetApproverStatus("Count"), "0"), Integer)
                                        'End If

                                        'If CType(intCnt, Integer) <> 0 Then
                                        '    Args.ToBeInsertedInFunction += "alert('This Approver have pending timesheets for the employee. Please Approve them before changing the Approver.'); return;" + vbCrLf
                                        'End If

                                        '' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                        'CommonFunction.Data.DisposeDataReader(drGetApproverStatus)
                                        '' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                        'Added by MrugajaB on 29th Nov 2006 for Whiziblesem SP8 Issue ID.7182
                                        'Purpose: When 'Release Resource From Projects' link is clicked , it is checked
                                        'whether employee is assigned as approver for timesheet or expensesheets on some projects
                                    ElseIf Args.ClientSideFunctionName.ToUpper = "RELEASE_ONCLICK" Then
                                        Dim strQuery As String = "select status from tbl_Pm_Employee where EmployeeID = " & Args.PrimaryKeyValue.ToString()
                                        Dim strStatus As Boolean = CBool(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, True), "false"))

                                        strQuery = ""
                                        strQuery = "select LeavingDate from tbl_Pm_Employee where EmployeeID = " & Args.PrimaryKeyValue.ToString()
                                        Dim dtLeavingDate As String = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, True)))

                                        Dim intReportingToCount As Integer
                                        strQuery = " Select IsNull(Count(ReportingTo),0) From tbl_PM_Employee Where Status = 0 AND ReportingTo=" & Args.PrimaryKeyValue.ToString() & "  And EmployeeID !=" & Args.PrimaryKeyValue.ToString()
                                        intReportingToCount = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, True), "0"))
                                        'Added or modified by PrashantD on 27 Jan 2008.
                                        Dim isActiveOnProject As Boolean = False
                                        Dim dr As IDataReader
                                        dr = CommonFunction.Data.GetDataReader("usp_Sel_Approvers_List_ToRelease " + Args.PrimaryKeyValue.ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        If dr.Read Then
                                            isActiveOnProject = True
                                        End If
                                        CommonFunction.Data.DisposeDataReader(dr)
                                        '--- added By purvaj on 29 Nov 2008 for whiziblesem 8.0 for release resource when responsible for KM approvals
                                        Dim m_strNewHDworkflowApprover = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_IsHelpDeskWorkflowApprover " + CType(Args.PrimaryKeyValue.ToString, String), True), "0"), "0")
                                        '--- end addition purvaj

                                        If (strStatus = False) Or (dtLeavingDate = "") Then
                                            If intReportingToCount > 0 Then
                                                intReportingToCount = 1
                                            End If
                                            If isActiveOnProject = True Then
                                                Args.ToBeInsertedInFunction += "window.open(""../HR/HR_ApproverToList.aspx?IsRepApprover=" + intReportingToCount.ToString + "&ApproverID=" & Args.PrimaryKeyValue.ToString() & """,""_new"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 900)/2 + "",top="" + (window.screen.height - 650)/2 + "",width=900,height=650""); return;"
                                            ElseIf intReportingToCount > 0 Then
                                                Args.ToBeInsertedInFunction += "window.open(""../HR/HR_ApproverToList.aspx?IsRepApprover=1&ApproverID=" & Args.PrimaryKeyValue.ToString() & """,""_new"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 500)/2 + "",top="" + (window.screen.height - 400)/2 + "",width=500,height=400""); return;"
                                            ElseIf intReportingToCount = 0 And m_strNewHDworkflowApprover <> "1" Then
                                                Args.ToBeInsertedInFunction += "window.open(""../HR/HR_ApproverToList.aspx?IsRepApprover=0&ApproverID=" & Args.PrimaryKeyValue.ToString() & """,""_new"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 400)/2 + "",top="" + (window.screen.height - 200)/2 + "",width=300,height=200""); return;"
                                                '--- added by purvaj on 29 Nov 2008 for whiziblesem 8.0 for release resource when responsible for KM approvals
                                            Else
                                                Args.ToBeInsertedInFunction += "window.open(""../HR/HR_ApproverToList.aspx?IsRepApprover=" + intReportingToCount.ToString + "&ApproverID=" & Args.PrimaryKeyValue.ToString() & """,""_new"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 700)/2 + "",top="" + (window.screen.height - 300)/2 + "",width=700,height=300""); return;"
                                                '--- end addition purvaj
                                            End If
                                            'End of addition or modification by PrashantD on 27 Jan 2008


                                        Else
                                            Cancel = True
                                        End If

                                        'End If
                                        'End of Modification By KapilGK
                                        'End Addition
                                    End If
                                End If
                                'End Addition
                                ' Added by ArchanaN on 25 Jan 2008
                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_CLICK" Then
                                    Cancel = True
                                End If

                                Dim strFor As String
                                strFor = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("For"), "")
                                If strFor.ToUpper = "JOINPOOL" Then
                                    If Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
                                        Cancel = True
                                    End If
                                    If Args.ClientSideFunctionName.ToUpper = "CLOSE_CLICK" Then
                                        Cancel = False
                                    End If

                                    ' To check the Add access of Employee Maintenance and hide save link in Resource Joining Pool
                                    Dim objWebPages As New WebPages.Template.WhizTemplate
                                    Dim objGlobal As WebPages.Template.IGlobal
                                    Dim objAccessRights As WebPages.Security.cAccessRights
                                    objWebPages.FillGlobalObject(objWebPages.CurrentThreadUICultureID)
                                    objGlobal = objWebPages.GlobalObject()
                                    objAccessRights = New WebPages.Security.cAccessRights(objGlobal)
                                    ' objAccessRights.ParentTagID = 2191
                                    objAccessRights.TagID = 23
                                    objAccessRights.GetAccess()

                                    If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                                        If objAccessRights.Add = False Then
                                            Cancel = True
                                        End If

                                        Args.ToBeInsertedInFunction = "var L1 = GetObjectReference('frmCommonPage','SAVEUI_HEAD0-23');if (L1 != null) { L1.style.display= 'none';}var L2 = GetObjectReference('frmCommonPage','SAVE_ADDUI_HEAD0-23');if (L2 != null) { L2.style.display= 'none';}var L3 = GetObjectReference('frmCommonPage','SAVE_CLOSEUI_HEAD0-23');if (L3 != null) { L3.style.display= 'none';}var L1 = GetObjectReference('frmCommonPage','SAVEUI_FOOT0-23');if (L1 != null) { L1.style.display= 'none';}var L2 = GetObjectReference('frmCommonPage','SAVE_ADDUI_FOOT0-23');if (L2 != null) { L2.style.display= 'none';}var L3 = GetObjectReference('frmCommonPage','SAVE_CLOSEUI_FOOT0-23');if (L3 != null) { L3.style.display= 'none';}"
                                        Args.ToBeInsertedInFunction += "objfrm.action='CommonPage.aspx?Operation=SAVE&Mode=ADD_NEW&PKToken=&MasterTagID=23&FromWhere=RM&For=JOINPOOL&PagingAlphabet=-1&AccessFirstTime=0&ParentTagID=0&PagingNumber=1&EmployeeID=" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeID"), "") & "';"
                                        Args.ToBeInsertedInFunction += "objfrm.submit();return;window.close();"
                                        ' Args.ToBeInsertedInFunction += " refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FromWhere=RM&MasterTagID=3873',true); " + vbCrLf
                                    End If
                                End If
                                ' End of Added by ArchanaN on 25 Jan 2008

                        Case CommonFunction.Constants.APP_TAG_GLOBAL_GEN_TASKS, CommonFunction.Constants.APP_TAG_VOIDED_TASKS
                                'Added by DipaliS 
                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close(); return;"
                                End If
                                'End Adddition by DipaliS

                                'Added By NitinVS
                                ' To close the page when ckicked on Clsoe Link in Project settings Pages.
                        Case CommonFunction.Constants.APP_TAG_PROJECT_REVIEW_TYPES
                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close(); return;"
                                End If
                        Case CommonFunction.Constants.APP_TAG_PROJECT_PROPERTIES
                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close(); return;"
                                End If

                        Case CommonFunction.Constants.APP_TAG_PROJECT_SETTINGS
                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close(); return;"
                                End If
                        Case CommonFunction.Constants.APP_TAG_PROJECT_ISSUE_SEVERITY
                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close(); return;"
                                End If
                        Case CommonFunction.Constants.APP_TAG_PROJECT_KEYWORDS
                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close(); return;"
                                End If
                        Case CommonFunction.Constants.APP_TAG_PROJECT_ROOT_CAUSES
                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close(); return;"
                                End If
                        Case CommonFunction.Constants.APP_TAG_PROJECT_KERNELS
                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close(); return;"
                                End If
                        Case CommonFunction.Constants.APP_TAG_PROJECT_OS
                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close(); return;"
                                End If
                        Case CommonFunction.Constants.APP_TAG_PROJECT_VERSIONS
                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close(); return;"
                                End If
                        Case CommonFunction.Constants.APP_TAG_PROJECT_EMAIL_SETTINGS
                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close(); return;"
                                End If

                                'End Addition By NitinVS
                                ' Added By NitinVS on 7 Dec 2004 
                                ' To Clsoe the window for tagID 10004
                        Case CommonFunction.Constants.APP_TAG_SELECT_TEMPLATE_FOR_PROJECT
                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close(); return;"

                                End If
                                'End Addition NitinVS 7 Dec 2004

                                '    'Integrated by MrugajaB on 26th April 2005 for WhizibleSEM SP3
                                'Case CommonFunction.Constants.APP_TAG_REVIEW_PLANNING
                                '    ', CommonFunction.Constants.APP_TAG_Project_FTR
                                '    Dim strQuery As String = ""
                                '    Dim drProjectDetails As IDataReader
                                '    Dim m_strReviewStatus As String = ""

                                '    'Code Added by RajkumarM ONSITE on 21st March 2005 to Disallow Closed Reviews to MOdify
                                '    If Args.PrimaryKeyValue.ToString() <> "" Then
                                '        strQuery = "Select ReviewStatus from tbl_pm_reviewstatistics Where ReviewStatisticsID= " + Args.PrimaryKeyValue.ToString()
                                '        drProjectDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                '        If CommonFunctions.General.CheckIsNothing(drProjectDetails, "") <> "" Then
                                '            If drProjectDetails.Read() Then
                                '                m_strReviewStatus = CType(CommonFunctions.Data.CheckIsDBNull(drProjectDetails("ReviewStatus"), ""), String)
                                '            End If
                                '        End If

                                '        CommonFunctions.Data.DisposeDataReader(drProjectDetails)
                                '    End If
                                '    ' End of Addition ONSITE

                                '    Select Case Args.SystemLinkType.ToUpper
                                '        Case "SAVE", "SAVE_ADD"
                                '            ' Code Added by RajkumarM on 22nd March ONSITE
                                '            If m_strReviewStatus.ToUpper = "CLOSED" Then
                                '                Cancel = True
                                '            End If
                                '            'End of Addition ONSITE
                                '    End Select
                                '    ' Added by RajkumarM on 22nd March ONSITE
                                '    Select Case Args.LinkName.ToUpper
                                '        Case "MAP REVIEW TASKS TO MPP TASKS"
                                '            If m_strReviewStatus.ToUpper = "CLOSED" Then
                                '                Cancel = True
                                '            End If
                                '    End Select
                                '    ' End of Addition ONSITE
                                '    'End Integration

                                'Modified by NitinVS on 26 Apr 2007 for WhizibleSEM SP 8 Regression Fixes Issue 12527 
                                'Added By MrugajaB on 2nd March,2005 for Project document category
                        Case CommonFunction.Constants.APP_TAG_PROJECT_DOCUMENTCATEGORY

                                If Args.ClientSideFunctionName = "Save_OnClick" Then
                                    Dim sbFunction As New System.Text.StringBuilder
                                    sbFunction.Append("var objForm;" + vbCrLf)
                                    sbFunction.Append(" var blnIsRecordSelected=false;")
                                    sbFunction.Append(" if( GetObjectReference('frmCommonList','chkDelete') != null ) { ")
                                    sbFunction.Append(" blnIsRecordSelected=IsCheckboxSelected('frmCommonList','chkDelete');")
                                    sbFunction.Append(" if (blnIsRecordSelected == false) {return;}")
                                    sbFunction.Append(" } " + vbCrLf)
                                    sbFunction.Append(" else return;" + vbCrLf)
                                    sbFunction.Append("objForm = GetFormReference('frmCommonList');" + vbCrLf)
                                    sbFunction.Append("objForm.action='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_PROJECT_DOCUMENTCATEGORY, String) + " &Action=Save';" + vbCrLf)
                                    sbFunction.Append("objForm.submit();" + vbCrLf)
                                    sbFunction.Append("return;" + vbCrLf)
                                    Args.ToBeInsertedInFunction = sbFunction.ToString()
                                    sbFunction = Nothing

                                End If
                                'End Addition
                                ' End Modification  by NitinVS on 26 Apr 2007 for WhizibleSEM SP 8 Regression Fixes Issue 12527 

                                'Added By MrugajaB on 28th March,2005 for Close link of 'Show Project Approvers Page'
                        Case CommonFunction.Constants.APP_TAG_PROJECT_APPROVERS
                                If Args.ClientSideFunctionName.ToUpper() = "CLOSE_ONCLICK" Then
                                    Args.ToBeInsertedInFunction = "window.close();" & vbCrLf & "return;" & vbCrLf
                                End If
                                'End Addition

                                'Added by MrugajaB on 30th April,2005 for integrating PBNV4 SP6 Hotfix ID.4.0.116-WAF in WhizibleSEM Sp3
                        Case CommonFunction.Constants.TAG_AUDIT_TRAIL
                                If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
                                    Dim strFunction As String
                                    strFunction = "window.close();return;"
                                    Args.ToBeInsertedInFunction = strFunction
                                End If
                                'End Addition


                                'Code Integrated by MrugajaB on 4th May,2005 for WhizibleSEM SP3 Task Progress feature
                                ' Code added by SwapnilR on 5th April 2005
                                ' Purpose : To display new page of pending deliverable list
                        Case CommonFunction.Constants.APP_TAG_PENDING_DELIVERABLE_PROGRESS
                                Select Case Args.ClientSideFunctionName.ToUpper.ToString
                                    Case "NEW_ONCLICK"
                                        Dim strSQL As String
                                        Dim strSQLCheck As String
                                        Dim objDr As IDataReader
                                        Dim strFromDate As String
                                        Dim strToDate As String
                                        Dim intCount As Integer
                                        Dim strAuthenticateCheck As String
                                        Dim drAuthenticateCheck As IDataReader
                                        Dim intStatus As Integer

                                        If WhizGlobal.ProjectID.ToString <> "" Then
                                            strSQL = "usp_tbl_PM_PendingProjectDeliverableProgress " + WhizGlobal.ProjectID.ToString
                                            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                                        End If

                                        strAuthenticateCheck = "SELECT CASE COUNT(*) WHEN (SELECT Count(*) FROM tbl_PM_DeliverableProgress WHERE ProjectID = " + WhizGlobal.ProjectID.ToString
                                        strAuthenticateCheck = strAuthenticateCheck + " AND Freezed = 1) THEN 1	ELSE 0 END AS CheckForAuthenticated FROM tbl_PM_DeliverableProgress WHERE ProjectID = "
                                        strAuthenticateCheck = strAuthenticateCheck + WhizGlobal.ProjectID.ToString

                                        drAuthenticateCheck = CommonFunction.Data.GetDataReader(strAuthenticateCheck, True)

                                        If (drAuthenticateCheck.Read) Then
                                            intStatus = CType(CommonFunction.Data.CheckIsDBNull(drAuthenticateCheck("CheckForAuthenticated"), "0"), Integer)
                                            If intStatus = 1 Then

                                                strSQLCheck = "usp_GetPendingDeliverableCount " + WhizGlobal.ProjectID.ToString
                                                objDr = CommonFunction.Data.GetDataReader(strSQLCheck, True)
                                                If objDr.Read Then
                                                    intCount = CType(objDr("Rowcout"), Integer)
                                                    If (intCount = 0) Then
                                                        Args.ToBeInsertedInFunction += "alert('There are no pending deliverable progress');" & vbCrLf
                                                        Args.ToBeInsertedInFunction += "return ;" & vbCrLf
                                                    ElseIf (intCount = 1) Then
                                                        strFromDate = CType(objDr("FromDate"), String)
                                                        strToDate = CType(objDr("ToDate"), String)
                                                        Args.ToBeInsertedInFunction += "window.open(""../PM/PM_DeliverablePercentProgress.aspx?FromDate=" + strFromDate + "&ToDate=" + strToDate + """,'_self')" + vbCrLf
                                                        Args.ToBeInsertedInFunction += "return ;" & vbCrLf
                                                    Else
                                                        Args.ToBeInsertedInFunction += "objfrm.action=""CommonList.aspx?MasterTagID=5030&FromWhere=PM&SortBy=FromDate&SortOrder=ASC""" & vbCrLf
                                                        Args.ToBeInsertedInFunction += "objfrm.submit();" & vbCrLf
                                                        Args.ToBeInsertedInFunction += "return;" & vbCrLf
                                                    End If
                                                Else
                                                    Args.ToBeInsertedInFunction += "objfrm.action=""CommonList.aspx?MasterTagID=5030&FromWhere=PM&SortBy=FromDate&SortOrder=ASC""" & vbCrLf
                                                    Args.ToBeInsertedInFunction += "objfrm.submit();" & vbCrLf
                                                    Args.ToBeInsertedInFunction += "return;" & vbCrLf
                                                End If
                                                ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                                CommonFunction.Data.DisposeDataReader(objDr)
                                                ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                            Else
                                                Args.ToBeInsertedInFunction += "alert('Please approve previously generated deliverable progress');" & vbCrLf
                                                Args.ToBeInsertedInFunction += "return ;" & vbCrLf
                                            End If

                                        End If
                                        ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                        CommonFunction.Data.DisposeDataReader(drAuthenticateCheck)
                                        ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                End Select
                                ' End of addition by SwapnilR on 5th April 2005
                                '    'Added by PradeepD on 03-Apr-05
                        Case CommonFunction.Constants.APP_TAG_PROJECT_PERCENT_PROGRESS
                                Select Case Args.ClientSideFunctionName.ToUpper.ToString
                                    Case "NEW_ONCLICK"
                                        Dim strFunctionBody As String
                                        'Args.SpToExecute = "EXEC usp_Count_tbl_PM_PendingTaskProgress" '+ HttpContext.Current.Session("ProjectID").ToString
                                        Args.ToBeInsertedInFunction += "objfrm.action=""CommonPage.aspx?Operation=PERCENT_PROGRESS&Mode=&MasterTagID=5033&FromWhere=PM""" & vbCrLf
                                        Args.ToBeInsertedInFunction += "objfrm.submit();" & vbCrLf
                                        Args.ToBeInsertedInFunction += "return;" & vbCrLf
                                End Select
                                '    END OF Added by PradeepD on 03-Apr-05

                                'End Addition

                                'Mrugaja
                                'integrated by harshada d on 15th june 2006 
                                'Added by PrajaktaR on 16th May 2006 for WhizibleSEM 6.0.1 IssueID 3736
                        Case CommonFunction.Constants.APP_TAG_COPY_CHECKLIST
                                If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Then
                                    'Purpose :- refresh parent page (Templates list) after copying CheckList
                                    Args.ToBeInsertedInFunction = " var strUrl; " + vbCrLf
                                    Args.ToBeInsertedInFunction += " strUrl = new String();" + vbCrLf
                                    Args.ToBeInsertedInFunction += " " + vbCrLf
                                    Args.ToBeInsertedInFunction += " strUrl = 'XMLHttp.aspx?TagID=3054&CheckListShortName='+objfrm.CheckListShortName.value+'&NonDatabase1='+ objfrm.NonDatabase1.value;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "if (navigator.appName !='Netscape') " + vbCrLf
                                    Args.ToBeInsertedInFunction += " { " + vbCrLf
                                    Args.ToBeInsertedInFunction += " objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  " + vbCrLf
                                    Args.ToBeInsertedInFunction += " objXHttp.onreadystatechange = HandlerOnReadyState; " + vbCrLf
                                    Args.ToBeInsertedInFunction += " objXHttp.open('GET',strUrl, false); " + vbCrLf
                                    Args.ToBeInsertedInFunction += " objXHttp.send();           " + vbCrLf
                                    Args.ToBeInsertedInFunction += " 	}  " + vbCrLf
                                    Args.ToBeInsertedInFunction += "  	else  {" + vbCrLf
                                    Args.ToBeInsertedInFunction += " objXHttp = new XMLHttpRequest();  " + vbCrLf
                                    Args.ToBeInsertedInFunction += " objXHttp.onreadystatechange = HandlerOnReadyState(); " + vbCrLf
                                    Args.ToBeInsertedInFunction += "  objXHttp.open('GET',strUrl, false);" + vbCrLf
                                    Args.ToBeInsertedInFunction += " objXHttp.send(null);" + vbCrLf
                                    Args.ToBeInsertedInFunction += "   }" + vbCrLf
                                    '***** End addition by SandipL on 24 Nov 2005
                                End If
                                'END Of Integration by PrajaktaR on 16th May 2006 for WhizibleSEM 6.0.1 IssueID 3736
                                'end of integration by harshada d on 15th june 2006

                                'Added by MrugajaB on 29th Aug 2006 for WhizibleSEM 6.0.1 IssueID 3736
                                'Purpose:For hiding 'back' Link
                                Select Case Args.SystemLinkType.ToUpper
                                    Case "BACK"
                                        Cancel = True
                                End Select
                                'End Addition

                    End Select

                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID
                        '    'added by harshada d for whizible 6.0 fro issue id 1936 helpdesk
                        'Case CommonFunction.Constants.APP_TAG_TAB_PROJECT_MAPPING
                        '        If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK_TAB" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
                        '            objTemplate = New WebPages.Template.WhizTemplate
                        '            Dim drDefaultProject As IDataReader
                        '            Dim intDefaultProjectID As Integer
                        '            Dim blnDefaultProjectSelected As Boolean
                        '            Dim strUniqueID As String
                        '            'Added by Siddharths on 18 feb 2005 
                        '            Dim strSqlQuery As String
                        '            Dim intResult As Integer = 1
                        '            'Added by Siddharths on 22 feb 2005
                        '            If Args.PrimaryKeyValue.Trim <> "" Then
                        '                strSqlQuery = "select count(*) from tbl_CRM_Function_Projects where functionID = " + Args.MasterPrimaryKeyValue + " and IsDefaultProject=1 and FunctionProjectID <> " + CType(Args.PrimaryKeyValue, String)
                        '                intResult = CType(CommonFunction.Data.GetDataScalar(strSqlQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)
                        '            End If
                        '            drDefaultProject = CommonFunction.Data.GetDataReader(" Select ProjectID frOM tbl_CRM_Function_Projects Where IsDefaultProject = 1 and FunctionID= " + Args.MasterPrimaryKeyValue, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        '            If (drDefaultProject.Read) Then
                        '                intDefaultProjectID = CType(CommonFunction.General.CheckIsNothing(drDefaultProject("ProjectID")), Integer)
                        '            Else
                        '                intDefaultProjectID = 0
                        '            End If
                        '            CommonFunction.Data.DisposeDataReader(drDefaultProject)
                        '            strUniqueID = Args.PrimaryKeyValue.ToString
                        '            If intDefaultProjectID <> 0 Then
                        '                If strUniqueID <> intDefaultProjectID.ToString Then
                        '                    With Args
                        '                        .ToBeInsertedInFunction += " objDefaultProject = GetObjectReference('frmCommonPage', 'IsDefaultProject'); " + vbCrLf
                        '                        .ToBeInsertedInFunction += " if(objDefaultProject.checked==true) {if (confirm('On setting this Project as a Default project,Default project setting of previous project will be removed.')==false) return;}" + vbCrLf
                        '                    End With
                        '                End If
                        '            End If
                        '            If intResult = 0 Then
                        '                Args.ToBeInsertedInFunction += " objDefaultProject = GetObjectReference('frmCommonPage', 'IsDefaultProject'); " + vbCrLf
                        '                Args.ToBeInsertedInFunction += " if(objDefaultProject.checked==false) {alert('There must be atleast one Default Project present.');objOffshore.checked==true;return;}" + vbCrLf
                        '            End If
                        '        End If
                        '        'end of addition by harshada d


                        Case CommonFunction.Constants.APP_TAG_TAB_REVIEW_ACTIONS
                            'Integrated by MrugajaB on 26th April 2005 for WhizibleSEM SP3
                            'Code Added by RajkumarM ONSITE on 21st March 2005 to Disallow Closed Reviews to MOdify
                            Dim strQuery As String = ""
                            Dim drReviewDetails As IDataReader
                            Dim m_strReviewstatisticsID As String
                            Dim m_strReviewStatus As String = ""
                            'Modified by HarshK for sp4 issueid 96 on 13/10/2005
                            Dim strReviewee As String
                            'End Modified by HarshK for sp4 issueid 96 on 13/10/2005

                            'Integrated by MrugajaB on 1st Aug,2005 for WhizibleSEM sp4 Issue ID.96
                            'added by harshada d on 1st Aug 2005 for ALLIANCE issue id 19868 save as task link to be removed if offline review is selected
                            Dim blnIsOfflineReview As Boolean
                            'end of addition by harshada d on 1st Aug 2005 for ALLIANCE issue id 19868 save as task link to be removed if offline review is selected

                            m_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ReviewStatisticsID_PK")
                            If m_strReviewstatisticsID = "" Then
                                m_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ForeignKeyValue")
                            End If
                            If m_strReviewstatisticsID = "" Then
                                m_strReviewstatisticsID = HttpContext.Current.Request("ReviewStatisticsID_PK")
                            End If

                            If m_strReviewstatisticsID <> "" Then
                                'Integrated by MrugajaB on 1st Aug,2005 for WhizibleSEM sp4 Issue ID.96
                                'isOfflineReview field added by harshada d on 1st Aug 2005 for ALLIANCE issue id 19868 save as task link to be removed if offline review is selected
                                'Modified by HarshK for sp4 issueid 96 on 13/10/2005
                                strQuery = "Select ReviewStatus,isOfflineReview,Reviewee from tbl_pm_reviewstatistics Where ReviewStatisticsID= " + m_strReviewstatisticsID
                                'Modified by HarshK for sp4 issueid 96 on 13/10/2005
                                'end of addition by harshada d on 1st Aug 2005 for ALLIANCE issue id 19868 save as task link to be removed if offline review is selected

                                drReviewDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If CommonFunctions.General.CheckIsNothing(drReviewDetails, "") <> "" Then
                                    If drReviewDetails.Read() Then
                                        m_strReviewStatus = CType(CommonFunctions.Data.CheckIsDBNull(drReviewDetails("ReviewStatus"), ""), String)
                                        'Integrated by MrugajaB on 1st Aug,2005 for WhizibleSEM sp4 Issue ID.96
                                        'added by harshada d on 1st Aug 2005 for ALLIANCE issue id 19868 save as task link to be removed if offline review is selected
                                        blnIsOfflineReview = CType(CommonFunctions.Data.CheckIsDBNull(drReviewDetails("isOfflineReview"), "false"), Boolean)
                                        'end of addition by harshada d on 1st Aug 2005 for ALLIANCE issue id 19868 save as task link to be removed if offline review is selected
                                        'Modified by HarshK for sp4 issueid 96 on 13/10/2005
                                        strReviewee = CType(CommonFunctions.Data.CheckIsDBNull(drReviewDetails("Reviewee"), ""), String)
                                        'End Modified by HarshK for sp4 issueid 96 on 13/10/2005
                                    End If
                                End If
                                CommonFunctions.Data.DisposeDataReader(drReviewDetails)
                            End If

                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE_ADD", "SAVE"
                                    If m_strReviewStatus.ToUpper = "CLOSED" Then
                                        Cancel = True
                                    End If

                            End Select

                            Select Case Args.LinkName.ToUpper
                                'Integrated by MrugajaB on 1st Aug,2005 for WhizibleSEM sp4 Issue ID.96
                                'save as task option removed by harshada d on 1st Aug 2005 for ALLIANCE issue id 19868 save as task link to be removed if offline review is selected
                                'Case "SAVE AS ISSUE", "SAVE AS TASK", "ADD OBSERVATION"
                                Case "ADD OBSERVATION"
                                    If m_strReviewStatus.ToUpper = "CLOSED" Then
                                        Cancel = True
                                    End If

                                    'Modified by MrugajaB on 2nd Feb 2006 for Multiple reviewees feature
                                    'Purpose:Save as issue feature will not be available for offline reviews
                                Case "SAVE AS ISSUE"
                                    If m_strReviewStatus.ToUpper = "CLOSED" Then
                                        Cancel = True
                                    ElseIf blnIsOfflineReview = True Then
                                        'If strReviewee = "" Then
                                        objTemplate = New WebPages.Template.WhizTemplate
                                        'Initialize the Resources
                                        objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                        Dim strMsg As String = objTemplate.GetResourceString("MSG_REVIEWEE_NOTSET")
                                        Args.ToBeInsertedInFunction += "alert(""" & strMsg & """); "
                                        Args.ToBeInsertedInFunction += "return;"
                                        objTemplate = Nothing
                                        ' End If
                                    End If
                                    'End Modification

                                    'Integrated by MrugajaB on 1st Aug,2005 for WhizibleSEM sp4 Issue ID.96
                                    'added by harshada d on 1st Aug 2005 for ALLIANCE issue id 19868 save as task link to be removed if offline review is selected
                                    'Modified by HarshK for sp4 issueid 96 on 13/10/2005
                                Case "SAVE AS TASK"
                                    If m_strReviewStatus.ToUpper = "CLOSED" Then
                                        Cancel = True
                                    ElseIf blnIsOfflineReview = True Then
                                        'If strReviewee = "" Then
                                        objTemplate = New WebPages.Template.WhizTemplate
                                        'Initialize the Resources
                                        objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                        Dim strMsg As String = objTemplate.GetResourceString("MSG_REVIEWEE_NOTSET")
                                        Args.ToBeInsertedInFunction += "alert(""" & strMsg & """); "
                                        Args.ToBeInsertedInFunction += "return;"
                                        objTemplate = Nothing
                                        ' End If
                                    End If
                                    'End Modified by HarshK for sp4 issueid 96 on 13/10/2005
                                    'end of addition by harshada d on 1st Aug 2005 for ALLIANCE issue id 19868 save as task link to be removed if offline review is selected
                                    'End Integration

                            End Select
                            ' End of Addition ONSITE by RajkumarM on 21st March 05
                            'End Integration

                            If Args.ClientSideFunctionName.ToLower = "saveasissue" Then
                                Dim strSQLQuery As String = "Exec usp_Sel_tbl_IB_Project_Sub_Type_GetReviewType " + HttpContext.Current.Session("intProjectID").ToString
                                Dim drReview As IDataReader = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                If Not drReview.Read Then
                                    'Review Type is not configured so...exit
                                    'Create object of the ProjectByNet Template Class
                                    objTemplate = New WebPages.Template.WhizTemplate
                                    'Initialize the Resources
                                    objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                    Dim strMsg As String = objTemplate.GetResourceString("REVIEW_ACTION")
                                    Args.ToBeInsertedInFunction += "alert(" + Chr(34) + strMsg + Chr(34) + "); return; " + vbCrLf
                                    objTemplate = Nothing
                                End If
                                CommonFunction.Data.DisposeDataReader(drReview)
                            End If
                            If (Args.ClientSideFunctionName.ToLower = "saveastask" Or Args.ClientSideFunctionName.ToLower = "saveasissue") Then
                                'Validate the form before submitting
                                Args.ToBeInsertedInFunction += "if (!ValidateForm_HeaderSection()) { return;}"

                                If Args.PrimaryKeyValue.Trim = "" Then
                                    'For Review Actions...for the insert mode show the Savve as Task and Save as Issue links by
                                    'ignoring the conditional clause
                                    Args.ConditionClause = ""
                                End If
                            End If
                            'Integrated by MrugajaB on 26th April 2005 for WhizibleSEM SP3
                            ' Code Added by RajkumarM ONSITE on 22nd March 05
                        Case CommonFunction.Constants.APP_TAG_TAB_REVIEW_OBSERVATIONS

                            'Code Added by RajkumarM ONSITE on 21st March 2005 to Disallow Closed Reviews to MOdify
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

                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE_ADD", "SAVE"
                                    If m_strReviewStatus.ToUpper = "CLOSED" Then
                                        Cancel = True
                                    End If

                            End Select

                            Select Case Args.LinkName.ToUpper
                                Case "SAVE AS ISSUE", "SAVE AS TASK", "ADD ACTION"
                                    If m_strReviewStatus.ToUpper = "CLOSED" Then
                                        Cancel = True
                                    End If

                            End Select
                            ' End of Addition


                            ' End of Addition ONSITE
                            'End Integration

                            'Code added by MrugajaB on 31st May 2005
                            'Purpose:To avoid any modifications in FTR if it is closed
                        Case CommonFunction.Constants.APP_TAG_TAB_FASTTRACKREVIEW_ACTIONS
                            'Integrated by MrugajaB on 26th April 2005 for WhizibleSEM SP3
                            'Code Added by RajkumarM ONSITE on 21st March 2005 to Disallow Closed Reviews to MOdify
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

                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE_ADD", "SAVE"
                                    If m_strReviewStatus.ToUpper = "CLOSED" Then
                                        Cancel = True
                                    End If

                            End Select

                            Select Case Args.LinkName.ToUpper
                                Case "SAVE AS ISSUE", "SAVE AS TASK", "ADD OBSERVATION"
                                    If m_strReviewStatus.ToUpper = "CLOSED" Then
                                        Cancel = True
                                    End If

                            End Select

                        Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEREQUEST_SKILLS, CommonFunction.Constants.APP_TAG_TAB_RESOURCEEXTENDREQUEST_SKILLS
                            Dim strSQL As String
                            Dim lngRequestID As Long = 0

                            lngRequestID = CType(CommonFunctions.General.CheckIsNothing("0" & HttpContext.Current.Request("RequestID_PK"), "0"), Long)
                            If lngRequestID > 0 Then
                                strSQL = "SELECT RequestID FROM tbl_PM_ResourceRequest WHERE RequestID = " + lngRequestID.ToString
                                strSQL = strSQL + " AND (STATUS = 'C' OR STATUS = 'REJECT')"
                                If CommonFunctions.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "") <> "" Then
                                    Select Case Args.SystemLinkType.ToUpper
                                        Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD"
                                            Cancel = True
                                    End Select
                                    'Added By JayavantK, On - 26-Aug-2004 - Start
                                Else
                                    Dim intResources As Integer = 0
                                    strSQL = "SELECT Count(EmployeeID) FROM tbl_PM_AssignedResources WHERE Status IN ('L', 'A') AND RequestID=" + lngRequestID.ToString()
                                    intResources = CType(CommonFunctions.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Integer)
                                    If intResources > 0 Then
                                        Select Case Args.SystemLinkType.ToUpper
                                            Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD"
                                                Cancel = True
                                        End Select
                                    End If
                                    'End Addition
                                End If
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEREQUEST_SKILLS_VIEW
                            'Remove the links Add and Delete
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD", "FILTERS", "SHOW_HISTORY", "CONFIGURE", "BACK"
                                    Cancel = True
                            End Select
                        Case CommonFunction.Constants.APP_TAG_TAB_CAPTIONS
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE_ADD"
                                    Cancel = True
                            End Select

                            '' Commented By ParagD On 10-Nov-2005
                            '' Empower - IssueID 20249 - Delete button does not exists on Employee Leave Details

                            'Case CommonFunction.Constants.APP_TAG_TAB_EMPLOYEE_LEAVE_DETAILS
                            '    If Args.SystemLinkType.ToUpper = "DELETE" Or _
                            '            Args.SystemLinkType.ToUpper = "SELECT_ALL" Then     'Added by JayavantK, On 13-Sep-2004
                            '        Cancel = True
                            '    End If

                            '' End of comments By ParagD On 10-Nov-2005
                            'Case CommonFunction.Constants.APP_TAG_TAB_CONFIGURE_RFI_ITEM_ATTRIBUTES
                            '    If Args.SystemLinkType.ToUpper = "DELETE" Then
                            '        Cancel = True
                            '    End If
                            'Added By JayavantK on 30/07/04
                        Case CommonFunction.Constants.APP_TAG_TAB_OUPOOLMASTER_RESOURCE
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SHOW_HISTORY", "SAVE"
                                    Cancel = True
                            End Select

                        Case CommonFunction.Constants.APP_TAG_TAB_OUPOOL_RESOURCE
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SHOW_HISTORY", "SAVE"
                                    Cancel = True
                            End Select
                            'Added by SiddharthS on 7 Apr 2005 for Issue Id 17473
                            'Purpose :When the Employee Rate is changed, the corressponding record is not inserted in Employee site. The Previuos record for the site is updated.
                        Case CommonFunction.Constants.APP_TAG_TAB_SITESROLERATE
                            If Args.ClientSideFunctionName.ToUpper = "UPDATEEMPLOYEERATES" Then
                                With Args
                                    .ToBeInsertedInFunction += " if (confirm('The billing rates will not be updated for the resources for whom the rates are already defined for the current date.')==false) return;" + vbCrLf ' { alert(' " + strOffshoreSite + "'); return; } " + vbCrLf
                                End With
                            End If
                            'End addition.

                            ' Added By JayavantK on 18-Jun-2004 - Start
                        Case CommonFunction.Constants.APP_TAG_TAB_ASSIGNEDRESOURCES
                            If Args.ClientSideFunctionName.ToLower = "assign_onclick" Then
                                Dim strStatus As String = ""
                                Dim lngRequestID As Long = 0
                                Dim strQuery As String = ""

                                lngRequestID = CType(CommonFunctions.General.CheckIsNothing("0" & HttpContext.Current.Request("RequestID_PK"), "0"), Long)
                                strQuery = "Exec usp_Sel_tbl_PM_ResourceRequest_GetStatus " & lngRequestID.ToString()
                                strStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                                If strStatus.Trim().ToUpper() = "C" Or strStatus.Trim().ToUpper() = "REJECT" Then
                                    Cancel = True
                                Else
                                    Dim strFunction As String

                                    objTemplate = New WebPages.Template.WhizTemplate
                                    objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                    strFunction = " var objChkDelete, intIndex=0;" + vbCrLf
                                    strFunction += "objChkDelete = GetObjectReference('frmCommonPage','chkDelete" & CommonFunction.Constants.APP_TAG_TAB_ASSIGNEDRESOURCES.ToString() & "',true);" + vbCrLf
                                    strFunction += "for(intIndex=0; intIndex < objChkDelete.length; intIndex++){" + vbCrLf
                                    strFunction += "    if(objChkDelete[intIndex].checked == true)" + vbCrLf
                                    strFunction += "        break;" + vbCrLf
                                    strFunction += "}" + vbCrLf
                                    strFunction += "if(intIndex == objChkDelete.length){" + vbCrLf
                                    strFunction += "    alert('" + objTemplate.GetResourceString("SELECT_RESOURCE_ASSIGNMENT") + "');" + vbCrLf
                                    strFunction += "    return;" + vbCrLf
                                    strFunction += "}" + vbCrLf
                                    Args.ToBeInsertedInFunction = strFunction
                                    objTemplate = Nothing
                                End If
                            ElseIf Args.ClientSideFunctionName.ToLower = "reject_onclick" Then
                                Dim strStatus As String = ""
                                Dim lngRequestID As Long = 0
                                Dim strQuery As String = ""

                                lngRequestID = CType(CommonFunctions.General.CheckIsNothing("0" & HttpContext.Current.Request("RequestID_PK"), "0"), Long)
                                strQuery = "Exec usp_Sel_tbl_PM_ResourceRequest_GetStatus " & lngRequestID.ToString()
                                strStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                                If strStatus.Trim().ToUpper() = "C" Or strStatus.Trim().ToUpper() = "REJECT" Then
                                    Cancel = True
                                Else
                                    Dim strFunction As String

                                    objTemplate = New WebPages.Template.WhizTemplate
                                    objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                    strFunction = " var objChkDelete, strEmployeeIds, intIndex=0;" + vbCrLf
                                    strFunction += "objChkDelete = GetObjectReference('frmCommonPage','chkDelete" & CommonFunction.Constants.APP_TAG_TAB_ASSIGNEDRESOURCES.ToString() & "',true);" + vbCrLf
                                    strFunction += "strEmployeeIds = '';" + vbCrLf
                                    strFunction += "for(intIndex=0; intIndex < objChkDelete.length; intIndex++){" + vbCrLf
                                    strFunction += "    if(objChkDelete[intIndex].checked == true)" + vbCrLf
                                    strFunction += "        strEmployeeIds = strEmployeeIds + objChkDelete[intIndex].value + ',';" + vbCrLf
                                    strFunction += "}" + vbCrLf
                                    strFunction += "if(strEmployeeIds != ''){" + vbCrLf
                                    strFunction += "    if (! confirm('" + objTemplate.GetResourceString("CONFIRM_REJECT_RESOURCE") + "'))" + vbCrLf
                                    strFunction += "        return;" + vbCrLf
                                    strFunction += "    strEmployeeIds = strEmployeeIds.substr(0,strEmployeeIds.length - 1);" + vbCrLf
                                    strFunction += "    window.open(""../HR/HR_AddComments.aspx?Mode=REJECT_RESOURCE&RequestID=" & lngRequestID.ToString() & "&EmployeeIDs="" + strEmployeeIds,"""",""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 400)/2 + "",width=600,height=400"");" + vbCrLf
                                    strFunction += "}" + vbCrLf
                                    strFunction += "else" + vbCrLf
                                    strFunction += "    alert('" + objTemplate.GetResourceString("SELECT_RESOURCE_REJECT") + "');" + vbCrLf
                                    strFunction += "return;" + vbCrLf
                                    Args.ToBeInsertedInFunction = strFunction
                                    objTemplate = Nothing
                                End If
                            End If
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE"
                                    Cancel = True
                                Case "SELECT_ALL"
                                    Dim strStatus As String = ""
                                    Dim lngRequestID As Long = 0
                                    Dim strQuery As String = ""

                                    lngRequestID = CType(CommonFunctions.General.CheckIsNothing("0" & HttpContext.Current.Request("RequestID_PK"), "0"), Long)
                                    strQuery = "Exec usp_Sel_tbl_PM_ResourceRequest_GetStatus " & lngRequestID.ToString()
                                    strStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                                    If strStatus.Trim().ToUpper() = "C" Or strStatus.Trim().ToUpper() = "REJECT" Then
                                        Cancel = True
                                    End If
                            End Select

                            'Trupti
                            ' Added By JayavantK on 18-Jun-2004 - Start
                        Case CommonFunction.Constants.APP_TAG_TAB_EXTENDASSIGNEDRESOURCES
                            If Args.ClientSideFunctionName.ToLower = "assign_onclick" Then
                                Dim strStatus As String = ""
                                Dim lngRequestID As Long = 0
                                Dim strQuery As String = ""

                                lngRequestID = CType(CommonFunctions.General.CheckIsNothing("0" & HttpContext.Current.Request("RequestID_PK"), "0"), Long)
                                strQuery = "Exec usp_Sel_tbl_PM_ResourceRequest_GetStatus " & lngRequestID.ToString()
                                strStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                                If strStatus.Trim().ToUpper() = "C" Or strStatus.Trim().ToUpper() = "REJECT" Then
                                    Cancel = True
                                Else
                                    Dim strFunction As String

                                    objTemplate = New WebPages.Template.WhizTemplate
                                    objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
'Integration by SanaS on 25-Sep-2009
                                    'Modified By GaneshG On 22-Aug-09 
                                    'Purpose : To allow resouce assignment for future date allocation only after reallocation date arrives
                                    strFunction = " var objChkDelete, intIndex=0;" + vbCrLf
                                    strFunction += "objChkDelete = GetObjectReference('frmCommonPage','chkDelete" & CommonFunction.Constants.APP_TAG_TAB_EXTENDASSIGNEDRESOURCES.ToString() & "',true);" + vbCrLf
                                    strFunction += "objFromDate = GetObjectReference('frmCommonPage','txthidFromDate_' + objChkDelete[0].value);" + vbCrLf
                                    strFunction += "objCurrentDate = GetObjectReference('frmCommonPage','txthidCurrentDate_' + objChkDelete[0].value);" + vbCrLf
                                    strFunction += "for(intIndex=0; intIndex < objChkDelete.length; intIndex++){" + vbCrLf
                                    strFunction += "    if(objChkDelete[intIndex].checked == true)" + vbCrLf
                                    strFunction += "        break;" + vbCrLf
                                    strFunction += "}" + vbCrLf
                                    strFunction += "if(intIndex == objChkDelete.length){" + vbCrLf
                                    strFunction += "    alert('" + objTemplate.GetResourceString("SELECT_RESOURCE_ASSIGNMENT") + "');" + vbCrLf
                                    strFunction += "    return;" + vbCrLf
                                    strFunction += "}" + vbCrLf
                                    strFunction += "if(disallowDate1LessThanDate2(objCurrentDate, objFromDate, 'You can not assign this resource before &#39;' + objFromDate.value + '&#39;')==true)" + vbCrLf
                                    strFunction += "{   return; }" + vbCrLf
                                    Args.ToBeInsertedInFunction = strFunction
                                    objTemplate = Nothing
                                    'End Modification By GaneshG
                                    'End Integration by SanaS on 25-Sep-2009
                                End If
                            ElseIf Args.ClientSideFunctionName.ToLower = "reject_onclick" Then
                                Dim strStatus As String = ""
                                Dim lngRequestID As Long = 0
                                Dim strQuery As String = ""

                                lngRequestID = CType(CommonFunctions.General.CheckIsNothing("0" & HttpContext.Current.Request("RequestID_PK"), "0"), Long)
                                strQuery = "Exec usp_Sel_tbl_PM_ResourceRequest_GetStatus " & lngRequestID.ToString()
                                strStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                                If strStatus.Trim().ToUpper() = "C" Or strStatus.Trim().ToUpper() = "REJECT" Then
                                    Cancel = True
                                Else
                                    Dim strFunction As String

                                    objTemplate = New WebPages.Template.WhizTemplate
                                    objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                    strFunction = " var objChkDelete, strEmployeeIds, intIndex=0;" + vbCrLf
                                    strFunction += "objChkDelete = GetObjectReference('frmCommonPage','chkDelete" & CommonFunction.Constants.APP_TAG_TAB_EXTENDASSIGNEDRESOURCES.ToString() & "',true);" + vbCrLf
                                    strFunction += "strEmployeeIds = '';" + vbCrLf
                                    strFunction += "for(intIndex=0; intIndex < objChkDelete.length; intIndex++){" + vbCrLf
                                    strFunction += "    if(objChkDelete[intIndex].checked == true)" + vbCrLf
                                    strFunction += "        strEmployeeIds = strEmployeeIds + objChkDelete[intIndex].value + ',';" + vbCrLf
                                    strFunction += "}" + vbCrLf
                                    strFunction += "if(strEmployeeIds != ''){" + vbCrLf
                                    strFunction += "    if (! confirm('" + objTemplate.GetResourceString("CONFIRM_REJECT_RESOURCE") + "'))" + vbCrLf
                                    strFunction += "        return;" + vbCrLf
                                    strFunction += "    strEmployeeIds = strEmployeeIds.substr(0,strEmployeeIds.length - 1);" + vbCrLf
                                    strFunction += "    window.open(""../HR/HR_AddComments.aspx?Mode=REJECT_RESOURCE&RequestID=" & lngRequestID.ToString() & "&EmployeeIDs="" + strEmployeeIds,"""",""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 400)/2 + "",width=600,height=400"");" + vbCrLf
                                    strFunction += "}" + vbCrLf
                                    strFunction += "else" + vbCrLf
                                    strFunction += "    alert('" + objTemplate.GetResourceString("SELECT_RESOURCE_REJECT") + "');" + vbCrLf
                                    strFunction += "return;" + vbCrLf
                                    Args.ToBeInsertedInFunction = strFunction
                                    objTemplate = Nothing
                                End If
                            End If
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE"
                                    Cancel = True
                                Case "SELECT_ALL"
                                    Dim strStatus As String = ""
                                    Dim lngRequestID As Long = 0
                                    Dim strQuery As String = ""

                                    lngRequestID = CType(CommonFunctions.General.CheckIsNothing("0" & HttpContext.Current.Request("RequestID_PK"), "0"), Long)
                                    strQuery = "Exec usp_Sel_tbl_PM_ResourceRequest_GetStatus " & lngRequestID.ToString()
                                    strStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                                    If strStatus.Trim().ToUpper() = "C" Or strStatus.Trim().ToUpper() = "REJECT" Then
                                        Cancel = True
                                    End If
                            End Select
                            'End

                        Case CommonFunction.Constants.APP_TAG_TAB_CLOSEREQUEST, CommonFunction.Constants.APP_TAG_TAB_CLOSEEXTENDREQUEST
                            If Args.ClientSideFunctionName.ToLower = "closerequest_onclick" Then
                                Dim strStatus As String = ""
                                Dim lngRequestID As Long = 0
                                Dim strQuery As String = ""

                                lngRequestID = CType(CommonFunctions.General.CheckIsNothing("0" & HttpContext.Current.Request("RequestID_PK"), "0"), Long)
                                strQuery = "Exec usp_Sel_tbl_PM_ResourceRequest_GetStatus " & lngRequestID.ToString()
                                strStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                                If strStatus.Trim().ToUpper() = "C" Then
                                    Cancel = True
                                Else
                                    Dim strFunction As String = ""
                                    Dim strMsg As String = ""
                                    Dim intMaxlength As Integer = 1500

                                    objTemplate = New WebPages.Template.WhizTemplate
                                    objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                    strMsg = objTemplate.GetResourceString("BLANK_COMMENTS", False)
                                    strFunction = "objComments = GetObjectReference('frmCommonPage', 'CancelComment');" + vbCrLf
                                    strFunction += "if (disallowBlank(objComments, '" + strMsg + "', true))" + vbCrLf
                                    strFunction += "    return;"
                                    strMsg = objTemplate.GetResourceString("COMMENTS_MAXLENGTH", False)
                                    strMsg = strMsg.Replace("<=>", intMaxlength.ToString())
                                    strFunction += "if (disallowMaxlengthViolation(objComments, " & intMaxlength.ToString() & ", '" + strMsg + "', true))" + vbCrLf
                                    strFunction += "    return;"
                                    strFunction += "if (! confirm(""" + objTemplate.GetResourceString("CONFIRM_CLOSED_REQUEST", False) + """))" + vbCrLf
                                    strFunction += "    return;"
                                    Args.ToBeInsertedInFunction = strFunction
                                    objTemplate = Nothing
                                End If
                            End If
                            Select Case Args.SystemLinkType.ToUpper
                                Case "SHOW_HISTORY", "SAVE"
                                    Cancel = True
                            End Select

                        Case CommonFunction.Constants.APP_TAG_TAB_DECLINECOMMENTS, CommonFunction.Constants.APP_TAG_TAB_DECLINEEXTENDCOMMENTS
                            Select Case Args.SystemLinkType.ToUpper
                                Case "SAVE", "SHOW_HISTORY"
                                    Cancel = True
                            End Select

                        Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEPOOL_RESOURCES
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SHOW_HISTORY", "SAVE"
                                    Cancel = True
                            End Select

                        Case CommonFunction.Constants.APP_TAG_TAB_TEAMPOOL_RESOURCES
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SHOW_HISTORY", "SAVE"
                                    Cancel = True
                            End Select

                            'Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEPOOL_TEAM
                            '    Select Case Args.SystemLinkType.ToUpper
                            '        Case "ADD_NEW", "DELETE", "SELECT_ALL", "SHOW_HISTORY", "SAVE"
                            '            Cancel = True
                            '    End Select

                            'Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEPOOL_MANAGER
                            '    Select Case Args.SystemLinkType.ToUpper
                            '        Case "ADD_NEW", "DELETE", "SELECT_ALL", "SHOW_HISTORY", "SAVE"
                            '            Cancel = True
                            '    End Select

                        Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEPOOL_RESOURCE
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SHOW_HISTORY", "SAVE"
                                    Cancel = True
                            End Select

                            'End of addition
                            ' Added By JayavantK on 31-Jul-2004 - Start
                        Case CommonFunction.Constants.APP_TAG_TAB_BUSINESSGROUP_RESOURCES
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SHOW_HISTORY", "SAVE"
                                    Cancel = True
                            End Select
                            'End of addition

                            'added by SachinR   on 31 Jul 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_PROCESS_PHASETASK_TEMPLATES
                            'here client side script added to validate the effort for it should not 
                            'exceed the balance effort limit for the template
                            If Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then

                                Dim strSQL As String
                                Dim strTemplateID As String
                                Dim strUniqueID As String
                                Dim dblBalanceEffort As Double
                                Dim objDr As IDataReader
                                Dim strClientScript As String
                                Dim blnEffortDistributionByPercentage As Boolean = False
                                'Create object of the ProjectByNet Template Class and Initialize the Resources
                                objTemplate = New WebPages.Template.WhizTemplate
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                strTemplateID = HttpContext.Current.Request("ForeignKeyValue") + ""
                                strUniqueID = HttpContext.Current.Request("UniqueID_PK") + ""

                                strSQL = "usp_Sel_tbl_PRS_PhaseTask_Template_BalanceEffort " + strTemplateID.Trim
                                If strUniqueID <> "" Then
                                    strSQL += "," + strUniqueID.Trim
                                End If
                                dblBalanceEffort = 0
                                objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If objDr.Read Then
                                    dblBalanceEffort = CType(CommonFunction.Data.CheckIsDBNull(objDr("BalanceEffort"), "0"), Double)
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)

                                blnEffortDistributionByPercentage = True
                                strSQL = "usp_sel_tbl_PRS_PhaseTask_Template " + strTemplateID.Trim
                                objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If objDr.Read Then
                                    blnEffortDistributionByPercentage = CType(CommonFunction.Data.CheckIsDBNull(objDr("PercentageEffortDistribution"), "0"), Boolean)
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)

                                strClientScript = " var objTxt=GetObjectReference('frmCommonPage','Effort'); " + vbCrLf
                                strClientScript += "var dblEffort=Number(objTxt.value);" + vbCrLf
                                strClientScript += "if(dblEffort > " + dblBalanceEffort.ToString + ")" + vbCrLf
                                strClientScript += "{" + vbCrLf
                                strClientScript += "alert('"
                                If blnEffortDistributionByPercentage = True Then
                                    strClientScript += objTemplate.GetResourceString("PHASE_EFFORT_EXCEEDS_PERCENT")
                                Else
                                    strClientScript += objTemplate.GetResourceString("PHASE_EFFORT_EXCEEDS_HOURS")
                                End If
                                strClientScript += "');" + vbCrLf
                                strClientScript += "return;" + vbCrLf
                                strClientScript += "}" + vbCrLf
                                Args.ToBeInsertedInFunction = strClientScript

                                objTemplate = Nothing
                            End If
                            'addition end
                            ' Added By NitinVS on 14 Dec 2004 
                            ' to 'here client side script added to validate the effort for it should not 
                            'exceed the balance effort limit for the template
                            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK_TAB" Then

                                Dim strSQL As String
                                Dim strTemplateID As String
                                Dim strUniqueID As String
                                Dim dblBalanceEffort As Double
                                Dim objDr As IDataReader
                                Dim strClientScript As String
                                Dim blnEffortDistributionByPercentage As Boolean = False
                                'Create object of the ProjectByNet Template Class and Initialize the Resources
                                objTemplate = New WebPages.Template.WhizTemplate
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                strTemplateID = HttpContext.Current.Request("ForeignKeyValue") + ""
                                strUniqueID = HttpContext.Current.Request("UniqueID_PK") + ""

                                strSQL = "usp_Sel_tbl_PRS_PhaseTask_Template_BalanceEffort " + strTemplateID.Trim
                                If strUniqueID <> "" Then
                                    strSQL += "," + strUniqueID.Trim
                                End If
                                dblBalanceEffort = 0
                                objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If objDr.Read Then
                                    dblBalanceEffort = CType(CommonFunction.Data.CheckIsDBNull(objDr("BalanceEffort"), "0"), Double)
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)

                                blnEffortDistributionByPercentage = True
                                strSQL = "usp_sel_tbl_PRS_PhaseTask_Template " + strTemplateID.Trim
                                objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If objDr.Read Then
                                    blnEffortDistributionByPercentage = CType(CommonFunction.Data.CheckIsDBNull(objDr("PercentageEffortDistribution"), "0"), Boolean)
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)

                                strClientScript = " var objTxt=GetObjectReference('frmCommonPage','Effort'); " + vbCrLf
                                strClientScript += "var dblEffort=Number(objTxt.value);" + vbCrLf
                                strClientScript += "if(dblEffort > " + dblBalanceEffort.ToString + ")" + vbCrLf
                                strClientScript += "{" + vbCrLf
                                strClientScript += "alert('"
                                If blnEffortDistributionByPercentage = True Then
                                    strClientScript += objTemplate.GetResourceString("PHASE_EFFORT_EXCEEDS_PERCENT")
                                Else
                                    strClientScript += objTemplate.GetResourceString("PHASE_EFFORT_EXCEEDS_HOURS")
                                End If
                                strClientScript += "');" + vbCrLf
                                strClientScript += "return;" + vbCrLf
                                strClientScript += "}" + vbCrLf
                                Args.ToBeInsertedInFunction = strClientScript

                                objTemplate = Nothing
                            End If
                            'addition end NitinVS on 14 Dec 2004


                            ' Added By JayavantK on 4-Aug-2004 - Start
                        Case CommonFunction.Constants.APP_TAG_TAB_BGPOOL_RESOURCE
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SHOW_HISTORY", "SAVE"
                                    Cancel = True
                            End Select
                            'End of addition
                            'Added By NileshD on 12 August 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_CONTRACT_VIEW_ATTACHMENT
                            Select Case Args.SystemLinkType.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SHOW_HISTORY", "SAVE"
                                    Cancel = True
                            End Select
                            'End Of Addition
                            ' Added By JayavantK on 20-Aug-2004 - Start
                        Case CommonFunction.Constants.APP_TAG_TAB_TRAINING_RESOURCES
                            Select Case Args.SystemLinkType.ToUpper
                                Case "SAVE", "SAVE_ADD"
                                    Dim strQuery As String = ""
                                    Dim drProjectDetails As IDataReader
                                    Dim strProjectStartDate As String = ""
                                    Dim strProjectEndDate As String = ""
                                    'Create object of the ProjectByNet Template Class
                                    objTemplate = New WebPages.Template.WhizTemplate
                                    'Initialize the Resources
                                    objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                    strQuery = "SELECT ExpectedStartDate, ExpectedEndDate FROM tbl_PM_Project WHERE ProjectID = " & HttpContext.Current.Session("intProjectID").ToString
                                    drProjectDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If drProjectDetails.Read() Then
                                        strProjectStartDate = CommonFunctions.General.CheckIsNothing(drProjectDetails.Item("ExpectedStartDate"), "")
                                        strProjectEndDate = CommonFunctions.General.CheckIsNothing(drProjectDetails.Item("ExpectedEndDate"), "")
                                        If strProjectStartDate <> "" Then strProjectStartDate = CommonFunctions.Dates.GetDate(CType(strProjectStartDate, Date))
                                        If strProjectEndDate <> "" Then strProjectEndDate = CommonFunctions.Dates.GetDate(CType(strProjectEndDate, Date))
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(drProjectDetails)

                                    Args.ToBeInsertedInFunction = " var strMsg, dtProjectStartDate,  dtProjectEndDate;" + vbCrLf
                                    Args.ToBeInsertedInFunction = " var dtCurrentStartDate,  dtCurrentEndDate;" + vbCrLf
                                    Args.ToBeInsertedInFunction = " var objCurrentStartDate,  objCurrentEndDate;" + vbCrLf
                                    Args.ToBeInsertedInFunction += "dtProjectStartDate = getDate('" & strProjectStartDate & "');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "dtProjectEndDate = getDate('" & strProjectEndDate & "');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "objCurrentStartDate = GetObjectReference('frmCommonPage','StartDate');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "dtCurrentStartDate = getDate(objCurrentStartDate.value);" + vbCrLf
                                    Args.ToBeInsertedInFunction += "objCurrentEndDate = GetObjectReference('frmCommonPage','EndDate');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "dtCurrentEndDate = getDate(objCurrentEndDate.value);" + vbCrLf
                                    Args.ToBeInsertedInFunction += "if((dtProjectStartDate != null) && (dtProjectEndDate != null) && (dtCurrentStartDate != null) && (dtCurrentEndDate != null)){" + vbCrLf
                                    Args.ToBeInsertedInFunction += "if((dtCurrentStartDate < dtProjectStartDate) || (dtCurrentEndDate > dtProjectEndDate)){" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strMsg='" & objTemplate.GetResourceString("DATES_BETWEEN_PROJECTDATES") & "';" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strMsg = replaceSubstring(strMsg, '<=>', '" & strProjectStartDate & "');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "strMsg = replaceSubstring(strMsg, '<==>', '" & strProjectEndDate & "');" + vbCrLf
                                    Args.ToBeInsertedInFunction += "alert(strMsg);" + vbCrLf
                                    Args.ToBeInsertedInFunction += "return;}}" + vbCrLf

                                    objTemplate = Nothing
                            End Select
                            'End of addition


                            'Added For Check List Items Sub Tag
                        Case CommonFunction.Constants.APP_TAG_TAB_CHECKLIST_ITEMS
                            If Args.SystemLinkType.ToUpper = "ADD_NEW" Then
                                'Args.ToBeInsertedInFunction = "    window.open('CommonList.aspx?MasterTagID=" + CType(CommonFunction.Constants.APP_TAG_QUESTION_SELECTION_LIST, String) + "&QuestionireID=" + CType(HttpContext.Current.Request.QueryString("QuestionnaireID_PK"), String) + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=100,top=100,width=600,height=400');" + vbCrLf
                                Args.ToBeInsertedInFunction = "    window.open('CommonList.aspx?MasterTagID=" + CType(CommonFunction.Constants.APP_TAG_QUESTION_SELECTION_LIST, String) + "&QuestionireID=" + CType(Args.MasterPrimaryKeyValue, String) + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=100,top=100,width=600,height=400');" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;"

                            End If
                            'End Additon

                            'Added by ShamkantD on 25th Aug 2004
                        Case CommonFunction.Constants.APP_SUB_TAG_CHECKLIST_ITEMS
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SHOW_HISTORY", "SAVE"
                                    Cancel = True
                            End Select
                            'End Of addition - ShamkantD on 25th Aug 2004
                            ''integration by harshada d on 15th june 2006
                            '		 'Integrated by PrajaktaR on 12th May 2006 for WhizibleSEM 6.0.1 IssueID 3736
                            '                     '---Added by harshk on 20/07/2005
                            '                     '---If checklist is inherited then disable delete
                        Case CommonFunction.Constants.APP_TAG_TAB_PROJECT_CHECKLISTITEM
                            Dim drIsInherited As IDataReader
                            Dim strSQLQuery As String
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD"
                                    strSQLQuery = "EXEC usp_Sel_tbl_PM_WorkOrderChecklist_IsInherited " & Args.MasterPrimaryKeyValue.ToString
                                    drIsInherited = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
                                    If drIsInherited.Read Then
                                        Cancel = True
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(drIsInherited)
                            End Select
                            '---End Added by harshk on 20/07/2005

                            'Mrugaja
                            '---Added by harshk on 22/07/2005
                            '---If checklist is inherited then disable delete
                        Case CommonFunction.Constants.APP_TAG_TAB_PROJECT_CHECKLIST_SECTIONS
                            Dim drIsInherited As IDataReader
                            Dim strSQLQuery As String
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL", "SAVE", "SAVE_ADD"
                                    strSQLQuery = "EXEC usp_Sel_tbl_PM_WorkOrderChecklist_IsInherited " & Args.MasterPrimaryKeyValue.ToString
                                    drIsInherited = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
                                    If drIsInherited.Read Then
                                        Cancel = True
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(drIsInherited)
                            End Select
                            '                     '---End Added by harshk on 22/07/2005
                            '                     'END Of integration by PrajaktaR on 12th May 2006 for WhizibleSEM 6.0.1 IssueID 3736
                            '                     'end of integration by harshada d on 15th june 2006
                        Case CommonFunction.Constants.APP_TAG_TAB_TASKTYPE
                            If Args.IsListPageLink = False Then
                                Args.CommonQueryString = TaskType_GetQueryString(Args.CommonQueryString)
                            End If
                            'Added By VidyaJ on 10th Feb 2005 - For IssueID - 15374
                        Case CommonFunction.Constants.APP_TAG_TAB_FASTTRACKREVIEW_ISSUES
                            Select Case Args.SystemLinkType.Trim.ToUpper
                                Case "ADD_NEW", "DELETE", "SELECT_ALL"
                                    Cancel = True
                            End Select
                            'End of Addition

                            ' Added By NitinVS on 8 March 2005 for WhizibleE SP2
                            ' Mulitiple level of Document 

                        Case CommonFunction.Constants.APP_TAG_TAB_MILESTONE_DOCUMENTS

                            If Args.LinkName.ToUpper = "UPLOAD DOCUMENT" Then
                                'Modified By VidyaJ - Security issue - 6197
                                Dim strToken As String
                                Dim strParentToken As String
                                If HttpContext.Current.Request.QueryString("PkToken") Is Nothing Then
                                    strParentToken = HttpContext.Current.Request.Form("PkToken") & ""
                                Else
                                    strParentToken = HttpContext.Current.Request.QueryString("PkToken") & ""
                                End If

                                strToken = CommonFunctions.Security.Token.GetToken(Args.MasterPrimaryKeyValue.ToString + CType(HttpContext.Current.Session("intUserID"), String) + "0" + WhizGlobal.ParentTagID.ToString)
                                'Commented and Added by NitinC on 07 April 2011 for WhizibleSEM 10.0
                                'Args.ToBeInsertedInFunction = "window.open(""../PM/PM_ProjectDocuments.aspx?ParentToken=" + strParentToken + "&PKToken=" + strToken + "&Mode=UPLOAD&MasterTagID=34&FromWhere=PM&UniqueID=" + Args.MasterPrimaryKeyValue.ToString + ""","""",""resizable=yes,menubar=no,scrollbars=no,left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=400"");" + vbCrLf
                                'Added and Commented By Vidya J On 28/11/2015 
                                'Args.ToBeInsertedInFunction = "window.open(""../PM/PM_ProjectDocuments.aspx?ParentToken=" + strParentToken + "&PKToken=" + strToken + "&Mode=UPLOAD&MasterTagID=34&FromWhere=PM&UniqueID=" + Args.MasterPrimaryKeyValue.ToString + ""","""",""resizable=yes,menubar=no,scrollbars=no,,channelmode=yes,left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=400"");" + vbCrLf
                                Args.ToBeInsertedInFunction = "window.open(""../PM/PM_ProjectDocuments.aspx?ParentToken=" + strParentToken + "&PKToken=" + strToken + "&Mode=UPLOAD&MasterTagID=34&FromWhere=PM&UniqueID=" + Args.MasterPrimaryKeyValue.ToString + ""","""",""resizable=yes,menubar=no,scrollbars=no,,channelmode=yes,fullscreen=no,left="" + (window.screen.width-550)/2 + "",top="" + (window.screen.height-400)/2 + "",width=550,height=400, '_blank'"");" + vbCrLf
                                'End of Added and Commented By Vidya J On 28/11/2015 
                                'End of Commented and Added by NitinC on 07 April 2011 for WhizibleSEM 10.0
                                Args.ToBeInsertedInFunction += "return;"
                            End If

                            If Args.ClientSideFunctionName.ToUpper = "ATTACHURL_ONCLICK" Then
                                'Modified By VidyaJ - Security issue - 6197
                                Dim strToken As String
                                Dim strParentToken As String
                                If HttpContext.Current.Request.QueryString("PkToken") Is Nothing Then
                                    strParentToken = HttpContext.Current.Request.Form("PkToken") & ""
                                Else
                                    strParentToken = HttpContext.Current.Request.QueryString("PkToken") & ""
                                End If

                                strToken = CommonFunctions.Security.Token.GetToken(Args.MasterPrimaryKeyValue.ToString + CType(HttpContext.Current.Session("intUserID"), String) + "0" + WhizGlobal.ParentTagID.ToString)

                                Args.ToBeInsertedInFunction += " window.open(""../PM/PM_ProjectDocuments.aspx?ParentToken=" + strParentToken + "&PKToken=" + strToken + "&Mode=URL&MasterTagID=34&FromWhere=PM&UniqueID=" + Args.MasterPrimaryKeyValue.ToString + ""","""",""resizable=yes,menubar=no,scrollbars=no,left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=350""); return; "
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_REVIEW_DOCUMENTS
                            If Args.LinkName.ToUpper = "UPLOAD DOCUMENT" Then
                                'Modified By VidyaJ - Security issue - 6197
                                Dim strToken As String
                                Dim strParentToken As String
                                If HttpContext.Current.Request.QueryString("PkToken") Is Nothing Then
                                    strParentToken = HttpContext.Current.Request.Form("PkToken") & ""
                                Else
                                    strParentToken = HttpContext.Current.Request.QueryString("PkToken") & ""
                                End If

                                strToken = CommonFunctions.Security.Token.GetToken(Args.MasterPrimaryKeyValue.ToString + CType(HttpContext.Current.Session("intUserID"), String) + "0" + WhizGlobal.ParentTagID.ToString)
                                'Commented and Added by NitinC on 07 April 2011 for WhizibleSEM 10.0

                                'Added by Dhanashri S ON 1st Sept 2014  Purpose:WhizibleSEM-SP2 upgrade
                                Args.ToBeInsertedInFunction = "window.open(""../PM/PM_ProjectDocuments.aspx?ParentToken=" + strParentToken + "&PKToken=" + strToken + "&Mode=UPLOAD&MasterTagID=1026&FromWhere=PM&UniqueID=" + Args.MasterPrimaryKeyValue.ToString + ""","""",""resizable=yes,menubar=no,scrollbars=no,left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=400"");" + vbCrLf
                                'Args.ToBeInsertedInFunction = "window.open(""../PM/PM_ProjectDocuments.aspx?ParentToken=" + strParentToken + "&PKToken=" + strToken + "&Mode=UPLOAD&MasterTagID=34&FromWhere=PM&UniqueID=" + Args.MasterPrimaryKeyValue.ToString + ""","""",""resizable=yes,menubar=no,scrollbars=no,,channelmode=yes,left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=400"");" + vbCrLf
                                'End of Addition by Dhanashri S ON 1st Sept 2014

                                'End of Commented and Added by NitinC on 07 April 2011 for WhizibleSEM 10.0
                                Args.ToBeInsertedInFunction += "return;"
                            End If

                            If Args.ClientSideFunctionName.ToUpper = "ATTACHURL_ONCLICK" Then
                                'Modified By VidyaJ - Security issue - 6197
                                Dim strToken As String
                                Dim strParentToken As String
                                If HttpContext.Current.Request.QueryString("PkToken") Is Nothing Then
                                    strParentToken = HttpContext.Current.Request.Form("PkToken") & ""
                                Else
                                    strParentToken = HttpContext.Current.Request.QueryString("PkToken") & ""
                                End If

                                strToken = CommonFunctions.Security.Token.GetToken(Args.MasterPrimaryKeyValue.ToString + CType(HttpContext.Current.Session("intUserID"), String) + "0" + WhizGlobal.ParentTagID.ToString)
                                Args.ToBeInsertedInFunction += " window.open(""../PM/PM_ProjectDocuments.aspx?ParentToken=" + strParentToken + "&PKToken=" + strToken + "&Mode=URL&MasterTagID=1026&FromWhere=PM&UniqueID=" + Args.MasterPrimaryKeyValue.ToString + ""","""",""resizable=yes,menubar=no,scrollbars=no,left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=350""); return; "
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_CHANGE_REQUEST_DOCUMENTS
                            If Args.LinkName.ToUpper = "UPLOAD DOCUMENT" Then
                                'Modified By VidyaJ - Security issue - 6197
                                Dim strToken As String
                                Dim strParentToken As String
                                If HttpContext.Current.Request.QueryString("PkToken") Is Nothing Then
                                    strParentToken = HttpContext.Current.Request.Form("PkToken") & ""
                                Else
                                    strParentToken = HttpContext.Current.Request.QueryString("PkToken") & ""
                                End If

                                strToken = CommonFunctions.Security.Token.GetToken(Args.MasterPrimaryKeyValue.ToString + CType(HttpContext.Current.Session("intUserID"), String) + "0" + WhizGlobal.ParentTagID.ToString)

                                Args.ToBeInsertedInFunction = "window.open(""../PM/PM_ProjectDocuments.aspx?ParentToken=" + strParentToken + "&PKToken=" + strToken + "&Mode=UPLOAD&MasterTagID=1039&FromWhere=PM&UniqueID=" + Args.MasterPrimaryKeyValue.ToString + ""","""",""resizable=yes,menubar=no,scrollbars=no,left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=400"");" + vbCrLf
                                Args.ToBeInsertedInFunction += "return;"
                            End If

                            If Args.ClientSideFunctionName.ToUpper = "ATTACHURL_ONCLICK" Then
                                'Modified By VidyaJ - Security issue - 6197
                                Dim strToken As String
                                Dim strParentToken As String
                                If HttpContext.Current.Request.QueryString("PkToken") Is Nothing Then
                                    strParentToken = HttpContext.Current.Request.Form("PkToken") & ""
                                Else
                                    strParentToken = HttpContext.Current.Request.QueryString("PkToken") & ""
                                End If

                                strToken = CommonFunctions.Security.Token.GetToken(Args.MasterPrimaryKeyValue.ToString + CType(HttpContext.Current.Session("intUserID"), String) + "0" + WhizGlobal.ParentTagID.ToString)

                                Args.ToBeInsertedInFunction += " window.open(""../PM/PM_ProjectDocuments.aspx?ParentToken=" + strParentToken + "&PKToken=" + strToken + "&Mode=URL&MasterTagID=1039&FromWhere=PM&UniqueID=" + Args.MasterPrimaryKeyValue.ToString + ""","""",""resizable=yes,menubar=no,scrollbars=no,left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=350""); return; "
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_PHASE_DOCUMENTS
                            If Args.LinkName.ToUpper = "UPLOAD DOCUMENT" Then
                                'Modified By VidyaJ - Security issue - 6197
                                Dim strToken As String
                                Dim strParentToken As String
                                If HttpContext.Current.Request.QueryString("PkToken") Is Nothing Then
                                    strParentToken = HttpContext.Current.Request.Form("PkToken") & ""
                                Else
                                    strParentToken = HttpContext.Current.Request.QueryString("PkToken") & ""
                                End If

                                strToken = CommonFunctions.Security.Token.GetToken(Args.MasterPrimaryKeyValue.ToString + CType(HttpContext.Current.Session("intUserID"), String) + "0" + WhizGlobal.ParentTagID.ToString)
                                'Commented and Added by NitinC on 07 April 2011 for WhizibleSEM 10.0

                                'Added by Dhanashri S ON 1st Sept 2014 Purpose:WhizibleSEM-SP2 upgrade
                                Args.ToBeInsertedInFunction = "window.open(""../PM/PM_ProjectDocuments.aspx?ParentToken=" + strParentToken + "&PKToken=" + strToken + "&Mode=UPLOAD&MasterTagID=516&FromWhere=PM&UniqueID=" + Args.MasterPrimaryKeyValue.ToString + ""","""",""resizable=yes,menubar=no,scrollbars=no,left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=400"");" + vbCrLf
                                'Args.ToBeInsertedInFunction = "window.open(""../PM/PM_ProjectDocuments.aspx?ParentToken=" + strParentToken + "&PKToken=" + strToken + "&Mode=UPLOAD&MasterTagID=34&FromWhere=PM&UniqueID=" + Args.MasterPrimaryKeyValue.ToString + ""","""",""resizable=yes,menubar=no,scrollbars=no,,channelmode=yes,left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=400"");" + vbCrLf
                                'End of Addition by Dhanashri S ON 1st Sept 2014 Purpose:WhizibleSEM-SP2 upgrade

                                'End of Commented and Added by NitinC on 07 April 2011 for WhizibleSEM 10.0
                                Args.ToBeInsertedInFunction += "return;"
                            End If

                            If Args.ClientSideFunctionName.ToUpper = "ATTACHURL_ONCLICK" Then
                                'Modified By VidyaJ - Security issue - 6197
                                Dim strToken As String
                                Dim strParentToken As String
                                If HttpContext.Current.Request.QueryString("PkToken") Is Nothing Then
                                    strParentToken = HttpContext.Current.Request.Form("PkToken") & ""
                                Else
                                    strParentToken = HttpContext.Current.Request.QueryString("PkToken") & ""
                                End If

                                strToken = CommonFunctions.Security.Token.GetToken(Args.MasterPrimaryKeyValue.ToString + CType(HttpContext.Current.Session("intUserID"), String) + "0" + WhizGlobal.ParentTagID.ToString)
                                Args.ToBeInsertedInFunction += " window.open(""../PM/PM_ProjectDocuments.aspx?ParentToken=" + strParentToken + "&PKToken=" + strToken + "&Mode=URL&MasterTagID=516&FromWhere=PM&UniqueID=" + Args.MasterPrimaryKeyValue.ToString + ""","""",""resizable=yes,menubar=no,scrollbars=no,left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=350""); return; "
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_FAST_TRACK_REVIEW_DOCUMENTS

                            If Args.LinkName.ToUpper = "UPLOAD DOCUMENT" Then
                                'Modified By VidyaJ - Security issue - 6197
                                Dim strToken As String
                                Dim strParentToken As String
                                If HttpContext.Current.Request.QueryString("PkToken") Is Nothing Then
                                    strParentToken = HttpContext.Current.Request.Form("PkToken") & ""
                                Else
                                    strParentToken = HttpContext.Current.Request.QueryString("PkToken") & ""
                                End If

                                strToken = CommonFunctions.Security.Token.GetToken(Args.MasterPrimaryKeyValue.ToString + CType(HttpContext.Current.Session("intUserID"), String) + "0" + WhizGlobal.ParentTagID.ToString)
                                'Commented and Added by NitinC on 07 April 2011 for WhizibleSEM 10.0

                                'Commented and Added By Chakshuta H on 1st Sept 2014 for SP2 Issue For Upload issue in fast track upload document
                                'Args.ToBeInsertedInFunction = "window.open(""../PM/PM_ProjectDocuments.aspx?ParentToken=" + strParentToken + "&PKToken=" + strToken + "&Mode=UPLOAD&MasterTagID=2191&FromWhere=PM&UniqueID=" + Args.MasterPrimaryKeyValue.ToString + ""","""",""resizable=yes,menubar=no,scrollbars=no,left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=400"");" + vbCrLf
                                'Args.ToBeInsertedInFunction = "window.open(""../PM/PM_ProjectDocuments.aspx?ParentToken=" + strParentToken + "&PKToken=" + strToken + "&Mode=UPLOAD&MasterTagID=34&FromWhere=PM&UniqueID=" + Args.MasterPrimaryKeyValue.ToString + ""","""",""resizable=yes,menubar=no,scrollbars=no,,channelmode=yes,left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=400"");" + vbCrLf
                                Args.ToBeInsertedInFunction = "window.open(""../PM/PM_ProjectDocuments.aspx?ParentToken=" + strParentToken + "&PKToken=" + strToken + "&Mode=UPLOAD&MasterTagID=2191&FromWhere=PM&UniqueID=" + Args.MasterPrimaryKeyValue.ToString + ""","""",""resizable=yes,menubar=no,scrollbars=no,,channelmode=yes,left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=400"");" + vbCrLf
                                'End Of Commented and Added By Chakshuta H on 1st Sept 2014 SP2 Issue For Upload issue in fast track upload document

                                'End of Commented and Added by NitinC on 07 April 2011 for WhizibleSEM 10.0
                                Args.ToBeInsertedInFunction += "return;"
                            End If

                            If Args.ClientSideFunctionName.ToUpper = "ATTACHURL_ONCLICK" Then
                                'Modified By VidyaJ - Security issue - 6197
                                Dim strToken As String
                                Dim strParentToken As String
                                If HttpContext.Current.Request.QueryString("PkToken") Is Nothing Then
                                    strParentToken = HttpContext.Current.Request.Form("PkToken") & ""
                                Else
                                    strParentToken = HttpContext.Current.Request.QueryString("PkToken") & ""
                                End If

                                strToken = CommonFunctions.Security.Token.GetToken(Args.MasterPrimaryKeyValue.ToString + CType(HttpContext.Current.Session("intUserID"), String) + "0" + WhizGlobal.ParentTagID.ToString)
                                Args.ToBeInsertedInFunction += " window.open(""../PM/PM_ProjectDocuments.aspx?ParentToken=" + strParentToken + "&PKToken=" + strToken + "&Mode=URL&MasterTagID=2191&FromWhere=PM&UniqueID=" + Args.MasterPrimaryKeyValue.ToString + ""","""",""resizable=yes,menubar=no,scrollbars=no,left="" + (window.screen.width-500)/2 + "",top="" + (window.screen.height-400)/2 + "",width=500,height=350""); return; "
                            End If

                            ' End Addition By NitinVS on 8 March 2005 for WhizibleE SP2

                            'Added By MrugajaB on 31st May 2005
                            'Purpose:To allow any modifications in document when FTR had closed status
                            'Dim strQuery As String = ""
                            'Dim drReviewDetails As IDataReader
                            'Dim m_strReviewstatisticsID As String
                            'Dim m_strReviewStatus As String = ""
                            'm_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ReviewStatisticsID_PK")
                            'If m_strReviewstatisticsID = "" Then
                            'm_strReviewstatisticsID = HttpContext.Current.Request.QueryString("ForeignKeyValue")
                            'End If
                            'If m_strReviewstatisticsID = "" Then
                            'm_strReviewstatisticsID = HttpContext.Current.Request("ReviewStatisticsID_PK")
                            'End If

                            'If m_strReviewstatisticsID <> "" Then
                            'strQuery = "Select ReviewStatus from tbl_pm_reviewstatistics Where ReviewStatisticsID= " + m_strReviewstatisticsID
                            'drReviewDetails = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            'If CommonFunctions.General.CheckIsNothing(drReviewDetails, "") <> "" Then
                            'If drReviewDetails.Read() Then
                            'm_strReviewStatus = CType(CommonFunctions.Data.CheckIsDBNull(drReviewDetails("ReviewStatus"), ""), String)

                            'End If
                            'CommonFunctions.Data.DisposeDataReader(drReviewDetails)
                            'End If

                            'Select Case Args.LinkName.ToUpper
                            'Case "UPLOAD DOCUMENT", "ATTACH URL"
                            '   If m_strReviewStatus.ToUpper = "CLOSED" Then
                            '  Cancel = True
                            ' End If
                            'End Select

                            'Select Case Args.SystemLinkType.Trim.ToUpper
                            '   Case "DELETE", "SELECT_ALL"
                            '      If m_strReviewStatus.ToUpper = "CLOSED" Then
                            '     Cancel = True
                            '    End If
                            'End Select
                        Case CommonFunction.Constants.APP_TAG_TAB_PROJECT_MAPPING
                            If Args.LinkName.ToUpper = "DELETE" Then
                                Args.ToBeInsertedInFunction = "var objAllowDelete = GetObjectReference('frmCommonPage','AllowDelete',true); " + vbNewLine
                                Args.ToBeInsertedInFunction += "var objProjectName = GetObjectReference('frmCommonPage','Project',true); " + vbNewLine
                                Args.ToBeInsertedInFunction += "var objArrchkDelete120 = GetObjectReference('frmCommonPage','chkDelete120',true); " + vbNewLine
                                Args.ToBeInsertedInFunction += "var ProjectList='';" + vbNewLine
                                Args.ToBeInsertedInFunction += "var i=0;" + vbNewLine
                                Args.ToBeInsertedInFunction += "var flag=false;" + vbNewLine
                                Args.ToBeInsertedInFunction += "for ( i=0;i<objAllowDelete.length;i++) {  if (objAllowDelete[i].value == '1' && objArrchkDelete120[i].checked == true ) { flag = true; ProjectList = ProjectList + '\n' + objProjectName[i].value; } }" + vbNewLine
                                Args.ToBeInsertedInFunction += "if ( flag==true ) { " + vbNewLine
                                Args.ToBeInsertedInFunction += "var confirmMessage='Tasks are allocated to Projects-';" + vbNewLine
                                Args.ToBeInsertedInFunction += "confirmMessage = confirmMessage + ProjectList ;" + vbNewLine
                                Args.ToBeInsertedInFunction += "confirmMessage = confirmMessage  + '\n Do you want to continue?';" + vbNewLine
                                Args.ToBeInsertedInFunction += "if (!confirm(confirmMessage))  return; " + vbNewLine
                                Args.ToBeInsertedInFunction += "objfrm.action=""CommonPage.aspx?FocusOn=SUBTAG&Operation=DELETE&" + Args.CommonQueryString + ";""" + vbNewLine
                                Args.ToBeInsertedInFunction += "objfrm.submit(); }" + vbNewLine
                            End If

                            ''Added by Dhanashri S on 29 Oct 2015
                        Case CommonFunctions.Constants.TAG_TAB_CLCPEXTENSION_CUSTOMECODE
                            If Args.SystemLinkType.ToUpper = "ADD_NEW" Or Args.SystemLinkType.ToUpper = "SELECT_ALL" Or Args.SystemLinkType.ToUpper = "DELETE" Or Args.SystemLinkType.ToUpper = "SAVE_ADD" Then
                                Cancel = True
                            End If
                        Case CommonFunctions.Constants.TAG_TAB_CLCPEXTENSION_INPUTPARAMETER
                            If Args.SystemLinkType.ToUpper = "ADD_NEW" Or Args.SystemLinkType.ToUpper = "SELECT_ALL" Or Args.SystemLinkType.ToUpper = "DELETE" Or Args.SystemLinkType.ToUpper = "SAVE_ADD" Then
                                Cancel = True
                            End If
                            ''End of Addition by Dhanashri S on 29 Oct 2015
                    End Select
                End If

                '---------------- Added By PurvaJ on 8 May 2008 Configurable workflow
                '---------------- cancel the save link based on the setting done for workflow at entity
                '---------------- Approver or owner
                Select Case WhizGlobal.TagID
                    Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING, CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS, CommonFunction.Constants.APP_TAG_MODULES, CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT, CommonFunction.Constants.APP_TAG_SUB_PROJECTS, CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                        If WhizGlobal.ParentTagID = 0 Then
                            If Args.ClientSideFunctionName.ToUpper.ToString = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper.ToString = "SAVEADD_ONCLICK" Then
                                'If Cancel = False Then
                                Dim intDisplaySaveLink As Integer
                                Dim strSQL As String = "usp_get_Workflow_SaveLinkAccess "
                                Dim strUniqueID As String = ""
                                If Args.PrimaryKeyValue = "" Then
                                    strUniqueID = "0"
                                Else
                                    strUniqueID = Args.PrimaryKeyValue
                                End If

                                strSQL = strSQL + strUniqueID.ToString
                                strSQL = strSQL + "," + WhizGlobal.TagID.ToString
                                strSQL = strSQL + "," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString
                                strSQL = strSQL + "," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0").ToString
                                strSQL = strSQL + "," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intPostID"), "0").ToString

                                intDisplaySaveLink = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, 2), 2)


                                'intDisplaySaveLink = 0 -> Do not display(new workflow is on)
                                'intDisplaySaveLink = 1 -> Display(new workflow is on)
                                'intDisplaySaveLink = 2 -> NA as old workflow in on


                                If intDisplaySaveLink = 0 Then
                                    Cancel = True
                                ElseIf intDisplaySaveLink = 1 Then
                                    Cancel = False
                                End If

                                'End If
                            End If
                        End If
                End Select
                '---------------- End Addition PurvaJ
            End Sub
            Public Shared Sub Before_NavLinks_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Cancel = False
                'This Event will occur before printing navigation links
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID

                        'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                        'Added By SandeepA on 15 Nov,2005 for Issue_D--676
                        'Purpose: Hide Navigation links
                    Case CommonFunction.Constants.APP_TAG_RestrictedAccessProjectInfo
                            Cancel = True
                            'End of Addition by SandeepA on 15 Nov,2005 for IssueID-676
                            'End Integration

                            'Added By VivekP On 3 August 2005 For WhizibleSEM SP4 IssueID-87
                        Case CommonFunction.Constants.APP_TAG_PROJECTTIMESHEET_COMMENT
                            Cancel = True
                            'End Of Addition By VivekP On 3 August 2005 For WhizibleSEM SP4 IssueID-87

                        Case CommonFunction.Constants.TAG_PROJECT_INFORMATION, CommonFunction.Constants.APP_TAG_RFI_TAX_BUILDER, CommonFunction.Constants.APP_TAG_CONTRACT_VIEW
                            Cancel = True

                            'added by SachinR   On 30 jul 2004
                            'issue 12191
                        Case CommonFunction.Constants.APP_TAG_PHASETASK_REVISION, CommonFunction.Constants.APP_TAG_PHASETASK_TEMPLATE_REVISION_1, CommonFunction.Constants.APP_TAG_PHASETASK_TEMPLATE_REVISION_2
                            'hide the navigation liks 
                            Cancel = True
                            'addition end

                            'added by SachinR   On 5 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLE_CODE_DEFINITION
                            'hide the navigation liks from the code definition page
                            Cancel = True
                            'addition end

                            'added by SachinR   On 06 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_SERIES_GENERATION
                            'hide the navigation liks from the invoice series generation page
                            Cancel = True
                            'addition end

                            'added by SachinR   On 17 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_ISSUE_CODEGENERATION
                            'hide the navigation liks from the issue code generation page
                            Cancel = True
                            'addition end

                            ' Added by DiptiK on 18th Aug 2k4
                        Case CommonFunction.Constants.APP_TAG_CNF_PROJECT_SETTINGS
                            Cancel = True
                            'addition ends
                            'added by SachinR   on 26 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_PRACTICE_SELECTION, CommonFunction.Constants.APP_TAG_ASSOCIATED_PHASE_TASK, CommonFunction.Constants.APP_TAG_ASSOCIATED_ACTIVITIES_DISTRIBUTION, CommonFunction.Constants.APP_TAG_ASSOCIATED_ACTIVITIES
                            Cancel = True
                            'addition end
                            'Added By NileshD on 27 August 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_DISPATCHED_DETAILS
                            Cancel = True
                            'End of Addition

                            ' Added by NitinVS on 22 November 2004
                            'hide the navigation liks from the T&M By Resource and T/M By Role Page
                        Case CommonFunction.Constants.APP_TAG_TAB_RATE_CONTRACT
                            Cancel = True
                            'End of Addition 

                            'Code Added by Noble K 29th Jan 2005 to Hide Navigation Links for Project Costs
                            'IssueID 15338
                        Case CommonFunction.Constants.APP_TAG_PROJECT_DOH
                            Cancel = True
                            'Code Added by Noble K 29th Jan 2005 to Hide Navigation Links for Project Costs Ends


                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_TAG_TAB_PHASETASK_REVISION, CommonFunction.Constants.APP_TAG_TAB_PHASETASK_TEMPLATE_REVISION
                            'added by SachinR   On 30 jul 2004
                            'issue 12191
                            'hide the navigation liks 
                            Cancel = True
                            'addition end

                            'added by SachinR   on 26 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_ASSOCIATED_PHASE_TASK
                            Cancel = True
                            'addition end

                            'Added by DipaliS 25 OCt 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_TASKTYPE
                            Cancel = True
                            'End addition by DipaliS
                    End Select
                End If
            End Sub

            Public Shared Sub Before_NavLink_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLink, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Cancel = False
                'This Event will occur before printing navigation link
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

            Public Shared Sub Before_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PagingLink, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)
                Cancel = False
                'This Event will occur before printing paging links
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

            Public Shared Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Cancel = False
                'This Event will occur before printing paging links
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID

                        'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                        'Added By SandeepA on 15 Nov,2005 for IssueID-676
                    Case CommonFunction.Constants.APP_TAG_ProjectInfoRoleAccess
                            'Purpose:To hide Paging link for Project info Role Access Page
                            'TagID: 3083
                            Cancel = True
                            'End of Addition By SandeepA on 15 Nov,2005 for IssueId-676

                            'Added by SandeepA on 15 Nov,2005 for IssueID -- 677
                        Case CommonFunction.Constants.APP_TAG_BG_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            'Purpose:To hide Paging link for Project Access
                            'TagID: 3087
                            Cancel = True
                            'End of addition by SandeepA no 15 Nov,2005 for IssueID -- 677
                            'End Integration
                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                            'Added by SandeepA on 15 Nov,2005 for IssueID -- 679
                        Case CommonFunction.Constants.APP_TAG_OU_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            'Purpose:To hide Paging link for Project Access
                            'TagID: 3088
                            Cancel = True
                            'End of addition by SandeepA no 15 Nov,2005 for IssueID -- 679
                            'End Integration

                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2

                            'Added by SandeepA on 16 Nov,2005 for IssueID -- 680
                        Case CommonFunction.Constants.APP_TAG_DU_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            'Purpose:To hide Paging link for Project Access
                            'TagID: 3090
                            Cancel = True
                            'End of addition by SandeepA no 16 Nov,2005 for IssueID -- 680
                            'End Integration
                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2

                            'Added by SandeepA on 16 Nov,2005 for IssueID -- 681
                        Case CommonFunction.Constants.APP_TAG_DT_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            'Purpose:To hide Paging link for Project Access
                            'TagID: 3092
                            Cancel = True
                            'End of addition by SandeepA no 16 Nov,2005 for IssueID -- 681
                            'End Integration



                            'Code Added by Noble K 29th Jan 2005 to Hide Paging Links for Project Costs
                            'IssueID 15338
                        Case CommonFunction.Constants.APP_TAG_PROJECT_DOH
                            Cancel = True
                            'Code Added by Noble K 29th Jan 2005 to Hide Paging Links for Project Costs Ends

                            'Added by ShamkantD on 30th July 2004 - added to hide the paging links for Work Order Field Access Page
                        Case CommonFunction.Constants.APP_TAG_CONFIG_WORKORDER_FIELD_ACCESS
                            'Cancel = True
                            'Addition edns - ShamkantD on 30th July 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_INITIATOR
                            Cancel = True
                            ' Added by DiptiK on 18th Aug 2k4
                        Case CommonFunction.Constants.APP_TAG_CNF_PROJECT_SETTINGS
                            Cancel = True
                            ' Addition Ends

                            ' integrated by harshada d for whizible sem SP7.2 for Issue ID 4518*/
                            'Added By AmitD For Question Selection List on 24 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_QUESTION_SELECTION_LIST
                            Cancel = True
                            'End Addiiton

                            '' Commented By ParagD On 3-July-2006
                            '' Purpose : Sierra 2529 - void tasks are not shown in "Show void Tasks" page.

                            '' Case CommonFunction.Constants.APP_TAG_VOIDED_TASKS
                            ''    Cancel = True

                            '' END : Commented By ParagD On 3-July-2006.    

                            'end of integration by harshada d
                            'code added by MrugajaB on 2 Mar,2005
                        Case CommonFunction.Constants.APP_TAG_PROJECT_DOCUMENTCATEGORY
                            Cancel = True
                            'End Addition
                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID

                    End Select
                End If
            End Sub

            Public Shared Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal WhizGlobal As WebPages.Template.IGlobal)
                Cancel = False
                'This Event will occur before printing paging links
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID
                        Case CommonFunctions.Constants.TAG_ADVANCE_FILTERS
                            Args.Add = True
                            Args.Edit = True
                            Args.Delete = True
                            Args.View = True
                        Case CommonFunction.Constants.App_Tag_Login_Maintenance
                            HttpContext.Current.Session("LoginViewAccess") = Args.View

                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID
                        'Added by ShamkantD on 15th Sep 2004 - for Checklist SubTag on Fast Track Review Page
                    Case CommonFunction.Constants.APP_SUBTAG_CHECKLIST_FASTTRACK_REVIEW
                            Cancel = True
                            'End of addition - ShamkantD on 15th Sep 2004 
                            'Added By JyotiG 23-Nov-2006
                            'Start_JG_CR_7630_23-Nov-2006
                        Case CommonFunction.Constants.APP_SUBTAG_EMPLOYEE_CURRENT_ASSIGNMNETS
                            Cancel = True
                            'End_JG_CR_7630_23-Nov-2006
                    End Select
                End If
            End Sub

            Public Shared Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)
                Cancel = False
                'This Event will occur before printing paging links
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID

                        ' Added by DiptiK on 14th Sep 2k4
                    Case CommonFunction.Constants.APP_TAG_CNF_SERVICE_SEGMENATATION

                            'Cancel = True  ' Commented by ShamkantD on 15 Sep 2004


                            ' Addition Ends

                            ' Added by DiptiK on 14th Sep 2k4
                        Case CommonFunction.Constants.APP_TAG_CNF_MARKET_SEGMENATATION

                            'Cancel = True ' Commented by ShamkantD on 15 Sep 2004


                            ' Addition Ends

                            'Integrated by SavitaS on 13 Mar 2006 for IssueID-2836 (For RFI Milestone and RFI Deliverable Pages.)
                            'Added by GaneshG on 12 Jan 2006 -- To change Paging link ClientsideFuctionName 
                            'for RFI Milestone and RFI Deliverable Page.
                        Case CommonFunction.Constants.APP_TAG_RFI_MILESTONE
                            If Args.ClientSideFunctionName = "Page_Onclick" Then
                                Args.ClientSideFunctionName = "Paging_Onclick"
                            End If

                        Case CommonFunction.Constants.APP_TAG_RFI_DELIVERABLES
                            If Args.ClientSideFunctionName = "Page_Onclick" Then
                                Args.ClientSideFunctionName = "Paging_Onclick"
                            End If
                            'End of Addition
                            'End Integration by SavitaS on 13 Mar 2006

                        Case CommonFunction.Constants.APP_TAG_DELIVERABLES_SELECTION_LIST
                            If (HttpContext.Current.Request("Fromwhere") = "IB") Then
                                Args.ClientSideFunctionName = "Paging_Print"
                                'ToBeInserted = " objfrm.action = 'CommonList.aspx?SetPagingAlphabet=1&Fromwhere=IB&ProjectID=" & HttpContext.Current.Request("ProjectID") & "&PagingAlphabet='+  strPagingAlphabet;" + vbCrLf
                                'Paging.ToBeInserted += " objfrm.submit(); return;" + vbCrLf
                            End If

                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID
                        ''Added by Dhanashri S on 29 Oct 2015
                        Case CommonFunctions.Constants.TAG_TAB_CLCPEXTENSION_CUSTOMECODE
                            Cancel = True
                            ''End of Addition by Dhanashri S on 29 Oct 2015
                    End Select
                End If
            End Sub

            Public Shared Sub After_Link_Print(ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
                'This Event will occur after printing link
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

            Public Shared Sub After_NavLink_Print(ByRef Args As WAF_DynamicMenu_NavLink, ByVal WhizGlobal As WebPages.Template.IGlobal)
                'This Event will occur after navigation link
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

            Public Shared Sub After_NavLinks_Print(ByRef Args As WAF_DynamicMenu_NavLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)
                'This Event will occur after printing navigation links
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

            Public Shared Sub After_Paging_Print(ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)
                'This Event will occur after printing paging
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

#Region "PRIVATE PROCEDURES"
            '--Code added by SajiU on 24 Nov 2006  strUserLoginName, strUserbuildpassword
            Private Shared Function CreateLogin(ByVal lngEmployeeID As Long) As Boolean
                'INSERT mode
                CreateLogin = True
                Dim CreateLoginFlag As Boolean
                Dim notAllowedUserFlag As Boolean
                Dim strSQLQuery As String
                Dim Counter As Integer
                Dim StrRndNumber As String = CStr(Int(Rnd() * 10))
                Dim strbuildpassword As String
                'Dim strEncryPass1 As String = ""
                Dim strLoginName As String = ""
                Dim strDefaultPassword As String = ""
                Dim m_objTemplate As WebPages.Template.WhizTemplate
                Dim objDr As IDataReader
                Dim strSQL As String
                Dim intActualUser As Long
                Dim intAllowedUser As Long
                Dim intLoginsCreated As Integer
                ''strSQL = "usp_sel_tbl_PM_CompanyInformation_BulkLogin"
                ''objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                ''While objDr.Read
                ''    strDefaultPassword = CommonFunction.Data.CheckIsDBNull(objDr("Default_Password"), "").ToString
                ''End While
                ''CommonFunction.Data.DisposeDataReader(objDr)
                If CheckForTamperingOfData(intAllowedUser, intActualUser) = True Then
                    CreateLoginFlag = True
                    notAllowedUserFlag = False
                    strSQL = ""
                    strSQL = "usp_sel_tbl_pm_employee_BulkLogin "
                    strSQL += lngEmployeeID.ToString
                    objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    While objDr.Read
                        strLoginName = CommonFunction.Data.CheckIsDBNull(objDr("UserName"), "").ToString
                    End While
                    CommonFunction.Data.DisposeDataReader(objDr)
                    ' Code added on 8th Dec 2006
                    For Counter = 1 To 1 Step 1
                        StrRndNumber += StrRndNumber + CStr(Int(Rnd() * 1000))
                    Next
                    strbuildpassword = Left$(strLoginName, 3) + StrRndNumber

                    'strDefaultPassword = strbuildpassword

                    'End of Addition on 8th Dec 2006

                    Dim objEncrypt As New Authentication.PWEncryption(CommonFunction.General.UnBuildQueryString(strLoginName), CommonFunction.General.UnBuildQueryString(strbuildpassword))
                    strDefaultPassword = objEncrypt.Encrypt()
                    objEncrypt = Nothing
                    'Commented And Added By Usha Pandit On 04.01.2021 For passing login name because null is passed for login name
                    'strSQLQuery = "Exec usp_Ins_tbl_PM_Login 'E',null,'" + lngEmployeeID.ToString + "',null,0,NULL,'" + CommonFunction.General.BuildQueryString(strDefaultPassword) + "'"
                    strSQLQuery = "Exec usp_Ins_tbl_PM_Login 'E',null,'" + lngEmployeeID.ToString + "',null,0, '" + strLoginName + "','" + CommonFunction.General.BuildQueryString(strDefaultPassword) + "'"
                    'End Of Added By Usha Pandit On 04.01.2021 For passing login name because null is passed for login name
                    Dim drInsert As IDataReader = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    If drInsert.Read Then
                        If drInsert("Exceeded").ToString = "1" And drInsert("Success").ToString = "1" Then
                            'keep the number of users in session so as to access in CEventHandlers
                            HttpContext.Current.Session("intAllowedUsers") = drInsert("Users").ToString
                            CreateLoginFlag = True
                        End If
                        If drInsert("Exceeded").ToString = "0" And drInsert("Success").ToString = "0" Then
                            'keep the number of users in session so as to access in CEventHandlers
                            HttpContext.Current.Session("strNotAllowedUsers") = CType(HttpContext.Current.Session("strNotAllowedUsers"), String) + strLoginName.ToString + ", "

                            CreateLoginFlag = False
                            notAllowedUserFlag = True
                        End If
                        
                    End If
                    'SendEmailForNewLogin(lngUserId, strLoginName, strPassword, "E")
                    If CreateLoginFlag = True And notAllowedUserFlag = False Then
                        intLoginsCreated = CType(HttpContext.Current.Session("intLoginsCreated"), Integer) + 1
                        Call SendEmailForNewLogin(lngEmployeeID, strLoginName, strbuildpassword, "E")
                        If intLoginsCreated > 0 Then
                            'Add the number of logins created to session so as to access in CEventHandlers
                            HttpContext.Current.Session("intLoginsCreated") = intLoginsCreated.ToString
                        End If
                    End If
                    'dispose
                    CommonFunction.Data.DisposeDataReader(drInsert)
                Else
                    CreateLoginFlag = False
                    CreateLogin = False
                End If

            End Function
            'Code added by SajiU on 8th Dec 2006
            Private Shared Function SendEmailForNewLogin(ByVal lngUserId As Long, ByVal strLoginName As String, ByVal strPassword As String, ByVal strUserType As String) As String
                Dim drEmail As IDataReader = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 12", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                Dim blnSendEmail As Boolean = False
                Dim blnShowPopup As Boolean = True
                SendEmailForNewLogin = ""
                ' Retrieve information about the mail message.
                If drEmail.Read Then
                    blnSendEmail = CType(drEmail("SendMail"), Boolean)
                    blnShowPopup = CType(drEmail("ShowPopup"), Boolean)
                End If
                'dispose
                CommonFunction.Data.DisposeDataReader(drEmail)

                If blnSendEmail = True Then
                    Dim strFromEmailID As String
                    Dim strToEmailID As String
                    Dim strCCToEmailID As String
                    Dim strSubject As String
                    Dim strEmailMessage As String
                    If blnShowPopup = False Then
                        Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_12(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, strUserType, lngUserId, strLoginName, strPassword)
                        Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                    Else
                        'SendEmailForNewLogin = "window.open (" + Chr(34) + "../General/SendEmail.aspx?MessageID=12&UserType=" + strUserType + "&UserID=" + lngUserId.ToString + "&LoginName=" + strLoginName + "&Password=" + strPassword + Chr(34) + ",null,""resizable=yes,scrollbars=no,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=600,height=500"");" + vbCrLf

                        ''window.open (" + Chr(34) + "../General/SendEmail.aspx?MessageID=20&TaskID=," + intTaskID + "," + Chr(34) + ",""Task"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=600,height=500"");" + vbCrLf
                        'SendEmailForNewLogin += "<Script language=javascript>" + vbCrLf
                        'SendEmailForNewLogin += "	window.open (" + Chr(34) + "../General/SendEmail.aspx?MessageID=12&UserType=" + strUserType + "&UserID=" + lngUserId.ToString + "&LoginName=" + strLoginName + "&Password=" + strPassword + Chr(34) + ",null,""resizable=yes,scrollbars=no,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=600,height=500"");" + vbCrLf
                        'SendEmailForNewLogin += "</Script>" + vbCrLf
                        Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_12(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, strUserType, lngUserId, strLoginName, strPassword)
                        Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)


                    End If
                End If
            End Function
            'End of addition by SajiU on 8th Dec 2006
            Private Shared Function ActivateLogin(ByVal lngEmployeeID As Long) As Boolean
                'Update mode
                ActivateLogin = True
                Dim strSQL As String
                strSQL = "Exec usp_Upd_tbl_PM_Login_SetReset_BulkLogin '" + lngEmployeeID.ToString + "'"
                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            End Function
            Private Shared Function ResetPWD(ByVal lngEmployeeID As Long) As Boolean
                'RESET mode
                ResetPWD = True
                Dim strSQLQuery As String
                'Dim strEncryPass1 As String = ""
                Dim strLoginName As String = ""
                Dim StrRndNumber As String = CStr(Int(Rnd() * 10))
                Dim Counter As Integer
                Dim strbuildpassword As String
                Dim strResetPassword As String = ""
                Dim m_objTemplate As WebPages.Template.WhizTemplate
                Dim objDr As IDataReader
                Dim strSQL As String
                Dim strFromEmailID As String
                Dim strToEmailID As String
                Dim strCCToEmailID As String
                Dim strSubject As String
                Dim strEmailMessage As String
                'strSQL = "usp_sel_tbl_PM_CompanyInformation_BulkLogin"
                'objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                'While objDr.Read
                '    strResetPassword = CommonFunction.Data.CheckIsDBNull(objDr("Reset_Password"), "").ToString
                'End While
                'CommonFunction.Data.DisposeDataReader(objDr)
                strSQL = ""
                strSQL = "usp_sel_tbl_pm_login_BulkReset "
                strSQL += lngEmployeeID.ToString
                objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                While objDr.Read
                    strLoginName = CommonFunction.Data.CheckIsDBNull(objDr("LoginName"), "").ToString
                End While
                CommonFunction.Data.DisposeDataReader(objDr)
                ' Code added on 8th Dec 2006
                For Counter = 1 To 1 Step 1
                    StrRndNumber += StrRndNumber + CStr(Int(Rnd() * 1000))
                Next
                strbuildpassword = Left$(strLoginName, 3) + StrRndNumber

                Dim objEncrypt As New Authentication.PWEncryption(CommonFunction.General.UnBuildQueryString(strLoginName), CommonFunction.General.UnBuildQueryString(strbuildpassword))
                strResetPassword = objEncrypt.Encrypt()
                objEncrypt = Nothing
                strSQL = ""
                strSQL = "Exec usp_Upd_tbl_PM_Login_SetResetPWD '" + lngEmployeeID.ToString + "','" + strResetPassword.ToString + "'"
                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_443(strFromEmailID, strToEmailID, strSubject, strEmailMessage, strLoginName, strbuildpassword)
                Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailId, strCCToEmailId, strFromEmailId, strSubject, strEmailMessage)

            End Function
            '=====================================================================
            ' Procedure Name		:	CheckForTamperingOfData
            ' Purpose				:	To check if the number of licence is manipulated
            '=====================================================================
            Private Shared Function CheckForTamperingOfData(ByRef AllowedUsers As Long, ByRef ActualUsers As Long) As Boolean
                CheckForTamperingOfData = True
                Dim drCompanyInformation As IDataReader
                Dim objValidatePW As Authentication.PWEncryption
                Dim intNoOfUsers As Integer
                Dim strEncryptedNoOfUsers As String
                Dim strEncryptedLicenseCode As String
                Dim intLicenseCode As Integer
                Dim strCSPLEmail As String
                Dim strEncryptedResult As String
                Dim blnCInfoManipulated As Boolean
                Dim intAllowedNoOfUsers As Integer
                Dim intActualNoOfUsers As Integer
                Dim blnRestrictExcessLogins As Boolean

                ' Get the number of licensed users as stored in the database.
                drCompanyInformation = CommonFunction.Data.GetDataReader("SELECT TOP 1 NoOfUsers, EncryptedUserNo, LicenseCode, EncryptedLicenseCode, CSPLEmail FROM tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                While drCompanyInformation.Read
                    intNoOfUsers = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("NoOfUsers")), Integer)
                    strEncryptedNoOfUsers = CommonFunction.Data.CheckIsDBNull(drCompanyInformation("EncryptedUserNo")).ToString.Trim
                    intLicenseCode = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("LicenseCode")), Integer)
                    strEncryptedLicenseCode = CommonFunction.Data.CheckIsDBNull(drCompanyInformation("EncryptedLicenseCode")).ToString.Trim
                    strCSPLEmail = CommonFunction.Data.CheckIsDBNull(drCompanyInformation("CSPLEmail")).ToString.Trim
                End While
                CommonFunction.Data.DisposeDataReader(drCompanyInformation)

                'Check if the no of users is manipulated
                objValidatePW = New Authentication.PWEncryption("PBN", intNoOfUsers.ToString)
                strEncryptedResult = objValidatePW.Encrypt
                objValidatePW = Nothing

                ' Compare the actual value with the encrypted value.
                If strEncryptedResult <> strEncryptedNoOfUsers Then blnCInfoManipulated = True

                'Check if the license code is manipulated
                objValidatePW = New Authentication.PWEncryption("PBN", intLicenseCode.ToString)
                strEncryptedResult = objValidatePW.Encrypt()
                objValidatePW = Nothing

                ' Compare the actual value with the encrypted value.
                If strEncryptedResult <> strEncryptedLicenseCode Then blnCInfoManipulated = True

                drCompanyInformation = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_UserLicenseInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                While drCompanyInformation.Read
                    intAllowedNoOfUsers = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("AllowedNoOfUsers")), Integer)
                    intActualNoOfUsers = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("ActualNoOfUsers")), Integer)
                    blnRestrictExcessLogins = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("RestrictExcessLogins")), Boolean)
                End While
                CommonFunction.Data.DisposeDataReader(drCompanyInformation)

                If blnCInfoManipulated = True Then
                    HttpContext.Current.Session("InfoManipulated") = "1"
                    CheckForTamperingOfData = False
                    Exit Function
                End If

                If (blnRestrictExcessLogins = True And (intAllowedNoOfUsers <= intActualNoOfUsers)) Then
                    HttpContext.Current.Session("ExcessLogins") = "1"
                    HttpContext.Current.Session("intAllowedNoOfUsers") = intAllowedNoOfUsers
                    HttpContext.Current.Session("intActualNoOfUsers") = intActualNoOfUsers
                    CheckForTamperingOfData = False
                    Exit Function
                Else
                    AllowedUsers = intAllowedNoOfUsers
                    ActualUsers = intActualNoOfUsers
                End If
            End Function
            '--Code Ended by SajiU

#Region "Project Reviews"

            Private Shared Sub SaveActionDetails(ByRef intReviewActionID As String, ByVal intReviewStatisticsID As String, ByVal ControlsHashTable As Hashtable)
                '=====================================================================
                ' Procedure Name		:	SaveActionDetails
                ' Purpose				:	Save Review Action Details
                ' Description			:	called for Save as Task and Save as Issue dynamic actions
                ' Parameters Passed		:	intReviewActionID, intReviewStatisticsID, Control hash table
                ' Parameters Affected	:	None.
                ' Returns				:	No return values.
                ' Assumptions			:	None.
                ' Dependencies			:	None.
                ' Author				:	UmeshJ
                ' Created				:	Feb 24, 2004
                ' Revisions				:   
                '=====================================================================	                
                ' Build Query to insert/update the review action record.
                Dim strSQLQuery As String = "Exec usp_Ins_tbl_PM_ReviewActions "
                Dim intReviewObservationID As String = ""

                ' Pass the Action ID if the action details are being updated.
                If intReviewActionID <> "" Then
                    strSQLQuery += intReviewActionID
                Else
                    strSQLQuery += "NULL"
                End If

                ' ReviewStatisticsID and Project ID.
                strSQLQuery += ", " + intReviewStatisticsID + ", " + HttpContext.Current.Session("intProjectID").ToString

                ' Project Review Type.
                strSQLQuery += ", NULL"

                ' Corporate Review Type.
                strSQLQuery += ", NULL"

                ' Project Review Cause ID.
                If CommonFunction.General.CheckIsNothing(ControlsHashTable("PReviewCauseID")) <> "" Then
                    strSQLQuery += ", " & CommonFunction.General.CheckIsNothing(ControlsHashTable("PReviewCauseID"))
                Else
                    strSQLQuery += ", NULL"
                End If

                ' Corporate Review Cause ID.
                strSQLQuery += ", NULL"

                ' Action.
                If CommonFunction.General.CheckIsNothing(ControlsHashTable("Action")) <> "" Then
                    strSQLQuery += ", '" & CommonFunction.General.BuildQueryString(Left(CommonFunction.General.CheckIsNothing(ControlsHashTable("Action")).ToString, 2000)) & "'"
                Else
                    strSQLQuery += ", NULL"
                End If

                ' Reference.
                If CommonFunction.General.CheckIsNothing(ControlsHashTable("Reference")) <> "" Then
                    strSQLQuery += ", '" & CommonFunction.General.BuildQueryString(Left(CommonFunction.General.CheckIsNothing(ControlsHashTable("Reference")), 100)) & "'"
                Else
                    strSQLQuery += ", NULL"
                End If

                ' Observation Reference.
                If intReviewObservationID <> "" Then
                    strSQLQuery += ", " & intReviewObservationID
                Else
                    strSQLQuery += ", NULL"
                End If

                ' The Work (hrs)
                'Commented and Added by Usha Pandit on 14.06.2019 for storing Correct Efforts after work field change
                'If CommonFunction.General.CheckIsNothing(ControlsHashTable("WorkInHours")) <> "" Then
                '    strSQLQuery = strSQLQuery & ", " & FormatNumber(CommonFunction.General.CheckIsNothing(ControlsHashTable("WorkInHours")), 2)
                'Else
                '    strSQLQuery = strSQLQuery & ", NULL"
                'End If

                If CommonFunction.General.CheckIsNothing(ControlsHashTable("WorkInHours")) <> "" Then
                    strSQLQuery = strSQLQuery & ", " & FormatNumber(CommonFunction.General.CheckIsNothing(ControlsHashTable("WorkInHours")), 2)
                Else
                    If CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase10")) <> "" Then
                        Dim HMEfforts As String = ""
                        Dim fltEfforts As String = ""
                        HMEfforts = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase10"), "0")
                        fltEfforts = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + HMEfforts + "',2)", True)
                        strSQLQuery = strSQLQuery & ", '" & fltEfforts + "'"

                    Else
                        strSQLQuery = strSQLQuery & ", NULL"
                    End If
                End If
                'End of Added by Usha Pandit on 14.06.2019 for storing Correct Efforts after work field change

                ' Created By (for audit trail.)
                strSQLQuery += ", '" & CommonFunction.General.BuildQueryString(HttpContext.Current.Session("strUserName").ToString) + "'"

                'Added by MrugajaB on 31st Jan 2006
                'Purpose: Saving 'Reviewee' in ReviewActions Table
                If CommonFunction.General.CheckIsNothing(ControlsHashTable("Reviewee")) <> "" Then
                    strSQLQuery += ", " & CommonFunction.General.CheckIsNothing(ControlsHashTable("Reviewee"))
                Else
                    strSQLQuery += ", NULL"
                End If

                'End Addition

                ' Execute the Query.
                intReviewActionID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))

            End Sub

            Private Shared Function SaveActionDetailsAsTask(ByRef intReviewActionID As String, ByVal ControlsHashTable As Hashtable) As String
                '=====================================================================
                ' Procedure Name		:	SaveActionDetailsAsTask
                ' Purpose				:	Save Review Action Details as Task
                ' Description			:	called for Save as Task dynamic actions
                ' Parameters Passed		:	intReviewActionID, Control hash table
                ' Parameters Affected	:	None.
                ' Returns				:	No return values.
                ' Assumptions			:	None.
                ' Dependencies			:	None.
                ' Author				:	UmeshJ
                ' Created				:	Feb 24, 2004
                ' Revisions				:   
                '=====================================================================	                
                Dim strSQLQuery As String = "Exec usp_Ins_tbl_PM_ProjectTasks_AssignReviewActionPoint " & intReviewActionID & ", '" & CommonFunction.General.BuildQueryString(HttpContext.Current.Session("strUserName").ToString) & "'"
                Dim intTaskID As String = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                Dim drEmailMessage As IDataReader
                Dim blnSendEmail As Boolean = False
                Dim blnShowPopup As Boolean = False
                SaveActionDetailsAsTask = ""
                ' Retrieve the details of the message to be sent to the Resource.
                drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 14", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drEmailMessage.Read Then
                    blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                    blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                End If
                CommonFunction.Data.DisposeDataReader(drEmailMessage)

                ' Check if the mail has to be sent.
                If blnSendEmail = True Then
                    ' Check if a popup message has to be shown.
                    If blnShowPopup = True Then
                        SaveActionDetailsAsTask += "<Script language=javascript>" + vbCrLf
                        SaveActionDetailsAsTask += "	window.open (" + Chr(34) + "../General/SendEmail.aspx?MessageID=20&TaskID=," + intTaskID + "," + Chr(34) + ",""Task"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=600,height=500"");" + vbCrLf
                        SaveActionDetailsAsTask += "</Script>" + vbCrLf
                        ' Else, if the mail has to be sent silently, then...
                    Else
                        Dim strFromEmailID As String
                        Dim strCCToEmailID As String
                        Dim strToEmailID As String
                        Dim strSubject As String
                        Dim strEmailMessage As String

                        Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_20(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, "," & intTaskID & ",")
                        Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                    End If
                End If
            End Function

            Private Shared Function SaveActionDetailsAsIssue(ByRef intReviewActionID As String, ByVal ControlsHashTable As Hashtable) As String
                '=====================================================================
                ' Procedure Name		:	SaveActionDetailsAsIssue
                ' Purpose				:	Save Review Action Details as Issue
                ' Description			:	called for Save as Issue dynamic action
                ' Parameters Passed		:	intReviewActionID, Control hash table
                ' Parameters Affected	:	None.
                ' Returns				:	No return values.
                ' Assumptions			:	None.
                ' Dependencies			:	None.
                ' Author				:	UmeshJ
                ' Created				:	Feb 24, 2004
                ' Revisions				:   NitinVS on 1 Aug 2007 for WhizibleSEM 7 
                '                           If Issue Efforts are more than project balance efforts issue task is created as void 
                '                           Hence email of issue task assignment not to be shown in this case.                                
                '=====================================================================	     
                Dim intAssignedTo As String = ","
                Dim strSQLQuery As String = "Exec usp_Ins_tbl_IB_Issue_AssignReviewActionPoint " + intReviewActionID + ", '" + CommonFunction.General.BuildQueryString(HttpContext.Current.Session("strUserName").ToString) + "'"
                Dim drIssue As IDataReader = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                Dim intIssueID As String = ""
                Dim blnSendEmail As Boolean = False
                Dim blnShowPopup As Boolean = False
                'Modified by NitinVS on 1 Aug 2007 for WhizibleSEM 7 
                ' If task is created as void do not show the assignment mail 
                Dim intIsActive As String = ""
                'Added by MrugajaB on 1st March 2006 for Multiple Reviewees Feature Isue ID.1835
                Dim m_blnAssignIssueToResponsiblePerson As Boolean = False
                Dim drProject As IDataReader
                Dim drEmailMessageIssue As IDataReader
                Dim strFromEmailIDIssue, strToEmailIDIssue, strCCToEmailIDIssue, strSubjectIssue, strEmailMessageIssue As String
                'End Addition


                If drIssue.GetName(0).ToUpper = "ISACTIVE" Then
                    drIssue.NextResult()
                End If

                If drIssue.Read Then
                    intIssueID = CommonFunction.Data.CheckIsDBNull(drIssue("IssueID")).ToString
                    If CommonFunction.Data.CheckIsDBNull(drIssue("AssignTo")).ToString.Trim <> "" Then
                        intAssignedTo += CommonFunction.Data.CheckIsDBNull(drIssue("AssignTo")).ToString.Trim & ","
                    End If
                    If CommonFunction.Data.CheckIsDBNull(drIssue("IsActive"), "").ToString() <> "" Then
                        intIsActive = CommonFunction.Data.CheckIsDBNull(drIssue("IsActive"), "").ToString()
                    End If
                End If
                CommonFunction.Data.DisposeDataReader(drIssue)

                'Added by MrugajaB on 1st March 2006 for Multiple Reviewees Feature Isue ID.1835
                'Purpose:When Project Setting 'Assign Issue To Responsible Person' is true then fire 2 mails
                '1:Mail for Issue Entry
                '2.Mail for Task Assignment for resource
                'If the setting is false then fire only one mail i.e. for Issue Entry

                drProject = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Project " + HttpContext.Current.Session("intProjectID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drProject.Read Then
                    If CommonFunction.Application.AssignIssueToResponsiblePerson = True Then
                        m_blnAssignIssueToResponsiblePerson = CType(drProject("AssignIssueToResponsiblePerson"), Boolean)
                    End If
                End If

                CommonFunctions.Data.DisposeDataReader(drProject)

                If m_blnAssignIssueToResponsiblePerson = True And intIsActive <> "0" Then
                    'End Modification by nitinvs on 1 Aug 2007 for WhizibleSEM 7 

                    ' Retrieve the details of the message to be sent to the Resource.
                    Dim drEmailMessage As IDataReader = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 20", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    If drEmailMessage.Read Then
                        blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                        blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                    End If
                    CommonFunction.Data.DisposeDataReader(drEmailMessage)

                    ' Check if the mail has to be sent.
                    If blnSendEmail = True Then
                        ' Check if a popup message has to be shown.
                        If blnShowPopup = True Then
                            SaveActionDetailsAsIssue += "<Script language=javascript>" + vbCrLf
                            SaveActionDetailsAsIssue += "	window.open (" + Chr(34) + "../General/SendEmail.aspx?MessageID=14&IssueID=" + intIssueID + "&EmployeeIDList=" + intAssignedTo + Chr(34) + ",""ISSUE"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=600,height=500"");" + vbCrLf
                            SaveActionDetailsAsIssue += "</Script>" + vbCrLf
                            ' Else, if the mail has to be sent silently, then...
                        Else
                            Dim strFromEmailID As String
                            Dim strCCToEmailID As String
                            Dim strToEmailID As String
                            Dim strSubject As String
                            Dim strEmailMessage As String

                            Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_14(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(CommonFunctions.General.CheckIsNothing(intIssueID, "0"), Long), intAssignedTo)
                            Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                            'Response.Write "<pre>" & strEmailMessage & "</pre>"					
                        End If
                    End If
                End If
                drEmailMessageIssue = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 8", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drEmailMessageIssue.Read Then
                    blnSendEmail = CType(drEmailMessageIssue("SendMail"), Boolean)
                    blnShowPopup = CType(drEmailMessageIssue("ShowPopup"), Boolean)
                End If
                'Destroy data reader
                CommonFunction.Data.DisposeDataReader(drEmailMessageIssue)

                'Exit procedure if no mail is to be send
                If Not blnSendEmail Then Exit Function

                'If popup window to be shown before sending mail
                If blnShowPopup Then
                    SaveActionDetailsAsIssue += "<Script language=javascript>" + vbCrLf
                    SaveActionDetailsAsIssue += "	window.open(""../General/SendEmail.aspx?MessageID=8&IssueID=" + intIssueID + """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");" + vbCrLf
                    SaveActionDetailsAsIssue += "</Script>" + vbCrLf
                Else
                    'If mail is to be send silently
                    Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_8(strFromEmailIDIssue, strToEmailIDIssue, strCCToEmailIDIssue, strSubjectIssue, strEmailMessageIssue, CType(CommonFunctions.General.CheckIsNothing(intIssueID, "0"), Long))
                    Call CommonFunction.Emails.SendEmailWithCC(strToEmailIDIssue, strCCToEmailIDIssue, strFromEmailIDIssue, strSubjectIssue, strEmailMessageIssue)
                End If
                'End Addition

            End Function
#End Region

#Region "Resources"
            Private Shared Sub ReassignResource(ByVal intEmployeeID As Long, ByVal intRoleID As Long, ByVal ControlsHashTable As Hashtable)
                '=====================================================================
                ' Procedure Name		:	ReassignResource
                ' Purpose				:	Reassign Resource
                ' Description			:	called for Reassign dynamic actions
                ' Parameters Passed		:	intEmployeeID,intRoleID, Control hash table
                ' Parameters Affected	:	None.
                ' Returns				:	No return values.
                ' Assumptions			:	None.
                ' Dependencies			:	None.
                ' Author				:	UmeshJ
                ' Created				:	Feb 24, 2004
                ' Revisions				:   
                '=====================================================================	                
                ' Build Query to insert/update the review action record.
                Dim strSQLQuery As String = "Exec usp_Ins_tbl_PM_ProjectEmployeeRole_New "

                'ProjectID
                strSQLQuery += HttpContext.Current.Session("intProjectID").ToString

                'Role ID and Employee ID
                strSQLQuery += ", " + intRoleID.ToString + ", " + intEmployeeID.ToString

                'Percentage
                strSQLQuery += ", '" + ControlsHashTable("ResourcePercentage").ToString + "' "

                'Expected Start Date
                strSQLQuery += ", '" + ControlsHashTable("ExpectedStartDate").ToString + "' "

                'Expected End Date
                strSQLQuery += ", '" + ControlsHashTable("ExpectedEndDate").ToString + "' "

                'BudgetedHours
                If CommonFunction.General.CheckIsNothing(ControlsHashTable("BudgetedHours")) <> "" Then
                    strSQLQuery += ", " + CommonFunction.General.CheckIsNothing(ControlsHashTable("BudgetedHours"))
                Else
                    strSQLQuery += ", NULL"
                End If

                'Responsibility
                If CommonFunction.General.CheckIsNothing(ControlsHashTable("Responsibility")) <> "" Then
                    strSQLQuery += ", '" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(ControlsHashTable("Responsibility")).ToString) + "'"
                Else
                    strSQLQuery += ", NULL"
                End If

                'Status
                If CommonFunction.General.CheckIsNothing(ControlsHashTable("ResourceStatus")) <> "" Then
                    strSQLQuery += ", '" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(ControlsHashTable("ResourceStatus")).ToString) + "'"
                Else
                    strSQLQuery += ", NULL"
                End If

                'Created By
                strSQLQuery += ", '" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"))) + "'"

                'IsResourceBillable
                If CommonFunction.General.CheckIsNothing(ControlsHashTable("IsResourceBillable")).ToUpper = "ON" Then
                    strSQLQuery = strSQLQuery & ", 1"
                Else
                    strSQLQuery = strSQLQuery & ", 0"
                End If

                'Modified BY NitinVS on 28 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 12324
                ' Added Reportingto field when reassigned
                'ReportingTo
                If CommonFunction.General.CheckIsNothing(ControlsHashTable("ReportingTo")).ToUpper <> "" Then
                    strSQLQuery = strSQLQuery & ", " + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(ControlsHashTable("ReportingTo")).ToString)
                Else
                    strSQLQuery = strSQLQuery & ", Null "
                End If

                'End Modification BY NitinVS on 28 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 12324

                ' Execute the Query.
                CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                'Added by SanaS on 8-Oct-2009 for resource allocation Changes
                strSQLQuery = " Usp_upd_ReassignedResource_CancelRequest " + intEmployeeID.ToString
                strSQLQuery += ", " + HttpContext.Current.Session("intProjectID").ToString
                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                'End Addition by SanaS on 8-Oct-2009 for resource allocation Changes
                'Added By shraddhaM on 6,July 2007 for REfreshing Resources CL Page thru RCV's CP Page
                HttpContext.Current.Response.Write("<script>")
                HttpContext.Current.Response.Write("if(window.opener)" + vbCrLf)
                HttpContext.Current.Response.Write("{" + vbCrLf)
                HttpContext.Current.Response.Write("if (window.opener != null && window.opener.location.href.match(""PM_ResourceCalenderView.aspx"") == ""PM_ResourceCalenderView.aspx"")" + vbCrLf)
                HttpContext.Current.Response.Write("window.opener.location.href = window.opener.location.href" + vbCrLf)
                HttpContext.Current.Response.Write("if (window.opener.opener != null && window.opener.opener.location.href.match(""CommonList.aspx"") == ""CommonList.aspx"" )" + vbCrLf)
                HttpContext.Current.Response.Write("window.opener.opener.location.href = '../General/CommonList.aspx?FromWhere=PM&MasterTagId=1019';" + vbCrLf)
                HttpContext.Current.Response.Write("}")
                HttpContext.Current.Response.Write("</script>")
                'End of Addition By shraddhaM on 6,July 2007 for REfreshing Resources CL Page thru RCV's CP Page
            End Sub
            Private Shared Function ReleaseResource_SendEmail(ByVal ProjectEmployeeRoleId As Long) As String
                '=====================================================================
                ' Procedure Name		:	ReleaseResource_SendEmail
                ' Purpose				:	SendEmail for Release Resource
                ' Description			:	called for Release dynamic actions
                ' Parameters Passed		:	ProjectEmployeeRoleId
                ' Parameters Affected	:	None.
                ' Returns				:	No return values.
                ' Assumptions			:	None.
                ' Dependencies			:	None.
                ' Author				:	UmeshJ
                ' Created				:	May 04, 2004
                ' Revisions				:   
                '=====================================================================	                
                Dim drEmailMessage As IDataReader
                Dim blnSendEmail As Boolean = False
                Dim blnShowPopup As Boolean = False
                ReleaseResource_SendEmail = ""
                ' Retrieve the details of the message to be sent to the Resource.
                drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 16", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drEmailMessage.Read Then
                    blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                    blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                End If
                CommonFunction.Data.DisposeDataReader(drEmailMessage)

                ' Check if the mail has to be sent.
                If blnSendEmail = True Then
                    ' Check if a popup message has to be shown.
                    If blnShowPopup = True Then
                        ReleaseResource_SendEmail += "<Script language=javascript>" + vbCrLf
                        ReleaseResource_SendEmail += "	window.open (" + Chr(34) + "../General/SendEmail.aspx?MessageID=16&ProjectEmployeeRoleId=" + ProjectEmployeeRoleId.ToString + Chr(34) + ",""release"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=600,height=500"");" + vbCrLf
                        ReleaseResource_SendEmail += "</Script>" + vbCrLf
                        ' Else, if the mail has to be sent silently, then...
                    Else
                        Dim strFromEmailID As String
                        Dim strCCToEmailID As String
                        Dim strToEmailID As String
                        Dim strSubject As String
                        Dim strEmailMessage As String
                        Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_16(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, ProjectEmployeeRoleId.ToString())
                        Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                    End If
                End If
            End Function
            Private Shared Function ReassignResource_SendEmail(ByVal lngEmployeeID As Long, ByVal lngRoleID As Long) As String
                '=====================================================================
                ' Procedure Name		:	ReassignResource_SendEmail
                ' Purpose				:	SendEmail for ReassignResource
                ' Description			:	called for Reassign dynamic actions
                ' Parameters Passed		:	lngEmployeeID, lngRoleID
                ' Parameters Affected	:	None.
                ' Returns				:	No return values.
                ' Assumptions			:	None.
                ' Dependencies			:	None.
                ' Author				:	UmeshJ
                ' Created				:	Feb 26, 2004
                ' Revisions				:   
                '=====================================================================	                
                Dim drEmailMessage As IDataReader
                Dim blnSendEmail As Boolean = False
                Dim blnShowPopup As Boolean = False
                ReassignResource_SendEmail = ""
                ' Retrieve the details of the message to be sent to the Resource.
                drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 15", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drEmailMessage.Read Then
                    blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                    blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                End If
                CommonFunction.Data.DisposeDataReader(drEmailMessage)

                ' Check if the mail has to be sent.
                If blnSendEmail = True Then
                    ' Check if a popup message has to be shown.
                    If blnShowPopup = True Then
                        ReassignResource_SendEmail += "<Script language=javascript>" + vbCrLf
                        ReassignResource_SendEmail += "	window.open (" + Chr(34) + "../General/SendEmail.aspx?MessageID=15&EmployeeID=" + lngEmployeeID.ToString + "&RoleID=" + lngRoleID.ToString + Chr(34) + ",""reassign"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=600,height=500"");" + vbCrLf
                        ReassignResource_SendEmail += "</Script>" + vbCrLf
                        ' Else, if the mail has to be sent silently, then...
                    Else
                        Dim strFromEmailID As String
                        Dim strCCToEmailID As String
                        Dim strToEmailID As String
                        Dim strSubject As String
                        Dim strEmailMessage As String

                        Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_15(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, lngEmployeeID, lngRoleID)
                        Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                    End If
                End If
            End Function
#End Region

#End Region

#Region "Task Type"
            '====================================================================
            ' Procedure Name        :   TaskType_GetQueryString
            ' Parameters Passed     :   QueryString : String
            ' Returns               :   String
            ' Parameters Affected   :   None
            ' Purpose               :   To remove the querystring parameters that are repeated
            ' Description           :   Same as above
            ' Assumptions           :   None
            ' Dependencies          :   None
            ' Author                :   DipaliS
            ' Created               :   October 21, 2004
            ' Revisions             :
            '=====================================================================
            Private Shared Function TaskType_GetQueryString(ByVal strQString As String) As String
                Dim strArrQString As String() = Split(strQString, "&")
                Dim blnFound As Boolean
                Dim intCount As Integer
                Dim intlastIndex As Integer = strArrQString.Length - 1

                strQString = ""
                For intCount = 0 To intlastIndex
                    If InStr(strArrQString(intCount).ToLower, "taskprojectid") <> 0 Then
                        If blnFound = False Then
                            strQString += strArrQString(intCount) + "&"
                        End If
                        blnFound = True
                    Else
                        strQString += strArrQString(intCount) + "&"
                    End If
                Next

                Return Left(strQString, strQString.Length - 1)

            End Function

#End Region

            Public Sub New()

            End Sub

            Protected Overrides Sub Finalize()
                MyBase.Finalize()
            End Sub
        End Class
    End Namespace
End Namespace
