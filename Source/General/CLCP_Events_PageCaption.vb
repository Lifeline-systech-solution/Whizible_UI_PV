Imports ProjectByNet
Namespace CommonEngine
    Namespace General
        Public Class CLCP_Events_PageCaption

            Public Shared Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As EventHandlers.WAF_General)
                Cancel = False
                'This Event will occur before link print
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID
                        'Modified By JyotiG
                        'Date :24-Aug-2006
                        'Issue ID : 5687
                        'Start
                        Case CommonFunction.Constants.APP_TAG_TAB_BASELINE_REVISION_REASON
                            Dim strMode As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "").ToString().ToUpper().Trim()
                            If Left(strMode, 1) = "A" Or Left(strMode, 1) = "R" Then
                                Args.LeftPageCaption = "Baseline Revision Reason"
                            ElseIf Left(strMode, 1) = "S" Then
                                Args.LeftPageCaption = "Sender Comments"
                            End If
                            'End
                            'Modified By JyotiG
                            'Date :23-Aug-2006
                            'Issue ID : 5687
                            'Start
                        Case CommonFunction.Constants.APP_TAG_TAB_BASELINE_COMMENTS
                            Dim strFormAction As String
                            strFormAction = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FormAction"), ""), String).Trim()
                            If strFormAction = "S" Then
                                Args.LeftPageCaption = "Sender Comments"
                            ElseIf strFormAction = "A" Or strFormAction = "R" Then
                                Args.LeftPageCaption = "Approver Comments"
                            End If
                            'End(Done By JyotiG)
                            'Added by VivekP On 5 August 2005 For WhizibleSEM SP4 IssueID-87
                        Case CommonFunction.Constants.APP_TAG_PROJECTTIMESHEET_COMMENT
                            If HttpContext.Current.Request.QueryString("ViewComment") = "ViewComment" Then
                                Args.LeftPageCaption = "View Comment"
                            End If
                            If HttpContext.Current.Request.QueryString("FROM") = "ProjectTimesheet" Then
                                Args.LeftPageCaption = "View Comment"
                            End If
                            'End Of Addition On 5 August 2005 For WhizibleSEM Sp4 IssueID-87


                            'Added By Paresh B for Rate Contract page om Aug . 04, 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_RATE_CONTRACT
                            'Modified (commented) by ShamkantD on 13 Oct 2004
                            'Dim strSQL As String
                            'Dim drRateContractLabel As IDataReader
                            'strSQL = "usp_Get_Rate_Contract_Caption " & HttpContext.Current.Session("intProjectId").ToString
                            'drRateContractLabel = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            'If drRateContractLabel.Read() Then
                            '    If Not IsDBNull(drRateContractLabel(0)) Then Args.LeftPageCaption = drRateContractLabel(0).ToString
                            'End If
                            'drRateContractLabel = Nothing
                            'End of Modification - ShamkantD on 13 Oct 2004

                            'Added by ShamkantD on 13 Oct 2004
                            'Get the node label so that it can be printed as caption
                            Dim strNodeLabel As String = ""
                            Dim strQuery As String = "usp_Sel_GetContractType_NodeLabel_ForProject " & HttpContext.Current.Session("intProjectID").ToString
                            strNodeLabel = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
                            If strNodeLabel.Trim() <> "" Then
                                Args.LeftPageCaption = strNodeLabel
                            End If

                            'Print the Project Name
                            Dim drProjectDetails As IDataReader = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            Dim strProjectName As String = ""
                            If drProjectDetails.Read = True Then
                                strProjectName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectDetails("ProjectName"), ""), "").ToString()
                            End If
                            CommonFunction.Data.DisposeDataReader(drProjectDetails)
                            If strProjectName.Trim() <> "" Then
                                Args.RightPageCaption = "Project: " & strProjectName
                            End If

                        Case CommonFunction.Constants.APP_TAG_PM_FIXED_BID
                            'Get the node label so that it can be printed as caption
                            Dim strNodeLabel As String = ""
                            Dim strQuery As String = "usp_Sel_GetContractType_NodeLabel_ForProject " & HttpContext.Current.Session("intProjectID").ToString
                            strNodeLabel = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
                            If strNodeLabel.Trim() <> "" Then
                                Args.LeftPageCaption = strNodeLabel
                            End If

                            'Print the Project Name
                            Dim drProjectDetails As IDataReader = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            Dim strProjectName As String = ""
                            If drProjectDetails.Read = True Then
                                strProjectName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectDetails("ProjectName"), ""), "").ToString()
                            End If
                            CommonFunction.Data.DisposeDataReader(drProjectDetails)
                            If strProjectName.Trim() <> "" Then
                                Args.RightPageCaption = "Project: " & strProjectName
                            End If

                        Case CommonFunction.Constants.APP_TAG_PROJECT_DOH
                            'Print the Project Name
                            Dim drProjectDetails As IDataReader = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            Dim strProjectName As String = ""
                            If drProjectDetails.Read = True Then
                                strProjectName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectDetails("ProjectName"), ""), "").ToString()
                            End If
                            CommonFunction.Data.DisposeDataReader(drProjectDetails)
                            If strProjectName.Trim() <> "" Then
                                Args.RightPageCaption = "Project: " & strProjectName
                            End If
                            'End of addition - ShamkantD on 13 Oct 2004

                        Case CommonFunction.Constants.TAG_PROJECT_INFORMATION
                            If Gen.IsListPage = False Then
                                Dim lngTagID As Long = CommonFunction.Constants.TAG_LIST_OF_PROJECTS
                                If WhizGlobal.UseHashTable = "N" Then
                                    Dim drTagMaster As IDataReader
                                    Dim strSQL As String

                                    'Get the details for the selected Page
                                    If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = WhizGlobal.LCID Then
                                        'Local culture ID is same as the default culture id
                                        strSQL = "usp_Sel_v_tbl_UI_TagMaster  " + lngTagID.ToString
                                    Else
                                        'Culture ID is other than the default culture id
                                        'Check if the Culture is supported by the system
                                        'Yes. Culture is supported. Retrieve the data specific to that Culture 
                                        strSQL = "usp_Sel_v_tbl_UI_TagMaster_Culture " & WhizGlobal.TagID.ToString & ", " + lngTagID.ToString
                                        drTagMaster = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        If Not drTagMaster.Read Then
                                            'Local culture ID is same as the default culture id
                                            strSQL = "usp_Sel_v_tbl_UI_TagMaster  " + lngTagID.ToString
                                        Else
                                            'Dispose the Data reader
                                            CommonFunction.Data.DisposeDataReader(drTagMaster)
                                        End If
                                    End If

                                    drTagMaster = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If drTagMaster.Read() Then
                                        If Not IsDBNull(drTagMaster("TagDescription")) Then Args.LeftPageCaption = drTagMaster("TagDescription").ToString
                                    End If
                                    'Dispose the Data reader
                                    CommonFunction.Data.DisposeDataReader(drTagMaster)
                                Else
                                    Dim objUITagMaster As New CommonEngines.HashTables.UITagMaster

                                    If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = WhizGlobal.LCID Then
                                        'Local culture ID is same as the default culture id
                                        objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(lngTagID)
                                    Else
                                        'Culture ID is other than the default culture id
                                        'Check if the Culture is supported by the system
                                        'Yes. Culture is supported. Retrieve the data specific to that Culture 
                                        objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterCultureObject(lngTagID.ToString.Trim + WhizGlobal.LCID.ToString)
                                        If objUITagMaster Is Nothing Then
                                            'No. Culture is NOT supported. Retrieve the data from the defual culture 
                                            objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(lngTagID)
                                        End If
                                    End If
                                    'Page Caption from the hash table
                                    Args.LeftPageCaption = objUITagMaster.TagDescription.ToString

                                    objUITagMaster = Nothing
                                End If

                                '''Start_AJ_03Oct2006
                                ''Dim strTagID As String = CStr(WhizGlobal.TagID)
                                ''Dim strRoleID As String = CStr(WhizGlobal.RoleID)
                                ''Dim strUserID As String = CStr(WhizGlobal.UserID)
                                ''Dim strSQL1 As String = "usp_WSEM_Sel_UserAccessibleForms " + strTagID + "," + strRoleID + ",'" + strUserID + "'"
                                ''Dim argsCombo As New CommonFunctions.HTMLControls.WAF_DropDown
                                ''argsCombo.ReturnHTML = True
                                ''argsCombo.WidthInPixel = 250
                                ''argsCombo.DropdownGroupingColumn = "Parent"
                                ''argsCombo.ToBeInserted = "onchange='CreateRecordOnChange()'"
                                ''Args.RightPageCaption = "Go to: " + CommonFunction.HTMLControls.DrawComboBox("CreateRecord", strSQL1, argsCombo)
                                ''argsCombo = Nothing
                                '''End_AJ_03Oct2006


                                '---------- Commented and added BY Purvaj on 10 Jun 2008
                                '---------- new configurable workflow added. Hence condition added, depending on the workflow, status is displayed.

                                Dim strAction As String = ""
                                If Gen.PrimaryKeyValue <> "" Then
                                    strAction = CommonFunction.WhizibleWorkflow.GetPageCaption(CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING.ToString, Gen.PrimaryKeyValue).ToString
                                End If

                                If strAction <> "" Then
                                    If InStr(strAction.ToUpper.ToString.Trim, "PENDING") > 0 Then
                                        Args.RightPageCaption = " Status: " + strAction
                                    Else
                                        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("LoginType"), "") = "C" Then 'strLoginType
                                            Args.RightPageCaption = " Status: " + strAction
                                        Else 'Commented By ViajyD  For IssueID :32456
                                            Args.RightPageCaption = "<Img border=0 title='Workflow Approval Status' src='../../Images/DB/TrackView.gif' style= 'cursor: pointer;' onclick=""javascript:showdetails(0," + CommonFunction.General.CheckIsNothing(CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING.ToString, "0") + "," + Gen.PrimaryKeyValue.ToString + ")"">" + " Status: " + strAction
                                        End If

                                    End If
                                Else
                                    '---------- End addition Purvaj
                                    'Added by ShamkantD on 5 Oct 2004 - Added for Project Information page
                                    Dim strBaselineStatus As String = ""
                                    Dim blnIsProjectCreationWorkflowReqd As Boolean = False

                                    'Get the status of 'Project creation workflow required' flag
                                    blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("blnIsProjectCreationWorkflowReqd"), "False"), Boolean)

                                    If blnIsProjectCreationWorkflowReqd = True Then
                                        strBaselineStatus = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("EXEC usp_Sel_tbl_PM_ProjectRevision_BaselineStatus " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString().Trim().ToUpper()
                                        If strBaselineStatus = "C" Then
                                            Args.RightPageCaption = "Approval Status: Pending Approval"
                                        End If

                                        If strBaselineStatus = "S" Then
                                            Args.RightPageCaption = "Approval Status: Sent for Approval"
                                        End If

                                        If strBaselineStatus = "R" Then
                                            Args.RightPageCaption = "Approval Status: Rejected"
                                        End If

                                        If strBaselineStatus = "B" Then
                                            Args.RightPageCaption = "Approval Status: Approved"
                                        End If
                                        'End of addition - ShamkantD on 5 Oct 2004
                                    End If
                                End If

                            End If

                        Case CommonFunction.Constants.APP_TAG_RESOURCES
                            If Gen.IsListPage = False And Gen.PrimaryKeyValue.Trim <> "" Then
                                'UI Page
                                Dim drResources As IDataReader
                                'Get the UserName value for the Role identified by the Primary Key
                                drResources = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ProjectEmployeeRole " + Gen.PrimaryKeyValue.Trim, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If (drResources.Read) Then
                                    Args.RightPageCaption = CommonFunction.General.CheckIsNothing(drResources("UserName").ToString)
                                    'Modified and Added by PrashantD on 9 May 2007 for CleanUp Activity
                                    Args.RightPageCaption += " - " + CommonFunction.General.CheckIsNothing(drResources("EmployeeName").ToString)
                                    'Dim strResourceCaption As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_Sel_v_tbl_UI_ControlTagMaster_FieldDetails " + CommonFunction.Constants.APP_TAG_RESOURCES.ToString + ",'ControlCaption','ControlName=''NonDatabase1'''", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))

                                    Dim objTemplate As WebPages.Template.WhizTemplate
                                    objTemplate = New WebPages.Template.WhizTemplate
                                    objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                    Dim strResourceCaption As String = objTemplate.GetResourceString("RESOURCE_RIGHT_PAGECAPTION")
                                    objTemplate = Nothing
                                    'End of addition by PrashantD on 9 May 2007 for Cleanup Activity


                                    If strResourceCaption.Trim <> "" Then Args.RightPageCaption = strResourceCaption + " : " + Args.RightPageCaption
                                End If
                                CommonFunction.Data.DisposeDataReader(drResources)
                            End If
                        Case CommonFunction.Constants.APP_TAG_BG_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS

                            'UI Page
                            Dim drResources As IDataReader
                            'Dim intBGEmployeeID As Integer
                            Dim strBGEmployeeID As String
                            strBGEmployeeID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupEmployeeID"), "0").ToString
                            'Added by JyotiG
                            'Start_JG_12307_26-Mar-2007
                            'Added By Rutuja D. on 4 Jan 2021 For IsueeId = 28830
                            If (strBGEmployeeID <> "0") Then
                                HttpContext.Current.Session("BusinessGroupEmployeeID") = strBGEmployeeID
                            End If
                            'End of Added By Rutuja D. on 4 Jan 2021 For IsueeId = 28830

                            If (strBGEmployeeID = "0") Or (strBGEmployeeID = "") Then
                                strBGEmployeeID = CType(HttpContext.Current.Session("BusinessGroupEmployeeID"), String)
                            End If
                            'End_JG_12307_26-Mar-2007
                            'Get the UserName value for the Role identified by the Primary Key
                            drResources = CommonFunction.Data.GetDataReader(" Select EmployeeName from v_tbl_CNF_BusinessGroups_MiddleLevelResources Where BusinessGroupEmployeeID = " & strBGEmployeeID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If (drResources.Read) Then
                                Args.RightPageCaption = " Resource : " & CommonFunction.General.CheckIsNothing(drResources("EmployeeName").ToString)

                            End If
                            CommonFunction.Data.DisposeDataReader(drResources)
                        Case CommonFunction.Constants.APP_TAG_OU_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS

                            'UI Page
                            Dim drResources As IDataReader
                            'Dim intOUEmployeeID As Integer
                            Dim strOUEmployeeID As String
                            strOUEmployeeID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("LocationEmployeeID"), "0").ToString

							'Added By Rutuja D. on 4 Jan 2021 For IsueeId = 28830
                            If (strOUEmployeeID <> "0") Then
                                HttpContext.Current.Session("LocationEmployeeID") = strOUEmployeeID
                            End If
                            'End Of Added By Rutuja D. On 4 Jan 2021 For IsueeId = 28830

                            'Added by JyotiG
                            'Start_JG_12307_26-Mar-2007
                            'Issue :1. Go to Configuration --> Organisation --> Organisation Unit --> Middle Level Resource[Subtab]
                            '2. Click on Set Project Access link
                            '3. Click on Filter --> Apply the filter 
                            '4. Now clear the filter --> select the project and click on save 
                            'Actual Result : Page crash occures 
                            If (strOUEmployeeID = "0") Or (strOUEmployeeID = "") Then
                                strOUEmployeeID = CType(HttpContext.Current.Session("LocationEmployeeID"), String)
                            End If
                            'End_JG_12307_26-Mar-2007
                            'Get the UserName value for the Role identified by the Primary Key
                            drResources = CommonFunction.Data.GetDataReader(" Select EmployeeName from v_tbl_PM_Location_MiddleLevelResources Where LocationEmployeeID = " & strOUEmployeeID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If (drResources.Read) Then
                                Args.RightPageCaption = " Resource : " & CommonFunction.General.CheckIsNothing(drResources("EmployeeName").ToString)

                            End If
                            CommonFunction.Data.DisposeDataReader(drResources)
                        Case CommonFunction.Constants.APP_TAG_DU_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS

                            'UI Page
                            Dim drResources As IDataReader
                            Dim intDUEmployeeID As Integer
                            intDUEmployeeID = CType(HttpContext.Current.Request.QueryString("ResourcePoolEmployeeID"), Integer)

                            'Get the UserName value for the Role identified by the Primary Key
                            drResources = CommonFunction.Data.GetDataReader(" Select EmployeeName from v_tbl_PM_ResourcePool_MiddleLevelResources Where ResourcePoolEmployeeID = " & intDUEmployeeID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If (drResources.Read) Then
                                Args.RightPageCaption = " Resource : " & CommonFunction.General.CheckIsNothing(drResources("EmployeeName").ToString)

                            End If
                            CommonFunction.Data.DisposeDataReader(drResources)

                        Case CommonFunction.Constants.APP_TAG_DT_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS

                            'UI Page
                            Dim drResources As IDataReader
                            Dim intDTEmployeeID As Integer
                            intDTEmployeeID = CType(HttpContext.Current.Request.QueryString("GroupEmployeeID"), Integer)

                            'Get the UserName value for the Role identified by the Primary Key
                            drResources = CommonFunction.Data.GetDataReader(" Select EmployeeName from v_tbl_PM_GroupMaster_MiddleLevelResources Where GroupEmployeeID = " & intDTEmployeeID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If (drResources.Read) Then
                                Args.RightPageCaption = " Resource : " & CommonFunction.General.CheckIsNothing(drResources("EmployeeName").ToString)

                            End If
                            CommonFunction.Data.DisposeDataReader(drResources)

                        Case CommonFunction.Constants.APP_TAG_RATECONTRACTBYROLE
                            Dim objTemplate As WebPages.Template.WhizTemplate
                            'Create object of the ProjectByNet Template Class
                            objTemplate = New WebPages.Template.WhizTemplate
                            'Initialize the Resources
                            objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                            Dim strSQL As String
                            Dim drContractType As IDataReader
                            'Get the page caption depending upon contract type
                            Dim strRateFor As String = ""
                            Dim strProjectID As String
                            Dim intContractType As Integer
                            strProjectID = HttpContext.Current.Session("intProjectID").ToString
                            strSQL = "SELECT ContractType FROM tbl_PM_Project WHERE ProjectID = " & strProjectID
                            drContractType = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If drContractType.Read Then
                                intContractType = CType(drContractType("ContractType"), Integer)
                                Select Case intContractType
                                    Case CommonFunction.Constants.RATECONTRACTTYPE.CONTRACT_BY_ROLE
                                        Args.LeftPageCaption = objTemplate.GetResourceString("PROJECT_RATE_CONTRACT_BYROLE")
                                    Case CommonFunction.Constants.RATECONTRACTTYPE.CONTRACT_BY_RESOURCE
                                        Args.LeftPageCaption = objTemplate.GetResourceString("PROJECT_RATE_CONTRACT_BYRESOURCE")
                                End Select
                            End If
                            CommonFunctions.Data.DisposeDataReader(drContractType)
                            objTemplate = Nothing
                        Case CommonFunction.Constants.APP_TAG_CONFIG_TYPE_SECURITY
                            If Gen.IsListPage = True Then
                                Dim objTemplate As WebPages.Template.WhizTemplate
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.IB_IssueTypes", "AppResources")
                                Dim strResourceCaption As String = objTemplate.GetResourceString("TYPE_CONFIG_ROLE")
                                objTemplate = Nothing
                                'List Page
                                Dim drRole As IDataReader
                                'Get the Role value for the Role identified by the Primary Key
                                drRole = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_Role " + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("Role"), "0"), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If (drRole.Read) Then
                                    Args.RightPageCaption = CommonFunction.General.CheckIsNothing(drRole("RoleDescription").ToString)
                                    If strResourceCaption.Trim <> "" Then Args.RightPageCaption = strResourceCaption + " : " + Args.RightPageCaption
                                End If
                                CommonFunction.Data.DisposeDataReader(drRole)
                            End If
                        Case CommonFunction.Constants.APP_TAG_SDLC_PROCESS
                            If (Gen.PrimaryKeyValue.Trim = "" And Gen.IsListPage = True) Or Gen.IsListPage = False Then
                                '_____Only for Master Page NOT FOR SUB TAG LIST PAGE
                                'For LIST and UI Page show the Process Name in the Page Caption
                                Dim strProcessID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("ProcessID"))

                                'Integrated by MrugajaB on 3rd Jan 2006 for Whiz2 Processes - Build 29
                                'Added by ManishK on 30th Aug 2005 

                                'Dim strProcessName As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetSQLDataScalar("usp_Sel_tbl_PRS_Process_Published '" + strProcessID + "'"))
                                Dim strProcessName As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetSQLDataScalar("usp_Sel_tbl_PRS_Project_SDLC_Details_ProcessName " + HttpContext.Current.Session("intProjectID").ToString + "," + strProcessID))
                                'End of addition by ManishK on 30th Aug 2005
                                'End Integration        
                                If strProcessName.Trim <> "" Then Args.LeftPageCaption += " : " + strProcessName
                            End If
                        Case CommonFunctions.Constants.TAG_AUDIT_TRAIL
                            ''Added by Dhanashri S on 29 Oct 2015
                            Dim strPageName As String = ""
                            ''End of Addition by Dhanashri S on 29 Oct 2015

                            'Added by MrugajaB on 30th April,2005 for integrating PBNV4 SP6 Hotfix ID.4.0.116-WAF in WhizibleSEM Sp3
                            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("IsSubTagID")) <> "1" Then
                                Dim strTagID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("TagID"))

                                ''Added by Dhanashri S on 29 Oct 2015
                                'Modified By Shrikant B On 1 Dec 2008 For WAF3_GEN_18
                                If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = WhizGlobal.LCID Then
                                    ''End of Addition by Dhanashri S on 29 Oct 2015

                                    strPageName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetSQLDataScalar("Select isnull(TagDescription,'') From v_tbl_UI_TagMaster Where TagID= '" + strTagID + "'"))

                                    ''Added by Dhanashri S on 29 Oct 2015
                                Else
                                    strPageName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetSQLDataScalar("Select isnull(TagDescription,'') From tbl_UI_TagMaster_Culture Where TagID= '" + strTagID + "'"))
                                End If
                                ''End of Addition by Dhanashri S on 29 Oct 2015

                                'Modification End By Shrikant B On 1 Dec 2008 For WAF3_GEN_18

                                If strPageName.Trim <> "" Then Args.RightPageCaption = strPageName

                            Else
                                'End Addition

                                'For the Audit Trail Page Show the Parent Page Caption as Right Side Page Caption
                                Dim strTagID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("TagID"))
                                ''Commented and added by PrashantSJ on 15th June 2007
                                ''Purpose: For Subtag It displays wrong page caption so now it will display correct subtab name
                                'Dim strPageName As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetSQLDataScalar("Select isnull(TagDescription,'') From v_tbl_UI_TagMaster Where TagID= '" + strTagID + "'"))

                                ''Added by Dhanashri S on 29 Oct 2015
                                'Modified By Shrikant B On 1 Dec 2008 For WAF3_GEN_18
                                If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = WhizGlobal.LCID Then
                                    ''End of Addition by Dhanashri S on 29 Oct 2015

                                    strPageName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetSQLDataScalar("Select isnull(SubTagName,'') From v_tbl_UI_SubTagMaster Where SubTagID= '" + strTagID + "'"))

                                    ''Added by Dhanashri S on 29 Oct 2015
                                Else
                                    strPageName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetSQLDataScalar("Select isnull(SubTagName,'') From tbl_UI_SubTagMaster_Culture Where SubTagID= '" + strTagID + "'"))
                                End If
                                ''End of Addition by Dhanashri S on 29 Oct 2015

                                'End of comment by PrashantSJ on 15th June 2007

                                If strPageName.Trim <> "" Then Args.RightPageCaption = strPageName
                            End If

                            'added by SachinR   on 17 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_PROCESS, CommonFunction.Constants.APP_TAG_METRIC_LIST, CommonFunction.Constants.APP_TAG_PROCESS_MEASUREMENT_INDICATOR
                                Dim strOUPoolID As String
                                Dim strSQL As String
                                Dim objDr As IDataReader
                                Dim objTemplate As WebPages.Template.WhizTemplate
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                strOUPoolID = HttpContext.Current.Request.QueryString("OUPoolID") + ""
                                If strOUPoolID <> "" And strOUPoolID <> "0" Then
                                    strSQL = "usp_Sel_tbl_PM_Location " + strOUPoolID.Trim
                                    objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If objDr.Read Then
                                        Args.RightPageCaption = objTemplate.GetResourceString("CAPTION_OU") + " : " + CommonFunction.Data.CheckIsDBNull(objDr("Location"), "").ToString
                                    End If
                                    CommonFunction.Data.DisposeDataReader(objDr)
                                End If
                                objTemplate = Nothing

                                'addition end
                                'added by SachinR   on 13 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                                Dim strSQL As String
                                Dim objDr As IDataReader
                                Dim objTemplate As WebPages.Template.WhizTemplate
                                Dim strScheduleTypeID As String
                                Dim strScheduleID As String
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                If Gen.IsListPage = False Then
                                    strScheduleTypeID = "NULL"
                                    strScheduleID = "NULL"
                                    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ScheduleTypeID"), "") <> "" Then
                                        strScheduleTypeID = HttpContext.Current.Request.QueryString("ScheduleTypeID") + ""
                                    Else
                                        strScheduleID = Gen.PrimaryKeyValue.Trim + ""
                                    End If
                                    If strScheduleID = "" Then strScheduleID = "NULL"
                                    If strScheduleTypeID = "" Then strScheduleTypeID = "NULL"

                                    strSQL = "usp_Sel_tbl_PM_CompanySchedules " + strScheduleTypeID.Trim + "," + strScheduleID.Trim
                                    objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If objDr.Read Then
                                        Args.RightPageCaption = objTemplate.GetResourceString("SCHEDULETYPE") + " : " + CommonFunction.Data.CheckIsDBNull(objDr("LabelSchedule"), "").ToString
                                    End If
                                    CommonFunction.Data.DisposeDataReader(objDr)
                                End If
                                objTemplate = Nothing

                                'Added by GokulP on 09 Sept 2009 for IssueID = 33092
                                Dim strAction As String = ""
                                If Gen.IsListPage = False And Gen.PrimaryKeyValue.Trim <> "" Then
                                    If Gen.PrimaryKeyValue <> "" Then
                                        strAction = CommonFunction.WhizibleWorkflow.GetPageCaption(CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE, Gen.PrimaryKeyValue).ToString
                                    End If

                                    If strAction <> "" Then
                                        If InStr(strAction.ToUpper.ToString.Trim, "PENDING") > 0 Then
                                            Args.RightPageCaption = " Status: " & strAction
                                        Else
                                            Args.RightPageCaption = "<Img border=0 title='Workflow Approval Status' src='../../Images/DB/TrackView.gif' style= 'cursor: pointer;' onclick=""javascript:showdetails(0," + CommonFunction.General.CheckIsNothing(CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString, "0") + "," + Gen.PrimaryKeyValue.ToString + ")"">" + " Status: " & strAction
                                        End If
                                    End If
                                End If
                                'End of Addition by GokulP on 09 Sept 2009 for IssueID = 33092

                                '##### Onsite Offshore functionality
                                'Added By AmitD on 20 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_RTS_SHOW_HISTORY_EMPLOYEE
                                Dim drGetEmployeeName As IDataReader
                                Dim strEmployeeName As String
                                Dim strSQL As String
                                'Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888
                                'Check whether request came from Onsite Resource Timesheet
                                Dim strEmployeeID As String
                                'Commented and Modified By JyotiG
                                'Start_JG_11135_09-Apr-2007
                                'If CType(HttpContext.Current.Request.QueryString("FromWhere"), String) = "Proxy" Then
                                If CType(HttpContext.Current.Request("FromWhere"), String) = "Proxy" Or CType(HttpContext.Current.Request.Form("FromWhere"), String) = "Proxy" Then
                                    'strEmployeeID = CType(HttpContext.Current.Request.QueryString("EmployeeID"), String)
                                    strEmployeeID = CType(HttpContext.Current.Request("EmployeeID"), String)
                                    'End_JG_11135_09-Apr-2007
                                Else
                                    strEmployeeID = CType(HttpContext.Current.Session("intUserID"), String)
                                End If
                                'Added By JyotiG
                            'Start_JG_11135_09-Apr-2007
                            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                            ''Args.LeftPageCaption = CommonFunction.HTMLControls.DrawTextBox("EmployeeID", "EmployeeID", , , , strEmployeeID.Trim, , , , , , True, , True)
                            Args.LeftPageCaption = CommonFunction.HTMLControls.DrawTextBox("EmployeeID", "EmployeeID", , , , strEmployeeID.Trim, , , , , , True, , True, EnableHTMLEncode:=True)
                                'End_JG_11135_09-Apr-2007
                                'Addition End by SantoshK on 20th March 2006

                                strSQL = "Select EmployeeName From tbl_PM_Employee WHERE EmployeeID = " + strEmployeeID
                                drGetEmployeeName = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                If drGetEmployeeName.Read Then
                                    strEmployeeName = CType(CommonFunctions.Data.CheckIsDBNull(drGetEmployeeName("EmployeeName"), ""), String)
                                End If
                                CommonFunctions.Data.DisposeDataReader(drGetEmployeeName)
                                Args.LeftPageCaption += "Resource Timesheet Status History For" + ": " + CType(strEmployeeName, String)

                        Case CommonFunction.Constants.APP_TAG_RTS_SHOW_HISTORY_APPROVERS
                                Dim drGetEmployeeName As IDataReader
                                Dim strApproverName As String
                                Dim strEmployeeName As String
                                Dim strSQL As String
                                strSQL = "Select EmployeeName From tbl_PM_Employee WHERE EmployeeID = " + CType(HttpContext.Current.Session("intUserID"), String)
                                drGetEmployeeName = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                If drGetEmployeeName.Read Then
                                    strApproverName = CType(CommonFunctions.Data.CheckIsDBNull(drGetEmployeeName("EmployeeName"), ""), String)
                                End If
                                CommonFunctions.Data.DisposeDataReader(drGetEmployeeName)

                                strSQL = "Select EmployeeName from tbl_PM_Employee Where EmployeeID = (Select Top 1 EmployeeID From tbl_PM_ResourceTimesheetStatus_History Where ResourceTimesheetID = " + CType(HttpContext.Current.Request.QueryString("ResourceTimesheetID"), String) + ")"
                                drGetEmployeeName = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                If drGetEmployeeName.Read Then
                                    strEmployeeName = CType(CommonFunctions.Data.CheckIsDBNull(drGetEmployeeName("EmployeeName"), ""), String)
                                End If
                                CommonFunctions.Data.DisposeDataReader(drGetEmployeeName)

                                Args.LeftPageCaption = "Resource Timesheet Status History for Approver: " + CType(strApproverName, String)
                                Args.RightPageCaption = "Resource Timesheet Of: " + CType(strEmployeeName, String)

                                'End Addition

                                'Added by MrugajaB on 21st March 2005 - Added for 'Requested Resources' page 


                        Case CommonFunction.Constants.APP_TAG_RESOURCEREQUEST, CommonFunction.Constants.APP_TAG_EXTENDRESOURCEREQUEST

                                Dim strRequestStatus As String = ""
                                Dim intAllowResourceAllocation As Boolean
                                Dim lngRequestID As Long = 0
                                Dim strQuery As String
                                Dim strSQL As String

                                'Get the status of 'Resource allocation workflow required' flag
                                'Modified By VidyaJ - Performance Issue - Resources - IssueID - 85
                                'Get whethere resource allocation workflow is applicable or not from application variable

                                ' strSQL = "SELECT AllowResourceAllocation from tbl_PM_CompanyInformation"
                                intAllowResourceAllocation = CommonFunction.Application.AllowResourceAllocation 'CType(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Boolean)
                                'End Of Modifications

                                If intAllowResourceAllocation = True Then
                                    If Gen.PrimaryKeyValue <> "" Then
                                        lngRequestID = CType(Gen.PrimaryKeyValue, Long)
                                        If lngRequestID <> 0 Then
                                            strQuery = "Exec usp_Sel_tbl_PM_ResourceRequest_GetStatusString " & lngRequestID.ToString()
                                            strRequestStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")

                                            Args.RightPageCaption = "Status: " & strRequestStatus
                                        End If
                                    End If
                                End If

                                'End Addition

                                '--------- Added BY PurvaJ on 4 Jun 2008
                                '--------- to print workflow approval status 
                        Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS
                                Dim strAction As String = ""
                                If Gen.IsListPage = False And Gen.PrimaryKeyValue.Trim <> "" Then
                                    If Gen.PrimaryKeyValue <> "" Then
                                        strAction = CommonFunction.WhizibleWorkflow.GetPageCaption(CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS, Gen.PrimaryKeyValue).ToString
                                    End If

                                    If strAction <> "" Then
                                        If InStr(strAction.ToUpper.ToString.Trim, "PENDING") > 0 Then
                                            Args.RightPageCaption = " Status: " & strAction
                                        Else
                                            Args.RightPageCaption = "<Img border=0 title='Workflow Approval Status' src='../../Images/DB/TrackView.gif' style= 'cursor: pointer;' onclick=""javascript:showdetails(0," + CommonFunction.General.CheckIsNothing(CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString, "0") + "," + Gen.PrimaryKeyValue.ToString + ")"">" + " Status: " & strAction
                                        End If
                                    End If
                                End If

                        Case CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT
                                Dim strAction As String = ""
                                If Gen.IsListPage = False And Gen.PrimaryKeyValue.Trim <> "" And Args.LeftPageCaption.ToUpper <> "IMPACT ANALYSIS" Then


                                    If Gen.PrimaryKeyValue <> "" Then
                                        strAction = CommonFunction.WhizibleWorkflow.GetPageCaption(CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT, Gen.PrimaryKeyValue).ToString
                                    End If

                                    If strAction <> "" Then
                                        If InStr(strAction.ToUpper.ToString.Trim, "PENDING") > 0 Then
                                            Args.RightPageCaption = " Status: " & strAction
                                        Else
                                            Args.RightPageCaption = "<Img border=0 title='Workflow Approval Status' src='../../Images/DB/TrackView.gif' style= 'cursor: pointer;' onclick=""javascript:showdetails(0," + CommonFunction.General.CheckIsNothing(CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT.ToString, "0") + "," + Gen.PrimaryKeyValue.ToString + ")"">" + " Status: " & strAction
                                        End If
                                    End If
                                End If

                        Case CommonFunction.Constants.APP_TAG_MODULES
                                Dim strAction As String = ""
                                If Gen.IsListPage = False And Gen.PrimaryKeyValue.Trim <> "" Then
                                    If Gen.PrimaryKeyValue <> "" Then
                                        strAction = CommonFunction.WhizibleWorkflow.GetPageCaption(CommonFunction.Constants.APP_TAG_MODULES, Gen.PrimaryKeyValue).ToString
                                    End If

                                    If strAction <> "" Then
                                        If InStr(strAction.ToUpper.ToString.Trim, "PENDING") > 0 Then
                                            Args.RightPageCaption = " Status: " & strAction
                                        Else
                                            Args.RightPageCaption = "<Img border=0 title='Workflow Approval Status' src='../../Images/DB/TrackView.gif' style= 'cursor: pointer;' onclick=""javascript:showdetails(0," + CommonFunction.General.CheckIsNothing(CommonFunction.Constants.APP_TAG_MODULES.ToString, "0") + "," + Gen.PrimaryKeyValue.ToString + ")"">" + " Status: " & strAction
                                        End If
                                    End If
                                End If

                        Case CommonFunction.Constants.APP_TAG_SUB_PROJECTS
                                Dim strAction As String = ""
                                If Gen.IsListPage = False And Gen.PrimaryKeyValue.Trim <> "" Then
                                    If Gen.PrimaryKeyValue <> "" Then
                                        strAction = CommonFunction.WhizibleWorkflow.GetPageCaption(CommonFunction.Constants.APP_TAG_SUB_PROJECTS, Gen.PrimaryKeyValue).ToString
                                    End If

                                    If strAction <> "" Then
                                        If InStr(strAction.ToUpper.ToString.Trim, "PENDING") > 0 Then
                                            Args.RightPageCaption = " Status: " & strAction
                                        Else
                                            Args.RightPageCaption = "<Img border=0 title='Workflow Approval Status' src='../../Images/DB/TrackView.gif' style= 'cursor: pointer;' onclick=""javascript:showdetails(0," + CommonFunction.General.CheckIsNothing(CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString, "0") + "," + Gen.PrimaryKeyValue.ToString + ")"">" + " Status: " & strAction
                                        End If
                                    End If
                                End If

                                'Commented by GokulP on 09 Sept 2009 for IssueID = 33092
                                'Description : This block is added in already defined case 
                                'Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                                '    Dim strAction As String = ""
                                '    If Gen.IsListPage = False And Gen.PrimaryKeyValue.Trim <> "" Then
                                '        If Gen.PrimaryKeyValue <> "" Then
                                '            strAction = CommonFunction.WhizibleWorkflow.GetPageCaption(CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE, Gen.PrimaryKeyValue).ToString
                                '        End If

                                '        If strAction <> "" Then
                                '            If InStr(strAction.ToUpper.ToString.Trim, "PENDING") > 0 Then
                                '                Args.RightPageCaption = " Status: " & strAction
                                '            Else
                                '                Args.RightPageCaption = "<Img border=0 title='Workflow Approval Status' src='../../Images/DB/TrackView.gif' style= 'cursor: pointer;' onclick=""javascript:showdetails(0," + CommonFunction.General.CheckIsNothing(CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString, "0") + "," + Gen.PrimaryKeyValue.ToString + ")"">" + " Status: " & strAction
                                '            End If
                                '        End If
                                '    End If
                                'End of Comment by GokulP on 09 Sept 2009 for IssueID = 33092

                                '----------- end addition PurvaJ

                    End Select
                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_TAG_TAB_PHASETASK_ACTIVITY
                            'added by SachinR   on 15 Oct 2004
                            'to show the activity name on the page caption
                            Dim strSQL As String
                            Dim objTemplate As WebPages.Template.WhizTemplate
                            Dim objDr As IDataReader

                            If Gen.PrimaryKeyValue <> "" Then
                                objTemplate = New WebPages.Template.WhizTemplate
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                strSQL = "usp_Sel_tbl_PRS_PhaseTask_Activity_Draft " + Gen.PrimaryKeyValue
                                objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If objDr.Read Then
                                    Args.RightPageCaption = objTemplate.GetResourceString("ACTIVITY") + " : " + CommonFunction.Data.CheckIsDBNull(objDr("Title"), "").ToString
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)
                                objTemplate = Nothing
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_PROCESS_PHASETASK_TEMPLATES
                            'to show the activity name on the page caption
                            Dim strSQL As String
                            Dim objTemplate As WebPages.Template.WhizTemplate
                            Dim objDr As IDataReader

                            If Gen.PrimaryKeyValue <> "" Then
                                objTemplate = New WebPages.Template.WhizTemplate
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                strSQL = "usp_Sel_tbl_PRS_PhaseTask_Template_Effort " + Gen.PrimaryKeyValue
                                objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If objDr.Read Then
                                    Args.RightPageCaption = objTemplate.GetResourceString("TASK") + " : " + CommonFunction.Data.CheckIsDBNull(objDr("PhaseTaskName"), "").ToString
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)
                                objTemplate = Nothing
                            End If
                            'addition end

                            'added by SachinR   on 06 Nov 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_ASSOCIATED_PHASE_TASK
                            'to show the task name on the page caption
                            Dim strSQL As String
                            Dim objTemplate As WebPages.Template.WhizTemplate
                            Dim objDr As IDataReader

                            If Gen.PrimaryKeyValue <> "" Then
                                objTemplate = New WebPages.Template.WhizTemplate
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                strSQL = "usp_Sel_GetProjectPhaseTaskDetils " + Gen.PrimaryKeyValue
                                objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If objDr.Read Then
                                    Args.RightPageCaption = objTemplate.GetResourceString("TASK") + " : " + CommonFunction.Data.CheckIsDBNull(objDr("PhaseTaskName"), "").ToString
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)
                                objTemplate = Nothing
                            End If
                            'addition end

                    End Select
                End If
            End Sub

        End Class
    End Namespace
End Namespace

