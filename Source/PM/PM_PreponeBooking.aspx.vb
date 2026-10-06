#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class PM_PreponeBooking
    Inherits WebPages.Template.WhizTemplate

    '=====================================================================
    ' Project Name          :   PBNIT Enterprise
    ' Module Name           :   Resource Allocation Details
    ' Page Name 	        :   PM_ExtendBooking	

    ' Purpose				:	To add, assigen or reject extend booking for an employee
    ' Description			:	To add, assigen or reject extend booking for an employee
    ' Assumptions			:	Employee preveously working on this project
    ' Dependencies			:	
    ' Author				:	NileshD
    ' Created				:	April 15, 2004
    ' Revisions				:	
    '=====================================================================

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region "Member Variables"
    Private WithEvents m_objMenu As New StaticMenu      'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New GenericGrid     'This variable is use to plotting grid.
    Private m_objGlobal As IGlobal                      'This variable is of global object inteface. 
    Private m_objAccessRights As cAccessRights          'This variable is for access rights of page.
    Private strMenu As String                           'stores the static menu string.
    Protected m_intProjectEmployeeRoleId As Integer
    Protected m_strRequestedEndDate As String
    Protected m_strpercentage As String = ""
    Protected m_strRequestedStartDate As String
    Protected m_strRequestDate As String
    Protected m_strHours As String = ""
    Protected m_intPriority As Integer
    Protected m_intResourcePool As Integer
    Protected m_strSpecialRequest As String
    Protected m_intRequestID As Integer
    Protected m_strMode As String
    Protected m_strScript As String
    Protected m_intEmployeeID As Integer
    Protected m_strStatus As String = "-1"
    Protected m_strOldAllocation As Double
    Protected m_StdAllocationPercentage As Long
    Protected m_IsProjectResourceAllocation As Boolean
    Protected m_strAction As String
    Protected strType As String
    Protected WithEvents frmPM_PreponeBooking As System.Web.UI.HtmlControls.HtmlForm
    Private m_RequestType As String
    Private strStartDate As String
    Private strEndDate As String
    Private strEmployeeName As String
    Private intEmployeeid As Integer
    Private lngHours As Double
    Private lngRegHours As Double
    Private strProjectID As String = "0"
    Private drProjectEmployee As IDataReader
    Private drProjectEmployeeRole As IDataReader
    Private cnt As Integer
    Private intResourcepoolID As Integer
    Protected intRequestID As Integer
    Private intRoleID As Integer
    Private m_flResourcePercentage As Double
    Private m_strRequestType As String
    Private mstrhrsperday As String
    Private mstrPercentageperday As String
    Private mstrtotal As String
    Private mstrApprovedhrsperday As String
    Private mstrApprovedPercentageperday As String
    Private mstrApprovedtotal As String
    Private m_strNewAllocation As Double
    Private noofdays As Long
    Private strSQL As String
    Private m_dblFreeHours As Double
    Private m_dblFreeMinWorkperday As Double = 0
    Private m_dblFreeMinWorkpercentage As Double = 0
    Private m_dblNewallocation As Double = 0
    'Added by SanaS on 14-Aug-2009
    Private sqlqryType As String
    'End Addition by SanaS on 14-Aug-2009


    Private Enum MenuIndex
        SAVE
        REJECTREQUEST
        ASSIGN
        CANCEL
        CLOSE
        HELP
    End Enum
    Protected m_lngTagId As Long = 0

#End Region

