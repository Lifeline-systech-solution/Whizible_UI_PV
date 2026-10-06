Imports CommonFunctions
Imports System.Web.HttpUtility

Public Class DocumentReview_Comments
    Inherits WebPages.Template.WhizTemplate

#Region "GLOBAL VARIABLES"
    Protected CONST_MODE_REVIEW As String = "REVIEW"
    Protected CONST_ACTION_SAVE As String = "SAVE"
    Protected m_strWindowTitle As String
    Protected m_blnAddAccess As Boolean
    Protected m_blnDelAccess As Boolean
    Protected m_strProjectID As String
    Protected m_strMode As String
    Protected m_strAction As String
    Protected m_intProjectDocumentReftypeid As Integer
    Protected m_strLoginType As String
    Protected m_strDocumentType As String
    Protected m_strDocumentID As String
    Protected m_strToken As String
    Protected m_strParentToken As String
    Protected m_intUniqueID As String
    Protected m_lngUserID As Long
    Protected m_strUserName As String
    Private WithEvents m_objGrid As New WebPage.Templates.GenericGrid
#End Region


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
        ' Added  By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting


        MyBase.ApplySecurity(True)
        ' End Added  By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Call PageInit()

        If Request.QueryString("Mode").ToUpper = CONST_MODE_REVIEW Then
            m_strWindowTitle = ("Document Review")
        End If

        m_strToken = ""
        m_strParentToken = ""

        If HttpContext.Current.Request.QueryString("ParentToken") Is Nothing Then
            m_strParentToken = Request.Form("txthidParentToken") & ""
        Else
            m_strParentToken = Request.QueryString("ParentToken") & ""
        End If
        If HttpContext.Current.Request.QueryString("PkToken") Is Nothing Then
            m_strToken = Request.Form("txthidToken") & ""
        Else
            m_strToken = Request.QueryString("PkToken") & ""
        End If

        m_intUniqueID = Request.QueryString("UniqueID") + ""
        m_lngUserID = CType(Session("intUserID").ToString, Long)



        If HttpContext.Current.Request.QueryString("MasterTagID") = "3721" Then
            If HttpContext.Current.Request.QueryString("MasterTagID") = "3721" And HttpContext.Current.Request.QueryString("PkToken") Is Nothing Then
                m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_intUniqueID, String) + CType(m_lngUserID, String) + "0" + "3721")
            Else
                m_strToken = Request.QueryString("PkToken") & ""

            End If
        End If


    End Sub


    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim objGlobal As WebPages.Template.IGlobal
        Dim objAccess As WebPage.Templates.AccessRights
        Dim strDocumentName As String

        'initialize the resource file for documents
        MyBase.InitializeResources("AppResources.RM_Documents", "AppResources")

        m_strAction = Request.QueryString("Action") & ""
        m_strMode = Request.QueryString("Mode") + ""
        m_intProjectDocumentReftypeid = CInt(Request.QueryString("ProjectDocumentReftypeid"))
        m_strLoginType = Session("LoginType").ToString + ""
        'm_strProjectID = Session("intProjectID").ToString + ""
        m_strProjectID = Request.QueryString("ProjectID")
        If Request.Form("hidProjectID") <> "" Then
            m_strProjectID = Request.Form("hidProjectID")
        End If
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidProjectID id=hidProjectID value=" + m_strProjectID + ">")
        'Get the DocumentID
        m_strDocumentType = CStr(Request.QueryString("DocumentType"))

        'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        'strSQL = "Select DocumentID,FileName from tbl_RM_ProjectReqDocument Where ProjectDocumentRefTypeId=" + m_intProjectDocumentReftypeid.ToString
        strSQL = "usp_sel_tbl_RM_ProjectReqDocument_DocumentID " + m_intProjectDocumentReftypeid.ToString
        'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        objDR = Data.GetDataReader(strSQL, True)
        If objDR.Read Then
            m_strDocumentID = CStr(objDR.Item("DocumentID"))
            strDocumentName = CStr(objDR.Item("FileName"))
        End If
        CommonFunctions.Data.DisposeDataReader(objDR)

        'Get the Reviewer name for the current session
        m_strUserName = Session("strUserName").ToString + ""

        'get the access settings for the user
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objGlobal = MyBase.GlobalObject
        objAccess = New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add
        m_blnDelAccess = objAccess.Delete
        'blnEditAccess = objAccess.Edit
        objAccess = Nothing

        Select Case m_strMode.ToUpper.Trim


            Case CONST_MODE_REVIEW

                If m_strAction <> "" Then
                    Call performReviewAction()

                End If


                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE")) : arrClientSideFunctions.Add("ReviewSave_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP")) : arrClientSideFunctions.Add("Help_OnClick('3721')")

                'copy all the element to string array
                Dim arrstrMenu(arrMenu.Count - 1) As String
                Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
                Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
                arrMenu.CopyTo(arrstrMenu)
                arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrClientSideFunctions = Nothing

                'draw upper menu
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
                General.WriteHTML(strMenu)

                'Display the (* Mandatory) PageLegends 
                Dim strarrLegend() As String = {"Mandatory"}
                Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
                General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, "Document Review", "Document Name  : " + strDocumentName)
                General.WriteHTML("<BR>")

                'plot the screen for document upload
                Call plotDocumentReviewScreen()

                'plot the lower menu
                General.WriteHTML("<BR>")
                General.WriteHTML(strMenu)


        End Select

        objGlobal = Nothing
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotDocumentReviewScreen
    ' Parameters Passed		:	None
    ' Returns				:	None
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the controls for document review screen.
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	ChristinaT
    ' Created				:	4 Jan 2007
    '=====================================================================
    Private Sub plotDocumentReviewScreen()
        Dim strDocumentRefID As String
        Dim strComments As String
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim strDate As String

        'Get then current date and time 
        strDate = CommonFunction.Dates.CGetDateTime(Date.Now) + ""

        'get the docuement ref ID and Comments
        strComments = HttpContext.Current.Request.Form("txtComments") + ""
        strSQL = "usp_sel_tbl_RM_GetHistory " + m_strDocumentID.Trim + "," + m_strProjectID.Trim + "," + m_intProjectDocumentReftypeid.ToString
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDr.Read Then
            If Not IsDBNull(objDr("DocumentRefTypeID")) Then
                strDocumentRefID = objDr("DocumentRefTypeID").ToString + ""
            Else
                strDocumentRefID = m_intProjectDocumentReftypeid.ToString
            End If

        End If
        Data.DisposeDataReader(objDr)





        General.WriteHTML("<Div id='DivBody' width=100% height=90% style='overflow: auto;' >")
        General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")
        'display Reviewer's name
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' width=30% >" + MyBase.GetResourceString("LBL_REVIEWEDBY") + "&nbsp</TD>")
        General.WriteHTML("<TD align='left'>" + m_strUserName + "</TD>")
        General.WriteHTML("<TD></TD>")
        General.WriteHTML("<TD></TD>")
        General.WriteHTML("</TR>")

        'display Review date
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right'>" + MyBase.GetResourceString("LBL_REVIEW_DATE") + "&nbsp</TD>")
        General.WriteHTML("<TD align='left'>" + strDate.Trim + "</TD>")
        General.WriteHTML("<TD></TD>")
        General.WriteHTML("<TD></TD>")
        General.WriteHTML("</TR>")

        'plot the TextArea for Review Comments
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='right' valign='top' >" + MyBase.GetResourceString("LBL_REVIEWCOMMENTS") + "&nbsp</TD>")
        General.WriteHTML("<TD align='left' >")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'General.WriteHTML(HTMLControls.DrawTextArea("txtComments", "txtComments", "Review Comments", , , "frmDocumentReview", , , 350, 100, 500, strComments.Trim, , , , , , , , True, True))
        General.WriteHTML(HTMLControls.DrawTextArea("txtComments", "txtComments", "Review Comments", , , "frmDocumentReview", , , 350, 100, 500, strComments.Trim, , , , , , , , True, True, EnableHTMLEncode:=True))
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        General.WriteHTML("</TD>")


        'Purpose:Hidden variable that will store value of token that is passed in edit mode from Task List Page

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        General.WriteHTML("<TD align='left'>" + HTMLControls.DrawTextBox("txthidToken", "txthidToken", value:=m_strToken, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>")
        General.WriteHTML("<TD align='left'>" + HTMLControls.DrawTextBox("txthidParentToken", "txthidParentToken", value:=m_strParentToken, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True) + "</TD>")
        'ended by Yogesh J for HTML encoding Date:06/10/15
        General.WriteHTML("</TR>")

        General.WriteHTML("</Table>")
        General.WriteHTML("</Div>")

        'plot the grid for previous comments
        Dim arrColHeader() As String = {"Reviewed By", "Reviewed Date", "Comments"}
        Dim arrAN() As String = {"ReviewedBy", "ReviewDate", "Comments"}

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'create the SP for grid data without sorting 
        strSQL = "Exec usp_Sel_RM_ProjectDocument_ReviewComments " + m_intProjectDocumentReftypeid.ToString

        'create Grid object and set the properties
        With m_objGrid
            .ActualColumnArray = arrAN
            .UserFriendlyColumnArray = arrColHeader
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 200
            .DIVStyle = "overflow:auto; width:100% "
            .NoOfDataColumns = 3
            .PrinterFriendlyVersion = False
            .VerticalDisplay = False
            .ColNameToolTipOnEachRow = True
            .returnHTML = False
            .EmptyValueReplacement = "-"
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL

            'plot the grid 
            .DrawGrid()
        End With
        m_objGrid = Nothing

        'close the body Div
        General.WriteHTML("</Div>")


    End Sub
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.DataField.Trim.ToUpper = "COMMENTS" Then

            Dim strComments As String
            strComments = Args.DataReader("Comments").ToString
            strComments = HtmlEncode(strComments)
            Args.StringToBeInserted = "<TD><PRE>" & strComments & "</PRE></TD>"
            Cancel = True

        End If
        If Args.DataField.Trim.ToUpper = "REVIEWDATE" Then
            Args.ShowTimeWithDate = True
        End If
    End Sub
    '=====================================================================
    ' Procedure Name		:	performReviewAction
    ' Parameters Passed		:	None
    ' Returns				:	None
    ' Parameters Affected	:	None
    ' Purpose				:	To update the database for the given document ID
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	ChristinaT
    ' Created				:	4 Jan 2007

    '=====================================================================
    Private Sub performReviewAction()
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strComments As String
        Dim strDate As String
        Dim blnSendEMail As Boolean
        Dim blnDisplayMsg As Boolean
        Dim strFromEmailID As String
        Dim strTOEmailID As String
        Dim strCCToEmailId As String
        Dim strSubject As String
        Dim strEmailMsg As String



        'Get then current date and time 
        strDate = CommonFunction.Dates.CGetDateTime(Date.Now) + ""

        'Get the Review comments
        strComments = HttpContext.Current.Request.Form("txtComments") + ""
        If strComments.Length > 3800 Then strComments = strComments.Substring(0, 3800)
        If strComments <> "" Then
            Select Case m_strAction
                Case CONST_ACTION_SAVE
                   
                    strSQL = "usp_Ins_tbl_RM_DocumentReview " + m_intProjectDocumentReftypeid.ToString + ",'" + m_strUserName + "','" + strDate + "','" + General.BuildQueryString(strComments) + "'"
                    Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                    'get the settings for sending email
                    strSQL = "usp_Sel_tbl_PM_EmailMessages 477"
                    objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                    If objDR.Read Then

                        If Not IsDBNull(objDR("SendMail")) Then
                            blnSendEMail = CType(objDR("SendMail"), Boolean)
                        Else
                            blnSendEMail = False
                        End If
                        If Not IsDBNull(objDR("ShowPopup")) Then
                            blnDisplayMsg = CType(objDR("ShowPopup"), Boolean)
                        Else
                            blnDisplayMsg = False
                        End If
                    End If

                    CommonFunctions.Data.DisposeDataReader(objDR)


                    'check the settings and send email
                    If blnSendEMail = True Then
                        If blnDisplayMsg = True Then


                            ' Call CommonFunction.EmailMessages.RMMessages.GetEmailMessage_477(strFromEmailID, strTOEmailID, strCCToEmailId, strSubject, strEmailMsg, m_intProjectDocumentReftypeid)
                            'write client side script to display the message window
                            General.WriteHTML("<Script language=javascript>")
                            General.WriteHTML("window.open('../RM/RM_SendEmail.aspx?MessageID=477&ProjectDocumentRefTypeID=" + m_intProjectDocumentReftypeid.ToString + "','','resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                            General.WriteHTML("window.close();")
                            General.WriteHTML("</Script>")
                        Else
                            'send email silently
                            Call CommonFunction.Emails.AppSendEmailWithCC(strTOEmailID, strCCToEmailId, strFromEmailID, strSubject, strEmailMsg)
                        End If
                    End If
                    ''close review window and refresh the parent page
                    'General.WriteHTML("<Script language=javascript>")
                    'General.WriteHTML(" refreshParent('frmCommonList','DocumentReview_CommonList.aspx?','DocumentReview_CommonList.aspx?FromWhere=RM&MasterTagID=3721');")
                    'General.WriteHTML("window.close();")
                    'General.WriteHTML("</Script>")


            End Select
        End If
    End Sub

End Class
