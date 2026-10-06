Imports ProjectByNet
Imports System.IO
Imports System.Net

Namespace CommonEngine
    Namespace General
        Public Class cEventHandlers
            '=====================================================================
            ' Class	Name	        :	cEventHandlers
            ' Purpose				:	This class is used to handles the following events
            '                           1. BeforeSave
            '                           2. AfterSave
            '                           3. PreRender
            '                           4. BeforeDelete
            '                           5. AfterDelete
            ' Description			:	Same as above
            ' Assumptions			:	None
            ' Dependencies			:	None
            ' Author				:	Ashish
            ' Created				:	September 01, 2003
            ' Revisions				:	
            '=====================================================================
            Private strActionCode As String
            Private strMasterPrimaryKey As String = ""
            Protected m_strToken As String
            Private m_objTemplate As WebPages.Template.WhizTemplate

            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
            'Code Modified:RajeshB          15 Jan 2005
            'Code Modified: AnugrahaL on 17 Jan 2006 to set the default action code.
            Public Property ActionCode() As String
                Get
                    Return strActionCode.ToString
                End Get
                Set(ByVal Value As String)
                    If Value Is Nothing Then
                        strActionCode = "DO_NOTHING"
                    Else
                        strActionCode = Value
                    End If
                End Set
            End Property

            'End Of Modifications - IssueID : 672

            Public WriteOnly Property MasterPrimaryKey() As String
                Set(ByVal Value As String)
                    strMasterPrimaryKey = Value
                End Set
            End Property


            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration

            Public Enum ReturnCodes
                DO_NOTHING
                ON_LOAD
                REDIRECT
                OPEN_WINDOW
                IGNORE_SAVE
                IGNORE_DELETE
                ' ***************************************************************************************
                ' Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_39
                ' ***************************************************************************************
                IGNORE_SAVE_AND_OPEN_WINDOW
                IGNORE_SAVE_AND_REDIRECT
                IGNORE_SAVE_AND_ON_LOAD
                IGNORE_DELETE_AND_OPEN_WINDOW
                IGNORE_DELETE_AND_REDIRECT
                IGNORE_DELETE_AND_ON_LOAD
                ' ***************************************************************************************
                ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_39
                ' ***************************************************************************************

            End Enum

            'End Of Modifications - IssueID : 672

#Region "APPLIED EVENTS"
            Public Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal CalledFrom As String, ByRef ConnectionID As Integer)
                'Called From will have one of these values: LIST, FORM
                strActionCode = ReturnCodes.DO_NOTHING.ToString
                If WhizGlobal.ParentTagID = 0 Then
                    Select Case WhizGlobal.TagID
                        'Your code will be written here
                        'Case 32
                        'ConnectionID=1 

                        ' Modified By MahendraV On 8:19 PM 6/20/2007 
                        ' Database update need to be moved in WhizForm_Init due to DataSet Related Changes For Whiziblesem 7
                        ' Commented code moved from PageListPreRender To WhizForm_Init
                        ' Start_MV_6/20/2007 
                        Case CommonFunction.Constants.APP_TAG_SQERT_LOCK
                            Dim strSQERTIDList As String = ""
                            Dim strSQLQuery As String = ""
                            ' Start_MV_6/20/2007 
                            Dim strBGID As String = ""
                            Dim strOUID As String = ""
                            Dim strProject As String = ""

                            'If Save link clicked, Save the changes
                            strSQERTIDList = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), ""), String)
                            If HttpContext.Current.Request.QueryString("Action") = "Save" Then

                                'strSQLQuery = "EXEC usp_CRW_ProjectSheet_UpdateLock '" & CType(strSQERTIDList, String) & "'"

                                strBGID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("BusinessGroupID"), ""), String)
                                strOUID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("LocationID"), ""), String)
                                strProject = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ProjectName"), ""), String)

                                'Modified by NitinVS on 2 Aug 2007 for WhizibleSEM 7 Removed pcfc from sp name 
                                strSQLQuery = "EXEC usp_CRW_ProjectSheet_UpdateLock '" & CType(strSQERTIDList, String) & "'"
                                'End Modification  by NitinVS on 2 Aug 2007 for WhizibleSEM 7 Removed pcfc from sp name 

                                'Aadded filters to Page
                                If strBGID <> "" Then
                                    strSQLQuery = strSQLQuery & "," + strBGID
                                Else
                                    strSQLQuery = strSQLQuery & ",NULL"
                                End If
                                If strOUID <> "" Then
                                    strSQLQuery = strSQLQuery & "," + strOUID
                                Else
                                    strSQLQuery = strSQLQuery & ",NULL"
                                End If
                                If strProject <> "" Then
                                    strSQLQuery = strSQLQuery & ",'" & strProject & "'"
                                Else
                                    strSQLQuery = strSQLQuery & ",NULL"
                                End If
                                ' Start_MV_6/20/2007
                                'Modified by NitinVS on 2 Aug 2007 for WhizibleSEM 7 changed datascaler to insertorupdate
                                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'End Modification  by NitinVS on 2 Aug 2007 for WhizibleSEM 7 datascaler to insertorupdate

                            End If
                            '    'End of addition - Mangesh Y on 6 Jan 2005
                            '    'End of addition - VivekP on 02 sep 2005
                            ' End_MV_6/20/2007 
                            ' Modified by MahendraV On 5:55 PM 6/28/2007
                            ' Database update need to be moved in WhizForm_Init from PageListPreRender due to DataSet Related Changes For Whiziblesem 7
                            ' Commented code moved from PageListPreRender To WhizForm_Init
                            ' IssueID(14030) Project > Project Confguration > Execution Template Selection : Page not getting refreshed
                            ' Start_MV_6/28/2007
                        Case CommonFunction.Constants.APP_TAG_SELECT_TEMPLATE_FOR_PROJECT
                            Dim strTemplateID As String
                            Dim StrSqlQuery As String
                            Dim StrScript As String
                            If HttpContext.Current.Request.QueryString("MODE") = "UPDATE_TEMPLATE" Then

                                strTemplateID = HttpContext.Current.Request.QueryString("TemplateID").ToString

                                strSqlQuery = "EXEC usp_Upd_tbl_PM_Project_AssociatePractice " & _
                                CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString() & _
                                ",Null,'" & CommonFunction.General.CheckIsNothing(WhizGlobal.UserName, "").ToString() & "'," & strTemplateID
                                CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            End If
                            'End_MV_6/28/2007

                            ' Added by MahendraV On 7:14 PM 6/28/2007 Moved from PageListPreRender to WhizForm_Init
                            ' Start_MV_6/28/2007
                        Case CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET
                            Dim blnVerify As Boolean
                            If HttpContext.Current.Request.QueryString("Verify") <> "" Then
                                blnVerify = CType(HttpContext.Current.Request.QueryString("Verify"), Boolean)
                            Else
                                blnVerify = False
                            End If
                            If blnVerify = True Then
                                Dim intVerifiedBy As Integer
                                Dim intCount As Integer
                                Dim intTimesheetID As Integer
                                Dim intDailyActivityID As Integer

                                Dim drVerify As IDataReader
                                Dim drResourceTimesheetstatus As IDataReader
                                Dim m_drTimesheet As IDataReader
                                Dim m_drActivites As IDataReader

                                Dim strVerifiedActivities As String
                                Dim strSQLQuery As String
                                Dim strRemarks As String
                                Dim intVerified As Integer
                                Dim dtVerificationDate As String

                                Dim arrVerifiedActivities As String()
                                Dim arrVerifiedActivitiesLength As Integer


                                dtVerificationDate = CType(Now(), String)

                                intVerifiedBy = CType(HttpContext.Current.Session("intUserID"), Integer)

                                strVerifiedActivities = CType(HttpContext.Current.Request.Form("chkDelete"), String)
                                If strVerifiedActivities <> "" Then
                                    arrVerifiedActivities = Split(strVerifiedActivities, ",")
                                End If

                                If Not IsNothing(arrVerifiedActivities) Then
                                    arrVerifiedActivitiesLength = arrVerifiedActivities.Length
                                Else
                                    arrVerifiedActivitiesLength = 0
                                End If

                                For intCount = 0 To arrVerifiedActivitiesLength - 1
                                    intTimesheetID = CType(arrVerifiedActivities(intCount), Integer)

                                    strSQLQuery = "usp_Sel_ResourceTimesheetDADetails " & intTimesheetID & "," & CType(HttpContext.Current.Session("intUserID"), String)

                                    m_drTimesheet = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    'Get Activity record details for the resource timesheet
                                    Do While m_drTimesheet.Read()
                                        intDailyActivityID = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("DailyActivityEntryID"), "0"), Integer)
                                        intVerified = 1
                                        strRemarks = ""

                                        '--- Execute sp to update verification details to Daily Activity Table
                                        strSQLQuery = "Exec usp_Upd_PM_ResourceTimesheetVerification " + CType(intDailyActivityID, String) + "," + CType(intVerified, String)
                                        strSQLQuery = strSQLQuery + "," + CType(intVerifiedBy, String) + ",'" + CType(dtVerificationDate, String) + "','" + strRemarks + "'"

                                        ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                        ' Replaced DataReader With InsertOrUpdate 

                                        'm_drActivites = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        CommonFunction.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                        ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                    Loop

                                    ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                    CommonFunction.Data.DisposeDataReader(m_drTimesheet)
                                    ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                    'Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
                                    strSQLQuery = "Exec usp_Upd_tbl_PM_ResourceTimesheetStatus " & intTimesheetID & "," & CType(intVerifiedBy, String) & "," & "'V'"

                                    drVerify = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    CommonFunctions.Data.DisposeDataReader(drVerify)


                                    'If Resource TimeSheet are verified then change the status to 'verified' 
                                    strSQLQuery = "Exec usp_Sel_ResourceTimesheet_GetVerifiedTasksStatus " & CType(intTimesheetID, String)
                                    drVerify = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    If drVerify.Read = False Then
                                        strSQLQuery = "Exec usp_Upd_ResouceTimesheetStatus " & CType(intTimesheetID, String) & ",'V'"
                                        drResourceTimesheetstatus = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        CommonFunctions.Data.DisposeDataReader(drResourceTimesheetstatus)
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(drVerify)


                                Next
                            End If

                            '##### End Addition
                        Case CommonFunction.Constants.APP_TAG_WORKORDER_FACILITIES
                            Dim blnSave As Boolean
                            Dim strSQL As String
                            Dim strFacilities As String
                            Dim drSaveFacilities As IDataReader
                            strFacilities = CType(HttpContext.Current.Request.Form("chkDelete"), String)
                            If HttpContext.Current.Request.QueryString("Save") = "True" Then
                                strSQL = "usp_Ins_tbl_PM_WorkOrderFacilities_ForProject '" + CType(strFacilities, String) + "'," + CType(HttpContext.Current.Session("intProjectID"), String)
                                drSaveFacilities = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            End If

                            CommonFunctions.Data.DisposeDataReader(drSaveFacilities)


                            '##### Added For Work Order Facilities on 17 AUG 2004
                        Case CommonFunction.Constants.APP_TAG_QUESTION_SELECTION_LIST
                            Dim blnSave As Boolean
                            Dim strSQL As String
                            Dim strQuestions As String
                            Dim strMandatory As String
                            ''Added by Dhanashri S on 24 Dec 2015
                            Dim strQuestionireID As String
                            ''End of Addition by Dhanashri S on 24 Dec 2015


                            Dim drSaveQuestions As IDataReader
                            strQuestions = CType(HttpContext.Current.Request.Form("chkDelete"), String)
                            strMandatory = CType(HttpContext.Current.Request.Form("chkMandatory"), String)
                            ''Added by Dhanashri S on 24 Dec 2015
                            strQuestionireID = CType(HttpContext.Current.Request.Form("txtQuestionireID"), String)
                            ''End of Addition by Dhanashri S on 24 Dec 2015

                            If strQuestionireID = "" Then
                                strQuestionireID = 0
                            End If


                            If HttpContext.Current.Request.QueryString("Save") = "True" Then
                                ''Commented and Added by Dhanashri S on 24 Dec 2015
                                'strSQL = "usp_Q_Save_AddQuestionToQuestionnaire_PBNITE '" + CType(strQuestions, String) + "'," + CType(HttpContext.Current.Request.QueryString("QuestionireID"), String) + ",'" + strMandatory + "'"
                                strSQL = "usp_Q_Save_AddQuestionToQuestionnaire_PBNITE '" + CType(strQuestions, String) + "'," + CType(strQuestionireID, String) + ",'" + strMandatory + "'"
                                ''End of Comment and Addition by Dhanashri S on 24 Dec 2015
                                drSaveQuestions = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            End If

                            CommonFunctions.Data.DisposeDataReader(drSaveQuestions)
                            '##### END Addition

                            '##### End Addition

                            'Added by ShamkantD on 11th August 2004

                        Case CommonFunction.Constants.APP_TAG_PM_SERVICE_SEGMENTATION
                            Dim intProjectID As String = HttpContext.Current.Session("intProjectID").ToString
                            Dim strSQL As String
                            Dim drServiceIDs As IDataReader
                            Dim strSegmentationIDs As String = ","
                            Dim strServiceIDs As String = ","
                            Dim strSubServiceIDs As String = ","

                            'Get the list of Service Segmentaion IDs selected for the current project
                            drServiceIDs = CommonFunction.Data.GetDataReader("SELECT DISTINCT ServicesSegmentationID FROM tbl_PM_Services WHERE ProjectID = " & intProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            While drServiceIDs.Read
                                If CommonFunction.General.CheckIsNothing(drServiceIDs("ServicesSegmentationID")).ToString <> "" Then
                                    strSegmentationIDs += drServiceIDs("ServicesSegmentationID").ToString + ","
                                End If
                            End While
                            CommonFunction.Data.DisposeDataReader(drServiceIDs)
                            HttpContext.Current.Session("strServicesSegmentationIDs") = strSegmentationIDs

                            'Get the list of Service Offering IDs selected for the current project
                            drServiceIDs = CommonFunction.Data.GetDataReader("SELECT DISTINCT A.ServiceOfferingID FROM tbl_PM_ServiceOffering A WHERE A.ProjectServiceID IN (SELECT ProjectServiceID FROM tbl_PM_Services B WHERE B.ProjectID = " & intProjectID & ")", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            While drServiceIDs.Read
                                If CommonFunction.General.CheckIsNothing(drServiceIDs("ServiceOfferingID")).ToString <> "" Then
                                    strServiceIDs += drServiceIDs("ServiceOfferingID").ToString + ","
                                End If
                            End While
                            CommonFunction.Data.DisposeDataReader(drServiceIDs)
                            HttpContext.Current.Session("strServiceOfferingIDs") = strServiceIDs

                            'Get the list of Sub Service Offering IDs selected for the current project
                            drServiceIDs = CommonFunction.Data.GetDataReader("SELECT DISTINCT A.SubServiceOfferingID FROM tbl_PM_ServiceOffering A WHERE A.ProjectServiceID IN (SELECT ProjectServiceID FROM tbl_PM_Services B WHERE B.ProjectID = " & intProjectID & ")", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            While drServiceIDs.Read
                                If CommonFunction.General.CheckIsNothing(drServiceIDs("SubServiceOfferingID")).ToString <> "" Then
                                    strSubServiceIDs += drServiceIDs("SubServiceOfferingID").ToString + ","
                                End If
                            End While
                            CommonFunction.Data.DisposeDataReader(drServiceIDs)
                            HttpContext.Current.Session("strSubServiceOfferingIDs") = strSubServiceIDs
                            'End of addition - ShamkantD on 11th August 2004
                        Case CommonFunction.Constants.APP_TAG_PM_MARKET_SEGMENTATION
                            'Added by PareshB on September 07,2004
                            Dim intProjectID As String = HttpContext.Current.Session("intProjectID").ToString
                            Dim strSQL As String
                            Dim drMarketIDs As IDataReader
                            Dim strDomainIDs As String = ","
                            Dim strMarketIDs As String = ","
                            Dim strSubmarketIDs As String = ","

                            'Get the list of Domain IDs selected for the current project
                            drMarketIDs = CommonFunction.Data.GetDataReader("Select DISTINCT DomainID from tbl_PM_ExternalMarket Where ProjectID =" & intProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            While drMarketIDs.Read
                                If CommonFunction.General.CheckIsNothing(drMarketIDs("DomainID")).ToString <> "" Then
                                    strDomainIDs += drMarketIDs("DomainID").ToString + ","
                                End If
                            End While
                            CommonFunction.Data.DisposeDataReader(drMarketIDs)
                            HttpContext.Current.Session("strDomainIDs") = strDomainIDs

                            'Get the list of Market IDs selected for the current project
                            drMarketIDs = CommonFunction.Data.GetDataReader("SELECT DISTINCT tbl_PM_MarketSubMarket.MarketID FROM tbl_PM_MarketSubMarket,tbl_PM_ExternalMarket WHERE tbl_PM_MarketSubMarket.ProjectDomainID =  tbl_PM_ExternalMarket.ProjectDomainID AND ProjectID = " & intProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            While drMarketIDs.Read
                                If CommonFunction.General.CheckIsNothing(drMarketIDs("MarketID")).ToString <> "" Then
                                    strMarketIDs += drMarketIDs("MarketID").ToString + ","
                                End If
                            End While
                            CommonFunction.Data.DisposeDataReader(drMarketIDs)
                            HttpContext.Current.Session("strMarketIDs") = strMarketIDs

                            'Get the list of Sub Market IDs selected for the current project
                            drMarketIDs = CommonFunction.Data.GetDataReader("SELECT DISTINCT tbl_PM_MarketSubMarket.SubMarketID FROM tbl_PM_MarketSubMarket,tbl_PM_ExternalMarket WHERE tbl_PM_MarketSubMarket.ProjectDomainID =  tbl_PM_ExternalMarket.ProjectDomainID AND ProjectID = " & intProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            While drMarketIDs.Read
                                If CommonFunction.General.CheckIsNothing(drMarketIDs("SubMarketID")).ToString <> "" Then
                                    strSubmarketIDs += drMarketIDs("SubMarketID").ToString + ","
                                End If
                            End While
                            CommonFunction.Data.DisposeDataReader(drMarketIDs)
                            HttpContext.Current.Session("strSubmarketIDs") = strSubmarketIDs
                            'End of addition - PareshB on September 07,2004
                        Case CommonFunction.Constants.APP_TAG_WORKORDER_CONTRACT_CLAUSES
                            Dim blnSave As Boolean
                            Dim strSQL As String
                            Dim strContractClauses As String
                            Dim drSaveContractClauses As IDataReader
                            strContractClauses = CType(HttpContext.Current.Request.Form("chkDelete"), String)
                            If HttpContext.Current.Request.QueryString("Save") = "True" Then
                                strSQL = "usp_Ins_tbl_PM_WorkOrderContractClauses_ForProject '" + CType(strContractClauses, String) + "'," + CType(HttpContext.Current.Session("intProjectID"), String)
                                drSaveContractClauses = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            End If

                            CommonFunctions.Data.DisposeDataReader(drSaveContractClauses)
                            'End of Addition - ShamkantD on 20th August 2004

                            ' added by HarshK for sp4 issueid 200(Module selection List)
                        Case CommonFunction.Constants.APP_TAG_TAB_SELECT_COST_HEADS
                            Dim strCostHeadIDList As String = ""
                            Dim strSQLQuery As String = ""
                            Dim drCostHeads As IDataReader

                            'If Save link clicked, Save the changes
                            strCostHeadIDList = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), ""), String)
                            If HttpContext.Current.Request.QueryString("Action") = "Save" Then
                                strSQLQuery = "EXEC usp_Ins_tbl_PM_WorkOrderCosts_ForProject " & _
                                    "'" & CType(strCostHeadIDList, String) & "'," & _
                                    CType(HttpContext.Current.Session("intProjectID"), String) & "," & _
                                    "'" & CommonFunction.General.CheckIsNothing(WhizGlobal.UserName, "").ToString() & "'"
                                CommonFunctions.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            End If
                            'End of addition - ShamkantD on 16 Sep 2004

                            'added by SachinR   on 17 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING
                            Dim strQuery As String = ""
                            Dim blnIsApprover As Boolean = False

                            'Get whether or not the logged in user is approver
                            'Integrated by SandipL SP8 to SP9

                            'Added By JyotiG (08-Jan-2007)
                            'Purpose :Customer cannot approve Project.so while checking he is approver or  not check he is employee / Customer
                            'Checking of Employee/Customer is added By JyotiG
                            If HttpContext.Current.Session("LoginType").ToString = "E" Then
                                strQuery = "usp_Sel_tbl_PM_Role_IsApprover " & _
                                                                CommonFunction.General.CheckIsNothing(WhizGlobal.UserID, "0").ToString() & "," & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString()
                                blnIsApprover = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
                                HttpContext.Current.Session("blnIsApprover") = blnIsApprover
                            End If
                            'End Integration by SandipL SP8 to SP9
                            'End of addition - ShamkantD on 27 Sep 2004

                            'Added by ShamkantD on 5 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_BUSINESS_GROUP
                            'Added for - Select Middle Level Resources for Business Group
                            Dim strEmployeeIDList As String = ""
                            Dim strSQLQuery As String = ""
                            Dim drCostHeads As IDataReader
                            Dim strMasterPrimaryKeyValue As String = ""


                            'plot hidden control to persist the value of MasterPrimaryKeyValue passed from query string 
                            strMasterPrimaryKeyValue = HttpContext.Current.Request.QueryString("MasterPrimaryKeyValue") + ""
                            If strMasterPrimaryKeyValue = "" Then
                                strMasterPrimaryKeyValue = HttpContext.Current.Request.Form("txtMasterPrimaryKeyValue") + ""
                            End If
                            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                            ''CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtMasterPrimaryKeyValue", "txtMasterPrimaryKeyValue", , , , strMasterPrimaryKeyValue.Trim, , , , , , True, , True))
                            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtMasterPrimaryKeyValue", "txtMasterPrimaryKeyValue", , , , strMasterPrimaryKeyValue.Trim, , , , , , True, , True, EnableHTMLEncode:=True))

                            'If Save link clicked, Save the changes
                            If strMasterPrimaryKeyValue.Trim <> "" Then
                                If HttpContext.Current.Request.QueryString("Action") = "Save" Then
                                    strEmployeeIDList = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), ""), String)

                                    strSQLQuery = "EXEC usp_Ins_tbl_CNF_BusinessGroups_MiddleLevelResources " & _
                                        "'" & CType(strEmployeeIDList, String) & "'," & _
                                        strMasterPrimaryKeyValue.Trim
                                    CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                End If
                            End If
                            'End of addition - ShamkantD on 5 Oct 2004

                            'Added by ShamkantD on 6 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_ORGANIZATION_UNIT
                            'Added for - Select Middle Level Resources for Organization Unit 
                            Dim strEmployeeIDList As String = ""
                            Dim strSQLQuery As String = ""
                            Dim drCostHeads As IDataReader
                            Dim strMasterPrimaryKeyValue As String = ""


                            'plot hidden control to persist the value of MasterPrimaryKeyValue passed from query string 
                            strMasterPrimaryKeyValue = HttpContext.Current.Request.QueryString("MasterPrimaryKeyValue") + ""
                            If strMasterPrimaryKeyValue = "" Then
                                strMasterPrimaryKeyValue = HttpContext.Current.Request.Form("txtMasterPrimaryKeyValue") + ""
                            End If
                            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                            ''CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtMasterPrimaryKeyValue", "txtMasterPrimaryKeyValue", , , , strMasterPrimaryKeyValue.Trim, , , , , , True, , True))
                            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtMasterPrimaryKeyValue", "txtMasterPrimaryKeyValue", , , , strMasterPrimaryKeyValue.Trim, , , , , , True, , True, EnableHTMLEncode:=True))

                            'If Save link clicked, Save the changes
                            If strMasterPrimaryKeyValue.Trim <> "" Then
                                If HttpContext.Current.Request.QueryString("Action") = "Save" Then
                                    strEmployeeIDList = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), ""), String)

                                    strSQLQuery = "EXEC usp_Ins_tbl_PM_Location_MiddleLevelResources " & _
                                        "'" & CType(strEmployeeIDList, String) & "'," & _
                                        strMasterPrimaryKeyValue.Trim
                                    CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))


                                End If
                            End If
                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_DELIVERY_UNIT
                            'Added for - Select Middle Level Resources for Delivery Unit 
                            Dim strEmployeeIDList As String = ""
                            Dim strSQLQuery As String = ""
                            Dim drCostHeads As IDataReader
                            Dim strMasterPrimaryKeyValue As String = ""

                            'plot hidden control to persist the value of MasterPrimaryKeyValue passed from query string 
                            strMasterPrimaryKeyValue = HttpContext.Current.Request.QueryString("MasterPrimaryKeyValue") + ""
                            If strMasterPrimaryKeyValue = "" Then
                                strMasterPrimaryKeyValue = HttpContext.Current.Request.Form("txtMasterPrimaryKeyValue") + ""
                            End If
                            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                            ''CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtMasterPrimaryKeyValue", "txtMasterPrimaryKeyValue", , , , strMasterPrimaryKeyValue.Trim, , , , , , True, , True))
                            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtMasterPrimaryKeyValue", "txtMasterPrimaryKeyValue", , , , strMasterPrimaryKeyValue.Trim, , , , , , True, , True, EnableHTMLEncode:=True))

                            'If Save link clicked, Save the changes
                            If strMasterPrimaryKeyValue.Trim <> "" Then
                                If HttpContext.Current.Request.QueryString("Action") = "Save" Then
                                    strEmployeeIDList = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), ""), String)

                                    strSQLQuery = "EXEC usp_Ins_tbl_PM_ResourcePool_MiddleLevelResources " & _
                                        "'" & CType(strEmployeeIDList, String) & "'," & _
                                        strMasterPrimaryKeyValue.Trim
                                    CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                End If
                            End If
                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_DELIVERY_TEAM
                            'Added for - Select Middle Level Resources for Delivery Team 
                            Dim strEmployeeIDList As String = ""
                            Dim strSQLQuery As String = ""
                            Dim drCostHeads As IDataReader
                            Dim strMasterPrimaryKeyValue As String = ""

                            'plot hidden control to persist the value of MasterPrimaryKeyValue passed from query string 
                            strMasterPrimaryKeyValue = HttpContext.Current.Request.QueryString("MasterPrimaryKeyValue") + ""
                            If strMasterPrimaryKeyValue = "" Then
                                strMasterPrimaryKeyValue = HttpContext.Current.Request.Form("txtMasterPrimaryKeyValue") + ""
                            End If
                            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                            ''CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtMasterPrimaryKeyValue", "txtMasterPrimaryKeyValue", , , , strMasterPrimaryKeyValue.Trim, , , , , , True, , True))
                            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtMasterPrimaryKeyValue", "txtMasterPrimaryKeyValue", , , , strMasterPrimaryKeyValue.Trim, , , , , , True, , True, EnableHTMLEncode:=True))

                            'If Save link clicked, Save the changes
                            If strMasterPrimaryKeyValue.Trim <> "" Then
                                If HttpContext.Current.Request.QueryString("Action") = "Save" Then
                                    strEmployeeIDList = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), ""), String)

                                    strSQLQuery = "EXEC usp_Ins_tbl_PM_GroupMaster_MiddleLevelResources " & _
                                        "'" & CType(strEmployeeIDList, String) & "'," & _
                                        strMasterPrimaryKeyValue.Trim
                                    CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))


                                End If
                            End If
                            'End of addition - ShamkantD on 6 Oct 2004

                            ' Added By NitinVS ON 7 Dec 
                            ' if the link update Template is clicked then add the selected template for the Project
                        Case CommonFunction.Constants.APP_TAG_SELECT_CHECKLIST_FOR_PROJECT
                            Dim strQuestionnaireID As String
                            Dim strCheckListShortName As String
                            Dim StrSqlQuery As String
                            If HttpContext.Current.Request.QueryString("MODE") = "UPDATE_CHECKLIST" Then

                                strQuestionnaireID = HttpContext.Current.Request.QueryString("QuestionnaireID").ToString
                                strCheckListShortName = HttpContext.Current.Request.QueryString("CheckListShortName").ToString


                                StrSqlQuery = "EXEC usp_Ins_tbl_PM_WorkOrderCheckList " & _
                                CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString() & _
                                ", '" & CommonFunctions.General.BuildQueryString(strCheckListShortName) & "'," & strQuestionnaireID
                                'modified by harshada d for chk list issue sp 7.5
                                '", """ & strCheckListShortName & """," & strQuestionnaireID
                                CommonFunctions.Data.InsertOrUpdateData(StrSqlQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            End If

                            'End of Addtion by PrachiK
                            'Added by MrugajaB on 3 Mar 2005 for Project Document Category
                        Case CommonFunction.Constants.APP_TAG_PROJECT_DOCUMENTCATEGORY
                            Dim strCategoryIDList As String = ""
                            Dim strSQLQuery As String = ""
                            Dim drCostHeads As IDataReader
                            Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                            Dim strScript As String = ""
                            Dim strAction As String

                            strAction = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action").ToUpper)

                            If strAction = "SAVE" Then
                                strCategoryIDList = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), ""), String) + ","
                                strSQLQuery = "EXEC usp_Ins_tbl_PM_Project_DocumentCategory " + intProjectID.ToString + ", '" + CType(strCategoryIDList, String) + "' "
                                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                CommonFunction.General.WriteHTML(strScript)
                            End If

                            'End Addition
                            '***** Code added by SandipL on 23 Nov 2005 --IssueID 672
                            'To remove session variable before closing
                        Case CommonFunction.Constants.APP_TAG_SDLC_PROCESS
                            If HttpContext.Current.Request.QueryString("ToDo") = "Sync" Then
                                Dim strActivityIDs As String
                                Dim strSQLQuery As String = ""
                                strActivityIDs = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkSynchronize"), ""), String)

                                If strActivityIDs <> "" Then
                                    strSQLQuery = "EXEC usp_RemoveActivity_tbl_PRS_Project_SDLC_Details " & HttpContext.Current.Session("intProjectID").ToString & "," & HttpContext.Current.Request.QueryString("ProcessID") & ",'" & strActivityIDs & "'"
                                    CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                End If
                            End If
                            ' 'End of Addition    :   ManishK     on 30th Aug 2005
                            'End Integration
                            '----------------------------------------------------------------------------------
                            ''---Code Added By SajiU on 5th Dec  2006
                    End Select
                Else
                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_TAG_TAB_PROJECT_FACILITIES
                            '--------------Added by AbhijeetD on 11th May 2004---------------
                            Dim strCreatedBy As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"))
                            Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                            Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

                            'Insert all the Facilities into tbl_PM_WorkOrderFacilities if none exist
                            If (CommonFunction.Data.GetDataScalar("SELECT WorkOrderFacilityID FROM tbl_PM_WorkOrderFacilities WHERE ProjectID = " + intProjectID.ToString, blnUseSQL) Is Nothing) Then
                                CommonFunction.Data.InsertOrUpdateData("usp_Ins_tbl_PM_WorkOrderFacilities " + intProjectID.ToString + ", '" + strCreatedBy + "'", blnUseSQL)
                            End If
                            '------------------------End addition----------------------------

                    End Select
                End If
            End Sub
            Public Function PageListPreRender(ByVal WhizGlobal As WebPages.Template.IGlobal) As String
                PageListPreRender = ""
                'Application standard return code
                strActionCode = ReturnCodes.DO_NOTHING.ToString

                If WhizGlobal.ParentTagID = 0 Then

                    Select Case WhizGlobal.TagID
                        'Added By Chakshuta H on 29th-Oct-2015
                        '-------------------------------------------------------------------------------------------------------------
                        'Added By - PushkarK On - Tuesday, July 25, 2006
                        'Reason   - For refreshing the Dynamic Action Lnks' list page. 
                        '-------------------------------------------------------------------------------------------------------------
                        Case CommonFunctions.Constants.TAG_SYSTEM_POOL_LINKS
                            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DYNAMIC_ACTION"), "0") = "1" Then
                                Dim sbScript As System.Text.StringBuilder
                                sbScript = New System.Text.StringBuilder
                                sbScript.Append("<Script language=javascript>")
                                sbScript.Append("try { ") 'Added by Vinay on 11 DEC. 2008 WAF3_GEN_18
                                sbScript.Append("window.opener.document.forms['frmInformativeSections'].action = window.opener.location.href;")
                                sbScript.Append("window.opener.document.forms['frmInformativeSections'].submit();")
                                sbScript.Append("window.close();")
                                sbScript.Append("} catch(e) { } ") 'Added by Vinay on 11 DEC. 2008 WAF3_GEN_18
                                sbScript.Append("</Script>")
                                CommonFunctions.General.WriteHTML(sbScript.ToString)
                                strActionCode = ReturnCodes.DO_NOTHING.ToString
                                sbScript = Nothing
                            End If
                            '-------------------------------------------------------------------------------------------------------------
                            'Addition Ends By - PushkarK On - Tuesday, July 25, 2006
                            '-------------------------------------------------------------------------------------------------------------

                            'Ended By Chakshuta H on 29th-Oct-2015

                            'Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
                            '-------------------------------------------------------------------------------------
                            'Added by GaneshG on 12 Jan 2006 -- To add changed function definations
                            'For RFI Milestone and RFI Deliverable Page.
                        Case CommonFunction.Constants.APP_TAG_RFI_MILESTONE
                            PageListPreRender += "function Paging_Onclick(strPagingAlphabet)" & vbCrLf & _
                                                "{ objfrm.action = 'Commonlist.aspx?Customer=" & HttpContext.Current.Request.QueryString("Customer").ToString & _
                                                "&RFIID=" & HttpContext.Current.Request.QueryString("RFIID").ToString & _
                                                "&PagingAlphabet=' + strPagingAlphabet;" & vbCrLf & _
                                                "objfrm.submit(); }" + vbCrLf

                            PageListPreRender += vbCrLf & _
                                                    "function SortByColumn(strFieldName,strAscDesc)" & vbCrLf & _
                                                    "{ objfrm.action = 'Commonlist.aspx?Customer=" & HttpContext.Current.Request.QueryString("Customer").ToString & _
                                                    "&RFIID=" & HttpContext.Current.Request.QueryString("RFIID").ToString & _
                                                    "&SortBy=' + strFieldName + " & "'&SortOrder=' + strAscDesc;" & vbCrLf & _
                                                    "objfrm.submit(); }" + vbCrLf

                            strActionCode = ReturnCodes.ON_LOAD.ToString

                        Case CommonFunction.Constants.APP_TAG_RFI_DELIVERABLES
                            PageListPreRender += "function Paging_Onclick(strPagingAlphabet)" & vbCrLf & _
                                                 "{ objfrm.action = 'Commonlist.aspx?Customer=" & HttpContext.Current.Request.QueryString("Customer").ToString & _
                                                 "&RFIID=" & HttpContext.Current.Request.QueryString("RFIID").ToString & _
                                                 "&PagingAlphabet=' + strPagingAlphabet;" & vbCrLf & _
                                                 "objfrm.submit(); }" + vbCrLf

                            PageListPreRender += vbCrLf & _
                                                    "function SortByColumn(strFieldName,strAscDesc)" & vbCrLf & _
                                                    "{ objfrm.action = 'Commonlist.aspx?Customer=" & HttpContext.Current.Request.QueryString("Customer").ToString & _
                                                    "&RFIID=" & HttpContext.Current.Request.QueryString("RFIID").ToString & _
                                                    "&SortBy=' + strFieldName + " & "'&SortOrder=' + strAscDesc;" & vbCrLf & _
                                                    "objfrm.submit(); }" + vbCrLf

                            strActionCode = ReturnCodes.ON_LOAD.ToString
                            'End of Addition by GaneshG
                            '-------------------------------------------------------------------------------------
                            'End Integration by SavitaS on 13 Mar 2006

                            'Added by VivekP on 02-Sep-2005 for CSL
                            'Added by Mangesh Y on 6 Jan 2005 - SQERT Locking Save
                            'Case CommonFunction.Constants.APP_TAG_SQERT_LOCK
                            '    Dim strSQERTIDList As String = ""
                            '    Dim strSQLQuery As String = ""
                            '    Dim strBGID As String = ""
                            '    Dim strOUID As String = ""
                            '    Dim strProject As String = ""

                            '    'If Save link clicked, Save the changes
                            '    strSQERTIDList = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), ""), String)
                            '    If HttpContext.Current.Request.QueryString("Action") = "Save" Then
                            '        ' Commented and Added by MahendraV On 4:52 PM 6/20/2007 for WhizibleSEMSP8 code integration
                            '        ' Start_MV_6/20/2007 
                            '        'strSQLQuery = "EXEC usp_CRW_ProjectSheet_UpdateLock '" & CType(strSQERTIDList, String) & "'"

                            '        strBGID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("BusinessGroupID"), ""), String)
                            '        strOUID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("LocationID"), ""), String)
                            '        strProject = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ProjectName"), ""), String)
                            '        strSQLQuery = "EXEC usp_CRW_ProjectSheet_UpdateLock '" & CType(strSQERTIDList, String) & "'"


                            '        'Aadded filters to Page
                            '        If strBGID <> "" Then
                            '            strSQLQuery = strSQLQuery & "," + strBGID
                            '        Else
                            '            strSQLQuery = strSQLQuery & ",NULL"
                            '        End If
                            '        If strOUID <> "" Then
                            '            strSQLQuery = strSQLQuery & "," + strOUID
                            '        Else
                            '            strSQLQuery = strSQLQuery & ",NULL"
                            '        End If
                            '        If strProject <> "" Then
                            '            strSQLQuery = strSQLQuery & ",'" & strProject & "'"
                            '        Else
                            '            strSQLQuery = strSQLQuery & ",NULL"
                            '        End If
                            '        ' Start_MV_6/20/2007 
                            '        CommonFunctions.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            '    End If
                            '    '    'End of addition - Mangesh Y on 6 Jan 2005
                            '    '    'End of addition - VivekP on 02 sep 2005

                        Case CommonFunction.Constants.TAG_ADVANCE_FILTERS
                            'Refresh Parent for Filters
                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("RefreshCL")) = "1" Or _
                                CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")).ToUpper = "DELETE" Then
                                PageListPreRender = "refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx');"
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If
                        Case CommonFunction.Constants.APP_TAG_PROJECT_ROOT_CAUSE
                            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("RootCausesSave")) = "1" Then
                                'If the SAVE operation is executed then refresh the parent
                                PageListPreRender = "refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx');"
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                                HttpContext.Current.Session("RootCausesSave") = ""
                            End If
                            'Case CommonFunction.Constants.APP_TAG_RFI_INITIATOR
                            '    Dim objAppResource As WebPages.Template.WhizTemplate
                            '    objAppResource = New WebPages.Template.WhizTemplate
                            '    objAppResource.InitializeResources("AppResources.EventHandlers", "AppResources")

                            '    'SalesPeriod
                            '    If Not (HttpContext.Current.Session("OpenSalesPeriod") Is Nothing) Then
                            '        If CType(HttpContext.Current.Session("OpenSalesPeriod"), Integer) = 0 Then
                            '            'CommonFunction.General.WriteHTML("<script language=javascript>")
                            '            'CommonFunction.General.WriteHTML("alert('" + objAppResource.GetResourceString("MSG_NO_PERIOD") + "');")
                            '            'CommonFunction.General.WriteHTML("window.location.href='CommonList.aspx?FromWhere=PM&MasterTagId=2044'")
                            '            'CommonFunction.General.WriteHTML("</script>")
                            '            'Modified By TruptiK on 23-May-2007
                            '            PageListPreRender = "alert('" + objAppResource.GetResourceString("MSG_NO_PERIOD") + "'); "
                            '            strActionCode = ReturnCodes.ON_LOAD.ToString
                            '            HttpContext.Current.Session("OpenSalesPeriod") = Nothing


                            '        End If
                            '    End If
                            '    'BaseCurrency Code
                            '    If Not (HttpContext.Current.Session("BaseCurrencyCode") Is Nothing) Then
                            '        If CType(HttpContext.Current.Session("BaseCurrencyCode"), String) = "" Then
                            '            'CommonFunction.General.WriteHTML("<script language=javascript>")
                            '            'CommonFunction.General.WriteHTML("alert('" + objAppResource.GetResourceString("MSG_NO_BASECODE") + "');")
                            '            'CommonFunction.General.WriteHTML("window.location.href='CommonList.aspx?FromWhere=PM&MasterTagId=2044'")
                            '            'CommonFunction.General.WriteHTML("</script>")
                            '            PageListPreRender = "alert('" + objAppResource.GetResourceString("MSG_NO_BASECODE") + "');"
                            '            'strActionCode = ReturnCodes.ON_LOAD.ToString
                            '            HttpContext.Current.Session("BaseCurrencyCode") = Nothing
                            '        End If
                            '    End If
                            '    'LocalCurrencyCode
                            '    If Not (HttpContext.Current.Session("LocalCurrencyCode") Is Nothing) Then
                            '        If CType(HttpContext.Current.Session("LocalCurrencyCode"), String) = "" Then
                            '            'CommonFunction.General.WriteHTML("<script language=javascript>")
                            '            'CommonFunction.General.WriteHTML("alert('" + objAppResource.GetResourceString("MSG_NO_LOCALCODE") + "');")
                            '            'CommonFunction.General.WriteHTML("window.location.href='CommonList.aspx?FromWhere=PM&MasterTagId=2044'")
                            '            'CommonFunction.General.WriteHTML("</script>")
                            '            PageListPreRender = "alert('" + objAppResource.GetResourceString("MSG_NO_LOCALCODE") + "');"
                            '            strActionCode = ReturnCodes.ON_LOAD.ToString
                            '            HttpContext.Current.Session("LocalCurrencyCode") = Nothing
                            '        End If
                            '    End If
                            '    'BillingCurrencyID
                            '    If Not (HttpContext.Current.Session("BillingCurrencyID") Is Nothing) Then
                            '        If CType(HttpContext.Current.Session("BillingCurrencyID"), Integer) = 0 Then
                            '            'CommonFunction.General.WriteHTML("<script language=javascript>")
                            '            'CommonFunction.General.WriteHTML("alert('" + objAppResource.GetResourceString("MSG_NO_BILLING") + "');")
                            '            'CommonFunction.General.WriteHTML("window.location.href='CommonList.aspx?FromWhere=PM&MasterTagId=2044'")
                            '            'CommonFunction.General.WriteHTML("</script>")
                            '            PageListPreRender = "alert('" + objAppResource.GetResourceString("MSG_NO_BILLING") + "');"
                            '            strActionCode = ReturnCodes.ON_LOAD.ToString
                            '            HttpContext.Current.Session("BillingCurrencyID") = Nothing
                            '        End If
                            '    End If
                            '    If Not (HttpContext.Current.Session("InvoiceResponsiblePerson") Is Nothing) Then
                            '        If CType(HttpContext.Current.Session("InvoiceResponsiblePerson"), Long) = 0 Then
                            '            ''PrashantSJ 22 May 07  
                            '            'CommonFunction.General.WriteHTML("<script language=javascript>")
                            '            'CommonFunction.General.WriteHTML("alert('" + objAppResource.GetResourceString("MSG_NO_RESP_PERSON") + "');")
                            '            'CommonFunction.General.WriteHTML("window.location.href='CommonList.aspx?FromWhere=PM&MasterTagId=2044'")
                            '            'CommonFunction.General.WriteHTML("</script>")
                            '            PageListPreRender = "alert('" + objAppResource.GetResourceString("MSG_NO_RESP_PERSON") + "'); " + vbCrLf
                            '            strActionCode = ReturnCodes.ON_LOAD.ToString
                            '            ''End prashantsj
                            '            HttpContext.Current.Session("InvoiceResponsiblePerson") = Nothing
                            '        End If
                            '    End If
                            '    If Not (HttpContext.Current.Session("CompanyBaseCurrencyCode") Is Nothing) Then
                            '        If CType(HttpContext.Current.Session("CompanyBaseCurrencyCode"), String) = "" Then
                            '            'CommonFunction.General.WriteHTML("<script language=javascript>")
                            '            'CommonFunction.General.WriteHTML("alert('" + objAppResource.GetResourceString("MSG_NO_COMPANYBASECODE") + "');")
                            '            'CommonFunction.General.WriteHTML("window.location.href='CommonList.aspx?FromWhere=PM&MasterTagId=2044'")
                            '            'CommonFunction.General.WriteHTML("</script>")
                            '            PageListPreRender = "alert('" + objAppResource.GetResourceString("MSG_NO_COMPANYBASECODE") + "'); "
                            '            strActionCode = ReturnCodes.ON_LOAD.ToString
                            '            'End Of Modification by TruptiK on 23-May-2007
                            '            HttpContext.Current.Session("CompanyBaseCurrencyCode") = Nothing
                            '        End If
                            '    End If
                            '    'End of addition by PrashantSJ on 28 Nov 2006
                            '    'Responsible Person for Invoice
                            '    'End


                            '    objAppResource = Nothing


                            '##### Cases Added For Resource Timesheet Flow
                            ' Modified by MahendraV On 7:14 PM 6/28/2007 
                            ' Database update need to be moved in WhizForm_Init due to DataSet Related Changes For Whiziblesem 7
                            ' Commented code moved from PageListPreRender To WhizForm_Init

                            ' Start_MV_6/28/2007
                        Case CommonFunction.Constants.APP_TAG_VERIFYRESOURCETIMESHEET
                            Dim blnVerify As Boolean
                            If HttpContext.Current.Request.QueryString("Verify") <> "" Then
                                blnVerify = CType(HttpContext.Current.Request.QueryString("Verify"), Boolean)
                            Else
                                blnVerify = False
                            End If
                            If blnVerify = True Then
                                Dim intVerifiedBy As Integer
                                Dim intCount As Integer
                                '    Dim intCtr As Integer
                                Dim intTimesheetID As Integer
                                '    Dim intDailyActivityID As Integer

                                '    Dim drVerify As IDataReader
                                '    Dim drResourceTimesheetstatus As IDataReader
                                Dim m_drTimesheet As IDataReader
                                '    Dim m_drActivites As IDataReader

                                Dim strVerifiedActivities As String
                                Dim strSQLQuery As String
                                '    Dim strRemarks As String
                                '    Dim intVerified As Integer
                                '    Dim dtVerificationDate As String

                                Dim arrVerifiedActivities As String()
                                Dim arrVerifiedActivitiesLength As Integer

                                Dim strFromDate As String
                                Dim strToDate As String
                                '    Dim dblTotalExtraAMH As Double
                                '    Dim dblTotalAMH As Double

                                '    'Variables for sending E-mail
                                Dim drEmailMessage As IDataReader
                                Dim drResource As IDataReader
                                Dim blnSendEmail As Boolean
                                Dim blnShowPopup As Boolean
                                Dim strOnloadClientScript As String
                                Dim strFromEmailID As String
                                Dim strToEmailID As String
                                Dim strCCToEmailID As String
                                Dim strSubject As String
                                Dim strEmailMessage As String
                                Dim strMessage As String
                                Dim strResourceID As String

                                'dtVerificationDate = CType(Now(), String)

                                intVerifiedBy = CType(HttpContext.Current.Session("intUserID"), Integer)

                                strVerifiedActivities = CType(HttpContext.Current.Request.Form("chkDelete"), String)
                                If strVerifiedActivities <> "" Then
                                    arrVerifiedActivities = Split(strVerifiedActivities, ",")
                                End If

                                If Not IsNothing(arrVerifiedActivities) Then
                                    arrVerifiedActivitiesLength = arrVerifiedActivities.Length
                                Else
                                    arrVerifiedActivitiesLength = 0
                                End If

                                For intCount = 0 To arrVerifiedActivitiesLength - 1
                                    intTimesheetID = CType(arrVerifiedActivities(intCount), Integer)

                                    strSQLQuery = "usp_Sel_ResourceTimesheetDADetails " & intTimesheetID & "," & CType(HttpContext.Current.Session("intUserID"), String)

                                    m_drTimesheet = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    '        'Get Activity record details for the resource timesheet
                                    Do While m_drTimesheet.Read()
                                        strFromDate = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("FromDate"), CType(Now(), String)), String)
                                        strToDate = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("ToDate"), CType(Now(), String)), String)
                                        '            intDailyActivityID = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("DailyActivityEntryID"), "0"), Integer)
                                        '            intVerified = 1
                                        '            strRemarks = ""

                                        '            '--- Execute sp to update verification details to Daily Activity Table
                                        '            strSQLQuery = "Exec usp_Upd_PM_ResourceTimesheetVerification " + CType(intDailyActivityID, String) + "," + CType(intVerified, String)
                                        '            strSQLQuery = strSQLQuery + "," + CType(intVerifiedBy, String) + ",'" + CType(dtVerificationDate, String) + "','" + strRemarks + "'"

                                        '            ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                        '            ' Replaced DataReader With InsertOrUpdate 

                                        '            'm_drActivites = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        '            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                        '            ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                    Loop

                                    '        ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                    '        CommonFunction.Data.DisposeDataReader(m_drTimesheet)
                                    '        ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                    '        'Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
                                    '        strSQLQuery = "Exec usp_Upd_tbl_PM_ResourceTimesheetStatus " & intTimesheetID & "," & CType(intVerifiedBy, String) & "," & "'V'"

                                    '        drVerify = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    '        CommonFunctions.Data.DisposeDataReader(drVerify)


                                    '        'If Resource TimeSheet are verified then change the status to 'verified' 
                                    '        strSQLQuery = "Exec usp_Sel_ResourceTimesheet_GetVerifiedTasksStatus " & CType(intTimesheetID, String)
                                    '        drVerify = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    '        If drVerify.Read = False Then
                                    '            strSQLQuery = "Exec usp_Upd_ResouceTimesheetStatus " & CType(intTimesheetID, String) & ",'V'"
                                    '            drResourceTimesheetstatus = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    '            CommonFunctions.Data.DisposeDataReader(drResourceTimesheetstatus)
                                    '        End If
                                    '        CommonFunctions.Data.DisposeDataReader(drVerify)

                                    strSQLQuery = "SELECT EmployeeID FROM tbl_PM_ResourceTimesheet WHERE TimesheetID = " & intTimesheetID
                                    drResource = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If drResource.Read Then
                                        strResourceID = CType(drResource("EmployeeID"), String)
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(drResource)

                                    strSQLQuery = "usp_Sel_tbl_PM_EmailMessages 427"
                                    drEmailMessage = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    If drEmailMessage.Read Then
                                        blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                                        blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(drEmailMessage)

                                    ' Check if the mail has to be sent.
                                    If blnSendEmail = True Then
                                        ' Check if a popup message has to be shown.
                                        If blnShowPopup = True Then
                                            CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                                            'CommonFunctions.General.WriteHTML("window.open('../../Source/General/SendEmail.aspx?MessageID=427&VerifiedBy=" + CType(intVerifiedBy, String) + "&ResourceID=" + CType(m_strEmployeeID, String) + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left='" + "(window.screen.width - 600) / 2" + "',top='" + "(window.screen.height - 500) / 2" + "',width=600,height=500')" + vbCrLf)
                                            CommonFunctions.General.WriteHTML("window.open('../../Source/General/SendEmail.aspx?MessageID=435&VerifiedBy=" + CType(intVerifiedBy, String) + "&ResourceID=" + CType(strResourceID, String) + "&FromDate=" + strFromDate + "&ToDate=" + strToDate + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                                            CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                                            ' Else, if the mail has to be sent silently, then...
                                        Else

                                            'TO DO: SEND EMAIL MESSAGE WITH CC
                                            'CommonFunction.EmailMessages.PMMessages. CRMMessages.GetEmailMessage_45(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intVerifiedBy, m_strEmployeeID)
                                            CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_435(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strMessage, intVerifiedBy, CType(HttpContext.Current.Request.QueryString("EmployeeID"), Integer), CType(strFromDate, Date), CType(strToDate, Date))
                                            Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strMessage)
                                        End If
                                    End If

                                    'strSQLQuery = "usp_Sel_tbl_PM_EmailMessages 427"
                                    'drEmailMessage = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    'If drEmailMessage.Read Then
                                    '    blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                                    '    blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                                    'End If
                                    'CommonFunctions.Data.DisposeDataReader(drEmailMessage)

                                    '' Check if the mail has to be sent.
                                    'If blnSendEmail = True Then
                                    '    ' Check if a popup message has to be shown.
                                    '    If blnShowPopup = True Then
                                    '        CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                                    '        'CommonFunctions.General.WriteHTML("window.open('../../Source/General/SendEmail.aspx?MessageID=427&VerifiedBy=" + CType(intVerifiedBy, String) + "&ResourceID=" + CType(m_strEmployeeID, String) + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left='" + "(window.screen.width - 600) / 2" + "',top='" + "(window.screen.height - 500) / 2" + "',width=600,height=500')" + vbCrLf)
                                    '        CommonFunctions.General.WriteHTML("window.open('../../Source/General/SendEmail.aspx?MessageID=427&VerifiedBy=" + CType(intVerifiedBy, String) + "&ResourceID=" + CType(intVerifiedBy, String) + "&FromDate=" + strFromDate + "&ToDate=" + strToDate + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                                    '        CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                                    '        ' Else, if the mail has to be sent silently, then...
                                    '    Else
                                    '        'TO DO: SEND EMAIL MESSAGE WITH CC
                                    '        'CommonFunction.EmailMessages.PMMessages. CRMMessages.GetEmailMessage_45(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intVerifiedBy, m_strEmployeeID)
                                    '        'CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_45(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                                    '    End If
                                    'End If
                                Next
                            End If
                            ''##### End Addition



                            ''##### Added For Work Order Facilities on 17 AUG 2004
                            'Case CommonFunction.Constants.APP_TAG_WORKORDER_FACILITIES
                            '        Dim blnSave As Boolean
                            '        Dim strSQL As String
                            '        Dim strFacilities As String
                            '        Dim drSaveFacilities As IDataReader
                            '        strFacilities = CType(HttpContext.Current.Request.Form("chkDelete"), String)
                            '        If HttpContext.Current.Request.QueryString("Save") = "True" Then
                            '            strSQL = "usp_Ins_tbl_PM_WorkOrderFacilities_ForProject '" + CType(strFacilities, String) + "'," + CType(HttpContext.Current.Session("intProjectID"), String)
                            '            drSaveFacilities = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '        End If

                            '        CommonFunctions.Data.DisposeDataReader(drSaveFacilities)
                            '##### END Addition

                            '##### Added For Question List on 21 Aug 2004
                            '##### Added For Work Order Facilities on 17 AUG 2004
                            'Case CommonFunction.Constants.APP_TAG_QUESTION_SELECTION_LIST
                            '        Dim blnSave As Boolean
                            '        Dim strSQL As String
                            '        Dim strQuestions As String
                            '        Dim strMandatory As String

                            '        Dim drSaveQuestions As IDataReader
                            '        strQuestions = CType(HttpContext.Current.Request.Form("chkDelete"), String)
                            '        strMandatory = CType(HttpContext.Current.Request.Form("chkMandatory"), String)

                            '        If HttpContext.Current.Request.QueryString("Save") = "True" Then
                            '            'strSQL = "usp_Q_Save_AddQuestionToQuestionnaire_WhizibleE '" + CType(strQuestions, String) + "'," + CType(HttpContext.Current.Request.QueryString("QuestionireID"), String) + ",'" + strMandatory + "'"
                            '            strSQL = "usp_Q_Save_AddQuestionToQuestionnaire_WhizibleE '" + CType(strQuestions, String) + "'," + CType(HttpContext.Current.Request.Form("txtQuestionireID"), String) + ",'" + strMandatory + "'"
                            '            drSaveQuestions = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '        End If

                            '        CommonFunctions.Data.DisposeDataReader(drSaveQuestions)
                            '        '##### END Addition

                            '        '##### End Addition

                            '        'Added by ShamkantD on 11th August 2004
                            'Case CommonFunction.Constants.APP_TAG_PM_SERVICE_SEGMENTATION
                            '        Dim intProjectID As String = HttpContext.Current.Session("intProjectID").ToString
                            '        Dim strSQL As String
                            '        Dim drServiceIDs As IDataReader
                            '        Dim strSegmentationIDs As String = ","
                            '        Dim strServiceIDs As String = ","
                            '        Dim strSubServiceIDs As String = ","

                            '        'Get the list of Service Segmentaion IDs selected for the current project
                            '        drServiceIDs = CommonFunction.Data.GetDataReader("SELECT DISTINCT ServicesSegmentationID FROM tbl_PM_Services WHERE ProjectID = " & intProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '        While drServiceIDs.Read
                            '            If CommonFunction.General.CheckIsNothing(drServiceIDs("ServicesSegmentationID")).ToString <> "" Then
                            '                strSegmentationIDs += drServiceIDs("ServicesSegmentationID").ToString + ","
                            '            End If
                            '        End While
                            '        CommonFunction.Data.DisposeDataReader(drServiceIDs)
                            '        HttpContext.Current.Session("strServicesSegmentationIDs") = strSegmentationIDs

                            '        'Get the list of Service Offering IDs selected for the current project
                            '        drServiceIDs = CommonFunction.Data.GetDataReader("SELECT DISTINCT A.ServiceOfferingID FROM tbl_PM_ServiceOffering A WHERE A.ProjectServiceID IN (SELECT ProjectServiceID FROM tbl_PM_Services B WHERE B.ProjectID = " & intProjectID & ")", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '        While drServiceIDs.Read
                            '            If CommonFunction.General.CheckIsNothing(drServiceIDs("ServiceOfferingID")).ToString <> "" Then
                            '                strServiceIDs += drServiceIDs("ServiceOfferingID").ToString + ","
                            '            End If
                            '        End While
                            '        CommonFunction.Data.DisposeDataReader(drServiceIDs)
                            '        HttpContext.Current.Session("strServiceOfferingIDs") = strServiceIDs

                            '        'Get the list of Sub Service Offering IDs selected for the current project
                            '        drServiceIDs = CommonFunction.Data.GetDataReader("SELECT DISTINCT A.SubServiceOfferingID FROM tbl_PM_ServiceOffering A WHERE A.ProjectServiceID IN (SELECT ProjectServiceID FROM tbl_PM_Services B WHERE B.ProjectID = " & intProjectID & ")", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '        While drServiceIDs.Read
                            '            If CommonFunction.General.CheckIsNothing(drServiceIDs("SubServiceOfferingID")).ToString <> "" Then
                            '                strSubServiceIDs += drServiceIDs("SubServiceOfferingID").ToString + ","
                            '            End If
                            '        End While
                            '        CommonFunction.Data.DisposeDataReader(drServiceIDs)
                            '        HttpContext.Current.Session("strSubServiceOfferingIDs") = strSubServiceIDs
                            '        'End of addition - ShamkantD on 11th August 2004

                            'Case CommonFunction.Constants.APP_TAG_PM_MARKET_SEGMENTATION
                            '        'Added by PareshB on September 07,2004
                            '        Dim intProjectID As String = HttpContext.Current.Session("intProjectID").ToString
                            '        Dim strSQL As String
                            '        Dim drMarketIDs As IDataReader
                            '        Dim strDomainIDs As String = ","
                            '        Dim strMarketIDs As String = ","
                            '        Dim strSubmarketIDs As String = ","

                            '        'Get the list of Domain IDs selected for the current project
                            '        drMarketIDs = CommonFunction.Data.GetDataReader("Select DISTINCT DomainID from tbl_PM_ExternalMarket Where ProjectID =" & intProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '        While drMarketIDs.Read
                            '            If CommonFunction.General.CheckIsNothing(drMarketIDs("DomainID")).ToString <> "" Then
                            '                strDomainIDs += drMarketIDs("DomainID").ToString + ","
                            '            End If
                            '        End While
                            '        CommonFunction.Data.DisposeDataReader(drMarketIDs)
                            '        HttpContext.Current.Session("strDomainIDs") = strDomainIDs

                            '        'Get the list of Market IDs selected for the current project
                            '        drMarketIDs = CommonFunction.Data.GetDataReader("SELECT DISTINCT tbl_PM_MarketSubMarket.MarketID FROM tbl_PM_MarketSubMarket,tbl_PM_ExternalMarket WHERE tbl_PM_MarketSubMarket.ProjectDomainID =  tbl_PM_ExternalMarket.ProjectDomainID AND ProjectID = " & intProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '        While drMarketIDs.Read
                            '            If CommonFunction.General.CheckIsNothing(drMarketIDs("MarketID")).ToString <> "" Then
                            '                strMarketIDs += drMarketIDs("MarketID").ToString + ","
                            '            End If
                            '        End While
                            '        CommonFunction.Data.DisposeDataReader(drMarketIDs)
                            '        HttpContext.Current.Session("strMarketIDs") = strMarketIDs

                            '        'Get the list of Sub Market IDs selected for the current project
                            '        drMarketIDs = CommonFunction.Data.GetDataReader("SELECT DISTINCT tbl_PM_MarketSubMarket.SubMarketID FROM tbl_PM_MarketSubMarket,tbl_PM_ExternalMarket WHERE tbl_PM_MarketSubMarket.ProjectDomainID =  tbl_PM_ExternalMarket.ProjectDomainID AND ProjectID = " & intProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '        While drMarketIDs.Read
                            '            If CommonFunction.General.CheckIsNothing(drMarketIDs("SubMarketID")).ToString <> "" Then
                            '                strSubmarketIDs += drMarketIDs("SubMarketID").ToString + ","
                            '            End If
                            '        End While
                            '        CommonFunction.Data.DisposeDataReader(drMarketIDs)
                            '        HttpContext.Current.Session("strSubmarketIDs") = strSubmarketIDs
                            '        'End of addition - PareshB on September 07,2004
                            'Case CommonFunction.Constants.APP_TAG_WORKORDER_CONTRACT_CLAUSES
                            '        Dim blnSave As Boolean
                            '        Dim strSQL As String
                            '        Dim strContractClauses As String
                            '        Dim drSaveContractClauses As IDataReader
                            '        strContractClauses = CType(HttpContext.Current.Request.Form("chkDelete"), String)
                            '        If HttpContext.Current.Request.QueryString("Save") = "True" Then
                            '            strSQL = "usp_Ins_tbl_PM_WorkOrderContractClauses_ForProject '" + CType(strContractClauses, String) + "'," + CType(HttpContext.Current.Session("intProjectID"), String)
                            '            drSaveContractClauses = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '        End If

                            '        CommonFunctions.Data.DisposeDataReader(drSaveContractClauses)
                            '        'End of Addition - ShamkantD on 20th August 2004

                            '        ' added by HarshK for sp4 issueid 200(Module selection List)
                        Case CommonFunction.Constants.APP_TAG_MODULE_SELECTION_LIST
                            CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                            CommonFunctions.General.WriteHTML("function Module_OnClick(UniqueID,strName)" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var strTempName = strName;" + vbCrLf)

                            CommonFunctions.General.WriteHTML("if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='TaskMap')" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objParentCbo = GetParentObjectReference('frmTaskDetails','cboColModule');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("if(objParentCbo != null){" + vbCrLf)
                            CommonFunctions.General.WriteHTML("for(var i = 0;i<objParentCbo.length;i++){" + vbCrLf)
                            CommonFunctions.General.WriteHTML("if(objParentCbo[i].value.substring(0,objParentCbo[i].value.indexOf('|')) == UniqueID){" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objParentCbo.selectedIndex = i;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("}}}}" + vbCrLf)

                            CommonFunctions.General.WriteHTML("window.close();" + vbCrLf)
                            CommonFunctions.General.WriteHTML("}" + vbCrLf)
                            CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                            '-----------------------------------------------------
                        Case CommonFunction.Constants.APP_TAG_MILESTONE_SELECTION_LIST
                            CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                            CommonFunctions.General.WriteHTML("function MileStone_OnClick(UniqueID,strName)" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var strTempName = strName;" + vbCrLf)

                            CommonFunctions.General.WriteHTML("if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='TaskMap')" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objParentCbo = GetParentObjectReference('frmTaskDetails','cboColMilestone');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("if(objParentCbo != null){" + vbCrLf)
                            CommonFunctions.General.WriteHTML("for(var i = 0;i<objParentCbo.length;i++){" + vbCrLf)
                            CommonFunctions.General.WriteHTML("if(objParentCbo[i].value.substring(0,objParentCbo[i].value.indexOf('|')) == UniqueID){" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objParentCbo.selectedIndex = i;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("}}}}" + vbCrLf)

                            CommonFunctions.General.WriteHTML("window.close();" + vbCrLf)
                            CommonFunctions.General.WriteHTML("}" + vbCrLf)
                            CommonFunctions.General.WriteHTML("</script>" + vbCrLf)

                        Case CommonFunction.Constants.APP_TAG_SUBPROJECT_SELECTION_LIST
                            CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                            CommonFunctions.General.WriteHTML("function SubProject_OnClick(UniqueID,strName)" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var strTempName = strName;" + vbCrLf)

                            CommonFunctions.General.WriteHTML("if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='TaskMap')" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objParentCbo = GetParentObjectReference('frmTaskDetails','cboColSubProject');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("if(objParentCbo != null){" + vbCrLf)
                            CommonFunctions.General.WriteHTML("for(var i = 0;i<objParentCbo.length;i++){" + vbCrLf)
                            CommonFunctions.General.WriteHTML("if(objParentCbo[i].value.substring(0,objParentCbo[i].value.indexOf('|')) == UniqueID){" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objParentCbo.selectedIndex = i;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("}}}}" + vbCrLf)

                            CommonFunctions.General.WriteHTML("window.close();" + vbCrLf)
                            CommonFunctions.General.WriteHTML("}" + vbCrLf)
                            CommonFunctions.General.WriteHTML("</script>" + vbCrLf)

                        Case CommonFunction.Constants.APP_TAG_TASKTYPE_SELECTION_LIST
                            CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                            CommonFunctions.General.WriteHTML("function TaskType_OnClick(UniqueID,strName)" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var strTempName = strName;" + vbCrLf)

                            CommonFunctions.General.WriteHTML("if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='TaskMap')" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objParentCbo = GetParentObjectReference('frmTaskDetails','cboColTaskType');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("if(objParentCbo != null){" + vbCrLf)
                            CommonFunctions.General.WriteHTML("for(var i = 0;i<objParentCbo.length;i++){" + vbCrLf)
                            CommonFunctions.General.WriteHTML("if(objParentCbo[i].value.substring(0,objParentCbo[i].value.indexOf('|')) == UniqueID){" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objParentCbo.selectedIndex = i;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("}}}}" + vbCrLf)

                            CommonFunctions.General.WriteHTML("window.close();" + vbCrLf)
                            CommonFunctions.General.WriteHTML("}" + vbCrLf)
                            CommonFunctions.General.WriteHTML("</script>" + vbCrLf)

                        Case CommonFunction.Constants.APP_TAG_PHASE_SELECTION_LIST
                            CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                            CommonFunctions.General.WriteHTML("function Phase_OnClick(UniqueID,strName)" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var strTempName = strName;" + vbCrLf)

                            CommonFunctions.General.WriteHTML("if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='TaskMap')" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objParentCbo = GetParentObjectReference('frmTaskDetails','cboColPhase');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("if(objParentCbo != null){" + vbCrLf)
                            CommonFunctions.General.WriteHTML("for(var i = 0;i<objParentCbo.length;i++){" + vbCrLf)
                            CommonFunctions.General.WriteHTML("if(objParentCbo[i].value.substring(0,objParentCbo[i].value.indexOf('|')) == UniqueID){" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objParentCbo.selectedIndex = i;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("}}}}" + vbCrLf)

                            CommonFunctions.General.WriteHTML("window.close();" + vbCrLf)
                            CommonFunctions.General.WriteHTML("}" + vbCrLf)
                            CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                            'End  added by HarshK for sp4 issueid 200(Module selection List)

                            '##### Case Added By AmitD on 25 Aug 2004 For Deliverables Selection List
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLES_SELECTION_LIST
                            CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                            '--- Modified by purvaj on 23 Apr 2009
                            '--- 3 Parameters added in the function 
                            'CommonFunctions.General.WriteHTML("function Deliverable_OnClick(DeliverableID,DelName)" + vbCrLf)
                            CommonFunctions.General.WriteHTML("function Deliverable_OnClick(DeliverableID,DelName,Baselinestartdate,Baselineenddate,baselinework,PlannedTaskEffots)" + vbCrLf)
                            '--- End modification purvaj

                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var str,intPer;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var strDelName = DelName;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='PM')" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            'Modified by SantoshK on Date June 8, 2006 for WhizibleSEM Issue ID.4168
                            'Purpose : Firefox Support
                            'CommonFunctions.General.WriteHTML("opener.frmTaskAssignment.txtDeliverableID.value=strDelName;" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("opener.frmTaskAssignment.txtHidDeliverableID.value=DeliverableID;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var objDeliverableName = GetParentObjectReference('frmTaskAssignment','txtDeliverableID');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objDeliverableName.value = strDelName ;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var objDeliverableID = GetParentObjectReference('frmTaskAssignment','txtHidDeliverableID');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objDeliverableID.value = DeliverableID ;" + vbCrLf)
                            'Modification Ends by SantoshK on June 8, 2006
                            '---- Added By purvaj on 23 Apr 2009 task validation done against deliverable baseline efforts and dates.
                            CommonFunctions.General.WriteHTML("var objtxtdelBasalinestartDate = GetParentObjectReference('frmTaskAssignment','txtdelBasalinestartDate');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objtxtdelBasalinestartDate.value = Baselinestartdate ;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var objtxtdelBaselineenddate = GetParentObjectReference('frmTaskAssignment','txtdelBaselineenddate');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objtxtdelBaselineenddate.value = Baselineenddate ;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var objtxtdelBaselinework = GetParentObjectReference('frmTaskAssignment','txtdelBaselinework');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objtxtdelBaselinework.value = baselinework ;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var objtxtdelPlannedTaskEfforts = GetParentObjectReference('frmTaskAssignment','txtdelPlannedTaskEfforts');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objtxtdelPlannedTaskEfforts.value = PlannedTaskEffots ;" + vbCrLf)

                            '--- ENd addition purvaj

                            CommonFunctions.General.WriteHTML("}" + vbCrLf)

                            CommonFunctions.General.WriteHTML("else if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='IB')" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            'Modified by SantoshK on Date June 8, 2006 for WhizibleSEM Issue ID.4168
                            'Purpose : Firefox Support
                            'CommonFunctions.General.WriteHTML("opener.frmIBIssueEntry.txtDeliverableName.value=strDelName;" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("opener.frmIBIssueEntry.DeliverableID.value=DeliverableID;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var objDeliverableName = GetParentObjectReference('frmIBIssueEntry','txtDeliverableName');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objDeliverableName.value = strDelName ;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var objDeliverableID = GetParentObjectReference('frmIBIssueEntry','DeliverableID');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objDeliverableID.value = DeliverableID ;" + vbCrLf)
                            'Modification Ends by SantoshK on June 8, 2006

                            CommonFunctions.General.WriteHTML("}" + vbCrLf)

                            'Code commented by SavitaS on 19 Jan 2006 to remove button next to Deliverable txtbox on Request Details Page.
                            ''Added by ManishK on11th Jan 2006 to add Deliverable txtBox on Helpdesk page
                            'CommonFunctions.General.WriteHTML("else if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='CRM')" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("opener.frmRequestDetails.txtDeliverableName.value=strDelName;" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("opener.frmRequestDetails.DeliverableID.value=DeliverableID;" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("}" + vbCrLf)
                            ''End of Added by ManishK on11th Jan 2006 to add Deliverable txtBox on Helpdesk page
                            'End comment by SavitaS on 19 Jan 2006

                            CommonFunctions.General.WriteHTML("else if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='Review')" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)

                            'Modified by SantoshK on Date June 8, 2006 for WhizibleSEM Issue ID.4168
                            'Purpose : Firefox Support
                            'CommonFunctions.General.WriteHTML("alert(DeliverableID);" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("opener.frmCommonPage.NonDatabase7.value=strDelName;" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("opener.frmCommonPage.txtHidDeliverableID.value=DeliverableID;" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("opener.frmCommonPage.DeliverableID.value=DeliverableID;" + vbCrLf)

                            CommonFunctions.General.WriteHTML("var objNonDatabase7 = GetParentObjectReference('frmCommonPage','NonDatabase7');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objNonDatabase7.value = strDelName ;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var objDeliverableName = GetParentObjectReference('frmCommonPage','txtHidDeliverableID');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objDeliverableName.value = strDelName ;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var objDeliverableID = GetParentObjectReference('frmCommonPage','DeliverableID');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objDeliverableID.value = DeliverableID ;" + vbCrLf)
                            'End Modification
                            'CommonFunctions.General.WriteHTML("}" + vbCrLf)
                            CommonFunctions.General.WriteHTML("}" + vbCrLf)


                            CommonFunctions.General.WriteHTML("else if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='Reviews')" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("alert(DeliverableID);" + vbCrLf)
                            'MODIFIED BY VIVEKP ON 27 SEP 2005 For ISSUEID -382
                            'CommonFunctions.General.WriteHTML("opener.frmCommonPage.NonDatabase2.value=strDelName;" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("opener.frmCommonPage.txtHidDeliverableID.value=DeliverableID;" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("opener.frmCommonPage.DeliverableID.value=DeliverableID;" + vbCrLf)
                            'END OF MODIFICATION BY VIVEKP ON 27 SEP 2005 FOR ISSUEID -382

                            'Modified by SantoshK on Date June 8, 2006 for WhizibleSEM Issue ID.4168
                            'Purpose : Firefox Support
                            CommonFunctions.General.WriteHTML("var objNonDatabase2 = GetParentObjectReference('frmCommonPage','NonDatabase2');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objNonDatabase2.value = strDelName ;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var objDeliverableName = GetParentObjectReference('frmCommonPage','txtHidDeliverableID');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objDeliverableName.value = strDelName ;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var objDeliverableID = GetParentObjectReference('frmCommonPage','DeliverableID');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objDeliverableID.value = DeliverableID ;" + vbCrLf)
                            'End Modification

                            CommonFunctions.General.WriteHTML("}" + vbCrLf)

                            'Added by Harshk For sp4 issueid 200 (Deliverable mapping on change management)
                            CommonFunctions.General.WriteHTML("else if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='ChgMng')" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("opener.frmCommonPage.NonDatabase1.value=strDelName;" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("opener.frmCommonPage.txtHidDeliverableID.value=DeliverableID;" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("opener.frmCommonPage.DeliverableID.value=DeliverableID;" + vbCrLf)

                            'Modified by SantoshK on Date June 8, 2006 for WhizibleSEM Issue ID.4168
                            'Purpose : Firefox Support
                            CommonFunctions.General.WriteHTML("var objNonDatabase1 = GetParentObjectReference('frmCommonPage','NonDatabase1');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objNonDatabase1.value = strDelName ;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var objDeliverableName = GetParentObjectReference('frmCommonPage','txtHidDeliverableID');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objDeliverableName.value = strDelName ;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var objDeliverableID = GetParentObjectReference('frmCommonPage','DeliverableID');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objDeliverableID.value = DeliverableID ;" + vbCrLf)
                            'End Modification

                            CommonFunctions.General.WriteHTML("}" + vbCrLf)

                            CommonFunctions.General.WriteHTML("else if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='TaskMap')" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objParentCbo = GetParentObjectReference('frmTaskDetails','cboColDeliverable');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("if(objParentCbo != null){" + vbCrLf)
                            CommonFunctions.General.WriteHTML("for(var i = 0;i<objParentCbo.length;i++){" + vbCrLf)
                            CommonFunctions.General.WriteHTML("if(objParentCbo[i].value.substring(0,objParentCbo[i].value.indexOf('|')) == DeliverableID){" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objParentCbo.selectedIndex = i;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("}}}}" + vbCrLf)

                            'End Added by Harshk For sp4 issueid 200 (Deliverable mapping on change management)

                            'Added By PadmnabhA
                            'Description - To Select Deliverables Selection for "IssueEntryForReview" page
                            CommonFunctions.General.WriteHTML("else if('" + CType(HttpContext.Current.Request("FromWhere"), String) + "'=='ReviewAction')" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{" + vbCrLf)

                            'Modified by SantoshK on Date June 8, 2006 for WhizibleSEM Issue ID.4168
                            'Purpose : Firefox Support
                            'CommonFunctions.General.WriteHTML("opener.frmIssueEntryForReview.txtDeliverable.value=strDelName;" + vbCrLf)
                            'CommonFunctions.General.WriteHTML("opener.frmIssueEntryForReview.DeliverableID.value=DeliverableID;" + vbCrLf)

                            CommonFunctions.General.WriteHTML("var objDeliverableName = GetParentObjectReference('frmCommonPage','txtDeliverable');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objDeliverableName.value = strDelName ;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var objDeliverableID = GetParentObjectReference('frmCommonPage','DeliverableID');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objDeliverableID.value = DeliverableID ;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("}" + vbCrLf)
                            'End Modification

                            'Added By Bharat Tekade on 11th-jan-2016 for Quick Create Page Deliverable Selection

                            CommonFunctions.General.WriteHTML("else if('" + CType(InStr(HttpContext.Current.Request("FromWhere").ToString.Trim, "QuickCreate", CompareMethod.Text), String) + "' > '0')" + vbCrLf)
                            CommonFunctions.General.WriteHTML("{ " + vbCrLf)
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
                            CommonFunctions.General.WriteHTML("var objDeliverableName = GetParentObjectReference('frmQuickTask','txtDeliverableID" + RowNumber + "');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objDeliverableName.value = strDelName ;" + vbCrLf)
                            CommonFunctions.General.WriteHTML("var objDeliverableID = GetParentObjectReference('frmQuickTask','txtHidDeliverableID" + RowNumber + "');" + vbCrLf)
                            CommonFunctions.General.WriteHTML("objDeliverableID.value = DeliverableID ;" + vbCrLf)

                            CommonFunctions.General.WriteHTML("}" + vbCrLf)
                            'End of Added By Bharat Tekade on 11th-jan-2016 for Quick Create Page Deliverable Selection

                            'Code Addition by PadmnabhA Ends
                            CommonFunctions.General.WriteHTML("window.close();" + vbCrLf)
                            CommonFunctions.General.WriteHTML("}" + vbCrLf)
                            '***** Code added by SandipL on 15 Feb 2006 --IssueID 2120
                            If HttpContext.Current.Request.QueryString("FromWhere") = "IB" Then
                                CommonFunctions.General.WriteHTML("function Paging_Print(strPagingAlphabet)" + vbCrLf)
                                CommonFunctions.General.WriteHTML("{" + vbCrLf)
                                CommonFunctions.General.WriteHTML(" objfrm.action = 'CommonList.aspx?SetPagingAlphabet=1&Fromwhere=IB&ProjectID=" & CType(HttpContext.Current.Session("SessionProject"), String) & "&PagingAlphabet='+  strPagingAlphabet;" + vbCrLf)
                                CommonFunctions.General.WriteHTML(" objfrm.submit(); return;" + vbCrLf)
                                CommonFunctions.General.WriteHTML("}" + vbCrLf)
                            End If
                            '***** End addition by SandipL on 15 Feb 2006
                            CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                            '##### End Addition
                            'added by SachinR   on 15 Sep 2004

                        Case CommonFunction.Constants.APP_TAG_ADD_PROCESS_TO_OU
                            'plot hidden control to persist the value of OUPoolID passed from query string 
                            Dim strOUPoolID As String
                            strOUPoolID = HttpContext.Current.Request.QueryString("OUPoolID") + ""
                            If strOUPoolID = "" Then
                                strOUPoolID = HttpContext.Current.Request.Form("txtOUPoolID") + ""
                            End If
                            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtOUPoolID", "txtOUPoolID", , , , strOUPoolID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
                            'addition end

                            'Added by ShamkantD on 16 Sep 2004 - for Select Cost Heads page (called from Project Costs)
                            'Case CommonFunction.Constants.APP_TAG_TAB_SELECT_COST_HEADS
                            '        Dim strCostHeadIDList As String = ""
                            '        Dim strSQLQuery As String = ""
                            '        Dim drCostHeads As IDataReader

                            '        'If Save link clicked, Save the changes
                            '        strCostHeadIDList = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), ""), String)
                            '        If HttpContext.Current.Request.QueryString("Action") = "Save" Then
                            '            strSQLQuery = "EXEC usp_Ins_tbl_PM_WorkOrderCosts_ForProject " & _
                            '                "'" & CType(strCostHeadIDList, String) & "'," & _
                            '                CType(HttpContext.Current.Session("intProjectID"), String) & "," & _
                            '                "'" & CommonFunction.General.CheckIsNothing(WhizGlobal.UserName, "").ToString() & "'"
                            '            CommonFunctions.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '        End If
                            '        'End of addition - ShamkantD on 16 Sep 2004

                            '        'added by SachinR   on 17 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_ADD_METRIC_TO_OU
                            'plot hidden control to persist the value of OUPoolID passed from query string 
                            Dim strOUPoolID As String
                            strOUPoolID = HttpContext.Current.Request.QueryString("OUPoolID") + ""
                            If strOUPoolID = "" Then
                                strOUPoolID = HttpContext.Current.Request.Form("txtOUPoolID") + ""
                            End If
                            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtOUPoolID", "txtOUPoolID", , , , strOUPoolID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))

                        Case CommonFunction.Constants.APP_TAG_ADD_PMI_TO_OU
                            'plot hidden control to persist the value of OUPoolID passed from query string 
                            Dim strOUPoolID As String
                            strOUPoolID = HttpContext.Current.Request.QueryString("OUPoolID") + ""
                            If strOUPoolID = "" Then
                                strOUPoolID = HttpContext.Current.Request.Form("txtOUPoolID") + ""
                            End If
                            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtOUPoolID", "txtOUPoolID", , , , strOUPoolID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
                            'addition end

                            'Added by ShamkantD on 27 Sep 2004
                            'Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING
                            '        Dim strQuery As String = ""
                            '        Dim blnIsApprover As Boolean = False

                            '        'Get whether or not the logged in user is approver
                            '        'Integrated by SandipL SP8 to SP9

                            '        'Added By JyotiG (08-Jan-2007)
                            '        'Purpose :Customer cannot approve Project.so while checking he is approver or  not check he is employee / Customer
                            '        'Checking of Employee/Customer is added By JyotiG
                            '        If HttpContext.Current.Session("LoginType").ToString = "E" Then
                            '            strQuery = "usp_Sel_tbl_PM_Role_IsApprover " & _
                            '                                            CommonFunction.General.CheckIsNothing(WhizGlobal.UserID, "0").ToString()
                            '            blnIsApprover = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
                            '            HttpContext.Current.Session("blnIsApprover") = blnIsApprover
                            '        End If
                            '        'End Integration by SandipL SP8 to SP9
                            '        'End of addition - ShamkantD on 27 Sep 2004

                            '        'Added by ShamkantD on 5 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_BUSINESS_GROUP
                            'Added for - Select Middle Level Resources for Business Group
                            'Dim strEmployeeIDList As String = ""
                            'Dim strSQLQuery As String = ""
                            'Dim drCostHeads As IDataReader
                            Dim strMasterPrimaryKeyValue As String = ""
                            Dim strScript As String = ""

                            'plot hidden control to persist the value of MasterPrimaryKeyValue passed from query string 
                            strMasterPrimaryKeyValue = HttpContext.Current.Request.QueryString("MasterPrimaryKeyValue") + ""
                            If strMasterPrimaryKeyValue = "" Then
                                strMasterPrimaryKeyValue = HttpContext.Current.Request.Form("txtMasterPrimaryKeyValue") + ""
                            End If
                            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtMasterPrimaryKeyValue", "txtMasterPrimaryKeyValue", , , , strMasterPrimaryKeyValue.Trim, , , , , , True, , True, EnableHTMLEncode:=True))

                            'If Save link clicked, Save the changes
                            If strMasterPrimaryKeyValue.Trim <> "" Then
                                If HttpContext.Current.Request.QueryString("Action") = "Save" Then
                                    'strEmployeeIDList = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), ""), String)

                                    'strSQLQuery = "EXEC usp_Ins_tbl_CNF_BusinessGroups_MiddleLevelResources " & _
                                    '    "'" & CType(strEmployeeIDList, String) & "'," & _
                                    '    strMasterPrimaryKeyValue.Trim
                                    'CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    'Close this dialog and refresh the opener window
                                    strScript = vbCrLf + "<Script language=javascript>"
                                    strScript += vbCrLf + "    refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FocusOn=SUBTAG');"
                                    strScript += vbCrLf + "    window.close();"
                                    strScript += vbCrLf + "</Script>"
                                    CommonFunction.General.WriteHTML(strScript)
                                End If
                            End If
                            'End of addition - ShamkantD on 5 Oct 2004

                            'Added by ShamkantD on 6 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_ORGANIZATION_UNIT
                            'Added for - Select Middle Level Resources for Organization Unit 
                            'Dim strEmployeeIDList As String = ""
                            'Dim strSQLQuery As String = ""
                            'Dim drCostHeads As IDataReader
                            Dim strMasterPrimaryKeyValue As String = ""
                            Dim strScript As String = ""

                            'plot hidden control to persist the value of MasterPrimaryKeyValue passed from query string 
                            strMasterPrimaryKeyValue = HttpContext.Current.Request.QueryString("MasterPrimaryKeyValue") + ""
                            If strMasterPrimaryKeyValue = "" Then
                                strMasterPrimaryKeyValue = HttpContext.Current.Request.Form("txtMasterPrimaryKeyValue") + ""
                            End If
                            ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtMasterPrimaryKeyValue", "txtMasterPrimaryKeyValue", , , , strMasterPrimaryKeyValue.Trim, , , , , , True, , True, EnableHTMLEncode:=True))

                            'If Save link clicked, Save the changes
                            If strMasterPrimaryKeyValue.Trim <> "" Then
                                If HttpContext.Current.Request.QueryString("Action") = "Save" Then
                                    'strEmployeeIDList = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), ""), String)

                                    'strSQLQuery = "EXEC usp_Ins_tbl_PM_Location_MiddleLevelResources " & _
                                    '    "'" & CType(strEmployeeIDList, String) & "'," & _
                                    '    strMasterPrimaryKeyValue.Trim
                                    'CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    'Close this dialog and refresh the opener window
                                    strScript = vbCrLf + "<Script language=javascript>"
                                    strScript += vbCrLf + "    refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FocusOn=SUBTAG');"
                                    strScript += vbCrLf + "    window.close();"
                                    strScript += vbCrLf + "</Script>"

                                    CommonFunction.General.WriteHTML(strScript)
                                End If
                            End If

                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_DELIVERY_UNIT
                            'Added for - Select Middle Level Resources for Delivery Unit 
                            'Dim strEmployeeIDList As String = ""
                            'Dim strSQLQuery As String = ""
                            'Dim drCostHeads As IDataReader
                            Dim strMasterPrimaryKeyValue As String = ""
                            Dim strScript As String = ""

                            'plot hidden control to persist the value of MasterPrimaryKeyValue passed from query string 
                            strMasterPrimaryKeyValue = HttpContext.Current.Request.QueryString("MasterPrimaryKeyValue") + ""
                            If strMasterPrimaryKeyValue = "" Then
                                strMasterPrimaryKeyValue = HttpContext.Current.Request.Form("txtMasterPrimaryKeyValue") + ""
                            End If
                            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtMasterPrimaryKeyValue", "txtMasterPrimaryKeyValue", , , , strMasterPrimaryKeyValue.Trim, , , , , , True, , True))

                            'If Save link clicked, Save the changes
                            If strMasterPrimaryKeyValue.Trim <> "" Then
                                If HttpContext.Current.Request.QueryString("Action") = "Save" Then
                                    'strEmployeeIDList = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), ""), String)

                                    'strSQLQuery = "EXEC usp_Ins_tbl_PM_ResourcePool_MiddleLevelResources " & _
                                    '    "'" & CType(strEmployeeIDList, String) & "'," & _
                                    '    strMasterPrimaryKeyValue.Trim
                                    'CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    'Close this dialog and refresh the opener window
                                    strScript = vbCrLf + "<Script language=javascript>"
                                    strScript += vbCrLf + "    refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FocusOn=SUBTAG');"
                                    strScript += vbCrLf + "    window.close();"
                                    strScript += vbCrLf + "</Script>"

                                    CommonFunction.General.WriteHTML(strScript)
                                End If
                            End If

                        Case CommonFunction.Constants.APP_TAG_SELECT_MIDDLE_LEVEL_RESOURCES_FOR_DELIVERY_TEAM
                            'Added for - Select Middle Level Resources for Delivery Team 
                            'Dim strEmployeeIDList As String = ""
                            'Dim strSQLQuery As String = ""
                            'Dim drCostHeads As IDataReader
                            Dim strMasterPrimaryKeyValue As String = ""
                            Dim strScript As String = ""

                            'plot hidden control to persist the value of MasterPrimaryKeyValue passed from query string 
                            strMasterPrimaryKeyValue = HttpContext.Current.Request.QueryString("MasterPrimaryKeyValue") + ""
                            If strMasterPrimaryKeyValue = "" Then
                                strMasterPrimaryKeyValue = HttpContext.Current.Request.Form("txtMasterPrimaryKeyValue") + ""
                            End If
                            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtMasterPrimaryKeyValue", "txtMasterPrimaryKeyValue", , , , strMasterPrimaryKeyValue.Trim, , , , , , True, , True, EnableHTMLEncode:=True))

                            'If Save link clicked, Save the changes
                            If strMasterPrimaryKeyValue.Trim <> "" Then
                                If HttpContext.Current.Request.QueryString("Action") = "Save" Then
                                    'strEmployeeIDList = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), ""), String)

                                    'strSQLQuery = "EXEC usp_Ins_tbl_PM_GroupMaster_MiddleLevelResources " & _
                                    '    "'" & CType(strEmployeeIDList, String) & "'," & _
                                    '    strMasterPrimaryKeyValue.Trim
                                    'CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    'Close this dialog and refresh the opener window
                                    strScript = vbCrLf + "<Script language=javascript>"
                                    strScript += vbCrLf + "    refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FocusOn=SUBTAG');"
                                    strScript += vbCrLf + "    window.close();"
                                    strScript += vbCrLf + "</Script>"

                                    CommonFunction.General.WriteHTML(strScript)
                                End If
                            End If
                            'End of addition - ShamkantD on 6 Oct 2004

                            ' Added By NitinVS ON 7 Dec 
                            ' if the link update Template is clicked then add the selected template for the Project
                        Case CommonFunction.Constants.APP_TAG_SELECT_TEMPLATE_FOR_PROJECT
                            ' Commented by MahendraV On 5:55 PM 6/28/2007
                            ' To commented this code from PageListPreRender
                            ' IssueID(14030) Project > Project Confguration > Execution Template Selection : Page not getting refreshed
                            ' Start_MV_6/28/2007
                            '    Dim strTemplateID As String
                            '    Dim StrSqlQuery As String
                            Dim StrScript As String
                            If HttpContext.Current.Request.QueryString("MODE") = "UPDATE_TEMPLATE" Then

                                '        strTemplateID = HttpContext.Current.Request.QueryString("TemplateID").ToString

                                '        strSqlQuery = "EXEC usp_Upd_tbl_PM_Project_AssociatePractice " & _
                                '        CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString() & _
                                '        ",Null,'" & CommonFunction.General.CheckIsNothing(WhizGlobal.UserName, "").ToString() & "'," & strTemplateID
                                '        CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                '        ' Refresh The Opener
                                StrScript = vbCrLf + "<Script language=javascript>"
                                '//Modified By ShraddhaM on 4/10/2006 For SP7 IssuID : 6601
                                StrScript += vbCrLf + "if (navigator.appName =='Netscape')"
                                StrScript += vbCrLf + "refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx',true);"
                                StrScript += vbCrLf + "else"
                                StrScript += vbCrLf + "    refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx');"
                                '//Ended By ShraddhaM on 4/10/2006 For SP7 IssuID : 6601
                                StrScript += vbCrLf + "</Script>"
                                CommonFunction.General.WriteHTML(StrScript)
                            End If
                            ' End_MV_6/28/2007
                            '    'End Addition NitinVS on 7 Dec 2004
                            '    ' Added By PrachiK on 28 Mar 2005. 
                            '    ' if the link update Template is clicked then add the selected Cheklist for the Project

                        Case CommonFunction.Constants.APP_TAG_SELECT_CHECKLIST_FOR_PROJECT
                            'Dim strQuestionnaireID As String
                            'Dim strCheckListShortName As String
                            'Dim StrSqlQuery As String
                            'Dim StrScript As String
                            If HttpContext.Current.Request.QueryString("MODE") = "UPDATE_CHECKLIST" Then

                                Dim sbScript As New System.Text.StringBuilder

                                'strQuestionnaireID = HttpContext.Current.Request.QueryString("QuestionnaireID").ToString
                                'strCheckListShortName = HttpContext.Current.Request.QueryString("CheckListShortName").ToString


                                'strSqlQuery = "EXEC usp_Ins_tbl_PM_WorkOrderCheckList " & _
                                'CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString() & _
                                '", '" & CommonFunctions.General.BuildQueryString(strCheckListShortName) & "'," & strQuestionnaireID
                                ''modified by harshada d for chk list issue sp 7.5
                                ''", """ & strCheckListShortName & """," & strQuestionnaireID
                                'CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                ' Refresh The Opener
                                '//Modified By ShraddhaM on 4/10/2006 For SP7 IssuID : 6594
                                sbScript.Append(vbCrLf)
                                sbScript.Append("<Script language=javascript>")
                                sbScript.Append(vbCrLf)
                                sbScript.Append("if (navigator.appName =='Netscape'){")
                                'strScript += vbCrLf + "?FromWhere=PM&MasterTagId=2263'"
                                sbScript.Append(vbCrLf)
                                sbScript.Append(" refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx',true);")
                                ''strScript += vbCrLf + "opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=3025';"
                                sbScript.Append(vbCrLf)
                                sbScript.Append("}")
                                sbScript.Append(vbCrLf)
                                sbScript.Append("else")
                                sbScript.Append(vbCrLf)
                                sbScript.Append("    refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx?FromWhere=PM&MasterTagId=2263');")
                                '//Ended By ShraddhaM on 4/10/2006 For SP7 IssuID : 6594
                                sbScript.Append(vbCrLf)
                                sbScript.Append("</Script>")
                                CommonFunction.General.WriteHTML(sbScript.ToString)
                                'sbScript.Remove(1, sbScript.Length)

                                sbScript = Nothing
                            End If

                            'End of Addtion by PrachiK
                            'Added by MrugajaB on 3 Mar 2005 for Project Document Category
                            'Case CommonFunction.Constants.APP_TAG_PROJECT_DOCUMENTCATEGORY
                            '    Dim strCategoryIDList As String = ""
                            '    Dim strSQLQuery As String = ""
                            '    Dim drCostHeads As IDataReader
                            '    Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                            '    Dim strScript As String = ""
                            '    Dim strAction As String

                            '    strAction = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action").ToUpper)

                            '    If strAction = "SAVE" Then
                            '        strCategoryIDList = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), ""), String) + ","
                            '        strSQLQuery = "EXEC usp_Ins_tbl_PM_Project_DocumentCategory " + intProjectID.ToString + ", '" + CType(strCategoryIDList, String) + "' "
                            '        CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '        CommonFunction.General.WriteHTML(strScript)
                            '    End If

                            '    'End Addition
                            '    '***** Code added by SandipL on 23 Nov 2005 --IssueID 672
                            '    'To remove session variable before closing
                        Case CommonFunction.Constants.APP_TAG_PROJECT_CUSTOM_FIELD_MAINTENANCE
                            If HttpContext.Current.Request.QueryString("close") = "1" Then
                                HttpContext.Current.Session.Remove("CustomFieldID")
                                Dim StrScript As String
                                StrScript = vbCrLf + "<Script language=javascript>"
                                StrScript += vbCrLf + "    window.close();"
                                StrScript += vbCrLf + "</Script>"
                                CommonFunction.General.WriteHTML(StrScript)

                                '***** End addition by SandipL on 23 Nov 2005

                            End If
                            ' Not Commented By MahendraV
                            '***** Code added by SandipL on 24 Nov 2005 for refreshing parent Page(Templates page)
                        Case CommonFunction.Constants.APP_TAG_COPY_EXECUTION_TEMPLATE
                            'Dim strScript As String
                            'strScript = "<script language = javascript>"
                            'strScript += " alert('Copied template is in draft mode. Please publish it before using it.');"
                            '' strScript += "opener.location.href='CommonList.aspx?FromWhere=PM&MasterTagId=" & CommonFunction.Constants.APP_TAG_PRACTICE_SELECTION & "';"
                            'strScript += "window.close();"
                            '' strscript += " refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx?FromWhere=PM&MasterTagID=2175',true); " + vbCrLf

                            'strScript += "window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?FromWhere=PM&MasterTagID=2175';" + vbCrLf
                            'strScript += "window.opener.document.forms['frmCommonList'].submit();" + vbCrLf
                            ''strScript += "return;"
                            'strScript += "</script>"
                            'CommonFunction.General.WriteHTML(strScript)
                            ''***** End addition by SandipL  on 24 Nov 2005

                            'Code added by SandipL on 7 Dec 2005 for IR/PIR Issue
                        Case CommonFunction.Constants.APP_TAG_RFI_TOOL, CommonFunction.Constants.APP_TAG_RFI_OS, CommonFunction.Constants.APP_TAG_RFI_SALES_PERSON

                            Dim strScript As String

                            strScript += "var objXHttp;" + vbCrLf
                            strScript += "var strID = '';" + vbCrLf
                            strScript += "	function HandlerOnReadyState()" + vbCrLf
                            strScript += "{" + vbCrLf
                            strScript += "if (objXHttp.readyState==4)" + vbCrLf
                            strScript += "{" + vbCrLf
                            strScript += "if (objXHttp.responseText != null) " + vbCrLf
                            strScript += " {" + vbCrLf
                            strScript += " if (objXHttp.responseText != '')" + vbCrLf
                            strScript += " {" + vbCrLf
                            If WhizGlobal.TagID = CommonFunction.Constants.APP_TAG_RFI_TOOL Then
                                strScript += "opener.frmRFI_RFI.txtRFIToolIDs.value= strID " + vbCrLf
                                strScript += "opener.frmRFI_RFI.txtRFIToolNames.value=objXHttp.responseText " + vbCrLf
                            ElseIf WhizGlobal.TagID = CommonFunction.Constants.APP_TAG_RFI_OS Then
                                strScript += "opener.frmRFI_RFI.txtRFIOSIDs.value= strID " + vbCrLf
                                strScript += "opener.frmRFI_RFI.txtRFIOSNames.value=objXHttp.responseText " + vbCrLf
                            ElseIf WhizGlobal.TagID = CommonFunction.Constants.APP_TAG_RFI_SALES_PERSON Then
                                'Integrated by TruptiK on 18-May-09
                                'Modified By VarunA on 23-Mar-2009 IssueID-29343
                                'Purpose : To have sale person in Mozilla
                                'strScript += "opener.frmRFI_RFI.txtRFISalesPersonIDs.value= strID " + vbCrLf
                                'strScript += "opener.frmRFI_RFI.txtRFISalesPersonNames.value=objXHttp.responseText " + vbCrLf
                                strScript += "window.opener.document.forms['frmRFI_RFI'].elements['txtRFISalesPersonIDs'].value= strID " + vbCrLf
                                strScript += "window.opener.document.forms['frmRFI_RFI'].elements['txtRFISalesPersonNames'].value=objXHttp.responseText " + vbCrLf
                                'End By VarunA on 23-Mar-2009 IssueID-29343
                                'End of intrgrated by TruptiK
                            End If
                            strScript += "window.close();" + vbCrLf
                            strScript += "}" + vbCrLf
                            strScript += "else" + vbCrLf
                            strScript += " {" + vbCrLf
                            If WhizGlobal.TagID = CommonFunction.Constants.APP_TAG_RFI_TOOL Then
                                strScript += "opener.frmRFI_RFI.txtRFIToolIDs.value= '' " + vbCrLf
                                strScript += "opener.frmRFI_RFI.txtRFIToolNames.value='' " + vbCrLf
                            ElseIf WhizGlobal.TagID = CommonFunction.Constants.APP_TAG_RFI_OS Then
                                strScript += "opener.frmRFI_RFI.txtRFIOSIDs.value= '' " + vbCrLf
                                strScript += "opener.frmRFI_RFI.txtRFIOSNames.value='' " + vbCrLf
                            ElseIf WhizGlobal.TagID = CommonFunction.Constants.APP_TAG_RFI_SALES_PERSON Then
                                ''Integrated by TruptiK on 18-May-09
                                'Modified By VarunA on 23-Mar-2009 IssueID-29343
                                'Purpose : To have sale person in Mozilla
                                'strScript += "opener.frmRFI_RFI.txtRFISalesPersonIDs.value= '' " + vbCrLf
                                'strScript += "opener.frmRFI_RFI.txtRFISalesPersonNames.value='' " + vbCrLf
                                strScript += "window.opener.document.forms['frmRFI_RFI'].elements['txtRFISalesPersonIDs'].value= strID " + vbCrLf
                                strScript += "window.opener.document.forms['frmRFI_RFI'].elements['txtRFISalesPersonNames'].value=objXHttp.responseText " + vbCrLf
                                'End By VarunA on 23-Mar-2009 IssueID-29343
                                'End of Integrated by TruptiK on 18-May-09
                            End If
                            strScript += "window.close();" + vbCrLf
                            strScript += "}" + vbCrLf
                            strScript += "}" + vbCrLf
                            strScript += "}" + vbCrLf
                            strScript += "}" + vbCrLf
                            PageListPreRender = strScript
                            strActionCode = ReturnCodes.ON_LOAD.ToString
                            'End addition by SandipL

                            'Integrated by MrugajaB on 3rd Jan 2006 for Whiz2 Processes - Build 29
                            ' 'Code Added     :   ManishK     on 30th Aug 2005
                        Case CommonFunction.Constants.APP_TAG_SDLC_PROCESS
                            If HttpContext.Current.Request.QueryString("ToDo") = "Sync" Then
                                Dim strActivityIDs As String
                                'Dim strSQLQuery As String = ""
                                strActivityIDs = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkSynchronize"), ""), String)

                                If strActivityIDs <> "" Then
                                    'strSQLQuery = "EXEC usp_RemoveActivity_tbl_PRS_Project_SDLC_Details " & HttpContext.Current.Session("intProjectID").ToString & "," & HttpContext.Current.Request.QueryString("ProcessID") & ",'" & strActivityIDs & "'"
                                    'CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    Dim strScript As String = ""
                                    strScript = vbCrLf + "<Script language=javascript>"
                                    strScript += vbCrLf + "window.location.href = 'CommonList.aspx?ProcessID=" + HttpContext.Current.Request.QueryString("ProcessID") + "&FromWhere=PM&MasterTagId=" + CommonFunction.Constants.APP_TAG_SDLC_PROCESS.ToString + "';"
                                    strScript += vbCrLf + "</Script>"
                                    CommonFunction.General.WriteHTML(strScript)
                                End If
                            End If
                            ' 'End of Addition    :   ManishK     on 30th Aug 2005
                            'End Integration
                            '----------------------------------------------------------------------------------
                            ''---Code Added By SajiU on 5th Dec  2006
                        Case CommonFunction.Constants.App_Tag_Login_Maintenance
                            Dim strMessage As String
                            Dim strNotAllowedUsers As String
                            'Check for Tampering of encrypted data.

                            If Not IsNothing(HttpContext.Current.Session("InfoManipulated")) Then

                                If HttpContext.Current.Session("InfoManipulated").ToString = "1" Then
                                    'strMessage = m_objTemplate.GetResourceString("NUMBER_OF_LICENSED_USERS_CANNOT_BE_MANIPULATED_AT_YOUR_END") + " !!" + "\r\n"
                                    If WhizGlobal.TagID = CommonFunction.Constants.App_Tag_Login_Maintenance Then

                                        CommonFunction.General.WriteHTML("<script language=javascript>")
                                        CommonFunction.General.WriteHTML("window.open('../SM/SM_LicenseExpired.aspx?FromWhere=E','', 'resizable=yes,menubar=no,scrollbars=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 600)/2 + ',width=500,height=400'); window.close();")
                                        CommonFunction.General.WriteHTML("</script>")
                                        ' PageListPreRender = "../SM/SM_LicenseExpired.aspx?FromWhere=E"
                                    Else
                                        ' PageListPreRender = "../SM/SM_LicenseExpired.aspx?FromWhere=C"
                                    End If
                                End If
                            End If

                            If Not IsNothing(HttpContext.Current.Session("intLoginsCreated")) Then
                                If HttpContext.Current.Session("intLoginsCreated").ToString <> "" Then
                                    strMessage += Replace(CommonFunctions.General.CheckIsNothing(m_objTemplate.GetResourceString("MSG_LOGINS_CREATED")), "<Count>", HttpContext.Current.Session("intLoginsCreated").ToString) + "\r\n"

                                End If
                            End If
                            If (Not IsNothing(HttpContext.Current.Session("ExcessLogins"))) And (Not IsNothing(HttpContext.Current.Session("intAllowedNoOfUsers"))) And (Not IsNothing(HttpContext.Current.Session("intActualNoOfUsers"))) Then
                                If HttpContext.Current.Session("ExcessLogins").ToString = "1" Then
                                    ''strMessage += m_objTemplate.GetResourceString("YOU_HAVE_BEEN_GIVEN_A_LICENSE_FOR").Replace("<USER_COUNT>", HttpContext.Current.Session("intAllowedNoOfUsers").ToString) + "\r\n"
                                    ''' strMessage += "YOU HAVE BEEN GIVEN A LICENSE FOR  " + HttpContext.Current.Session("intAllowedNoOfUsers").ToString
                                    If CInt(HttpContext.Current.Session("intAllowedNoOfUsers")) <= CInt(HttpContext.Current.Session("intActualNoOfUsers")) Then
                                        ''    strMessage += m_objTemplate.GetResourceString("YOU_HAVE_ALREADY_ADDED_USERS").Replace("<USER_COUNT>", HttpContext.Current.Session("intActualNoOfUsers").ToString) + "\r\n"

                                        ''End If



                                        ''    strMessage += m_objTemplate.GetResourceString("YOU_HAVE_EXCEEDED_THE_LIMIT") + " !!" + "\r\n"
                                        ''    'strMessage += "YOU HAVE EXCEEDED THE LIMIT " + " !!"

                                        ''End If
                                        If WhizGlobal.TagID = CommonFunction.Constants.App_Tag_Login_Maintenance Then

                                            CommonFunction.General.WriteHTML("<script language=javascript>")
                                            CommonFunction.General.WriteHTML("window.open('../SM/SM_LicenseExpired.aspx?FromWhere=E','', 'resizable=yes,menubar=no,scrollbars=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 600)/2 + ',width=500,height=400'); window.close();")
                                            CommonFunction.General.WriteHTML("</script>")
                                            ' PageListPreRender = "../SM/SM_LicenseExpired.aspx?FromWhere=E"
                                        Else
                                            ' PageListPreRender = "../SM/SM_LicenseExpired.aspx?FromWhere=C"
                                        End If
                                        strActionCode = ReturnCodes.REDIRECT.ToString


                                    End If
                                End If
                            End If

                            If Not IsNothing(HttpContext.Current.Session("strNotAllowedUsers")) Then
                                If HttpContext.Current.Session("strNotAllowedUsers").ToString <> "" Then
                                    strNotAllowedUsers = HttpContext.Current.Session("strNotAllowedUsers").ToString
                                    strNotAllowedUsers = strNotAllowedUsers.Trim

                                    If strNotAllowedUsers.EndsWith(",") = True Then
                                        strNotAllowedUsers = strNotAllowedUsers.Substring(0, strNotAllowedUsers.Length - 1)
                                    End If
                                    'strMessage += Replace(CommonFunctions.General.CheckIsNothing(m_objTemplate.GetResourceString("EMP_LOGIN_LIC_EXCEED")), "<LIC_NO>", HttpContext.Current.Session("intAllowedUsers").ToString)
                                    'strMessage += Replace(CommonFunctions.General.CheckIsNothing(m_objTemplate.GetResourceString("EMP_LOGIN_LIC_EXCEED")), "<LIC_NO>", HttpContext.Current.Session("intAllowedUsers").ToString)
                                    strMessage += m_objTemplate.GetResourceString("MSG_LOGINS_ALREADY_EXISTS") + strNotAllowedUsers.ToString + "\r\n"

                                End If
                            End If

                            HttpContext.Current.Session("intLoginsCreated") = Nothing
                            HttpContext.Current.Session("intAllowedUsers") = Nothing
                            HttpContext.Current.Session("InfoManipulated") = Nothing
                            HttpContext.Current.Session("ExcessLogins") = Nothing
                            HttpContext.Current.Session("intAllowedNoOfUsers") = Nothing
                            HttpContext.Current.Session("intActualNoOfUsers") = Nothing
                            HttpContext.Current.Session("strNotAllowedUsers") = Nothing

                            If strMessage <> "" Then
                                PageListPreRender += vbCrLf + "alert('" + strMessage + "')" + vbCrLf
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If

                            ''    '    '---End of Addition by SajiU on 5th Dec 2006
                            ''    '----------------------------------------------------------------------------------

                            'Code Added by PrashantD on 7 May 2007 for PointWest RequestID 6720
                            'Purpose: Session("DeliverableType") did not initialized anywhere. Here it is initialized.
                        Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                            HttpContext.Current.Session("DeliverableType") = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT ISNULL(FixedValue,'0') from tbl_UI_EmployeeFilterSettings_FieldDetails Where TagID = " + CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE.ToString + " AND UserID = " + HttpContext.Current.Session("intUserID").ToString + " AND ControlName = 'DeliverableTypeID'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), String)
                            'End of addition by PrashantD on 7 May 2007
                            'Added by ShraddhaM on 14,Sep 2007
                            'Purpose : Clear Preferences
                        Case CommonFunction.Constants.APP_TAG_EMPLOYEE_MAINTENANCE
                            Dim strFrom As String
                            Dim strEmpID As String
                            Dim strQuery As String
                            Dim strQueryEmpFilters As String
                            Dim strFieldFilters As String
                            Dim drUserPreferences As IDataReader
                            Dim Key As String
                            strFrom = HttpContext.Current.Request.QueryString("From")
                            strEmpID = HttpContext.Current.Request.QueryString("EmpID")

                            If Not strFrom Is Nothing Then
                                If strFrom.ToUpper = "CLEAREPREFERENCES" Then
                                    strQuery = "SELECT  * FROM tbl_UI_UserPreferences WHERE UserID = " + strEmpID
                                    drUserPreferences = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    While drUserPreferences.Read
                                        Key = drUserPreferences("UserID").ToString() + "-" + drUserPreferences("LoginType").ToString() + "-" + drUserPreferences("Identifier").ToString() + "-" + drUserPreferences("ItemID").ToString()
                                        CommonEngines.HashTables.GetHashTableObject.ClearUPFHashTable(Key)
                                    End While
                                    CommonFunction.Data.DisposeDataReader(drUserPreferences)
                                    strQuery = "DELETE FROM tbl_UI_UserPreferences WHERE LoginType='E' AND UserID = " + strEmpID
                                    CommonFunctions.Data.InsertOrUpdateData(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    strQueryEmpFilters = "DELETE FROM tbl_UI_EMployeeFiltersettings WHERE LoginType='E' AND UserID = " + strEmpID
                                    CommonFunctions.Data.InsertOrUpdateData(strQueryEmpFilters, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    strFieldFilters = "UPDATE tbl_UI_EmployeeFilterSettings_FieldDetails SET FixedValue = NULL,UserFriendlyFixedValue = NULL WHERE LoginType='E' AND UserID = " + strEmpID + " AND FixedValue IS NOT NULL AND UserFriendlyFixedValue IS NOT NULL"
                                    CommonFunctions.Data.InsertOrUpdateData(strFieldFilters, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    CommonFunctions.Data.InsertOrUpdateData("usp_Del_tbl_PM_DefaultTabProject " + strEmpID + ",'E'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                End If
                            End If
                            'End of addition by ShraddhaM on 14,Sep 2007
                            'Addedby ArchanaN on 21 JAn 2008
                            'To display the managers of the resource pool. To Persist the Resource RequestID Query String
                        Case CommonFunction.Constants.APP_TAG_REQUEST_APPROVERS
                            Dim strRequestID As String
                            strRequestID = HttpContext.Current.Request.QueryString("RequestID")
                            If strRequestID Is Nothing OrElse strRequestID = "" Then
                                strRequestID = HttpContext.Current.Request.Form("hidRequestID")
                            End If
                            CommonFunction.General.WriteHTML("<input type=hidden id=hidRequestID name=hidRequestID value=" + strRequestID + ">")
                            'End by ArchanaN
                    End Select
                Else
                    Select Case WhizGlobal.TagID
                        'Case CommonFunction.Constants.APP_TAG_TAB_PROJECT_FACILITIES
                        '    '--------------Added by AbhijeetD on 11th May 2004---------------
                        '    Dim strCreatedBy As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"))
                        '    Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                        '    Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

                        '    'Insert all the Facilities into tbl_PM_WorkOrderFacilities if none exist
                        '    If (CommonFunction.Data.GetDataScalar("SELECT WorkOrderFacilityID FROM tbl_PM_WorkOrderFacilities WHERE ProjectID = " + intProjectID.ToString, blnUseSQL) Is Nothing) Then
                        '        CommonFunction.Data.InsertOrUpdateData("usp_Ins_tbl_PM_WorkOrderFacilities " + intProjectID.ToString + ", '" + strCreatedBy + "'", blnUseSQL)
                        '    End If
                        '    '------------------------End addition----------------------------

                    End Select
                End If

                ' Database update need to be moved in WhizForm_Init due to DataSet Related Changes For Whiziblesem 7
                ' Commented code moved from PageListPreRender To WhizForm_Init
                ' End_of cmmeted code here by MahendraV On 6/28/2007

            End Function

            Public Function PageUIPreRender(ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal strPrimaryKey As String = "") As String
                PageUIPreRender = ""
                Dim strSenderRevisionID As String
                'Application standard return code
                strActionCode = ReturnCodes.DO_NOTHING.ToString

                '----------- Added By Purvaj on 8 may 2008 Configurable workflow
                If WhizGlobal.ParentTagID = 0 Then
                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING, CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS, CommonFunction.Constants.APP_TAG_MODULES, CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT, CommonFunction.Constants.APP_TAG_SUB_PROJECTS, CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                            CommonFunction.WhizibleWorkflow.PerformWorkflowAction(WhizGlobal.TagID, strPrimaryKey, WhizGlobal)
                    End Select

                End If
                '----------- End addition PurvaJ

                If WhizGlobal.ParentTagID = 0 Then

                    Select Case WhizGlobal.TagID
                        ' Modified By MahendraV On 24-Nov-2008 for Whiziblesem8.0_Whiz3
                        ' Purpose : to hide back link if all taged page opend from workflow approvals page 
                        ' Start_MV_24-Nov-2008
                        Case CommonFunction.Constants.APP_TAG_SUB_PROJECTS, CommonFunction.Constants.APP_TAG_DELIVERABLES, CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT, CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING, CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS, CommonFunction.Constants.APP_TAG_MODULES, CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT, CommonFunction.Constants.APP_TAG_SUB_PROJECTS
                            If Not HttpContext.Current.Request.QueryString("ForWorkflowFrom") Is Nothing Then
                                If HttpContext.Current.Request.QueryString("ForWorkflowFrom").ToUpper() = "WF" Then
                                    ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                    CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtFromforWF", "txtFromforWF", , , , HttpContext.Current.Request.QueryString("ForWorkflowFrom").ToString(), , , , , , True, , True, EnableHTMLEncode:=True))
                                    strActionCode = ReturnCodes.ON_LOAD.ToString()
                                End If
                            Else
                                If Not HttpContext.Current.Request.Form("txtFromforWF") Is Nothing Then
                                    If HttpContext.Current.Request.Form("txtFromforWF").ToUpper() = "WF" Then
                                        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                                        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtFromforWF", "txtFromforWF", , , , HttpContext.Current.Request.Form("txtFromforWF").ToString(), , , , , , True, , True))
                                        strActionCode = ReturnCodes.ON_LOAD.ToString()
                                    End If
                                End If
                            End If
                            ' End_MV_24-Nov-2008
                    End Select
                    'Master Tag
                    Select Case WhizGlobal.TagID

                        'Added By Chakshuta H on 29th-Oct-2015
                        ' For Ref. No : WAF3_GEN_3 Tenant & Sub Tenant Creation
                        ' By SumitS
                        'WAF_DISABLE_USERLICENCING : Added Case for Client Login Maintenance 
                        'i.e. TAG_LOGIN_MAINTENANCE_CUSTOMER_CREATED
                        Case CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_EMPLOYEE, _
                            CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_CUSTOMER, _
                            CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_CUSTOMER_CREATED, _
                            CommonFunction.Constants.TAG_SUB_TENANTS, _
                            CommonFunction.Constants.TAG_TENANTS

                            'Modified - By PushkarK ON 23-May-2008 For WAF_DISABLE_USERLICENCING
                            'Get the framework Setting to bypass check for the no. of user licences.
                            'If the key is not present/ has value = 'N', then do not bypass. 
                            Dim blnDisableUserLicencing As Boolean = False
                            blnDisableUserLicencing = CommonFunctions.General.GetFrameworkSettings("WAF_DISABLE_USERLICENCING", "Y")

                            If blnDisableUserLicencing = False Then

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

                                If blnCInfoManipulated = True Or (blnRestrictExcessLogins = True And (intAllowedNoOfUsers <= intActualNoOfUsers) And strPrimaryKey = "") Then
                                    'Redirect to the page SM_LicenseExpired with the parameter FromWhere depending upon tag i.e. Employee or Customer
                                    If WhizGlobal.TagID = CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_EMPLOYEE Then
                                        PageUIPreRender = "../SM/SM_LicenseExpired.aspx?FromWhere=E"
                                    Else
                                        PageUIPreRender = "../SM/SM_LicenseExpired.aspx?FromWhere=C"
                                    End If
                                    strActionCode = ReturnCodes.REDIRECT.ToString
                                End If

                            End If
                            'Modification Ends - By PushkarK ON 23-May-2008 For WAF_DISABLE_USERLICENCING
                            'Added By NileshD on 07/09/04
                        Case CommonFunctions.Constants.App_TAG_THEMES
                            Dim drStyleSheet As IDataReader
                            Dim strSQL As String
                            Dim strDefault As String
                            strSQL = "SELECT UserStyleSheetID FROM tbl_UI_UserSettings WHERE LoginID = " + WhizGlobal.LoginID.ToString
                            drStyleSheet = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If drStyleSheet.Read Then
                                drStyleSheet.Close()
                            Else
                                drStyleSheet.Close()
                                strSQL = "SELECT StylesheetID FROM tbl_UI_StyleSheets WHERE IsSystemDefault = 1"
                                drStyleSheet = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drStyleSheet.Read Then
                                    strDefault = drStyleSheet("StyleSheetID").ToString
                                    strSQL = "INSERT INTO tbl_UI_UserSettings(LoginID, StyleSheetID) Values(" + WhizGlobal.LoginID.ToString + "," + strDefault + ")"
                                    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                End If
                            End If
                            CommonFunction.Data.DisposeDataReader(drStyleSheet)
                            'End Of Addition

                            'Ended By Chakshuta H on 29th-Oct-2015




                            'Modified By VidyaJ - Performance Issue - Deliverable - SP4 - IssueID -84

                            'Store selected deliverable in session variable and use it while plotting instead of
                            'firing the query every time in control event

                        Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                            'here check if control is applicable then only show it,else dont show it
                            'if control is mandatory then only make it mandatory, else dont
                            'default all the controls are mandatory
                            Dim strSQL As String
                            Dim objDr As IDataReader
                            Dim strScheduleID As String
                            Dim blnUseSQL As Boolean


                            blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

                            strScheduleID = ""
                            'Modified by SachinR    on 12 Oct 2004
                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ScheduleTypeID"), "") <> "" Then
                                strScheduleID = HttpContext.Current.Request.QueryString("ScheduleTypeID")
                            End If
                            'modification end

                            'if user has not selected any deliverable type and clicked on the deliverable to edit it
                            'then no deliveable type will be stored as user preferences.Then get the deliverable typeID
                            'from the deliverable record
                            If strScheduleID = "" Or strScheduleID = "0" Then
                                strSQL = "usp_sel_tbl_PM_OtherSchedules " + strPrimaryKey
                                objDr = CommonFunction.Data.GetDataReader(strSQL, blnUseSQL)
                                If objDr.Read Then
                                    strScheduleID = CommonFunction.Data.CheckIsDBNull(objDr("ScheduleTypeID"), "").ToString + ""
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)

                            End If
                            HttpContext.Current.Session("ScheduleTypeID") = strScheduleID
                            'End Of Modifications
                            'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                        Case CommonFunction.Constants.APP_TAG_RFI_MILESTONE
                            If CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String), m_strToken) = False Then
                                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("IR/PIR", CType(2044, Long), CType(0, Long), "RFIID", HttpContext.Current.Request.QueryString("RFIID").ToString)

                                'Token is Invalid now redirect to the Invalid Access Page
                                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                            End If
                            'Added By JyotiG
                            'Start
                            'Issue Id : 6197
                        Case CommonFunction.Constants.APP_TAG_RFI_CHANGE_STATUS

                            'plot hidden control to persist the value of OUPoolID passed from query string 
                            Dim strToken As String
                            strToken = HttpContext.Current.Request.QueryString("PKToken") + ""
                            If strToken = "" Then
                                strToken = HttpContext.Current.Request.Form("txtToken") + ""
                            End If
                            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtToken", "txtToken", , , , strToken.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
                            'addition end
                            'End

                        Case CommonFunction.Constants.APP_TAG_RFI_DELIVERABLES
                            If CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String), m_strToken) = False Then
                                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("IR/PIR", CType(2044, Long), CType(0, Long), "RFIID", HttpContext.Current.Request.QueryString("RFIID").ToString)

                                'Token is Invalid now redirect to the Invalid Access Page
                                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                            End If
                            'End
                        Case CommonFunction.Constants.APP_TAG_PRACTICE_SELECTION
                            '--- Code added by NileshJ on 20 May to maintain the primary key of th project.
                            If HttpContext.Current.Request.QueryString("ProjectPhaseTaskTemplateID_PK") <> "" Then
                                HttpContext.Current.Session("ProjectPhaseTaskTemplateID_PK_Copy") = HttpContext.Current.Request.QueryString("ProjectPhaseTaskTemplateID_PK")
                            End If
                            '--- Addition Ends.
                            '--- addition ends
                        Case CommonFunction.Constants.APP_TAG_TAB_RATE_CONTRACT
                            'Added By paresh B. on August 09,2004
                            'Purpose : To Delete User Preferences Since it cause the error while 
                            'hiding user Selected Tab in rate Contract Page
                            'Variable Declarations
                            Dim strSQL As String        'For SQL Query for Deletion
                            Dim intResult As Integer    'For Storing the result of Delete Operation
                            Dim strScript As String = ""
                            Dim strNodeLabel As String = ""
                            Dim strQuery As String = ""

                            'Set the SQL Query 
                            strSQL = "Delete From tbl_UI_UserPreferences Where UserId = " & HttpContext.Current.Session("intUserID").ToString & " And ItemID = " & CommonFunction.Constants.APP_TAG_TAB_RATE_CONTRACT & " And Identifier= 'SUBTAG'"

                            'Execute the Query 
                            intResult = CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            'Added by ShamkantD on 13 Oct 2004
                            'Get the node label so that it can be printed as title
                            strQuery = "usp_Sel_GetContractType_NodeLabel_ForProject " & HttpContext.Current.Session("intProjectID").ToString
                            'strNodeLabel = CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")).ToString()
                            strNodeLabel = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
                            strNodeLabel = Replace(strNodeLabel, "'", "\'")
                            If strNodeLabel.Trim() <> "" Then
                                strScript = "document.title='" & strNodeLabel & "';"
                                PageUIPreRender = strScript
                            End If

                            'Application standard return code
                            strActionCode = ReturnCodes.ON_LOAD.ToString
                            'End of addition - ShamkantD on 13 Oct 2004

                        Case CommonFunction.Constants.APP_TAG_REVIEW_PLANNING
                            Dim strScript As String
                            Dim StrToday As String
                            'Initialize the varibles used to display validation messages
                            strScript = "var strReviewDateMsg1='" + m_objTemplate.GetResourceString("REVIEW_PLANNING_REVIEW_DATE_MESSAGE1") + "';" + vbCrLf
                            'strScript += "var strReviewDateMsg2='" + m_objTemplate.GetResourceString("REVIEW_PLANNING_REVIEW_DATE_MESSAGE2") + "';"

                            strScript += "var strReviewDateMsg2='" + m_objTemplate.GetResourceString("REVIEW_PLANNING_REVIEW_DATE_MESSAGE3") + " " + Date.Today.ToString("dd-MMM-yyyy") + "';"
                            'MODIFIED BY VIVEKP ON 27 SEP 2005 FOR ISSUEIS-382
                            strScript += "function SelectDeliverable()"
                            strScript += "{"
                            '//Modified By nitinVS on 10 Mar 2007 for WhizibleSEM SP 8 IssueID 11507
                            'Added script to check existance of the object
                            strScript += "objDeliverableID = GetObjectReference('frmCommonPage','DeliverableID');"
                            strScript += " var deliverableValue ='';  "
                            strScript += " if( objDeliverableID != null ) { deliverableValue = objDeliverableID.value ; " + vbCrLf
                            strScript += "window.open('../General/CommonList.aspx?MasterTagID=2176&FromWhere=Review&DeliverableID=' + deliverableValue,'','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=800,height=500'); "
                            strScript += " } "
                            '//End Modified By nitinVS on 10 Mar 2007 for WhizibleSEM SP 8 IssueID 11507

                            strScript += "}"
                            'END OF MODIFICATION  BY VIVEKP ON 27 SEP 2005 FOR ISSUEIS-382

                            PageUIPreRender = strScript
                            'Application standard return code
                            strActionCode = ReturnCodes.ON_LOAD.ToString
                            'Added by harsh for sp4 issueid 200 on 12/09/05 (Deliverable mapping)
                        Case CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT
                            Dim strScript As String
                            strScript = "function SelectDeliverable()"
                            strScript += "{"
                            strScript += "objDeliverableID = GetObjectReference('frmCommonPage','DeliverableID');"
                            '//Modified By nitinVS on 10 Mar 2007 for WhizibleSEM SP 8 IssueID 11507
                            'Added script to check existance of the object
                            strScript += " var deliverableValue ='';  "
                            strScript += " if( objDeliverableID != null ) { deliverableValue = objDeliverableID.value ; " + vbCrLf
                            strScript += "window.open('../General/CommonList.aspx?MasterTagID=2176&FromWhere=ChgMng&DeliverableID=' + deliverableValue,'','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=800,height=500');"
                            strScript += " } "
                            '//End Modified By nitinVS on 10 Mar 2007 for WhizibleSEM SP 8 IssueID 11507

                            strScript += "}"
                            PageUIPreRender = strScript
                            'Application standard return code
                            strActionCode = ReturnCodes.ON_LOAD.ToString
                            'end 'Added by harsh for sp4 issueid 200 on 12/09/05 (Deliverable mapping)
                        Case CommonFunction.Constants.APP_TAG_REVIEWS
                            Dim strScript As String
                            strScript = "function SelectDeliverable()"
                            strScript += "{"
                            strScript += "objDeliverableID = GetObjectReference('frmCommonPage','DeliverableID');"
                            '//Modified By nitinVS on 10 Mar 2007 for WhizibleSEM SP 8 IssueID 11507
                            'Added script to check existance of the object
                            strScript += " var deliverableValue ='';  "
                            strScript += " if( objDeliverableID != null ) { deliverableValue = objDeliverableID.value ; " + vbCrLf
                            strScript += "window.open('../General/CommonList.aspx?MasterTagID=2176&FromWhere=Reviews&DeliverableID=' + deliverableValue,'','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=800,height=500');"
                            strScript += " } "
                            '//End Modified By nitinVS on 10 Mar 2007 for WhizibleSEM SP 8 IssueID 11507

                            strScript += "}"


                            PageUIPreRender = strScript
                            'Application standard return code
                            strActionCode = ReturnCodes.ON_LOAD.ToString

                        Case CommonFunction.Constants.APP_TAG_FAST_TRACK_REVIEWS
                            Dim strScript As String
                            strScript = "function SelectDeliverable()"
                            strScript += "{"
                            strScript += "objDeliverableID = GetObjectReference('frmCommonPage','DeliverableID');"
                            strScript += " var deliverableValue ='';  "
                            '//Modified By nitinVS on 10 Mar 2007 for WhizibleSEM SP 8 IssueID 11507
                            'Added script to check existance of the object
                            strScript += " if( objDeliverableID != null ) { deliverableValue = objDeliverableID.value ; " + vbCrLf
                            strScript += "window.open('../General/CommonList.aspx?MasterTagID=2176&FromWhere=Reviews&DeliverableID=' + deliverableValue,'','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=800,height=500');"
                            strScript += " } "
                            '//End Modified By nitinVS on 10 Mar 2007 for WhizibleSEM SP 8 IssueID 11507

                            strScript += "}"


                            PageUIPreRender = strScript
                            'Application standard return code
                            strActionCode = ReturnCodes.ON_LOAD.ToString


                        Case CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_EMPLOYEE, CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_CUSTOMER

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
                            CommonFunction.Data.DisposeDataReader(drCompanyInformation)                           'Check if the no of users is manipulated
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

                            If blnCInfoManipulated = True Or (blnRestrictExcessLogins = True And (intAllowedNoOfUsers <= intActualNoOfUsers) And strPrimaryKey = "") Then
                                'Redirect to the page SM_LicenseExpired with the parameter FromWhere depending upon tag i.e. Employee or Customer
                                If WhizGlobal.TagID = CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_EMPLOYEE Then
                                    PageUIPreRender = "../SM/SM_LicenseExpired.aspx?FromWhere=E"
                                Else
                                    PageUIPreRender = "../SM/SM_LicenseExpired.aspx?FromWhere=C"
                                End If
                                strActionCode = ReturnCodes.REDIRECT.ToString
                            End If

                        Case CommonFunction.Constants.APP_TAG_MYPROFILE
                            Dim strScript As String
                            'Initialize the varibles used to display validation messages
                            strScript = "var strDateMsg='" + m_objTemplate.GetResourceString("MYPROFILE_PASSPORT_ISSUEDATE") + "';"
                            strScript &= vbCrLf & "var strBirthDateMsg='" + m_objTemplate.GetResourceString("MYPROFILE_BIRTHDATE") + "';"
                            PageUIPreRender = strScript
                            'Application standard return code
                            strActionCode = ReturnCodes.ON_LOAD.ToString

                            '***** Code Commented and added by SandipL on 24 Nov 3005
                            'Purpose :- Check whether Employee has already applied in the fromDate and todate range
                            'Pupose of comment ;- Same code for both no need to write seperately

                            ''''Commented By ManishK on 3rd Jan 2006 for Addition of inherited page for WFH 
                            ''' Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEAPPLICATION, CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS
                            ''''End ofCommented By ManishK on 3rd Jan 2006 for Addition of inherited page for WFH 
                            '''Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS
                            '''    'Initialize the Resources
                            '''    m_objTemplate.InitializeResources("AppResources.EmployeeLeaveApplication", "AppResources")
                            '''    Dim strScript As String
                            '''    'Initialize the varibles used to display validation messages
                            '''    strScript = "var strDateMsg='" + m_objTemplate.GetResourceString("LEAVE_APPLICATION_HALFDAY_MESSAGE") + "';" + vbCrLf
                            '''    strScript += "var objXHttp;" + vbCrLf
                            '''    strScript += "var blnFlag = false;" + vbCrLf
                            '''    strScript += "	function HandlerOnReadyState()" + vbCrLf
                            '''    strScript += "{" + vbCrLf
                            '''    strScript += "if (objXHttp.readyState==4)" + vbCrLf
                            '''    strScript += "{" + vbCrLf
                            '''    strScript += "if (objXHttp.responseText != null) " + vbCrLf
                            '''    strScript += " {" + vbCrLf
                            '''    strScript += " if (objXHttp.responseText == 'True')" + vbCrLf
                            '''    strScript += " {alert('Employee has already applied for leave between \'' + objfrm.FromDate.value + '\' and \'' + objfrm.ToDate.value + '\'');" + vbCrLf
                            '''    strScript += " blnFlag = true;" + vbCrLf
                            '''    strScript += "}" + vbCrLf
                            '''    strScript += " else" + vbCrLf
                            '''    strScript += " blnFlag = false;" + vbCrLf
                            '''    strScript += "}" + vbCrLf
                            '''    strScript += "}" + vbCrLf
                            '''    strScript += "}" + vbCrLf
                            '''    PageUIPreRender = strScript
                            '''    'ReInitialize the Resources
                            '''    m_objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                            '''    'Application standard return code
                            '''    strActionCode = ReturnCodes.ON_LOAD.ToString
                            ''End of Commented by ManishK on 3rd Jan 06


                            'Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS
                            '    'Initialize the Resources
                            '    m_objTemplate.InitializeResources("AppResources.EmployeeLeaveApplication", "AppResources")
                            '    Dim strScript As String
                            '    'Initialize the varibles used to display validation messages
                            '    strScript = "var strDateMsg='" + m_objTemplate.GetResourceString("LEAVE_APPLICATION_HALFDAY_MESSAGE") + "';"
                            '    PageUIPreRender = strScript
                            '    'ReInitialize the Resources
                            '    m_objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                            '    'Application standard return code
                            '    strActionCode = ReturnCodes.ON_LOAD.ToString

                            '***** End comment and addition by SandipL on 24 Nov 2005
                            'Code Added by PrashantD on 19 Jan 2008 for Resource Demand Enhancment
                            'Case CommonFunction.Constants.APP_TAG_RESOURCEREQUEST
                        Case CommonFunction.Constants.APP_TAG_RESOURCEREQUEST, CommonFunction.Constants.APP_TAG_EXTENDRESOURCEREQUEST
                            'added by NileshD   On  9 Apr 2004
                            'added client side message of project date validation for resource request
                            'Initialize the Resources
                            m_objTemplate.InitializeResources("AppResources.PM_ResourceAllocation", "AppResources")
                            Dim strScript As String
                            'Initialize the varibles used to display validation messages
                            strScript = "var strProjectDateMsg='" + m_objTemplate.GetResourceString("PROJECT_END_DATE_MESSAGE") + "';" + vbCrLf
                            strScript += "var strPerDay ='" + m_objTemplate.GetResourceString("WORKHOURS_PERDAY_MESSAGE") + "';" + vbCrLf
                            strScript += "var strPercent ='" + m_objTemplate.GetResourceString("WORKHOURS_PERCENT_MESSAGE") + "';" + vbCrLf
                            'Added By NileshD On 7th Jan 2005 To resolve the issue 14850
                            strScript += "var strDuration ='" + m_objTemplate.GetResourceString("PROJECT_DURATION_MSG") + "';" + vbCrLf
                            'End Of Addition
                            PageUIPreRender = strScript
                            'add the working hours value from databse by passing project id
                            Dim dblWorkHours As Double = 0
                            dblWorkHours = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_tbl_PM_Location_WorkHours " & WhizGlobal.ProjectID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Double)
                            PageUIPreRender += "var intWorkHours=" & dblWorkHours.ToString() & ";"
                            'ReInitialize the Resources
                            m_objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                            'Application standard return code
                            strActionCode = ReturnCodes.ON_LOAD.ToString
                            'Added By JayavantK, On - 30-Aug-2004
                            If CType(HttpContext.Current.Session.Item("AssignResource"), Integer) = 1 Then
                                ''Commented and added by NitinC on 01 Mar 2012 For WhizibleSEM 11.0
                                'PageUIPreRender += "refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx');"
                                PageUIPreRender += "refreshParent('frmCommonList','Resources_CommonList.aspx','Resources_CommonList.aspx');"
                                ''End of Commented and added by NitinC on 01 Mar 2012 For WhizibleSEM 11.0
                                HttpContext.Current.Session.Item("AssignResource") = 0
                            End If
                            'End Addition

                        Case CommonFunction.Constants.APP_TAG_RISKS

                            'added by SachinR   On  9 Apr 2004
                            'add client side variable to use as a flag for the message of 
                            'invoking the ContingencyPlan in case of Status=Occurred
                            PageUIPreRender = " var blnIsStatusChanged=false; "
                            'Application standard return code
                            strActionCode = ReturnCodes.ON_LOAD.ToString
                            'Case CommonFunction.Constants.APP_TAG_RATECONTRACTBYROLE
                            '    'added by DipaliS On 10 th May for Rate Contract By Role
                            '    Dim drRateByRole As IDataReader
                            '    Dim strProjectID As String
                            '    strProjectID = HttpContext.Current.Session("intProjectID").ToString
                            '    'Check whether the record for given projectId exists
                            '    Dim strSQL As String = "usp_Sel_tbl_PM_WorkOrderRateContract " & strProjectID
                            '    drRateByRole = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '    'if no,insert new record
                            '    If Not drRateByRole.Read Then
                            '        strSQL = "Insert into tbl_PM_WorkOrderRateContract(ProjectID,RateMethod) values(" & strProjectID & ",'H')"
                            '        CommonFunctions.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '    End If
                            '    CommonFunctions.Data.DisposeDataReader(drRateByRole)
                            '    strActionCode = ReturnCodes.ON_LOAD.ToString
                        Case CommonFunction.Constants.APP_TAG_CONTRACT_REVIEW_MEETING
                            '--------------Added by AbhijeetD on 10th May 2004---------------
                            Dim strCustomerName As String
                            Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                            Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
                            Dim drCustomerInfo As IDataReader

                            'Get the Customer Name for the project in session
                            drCustomerInfo = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_CustomerInformation " + intProjectID.ToString, blnUseSQL)
                            If drCustomerInfo.Read Then
                                strCustomerName = CommonFunction.General.CheckIsNothing(drCustomerInfo("CustomerName"), "")
                            End If
                            CommonFunction.Data.DisposeDataReader(drCustomerInfo)

                            'Insert a Contract Meeting Record for the project in session if it does not exist
                            If (CommonFunction.Data.GetDataScalar("SELECT CRMID FROM tbl_PM_CRM WHERE ProjectID = " + intProjectID.ToString, blnUseSQL) Is Nothing) Then
                                CommonFunction.Data.InsertOrUpdateData("INSERT INTO tbl_PM_CRM(ProjectID, CustomerName) VALUES(" + intProjectID.ToString + ",'" + strCustomerName + "')", blnUseSQL)
                            End If
                            '------------------------End addition----------------------------
                            'added By SachinR   on 15 Jul 2004
                        Case CommonFunction.Constants.APP_TAG_SDLC_SAVE_WITH_REVISION
                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")).ToUpper = "SAVE" Then
                                Dim strSDLCID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("NonDatabase1"))
                                Dim strProcessID As String = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_Sel_tbl_PRS_Project_SDLC_ProcessID '" + strSDLCID + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                                PageUIPreRender = "refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?Operation=SAVE&Mode=&MasterTagID=" + CommonFunction.Constants.APP_TAG_SDLC_PROCESS.ToString + "&FromWhere=PM&ParentTagID=0&SDLCId=" + strSDLCID + "&ProcessID=" + strProcessID + "',true);"
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If
                            'addition end
                        Case CommonFunction.Constants.APP_TAG_RFI_TAX_BUILDER
                            Dim objAppResource As WebPages.Template.WhizTemplate
                            objAppResource = New WebPages.Template.WhizTemplate
                            objAppResource.InitializeResources("AppResources.EventHandlers", "AppResources")

                            Dim strToBeInserted As String
                            'Validate
                            strToBeInserted += vbCrLf + "function ValidateFormula(strType,strValue)" + vbCrLf + "{"
                            strToBeInserted += vbCrLf + "var strExistingFormula;"
                            strToBeInserted += vbCrLf + "strExistingFormula = objfrm.Formula.value;"
                            strToBeInserted += vbCrLf + "strValue = trimString(strValue);"
                            strToBeInserted += vbCrLf + "if(strType == ""OPERAND"")" + vbCrLf + "{"
                            strToBeInserted += vbCrLf + "if(strExistingFormula == """")"
                            strToBeInserted += vbCrLf + "return true;"
                            strToBeInserted += vbCrLf + "else if(strExistingFormula.indexOf(strValue) >= 0)" + vbCrLf + "{"
                            strToBeInserted += vbCrLf + "alert('" + objAppResource.GetResourceString("RFI_FORMULA_DUPLICATE") + "');"
                            strToBeInserted += vbCrLf + "return false  ;" + vbCrLf + "}"
                            strToBeInserted += vbCrLf + "else if(strExistingFormula.substring(strExistingFormula.length-1,strExistingFormula.length) == ""+"" || strExistingFormula.substring(strExistingFormula.length-1,strExistingFormula.length) == ""-"")"
                            strToBeInserted += vbCrLf + "return true;	"
                            strToBeInserted += vbCrLf + "else" + vbCrLf + "{" + vbCrLf + "alert('" + objAppResource.GetResourceString("RFI_OPERAND") + "')" + vbCrLf + "return false;" + vbCrLf + "}" + vbCrLf + "}" + vbCrLf + "else" + vbCrLf + "{"
                            strToBeInserted += vbCrLf + "if(strExistingFormula == """")"
                            strToBeInserted += vbCrLf + "return  false;"
                            strToBeInserted += vbCrLf + "else if(strExistingFormula.substring(strExistingFormula.length-1,strExistingFormula.length)== ""]"")"
                            strToBeInserted += vbCrLf + "return true;"
                            strToBeInserted += vbCrLf + "else" + vbCrLf + "{"
                            strToBeInserted += vbCrLf + "return false;" + vbCrLf + "}" + vbCrLf + "}" + vbCrLf + "}"

                            'End Validate
                            strToBeInserted += "function Append_OnClick()" + vbCrLf + "{" + vbCrLf + " var strFunction, strAttribute;" + vbCrLf
                            strToBeInserted += vbCrLf + "strAttribute = objfrm.NonDatabase1.value;"
                            strToBeInserted += vbCrLf + "if(trimString(strAttribute)  != """")" + vbCrLf + "{"
                            strToBeInserted += vbCrLf + "if(ValidateFormula(""OPERAND"", strAttribute)==true)"
                            strToBeInserted += vbCrLf + "{"

                            strToBeInserted += vbCrLf + "objfrm.Formula.value= objfrm.Formula.value + trimString(strAttribute);"
                            strToBeInserted += vbCrLf + "}"
                            strToBeInserted += vbCrLf + "}"
                            strToBeInserted += vbCrLf + "else" + vbCrLf + "alert('" + objAppResource.GetResourceString("RFI_ATTRIBUTE") + "');"
                            strToBeInserted += vbCrLf + " }"

                            strToBeInserted += vbCrLf + "function Clear_OnClick()"
                            strToBeInserted += vbCrLf + "{"
                            strToBeInserted += vbCrLf + "objfrm.Formula.value = """";" + vbCrLf + "}"
                            strToBeInserted += vbCrLf + "function Operator_OnClick(strValue)" + vbCrLf + "{"
                            strToBeInserted += vbCrLf + "var strResult;"
                            strToBeInserted += vbCrLf + "if(ValidateFormula(""OPERATOR"" ,strValue)==true)"
                            strToBeInserted += vbCrLf + "objfrm.Formula.value = objfrm.Formula.value + "" "" + strValue;	"
                            strToBeInserted += vbCrLf + "else"
                            strToBeInserted += vbCrLf + "alert('" + objAppResource.GetResourceString("RFI_OPERAND") + "');" + vbCrLf + "}"
                            PageUIPreRender = strToBeInserted
                            strActionCode = ReturnCodes.ON_LOAD.ToString

                            'added by SachinR   On 4 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLE_CODE_DEFINITION
                            'here client side functions are plotted to append the field and seperator
                            'to create code 
                            Dim objAppResource As WebPages.Template.WhizTemplate
                            objAppResource = New WebPages.Template.WhizTemplate
                            objAppResource.InitializeResources("AppResources.EventHandlers", "AppResources")
                            Dim strClientSide As String

                            strClientSide = "function Append_OnClick(){"
                            strClientSide += vbCrLf + "	var objField,objCode,objCompanyName;"
                            strClientSide += vbCrLf + "	var strField,strCode;"
                            strClientSide += vbCrLf + "	objField=GetObjectReference('frmCommonPage','NonDatabase1');"
                            strClientSide += vbCrLf + "	if(disallowBlank(objField,'Please select \'Field Name\' to append.',true)==true)"
                            strClientSide += vbCrLf + "	{	return; }"
                            strClientSide += vbCrLf + "	strField=new String(objField.options[objField.selectedIndex].text);"
                            'Modified By VidyaJ - SP4
                            'Field should be in the format <FieldName>
                            strClientSide += vbCrLf + " strField='<' + strField + '>';"
                            strClientSide += vbCrLf + "	objCode=GetObjectReference('frmCommonPage','CodeTemplate');"
                            strClientSide += vbCrLf + "	strCode=new String(objCode.value);"
                            strClientSide += vbCrLf + "	if(strCode!=''){"
                            strClientSide += vbCrLf + "if(strCode.indexOf(strField,0)>=0)"
                            strClientSide += vbCrLf + "{	alert('Field Name - \''+ strField +'\' is already selected for the code.');"
                            strClientSide += vbCrLf + "return; }"
                            strClientSide += vbCrLf + "}"
                            strClientSide += vbCrLf + "else {"
                            strClientSide += vbCrLf + "objCompanyName=GetObjectReference('frmCommonPage','NonDatabase3');"
                            strClientSide += vbCrLf + "objCode.value = objCompanyName.value; }"
                            strClientSide += vbCrLf + " objCode.value = objCode.value + strField;"
                            strClientSide += vbCrLf + "}"

                            strClientSide += vbCrLf + vbCrLf + "function AppendWithSeperator(){"
                            strClientSide += vbCrLf + "var objField,objSeperator,objCode;"
                            strClientSide += vbCrLf + "var strField,strSeperator,strCode;"
                            strClientSide += vbCrLf + "objField=GetObjectReference('frmCommonPage','NonDatabase1');"
                            'Modified  by PrachiK on 15  Mar 2005 FOR IssueID 14974
                            'Purpose:Improper Messages For Define Code Template Page in the Deliverables Types under the Process Tab

                            strClientSide += vbCrLf + "if(disallowBlank(objField,'Please select \'Field Name\' to append.',true)==true)"

                            strClientSide += vbCrLf + "{	return; }"
                            strClientSide += vbCrLf + "strField=new String(objField.options[objField.selectedIndex].text);"

                            'Modified By VidyaJ - SP4
                            'Field should be in the format <FieldName>
                            strClientSide += vbCrLf + " strField='<' + strField + '>';"
                            'Modification ended
                            strClientSide += vbCrLf + "objCode=GetObjectReference('frmCommonPage','CodeTemplate');"
                            strClientSide += vbCrLf + "strCode=new String(objCode.value);"
                            strClientSide += vbCrLf + "	if(strCode!=''){"
                            strClientSide += vbCrLf + "if(strCode.indexOf(strField,0)>=0)"
                            strClientSide += vbCrLf + "{	alert('Field Name - \''+ strField +'\' is already selected for the code.');"
                            strClientSide += vbCrLf + "return; }"
                            strClientSide += vbCrLf + "}"
                            strClientSide += vbCrLf + "else {"
                            strClientSide += vbCrLf + "objCompanyName=GetObjectReference('frmCommonPage','NonDatabase3');"
                            strClientSide += vbCrLf + "objCode.value = objCompanyName.value; }"
                            strClientSide += vbCrLf + "objSeperator=GetObjectReference('frmCommonPage','NonDatabase2');"
                            strClientSide += vbCrLf + "if(disallowBlank(objSeperator,'Please select any seperator to append.',true)==true)"
                            strClientSide += vbCrLf + "{	return; }"
                            strClientSide += vbCrLf + "strSeperator=new String(objSeperator.options[objSeperator.selectedIndex].text);"
                            strClientSide += vbCrLf + "objCode.value = objCode.value + strField + strSeperator;"
                            strClientSide += vbCrLf + "}"

                            strClientSide += vbCrLf + vbCrLf + "function Clear_OnClick(){"
                            strClientSide += vbCrLf + "var objCode;"
                            strClientSide += vbCrLf + "objCode=GetObjectReference('frmCommonPage','CodeTemplate');"
                            strClientSide += vbCrLf + "objCode.value='';"
                            strClientSide += vbCrLf + "}"

                            PageUIPreRender = strClientSide
                            strActionCode = ReturnCodes.ON_LOAD.ToString

                            'added by SachinR   On 4 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_SERIES_GENERATION
                            'here client side functions are plotted to append the field and seperator
                            'to create code 
                            Dim objAppResource As WebPages.Template.WhizTemplate
                            objAppResource = New WebPages.Template.WhizTemplate
                            objAppResource.InitializeResources("AppResources.EventHandlers", "AppResources")
                            Dim strClientSide As String
                            'Modified by NikhatM on 23 Feb 2005,issue id 14974,display proper messages for fields and seperators.
                            strClientSide = "function Append_OnClick(){"
                            strClientSide += vbCrLf + "	var objField,objCode,objCompanyName;"
                            strClientSide += vbCrLf + "	var strField,strCode;"
                            strClientSide += vbCrLf + "	objField=GetObjectReference('frmCommonPage','NonDatabase2');"
                            strClientSide += vbCrLf + "	if(disallowBlank(objField,'Please select Field Name to append.',true)==true)"
                            strClientSide += vbCrLf + "	{	return; }"
                            strClientSide += vbCrLf + "	strField=new String(objField.value);"
                            strClientSide += vbCrLf + "	objCode=GetObjectReference('frmCommonPage','InvoiceNumberGenerationFormula');"
                            strClientSide += vbCrLf + "	strCode=new String(objCode.value);"
                            strClientSide += vbCrLf + "	if(strCode!=''){"
                            strClientSide += vbCrLf + "if(strCode.indexOf(strField,0)>=0)"
                            strClientSide += vbCrLf + "{	alert(strField+' Field is already selected for the code.');"
                            'strClientSide += vbCrLf + "{	alert('Field is already selected for the code.');"
                            strClientSide += vbCrLf + "return; }"
                            strClientSide += vbCrLf + "}"
                            strClientSide += vbCrLf + "else {"
                            strClientSide += vbCrLf + "objCompanyName=GetObjectReference('frmCommonPage','NonDatabase1');"
                            strClientSide += vbCrLf + "objCode.value = objCompanyName.value; }"
                            strClientSide += vbCrLf + " objCode.value = objCode.value + strField;"
                            strClientSide += vbCrLf + "}"

                            strClientSide += vbCrLf + vbCrLf + "function AppendWithSeperator(){"
                            strClientSide += vbCrLf + "var objField,objSeperator,objCode;"
                            strClientSide += vbCrLf + "var strField,strSeperator,strCode;"
                            strClientSide += vbCrLf + "objField=GetObjectReference('frmCommonPage','NonDatabase2');"
                            'code commented and added by Harshada D on 10 th May 2005 for JUBILANT ISSUE ID : 19222
                            ' strClientSide += vbCrLf + "if(disallowBlank(objField,'Please select 'Field Name' to append.',true)==true)"
                            strClientSide += vbCrLf + "if(disallowBlank(objField,'Please select \'Field Name\' to append.',true)==true)"
                            ' End of Addition by Harshada D 
                            strClientSide += vbCrLf + "{	return; }"
                            strClientSide += vbCrLf + "strField=new String(objField.value);"
                            strClientSide += vbCrLf + "objCode=GetObjectReference('frmCommonPage','InvoiceNumberGenerationFormula');"
                            strClientSide += vbCrLf + "strCode=new String(objCode.value);"
                            strClientSide += vbCrLf + "	if(strCode!=''){"
                            strClientSide += vbCrLf + "if(strCode.indexOf(strField,0)>=0)"
                            strClientSide += vbCrLf + "{	alert('Field Name -'+strField+'is already selected for the code.');"

                            'strClientSide += vbCrLf + "{	alert('Field is already selected for the code.');"
                            strClientSide += vbCrLf + "return; }"
                            strClientSide += vbCrLf + "}"
                            strClientSide += vbCrLf + "else {"
                            strClientSide += vbCrLf + "objCompanyName=GetObjectReference('frmCommonPage','NonDatabase1');"
                            strClientSide += vbCrLf + "objCode.value = objCompanyName.value; }"
                            strClientSide += vbCrLf + "objSeperator=GetObjectReference('frmCommonPage','NonDatabase3');"
                            strClientSide += vbCrLf + "if(disallowBlank(objSeperator,'Please select any seperator to append.',true)==true)"
                            strClientSide += vbCrLf + "{	return; }"
                            strClientSide += vbCrLf + "strSeperator=new String(objSeperator.options[objSeperator.selectedIndex].text);"
                            strClientSide += vbCrLf + "objCode.value = objCode.value + strField + strSeperator;"
                            strClientSide += vbCrLf + "}"

                            strClientSide += vbCrLf + vbCrLf + "function Clear_OnClick(){"
                            strClientSide += vbCrLf + "var objCode;"
                            strClientSide += vbCrLf + "objCode=GetObjectReference('frmCommonPage','InvoiceNumberGenerationFormula');"
                            strClientSide += vbCrLf + "objCode.value='';"
                            strClientSide += vbCrLf + "}"

                            PageUIPreRender = strClientSide
                            strActionCode = ReturnCodes.ON_LOAD.ToString

                            'added by SachinR   On 17 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_ISSUE_CODEGENERATION
                            'here client side functions are plotted to append the field and seperator
                            'to create code 
                            Dim objAppResource As WebPages.Template.WhizTemplate
                            objAppResource = New WebPages.Template.WhizTemplate
                            objAppResource.InitializeResources("AppResources.EventHandlers", "AppResources")
                            Dim strClientSide As String

                            strClientSide = "function Append_OnClick(){"
                            strClientSide += vbCrLf + "	var objField,objCode,objCompanyName;"
                            strClientSide += vbCrLf + "	var strField,strCode;"
                            strClientSide += vbCrLf + "	objField=GetObjectReference('frmCommonPage','NonDatabase1');"
                            strClientSide += vbCrLf + "	if(disallowBlank(objField,'Please select field name to append.',true)==true)"
                            strClientSide += vbCrLf + "	{	return; }"
                            strClientSide += vbCrLf + "	strField=new String(objField.options[objField.selectedIndex].text);"
                            strClientSide += vbCrLf + " strField='<' + strField + '>';"
                            strClientSide += vbCrLf + "	objCode=GetObjectReference('frmCommonPage','CodeTemplate');"
                            strClientSide += vbCrLf + "	strCode=new String(objCode.value);"
                            strClientSide += vbCrLf + "	if(strCode!=''){"
                            strClientSide += vbCrLf + "if(strCode.indexOf(strField,0)>=0)"
                            strClientSide += vbCrLf + "{	alert(strField+' Field is already selected for the code.');"
                            'strClientSide += vbCrLf + "{	alert('Field is already selected for the code.');"
                            strClientSide += vbCrLf + "return; }"
                            strClientSide += vbCrLf + "}"
                            strClientSide += vbCrLf + "else {"
                            strClientSide += vbCrLf + "objCompanyName=GetObjectReference('frmCommonPage','NonDatabase3');"
                            strClientSide += vbCrLf + "objCode.value = objCompanyName.value; }"
                            strClientSide += vbCrLf + " objCode.value = objCode.value + strField;"
                            strClientSide += vbCrLf + "}"
                            strClientSide += vbCrLf + vbCrLf + "function AppendWithSeperator(){"
                            strClientSide += vbCrLf + "var objField,objSeperator,objCode;"
                            strClientSide += vbCrLf + "var strField,strSeperator,strCode;"
                            strClientSide += vbCrLf + "objField=GetObjectReference('frmCommonPage','NonDatabase1');"
                            'strClientSide += vbCrLf + "if(disallowBlank(objField,'Please select any field to append.',true)==true)"
                            'Modified By NitinVS on 12 Apr 2005 to Remove Javasxript Errot for Single Quoate ' Replace With \'
                            strClientSide += vbCrLf + "if(disallowBlank(objField,'Please select \'Field Name\' to append.',true)==true)"
                            ' End Modification By NitinVS on 12 Apr 2005 
                            strClientSide += vbCrLf + "{	return; }"
                            strClientSide += vbCrLf + "strField=new String(objField.options[objField.selectedIndex].text);"


                            strClientSide += vbCrLf + " strField='<' + strField + '>';"

                            strClientSide += vbCrLf + "objCode=GetObjectReference('frmCommonPage','CodeTemplate');"
                            strClientSide += vbCrLf + "strCode=new String(objCode.value);"
                            strClientSide += vbCrLf + "	if(strCode!=''){"
                            strClientSide += vbCrLf + "if(strCode.indexOf(strField,0)>=0)"
                            ' Modified By NitinVS on 12 Apr 2005 for Removing Javascript Error

                            strClientSide += vbCrLf + "{	alert('Field Name -'+ strField + '  is already selected for the code.');"
                            ' End Modification By NitinVS on 12 Apr 2005 
                            'strClientSide += vbCrLf + "{	alert('Field is already selected for the code.');"
                            strClientSide += vbCrLf + "return; }"
                            strClientSide += vbCrLf + "}"
                            strClientSide += vbCrLf + "else {"
                            strClientSide += vbCrLf + "objCompanyName=GetObjectReference('frmCommonPage','NonDatabase3');"
                            strClientSide += vbCrLf + "objCode.value = objCompanyName.value; }"
                            strClientSide += vbCrLf + "objSeperator=GetObjectReference('frmCommonPage','NonDatabase2');"
                            strClientSide += vbCrLf + "if(disallowBlank(objSeperator,'Please select any seperator to append.',true)==true)"
                            strClientSide += vbCrLf + "{	return; }"
                            strClientSide += vbCrLf + "strSeperator=new String(objSeperator.options[objSeperator.selectedIndex].text);"
                            strClientSide += vbCrLf + "objCode.value = objCode.value + strField + strSeperator;"
                            strClientSide += vbCrLf + "}"

                            strClientSide += vbCrLf + vbCrLf + "function Clear_OnClick(){"
                            strClientSide += vbCrLf + "var objCode;"
                            strClientSide += vbCrLf + "objCode=GetObjectReference('frmCommonPage','CodeTemplate');"
                            strClientSide += vbCrLf + "objCode.value='';"
                            strClientSide += vbCrLf + "}"
                            'Modification ends
                            PageUIPreRender = strClientSide
                            strActionCode = ReturnCodes.ON_LOAD.ToString

                            'added by SachinR   on 26 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_SOFTEX_FORM_GENERATION
                            If Not HttpContext.Current.Session("SoftexCustomerID") Is Nothing Then
                                HttpContext.Current.Session.Remove("SoftexCustomerID")
                            End If
                            'addition end

                            'Added by ShamkantD on 22 Sep 2004 - added for Project Information page
                        Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING
                            Dim strRevisionFieldsList As String = ","
                            Dim drRevisionFields As IDataReader
                            Dim strQuery As String = ""
                            Dim strOperation As String = ""
                            Dim blnProjectForApprovalFlag As Boolean = False
                            Dim strProjectBaselineStatus As String = ""
                            'Get the status of 'Project creation workflow required' flag
                            Dim blnIsProjectCreationWorkflowReqd As Boolean = False

                            Dim strSQL As String
                            Dim intResult As Integer
                            Dim strProjectName As String

                            'strsql = "If Exists(Select 1 from tbl_PM_ProjectInfoRoleAccess where ProjectID=" & WhizGlobal.ProjectID & " and RoleID= " & WhizGlobal.RoleID & ")Select 1 Else Select 0"

                            'Added by MrugajaB on 20th Dec 2005 for WhizibleSEM SP5 -Restricted Project Access Feature
                            'Purpose: When restricted Project access is set for a role, then restricted access was not getting applied on project information page
                            'it was working only when project was selected through project listing page
                            strSQL = "If Exists(Select 1 from tbl_PM_ProjectInfoRoleAccess where ProjectID=" & CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer) & " and RoleID= " & WhizGlobal.RoleID & ")Select 1 Else Select 0"

                            intResult = CInt(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                            If intResult = 1 Then
                                'Code added by vidyaJ - Security issue - 6197
                                Dim strtoken As String
                                strtoken = CommonFunctions.Security.Token.GetToken(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), String) + CType(HttpContext.Current.Session("intUserID"), String) + "0" + "3086")
                                PageUIPreRender = "../General/CommonPage.aspx?PKToken=" & strtoken & "&FromWhere=PM&ProjectID_PK=" & CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer) & "&MasterTagID=3086&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1"
                                'PageUIPreRender = "../General/CommonPage.aspx?FromWhere=PM&MasterTagID=3086&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1"
                                strActionCode = ReturnCodes.REDIRECT.ToString
                            Else
                                'End Addition

                                blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
                                HttpContext.Current.Session("blnIsProjectCreationWorkflowReqd") = blnIsProjectCreationWorkflowReqd

                                If blnIsProjectCreationWorkflowReqd = True Then
                                    'Get the list of Revision Fields and store it in a session veriable
                                    strQuery = "SELECT RevisionFieldName FROM tbl_PM_RevisionFields WHERE ProjectTypeID = " & _
                                        "(SELECT ProjectTypeID FROM tbl_PM_Project WHERE ProjectID = " & _
                                        CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString & ")"

                                    drRevisionFields = CommonFunction.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    While drRevisionFields.Read
                                        strRevisionFieldsList &= CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drRevisionFields("RevisionFieldName"), ""), ""), String).ToUpper & ","
                                    End While

                                    CommonFunction.Data.DisposeDataReader(drRevisionFields)
                                    HttpContext.Current.Session("strRevisionFieldsList") = strRevisionFieldsList
                                    'End of addition - ShamkantD on 22 Sep 2004
                                End If

                                'Added by ShamkantD on 23 Sep 2004
                                Dim blnIsApprover As Boolean = False
                                'Get whether or not the logged in user is approver
                                'Integrated by SandipL SP8 to SP9

                                'Added By JyotiG (08-Jan-2007)
                                'Purpose :Customer cannot approve Project.so while checking he is approver or  not check he is employee / Customer
                                'Checking of Employee/Customer is added By JyotiG
                                If HttpContext.Current.Session("LoginType").ToString = "E" Then
                                    strQuery = "usp_Sel_tbl_PM_Role_IsApprover " & _
                                                                        CommonFunction.General.CheckIsNothing(WhizGlobal.UserID, "0").ToString() & "," & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString()
                                    blnIsApprover = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
                                    HttpContext.Current.Session("blnIsApprover") = blnIsApprover
                                End If
                                'End Integration by SandipL SP8 to SP9
                                'End of addition - ShamkantD on 23 Sep 2004

                                'Added by ShamkantD on 4 Oct 2004
                                'Integrated by MonikaI for Whizible SP 7.2 Issue ID 4518
                                'Commented & Added By AmitJ For Dss IssueId 2655
                                ''Page crash if username includes "'" e.g. Username = Dawood's

                                ' strQuery = "EXEC usp_Sel_PM_IsProjectForApproval " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString() & ",'" & CommonFunction.General.CheckIsNothing(WhizGlobal.UserName, "").ToString() & "'"
                                strQuery = "EXEC usp_Sel_PM_IsProjectForApproval " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString() & ",'" & CommonFunction.General.CheckIsNothing(Replace(WhizGlobal.UserName, "'", "''"), "").ToString() & "'"
                                'End Of Addition By Amit J
                                'End of integration
                                blnProjectForApprovalFlag = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
                                HttpContext.Current.Session("blnProjectForApprovalFlag") = blnProjectForApprovalFlag
                                'End of addition - ShamkantD on 4 Oct 2004

                                'Added by ShamkantD on 11 Oct 2004
                                strQuery = "EXEC usp_Sel_tbl_PM_ProjectRevision_BaselineStatus " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString()
                                strProjectBaselineStatus = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString().Trim()
                                HttpContext.Current.Session("strProjectBaselineStatus") = strProjectBaselineStatus
                                'End of addition - ShamkantD on 11 Oct 2004

                                'Added by ShamkantD on Friday, September 24, 2004
                                strOperation = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), "").ToString().ToUpper()
                                'Action for "Send for Approval" - Set baseline status to 'S'
                                If strOperation = "SENDFORAPPROVAL" Then
                                    'Added by ShamkantD on 29 Sep 2004
                                    'Send email to approvers
                                    Dim drEmailMessage As IDataReader
                                    Dim drApprovers As IDataReader
                                    Dim blnSendEmail As Boolean = False, blnShowPopup As Boolean = False
                                    Dim intApproverID As Integer = 0
                                    Dim strFromEmailID As String = "", strToMailID As String = "", strCCToMailID As String = ""
                                    Dim strToEmailID As String = "", strCCToEmailID As String = ""
                                    Dim strEmailMessage As String = "", strSubject As String = "", strMessage As String = ""
                                    Dim intBusinessGroupID As Integer = 0, intLocationID As Integer = 0
                                    Dim drProjectInformation As IDataReader

                                    'Change Baseline status to "S" - Sent for Approval
                                    strQuery = "EXEC usp_Upd_tbl_PM_ProjectRevision_BaselineStatus " & _
                                        CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString() & _
                                        ", 'S'"
                                    CommonFunction.Data.InsertOrUpdateData(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    'Update the field SentForApprovalBy field value with the logged in user's name
                                    strQuery = "EXEC usp_Upd_tbl_PM_ProjectRevision_SentForApprovalBy " & _
                                        CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString() & ",'" & _
                                        CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(WhizGlobal.UserName, "").ToString()) & "'"
                                    CommonFunction.Data.InsertOrUpdateData(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    'Get Business Group ID and Location ID
                                    drProjectInformation = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Project " & WhizGlobal.ProjectID.ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If drProjectInformation.Read Then
                                        intBusinessGroupID = CType(CommonFunction.Data.CheckIsDBNull(drProjectInformation("BusinessGroupID"), "0"), Integer)
                                        intLocationID = CType(CommonFunction.Data.CheckIsDBNull(drProjectInformation("LocationID"), "0"), Integer)
                                    End If
                                    CommonFunction.Data.DisposeDataReader(drProjectInformation)

                                    'Get the list of approvers
                                    'Commented by DipaliS 27 Oct 2004
                                    'Purpose:   Issue 13593
                                    'strQuery = "usp_Sel_tbl_PM_Employee_Approvers " & intBusinessGroupID.ToString() & "," & intLocationID.ToString()
                                    'drApprovers = CommonFunction.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    drEmailMessage = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmailMessages 440", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If drEmailMessage.Read Then
                                        blnSendEmail = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("SendMail"), "0"), Boolean)
                                        blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("ShowPopup"), "0"), Boolean)
                                    End If
                                    CommonFunction.Data.DisposeDataReader(drEmailMessage)
                                    If blnSendEmail Then
                                        If blnShowPopup Then
                                            'Commented by DipaliS 27 Oct 2004
                                            'Purpose:   Issue 13593
                                            'While drApprovers.Read
                                            'intApproverID = CType(CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drApprovers("EmployeeID"), "0"), "0"), Integer)
                                            CommonFunction.General.WriteHTML("<script language=javascript>")
                                            'Commented by DipaliS 27 Oct 2004
                                            'Purpose:   Issue 13593
                                            'CommonFunction.General.WriteHTML("window.open (""../General/SendEmail.aspx?MessageID=440&ApproverID=" & intApproverID.ToString() & "&ProjectID=" & CType(CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0"), Integer) & """, ""_blank"", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                                            'Added by DipaliS 27 Oct 2004
                                            'Purpose:   Issue 13593
                                            CommonFunction.General.WriteHTML("window.open (""../General/SendEmail.aspx?MessageID=440&BusinessGroupID=" & intBusinessGroupID.ToString() & "&LocationID=" & intLocationID.ToString() & "&ProjectID=" & CType(CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0"), Integer) & """, ""_blank"", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                                            'End addition
                                            CommonFunction.General.WriteHTML("</script>")
                                            'Commented by DipaliS 27 Oct 2004
                                            'Purpose:   Issue 13593
                                            'End While
                                        Else
                                            'Commented by DipaliS 27 Oct 2004
                                            'Purpose:   Issue 13593
                                            'While drApprovers.Read
                                            'intApproverID = CType(CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drApprovers("ApproverID"), "0"), "0"), Integer)
                                            'Silent mail
                                            CommonFunction.EmailMessages.PMMessages.GetEmailMessage_440(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0"), Integer), intBusinessGroupID.ToString, intLocationID.ToString)
                                            CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                                            'Commented by DipaliS 27 Oct 2004
                                            'Purpose:   Issue 13593
                                            'End While
                                        End If
                                    End If

                                    CommonFunction.Data.DisposeDataReader(drApprovers)
                                    CommonFunctions.Data.DisposeDataReader(drEmailMessage)
                                    'End of addition - ShamkantD on 29 Sep 2004
                                End If

                                If strOperation = "REVISION" Then
                                    strQuery = "EXEC usp_Ins_tbl_PM_ProjectRevision_Revision " & _
                                        CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString()
                                    CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                End If
                                'End of addition - ShamkantD on Friday, September 24, 2004
                                ' Added by ShraddhaM on 4,July for Whiziblesem8 
                                ' Purpose : To plot conditional back function 
                                Dim strFrom As String
                                strFrom = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("From"), "")
                                If strFrom Is Nothing OrElse strFrom = "" Then
                                    strFrom = HttpContext.Current.Request.Form("hidFrom")
                                End If
                                CommonFunction.General.WriteHTML("<input type=hidden name='hidFrom' id='hidFrom' value='" + strFrom + "'>")

                                ' End of addition by ShraddhaM on 4,July for Whiziblesem8 
                            End If
                        Case CommonFunction.Constants.APP_TAG_TAB_BASELINE_REVISION_REASON
                            'Start
                            Dim strTitle As String
                            Dim strMode As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "").ToString().ToUpper().Trim()
                            strMode = Left(strMode, 1)
                            If strMode = "S" Then
                                strTitle = "document.title='Sender Comments';"
                                PageUIPreRender = strTitle
                            ElseIf strMode = "A" Or strMode = "R" Then
                                strTitle = "document.title='Revision Reason';"
                                PageUIPreRender = strTitle
                            End If
                            strActionCode = ReturnCodes.ON_LOAD.ToString
                            'End

                            'Added by ShamkantD on Friday, September 24, 2004 - added for Basliline comments
                        Case CommonFunction.Constants.APP_TAG_TAB_BASELINE_COMMENTS
                            Dim strFormAction As String
                            Dim strOperation As String = ""
                            Dim intRevisionReasonID As Integer = 0
                            Dim strTitle As String

                            strOperation = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), ""), String).Trim()
                            strFormAction = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FormAction"), ""), String).Trim()
                            'Modified By JyotiG
                            'Date :23-Aug-2006
                            'Start
                            'Issue ID : 5687
                            If strFormAction = "S" Then
                                strTitle = "document.title='Sender Comments';"
                                PageUIPreRender = strTitle
                            ElseIf strFormAction = "A" Or strFormAction = "R" Then
                                strTitle = "document.title='Approver Comments';"
                                PageUIPreRender = strTitle
                            End If
                            strActionCode = ReturnCodes.ON_LOAD.ToString
                            'End

                            If strOperation.ToUpper() = "SAVE" Then
                                If strFormAction = "A" Then
                                    Dim strSQLQuery As String = ""
                                    'Modified By JyotiG
                                    'Issue Id : 5760
                                    'Date : 07-Sep-2006
                                    'Start

                                    'strSQLQuery = "EXEC usp_Ins_tbl_PM_Project_BaselineRevisionReason " & _
                                    '   "'" & CType(HttpContext.Current.Session("intProjectID"), String) & "'," & _
                                    '   "'" & Replace(Replace(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ReasonForRejection"), "").ToString(), "'", "''"), """", """""") & "'," & _
                                    '   "'" & CommonFunction.General.CheckIsNothing(WhizGlobal.UserName, "").ToString() & "','A' "
                                    strSQLQuery = "EXEC usp_Ins_tbl_PM_Project_BaselineRevisionReason " & _
                                                    "'" & CType(HttpContext.Current.Session("intProjectID"), String) & "'," & _
                                                    "'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ReasonForRejection"), "").ToString()) & "'," & _
                                                    "'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(WhizGlobal.UserName, "").ToString()) & "','A' "
                                    'End
                                    intRevisionReasonID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)
                                End If

                                If strFormAction = "R" Then
                                    Dim strSQLQuery As String = ""
                                    'Modified By JyotiG
                                    'Issue Id : 5760
                                    'Date : 07-Sep-2006
                                    'Start

                                    'strSQLQuery = "EXEC usp_Ins_tbl_PM_ProjectBaselineRejectionReason " & _
                                    '   "'" & CType(HttpContext.Current.Session("intProjectID"), String) & "'," & _
                                    '   "'" & Replace(Replace(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ReasonForRejection"), "").ToString(), "'", "''"), """", """""") & "'," & _
                                    '   "'" & CommonFunction.General.CheckIsNothing(WhizGlobal.UserName, "").ToString() & "'"
                                    strSQLQuery = "EXEC usp_Ins_tbl_PM_ProjectBaselineRejectionReason " & _
                                       "'" & CType(HttpContext.Current.Session("intProjectID"), String) & "'," & _
                                       "'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ReasonForRejection"), "").ToString()) & "'," & _
                                       "'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(WhizGlobal.UserName, "").ToString()) & "'"
                                    'End
                                    intRevisionReasonID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)
                                End If
                                'Done By JyotiG
                                'Start
                                'Issue ID : 5687
                                If strFormAction = "S" Then
                                    Dim strSQLQuery As String = ""
                                    'Modified By JyotiG
                                    'Issue Id : 5760
                                    'Date : 07-Sep-2006
                                    'Start

                                    'strSQLQuery = "EXEC usp_Ins_tbl_PM_Project_BaselineRevisionReason " & _
                                    '   "'" & CType(HttpContext.Current.Session("intProjectID"), String) & "'," & _
                                    '   "'" & Replace(Replace(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ReasonForRejection"), "").ToString(), "'", "''"), """", """""") & "'," & _
                                    '   "'" & CommonFunction.General.CheckIsNothing(WhizGlobal.UserName, "").ToString() & "','S'"

                                    strSQLQuery = "EXEC usp_Ins_tbl_PM_Project_BaselineRevisionReason " & _
                                      "'" & CType(HttpContext.Current.Session("intProjectID"), String) & "'," & _
                                      "'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ReasonForRejection"), "").ToString()) & "'," & _
                                      "'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(WhizGlobal.UserName, "").ToString()) & "','S'"
                                    'End
                                    intRevisionReasonID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)

                                End If
                                'eND
                                'Added by ShamkantD on 30 Sep 2004
                                'Send email to the project owner
                                If intRevisionReasonID > 0 And (strFormAction = "A" Or strFormAction = "R") Then
                                    Dim strSQLQuery As String = ""
                                    Dim drEmailMessage As IDataReader
                                    Dim blnSendEmail As Boolean = False, blnShowPopup As Boolean = False
                                    Dim intRecipientID As Integer = 0
                                    Dim strFromEmailID As String = "", strToMailID As String = "", strCCToMailID As String = ""
                                    Dim strToEmailID As String = "", strCCToEmailID As String = ""
                                    Dim strEmailMessage As String = "", strSubject As String = "", strMessage As String = ""
                                    Dim intBusinessGroupID As Integer = 0, intLocationID As Integer = 0
                                    Dim strProjectOwnerName As String = ""
                                    Dim strApprovalStatus As String = strFormAction.ToUpper().Trim()

                                    'Get the username of the person who created the project
                                    strSQLQuery = "SELECT SentForApprovalBy FROM tbl_PM_ProjectRevision WHERE ProjectID = " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString() & " AND RevisionNumber = (SELECT MAX(RevisionNumber) AS RevisionNumber FROM tbl_PM_ProjectRevision WHERE ProjectID = " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString() & ")"
                                    strProjectOwnerName = CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString())
                                    'strProjectOwnerName = CommonFunction.General.BuildQueryString(strProjectOwnerName)
                                    If strProjectOwnerName.Trim() <> "" Then
                                        'Get the ID of Recipients
                                        strSQLQuery = "EXEC usp_Sel_GetEmployeeID '" & strProjectOwnerName & "'"
                                        intRecipientID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)
                                    End If

                                    drEmailMessage = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmailMessages 441", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If drEmailMessage.Read Then
                                        blnSendEmail = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("SendMail"), "0"), Boolean)
                                        blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("ShowPopup"), "0"), Boolean)
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(drEmailMessage)

                                    If blnSendEmail Then
                                        If blnShowPopup Then
                                            If intRecipientID > 0 Then
                                                CommonFunction.General.WriteHTML("<script language=javascript>")
                                                CommonFunction.General.WriteHTML("window.open (""../General/SendEmail.aspx?MessageID=441&RecipientID=" & intRecipientID.ToString() & "&ProjectID=" & CType(CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0"), Integer) & "&ApprovalStatus=" & strApprovalStatus & "&RevisionReasonID=" & intRevisionReasonID.ToString() & """, ""_blank"", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                                                CommonFunction.General.WriteHTML("</script>")
                                            End If
                                        Else
                                            If intRecipientID > 0 Then
                                                'Silent mail
                                                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_441(intRecipientID.ToString(), strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0"), Integer), strApprovalStatus, intRevisionReasonID)
                                                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                                            End If
                                        End If
                                    End If

                                    Dim strScript2 As String
                                    strScript2 = "<script language = javascript>"
                                    strScript2 += "window.opener.location.href=window.opener.location.href;"
                                    strScript2 += "window.close();"
                                    strScript2 += "</script>"
                                    CommonFunction.General.WriteHTML(strScript2)
                                    'End If
                                    'End of addition - ShamkantD on 30 Sep 2004
                                    'Modified By JyotiG
                                    'Date :23-Aug-2006
                                    'Issue ID : 5687
                                    'Start
                                ElseIf intRevisionReasonID > 0 And strFormAction = "S" Then

                                    Dim drEmailMessage As IDataReader
                                    Dim drApprovers As IDataReader
                                    Dim blnSendEmail As Boolean = False, blnShowPopup As Boolean = False
                                    Dim intApproverID As Integer = 0
                                    Dim strFromEmailID As String = "", strToMailID As String = "", strCCToMailID As String = ""
                                    Dim strToEmailID As String = "", strCCToEmailID As String = ""
                                    Dim strEmailMessage As String = "", strSubject As String = "", strMessage As String = ""
                                    Dim intBusinessGroupID As Integer = 0, intLocationID As Integer = 0
                                    Dim drProjectInformation As IDataReader
                                    Dim strSQL1 As String


                                    'Change Baseline status to "S" - Sent for Approval
                                    strSQL1 = "EXEC usp_Upd_tbl_PM_ProjectRevision_BaselineStatus " & _
                                        CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString() & _
                                        ", 'S'"
                                    CommonFunction.Data.InsertOrUpdateData(strSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    'Update the field SentForApprovalBy field value with the logged in user's name
                                    strSQL1 = "EXEC usp_Upd_tbl_PM_ProjectRevision_SentForApprovalBy " & _
                                        CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString() & ",'" & _
                                        CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(WhizGlobal.UserName, "").ToString()) & "'"
                                    CommonFunction.Data.InsertOrUpdateData(strSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    'Get Business Group ID and Location ID
                                    drProjectInformation = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Project " & WhizGlobal.ProjectID.ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If drProjectInformation.Read Then
                                        intBusinessGroupID = CType(CommonFunction.Data.CheckIsDBNull(drProjectInformation("BusinessGroupID"), "0"), Integer)
                                        intLocationID = CType(CommonFunction.Data.CheckIsDBNull(drProjectInformation("LocationID"), "0"), Integer)
                                    End If
                                    CommonFunction.Data.DisposeDataReader(drProjectInformation)

                                    'Get the list of approvers
                                    'Commented by DipaliS 27 Oct 2004
                                    'Purpose:   Issue 13593
                                    'strQuery = "usp_Sel_tbl_PM_Employee_Approvers " & intBusinessGroupID.ToString() & "," & intLocationID.ToString()
                                    'drApprovers = CommonFunction.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    drEmailMessage = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmailMessages 440", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If drEmailMessage.Read Then
                                        blnSendEmail = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("SendMail"), "0"), Boolean)
                                        blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("ShowPopup"), "0"), Boolean)
                                    End If
                                    CommonFunction.Data.DisposeDataReader(drEmailMessage)
                                    If blnSendEmail Then
                                        If blnShowPopup Then
                                            'Commented by DipaliS 27 Oct 2004
                                            'Purpose:   Issue 13593
                                            'While drApprovers.Read
                                            'intApproverID = CType(CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drApprovers("EmployeeID"), "0"), "0"), Integer)
                                            CommonFunction.General.WriteHTML("<script language=javascript>")
                                            'Commented by DipaliS 27 Oct 2004
                                            'Purpose:   Issue 13593
                                            'CommonFunction.General.WriteHTML("window.open (""../General/SendEmail.aspx?MessageID=440&ApproverID=" & intApproverID.ToString() & "&ProjectID=" & CType(CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0"), Integer) & """, ""_blank"", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                                            'Added by DipaliS 27 Oct 2004
                                            'Purpose:   Issue 13593
                                            CommonFunction.General.WriteHTML("window.open (""../General/SendEmail.aspx?MessageID=440&BusinessGroupID=" & intBusinessGroupID.ToString() & "&LocationID=" & intLocationID.ToString() & "&ProjectID=" & CType(CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0"), Integer) & """, ""_blank"", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                                            'End addition
                                            CommonFunction.General.WriteHTML("</script>")
                                            'Commented by DipaliS 27 Oct 2004
                                            'Purpose:   Issue 13593
                                            'End While
                                        Else
                                            'Commented by DipaliS 27 Oct 2004
                                            'Purpose:   Issue 13593
                                            'While drApprovers.Read
                                            'intApproverID = CType(CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drApprovers("ApproverID"), "0"), "0"), Integer)
                                            'Silent mail
                                            CommonFunction.EmailMessages.PMMessages.GetEmailMessage_440(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0"), Integer), intBusinessGroupID.ToString, intLocationID.ToString)
                                            CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                                            'Commented by DipaliS 27 Oct 2004
                                            'Purpose:   Issue 13593
                                            'End While
                                        End If
                                        Dim strScript1 As String
                                        strScript1 = "<script language = javascript>"
                                        'strScript1 += "window.opener.location.href=window.opener.location.href;"
                                        'strScript1 += "window.opener.location.href=CommonPage.aspx?Mode=&ProjectID=" & CType(CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0"), Integer) & "&MasterTagID=32&FromWhere=PM&PagingAlphabet=-1&AccessFirstTime=0&ParentTagID=0&PagingNumber=1;"
                                        ''Commented and Added by NitinC on 25 April 2012 for WhizibleSEM 11.0 
                                        ''[Issue Fix : For Old workflow on project information page whn click on action links e.g. send for approval,show 
                                        ''revisions,show project approvers etc page is crashed.]
                                        'strScript1 += "refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?Mode=&ProjectID=" + CType(CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0"), String) + "&MasterTagID=32&FromWhere=PM&PagingAlphabet=-1&AccessFirstTime=0&ParentTagID=0&PagingNumber=1',true);"
                                        strScript1 += "refreshParent('frmCommonPage','ProjectInformation_CommonPage.aspx','../PM/ProjectInformation_CommonPage.aspx?Mode=&ProjectID=" + CType(CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0"), String) + "&MasterTagID=32&FromWhere=PM&PagingAlphabet=-1&AccessFirstTime=0&ParentTagID=0&PagingNumber=1',true);"
                                        ''End of Commented and Added by NitinC on 25 April 2012 for WhizibleSEM 11.0 
                                        strScript1 += "window.close();"
                                        strScript1 += "</script>"
                                        CommonFunction.General.WriteHTML(strScript1)
                                    End If
                                    'End of addition - ShamkantD on Friday, September 24, 2004
                                End If
                            End If
                            'Added by ShamkantD on 13 Oct 2004
                            'End (Done By JyotiG)
                        Case CommonFunction.Constants.APP_TAG_PM_FIXED_BID

                            Dim strScript As String = ""

                            'Get the node label so that it can be printed as title
                            Dim strNodeLabel As String = ""
                            Dim strQuery As String = "usp_Sel_GetContractType_NodeLabel_ForProject " & HttpContext.Current.Session("intProjectID").ToString
                            strNodeLabel = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
                            If strNodeLabel.Trim() <> "" Then
                                strScript = "document.title='" & strNodeLabel & "';"
                                PageUIPreRender = strScript
                            End If

                            'Application standard return code
                            strActionCode = ReturnCodes.ON_LOAD.ToString
                            'End of addition - ShamkantD on 13 Oct 2004
                            '    ' integrated by harshada d on 15 th june 2006 
                            '    'Integrated by PrajaktaR on 12th May 2006 for WhizibleSEM 6.0.1 IssueID 3736
                            '    'added by Harshk on 21/07/2005
                            '    'to remove delete caption from grid header for inherited checkList
                        Case CommonFunction.Constants.APP_TAG_PROJECT_CHECKLIST
                            Dim strProjectCheckListID_PK As String
                            strProjectCheckListID_PK = HttpContext.Current.Request.QueryString("ProjectCheckListID_PK")
                            If strProjectCheckListID_PK <> "" Then
                                HttpContext.Current.Session("ProjectCheckListID_PK") = strProjectCheckListID_PK
                            End If
                            'end Harshk on 21/07/2005
                            'END OF Integration by PrajaktaR on 12th May 2006 for WhizibleSEM 6.0.1 IssueID 3736
                            'end of integration by harshada d 

                        Case CommonFunction.Constants.APP_TAG_RESOURCES
                            Dim strScript As String
                            Dim strSQL As String
                            Dim drGetDefaultApprover As IDataReader
                            Dim drGetEmployeeID As IDataReader
                            Dim strEmployeeID As String
                            'ADDITION by SanaS on 14-OCT-2009
                            Dim intEnableProjectResourceAllocation As Integer
                            Dim intAllowResourceAllocation As Integer

                            If CommonFunction.Application.AllowResourceAllocation Then
                                intAllowResourceAllocation = 1
                            Else
                                intAllowResourceAllocation = 0
                            End If

                            intEnableProjectResourceAllocation = intAllowResourceAllocation
                            If intAllowResourceAllocation = 0 Then
                                intEnableProjectResourceAllocation = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_IsProjectResourceAllocation " + WhizGlobal.ProjectID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                            End If
                            'End ADDITION by SanaS on 14-OCT-2009


                            strScript = "<script language='javascript'>" + vbCrLf
                            'Added By PradeepD to resolve Tavant Issue 17713 Duplicate Resources on Project
                            strScript += "var blnIsSaveClicked =0;" + vbCrLf
                            'End: Added By PradeepD to resolve Tavant Issue 17713 Duplicate Resources on Project
                            strScript += "var objReportingTo;" + vbCrLf
                            strScript += "var PreviousReportingTo;" + vbCrLf

                            strScript += "function Approver_OnClick()" + vbCrLf
                            strScript += "{" + vbCrLf
                            strScript += "var objIsDefaultApprover;" + vbCrLf
                            strScript += "objIsDefaultApprover = GetObjectReference('frmCommonPage','IsDefaultApprover',true);" + vbCrLf
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
                            If CType(HttpContext.Current.Request.QueryString("ProjectEmployeeRoleId_PK"), String) <> "" Then
                                strSQL = "SELECT EmployeeID From tbl_PM_ProjectEmployeeRole Where ProjectEmployeeRoleID = " + CType(HttpContext.Current.Request.QueryString("ProjectEmployeeRoleId_PK"), String)
                                drGetEmployeeID = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                If drGetEmployeeID.Read Then
                                    strEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(drGetEmployeeID("EmployeeID"), "0"), String)
                                End If

                                CommonFunction.Data.DisposeDataReader(drGetEmployeeID)


                                'commented and added by ShraddhaM on 17,Sept 2008
                                'strSQL = "SELECT EmployeeID From tbl_PM_ProjectEmployeeRole WHERE ProjectID = " + CType(HttpContext.Current.Session("intProjectID"), String) + " AND IsDefaultApprover = 1 AND EmployeeID <> " + CType(strEmployeeID, String)
                                strSQL = "SELECT EmployeeID From tbl_PM_ProjectEmployeeRole WHERE ProjectID = " + ProjectID + " AND IsDefaultApprover = 1 AND EmployeeID <> " + CType(strEmployeeID, String)
                            Else
                                'strSQL = "SELECT EmployeeID From tbl_PM_ProjectEmployeeRole WHERE ProjectID = " + CType(HttpContext.Current.Session("intProjectID"), String) + " AND IsDefaultApprover = 1"
                                strSQL = "SELECT EmployeeID From tbl_PM_ProjectEmployeeRole WHERE ProjectID = " + ProjectID + " AND IsDefaultApprover = 1"
                                'End of comment and addition by ShraddhaM on 17,Sept 2008
                            End If
                            drGetDefaultApprover = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))


                            If drGetDefaultApprover.Read Then
                                'strScript += "alert(objIsDefaultApprover[0].checked);" + vbCrLf
                                strScript += "if(objIsDefaultApprover[0].checked)" + vbCrLf
                                'Commented and modified by JyotiG
                                'Start_JG_11112_20-Mar-2007
                                'Issue : Resource Allocation on Project :- 
                                'Already default approver is present on the project. Make another resource a default approver. In the alert message, grammatical mistake is present.
                                'strScript += "alert('This will change the previouly set Default Approver');" + vbCrLf
                                strScript += "alert('This will change the previously set Default Approver');" + vbCrLf
                                'End_JG_11112_20-Mar-2007
                            End If



                            strScript += "}" + vbCrLf

                            strScript += "function Approver_OnChange()" + vbCrLf
                            strScript += "{" + vbCrLf
                            strScript += "var ChangedReportingTo;" + vbCrLf

                            strScript += "ChangedReportingTo = GetObjectReference('frmCommonPage','ReportingTo').value;" + vbCrLf
                            'strScript += "alert(PreviousReportingTo);" + vbCrLf
                            'strScript += "alert(ChangedReportingTo);" + vbCrLf
                            strScript += "if(PreviousReportingTo != ChangedReportingTo)" + vbCrLf
                            strScript += "{" + vbCrLf
                            strScript += "if(PreviousReportingTo != '' && ChangedReportingTo!='')" + vbCrLf
                            strScript += "{" + vbCrLf
                            If CType(HttpContext.Current.Request.QueryString("ProjectEmployeeRoleId_PK"), String) <> "" Then
                                strScript += "alert('Please check that all the previously generated timesheets are verified before changing the approver and saving.');" + vbCrLf
                            End If
                            strScript += "}" + vbCrLf
                            strScript += "}" + vbCrLf
                            strScript += "}" + vbCrLf

                            'Addition done by SuchitraP on 17 Oct 2007
                            'Purpose:Resource Percentage Allocation validation
                            'Dim strMode As String
                            Dim strResourceAllocation As String
                            Dim strProjectEmployeeRole As String
                            Dim strProjectID As String
                            Dim TotalResAllocation As String
                            Dim strEmployee_ID As String
                            strScript += " var whichClick;"
                            strScript += "function GetDataBeforeSave(evtSource)" + vbCrLf
                            strScript += "{" + vbCrLf
                            strScript += "whichClick = evtSource;" + vbCrLf
                            'strScript += "alert('Within getdatabefore save function');" + vbCrLf

                            strResourceAllocation = CType(CommonFunction.Data.GetDataScalar("usp_Sel_ResAllocation_SettingValue", True), String)

                            'strMode = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "")
                            If strResourceAllocation <> "0" Then
                                CommonFunction.General.WriteHTML("<input type=hidden name=hidResAllocationValue id=hidResAllocationValue value=" + strResourceAllocation + " >")

                                If strPrimaryKey = "" Then
                                    If intEnableProjectResourceAllocation = 0 Then
                                        strScript += "var strEmployee,strUrl;" + vbCrLf
                                        strScript += "strEmployee=GetObjectReference('frmCommonPage','EmployeeID').value;" + vbCrLf
                                        strScript += " strUrl = new String();" + vbCrLf
                                        strScript += " " + vbCrLf
                                        strScript += " strUrl = '../General/XMLHttp.aspx?TagID=1019&EmployeeID=' + strEmployee" + vbCrLf
                                        'strScript += "alert(strUrl);" + vbCrLf
                                        'HttpContext.Current.Response.Write("loadXMLDoc(strUrl,null);")
                                        strScript += " if(isIE() == 'IE'){ " + vbCrLf
                                        strScript += "loadXMLDoc(strUrl,null);" + vbCrLf
                                        strScript += " } " + vbCrLf
                                    Else
                                        strScript += "var StartDate=GetObjectReference('frmCommonPage','ExpectedStartDate');" + vbCrLf
                                        strScript += "var EndDate=GetObjectReference('frmCommonPage','ExpectedEndDate');" + vbCrLf
                                        strScript += "var strEmployee=GetObjectReference('frmCommonPage','EmployeeID');" + vbCrLf
                                        strScript += "strURL='../General/XMLHttp.aspx?TagID=1019&Action=ALLOCATIONVALIDATION&ProjectID=" + ProjectID.ToString + "&FromDate='+encodeURIComponent(StartDate.value)+'&ToDate='+encodeURIComponent(EndDate.value)+'&EmployeeID='+strEmployee.value;" + vbCrLf
                                        strScript += " if(isIE() == 'IE'){ " + vbCrLf
                                        strScript += " if(loadAllocXMLDoc(strURL,'')!=true) {" + vbCrLf
                                        strScript += "alert(Msgg); return;}" + vbCrLf
                                        strScript += "else {if(whichClick == 'SAVE'){Save_OnClick();}else{	SaveAdd_OnClick();}}" + vbCrLf
                                        strScript += " } " + vbCrLf
                                    End If



                                Else
                                    strEmployee_ID = HttpContext.Current.Request.Form("EmployeeID")
                                    If strEmployee_ID Is Nothing OrElse strEmployee_ID = "" Then
                                        strProjectEmployeeRole = strPrimaryKey ' HttpContext.Current.Request.QueryString("ProjectEmployeeRoleId_PK")
                                        If strProjectEmployeeRole Is Nothing OrElse strProjectEmployeeRole = "" Then
                                            strProjectEmployeeRole = HttpContext.Current.Request.QueryString("ProjectEmployeeRoleId_PK")
                                        End If
                                        If strProjectEmployeeRole Is Nothing OrElse strProjectEmployeeRole = "" Then
                                            strProjectEmployeeRole = HttpContext.Current.Request.Form("ProjectEmployeeRoleId_PK")
                                        End If
                                        strEmployee_ID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT EmployeeID FROM tbl_PM_ProjectEmployeeRole WHERE ProjectEmployeeRoleID=" + strProjectEmployeeRole, True), "0"), String)
                                    End If
                                    strProjectID = CType(HttpContext.Current.Session("intProjectID"), String)
                                    strSQL = "EXEC usp_Sel_tbl_PM_ProjectEmployeeRole_ResourcePer " + strEmployee_ID + "," + strProjectID
                                    TotalResAllocation = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), "0"), String)
                                    CommonFunction.General.WriteHTML("<input type=hidden name=hidValidateResAllocation id=hidValidateResAllocation value=" + TotalResAllocation + " >")
                                    'Added on 24 Oct 2007 
                                    CommonFunction.General.WriteHTML("<input type=hidden name=hidResourcePerBeforeAlter id=hidResourcePerBeforeAlter value='' >")
                                    'End 
                                End If
                                'strScript += "}" + vbCrLf
                            Else

                                CommonFunction.General.WriteHTML("<input type=hidden name=hidResAllocationValue id=hidResAllocationValue value=" + strResourceAllocation + " >")

                                strScript += "var ResPerEnter=GetObjectReference('frmCommonPage','ResourcePercentage');" + vbCrLf
                                strScript += "var RAValue=ResPerEnter.value;" + vbCrLf
                                strScript += "if(whichClick=='SAVE'){" + vbCrLf
                                strScript += "if(RAValue<0 || RAValue>100){" + vbCrLf
                                strScript += "alert('Resource percentage should be between (0-100)');ResPerEnter.focus();return;}" + vbCrLf
                                strScript += "Save_OnClick();}" + vbCrLf
                                strScript += "else{" + vbCrLf
                                strScript += "if(RAValue<0 || RAValue>100){" + vbCrLf
                                strScript += "alert('Resource percentage should be between (0-100)');ResPerEnter.focus();return;}" + vbCrLf
                                strScript += "SaveAdd_OnClick();}" + vbCrLf
                                If strPrimaryKey <> "" Then
                                    'Added on 24 Oct 2007 
                                    CommonFunction.General.WriteHTML("<input type=hidden name=hidResourcePerBeforeAlter id=hidResourcePerBeforeAlter value='' >")
                                    'End 
                                End If

                            End If

                            strScript += "}" + vbCrLf

                            strScript += "function ValidateEditMode()" + vbCrLf
                            strScript += "{ " + vbCrLf
                            If intEnableProjectResourceAllocation = 0 Then
                                strScript += "var Restemp,Pertemp,Total=0,objProjectEmpRolePK,ResAllocationValue;" + vbCrLf
                                strScript += "objProjectEmpRolePK=GetObjectReference('frmCommonPage','ProjectEmployeeRoleId_PK');" + vbCrLf
                                strScript += "if(objProjectEmpRolePK) {" + vbCrLf
                                strScript += "ResAllocationValue=GetObjectReference('frmCommonPage','hidResAllocationValue').value;" + vbCrLf
                                strScript += "if(ResAllocationValue!=0){" + vbCrLf
                                strScript += "var ResAllocation=GetObjectReference('frmCommonPage','hidValidateResAllocation');" + vbCrLf
                                strScript += "Restemp=parseFloat(ResAllocation.value);" + vbCrLf
                                strScript += "var PerAllocation=GetObjectReference('frmCommonPage','ResourcePercentage');" + vbCrLf
                                strScript += "Pertemp=parseFloat(PerAllocation.value);" + vbCrLf
                                strScript += "Total=Restemp+Pertemp;" + vbCrLf
                                'strscript += "alert('Total'+Total);" + vbCrLf
                                'strscript += "alert(ResAllocationValue);" + vbCrLf
                                strScript += "if(Total>ResAllocationValue)" + vbCrLf
                                strScript += "return true;" + vbCrLf
                                strScript += "return false;" + vbCrLf

                                'strSCript += " alert('Total Percentage Allocation ('+Restemp+') cannot be more  than '+ResAllocationValue);" + vbCrLf
                                'strScript += " PerAllocation.focus();return;}" + vbCrLf
                                'strScript += "else{Save_OnClick()}" + vbCrLf
                                strScript += "}}" + vbCrLf
                            Else
                                strScript += "return true;" + vbCrLf
                            End If
                            strScript += "}" + vbCrLf

                            strScript += "function ValidateAddMode()" + vbCrLf
                            strScript += "{" + vbCrLf
                            strScript += "var strResourcePercentage,ResAllocationValue,fltTotalResourcePercentage,fltTotalResPercentExceptCurrent,fltTotal;" + vbCrLf
                            strScript += "strResourcePercentage = GetObjectReference('frmCommonPage','ResourcePercentage');" + vbCrLf
                            strScript += "ResAllocationValue = GetObjectReference('frmCommonPage','hidResAllocationValue').value;" + vbCrLf
                            strScript += "fltTotalResourcePercentage=parseFloat(strResourcePercentage.value);" + vbCrLf
                            strScript += "fltTotalResPercentExceptCurrent=parseFloat(TotalResPercentExceptCurrent);" + vbCrLf
                            strScript += "fltTotal=fltTotalResourcePercentage+fltTotalResPercentExceptCurrent;" + vbCrLf
                            'strScript += "alert('Total'+fltTotal);" + vbCrLf
                            'strScript += "alert('BaseValue'+ResAllocationValue);" + vbCrLf
                            strScript += "if(fltTotal>ResAllocationValue)" + vbCrLf
                            strScript += "return true;" + vbCrLf
                            strScript += "return false;" + vbCrLf
                            strScript += "}" + vbCrLf

                            'End of Addition by SuchitraP on 17 Oct 2007

                            'ShraddhaM 3,July 2007 to remove Save_Add Link  
                            If HttpContext.Current.Request.QueryString("From") <> "" Then
                                CommonFunctions.General.WriteHTML("<input type = hidden name = 'hidFrom' value = 'RCV'>")
                            ElseIf HttpContext.Current.Request.Form("hidFrom") <> "" Then
                                CommonFunctions.General.WriteHTML("<input type = hidden name = 'hidFrom' value = 'RCV'>")
                            End If
                            'End of 3,July 2007 to remove Save_Add Link  

                            'Added by ShraddhaM on 17,Sept 2008
                            'Purpose : Resource Allocation from advanced searched resources in Whiziblesem8.0
                            Dim PRJID As String
                            Dim Pipe_OR_Team_PK As String

                            PRJID = HttpContext.Current.Request.QueryString("PRJID")
                            If PRJID Is Nothing OrElse PRJID = "" Then
                                PRJID = HttpContext.Current.Request.Form("hidPKValue")
                            End If

                            Pipe_OR_Team_PK = HttpContext.Current.Request.QueryString("Pipe_OR_Team_PK")
                            If Pipe_OR_Team_PK Is Nothing OrElse Pipe_OR_Team_PK = "" Then
                                Pipe_OR_Team_PK = HttpContext.Current.Request.Form("hidPipe_OR_Team_PK")
                            End If

                            CommonFunction.General.WriteHTML("<input type=hidden name='hidPKValue' id='hidPKValue' value='" + PRJID + "'>")
                            CommonFunction.General.WriteHTML("<input type=hidden name='hidPipe_OR_Team_PK' id='hidPipe_OR_Team_PK' value='" + Pipe_OR_Team_PK + "'>")

                            'End of addition by ShraddhaM on 17,Sept 2008

                            strScript += "</script>" + vbCrLf
                            CommonFunction.Data.DisposeDataReader(drGetDefaultApprover)
                            CommonFunction.General.WriteHTML(strScript)



                            'Code Integrated by MrugajaB on 4th May,2005 for WhizibleSEM SP3 Task Progress feature
                            'Added By PradeepD on 04-APR-2005 For Task Progress
                        Case CommonFunction.Constants.APP_TAG_PROJECT_PERCENT_PROGRESS
                            Dim strMsg As String, strSQL As String, strScript As String, intPendingCount As String
                            Dim drPendingTaskProgress As IDataReader
                            Dim drCountPendingTaskProgress As IDataReader
                            Dim drIsTaskProgressApprove As IDataReader
                            Dim IsTaskProgressApprove As String

                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), "").ToString().ToUpper() = "PERCENT_PROGRESS" Then
                                intPendingCount = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PendingCount"), "").ToString()
                                If intPendingCount = "" Then
                                    'Get latest Pending Task Progress first
                                    strSQL = ("EXEC usp_tbl_PM_PendingProjectTaskProgress " & HttpContext.Current.Session("intProjectID").ToString)
                                    drPendingTaskProgress = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    drPendingTaskProgress.Read()
                                    'Get Count of  Pending Task Progress
                                    strSQL = "EXEC usp_Count_tbl_PM_PendingTaskProgress " & HttpContext.Current.Session("intProjectID").ToString
                                    drCountPendingTaskProgress = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    drCountPendingTaskProgress.Read()
                                    intPendingCount = drCountPendingTaskProgress("PendingTaskProgress").ToString

                                    ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                    CommonFunction.Data.DisposeDataReader(drCountPendingTaskProgress)
                                    ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                    ' Display Pending task progress if task Progress is approved.
                                    strSQL = "SELECT Distinct Freezed FROM tbl_PM_TaskProgress"
                                    strSQL += " WHERE FromDate = (Select max(fromdate) from tbl_PM_TaskProgress where projectid='" + HttpContext.Current.Session("intProjectID").ToString + "' )"
                                    strSQL += " and projectid='" + HttpContext.Current.Session("intProjectID").ToString + "'"


                                    drIsTaskProgressApprove = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    If drIsTaskProgressApprove.Read Then
                                        IsTaskProgressApprove = CType(CommonFunctions.Data.CheckIsDBNull(drIsTaskProgressApprove("Freezed"), "True"), String)
                                    Else
                                        IsTaskProgressApprove = "True"
                                    End If

                                    ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                    CommonFunction.Data.DisposeDataReader(drIsTaskProgressApprove)
                                    ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                    If IsTaskProgressApprove <> "True" Then
                                        CommonFunction.General.WriteHTML("<script language=javascript>")
                                        CommonFunction.General.WriteHTML("alert('Please approve previously generated task progress');")
                                        CommonFunction.General.WriteHTML("</script>")
                                        PageUIPreRender = "../General/CommonList.aspx?FromWhere=PM&MasterTagId=5033"
                                        strActionCode = ReturnCodes.REDIRECT.ToString
                                    Else

                                        ' End addtion


                                        'Added By  PradipK on 7th April 2005
                                        ' If Pending Task Count is greater than 1 then Call Link page 
                                        ' that display all pending tasks.
                                        If Val(intPendingCount) > 1 Then
                                            CommonFunction.General.WriteHTML("<script language=javascript>")
                                            CommonFunction.General.WriteHTML("var objfrm = GetFormReference('frmCommonPage');")
                                            CommonFunction.General.WriteHTML("objfrm.action=""CommonList.aspx?&Mode=&MasterTagID=5028&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1""")
                                            CommonFunction.General.WriteHTML("objfrm.submit();")
                                            CommonFunction.General.WriteHTML("</script>")
                                        Else
                                            ' If Pending Task Count is 0 then Display Message.
                                            If Val(intPendingCount) = 0 Then
                                                CommonFunction.General.WriteHTML("<script language=javascript>")
                                                CommonFunction.General.WriteHTML("alert('There are no Pending Task Progress');")
                                                CommonFunction.General.WriteHTML("</script>")
                                                PageUIPreRender = "../General/CommonList.aspx?FromWhere=PM&MasterTagId=5033"
                                                strActionCode = ReturnCodes.REDIRECT.ToString
                                            Else
                                                ' If Pending Task Count is 1 then Display Task Progress Detail Page.
                                                PageUIPreRender = "../PM/PM_TaskProgress.aspx?&FromWhere=PM&FromDate=" + drPendingTaskProgress("FromDate").ToString + "&ToDate=" + drPendingTaskProgress("ToDate").ToString + "&ProjectID=" + drPendingTaskProgress("ProjectID").ToString
                                                strActionCode = ReturnCodes.REDIRECT.ToString
                                            End If
                                        End If
                                        ' End of Addtion by PradipK on 7th April 2005.

                                    End If

                                End If
                            End If
                            ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                            CommonFunction.Data.DisposeDataReader(drPendingTaskProgress)

                            ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                            'End Addition

                            '***** Code added by SandipL on 22 nov 2005 for refreshing parent page through XMlHttp 
                        Case CommonFunction.Constants.APP_TAG_COPY_EXECUTION_TEMPLATE
                            Dim strScript As String
                            strScript = " " + vbCrLf
                            strScript += "<script language = javascript>" + vbCrLf
                            strScript += "var objXHttp;" + vbCrLf
                            '//Modified By ShraddhaM on 4/10/2006 For SP7 IssuID : 6598
                            strScript += "	function HandlerOnReadyState()" + vbCrLf
                            strScript += "{" + vbCrLf
                            strScript += "if (navigator.appName =='Netscape')" + vbCrLf
                            strScript += "{" + vbCrLf
                            strScript += "if (objXHttp.readyState==0)" + vbCrLf
                            strScript += "{" + vbCrLf
                            strScript += " alert('Copied template is in draft mode. Please publish it before using it.');"
                            '' strScript += "opener.location.href='CommonList.aspx?FromWhere=PM&MasterTagId=" & CommonFunction.Constants.APP_TAG_PRACTICE_SELECTION & "';"
                            'strscript += " refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx?FromWhere=PM&MasterTagID=2175',true); " + vbCrLf
                            strScript += " refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx',true); " + vbCrLf

                            strScript += "window.close();"
                            'strscript += " refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx?FromWhere=PM&MasterTagID=2175',true); " + vbCrLf

                            'strscript += " refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx?FromWhere=PM&MasterTagID=2175',true); " + vbCrLf
                            'strScript += "window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?FromWhere=PM&MasterTagID=2175';" + vbCrLf
                            'strScript += "window.opener.document.forms['frmCommonList'].submit();" + vbCrLf
                            strScript += "}" + vbCrLf
                            strScript += "}" + vbCrLf
                            strScript += "else {" + vbCrLf
                            strScript += "if (objXHttp.readyState==4)" + vbCrLf
                            strScript += "{" + vbCrLf
                            strScript += " alert('Copied template is in draft mode. Please publish it before using it.');"
                            '' strScript += "opener.location.href='CommonList.aspx?FromWhere=PM&MasterTagId=" & CommonFunction.Constants.APP_TAG_PRACTICE_SELECTION & "';"
                            strScript += "window.close();"
                            '' strscript += " refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx?FromWhere=PM&MasterTagID=2175',true); " + vbCrLf
                            strScript += "window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?FromWhere=PM&MasterTagID=2175';" + vbCrLf
                            strScript += "window.opener.document.forms['frmCommonList'].submit();" + vbCrLf
                            ''strScript += "return;"
                            strScript += "}" + vbCrLf
                            strScript += "}" + vbCrLf
                            strScript += "}" + vbCrLf
                            strScript += "</script>"
                            CommonFunctions.General.WriteHTML(strScript)
                            ' PageUIPreRender = strScript
                            '***** End addition by SandipL on 22 nov 2005 

                        Case CommonFunction.Constants.APP_TAG_PM_PROJECT_INFORMATION
                            Dim strSQL As String
                            Dim intResult As Integer
                            Dim strProjectName As String

                            'strsql = "If Exists(Select 1 from tbl_PM_ProjectInfoRoleAccess where ProjectID=" & WhizGlobal.ProjectID & " and RoleID= " & WhizGlobal.RoleID & ")Select 1 Else Select 0"
                            strSQL = "If Exists(Select 1 from tbl_PM_ProjectInfoRoleAccess where ProjectID=" & CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer) & " and RoleID= " & WhizGlobal.RoleID & ")Select 1 Else Select 0"
                            intResult = CInt(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                            If intResult = 1 Then
                                PageUIPreRender = "../General/CommonPage.aspx?FromWhere=PM&ProjectID_PK=" & CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                                strActionCode = ReturnCodes.REDIRECT.ToString
                                'vigation.aspx?subPage=CommonPage.aspx&ProjectID_PK=" & CType(Args.DataReader("ProjectID"), String) & "&ProjectName=" & strProjectName & "&MasterTagID=3086&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1"" Title=""""  Target=_top >" & CType(Args.DataReader("ProjectName"), String) & " </A></TD>"
                            End If
                            ' integrated by harshada d on 15th june 2006
                            'Added by PrajaktaR for WhizibleSEM 6.0.1 IssueID 3736
                        Case CommonFunction.Constants.APP_TAG_COPY_CHECKLIST
                            Dim strScript As String
                            strScript = " " + vbCrLf
                            strScript += "<script language = javascript>" + vbCrLf
                            strScript += "var objXHttp;" + vbCrLf
                            strScript += "	function HandlerOnReadyState()" + vbCrLf

                            strScript += "{" + vbCrLf
                            '//Modified By ShraddhaM on 4/10/2006 For SP7 IssuID : 6598
                            strScript += "if(navigator.appName =='Netscape') {" + vbCrLf

                            strScript += "if (objXHttp.readyState==0)" + vbCrLf
                            strScript += "{" + vbCrLf
                            strScript += " alert('Copied template is in draft mode. Please publish it before using it.');"
                            ''opener.location.href=
                            'strScript += "frmCommonList.action = 'CommonPage.aspx?MasterTagID=3054';" + vbCrLf
                            'strScript += "frmCommonList.submit();" + vbCrLf
                            'strScript += "return;" + vbCrLf
                            'strScript += "refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx?FromWhere=PM&MasterTagId=2263');"
                            'strScript += "refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx?FromWhere=PM&MasterTagId=2263');"
                            strScript += "refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx',true);"

                            strScript += "window.close();"

                            'strScript += "refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx?FromWhere=PM&MasterTagId=2263');"

                            strScript += "}" + vbCrLf
                            strScript += "}" + vbCrLf 'End of Firefox IF
                            strScript += "else {" + vbCrLf
                            strScript += "if (objXHttp.readyState==4)" + vbCrLf
                            strScript += "{" + vbCrLf
                            strScript += " alert('Copied template is in draft mode. Please publish it before using it.');"
                            strScript += "window.close();"
                            strScript += "window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?FromWhere=PM&MasterTagID=2263';" + vbCrLf
                            strScript += "window.opener.document.forms['frmCommonList'].submit();" + vbCrLf
                            strScript += "}" + vbCrLf
                            strScript += "}" + vbCrLf 'End of Firefox else
                            strScript += "}" + vbCrLf
                            strScript += "</script>"
                            '//Ended By ShraddhaM on 4/10/2006 For SP7 IssuID : 6598
                            CommonFunctions.General.WriteHTML(strScript)
                            'Added by PrajaktaR for WhizibleSEM 6.0.1 IssueID 3736
                            'end of integration by harshada d on 15 th June 2006

                            'Integrated by MrugajaB on 25th July 2006 for WhizibleSEM SP7
                            'Purpose: The stylesheet selected through 'Themes' node is not getting selected
                            'Added By NileshD on 07/09/04
                        Case CommonFunctions.Constants.App_TAG_THEMES
                            Dim drStyleSheet As IDataReader
                            Dim strSQL As String
                            Dim strDefault As String
                            strSQL = "SELECT UserStyleSheetID FROM tbl_UI_UserSettings WHERE LoginID = " + WhizGlobal.LoginID.ToString
                            drStyleSheet = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If drStyleSheet.Read Then
                                drStyleSheet.Close()
                            Else
                                drStyleSheet.Close()
                                strSQL = "SELECT StylesheetID FROM tbl_UI_StyleSheets WHERE IsSystemDefault = 1"
                                drStyleSheet = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drStyleSheet.Read Then
                                    strDefault = drStyleSheet("StyleSheetID").ToString
                                    strSQL = "INSERT INTO tbl_UI_UserSettings(LoginID, StyleSheetID) Values(" + WhizGlobal.LoginID.ToString + "," + strDefault + ")"
                                    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                End If

                            End If

                            CommonFunction.Data.DisposeDataReader(drStyleSheet)
                            'End Of Addition
                            'End Integration by MrugajaB
                            ' Added BY MahendraV On 10:40 AM 5/10/2007 For Module Closure
                            'Start_MV_5/10/2007
                        Case CommonFunction.Constants.APP_TAG_MODULES
                            Dim strRefersh As New StringBuilder("")

                            If HttpContext.Current.Request.QueryString("CloseModule") = "1" Then
                                Dim strSQL As String
                                Dim strModuleId_PK As String
                                strModuleId_PK = HttpContext.Current.Request.QueryString("ModuleId_PK")
                                strSQL = "usp_Upd_tbl_PM_Module_CloseModule " & strModuleId_PK
                                CommonFunction.Data.InsertOrUpdateData(strSQL, True)

                                CommonFunction.EmailMessages.PMMessages.ReOpen_Closure_SendMail(strModuleId_PK, CType(483, String))


                                HttpContext.Current.Response.Write(CommonFunction.General.GetRefreshParentScript("'frmGanttChartView'", "'GanttChartView.aspx'", "'../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + CommonFunction.Constants.APP_TAG_MODULES.ToString + "'", True))

                            End If
                            If HttpContext.Current.Request.QueryString("ReOpenModule") = "1" Then
                                Dim strSQL As String
                                Dim strModuleId_PK As String
                                strModuleId_PK = HttpContext.Current.Request.QueryString("ModuleId_PK")
                                strSQL = "usp_Upd_tbl_PM_Module_ReOpenModule " & strModuleId_PK
                                CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                                CommonFunction.EmailMessages.PMMessages.ReOpen_Closure_SendMail(strModuleId_PK, CType(484, String))



                            End If

                            strRefersh = Nothing
                            'End_MV_5/10/2007

                            ' Added BY MahendraV On 3:25 PM 5/12/2007 for SubProject Closure
                            ' Start_MV_5/12/2007
                        Case CommonFunction.Constants.APP_TAG_SUB_PROJECTS

                            If HttpContext.Current.Request.QueryString("CloseSubProject") = "1" Then
                                Dim strSQL As String
                                Dim strSubProjectId_PK As String
                                strSubProjectId_PK = HttpContext.Current.Request.QueryString("SubProjectId_PK")
                                strSQL = "usp_Upd_tbl_PM_SubProject_CloseSubProject " & strSubProjectId_PK
                                CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                                CommonFunction.EmailMessages.PMMessages.ReOpen_Closure_SendMail(strSubProjectId_PK, CType(485, String))

                                HttpContext.Current.Response.Write(CommonFunction.General.GetRefreshParentScript("'frmGanttChartView'", "'GanttChartView.aspx'", "'../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString + "'", True))

                            End If
                            If HttpContext.Current.Request.QueryString("ReOpenSubProject") = "1" Then
                                Dim strSQL As String
                                Dim strSubProjectId_PK As String
                                strSubProjectId_PK = HttpContext.Current.Request.QueryString("SubProjectId_PK")
                                strSQL = "usp_Upd_tbl_PM_SubProject_ReOpenSubProject " & strSubProjectId_PK
                                CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                                CommonFunction.EmailMessages.PMMessages.ReOpen_Closure_SendMail(strSubProjectId_PK, CType(486, String))
                            End If

                            'End_MV_5/12/2007

                            ' Added BY MahendraV On 12:55 PM 5/15/2007 for MileStone Closure
                            ' Start_MV_5/15/2007
                        Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS


                            If HttpContext.Current.Request.QueryString("CloseMileStone") = "1" Then
                                Dim strSQL As String
                                Dim strMileStoneId_PK As String
                                strMileStoneId_PK = HttpContext.Current.Request.QueryString("MileStoneId_PK")
                                strSQL = "usp_Upd_tbl_PM_MileStone_CloseMileStone " & strMileStoneId_PK
                                CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                                CommonFunction.EmailMessages.PMMessages.ReOpen_Closure_SendMail(strMileStoneId_PK, CType(487, String))

                                HttpContext.Current.Response.Write(CommonFunction.General.GetRefreshParentScript("'frmGanttChartView'", "'GanttChartView.aspx'", "'../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString + "'", True))

                            End If
                            If HttpContext.Current.Request.QueryString("ReOpenMileStone") = "1" Then
                                Dim strSQL As String
                                Dim strMileStoneId_PK As String
                                strMileStoneId_PK = HttpContext.Current.Request.QueryString("MileStoneId_PK")
                                strSQL = "usp_Upd_tbl_PM_MileStone_ReOpenMileStone " & strMileStoneId_PK
                                CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                                CommonFunction.EmailMessages.PMMessages.ReOpen_Closure_SendMail(strMileStoneId_PK, CType(488, String))

                            End If

                            'End_MV_5/15/2007

                            ' Added By NitinVS on 11 May 2007 for Whizible 7.0 
                            ' Deleting of AMC Collection Details need to be done before plotting the header as it referes to the amc collection amt
                        Case CommonFunction.Constants.APP_TAG_PRODUCT_VERSION_AMC_COLLECTION
                            Dim strSubTagId As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString.Get("SubTagID"), "")
                            Dim strOperation As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString.Get("Operation"), "")
                            If strSubTagId = "3206" And strOperation = "DELETE" Then
                                Dim AmcID As String = HttpContext.Current.Request.QueryString.Get("ID").ToString()
                                Dim AmcDetailsID As String() = HttpContext.Current.Request.Form.GetValues("ChkDelete3206")
                                Dim selctedDeatilsId As String
                                Dim sbstrSQL As New System.Text.StringBuilder
                                Dim sbstrResult As New System.Text.StringBuilder

                                For Each selctedDeatilsId In AmcDetailsID
                                    sbstrSQL.Length = 0
                                    sbstrSQL.Append("BEGIN " + vbCrLf)
                                    sbstrSQL.Append(" Declare @p1 Varchar(2000) " + vbCrLf)
                                    sbstrSQL.Append(" Set @P1='' " + vbCrLf)
                                    sbstrSQL.Append(" EXEC usp_Del_tbl_PRD_Customer_ProductVersion_AMC_CollectionDetails '")
                                    sbstrSQL.Append(selctedDeatilsId)
                                    sbstrSQL.Append("' , ")
                                    sbstrSQL.Append(" @strResult = @p1 output " + vbCrLf)
                                    sbstrSQL.Append(" select @P1" + vbCrLf)
                                    sbstrSQL.Append(" END ")

                                    sbstrResult.Append(CommonFunction.Data.GetDataScalar(sbstrSQL.ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString() + "\n")

                                Next

                                If sbstrResult.Length > 0 Then
                                    PageUIPreRender = "alert(""" + Replace(sbstrResult.ToString(), """", "\""") + """);"
                                    strActionCode = ReturnCodes.ON_LOAD.ToString()
                                End If
                            End If


                            ' End Addition By NitinVS on 11 May 2007 for Whizible 7.0 

                            'Addition done by SuchitraP on 21-MAY-2007 for CleanUp Activity
                        Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEMASTER
                            If HttpContext.Current.Request.QueryString("Operation") = "DELETE" Then
                                Dim strSQL As String
                                Dim getSelChkbox As String = ""
                                getSelChkbox += HttpContext.Current.Request.Form("chkDelete1002") & ","
                                Dim strmessage As String = ""
                                Dim arrchkbox As String()
                                arrchkbox = Split(getSelChkbox, ",")
                                Dim arrobj As Integer
                                Dim strOutMsg As String
                                'Dim strscript As String = ""

                                While arrobj < arrchkbox.Length - 1
                                    'strSQL += "exec usp_del_EmployeesLeaveTypes @intUniqueID = " & arrchkbox(arrobj) & ", @strResult = @P1 output" & vbCrLf
                                    strSQL = "declare @P1 varchar(2000)" & vbCrLf
                                    strSQL += "exec usp_del_EmployeesLeaveTypes " & arrchkbox(arrobj) & ", @strResult = @P1 output" & vbCrLf
                                    'strSQL = "exec usp_del_EmployeesLeaveTypes " & arrchkbox(arrobj) & ", strOutMsg = @P1 output" & vbCrLf
                                    strSQL += "SELECT @P1" & vbCrLf
                                    strmessage += CType(CommonFunctions.Data.GetSQLDataScalar(strSQL), String) + "\n"
                                    arrobj = arrobj + 1
                                End While
                                If strmessage <> "" Then
                                    PageUIPreRender = "alert(""" & strmessage.Replace("""", "\""") & """);"
                                    strActionCode = ReturnCodes.ON_LOAD.ToString()
                                End If
                            End If
                            'end of Addition done by SuchitraP on 21-MAY-2007 for CleanUp Activity
                        Case CommonFunction.Constants.APP_TAG_PUBLISH_DELIVERABLE_PROJECT_TEMPLATE
                            ' Added By MahendraV On 8:15 PM 7/5/2007 For WhizibleSEM 7 
                            ' To check for allowing copy execution template at project level
                            ' Start_MV_7/5/2007
                            Dim strTemplateID As String
                            Dim strProjectID As String
                            strTemplateID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TemplateID"), "")
                            strProjectID = CType(HttpContext.Current.Session("intProjectID"), String)
                            PageUIPreRender = ""
                            Dim strMessage As String = ""
                            strMessage = CType(CommonFunction.Data.GetDataScalar("usp_Sel_tbl_PM_AllowPublishCopyTemplate " + strTemplateID + "," + strProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
                            If strMessage <> "" Then
                                PageUIPreRender += " alert('" + strMessage + "');"
                                PageUIPreRender += vbCrLf + "window.close();"
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If
                            ' End_MV_7/5/2007
                        Case CommonFunction.Constants.APP_TAG_CREATE_PROJECT
                            'Added by ShraddhaM on 17,Sept 2008
                            'Purpose : To create project when opportunity is closed in Whiziblesem8.0
                            Dim strFrom As String
                            Dim OpportunityID As String
                            Dim CustomerID As String
                            Dim CustomerName As String

                            strFrom = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("From"), "")
                            If strFrom Is Nothing OrElse strFrom = "" Then
                                strFrom = HttpContext.Current.Request.Form("hidFrom")
                            End If
                            OpportunityID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("opportunityID"), "")
                            If OpportunityID Is Nothing OrElse OpportunityID = "" Then
                                OpportunityID = HttpContext.Current.Request.Form("hidOppID")
                            End If
                            CustomerID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CustomerID"), "")
                            If CustomerID Is Nothing OrElse CustomerID = "" Then
                                CustomerID = HttpContext.Current.Request.Form("hidCustomerID")
                            End If
                            CustomerName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CustomerName"), "")
                            If CustomerName Is Nothing OrElse CustomerName = "" Then
                                CustomerName = HttpContext.Current.Request.Form("hidCustomerName")
                            End If

                            CommonFunction.General.WriteHTML("<input type=hidden name='hidFrom' id='hidFrom' value='" + strFrom + "'>")
                            CommonFunction.General.WriteHTML("<input type=hidden name='hidOppID' id='hidOppID' value=" + OpportunityID + ">")
                            CommonFunction.General.WriteHTML("<input type=hidden name='hidCustomerID' id='hidCustomerID' value='" + CustomerID + "'>")
                            CommonFunction.General.WriteHTML("<input type=hidden name='hidCustomerName' id='hidCustomerName' value='" + CustomerName + "'>")

                        Case CommonFunction.Constants.APP_TAG_CUSTOMER_MASTER
                            Dim strFrom As String
                            Dim OpportunityID As String
                            Dim CustomerID As String
                            Dim CustomerName As String

                            strFrom = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("From"), "")
                            If strFrom Is Nothing OrElse strFrom = "" Then
                                strFrom = HttpContext.Current.Request.Form("hidFrom")
                            End If
                            OpportunityID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("opportunityID"), "")
                            If OpportunityID Is Nothing OrElse OpportunityID = "" Then
                                OpportunityID = HttpContext.Current.Request.Form("hidOppID")
                            End If

                            CustomerName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CustomerName"), "")
                            If CustomerName Is Nothing OrElse CustomerName = "" Then
                                CustomerName = HttpContext.Current.Request.Form("hidCustomerName")
                            End If

                            CommonFunction.General.WriteHTML("<input type=hidden name='hidFrom' id='hidFrom' value='" + strFrom + "'>")
                            CommonFunction.General.WriteHTML("<input type=hidden name='hidOppID' id='hidOppID' value=" + OpportunityID + ">")
                            'CommonFunction.General.WriteHTML("<input type=hidden name='hidCustomerID' id='hidCustomerID' value='" + CustomerID + "'>")
                            CommonFunction.General.WriteHTML("<input type=hidden name='hidCustomerName' id='hidCustomerName' value='" + CustomerName + "'>")

                            'End of addition by ShraddhaM on 17,Sept 2008

                    End Select

                Else
                    'Details Tag
                    Select Case WhizGlobal.TagID
                        'Case CommonFunction.Constants.APP_TAG_TAG_EMPLOYEE_CERTIFICATIONS
                        Case CommonFunction.Constants.APP_TAG_TAB_EMPLOYEE_CERTIFICATIONS
                            Dim strScript As String
                            'Initialize the varibles used to display validation messages
                            strScript = "var strCertificationDateMsg='" + m_objTemplate.GetResourceString("EMPLOYEE_CERTIFICATIONS_DATE_MESSAGE") + "';"
                            PageUIPreRender = strScript
                            'Application standard return code
                            strActionCode = ReturnCodes.ON_LOAD.ToString
                            'added by SachinR   on 15 Jul 2004
                            'This code is copied from the Whizible 4.1 written by UmeshJ to port this functionality
                        Case CommonFunction.Constants.APP_TAG_TAB_SDLC_CHECKLISTS
                            If strPrimaryKey.Trim <> "" Then
                                'We are changing the default behavior of the Edit mode.....
                                'If the user clicks on the Edit link then the Check list form should get displayed for download
                                Dim strUniqueID As String = HttpContext.Current.Request.QueryString("UniqueID_PK")
                                Dim strChecklistID As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetSQLDataScalar("usp_Sel_tbl_PRS_SDLC_Checklists_ChecklistID '" + strUniqueID + "'"))
                                'Open the Checklist Form Page and close the Edit window
                                PageUIPreRender = "window.open('../Process/PRO_ChecklistPreview.aspx?QuestionnaireID=" + strChecklistID + "','', 'resizable=yes,menubar=yes,scrollbars=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 600)/2 + ',width=800,height=600'); window.close();"
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If
                        Case CommonFunction.Constants.APP_TAG_TAB_SDLC_TEMPLATES
                            If strPrimaryKey.Trim <> "" Then
                                'We are changing the default behavior of the Edit mode.....
                                'If the user clicks on the Edit link then the Template should get displayed for download
                                Dim strUniqueID As String = HttpContext.Current.Request.QueryString("UniqueID_PK")
                                Dim lngTemplateID As Long = CType(CommonFunctions.Data.GetSQLDataScalar("usp_Sel_tbl_PRS_SDLC_Templates '" + strUniqueID + "'"), Long)
                                'Open the Template and close the Edit window
                                Dim strTemplateFileName As String = CommonFunction.General.funcReturnOriginalFileName("TPT", lngTemplateID)
                                PageUIPreRender = "window.open('../General/ViewAttachment.aspx?FromWhere=TPT&FileName=" + strTemplateFileName.Trim + "','pp','MENUBAR=no,TITLEBAR=yes,TOOLBAR=no,RESIZABLE=yes');window.close();"
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If
                            'addition end


                    End Select
                End If
            End Function

            Public Function PageListPostRender(ByVal WhizGlobal As WebPages.Template.IGlobal) As String
                PageListPostRender = ""
                Select Case WhizGlobal.TagID
                    'Integrated by SandipL SP8 to SP9
                    'Start_AJ_09Jan2007
                    Case CommonFunction.Constants.APP_TAG_DASHBOARDLOOKUP
                        CommonFunction.General.WriteHTML("<INPUT type=hidden id=hidParentControl name = hidParentControl value=" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ParentControl"), "") + ">")
                        'End_AJ_09Jan2007
                        'End Integration by SandipL SP8 to SP9
                        'Added by ShamkantD on 27 Sep 2004
                    Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING
                        'Remove session variables
                        If Not HttpContext.Current.Session("blnIsApprover") Is Nothing Then
                            HttpContext.Current.Session.Remove("blnIsApprover")
                        End If
                        'End of addition - ShamkantD on 27 Sep 2004
                        'Modified By VidyaJ - Performance Issue - Deliverable - SP4 - IssueID -84
                        'Store selected deliverable in session variable and use it while plotting instead of
                        'firing the query every time in Grid TD event
                    Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                        'Remove session variables
                        If Not HttpContext.Current.Session("DeliverableType") Is Nothing Then
                            HttpContext.Current.Session.Remove("DeliverableType")
                        End If



                End Select

                'Application standard return code
                strActionCode = ReturnCodes.DO_NOTHING.ToString

            End Function

            Public Function PageUIPostRender(ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal strPrimaryKey As String = "") As String
                PageUIPostRender = ""
                'Application standard return code
                strActionCode = ReturnCodes.DO_NOTHING.ToString

                If WhizGlobal.ParentTagID = 0 Then
                    Select Case WhizGlobal.TagID


                        'Code added by SajiU on 12th Dec 2006
                        'Case CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_EMPLOYEE, CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_CUSTOMER, CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_CUSTOMER_CREATED, CommonFunction.Constants.App_Tag_Login_Maintenance
                        'Commented And Added By Usha Pandit On 07.01.2021 For making encrypted password value blank for LOGIN_MAINTENANCE
                        'Case CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_EMPLOYEE, CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_CUSTOMER, CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_CUSTOMER_CREATED, CommonFunction.Constants.TAG_SUB_TENANTS, CommonFunction.Constants.TAG_TENANTS
                        Case CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_EMPLOYEE, CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_CUSTOMER, CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_CUSTOMER_CREATED, CommonFunction.Constants.TAG_SUB_TENANTS, CommonFunction.Constants.TAG_TENANTS, CommonFunction.Constants.App_Tag_Login_Maintenance
                            'End Of Added By Usha Pandit On 07.01.2021 For making encrypted password value blank for LOGIN_MAINTENANCE
                            'Clear Password field value
                            PageUIPostRender = vbCrLf + "var objPass=GetObjectReference('frmCommonPage','Password');"
                            PageUIPostRender += vbCrLf + "if (objPass != null) {objPass.value="""";}"
                            strActionCode = ReturnCodes.ON_LOAD.ToString

                            'Added By Chakshuta H on 29th-Oct-2015
                            'With Ref No : WAF3_GEN_3
                        Case CommonFunctions.Constants.MASTER_TAG_UI_CONFIGURATION
                            'Refresh Hash table
                            Dim PrimaryKey As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("TagID_PK"))
                            If PrimaryKey <> "" Then
                                CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CType(PrimaryKey, Long))
                            End If
                            'Ended By Chakshuta H on 29th-Oct-2015

                        Case CommonFunction.Constants.APP_TAG_REVIEW_PLANNING  'Review Planning Tag
                            'Set the Old Date value = review date
                            PageUIPostRender = vbCrLf + "var objOldDate=GetObjectReference('frmCommonPage','NonDatabase3');"
                            PageUIPostRender += vbCrLf + "var objReviewDate=GetObjectReference('frmCommonPage','ReviewedDate');"
                            PageUIPostRender += vbCrLf + "if (objOldDate != null && objReviewDate != null) {objOldDate.value=objReviewDate.value;}"
                            'Code Added by DipaliS 20 Oct 2004
                            PageUIPostRender += vbCrLf + "var objOldStartDate=GetObjectReference('frmCommonPage','NonDatabase4');"
                            PageUIPostRender += vbCrLf + "var objReviewStartDate=GetObjectReference('frmCommonPage','ReviewStartDate');"
                            PageUIPostRender += vbCrLf + "if (objOldStartDate != null && objReviewStartDate != null) {objOldStartDate.value=objReviewStartDate.value;}"

                            PageUIPostRender += vbCrLf + "var objOldEndDate=GetObjectReference('frmCommonPage','NonDatabase5');"
                            PageUIPostRender += vbCrLf + "var objReviewEndDate=GetObjectReference('frmCommonPage','ReviewEndDate');"
                            PageUIPostRender += vbCrLf + "if (objOldEndDate != null && objReviewEndDate != null) {objOldEndDate.value=objReviewEndDate.value;}"



                            'End Addition by DipaliS
                            If Not (strPrimaryKey = "") Then
                                'If its the edit mode
                                Dim drReviewers As IDataReader
                                Dim strReviewerIDList As String = ""
                                ' Get the list of reviewers for this review.
                                drReviewers = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ReviewStatistics_Reviewers_New " + strPrimaryKey, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drReviewers.Read Then
                                    strReviewerIDList = ","
                                    strReviewerIDList = strReviewerIDList + Trim(drReviewers("ReviewerID").ToString) + ","
                                    Do While drReviewers.Read
                                        If Trim(drReviewers("ReviewerID").ToString) <> "" Then
                                            strReviewerIDList = strReviewerIDList + Trim(drReviewers("ReviewerID").ToString) + ","
                                        End If
                                    Loop
                                End If
                                drReviewers.Close() : drReviewers.Dispose() : drReviewers = Nothing

                                'Code Added By SatyanarayanaA on 20-Jan-2006 for getting the check after Save in the Reviewer Page
                                Dim drReviewee As IDataReader
                                Dim strRevieweeIDList As String = ""

                                drReviewee = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ReviewStatistics_Authors " + strPrimaryKey, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'If drReviewee.Read Then
                                strRevieweeIDList = ","
                                'strRevieweeIDList = strRevieweeIDList + Trim(drReviewee("AuthorID").ToString) + ","
                                While drReviewee.Read
                                    If Trim(drReviewee("AuthorID").ToString) <> "" Then
                                        strRevieweeIDList = strRevieweeIDList + Trim(drReviewee("AuthorID").ToString) + ","
                                    End If
                                End While
                                drReviewee.Close() : drReviewee.Dispose() : drReviewee = Nothing
                                'End Of Addition By SatyanarayanaA on 20-Jan-2006 for getting the check after Save in the Reviewer Page

                                'Code Added By SatyanarayanaA on 20-Jan-2006 for getting the check after Save in the Reviewer Page

                                PageUIPostRender = vbCrLf + "var objRevieweeIDList = GetObjectReference('frmCommonPage','NonDatabase12');"
                                PageUIPostRender += vbCrLf + "if (objRevieweeIDList != null) { objRevieweeIDList.value = '" + strRevieweeIDList + "';}"

                                If Not (strReviewerIDList = "") Then
                                    PageUIPostRender += vbCrLf + "var objReviewerIDList = GetObjectReference('frmCommonPage','NonDatabase1');"
                                    PageUIPostRender += vbCrLf + "if (objReviewerIDList != null) { objReviewerIDList.value = '" + strReviewerIDList + "';}"
                                End If
                            End If
                            strActionCode = ReturnCodes.ON_LOAD.ToString
                            'Added by ShamkantD on 10th September 2004 - for Fast Track Reviews

                            'Added by PrajaktaR on 16th May 2005 for PCFC IssueID 19234
                            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")) = "SAVE" Then
                                'On saving the Form do net set focus on any of the control 
                                'ModifiedBy HarshK for sp4 issueid 449
                                PageUIPostRender += vbCrLf + "var objCtrl = GetObjectReference('frmCommonPage','PReviewTypeID'); if (objCtrl!= null){objCtrl.focus=true}"
                                'End ModifiedBy HarshK for sp4 issueid 449

                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If
                            'End of Addition by PrajaktaR on 16th May 2005 for PCFC IssueID 19234



                        Case CommonFunction.Constants.APP_TAG_REVIEWS 'Reviews Tag
                            If Not (strPrimaryKey = "") Then
                                'If its the edit mode
                                Dim drReviewers As IDataReader
                                Dim strReviewerIDList As String = ""
                                ' Get the list of reviewers for this review.
                                drReviewers = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ReviewStatistics_Reviewers " + strPrimaryKey, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drReviewers.Read Then
                                    strReviewerIDList = ","
                                    strReviewerIDList = strReviewerIDList + Trim(drReviewers("ReviewerID").ToString) + ","
                                    Do While drReviewers.Read
                                        If Trim(drReviewers("ReviewerID").ToString) <> "" Then
                                            strReviewerIDList = strReviewerIDList + Trim(drReviewers("ReviewerID").ToString) + ","
                                        End If
                                    Loop
                                End If
                                drReviewers.Close() : drReviewers.Dispose() : drReviewers = Nothing
                                'Code Added By SatyanarayanaA on 20-Jan-2006 for getting the check after Save in the Reviewer Page
                                Dim drReviewee As IDataReader
                                Dim strRevieweeIDList As String = ""

                                drReviewee = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ReviewStatistics_Authors " + strPrimaryKey, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'If drReviewee.Read Then
                                strRevieweeIDList = ","
                                'strRevieweeIDList = strRevieweeIDList + Trim(drReviewee("AuthorID").ToString) + ","
                                While drReviewee.Read
                                    If Trim(drReviewee("AuthorID").ToString) <> "" Then
                                        strRevieweeIDList = strRevieweeIDList + Trim(drReviewee("AuthorID").ToString) + ","
                                    End If
                                End While
                                drReviewee.Close() : drReviewee.Dispose() : drReviewee = Nothing
                                'End Of Addition By SatyanarayanaA on 20-Jan-2006 for getting the check after Save in the Reviewer Page


                                'Code Added By SatyanarayanaA on 20-Jan-2006 for getting the check after Save in the Reviewer Page

                                PageUIPostRender = vbCrLf + "var objRevieweeIDList = GetObjectReference('frmCommonPage','NonDatabase12');"
                                PageUIPostRender += vbCrLf + "if (objRevieweeIDList != null) { objRevieweeIDList.value = '" + strRevieweeIDList + "';}"

                                'Set the value of Reviewer id list in the hidden control NonDatabase
                                If Not (strReviewerIDList = "") Then
                                    PageUIPostRender += vbCrLf + "var objReviewerIDList = GetObjectReference('frmCommonPage','NonDatabase1');"
                                    PageUIPostRender += vbCrLf + "if (objReviewerIDList != null) { objReviewerIDList.value = '" + strReviewerIDList + "';}"
                                End If
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                                'End of Addition By SatyanarayanaA on 20-Jan-2006 for getting the check after Save in the Reviewer Page

                            End If
                        Case CommonFunction.Constants.APP_TAG_RESOURCES  'Resources Tag
                            PageUIPostRender = ""
                            If Not (strPrimaryKey = "") Then
                                'If its the edit mode then set the value of the control NonDatabase1
                                Dim drResources As IDataReader
                                Dim strUserName As String
                                'Get the UserName value for the Role identified by the Primary Key
                                drResources = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ProjectEmployeeRole " + strPrimaryKey, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If (drResources.Read) Then
                                    strUserName = CommonFunction.General.CheckIsNothing(drResources("UserName").ToString)
                                    strUserName = strUserName.Replace("'", "\'")
                                End If
                                CommonFunction.Data.DisposeDataReader(drResources)
                                'Generate script for assigning the value to the control and disable it
                                PageUIPostRender = vbCrLf + "var objNonDatabase1 = GetObjectReference('frmCommonPage', 'NonDatabase1');"
                                PageUIPostRender += vbCrLf + "if (objNonDatabase1 != null){objNonDatabase1.value = '" + strUserName + "';}"
                            End If

                            CommonFunction.General.WriteHTML("<script language='javascript'>")
                            'Added by PrashantD on 7 March 2007 for IssueID 11095
                            CommonFunction.General.WriteHTML("if (GetObjectReference('frmCommonPage','ReportingTo'))")
                            'End of addition by PrashantD on 7 March 2007
                            CommonFunction.General.WriteHTML("PreviousReportingTo = GetObjectReference('frmCommonPage','ReportingTo').value;" + vbCrLf)
                            CommonFunction.General.WriteHTML("</script>")


                            PageUIPostRender += vbCrLf + "if (GetObjectReference('frmCommonPage', 'NonDatabase1') != null){GetObjectReference('frmCommonPage', 'NonDatabase1').disabled=true;}"


                            strActionCode = ReturnCodes.ON_LOAD.ToString

                            ''Commented By ManishK on 3rd Jan 06 as inherited page is added for Leave page
                            '''''Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEAPPLICATION
                            '''''    Dim strScript As String
                            '''''    strScript += "var objLBalance = GetObjectReference('frmCommonPage','NonDatabase1');" + vbCrLf
                            '''''    strScript += "var objLeave;" + vbCrLf
                            '''''    'ADDED BY MANGESH ON 7 APRIL 2005 : DEFAULT LEAVE TYPE SHOULD ONLY BE SET IN ADD NEW MODE PCFC ISSUE 17546
                            '''''    strScript += "var objLeaveId = GetObjectReference('frmCommonPage','LeaveID_PK');" + vbCrLf
                            '''''    'END ADDITION
                            '''''    'strscript += "objLBalance = GetObjectReference('frmCommonPage', 'NonDatabase1');" + vbCrLf
                            '''''    strScript += "objLBalance.selectedIndex = 1;" + vbCrLf
                            '''''    strScript += "objLeave = GetObjectReference('frmCommonPage', 'LeaveTypeID');" + vbCrLf
                            '''''    'ADDED BY MANGESH ON 7 APRIL 2005 : DEFAULT LEAVE TYPE SHOULD ONLY BE SET IN ADD NEW MODE PCFC ISSUE 17546
                            '''''    strScript += "if (objLeaveId.value == '')" + vbCrLf
                            '''''    'END ADDITION
                            '''''    strScript += "objLeave.selectedIndex = 1;"
                            '''''    PageUIPostRender = strScript
                            '''''    strActionCode = ReturnCodes.ON_LOAD.ToString
                            '''''    'Added by PrajaktaR on 16 th May 2005 for PCFC IssueID 19235
                            '''''    If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")) = "SAVE" Then
                            '''''        'On saving the Form do net set focus on any of the control 
                            '''''        PageUIPostRender = vbCrLf + "var objCtrl = GetObjectReference('frmcommonpage','AppliedDate'); if (objCtrl!= null){objCtrl.focus=false}"
                            '''''        strActionCode = ReturnCodes.ON_LOAD.ToString
                            '''''    End If
                            '''''    'End of Addition by PrajaktaR on 16 th May 2005 for PCFC IssueID 19235

                            'Added By NileshD on 29 July 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_TYPE_MASTER
                            If Not HttpContext.Current.Session("RFITAXID") Is Nothing Then
                                HttpContext.Current.Session("RFITAXID") = Nothing
                            End If
                            'End Of Addition
                            'Added By NileshD on 7 August 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_DISPATCHED_DETAILS
                            Dim strScript As String
                            strScript = "var objDispatch = GetObjectReference('frmCommonPage','InvoiceDispatched');"
                            strScript += "var objCourieDate = GetObjectReference('frmCommonPage','courierDate');"
                            strScript += "var objCourierName = GetObjectReference('frmCommonPage','courierName');"
                            strScript += "var objcourierReferenceNumber = GetObjectReference('frmCommonPage','courierReferenceNumber');"
                            strScript += "var objdispatchedby = GetObjectReference('frmCommonPage','dispatchedby');"
                            strScript += "var objPODDetails = GetObjectReference('frmCommonPage','PODDetails');"
                            strScript += "if (objDispatch.checked == true)"
                            strScript += "{ objCourieDate.disabled = false;"
                            strScript += "  objCourierName.disabled = false;"
                            strScript += "  objcourierReferenceNumber.disabled = false;"
                            strScript += "  objdispatchedby.disabled = false;"
                            strScript += "   objPODDetails.disabled = false; }"
                            strScript += "else { "
                            strScript += " objCourieDate.disabled = true; "
                            strScript += " objCourierName.disabled = true; "
                            strScript += " objcourierReferenceNumber.disabled = true; "
                            strScript += " objdispatchedby.disabled = true; "
                            strScript += " objPODDetails.disabled = true; }"
                            PageUIPostRender = strScript
                            strActionCode = ReturnCodes.ON_LOAD.ToString
                            'End Of Addition

                            'added by SachinR   On 21 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLE_CODE_DEFINITION
                            Dim strScript As String
                            strScript = "var objTxt=GetObjectReference('frmCommonPage','CodeTemplate');"
                            strScript += "objTxt.readOnly=true;"
                            PageUIPostRender = strScript
                            strActionCode = ReturnCodes.ON_LOAD.ToString
                            'addition end

                            'Added by ShamkantD on 10th September 2004 - for Fast Track Reviews
                        Case CommonFunction.Constants.APP_TAG_FAST_TRACK_REVIEWS  'Fast Track Reviews Tag
                            If Not (strPrimaryKey = "") Then
                                'If its the edit mode
                                Dim drReviewers As IDataReader
                                Dim strReviewerIDList As String = ""
                                ' Get the list of reviewers for this review.
                                drReviewers = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ReviewStatistics_Reviewers " + strPrimaryKey, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drReviewers.Read Then
                                    strReviewerIDList = ","
                                    strReviewerIDList = strReviewerIDList + Trim(drReviewers("ReviewerID").ToString) + ","
                                    Do While drReviewers.Read
                                        If Trim(drReviewers("ReviewerID").ToString) <> "" Then
                                            strReviewerIDList = strReviewerIDList + Trim(drReviewers("ReviewerID").ToString) + ","
                                        End If
                                    Loop
                                End If
                                drReviewers.Close() : drReviewers.Dispose() : drReviewers = Nothing
                                'Set the value of Reviewer id list in the hidden control NonDatabase
                                If Not (strReviewerIDList = "") Then
                                    PageUIPostRender = vbCrLf + "var objReviewerIDList = GetObjectReference('frmCommonPage','NonDatabase1');"
                                    PageUIPostRender += vbCrLf + "if (objReviewerIDList != null) { objReviewerIDList.value = '" + strReviewerIDList + "';}"
                                    strActionCode = ReturnCodes.ON_LOAD.ToString
                                End If
                            End If
                            'End of addition - ShamkantD on 10th September 2004 
                            'added by SachinR   on 16 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_PUBLISH_PROCESS
                            Dim strOUPoolID As String
                            strOUPoolID = HttpContext.Current.Request.QueryString("OUPoolID") + ""
                            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("OUPoolID", "OUPoolID", , , , strOUPoolID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
                            'addition end

                            'Added by ShamkantD on 22 Sep 2004 - added for Project Information page
                        Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING
                            'Remove session variables
                            If Not HttpContext.Current.Session("strRevisionFieldsList") Is Nothing Then
                                HttpContext.Current.Session.Remove("strRevisionFieldsList")
                            End If

                            If Not HttpContext.Current.Session("blnIsApprover") Is Nothing Then
                                HttpContext.Current.Session.Remove("blnIsApprover")
                            End If

                            If Not HttpContext.Current.Session("blnIsProjectCreationWorkflowReqd") Is Nothing Then
                                HttpContext.Current.Session.Remove("blnIsProjectCreationWorkflowReqd")
                            End If

                            If Not HttpContext.Current.Session("blnProjectForApprovalFlag") Is Nothing Then
                                HttpContext.Current.Session.Remove("blnProjectForApprovalFlag")
                            End If
                            'End of addition - ShamkantD on 22 Sep 2004
                            '----- added By PUrvaj on 20 Jun 2008 Configurable workflow. Enable revision fields if submit link is plotted
                            If Not HttpContext.Current.Session("WorkflowLinks") Is Nothing Then
                                HttpContext.Current.Session.Remove("WorkflowLinks")
                            End If
                            '--- end purvaj

                            'Added by ShamkantD on 11 Oct 2004
                            If Not HttpContext.Current.Session("strProjectBaselineStatus") Is Nothing Then
                                HttpContext.Current.Session.Remove("strProjectBaselineStatus")
                            End If
                            'End of addition - ShamkantD on 11 Oct 2004

                            'Added by ShamkantD on 30 Sep 2004 - Added for Project information page
                            'When the user sends the Project for approval, an email should be sent to the approvers,
                            'in which case, the focus should be set on the email dialog and not on the Project
                            'Information page.
                            Dim strOperation As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), "").ToString().ToUpper()
                            If strOperation = "SENDFORAPPROVAL" Then
                                'Do net set focus on any of the control 
                                PageUIPostRender = vbCrLf & "var objCtrl = GetObjectReference('frmCommonPage','ShortJobTitle');" & vbCrLf & "if (objCtrl!= null)" & vbCrLf & "    objCtrl.focus=false;"
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If
                            'End of addition - ShamkantD on 30 Sep 2004

                            'Added code by SwapnilR on 14th Dec 2004
                            'Purpose - setting focus to associated task page which is populated 
                            '          after saving the detail of deliverable page
                        Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")) = "SAVE" Then
                                'On saving the Form do net set focus on any of the control 
                                PageUIPostRender = vbCrLf + "var objCtrl = GetObjectReference('frmCommonPage','Title'); if (objCtrl!= null){objCtrl.focus=false}"
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If

                            'End of code addtion by SwapnilR on 14th Dec 2004

                            ' Added By VivekP on 5 May 2005 for WhizibleSEM SP3 Copy Sub Project Functionality Functionality
                            Dim COPYDATA As String
                            Dim UniqueID As Integer = 0
                            Dim strTobeInserted As String
                            COPYDATA = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("COPYDATA"), ""), String)
                            UniqueID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UNIQUEID"), "0"), Integer)

                            If COPYDATA <> "" And UniqueID <> 0 Then
                                strTobeInserted = CommonFunction.CopyData.CopyData(CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE, UniqueID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                PageUIPostRender = strTobeInserted
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If
                            'End of Addition On 5 May 2005 for WhizibleSEM SP3 Copy Sub Project Functionality Functionality

                            'Modified By VidyaJ - Performance Issue - Deliverable - SP4 - IssueID -84

                            If Not HttpContext.Current.Session("ScheduleTypeID") Is Nothing Then
                                HttpContext.Current.Session.Remove("ScheduleTypeID")
                            End If
                            'End Of Modifications

                            ''Added by Manishk on 10th Jan 06 to add Deliverable link on Help desk, Issues, Change management
                            Dim strScript As String = ""
                            If CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper <> "PM" And CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode")).ToUpper = "ADD_NEW" And CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), "")).ToUpper <> "SAVE" Then
                                strScript = "<script language = javascript>" + vbCrLf
                                strScript += "var objTitle = GetObjectReference('frmCommonPage','Title');" + vbCrLf
                                strScript += "var objDescription = GetObjectReference('frmCommonPage','Description');" + vbCrLf
                                strScript += "var objStartDate = GetObjectReference('frmCommonPage','FFE29587WHIZ_StartDate');" + vbCrLf
                                If CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper = "CRM" Then
                                    strScript += "objTitle.value=window.opener.frmRequestDetails.txtSubject.value;" + vbCrLf
                                    strScript += "objDescription.value=window.opener.frmRequestDetails.txtDescription.value;" + vbCrLf
                                    strScript += "objStartDate.value=window.opener.frmRequestDetails.FFE29587WHIZ_txtResolutionDate.value;" + vbCrLf
                                    strScript += "objStartDate.focus();" + vbCrLf
                                End If

                                If CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper = "IB" Then
                                    strScript += "objTitle.value=window.opener.frmIBIssueEntry.Summary.value;" + vbCrLf
                                    strScript += "objDescription.value=window.opener.frmIBIssueEntry.Description.value;" + vbCrLf
                                    strScript += "objStartDate.value=window.opener.frmIBIssueEntry.FFE29587WHIZ_ReportedDate.value;" + vbCrLf
                                    strScript += "objStartDate.focus();" + vbCrLf
                                End If
                                If CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper = "PMCM" Then
                                    strScript += "objTitle.value=window.opener.frmCommonPage.ChangeRequestSummary.value;" + vbCrLf
                                    strScript += "objDescription.value=window.opener.frmCommonPage.ChangeRequestDescription.value;" + vbCrLf
                                    strScript += "objStartDate.value=window.opener.frmCommonPage.FFE29587WHIZ_ChangeRequestDate.value;" + vbCrLf
                                    strScript += "objStartDate.focus();" + vbCrLf
                                End If
                                strScript += "</script>" + vbCrLf
                                CommonFunction.General.WriteHTML(strScript)
                            End If
                            If CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper <> "PM" And CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), "")).ToUpper = "SAVE" Then
                                ' Dim strScheduleID As String = CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ScheduleID_PK"), ""))
                                strScript = "<script language = javascript>" + vbCrLf
                                strScript += "var objfrm = GetObjectReference('frmCommonPage','Title');"
                                If CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper = "IB" Then
                                    strScript += "if(window.opener.frmIBIssueEntry.txtDeliverableName.value==''){"
                                    strScript += "window.opener.frmIBIssueEntry.txtDeliverableName.value=objfrm.value;" + vbCrLf
                                    strScript += "window.opener.frmIBIssueEntry.DeliverableID.value='" + strPrimaryKey + "';}" + vbCrLf

                                ElseIf CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper = "CRM" Then
                                    strScript += "if(window.opener.frmRequestDetails.txtDeliverableName.value==''){"
                                    strScript += "window.opener.frmRequestDetails.txtDeliverableName.value=objfrm.value;" + vbCrLf
                                    strScript += "window.opener.frmRequestDetails.DeliverableID.value='" + strPrimaryKey + "';}" + vbCrLf

                                ElseIf CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper = "PMCM" Then
                                    strScript += "if(window.opener.frmCommonPage.NonDatabase1.value==''){"
                                    strScript += "window.opener.frmCommonPage.NonDatabase1.value=objfrm.value;" + vbCrLf
                                    strScript += "window.opener.frmCommonPage.DeliverableID.value='" + strPrimaryKey + "';}" + vbCrLf
                                    'strScript += "window.opener.close();" + vbCrLf
                                End If
                                strScript += "window.close();" + vbCrLf
                                strScript += "</script>" + vbCrLf
                                CommonFunction.General.WriteHTML(strScript)
                            End If
                            ''End of Added by Manishk on 10th Jan 06 to add Deliverable link on Help desk, Issues, Change management 


                            ' Added By VivekP on 5 May 2005 for WhizibleSEM SP3 Copy Sub Project Functionality Functionality
                        Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS
                            Dim COPYDATA As String
                            Dim UniqueID As Integer = 0
                            Dim strTobeInserted As String
                            COPYDATA = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("COPYDATA"), ""), String)
                            UniqueID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UNIQUEID"), "0"), Integer)

                            If COPYDATA <> "" And UniqueID <> 0 Then
                                strTobeInserted = CommonFunction.CopyData.CopyData(CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS, UniqueID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                PageUIPostRender = strTobeInserted
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If
                            'End of Addition On 5 May 2005 for WhizibleSEM SP3 Copy Sub Project Functionality Functionality

                            'Code Added By VidyaJ on 17th jan 2005
                            'For issue ID - 15428
                            'Do not allow to publish template if
                            'i. No active activities are associated to it
                            'ii. If a review task has not review type associated to it
                        Case CommonFunction.Constants.APP_TAG_PROCESS_PHASETASK_TEMPLATE_PUBLISH
                            Dim intTemplateID As Integer
                            PageUIPostRender = ""
                            intTemplateID = CType(HttpContext.Current.Request.QueryString("TemplateID"), Integer)

                            If intTemplateID <> 0 Then

                                Dim drTemplate As IDataReader
                                Dim strMessage As String
                                strMessage = ""
                                drTemplate = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_AllowPublishTemplate " + CType(intTemplateID, String), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If (drTemplate.Read) Then
                                    strMessage = CommonFunction.General.CheckIsNothing(drTemplate("AllowPublish").ToString)

                                End If
                                CommonFunction.Data.DisposeDataReader(drTemplate)
                                If strMessage <> "" Then
                                    PageUIPostRender += " alert('" + strMessage + "');"
                                    PageUIPostRender += vbCrLf + "window.close();"
                                    strActionCode = ReturnCodes.ON_LOAD.ToString
                                End If
                            End If

                            ' Added By NitinVS on 24 March 2005 for WhizibleE SP2 
                            ' IssueID 16936 
                            ' Email : Email page is opened, But it does not recieve Focus. It should be open the Discussion thread page.
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLE_DISCUSSION_THREAD

                            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")) = "SAVE" Then
                                'On saving the Form do not set focus on any of the control 
                                PageUIPostRender = vbCrLf + "var objCtrl = GetObjectReference('frmCommonPage','Comments'); if (objCtrl!= null){objCtrl.focus=false}"
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If

                            ' End Addition By NitinVS on 24 Mar 2005 for WhizibleE SP2 IssueID 16936

                            ' Added By NitinVS on 4 May 2005 for WhizibleSEM SP3 Copy Module Functionality

                        Case CommonFunction.Constants.APP_TAG_MODULES
                            Dim COPYDATA As String
                            Dim UniqueID As Integer = 0
                            Dim strTobeInserted As String
                            COPYDATA = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("COPYDATA"), ""), String)
                            UniqueID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UNIQUEID"), "0"), Integer)

                            If COPYDATA <> "" And UniqueID <> 0 Then
                                strTobeInserted = CommonFunction.CopyData.CopyData(CommonFunction.Constants.APP_TAG_MODULES, UniqueID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                PageUIPostRender = strTobeInserted
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If
                            ' End Addition By NitinVS on 4 May 2005  for WhizibleSEM SP3 Copy Module Functionality


                            ' Added By VivekP on 5 May 2005 for WhizibleSEM SP3 Copy Sub Project Functionality Functionality
                        Case CommonFunction.Constants.APP_TAG_SUB_PROJECTS
                            Dim COPYDATA As String
                            Dim UniqueID As Integer = 0
                            Dim strTobeInserted As String
                            COPYDATA = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("COPYDATA"), ""), String)
                            UniqueID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UNIQUEID"), "0"), Integer)

                            If COPYDATA <> "" And UniqueID <> 0 Then
                                strTobeInserted = CommonFunction.CopyData.CopyData(CommonFunction.Constants.APP_TAG_SUB_PROJECTS, UniqueID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                PageUIPostRender = strTobeInserted
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If
                            ' End Addition By VivekP on 5 May 2005  for WhizibleSEM SP3 Copy Module Functionality
                            'Integrated by SandipL SP8 to SP9
                            'Added by SrikanthY on 16 Jan 2007 To disable customer combo in case no department exposed to customer on OnBahalfof customer/employee page
                        Case CommonFunction.Constants.APP_TAG_SELECT_REQUEST_CATEGORY
                            If CType(HttpContext.Current.Request.QueryString("ExposeCust"), Double) = 0 Then
                                PageUIPostRender = ""
                                PageUIPostRender += vbCrLf + "var objNonDatabase = GetObjectReference(""frmCommonPage"",""NonDatabase1"",true);"
                                PageUIPostRender += vbCrLf + "objNonDatabase[0].disabled=true;"
                                PageUIPostRender += vbCrLf + "if (objNonDatabase[0].disabled==true)"
                                PageUIPostRender += vbCrLf + "{"
                                PageUIPostRender += vbCrLf + "objNonDatabase[0].focus=false;"
                                PageUIPostRender += vbCrLf + "}"
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If
                            'End of Addition by SrikanthY
                            'End Integration by SandipL SP8 to SP9


                    End Select
                Else
                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_TAG_TAB_SKILLS
                            'Modified By NitinVS on 18 Apr 2007 for WhizibleSEM SP 8 Regression Issue 12564 
                            Dim sbScript As New System.Text.StringBuilder

                            'PageUIPostRender = vbCrLf + "var objProficiency = GetObjectReference('frmCommonPage', 'Proficiency');"
                            'PageUIPostRender += vbCrLf + "var objHasCoreCompetency = GetObjectReference('frmCommonPage', 'HasCoreCompetency');"
                            'PageUIPostRender += vbCrLf + "if (objProficiency.value == '41') {objHasCoreCompetency.disabled = false;}"
                            'PageUIPostRender += vbCrLf + "else {objHasCoreCompetency.disabled=true;}"
                            sbScript.Append(vbCrLf + " var objProficiency = GetObjectReference('frmCommonPage', 'Proficiency');")
                            sbScript.Append(vbCrLf + " var objHasCoreCompetency = GetObjectReference('frmCommonPage', 'HasCoreCompetency');")
                            sbScript.Append(vbCrLf + " if ( objProficiency != null && objHasCoreCompetency != null ) { ")
                            'Comment and Modification by SuchitraP on 9-Dec-2008 for RDM changes
                            'sbScript.Append(vbCrLf + " if (objProficiency.value == '41') {objHasCoreCompetency.disabled = false;}")
                            sbScript.Append(vbCrLf + " if (objProficiency.value != '') {objHasCoreCompetency.disabled = false;}")
                            'End of Comment and Modification by SuchitraP on 9-Dec-2008
                            sbScript.Append(vbCrLf + " else {objHasCoreCompetency.disabled=true;}")
                            sbScript.Append(vbCrLf + " }")
                            PageUIPostRender = sbScript.ToString()
                            'End Modification By NitinVS  on 18 Apr 2007 for WhizibleSEM SP 8 Regression Issue 12564 
                            strActionCode = ReturnCodes.ON_LOAD.ToString
                            'Added By NileshD on 29 July 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_TAX_DETAILS
                            Dim strTaxID As String
                            Dim strScript As String
                            If strPrimaryKey <> "" Then
                                'select the index for tax combo and also populate formula and percentage
                                strTaxID = CommonFunction.Data.GetDataScalar("SELECT TaxID FROM tbl_PM_RFITypes_TaxDetails WHERE RFITypeTaxID = " + strPrimaryKey, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                                strScript += "var objTax = GetObjectReference('frmCommonPage','TaxID');" + vbCrLf
                                strScript += "objTax.value = " + strTaxID + ";" + vbCrLf
                                strScript += "objAttribute = GetObjectReference('frmCommonPage', 'NonDatabase1');" + vbCrLf
                                strScript += "ObjFormula = GetObjectReference('frmCommonPage', 'NonDatabase2');" + vbCrLf
                                strScript += "ObjTaxPercentage = GetObjectReference('frmCommonPage', 'NonDatabase3');" + vbCrLf
                                strScript += "objAttribute.selectedIndex = objTax.selectedIndex;" + vbCrLf
                                strScript += "ObjFormula.value = objAttribute.options(objAttribute.selectedIndex).innerText;" + vbCrLf
                                strScript += "ObjTaxPercentage.value = objAttribute.value;" + vbCrLf
                                PageUIPostRender = strScript
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If
                            'End Of Addition
                    End Select
                End If
            End Function

            Public Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As Hashtable, ByRef PrimaryKey As String, Optional ByRef RedirectToCL As Boolean = True) As String
                BeforeSave = ""
                'Application standard return code
                strActionCode = ReturnCodes.DO_NOTHING.ToString

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag Page - Before Save Event
                    Select Case WhizGlobal.TagID

                        'Added By Chakshuta H on 29th-Oct-2015
                        ' By SumitS : On 12th May 2006
                        ' With Ref No : WAF3_GEN_3
                        Case CommonFunction.Constants.TAG_SUB_TENANTS
                            SaveSubTenantInformation(ControlsHashTable, PrimaryKey)
                            strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                        Case CommonFunction.Constants.TAG_TENANTS
                            SaveTenantInformation(ControlsHashTable, PrimaryKey)
                            strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                            'Added By NileshD on 6th Sep 2005 ReqID-WAF3_PB_8
                        Case 23
                            If PrimaryKey <> "" Then
                                Dim strRoleID As String
                                strRoleID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("SELECT PostID FROM tbl_PM_Employee Where EmployeeID=" + PrimaryKey, True), "0")
                                If strRoleID <> ControlsHashTable.Item("PostID").ToString Then
                                    CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'E',null,null," + PrimaryKey)
                                End If
                            End If
                            'End Of Addition By NileshD on 6th Sep 2005 ReqID-WAF3_PB_8

                            'Ended By Chakshuta H on 29th-Oct-2015

                            'Added By JyotiG
                            'Start_JG_7713_15-Nov-2006
                        Case CommonFunction.Constants.APP_TAG_CORPORATE_PROJECTS
                            If PrimaryKey.Trim <> "" Then
                                Dim strSqlPrjInfo As String
                                Dim drPrjInfo As IDataReader
                                Dim strProjectOver As String
                                strSqlPrjInfo = "Select [Over] from tbl_PM_Project where ProjectID =" + PrimaryKey.Trim
                                drPrjInfo = CommonFunction.Data.GetDataReader(strSqlPrjInfo, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drPrjInfo.Read Then
                                    strProjectOver = CType(CommonFunction.Data.CheckIsDBNull(drPrjInfo("Over"), "False"), String)
                                End If
                                CommonFunction.Data.DisposeDataReader(drPrjInfo)
                                HttpContext.Current.Session.Add("strIsOver", strProjectOver)
                            End If
                            'End_JG_7713_15-Nov-2006
                            'Added By MahendraV On 6:05 PM 7/23/2007 For WhizibleSEM 7.0
                            ' IssueID(14274) : Deliverable Type : After adding Code Template, make any of the deliverable field applicable & save. After saving the record, previously added Code Template becomes disappear.
                            ' Start_MV_7/23/2007
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLE_CODE_DEFINITION
                            Dim strUpdateQuery As String
                            Dim strCodeTemplate As String
                            strCodeTemplate = HttpContext.Current.Request.Form("CodeTemplate")
                            If strCodeTemplate <> "" Then
                                strCodeTemplate = strCodeTemplate.Replace("'", "''")
                            End If

                            strUpdateQuery = "UPDATE tbl_PM_CompanySchedules SET CodeTemplate='" + strCodeTemplate + "' WHERE ScheduleID = " + HttpContext.Current.Request.Form("ScheduleID_PK")
                            CommonFunctions.Data.InsertOrUpdateData(strUpdateQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            ' End_MV_7/23/2007
                            'Added By JyotiG
                            'Start_JG_11488_15-Mar-2007
                            'Issue Details: 1. Go to Project -- >project Deliverables 2. Open a record in Edit Mode 3. click on Discussion Thread link 4. Post DT 
                            ' Actual Result : Issue 1 : From and To fields are comming blank Issue 2: In mail message <Sender Name> placeholder gets displayed Issue 3: Postion of mail window is not at centre. 


                        Case CommonFunction.Constants.APP_TAG_DELIVERABLE_DISCUSSION_THREAD
                            Dim strDiscussionID As String
                            Dim strSqlDiscussion As String
                            Dim strShowToCust As String
                            Dim strShow As String
                            strShowToCust = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("ShowToCustomer"), "off").ToString
                            If strShowToCust.ToUpper = "ON" Then
                                strShow = "1"
                            Else
                                strShow = "0"
                            End If
                            strSqlDiscussion = "usp_Ins_tbl_Deliverable_Discussions " + HttpContext.Current.Request("ScheduleID").ToString + ",'" + CommonFunction.General.BuildQueryString(WhizGlobal.UserName.ToString) + "','" + CommonFunction.General.BuildQueryString(HttpContext.Current.Request("Comments").ToString) + "'," + strShow
                            strDiscussionID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSqlDiscussion, True), "0")
                            Dim strScript As String
                            strScript = "<script language = javascript>" + vbCrLf
                            If ControlsHashTable("ShowToCustomer").ToString.ToUpper = "ON" Then
                                strScript += "window.open('SendEmail.aspx?MessageID=438&DiscussionID=" + strDiscussionID + "&ScheduleID=" + HttpContext.Current.Request("ScheduleID").ToString + "&Show=1',null,'status=no,toolbar=no,menubar=no,width=600,height=500');" + vbCrLf
                            Else
                                strScript += "window.open('SendEmail.aspx?MessageID=438&DiscussionID=" + strDiscussionID + "&ScheduleID=" + HttpContext.Current.Request("ScheduleID").ToString + "&Show=0',null,'status=no,toolbar=no,menubar=no,width=600,height=500');" + vbCrLf
                            End If
                            strScript += "</script>"
                            CommonFunction.General.WriteHTML(strScript)

                            strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                            'End_JG_11488_15-Mar-2007
                        Case CommonFunction.Constants.APP_TAG_RFI_CHANGE_STATUS
                            Dim strScript As String
                            'Start
                            'JyotiG
                            'Issue Id : 6197
                            Dim strRFIId As String
                            Dim strUserId As String
                            Dim m_intTagID As String
                            Dim strUserType As String
                            Dim m_MasterTagID As String
                            Dim strPrjId As String
                            Dim strStatus As String

                            m_strToken = HttpContext.Current.Request.Form("txtToken") + ""
                            strRFIId = HttpContext.Current.Request.QueryString("RFIID") & ""
                            strUserId = HttpContext.Current.Session("intUserID").ToString
                            strUserType = HttpContext.Current.Request.QueryString("ChangedBy") & ""
                            strPrjId = ControlsHashTable("ProjectID").ToString
                            ''Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                            strStatus = HttpContext.Current.Request.Form("CurrentRFIStatus") + ""
                            'Added By shraddhaM on 16,Mar 2007 for OTIS IssueId : 6098
                            If strStatus = "Re-Submitted" Then
                                strStatus = "Submitted"
                            End If
                            'End of addition By shraddhaM on 16,Mar 2007 for OTIS IssueId : 6098
                            If strUserType = "Initiator" Then
                                If CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String) + strStatus, m_strToken) = False Or m_strToken = "" Then
                                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("IR/PIR", CType(2044, Long), CType(0, Long), "RFIID", HttpContext.Current.Request.QueryString("RFIID").ToString)

                                    'Token is Invalid now redirect to the Invalid Access Page
                                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                                End If
                            Else
                                'End of addition by MonikaI
                                If strUserType = "Approver" Then
                                    m_MasterTagID = "2074"
                                Else
                                    m_MasterTagID = "2083"
                                End If
                                m_intTagID = "0"
                                If CommonFunctions.Security.Token.ValidateToken(CType(strRFIId, String) + CType(strUserId, String) + CType(m_MasterTagID, String) + CType(m_intTagID, String) + CType(strPrjId, String), m_strToken) = False Or m_strToken = "" Then
                                    'Token is Invalid now redirect to the Invalid Access Page
                                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                                End If
                            End If
                            'End
                            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                        Case CommonFunction.Constants.APP_TAG_CORPORATE_SETTINGS
                            Dim drCompanyInfo As IDataReader
                            If PrimaryKey <> "" Then
                                'Code added by SandipL on 9 Dec 2005 -- IssueID 672 --Call Trigger sp if flags changed 
                                Dim strSQL As String
                                strSQL = "Select Case isnull(BackdatingNoDays,0) when 0 then NULL else BackdatingNoDays end as BackdatingNoDays ,Case isnull(ForwardDatingNoDays,0) when 0 then NULL else ForwardDatingNoDays end  as ForwardDatingNoDays," + vbCrLf
                                strSQL += " case TimesheetWorkflow when 0 then '' else 'on' end  as  TimesheetWorkflow," + vbCrLf
                                'Added by PrashantD on 21 Feb 2007 for Resource Allocation settings are moved on Advanced Setttings.
                                ' For impact, we have set these settings as hidden.
                                'strSQL += " case AllowResourceAllocation when 0 then '' else 'on' end as AllowResourceAllocation ," + vbCrLf
                                strSQL += " case AllowResourceAllocation when 0 then 0 else 1 end as AllowResourceAllocation ," + vbCrLf
                                strSQL += " case AllowLeaveWorkflow when 0 then '' else 'on' end as AllowLeaveWorkflow ," + vbCrLf
                                strSQL += " case IsProjectCreationWorkflowReqd when 0 then '' else 'on' end as IsProjectCreationWorkflowReqd ," + vbCrLf
                                strSQL += " case IncludeIR when 0 then '' else 'on' end as IncludeIR" + vbCrLf
                                'Added by MrugajaB on 6th Jan 2005 for WhizibleSEM 6.0 Build - General
                                'Purpose:For implementing share point style UI
                                strSQL += " ,case UseSharePointUI when 0 then '' else 'on' end as UseSharePointUI" + vbCrLf
                                'End Addition
                                'Added By VidyaJ - IssueID - 3331 - Whiz6.0
                                strSQL += " ,case ExpenseWorkflow when 0 then '' else 'on' end as ExpenseWorkflow " + vbCrLf

                                'Added by ShitalN 
                                strSQL += " ,case AllowResourcePercentage when 0 then '' else 'on' end as AllowResourcePercentage "
                                'End Addition By ShitalN

                                ' Added bY Nitinvs on 28 Jun2007 for WhizibleSEM 7 
                                strSQL += " , case EnableProductExecution when 0 then '' else 'on' end as EnableProductExecution "
                                'End Addition bY Nitinvs on 28 Jun2007 for WhizibleSEM 7 
                                strSQL += " From tbl_PM_CompanyInformation " + vbCrLf
                                drCompanyInfo = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                'Get Activity record details for the resource timesheet
                                Do While drCompanyInfo.Read()

                                    If CType(drCompanyInfo("AllowResourceAllocation"), String) <> CType(ControlsHashTable.Item("AllowResourceAllocation"), String) Then
                                        HttpContext.Current.Session.Add("blnAllowResourceAllocation", 1)
                                    Else
                                        HttpContext.Current.Session.Add("blnAllowResourceAllocation", 0)
                                    End If

                                    If CType(drCompanyInfo("AllowLeaveWorkflow"), String) <> CType(ControlsHashTable.Item("AllowLeaveWorkFlow"), String) Then
                                        HttpContext.Current.Session.Add("blnAllowLeaveWorkflow", 1)
                                    Else
                                        HttpContext.Current.Session.Add("blnAllowLeaveWorkflow", 0)
                                    End If
                                    If CType(drCompanyInfo("IncludeIR"), String) <> CType(ControlsHashTable.Item("IncludeIR"), String) Then
                                        HttpContext.Current.Session.Add("blnIncludeIR", 1)
                                    Else
                                        HttpContext.Current.Session.Add("blnIncludeIR", 0)
                                    End If
                                    If CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("BackdatingNoDays"), ""), String) <> CType(ControlsHashTable.Item("BackdatingNoDays"), String) Then
                                        HttpContext.Current.Session.Add("blnBackdatingNoDays", 1)
                                    Else
                                        HttpContext.Current.Session.Add("blnBackdatingNoDays", 0)
                                    End If
                                    If CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("ForwardDatingNoDays"), ""), String) <> CType(ControlsHashTable.Item("ForwardDatingNoDays"), String) Then
                                        HttpContext.Current.Session.Add("blnForwardDatingNoDays", 1)
                                    Else
                                        HttpContext.Current.Session.Add("blnForwardDatingNoDays", 0)
                                    End If
                                    If CType(drCompanyInfo("IsProjectCreationWorkflowReqd"), String) <> CType(ControlsHashTable.Item("IsProjectCreationWorkflowReqd"), String) Then
                                        HttpContext.Current.Session.Add("blnIsProjectCreationWorkflowReqd", 1)
                                    Else
                                        HttpContext.Current.Session.Add("blnIsProjectCreationWorkflowReqd", 0)
                                    End If
                                    'End addition by SandipL on 9 Dec

                                    'If CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("AllowResourceAllocation"), "0"), String) <> CType(ControlsHashTable.Item("AllowResourceAllocation"), String) Or CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("AllowLeaveWorkflow"), "0"), String) <> CType(ControlsHashTable.Item("AllowLeaveWorkflow"), String) Or CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("IncludeIR"), "0"), String) <> CType(ControlsHashTable.Item("IncludeIR"), String) Then
                                    '    CommonEngines.HashTables.GetHashTableObject.ClearTreeHashTable()

                                    'End If

                                    'Added by MrugajaB on 6th Jan 2005 for WhizibleSEM 6.0 Build - General
                                    'Purpose:For implementing share point style UI
                                    'If CType(drCompanyInfo("UseSharePointUI"), String) <> CType(ControlsHashTable.Item("UseSharepointUI"), String) Then
                                    '    HttpContext.Current.Session.Add("blnUseSharePointUI", 1)
                                    'Else
                                    '    HttpContext.Current.Session.Add("blnUseSharePointUI", 0)
                                    'End If

                                    If CType(ControlsHashTable.Item("UseSharepointUI"), String) = "" Then
                                        HttpContext.Current.Session.Add("blnUseSharePointUI", 0)
                                    ElseIf CType(ControlsHashTable.Item("UseSharepointUI"), String) = "on" Then
                                        HttpContext.Current.Session.Add("blnUseSharePointUI", 1)
                                    End If

                                    'End Addition

                                    'Added By VidyaJ - IssueID - 3331 - Whiz6.0
                                    If CType(ControlsHashTable.Item("ExpenseWorkflow"), String) = "" Then
                                        HttpContext.Current.Session.Add("UseExpenseWorkflow", 0)
                                    ElseIf CType(ControlsHashTable.Item("ExpenseWorkflow"), String) = "on" Then
                                        HttpContext.Current.Session.Add("UseExpenseWorkflow", 1)
                                    End If

                                    'Added by ShitalN
                                    If CType(ControlsHashTable.Item("AllowResourcePercentage"), String) = "" Then
                                        HttpContext.Current.Session.Add("blnAllowResourcePercentage", 0)
                                    ElseIf CType(ControlsHashTable.Item("AllowResourcePercentage"), String) = "on" Then
                                        HttpContext.Current.Session.Add("blnAllowResourcePercentage", 1)
                                    End If
                                    'End of Addition By ShitalN
                                    ' Added bY Nitinvs on 28 Jun2007 for WhizibleSEM 7 
                                    If CType(ControlsHashTable.Item("EnableProductExecution"), String) = "" Then
                                        HttpContext.Current.Session.Add("EnableProductExecution", 0)
                                    ElseIf CType(ControlsHashTable.Item("EnableProductExecution"), String) = "on" Then
                                        HttpContext.Current.Session.Add("EnableProductExecution", 1)
                                    End If
                                    'End Addition bY Nitinvs on 28 Jun2007 for WhizibleSEM 7 
                                    If CType(ControlsHashTable.Item("EnableProjectProfitability"), String) = "" Then
                                        HttpContext.Current.Session.Add("EnableProjectProfitability", 0)
                                    ElseIf CType(ControlsHashTable.Item("EnableProjectProfitability"), String) = "on" Then
                                        HttpContext.Current.Session.Add("EnableProjectProfitability", 1)
                                    End If
                                Loop

                                CommonFunction.Data.DisposeDataReader(drCompanyInfo)

                            End If

                            'End Of Modifications - IssueID : 672
                            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                            'Added By NileshD on 6th Sep 2005 ReqID-WAF3_PB_8
                        Case CommonFunction.Constants.APP_TAG_EMPLOYEE
                            If PrimaryKey <> "" Then
                                Dim strRoleID As String
                                strRoleID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("SELECT PostID FROM tbl_PM_Employee Where EmployeeID=" + PrimaryKey, True), "0")
                                If strRoleID <> ControlsHashTable.Item("PostID").ToString Then
                                    CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'E',null,null," + PrimaryKey)
                                End If

                                ''Added By KapilGK on 22-Nov-2006 for SP8 IssueID 7182
                                'Dim strQuery As String = "select status from tbl_Pm_Employee where EmployeeID = " & PrimaryKey.ToString
                                ''Dim strStatus As Boolean = CBool(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("Status"), "false"))
                                'Dim strStatus As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("Status"), "").ToString
                                'Dim intReportingToCount As Integer

                                'strQuery = " Select IsNull(Count(ReportingTo),0) From tbl_PM_Employee Where status=0 and  ReportingTo=" & PrimaryKey.ToString
                                'intReportingToCount = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, True), "0"))
                                'If strStatus.ToUpper = "ON" And intReportingToCount > 0 Then
                                '    'AfterSave = "window.open(""../HR/HR_ApproverToList.aspx?ApproverID=" & PrimaryKey.ToString & """,""_new"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 700)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=700,height=500"");"
                                '    BeforeSave = "window.open(""../HR/HR_ApproverToList.aspx?ApproverID=" & PrimaryKey.ToString & """,""_new"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 700)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=700,height=500"");"
                                '    'strActionCode = ReturnCodes.ON_LOAD.ToString
                                '    strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                                'End If
                                ''End of Addition By KapilGK - IssueID 7182


                            End If
                            'End Of Addition By NileshD on 6th Sep 2005 ReqID-WAF3_PB_8
                            'End Of Modifications - IssueID : 672


                            '--- Code added by Nilesh on 19 May 2005
                        Case CommonFunction.Constants.APP_TAG_COPY_EXECUTION_TEMPLATE
                            'Code Commented by SandipL on 24 Nov 2005 -Code transfered to XmlHttp.vb to solve server side validation problem 

                            'Dim strTemplateName As String
                            'Dim strTemplateDesctiption As String
                            'Dim strProjectPhaseTaskID As String
                            'Dim strSQLQuery As String

                            'strTemplateName = HttpContext.Current.Request("TemplateName")
                            'strTemplateDesctiption = HttpContext.Current.Request("TemplateDescription")
                            'strProjectPhaseTaskID = HttpContext.Current.Request("NonDatabase1")

                            'strSQLQuery = " Exec usp_Copy_ExecutionTemplate " & strProjectPhaseTaskID & ",'" & strTemplateName & "','" & strTemplateDesctiption & "'"
                            'CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, True)
                            'Dim strScript As String
                            '' AfterSave = "<script language = javascript>"
                            'strScript = " alert('Copied template is in draft mode. Please publish it before using it.');"
                            '' strScript += "opener.location.href='CommonList.aspx?FromWhere=PM&MasterTagId=" & CommonFunction.Constants.APP_TAG_PRACTICE_SELECTION & "';"
                            'strScript += "window.close();"
                            '' strscript += " refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx?FromWhere=PM&MasterTagID=2175',true); " + vbCrLf

                            'strScript += "window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?FromWhere=PM&MasterTagID=2175';" + vbCrLf
                            'strScript += "window.opener.document.forms['frmCommonList'].submit();" + vbCrLf
                            '' AfterSave += "return;"
                            ''AfterSave += "</script>"

                            'BeforeSave = strscript
                            ''CommonFunction.General.WriteHTML(strScript)

                            'End commenting by SandipL on 24 nov 2005

                            RedirectToCL = False

                            strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_SAVE.ToString
                            RedirectToCL = False
                            'integrated by harshada d on 15th of june 2006
                            'Integrated by PrajaktaR on 12th May 2006 for Whizible 6.0.1 IssueID 3736
                            '---Code Added By HarshK on 15/07/2005 for 
                        Case CommonFunction.Constants.APP_TAG_COPY_CHECKLIST
                            'commented by harshada d by harshada d for whizible sem SP7.2 on 11 Aug 2006
                            'Dim strCheckListName As String
                            'Dim strProjectCheckListID As String
                            'Dim strSQLQuery As String

                            'strCheckListName = HttpContext.Current.Request("CheckListShortName")
                            'strProjectCheckListID = HttpContext.Current.Request("NonDatabase1")

                            'strSQLQuery = " Exec usp_Copy_CheckList " & strProjectCheckListID & ",'" & strCheckListName & "'"
                            'CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, True)
                            ''Dim strScript As String
                            ''strScript = " alert('Copied checklist is in draft mode. Please publish it before using it.');"
                            ''strScript += "window.close();"
                            ''strScript += "window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?FromWhere=PM&MasterTagID=2263';" + vbCrLf
                            ''strScript += "window.opener.document.forms['frmCommonList'].submit();" + vbCrLf

                            'BeforeSave = strscript
                            'end of commentation by harshada d 

                            RedirectToCL = False

                            strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_SAVE.ToString
                            RedirectToCL = False
                            '---END Of Code Added By HarshK on 15/07/2005 for 
                            'END Of Integration by PrajaktaR on 12th May 2006 for Whizible 6.0.1 IssueID 3736
                            'end of integration by harshada d on 15th june 2006
                        Case CommonFunction.Constants.APP_TAG_PROJECT_RELEASES
                            'Added by paresh b on September 10, 2004 For Project Releases
                            Dim strSQL As String
                            Dim drFixedRelease As IDataReader
                            Dim drProjectDates As IDataReader

                            Dim dtProjectStartDate As Date, dtReleaseFromdate As Date
                            Dim dtProjectEndDate As Date, dtReleaseToDate As Date

                            Dim objAppResource As WebPages.Template.WhizTemplate
                            objAppResource = New WebPages.Template.WhizTemplate
                            objAppResource.InitializeResources("AppResources.EventHandlers", "AppResources")

                            strSQL = "usp_Sel_tbl_PM_Project " & ControlsHashTable("ProjectID").ToString

                            drProjectDates = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If drProjectDates.Read Then
                                dtProjectStartDate = CDate(drProjectDates("ExpectedStartDate").ToString)
                                dtProjectEndDate = CDate(drProjectDates("ExpectedEndDate").ToString)
                            End If
                            ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                            CommonFunction.Data.DisposeDataReader(drProjectDates)
                            'drProjectDates = Nothing
                            ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745


                            dtReleaseFromdate = CDate(ControlsHashTable("ReleaseFromDate").ToString)
                            dtReleaseToDate = CDate(ControlsHashTable("ReleaseToDate").ToString)

                            'Release Dates should be in betweeb project dates
                            If DateDiff(DateInterval.Day, dtProjectStartDate, dtReleaseFromdate) < 0 Or DateDiff(DateInterval.Day, dtProjectEndDate, dtReleaseToDate) > 0 Then
                                BeforeSave = "alert('" & objAppResource.GetResourceString("RELEASE_PROJECT_DATES") & "');"
                                strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                                RedirectToCL = False

                            Else

                                If ControlsHashTable("ReleaseCategory").ToString = "F" Then
                                    strSQL = "usp_ValidateFixedRelease "
                                    strSQL = strSQL & "@ProjectID=" & HttpContext.Current.Session("intProjectId").ToString
                                    strSQL = strSQL & ",@strFromDate=" & IIf(ControlsHashTable("ReleaseFromDate").ToString = "", "NULL", "'" & ControlsHashTable("ReleaseFromDate").ToString & "'").ToString
                                    strSQL = strSQL & ",@strToDate=" & IIf(ControlsHashTable("ReleaseToDate").ToString = "", "NULL", "'" & ControlsHashTable("ReleaseToDate").ToString & "'").ToString
                                    If PrimaryKey <> "" Then
                                        strSQL = strSQL & ",@intReleaseID=" & PrimaryKey
                                    Else
                                        strSQL = strSQL & ",@intReleaseID=NULL"
                                    End If

                                    drFixedRelease = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    If drFixedRelease.Read = True Then
                                        If drFixedRelease("valid").ToString = "0" Then
                                            BeforeSave = "alert('" & objAppResource.GetResourceString("FIXED_RELEASE_OVERLAP") & "');"
                                            strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                                            RedirectToCL = False
                                        End If
                                    End If
                                    ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                    CommonFunction.Data.DisposeDataReader(drFixedRelease)
                                    ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                End If
                            End If
                        Case CommonFunction.Constants.APP_TAG_TAB_EXPENSES
                            'Added by paresh b on August 24, 2004 For Expenses
                            Dim strSQL As String

                            If PrimaryKey.Trim = "" Then
                                strSQL = "usp_Ins_tbl_PM_Expenses "
                                strSQL = strSQL & "@intProjectID=" & IIf(ControlsHashTable("Projectid").ToString = "", "NULL", ControlsHashTable("Projectid").ToString).ToString
                                strSQL = strSQL & ",@intSubItemID=" & IIf(ControlsHashTable("SubItemID").ToString = "", "NULL", ControlsHashTable("SubItemID").ToString).ToString
                                strSQL = strSQL & ",@dtmEntryDate=" & IIf(ControlsHashTable("EntryDate").ToString = "", "NULL", "'" & ControlsHashTable("EntryDate").ToString & "'").ToString
                                strSQL = strSQL & ",@fltAmount=" & IIf(ControlsHashTable("Amount").ToString = "", "NULL", ControlsHashTable("Amount").ToString).ToString
                                strSQL = strSQL & ",@intEmployeeID=" & WhizGlobal.UserID
                                strSQL = strSQL & ",@strDescription=NULL "
                                strSQL = strSQL & ",@strPaymentMode=" & IIf(ControlsHashTable("PaymentMode").ToString = "", "NULL", ControlsHashTable("PaymentMode").ToString).ToString
                                strSQL = strSQL & ",@IsRequest=1"
                                strSQL = strSQL & ",@intDepartmentID=" & IIf(ControlsHashTable("DepartmentId").ToString = "", "NULL", ControlsHashTable("DepartmentId").ToString).ToString
                            Else
                                strSQL = "usp_Upd_tbl_PM_Expenses "
                                strSQL = strSQL & "@dtmEntryDate=" & IIf(ControlsHashTable("EntryDate").ToString = "", "NULL", "'" & ControlsHashTable("EntryDate").ToString & "'").ToString
                                strSQL = strSQL & ",@fltAmount=" & IIf(ControlsHashTable("Amount").ToString = "", "NULL", ControlsHashTable("Amount").ToString).ToString
                                strSQL = strSQL & ",@intEmployeeID=" & WhizGlobal.UserID
                                strSQL = strSQL & ",@strDescription=NULL "
                                strSQL = strSQL & ",@strPaymentMode=" & IIf(ControlsHashTable("PaymentMode").ToString = "", "NULL", ControlsHashTable("PaymentMode").ToString).ToString
                                strSQL = strSQL & ",@IsRequest=1"
                                strSQL = strSQL & ",@intExpenseEntryID =" & IIf(PrimaryKey.ToString = "", "NULL", PrimaryKey).ToString
                                strSQL = strSQL & ",@intDepartmentID=" & IIf(ControlsHashTable("DepartmentId").ToString = "", "NULL", ControlsHashTable("DepartmentId").ToString).ToString
                                strSQL = strSQL & ",@intSubItemID=" & IIf(ControlsHashTable("SubItemID").ToString = "", "NULL", ControlsHashTable("SubItemID").ToString).ToString
                            End If

                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            strActionCode = ReturnCodes.IGNORE_SAVE.ToString


                        Case CommonFunction.Constants.APP_TAG_TAB_RATE_CONTRACT
                            'Added By paresh bhatewara for rate contract by resource page on Aug 04, 04
                            Dim strSQL As String
                            strSQL = "usp_Upd_tbl_PM_WorkOrderRateContract "
                            strSQL = strSQL & "@CeilingAmount=" & IIf(ControlsHashTable("CeilingAmount").ToString = "", "NULL", ControlsHashTable("CeilingAmount").ToString).ToString
                            strSQL = strSQL & ",@ContractValidityDate=" & IIf(CommonFunction.General.CheckIsNothing(ControlsHashTable("ContractValidityDate"), "").ToString = "", "NULL", "'" & CommonFunction.General.CheckIsNothing(ControlsHashTable("ContractValidityDate"), "").ToString & "'").ToString
                            strSQL = strSQL & ",@Escalation=" & IIf(CommonFunction.General.CheckIsNothing(ControlsHashTable("EscalationPercent"), "").ToString = "", "NULL", CommonFunction.General.CheckIsNothing(ControlsHashTable("EscalationPercent"), "").ToString).ToString
                            strSQL = strSQL & ",@OvertimeMultiFactor=" & IIf(CommonFunction.General.CheckIsNothing(ControlsHashTable("OvertimeMultiFactor"), "").ToString = "", "NULL", CommonFunction.General.CheckIsNothing(ControlsHashTable("OvertimeMultiFactor"), "").ToString).ToString
                            strSQL = strSQL & ",@BasisOfRate=" & IIf(CommonFunction.General.CheckIsNothing(ControlsHashTable("BasisOfRate"), "").ToString = "", "NULL", "'" & CommonFunction.General.CheckIsNothing(ControlsHashTable("BasisOfRate"), "").ToString & "'").ToString
                            strSQL = strSQL & ",@RateMethod=" & IIf(CommonFunction.General.CheckIsNothing(ControlsHashTable("RateMethod"), "").ToString = "", "NULL", "'" & CommonFunction.General.CheckIsNothing(ControlsHashTable("RateMethod"), "").ToString & "'").ToString
                            strSQL = strSQL & ",@ProjectID=" & HttpContext.Current.Session("intProjectId").ToString
                            'Commented and Modified by JyotiG
                            'Start_JG_12445_02-Apr-2007
                            'Issue : 1. login by a user who has a space in his username. eg:- 'Tst Res'
                            '2. Go to Project -> Project Information.
                            '3. Click on the link 'T&M by Resource' / 'T&M by Role'.
                            '4. Click on save link.
                            '5. Page crashes.
                            'strSQL = strSQL & ",@CreatedBy=" & HttpContext.Current.Session("strUserName").ToString
                            strSQL = strSQL & ",@CreatedBy='" & HttpContext.Current.Session("strUserName").ToString & "'"
                            'End_JG_12445_02-Apr-2007
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                        Case CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_EMPLOYEE
                            BeforeSave = SaveEmployeeLoginInformation(ControlsHashTable, PrimaryKey)
                            strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                        Case CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_CUSTOMER
                            BeforeSave = SaveCustomerLoginInformation(ControlsHashTable, PrimaryKey)
                            strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                        Case CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_CUSTOMER_CREATED
                            BeforeSave = SaveCustomerCreatedLoginInformation(ControlsHashTable, PrimaryKey)
                            If BeforeSave.Trim <> "" Then RedirectToCL = False
                            strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                        Case CommonFunction.Constants.APP_TAG_REVISION_DETAILS
                            Dim strSQL As String
                            'Insert the Published list in the Publish table and remove from the Draft table
                            CommonFunctions.Data.InsertOrUpdateData("usp_Ins_tbl_PRS_Checklists_PublishChecklist " + ControlsHashTable("ChecklistID").ToString, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            'Update the Revision Details
                            strSQL = "usp_Ins_tbl_PRS_Checklists_RevisionDetails " + ControlsHashTable("ChecklistID").ToString + ", '" + ControlsHashTable("Reason").ToString + "', '" + ControlsHashTable("RevisionDetails").ToString + "', '" _
                                     + ControlsHashTable("RevisedBy").ToString + "', '" + ControlsHashTable("RevisedOn").ToString + "', Null, Null, '" + ControlsHashTable("ApprovedBy").ToString + "', '" + ControlsHashTable("ApprovedOn").ToString + "'"
                            CommonFunctions.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                            RedirectToCL = False

                            '------------------Commented out by AbhijeetD on 25th May------------------
                        Case CommonFunction.Constants.APP_TAG_CREATE_PROJECT
                            Dim strSQL As String
                            Dim strLocationID As String
                            Dim strBusinessGroup As String
                            Dim intCreatePrjGroup As Integer
                            Dim strProjectGroup As String
                            Dim strCustomer As String
                            Dim strProjectLCV As String
                            Dim intBillable As Integer
                            Dim drJobCode As IDataReader


                            If Not CommonFunction.Data.CheckIsDBNull(ControlsHashTable("LocationID")).ToString = "" Then
                                strLocationID = ControlsHashTable("LocationID").ToString
                            Else
                                strLocationID = "NULL"
                            End If
                            If Not CommonFunction.Data.CheckIsDBNull(ControlsHashTable("BusinessGroupID")).ToString = "" Then
                                strBusinessGroup = ControlsHashTable("BusinessGroupID").ToString
                            Else
                                strBusinessGroup = "NULL"
                            End If

                            'Code commented by MrugajaB on 29th Dec 2005
                            'Purpose:This code is return below
                            'If Not CommonFunction.Data.CheckIsDBNull(ControlsHashTable("ContractValue")).ToString = "" Then
                            'strProjectLCV = ControlsHashTable("ContractValue").ToString
                            'Else
                            '    strProjectLCV = "NULL"
                            'End If
                            'End Modification

                            'If CommonFunction.Data.CheckIsDBNull(ControlsHashTable("CreateProjectGroup")).ToString = "" Then
                            intCreatePrjGroup = 0
                            'Else
                            '   intCreatePrjGroup = 1
                            'End If
                            If Not CommonFunction.Data.CheckIsDBNull(ControlsHashTable("ProjectGroupID")).ToString = "" Then
                                strProjectGroup = ControlsHashTable("ProjectGroupID").ToString
                            Else
                                strProjectGroup = "NULL"
                            End If
                            If Not CommonFunction.Data.CheckIsDBNull(ControlsHashTable("CustomerID")).ToString = "" Then
                                strCustomer = ControlsHashTable("CustomerID").ToString
                            Else
                                strCustomer = "NULL"
                            End If
                            'Modified by MrugajaB on 29th Dec 2005
                            'Purpose:- Page was getting crashed if space character is entered in 'prject Value' Textbox ,trim was not used
                            If Not Trim(CommonFunction.Data.CheckIsDBNull(ControlsHashTable("ContractValue")).ToString) = "" Then
                                strProjectLCV = ControlsHashTable("ContractValue").ToString
                            Else
                                strProjectLCV = "NULL"
                            End If
                            'End Modification
                            If CommonFunction.Data.CheckIsDBNull(ControlsHashTable("Billable")).ToString = "" Then
                                intBillable = 0
                            Else
                                intBillable = 1
                            End If

                            strSQL = "usp_Sel_PM_GenenrateJobCode " + strLocationID + ", " + strBusinessGroup + ", " + intCreatePrjGroup.ToString + ", " + strProjectGroup + ", " + strCustomer + ", " + strProjectLCV.ToString + ", " + intBillable.ToString
                            drJobCode = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If drJobCode.Read Then
                                If Not CommonFunction.Data.CheckIsDBNull(drJobCode("ErrorCode")).ToString = "0" Then
                                    strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                                Else
                                    strActionCode = ReturnCodes.DO_NOTHING.ToString
                                    HttpContext.Current.Session("strJobCode") = CommonFunction.Data.CheckIsDBNull(drJobCode("JobCode"))
                                    'Added By Paresh B on july 31, 2004
                                    ControlsHashTable("ProjectCode") = CommonFunction.Data.CheckIsDBNull(drJobCode("JobCode"))
                                End If
                                HttpContext.Current.Session("intJobCodeError") = CommonFunction.Data.CheckIsDBNull(drJobCode("ErrorCode")).ToString
                            Else
                                HttpContext.Current.Session("intJobCodeError") = ""
                            End If
                            CommonFunction.Data.DisposeDataReader(drJobCode)
                            '------------------------Commenting Ends----------------------


                            'added by SachinR   on 3 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_SOFTEX_FORM_GENERATION
                            'here details of softext form will be stored and invoices are generated
                            Dim strCustomerID As String
                            Dim strContractID As String
                            Dim strSalesPeriod As String
                            Dim strCompanyID As String
                            Dim strSoftexID As String
                            Dim strSQL As String
                            Dim objDr As IDataReader

                            strCustomerID = HttpContext.Current.Request("CustomerID") + ""
                            strContractID = HttpContext.Current.Request("ContractID") + ""
                            strSalesPeriod = HttpContext.Current.Request("SalesPeriodID") + ""
                            strCompanyID = HttpContext.Current.Request("CompanyID") + ""

                            'added by SachinR   on 26 Aug 2004
                            'Issue - 12577
                            Dim blnSoftexExist As Boolean = False
                            strSQL = "usp_Sel_tbl_PM_SoftexMaster_IsExists "
                            strSQL += strCustomerID.Trim + "," + strContractID.Trim
                            strSQL += "," + strCompanyID.Trim + "," + strSalesPeriod.Trim
                            If CType(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Long) > 0 Then
                                blnSoftexExist = True
                                BeforeSave = "alert('A softex form with the same combination already exists.\r\nPlease select different combination.');"
                                strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                                RedirectToCL = True
                            End If
                            'addition end

                            If blnSoftexExist = False Then
                                strSQL = "usp_tbl_PM_SoftexMaster_AddOrEdit "
                                strSQL += strCustomerID.Trim + "," + strContractID.Trim
                                strSQL += "," + strSalesPeriod.Trim + "," + strCompanyID.Trim
                                objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If objDr.Read Then
                                    If CommonFunction.Data.CheckIsDBNull(objDr("Result"), "").ToString = "1" Then
                                        'HttpContext.Current.Session("FormGenerated") = "NO"
                                        BeforeSave = "alert('Cannot insert the Softex Form since no invoices are defined on it.');"
                                    Else
                                        strSoftexID = CommonFunction.Data.CheckIsDBNull(objDr("SoftexID"), "").ToString
                                    End If
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)
                                strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                                'Added & commented y Dipali V on 23rd March 2020 For Refresh issues
                                RedirectToCL = False
                                ' RedirectToCL = True
                                'End of Added & commented y Dipali V on 23rd March 2020 For Refresh issues
                            End If
                            'addition end

                        Case CommonFunction.Constants.APP_TAG_PM_STAKEHOLDER

                            Dim strName As String
                            Dim strContactCategoryID As String
                            Dim strSQL As String
                            Dim strProjectID As String

                            If Not (ControlsHashTable("Name") Is Nothing) Then
                                If IsNumeric(ControlsHashTable("Name")) Then
                                    Dim dr As System.Data.IDataReader
                                    ControlsHashTable("EmployeeID") = ControlsHashTable("Name")
                                    dr = CommonFunctions.Data.GetDataReader("Select * " & _
                                         " From tbl_PM_Employee " & _
                                         " Where EmployeeID = " & CType(ControlsHashTable("Name"), String), _
                                         True)
                                    If Not (dr Is Nothing) Then
                                        If dr.Read() Then
                                            ControlsHashTable("Name") = dr("EmployeeName")
                                        End If
                                    End If
                                    ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                    CommonFunction.Data.DisposeDataReader(dr)
                                    'dr = Nothing
                                    ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                End If
                            End If

                            strName = CType(ControlsHashTable("Name"), String)
                            strContactCategoryID = CType(ControlsHashTable("ContactCategoryID"), String)
                            strProjectID = CType(ControlsHashTable("ProjectID"), String)

                            strSQL = "  Select  Count(ProjectContactID) "
                            strSQL &= " From tbl_PM_ProjectContacts "
                            strSQL &= " Where ProjectID = " & strProjectID
                            strSQL &= " AND Name = '" & strName & "' "
                            strSQL &= " AND ContactCategoryID = " & strContactCategoryID
                            ' Commented By the Noble K = 7th December 2004 
                            'If CType(CommonFunction.Data.GetSQLDataScalar(strSQL), Integer) > 0 Then

                            'BeforeSave = " alert('Stakeholder already exists'); "

                            ' strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_SAVE.ToString
                            'RedirectToCL = False
                            ' End If

                            'End OF Commented Code.By Noble K

                            'Added by ShamkantD on 7th August 2004 - added to save Fixed Bid details
                        Case CommonFunction.Constants.APP_TAG_PM_FIXED_BID
                            Dim strSQL As String
                            Dim strPriceValidityDate As String
                            Dim dblEscalation As String
                            Dim dblOriginalContractValue As String
                            Dim dblThisRevisionValue As String

                            strPriceValidityDate = HttpContext.Current.Request.Form("PriceValidityDate")

                            If HttpContext.Current.Request.Form("EscalationPercentage") = "" Then
                                dblEscalation = "Null"
                            Else
                                dblEscalation = HttpContext.Current.Request.Form("EscalationPercentage")
                            End If

                            If HttpContext.Current.Request.Form("OriginalContractValue") = "" Then
                                dblOriginalContractValue = "Null"
                            Else
                                dblOriginalContractValue = CType(CType(HttpContext.Current.Request.Form("OriginalContractValue"), Double), String)
                            End If

                            If HttpContext.Current.Request.Form("ThisRevisionValue") = "" Then
                                dblThisRevisionValue = "Null"
                            Else
                                dblThisRevisionValue = HttpContext.Current.Request.Form("ThisRevisionValue")
                            End If

                            strSQL = "EXEC usp_Ins_tbl_PM_WorkOrderLumpSumContract " + _
                             dblOriginalContractValue & "," + _
                             dblThisRevisionValue & ",'" + _
                             strPriceValidityDate & "'," + _
                             dblEscalation & "," + _
                             HttpContext.Current.Session("intProjectID").ToString & ",'" + _
                             HttpContext.Current.Session("strUserName").ToString + "'"

                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                            RedirectToCL = False

                        Case CommonFunction.Constants.APP_TAG_PM_BILLING_ADDRESS
                            Dim strSQL As String
                            Dim strBillingAddress As String

                            strBillingAddress = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("BillingAddress")).ToString

                            strSQL = "EXEC usp_Ins_Upd_tbl_PM_BillingAddress " + _
                             HttpContext.Current.Session("intProjectID").ToString & ",'" + _
                             strBillingAddress + "'"

                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                            RedirectToCL = False
                            'End of addition - ShamkantD on 7th August 2004

                            '##### Cases Added For Resource Timesheet Flow
                        Case CommonFunction.Constants.APP_TAG_RESOURCES
                            'Added By MangeshY For Resource Timesheet Flow
                            'Set the value of IsDefaultApprover of all the employees to 0 if 
                            ' this employee is selected as default approver
                            If HttpContext.Current.Request.Form("IsDefaultApprover") = "on" Then
                                Dim strSQL As String

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
                                'strSQL = "USP_UPD_tbl_PM_ProjectEmployeeRole_DefaultApprover " + CType(HttpContext.Current.Session("intProjectId"), String)
                                strSQL = "USP_UPD_tbl_PM_ProjectEmployeeRole_DefaultApprover " + ProjectID
                                'End of comment and addition by ShraddhaM on 17,Sept 2008

                                CommonFunctions.Data.InsertOrUpdateData(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                '                          strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                                'Modified by ShraddhaM on 16,Mar 2009 
                                'Purpose : From advance search if Default approver is selected page openes in add mode after saving.
                                If PKValue = "" Or PKValue Is Nothing Then
                                    RedirectToCL = False
                                End If

                                'End of modification by ShraddhaM

                            End If

                            'addition end
                            'End Addition

                            '##### End Addition

                            '    'Code Integrated by MrugajaB on 4th May,2005 for WhizibleSEM SP3 Task Progress feature
                            '    'Code added By Pradipk on 23 April 2005
                            '    'Purpose : If Progress Entry radio button is disable then 
                            '    'assign value of ProgressEntry from Database to Hash Table.
                            'Case CommonFunction.Constants.APP_TAG_PROJECT_SETTINGS
                            '    Dim strProgressEntry As String
                            '    Dim strQuery As String
                            '    If ControlsHashTable("ProgressEntry").ToString = "" Then
                            '        strQuery = "SELECT PROGRESSENTRY FROM tbl_PM_Project where Projectid=' " + HttpContext.Current.Session("intProjectID").ToString + " '"
                            '        strProgressEntry = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).tostring, "E").tostring
                            '        ControlsHashTable("ProgressEntry") = strProgressEntry
                            '    End If
                            'End addtion PradipK

                            'Modified by SachinR    on 21 Sep 2004
                            'This code is commented as Phasetask practice is removed and association is removed 
                            'from the project level.
                            '        'added by SachinR   on 10 Aug 2004
                            'Case CommonFunction.Constants.APP_TAG_PROJECT_SETTINGS
                            '        'here check if practice is applied to the project, if not applied then set the flag 
                            '        'in session, check that flag in AfterSave to get the template data from corporate level
                            '        'to project level
                            '        Dim StrSQL As String
                            '        Dim objDr As IDataReader
                            '        strSQL = "usp_Sel_tbl_PM_Project " + HttpContext.Current.Session("intProjectID").ToString
                            '        objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '        If objDr.Read Then
                            '            If CommonFunction.Data.CheckIsDBNull(objDr("PracticeGroupID"), "").tostring <> "" Then
                            '                'if practice applied already then set the flag in session
                            '                HttpContext.Current.Session("PracticeApplied") = "Yes"
                            '            End If
                            '        End If
                            '        CommonFunction.Data.DisposeDataReader(objdr)
                            '        'addition end  
                            'added by DiptiK   on 21 Aug 2004


                        Case CommonFunction.Constants.APP_TAG_ANSWERS
                            Dim strSingle As String
                            Dim objDr As IDataReader
                            Dim StrSQL As String
                            Dim intVal As Integer
                            Dim strScript As String = ""
                            If (CType(HttpContext.Current.Request.Form("AnswerSetID_PK"), String) <> "") Then
                                StrSQL = "select count(IsNegative) as count from tbl_q_answer where answersetid=" & CType(HttpContext.Current.Request.Form("AnswerSetID_PK"), Int16) & " and isnegative=1"
                                objDr = CommonFunction.Data.GetDataReader(StrSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If objDr.Read Then
                                    intVal = CType(objDr("count"), Integer)
                                End If

                                CommonFunction.Data.DisposeDataReader(objDr)
                                'check if the single selection check box is checked or not
                                strSingle = CType(ControlsHashTable("SingleSelection"), String)
                                If (strSingle = "on" And intVal > 0) Then
                                    'strScript = "<script language = javascript>"
                                    'strScript += "alert('There is already a negative response added for single selection. You cannot add more than one.');"
                                    'strScript += "</script>"
                                    'CommonFunction.General.WriteHTML(strScript)
                                    strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                                End If

                                'Multiple Selection case
                                If (strSingle = "" And intVal > 0) Then
                                    strScript = "<script language = javascript>"
                                    strScript += "alert('There cannot be negative response for multiple selection.');"
                                    strScript += "</script>"
                                    CommonFunction.General.WriteHTML(strScript)
                                    strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                                End If
                            End If
                            'addition ends

                            'added by SachinR   on 24 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                            'here if status of the deliverable is changed then send mail for status changed
                            Dim strSQL As String
                            Dim strOldStatus As String
                            Dim strNewStatus As String
                            Dim objDr As IDataReader
                            Dim strScript As String

                            If PrimaryKey <> "" Then
                                strOldStatus = ""
                                strSQL = "usp_sel_tbl_PM_OtherSchedules " + PrimaryKey.Trim
                                objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If objDr.Read Then
                                    strOldStatus = CommonFunction.Data.CheckIsDBNull(objDr("Status"), "").ToString
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)
                                strNewStatus = ""
                                strNewStatus = HttpContext.Current.Request.Form("Status")
                                If strOldStatus <> strNewStatus Then
                                    'status changed, send mail
                                    'set session variable to send mail
                                    HttpContext.Current.Session.Add("DeliverableStatusChanged", "Yes")
                                End If
                            End If
                            'addition end

                            'added by SachinR   on 30 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_DELIVERY_UNIT_ORGANIZATION_STRUCTURE
                            Dim strOUPoolID As String
                            Dim strSQL As String
                            Dim strResourcePoolName As String
                            Dim strResourcePoolCode As String

                            strOUPoolID = HttpContext.Current.Request.Form("OUPoolID") + ""
                            strResourcePoolName = HttpContext.Current.Request.Form("ResourcePoolName") + ""
                            strResourcePoolCode = HttpContext.Current.Request.Form("ResourcePoolCode") + ""


                            strSQL = "usp_Ins_tbl_PM_ResourcePool_OrganizationStructure "
                            strSQL += strOUPoolID.Trim

                            'Modified By ShraddhaM on 12 Sep 2006 for SP7 For IssueID : 6198
                            strSQL += ",'" + CommonFunction.General.BuildQueryString(strResourcePoolName.Trim).ToString + "'"
                            strSQL += ",'" + CommonFunction.General.BuildQueryString(WhizGlobal.UserName.Trim).ToString + "'"
                            If strResourcePoolCode <> "" Then
                                strSQL += ",'" + CommonFunction.General.BuildQueryString(strResourcePoolCode.Trim).ToString + "'"
                            Else
                                strSQL += ",NULL"
                            End If

                            'End of Modification By ShraddhaM on 12 Sep 2006 for SP7 For IssueID : 6198
                            If PrimaryKey <> "" Then
                                strSQL += "," + PrimaryKey.Trim
                            End If
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                            'addition end

                            'added by SachinR   on 1 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_PROCESS_PHASETASK
                            'check if task type is changed then set the flag in the session, check that
                            'that flag after save and update phasetask record 
                            Dim strSQL As String
                            Dim objDr As IDataReader
                            Dim strNewTaskType As String
                            Dim strPrevTaskType As String

                            If PrimaryKey <> "" Then
                                strNewTaskType = HttpContext.Current.Request.Form("TaskType") + ""
                                strPrevTaskType = ""
                                strSQL = "usp_Sel_tbl_PRS_PhaseTask_Draft " + PrimaryKey.Trim
                                objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If objDr.Read Then
                                    strPrevTaskType = CommonFunction.Data.CheckIsDBNull(objDr("TaskType"), "").ToString
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)

                                HttpContext.Current.Session.Add("TaskTypeChanged", "No")
                                If strNewTaskType <> strPrevTaskType Then
                                    strPrevTaskType = HttpContext.Current.Request.Form("NonDatabase1") + ""
                                    If strNewTaskType = strPrevTaskType Then
                                        'set the flag in the session as task type changed and user clicked OK to 
                                        'confirm the change
                                        HttpContext.Current.Session("TaskTypeChanged") = "Yes"
                                    End If
                                End If
                            End If
                            'addition end

                            'Added By JayavantK on 15-Sep-2004
                        Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEAPPLICATION, CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS
                            'Code commented by SandipL on 24 Nov 2005 --Server side Validations done through XMLHttp.vb

                            'Dim strQuery As String = ""
                            'Dim lngEmployeeID As Long = 0
                            'Dim lngLeaveID As Long = 0
                            'Dim strFromDate As String = ""
                            'Dim strToDate As String = ""

                            'If WhizGlobal.TagID = CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEAPPLICATION Then
                            '    lngEmployeeID = WhizGlobal.UserID
                            'ElseIf WhizGlobal.TagID = CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS Then
                            '    lngEmployeeID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("EmployeeID"), "0"), Long)
                            'End If
                            'If PrimaryKey <> "" Then
                            '    lngLeaveID = CType(PrimaryKey, Long)
                            'End If

                            'strFromDate = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("FromDate"), "")
                            'strToDate = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("ToDate"), "")
                            'If strFromDate <> "" And strToDate <> "" Then
                            '    strQuery = "usp_Sel_tbl_PM_EmployeeLeaveDetails_LeavesBetween " & lngEmployeeID.ToString() & "," & lngLeaveID.ToString() & ", '" & strFromDate & "', '" & strToDate & "'"
                            '    If CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "") <> "" Then
                            '        BeforeSave = "alert(""Employee has already applied for leave between '" & strFromDate & "' and '" & strToDate & """);"
                            '        strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                            '        RedirectToCL = False
                            '    End If
                            'End If
                            'End Addition

                            'End commenting by SandipL on 24 Nov 2005

                            '##### Onsite Offshore functionality
                        Case CommonFunction.Constants.APP_TAG_SITE_TRANSFER
                            'Code Added By VidyaJ on 24th Aug 2004
                            Dim strSelectedResources As String
                            Dim intProjectID As Integer
                            Dim strSQL As String
                            Dim intTransferSiteID As Integer
                            Dim strScript As String
                            Dim strRoleID As String
                            Dim strEffectiveDate As String
                            Dim drCheckDuplicateRecord As IDataReader
                            Dim strCount As String
                            Dim blnInsert As Boolean
                            Dim strBillingPercentage As String

                            'Added by SiddharthS on 19 Feb 2005
                            Dim strSQLQuery As String
                            Dim intResult As Integer
                            Dim Query As String
                            'ends.
                            blnInsert = True



                            strSelectedResources = CType(ControlsHashTable("NonDatabase1"), String)

                            'Added  by PrachiK on 5 Mar 2005 FOR IssueID 15848
                            'Purpose:Don't allow transfer if transfer date is less than current date
                            Dim strSelectedResource As String
                            Dim intPos As Integer
                            intPos = InStr(1, strSelectedResources, ",", CompareMethod.Text)
                            'Modified By SnehalV on 21st Sept 2006
                            If intPos <> 0 Then
                                strSelectedResource = Mid(strSelectedResources, 1, intPos - 1)
                            Else
                                strSelectedResource = strSelectedResources
                            End If
                            'Modification ended by snehalv
                            'Addtion ended by prachik

                            intProjectID = CType(HttpContext.Current.Session("intProjectId"), Integer)
                            intTransferSiteID = CType(ControlsHashTable("Name"), Integer)
                            strRoleID = CType(ControlsHashTable("NonDatabase2"), String)
                            strEffectiveDate = CType(ControlsHashTable("CreatedDate"), String)
                            strEffectiveDate = CType(CommonFunctions.Dates.GetDate(CType(strEffectiveDate, Date)), String)
                            strBillingPercentage = CType(ControlsHashTable("NonDatabase3"), String)
                            If CType(strBillingPercentage, String) = "" Then
                                strBillingPercentage = "0"
                            End If
                            If strSelectedResources <> "" Then
                                If Right(strSelectedResources, 1) = "," Then
                                    strSelectedResources = Left(strSelectedResources, Len(strSelectedResources) - 1)
                                End If
                                'Commented by SiddharthS on 8 Apr 2005

                                'strSQL = "SELECT Count(*) as Count From tbl_PM_EmployeeSiteDetails Where ProjectID = " + CType(HttpContext.Current.Session("intProjectID"), String) + " AND StartDate = '" + CType(strEffectiveDate, String) + "' AND EmployeeID IN (" + strSelectedResources + ")  "
                                'drCheckDuplicateRecord = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                'If drCheckDuplicateRecord.Read Then
                                '	strCount = CType(CommonFunctions.Data.CheckIsDBNull(drCheckDuplicateRecord("Count"), "0"), String)
                                '	If strCount <> "0" Then
                                '		blnInsert = False
                                '		strScript = strScript + "alert('Cannot add duplicate record for the same date');"
                                '	End If
                                'End If

                                'End comment

                            End If
                            strSelectedResources = strSelectedResources
                            'Added by SiddharthS on 19 Feb  
                            strSQLQuery = "Select SiteID from tbl_PM_EmployeeSiteDetails where EmployeeID=" + strSelectedResource + "  and ProjectID=" + CType(intProjectID, String) + "and CurrentRecord=1"
                            intResult = CType(CommonFunction.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)
                            'end

                            If blnInsert = True Then
                                'Modified by SiddharthS on 19 Feb 2005 FOR IssueID 15848
                                'Purpose:Don't allow transfer iftransfer date is less than current date
                                'Commented by SiddharthS on 17 Mar 2005 for Issue Id 15848
                                'Dim dt As DateTime = Date.Now
                                'Commented by SiddharthS on 17 Mar 2005 to allow transfer on less than current date. 
                                'If strEffectiveDate < CType(CommonFunctions.Dates.GetDate(CType(dt, Date)), String) Then
                                'strScript = strScript + "alert('The transfer date can not be less than current date');"
                                'Comment ends.
                                'Else
                                'Added  by PrachiK on 5 Mar 2005 FOR IssueID 15848
                                'Purpose:Don't allow transfer if transfer date is less than current date

                                '''''Code Added by SiddharthS on 22 Feb 2005 for IssueID 15842
                                '''''Purpose:The transfer date can not be less than the date on which resource is assigned to the project
                                ''''Dim dtResult As DateTime
                                ''''Dim strResult As String
                                ''''Query = "select ExpectedStartDate from tbl_PM_ProjectEmployeeRole where EmployeeID = " + strSelectedResources + " and ProjectID=" + CType(intProjectID, String)
                                ''''dtResult = CType(CommonFunction.Data.GetDataScalar(Query, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Date)
                                ''''strResult = CType(CommonFunctions.Dates.GetDate(CType(dtResult, Date)), String)
                                '''''End Addition


                                'Commented 8 Apr 
                                'Dim ProjectEndDate As String
                                'strSQL = "select ExpectedStartDate from tbl_PM_ProjectEmployeeRole where EmployeeID in  (" & strSelectedResources & ")  and ProjectID=" & CType(intProjectID, String) '

                                ' Modified by SiddharthS on 8 Apr 2005
                                'strSelectedResource is changed as strSelectedResources 8 Apr 
                                strSQL = "usp_sel_Employees_For_UnsuccessFullTransfer " & intProjectID & " , '" & strSelectedResources & "','" & strEffectiveDate & "'"
                                'End modification.

                                'Added by SiddharthS on 11 Apr 2005 for IssueId 17478
                                'Purpose : To display the alert for unsuccessful transfer.

                                Dim drReader As IDataReader
                                Dim intTransferCount As Integer
                                Dim strUnsuccessfulTransfers As String = ""
                                Dim strReasons As String
                                Dim strQuery As String

                                strReasons = "The employees and reasons for their unsuccessful transfer are specified below :"
                                strReasons += "\n"
                                strReasons += "\n"
                                drReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                strQuery = " usp_checkForUnsusseccfulTransfer " & intProjectID & " , '" & strSelectedResources & "','" & strEffectiveDate & "'"
                                intTransferCount = CType(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)
                                If intTransferCount = 1 Then

                                    'Commented on 8 Apr
                                    'ProjectEndDate = CommonFunction.Dates.GetDate(CType(drReader("ExpectedStartDate"), Date))
                                    'ProjectEndDate = CType(CommonFunctions.Dates.GetDate(CType(ProjectEndDate, Date)), String)
                                    While drReader.Read

                                        strUnsuccessfulTransfers += drReader("EmployeeName").ToString
                                        strUnsuccessfulTransfers += "-"
                                        strUnsuccessfulTransfers += drReader("EmpReason").ToString
                                        strUnsuccessfulTransfers += "\n"
                                        strUnsuccessfulTransfers += "\n"
                                        ' strScript = strScript + "alert('The transfer date can not be less than the date on which resource is assigned to the project(" + ProjectEndDate + ")');"
                                        'end comment
                                    End While
                                    strUnsuccessfulTransfers = strReasons + strUnsuccessfulTransfers
                                    If intTransferCount = 1 Then
                                        strScript = strScript + "alert(""" + strUnsuccessfulTransfers + """);"
                                    End If

                                    'End Addition
                                Else
                                    strSQL = " Exec usp_Ins_ProjectSiteResources  " + CType(intProjectID, String) + "," + CType(intTransferSiteID, String) + ",'" + strSelectedResources + "'," + CType(strRoleID, String) + ",'" + CType(strEffectiveDate, String) + "'," + CType(strBillingPercentage, String)
                                    CommonFunctions.Data.InsertOrUpdateData(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If intResult <> intTransferSiteID Then
                                        strScript = strScript + " alert('Selected Resources Transfered successfully ');"
                                    Else

                                    End If

                                    strScript = strScript + "window.opener.location.href = 'CommonList.aspx?FromWhere=PM&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_EMPLOYEESITEDETAILS, String) + "';"
                                    strScript = strScript + " window.close(); "
                                    'End If
                                End If
                                CommonFunction.Data.DisposeDataReader(drReader)


                                '''''    'Code modified by SiddharthS 22 Feb 2005 for IssueID 15842
                                '''''    If CType(strEffectiveDate, Date) < dtResult Then
                                '''''        strScript = strScript + "alert('The transfer date can not be less than the date on which resource is assigned to the project(" + strResult + ")'); "
                                '''''    Else
                                '''''        'End modification.
                                '''''        strSQL = " Exec usp_Ins_ProjectSiteResources  " + CType(intProjectID, String) + "," + CType(intTransferSiteID, String) + ",'" + strSelectedResources + "'," + CType(strRoleID, String) + ",'" + CType(strEffectiveDate, String) + "'," + CType(strBillingPercentage, String)
                                '''''        CommonFunctions.Data.InsertOrUpdateData(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                '''''        If intResult <> intTransferSiteID Then
                                '''''            strScript = strScript + " alert('Selected Resources Transfered successfully ');"
                                '''''        Else

                                '''''        End If
                                '''''        'strScript = strScript + " alert('Selected Resources Transfered successfully ');"
                                '''''        strScript = strScript + "window.opener.location.href = 'CommonList.aspx?FromWhere=PM&MasterTagId=" + CType(CommonFunction.Constants.APP_TAG_EMPLOYEESITEDETAILS, String) + "';"
                                '''''        strScript = strScript + " window.close(); "
                                '''''    End If
                                'End If
                                '''''Modification ends.
                                'Addtion ended by  prachi
                            End If
                            BeforeSave = strScript
                            ' CommonFunction.General.WriteHTML(strScript)

                            strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_SAVE.ToString
                            RedirectToCL = False

                            'Added By AmitD on 29 Oct 2004
                            'Case CommonFunction.Constants.APP_TAG_REVIEW_PLANNING
                            'ControlsHashTable("NONDATABASE7") = HttpContext.Current.Request.Form("txtHidDeliverableID")
                            'End Addition
                            'Added By Santosh Pawar on 30-Nov-2004
                        Case CommonFunction.Constants.APP_TAG_PM_STAKEHOLDER


                            '    'Added By SantoshK on 28th APril 2005 - Copy Template
                            'Case CommonFunction.Constants.APP_TAG_COPY_TEMPLATE


                            '    strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                            '    RedirectToCL = False

                            '    'Addition Ends - SantoshK 28th April 2005


                        Case CommonFunction.Constants.APP_TAG_REVIEWS
                            'Added by MrugajaB on 23rd Feb 2006 for Multiple reviewees feature (Issue ID.1835)
                            'Purpose: If Review work hrs changed then add variable in session
                            Dim strSQL As String
                            Dim drEfforts As IDataReader
                            Dim strScript As String

                            If PrimaryKey <> "" Then
                                If CType(ControlsHashTable.Item("NonDatabase15"), Double) <> CType(ControlsHashTable.Item("ReviewEffort"), Double) Then
                                    HttpContext.Current.Session.Add("ReviewHrsChanged", 1)
                                Else
                                    HttpContext.Current.Session.Add("ReviewHrsChanged", 0)
                                End If

                            End If
                            '    'End Addition

                            '----------------------------------------------------------------------------------------
                            '--Coded added by SajiU on 5th Dec 2006
                        Case CommonFunction.Constants.App_Tag_Login_Maintenance
                            BeforeSave = SaveEmployeeLoginInformationINDetail(ControlsHashTable, PrimaryKey)
                            strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                            'Addition Ends - SajiU on 5th Dec 2006
                            '--------------------------------------------------------------------------------------------
                            'Added by ShraddhaM on 11,Jul 2008
                            'Purpose : To integrate Risk Registration from Whizible 2007 
                        Case CommonFunction.Constants.APP_TAG_P12PROJECT_RISK_REGISTER

                            Dim intMessageID As Integer
                            Dim strMailTo As String = ""
                            Dim strFromMail As String = ""
                            Dim strMailCC As String = ""
                            Dim strSubject As String = ""
                            Dim strMessage As String = ""
                            Dim drEmailMessage As IDataReader
                            Dim lngProjectId As Long
                            Dim strSQL, strRisk As String
                            Dim drRiskID As IDataReader
                            Dim intRiskID As Integer
                            Dim blnSendEmail As Boolean
                            Dim blnShowPopup As Boolean

                            Dim intOldCostOpportunity As String
                            Dim intnNewCostOpportunity As String
                            Dim intOldSizeOppurtunity As String
                            Dim intNewSizeOppurtunity As String
                            Dim OldOppurtunityStatus As String
                            Dim NewOppurtunityStatus As String
                            Dim OldAssignedTo As String
                            Dim NewAssignedTo As String
                            Dim blnFlag As Boolean = False
                            Dim NewFlag As Boolean = False
                            Dim ResponsePlan As String
                            Dim EffectOnProject As String
                            Dim oldResponsePlan As String


                            If PrimaryKey.ToString <> "" Then

                                intRiskID = PrimaryKey.ToString

                                EffectOnProject = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("EffectOnProject"), "").ToString

                                intOldCostOpportunity = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("NonDatabase5"), "").ToString
                                intnNewCostOpportunity = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("CostOfOpportunity"), "").ToString

                                intOldSizeOppurtunity = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("NonDatabase4"), "").ToString
                                intNewSizeOppurtunity = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("SizeOfOppotunity"), "").ToString

                                OldOppurtunityStatus = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("NonDatabase6"), "").ToString
                                NewOppurtunityStatus = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("OpportunityStatus"), "").ToString

                                OldAssignedTo = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("NonDatabase7"), "").ToString
                                NewAssignedTo = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("AssignedTo"), "").ToString

                                ResponsePlan = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("CustomFieldText1"), "").ToString
                                oldResponsePlan = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("NonDatabase9"), "").ToString


                                If ((intOldCostOpportunity = "" And intOldSizeOppurtunity = "" And OldOppurtunityStatus = "" And OldAssignedTo = "") And (intnNewCostOpportunity <> "" And intNewSizeOppurtunity <> "" And NewOppurtunityStatus <> "" And NewAssignedTo <> "")) Then
                                    intMessageID = 532
                                    blnFlag = True
                                End If

                                If ((intOldCostOpportunity <> intnNewCostOpportunity) Or (intOldSizeOppurtunity <> intNewSizeOppurtunity) Or (OldOppurtunityStatus <> NewOppurtunityStatus) Or (NewAssignedTo <> OldAssignedTo)) And blnFlag = False Then
                                    intMessageID = 533
                                End If


                                strSQL = "EXEC usp_Sel_tbl_PM_EmailMessages " & CommonFunction.General.CheckIsNothing(intMessageID, "0").ToString()
                                drEmailMessage = CommonFunction.Data.GetDataReader(strSQL, True)
                                lngProjectId = HttpContext.Current.Session("intProjectID").ToString


                                If drEmailMessage.Read Then
                                    blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                                    blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                                End If
                                'If ((intOldCostOpportunity <> intnNewCostOpportunity) Or (intOldSizeOppurtunity <> intNewSizeOppurtunity) Or (OldOppurtunityStatus <> NewOppurtunityStatus) Or (NewAssignedTo <> OldAssignedTo)) Then

                                CommonFunction.Data.DisposeDataReader(drEmailMessage)
                                CommonFunction.Data.DisposeDataReader(drRiskID)

                                If intMessageID = 532 Then
                                    If blnSendEmail = True And blnShowPopup = True Then
                                        BeforeSave = "window.open('../General/SendEmail.aspx?MessageID=532&RiskID=" + intRiskID.ToString + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500');" + vbCrLf
                                    End If

                                    If blnSendEmail = True And blnShowPopup = False Then
                                        CommonFunction.EmailMessages.PMMessages.GetEmailMessage_532(strFromMail, strMailTo, strMailCC, strSubject, strMessage, intRiskID)
                                        CommonFunction.Emails.AppSendEmailWithCC(strMailTo, strFromMail, strMailCC, strSubject, strMessage)
                                    End If
                                End If

                                If intMessageID = 533 Then
                                    If blnSendEmail = True And blnShowPopup = True Then
                                        'AfterSave = "window.open('../General/SendEmail.aspx?MessageID=474&RiskID=" + intRiskID.ToString + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500');" + vbCrLf
                                        BeforeSave = "window.open('../General/SendEmail.aspx?MessageID=533&RiskID=" + intRiskID.ToString + "&intOldCostOpportunity=" + intOldCostOpportunity + "&intOldSizeOppurtunity=" + intOldSizeOppurtunity + "&OldOppurtunityStatus=" + OldOppurtunityStatus + "&OldAssignedTo=" + OldAssignedTo + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500');" + vbCrLf
                                    End If

                                    If blnSendEmail = True And blnShowPopup = False Then
                                        CommonFunction.EmailMessages.PMMessages.GetEmailMessage_533(strFromMail, strMailTo, strMailCC, strSubject, strMessage, intRiskID, intOldCostOpportunity, intOldSizeOppurtunity, OldOppurtunityStatus, OldAssignedTo)
                                        CommonFunction.Emails.AppSendEmailWithCC(strMailTo, strFromMail, strMailCC, strSubject, strMessage)
                                    End If
                                End If


                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If
                            'End of addition by ShraddhaM
                            'Added By Riddhesh Patil on 18 Jan 2024 for Validating the Contract Value with Total IR created value
                        Case 2041
                            Dim IntContractValue As Integer = 0
                            Dim ContractValue As Double = 0
                            Dim strResult As Integer
                            If HttpContext.Current.Request.Form("ContractID_PK") <> "" And Not HttpContext.Current.Request.Form("ContractID_PK") Is Nothing Then
                                IntContractValue = HttpContext.Current.Request.Form("ContractID_PK")
                                ContractValue = HttpContext.Current.Request.Form("POValue")
                                strResult = CommonFunctions.Data.GetDataScalar("usp_sel_whizible2_ValidatePOValue " & IntContractValue & "," & ContractValue, True)
                                If strResult = 1 Then
                                    BeforeSave = "alert('Total of IR value is greater than Contract value. So, you cannot revise the contract value.')"
                                    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_SAVE.ToString
                                    RedirectToCL = False
                                End If
                            End If
                            'End of Added By Riddhesh Patil on 18 Jan 2024 for Validating the Contract Value with Total IR created value

                    End Select
                Else
                    'For Sub Tag Page - Before Save Event
                    Select Case WhizGlobal.TagID

                        'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                        'Added By NileshD on 6th Sep 2005 ReqID-WAF3_PB_8
                        Case CommonFunction.Constants.APP_TAG_TAB_GROUP_ACCESS
                            If PrimaryKey = "" Then
                                CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'E',null,null," + strMasterPrimaryKey)
                            End If
                            'End Of Addition By NileshD on 6th Sep 2005 ReqID-WAF3_PB_8
                            'End Of Modifications - IssueID : 672

                        Case CommonFunction.Constants.APP_TAG_TAB_ROLE_MAPPING
                            Dim strSQL As String
                            'Add the Function Roles for each RequestTypeID of the the department
                            strSQL = "usp_Ins_tbl_CRM_Function_Roles " + strMasterPrimaryKey + "," + ControlsHashTable("RoleID").ToString
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                        Case CommonFunction.Constants.APP_TAG_TAB_SCM_PLAN_CONFIGURABLE_ITEMS
                            Dim strSQL As String
                            Dim strNoOfConfigItems As String
                            If (ControlsHashTable("NoOfConfigItems").ToString = "") Then
                                strNoOfConfigItems = "NULL"
                            Else
                                strNoOfConfigItems = ControlsHashTable("NoOfConfigItems").ToString
                            End If
                            'Insert the DocumentCategory 
                            strSQL = "usp_ins_SCMPlan " + ControlsHashTable("ProjectID").ToString + ", " + strMasterPrimaryKey + "," + ControlsHashTable("DocumentCategoryId").ToString + ", " + strNoOfConfigItems
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            strActionCode = ReturnCodes.IGNORE_SAVE.ToString

                            'added by DiptiK   on 21 Aug 2004
                        Case CommonFunction.Constants.APP_SUB_TAG_ANSWERS
                            Dim strSingle As String
                            Dim objDr As IDataReader
                            Dim objDrMultipleSel As IDataReader
                            Dim StrSQL As String
                            Dim strNegative As String

                            Dim intVal As Integer
                            Dim intSingle As Integer
                            Dim strScript As String = ""

                            'get count for no. of negative responses
                            StrSQL = "select count(IsNegative) as count from tbl_q_answer where answersetid=" & CType(HttpContext.Current.Request.Form("ForeignKeyValue"), Int16) & " and isnegative=1"
                            objDr = CommonFunction.Data.GetDataReader(StrSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If objDr.Read Then
                                intVal = CType(objDr("count"), Integer)
                            End If
                            CommonFunction.Data.DisposeDataReader(objDr)

                            ' get if single selection or multiple
                            StrSQL = "select SingleSelection as count from tbl_q_answerset where answersetid=" & CType(HttpContext.Current.Request.Form("ForeignKeyValue"), Int16)
                            objDrMultipleSel = CommonFunction.Data.GetDataReader(StrSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If objDrMultipleSel.Read Then
                                intSingle = CType(objDrMultipleSel("count"), Integer)
                            End If
                            CommonFunction.Data.DisposeDataReader(objDrMultipleSel)
                            'strSingle = CType(ControlsHashTable("SingleSelection"), String)
                            'Case: if single selection and more than one negative response is there
                            If (intSingle <> 0 And intVal > 0) Then
                                'strScript = "<script language = javascript>"
                                'strScript += "alert('There is already a negative response added for single selection. You cannot add more than one.');"
                                'strScript += "</script>"
                                'CommonFunction.General.WriteHTML(strScript)
                                'strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                            End If
                            ' get the value for the check box of isnegative response
                            strNegative = CType(ControlsHashTable("IsNegative"), String)

                            'case: if multiple selection is there and negative response is asked
                            If (intSingle = 0 And strNegative = "on") Then
                                'strScript = "<script language = javascript>"
                                'strScript += "alert('There cannot be a negative response for multiple selection.');"
                                'strScript += "</script>"
                                'CommonFunction.General.WriteHTML(strScript)
                                strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                            End If

                            'addition ends

                            'Added By Nileshd on 26 August 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_CONFIGURE_RFI_ITEM_ATTRIBUTES
                            Dim drTestScript As IDataReader
                            Dim strSQL As String
                            Dim m_strQueryMessage As String = ""

                            If ControlsHashTable("NonDatabase1").ToString.ToUpper = "2" Then
                                If ControlsHashTable("StoredProcedure").ToString <> "" Then
                                    Try
                                        strSQL = ControlsHashTable("StoredProcedure").ToString
                                        If InStr(strSQL, "<PROJECT_ID>") > 0 Then
                                            strSQL = strSQL.Replace("<PROJECT_ID>", "1")
                                        End If
                                        'Modified By PrashantSJ on 24 Aug 2007 for WhizibleSEM 7.0 
                                        ' to Validate for Invalid sql keywords 
                                        Dim Pattern As New System.Text.StringBuilder

                                        Dim strConfigPath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory) & "bin\"
                                        'Create the config manager
                                        Dim objConfigMgr As New Utilities.Config.ConfigManager(strConfigPath & "Security.Config")
                                        'Open the config file
                                        objConfigMgr.Open()
                                        'Get the config key value
                                        Pattern.Append(objConfigMgr.GetValue("SQLKeyWords"))
                                        Pattern.Replace("select|", "")
                                        Pattern.Replace("exec|", "")
                                        Pattern.Replace("execute|", "")
                                        Pattern.Replace("sp_|", "")
                                        'Craete the regular exception object
                                        Dim reEx As New System.Text.RegularExpressions.Regex(Pattern.ToString(), System.Text.RegularExpressions.RegexOptions.IgnoreCase)

                                        'Clean the string with pattern
                                        strSQL = reEx.Replace(strSQL, "")
                                        'Destroy the re object
                                        reEx = Nothing
                                        Pattern = Nothing
                                        'Destroy the object
                                        objConfigMgr = Nothing

                                        'End Modification PrashantSJ on 24 Aug 2007 for WhizibleSEM 7.0 

                                        If CommonFunctions.Data.ValidateQuery(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)) = False Then
                                            m_strQueryMessage = m_objTemplate.GetResourceString("INVALIDQUERY")
                                        End If

                                        If m_strQueryMessage = "" Then
                                            drTestScript = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                            drTestScript.Close()
                                        Else
                                            Dim strScript As String
                                            strScript = "<script language = javascript>"
                                            strScript += "window.alert('Please enter the valid stored procedure');"
                                            strScript += "</script>"
                                            CommonFunction.General.WriteHTML(strScript)
                                            strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                                            RedirectToCL = False
                                        End If
                                    Catch ex As Exception
                                        Dim strScript As String
                                        strScript = "<script language = javascript>"
                                        strScript += "window.alert('Please enter the valid stored procedure');"
                                        strScript += "</script>"
                                        CommonFunction.General.WriteHTML(strScript)
                                        strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                                        RedirectToCL = False
                                    Finally
                                        CommonFunction.Data.DisposeDataReader(drTestScript)
                                    End Try
                                End If
                            End If
                            'End of Addition

                            'added by SachinR   on 27 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_ORGANIZATION_STRUCTURE_LOCATIONS
                            'here default save is canceled and data is saved to master of location and 
                            'then location and businessgroup mapping is stored in the mapping table
                            Dim strSQL As String
                            Dim strLocation As String
                            Dim strLocationCode As String
                            Dim strBusinessGroupID As String
                            strLocation = HttpContext.Current.Request.Form("Location") + ""
                            strLocationCode = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("LocationCode"), "")
                            strBusinessGroupID = strMasterPrimaryKey + ""
                            'insert location record and get the location ID
                            'Modified By ShraddhaM on 12 Sep 2006 for SP7 For IssueID : 6198
                            'If intOutput = 0 Then
                            strSQL = "usp_Ins_tbl_PM_Location_OrganizationStructure "
                            strSQL += strBusinessGroupID.Trim
                            strSQL += ",'" + CommonFunction.General.BuildQueryString(strLocation.Trim).ToString + "'"
                            strSQL += ",'" + CommonFunction.General.BuildQueryString(WhizGlobal.UserName.Trim).ToString + "'"
                            If strLocationCode <> "" Then
                                strSQL += ",'" + CommonFunction.General.BuildQueryString(strLocationCode.Trim).ToString + "'"
                                'Ended By ShraddhaM on 12 Sep 2006 for SP7
                            Else
                                strSQL += ",NULL"
                            End If

                            If PrimaryKey <> "" Then
                                'then insert new record
                                strSQL += "," + PrimaryKey.Trim
                            End If
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                            'added By SachinR   on 30 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_DELIVERY_TEAM_ORGANIZATION_STRUCTURE
                            Dim strSQL As String
                            Dim strGroupCode As String
                            Dim strGroupName As String
                            Dim strResourceHead As String
                            Dim strResourcePoolID As String

                            strGroupCode = HttpContext.Current.Request.Form("GroupCode") + ""
                            strGroupName = HttpContext.Current.Request.Form("GroupName") + ""
                            strResourcePoolID = strMasterPrimaryKey + ""

                            'insert location record and get the location ID
                            strSQL = "usp_Ins_tbl_PM_GroupMaster_Organization_Structure "
                            strSQL += strResourcePoolID.Trim
                            'Modified By ShraddhaM on 12 Sep 2006 for SP7 For IssueID : 6198
                            strSQL += ",'" + CommonFunction.General.BuildQueryString(strGroupName.Trim).ToString + "'"
                            strSQL += ",'" + CommonFunction.General.BuildQueryString(WhizGlobal.UserName.Trim).ToString + "'"
                            If strGroupCode <> "" Then
                                strSQL += ",'" + CommonFunction.General.BuildQueryString(strGroupCode.Trim).ToString + "'"
                            Else
                                strSQL += ",NULL"
                            End If

                            If PrimaryKey <> "" Then
                                'then insert new record
                                strSQL += "," + PrimaryKey.Trim
                            End If
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                            'addition end


                            'Code commented by SiddharthS on 15 Mar 2005 for IssueID 15845
                            'Purpose : To remove server side validation and doing it on client side.

                            'Code modified by SiddharthS on 15 Mar 2005 for IssueID 15845
                            'Purpose:In Sub Tab 'Employee Site History', when an role is changed then the site record is not updated.
                            'to allow to update the record if role is changed
                            '##### Onsite Offshore functionality
                            'Integrated by SavitaS on 04 Sept 2006 for SP& Integration IssueID 5702
                            'Code uncommented by SavitaS on 18 May 2006 for Sierra IssueID-1788
                        Case CommonFunction.Constants.APP_TAG_TAB_SITE_HISTORY
                            Dim strSQL As String
                            Dim drCheckDuplicateRecord As IDataReader
                            Dim strEffectiveDate As String
                            Dim strEmployeeID As String
                            Dim strRoleID As String
                            Dim strSiteID As String
                            Dim strPorjectID As String
                            Dim strCount As String
                            Dim strScript As String
                            Dim intResult As Integer

                            strPorjectID = CType(HttpContext.Current.Session("intProjectId"), String)
                            strSiteID = CType(ControlsHashTable("SiteID"), String)
                            strEmployeeID = strMasterPrimaryKey
                            strRoleID = CType(ControlsHashTable("RoleID"), String)
                            strEffectiveDate = CType(ControlsHashTable("StartDate"), String)
                            strEffectiveDate = CType(CommonFunctions.Dates.GetDate(CType(strEffectiveDate, Date)), String)

                            strSQL = "usp_CheckDuplicateRecordInBillingInfo " + CType(strPorjectID, String) + "," + CType(strSiteID, String) + "," + CType(strEmployeeID, String) + "," + CType(strRoleID, String) + ",'" + CType(strEffectiveDate, String) + "'"
                            'drCheckDuplicateRecord = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            intResult = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)
                            'If drCheckDuplicateRecord.Read Then
                            '    strCount = CType(CommonFunctions.Data.CheckIsDBNull(drCheckDuplicateRecord("Count"), "0"), String)
                            'Else
                            '    strCount = "0"
                            'End If
                            'CommonFunctions.Data.DisposeDataReader(drCheckDuplicateRecord)

                            If intResult = 1 Then
                                strScript = strScript + " alert('The site and a role already exists for the selected Transfer Date');"
                                BeforeSave = strScript
                                strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_SAVE.ToString
                                RedirectToCL = False
                            End If
                            'End Addition
                            'Addition done by SuchitraP on 24-MAY-2007 for CleanUp Activity
                        Case CommonFunction.Constants.APP_TAG_TAB_LEAVES
                            'Dim myQuery As String = ""
                            Dim strLeaveType As String
                            Dim strLeaveEntitlement As String
                            'Addition done by SuchitraP on 2-Jul-2007 for IssueID 14182
                            Dim strProRata As String
                            'End of addition done by SuchitraP on 2-Jul-2007 for IssueID 14182
                            Dim strsql As String = ""
                            'Dim blnIsProRataEnabled As Boolean = False
                            Dim strUniqueID As String
                            'myQuery = "SELECT ISNULL(IsProRataEnabled,0) FROM tbl_PM_CompanyInformation"
                            'blnIsProRataEnabled = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(myQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Boolean)
                            'If blnIsProRataEnabled = False Then

                            'modified by SuchitraP on 6-JUN-2007 for IssueID 13521
                            strUniqueID = HttpContext.Current.Request.QueryString("UniqueID_PK")
                            If strUniqueID Is Nothing Then
                                strUniqueID = HttpContext.Current.Request.Form("UniqueID_PK")
                            ElseIf strUniqueID = "" Then
                                strUniqueID = HttpContext.Current.Request.Form("UniqueID_PK")
                            End If
                            'End of modification by SuchitraP on 6-JUN-2007 for IssueID 13521

                            If CommonFunction.Application.IsProRataEnabled = False Then
                                'comment by SuchitraP on 6-JUN-2007 for IssueID 13521
                                'strUniqueID = HttpContext.Current.Request.QueryString("UniqueID_PK")
                                'If strUniqueID Is Nothing Then
                                '    strUniqueID = HttpContext.Current.Request.Form("UniqueID_PK")
                                'ElseIf strUniqueID = "" Then
                                '    strUniqueID = HttpContext.Current.Request.Form("UniqueID_PK")
                                'End If
                                'End of comment by SuchitraP on 6-JUN-2007 for IssueID 13521

                                'If strUniqueID Is Nothing AndAlso strUniqueID <> "" Then
                                If Not strUniqueID Is Nothing AndAlso strUniqueID <> "" Then
                                    strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                                    strLeaveType = HttpContext.Current.Request.Form.Get("LeaveTypeID")
                                    strLeaveEntitlement = HttpContext.Current.Request.Form.Get("NoOfLeaves")
                                    strsql = "UPDATE tbl_PM_LeaveMaster SET LeaveTypeID=" + strLeaveType + "," + "NoOfLeaves=" + strLeaveEntitlement + " WHERE UniqueID = " + strUniqueID
                                    CommonFunctions.Data.InsertOrUpdateData(strsql, True)
                                End If
                            Else
                                If PrimaryKey <> "" Then
                                    strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                                    'Addition done by SuchitraP on 2-Jul-2007 for IssueID 14182
                                    'To update Leave Entitlement as well as ProRata
                                    strLeaveType = HttpContext.Current.Request.Form.Get("LeaveTypeID")
                                    strLeaveEntitlement = HttpContext.Current.Request.Form.Get("NoOfLeaves")
                                    strProRata = HttpContext.Current.Request.Form.Get("ProRata")
                                    If strProRata = "" Then
                                        strProRata = "0"
                                    End If
                                    Dim strLeaveTypeID As String
                                    Dim strDesignationID As String
                                    strLeaveTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form.Get("LeaveTypeID"))
                                    strDesignationID = strMasterPrimaryKey
                                    strsql = "usp_Upd_tbl_PM_EmployeeLeaveDetails_ProData " + strUniqueID + "," + strDesignationID + "," + strLeaveTypeID + "," + strProRata
                                    CommonFunctions.Data.InsertOrUpdateData(strsql, True)
                                    strsql = "UPDATE tbl_PM_LeaveMaster SET LeaveTypeID=" + strLeaveType + "," + "NoOfLeaves=" + strLeaveEntitlement + "," + "ProRata=" + strProRata + " WHERE UniqueID = " + strUniqueID
                                    CommonFunctions.Data.InsertOrUpdateData(strsql, True)
                                    'End of addition done by SuchitraP on 2-Jul-2007 for IssueID 14182
                                End If
                            End If
                            'End of Addition done by SuchitraP on 24-MAY-2007 for CleanUp Activity

                            'Addition done by SuchitraP on 24-MAY-2007 for CleanUp Activity
                        Case CommonFunction.Constants.APP_TAG_TAB_EMPLOYEE_LEAVE_DETAILS
                            'Dim myQuery As String = ""
                            Dim strLeaveType As String
                            Dim strLeaveEntitlement As String
                            Dim strLeaveBalance As String
                            Dim strsql As String = ""
                            'Dim blnIsProRataEnabled As Boolean = False
                            Dim strUniqueID As String
                            'myQuery = "SELECT ISNULL(IsProRataEnabled,0) FROM tbl_PM_CompanyInformation"
                            'blnIsProRataEnabled = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(myQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Boolean)
                            'If blnIsProRataEnabled = False Then
                            If CommonFunction.Application.IsProRataEnabled = False Then
                                strUniqueID = HttpContext.Current.Request.QueryString("UniqueID_PK")
                                If strUniqueID Is Nothing Then
                                    strUniqueID = HttpContext.Current.Request.Form("UniqueID_PK")
                                ElseIf strUniqueID = "" Then
                                    strUniqueID = HttpContext.Current.Request.Form("UniqueID_PK")
                                End If

                                If Not strUniqueID Is Nothing AndAlso strUniqueID <> "" Then
                                    strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                                    'strLeaveType = HttpContext.Current.Request.Form.Get("LeaveTypeID")
                                    strLeaveEntitlement = HttpContext.Current.Request.Form.Get("NoOfLeaves")
                                    strLeaveBalance = HttpContext.Current.Request.Form.Get("LeaveBalance")
                                    strsql = "UPDATE tbl_PM_EmployeeLeaveMaster SET NoOfLeaves=" + strLeaveEntitlement + "," + "LeaveBalance=" + strLeaveBalance + " WHERE UniqueID = " + strUniqueID
                                    CommonFunctions.Data.InsertOrUpdateData(strsql, True)
                                End If
                            End If
                            'End of Addition done by SuchitraP on 24-MAY-2007 for CleanUp Activity

                            'End comment by SavitaS
                            'Integrated by SavitaS on 04 Sept 2006 for SP& Integration IssueID 5702

                            'End Modification.

                            'Commenting End.

                            'Code commented by SiddharthS on 15 Mar 2005 for IssueID 15845
                            'Purpose : To remove server side validation and doing it on client side.

                            'Added by Siddharths on 20 Feb 2005 t0 resolve issue id 15867
                            'Purpose:If the roles / sites are different, the Billing Rate for that employee for the site should be added on the same date
                            'Case CommonFunction.Constants.APP_TAG_TAB_EMP_RATE_INFO
                            '    Dim strSQL As String
                            '    Dim strEmployeeID As String
                            '    Dim strRoleID As String
                            '    Dim strSiteID As String
                            '    Dim strPorjectID As String
                            '    Dim intResult As Integer
                            '    Dim strScript As String
                            '    Dim strEffectiveDate As String
                            '    strPorjectID = CType(HttpContext.Current.Session("intProjectId"), String)
                            '    strSiteID = CType(ControlsHashTable("SiteID"), String)
                            '    strEmployeeID = strMasterPrimaryKey ' CType(ControlsHashTable("EmployeeID"), String)
                            '    strRoleID = CType(ControlsHashTable("RoleID"), String)
                            '    strEffectiveDate = CType(ControlsHashTable("StartDate"), String)
                            '    strEffectiveDate = CType(CommonFunctions.Dates.GetDate(CType(strEffectiveDate, Date)), String)
                            '    strSQL = "usp_CheckDuplicateRecordInBillingRateInfo " + CType(strPorjectID, String) + "," + CType(strSiteID, String) + "," + CType(strEmployeeID, String) + "," + CType(strRoleID, String) + ",'" + CType(strEffectiveDate, String) + "'"
                            '    intResult = CType(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)
                            '    If intResult = 1 Then
                            '        strScript = strScript + " alert('Cannot add the record for the same date.');"
                            '        BeforeSave = strScript
                            '        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_SAVE.ToString
                            '        RedirectToCL = False
                            '    End If
                            'End addition
                            'Comment end.

                            'Case CommonFunction.Constants.APP_TAG_TAB_PROJECT_MAPPING
                            '    Dim strSQL As String
                            '    Dim intDefaultCount As Integer

                            '    If ControlsHashTable.Item("IsDefaultProject").ToString.ToUpper = "ON" Then
                            '        strSQL = "UPDATE tbl_CRM_Function_Projects SET ISDefaultProject = 0 WHERE ISDefaultProject = 1 AND FunctionID = " + strMasterPrimaryKey
                            '        intDefaultCount = CType(CommonFunctions.Data.GetDataScalar(strsql, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)
                            '    End If

                            '''    '--Coded added by SajiU on 27 NoV 2006
                            '''Case CommonFunction.Constants.APP_SUBTAG_LOGIN_ACTIVATE
                            '''    BeforeSave = SaveEmployeeLoginInformationINDetail(ControlsHashTable, PrimaryKey)
                            '''    strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                            '''    'Addition Ends - SajiU on 27 NoV 2006
                            '''Added By Nikhil Adkar on 31st Dec 2025 for W26 VAPT 
                        Case CommonFunction.Constants.APP_SUBTAG_INVOICE_PAYMENT_RECEIPT
                            Dim strScript As String = ""
                            Dim InvoiceAmount As Double = 0
                            Dim InvPaymentBillingCurrencyAmount As Double = 0
                            InvoiceAmount = HttpContext.Current.Request.Form.Get("NonDatabase2")
                            InvPaymentBillingCurrencyAmount = HttpContext.Current.Request.Form.Get("InvPaymentBillingCurrencyAmount")
                            If InvPaymentBillingCurrencyAmount > InvoiceAmount Then
                                strScript = strScript + " alert('Amount should not be greater than Invoice Amount!');"
                                BeforeSave = strScript
                                strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_SAVE.ToString
                                RedirectToCL = False
                            End If
                            ''End of Added By Nikhil Adkar on 31st Dec 2025 for W26 VAPT

                    End Select
                End If
            End Function

            Public Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
                AfterSave = ""
                'Application standard return code
                strActionCode = ReturnCodes.DO_NOTHING.ToString

                'Added by VijayD  oN 22th May 2009 for IssueID 29455
                'Purpose : To Handle single quote(') in UserName
                Dim strUser As String
                strUser = HttpContext.Current.Session("strUserName").ToString
                Dim intIndex As Integer = strUser.IndexOf("'")
                If intIndex >= 0 Then
                    strUser = strUser.Replace("'", "''")
                End If
                'End of addition VijayD  oN 22th May 2009 for IssueID 29455

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag Page - After Save Event
                    Select Case WhizGlobal.TagID
                        'Added By Chakshuta H on 29th-Oct-2015
                        'Modified By PushkarK On Friday, December 16, 2005 for WAF3_GEN_1 : Added Constant for User Defined Module Page's Tag ID
                        Case CommonFunction.Constants.TAG_SYSTEM_MODULES, CommonFunction.Constants.TAG_USERDEFINED_MODULES
                            'Added By AshishR 
                            'Purpose : to udapte the system mdoules hash tables, if any body modifies the module details
                            Call CommonEngines.HashTables.CreateHashTables.CreateSystemModuleHashTable()
                            '-----------------------------------------------------------------------------------------------------------------------------------------------
                            'Added By Shrikant B ON 18 Nov 2008 For WAF3_GEN_18
                            Call CommonEngines.HashTables.CreateHashTables.CreateSystemModuleHashTableCulture(CommonEngines.HashTables.Culture.GetSupportedCulturIDs)
                            'Added By Shrikant B On 18 Nov 2008 For WAF_GEN_18
                            '-----------------------------------------------------------------------------------------------------------------------------------------------
                        Case CommonFunction.Constants.TAG_OPTION_BUTTONS, CommonFunction.Constants.TAG_GRID_FORMATTING_RULES, CommonFunction.Constants.TAG_COMPARISON_VALIDATIONS, CommonFunction.Constants.TAG_DEFAULT_PAGE_FILTERS, CommonFunction.Constants.TAG_QUERY_STRING_PARAMETERS 'Added By NinadP on 22 Jan 2008, ReqID WAF3_PB_57  
                            'For Master Tag Options buttons, Grid Formatting rules, Comparison Rules, Default Filters ...after deleting the record update the hash table
                            Call CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("TagID")), Long))
                            'Added By NinadP on 20 June 2007 ReqID - WAF3_PB_48
                            'Modified By NinadP on 22 Jan 2008, ReqID WAF3_PB_57  
                            If WhizGlobal.TagID = CommonFunction.Constants.TAG_DEFAULT_PAGE_FILTERS Or WhizGlobal.TagID = CommonFunction.Constants.TAG_QUERY_STRING_PARAMETERS Then
                                Dim sbScript As New System.Text.StringBuilder
                                sbScript.Append("<Script language=javascript>")
                                sbScript.Append("try { ") 'Added by Vinay on 11 DEC. 2008 WAF3_GEN_18
                                sbScript.Append("window")
                                If WhizGlobal.TagID = CommonFunction.Constants.TAG_QUERY_STRING_PARAMETERS Then sbScript.Append(".parent")
                                sbScript.Append(".opener.document.forms['frmSample'].action = window") 'Modified By NinadP on 21 April 2008, IssueID 20091
                                If WhizGlobal.TagID = CommonFunction.Constants.TAG_QUERY_STRING_PARAMETERS Then sbScript.Append(".parent")
                                sbScript.Append(".opener.location.href;")
                                sbScript.Append("window")
                                If WhizGlobal.TagID = CommonFunction.Constants.TAG_QUERY_STRING_PARAMETERS Then sbScript.Append(".parent")
                                sbScript.Append(".opener.document.forms['frmSample'].submit();")
                                sbScript.Append("} catch(e) { } ") 'Added by Vinay on 11 DEC. 2008 WAF3_GEN_18
                                'End Modification By NinadP on 22 Jan 2008, ReqID WAF3_PB_57  
                                sbScript.Append("</Script>")
                                HttpContext.Current.Response.Write(sbScript.ToString)
                                sbScript = Nothing
                                If Not IsEditMode Then RedirectToCL = False
                            End If
                            'Case CommonFunction.Constants.APP_TAG_COMPANY_INFORMATION, CommonFunction.Constants.APP_TAG_CORPORATE_SETTINGS
                            '    'Reload Application Settings
                            '    'Added By NileshD 25 Nov 2005 for ReqID WAF3_PB_13
                            '    If UCase(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("IsWebGardenImplemented"), "")) = "TRUE" Then
                            '        CommonFunctions.IIS.RecycleAppPool(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("ApplicationPoolName"), "DefaultAppPool"))
                            '    Else
                            '        Call CommonFunctions.General.GetCorporateSettings(True)
                            '    End If
                            'Ended By Chakshuta H on 29th-Oct-2015

                        Case 1853 'TAB_CONTROLS - For Tab and Sub Tag
                            'WAF3_PB_44 Added By UmeshJ 14 May 2007
                            If UCase(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("Is_SubTag"), "")) = "0" Then
                                Call CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("TagID")), Long))
                            Else
                                Dim lngTagID As Long = CType(CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_Sel_v_tbl_UI_SubTagMaster_GetTagID " + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("TagID")), CommonEngines.HashTables.CreateHashTables.UseSQL)), Long)
                                Call CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(lngTagID)
                            End If
                            'WAF3_PB_44 Added By UmeshJ 14 May 2007


                            'Code Added By PradipK on 29 Dec 2006
                            'Purpose : Page Crash while adding  Existing Organization Unit.


                        Case CommonFunction.Constants.APP_TAG_TAB_NEW_EXISTING_OU
                            'Response.Write("</Script>")
                            Dim StrScript As String
                            If IsEditMode = False Then

                                'AfterSave += " window.opener.location.href=window.opener.location.href;" + vbCrLf
                                'AfterSave += " window.close();" + vbCrLf
                                'strActionCode = ReturnCodes.ON_LOAD.ToString

                                'StrScript = vbCrLf + "<Script language=javascript>"
                                'strScript += vbCrLf + "    refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx');"
                                'strScript += vbCrLf + "</Script>"
                                'CommonFunction.General.WriteHTML(strScript)


                                AfterSave += "window.opener.document.forms['frmCommonPage'].action = 'CommonPage.aspx?SubTagID=2080&FocusOn=SUBTAG&PagingNumber=1';" + vbCrLf
                                AfterSave += "window.opener.document.forms['frmCommonPage'].submit();" + vbCrLf
                                AfterSave += "window.close();"

                                strActionCode = ReturnCodes.ON_LOAD.ToString


                            End If
                            ' Added by GaneshD on 02 Sep 2009 For Whiziblesem 9.0 - [StatusFlow]Issue Type page was not getting refreshed once statuses are configured
                            'Case CommonFunction.Constants.APP_TAG_IB_STATUS_FLOW_CONF


                            '    'AfterSave += "alert('Hi');" + vbCrLf

                            '    AfterSave += "var strParentPage = new String();" + vbCrLf
                            '    AfterSave += "strParentPage = '../IB/IBIssueTypes.aspx?FromWhere=PM&MasterTagId=538';" + vbCrLf
                            '    RedirectToCL = False
                            '    AfterSave += "refreshParent('frmIssueTypes', 'IBIssueTypes.aspx', strParentPage);" + vbCrLf
                            '    strActionCode = ReturnCodes.ON_LOAD.ToString
                            '    ' End of addition by GaneshD 

                            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                            'Added By NileshD on 16 Sept. 2004
                        Case CommonFunctions.Constants.TAG_CLCP_EXTENSION
                            'CommonFunction.Data.InsertOrUpdateData("usp_Upd_tbl_UI_CLCPExtensionParameterMaster " + _
                            '            CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Tag").ToString, "") + ", " + _
                            '            CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ParentTag").ToString, "") + _
                            '            ", '" + PrimaryKey + "'", _
                            '            CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            CommonEngines.HashTables.CLCPExtensionHandler.ReloadExtensionHashTables()
                            'End Of Addition

                            'End Of Modifications - IssueID : 672


                            'Added by HarshK for sp4 issueid 536
                        Case CommonFunction.Constants.APP_TAG_EMPLOYEE_MAINTENANCE
                            Dim strQuery As String = "select status from tbl_Pm_Employee where EmployeeID = " & PrimaryKey.ToString
                            Dim strStatus As Boolean = CBool(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, True), "false"))
                            Dim intReportingToCount As Integer
                            strQuery = " Select IsNull(Count(ReportingTo),0) From tbl_PM_Employee Where status=0 and  ReportingTo=" & PrimaryKey.ToString
                            intReportingToCount = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, True), "0"))

                            'Modified By KapilGK On 24-Nov-2006 For SP8 IssueID - 7182
                            'strQuery = " Select IsNull(Count(ProjectID),0) From tbl_PM_ProjectEmployeeRole Where ActualEndDate Is Null And EmployeeID=" & PrimaryKey.ToString
                            strQuery = " Select IsNull(Count(tbl_PM_ProjectEmployeeRole.ProjectID),0) From tbl_PM_ProjectEmployeeRole Left Join Tbl_PM_Project On tbl_PM_ProjectEmployeeRole.ProjectID = Tbl_PM_Project.ProjectID Where Tbl_PM_Project.GlobalProject = 0 And tbl_PM_ProjectEmployeeRole.ActualEndDate Is Null And EmployeeID = " & PrimaryKey.ToString
                            Dim intAllocatedProjectCount As Integer
                            intAllocatedProjectCount = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, True), "0"))

                            'If strStatus = True And intReportingToCount > 0 Then
                            '    AfterSave = "window.open(""../HR/HR_ApproverToList.aspx?ApproverID=" & PrimaryKey.ToString & """,""_new"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 700)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=700,height=500"");"
                            '    strActionCode = ReturnCodes.ON_LOAD.ToString
                            'End If

                            If strStatus = True Then
                                If intReportingToCount > 0 Then
                                    If intAllocatedProjectCount > 0 Then
                                        AfterSave = "window.open(""../HR/HR_ApproverToList.aspx?Project=1&IsApprover=1&ApproverID=" & PrimaryKey.ToString & """,""_new"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 700)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=700,height=500"");"
                                    Else
                                        AfterSave = "window.open(""../HR/HR_ApproverToList.aspx?Project=0&IsApprover=1&ApproverID=" & PrimaryKey.ToString & """,""_new"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 700)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=700,height=500"");"
                                    End If
                                    strActionCode = ReturnCodes.ON_LOAD.ToString
                                Else
                                    If intAllocatedProjectCount > 0 Then
                                        AfterSave = "window.open(""../HR/HR_ApproverToList.aspx?Project=1&IsApprover=0&ApproverID=" & PrimaryKey.ToString & """,""_new"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 700)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=700,height=500"");"
                                        strActionCode = ReturnCodes.ON_LOAD.ToString
                                    End If
                                End If

                            End If
                            'End of Modification By KapilKG
                            'End Added by HarshK for sp4 issueid 536

                            ' Added by ArchanaN on 25 Jan 2008
                            'Case CommonFunction.Constants.APP_TAG_EMPLOYEE_MAINTENANCE
                            Dim strFor As String
                            Dim strEmployeeJoinPoolID As String
                            Dim strUserName As String
                            Dim drEmp As IDataReader
                            Dim strSQL As String
                            Dim StrScript As String

                            strFor = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("For"), "")
                            If strFor.ToUpper = "JOINPOOL" Then
                                If HttpContext.Current.Request.QueryString("Operation").ToUpper = "SAVE" Then
                                    strEmployeeJoinPoolID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeID"), "")
                                    strUserName = CommonFunction.General.BuildQueryString(HttpContext.Current.Session("strUserName").ToString)
                                    strSQL = "usp_Ins_tbl_PM_Employee_FromJoinPool " & strEmployeeJoinPoolID & "," & PrimaryKey & ",' " & strUserName & "'"
                                    CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                                    StrScript = "<Script language=javascript>" + vbCrLf
                                    StrScript += "window.opener.document.forms['frmCommonList'].action = '../../Source/HR/HR_CommonList.aspx?FromWhere=RM&MasterTagID=3873';" + vbCrLf
                                    StrScript += "window.opener.document.forms['frmCommonList'].submit();" + vbCrLf
                                    StrScript += "window.close();" + vbCrLf
                                    StrScript += "</Script>"
                                    CommonFunction.General.WriteHTML(StrScript)
                                End If
                            End If
                            ' End of Added by ArchanaN on 25 Jan 2008
                            'Added Byb VivekP On 3 August 2005 For WhizibleSEM SP4 IssueID-87
                            'Added by TruptiK on 17-Sep-2008
                        Case CommonFunction.Constants.App_Tag_AlertLevel
                            Dim Message As String = ""
                            Dim arrPhone() As String
                            Dim intCnt As Integer
                            Dim PhNO As String = ""
                            Dim strProxyURL As String = ""
                            Dim proxyUser, proxyPassword, proxyDomain As String
                            Dim proxy As System.Net.IWebProxy
                            Dim URI As System.Uri
                            Dim credentials As System.Net.NetworkCredential
                            'Dim webObject As New Whizible.SMSService.falertwsdl

                            'provide credentials or bypass proxy
                            'proxy.IsBypassed = True
                            Message = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("Message"), "")
                            PhNO = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("PhNumber"), "")
                            arrPhone = PhNO.Split(","c)

                            'If CommonFunctions.General.GetApplicationKeySetting("ProxyURL") <> "" Then
                            '    strProxyURL = CommonFunctions.General.GetApplicationKeySetting("ProxyURL")
                            '    URI = New System.Uri(strProxyURL)
                            '    proxy = New System.Net.WebProxy(URI, True)

                            '    proxyUser = CommonFunctions.General.GetApplicationKeySetting("ProxyUserName")
                            '    proxyPassword = CommonFunctions.General.GetApplicationKeySetting("ProxyPassword")
                            '    proxyDomain = CommonFunctions.General.GetApplicationKeySetting("ProxyDomain")

                            '    If proxyUser <> "" AndAlso proxyPassword <> "" Then
                            '        credentials = New System.Net.NetworkCredential(proxyUser, proxyPassword)
                            '        If proxyDomain <> "" Then
                            '            credentials.Domain = proxyDomain
                            '        End If
                            '        'set local proxy settings to the service object
                            '        proxy.Credentials = credentials
                            '        webObject.Proxy = proxy

                            '    Else
                            '        'set local proxy settings to the service object
                            '        webObject.Proxy = proxy
                            '        proxy.Credentials = credentials
                            '        webObject.UseDefaultCredentials = True
                            '    End If
                            'Else
                            '    'proxy.IsBypassed() = True
                            '    webObject.UseDefaultCredentials = True
                            'End If
                            'Try
                            'send SMS
                            'For intCnt = 0 To arrPhone.Length - 1
                            '    If arrPhone(intCnt) <> "" Or arrPhone(intCnt) Is Nothing Then
                            '        webObject.SendSMS("compulink", "Compulink", "tollfree", Message, arrPhone(intCnt))
                            '    End If
                            'Next

                            For intCnt = 0 To arrPhone.Length - 1
                                If arrPhone(intCnt) <> "" Or arrPhone(intCnt) Is Nothing Then
                                    FastAlert.SendSMS(Message, arrPhone(intCnt))
                                End If
                            Next

                            'webObject.SendBulkSMS()
                            'Catch ex As Exception
                            '    CommonFunction.General.WriteLog()
                            'End Try
                            ''End of addition by TruptiK
                        Case CommonFunction.Constants.APP_TAG_PROJECTTIMESHEET_COMMENT
                            Dim m_lngTimesheetNo As String = HttpContext.Current.Request.QueryString("TimesheetNo")
                            Dim stRejectSQL As String = "usp_Upd_tbl_PM_TimeSheetInvoice_For_Rejection " + m_lngTimesheetNo.ToString
                            Dim strMailTo As String = ""
                            Dim strFromMail As String = ""
                            Dim strMailCC As String = ""
                            Dim strSubject As String = ""
                            Dim strMessage As String = ""
                            Dim drEmailMessage As IDataReader
                            Dim blnSendEmail As Boolean
                            Dim blnShowPopup As Boolean
                            drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 442", True)
                            If drEmailMessage.Read Then
                                blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                                blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                            End If
                            CommonFunction.Data.DisposeDataReader(drEmailMessage)
                            If blnSendEmail = True And blnShowPopup = True Then
                                'Response.Write("<Script language='javascript'>")
                                'CommonFunctions.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=442&TimeSheetID=" + m_lngTimesheetNo.ToString + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                                AfterSave = "window.open('../General/SendEmail.aspx?MessageID=442&TimeSheetID=" + m_lngTimesheetNo.ToString + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500');" + vbCrLf
                                'AfterSave += "var opnerpath=window.opener.opener.location.href;" + vbCrLf
                                'AfterSave += "var opnerpathttmp=opnerpath+""&AfterReject=AfterReject"";" + vbCrLf
                                ''AfterSave += "strtemp=strtemp" + "&AfterReject=AfterReject;"
                                'AfterSave += " window.opener.opener.location.href=opnerpathttmp;" + vbCrLf
                                ''AfterSave += " window.opener.opener.location.href= window.opener.opener.location.href;" + vbCrLf
                                AfterSave += " window.opener.location.href=window.opener.location.href;" + vbCrLf
                                AfterSave += " window.close();" + vbCrLf
                                'Response.Write("</Script>")
                            End If

                            If blnSendEmail = True And blnShowPopup = False Then
                                CommonFunction.EmailMessages.FAMessages.GetEmailMessage_442(strFromMail, strMailTo, strMailCC, strSubject, strMessage, CType(m_lngTimesheetNo, Long))
                                CommonFunction.Emails.AppSendEmailWithCC(strMailTo, strFromMail, strMailCC, strSubject, strMessage)
                            End If

                            CommonFunctions.Data.InsertOrUpdateData(stRejectSQL, True)
                            strActionCode = ReturnCodes.ON_LOAD.ToString
                            'End  Of Addition On 3 August 2005 For WhizibleSEM SP4 IssueID-87

                            'Added By VivekP On 6 May 2005 For Copy Functionality WHIZIBLESEM SP3
                        Case CommonFunction.Constants.APP_TAG_MODULES
                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("COPYDATA"), "") = "1" _
                            And CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UNIQUEID"), "") <> "" Then

                                'Added By VidyaJ - IssueID - 11860
                                Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                                Dim strSQL As String = "usp_Sel_PM_ShowTaskTab " + intProjectID.ToString + ", 'MODULE'"
                                'Added by TruptiK on 27-Nov-2007
                                'Purpose:-If project is on-hold task can not be copied.
                                Dim drOnHold As IDataReader
                                Dim strProjectOnHold As String
                                drOnHold = CommonFunction.Data.GetDataReader("SELECT MapToProjectOnHold FROM tbl_CNF_ProjectStatus inner join tbl_PM_Project on tbl_CNF_ProjectStatus.ProjectStatusID=tbl_PM_Project.ProjectStatusID WHERE ProjectID = " & intProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                While drOnHold.Read
                                    If CommonFunction.General.CheckIsNothing(drOnHold("MapToProjectOnHold")).ToString <> "" Then
                                        strProjectOnHold = drOnHold("MapToProjectOnHold").ToString
                                    End If
                                End While
                                CommonFunction.Data.DisposeDataReader(drOnHold)
                                'End of addition by TruptiK
                                If (CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "") <> "") Then

                                    ' If (CommonFunction.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) Is Nothing) Then


                                    Dim UniqueID As String
                                    Dim NewID As String
                                    UniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UNIQUEID"), "")
                                    NewID = PrimaryKey
                                    'Added by TruptiK on 27-Nov-2007
                                    'Purpose:-If project is on-hold task can not be copied.
                                    If strProjectOnHold = "True" Then
                                        AfterSave = "if(1==2){" + vbCrLf
                                    Else
                                        AfterSave = " if (confirm(" + Chr(34) + "If you want to copy the task  then press OK.\nIf you don't want to copy the task  then press Cancel." + Chr(34) + ")) { " + vbCrLf
                                    End If
                                    'End of addition by TruptiK
                                    AfterSave += "	window.open (" + Chr(34) + "../PM/PM_CopyTask.aspx?MODE=ADD_NEW&PARENT_TAGID=454&UNIQUEID=" + UniqueID + "&UNIQUEID_NEW=" + NewID + Chr(34) + ",null,""resizable=yes,scrollbars=no,left="" + (window.screen.width - 700) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=800,height=600"");" + vbCrLf
                                    AfterSave += " opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=454'   ;" + vbCrLf
                                    AfterSave += " } " + vbCrLf
                                    AfterSave += "opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" & CommonFunction.Constants.APP_TAG_MODULES & "';"

                                    'Added by VijayD on 21 August 2009 Purpose: to refersh gantt chart page 
                                    AfterSave += "if(window.opener.opener!=null) {" + vbCrLf
                                    AfterSave += "var strParentPage; strParentPage = new String();" + vbCrLf
                                    AfterSave += "strParentPage = opener.opener.location.href;" + vbCrLf
                                    AfterSave += "if (strParentPage.toUpperCase().indexOf('GANTTCHARTVIEW.ASPX') != -1){" + vbCrLf
                                    AfterSave += "window.opener.opener.document.forms['frmGanttChartView'].action = '../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + CommonFunction.Constants.APP_TAG_MODULES.ToString + "';" + vbCrLf
                                    AfterSave += "try{window.opener.opener.document.forms['frmGanttChartView'].submit();}catch(e){}}}" + vbCrLf
                                    'End Addition By Vijay On 21 August 2009

                                    AfterSave += " window.close();" + vbCrLf
                                    strActionCode = ReturnCodes.ON_LOAD.ToString
                                Else
                                    AfterSave = "opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" & CommonFunction.Constants.APP_TAG_MODULES & "';"

                                    'Added by VijayD on 21 August 2009 Purpose: to refersh gantt chart page 
                                    AfterSave += "if(window.opener.opener!=null) {" + vbCrLf
                                    AfterSave += "var strParentPage; strParentPage = new String();" + vbCrLf
                                    AfterSave += "strParentPage = opener.opener.location.href;" + vbCrLf
                                    AfterSave += "if (strParentPage.toUpperCase().indexOf('GANTTCHARTVIEW.ASPX') != -1){" + vbCrLf
                                    AfterSave += "window.opener.opener.document.forms['frmGanttChartView'].action = '../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + CommonFunction.Constants.APP_TAG_MODULES.ToString + "';" + vbCrLf
                                    AfterSave += "try{window.opener.opener.document.forms['frmGanttChartView'].submit();}catch(e){}}}" + vbCrLf
                                    'End Addition By Vijay On 21 August 2009

                                    AfterSave += " window.close();" + vbCrLf
                                    strActionCode = ReturnCodes.ON_LOAD.ToString
                                End If
                            End If
                            'Added by VijayD on 21 August 2009 Purpose: to refersh gantt chart page 
                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), "") = "SAVE" _
                            And CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UNIQUEID"), "") = "" Then
                                AfterSave = "if(window.opener!=null) {" + vbCrLf
                                AfterSave += "var strParentPage; strParentPage = new String();" + vbCrLf
                                AfterSave += "strParentPage = opener.location.href;" + vbCrLf
                                AfterSave += "if (strParentPage.toUpperCase().indexOf('GANTTCHARTVIEW.ASPX') != -1){" + vbCrLf
                                AfterSave += "opener.location.href = '../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + CommonFunction.Constants.APP_TAG_MODULES.ToString + "';" + vbCrLf
                                AfterSave += "}" + vbCrLf
                                AfterSave += "if (strParentPage.toUpperCase().indexOf('HOME_OUTLOOKVIEW.ASPX') != -1){" + vbCrLf
                                AfterSave += "opener.location.href = '../Home/Home_OutlookView.aspx?List=12';" + vbCrLf ' + CommonFunction.Constants.APP_TAG_MODULES.ToString + "';" + vbCrLf
                                AfterSave += "}}" + vbCrLf
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If

                            'End Addition By Vijay On 21 August 2009

                            ''Added by PrashantSJ on 28th July 2009 Purpose: to refersh gantt chart page 
                            'HttpContext.Current.Response.Write(CommonFunction.General.GetRefreshParentScript("'frmGanttChartView'", "'GanttChartView.aspx'", "'../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" & CommonFunction.Constants.APP_TAG_MODULES.ToString + "'", True))
                            ''End of addition by PrashantSJ on 28th July 2009 Purpose: to refersh gantt chart page 

                            'End OF Addition On 6 May 2005 For Copy Functionality WHIZIBLESEM SP3

                            ''Added By Aniruddh Gujar on 18-Feb-2019 Purpose::Project Work field level changes 
                            Dim strSQLQuery As String
                            Dim WorkHourMinute As String
                            Dim WorkHour As String
                            Dim WorkMinute As String

                            WorkHourMinute = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase10"))

                            If WorkHourMinute = "" Then
                                WorkHourMinute = "00:00"
                            End If

                            WorkHour = WorkHourMinute.Substring(0, WorkHourMinute.IndexOf(":"))
                            WorkMinute = WorkHourMinute.Substring(WorkHourMinute.IndexOf(":") + 1)

                            If WorkHour = "" Then
                                WorkHour = "0"
                            End If
                            If WorkMinute = "" Then
                                WorkMinute = "0"
                            End If
                            If WorkMinute.Length = 1 Then
                                WorkMinute = WorkMinute + "0"
                            End If

                            strSQLQuery = "EXEC usp_Whizible2_upd_EstimatedEffortsForWBS " & PrimaryKey & ",'" & WorkHour & "','" & WorkMinute & "',1"
                            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, True)
                            ''End of Added By Aniruddh Gujar on 18-Feb-2019 Purpose::Project Work field level changes 

                        Case CommonFunction.Constants.TAG_SYSTEM_MODULES
                            'Added By AshishR 
                            'Purpose : to udapte the system mdoules hash tables, if any body modifies the module details
                            Call CommonEngines.HashTables.CreateHashTables.CreateSystemModuleHashTable()

                            ''Added By Aniruddh Gujar on 18-Feb-2019 Purpose::Project Work field level changes 
                            Dim strSQLQuery As String
                            Dim WorkHour As String
                            Dim WorkMinute As String

                            WorkHour = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase10"))
                            WorkMinute = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase11"))

                            If WorkHour = "" Then
                                WorkHour = "0"
                            End If
                            If WorkMinute = "" Then
                                WorkMinute = "0"
                            End If
                            If WorkMinute.Length = 1 Then
                                WorkMinute = WorkMinute + "0"
                            End If

                            strSQLQuery = "EXEC usp_Whizible2_upd_EstimatedEffortsForWBS " & PrimaryKey & ",'" & WorkHour & "','" & WorkMinute & "',1"
                            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, True)
                            ''End of Added By Aniruddh Gujar on 18-Feb-2019 Purpose::Project Work field level changes 

                        ''Added By Usha Pandit On 26.06.2020 Purpose::Project Work field level changes  
                        Case CommonFunction.Constants.APP_TAG_TYPE
                            Dim strSQLQuery As String
                            Dim WorkHourMinute As String
                            Dim WorkHour As String
                            Dim WorkMinute As String

                            WorkHourMinute = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase2"))

                            If WorkHourMinute = "" Then
                                WorkHourMinute = "00:00"
                            End If

                            WorkHour = WorkHourMinute.Substring(0, WorkHourMinute.IndexOf(":"))
                            WorkMinute = WorkHourMinute.Substring(WorkHourMinute.IndexOf(":") + 1)

                            If WorkHour = "" Then
                                WorkHour = "0"
                            End If
                            If WorkMinute = "" Then
                                WorkMinute = "0"
                            End If
                            If WorkMinute.Length = 1 Then
                                WorkMinute = WorkMinute + "0"
                            End If

                            strSQLQuery = "EXEC usp_Whizible2_upd_EstimatedEffortsForWBS " & PrimaryKey & ",'" & WorkHour & "','" & WorkMinute & "',15"
                            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, True)

                        ''End Of Added By Usha Pandit On 26.06.2020 Purpose::Project Work field level changes

                             ''Added By Sagar Nipane on 21-Feb-2019 Purpose::Project Work field level changes 
                        Case CommonFunction.Constants.APP_TAG_PHASE_DETAILS

                            Dim strSQLQuery As String
                            Dim WorkHourMinute As String
                            Dim WorkHour As String
                            Dim WorkMinute As String

                            WorkHourMinute = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase10"))

                            If WorkHourMinute = "" Then
                                WorkHourMinute = "00:00"
                            End If

                            WorkHour = WorkHourMinute.Substring(0, WorkHourMinute.IndexOf(":"))
                            WorkMinute = WorkHourMinute.Substring(WorkHourMinute.IndexOf(":") + 1)

                            If WorkHour = "" Then
                                WorkHour = "0"
                            End If
                            If WorkMinute = "" Then
                                WorkMinute = "0"
                            End If
                            If WorkMinute.Length = 1 Then
                                WorkMinute = WorkMinute + "0"
                            End If

                            strSQLQuery = "EXEC usp_Whizible2_upd_EstimatedEffortsForWBS " & PrimaryKey & ",'" & WorkHour & "','" & WorkMinute & "',3"
                            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, True)
                        ''End of Added By Sagar Nipane on 21-Feb-2019 Purpose::Project Work field level changes

                        Case CommonFunction.Constants.APP_TAG_REVIEWS
                            'Commented by SatyanarayanaA on 12-Jan-2006
                            If IsEditMode = False Then 'First Time entry only
                                AfterSave = " if (confirm(" + Chr(34) + m_objTemplate.GetResourceString("PROJECT_REVIEW") + Chr(34) + ")) { " + vbCrLf
                                AfterSave += "	window.open (" + Chr(34) + "../PM/PM_MapReviewTasks.aspx?ReviewStatisticsID=" + PrimaryKey + Chr(34) + ",null,""resizable=yes,scrollbars=no,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 350) / 2 + "",width=600,height=350"");" + vbCrLf
                                AfterSave += " }"
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If
                            'End Commented by SatyanarayanaA on 12-Jan-2006
                            'After save for Review Tag
                            Dim strReviewerIDList As String
                            Dim strSQL As String
                            'Retrieve the ReviewerID list
                            strReviewerIDList = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase1"))

                            'If strReviewerIDList is not empty
                            If Not (strReviewerIDList = ",," Or strReviewerIDList = "") Then
                                ' Delete the entries of the reviewers who do not belong to the current list.
                                strSQL = "usp_Del_tbl_PM_ReviewStatistics_Reviewers " + PrimaryKey + ", '" + strReviewerIDList + "'"
                                CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                ' For each reviewer in the new reviewer list, make an entry in the reviewer list.
                                'Commented by SatyanarayanaA on 10-Jan-2006
                                strSQL = "usp_Ins_tbl_PM_ReviewStatistics_Reviewers_New " + PrimaryKey + ", '" + strReviewerIDList + "'"
                                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))


                                'End of Comment by SatyanarayanaA
                            End If

                            'Added by SatyanarayanaA on 18-Jan-2006
                            Dim strRevieweeIDList As String
                            'Retrieve the RevieweeID list
                            strRevieweeIDList = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase12"))

                            'If strRevieweeIDList is not empty
                            If Not (strRevieweeIDList = ",," Or strRevieweeIDList = "") Then
                                ' Delete the entries of the reviewee who do not belong to the current list.
                                strSQL = "usp_Del_tbl_PM_ReviewStatistics_Authors " + PrimaryKey + ", '" + strRevieweeIDList + "'"
                                CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                ' For each reviewer in the new reviewee list, make an entry in the reviewee list.
                                'Commented by SatyanarayanaA on 10-Jan-2006
                                strSQL = "usp_Ins_tbl_PM_ReviewStatistics_Authors_New " + PrimaryKey + ", '" + strRevieweeIDList + "'"
                                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'End of Comment by SatyanarayanaA
                            End If

                            'Added by MrugajaB on 23rd Feb 2006 for Multiple reviewees feature (Issue ID.1835)
                            'Purpose:- update the work hrs of reviewers and reviewees as per work hrs of review
                            If Not (strReviewerIDList = ",," Or strReviewerIDList = "") Then
                                If CType(HttpContext.Current.Session("ReviewHrsChanged"), Integer) = 1 Then
                                    strSQL = "EXEC usp_sel_UpdateReviewWorkHrs " + PrimaryKey
                                    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    HttpContext.Current.Session.Remove("ReviewHrsChanged")
                                End If
                            End If
                            'End Addition

                            'Ended by SatyanarayanaA on 18-Jan-2006

                            '### Assign Task to Reviewer and Reviewee
                            Call AssignOrUpdateTasks(PrimaryKey, ControlsHashTable)

                            'Insert the observations that have same Reviewee, Reviewer and ReviewType with TrackToNextReview set
                            CommonFunction.Data.InsertOrUpdateData("usp_Upd_tbl_PM_GetReviewObservations " + PrimaryKey, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            'added by SachinR   on 28 Oct 2004
                            'update the review record for deliverable type ID, based on the selected Deliverable
                            strSQL = "usp_Upd_tbl_PM_ReviewStatistics " + PrimaryKey.Trim
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            'addition end

                            ''Added By Sagar Nipane on 28-Feb-2019 Purpose::Project Work field level changes 

                            Dim strSQLQuery As String
                            Dim WorkHourMinute As String
                            Dim WorkHour As String
                            Dim WorkMinute As String

                            WorkHourMinute = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase10"))

                            If WorkHourMinute = "" Then
                                WorkHourMinute = "00:00"
                            End If

                            WorkHour = WorkHourMinute.Substring(0, WorkHourMinute.IndexOf(":"))
                            WorkMinute = WorkHourMinute.Substring(WorkHourMinute.IndexOf(":") + 1)

                            If WorkHour = "" Then
                                WorkHour = "0"
                            End If
                            If WorkMinute = "" Then
                                WorkMinute = "0"
                            End If
                            If WorkMinute.Length = 1 Then
                                WorkMinute = WorkMinute + "0"
                            End If

                            strSQLQuery = "EXEC usp_Whizible2_upd_EstimatedEffortsForWBS " & PrimaryKey & ",'" & WorkHour & "','" & WorkMinute & "',6"
                            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, True)
                            ''End of Added By Sagar Nipane on 28-Feb-2019 Purpose::Project Work field level changes

                        Case CommonFunction.Constants.TAG_OPTION_BUTTONS, CommonFunction.Constants.TAG_GRID_FORMATTING_RULES, CommonFunction.Constants.TAG_COMPARISON_VALIDATIONS, CommonFunction.Constants.TAG_DEFAULT_PAGE_FILTERS
                            'For Master Tag Options buttons, Grid Formatting rules, Comparison Rules, Default Filters ...after deleting the record update the hash table
                            Call CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("TagID")), Long))
                            If WhizGlobal.TagID = CommonFunction.Constants.TAG_DEFAULT_PAGE_FILTERS Then
                                Dim sbScript As New System.Text.StringBuilder
                                sbScript.Append("<Script language=javascript>")
                                sbScript.Append("window.opener.document.forms['frmSample'].action = window.opener.location.href;")
                                sbScript.Append("window.opener.document.forms['frmSample'].submit();")
                                sbScript.Append("</Script>")
                                HttpContext.Current.Response.Write(sbScript.ToString)
                                sbScript = Nothing
                                If Not IsEditMode Then RedirectToCL = False
                            End If

                        Case CommonFunction.Constants.TAG_TAB_OPTION_BUTTONS, CommonFunction.Constants.TAG_TAB_GRID_FORMATTING_RULES, CommonFunction.Constants.TAG_TAB_COMPARISON_VALIDATIONS
                            'For Sub Tag Options buttons, Grid Formatting rules, Comparison Rules ...after deleting the record update the hash table
                            Call CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("ParentTag")), Long))

                        Case CommonFunction.Constants.APP_TAG_REVIEW_PLANNING
                            RedirectToCL = False
                            If IsEditMode = False Then 'First Time entry only
                                'added by SachinR   on 20 Nov 2004
                                'Issue ID - 14104
                                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("Reviewee"), "") <> "" Then
                                    'addition end   on 20 Nov 2004
                                    AfterSave += " if(confirm(" + Chr(34) + m_objTemplate.GetResourceString("PROJECT_REVIEW") + Chr(34) + ")) { " + vbCrLf
                                    AfterSave += "	window.open (" + Chr(34) + "../PM/PM_MapReviewTasks.aspx?ReviewStatisticsID=" + PrimaryKey + Chr(34) + ",null,""resizable=yes,scrollbars=no,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 350) / 2 + "",width=600,height=350"");" + vbCrLf
                                    AfterSave += " }"
                                End If
                            End If
                            'After save for Review Planning Tag
                            Dim strReviewerIDList As String
                            Dim strSQL As String
                            'Retrieve the ReviewerID list
                            strReviewerIDList = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase1"))
                            ' Delete the entries of the reviewers who do not belong to the current list.
                            strSQL = "usp_Del_tbl_PM_ReviewStatistics_Reviewers " + PrimaryKey + ", '" + strReviewerIDList + "'"
                            CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            ' For each reviewer in the new reviewer list, make an entry in the reviewer list.
                            strSQL = "usp_Ins_tbl_PM_ReviewStatistics_Reviewers_New " + PrimaryKey + ", '" + strReviewerIDList + "'"
                            CommonFunction.Data.SQLInsertOrUpdateData(strSQL)

                            'Added by SatyanarayanaA on 18-Jan-2006
                            Dim strRevieweeIDList As String
                            'Retrieve the RevieweeID list
                            strRevieweeIDList = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase12"))

                            'If strRevieweeIDList is not empty
                            If Not (strRevieweeIDList = ",," Or strRevieweeIDList = "") Then
                                ' Delete the entries of the reviewee who do not belong to the current list.
                                strSQL = "usp_Del_tbl_PM_ReviewStatistics_Authors " + PrimaryKey + ", '" + strRevieweeIDList + "'"
                                CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                ' For each reviewer in the new reviewee list, make an entry in the reviewee list.
                                'Commented by SatyanarayanaA on 10-Jan-2006
                                strSQL = "usp_Ins_tbl_PM_ReviewStatistics_Authors_New " + PrimaryKey + ", '" + strRevieweeIDList + "'"
                                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'End of Comment by SatyanarayanaA
                            End If

                            'Ended by SatyanarayanaA on 18-Jan-2006

                            '### Assign Task to Reviewer and Reviewee
                            Call AssignOrUpdateTasks(PrimaryKey, ControlsHashTable)

                            If IsEditMode = False Then
                                'Send mail for Review planning
                                AfterSave += SendMail_ReviewPlanned(PrimaryKey)
                            Else
                                'Send mail for Review reschedule
                                'Code Commented by DipaliS 20 Oct 2004 
                                'Dim oldReviewDate As Date
                                'Dim ReviewDate As Date
                                'oldReviewDate = CType(ControlsHashTable("NonDatabase3"), Date)
                                'ReviewDate = CType(ControlsHashTable("ReviewedDate"), Date)
                                'If oldReviewDate <> ReviewDate Then
                                '    'Review is Rescheduled
                                '    'AfterSave += SendMail_ReviewRescheculed(PrimaryKey, ControlsHashTable("NonDatabase3").ToString)
                                'End If
                                'Code Added by DipaliS 20 OCt 2004
                                Dim oldReviewStartDate As Date
                                Dim oldReviewEndDate As Date
                                Dim ReviewStartDate As Date
                                Dim ReviewEndDate As Date

                                If CType(ControlsHashTable("NonDatabase4"), String) <> "" Then
                                    oldReviewStartDate = CType(ControlsHashTable("NonDatabase4"), Date)
                                End If
                                ReviewStartDate = CType(ControlsHashTable("ReviewStartDate"), Date)

                                If CType(ControlsHashTable("NonDatabase5"), String) <> "" Then
                                    oldReviewEndDate = CType(ControlsHashTable("NonDatabase5"), Date)
                                End If
                                ReviewEndDate = CType(ControlsHashTable("ReviewEndDate"), Date)
                                If ((CType(ControlsHashTable("NonDatabase4"), String) <> "") And (oldReviewStartDate <> ReviewStartDate)) Or ((CType(ControlsHashTable("NonDatabase5"), String) <> "") And (oldReviewEndDate <> ReviewEndDate)) Then
                                    AfterSave += SendMail_ReviewRescheculed(PrimaryKey, ControlsHashTable("NonDatabase3").ToString, ControlsHashTable("NonDatabase4").ToString, ControlsHashTable("NonDatabase5").ToString)
                                End If
                                'End addition by DipaliS
                            End If
                            strActionCode = ReturnCodes.ON_LOAD.ToString

                            '------------------Commented out by AbhijeetD on 25th May------------------
                            '--------------for reverting Project Creation Workflow changes---------
                            'Case CommonFunction.Constants.TAG_PROJECT_INFORMATION
                            '    'Store the Revision Field history
                            '    Dim strSQL As String
                            '    Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
                            '    Dim drNonRevisionFields As IDataReader
                            '    Dim strSQLFieldValue As String

                            '    'Maintain the audit trail for Revision Fields
                            '    strSQL = "usp_Ins_tbl_PM_Revision " + PrimaryKey.ToString + ", '" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName")).ToString + "'"
                            '    CommonFunction.Data.InsertOrUpdateData(strsql, blnUseSQL)

                            '    'Update the Projects table for all fields other than Revision Fields
                            '    drNonRevisionFields = CommonFunction.Data.GetDataReader("usp_Sel_PM_NonRevisionFields", blnUseSQL)
                            '    strSQL = "UPDATE tbl_PM_ProjectRevision SET "
                            '    While drNonRevisionFields.Read
                            '        strSQLFieldValue = "SELECT [" + drNonRevisionFields("FieldName").ToString + "] FROM tbl_PM_ProjectRevision WHERE ProjectID = " + PrimaryKey.ToString
                            '        strSQL += "[" + drNonRevisionFields("FieldName").ToString + "] ="
                            '        strSQL += FormatValue(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLFieldValue, blnUseSQL)).tostring, drNonRevisionFields("DataType").ToString)
                            '        strSQL += ","
                            '    End While
                            '    strSQL = strSQL.Remove(strSQL.LastIndexOf(","), 1)
                            '    strSQL += " WHERE ProjectID = " + PrimaryKey.ToString
                            '    CommonFunction.Data.InsertOrUpdateData(strSQL, blnUseSQL)

                            '    'Update the IsRevision field
                            '    strSQL = "usp_Upd_tbl_PM_ProjectRevision_IsRevision_Save " + PrimaryKey.ToString
                            '    CommonFunction.Data.InsertOrUpdateData(strsql, blnUseSQL)

                            '    Dim strQueryString As String = HttpContext.Current.Current.Request.QueryString.ToString
                            '    'When the Project is Saved Refresh the Tree
                            '    AfterSave = "top.location.target = ""_top""" + vbCrLf
                            '    AfterSave += "top.location.href = " + Chr(34) + "Navigation.aspx?subPage=CommonPage.aspx&" + strQueryString + Chr(34) + ""
                            '    strActionCode = ReturnCodes.ON_LOAD.ToString

                            'Case CommonFunction.Constants.APP_TAG_WORKORDER
                            '    'Store the Revision Field history
                            '    Dim strSQL As String
                            '    Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
                            '    Dim drNonRevisionFields As IDataReader
                            '    Dim strSQLFieldValue As String

                            '    'Maintain the audit trail for Revision Fields
                            '    strSQL = "usp_Ins_tbl_PM_Revision " + PrimaryKey.ToString + ", '" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName")).ToString + "'"
                            '    CommonFunction.Data.InsertOrUpdateData(strsql, blnUseSQL)

                            '    'Update the Projects table for all fields other than Revision Fields
                            '    drNonRevisionFields = CommonFunction.Data.GetDataReader("usp_Sel_PM_NonRevisionFields", blnUseSQL)
                            '    strSQL = "UPDATE tbl_PM_Project SET "
                            '    While drNonRevisionFields.Read
                            '        strSQLFieldValue = "SELECT [" + drNonRevisionFields("FieldName").ToString + "] FROM tbl_PM_ProjectRevision WHERE ProjectID = " + PrimaryKey.ToString
                            '        strSQL += "[" + drNonRevisionFields("FieldName").ToString + "] ="
                            '        strSQL += FormatValue(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLFieldValue, blnUseSQL)).tostring, drNonRevisionFields("DataType").ToString)
                            '        strSQL += ","
                            '    End While
                            '    strSQL = strSQL.Remove(strSQL.LastIndexOf(","), 1)
                            '    strSQL += " WHERE ProjectID = " + PrimaryKey.ToString
                            '    CommonFunction.Data.InsertOrUpdateData(strSQL, blnUseSQL)

                            '    'Update the IsRevision field
                            '    strSQL = "usp_Upd_tbl_PM_ProjectRevision_IsRevision_Save " + PrimaryKey.ToString
                            '    CommonFunction.Data.InsertOrUpdateData(strsql, blnUseSQL)
                            '------------------------Commenting Ends----------------------


                            ''Added By Usha Pandit on 28-Feb-2019 Purpose::Project Work field level changes 
                            Dim strSQLQuery As String
                            Dim WorkHourMinute As String
                            Dim WorkHour As String
                            Dim WorkMinute As String

                            WorkHourMinute = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase20"))

                            If WorkHourMinute = "" Then
                                WorkHourMinute = "00:00"
                            End If

                            WorkHour = WorkHourMinute.Substring(0, WorkHourMinute.IndexOf(":"))
                            WorkMinute = WorkHourMinute.Substring(WorkHourMinute.IndexOf(":") + 1)

                            If WorkHour = "" Then
                                WorkHour = "0"
                            End If
                            If WorkMinute = "" Then
                                WorkMinute = "0"
                            End If
                            If WorkMinute.Length = 1 Then
                                WorkMinute = WorkMinute + "0"
                            End If

                            strSQLQuery = "EXEC usp_Whizible2_upd_EstimatedEffortsForWBS " & PrimaryKey & ",'" & WorkHour & "','" & WorkMinute & "',6"
                            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, True)
                            ''End of Added By Usha Pandit on 28-Feb-2019 Purpose::Project Work field level changes

                        Case CommonFunction.Constants.APP_TAG_PUBLISH_PROCESS
                            If IsEditMode = False Then
                                'Update the Status flag of tbl_PRS_Process_Draft table to "P"
                                Dim intProcessID As String = HttpContext.Current.Request.QueryString("ProcessID")
                                Dim intRevisionID As String = PrimaryKey
                                Dim intRevisionNo As String = CommonFunction.General.CheckIsNothing(ControlsHashTable("RevisionNo").ToString)
                                Dim strProcessStatus As String = "P"
                                Dim strRevisedBy As String = CommonFunction.General.CheckIsNothing(ControlsHashTable("RevisedBy"))
                                Dim strSQL As String = "usp_Upd_tbl_PRS_Process_DraftStatus " + intProcessID + "," + intRevisionID + "," + intRevisionNo + ",'" + strRevisedBy + "','" + strProcessStatus + "'"
                                CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                strSQL = "usp_Upd_PRS_Process_Published " + intProcessID + ", '" + strProcessStatus + "'"
                                CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'added by SachinR   on 16 Sep 2004
                                Dim strOUPoolID As String
                                strOUPoolID = HttpContext.Current.Request.Form("OUPoolID") + ""
                                AfterSave = "window.opener.location='CommonList.aspx?FromWhere=PRO&MasterTagId=1040&OUPoolID=" + strOUPoolID.Trim + "';"
                                AfterSave += " window.close();"
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                                RedirectToCL = False
                                'addition end
                            End If

                        Case CommonFunction.Constants.APP_TAG_PROCESS
                            If IsEditMode Then
                                'Update the Status flag of tbl_PRS_Process_Draft table to "D"
                                Dim strProcessID As String = PrimaryKey
                                Dim strRevisionID As String = "0"
                                Dim strRevisionNo As String = "0"
                                Dim strProcessStatus As String = "D"
                                Dim strRevisedBy As String = ""
                                Dim strSQL As String
                                Dim drReader As IDataReader
                                'Get the revision details
                                strSQL = "usp_Sel_Prs_RevisionDetails " + strProcessID
                                drReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drReader.Read Then
                                    strRevisionID = CommonFunction.Data.CheckIsDBNull(drReader("RevisionID"), "0").ToString
                                    strRevisionNo = CommonFunction.Data.CheckIsDBNull(drReader("RevisionNo"), "0").ToString
                                End If
                                CommonFunction.Data.DisposeDataReader(drReader)
                                strSQL = "usp_Upd_tbl_PRS_Process_DraftStatus " + strProcessID + "," + strRevisionID + "," + strRevisionNo + ",'" + strRevisedBy + "','" + strProcessStatus + "'"
                                CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            End If

                        Case CommonFunction.Constants.APP_TAG_COMPANY_INFORMATION, CommonFunction.Constants.APP_TAG_CORPORATE_SETTINGS

                            'Code added by SandipL on 9 Dec 2005 -- IssueID 672 -- to avoid DeadLock
                            If WhizGlobal.TagID = CommonFunction.Constants.APP_TAG_CORPORATE_SETTINGS Then
                                Dim strSQL As String
                                strSQL = "usp_tbl_PM_CompanyInformation_afterUpdateTriggers "
                                strSQL += CType(HttpContext.Current.Session("blnAllowResourceAllocation"), String) + ","
                                strSQL += CType(HttpContext.Current.Session("blnAllowLeaveWorkflow"), String) + ","
                                strSQL += CType(HttpContext.Current.Session("blnIsProjectCreationWorkflowReqd"), String) + ","
                                strSQL += CType(HttpContext.Current.Session("blnIncludeIR"), String) + ","
                                strSQL += CType(HttpContext.Current.Session("blnBackdatingNoDays"), String) + ","
                                strSQL += CType(HttpContext.Current.Session("blnForwardDatingNoDays"), String) + ",0"

                                'Added by MrugajaB on 6th Jan 2005 for WhizibleSEM 6.0 Build - General
                                'Purpose:For implementing share point style UI
                                strSQL += "," + CType(HttpContext.Current.Session("blnUseSharePointUI"), String)
                                'End Addition

                                'Added by VidyaJ - IssueID - 
                                'Purpose:For implementing Expense Workflow
                                strSQL += "," + CType(HttpContext.Current.Session("UseExpenseWorkflow"), String)
                                'End Addition

                                ' Added BY NitinVS on 28 Jun 2007 for WhizibleSEM 7 
                                strSQL += "," + CType(HttpContext.Current.Session("EnableProductExecution"), String)
                                ' End Addition BY NitinVS on 28 Jun 2007 for WhizibleSEM 7 

                                strSQL += "," + CType(HttpContext.Current.Session("EnableProjectProfitability"), String)

                                Dim blnStatus As Boolean = CBool(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "false"))
                                If blnStatus Then
                                    CommonEngines.HashTables.GetHashTableObject.ClearTreeHashTable()
                                End If
                                'Remove session variables
                                HttpContext.Current.Session.Remove("blnAllowResourceAllocation")
                                HttpContext.Current.Session.Remove("blnAllowLeaveWorkflow")
                                HttpContext.Current.Session.Remove("blnIsProjectCreationWorkflowReqd")
                                HttpContext.Current.Session.Remove("blnIncludeIR")
                                HttpContext.Current.Session.Remove("blnBackdatingNoDays")
                                HttpContext.Current.Session.Remove("blnForwardDatingNoDays")
                                HttpContext.Current.Session.Remove("UseExpenseWorkflow")
                                'End addition by SandipL on 9 Dec 2005

                                'Added by MrugajaB on 6th Jan 2005 for WhizibleSEM 6.0 Build - General
                                'Purpose:For implementing share point style UI
                                HttpContext.Current.Session.Remove("blnUseSharePointUI")
                                'End Addition
                                ' Added By NitinVS on 28 jun 2007 for WhizibleSEM 7
                                HttpContext.Current.Session.Remove("EnableProductExecution")
                                ' End Added By NitinVS on 28 jun 2007 for WhizibleSEM 7
                                HttpContext.Current.Session.Remove("EnableProjectProfitability")

                                ''''''''''''''''''''''''''''''''''
                                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("SMTPPassword")) <> "" Then
                                    strSQL = "usp_Upd_SMTPPassword '" + CommonFunctions.General.EncryptString(HttpContext.Current.Request.Form("SMTPPassword")) + "'"
                                    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                End If
                                ''''''''''''''''''''''''''''''''''
                            End If


                            'Reload Application Settings
                            Call CommonFunctions.General.GetCorporateSettings(True)
                            Call CommonFunction.General.LoadCompanyApplicationSettings()
                            'Added by DipaliS 15 Oct 2004
                            'Purpose    :   To Refresh the hashtable for Project Settings and Customer maintainance
                            CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CommonFunction.Constants.APP_TAG_PROJECT_SETTINGS)
                            CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CommonFunction.Constants.APP_TAG_CUSTOMER_MASTER)
                            'End addition by DipaliS

                            'Added by VidyaJ 24th Nov 2004
                            'Purpose    :   To Refresh the hashtable for Project Creation workflow
                            CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CommonFunction.Constants.TAG_ROLE_MAINTENANCE)
                            'End addition by VidyaJ

                            '3800:
                            'Added by NitinVS on 3 July 2007 for WhizibleSEM 7 
                            'Purpose    :   To Refresh the hashtable for Product Reprots
                            CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CommonFunction.Constants.APP_TAG_TAB_PRODUCT_REPORTS)
                            ''Added by PrashantSJ on 4 July 2007 For WhizibleSEM 7.0
                            ''Purpose: To refresh the hashtable while checking or unchecking of IR Workflow Checkbox
                            CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CommonFunction.Constants.APP_TAG_CORPORATE_SETTINGS)
                            ''End of addition  by PrashantSJ on 4 July 2007
                            'End addition by NitinVS on 3 July 2007 
                            ''Added by PrashantSJ on 27th Feb 2009
                            CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(3940)
                            CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(3941)
                            CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(3942)
                            CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(3943)
                            CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(3945)
                            CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(3946)
                            CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(3950)
                            ''End of addition by PrashantSJ on 27th Feb 2009
                            ''Added by PrashantSJ on 9th June 2009 Purpose: to referesh the company information hashtable
                        Case CommonFunction.Constants.APP_TAG_THEME
                            'Reload Application Settings
                            Call CommonFunctions.General.GetCorporateSettings(True)
                            Call CommonFunction.General.LoadCompanyApplicationSettings()
                            ''End of addition by PrashantSJ on 9th June 2009

                        Case CommonFunction.Constants.APP_TAG_CHECKLISTS
                        Case CommonFunction.Constants.TAG_DEFAULT_TAB_FILTERS
                            'Set the value of ParentTagID 
                            CommonFunction.Data.InsertOrUpdateData("usp_Upd_tbl_UI_TagDefaultFilters " + PrimaryKey + ", " + ControlsHashTable("TagID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            ''Code Commented by ManishK on 3rd Jan 06 as new inherited page is added for the leave page
                            '''Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEAPPLICATION
                            '''        If PrimaryKey.Trim() <> "" Then
                            '''            Dim strSQL As String
                            '''            strsql = "<script language = javascript>"
                            '''            strsql += "window.open('SendEmail.aspx?MessageID=68&LeaveID=" & PrimaryKey & "',null,'status=no,toolbar=no,menubar=no,location=no,width=600,height=500');"
                            '''            strsql += "</script>"
                            '''            CommonFunction.General.WriteHTML(strsql)
                            '''        End If
                            ''End of Code Commented by ManishK on 3rd Jan 06 as new inherited page is added for the leave page

                            'added by   SachinR     On  08 Apr 2004
                            'To insert record in the tbl_pm_projectTasks table for the RiskID and projectID
                            'for each record in the tbl_pm_contingencyPlan table.
                        Case CommonFunction.Constants.APP_TAG_RISKS

                            If HttpContext.Current.Request.Form("NonDatabase1") = "Yes" Then
                                Dim strProjectID, strSQL As String

                                strProjectID = HttpContext.Current.Session("intProjectID").ToString + ""

                                strSQL = "usp_ins_tbl_pm_ProjectTasks_ContingencyPlans " + PrimaryKey.Trim + "," + strProjectID.Trim
                                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            End If
                            'addition end

                            '------------------Commented out by AbhijeetD on 25th May------------------
                            '--------------for reverting Project Creation Workflow changes---------
                        Case CommonFunction.Constants.APP_TAG_CREATE_PROJECT

                            Dim intErrorCode As Integer
                            Dim strError As String = ""
                            Dim strScript As String
                            Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
                            intErrorCode = CType(HttpContext.Current.Session("intJobCodeError"), Integer)
                            If Not intErrorCode = 0 Then
                                strError = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT ErrorDescription FROM tbl_PM_JobCodeError WHERE ErrorCode =" + intErrorCode.ToString, blnUseSQL)).ToString
                                strScript = "alert('" + strError + "');"
                                AfterSave = strScript
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            ElseIf intErrorCode = 0 Then
                                Dim strSQL As String
                                Dim intCreateProject As Integer
                                Dim strJobCode As String

                                'If CommonFunction.Data.CheckIsDBNull(ControlsHashTable("CreateProjectGroup")).ToString = "" Then
                                'intCreateProject = 0
                                'Else
                                'intCreateProject = 1
                                'End If
                                If Not HttpContext.Current.Session("strJobCode").ToString = "" Then
                                    strJobCode = "'" + HttpContext.Current.Session("strJobCode").ToString + "'"
                                Else
                                    strJobCode = "NULL"
                                End If
                                'Modified by MrugajaB on 29th Dec 2005
                                'Purpose:- Page was getting crashed if space character is entered in 'prject Value' Textbox ,trim was not used
                                'strSQL = "usp_Ins_PM_JobCode " & PrimaryKey.ToString & ", " & strJobCode.ToString & ", " & IIf(ControlsHashTable("ContractValue").ToString = "", "NULL", ControlsHashTable("ContractValue").ToString).ToString & ", " & intCreateProject.ToString & ", " & ControlsHashTable("CustomerID").ToString & ", '" & HttpContext.Current.Session("strUserName").ToString & "'"
                                'Modified by SonalD on 13th March 2009 for IssueID 27881
                                'Purpose : To Handle single quote(') in UserName
                                'strSQL = "usp_Ins_PM_JobCode " & PrimaryKey.ToString & ", " & strJobCode.ToString & ", " & IIf(Trim(CommonFunction.Data.CheckIsDBNull(ControlsHashTable("ContractValue")).ToString) = "", "NULL", ControlsHashTable("ContractValue").ToString).ToString & ", " & intCreateProject.ToString & ", " & ControlsHashTable("CustomerID").ToString & ", '" & HttpContext.Current.Session("strUserName").ToString & "'"
                                strSQL = "usp_Ins_PM_JobCode " & PrimaryKey.ToString & ", " & strJobCode.ToString & ", " & IIf(Trim(CommonFunction.Data.CheckIsDBNull(ControlsHashTable("ContractValue")).ToString) = "", "NULL", ControlsHashTable("ContractValue").ToString).ToString & ", " & intCreateProject.ToString & ", " & ControlsHashTable("CustomerID").ToString & ", '" & strUser & "'"
                                'End of modification  by SonalD on 13th March 2009, for IssueID 27881
                                'End Modification
                                CommonFunction.Data.InsertOrUpdateData(strSQL, blnUseSQL)

                                strSQL = "usp_Ins_tbl_PM_ProjectFixedBid_Revision_New_Project " + PrimaryKey
                                CommonFunction.Data.InsertOrUpdateData(strSQL, blnUseSQL)

                                'Clear the session variables for job code
                                HttpContext.Current.Session("intJobCodeError") = ""
                                HttpContext.Current.Session("strJobCode") = ""

                                'HttpContext.Current.Session("intJobCode") = PrimaryKey
                                'Code Added By VidyaJ on 9th Nov 2004
                                'Default Assignment to project will be done only
                                'if resource allocation workflow is not enabled
                                'Modified by ShamkantD on 1 Dec 2004
                                'Commented per Vidya's suggestion, this validation will not be required any more.
                                'Dim intAllowResourceAllocation As Integer
                                'intAllowResourceAllocation = CType(CommonFunction.Data.GetDataScalar("SELECT AllowResourceAllocation from tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)

                                'If intAllowResourceAllocation = 0 Then
                                'Assign to the new Project
                                Call AssignProject(CType(PrimaryKey, Long))
                                'End If
                                'End of modification - ShamkantD on 1 Dec 2004

                                'When the Project is Saved Refresh the Tree
                                'Dim strProjectName As String = HttpContext.Current.Server.UrlEncode(CommonFunctions.General.CheckIsNothing(ControlsHashTable("ProjectName")))
                                'Dim strProjectName As String = CommonFunctions.General.CheckIsNothing(ControlsHashTable("ProjectName"))
                                'AfterSave = "top.location.target = ""_top""" + vbCrLf
                                'HttpContext.Current.Session("strJobCode") = strProjectName

                                '--- Commented and Added By Purvaj 26 Sept 2008 for Firefox issue
                                'AfterSave += "window.navigate(""../General/CommonList.aspx?MasterTagID=32&FromWhere=PM"")"
                                AfterSave = "window.location.href = ""../General/CommonList.aspx?MasterTagID=32&FromWhere=PM"" "
                                '--- End comment and addition By Purvaj

                                strActionCode = ReturnCodes.ON_LOAD.ToString



                            End If
                            '  ------------------------Commenting Ends----------------------
                            'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
                            'Added By PradipK on 22 March 2006 for SLA Management
                            'Purpose: To Add Corporate Level SLA to Project Level
                            Dim strSQLSLA As String
                            strSQLSLA = "usp_Ins_Issue_SLA   " + PrimaryKey
                            CommonFunction.Data.SQLInsertOrUpdateData(strSQLSLA)
                            strSQLSLA = "usp_Ins_tbl_PM_ProjectWorkingHours   " + PrimaryKey
                            CommonFunction.Data.SQLInsertOrUpdateData(strSQLSLA)
                            'End Addition By PradipK on 22 March 2006 for SLA Management
                            ' Added bY PrashantSJ on 14th Nov 2008 for WhizibleSEM 8 (Project Profitability)
                            'Modified by SonalD on 13th March 2009 for IssueID 27881
                            'Purpose : To Handle single quote(') in UserName
                            'CommonFunction.Data.InsertOrUpdateData("usp_Ins_DefaultProjectSite " + PrimaryKey.ToString + ",N'" + HttpContext.Current.Session("strUserName").ToString + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            CommonFunction.Data.InsertOrUpdateData("usp_Ins_DefaultProjectSite " + PrimaryKey.ToString + ",N'" + strUser + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            'End of modification by sonalD on 13th March 2009
                            'End of addition by PrashantSJ on 14th Nov 2008 for WhizibleSEM 8 (Project Profitability)
                            '-------------- added By PurvaJ on 5 May 2008 
                            '-------------- for configurable workflow. Inherit corporate setting at project level


                            'CommonFunction.Data.InsertOrUpdateData("usp_Upd_tbl_IM_ProjectAttributes " + PrimaryKey.ToString + ",NULL,NULL,N'" + HttpContext.Current.Session("strUserName").ToString + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            CommonFunction.Data.InsertOrUpdateData("usp_Upd_tbl_IM_ProjectAttributes " + PrimaryKey.ToString + ",NULL,NULL,N'" + strUser + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            'CommonFunction.Data.InsertOrUpdateData("usp_Ins_InheritWorkflowDefinationAtProjectLevel " + PrimaryKey.ToString + ",N'" + HttpContext.Current.Session("strUserName").ToString + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            CommonFunction.Data.InsertOrUpdateData("usp_Ins_InheritWorkflowDefinationAtProjectLevel " + PrimaryKey.ToString + ",N'" + strUser + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '-------------- End Addition PurvaJ
                            ''Added By Aniruddh Gujar on 01-Mar-2018 Purpose::To inherit the Agile Data on Project
                            Dim IsAgile As String
                            IsAgile = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("EXEC usp_NG2_chk_IsAgileProject " & PrimaryKey.ToString, True), "1")
                            If IsAgile <> 0 Then
                                CommonFunction.Data.InsertOrUpdateData("usp_NG2_InheritAgileDataOnProject " + PrimaryKey.ToString + ",N'" + strUser + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            End If
                            ''End of Added By Aniruddh Gujar on 01-Mar-2018 Purpose::To inherit the Agile Data on Project

                            'added by SachinR   on 15 Jul 2004
                            'Added by ShraddhaM on 17,Sept 2008
                            'Purpose : To create project when opportunity is closed in Whiziblesem8.0
                            Dim FromWhere As String
                            Dim OpportunityID As String
                            FromWhere = HttpContext.Current.Request.QueryString("From")
                            OpportunityID = HttpContext.Current.Request.QueryString("opportunityID")
                            If FromWhere Is Nothing Then
                                FromWhere = HttpContext.Current.Request.Form("hidFrom")
                            End If
                            If OpportunityID Is Nothing Then
                                OpportunityID = HttpContext.Current.Request.Form("hidOppID")
                            End If
                            If FromWhere = "DEMAND" Then
                                CommonFunction.Data.InsertOrUpdateData("usp_upd_Opportunity_ConvertedToProject " + PrimaryKey.ToString() + "," + OpportunityID, True)
                                CommonFunction.Data.InsertOrUpdateData("usp_INS_TeamStructure_ConvertedProjects " + PrimaryKey.ToString() + "," + OpportunityID, True)

                                'strScript = "<script language = javascript>"
                                'AfterSave = "refreshParent('frmCommonPage','HR_Opportunity_CommonPage.aspx','../HR/HR_Opportunity_CommonPage.aspx?MasterTagID=3851');"
                                'AfterSave = "refreshParent('frmCommonPage','HR_Opportunity_CommonPage.aspx','../HR/HR_Opportunity_CommonPage.aspx?MasterTagID=3851');"
                                'AfterSave = "var objPKTokene = GetParentObjectReference('frmCommonPage','PKToken');"

                                'Added by SonalD on 30th Sept 2008
                                AfterSave = "var objPKTokene=window.opener.document.forms['frmCommonPage'].elements['PKToken'];"
                                AfterSave += vbCrLf + "alert('Project created successfully');"
                                AfterSave += vbCrLf + "opener.location.href='../HR/HR_Opportunity_CommonPage.aspx?MasterTagID=3851&OpportunityID_PK=" + OpportunityID + "&FromWhere=RM&PKToken='+objPKTokene.value+'&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1';"
                                AfterSave += vbCrLf + "window.close();"
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                                'End of addition by sonalD on 30th Sept 2008

                                'strScript += "</script>"
                                'CommonFunction.General.WriteHTML(strScript)
                            End If
                            'Modified by SonalD on 13th March 2009 for IssueID 27881
                            'Purpose : To Handle single quote(') in UserName
                            'CommonFunction.Data.InsertOrUpdateData("usp_Ins_tbl_PM_WorkOrderCosts_Inherits_ForProject " + PrimaryKey.ToString + ",N'" + HttpContext.Current.Session("strUserName").ToString + "'", True)
                            CommonFunction.Data.InsertOrUpdateData("usp_Ins_tbl_PM_WorkOrderCosts_Inherits_ForProject " + PrimaryKey.ToString + ",N'" + strUser + "'", True)
                            'End of modification by sonalD on 13th March 2009

                        Case CommonFunction.Constants.APP_TAG_CUSTOMER_MASTER
                            Dim FromWhere As String
                            Dim OpportunityID As String
                            Dim strScript As String

                            FromWhere = HttpContext.Current.Request.QueryString("From")
                            OpportunityID = HttpContext.Current.Request.QueryString("opportunityID")
                            If FromWhere Is Nothing Then
                                FromWhere = HttpContext.Current.Request.Form("hidFrom")
                            End If
                            If OpportunityID Is Nothing Then
                                OpportunityID = HttpContext.Current.Request.Form("hidOppID")
                            End If
                            If FromWhere = "DEMAND" Then
                                CommonFunction.Data.InsertOrUpdateData("usp_upd_Opportunity_CreatedCustomer " + OpportunityID + "," + PrimaryKey, True)
                                'strScript = "<script language = javascript>"
                                'strScript += "window.close();"
                                'strScript += "</script>"

                                'Added by SonalD on 30th Sept 2008
                                AfterSave = "var objPKTokene=window.opener.document.forms['frmCommonPage'].elements['PKToken'];"
                                AfterSave += vbCrLf + "alert('Customer created successfully');"
                                AfterSave += vbCrLf + "opener.location.href='../HR/HR_Opportunity_CommonPage.aspx?MasterTagID=3851&OpportunityID_PK=" + OpportunityID + "&FromWhere=RM&PKToken='+objPKTokene.value+'&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1';"
                                AfterSave += vbCrLf + "window.close();"
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                                'End of addition by sonalD on 30th Sept 2008

                            End If
                            'Ended by ShraddhaM on 17,Sept 2008
                        Case CommonFunction.Constants.APP_TAG_SDLC_SAVE_WITH_REVISION
                            'Increment Revision number
                            Dim SQL As String = "usp_Ins_Save_Revisions null," + WhizGlobal.ProjectID.ToString
                            Call CommonFunctions.Data.InsertOrUpdateData(SQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            'addition end

                            'added by SachinR   on 22 Jul 2004
                            'purpose    To implement Process definition workflow
                        Case CommonFunction.Constants.APP_TAG_PROCESS_PHASETASK
                            Dim strSQL As String
                            If IsEditMode = True Then
                                'added by SachinR   on 1 Sep 2004
                                'delete related acvity records if tasktype is changed
                                If HttpContext.Current.Session("TaskTypeChanged").ToString.ToUpper = "YES" Then
                                    strSQL = "usp_Upd_PhaseTaskTypeChanged_DeleteActivity " + PrimaryKey.Trim
                                    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                End If
                                HttpContext.Current.Session.Remove("TaskTypeChanged")
                                'addition end
                            End If

                            ' Modified By NitinVS on 28 Feb 2005 for WhizibleE SP2 
                            ' The Update SP is callled Through Trigger 
                            'If PrimaryKey <> "" Then
                            '    'update the status of the phase task from published(P) to Draft(D).

                            '    strSQL = "usp_Upd_UpdatePhaseTaskDraftStatus " + PrimaryKey.Trim
                            '    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            'End If

                            ' End Modification By NitinVS on 28 Feb 2005 

                            'added by SachinR   on 28 jul 2004
                        Case CommonFunction.Constants.APP_TAG_PROCESS_PHASETASK_PUBLISH
                            'modified by SachinR    on 30 Jul 2004
                            'issue 12182
                            If IsEditMode = False Then
                                Dim strRevisionID As String
                                Dim strSQL As String

                                strRevisionID = PrimaryKey
                                strSQL = "usp_Ins_tbl_PRS_PhaseTask_Publish_PublishPhaseTask " + strRevisionID.Trim
                                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            End If
                            'modification end
                            'addition end

                            ' WhizibleE SP2
                            ' Commented By NitinVS on 24 Feb 2005 
                            ' This Update SP is called through Trigger only if the field values are changed

                            '        'added by SachinR   on 29 Jul 2004
                            '        'purpose    To implement Process definition workflow
                            'Case CommonFunction.Constants.APP_TAG_PROCESS_PHASETASK_TEMPLATES
                            '        If PrimaryKey <> "" Then
                            '            'update the status of the template from published(P) to Draft(D).
                            '            Dim strSQL As String

                            '            strSQL = "usp_upd_PRS_UpdatePhaseTaskTemplateDraftStatus " + PrimaryKey.Trim
                            '            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '        End If
                            '        'addition end

                            ' End Addition by NitinVS 24 FEb 2005 
                            ' PBNIET SP2 

                            'added by SachinR   on 29 jul 2004
                        Case CommonFunction.Constants.APP_TAG_PROCESS_PHASETASK_TEMPLATE_PUBLISH
                            'modified by SachinR    on 30 Jul 2004
                            'issue 12182
                            If IsEditMode = False Then
                                Dim strRevisionID As String
                                Dim strSQL As String

                                strRevisionID = PrimaryKey
                                strSQL = "usp_Ins_PhaseTask_PublishTemplate " + strRevisionID.Trim
                                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            End If
                            'modification end
                            'saddition end

                            ' Added By JayavantK on 28-Jun-2004 - Start
                            'Code added by PrashantD on 19 Jan 2008 for Resource Demand Enhancment
                            'Case CommonFunction.Constants.APP_TAG_RESOURCEREQUEST
                        Case CommonFunction.Constants.APP_TAG_RESOURCEREQUEST, CommonFunction.Constants.APP_TAG_EXTENDRESOURCEREQUEST
                            Dim strQuery As String = ""
                            Dim strStatus As String = ""
                            Dim strScript As String = ""
                            Dim lngRequestID As Long = 0
                            lngRequestID = CType("0" & CommonFunctions.General.CheckIsNothing(PrimaryKey, "0"), Long)
                            If lngRequestID <> 0 Then
                                'Integrated by ShraddhaM for Resource Allocation on 28,Aug 2009
                                'Added by SanaS on 18-Aug-2009
                                'Purpose: Storing WorkHrsPErDay,TotalHrs and %Allocation in Every Request. Irrespective of Type of Allocation
                                If lngRequestID <> 0 Then
                                    strQuery = "Exec usp_upd_RequestWorkHrs_Details " & lngRequestID.ToString()
                                    CommonFunction.Data.InsertOrUpdateData(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                End If
                                'End Addition by SanaS on 18-Aug-2009
                                'Ended Integration by ShraddhaM
                                strQuery = "Exec usp_Sel_tbl_PM_ResourceRequest_GetStatus " & lngRequestID.ToString()
                                strStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                                strStatus = strStatus.Trim().ToUpper()
                                If strStatus = "R" Then
                                    strQuery = "Exec usp_Sel_tbl_PM_ResourceRequestDetails_Skills " & lngRequestID.ToString()
                                    If CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "") = "" Then
                                        strScript = "<script language = javascript>"
                                        strScript += "alert('" + m_objTemplate.GetResourceString("ADD_SKILLS_IN_RESOURCE_REQUEST") + "');"
                                        strScript += "</script>"
                                        CommonFunction.General.WriteHTML(strScript)
                                        HttpContext.Current.Session.Item("SELECT_SUBTAG") = 1
                                    End If
                                End If
                            End If
                            ' Added By JayavantK on 28-Jun-2004 - End

                            ' Added By JayavantK on 30-Jul-2004 - Start
                        Case CommonFunction.Constants.APP_TAG_RESOURCE_REQUEST_ESCALATION
                            'add client side script for refresing the main page (PM_RESOURCEALLOCATION.ASPX)
                            'and closing intermediate page as per call for this page
                            Dim strScript As String
                            strScript = "<script language = javascript>" + vbCrLf
                            strScript += "window.open('SendEmail.aspx?MessageID=426&EmployeeID=" & WhizGlobal.UserID & "&RequestID=" & HttpContext.Current.Request("RequestID").ToString & "',null,'status=no,toolbar=no,menubar=no,width=600,height=500');" + vbCrLf
                            strScript += "var strParentPage;" + vbCrLf
                            strScript += "strParentPage = new String();" + vbCrLf
                            strScript += "strParentPage = window.opener.location.href;" + vbCrLf
                            strScript += "if (strParentPage.toUpperCase().indexOf('PM_RESOURCEALLOCATION.ASPX') != -1)" + vbCrLf
                            strScript += "{ window.opener.document.forms['frmPM_ResourceAllocation'].action = '../PM/PM_ResourceAllocation.aspx?FromWhere=RM&MasterTagID=1225';" + vbCrLf
                            strScript += "window.opener.document.forms['frmPM_ResourceAllocation'].submit();}" + vbCrLf
                            strScript += "else" + vbCrLf
                            strScript += "{ var strParentPages;" + vbCrLf
                            strScript += "strParentPages = new String();" + vbCrLf
                            strScript += "strParentPages = window.opener.opener.location.href;" + vbCrLf
                            strScript += "if (strParentPages.toUpperCase().indexOf('PM_RESOURCEALLOCATION.ASPX') != -1)" + vbCrLf
                            strScript += "{ window.opener.opener.document.forms['frmPM_ResourceAllocation'].action = '../PM/PM_ResourceAllocation.aspx?FromWhere=RM&MasterTagID=1225';" + vbCrLf
                            strScript += "window.opener.opener.document.forms['frmPM_ResourceAllocation'].submit();" + vbCrLf
                            strScript += "window.opener.close();}}" + vbCrLf
                            strScript += "window.close();" + vbCrLf
                            strScript += "</script>"
                            CommonFunction.General.WriteHTML(strScript)

                        Case CommonFunction.Constants.APP_TAG_RESOURCE_REQUEST_ESCALATION_TO_OUPOOL
                            'add client side script for refresing the main page (PM_RESOURCEALLOCATION.ASPX)
                            'and closing intermediate page as per call for this page
                            Dim strScript As String
                            strScript = "<script language = javascript>" + vbCrLf
                            strScript += "window.open('SendEmail.aspx?MessageID=427&EmployeeID=" & WhizGlobal.UserID & "&RequestID=" & HttpContext.Current.Request("RequestID").ToString & "',null,'status=no,toolbar=no,menubar=no,width=600,height=500');" + vbCrLf
                            strScript += "var strParentPage;" + vbCrLf
                            strScript += "strParentPage = new String();" + vbCrLf
                            strScript += "strParentPage = window.opener.location.href;" + vbCrLf
                            strScript += "if (strParentPage.toUpperCase().indexOf('PM_RESOURCEALLOCATION.ASPX') != -1)" + vbCrLf
                            strScript += "{ window.opener.document.forms['frmPM_ResourceAllocation'].action = '../PM/PM_ResourceAllocation.aspx?FromWhere=RM&MasterTagID=1225';" + vbCrLf
                            strScript += "window.opener.document.forms['frmPM_ResourceAllocation'].submit();}" + vbCrLf
                            strScript += "else" + vbCrLf
                            strScript += "{ var strParentPages;" + vbCrLf
                            strScript += "strParentPages = new String();" + vbCrLf
                            strScript += "strParentPages = window.opener.opener.location.href;" + vbCrLf
                            strScript += "if (strParentPages.toUpperCase().indexOf('PM_RESOURCEALLOCATION.ASPX') != -1)" + vbCrLf
                            strScript += "{ window.opener.opener.document.forms['frmPM_ResourceAllocation'].action = '../PM/PM_ResourceAllocation.aspx?FromWhere=RM&MasterTagID=1225';" + vbCrLf
                            strScript += "window.opener.opener.document.forms['frmPM_ResourceAllocation'].submit();" + vbCrLf
                            strScript += "window.opener.close();}}" + vbCrLf
                            strScript += "window.close();" + vbCrLf
                            strScript += "</script>"
                            CommonFunction.General.WriteHTML(strScript)

                        Case CommonFunction.Constants.APP_TAG_RESOURCE_REQUEST_ESCALATION_TO_GLOBALPOOL
                            'add client side script for refresing the main page (PM_RESOURCEALLOCATION.ASPX)
                            'and closing intermediate page as per call for this page
                            Dim strScript As String
                            strScript = "<script language = javascript>" + vbCrLf
                            strScript += "window.open('SendEmail.aspx?MessageID=432&EmployeeID=" & WhizGlobal.UserID & "&RequestID=" & HttpContext.Current.Request("RequestID").ToString & "',null,'status=no,toolbar=no,menubar=no,width=600,height=500');" + vbCrLf
                            strScript += "var strParentPage;" + vbCrLf
                            strScript += "strParentPage = new String();" + vbCrLf
                            strScript += "strParentPage = window.opener.location.href;" + vbCrLf
                            strScript += "if (strParentPage.toUpperCase().indexOf('PM_RESOURCEALLOCATION.ASPX') != -1)" + vbCrLf
                            strScript += "{ window.opener.document.forms['frmPM_ResourceAllocation'].action = '../PM/PM_ResourceAllocation.aspx?FromWhere=RM&MasterTagID=1225';" + vbCrLf
                            strScript += "window.opener.document.forms['frmPM_ResourceAllocation'].submit();}" + vbCrLf
                            strScript += "else" + vbCrLf
                            strScript += "{ var strParentPages;" + vbCrLf
                            strScript += "strParentPages = new String();" + vbCrLf
                            strScript += "strParentPages = window.opener.opener.location.href;" + vbCrLf
                            strScript += "if (strParentPages.toUpperCase().indexOf('PM_RESOURCEALLOCATION.ASPX') != -1)" + vbCrLf
                            strScript += "{ window.opener.opener.document.forms['frmPM_ResourceAllocation'].action = '../PM/PM_ResourceAllocation.aspx?FromWhere=RM&MasterTagID=1225';" + vbCrLf
                            strScript += "window.opener.opener.document.forms['frmPM_ResourceAllocation'].submit();" + vbCrLf
                            strScript += "window.opener.close();}}" + vbCrLf
                            strScript += "window.close();" + vbCrLf
                            strScript += "</script>"
                            CommonFunction.General.WriteHTML(strScript)

                        Case CommonFunction.Constants.APP_TAG_RESOURCE_REQUEST_ESCALATION_TO_BGPOOL
                            'add client side script for refresing the main page (PM_RESOURCEALLOCATION.ASPX)
                            'and closing intermediate page as per call for this page
                            Dim strScript As String
                            strScript = "<script language = javascript>" + vbCrLf
                            strScript += "window.open('SendEmail.aspx?MessageID=430&EmployeeID=" & WhizGlobal.UserID & "&RequestID=" & HttpContext.Current.Request("RequestID").ToString & "',null,'status=no,toolbar=no,menubar=no,width=600,height=500');" + vbCrLf
                            strScript += "var strParentPage;" + vbCrLf
                            strScript += "strParentPage = new String();" + vbCrLf
                            strScript += "strParentPage = window.opener.location.href;" + vbCrLf
                            strScript += "if (strParentPage.toUpperCase().indexOf('PM_RESOURCEALLOCATION.ASPX') != -1)" + vbCrLf
                            strScript += "{ window.opener.document.forms['frmPM_ResourceAllocation'].action = '../PM/PM_ResourceAllocation.aspx?FromWhere=RM&MasterTagID=1225';" + vbCrLf
                            strScript += "window.opener.document.forms['frmPM_ResourceAllocation'].submit();}" + vbCrLf
                            strScript += "else" + vbCrLf
                            strScript += "{ var strParentPages;" + vbCrLf
                            strScript += "strParentPages = new String();" + vbCrLf
                            strScript += "strParentPages = window.opener.opener.location.href;" + vbCrLf
                            strScript += "if (strParentPages.toUpperCase().indexOf('PM_RESOURCEALLOCATION.ASPX') != -1)" + vbCrLf
                            strScript += "{ window.opener.opener.document.forms['frmPM_ResourceAllocation'].action = '../PM/PM_ResourceAllocation.aspx?FromWhere=RM&MasterTagID=1225';" + vbCrLf
                            strScript += "window.opener.opener.document.forms['frmPM_ResourceAllocation'].submit();" + vbCrLf
                            strScript += "window.opener.close();}}" + vbCrLf
                            strScript += "window.close();" + vbCrLf
                            strScript += "</script>"
                            CommonFunction.General.WriteHTML(strScript)

                            ' Added By JayavantK on 30-Jul-2004 - End
                            'Added By NileshD on 2 & 3 August 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_CHANGE_STATUS
                            Dim strScript As String
                            ''Start
                            ''JyotiG
                            ''Issue Id : 6197
                            'Dim strRFIId As String
                            'Dim strUserId As String
                            'Dim m_intTagID As String
                            'Dim strUserType As String
                            'Dim m_MasterTagID As String
                            'Dim strPrjId As String
                            'm_strToken = HttpContext.Current.Request.Form("txtToken") + "" 'HttpContext.Current.Request.QueryString("PKToken").ToString
                            'strRFIId = HttpContext.Current.Request.QueryString("RFIID") & ""
                            'strUserId = HttpContext.Current.Session("intUserID").ToString
                            'strUserType = HttpContext.Current.Request.QueryString("ChangedBy") & ""
                            'strPrjId = ControlsHashTable("ProjectID").ToString
                            '''Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
                            'If HttpContext.Current.Request.QueryString("CreatedBy") = "Initiator" Then
                            '    If CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String), m_strToken) = False Or m_strToken = "" Then
                            '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("IR/PIR", CType(2044, Long), CType(0, Long), "RFIID", HttpContext.Current.Request.QueryString("RFIID").ToString)

                            '        'Token is Invalid now redirect to the Invalid Access Page
                            '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                            '    End If
                            'End If
                            ''End of addition by MonikaI

                            'If strUserType = "Approver" Then
                            '    m_MasterTagID = "2074"
                            'Else
                            '    m_MasterTagID = "2083"
                            'End If
                            'm_intTagID = "0"
                            'If CommonFunctions.Security.Token.ValidateToken(CType(strRFIId, String) + CType(strUserId, String) + CType(m_MasterTagID, String) + CType(m_intTagID, String) + CType(strPrjId, String), m_strToken) = False Or m_strToken = "" Then
                            '    'Token is Invalid now redirect to the Invalid Access Page
                            '    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                            'End If
                            ''End

                            'End
                            strScript = "<script language = javascript>" + vbCrLf
                            If ControlsHashTable("CurrentRFIStatus").ToString.ToUpper = "APPROVED" Then
                                strScript += "window.open('SendEmail.aspx?MessageID=52&RFIID=" & ControlsHashTable("RFIID").ToString & "',null,'status=no,toolbar=no,menubar=no,width=600,height=500');" + vbCrLf
                                If ControlsHashTable("NonDatabase2").ToString.ToUpper <> "NONE" Then
                                    If ControlsHashTable("NonDatabase2").ToString.ToUpper = "APPROVER" Then
                                        strScript += "var strParentPages;" + vbCrLf
                                        strScript += "strParentPages = new String();" + vbCrLf
                                        strScript += "strParentPages = window.opener.location.href;" + vbCrLf
                                        strScript += "if (strParentPages.toUpperCase().indexOf('COMMONLIST.ASPX') != -1)" + vbCrLf
                                        strScript += "{ window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?FromWhere=FA&MasterTagID=2074';" + vbCrLf
                                        strScript += "window.opener.document.forms['frmCommonList'].submit();}" + vbCrLf
                                        strScript += "window.close();" + vbCrLf
                                    ElseIf ControlsHashTable("NonDatabase2").ToString.ToUpper = "DETAILS" Then
                                        strScript += "var strParentPages;" + vbCrLf
                                        strScript += "strParentPages = new String();" + vbCrLf
                                        strScript += "strParentPages = window.opener.location.href;" + vbCrLf
                                        strScript += "if (strParentPages.toUpperCase().indexOf('RFI_RFI.ASPX') != -1)" + vbCrLf
                                        strScript += "{ window.opener.document.forms['frmRFI_RFI'].action = '../RFI/RFI_RFI.aspx?Mode=Edit&UserType=Approver&FromStatus=1&RFIID=" + ControlsHashTable("RFIID").ToString + "';" + vbCrLf
                                        strScript += "window.opener.document.forms['frmRFI_RFI'].submit();}" + vbCrLf
                                        strScript += "window.close();" + vbCrLf
                                    End If
                                End If


                            ElseIf ControlsHashTable("CurrentRFIStatus").ToString.ToUpper = "SUBMITTED" Then
                                If ControlsHashTable("NonDatabase2").ToString.ToUpper <> "NONE" Then
                                    strScript += "window.open('SendEmail.aspx?MessageID=51&RFIID=" & ControlsHashTable("RFIID").ToString & "',null,'status=no,toolbar=no,menubar=no,width=600,height=500');" + vbCrLf
                                    'If called from RFI Details Page
                                    If ControlsHashTable("NonDatabase2").ToString.ToUpper = "DETAILS" Then
                                        strScript += "var strParentPages;" + vbCrLf
                                        strScript += "strParentPages = new String();" + vbCrLf
                                        strScript += "strParentPages = window.opener.location.href;" + vbCrLf
                                        strScript += "if (strParentPages.toUpperCase().indexOf('RFI_RFI.ASPX') != -1)" + vbCrLf
                                        strScript += "{window.opener.document.forms['frmRFI_RFI'].action = '../RFI/RFI_RFI.aspx?Mode=Edit&FromStatus=1&UserType=Initiator&RFIID=" + ControlsHashTable("RFIID").ToString + "';" + vbCrLf
                                        strScript += "var objCustomer= window.opener.document.forms['frmRFI_RFI'].cboCustomerID;" + vbCrLf
                                        strScript += "var objRFIType= window.opener.document.forms['frmRFI_RFI'].cboRFITypeID;" + vbCrLf
                                        strScript += "var objBilling= window.opener.document.forms['frmRFI_RFI'].cboBillingCurrencyID;" + vbCrLf
                                        strScript += " objCustomer.disabled = false;" + vbCrLf
                                        strScript += "objRFIType.disabled = false;" + vbCrLf
                                        strScript += "objBilling.disabled = false;" + vbCrLf
                                        'Code Added By DipaliS 4 July 2004
                                        strScript += "var objStatus= window.opener.document.forms['frmRFI_RFI'].txtCurrentStatus;" + vbCrLf
                                        strScript += "var objRFIID= window.opener.document.forms['frmRFI_RFI'].txtRFIID;" + vbCrLf
                                        strScript += "objStatus.value = '" + ControlsHashTable("CurrentRFIStatus").ToString.ToUpper + "';" + vbCrLf
                                        strScript += "objRFIID.value= '0';" + vbCrLf
                                        'End addition
                                        strScript += "window.opener.document.forms['frmRFI_RFI'].submit();}" + vbCrLf
                                        strScript += "window.close();" + vbCrLf
                                    End If
                                    'If Called From RFI Initiator List
                                    If ControlsHashTable("NonDatabase2").ToString.ToUpper = "CHECKLIST" Then
                                        strScript += "var strParentPages;" + vbCrLf
                                        strScript += "strParentPages = new String();" + vbCrLf
                                        strScript += "strParentPages = window.opener.location.href;" + vbCrLf
                                        strScript += "if (strParentPages.toUpperCase().indexOf('COMMONLIST.ASPX') != -1)" + vbCrLf
                                        strScript += "{ window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?FromWhere=PM&MasterTagID=" + CommonFunction.Constants.APP_TAG_RFI_INITIATOR.ToString + "';" + vbCrLf
                                        strScript += "window.opener.document.forms['frmCommonList'].submit();}" + vbCrLf
                                        strScript += "window.close();" + vbCrLf
                                    End If
                                End If

                            ElseIf ControlsHashTable("CurrentRFIStatus").ToString.ToUpper = "REJECTED" Then
                                strScript += "window.open('SendEmail.aspx?MessageID=53&RFIID=" & ControlsHashTable("RFIID").ToString & "',null,'status=no,toolbar=no,menubar=no,width=600,height=500');" + vbCrLf
                                If ControlsHashTable("NonDatabase2").ToString.ToUpper <> "NONE" Then
                                    If ControlsHashTable("NonDatabase2").ToString.ToUpper = "APPROVER" Then
                                        strScript += "var strParentPages;" + vbCrLf
                                        strScript += "strParentPages = new String();" + vbCrLf
                                        strScript += "strParentPages = window.opener.location.href;" + vbCrLf
                                        strScript += "if (strParentPages.toUpperCase().indexOf('COMMONLIST.ASPX') != -1)" + vbCrLf
                                        strScript += "{ window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?FromWhere=FA&MasterTagID=2074';" + vbCrLf
                                        strScript += "window.opener.document.forms['frmCommonList'].submit();}" + vbCrLf
                                        strScript += "window.close();" + vbCrLf
                                    ElseIf ControlsHashTable("NonDatabase2").ToString.ToUpper = "DETAILS" Then
                                        strScript += "var strParentPages;" + vbCrLf
                                        strScript += "strParentPages = new String();" + vbCrLf
                                        strScript += "strParentPages = window.opener.location.href;" + vbCrLf
                                        strScript += "if (strParentPages.toUpperCase().indexOf('RFI_RFI.ASPX') != -1)" + vbCrLf
                                        strScript += "{ window.opener.document.forms['frmRFI_RFI'].action = '../RFI/RFI_RFI.aspx?Mode=Edit&UserType=Approver&FromStatus=1&RFIID=" + ControlsHashTable("RFIID").ToString + "';" + vbCrLf
                                        strScript += "window.opener.document.forms['frmRFI_RFI'].submit();}" + vbCrLf
                                        strScript += "window.close();" + vbCrLf
                                    End If
                                End If

                            ElseIf ControlsHashTable("CurrentRFIStatus").ToString.ToUpper = "CANCELLED" Then
                                strScript += "window.open('SendEmail.aspx?MessageID=54&RFIID=" & ControlsHashTable("RFIID").ToString & "&UserType=" & ControlsHashTable("NonDatabase1").ToString & "',null,'status=no,toolbar=no,menubar=no,width=600,height=500');" + vbCrLf
                                If ControlsHashTable("NonDatabase2").ToString.ToUpper <> "NONE" Then
                                    If ControlsHashTable("NonDatabase2").ToString.ToUpper = "APPROVER" Then
                                        strScript += "var strParentPages;" + vbCrLf
                                        strScript += "strParentPages = new String();" + vbCrLf
                                        strScript += "strParentPages = window.opener.location.href;" + vbCrLf
                                        strScript += "if (strParentPages.toUpperCase().indexOf('COMMONLIST.ASPX') != -1)" + vbCrLf
                                        If ControlsHashTable("NonDatabase1").ToString.ToUpper = "APPROVER" Then
                                            strScript += "{ window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?FromWhere=FA&MasterTagID=2074';" + vbCrLf

                                        ElseIf ControlsHashTable("NonDatabase1").ToString.ToUpper = "ACCOUNTS" Then
                                            strScript += "{ window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?FromWhere=FA&MasterTagID=2083';" + vbCrLf
                                        End If
                                        strScript += "window.opener.document.forms['frmCommonList'].submit();}" + vbCrLf
                                        strScript += "window.close();" + vbCrLf
                                    ElseIf ControlsHashTable("NonDatabase2").ToString.ToUpper = "DETAILS" Then
                                        strScript += "var strParentPages;" + vbCrLf
                                        strScript += "strParentPages = new String();" + vbCrLf
                                        strScript += "strParentPages = window.opener.location.href;" + vbCrLf
                                        ''Added and commented by PrashantSJ on 27th June 2007 For WhizibleSEM 7.0
                                        ''Purpose: After cancellation of IR parent page should refresh
                                        'strScript += "if (strParentPages.toUpperCase().indexOf('RFI_RFI.ASPX') != -1)" + vbCrLf
                                        If ControlsHashTable("NonDatabase1").ToString.ToUpper = "APPROVER" Then

                                            'strScript += "{ window.opener.document.forms['frmRFI_RFI'].action = '../RFI/RFI_RFI.aspx?Mode=Edit&UserType=Approver&FromStatus=1&RFIID=" + ControlsHashTable("RFIID").ToString + "';" + vbCrLf
                                            strScript += "if (strParentPages.toUpperCase().indexOf('COMMONLIST.ASPX') != -1)" + vbCrLf
                                            strScript += "{ window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?FromWhere=FA&MasterTagID=2083';" + vbCrLf
                                            strScript += "window.opener.document.forms['frmCommonList'].submit();}" + vbCrLf
                                        ElseIf ControlsHashTable("NonDatabase1").ToString.ToUpper = "ACCOUNTS" Then
                                            strScript += "if (strParentPages.toUpperCase().indexOf('RFI_RFI.ASPX') != -1)" + vbCrLf
                                            strScript += "{ window.opener.document.forms['frmRFI_RFI'].action = '../RFI/RFI_RFI.aspx?Mode=Edit&UserType=Accounts&FromStatus=1&RFIID=" + ControlsHashTable("RFIID").ToString + "';" + vbCrLf
                                            strScript += "window.opener.document.forms['frmRFI_RFI'].submit();}" + vbCrLf
                                        End If
                                        'strScript += "window.opener.document.forms['frmRFI_RFI'].submit();}" + vbCrLf
                                        '''End of addition and comment by PrashantSJ on 27th June 2007
                                        strScript += "window.close();" + vbCrLf
                                    End If

                                End If


                            ElseIf ControlsHashTable("CurrentRFIStatus").ToString.ToUpper = "RE-SUBMITTED" Then
                                strScript += "window.open('SendEmail.aspx?MessageID=55&RFIID=" & ControlsHashTable("RFIID").ToString & "',null,'status=no,toolbar=no,menubar=no,width=600,height=500');" + vbCrLf
                                If ControlsHashTable("NonDatabase2").ToString.ToUpper = "DETAILS" Then
                                    strScript += "var strParentPages;" + vbCrLf
                                    strScript += "strParentPages = new String();" + vbCrLf
                                    strScript += "strParentPages = window.opener.location.href;" + vbCrLf
                                    strScript += "if (strParentPages.toUpperCase().indexOf('RFI_RFI.ASPX') != -1)" + vbCrLf
                                    strScript += "{ window.opener.document.forms['frmRFI_RFI'].action = '../RFI/RFI_RFI.aspx?Mode=Edit&UserType=Initiator&FromStatus=1&RFIID=" + ControlsHashTable("RFIID").ToString + "';" + vbCrLf
                                    'Code Added By DipaliS 4 July 2004
                                    strScript += "var objStatus= window.opener.document.forms['frmRFI_RFI'].txtCurrentStatus;" + vbCrLf
                                    strScript += "var objRFIID= window.opener.document.forms['frmRFI_RFI'].txtRFIID;" + vbCrLf
                                    strScript += "objStatus.value = '" + ControlsHashTable("CurrentRFIStatus").ToString.ToUpper + "';" + vbCrLf
                                    strScript += "objRFIID.value= '0';" + vbCrLf
                                    'End addition
                                    strScript += "window.opener.document.forms['frmRFI_RFI'].submit();}" + vbCrLf
                                    strScript += "window.close();" + vbCrLf
                                End If
                                'If Called From RFI Initiator List
                                If ControlsHashTable("NonDatabase2").ToString.ToUpper = "CHECKLIST" Then
                                    strScript += "var strParentPages;" + vbCrLf
                                    strScript += "strParentPages = new String();" + vbCrLf
                                    strScript += "strParentPages = window.opener.location.href;" + vbCrLf
                                    strScript += "if (strParentPages.toUpperCase().indexOf('COMMONLIST.ASPX') != -1)" + vbCrLf
                                    strScript += "{ window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?FromWhere=PM&MasterTagID=" + CommonFunction.Constants.APP_TAG_RFI_INITIATOR.ToString + "';" + vbCrLf
                                    strScript += "window.opener.document.forms['frmCommonList'].submit();}" + vbCrLf
                                    strScript += "window.close();" + vbCrLf
                                End If

                            End If
                            strScript += "</script>"
                            CommonFunction.General.WriteHTML(strScript)
                            'Start
                            'JyotiG
                            'Issue Id : 6197
                            'Else
                            '    'Token is Invalid now redirect to the Invalid Access Page
                            '    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                            'End If
                            ''End

                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_DISPATCHED_DETAILS
                            Dim strScript As String
                            strScript = "<script language = javascript>" + vbCrLf
                            strScript += "window.close();" + vbCrLf
                            strScript += "</script>"
                            CommonFunction.General.WriteHTML(strScript)
                            'End of Addition

                            'Modified by SachinR    on 21 Sep 2004
                            'This code is commented as Phasetask practice is removed and association is removed 
                            'from the project level. 
                            'added by SachinR   on 10 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_PROJECT_SETTINGS
                            ''here check if practice is applied, and previously not applied, then get the 
                            ''template data from corporate level to project level
                            Dim StrSQL As String
                            'Dim strPracticeGroupID As String
                            'Dim strUserName As String
                            'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("PracticeApplied"), "").ToString.ToUpper <> "YES" Then
                            '    If HttpContext.Current.Request.Form("PracticeGroupID") <> "" Then
                            '        'if practice group is selected then update data
                            '        strPracticeGroupID = HttpContext.Current.Request.Form("PracticeGroupID") + ""
                            '        strUserName = WhizGlobal.UserName + ""
                            '        strSQL = "usp_Upd_tbl_PM_Project_AssociatePractice " + WhizGlobal.ProjectID.ToString + "," + strPracticeGroupID.Trim + ",'" + strUserName.Trim + "'"
                            '        CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '    End If
                            'End If
                            'HttpContext.Current.Session("PracticeApplied") = ""
                            ''addition end

                            'added by JayavantK   on 20 Aug 2004
                            'Set the Effort Distribution true when the SubTask Types flag is true. This is required in 'Daily Activity'.
                            'StrSQL = "Update tbl_PM_Project SET ApplyEffortDistribution = 1 WHERE HaveSubTaskTypes = 1 AND ProjectID = " + WhizGlobal.ProjectID.ToString
                            'CommonFunction.Data.InsertOrUpdateData(StrSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            'addition end

                            'added by SachinR   on 20 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLE_DISCUSSION_THREAD
                            'Commented by JyotiG
                            'Start_JG_11488_15_Mar-2007
                            'Dim strScript As String
                            'strScript = "<script language = javascript>" + vbCrLf
                            'If ControlsHashTable("ShowToCustomer").ToString.ToUpper = "ON" Then
                            '    strScript += "window.open('SendEmail.aspx?MessageID=438&DiscussionID=" + PrimaryKey + "&ScheduleID=" + HttpContext.Current.Request("ScheduleID").ToString + "&Show=1',null,'status=no,toolbar=no,menubar=no,width=600,height=500');" + vbCrLf
                            'Else
                            '    strScript += "window.open('SendEmail.aspx?MessageID=438&DiscussionID=" + PrimaryKey + "&ScheduleID=" + HttpContext.Current.Request("ScheduleID").ToString + "&Show=0',null,'status=no,toolbar=no,menubar=no,width=600,height=500');" + vbCrLf
                            'End If
                            'strScript += "</script>"
                            'CommonFunction.General.WriteHTML(strScript)
                            'addition end
                            'End_JG_11488_15_Mar-2007
                            'added by SachinR   On 21 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLE_CODE_DEFINITION
                            'here refresh the parent page, CL and UI 
                            Dim strScript As String
                            strScript = "<script language = javascript>" + vbCrLf

                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("NonDatabase4"), "") = "Yes" Then
                                strScript += "opener.document.forms[0].CodeTemplate.value='" + HttpContext.Current.Request.Form("CodeTemplate") + "';" + vbCrLf
                            Else
                                strScript += "opener.document.forms[0].action=opener.location.href;" + vbCrLf
                                strScript += "opener.document.forms[0].submit();" + vbCrLf
                            End If
                            strScript += " window.close(); </script>"
                            CommonFunction.General.WriteHTML(strScript)
                            'addition end

                            'added by SachinR   on 24 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                            'send mail for status change
                            Dim strScheduleID As String
                            Dim strScript As String

                            If IsEditMode = True Then
                                If Not HttpContext.Current.Session("DeliverableStatusChanged") Is Nothing Then
                                    If HttpContext.Current.Session("DeliverableStatusChanged").ToString = "Yes" Then
                                        'flag set in the session to send mail for status change of deliverable
                                        strScript = "<script language = javascript>" + vbCrLf
                                        strScript += "window.open('SendEmail.aspx?MessageID=439&ScheduleID=" + PrimaryKey + "&Show=1',null,'status=no,toolbar=no,menubar=no,width=600,height=500');" + vbCrLf
                                        strScript += "</script>"
                                        CommonFunction.General.WriteHTML(strScript)
                                        HttpContext.Current.Session.Remove("DeliverableStatusChanged")
                                    End If
                                End If
                            End If
                            'addition end

                            'added by SachinR   on 19 Oct 2004
                            'to genrate the code template and serial no and update the new record
                            Dim strSQL As String
                            If IsEditMode = False Then
                                strSQL = "usp_upd_tbl_PM_OtherSchedule_CodeTemplate " + PrimaryKey.Trim
                                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))


                            End If
                            'addition end

                            'added by SachinR   on 29 Oct 2004
                            'update the tasks related with the deliverable to make them Void or OnHold if
                            'deliverable is made Void or OnHold
                            Dim strVoid As String
                            Dim strOnHold As String
                            Dim blnUpdate As Boolean = False
                            Dim strSQL2 As String

                            If IsEditMode Then
                                strScript = "<script language = javascript>" + vbCrLf
                                strSQL = "usp_Upd_tbl_PM_ProjectTasks_Void_OnHold_ForDeliverable " + WhizGlobal.ProjectID.ToString + "," + PrimaryKey.Trim

                                strOnHold = HttpContext.Current.Request.Form("IsOnHold") + ""
                                If strOnHold = "1" Or UCase(strOnHold) = "ON" Then
                                    'Update tasks if previously it was not On Hold
                                    If HttpContext.Current.Request.Form("NonDatabase5").ToUpper = "FALSE" Or HttpContext.Current.Request.Form("NonDatabase5") = "" Then
                                        strSQL += ",1"
                                        blnUpdate = True
                                        strScript += "window.open('../PM/PM_DeliverableTasks.aspx?Mode=OnHold&DeliverableID=" + PrimaryKey.Trim + "', '', 'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 600)/2 + ',width=800,height=600');" + vbCrLf
                                    Else
                                        strSQL += ",NULL"
                                    End If
                                Else
                                    strSQL += ",NULL"
                                    If HttpContext.Current.Request.Form("NonDatabase5").ToUpper = "TRUE" Then
                                        'Update all the related tasks to remove the On Hold  
                                        strSQL2 = "usp_Upd_tbl_PM_ProjectTasks_UnOnHold NULL," + WhizGlobal.ProjectID.ToString + "," + PrimaryKey.Trim
                                        CommonFunction.Data.InsertOrUpdateData(strSQL2, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                        strScript += "window.open('../PM/PM_DeliverableTasks.aspx?Mode=UnOnHold&DeliverableID=" + PrimaryKey.Trim + "', '', 'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 600)/2 + ',width=800,height=600');" + vbCrLf
                                    End If
                                End If

                                strVoid = HttpContext.Current.Request.Form("Void") + ""
                                If strVoid = "1" Or UCase(strVoid) = "ON" Then
                                    'Update tasks if previously it was not Void
                                    If HttpContext.Current.Request.Form("NonDatabase6").ToUpper = "FALSE" Or HttpContext.Current.Request.Form("NonDatabase6") = "" Then
                                        strSQL += ",1"
                                        blnUpdate = True
                                        strScript += "window.open('../PM/PM_DeliverableTasks.aspx?Mode=Void&DeliverableID=" + PrimaryKey.Trim + "', '', 'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 600)/2 + ',width=800,height=600');" + vbCrLf
                                    Else
                                        strSQL += ",NULL"
                                    End If
                                Else
                                    strSQL += ",NULL"
                                    If HttpContext.Current.Request.Form("NonDatabase6").ToUpper = "TRUE" Then
                                        'Update all the related tasks to remove the Void  
                                        strSQL2 = "usp_Upd_tbl_PM_ProjectTasks_UnVoid NULL," + WhizGlobal.ProjectID.ToString + "," + PrimaryKey.Trim
                                        CommonFunction.Data.InsertOrUpdateData(strSQL2, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                        strScript += "window.open('../PM/PM_DeliverableTasks.aspx?Mode=UnVoid&DeliverableID=" + PrimaryKey.Trim + "', '', 'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 600)/2 + ',width=800,height=600');" + vbCrLf
                                    End If
                                End If

                                If blnUpdate = True Then
                                    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                End If
                                strScript += "</script>"
                                CommonFunction.General.WriteHTML(strScript)
                            End If
                            'addition end

                            ' Commented  By NitinVS On 28 Feb 2005 for WhizibleE SP2
                            ' Th Update Sp is called throught Trigger

                            '        'added by SachinR   on 26 Aug 2004
                            'Case CommonFunction.Constants.APP_TAG_PRACTICE_SELECTION
                            '        'update the status of project template to Draft(D)
                            '        'also update the status of all related phasetasks and activties
                            '        If IsEditMode = True Then
                            '            Dim strTemplateID As String
                            '            Dim strSQL As String
                            '            strTemplateID = PrimaryKey.Trim
                            '            strSQL = "usp_upd_updateTemplateStatusToDraft " + strTemplateID.Trim
                            '            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                            '        End If

                            ' End Modification By NitinVS on 28 Feb 2005 for WhizibleE SP2

                            ' Added By NitinVS on 9 MAy 2005 for WhizibleSEM SP3 
                            ' Implementing Copy functionality 
                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("COPYDATA"), "") = "1" _
                                   And CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UNIQUEID"), "") <> "" Then
                                Dim UniqueID As String
                                Dim NewID As String
                                Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                                UniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UNIQUEID"), "")
                                NewID = PrimaryKey
                                'Added by TruptiK on 21-DEc-2007
                                'Purpose:-If project is on-hold task can not be copied.
                                Dim drOnHold As IDataReader
                                Dim strProjectOnHold As String
                                drOnHold = CommonFunction.Data.GetDataReader("SELECT MapToProjectOnHold FROM tbl_CNF_ProjectStatus inner join tbl_PM_Project on tbl_CNF_ProjectStatus.ProjectStatusID=tbl_PM_Project.ProjectStatusID WHERE ProjectID = " & intProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                While drOnHold.Read
                                    If CommonFunction.General.CheckIsNothing(drOnHold("MapToProjectOnHold")).ToString <> "" Then
                                        strProjectOnHold = drOnHold("MapToProjectOnHold").ToString
                                    End If
                                End While
                                CommonFunction.Data.DisposeDataReader(drOnHold)
                                'End of addition by TruptiK ON 21-Dec-2007
                                'Added by TruptiK on 21-Dec-2007
                                'Purpose:-If project is on-hold task can not be copied.
                                If strProjectOnHold = "True" Then
                                    AfterSave = "if(1==2){" + vbCrLf
                                Else
                                    AfterSave = " if (confirm(" + Chr(34) + "If you want to copy the task  then press OK.\nIf you don't want to copy the task  then press Cancel." + Chr(34) + ")) { " + vbCrLf
                                End If
                                'End of addition by TruptiK
                                AfterSave += "	window.open (" + Chr(34) + "../PM/PM_CopyTask.aspx?MODE=ADD_NEW&PARENT_TAGID=2133&UNIQUEID=" + UniqueID + "&UNIQUEID_NEW=" + NewID + Chr(34) + ",null,""resizable=yes,scrollbars=no,left="" + (window.screen.width - 700) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=800,height=600"");" + vbCrLf
                                AfterSave += " opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=2133'   ;" + vbCrLf
                                AfterSave += " } " + vbCrLf
                                AfterSave += "opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" & CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE & "';" + vbCrLf

                                'Added by VijayD on 21 August 2009 Purpose: to refersh gantt chart page 
                                AfterSave += "if(window.opener.opener!=null) {" + vbCrLf
                                AfterSave += "var strParentPage; strParentPage = new String();" + vbCrLf
                                AfterSave += "strParentPage = opener.opener.location.href;" + vbCrLf
                                AfterSave += "if (strParentPage.toUpperCase().indexOf('WBS_GANTTCHARTVIEW.ASPX') != -1){" + vbCrLf
                                AfterSave += "try{opener.opener.location.href = '../Home/WBS_GanttChartView.aspx?GanttChartType=1&From_Where=HRHome&MasterTagID=1038';" + vbCrLf
                                AfterSave += "}catch(e){}}}" + vbCrLf
                                'End Addition By Vijay On 21 August 2009
                                AfterSave += " window.close();" + vbCrLf
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If

                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), "") = "SAVE" _
                                   And CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UNIQUEID"), "") = "" Then

                                'Added by VijayD on 21 August 2009 Purpose: to refersh gantt chart page 
                                AfterSave = "if(window.opener!=null) {" + vbCrLf
                                AfterSave += "var strParentPage; strParentPage = new String();" + vbCrLf
                                AfterSave += "strParentPage = opener.location.href;" + vbCrLf
                                AfterSave += "if (strParentPage.toUpperCase().indexOf('WBS_GANTTCHARTVIEW.ASPX') != -1){" + vbCrLf
                                AfterSave += "opener.location.href = '../Home/WBS_GanttChartView.aspx?GanttChartType=1&From_Where=PM&MasterTagID=1038';" + vbCrLf
                                AfterSave += "}" + vbCrLf
                                AfterSave += "if (strParentPage.toUpperCase().indexOf('HOME_OUTLOOKVIEW.ASPX') != -1){" + vbCrLf
                                AfterSave += "opener.location.href = '../Home/Home_OutlookView.aspx?List=9';" + vbCrLf
                                AfterSave += "}}" + vbCrLf
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                                'End Addition By Vijay On 21 August 2009
                            End If
                            '________________________________________________________________________________________________
                            ' JP_21AUG2006
                            ' Purpose: For Sending the Mail after the Deliverable Creation
                            ' If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MessageID"), "") = "476" Then
                            Dim strFromEmailID As String = "", strToMailID As String = "", strCCToMailID As String = ""
                            Dim strToEmailID As String = "", strCCToEmailID As String = ""
                            Dim strEmailMessage As String = "", strSubject As String = "", strMessage As String = ""
                            Dim drEmailMessage As IDataReader
                            Dim blnSendEmail As Boolean
                            Dim blnShowPopup As Boolean
                            drEmailMessage = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmailMessages 471", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If drEmailMessage.Read Then
                                blnSendEmail = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("SendMail"), "0"), Boolean)
                                blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("ShowPopup"), "0"), Boolean)
                            End If

                            ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                            CommonFunction.Data.DisposeDataReader(drEmailMessage)
                            ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                            '*******************************************
                            Dim strHTMLScript As String
                            If IsEditMode = False Then
                                If blnSendEmail = True And blnShowPopup = True Then
                                    'AfterSave
                                    'strHTMLScript = "<script language = javascript>" + vbCrLf
                                    strHTMLScript += "window.open('../General/SendEmail.aspx?MessageID=471&ScheduleID=" + PrimaryKey.Trim + "', '','resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500');" + vbCrLf
                                    'AfterSave += " window.opener.location.href=window.opener.location.href;" + vbCrLf
                                    'AfterSave += " window.close();" + vbCrLf
                                    'strHTMLScript += "</script>" + vbCrLf

                                    'CommonFunction.General.WriteHTML(strHTMLScript)
                                    AfterSave += strHTMLScript
                                End If

                                If blnSendEmail = True And blnShowPopup = False Then
                                    CommonFunction.EmailMessages.PMMessages.GetEmailMessage_471(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(PrimaryKey, Long))
                                    CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                                End If
                            End If

                            ''Commneted By VijayD On 21 August 2009 :Code was not Workable

                            '''Added by PrashantSJ on 14th July 2009 Purpose: to refersh deliverable planning Gantt chart page
                            'CommonFunction.General.WriteHTML("<script language = javascript>")
                            'CommonFunction.General.WriteHTML(" var strParentPage;")
                            'CommonFunction.General.WriteHTML("strParentPage = new String();")
                            'CommonFunction.General.WriteHTML("if(window.opener!=null){  strParentPage = opener.location.href;")
                            'CommonFunction.General.WriteHTML("if (strParentPage.toUpperCase().indexOf('WBS_GanttChartView.aspx'.toUpperCase()) != -1)")
                            'CommonFunction.General.WriteHTML("{")
                            'CommonFunction.General.WriteHTML("	window.opener.document.forms['frmWBS_GanttChartView'].action = '../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038';")
                            'CommonFunction.General.WriteHTML("	try{window.opener.document.forms['frmWBS_GanttChartView'].submit();}catch(e){}	")
                            'CommonFunction.General.WriteHTML("}")
                            'CommonFunction.General.WriteHTML("window.close(); } ")
                            'CommonFunction.General.WriteHTML("</script>")
                            '''End of addition by PrashantSJ on 14th July 2009 Purpose: to refersh deliverable planning Gantt chart page
                            ''CommonFunctions.Data.InsertOrUpdateData(stRejectSQL, True)
                            'strActionCode = ReturnCodes.ON_LOAD.ToString
                            ''________________________________________________________________________________________________
                            ''Added by PrashantSJ on 28th July 2009 Purpose: to refersh gantt chart page 
                            'HttpContext.Current.Response.Write(CommonFunction.General.GetRefreshParentScript("'frmWBS_GanttChartView'", "'WBS_GanttChartView.aspx'", "'../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=" & CommonFunction.Constants.APP_TAG_ASSIGNED_TASK.ToString + "&GanttChartType=1'", True))
                            ''End of addition by PrashantSJ on 28th July 2009 Purpose: to refersh gantt chart page 

                            ''End Comment By VijayD ON 21 August 2009
                            '*******************************************
                            strActionCode = ReturnCodes.ON_LOAD.ToString

                            ''Added By Sagar Nipane on 21-Feb-2019 Purpose::Project Work field level changes 

                            Dim strSQLQuery As String
                            Dim WorkHourMinute As String
                            Dim WorkHour As String
                            Dim WorkMinute As String

                            WorkHourMinute = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase10"))

                            If WorkHourMinute = "" Then
                                WorkHourMinute = "00:00"
                            End If

                            WorkHour = WorkHourMinute.Substring(0, WorkHourMinute.IndexOf(":"))
                            WorkMinute = WorkHourMinute.Substring(WorkHourMinute.IndexOf(":") + 1)

                            If WorkHour = "" Then
                                WorkHour = "0"
                            End If
                            If WorkMinute = "" Then
                                WorkMinute = "0"
                            End If
                            If WorkMinute.Length = 1 Then
                                WorkMinute = WorkMinute + "0"
                            End If

                            strSQLQuery = "EXEC usp_Whizible2_upd_EstimatedEffortsForWBS " & PrimaryKey & ",'" & WorkHour & "','" & WorkMinute & "',5"
                            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, True)
                            ''End of Added By Sagar Nipane on 21-Feb-2019 Purpose::Project Work field level changes


                        Case CommonFunction.Constants.APP_TAG_ASSOCIATED_PHASE_TASK
                            'update the status of project template to Draft(D)
                            'also update the status of all related phasetasks and activties
                            If IsEditMode = True Then
                                Dim strTemplateID As String
                                Dim strSQL As String
                                strTemplateID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("TemplateID"), "")
                                strSQL = "usp_upd_updateTemplateStatusToDraft " + strTemplateID.Trim
                                CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                            End If
                        Case CommonFunction.Constants.APP_TAG_ASSOCIATED_ACTIVITIES
                            'update the status of project template to Draft(D)
                            'also update the status of all related phasetasks and activties
                            If IsEditMode = True Then
                                Dim strTemplateID As String
                                Dim strSQL As String
                                strTemplateID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("TemplateID"), "")
                                strSQL = "usp_upd_updateTemplateStatusToDraft " + strTemplateID.Trim
                                CommonFunction.Data.InsertOrUpdateData(strSQL, True)

                                'added by SachinR   on 08 Nov 2004
                                Dim strTaskID As String = HttpContext.Current.Request.QueryString("PhaseTaskID") + ""
                                AfterSave = " opener.location.href='../PM/PM_ActivityEffortDistribution.aspx?PhaseTaskID=" + strTaskID + "&TemplateID=" + strTemplateID + "';"
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                                'addition end
                            End If
                        Case CommonFunction.Constants.APP_TAG_ASSOCIATED_ACTIVITIES_DISTRIBUTION
                            'update the status of project template to Draft(D)
                            'also update the status of all related phasetasks and activties
                            If IsEditMode = True Then
                                Dim strTemplateID As String
                                Dim strSQL As String
                                strTemplateID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("TemplateID"), "")
                                strSQL = "usp_upd_updateTemplateStatusToDraft " + strTemplateID.Trim
                                CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                            End If
                            'addition end

                            'added by SachinR   on 27 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_PUBLISH_DELIVERABLE_PROJECT_TEMPLATE
                            'here publish the template(copy all template related data from draft tables to
                            'publish tables with new revision No and RevisionID)

                            If IsEditMode = False Then
                                Dim strSQL As String
                                strSQL = "usp_Upd_PublishProjectDeliverableTemplate " + PrimaryKey.Trim
                                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'added by SachinR   on 03 Nov 2004
                                'plot sclient side script to refresh Parent page after publishing

                                'Modified by ShamkantD on 16 Dec 2004
                                'Modified to fix issue 14760 (Projects - Execution Templates - Publish link generates error)
                                'AfterSave = "opener.location.href=opener.location.href;" + vbCrLf
                                AfterSave = "opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" & CommonFunction.Constants.APP_TAG_PRACTICE_SELECTION & "';"
                                'End of addition - ShamkantD on 16 Dec 2004

                                AfterSave += vbCrLf + "window.close();"
                                RedirectToCL = False
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                                'addition end   on 03 Nov 2004
                            End If
                            'addition end
                            'Added by ShamkantD on 10th September 2004 - for Fast Track Reviews

                        Case CommonFunction.Constants.APP_TAG_FAST_TRACK_REVIEWS    'Fast Track Reviews tag

                            'Commented by MrugajaB for on 18th July 2006 for WhizibleSEM SP7
                            'Purpose: This code will not be required as FTR cannot be mapped to MPP tasks in edit mode
                            'If IsEditMode = False Then 'First Time entry only
                            '    AfterSave = " if (confirm(" + Chr(34) + m_objTemplate.GetResourceString("PROJECT_REVIEW") + Chr(34) + ")) { " + vbCrLf
                            '    AfterSave += "	window.open (" + Chr(34) + "../PM/PM_MapReviewTasks.aspx?ReviewStatisticsID=" + PrimaryKey + Chr(34) + ",null,""resizable=yes,scrollbars=no,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 350) / 2 + "",width=600,height=350"");" + vbCrLf
                            '    AfterSave += " }"
                            '    strActionCode = ReturnCodes.ON_LOAD.ToString
                            'End If
                            'End Comment
                            'After save for Review Tag
                            Dim strReviewerIDList As String
                            Dim strSQL As String
                            'Retrieve the ReviewerID list
                            strReviewerIDList = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase1"))

                            'If strReviewerIDList is not empty
                            If Not (strReviewerIDList = ",," Or strReviewerIDList = "") Then
                                ' Delete the entries of the reviewers who do not belong to the current list.
                                strSQL = "usp_Del_tbl_PM_ReviewStatistics_Reviewers " + PrimaryKey + ", '" + strReviewerIDList + "'"
                                CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                ' For each reviewer in the new reviewer list, make an entry in the reviewer list.
                                strSQL = "usp_Ins_tbl_PM_ReviewStatistics_Reviewers_New " + PrimaryKey + ", '" + strReviewerIDList + "'"
                                CommonFunction.Data.SQLInsertOrUpdateData(strSQL)
                            End If

                            ' Added By nitinVS on 18 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 12629 
                            ' Task not created for Reviewee from fast track review 
                            ' ASSUMPTION : Only single Reviewee Is present. Need to change when Multiple Reviewee IS Implemented
                            Dim strRevieweeIDList As String
                            'Retrieve the RevieweeID list
                            strRevieweeIDList = CommonFunction.General.CheckIsNothing(ControlsHashTable("Reviewee"))

                            'If strRevieweeIDList is not empty
                            If Not (strRevieweeIDList = ",," Or strRevieweeIDList = "") Then
                                ' To get the reviewee EmployeeId 
                                strRevieweeIDList = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT  IsNull(EmployeeID, 0)  FROM tbl_PM_Employee WHERE UserName = '" + strRevieweeIDList + "' ", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0").ToString()
                                strRevieweeIDList = "," + strRevieweeIDList + ","
                                ' Delete the entries of the reviewee who do not belong to the current list.
                                strSQL = "usp_Del_tbl_PM_ReviewStatistics_Authors " + PrimaryKey + ", '" + strRevieweeIDList + "'"
                                CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                ' For each reviewer in the new reviewee list, make an entry in the reviewee list.
                                'Commented by SatyanarayanaA on 10-Jan-2006
                                strSQL = "usp_Ins_tbl_PM_ReviewStatistics_Authors_New " + PrimaryKey + ", '" + strRevieweeIDList + "'"
                                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            End If
                            'End Added By nitinVS on 18 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 12629 

                            '### Assign Task to Reviewer and Reviewee
                            Call AssignOrUpdateTasks(PrimaryKey, ControlsHashTable)

                            'End of addition - ShamkantD on 10th September 2004 

                            'By DiptiK on 15 Sep 2k4 for send email functionality
                            Dim objDr As IDataReader
                            Dim StrSQLQuery As String
                            Dim strVal As String

                            StrSQLQuery = "select ReviewStatus as ReviewStatus from tbl_pm_reviewstatistics where reviewstatisticsid=" & PrimaryKey
                            objDr = CommonFunction.Data.GetDataReader(StrSQLQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If objDr.Read Then
                                strVal = CType(objDr("ReviewStatus"), String)
                            End If
                            CommonFunction.Data.DisposeDataReader(objDr)
                            If strVal.ToUpper = "CLOSED" Then
                                'Send email functionality to be added here
                                'Dim drEmailMessage As IDataReader, blnSendEmail As Boolean, blnShowPopup As Boolean
                                'drEmailMessage = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmailMessages 79", MyBase.UseSQL)

                                'If drEmailMessage.Read Then
                                '    blnSendEmail = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("SendMail"), "0"), Boolean)
                                '    blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("ShowPopup"), "0"), Boolean)
                                'End If
                            End If
                            'End of addition

                            'Added by ShamkantD on 23 Sep 2004 - added for Project Information page

                            ''Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 

                            Dim WorkHourMinute As String
                            Dim WorkHour As String
                            Dim WorkMinute As String

                            WorkHourMinute = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase21"))

                            If WorkHourMinute = "" Then
                                WorkHourMinute = "00:00"
                            End If

                            WorkHour = WorkHourMinute.Substring(0, WorkHourMinute.IndexOf(":"))
                            WorkMinute = WorkHourMinute.Substring(WorkHourMinute.IndexOf(":") + 1)

                            If WorkHour = "" Then
                                WorkHour = "0"
                            End If
                            If WorkMinute = "" Then
                                WorkMinute = "0"
                            End If
                            If WorkMinute.Length = 1 Then
                                WorkMinute = WorkMinute + "0"
                            End If

                            StrSQLQuery = "EXEC usp_Whizible2_upd_EstimatedEffortsForWBS " & PrimaryKey & ",'" & WorkHour & "','" & WorkMinute & "',6"
                            CommonFunction.Data.InsertOrUpdateData(StrSQLQuery, True)
                            ''End of Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes

                        Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING
                            'Modified by ShamkantD on 01 Oct 2004
                            'Get the status of 'Project creation workflow required' flag
                            Dim blnIsProjectCreationWorkflowReqd As Boolean = False
                            blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
                            If blnIsProjectCreationWorkflowReqd = True Then
                                'If the project creation workflow is applicable, update non-revision fields in tbl_PM_Project table
                                CommonFunction.Data.InsertOrUpdateData("usp_Upd_tbl_PM_Project_NonRevisionFields " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            Else
                                'Else, update all fields in tbl_PM_Project table
                                CommonFunction.Data.InsertOrUpdateData("usp_Upd_tbl_PM_Project_AllFields " & CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            End If
                            'End of modification - ShamkantD on 01 Oct 2004

                            'End of addition - ShamkantD on 23 Sep 2004

                            'added by SachinR   on 02 Nov 2004
                            'to implement the hashtable for the deliverable field configuration
                            'here hashtable is refreshed for the deliverable type which is added here
                        Case CommonFunction.Constants.APP_TAG_PRS_DELIVERABLE_TYPES
                            Dim lngDeliverableTypeID As Long = 0

                            If IsEditMode = False Then
                                lngDeliverableTypeID = CType(PrimaryKey, Long)
                                CommonEngine.HashTables.Deliverable.CreateDeliverableHashTable(lngDeliverableTypeID)
                            End If
                            'addition end

                            '    'Code added By SantoshK on 28th April 2005
                            '    'Copy Template funntionality
                            'Case CommonFunction.Constants.APP_TAG_COPY_TEMPLATE
                            '    Dim strTemplateID As String
                            '    Dim strSQLQuery As String
                            '    Dim StrScript As String
                            '    Dim strTempalateName As String
                            '    Dim strTemplateDescription As String

                            '    strTemplateID = PrimaryKey.ToString




                            '    'strSQLQuery = "EXEC usp_Upd_tbl_PM_Project_AssociatePractice " & _
                            '    'CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString() & _
                            '    '",Null,'" & CommonFunction.General.CheckIsNothing(WhizGlobal.UserName, "").ToString() & "'," & strTemplateID
                            '    'CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '    ' Refresh The Opener
                            '    StrScript = vbCrLf + "<Script language=javascript>"
                            '    strScript += vbCrLf + "    refreshParent('frmCommonList','CommonList.aspx','CommonList.aspx');"
                            '    strScript += vbCrLf + "</Script>"
                            '    CommonFunction.General.WriteHTML(strScript)


                            '    'If IsEditMode = False Then
                            '    'AfterSave = "opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" & CommonFunction.Constants.APP_TAG_PRACTICE_SELECTION & "';"
                            '    'AfterSave += vbCrLf + "window.close();"
                            '    'RedirectToCL = False
                            '    'strActionCode = ReturnCodes.ON_LOAD.ToString

                            '    'End If
                            '    'Addition Ends - on 28th April 2005

                            ' Added By NitinVS on 10 May 2005 for WhizibleSEM SP3 
                            ' Implementing Copy Task functionality 
                        Case CommonFunction.Constants.APP_TAG_SUB_PROJECTS

                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("COPYDATA"), "") = "1" _
                                And CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UNIQUEID"), "") <> "" Then

                                'Added by vidyaJ - IssueID - 11860

                                Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                                Dim strSQL As String = "usp_Sel_PM_ShowTaskTab " + intProjectID.ToString + ", 'SUBPROJECT'"
                                'Added by TruptiK on 27-Nov-2007
                                'Purpose:-If project is on-hold task can not be copied.
                                Dim drOnHold As IDataReader
                                Dim strProjectOnHold As String
                                drOnHold = CommonFunction.Data.GetDataReader("SELECT MapToProjectOnHold FROM tbl_CNF_ProjectStatus inner join tbl_PM_Project on tbl_CNF_ProjectStatus.ProjectStatusID=tbl_PM_Project.ProjectStatusID WHERE ProjectID = " & intProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                While drOnHold.Read
                                    If CommonFunction.General.CheckIsNothing(drOnHold("MapToProjectOnHold")).ToString <> "" Then
                                        strProjectOnHold = drOnHold("MapToProjectOnHold").ToString
                                    End If
                                End While
                                CommonFunction.Data.DisposeDataReader(drOnHold)
                                'End of addition by TruptiK ON 27-Nov-2007
                                If (CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "") <> "") Then


                                    Dim UniqueID As String
                                    Dim NewID As String
                                    UniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UNIQUEID"), "")
                                    NewID = PrimaryKey
                                    'Added by TruptiK on 27-Nov-2007
                                    'Purpose:-If project is on-hold task can not be copied.
                                    If strProjectOnHold = "True" Then
                                        AfterSave = "if(1==2){" + vbCrLf
                                    Else
                                        AfterSave = " if (confirm(" + Chr(34) + "If you want to copy the task  then press OK.\nIf you don't want to copy the task  then press Cancel." + Chr(34) + ")) { " + vbCrLf
                                    End If
                                    'End of addition by TruptiK ON 27-Nov-2007
                                    AfterSave += "	window.open (" + Chr(34) + "../PM/PM_CopyTask.aspx?MODE=ADD_NEW&PARENT_TAGID=661&UNIQUEID=" + UniqueID + "&UNIQUEID_NEW=" + NewID + Chr(34) + ",null,""resizable=yes,scrollbars=no,left="" + (window.screen.width - 700) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=800,height=600"");" + vbCrLf
                                    AfterSave += " opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=661'   ;" + vbCrLf
                                    AfterSave += " } " + vbCrLf
                                    AfterSave += "opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" & CommonFunction.Constants.APP_TAG_SUB_PROJECTS & "';"

                                    'Added by VijayD on 21 August 2009 Purpose: to refersh gantt chart page 
                                    AfterSave += "if(window.opener.opener!=null) {" + vbCrLf
                                    AfterSave += "var strParentPage; strParentPage = new String();" + vbCrLf
                                    AfterSave += "strParentPage = opener.opener.location.href;" + vbCrLf
                                    AfterSave += "if (strParentPage.toUpperCase().indexOf('GANTTCHARTVIEW.ASPX') != -1){" + vbCrLf
                                    AfterSave += "window.opener.opener.document.forms['frmGanttChartView'].action = '../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString + "';" + vbCrLf
                                    AfterSave += "try{window.opener.opener.document.forms['frmGanttChartView'].submit();}catch(e){}}}" + vbCrLf
                                    'End Addition By Vijay On 21 August 2009
                                    AfterSave += " window.close();" + vbCrLf
                                    strActionCode = ReturnCodes.ON_LOAD.ToString
                                Else
                                    AfterSave = "opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" & CommonFunction.Constants.APP_TAG_SUB_PROJECTS & "';"

                                    'Added by VijayD on 21 August 2009 Purpose: to refersh gantt chart page 
                                    AfterSave += "if(window.opener.opener!=null) {" + vbCrLf
                                    AfterSave += "var strParentPage; strParentPage = new String();" + vbCrLf
                                    AfterSave += "strParentPage = opener.opener.location.href;" + vbCrLf
                                    AfterSave += "if (strParentPage.toUpperCase().indexOf('GANTTCHARTVIEW.ASPX') != -1){" + vbCrLf
                                    AfterSave += "window.opener.opener.document.forms['frmGanttChartView'].action = '../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString + "';" + vbCrLf
                                    AfterSave += "try{window.opener.opener.document.forms['frmGanttChartView'].submit();}catch(e){}}}" + vbCrLf
                                    'End Addition By Vijay On 21 August 2009

                                    AfterSave += " window.close();" + vbCrLf
                                    strActionCode = ReturnCodes.ON_LOAD.ToString
                                End If
                            End If
                            'Added by VijayD on 21 August 2009 Purpose: to refersh gantt chart page 
                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), "") = "SAVE" _
                                And CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UNIQUEID"), "") = "" Then
                                AfterSave = "if(window.opener!=null) {" + vbCrLf
                                AfterSave += "var strParentPage; strParentPage = new String();" + vbCrLf
                                AfterSave += "strParentPage = opener.location.href;" + vbCrLf
                                AfterSave += "if (strParentPage.toUpperCase().indexOf('GANTTCHARTVIEW.ASPX') != -1){" + vbCrLf
                                AfterSave += "opener.location.href = '../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString + "';" + vbCrLf
                                AfterSave += "}" + vbCrLf
                                AfterSave += "if (strParentPage.toUpperCase().indexOf('HOME_OUTLOOKVIEW.ASPX') != -1){" + vbCrLf
                                AfterSave += "opener.location.href = '../Home/Home_OutlookView.aspx?List=10';" + vbCrLf ' + CommonFunction.Constants.APP_TAG_MODULES.ToString + "';" + vbCrLf
                                AfterSave += "}}" + vbCrLf
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If
                            'End Addition By Vijay On 21 August 2009
                            'Commented  by VijayD on 21 August 2009 Purpose: Code was not workable
                            ''Added by PrashantSJ on 28th July 2009 Purpose: to refersh gantt chart page 
                            'HttpContext.Current.Response.Write(CommonFunction.General.GetRefreshParentScript("'frmGanttChartView'", "'GanttChartView.aspx'", "'../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" & CommonFunction.Constants.APP_TAG_SUB_PROJECTS.ToString + "'", True))
                            ''End of addition by PrashantSJ on 28th July 2009 Purpose: to refersh gantt chart page 
                            'End Comment By Vijay On 21 August 2009

                        Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS

                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("COPYDATA"), "") = "1" _
                                And CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UNIQUEID"), "") <> "" Then

                                'Added by vidyaJ - IssueID - 11860
                                Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), Integer)
                                Dim strSQL As String = "usp_Sel_PM_ShowTaskTab " + intProjectID.ToString + ", 'MILESTONE'"
                                'Added by TruptiK on 27-Nov-2007
                                'Purpose:-If project is on-hold task can not be copied.
                                Dim drOnHold As IDataReader
                                Dim strProjectOnHold As String
                                drOnHold = CommonFunction.Data.GetDataReader("SELECT MapToProjectOnHold FROM tbl_CNF_ProjectStatus inner join tbl_PM_Project on tbl_CNF_ProjectStatus.ProjectStatusID=tbl_PM_Project.ProjectStatusID WHERE ProjectID = " & intProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                While drOnHold.Read
                                    If CommonFunction.General.CheckIsNothing(drOnHold("MapToProjectOnHold")).ToString <> "" Then
                                        strProjectOnHold = drOnHold("MapToProjectOnHold").ToString
                                    End If
                                End While
                                CommonFunction.Data.DisposeDataReader(drOnHold)
                                'End of addition by TruptiK

                                If (CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "") <> "") Then

                                    Dim UniqueID As String
                                    Dim NewID As String
                                    UniqueID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UNIQUEID"), "")
                                    NewID = PrimaryKey
                                    'Added by TruptiK on 27-Nov-2007
                                    'Purpose:-If project is on-hold task can not be copied.
                                    If strProjectOnHold = "True" Then
                                        AfterSave = "if(1==2){" + vbCrLf
                                    Else
                                        AfterSave = " if (confirm(" + Chr(34) + "If you want to copy the task  then press OK.\nIf you don't want to copy the task  then press Cancel." + Chr(34) + ")) { " + vbCrLf
                                    End If
                                    'End of addition by TruptiK on 27-Nov-2007
                                    AfterSave += "	window.open (" + Chr(34) + "../PM/PM_CopyTask.aspx?MODE=ADD_NEW&PARENT_TAGID=34&UNIQUEID=" + UniqueID + "&UNIQUEID_NEW=" + NewID + Chr(34) + ",null,""resizable=yes,scrollbars=no,left="" + (window.screen.width - 700) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=800,height=600"");" + vbCrLf
                                    AfterSave += " opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=34'   ;" + vbCrLf
                                    AfterSave += " } " + vbCrLf
                                    AfterSave += "opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" & CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS & "';"
                                    'Added by VijayD on 21 August 2009 Purpose: to refersh gantt chart page 
                                    AfterSave += "if(window.opener.opener!=null) {" + vbCrLf
                                    AfterSave += "var strParentPage; strParentPage = new String();" + vbCrLf
                                    AfterSave += "strParentPage = opener.opener.location.href;" + vbCrLf
                                    AfterSave += "if (strParentPage.toUpperCase().indexOf('GANTTCHARTVIEW.ASPX') != -1){" + vbCrLf
                                    AfterSave += "window.opener.opener.document.forms['frmGanttChartView'].action = '../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString + "';" + vbCrLf
                                    AfterSave += "try{window.opener.opener.document.forms['frmGanttChartView'].submit();}catch(e){}}}" + vbCrLf
                                    'End Addition By Vijay On 21 August 2009
                                    AfterSave += " window.close();" + vbCrLf
                                    strActionCode = ReturnCodes.ON_LOAD.ToString
                                Else
                                    AfterSave = "opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" & CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS & "';"
                                    'Added by VijayD on 21 August 2009 Purpose: to refersh gantt chart page 
                                    AfterSave += "if(window.opener.opener!=null) {" + vbCrLf
                                    AfterSave += "var strParentPage; strParentPage = new String();" + vbCrLf
                                    AfterSave += "strParentPage = opener.opener.location.href;" + vbCrLf
                                    AfterSave += "if (strParentPage.toUpperCase().indexOf('GANTTCHARTVIEW.ASPX') != -1){" + vbCrLf
                                    AfterSave += "window.opener.opener.document.forms['frmGanttChartView'].action = '../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString + "';" + vbCrLf
                                    AfterSave += "try{window.opener.opener.document.forms['frmGanttChartView'].submit();}catch(e){}}}" + vbCrLf
                                    'End Addition By Vijay On 21 August 2009
                                    AfterSave += " window.close();" + vbCrLf

                                    strActionCode = ReturnCodes.ON_LOAD.ToString
                                End If
                            End If
                            'Added by VijayD on 21 August 2009 Purpose: to refersh gantt chart page 
                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), "") = "SAVE" _
                                And CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UNIQUEID"), "") = "" Then
                                AfterSave = "if(window.opener!=null) {" + vbCrLf
                                AfterSave += "var strParentPage; strParentPage = new String();" + vbCrLf
                                AfterSave += "strParentPage = opener.location.href;" + vbCrLf
                                AfterSave += "if (strParentPage.toUpperCase().indexOf('GANTTCHARTVIEW.ASPX') != -1){" + vbCrLf
                                AfterSave += "opener.location.href = '../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString + "';" + vbCrLf
                                AfterSave += "}" + vbCrLf
                                AfterSave += "if (strParentPage.toUpperCase().indexOf('HOME_OUTLOOKVIEW.ASPX') != -1){" + vbCrLf
                                AfterSave += "opener.location.href = '../Home/Home_OutlookView.aspx?List=6';" + vbCrLf ' + CommonFunction.Constants.APP_TAG_MODULES.ToString + "';" + vbCrLf
                                AfterSave += "}}" + vbCrLf
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If
                            'End Addition By Vijay On 21 August 2009

                            'Commented  by VijayD on 21 August 2009 Purpose: Code was not workable
                            ''Added by PrashantSJ on 28th July 2009 Purpose: to refersh gantt chart page 
                            'HttpContext.Current.Response.Write(CommonFunction.General.GetRefreshParentScript("'frmGanttChartView'", "'GanttChartView.aspx'", "'../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" & CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS.ToString + "'", True))
                            ''End of addition by PrashantSJ on 28th July 2009 Purpose: to refersh gantt chart page 
                            'End Comment By Vijay On 21 August 2009

                            ' End Addition By NitinVS on 10 May 2005 for WhizibleSEM SP3 
                            ' Implementing Copy Task Functionality 

                            ' Added By NitinVS on 8 September 2008 for Project Profitability 
                            If IsEditMode = True Then
                                CommonFunction.Data.InsertOrUpdateData("USP_INS_UPD_Tbl_PM_Milestones_RevenueStatus_History " + PrimaryKey + ",'" + HttpContext.Current.Session("strUserName").ToString() + "'", CType(CommonFunction.General.GetApplicationKeySetting("USESQL"), Boolean))
                            End If
                            ' End addition By NitinVS on 8 September 2008 for Project Profitability 

                            'added by VidyaJ -IssueID 672 - Whiz2.0 Integration
                        Case CommonFunction.Constants.TAG_OPTION_BUTTONS, CommonFunction.Constants.TAG_GRID_FORMATTING_RULES, CommonFunction.Constants.TAG_COMPARISON_VALIDATIONS, CommonFunction.Constants.TAG_DEFAULT_PAGE_FILTERS
                            'For Master Tag Options buttons, Grid Formatting rules, Comparison Rules, Default Filters ...after deleting the record update the hash table
                            Call CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("TagID")), Long))
                            'end addition by VidyaJ
                            'integrated by harshada d on 15th june 2006
                            'Integrated by PrajaktaR on 12th May 2006 for Whizible 6.0.1 IssueID 3736
                            '----Added by Harshk on 18/07/05
                            ' Code added by SwapnilR on 10th Oct 2006
                            ' Purpose : To capture reason of the project reopen which includes
                            '           1. Project Reopen updation
                            '           2. Parent window refresh
                            '           3. Send mail pop-up window
                            '           4. Current window closing
                        Case CommonFunction.Constants.APP_TAG_PROJECT_REOPEN_REASON_CAPTURE
                            Dim strQuery As String
                            'Project reopen updation
                            strQuery = "Exec usp_Upd_ReopenProject " + CommonFunction.General.CheckIsNothing(WhizGlobal.ProjectID, "0").ToString()
                            CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

                            AfterSave += "opener.location.href=""../PM/PM_ProjectClosure.aspx?FromWhere=PM&MasterTagId=468""" + vbCrLf
                            AfterSave += "window.open (""SendEmail.aspx?MessageID=470" + """, ""_blank"", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");"
                            AfterSave += "window.close();"
                            strActionCode = ReturnCodes.ON_LOAD.ToString
                            'End of code addtion by SwapnilR on 10th Oct 2006
                            'Added By JyotiG
                            'Start_JG_7713_16-Nov-2006
                        Case CommonFunction.Constants.APP_TAG_CORPORATE_PROJECTS
                            If IsEditMode = True Then

                                Dim strQuery As String
                                Dim strSqlPrjInfo As String
                                Dim drPrjInfo As IDataReader
                                Dim strProjectOver As String
                                Dim strOver As String
                                strOver = CType(HttpContext.Current.Session("strIsOver"), String)
                                strSqlPrjInfo = "Select [Over] from tbl_PM_Project where ProjectID =" + PrimaryKey.Trim
                                drPrjInfo = CommonFunction.Data.GetDataReader(strSqlPrjInfo, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drPrjInfo.Read Then
                                    strProjectOver = CType(CommonFunction.Data.CheckIsDBNull(drPrjInfo("Over"), "False"), String)
                                End If
                                CommonFunction.Data.DisposeDataReader(drPrjInfo)
                                If strOver = "False" And strProjectOver = "True" Then
                                    strQuery = "Exec usp_Upd_tbl_ProjectClosure " + PrimaryKey.Trim
                                    CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
                                End If
                                If strOver = "True" And strProjectOver = "False" Then
                                    'If strOver = "False" Then
                                    strQuery = "Exec usp_Upd_ReopenProject " + PrimaryKey.Trim
                                    CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
                                    'End If
                                End If
                            End If
                            'End_JG_7713_16-Nov-2006
                        Case CommonFunction.Constants.APP_TAG_PUBLISH_DELIVERABLE_PROJECT_CHECKLIST
                            If IsEditMode = False Then
                                Dim strSQL As String
                                strSQL = "usp_Upd_PublishProjectDeliverableCheckList " + PrimaryKey.Trim
                                CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                                AfterSave = "opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagId=" & CommonFunction.Constants.APP_TAG_PROJECT_CHECKLIST & "';"
                                AfterSave += vbCrLf + "window.close();"
                                RedirectToCL = False
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                            End If
                            '-----End-----Harshk on 18/07/05
                            'END OF Integration by PrajaktaR on 12th May 2006 for Whizible 6.0.1 IssueID 3736
                            'Integrated by PrajaktaR on 12th May 2006 for Whizible 6.0.1 IssueID 3736
                            '---Code Added By HarshK on 15/07/2005 for 
                        Case CommonFunction.Constants.APP_TAG_COPY_CHECKLIST
                            'Dim strCheckListName As String
                            'Dim strProjectCheckListID As String
                            'Dim strSQLQuery As String

                            'strCheckListName = HttpContext.Current.Request("CheckListShortName")
                            'strProjectCheckListID = HttpContext.Current.Request("NonDatabase1")

                            'strSQLQuery = " Exec usp_Copy_CheckList " & strProjectCheckListID & ",'" & strCheckListName & "'"
                            'CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, True)
                            Dim strScript As String
                            strScript = " alert('Copied checklist is in draft mode. Please publish it before using it.');"
                            strScript += "window.close();"
                            strScript += "window.opener.document.forms['frmCommonList'].action = 'CommonList.aspx?FromWhere=PM&MasterTagID=2263';" + vbCrLf
                            strScript += "window.opener.document.forms['frmCommonList'].submit();" + vbCrLf


                            'strActionCode = ReturnCodes.ON_LOAD.ToString
                            RedirectToCL = False
                            strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_SAVE.ToString
                            AfterSave = strScript
                            '---END Of Code Added By HarshK on 15/07/2005 for 
                            'END Of Integration by PrajaktaR on 12th May 2006 for Whizible 6.0.1 IssueID 3736
                            'end of integration by harshada d on 15 th june 2006

                        Case CommonFunction.Constants.App_TAG_THEMES
                            'Added by MrugajaB on 26th July 2006
                            'Purpose : This code will be used for refreshing tree after new theme is applied so that 
                            'new color change will be applicable for tree without saving web.config

                            'Added By NileshD on 13 Sep 2005 REQID - WAF3_PB_8
                            'Added & Modified By VarunA on 2-Oct-2008 IssueID-21551
                            'Purpose : To refresh tree with new theme in PM module for Customer.
                            'CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'E',null,null," + CType(HttpContext.Current.Session("intUserID"), String) + ",null")
                            If WhizGlobal.LoginType = "E" Then
                                CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'E',null,null," + CType(HttpContext.Current.Session("intUserID"), String) + ",null")
                            Else
                                CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List_Customer 'C'," + CType(HttpContext.Current.Session("intUserID"), String))
                            End If
                            'End By VarunA on 2-Oct-2008 IssueID-21551
                            'End Of Modifications - IssueID : 672

                            'End OF Addition By NileshD on 13 Sep 2005 REQID - WAF3_PB_8

                            'Added By KapilGK for SP8 On 28-Nov-2006
                        Case CommonFunction.Constants.APP_TAG_ENTITY_UPDATE_SCHEDULE
                            Dim strSQL As String
                            strSQL = "Update tbl_CDB_Update_Schedule Set NextUpdate = cast(NextUpdate as varchar(11)) + ' ' + starttime + ':00:000' Where ScheduleID = " + PrimaryKey
                            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                            'End of Addition By KapilGK
                        Case CommonFunction.Constants.APP_TAG_RESOURCES
                            'Added by PrashantD on 19 April 2007 for IssueID 11628
                            'Addition done by SuchitraP on 19 Sept 2007 
                            If (PrimaryKey <> "" AndAlso Not PrimaryKey Is Nothing) Then
                                'End of addition by SuchitraP on 19 Sept 2007 
                                Dim dr As IDataReader
                                Dim drBatch As IDataReader
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

                                'dr = CommonFunction.Data.GetDataReader("SELECT disableAllIssuesLink FROM tbl_PM_ProjectEmployeeRole WHERE ProjectEmployeeRoleID <> " + PrimaryKey + " AND  Role = " + HttpContext.Current.Request.Form("Role") + " AND ProjectID = " + HttpContext.Current.Session("intProjectID").ToString + " AND disableAllIssuesLink = 1", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'drBatch = CommonFunction.Data.GetDataReader("SELECT hidebatchupdatelink FROM tbl_PM_ProjectEmployeeRole WHERE ProjectEmployeeRoleID <> " + PrimaryKey + " AND  Role = " + HttpContext.Current.Request.Form("Role") + " AND ProjectID = " + HttpContext.Current.Session("intProjectID").ToString + " AND hidebatchupdatelink = 1", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                dr = CommonFunction.Data.GetDataReader("SELECT disableAllIssuesLink FROM tbl_PM_ProjectEmployeeRole WHERE ProjectEmployeeRoleID <> " + PrimaryKey + " AND  Role = " + HttpContext.Current.Request.Form("Role") + " AND ProjectID = " + ProjectID + " AND disableAllIssuesLink = 1", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                drBatch = CommonFunction.Data.GetDataReader("SELECT hidebatchupdatelink FROM tbl_PM_ProjectEmployeeRole WHERE ProjectEmployeeRoleID <> " + PrimaryKey + " AND  Role = " + HttpContext.Current.Request.Form("Role") + " AND ProjectID = " + ProjectID + " AND hidebatchupdatelink = 1", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'End of commented and added by ShraddhaM on 17,Sept 2008

                                If dr.Read Then
                                    If Not IsDBNull(dr(0)) Then
                                        CommonFunction.Data.InsertOrUpdateData("UPDATE tbl_PM_ProjectEmployeeRole SET disableAllIssuesLink=1 WHERE ProjectEmployeeRoleID = " + PrimaryKey, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    End If
                                End If
                                CommonFunction.Data.DisposeDataReader(dr)

                                'End of addition by PrashantD on 19 April 2007
                                'Added By ShraddhaM on 3,July 2007
                                If drBatch.Read Then
                                    If Not IsDBNull(drBatch(0)) Then
                                        CommonFunction.Data.InsertOrUpdateData("UPDATE tbl_PM_ProjectEmployeeRole SET hidebatchupdatelink = 1 WHERE ProjectEmployeeRoleID = " + PrimaryKey, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    End If
                                End If
                                CommonFunction.Data.DisposeDataReader(drBatch)
                                'End of Addtion By ShraddhaM on 3,July 2007
                            End If
                            'Added by ShraddhaM on 17,Sept 2008
                            'Purpose : Resource Allocation from advanced searched resources in Whiziblesem8.0
                            'If HttpContext.Current.Request.Form("hidPKValue") <> "" Then
                            If IsEditMode = False Then
                                Dim strQuery As String
                                Dim StartDate As String
                                Dim EndDate As String
                                Dim RESPKValue As String
                                Dim Pipe_OR_Team_PK As String
                                Dim RoleID As String

                                RESPKValue = HttpContext.Current.Request.Form("hidPKValue")
                                RoleID = HttpContext.Current.Request.Form("Role")
                                StartDate = HttpContext.Current.Request.Form("ExpectedStartDate")
                                EndDate = HttpContext.Current.Request.Form("ExpectedEndDate")
                                Pipe_OR_Team_PK = HttpContext.Current.Request.Form("hidPipe_OR_Team_PK")

                                If Pipe_OR_Team_PK Is Nothing OrElse Pipe_OR_Team_PK = "" Then
                                    Pipe_OR_Team_PK = "NULL"
                                End If
                                If RoleID Is Nothing OrElse RoleID = "" Then
                                    RoleID = "NULL"
                                End If
                                'Added by SanaS 0n 18-Sep-2009
                                If Pipe_OR_Team_PK <> "NULL" Then
                                    strQuery = "usp_upd_tbl_PM_TeamStructure_SoftBooking " + PrimaryKey.Trim + "," + Pipe_OR_Team_PK.ToString
                                    CommonFunction.Data.InsertOrUpdateData(strQuery, True)
                                End If
                                'End  Addition by SanaS 0n 18-Sep-2009
                                'strQuery = "usp_upd_AllocatedResource_Distribution 'P'," + Pipe_OR_Team_PK + ",'" + StartDate + "','" + EndDate + "'," + RoleID + "," + HttpContext.Current.Session("intProjectID").ToString
                                'CommonFunction.Data.InsertOrUpdateData(strQuery, True)

                            End If

                            'End If
                            'End of addition by ShraddhaM on 17,Sept 2008
                            ''Added by PrashantSJ on 28th July 2009 Purpose: to refersh gantt chart page 
                            'Dim sbHTML As New StringBuilder("")

                            'sbHTML.Append("<script language='javascript'>" + vbCrLf)
                            'sbHTML.Append("if(window.opener!=null) {" + vbCrLf)
                            'sbHTML.Append("var strParentPage;" + vbCrLf)
                            'sbHTML.Append("strParentPage = new String();" + vbCrLf)

                            'sbHTML.Append("strParentPage = opener.location.href;" + vbCrLf)

                            'sbHTML.Append("if (strParentPage.toUpperCase().indexOf('GanttChartView.aspx') != -1)" + vbCrLf)
                            'sbHTML.Append("{" + vbCrLf)
                            'sbHTML.Append("window.opener.document.forms['frmGanttChartView'].action = '../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" & CommonFunction.Constants.APP_TAG_RESOURCES.ToString + "';" + vbCrLf)
                            'sbHTML.Append("try{window.opener.document.forms['frmGanttChartView'].submit();}catch(e){}" + vbCrLf)
                            'sbHTML.Append("}" + vbCrLf)
                            'sbHTML.Append("}" + vbCrLf)
                            'sbHTML.Append("</script>")

                            If HttpContext.Current.Request.Form("hidFrom") = "RCV" Then
                                Dim sbHTML As New StringBuilder("")
                                sbHTML.Append("<script language='javascript'>" + vbCrLf)
                                sbHTML.Append("if(window.opener!=null) {" + vbCrLf)
                                sbHTML.Append("window.opener.location.href = window.opener.location.href;" + vbCrLf)
                                sbHTML.Append("}" + vbCrLf)
                                sbHTML.Append("if(window.opener.opener!=null) {" + vbCrLf)
                                sbHTML.Append("window.opener.opener.location.href = window.opener.opener.location.href;" + vbCrLf)
                                sbHTML.Append("}" + vbCrLf)
                                sbHTML.Append("</script>")

                                HttpContext.Current.Response.Write(sbHTML.ToString)

                            End If

                            HttpContext.Current.Response.Write(CommonFunction.General.GetRefreshParentScript("'frmGanttChartView'", "'GanttChartView.aspx'", "'../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" & CommonFunction.Constants.APP_TAG_RESOURCES.ToString + "'", False))
                            HttpContext.Current.Response.Write(CommonFunction.General.GetRefreshParentScript("'GraphOutlook'", "'Home_OutlookView.aspx'", "'../Home/Home_OutlookView.aspx?List=11&MasterTagID=" & CommonFunction.Constants.APP_TAG_RESOURCES.ToString + "'", False))
                            'HttpContext.Current.Response.Write(sbHTML.ToString)
                            'sbHTML = Nothing
                            'AfterSave += CommonFunction.General.GetRefreshParentScript("'frmGanttChartView'", "'GanttChartView.aspx'", "'../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" & CommonFunction.Constants.APP_TAG_RESOURCES.ToString + "'", True)

                            ''End of addition by PrashantSJ on 28th July 2009 Purpose: to refersh gantt chart page 

                            '---- Added BY PurvAJ on 23 Dec 2008 for whiziblesem 8.0
                            '---- to refresh workflow hash table
                        Case CommonFunction.Constants.APP_TAG_WORKFLOW_STAGES
                            '---- End addition purvaj
                            Dim objWorkFlowHashTable As New WorkFlowCommonEngine.HashTables.CreateProcessDefinationHashTables
                            objWorkFlowHashTable.CreateProcessMasterHashTable("C6FCF802-8FB7-49DB-A4D2-1EB521BBEE84")
                            objWorkFlowHashTable = Nothing

                            'Added By Bharat T on 29th-Nov-2016 for Euronet Issue fixing
                        Case CommonFunction.Constants.TAG_LOGIN_MAINTENANCE_CUSTOMER
                            If IsEditMode = True Then


                                Dim lngUserId As Long
                                Dim strLoginName As String
                                Dim strPassword As String
                                Dim strUserType As String

                                strLoginName = HttpContext.Current.Request.Form("LoginName")
                                strPassword = HttpContext.Current.Request.Form("Password")


                                ''Added By Vaijat K ON 24/02/2017 For password encryption
                                Dim strCount As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("NonDatabase3"))
                                Dim strencryptedkey As String = ""
                                Dim strencryptedlength As String = ""
                                Dim struniqueid As String = ""
                                Dim IsValid As Boolean = False


                                'Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
                                struniqueid = XMLHttp.m_LoginHashTable.Item(strLoginName)
                                'End of Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
                                ''Added By Vaijat K ON 24/02/2017 For password encryption
                                strencryptedkey = strPassword.Substring(1, strCount)

                                Dim strpwd1 As String() = strPassword.Split("|")
                                strPassword = ""
                                For i As Integer = 0 To strpwd1.Length - 2
                                    strPassword &= strpwd1(i).Substring(0, 1)
                                Next
                                strPassword = StrReverse(strPassword)
                                ''End Added By Vaijat K ON 24/02/2017 For password encryption



                                strUserType = HttpContext.Current.Session("LoginType").ToString
                                lngUserId = HttpContext.Current.Session("intUserID").ToString

                                Dim drEmail As IDataReader = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 20032", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                Dim blnSendEmail As Boolean = False
                                Dim blnShowPopup As Boolean = True

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
                                        Call CommonFunction.EmailMessages.RMMessages.GetEmailMessage_20032(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, lngUserId, strUserType, strLoginName, strPassword)
                                        Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                                    Else
                                        'SendEmailForNewLogin = "window.open (" + Chr(34) + "../General/SendEmail.aspx?MessageID=12&UserType=" + strUserType + "&UserID=" + lngUserId.ToString + "&LoginName=" + strLoginName + "&Password=" + strPassword + Chr(34) + ",null,""resizable=yes,scrollbars=no,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=600,height=500"");" + vbCrLf

                                        ''window.open (" + Chr(34) + "../General/SendEmail.aspx?MessageID=20&TaskID=," + intTaskID + "," + Chr(34) + ",""Task"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=600,height=500"");" + vbCrLf
                                        'SendEmailForNewLogin += "<Script language=javascript>" + vbCrLf
                                        'SendEmailForNewLogin += "	window.open (" + Chr(34) + "../General/SendEmail.aspx?MessageID=12&UserType=" + strUserType + "&UserID=" + lngUserId.ToString + "&LoginName=" + strLoginName + "&Password=" + strPassword + Chr(34) + ",null,""resizable=yes,scrollbars=no,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=600,height=500"");" + vbCrLf
                                        'SendEmailForNewLogin += "</Script>" + vbCrLf
                                        Call CommonFunction.EmailMessages.RMMessages.GetEmailMessage_20032(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, lngUserId, strUserType, strLoginName, strPassword)
                                        Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)


                                    End If
                                End If
                            End If
                            'End of Added By Bharat T on 29th-Nov-2016 for Euronet Issue fixing
                    End Select
                Else
                    'For Sub Tag Page - After Save Event
                    Select Case WhizGlobal.TagID
                        '    'Code Added By PradipK on 29 Dec 2006
                        '    'Purpose : Page Crash while adding  Existing Organization Unit.

                        'Case CommonFunction.Constants.APP_TAG_TAB_NEW_EXISTING_OU
                        '        'Response.Write("</Script>")
                        '        If IsEditMode = False Then
                        '            'AfterSave += " window.opener.location.href='CommonPage.aspx?SubTagID=2080&FocusOn=SUBTAG&PagingNumber=1;'" + vbCrLf
                        '            'AfterSave += " window.close();" + vbCrLf


                        '            AfterSave += " window.opener.location.href=window.opener.location.href;" + vbCrLf
                        '            AfterSave += " window.close();" + vbCrLf

                        '            'AfterSave += "window.opener.document.forms['frmCommonPage'].action = 'CommonPage.aspx?SubTagID=2080&FocusOn=SUBTAG&PagingNumber=1';" + vbCrLf
                        '            'AfterSave += "window.opener.document.forms['frmCommonPage'].submit();" + vbCrLf
                        '            'AfterSave += "window.close();"
                        '            strActionCode = ReturnCodes.ON_LOAD.ToString
                        '        End If

                        'Added By Sagar Nipane on 05-March-2019 Purpose::Project Work field level changes 
                        Case CommonFunction.Constants.APP_TAG_TAB_TRAINING_RESOURCES

                            Dim strSQLQuery As String
                            Dim WorkHourMinute As String
                            Dim WorkHour As String
                            Dim WorkMinute As String

                            WorkHourMinute = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase10"))
                            'WorkHourMinute = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + WorkHourMinute + "',2)", True)
                            If WorkHourMinute = "" Then
                                WorkHourMinute = "00:00"
                            End If

                            WorkHour = WorkHourMinute.Substring(0, WorkHourMinute.IndexOf(":"))
                            WorkMinute = WorkHourMinute.Substring(WorkHourMinute.IndexOf(":") + 1)

                            If WorkHour = "" Then
                                WorkHour = "0"
                            End If
                            If WorkMinute = "" Then
                                WorkMinute = "0"
                            End If
                            If WorkMinute.Length = 1 Then
                                WorkMinute = WorkMinute + "0"
                            End If

                            strSQLQuery = "EXEC usp_Whizible2_upd_EstimatedEffortsForWBS " & PrimaryKey & ",'" & WorkHour & "','" & WorkMinute & "',8"
                            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, True)
                            ''End of Added By Sagar Nipane on 05-March-2019 Purpose::Project Work field level changes

                        Case CommonFunction.Constants.APP_TAG_TAB_REVIEW_ACTIONS
                            If IsEditMode = False Then
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

                            'Added By Sagar Nipane on 01-March-2019 Purpose::Project Work field level changes 

                            Dim strSQLQuery As String
                            Dim WorkHourMinute As String
                            Dim WorkHour As String
                            Dim WorkMinute As String

                            WorkHourMinute = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase10"))
                            'WorkHourMinute = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + WorkHourMinute + "',2)", True)
                            If WorkHourMinute = "" Then
                                WorkHourMinute = "00:00"
                            End If

                            WorkHour = WorkHourMinute.Substring(0, WorkHourMinute.IndexOf(":"))
                            WorkMinute = WorkHourMinute.Substring(WorkHourMinute.IndexOf(":") + 1)

                            If WorkHour = "" Then
                                WorkHour = "0"
                            End If
                            If WorkMinute = "" Then
                                WorkMinute = "0"
                            End If
                            If WorkMinute.Length = 1 Then
                                WorkMinute = WorkMinute + "0"
                            End If

                            strSQLQuery = "EXEC usp_Whizible2_upd_EstimatedEffortsForWBS " & PrimaryKey & ",'" & WorkHour & "','" & WorkMinute & "',7"
                            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, True)
                            ''End of Added By Sagar Nipane on 01-March-2019 Purpose::Project Work field level changes

                        Case CommonFunction.Constants.APP_TAG_TAB_PROCESS_ROLES
                            'Update the Status flag of tbl_PRS_Process_Draft table to "D"
                            Dim strProcessID As String = strMasterPrimaryKey
                            Dim strSQL As String = "usp_Upd_UpdateProcessDraftStatus " + strProcessID
                            CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        Case CommonFunction.Constants.APP_TAG_TAB_PROCESS_ACTIVITIES
                            'Update the Status flag of tbl_PRS_Process_Draft table to "D"
                            Dim strProcessID As String = strMasterPrimaryKey
                            Dim strSQL As String = "usp_Upd_UpdateProcessDraftStatus " + strProcessID
                            CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        Case CommonFunction.Constants.APP_TAG_TAB_LEAVES
                            Dim strLeaveTypeID As String
                            Dim strDesignationID As String
                            Dim strNoOfLeaves As String

                            Dim strSQL As String
                            'insert or update the record for tbl_PM_EmployeeLeaveMaster depending on the 
                            'roleID / designationID and leavetype id 
                            strLeaveTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form.Get("LeaveTypeID"))
                            strDesignationID = strMasterPrimaryKey
                            strNoOfLeaves = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form.Get("NoOfLeaves").ToString)


                            If IsEditMode Then

                                strSQL = "usp_upd_tbl_PM_EmployeeLeaveMaster " + strLeaveTypeID + "," + strDesignationID + "," + strNoOfLeaves
                            Else
                                strSQL = "usp_ins_tbl_PM_EmployeeLeaveMaster " + strLeaveTypeID + "," + strDesignationID
                            End If
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            'Added by SatyanarayanaA on 10-Jan-2006
                        Case CommonFunction.Constants.APP_TAG_TAB_REVIEW_REVIEWER
                            Dim strSQL As String
                            strSQL = "usp_Ins_WPBN_CreateReviewTask_ForReviewer " + PrimaryKey + ",'" + WhizGlobal.UserName + "'"
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            ''Added By Sagar Nipane on 01-March-2019 Purpose::Project Work field level changes 
                            Dim strSQLQuery As String
                            Dim WorkHourMinute As String
                            Dim WorkHour As String
                            Dim WorkMinute As String

                            WorkHourMinute = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase10"))
                            'WorkHourMinute = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + WorkHourMinute + "',2)", True)
                            If WorkHourMinute = "" Then
                                WorkHourMinute = "00:00"
                            End If

                            WorkHour = WorkHourMinute.Substring(0, WorkHourMinute.IndexOf(":"))
                            WorkMinute = WorkHourMinute.Substring(WorkHourMinute.IndexOf(":") + 1)

                            If WorkHour = "" Then
                                WorkHour = "0"
                            End If
                            If WorkMinute = "" Then
                                WorkMinute = "0"
                            End If
                            If WorkMinute.Length = 1 Then
                                WorkMinute = WorkMinute + "0"
                            End If

                            strSQLQuery = "EXEC usp_Whizible2_upd_EstimatedEffortsForWBS " & PrimaryKey & ",'" & WorkHour & "','" & WorkMinute & "',9"
                            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, True)
                            '''End of Added By Sagar Nipane on 01-March-2019 Purpose::Project Work field level changes

                        Case CommonFunction.Constants.APP_TAG_TAB_REVIEW_AUTHOR
                            Dim strSQL As String

                            strSQL = "usp_Ins_WPBN_CreateReviewTask_ForAuthor " + PrimaryKey + ",'" + WhizGlobal.UserName + "'"
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))


                            'Ended by SatyanarayanaA on 10-Jan-2006
                            'Added By Sagar Nipane on 01-March-2019 Purpose::Project Work field level changes 
                            Dim strSQLQuery As String
                            Dim WorkHourMinute As String
                            Dim WorkHour As String
                            Dim WorkMinute As String

                            WorkHourMinute = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase10"))
                            'WorkHourMinute = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + WorkHourMinute + "',2)", True)
                            If WorkHourMinute = "" Then
                                WorkHourMinute = "00:00"
                            End If

                            WorkHour = WorkHourMinute.Substring(0, WorkHourMinute.IndexOf(":"))
                            WorkMinute = WorkHourMinute.Substring(WorkHourMinute.IndexOf(":") + 1)

                            If WorkHour = "" Then
                                WorkHour = "0"
                            End If
                            If WorkMinute = "" Then
                                WorkMinute = "0"
                            End If
                            If WorkMinute.Length = 1 Then
                                WorkMinute = WorkMinute + "0"
                            End If

                            strSQLQuery = "EXEC usp_Whizible2_upd_EstimatedEffortsForWBS " & PrimaryKey & ",'" & WorkHour & "','" & WorkMinute & "',10"
                            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, True)
                            'End of Added By Sagar Nipane on 01-March-2019 Purpose::Project Work field level changes




                            'added by harshada d for helpdesk on 24 feb 2006  for whiziblesem 6.0 issue id 1936
                            'Case CommonFunction.Constants.APP_TAG_TAB_PROJECT_MAPPING
                            '    Dim strSQL As String
                            '    Dim strMasterPrimaryKeyValue As String
                            '    strSQL = "usp_UPD_tbl_CRM_Function_ProjectMapping " + strMasterPrimaryKey.ToString + "," + PrimaryKey
                            '    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '    'end of addition by harshada d for hrlpdesk for whiziblesem 6.0 issue id 1936


                        Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEREQUEST_SKILLS, CommonFunction.Constants.APP_TAG_TAB_RESOURCEEXTENDREQUEST_SKILLS
                            Dim strSQL As String
                            'Update the configured Days for that request
                            strSQL = "usp_Upd_tbl_PM_ResourceRequest_ConfiguredDays " + strMasterPrimaryKey
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            ' WhizibleE SP2
                            ' Commented By NitinVS on 24 Feb 2005 
                            ' This Update SP is called through Trigger only if the field values are changed

                            '    'added By SachinR   on 29 Jul 2004
                            'Case CommonFunction.Constants.APP_TAG_TAB_PROCESS_PHASETASK_TEMPLATES

                            ''update the status of the template to 'D' after modifying the data
                            'Dim strSQL As String
                            'Dim strTemplateID As String
                            'strTemplateID = HttpContext.Current.Request("ForeignKeyValue") + ""

                            'strSQL = "usp_upd_PRS_UpdatePhaseTaskTemplateDraftStatus " + strTemplateID.Trim
                            'CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            ''addition end

                            ' End Addition by NitinVS 24 FEb 2005 
                            ' PBNIET SP2 

                            'added by SachinR   on 30 Jul 2004

                            ' Modifed By NitinVS on 28 Feb 2005 for WhizibleE SP2
                            ' The update procedure is called through the Trigger for Phase Task Activity 

                            'Case CommonFunction.Constants.APP_TAG_TAB_PHASETASK_ACTIVITY, CommonFunction.Constants.APP_TAG_TAB_PHASETASK_UPLOADDOCUMENT

                            ' End Modification By NitinVS on 28 Feb 2005 for WhizibleE SP2

                        Case CommonFunction.Constants.APP_TAG_TAB_PHASETASK_UPLOADDOCUMENT
                            'update the phasetask table to change the staus of phasetask to draft='D'
                            Dim strSQL As String
                            Dim strPhaseTaskID As String
                            strPhaseTaskID = HttpContext.Current.Request("ForeignKeyValue") + ""

                            strSQL = "usp_Upd_UpdatePhaseTaskDraftStatus " + strPhaseTaskID.Trim
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            'addition end

                            ' Commented  By NitinVS On 28 Feb 2005 for WhizibleE SP2
                            ' Th Update Sp is called throught Trigger
                            '    'added by SachinR   on 26 Aug 2004

                            'Case CommonFunction.Constants.APP_TAG_TAB_ASSOCIATED_PHASE_TASK
                            '    'update the status of project template to Draft(D)
                            '    'also update the status of all related phasetasks and activties
                            '    If IsEditMode = True Then
                            '        Dim strTemplateID As String
                            '        Dim strSQL As String
                            '        strTemplateID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("TemplateID"), "")
                            '        strSQL = "usp_upd_updateTemplateStatusToDraft " + strTemplateID.Trim
                            '        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                            '    End If
                            '    'addition end

                            ' End Comment By NitinVS on 28 Feb 2005 for WhizibleE SP2

                            'added by SachinR   on 20 Oct 2004
                            'Here records for the employee access for the deliverable type are inserted 
                        Case CommonFunction.Constants.APP_TAG_TAB_DELIVERABLE_SETTINGS
                            Dim strSQL As String

                            'if it is Add mode then insert record
                            strSQL = "usp_Ins_tbl_PM_DeliverableType_RoleMapping " + PrimaryKey.Trim + ",'" + WhizGlobal.UserName.Trim + "'"
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            'addition end

                            'added by SachinR   on 02 Nov 2004
                            'to implement the hashtable for the deliverable field configuration
                            'here hashtable is refreshed for the deliverable type which is edited here
                        Case CommonFunction.Constants.APP_TAG_TAB_DELIVERABLE_FIELDS
                            Dim lngDeliverableTypeID As Long = 0

                            If strMasterPrimaryKey <> "" Then
                                lngDeliverableTypeID = CType(strMasterPrimaryKey, Long)
                                CommonEngine.HashTables.Deliverable.CreateDeliverableHashTable(lngDeliverableTypeID)
                            End If
                            'addition end
                            'Added by ShraddhaM on 11,Jul 2008
                            'Purpose : To integrate Risk Registration from Whizible 2007 
                        Case CommonFunction.Constants.APP_SUB_TAG_P12PROJECT_RISKS_MITIGATION_PLAN

                            Dim intMessageID As Integer
                            Dim strMailTo As String = ""
                            Dim strFromMail As String = ""
                            Dim strMailCC As String = ""
                            Dim strSubject As String = ""
                            Dim strMessage As String = ""
                            Dim drEmailMessage As IDataReader
                            Dim lngProjectId As Long
                            Dim strSQL, strRisk As String
                            Dim drRiskID As IDataReader
                            Dim intRiskID As Integer
                            Dim blnSendEmail As Boolean
                            Dim blnShowPopup As Boolean
                            Dim intMitigationPlanID As Integer

                            intMessageID = 534
                            If PrimaryKey.ToString <> "" Then

                                intMitigationPlanID = PrimaryKey.ToString

                                strSQL = "EXEC usp_Sel_tbl_PM_EmailMessages " & CommonFunction.General.CheckIsNothing(intMessageID, "0").ToString()
                                drEmailMessage = CommonFunction.Data.GetDataReader(strSQL, True)
                                lngProjectId = HttpContext.Current.Session("intProjectID").ToString
                                intMessageID = 534

                                If drEmailMessage.Read Then
                                    blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                                    blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                                End If

                                CommonFunction.Data.DisposeDataReader(drEmailMessage)

                                If intMessageID = 534 Then
                                    If blnSendEmail = True And blnShowPopup = True Then
                                        AfterSave = "window.open('../General/SendEmail.aspx?MessageID=534&MitigationPlanID=" + intMitigationPlanID.ToString + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500');" + vbCrLf
                                    End If

                                    If blnSendEmail = True And blnShowPopup = False Then
                                        CommonFunction.EmailMessages.PMMessages.GetEmailMessage_534(strFromMail, strMailTo, strMailCC, strSubject, strMessage, intMitigationPlanID)
                                        CommonFunction.Emails.AppSendEmailWithCC(strMailTo, strFromMail, strMailCC, strSubject, strMessage)
                                    End If
                                End If
                            End If

                            strActionCode = ReturnCodes.ON_LOAD.ToString

                            ''Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 
                        Case CommonFunction.Constants.APP_TAG_TAB_FASTTRACKREVIEW_ACTIONS

                            Dim StrSQLQuery As String
                            Dim WorkHourMinute As String
                            Dim WorkHour As String
                            Dim WorkMinute As String

                            WorkHourMinute = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase2"))

                            If WorkHourMinute = "" Then
                                WorkHourMinute = "00:00"
                            End If

                            WorkHour = WorkHourMinute.Substring(0, WorkHourMinute.IndexOf(":"))
                            WorkMinute = WorkHourMinute.Substring(WorkHourMinute.IndexOf(":") + 1)

                            If WorkHour = "" Then
                                WorkHour = "0"
                            End If
                            If WorkMinute = "" Then
                                WorkMinute = "0"
                            End If
                            If WorkMinute.Length = 1 Then
                                WorkMinute = WorkMinute + "0"
                            End If

                            StrSQLQuery = "EXEC usp_Whizible2_upd_EstimatedEffortsForWBS " & PrimaryKey & ",'" & WorkHour & "','" & WorkMinute & "',7"
                            CommonFunction.Data.InsertOrUpdateData(StrSQLQuery, True)

                            ''End of Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes



                        Case CommonFunction.Constants.APP_SUB_TAG_P12PROJECT_RISKS_CONTINEGENCY_PLAN

                            Dim intMessageID As Integer
                            Dim strMailTo As String = ""
                            Dim strFromMail As String = ""
                            Dim strMailCC As String = ""
                            Dim strSubject As String = ""
                            Dim strMessage As String = ""
                            Dim drEmailMessage As IDataReader
                            Dim lngProjectId As Long
                            Dim strSQL, strRisk As String
                            Dim drRiskID As IDataReader
                            Dim intRiskID As Integer
                            Dim blnSendEmail As Boolean
                            Dim blnShowPopup As Boolean
                            Dim intContingencyPlanID As Integer

                            intMessageID = 538
                            If PrimaryKey.ToString <> "" Then

                                intContingencyPlanID = PrimaryKey.ToString

                                strSQL = "EXEC usp_Sel_tbl_PM_EmailMessages " & CommonFunction.General.CheckIsNothing(intMessageID, "0").ToString()
                                drEmailMessage = CommonFunction.Data.GetDataReader(strSQL, True)
                                lngProjectId = HttpContext.Current.Session("intProjectID").ToString
                                intMessageID = 538

                                If drEmailMessage.Read Then
                                    blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                                    blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                                End If

                                CommonFunction.Data.DisposeDataReader(drEmailMessage)

                                If intMessageID = 538 Then
                                    If blnSendEmail = True And blnShowPopup = True Then
                                        AfterSave = "window.open('../General/SendEmail.aspx?MessageID=538&ContingencyPlanID=" + intContingencyPlanID.ToString + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500');" + vbCrLf
                                    End If

                                    If blnSendEmail = True And blnShowPopup = False Then
                                        CommonFunction.EmailMessages.PMMessages.GetEmailMessage_538(strFromMail, strMailTo, strMailCC, strSubject, strMessage, intContingencyPlanID)
                                        CommonFunction.Emails.AppSendEmailWithCC(strMailTo, strFromMail, strMailCC, strSubject, strMessage)
                                    End If
                                End If
                            End If
                        
                            strActionCode = ReturnCodes.ON_LOAD.ToString
                            'End of addition by ShraddhaM
                            ''Added By Ankush Toraskar on 05-Mar-2019 Purpose::Project Work field level changes in Modification Efforts subtag 
                        Case CommonFunction.Constants.SUBTAG_TAB_WORK_VALIDATIONS

                            Dim StrSQLQuery As String
                            Dim WorkHourMinute As String
                            Dim WorkHour As String
                            Dim WorkMinute As String

                            WorkHourMinute = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase1"))

                            If WorkHourMinute = "" Then
                                WorkHourMinute = "00:00"
                            End If

                            WorkHour = WorkHourMinute.Substring(0, WorkHourMinute.IndexOf(":"))
                            WorkMinute = WorkHourMinute.Substring(WorkHourMinute.IndexOf(":") + 1)

                            If WorkHour = "" Then
                                WorkHour = "0"
                            End If
                            If WorkMinute = "" Then
                                WorkMinute = "0"
                            End If
                            If WorkMinute.Length = 1 Then
                                WorkMinute = WorkMinute + "0"
                            End If

                            StrSQLQuery = "EXEC usp_Whizible2_upd_EstimatedEffortsForWBS " & PrimaryKey & ",'" & WorkHour & "','" & WorkMinute & "',11"
                            CommonFunction.Data.InsertOrUpdateData(StrSQLQuery, True)

                            ''End of Added By Ankush Toraskar on 05-Mar-2019 Purpose::Project Work field level changes in Modification Efforts subtag 


                            ''Added By Ankush Toraskar on 05-Mar-2019 Purpose::Project Work field level changes in Contingency Plans subtag
                        Case CommonFunction.Constants.APP_TAG_TAB_CONTINGENCYPLAN

                            Dim StrSQLQuery As String
                            Dim WorkHourMinute As String
                            Dim WorkHour As String
                            Dim WorkMinute As String

                            WorkHourMinute = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase1"))

                            If WorkHourMinute = "" Then
                                WorkHourMinute = "00:00"
                            End If

                            WorkHour = WorkHourMinute.Substring(0, WorkHourMinute.IndexOf(":"))
                            WorkMinute = WorkHourMinute.Substring(WorkHourMinute.IndexOf(":") + 1)
                            If WorkHour = "" Then
                                WorkHour = "0"
                            End If
                            If WorkMinute = "" Then
                                WorkMinute = "0"
                            End If
                            If WorkMinute.Length = 1 Then
                                WorkMinute = WorkMinute + "0"
                            End If
                            StrSQLQuery = "EXEC usp_Whizible2_upd_EstimatedEffortsForWBS " & PrimaryKey & ",'" & WorkHour & "','" & WorkMinute & "',13"
                            CommonFunction.Data.InsertOrUpdateData(StrSQLQuery, True)

                            ''End of Added By Ankush Toraskar on 05-Mar-2019 Purpose::Project Work field level changes in Contingency Plans subtag


                    End Select
                End If

            End Function

            Public Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal) As String
                BeforeDelete = ""
                'Application standard return code
                strActionCode = ReturnCodes.DO_NOTHING.ToString
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag Page - Before Delete Event
                    Select Case WhizGlobal.TagID

                        'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                        'Added By SandeepA on 14 Nov,2005 for IssueID --676
                        'Page : Project Information Role Access :TagID=3083
                        'Purpose: Grant access to users for the Project Information page
                        Case CommonFunction.Constants.APP_TAG_ProjectInfoRoleAccess
                            'Call the following for select of Role Access for Project Information Page.
                            Dim strSQL As String
                            Dim arrComma As Char() = {","c}
                            Dim strSelectList As String() = DeletedIDList.Split(arrComma)
                            Dim strRoleID As String
                            If WhizGlobal.ProjectID <> 0 Then
                                'Delete all the records corresponding to the ProjectID
                                strSQL = "usp_Del_tbl_PM_ProjectInfoRoleAccess " & WhizGlobal.ProjectID
                                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                For Each strRoleID In strSelectList
                                    'Insert into table the Selected records
                                    If strRoleID <> "" Then
                                        strSQL = "usp_ins_tbl_PM_ProjectInfoRoleAccess  " & WhizGlobal.ProjectID & "," & strRoleID
                                        CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    End If
                                Next
                            End If
                            strActionCode = ReturnCodes.IGNORE_DELETE.ToString
                            'End of addition by SandeepA on 14 Nov,2005 for IssueId -676
                            'End Integration

                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                            'Added By SandeepA on 15 Nov,2005 for IssueID --677
                            'Page : Business group Middle Level Resource Project Access :TagID=3087
                            'Purpose: Grant access to users for the Project 
                        Case CommonFunction.Constants.APP_TAG_BG_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            'Call the following for select of Role Access for Project Information Page.
                            Dim strSQL As String
                            Dim arrComma As Char() = {","c}
                            Dim strSelectList As String() = DeletedIDList.Split(arrComma)
                            Dim strProjectID As String
                            Dim strBusinessGroupEmployeeID As String

                            strBusinessGroupEmployeeID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupEmployeeID"), ""))
                            'Comment removed by JyotiG
                            'Start_JG_12307_26-Mar-2007
                            'Issue : Steps to reproduce the issue :
                            '1. Go to Configuration --> Organisation --> Organisation Unit --> Middle Level Resource[Subtab]
                            '2. Click on Set Project Access link
                            '3. Click on Filter --> Apply the filter 
                            '4. Now clear the filter --> select the project and click on save 
                            'Actual Result : Page crash occures
                            '[22-Mar-2007 11:25:08 AM - SujataK] Same thing is applicable for :
                            'Configuration --> Organisation --> Business Group --> Middle Level Resource[Subtab]

                            If (strBusinessGroupEmployeeID = "") Then
                                strBusinessGroupEmployeeID = CStr(HttpContext.Current.Session("BusinessGroupEmployeeID"))
                            End If
                            'End_JG_12307_26-Mar-2007
                            'HttpContext.Current.Session("BusinessGroupEmployeeID") = strBusinessGroupEmployeeID
                            'Delete all the records corresponding to the ProjectID
                            strSQL = "usp_del_tbl_CNF_BusinessGroups_ResourceProjectAccess " & strBusinessGroupEmployeeID
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            For Each strProjectID In strSelectList
                                'Insert into table the Selected records
                                If strProjectID <> "" Then
                                    strSQL = "usp_ins_tbl_CNF_BusinessGroups_ResourceProjectAccess  " & strBusinessGroupEmployeeID & "," & strProjectID
                                    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                End If
                            Next
                            strActionCode = ReturnCodes.IGNORE_DELETE.ToString
                            'End of addition by SandeepA on 15 Nov,2005 for IssueId -677
                            'End Integration
                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2							
                            'Added By SandeepA on 15 Nov,2005 for IssueID --679
                            'Page : Organization Unit Middle Level Resource Project Access :TagID=3088
                            'Purpose: Grant access to users for the Project 
                        Case CommonFunction.Constants.APP_TAG_OU_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            'Call the following for select of Role Access for Project Information Page.
                            Dim strSQL As String
                            Dim arrComma As Char() = {","c}
                            Dim strSelectList As String() = DeletedIDList.Split(arrComma)
                            Dim strProjectID As String
                            Dim strLocationEmployeeID As String

                            strLocationEmployeeID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("LocationEmployeeID"), ""))
                            'Comments are removed by JyotiG
                            'Start_JG_12307_26-MAr-2007
                            'Issue : Steps to reproduce the issue :
                            '1. Go to Configuration --> Organisation --> Organisation Unit --> Middle Level Resource[Subtab]
                            '2. Click on Set Project Access link
                            '3. Click on Filter --> Apply the filter 
                            '4. Now clear the filter --> select the project and click on save 
                            'Actual Result : Page crash occures
                            '[22-Mar-2007 11:25:08 AM - SujataK] Same thing is applicable for :
                            'Configuration --> Organisation --> Business Group --> Middle Level Resource[Subtab]
                            If (strLocationEmployeeID = "") Then
                                strLocationEmployeeID = CStr(HttpContext.Current.Session("LocationEmployeeID"))
                            End If
                            'End_JG_12307_26-MAr-2007
                            'HttpContext.Current.Session("LocationEmployeeID") = strLocationEmployeeID
                            'Delete all the records corresponding to the ProjectID
                            strSQL = "usp_del_tbl_PM_Location_ResourceProjectAccess " & strLocationEmployeeID
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            For Each strProjectID In strSelectList
                                'Insert into table the Selected records
                                If strProjectID <> "" Then
                                    strSQL = "usp_ins_tbl_PM_Location_ResourceProjectAccess  " & strLocationEmployeeID & "," & strProjectID
                                    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                End If
                            Next
                            strActionCode = ReturnCodes.IGNORE_DELETE.ToString
                            'End of addition by SandeepA on 15 Nov,2005 for IssueId -679
                            'End Integration

                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                            'Added By SandeepA on 16 Nov,2005 for IssueID --680

                            'Page : Delivery Unit Middle Level Resource Project Access :TagID=3090
                            'Purpose: Grant access to users for the Project 
                        Case CommonFunction.Constants.APP_TAG_DU_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            'Call the following for select of Role Access for Project Information Page.
                            Dim strSQL As String
                            Dim arrComma As Char() = {","c}
                            Dim strSelectList As String() = DeletedIDList.Split(arrComma)
                            Dim strProjectID As String
                            Dim strResourcePoolEmployeeID As String

                            strResourcePoolEmployeeID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ResourcePoolEmployeeID"), ""))
                            'If (strResourcePoolEmployeeID = "") Then
                            'strResourcePoolEmployeeID = CStr(HttpContext.Current.Session("ResourcePoolEmployeeID"))
                            'End If
                            'HttpContext.Current.Session("ResourcePoolEmployeeID") = strResourcePoolEmployeeID
                            'Delete all the records corresponding to the ProjectID
                            strSQL = "usp_del_tbl_PM_ResourcePool_ResourceProjectAccess " & strResourcePoolEmployeeID
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            For Each strProjectID In strSelectList
                                'Insert into table the Selected records
                                If strProjectID <> "" Then
                                    strSQL = "usp_ins_tbl_PM_ResourcePool_ResourceProjectAccess   " & strResourcePoolEmployeeID & "," & strProjectID
                                    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                End If
                            Next
                            strActionCode = ReturnCodes.IGNORE_DELETE.ToString
                            'End of addition by SandeepA on 15 Nov,2005 for IssueId -680
                            'End Integration
                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                            'Added By SandeepA on 16 Nov,2005 for IssueID --681
                            'Page : Delivery Team Middle Level Resource Project Access :TagID=3092
                            'Purpose: Grant access to users for the Project 
                        Case CommonFunction.Constants.APP_TAG_DT_MIDDLELEVEL_RESOURCE_PROJECT_ACCESS
                            'Call the following for select of Role Access for Project Information Page.
                            Dim strSQL As String
                            Dim arrComma As Char() = {","c}
                            Dim strSelectList As String() = DeletedIDList.Split(arrComma)
                            Dim strProjectID As String
                            Dim strGroupEmployeeID As String

                            strGroupEmployeeID = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("GroupEmployeeID"), ""))
                            'If (strGroupEmployeeID = "") Then
                            'strGroupEmployeeID = CStr(HttpContext.Current.Session("GroupEmployeeID"))
                            'End If
                            'HttpContext.Current.Session("GroupEmployeeID") = strGroupEmployeeID
                            'Delete all the records corresponding to the ProjectID
                            strSQL = "usp_del_tbl_PM_GroupMaster_ResourceProjectAccess  " & strGroupEmployeeID
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            For Each strProjectID In strSelectList
                                'Insert into table the Selected records
                                If strProjectID <> "" Then
                                    strSQL = "usp_ins_tbl_PM_GroupMaster_ResourceProjectAccess   " & strGroupEmployeeID & "," & strProjectID
                                    CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                End If
                            Next
                            strActionCode = ReturnCodes.IGNORE_DELETE.ToString
                            'End of addition by SandeepA on 15 Nov,2005 for IssueId -681
                            'End Integration

                            ''------------------------------------------------------------------------------------------
                            ''Code added by RohiniK on 21 August 2006 for Role wise Access to All ISsues Tab in Issues Module  for Whiziblesem SP 7 Issue ID 5688 
                            ''added by RohiniK on 21 August 2006 for updating DisableAllIssues field in table
                        Case CommonFunction.Constants.APP_TAG_CONFIG_TYPE_SECURITY_ROLES
                            Dim strSQL As String
                            Dim strProjectID As String
                            Dim strchkSelected As String = ""
                            'Added By ShraddhaM on 3,July 2007
                            'Purpose : Hide Batch Update Link as per Role Access given in Issue Type
                            Dim strchkBatch As String = ""
                            strchkBatch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkBatch"), "0")
                            strchkSelected = HttpContext.Current.Request.QueryString("chkSelected").ToString()
                            strProjectID = CStr(HttpContext.Current.Session("intProjectID"))
                            CommonFunction.Data.InsertOrUpdateData("usp_Ins_Upd_tbl_PM_ProjectEmployeeRole_BatchUpdate " + strProjectID + ",'" + strchkBatch + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            'End of Addition By ShraddhaM on 3,July 2007
                            If strchkSelected <> "0" Then
                                strSQL = "usp_Ins_Upd_tbl_PM_ProjectEmployeeRole " & strProjectID & ", '(" & DeletedIDList & ")'"
                            Else
                                strSQL = "usp_Ins_Upd_tbl_PM_ProjectEmployeeRole " & strProjectID
                            End If
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
                            ''End of Code addition by RohiniK on 21 August 2006 for Role wise Access to All ISsues Tab in Issues Module
                            ''------------------------------------------------------------------------------------------
                            '-----------------------------------------------
                            'Code Added by SajiU on 6th Dec 2006

                        Case CommonFunction.Constants.App_Tag_Login_Maintenance
                            Dim strSQL As String
                            Dim intCount As Integer
                            Dim strResult As Boolean
                            Dim arrComma As Char() = {","c}
                            Dim strSelectList As String() = DeletedIDList.Split(arrComma)
                            For intCount = 0 To strSelectList.Length - 1
                                strResult = DeleteLogin(CType(strSelectList(intCount).ToString, Long))
                                If strResult <> True Then
                                    Exit For

                                End If
                            Next
                            strActionCode = ReturnCodes.IGNORE_DELETE.ToString
                            'End of Addition on 6th Dec 2006
                            '-----------------------------------------------

                    End Select
                Else
                    'For Sub Tag Page - Before Delete Event
                    'Added By Chakshuta H on 29th-Oct-2015
                    '--------------------------------------------------------------------------------------------------------------------------------------------------
                    'Added By Shrikant B On 20 Nov 2008 For WAF3_GEN_18 - R2L Language Support
                    '---------------------------------------------------------------------------------------------------------------------------------------------------
                    Dim arrDeletedId() As String = DeletedIDList.Split(CChar(","))
                    Dim intLength As Integer = arrDeletedId.Length - 1
                    Dim strsession As String = ""
                    Dim iCount As Integer = 0
                    Dim strLCID As String = ""
                    'Ended By Chakshuta H on 29th-Oct-2015

                    Select Case WhizGlobal.TagID
                        'Added By Chakshuta H on 29th-Oct-2015
                        Case CommonFunctions.Constants.CULTURE_CONTROL_TAGMASTER
                            strsession = CStr(CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_tbl_UI_ControlTagMaster_culture_GetTagID " + arrDeletedId(0), True))
                            For iCount = 0 To intLength
                                strLCID = CStr(CommonFunctions.Data.GetDataScalar("SELECT LCID FROM tbl_UI_ControlTagMaster_culture WITH(NOLOCK) where UniqueID = " + arrDeletedId(iCount), True))
                                strsession += "," + strLCID
                            Next

                        Case CommonFunctions.Constants.CULTURE_TAGMASTER
                            strsession = CStr(CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_tbl_UI_TagMaster_culture_GetTagID " + arrDeletedId(0), True))
                            For iCount = 0 To intLength
                                strLCID = CStr(CommonFunctions.Data.GetDataScalar("SELECT LCID FROM tbl_UI_TagMaster_culture WITH(NOLOCK) where UniqueID = " + arrDeletedId(iCount), True))
                                strsession += "," + strLCID
                            Next

                        Case CommonFunctions.Constants.CULTURE_CONTROL_SUBTAG_MASTER
                            strsession = CStr(CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_tbl_UI_SubControlTagMaster_culture_GetTagID " + arrDeletedId(0), True))
                            For iCount = 0 To intLength
                                strLCID = CStr(CommonFunctions.Data.GetDataScalar("SELECT LCID FROM tbl_UI_SubControlTagMaster_culture WITH(NOLOCK) where UniqueID = " + arrDeletedId(iCount), True))
                                strsession += "," + strLCID
                            Next

                        Case CommonFunctions.Constants.CULTURE_SUBTAG_MASTER
                            strsession = CStr(CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_tbl_UI_SubTagMaster_culture_GetTagID " + arrDeletedId(0), True))
                            For iCount = 0 To intLength
                                strLCID = CStr(CommonFunctions.Data.GetDataScalar("SELECT LCID FROM tbl_UI_SubTagMaster_culture WITH(NOLOCK) where UniqueID = " + arrDeletedId(iCount), True))
                                strsession += "," + strLCID
                            Next

                        Case CommonFunctions.Constants.CULTURE_DYNAMICLINKS
                            strsession = CStr(CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_v_tbl_UI_Dynamic_Links_GetTagID  " + arrDeletedId(0) + ",0", True))
                            For iCount = 0 To intLength
                                strLCID = CStr(CommonFunctions.Data.GetDataScalar("SELECT LCID FROM tbl_UI_Dynamic_Links_culture WITH(NOLOCK) where UniqueID = " + arrDeletedId(iCount), True))
                                strsession += "," + strLCID
                            Next
                        Case CommonFunctions.Constants.CULTURE_SUBTAG_DYNAMICLINKS
                            strsession = CStr(CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_v_tbl_UI_Dynamic_Links_GetTagID " + arrDeletedId(0) + ",1", True))
                            For iCount = 0 To intLength
                                strLCID = CStr(CommonFunctions.Data.GetDataScalar("SELECT LCID FROM tbl_UI_SubTag_Dynamic_Links_culture WITH(NOLOCK) where UniqueID = " + arrDeletedId(iCount), True))
                                strsession += "," + strLCID
                            Next
                            'Case CommonFunctions.Constants.CULTURE_SYSTEM_LINKS
                            '    'CommonEngines.HashTables. 
                        Case CommonFunctions.Constants.CULTURE_VALIDATIONS
                            strsession = CStr(CommonFunctions.Data.GetDataScalar("SELECT VALIDATIONID FROM  TBL_UI_VALIDATION_CULTURE WITH(NOLOCK) WHERE UniqueID = " + arrDeletedId(0), True))
                            For iCount = 0 To intLength
                                strLCID = CStr(CommonFunctions.Data.GetDataScalar("SELECT LCID FROM  TBL_UI_VALIDATION_CULTURE WITH(NOLOCK) WHERE UniqueID = " + arrDeletedId(iCount), True))
                                strsession += "," + strLCID
                            Next
                        Case CommonFunctions.Constants.CULTURE_CONTROL_COMPARISON
                            strsession = CStr(CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_v_tbl_UI_ControlComparisonValidations_GetControlTagID " + arrDeletedId(0) + ",0", True))
                            For iCount = 0 To intLength
                                strLCID = CStr(CommonFunctions.Data.GetDataScalar("SELECT LCID FROM tbl_UI_ControlComparisonValidations_CULTURE WITH(NOLOCK) where UniqueID = " + arrDeletedId(iCount), True))
                                strsession += "," + strLCID
                            Next
                        Case CommonFunctions.Constants.CULTURE_SUBTAG_CONTROL_COMPARISON
                            strsession = CStr(CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_v_tbl_UI_ControlComparisonValidations_GetControlTagID " + arrDeletedId(0) + ",1", True))
                            For iCount = 0 To intLength
                                strLCID = CStr(CommonFunctions.Data.GetDataScalar("SELECT LCID FROM tbl_UI_ControlComparisonValidations_CULTURE WITH(NOLOCK) where UniqueID = " + arrDeletedId(iCount), True))
                                strsession += "," + strLCID
                            Next
                        Case CommonFunctions.Constants.CULTURE_OPTIONBUTTON
                            strsession = CStr(CommonFunctions.Data.GetDataScalar("EXEC usp_sel_tbl_tbl_UI_OptionButtonControlDetails_GetControlTagID  " + arrDeletedId(0) + ",0", True))
                            For iCount = 0 To intLength
                                strLCID = CStr(CommonFunctions.Data.GetDataScalar("SELECT LCID FROM tbl_UI_OptionButtonControlDetails_CULTURE WITH(NOLOCK) where UniqueID = " + arrDeletedId(iCount), True))
                                strsession += "," + strLCID
                            Next
                        Case CommonFunctions.Constants.CULTURE_SUBTAG_OPTIONBUTTON
                            strsession = CStr(CommonFunctions.Data.GetDataScalar("EXEC usp_sel_tbl_tbl_UI_OptionButtonControlDetails_GetControlTagID  " + arrDeletedId(0) + ",1", True))
                            For iCount = 0 To intLength
                                strLCID = CStr(CommonFunctions.Data.GetDataScalar("SELECT LCID FROM tbl_UI_OptionButtonControlDetails_CULTURE WITH(NOLOCK) where UniqueID = " + arrDeletedId(iCount), True))
                                strsession += "," + strLCID
                            Next
                        Case CommonFunctions.Constants.CULTURE_MODULE
                            strsession = "SystemModules"
                            For iCount = 0 To intLength
                                strLCID = CStr(CommonFunctions.Data.GetDataScalar("SELECT LCID FROM tbl_PM_SystemModules_Culture WITH(NOLOCK) where UniqueID = " + arrDeletedId(iCount), True))
                                strsession += "," + strLCID
                            Next

                        Case CommonFunctions.Constants.CULTURE_TAB_CONTROL
                            strsession = CStr(CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_tbl_ui_tabControl_culture_GetTabID  " + arrDeletedId(0) + ",0", True))
                            For iCount = 0 To intLength
                                strLCID = CStr(CommonFunctions.Data.GetDataScalar("SELECT LCID FROM tbl_ui_tabControls_culture WITH(NOLOCK) where UniqueID = " + arrDeletedId(iCount), True))
                                strsession += "," + strLCID
                            Next
                        Case CommonFunctions.Constants.CULTURE_TAB_SUBTAG_CONTROL
                            strsession = CStr(CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_tbl_ui_tabControl_culture_GetTabID  " + arrDeletedId(0) + ",1", True))
                            For iCount = 0 To intLength
                                strLCID = CStr(CommonFunctions.Data.GetDataScalar("SELECT LCID FROM tbl_ui_tabControls_culture WITH(NOLOCK) where UniqueID = " + arrDeletedId(iCount), True))
                                strsession += "," + strLCID
                            Next

                            'Ended By Chakshuta H on 29th-Oct-2015

                            'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                            'Added By NileshD on 6th Sep 2005 ReqID-WAF3_PB_8
                        Case CommonFunction.Constants.APP_TAG_TAB_GROUP_ACCESS
                            CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'E',null,null," + strMasterPrimaryKey)
                            'End Of Addition By NileshD on 6th Sep 2005 ReqID-WAF3_PB_8
                            'End Of Modifications - IssueID : 672

                        Case CommonFunction.Constants.APP_TAG_TAB_CHECKLIST_SECTIONS
                            'Call the following for deletion functionality of Checklist Sections sub tag
                            Dim strSQL As String
                            Dim arrComma As Char() = {","c}
                            Dim strChecklistSectionList As String() = DeletedIDList.Split(arrComma)
                            Dim strSectionID As String
                            For Each strSectionID In strChecklistSectionList
                                strSQL = "usp_Del_tbl_PRS_ChecklistSections_Draft " + strSectionID + ", '" + WhizGlobal.UserName + "'"
                                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            Next
                            strActionCode = ReturnCodes.IGNORE_DELETE.ToString
                        Case CommonFunction.Constants.APP_TAG_TAB_ROLE_MAPPING
                            Dim strFunctionRoleIDList As String() = DeletedIDList.Split(","c)
                            Dim strFunctionRoleID As String
                            For Each strFunctionRoleID In strFunctionRoleIDList
                                CommonFunction.Data.InsertOrUpdateData("usp_Del_tbl_CRM_Function_Roles_New " + strFunctionRoleID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            Next
                            strActionCode = ReturnCodes.IGNORE_DELETE.ToString

                        Case CommonFunction.Constants.APP_TAG_TAB_MILESTONE_DOCUMENTS, CommonFunction.Constants.APP_TAG_TAB_REVIEW_DOCUMENTS, CommonFunction.Constants.APP_TAG_TAB_CHANGE_REQUEST_DOCUMENTS, CommonFunction.Constants.APP_TAG_TAB_PHASE_DOCUMENTS, CommonFunction.Constants.APP_TAG_TAB_FAST_TRACK_REVIEW_DOCUMENTS
                            Dim strProjectId As String
                            Dim blnUseSQL As Boolean
                            Dim strDocumentIDList As String
                            Dim strwhatToDelete As String
                            strProjectId = HttpContext.Current.Session("intProjectID").ToString
                            blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
                            strDocumentIDList = DeletedIDList
                            strwhatToDelete = "A"

                            CommonFunction.ProjectDocument.DeleteDocument(strProjectId, strDocumentIDList, strwhatToDelete, blnUseSQL)
                            strActionCode = ReturnCodes.IGNORE_DELETE.ToString
                            ' Added By NitinVS on 11 May 2007 for WhizibleSEM 7.0 

                        Case CommonFunction.Constants.APP_TAG_TAB_PRODUCT_VERSION_AMC_COLLECTION
                            strActionCode = ReturnCodes.IGNORE_DELETE.ToString()
                            ' End Addition By NitinVS on 11 May 2007 for WhizibleSEM 7.0 

                            'Addition done by SuchitraP on 21-MAY-2007 for IssueID 13361 (Cleanup Activity)
                        Case CommonFunction.Constants.APP_TAG_TAB_EMPLOYEE_LEAVE_DETAILS
                            strActionCode = ReturnCodes.IGNORE_DELETE.ToString()
                            'End of Addition by SuchitraP on 21-MAY-2007 for IssueID 13361 (Cleanup Activity)
                            ' Commented by ArchanaN on 25-May-2011
                            'Puporpose : Functionality was added in sem8.0 but excluded in 10.0
                            'Added by ArchanaN on 8-Sept-2009
                            'Purpose : To update DepartmentID in EmployeeMaster
                            'Case CommonFunction.Constants.APP_SUB_TAG_DEPARTMENT_EMPLOYEESELECTION
                            '    Dim strQuery As String = ""
                            '     strQuery = "usp_Upd_tbl_PM_Employee_Department '" + DeletedIDList + ",',0"
                            '    CommonFunction.Data.InsertOrUpdateData(strQuery, True)
                            '    strActionCode = ReturnCodes.IGNORE_DELETE.ToString
                            'End of Added by ArchanaN on 8-Sept-2009
                            ' end of Commented by ArchanaN on 25-May-2011
                    End Select
                    'Added By Chakshuta H on 29th-Oct-2015
                    HttpContext.Current.Session("WAF_REFRESHCULTURE") = strsession
                    arrDeletedId = Nothing
                    strsession = ""
                    '--------------------------------------------------------------------------------------------------------------------------------------------------
                    'Addition End By Shrikant B On 20 Nov 2008 For WAF3_GEN_18 - R2L Language Support
                    '---------------------------------------------------------------------------------------------------------------------------------------------------

                    'Ended By Chakshuta H on 29th-Oct-2015

                End If

            End Function

            Public Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal) As String
                AfterDelete = ""
                'Application standard return code
                strActionCode = ReturnCodes.DO_NOTHING.ToString
                If WhizGlobal.ParentTagID = 0 Then
                    'For MASTER Tags
                    Select Case WhizGlobal.TagID
                        '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                        ' Added By Shrikant On 12 June 2008 Issue ID:20925
                        'Purpose : to udapte the system mdoules hash tables, if any body modifies the module details
                        Case CommonFunction.Constants.TAG_SYSTEM_MODULES, CommonFunction.Constants.TAG_USERDEFINED_MODULES
                            Call CommonEngines.HashTables.CreateHashTables.CreateSystemModuleHashTable()
                            'Addition End By Shrikant On 12 June 2008 Issue ID:20925
                            'Integrated BY NitinVS on 30 Jun 2007 for Whiz 2 SP8 
                            'Commented And Added by Chakshuta H on 29th-Oct-2015
                            'Case CommonFunction.Constants.TAG_OPTION_BUTTONS, CommonFunction.Constants.TAG_GRID_FORMATTING_RULES, CommonFunction.Constants.TAG_COMPARISON_VALIDATIONS, CommonFunction.Constants.TAG_DEFAULT_PAGE_FILTERS
                        Case CommonFunction.Constants.TAG_OPTION_BUTTONS, CommonFunction.Constants.TAG_GRID_FORMATTING_RULES, CommonFunction.Constants.TAG_COMPARISON_VALIDATIONS, CommonFunction.Constants.TAG_DEFAULT_PAGE_FILTERS, CommonFunction.Constants.TAG_QUERY_STRING_PARAMETERS 'Added By NinadP on 22 Jan 2008, ReqID WAF3_PB_57  
                            'End Of Commented And Added by Chakshuta H on 29th-Oct-2015

                            'For Master Tag Options buttons, Grid Formatting rules, Comparison Rules, Default Filters ...after deleting the record update the hash table
                            Call CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("TagID")), Long))
                            'Commented And Added by Chakshuta H on 29th-Oct-2015
                            'If WhizGlobal.TagID = CommonFunction.Constants.TAG_DEFAULT_PAGE_FILTERS Then
                            'Added By NinadP on 20 June 2007 ReqID - WAF3_PB_48
                            'Modified By NinadP on 22 Jan 2008, ReqID WAF3_PB_57  
                            If WhizGlobal.TagID = CommonFunction.Constants.TAG_DEFAULT_PAGE_FILTERS Or WhizGlobal.TagID = CommonFunction.Constants.TAG_QUERY_STRING_PARAMETERS Then
                                'End Of Commented And Added by Chakshuta H on 29th-Oct-2015
                                Dim sbScript As New System.Text.StringBuilder
                                sbScript.Append("<Script language=javascript>")
                                'Commented And Added by Chakshuta H on 29th-Oct-2015
                                ''sbScript.Append("window.opener.document.forms['frmSample'].action = window.opener.location.href;")
                                ''sbScript.Append("window.opener.document.forms['frmSample'].submit();")
                                sbScript.Append("try { ") 'Added by Vinay on 11 DEC. 2008 WAF3_GEN_18
                                sbScript.Append("window")
                                If WhizGlobal.TagID = CommonFunction.Constants.TAG_QUERY_STRING_PARAMETERS Then sbScript.Append(".parent")
                                sbScript.Append(".opener.document.forms['frmSample'].action = window")
                                If WhizGlobal.TagID = CommonFunction.Constants.TAG_QUERY_STRING_PARAMETERS Then sbScript.Append(".parent")
                                sbScript.Append(".opener.location.href;")
                                sbScript.Append("window")
                                If WhizGlobal.TagID = CommonFunction.Constants.TAG_QUERY_STRING_PARAMETERS Then sbScript.Append(".parent")
                                sbScript.Append(".opener.document.forms['frmSample'].submit();")
                                'End Modification By NinadP on 22 Jan 2008, ReqID WAF3_PB_57  
                                sbScript.Append(" } catch(e) { } ") 'Added by Vinay on 11 DEC. 2008 WAF3_GEN_18
                                'End Of Commented And Added by Chakshuta H on 29th-Oct-2015
                                sbScript.Append("</Script>")
                                HttpContext.Current.Response.Write(sbScript.ToString)
                                sbScript = Nothing
                            End If
                        Case CommonFunction.Constants.TAG_TAB_OPTION_BUTTONS, CommonFunction.Constants.TAG_TAB_COMPARISON_VALIDATIONS
                            'For Sub Tag Options buttons, Grid Formatting rules, Comparison Rules ...after deleting the record update the hash table
                            Call CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("ParentTag")), Long))
                        Case CommonFunction.Constants.TAG_TAB_GRID_FORMATTING_RULES
                            'Refresh hastable for Sub Tag Grid Formatting rules
                            Dim lngTagID As Long = CType(CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_Sel_v_tbl_UI_SubTagMaster_GetTagID " + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("TagID")), CommonEngines.HashTables.CreateHashTables.UseSQL)), Long)
                            Call CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(lngTagID)
                        Case 1853 'TAB_CONTROLS - For Tab and Sub Tag
                            'WAF3_PB_44 Added By UmeshJ 14 May 2007
                            If UCase(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("Is_SubTag"), "")) = "0" Then
                                Call CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("TagID")), Long))
                            Else
                                Dim lngTagID As Long = CType(CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_Sel_v_tbl_UI_SubTagMaster_GetTagID " + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("TagID")), CommonEngines.HashTables.CreateHashTables.UseSQL)), Long)
                                Call CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(lngTagID)
                            End If
                            'WAF3_PB_44 Added By UmeshJ 14 May 2007
                            ' End Integration By NitinVS on 30 Jun 2007 for Whiz 2 SP8 
                        Case CommonFunction.Constants.TAG_ADVANCE_FILTERS
                            Dim strTagID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("TagID"))
                            If strTagID.Trim <> "" Then
                                'Clear filter from the session
                                HttpContext.Current.Session("AdvanceFilter" + strTagID) = ""
                            End If

                            'added by SachinR   on 02 Nov 2004
                            'to implement the hashtable for the deliverable field configuration
                            'here hashtable is refreshed for the deliverable type which is deleted to remove it from the hashtable
                        Case CommonFunction.Constants.APP_TAG_PRS_DELIVERABLE_TYPES
                            Dim lngDeliverableTypeID As Long = 0
                            Dim strIDList() As String
                            Dim strID As String

                            If DeletedIDList <> "" Then
                                strIDList = DeletedIDList.Split(","c)
                                For Each strID In strIDList
                                    If strID <> "" Then
                                        lngDeliverableTypeID = CType(strID, Long)
                                        CommonEngine.HashTables.Deliverable.RemoveHashTableDeliverableObject(lngDeliverableTypeID)
                                    End If
                                Next
                            End If
                            'addition end
                            'added by VidyaJ - IssueID 672 -whiz2.0 integration
                        Case CommonFunction.Constants.TAG_OPTION_BUTTONS, CommonFunction.Constants.TAG_GRID_FORMATTING_RULES, CommonFunction.Constants.TAG_COMPARISON_VALIDATIONS, CommonFunction.Constants.TAG_DEFAULT_PAGE_FILTERS
                            'For Master Tag Options buttons, Grid Formatting rules, Comparison Rules, Default Filters ...after deleting the record update the hash table
                            Call CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("TagID")), Long))
                            'End of addition by VidyaJ
                        Case CommonFunction.Constants.APP_TAG_MODULES
                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), "") = "SAVE" Then
                                'Added by VijayD on 21 August 2009 Purpose: to refersh gantt chart page 
                                AfterDelete = "if(window.opener!=null) {" + vbCrLf
                                AfterDelete += "var strParentPage; strParentPage = new String();" + vbCrLf
                                AfterDelete += "strParentPage = opener.location.href;" + vbCrLf
                                AfterDelete += "if (strParentPage.toUpperCase().indexOf('WBS_GANTTCHARTVIEW.ASPX') != -1){" + vbCrLf
                                AfterDelete += "opener.location.href = '../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + CommonFunction.Constants.APP_TAG_MODULES.ToString + "';" + vbCrLf
                                AfterDelete += "}" + vbCrLf
                                AfterDelete += "if (strParentPage.toUpperCase().indexOf('HOME_OUTLOOKVIEW.ASPX') != -1){" + vbCrLf
                                AfterDelete += "opener.location.href = '../Home/Home_OutlookView.aspx?List=12';" + vbCrLf
                                AfterDelete += "}}" + vbCrLf
                                strActionCode = ReturnCodes.ON_LOAD.ToString
                                'End Addition By Vijay On 21 August 2009
                            End If
                    End Select
                Else
                    'Added By Chakshuta H on 29th-Oct-2015
                    '--------------------------------------------------------------------------------------------------------------------------------------------------
                    'Added By Shrikant B On 20 Nov 2008 For WAF3_GEN_18 - R2L Language Support
                    '---------------------------------------------------------------------------------------------------------------------------------------------------
                    Dim strsession As String = ""
                    Dim intLength As Integer
                    Dim Key As String = ""
                    Dim lngTagID As Long
                    Dim strSQL As String = ""
                    strsession = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("WAF_REFRESHCULTURE")) 'Modified By ninad on 13 July 2009 IssueID - 31733 
                    Dim arrSession() As String = strsession.Split(CChar(","))
                    Dim iCount As Integer = arrSession.Length - 1
                    HttpContext.Current.Session("WAF_REFRESHCULTURE") = Nothing
                    'Ended By Chakshuta H on 29th-Oct-2015

                    'For DETAILS Tags
                    Select Case WhizGlobal.TagID
                        'Added By Chakshuta H on 29th-Oct-2015
                        Case CommonFunctions.Constants.CULTURE_CONTROL_TAGMASTER
                            For intLength = 0 To iCount - 1
                                Key = arrSession(0) + arrSession(iCount - intLength)
                                CommonEngines.HashTables.GetHashTableObject.RemoveUIControlTagMasterCLHashTable(Key)
                                CommonEngines.HashTables.GetHashTableObject.RemoveUIControlTagMasterCPHashTable(Key)
                            Next
                        Case CommonFunctions.Constants.CULTURE_TAGMASTER
                            For intLength = 0 To iCount - 1
                                Key = arrSession(0) + arrSession(iCount - intLength)
                                CommonEngines.HashTables.GetHashTableObject.RemoveUITagMasterHashTable(CLng(Key)) 'Modified By Ninad to change data type of key 
                            Next
                        Case CommonFunctions.Constants.CULTURE_CONTROL_SUBTAG_MASTER
                            For intLength = 0 To iCount - 1
                                Key = arrSession(0) + arrSession(iCount - intLength)
                                CommonEngines.HashTables.GetSubTagHashTableObjects.RemoveUISubTagControlMasterCLHashTable(Key)
                                CommonEngines.HashTables.GetSubTagHashTableObjects.RemoveUISubTagControlMasterCPHashTable(Key)
                            Next
                        Case CommonFunctions.Constants.CULTURE_SUBTAG_MASTER
                            For intLength = 0 To iCount - 1
                                Key = arrSession(0) + arrSession(iCount - intLength)
                                CommonEngines.HashTables.GetSubTagHashTableObjects.RemoveSubUITagMasterHashTable(Key)
                            Next
                        Case CommonFunctions.Constants.CULTURE_DYNAMICLINKS
                            For intLength = 0 To iCount - 1
                                Key = arrSession(0) + arrSession(iCount - intLength)
                                CommonEngines.HashTables.GetHashTableObject.RemoveDynamicLinksCultureCLHashTable(Key)
                                CommonEngines.HashTables.GetHashTableObject.RemoveDynamicLinksCultureCPHashTable(Key)
                                CommonEngines.HashTables.CreateHashTables.CreateUITagMasterCultureHashTable(arrSession(iCount - intLength), CLng(arrSession(0)))
                            Next
                        Case CommonFunctions.Constants.CULTURE_SUBTAG_DYNAMICLINKS
                            For intLength = 0 To iCount - 1
                                Key = arrSession(0) + arrSession(iCount - intLength)
                                CommonEngines.HashTables.GetSubTagHashTableObjects.RemoveSubTagDynamicLinksCultureCLHashTable(Key)
                                CommonEngines.HashTables.GetSubTagHashTableObjects.RemoveSubTagDynamicLinksCultureCPHashTable(Key)
                                CommonEngines.HashTables.CreateSubTagHashTables.CreateUISubTagMasterCultureHashTable(arrSession(iCount - intLength), CLng(arrSession(0)))
                            Next
                        Case CommonFunctions.Constants.CULTURE_VALIDATIONS
                            For intLength = 0 To iCount - 1
                                Key = arrSession(0) + arrSession(iCount - intLength)
                                CommonEngines.HashTables.GetHashTableObject.RemoveValidationRulesCultureHashTable(Key)
                            Next

                        Case CommonFunctions.Constants.CULTURE_CONTROL_COMPARISON
                            For iCount = 0 To intLength
                                Key = arrSession(0) + "-" + arrSession(iCount - intLength) + "-0"
                                CommonEngines.HashTables.GetHashTableObject.RemoveControlCompareasonValidationsCultureHashTable(Key)
                            Next

                        Case CommonFunctions.Constants.CULTURE_SUBTAG_CONTROL_COMPARISON
                            For iCount = 0 To intLength
                                Key = arrSession(0) + "-" + arrSession(iCount - intLength) + "-1"
                                CommonEngines.HashTables.GetSubTagHashTableObjects.RemoveSubTagControlCompareasonValidationsCultureHashTable(Key)
                            Next

                        Case CommonFunctions.Constants.CULTURE_OPTIONBUTTON
                            For intLength = 0 To iCount - 1
                                Key = arrSession(0) + "-" + arrSession(iCount - intLength) + "-0"
                                CommonEngines.HashTables.GetHashTableObject.RemoveOptionButtonCultureHashTable(Key)
                                strSQL = "usp_Sel_PB_TagIDFromControlTagID  " + arrSession(0)
                                lngTagID = CLng(CommonFunctions.Data.GetDataScalar(strSQL, True))
                                CommonEngines.HashTables.CreateHashTables.CreateUITagMasterCultureHashTable(arrSession(iCount - intLength), lngTagID)
                            Next

                        Case CommonFunctions.Constants.CULTURE_SUBTAG_OPTIONBUTTON
                            Dim lngSubTagID As Long
                            For intLength = 0 To iCount - 1
                                Key = arrSession(0) + "-" + arrSession(iCount - intLength) + "-1"
                                CommonEngines.HashTables.GetSubTagHashTableObjects.RemoveSubTagOptionButtonCultureHashTable(Key)
                                strSQL = "usp_Sel_PB_SubTagIDFromSubControlTagID  " + arrSession(0)
                                lngSubTagID = CLng(CommonFunctions.Data.GetDataScalar(strSQL, True))
                                strSQL = ""
                                strSQL = "usp_Sel_PB_GetTagIDFromSubTagID " + lngSubTagID.ToString
                                lngTagID = CLng(CommonFunctions.Data.GetDataScalar(strSQL, True))
                                CommonEngines.HashTables.CreateSubTagHashTables.CreateUISubTagMasterCultureHashTable(arrSession(iCount - intLength), lngTagID)
                            Next
                        Case CommonFunctions.Constants.CULTURE_MODULE
                            For intLength = 0 To iCount - 1
                                Key = arrSession(0) + arrSession(iCount - intLength)
                                CommonEngines.HashTables.GetHashTableObject.RemoveSystemModuleHashTableCulture(Key)
                                CommonEngines.HashTables.CreateHashTables.CreateSystemModuleHashTableCulture(arrSession(iCount - intLength))
                            Next

                        Case CommonFunctions.Constants.CULTURE_TAB_CONTROL
                            For intLength = 0 To iCount - 1
                                Key = arrSession(0) + "-0-" + arrSession(iCount - intLength)
                                CommonEngines.HashTables.GetHashTableObject.RemoveTabControlsHashTable(Key)
                                CommonEngines.HashTables.CreateHashTables.CreateUITagMasterCultureHashTable(arrSession(iCount - intLength), CLng(arrSession(0)))
                            Next
                        Case CommonFunctions.Constants.CULTURE_TAB_SUBTAG_CONTROL
                            For intLength = 0 To iCount - 1
                                Key = arrSession(0) + "-1-" + arrSession(iCount - intLength)
                                CommonEngines.HashTables.GetSubTagHashTableObjects.RemoveSubTagTabControlsHashTable(Key)
                                strSQL = "usp_Sel_PB_GetTagIDFromSubTagID " + arrSession(0)
                                lngTagID = CLng(CommonFunctions.Data.GetDataScalar(strSQL, True))
                                CommonEngines.HashTables.CreateSubTagHashTables.CreateUISubTagMasterCultureHashTable(arrSession(iCount - intLength), lngTagID)
                            Next

                            '--------------------------------------------------------------------------------------------------------------------------------------------------
                            'Addition End By Shrikant B On 20 Nov 2008 For WAF3_GEN_18 - R2L Language Support
                            '---------------------------------------------------------------------------------------------------------------------------------------------------
                            'Ended By Chakshuta H on 29th-Oct-2015

                        Case CommonFunction.Constants.APP_TAG_TAB_PROCESS_ROLES
                            'Update the Status flag of tbl_PRS_Process_Draft table to "D"
                            Dim strProcessID As String = strMasterPrimaryKey
                            strSQL = "usp_Upd_UpdateProcessDraftStatus " + strProcessID
                            CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        Case CommonFunction.Constants.APP_TAG_TAB_PROCESS_ACTIVITIES
                            'Update the Status flag of tbl_PRS_Process_Draft table to "D"
                            Dim strProcessID As String = strMasterPrimaryKey
                            strSQL = "usp_Upd_UpdateProcessDraftStatus " + strProcessID
                            CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        Case CommonFunction.Constants.APP_TAG_TAB_RESOURCEREQUEST_SKILLS, CommonFunction.Constants.APP_TAG_TAB_RESOURCEEXTENDREQUEST_SKILLS
                            'Update the configured Days for that request

                            strSQL = "usp_Upd_tbl_PM_ResourceRequest_ConfiguredDays " + strMasterPrimaryKey
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            'Start Added by SatyanarayanaA
                        Case CommonFunction.Constants.APP_TAG_TAB_REVIEW_REVIEWER, CommonFunction.Constants.APP_TAG_TAB_REVIEW_AUTHOR

                            Dim strHTML As String
                            Dim strWork As String
                            Dim strStartDate As String
                            Dim strEndDate As String
                            Dim objDr As Data.IDataReader
                            strWork = "0"
                            strStartDate = ""
                            strEndDate = ""

                            strSQL = "usp_sel_WPBN_GetReviewTestingRefreshPlan " + strMasterPrimaryKey
                            objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            If objDr.Read Then
                                strWork = CommonFunction.Data.CheckIsDBNull(objDr("TotalWork"), "0").ToString + ""
                                '/*strStartDate = CommonFunction.Data.CheckIsDBNull(objDr("StartDate"), "").ToString + ""
                                'If strStartDate <> "" Then strStartDate = CommonFunction.Dates.GetDate(CType(strStartDate, Date))
                                'strEndDate = CommonFunction.Data.CheckIsDBNull(objDr("EndDate"), "").ToString + ""
                                'If strEndDate <> "" Then strEndDate = CommonFunction.Dates.GetDate(CType(strEndDate, Date))*/
                            End If
                            CommonFunction.Data.DisposeDataReader(objDr)

                            strHTML = vbCrLf + "<Script language=javascript>" + vbCrLf
                            strHTML += "txtReviewWork=GetObjectReference('frmCommonPage','ReviewEffort');" + vbCrLf
                            '/*strHTML += "txtStartDate=GetObjectReference('frmCommonPage','ReviewedDate');" + vbCrLf
                            'strHTML += "txtEndDate=GetObjectReference('frmCommonPage','WPBN_EndDate');" + vbCrLf*/
                            strHTML += "if(txtReviewWork != null){ txtReviewWork.value='" + strWork.Trim + "'; }" + vbCrLf
                            '/*strHTML += "if(txtStartDate != null){ txtStartDate.value='" + strStartDate.Trim + "'; }" + vbCrLf
                            'strHTML += "if(txtEndDate != null){ txtEndDate.value='" + strEndDate.Trim + "'; }" + vbCrLf*/
                            strHTML += "</Script>" + vbCrLf
                            CommonFunction.General.WriteHTML(strHTML)

                            'Ended 

                    End Select
                End If

            End Function
            Public Function NavigateToSmsUrl(ByVal strMessage As String, ByVal strNumbers As String, ByVal strUser As String, ByVal strpw As String, ByVal strSender As String) As String
                ''=====================================================================
                '' Procedure  Name		:	NavigateToSmsUrl
                '' Parameters Passed	:	
                '' Returns				:	
                '' Parameters Affected	:	None
                '' Purpose				:	To Send SMS Using Navigation.
                '' Description			:	
                '' Assumptions			:	None
                '' Dependencies			:	None
                '' Author				:	SwatiC
                '' Created				:	Aug 25, 2008
                '' Revisions			:	
                ''=====================================================================

                '  Dim LogWriter As New System.IO.StreamWriter("..\SMSLogs\log.txt", True)
                Dim request As System.Net.HttpWebRequest
                Dim response As Net.HttpWebResponse = Nothing
                Dim strStatus As String = " "
                Dim proxy As System.Net.IWebProxy
                Dim strProxyUser As String
                Dim strProxyPassword As String
                Dim strDomain As String
                Dim strProxyURL As String


                ' strUser = CommonFunctions.General.GetApplicationKeySetting("FastAlertUser")

                Dim strUrl As String
                'strUrl = "http://api.fastalerts.in/fastclient/SMSclient.php?username=" + strUser + "&password=" + strpw + "&message=" + strMessage + "&numbers=" + strNumbers + "&senderid=" + strSender
                strUrl = CommonFunctions.General.GetApplicationKeySetting("NavigationURL")
                strUrl = strUrl.Replace("|USER_NAME|", strUser + "&")
                strUrl = strUrl.Replace("|PASSWORD|", strpw + "&")
                strUrl = strUrl.Replace("|MESSAGE|", strMessage + "&")
                strUrl = strUrl.Replace("|NUMBERS|", strNumbers + "&")
                strUrl = strUrl.Replace("|SENDER|", strSender)

                Try
                    ' Create the web request   
                    request = DirectCast(System.Net.HttpWebRequest.Create(strUrl), Net.HttpWebRequest)

                    strProxyURL = CommonFunctions.General.GetApplicationKeySetting("ProxyURL")
                    strProxyUser = CommonFunctions.General.GetApplicationKeySetting("ProxyUserName")
                    strProxyPassword = CommonFunctions.General.GetApplicationKeySetting("ProxyPassword")
                    strDomain = CommonFunctions.General.GetApplicationKeySetting("ProxyDomain")

                    If strProxyURL <> "" And Not (strProxyURL Is Nothing) Then
                        proxy = New WebProxy(strProxyURL, True)
                    Else
                        proxy = Net.WebRequest.DefaultWebProxy
                    End If

                    If strProxyUser <> "" And Not (strProxyUser Is Nothing) Then
                        proxy.Credentials = New NetworkCredential(strProxyUser, strProxyPassword, strDomain)
                    Else
                        proxy.Credentials = System.Net.CredentialCache.DefaultCredentials
                    End If

                    request.Proxy = proxy

                    ' Get response   
                    response = DirectCast(request.GetResponse(), Net.HttpWebResponse)


                Catch ex As Exception
                    ' LogWriter.WriteLine("Date " + Now.ToString() + " Log Message : " + ex.Message)
                    '''Finally
                    '''If Not response Is Nothing Then
                    '''    Dim strStream As System.IO.Stream
                    '''    strStream = response.GetResponseStream

                    '''    Dim strRedaer As New StreamReader(strStream)

                    '''    strStatus = strRedaer.ReadLine()

                    '''    While Not strStatus Is Nothing
                    '''        strStatus = strRedaer.ReadLine()
                    '''        If strStatus.Contains("Response Code") Then
                    '''            Exit While
                    '''        End If
                    '''    End While
                    '''    If strStatus.Contains("402,") Then
                    '''        'strStatus = strStatus.Substring(0, strStatus.IndexOf("402,"))
                    '''        strStatus = (strStatus.Replace(strStatus.Substring(0, strStatus.IndexOf("Response Code :") + Len("Response Code :")), "")).Substring(0, (strStatus.Replace(strStatus.Substring(0, strStatus.IndexOf("Response Code :") + Len("Response Code :")), "")).IndexOf("</font>"))
                    '''    Else
                    '''        strStatus = "402,0"
                    '''    End If

                    '''    response.Close()
                    '''End If

                End Try
                Return strStatus
            End Function

            Private Function FormatValue(ByVal strValue As String, ByVal DataType As String) As String
                '=====================================================================
                ' Procedure Name        : FormatValue
                ' Purpose               : Formats and returns the value depending upon
                '                           its control type 
                ' Description           : Same as above
                ' Parameters Passed     : Value , DataType
                ' Parameters Affected   : None.
                ' Returns               : Formated Value
                ' Assumptions           : None.
                ' Dependencies          : None.
                ' Author                : UmeshJ
                ' Created               : November 07, 2003 
                ' Revisions             :
                '=====================================================================
                Select Case DataType.ToUpper
                    Case "BIT"
                        If strValue.Trim.ToUpper = "TRUE" Then
                            strValue = "'1'"
                        ElseIf strValue.Trim.ToUpper = "FALSE" Then
                            strValue = "'0'"
                        Else
                            strValue = "null"
                        End If
                    Case "MONEY"
                        strValue = "CAST('" + strValue + "' AS Money)"
                    Case Else
                        If strValue.Trim = "" Then Return "null"
                        strValue = "'" + CommonFunction.General.BuildQueryString(strValue) + "'"
                End Select
                Return strValue
            End Function


#Region "PRIVATE PROCEDURES"

#Region "Project Information"

            Sub AssignProject(ByVal intProjectID As Long)

                Dim drEmployee As IDataReader
                Dim intRoleID As Long
                Dim drRole As IDataReader
                Dim blnAssignToProjectByDefault As Boolean
                Dim intRoleLevel As Integer = 0     'Added by ShamkantD on 1 Dec 2004

                blnAssignToProjectByDefault = False

                ' If the current login user is the employee of the company, then...
                If HttpContext.Current.Session("LoginType").ToString = "E" Then

                    ' Get the role of the current login employee.
                    drEmployee = CommonFunction.Data.GetDataReader("usp_tbl_Sel_EmployeeInfo " + HttpContext.Current.Session("intUserID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    If drEmployee.Read Then
                        intRoleID = CType(drEmployee("PostID"), Long)
                    Else
                        intRoleID = CType(HttpContext.Current.Session("intPostID"), Long)
                    End If
                    'Dispose the reader
                    Call CommonFunction.Data.DisposeDataReader(drEmployee)

                    ' Check if the resources of the role must be assigned to the project by default...
                    drRole = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_Role " + intRoleID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    If drRole.Read Then
                        'Modified by ShamkantD on 1 Dec 2004
                        'If the resource is low level resource, add the resource to the project
                        intRoleLevel = CType(CommonFunction.Data.CheckIsDBNull(drRole("Level"), "0"), Integer)
                        If intRoleLevel = 3 Then
                            blnAssignToProjectByDefault = True
                        Else
                            blnAssignToProjectByDefault = CType(CommonFunction.Data.CheckIsDBNull(drRole("AssignToProjectByDefault"), "False"), Boolean)
                        End If
                        'End of modification - ShamkantD on 1 Dec 2004
                    End If
                    'Dispose the reader
                    Call CommonFunction.Data.DisposeDataReader(drRole)
                End If

                'Added by ShamkantD on 1 Dec 2004 
                'If the user is middle level access user, add an entry in tbl_PM_ProjectAccess table
                If intRoleLevel = 2 Then
                    CommonFunction.Data.InsertOrUpdateData("EXEC usp_PM_ProjectAccess " + HttpContext.Current.Session("intUserID").ToString & "," & intProjectID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                End If
                'End of addition - ShamkantD on 1 Dec 2004

                ' If the resource does not have to be assigned to the project, then exit the subroutine.
                If blnAssignToProjectByDefault = False Then
                    Exit Sub
                End If
                ' End Addition.

                Dim strSQL As String = "EXEC usp_Ins_tbl_PM_ProjectEmployeeRole " + intProjectID.ToString + "," & HttpContext.Current.Session("intPostID").ToString & "," & HttpContext.Current.Session("intUserID").ToString
                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            End Sub
#End Region

#Region "Login Maintenance"

            Private Function SaveCustomerCreatedLoginInformation(ByVal ControlsHashTable As Hashtable, Optional ByRef LoginID As String = "") As String
                SaveCustomerCreatedLoginInformation = ""
                'Commented And Added by Chakshuta H on 29th-Oct-2015
                ''Dim strLoginName As String = CommonFunction.General.CheckIsNothing(ControlsHashTable("LoginName")).Trim
                ''Dim strPassword As String = CommonFunction.General.CheckIsNothing(ControlsHashTable("Password")).Trim
                Dim strLoginName As String = FixString(CommonFunction.General.CheckIsNothing(ControlsHashTable("LoginName")).Trim, 30, False, True) 'Modified By Ninad on 24 Aug 2009 IssueID-32698 
                Dim strPassword As String = CommonFunction.General.CheckIsNothing(ControlsHashTable("Password")) 'Modified By Ninad on 24 Aug 2009 IssueID-32698 
                'End Of Commented And Added by Chakshuta H on 29th-Oct-2015

                ''Added By Vaijat K ON 24/02/2017 For password encryption
                Dim strCount As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("NonDatabase3"))
                Dim strencryptedkey As String = ""
                Dim strencryptedlength As String = ""
                Dim struniqueid As String = ""
                Dim IsValid As Boolean = False


                'Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
                struniqueid = XMLHttp.m_LoginHashTable.Item(strLoginName)
                'End of Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
                ''Added By Vaijat K ON 24/02/2017 For password encryption
                strencryptedkey = strPassword.Substring(1, strCount)

                Dim strpwd1 As String() = strPassword.Split("|")
                strPassword = ""
                For i As Integer = 0 To strpwd1.Length - 2
                    strPassword &= strpwd1(i).Substring(0, 1)
                Next
                strPassword = StrReverse(strPassword)
                ''End Added By Vaijat K ON 24/02/2017 For password encryption
                strPassword = FixString(strPassword.Trim, 30, False, True)

                Dim strEncryPass As String = ""
                Dim strSQLQuery As String
                Dim objEncrypt As New Authentication.PWEncryption(CommonFunction.General.UnBuildQueryString(strLoginName), CommonFunction.General.UnBuildQueryString(strPassword))
                strEncryPass = objEncrypt.Encrypt()
                objEncrypt = Nothing
                If LoginID.Trim = "" Then
                    'INSERT mode
                    Dim lngUserId As Long = CType(HttpContext.Current.Session("intUserID"), Long)
                    strSQLQuery = "Exec usp_Ins_tbl_PM_Login 'C','" + lngUserId.ToString + "',null," + CommonFunction.Constants.ROLE_CUSTOMER.ToString + ",1,'" + strLoginName + "','" + CommonFunction.General.BuildQueryString(strEncryPass) + "'"
                    Dim drInsert As IDataReader = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    If drInsert.Read Then
                        If drInsert("Exceeded").ToString = "1" And drInsert("Success").ToString = "1" And HttpContext.Current.Session("LoginType").ToString.ToUpper <> "C" Then
                            'Oooooooooops u have exceeded the LIMIT...[Remaining -get message from resource]
                            'Commented And Added by Chakshuta H on 29th-Oct-2015
                            '' SaveCustomerCreatedLoginInformation = "alert(""" + Replace(CommonFunctions.General.CheckIsNothing(m_objTemplate.GetResourceString("EMP_LOGIN_LIC_EXCEED")), "<LIC_NO>", drInsert("Users").ToString) + """)" + vbCrLf

                            'Modified - By PushkarK ON 23-May-2008 For WAF_DISABLE_USERLICENCING
                            'Get the framework Setting to bypass check for the no. of user licences.
                            'If the key is not present/ has value = 'N', then do not bypass. 
                            Dim blnDisableUserLicencing As Boolean = False
                            blnDisableUserLicencing = CommonFunctions.General.GetFrameworkSettings("WAF_DISABLE_USERLICENCING", "Y")
                            If blnDisableUserLicencing = False Then
                                SaveCustomerCreatedLoginInformation = "alert(""" + Microsoft.VisualBasic.Strings.Replace(CommonFunctions.General.CheckIsNothing(m_objTemplate.GetResourceString("EMP_LOGIN_LIC_EXCEED")), "<LIC_NO>", drInsert("Users").ToString) + """)" + vbCrLf
                            End If
                            'Modification Ends - By PushkarK ON 23-May-2008 For WAF_DISABLE_USERLICENCING
                            'End Of Commented And Added by Chakshuta H on 29th-Oct-2015
                            LoginID = drInsert("LoginID").ToString
                        End If
                    End If

                    'dispose
                    CommonFunction.Data.DisposeDataReader(drInsert)
                Else
                    'UPDATE mode
                    Dim lngLoginId As Long = CType(LoginID, Long)
                    'Commented and Added By NikitaD on 18-Jan-2016 for client Password  Update crash Issue
                    'strSQLQuery = "Exec usp_Upd_tbl_PM_Login_Password " + LoginID.ToString + ",'" + CommonFunction.General.BuildQueryString(strEncryPass) + "'"
                    strSQLQuery = "Exec usp_Upd_tbl_PM_Login_Password " + LoginID.ToString + ",'" + CommonFunction.General.BuildQueryString(strEncryPass) + "','" + CommonFunction.General.BuildQueryString(CType(HttpContext.Current.Session("strUserName"), String)) + "'"                   'End Commented and Added By NikitaD on 18-Jan-2016 for client Password  Update crash Issue
                    'end Commented and Added By NikitaD on 18-Jan-2016 for client Password  Update crash Issue
                    CommonFunction.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                End If
            End Function

            Private Function SaveCustomerLoginInformation(ByVal ControlsHashTable As Hashtable, Optional ByVal LoginID As String = "") As String
                SaveCustomerLoginInformation = ""
                'Commented And Added by Chakshuta H on 29th-Oct-2015
                ''Dim strLoginName As String = CommonFunction.General.CheckIsNothing(ControlsHashTable("LoginName")).Trim
                ''Dim strPassword As String = CommonFunction.General.CheckIsNothing(ControlsHashTable("Password")).Trim
                Dim strLoginName As String = FixString(CommonFunction.General.CheckIsNothing(ControlsHashTable("LoginName")).Trim, 30, False, True) 'Modified By Ninad on 24 Aug 2009 IssueID-32698 
                Dim strPassword As String = CommonFunction.General.CheckIsNothing(ControlsHashTable("Password")) 'Modified By Ninad on 24 Aug 2009 IssueID-32698 
                'End Of Commented And Added by Chakshuta H on 29th-Oct-2015

                ''Added By Vaijat K ON 24/02/2017 For password encryption
                Dim strCount As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("NonDatabase3"))
                Dim strencryptedkey As String = ""
                Dim strencryptedlength As String = ""
                Dim struniqueid As String = ""
                Dim IsValid As Boolean = False


                'Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
                struniqueid = XMLHttp.m_LoginHashTable.Item(strLoginName)
                'End of Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
                ''Added By Vaijat K ON 24/02/2017 For password encryption
                strencryptedkey = strPassword.Substring(1, strCount)
                'Dim SM As New StreamWriter(HttpContext.Current.Server.MapPath("") & "/SaveEmployeeLoginInformation.txt")
                'SM.WriteLine("strPassword Before decryption : " & strPassword)
                Dim strpwd1 As String() = strPassword.Split("|")
                strPassword = ""
                For i As Integer = 0 To strpwd1.Length - 2
                    strPassword &= strpwd1(i).Substring(0, 1)
                Next
                strPassword = StrReverse(strPassword)
                ''End Added By Vaijat K ON 24/02/2017 For password encryption
                strPassword = FixString(strPassword.Trim, 30, False, True)

                'SM.WriteLine("strPassword AFter decryption: " & strPassword)
                'SM.Close()

                Dim strEncryPass As String = ""
                Dim strSQLQuery As String
                'Code added by SajiU on 19th Dec 2006
                Dim strSQL As String
                Dim objDr As IDataReader
                If strLoginName = "" Then
                    strSQL = ""
                    strSQL = "usp_Sel_tbl_PM_Login "
                    strSQL += LoginID.ToString
                    objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    While objDr.Read
                        strLoginName = CommonFunction.Data.CheckIsDBNull(objDr("loginName"), "").ToString
                    End While
                    CommonFunction.Data.DisposeDataReader(objDr)
                End If
                'End of Addition by SajiU on 19th Dec 2006
                '--- modified by purvaj on 30 Jun 2009 8.1 issue fixes
                '--- if password contains single quote, wrong password gets encrypted.Multiple single quotes get appended for a single single quote.
                '--- "Replace(" added in the following statement
                Dim objEncrypt As New Authentication.PWEncryption(Replace(CommonFunction.General.UnBuildQueryString(strLoginName), "''", "'"), Replace(CommonFunction.General.UnBuildQueryString(strPassword), "''", "'"))
                strEncryPass = objEncrypt.Encrypt()
                objEncrypt = Nothing
                If LoginID.Trim = "" Then
                    'INSERT mode
                    Dim lngUserId As Long = CType(CommonFunction.General.CheckIsNothing(ControlsHashTable("CustomerID"), "0"), Long)
                    strSQLQuery = "Exec usp_Ins_tbl_PM_Login 'C','" + lngUserId.ToString + "',null," + CommonFunction.Constants.ROLE_CUSTOMER.ToString + ",0,'" + strLoginName + "','" + CommonFunction.General.BuildQueryString(strEncryPass) + "'"
                    Dim drInsert As IDataReader = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    If drInsert.Read Then
                        If drInsert("Exceeded").ToString = "1" And drInsert("Success").ToString = "1" And HttpContext.Current.Session("LoginType").ToString.ToUpper <> "C" Then
                            'Oooooooooops u have exceeded the LIMIT
                            'Commented And Added by Chakshuta H on 29th-Oct-2015
                            ''SaveCustomerLoginInformation = "alert(""" + Replace(CommonFunctions.General.CheckIsNothing(m_objTemplate.GetResourceString("EMP_LOGIN_LIC_EXCEED")), "<LIC_NO>", drInsert("Users").ToString) + """)" + vbCrLf
                            'Modified - By PushkarK ON 23-May-2008 For WAF_DISABLE_USERLICENCING
                            'Get the framework Setting to bypass check for the no. of user licences.
                            'If the key is not present/ has value = 'N', then do not bypass. 
                            Dim blnDisableUserLicencing As Boolean = False
                            blnDisableUserLicencing = CommonFunctions.General.GetFrameworkSettings("WAF_DISABLE_USERLICENCING", "Y")
                            If blnDisableUserLicencing = False Then
                                SaveCustomerLoginInformation = "alert(""" + Microsoft.VisualBasic.Strings.Replace(CommonFunctions.General.CheckIsNothing(m_objTemplate.GetResourceString("EMP_LOGIN_LIC_EXCEED")), "<LIC_NO>", drInsert("Users").ToString) + """)" + vbCrLf
                            End If
                            'End Of Commented And Added by Chakshuta H on 29th-Oct-2015
                            'Modification Ends - By PushkarK ON 23-May-2008 For WAF_DISABLE_USERLICENCING

                        End If
                    End If
                    'dispose
                    CommonFunction.Data.DisposeDataReader(drInsert)
                    'Send Email for New Customer Login
                    SaveCustomerLoginInformation += SendEmailForNewLogin(lngUserId, strLoginName, strPassword, "C")
                Else
                    'UPDATE mode
                    Dim lngLoginId As Long = CType(LoginID, Long)
                    'Commented And Added By Chakshuta H on 24th-Nov-2015 Purpose::QA issue fixing
                    'strSQLQuery = "Exec usp_Upd_tbl_PM_Login_Password " + LoginID.ToString + ",'" + CommonFunction.General.BuildQueryString(strEncryPass) + "'"
                    strSQLQuery = "Exec usp_Upd_tbl_PM_Login_Password " + LoginID.ToString + ",'" + CommonFunction.General.BuildQueryString(strEncryPass) + "',N'" + CommonFunction.General.BuildQueryString(CType(HttpContext.Current.Session("strUserName"), String)) + "'" 'Modified By Ninad on 15 May 2008, Issue ID-  20310
                    'End Of Commented And Added By Chakshuta H on 24th-Nov-2015 Purpose::QA issue fixing
                    CommonFunction.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                End If
            End Function

            Private Function SaveEmployeeLoginInformation(ByVal ControlsHashTable As Hashtable, Optional ByVal LoginID As String = "") As String
                SaveEmployeeLoginInformation = ""
                Dim strLoginName As String = CommonFunction.General.CheckIsNothing(ControlsHashTable("LoginName")).Trim
                Dim strPassword As String = CommonFunction.General.CheckIsNothing(ControlsHashTable("Password")).Trim
                ''Added By Vaijat K ON 24/02/2017 For password encryption
                Dim strCount As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("NonDatabase3"))
                Dim strencryptedkey As String = ""
                Dim strencryptedlength As String = ""
                Dim struniqueid As String = ""
                Dim IsValid As Boolean = False


                'Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
                struniqueid = XMLHttp.m_LoginHashTable.Item(strLoginName)
                'End of Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
                ''Added By Vaijat K ON 24/02/2017 For password encryption
                strencryptedkey = strPassword.Substring(1, strCount)
                'Dim SM As New StreamWriter(HttpContext.Current.Server.MapPath("") & "/SaveEmployeeLoginInformation.txt")
                'SM.WriteLine("strPassword Before decryption : " & strPassword)

                Dim strpwd1 As String() = strPassword.Split("|")
                strPassword = ""
                For i As Integer = 0 To strpwd1.Length - 2
                    strPassword &= strpwd1(i).Substring(0, 1)
                Next
                strPassword = StrReverse(strPassword)
                ''End Added By Vaijat K ON 24/02/2017 For password encryption
                ''Added by Vaijat For Checking Log
                'SM.WriteLine("strPassword AFter decryption: " & strPassword)
                'SM.Close()
                ''End Added by Vaijat For Checking Log
                Dim strEncryPass As String = ""
                Dim strSQLQuery As String
                'Code added by SajiU on 4th Dec 2006
                Dim strSQL As String
                Dim objDr As IDataReader
                If strLoginName = "" Then
                    strSQL = ""
                    strSQL = "usp_Sel_tbl_PM_Login "
                    strSQL += LoginID.ToString
                    objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    While objDr.Read
                        strLoginName = CommonFunction.Data.CheckIsDBNull(objDr("loginName"), "").ToString
                    End While
                    CommonFunction.Data.DisposeDataReader(objDr)
                End If
                'End of Addition by SajiU on 4th Dec 2006

                Dim objEncrypt As New Authentication.PWEncryption(CommonFunction.General.UnBuildQueryString(strLoginName), CommonFunction.General.UnBuildQueryString(strPassword))
                strEncryPass = objEncrypt.Encrypt()
                objEncrypt = Nothing
                If LoginID.Trim = "" Then
                    'INSERT mode
                    Dim lngUserId As Long = CType(CommonFunction.General.CheckIsNothing(ControlsHashTable("EmployeeID"), "0"), Long)
                    strSQLQuery = "Exec usp_Ins_tbl_PM_Login 'E',null,'" + lngUserId.ToString + "',null,0,'" + strLoginName + "','" + CommonFunction.General.BuildQueryString(strEncryPass) + "'"
                    Dim drInsert As IDataReader = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    If drInsert.Read Then
                        If drInsert("Exceeded").ToString = "1" And drInsert("Success").ToString = "1" Then
                            'Oooooooooops u have exceeded the LIMIT
                            'Commented And Added by Chakshuta H on 29th-Oct-2015
                            ''SaveEmployeeLoginInformation = "alert(""" + Replace(CommonFunctions.General.CheckIsNothing(m_objTemplate.GetResourceString("EMP_LOGIN_LIC_EXCEED")), "<LIC_NO>", drInsert("Users").ToString) + """)" + vbCrLf
                            'Modified - By PushkarK ON 23-May-2008 For WAF_DISABLE_USERLICENCING
                            'Get the framework Setting to bypass check for the no. of user licences.
                            'If the key is not present/ has value = 'N', then do not bypass. 
                            Dim blnDisableUserLicencing As Boolean = False
                            blnDisableUserLicencing = CommonFunctions.General.GetFrameworkSettings("WAF_DISABLE_USERLICENCING", "Y")
                            If blnDisableUserLicencing = False Then
                                SaveEmployeeLoginInformation = "alert(""" + Microsoft.VisualBasic.Strings.Replace(CommonFunctions.General.CheckIsNothing(m_objTemplate.GetResourceString("EMP_LOGIN_LIC_EXCEED")), "<LIC_NO>", drInsert("Users").ToString) + """)" + vbCrLf
                            End If
                            'Modification Ends - By PushkarK ON 23-May-2008 For WAF_DISABLE_USERLICENCING
                            'End Of Commented And Added by Chakshuta H on 29th-Oct-2015
                        End If
                    End If
                    'dispose
                    CommonFunction.Data.DisposeDataReader(drInsert)
                    'Send Email
                    SaveEmployeeLoginInformation += SendEmailForNewLogin(lngUserId, strLoginName, strPassword, "E")
                Else
                    'UPDATE mode
                    Dim lngLoginId As Long = CType(LoginID, Long)
                    'Commented And Added by Chakshuta H on 29th-Oct-2015
                    ''strSQLQuery = "Exec usp_Upd_tbl_PM_Login_Password " + LoginID.ToString + ",'" + CommonFunction.General.BuildQueryString(strEncryPass) + "'"
                    strSQLQuery = "Exec usp_Upd_tbl_PM_Login_Password " + LoginID.ToString + ",'" + CommonFunction.General.BuildQueryString(strEncryPass) + "',N'" + CommonFunction.General.BuildQueryString(CType(HttpContext.Current.Session("strUserName"), String)) + "'" 'Modified By Ninad on 15 May 2008, Issue ID-  20310
                    'End Of Commented And Added by Chakshuta H on 29th-Oct-2015

                    CommonFunction.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                End If
            End Function
            '--Code added by SajiU on 27 Nov 2006
            Private Function SaveEmployeeLoginInformationINDetail(ByVal ControlsHashTable As Hashtable, Optional ByVal EmployeeID As String = "") As String
                SaveEmployeeLoginInformationINDetail = ""
                Dim strLoginName As String = CommonFunction.General.CheckIsNothing(ControlsHashTable("LoginName")).Trim
                Dim strPassword As String = CommonFunction.General.CheckIsNothing(ControlsHashTable("Password")).Trim
                Dim strEncryPass As String = ""
                Dim strSQLQuery As String
                'Code added by SajiU on 12th Dec 2006
                Dim strSQL As String
                Dim objDr As IDataReader
                If strLoginName = "" Then
                    strSQL = ""
                    strSQL = "usp_Sel_tbl_PM_Login_Bulk "
                    strSQL += EmployeeID.ToString
                    objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    While objDr.Read
                        strLoginName = CommonFunction.Data.CheckIsDBNull(objDr("loginName"), "").ToString
                    End While
                    CommonFunction.Data.DisposeDataReader(objDr)
                End If
                'End of Addition by SajiU on 12th Dec 2006

                Dim objEncrypt As New Authentication.PWEncryption(CommonFunction.General.UnBuildQueryString(strLoginName), CommonFunction.General.UnBuildQueryString(strPassword))
                strEncryPass = objEncrypt.Encrypt()
                objEncrypt = Nothing

                'Modified By NitinVs on 11 apr 2007 for whizibleSEM SP 8 Regression Issue Fixes 
                ' for user Name added single quote before and after LoginName 

                'UPDATE mode
                strSQLQuery = "Exec usp_Upd_tbl_PM_Login_And_Password " + EmployeeID.ToString + ",'" + strLoginName.ToString + "','" + CommonFunction.General.BuildQueryString(strEncryPass) + "'"

                'End Modification By NitinVs on 11 apr 2007 for whizibleSEM SP 8 Regression Issue Fixes 


                CommonFunction.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            End Function
            '--End Of addition by SajiU on 27 Nov 2006
            '-------------------------------------------------------
            '--Code added by SajiU on 6th Dec 2006

            Private Function DeleteLogin(ByVal lngEmployeeID As Long) As Boolean
                DeleteLogin = True
                Dim strSQLQuery As String

                strSQLQuery = "Exec usp_Del_tbl_PM_Login_BulkLogin  " + lngEmployeeID.ToString
                CommonFunction.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))


            End Function

            '--End Of addition by SajiU on 6th Dec 2006
            '-------------------------------------------------------
            Private Function SendEmailForNewLogin(ByVal lngUserId As Long, ByVal strLoginName As String, ByVal strPassword As String, ByVal strUserType As String) As String
                Dim drEmail As IDataReader = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 12", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                Dim blnSendEmail As Boolean = False
                Dim blnShowPopup As Boolean = True
                ' Retrieve information about the mail message.
                If drEmail.Read Then
                    blnSendEmail = CType(drEmail("SendMail"), Boolean)
                    blnShowPopup = CType(drEmail("ShowPopup"), Boolean)
                End If
                'dispose
                CommonFunction.Data.DisposeDataReader(drEmail)

                If blnSendEmail = True Then
                    If blnShowPopup = False Then
                        Dim strFromEmailID As String
                        Dim strToEmailID As String
                        Dim strCCToEmailID As String
                        Dim strSubject As String
                        Dim strEmailMessage As String
                        Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_12(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, strUserType, lngUserId, strLoginName, strPassword)
                        Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                    Else
                        SendEmailForNewLogin = "window.open (" + Chr(34) + "../General/SendEmail.aspx?MessageID=12&UserType=" + strUserType + "&UserID=" + lngUserId.ToString + "&LoginName=" + strLoginName + "&Password=" + strPassword + Chr(34) + ",null,""resizable=yes,scrollbars=no,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=600,height=500"");" + vbCrLf
                    End If
                End If
            End Function
            'Added By Chakshuta H on 29th-Oct-2015
            Private Function UpdateIsFirstTimeLogin(Optional ByVal LoginID As String = "") As String
                '=====================================================================
                ' Function Name         : UpdateIsFirstTimeLogin
                ' Purpose               : Update The First Time Login 
                ' Description           : If Change Password On Reset Flag Is true Update First Time Login Flag To True
                ' Parameters Passed     : None
                ' Returns               : None
                ' Parameters Affected   : None
                ' Assumptions           : None
                ' Dependencies          : None
                ' Author                : ShrikantB
                ' Created               : 06-SEP-2010
                ' Revisions             :
                '=====================================================================
                Dim strSQLQuery As String
                Dim blnPwdOnReset As Boolean = False
                Dim drCompanyInfo As IDataReader
                'Get data reader Object    
                Try

                    If LoginID.Trim <> "" Then
                        drCompanyInfo = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        If drCompanyInfo.Read Then
                            blnPwdOnReset = CBool(drCompanyInfo("EnablePwdOnReset"))
                        End If
                        If drCompanyInfo.IsClosed = False Then
                            drCompanyInfo.Close()
                        End If

                        If blnPwdOnReset = True Then
                            strSQLQuery = "EXEC usp_Upd_ChangeIsloginforfirsttime_True " + LoginID.ToString
                            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        End If
                    End If
                Catch ex As Exception
                    Err.Raise(Err.Number, "CLCP_Events_cEventHandlers->UpdateIsFirstTimeLogin", ex.Message)
                Finally
                    If Not drCompanyInfo Is Nothing Then
                        drCompanyInfo.Dispose()
                    End If
                End Try


            End Function
            'Ended By Chakshuta H on 29th-Oct-2015

#End Region
            'Added By Chakshuta H on 29th-Oct-2015
#Region "SAAS"
            ' With Referance to: WAF3_GEN_3
            ' Added By SumitS: 12 May 2006
            Private Sub SaveSubTenantInformation(ByVal ControlsHashTable As Hashtable, Optional ByVal LoginID As String = "")
                Dim strLoginName As String = FixString(CommonFunction.General.CheckIsNothing(ControlsHashTable("LoginName")).Trim, 30, False, True) 'Modified By Ninad on 24 Aug 2009 IssueID-32698 
                Dim strPassword As String = FixString(CommonFunction.General.CheckIsNothing(ControlsHashTable("Password")).Trim, 30, False, True) 'Modified By Ninad on 24 Aug 2009 IssueID-32698 
                Dim strEncryPass As String = ""
                Dim strSQLQuery As String
                Dim objEncrypt As New Authentication.PWEncryption(strLoginName, strPassword)
                strEncryPass = objEncrypt.Encrypt()
                objEncrypt = Nothing
                If LoginID.Trim = "" Then
                    'INSERT mode
                    Dim strTenantID As String = CommonFunction.General.CheckIsNothing(ControlsHashTable("TenantID")).Trim()
                    Dim sSQL As String
                    ' if Administrator Login then it have Tenant Id so set strTenantid as TenantID
                    If strTenantID <> "" Then
                        strTenantID = "'" + strTenantID + "'"
                    End If
                    sSQL = "EXEC usp_ins_tbl_PM_Login_Tenant '" + strLoginName + "','" + strEncryPass + "'," + strTenantID + ", 0"
                    CommonFunction.Data.InsertOrUpdateData(sSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    sSQL = "EXEC usp_ins_tbl_PM_Login_SubTenantCreation  '" + strLoginName + "'," + strTenantID
                    CommonFunction.Data.InsertOrUpdateData(sSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                Else
                    Dim sSQL As String
                    sSQL = "EXEC usp_ins_tbl_PM_Login_Tenant '" + strLoginName + "','" + strEncryPass + "', '', 1"
                    CommonFunction.Data.InsertOrUpdateData(sSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                End If
            End Sub
            Private Sub SaveTenantInformation(ByVal ControlsHashTable As Hashtable, Optional ByVal LoginID As String = "")
                Dim strLoginName As String = FixString(CommonFunction.General.CheckIsNothing(ControlsHashTable("LoginName")).Trim, 30, False, True) 'Modified By Ninad on 24 Aug 2009 IssueID-32698 
                Dim strPassword As String = FixString(CommonFunction.General.CheckIsNothing(ControlsHashTable("Password")).Trim, 30, False, True) 'Modified By Ninad on 24 Aug 2009 IssueID-32698 
                Dim strEncryPass As String = ""
                Dim strSQLQuery As String
                Dim objEncrypt As New Authentication.PWEncryption(strLoginName, strPassword)
                strEncryPass = objEncrypt.Encrypt()
                objEncrypt = Nothing
                If LoginID.Trim = "" Then
                    'INSERT mode
                    Dim strTenantID As String = CommonFunction.General.CheckIsNothing(ControlsHashTable("TenantID")).Trim()
                    Dim sSQL As String
                    ' if Administrator Login then it have Tenant Id so set strTenantid as TenantID
                    If strTenantID <> "" Then
                        strTenantID = "'" + strTenantID + "'"
                    End If
                    sSQL = "EXEC usp_ins_tbl_PM_Login_Tenant '" + strLoginName + "','" + strEncryPass + "'," + strTenantID + ", 0"
                    CommonFunction.Data.InsertOrUpdateData(sSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    sSQL = "EXEC usp_ins_tbl_PM_Login_TenantCreation  '" + strLoginName + "'," + strTenantID
                    CommonFunction.Data.InsertOrUpdateData(sSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                Else
                    Dim sSQL As String
                    sSQL = "EXEC usp_ins_tbl_PM_Login_Tenant '" + strLoginName + "','" + strEncryPass + "', '', 1"
                    CommonFunction.Data.InsertOrUpdateData(sSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                End If
            End Sub
#End Region
            'Ended By Chakshuta H on 29th-Oct-2015

#Region "Project Review"

            Private Sub AssignOrUpdateTasks(ByVal strPrimaryKey As String, ByVal ControlsHashTable As Hashtable)
                '=====================================================================
                ' Procedure Name		:	AssignOrUpdateTasks
                ' Purpose				:	To assign review tasks for the reviewer and the reviewee.
                '							For edit mode the task details will be updated.
                ' Description			:	Same as above.
                ' Parameters Passed		:	strPrimaryKey, ControlsHashTable
                ' Parameters Affected	:	None.
                ' Returns				:	No return values.
                ' Assumptions			:	None.
                ' Dependencies			:	None.
                ' Author				:	RajaniR
                ' Created				:	Wednesday, June 26, 2002 11:12
                ' Revisions				:   Converted to .net by umeshj on Feb 23, 2004
                '                           1.  HiteshS on 17th Jan.2005
                '                               For IssueID >> 15376
                '                               Added If condition to pass paramere as NULL if it returns "" string
                '=====================================================================	
                Dim strSQLQuery As String

                ' Build Query to insert/update the review tasks.
                strSQLQuery = "Exec usp_Ins_tbl_PM_AssignReviewTasks_ReviewPlanning "

                ' The Review ID.
                strSQLQuery = strSQLQuery + strPrimaryKey

                ' Project ID.
                strSQLQuery = strSQLQuery + ", " + HttpContext.Current.Session("intProjectID").ToString

                ' Review Type ID.
                '====================================================
                'Modified By    :   HiteshS on 17th Jan.2005
                'For ISSUE ID   :   15376
                'Description    :   Passed the NULL value if CommonFunction.General.CheckIsNothing(ControlsHashTable("PReviewTypeID")) returns ""
                '====================================================
                If Not Trim(CommonFunction.General.CheckIsNothing(ControlsHashTable("PReviewTypeID"))) = "" Then
                    strSQLQuery = strSQLQuery + "," + CommonFunction.General.CheckIsNothing(ControlsHashTable("PReviewTypeID"))
                Else
                    strSQLQuery = strSQLQuery + ", NULL "
                End If
                '====================================================
                'End Of Modification By HiteshS on 17th Jan.2005
                '====================================================

                ' Review Date.
                If CommonFunction.General.CheckIsNothing(ControlsHashTable("ReviewedDate")) <> "" Then
                    strSQLQuery = strSQLQuery & ", '" & CommonFunction.Dates.GetDate(CType(CommonFunction.General.CheckIsNothing(ControlsHashTable("ReviewedDate")), Date)) + "'"
                Else
                    strSQLQuery = strSQLQuery & ", NULL"
                End If

                ' Reviewer.
                If CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase1")) <> "" Then
                    'Reviwer list is calculated internaly in the SP..
                    strSQLQuery = strSQLQuery & ", '" & Left(CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase1")), 30) + "'"
                Else
                    strSQLQuery = strSQLQuery & ", NULL"
                End If

                ' Reviewee.
                'Commented and Added Start by SatyanarayanaA on 18-Jan-2006
                'If CommonFunction.General.CheckIsNothing(ControlsHashTable("Reviewee")) <> "" Then
                If CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase12")) <> "" Then
                    'Commented Ended by SatyanarayanaA on 18-Jan-2006
                    strSQLQuery = strSQLQuery & ", '" & Left(CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase12")), 30) + "'"
                Else
                    strSQLQuery = strSQLQuery & ", NULL"
                End If

                'Modified by NitinVS on 2 Jun 2007 for WhizbileSEM 7 ISsueID 14217
                'Review effort is getting passed as 102,343 which is treated as extra parameter hence crash occurs
                ' Removed the formatstring method
                ' Expected duration of work (hrs).

                'Commented and Added by Usha Pandit on 15.05.2019 for storing Correct Efforts after work field change
                'If CommonFunction.General.CheckIsNothing(ControlsHashTable("ReviewEffort")) <> "" Then
                '    strSQLQuery = strSQLQuery & ", '" & CommonFunction.General.CheckIsNothing(ControlsHashTable("ReviewEffort"), "0") + "'"
                'Else
                '    strSQLQuery = strSQLQuery & ", NULL"
                'End If

                If CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase10")) <> "" Then
                    Dim HMEfforts As String = ""
                    Dim fltEfforts As String = ""
                    HMEfforts = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase10"), "0")
                    fltEfforts = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + HMEfforts + "',2)", True)
                    strSQLQuery = strSQLQuery & ", '" & fltEfforts + "'"

                Else
                    strSQLQuery = strSQLQuery & ", NULL"
                End If

                'End of Added by Usha Pandit on 15.05.2019 for storing Correct Efforts after work field change




                'End Modification By NitinVS on 2 Jun 2007 for WhizbileSEM 7 ISsueID 14217

                ' Created By (for audit trail).				
                strSQLQuery = strSQLQuery & ", '" & CommonFunction.General.BuildQueryString(HttpContext.Current.Session("strUserName").ToString) & "'"

                'UnCommented This Code as this is Required - VidyaJ - For IssueID - 16783
                ' Insert/Update Tasks.		
                CommonFunction.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                'End Of Addition

            End Sub

            Private Function SendMail_ReviewPlanned(ByVal PrimaryKey As String) As String
                '=====================================================================
                ' Procedure Name		:	SendMail_ReviewPlanned
                ' Purpose				:	SendMail for ReviewPlanned
                ' Description			:	Same as above.
                ' Parameters Passed		:	strPrimaryKey
                ' Parameters Affected	:	None.
                ' Returns				:	No return values.
                ' Assumptions			:	None.
                ' Dependencies			:	None.
                ' Author				:	UmeshJ
                ' Created				:	Feb 23, 2004
                ' Revisions				:   
                '=====================================================================	                
                Dim blnSendEmail As Boolean
                Dim blnShowPopup As Boolean
                ' Get the flag status for the messaage. (i.e. 1. Whether the mail has to be sent? 2. Should a popup page must be displayed?)
                Dim drEmailMessage As IDataReader = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 29", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drEmailMessage.Read Then
                    blnSendEmail = CType(CommonFunction.Data.CheckIsDBNull(drEmailMessage("SendMail")), Boolean)
                    blnShowPopup = CType(CommonFunction.Data.CheckIsDBNull(drEmailMessage("ShowPopup")), Boolean)
                End If
                CommonFunction.Data.DisposeDataReader(drEmailMessage)
                SendMail_ReviewPlanned = ""
                ' If the mail must be sent, then...
                If blnSendEmail = True Then

                    ' If the mail must be sent silently, then...
                    If blnShowPopup = False Then
                        Dim strFromEmailID As String
                        Dim strToEmailID As String
                        Dim strCCToEmailID As String
                        Dim strSubject As String
                        Dim strEmailMessage As String
                        ' Get the mail content and send the mail.
                        Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_29(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, CType(PrimaryKey, Long))
                        Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)

                        ' Else, if the mail must be displayed in the popup window, then...
                    Else
                        ' Display the mail content in the popup window.
                        SendMail_ReviewPlanned += "	window.open (" + Chr(34) + "../General/SendEmail.aspx?MessageID=29&ReviewStatisticsID=" + PrimaryKey + Chr(34) + ",""Planned"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=600,height=500"");" + vbCrLf
                    End If
                End If

            End Function

            Private Function SendMail_ReviewRescheculed(ByVal PrimaryKey As String, ByVal OldReviewDate As String, ByVal OldReviewStartDate As String, ByVal oldreviewenddate As String) As String
                '=====================================================================
                ' Procedure Name		:	SendMail_ReviewRescheculed
                ' Purpose				:	SendMail Review Rescheculed
                ' Description			:	Same as above.
                ' Parameters Passed		:	strPrimaryKey
                ' Parameters Affected	:	None.
                ' Returns				:	No return values.
                ' Assumptions			:	None.
                ' Dependencies			:	None.
                ' Author				:	UmeshJ
                ' Created				:	Feb 23, 2004
                ' Revisions				:   Oct 2004 
                '                           by DipaliS : Added 2 parameters for start and end date old values
                '=====================================================================	                
                ' Get the flag status for the messaage. (i.e. 1. Whether the mail has to be sent? 2. Should a popup page must be displayed?)
                Dim blnSendEmail As Boolean
                Dim blnShowPopup As Boolean
                ' Get the flag status for the messaage. (i.e. 1. Whether the mail has to be sent? 2. Should a popup page must be displayed?)
                Dim drEmailMessage As IDataReader = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 29", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drEmailMessage.Read Then
                    blnSendEmail = CType(CommonFunction.Data.CheckIsDBNull(drEmailMessage("SendMail")), Boolean)
                    blnShowPopup = CType(CommonFunction.Data.CheckIsDBNull(drEmailMessage("ShowPopup")), Boolean)
                End If
                CommonFunction.Data.DisposeDataReader(drEmailMessage)
                SendMail_ReviewRescheculed = ""
                ' If the mail must be sent, then...
                If blnSendEmail = True Then
                    ' If the mail must be sent silently, then...
                    If blnShowPopup = False Then
                        Dim strFromEmailID As String
                        Dim strToEmailID As String
                        Dim strCCToEmailID As String
                        Dim strSubject As String
                        Dim strEmailMessage As String
                        ' Get the mail content and send the mail.
                        'Code Commented by DipaliS 20 Oct 2004
                        'Added Parameters for old start and end date
                        'Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_30(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, PrimaryKey, CType(OldReviewDate, Date))
                        Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_30(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, PrimaryKey, CType(OldReviewDate, Date), CType(OldReviewStartDate, Date), CType(oldreviewenddate, Date))
                        Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                        ' Else, if the mail must be displayed in the popup window, then...		
                    Else
                        ' Display the mail content in the popup window.
                        'Code Commented by DipaliS 20 OCt 2004 and added the following
                        'SendMail_ReviewRescheculed += "	window.open (" + Chr(34) + "../General/SendEmail.aspx?MessageID=30&ReviewStatisticsID=" + PrimaryKey + "&OldReviewDate=" + OldReviewDate + Chr(34) + ",""Scheduled"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=600,height=500"");" + vbCrLf
                        SendMail_ReviewRescheculed += "	window.open (" + Chr(34) + "../General/SendEmail.aspx?MessageID=30&ReviewStatisticsID=" + PrimaryKey + "&OldReviewStartDate=" + OldReviewStartDate.ToString + "&OldReviewEndDate=" + oldreviewenddate.ToString + "&OldReviewDate=" + OldReviewDate + Chr(34) + ",""Scheduled"",""resizable=yes,scrollbars=no,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 500) / 2 + "",width=600,height=500"");" + vbCrLf
                    End If
                End If
            End Function

#End Region

#End Region

#End Region

            Sub New()
                'Create object of the ProjectByNet Template Class
                m_objTemplate = New WebPages.Template.WhizTemplate
                'Initialize the Resources
                m_objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
            End Sub


            Protected Overrides Sub Finalize()
                'Remove the object from memory
                m_objTemplate = Nothing
            End Sub
            'Added By Chakshuta H on 29th-Oct-2015
            Protected Function FixString(ByVal UserInput As String, ByVal MaxLen As Integer, ByVal CheckNumeric As Boolean, ByVal ValExpected As Boolean) As String
                '=====================================================================
                ' Function  Name		:	FixString
                ' Parameters Passed		:	UserInput - User given input
                '                           MaxLen -  standard max length of input
                '                           CheckNumeric - Whether to apply numeric check
                '                           Value Expected - Is value expected
                ' Returns				:	Returns the fix string
                ' Parameters Affected	:	None
                ' Purpose				:	To get the form control value
                ' Description			:	
                ' Assumptions			:	None
                ' Dependencies			:	None
                ' ReqID                 :   IssueID-32698 Password Policy is not honoured
                ' Author				:	NinadP
                ' Created				:	24 Aug 2009
                ' Revisions				:	
                '=====================================================================
                Try
                    'Add the event handler to raise an event
                    AddHandler Utilities.Security.SecurityBuilder.NotValidInput, AddressOf Me.NotValidInput
                    'Call the fixstirng method of seucrity builder class
                    Return Utilities.Security.SecurityBuilder.FixString(UserInput, MaxLen, CheckNumeric, ValExpected)
                Catch ex As Exception
                    Dim strErrMessage As String = " UserInput:" + UserInput + ", MaxLen:" + MaxLen.ToString + ",CheckNumeric:" + CheckNumeric.ToString + ",ValExpected:" + ValExpected.ToString
                    Err.Raise(Err.Number, "Template->FixString", ex.Message + strErrMessage)
                End Try
            End Function
            'Event handler
            Private Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
                '=====================================================================
                ' Function  Name		:	NotValidInput
                ' Parameters Passed		:	UserInput - User given input
                '                       :   Cause - Case of server side validation failing
                ' Returns				:	Raise an exception
                ' Parameters Affected	:	None
                ' Purpose				:	To get the form control value
                ' Description			:	
                ' Assumptions			:	None
                ' Dependencies			:	None
                ' ReqID                 :   IssueID-32698 Password Policy is not honoured
                ' Author				:	NinadP
                ' Created				:	24 Aug 2009
                ' Revisions				:	
                '=====================================================================
                Dim ex As New Exception
                ex.Source = "Invalid User Input : " + UserInput + vbCrLf + "Cause :" + Cause
                Throw ex
            End Sub
            'Ended By Chakshuta H on 29th-Oct-2015

        End Class

    End Namespace

End Namespace
