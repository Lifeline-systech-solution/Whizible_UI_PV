#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class PM_ChangeAllocationType
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
    Protected m_strEndDate As String
    Protected m_strRequestedEffectiveFromDate As String
    Protected m_strRequestDate As String
    Protected m_strHours As String
    Protected m_intPriority As Integer
    Protected m_strSpecialRequest As String
    Protected m_intRequestID As Integer
    Protected m_strMode As String
    Protected m_strScript As String
    Protected m_intEmployeeID As Integer
    Protected m_strStatus As String = "-1"
    Protected strRequestType As String
    Protected m_StdAllocationPercentage As Long
    Protected m_IsProjectResourceAllocation As Boolean
    Protected m_OldAllocation As Double
    Protected WithEvents frmPM_ChangeAllocation As System.Web.UI.HtmlControls.HtmlForm

    Private strStartDate As String
    Private strEndDate As String
    Private strEmployeeName As String
    Private lngBalanceHours As Long
    Private lngHours As Double
    Private strProjectID As String = "0"
    Private drProjectEmployee As IDataReader
    Private drProjectEmployeeRole As IDataReader
    Private intResourcepoolID As Integer
    Private intRoleID As Integer
    Protected intRequestID As Integer
    Private m_dblFreeHours As Double = 0
    Private m_dblFreeMinWorkperday As Double = 0
    Private m_dblFreeMinWorkpercentage As Double = 0
    Private m_dblNewallocation As Double = 0
    Private strSQL As String
    Private lngRegHours As Double
    Private m_RequestType As String
    Private mstrhrsperday As String
    Private mstrPercentageperday As String
    Private mstrtotal As String
    Private mstrApprovedhrsperday As String
    Private mstrApprovedPercentageperday As String
    Private mstrApprovedtotal As String
    Private intEmployeeid As Integer
    Private m_strRequestedEndDate As String

    Private Enum MenuIndex
        SAVE
        REJECTREQUEST
        ASSIGN
        CANCEL
        CLOSE

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

        Dim arrMenu(4) As String
        Dim arrMenuToolTip(4) As String
        Dim arrClientSideFunction(4) As String
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

 

        Dim strGrid As String

        'cerate the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True)

        MyBase.InitializeResources("AppResources.PM_ExtendBooking", "AppResources")
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

        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, "Change Allocation", , , True))
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

        If intRequestID = 0 Then
            strProjectID = m_objGlobal.ProjectID.ToString
        Else
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            '''strProjectID = CType(CommonFunction.Data.GetDataScalar("Select ProjectID FROM TBL_PM_ResourceRequest Where RequestID=" + m_intRequestID.ToString, MyBase.UseSQL), String)
            strProjectID = CType(CommonFunction.Data.GetDataScalar("usp_sel_TBL_PM_ResourceRequest_ProjectID " + m_intRequestID.ToString, MyBase.UseSQL), String)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
        End If

        m_IsProjectResourceAllocation = CType(CommonFunctions.Data.GetDataScalar("usp_Sel_IsProjectResourceAllocation " + m_objGlobal.ProjectID.ToString, MyBase.UseSQL), Boolean)
        m_intProjectEmployeeRoleId = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectEmployeeRoleID"), "0"), Integer)
        drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_sel_ApproveorRejectRequest_tbl_PM_ResourceRequest " + m_objGlobal.ProjectID.ToString + "," + m_intProjectEmployeeRoleId.ToString + "," + "1", MyBase.UseSQL)
        If m_IsProjectResourceAllocation Then
            strRequestType = "P"
        End If
        If drProjectEmployeeRole.Read Then
            intRequestID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(drProjectEmployeeRole("RequestID"), "0"), "0"), Integer)
        End If
        CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)

        If m_intProjectEmployeeRoleId <> 0 Then
            drProjectEmployee = CommonFunction.Data.GetDataReader("usp_Sel_ProjectEmployeeRole_ChangeAllocation " + m_intProjectEmployeeRoleId.ToString + "," + m_objGlobal.ProjectID.ToString, MyBase.UseSQL)
            If drProjectEmployee.Read Then
                strStartDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("ExpectedStartDate"), ""), Date))
                strEndDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("ExpectedEndDate"), ""), Date))
                lngHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("BudgetedHours"), "0"), Double)
                strEmployeeName = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("EmployeeName"), "0"), String)
                m_intEmployeeID = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("EmployeeID"), "0"), Integer)
                strRequestType = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("RequestType"), "0"), String)
                If strRequestType = "HPD" Then
                    lngRegHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("WorkHours"), "0"), Double)
                ElseIf strRequestType = "TH" Then
                    lngRegHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("TotalRequestedHrs"), "0"), Double)
                ElseIf strRequestType = "P" Then
                    lngRegHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("PercentageAllocation"), "0"), Double)
                End If
                intRoleID = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("Role"), "0"), Integer)
                m_strStatus = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("Status"), "-1"), String)
                If m_strStatus = "A" Then
                    m_strRequestedEffectiveFromDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("FromDate"), ""), Date))
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
            CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)

            If intRequestID <> 0 Then
                drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ResourceRequest_ChangeAllocationType NULL," + intRequestID.ToString, MyBase.UseSQL)
            Else
                drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ResourceRequest_ChangeAllocationType " + m_intProjectEmployeeRoleId.ToString, MyBase.UseSQL)
            End If
            If m_strStatus <> "A" Then
                If drProjectEmployeeRole.Read Then

                    m_strRequestedEffectiveFromDate = CommonFunction.Dates.GetDate(CType(drProjectEmployeeRole("FromDate"), Date))
                    m_strEndDate = CommonFunction.Dates.GetDate(CType(drProjectEmployeeRole("ToDate"), Date))
                    m_strSpecialRequest = CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("SpecialRequest"), "").ToString
                    m_strHours = drProjectEmployeeRole("WorkHours").ToString
                    m_intPriority = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("Priority"), "0"), Integer)
                    m_intRequestID = CType(drProjectEmployeeRole("RequestID"), Integer)
                End If
                CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)
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
            drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ResourceRequest_ChangeAllocationType NULL," + m_intRequestID.ToString, MyBase.UseSQL)
            If drProjectEmployeeRole.Read Then
                m_strRequestedEffectiveFromDate = CommonFunction.Dates.GetDate(CType(drProjectEmployeeRole("FromDate"), Date))
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
                strRequestType = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("Type"), "0"), String)
                If m_strStatus = "A" Then
                    m_strRequestedEffectiveFromDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("FromDate"), ""), Date))
                    m_strRequestedEndDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("ToDate"), ""), Date))
                    lngHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("TotalRequestedHrs"), "0"), Double)
                End If
            End If

            CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)
        End If

    End Sub
    Private Sub CancelRequest()
        m_intRequestID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RequestID"), "0"), Integer)
        strSQL = "usp_Cancel_Resourcerequest " + m_intRequestID.ToString
        CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        m_strScript &= "window.close();" + vbCrLf
        m_strScript &= "window.opener.location=window.opener.location;" + vbCrLf



    End Sub
    Private Sub SaveData()
        Dim mNewRequestID As Long
        'For save option
        If m_strMode = "SAVE" Then
            Dim flag As Integer
            Dim m_strerr As String
            Dim dblstrHours1 As Double
            m_strRequestedEffectiveFromDate = MyBase.GetFormValue("txtEffectiveFromDate")
            m_strEndDate = MyBase.GetFormValue("txtReqEndDate")
            m_strHours = MyBase.GetFormValue("txtHours")
            'Added By Usha Pandit On 10.04.2020 For blank hours field conversion to double issue
            If m_strHours = "" Or m_strHours Is Nothing Then
                m_strHours = "0"
            End If
            'End Of Added By Usha Pandit On 10.04.2020 For blank hours field conversion to double issue
            dblstrHours1 = CType(m_strHours, Double)
            m_strSpecialRequest = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtRequest"), "")
            'm_intPriority =            CType(CommonFunction.General.CheckIsNothing("0" + MyBase.GetFormValue("cboPriority"), "0"), Integer)()
            m_intPriority = 0
            m_dblNewallocation = CType(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtNewAllocation"), "0"), Double)

            drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_sel_FreeHours_ChangeAllocation '" + m_strRequestedEffectiveFromDate + "','" + m_strEndDate + "'" + "," + m_intEmployeeID.ToString + "," + CType(HttpContext.Current.Session("intProjectID"), String), MyBase.UseSQL)

            If drProjectEmployeeRole.Read Then
                m_dblFreeHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("FreeHours"), "0"), Double)
                m_dblFreeMinWorkperday = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("MinimumPerDay"), "0"), Double)
                m_dblFreeMinWorkpercentage = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("MinimumPercentage"), "0"), Double)
            End If

            CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)

            If m_dblFreeHours < dblstrHours1 Then
                flag = 1
                m_strerr = "Resource Free Hrs are less than the hours you are requesting."

            End If
            If strRequestType = "P" Then
                If m_dblNewallocation > m_dblFreeMinWorkpercentage Then
                    flag = 1
                    m_strerr = m_strerr + "\nResource available percentage ( " + m_dblFreeMinWorkpercentage.ToString + "%) is less than the requested."
                End If
            ElseIf strRequestType = "HPD" Then
                If m_dblNewallocation > m_dblFreeMinWorkperday Then
                    flag = 1
                    m_strerr = m_strerr + "\n\nResource available  work hours per day (" + m_dblFreeMinWorkperday.ToString + ") are less than the requested. "
                End If
            End If
            If flag = 1 Then
                m_strHours = ""
                m_strRequestedEffectiveFromDate = ""
                Response.Write("<script language=javascript>")
                Response.Write("alert('" + m_strerr + "');" + vbCrLf)
                Response.Write("</script>")
            End If
            If flag <> 1 Then
                If intRequestID <> 0 Then
                    strSQL = "usp_Ins_tbl_PM_ResourceRequest_Allocation " + intRequestID.ToString + "," + m_objGlobal.ProjectID.ToString + ",'"
                    strSQL += m_strRequestedEffectiveFromDate + "','" + m_strEndDate + "',NULL,1," + m_strHours
                    strSQL += ",'" + CommonFunction.General.BuildQueryString(m_strSpecialRequest) + "'"
                    strSQL += "," + m_intPriority.ToString + ",'"
                    strSQL += CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) + "'," + m_objGlobal.UserID.ToString + ",'" + strRequestType.ToString + "',NULL," + m_intProjectEmployeeRoleId.ToString + "," + "R" + "," + intResourcepoolID.ToString + "," + intRoleID.ToString + ",null,C"
                   
                    m_intRequestID = CType(CommonFunctions.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), Long)

                Else
                    strSQL = "usp_Ins_tbl_PM_ResourceRequest_Allocation  NULL," + m_objGlobal.ProjectID.ToString + ",'"
                    strSQL += m_strRequestedEffectiveFromDate + "','" + m_strEndDate + "',NULL,1," + m_strHours

                    strSQL += ",'" + CommonFunction.General.BuildQueryString(m_strSpecialRequest) + "'"
                    strSQL += "," + m_intPriority.ToString + ",'"
                    strSQL += CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) + "'," + m_objGlobal.UserID.ToString + ",'" + strRequestType.ToString + "',NULL," + m_intProjectEmployeeRoleId.ToString + "," + "R" + "," + intResourcepoolID.ToString + "," + intRoleID.ToString + ",null,C"
                    m_intRequestID = CType(CommonFunctions.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), Long)

                End If

                If m_IsProjectResourceAllocation = False Then
                    If intRequestID = 0 Then
                        m_strScript = "window.close();" + vbCrLf
                        m_strScript += "window.opener.location=window.opener.location;"
                        'write client side script to display the message window
                        '  m_strScript += "window.open('../General/SendEmail.aspx?MessageID=543&ResourceRequestID=" + m_intRequestID.ToString + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');"
                        m_strScript += "window.open('../General/SendEmail.aspx?MessageID=543&ResourceRequestID=" + m_intRequestID.ToString + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');"

                    Else
                        m_strScript = "window.close();"
                    End If
                Else
                    WithoutWorkFlowAssign()
                End If
            End If
            End If
            If m_strMode = "ASSIGNSAVE" Then
                Dim flag As Integer = 0
                Dim dblstrHours1 As Double
                Dim m_strerr As String
                m_strRequestedEffectiveFromDate = MyBase.GetFormValue("txtEffectiveFromDate")
                m_strEndDate = MyBase.GetFormValue("txtReqEndDate")
                m_strHours = MyBase.GetFormValue("txtHours")
                dblstrHours1 = CType(m_strHours, Double)
                ' m_intPriority = CType(CommonFunction.General.CheckIsNothing("0" + MyBase.GetFormValue("cboPriority"), "0"), Integer)
                m_intPriority = 0
                m_strSpecialRequest = CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtRequest"), " ").ToString)
                m_dblNewallocation = CType(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtNewAllocation"), "0"), Double)
                drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_sel_FreeHours_ChangeAllocation '" + m_strRequestedEffectiveFromDate + "','" + m_strEndDate + "'" + "," + m_intEmployeeID.ToString + "," + strProjectID, MyBase.UseSQL)

                If drProjectEmployeeRole.Read Then
                    m_dblFreeHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("FreeHours"), "0"), Double)
                    m_dblFreeMinWorkperday = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("MinimumPerDay"), "0"), Double)
                    m_dblFreeMinWorkpercentage = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("MinimumPercentage"), "0"), Double)
                End If

                CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)

                If m_dblFreeHours < dblstrHours1 Then
                    flag = 1
                    m_strerr = "Resource Free Hrs are less than the hours you are requesting."

                End If
                If strRequestType = "P" Then
                    If m_dblNewallocation > m_dblFreeMinWorkpercentage Then
                        flag = 1
                        m_strerr = m_strerr + "\nResource minimum available percentage ( " + m_dblFreeMinWorkpercentage.ToString + "%) is less than the requested."
                    End If
                ElseIf strRequestType = "HPD" Then
                    If m_dblNewallocation > m_dblFreeMinWorkperday Then
                        flag = 1
                        m_strerr = m_strerr + "\n\nResource available free work hours per day (" + m_dblFreeMinWorkperday.ToString + ") are less than the requested. "
                    End If
                End If
                If flag = 1 Then
                    Response.Write("<script language=javascript>")
                    Response.Write("alert('" + m_strerr + "');" + vbCrLf)
                    Response.Write("</script>")
                End If
                If flag <> 1 Then

                    'inset into tbl_PM_AssignedResources table 
                    If DateDiff("d", m_strRequestedEffectiveFromDate, strStartDate) = 0 Then
                        strSQL = "usp_Ins_tbl_PM_AssignedResourcesForChangeAllocation " + m_intRequestID.ToString + "," + strProjectID + ","
                        strSQL += m_intEmployeeID.ToString + ",'" + m_strRequestedEffectiveFromDate + "','" + m_strEndDate + "'," + m_strHours + "," + m_intProjectEmployeeRoleId.ToString + ",'L' "
                    ElseIf DateDiff("d", m_strRequestedEffectiveFromDate, Now.Date) = 0 Then

                        strSQL = "usp_Ins_tbl_PM_AssignedResourcesForChangeAllocation " + m_intRequestID.ToString + "," + strProjectID + ","
                        strSQL += m_intEmployeeID.ToString + ",'" + m_strRequestedEffectiveFromDate + "','" + m_strEndDate + "'," + m_strHours + "," + m_intProjectEmployeeRoleId.ToString + ",'L' "
                    Else
                        strSQL = "usp_Ins_tbl_PM_AssignedResourcesForChangeAllocation " + m_intRequestID.ToString + "," + strProjectID + ","
                        strSQL += m_intEmployeeID.ToString + ",'" + m_strRequestedEffectiveFromDate + "','" + m_strEndDate + "'," + m_strHours + "," + m_intProjectEmployeeRoleId.ToString + ",'A'"
                    End If
                    CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                    'update tbl_PM_ResourceRequest table
                    strSQL = "usp_Ins_tbl_PM_ChangeAllocationResourceRequest " + m_intRequestID.ToString + "," + strProjectID + ",'"
                    strSQL += m_strRequestedEffectiveFromDate + "','" + m_strEndDate + "',NULL,1," + m_strHours
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
                    strSQL += m_objGlobal.UserName + "'," + m_objGlobal.UserID.ToString + ",'" + strRequestType.ToString + "',NULL," + m_intProjectEmployeeRoleId.ToString + "," + "A" + "," + intResourcepoolID.ToString + "," + intRoleID.ToString + "," + "1,null,'C'"
                    'End Modification by SanaS on 14-Aug-2009
                    CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                    drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_get_resource_tbl_pm_resourcerequest " + strProjectID + ",'" + m_strEndDate + "'" + "," + m_intEmployeeID.ToString, MyBase.UseSQL)
                    If drProjectEmployeeRole.Read Then
                        intEmployeeid = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(drProjectEmployeeRole("employeeid"), "0"), "0"), Integer)
                    End If
                    If intEmployeeid <> 0 Then
                        Response.Write("<script language=javascript>" & vbCrLf)
                        Response.Write(" alert('You can not send request as he has planned task after Requested End Date'); ")
                        Response.Write("</script>")

                    Else

                        m_strScript = "window.close();" + vbCrLf
                        m_strScript &= "window.opener.location=window.opener.location;" + vbCrLf
                        m_strScript &= "window.open(""../General/SendEmail.aspx?MessageID=541&RequestID=" & m_intRequestID.ToString()
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

        'If mode is ADD then show the request end date , hours and priority as empty values
        If m_strMode = "ADD" Then
            If intRequestID = 0 Then
                If m_strStatus <> "A" Then
                    m_strRequestedEffectiveFromDate = ""
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
        'When Resource allocation workflow is not to be used.


        With ObjSectionTitle
            Response.Write(.GetSectionTitle(strLeftSectionTitle, strSectionTag, strFunctionName, , , , , ))
            Response.Write(System.Environment.NewLine + "<SCRIPT language=javascript>" + System.Environment.NewLine)
            Response.Write(.ClientsideScript())
            Response.Write(System.Environment.NewLine + "</SCRIPT>" + System.Environment.NewLine)
        End With

        If lngRegHours = 0 Then
            Dim drAllocationDetails As IDataReader
            drAllocationDetails = CommonFunctions.Data.GetDataReader("usp_sel_getOldAllocationDetails  " + m_intProjectEmployeeRoleId.ToString + "," + m_intRequestID.ToString, MyBase.UseSQL)
            If drAllocationDetails.Read Then
                If strRequestType.ToString = "HPD" Then

                    lngRegHours = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("ApprovedWorkHours"), "0"), Double)
                ElseIf strRequestType.ToString = "P" Then
                    lngRegHours = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("ApprovedPercentageAllocation"), "0"), Double)
                Else
                    lngRegHours = CType(CommonFunctions.General.CheckIsNothing(drAllocationDetails.Item("ApprovedTotalRequestedHrs"), "0"), Double)
                End If
            End If

            CommonFunction.Data.DisposeDataReader(drAllocationDetails)
        End If
        m_OldAllocation = lngRegHours
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
        If m_strStatus <> "A" Then
            Response.Write(strStartDate)
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtStartDate", "txtStartDate", , , , strStartDate, , , , , , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        Else
            Response.Write(m_strRequestedEffectiveFromDate)
        End If
        Response.Write("</TD>")
        Response.Write("<TD align=right><b>")
        Response.Write("Allocation End Date: </b>")
        Response.Write("</TD>")
        Response.Write("<TD>")
        If m_strStatus <> "A" Then
            Response.Write(strEndDate)
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", , , , strEndDate, , , , , , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
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
        If strRequestType.ToString = "TH" Then
            Response.Write("Total Hours")
        ElseIf strRequestType.ToString = "P" Then
            Response.Write("% Per Day")
        Else
            Response.Write("Hours Per Day")
        End If
        Response.Write("</td>")

        Response.Write("<TD align=right><b>")
        Response.Write("Allocation Value: </b>")
        Response.Write("</TD>")
        Response.Write("<TD>")
        If strRequestType = "P" Then
            Response.Write(lngRegHours.ToString + " %")
        ElseIf strRequestType = "HPD" Then
            Response.Write(lngRegHours.ToString + " Hrs/Day")
        Else
            Response.Write(lngRegHours.ToString)
        End If
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtReqWorkHours", "txtReqWorkHours", , , , lngRegHours.ToString, , , , , , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
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

        'Create object of the Section Title class from the Templates
        'Create second section
        ObjSectionTitle = New WebPages.Template.SectionTitle
        strLeftSectionTitle = "Change Allocation Details"
        strSectionTag = "divSection2"
        strFunctionName = "ShowHide_divSection2"
        If m_strStatus.Trim.ToUpper <> "A" Then



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
                    End If

                End If
                drAllocationDetails.Close()
                drAllocationDetails.Dispose()

                Response.Write("<table cellSpacing='0' class='clsTable' width='99.9%'>")
                Response.Write("<TR class='clsTREven'>")
                Response.Write("<TD align=right >")
                If strRequestType = "TH" Then
                    Response.Write("NEW " + MyBase.GetResourceString("WORK_HOURS") + " ")
                    Response.Write("</TD>")
                    Response.Write("<TD>")
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtNewAllocation", "txtNewAllocation", , , , mstrtotal.ToString, , , ToBeInserted:="onblur=""javascript:GetWorkHours()""", EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                ElseIf strRequestType = "P" Then
                    Response.Write("New % Of Day ")
                    Response.Write("</TD>")
                    Response.Write("<TD >")
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtNewAllocation", "txtNewAllocation", , , , mstrPercentageperday.ToString, , , ToBeInserted:="onblur=""javascript:GetWorkHours()""", EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                ElseIf strRequestType = "HPD" Then
                    Response.Write("New Hrs Per Day ")
                    Response.Write("</TD>")
                    Response.Write("<TD>")
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtNewAllocation", "txtNewAllocation", , , , mstrhrsperday.ToString, , , ToBeInserted:="onblur=""javascript:GetWorkHours()""", EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                End If
                Response.Write("</td>")
                Response.Write("<TD align=right>")
                Response.Write("Effective From Date")
                Response.Write("</TD>")
                Response.Write("<TD>")
                If strRequestType.ToUpper <> "TH" Then
                    Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtEffectiveFromDate", "txtEffectiveFromDate", , , m_strRequestedEffectiveFromDate, , "frmPM_ChangeAllocation", , , , , , , , True, ToBeInserted:="onblur=""javascript:GetWorkHours()"""))
                Else
                    Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtEffectiveFromDate", "txtEffectiveFromDate", , , m_strRequestedEffectiveFromDate, , "frmPM_ChangeAllocation", , , , , , , , True))
                End If


                Dim ProjectDate As String
                If strProjectID <> "0" Then

                    ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    ''strSQL = "select expectedenddate from tbl_PM_project where ProjectID= " & strProjectID
                    strSQL = "usp_sel_tbl_PM_project_ChangeAllocationType_expectedenddate " & strProjectID
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                Else
                    ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    ''strSQL = "select expectedenddate from tbl_PM_project where ProjectID= " & CType(HttpContext.Current.Session("intProjectID"), String)
                    strSQL = "usp_sel_tbl_PM_project_ChangeAllocationType_expectedenddate " & CType(HttpContext.Current.Session("intProjectID"), String)
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
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
                If intRequestID = 0 Then
                    m_strEndDate = strEndDate
                End If
                Dim CurrentDate As String
                CurrentDate = Date.Now().ToString("dd-MMM-yyyy")
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtCurrentDate", "txtCurrentDate", , , , CurrentDate, , , , , , True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtReqEndDate", "txtReqEndDate", , , , m_strEndDate, , , , , , True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                Response.Write("</TD>")
                Response.Write("</TR>")
                Response.Write("<TR class='clsTREven'>")
                If CommonFunctions.General.CheckIsNothing(m_strHours) <> "-1" Then

                    Response.Write("<TD align=right>")
                    Response.Write("New Work Hours: ")
                    Response.Write("</TD>")
                    Response.Write("<TD colspan=3><span id=TotalHrsSpan>")

                    'Response.Write(lngHours.ToString + "</span>")
                    Response.Write(m_strHours + "</span>")


                    If strRequestType <> "TH" Then
                        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtHours", "txtHours", , 60, 4, m_strHours, "right", , True, , , True, , EnableHTMLEncode:=True))
                        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Else
                        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtHours", "txtHours", , 60, 4, m_strHours, "right", , , , , True, EnableHTMLEncode:=True))
                        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    End If
                    Response.Write("</TD>")
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
                    m_strHours = mstrtotal
                End If
                drAllocationDetails.Close()
                drAllocationDetails.Dispose()

                Response.Write("<table cellSpacing='0' class='clsTable' width='99.9%'>")
                Response.Write("<TR class='clsTREven'>")
                Response.Write("<TD align=right>")
                If strRequestType = "TH" Then
                    Response.Write("NEW " + MyBase.GetResourceString("WORK_HOURS") + " ")
                    Response.Write("</TD>")
                    Response.Write("<TD>")
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtNewAllocation", "txtNewAllocation", , , , mstrtotal.ToString, , , True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                ElseIf strRequestType = "P" Then
                    Response.Write("New % Of Day ")
                    Response.Write("</TD>")
                    Response.Write("<TD>")
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtNewAllocation", "txtNewAllocation", , , , mstrPercentageperday.ToString, , , True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                ElseIf strRequestType = "HPD" Then
                    Response.Write("New Hrs Per Day ")
                    Response.Write("</TD>")
                    Response.Write("<TD>")
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtNewAllocation", "txtNewAllocation", , , , mstrhrsperday.ToString, , , True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                End If
                Response.Write("</TD>")

                Response.Write("<TD align=right>")
                Response.Write("Effective From Date")
                Response.Write("</TD>")
                Response.Write("<TD>")
                Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtEffectiveFromDate", "txtEffectiveFromDate", , , m_strRequestedEffectiveFromDate, , "frmPM_ChangeAllocation", , , , True, , , , True))

                Dim ProjectDate As String
                If strProjectID <> "0" Then
                    ''''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    ''strSQL = "select expectedenddate from tbl_PM_project where ProjectID= " & strProjectID
                    strSQL = "usp_sel_tbl_PM_project_ChangeAllocationType_expectedenddate " & strProjectID
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                Else
                    ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    ''strSQL = "select expectedenddate from tbl_PM_project where ProjectID= " & CType(HttpContext.Current.Session("intProjectID"), String)
                    strSQL = "usp_sel_tbl_PM_project_ChangeAllocationType_expectedenddate " & CType(HttpContext.Current.Session("intProjectID"), String)
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
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
                If intRequestID = 0 Then
                    m_strEndDate = strEndDate
                End If
                Dim CurrentDate As String
                CurrentDate = Date.Now().ToString("dd-MMM-yyyy")
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtCurrentDate", "txtCurrentDate", , , , CurrentDate, , , , , , True, EnableHTMLEncode:=True))
                Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtReqEndDate", "txtReqEndDate", , , , m_strEndDate, , , , , , True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                Response.Write("</TD>")
                Response.Write("</TR>")
                Response.Write("<TR class='clsTREven'>")
                If CommonFunctions.General.CheckIsNothing(m_strHours) <> "-1" Then

                    Response.Write("<TD align=right>")
                    Response.Write("New Work Hours: ")
                    Response.Write("</TD>")
                    Response.Write("<TD colspan=3><span id=TotalHrsSpan>")
                    Response.Write(m_strHours + "</span>")
                    If strRequestType <> "TH" Then
                        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtHours", "txtHours", , 60, 4, m_strHours, "right", , , , , True, , , EnableHTMLEncode:=True))
                        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Else
                        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtHours", "txtHours", , 60, 4, m_strHours, "right", , , , , True, , , , EnableHTMLEncode:=True))
                        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encodings
                    End If
                    Response.Write("</TD>")
                End If

            End If
            Response.Write("</TR>")
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
        ' Author                : SanaS
        ' Created               : Aug 29, 2009  
        ' Revisions             :
        '=====================================================================

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        '' m_StdAllocationPercentage = CType(CommonFunctions.Data.GetDataScalar("SELECT IsNull(SettingValue,100) FROM tbl_sem_settings WHERE SettingName='RESOURCE_ALLOCATION'", MyBase.UseSQL), Long)
        m_StdAllocationPercentage = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_sem_settings_SettingValue", MyBase.UseSQL), Long)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        'This will initialize all the global objects.
        GetGlobalObject()
        'This will strore the constructed menu string in a string variable.   
        'To get Data for Plotting Screen
        InitializeData()
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

    Private Sub WithoutWorkFlowAssign()
        Dim m_dblNewallocation As Double = 0
        Dim dblstrHours1 As Double
        Dim m_strerr As String
        Dim strsql As String
        Dim strStartDate As String
        Dim strProjectid As String

        Dim intResourcepoolID As Integer = 0

        Dim m_strScript As String
        strProjectid = m_objGlobal.ProjectID.ToString()
        m_strRequestedEffectiveFromDate = MyBase.GetFormValue("txtEffectiveFromDate")

        m_strEndDate = MyBase.GetFormValue("txtReqEndDate")
        strStartDate = MyBase.GetFormValue("txtStartDate")
        m_strHours = MyBase.GetFormValue("txtHours")
        dblstrHours1 = CType(m_strHours, Double)
        m_intPriority = 0
        m_strSpecialRequest = CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtRequest"), " ").ToString)
        m_dblNewallocation = CType(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtNewAllocation"), "0"), Double)



        If DateDiff("d", m_strRequestedEffectiveFromDate, strStartDate) = 0 Then
            strsql = "usp_Ins_tbl_PM_AssignedResourcesForChangeAllocation " + m_intRequestID.ToString + "," + strProjectid + ","
            strsql += m_intEmployeeID.ToString + ",'" + m_strRequestedEffectiveFromDate + "','" + m_strEndDate + "'," + m_strHours + "," + m_intProjectEmployeeRoleId.ToString + ",'L' "
        ElseIf DateDiff("d", m_strRequestedEffectiveFromDate, Now.Date) = 0 Then

            strsql = "usp_Ins_tbl_PM_AssignedResourcesForChangeAllocation " + m_intRequestID.ToString + "," + strProjectid + ","
            strsql += m_intEmployeeID.ToString + ",'" + m_strRequestedEffectiveFromDate + "','" + m_strEndDate + "'," + m_strHours + "," + m_intProjectEmployeeRoleId.ToString + ",'L' "
        Else

            strsql = "usp_Ins_tbl_PM_AssignedResourcesForChangeAllocation " + m_intRequestID.ToString + "," + strProjectid + ","
            strsql += m_intEmployeeID.ToString + ",'" + m_strRequestedEffectiveFromDate + "','" + m_strEndDate + "'," + m_strHours + "," + m_intProjectEmployeeRoleId.ToString + ",'A'"
        End If
        CommonFunction.Data.InsertOrUpdateData(strsql, MyBase.UseSQL)


        strsql = "usp_Ins_tbl_PM_ChangeAllocationResourceRequest " + m_intRequestID.ToString + "," + strProjectid + ",'"
        strsql += m_strRequestedEffectiveFromDate + "','" + m_strEndDate + "',NULL,1," + m_strHours
        If m_strSpecialRequest = "" Then
            strsql += ",NULL"
        Else
            strsql += ",'" + m_strSpecialRequest + "'"
        End If

        strsql += ",NULL,'"
        strsql += m_objGlobal.UserName + "'," + m_objGlobal.UserID.ToString + ",'" + strRequestType.ToString + "',NULL," + m_intProjectEmployeeRoleId.ToString + "," + "A" + "," + intResourcepoolID.ToString + "," + intRoleID.ToString + "," + "1,null,'C'"

        CommonFunction.Data.InsertOrUpdateData(strsql, MyBase.UseSQL)

        m_strScript = "<script type='text/javascript'>"
        m_strScript &= "window.close();" + vbCrLf
        m_strScript &= "window.opener.location=window.opener.location;" + vbCrLf
        m_strScript &= "</script>;" + vbCrLf
        Response.Write(m_strScript)

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
        m_strRequestedEffectiveFromDate = ""
        m_strSpecialRequest = ""
        m_strHours = ""

        m_strMode = Request.QueryString("Mode").ToUpper
        m_strRequestedEffectiveFromDate = MyBase.GetFormValue("txtEffectiveFromDate")
        m_strSpecialRequest = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtRequest"), "").ToString
        m_strHours = MyBase.GetFormValue("txtHours")
       

        'this code is executed for assigned resource request.
        '  m_intPriority = CType(CommonFunction.General.CheckIsNothing("0" + MyBase.GetFormValue("cboPriority"), "0"), Integer)
        m_intPriority = 0
        If Not IsPostBack Then
            m_intRequestID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RequestID"), "0"), Integer)
            If m_intRequestID <> 0 Then
                drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ResourceRequest_ChangeAllocationType NULL," + m_intRequestID.ToString, MyBase.UseSQL)
                If drProjectEmployeeRole.Read Then
                    m_strStatus = drProjectEmployeeRole("Status").ToString
                End If
                CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)
            End If

            MyBase.InitializeResources("AppResources.PM_ExtendBooking", "AppResources")
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
            ElseIf m_RequestType <> "C" Then
                If Args.MenuColIndex = 3 Then
                    Cancel = True
                End If
            End If
            'Commented by SanaS on 14-Sep-2009 to allow cancel functionality in without workflow
            ''added by RohiniK on 8 Sep 09 to hide Cancel link
            'If m_IsProjectResourceAllocation = True Then
            '    If Args.MenuColIndex = 3 Then
            '        Cancel = True
            '    End If
            'End If
            ''End of addition by RohiniK on 8 Sep 09 to hide Cancel link
            'End Comment by SanaS on 14-Sep-2009 to allow cancel functionality in without workflow
        Else
            'for add or save mode hide the Assign and Reject Request link
            If m_strMode = "ADD" Or m_strMode = "SAVE" Then
                If Args.MenuColIndex = 1 Or Args.MenuColIndex = 2 Or Args.MenuColIndex = 3 Then
                    Cancel = True
                End If
            End If
            'For ASSIGN,ASSIGNSAVE,ASSIGNCONFIRM mode hide save link
            If m_strMode = "ASSIGN" Or m_strMode = "ASSIGNSAVE" Then
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
