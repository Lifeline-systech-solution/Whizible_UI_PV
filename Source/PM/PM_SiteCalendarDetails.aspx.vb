#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class PM_SiteCalendarDetails
    Inherits WebPages.Template.WhizTemplate

    '=====================================================================
    ' Page Name 	        :	
    ' Purpose				:	
    ' Description			:	
    ' Assumptions			:	

    ' Dependencies			:	
    ' Author				:	
    ' Created				:	
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

        If Not IsNothing(Request.QueryString("EmployeeID")) Then
            m_strEmployeeID = CType(Request.QueryString("EmployeeID"), String)
        End If

        ''Added by Yogesh J on on 01 Mar 2016 to validate Token
        ''Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
        If Request.QueryString("Date") IsNot Nothing And Request.QueryString("SiteID") IsNot Nothing And Request.QueryString("EmployeeID") IsNot Nothing Then
            ''End of Addition by Dhanashri S on 11 Aug 2016
            If (CommonFunctions.Security.Token.ValidateToken(CType(m_strEmployeeID, String) + CType(Request.QueryString("Date"), String) + CType(Request.QueryString("SiteID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then

                ' Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_YearValue, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        '  End of addition by Yogesh J on 29-Jan-2016 to validate Token 
    End Sub

#End Region

#Region "Member Variables"
    Private WithEvents m_objMenu As New StaticMenu      'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New GenericGrid     'This variable is use to plotting grid.
    Private m_objGlobal As IGlobal                      'This variable is of global object inteface. 
    Private m_objAccessRights As cAccessRights          'This variable is for access rights of page.
    Private strMenu As String                           'stores the static menu string.
    Protected m_strSiteID As String
    Protected m_strDate As String
    Private m_strMode As String
    Protected m_strProjectID As String


    Private strSiteCalendarDayID As String
    Private dblNormalHours As Double
    Private dblExtraHours As Double
    Private blnIsHoliday As Boolean
    Private blnShowSetDefault As Boolean
    Private drSiteCalendar As IDataReader
    'Added By DipaliS 5 Oct 2004
    'Purpose : To Disable the editing if Mode in ReadOnly
    Private m_blnReadOnly As Boolean = False
    'end Addition by DipaliS
    ''Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
    Protected m_strEmployeeID As String
    ''End of Addition by Dhanashri S on 11 Aug 2016

#End Region


#Region "Handling Modes"
    Public Sub HandleModes()
        m_strMode = CType(Request.QueryString("Mode"), String)
        Dim strSiteCalendarDayID As String
        Dim strSiteID As String
        Dim strNormalHours As Double
        Dim strExtraHours As Double
        Dim strSQL As String
        Dim strHoliday As String
        Dim strDate As String
        Dim drSaveSiteCalendar As IDataReader



        If Request.Form("txtSiteCalendarDayID") <> "0" Then
            strSiteCalendarDayID = CType(Request.Form("txtSiteCalendarDayID"), String)
        Else
            strSiteCalendarDayID = "NULL"
        End If

        strSiteID = CType(Request.QueryString("SiteID"), String)


        strNormalHours = CType(CommonFunctions.Data.CheckIsDBNull(Request.Form("NormalHours"), "NULL"), Double)
        strExtraHours = CType(Request.Form("ExtraHours"),Double)
        strDate = CType(Request.QueryString("Date"), String)


        strHoliday = CType(Request.Form("Holiday"), String)
        If strHoliday = "" Then
            strHoliday = "0"
        End If


        If m_strMode = "Save" Then
            strSQL = "usp_Ins_tbl_PM_ProjectSiteCalendar " + CType(strSiteCalendarDayID, String) + "," + CType(Session("intProjectID"), String) + "," + CType(strSiteID, String) + ",'" + CType(strDate, String) + "'," + CType(strNormalHours, String) + "," + CType(strExtraHours, String) + "," + CType(strHoliday, String)
            drSaveSiteCalendar = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            CommonFunctions.Data.DisposeDataReader(drSaveSiteCalendar)

            CommonFunctions.General.WriteHTML("<script language='javascript'>")
            ' Code added by SwapnilR on 22 Nov 2004
            ' Purpose : When any changes are made into previous month dates then
            '           it is giving message of retry for that instead of opener.reload
            '           opener.location.href is used.
            CommonFunctions.General.WriteHTML("opener.location.href = opener.location.href")
            ' End of code addtion by SwapnilR
            CommonFunctions.General.WriteHTML("window.close();")
            CommonFunctions.General.WriteHTML("</script>")
        End If

        If m_strMode = "SetDefault" Then
            strSQL = "usp_Del_tbl_PM_ProjectSiteCalendar " + CType(strSiteCalendarDayID, String)
            drSaveSiteCalendar = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            CommonFunctions.Data.DisposeDataReader(drSaveSiteCalendar)

            CommonFunctions.General.WriteHTML("<script language='javascript'>")
            CommonFunctions.General.WriteHTML("opener.location.reload();")
            CommonFunctions.General.WriteHTML("window.close();")
            CommonFunctions.General.WriteHTML("</script>")
        End If





    End Sub
#End Region

#Region "Functions & Procedures"

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
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        'Code Added by DipaliS 5 Oct 2004
        'Do not show the save link if mode is readonly
        If m_blnReadOnly = True Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunction() As String = {"Close_OnClick()", "Help_OnClick()"}
            strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True)
        Else
            'End Addition By DipaliS
            If blnShowSetDefault = True Then
                Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SETDEFAULT"), MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
                Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SETDEFAULT_TOOLTIP"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
                Dim arrClientSideFunction() As String = {"SetDefault()", "Save_OnClick()", "Close_OnClick()", "Help_OnClick()"}
                strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True)
            Else
                Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
                Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
                Dim arrClientSideFunction() As String = {"Save_OnClick()", "Close_OnClick()", "Help_OnClick()"}
                strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True)

            End If

            Dim strGrid As String
            'cerate the static menu.

            'Code Added by DipaliS 5 Oct 2004
        End If
        'End Addition By DipaliS



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
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================

        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION")))


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
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        m_objMenu = Nothing
        m_objGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing

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
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        '######### Page Code starts here


        '##### Get the values from QueryString
        m_strSiteID = CType(Request.QueryString("SiteID"), String)
        m_strDate = CType(Request.QueryString("Date"), String)
        '##### End 

        ' ## Code added by SwapnilR on 18th Nov 2004
        'm_strProjectID = CType(Session("intProjectID"), String)
        If Session("intProjectID") Is Nothing Then
            m_strProjectID = CType(Request.QueryString("ProjectID"), String)
        Else
            m_strProjectID = CType(Session("intProjectID"), String)
        End If

        Dim drWeekEnd As IDataReader
        Dim intIsWeekEnd As Integer

        'Code Added by DipaliS 6 oct 2004
        Dim strMode As String = ""
        If Not IsNothing(Request.QueryString("Mode")) Then
            strMode = CType(Request.QueryString("Mode"), String)
        Else
            strMode = ""
        End If

       



        If strMode.ToUpper = "READONLY" Then
            m_blnReadOnly = True
        End If
        'End addition by DipaliS

        'Get the Record from Site Calendar
        Dim strSQL As String

        If m_blnReadOnly = True Then
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'strSQL = "Select * FROM tbl_PM_ProjectSiteCalendar WHERE ProjectID = " + CType(m_strProjectID, String) + " AND SiteID = " + CType(m_strSiteID, String) + " AND Date = '" + CType(m_strDate, String) + "' and Freeze = 1"
            strSQL = "usp_sel_tbl_PM_ProjectSiteCalendar_Freeze_ProjectWise " + CType(m_strProjectID, String) + "," + CType(m_strSiteID, String) + ",'" + CType(m_strDate, String) + "'"
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
        Else
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'strSQL = "Select * FROM tbl_PM_ProjectSiteCalendar WHERE ProjectID = " + CType(m_strProjectID, String) + " AND SiteID = " + CType(m_strSiteID, String) + " AND Date = '" + CType(m_strDate, String) + "'"
            strSQL = "usp_sel_tbl_PM_ProjectSiteCalendar_ProjectWise " + CType(m_strProjectID, String) + "," + CType(m_strSiteID, String) + ",'" + CType(m_strDate, String) + "'"
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
        End If

        drSiteCalendar = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)


        If drSiteCalendar.Read Then
            strSiteCalendarDayID = CType(CommonFunctions.Data.CheckIsDBNull(drSiteCalendar("SiteCalendarDayID"), ""), String)
            dblNormalHours = CType(CommonFunctions.Data.CheckIsDBNull(drSiteCalendar("NormalHours"), "0"), Double)
            dblExtraHours = CType(CommonFunctions.Data.CheckIsDBNull(drSiteCalendar("ExtraHours"), "0"), Double)
            blnIsHoliday = CType(CommonFunctions.Data.CheckIsDBNull(drSiteCalendar("Holiday"), "0"), Boolean)
            blnShowSetDefault = True
        Else
            ' Code added by SwapnilR 18th Nov 2004
            strSQL = "EXEC usp_CheckWeekEnd " + CType(m_strProjectID, String) + ", " + CType(m_strSiteID, String) + ", '" + CType(m_strDate, String) + "'"
            drWeekEnd = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If drWeekEnd.Read Then
                intIsWeekEnd = CType(CommonFunctions.Data.CheckIsDBNull(drWeekEnd("IsWeekEnd"), "-1"), Integer)
                If (intIsWeekEnd = 1) Then
                    dblNormalHours = 0
                    dblExtraHours = 0
                    blnIsHoliday = True
                ElseIf (intIsWeekEnd = 0) Then

                    ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    ''strSQL = " SELECT WorkHrs,ExtraHoursCap FROM tbl_PM_ProjectSites WHERE ProjectID = " + CType(m_strProjectID, String) + " AND ProjectSiteID = " + CType(m_strSiteID, String)
                    strSQL = "usp_sel_tbl_PM_ProjectSites_WorkHrs_ExtraHoursCap " + CType(m_strProjectID, String) + "," + CType(m_strSiteID, String)
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    drWeekEnd = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                    dblNormalHours = 0
                    dblExtraHours = 0
                    If drWeekEnd.Read Then
                        dblNormalHours = CType(CommonFunctions.Data.CheckIsDBNull(drWeekEnd("WorkHrs"), "0"), Double)
                        dblExtraHours = CType(CommonFunctions.Data.CheckIsDBNull(drWeekEnd("ExtraHoursCap"), "0"), Double)
                    End If
                    blnIsHoliday = False
                    CommonFunction.Data.DisposeDataReader(drWeekEnd)
                Else
                    'error
                End If
            End If
            CommonFunction.Data.DisposeDataReader(drWeekEnd)
            ' added by harshada d for Whiziblesem SP7 for IssueID 4557 for DA Easy Entry on 28 Jun 2006
            '---------------------------------------------------------------------------------------
            'Added by SavitaS for Bristlecone IssueID 2355 on 13 June 2006
            'Purpose : To make NormalHours and ExtraHours zero if its holiday.
            Dim strGetHolidays As String = ""
            Dim drHolidays As IDataReader

            strGetHolidays = "Exec usp_Sel_OUHoliday " & CType(m_strProjectID, String) & ",'" & CType(m_strDate, String) & "'"
            drHolidays = CommonFunctions.Data.GetDataReader(strGetHolidays, MyBase.UseSQL)
            If drHolidays.Read Then
                dblNormalHours = 0
                dblExtraHours = 0
                blnIsHoliday = True
            End If
            CommonFunctions.Data.DisposeDataReader(drHolidays)
            'End by SavitaS
            '------------------------------------------------------
            ' end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for DA Easy Entry 28 Jun 2006
            ' End of code addtion by SwapnilR
            strSiteCalendarDayID = "0"
            blnShowSetDefault = False
            drSiteCalendar.Close()
        End If






        'This will strore the constructed menu string in a string variable.   
        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
        'Display the page caption.
        DrawPageCaption()
        Response.Write("<DIV id= 'PageDiv' Style='Width:100%;OverFlow:auto'>")
        HandleModes()
        DrawUI()
        Response.Write("</DIV>")

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        DisposeObjects()
    End Sub


    Public Sub DrawUI()



        CommonFunctions.General.WriteHTML("<TABLE CellSpacing=0 class='clsTable' width='100%'>" + vbCrLf)
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD valign=top align=right>" + MyBase.GetResourceString("NORMAL_HOURS") + "</TD>")
        'Code Commented By DipaliS 5 Oct 2004 and added the following
        'CommonFunctions.General.WriteHTML("<TD colspan='5'>&nbsp;<Input  Type=Textbox  name='NormalHours' id='NormalHours' class='clsTextBox' style='width:50px'  maxlength=15 style='' value='" + CType(dblNormalHours, String) + "' style='text-align:right' onkeypress='Javascript:OnlyNumeric(1)'><IMG src='../../Images/Star.gif' border=0></TD>")
        'Code Added by DipaliS 5 Oct 2004
        If m_blnReadOnly = False Then
            CommonFunctions.General.WriteHTML("<TD colspan='5'>&nbsp;<Input  Type=Textbox  name='NormalHours' id='NormalHours' class='clsTextBox' style='width:50px'  maxlength=15 style='' value='" + CType(dblNormalHours, String) + "' style='text-align:right' onkeypress='Javascript:OnlyNumeric(1)'><IMG src='../../Images/Star.gif' border=0></TD>")
        Else
            CommonFunctions.General.WriteHTML("<TD colspan='5'>&nbsp;<Input  Type=Textbox  name='NormalHours' id='NormalHours' class='clsTextBox' style='width:50px'  maxlength=15 style='' value='" + CType(dblNormalHours, String) + "' style='text-align:right' onkeypress='Javascript:OnlyNumeric(1)' disabled><IMG src='../../Images/Star.gif' border=0></TD>")
        End If
        'End Addition by DipaliS

        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD valign=top align=right>" + MyBase.GetResourceString("EXTRA_HOURS") + "</TD>")
        'Code Commented By DipaliS 5 Oct 2004 and added the following
        'CommonFunctions.General.WriteHTML("<TD colspan='5'>&nbsp;<Input  Type=Textbox  name='ExtraHours' id='ExtraHours' class='clsTextBox' style='width:50px'  maxlength=15 style='' value='" + CType(dblExtraHours, String) + "' style='text-align:right'  onkeypress='Javascript:OnlyNumeric(1)'><IMG src='../../Images/Star.gif' border=0></TD>")
        'Code Added by DipaliS 5 Oct 2004
        If m_blnReadOnly = False Then
            CommonFunctions.General.WriteHTML("<TD colspan='5'>&nbsp;<Input  Type=Textbox  name='ExtraHours' id='ExtraHours' class='clsTextBox' style='width:50px'  maxlength=15 style='' value='" + CType(dblExtraHours, String) + "' style='text-align:right'  onkeypress='Javascript:OnlyNumeric(1)'></TD>")
        Else
            CommonFunctions.General.WriteHTML("<TD colspan='5'>&nbsp;<Input  Type=Textbox  name='ExtraHours' id='ExtraHours' class='clsTextBox' style='width:50px'  maxlength=15 style='' value='" + CType(dblExtraHours, String) + "' style='text-align:right'  onkeypress='Javascript:OnlyNumeric(1)' disabled></TD>")
        End If
        'End Addition by DipaliS

        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD valign=top align=right>" + MyBase.GetResourceString("HOLIDAY") + "</TD>")

        'Code Added by DipaliS 5 Oct 2004
        ' Javascript function onclick is added by SwapnilR on 27th Nov 2004
        If m_blnReadOnly = False Then
            If blnIsHoliday = True Then
                CommonFunctions.General.WriteHTML("<TD colspan='5'>&nbsp;<Input type=checkbox name='Holiday' id='Holiday' class='clsCheckBox' value='1' checked onClick=setValueToZero(this)><Input  Type=Textbox  name='thisIsADummyControl' id='thisIsADummyControl' class='clsTextBox' style='WIDTH:0px;HEIGHT:0px' value='' style='text-align:Left'  TabIndex=-1 ></TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD colspan='5'>&nbsp;<Input type=checkbox name='Holiday' id='Holiday' class='clsCheckBox' value='1' onClick=setValueToZero(this)><Input  Type=Textbox  name='thisIsADummyControl' id='thisIsADummyControl' class='clsTextBox' style='WIDTH:0px;HEIGHT:0px' value='' style='text-align:Left'  TabIndex=-1 ></TD>")
            End If

        Else
            If blnIsHoliday = True Then
                CommonFunctions.General.WriteHTML("<TD colspan='5'>&nbsp;<Input type=checkbox name='Holiday' id='Holiday' class='clsCheckBox' value='1' checked disabled onClick=setValueToZero(this)><Input  Type=Textbox  name='thisIsADummyControl' id='thisIsADummyControl' class='clsTextBox' style='WIDTH:0px;HEIGHT:0px' value='' style='text-align:Left'  TabIndex=-1 ></TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD colspan='5'>&nbsp;<Input type=checkbox name='Holiday' id='Holiday' class='clsCheckBox' value='1' disabled onClick=setValueToZero(this)><Input  Type=Textbox  name='thisIsADummyControl' id='thisIsADummyControl' class='clsTextBox' style='WIDTH:0px;HEIGHT:0px' value='' style='text-align:Left'  TabIndex=-1 ></TD>")
            End If
        End If
        ' End of code addtion by SwapnilR
        'End Addition by DipaliS
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")
        CommonFunctions.General.WriteHTML("<input type='hidden' name='txtSiteCalendarDayID' id='txtSiteCalendarDayID' value='" + strSiteCalendarDayID + "'>")

        CommonFunctions.Data.DisposeDataReader(drSiteCalendar)

    End Sub


#End Region

#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        MyBase.InitializeResources("AppResources.PM_SiteCalendarDetails", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region

End Class
