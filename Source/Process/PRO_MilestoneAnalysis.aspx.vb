'*********************************************************************
'                CSPL Code Header
' Project Name     : PBNIT      
' Module Name      : PRO_MilestoneAnalysis
' Purpose          : The page for MileStone Analysis with Mode :-REPROJ
' Description      : Same as Above   
' Assumptions      :    
' Dependencies     : 
' Author           : DipaliS
' Reviewed         :
' Tested           :
' Created          : April 07, 2004 
' Revisions        :								   
'*********************************************************************
Public Class PRO_MilestoneAnalysis
    Inherits WebPages.Template.WhizTemplate

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

#Region "Constructor"
    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
#End Region

#Region "Member variables"
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_strPagingAlphabet As String
    Private m_intUserID As Integer
    Protected WithEvents frmPRO_MilestoneAnalysis As System.Web.UI.HtmlControls.HtmlForm
    Private m_intRoleLevel As Integer
    Protected m_lngMasterTagID As Long
    Private WithEvents m_objGrid As WebPages.Template.AdvancedGrid
    Private WithEvents m_objGridForMilestone As WebPages.Template.AdvancedGrid
    Protected m_strMode As String
    Protected m_intProjectID As Integer
    Private m_intAnalysisID As Integer
    Protected m_lngtMilestoneAnalysisReportID As Long
#End Region

