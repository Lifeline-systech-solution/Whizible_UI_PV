Public Class RM_TaskClosure
    Inherits WebPages.Template.WhizTemplate


#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
        ' Added  Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added  Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
#Region "Member Variables"

    Dim m_strProjectID As String
    Dim m_strProjectRequirementID As String
    Dim m_strRequirementTitle As String

#End Region
    Private Sub Initialize()



        m_strProjectID = Request.QueryString("ProjectID")
        If Request.Form("hidProjectID") <> "" Then
            m_strProjectID = Request.Form("hidProjectID")
        End If
        m_strProjectRequirementID = Request.QueryString("ProjectRequirementID")
        If Request.Form("hidProjectRequirementID") <> "" Then
            m_strProjectRequirementID = Request.Form("hidProjectRequirementID")
        End If
        'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
        'm_strRequirementTitle = CType(CommonFunction.Data.GetDataScalar("Select ReqTitle FROM tbl_RM_ProjectRequirements WHERE ProjectRequirementID = " + m_strProjectRequirementID, MyBase.UseSQL), String)
        m_strRequirementTitle = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_RM_ProjectRequirements_ReqTitle " + m_strProjectRequirementID, MyBase.UseSQL), String)
        'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidProjectRequirementID id=hidProjectRequirementID value=" + m_strProjectRequirementID + ">")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidProjectID id=hidProjectID value=" + m_strProjectID + ">")


    End Sub

    Protected Sub InitPage()
        Initialize()
        ExecuteAction()
        DrawMenu()
        CommonFunction.General.WriteHTML("<DIV id=PageDiv style=""WIDTH:100%;HEIGHT:350px;OVERFLOW:auto"">")
        CommonFunction.General.WriteHTML("<BR>")
        DrawPageCaption()
        CommonFunction.General.WriteHTML("<BR>")
        DrawTaskCompletionGrid()
        CommonFunction.General.WriteHTML("<BR>")
        DrawTaskVoidGrid()
        CommonFunction.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML("</DIV>")
        DrawMenu()
    End Sub
    Private Sub DrawTaskCompletionGrid()

        CommonFunction.General.WriteHTML("<TABLE width=99.9% class='clsTable'>")
        CommonFunction.General.WriteHTML("<TR class=clsTRSectionHeader>")
        CommonFunction.General.WriteHTML("<TD>")
        CommonFunction.General.WriteHTML("<A href=""Javascript:TaskCompletion_div()"">")
        CommonFunction.General.WriteHTML("<Img Border=0 id=imgTaskCompletionShowHide Src='../../Images/minus.gif' title=''></A>")
        CommonFunction.General.WriteHTML("&nbsp;&nbsp; Tasks for Completion ")
        CommonFunction.General.WriteHTML("</TD></TR></TABLE>")
        CommonFunction.General.WriteHTML("<DIV id='TaskCompletion' name='TaskCompletion' height=200px style=""overflow:auto;display:''"">")
        Dim strSQL As String = "usp_Sel_RM_TaskCompletion " + m_strProjectRequirementID + "," + m_strProjectID
        Dim strCss As String = "clsTROdd"

        Dim dr As IDataReader
        dr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        CommonFunction.General.WriteHTML("<TABLE class='clsGridTable'cellpadding=0 cellspacing=1 width='99.9%'>")
        CommonFunction.General.WriteHTML("<THead class='clsTRColumnHeader'>")
        CommonFunction.General.WriteHTML("<TH align=left class=''>Task Name</TH>")
        CommonFunction.General.WriteHTML("<TH align=left class=''>Resource Name</TH>")
        CommonFunction.General.WriteHTML("<TH align=left class=''>Start Date</TH>")
        CommonFunction.General.WriteHTML("<TH align=left class=''>End Date</TH>")
        CommonFunction.General.WriteHTML("<TH align=left class=''>Actual Start Date</TH>")
        CommonFunction.General.WriteHTML("<TH align=left class=''>Work (hrs)</TH>")
        CommonFunction.General.WriteHTML("<TH align=left class=''>Actual Work (hrs)</TH>")
        CommonFunction.General.WriteHTML("<TH align=left class=''>Actual Percent Complete</TH>")
        CommonFunction.General.WriteHTML("<TH align=left class=''>Select</TH>")
        CommonFunction.General.WriteHTML("</THead>")



        While dr.Read
            CommonFunction.General.WriteHTML("<TR class='" + strCss + "'>")
            'Task Name
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML(dr("TaskName").ToString)
            CommonFunction.General.WriteHTML("</TD>")


            'Resource Name
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML(dr("EmployeeName").ToString)
            CommonFunction.General.WriteHTML("</TD>")

            'Start Date
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML(dr("StartDate").ToString)
            CommonFunction.General.WriteHTML("</TD>")

            'End Date
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML(dr("EndDate").ToString)
            CommonFunction.General.WriteHTML("</TD>")

            'Actual Start Date
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML(dr("ActualStartDate").ToString)
            CommonFunction.General.WriteHTML("</TD>")

            'Work (hrs)
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML(dr("PlannedWork").ToString)
            CommonFunction.General.WriteHTML("</TD>")

            'Actual Work (hrs)
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML(dr("ActualWork").ToString)
            CommonFunction.General.WriteHTML("</TD>")

            'Actual Percent Complete
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML(dr("ActualPercentComplete").ToString)
            CommonFunction.General.WriteHTML("</TD>")

            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML("<INPUT name=chkCompletion id=chkCompletion type=checkbox value=" + dr("TaskID").ToString + ">")
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("</TR>")
            If strCss = "clsTROdd" Then
                strCss = "clsTREvenRow"
            Else
                strCss = "clsTROdd"
            End If

        End While
        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</DIV>")
        CommonFunction.Data.DisposeDataReader(dr)

    End Sub
    Private Sub DrawTaskVoidGrid()

        CommonFunction.General.WriteHTML("<TABLE width=99.9% class='clsTable'>")
        CommonFunction.General.WriteHTML("<TR class=clsTRSectionHeader>")
        CommonFunction.General.WriteHTML("<TD>")
        CommonFunction.General.WriteHTML("<A href=""Javascript:TaskVoid_div()"">")
        CommonFunction.General.WriteHTML("<Img Border=0 id=imgTaskVoidShowHide Src='../../Images/minus.gif' title=''></A>")
        CommonFunction.General.WriteHTML("&nbsp;&nbsp; Tasks for Void ")
        CommonFunction.General.WriteHTML("</TD></TR></TABLE>")
        CommonFunction.General.WriteHTML("<DIV id='TaskVoid' name='TaskVoid' height=200px style=""overflow:auto;display:''"">")

        Dim strSQL As String = "usp_Sel_RM_TaskVoid " + m_strProjectRequirementID + "," + m_strProjectID
        Dim strCss As String = "clsTROdd"

        Dim dr As IDataReader
        dr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        CommonFunction.General.WriteHTML("<TABLE class='clsGridTable'cellpadding=0 cellspacing=1 width='99.9%'>")
        CommonFunction.General.WriteHTML("<THead class='clsTRColumnHeader'>")
        CommonFunction.General.WriteHTML("<TH align=left class=''>Task Name</TH>")
        CommonFunction.General.WriteHTML("<TH align=left class=''>Resource Name</TH>")
        CommonFunction.General.WriteHTML("<TH align=left class=''>Start Date</TH>")
        CommonFunction.General.WriteHTML("<TH align=left class=''>End Date</TH>")
        CommonFunction.General.WriteHTML("<TH align=left class=''>Actual Start Date</TH>")
        CommonFunction.General.WriteHTML("<TH align=left class=''>Work (hrs)</TH>")
        CommonFunction.General.WriteHTML("<TH align=left class=''>Actual Work (hrs)</TH>")
        CommonFunction.General.WriteHTML("<TH align=left class=''>Actual Percent Complete</TH>")
        CommonFunction.General.WriteHTML("<TH align=left class=''>Select</TH>")
        CommonFunction.General.WriteHTML("</THead>")



        While dr.Read
            CommonFunction.General.WriteHTML("<TR class='" + strCss + "'>")
            'Task Name
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML(dr("TaskName").ToString)
            CommonFunction.General.WriteHTML("</TD>")

            'Resource Name
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML(dr("EmployeeName").ToString)
            CommonFunction.General.WriteHTML("</TD>")

            'Start Date
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML(dr("StartDate").ToString)
            CommonFunction.General.WriteHTML("</TD>")

            'End Date
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML(dr("EndDate").ToString)
            CommonFunction.General.WriteHTML("</TD>")

            'Actual Start Date
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML(dr("ActualStartDate").ToString)
            CommonFunction.General.WriteHTML("</TD>")

            'Work (hrs)
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML(dr("PlannedWork").ToString)
            CommonFunction.General.WriteHTML("</TD>")

            'Actual Work (hrs)
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML(dr("ActualWork").ToString)
            CommonFunction.General.WriteHTML("</TD>")

            'Actual Percent Complete
            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML(dr("ActualPercentComplete").ToString)
            CommonFunction.General.WriteHTML("</TD>")

            CommonFunction.General.WriteHTML("<TD>")
            CommonFunction.General.WriteHTML("<INPUT name=chkVoid id=chkVoid type=checkbox value=" + dr("TaskID").ToString + ">")
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("</TR>")
            If strCss = "clsTROdd" Then
                strCss = "clsTREvenRow"
            Else
                strCss = "clsTROdd"
            End If

        End While
        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</DIV>")
        CommonFunction.Data.DisposeDataReader(dr)

    End Sub
    Private Sub DrawPageCaption()
        Dim objPageCaption As WebPage.Templates.PageCaption = New WebPage.Templates.PageCaption
        objPageCaption.GetPageCaptions(, , "Requirement: " + m_strRequirementTitle)
        CommonFunction.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        CommonFunction.General.WriteHTML("<tr class='clsTRGroupHeader'>")
        CommonFunction.General.WriteHTML("<td align='Left' >")
        CommonFunction.General.WriteHTML("Status can not be changed to the status those are mapped to close with out mapped tasks are not completed or void.")
        CommonFunction.General.WriteHTML("</td></tr></table>")
    End Sub
    Private Sub DrawMenu()
        Dim arrMenu As New System.Collections.ArrayList
        Dim arrMenuToolTip As New System.Collections.ArrayList
        Dim arrCSFunction As New System.Collections.ArrayList


        arrMenu.Add("Save")
        arrMenuToolTip.Add("Save")
        arrCSFunction.Add("Save_Click()")

        arrMenu.Add("Close")
        arrMenuToolTip.Add("Close")
        arrCSFunction.Add("Close_OnClick()")

        arrMenu.Add("?")
        arrMenuToolTip.Add("Help")
        arrCSFunction.Add("Help_OnClick('RM_SM_TEMP')")


        CommonFunction.General.WriteHTML(WebPages.Template.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip)))

    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    Private Sub ExecuteAction()
        If Request.QueryString("Action") = "COMPLETE-VOID" Then
            MarkCompleteTasks()
            MarkVoidTasks()
            Response.Write("<SCRIPT>window.opener.location.href=window.opener.document.getElementById('hidURL').value;</SCRIPT>")
        End If

    End Sub
    Private Sub MarkCompleteTasks()
        If Request.Form("chkCompletion") Is Nothing Then
            Exit Sub
        End If

        Dim m_strTaskIDs() As String
        Dim c As Integer = 0
        m_strTaskIDs = Request.Form("chkCompletion").Split(","c)
        While c < m_strTaskIDs.Length
            CommonFunction.Data.InsertOrUpdateData("usp_RM_MarkTasksComplete " + m_strTaskIDs(c), MyBase.UseSQL)
            c += 1
        End While
    End Sub
    Private Sub MarkVoidTasks()
        If Request.Form("chkVoid") Is Nothing Then
            Exit Sub
        End If
        Dim m_strTaskIDs() As String
        Dim c As Integer = 0
        m_strTaskIDs = Request.Form("chkVoid").Split(","c)
        While c < m_strTaskIDs.Length
            CommonFunction.Data.InsertOrUpdateData("usp_RM_MarkTasksVoid " + m_strTaskIDs(c) + "," + m_strProjectID, MyBase.UseSQL)
            c += 1
        End While
    End Sub
End Class
