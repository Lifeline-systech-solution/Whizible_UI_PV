Imports ProjectByNet
Namespace CommonEngine
    Namespace General
        Public Class CLCP_Events_Controls
            Protected Structure Controls_struct
                Dim ControlName As String
                Dim ControlCaption As String
                Dim Applicable As Boolean
                Dim Mandatory As Boolean
                Dim RowNumber As Integer
                Dim OrderNumber As Integer
            End Structure
            Protected m_ControlProperties As Controls_struct
            Protected m_ControlsHashTable As New Hashtable
            Public Shared Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing)
                'This event will occur before plotting the Control cell <TD>
                Cancel = False

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    'Added By DipaliS the check to display the field depending upon the Role
                    Select Case WhizGlobal.TagID


                         ' Added by Vyankat B. on 20th April 2026 to set the dynamic currency symbol
                        Case 53
                            ' Added to set currency logo for RoleCost control
                            If Args.ControlName.ToUpper() = "ROLECOST" Then
                                Dim strCurrencyLogo As String = ""
                                Try
                                    Dim objLogo As Object = CommonFunction.Data.GetDataScalar("EXEC use_Whizible2_Currency_logo", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    strCurrencyLogo = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objLogo, ""), ""), String).Trim()
                                Catch ex As Exception
                                End Try

                                If strCurrencyLogo <> "" Then
                                    Args.ControlCaption = "Cost (" & strCurrencyLogo & ")"
                                Else
                                    Args.ControlCaption = "Cost"
                                End If
                            End If

                        'End of Added by Vyankat B. on 20th April 2026 to set the dynamic currency symbol

                        'Modified By JyotiG
                        'Date :23-Aug-2006
                        'Issue Id: 5687
                        'Start
                        Case CommonFunction.Constants.APP_TAG_TAB_BASELINE_REVISION_REASON
                            Dim strMode As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "").ToString().ToUpper().Trim()
                            If Left(strMode, 1) = "A" Or Left(strMode, 1) = "R" Then
                                Args.ControlCaption = "Revision Reason"
                            ElseIf Left(strMode, 1) = "S" Then
                                Args.ControlCaption = "Sender Comments"
                            End If
                        Case CommonFunction.Constants.APP_TAG_TAB_BASELINE_COMMENTS
                            If Args.ControlName.ToUpper() = "NONDATABASE1" Then
                                Dim drProjectInformation As IDataReader
                                Dim drRevisionInformation As IDataReader
                                Dim strProjectStartDate As String
                                Dim strProjectEndDate As String
                                Dim strProjectEfforts As String

                                Dim strRevisedStartDate As String
                                Dim strRevisedEndDate As String
                                Dim strRevisedEfforts As String

                                Dim strFormAction As String
                                Dim strCommentData As String

                                Dim strSql As String
                                Dim strRevisionId As String
                                Dim drRevision As IDataReader
                                Dim strSenderQuery As String

                                strFormAction = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FormAction"), ""), String).Trim()

                                strSql = "Select  Max(RevisionReasonID) as RevisionID from tbl_PM_Project_BaselineRevisionReason where ProjectID =" & WhizGlobal.ProjectID.ToString()
                                drRevision = CommonFunction.Data.GetDataReader(strSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drRevision.Read Then
                                    strRevisionId = CType(CommonFunction.Data.CheckIsDBNull(drRevision("RevisionID"), "0"), String)
                                End If
                                CommonFunction.Data.DisposeDataReader(drRevision)
                                'drProjectInformation = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Project " & WhizGlobal.ProjectID.ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                drRevisionInformation = CommonFunction.Data.GetDataReader("EXEC usp_Sel_PM_Project_Baseline_Revision_Rejection_Reason " & strRevisionId.ToString() & "," & "'& strFormAction &'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                strSenderQuery = "EXEC usp_Sel_PM_Project_Baseline_Revision_Rejection_Reason " & strRevisionId.ToString() & ",'S'"
                                'Done By JyotiG
                                'Date : 05-Sep-2006
                                'Issue ID : 5763
                                'Start
                                'strCommentData = Replace(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSenderQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString(), (Chr(13)), "<BR>")
                                strCommentData = Replace(HttpContext.Current.Server.HtmlEncode(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSenderQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()), (Chr(13)), "<BR>")
                                'strCommentData = HttpContext.Current.Server.HtmlEncode(strCommentData)
                                'End
                                Args.IgnoreActualValue = True
                                If strFormAction = "S" Then
                                    Cancel = True
                                ElseIf strFormAction = "A" Or strFormAction = "R" Then
                                    'Args.NewValue = CommonFunctions.General.WriteHTML(Server.HtmlEncode(strCommentData))

                                    Args.NewValue = strCommentData
                                    'Args.NewValue = strCommentData
                                End If
                                CommonFunction.Data.DisposeDataReader(drRevisionInformation)
                            End If
                            'End (JyotiG)
                        Case CommonFunction.Constants.APP_TAG_PM_STAKEHOLDER

                            Dim contactType As Char
                            ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                            ' Dim dr As IDataReader
                            ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                            Select Case Args.ControlName.ToUpper
                                Case "ORGANIZATIONNAME"
                                    'If the Contact Category is Customer then do not show the Organization Name 
                                    With HttpContext.Current
                                        If CType(.Session("Tmp_ContactCategoryID"), String) = "" _
                                           Or CType(.Session("Tmp_ContactCategoryID"), String) = "1" Then
                                            Cancel = True
                                            HttpContext.Current.Session.Remove("Tmp_ContactCategoryID")
                                        End If
                                    End With
                                Case "CONTACTCATEGORYID"
                                    'Store the Contact Type in Session
                                    If Not (HttpContext.Current.Request.Form("ContactCategoryID") Is Nothing) And
                                       (HttpContext.Current.Request.QueryString("Navigation") Is Nothing) Then
                                        HttpContext.Current.Session("Tmp_ContactCategoryID") = (HttpContext.Current.Request.Form("ContactCategoryID").ToString)
                                    ElseIf Not (drControls Is Nothing) Then
                                        HttpContext.Current.Session("Tmp_ContactCategoryID") = CStr(drControls("ContactCateGoryID"))
                                    Else
                                        HttpContext.Current.Session.Remove("Tmp_ContactCategoryID")
                                    End If
                            End Select

                            'Get the type of Contact from Database 
                            If Not (HttpContext.Current.Session("Tmp_ContactCategoryID") Is Nothing) _
                              And IsNumeric(HttpContext.Current.Session("Tmp_ContactCategoryID")) Then
                                ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                Dim dr As IDataReader
                                ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                dr = CommonFunction.Data.GetDataReader("usp_Sel_tbl_CNF_ContactCategory " _
                                  & CType(HttpContext.Current.Session("Tmp_ContactCategoryID"), String), True)
                                dr.Read()
                                HttpContext.Current.Session("Tmp_ContactCategoryID") = DirectCast(dr("CategoryType"), String).ToUpper
                                CommonFunction.Data.DisposeDataReader(dr)
                            End If

                            Select Case HttpContext.Current.Session("Tmp_ContactCategoryID")
                                Case "C" 'Customer
                                    Select Case Args.ControlName.ToUpper
                                        Case "ORGANIZATIONNAME"
                                            Cancel = True
                                    End Select
                                Case "O"  'Organization
                                    Select Case Args.ControlName.ToUpper
                                        Case "NONDATABASE1"
                                            Cancel = True
                                        Case "ORGANIZATIONNAME"
                                            Cancel = True
                                    End Select
                                Case Else
                                    Select Case Args.ControlName.ToUpper
                                        Case "NONDATABASE1"
                                            Cancel = True
                                    End Select
                            End Select

                            'Case CommonFunction.Constants.TAG_PROJECT_INFORMATION, CommonFunction.Constants.APP_TAG_WORKORDER
                            '    Dim drRoleAccess As IDataReader
                            '    Dim strSQL As String = "usp_sel_tbl_pm_WOUSerAccess " & WhizGlobal.RoleID & ",'" & CommonFunction.General.BuildQueryString(Args.ControlName) & "'"
                            '    drRoleAccess = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '    If Not (drRoleAccess.Read) Then
                            '        Cancel = True
                            '    End If
                            '    CommonFunction.Data.DisposeDataReader(drRoleAccess)
                        Case CommonFunction.Constants.APP_TAG_CREATE_PROJECT
                            Select Case Args.ControlName.ToUpper
                                Case "LOCATIONID", "BUSINESSGROUPID"
                                    '---Added By Paresh B. For workorder Page on August 05,2004
                                    Dim objTemplate As WebPages.Template.WhizTemplate
                                    'Create object of the ProjectByNet Template Class
                                    objTemplate = New WebPages.Template.WhizTemplate
                                    'Initialize the Resources
                                    objTemplate.InitializeResources("AppResources.WorkOrder", "AppResources")
                                    If Args.ControlName.ToUpper = "LOCATIONID" Then
                                        Args.ControlCaption = objTemplate.GetResourceString("LOCATION")
                                    Else
                                        Args.ControlCaption = objTemplate.GetResourceString("BUSINESS_GROUP")
                                    End If
                                    objTemplate = Nothing

                            End Select

                        Case CommonFunction.Constants.APP_TAG_CREATE_PROJECT
                            Select Case Args.ControlName.ToUpper
                                Case "LOCATIONID", "BUSINESSGROUPID"
                                    '---Added By Paresh B. For workorder Page on August 05,2004
                                    Dim objTemplate As WebPages.Template.WhizTemplate
                                    'Create object of the ProjectByNet Template Class
                                    objTemplate = New WebPages.Template.WhizTemplate
                                    'Initialize the Resources
                                    objTemplate.InitializeResources("AppResources.WorkOrder", "AppResources")
                                    If Args.ControlName.ToUpper = "LOCATIONID" Then
                                        Args.ControlCaption = objTemplate.GetResourceString("LOCATION")
                                    Else
                                        Args.ControlCaption = objTemplate.GetResourceString("BUSINESS_GROUP")
                                    End If
                                    objTemplate = Nothing

                            End Select

                            'Added by ShamkantD on 6 Oct 2004 - Added for Project Information page
                        Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING
                            Select Case Args.ControlName.ToUpper
                                Case "LOCATIONID", "BUSINESSGROUPID"
                                    '---Added By Paresh B. For workorder Page on August 05,2004
                                    Dim objTemplate As WebPages.Template.WhizTemplate
                                    'Create object of the ProjectByNet Template Class
                                    objTemplate = New WebPages.Template.WhizTemplate
                                    'Initialize the Resources
                                    objTemplate.InitializeResources("AppResources.WorkOrder", "AppResources")
                                    If Args.ControlName.ToUpper = "LOCATIONID" Then
                                        Args.ControlCaption = objTemplate.GetResourceString("LOCATION")
                                    Else
                                        Args.ControlCaption = objTemplate.GetResourceString("BUSINESS_GROUP")
                                    End If
                                    objTemplate = Nothing
                            End Select
                            'End of addition - ShamkantD on 6 Oct 2004

                            '##### Cases Added For Resource Timesheet Flow
                            'Code Added By MangeshY on 22 July 2004 : Donot show the two controls if Timesheet workflow is switched off at company level
                        Case CommonFunction.Constants.APP_TAG_RESOURCES
                            'Modified By VidyaJ - Resources - SP4 - IssueID - 85
                            'Get whethere Timesheet workflow is applicable or not from application variable

                            'Dim strSQL As String
                            'Dim drCompanyInformation As IDataReader

                            'strSQL = "Exec usp_sel_tbl_PM_CompanyInformation"
                            'drCompanyInformation = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            'If drCompanyInformation.Read Then
                            '    If Not CType(CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("TimesheetWorkFlow"), "0"), Boolean) Then
                            If Not CType(CommonFunction.Application.TimesheetWorkFlow, Boolean) Then
                                Select Case Args.ControlName.ToUpper
                                    Case "ISDEFAULTAPPROVER"
                                        Cancel = True
                                    Case "REPORTINGTO"
                                        Cancel = True
                                End Select
                            End If
                            '  End If


                            'CommonFunctions.Data.DisposeDataReader(drCompanyInformation)
                            'End Of Modifications
                            'End Addition
                            '##### End Of Cases For Resource Timesheet Flow

                            'added by SachinR   on 13 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                            'here check if control is applicable then only show it,else dont show it
                            'if control is mandatory then only make it mandatory, else dont
                            'default all the controls are mandatory
                            Dim strSQL As String
                            Dim objDr As IDataReader
                            Dim strScheduleID As String
                            Dim blnUseSQL As Boolean
                            Dim str() As String
                            Dim strRule As String
                            Dim strLabel As String
                            Dim blnIsApplicable As Boolean
                            Dim blnIsMandatory As Boolean
                            blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

                            strScheduleID = ""
                            'Modified by SachinR    on 12 Oct 2004
                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ScheduleTypeID"), "") <> "" Then
                                strScheduleID = HttpContext.Current.Request.QueryString("ScheduleTypeID")
                            End If
                            'modification end

                            'Modified By VidyaJ - Performance Issue - Deliverable - SP4 - IssueID -84

                            'Moved the code to UI Page Pre Render so that query is executed only once

                            'if user has not selected any deliverable type and clicked on the deliverable to edit it
                            'then no deliveable type will be stored as user preferences.Then get the deliverable typeID
                            'from the deliverable record
                            If strScheduleID = "" Or strScheduleID = "0" Then
                                'strSQL = "usp_sel_tbl_PM_OtherSchedules " + Args.PrimaryKeyValue.Trim
                                'objDr = CommonFunction.Data.GetDataReader(strSQL, blnUseSQL)
                                'If objDr.Read Then
                                '    strScheduleID = CommonFunction.Data.CheckIsDBNull(objDr("ScheduleTypeID"), "").ToString + ""
                                'End If
                                'CommonFunction.Data.DisposeDataReader(objDr)
                                strScheduleID = CType(HttpContext.Current.Session("ScheduleTypeID"), String)
                            End If
                            'End Of Modifications

                            If strScheduleID = "" Then strScheduleID = "0"

                            strLabel = ""
                            blnIsApplicable = False
                            blnIsMandatory = False

                            'added by SachinR   on 02 Nov 2004
                            'implement the hashtable for the deliverable field configuration.Following commented code
                            'is previous implementation with direct database
                            Dim objDeliverableField As New CommonEngine.HashTables.DeliverableField
                            objDeliverableField = CommonEngine.HashTables.Deliverable.GetHashTableDeliverableFieldObject(CType(strScheduleID, Long), Args.ControlName)
                            If Not objDeliverableField Is Nothing Then
                                strLabel = CommonFunction.General.FormatString(objDeliverableField.Label, True)
                                blnIsApplicable = objDeliverableField.Applicable
                                blnIsMandatory = objDeliverableField.Mandatory
                            End If
                            objDeliverableField = Nothing
                            'addition end   on 02 Nov 2004

                            'added by SachinR   on 28 Oct 2004
                            If strLabel = "" Then
                                strLabel = Args.ControlCaption
                            End If
                            'addition end

                            Select Case UCase(Args.ControlName)
                                Case "STARTDATE", "EARLIESTSTARTDATE", "LATESTCOMPLETIONDATE", "CUSTOMERREFNO", "DELIVERABLELCE", "PROJECTSITEID", "PACKAGEID", "PROJECTSYSTEMID"

                                    If blnIsApplicable = False Then
                                        Cancel = True
                                    Else
                                        Args.ControlCaption = strLabel

                                        If blnIsMandatory = False Then
                                            Args.Mandatory = False
                                            str = Args.ValidationRules.Split(","c)
                                            Args.ValidationRules = ""
                                            For Each strRule In str
                                                If strRule <> "1" Then
                                                    Args.ValidationRules += strRule + ","
                                                End If
                                            Next
                                        End If

                                    End If

                                Case "DELIVERABLESIZE", "DELIVERABLESIZEUNITID", "INCLUDEINMEASUREMENT", "REQUESTEDBY", "RESPONSIBLEPERSON", "STATUS", "TITLE"

                                    If blnIsApplicable = False Then
                                        Cancel = True
                                    Else
                                        Args.ControlCaption = strLabel

                                        If blnIsMandatory = False Then
                                            Args.Mandatory = False
                                            str = Args.ValidationRules.Split(","c)
                                            Args.ValidationRules = ""
                                            For Each strRule In str
                                                If strRule <> "1" Then
                                                    Args.ValidationRules += strRule + ","
                                                End If
                                            Next
                                        End If
                                    End If

                                Case "PRIORITY", "COMPLEXITYID", "DEPARTMENTID", "PERCENTAGECOMPLETE", "EXPECTEDCOMPLETIONTIME", "REQUESTEDTIME", "ISACCEPTANCETESTINGREQUIRED"

                                    If blnIsApplicable = False Then
                                        Cancel = True
                                    Else
                                        Args.ControlCaption = strLabel

                                        If blnIsMandatory = False Then
                                            Args.Mandatory = False
                                            str = Args.ValidationRules.Split(","c)
                                            Args.ValidationRules = ""
                                            For Each strRule In str
                                                If strRule <> "1" Then
                                                    Args.ValidationRules += strRule + ","
                                                End If
                                            Next
                                        End If
                                    End If
                                    ' Modified By NitinVS on 30 Aug 2005 for WhizibleSEM SP4 IssueID 94
                                    ' Additional Custom Fields for Deliverable.

                                Case "CUSTOMFIELDTEXT1", "CUSTOMFIELDTEXT2", "CUSTOMFIELDTEXT3", "CUSTOMFIELDTEXT4", "CUSTOMFIELDTEXT5",
                                        "CUSTOMFIELDNUMERIC1", "CUSTOMFIELDNUMERIC2", "CUSTOMFIELDNUMERIC3", "CUSTOMFIELDNUMERIC4", "CUSTOMFIELDNUMERIC5",
                                        "CUSTOMFIELDDATE1", "CUSTOMFIELDDATE2", "CUSTOMFIELDDATE3", "CUSTOMFIELDDATE4", "CUSTOMFIELDDATE5"

                                    If blnIsApplicable = False Then
                                        Cancel = True
                                    Else
                                        Args.ControlCaption = strLabel

                                        If blnIsMandatory = False Then
                                            Args.Mandatory = False
                                            str = Args.ValidationRules.Split(","c)
                                            Args.ValidationRules = ""
                                            For Each strRule In str
                                                If strRule <> "1" Then
                                                    Args.ValidationRules += strRule + ","
                                                End If
                                            Next
                                        End If
                                    End If

                                    ' End Modification By NitinVS on  30 Aug 2005 for WhizibleSEM SP4 IssueID 94

                                Case Else
                            End Select
                            'addition end

                            'added by SachinR   on 20 aug 2004
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLE_DISCUSSION_THREAD
                            'here ShowToCustomer checkbox is show only if user is employee
                            If Args.ControlName.ToUpper = "SHOWTOCUSTOMER" Then
                                If WhizGlobal.LoginType.ToUpper <> "E" Then
                                    Args.IsHidden = True
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = "True"
                                End If
                            End If
                            'addition end
                    End Select
                Else
                    'For Details Tag
                End If
            End Sub

            Public Shared Sub After_PlotControlCell(ByVal Args As EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing)
                'This event will occur After plotting the Control cell <TD>

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag

                Else
                    'For Details Tag

                End If
            End Sub

            Public Shared Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")
                'This event will occur before plotting the Control caption
                Cancel = False

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_TAG_RESOURCES
                            Select Case Args.ControlName.ToUpper
                                Case "NONDATABASE1"
                                    If Args.IsEditMode Then
                                        Args.HREF_URL = ""
                                        Args.HREF_Parameters = ""
                                        'Added by ShraddhaM on 17,Sept 2008
                                        'Purpose : Resource Allocation from advanced searched resources in Whiziblesem8.0
                                    ElseIf HttpContext.Current.Request.QueryString("FromADSEARCH") = "1" Then
                                        Args.HREF_URL = ""
                                        Args.HREF_Parameters = ""
                                        'End of addition by ShraddhaM on 17,Sept 2008
                                    End If
                            End Select
                            'Commented by Manishk on 3rd Jan 2006 as new inherited page is added for leave page
                            '''Added by NileshD 8 April 2004
                            '''Hide the lable of leave balance in edit mode.
                            '''Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEAPPLICATION
                            '''    'do not shoe the caption in edit mode.
                            '''    If Args.ControlName.ToUpper = "NONDATABASE1" Then
                            '''        If Args.IsEditMode = True Then
                            '''            'Cancel = True
                            '''        End If
                            '''    End If
                            '''    'Addition End
                            '''    'Added By DipaliS the check to display the field depending upon the Role
                            '''    'Case CommonFunction.Constants.TAG_PROJECT_INFORMATION, CommonFunction.Constants.APP_TAG_WORKORDER
                            '''    '    Dim drRoleAccess As IDataReader
                            '''    '    Dim strSQL As String = "usp_sel_tbl_pm_WOUSerAccess " & WhizGlobal.RoleID & ",'" & CommonFunction.General.BuildQueryString(Args.ControlName) & "'"
                            '''    '    drRoleAccess = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '''    '    If Not (drRoleAccess.Read) Then
                            '''    '        Cancel = True
                            '''    '    End If
                            '''    '    CommonFunction.Data.DisposeDataReader(drRoleAccess)

                            'End of Commented by Manishk on 3rd Jan 2006 as new inherited page is added for leave page

                            '    'Added by ShamkantD on 2nd August 2004

                            '    'Modified By PrachiK on 26 Feb 2005 for Issue ID 14776. 
                            '    'Purpose: Setting - Assign issue to resposible person 
                        Case CommonFunction.Constants.APP_TAG_PROJECT_SETTINGS
                            If Args.ControlCaption.ToUpper = "ASSIGN ISSUE TO RESPONSIBLE PERSON" Then

                                Dim intAssignIssueToResponsiblePerson As Integer
                                If Not CommonFunction.Data.GetDataScalar("select assignIssueToResponsiblePerson from tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) Is Nothing Then
                                    intAssignIssueToResponsiblePerson = CType(CommonFunction.Data.GetDataScalar("select assignIssueToResponsiblePerson from tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)
                                    If intAssignIssueToResponsiblePerson = 0 Then
                                        Cancel = True
                                    End If
                                End If
                            End If
                            'Addtion ended
                        Case CommonFunction.Constants.APP_TAG_WORKORDER
                            'Show or hide the controls depending upon the Work Order Field access
                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strWorkOrderAccessAttributes")).ToString = "" Then
                                Dim drAttributes As IDataReader
                                Dim strAttributes As String

                                drAttributes = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_WOUserAcess " & HttpContext.Current.Session("intPostID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                strAttributes = ""
                                While drAttributes.Read
                                    If CommonFunction.General.CheckIsNothing(drAttributes("CheckAttribute")).ToString <> "" Then
                                        strAttributes += drAttributes("AttributeName").ToString + ","
                                    End If
                                End While
                                CommonFunction.Data.DisposeDataReader(drAttributes)

                                HttpContext.Current.Session("strWorkOrderAccessAttributes") = strAttributes
                            End If

                            Select Case Args.ControlName.ToUpper
                                Case "PROJECTCODE"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectCode") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROJECTNAME"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectName") < 1 Then
                                        Cancel = True
                                    End If
                                Case "CUSTOMERID"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "CustomerName") < 1 Then
                                        Cancel = True
                                    End If
                                Case "DESCRIPTION"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "Description") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROJECTADDRESS"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectAddress") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROJECTCITY"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectCity") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROJECTSTATE"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectState") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROJECTCOUNTRY"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectCountry") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROJECTPIN"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectPIN") < 1 Then
                                        Cancel = True
                                    End If
                                Case "FUNDEDBY"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "FundedBy") < 1 Then
                                        Cancel = True
                                    End If
                                Case "CONTRACTSTATUSID"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ContractRequired") < 1 Then
                                        Cancel = True
                                    End If
                                Case "CONTRACTPREPAREDBY"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ContractPreparedBy") < 1 Then
                                        Cancel = True
                                    End If
                                Case "VALIDITYDATE"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ContractValidityDate") < 1 Then
                                        Cancel = True
                                    End If
                                Case "CUSTOMERCONTACTPERSON"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "CustomerContactPerson") < 1 Then
                                        Cancel = True
                                    End If
                                Case "AUTHORIZATIONPONUMBER"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "AuthorizationPONumber") < 1 Then
                                        Cancel = True
                                    End If
                                Case "CUSTOMERADDRESS"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "CustomerAddress") < 1 Then
                                        Cancel = True
                                    End If
                                Case "REFERENCENO"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ReferenceNo") < 1 Then
                                        Cancel = True
                                    End If
                                Case "REFERENCEDATE"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ReferenceDate") < 1 Then
                                        Cancel = True
                                    End If

                                    'Added by ShamkantD on 5th August 2004
                                Case "SHORTJOBTITLE"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ShortJobTitle") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROJECTSIZE"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectSize") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROJECTSIZEUNITID"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectSize") < 1 Then
                                        Cancel = True
                                    End If
                                Case "LIFECYCLEID"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "LifeCycleID") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROPOSALNO"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProposalNo") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROPOSALCOST"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProposalCost") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROPOSALJOBNO"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProposalJobNo") < 1 Then
                                        Cancel = True
                                    End If
                                    'End of addition - ShamkantD on 5th August 2004
                            End Select

                        Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING
                            'Modified by ShamkantD on 23 Sep 2004 - disable the Work Order Field access validations
                            ''Show or hide the controls depending upon the Work Order Field access
                            'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strWorkOrderAccessAttributes")).ToString = "" Then
                            '    Dim drAttributes As IDataReader
                            '    Dim strAttributes As String

                            '    drAttributes = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_WOUserAcess " & HttpContext.Current.Session("intPostID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '    strAttributes = ""
                            '    While drAttributes.Read
                            '        If CommonFunction.General.CheckIsNothing(drAttributes("CheckAttribute")).ToString <> "" Then
                            '            strAttributes += drAttributes("AttributeName").ToString + ","
                            '        End If
                            '    End While
                            '    CommonFunction.Data.DisposeDataReader(drAttributes)

                            '    HttpContext.Current.Session("strWorkOrderAccessAttributes") = strAttributes
                            'End If

                            'Select Case Args.ControlName.ToUpper
                            '    Case "SHORTJOBTITLE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ShortJobTitle") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "CONTRACT"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "Contract") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "PROPOSALNO"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProposalNo") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "PROJECTGROUPID"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectGroupID") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "INVOICEAPPLICABLE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "InvoiceApplicable") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "BILLABLE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "Billable") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "PROPOSALJOBNO"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProposalJobNo") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "PROPOSALCOST"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProposalCost") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "PROJECTTYPE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectTypeID") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "LIFECYCLEID"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "LifeCycleID") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "CONTRACTTYPE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ContractType") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "BILLINGCYCLETYPE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "BillingCycleType") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "PROJECTSIZE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectSize") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "PROJECTSIZEUNITID"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectSize") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "EXPECTEDSTARTDATE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ExpectedStartDate") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "EXPECTEDENDDATE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ExpectedEndDate") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "ESTIMATEDEFFORTS"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "EstimatedEfforts") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "CONTRACTVALUE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ContractValue") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "BASECURRENCY"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "BaseCurrency") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "LOCATIONID"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "LocationID") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "BUSINESSGROUPID"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "BusinessGroupID") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "PROJECTSTATUSID"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectStatusID") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "PROJECTTYPEID"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectTypeID") < 1 Then
                            '            Cancel = True
                            '        End If
                            'End Select
                            ''End of addition - ShamkantD on 2nd August 2004
                            'Modification ends - ShamkantD on 23 Sep 2004
                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                            '----------------------------------------------------------------------------------
                            'Added By SandeepA on 14 Nov,2005 for IssueID - 671
                        Case CommonFunction.Constants.APP_TAG_PRS_DELIVERABLE_TYPES
                            'Purpose: Show/Hide 'Code Template' control Caption
                            If Args.ControlName.ToUpper = "CODETEMPLATE" Then
                                Dim strScheduleID As String
                                Dim strSQLQuery As String
                                Dim intResult As Integer
                                Dim blnUseSQL As Boolean

                                blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
                                'Check if the Code Template is Editable
                                strScheduleID = CommonFunctions.General.CheckIsNothing(Args.PrimaryKeyValue, "0")
                                strSQLQuery = "If Exists(Select 1 from tbl_PM_CompanySchedules where ScheduleID=" & strScheduleID & " and IsCodeTemplateEditable=1)Select (Select 1 from tbl_PM_CompanySchedules where ScheduleID=" & strScheduleID & " and IsCodeTemplateEditable=1) Else Select 0"
                                intResult = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strsqlquery, blnUseSQL), "0"), Integer)
                                If intresult = 0 Then
                                    'If Code Template is editable then show the Code Template TextBox
                                Else
                                    'If Code Template is not editable then Hide the Code Template TextBox
                                    Cancel = True
                                End If
                            End If
                            'End of Addition by SandeepA on 14 Nov,2005 for IssueID - 671

                            'Added By SandeepA on 12 Nov,2005 for IssueID -671
                        Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                            'Purpose: Hide the Control cation for 'Code Template' id not shown in ADD_NEW Mode
                            If Args.ControlName.ToUpper = "DOCUMENTNO" Then

                                Dim strSQLQuery As String
                                Dim intResult As Integer
                                Dim strScheduleTypeID As String

                                If Args.IsEditMode = False Then
                                    'ADD_NEW MODE
                                    strScheduleTypeID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ScheduleTypeID"), "0")
                                    'Get the Result
                                    strSQLQuery = "If Exists(Select 1 from tbl_PM_CompanySchedules where ScheduleID=" & strScheduleTypeID & " and IsCodeTemplateEditable=1)Select (Select 1 from tbl_PM_CompanySchedules where ScheduleID=" & strScheduleTypeID & " and IsCodeTemplateEditable=1) Else Select 0"
                                    intResult = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery, True), "0"), Integer)
                                    'if intResult is 1 -Show 'CodeTemplate' in Editable Mode with Mandatory, Else dont show the control
                                    If intResult = 1 Then
                                        Args.Editable = True
                                        Args.Mandatory = True
                                    Else
                                        Cancel = True
                                    End If
                                End If
                            End If
                            'End of Addition By SandeepA on  12 Nov,2005 for IssueID-671
                            '----------------------------------------------------------------------------------
                            'End Addition

                            'Integrated by MrugajaB on 23rd March 2006 for WhizibleSEM 6.0 Expense WorkFlow - Issue ID.2886
                        Case CommonFunction.Constants.APP_TAG_PROJECT_DOH

                            If Args.ControlName.ToUpper = "ISACTIVE" Then
                                Dim strSQL As String
                                Dim ExpenseWorkFlow As String

                                StrSQL = "SELECT ExpenseWorkFlow FROM tbl_PM_CompanyInformation "
                                ExpenseWorkFlow = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0")

                                If ExpenseWorkFlow.ToUpper = "FALSE" Then
                                    Cancel = True
                                End If

                            End If
                            'End Integration

                    End Select
                Else
                    'For Details Tag
                    Select Case WhizGlobal.TagID
                        'Case CommonFunction.Constants.APP_TAG_NEW_RATE
                        '    If Args.ControlName.ToUpper = "RATEFORID" Then

                        'End If
                        'Added By DipaliS for changing the caption for Rate For Name control
                        Case CommonFunction.Constants.APP_TAG_NEW_RATE 'APP_TAG_TAB_RATECONTRACTBYROLE
                            Dim strSQL As String
                            Dim drContractType As IDataReader
                            'Get the caption for RateForName depending upon contract type
                            If Args.ControlName.ToUpper = "RATEFORID" Then
                                Dim objTemplate As WebPages.Template.WhizTemplate
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
                                If strRateFor <> "" Then
                                    Args.ControlCaption = strRateFor
                                End If
                                CommonFunctions.Data.DisposeDataReader(drContractType)
                                objTemplate = Nothing
                            End If

                            'added by SachinR   on 28 Jul 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_PROCESS_PHASETASK_TEMPLATES
                            'change the caption of the effort field based on the flag PercentEfforDistribution of template
                            If Args.ControlName.ToUpper = "EFFORT" Then
                                Dim strTemplateID As String
                                Dim strSQL As String
                                Dim objDr As IDataReader
                                Dim blnEffortDistributionByPercentage As Boolean = False
                                Dim objTemplate As WebPages.Template.WhizTemplate
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

                                strTemplateID = HttpContext.Current.Request("ForeignKeyValue") + ""

                                strSQL = "usp_sel_tbl_PRS_PhaseTask_Template " + strTemplateID.Trim
                                objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If objDr.Read Then
                                    blnEffortDistributionByPercentage = CType(CommonFunction.Data.CheckIsDBNull(objDr("PercentageEffortDistribution"), "0"), Boolean)
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)

                                If blnEffortDistributionByPercentage = True Then
                                    Args.ControlCaption = objTemplate.GetResourceString("PHASE_EFFORT_PERCENTAGE")
                                Else
                                    Args.ControlCaption = objTemplate.GetResourceString("PHASE_EFFORT_HOURS")
                                End If
                                objTemplate = Nothing
                            End If
                            'addition end
                            'Added By NileshD on 29 July 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_TAX_DETAILS
                            If Args.ControlName.ToUpper = "TAXID" Then
                                Dim intCounter As Integer
                                Dim strQuery As String
                                'Get the Tax list according to number of taxes added for this RFI Type
                                strQuery = "SELECT Count(RFITypeTaxID) FROM tbl_PM_RFITypes_TaxDetails WHERE RFITypeID = '" + Args.MasterPrimaryKeyValue + "'"
                                intCounter = CType(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)
                                If Args.IsEditMode = True Then
                                    Args.ControlCaption = Args.ControlCaption + " ( " + intCounter.ToString + " )"
                                Else
                                    Args.ControlCaption = Args.ControlCaption + " ( " + (intCounter + 1).ToString + " )"
                                End If

                            End If

                            'End of Addition

                            'Addition done by SuchitraP on 16-MAY-2007 for Cleanup Activity
                        Case CommonFunction.Constants.APP_TAG_TAB_LEAVES
                            'Dim myQuery As String = ""
                            'Dim blnIsProRataEnabled As Boolean = False
                            'myQuery = "SELECT ISNULL(IsProRataEnabled,0) FROM tbl_PM_CompanyInformation"
                            'blnIsProRataEnabled = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(myQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Boolean)
                            'If blnIsProRataEnabled = False Then
                            If CommonFunction.Application.IsProRataEnabled = False Then
                                If Args.ControlName = "ProRata" Then
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
                                If Args.ControlName = "ProRata" Then
                                    Cancel = True
                                End If
                            End If
                            'End of addition done by SuchitraP for Cleanup Activity
                    End Select
                End If
            End Sub

            Public Shared Sub After_PlotControlCaption(ByVal Args As EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing, Optional ByRef InsertAfterCaption As String = "")
                'This event will occur After plotting the Control caption

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag

                Else
                    'For Details Tag

                End If
            End Sub

            Public Shared Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
                'This event will occur before plotting the Control caption
                'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                'Cancel = False
                'End Of Modifications - IssueID : 672

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID

                        'Added by TruptiK on 25-Aug-2008
                        'Case CommonFunction.Constants.APP_TAG_AlertLevel
                        '    Dim strColorName As String
                        '    If Args.ControlName.ToUpper = "COLOR" Then
                        '        Cancel = True
                        '        'Args.IgnoreActualValue = True
                        '        Args.ControlToolTip = "Color Palette Control"
                        '        If Args.IsEditMode = True Then
                        '            strColorName = CStr(drControls.Item("Color"))
                        '        Else
                        '            strColorName = ""
                        '        End If

                        '        InsertBeforeControl = CommonFunction.HTMLControls.DrawColorPalette("ColorName", "ColorName", "clsColorPaletteTextBox", , strColorName, , , , , , , , , True, True)
                        '        Args.InsertAfterControlOption = ""
                        '        Args.Mandatory = True
                        '    End If
                        'end of addition by TruptiK
                        ''Added by PrashantSJ on 19th June 2007 Version : SEM 8.1 
                        Case CommonFunction.Constants.APP_TAG_THEME
                            If Args.ControlName.ToUpper = "EARLIERNAVIGATIONSTYLE" Then
                                If CType(CommonFunction.Data.CheckIsDBNull(drControls("EarlierNavigationStyle"), "False"), Boolean) Then
                                    Args.ToBeInserted = "checked"
                                End If
                            End If
                            ''End of addition by PrashantSJ on 19th June 2009
                        Case CommonFunction.Constants.APP_TAG_TAB_EXPENSES
                            'Added By JayavantK on 07-Oct-2004
                            Dim lngProjectID As Long = 0
                            Dim lngItemID As Long = 0
                            Dim strQuery As String = ""
                            'End Addition

                            'added by paresh B on August 24, 2004 For Expenses
                            'Load the View state of the controls only when the Project or Cost group selection is changed.
                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID")).ToString <> "" Then
                                Args.IgnoreActualValue = True
                                Args.NewValue = HttpContext.Current.Request.Form(Args.ControlName).ToString
                            End If


                            'Added By JayavantK on 07-Oct-2004
                            Select Case Args.ControlName.ToUpper
                                Case "SUBITEMID"
                                    Dim drTemp As IDataReader
                                    If Args.IsEditMode = False Then
                                        lngProjectID = CType(CommonFunction.General.CheckIsNothing("0" & HttpContext.Current.Request.QueryString("ProjectID"), "0"), Long)
                                        lngItemID = CType(CommonFunction.General.CheckIsNothing("0" & HttpContext.Current.Request.QueryString("ItemID"), "0"), Long)
                                    Else
                                        strQuery = "SELECT ProjectID, CostGroupID FROM tbl_PM_Expenses INNER JOIN tbl_CNF_CostHeads ON CostHeadID = SubItemID"
                                        strQuery = strQuery & " WHERE ExpensesEntryID = " & Args.PrimaryKeyValue.ToString()

                                        drTemp = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        If CommonFunctions.General.CheckIsNothing(drTemp, "") <> "" And drTemp.Read Then
                                            lngProjectID = CType(CommonFunction.Data.CheckIsDBNull(drTemp.Item("ProjectID"), "0"), Long)
                                            lngItemID = CType(CommonFunction.Data.CheckIsDBNull(drTemp.Item("CostGroupID"), "0"), Long)
                                        End If
                                    End If

                                    ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                    CommonFunction.Data.DisposeDataReader(drTemp)
                                    ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                    'subItemID should be linked to the Item.
                                    If lngProjectID > 0 And lngItemID > 0 Then
                                        Args.AdditionalInformation = "usp_Sel_CostHeadForExpense " & lngItemID.ToString() & ", " & lngProjectID.ToString()
                                    End If

                                Case "COSTGROUPID"
                                    If Args.IsEditMode = False Then
                                        lngProjectID = CType(CommonFunction.General.CheckIsNothing("0" & HttpContext.Current.Request.QueryString("ProjectID"), "0"), Long)
                                    Else
                                        strQuery = "SELECT ProjectID FROM tbl_PM_Expenses WHERE ExpensesEntryID = " & Args.PrimaryKeyValue.ToString()
                                        lngProjectID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Long)
                                    End If
                                    'subItemID should be linked to the Item.
                                    If lngProjectID > 0 Then
                                        Args.AdditionalInformation = "usp_Sel_CostGroupForExpense " & lngProjectID.ToString()
                                    End If

                                Case "PROJECTID"
                                    'Commented By MrugajaB on 10th June 2005
                                    'Args.AdditionalInformation = "usp_Sel_Project_For_DA_Active_InActive_Projects " + CType(HttpContext.Current.Session("intUserID"), String) + ",NULL,'" + CType(HttpContext.Current.Request.QueryString("DADate"), String) + "',''"
                                    'Args.DropDownEditSQL = "usp_Sel_Project_For_DA_Active_InActive_Projects " + CType(HttpContext.Current.Session("intUserID"), String) + ",NULL,'" + CType(HttpContext.Current.Request.QueryString("DADate"), String) + "',''"
                                    'End Addition
                                    Dim intRoleLevel As Integer
                                    Dim m_strProjectFilters As String
                                    intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intRoleLevel"), "0"), Integer)
                                    'If middle level then apply filter for Projects
                                    If intRoleLevel = 2 Then
                                        'Apply Role Access Filter for Project List
                                        m_strProjectFilters = ""
                                        Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
                                        If strFilter <> "" Then
                                            m_strProjectFilters += strFilter
                                        End If
                                        'Code Commented By DipaliS 15 July and added the following
                                        Dim strRemove As String = "ProjectID IN"
                                        m_strProjectFilters = m_strProjectFilters.Remove(0, strRemove.Length)
                                        'End Addition
                                        m_strProjectFilters = m_strProjectFilters.Replace("'", "")
                                    End If
                                    'End addition by DipaliS

                                    'Added by MrugajaB on 10th June 2005
                                    'Purpose:The sp used previously was also fetching global projects along with other projects
                                    Args.AdditionalInformation = "usp_sel_Projects_forTimesheetExpenses " + CType(HttpContext.Current.Session("intUserID"), String) + ",'" + CType(HttpContext.Current.Request.QueryString("DADate"), String) + "','" + m_strProjectFilters + "'"
                                    Args.DropDownEditSQL = "usp_sel_Projects_forTimesheetExpenses " + CType(HttpContext.Current.Session("intUserID"), String) + ",'" + CType(HttpContext.Current.Request.QueryString("DADate"), String) + "','" + m_strProjectFilters + "'"
                                    'End Additon
                            End Select
                            'End Addition
                            '##### Added By AmitD on 30 Aug 2004 - For Create Project 
                        Case CommonFunction.Constants.APP_TAG_CREATE_PROJECT
                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form(Args.ControlName)).ToString <> "" Then
                                ' Otherwise load viewState
                                Args.IgnoreActualValue = True
                                Args.NewValue = HttpContext.Current.Request.Form(Args.ControlName).ToString
                            End If

                            Select Case Args.ControlName.ToUpper
                                'intigrated by harshk for sp4 issueid 591
                                'Case "LOCATIONID"

                                '        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID")).ToString <> "" Then
                                '            'Args.IgnoreActualValue = True
                                '            Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & HttpContext.Current.Request.QueryString("BusinessGroupID").ToString
                                '            Args.DropDownEditSQL = "usp_Sel_GetBusinessGroupsForLocation " & HttpContext.Current.Request.QueryString("BusinessGroupID").ToString
                                '            Args.IgnoreActualValue = True
                                '            Args.NewValue = ""

                                '            'Args.AdditionalInformation = "Select CostHeadID, CostHead from tbl_CNF_CostHeads "
                                '        ElseIf CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("LocationID")).ToString <> "" Then

                                '            Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & HttpContext.Current.Request.Form("BusinessGroupID").ToString
                                '            Args.DropDownEditSQL = "usp_Sel_GetBusinessGroupsForLocation " & HttpContext.Current.Request.Form("BusinessGroupID").ToString

                                '        ElseIf CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("BusinessGroupID")).ToString <> "" Then

                                '            Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & HttpContext.Current.Request.Form("BusinessGroupID").ToString
                                '            Args.DropDownEditSQL = "usp_Sel_GetBusinessGroupsForLocation " & HttpContext.Current.Request.Form("BusinessGroupID").ToString

                                '        Else
                                '            ' the condition which will always return no records
                                '            Args.AdditionalInformation = "Select LocationID, Location From tbl_PM_Location Where LocationID = -1"
                                '            Args.DropDownEditSQL = "Select LocationID, Location From tbl_PM_Location Where LocationID = -1"

                                '        End If

                                '        'Added by AbhijitD on 22 Aug 2005 for Project Creation Page
                                '        ''Delivery Unit
                                '    Case "RESOURCEPOOLID"
                                '        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("LocationID")).ToString <> "" Then
                                '            Args.AdditionalInformation = "usp_Sel_GetResourcePoolForLocation " & HttpContext.Current.Request.Form("LocationID").ToString
                                '            Args.DropDownEditSQL = Args.AdditionalInformation
                                '            'If business Group ID is changed that indicates there is no value in OU Combo.
                                '            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID")).ToString <> "" Then
                                '                Args.AdditionalInformation = "SELECT ResourcePoolID, ResourcePoolName FROM tbl_PM_ResourcePool Where ResourcePoolID = -1"
                                '                Args.DropDownEditSQL = Args.AdditionalInformation
                                '            End If

                                '        Else
                                '            Args.AdditionalInformation = "SELECT ResourcePoolID, ResourcePoolName FROM tbl_PM_ResourcePool Where ResourcePoolID = -1"
                                '            Args.DropDownEditSQL = Args.AdditionalInformation

                                '        End If


                                '        'Added by SantoshK on 27 Sept 2005 for Project Creation Page
                                '        'Delivery Team
                                '    Case "RESOURCEGROUPID"
                                '        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ResourcePoolID")).ToString <> "" Then
                                '            Args.AdditionalInformation = " SELECT G.GroupID,G.GroupName FROM tbl_PM_GroupMaster  G INNER JOIN tbl_PM_ResourcePool_Teams P " & _
                                '                                            "ON P.GroupID = G.GroupID WHERE P.ResourcePoolID =  " & HttpContext.Current.Request.Form("ResourcePoolID").ToString
                                '            Args.DropDownEditSQL = Args.AdditionalInformation
                                '            'If business Group ID or OU is changed that indicates there is no value in DU Combo.
                                '            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID")).ToString <> "" Or CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("LocationID")).ToString <> "" Then
                                '                Args.AdditionalInformation = "SELECT GroupID, GroupName FROM tbl_PM_GroupMaster Where GroupID = -1"
                                '                Args.DropDownEditSQL = Args.AdditionalInformation
                                '            End If

                                '        Else
                                '            Args.AdditionalInformation = "SELECT GroupID, GroupName FROM tbl_PM_GroupMaster Where GroupID = -1"
                                '            Args.DropDownEditSQL = Args.AdditionalInformation

                                '        End If
                                'end intigrated by harshk for sp4 issueid 591
                                '*******************************************
                                Case "LOCATIONID"
                                    'modified by harshk for sp4 issueid 591 on 18/10/2005
                                    Dim strTempLocationID As String, strTempBGID As String, strPractice As String
                                    strPractice = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectType")).ToString
                                    strTempBGID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID")).ToString
                                    If strTempBGID <> "" Then
                                        'Integrated by SandipL SP8 to SP9

                                        'Modified by SandipL on 06 April 2007
                                        'populate onle Active Locations
                                        'Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & strTempBGID
                                        Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & strTempBGID & ",NULL,0"
                                        'End modifications by SandipL
                                        If strPractice = "" Then
                                            Args.IgnoreActualValue = True
                                            Args.NewValue = ""
                                        End If
                                    Else
                                        strTempBGID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("BusinessGroupID")).ToString
                                        If strTempBGID <> "" Then
                                            'Modified by SandipL on 06 April 2007
                                            'populate onle Active Locations
                                            'Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & strTempBGID
                                            Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & strTempBGID & ",NULL,0"
                                            'End modifications by SandipL
                                            'End Integration by SandipL SP8 to SP9
                                        Else
                                            ' the condition which will always return no records
                                            Args.AdditionalInformation = "Select LocationID, Location From tbl_PM_Location Where LocationID = -1"
                                        End If
                                    End If
                                    'End modified by harshk for sp4 issueid 591 on 18/10/2005
                                    'Added by ShraddhaM on 17,Sept 2008
                                    'Purpose : To create project when opportunity is closed in Whiziblesem8.0
                                    Dim OpportunityID As String
                                    Dim FromWhere As String
                                    Dim strQuery As String
                                    Dim dr As IDataReader
                                    Dim strOU As String
                                    Dim strBG As String

                                    FromWhere = HttpContext.Current.Request.QueryString("From")
                                    If FromWhere Is Nothing Then
                                        FromWhere = HttpContext.Current.Request.Form("hidFrom")
                                    End If
                                    If FromWhere = "DEMAND" Then
                                        OpportunityID = HttpContext.Current.Request.QueryString("opportunityID")
                                        If OpportunityID Is Nothing Then
                                            OpportunityID = HttpContext.Current.Request.Form("hidOppID")
                                        End If
                                        strOU = HttpContext.Current.Request.Form("LOCATIONID")
                                        If strOU Is Nothing Then
                                            strQuery = "SELECT LocationID,BusinessGroupID FROM tbl_RM_Opportunity WHERE OpportunityID = " + OpportunityID
                                            dr = CommonFunction.Data.GetDataReader(strQuery, True)
                                            If dr.Read() Then
                                                strOU = dr("LocationID").ToString
                                                strBG = dr("BusinessGroupID").ToString
                                            End If
                                            CommonFunction.Data.DisposeDataReader(dr)
                                        End If
                                        If Not HttpContext.Current.Request.Form("BusinessGroupID") Is Nothing Then
                                            strBG = HttpContext.Current.Request.Form("BusinessGroupID")
                                        End If
                                        If strBG <> "" Then
                                            Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & strBG & ",NULL,0"
                                        Else
                                            Args.AdditionalInformation = "Select LocationID, Location From tbl_PM_Location Where LocationID = -1"
                                        End If

                                        Args.IgnoreActualValue = True
                                        Args.NewValue = strOU

                                    End If

                                    'End of addition by ShraddhaM on 17,Sept 2008
                                    'added by harshK for sp4 issueid 591 on 18/10/2005
                                Case "RESOURCEPOOLID"
                                    Dim strTempLocationID As String, strTempBGID As String, strPractice As String
                                    strTempLocationID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("LocationID")).ToString
                                    strTempBGID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID")).ToString
                                    strPractice = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectType")).ToString
                                    If strTempBGID <> "" And strPractice = "" Then
                                        Args.AdditionalInformation = "usp_Sel_GetResourcePoolForLocation -1"
                                    ElseIf strTempLocationID <> "" Then
                                        'Integrated by SandipL SP8 to SP9

                                        'Modified by SandipL on 06 April 2007
                                        'populate onle Active DUs
                                        'Args.AdditionalInformation = "usp_Sel_GetResourcePoolForLocation " & strTempLocationID
                                        Args.AdditionalInformation = "usp_Sel_GetResourcePoolForLocation " & strTempLocationID & ",0"
                                        Args.IgnoreActualValue = True
                                        Args.NewValue = ""
                                    Else
                                        strTempLocationID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("LocationID")).ToString
                                        'Modified by SandipL on 06 April 2007
                                        'populate onle Active DUs
                                        'Args.AdditionalInformation = "usp_Sel_GetResourcePoolForLocation " & strTempLocationID
                                        If strTempLocationID <> "" Then
                                            Args.AdditionalInformation = "usp_Sel_GetResourcePoolForLocation " & strTempLocationID & ",0"
                                        Else
                                            ' Will not return any record
                                            Args.AdditionalInformation = "usp_Sel_GetResourcePoolForLocation "
                                        End If
                                        'End Integration by SandipL SP8 to SP9
                                    End If
                                    'aDDED BY TRUPTIk
                                Case "CUSTOMERID"
                                    Dim strTempLocationID As String, strTempBGID As String, strPractice As String
                                    strPractice = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectType")).ToString
                                    strTempBGID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID")).ToString
                                    'strTempLocationID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("LocationID")).ToString
                                    strTempLocationID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("LocationID")).ToString

                                    'If strTempLocationID = "" Or strTempLocationID Is Nothing Then
                                    '    strTempLocationID = "NULL"
                                    'End If
                                    If strTempBGID = "" Then
                                        strTempBGID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("BusinessGroupID")).ToString
                                    End If
                                    If strTempBGID <> "" Then
                                        If strTempLocationID = "" Or strTempLocationID Is Nothing Then
                                            strTempLocationID = "NULL"
                                        End If
                                        'Integrated by SandipL SP8 to SP9

                                        'Modified by SandipL on 06 April 2007
                                        'populate onle Active Locations
                                        'Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & strTempBGID
                                        Args.AdditionalInformation = "usp_Sel_tbl_PM_Customer_ForProject NULL,NULL," & strTempBGID & ", " & strTempLocationID & ",NULL"
                                        'Args.AdditionalInformation = "usp_Sel_tbl_PM_Customer NULL,NULL," & strTempBGID & ", NULL,NULL"
                                        'End modifications by SandipL
                                        If strPractice = "" Then
                                            Args.IgnoreActualValue = True
                                            Args.NewValue = ""
                                        End If

                                    Else
                                        strTempBGID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("BusinessGroupID")).ToString
                                        'strTempLocationID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("LocationID")).ToString
                                        If strTempBGID <> "" Then
                                            'Modified by SandipL on 06 April 2007
                                            'populate onle Active Locations
                                            'Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & strTempBGID
                                            Args.AdditionalInformation = "usp_Sel_tbl_PM_Customer_ForProject NULL,NULL," & strTempBGID & ", " & strTempLocationID & ",NULL"
                                            'Args.AdditionalInformation = "usp_Sel_tbl_PM_Customer NULL,NULL," & strTempBGID & ", NULL,NULL"
                                            'End modifications by SandipL
                                            'End Integration by SandipL SP8 to SP9
                                        Else
                                            ' the condition which will always return no records
                                            Args.AdditionalInformation = "EXEC usp_Sel_tbl_PM_Customer_ForProject"
                                        End If
                                    End If
                                    'END OF ADDITION BY tRUPTIk
                                    'Added by ShraddhaM on 17,Sept 2008
                                    'Purpose : To create project when opportunity is closed in Whiziblesem8.0
                                    Dim OpportunityID As String
                                    Dim CustomerID As String
                                    Dim FromWhere As String
                                    FromWhere = HttpContext.Current.Request.QueryString("From")
                                    If FromWhere Is Nothing Then
                                        FromWhere = HttpContext.Current.Request.Form("hidFrom")
                                    End If
                                    If FromWhere = "DEMAND" Then
                                        OpportunityID = HttpContext.Current.Request.QueryString("opportunityID")
                                        If OpportunityID Is Nothing Then
                                            OpportunityID = HttpContext.Current.Request.Form("hidOppID")
                                        End If
                                        CustomerID = HttpContext.Current.Request.QueryString("CustomerID")
                                        If CustomerID Is Nothing Then
                                            CustomerID = HttpContext.Current.Request.Form("hidCustomerID")
                                        End If

                                        Args.IgnoreActualValue = True
                                        Args.NewValue = CustomerID
                                    End If
                                    'End of addition by ShraddhaM on 17,Sept 2008
                                Case "RESOURCEGROUPID"
                                    Dim strTempLocationID As String, strTempBGID As String, strDUID As String, strPractice As String
                                    strTempLocationID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("LocationID")).ToString
                                    strTempBGID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID")).ToString
                                    strDUID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RESOURCEPOOLID")).ToString
                                    strPractice = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectType")).ToString
                                    If (strTempBGID <> "" Or strTempLocationID <> "") And strPractice = "" Then
                                        Args.AdditionalInformation = "usp_sel_GetDeliverayTeam -1"
                                    ElseIf strDUID <> "" Then
                                        'Integrated by SandipL SP8 to SP9

                                        'Modified by SandipL on 06 April 2007
                                        'populate onle Active DUs
                                        'Args.AdditionalInformation = "usp_sel_GetDeliverayTeam " & strDUID
                                        Args.AdditionalInformation = "usp_sel_GetDeliverayTeam " & strDUID & ",0"
                                        Args.IgnoreActualValue = True
                                        Args.NewValue = ""
                                    Else
                                        strDUID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("RESOURCEPOOLID")).ToString
                                        'Args.AdditionalInformation = "usp_sel_GetDeliverayTeam " & strDUID
                                        If strDUID <> "" Then
                                            Args.AdditionalInformation = "usp_sel_GetDeliverayTeam " & strDUID & ",0"
                                        Else
                                            'Will not return any record
                                            Args.AdditionalInformation = "usp_sel_GetDeliverayTeam "
                                        End If

                                        ' End modifications by SandipL on 06 April 2007
                                        'End Integration by SandipL SP8 to SP9
                                    End If
                                    'End added by harshK for sp4 issueid 591
                                    'Added by ShamkantD on 7 Oct 2004 - added for Non database control - Project Type
                                Case "NONDATABASE1"
                                    Dim strPracticeName As String = ""
                                    Dim strMainProjectType As String = ""
                                    strPracticeName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ProjectType"), "").ToString()
                                    If strPracticeName.Trim() <> "" Then
                                        strMainProjectType = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("EXEC usp_Sel_tbl_PRS_Main_ProjectType_For_Practice '" & CommonFunction.General.BuildQueryString(strPracticeName) & "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
                                    End If
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = strMainProjectType
                                    'End of addition - ShamkantD on 7 Oct 2004

                                    'Added By PrachiK on 7 Mar 2005 for Issue ID 16666. 
                                    'Purpose: The value of Billable Field changes from true to false when project is revised.
                                    'Issueid 16438
                                    'Purpose:While creating Project,Checkbox for 'Billable' becomes false when we select a Business Group
                                Case "BILLABLE"
                                    'Modified by SiddharthS on 4 Apr 2005
                                    'If Args.IsEditMode = False Then
                                    If HttpContext.Current.Request.Form("Billable") = "on" Then

                                        Args.ToBeInserted = "checked"

                                    End If
                                    'End of Addtion 
                                    'End If
                                    'end modification.
                                    'Added by ShraddhaM on 17,Sept 2008
                                    'Purpose : To create project when opportunity is closed in Whiziblesem8.0
                                Case "PROJECTNAME"
                                    Dim OpportunityID As String
                                    Dim CustomerName As String
                                    Dim FromWhere As String
                                    FromWhere = HttpContext.Current.Request.QueryString("From")
                                    If FromWhere Is Nothing Then
                                        FromWhere = HttpContext.Current.Request.Form("hidFrom")
                                    End If
                                    If FromWhere = "DEMAND" Then
                                        OpportunityID = HttpContext.Current.Request.QueryString("opportunityID")
                                        If OpportunityID Is Nothing Then
                                            OpportunityID = HttpContext.Current.Request.Form("hidOppID")
                                        End If
                                        CustomerName = HttpContext.Current.Request.QueryString("CustomerName")
                                        If CustomerName Is Nothing Then
                                            'CustomerName = HttpContext.Current.Request.Form("hidCustomerName")
                                            CustomerName = HttpContext.Current.Request.Form("ProjectName")
                                        End If

                                        Args.IgnoreActualValue = True
                                        Args.NewValue = CustomerName
                                    End If

                                Case "EXPECTEDSTARTDATE"
                                    Dim OpportunityID As String
                                    Dim FromWhere As String
                                    Dim strQuery As String
                                    Dim dr As IDataReader
                                    Dim strStartDate As String
                                    Dim strEndDate As String

                                    FromWhere = HttpContext.Current.Request.QueryString("From")
                                    If FromWhere Is Nothing Then
                                        FromWhere = HttpContext.Current.Request.Form("hidFrom")
                                    End If
                                    If FromWhere = "DEMAND" Then
                                        OpportunityID = HttpContext.Current.Request.QueryString("opportunityID")
                                        If OpportunityID Is Nothing Then
                                            OpportunityID = HttpContext.Current.Request.Form("hidOppID")
                                        End If

                                        strStartDate = HttpContext.Current.Request.Form("EXPECTEDSTARTDATE")

                                        If strStartDate Is Nothing Then
                                            strQuery = "SELECT Replace ( Convert( varchar, ApproxStartDate , 106) , ' ' , '-') ApproxStartDate FROM tbl_RM_Opportunity WHERE OpportunityID = " + OpportunityID
                                            dr = CommonFunction.Data.GetDataReader(strQuery, True)
                                            If dr.Read() Then
                                                strStartDate = dr("ApproxStartDate").ToString
                                                'strEndDate = dr("ApproxEndDate").ToString
                                            End If
                                            CommonFunction.Data.DisposeDataReader(dr)
                                        End If

                                        Args.IgnoreActualValue = True
                                        Args.NewValue = strStartDate
                                    End If
                                Case "EXPECTEDENDDATE"
                                    Dim OpportunityID As String
                                    Dim FromWhere As String
                                    Dim strQuery As String
                                    Dim dr As IDataReader
                                    Dim strStartDate As String
                                    Dim strEndDate As String
                                    FromWhere = HttpContext.Current.Request.QueryString("From")
                                    If FromWhere Is Nothing Then
                                        FromWhere = HttpContext.Current.Request.Form("hidFrom")
                                    End If
                                    If FromWhere = "DEMAND" Then
                                        OpportunityID = HttpContext.Current.Request.QueryString("opportunityID")
                                        If OpportunityID Is Nothing Then
                                            OpportunityID = HttpContext.Current.Request.Form("hidOppID")
                                        End If
                                        strEndDate = HttpContext.Current.Request.Form("EXPECTEDENDDATE")
                                        If strEndDate Is Nothing Then
                                            strQuery = "SELECT Replace ( Convert( varchar, ApproxEndDate , 106) , ' ' , '-') ApproxEndDate FROM tbl_RM_Opportunity WHERE OpportunityID = " + OpportunityID
                                            dr = CommonFunction.Data.GetDataReader(strQuery, True)
                                            If dr.Read() Then
                                                'strStartDate = dr("ApproxStartDate").ToString
                                                strEndDate = dr("ApproxEndDate").ToString
                                            End If
                                            CommonFunction.Data.DisposeDataReader(dr)
                                        End If
                                        Args.IgnoreActualValue = True
                                        Args.NewValue = strEndDate
                                    End If
                                Case "BUSINESSGROUPID"
                                    Dim OpportunityID As String
                                    Dim FromWhere As String
                                    Dim strQuery As String
                                    Dim dr As IDataReader
                                    Dim strBG As String

                                    FromWhere = HttpContext.Current.Request.QueryString("From")
                                    If FromWhere Is Nothing Then
                                        FromWhere = HttpContext.Current.Request.Form("hidFrom")
                                    End If
                                    If FromWhere = "DEMAND" Then
                                        OpportunityID = HttpContext.Current.Request.QueryString("opportunityID")
                                        If OpportunityID Is Nothing Then
                                            OpportunityID = HttpContext.Current.Request.Form("hidOppID")
                                        End If
                                        strBG = HttpContext.Current.Request.Form("BUSINESSGROUPID")
                                        If strBG Is Nothing Then
                                            strQuery = "SELECT BusinessGroupID FROM tbl_RM_Opportunity WHERE OpportunityID = " + OpportunityID
                                            dr = CommonFunction.Data.GetDataReader(strQuery, True)
                                            If dr.Read() Then
                                                strBG = dr("BusinessGroupID").ToString
                                            End If
                                            CommonFunction.Data.DisposeDataReader(dr)
                                        End If
                                        Args.IgnoreActualValue = True
                                        'Args.AdditionalInformation = "usp_Sel_tbl_CNF_BusinessGroup 1,NULL,'DEMAND'," + strBG
                                        'Args.DropDownEditSQL = "usp_Sel_tbl_CNF_BusinessGroup 1,NULL,'DEMAND'," + strBG

                                        Args.NewValue = strBG
                                    End If

                            End Select
                        Case CommonFunction.Constants.APP_TAG_CUSTOMER_MASTER
                            Select Case Args.ControlName.ToUpper
                                Case "CUSTOMERNAME"
                                    Dim OpportunityID As String
                                    Dim CustomerName As String
                                    Dim FromWhere As String
                                    FromWhere = HttpContext.Current.Request.QueryString("From")
                                    If FromWhere Is Nothing Then
                                        FromWhere = HttpContext.Current.Request.Form("hidFrom")
                                    End If
                                    If FromWhere = "DEMAND" Then
                                        'OpportunityID = HttpContext.Current.Request.QueryString("opportunityID")
                                        'If OpportunityID Is Nothing Then
                                        '    OpportunityID = HttpContext.Current.Request.Form("hidOppID")
                                        'End If
                                        CustomerName = HttpContext.Current.Request.QueryString("CustomerName")
                                        If CustomerName Is Nothing Then
                                            CustomerName = HttpContext.Current.Request.Form("hidCustomerName")
                                        End If

                                        Args.IgnoreActualValue = True
                                        Args.NewValue = CustomerName
                                    End If

                                    'End of addition by ShraddhaM on 17,Sept 2008
                            End Select

                            '##### End Addition

                        Case CommonFunction.Constants.APP_TAG_TAB_RATE_CONTRACT
                            'Added By Paresh B on August 4, 2004 For Rate Contract page
                            Select Case Args.ControlName.ToUpper
                                Case "HTML TAG1"
                                    Dim strSQL As String
                                    Dim drCurrency As IDataReader
                                    strSQL = "SELECT CurrencyName FROM tbl_pm_Project, tbl_PM_CurrencyMaster WHERE tbl_pm_Project.BaseCurrency = tbl_PM_CurrencyMaster.CurrencyID and ProjectID = " & HttpContext.Current.Session("IntProjectId").ToString
                                    drCurrency = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If drCurrency.Read() Then
                                        Args.HTMLTag = "<B>" & CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                                    End If
                                    drCurrency = Nothing

                                    ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                    CommonFunction.Data.DisposeDataReader(drCurrency)
                                    ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                    'Added by ShamkantD on 23rd August 2004
                                Case "CEILINGAMOUNT"

                                    If drControls.Read = True Then   '--added by paresh b

                                        If CommonFunction.General.CheckIsNothing(drControls("CeilingAmount")).ToString <> "" Then
                                            Args.IgnoreActualValue = True
                                            Args.NewValue = FormatNumber(CType(drControls("CeilingAmount"), Double), 2, , , TriState.False)
                                        End If
                                    End If
                                Case "OVERTIMEMULTIFACTOR"
                                    Args.IgnoreActualValue = True
                                    If CommonFunction.General.CheckIsNothing(drControls("OvertimeMultiFactor")).ToString <> "" Then
                                        Args.NewValue = FormatNumber(CType(drControls("OvertimeMultiFactor"), Double), 2, , , TriState.False)
                                    End If
                                    'End of Addition - ShamkantD on 23rd August 2004
                            End Select
                            'prachi
                        Case CommonFunction.Constants.APP_TAG_PM_PROJECT_INFORMATION
                            If Args.ControlName.ToUpper = "BILLABLE" Then
                                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("Billable")).ToString <> "" Then
                                    If HttpContext.Current.Request.Form("Billable") = "on" Then
                                        Args.ToBeInserted = "checked"

                                    End If
                                Else
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = "off"
                                    Args.ToBeInserted = ""
                                End If
                            End If

                        Case CommonFunction.Constants.APP_TAG_RESOURCES
                            'Added by ShraddhaM on 17,Sept 2008
                            'Purpose : Resource Allocation from advanced searched resources in Whiziblesem8.0
                            Dim ProjectID As String
                            'Added by SanaS on 25-Sep-2009 for Resource Allocation Changes
                            Dim intEnableProjectResourceAllocation As Integer
                            Dim intAllowResourceAllocation As Integer
                            'End addition by SanaS on 25-Sep-2009 for Resource Allocation Changes
                            If HttpContext.Current.Request.QueryString("FromADSEARCH") = "1" Then
                                ProjectID = HttpContext.Current.Request.QueryString("PRJID")
                            Else
                                ProjectID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")
                            End If
                            'Added by SanaS on 25-Sep-2009 for Resource Allocation Changes
                            If CommonFunction.Application.AllowResourceAllocation Then
                                intAllowResourceAllocation = 1
                            Else
                                intAllowResourceAllocation = 0
                            End If

                            If intAllowResourceAllocation = 0 Then
                                intEnableProjectResourceAllocation = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_IsProjectResourceAllocation " + WhizGlobal.ProjectID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                            Else
                                intEnableProjectResourceAllocation = 0
                            End If
                            'End Addition by SanaS on 25-Sep-2009 for Resource Allocation Changes
                            Dim PKValue As String
                            PKValue = HttpContext.Current.Request.QueryString("PRJID")
                            If PKValue Is Nothing Then
                                PKValue = HttpContext.Current.Request.Form("hidPKValue")
                            End If
                            If PKValue <> "" Then
                                If Not Args.IsEditMode Then

                                    Select Case Args.ControlName.ToUpper
                                        Case "NONDATABASE1"
                                            Args.DefaultValue = "1-" + HttpContext.Current.Request.QueryString("EmployeeName")
                                        Case "EMPLOYEEID"
                                            Args.DefaultValue = "1-" + HttpContext.Current.Request.QueryString("EMPID")
                                        Case "ROLE"
                                            Args.DefaultValue = "1-" + HttpContext.Current.Request.QueryString("RoleID")
                                        Case "EXPECTEDSTARTDATE"
                                            Args.DefaultValue = "1-" + HttpContext.Current.Request.QueryString("SD")
                                        Case "EXPECTEDENDDATE"
                                            Args.DefaultValue = "1-" + HttpContext.Current.Request.QueryString("ED")
                                        Case "RESOURCEPERCENTAGE"
                                            'COMMENTED AND added by SanaS on 23-Nov-2009
                                            'Args.DefaultValue = "1-" + HttpContext.Current.Request.QueryString("RECPER")
                                            Dim drAllocation As IDataReader
                                            Dim strSQL As String = ""

                                            Dim strStartDate As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SD"), "")
                                            Dim strEndDate As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ED"), "")
                                            Dim strProjectID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PRJID"), "")
                                            Dim strEmployeeID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmpID"), "")
                                            If strStartDate <> "" And strEndDate <> "" And strEmployeeID <> "" Then
                                                strSQL = "usp_sel_FreeHours_ChangeAllocation "
                                                strSQL += " '" + CommonFunction.Dates.GetDate(CType(strStartDate, Date)) + "'"
                                                strSQL += ",'" + CommonFunction.Dates.GetDate(CType(strEndDate, Date)) + "'"
                                                strSQL += "," + strEmployeeID
                                                strSQL += "," + strProjectID
                                                drAllocation = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                                If drAllocation.Read Then
                                                    'Args.DefaultValue = "1-" + HttpContext.Current.Request.QueryString("RECPER")
                                                    Args.DefaultValue = "1-" + CType(CommonFunction.Data.CheckIsDBNull(drAllocation("MinimumPercentage"), "0.0"), String)
                                                Else
                                                    Args.DefaultValue = "1-" + HttpContext.Current.Request.QueryString("RECPER")
                                                End If
                                                CommonFunctions.Data.DisposeDataReader(drAllocation)
                                            Else
                                                Args.DefaultValue = "1-" + HttpContext.Current.Request.QueryString("RECPER")
                                            End If
                                            'End addition by SanaS on 23-Nov-2009

                                            'Args.DefaultValue = "1-0"
                                        Case "NONDATABASE3"
                                            Args.DefaultValue = "1-" + HttpContext.Current.Request.QueryString("JDATE")
                                        Case "NONDATABASE6"
                                            Args.DefaultValue = "1-" + HttpContext.Current.Request.QueryString("TENDATE")
                                        Case "PROJECTID"
                                            Args.DefaultValue = "1-" + ProjectID
                                        Case "NONDATABASE4"
                                            Args.DefaultValue = "2-SELECT Replace ( Convert( varchar, ExpectedStartDAte , 106) , ' ' , '-') FROM tbl_PM_Project WHERE ProjectID =" + ProjectID
                                        Case "NONDATABASE5"
                                            Args.DefaultValue = "2-SELECT Replace ( Convert( varchar, ExpectedEndDAte , 106) , ' ' , '-') FROM tbl_PM_Project WHERE ProjectID =" + ProjectID
                                            'Case "RESOURCEPERCENTAGE"
                                            '    Args.DefaultValue = "1-" + HttpContext.Current.Request.QueryString("RECPER")
                                            '    'Args.DefaultValue = "1-0"

                                    End Select
                                End If
                            End If
                            'End of addition by ShraddhaM on 17,Sept 2008
                            'RESOURCES
                            Select Case Args.ControlName.ToUpper
                                Case "EXPECTEDENDDATE"
                                    If Not Args.IsEditMode Then
                                        'For ADD NEW MODE
                                        Dim strSQL As String

                                        strSQL = "usp_sel_tbl_PM_Project_ExpectedEndDate " + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")
                                        Dim ExpectedEndDate As String = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
                                        If ExpectedEndDate <> "" Then
                                            'If Project Expected End Date is less than Current Date then set the Resource Expected End Date as blank else set it as Project Expected End Date
                                            If DateDiff(DateInterval.Day, CType(ExpectedEndDate, Date), Date.Now) > 0 Then
                                                Args.DefaultValue = ""
                                            Else
                                                If Not PKValue <> "" Then
                                                    Args.DefaultValue = "1-" + CommonFunction.Dates.GetDate(CType(ExpectedEndDate, Date))
                                                End If
                                                'Args.DefaultValue = "1-" + CommonFunction.Dates.GetDate(CType(ExpectedEndDate, Date))
                                            End If
                                        End If
                                    End If
                                    'Modified By VidyaJ - Resources - SP4 - IssueID - 85
                                    'Get whethere resource allocation workflow is applicable or not from application variable

                                    'Dim drResource As IDataReader
                                    Dim blnAllocation As Boolean
                                    'Dim strSQLs As String
                                    'strSQLs = "SELECT AllowResourceAllocation from tbl_PM_CompanyInformation"
                                    blnAllocation = CommonFunction.Application.AllowResourceAllocation 'CType(CommonFunction.Data.GetDataScalar(strSQLs, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Boolean)
                                    'Modified by SanaS on 25-Sep-2009 for Resource Allocation Changes
                                    If blnAllocation = True Then
                                        Args.DisableInEditMode = True
                                    ElseIf intEnableProjectResourceAllocation = 1 Then
                                        If Args.IsEditMode = True Then
                                            If IsDBNull(drControls("ActualEndDate")) Then
                                                Args.DisableInEditMode = True
                                            End If
                                        End If
                                    End If
                                    'End Modification by SanaS on 25-Sep-2009 for Resource Allocation Changes
                                    ' CommonFunction.Data.DisposeDataReader(drResource)
                                    'End Of Modifications
                                Case "EXPECTEDSTARTDATE"
                                    Dim drResource As IDataReader
                                    Dim blnAllocation As Boolean
                                    'Modified By VidyaJ - Resources - SP4 - IssueID - 85
                                    'Get whethere resource allocation workflow is applicable or not from application variable
                                    ' strSQLs = "SELECT AllowResourceAllocation from tbl_PM_CompanyInformation"
                                    blnAllocation = CommonFunction.Application.AllowResourceAllocation   'CType(CommonFunction.Data.GetDataScalar(strSQLs, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Boolean)
                                    'Modified by SanaS on 25-Sep-2009 for Resource Allocation Changes
                                    If blnAllocation = True Then
                                        Args.DisableInEditMode = True
                                    ElseIf intEnableProjectResourceAllocation = 1 Then
                                        If Args.IsEditMode = True Then
                                            If IsDBNull(drControls("ActualEndDate")) Then
                                                Args.DisableInEditMode = True
                                            End If
                                        End If
                                    End If
                                    'End Modification by SanaS on 25-Sep-2009 for Resource Allocation Changes
                                    'End Of Modifications

                                Case "BUDGETEDHOURS"
                                    'Modified By VidyaJ - Performance Issue - Resources - IssueID - 85
                                    'Get whethere resource allocation workflow is applicable or not from application variable

                                    'Dim drResource As IDataReader
                                    Dim blnAllocation As Boolean
                                    'Dim strSQLs As String
                                    'strSQLs = "SELECT AllowResourceAllocation from tbl_PM_CompanyInformation"
                                    blnAllocation = CommonFunction.Application.AllowResourceAllocation  'CType(CommonFunction.Data.GetDataScalar(strSQLs, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Boolean)
                                    'Modified by SanaS on 25-Sep-2009 for Resource Allocation Changes 
                                    If blnAllocation = True Then
                                        Args.DisableInEditMode = True
                                    ElseIf intEnableProjectResourceAllocation = 1 Then
                                        If Args.IsEditMode = True Then
                                            If IsDBNull(drControls("ActualEndDate")) Then
                                                Args.DisableInEditMode = True
                                            End If
                                        End If
                                    End If
                                    'End Modification by SanaS on 25-Sep-2009 for Resource Allocation Changes
                                    ' CommonFunction.Data.DisposeDataReader(drResource)
                                Case "REPORTINGTO"
                                    Dim strSQLs As String
                                    Dim strSQL As String
                                    ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                    'Dim drGetDefaultApprover As IDataReader
                                    ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                    Dim strDefaultApprover As String
                                    Dim strApprover As String

                                    'Commented and Added by ShraddhaM on 17,Sept 2008
                                    'Purpose : Resource Allocation from advanced searched resources in Whiziblesem8.0
                                    'strSQL = "SELECT EmployeeID From tbl_PM_ProjectEmployeeRole WHERE ProjectID = " + CType(HttpContext.Current.Session("intProjectID"), String) + " AND IsDefaultApprover = 1"
                                    strSQL = "SELECT EmployeeID From tbl_PM_ProjectEmployeeRole WHERE ProjectID = " + ProjectID + " AND IsDefaultApprover = 1"
                                    'End of Commented and Added by ShraddhaM on 17,Sept 2008

                                    strDefaultApprover = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), String)
                                    If IsNothing(strDefaultApprover) Then
                                        strDefaultApprover = ""
                                    End If

                                    If Args.IsEditMode = True Then
                                        'If drControls.Read Then
                                        'If CType(drControls("employeeid"), String) <> "" Then
                                        'strsqls = "usp_Sel_tbl_PM_Employee_Project_Resources " + WhizGlobal.ProjectID.ToString + "," + CType(drControls("employeeid"), String)

                                        'Commented and modified by MrugajaB on 10th July 2006 for WhizibleSEM SP7 Issue ID.4582
                                        'strSQLs = "usp_sel_tbl_PM_RowWiseApprovers  " + CType(HttpContext.Current.Session("intProjectID"), String)

                                        'Commented and Added by ShraddhaM on 17,Sept 2008
                                        'Purpose : Resource Allocation from advanced searched resources in Whiziblesem8.0
                                        'strSQLs = "usp_sel_tbl_PM_RowWiseExternalApprovers " + CType(HttpContext.Current.Session("intProjectID"), String)
                                        strSQLs = "usp_sel_tbl_PM_RowWiseExternalApprovers " + ProjectID
                                        'End of Commented and Added by ShraddhaM on 17,Sept 2008



                                        'End Modification
                                        Args.StoredProcedureName = strSQLs
                                        Args.DropDownEditSQL = strSQLs

                                        'strSQL = "Select ReportingTo From tbl_PM_ProjectEmployeeRole Where ProjectID = " + CType(HttpContext.Current.Session("intProjectID"), String) + " AND EmployeeID = " + CType(Args.PrimaryKeyValue, String)
                                        ' End If
                                        'End If
                                    Else

                                        'Adde By NileshD on 08/06/04
                                        'For New mode change the sp parameters.
                                        'strsqls = "usp_Sel_tbl_PM_Employee_Project_Resources " + WhizGlobal.ProjectID.ToString

                                        'Commented and modified by MrugajaB on 10th July 2006 for WhizibleSEM SP7 Issue ID.4582
                                        'strSQLs = "usp_sel_tbl_PM_RowWiseApprovers " + CType(HttpContext.Current.Session("intProjectID"), String)

                                        'Commented and Added by ShraddhaM on 17,Sept 2008
                                        'Purpose : Resource Allocation from advanced searched resources in Whiziblesem8.0
                                        'strSQLs = "usp_sel_tbl_PM_RowWiseExternalApprovers " + CType(HttpContext.Current.Session("intProjectID"), String)
                                        strSQLs = "usp_sel_tbl_PM_RowWiseExternalApprovers " + ProjectID
                                        'End of Commented and Added by ShraddhaM on 17,Sept 2008

                                        Args.StoredProcedureName = strSQLs
                                        'Commented and modified by MrugajaB on 10th July 2006 for WhizibleSEM SP7 Issue ID.4582
                                        'Args.DropDownEditSQL = strSQLs
                                        Args.AdditionalInformation = strSQLs
                                        'End Modification
                                        Args.IgnoreActualValue = True
                                        Args.NewValue = strDefaultApprover

                                        'End Addition
                                    End If


                                    Args.FunctionCall = "OnChange=javascript:Approver_OnChange();"

                                    '##### Case For Controls Added For Resource Timesheet Flow
                                    'Code Added By MangeshY on 22 July 2004 : Donot show the two controls if Timesheet workflow is switched off at company level
                                Case "ISDEFAULTAPPROVER"
                                    Dim strSQL As String
                                    Dim drResource As IDataReader

                                    strSQL = "Exec usp_Sel_tbl_PM_ProjectEmployeeRole " + CType(HttpContext.Current.Request.QueryString("ProjectEmployeeRoleId_PK"), String)

                                    drResource = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                    While (drResource.Read)
                                        If Not IsDBNull(drResource("ActualEndDate")) Then
                                            Select Case Args.ControlName.ToUpper
                                                Case "ISDEFAULTAPPROVER"
                                                    Args.Editable = False
                                            End Select
                                        End If
                                    End While

                                    CommonFunctions.Data.DisposeDataReader(drResource)

                                    Args.FunctionCall = "OnClick=javascript:Approver_OnClick();"
                                    'End Addition
                                    'Added by SanaS on 25-Sep-2009 for Resource allocation Changes
                                Case "RESOURCEPERCENTAGE"

                                    Dim blnAllocation As Boolean
                                    'Dim strSQLs As String
                                    'strSQLs = "SELECT AllowResourceAllocation from tbl_PM_CompanyInformation"
                                    blnAllocation = CommonFunction.Application.AllowResourceAllocation  'CType(CommonFunction.Data.GetDataScalar(strSQLs, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Boolean)
                                    If blnAllocation = True Then
                                        Args.DisableInEditMode = True
                                    ElseIf intEnableProjectResourceAllocation = 1 Then
                                        If Args.IsEditMode = True Then
                                            If IsDBNull(drControls("ActualEndDate")) Then
                                                Args.DisableInEditMode = True
                                            End If
                                        End If
                                    End If
                                    'End Addition by SanaS on 25-Sep-2009 for Resource allocation Changes
                                    '##### End of Controls Cases For Resource Timesheet Flow

                            End Select

                        Case CommonFunction.Constants.APP_TAG_RISKS
                            If Args.ControlName.ToUpper = "PROBABILITY" Or Args.ControlName.ToUpper = "WEIGHT" Or Args.ControlName.ToUpper = "SEVERITY" Then
                                Args.TextAlign = "right"
                            End If

                        Case CommonFunction.Constants.APP_TAG_PROCESS
                            Select Case Args.ControlName.ToUpper
                                'Disable the control IsActive in Add Mode
                                Case "ISACTIVE"
                                    If Args.IsEditMode = False Then
                                        'Add mode
                                        Args.Editable = False
                                    Else
                                        'Edit mode
                                        Args.Editable = True
                                    End If
                            End Select
                        Case CommonFunction.Constants.APP_TAG_TEMPLATES
                            Select Case Args.ControlName.ToUpper
                                'Disable the control Revision Date in Add mode
                                Case "REVISIONDATE"
                                    If Not Args.IsEditMode Then
                                        'Add mode
                                        Args.Editable = False
                                    Else
                                        'Edit mode
                                        Args.Editable = True
                                    End If
                                Case "REVISIONNUMBER"
                                    'Increment the value of Revision Number in Edit mode
                                    If Args.IsEditMode Then
                                        'Edit mode
                                        Args.IgnoreActualValue = True
                                        If Not (IsDBNull(drControls("RevisionNumber")) Or drControls("RevisionNumber").ToString = "") Then
                                            Args.NewValue = (CType(drControls("RevisionNumber"), Integer) + 1).ToString
                                        End If
                                    End If
                            End Select
                        Case CommonFunction.Constants.APP_TAG_PROCESS_MEASUREMENT_INDICATOR
                            Select Case Args.ControlName.ToUpper
                                'Disable the control IsActive in Add Mode
                                Case "ACTIVE"
                                    If Args.IsEditMode = False Then
                                        'Add mode
                                        Args.Editable = False
                                    Else
                                        'Edit mode
                                        Args.Editable = True
                                    End If
                            End Select
                            'Code added by SiddharthS on 15 March 2005 for issue id 
                            'Purpose : To retain the values on the form if the save is ingnored.
                        Case CommonFunction.Constants.APP_TAG_SITE_TRANSFER
                            If Args.ControlName.ToUpper = "NAME" Then
                                If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form(Args.ControlName), "") <> "" Then
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = HttpContext.Current.Request.Form(Args.ControlName)
                                End If
                            End If
                            If Args.ControlName.ToUpper = "NONDATABASE2" Then
                                If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form(Args.ControlName), "") <> "" Then
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = HttpContext.Current.Request.Form(Args.ControlName)
                                End If
                            End If
                            If Args.ControlName.ToUpper = "NONDATABASE3" Then
                                If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form(Args.ControlName), "") <> "" Then
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = HttpContext.Current.Request.Form(Args.ControlName)
                                End If
                            End If
                            If Args.ControlName.ToUpper = "CREATEDDATE" Then
                                If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form(Args.ControlName), "") <> "" Then
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = HttpContext.Current.Request.Form(Args.ControlName)
                                End If
                            End If


                            'End addition.

                        Case CommonFunction.Constants.APP_TAG_REVIEWS
                            '#####PROJECT REVIEW
                            If Args.ControlName.ToLower = "reviewee" And Args.IsEditMode = True Then
                                'Edit Mode
                                If CType(CommonFunction.Data.CheckIsDBNull(drControls("IsPlannedReview"), "False"), Boolean) = True Then
                                    'For the planned review do not allow to change the Reviewee
                                    Args.Editable = False
                                End If
                            End If
                            'Reviewer(s)
                            If Args.ControlName.ToLower = "reviewedby" Then
                                'Show Reviewer (s) text box disable
                                Args.Editable = False
                            End If
                            'Added By JayavantK, On - 20-Aug-2004
                            If Args.ControlName.ToUpper = "REVIEWEE" And Args.IsEditMode = True Then
                                Dim strQuery As String = ""
                                strQuery = "SELECT COUNT(ReviewActionID) FROM tbl_PM_ReviewActions"
                                strQuery &= " INNER JOIN tbl_PM_ProjectTasks ON tbl_PM_ProjectTasks.TaskID = tbl_PM_ReviewActions.TaskID AND IsActive=1"
                                strQuery &= " WHERE(tbl_PM_ReviewActions.ReviewStatisticsID = " & CommonFunctions.General.CheckIsNothing(drControls("ReviewStatisticsID"), "0") & ")"
                                If CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Integer) > 0 Then
                                    Args.Editable = False
                                End If
                            End If
                            'End Addition

                            'Added By AmitD on 30 Oct 2004
                            If Args.ControlName.ToUpper = "NONDATABASE2" Then
                                Dim strSQL As String
                                Dim drGetDeliverable As IDataReader
                                Dim strDeliverableID As String
                                Dim strDeliverableName As String


                                If Args.IsEditMode Then
                                    strSQL = "Select DeliverableID from tbl_PM_ReviewStatistics Where ReviewStatisticsID = " + CType(Args.PrimaryKeyValue, String)
                                    drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))


                                    If drGetDeliverable.Read Then
                                        strDeliverableID = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("DeliverableID"), "0"), String)
                                    End If

                                    CommonFunction.Data.DisposeDataReader(drGetDeliverable)

                                    If strDeliverableID <> "0" Then
                                        strSQL = "Select Title From tbl_PM_OtherSchedules Where ScheduleID = " + CType(strDeliverableID, String)
                                        drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                        If drGetDeliverable.Read Then
                                            strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("Title"), "0"), String)
                                        End If
                                        ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                        CommonFunction.Data.DisposeDataReader(drGetDeliverable)
                                        ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                    End If

                                    Args.IgnoreActualValue = True
                                    Args.NewValue = strDeliverableName

                                End If
                            End If


                            'End Addition
                            'Added by harshK for sp4 issueid 200 (Deliverable mapping) on 12/09/05
                        Case CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT
                            If Args.ControlName.ToUpper = "NONDATABASE1" Then
                                Dim strSQL As String
                                Dim strDeliverableID As String
                                Dim strDeliverableName As String

                                If Args.IsEditMode Then

                                    'modified by harshada d on 15 feb 2006 for creating deliverables functionality
                                    'strSQL = "Select DeliverableID from tbl_PM_ChangeRequest_Master Where ChangeRequestID = " + CType(Args.PrimaryKeyValue, String)
                                    Dim intChangeRequestID As String
                                    intChangeRequestID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ChangeRequestID_PK")).ToString

                                    If intChangeRequestID = "" Then
                                        intChangeRequestID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ChangeRequestID")).ToString

                                    End If
                                    'end of modification by harshada d on 15 feb 2006 for creating deliverables functionality
                                    If intChangeRequestID <> "" Then
                                        strSQL = "Select DeliverableID from tbl_PM_ChangeRequest_Master Where ChangeRequestID = " + intChangeRequestID
                                        strDeliverableID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), String)
                                        If strDeliverableID <> "0" Then
                                            strSQL = "Select Title From tbl_PM_OtherSchedules Where ScheduleID = " + CType(strDeliverableID, String)
                                            strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), String)
                                        End If
                                        Args.IgnoreActualValue = True
                                        Args.NewValue = strDeliverableName
                                    End If
                                End If
                            End If
                            'End Added by harshK for sp4 issueid 200 (Deliverable mapping)
                        Case CommonFunction.Constants.APP_TAG_REVIEW_PLANNING
                            'Reviewer(s)
                            If Args.ControlName.ToLower = "reviewedby" Then
                                'Show Reviewer (s) text box disable
                                Args.Editable = False
                            End If



                            If Args.ControlName.ToUpper = "NONDATABASE7" Then
                                Dim strSQL As String
                                Dim drGetDeliverable As IDataReader
                                Dim strDeliverableID As String
                                Dim strDeliverableName As String


                                If Args.IsEditMode Then
                                    strSQL = "Select DeliverableID from tbl_PM_ReviewStatistics Where ReviewStatisticsID = " + CType(Args.PrimaryKeyValue, String)
                                    drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))


                                    If drGetDeliverable.Read Then
                                        strDeliverableID = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("DeliverableID"), "0"), String)
                                    End If

                                    CommonFunction.Data.DisposeDataReader(drGetDeliverable)

                                    If strDeliverableID <> "0" Then
                                        strSQL = "Select Title From tbl_PM_OtherSchedules Where ScheduleID = " + CType(strDeliverableID, String)
                                        drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                        If drGetDeliverable.Read Then
                                            strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("Title"), "0"), String)
                                        End If
                                        ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                        CommonFunction.Data.DisposeDataReader(drGetDeliverable)
                                        ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                    End If

                                    Args.IgnoreActualValue = True
                                    Args.NewValue = strDeliverableName



                                End If
                                'Integrated by PrajaktaR for WSEMSP4 IssueID 449
                                'Added by PrajaktaR on 19th Aug 2005 for Alliance., Aspire 20449 
                            ElseIf Args.ControlName.ToUpper = "NONDATABASE4" Then
                                If Args.IsEditMode Then
                                    Dim strSQL As String
                                    Dim drDate As IDataReader
                                    Dim dtReviewStartDate As Date

                                    strSQL = "SELECT ReviewStartDate FROM tbl_PM_ReviewStatistics WHERE ReviewStatisticsID = " + CType(Args.PrimaryKeyValue, String)
                                    drDate = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If drDate.Read Then
                                        dtReviewStartDate = CType(CommonFunction.Data.CheckIsDBNull(drDate("ReviewStartDate"), CType(Now, String)), Date)
                                    End If

                                    CommonFunction.Data.DisposeDataReader(drDate)
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = CType(dtReviewStartDate, String)
                                End If
                            ElseIf Args.ControlName.ToUpper = "NONDATABASE5" Then
                                If Args.IsEditMode Then
                                    Dim strSQL As String
                                    Dim drDate As IDataReader
                                    Dim dtReviewEndDate As Date

                                    strSQL = "SELECT ReviewEndDate FROM tbl_PM_ReviewStatistics WHERE ReviewStatisticsID = " + CType(Args.PrimaryKeyValue, String)
                                    drDate = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If drDate.Read Then
                                        dtReviewEndDate = CType(CommonFunction.Data.CheckIsDBNull(drDate("ReviewEndDate"), CType(Now, String)), Date)
                                    End If

                                    CommonFunction.Data.DisposeDataReader(drDate)
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = CType(dtReviewEndDate, String)
                                End If

                                'End of Addition by PrajaktaR on 19th Aug 2005 for Alliance.
                                'END Of Integration by PrajaktaR for WSEMSP4 IssueID 449
                            End If


                        Case CommonFunction.Constants.APP_TAG_PUBLISH_PROCESS
                            'Increment the value of RevisionNo
                            If Args.ControlName.ToUpper = "REVISIONNO" Then
                                Dim strProcessID As String = HttpContext.Current.Request.QueryString("ProcessId")
                                Dim strSQL As String
                                strSQL = "SELECT ISNULL(MAX(RevisionNo), 0) + 1 "
                                strSQL += "FROM tbl_PRS_Process_Revision "
                                strSQL += "WHERE ProcessID =" + strProcessID
                                Args.DefaultValue = "1-" + CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                            End If
                            ''Commented by ManishK on 03rd Jan 2006 as new page is inherited for this
                            ''''Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS
                            ''''    'If Status is not Submitted in Edit mode
                            ''''    If Args.IsEditMode = True And Args.PrimaryKeyValue <> "" Then
                            ''''        If CType(CommonFunction.Data.CheckIsDBNull(drControls("LeaveStatusID"), "0"), Long) <> 1 Then
                            ''''            Args.Editable = False
                            ''''        End If
                            ''''    End If

                            ''''    ' Added By JayavantK on 15-Sep-2004
                            ''''    If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeID"), "") <> "" Then
                            ''''        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form(Args.ControlName)).ToString <> "" Then
                            ''''            Args.IgnoreActualValue = True
                            ''''            Args.NewValue = HttpContext.Current.Request.Form(Args.ControlName).ToString
                            ''''        End If

                            ''''        If Args.ControlName.ToUpper = "LEAVETYPEID" Then
                            ''''            Dim strEmployeeID As String = ""
                            ''''            Dim strQuery As String = ""

                            ''''            strEmployeeID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeID"), "")
                            ''''            If strEmployeeID <> "" Then
                            ''''                strQuery = "Exec usp_Sel_tbl_PM_LeaveTypemaster " & strEmployeeID
                            ''''                Args.AdditionalInformation = strQuery
                            ''''            End If
                            ''''        ElseIf Args.ControlName.ToUpper = "HALFDAY" Then
                            ''''            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form(Args.ControlName), "") <> "" Then
                            ''''                Args.ToBeInserted = "Checked"
                            ''''            End If
                            ''''        End If
                            ''''    End If
                            ''''    'End Addition

                            ''''''    Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEAPPLICATION
                            ''''''        'disable the leave balance combo box
                            ''''''        If Args.ControlName.ToUpper = "NONDATABASE1" Then

                            ''''''    If Args.IsEditMode = True Then
                            ''''''        'Cancel = True
                            ''''''        'Integrated By Manishk on 02 Jan 2006
                            ''''''        'Modified by SachinR    on 30 Nov 2005
                            ''''''        Dim intIndex As Integer
                            ''''''        intIndex = 0
                            ''''''        If IsDBNull(drControls("leavetypeid")) = False Then
                            ''''''            intIndex = CType(drControls("leavetypeid"), Integer)
                            ''''''        End If
                            ''''''        '  Dim intIndex As Integer = CType(drControls("leavetypeid"), Integer)
                            ''''''        'end modification   on 30 Nov 2005
                            ''''''        'End of Integrated By Manishk on 02 Jan 2006

                            ''''''        Args.IgnoreActualValue = True
                            ''''''        Args.DropDownEditSQL = "usp_Sel_tbl_PM_EmployeeLeaveMaster " + WhizGlobal.UserID.ToString + "," + intIndex.ToString
                            ''''''        'Args.StoredProcedureName = "usp_Sel_tbl_PM_EmployeeLeaveMaster " + WhizGlobal.UserID.ToString + "," + intIndex.ToString
                            ''''''        'Args.DefaultValue = "usp_Sel_tbl_PM_EmployeeLeaveMaster " + WhizGlobal.UserID.ToString + "," + intIndex.ToString
                            ''''''        'Args.NewValue = "usp_Sel_tbl_PM_EmployeeLeaveMaster " + WhizGlobal.UserID.ToString + "," + intIndex.ToString
                            ''''''    End If
                            ''''''    Args.Editable = False
                            ''''''ElseIf Args.ControlName.ToUpper = "APPROVER" Then
                            ''''''    Cancel = True
                            ''''''End If
                            ''End of Commented by ManishK on 03rd Jan 2006 as new page is inherited for this for Leave

                        Case CommonFunction.Constants.APP_TAG_TASK_TYPE_MAINTENANCE_PM
                            'Enable the Primary Key Control
                            If Args.ControlName.ToUpper = "TASKTYPEID" Then
                                Args.Editable = True
                                'Commented By NileshD on 8 oct 2004
                                'Following code is commented becuase default functionality was not working 
                                'properly.

                                'If Args.IsEditMode = False Then

                                '    If IsNothing(HttpContext.Current.Request.QueryString("ProjectID")) = False Then
                                '        Args.AdditionalInformation = "usp_Sel_tbl_PM_TaskTypes_PopulateCombo " & HttpContext.Current.Request.QueryString("ProjectID").ToString
                                '    Else
                                '        Args.AdditionalInformation = "usp_Sel_tbl_PM_TaskTypes_PopulateCombo " & HttpContext.Current.Session("intProjectID").ToString
                                '    End If
                                'ElseIf Args.IsEditMode = True Then
                                '    If IsNothing(HttpContext.Current.Request.QueryString("ProjectID")) = False Then
                                '        Args.AdditionalInformation = "usp_Sel_ListOfTasks_ForInheriting_Edit " & HttpContext.Current.Request.QueryString("ProjectID").ToString
                                '    Else
                                '        Args.AdditionalInformation = "usp_Sel_ListOfTasks_ForInheriting_Edit " & HttpContext.Current.Session("intProjectID").ToString
                                '    End If
                                'End If
                            End If

                            'If Args.ControlName.ToUpper = "PROJECTID" Then
                            '    If IsNothing(HttpContext.Current.Request.QueryString("ProjectID")) = False Then
                            '        Args.IgnoreActualValue = True
                            '        Args.NewValue = HttpContext.Current.Request.QueryString("ProjectID").ToString
                            '    End If
                            'End If
                            'Added by DipaliS 21 Oct 2004
                            If Args.ControlName.ToUpper = "TASKTYPEID" Then
                                'If Args.IsEditMode = False Then
                                '    If HttpContext.Current.Request.QueryString("TaskProjectID").ToString = "0" Then
                                '        Args.AdditionalInformation = "usp_Sel_tbl_PM_TaskTypes_PopulateCombo " + HttpContext.Current.Session("intProjectID").ToString
                                '    Else
                                '        Args.AdditionalInformation = "usp_Sel_tbl_PM_TaskTypes_PopulateCombo_ForGlobal " + HttpContext.Current.Request.QueryString("TaskProjectID").ToString
                                '    End If
                                'Else
                                '    If HttpContext.Current.Request.QueryString("TaskProjectID").ToString = "0" Then
                                '        Args.DropDownEditSQL = "usp_Sel_ListOfTasks_ForInheriting_Edit " + HttpContext.Current.Session("intProjectID").ToString
                                '    Else
                                '        Args.DropDownEditSQL = "usp_Sel_ListOfTasks_ForInheriting_Edit " + HttpContext.Current.Request.QueryString("TaskProjectID").ToString
                                '    End If
                                'End If
                            End If
                            'If Args.ControlName.ToUpper = "PROJECTID" Then
                            '    If HttpContext.Current.Request.QueryString("TaskProjectID").ToString = "0" Then
                            '        Args.IgnoreActualValue = True
                            '        Args.NewValue = HttpContext.Current.Session("intProjectID").ToString
                            '    End If
                            'End If
                            'End addition by DipaliS 21 Oct 2004
                            'Code added by PrashantD on 19 Jan 2008 for Resource Demand Enhancment
                            'Case CommonFunction.Constants.APP_TAG_RESOURCEREQUEST
                        Case CommonFunction.Constants.APP_TAG_RESOURCEREQUEST, CommonFunction.Constants.APP_TAG_EXTENDRESOURCEREQUEST
                            If Args.ControlName.ToUpper = "NONDATABASE1" Then
                                Dim objEndDate As String
                                objEndDate = CommonFunction.Data.GetDataScalar("usp_Sel_tbl_PM_Project_EndDate " & WhizGlobal.ProjectID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                                Args.IgnoreActualValue = True
                                Args.NewValue = objEndDate
                                Args.Editable = False
                            End If
                            If Args.ControlName.ToUpper = "REQUESTDATE" Then
                                'change the formate of date in edit mode.
                                If Args.IsEditMode = True Then
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = CommonFunction.Dates.GetDate(CType(CommonFunction.General.CheckIsNothing(drControls("RequestDate"), ""), Date))
                                End If
                            End If
                            'Added By NileshD on 7th Jan 2005 for resolving issue 14850
                            If Args.ControlName.ToUpper = "NONDATABASE2" Then
                                Args.IgnoreActualValue = True
                                Dim strDays As String
                                strDays = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT ExpectedDuration FROM tbl_PM_Project WHERE ProjectID = " + WhizGlobal.ProjectID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString
                                Args.NewValue = strDays
                            End If
                            'Added by TruptiK on 05-jun-09
                            'End of addition by TruptiK
                            'End Of Addition
                        Case CommonFunction.Constants.APP_TAG_CORPORATE_SETTINGS
                            If Args.ControlName.ToUpper = "RESOURCEALLOCATIONLEVEL" Then
                                If CType(CommonFunction.Data.CheckIsDBNull(drControls("AllowResourceAllocation"), "False"), Boolean) = True Then
                                    Args.Editable = True
                                Else
                                    Args.Editable = False
                                End If
                            End If
                            'Added by ShamkantD on 30 Nov 2004
                            If Args.ControlName.ToUpper() = "IsProjectCreationWorkflowReqd".ToUpper() Then
                                Dim intProjectsBeingApproved As Integer = 0

                                'Determine the number of projects that are sent for approval or are rejected.
                                intProjectsBeingApproved = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT COUNT(*) AS ProjectsBeingApproved FROM tbl_PM_ProjectRevision WHERE BaselineStatus IN ('S', 'R')", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)

                                If intProjectsBeingApproved > 0 Then
                                    Args.Editable = False
                                End If
                            End If
                            'End of addition - ShamkantD on 30 Nov 2004
                            If Args.ControlName.ToUpper = "SMTPPASSWORD" Then
                                If CType(CommonFunction.Data.CheckIsDBNull(drControls("SMTPPassword")), String) <> "" Then
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = CommonFunction.General.DecryptString(CType(drControls("SMTPPassword"), String))
                                End If
                            End If
                        Case CommonFunction.Constants.APP_TAG_CONTRACT_REVIEW_MEETING
                                If Args.ControlName.ToUpper = "EXPECTEDSTARTDATE" Then
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = CommonFunction.Dates.GetDate(CType(drControls("ExpectedStartDate"), Date))
                                End If
                                If Args.ControlName.ToUpper = "EXPECTEDENDDATE" Then
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = CommonFunction.Dates.GetDate(CType(drControls("ExpectedEndDate"), Date))
                                End If
                        Case CommonFunction.Constants.App_TAG_FIXED_BID
                                'Get the First value for contract from revision table for given project
                                Select Case Args.ControlName.ToLower
                                    Case "revid"
                                        'Get the next value for Revision ID
                                        Args.IgnoreActualValue = True
                                        Args.FieldDataTypeID = CommonFunction.Constants.FIELD_DATA_TYPE_NUMERIC
                                        Args.NewValue = CommonFunctions.Data.GetDataScalar("usp_sel_tbl_pm_projectfixedbid_revision_RevID " & WhizGlobal.ProjectID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                                        Args.NewValue = FormatNumber(Args.NewValue, 2)
                                    Case "nondatabase1"
                                        Args.IgnoreActualValue = True
                                        Args.FieldDataTypeID = CommonFunction.Constants.FIELD_DATA_TYPE_NUMERIC
                                        Args.NewValue = CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectfixedBid_Revision_GetMinCV " & WhizGlobal.ProjectID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                                        Args.NewValue = FormatNumber(Args.NewValue, 2)
                                    Case "nondatabase2"
                                        'Get the Contract Value from Project Table
                                        Args.IgnoreActualValue = True
                                        Args.FieldDataTypeID = CommonFunction.Constants.FIELD_DATA_TYPE_NUMERIC
                                        Args.NewValue = CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectRevision_contractvalue " & WhizGlobal.ProjectID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                                        Args.NewValue = FormatNumber(Args.NewValue, 2)
                                    Case "nondatabase5"
                                        'Get the Previous Approved Contract Value from the Revision Table 
                                        Args.IgnoreActualValue = True
                                        Args.FieldDataTypeID = CommonFunction.Constants.FIELD_DATA_TYPE_NUMERIC
                                        Args.NewValue = CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_ProjectFixedbid_Revision_PrevApproved " & WhizGlobal.ProjectID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                                        Args.NewValue = FormatNumber(Args.NewValue, 2)
                                End Select

                                '    'Added By DipaliS the check to display the field depending upon the Role
                                'Case CommonFunction.Constants.APP_TAG_WORKORDER
                                '    Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

                                '    If Args.ControlTypeID <> CommonFunction.Constants.CONTROL_TYPE_HIDDEN And Args.IsHidden = False Then
                                '        Dim drRoleAccess As IDataReader
                                '        Dim strSQL As String = "usp_sel_tbl_pm_WOUSerAccess " & WhizGlobal.RoleID & ",'" & CommonFunction.General.BuildQueryString(Args.ControlName) & "'"

                                '        drRoleAccess = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL)
                                '        If Not (drRoleAccess.Read) Then
                                '            Cancel = True
                                '        End If
                                '        CommonFunction.Data.DisposeDataReader(drRoleAccess)
                                '    End If

                                '    'If Baseline has been set atleast once
                                '    If CType(CommonFunction.Data.CheckIsDBNull(drControls("BaselineNumber"), "0"), Integer) > 0 Then
                                '        'If the field being plot is a Revision Field then show it as disabled
                                '        If Not CommonFunction.Data.GetDataScalar("usp_Sel_PM_IsProjectRevisionField '" + Args.ControlName + "'", blnUseSQL) Is Nothing Then
                                '            Args.Editable = False
                                '        End If
                                '    End If


                                'Case CommonFunction.Constants.TAG_PROJECT_INFORMATION
                                '    Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

                                '    If Args.ControlTypeID <> CommonFunction.Constants.CONTROL_TYPE_HIDDEN And Args.IsHidden = False Then
                                '        Dim drRoleAccess As IDataReader
                                '        Dim strSQL As String = "usp_sel_tbl_pm_WOUSerAccess " & WhizGlobal.RoleID & ",'" & CommonFunction.General.BuildQueryString(Args.ControlName) & "'"

                                '        drRoleAccess = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL)
                                '        If Not (drRoleAccess.Read) Then
                                '            Cancel = True
                                '        End If
                                '        CommonFunction.Data.DisposeDataReader(drRoleAccess)
                                '    End If

                                '    'If Baseline has been set atleast once
                                '    If CType(CommonFunction.Data.CheckIsDBNull(drControls("BaselineNumber"), "0"), Integer) > 0 Then
                                '        'If the field being plot is a Revision Field then show it as disabled
                                '        If Not CommonFunction.Data.GetDataScalar("usp_Sel_PM_IsProjectRevisionField '" + Args.ControlName + "'", blnUseSQL) Is Nothing Then
                                '            Args.Editable = False
                                '        End If
                                '    End If

                        Case CommonFunction.Constants.APP_TAG_RATECONTRACTBYROLE
                                If Args.ControlName.ToUpper = "CONTRACTVALIDITYDATE" Then
                                    If Not CType(CommonFunction.Data.CheckIsDBNull(drControls("CONTRACTVALIDITYDATE")), Boolean) Then
                                        'If Not IsDBNull((drControls("CONTRACTVALIDITYDATE"))) Then
                                        Args.IgnoreActualValue = True
                                        Args.NewValue = CommonFunction.Dates.GetDate(CType(drControls("CONTRACTVALIDITYDATE"), Date))
                                    End If
                                End If
                                If Args.ControlName.ToUpper = "EXPECTEDSTARTDATE" Then
                                    Dim strSQL As String = "SELECT EXPECTEDSTARTDATE FROM tbl_pm_project where projectid=" & WhizGlobal.ProjectID.ToString
                                    Dim dtStartDate As Date
                                    dtStartDate = CType(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Date)
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = CommonFunction.Dates.GetDate(dtStartDate)
                                End If

                        Case CommonFunction.Constants.APP_TAG_PROJECT_SETTINGS
                                'Intehrated by TruptiK on 19-May-09
                                'Modified by ShraddhaM on 20,Mar 2009 for Whiziblesem7.2
                                'Purpose : For Case 1 project enable the Apply Effort Distribution checkbox.
                                Dim blnIsCase1Project As Boolean = False
                                blnIsCase1Project = CType(CommonFunction.Data.GetDataScalar("SELECT 1 FROM tbl_PM_Project WHERE ProjectID = " + HttpContext.Current.Session("intProjectID").ToString + " AND ApplyEffortDistribution = 0 AND HaveSubTaskTypes = 0", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Boolean)

                                If blnIsCase1Project = False And (Args.ControlName.ToUpper = "APPLYEFFORTDISTRIBUTION" Or Args.ControlName.ToUpper = "HAVESUBTASKTYPES") Then
                                    'Disable Apply Effort Distribution and Apply SubTask Type if any task other than General task is assigned for the Project
                                    'If Args.ControlName.ToUpper = "APPLYEFFORTDISTRIBUTION" Or Args.ControlName.ToUpper = "HAVESUBTASKTYPES" Then
                                    If Not CommonFunction.Data.GetDataScalar("SELECT TaskID FROM tbl_PM_ProjectTasks WHERE ProjectID = " + HttpContext.Current.Session("intProjectID").ToString + " AND WhichTask <> 'D'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) Is Nothing Then
                                        Args.Editable = False
                                        'End If
                                    End If
                                ElseIf blnIsCase1Project = True And Args.ControlName.ToUpper = "HAVESUBTASKTYPES" Then
                                    If Not CommonFunction.Data.GetDataScalar("SELECT TaskID FROM tbl_PM_ProjectTasks WHERE ProjectID = " + HttpContext.Current.Session("intProjectID").ToString + " AND WhichTask <> 'D'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) Is Nothing Then
                                        Args.Editable = False
                                        'End If
                                    End If
                                End If

                                'End of additon by ShraddhaM
                                'End of integration by TruptiK

                                'Code Integrated by MrugajaB on 4th May,2005 for WhizibleSEM SP3 Task Progress feature
                                'Addd by PradeepD on 11-Apr-2005
                                ' Once filled , not  allow user to change the values. 

                                If Args.ControlName.ToUpper = "PROGRESSENTRY" Then
                                    Dim strSQLQuery As String
                                    Dim strPEntry As String
                                    Dim strCount As String
                                    strSQLQuery = "SELECT ProgressEntry FROM Tbl_PM_Project WHERE ProjectID = " + HttpContext.Current.Session("intProjectID").ToString '+ " AND ProgressEntry IS NOT NULL"
                                    If Not CommonFunction.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) Is Nothing Then
                                        strPEntry = CommonFunction.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                                        If strPEntry = "D" Then
                                            strSQLQuery = "SELECT count(FromDate)  FROM tbl_PM_DeliverableProgress WHERE ProjectID = " + HttpContext.Current.Session("intProjectID").ToString
                                            strCount = CommonFunction.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                                            If (strCount <> "0") Then
                                                Args.Editable = False
                                            End If
                                        End If

                                        If strPEntry = "T" Then
                                            strSQLQuery = "SELECT count(FromDate)  FROM tbl_PM_Taskprogress WHERE ProjectID = " + HttpContext.Current.Session("intProjectID").ToString
                                            strCount = CommonFunction.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                                            If (strCount <> "0") Then
                                                Args.Editable = False
                                            End If
                                        End If
                                        ' For Default Setting Assign ProgressEntry to 'Effort Driven'
                                        If strPEntry = "" Then
                                            strSQLQuery = "UPDATE tbl_PM_Project SET PROGRESSENTRY = 'E' WHERE Projectid= " + HttpContext.Current.Session("intProjectID").ToString
                                            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                            Args.DefaultValue = "E"
                                        End If

                                    End If
                                End If
                                'End Addition

                                'added by SachinR   on 15 Jul 2004

                                'Modified By PrachiK on 26 Feb 2005 for Issue ID 14776. 
                                'Purpose: Setting - Assign issue to resposible person 
                                If Args.ControlName.ToUpper = "ASSIGNISSUETORESPONSIBLEPERSON" Then
                                    Dim intAssignIssueToResponsiblePerson As Integer
                                    If Not CommonFunction.Data.GetDataScalar("select assignIssueToResponsiblePerson from tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) Is Nothing Then
                                        intAssignIssueToResponsiblePerson = CType(CommonFunction.Data.GetDataScalar("select assignIssueToResponsiblePerson from tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)
                                        If intAssignIssueToResponsiblePerson = 0 Then
                                            Cancel = True
                                        End If
                                    End If
                                End If
                                'Addtion ended

                        Case CommonFunction.Constants.APP_TAG_SDLC_SAVE_WITH_REVISION
                                If Args.ControlName.ToUpper = "NONDATABASE1" Then
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("SDLCId"))
                                End If
                                'addition end
                        Case CommonFunction.Constants.APP_TAG_RFI_TAX_BUILDER
                                If Args.ControlName.ToUpper = "FORMULA" Then
                                    Args.DisableInEditMode = True
                                End If

                                'Added by JayavantK on 30/07/04
                        Case CommonFunction.Constants.APP_TAG_RESOURCE_REQUEST_ESCALATION
                                If Args.ControlName.ToUpper = "ISESCALATEDFROMTEAM" Then
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = "1"
                                End If
                        Case CommonFunction.Constants.APP_TAG_RESOURCE_REQUEST_ESCALATION_TO_GLOBALPOOL
                                If Args.ControlName.ToUpper = "ISESCALATEDFROMBGPOOL" Then
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = "1"
                                End If
                        Case CommonFunction.Constants.APP_TAG_RESOURCE_REQUEST_ESCALATION_TO_OUPOOL
                                If Args.ControlName.ToUpper = "ISESCALATEDFROMRESOURCEPOOL" Then
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = "1"
                                End If

                        Case CommonFunction.Constants.APP_TAG_RESOURCE_REQUEST_ESCALATION_TO_BGPOOL
                                If Args.ControlName.ToUpper = "ISESCALATEDFROMOUPOOL" Then
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = "1"
                                End If
                                'End of addition
                                'Added By NileshD on 2 August 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_CHANGE_STATUS
                                If Args.ControlName.ToUpper = "CURRENTRFISTATUS" Then
                                    If Not HttpContext.Current.Request.QueryString("RFIMODE") Is Nothing Then
                                        If HttpContext.Current.Request.QueryString("RFIMODE").ToUpper = "SUBMIT" Then
                                            Args.IgnoreActualValue = True
                                            Args.AdditionalInformation = "SELECT 'Submitted'"
                                            Args.NewValue = "Submitted"
                                        End If
                                        If HttpContext.Current.Request.QueryString("RFIMODE").ToUpper = "CANCEL" Then
                                            Args.IgnoreActualValue = True
                                            Args.AdditionalInformation = "SELECT 'Cancelled'"
                                        End If
                                        If HttpContext.Current.Request.QueryString("RFIMODE").ToUpper = "RESUBMIT" Then
                                            Args.IgnoreActualValue = True
                                            Args.AdditionalInformation = "SELECT 'Re-Submitted'"
                                            Args.NewValue = "Re-Submitted"
                                        End If
                                    End If
                                End If
                                If Args.ControlName.ToUpper = "PROJECTID" Then
                                    Dim strSQL As String
                                    Args.IgnoreActualValue = True
                                    strSQL = "SELECT PROJECTID FROM tbl_PM_RFIs WHERE RFIID = " + HttpContext.Current.Request.QueryString("RFIID").ToString
                                    Args.NewValue = CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                                End If
                                'end of addition

                                'added by SachinR   on 2 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_SOFTEX_FORM_GENERATION
                                'here when cantract control is plotted then contract will be listed for the 
                                'customer selected, customer id will be passed to the SP for contract list
                                If Args.PrimaryKeyValue = "" Then
                                    Dim strCustomerID As String
                                    If Args.ControlName.ToUpper = "CUSTOMERID" Then
                                        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("CustomerChange"), "") = "1" Then
                                            strCustomerID = HttpContext.Current.Request("CustomerID") + ""
                                            Args.NewValue = strCustomerID.Trim
                                            Args.IgnoreActualValue = True
                                        End If
                                    End If
                                    If Args.ControlName.ToUpper = "CONTRACTID" Then
                                        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("CustomerChange"), "") = "1" Then
                                            strCustomerID = HttpContext.Current.Request("CustomerID") + ""
                                            Args.AdditionalInformation = "usp_Sel_Rfi_CustomerContracts " + strCustomerID.Trim
                                        End If
                                    End If
                                End If

                                'addition end

                                'Added by ShamkantD on 2nd August 2004
                        Case CommonFunction.Constants.APP_TAG_PM_FIXED_BID
                                Select Case Args.ControlName.ToUpper
                                    Case "HTML TAG1", "HTML TAG2", "HTML TAG3", "HTML TAG4", "HTML TAG5"
                                        'Get the selected currency for the project
                                        Dim strSQL As String
                                        Dim strCurrency As String

                                        strSQL = "SELECT CurrencyCode FROM tbl_PM_CurrencyMaster WHERE CurrencyID = (SELECT BaseCurrency FROM tbl_PM_Project WHERE ProjectID = " & HttpContext.Current.Session("intProjectID").ToString & ")"
                                        strCurrency = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))).ToString

                                        If CommonFunction.General.CheckIsNothing(strCurrency).ToString <> "" Then
                                            Args.HTMLTag = strCurrency
                                        End If
                                        'Added by ShamkantD on for Fixed Bid page on 23rd Aug 2004
                                    Case "ORIGINALCONTRACTVALUE"
                                        'If there is no record in Fixed Bid table, pull the original conract value from project table
                                        If CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("SELECT ProjectID FROM d_tbl_PM_WorkOrderLumpSumContract WHERE ProjectID = " & HttpContext.Current.Session("intProjectID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))) = "" Then
                                            Args.IgnoreActualValue = True
                                            Args.NewValue = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("SELECT ContractValue FROM tbl_PM_Project WHERE ProjectID = " & HttpContext.Current.Session("intProjectID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))).ToString
                                            If Trim(Args.NewValue) <> "" Then
                                                Args.NewValue = FormatNumber(CType(Args.NewValue, Double), 2, , , TriState.False)
                                            End If
                                        Else
                                            Args.IgnoreActualValue = True
                                            If CommonFunction.General.CheckIsNothing(drControls("OriginalContractValue")).ToString <> "" Then
                                                Args.NewValue = FormatNumber(CType(drControls("OriginalContractValue"), Double), 2, , , TriState.False)
                                            End If
                                        End If
                                    Case "PREVIOUSCONTRACTREVISION"
                                        If CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("SELECT LumpSumContractID FROM tbl_PM_WorkOrderLumpSumContract WHERE ProjectID = " & HttpContext.Current.Session("intProjectID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))).ToString <> "" Then
                                            Args.IgnoreActualValue = True
                                            If CommonFunction.General.CheckIsNothing(drControls("PreviousContractRevision")).ToString <> "" Then
                                                Args.NewValue = FormatNumber(CType(drControls("PreviousContractRevision"), Double), 2, , , TriState.False)
                                            End If
                                        End If
                                    Case "LASTCONTRACTVALUE"
                                        If CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("SELECT LumpSumContractID FROM tbl_PM_WorkOrderLumpSumContract WHERE ProjectID = " & HttpContext.Current.Session("intProjectID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))).ToString <> "" Then
                                            Args.IgnoreActualValue = True
                                            If CommonFunction.General.CheckIsNothing(drControls("LastContractValue")).ToString <> "" Then
                                                Args.NewValue = FormatNumber(CType(drControls("LastContractValue"), Double), 2, , , TriState.False)
                                            End If
                                        End If
                                    Case "THISREVISIONVALUE"
                                        If CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("SELECT LumpSumContractID FROM tbl_PM_WorkOrderLumpSumContract WHERE ProjectID = " & HttpContext.Current.Session("intProjectID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))).ToString <> "" Then
                                            Args.IgnoreActualValue = True
                                            If CommonFunction.General.CheckIsNothing(drControls("ThisRevisionValue")).ToString <> "" Then
                                                Args.NewValue = FormatNumber(CType(drControls("ThisRevisionValue"), Double), 2, , , TriState.False)
                                            End If
                                        End If
                                    Case "LATESTREVISIONVALUE"
                                        If CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("SELECT LumpSumContractID FROM tbl_PM_WorkOrderLumpSumContract WHERE ProjectID = " & HttpContext.Current.Session("intProjectID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))).ToString <> "" Then
                                            Args.IgnoreActualValue = True
                                            If CommonFunction.General.CheckIsNothing(drControls("LatestRevisionValue")).ToString <> "" Then
                                                Args.NewValue = FormatNumber(CType(drControls("LatestRevisionValue"), Double), 2, , , TriState.False)
                                            End If
                                        End If
                                        'End of addition
                            End Select
                        Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS
                            If Args.IsEditMode Then
                                Select Case Args.ControlName.ToUpper
                                    Case "BILLAMOUNT"
                                        Args.IgnoreActualValue = True
                                        If CommonFunction.Data.CheckIsDBNull(drControls("BillAmount")).ToString <> "" Then
                                            Args.NewValue = FormatNumber(CType(drControls("BillAmount"), Double), 2, , , TriState.False)
                                        End If
                                End Select
                            End If

                        Case CommonFunction.Constants.APP_TAG_PM_BILLING_ADDRESS
                            Select Case Args.ControlName.ToUpper
                                Case "BILLINGADDRESS"
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_pm_BillingAddress " & HttpContext.Current.Session("intProjectID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))).ToString
                            End Select

                        Case CommonFunction.Constants.APP_TAG_WORKORDER
                            'Show or hide the controls depending upon the Work Order Field access
                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strWorkOrderAccessAttributes")).ToString = "" Then
                                Dim drAttributes As IDataReader
                                Dim strAttributes As String

                                drAttributes = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_WOUserAcess " & HttpContext.Current.Session("intPostID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                strAttributes = ""
                                While drAttributes.Read
                                    If CommonFunction.General.CheckIsNothing(drAttributes("CheckAttribute")).ToString <> "" Then
                                        strAttributes += drAttributes("AttributeName").ToString + ","
                                    End If
                                End While
                                CommonFunction.Data.DisposeDataReader(drAttributes)

                                HttpContext.Current.Session("strWorkOrderAccessAttributes") = strAttributes
                            End If

                            Select Case Args.ControlName.ToUpper
                                Case "PROJECTCODE"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectCode") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROJECTNAME"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectName") < 1 Then
                                        Cancel = True
                                    End If
                                Case "CUSTOMERID"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "CustomerName") < 1 Then
                                        Cancel = True
                                    End If
                                Case "DESCRIPTION"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "Description") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROJECTADDRESS"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectAddress") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROJECTCITY"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectCity") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROJECTSTATE"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectState") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROJECTCOUNTRY"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectCountry") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROJECTPIN"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectPIN") < 1 Then
                                        Cancel = True
                                    End If
                                Case "FUNDEDBY"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "FundedBy") < 1 Then
                                        Cancel = True
                                    End If
                                Case "CONTRACTSTATUSID"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ContractRequired") < 1 Then
                                        Cancel = True
                                    End If
                                Case "CONTRACTPREPAREDBY"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ContractPreparedBy") < 1 Then
                                        Cancel = True
                                    End If
                                Case "VALIDITYDATE"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ContractValidityDate") < 1 Then
                                        Cancel = True
                                    End If
                                Case "CUSTOMERCONTACTPERSON"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "CustomerContactPerson") < 1 Then
                                        Cancel = True
                                    End If
                                Case "AUTHORIZATIONPONUMBER"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "AuthorizationPONumber") < 1 Then
                                        Cancel = True
                                    End If
                                Case "CUSTOMERADDRESS"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "CustomerAddress") < 1 Then
                                        Cancel = True
                                    End If
                                Case "REFERENCENO"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ReferenceNo") < 1 Then
                                        Cancel = True
                                    End If
                                Case "REFERENCEDATE"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ReferenceDate") < 1 Then
                                        Cancel = True
                                    End If

                                    'Added by ShamkantD on 5th August 2004
                                Case "SHORTJOBTITLE"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ShortJobTitle") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROJECTSIZE"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectSize") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROJECTSIZEUNITID"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectSize") < 1 Then
                                        Cancel = True
                                    End If
                                Case "LIFECYCLEID"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "LifeCycleID") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROPOSALNO"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProposalNo") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROPOSALCOST"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProposalCost") < 1 Then
                                        Cancel = True
                                    End If
                                Case "PROPOSALJOBNO"
                                    If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProposalJobNo") < 1 Then
                                        Cancel = True
                                    End If
                                    'End of addition - ShamkantD on 5th August 2004

                                    'Release the session variable 
                                    HttpContext.Current.Session("strWorkOrderAccessAttributes") = ""
                            End Select
                            'Added By JyotiG
                            'Start_JG_7713_15-Nov-2006
                        Case CommonFunction.Constants.APP_TAG_CORPORATE_PROJECTS
                            'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode")).ToString = "ADD_NEW" Then
                            If Args.IsEditMode = False Then
                                'If Args.ControlName.ToUpper = "[OVER]" Then
                                '    Args.Editable = False
                                'End If
                                'Project Status
                                If Args.ControlName = "ProjectStatusID" Then
                                    Dim drPrjStatus As IDataReader
                                    Dim strStatusId As String
                                    drPrjStatus = CommonFunction.Data.GetDataReader("Select ProjectStatusID from tbl_CNF_ProjectStatus where MapToProjectInitiated =1", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If drPrjStatus.Read Then
                                        strStatusId = CType(CommonFunction.Data.CheckIsDBNull(drPrjStatus("ProjectStatusID"), "0"), String)
                                        If strStatusId <> "0" Then
                                            Args.IgnoreActualValue = True
                                            Args.Mandatory = False
                                            Args.NewValue = strStatusId
                                            Args.Editable = False
                                        End If
                                    Else
                                        Args.IgnoreActualValue = True
                                        Args.Mandatory = False
                                        Args.NewValue = ""
                                        Args.Editable = False
                                    End If
                                    CommonFunction.Data.DisposeDataReader(drPrjStatus)
                                End If
                            End If
                            'End_JG_7713_15-Nov-2006
                        Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING
                            'Modified by ShamkantD on 23 Sep 2004 - disable the Work Order Field access validations
                            ''Show or hide the controls depending upon the Work Order Field access
                            'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strWorkOrderAccessAttributes")).ToString = "" Then
                            '    Dim drAttributes As IDataReader
                            '    Dim strAttributes As String

                            '    drAttributes = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_WOUserAcess " & HttpContext.Current.Session("intPostID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '    strAttributes = ""
                            '    While drAttributes.Read
                            '        If CommonFunction.General.CheckIsNothing(drAttributes("CheckAttribute")).ToString <> "" Then
                            '            strAttributes += drAttributes("AttributeName").ToString + ","
                            '        End If
                            '    End While
                            '    CommonFunction.Data.DisposeDataReader(drAttributes)

                            '    HttpContext.Current.Session("strWorkOrderAccessAttributes") = strAttributes
                            'End If

                            'Select Case Args.ControlName.ToUpper
                            '    Case "SHORTJOBTITLE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ShortJobTitle") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "CONTRACT"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "Contract") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "PROPOSALNO"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProposalNo") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "PROJECTGROUPID"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectGroupID") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "INVOICEAPPLICABLE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "InvoiceApplicable") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "BILLABLE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "Billable") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "PROPOSALJOBNO"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProposalJobNo") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "PROPOSALCOST"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProposalCost") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "PROJECTTYPE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectTypeID") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "LIFECYCLEID"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "LifeCycleID") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "CONTRACTTYPE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ContractType") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "BILLINGCYCLETYPE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "BillingCycleType") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "PROJECTSIZE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectSize") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "PROJECTSIZEUNITID"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectSize") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "EXPECTEDSTARTDATE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ExpectedStartDate") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "EXPECTEDENDDATE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ExpectedEndDate") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "ESTIMATEDEFFORTS"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "EstimatedEfforts") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "CONTRACTVALUE"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ContractValue") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "BASECURRENCY"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "BaseCurrency") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "LOCATIONID"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "LocationID") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "BUSINESSGROUPID"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "BusinessGroupID") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "PROJECTSTATUSID"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectStatusID") < 1 Then
                            '            Cancel = True
                            '        End If
                            '    Case "PROJECTTYPEID"
                            '        If InStr(HttpContext.Current.Session("strWorkOrderAccessAttributes").ToString, "ProjectTypeID") < 1 Then
                            '            Cancel = True
                            '        End If

                            '        'Release the session variable 
                            '        HttpContext.Current.Session("strWorkOrderAccessAttributes") = ""
                            'End Select
                            ''End of addition - ShamkantD on 2nd August 2004
                            'End of modification - ShamkantD on 23 Sep 2004

                            'Added by ShamkantD on 29 Sep 2004 - added for Project Information page
                            'Check whether the Project for which information is shown is opened for Approval,
                            'so that accordingly the Information should be shown in Read Only mode 
                            Dim blnProjectForApprovalFlag As Boolean = False
                            blnProjectForApprovalFlag = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("blnProjectForApprovalFlag"), "False"), Boolean)


                            '------ Added By Purvaj on 20 Jun 2008 new projet workflow added(Generic workflow) hence plotting logic changed.
                            '----- fields are editable only when submit link is dispayed. i.e 1st stage.
                            Dim strLinkName As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("WorkflowLinks"), "")

                            If strLinkName.ToUpper.Trim = "SUBMIT" Or strLinkName.ToUpper.Trim = "APPROVE" Then
                                If Args.ControlName.ToUpper = "BUSINESSGROUPID" Or Args.ControlName.ToUpper = "LOCATIONID" Or Args.ControlName.ToUpper = "RESOURCEPOOLID" Or Args.ControlName.ToUpper = "" Or Args.ControlName.ToUpper = "RESOURCEGROUPID" Or Args.ControlName.ToUpper = "PROJECTTYPEID" Or Args.ControlName.ToUpper = "CUSTOMERID" Then
                                    If strLinkName.ToUpper.Trim = "SUBMIT" Then
                                        Args.Editable = True
                                    ElseIf strLinkName.ToUpper.Trim = "APPROVE" Then
                                        Args.Editable = False
                                    End If
                                    '--- End addition purvaj
                                End If
                            End If

                            '---- Commented by Purvaj on 20 Jun 2008 Existing project workflow replaced with generic workflow
                            '---- hence disable controls code commented.
                            ''Added by ShamkantD on 23 Sep 2004 
                            ''Show all information in disabled mode if approver is looking at the Project information page
                            'If CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("blnIsApprover"), "False"), Boolean) = True And blnProjectForApprovalFlag = True Then
                            '    Args.Editable = False
                            'End If
                            ''End of addition - ShamkantD on 23 Sep 2004 
                            '---- End comment PUrvaJ

                            'Get the status of 'Project creation workflow required' flag
                            Dim blnIsProjectCreationWorkflowReqd As Boolean = False
                            blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("blnIsProjectCreationWorkflowReqd"), "False"), Boolean)

                            If blnIsProjectCreationWorkflowReqd = True Then
                                'Added by ShamkantD on Friday, September 24, 2004
                                'Check if the current field is Revision field. 
                                If InStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strRevisionFieldsList"), ",").ToString(), "," & Args.ControlName.ToString().ToUpper() & ",") > 0 Then
                                    Dim strBaselineStatus As String = ""
                                    strBaselineStatus = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drControls("BaselineStatus"), ""), "").ToString()
                                    '------ Added By Purvaj on 20 Jun 2008 new projet workflow added(Generic workflow) hence plotting logic changed.
                                    '----- fields are editable only when submit link is dispayed. i.e 1st stage.
                                    'Dim strLinkName As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("WorkflowLinks"), "")

                                    If strLinkName.ToUpper.Trim = "SUBMIT" Or strLinkName.ToUpper.Trim = "APPROVE" Then
                                        If strLinkName.ToUpper.Trim = "SUBMIT" Then
                                            Args.Editable = True
                                        ElseIf strLinkName.ToUpper.Trim = "APPROVE" Then
                                            Args.Editable = False
                                        End If
                                        '--- End addition purvaj
                                    Else
                                        If CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("blnIsApprover"), "False"), Boolean) = True And blnProjectForApprovalFlag = True Then
                                            Args.Editable = False
                                        End If
                                    End If
                                    If strBaselineStatus = "B" And strLinkName.ToUpper.Trim = "" Then
                                        'Whenever, the Baseline status of the latest Revision of a project 
                                        'is "B" (Baselined), the Revision Fields will be shown in Read-Only 
                                        'mode.
                                        Args.Editable = False
                                    End If
                                    '---- End addition and modification Purvaj
                                End If
                                'End of addition - ShamkantD on Friday, September 24, 2004
                            End If
                            If Args.ControlName.ToUpper = "BILLABLE" And Args.IsEditMode = True Then
                                'Commented by SiddharthS on 5 Apr 2005 for issueID 16438
                                'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("Billable")).ToString <> "" Then
                                '    If HttpContext.Current.Request.Form("Billable") = "on" Then
                                '        Args.ToBeInserted = "checked"
                                '    Else
                                '        Args.IgnoreActualValue = True
                                '        Args.NewValue = "off"
                                '        Args.ToBeInserted = ""
                                '    End If
                                'End If
                                'End comment.
                                'Added by SiddharthS on 5 Apr 2005 for issueID 16438

                                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("strBillable")).ToString <> "" Then
                                    If HttpContext.Current.Request.QueryString("strBillable").ToString = "true" Then
                                        Args.ToBeInserted = "checked"
                                    Else
                                        Args.IgnoreActualValue = True
                                        Args.NewValue = "off"
                                        Args.ToBeInserted = ""
                                    End If
                                End If
                                'End addition.
                            End If
                            'Added by ShamkantD on 23rd August 2004
                            Select Case Args.ControlName.ToUpper
                                Case "CONTRACTVALUE"
                                    Args.IgnoreActualValue = True
                                    If CommonFunction.General.CheckIsNothing(drControls("ContractValue")).ToString <> "" Then
                                        Args.NewValue = FormatNumber(CType(drControls("ContractValue"), Double), 2, , , TriState.False)
                                    End If
                                    'Added By PrachiK on 7 Mar 2005 for Issue ID 16666. 
                                    'Purpose: The value of Billable Field changes from true to false when project is revised.
                                    'Issueid 16438
                                    'Purpose:While creating Project,Checkbox for 'Billable' becomes false when we select a Business Group
                                    'Case "BILLABLE"
                                    '    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("Billable")).ToString <> "" Then
                                    '        If HttpContext.Current.Request.Form("Billable") = "on" Then
                                    '            Args.ToBeInserted = "checked"
                                    '        Else
                                    '            Args.IgnoreActualValue = True
                                    '            Args.NewValue = "off"
                                    '            Args.ToBeInserted = ""
                                    '        End If
                                    '    End If
                                    'Addtion ended
                            End Select
                            'End of Addition - ShamkantD on 23rd August 2004

                            '##### Added By AmitD on 30 Aug 2004 - For Project Information
                            'if the value of control is nothing means that page is loading first time .. so do not load viewstate
                            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request(Args.ControlName)).ToString <> "" Then
                                ' Otherwise load viewState
                                'Modified by ShamkantD on 5 Oct 2004 - added condition to check 
                                'the Operation mode - if it is save mode, instead of loading 
                                'viewState values, the values should be taken from the Database

                                '---------- Modified By PurvaJ on 26 May 2008 Configurable workflow
                                '---------- When clicked on Put On Hold / REsume Project link the page gets refreshed.
                                '---------- but the status was not getting refreshed as the operation was not save.
                                '---------- Hence AND condition added for plotting control value in the
                                '---------- 'And CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("WorkflowAction"), "").ToString().ToUpper() <> "PUTONHOLD" And CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("WorkflowAction"), "").ToString().ToUpper() <> "BLOCKDA" '


                                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), "").ToString().ToUpper() <> "SAVE" And CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("WorkflowAction"), "").ToString().ToUpper() <> "PUTONHOLD" And CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("WorkflowAction"), "").ToString().ToUpper() <> "BLOCKDA" Then
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = HttpContext.Current.Request(Args.ControlName).ToString
                                End If

                                '----------- End Modification PurvaJ

                                'End of addition - ShamkantD on 5 Oct 2004
                            End If

                            Select Case Args.ControlName.ToUpper
                                'Intigrated by HarshK for sp4 Issueid 591
                                'Case "BUSINESSGROUPID"
                                '    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")).ToString = "REVISION" Then
                                '        Args.IgnoreActualValue = False
                                '    End If

                                'Case "LOCATIONID"

                                '    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID")).ToString <> "" Then
                                '        'Args.IgnoreActualValue = True
                                '        Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & HttpContext.Current.Request.QueryString("BusinessGroupID").ToString
                                '        Args.IgnoreActualValue = True
                                '        Args.NewValue = ""

                                '        'Args.AdditionalInformation = "Select CostHeadID, CostHead from tbl_CNF_CostHeads "
                                '    ElseIf CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("LocationID")).ToString <> "" And _
                                '            CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")).ToString <> "REVISION" Then

                                '        Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & HttpContext.Current.Request.Form("BusinessGroupID").ToString

                                '    ElseIf CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")).ToString = "REVISION" Then

                                '        Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & CType(drControls("BusinessGroupID"), String)
                                '        Args.IgnoreActualValue = False

                                '    Else
                                '        Dim strProjectID As String
                                '        If CType(HttpContext.Current.Request.QueryString("ProjectID_PK"), String) <> "" Then
                                '            strProjectID = CType(HttpContext.Current.Request.QueryString("ProjectID_PK"), String)
                                '        ElseIf CType(HttpContext.Current.Request.QueryString("ProjectID"), String) <> "" Then
                                '            strProjectID = CType(HttpContext.Current.Request.QueryString("ProjectID"), String)
                                '        Else
                                '            strProjectID = CType(HttpContext.Current.Session("intProjectID"), String)
                                '        End If
                                '        ' the condition which will always return no records
                                '        Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " + "0," + CType(strProjectID, String)

                                '    End If

                                '    'Added by AbhijitD on 22 Aug 2005 for Project Information Page for impelmenting populatecombochange for DU & DT
                                '    'Delivery Unit            
                                'Case "RESOURCEPOOLID"
                                '    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("LocationID")).ToString <> "" Or _
                                '        CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID")).ToString <> "" Then
                                '        Args.IgnoreActualValue = True
                                '        Args.NewValue = ""
                                '    End If

                                '    'Code Changed By SantoshK on 29Sept 2005
                                '    'Added one more condition in if
                                '    If (CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID")).ToString <> "") Or _
                                '           (CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("LocationID")).ToString <> "" And _
                                '            CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")).ToString <> "REVISION") Then

                                '        Args.AdditionalInformation = "usp_Sel_GetResourcePoolForLocation " & HttpContext.Current.Request.Form("LocationID").ToString
                                '        Args.DropDownEditSQL = Args.AdditionalInformation
                                '        'If business Group ID is changed that indicates there is no value in OU Combo.
                                '        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID")).ToString <> "" Then
                                '            Args.AdditionalInformation = "SELECT ResourcePoolID, ResourcePoolName FROM tbl_PM_ResourcePool Where ResourcePoolID = -1"
                                '            Args.DropDownEditSQL = Args.AdditionalInformation
                                '        End If
                                '        'Code Added By SantoshK on 28th Sept - to Resolve Issue related Revision Click
                                '        'If Revision is Clicked restore Du Values
                                '    ElseIf CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")).ToString = "REVISION" Then
                                '        Args.AdditionalInformation = "usp_Sel_GetResourcePoolForLocation " & drControls("LocationID").ToString
                                '        Args.DropDownEditSQL = Args.AdditionalInformation
                                '        Args.IgnoreActualValue = False
                                '    Else
                                '        If Not drControls Is Nothing Then
                                '            If CommonFunction.Data.CheckIsDBNull(drControls("LocationID")).ToString = "" Then
                                '                Args.AdditionalInformation = "SELECT ResourcePoolID, ResourcePoolName FROM tbl_PM_ResourcePool Where ResourcePoolID = -1"
                                '                Args.DropDownEditSQL = Args.AdditionalInformation
                                '            Else
                                '                Args.AdditionalInformation = "usp_Sel_GetResourcePoolForLocation " & drControls("LocationID").ToString
                                '                Args.DropDownEditSQL = Args.AdditionalInformation
                                '            End If
                                '        Else
                                '            Args.AdditionalInformation = "SELECT ResourcePoolID, ResourcePoolName FROM tbl_PM_ResourcePool Where ResourcePoolID = -1"
                                '            Args.DropDownEditSQL = Args.AdditionalInformation
                                '        End If
                                '    End If
                                '    'End of addition by AbhijitD


                                '    'Added by SantoshK on 27 Sept 2005 for Project Creation Page
                                '    'Delivery Team
                                'Case "RESOURCEGROUPID"

                                '    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ResourcePoolID")).ToString <> "" Then
                                '        Args.IgnoreActualValue = True
                                '        Args.NewValue = ""
                                '    End If

                                '    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ResourcePoolID")).ToString <> "" And _
                                '            CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")).ToString <> "REVISION" Then

                                '        Args.AdditionalInformation = " SELECT G.GroupID,G.GroupName FROM tbl_PM_GroupMaster  G INNER JOIN tbl_PM_ResourcePool_Teams P " & _
                                '                                       "ON P.GroupID = G.GroupID WHERE P.ResourcePoolID =  " & HttpContext.Current.Request.Form("ResourcePoolID").ToString
                                '        Args.DropDownEditSQL = Args.AdditionalInformation

                                '        'If business Group ID is changed or Location is changed , that indicates there is no value in OU Combo.
                                '    ElseIf CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID")).ToString <> "" Or CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("LocationID")).ToString <> "" Then
                                '        Args.AdditionalInformation = "SELECT GroupID, GroupName FROM tbl_PM_GroupMaster Where GroupID = -1"
                                '        Args.DropDownEditSQL = Args.AdditionalInformation
                                '    Else
                                '        If Not drControls Is Nothing Then
                                '            If CommonFunction.Data.CheckIsDBNull(drControls("ResourcePoolID")).ToString = "" Then
                                '                Args.AdditionalInformation = "SELECT GroupID, GroupName FROM tbl_PM_GroupMaster Where GroupID = -1"
                                '                Args.DropDownEditSQL = Args.AdditionalInformation
                                '            Else
                                '                Args.AdditionalInformation = " SELECT G.GroupID,G.GroupName FROM tbl_PM_GroupMaster  G INNER JOIN tbl_PM_ResourcePool_Teams P " & _
                                '                                            "ON P.GroupID = G.GroupID WHERE P.ResourcePoolID =  " & drControls("ResourcePoolID").ToString
                                '                Args.DropDownEditSQL = Args.AdditionalInformation
                                '            End If
                                '        Else
                                '            Args.AdditionalInformation = "SELECT GroupID, GroupName FROM tbl_PM_GroupMaster Where GroupID = -1"
                                '            Args.DropDownEditSQL = Args.AdditionalInformation
                                '        End If
                                '    End If

                                'Case "BILLABLE"
                                '    If HttpContext.Current.Request.Form("Billable") = "on" Then
                                '        Args.ToBeInserted = "checked"
                                '    ElseIf (CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("LocationID")).ToString <> "" Or CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID")).ToString <> "") Then
                                '        Args.IgnoreActualValue = True
                                '        Args.NewValue = "off"
                                '        Args.ToBeInserted = ""
                                '    End If
                                'End Intigrated by HarshK for sp4 Issueid 591
                                '*****************
                                'modified by HarshK for sp4 issueid 591
                                Case "BUSINESSGROUPID"
                                    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")).ToString = "REVISION" Then
                                        Args.IgnoreActualValue = False
                                    End If
                                Case "LOCATIONID"

                                    Dim strTempBGID As String, strTempLocationID As String, strDUID As String
                                    Dim strOperation As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")).ToString
                                    strTempBGID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID")).ToString
                                    strTempLocationID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("LocationID")).ToString
                                    strDUID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RESOURCEPOOLID")).ToString
                                    'If strOperation.ToUpper <> "REVISION" Then
                                    If strOperation.Trim = "" Then
                                        'Integrated by SandipL SP8 to SP9

                                        If strTempBGID <> "" Then
                                            'Modified by SandipL on 6 April 2007
                                            ' Active/inactive Flag in OS
                                            'Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & strTempBGID
                                            Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & strTempBGID & "," & drControls("ProjectID").ToString & ",0,1"
                                            ' End modification by SandipL on 6 April 2007
                                            Args.IgnoreActualValue = True
                                            Args.NewValue = ""
                                        Else
                                            If strTempLocationID <> "" Or strDUID <> "" Then
                                                strTempBGID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("BusinessGroupID")).ToString
                                                'Modified by SandipL on 6 April 2007
                                                ' Active/inactive Flag in OS
                                                'Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & strTempBGID 
                                                Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & strTempBGID & "," & drControls("ProjectID").ToString & ",0,1"
                                            Else
                                                'Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & drControls("BusinessGroupID").ToString 
                                                Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & drControls("BusinessGroupID").ToString & "," & drControls("ProjectID").ToString & ",0,1"
                                                ' End modification by SandipL on 6 April 2007
                                            End If

                                        End If
                                    Else
                                        Args.AdditionalInformation = "usp_Sel_GetBusinessGroupsForLocation " & drControls("BusinessGroupID").ToString & "," & drControls("ProjectID").ToString & ",0,1"
                                        Args.IgnoreActualValue = False
                                    End If
                                    'End Integration by SandipL SP8 to SP9
                                    'End modified by HarshK for sp4 issueid 591
                                    'added by harshK for sp4 issueid 591 on 18/10/2005
                                Case "RESOURCEPOOLID"
                                    Dim strTempLocationID As String, strTempBGID As String, strDUID As String
                                    Dim strOperation As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")).ToString
                                    strTempLocationID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("LocationID")).ToString
                                    strTempBGID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID")).ToString
                                    strDUID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RESOURCEPOOLID")).ToString
                                    'If strOperation.ToUpper <> "REVISION" Then
                                    If strOperation.Trim = "" Then
                                        If strTempBGID <> "" Then
                                            Args.AdditionalInformation = "usp_Sel_GetResourcePoolForLocation -1"
                                        Else
                                            If strTempLocationID <> "" Then
                                                'Integrated by SandipL SP8 to SP9

                                                'Modified by SandipL on 6 April 2007
                                                ' Active/inactive Flag in OS
                                                'Args.AdditionalInformation = "usp_Sel_GetResourcePoolForLocation " & strTempLocationID
                                                Args.AdditionalInformation = "usp_Sel_GetResourcePoolForLocation " & strTempLocationID & ",0,1," & drControls("ProjectID").ToString
                                                ' End modification by SandipL on 6 April 2007
                                                Args.IgnoreActualValue = True
                                                Args.NewValue = ""
                                            Else
                                                If strDUID <> "" Then
                                                    strTempLocationID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("LocationID")).ToString
                                                    'Modified by SandipL on 6 April 2007
                                                    ' Active/inactive Flag in OS
                                                    Args.AdditionalInformation = "usp_Sel_GetResourcePoolForLocation " & strTempLocationID & ",0,1," & drControls("ProjectID").ToString
                                                Else
                                                    Args.AdditionalInformation = "usp_Sel_GetResourcePoolForLocation " & drControls("LocationID").ToString & ",0,1," & drControls("ProjectID").ToString
                                                    ' End modification by SandipL on 6 April 2007
                                                End If

                                            End If
                                        End If
                                    Else
                                        'Modified by SandipL on 6 April 2007
                                        ' Active/inactive Flag in OS
                                        'Args.AdditionalInformation = "usp_Sel_GetResourcePoolForLocation " & drControls("LocationID").ToString
                                        Args.AdditionalInformation = "usp_Sel_GetResourcePoolForLocation " & drControls("LocationID").ToString & ",0,1," & drControls("ProjectID").ToString
                                        ' End modification by SandipL on 6 April 2007
                                        'End Integration by SandipL SP8 to SP9
                                        Args.IgnoreActualValue = False
                                    End If
                                Case "RESOURCEGROUPID"
                                    Dim strTempLocationID As String, strTempBGID As String, strDUID As String
                                    Dim strOperation As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")).ToString
                                    strTempLocationID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("LocationID")).ToString
                                    strTempBGID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID")).ToString
                                    strDUID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RESOURCEPOOLID")).ToString
                                    'If strOperation.ToUpper <> "REVISION" Then
                                    If strOperation.Trim = "" Then
                                        If strTempBGID <> "" Or strTempLocationID <> "" Then
                                            Args.AdditionalInformation = "usp_sel_GetDeliverayTeam -1"
                                        Else
                                            If strDUID <> "" Then
                                                'Integrated by SandipL SP8 to SP9

                                                'Modified by SandipL on 6 April 2007
                                                ' Active/inactive Flag in OS

                                                'Args.AdditionalInformation = "usp_sel_GetDeliverayTeam " & strDUID 
                                                Args.AdditionalInformation = "usp_sel_GetDeliverayTeam " & strDUID & ",0,1," & drControls("ProjectID").ToString
                                                Args.IgnoreActualValue = True
                                                Args.NewValue = ""
                                            Else
                                                'Args.AdditionalInformation = "usp_sel_GetDeliverayTeam " & drControls("RESOURCEPOOLID").ToString 
                                                If Not drControls("RESOURCEPOOLID") Is Nothing Then
                                                    If drControls("RESOURCEPOOLID").ToString <> "" Then
                                                        Args.AdditionalInformation = "usp_sel_GetDeliverayTeam " & drControls("RESOURCEPOOLID").ToString & ",0,1," & drControls("ProjectID").ToString
                                                    Else
                                                        'will not return any record
                                                        Args.AdditionalInformation = "usp_sel_GetDeliverayTeam "
                                                    End If
                                                Else
                                                    'will not return any record
                                                    Args.AdditionalInformation = "usp_sel_GetDeliverayTeam "
                                                End If

                                            End If
                                        End If
                                    Else
                                        'Args.AdditionalInformation = "usp_sel_GetDeliverayTeam " & drControls("RESOURCEPOOLID").ToString 
                                        If Not drControls("RESOURCEPOOLID") Is Nothing Then
                                            If drControls("RESOURCEPOOLID").ToString <> "" Then
                                                Args.AdditionalInformation = "usp_sel_GetDeliverayTeam " & drControls("RESOURCEPOOLID").ToString & ",0,1," & drControls("ProjectID").ToString
                                            Else
                                                'will not return any record
                                                Args.AdditionalInformation = "usp_sel_GetDeliverayTeam "
                                            End If
                                        Else
                                            'will not return any record
                                            Args.AdditionalInformation = "usp_sel_GetDeliverayTeam "
                                        End If
                                        ' End modification by SandipL on 6 April 2007
                                        'End Integration by SandipL SP8 to SP9
                                        Args.IgnoreActualValue = False
                                    End If
                                Case "BILLABLE"
                                    If HttpContext.Current.Request.Form("Billable") = "on" Then
                                        Args.ToBeInserted = "checked"
                                    ElseIf (CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("LocationID")).ToString <> "" Or CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID")).ToString <> "") Then
                                        Args.IgnoreActualValue = True
                                        Args.NewValue = "off"
                                        Args.ToBeInserted = ""
                                    End If
                                    'End added by harshK for sp4 issueid 591
                            End Select
                            '##### End Addition

                            'Added by ShamkantD on 22 Sep 2004 - added for non-database control Project Type
                            If Args.ControlName.ToUpper = "NONDATABASE3" And Args.IsEditMode = True Then
                                Dim strProjectType As String = ""
                                Dim intProjectTypeID As Integer = 0
                                Dim intMainProjectTypeID As Integer = 0
                                Dim strSQLQuery As String = ""

                                'Get project type id
                                intProjectTypeID = CType(CommonFunction.Data.CheckIsDBNull(drControls("ProjectTypeID"), "0"), Integer)

                                'Get main project type id
                                strSQLQuery = "SELECT ProjectTypeID FROM tbl_PRs_ProjectTypes WHERE TypeID = " & intProjectTypeID.ToString()
                                intMainProjectTypeID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)

                                'Get main project type
                                strSQLQuery = "Select ProjectType From tbl_PRS_Main_ProjectType Where ProjectTypeID = " & intMainProjectTypeID.ToString()
                                strProjectType = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), ""), String)

                                Args.IgnoreActualValue = True
                                Args.NewValue = strProjectType.Trim()
                                Args.Editable = False
                            End If
                            'End of addition - ShamkantD on 22 Sep 2004 


                            'Modified By PrachiK on 1 Mar 2005 for Issue ID 16248.  and Issue id 16539 and IssueID 16449
                            'Purpose: Setting - Under the filter 'CreatedBy' or the Column 'CreatedBy ' no values are present for the Show History 
                            'Issue Id=16248 APP_TAG_Initiation_Note
                            'Issue id=16539 APP_TAG_ProjectWorkPlan
                            'Issue id=16449 APP_TAG_Request_Feedback_Parameters
                            'Issue Id=16135 APP_TAG_BUSINESS_GROUP
                        Case CommonFunction.Constants.APP_TAG_Initiation_Note, CommonFunction.Constants.APP_TAG_ProjectWorkPlan, CommonFunction.Constants.APP_TAG_Request_Feedback_Parameters, CommonFunction.Constants.APP_TAG_BUSINESS_GROUP
                            If Args.ControlName.ToUpper = "MODIFIEDBY" Then
                                Args.IgnoreActualValue = True
                                Args.NewValue = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "")

                            End If
                            'Addtion Ended
                            'Added By NileshD on 3 August 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_DISPATCHED_DETAILS
                            If Args.ControlName.ToUpper = "DISPATCHEDBY" Then
                                If drControls("dispatchedby").ToString = "" Then
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "")
                                End If
                            End If
                            If Args.ControlName.ToUpper = "COURIERDATE" Then
                                If drControls("COURIERDATE").ToString = "" Then
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.GetDataScalar("SELECT GETDATE()", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Date)).ToString
                                End If
                            End If
                            ' End of Addition
                            '------Added by DiptiK on 25 sep
                        Case CommonFunction.Constants.APP_TAG_TAB_BASELINE_REVISION_REASON
                            'Modified by ShamkantD on 29 Sep 2004
                            If Args.ControlName.ToUpper() = "ReasonForRevision".ToUpper() Then
                                Dim strReason As String = ""
                                Dim StrSQL As String = ""
                                Dim strRevisionReasonID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RevisionReasonID"), "0").ToString()
                                Dim strMode As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "").ToString().ToUpper().Trim()
                                If strMode <> "" Then
                                    StrSQL = "EXEC usp_Sel_PM_Project_Baseline_Revision_Rejection_Reason " & strRevisionReasonID & ",'" & Left(strMode, 1) & "'"
                                    strReason = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(StrSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
                                End If
                                Args.IgnoreActualValue = True
                                Args.NewValue = strReason.Trim()
                            End If
                            '-------
                            'End of modification - ShamkantD on 29 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_PM_STAKEHOLDER

                            If HttpContext.Current.Request.QueryString("ComboRefresh") = "Category" Then
                                If Not IsNothing(HttpContext.Current.Request.Form(Args.ControlName)) Then
                                    If Args.ControlName.ToUpper = "CONTACTCATEGORYID" Then
                                        Args.IgnoreActualValue = True
                                        Args.NewValue = HttpContext.Current.Request.Form(Args.ControlName).ToString
                                    End If
                                End If
                            End If

                            If Args.ControlName.ToUpper = "NONDATABASE1" Then
                                Dim drCustomerName As IDataReader

                                drCustomerName = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_CustomerInformation_New " _
                                 & CType(HttpContext.Current.Session("intProjectID"), String), True)
                                If drCustomerName.Read() Then
                                    Args.NewValue = DirectCast(drCustomerName("Customer Name"), String)
                                    Args.IgnoreActualValue = True
                                End If

                                CommonFunction.Data.DisposeDataReader(drCustomerName)
                            End If


                            Select Case HttpContext.Current.Session("Tmp_ContactCategoryID")
                                Case "O"           'Organization
                                    Select Case Args.ControlName.ToUpper
                                        Case "NAME"
                                            'Following Code block will change the nature of control from textbox to 
                                            'combo box and will represent the EmployeeID column instead of Name column
                                            'whenever User Selects organization Type ComboBox 
                                            Args.ControlTypeID = 2
                                            'If Not (drControls Is Nothing) Then
                                            If Args.IsEditMode Then
                                                Args.AdditionalInformation = "usp_Sel_tbl_PM_ProjectResources " + CStr(HttpContext.Current.Session("intProjectID")) + CType(IIf(IsDBNull(drControls("EmployeeID")), "", "," & CType(drControls("EmployeeID"), String)), String)
                                                '' Args.AdditionalInformation = "usp_Sel_tbl_PM_ProjectResources " + CStr(HttpContext.Current.Session("intProjectID")) + CType(IIf(IsDBNull(drControls("EmployeeID")), "", "," & CType(IIf(IsDBNull(drControls("EmployeeID")), String)

                                                Args.DropDownEditSQL = "usp_Sel_tbl_PM_ProjectResources " + CStr(HttpContext.Current.Session("intProjectID")) + CType(IIf(IsDBNull(drControls("EmployeeID")), "", "," & CType(drControls("EmployeeID"), String)), String)
                                            Else
                                                Args.AdditionalInformation = "usp_Sel_tbl_PM_ProjectResources " + CStr(HttpContext.Current.Session("intProjectID"))
                                                Args.DropDownEditSQL = "usp_Sel_tbl_PM_ProjectResources " + CStr(HttpContext.Current.Session("intProjectID"))

                                            End If
                                            Args.ControlName = "Name"
                                            Args.FieldDataTypeID = 1
                                            Args.IgnoreActualValue = True
                                            If Not (drControls Is Nothing) Then
                                                Args.NewValue = CType(IIf(IsDBNull(drControls("EmployeeID")), "", drControls("EmployeeID")), String)
                                            End If
                                    End Select
                            End Select

                            'added by SachinR   On 5 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLE_CODE_DEFINITION

                            'set the value of code prefix to company short name default
                            If Args.ControlName.ToLower = "nondatabase3" Then
                                Dim strSQL As String
                                Dim strShortName As String
                                'strSQL = "Select ShortCompanyName From tbl_PM_CompanyInformation"
                                'Code added By VidyaJ on 8th Dec 2004
                                strSQL = " Select ShortCompanyName+'-' +Isnull(C.ShortName,'') From tbl_PM_CompanyInformation,tbl_PM_CompanySchedules C Where ScheduleID= " + Args.PrimaryKeyValue

                                strShortName = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString
                                Args.IgnoreActualValue = True
                                Args.NewValue = strShortName.Trim

                                'added by SachinR   on 16 Nov 2004
                            ElseIf Args.ControlName.ToLower = "nondatabase4" Then
                                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromUI"), "") <> "" Then
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = "Yes"
                                Else
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("NonDatabase4"), "")
                                End If
                                'addition end on 16 Nov 2004
                            End If
                            'addition end
                            'Commented by PrashantSJ on 10th May 2007
                            'Purpose: In Code prefix field all Invoice series get dispalying because of following code
                            'so there is no need to have this code.
                            'added by SachinR   On 06 Aug 2004
                            'Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_SERIES_GENERATION
                            '    'set the value of code prefix to company short name default
                            '    If Args.ControlName.ToLower = "nondatabase1" Then
                            '        Dim strSQL As String
                            '        Dim objDr As IDataReader
                            '        Dim strInvoiceCode As String
                            '        Dim strPrefix As String
                            '        Dim arrList As System.Collections.ArrayList

                            '        arrList = New System.Collections.ArrayList

                            '        strSQL = "Select InvoiceNumberGenerationFormula From tbl_PM_CompanyInformation "
                            '        strInvoiceCode = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").tostring

                            '        strSQL = "usp_Sel_GetSequence_InvoiceGenerationSeries 'SEQ'"
                            '        objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            '        While objDr.Read
                            '            arrList.Add(CommonFunction.Data.CheckIsDBNull(objDr("Code"), "").ToString)
                            '        End While
                            '        CommonFunction.Data.DisposeDataReader(objDr)

                            '        Dim arrFields(arrList.Count - 1) As String
                            '        arrList.CopyTo(arrFields)
                            '        arrList.Clear()
                            '        arrList = Nothing

                            '        Dim i As Integer
                            '        Dim intFoundAtIndex As Integer
                            '        For i = 0 To arrFields.Length - 1
                            '            intFoundAtIndex = InStr(1, strInvoiceCode, arrFields(i), 0)
                            '            If intFoundAtIndex <> 0 Then
                            '                Exit For
                            '            End If
                            '        Next

                            '        If i > arrFields.Length - 1 Then
                            '            strPrefix = strInvoiceCode
                            '            Exit Sub
                            '        Else
                            '            strPrefix = Left(strInvoiceCode, intFoundAtIndex - 1)
                            '        End If

                            '        Args.IgnoreActualValue = True
                            '        Args.NewValue = strPrefix.Trim
                            '    End If
                            'addition end

                            'added by SachinR   on 07 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_CUSTOMER_ADDRESSES
                            'here selected value of address code in the combo is persisted
                            If Args.ControlName.ToLower = "addresscode" Then
                                Dim strAddressCode As String
                                Dim strCustomerID As String
                                strAddressCode = HttpContext.Current.Request.QueryString("CustomerAddressID") + ""
                                strCustomerID = HttpContext.Current.Request.QueryString("CustomerID") + ""
                                Args.AdditionalInformation = "usp_Sel_tbl_PM_Customer_Addresses_ForProject " + strCustomerID.Trim
                                Args.DropDownEditSQL = "usp_Sel_tbl_PM_Customer_Addresses_ForProject " + strCustomerID.Trim
                                Args.IgnoreActualValue = True
                                Args.NewValue = strAddressCode.Trim
                                If HttpContext.Current.Request.QueryString("ReadOnly") = "1" Then
                                    Args.Editable = False
                                End If

                                'addition end
                                'Trupti
                                Dim Token As String = CommonFunctions.Security.Token.GetToken(HttpContext.Current.Request.QueryString("CustomerAddressID") + HttpContext.Current.Session("intUserID").ToString + "0" + "2114")
                                Dim read As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ReadOnly"), "").ToString
                                Args.FunctionCall = "OnChange=javascript:AddressCode_OnChange();"
                                Args.FunctionBody = "function AddressCode_OnChange(){" + vbCrLf
                                Args.FunctionBody += "var objCbo,objTxt;var strAddressCode;" + vbCrLf
                                Args.FunctionBody += "var str='" + Token + "';" + vbCrLf
                                Args.FunctionBody += "var str1='" + read + "';" + vbCrLf
                                Args.FunctionBody += "objCbo=GetObjectReference('frmCommonPage','AddressCode');" + vbCrLf
                                Args.FunctionBody += " objTxt=GetObjectReference('frmCommonPage','CustomerID');" + vbCrLf
                                Args.FunctionBody += "if(objCbo.value!=""""){" + vbCrLf
                                Args.FunctionBody += "strAddressCode=objCbo.value;" + vbCrLf
                                Args.FunctionBody += "var objfrm = GetFormReference('frmCommonPage');" & vbCrLf
                                Args.FunctionBody += "objfrm.action=""CommonPage.aspx?PKToken="" + str + ""&FromWhere=SM&MasterTagID=2114&CustomerAddressID="" + strAddressCode + ""&CustomerID="" + objTxt.value + ""&ReadOnly=""+ str1;" + vbCrLf
                                'CommonPage.aspx?PKToken="""+str"+ "+" + str1 + "&FromWhere=SM&MasterTagID=2114&CustomerAddressID="+str1 +"+strAddressCode+" + "&CustomerID=" + str1+ "+ objTxt.value"+ str1+";" ;
                                'Args.FunctionBody += "objfrm.action=""" + "CommonPage.aspx?PKToken="" + str + ""&FromWhere=SM&MasterTagID=2114&CustomerAddressID=""+ strAddressCode +""&CustomerID="" + objTxt.value"";"
                                Args.FunctionBody += "objfrm.submit(); }}"
                            End If
                            'End by Trupti
                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                            'Added By SandeepA on 14 Nov,2005 for IssueID - 671
                            'Purpose: To Show/Hide the control 'Code Template' depending on IsCodeTemplateEditable flag
                        Case CommonFunction.Constants.APP_TAG_PRS_DELIVERABLE_TYPES
                            If Args.ControlName.ToUpper = "CODETEMPLATE" Then
                                Dim strScheduleID As String
                                Dim strSQLQuery As String
                                Dim intResult As Integer
                                Dim blnUseSQL As Boolean

                                blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
                                'Check if the Code Template is Editable
                                strScheduleID = CommonFunctions.General.CheckIsNothing(Args.PrimaryKeyValue, "0")
                                strSQLQuery = "If Exists(Select 1 from tbl_PM_CompanySchedules where ScheduleID=" & strScheduleID & " and IsCodeTemplateEditable=1)Select (Select 1 from tbl_PM_CompanySchedules where ScheduleID=" & strScheduleID & " and IsCodeTemplateEditable=1) Else Select 0"
                                intResult = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery, blnUseSQL), "0"), Integer)
                                If intResult = 0 Then
                                    'If Code Template is editable then show the Code Template TextBox
                                    Args.Editable = False
                                Else
                                    'If Code Template is not editable then Hide the Code Template TextBox
                                    Args.Editable = True
                                    Args.IsHidden = True
                                End If
                            End If
                            'End of Addition by SandeepA on 14 Nov,2005 for IssueID - 671
                            'End Integration

                            'added by SachinR   On 17 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_ISSUE_CODEGENERATION
                            'set the value of code prefix to company short name default
                            If Args.ControlName.ToLower = "nondatabase3" Then
                                Dim strSQL As String
                                Dim strShortName As String
                                strSQL = "Select ShortCompanyName From tbl_PM_CompanyInformation"
                                strShortName = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "").ToString
                                Args.IgnoreActualValue = True
                                Args.NewValue = strShortName.Trim
                            End If
                            'addition end

                            'added by SachinR   on 18 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE

                            Dim strSQL As String
                            Dim blnUseSQL As Boolean
                            Dim objDr As IDataReader
                            Dim strScheduleTypeID As String
                            Dim strProjectStartDate As String
                            Dim strProjectEndDate As String
                            Dim strProjectEffort As String
                            blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

                            'Integrated by MrugajaB on 16th Dec 2005 for Whiz2
                            'Added By SandeepA on 11 Nov,2005 for IssueID--671
                            'Purpose : If the flag in table tbl_PM_CompanySchedules i.e. IsCodeTemplateEditable=1
                            '          then show the code template textbox in editable mode else show readonly
                            If Args.ControlName.ToUpper = "DOCUMENTNO" Then
                                Dim strSQLQuery As String
                                Dim intResult As Integer

                                If Args.IsEditMode = False Then
                                    'ADD_NEW MODE
                                    strScheduleTypeID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ScheduleTypeID"), "None")
                                    'Get the Result
                                    strSQLQuery = "If Exists(Select 1 from tbl_PM_CompanySchedules where ScheduleID=" & strScheduleTypeID & " and IsCodeTemplateEditable=1)Select (Select 1 from tbl_PM_CompanySchedules where ScheduleID=" & strScheduleTypeID & " and IsCodeTemplateEditable=1) Else Select 0"
                                    intResult = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery, blnUseSQL), "0"), Integer)
                                    'if intResult is 1 -Show 'CodeTemplate' in Editable Mode with Mandatory, Else dont show the control
                                    If intResult = 1 Then
                                        'Show Editable and Mandatory
                                        Args.Editable = True
                                        Args.Mandatory = True
                                    Else
                                        'Cancel 
                                        Cancel = True
                                    End If
                                Else
                                    'EDIT MODE
                                    'Get the ScheduletypeID
                                    strSQLQuery = "If Exists(Select ScheduleTypeID from tbl_PM_OtherSchedules where ScheduleID=" & Args.PrimaryKeyValue.ToString & ")Select(Select ScheduleTypeID from tbl_PM_OtherSchedules where ScheduleID=" & Args.PrimaryKeyValue.ToString & ")Else Select 0"
                                    strScheduleTypeID = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery, blnUseSQL), "0"))
                                    'Get the Result
                                    strSQLQuery = "If Exists(Select 1 from tbl_PM_CompanySchedules where ScheduleID=" & strScheduleTypeID & " and IsCodeTemplateEditable=1)Select (Select 1 from tbl_PM_CompanySchedules where ScheduleID=" & strScheduleTypeID & " and IsCodeTemplateEditable=1) Else Select 0"
                                    intResult = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery, blnUseSQL), "0"), Integer)
                                    'if intResult is 1 -Show 'CodeTemplate' in Editable Mode with Mandatory, Else Show Readonly
                                    If intResult = 1 Then
                                        'Show Editable and Mandatory
                                        '-- Modified By purvaj on 16 Jun 2009 Code template should be editable in edit mode depending on the setting done for deliverable type.
                                        '-- in both if and else part , editable was set to false
                                        'Args.Editable = False
                                        Args.Editable = True
                                        '-- End modification purvaj
                                        'Args.Mandatory = True
                                    Else
                                        'Show Read Only 
                                        Args.Editable = False
                                    End If
                                End If

                            End If
                            'End of addition By SandeepA on 11 Nov,2005 for IssueID--671
                            'End Integration
                            ''Added By ManishK On 18th Jan 2006 to change The Source for the Assign To combo on Deliverable page for helpdesk
                            If CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "")).ToUpper = "ADD_NEW" And CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation"), "")).ToUpper <> "SAVE" And CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper = "CRM" Then
                                If Args.ControlName.ToLower = "responsibleperson" Then
                                    Dim strFunctionID As String
                                    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FunctionID"), "") <> "" Then
                                        strFunctionID = HttpContext.Current.Request.QueryString("FunctionID")
                                    End If

                                    strSQL = " usp_CRM_Get_FunctionEmployees " + strFunctionID.Trim + ", 1"
                                    Args.AdditionalInformation = strSQL
                                    Args.IgnoreActualValue = True
                                    Args.DropDownEditSQL = strSQL

                                End If
                            End If
                            ''End fo addition by Manishk On 18th Jan 06


                            'set the Sp for status combobox with parameters (projectID and ScheduletypeID)
                            If Args.ControlName.ToLower = "status" Then

                                'Modified by SachinR    on 12 Oct 2004
                                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ScheduleTypeID"), "") <> "" Then
                                    strScheduleTypeID = HttpContext.Current.Request.QueryString("ScheduleTypeID")
                                End If
                                'modification end

                                If strScheduleTypeID = "" Then strScheduleTypeID = "NULL"


                                strSQL = "usp_Sel_tbl_IB_Project_Type_Status_Deliverables " + strScheduleTypeID.Trim + "," + WhizGlobal.ProjectID.ToString
                                If Args.PrimaryKeyValue <> "" And Args.PrimaryKeyValue <> "0" Then
                                    strSQL += "," + Args.PrimaryKeyValue.Trim
                                Else
                                    strSQL += ",NULL"
                                End If
                                'added by SachinR   on 27 Oct 2004
                                'To get the status which are accessible to the current role
                                strSQL += ",'" + WhizGlobal.UserName.Trim + "'"
                                'addition end
                                Args.AdditionalInformation = strSQL
                                Args.DropDownEditSQL = strSQL

                                'added by SachinR   on 03 Sep 2004
                            ElseIf Args.ControlName.ToUpper = "NONDATABASE1" Then
                                strSQL = "usp_Sel_tbl_PM_Project " + WhizGlobal.ProjectID.ToString
                                objDr = CommonFunction.Data.GetDataReader(strSQL, blnUseSQL)
                                If objDr.Read Then
                                    strProjectStartDate = CommonFunction.Data.CheckIsDBNull(objDr("ExpectedStartDate"), "").ToString
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)

                                If strProjectStartDate <> "" Then
                                    strProjectStartDate = CommonFunction.Dates.GetDate(CType(strProjectStartDate, Date)) + ""
                                End If

                                Args.IgnoreActualValue = True
                                Args.NewValue = strProjectStartDate.Trim

                            ElseIf Args.ControlName.ToUpper = "NONDATABASE2" Then
                                strSQL = "usp_Sel_tbl_PM_Project " + WhizGlobal.ProjectID.ToString
                                objDr = CommonFunction.Data.GetDataReader(strSQL, blnUseSQL)
                                If objDr.Read Then
                                    strProjectEndDate = CommonFunction.Data.CheckIsDBNull(objDr("ExpectedEndDate"), "").ToString
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)

                                If strProjectEndDate <> "" Then
                                    strProjectEndDate = CommonFunction.Dates.GetDate(CType(strProjectEndDate, Date)) + ""
                                End If

                                Args.IgnoreActualValue = True
                                Args.NewValue = strProjectEndDate.Trim

                            ElseIf Args.ControlName.ToUpper = "NONDATABASE3" Then
                                strSQL = "usp_Sel_tbl_PM_Project " + WhizGlobal.ProjectID.ToString
                                objDr = CommonFunction.Data.GetDataReader(strSQL, blnUseSQL)
                                If objDr.Read Then
                                    strProjectEffort = CommonFunction.Data.CheckIsDBNull(objDr("EstimatedEfforts"), "").ToString
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)

                                If strProjectEffort = "" Then strProjectEffort = "0"

                                Args.IgnoreActualValue = True
                                Args.NewValue = strProjectEffort.Trim

                                'addition end
                                'added by SachinR   on 12 Oct 2004
                            ElseIf Args.ControlName.ToUpper = "SCHEDULETYPEID" Then
                                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ScheduleTypeID"), "") <> "" Then
                                    strScheduleTypeID = HttpContext.Current.Request.QueryString("ScheduleTypeID")
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = strScheduleTypeID.Trim
                                End If

                            End If
                            'addition end

                            'Added By ShamkantD for Check List Items on 24 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_CHECKLIST_ITEMS
                            If Args.ControlName.ToUpper = "CREVIEWCAUSEID" Then
                                Dim strSQL As String
                                Dim drGetIsSingleSelection As IDataReader
                                Dim blnMultipleSelection As Boolean
                                Dim blnSingleSelection As Boolean

                                Dim intQuestionID As String

                                intQuestionID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("QuestionID_PK")).ToString
                                If intQuestionID = "" Then
                                    intQuestionID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("QuestionID")).ToString

                                End If

                                If intQuestionID <> "" Then
                                    strSQL = "Select * From tbl_Q_Question Where QuestionID = " + intQuestionID
                                    drGetIsSingleSelection = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))


                                    If drGetIsSingleSelection.Read Then
                                        blnMultipleSelection = CType(CommonFunctions.Data.CheckIsDBNull(drGetIsSingleSelection("MultipleSelection"), "0"), Boolean)
                                        blnSingleSelection = CType(CommonFunctions.Data.CheckIsDBNull(drGetIsSingleSelection("SingleSelection"), "0"), Boolean)
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(drGetIsSingleSelection)

                                    If blnMultipleSelection = True Or blnSingleSelection = False Then

                                        Args.DisableInEditMode = True

                                    End If
                                End If
                                'Added By PrachiK on 10 Mar 2005 for Issue ID 16206. 
                                'Purpose: After creating a checklist item , we can associate a Review cause to a multiple answers
                                Dim strSingleSelection As String
                                Dim intPos As Integer
                                strSingleSelection = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("AnswerSetID")), String)
                                strSQL = " Exec usp_Sel_tbl_Q_AnswerSet " + strSingleSelection
                                drGetIsSingleSelection = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drGetIsSingleSelection.Read Then
                                    strSingleSelection = CType(CommonFunctions.Data.CheckIsDBNull(drGetIsSingleSelection("AnswerSetName"), "0"), String)
                                End If
                                CommonFunctions.Data.DisposeDataReader(drGetIsSingleSelection)
                                intPos = InStr(1, strSingleSelection.ToUpper, "MULTIPLE", CompareMethod.Text)
                                If intPos >= 1 Then
                                    Args.Editable = False

                                End If
                                'Addition ended


                            End If

                            'End Addition
                            'added by JayavantK on 18 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_EMPLOYEE_MAINTENANCE
                            Dim drTemp As IDataReader
                            Dim strQuery As String = ""
                            Dim intCount As Integer = 0
                            Dim lngBusinessGroupID, lngOUPoolID, lngEmployeeID As Long

                            If Args.ControlName.ToUpper = "BUSINESSGROUPID" Then
                                Dim strOUPool As String = ""

                                'Added by NitinVS on 25 November 2004 
                                'commented StrQuery and if condition 
                                'strQuery = "SELECT ResourceAllocationLevel FROM tbl_PM_CompanyInformation"
                                'If CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "") = "ODC" Then
                                'End addition  NitinVS 25 November 2004

                                Args.ToBeInserted = "onchange='javascript:BusinessGroup_Change(0)'"
                                'Integrated by SandipL SP8 to SP9

                                'Added by SandipL on 9 April 2007 -- dropdown not showing existing value in edit mode
                                Args.FunctionBody &= "  var objBGId = GetObjectReference('frmCommonPage','BusinessGroupID');" & vbCrLf
                                Args.FunctionBody &= "  var objOUPool = GetObjectReference('frmCommonPage','LocationID');" & vbCrLf
                                Args.FunctionBody += " var objDU=GetObjectReference('frmCommonPage','ResourcePoolID'); " + vbCrLf
                                Args.FunctionBody += " var objDT=GetObjectReference('frmCommonPage','GroupID'); " + vbCrLf
                                'End addition by SandipL on 9 April
                                Args.FunctionBody &= "var arrBG_OU = new Array();" & vbCrLf
                                strQuery = "SELECT BusinessGroupID, OUPoolID, Location FROM tbl_CNF_BusinessGroup_OUPools"
                                strQuery &= " INNER JOIN tbl_PM_Location ON LocationID = OUPoolID "
                                'Added by SandipL on 06 April 2007 -- Show active OS
                                strQuery &= " WHERE Isnull(tbl_PM_Location.Active,0) = 1 "
                                If Args.PrimaryKeyValue <> "" And Args.PrimaryKeyValue <> "0" Then
                                    'Added by ArchanaN
                                    'After saving the record in Resource Joining Pool drControl is nothing
                                    Dim strLocationID As String

                                    If drControls Is Nothing Then
                                        strLocationID = HttpContext.Current.Request.Form("LocationID").ToString
                                    Else
                                        strLocationID = drControls("LocationID").ToString
                                    End If
                                    ' End of Added by ArchanaN
                                    strQuery &= " OR tbl_PM_Location.LocationID=" & strLocationID
                                End If
                                strQuery &= " Order by tbl_PM_Location.Location "
                                'End addition by SandipL on 06 April
                                'End Integration by SandipL SP8 to SP9                               
                                drTemp = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                While drTemp.Read()
                                    lngBusinessGroupID = CType(CommonFunctions.Data.CheckIsDBNull(drTemp.Item("BusinessGroupID"), "0"), Long)
                                    lngOUPoolID = CType(CommonFunctions.Data.CheckIsDBNull(drTemp.Item("OUPoolID"), "0"), Long)
                                    strOUPool = CommonFunctions.General.CheckIsNothing(drTemp.Item("Location"), "")
                                    'Write Code Fro Replce ' with \
                                    'Modified By ShraddhaM on 13 Sep 2006 for SP7 Issue ID :6210
                                    strOUPool = strOUPool.Replace("'", "\'")
                                    'End of Modification By ShraddhaM on 13 Sep 2006 for SP7 Issue ID :6210
                                    Args.FunctionBody &= "arrBG_OU[" & intCount.ToString() & "] = new Array(3);" & vbCrLf
                                    Args.FunctionBody &= "arrBG_OU[" & intCount.ToString() & "][0] = " & lngBusinessGroupID.ToString() & ";" & vbCrLf
                                    Args.FunctionBody &= "arrBG_OU[" & intCount.ToString() & "][1] = " & lngOUPoolID.ToString() & ";" & vbCrLf
                                    Args.FunctionBody &= "arrBG_OU[" & intCount.ToString() & "][2] = '" & strOUPool & "';" & vbCrLf
                                    intCount = intCount + 1
                                End While
                                ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                CommonFunction.Data.DisposeDataReader(drTemp)
                                ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                lngEmployeeID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeID_PK"), "0"), Long)
                                'Added by VidyaJ on 12 Jan 2004 - IssueID -14786
                                If lngEmployeeID = 0 Then
                                    Dim strEmpID As String
                                    strEmpID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeID"), "0")
                                    If strEmpID = "" Then
                                        strEmpID = "0"
                                    End If
                                    lngEmployeeID = CType(strEmpID, Long)
                                End If
                                'End of addition

                                If lngEmployeeID > 0 Then
                                    'Integrated by SandipL SP8 to SP9
                                    'modified by SandipL on 9 April 2007 -- dropdown not showing existing value in edit mode
                                    'Args.FunctionBody &= " BusinessGroup_Change();" & vbCrLf
                                    'Modified By VarunA on 26-Jan-2008 RequestID-11144
                                    'Args.FunctionBody &= "  var SelectedOUPool= objOUPool.value;" & vbCrLf
                                    Args.FunctionBody &= "  if(objOUPool) { var SelectedOUPool= objOUPool.value; }" & vbCrLf
                                    'End By VarunA on 26-Jan-2008 RequestID-11144
                                    Args.FunctionBody &= " BusinessGroup_Change(1);" & vbCrLf
                                    'Modified By VarunA on 26-Jan-2008 RequestID-11144
                                    'Args.FunctionBody &= " if (SelectedOUPool!=''){objOUPool.value = SelectedOUPool;} "
                                    Args.FunctionBody &= " if (SelectedOUPool){ if (SelectedOUPool!=''){objOUPool.value = SelectedOUPool;}} "
                                    'End By VarunA on 26-Jan-2008 RequestID-11144
                                    'End modfications by SandipL on 09 April 2007
                                    'End Integration by SandipL SP8 to SP9
                                End If

                                'Modified by NiranjanK on Date July 05,2006 for WhizibleSEM Issue ID.4168
                                'create function to add new option in combo box at runtime.
                                Args.FunctionBody &= "function AddOption(strValue,strText)" & vbCrLf
                                Args.FunctionBody &= "{" & vbCrLf
                                Args.FunctionBody &= "objNewElement = document.createElement('OPTION');" & vbCrLf
                                Args.FunctionBody &= "objNewElement.innerHTML = strText;" & vbCrLf
                                Args.FunctionBody &= "objNewElement.value = strValue;" & vbCrLf
                                Args.FunctionBody &= "return objNewElement;" & vbCrLf
                                Args.FunctionBody &= "}" & vbCrLf
                                'End of modification by NiranjanK on July 05,2006 Isse ID.4168

                                Args.FunctionBody &= "function BusinessGroup_Change(intWhen){" & vbCrLf

                                'Commented by SandipL
                                '''Args.FunctionBody &= "  var objBGId = GetObjectReference('frmCommonPage','BusinessGroupID');" & vbCrLf
                                '''Args.FunctionBody &= "  var objOUPool = GetObjectReference('frmCommonPage','LocationID');" & vbCrLf
                                'Modified By ShraddhaM For Issue ID : 5183 on 11 Sep 2006

                                Args.FunctionBody &= " if (objBGId!=null && objOUPool !=null) {" & vbCrLf
                                'Args.FunctionBody &= "alert('hi1');" & vbCrLf


                                Args.FunctionBody &= "  var lngSelectedOUPool, i, lngBGId = objBGId[objBGId.selectedIndex].value;" & vbCrLf
                                Args.FunctionBody &= "  if(lngBGId > 0){ i = 0;" & vbCrLf
                                'Modified by NiranjanK on Date July 05,2006 for WhizibleSEM Issue ID.4168
                                Args.FunctionBody &= " if (objOUPool[objOUPool.selectedIndex]!=null) {" & vbCrLf
                                Args.FunctionBody &= "    lngSelectedOUPool = objOUPool[objOUPool.selectedIndex].value;" & vbCrLf
                                Args.FunctionBody &= " } else " & vbCrLf
                                Args.FunctionBody &= " { " & vbCrLf
                                Args.FunctionBody &= "lngSelectedOUPool='';" & vbCrLf
                                Args.FunctionBody &= " } " & vbCrLf

                                Args.FunctionBody &= "    objOUPool.length = 0;" & vbCrLf
                                'Args.FunctionBody &= "    objOUPool.add(new Option('', ''));" & vbCrLf
                                Args.FunctionBody &= "    objOUPool.appendChild(AddOption('',''));" & vbCrLf
                                Args.FunctionBody &= "    for(i=0; i < arrBG_OU.length;i++){" & vbCrLf
                                Args.FunctionBody &= "    if(lngBGId == arrBG_OU[i][0]){" & vbCrLf
                                'Args.FunctionBody &= "        objOUPool.add(new Option(arrBG_OU[i][2], arrBG_OU[i][1]));" & vbCrLf
                                Args.FunctionBody &= "        objOUPool.appendChild(AddOption(arrBG_OU[i][1],arrBG_OU[i][2]));" & vbCrLf
                                Args.FunctionBody &= "        if(arrBG_OU[i][1] == lngSelectedOUPool){" & vbCrLf
                                Args.FunctionBody &= "            objOUPool.selectedIndex = objOUPool.length - 1;" & vbCrLf
                                Args.FunctionBody &= "        }" & vbCrLf
                                Args.FunctionBody &= "     }" & vbCrLf
                                Args.FunctionBody &= "    }" & vbCrLf
                                'Added By NitinVS on 20 FEb 2007 for WhizibleSEM SP 9 
                                Args.FunctionBody &= "    if(objOUPool != null ) " & vbCrLf
                                Args.FunctionBody &= "    objOUPool.focus();" & vbCrLf
                                ' End Addition By NitinVS on 20 FEb 2007 for WhizibleSEM SP 9 

                                Args.FunctionBody &= "  }" & vbCrLf
                                'Added by ShamkantD on 16 Dec 2004
                                'When no value is selected in Business Group Combobox, the 
                                'Organization Unit combobox should be blanked out.
                                Args.FunctionBody &= "  else" & vbCrLf
                                Args.FunctionBody &= "  {" & vbCrLf
                                Args.FunctionBody &= "    objOUPool.length = 0;" & vbCrLf
                                'Args.FunctionBody &= "    objOUPool.add(new Option('', ''));" & vbCrLf
                                Args.FunctionBody &= "    objOUPool.appendChild(AddOption('', ''));" & vbCrLf
                                'End of modification by NiranjanK on July 05,2006 Isse ID.4168
                                Args.FunctionBody &= "  }" & vbCrLf

                                ' Added By MahendraV On 5:50 PM 5/25/2007 for IssueID : 12991
                                ' Start_MV_5/25/2007
                                Args.FunctionBody &= "  if(intWhen == 0){ " & vbCrLf
                                Args.FunctionBody &= "  if(objDU==null ) return;" + vbCrLf
                                Args.FunctionBody &= "      objDU.length = 0;" & vbCrLf
                                Args.FunctionBody &= "      objDU.appendChild(AddOption('',''));" & vbCrLf
                                Args.FunctionBody &= "  if(objDT == null ) return;" + vbCrLf
                                Args.FunctionBody &= "      objDT.length = 0;" & vbCrLf
                                Args.FunctionBody &= "      objDT.appendChild(AddOption('',''));" & vbCrLf
                                Args.FunctionBody &= "  }" & vbCrLf
                                ' End_MV_5/25/2007

                                'End of addition - ShamkantD on 16 Dec 2004
                                Args.FunctionBody &= "}" & vbCrLf
                                Args.FunctionBody &= " }" & vbCrLf

                                'Args.FunctionBody &= " else {" & vbCrLf
                                'Args.FunctionBody &= "alert('hi2');" & vbCrLf
                                'Args.FunctionBody &= " }" & vbCrLf



                                'Args.FunctionBody &= "  if(lngBGId > 0){ i = 0;" & vbCrLf
                                ''Modified by NiranjanK on Date July 05,2006 for WhizibleSEM Issue ID.4168
                                'Args.FunctionBody &= " if (objOUPool[objOUPool.selectedIndex]!=null) {" & vbCrLf
                                'Args.FunctionBody &= "    lngSelectedOUPool = objOUPool[objOUPool.selectedIndex].value;" & vbCrLf
                                'Args.FunctionBody &= " } else " & vbCrLf
                                'Args.FunctionBody &= " { " & vbCrLf
                                'Args.FunctionBody &= "lngSelectedOUPool='';" & vbCrLf
                                'Args.FunctionBody &= " } " & vbCrLf
                                'Args.FunctionBody &= "    objOUPool.length = 0;" & vbCrLf
                                ''Args.FunctionBody &= "    objOUPool.add(new Option('', ''));" & vbCrLf
                                'Args.FunctionBody &= "    objOUPool.appendChild(AddOption('',''));" & vbCrLf
                                'Args.FunctionBody &= "    for(i=0; i < arrBG_OU.length;i++){" & vbCrLf
                                'Args.FunctionBody &= "    if(lngBGId == arrBG_OU[i][0]){" & vbCrLf
                                ''Args.FunctionBody &= "        objOUPool.add(new Option(arrBG_OU[i][2], arrBG_OU[i][1]));" & vbCrLf
                                'Args.FunctionBody &= "        objOUPool.appendChild(AddOption(arrBG_OU[i][1],arrBG_OU[i][2]));" & vbCrLf

                                'Args.FunctionBody &= "        if(arrBG_OU[i][1] == lngSelectedOUPool){" & vbCrLf
                                'Args.FunctionBody &= "            objOUPool.selectedIndex = objOUPool.length - 1;" & vbCrLf
                                'Args.FunctionBody &= "        }" & vbCrLf
                                'Args.FunctionBody &= "     }" & vbCrLf
                                'Args.FunctionBody &= "    }" & vbCrLf
                                'Args.FunctionBody &= "  }" & vbCrLf
                                ''Added by ShamkantD on 16 Dec 2004
                                ''When no value is selected in Business Group Combobox, the 
                                ''Organization Unit combobox should be blanked out.
                                'Args.FunctionBody &= "  else" & vbCrLf
                                'Args.FunctionBody &= "  {" & vbCrLf
                                'Args.FunctionBody &= "    objOUPool.length = 0;" & vbCrLf
                                ''Args.FunctionBody &= "    objOUPool.add(new Option('', ''));" & vbCrLf
                                'Args.FunctionBody &= "    objOUPool.appendChild(AddOption('', ''));" & vbCrLf
                                ''End of modification by NiranjanK on July 05,2006 Isse ID.4168
                                'Args.FunctionBody &= "  }" & vbCrLf
                                ''End of addition - ShamkantD on 16 Dec 2004
                                'Args.FunctionBody &= "}" & vbCrLf
                                'commented by NitinVS on 25 November 2004 
                                'End If
                                ' Comment Ends NitinVS on 25 November 2004

                                'added by SachinR   on 08 Sep 2004
                                'write client side script to fill the Resource pool combo on the client side
                                'based on the OU selected.write array on the scient side with OUPoolID, ResourcePoolID and ResourcePool 
                            ElseIf Args.ControlName.ToUpper = "LOCATIONID" Then
                                Dim strResourcePool As String
                                Dim lngResourcePoolID As Long
                                intCount = 0
                                strResourcePool = ""
                                lngResourcePoolID = 0
                                lngOUPoolID = 0

                                Args.FunctionCall = " onchange='javascript:OUPool_OnChange(this,0)'"
                                Args.FunctionBody = "var arrOU_DU = new Array();" + vbCrLf
                                'Integrated by SandipL SP8 to SP9

                                strQuery = "usp_Sel_tbl_PM_OUPool_ResourcePools 0 "
                                ' Added by SandipL on 06 April 2007 show Acive + current DUs
                                If Args.PrimaryKeyValue <> "" And Args.PrimaryKeyValue <> "0" Then
                                    strQuery &= ",1," & Args.PrimaryKeyValue
                                End If
                                ' End addition by SandipL on 06 April 2007
                                'End Integration by SandipL SP8 to SP9

                                drTemp = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                While drTemp.Read
                                    lngOUPoolID = CType(CommonFunctions.Data.CheckIsDBNull(drTemp.Item("OUPoolID"), "0"), Long)
                                    lngResourcePoolID = CType(CommonFunctions.Data.CheckIsDBNull(drTemp.Item("ResourcePoolID"), "0"), Long)
                                    strResourcePool = CommonFunctions.General.CheckIsNothing(drTemp.Item("ResourcePoolName"), "")
                                    'Modified By ShraddhaM on 13 Sep 2006 for SP7 Issue ID :6210
                                    strResourcePool = strResourcePool.Replace("'", "\'")
                                    'End of Modification By ShraddhaM on 13 Sep 2006 for SP7 Issue ID :6210
                                    Args.FunctionBody += "arrOU_DU[" + intCount.ToString + "] = new Array(3);" + vbCrLf
                                    Args.FunctionBody += "arrOU_DU[" + intCount.ToString + "][0]= " + lngOUPoolID.ToString + ";" + vbCrLf
                                    Args.FunctionBody += "arrOU_DU[" + intCount.ToString + "][1]= " + lngResourcePoolID.ToString + ";" + vbCrLf
                                    Args.FunctionBody += "arrOU_DU[" + intCount.ToString + "][2]= '" + strResourcePool.Trim + "';" + vbCrLf
                                    intCount += 1
                                End While
                                CommonFunction.Data.DisposeDataReader(drTemp)
                                'Integrated by SandipL SP8 to SP9

                                'modified by SandipL on 9 April 2007 -- dropdown not showing existing value in edit mode
                                'Args.FunctionBody += " OUPool_OnChange(GetObjectReference('frmCommonPage','LocationID'));" + vbCrLf
                                If Args.PrimaryKeyValue <> "" And Args.PrimaryKeyValue <> "0" Then
                                    'Modified By VarunA on 26-Jan-2008 RequestID-11144
                                    'Args.FunctionBody &= "  var SelectedDU = objDU.value;" & vbCrLf
                                    Args.FunctionBody &= " if(objDU) { var SelectedDU = objDU.value; }" & vbCrLf
                                    'End By VarunA on 26-Jan-2008 RequestID-11144
                                    Args.FunctionBody += " OUPool_OnChange(this,1);" + vbCrLf
                                    'Modified By VarunA on 26-Jan-2008 RequestID-11144
                                    'Args.FunctionBody &= " if (SelectedDU!=''){objDU.value = SelectedDU;} "
                                    Args.FunctionBody &= "if(SelectedDU){ if (SelectedDU!=''){objDU.value = SelectedDU;} }"
                                    'End By VarunA on 26-Jan-2008 RequestID-11144
                                End If

                                'End modfications by SandipL on 09 April 2007
                                'Modified by NiranjanK on Date July 05,2006 for WhizibleSEM Issue ID.4168
                                'SandipL
                                'Args.FunctionBody += " function OUPool_OnChange(objOU){" + vbCrLf
                                Args.FunctionBody += " function OUPool_OnChange(objThis,intWhen){" + vbCrLf
                                'Modified By ShraddhaM For Issue ID : 5183 on 11 Sep 2006
                                Args.FunctionBody += " if(objOUPool!=null){" + vbCrLf
                                'Commented by SandipL objDU declared global
                                '''Args.FunctionBody += " var objDU=GetObjectReference('frmCommonPage','ResourcePoolID'); " + vbCrLf
                                Args.FunctionBody += " var intOUID=objOUPool.value; " + vbCrLf
                                'End Integration by SandipL SP8 to SP9                              
                                Args.FunctionBody += " if(objDU!=null){" + vbCrLf
                                Args.FunctionBody += " var intDUID=objDU.value; " + vbCrLf
                                Args.FunctionBody += " var i,intCount=0;" + vbCrLf
                                Args.FunctionBody += " objDU.options.length=0; " + vbCrLf
                                'Args.FunctionBody += " objDU.add(new Option('',''));" + vbCrLf
                                'Add Option function is defined while plotting BUSINESSGROUPID combo box. 
                                Args.FunctionBody += " objDU.appendChild(AddOption('',''));" + vbCrLf
                                Args.FunctionBody += " for(i=0;i<arrOU_DU.length;i++)" + vbCrLf
                                Args.FunctionBody += " {" + vbCrLf
                                Args.FunctionBody += " if(arrOU_DU[i][0]==intOUID){" + vbCrLf
                                'Args.FunctionBody += " objDU.add(new Option(arrOU_DU[i][2],arrOU_DU[i][1]));" + vbCrLf
                                Args.FunctionBody += " objDU.appendChild(AddOption(arrOU_DU[i][1],arrOU_DU[i][2]));" + vbCrLf
                                Args.FunctionBody += " }" + vbCrLf
                                Args.FunctionBody += " }" + vbCrLf
                                Args.FunctionBody += " if(intDUID!=''){ objDU.value=intDUID; }" + vbCrLf
                                Args.FunctionBody += "}" + vbCrLf
                                Args.FunctionBody += "}" + vbCrLf
                                'End of modification by NiranjanK on July 05,2006 Isse ID.4168
                                'Added By NitinVS on 20 FEb 2007 for WhizibleSEM SP 9 
                                Args.FunctionBody &= "    if ( objDU != null ) " & vbCrLf
                                Args.FunctionBody &= "    objDU.focus();" & vbCrLf
                                ' End Addition By NitinVS on 20 FEb 2007 for WhizibleSEM SP 9 

                                ' Added By MahendraV On 5:50 PM 5/25/2007 for IssueID : 12991
                                ' Start_MV_5/25/2007

                                Args.FunctionBody += "  if(intWhen == 0){ " & vbCrLf
                                Args.FunctionBody += " if(objDT == null ) return;" + vbCrLf
                                Args.FunctionBody += "      objDT.length = 0;" & vbCrLf
                                Args.FunctionBody += "   objDT.appendChild(AddOption('',''));" & vbCrLf
                                Args.FunctionBody += " }" + vbCrLf
                                ' End_MV_5/25/2007

                                Args.FunctionBody += " }" + vbCrLf
                            ElseIf Args.ControlName.ToUpper = "RESOURCEPOOLID" Then
                                Dim strGroupName As String
                                Dim lngGroupID As Long
                                Dim lngDUPoolID As Long
                                intCount = 0
                                strGroupName = ""
                                lngGroupID = 0
                                lngDUPoolID = 0

                                Args.FunctionCall = " onchange='javascript:DUPool_OnChange(this)'"
                                Args.FunctionBody = "var arrDU_DT = new Array();" + vbCrLf
                                'Integrated by SandipL SP8 to SP9

                                strQuery = "usp_Sel_tbl_PM_ResourcePool_Teams 0 "
                                ' Added by SandipL on 06 April 2007 show Acive + current DUs
                                If Args.PrimaryKeyValue <> "" And Args.PrimaryKeyValue <> "0" Then
                                    strQuery &= ",1," & Args.PrimaryKeyValue
                                End If
                                ' End addition by SandipL on 06 April 2007
                                'End Integration by SandipL SP8 to SP9
                                drTemp = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                While drTemp.Read
                                    lngDUPoolID = CType(CommonFunctions.Data.CheckIsDBNull(drTemp.Item("ResourcePoolID"), "0"), Long)
                                    lngGroupID = CType(CommonFunctions.Data.CheckIsDBNull(drTemp.Item("GroupID"), "0"), Long)
                                    strGroupName = CommonFunctions.General.CheckIsNothing(drTemp.Item("GroupName"), "")
                                    'Modified By ShraddhaM on 13 Sep 2006 for SP7 Issue ID :6210
                                    strGroupName = strGroupName.Replace("'", "\'")
                                    'End Of Modification By ShraddhaM on 13 Sep 2006 for SP7 Issue ID :6210
                                    Args.FunctionBody += "arrDU_DT[" + intCount.ToString + "] = new Array(3);" + vbCrLf
                                    Args.FunctionBody += "arrDU_DT[" + intCount.ToString + "][0]= " + lngDUPoolID.ToString + ";" + vbCrLf
                                    Args.FunctionBody += "arrDU_DT[" + intCount.ToString + "][1]= " + lngGroupID.ToString + ";" + vbCrLf
                                    Args.FunctionBody += "arrDU_DT[" + intCount.ToString + "][2]= '" + strGroupName.Trim + "';" + vbCrLf
                                    intCount += 1
                                End While
                                CommonFunction.Data.DisposeDataReader(drTemp)

                                'Integrated by SandipL SP8 to SP9


                                'modified by SandipL on 9 April 2007 -- dropdown not showing existing value in edit mode
                                'Args.FunctionBody += " DUPool_OnChange(GetObjectReference('frmCommonPage','ResourcePoolID'));" + vbCrLf
                                If Args.PrimaryKeyValue <> "" And Args.PrimaryKeyValue <> "0" Then
                                    'Modified By VarunA on 26-Jan-2008 RequestID-11144
                                    'Args.FunctionBody &= "  var SelectedDT = objDT.value;" & vbCrLf
                                    Args.FunctionBody &= "if(objDT) { var SelectedDT = objDT.value;}" & vbCrLf
                                    'End By VarunA on 26-Jan-2008 RequestID-11144
                                    Args.FunctionBody += " DUPool_OnChange();" + vbCrLf
                                    'Modified By VarunA on 26-Jan-2008 RequestID-11144
                                    'Args.FunctionBody &= "  if (SelectedDT!=''){ objDT.value = SelectedDT;} " + vbCrLf
                                    Args.FunctionBody &= "if(SelectedDT) {if (SelectedDT!=''){ objDT.value = SelectedDT;}} " + vbCrLf
                                    'End By VarunA on 26-Jan-2008 RequestID-11144
                                End If
                                'End modfications by SandipL on 09 April 2007
                                'Modified by NiranjanK on Date July 05,2006 for WhizibleSEM Issue ID.4168
                                Args.FunctionBody += " function DUPool_OnChange(){" + vbCrLf
                                'Modified By ShraddhaM For Issue ID : 5183 on 11 Sep 2006
                                Args.FunctionBody += " if(objDU!=null){" + vbCrLf
                                'SandipL
                                'Args.FunctionBody += " var objDT=GetObjectReference('frmCommonPage','GroupID'); " + vbCrLf
                                'End Integration by SandipL SP8 to SP9                                

                                Args.FunctionBody += " var intDUID=objDU.value; " + vbCrLf
                                Args.FunctionBody += " if(objDT!=null){" + vbCrLf
                                Args.FunctionBody += " var intDTID=objDT.value;" + vbCrLf
                                Args.FunctionBody += " var i,intCount=0;" + vbCrLf
                                Args.FunctionBody += " objDT.options.length=0; " + vbCrLf
                                'Args.FunctionBody += " objDT.add(new Option('',''));" + vbCrLf
                                Args.FunctionBody += " objDT.appendChild(AddOption('',''));" + vbCrLf
                                Args.FunctionBody += " for(i=0;i<arrDU_DT.length;i++)" + vbCrLf
                                Args.FunctionBody += " {" + vbCrLf
                                Args.FunctionBody += " if(arrDU_DT[i][0]==intDUID){" + vbCrLf
                                'Args.FunctionBody += " objDT.add(new Option(arrDU_DT[i][2],arrDU_DT[i][1]));" + vbCrLf
                                Args.FunctionBody += " objDT.appendChild(AddOption(arrDU_DT[i][1],arrDU_DT[i][2]));" + vbCrLf
                                Args.FunctionBody += " }" + vbCrLf
                                Args.FunctionBody += " }" + vbCrLf
                                Args.FunctionBody += " if(intDTID!='') { objDT.value=intDTID; }" + vbCrLf
                                Args.FunctionBody += "}" + vbCrLf

                                Args.FunctionBody += "}" + vbCrLf
                                'ShraddhaM
                                'Added By NitinVS on 20 FEb 2007 for WhizibleSEM SP 9 
                                Args.FunctionBody &= "    if( objDT != null ) " & vbCrLf
                                Args.FunctionBody &= "    objDT.focus();" & vbCrLf
                                ' End Addition By NitinVS on 20 FEb 2007 for WhizibleSEM SP 9 

                                Args.FunctionBody += " }" + vbCrLf
                                'addition end
                                'End of modification by NiranjanK on July 05,2006 Isse ID.4168
                            End If
                            ' Added by ArchanaN on 25 Jan 2008
                            '  Case CommonFunction.Constants.APP_TAG_EMPLOYEE_JOININGPOOL
                            Dim strFor As String
                            strFor = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("For"), "")
                            Dim strEmployeename As String
                            Dim strAddress As String
                            Dim strphone As String
                            Dim strRoleID As String
                            Dim strDesignationID As String
                            Dim dtJoiningDate As Date
                            Dim strEmployeeID As String
                            Dim EmpDetails As String
                            Dim strSQL As String
                            If strFor.ToUpper = "JOINPOOL" Then
                                strEmployeeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeID"), "")
                                strSQL = "Select EMPLOYEENAME from tbl_PM_Employee_Offered Where EmployeeID = " & strEmployeeID
                                strEmployeename = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), ""), String)

                                strSQL = "Select ADDRESS from tbl_PM_Employee_Offered Where EmployeeID = " & strEmployeeID
                                strAddress = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), String)

                                strSQL = "Select PHONE from tbl_PM_Employee_Offered Where EmployeeID = " & strEmployeeID
                                strphone = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), String)

                                strSQL = "Select POSTID from tbl_PM_Employee_Offered Where EmployeeID = " & strEmployeeID
                                strRoleID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), String)

                                strSQL = "Select DesignationID from tbl_PM_Employee_Offered Where EmployeeID = " & strEmployeeID
                                strDesignationID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), String)

                                strSQL = "Select JoiningDate from tbl_PM_Employee_Offered Where EmployeeID = " & strEmployeeID
                                dtJoiningDate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), Date)

                                If Args.ControlName.ToUpper = "EMPLOYEENAME" Then
                                    Args.DefaultValue = "1-" + CommonFunction.General.CheckIsNothing(strEmployeename, "")
                                End If
                                If Args.ControlName.ToUpper = "ADDRESS" Then
                                    Args.DefaultValue = "1-" + CommonFunction.General.CheckIsNothing(strAddress, "")
                                End If
                                If Args.ControlName.ToUpper = "PHONE" Then
                                    Args.DefaultValue = "1-" + CommonFunction.General.CheckIsNothing(strphone, "")
                                End If
                                If Args.ControlName.ToUpper = "POSTID" Then
                                    Args.DefaultValue = "1-" + CommonFunction.General.CheckIsNothing(strRoleID, "")
                                End If
                                If Args.ControlName.ToUpper = "DESIGNATIONID" Then
                                    Args.DefaultValue = "1-" + CommonFunction.General.CheckIsNothing(strDesignationID, "")
                                End If
                                If Args.ControlName.ToUpper = "JOININGDATE" Then
                                    Args.DefaultValue = "1-" + CommonFunction.General.CheckIsNothing(dtJoiningDate, "")
                                End If
                            End If
                            ' End of Added by ArchanaN on 25 Jan 2008
                            'Added By VarunA on 26-Jan-2008 RequestID-11144
                            'Purpose : To have employee image in view mode.
                            If Args.ControlName.ToUpper = "GENDER" Then
                                Dim strPhotoPath As String
                                Dim strPhotoPathQuery As String = ""
                                If Args.PrimaryKeyValue <> "" Then
                                    strPhotoPathQuery = "select  '../../Images/Photo/' + SystemFilename from tbl_RM_EmployeeMaintenance_Attachment  where employeeid = " + Args.PrimaryKeyValue
                                    strPhotoPath = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strPhotoPathQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), String)
                                    If strPhotoPath <> "" Then
                                        CommonFunction.General.WriteHTML("<Input type=hidden name=hidPhotoPath value=" + strPhotoPath + ">")
                                    Else
                                        CommonFunction.General.WriteHTML("<Input type=hidden name=hidPhotoPath value='../../Images/NoPreview.gif'>")
                                    End If
                                Else
                                    CommonFunction.General.WriteHTML("<Input type=hidden name=hidPhotoPath value='../../Images/NoPreview.gif'>")
                                End If
                            End If
                            'End By VarunA on 26-Jan-2008 RequestID-11144

                            'added by SachinR   on 1 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_PROCESS_PHASETASK
                            If Args.ControlName.ToUpper = "ISACTIVE" Then
                                If Args.IsEditMode = False Then
                                    Args.Editable = False
                                End If
                            End If
                            'addition end

                            ' Added By NitinVS on 14 Dec 2004 
                            'to make IsActive disabled 
                        Case CommonFunction.Constants.APP_TAG_PROCESS_PHASETASK_TEMPLATES
                            If Args.ControlName.ToUpper = "ISACTIVE" Then
                                If Args.IsEditMode = False Then
                                    Args.Editable = False
                                End If
                            End If
                            'addition end By NitinVS on 14 Dec 2004 

                            'Added by ShamkantD on 10th September 2004 - for Fast Track Reviews
                        Case CommonFunction.Constants.APP_TAG_FAST_TRACK_REVIEWS
                            '#####FAST TRACK REVIEW
                            If Args.ControlName.ToLower = "reviewee" And Args.IsEditMode = True Then
                                'Edit Mode
                                If CType(CommonFunction.Data.CheckIsDBNull(drControls("IsPlannedReview"), "False"), Boolean) = True Then
                                    'For the planned review do not allow to change the Reviewee
                                    Args.Editable = False
                                End If
                            End If
                            'Reviewer(s)
                            If Args.ControlName.ToLower = "reviewedby" Then
                                'Show Reviewer (s) text box disable
                                Args.Editable = False
                            End If
                            If Args.ControlName.ToUpper = "REVIEWEE" And Args.IsEditMode = True Then
                                Dim strQuery As String = ""
                                strQuery = "SELECT COUNT(ReviewActionID) FROM tbl_PM_ReviewActions"
                                strQuery &= " INNER JOIN tbl_PM_ProjectTasks ON tbl_PM_ProjectTasks.TaskID = tbl_PM_ReviewActions.TaskID AND IsActive=1"
                                strQuery &= " WHERE(tbl_PM_ReviewActions.ReviewStatisticsID = " & CommonFunctions.General.CheckIsNothing(drControls("ReviewStatisticsID"), "0") & ")"
                                If CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Integer) > 0 Then
                                    Args.Editable = False
                                End If
                                HttpContext.Current.Session("ReviewStatisticsId") = Args.PrimaryKeyValue
                            End If

                            If Args.ControlName.ToUpper = "CHECKLISTTYPEID" And Args.IsEditMode = True Then
                                'Check whether there are any responses posted for the selected checklist.
                                'if any responses are found then checklist cannot be changed ie the combo 
                                'will be disabled.
                                Dim blnChecklistResponded As Boolean = False
                                Dim strSQLQuery As String = "SELECT TOP 1 ProjectChecklistResponseId FROM tbl_PM_Checklistresponses Where ContextType = 'R' and ContextId =" & CommonFunction.General.CheckIsNothing(Args.PrimaryKeyValue, "0").ToString()
                                Dim drReview As IDataReader

                                drReview = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If drReview.Read Then
                                    blnChecklistResponded = True
                                End If
                                CommonFunction.Data.DisposeDataReader(drReview)

                                If blnChecklistResponded Then
                                    'Disable the Checklist combobox
                                    Args.DisableInEditMode = True
                                End If
                            End If

                            'End of addition - ShamkantD on 10th September 2004 

                            'Added By AmitD on 30 Oct 2004
                            If Args.ControlName.ToUpper = "NONDATABASE2" Then
                                Dim strSQL As String
                                Dim drGetDeliverable As IDataReader
                                Dim strDeliverableID As String
                                Dim strDeliverableName As String


                                If Args.IsEditMode Then
                                    strSQL = "Select DeliverableID from tbl_PM_ReviewStatistics Where ReviewStatisticsID = " + CType(Args.PrimaryKeyValue, String)
                                    drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))


                                    If drGetDeliverable.Read Then
                                        strDeliverableID = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("DeliverableID"), "0"), String)
                                    End If

                                    CommonFunction.Data.DisposeDataReader(drGetDeliverable)

                                    If strDeliverableID <> "0" Then
                                        strSQL = "Select Title From tbl_PM_OtherSchedules Where ScheduleID = " + CType(strDeliverableID, String)
                                        drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                        If drGetDeliverable.Read Then
                                            strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("Title"), "0"), String)
                                        End If
                                        ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                        CommonFunction.Data.DisposeDataReader(drGetDeliverable)
                                        ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                    End If

                                    Args.IgnoreActualValue = True
                                    Args.NewValue = strDeliverableName



                                End If
                            End If



                            'End Addition


                            'Added by ShamkantD on Friday, September 24, 2004 - added for Approver's comments dialog
                        Case CommonFunction.Constants.APP_TAG_TAB_BASELINE_COMMENTS
                            If Args.ControlName.ToUpper() = "ReasonForRejection".ToUpper() Then
                                'Modified By JyotiG
                                'Date :23-Aug-2006
                                'Issue ID : 5687
                                'Start
                                'Blank out the comments box
                                Args.IgnoreActualValue = True
                                Dim drProjectInformation As IDataReader
                                Dim drRevisionInformation As IDataReader
                                Dim drQuestionInformation As IDataReader

                                Dim strProjectStartDate As String
                                Dim strProjectEndDate As String
                                Dim strProjectEfforts As String

                                Dim strRevisedStartDate As String
                                Dim strRevisedEndDate As String
                                Dim strRevisedEfforts As String

                                Dim strFormAction As String
                                Dim strCommentData As String
                                'Added by SnehalV 3-Nov-2006 for WhizibleSEM SP8 IssueID:7449
                                Dim mbaselinenumber As Integer
                                'End of Addition by SnehalV  

                                strCommentData = ""
                                strFormAction = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FormAction"), ""), String).Trim()
                                drProjectInformation = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Project " & WhizGlobal.ProjectID.ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'Modified By JyotiG (31-Aug-2006)
                                'Start
                                drQuestionInformation = CommonFunction.Data.GetDataReader("EXEC usp_sel_ApprovalQuestions ", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                'End
                                drRevisionInformation = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_ProjectRevision " & WhizGlobal.ProjectID.ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If strFormAction = "S" Then
                                    strCommentData = "Following are details:" & (Chr(13))
                                    'Added By JyotiG
                                    'Issue Id : 5764
                                    'Start
                                    strCommentData = strCommentData & "Sender:" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") & (Chr(13))
                                    strCommentData = strCommentData & "Date:" & Now.Date & (Chr(13)) & (Chr(13))
                                    'End
                                ElseIf strFormAction = "A" Or strFormAction = "R" Then
                                    strCommentData = "Following are details:" & (Chr(13))
                                    'Added By JyotiG
                                    'Issue Id : 5764
                                    'Start
                                    strCommentData = strCommentData & "Sender:" & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") & (Chr(13))
                                    strCommentData = strCommentData & "Date:" & Now.Date & (Chr(13)) & (Chr(13))
                                    'End
                                End If


                                If drProjectInformation.Read And drRevisionInformation.Read Then
                                    'Added by SnehalV 3-Nov-2006 for WhizibleSEM SP8 IssueID:7449
                                    mbaselinenumber = CType(drProjectInformation("BaselineNumber"), Integer)
                                    'End of Addition by SnehalV  
                                    strProjectEndDate = CommonFunction.Dates.GetDate(CType(drProjectInformation("expectedenddate"), Date))
                                    strProjectStartDate = CommonFunction.Dates.GetDate(CType(drProjectInformation("expectedStartdate"), Date))
                                    strProjectEfforts = CType(drProjectInformation("EstimatedEfforts"), String)

                                    strRevisedEndDate = CommonFunction.Dates.GetDate(CType(drRevisionInformation("expectedenddate"), Date))
                                    strRevisedStartDate = CommonFunction.Dates.GetDate(CType(drRevisionInformation("expectedStartdate"), Date))
                                    strRevisedEfforts = CType(drRevisionInformation("EstimatedEfforts"), String)
                                    'Modfied by SnehalV 3-Nov-2006 for WhizibleSEM SP8 IssueID:7449
                                    'Purpose: To check if the new project is send for approval or project revision is sent
                                    'and accordingly change the sender comment
                                    'Start:
                                    If mbaselinenumber <> 0 Then
                                        'End
                                        strCommentData = strCommentData & "Revised Start Date :" & strRevisedStartDate & (Chr(13)) & "Revised End Date :" & strRevisedEndDate & (Chr(13)) & "Revised Efforts:" & strRevisedEfforts & (Chr(13)) & "==========================================================" & (Chr(13)) & "Before Revision :" & (Chr(13)) & "Start Date :" & strProjectStartDate & (Chr(13)) & "End Date :" & strProjectEndDate & (Chr(13)) & "Efforts:" & strProjectEfforts & (Chr(13)) & (Chr(13))
                                        'Modified By JyotiG (31-Aug-2006)
                                        'Start
                                        While drQuestionInformation.Read
                                            If CType(drQuestionInformation("Question"), String) <> "" Then
                                                strCommentData = strCommentData & CType(drQuestionInformation("Question"), String) & (Chr(13)) & (Chr(13))
                                            End If
                                        End While
                                        'End
                                        'Start: Modification by SnehalV 3-Nov-2006 for WhizibleSEM SP8 IssueID:7449
                                    Else
                                        'Modified By VidyaJ - IssueID - 11659
                                        strProjectEndDate = CommonFunction.Dates.GetDate(CType(drRevisionInformation("expectedenddate"), Date))
                                        strProjectStartDate = CommonFunction.Dates.GetDate(CType(drRevisionInformation("expectedStartdate"), Date))
                                        strProjectEfforts = CType(drRevisionInformation("EstimatedEfforts"), String)
                                        strCommentData = strCommentData & "Planned Project Details :" & (Chr(13)) & "Start Date :" & strProjectStartDate & (Chr(13)) & "End Date :" & strProjectEndDate & (Chr(13)) & "Efforts:" & strProjectEfforts & (Chr(13)) & (Chr(13))
                                    End If
                                    'End of Modfication by SnehalV
                                End If
                                If strFormAction = "S" Then
                                    Args.NewValue = ""
                                    Args.NewValue = strCommentData
                                ElseIf strFormAction = "A" Or strFormAction = "R" Then
                                    Args.NewValue = ""
                                End If
                                'End of addition - ShamkantD on Friday, September 24, 2004
                                CommonFunction.Data.DisposeDataReader(drProjectInformation)
                                CommonFunction.Data.DisposeDataReader(drRevisionInformation)
                                CommonFunction.Data.DisposeDataReader(drQuestionInformation)
                            End If
                            'End(Done By JyotiG)
                            'Added by ShamkantD on 8 Oct 2004 - Added for Project Costs page
                        Case CommonFunction.Constants.APP_TAG_PROJECT_DOH
                            Select Case Args.ControlName.ToUpper
                                Case "COSTTOCOMPANY"
                                    Args.IgnoreActualValue = True
                                    If CommonFunction.General.CheckIsNothing(drControls("CostToCompany")).ToString <> "" Then
                                        Args.NewValue = FormatNumber(CType(drControls("CostToCompany"), Double), 2, , , TriState.False)
                                    End If
                                Case "REIMBERSABLE"
                                    Args.IgnoreActualValue = True
                                    If CommonFunction.General.CheckIsNothing(drControls("Reimbersable")).ToString <> "" Then
                                        Args.NewValue = FormatNumber(CType(drControls("Reimbersable"), Double), 2, , , TriState.False)
                                    End If

                                    'Integrated by MrugajaB on 23rd March 2006 for WhizibleSEM 6.0 Expense WorkFlow - Issue ID.2886
                                    ' Added By NitinVS on 24 May 2005 for Expense Workflow Implementation
                                Case "ISACTIVE"
                                    Dim strSQL As String
                                    Dim ExpenseWorkFlow As String

                                    strSQL = "SELECT ExpenseWorkFlow FROM tbl_PM_CompanyInformation "
                                    ExpenseWorkFlow = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "FALSE"), "FALSE")

                                    If ExpenseWorkFlow.ToUpper = "FALSE" Then
                                        Cancel = True
                                    End If
                                    ' End Addition By NitinVS on 24 May 2005 for Expense Workflow Implementation
                                    'End Integration
                            End Select
                            'End of addition - ShamkantD on 8 Oct 2004

                            '#####V Onsite Offshore functionality
                        Case CommonFunction.Constants.APP_TAG_EMPLOYEESITEDETAILS
                            Dim strSQL As String
                            Dim strNewValue As String
                            Dim drEmployeeSiteDetails As IDataReader

                            strSQL = "SELECT * from v_tbl_PM_EmployeeBillingInfo Where EmployeeID = " + CType(Args.PrimaryKeyValue, String) + " AND " + " ProjectID = " + CType(HttpContext.Current.Session("intProjectID"), String)
                            drEmployeeSiteDetails = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            If Args.ControlName = "EmployeeName" Then
                                If drEmployeeSiteDetails.Read Then
                                    strNewValue = CType(CommonFunctions.Data.CheckIsDBNull(drEmployeeSiteDetails("EmployeeName"), ""), String)
                                End If
                                Args.IgnoreActualValue = True
                                Args.NewValue = strNewValue
                            End If

                            If Args.ControlName = "Name" Then
                                If drEmployeeSiteDetails.Read Then
                                    strNewValue = CType(CommonFunctions.Data.CheckIsDBNull(drEmployeeSiteDetails("Name"), ""), String)
                                End If
                                Args.IgnoreActualValue = True
                                Args.NewValue = strNewValue
                            End If

                            If Args.ControlName = "RoleDescription" Then
                                If drEmployeeSiteDetails.Read Then
                                    strNewValue = CType(CommonFunctions.Data.CheckIsDBNull(drEmployeeSiteDetails("RoleDescription"), ""), String)
                                End If
                                Args.IgnoreActualValue = True
                                Args.NewValue = strNewValue
                            End If

                            If Args.ControlName = "StartDate" Then
                                If drEmployeeSiteDetails.Read Then
                                    '' START : Integrated by ParagD On 14-Aug-2006 for whizible SP 7.2 

                                    'Commented and Added By Amit J on 27th June for Thesys(2599) & CashTech(2585) Issues    
                                    'Change In input date format from mm/dd/yyyy format to any other format- page displays error.
                                    'strNewValue = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Dates.CGetDate(CType(drEmployeeSiteDetails("StartDate"), Date)), ""), String)
                                    strNewValue = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Dates.GetDate(CType(drEmployeeSiteDetails("StartDate"), Date)), ""), String)
                                    'End of Additon

                                    '' END : Integrated by ParagD On 14-Aug-2006 for whizible SP 7.2 
                                End If
                                Args.IgnoreActualValue = True
                                Args.NewValue = strNewValue
                            End If


                            CommonFunctions.Data.DisposeDataReader(drEmployeeSiteDetails)
                            'End Addition

                        Case CommonFunction.Constants.APP_TAG_PROJECTSITES
                            Dim strSQL As String
                            Dim drCheckSiteNo As IDataReader
                            Dim intSiteNo As Integer
                            If Args.ControlName.ToUpper = "ISOFFSHORE" Then
                                strSQL = "Select count(*) as NoOfSites from tbl_PM_ProjectSites WHERE ProjectID =" + CType(HttpContext.Current.Session("intProjectID"), String)
                                drCheckSiteNo = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                If drCheckSiteNo.Read Then
                                    intSiteNo = CType(CommonFunctions.Data.CheckIsDBNull(drCheckSiteNo("NoOfSites"), "0"), Integer)
                                Else
                                    intSiteNo = 0
                                End If

                                ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745
                                CommonFunction.Data.DisposeDataReader(drCheckSiteNo)
                                ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 20745

                                If intSiteNo = 0 Then
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = "True"
                                    Args.Editable = False

                                End If

                                If intSiteNo = 1 Then
                                    Args.DisableInEditMode = True
                                End If

                            End If
                            'End Addition

                        Case CommonFunction.Constants.APP_TAG_SITE_TRANSFER
                            'Code added by VidyaJ on 24th Aug 2004
                            If Args.ControlName.ToUpper = "HTML TAG1" Then
                                Dim drResourcenames As IDataReader
                                Dim strSelectedResources As String
                                strSelectedResources = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Emp")).ToString

                                If strSelectedResources <> "" Then
                                    'Get Offshore Site ID for this project
                                    drResourcenames = CommonFunction.Data.GetDataReader(" usp_sel_tbl_PM_GetEmployeeNames '" + strSelectedResources + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                    If (drResourcenames.Read) Then
                                        strSelectedResources = CommonFunction.General.CheckIsNothing(drResourcenames("EmployeeNames"))
                                    Else
                                        strSelectedResources = ""
                                    End If
                                    CommonFunction.Data.DisposeDataReader(drResourcenames)
                                    Args.HTMLTag = Args.HTMLTag + strSelectedResources
                                End If

                            End If

                            If Args.ControlName = "NonDatabase3" Then
                                Args.Alignment = "Right"
                            End If
                            'End Addition

                            'Added by ShamkantD on 21 Nov 2004 
                            'Added for Service Offering Segmentaion 
                        Case CommonFunction.Constants.APP_TAG_SERVICE_OFFERINGS_SEGMENTATION
                            If Args.IsEditMode = True Then
                                If Args.ControlName.ToUpper() = "ServicesSegmentationID".ToUpper() Then
                                    'Should not allow to change Services Segmentation in Service Offerings Segmentation 
                                    'if its being used in Sub Service Offerings Segmentation or at project level
                                    Dim intServiceOfferingIDCount As Integer = 0
                                    Dim strQuery As String = "SELECT COUNT(ServiceOfferingID) AS ServiceOfferingIDCount FROM tbl_PM_ServiceOffering WHERE ServiceOfferingID = " & CommonFunction.General.CheckIsNothing(Args.PrimaryKeyValue, "0")
                                    intServiceOfferingIDCount = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)

                                    If intServiceOfferingIDCount > 0 Then
                                        Args.DisableInEditMode = True
                                    End If
                                End If
                            End If

                            'Added for Sub Service Offering Segmentaion
                        Case CommonFunction.Constants.APP_TAG_SUB_SERVICE_OFFERINGS_SEGMENTATION
                            If Args.IsEditMode = True Then
                                If Args.ControlName.ToUpper() = "ServiceOfferingID".ToUpper() Then
                                    'Should not allow to change Service Offerings in Sub Service Offerings Segmentation  
                                    'if its being used at project level
                                    Dim intServiceOfferingCount As Integer = 0
                                    Dim strQuery As String = "SELECT COUNT(SubServiceOfferingID) AS ServiceOfferingCount FROM tbl_PM_ServiceOffering WHERE SubServiceOfferingID = " & CommonFunction.General.CheckIsNothing(Args.PrimaryKeyValue, "0")
                                    intServiceOfferingCount = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)

                                    If intServiceOfferingCount > 0 Then
                                        Args.DisableInEditMode = True
                                    End If
                                End If
                            End If

                            'Added for Market Segmentaion
                        Case CommonFunction.Constants.APP_TAG_MARKET_SEGMENTATION
                            If Args.IsEditMode = True Then
                                If Args.ControlName.ToUpper() = "DomainID".ToUpper() Then
                                    'Should not allow to change 'External Market' in market segmentation if its 
                                    'being used in Sub Market Segmentation or at project level
                                    Dim intMarketCount As Integer = 0
                                    Dim strQuery As String = "SELECT COUNT(MarketID) AS MarketCount FROM tbl_PM_MarketSubMarket WHERE MarketID = " & CommonFunction.General.CheckIsNothing(Args.PrimaryKeyValue, "0")
                                    intMarketCount = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)

                                    If intMarketCount > 0 Then
                                        Args.DisableInEditMode = True
                                    End If
                                End If
                            End If

                            'Added for Sub Market Segmentaion
                        Case CommonFunction.Constants.APP_TAG_SUB_MARKET_SEGMENTATION
                            If Args.IsEditMode = True Then
                                If Args.ControlName.ToUpper() = "MarketID".ToUpper() Then
                                    'Should not allow to change market segmentation in Sub Market Segmentation 
                                    'if its being used at project level                                    
                                    Dim intSubMarketCount As Integer = 0
                                    Dim strQuery As String = "SELECT COUNT(SubMarketID) AS SubMarketCount FROM tbl_PM_MarketSubMarket WHERE SubMarketID = " & CommonFunction.General.CheckIsNothing(Args.PrimaryKeyValue, "0")
                                    intSubMarketCount = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)

                                    If intSubMarketCount > 0 Then
                                        Args.DisableInEditMode = True
                                    End If
                                End If
                            End If
                            'End of addition - ShamkantD on 21 Nov 2004
                            'Code added by VidyaJ for - DXU
                            'To populate Primary Key combo on entity selection
                        Case CommonFunction.Constants.APP_TAG_TEMPLATE_DESIGN
                            If Not HttpContext.Current.Request.QueryString("IsComboChange") Is Nothing Then
                                If Args.ControlName = "PrimaryKey" Then
                                    'Args.IgnoreActualValue = True
                                    Args.AdditionalInformation = "SELECT FieldName, UserFriendlyName FROM tbl_DXU_EntityDetails" _
                                                                    & " WHERE Show = 1 and EntityID = " & HttpContext.Current.Request.Form("EntityID") + " Order by UserFriendlyName"
                                    Args.DropDownEditSQL = Args.AdditionalInformation
                                End If
                            End If
                            'end of additions by IrtaizaS
                            'End Of Addition

                            'Added by MrugajaB on 29th Aug 2006 for Whiziblesem SP7 Issue ID.3736
                            'Purpose:Checklist name for inherited checklist should not be editable
                        Case CommonFunction.Constants.APP_TAG_PROJECT_CHECKLIST
                            If Args.ControlName.ToUpper = "CHECKLISTSHORTNAME" Then
                                Dim strSQLQuery As String
                                Dim drIsInherited As IDataReader
                                strSQLQuery = "EXEC usp_Sel_tbl_PM_WorkOrderChecklist_IsInherited " & CommonFunction.General.CheckIsNothing(Args.PrimaryKeyValue, "0")
                                drIsInherited = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
                                If drIsInherited.Read Then
                                    Args.DisableInEditMode = True
                                End If
                                CommonFunctions.Data.DisposeDataReader(drIsInherited)
                            End If
                            'End If
                            '--------------------------------------------------------
                            'Code added by SajiU on 14 Dec 2006
                        Case CommonFunction.Constants.App_Tag_Login_Maintenance
                            If Args.ControlName.ToUpper = "LOGINNAME" Then


                                Dim strSQLQuery As String
                                Dim strSelectionValue As String
                                Dim drIsInherited As IDataReader
                                strSQLQuery = "EXEC usp_Sel_tbl_PM_Login_Bulk_LastLogon " & CommonFunction.General.CheckIsNothing(Args.PrimaryKeyValue, "0")
                                drIsInherited = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
                                If drIsInherited.Read Then
                                    strSelectionValue = CType(CommonFunctions.Data.CheckIsDBNull(drIsInherited("LastLogon"), ""), String)
                                End If
                                CommonFunctions.Data.DisposeDataReader(drIsInherited)
                                If strSelectionValue = "" Then
                                    Args.DisableInEditMode = False
                                Else
                                    Args.DisableInEditMode = True
                                End If
                            End If
                            'End of addtion by SajiU on 2006
                            '-----------------------------------------
                    End Select
                Else
                    'For Details Tag
                    Select Case WhizGlobal.TagID
                        '    ' added by harshada d for helpdesk enhancements 1936 whizible 6
                        Case CommonFunction.Constants.APP_TAG_TAB_PROJECT_MAPPING
                            Dim strSQL As String
                            Dim drCheckDefaultProjectNo As IDataReader
                            Dim blnDefaultProject As Boolean
                            Dim intDefaultProjectCount As Integer
                            If Args.ControlName.ToUpper = "ISDEFAULTPROJECT" And Args.IsEditMode = True Then
                                strSQL = " Select IsDefaultProject from tbl_CRM_Function_projects Where FunctionProjectID= " & Args.PrimaryKeyValue '"Select count(*) as NoOfDefaultProjects from tbl_CRM_Function_Projects WHERE FunctionID =" + Args.MasterPrimaryKeyValue + " and IsDefaultProject = 1"
                                blnDefaultProject = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "C"), Boolean) 'CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                strSQL = "select count(*) as ProjectCount from tbl_CRM_Function_Projects where functionID = " + Args.MasterPrimaryKeyValue + " and IsDefaultProject=1 and FunctionProjectID <> " + CType(Args.PrimaryKeyValue, String)
                                intDefaultProjectCount = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "C"), Integer) 'CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                If blnDefaultProject = False And intDefaultProjectCount > 0 Then
                                    Args.Editable = False
                                Else
                                    Args.Editable = True
                                End If

                            End If

                            '        'end of addition by harshada



                        Case CommonFunction.Constants.APP_TAG_TAB_ACTIVITY_DETAILS
                            Select Case Args.ControlName.ToUpper
                                'Disable the control IsActive in Add mode
                                Case "ISACTIVE"
                                    If Args.IsEditMode = False Then
                                        'Add mode
                                        Args.Editable = False
                                    Else
                                        'Edit mode
                                        Args.Editable = True
                                    End If
                            End Select
                        Case CommonFunction.Constants.APP_TAG_TAB_REVIEW_ACTIONS
                            If Args.IsEditMode = False Then '
                                'For INSERT mode
                                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ReviewObservationID")) <> "" Then
                                    'Observation is converted to task
                                    If Args.ControlName.ToLower = "reviewobservationid" Then
                                        'Set the Observation ID
                                        Args.IgnoreActualValue = True
                                        Args.NewValue = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ReviewObservationID"))
                                    ElseIf Args.ControlName.ToLower = "action" Then
                                        Dim intReviewObservationID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ReviewObservationID"))
                                        Dim drObs As IDataReader = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_ReviewObservations " + intReviewObservationID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                        If drObs.Read Then
                                            Args.DefaultValue = "1-" + CommonFunction.Data.CheckIsDBNull(drObs("Observation")).ToString
                                        End If
                                        CommonFunction.Data.DisposeDataReader(drObs)
                                    End If
                                End If
                            End If

                            If Args.ControlName.ToLower = "workinhours" Then
                                ' Validation - Check if the Work (hrs) specified is a multiple of min hours for daily activity hours.
                                Dim strFunction As String
                                Dim strMsg As String
                                Dim objTemplate As WebPages.Template.WhizTemplate
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                strMsg = objTemplate.GetResourceString("REVIEW_ACTION_DA_HOURS", False) ' get message from resource file
                                'Replace by value of min allowed hours
                                strMsg = Replace(Replace(strMsg, "[MIN_DA_HOURS]", CommonFunctions.Application.MinHoursForDAEntry.ToString), "[CAPTION]", Args.ControlCaption)
                                strFunction = vbCrLf + "var objWork = GetObjectReference('frmCommonPage','WorkInHours')"
                                strFunction += vbCrLf + "if (objWork.value.indexOf('.', 0) >= 0) {"
                                strFunction += vbCrLf + "// means decimal exists: Now we check if value is a multiple of the Min. Timesheet value"
                                strFunction += vbCrLf + "if ( ( parseFloat(objWork.value) / " + CommonFunctions.Application.MinHoursForDAEntry.ToString + " ) != ( parseInt( parseFloat(objWork.value) / " + CommonFunctions.Application.MinHoursForDAEntry.ToString + " ) ) )"
                                strFunction += vbCrLf + "{"
                                strFunction += vbCrLf + "alert(" + Chr(34) + strMsg + Chr(34) + ");"
                                strFunction += vbCrLf + "objWork.focus();"
                                strFunction += vbCrLf + "return false;"
                                strFunction += vbCrLf + "}"
                                strFunction += vbCrLf + "}"
                                strMsg = objTemplate.GetResourceString("REVIEW_ACTION_DA_HOURS_RANGE", False) ' get message from resource file
                                'Replace by value of min allowed hours
                                strMsg = Replace(Replace(strMsg, "[MIN_DA_HOURS]", CommonFunctions.Application.MinHoursForDAEntry.ToString), "[CAPTION]", Args.ControlCaption)
                                strFunction += vbCrLf + "if (disallowValueRangeViolation(GetObjectReference('frmCommonPage','WorkInHours')," + CommonFunctions.Application.MinHoursForDAEntry.ToString + ",24,'" + strMsg + "',true))"
                                strFunction += vbCrLf + "{ return false; }"
                                Args.ClientSideScript += strFunction
                                objTemplate = Nothing
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_REVIEW_OBSERVATIONS

                            If Args.IsEditMode = True Then  '
                                'For EDIT mode
                                If (Args.ControlName.ToLower = "tracktonextreview" Or Args.ControlName.ToLower = "closed") And CommonFunction.Data.CheckIsDBNull(drControls("ReviewActionID"), "0").ToString <> "0" Then
                                    'If the Observation is converted to Task then do not allow to Track to next review 
                                    Args.Editable = False
                                End If
                            End If

                        Case CommonFunction.Constants.APP_TAG_TAB_CONTINGENCYPLAN

                            'added by   SachinR     On  08 Apr 2004
                            'to insert the client script to ask the user about the confirmation to update the 
                            'projectTasks with contingencyplans record for the current RiskID and projectID
                            If Args.ControlName.ToUpper = "EXPECTEDWORK" Then
                                ' Validation - Check if the Work (hrs) specified is a multiple of min hours for daily activity hours.
                                Dim strFunction As String
                                Dim strMsg As String
                                Dim objTemplate As WebPages.Template.WhizTemplate
                                'Create object of the ProjectByNet Template Class
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                strMsg = objTemplate.GetResourceString("REVIEW_ACTION_DA_HOURS", False) ' get message from resource file
                                'Replace by value of min allowed hours
                                strMsg = Replace(Replace(strMsg, "[MIN_DA_HOURS]", CommonFunctions.Application.MinHoursForDAEntry.ToString), "[CAPTION]", Args.ControlCaption)
                                strFunction = vbCrLf + "var objWork = GetObjectReference('frmCommonPage','ExpectedWork')"
                                strFunction += vbCrLf + "if (objWork.value.indexOf('.', 0) >= 0) {"
                                strFunction += vbCrLf + "// means decimal exists: Now we check if value is a multiple of the Min. Timesheet value"
                                strFunction += vbCrLf + "if ( ( parseFloat(objWork.value) / " + CommonFunctions.Application.MinHoursForDAEntry.ToString + " ) != ( parseInt( parseFloat(objWork.value) / " + CommonFunctions.Application.MinHoursForDAEntry.ToString + " ) ) )"
                                strFunction += vbCrLf + "{"
                                strFunction += vbCrLf + "alert(" + Chr(34) + strMsg + Chr(34) + ");"
                                strFunction += vbCrLf + "objWork.focus();"
                                strFunction += vbCrLf + "return false;"
                                strFunction += vbCrLf + "}"
                                strFunction += vbCrLf + "}"
                                strMsg = objTemplate.GetResourceString("REVIEW_ACTION_DA_HOURS_RANGE", False) ' get message from resource file
                                'Replace by value of min allowed hours
                                strMsg = Replace(Replace(strMsg, "[MIN_DA_HOURS]", CommonFunctions.Application.MinHoursForDAEntry.ToString), "[CAPTION]", Args.ControlCaption)
                                strFunction += vbCrLf + "if (disallowValueRangeViolation(GetObjectReference('frmCommonPage','ExpectedWork')," + CommonFunctions.Application.MinHoursForDAEntry.ToString + ",24,'" + strMsg + "',true))"
                                strFunction += vbCrLf + "{ return false; }"
                                Args.ClientSideScript += strFunction
                                objTemplate = Nothing
                            End If
                            'addition end
                            'Added By DipaliS 11 th May
                        Case CommonFunction.Constants.APP_TAG_NEW_RATE 'APP_TAG_TAB_RATECONTRACTBYROLE
                            If Args.ControlName.ToUpper = "RATEFORID" Or Args.ControlName.ToUpper = "NONDATABASE1" Then
                                Dim strSQL As String
                                Dim drContractType As IDataReader
                                'Get the data source for RateForName depending upon contract type
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
                                            Args.AdditionalInformation = "usp_sel_tbl_pm_Role_ForRateContract " & strProjectID & ",NULL"
                                            If Args.IsEditMode Then
                                                Args.DropDownEditSQL = "usp_sel_tbl_pm_Role_ForRateContract " & strProjectID & "," & CType(CommonFunctions.General.CheckIsNothing(drControls.Item("RateForID")), String)
                                            End If
                                            If Args.ControlName.ToUpper = "NONDATABASE1" Then
                                                Args.AdditionalInformation = "usp_sel_tbl_pm_role_ratecontract " & strProjectID & ",1"
                                            End If
                                        Case CommonFunction.Constants.RATECONTRACTTYPE.CONTRACT_BY_RESOURCE
                                            Args.AdditionalInformation = "usp_sel_tbl_pm_Employee_ForRateContract " & strProjectID & ",NULL"
                                            If Args.IsEditMode Then
                                                Args.DropDownEditSQL = "usp_sel_tbl_pm_Employee_ForRateContract " & strProjectID & "," & CType(CommonFunctions.General.CheckIsNothing(drControls.Item("RateForID")), String)
                                            End If
                                            If Args.ControlName.ToUpper = "NONDATABASE1" Then
                                                Args.AdditionalInformation = "usp_sel_tbl_pm_role_ratecontract " & strProjectID & ",0"
                                            End If
                                    End Select
                                End If
                                CommonFunctions.Data.DisposeDataReader(drContractType)
                            End If
                            'Added By NileshD on 28 July 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_TAX_DETAILS
                            If Args.ControlName.ToUpper = "TAXID" Then
                                If Args.IsEditMode = False Then
                                    Dim intCounter As Integer
                                    Dim strQuery As String
                                    'Get the Tax list according to number of taxes added for this RFI Type
                                    strQuery = "SELECT Count(RFITypeTaxID) FROM tbl_PM_RFITypes_TaxDetails WHERE RFITypeID = '" + Args.MasterPrimaryKeyValue + "'"
                                    intCounter = CType(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)
                                    Args.IgnoreActualValue = True
                                    Args.AdditionalInformation = "usp_Sel_tbl_PM_TaxMaster NULL,'TaxAmount" & (intCounter + 1) & "'"
                                Else
                                    'Get the list of taxes which is selected 
                                    Args.IgnoreActualValue = True
                                    Args.AdditionalInformation = "usp_Sel_tbl_Tax_Master_RFI " + Args.PrimaryKeyValue
                                End If
                            End If
                            If Args.ControlName.ToUpper = "NONDATABASE1" Then
                                If Args.IsEditMode = False Then
                                    Dim intCounter As Integer
                                    Dim strQuery As String
                                    'Get the formula and percentage for the selected tax
                                    strQuery = "SELECT Count(RFITypeTaxID) FROM tbl_PM_RFITypes_TaxDetails WHERE RFITypeID = '" + Args.MasterPrimaryKeyValue + "'"
                                    intCounter = CType(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)
                                    Args.IgnoreActualValue = True
                                    Args.AdditionalInformation = "SELECT StandardTaxPercentage,Formula FROM tbl_PM_TaxMaster WHERE FieldName ='TaxAmount" & (intCounter + 1) & "'"
                                Else
                                    'Get the list of formul's and percentages for the selected tax.
                                    Args.IgnoreActualValue = True
                                    Args.AdditionalInformation = "usp_Sel_tbl_Tax_Master_RFI_Attributes " + Args.PrimaryKeyValue
                                End If
                            End If
                            'End of Addition
                            'Added By NileshD on 29July 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_CONFIGURE_RFI_ITEM_ATTRIBUTES
                            If Args.ControlName.ToUpper = "ISCOMPULSORY" Then
                                Args.Editable = False
                            End If
                            'other than custome fields disabled control type and store procedure controls
                            If Args.ControlName.ToUpper = "NONDATABASE1" Then
                                If Args.IsEditMode = True Then
                                    If InStr(drControls("UserFriendlyCaptionMaster").ToString.ToUpper, "CUSTOM") < 1 Then
                                        Args.Editable = False
                                    End If
                                    Args.IgnoreActualValue = True
                                    Args.NewValue = drControls("ControlTypeID").ToString
                                End If
                            End If
                            If Args.ControlName.ToUpper = "STOREDPROCEDURE" Then
                                If Args.IsEditMode = True Then
                                    If InStr(drControls("UserFriendlyCaptionMaster").ToString.ToUpper, "CUSTOM") < 1 Then
                                        Args.Editable = False
                                    End If
                                End If
                            End If
                            'end of Addition

                            'added by DiptiK   on 21 Aug 2004
                            'For Details Tag
                            'Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_SUB_TAG_ANSWERS
                            Dim strSingle As String
                            Dim objDr As IDataReader
                            Dim objDrMultipleSel As IDataReader
                            Dim StrSQL As String
                            Dim strNegative As String

                            Dim intVal As Integer
                            Dim intSingle As Boolean
                            Dim strScript As String = ""
                            If Args.ControlName.ToUpper = "ISNEGATIVE" Then
                                'get count for no. of negative responses
                                'StrSQL = "select count(IsNegative) as count from tbl_q_answer where answersetid=" & CType(HttpContext.Current.Request.QueryString("ForeignKeyValue"), Int16) & " and isnegative=1"
                                StrSQL = "select count(IsNegative) as count from tbl_q_answer where answersetid=" & CType(Args.MasterPrimaryKeyValue, Int16) & " and isnegative=1"
                                objDr = CommonFunction.Data.GetDataReader(StrSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If objDr.Read Then
                                    intVal = CType(objDr("count"), Integer)
                                End If
                                CommonFunction.Data.DisposeDataReader(objDr)

                                ' get if single selection or multiple
                                'StrSQL = "select SingleSelection as count from tbl_q_answerset where answersetid=" & CType(HttpContext.Current.Request.QueryString("ForeignKeyValue"), Int16)
                                StrSQL = "select SingleSelection as count from tbl_q_answerset where answersetid=" & CType(Args.MasterPrimaryKeyValue, Int16)
                                objDrMultipleSel = CommonFunction.Data.GetDataReader(StrSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                If objDrMultipleSel.Read Then
                                    intSingle = CType(objDrMultipleSel("count"), Boolean)
                                End If
                                CommonFunction.Data.DisposeDataReader(objDrMultipleSel)
                                'strSingle = CType(ControlsHashTable("SingleSelection"), String)
                                'Case: if single selection and more than one negative response is there
                                If (intSingle = True And intVal > 0) Then
                                    'strScript = "<script language = javascript>"
                                    'strScript += "alert('There is already a negative response added for single selection. You cannot add more than one.');"
                                    'strScript += "</script>"
                                    'CommonFunction.General.WriteHTML(strScript)
                                    Args.Editable = False
                                    'strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                                End If
                                ' get the value for the check box of isnegative response
                                'strNegative = CType(ControlsHashTable("IsNegative"), String)

                                'case: if multiple selection is there and negative response is asked
                                If (intSingle = False) Then
                                    Args.Editable = False
                                End If
                            End If
                            'addition ends

                            'Added By AmitD for Check List Items on 23 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_CHECKLIST_ITEMS
                            If Args.ControlName = "CReviewCauseID" Then
                                Dim strSQL As String
                                Dim drGetIsSingleSelection As IDataReader
                                Dim blnMultipleSelection As Boolean
                                Dim blnSingleSelection As Boolean
                                'strSQL = "Select * From tbl_Q_QuestionnaireQuestion Where QuestionnaireQuestionID = " + CType(HttpContext.Current.Request.QueryString("QuestionnaireQuestionID_PK"), String)
                                'Modified by SavitaS on 27 Sept 2006 for SP7 IssueID 6455
                                If CType(Args.PrimaryKeyValue, String) <> "" Then
                                    strSQL = "Select * From tbl_Q_QuestionnaireQuestion Where QuestionnaireQuestionID = " + CType(Args.PrimaryKeyValue, String)
                                Else
                                    strSQL = "Select * From tbl_Q_QuestionnaireQuestion Where QuestionnaireQuestionID = " + CType(HttpContext.Current.Request.QueryString("QuestionnaireQuestionID"), String)
                                End If
                                'End of Modified by SavitaS on 27 Sept 2006 for SP7 IssueID 6455
                                drGetIsSingleSelection = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                                If drGetIsSingleSelection.Read Then
                                    blnMultipleSelection = CType(CommonFunctions.Data.CheckIsDBNull(drGetIsSingleSelection("MultipleSelection"), "0"), Boolean)
                                    blnSingleSelection = CType(CommonFunctions.Data.CheckIsDBNull(drGetIsSingleSelection("SingleSelection"), "0"), Boolean)
                                End If

                                CommonFunctions.Data.DisposeDataReader(drGetIsSingleSelection)


                                If blnMultipleSelection = True Or blnSingleSelection = False Then
                                    Args.DisableInEditMode = True
                                End If
                            End If
                            'End Addition

                            'added by SachinR   on 08 Nov 2004
                        Case CommonFunction.Constants.APP_TAG_TAB_ASSOCIATED_PHASE_TASK
                            'get the total effort of the tasks for the template and calculate remaining effort
                            'for the validation on effort,as it shoud not exceed reamining effort
                            If Args.ControlName.ToUpper = "NONDATABASE1" Then
                                Dim strSQL As String
                                Dim dblTotalEffort As Double = 0
                                Dim dblRemainingEffort As Double = 0
                                strSQL = "usp_Sel_getTotalTaskEffortForTemplate " + Args.MasterPrimaryKeyValue + "," + Args.PrimaryKeyValue
                                dblTotalEffort = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), "0"), Double)
                                dblRemainingEffort = 100 - dblTotalEffort
                                Args.IgnoreActualValue = True
                                Args.NewValue = dblRemainingEffort.ToString
                            End If
                            'addition end
                            'Addition done by SuchitraP on 16-MAY-2007 for Cleanup Activity
                        Case CommonFunction.Constants.APP_TAG_TAB_LEAVES
                            'Dim myQuery As String = ""
                            'Dim blnIsProRataEnabled As Boolean = False
                            'myQuery = "SELECT ISNULL(IsProRataEnabled,0) FROM tbl_PM_CompanyInformation"
                            'blnIsProRataEnabled = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(myQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Boolean)
                            'If blnIsProRataEnabled = False Then
                            If CommonFunction.Application.IsProRataEnabled = False Then
                                If Args.ControlName = "ProRata" Then
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
                                If Args.ControlName = "ProRata" Then
                                    Cancel = True
                                End If
                            End If
                            'End of addition done by SuchitraP for Cleanup Activity
                    End Select

                End If
            End Sub

            Public Shared Sub After_PlotControl(ByVal Args As EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")
                'This event will occur After plotting the Control

                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID
                        'Added By DipaliS :10 th May
                        Case CommonFunction.Constants.APP_TAG_RATECONTRACTBYROLE
                            If Args.ControlName.ToLower = "ceilingamount" Then
                                If Not drControls.Read Then
                                    InsertAfterControl = ""
                                Else
                                    InsertAfterControl = CType(drControls.Item("CurrencyName"), String)
                                End If

                            End If
                            If Args.ControlName.ToLower = "escalationpercent" Then
                                InsertAfterControl = "%"
                            End If
                        Case CommonFunction.Constants.App_TAG_FIXED_BID
                            'Get the First value for contract from revision table for given project
                            Select Case Args.ControlName.ToLower
                                Case "revid", "nondatabase1", "nondatabase2", "nondatabase5", "amount"
                                    'Get the next value for Revision ID
                                    InsertAfterControl = CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_ProjectRevision_Currency " & WhizGlobal.ProjectID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                            End Select
                        Case CommonFunction.Constants.APP_TAG_RFI_TAX_BUILDER
                            If Args.ControlName.ToLower = "nondatabase1" Then
                                'Create object of the ProjectByNet Template Class
                                Dim objTemplate As WebPages.Template.WhizTemplate
                                objTemplate = New WebPages.Template.WhizTemplate
                                'Initialize the Resources
                                objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")
                                Dim strToBeInserted As String
                                'Plot the required controls
                                strToBeInserted = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;<A HREF = ""JavaScript:Append_OnClick()""><B>" + objTemplate.GetResourceString("RFI_APPEND") + "</B></A>"
                                strToBeInserted += "&nbsp;|&nbsp;<A HREF = ""JavaScript:Clear_OnClick()""><B>" + objTemplate.GetResourceString("RFI_CLEAR") + "</B></A>&nbsp;|"
                                strToBeInserted += "&nbsp;&nbsp;&nbsp;<a href='JavaScript:Operator_OnClick(" & Chr(34) & "+" & Chr(34) & ")' title='PLUS...' ><img Border=0 src='../../images/Plus.gif' ></A>"
                                strToBeInserted += "&nbsp;&nbsp;&nbsp;<a href='JavaScript:Operator_OnClick(" & Chr(34) & "-" & Chr(34) & ")' title='MINUS...'><img Border=0 src='../../images/Minus.gif' style='BACKGROUND-COLOR: aliceblue' ></A>"
                                InsertAfterControl = strToBeInserted
                                objTemplate = Nothing
                            End If

                            'added by SachinR   On 5 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_DELIVERABLE_CODE_DEFINITION
                            'here links are plotted to append the field and seperator to create code 
                            Dim strToBeInserted As String
                            If Args.ControlName.ToLower = "nondatabase2" Then
                                'Plot the required controls
                                strToBeInserted += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;<A HREF = ""JavaScript:AppendWithSeperator()""><B>Append With Seperator</B></A>&nbsp;|&nbsp;"
                                ' Modified By NitinVS on 28 Mar 2005 for PBNTIE SP2 
                                ' The Link for Clear is now shown through a HTML TAG and removed the Magnifier Image. 
                                'strToBeInserted += "&nbsp;|&nbsp;<A HREF = ""JavaScript:Clear_OnClick()""><B>Clear</B></A>&nbsp;|"

                                InsertAfterControl = strToBeInserted

                            ElseIf Args.ControlName.ToUpper = "CODETEMPLATE" Then

                                Args.Editable = False
                                strToBeInserted = "<SCRIPT>"
                                strToBeInserted += " for(i=0;i<document.images.length;i++){" + vbCrLf
                                strToBeInserted += " var objsrc = document.images[i].src;" + vbCrLf
                                strToBeInserted += " if(objsrc=='http://localhost/WhizibleE/Images/zoomin.gif'){" + vbCrLf
                                strToBeInserted += " document.images[i].style.visibility='hidden';" + vbCrLf
                                strToBeInserted += " document.images[i].style.width=0;document.images[i].style.height=0;}" + vbCrLf
                                strToBeInserted += "}" + vbCrLf
                                strToBeInserted += "</SCRIPT>" + vbCrLf
                                InsertAfterControl = strtobeinserted
                                'End Modiification By NitinVS on 29 MAr 2005 for WhizibleE SP2 

                            ElseIf Args.ControlName.ToLower = "nondatabase1" Then
                                strToBeInserted = "&nbsp;|&nbsp;<A HREF = ""JavaScript:Append_OnClick()""><B>Append</B></A>&nbsp;|"
                                InsertAfterControl = strToBeInserted
                            End If
                            'addition end

                            'added by SachinR   On 5 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_RFI_INVOICE_SERIES_GENERATION
                            'here links are plotted to append the field and seperator to create code 
                            Dim strToBeInserted As String
                            If Args.ControlName.ToLower = "nondatabase3" Then
                                'Plot the required controls
                                strToBeInserted += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;<A HREF = ""JavaScript:AppendWithSeperator()""><B>Append With Seperator</B></A>"
                                strToBeInserted += "&nbsp;|&nbsp;<A HREF = ""JavaScript:Clear_OnClick()""><B>Clear</B></A>&nbsp;|"
                                InsertAfterControl = strToBeInserted

                            ElseIf Args.ControlName.ToLower = "nondatabase2" Then
                                strToBeInserted = "&nbsp;|&nbsp;<A HREF = ""JavaScript:Append_OnClick()""><B>Append</B></A>&nbsp;|"
                                InsertAfterControl = strToBeInserted

                            End If
                            'addition end

                            'added by SachinR   On 17 Aug 2004
                        Case CommonFunction.Constants.APP_TAG_ISSUE_CODEGENERATION
                            'here links are plotted to append the field and seperator to create issue code 
                            Dim strToBeInserted As String
                            If Args.ControlName.ToLower = "nondatabase2" Then
                                'Plot the required controls
                                strToBeInserted += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;<A HREF = ""JavaScript:AppendWithSeperator()""><B>Append With Seperator</B></A>"
                                strToBeInserted += "&nbsp;|&nbsp;<A HREF = ""JavaScript:Clear_OnClick()""><B>Clear</B></A>&nbsp;|"
                                InsertAfterControl = strToBeInserted

                            ElseIf Args.ControlName.ToLower = "nondatabase1" Then
                                strToBeInserted = "&nbsp;|&nbsp;<A HREF = ""JavaScript:Append_OnClick()""><B>Append</B></A>&nbsp;|"
                                InsertAfterControl = strToBeInserted

                            End If
                            '    'addition end
                            ''Commented by ManishK On 3rd Jan 2006 as new inherited page Is added for leave page
                            '    'Added By JayavantK on 12-Oct-2004
                            'Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEAPPLICATION
                            '    If Args.ControlName.ToUpper = "APPROVER" Then
                            '        Dim strQuery As String = ""
                            '        Dim strReportingTo As String = ""
                            '        strQuery = "SELECT E2.EmployeeName AS ReportingToName FROM tbl_PM_Employee E1"
                            '        strQuery = strQuery + " INNER JOIN tbl_PM_Employee E2 ON E2.EmployeeID = E1.ReportingTo"
                            '        strQuery = strQuery + " WHERE E1.EmployeeID = " + WhizGlobal.UserID.ToString()
                            '        strReportingTo = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                            '        InsertAfterControl = strReportingTo
                            '    End If
                            '    'End Addition
                            '    'Added by DipaliS 15 Oct 2004
                            ''End of Commented by ManishK On 3rd Jan 2006 as new inherited page Is added for leave page

                        Case CommonFunction.Constants.APP_TAG_TYPE, CommonFunction.Constants.APP_TAG_SUB_REQUEST
                            If Args.ControlName.ToUpper = "DEFAULTWORK" Then
                                InsertAfterControl = "<INPUT Type='Hidden' ID = 'DAHours' Name='DAHours' Value='" & CommonFunction.Application.MinHoursForDAEntry & "'>"
                            End If
                            'End Addition by DipaliS


                            'Added By AmitD on 29 Oct 2004
                        Case CommonFunction.Constants.APP_TAG_REVIEW_PLANNING
                            If Args.ControlName.ToUpper = "NONDATABASE7" Then
                                InsertAfterControl = "<Input  type='hidden'  name='txtHidDeliverableID' id='txtHidDeliverableID' class='clsTextBox' style='' value='17' style='text-align:Left'>&nbsp;<img Border=0 src = '../../images/dblclick.gif' id ='imgValidationRules' title = '' height = '12px' width = '12px' onclick = 'Javascript:JavaScript:SelectDeliverable()'>"
                            End If
                            'added by harshk for sp4 issueid 200 (Deliverable mapping)
                        Case CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT
                            If Args.ControlName.ToUpper = "NONDATABASE1" Then
                                InsertAfterControl = "<Input  type='hidden'  name='txtHidDeliverableID' id='txtHidDeliverableID' class='clsTextBox' style='' value='17' style='text-align:Left'>&nbsp;<img Border=0 src = '../../images/dblclick.gif' id ='imgValidationRules' title = '' height = '12px' width = '12px' onclick = 'Javascript:JavaScript:SelectDeliverable()'>"
                            End If
                            'End added by harshk for sp4 issueid200 (Deliverable mapping)
                        Case CommonFunction.Constants.APP_TAG_REVIEWS
                            If Args.ControlName.ToUpper = "NONDATABASE2" Then
                                InsertAfterControl = "<Input  type='hidden'  name='txtHidDeliverableID' id='txtHidDeliverableID' class='clsTextBox' style='' value='17' style='text-align:Left'>&nbsp;<img Border=0 src = '../../images/dblclick.gif' id ='imgValidationRules' title = '' height = '12px' width = '12px' onclick = 'Javascript:JavaScript:SelectDeliverable()'>"
                            End If

                        Case CommonFunction.Constants.APP_TAG_FAST_TRACK_REVIEWS
                            If Args.ControlName.ToUpper = "NONDATABASE2" Then
                                InsertAfterControl = "<Input  type='hidden'  name='txtHidDeliverableID' id='txtHidDeliverableID' class='clsTextBox' style='' value='17' style='text-align:Left'>&nbsp;<img Border=0 src = '../../images/dblclick.gif' id ='imgValidationRules' title = '' height = '12px' width = '12px' onclick = 'Javascript:JavaScript:SelectDeliverable()'>"
                            End If

                            'End Addition

                            'Code added By VidyaJ for - DXU
                            'To maintain the values of these controls on postback for populating Primary Key combo
                        Case CommonFunction.Constants.APP_TAG_TEMPLATE_DESIGN
                            If Not HttpContext.Current.Request.Form("TemplateName") Is Nothing And HttpContext.Current.Request.Form("TemplateName") <> "" And (Args.ControlName = "TemplateName") Then
                                CommonFunction.General.WriteHTML("<script language=Javascript>")
                                CommonFunction.General.WriteHTML("var objTemplateName = GetObjectReference('frmCommonPage', 'TemplateName');")
                                CommonFunction.General.WriteHTML("if(objTemplateName!=null) objTemplateName.value = '" + HttpContext.Current.Request.Form("TemplateName") + "';")
                                CommonFunction.General.WriteHTML("</script>")
                            End If
                            If Not HttpContext.Current.Request.Form("EntityID") Is Nothing And HttpContext.Current.Request.Form("EntityID") <> "" And (Args.ControlName = "EntityID") Then
                                CommonFunction.General.WriteHTML("<script language=Javascript>")
                                CommonFunction.General.WriteHTML("var objEntityID = GetObjectReference('frmCommonPage', 'EntityID');")
                                CommonFunction.General.WriteHTML("if(objEntityID!=null) objEntityID.value = " + HttpContext.Current.Request.Form("EntityID") + ";")
                                CommonFunction.General.WriteHTML("</script>")
                            End If

                            'End Of Addition    

                    End Select

                Else

                End If
            End Sub


            'UJ_25052007 WAF3_PB_49
            Public Shared Sub Initialize_Controls(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_InitializeControls, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef ControlCollection As CommonEngines.HashTables.UIControlTagMaster())
                'If WhizGlobal.ParentTagID = 0 Then
                'For Master Tag
                Select Case WhizGlobal.TagID
                    Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE

                        'Else
                        'For Details Tag
                        'End If

                        'here check if control is applicable then only show it,else dont show it
                        'if control is mandatory then only make it mandatory, else dont
                        'default all the controls are mandatory
                        Dim strSQL As String
                        Dim objDr As IDataReader
                        Dim strScheduleID As String
                        Dim blnUseSQL As Boolean
                        Dim str() As String
                        Dim strRule As String
                        Dim strLabel As String
                        Dim blnIsApplicable As Boolean
                        Dim blnIsMandatory As Boolean
                        Dim intCounter As Integer = 0

                        blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

                        strScheduleID = ""
                        'Modified by SachinR    on 12 Oct 2004
                        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ScheduleTypeID"), "") <> "" Then
                            strScheduleID = HttpContext.Current.Request.QueryString("ScheduleTypeID")
                        End If
                        'modification end

                        'Modified By VidyaJ - Performance Issue - Deliverable - SP4 - IssueID -84

                        'Moved the code to UI Page Pre Render so that query is executed only once

                        'if user has not selected any deliverable type and clicked on the deliverable to edit it
                        'then no deliveable type will be stored as user preferences.Then get the deliverable typeID
                        'from the deliverable record
                        If strScheduleID = "" Or strScheduleID = "0" Then
                            'strSQL = "usp_sel_tbl_PM_OtherSchedules " + Args.PrimaryKeyValue.Trim
                            'objDr = CommonFunction.Data.GetDataReader(strSQL, blnUseSQL)
                            'If objDr.Read Then
                            '    strScheduleID = CommonFunction.Data.CheckIsDBNull(objDr("ScheduleTypeID"), "").ToString + ""
                            'End If
                            'CommonFunction.Data.DisposeDataReader(objDr)
                            strScheduleID = CType(HttpContext.Current.Session("ScheduleTypeID"), String)
                        End If
                        'End Of Modifications

                        If strScheduleID = "" Then strScheduleID = "0"

                        Dim intLen As Integer = ControlCollection.Length - 1

                        For intCounter = 0 To intLen

                            strLabel = ""
                            blnIsApplicable = False
                            blnIsMandatory = False

                            'added by SachinR   on 02 Nov 2004
                            'implement the hashtable for the deliverable field configuration.Following commented code
                            'is previous implementation with direct database
                            Dim objDeliverableField As New CommonEngine.HashTables.DeliverableField
                            objDeliverableField = CommonEngine.HashTables.Deliverable.GetHashTableDeliverableFieldObject(CType(strScheduleID, Long), ControlCollection(intCounter).ControlName)
                            If Not objDeliverableField Is Nothing Then
                                strLabel = CommonFunction.General.FormatString(objDeliverableField.Label, True)
                                blnIsApplicable = objDeliverableField.Applicable
                                blnIsMandatory = objDeliverableField.Mandatory
                            End If
                            objDeliverableField = Nothing
                            'addition end   on 02 Nov 2004

                            'added by SachinR   on 28 Oct 2004
                            If strLabel = "" Then
                                strLabel = ControlCollection(intCounter).ControlCaption
                            End If
                            'addition end

                            Select Case UCase(ControlCollection(intCounter).ControlName)
                                Case "STARTDATE", "EARLIESTSTARTDATE", "LATESTCOMPLETIONDATE", "CUSTOMERREFNO", "DELIVERABLELCE", "PROJECTSITEID", "PACKAGEID", "PROJECTSYSTEMID"

                                    If blnIsApplicable = False Then
                                        'Cancel = True
                                    Else
                                        ControlCollection(intCounter).ControlCaption = strLabel

                                        If blnIsMandatory = False Then
                                            ControlCollection(intCounter).Mandatory = False
                                            str = ControlCollection(intCounter).ValidationRules.Split(","c)
                                            ControlCollection(intCounter).ValidationRules = ""
                                            For Each strRule In str
                                                If strRule <> "1" Then
                                                    ControlCollection(intCounter).ValidationRules += strRule + ","
                                                End If
                                            Next
                                        End If

                                    End If

                                Case "DELIVERABLESIZE", "DELIVERABLESIZEUNITID", "INCLUDEINMEASUREMENT", "REQUESTEDBY", "RESPONSIBLEPERSON", "STATUS", "TITLE"

                                    If blnIsApplicable = False Then
                                        'Cancel = True
                                    Else
                                        ControlCollection(intCounter).ControlCaption = strLabel

                                        If blnIsMandatory = False Then
                                            ControlCollection(intCounter).Mandatory = False
                                            str = ControlCollection(intCounter).ValidationRules.Split(","c)
                                            ControlCollection(intCounter).ValidationRules = ""
                                            For Each strRule In str
                                                If strRule <> "1" Then
                                                    ControlCollection(intCounter).ValidationRules += strRule + ","
                                                End If
                                            Next
                                        End If
                                    End If

                                Case "PRIORITY", "COMPLEXITYID", "DEPARTMENTID", "PERCENTAGECOMPLETE", "EXPECTEDCOMPLETIONTIME", "REQUESTEDTIME", "ISACCEPTANCETESTINGREQUIRED"

                                    If blnIsApplicable = False Then
                                        'Cancel = True
                                    Else
                                        ControlCollection(intCounter).ControlCaption = strLabel

                                        If blnIsMandatory = False Then
                                            ControlCollection(intCounter).Mandatory = False
                                            str = ControlCollection(intCounter).ValidationRules.Split(","c)
                                            ControlCollection(intCounter).ValidationRules = ""
                                            For Each strRule In str
                                                If strRule <> "1" Then
                                                    ControlCollection(intCounter).ValidationRules += strRule + ","
                                                End If
                                            Next
                                        End If
                                    End If
                                    ' Modified By NitinVS on 30 Aug 2005 for WhizibleSEM SP4 IssueID 94
                                    ' Additional Custom Fields for Deliverable.

                                Case "CUSTOMFIELDTEXT1", "CUSTOMFIELDTEXT2", "CUSTOMFIELDTEXT3", "CUSTOMFIELDTEXT4", "CUSTOMFIELDTEXT5", _
                                        "CUSTOMFIELDNUMERIC1", "CUSTOMFIELDNUMERIC2", "CUSTOMFIELDNUMERIC3", "CUSTOMFIELDNUMERIC4", "CUSTOMFIELDNUMERIC5", _
                                        "CUSTOMFIELDDATE1", "CUSTOMFIELDDATE2", "CUSTOMFIELDDATE3", "CUSTOMFIELDDATE4", "CUSTOMFIELDDATE5"

                                    If blnIsApplicable = False Then
                                        'Cancel = True
                                    Else
                                        ControlCollection(intCounter).ControlCaption = strLabel

                                        If blnIsMandatory = False Then
                                            ControlCollection(intCounter).Mandatory = False
                                            str = ControlCollection(intCounter).ValidationRules.Split(","c)
                                            ControlCollection(intCounter).ValidationRules = ""
                                            For Each strRule In str
                                                If strRule <> "1" Then
                                                    ControlCollection(intCounter).ValidationRules += strRule + ","
                                                End If
                                            Next
                                        End If
                                    End If

                                    ' End Modification By NitinVS on  30 Aug 2005 for WhizibleSEM SP4 IssueID 94

                            End Select
                            'addition end

                        Next


                End Select

            End Sub
        End Class
    End Namespace
End Namespace
