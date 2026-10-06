'=====================================================================
' Class	Name	        :	XMLHttp
' Purpose				:	This class is used to handles server side validations
' Description			:	Same as above
' Assumptions			:	None
' Dependencies			:	None
' Author				:	SandipL
' Created				:	23 Nov 2005
' Revisions				:	
'=====================================================================
Imports System.Xml
Imports WhizTemplate
Imports System.Text
Imports Authentication
Imports System.DirectoryServices
Imports Token
Public Class XMLHttp
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    Protected m_strAction As String
    Protected m_strTemplateID As String

    ''Added By Aniruddh Gujar on 13-Jun-2016 Purpose::To decrypt Password
    Public Shared m_LoginHashTable As New Hashtable
    ''End of Added By Aniruddh Gujar on 13-Jun-2016 Purpose::To decrypt Password

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        MyBase.ApplySecurity(True)
        Dim lngTagID As Long
        Dim strMode As String
        lngTagID = CType(Request.QueryString.Get("TagID"), Long)

        If Request.QueryString.Get("Action") Is Nothing Then
            m_strAction = ""
        Else
            m_strAction = CType(Request.QueryString.Get("Action"), String)
        End If

        If Request.QueryString.Get("FromWhere") Is Nothing Then
            m_strTemplateID = ""
        Else
            m_strTemplateID = CType(Request.QueryString.Get("FromWhere"), String)
        End If

        If m_strAction.ToUpper = "GETFAVIDS" Then
            Dim strFavouriteTagIDs As String
            strFavouriteTagIDs = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull( _
                    CommonFunctions.Data.GetDataScalar("usp_sel_tbl_SEM_ControlItems_FavouritesTreeNode " + _
                    CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID")) + ",'" + m_strTemplateID + "','" + _
                    CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LoginType")) + "'", True)))

            Response.Clear()
            Response.Write(strFavouriteTagIDs)
            Response.End()
        End If
        'Added By Bharat T on 1st-Feb-2016
        If m_strAction.ToUpper = "VALIDATEFAVTREE" Then
            Dim strFavouriteTagIDs As String
            Dim strTagID As String
            Dim strResult As String

            strTagID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(Request.QueryString("TagID"), "0"), "0")

            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(
                    CommonFunctions.Data.GetDataScalar("Usp_Chk_FavTreeNodeExists " +
                    CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID").ToString()) + "," + strTagID, True)))

            Response.Clear()
            Response.Write(strResult)
            Response.End()
            Exit Sub
        End If
        'End of Added By Bharat T on 1st-Feb-2016


        '''Start_AJ_03Oct2006
        ''Dim strPageName As String = ""
        ''Dim str As String = "select '..'+ right(v_tbl_UI_TagMaster.PageName, len(v_tbl_UI_TagMaster.PageName)-9) from v_tbl_UI_TagMaster where TagID = " + lngTagID.ToString
        ''strPageName = CType(CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(str, True), ""), String)
        ''Response.Write(strPageName)
        '''End_AJ_03Oct2006
        Select Case lngTagID

            Case CommonFunction.Constants.APP_TAG_COPY_EXECUTION_TEMPLATE

                Dim strTemplateName As String
                Dim strTemplateDesctiption As String
                Dim strProjectPhaseTaskID As String
                Dim strSQLQuery As String

                strTemplateName = HttpContext.Current.Request("TemplateName")
                strTemplateDesctiption = HttpContext.Current.Request("TemplateDescription")
                strProjectPhaseTaskID = HttpContext.Current.Request("NonDatabase1")

                'Modified By NitinVS on 6 Mar 2007 for WhizibleSEM SP8 Regreesion Issues IssueID 11138
                ' Added CommonFunctions.General.BuildQueryString() to handle ' in tempalte name and description 
                strSQLQuery = " Exec usp_Copy_ExecutionTemplate " & strProjectPhaseTaskID & ",'" & CommonFunctions.General.BuildQueryString(strTemplateName) & "','" & CommonFunctions.General.BuildQueryString(strTemplateDesctiption) & "'"
                'end Modified By NitinVS on 6 Mar 2007 for WhizibleSEM SP8 Regreesion Issues IssueID 11138
                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, True)
                Return
                'integration by harshada d on 15th june 2006
                'Integrated by PrajaktaR on 12th May 2006 for Whizible 6.0.1 IssueID 3736
            Case CommonFunction.Constants.APP_TAG_COPY_CHECKLIST
                Dim strCheckListName As String
                Dim strProjectCheckListID As String
                Dim strSQLQuery As String

                strCheckListName = HttpContext.Current.Request("CheckListShortName")
                strProjectCheckListID = HttpContext.Current.Request("NonDatabase1")
                'modified by harshada d for whiziblesem sp 7.4 for checklist enhancements on 08 Sept 2006
                ' strSQLQuery = " Exec usp_Copy_CheckList " & strProjectCheckListID & ",'" & strCheckListName & "'"
                strSQLQuery = " Exec usp_Copy_CheckList " & strProjectCheckListID & ",'" & CommonFunctions.General.BuildQueryString(Left(strCheckListName, 200)) & "'"
                'end of modification by harshada d 
                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, True)
                'END OF Integration by PrajaktaR on 12th May 2006 for Whizible 6.0.1 IssueID 3736
                'end of integration by harshada d on 15th june 2006
            Case CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEAPPLICATION, CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS
                Dim strQuery As String = ""
                Dim lngEmployeeID As Long = 0
                Dim lngLeaveID As Long = 0
                Dim strFromDate As String = ""
                Dim strToDate As String = ""
                'Added By VarunA on 17-Aug-2009 RequestID-22994
                'Purpose : To have validation based on working days instead of From & ToDate.
                Dim WorkingDaysCount As String = ""
                'End By VarunA on 17-Aug-2009 RequestID-22994

                'Added By VarunA on 11-Sep-2007 Whizible 7.1 Development & Release
                Dim strLeaveStatus As String = ""
                'End By VarunA on 11-Sep-2007

                ' Code added by SwapnilR on 10th Oct 2006
                ' Purpose : To validate the startdate and enddate of leaves for the resoure depending upon the user.
                '           If call from 1208 -- EmployeeID is from request querystring - EmployeeID
                '           If call from 1209 -- EmployeeID is from request querystring - AppliedUser
                '           w.r.t. IssueID #7075 SP8
                If lngTagID = CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEAPPLICATION Then
                    lngEmployeeID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("EmployeeID"), "0"), Long)
                ElseIf lngTagID = CommonFunction.Constants.APP_TAG_EMPLOYEELEAVEDETAILS Then
                    lngEmployeeID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("AppliedUser"), "0"), Long)
                End If
                ' End of code addition by SwapnilR on 10th Oct 2006

                If HttpContext.Current.Request("LeaveID") <> "" Then
                    lngLeaveID = CType(HttpContext.Current.Request("LeaveID"), Long)
                End If

                'Added By VarunA on 11-Sep-2007 Whizible 7.1 Development & Release
                'Purpose : To have the leaveStatus of a rejected leave
                strLeaveStatus = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select LeaveStatusID from tbl_PM_EmployeeLeaveDetails WHERE LeaveID=" & lngLeaveID, MyBase.UseSQL), ""))
                strLeaveStatus = CommonFunctions.General.CheckIsNothing(strLeaveStatus, "")
                'End By VarunA on 11-Sep-2007

                strFromDate = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("FromDate"), "")
                strToDate = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("ToDate"), "")

                'ADDED BY AMIT MAHADIK ON 19 MAY 2011,WHIZIBLESEM 10.0
                Dim strFirstHalfDay As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("FirstHalfDay"), "")
                If strFirstHalfDay.ToLower() = "true" Then
                    strFirstHalfDay = "1"
                Else
                    strFirstHalfDay = "0"
                End If
                Dim strSecondHalfDay As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("SecondHalfDay"), "")
                If strSecondHalfDay.ToLower() = "true" Then
                    strSecondHalfDay = "1"
                Else
                    strSecondHalfDay = "0"
                End If
                'END ADDED BY AMIT MAHADIK ON 19 MAY 2011,WHIZIBLESEM 10.0

                Response.ContentType = "text/html"
                'Added By VarunA on 17-Aug-2009 RequestID-22994
                'Purpose : To have validation based on working days instead of From & ToDate.
                strQuery = "usp_Sel_tbl_PM_GetBusinessWorkingDaysCount " & lngEmployeeID.ToString & ",'" & strFromDate & "','" & strToDate & "'"
                WorkingDaysCount = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, True), "0"), String)
                'End By VarunA on 17-Aug-2009 RequestID-22994
                'Added By VarunA on 11-Sep-2007 Whizible 7.1 Development & Release
                If strLeaveStatus <> "3" Then
                    'End By VarunA on 11-Sep-2007
                    If strFromDate <> "" And strToDate <> "" Then
                        strQuery = "usp_Sel_tbl_PM_EmployeeLeaveDetails_LeavesBetween " & lngEmployeeID.ToString() & "," & lngLeaveID.ToString() & ", '" & strFromDate & "', '" & strToDate & "'" & "," & strFirstHalfDay & "," & strSecondHalfDay
                        If CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "") <> "" Then
                            'Modified By VarunA on 17-Aug-2009 RequestID-22994
                            'Purpose : To have validation based on working days instead of From & ToDate.
                            'Response.Write("True")

                            'ADDED and deleted BY AMIT MAHADIK ON 18 MAY 2011,WHIZIBLESEM 10.0 for 2 half day leaves
                            '''If (strFirstHalfDay.ToLower() = "true" And strSecondHalfDay.ToLower() = "false") OrElse (strFirstHalfDay.ToLower() = "false" And strSecondHalfDay.ToLower() = "true") Then
                            '''    Response.Write("False|" & WorkingDaysCount)
                            '''Else
                            '''    Response.Write("True|" & WorkingDaysCount)
                            '''End If
                            'END ADDED and deleted BY AMIT MAHADIK ON 18 MAY 2011,WHIZIBLESEM 10.0

                            'DELETED and added above BY AMIT MAHADIK ON 18 MAY 2011,WHIZIBLESEM 10.0
                            Response.Write("True|" & WorkingDaysCount)
                            'END DELETED and added above BY AMIT MAHADIK ON 18 MAY 2011,WHIZIBLESEM 10.0

                            'End By VarunA on 17-Aug-2009 RequestID-22994
                            Return
                        End If
                    End If
                    'Added By VarunA on 11-Sep-2007 Whizible 7.1 Development & Release
                    'Pupose : To check the rejected leave within the period and update the leaveStatus of a rejected leave.
                Else
                    If strFromDate <> "" And strToDate <> "" Then
                        strQuery = "usp_Sel_tbl_PM_EmployeeLeaveDetails_LeavesBetween_Rejected " & lngEmployeeID.ToString() & "," & lngLeaveID.ToString() & ", '" & strFromDate & "', '" & strToDate & "'"
                        If CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "") <> "" Then
                            'Modified By VarunA on 17-Aug-2009 RequestID-22994
                            'Purpose : To have validation based on working days instead of From & ToDate.
                            'Response.Write("True")
                            Response.Write("True|" & WorkingDaysCount)
                            'End By VarunA on 17-Aug-2009 RequestID-22994
                            Return
                        Else
                            strQuery = "usp_Upd_tbl_PM_EmployeeLeaveDetails_RejectedLeave " & lngLeaveID.ToString()
                            CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL))
                        End If
                    End If
                End If
                'End By VarunA on 11-Sep-2007
                'Modified By VarunA on 17-Aug-2009 RequestID-22994
                'Purpose : To have validation based on working days instead of From & ToDate.
                'Response.Write("False")
                Response.Write("False|" & WorkingDaysCount)
                'End By VarunA on 17-Aug-2009 RequestID-22994

            Case CommonFunction.Constants.APP_TAG_RFI_TOOL
                Dim strIsRequiredIDArray As String() = Split(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("chkDelete")), ",")
                Dim drTools As IDataReader
                Dim strTools As String
                Dim strSQL As String
                Response.ContentType = "text/html"
                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("chkDelete")) <> "" Then
                    strSQL = "SELECT Description from v_tbl_PM_ProjectTools WHERE ProjectToolID in (" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("chkDelete")) + ")"
                    drTools = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    strTools = ""
                    While drTools.Read
                        strTools += drTools("Description").ToString + ","
                    End While
                    CommonFunction.Data.DisposeDataReader(drTools)
                    If strTools <> "" Then
                        strTools = strTools.Remove(strTools.Length - 1, 1)
                    End If
                    Response.Write(strTools)
                Else
                    Response.Write("Nothing")
                End If
            Case CommonFunction.Constants.APP_TAG_RFI_OS
                Dim strIsRequiredIDArray As String() = Split(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("chkDelete")), ",")
                Dim drOS As IDataReader
                Dim strOSs As String
                Dim strSQL As String
                Response.ContentType = "text/html"
                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("chkDelete")) <> "" Then
                    strSQL = "SELECT OS from v_tbl_IB_Project_OS WHERE ProjectOSID in (" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("chkDelete")) + ")"
                    drOS = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    strOSs = ""
                    While drOS.Read
                        strOSs += drOS("OS").ToString + ","
                    End While
                    CommonFunction.Data.DisposeDataReader(drOS)

                    If strOSs <> "" Then
                        strOSs = strOSs.Remove(strOSs.Length - 1, 1)
                    End If
                    Response.Write(strOSs)
                Else
                    Response.Write("Nothing")
                End If
            Case CommonFunction.Constants.APP_TAG_RFI_SALES_PERSON
                Dim strIsRequiredIDArray As String() = Split(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("chkDelete")), ",")
                Dim drSalesPerson As IDataReader
                Dim strSalesPersons As String
                Dim strSQL As String
                Response.ContentType = "text/html"
                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("chkDelete")) <> "" Then
                    strSQL = "SELECT UserName from v_tbl_PM_Project_SalesPersons WHERE SalesPersonID in (" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("chkDelete")) + ") AND ProjectID = " + CType(HttpContext.Current.Session("intProjectID"), String)
                    drSalesPerson = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    strSalesPersons = ""
                    While drSalesPerson.Read
                        strSalesPersons += drSalesPerson("UserName").ToString + ","
                    End While
                    CommonFunction.Data.DisposeDataReader(drSalesPerson)

                    If strSalesPersons <> "" Then
                        strSalesPersons = strSalesPersons.Remove(strSalesPersons.Length - 1, 1)
                    End If
                    Response.Write(strSalesPersons)
                Else
                    Response.Write("Nothing")
                End If

                'Addition done by SuchitraP on 27-Sept-2007
                'Purpose:Total % Resource Allocation validation
            Case CommonFunction.Constants.APP_TAG_RESOURCES
                '''
                ' Integration by SanaS on 25-Sep-2009 for Resource Allocation Changes
                'Added By SanaS on 14-Aug-2009 for calcualating the work hours for Extend or Prepone release request.
                Dim RequestType As String
                Dim strAction As String
                Dim intProjectEmployeeRoleID As Integer

                RequestType = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode")).ToUpper
                strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action")).ToUpper
                intProjectEmployeeRoleID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectEmployeeROLEID"), "0"), Integer)

                Select Case strAction.ToUpper

                    Case "GETWORKHRS"

                        Dim dtEndDate As String
                        Dim dtEffectiveDate As String
                        Dim flNewAllocation As String
                        Dim flworkhours As Double
                        Dim SQLQry As String

                        If RequestType = "EXTENDBOOKING" Then
                            RequestType = "E"
                        Else
                            RequestType = "P"
                        End If

                        dtEndDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("EndDate"))
                        dtEffectiveDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("EffectiveDate"))
                        flNewAllocation = CommonFunctions.General.CheckIsNothing(Request.QueryString("NewAllocation"))

                        SQLQry = "usp_Get_Workhours_From_RequestType " + intProjectEmployeeRoleID.ToString + ",'" + dtEndDate.ToString
                        SQLQry = SQLQry + "','" + dtEffectiveDate.ToString + "'," + flNewAllocation.ToString + ",'" + RequestType.ToString + "'"
                        flworkhours = CType(CommonFunctions.Data.GetDataScalar(SQLQry, MyBase.UseSQL), Double)

                        Response.Clear()
                        Response.Write("GETWORKHRS|" & flworkhours.ToString)
                        Response.End()

                    Case "GETALLOCATIONDETAILS"

                        Dim strSQL As String
                        Dim PerDayEffort As Double
                        Dim Percentage As Decimal
                        Dim drAllocationDetails As IDataReader
                        Dim strType, strUnit, strStartDate, strEndDate As String

                        strType = CommonFunctions.General.CheckIsNothing(Request.QueryString("Type"))
                        strUnit = CommonFunctions.General.CheckIsNothing(Request.QueryString("Unit"))
                        strStartDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("StartDate"))
                        strEndDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("EndDate"))

                        'PerDayEffort = Convert.ToDouble(CommonFunctions.General.CheckIsNothing(Request.QueryString("PerDayEffort")))

                        strSQL = "usp_Get_AllocationDetails_For_ExtendBooking " & intProjectEmployeeRoleID.ToString & ",'" & strType & "'," & strUnit _
                         & ",'" & strStartDate & "','" & strEndDate & "'"

                        'Percentage = Convert.ToDecimal(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL))
                        drAllocationDetails = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

                        If drAllocationDetails.Read() Then
                            Response.Clear()
                            Response.Write("GETALLOCATIONDETAILS" & "|" & drAllocationDetails.Item("WorkHoursPerDay").ToString & "|" & drAllocationDetails.Item("TotalWorkHours").ToString & "|" & drAllocationDetails.Item("Percentage").ToString)
                            Response.End()
                        End If
                    Case "ALLOCATIONVALIDATION"
                        Dim strSQL As String = ""
                        Dim AllocationPercentage As Double = 0.0
                        Dim drAllocation As IDataReader
                        Dim strStartDate As String = CommonFunction.General.CheckIsNothing(Request.QueryString("FromDate"))
                        Dim strEndDate As String = CommonFunction.General.CheckIsNothing(Request.QueryString("ToDate"))
                        Dim strProjectID As String = CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"))
                        Dim strEmployeeID As String = CommonFunction.General.CheckIsNothing(Request.QueryString("EmployeeID"))

                        strSQL = "usp_sel_FreeHours_ChangeAllocation "
                        strSQL += " '" + CommonFunction.Dates.GetDate(CType(strStartDate, Date)) + "'"
                        strSQL += ",'" + CommonFunction.Dates.GetDate(CType(strEndDate, Date)) + "'"
                        strSQL += "," + strEmployeeID
                        strSQL += "," + strProjectID

                        drAllocation = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
                        If drAllocation.Read Then
                            AllocationPercentage = CType(CommonFunction.Data.CheckIsDBNull(drAllocation("MinimumPercentage"), "0.0"), Double)
                        End If
                        CommonFunction.Data.DisposeDataReader(drAllocation)

                        Response.Clear()
                        Response.Write(FormatNumber(AllocationPercentage, 2))
                        Response.End()
                    Case Else
                        Response.Clear()
                        Response.Write(GetTotalResourceAllocation)
                        Response.End()

                        'End of addition by SuchitraP on 27-Sept-2007

                        ' Added By NitinVS on 21 May 2007 for WhizibleSEM 7.0 

                End Select


                'End Addition By SanaS on 14-Aug-2009 for calcualating the work hours for Extend or Prepone release request.

                'Added By GaneshG On 08-Sep-09 
            Case CommonFunction.Constants.APP_TAG_ProjectListForResourceAllocation

                Response.ContentType = "text/html"
                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("ProjectID")) <> "" Then
                    Session.Item("intProjectID") = HttpContext.Current.Request("ProjectID").ToString
                    'Added by SanaS for setting the projectname in session
                    ''Session("strProjectName") = CommonFunction.Data.GetDataScalar("Select ProjectName FROM tbl_PM_Project WHERE PROJECTID=" & CType(Session("intProjectID"), Long), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    Session("strProjectName") = CommonFunction.Data.GetDataScalar("usp_sel_ProjectName_tbl_PM_Project " & CType(Session("intProjectID"), Long), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    'End addition by SanaS for setting the projectname in session
                    If CommonFunction.Application.ApplyProjectLevelRole = True Then   'Application Project Level IF
                        If CType(Session("intRoleLevel"), Integer) = CommonFunction.Constants.ACCESS_LEVEL_LOW Or GetRole() = "Employee" Then

                            Dim drGetRole As IDataReader
                            drGetRole = CommonFunction.Data.GetDataReader("EXEC usp_Sel_EmployeeProjectRole " & CType(Session("intProjectID"), Long) & "," & CType(Session("intUserID"), Long), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            If drGetRole.Read Then
                                Session("intLastPostID") = Session("intPostID")
                                Session("intPostID") = drGetRole(0)
                            End If

                            CommonFunction.Data.DisposeDataReader(drGetRole)
                        Else
                            If Trim(CType(Session("intLastPostID"), String)) <> "" Then Session("intPostID") = Session("intLastPostID")
                        End If

                    End If

                    Response.Write("True")
                End If
                'End Addition By GaneshG
                'End Integration by SanaS on 25-Sep-2009 for Resource Allocation Changes
                ''

            Case 1038 ' Assigned Task Page
                'Added and modified By Amol Changle On: 13 May 2009
                'Purpose: To validate Task assignment for baseline
                strMode = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode")).ToString()
                If strMode.ToLower() = "taskvalidation" Then
                    Dim strTaskID As String
                    Dim strTaskStartDate As String
                    Dim strTaskEndDate As String
                    Dim strWork As String
                    Dim strDeliverableID As String
                    Dim strModuleID As String
                    Dim strSubProjectID As String
                    Dim strMilestoneID As String
                    Dim strSQL As New StringBuilder("")
                    Dim strErrMsg As String = ""
                    Dim strProjectID As String = ""

                    strProjectID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0").ToString()
                    strTaskID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TaskID"), "0").ToString()
                    strTaskStartDate = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("StartDate")).ToString()
                    strTaskEndDate = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EndDate")).ToString()
                    strWork = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Work"), "0").ToString()
                    strDeliverableID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DeliverableID"), "0").ToString()
                    strModuleID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ModuleID"), "0").ToString()
                    strSubProjectID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubProjectID"), "0").ToString()
                    strMilestoneID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MilestoneID"), "0").ToString()

                    'Commented & Added by GokulP on 09 Sept 2009 for IssueID = 33084
                    'If strDeliverableID = "" Or strModuleID = "" Or strSubProjectID = "" Or strMilestoneID = "" Then
                    Dim strFrompage As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromPage"), "").ToString()
                    If strFrompage.Trim.ToUpper <> "ASSIGNTASKEDITMODE" And (strDeliverableID = "" Or strModuleID = "" Or strSubProjectID = "" Or strMilestoneID = "") Then
                        'End of Comment & Addition by GokulP on 09 Sept 2009 for IssueID = 33084

                        Dim drWBS As IDataReader

                        'Added by GokulP on 09 Sept 2009 for IssueID = 33086
                        Dim strFromWhichPage As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhichPage"), "").ToString()
                        Dim strTaskNameForMsg As String = ""
                        If strFromWhichPage.Trim.ToUpper = "TASKMAPPING" Then
                            drWBS = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ProjectTasks_TaskMapping " + strProjectID + "," + strTaskID, MyBase.UseSQL)
                            If drWBS.Read Then
                                strTaskID = CType(CommonFunction.Data.CheckIsDBNull(drWBS("TaskID")), String)
                                strTaskStartDate = CType(CommonFunction.Data.CheckIsDBNull(drWBS("StartDate")), String)
                                strTaskEndDate = CType(CommonFunction.Data.CheckIsDBNull(drWBS("EndDate")), String)
                                strWork = CType(CommonFunction.Data.CheckIsDBNull(drWBS("Work")), String)
                                strTaskNameForMsg = CType(CommonFunction.Data.CheckIsDBNull(drWBS("TaskName")), String)
                            End If
                        Else
                            'End of Addition by GokulP on 09 Sept 2009 for IssueID = 33086
                            drWBS = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ProjectTasks " + strProjectID + "," + strTaskID, MyBase.UseSQL)
                            If drWBS.Read Then
                                If strDeliverableID = "" Then strDeliverableID = CType(CommonFunction.Data.CheckIsDBNull(drWBS("DeliverableID")), String)
                                If strModuleID = "" Then strModuleID = CType(CommonFunction.Data.CheckIsDBNull(drWBS("ModuleID")), String)
                                If strSubProjectID = "" Then strSubProjectID = CType(CommonFunction.Data.CheckIsDBNull(drWBS("SubProjectID")), String)
                                If strMilestoneID = "" Then strMilestoneID = CType(CommonFunction.Data.CheckIsDBNull(drWBS("MilestoneID")), String)
                            End If
                            'Added by GokulP on 09 Sept 2009 for IssueID = 33086
                        End If
                        'End of Addition by GokulP on 09 Sept 2009 for IssueID = 33086                        

                        CommonFunction.Data.DisposeDataReader(drWBS)
                    End If
                    'Added and modified By VijayD On: 9 Jun 2009
                    'Purpose: To validate Task assignment for baseline (While Selecting the Task or while Updating)
                    Dim strParentTaskID As String = "0"

                    strParentTaskID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ParentTagID"), "0").ToString()
                    Dim strUniqueID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UniqueID"), "0").ToString()

                    If strParentTaskID = 454 Then 'If the Copy Task Page is called from Module Page.
                        strDeliverableID = ""
                        strSubProjectID = ""
                        strMilestoneID = ""
                        strModuleID = strUniqueID
                    ElseIf strParentTaskID = 661 Then 'If the Copy Task Page is called from SubProject Page.
                        strDeliverableID = ""
                        strModuleID = ""
                        strMilestoneID = ""
                        strSubProjectID = strUniqueID
                    ElseIf strParentTaskID = 34 Then 'If the Copy Task Page is called from Milestone Page.
                        strDeliverableID = ""
                        strModuleID = ""
                        strSubProjectID = ""
                        strMilestoneID = strUniqueID
                    ElseIf strParentTaskID = 2133 Then 'If the Copy Task Page is called from Deliverable Page.
                        strSubProjectID = ""
                        strModuleID = ""
                        strMilestoneID = ""
                        strDeliverableID = strUniqueID
                    End If

                    'Commented by GokulP on 21 Sept 2009 for Removing the Validation as per discussion with PrashantSJ
                    ''Added by GokulP on 09 Sept 2009 for IssueID = 33086
                    'If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhichPage"), "").ToString().Trim.ToUpper.ToString = "TASKMAPPING" Then
                    '    strSQL.Append("Usp_Sel_TaskValidation_Baseline_TaskMapping ")
                    'Else
                    '    'End of Addition by GokulP on 09 Sept 2009 for IssueID = 33086
                    'strSQL.Append("Usp_Sel_TaskValidation_Baseline ")
                    '    'Added by GokulP on 09 Sept 2009 for IssueID = 33086
                    'End If
                    ''End of Addition by GokulP on 09 Sept 2009 for IssueID = 33086
                    'End of Comment by GokulP on 21 Sept 2009 for Removing the Validation as per discussion with PrashantSJ

                    strSQL.Append(strProjectID)
                    strSQL.Append(",")
                    If strTaskID = "" Then
                        strSQL.Append("0,")
                    Else
                        strSQL.Append(strTaskID)
                        strSQL.Append(",")
                    End If
                    If strTaskStartDate = "" Then
                        strSQL.Append("NULL,")
                    Else
                        strSQL.Append("'")
                        strSQL.Append(strTaskStartDate)
                        strSQL.Append("',")
                    End If
                    If strTaskEndDate = "" Then
                        strSQL.Append("NULL,")
                    Else
                        strSQL.Append("'")
                        strSQL.Append(strTaskEndDate)
                        strSQL.Append("',")
                    End If
                    If strWork = "" Then
                        strSQL.Append("NULL,")
                    Else
                        strSQL.Append(strWork)
                        strSQL.Append(",")
                    End If
                    If strDeliverableID = "" Then
                        strSQL.Append("NULL,")
                    Else
                        strSQL.Append(strDeliverableID)
                        strSQL.Append(",")
                    End If
                    If strModuleID = "" Then
                        strSQL.Append("NULL,")
                    Else
                        strSQL.Append(strModuleID)
                        strSQL.Append(",")
                    End If
                    If strSubProjectID = "" Then
                        strSQL.Append("NULL,")
                    Else
                        strSQL.Append(strSubProjectID)
                        strSQL.Append(",")
                    End If
                    If strMilestoneID = "" Then
                        strSQL.Append("NULL")
                    Else
                        strSQL.Append(strMilestoneID)
                    End If
                    'End Addition By VijayD On 9 Jun 2009

                    'Commented & Added by GokulP on 21 Sept 2009 for Removing the Validation as per discussion with PrashantSJ
                    'strErrMsg = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL.ToString(), True)))
                    strErrMsg = ""
                    'End of Comment & Addition by GokulP on 21 Sept 2009 for Removing the Validation as per discussion with PrashantSJ
                    strSQL = Nothing
                    Response.Clear()
                    Response.Write(strErrMsg)
                    Response.End()

                Else
                    Dim ProjectSettings As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString.Get("PROJECT_SETTINGS"), "")
                    If ProjectSettings.ToLower = "normal" Then
                        Call CASE1_ValidateLeaves()
                    Else
                        Call CASE2_ValidateLeaves()
                    End If

                End If
                'End Addition and modification by Amol Changle On: 13 May 2009
                ' End Addition By NitinVS on 21 May 2007 for WhizibleSEM 7.0 

                ' Added MahendraV On 1:05 PM 6/7/2007 for ReviewType on the basis of selected TaskType
                ' Start_MV_6/7/2007
            Case 2010
                Call ChangeReviewType()
                ' ' End_MV_6/7/2007                
            Case 3217
                'Added by ShradhhaM on 16,Jan 2008
                'Purpose : To check duplication of visa details from Employee Maintenance -- Visa Details sub tab
                Call CheckVisaDuplication()
                'End of addition by ShradhhaM on 16,Jan 2008
                'Added By NitinVS on 8 SEP 2008 for Project Profitability 
            Case 3949
                Call checkPayrollDates()
                'End Addition By NitinVS on 8 SEP 2008 for Project Profitability 
                ''Added by PrashantSJ on 14th July 2009 : for Quick planning-Ganttchart view
            Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                Call ValidatePlanDeliverable()

            Case "2125"
                Call ApproveResourceTimeSheet()
                ''End of addition by PrashantSJ on 14th July 2009 : for Quick planning-Ganttchart view
                'Added by SanaS on 27-Oct-2009
            Case 3982

                Call ValidateAllocation()
                'End Added by SanaS on 27-Oct-2009
                'Added by SanaS on 12-Nov-2009
            Case 3968
                Call ValidateBulkAllocation()
                'End Added by SanaS on 12-Nov-2009

                ''Added By Aniruddh Gujar on 13-Jun-2016 Purpose::To decrypt Password
            Case 99999
                m_strAction = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"))

                If m_strAction.ToUpper() = "VALIDATEUSERNAME" Then
                    Try
                        Dim strUserName As String
                        Dim strUniuqeID As String
                        Dim strSQL As String
                        Dim strResult As String
                        Dim strEncryptedUniuqeID As String

                        strUserName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UserName"), "").ToString()
                        strUniuqeID = Guid.NewGuid().ToString
                        strEncryptedUniuqeID = Token.GetUserNameToken(strUniuqeID)

                        strResult = strEncryptedUniuqeID

                        If m_LoginHashTable.ContainsKey(strUserName) Then
                            m_LoginHashTable.Remove(strUserName)
                        End If
                        m_LoginHashTable.Add(strUserName, strUniuqeID)

                        Response.Clear()
                        Response.Write(strResult)
                    Catch ex As Exception
                        m_LoginHashTable = Nothing
                        Response.Clear()
                        Response.Write(ex.Message)
                    End Try
                    Response.End()
                End If
                ''End of Added By Aniruddh Gujar on 13-Jun-2016 Purpose::To decrypt Password
                If m_strAction.ToUpper() = "VALIDATEUSERNAME" Then
                    Try
                        Dim strUserName As String
                        Dim strUniuqeID As String
                        Dim strSQL As String
                        Dim strResult As String
                        Dim strEncryptedUniuqeID As String

                        strUserName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UserName"), "").ToString()
                        strUniuqeID = Guid.NewGuid().ToString
                        strEncryptedUniuqeID = Token.GetUserNameToken(strUniuqeID)

                        strResult = strEncryptedUniuqeID

                        If m_LoginHashTable.ContainsKey(strUserName) Then
                            m_LoginHashTable.Remove(strUserName)
                        End If
                        m_LoginHashTable.Add(strUserName, strUniuqeID)

                        Response.Clear()
                        Response.Write(strResult)
                    Catch ex As Exception
                        m_LoginHashTable = Nothing
                        Response.Clear()
                        Response.Write(ex.Message)
                    End Try
                    Response.End()
                End If
                ''End of Added By Aniruddh Gujar on 13-Jun-2016 Purpose::To decrypt Password
        End Select

        If IsNothing(HttpContext.Current.Request.QueryString.Get("FROM")) = False Then
            EasyTaskEdit_validateLeaves()
        End If

        strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"))
        Select Case strMode.ToLower()

            Case "customerportal"
                Dim strCalledFrom As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("CalledFrom"), "")
                If strCalledFrom = "IssueTab" Or strCalledFrom = "TaskSTab" Then

                    Dim strTabName As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("TabName"), "")
                    Dim strCustomerId As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("CustomerId"), "0")
                    Dim strEmployeeID As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("EmployeeID"), "0")
                    Dim strProjectID As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"), "0")
                    Dim strLoginType As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("LoginType"), "")

                    Dim strSummaryIssueStatus As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("SummaryIssueStatus"), "")
                    Dim strSummaryIssueType As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("SummaryIssueType"), "")
                    Dim strSummaryIssueCriteria As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("SummaryIssueCriteria"), "")
                    Dim strWeekDate As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("WeekDate"), "")
                    Dim strIssueNextLastToday As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("IssueNextLastToday"), "")

                    Dim strProjectIssueStatus As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectIssueStatus"), "")

                    Dim strCurrWeekStartDate As String
                    Dim strPrevWeekStartDate As String

                    If (strSummaryIssueCriteria = "Last Week") Then
                        Dim WeekStart As Integer = 2
                        Dim WeekToday As Integer = Weekday(Now)
                        Dim Cnt As Integer
                        Cnt = WeekToday - WeekStart

                        strPrevWeekStartDate = CommonFunctions.General.CheckIsNothing(CType(DateAdd(DateInterval.Day, -Cnt, Now.Date), String), CType(DateAdd(DateInterval.Day, -Cnt, Now.Date), String))
                        strCurrWeekStartDate = CType(DateAdd(DateInterval.Day, -7, CType(strPrevWeekStartDate, Date)), String)

                    ElseIf (strSummaryIssueCriteria = "Next Week") Then
                        Dim WeekStart As Integer = 2
                        Dim WeekToday As Integer = Weekday(Now)
                        Dim Cnt As Integer
                        Cnt = WeekToday - WeekStart
                        strPrevWeekStartDate = CommonFunctions.General.CheckIsNothing(CType(DateAdd(DateInterval.Day, -Cnt, Now.Date), String), CType(DateAdd(DateInterval.Day, -Cnt, Now.Date), String))
                        strCurrWeekStartDate = CType(DateAdd(DateInterval.Day, 7, CType(strPrevWeekStartDate, Date)), String)
                    Else
                        Dim WeekStart As Integer = 2
                        Dim WeekToday As Integer = Weekday(Now)
                        Dim Cnt As Integer
                        Cnt = WeekToday - WeekStart
                        strPrevWeekStartDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("WeekDate"), CType(DateAdd(DateInterval.Day, -Cnt, Now.Date), String))
                        strCurrWeekStartDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("WeekDate"), CType(DateAdd(DateInterval.Day, -Cnt, Now.Date), String))
                    End If
                    If strCalledFrom = "IssueTab" Then

                        Dim PageNumber As String = Request.QueryString("PageNumber").ToString()
                        Dim Maximize As Boolean = CType(Request.QueryString("Maximize"), Boolean)
                        Dim Period As String
                        If Not Request.QueryString("Period") Is Nothing And Request.QueryString("Period") <> "0" And Request.QueryString("Period") <> "" Then
                            Period = CType(Request.QueryString("Period"), String)
                        Else
                            Period = "NULL"
                        End If

                        Response.Clear()
                        Response.Write(DrawSummary_Project_IssueDetails(strTabName, strEmployeeID, strCustomerId, strProjectID, strSummaryIssueStatus, strSummaryIssueType, strLoginType, strIssueNextLastToday, strCurrWeekStartDate, strPrevWeekStartDate, strProjectIssueStatus, PageNumber, Maximize, Period))
                        Response.End()
                    End If
                    If strCalledFrom = "TaskSTab" Then
                        Dim strProjectTaskStatus As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectTaskStatus"), "")
                        Dim strSummaryTaskStatus As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("SummaryTaskStatus"), "")

                        Dim PageNumber As String = Request.QueryString("PageNumber").ToString()
                        Dim Maximize As Boolean = CType(Request.QueryString("Maximize"), Boolean)
                        Dim Period As String
                        If Not Request.QueryString("Period") Is Nothing And Request.QueryString("Period") <> "0" And Request.QueryString("Period") <> "" Then
                            Period = CType(Request.QueryString("Period"), String)
                        Else
                            Period = "NULL"
                        End If


                        Response.Clear()
                        Response.Write(DrawGridTasks(strTabName, strCalledFrom, strEmployeeID, strCustomerId, strProjectID, strLoginType, strProjectTaskStatus, strCurrWeekStartDate, strIssueNextLastToday, strSummaryTaskStatus, PageNumber, Maximize, Period))
                        Response.End()
                    End If
                ElseIf strCalledFrom = "MilestoneTab" Then
                    Dim strTabName As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("TabName"), "")
                    Dim strCustomerId As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("CustomerId"), "0")
                    Dim strEmployeeID As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("EmployeeID"), "0")
                    Dim strProjectID As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"), "0")
                    Dim strLoginType As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("LoginType"), "")

                    Dim strMilestones_SearchCriteria As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("Milestones_SearchCriteria"), "")
                    Dim strSummaryDeliverables As String

                    Response.Clear()
                    Response.Write(DrawMileStonesDetails(strTabName, strEmployeeID, strCustomerId, strProjectID, strMilestones_SearchCriteria))
                    Response.End()
                ElseIf strCalledFrom = "DeliverableTab" Then
                    Dim strTabName As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("TabName"), "")
                    Dim strCustomerId As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("CustomerId"), "0")
                    Dim strEmployeeID As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("EmployeeID"), "0")
                    Dim strProjectID As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"), "0")
                    Dim strLoginType As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("LoginType"), "")

                    Dim strDeliverables_SearchCriteria As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("Deliverables_SearchCriteria"), "")
                    Dim strSummaryDeliverables As String

                    Response.Clear()
                    Response.Write(DrawDeliverablesDetails(strTabName, strEmployeeID, strCustomerId, strProjectID, strDeliverables_SearchCriteria))
                    Response.End()
                Else
                    Dim strLoginType As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("LoginType"))
                    Dim strCustomerID As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("CustomerID"))
                    Dim strEmployeeID As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("EmployeeID"))

                    Response.Clear()
                    Response.Write(DrawSummaryProjectTabs(strLoginType, strCustomerID, strEmployeeID))
                    Response.End()
                End If

                'Added By VijayD On 20 August 2009
                'Purpose : To Provide  the Resource level  Validatation 
            Case "crm_requestassignment"
                Dim strMsg As String
                Dim CurrentStartDate As Date = CDate(CommonFunctions.General.CheckIsNothing(Request.QueryString("CurrentStartDate"))).ToString("dd-MMM-yyyy")
                Dim CurrentEndDate As Date = CDate(CommonFunctions.General.CheckIsNothing(Request.QueryString("CurrentEndDate"))).ToString("dd-MMM-yyyy")
                Dim dtResourceStartDate As Date
                Dim dtResourceEndDate As Date
                Dim strSQL As String = ""
                Dim dr As IDataReader
                Dim strEmployeeID As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("EmployeeID"), "0")
                Dim strProjectID As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"), "0")
                ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                ''Dim strEmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select UserName From Tbl_Pm_Employee Where EmployeeID=" + strEmployeeID, True), ""))
                Dim strEmployeeName = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_UserName_Tbl_Pm_Employee " + strEmployeeID, True), ""))
                ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                strSQL = " SELECT ExpectedStartDate,ExpectedEndDate FROM tbl_PM_ProjectEmployeeRole "
                strSQL = strSQL + " WHERE tbl_PM_ProjectEmployeeRole.ProjectID =" + strProjectID
                strSQL = strSQL + " AND  tbl_PM_ProjectEmployeeRole.EmployeeID = " + strEmployeeID
                dr = CommonFunctions.Data.GetDataReader(strSQL, True)
                While dr.Read()
                    dtResourceStartDate = CDate(CommonFunctions.Data.CheckIsDBNull(dr("ExpectedStartDate"))).ToString("dd-MMM-yyyy")
                    dtResourceEndDate = CDate(CommonFunctions.Data.CheckIsDBNull(dr("ExpectedEndDate"))).ToString("dd-MMM-yyyy")
                End While
                CommonFunction.Data.DisposeDataReader(dr)
                If DateDiff(DateInterval.Day, CurrentStartDate, dtResourceStartDate) > 0 Then
                    strMsg = "Start date should be between resource (<=>)  start date (<==> )  and end date (<===>) on project"
                    strMsg = Replace(strMsg, "<=>", strEmployeeName)
                    strMsg = Replace(strMsg, "<==>", dtResourceStartDate)
                    strMsg = Replace(strMsg, "<===>", dtResourceEndDate)
                End If
                If (DateDiff(DateInterval.Day, dtResourceEndDate, CurrentEndDate) > 0) Then
                    strMsg = "End date should be between resource (<=>)  start date (<==> )  and end date (<===>) on project"
                    strMsg = Replace(strMsg, "<=>", strEmployeeName)
                    strMsg = Replace(strMsg, "<==>", dtResourceStartDate)
                    strMsg = Replace(strMsg, "<===>", dtResourceEndDate)
                End If
                Response.Clear()
                Response.Write(strMsg)
                Response.End()
                'End Addition ByVijayD On20 August 2009

            Case "leavesvalidation"
                Dim strMsg As String
                Dim dtStartDate As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("StartDate")).ToString
                Dim dtEndDate As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("EndDate")).ToString
                Dim strTaskID As String = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskID"), "0"))
                Dim strSQL As String = ""
                Dim dr As IDataReader
                strMsg = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_EmployeeLeaveDetails_Gantt " + strTaskID + ",'" + dtStartDate + "','" + dtEndDate + "'", True), ""))
                Response.Clear()
                Response.Write(strMsg)
                Response.End()
            Case "dailyactivity_gantt"
                Dim strMsg As String
                Dim dtStartDate As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("StartDate")).ToString
                Dim dtEndDate As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("EndDate")).ToString
                Dim strTaskID As String = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskID"), "0"))
                Dim strSQL As String = ""
                Dim dr As IDataReader
                strMsg = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_Pm_DailyActivity_Gantt " + strTaskID + ",'" + dtStartDate + "','" + dtEndDate + "'", True), ""))
                Response.Clear()
                Response.Write(strMsg)
                Response.End()
            Case "wbsbaselinevalidation"
                Dim strMsg As String
                Dim strProjectID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0").ToString()
                Dim strID As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.General.CheckIsNothing(Request.QueryString("ID")), "0").ToString()
                Dim strType As String = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("Type"), "DELI"))
                Dim strFromWhere As String = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"), ""))
                Dim strSQL As String = ""
                Dim dr As IDataReader
                strMsg = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_Sel_TaskValidation_Baseline_Gantt " + strProjectID + "," + strID + ",'" + strType + "','" + strFromWhere + "'", True), ""))
                Response.Clear()
                Response.Write(strMsg)
                Response.End()
            Case "resourcejoing_gantt"
                Dim strMsg As String
                Dim strResourceID As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("ResourceID"), "0").ToString()
                Dim dtStartDate As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("StartDate")).ToString
                Dim dtEndDate As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("EndDate")).ToString
                strMsg = Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_Sel_ResourceJoing_Validation_Gantt " + strResourceID + ",'" + dtStartDate + "','" + dtEndDate + "'", True), ""))
                Response.Clear()
                Response.Write(strMsg)
                Response.End()
        End Select

    End Sub
    Private Sub ApproveResourceTimeSheet()
        Dim m_strUniqueID As String = HttpContext.Current.Request.QueryString("UniqueID")
        Dim m_strComment As String = HttpContext.Current.Request.QueryString("Comment")
        If m_strUniqueID <> "" Then
            Approved(m_strUniqueID, m_strComment)
        End If
        Response.Clear()
        Response.Write("")
        Response.End()
    End Sub
    Private Sub Approved(ByVal strUniqueID As String, ByVal strComment As String)
        '=====================================================================
        ' Procedure Name        : Approved()
        ' Purpose               : To Approve the Leave,IR,Expense,Project,Project TimeSheet and Resourse TimeSheet
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 8:12 PM 9/19/2007
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String
        Dim drVerify As IDataReader
        Dim m_drTimesheet As IDataReader
        Dim intVerifiedBy As Long
        Dim intDailyActivityID As Integer
        Dim intVerified As Integer
        Dim strSQLQuery As String
        Dim strRemarks As String
        Dim dtVerificationDate As String
        Dim strFromDate As String
        Dim strToDate As String

        dtVerificationDate = CType(Now(), String)
        intVerifiedBy = HttpContext.Current.Session("intUserID")
        strSQLQuery = "usp_Sel_ResourceTimesheetDADetails " & strUniqueID & "," & CType(intVerifiedBy, String)
        m_drTimesheet = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        'Get Activity record details for the resource timesheet
        Do While m_drTimesheet.Read()
            strFromDate = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("FromDate"), CType(Now(), String)), String)
            strToDate = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("ToDate"), CType(Now(), String)), String)
            intDailyActivityID = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("DailyActivityEntryID"), "0"), Integer)
            intVerified = 1
            strRemarks = ""

            '--- Execute sp to update verification details to Daily Activity Table
            strSQLQuery = "Exec usp_Upd_PM_ResourceTimesheetVerification " + CType(intDailyActivityID, String) + "," + CType(intVerified, String)
            strSQLQuery = strSQLQuery + "," + CType(intVerifiedBy, String) + ",'" + CType(dtVerificationDate, String) + "','" + strRemarks + "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        Loop

        'Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
        strSQLQuery = "Exec usp_Upd_tbl_PM_ResourceTimesheetStatus " & strUniqueID & "," & CType(intVerifiedBy, String) & "," & "'V'"
        CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        CommonFunctions.Data.DisposeDataReader(drVerify)


        'If Resource TimeSheet are verified then change the status to 'verified' 
        strSQLQuery = "Exec usp_Sel_ResourceTimesheet_GetVerifiedTasksStatus " & CType(strUniqueID, String)
        drVerify = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        If drVerify.Read = False Then
            strSQLQuery = "Exec usp_Upd_ResouceTimesheetStatus " & CType(strUniqueID, String) & ",'V'"
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        End If

        CommonFunctions.Data.DisposeDataReader(drVerify)
        CommonFunctions.Data.DisposeDataReader(m_drTimesheet)

    End Sub
    Private Sub ValidatePlanDeliverable()
        '====================================================================
        ' Procedure Name        : ValidatePlanDeliverable
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To validate plan deliverable condition and return the result
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : PrashantSJ 
        ' Created               : 14,Julty 2009
        ' Revisions             :
        '=====================================================================
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

        Dim intBaselineNumber As Integer = 0, strBaselineMessage As String = ""
        Dim strTemplateID As String

        drStatus = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_CNF_Project_Status " & HttpContext.Current.Session("intProjectID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drStatus.Read() Then
            blnProjectOnHold = CType(CommonFunction.Data.CheckIsDBNull(drStatus("ProjectOnHold"), "False"), Boolean)
            strOnHoldMessage = CType(CommonFunction.Data.CheckIsDBNull(drStatus("ProjectOnHoldMsg"), ""), String)
            intBaselineNumber = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drStatus("BaselineNumber"), "0"), "0"), Integer)
            strBaselineMessage = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drStatus("BaseLineMessage"), ""), ""), String)
        End If
        CommonFunction.Data.DisposeDataReader(drStatus)

        Dim blnIsProjectCreationWorkflowReqd As Boolean = False
        blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)

        strScheduleID = CommonFunction.General.CheckIsNothing(Request.QueryString("ScheduleID"), "").ToString.Trim

        If strScheduleID.Trim <> "" Then

            strSQL = "SELECT * FROM tbl_PM_OtherSchedules " & _
            " WHERE tbl_PM_OtherSchedules.ScheduleID = " & strScheduleID & _
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
                    ' strFunction &= "return;" + vbCrLf

                ElseIf intVoidOrOnHold = 1 Then
                    strFunction = "alert(""Planning is not allowed when deliverable is Void or OnHold."");" & vbCrLf
                    ' strFunction &= "return;" + vbCrLf

                Else
                    'Also add parameters of Deliverable Details page so that when Plan Deliverables 
                    'finishes, it is used while refreshing the Deliverable Details page
                    ' Modified  By  : NitinVS on 22 Feb 2005
                    ' Purpose       : To set the Default value for Template 
                    '                 Added Query String Parameter TemplateID 

                    With HttpContext.Current.Request
                        strFunction = "window.open(""../PM/PM_PlanDeliverable.aspx?" & _
                            "Mode=EDIT" & _
                            "&MasterTagID=" & CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE & _
                            "&ScheduleID=" & strScheduleID & _
                            "&ScheduleTypeID=" & strScheduleTypeID & _
                            "&DeliverableID=" & strScheduleID & _
                            "&DeliverableTypeID=" & strScheduleTypeID & _
                            "&EarliestStartDate=" & strEarliestStartDate & _
                            "&DepartmentID=" & strDepartmentID & _
                            "&ProjectSystemID=" & strProjectSystemID & _
                            "&ProjectSiteID=" & strProjectSiteID & _
                            "&PackageID=" & strPackageID & _
                            "&TemplateID=" & strTemplateID & _
                            "&FromWhere=" & CommonFunction.General.CheckIsNothing(.QueryString("FromWhere"), "") & _
                            "&PagingAlphabet=" & CommonFunction.General.CheckIsNothing(.QueryString("PagingAlphabet"), "") & _
                            "&SortBy=" & CommonFunction.General.CheckIsNothing(.QueryString("SortBy"), "") & _
                            "&SortOrder=" & CommonFunction.General.CheckIsNothing(.QueryString("SortOrder"), "") & _
                            "&ParentTagID=" & CommonFunction.General.CheckIsNothing(.QueryString("ParentTagID"), "") & _
                            "&FromCL=1" & _
                            """, ""_new"", ""resizable=yes,scrollbars=no,left="" + ((window.screen.width - 850)/2) + "",top="" + ((window.screen.height - 650)/2) + "",width=850,height=650"");" + vbCrLf
                        'strFunction &= "return;" + vbCrLf

                        ' End Modification By NitinVS on 22 Feb 2005 

                        If blnIsProjectCreationWorkflowReqd = True Then
                            If intBaselineNumber = 0 Then
                                strFunction = "alert('" & strBaselineMessage & "'); " & vbCrLf
                                '     strFunction += "return;"
                            End If
                        End If
                        If blnProjectOnHold = True Then
                            strFunction += "alert('" & strOnHoldMessage & "'); " & vbCrLf
                            ' strFunction += "return;"
                        End If


                    End With
                End If
            End If
        End If
        Response.Clear()
        Response.Write(strFunction)
        Response.End()
    End Sub


    Private Sub CheckVisaDuplication()
        '====================================================================
        ' Procedure Name        : CheckVisaDuplication
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To check duplication of visa details. 
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : ShraddhaM 
        ' Created               : 16,Jan 2008
        ' Revisions             :
        '=====================================================================
        Dim IsExists As Boolean
        Dim strQuery As String
        Dim strCountryID As String
        Dim strVisaTypeID As String
        Dim strValidFrom As String
        Dim strValidUpto As String
        Dim strEmployeeID As String
        Dim PK As String

        strCountryID = HttpContext.Current.Request.QueryString("CountryID")
        strVisaTypeID = HttpContext.Current.Request.QueryString("VisaTypeID")
        strValidFrom = HttpContext.Current.Request.QueryString("ValidFrom")
        strValidUpto = HttpContext.Current.Request.QueryString("ValidUpto")
        strEmployeeID = HttpContext.Current.Request.QueryString("EmployeeID")
        PK = HttpContext.Current.Request.QueryString("PK")
        If PK Is Nothing Or PK = "" Then
            PK = "NULL"
        End If

        strQuery = "usp_sel_VisaDetials_DuplicationCheck " + strEmployeeID + "," + strVisaTypeID + ",'" + strValidFrom + "','" + strValidUpto + "'," + strCountryID + "," + PK
        IsExists = CType(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), Boolean)

        Response.Clear()
        Response.Write(IsExists)
        Response.End()


    End Sub
    'Integrated By SanaS on 9-11-2009
    Private Sub ValidateAllocation()
        '====================================================================
        ' Function Name         : ValidateAllocation
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To validated data entered while allocating resource on Project from Resource Allocation Dashboard
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SanaS 
        ' Created               : 26-Oct-2009
        ' Revisions             :
        '=====================================================================
        Dim strProjectid As String
        Dim stremployeeid As String
        Dim strstartdate As String
        Dim strendddate As String
        Dim strallocationPer As String
        Dim strQuery As String
        Dim strmsg As String
        strProjectid = CommonFunction.General.CheckIsNothing(Request.QueryString("Project"))
        stremployeeid = CommonFunction.General.CheckIsNothing(Request.QueryString("EmployeeId"))
        strstartdate = CommonFunction.General.CheckIsNothing(Request.QueryString("FromDate"))
        strendddate = CommonFunction.General.CheckIsNothing(Request.QueryString("ToDate"))
        strallocationPer = CommonFunction.General.CheckIsNothing(Request.QueryString("Allocation"))
        strQuery = "EXEC usp_validate_ProjectEmployee_Allocation " + stremployeeid + "," + strProjectid + ",'" + strstartdate.ToString + "','"
        strQuery += strendddate + "'," + strallocationPer.ToString
        strmsg = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strQuery, True), "")
        Response.Clear()
        Response.Write(strmsg)
        Response.End()



    End Sub
    'End Integration by SanaS
    'Added by SanaS on 12-Nov-2009
    Private Sub ValidateBulkAllocation()
        '====================================================================
        ' Function Name         : ValidateAllocation
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To validated data entered while allocating resource on Project from Resource Allocation Dashboard
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SanaS 
        ' Created               : 26-Oct-2009
        ' Revisions             :
        '=====================================================================

        Dim strSelectedEmployee As String
        Dim strstartdate As String
        Dim strendddate As String

        Dim strQuery As String
        Dim strmsg As String

        strSelectedEmployee = CommonFunction.General.CheckIsNothing(Request.QueryString("SelectedEmployee"))
        strstartdate = CommonFunction.General.CheckIsNothing(Request.QueryString("FromDate"))
        strendddate = CommonFunction.General.CheckIsNothing(Request.QueryString("ToDate"))

        strQuery = "EXEC usp_validate_ProjectEmployee_BulkAllocation '" + strSelectedEmployee + "','" + strstartdate.ToString + "','"
        strQuery += strendddate + "'"
        strmsg = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strQuery, True), "")
        Response.Clear()
        Response.Write(strmsg)
        Response.End()
    End Sub
    'End Addition by SanaS on 12-Nov-2009

    Private Function GetTotalResourceAllocation() As String
        '====================================================================
        ' Function Name         : GetTotalResourceAllocation
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Total % allocation of particular resource for all projects
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SuchitraP 
        ' Created               : 27-Sept-2007
        ' Revisions             :
        '=====================================================================
        Dim strEmployeeID As String
        Dim strProjectID As String
        Dim strQuery As String
        Dim TotalResAllocation As String

        strEmployeeID = HttpContext.Current.Request.QueryString("EmployeeID")
        ''Modified by swapnil aswale on 22-01-2016 for [saving resource data]
        If strEmployeeID = "" Then
            Return ""
        Else
            strProjectID = CType(HttpContext.Current.Session("intProjectID"), String)
            strQuery = "EXEC usp_Sel_tbl_PM_ProjectEmployeeRole_ResourcePer " + strEmployeeID + "," + strProjectID
            TotalResAllocation = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, True), "0"), String)

            Return TotalResAllocation
        End If
        ''Ended


    End Function
#Region "Leave and Work from home validation for Task"

    Public Shared Sub ChangeReviewType()
        '====================================================================
        ' Procedure Name        : ChangeReviewType
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Review type for selected task type 
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : MahendraV 
        ' Created               : 2:05 PM 6/7/2007
        ' Revisions             :
        '=====================================================================
        Dim strReturn As String = ""
        Dim strQuery As String = ""
        Dim lngPhaseTaskID As Long
        Dim blnIsNewTask As Boolean
        Dim strReviewTypeID As String
        Dim strReviewType As String
        Dim strReviewInfo As String

        Dim drRevieType As IDataReader
        Dim WebForm As WebPages.Template.WhizTemplate = New WebPages.Template.WhizTemplate
        lngPhaseTaskID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString.Get("PhaseTaskID"), "0"), Long)
        strQuery = "Exec usp_sel_tbl_PRS_PhaseTask_Draft_GetRevieTypes " & lngPhaseTaskID.ToString()
        drRevieType = CommonFunctions.Data.GetDataReader(strQuery, WebForm.UseSQL)

        strReviewInfo = "->"
        While drRevieType.Read
            strReviewType = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drRevieType("CReviewType"), ""), "")
            strReviewTypeID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drRevieType("CReviewTypeID"), ""), "")

            strReviewInfo &= "|" & strReviewType & "->" & strReviewTypeID
        End While
        HttpContext.Current.Response.Clear()
        HttpContext.Current.Response.ContentType = "text/html"

        If Not strReviewInfo Is Nothing Then
            HttpContext.Current.Response.Write(strReviewInfo)
        Else
            HttpContext.Current.Response.Write("null")
        End If
        CommonFunctions.Data.DisposeDataReader(drRevieType)





    End Sub
    Public Shared Sub CASE1_ValidateLeaves()
        '====================================================================
        ' Procedure Name        : ValidateLeaves
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Validate Leaves for selected resource and dates 
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NitinVS 
        ' Created               : 21 May 2007
        ' Revisions             :
        '=====================================================================
        Dim blnIsNewTask As Boolean
        Dim arrEmpId() As String
        Dim intCtr As Integer
        Dim intNumberOfEmployees As Integer = 0
        Dim dblTempWork As Double = 0
        Dim strEmployeeNames As String
        Dim strTempName As String
        Dim strEmployeeId As String
        Dim strCurrentStartDate As String
        Dim strCurrentEndDate As String
        Dim strLeaveMessage As String
        Dim lngTaskId As Long
        Dim WebForm As WebPages.Template.WhizTemplate = New WebPages.Template.WhizTemplate
        Dim ProjectSettings As String = ""

        WebForm.InitializeResources("AppResources.PM_TaskAssignment", "AppResources")
        lngTaskId = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString.Get("TaskId"), "0"), Long)

        If lngTaskId > 0 Then
            blnIsNewTask = False
        Else
            blnIsNewTask = True
        End If

        strCurrentStartDate = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("FromDate"), "")
        strCurrentEndDate = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("ToDate"), "")
        strEmployeeId = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("EmployeeIDs"), "")

        If blnIsNewTask = True Then
            arrEmpId = strEmployeeId.Split(CType(",", Char))
            intNumberOfEmployees = arrEmpId.Length()
            strEmployeeNames = ""
            For intCtr = 0 To intNumberOfEmployees - 1
                If arrEmpId(intCtr) <> "" Then
                    'Check if there is any leave(s) between the start date and end date
                    strTempName = CheckLeaves(CType(arrEmpId(intCtr), Long), strCurrentStartDate, strCurrentEndDate)
                    If strTempName <> "" Then strEmployeeNames &= strTempName + "<==>"
                End If
            Next
            strLeaveMessage = strEmployeeNames
        Else
            'Check if there is any leave(s) between the start date and end date
            strTempName = CheckLeaves(CType(strEmployeeId, Long), strCurrentStartDate, strCurrentEndDate)
            strLeaveMessage = strTempName
        End If

        HttpContext.Current.Response.Clear()
        HttpContext.Current.Response.Write(strLeaveMessage)

    End Sub
    Public Shared Sub CASE2_ValidateLeaves()
        '====================================================================
        ' Procedure Name        : ValidateLeaves
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Validate Leaves for selected resource and dates 
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NitinVS 
        ' Created               : 21 May 2007
        ' Revisions             :
        '=====================================================================

        Dim arrEmpId() As String
        Dim intCnt As Integer
        Dim intNumberOfEmployees As Integer = 0
        Dim strEmployeeNames As String
        Dim strTempName As String
        Dim strEmployeeId As String
        Dim strLeaveMessage As String
        Dim WebForm As WebPages.Template.WhizTemplate = New WebPages.Template.WhizTemplate

        WebForm.InitializeResources("AppResources.PM_AssignTaskResources", "AppResources")
        strEmployeeId = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("EmployeeIDs"), "")

        ''Added by Usha Pandit on 07 Mar 2019 Purpose::Whizible 2 Work field change
        Dim strFromDate As String
        Dim strToDate As String
        Dim arrFromDate() As String
        Dim arrToDate() As String


        strFromDate = HttpContext.Current.Request.QueryString("FromDate")
        strToDate = HttpContext.Current.Request.QueryString("ToDate")

        arrFromDate = CommonFunctions.General.CheckIsNothing(strFromDate, "").Split(CType(";", Char))
        arrToDate = CommonFunctions.General.CheckIsNothing(strToDate, "").Split(CType(";", Char))

        ''End of Added by Usha Pandit on 07 Mar 2019 Purpose::Whizible 2 Work field change

        arrEmpId = strEmployeeId.Split(CType(";", Char))
        intNumberOfEmployees = arrEmpId.Length()
        For intCnt = 0 To intNumberOfEmployees - 1
            If arrEmpId(intCnt) <> "" Then
                Dim strEmpList As String() = arrEmpId(intCnt).Split(CType(":", Char))
                'Check if there is any leave(s) between the start date and end date
                ''Commented and Added by Usha Pandit on 07 Mar 2019 Purpose::Whizible 2 Work field change
                'strTempName = CheckLeaves(CType(strEmpList(0), Long), strEmpList(1).ToString, strEmpList(2).ToString)
                If strFromDate Is Nothing Then
                    strTempName = CheckLeaves(CType(strEmpList(0), Long), strEmpList(1).ToString, strEmpList(2).ToString)
                Else
                    Dim strFromDateList As String() = CommonFunctions.General.CheckIsNothing(arrFromDate(intCnt), "").Split(CType(":", Char))
                    Dim strToDateList As String() = CommonFunctions.General.CheckIsNothing(arrToDate(intCnt), "").Split(CType(":", Char))

                    strTempName = CheckLeaves(CType(strEmpList(0), Long), strFromDateList(0).ToString, strToDateList(0).ToString)

                End If
               
                ''End of Added by Usha Pandit on 07 Mar 2019 Purpose::Whizible 2 Work field change

                strEmployeeNames += strTempName + "<=>"
            End If
        Next
        strLeaveMessage = strEmployeeNames
        HttpContext.Current.Response.Clear()
        HttpContext.Current.Response.Write(strLeaveMessage)
    End Sub

    Public Shared Sub EasyTaskEdit_validateLeaves()
        'ShraddhaM 22 Aug 2006
        Dim StartDate As String
        Dim EndDate As String
        Dim EmpID As String
        Dim strEmployeeNames As String
        Dim strLeaveMessage As String
        StartDate = HttpContext.Current.Request.QueryString("startDate")
        EndDate = HttpContext.Current.Request.QueryString("endDate")
        EmpID = HttpContext.Current.Request.QueryString("EmployeeID")
        Dim strTempName As String
        strTempName = CheckLeaves(CType(EmpID, Long), StartDate, EndDate)
        If strTempName <> "" Then
            strEmployeeNames &= strTempName + "<==>"


            'Check if there is any leave(s) between the start date and end date
            'strTempName = CheckLeaves(CType(arrEmpId(intCtr), Long), strCurrentStartDate, strCurrentEndDate)
            'If strTempName <> "" Then strEmployeeNames &= strTempName + "<==>"
            'End If

            strLeaveMessage = strEmployeeNames

            'Check if there is any leave(s) between the start date and end date
            'strTempName = CheckLeaves(CType(strEmployeeId, Long), strCurrentStartDate, strCurrentEndDate)
            strLeaveMessage = strTempName
            'End If
            ' End If
            HttpContext.Current.Response.Clear()
            HttpContext.Current.Response.Write(strLeaveMessage)
        End If

    End Sub
    Public Shared Function CheckLeaves(ByVal lngEmployeeID As Long, ByVal strStartDate As String, _
            ByVal strEndDate As String) As String
        '====================================================================
        ' Procedure Name       : CheckLeaves
        ' Parameters Passed    : EmployeeId - The Resources unique id
        '                       strStartDate - The Tasks Start date
        '                       strEndDate - The Tasks End date
        ' Returns              : The Name of the Employee if there is leave in between the start date and end date
        ' Parameters Affected  : None
        ' Purpose              : This function checks whether there is any leave in between the task start date 
        '                        and end date of the resource.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : August 10, 2004
        ' Revisions            : 
        '=====================================================================

        Dim strReturn As String = ""
        Dim strQuery As String = ""
        ''Added by ManishK on 6th Feb 2006 for WFH Issue 
        Dim drLeave As IDataReader
        Dim strTemp As String = ""
        Dim strWFHDays As String = ""
        Dim strLeaveMessage As String = ""
        Dim strWFHMessage As String = ""
        Dim WebForm As WebPages.Template.WhizTemplate = New WebPages.Template.WhizTemplate
        Dim strEmployeeName As String
        Dim strLeaveDays As String

        WebForm.InitializeResources("AppResources.PM_TaskAssignment", "AppResources")
        ''End Added by ManishK on 6th Feb 2006 for WFH Issue 
        strQuery = "Exec usp_Sel_tbl_PM_EmployeeLeaveDetails_ForGivenDates " & lngEmployeeID.ToString()
        strQuery &= ", '" & strStartDate & "'"
        strQuery &= ", '" & strEndDate & "'"
        ''Added by ManishK on 6th Feb 2006 for WFH Issue 
        drLeave = CommonFunctions.Data.GetDataReader(strQuery, WebForm.UseSQL)
        While drLeave.Read
            strEmployeeName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drLeave("EmployeeName"), ""), "")
            If strEmployeeName <> "" Then
                strLeaveDays = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drLeave("LeaveDays"), ""), "")
                strWFHDays = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drLeave("WFHDays"), ""), "")
                If strLeaveDays <> "" Then
                    strLeaveMessage = strEmployeeName + " " + WebForm.GetResourceString("CONFIRM_LEAVES") + " " + strLeaveDays.Remove(0, 1) + " "
                End If
                If strWFHDays <> "" Then
                    strWFHMessage = strEmployeeName + " " + WebForm.GetResourceString("CONFIRM_WFH") + " " + strWFHDays.Remove(0, 1)
                End If
                strTemp = strLeaveMessage + " <==> " + strWFHMessage
            End If
        End While
        CommonFunctions.Data.DisposeDataReader(drLeave)
        strReturn = strTemp
        'strReturn = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), ""), "")
        Return strReturn

    End Function

#End Region

    Private Sub checkPayrollDates()
        '====================================================================
        ' Function Name         : checkPayrollDates
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Employee Payroll dates should not be overlapping 
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NitinVS 
        ' Created               : 08-Sept-2008
        ' Revisions             :
        '=====================================================================
        Dim strEmployeeID As Long = 0
        Dim strFromDate As String = ""
        Dim strToDate As String = ""
        Dim strResult As String = ""
        Dim EmployeePayrollId_PK As String = ""
        Dim sbSQL As New System.Text.StringBuilder
        strEmployeeID = HttpContext.Current.Request.QueryString("EmployeeID").ToString()
        strFromDate = HttpContext.Current.Request.QueryString("FromDate").ToString()
        strToDate = HttpContext.Current.Request.QueryString("ToDate").ToString()
        EmployeePayrollId_PK = HttpContext.Current.Request.QueryString("EmployeePayrollId_PK").ToString()

        sbSQL.Append("usp_Validate_PayrollDates ")
        sbSQL.Append(strEmployeeID)
        sbSQL.Append(" , '")
        sbSQL.Append(strFromDate)
        sbSQL.Append("' , '")
        sbSQL.Append(strToDate)
        sbSQL.Append("',")
        If EmployeePayrollId_PK <> "" Then
            sbSQL.Append("'")
            sbSQL.Append(EmployeePayrollId_PK)
            sbSQL.Append("'")
        Else
            sbSQL.Append(" Null ")
        End If

        strResult = CommonFunction.Data.GetDataScalar(sbSQL.ToString(), MyBase.UseSQL)

        Response.Clear()
        Response.Write(strResult)
        Response.End()

        strResult = Nothing
        strEmployeeID = Nothing
        strFromDate = Nothing
        strToDate = Nothing
        EmployeePayrollId_PK = Nothing
        sbSQL = Nothing
    End Sub

    Public Function DrawSummaryProjectTabs(ByVal m_LoginType As String, ByVal m_customerid As String, ByVal m_EmployeeID As String, Optional ByRef FavPageNo As Integer = 1, Optional ByRef m_ProjectID As String = "") As String
        Dim sbFavTab As New StringBuilder("")

        Dim strPageName As String = ""
        Dim strToolTip As String = ""
        Dim strTagID As String = ""
        Dim strControlItemID As String = ""
        Dim strTagName As String = ""
        Dim PAGE_SIZE As Integer = 8
        Dim intStartRecord As Integer = 0
        Dim m_intPageNumber As Integer
        Dim m_intRowCount As Integer = 0
        Dim dblRatio As Double = 0.0
        Dim m_strProjectName As String = ""
        Dim m_strProjectID As String = ""
        Dim intCount As Integer = 1
        Dim strSql As String
        ' Dim strProjectList As String = ""

        If Not HttpContext.Current.Request.Form("PageNumber") Is Nothing Then
            m_intPageNumber = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("PageNumber"), "1")
        Else
            m_intPageNumber = FavPageNo
        End If


        intStartRecord = ((m_intPageNumber - 1) * PAGE_SIZE)

        Dim dsFAVTAB As DataSet
        If (m_LoginType.ToLower = "c") Then
            strSql = " usp_BrickRed_tbl_Pm_CustomerLoginProject " + m_customerid & "," & "NULL" & "," & m_EmployeeID
        Else
            strSql = " usp_BrickRed_tbl_Pm_CustomerLoginProject " + m_customerid & "," & "NULL" & "," & m_EmployeeID
        End If

        dsFAVTAB = CommonFunction.Data.GetDataSet(strSql, "FAVTAB", m_intRowCount, intStartRecord, PAGE_SIZE, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        With sbFavTab

            If m_intRowCount > 0 Then
                dblRatio = m_intRowCount / PAGE_SIZE

                If System.Math.Ceiling(dblRatio) < m_intPageNumber Then
                    m_intPageNumber = 1
                End If
                'Commented by ShraddhaM to remove Summary tab from Customer Portal
                '.Append("<a  class='' Title='Summary' onclick=""javascript:ShowSummary_ProjectSTab('Summary'," + CType(CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0"), String) + ",'0')"">Summary </a>")
                'End of commnet by ShraddhaM
                For Each drRow As DataRow In dsFAVTAB.Tables(0).Select("1=1", "ProjectName")
                    m_strProjectName = CType(CommonFunction.Data.CheckIsDBNull(drRow("ProjectName"), ""), String)
                    m_strProjectID = CType(CommonFunctions.Data.CheckIsDBNull(drRow("ProjectID"), ""), String)

                    If m_ProjectID = m_strProjectID Then
                        .Append("<a  class='selectedTab'  Title='" + m_strProjectName + "' onclick=""javascript:ShowSummary_ProjectSTab('Project'," + m_strProjectID + "," + intCount.ToString + "," + m_intPageNumber.ToString() + ")"">")
                    Else
                        .Append("<a  class=''  Title='" + m_strProjectName + "' onclick=""javascript:ShowSummary_ProjectSTab('Project'," + m_strProjectID + "," + intCount.ToString + "," + m_intPageNumber.ToString() + ")"">")
                    End If

                    If m_strProjectName.Length > 17 Then
                        m_strProjectName = m_strProjectName.Substring(0, 10) + ".."
                    End If

                    If m_ProjectID = m_strProjectID Then
                        .Append("<B>" + m_strProjectName.ToString + "</B></a>")
                    Else
                        .Append(m_strProjectName.ToString + "</a>")
                    End If

                    If (intCount = 1 And (m_ProjectID = "0" Or m_ProjectID = "")) Then
                        m_ProjectID = m_strProjectID
                    End If
                    intCount += 1


                    'strProjectList = strProjectList + m_strProjectID + ","
                Next
            End If
            .Append(CommonFunction.HTMLControls.DrawTextBox("txtFAVPageNumber", "txtFAVPageNumber", , 5, 4, m_intPageNumber.ToString, "right", , , , , True))
            .Append(CommonFunction.HTMLControls.DrawTextBox("txtNoOfFAV", "txtNoOfFAV", , 5, , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True))
            '.Append(CommonFunction.HTMLControls.DrawTextBox("txtProjectList", "txtProjectList", , 5, , strProjectList, , DisplayNone:=True))
        End With

        DrawSummaryProjectTabs = sbFavTab.ToString

        sbFavTab = Nothing
        dsFAVTAB = Nothing

    End Function

    Public Function DrawSummary_Project_IssueDetails(ByRef strTabName As String, ByRef strEmployeeID As String, ByRef strCustomerID As String, ByRef strProjectID As String, ByRef strSummaryIssueStatus As String, ByRef strSummaryIssueType As String, ByRef strLoginType As String, ByRef strIssueNextLastToday As String, ByRef strCurrWeekStartDate As String, ByRef strPrevWeekStartDate As String, ByRef strProjectIssueStatus As String, ByRef PageNumber As String, ByRef Maximize As Boolean, ByRef Period As String) As String
        Dim strSQL As String
        Dim drProject As IDataReader
        Dim drIssue As IDataReader
        Dim intProjectID As Integer
        Dim intCount As Integer = 0
        Dim blnFlag As Boolean = False
        Dim blnRecordFlag As Boolean = True
        Dim blnRecordFlagForProject As Boolean = False
        Dim sbFavTab As New StringBuilder("")
        Dim blnProject_RecordFlag As Boolean = True
        Dim blnIssueAvail As Boolean = False

        Dim intPageSize As Integer = 10

        If Maximize = True Then
            intPageSize = 20
        End If

        If (strTabName = "" Or strTabName.ToLower = "summary") Then 'When Form is called from  Summary Tab
            strSQL = "usp_BrickRed_tbl_Pm_CustomerLoginProject  " + strCustomerID & "," & "NULL" & "," & strEmployeeID
        Else 'When Form is called from  any Project Tab
            strSQL = "usp_BrickRed_tbl_Pm_CustomerLoginProject " + strCustomerID & "," & strProjectID & "," & strEmployeeID
        End If
        drProject = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        With sbFavTab

            Do While drProject.Read
                blnRecordFlagForProject = True
                strSQL = ""
                If (strTabName = "Summary") Then

                    If (strSummaryIssueStatus = "All" And strSummaryIssueType = "All") Then
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_Issue " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'All','All','Summary','" + strCurrWeekStartDate + "','" + strPrevWeekStartDate + "','" + strIssueNextLastToday + "','" + strLoginType + "'"
                    ElseIf (strSummaryIssueStatus <> "All" And strSummaryIssueType = "All") Then
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_Issue " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'All','" + strSummaryIssueStatus + "','Summary','" + strCurrWeekStartDate + "','" + strPrevWeekStartDate + "','" + strIssueNextLastToday + "','" + strLoginType + "'"
                    ElseIf (strSummaryIssueStatus = "All" And strSummaryIssueType <> "All") Then
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_Issue " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'" + strSummaryIssueType + "','All','Summary','" + strCurrWeekStartDate + "','" + strPrevWeekStartDate + "','" + strIssueNextLastToday + "','" + strLoginType + "'"
                    Else
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_Issue " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'" + strSummaryIssueType + "','" + strSummaryIssueStatus + "','Summary','" + strCurrWeekStartDate + "','" + strPrevWeekStartDate + "','" + strIssueNextLastToday + "','" + strLoginType + "'"
                    End If

                Else
                    If (strProjectIssueStatus = "All") Then
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_Issue " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'All',NULL,'Project',NULL,NULL,NULL,'" + strLoginType + "'," + Period + "," + PageNumber.ToString() + "," + intPageSize.ToString()
                    Else
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_Issue  " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'" + strProjectIssueStatus + "',NULL,'Project',NULL,NULL,NULL,'" + strLoginType + "'," + Period + "," + PageNumber.ToString() + "," + intPageSize.ToString()
                    End If
                End If

                drIssue = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                intCount = 0
                blnProject_RecordFlag = True
                Do While drIssue.Read
                    blnRecordFlag = False
                    blnIssueAvail = True
                    If blnProject_RecordFlag = True Then
                        .Append("<table class='project_container' cellSpacing='0' cellPadding='0' width='100%' border='0'>")
                        .Append("<tr class='clsTRSectionHeader'>")
                        .Append("<td>" + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectName"), "0"), String) + "</td>")
                        .Append("</tr>")
                        .Append("<tr>")
                        .Append("<td>")
                        .Append("<table cellSpacing='0' cellPadding='0' width='100%' border='0'>")
                        .Append("<tr class='clsTRPageCaption'>")
                        .Append("<td>ID</td>")
                        .Append("<td>Description</td>")
                        .Append("<td>Type</td>")
                        .Append("<td>Status</td>")
                        .Append("<td>Responsible Person</td>")
                        .Append("<td>Reported Date</td>")
                        .Append("</tr>")
                    End If

                    .Append("<tr>")
                    .Append("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drIssue("IssueID"), "&nbsp"), String) + " </td>") 'strRef &
                    .Append("<td class='table_content'>" + Server.HtmlEncode(CType(CommonFunctions.Data.CheckIsDBNull(drIssue("Summary"), "&nbsp"), String)) + "</td>")
                    .Append("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drIssue("Type"), "&nbsp"), String) + "</td>")
                    .Append("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drIssue("Status"), "&nbsp"), String) + "</td>")
                    .Append("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drIssue("AssignToName"), "-"), String) + "</td>")
                    .Append("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Dates.CGetDate(Date.Parse(drIssue("EndDate"))), "&nbsp"), String) + "</td>")
                    .Append("</tr>")

                    blnProject_RecordFlag = False
                Loop
                CommonFunction.Data.DisposeDataReader(drIssue)
                If blnRecordFlag = False Then
                    .Append("</table>")
                    .Append("</td>")
                    .Append("</tr>")
                    .Append("</table>")
                End If
                blnRecordFlag = True
            Loop
            If blnRecordFlagForProject = False Or blnIssueAvail = False Then
                .Append("<table cellSpacing='0' cellPadding='0' width='100%' border='0'>")
                .Append("<tr class='clsTRPageCaption'>")
                .Append("<td>ID</td>")
                .Append("<td>Description</td>")
                .Append("<td>Type</td>")
                .Append("<td>Status</td>")
                .Append("<td>Resource</td>")
                .Append("<td>End Date</td>")
                .Append("</tr>")
                .Append("<tr>")
                .Append("<td class='clsPortal' align='center' colspan=6>There are no items to show in this view.</td>")
                .Append("</tr>")
                .Append("</table>")
            End If
            drProject = Nothing
        End With

        DrawSummary_Project_IssueDetails = sbFavTab.ToString

        sbFavTab = Nothing

        CommonFunction.Data.DisposeDataReader(drProject)
    End Function

    Public Function DrawMileStonesDetails(ByRef strTabName As String, ByRef strEmployeeID As String, ByRef strCustomerID As String, ByRef strProjectID As String, ByRef strMilestones_Search As String) As String
        '=====================================================================
        ' Procedure Name        : DrawMileStonesDetails()	
        ' Purpose               : Plot the MileStones/ Deliverables Details on the page
        ' Description           : Same As Above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : May 29 , 2008
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim drProject As IDataReader
        Dim drMilestones As IDataReader
        Dim intProjectID As Integer
        Dim intCount As Integer = 0
        Dim blnFlag As Boolean = False
        Dim blnRecordFlag As Boolean = True
        Dim blnRecordProjectFlag As Boolean = False
        Dim blnProject_RecordFlag As Boolean = True
        Dim blnMilestoneAvail As Boolean = False
        If (strTabName = "" Or strTabName.ToLower = "summary") Then 'When Form is called from  Summary Tab
            strSQL = "usp_BrickRed_tbl_Pm_CustomerLoginProject  " + strCustomerID & "," & "NULL" & "," & strEmployeeID
        Else 'When Form is called from  any Project Tab
            strSQL = "usp_BrickRed_tbl_Pm_CustomerLoginProject " + strCustomerID & "," & strProjectID & "," & strEmployeeID
        End If

        drProject = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        Do While drProject.Read
            blnRecordProjectFlag = True
            strSQL = "exec Usp_BrickRed_DB_tbl_PM_Milestones " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "0"), String) + ",'" + strMilestones_Search + "'"
            drMilestones = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            intCount = 0
            blnProject_RecordFlag = True
            Do While drMilestones.Read
                blnRecordFlag = False
                blnMilestoneAvail = True
                If blnProject_RecordFlag = True Then
                    CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='project_container'>")
                    CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader'>")
                    CommonFunctions.General.WriteHTML("<td>" + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectName"), ""), String) + "</td>")
                    CommonFunctions.General.WriteHTML("</tr>")
                    CommonFunctions.General.WriteHTML("<tr>")
                    CommonFunctions.General.WriteHTML("<td>")
                    CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
                    CommonFunctions.General.WriteHTML("<tr class='clsTRPageCaption'>")
                    CommonFunctions.General.WriteHTML("<td>ID</td>")
                    CommonFunctions.General.WriteHTML("<td>Description</td>")
                    CommonFunctions.General.WriteHTML("<td>Start Date</td>")
                    CommonFunctions.General.WriteHTML("</tr>")
                End If
                CommonFunctions.General.WriteHTML("<tr>")
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drMilestones("MilestoneID"), "&nbsp"), String) + " </td>") '<a href='#'>
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + Server.HtmlEncode(CType(CommonFunctions.Data.CheckIsDBNull(drMilestones("Milestone"), "&nbsp"), String)) + "</td>")
                CommonFunctions.General.WriteHTML("<td  class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Dates.CGetDate(Date.Parse(drMilestones("StartDate"))), "&nbsp"), String) + " </td>")
                CommonFunctions.General.WriteHTML("</tr>")
                blnProject_RecordFlag = False
            Loop
            CommonFunction.Data.DisposeDataReader(drMilestones)

            If blnRecordFlag = False Then
                CommonFunctions.General.WriteHTML("</table>")
                CommonFunctions.General.WriteHTML("</td>")
                CommonFunctions.General.WriteHTML("</tr>")
                CommonFunctions.General.WriteHTML("</table>")
                blnRecordFlag = True
            End If
        Loop

        If blnRecordProjectFlag = False Or blnMilestoneAvail = False Then
            CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
            CommonFunctions.General.WriteHTML("<tr class='clsTRPageCaption'>")
            CommonFunctions.General.WriteHTML("<td>ID</td>")
            CommonFunctions.General.WriteHTML("<td>Description</td>")

            CommonFunctions.General.WriteHTML("<td>Start Date</td>")
            CommonFunctions.General.WriteHTML("<td>End Date</td>")

            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td class='clsPortal' align='center' colspan=4>There are no items to show in this view.</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("</table>")
        End If

        CommonFunction.Data.DisposeDataReader(drProject)
    End Function

    Public Function DrawDeliverablesDetails(ByRef strTabName As String, ByRef strEmployeeID As String, ByRef strCustomerID As String, ByRef strProjectID As String, ByRef strDeliverables_Search As String) As String

        '=====================================================================
        ' Procedure Name        : DrawDeliverablesDetails()	
        ' Purpose               : Plot the  Notification Details about projects on the page
        ' Description           : Same As Above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : May 29 , 2008
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim drProject As IDataReader
        Dim drDeliverables As IDataReader
        Dim intProjectID As Integer
        Dim intCount As Integer = 0
        Dim blnFlag As Boolean = False
        Dim blnRecordFlag As Boolean = True
        Dim blnRecordProjectFlag As Boolean = False
        Dim blnProject_RecordFlag As Boolean = True
        Dim blnDeliverableAvail As Boolean = False
        If (strTabName = "" Or strTabName.ToLower = "summary") Then 'When Form is called from  Summary Tab
            strSQL = "usp_BrickRed_tbl_Pm_CustomerLoginProject  " + strCustomerID & "," & "NULL" & "," & strEmployeeID
        Else 'When Form is called from  any Project Tab
            strSQL = "usp_BrickRed_tbl_Pm_CustomerLoginProject " + strCustomerID & "," & strProjectID & "," & strEmployeeID
        End If
        drProject = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        Do While drProject.Read

            strSQL = "exec Usp_BrickRed_DB_tbl_PM_OtherSchedules " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "0"), String) + " ,'" + strDeliverables_Search + "'"
            drDeliverables = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            blnRecordProjectFlag = True
            blnProject_RecordFlag = True
            Do While drDeliverables.Read
                blnRecordFlag = False
                blnDeliverableAvail = True
                If blnProject_RecordFlag = True Then
                    CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='project_container'>")
                    CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader'>")
                    CommonFunctions.General.WriteHTML("<td>" + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectName"), ""), String) + "</td>")
                    CommonFunctions.General.WriteHTML("</tr>")
                    CommonFunctions.General.WriteHTML("<tr>")
                    CommonFunctions.General.WriteHTML("<td>")
                    CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
                    CommonFunctions.General.WriteHTML("<tr class='clsTRPageCaption'>")
                    CommonFunctions.General.WriteHTML("<td>ID</td>")
                    CommonFunctions.General.WriteHTML("<td>Description</td>")
                    CommonFunctions.General.WriteHTML("<td>Start Date</td>")
                    CommonFunctions.General.WriteHTML("</tr>")
                End If
                CommonFunctions.General.WriteHTML("<tr>")
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drDeliverables("DeliverableId"), "&nbsp"), String) + " </td>")
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + Server.HtmlEncode(CType(CommonFunctions.Data.CheckIsDBNull(drDeliverables("Deliverable"), "&nbsp"), String)) + "</td>")
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Dates.CGetDate(Date.Parse(drDeliverables("StartDate"))), "&nbsp"), String) + " </td>")
                CommonFunctions.General.WriteHTML("</tr>")
                blnProject_RecordFlag = False

            Loop

            CommonFunction.Data.DisposeDataReader(drDeliverables)
            If blnRecordFlag = False Then
                CommonFunctions.General.WriteHTML("</table>")
                CommonFunctions.General.WriteHTML("</td>")
                CommonFunctions.General.WriteHTML("</tr>")
                CommonFunctions.General.WriteHTML("</table>")
                blnRecordFlag = True
            End If
        Loop
        If blnRecordProjectFlag = False Or blnDeliverableAvail = False Then
            CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
            CommonFunctions.General.WriteHTML("<tr class='clsTRPageCaption'>")
            CommonFunctions.General.WriteHTML("<td>ID</td>")
            CommonFunctions.General.WriteHTML("<td>Description</td>")
            CommonFunctions.General.WriteHTML("<td>Start Date</td>")
            CommonFunctions.General.WriteHTML("<td>End Date</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td class='clsPortal' align='center' colspan=4>There are no items to show in this view.</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("</table>")
        End If

        CommonFunction.Data.DisposeDataReader(drProject)
    End Function

    Public Function DrawGridTasks(ByRef strTabName As String, ByRef strCallFrom As String, ByRef strEmployeeID As String, ByRef strCustomerID As String, ByRef strProjectID As String, ByRef strLoginType As String, ByRef strProjectTaskStatus As String, ByRef strCurrWeekStartDateTask As String, ByRef strTaskNextLastTodayTask As String, ByRef strSummaryTaskStatus As String, ByRef PageNumber As String, ByRef Maximize As Boolean, ByRef Period As String) As String
        '=====================================================================
        ' Procedure Name        : DrawGridTasks()	
        ' Purpose               : Plot the  grid for Tasks of projects on the page
        ' Description           : Same As Above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : May 29 , 2009
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim drProject As IDataReader
        Dim drTask As IDataReader
        Dim intProjectID As Integer
        Dim blnRecordFlagForProject As Boolean = False
        Dim dt_strendDate As String = ""
        Dim blnRecordFlag As Boolean = True
        Dim blnRecordProjectFlag As Boolean = False
        Dim blnProject_RecordFlag As Boolean = True
        Dim blnDeliverableAvail As Boolean = False

        Dim intCurrentIndex As Integer
        Dim strHTML As New System.Text.StringBuilder
        Dim intPageSize As Integer = 10

        If Maximize = True Then
            intPageSize = 20
        End If

        If (strTabName = "" Or strTabName.ToLower = "summary") Then 'When Form is called from  Summary Tab
            strSQL = "usp_BrickRed_tbl_Pm_CustomerLoginProject  " + strCustomerID + "," + "NULL" & "," & strEmployeeID
        Else 'When Form is called from  any Project Tab
            strSQL = "usp_BrickRed_tbl_Pm_CustomerLoginProject " + strCustomerID & "," & strProjectID & "," & strEmployeeID
        End If
        drProject = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        Do While drProject.Read
            blnRecordProjectFlag = True
            strSQL = ""
            'Modified By VijayD On 29 August 2008
            If (strLoginType = "C") Then
                If (strCallFrom = "Summary") Then

                    If (strSummaryTaskStatus = "All") Then
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_ProjectTasks_Customer " + strEmployeeID + ",'" + strLoginType + "'," + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'All','Summary','" + strCurrWeekStartDateTask + "','" + strTaskNextLastTodayTask + "'"
                    Else
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_ProjectTasks_Customer  " + strEmployeeID + ",'" + strLoginType + "'," + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'" + strSummaryTaskStatus + "','Summary','" + strCurrWeekStartDateTask + "','" + strTaskNextLastTodayTask + "'"
                    End If
                Else
                    If (strProjectTaskStatus = "All") Then
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_ProjectTasks_Customer " + strEmployeeID + ",'" + strLoginType + "'," + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'All','Project'"
                    Else
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_ProjectTasks_Customer  " + strEmployeeID + ",'" + strLoginType + "'," + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'" + strProjectTaskStatus + "','Project'"
                    End If
                End If

                'Added By VijayD
            Else
                If (strCallFrom = "Summary") Then

                    If (strSummaryTaskStatus = "All") Then
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_ProjectTasks_Employee " + strEmployeeID + ",'" + strLoginType + "'," + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'All','Summary','" + strCurrWeekStartDateTask + "','" + strTaskNextLastTodayTask + "'"
                    Else
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_ProjectTasks_Employee  " + strEmployeeID + ",'" + strLoginType + "'," + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'" + strSummaryTaskStatus + "','Summary','" + strCurrWeekStartDateTask + "','" + strTaskNextLastTodayTask + "'"
                    End If
                Else
                    If (strProjectTaskStatus = "All") Then
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_ProjectTasks_Employee " + strEmployeeID + ",'" + strLoginType + "'," + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'All','Project',NULL,NULL,NULL," + Period + "," + PageNumber.ToString() + "," + intPageSize.ToString()
                    Else
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_ProjectTasks_Employee  " + strEmployeeID + ",'" + strLoginType + "'," + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'" + strProjectTaskStatus + "','Project',NULL,NULL,NULL," + Period + "," + PageNumber.ToString() + "," + intPageSize.ToString()
                    End If
                End If
            End If
            drTask = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

            'strHTML.Append("<input type=hidden id='txtCurrentPage_Task' name='txtCurrentPage_Task' value='" + intTaskCurrentPageNo.ToString() + "'>")
            'strHTML.Append("<input type=hidden id='txtNoOfPages_Task' name='txtNoOfPages_Task' value='" + intTaskTotalPageNo.ToString() + "'>")


            blnProject_RecordFlag = True
            Do While drTask.Read
                blnRecordFlag = False
                blnDeliverableAvail = True
                If blnProject_RecordFlag = True Then
                    CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='project_container'>")
                    CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader'>")
                    CommonFunctions.General.WriteHTML("<td>" + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectName"), ""), String) + "</td>")
                    CommonFunctions.General.WriteHTML("</tr>")
                    CommonFunctions.General.WriteHTML("<tr>")
                    CommonFunctions.General.WriteHTML("<td>")
                    CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
                    CommonFunctions.General.WriteHTML("<tr class='clsTRPageCaption'>")
                    CommonFunctions.General.WriteHTML("<td>Description</td>")
                    CommonFunctions.General.WriteHTML("<td>Resource</td>")
                    CommonFunctions.General.WriteHTML("<td>Start Date</td>")
                    CommonFunctions.General.WriteHTML("<td>End Date </td>")
                    CommonFunctions.General.WriteHTML("<td>Status</td>")
                    CommonFunctions.General.WriteHTML("</tr>")
                End If
                CommonFunctions.General.WriteHTML("<tr>")
                CommonFunctions.General.WriteHTML("<td class='table_content' width='50%'>" + Server.HtmlEncode(CType(CommonFunctions.Data.CheckIsDBNull(drTask("Description"), "&nbsp"), String)) + " </td>") '+ strRef + 
                CommonFunctions.General.WriteHTML("<td class='table_content' width='20%'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTask("Resource"), "&nbsp"), String) + "</td>")
                CommonFunctions.General.WriteHTML("<td class='table_content' width='12%'>" + CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Dates.CGetDate(Date.Parse(drTask("startdate"))), "&nbsp"), String) + "</td>")
                CommonFunctions.General.WriteHTML("<td class='table_content' width='12%'>" + CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Dates.CGetDate(Date.Parse(drTask("Enddate"))), "&nbsp"), String) + "</td>")
                CommonFunctions.General.WriteHTML("<td class='table_content' width='5%'>")
                If (CType(CommonFunctions.Data.CheckIsDBNull(drTask("status"), ""), String) = "Not Started") Then
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/flag_Yellow.gif' alt='' width='10' height='10' title='In Progress'></IMG>")
                ElseIf (CType(CommonFunctions.Data.CheckIsDBNull(drTask("status"), ""), String) = "Need Attention") Then
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/flag_Red.gif'  alt='' width='10' height='10' title='Critical, Started Late, Finished Late'></IMG>")
                ElseIf (CType(CommonFunctions.Data.CheckIsDBNull(drTask("status"), ""), String) = "In Progress") Then
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/flag_Green.gif'  alt='' width='10' height='10' title='Assigned ,Not Yet Started''></IMG>")

                ElseIf (CType(CommonFunctions.Data.CheckIsDBNull(drTask("status"), ""), String) = "Future Dated Tasks") Then
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/GrayFlag.gif'  alt='' width='15' height='15' title='Assigned ,Future Dated Tasks''></IMG>")
                End If
                CommonFunctions.General.WriteHTML("</td></tr>")

                blnProject_RecordFlag = False
            Loop
            CommonFunction.Data.DisposeDataReader(drTask)
            If blnRecordFlag = False Then
                CommonFunctions.General.WriteHTML("</table>")
                CommonFunctions.General.WriteHTML("</td>")
                CommonFunctions.General.WriteHTML("</tr>")
                CommonFunctions.General.WriteHTML("</table>")
                blnRecordFlag = True
            End If
        Loop
        If blnRecordProjectFlag = False Or blnDeliverableAvail = False Then
            CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
            CommonFunctions.General.WriteHTML("<tr class='clsTRPageCaption'>")
            CommonFunctions.General.WriteHTML("<td>Description</td>")
            CommonFunctions.General.WriteHTML("<td>Resource</td>")
            CommonFunctions.General.WriteHTML("<td>End Date </td>")
            CommonFunctions.General.WriteHTML("<td>Status</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td class='clsPortal' align='center' colspan=4>There are no items to show in this view.</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("</table>")
        End If

        CommonFunction.Data.DisposeDataReader(drProject)
    End Function
    'Integrated by SanaS on 25-Sep-2009 for Resource Allocation Changes
    'Added by GaneshG 22-Aug-2009
    Private Function GetRole() As String
        '=====================================================================
        ' Procedure Name		:	GetRole
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To set the loggied users role
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AshishR
        ' Created				:	22 Apr 2002
        ' Revisions				:	22 APr 2002
        '=====================================================================

        Dim drRoleName As IDataReader
        Dim strSQL As String

        strSQL = "Select RoleDescription FROM tbl_PM_Role WHERE RoleID=(SELECT TOP 1 Role FROM tbl_PM_ProjectEmployeeRole WHERE ProjectID=" & CType(Session("intProjectID"), Long)
        strSQL = strSQL & " AND EmployeeID=" & CType(Session("intUserID"), Long) & ")"

        drRoleName = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drRoleName.Read Then
            GetRole = CType(drRoleName("RoleDescription"), String) & ""
        End If
        ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

        'drRoleName.Close()
        CommonFunction.Data.DisposeDataReader(drRoleName)

        ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

    End Function
    'End addition by GaneshG 22-Aug-2009
    'End Integration by SanaS on 25-Sep-2009 for Resource Allocation Changes
    <System.Web.Services.WebMethod()>
    Public Shared Function GetUniqueIdentifier(ByVal UserName As String)
        '=====================================================================
        ' Procedure Name		:	GetUniqueIdentifier
        ' Parameters Passed		:	UserName
        ' Returns				:	Encrypted Uniuqe ID
        ' Parameters Affected	:	None
        ' Purpose				:	To get Unique Identifier
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vaijat K
        ' Created				:	19/04/2017
        ' Revisions				:	
        '=====================================================================

        Try
            Dim strUserName As String
            Dim strUniuqeID As String
            Dim strSQL As String
            Dim strResult As String
            Dim strEncryptedUniuqeID As String

            strUserName = CommonFunctions.General.CheckIsNothing(UserName, "").ToString()
            strUniuqeID = Guid.NewGuid().ToString
            strEncryptedUniuqeID = Token.GetUserNameToken(strUniuqeID)

            strResult = strEncryptedUniuqeID

            If m_LoginHashTable.ContainsKey(strUserName) Then
                m_LoginHashTable.Remove(strUserName)
            End If
            m_LoginHashTable.Add(strUserName, strUniuqeID)

            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try

    End Function
End Class
