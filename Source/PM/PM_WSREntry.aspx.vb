Public Class PM_WSREntry
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

    Protected m_intProjectID As Integer
    Protected m_intTimeSheetNo As Integer
    Protected m_strMode As String = ""
    Protected m_Action As String
    Protected m_strToken As String = ""
    Private strHighLights As String = ""
    Private strIssues As String = ""
    Private strSleepage As String = ""
    Private strSuggetions As String = ""
    Private strActivities As String = ""

    '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
    Protected m_strToken_FromPMTimesheet As String
    Protected m_strTimeSheetNo As String
    '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197 

    Public Sub PageInit()
        '######### Page Code starts here

        Dim strQuery, strFromDate, strToDate As String
        Call SetVariables()

        '' START : Added By ParagD On 14-Sept-2006 : Security Issue 6197
        If m_intTimeSheetNo.ToString <> "0" Then
            If (Trim(m_strToken_FromPMTimesheet & "") = "" And CommonFunctions.Security.Token.ValidateToken("0" + CType(Session("intUserID"), String) + "0" + "1049", m_strToken_FromPMTimesheet) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Project Timesheet : Generate", 1049, 0, "Timesheet No", "0")
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        '' END : Added By ParagD On 14-Sept-2006 : Security Issue 6197

        If m_strMode.ToUpper = "DELETE" Then Call DeleteAttachment()
        'strValue = MyBase.FixString(strValue, 0, False, blnMandatory)



        If Not MyBase.GetFormValue("txtHighLights") Is Nothing Then strHighLights = MyBase.FixString(MyBase.GetFormValue("txtHighLights"), 700, False, False)
        If Not MyBase.GetFormValue("txtSleepage") Is Nothing Then strSleepage = MyBase.FixString(MyBase.GetFormValue("txtSleepage"), 700, False, False)
        If Not MyBase.GetFormValue("txtIssues") Is Nothing Then strIssues = MyBase.FixString(MyBase.GetFormValue("txtIssues"), 700, False, False)
        If Not MyBase.GetFormValue("txtSuggetions") Is Nothing Then strSuggetions = MyBase.FixString(MyBase.GetFormValue("txtSuggetions"), 700, False, False)
        If Not MyBase.GetFormValue("txtActivities") Is Nothing Then strActivities = MyBase.FixString(MyBase.GetFormValue("txtActivities"), 700, False, False)

        If m_strMode.ToUpper = "INSERT" Or m_strMode = "" Then
            Dim drWSROtherAttributes As IDataReader
            drWSROtherAttributes = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_WSROtherAttributes " + m_intTimeSheetNo.ToString, MyBase.UseSQL)
            If drWSROtherAttributes.Read Then
                strHighLights = drWSROtherAttributes("HighLights").ToString
                strIssues = drWSROtherAttributes("Issues").ToString
                strSleepage = drWSROtherAttributes("Sleepage").ToString
                strSuggetions = drWSROtherAttributes("Suggetion").ToString
                strActivities = drWSROtherAttributes("Activities").ToString
                m_Action = "Update"
            Else
                m_Action = "Insert"
            End If
            CommonFunction.Data.DisposeDataReader(drWSROtherAttributes)
        ElseIf m_strMode.ToUpper = "UPDATE" Then
            m_Action = "Update"
        End If

        If m_strMode <> "" Then
            If m_Action.ToUpper = "INSERT" Then
                'Commented and Modified By JyotiG
                'Start_JG_11779_20-Mar-2007
                'Issue : PT: WSR: page Crash: When long text is entered in any of the text areas , page crashes.
                'strQuery = "EXEC usp_Ins_tbl_PM_WSROtherAttributes " + m_intProjectID.ToString + "," + m_intTimeSheetNo.ToString + ", '" + CommonFunction.General.BuildQueryString(Left(Trim(strHighLights),  3999)) + "','" + CommonFunction.General.BuildQueryString(Left(Trim(strIssues), 3999)) + "','" + CommonFunction.General.BuildQueryString(Left(Trim(strSuggetions), 3999)) + "','" + CommonFunction.General.BuildQueryString(Left(Trim(strSleepage), 3999)) + "','" + CommonFunction.General.BuildQueryString(Left(Trim(strActivities), 3999)) + "'"
                strQuery = "EXEC usp_Ins_tbl_PM_WSROtherAttributes " + m_intProjectID.ToString + "," + m_intTimeSheetNo.ToString + ", '" + Trim(strHighLights) + "','" + Trim(strIssues) + "','" + Trim(strSuggetions) + "','" + Trim(strSleepage) + "','" + Trim(strActivities) + "'"
                'End_JG_11779_20-Mar-2007
            Else
                'Commented and Modified By JyotiG
                'Start_JG_11779_20-Mar-2007
                'strQuery = "EXEC usp_Upd_tbl_PM_WSROtherAttributes " + m_intTimeSheetNo.ToString + ", '" + CommonFunction.General.BuildQueryString(Left(Trim(strHighLights), 1999)) + "','" + CommonFunction.General.BuildQueryString(Left(Trim(strIssues), 1999)) + "','" + CommonFunction.General.BuildQueryString(Left(Trim(strSuggetions), 1999)) + "','" + CommonFunction.General.BuildQueryString(Left(Trim(strSleepage), 1999)) + "','" + CommonFunction.General.BuildQueryString(Left(Trim(strActivities), 1999)) + "'"
                strQuery = "EXEC usp_Upd_tbl_PM_WSROtherAttributes " + m_intTimeSheetNo.ToString + ", '" + Trim(strHighLights) + "','" + Trim(strIssues) + "','" + Trim(strSuggetions) + "','" + Trim(strSleepage) + "','" + Trim(strActivities) + "'"
                'End_JG_11779_20-Mar-2007
            End If

            Dim drTemp As IDataReader
            drTemp = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If drTemp.Read Then
                strFromDate = drTemp(0).ToString
                strToDate = drTemp(1).ToString
            End If
            CommonFunction.Data.DisposeDataReader(drTemp)
            Response.Clear()
            ''Commented and added by Nilesh G on 22/8/2016 Purpose : PkToken generation 
            '' Response.Redirect("PM_WeeklyStatusReport.aspx?FromDate=" + strFromDate + "&ToDate=" + strToDate + "&ProjectID=" + m_intProjectID.ToString + "&TimeSheetNo=" + m_intTimeSheetNo.ToString)
            m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_intTimeSheetNo, String) + CType(Session("intUserID"), String) + "0" + "0")
            Response.Redirect("PM_WeeklyStatusReport.aspx?FromDate=" + strFromDate + "&PKToken=" + m_strToken + "&ToDate=" + strToDate + "&ProjectID=" + m_intProjectID.ToString + "&TimeSheetNo=" + m_intTimeSheetNo.ToString)
            ''End of Commented and added by Nilesh G on 22/8/2016 Purpose : PkToken generation 
        End If

        Dim strMenu As String = GenerateMenu()
        Response.Write(strMenu)

        Response.Write("<BR>")

        'Page caption
        Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGECAPTION")))

        Response.Write("<BR>")

        'Plot text areas
        Response.Write("<TABLE cellspacing=0 width=99.9% class=clsTable>")


        'Highlights
        Response.Write("<TR class=clsTREven><TD>" + MyBase.GetResourceString("HIGHLIGHTS") + "</TD></TR>")
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'CommonFunction.HTMLControls.DrawTextArea("txtHighLights", "txtHighLights", , , , "frmPM_WSREntry", , , 450, 75, , strHighLights)
        CommonFunction.HTMLControls.DrawTextArea("txtHighLights", "txtHighLights", , , , "frmPM_WSREntry", , , 450, 75, , strHighLights, EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        Response.Write("</TD>")
        Response.Write("</TR>")

        'Sleepage
        Response.Write("<TR class=clsTREven><TD>" + MyBase.GetResourceString("SLIPPAGE") + "</TD></TR>")
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'CommonFunction.HTMLControls.DrawTextArea("txtSleepage", "txtSleepage", , , , "frmPM_WSREntry", , , 450, 75, , strSleepage)
        CommonFunction.HTMLControls.DrawTextArea("txtSleepage", "txtSleepage", , , , "frmPM_WSREntry", , , 450, 75, , strSleepage, EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        Response.Write("</TD>")
        Response.Write("</TR>")

        'Issues
        Response.Write("<TR class=clsTREven><TD>" + MyBase.GetResourceString("ISSUES") + "</TD></TR>")
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'CommonFunction.HTMLControls.DrawTextArea("txtIssues", "txtIssues", , , , "frmPM_WSREntry", , , 450, 75, , strIssues)
        CommonFunction.HTMLControls.DrawTextArea("txtIssues", "txtIssues", , , , "frmPM_WSREntry", , , 450, 75, , strIssues, EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        Response.Write("</TD>")
        Response.Write("</TR>")


        'Suggetions
        Response.Write("<TR class=clsTREven><TD>" + MyBase.GetResourceString("SUGGESTIONS") + "</TD></TR>")
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'CommonFunction.HTMLControls.DrawTextArea("txtSuggetions", "txtSuggetions", , , , "frmPM_WSREntry", , , 450, 75, , strSuggetions)
        CommonFunction.HTMLControls.DrawTextArea("txtSuggetions", "txtSuggetions", , , , "frmPM_WSREntry", , , 450, 75, , strSuggetions, EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        Response.Write("</TD>")
        Response.Write("</TR>")

        'Activities
        Response.Write("<TR class=clsTREven><TD>" + MyBase.GetResourceString("ACTIVITIES") + "</TD></TR>")
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'CommonFunction.HTMLControls.DrawTextArea("txtActivities", "txtActivities", , , , "frmPM_WSREntry", , , 450, 75, , strActivities)
        CommonFunction.HTMLControls.DrawTextArea("txtActivities", "txtActivities", , , , "frmPM_WSREntry", , , 450, 75, , strActivities, EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        Response.Write("</TD>")
        Response.Write("</TR>")

        ''Save and Cancel buttons
        'Response.Write("<TR class=clsTREven><TD align=center><Input type=Button name=cmdSave class=ButtonStyle value=Save style='Width:80' Language=javascript OnClick=Save_OnClick('" + m_Action + "')>")
        'Response.Write("&nbsp;&nbsp;<Input type=Button name=cmdCancel class=ButtonStyle value=Cancel style='Width:80' Language=javascript OnClick=Cancel_OnClick()>")

        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197 
        Response.Write("<TR><TD>")

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_strToken_FromPMTimesheet, , , , , , , , , , , , True, , EnableHTMLEncode:=True)
        '''End of Modification by Dhanashri S on 7 Oct 2015 

        Response.Write("</TD></TR>")
        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197 

        Response.Write("</TABLE>")

        Response.Write("<BR>" + strMenu)

    End Sub

    Private Sub DeleteAttachment()

    End Sub

    Private Function GenerateMenu() As String
        '=====================================================================
        ' function Name         : GenerateMenu()	
        ' Purpose               : To generate menu
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 20, 2004
        ' Revisions             :
        '=====================================================================


        Dim ArrTopMenuCaptionsList As New ArrayList
        Dim ArrTopMenuToolTipsList As New ArrayList
        Dim ArrTopMenuFunctionsList As New ArrayList

        'Initialize resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
        ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
        ArrTopMenuFunctionsList.Add("Save_OnClick('" + m_Action + "')")

        ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        ArrTopMenuFunctionsList.Add("Cancel_OnClick()")

        ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        ArrTopMenuFunctionsList.Add("Help_OnClick('TS')")

        Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
        ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
        ArrTopMenuCaptionsList = Nothing

        Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String
        ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)
        ArrTopMenuToolTipsList = Nothing

        Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
        ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)
        ArrTopMenuFunctionsList = Nothing

        'Initialize resource file 
        MyBase.InitializeResources("AppResources.PM_WSREntry", "AppResources")

        'Generate menu string and return
        Return WebPage.Templates.StaticMenu.DrawMenu(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True) + "<BR>"
    End Function

    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()        
        MyBase.ApplySecurity(True)
        'End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.PM_WSREntry", "AppResources")
    End Sub

    Private Sub SetVariables()

        'ProjectId
        If Not Request.QueryString("TimeSheetNo") Is Nothing Then
            If Request.QueryString("TimeSheetNo") <> "" Then
                m_intTimeSheetNo = CType(Request.QueryString("TimeSheetNo"), Integer)
            End If
        End If

        'TimeSheetNo
        If Not Request.QueryString("ProjectID") Is Nothing Then
            If Request.QueryString("ProjectID") <> "" Then
                m_intProjectID = CType(Request.QueryString("ProjectID"), Integer)
            End If
        End If

        'Mode
        If Not Request.QueryString("Mode") Is Nothing Then
            If Request.QueryString("Mode") <> "" Then
                m_strMode = Request.QueryString("Mode").ToString
            End If
        End If

        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        If Request.QueryString("PKToken") <> "" Then
            m_strToken_FromPMTimesheet = Request.QueryString("PKToken")
        Else
            m_strToken_FromPMTimesheet = Request.Form("txtPkToken").ToString
        End If
        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

    End Sub

End Class