#Region "Procedures"
    Public Sub PageInit()
        'Get the
        m_lngtMilestoneAnalysisReportID = CommonFunctions.Application.MilestoneAnalysisReportID

        m_intUserID = CType(Session("intUserID"), Integer)
        m_intRoleLevel = CType(Session("intRoleLevel"), Integer)

        'Get the Page Number
        If Trim(Request.QueryString("PageNumber")) = "" Then
            m_strPagingAlphabet = "-1"
        Else
            '' START : Commented and Modified By ParagD on 27-Sept-2006
            '' m_strPagingAlphabet = Trim(Request.QueryString("PageNumber"))
            m_strPagingAlphabet = CommonFunction.General.BuildQueryString(Trim(Request.QueryString("PageNumber")))
            '' END : Commented and Modified By ParagD on 27-Sept-2006
        End If

        'Get the Mode
        m_strMode = Trim(Request.QueryString("strMode"))

        If m_strMode Is Nothing Then
            m_strMode = ""
        End If

        'Project ID
        m_intProjectID = CType(Request.QueryString("ProjectID"), Integer)

        'Get the Menu for the Page
        GetGlobalObject()
        m_lngMasterTagID = m_objGlobal.TagID

        'Page div
        If m_strMode = "" Then
            GetMenu("", True)
            GetPageCaption()
            Response.Write("<DIV ID='PageDiv' style='overflow:auto;width=100%'>")
            GetProjects()
            Response.Write("</DIV>")
            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
            Response.Write("<BR>")
            GetMenu("", False)
        ElseIf m_strMode = "REPMIL" Then
            GetMenu("REPMIL", True)
            GetPageCaption()
            Response.Write("<DIV ID='PageDiv' style='overflow:auto;width=100%'>")
            GetMileStoneForProject()
            Response.Write("</DIV>")
            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
            Response.Write("<BR>")
            GetMenu("REPMIL", False)
        End If

        m_objGlobal = Nothing
    End Sub
    '=====================================================================
    ' Procedure Name        : GetGlobalObject()	
    ' Purpose               : Function To Fill Global Object
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : April 7, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject
    End Sub

    '=====================================================================
    ' Procedure Name        : GetMenu()	
    ' Purpose               : Function To Page Caption
    ' Description           : same as above
    ' Parameters Passed     : Mode , Draepaging
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : April 7, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetMenu(ByVal Mode As String, ByVal DrawPaging As Boolean)
        Dim objMenu As WebPages.Template.StaticMenu
        Dim strPager As String = ""
        objMenu = New WebPages.Template.StaticMenu

        'Get the Pager String
        Dim objPager As WebPages.Template.Paging
        objPager = New WebPages.Template.Paging

        If Mode = "" Then
            If DrawPaging = True Then
                strPager = objPager.DrawPaging(m_strPagingAlphabet, "Exec usp_Sel_GetProjects_ForPaging " & m_intUserID & "," & m_intRoleLevel & ",NULL")
                If strPager <> "" Then
                    strPager = MyBase.GetResourceString("PAGING_SELECT") + strPager
                End If
            End If

            'Plot the Menu and the pager
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_HELP")}

            Dim arrClientSideFunctions() As String = {"Help_OnClick('" & m_objGlobal.TagID & "')"}

            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_HELP_TOOLTIP")}

            objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, False, strPager)

            objMenu = Nothing
            objPager = Nothing

        ElseIf Mode = "REPMIL" Then
            If DrawPaging = True Then
                strPager = objPager.DrawPaging(m_strPagingAlphabet, "Exec usp_Sel_GetProjectMilestones_ForPaging " & m_intProjectID & ",NULL")
                If strPager <> "" Then
                    strPager = MyBase.GetResourceString("PAGING_SELECT") + strPager
                End If
            End If

            'Plot the Menu and the pager
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_BACK"), MyBase.GetResourceString("MENU_HELP")}

            Dim arrClientSideFunctions() As String = {"Back_OnClick('REPMIL')", "Help_OnClick('" & m_objGlobal.TagID & "')"}

            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_BACK_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}

            objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, False, strPager)

            objMenu = Nothing
            objPager = Nothing

        End If
    End Sub
    '=====================================================================
    ' Procedure Name        : GetPageCaption()	
    ' Purpose               : Function To Page Caption
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : April 7, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetPageCaption()
        Response.Write("<BR>")
        WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal)
        Response.Write("<BR>")

        Dim objHeader As New WebPages.Template.HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        Dim strHeader As String = objHeader.DrawHeaderFooter(m_objGlobal, True) & ""
        Response.Write(strHeader)
        If strHeader.Trim <> "" Then Response.Write("<BR>")
        objHeader = Nothing
    End Sub
    '=====================================================================
    ' Procedure Name        : GetProjects()	
    ' Purpose               : Function To draw the Projects Grid
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : April 7, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetProjects()
        Dim strSQLQuery As String
        'Build the SQL depending upon the Paging alphabet selected
        If m_strPagingAlphabet = "" Then

            strSQLQuery = "Exec usp_Sel_GetProjects  " & m_intUserID & "," & m_intRoleLevel & ",NULL"

        ElseIf m_strPagingAlphabet = "-1" Then
            'if the value of strPage is -1 then getting all the list of the PMI
            strSQLQuery = "Exec usp_Sel_GetProjects  " & m_intUserID & "," & m_intRoleLevel & ",NULL"

        Else
            'Geting the list of PMI depending on the value of strPage
            strSQLQuery = "Exec usp_Sel_GetProjects " & m_intUserID & "," & m_intRoleLevel & ",'" & m_strPagingAlphabet & "'"
        End If

        'Initialize the resources for this particular page
        MyBase.InitializeResources("AppResources.PRO_MilestoneAnalysis", "AppResources")

        m_objGrid = New WebPages.Template.AdvancedGrid
        Dim arrActualColumnArray() As String = {"ProjectName"}

        Dim arrUserFriendlyArray() As String = {MyBase.GetResourceString("PROJECTNAME")}
        'Dim arrTDStyle() As String = {"align=left", "align=center", "align=center", "align=center"}

        Dim arrRowLink() As String = {"1"}
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        m_objGrid.ActualColumnArray = arrActualColumnArray
        m_objGrid.UserFriendlyColumnArray = arrUserFriendlyArray
        ' m_objGrid.RowLinkArray = arrRowLink


        Dim strGrid As String
        m_objGrid.ActualColumnArray = arrActualColumnArray
        m_objGrid.UserFriendlyColumnArray = arrUserFriendlyArray
        m_objGrid.returnHTML = True
        m_objGrid.UseSQL = MyBase.UseSQL
        m_objGrid.SQL = strSQLQuery
        m_objGrid.NoOfDataColumns = 1
        m_objGrid.DIVStyle = "'overflow:auto;Height:400'"
        m_objGrid.PrimaryKey = "ProjectID"
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        m_objGrid.IgnoreHTMLEncode = arrIgnoreHtml
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        strGrid = m_objGrid.DrawGrid()
        m_objGrid = Nothing

        Response.Write(strGrid)
    End Sub
    '=====================================================================
    ' Procedure Name        : GetMileStoneForProject()	
    ' Purpose               : Function To draw the Milestones Grid
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : April 7, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GetMileStoneForProject()
        Dim strQuery As String
        'Gets the Milestones for the project for showing the report
        strQuery = "Exec usp_Sel_GetProjectMilestones " & m_intProjectID

        If m_strPagingAlphabet = "" Then

            strQuery = "Exec usp_Sel_GetProjectMilestones " & m_intProjectID & ",NULL"

        ElseIf m_strPagingAlphabet = "-1" Then
            'if the value of m_strPagingAlphabet is -1 then getting all the list of the PMI
            strQuery = "Exec usp_Sel_GetProjectMilestones " & m_intProjectID & ",NULL"
        Else
            'Geting the list of PMI depending on the value of m_strPagingAlphabet
            strQuery = "Exec usp_Sel_GetProjectMilestones " & m_intProjectID & ",'" & m_strPagingAlphabet & "'"
        End If
        'Initialize the resources for this particular page
        MyBase.InitializeResources("AppResources.PRO_MilestoneAnalysis", "AppResources")

        m_objGridForMilestone = New WebPages.Template.AdvancedGrid
        Dim arrActualColumnArray() As String = {"Milestone", ""}

        Dim arrUserFriendlyArray() As String = {MyBase.GetResourceString("MILESTONE"), MyBase.GetResourceString("REPORT")}
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        m_objGridForMilestone.ActualColumnArray = arrActualColumnArray
        m_objGridForMilestone.UserFriendlyColumnArray = arrUserFriendlyArray


        Dim strGrid As String
        m_objGridForMilestone.ActualColumnArray = arrActualColumnArray
        m_objGridForMilestone.UserFriendlyColumnArray = arrUserFriendlyArray
        m_objGridForMilestone.returnHTML = True
        m_objGridForMilestone.UseSQL = MyBase.UseSQL
        m_objGridForMilestone.SQL = strQuery
        m_objGridForMilestone.NoOfDataColumns = 1
        m_objGridForMilestone.DIVStyle = "'overflow:auto;Height:400'"
        m_objGridForMilestone.PrimaryKey = "MilestoneID"
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        m_objGridForMilestone.IgnoreHTMLEncode = arrIgnoreHtml
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        strGrid = m_objGridForMilestone.DrawGrid()
        m_objGridForMilestone = Nothing

        Response.Write(strGrid)

    End Sub
