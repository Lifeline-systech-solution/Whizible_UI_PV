Public Class EvaluationExpiry
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Page Name             : EvaluationExpiry
    ' Purpose               : Evaluation Period Exires page
    ' Description           : We allow user to post comments and mail then to PBN team.
    ' Parameters Passed     : 
    ' Assumptions           : AppResources.EvaluationExpiry.resx Resource file exists
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : SuryabirD
    ' Created               : Mar 20th, 2004
    ' Revisions             : 
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

    Private srrEmailTo As String
    Private Const MDB_FILE_FOLDER As String = "../../Projects/"
    Private Const MDB_CONNSTR As String = "Provider=Microsoft.Jet.OLEDB.4.0;Persist Security Info=False;Data Source="
    Private Const MDB_DB_PWD As String = "Registration.mdb;Jet OLEDB:Database Password=indianpicaso"
    Protected m_strMode As String

    Public Sub PageInit()
        ' initialize the spaces  
        Dim conRegString, strSQL As String
        Dim drExpiryDate As IDataReader
        Dim sDate, sHTML, strMenu As String
        Dim strExpiryDate, strUserName As String

        If m_strMode = "SAVE" Then
            Call SaveandSendMail()

        Else

            ' The connection string
            conRegString = MDB_CONNSTR + Server.MapPath(MDB_FILE_FOLDER) + MDB_DB_PWD

            ' open the record set object
            strSQL = "SELECT * from fixedDate"
            drExpiryDate = CommonFunctions.Data.GetDataReader(strSQL, False, conRegString)

            ' get the Expiry date from the Database
            If drExpiryDate.Read Then
                strExpiryDate = CommonFunctions.Data.CheckIsDBNull(drExpiryDate("ExpiryDate")).ToString
                'Response.Write(Server.HtmlEncode(strExpiryDate))
                sDate = DecryptString(strExpiryDate)
            Else
                sDate = ""
            End If

            ' close the record set
            CommonFunctions.Data.DisposeDataReader(drExpiryDate)

            '-- Top Menu
            strMenu = DrawMenu()
            Response.Write(strMenu + "<BR>")

            Response.Write("<DIV Name='PageDiv' ID='PageDiv' Style='WIDTH:100%;OVERFLOW:auto;'>")

            Response.Write("<TABLE border=0 cellPadding=0 cellSpacing=0 class=clsTable width = 100%>")
            Response.Write("<TR class= clsTROdd >")
            Response.Write("<TD align=left vAlign=bottom width =100%>")

            strUserName = CType(Session("strUserName"), String)
            Response.Write(MyBase.GetResourceString("DEAR") + " &nbsp;<B>" + strUserName + ",</B>")
            sHTML = "<TABLE border=0 cellPadding=0 cellSpacing=0 class=clsTable width = '100%'><BR><TR class=clsTROdd> <TD >"
            sHTML = sHTML + Replace(MyBase.GetResourceString("MSG_PBN"), "<DATE>", CommonFunctions.Dates.CGetDate(CType(sDate, Date)))
            sHTML = sHTML + "<BR>"
            'Modified By VarunA on 27-Sep-2008 
            'Purpose : To have Address and details of content change.
            'sHTML = sHTML + MyBase.GetResourceString("MSG_CONTACT")
            sHTML = sHTML + MyBase.GetResourceString("VM_ADDR")
            'sHTML = sHTML + MyBase.GetResourceString("EXTN_EMAIL")
            'End By VarunA on 27-Sep-2008 
            sHTML = sHTML + MyBase.GetResourceString("GIVE_FEEDBACK")
            Response.Write(sHTML)
            Response.Write("</TD></TR></TABLE>")

            Response.Write("</TD></TR><TR class = clsTROdd width =100%><TD align=center >")
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            ' CommonFunctions.HTMLControls.DrawTextArea("txtFeedback", "txtFeedback", , , , "frmEvaluationExpiry", , , 674, 72, 4000)
            CommonFunctions.HTMLControls.DrawTextArea("txtFeedback", "txtFeedback", , , , "frmEvaluationExpiry", , , 674, 72, 4000, EnableHTMLEncode:=True)
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            Response.Write("</TD></TR>")
            Response.Write("<TR>")
            Response.Write("<TD class=clsTDOdd align=center>")

            Response.Write("</TD></TR>")
            Response.Write("<TR>")
            Response.Write("<TD class=clsTDOdd align=left>" + MyBase.GetResourceString("THANKS_AGAIN") + "</td></TR>")
            Response.Write("<TR><TD class=clsTDOdd align =left><B>" + MyBase.GetResourceString("PBN_TEAM") + "</B></td></TR>")
            Response.Write("</TABLE>")

            Response.Write("</DIV>")

            '-- Bottom Menu
            Response.Write("<BR>")
            Response.Write(strMenu)
        End If
    End Sub


    Private Sub SaveandSendMail()
        '=====================================================================
        ' Procedure Name        : SaveandSendMail
        ' Purpose               : Send comments posted as Email and Show User 'Thanks' Message 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Mar 15,2004   
        '=====================================================================
        Dim sSQL, sFromMailID As String

        Call SendExpiryEmail()
        Response.Write("<TABLE class=clsTABLE cellspacing=0 Width='99.9%'>")
        Response.Write("<TR><TD align=center class=clsTDOdd>" + MyBase.GetResourceString("THANKS", False) + "</TD></TR>")
        Response.Write("<TR><TD align=right class=clsTDOdd><A HREF=../../Default.aspx>Login</A></TD></TR>")
        Response.Write("<TABLE>")

    End Sub

    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        '=====================================================================
        Dim objMenu As New WebPages.Template.StaticMenu

        '-- SEND Link 
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SEND")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SEND_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {"Save_OnClick()"}

        Dim strMenu As String = objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        objMenu = Nothing

        Return strMenu

    End Function

    Private Sub SendExpiryEmail()
        '=====================================================================
        ' Procedure Name        : SendExpiryEmail
        ' Purpose               : Sends Feedback Email to PBN Team 
        ' Description           : Sends Feedback Email to PBN Team 
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Mar 19,2004   
        '=====================================================================
        '-- Email CSPL_MAIL_ID ,we from resource file : projectbynet@compulnk.com

        Dim sMailBody As String
        ' get the text area 's text (the feedback given by the evaluater
        sMailBody = MyBase.GetFormValue("txtFeedback")

        ' If there was no feedback given dont send mail
        If sMailBody.Trim <> "" Then
            ' Send Mail 
            Try
                CommonFunction.Emails.AppSendEmail(MyBase.GetResourceString("CSPL_MAIL_ID"), CommonFunction.Application.Email, MyBase.GetResourceString("CUST_FEEDBACK"), sMailBody)
            Catch
            End Try
        End If

    End Sub

    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'Modified By VarunA on 27-Sep-2008
        'Purpose : To have Address and details of content change.
        'MyBase.InitializeResources("AppResources.EvaluationExpiry", "AppResources")
        MyBase.InitializeResources("AppEvaluationExpiry.EvaluationExpiry", "AppEvaluationExpiry")
        'End By VarunA on 27-Sep-2008
    End Sub

    Private Sub EvaluationExpiry_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("MODE"))
    End Sub

    Private Function DecryptString(ByVal strEncrypted As String) As String
        '=====================================================================
        ' Procedure Name        :   DecryptString
        ' Description           :   Decrypts the passed string
        ' Purpose               :
        ' Parameters Passed     :   strEncrypted As String i.e. the string to be Decrypted
        ' Returns               :   The DEcrypted String
        ' Parameters Affected   :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                :   SuryabirD
        ' Created               :   Tuesday, May 22, 2001 14:40
        ' Revisions             :
        '=====================================================================
        Dim intStrArr() As String
        Dim intEncryptNum, intCount As Integer

        'Decrypt string if passed string exists
        If strEncrypted + "" <> "" Then
            ReDim intStrArr(strEncrypted.Length)
            intEncryptNum = 1
            'Taking each character 1 by 1 and reconverting Ascii chars to Chars
            'after subtracting intEncryptNum from them
            For intCount = 1 To strEncrypted.Length
                intStrArr(intCount) = CType(Asc(Mid(strEncrypted, intCount, 1)) - intEncryptNum, String)
                intEncryptNum = intEncryptNum + 2
                intStrArr(intCount) = Chr(CType(intStrArr(intCount), Integer))
            Next

            DecryptString = Join(intStrArr, "")
        Else
            DecryptString = strEncrypted
        End If
    End Function

End Class
