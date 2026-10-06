Imports CommonFunction
Imports Whizible
Public Class OverallSchedule_AttributeDetails
    Inherits WebPages.Template.WhizTemplate

    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface. 
    Private m_objAccessRights As WebPages.Security.cAccessRights          'This variable is for access rights of page.
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu

    Protected m_strAttribute As String
    Protected m_strAttributeID As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        If Not Request.QueryString("Attribute") Is Nothing Then
            m_strAttribute = Request.QueryString("Attribute").ToString
        Else
            m_strAttribute = ""
        End If

        If Not Request.QueryString("AttributeID") Is Nothing Then
            m_strAttributeID = HttpContext.Current.Request.QueryString("AttributeID")
        Else
            m_strAttributeID = ""
        End If
    End Sub

    Public Sub PageInit()
        GetGlobalObject()
        PlotMenu()

        WritePage()

    End Sub
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
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

    End Sub
    Protected Sub PlotMenu()
        Dim arrMenu() As String
        Dim arrMenuToolTip() As String
        Dim arrCSFunction() As String
        Dim sbSTRHTML As New System.Text.StringBuilder

        Dim m_arrMenu() As String = {"Close"}
        Dim m_arrMenuToolTip() As String = {"Close"}
        Dim m_arrCSFunction() As String = {"Close_OnClick()"}
        arrMenu = m_arrMenu
        arrMenuToolTip = m_arrMenuToolTip
        arrCSFunction = m_arrCSFunction

        Dim strMenu As String

        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
        sbSTRHTML.Append(strMenu)

        CommonFunction.General.WriteHTML(sbSTRHTML.ToString())
        CommonFunction.General.WriteHTML("<br>")
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, m_strAttribute & " Details", , , True))
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "", , , True))

        CommonFunction.General.WriteHTML("<br>")

    End Sub
    Protected Sub WritePage()

        Dim sbSTRHTML As New System.Text.StringBuilder
        Dim strSQL As String
        Dim dr As IDataReader

        Dim strAttributeName As String = ""
        Dim Abbreviated_Name As String = ""
        Dim strProjectCode As String = ""
        Dim strProjectGroupName As String = ""
        Dim strAttributeDescription As String = ""
        Dim strStartDate As String = ""
        Dim strEndDate As String = ""
        Dim strBillable As String = ""
        Dim strContractType As String = ""
        Dim strWork As String = ""
        Dim Project_Currency As String = ""
        Dim Business_Group As String = ""
        Dim Organization_Unit As String = ""
        Dim Practice As String = ""
        Dim Customer As String = ""
        Dim Project_Size As String = ""
        Dim Project_Status As String = ""
        Dim Closed As String = ""
        Dim Responsible_Person As String = ""
        Dim Invoice_Printed As String = ""
        Dim Analysis_applicable As String = ""
        Dim Analysis_Status As String = ""
        Dim Milestone_Status As String = ""
        Dim Invoice_No As String = ""
        Dim Revenue_Recognize_Date As String = ""
        Dim Complexity As String = ""
        Dim PlannedResources As String = ""
        Dim PercentEfforts As String = ""
        Dim CurrentPhase As String = ""
        Dim Ready_for_Billing As String = ""
        Dim Code_Template As String = ""
        Dim Priority As String = ""
        Dim Requested_By As String = ""
        Dim Status As String = ""
        Dim Start_Time As String = ""
        Dim Complition_Time As String = ""
        Dim Billable As String = ""
        Dim OnHold As String = ""
        Dim Void As String = ""
        Dim Billable_Amount As String = ""
        Dim BaselineStartDate As String = ""
        Dim BaselineEndDate As String = ""
        Dim ActualStartDate As String = ""
        Dim ActualEndDate As String = ""
        Dim TaskType As String = ""
        Dim strSite As String = ""
        Dim ActualEfforts As String = ""
        Dim OpenTasksCount As String = ""
        Dim CompletedTasksCount As String = ""
        Dim CriticalTasksCount As String = ""
        Dim PercentageComplete As String = ""

        Dim ProjectManager As String = ""
        Dim ActualDuration As String = ""
        Dim TotalEmployees As String = ""
        Dim TotalActiveEmployees As String = ""
        Dim TotalReviews As String = ""
        Dim SubProjectCount As String = ""
        Dim MileStoneCount As String = ""
        Dim ModuleCount As String = ""
        Dim PhasesCount As String = ""
        Dim DeliverableCount As String = ""
        Dim IssuesCount As String = ""
        Dim OpenIssuesCount As String = ""
        Dim CloseIssuesCount As String = ""

        strSQL = "EXEC usp_sel_tbl_PM_OverallScheduleAttributeDetails " & m_strAttributeID & ",'" & m_strAttribute & "'"
        dr = CommonFunction.Data.GetDataReader(strSQL, True)

        sbSTRHTML.Append("<div style=""width:100%;height:310px;overflow:auto;"" ID=""DivMain"">")
        If m_strAttribute.ToUpper = "PROJECT" Then
            While dr.Read()
                Abbreviated_Name = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Abbreviated_Name"), "&nbsp"), "&nbsp")
                strProjectCode = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ProjectCode"), "&nbsp"), "&nbsp")
                strAttributeName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ProjectName"), "&nbsp"), "&nbsp")
                strAttributeDescription = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Description"), "&nbsp"), "&nbsp")
                strStartDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("StartDate"), "&nbsp"), "&nbsp")
                strEndDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("EndDate"), "&nbsp"), "&nbsp")
                strBillable = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Billable"), "&nbsp"), "&nbsp")
                strContractType = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ContractType"), "&nbsp"), "&nbsp")
                strWork = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Work"), "&nbsp"), "&nbsp")
                Project_Currency = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Project_Currency"), "&nbsp"), "&nbsp")
                Business_Group = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Business_Group"), "&nbsp"), "&nbsp")
                Organization_Unit = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Organization_Unit"), "&nbsp"), "&nbsp")
                Practice = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Practice"), "&nbsp"), "&nbsp")
                Customer = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "&nbsp"), "&nbsp")
                Project_Size = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Project_Size"), "&nbsp"), "&nbsp")
                Project_Status = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Project_Status"), "&nbsp"), "&nbsp")

                ProjectManager = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ProjectManager"), "&nbsp"), "&nbsp")
                ActualStartDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ActualStartDate"), "&nbsp"), "&nbsp")
                ActualEndDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ActualEndDate"), "&nbsp"), "&nbsp")
                ActualDuration = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ActualDuration"), "&nbsp"), "&nbsp")
                TotalEmployees = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("TotalEmployees"), "&nbsp"), "&nbsp")
                TotalActiveEmployees = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("TotalActiveEmployees"), "&nbsp"), "&nbsp")
                TotalReviews = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("TotalReviews"), "&nbsp"), "&nbsp")
                SubProjectCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("SubProjectCount"), "&nbsp"), "&nbsp")
                MileStoneCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("MileStoneCount"), "&nbsp"), "&nbsp")
                ModuleCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ModuleCount"), "&nbsp"), "&nbsp")
                PhasesCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("PhasesCount"), "&nbsp"), "&nbsp")
                DeliverableCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("DeliverableCount"), "&nbsp"), "&nbsp")
                IssuesCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("IssuesCount"), "&nbsp"), "&nbsp")
                OpenIssuesCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("OpenIssuesCount"), "&nbsp"), "&nbsp")
                CloseIssuesCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("CloseIssuesCount"), "&nbsp"), "&nbsp")
            End While


            sbSTRHTML.Append("<TABLE class=clsTable cellspacing=0 cellpadding=0>")

            ''Abbreviated_Name
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Abbreviated Name : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Abbreviated_Name)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Project Code
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Project Code : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strProjectCode)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Project Name
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Project Name : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strAttributeName)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Description
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Description : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strAttributeDescription)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Start Date
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Start Date : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strStartDate)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''End Date
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>End Date : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strEndDate)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Billable
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Billable : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strBillable)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Commercial Details
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Commercial Details : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strContractType)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Work
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Work : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strWork)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Currency
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Currency : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Project_Currency)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Business Group
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Business Group : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Business_Group)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Organization Unit
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Organization Unit : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Organization_Unit)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Practice
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Practice : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Practice)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Customer
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Customer : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Customer)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Project_Size
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Project Size : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Project_Size)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Project_Status
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Project Status : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Project_Status)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''ProjectManager
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Project Manager : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(ProjectManager)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''ActualStartDate
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Actual Start Date : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(ActualStartDate)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''ActualEndDate
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Actual End Date : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(ActualEndDate)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''ActualDuration
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Actual Duration : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(ActualDuration)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''TotalEmployees
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Total Employees : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(TotalEmployees)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''TotalActiveEmployees
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Total Active Employees : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(TotalActiveEmployees)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''TotalReviews
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Total Reviews : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(TotalReviews)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''SubProjectCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>No. of Sub Project : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(SubProjectCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''MileStoneCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>No. of MileStone : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(MileStoneCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''ModuleCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>No. of Modules : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(ModuleCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''PhasesCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>No. of Phases : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(PhasesCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''DeliverableCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>No. of Project Deliverable : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(DeliverableCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''IssuesCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>No. of Issues : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(IssuesCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''OpenIssuesCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>No. of Open Issues : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(OpenIssuesCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''CloseIssuesCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>No. of Close Issues : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(CloseIssuesCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            sbSTRHTML.Append("</TABLE>")

        ElseIf m_strAttribute.ToUpper = "SUBPROJECT" Then
            While dr.Read()
                strAttributeName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("SubProjectName"), "&nbsp"), "&nbsp")
                strAttributeDescription = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Description"), "&nbsp"), "&nbsp")
                strStartDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("StartDate"), "&nbsp"), "&nbsp")
                strEndDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("EndDate"), "&nbsp"), "&nbsp")
                strWork = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Work"), "&nbsp"), "&nbsp")
                Closed = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Closed"), "&nbsp"), "&nbsp")
                Responsible_Person = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Responsible_Person"), "&nbsp"), "&nbsp")
                ActualEfforts = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ActualEfforts"), "&nbsp"), "&nbsp")
                OpenTasksCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("OpenTasksCount"), "&nbsp"), "&nbsp")
                CompletedTasksCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("CompletedTasksCount"), "&nbsp"), "&nbsp")
                CriticalTasksCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("CriticalTasksCount"), "&nbsp"), "&nbsp")
                PercentageComplete = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("PercentageComplete"), "&nbsp"), "&nbsp")
            End While

            sbSTRHTML.Append("<TABLE class=clsTable cellspacing=0 cellpadding=0>")

            ''SubProject Name
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>SubProject Name : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strAttributeName)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Description
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Description : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strAttributeDescription)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Start Date
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Start Date : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strStartDate)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''End Date
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>End Date : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strEndDate)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Work
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Work : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strWork)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Closed
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Is Closed : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Closed)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Responsible_Person
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Responsible Person : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Responsible_Person)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Actual Efforts
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Actual Efforts : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(ActualEfforts)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''OpenTasksCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Count of Open Tasks : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(OpenTasksCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''CompletedTasksCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Count Completed Tasks : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(CompletedTasksCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''CriticalTasksCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Count Critical Tasks : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(CriticalTasksCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''PercentageComplete
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Percentage Complete : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(PercentageComplete)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            sbSTRHTML.Append("</TABLE>")
        ElseIf m_strAttribute.ToUpper = "MILESTONE" Then
            While dr.Read()
                strAttributeName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("MileStone"), "&nbsp"), "&nbsp")
                strAttributeDescription = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Comments"), "&nbsp"), "&nbsp")
                strStartDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("StartDate"), "&nbsp"), "&nbsp")
                strEndDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("EndDate"), "&nbsp"), "&nbsp")
                strWork = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Bill_Amount"), "&nbsp"), "&nbsp")
                Ready_for_Billing = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Ready_for_Billing"), "&nbsp"), "&nbsp")
                Invoice_Printed = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Invoice_Printed"), "&nbsp"), "&nbsp")
                Analysis_applicable = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Analysis_applicable"), "&nbsp"), "&nbsp")
                Analysis_Status = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Analysis_Status"), "&nbsp"), "&nbsp")
                Milestone_Status = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Milestone_Status"), "&nbsp"), "&nbsp")
                Invoice_No = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Invoice_No"), "&nbsp"), "&nbsp")
                Revenue_Recognize_Date = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Revenue_Recognize_Date"), "&nbsp"), "&nbsp")
                Closed = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Closed"), "&nbsp"), "&nbsp")
                Responsible_Person = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ResponsiblePerson"), "&nbsp"), "&nbsp")
                ActualEfforts = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ActualEfforts"), "&nbsp"), "&nbsp")
                OpenTasksCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("OpenTasksCount"), "&nbsp"), "&nbsp")
                CompletedTasksCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("CompletedTasksCount"), "&nbsp"), "&nbsp")
                CriticalTasksCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("CriticalTasksCount"), "&nbsp"), "&nbsp")
                PercentageComplete = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("PercentageComplete"), "&nbsp"), "&nbsp")
            End While

            sbSTRHTML.Append("<TABLE class=clsTable cellspacing=0 cellpadding=0>")

            ''MileStone Name
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>MileStone Name : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strAttributeName)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''MileStone Details
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>MileStone Details : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strAttributeDescription)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Start Date
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Start Date : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strStartDate)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''End Date
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>End Date : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strEndDate)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Bill Amount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Bill Amount : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strWork)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Ready_for_Billing
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Ready for Billing : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Ready_for_Billing)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Is Invoice Printed
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Is Invoice Printed : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Invoice_Printed)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Analysis applicable
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Analysis applicable : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Analysis_applicable)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Analysis Status
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Analysis Status : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Analysis_Status)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Milestone Status
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Milestone Status : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Milestone_Status)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Invoice_No
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Invoice No : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Invoice_No)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Revenue_Recognize_Date
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Revenue Recognize Date : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Revenue_Recognize_Date)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Is Closed
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Is Closed : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Closed)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Responsible_Person
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Responsible Person : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Responsible_Person)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Actual Efforts
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Actual Efforts : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(ActualEfforts)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''OpenTasksCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Count of Open Tasks : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(OpenTasksCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''CompletedTasksCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Count Completed Tasks : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(CompletedTasksCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''CriticalTasksCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Count Critical Tasks : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(CriticalTasksCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''PercentageComplete
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Percentage Complete : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(PercentageComplete)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            sbSTRHTML.Append("</TABLE>")
        ElseIf m_strAttribute.ToUpper = "MODULE" Then
            While dr.Read()
                strAttributeName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ModuleName"), "&nbsp"), "&nbsp")
                strAttributeDescription = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ModuleDescription"), "&nbsp"), "&nbsp")
                strStartDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("StartDate"), "&nbsp"), "&nbsp")
                strEndDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("EndDate"), "&nbsp"), "&nbsp")
                strWork = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Work"), "&nbsp"), "&nbsp")
                Closed = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Closed"), "&nbsp"), "&nbsp")
                Responsible_Person = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ResponsiblePerson"), "&nbsp"), "&nbsp")
                Complexity = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Complexity"), "&nbsp"), "&nbsp")
                ActualEfforts = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ActualEfforts"), "&nbsp"), "&nbsp")
                OpenTasksCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("OpenTasksCount"), "&nbsp"), "&nbsp")
                CompletedTasksCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("CompletedTasksCount"), "&nbsp"), "&nbsp")
                CriticalTasksCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("CriticalTasksCount"), "&nbsp"), "&nbsp")
                PercentageComplete = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("PercentageComplete"), "&nbsp"), "&nbsp")
            End While

            sbSTRHTML.Append("<TABLE class=clsTable cellspacing=0 cellpadding=0>")

            ''Module Name
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Module Name : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strAttributeName)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Description
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Description : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strAttributeDescription)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Start Date
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Start Date : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strStartDate)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''End Date
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>End Date : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strEndDate)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Work
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Work : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strWork)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Closed
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Is Closed : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Closed)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Responsible_Person
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Responsible Person : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Responsible_Person)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Complexity
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Complexity : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Complexity)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Actual Efforts
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Actual Efforts : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(ActualEfforts)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''OpenTasksCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Count of Open Tasks : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(OpenTasksCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''CompletedTasksCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Count Completed Tasks : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(CompletedTasksCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''CriticalTasksCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Count Critical Tasks : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(CriticalTasksCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''PercentageComplete
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Percentage Complete : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(PercentageComplete)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            sbSTRHTML.Append("</TABLE>")
        ElseIf m_strAttribute.ToUpper = "PHASE" Then
            While dr.Read()
                strAttributeName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("AttributeName"), "&nbsp"), "&nbsp")
                strStartDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("StartDate"), "&nbsp"), "&nbsp")
                strEndDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("EndDate"), "&nbsp"), "&nbsp")
                PlannedResources = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("PlannedResources"), "&nbsp"), "&nbsp")
                PercentEfforts = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("PercentEfforts"), "&nbsp"), "&nbsp")
                CurrentPhase = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("CurrentPhase"), "&nbsp"), "&nbsp")
                strWork = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("EstimatedEfforts"), "&nbsp"), "&nbsp")
                Responsible_Person = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ResponsiblePerson"), "&nbsp"), "&nbsp")
                ActualEfforts = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ActualEfforts"), "&nbsp"), "&nbsp")
                OpenTasksCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("OpenTasksCount"), "&nbsp"), "&nbsp")
                CompletedTasksCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("CompletedTasksCount"), "&nbsp"), "&nbsp")
                CriticalTasksCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("CriticalTasksCount"), "&nbsp"), "&nbsp")
                PercentageComplete = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("PercentageComplete"), "&nbsp"), "&nbsp")
            End While

            sbSTRHTML.Append("<TABLE class=clsTable cellspacing=0 cellpadding=0>")

            ''Phase Name
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Phase Name : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strAttributeName)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Start Date
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Start Date : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strStartDate)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''End Date
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>End Date : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strEndDate)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Peak Team Size
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Peak Team Size : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(PlannedResources)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Percentage Efforts
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Percentage Efforts : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(PercentEfforts)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Current Phase
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Current Phase : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(CurrentPhase)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Works (Hrs)
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Works (Hrs) : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strWork)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Responsible Person
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Responsible Person : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Responsible_Person)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Actual Efforts
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Actual Efforts : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(ActualEfforts)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''OpenTasksCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Count of Open Tasks : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(OpenTasksCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''CompletedTasksCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Count Completed Tasks : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(CompletedTasksCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''CriticalTasksCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Count Critical Tasks : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(CriticalTasksCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''PercentageComplete
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Percentage Complete : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(PercentageComplete)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            sbSTRHTML.Append("</TABLE>")
        ElseIf m_strAttribute.ToUpper = "DELIVERABLE" Then
            While dr.Read()
                strAttributeName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Title"), "&nbsp"), "&nbsp")
                strAttributeDescription = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Description"), "&nbsp"), "&nbsp")
                strStartDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("StartDate"), "&nbsp"), "&nbsp")
                strEndDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("EndDate"), "&nbsp"), "&nbsp")
                Code_Template = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Code_Template"), "&nbsp"), "&nbsp")
                strWork = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("efforts"), "&nbsp"), "&nbsp")
                Priority = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Priority"), "&nbsp"), "&nbsp")
                Requested_By = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Requested_By"), "&nbsp"), "&nbsp")
                Responsible_Person = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Responsible_Person"), "&nbsp"), "&nbsp")
                Status = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Status"), "&nbsp"), "&nbsp")
                Start_Time = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Start_Time"), "&nbsp"), "&nbsp")
                Complition_Time = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Complition_Time"), "&nbsp"), "&nbsp")
                Billable = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Billable"), "&nbsp"), "&nbsp")
                OnHold = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("OnHold"), "&nbsp"), "&nbsp")
                Void = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Void"), "&nbsp"), "&nbsp")
                Billable_Amount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Billable_Amount"), "&nbsp"), "&nbsp")
                strSite = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Site"), "&nbsp"), "&nbsp")
                ActualEfforts = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ActualEfforts"), "&nbsp"), "&nbsp")
                OpenTasksCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("OpenTasksCount"), "&nbsp"), "&nbsp")
                CompletedTasksCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("CompletedTasksCount"), "&nbsp"), "&nbsp")
                CriticalTasksCount = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("CriticalTasksCount"), "&nbsp"), "&nbsp")
                PercentageComplete = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("PercentageComplete"), "&nbsp"), "&nbsp")
            End While

            sbSTRHTML.Append("<TABLE class=clsTable cellspacing=0 cellpadding=0>")

            ''Code_Template
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Code Template : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Code_Template)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Deliverable Name
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Deliverable Name : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strAttributeName)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Description
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Description : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strAttributeDescription)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Start Date
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Start Date : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strStartDate)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''End Date
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>End Date : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strEndDate)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Efforts(hrs)
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Efforts(hrs) : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strWork)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Priority
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Priority : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Priority)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Requested_By
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Requested By : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Requested_By)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Responsible_Person
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Responsible Person : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Responsible_Person)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Status
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Status : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Status)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Start_Time
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Start Time (hh:mm) : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Start_Time)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Complition_Time
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Completion Time (hh:mm) </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Complition_Time)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Billable
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Billable : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Billable)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''OnHold
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>On Hold : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(OnHold)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Void
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Void : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Void)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Billable_Amount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Billable Amount : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Billable_Amount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Site
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Site : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(Site)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''Actual Efforts
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Actual Efforts : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(ActualEfforts)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''OpenTasksCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Count of Open Tasks : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(OpenTasksCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''CompletedTasksCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Count Completed Tasks : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(CompletedTasksCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''CriticalTasksCount
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Count Critical Tasks : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(CriticalTasksCount)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''PercentageComplete
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Percentage Complete : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(PercentageComplete)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            sbSTRHTML.Append("</TABLE>")
        ElseIf m_strAttribute.ToUpper = "TASK" Then
            While dr.Read()
                strAttributeName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("TaskName"), "&nbsp"), "&nbsp")
                strAttributeDescription = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("TaskNotes"), "&nbsp"), "&nbsp")
                strStartDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("StartDate"), "&nbsp"), "&nbsp")
                strEndDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("EndDate"), "&nbsp"), "&nbsp")
                Responsible_Person = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeName"), "&nbsp"), "&nbsp")
                strWork = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Work"), "&nbsp"), "&nbsp")
                BaselineStartDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("BaselineStartDate"), "&nbsp"), "&nbsp")
                BaselineEndDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("BaselineEndDate"), "&nbsp"), "&nbsp")
                ActualStartDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ActualStartDate"), "&nbsp"), "&nbsp")
                ActualEndDate = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ActualEndDate"), "&nbsp"), "&nbsp")
                Billable = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("IsBillable"), "&nbsp"), "&nbsp")
                Priority = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("Priority"), "&nbsp"), "&nbsp")
                TaskType = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("TaskType"), "&nbsp"), "&nbsp")
            End While

            sbSTRHTML.Append("<TABLE class=clsTable cellspacing=0 cellpadding=0>")

            ''Task Name
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Task Name : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strAttributeName)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Description
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Description : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strAttributeDescription)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            ''Start Date
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>Start Date : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strStartDate)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")

            ''End Date
            sbSTRHTML.Append("<TR>")
            sbSTRHTML.Append("<TD width=10% align=""left"">")
            sbSTRHTML.Append("<b>End Date : </b>")
            sbSTRHTML.Append("</TD><TD width=10% align=""left"">")
            sbSTRHTML.Append(strEndDate)
            sbSTRHTML.Append("</TD>")
            sbSTRHTML.Append("</TR>")
            sbSTRHTML.Append("</TABLE>")
        End If
        sbSTRHTML.Append("</div>")
        CommonFunction.General.WriteHTML(sbSTRHTML.ToString())

    End Sub
End Class