#Region "Functions & Procedures"
    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        : GetGlobalObject
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Get the global object and assign it to variable
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_lngTagId = m_objGlobal.TagID
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
    End Sub

    Private Sub DrawMenu()
        '====================================================================
        ' Procedure Name        : DrawMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the menu
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrMenu(5) As String

        Dim arrMenuToolTip(5) As String

        Dim arrClientSideFunction(5) As String


        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        arrMenu(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE")
        arrMenuToolTip(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE_TOOLTIP")
        arrClientSideFunction(MenuIndex.SAVE) = "Save_OnClick()"

        arrMenu(MenuIndex.ASSIGN) = MyBase.GetResourceString("MENU_ALLOCATE_RESOURCE")
        arrMenuToolTip(MenuIndex.ASSIGN) = MyBase.GetResourceString("MENU_ALLOCATE_RESOURCE_TOOLTIP")
        arrClientSideFunction(MenuIndex.ASSIGN) = "Assign_OnClick()"

        arrMenu(MenuIndex.REJECTREQUEST) = MyBase.GetResourceString("MENU_DECLINE_REQUEST")
        arrMenuToolTip(MenuIndex.REJECTREQUEST) = MyBase.GetResourceString("MENU_DECLINE_REQUEST_TOOLTIP")
        arrClientSideFunction(MenuIndex.REJECTREQUEST) = "RejectRequest_OnClick()"
        arrMenu(MenuIndex.CANCEL) = MyBase.GetResourceString("MENU_CANCEL")
        arrMenuToolTip(MenuIndex.CANCEL) = MyBase.GetResourceString("MENU_CANCEL_TOOLTIP")
        arrClientSideFunction(MenuIndex.CANCEL) = "Cancel_OnClick()"

        arrMenu(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        arrMenuToolTip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        arrClientSideFunction(MenuIndex.CLOSE) = "Close_OnClick()"

        arrMenu(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        arrMenuToolTip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        arrClientSideFunction(MenuIndex.HELP) = "Help_OnClick('PM_EXTENDBOOKING')"


        Dim strGrid As String

        'cerate the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True)

        MyBase.InitializeResources("AppResources.PM_PreponeBooking", "AppResources")

    End Sub

    Private Sub DrawPageCaption()
        '====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page caption thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================

        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_TITLE"), , , True))
        Response.Write("<BR>")
    End Sub

    Private Sub DrawHeader()
        '====================================================================
        ' Procedure Name        : DrawHeader
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page Header thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================
        Dim objHeader As HeaderFooter
        Dim strReturn As String
        objHeader = New HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        strReturn = objHeader.DrawHeaderFooter(m_objGlobal, True)
        If strReturn <> "" Then
            Response.Write(strReturn)
        End If
        objHeader = Nothing

    End Sub

    Private Sub DisposeObjects()
        '====================================================================
        ' Procedure Name        : DisposeObjects
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Dispose all the objects
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================
        m_objMenu = Nothing
        m_objGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing

    End Sub

    Private Sub WritePageLegend()
        '====================================================================
        ' Procedure Name        : WritePageLegend
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the page legend
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrLegends(0) As String
        Dim arrLegendImg(0) As String
        arrLegends(0) = "&nbsp;" & MyBase.GetResourceString("MANDATORY")
        arrLegendImg(0) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        CommonFunctions.General.WriteHTML(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends, True))
    End Sub
    Private Sub InitializeData()
        '====================================================================
        ' Procedure Name        : SaveData
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To Initialize variables 
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SanaS
        ' Created               : 01-Sep-2009
        '=====================================================================

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''m_StdAllocationPercentage = CType(CommonFunctions.Data.GetDataScalar("SELECT IsNull(SettingValue,100) FROM tbl_sem_settings WHERE SettingName='RESOURCE_ALLOCATION'", MyBase.UseSQL), Long)
        m_StdAllocationPercentage = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_sem_settings_SettingValue", MyBase.UseSQL), Long)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        'this code will get execute when form will open in Save mode

        intRequestID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RequestID"), "0"), Integer)
        If intRequestID = 0 Then
            strProjectID = m_objGlobal.ProjectID.ToString
        Else
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strProjectID = CType(CommonFunction.Data.GetDataScalar("Select ProjectID FROM TBL_PM_ResourceRequest Where RequestID=" + m_intRequestID.ToString, MyBase.UseSQL), String)
            strProjectID = CType(CommonFunction.Data.GetDataScalar("usp_sel_TBL_PM_ResourceRequest_ProjectID " + m_intRequestID.ToString, MyBase.UseSQL), String)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        End If
        m_IsProjectResourceAllocation = CType(CommonFunctions.Data.GetDataScalar("usp_Sel_IsProjectResourceAllocation " + m_objGlobal.ProjectID.ToString, MyBase.UseSQL), Boolean)

        m_intProjectEmployeeRoleId = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectEmployeeRoleID"), "0"), Integer)
        If m_IsProjectResourceAllocation Then
            strType = "P"
        End If
        drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_sel_ApproveorRejectRequest_tbl_PM_ResourceRequest " + m_objGlobal.ProjectID.ToString + "," + m_intProjectEmployeeRoleId.ToString, MyBase.UseSQL)

        If drProjectEmployeeRole.Read Then
            intRequestID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(drProjectEmployeeRole("RequestID"), "0"), "0"), Integer)
        End If
        CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)



        If m_intProjectEmployeeRoleId <> 0 Then
            drProjectEmployee = CommonFunction.Data.GetDataReader("usp_Sel_ProjectEmployeeRole_Prepone " + m_intProjectEmployeeRoleId.ToString + "," + m_objGlobal.ProjectID.ToString, MyBase.UseSQL)
            If drProjectEmployee.Read Then
                strStartDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("ExpectedStartDate"), ""), Date))
                strEndDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("ExpectedEndDate"), ""), Date))
                lngHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("BudgetedHours"), "0"), Double)
                strEmployeeName = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("EmployeeName"), "0"), String)
                m_intEmployeeID = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("EmployeeID"), "0"), Integer)
                'm_flResourcePercentage = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("ResourcePercentage"), "0"), Integer)
                strType = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("RequestType"), "0"), String)
                If strType = "HPD" Then
                    lngRegHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("WorkHours"), "0"), Double)
                    mstrApprovedhrsperday = lngRegHours

                ElseIf strType = "TH" Then
                    lngRegHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("TotalRequestedHrs"), "0"), Double)
                    mstrApprovedtotal = lngRegHours

                ElseIf strType = "P" Then
                    lngRegHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("PercentageAllocation"), "0"), Double)
                    mstrApprovedPercentageperday = lngRegHours

                End If
                'intRoleID = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("Role"), "0"), Integer)

                m_strStatus = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("Status"), "-1"), String)
                If m_strStatus = "A" Then
                    m_strRequestedStartDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("FromDate"), ""), Date))
                    m_strRequestedEndDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("ToDate"), ""), Date))
                    lngHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("TotalRequestedHrs"), "0"), Double)
                End If
            End If
            CommonFunction.Data.DisposeDataReader(drProjectEmployee)

            drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_sel_resourcepool_tbl_pm_resourcerequest  " + m_objGlobal.ProjectID.ToString() + "," + m_intEmployeeID.ToString, MyBase.UseSQL)
            If drProjectEmployeeRole.Read Then
                intResourcepoolID = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("Resourcepoolid"), "0"), Integer)
                intRoleID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(drProjectEmployeeRole("RoleID"), "0"), "0"), Integer)
            End If

            CommonFunction.Data.DisposeDataReader(drProjectEmployee)
            If intRequestID <> 0 Then
                'drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ResourceRequest_ExtensionBooking NULL," + intRequestID.ToString, MyBase.UseSQL)
                drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ResourceRequest_PreponeType NULL," + intRequestID.ToString, MyBase.UseSQL)

            Else
                '  drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ResourceRequest_ExtensionBooking " + m_intProjectEmployeeRoleId.ToString, MyBase.UseSQL)
                drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ResourceRequest_PreponeType " + m_intProjectEmployeeRoleId.ToString, MyBase.UseSQL)

            End If
            If m_strStatus <> "A" Then
                If drProjectEmployeeRole.Read Then

                    ' If intRequestID = 0 Then
                    '     m_strRequestedStartDate = CommonFunction.Dates.GetDate(CType(drProjectEmployeeRole("FROMDate"), Date))

                    ' Else
                    '     m_strRequestedStartDate = CommonFunction.Dates.GetDate(CType(drProjectEmployeeRole("FROMDate"), Date))
                    ' End If
                    m_strRequestedStartDate = CommonFunction.Dates.GetDate(CType(drProjectEmployeeRole("FROMDate"), Date))
                    m_strRequestedEndDate = CommonFunction.Dates.GetDate(CType(drProjectEmployeeRole("ToDate"), Date))
                    m_strSpecialRequest = CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("SpecialRequest"), "").ToString
                    m_strHours = drProjectEmployeeRole("TotalRequestedHrs").ToString
                    m_intPriority = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("Priority"), "0"), Integer)
                    m_intRequestID = CType(drProjectEmployeeRole("RequestID"), Integer)
                    'intRoleID = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("RoleID"), "0"), Integer)
                    strType = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("Type"), ""), String)
                    If strType = "P" Then
                        mstrPercentageperday = drProjectEmployeeRole("PercentageAllocation").ToString
                    ElseIf strType = "HPD" Then
                        mstrhrsperday = drProjectEmployeeRole("WorkHours").ToString
                    ElseIf strType = "TH" Then
                        mstrtotal = drProjectEmployeeRole("TotalRequestedHrs").ToString
                    End If
                Else
                    noofdays = DateDiff("d", CommonFunctions.Dates.GetDate(Now.Date), strStartDate)
                    If CommonFunctions.General.CheckIsNothing(strStartDate, "") <> "" Then
                        m_strRequestedStartDate = CommonFunction.Dates.GetDate(CType(strStartDate, Date))
                    Else
                        m_strRequestedStartDate = ""
                    End If
                End If

                CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)
                ' 'Added by SanaS on 14-Aug-2009
                ' sqlqryType = "usp_get_allocationType_for_AssignedResource " + m_intProjectEmployeeRoleId.ToString

                ' strType = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(sqlqryType, MyBase.UseSQL), ""), String)
                '  'End addition by  SanaS on 14-Aug-2009

            Else
                If drProjectEmployeeRole.Read Then
                    m_RequestType = CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("RequestType"), "").ToString
                End If
                CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)
            End If
        End If
        'this code will get execute when form will open in Assigned mode
        'get the request details
        m_intRequestID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RequestID"), "0"), Integer)
        If m_intRequestID <> 0 Then
            drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ResourceRequest_ExtensionBooking NULL," + m_intRequestID.ToString, MyBase.UseSQL)
            If drProjectEmployeeRole.Read Then
                m_strRequestedStartDate = CommonFunction.Dates.GetDate(CType(drProjectEmployeeRole("FROMDate"), Date))
                m_strRequestedEndDate = CommonFunction.Dates.GetDate(CType(drProjectEmployeeRole("ToDate"), Date))
                m_strSpecialRequest = CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("SpecialRequest"), "").ToString
                m_strHours = drProjectEmployeeRole("WorkHours").ToString
                m_intPriority = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("Priority"), "0"), Integer)
                m_intRequestID = CType(drProjectEmployeeRole("RequestID"), Integer)
                strStartDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("ExpectedStartDate"), ""), Date))
                strEndDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("ExpectedEndDate"), ""), Date))
                m_strRequestDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("RequestDate"), ""), Date))
                m_intProjectEmployeeRoleId = CType(drProjectEmployeeRole("ProjectEmployeeRoleId"), Integer)
                m_strStatus = CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("Status"), "").ToString
                m_intEmployeeID = CType(drProjectEmployeeRole("EmployeeID"), Integer)
                lngHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("BudgetedHours"), "0"), Double)
                strEmployeeName = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("EmployeeName"), "0"), String)
                strProjectID = CType(drProjectEmployeeRole("ProjectID"), String)
                intResourcepoolID = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("ResourcePoolID"), "0"), Integer)
                intRoleID = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("RoleID"), "0"), Integer)
                'Added By SanaS on 14-Aug-2009
                strType = CType(drProjectEmployeeRole("Type"), String)
                m_flResourcePercentage = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("ResourcePercentage"), "0"), Integer)

            End If

            CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)
        End If

    End Sub
    Private Sub CancelRequest()
        m_intRequestID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RequestID"), "0"), Integer)
        strSQL = "usp_Cancel_Resourcerequest " + m_intRequestID.ToString

        CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        m_strScript = "window.close();" + vbCrLf
        m_strScript &= "window.opener.location=window.opener.location;" + vbCrLf




    End Sub
    Private Sub SaveData()
        '====================================================================
        ' Procedure Name        : SaveData
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To save data when mode is Save or AssignSave
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SanaS
        ' Created               : 01-Sep-2009
        '=====================================================================
        'For save option

        If m_strMode = "SAVE" Then

            Dim flag As Integer
            Dim m_strerr As String
            Dim m_PreponeHours As Double = 0
            Dim ActualHours As Double = 0
            Dim Hours As Double = 0
            Dim WorkingDays As Double
            Dim m_extrahrsRequired As Double
            Dim mNewRequestID As Long
            m_strRequestedStartDate = MyBase.GetFormValue("txtReqStart")
            m_strRequestedEndDate = MyBase.GetFormValue("txtReqEndDate")
            m_strHours = MyBase.GetFormValue("txtHours")
            m_strSpecialRequest = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtRequest"), "")
            m_strNewAllocation = CType(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtNewAllocation"), "0"), Double)
            m_strOldAllocation = CType(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtPrevAllocation"), "0"), Double)

            drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_sel_ProponeRelease_Workhours '" + strStartDate + "','" + m_strRequestedEndDate + "'" + "," + m_intEmployeeID.ToString + "," + CType(HttpContext.Current.Session("intProjectID"), String) + "," + lngHours.ToString + ",'" + strEndDate.ToString + "'", MyBase.UseSQL)
            If drProjectEmployeeRole.Read Then
                m_PreponeHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("WorkHours"), "0"), Double)
                ActualHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("ActualHours"), "0"), Double)
                WorkingDays = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("WorkingDays"), "0"), Double)
            End If

            Hours = CType(lngHours, Double) - CType(m_strHours, Double)

            CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)

            If m_strNewAllocation > m_strOldAllocation Then

                drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_sel_FreeHours_PreponeBooking '" + m_strRequestedStartDate + "','" + m_strRequestedEndDate + "'" + "," + m_intEmployeeID.ToString + "," + CType(HttpContext.Current.Session("intProjectID"), String), MyBase.UseSQL)
                If drProjectEmployeeRole.Read Then
                    m_dblFreeHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("FreeHours"), "0"), Double)
                    m_dblFreeMinWorkperday = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("MinimumPerDay"), "0"), Double)
                    m_dblFreeMinWorkpercentage = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("MinimumPercentage"), "0"), Double)
                End If

                CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)

                strSQL = "usp_sel_get_ExtrahrsRequired_Prepone '" + m_strRequestedStartDate + "','"
                strSQL = strSQL + m_strRequestedEndDate + "'," + m_strOldAllocation.ToString + ","
                strSQL = strSQL + m_strNewAllocation.ToString + ",'" + strType + "'," + m_intEmployeeID.ToString + "," + CType(HttpContext.Current.Session("intProjectID"), String)
                drProjectEmployeeRole = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
                If drProjectEmployeeRole.Read Then
                    m_extrahrsRequired = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("ExtraHours"), "0"), Double)
                End If

                CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)

                If m_extrahrsRequired > m_dblFreeHours Then
                    flag = 1
                    flag = 1
                    m_strerr = "You can not Prepone release this resource with Extra Hrs requirement as Resource is not free"
                    'Response.Write("<script language=javascript>")
                    'Response.Write("alert('You can not Prepone release this resource with Extra Hrs requirement as Resource is not free');" + vbCrLf)
                    'Response.Write("</script>")
                End If
                If strType = "P" Then
                    If m_strNewAllocation > m_dblFreeMinWorkpercentage Then
                        flag = 1
                        ' m_strerr = m_strerr + "\nResource minimum available percentage ( " + m_dblFreeMinWorkpercentage.ToString + "%) is less than the requested."
                        m_strerr = m_strerr + "\nResource available percentage ( " + m_dblFreeMinWorkpercentage.ToString + "%) is less than the requested."

                    End If
                ElseIf strType = "HPD" Then
                    If m_strNewAllocation > m_dblFreeMinWorkperday Then
                        flag = 1
                        m_strerr = m_strerr + "\n\nResource available free work hours per day (" + m_dblFreeMinWorkperday.ToString + ") are less than the requested. "
                    End If
                End If
            End If
            If flag = 1 Then
                Response.Write("<script language=javascript>")
                Response.Write("alert('" + m_strerr + "');" + vbCrLf)
                Response.Write("</script>")
            End If
            'If CType(m_strHours, Double) >= CType(lngHours, Double) Then
            '    flag = 1
            '    Response.Write("<script language=javascript>")
            '    Response.Write("alert('You can not Prepone release this resource as Planned Work hours should be greater than 0');" + vbCrLf)
            '    Response.Write("</script>")
            'End If
            If WorkingDays = 0 Then
                flag = 1
                Response.Write("<script language=javascript>")
                Response.Write("alert('You can not Prepone release this resource as Working Days are 0');" + vbCrLf)
                Response.Write("</script>")
            End If
            'If m_PreponeHours <> 0 Then
            '    If Hours > m_PreponeHours Then
            '        flag = 1
            '        Response.Write("<script language=javascript>")
            '        Response.Write("alert('You can not Prepone release this resource');" + vbCrLf)
            '        Response.Write("</script>")
            '    End If
            'End If
            If ActualHours <> 0 Then
                If Hours <= ActualHours Then
                    flag = 1
                    Response.Write("<script language=javascript>")
                    Response.Write("alert('You can not Prepone release this resource! Resource has daily activity entered greater than New Total Hours ');" + vbCrLf)
                    Response.Write("</script>")
                End If
            End If

            If flag <> 1 Then
                If intRequestID <> 0 Then
                    strSQL = "usp_Ins_tbl_PM_PreponeResourceRequest " + intRequestID.ToString + "," + m_objGlobal.ProjectID.ToString + ",'"
                    strSQL += m_strRequestedStartDate + "','" + m_strRequestedEndDate + "',NULL,1," + m_strHours
                    'If m_strSpecialRequest = "" Then
                    '    strSQL += ",'" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtRequest"), "0").ToString) + "'"
                    'Else
                    strSQL += ",'" + CommonFunction.General.BuildQueryString(m_strSpecialRequest) + "'"
                    'End If

                    strSQL += ",NULL,'"
                    'Modified by SanaS on 14-Aug-2009
                    'strSQL += CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) + "'," + m_objGlobal.UserID.ToString + ",'HPD',NULL," + m_intProjectEmployeeRoleId.ToString + "," + "R" + "," + intResourcepoolID.ToString + "," + intRoleID.ToString + ",0,null," + "P"
                    strSQL += CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) + "'," + m_objGlobal.UserID.ToString + ",'" + strType + "',NULL," + m_intProjectEmployeeRoleId.ToString + "," + "R" + "," + intResourcepoolID.ToString + "," + intRoleID.ToString + ",0,null,'P'"
                    'END Modification by SanaS on 14-Aug-2009
                    m_intRequestID = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), Long)


                Else
                    strSQL = "usp_Ins_tbl_PM_PreponeResourceRequest  NULL," + m_objGlobal.ProjectID.ToString + ",'"
                    If m_strNewAllocation <> m_strOldAllocation Then
                        strSQL += m_strRequestedStartDate + "','" + m_strRequestedEndDate + "',NULL,1," + m_strHours
                    Else
                        strSQL += m_strRequestedStartDate + "','" + m_strRequestedEndDate + "',NULL,1," + m_strHours
                    End If
                    'If m_strSpecialRequest = "" Then
                    '    strSQL += ",'" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtRequest"), "0").ToString) + "'"
                    'Else
                    strSQL += ",'" + CommonFunction.General.BuildQueryString(m_strSpecialRequest) + "'"
                    'End If

                    strSQL += ",NULL,'"
                    'Modified by SanaS on 14-Aug-2009
                    'strSQL += CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) + "'," + m_objGlobal.UserID.ToString + ",'HPD',NULL," + m_intProjectEmployeeRoleId.ToString + "," + "R" + "," + intResourcepoolID.ToString + "," + intRoleID.ToString + ",0,null," + "P"
                    strSQL += CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) + "'," + m_objGlobal.UserID.ToString + ",'" + strType + "',NULL," + m_intProjectEmployeeRoleId.ToString + "," + "R" + "," + intResourcepoolID.ToString + "," + intRoleID.ToString + ",0,null,'P'"
                    'END Modification by SanaS on 14-Aug-2009

                    m_intRequestID = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), Long)



                End If
                CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)



                If m_IsProjectResourceAllocation = False Then

                    m_strRequestedEndDate = MyBase.GetFormValue("txtReqEndDate")
                    m_intEmployeeID = CType(MyBase.GetFormValue("txtEmpID"), Integer)
                    drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_get_resource_tbl_pm_resourcerequest " + m_objGlobal.ProjectID.ToString + ",'" + m_strRequestedEndDate + "'" + "," + m_intEmployeeID.ToString, MyBase.UseSQL)

                    If drProjectEmployeeRole.Read Then
                        intEmployeeid = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(drProjectEmployeeRole("employeeid"), "0"), "0"), Integer)
                    End If
                    If intEmployeeid <> 0 Then

                        Response.Write("<script language=javascript>" & vbCrLf)
                        Response.Write(" alert('You can not send request as he has planned task after Requested End Date'); ")
                        Response.Write("</script>")
                    ElseIf intRequestID = 0 And intEmployeeid = 0 Then
                        Response.Write("<script language=javascript>" & vbCrLf)
                        Response.Write("window.close();" + vbCrLf)
                        Response.Write("window.opener.location=window.opener.location;")
                        Response.Write("window.open('../General/SendEmail.aspx?MessageID=498&ResourceRequestID=" + m_intRequestID.ToString + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                        Response.Write("</script>")
                    Else
                        Response.Write("<script language=javascript>" & vbCrLf)
                        Response.Write("window.close();")
                        Response.Write("window.opener.location=window.opener.location;") ''RK
                        Response.Write("</script>")
                        'Response.Write("<script language=javascript>" & vbCrLf)
                        'Response.Write("window.close();" + vbCrLf)
                        'Response.Write("window.opener.location=window.opener.location;")
                        'Response.Write("window.open('../General/SendEmail.aspx?MessageID=81&ResourceRequestID=" + CType(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), Integer).ToString + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                        'Response.Write("</script>")
                    End If
                    CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)
                Else
                    WithoutWorkFlowAssign()
                End If
            End If
        End If


        If m_strMode = "ASSIGNSAVE" Then
            Dim m_PreponeHours As Double
            Dim Hours As Double
            Dim flag As Integer
            Dim ActualHours As Double = 0
            Dim WorkingDays As Double
            Dim m_strerr As String
            Dim m_extrahrsRequired As Double
            m_strRequestedStartDate = MyBase.GetFormValue("txtReqStart")
            m_strRequestedEndDate = MyBase.GetFormValue("txtReqEndDate")
            m_strHours = MyBase.GetFormValue("txtHours")
            m_intPriority = CType(CommonFunction.General.CheckIsNothing("0" + MyBase.GetFormValue("cboPriority"), "0"), Integer)
            m_strSpecialRequest = CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtRequest"), " ").ToString)
            m_strNewAllocation = CType(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtNewAllocation"), "0"), Double)
            m_strOldAllocation = CType(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtPrevAllocation"), "0"), Double)


            drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_sel_ProponeRelease_Workhours '" + strStartDate + "','" + m_strRequestedEndDate + "'" + "," + m_intEmployeeID.ToString + "," + strProjectID.ToString + "," + lngHours.ToString + ",'" + strEndDate.ToString + "'", MyBase.UseSQL)
            If drProjectEmployeeRole.Read Then
                m_PreponeHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("WorkHours"), "0"), Double)
                ActualHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("ActualHours"), "0"), Double)
                WorkingDays = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("WorkingDays"), "0"), Double)
            End If
            Hours = CType(lngHours, Double) - CType(m_strHours, Double)
            If m_strNewAllocation > m_strOldAllocation Then

                drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_sel_FreeHours_PreponeBooking '" + m_strRequestedStartDate + "','" + m_strRequestedEndDate + "'" + "," + m_intEmployeeID.ToString + "," + strProjectID.ToString, MyBase.UseSQL)
                If drProjectEmployeeRole.Read Then
                    m_dblFreeHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("FreeHours"), "0"), Double)
                    m_dblFreeMinWorkperday = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("MinimumPerDay"), "0"), Double)
                    m_dblFreeMinWorkpercentage = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("MinimumPercentage"), "0"), Double)
                End If

                CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)

                strSQL = "usp_sel_get_ExtrahrsRequired_Prepone '" + m_strRequestedStartDate + "','"
                strSQL = strSQL + m_strRequestedEndDate + "'," + m_strOldAllocation.ToString + ","
                strSQL = strSQL + m_strNewAllocation.ToString + ",'" + strType + "'," + m_intEmployeeID.ToString + "," + strProjectID.ToString
                drProjectEmployeeRole = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
                If drProjectEmployeeRole.Read Then
                    m_extrahrsRequired = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("ExtraHours"), "0"), Double)
                End If

                CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)

                If m_extrahrsRequired > m_dblFreeHours Then
                    flag = 1
                    m_strerr = "You can not Prepone release this resource with Extra Hrs requirement as Resource is not free"
                    'Response.Write("<script language=javascript>")
                    'Response.Write("alert('You can not Prepone release this resource with Extra Hrs requirement as Resource is not free');" + vbCrLf)
                    'Response.Write("</script>")
                End If
                If strType = "P" Then
                    If m_strNewAllocation > m_dblFreeMinWorkpercentage Then
                        flag = 1
                        m_strerr = m_strerr + "\nResource minimum available percentage ( " + m_dblFreeMinWorkpercentage.ToString + "%) is less than the requested."
                    End If
                ElseIf strType = "HPD" Then
                    If m_strNewAllocation > m_dblFreeMinWorkperday Then
                        flag = 1
                        m_strerr = m_strerr + "\n\nResource available free work hours per day (" + m_dblFreeMinWorkperday.ToString + ") are less than the requested. "
                    End If
                End If
            End If
            If flag = 1 Then
                Response.Write("<script language=javascript>")
                Response.Write("alert('" + m_strerr + "');" + vbCrLf)
                Response.Write("</script>")
            End If
            'If CType(m_strHours, Double) >= CType(lngHours, Double) Then
            '    flag = 1
            '    Response.Write("<script language=javascript>")
            '    Response.Write("alert('You can not Prepone release this resource as Planned Work hours should be greater than 0');" + vbCrLf)
            '    Response.Write("</script>")
            'End If
            If WorkingDays = 0 Then
                flag = 1
                Response.Write("<script language=javascript>")
                Response.Write("alert('You can not Prepone release this resource as Working Days are 0');" + vbCrLf)
                Response.Write("</script>")
            End If
            'If m_PreponeHours <> 0 Then
            '    If Hours > m_PreponeHours Then
            '        flag = 1
            '        Response.Write("<script language=javascript>")
            '        Response.Write("alert('You can not Prepone release this resource');" + vbCrLf)
            '        Response.Write("</script>")
            '    End If
            'End If
            If ActualHours <> 0 Then
                If Hours < ActualHours Then
                    flag = 1
                    Response.Write("<script language=javascript>")
                    Response.Write("alert('You can not Prepone release this resource! Resource has daily activity entered greater than New Total Hours ');" + vbCrLf)
                    Response.Write("</script>")
                End If
            End If

            If flag <> 1 Then
                'inset into tbl_PM_AssignedResources table 
                If DateDiff("d", m_strRequestedStartDate, strStartDate) = 0 Then
                    strSQL = "usp_Ins_tbl_PM_AssignedResourcesForPreponeBooking " + m_intRequestID.ToString + "," + strProjectID.ToString + ","
                    strSQL += m_intEmployeeID.ToString + ",'" + m_strRequestedStartDate + "','" + m_strRequestedEndDate + "'," + m_strHours + "," + m_intProjectEmployeeRoleId.ToString + ",'L' "
                ElseIf DateDiff("d", m_strRequestedStartDate, Now.Date) = 0 Then
                    strSQL = "usp_Ins_tbl_PM_AssignedResourcesForPreponeBooking " + m_intRequestID.ToString + "," + strProjectID.ToString + ","
                    strSQL += m_intEmployeeID.ToString + ",'" + m_strRequestedStartDate + "','" + m_strRequestedEndDate + "'," + m_strHours + "," + m_intProjectEmployeeRoleId.ToString + ",'L' "
                Else
                    strSQL = "usp_Ins_tbl_PM_AssignedResourcesForPreponeBooking " + m_intRequestID.ToString + "," + strProjectID.ToString + ","
                    strSQL += m_intEmployeeID.ToString + ",'" + m_strRequestedStartDate + "','" + m_strRequestedEndDate + "'," + m_strHours + "," + m_intProjectEmployeeRoleId.ToString + ",'A' "
                End If
                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                'update tbl_PM_ResourceRequest table
                strSQL = "usp_Ins_tbl_PM_PreponeResourceRequest " + m_intRequestID.ToString + "," + strProjectID.ToString + ",'"
                strSQL += m_strRequestedStartDate + "','" + m_strRequestedEndDate + "',NULL,1," + m_strHours
                If m_strSpecialRequest = "" Then
                    strSQL += ",NULL"
                Else
                    strSQL += ",'" + m_strSpecialRequest + "'"
                End If
                'If m_intPriority = 0 Then
                strSQL += ",NULL,'"
                'Else
                '    strSQL += "," + m_intPriority.ToString + ",'"
                'End If
                'Modification by SanaS on 14-Aug-2009
                'strSQL += m_objGlobal.UserName + "'," + m_objGlobal.UserID.ToString + ",'HPD',NULL," + m_intProjectEmployeeRoleId.ToString + "," + "A" + "," + intResourcepoolID.ToString + "," + intRoleID.ToString + "," + "1"
                strSQL += m_objGlobal.UserName + "'," + m_objGlobal.UserID.ToString + ",'" + strType + "',NULL," + m_intProjectEmployeeRoleId.ToString + "," + "A" + "," + intResourcepoolID.ToString + "," + intRoleID.ToString + "," + "1,null,'P'"
                'End Modification by SanaS on 14-Aug-2009
                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)


                drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_get_resource_tbl_pm_resourcerequest " + strProjectID + ",'" + m_strRequestedEndDate + "'" + "," + m_intEmployeeID.ToString, MyBase.UseSQL)
                If drProjectEmployeeRole.Read Then
                    intEmployeeid = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(drProjectEmployeeRole("employeeid"), "0"), "0"), Integer)
                End If
                If intEmployeeid <> 0 Then

                    Response.Write("<script language=javascript>" & vbCrLf)
                    Response.Write(" alert('You can not send request as he has planned task after Requested End Date'); ")
                    Response.Write("</script>")
                    'ElseIf intRequestID = 0 And intEmployeeid = 0 Then
                    '    Response.Write("<script language=javascript>" & vbCrLf)
                    '    Response.Write("window.close();" + vbCrLf)
                    '    Response.Write("window.opener.location=window.opener.location;")
                    '    Response.Write("window.open('../General/SendEmail.aspx?MessageID=81&ResourceRequestID=" + CType(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), Integer).ToString + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                    '    Response.Write("</script>")
                Else
                    'Response.Write("<script language=javascript>" & vbCrLf)
                    'Response.Write("window.close();")
                    'Response.Write("</script>")

                    'Response.Write("<script language=javascript>" & vbCrLf)
                    'Response.Write("window.close();")
                    'Response.Write("window.opener.location=window.opener.location;")
                    'Response.Write("window.open('../General/SendEmail.aspx?MessageID=76&RequestID=" + m_intRequestID.ToString() + "  EmployeeIDS = " + m_intEmployeeID.ToString + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")

                    m_strScript = "window.close();" + vbCrLf
                    m_strScript &= "window.opener.location=window.opener.location;" + vbCrLf
                    m_strScript &= "window.open(""../General/SendEmail.aspx?MessageID=499&RequestID=" & m_intRequestID.ToString()
                    m_strScript &= "&EmployeeIDS=" & m_intEmployeeID.ToString & """ ,'',"
                    m_strScript &= "'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left='"
                    m_strScript &= " + (window.screen.width - 600)/2 + ',top='"
                    m_strScript &= " + (window.screen.height - 500)/2 + ',width=600,height=500')" & vbCrLf

                End If
            End If
            CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)

        End If

    End Sub
    Private Sub DrawPage()
        '====================================================================
        ' Procedure Name        : SaveData
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To draw page
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SanaS
        ' Created               : 01-Sep-2009
        '=====================================================================

        'If mode is ADD then show the request end date , hours and priority as empty values
        If m_IsProjectResourceAllocation = True Then
            strType = "P"
        End If
        If m_strMode = "ADD" Then
            If intRequestID = 0 Then
                If m_strStatus <> "A" Then
                    m_strRequestedStartDate = strStartDate

                    m_strRequestedEndDate = ""
                    m_strHours = ""
                    m_intPriority = 0
                    m_strSpecialRequest = ""
                End If
            End If
        End If

        'Commented and added By Bharat T on 16th-oct-2015
        'Response.Write("<DIV Id= 'PageDiv' Style='Width:100%;OverFlow:auto'>")
        Response.Write("<DIV Id= 'PageDiv' Style='Width:100%;OverFlow:auto;height:400px'>")
        'End of Commented and added By Bharat T on 16th-oct-2015


        'Create object of the Section Title class from the Templates
        'create first section
        Dim ObjSectionTitle As New WebPages.Template.SectionTitle
        Dim strLeftSectionTitle As String = MyBase.GetResourceString("CURRENT_DETAIL")
        Dim strSectionTag As String = "divSection1"
        Dim strFunctionName As String = "ShowHide_divSection1"
        If lngRegHours = 0 Then
            Dim drAllocationDetails As IDataReader
            drAllocationDetails = CommonFunctions.Data.GetDataReader("usp_sel_getOldAllocationDetails  " + m_intProjectEmployeeRoleId.ToString + "," + m_intRequestID.ToString, MyBase.UseSQL)
            If drAllocationDetails.Read Then
                If strType.ToString = "HPD" Then

                    lngRegHours = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("ApprovedWorkHours"), "0"), String)
                ElseIf strType.ToString = "P" Then
                    lngRegHours = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("ApprovedPercentageAllocation"), "0"), String)
                Else
                    lngRegHours = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("ApprovedTotalRequestedHrs"), "0"), String)
                End If
                If lngHours = 0 Then
                    lngHours = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("ApprovedTotalRequestedHrs"), "0"), String)
                End If
            End If

            CommonFunction.Data.DisposeDataReader(drAllocationDetails)

        End If

        With ObjSectionTitle
            Response.Write(.GetSectionTitle(strLeftSectionTitle, strSectionTag, strFunctionName, , , , , ))
            Response.Write(System.Environment.NewLine + "<SCRIPT language=javascript>" + System.Environment.NewLine)
            Response.Write(.ClientsideScript())
            Response.Write(System.Environment.NewLine + "</SCRIPT>" + System.Environment.NewLine)
        End With

        ObjSectionTitle = Nothing

        System.Web.HttpContext.Current.Response.Write("<DIV Id=" + strSectionTag + " Style='HEIGHT:100px;'>")

        Response.Write("<table cellSpacing='0' class='clsTable' width='99.9%'>")
        Response.Write("<TR class='clsTREven'>")
        Response.Write("<TD align=right><b>")
        Response.Write("Employee Name: </b>")
        Response.Write("</TD>")
        Response.Write("<TD colspan=3>")
        Response.Write(strEmployeeName)
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtEmpID", "txtEmpID", , , , m_intEmployeeID.ToString, , , , , , True, , , , , , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        Response.Write("</TD>")
        Response.Write("</TR>")
        Response.Write("<TR class='clsTREven'>")
        Response.Write("<TD align=right><b>")
        Response.Write("Allocation Start Date: </b>")
        Response.Write("</TD>")
        Response.Write("<TD>")
        If m_strStatus.Trim.ToUpper <> "A" Then
            Response.Write(strStartDate)

            Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtStartDate", "txtStartDate", , , strStartDate, , "frmPM_PreponeBooking", , , , , , , , , , , True))

        Else
            Response.Write(m_strRequestedStartDate)
        End If
        Response.Write("</TD>")

        Response.Write("<TD align=right><b>")
        Response.Write("Allocation End Date: </b>")
        Response.Write("</TD>")
        Response.Write("<TD>")
        If m_strStatus.Trim.ToUpper <> "A" Then
            Response.Write(strEndDate)
            Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtEndDate", "txtEndDate", , , strEndDate, , "frmPM_PreponeBooking", , , , , , , , , , , True))

        Else
            Response.Write(m_strRequestedEndDate)
        End If
        Response.Write("</TD>")
        Response.Write("</TR>")
        Response.Write("<TR class='clsTREven'>")
        Response.Write("<TD align=right><b>")
        Response.Write("Allocation Type: </b>")
        Response.Write("</TD>")
        Response.Write("<TD>")
        If strType = "TH" Then
            Response.Write("Total Hours")
        ElseIf strType = "P" Then
            Response.Write("% Per Day")
        Else
            Response.Write("Hours Per Day")
        End If
        Response.Write("</TD>")
        Response.Write("<TD align=right><b>")
        Response.Write("Allocation Value: </b>")
        Response.Write("</TD>")
        Response.Write("<TD>")
        If strType = "P" Then
            Response.Write(lngRegHours.ToString + " %")
        ElseIf strType = "HPD" Then
            Response.Write(lngRegHours.ToString + "Hrs/Day")
        Else
            Response.Write(lngRegHours.ToString)
        End If
        Response.Write("</TD>")
        Response.Write("</TR>")
        Response.Write("<TR class='clsTREven'>")
        Response.Write("<TD align=right><b>")
        Response.Write("Work Hours on Project: </b>")
        Response.Write("</TD>")
        Response.Write("<TD colspan=3>")
        Response.Write(lngHours.ToString)
        Response.Write("</TD>")
        Response.Write("</TR>")
        Response.Write("</table>")

        System.Web.HttpContext.Current.Response.Write("</DIV>")
        If m_strStatus.Trim.ToUpper <> "A" Then

            'Create object of the Section Title class from the Templates
            'Create second section
            ObjSectionTitle = New WebPages.Template.SectionTitle
            strLeftSectionTitle = MyBase.GetResourceString("PREPONE_REQUEST")
            strSectionTag = "divSection2"
            strFunctionName = "ShowHide_divSection2"


            With ObjSectionTitle
                Response.Write(.GetSectionTitle(strLeftSectionTitle, strSectionTag, strFunctionName, , , , , ))
                Response.Write(System.Environment.NewLine + "<SCRIPT language=javascript>" + System.Environment.NewLine)
                Response.Write(.ClientsideScript())
                Response.Write(System.Environment.NewLine + "</SCRIPT>" + System.Environment.NewLine)
            End With

            ObjSectionTitle = Nothing

            System.Web.HttpContext.Current.Response.Write("<DIV Id=" + strSectionTag + " Style='HEIGHT:100px;'>")

            If m_strMode = "SAVE" Or m_strMode = "ADD" Then

                'strType = CType(CommonFunctions.Data.GetDataScalar("usp_get_allocationType_for_AssignedResource " + m_intProjectEmployeeRoleId.ToString, MyBase.UseSQL), String)
                Dim drAllocationDetails As IDataReader

                If intRequestID = 0 Then
                    drAllocationDetails = CommonFunctions.Data.GetDataReader("usp_sel_getOldAllocationDetails  " + m_intProjectEmployeeRoleId.ToString, MyBase.UseSQL)
                Else
                    drAllocationDetails = CommonFunctions.Data.GetDataReader("usp_sel_getOldAllocationDetails  " + m_intProjectEmployeeRoleId.ToString + "," + intRequestID.ToString, MyBase.UseSQL)
                End If
                If drAllocationDetails.Read Then
                    If intRequestID = 0 Then
                        mstrhrsperday = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("WorkHours"), "0"), String)
                        mstrPercentageperday = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("PercentageAllocation"), "0"), String)
                        mstrtotal = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("TotalRequestedHrs"), "0"), String)
                        mstrApprovedhrsperday = mstrhrsperday
                        mstrApprovedPercentageperday = mstrPercentageperday
                        mstrApprovedtotal = mstrtotal
                    Else
                        mstrhrsperday = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("WorkHours"), "0"), String)
                        mstrPercentageperday = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("PercentageAllocation"), "0"), String)
                        mstrtotal = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("TotalRequestedHrs"), "0"), String)
                        mstrApprovedhrsperday = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("ApprovedWorkHours"), "0"), String)
                        mstrApprovedPercentageperday = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("ApprovedPercentageAllocation"), "0"), String)
                        mstrApprovedtotal = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("ApprovedTotalRequestedHrs"), "0"), String)
                        m_strHours = mstrtotal
                    End If
                Else
                    If m_IsProjectResourceAllocation = True Then
                        mstrPercentageperday = lngRegHours
                        mstrApprovedPercentageperday = lngRegHours
                    Else
                        If mstrPercentageperday Is Nothing Then
                            mstrPercentageperday = mstrApprovedPercentageperday
                        End If
                    End If
                End If

                CommonFunction.Data.DisposeDataReader(drAllocationDetails)


                Response.Write("<table cellSpacing='0' class='clsTable' width='99.9%'>")
                Response.Write("<TR class='clsTREven'>")
                Response.Write("<TD align=right>")
                Response.Write("New End Date: ")
                Response.Write("</TD>")
                Response.Write("<TD colspan=3>")
                If strType.ToUpper <> "TH" Then
                    Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtReqEndDate", "txtReqEndDate", , , m_strRequestedEndDate, , "frmPM_PreponeBooking", , , , , , , , True, ToBeInserted:="onblur=""javascript:GetWorkHours()"""))
                Else
                    Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtReqEndDate", "txtReqEndDate", , , m_strRequestedEndDate, , "frmPM_PreponeBooking", , , , , , , , True, ToBeInserted:="onblur=""javascript:GetWorkHours()"""))
                    ''added Function name by RohiniK on 7 Sep 09
                End If
                Response.Write("<TD align=right>")
                If strType = "TH" Then
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtPrevAllocation", "txtPrevAllocation", , , , mstrApprovedtotal.ToString, , , True, , , True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    m_strOldAllocation = CType(mstrtotal, Double)
                ElseIf strType = "P" Then
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtPrevAllocation", "txtPrevAllocation", , , , mstrApprovedPercentageperday.ToString, , , True, , , True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    m_strOldAllocation = CType(mstrPercentageperday, Double)
                ElseIf strType = "HPD" Then
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtPrevAllocation", "txtPrevAllocation", , , , mstrApprovedhrsperday.ToString, , , True, , , True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    m_strOldAllocation = CType(mstrhrsperday, Double)
                End If
                Response.Write("</TD>")
                Response.Write("<TR class='clsTREven'>")
                Response.Write("<TD colspan=4 align=center><b>")
                Response.Write("If You want to change allocation, please enter following details</b>")
                Response.Write("</TD>")
                Response.Write("</TR>")
                Response.Write("<TR class='clsTREven'>")

                Response.Write("<TD align=right>")
                If strType = "TH" Then
                    Response.Write("NEW " + MyBase.GetResourceString("WORK_HOURS") + " ")
                    Response.Write("</TD>")
                    Response.Write("<TD>")
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtNewAllocation", "txtNewAllocation", , , , mstrtotal.ToString, , , ToBeInserted:="onblur=""javascript:GetWorkHours()""", EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                ElseIf strType = "P" Then
                    Response.Write("New % Of Day ")
                    Response.Write("</TD>")
                    Response.Write("<TD>")
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtNewAllocation", "txtNewAllocation", , , , mstrPercentageperday.ToString, , , ToBeInserted:="onblur=""javascript:GetWorkHours()""", EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                ElseIf strType = "HPD" Then
                    Response.Write("New Hrs Per Day ")
                    Response.Write("</TD>")
                    Response.Write("<TD>")
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtNewAllocation", "txtNewAllocation", , , , mstrhrsperday.ToString, , , ToBeInserted:="onblur=""javascript:GetWorkHours()""", EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                End If
                Response.Write("</TD>")
                Response.Write("<TD align=right>")
                Response.Write("Effective Date")
                Response.Write("</TD>")
                Response.Write("<TD>")
                Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtReqStart", "txtReqStart", , , m_strRequestedStartDate, , "frmPM_PreponeBooking", , , , , , , ToBeInserted:="onblur=""javascript:GetWorkHours()"""))
                Response.Write("</TD>")
                Response.Write("</TR>")
                If CommonFunctions.General.CheckIsNothing(m_strHours) <> "-1" Then
                    Response.Write("<TR class='clsTREven'>")
                    Response.Write("<TD align=right>")
                    Response.Write("New Work Hours: ")
                    Response.Write("</TD>")
                    Response.Write("<TD colspan=3><span id=TotalHrsSpan>")
                    Response.Write(mstrtotal + "</span>")
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtHours", "txtHours", , 60, 4, mstrtotal, "right", , , True, , True, , , EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

                    Response.Write("</TD>")
                    Response.Write("</TR>")
                End If

            Else
                Dim drAllocationDetails As IDataReader
                drAllocationDetails = CommonFunctions.Data.GetDataReader("usp_sel_getOldAllocationDetails  " + m_intProjectEmployeeRoleId.ToString + "," + m_intRequestID.ToString, MyBase.UseSQL)
                If drAllocationDetails.Read Then
                    mstrhrsperday = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("WorkHours"), "0"), String)
                    mstrPercentageperday = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("PercentageAllocation"), "0"), String)
                    mstrtotal = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("TotalRequestedHrs"), "0"), String)
                    mstrApprovedhrsperday = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("ApprovedWorkHours"), "0"), String)
                    mstrApprovedPercentageperday = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("ApprovedPercentageAllocation"), "0"), String)
                    mstrApprovedtotal = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("ApprovedTotalRequestedHrs"), "0"), String)
                End If

                CommonFunction.Data.DisposeDataReader(drAllocationDetails)

                Response.Write("<table cellSpacing='0' class='clsTable' width='99.9%'>")
                Response.Write("<TR class='clsTREven'>")
                Response.Write("<TD align=right>")
                Response.Write("New End Date: ")
                Response.Write("</TD>")
                Response.Write("<TD colspan=3>")
                Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtReqEndDate", "txtReqEndDate", , , m_strRequestedEndDate, , "frmPM_PreponeBooking", , , , True, , , , True))
                Response.Write("</TD>")
                Response.Write("<TD align=right>")
                'kept txtPrevAllocation as hidden
                If strType = "TH" Then
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtPrevAllocation", "txtPrevAllocation", , , , mstrApprovedtotal.ToString, , , , , , True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    m_strOldAllocation = CType(mstrtotal, Double)
                ElseIf strType = "P" Then
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtPrevAllocation", "txtPrevAllocation", , , , mstrApprovedPercentageperday.ToString, , , , , , True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    m_strOldAllocation = CType(mstrPercentageperday, Double)
                ElseIf strType = "HPD" Then
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtPrevAllocation", "txtPrevAllocation", , , , mstrApprovedhrsperday.ToString, , , , , , True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    m_strOldAllocation = CType(mstrhrsperday, Double)
                End If
                Response.Write("</TD>")
                Response.Write("<TR class='clsTREven'>")
                Response.Write("<TD align=right>")
                If strType = "TH" Then
                    Response.Write("NEW " + MyBase.GetResourceString("WORK_HOURS") + " ")
                    Response.Write("</TD>")
                    Response.Write("<TD>")
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtNewAllocation", "txtNewAllocation", , , , mstrtotal.ToString, , , True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                ElseIf strType = "P" Then
                    Response.Write("New % Of Day ")
                    Response.Write("</TD>")
                    Response.Write("<TD>")
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtNewAllocation", "txtNewAllocation", , , , mstrPercentageperday.ToString, , , True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                ElseIf strType = "HPD" Then
                    Response.Write("New Hrs Per Day ")
                    Response.Write("</TD>")
                    Response.Write("<TD>")
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtNewAllocation", "txtNewAllocation", , , , mstrhrsperday.ToString, , , True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                End If
                Response.Write("</TD>")

                Response.Write("<TD align=right>")
                Response.Write("Effective Date")
                Response.Write("</TD>")
                Response.Write("<TD>")
                Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtReqStart", "txtReqStart", , , m_strRequestedStartDate, , "frmPM_PreponeBooking", , , , True, , , True))
                Response.Write("</TD>")

                Response.Write("</TR>")
                If CommonFunctions.General.CheckIsNothing(m_strHours) <> "-1" Then
                    Response.Write("<TR class='clsTREven'>")
                    Response.Write("<TD align=right>")
                    Response.Write("New Work Hours: ")
                    Response.Write("</TD>")
                    Response.Write("<TD colspan=3><span id=TotalHrsSpan>")
                    'Modified by SanaS on 14-Aug-2009 for automatically calculating work hours for Percent and hour per day type of allocation
                    Response.Write(mstrtotal + "</span>")
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtHours", "txtHours", , 60, 4, mstrtotal, "right", , , True, , True, , , , EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write("</TD>")
                    Response.Write("</TR>")
                End If

            End If

            'Modified By PrachiK on 10 Mar 2005 for Issue ID=15907. 
            'Purpose: Puting Project end date into hidden field for red date validation

            Dim ProjectDate As String
            'strSQL = "select expectedenddate from tbl_PM_project where ProjectID= " & CType(HttpContext.Current.Session("intProjectID"), String)

            If strProjectID <> "0" Then
                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strSQL = "select expectedenddate from tbl_PM_project where ProjectID= " & strProjectID
                strSQL = "usp_sel_tbl_PM_project_ChangeAllocationType_expectedenddate " & strProjectID
                ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            Else
                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strSQL = "select expectedenddate from tbl_PM_project where ProjectID= " & CType(HttpContext.Current.Session("intProjectID"), String)
                strSQL = "usp_sel_tbl_PM_project_ChangeAllocationType_expectedenddate " & CType(HttpContext.Current.Session("intProjectID"), String)
                ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            End If

            Dim drReader As IDataReader
            drReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If (drReader.Read) Then
                ProjectDate = CommonFunction.Dates.GetDate(CType(drReader("expectedenddate"), Date))
            End If

            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtProjEndDate", "txtProjEndDate", , , , ProjectDate, , , , , , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.Data.DisposeDataReader(drReader)
            'Added by Sana
            'Purpose: Puting Todays Date into hidden field for Effective date validation

            Dim m_strToday As String
            m_strToday = CommonFunctions.Dates.GetDate(Now.Date)
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtToday", "txtToday", , , , m_strToday, , , , , , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            'End Addition by Sana
            Response.Write("<TR class='clsTREven'>")
            Response.Write("<TD align=right valign=top>")
            Response.Write(MyBase.GetResourceString("SPECIAL_REQUEST") + " ")
            Response.Write("</TD>")
            Response.Write("<TD colspan=3>")
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'Response.Write(CommonFunction.HTMLControls.DrawTextArea("txtRequest", "txtRequest", , , , , , , 450, 80, 300, m_strSpecialRequest))
            Response.Write(CommonFunction.HTMLControls.DrawTextArea("txtRequest", "txtRequest", , , , , , , 450, 80, 300, m_strSpecialRequest, EnableHTMLEncode:=True))
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            Response.Write("</TD>")
            Response.Write("</TR>")
            Response.Write("</table>")

            System.Web.HttpContext.Current.Response.Write("</DIV>")
        End If
        HttpContext.Current.Response.Write("</DIV>")
        Response.Write("<BR>")

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        DisposeObjects()

    End Sub
    Private Sub WithoutWorkFlowAssign()
        Dim m_dblNewallocation As Double = 0
        Dim strsql As String
        Dim strStartDate As String
        Dim strProjectid As String
        Dim m_strNewAllocation As Double
        Dim intResourcepoolID As Integer = 0
        Dim m_strScript As String
        Dim m_PreponeHours As Double
        Dim Hours As Double

        Dim m_extrahrsRequired As Double


        strStartDate = MyBase.GetFormValue("txtStartDate")
        m_strRequestedStartDate = MyBase.GetFormValue("txtReqStart")
        m_strRequestedEndDate = MyBase.GetFormValue("txtReqEndDate")
        m_strHours = MyBase.GetFormValue("txtHours")
        m_intPriority = 0
        m_strSpecialRequest = CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtRequest"), " ").ToString)
        m_strNewAllocation = CType(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtNewAllocation"), "0"), Double)
        m_strOldAllocation = CType(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtPrevAllocation"), "0"), Double)
        strProjectid = m_objGlobal.ProjectID.ToString()

        strType = "P"


        If DateDiff("d", m_strRequestedStartDate, strStartDate) = 0 Then
            strsql = "usp_Ins_tbl_PM_AssignedResourcesForPreponeBooking " + m_intRequestID.ToString + "," + strProjectid.ToString + ","
            strsql += m_intEmployeeID.ToString + ",'" + m_strRequestedStartDate + "','" + m_strRequestedEndDate + "'," + m_strHours + "," + m_intProjectEmployeeRoleId.ToString + ",'L' "
        ElseIf DateDiff("d", m_strRequestedStartDate, Now.Date) = 0 Then
            strsql = "usp_Ins_tbl_PM_AssignedResourcesForPreponeBooking " + m_intRequestID.ToString + "," + strProjectid.ToString + ","
            strsql += m_intEmployeeID.ToString + ",'" + m_strRequestedStartDate + "','" + m_strRequestedEndDate + "'," + m_strHours + "," + m_intProjectEmployeeRoleId.ToString + ",'L' "
        Else
            strsql = "usp_Ins_tbl_PM_AssignedResourcesForPreponeBooking " + m_intRequestID.ToString + "," + strProjectid.ToString + ","
            strsql += m_intEmployeeID.ToString + ",'" + m_strRequestedStartDate + "','" + m_strRequestedEndDate + "'," + m_strHours + "," + m_intProjectEmployeeRoleId.ToString + ",'A' "
        End If
        CommonFunction.Data.InsertOrUpdateData(strsql, MyBase.UseSQL)

        'update tbl_PM_ResourceRequest table
        strsql = "usp_Ins_tbl_PM_PreponeResourceRequest " + m_intRequestID.ToString + "," + strProjectid.ToString + ",'"
        strsql += m_strRequestedStartDate + "','" + m_strRequestedEndDate + "',NULL,1," + m_strHours
        If m_strSpecialRequest = "" Then
            strsql += ",NULL"
        Else
            strsql += ",'" + m_strSpecialRequest + "'"
        End If
        'If m_intPriority = 0 Then
        strsql += ",NULL,'"

        strsql += m_objGlobal.UserName + "'," + m_objGlobal.UserID.ToString + ",'" + strType + "',NULL," + m_intProjectEmployeeRoleId.ToString + "," + "A" + "," + intResourcepoolID.ToString + "," + intRoleID.ToString + "," + "1,null,'P'"
        'End Modification by SanaS on 14-Aug-2009
        CommonFunction.Data.InsertOrUpdateData(strsql, MyBase.UseSQL)


        m_strScript = "<script type='text/javascript'>"
        m_strScript &= "window.close();" + vbCrLf
        m_strScript &= "window.opener.location=window.opener.location;" + vbCrLf
        m_strScript &= "</script>;" + vbCrLf
        Response.Write(m_strScript)

    End Sub

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        : PageInit
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the page
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             : SanaS 29-Aug-2009
        '=====================================================================

        'This will initialize all the global objects.
        GetGlobalObject()
        InitializeData()
        'This will strore the constructed menu string in a string variable.   

        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        'Display the page legend
        WritePageLegend()
        'Display the page caption.
        DrawPageCaption()
        'Display the Header if exist. 
        DrawHeader()
        If m_strMode.ToUpper = "CANCEL" Then
            CancelRequest()
        End If

        If m_strMode.ToUpper = "SAVE" Or m_strMode.ToUpper = "ASSIGNSAVE" Then

            SaveData()
        End If


        If m_strMode.ToUpper <> "CANCEL" Then
            DrawPage()
        End If


    End Sub
#End Region

#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region

#Region "Page - Control Events "

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim drProjectEmployeeRole As IDataReader
        m_strRequestedStartDate = ""
        m_strRequestedEndDate = ""
        m_strSpecialRequest = ""
        m_strHours = ""
        m_strMode = Request.QueryString("Mode").ToUpper
        m_strRequestedEndDate = MyBase.GetFormValue("txtReqEndDate")
        m_strSpecialRequest = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtRequest"), "").ToString
        'm_strHours = MyBase.GetFormValue("txtHours")

        'this code is executed for assigned resource request.
        m_intPriority = CType(CommonFunction.General.CheckIsNothing("0" + MyBase.GetFormValue("cboPriority"), "0"), Integer)
        If Not IsPostBack Then
            m_intRequestID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RequestID"), "0"), Integer)
            If m_intRequestID <> 0 Then
                drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ResourceRequest_ExtensionBooking NULL," + m_intRequestID.ToString, MyBase.UseSQL)
                If drProjectEmployeeRole.Read Then
                    m_strStatus = drProjectEmployeeRole("Status").ToString
                End If
                CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)
            End If

            MyBase.InitializeResources("AppResources.PM_PreponeBooking", "AppResources")

        End If

    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print

        'if resource already assigned then only show the close link.
        If m_strStatus.Trim.ToUpper = "A" Then
            If Args.MenuColIndex < 3 Then
                Cancel = True
            End If
            If m_strMode = "ASSIGN" Then
                If Args.MenuColIndex = 3 Then
                    Cancel = True
                End If
            ElseIf m_RequestType <> "P" Then
                If Args.MenuColIndex = 3 Then
                    Cancel = True
                End If
            End If
           
        Else
            'for add or save mode hide the Assign and Reject Request link
            If m_strMode = "ADD" Or m_strMode = "SAVE" Then
                If Args.MenuColIndex = 1 Or Args.MenuColIndex = 2 Or Args.MenuColIndex = 3 Then
                    Cancel = True
                End If
            End If
            'For ASSIGN,ASSIGNSAVE,ASSIGNCONFIRM mode hide save link
            If m_strMode = "ASSIGN" Or m_strMode = "ASSIGNSAVE" Or m_strMode = "ASSIGNCONFIRM" Then
                If Args.MenuColIndex = 0 Then
                    Cancel = True
                End If
                If Args.MenuColIndex = 3 Then
                    Cancel = True
                End If
            End If
        End If

    End Sub

#End Region

End Class
