Imports Whizible
Public Class ConvertDisscussion

    Inherits WebPages.Template.WhizTemplate
    'Protected StrDuplicate As String
    'Protected Flag As Boolean = False
    Protected m_lngQueryID As String
    Protected m_TokenKEY As String
    Protected m_PKToken_FromDT As String = ""
    Protected FromWhere As String
    Protected selectedids As String



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
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Call Initialize()

        '  If Page.IsPostBack Then
        'Call PerformActions()
        ' End If
    End Sub
    Protected Sub Init_Load()
        If (HttpContext.Current.Request.QueryString("flag") = "convert") Then

            Call ConvertToFaq()

        Else
            Call WritePage()
        End If

    End Sub


    Public Sub New()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        '' MyBase.ApplySecurity(False, 2)
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016

    End Sub
    Private Sub ConvertToFaq()


        Dim strSubject As String
        Dim strName As String
        Dim strDate As String
        Dim strFaqCode As String
        Dim strDescription As String
        Dim strRequiredId As String
        Dim strlen As Integer
        Dim cnt As Integer
        Dim strSql As String
        Dim strDepartment As String


        strSubject = HttpContext.Current.Request.Form("Subject").ToString
        strName = HttpContext.Current.Request.Form("Name").ToString
        strDate = HttpContext.Current.Request.Form("Date").ToString
        strFaqCode = HttpContext.Current.Request.Form("FaqCode").ToString
        strDescription = HttpContext.Current.Request.Form("Description").ToString
        strRequiredId = HttpContext.Current.Request.Form("RequestId").ToString
        strDepartment = HttpContext.Current.Request.Form("Department").ToString

        Dim Subject() As String
        Dim Name() As String
        Dim sDate() As String
        Dim FaqCode() As String
        Dim Description() As String
        Dim RequiredId() As String
        Dim Department() As String
        RequiredId = strRequiredId.Split(CChar(","))
        Subject = strSubject.Split(CChar(","))
        Name = strName.Split(CChar(","))
        sDate = strDate.Split(CChar(","))
        FaqCode = strFaqCode.Split(CChar(","))

        'Added by Bharat Tekade


        Description = strDescription.Split(CChar(","))
        'Description = strDescription.Split(CChar("\n"))

        'Ended By Bharat Tekade

        Department = strDepartment.Split(CChar(","))

        ' Dim flag As Boolean = False


        strlen = RequiredId.Length
        For cnt = 0 To strlen - 1

            '  StrDuplicate = "SELECT FaqCode FROM tbl_CNF_Faq Where FaqCode Like '" & FaqCode(cnt).ToString & "'"

            ' If StrDuplicate = "" Then
            'flag = True
            strSql = "usp_CRM_Ins_ConvertFaq '" + Subject(cnt).Replace("'", "''") + "','" + System.DateTime.Now.ToString + "','" + Name(cnt).Replace("'", "''") + "','" + FaqCode(cnt).Replace("'", "''") + "','" + Description(cnt).Replace("'", "''") + "','" + Department(cnt).ToString + "' "
            CommonFunction.Data.InsertOrUpdateData(strSql, True)

            '  Else
            'Response.Write("<script language ='javascript'>")
            'Response.Write("alert('Faq Code Must Be Unique');")
            'Response.Write("window.location.href('ConvertDisscussion.aspx?MasterTagID=20003&PKToken=" & Request.Form("PKToken") & "&QueryID=" & Request.Form("QueryID").ToString & "&CRMQueryDetailId=" & strRequiredId & "'); ")
            'Response.Write("return;")
            'Response.Write("</script>")
            '     flag = False

            'End If

        Next
        ' If flag = True Then

        ' Response.Write("<Script language ='javascript'>Alert('Succesfully Converted');</Script>")

        Response.Write("<script language ='javascript'>")
        Response.Write("alert('Discussion Thread(s) have been successfully converted to FAQs!');")
        'Added By Bharat Tekade on 3rd-Feb-2016 for you are not authorized to view this record issue
        Response.Write("window.opener.location.href=window.opener.location.href;")
        Response.Write("window.close();")
        'End of Added By Bharat Tekade on 3rd-Feb-2016 for you are not authorized to view this record issue
        'Response.Write("window.opener.document.forms['frmDiscussion'].Submit();")



        ' Response.Write("window.close();")
        'Response.Write("window.opener.open();") 
        '' Response.Write("refreshParent('frmDiscussion','CRM_DiscussionThread.aspx','CRM_DiscussionThread.aspx?QueryID=" & Request.Form("QueryID").ToString & "&PKToken=" & Request.Form("PKToken").ToString & "&FromWhere=" & Request.Form("FromWhere").ToString & " ');")
        'Response.Write("window.opener.close();")
        'Response.Write("window.opener.location.reload();")
        Response.Write("</script>")


        ' End If




    End Sub
    Private Sub Initialize()
        'Added by Shamkant S on 18-Jan-2016 to Generate and Validate Token
        If Not Request.QueryString("QueryID") Is Nothing Then
            m_lngQueryID = CType(Request.QueryString("QueryID"), String)
        Else
            m_lngQueryID = ""
        End If

        If Not Request.QueryString("FromWhere") Is Nothing Then
            FromWhere = CType(Request.QueryString("FromWhere"), String)
        Else
            FromWhere = ""
        End If
        If Not Request.QueryString("CRMQueryDetailId") Is Nothing Then
            selectedids = CType(Request.QueryString("CRMQueryDetailId"), String)
        Else
            selectedids = ""
        End If

        If Not Request.QueryString("PKToken") Is Nothing Then
            '  m_TokenKEY = CType(Request.QueryString("PKToken"), String)
            m_PKToken_FromDT = Trim(Request.QueryString("PKToken") & "")


        End If
        If m_PKToken_FromDT <> "" Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(m_lngQueryID, String) + CType(selectedids, String) + "0" + "0", m_PKToken_FromDT) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(m_lngQueryID, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If

        End If
        'End of addition by Shamkant S on 18-Jan-2016 to Generate and Validate Token
    End Sub
    Private Sub PerformActions()

    End Sub
    Protected Sub WritePage()


        Dim strMenu As String
        Dim cnt As Integer
        Dim dr As IDataReader
        Dim FunctionID As Integer

        Dim arrMenu() As String = {"Convert", MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        Dim arrMenuToolTip() As String = {"Convert To FAQ", MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
        Dim arrCSFunction() As String = {"Convert_OnClick()", "Close_OnClick()", "Help_OnClick()"}
        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)
        Response.Write(strMenu)

        Dim strRequestId As String
        strRequestId = HttpContext.Current.Request.QueryString("CRMQueryDetailId")
        Dim strsql As String
        Dim RequestId() As String


        RequestId = strRequestId.Split(CChar(","))




        Response.Write("<h5 align ='center' class ='clsTRPageCaption'>Plese Fill the remaining information</h5>")
        Response.Write("<br /><br />")


        Response.Write("<Table class='clsBody' width='99.9%' cellpadding=0 cellspacing=0 border = 1>")
        Response.Write("<tr class='clsTREven'>")
        'Response.Write("<Th>Name</Th>")
        Response.Write("<Th class='cslBody'>FAQ Code</Th>")
        ' Response.Write("<Th>Date</Th>")
        Response.Write("<Th>Subject</Th>")
        Response.Write("<Th class='cslBody'>Description</Th>")
        ' Response.Write("<Th>Department</Th>")

        Response.Write("</tr><tr class='clsTREven' align='center'>")

        For cnt = 0 To RequestId.Length - 1
            If (RequestId(cnt) <> "") Then
                If (cnt > 0) Then
                    Response.Write("<tr class='clsTREven' align='center'>")
                    dr = CommonFunction.Data.GetDataReader("usp_CRM_GetQueryDetailID " + CommonFunctions.General.CheckIsNothing(RequestId(cnt)), True)
                    While dr.Read

                        '  Response.Write("<td>")
                        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("Name", "Name", "clsTextBox", , , dr("SubmittedBy").ToString, "left", , , True, , True, , True, EnableHTMLEncode:=True)) '& "</td>")
                        Response.Write("<td>")
                        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("FaqCode", RequestId(cnt), "clsTextBox", , , , , , , , , , , True, True, EnableHTMLEncode:=True) & "</td>")

                        ' Response.Write("<td>")
                        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("Date", "Date", "clsTextBox", , , dr("SubmittedDate").ToString, , , , True, , True, , True, EnableHTMLEncode:=True)) '& "</td>")

                        Response.Write("<td>")
                        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("Subject", "Subject", "clsTextBox", , , , "left", , , False, , , , True, True, EnableHTMLEncode:=True) & "</td>")
                        'ended by Yogesh J for HTML encoding Date:05/10/15

                        Response.Write("<td>")
                        Response.Write(CommonFunctions.HTMLControls.DrawTextArea("Description", "Description", , "clsTextArea", , , , , 300, 30, 0, dr("DiscussionThread").ToString, "left", , , , , , , True, True, , , , , , , , EnableHTMLEncode:=True))
                        'Response.Write(CommonFunctions.HTMLControls.DrawTextBox("Description", "Description", "clsTextBox", , , dr("DiscussionThread").ToString, , , , , , , , True) & "</td>")
                        Response.Write("</td>")
                        Response.Write(CommonFunctions.HTMLControls.DrawComboBox("Department", "SELECT DepartmentID,Department FROM tbl_PM_DepartmentMaster", 100, dr("FunctionID").ToString, , , True, "clsComboBox", , , True)) ' & "</td>")
                        'Response.Write("<td>")
                        'Response.Write(CommonFunctions.HTMLControls.DrawComboBox("Department", "SELECT Department FROM tbl_PM_DepartmentMaster",, , , , True, "clsComboBox") & "</td>")
                        'Response.Write("<td>")
                        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("RequestId", "RequestId", "clsTextBox", , , RequestId(cnt), , , , , , True, , True, EnableHTMLEncode:=True)) '& "</td>")
                        'ended by Yogesh J for HTML encoding Date:05/10/15
                    End While
                    Response.Write("</tr>")

                    'Response.Write(RequestId(cnt))
                Else
                    dr = CommonFunction.Data.GetDataReader("usp_CRM_GetQueryDetailID " + CommonFunctions.General.CheckIsNothing(RequestId(cnt)), True)
                    While dr.Read

                        ' Response.Write("<td>")
                        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("Name", "Name", "clsTextBox", , , dr("SubmittedBy").ToString, "left", "Arial", , True, , True, , True, EnableHTMLEncode:=True)) ' & "</td>")
                        Response.Write("<td>")
                        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("FaqCode", RequestId(cnt), "clsTextBox", , , , "left", , , , , , , True, True, EnableHTMLEncode:=True) & "</td>")

                        '  Response.Write("<td>")
                        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("Date", "Date", "clsTextBox", , , dr("SubmittedDate").ToString, "center", , , True, , True, , True, EnableHTMLEncode:=True)) '& "</td>")

                        Response.Write("<td>")
                        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("Subject", "Subject", "clsTextBox", , , , "left", , , False, , , , True, True, EnableHTMLEncode:=True) & "</td>")
                        'ended by Yogesh J for HTML encoding Date:05/10/15

                        Response.Write("<td>")
                        'Response.Write(CommonFunctions.HTMLControls.DrawTextBox("Description", "Description", "clsTextBox", , , dr("DiscussionThread").ToString, "left", , , , , , , True) & "</td>")
                        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                        'Response.Write(CommonFunctions.HTMLControls.DrawTextArea("Description", "Description", , "clsTextArea", , , , , 300, 30, 0, dr("DiscussionThread").ToString, , , , , , , , True, True))
                        Response.Write(CommonFunctions.HTMLControls.DrawTextArea("Description", "Description", , "clsTextArea", , , , , 300, 30, 0, dr("DiscussionThread").ToString, , , , , , , , True, True, EnableHTMLEncode:=True))
                        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                        Response.Write("</td>")
                        Response.Write(CommonFunctions.HTMLControls.DrawComboBox("Department", "SELECT DepartmentID,Department FROM tbl_PM_DepartmentMaster", 100, dr("FunctionID").ToString, , , True, "clsComboBox", , , True) & "</td>")
                        'Response.Write("<td>")

                        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("RequestId", "RequestId", "clsTextBox", , , RequestId(cnt), , , , , , True, , True, EnableHTMLEncode:=True)) '& "</td>")
                        'Commented and added by Yogesh J for HTML encoding Date:05/10/15



                    End While
                End If
            End If

        Next

        'Commented and added by Yogesh J for HTML encoding Date:05/10/15

        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("QueryID", "QueryID", "clsTextBox", , , HttpContext.Current.Request.QueryString("QueryID"), , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("PKToken", "PKToken", "clsTextBox", , , HttpContext.Current.Request.QueryString("PKToken"), , , , , , True, , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("FromWhere", "FromWhere", "clsTextBox", , , HttpContext.Current.Request.QueryString("FromWhere"), , , , , , True, , True, EnableHTMLEncode:=True))

        'ended by Yogesh J for HTML encoding Date:05/10/15

    End Sub

    Private Sub WriteGrid(ByVal SQL As String)

    End Sub

End Class