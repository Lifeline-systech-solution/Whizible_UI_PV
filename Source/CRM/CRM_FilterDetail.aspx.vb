Public Class CRM_FilterDetail
    Inherits WebPages.Template.WhizTemplate


    Protected m_strMode As String = ""
    Protected m_strAction As String = ""
    Protected m_strSortBy As String = ""
    Protected m_strSortOrder As String = ""
    Protected m_strAlphabet As String = "-1"
    Protected m_strFromWhere As String = ""
    Protected m_intRefresh As Integer = 0
    Protected m_intValidFilter As Integer = 1
    Protected m_lngFilterID As Long = 0

    Protected m_ApplyFilter As Integer = 0

    Private m_lngEmployeeID As Long
    Private m_intRoleID As Integer
    Private m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Private m_blnUseSQL As Boolean

    'Added By NitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
    Protected m_lngCRMID As Long = 0
    'End Addition  By NitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293


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
        If Page.IsPostBack Then
            Call PerformActions()
        End If
    End Sub


    Public Sub New()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        ''COMMENTED AND ADDED BY NILESH G ON 24/10/2016 PURPOSE : SECURITY  
        ''MyBase.ApplySecurity(False, 2)
        MyBase.ApplySecurity(True)
        ''END OF COMMENTED AND ADDED BY NILESH G ON 24/10/2016 PURPOSE : SECURITY  
    End Sub


    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the module variables here
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 26,2004
        ' Revisions             :
        '=====================================================================

        ' page number
        If Not Request.QueryString("PageNumber") Is Nothing Then
            m_strAlphabet = Request.QueryString("PageNumber").ToString
        End If
        ' mode of the page
        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode").ToString
        Else
            m_strMode = ""
        End If
        ' Action of the page
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If
        ' from where?? DB/SR/AR
        If Not Request.QueryString("FromWhere") Is Nothing Then
            m_strFromWhere = Request.QueryString("FromWhere").ToString
        Else
            m_strFromWhere = ""
        End If
        ' Sort by of the page
        If Not Request.QueryString("SortBy") Is Nothing Then
            m_strSortBy = Request.QueryString("SortBy").ToString
        Else
            m_strSortBy = "FilterName"
        End If
        ' Sort order of the page
        If Not Request.QueryString("SortOrder") Is Nothing Then
            m_strSortOrder = Request.QueryString("SortOrder").ToString
        Else
            m_strSortOrder = "ASC"
        End If


        m_lngFilterID = CType(Request.QueryString("FilterID"), Long)
        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_intRoleID = CType(Session("intPostID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        'Added By NitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
        Dim strSQL As String
        Dim dr As IDataReader
        strSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
        Else
            m_lngCRMID = 0
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
        'End Addition  By NitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293

    End Sub


    Private Sub PerformActions()
        '=====================================================================
        ' Procedure Name        : PerformActions()	
        ' Purpose               : To take requested actions on the page
        ' Description           : The proc. performs the actions for the page
        '                         Deletes, updates and inserts are done
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : Module variables are set.
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 26,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim dr As IDataReader

        Select Case UCase(Trim(m_strAction & ""))

            Case "SAVE"

                If VerifyFilter(MyBase.GetFormValue("txtFilter", False)) = True Then

                    If UCase(Trim(m_strMode & "")) = "EDIT" Then
                        ' update the record
                        strSQL = "usp_CRM_Update_Filter	" & m_lngFilterID
                        strSQL = strSQL & ",'" & MyBase.GetFormValue("txtFilterName") & "'"

                        ' Modified by NitinVS on 10 Aug 2005 for WhizibleSEM SP4 IssueID 2 
                        ' Replaced New Line Character wiht Blank 

                        strSQL = strSQL & ",'" & Replace(MyBase.GetFormValue("txtFilter"), Chr(13), "") & "'"

                        ' End Modification  by NitinVS on 10 Aug 2005 for WhizibleSEM SP4 IssueID 2

                        CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                    Else
                        ' insert the NEW filter
                        strSQL = "usp_CRM_Insert_Filter	" & m_lngEmployeeID
                        strSQL = strSQL & ",'" & MyBase.GetFormValue("txtFilterName") & "'"
                        strSQL = strSQL & ",'" & MyBase.GetFormValue("txtFilter") & "'"

                        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                        If dr.Read Then
                            m_lngFilterID = CType(CommonFunctions.Data.CheckIsDBNull(dr("FilterID"), "0"), Long)
                        End If
                        CommonFunctions.Data.DisposeDataReader(dr)
                        ' set the mode to Edit
                        m_strMode = "EDIT"
                    End If
                    m_intRefresh = 1
                    m_intValidFilter = 1
                Else
                    m_intValidFilter = 0
                End If

            Case "APPLY_WITHOUT_SAVING"

                If VerifyFilter(MyBase.GetFormValue("txtFilter", False)) = True Then
                    m_intRefresh = 1
                    m_intValidFilter = 1
                    'Added By KapilGK On 16-10-2006 
                    'for Displaying First Page of Parent Data after Applying any filter
                    m_ApplyFilter = 1
                    'End of Addition By KapilGK
                    Session("strCRM_Filter_" & UCase(Trim(m_strFromWhere & ""))) = MyBase.GetFormValue("txtFilter", False)
                Else
                    m_intValidFilter = 0
                End If

                'Added by ShraddhaM on 20,Apr 2009 for "Save and apply"
            Case "SAVEANDAPPLY"

                If VerifyFilter(MyBase.GetFormValue("txtFilter", False)) = True Then

                    If UCase(Trim(m_strMode & "")) = "EDIT" Then
                        ' update the record
                        strSQL = "usp_CRM_Update_Filter	" & m_lngFilterID
                        strSQL = strSQL & ",'" & MyBase.GetFormValue("txtFilterName") & "'"

                        ' Modified by NitinVS on 10 Aug 2005 for WhizibleSEM SP4 IssueID 2 
                        ' Replaced New Line Character wiht Blank 

                        strSQL = strSQL & ",'" & Replace(MyBase.GetFormValue("txtFilter"), Chr(13), "") & "'"

                        ' End Modification  by NitinVS on 10 Aug 2005 for WhizibleSEM SP4 IssueID 2

                        CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                    Else
                        ' insert the NEW filter
                        strSQL = "usp_CRM_Insert_Filter	" & m_lngEmployeeID
                        strSQL = strSQL & ",'" & MyBase.GetFormValue("txtFilterName") & "'"
                        strSQL = strSQL & ",'" & MyBase.GetFormValue("txtFilter") & "'"

                        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                        If dr.Read Then
                            m_lngFilterID = CType(CommonFunctions.Data.CheckIsDBNull(dr("FilterID"), "0"), Long)
                        End If
                        CommonFunctions.Data.DisposeDataReader(dr)
                        ' set the mode to Edit
                        m_strMode = "EDIT"
                    End If
                    m_intRefresh = 1
                    m_intValidFilter = 1
                Else
                    m_intValidFilter = 0
                End If


                If VerifyFilter(MyBase.GetFormValue("txtFilter", False)) = True Then
                    m_intRefresh = 1
                    m_intValidFilter = 1
                    'Added By KapilGK On 16-10-2006 
                    'for Displaying First Page of Parent Data after Applying any filter
                    m_ApplyFilter = 1
                    'End of Addition By KapilGK
                    Session("strCRM_Filter_" & UCase(Trim(m_strFromWhere & ""))) = MyBase.GetFormValue("txtFilter", False)
                Else
                    m_intValidFilter = 0
                End If

                'CommonFunction.General.WriteHTML("<script language=javascript>")

                'CommonFunction.General.WriteHTML("var url;")
                'CommonFunction.General.WriteHTML("url=replaceSubstring(window.opener.location.href,'Action=','Action1=');")
                'CommonFunction.General.WriteHTML("url=replaceSubstring(url,'PageNumber=','PageNumber1=');")
                'CommonFunction.General.WriteHTML("window.opener.location.href=url+'&PageNumber=1';")

                'CommonFunction.General.WriteHTML("var objParetncboFilter = window.opener.document.forms['frmDashboard'].elements['cboFilter'];")
                'CommonFunction.General.WriteHTML("alert('1');")
                'CommonFunction.General.WriteHTML("alert(objParetncboFilter);")
                'CommonFunction.General.WriteHTML("objParetncboFilter.value = " + m_lngFilterID.ToString() + " ;")
                'CommonFunction.General.WriteHTML("</script>")

            Case Else

        End Select

    End Sub


    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To write the page for adding report to user Dashboards
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Feb 26,2004
        ' Revisions             :
        '=====================================================================
        'Save And Apply link added by ShraddhaM  for WhizibleSem8 
        Dim arrMenu() As String = {"Save And Apply", MyBase.GetResourceString("MENU_APPLY_WITHOUT_SAVING"), MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_BACK"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        Dim arrMenuToolTip() As String = {"Save And Apply", MyBase.GetResourceString("MENU_APPLY_WITHOUT_SAVING_TOOLTIP"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_BACK_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
        Dim arrCSFunction() As String = {"SaveAndApply_OnClick()", "ApplyWithoutSaving_OnClick()", "Save_OnClick()", "Back_OnClick()", "Close_OnClick()", "Help_OnClick('CRM_FILTERS')"}
        Dim strSQL As String
        Dim dr As IDataReader
        Dim strMenu As String

        Dim strFromWhere As String

        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        Dim strFilterName As String = ""
        Dim strFilter As String = ""

        strFilterName = Trim(MyBase.GetFormValue("txtFilterName", False) & "")
        strFilter = Trim(MyBase.GetFormValue("txtFilter", False) & "")

        If Not Page.IsPostBack Then
            If UCase(Trim(m_strMode & "")) = "EDIT" Then
                ' get the value from database for the filter
                strSQL = "usp_sel_tbl_CRM_Filters " & m_lngFilterID & "," & m_lngEmployeeID
                dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                If dr.Read Then
                    strFilter = dr("FilterText").ToString
                    strFilterName = dr("FilterName").ToString
                End If
                CommonFunctions.Data.DisposeDataReader(dr)
            End If
        End If

        ' menu
        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)

        MyBase.InitializeResources("AppResources.CRM_FilterDetail", "AppResources")

        With Response

            'menu
            .Write(strMenu)

            'mandatory legend
            WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend)
            MyBase.InitializeResources("AppResources.CRM_RequestList", "AppResources")
            Select Case UCase(Trim(m_strFromWhere & ""))
                Case "SR" : strFromWhere = MyBase.GetResourceString("SUBMITTED_REQUESTS_CAPTION")
                Case "AR" : strFromWhere = MyBase.GetResourceString("ASSIGNED_REQUESTS_CAPTION")
                Case "DB" : strFromWhere = MyBase.GetResourceString("EDASHBOARD_CAPTION")
                Case Else : strFromWhere = ""
            End Select

            MyBase.InitializeResources("AppResources.CRM_FilterDetail", "AppResources")

            'page caption
            If UCase(Trim(m_strMode & "")) = "NEW" Then
                .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_NEW_FILTER") & " [" & strFromWhere & "]"))
            Else
                .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_FILTER_DETAILS") & " [" & strFromWhere & "]"))
            End If

            .Write("<BR>")

            .Write("<DIV id=divList style='overflow:auto'>")
            ' filter name
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            .Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            .Write("<tr class=clsTREven>" & vbCrLf)
            .Write("<td width='100%'>" & vbCrLf)
            .Write(MyBase.GetResourceString("CAPTION_FILTER_NAME"))
            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txtFilterName", "txtFilterName", , 300, 50, strFilterName, , , , , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:05/10/15
            .Write("</td>" & vbCrLf)
            .Write("</tr>" & vbCrLf)
            .Write("</Table>" & vbCrLf)

            .Write("<BR>" & vbCrLf)
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            .Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            .Write("<tr class=clsTREven>" & vbCrLf)

            ' fields for filters
            .Write("<td  align=left NoWrap>" & MyBase.GetResourceString("CAPTION_FIELD") & vbCrLf)

            'Modifed By NitinVS on 20 Feb 2007 for WhizibleSEM SP 9 IssueId =10366
            strSQL = "usp_CRM_Fields_ForCombo '" + m_strLoginType + "'"
            'End Modification By NitinVS on 20 Feb 2007 for WhizibleSEM SP 9 IssueId =10366

            'Added By Amol Changle On: 24 jul 2009
            'Purpose: To select custom fields Role specific
            strSQL += "," + m_lngEmployeeID.ToString()
            'End Addition

            CommonFunctions.HTMLControls.DrawComboBox("cboField", strSQL, , , "onchange=javascript:cboField_OnChange()", True)
            .Write("</td>" & vbCrLf)

            ' operator
            .Write("<td  align=left NoWrap>" & MyBase.GetResourceString("CAPTION_OPERATOR") & vbCrLf)
            strSQL = "usp_CRM_Operators_ForCombo"
            CommonFunctions.HTMLControls.DrawComboBox("cboOperator", strSQL)
            .Write("</td>" & vbCrLf)


            '------------------------------------------------------------------------------
            ' value

            ' text for value
            .Write("<td id=TDValue  align=left NoWrap >" & MyBase.GetResourceString("CAPTION_VALUE") & vbCrLf)
            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txtValue", "txtValue", , 100, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:05/10/15
            .Write("</td>" & vbCrLf)


            ' assign to combo(dept. users)
            'Commented By ShraddhaM on 23,July 2007 for AssignTo Combo Changed to TextBox
            '.Write("<td id=TDAssignTo  align=left style='Display:None'>" & MyBase.GetResourceString("CAPTION_VALUE") & vbCrLf)
            'strSQL = "usp_CRM_Filters_Username_ForCombo " & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(m_strLoginType & "") & "'"
            'CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", strSQL, , m_strUserName)
            '.Write("</td>" & vbCrLf)
            'End of Comment By ShraddhaM on 23,July 2007 

            'Added By ShraddhaM on 23,July 2007 for AssignTo Combo Changed to TextBox
            .Write("<TD align=left id='TDAssignTo' style='Display:None'><A Href='JavaScript:AssignTo_OnClick()' >Assign To</A></TD>" & vbCrLf)
            'End of Addition By ShraddhaM on 23,July 2007 for AssignTo changes

            ' date
            .Write("<td id=TDDate  align=left style='Display:None'>" & MyBase.GetResourceString("CAPTION_VALUE") & vbCrLf)
            CommonFunctions.HTMLControls.DrawDateControl("txtDate", "txtDate", , , , , "frmFilterDetails")
            .Write("</td>" & vbCrLf)

            ' sub request type combo
            .Write("<td id=TDSubRequestType  align=left style='Display:None'>" & MyBase.GetResourceString("CAPTION_VALUE") & vbCrLf)
            strSQL = "usp_CRM_Filters_SubRequestType_ForCombo " & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(m_strLoginType & "") & "'"
            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL)
            .Write("</td>" & vbCrLf)

            ' submitted by(all users)
            .Write("<td id=TDSubmittedBy  align=left style='Display:None'>" & MyBase.GetResourceString("CAPTION_VALUE") & vbCrLf)
            strSQL = "usp_CRM_Filters_SubmittedBy_ForCombo " & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(m_strLoginType & "") & "'"
            CommonFunctions.HTMLControls.DrawComboBox("cboSubmittedBy", strSQL, , m_strUserName)
            .Write("</td>" & vbCrLf)

            ' status
            .Write("<td id=TDStatus  align=left style='Display:None'>" & MyBase.GetResourceString("CAPTION_VALUE") & vbCrLf)
            strSQL = "usp_CRM_Filters_Status_ForCombo"
            CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strSQL)
            .Write("</td>" & vbCrLf)

            ' priotity
            .Write("<td id=TDPriority  align=left style='Display:None'>" & MyBase.GetResourceString("CAPTION_VALUE") & vbCrLf)
            strSQL = "usp_CRM_Filters_Priority_ForCombo"
            CommonFunctions.HTMLControls.DrawComboBox("cboPriority", strSQL)
            .Write("</td>")

            ' target location
            .Write("<td id=TDTargetLocation  align=left style='Display:None'>" & MyBase.GetResourceString("CAPTION_VALUE") & vbCrLf)
            strSQL = "usp_CRM_Filters_TargetLocations_ForCombo  " & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(m_strLoginType & "") & "'"
            CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", strSQL)
            .Write("</td>" & vbCrLf)

            ' feedback
            .Write("<td id=TDFeedback  align=left style='Display:None'>" & MyBase.GetResourceString("CAPTION_VALUE") & vbCrLf)
            strSQL = "usp_CRM_Filters_Feedback_ForCombo"
            CommonFunctions.HTMLControls.DrawComboBox("cboFeedback", strSQL)
            .Write("</td>" & vbCrLf)

            ' rating
            .Write("<td id=TDFeedbackRating  align=left style='Display:None'>" & MyBase.GetResourceString("CAPTION_VALUE") & vbCrLf)
            strSQL = "usp_CRM_Filters_FeedbackRating_ForCombo"
            CommonFunctions.HTMLControls.DrawComboBox("cboFeedbackRating", strSQL)
            .Write("</td>" & vbCrLf)


            'Added By SantoshK on 2nd Dec 2004
            'Added Request Type Filter
            'Request type combo
            .Write("<td id=TDRequestType  align=left NoWrap style='Display:None'>" & MyBase.GetResourceString("CAPTION_VALUE") & vbCrLf)
            strSQL = "usp_CRM_Filters_RequestType_ForCombo  " & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(m_strLoginType & "") & "'"
            CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL)
            .Write("</td>")
            'Addition Ends


            ' Login Type 
            .Write("<td id=TDLoginType  align=left NoWrap style='Display:None'>" & MyBase.GetResourceString("CAPTION_VALUE") & vbCrLf)
            strSQL = "usp_CRM_Filters_LoginType_ForCombo"
            CommonFunctions.HTMLControls.DrawComboBox("cboLoginType", strSQL)
            .Write("</td>")
            '------------------------------------------------------------------------------
            'Added By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
            ' Product 
            .Write("<td id=TDProduct  align=left NoWrap style='Display:None'>" & MyBase.GetResourceString("CAPTION_VALUE") & vbCrLf)
            'Added by PrashantD on 9 April 2007
            'strSQL = "usp_sel_tbl_PRD_ProductVersion_forCRM"
            strSQL = "usp_sel_tbl_PRD_ProductVersion_forCRM NULL,'" + Session("LoginType").ToString + "'," + Session("intUserId").ToString
            'End of addition by PrashantD on 9 April 2007
            CommonFunctions.HTMLControls.DrawComboBox("cboProduct", strSQL, 300)
            .Write("</td>")

            ' Component
            .Write("<td id=TDComponent  align=left NoWrap style='Display:None'>" & MyBase.GetResourceString("CAPTION_VALUE") & vbCrLf)
            'Added by PrashantD on 9 April 2007
            'strSQL = "usp_sel_tbl_PRD_Component_forCRM
            strSQL = "usp_sel_tbl_PRD_Component_forCRM NULL,NULL,'" + Session("LoginType").ToString + "'," + Session("intUserId").ToString
            'End of addition by PrashantD on 9 April 2007
            CommonFunctions.HTMLControls.DrawComboBox("cboComponent", strSQL, 300)
            .Write("</td>")

            ' Severity 
            .Write("<td id=TDSeverity  align=left NoWrap style='Display:None'>" & MyBase.GetResourceString("CAPTION_VALUE") & vbCrLf)
            strSQL = "usp_sel_tbl_CRM_Severity_forCRM "
            CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", strSQL)
            .Write("</td>")

            .Write("<td id=TDDepartment  align=left NoWrap style='Display:None'>" & MyBase.GetResourceString("CAPTION_VALUE") & vbCrLf)
            strSQL = "usp_sel_Tbl_PM_DepartmentMaster_ForCRM Null , " + m_lngEmployeeID.ToString() + " , '" + m_strLoginType + "'"
            CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", strSQL)
            .Write("</td>")

            'End Addition By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293

            ' SrikanthY on 26 Mar 2007 to Display Client Name on filter page 
            .Write("<td id=TDClient  align=left NoWrap style='Display:None'>" & MyBase.GetResourceString("CAPTION_VALUE") & vbCrLf)
            strSQL = "usp_sel_tbl_PM_Customer_forCRM " & "'" & CommonFunctions.General.BuildQueryString(m_strLoginType & "") & "'," & m_lngEmployeeID

            CommonFunctions.HTMLControls.DrawComboBox("cboClient", strSQL, 300)
            .Write("</td>")
            'End of addition by SrikanthY on 26 Mar 2007

            'Added By Amol Changle On: 24 Jul 2009
            'Purpose: To plot TDs for Custom combo fields
            Dim drCustomFields As IDataReader
            Dim strDatabaseFieldName As String
            Dim strUserGivenCaption As String

            drCustomFields = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_CustomFields_Master 0,NULL,1,NULL,'Help-Desk'", True)
            While drCustomFields.Read()
                strDatabaseFieldName = CommonFunctions.Data.CheckIsDBNull(drCustomFields("DatabaseFieldName")).ToString()
                strUserGivenCaption = CommonFunctions.Data.CheckIsDBNull(drCustomFields("UserGivenCaption")).ToString()

                If strDatabaseFieldName.ToLower().Contains("customfieldcombo") Then
                    .Write("<td id=TD" + strDatabaseFieldName + "  align=left NoWrap style='Display:None'>" & strUserGivenCaption & vbCrLf)
                    CommonFunctions.HTMLControls.DrawComboBox(strDatabaseFieldName, "usp_Sel_tbl_PM_CustomFields_Details '" + strDatabaseFieldName + "',0,1,'Help-Desk'")
                    .Write("</td>")
                End If
            End While
            CommonFunctions.Data.DisposeDataReader(drCustomFields)
            'End Addition

            .Write("<td  align=left NoWrap>" & vbCrLf)
            .Write("<A href='JavaScript:Append_OnClick()' style='TEXT-DECORATION:None'><font face=verdana;arial color='black' size=1 style='BACKGROUND-COLOR: aliceblue'><B>| " & MyBase.GetResourceString("LINK_APPEND") & " |</B></font></A>" & vbCrLf)
            .Write("</td>" & vbCrLf)

            .Write("</tr>" & vbCrLf)
            .Write("</Table>" & vbCrLf)

            .Write("<BR>" & vbCrLf)


            ' insert '(',')','AND','OR'
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            .Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            .Write("<tr class=clsTREven>" & vbCrLf)
            .Write("<td  align=left>" & vbCrLf)
            .Write(MyBase.GetResourceString("LINK_INSERT") & " |&nbsp;" & vbCrLf)
            .Write("<a href=" & Chr(34) & "javascript:Insert_OnClick('(')" & Chr(34) & " style='TEXT-DECORATION: none'>" & vbCrLf)
            .Write("<font size=1 face=verdana color=black style='BACKGROUND-COLOR: aliceblue'>" & vbCrLf)
            .Write("<b>&nbsp;&nbsp;(&nbsp;&nbsp;</b>" & vbCrLf)
            .Write("</font>" & vbCrLf)

            .Write("|&nbsp;" & vbCrLf)
            .Write("<a href=" & Chr(34) & "javascript:Insert_OnClick(')')" & Chr(34) & " style='TEXT-DECORATION: none'>" & vbCrLf)
            .Write("<font size=1 face=verdana color=black style='BACKGROUND-COLOR: aliceblue'>" & vbCrLf)
            .Write("<b>&nbsp;&nbsp;)&nbsp;&nbsp;</b>" & vbCrLf)
            .Write("</font>" & vbCrLf)

            .Write("|&nbsp;" & vbCrLf)
            .Write("<a href=" & Chr(34) & "javascript:Insert_OnClick('AND')" & Chr(34) & " style='TEXT-DECORATION: none'>" & vbCrLf)
            .Write("<font size=1 face=verdana color=black style='BACKGROUND-COLOR: aliceblue'>" & vbCrLf)
            .Write("<b>&nbsp;&nbsp;AND&nbsp;&nbsp;</b>" & vbCrLf)
            .Write("</font>" & vbCrLf)

            .Write("|&nbsp;" & vbCrLf)
            .Write("<a href=" & Chr(34) & "javascript:Insert_OnClick('OR')" & Chr(34) & " style='TEXT-DECORATION: none'>" & vbCrLf)
            .Write("<font size=1 face=verdana color=black style='BACKGROUND-COLOR: aliceblue'>" & vbCrLf)
            .Write("<b>&nbsp;&nbsp;OR&nbsp;&nbsp;</b>" & vbCrLf)
            .Write("</font>")

            .Write("&nbsp;|" & vbCrLf)

            .Write("</td>" & vbCrLf)
            .Write("</tr>" & vbCrLf)

            ' textarea for filter text
            .Write("<tr class=clsTREven>" & vbCrLf)
            .Write("<td  align=left>" & vbCrLf)
            'Modified By ShraddhaM on 27 July 2006
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'CommonFunctions.HTMLControls.DrawTextArea("txtFilter", "txtFilter", "Filter", , , , , , 600, 160, , strFilter, , , , , , , , , True, , , , , , "Soft", )
            CommonFunctions.HTMLControls.DrawTextArea("txtFilter", "txtFilter", "Filter", , , , , , 600, 160, , strFilter, , , , , , , , , True, , , , , , "Soft", , EnableHTMLEncode:=True)
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            .Write("</td>" & vbCrLf)
            .Write("</tr>" & vbCrLf)

            .Write("</Table>" & vbCrLf)

            .Write("<BR>" & vbCrLf)

            ' clear all link
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            .Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            .Write("<tr class=clsTREven>" & vbCrLf)
            .Write("<td  align=right NoWrap width='100%'>" & vbCrLf)
            .Write("<A href='JavaScript:ClearAll_OnClick()' style='TEXT-DECORATION:None'><font face=verdana;arial color='black' size=1 style='BACKGROUND-COLOR: aliceblue'><B>| " & MyBase.GetResourceString("LINK_CLEAR_ALL") & " |</B></font></A>" & vbCrLf)
            .Write("</td>" & vbCrLf)
            .Write("</tr>" & vbCrLf)
            .Write("</Table>" & vbCrLf)

            .Write("</DIV>")

            .Write(strMenu)
        End With


    End Sub


    Private Function VerifyFilter(ByVal Filter As String) As Boolean
        '=====================================================================
        ' Procedure Name        : VerifyFilter()	
        ' Purpose               : To verfiy the filter 
        ' Description           : same as above
        ' Parameters Passed     : Filter string
        ' Returns               : true/false
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 26,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        strSQL = "select QueryID from v_tbl_CRM_Query_Master where (1=1) and " & Filter
        Return CommonFunctions.Data.ValidateQuery(strSQL, m_blnUseSQL)

    End Function

    'Private Function PlotCustomFieldCombo(ByVal strCustomFieldName As String) As String
    '    '=====================================================================
    '    ' Procedure Name        : PlotCustomFieldCombo
    '    ' Purpose               : To plot custom field combobox
    '    ' Description           : same as above
    '    ' Parameters Passed     : CustomFieldName
    '    ' Returns               : HTML string
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amol Changle
    '    ' Created               : 24 Jul 2009
    '    ' Revisions             :
    '    '=====================================================================
    'End Function


End Class
