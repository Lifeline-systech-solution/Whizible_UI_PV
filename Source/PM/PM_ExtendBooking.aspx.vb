#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class PM_ExtendBooking
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
    Protected m_strRequestedStartDate As String
    Protected m_strRequestedEndDate As String
    Protected m_strRequestDate As String
    'Added by TruptiK on 13-Feb-09
    'Purpose:-ThirdWare Change of Resource Allocation Percentage.
    Protected m_StrFromDate As String
    'End of addition by TruptiK
    Protected m_strHours As String
    'Integrated By SanaS on 24-Sep-2009
    Protected m_strMaxUnits As String

    Private m_dblWorkHrsPerDay As Double
    Private m_dblTotalWorkHrs As Double
    Private m_dblPercentage As Double

    Protected m_dblPrevWorkHrsPerDay As Double
    Protected m_dblPrevTotalWorkHrs As Double
    Protected m_dblPrevPercentage As Double
    'End Integrated By SanaS on 24-Sep-2009
    Protected m_intPriority As Integer
    Protected m_strSpecialRequest As String
    Protected m_intRequestID As Integer
    Protected m_strMode As String
    Protected m_strScript As String
    Protected m_intEmployeeID As Integer
    Protected m_strStatus As String = ""
    Protected m_RequestType As String
    'Integrated By SanaS on 24-Sep-2009
    Protected m_strType As String
    'Protected m_dblPrevUnit, m_dblNewUnit, m_dblTotalWorkHours As Double

    Private blnIsDisabled As Boolean = False
    Private blnIsReadOnly As Boolean = False

    Private strCurrentStartDate As String
    Private strCurrentEndDate As String
    Private strCurrentResourcePercentage As String
    Private dblCurrentHours As Double

    Private m_blnEnableResourceAllocation As Boolean = False
    Private blnIsOverAllocation As Boolean = False

    Private strEmployeeName As String
    Private strProjectID As String = "0"
    Protected intRequestID As Integer
    Private m_dblFreeHours As Double = 0
    Private lngBalanceHours As Long
    Private intRoleID As Integer
    Dim intResourcepoolID As Integer

    Protected m_lngTagId As Long = 0
    'End Integrated By SanaS on 24-Sep-2009
    Protected WithEvents frmPM_ExtendBooking As System.Web.UI.HtmlControls.HtmlForm

    Private Enum MenuIndex
        SAVE
        REJECTREQUEST
        ASSIGN
        CANCEL
        CLOSE
        HELP
    End Enum

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

    Private Sub PlotPage()
        '====================================================================
        ' Procedure Name        :PlotPage
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               :To plot the page
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : GaneshG
        ' Created               : 
        ' Revisions             :Integrated from WhizibleSEM8 by SanaS on 24-Sep-2009
        '=====================================================================
        'This will strore the constructed menu string in a string variable.   
        DrawMenu()

        CommonFunctions.General.WriteHTML(strMenu)

        'Display the page legend
        WritePageLegend()

        'Display the page caption.
        DrawPageCaption()

        'Display the Header if exist. 
        DrawHeader()

        'Commented and added By Bharat T on 16th-oct-2015
        'Response.Write("<DIV Id= 'PageDiv' Style='Width:100%;OverFlow:auto'>")
        Response.Write("<DIV Id= 'PageDiv' Style='Width:100%;OverFlow:auto;height:400px'>")
        'End of Commented and added By Bharat T on 16th-oct-2015

        PlotCurrentDetailsSection()

        If m_RequestType = "E" Or m_RequestType = "" Then
            PlotExtendRequestDetails()
        End If


        Response.Write("</DIV>")

        Response.Write("<BR>")

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

    End Sub

    Private Sub AssignConfirm()
        '====================================================================
        ' Procedure Name        :AssignConfirm
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               :To save the data after Allocator approves the request
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : GaneshG
        ' Created               : 
        ' Revisions             :Integrated from WhizibleSEM8 by SanaS on 24-Sep-2009
        '=====================================================================
        Dim flag1 As Integer = 0
        Dim dblstrHours1 As Double
        Dim drProjectEmployeeRole As IDataReader
        Dim drProjectEmployeeRole1 As IDataReader
        Dim dblMinAvailablePerDayHrs As Double = 0
        Dim dblMinAvailablePercentage As Double = 0


        dblstrHours1 = m_dblTotalWorkHrs

        drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_Sel_GetResourceBalanceHours '" + m_strRequestedStartDate + "','" + m_strRequestedEndDate + "'" + "," + m_intEmployeeID.ToString, MyBase.UseSQL)

        If drProjectEmployeeRole.Read Then
            lngBalanceHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("BalanceHours"), "0"), Long)
        End If

        CommonFunctions.Data.DisposeDataReader(drProjectEmployeeRole)
        'if balance hours are less than the hours enter by user the give the warning  


        ''Added by TruptiK on 13-Feb-09
        ''Purpose:-To add validation for Freehours.(ThirdWare)

        'Integrated Changes By GaneshG on 11-Aug-09
        drProjectEmployeeRole1 = CommonFunction.Data.GetDataReader("usp_sel_FreeHours_ExtendBooking '" + m_strRequestedStartDate + "','" + m_strRequestedEndDate + "'" + "," + m_intEmployeeID.ToString + "," + strProjectID.ToString, MyBase.UseSQL)
        'End Integration By GaneshG

        If drProjectEmployeeRole1.Read Then
            m_dblFreeHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole1("FreeHours"), "0"), Double)
            dblMinAvailablePerDayHrs = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole1("MinAvailablePerDayHrs"), "0"), Double)
            dblMinAvailablePercentage = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole1("MinAvailablePercentage"), "0"), Double)
        End If

        CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole1)
       


        If m_strType = "P" Then
            If m_dblPercentage > dblMinAvailablePercentage Then
                flag1 = 1
                Response.Write("<script language=javascript>")
                Response.Write("alert('Resource available percentage ( " + dblMinAvailablePercentage.ToString + "%) is less than the requested.');" + vbCrLf)
                Response.Write("</script>")

            End If
        ElseIf m_strType = "HPD" Then
            If m_dblWorkHrsPerDay > dblMinAvailablePerDayHrs Then
                flag1 = 1
                Response.Write("<script language=javascript>")
                Response.Write("alert('Resource available work hours per day (" + dblMinAvailablePerDayHrs.ToString + ") are less than the requested.');" + vbCrLf)
                Response.Write("</script>")

            End If
        Else
            If m_dblFreeHours < dblstrHours1 Then
                'm_strScript = "<script language=javascript>"
                'm_strScript += "alert('Free Hrs are less');" + vbCrLf
                'm_strScript += "</script>"
                flag1 = 1
                '    'CommonFunctions.General.WriteHTML(m_strScript)
                Response.Write("<script language=javascript>")
                Response.Write("alert('Resource Free Hrs are less than the hours you are assigning him/her for project');" + vbCrLf)
                Response.Write("</script>")
            End If
        End If
        If flag1 = 0 Then
            If lngBalanceHours < CType(CommonFunction.General.CheckIsNothing(m_strHours, "0"), Long) Then
                m_strScript = "if (confirm('" + MyBase.GetResourceString("BALANCE_HOURS_MESSAGE") + "'))" + vbCrLf
                m_strScript += "{objform.action = ""../PM/PM_ExtendBooking.aspx?MODE=AssignSave&RequestID=""+ " + m_intRequestID.ToString + ";" + vbCrLf
                m_strScript += "objform.submit();}"
            Else
                m_strScript = "objform.action = ""../PM/PM_ExtendBooking.aspx?MODE=AssignSave&RequestID=""+ " + m_intRequestID.ToString + ";" + vbCrLf
                m_strScript += "objform.submit();"
            End If
        End If

    End Sub

    Private Sub AssignSave()
        '====================================================================
        ' Procedure Name        :AssignSave
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               :To save the data after confirmation
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : GaneshG
        ' Created               : 
        ' Revisions             :Integrated from WhizibleSEM8 by SanaS on 24-Sep-2009
        '=====================================================================
        Dim strSQL As String

        'm_strHours = MyBase.GetFormValue("txtTotalWorkHours")


        'inset into tbl_PM_AssignedResources table 
        strSQL = "usp_Ins_tbl_PM_AssignedResourcesForExtendBooking " + m_intRequestID.ToString + "," + strProjectID.ToString + ","
        strSQL += m_intEmployeeID.ToString + ",'" + m_strRequestedStartDate + "','" + m_strRequestedEndDate + "'," + m_dblWorkHrsPerDay.ToString + "," + m_dblTotalWorkHrs.ToString + "," + m_dblPercentage.ToString
        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        'update tbl_PM_ResourceRequest table
        strSQL = "usp_Ins_tbl_PM_ResourceRequest " + m_intRequestID.ToString + "," + strProjectID.ToString.ToString + ",'"
        strSQL += m_strRequestedStartDate + "','" + m_strRequestedEndDate + "',NULL,1," + m_dblWorkHrsPerDay.ToString
        If m_strSpecialRequest = "" Then
            strSQL += ",NULL"
        Else
            strSQL += ",'" + m_strSpecialRequest + "'"
        End If

        strSQL += "," + m_intPriority.ToString + ",'"


        'Integrated Changes By GaneshG on 11-Aug-09
        'Purpose :  Page crash occurs if the User name of the employee has Single quote in it for Approving the Extend Booking request 

        strSQL += CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) + "'," + m_objGlobal.UserID.ToString + ",'" + m_strType + "',NULL," + m_intProjectEmployeeRoleId.ToString + "," + "A" + "," + intResourcepoolID.ToString + "," + intRoleID.ToString
        'End Integration By GaneshG

        strSQL += ", NULL, NULL, " & m_dblTotalWorkHrs.ToString & "," & m_dblPercentage.ToString

        If m_blnEnableResourceAllocation = True Then
            strSQL += ",1"
        End If

        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        m_strScript = "window.close();" + vbCrLf
        m_strScript &= "window.opener.location=window.opener.location;" + vbCrLf

        If m_blnEnableResourceAllocation = False Then
            m_strScript &= "window.open(""../General/SendEmail.aspx?MessageID=502&RequestID=" & m_intRequestID.ToString()
            m_strScript &= "&EmployeeIDS=" & m_intEmployeeID.ToString & """ ,'',"
            m_strScript &= "'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left='"
            m_strScript &= " + (window.screen.width - 600)/2 + ',top='"
            m_strScript &= " + (window.screen.height - 500)/2 + ',width=600,height=500')" & vbCrLf
        End If

    End Sub

    Private Sub Get_Approved_Or_Requested_RequestDetails()
        '====================================================================
        ' Procedure Name        :Get_Approved_Or_Requested_RequestDetails
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               :To get the resource details
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : GaneshG
        ' Created               : 
        ' Revisions             :Integrated from WhizibleSEM8 by SanaS on 24-Sep-2009
        '=====================================================================
        'Added By GaneshG On 19-Aug-09 
        'Purpose: Get previous allocation details
        Dim drOldAllocationDetails As IDataReader
        Dim strSQL As String

        strSQL = "usp_sel_getOldAllocationDetails " & m_intProjectEmployeeRoleId.ToString

        If intRequestID <> 0 Then
            strSQL += "," & intRequestID.ToString
        End If

        drOldAllocationDetails = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If drOldAllocationDetails.Read Then
            If intRequestID <> 0 Then
                m_dblPrevWorkHrsPerDay = CType(CommonFunction.Data.CheckIsDBNull(drOldAllocationDetails("ApprovedWorkHours"), "0"), Double)
                m_dblPrevTotalWorkHrs = CType(CommonFunction.Data.CheckIsDBNull(drOldAllocationDetails("ApprovedTotalRequestedHrs"), "0"), Double)
                m_dblPrevPercentage = CType(CommonFunction.Data.CheckIsDBNull(drOldAllocationDetails("ApprovedPercentageAllocation"), "0"), Double)
            Else
                m_dblPrevWorkHrsPerDay = CType(CommonFunction.Data.CheckIsDBNull(drOldAllocationDetails("WorkHours"), "0"), Double)
                m_dblPrevTotalWorkHrs = CType(CommonFunction.Data.CheckIsDBNull(drOldAllocationDetails("TotalRequestedHrs"), "0"), Double)
                m_dblPrevPercentage = CType(CommonFunction.Data.CheckIsDBNull(drOldAllocationDetails("PercentageAllocation"), "0"), Double)
                
                Select Case m_strType.ToUpper
                    Case "TH"
                        m_dblTotalWorkHrs = m_dblPrevTotalWorkHrs
                    Case "HPD"
                        m_dblWorkHrsPerDay = m_dblPrevWorkHrsPerDay
                    Case "P"
                        m_dblPercentage = m_dblPrevPercentage
                End Select

            End If
        End If

        CommonFunction.Data.DisposeDataReader(drOldAllocationDetails)
        'End Addition By GaneshG
    End Sub

    Private Sub SaveAllocationDetails()
        '====================================================================
        ' Procedure Name        :SaveAllocationDetails
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               :To save the extend request details at the time of submission
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : GaneshG
        ' Created               : 
        ' Revisions             :Integrated from WhizibleSEM8 by SanaS on 24-Sep-2009
        '=====================================================================
   
        Dim flag As Integer
        Dim dblstrHours1 As Double
        Dim dblMinAvailablePerDayHrs As Double = 0
        Dim dblMinAvailablePercentage As Double = 0
        Dim strAlertScript As String
        Dim strSQL As String = ""
        Dim drProjectEmployeeRole As IDataReader

        m_strRequestedStartDate = MyBase.GetFormValue("txtReqStartDate")
        m_strRequestedEndDate = MyBase.GetFormValue("txtReqEndDate")

        m_strSpecialRequest = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtRequest"), "")
        m_intPriority = CType(CommonFunction.General.CheckIsNothing("0" + MyBase.GetFormValue("cboPriority"), "0"), Integer)

        If m_strType = "HPD" Then
            m_dblWorkHrsPerDay = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txt_New_Units"))
            m_dblPercentage = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtPercentage"))
            m_dblTotalWorkHrs = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtTotalWorkHours"))
        ElseIf m_strType = "TH" Then
            m_dblTotalWorkHrs = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txt_New_Units"))
            m_dblPercentage = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtPercentage"))
            m_dblWorkHrsPerDay = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtWorkHrsPerDay"))
        ElseIf m_strType = "P" Then
            m_dblPercentage = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txt_New_Units"))
            m_dblTotalWorkHrs = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtTotalWorkHours"))
            m_dblWorkHrsPerDay = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtWorkHrsPerDay"))
        End If

        drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_sel_FreeHours_ExtendBooking '" + m_strRequestedStartDate + "','" + m_strRequestedEndDate + "'" + "," + m_intEmployeeID.ToString + "," + CType(HttpContext.Current.Session("intProjectID"), String), MyBase.UseSQL)

        If drProjectEmployeeRole.Read Then
            m_dblFreeHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("FreeHours"), "0"), Double)
            dblMinAvailablePerDayHrs = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("MinAvailablePerDayHrs"), "0"), Double)
            dblMinAvailablePercentage = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("MinAvailablePercentage"), "0"), Double)
        End If

        CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)

        If m_strType = "P" Then
            If m_dblPercentage > dblMinAvailablePercentage Then
                flag = 1
                strAlertScript = strAlertScript + "Resource available percentage ( " + dblMinAvailablePercentage.ToString + "%) is less than the requested."
            End If
        ElseIf m_strType = "HPD" Then
            If m_dblWorkHrsPerDay > dblMinAvailablePerDayHrs Then
                flag = 1
                strAlertScript = strAlertScript + "Resource available work hours per day (" + dblMinAvailablePerDayHrs.ToString + ") are less than the requested. "
            End If
        End If

        If flag = 1 Then
            blnIsOverAllocation = True
            Response.Write("<script language=javascript>")
            Response.Write("alert('" & strAlertScript & "');" & vbCrLf)
            Response.Write("</script>")
        End If


        If flag <> 1 Then
            If intRequestID <> 0 Then
                strSQL = "usp_Ins_tbl_PM_ResourceRequest " + intRequestID.ToString + "," + m_objGlobal.ProjectID.ToString + ",'"
                strSQL += m_strRequestedStartDate + "','" + m_strRequestedEndDate + "',NULL,1," + m_dblWorkHrsPerDay.ToString
                 strSQL += ",'" + CommonFunction.General.BuildQueryString(m_strSpecialRequest) + "'"
                strSQL += "," + m_intPriority.ToString + ",'"

                'Integrated Changes By GaneshG on 11-Aug-09
                strSQL += CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) + "'," + m_objGlobal.UserID.ToString + ",'" + m_strType + "',NULL," + m_intProjectEmployeeRoleId.ToString + "," + "R" + "," + intResourcepoolID.ToString + "," + intRoleID.ToString + ",null,'E'"
                'End Integration By GaneshG

                strSQL += "," & m_dblTotalWorkHrs.ToString & "," & m_dblPercentage.ToString

                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            Else
                strSQL = "usp_Ins_tbl_PM_ResourceRequest  NULL," + m_objGlobal.ProjectID.ToString + ",'"
                strSQL += m_strRequestedStartDate + "','" + m_strRequestedEndDate + "',NULL,1," + m_dblWorkHrsPerDay.ToString

                strSQL += ",'" + CommonFunction.General.BuildQueryString(m_strSpecialRequest) + "'"
                strSQL += "," + m_intPriority.ToString + ",'"

                'Added by SanaS on 14-Aug-2009
                'Integrated Changes By GaneshG on 11-Aug-09
                'Modified by SanaS on 14-Aug-2009
                'strSQL += CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) + "'," + m_objGlobal.UserID.ToString + ",'HPD',NULL," + m_intProjectEmployeeRoleId.ToString + "," + "R" + "," + intResourcepoolID.ToString + "," + intRoleID.ToString + ",null,'E'"
                strSQL += CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) + "'," + m_objGlobal.UserID.ToString + ",'" + m_strType + "',NULL," + m_intProjectEmployeeRoleId.ToString + "," + "R" + "," + intResourcepoolID.ToString + "," + intRoleID.ToString + ",null,'E'"
                'End Modification by SanaS on 14-Aug-2009
                'End Integration By GaneshG

                strSQL += "," & m_dblTotalWorkHrs.ToString & "," & m_dblPercentage.ToString


                m_intRequestID = CType(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), String)

            End If


            If intRequestID = 0 And m_blnEnableResourceAllocation = False Then
                m_strScript = "window.close();" + vbCrLf
                m_strScript += "window.opener.location=window.opener.location;"
                'write client side script to display the message window

                m_strScript += "window.open('../General/SendEmail.aspx?MessageID=80&ResourceRequestID=" + m_intRequestID.ToString + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');"
            Else
                m_strScript = "window.close();"

            End If
        End If

    End Sub

    Private Sub PlotExtendRequestDetails()
        '====================================================================
        ' Procedure Name        :PlotExtendRequestDetails
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               :To plot extend request details of resource
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : GaneshG
        ' Created               : 
        ' Revisions             :Integrated from WhizibleSEM8 by SanaS on 24-Sep-2009
        '=====================================================================
        Dim ObjSectionTitle As New WebPages.Template.SectionTitle
        Dim strLeftSectionTitle As String
        Dim strSectionTag As String
        Dim strFunctionName As String

        Dim strDisabled As String = ""

        If m_strStatus.ToUpper <> "A" Or (m_strStatus.ToUpper = "A" And m_strMode.ToUpper = "ADD") Then

            strLeftSectionTitle = MyBase.GetResourceString("EXTEND_REQUEST")
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

            Response.Write("<table cellSpacing='0' class='clsTable' width='99.9%'>")
            Response.Write("<TR class='clsTREven'>")
            Response.Write("<TD align=right>")
            Response.Write("New End Date")
            Response.Write("</TD>")

            Response.Write("<TD colspan=3>")
            Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtReqEndDate", "txtReqEndDate", , , m_strRequestedEndDate, , "frmPM_ExtendBooking", , , , blnIsDisabled, , , , True, , ToBeInserted:="onblur=""javascript:GetAllocationDetails()"""))

            'Modified By PrachiK on 10 Mar 2005 for Issue ID=15907. 
            'Purpose: Puting Project end date into hidden field for red date validation

            Dim ProjectDate As String


            Dim strSQL As String

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
            'End Addition
            Response.Write("</TD>")
            Response.Write("</TR>")

            Response.Write("<TR class='clsTREven'>")
            Response.Write("<TD>&nbsp</TD>")
            Response.Write("<TD colspan=3>")
            Response.Write("<b>If you want to change allocation, please enter following details</b>")
            Response.Write("</TD>")
            Response.Write("</TR>")

            Response.Write("<TR class='clsTREven'>")
            Response.Write("<TD align=right>")
            Response.Write("New Allocation")
            Response.Write("</TD>")
            Response.Write("<TD>")

            Select Case m_strType.ToUpper

                Case "TH"
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txt_New_Units", "txt_New_Units", , 60, 4, m_dblTotalWorkHrs.ToString, "right", , blnIsDisabled, , , , "onblur=""javascript:GetAllocationDetails()""", , True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(" Hrs")

                Case "HPD"
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txt_New_Units", "txt_New_Units", , 60, 4, m_dblWorkHrsPerDay.ToString, "right", , blnIsDisabled, , , , "onblur=""javascript:GetAllocationDetails()""", , True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(" Hrs/Day")

                Case "P"
                    'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txt_New_Units", "txt_New_Units", , 60, 4, m_dblPercentage.ToString, "right", , blnIsDisabled, , , , "onblur=""javascript:GetAllocationDetails()""", , True, EnableHTMLEncode:=True))
                    'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    Response.Write(" %")

            End Select

            Response.Write("</TD>")
            Response.Write("<TD align=right>")
            Response.Write("New Effective Date ")
            Response.Write("</TD>")
            Response.Write("<TD>")
            Response.Write(CommonFunction.HTMLControls.DrawDateControl("txtReqStartDate", "txtReqStartDate", , , m_strRequestedStartDate, , "frmPM_ExtendBooking", , , , blnIsDisabled, , , , True, , ToBeInserted:="onblur=""javascript:GetAllocationDetails()"""))
            Response.Write("</TD>")
            Response.Write("</TR>")
            Response.Write("<TR class='clsTREven'>")
            Response.Write("<TD align=right>")
            Response.Write("New Total Work Hours:")
            Response.Write("</TD>")
            Response.Write("<TD colspan=3>")

            If m_strType.ToUpper = "HPD" Or m_strType.ToUpper = "P" Then
                'Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtTotalWorkHours", "txtTotalWorkHours", , 60, 4, m_dblTotalWorkHrs.ToString, "right", , blnIsDisabled, blnIsReadOnly))
                Response.Write("<span id='SpanTotalWorkHours'>" & m_dblTotalWorkHrs.ToString & "</span>")
            End If
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtTotalWorkHours", "txtTotalWorkHours", , 60, 4, m_dblTotalWorkHrs.ToString, "right", IsHidden:=True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Response.Write("</TD>")
            Response.Write("</TR>")
            Response.Write("<TR class='clsTREven'>")
            Response.Write("<TD align=right valign=top>")
            Response.Write(MyBase.GetResourceString("SPECIAL_REQUEST") + " ")
            Response.Write("</TD>")
            Response.Write("<TD colspan=3>")
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'Response.Write(CommonFunction.HTMLControls.DrawTextArea("txtRequest", "txtRequest", , , , , , , 300, 100, 300, m_strSpecialRequest, , , , , , , strDisabled))
            Response.Write(CommonFunction.HTMLControls.DrawTextArea("txtRequest", "txtRequest", , , , , , , 300, 100, 300, m_strSpecialRequest, , , , , , , strDisabled, EnableHTMLEncode:=True))
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            Response.Write("</TD>")
            Response.Write("</TR>")

            ''Plot Hidden Controls
            Response.Write("<TR class='clsTREven'>")
            Response.Write("<TD>")
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtPercentage", "txtPercentage", , 60, 4, m_dblPercentage.ToString, "right", IsHidden:=True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Response.Write("</TD>")
            Response.Write("<TD colspan=3>")
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtWorkHrsPerDay", "txtWorkHrsPerDay", , 60, 4, m_dblWorkHrsPerDay.ToString, "right", IsHidden:=True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Response.Write("</TD>")
            Response.Write("</TR>")

            Response.Write("</table>")

            'System.Web.HttpContext.Current.Response.Write("</DIV>")

            HttpContext.Current.Response.Write("</DIV>")
        End If
    End Sub

    Private Sub PlotCurrentDetailsSection()
        '====================================================================
        ' Procedure Name        :PlotCurrentDetailsSection
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               :To plot current allocation details of resource
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : GaneshG
        ' Created               : 
        ' Revisions             :Integrated from WhizibleSEM8 by SanaS on 24-Sep-2009
        '=====================================================================
        Dim ObjSectionTitle As New WebPages.Template.SectionTitle
        Dim strLeftSectionTitle As String
        Dim strSectionTag As String
        Dim strFunctionName As String

        'Create object of the Section Title class from the Templates
        'create first section

        strLeftSectionTitle = MyBase.GetResourceString("CURRENT_DETAIL")
        strSectionTag = "divSection1"
        strFunctionName = "ShowHide_divSection1"

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
        Response.Write("<TD align=right>")
        Response.Write("<b>" & MyBase.GetResourceString("EMP_NAME") & ": </b>")
        Response.Write("</TD>")
        Response.Write("<TD colspan=3>")
        Response.Write(strEmployeeName)
        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtEmpName", "txtEmpName", , , , strEmployeeName, , , True))
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtEmpID", "txtEmpID", , , , m_intEmployeeID.ToString, , , , , , True, , , , , , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        Response.Write("</TD>")
        Response.Write("</TR>")

        Response.Write("<TR class='clsTREven'>")
        Response.Write("<TD align=right>") 'width='20%'
        Response.Write("<b>Allocation Start Date: </b>")
        Response.Write("</TD>")
        Response.Write("<TD>") 'width='30%'
        'UnCommented by SanaS on 17-Sep-2009 as Validation was not getting through 
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtStartDate", "txtStartDate", , , , strCurrentStartDate, , , False, , , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        'End UnComment by SanaS on 17-Sep-2009 as Validation was not getting through 
        Response.Write(strCurrentStartDate)
        Response.Write("</TD>")
        'Response.Write("</TR>")
        'Response.Write("<TR class='clsTREven'>")
        Response.Write("<TD align=right>") 'width='20%'
        'Response.Write(MyBase.GetResourceString("END_DATE"))
        Response.Write("<b>Allocation End Date: </b>")
        Response.Write("</TD>")
        Response.Write("<TD >") 'width=30% 
        'UnCommented by SanaS on 17-Sep-2009 as Validation was not getting through 
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", , , , strCurrentEndDate, , , False, , , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        'End UnComment by SanaS on 17-Sep-2009 as Validation was not getting through 
        Response.Write(strCurrentEndDate)
        Response.Write("</TD>")
        Response.Write("</TR>")

        'Added By GaneshG On 18-Aug-09
        Dim strTypeDescription As String

        Select Case m_strType.ToUpper
            Case "TH"
                strTypeDescription = "Total Hours"
            Case "P"
                strTypeDescription = "% Of Day"
            Case "HPD"
                strTypeDescription = "Per Day"
        End Select
        'End Addition By GaneshG

        Response.Write("<TR class='clsTREven'>")
        Response.Write("<TD align=right>")
        Response.Write("<b>Allocation Type: </b>")
        Response.Write("</TD>")
        Response.Write("<TD>")
        Response.Write(strTypeDescription)
        Response.Write("</TD>")
        Response.Write("<TD align=right>")
        Response.Write("<b>Allocation Value: </b>")
        Response.Write("</TD>")
        Response.Write("<TD>")
        Select Case m_strType.ToUpper
            Case "TH"
                Response.Write(m_dblPrevTotalWorkHrs.ToString & " Hrs")
            Case "HPD"
                Response.Write(m_dblPrevWorkHrsPerDay.ToString & " Hrs/Day")
            Case "P"
                Response.Write(m_dblPrevPercentage.ToString & " %")
        End Select
        Response.Write("</TD>")
        Response.Write("</TR>")
        Response.Write("<TR class='clsTREven'>")

        Response.Write("<TD align=right>") 'width='30%'  
        Response.Write("<b>" & MyBase.GetResourceString("WORK_HOURS") + ": </b>")
        Response.Write("</TD>")
        Response.Write("<TD colspan=3>") 'width='20%'
        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtWorkHours", "txtWorkHours", , , , lngCurrentHours.ToString, , , True))
        Response.Write(dblCurrentHours.ToString)
        Response.Write("</TD>")
        Response.Write("</TR>")


        Response.Write("</table>")

        System.Web.HttpContext.Current.Response.Write("</DIV>")
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
        'Added by SanaS 10-11-2009
        arrMenu(MenuIndex.CANCEL) = MyBase.GetResourceString("MENU_CANCEL")
        arrMenuToolTip(MenuIndex.CANCEL) = MyBase.GetResourceString("MENU_CANCEL_TOOLTIP")
        arrClientSideFunction(MenuIndex.CANCEL) = "Cancel_OnClick()"
        'End Addition by SanaS 10-11-2009
        arrMenu(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        arrMenuToolTip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        arrClientSideFunction(MenuIndex.CLOSE) = "Close_OnClick()"

        arrMenu(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        arrMenuToolTip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        arrClientSideFunction(MenuIndex.HELP) = "Help_OnClick('PM_EXTENDBOOKING')"


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
        ' Revisions             :
        '=====================================================================

        'This will initialize all the global objects.
        GetGlobalObject()
        If m_intRequestID = 0 Then
            strProjectID = m_objGlobal.ProjectID.ToString
        Else
            strProjectID = CType(CommonFunction.Data.GetDataScalar("Select ProjectID FROM TBL_PM_ResourceRequest Where RequestID=" + m_intRequestID.ToString, MyBase.UseSQL), String)
        End If
        m_blnEnableResourceAllocation = CType(CommonFunction.Data.GetDataScalar("usp_Sel_IsProjectResourceAllocation " & strProjectID.ToString, MyBase.UseSQL), Boolean)
        'this code will get execute when form will open in Save mode
        m_intProjectEmployeeRoleId = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectEmployeeRoleID"), "0"), Integer)

        If m_intProjectEmployeeRoleId <> 0 Then
            GetCurrentAllocationDetails()
        End If

        m_strMaxUnits = CType(CommonFunctions.Data.GetDataScalar("usp_Get_MaxUnits_For_AllocationType '" & m_strType & "'," & m_objGlobal.ProjectID.ToString, MyBase.UseSQL), String)

        'this code will get execute when form will open in Assigned mode
        'get the request details
        m_intRequestID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RequestID"), "0"), Integer)

        If m_intRequestID <> 0 Then
            GetExistingRequestDetails()
        End If

        Get_Approved_Or_Requested_RequestDetails()

        If m_blnEnableResourceAllocation = True Then
            If m_strMode.ToUpper = "CANCEL" Then
                CancelRequest()
            End If
            If m_strMode.ToUpper = "SAVE" Then
                m_strType = "P"
                SaveAllocationDetails()
                If blnIsOverAllocation = False Then
                    AssignSave()
                End If
            Else
                m_strType = "P"
                m_dblPrevPercentage = strCurrentResourcePercentage
                If m_RequestType = "" Then
                    m_dblPercentage = strCurrentResourcePercentage
                End If
            End If

        Else

                If m_strMode = "SAVE" Then
                    SaveAllocationDetails()
                ElseIf m_strMode = "ASSIGNCONFIRM" Then
                    AssignConfirm()
                ElseIf m_strMode = "ASSIGNSAVE" Then
                    AssignSave()
                End If


        End If

        Call PlotPage()

        DisposeObjects()

    End Sub

    Private Sub GetExistingRequestDetails()
        '====================================================================
        ' Procedure Name        :GetExistingRequestDetails
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               :To get existing request details of resource
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : GaneshG
        ' Created               : 
        ' Revisions             :Integrated from WhizibleSEM8 by SanaS on 24-Sep-2009
        '=====================================================================
        Dim drProjectEmployeeRole As IDataReader

        drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ResourceRequest_ExtensionBooking NULL," + m_intRequestID.ToString, MyBase.UseSQL)

        If drProjectEmployeeRole.Read Then

            strCurrentStartDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("ExpectedStartDate"), ""), Date))
            strCurrentEndDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("ExpectedEndDate"), ""), Date))
            strCurrentResourcePercentage = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("ResourcePercentage"), "0"), String)
            dblCurrentHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("BudgetedHours"), "0"), Double)
            intResourcepoolID = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("ResourcePoolID"), "0"), Integer)
            m_strSpecialRequest = CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("SpecialRequest"), "").ToString
            'm_strHours = drProjectEmployeeRole("WorkHours").ToString
            m_intPriority = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("Priority"), "0"), Integer)
            'm_intRequestID = CType(drProjectEmployeeRole("RequestID"), Integer)
            m_strRequestDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("RequestDate"), ""), Date))
            m_intProjectEmployeeRoleId = CType(drProjectEmployeeRole("ProjectEmployeeRoleId"), Integer)
            strProjectID = CType(drProjectEmployeeRole("ProjectID"), String)
            m_strStatus = CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("Status"), "").ToString.Trim
            m_intEmployeeID = CType(drProjectEmployeeRole("EmployeeID"), Integer)
            strEmployeeName = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("EmployeeName"), "0"), String)
            intRoleID = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("RoleID"), "0"), Integer)
            m_strRequestedStartDate = CommonFunction.Dates.GetDate(CType(drProjectEmployeeRole("FromDate"), Date))
            m_strRequestedEndDate = CommonFunction.Dates.GetDate(CType(drProjectEmployeeRole("ToDate"), Date))
            'm_StrFromDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("FromDate"), ""), Date))
            'Added by SanaS on 14-Aug-2009
            m_strType = CType(drProjectEmployeeRole("Type"), String)
            m_dblWorkHrsPerDay = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("WorkHours"), "0"), Double)
            m_dblTotalWorkHrs = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("TotalRequestedHrs"), "0"), Double)
            m_dblPercentage = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("PercentageAllocation"), "0"), Double)
            intRequestID = m_intRequestID
        End If

        CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)

    End Sub

    Private Sub GetCurrentAllocationDetails()
        '====================================================================
        ' Procedure Name        :GetCurrentAllocationDetails
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               :To get current allocation details of resource
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : GaneshG
        ' Created               : 
        ' Revisions             :Integrated from WhizibleSEM8 by SanaS on 24-Sep-2009
        '=====================================================================
        Dim drProjectEmployee As IDataReader
        Dim drProjectEmployeeRole As IDataReader
        Dim strSQL As String

        '''this code will get execute when form will open in Save mode
        ''m_intProjectEmployeeRoleId = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectEmployeeRoleID"), "0"), Integer)

        ''If m_intProjectEmployeeRoleId <> 0 Then

        drProjectEmployee = CommonFunction.Data.GetDataReader("usp_Sel_ProjectEmployeeRole " + m_intProjectEmployeeRoleId.ToString + "," + m_objGlobal.ProjectID.ToString, MyBase.UseSQL)

        If drProjectEmployee.Read Then
            strCurrentStartDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("ExpectedStartDate"), ""), Date))
            strCurrentEndDate = CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("ExpectedEndDate"), ""), Date))
            strCurrentResourcePercentage = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("ResourcePercentage"), "0"), String)
            dblCurrentHours = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("BudgetedHours"), "0"), Double)
            strEmployeeName = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("EmployeeName"), "0"), String)
            m_intEmployeeID = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("EmployeeID"), "0"), Integer)
            m_strRequestedStartDate = CommonFunction.Dates.GetDate(DateAdd(DateInterval.Day, 1, CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("ExpectedEndDate"), ""), Date)))
            intRoleID = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployee("RoleID"), "0"), Integer)
        End If

        CommonFunction.Data.DisposeDataReader(drProjectEmployee)


        'Added by TruptiK on 14-Jan-2008
        drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_sel_ApproveorRejectRequest_tbl_PM_ResourceRequest " + m_objGlobal.ProjectID.ToString + "," + m_intProjectEmployeeRoleId.ToString + "," + "1", MyBase.UseSQL)

        If drProjectEmployeeRole.Read Then
            intRequestID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(drProjectEmployeeRole("RequestID"), "0"), "0"), Integer)
        End If

        CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)
        'End of addition by TruptiK
        '''Added by TruptiK on 15-Jan-2008
        drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_sel_resourcepool_tbl_pm_resourcerequest  " + m_objGlobal.ProjectID.ToString() + "," + m_intEmployeeID.ToString, MyBase.UseSQL)

        If drProjectEmployeeRole.Read Then
            intResourcepoolID = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("Resourcepoolid"), "0"), Integer)

        End If

        CommonFunction.Data.DisposeDataReader(drProjectEmployee)
        '''End of addition by TruptiK on 15-Jan-2008

        'Modified by TruptiK on 14-Jan-2008
        'drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ResourceRequest_ExtensionBooking " + m_intProjectEmployeeRoleId.ToString, MyBase.UseSQL)
        If intRequestID <> 0 Then
            drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ResourceRequest_ExtensionBooking NULL," + intRequestID.ToString, MyBase.UseSQL)

            If drProjectEmployeeRole.Read Then
                m_strRequestedStartDate = CommonFunction.Dates.GetDate(CType(drProjectEmployeeRole("FromDate"), Date))
                m_strRequestedEndDate = CommonFunction.Dates.GetDate(CType(drProjectEmployeeRole("ToDate"), Date))
                m_strSpecialRequest = CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("SpecialRequest"), "").ToString
                'm_strHours = drProjectEmployeeRole("WorkHours").ToString
                m_intPriority = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("Priority"), "0"), Integer)
                'm_intRequestID = CType(drProjectEmployeeRole("RequestID"), Integer)
                m_strStatus = CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("Status"), "").ToString.Trim
                m_dblWorkHrsPerDay = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("WorkHours"), "0"), Double)
                m_dblTotalWorkHrs = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("TotalRequestedHrs"), "0"), Double)
                m_dblPercentage = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("PercentageAllocation"), "0"), Double)
                m_strType = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("Type"), "P"), String)
                m_RequestType = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("RequestType"), ""), String)
            End If

            CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)
        Else
            drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ResourceRequest_ExtensionBooking " + m_intProjectEmployeeRoleId.ToString, MyBase.UseSQL)

            If drProjectEmployeeRole.Read Then
                If m_strRequestedStartDate < CommonFunction.Dates.GetDate(DateAdd(DateInterval.Day, 1, CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("ToDate"), ""), Date))) Then
                    m_strRequestedStartDate = CommonFunction.Dates.GetDate(DateAdd(DateInterval.Day, 1, CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("ToDate"), ""), Date)))
                End If
                m_strSpecialRequest = CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("SpecialRequest"), "").ToString
                m_intPriority = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("Priority"), "0"), Integer)
                m_strStatus = CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("Status"), "").ToString.Trim
                'm_dblWorkHrsPerDay = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("WorkHours"), "0"), Double)
                'm_dblTotalWorkHrs = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("TotalRequestedHrs"), "0"), Double)
                'm_dblPercentage = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("PercentageAllocation"), "0"), Double)
                m_strType = CType(CommonFunction.Data.CheckIsDBNull(drProjectEmployeeRole("Type"), "P"), String)
            End If

            CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)
        End If

        ''Added by SanaS on 14-Aug-2009
        'strSQL = "usp_get_allocationType_for_AssignedResource " + m_intProjectEmployeeRoleId.ToString
        'm_strType = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), ""), String)
        ''End addition by  SanaS on 14-Aug-2009


    End Sub
    Private Sub CancelRequest()
        Dim strSQL As String
        m_intRequestID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RequestID"), "0"), Integer)
        strSQL = "usp_Cancel_Resourcerequest_ExtendBooking " + m_intRequestID.ToString
        CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        m_strScript &= "window.close();" + vbCrLf
        m_strScript &= "window.opener.location=window.opener.location;" + vbCrLf



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
        m_strRequestedEndDate = ""
        m_strSpecialRequest = ""
        'm_strHours = ""

        m_strMode = CommonFunction.General.CheckIsNothing(Request.QueryString("Mode")).ToUpper
        ''m_strRequestedStartDate = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtReqStartDate"))
        ''m_strRequestedEndDate = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtReqEndDate"))
        ''m_strSpecialRequest = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtRequest"), "").ToString
        'm_strHours = MyBase.GetFormValue("txtTotalWorkHours")

        If m_strMode.ToUpper = "ASSIGN" Or m_strMode.ToUpper = "ASSIGNCONFIRM" Then
            blnIsDisabled = True
        ElseIf m_strMode.ToUpper = "ADD" Then
            blnIsReadOnly = True
        End If

        '''this code is executed for assigned resource request.
        ''m_intPriority = CType(CommonFunction.General.CheckIsNothing("0" + MyBase.GetFormValue("cboPriority"), "0"), Integer)
        ''If Not IsPostBack Then
        m_intRequestID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RequestID"), "0"), Integer)
        ''If m_intRequestID <> 0 Then
        ''    'drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ResourceRequest_ExtensionBooking NULL," + m_intRequestID.ToString, MyBase.UseSQL)
        ''    drProjectEmployeeRole = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_AssignedResources " + m_intRequestID.ToString, MyBase.UseSQL)
        ''    If drProjectEmployeeRole.Read Then
        ''        m_strStatus = drProjectEmployeeRole("Status").ToString.Trim
        ''    End If
        ''    CommonFunction.Data.DisposeDataReader(drProjectEmployeeRole)
        ''End If
        ''End If

        MyBase.InitializeResources("AppResources.PM_ExtendBooking", "AppResources")
       


    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print

        'if resource already assigned then only show the close link.
        'If m_strStatus.Trim.ToUpper = "L" Then
        If m_strStatus.Trim.ToUpper <> "R" And m_strStatus.Trim.ToUpper <> "" Then
            If m_blnEnableResourceAllocation = True Then
                If m_strStatus.Trim.ToUpper = "A" Then
                    If Args.MenuColIndex < 3 Then
                        Cancel = True
                    End If
                    If m_RequestType <> "E" Then
                        If Args.MenuColIndex = 3 Then
                            Cancel = True
                        End If
                    End If
                ElseIf m_strStatus.Trim.ToUpper = "L" Then
                    If Args.MenuColIndex = 1 Or Args.MenuColIndex = 2 Or Args.MenuColIndex = 3 Then
                        Cancel = True
                    End If
                End If
            Else
                If m_strStatus.Trim.ToUpper = "REJECT" Then
                    If Args.MenuColIndex = 1 Or Args.MenuColIndex = 2 Or Args.MenuColIndex = 3 Then
                        Cancel = True
                    End If
                ElseIf m_strStatus.Trim.ToUpper = "L" Then
                    If Args.MenuColIndex = 1 Or Args.MenuColIndex = 2 Or Args.MenuColIndex = 3 Then
                        Cancel = True
                    End If
                Else
                    If Args.MenuColIndex < 4 Then
                        Cancel = True
                    End If
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
                If Args.MenuColIndex = 0 Or Args.MenuColIndex = 3 Then
                    Cancel = True
                End If
            End If
        End If

    End Sub

#End Region

End Class
