'=====================================================================
' Class	Name	        :	PM_XMLHttp
' Purpose				:	This class is used to handles server side validations
' Description			:	Same as above
' Assumptions			:	None
' Dependencies			:	None
' Author				:	Amit Mahadik
' Created				:	30-Jan-

' Revisions				:	
'=====================================================================
Imports System.Xml
Imports System.Text
Imports Whizible
Imports System.Data


Imports CommonFunctions
Imports System

Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security

Imports System.IO

Public Class Customer_XMLHttp
    Inherits WebPages.Template.WhizTemplate
    Private Shared WithEvents m_objPHSGrid As New WebPage.Templates.AdvancedGrid
    Protected Shared m_strSortOrder As String = ""
    Protected Shared m_strSortBy As String = ""
    Protected Shared strQuery As String
    Protected sbExportToExcel As New StringBuilder
    Public strlogPath As String
    Public strlogFile As String
    Protected m_Action As String
    Dim strResult As String = ""
    Dim strSQL As String
    Dim intUserID As Integer
    Protected TravelType As String
    Dim ProjectID As Integer
    Dim TravelID As Integer
    Dim TravelDate As String
    Dim TravelRequisition As String
    Protected HotelID As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        m_Action = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("Action"), ""), "")

        If m_Action.ToUpper = "VALIDATECOMBINATION" Then
            Dim SubProject As String
            Dim strModule As String
            Dim Phase As String
            Dim Milestone As String
            Dim strSql As String
            Dim ProjectID As String

            SubProject = Request.QueryString("SubProject")
            strModule = Request.QueryString("Module")
            Phase = Request.QueryString("Phase")
            Milestone = Request.QueryString("Milestone")
            ProjectID = Request.QueryString("ProjectID")
            'strURL="Action=VALIDATECOMBINATION&SubProject="+ objSubProject.value +"&Module="+ objModule.value + "&Phase="+ objPhase.value +"&Milestone="+objMilestone.value+"&ProjectID=" + objProjectID + "";

            strSql = "usp_validate_CombinationExists " & ProjectID & "," & SubProject & "," & strModule & "," & Phase & "," & Milestone

            strResult = CommonFunction.Data.GetDataScalar(strSql, True)
            Response.Clear()
            Response.Write(strResult)
            Response.End()


        End If
        If m_Action.ToUpper = "VALIDATEATTRIBUTECONFIGURATION" Then
            
            Dim strSql As String
            Dim ProjectID As String

            
            ProjectID = CType(Session("intProjectID"), Long)
            'strURL="Action=VALIDATECOMBINATION&SubProject="+ objSubProject.value +"&Module="+ objModule.value + "&Phase="+ objPhase.value +"&Milestone="+objMilestone.value+"&ProjectID=" + objProjectID + "";

            strSql = "Usp_Validate_AttributeConfiguration " & ProjectID

            strResult = CommonFunction.Data.GetDataScalar(strSql, True)
            Response.Clear()
            Response.Write(strResult)
            Response.End()


        End If
        If m_Action.ToUpper = "VALIDATEBASELINE" Then

            Dim FromDate As String
            Dim ToDate As String
            Dim ProjCustomerCapDetailsID As String
            Dim strSql As String
            Dim ProjectID As String
            Dim EffectiveFrom As String
            Dim CurrentEndDate As String

            Dim ActualStartDate As String
            Dim ActualEndDate As String

            'Commented and Added By Bharat Tekade on 28th-Apr-2016 to move all validation of baseline to current
            'EffectiveFrom = Request.QueryString("BaseLineStartDate")
            'BaselineEndDate = Request.QueryString("BaselineEndDate")
            EffectiveFrom = Request.QueryString("CurrentStartDate")
            CurrentEndDate = Request.QueryString("CurrentEndDate")
            'End of Commented and Added By Bharat Tekade on 28th-Apr-2016 to move all validation of baseline to current
            ActualStartDate = Request.QueryString("ActualStartDate")
            ActualEndDate = Request.QueryString("ActualEndDate")
            ProjectID = CType(Session("intProjectID"), Long)


            'strSql = "Usp_Validate_BaselineDates_At_project " & ProjectID & ",'" & EffectiveFrom & "','" & BaselineEndDate & "'"
            strSql = "Usp_Validate_BaselineDates_At_project " & ProjectID & ",'" & EffectiveFrom & "','" & CurrentEndDate & "','" & ActualStartDate & "','" & ActualEndDate & "'"
            strResult = CommonFunction.Data.GetDataScalar(strSql, True)
            Response.Clear()
            Response.Write(strResult)
            Response.End()


        End If
        If m_Action.ToUpper = "VALIDATEBASELINEEFFORTS" Then

            Dim FromDate As String
            Dim ToDate As String
            Dim ProjCustomerCapDetailsID As String
            Dim strSql As String
            Dim ProjectID As String
            Dim BaselineStartDate As String
            Dim BaselineEndDate As String
            Dim BaselineEfforts As String
            Dim OverallScheduleID As String

            BaselineStartDate = Request.QueryString("BaseLineStartDate")
            BaselineEndDate = Request.QueryString("BaselineEndDate")
            BaselineEfforts = Request.QueryString("BaselineEfforts")
            OverallScheduleID = Request.QueryString("OverallScheduleID")
            ProjectID = CType(Session("intProjectID"), Long)


            'strSql = "Usp_Validate_BaselineDates_At_project " & ProjectID & ",'" & EffectiveFrom & "','" & BaselineEndDate & "'"
            'strSql = "Usp_Validate_BaselineEffort " & ProjectID & "," & OverallScheduleID & ""
            strSql = "Usp_Validate_BaselineEffort " & ProjectID
            'strSql = "Usp_Validate_BaselineEffort " & ProjectID & "," & OverallScheduleID & "," & BaselineEfforts & ",'" & BaselineStartDate & "','" & BaselineEndDate & "'"

            strResult = CommonFunction.Data.GetDataScalar(strSql, True)
            Response.Clear()
            Response.Write(strResult)
            Response.End()


        End If
        If m_Action.ToUpper = "VALIDATEBASELINEEFFORTSONSAVE" Then

            Dim FromDate As String
            Dim ToDate As String
            Dim ProjCustomerCapDetailsID As String
            Dim strSql As String
            Dim ProjectID As String
            Dim CurrentStartDate As String
            Dim CurrentEndDate As String
            'Dim BaselineEfforts As String
            Dim CurrentEfforts As String
            Dim OverallScheduleID As String


            'Commented and Added By Bharat Tekade on 28th-Apr-2016 to move all validation of baseline to current
            'BaselineStartDate = Request.QueryString("BaseLineStartDate")
            'BaselineEndDate = Request.QueryString("BaselineEndDate")
            CurrentStartDate = Request.QueryString("CurrentStartDate")
            CurrentEndDate = Request.QueryString("CurrentEndDate")
            'End of Commented and Added By Bharat Tekade on 28th-Apr-2016 to move all validation of baseline to current
            CurrentEfforts = Request.QueryString("CurrentEfforts")
            OverallScheduleID = Request.QueryString("OverallScheduleID")
            ProjectID = CType(Session("intProjectID"), Long)

            'strSql = "Usp_Validate_BaselineDates_At_project " & ProjectID & ",'" & EffectiveFrom & "','" & BaselineEndDate & "'"
            strSql = "Usp_Validate_BaselineEffort_OnSave " & ProjectID & "," & OverallScheduleID & "," & CurrentEfforts & ",'" & CurrentStartDate & "','" & CurrentEndDate & "'"
            strResult = CommonFunction.Data.GetDataScalar(strSql, True)
            Response.Clear()
            Response.Write(strResult)
            Response.End()


        End If
        '
        If m_Action.ToUpper = "VALIDATEBASELINEEFFORTSONSAVEASSNAP" Then

            Dim FromDate As String
            Dim ToDate As String
            Dim ProjCustomerCapDetailsID As String
            Dim strSql As String
            Dim ProjectID As String
            Dim BaselineStartDate As String
            Dim BaselineEndDate As String
            Dim BaselineEfforts As String

            Dim CurrentStartDate As String
            Dim CurrentEndDate As String
            Dim CurrentEfforts As String

            Dim OverallScheduleID As String



            'Commented and Added By Bharat Tekade on 28th-Apr-2016 to move all validation of baseline to current
            ''BaselineStartDate = Request.QueryString("BaseLineStartDate")
            ''BaselineEndDate = Request.QueryString("BaselineEndDate")
            ''BaselineEfforts = Request.QueryString("BaselineEfforts")
            CurrentStartDate = Request.QueryString("CurrentStartDate")
            CurrentEndDate = Request.QueryString("CurrentEndDate")
            CurrentEfforts = Request.QueryString("CurrentEfforts")
            'End of Commented and Added By Bharat Tekade on 28th-Apr-2016 to move all validation of baseline to current

            OverallScheduleID = Request.QueryString("OverallScheduleID")
            ProjectID = CType(Session("intProjectID"), Long)


            'strSql = "Usp_Validate_BaselineDates_At_project " & ProjectID & ",'" & EffectiveFrom & "','" & BaselineEndDate & "'"
            strSql = "Usp_Validate_BaselineEffort_OnSaveAsSnapshot " & ProjectID & "," & OverallScheduleID & "," & CurrentEfforts & ",'" & CurrentStartDate & "','" & CurrentEndDate & "'"
            strResult = CommonFunction.Data.GetDataScalar(strSql, True)
            Response.Clear()
            Response.Write(strResult)
            Response.End()


        End If
        ''Added By Aniruddh Gujar on 10-Mar-2016 Purpose::SEM OS Enhancement
        If m_Action.ToUpper = "VALIDATECONSECUTIVE" Then
            Dim strPhaseID As String
            Dim strSubProjectID As String
            Dim strModuleID As String
            Dim strMilestoneID As String
            Dim strDeliverable As String
            Dim strResult As String

            strPhaseID = CommonFunction.General.CheckIsNothing(Request.QueryString("Phase"), "NULL")
            strSubProjectID = CommonFunction.General.CheckIsNothing(Request.QueryString("SubProject"), "NULL")
            strModuleID = CommonFunction.General.CheckIsNothing(Request.QueryString("Module"), "NULL")
            strMilestoneID = CommonFunction.General.CheckIsNothing(Request.QueryString("Milestone"), "NULL")
            strDeliverable = CommonFunction.General.CheckIsNothing(Request.QueryString("Deliverable"), "NULL")

            Dim strSQL As String = "EXEC usp_chk_ConsecutiveOSOrder " & strPhaseID & "," & strSubProjectID & "," & strModuleID & "," & strMilestoneID & "," & strDeliverable
            strResult = CommonFunction.Data.GetDataScalar(strSQL, True)

            Response.Clear()
            Response.Write(strResult)
            Response.End()
        End If
        If m_Action.ToUpper = "IMPORTBASELINE" Then
            Dim strProjectID As String
            strProjectID = CType(Session("intProjectID"), Long)

            Dim strSQL As String = "EXEC usp_chk_ImportBaselineData " & strProjectID
            strResult = CommonFunction.Data.GetDataScalar(strSQL, True)

            Response.Clear()
            Response.Write(strResult)
            Response.End()
        End If
        ''End of Added By Aniruddh Gujar on 10-Mar-2016 Purpose::SEM OS Enhancement

        ''Added By Chakshuta H on 11-Mar-2016 Purpose::SEM OS Enhancement
        If m_Action.ToUpper = "VALIDATEISDATABASELINED" Then
            Dim strProjectID As String
            strProjectID = CType(Session("intProjectID"), Long)

            Dim strSQL As String = "EXEC usp_validate_Atleast1BaselineData " & strProjectID
            strResult = CommonFunction.Data.GetDataScalar(strSQL, True)

            Response.Clear()
            Response.Write(strResult)
            Response.End()
        End If
        If m_Action.ToUpper = "ISALLDATAPRESENT" Then
            Dim strProjectID As String
            Dim OverallScheduleID As String
            strProjectID = CType(Session("intProjectID"), Long)
            OverallScheduleID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("OverallScheduleID"), ""), "")


            Dim strSQL As String = "EXEC usp_validate_IsAllDataPresentInOs " & strProjectID & "," & OverallScheduleID & " ,'" & m_Action & "'"
            strResult = CommonFunction.Data.GetDataScalar(strSQL, True)

            Response.Clear()
            Response.Write(strResult)
            Response.End()
        End If
        If m_Action.ToUpper = "ISTIMESHEETENTRYPRESENT" Then
            Dim OverallScheduleID As String
            'strProjectID = CType(Session("intProjectID"), Long)
            OverallScheduleID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("OverallScheduleID"), ""), "")


            Dim strSQL As String = "EXEC Usp_Check_IsTimesheetFilled " & OverallScheduleID
            strResult = CommonFunction.Data.GetDataScalar(strSQL, True)

            Response.Clear()
            Response.Write(strResult)
            Response.End()
        End If
        ''End of Added By Chakshuta H on 11-Mar-2016  Purpose::SEM OS Enhancement
        ''Added by Yogesh Jalamkar on 30-Mar-2016 Purpose :SEM Create Project page  
        If m_Action.ToUpper = "CREATEPROJECTBU" Then
            Dim strBussinessGroupID As String

            strBussinessGroupID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("BusinessGroupID"), ""), "")

            strSQL = "usp_Sel_GetBusinessGroupsForLocation " & strBussinessGroupID & ",NULL,0"
            Dim strResult_ProjectDetails As New System.Text.StringBuilder
            Dim drStaffingDetails As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strSQL)
            If (drStaffingDetails.HasRows) Then
                While (drStaffingDetails.Read())
                    strResult_ProjectDetails.Append(drStaffingDetails("OUPoolID").ToString())
                    strResult_ProjectDetails.Append(",")
                    strResult_ProjectDetails.Append(drStaffingDetails("Location").ToString())
                    strResult_ProjectDetails.Append("$")
                End While
            End If
            CommonFunctions.Data.DisposeDataReader(CType(drStaffingDetails, SqlClient.SqlDataReader))
            Response.Clear()
            Response.Write(strResult_ProjectDetails)
            Response.End()

        End If
        If m_Action.ToUpper = "CREATEPROJECTPRACTICE" Then
            Dim strProjectType As String
            strProjectType = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("ProjectType"), ""), "")
            strSQL = "usp_Sel_tbl_PRS_Main_ProjectType_For_Practice '" & strProjectType & "'"
            strResult = CommonFunction.Data.GetDataScalar(strSQL, True)
            Response.Clear()
            Response.Write(strResult)
            Response.End()

        End If
        If m_Action.ToUpper = "CREATEPROJECTORGANISATIONUNIT" Then
            Dim strBussinessGroupID As String
            Dim strLocationID As String
            strBussinessGroupID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("BusinessGroupID"), ""), "")
            strLocationID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("LocationID"), ""), "")
            If strLocationID = "" Then
                strLocationID = "NULL"
            End If
            strSQL = "usp_Sel_tbl_PM_Customer_ForProject NULL,NULL," & strBussinessGroupID & ", " & strLocationID & ",NULL"
            Dim strResult_ProjectDetails As New System.Text.StringBuilder
            Dim drStaffingDetails As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strSQL)
            If (drStaffingDetails.HasRows) Then
                While (drStaffingDetails.Read())
                    strResult_ProjectDetails.Append(drStaffingDetails("Customer").ToString())
                    strResult_ProjectDetails.Append(",")
                    strResult_ProjectDetails.Append(drStaffingDetails("CustomerName").ToString())
                    strResult_ProjectDetails.Append("$")
                End While
            End If
            CommonFunctions.Data.DisposeDataReader(CType(drStaffingDetails, SqlClient.SqlDataReader))
            Response.Clear()
            Response.Write(strResult_ProjectDetails)
            Response.End()

        End If
        If m_Action.ToUpper = "PROJECTINFORMATIONBU" Then
            Dim strBussinessGroupID As String
            Dim strProjectID As String
            Dim strLocationID As String
            strBussinessGroupID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("BusinessGroupID"), ""), "")
            strProjectID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("ProjectID"), ""), "")
            If strProjectID = "" Then
                strProjectID = "NULL"
            End If
            strSQL = "usp_Sel_GetBusinessGroupsForLocation " & strBussinessGroupID & "," & strProjectID & ",0,1"
            Dim strResult_ProjectDetails As New System.Text.StringBuilder
            Dim drStaffingDetails As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strSQL)
            If (drStaffingDetails.HasRows) Then
                While (drStaffingDetails.Read())
                    strResult_ProjectDetails.Append(drStaffingDetails("OUPoolID").ToString())
                    strResult_ProjectDetails.Append(",")
                    strResult_ProjectDetails.Append(drStaffingDetails("Location").ToString())
                    strResult_ProjectDetails.Append("$")
                End While
            End If
            CommonFunctions.Data.DisposeDataReader(CType(drStaffingDetails, SqlClient.SqlDataReader))
            Response.Clear()
            Response.Write(strResult_ProjectDetails)
            Response.End()


        End If
        'End of addition by Yogesh Jalamkar on 30-Mar-2016 Purpose :SEM Create Project page 
        ''Added By Chakshuta H on 11-Mar-2016 Purpose::SEM Resource Reallocation Page
        If m_Action.ToUpper = "VALIDATESTARTDATERESOURCEREALLOC" Then
            Dim strStartDate As String
            Dim strEndDate As String
            Dim strEmployeeID As String
            Dim strProjectID As String
            Dim strAvailAllocation As String
            'hidValidateResAllocation

            strStartDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("StartDate"), ""), "")
            strEndDate = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("EndDate"), ""), "")
            strEmployeeID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("EmployeeID"), ""), "")
            strAvailAllocation = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("hidValidateResAllocation"), ""), "")
            strProjectID = CType(Session("intProjectID"), Long)

            'Dim strSQL As String = "EXEC usp_Validate_MinEntryDate_StartDate " & strProjectID & "," & strEmployeeID & ",'" & strStartDate & "','" & strEndDate & "'"
            Dim strSQL As String = "EXEC usp_Validate_MinEntryDate_StartDate " & strProjectID & "," & strEmployeeID & ",'" & strStartDate & "','" & strEndDate & "','" & strAvailAllocation & "'"
            strResult = CommonFunction.Data.GetDataScalar(strSQL, True)

            Response.Clear()
            Response.Write(strResult)
            Response.End()

        End If
        ''Ended By Chakshuta H on 11-Mar-2016 Purpose::SEM Resource Reallocation Page 
        'Commented and Added By Bharat Tekade on 28th-Apr-2016 to move all validation of baseline to current
        If m_Action.ToUpper = "VALIDATEISBASELINE" Then
            Dim intProjectID As String
            Dim strSQL As String
            Dim strResult As String
            Dim strSubProject, strModule, strPhase, strMilestone, strDeliverable, strSettingID As String

            intProjectID = CommonFunction.General.CheckIsNothing(Session("intProjectID"), "")

            strSubProject = CommonFunctions.General.CheckIsNothing(Request.QueryString("SubProjectValue"))
            strModule = CommonFunctions.General.CheckIsNothing(Request.QueryString("ModuleValue"))
            strPhase = CommonFunctions.General.CheckIsNothing(Request.QueryString("PhaseValue"))
            strMilestone = CommonFunctions.General.CheckIsNothing(Request.QueryString("MilestoneValue"))
            strDeliverable = CommonFunctions.General.CheckIsNothing(Request.QueryString("DelValue"))

            strSettingID = CommonFunctions.General.CheckIsNothing(Request.QueryString("SettingID"))

            If strSubProject = "" Then
                strSubProject = "0"
            End If

            If strModule = "" Then
                strModule = "0"
            End If

            If strPhase = "" Then
                strPhase = "0"
            End If

            If strMilestone = "" Then
                strMilestone = "0"
            End If

            If strDeliverable = "" Then
                strDeliverable = "0"
            End If

            If strSettingID = "" Then
                strSettingID = "0"
            End If

            strSQL = "usp_check_OSCombination_IsBaselined " & intProjectID & "," & strSubProject & "," & strModule & "," & strPhase & "," & strMilestone & "," & strDeliverable & "," & strSettingID
            strResult = CommonFunction.Data.GetDataScalar(strSQL, True)

            Response.Clear()
            Response.Write(strResult)
            Response.End()

        End If
        'End of Commented and Added By Bharat Tekade on 28th-Apr-2016 to move all validation of baseline to current


        ' Added By Dipali Vekhande on 6th-may-2016 for Project Charter Page
        'Dim strSQL As String
        ' m_Action = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("Action"), ""), "")
        If m_Action.ToUpper = "GETPROJECTCODE" Then
            Dim SearchKey As String = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("SearchKey"), ""), "")
            Dim drDetails As IDataReader
            Dim strResult1 As String

            If SearchKey.ToString <> "" Then
                strSQL = "usp_sel_PM_GetCustomer '" & SearchKey.ToString & "'"
                'strResult = CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)
                drDetails = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
                Do While drDetails.Read()
                    strResult1 = strResult1 + "$$" + CType(drDetails("CustomerName"), String) & ""

                Loop

                Response.Clear()
                Response.Write(strResult1)
                Response.End()

            End If
        End If
        ' End and Added By Dipali Vekhande on 6th-may-2016 for Project Charter Page
        ' Added By Bharat Tekade on 06th-May-2016 to validate task mapped to snapshots
        If m_Action.ToUpper = "SNAPSHOTTASKCHECK" Then
            Dim intProjectID As String
            Dim strSQL As String
            Dim strResult As String

            intProjectID = CommonFunction.General.CheckIsNothing(Session("intProjectID"), "")

            strSQL = "usp_Validate_OS_Snapshot " & intProjectID
            strResult = CommonFunction.Data.GetDataScalar(strSQL, True)

            Response.Clear()
            Response.Write(strResult)
            Response.End()

        End If

        If m_Action.ToUpper = "CHECKWBSDATES" Then
            Dim intProjectID As String
            Dim strSQL As String
            Dim strResult As String

            intProjectID = CommonFunction.General.CheckIsNothing(Session("intProjectID"), "")

            strSQL = "usp_Validate_OverallScheudle_ParentChildDates " & intProjectID
            strResult = CommonFunction.Data.GetDataScalar(strSQL, True)

            Response.Clear()
            Response.Write(strResult)
            Response.End()

        End If
        'End Of Added By Bharat Tekade on 06th-May-2016 to validate task mapped to snapshots
        ' Added By Bharat Tekade on 13th-May-2016 to validate combination attribute dates
        If m_Action.ToUpper = "CHECKCOMBINATIONDATES" Then
            Dim strSubProject, strPhase, strModule, strMilestone, strDeliverable As String
            Dim intProjectID As String
            Dim strSQL As String
            Dim strResult As String

            strSubProject = CommonFunctions.General.CheckIsNothing(Request.QueryString("SubProject"))
            strPhase = CommonFunctions.General.CheckIsNothing(Request.QueryString("Phase"))
            strModule = CommonFunctions.General.CheckIsNothing(Request.QueryString("Module"))
            strMilestone = CommonFunctions.General.CheckIsNothing(Request.QueryString("Milestone"))
            strDeliverable = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectDeliverable"))
            intProjectID = CommonFunction.General.CheckIsNothing(Session("intProjectID"), "")

            strSQL = "usp_Validate_CombinationAttribute_Dates " & intProjectID & "," & strSubProject & "," & strPhase & "," & strModule & "," & strMilestone & "," & strDeliverable
            strResult = CommonFunction.Data.GetDataScalar(strSQL, True)

            Response.Clear()
            Response.Write(strResult)
            Response.End()
        End If
        If m_Action.ToUpper = "CHECKVALIDCOMBINATION" Then
            Dim strSubProject, strPhase, strModule, strMilestone, strDeliverable As String
            Dim intProjectID As String
            Dim strSQL As String
            Dim strResult As String

            strSubProject = CommonFunctions.General.CheckIsNothing(Request.QueryString("SubProject"))
            strPhase = CommonFunctions.General.CheckIsNothing(Request.QueryString("Phase"))
            strModule = CommonFunctions.General.CheckIsNothing(Request.QueryString("Module"))
            strMilestone = CommonFunctions.General.CheckIsNothing(Request.QueryString("Milestone"))
            strDeliverable = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectDeliverable"))
            intProjectID = CommonFunction.General.CheckIsNothing(Session("intProjectID"), "")

            strSQL = "usp_chk_IsVaildOSCombination " & intProjectID & "," & strSubProject & "," & strPhase & "," & strModule & "," & strMilestone & "," & strDeliverable
            strResult = CommonFunction.Data.GetDataScalar(strSQL, True)

            Response.Clear()
            Response.Write(strResult)
            Response.End()
        End If
        'End of Added By Bharat Tekade on 13th-May-2016 to validate combination attribute dates
        ''Added by Yogesh Jalamkar on 06-JAN-2016 Purpose:Allegrow Customization
        If m_Action.ToUpper = "ISMILESTONETASKCLOSED" Then
            Dim strMilestone As String
            Dim intProjectID As String
            Dim strSQL As String
            Dim strResult As String

            strMilestone = CommonFunctions.General.CheckIsNothing(Request.QueryString("MilestoneID"))    
            intProjectID = CommonFunction.General.CheckIsNothing(Session("intProjectID"), "")

            strSQL = "usp_Is_MilestoneTaskClosed " & strMilestone & "," & intProjectID
            strResult = CommonFunction.Data.GetDataScalar(strSQL, True)
            Response.Clear()
            Response.Write(strResult)
            Response.End()
        End If
        If m_Action.ToUpper = "ISDELIVERABLECLOSED" Then
            Dim strDeliverable As String
            Dim intProjectID As String
            Dim strSQL As String
            Dim strResult As String

            strDeliverable = CommonFunctions.General.CheckIsNothing(Request.QueryString("DelivarableID"))
            intProjectID = CommonFunction.General.CheckIsNothing(Session("intProjectID"), "")

            strSQL = "usp_Is_DeliverableTaskClosed " & strDeliverable & "," & intProjectID
            strResult = CommonFunction.Data.GetDataScalar(strSQL, True)
            Response.Clear()
            Response.Write(strResult)
            Response.End()
        End If
        ''End of addition by Yogesh Jalamkar 

        ''Added By Aniruddh Gujar on 18-Feb-2019 Purpose::Project Work field level changes 
        If m_Action.ToUpper = "VALIDATEWBSEFFORTS" Then
            Dim strUniqueID As String
            Dim strWBSEntity As String
            Dim intProjectID As String
            Dim strSQL As String
            Dim strResult As String
            Dim WorkHour As String
            Dim WorkMinute As String

            strUniqueID = CommonFunctions.General.CheckIsNothing(Request.QueryString("UniqueID"))
            strWBSEntity = CommonFunctions.General.CheckIsNothing(Request.QueryString("WBSEntity"))
            WorkHour = CommonFunctions.General.CheckIsNothing(Request.QueryString("WorkHour"))
            WorkMinute = CommonFunctions.General.CheckIsNothing(Request.QueryString("WorkMinute"))
            intProjectID = CommonFunction.General.CheckIsNothing(Session("intProjectID"), "")

            If strUniqueID = "" Then
                strUniqueID = "NULL"
            End If
            If WorkHour = "" Then
                WorkHour = "0"
            End If
            If WorkMinute = "" Then
                WorkMinute = "0"
            End If
            strSQL = "usp_Whizible2_ValidateWBSEffortsWithProject " & strUniqueID & "," & intProjectID & "," & WorkHour & "," & WorkMinute & ",'" & strWBSEntity & "'"
            strResult = CommonFunction.Data.GetDataScalar(strSQL, True)
            Response.Clear()
            Response.Write(strResult)
            Response.End()
        End If
        ''End of Added By Aniruddh Gujar on 18-Feb-2019 Purpose::Project Work field level changes 
    End Sub


End Class