#End Region

#Region "Grid Events"

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        'Insert string for the Hyperlink
        Dim strToBeInstertd As String
        'Commented And Added by Vaijat K ON 10/11/2015
        'strToBeInstertd = "<A href=" & """Javascript:GetMileStones(" & CType(Args.DataReader("projectid"), String) & _
        '        ")""" & ">" & CType(Args.DataReader("ProjectName"), String) & "</A>"
        strToBeInstertd = "<A href=" & """Javascript:GetMileStones(" & CType(Args.DataReader("projectid"), String) & _
                ")""" & ">" & HttpUtility.HtmlEncode(CType(Args.DataReader("ProjectName"), String)) & "</A>"
        Cancel = True
        Args.StringToBeInserted = "<td>" & strToBeInstertd & "</td>"
    End Sub

    Private Sub m_objGridForMilestone_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGridForMilestone.DataRowTD_BeforePrint

        'Insert string for hyperlink
        If Args.ColIndex = 1 Then
            Dim strMileStone As String
            Dim intMileStoneID As Integer
            Dim strQueryAnalysis As String
            Dim intAnalysisID As Integer
            'Get the Analysis ID
            strMileStone = CType(Args.DataReader("MileStone"), String) & ""
            intMileStoneID = CType(Args.DataReader("MileStoneID"), Integer)

            strQueryAnalysis = "EXEC usp_Sel_PDB_GetAnalysisID " & m_intProjectID & "," & intMileStoneID
            intAnalysisID = CType(CommonFunctions.Data.GetDataScalar(strQueryAnalysis, MyBase.UseSQL), Integer)

            Dim strToBeInstertd As String
            strToBeInstertd = "<A href=" & """Javascript:MilestoneAnalysisReport(" & CType(intAnalysisID, String) & _
                ")""" & ">" & "Show Report</A>"

            Cancel = True
            Args.StringToBeInserted = "<td>" & strToBeInstertd & "</td>"
        End If
    End Sub
#End Region

End Class
