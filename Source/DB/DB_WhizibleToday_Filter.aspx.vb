'Imports System.Globalization

Public Class DB_WhizibleToday_Filter
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
    End Sub

#End Region


    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    'Private m_objDTFI As New DateTimeFormatInfo       'Requires to parse the date.
    Private m_blnUseSQL As Boolean
    Dim m_strEntity As String = ""
    Dim m_strField As String = ""
    Dim m_strValue As String = ""
    Dim m_strOperation As String = ""
    'Added By JyotiG
    'Date : 16-Oct-2006
    'Purpose : Developer Dasboard Enhanced View
    'Start
    Protected strDashBoard As String = ""
    'End

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        m_blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
        'Added By JyotiG
        'Date : 16-Oct-2006
        'Purpose : Developer Dasboard Enhanced View
        'Start
        strDashBoard = CommonFunctions.General.CheckIsNothing(Request.QueryString("DashBoard"), "")
        'End
        If Request.QueryString("Action") = "ApplyFilter" Then
            SaveFilterDtls()
        ElseIf Request.QueryString("Action") = "ClearFilter" Then
            ClearFilterDtls()
        End If

    End Sub

    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : 
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MonikaI
        ' Created               : Aug 21 ,2006
        ' Revisions             :
        '=====================================================================

        Dim strMenu As String
        Dim drProjectCount As IDataReader
        Dim strSQL As String
        Dim strEntity As String = ""
        Dim strField As String = ""
        Dim strProjectValue As String = ""
        Dim strResourceValue As String = ""

        drProjectCount = CommonFunctions.Data.GetDataReader("usp_sel_WhizibleToday_Filter " + Session("intUserID").ToString + "," + Session("LoginType").ToString + "," + Request.QueryString("FromWhere") + "," + Request.QueryString("DashBoard"), m_blnUseSQL)
        If drProjectCount.FieldCount > 0 Then
            Dim arrMenu() As String = {"Apply Filter", "Clear Filter", "Close", "?"}
            Dim arrMenuToolTip() As String = {"Apply Filter", "Clear Filter", "Close", "Help"}
            Dim arrCSFunction() As String = {"Apply_OnClick()", "Clear_OnClick()", "Close_OnClick()", "Help_OnClick()"}
            strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
           
            While drProjectCount.Read
                strField = CType(drProjectCount("Field"), String)
                If strField = "cboProject" Then
                    strProjectValue = CType(drProjectCount("Value"), String)
                End If
                If strField = "cboResource" Then
                    strResourceValue = CType(drProjectCount("Value"), String)
                End If
            End While
            ''Done By JyotiG
            ''Start
            'If Request.QueryString("PMVisitNo") = "1" Then
            '    If strProjectValue = "" And strResourceValue = "" Then
            '        strResourceValue = Session("intUserID").ToString
            '    End If
            'End If
            'If Request.QueryString("IBVisitNo") = "1" Then
            '    If strProjectValue = "" And strResourceValue = "" Then
            '        strResourceValue = Session("intUserID").ToString
            '    End If
            'End If
            'If Request.QueryString("DELVisitNo") = "1" Then
            '    If strProjectValue = "" And strResourceValue = "" Then
            '        strResourceValue = Session("intUserID").ToString
            '    End If
            'End If
            'If Request.QueryString("RVVisitNo") = "1" Then
            '    If strProjectValue = "" And strResourceValue = "" Then
            '        strResourceValue = Session("intUserID").ToString
            '    End If
            'End If
            ''End
        Else
            Dim arrMenu() As String = {"Apply Filter", "Close", "?"}
            Dim arrMenuToolTip() As String = {"Apply Filter", "Close", "Help"}
            Dim arrCSFunction() As String = {"Apply_OnClick()", "Close_OnClick()", "Help_OnClick()"}
            strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)

        End If
        CommonFunctions.Data.DisposeDataReader(drProjectCount)
        'm_intUniqueID = 0

        With Response
            .Write(strMenu)
            .Write("<BR>")
            .Write(WebPage.Templates.PageCaption.GetPageCaptions(, "Select the Filter Criteria"))
            .Write("<BR>")
            .Write("<div id=divList style='overflow:auto'>")
            .Write("<Table class=clsTable width ='100%' cellpadding=0 cellspacing=0>" & vbCrLf)
            .Write("<TR class=clsTREven>")
            .Write("<TD align=right>Project</TD>")
            .Write("<TD>")
            strSQL = "usp_Sel_AccessibleProjects_ForEmployee " + Session("intUserID").ToString
            CommonFunctions.HTMLControls.DrawComboBox("cboProject", strSQL, 200, strProjectValue, "onchange=javascript:onSelection('FrmWhizibleTodayFilter','cboProject','cboResource')", True, , , , , , 1)
            .Write("</TD>")
            .Write("</TR>")
            'Added By JyotiG
            'Date : 16-Oct-2006
            'Purpose : Developer Dasboard Enhanced View
            'Start
            If strDashBoard = "PMDB" Then
                'Done By JyotiG(29-Aug-2006)
                'Start
                If Request.QueryString("FromWhere") = "PM" Then
                    .Write("<TR class=clsTREven>")
                    .Write("<TD align=right>Resource Name</TD>")
                    .Write("<TD>")
                End If
                'Done By JyotiG(31-Aug-2006)
                'Start
                If Request.QueryString("FromWhere") = "DEL" Then
                    .Write("<TR class=clsTREven>")
                    .Write("<TD align=right>Responsible Person/Requested By</TD>")
                    .Write("<TD>")
                End If
                'End
                If Request.QueryString("FromWhere") = "IB" Then
                    .Write("<TR class=clsTREven>")
                    .Write("<TD align=right>Responsible Person</TD>")
                    .Write("<TD>")
                End If
                If Request.QueryString("FromWhere") = "RV" Then
                    .Write("<TR class=clsTREven>")
                    'Commented and Modified By JyotiG
                    'Start_JG_7305_14-Nov-2006
                    '.Write("<TD align=right>Reviewee</TD>")
                    .Write("<TD align=right>Reviewee/Reviewer</TD>")
                    'End_JG_7305_14-Nov-2006
                    .Write("<TD>")
                End If
                'End
            End If

            '.Write("<TR class=clsTREven>")
            '.Write("<TD align=right>Resource Name</TD>")
            '.Write("<TD>")

            'Added By JyotiG
            'Date : 16-Oct-2006
            'Purpose : Developer Dasboard Enhanced View
            'Start
            If strDashBoard = "PMDB" Then
                'End of Modification By JyotiG
                If strProjectValue = "" Then
                    CommonFunctions.HTMLControls.DrawComboBox("cboResource", "usp_sel_WhizToday_Resource " + Session("intUserID").ToString, 200, strResourceValue, , True, , , , , , 2)
                Else
                    CommonFunctions.HTMLControls.DrawComboBox("cboResource", "usp_sel_WhizToday_Resource " + Session("intUserID").ToString + "," + strProjectValue, 200, strResourceValue, , True, , , , , , 2)
                End If

            End If

            .Write("</TD>")
            .Write("</TR>")

            'Select Case Request.QueryString("FromWhere")
            '    Case "PM"
            '        .Write("<TR class=clsTREven>")
            '        .Write("<TD align=right>Project</TD>")
            '        .Write("<TD>")
            '        'strSQL = "usp_sel_WhizToday_Project 'PM'," + Session("intUserID").ToString
            '        strSQL = "usp_Sel_AccessibleProjects_ForEmployee " + Session("intUserID").ToString
            '        CommonFunctions.HTMLControls.DrawComboBox("cboProject", strSQL, 200, , "onchange=javascript:onSelection('FrmWhizibleTodayFilter','cboProject','cboResource')", True, , , , , , 0)
            '        .Write("</TD>")
            '        .Write("</TR>")

            '        .Write("<TR class=clsTREven>")
            '        .Write("<TD align=right>Resource Name</TD>")
            '        .Write("<TD>")
            '        CommonFunctions.HTMLControls.DrawComboBox("cboResource", "usp_sel_WhizToday_Resource " + Session("intUserID").ToString, 200, , , True, , , , , , 0)
            '        .Write("</TD>")
            '        .Write("</TR>")
            '    Case "IB"
            '        .Write("<TR class=clsTREven>")
            '        .Write("<TD align=right>Project</TD>")
            '        .Write("<TD>")
            '        strSQL = "usp_Sel_AccessibleProjects_ForEmployee " + Session("intUserID").ToString
            '        CommonFunctions.HTMLControls.DrawComboBox("cboProject", strSQL, 200, , "onchange=javascript:onSelection('FrmWhizibleTodayFilter','cboProject','cboResource')", True, , , , , , 0)
            '        .Write("</TD>")
            '        .Write("</TR>")

            '        .Write("<TR class=clsTREven>")
            '        .Write("<TD align=right>Resource Name</TD>")
            '        .Write("<TD>")
            '        CommonFunctions.HTMLControls.DrawComboBox("cboResource", "usp_sel_WhizToday_Resource " + Session("intUserID").ToString, 200, , , True, , , , , , 0)
            '        .Write("</TD>")
            '        .Write("</TR>")

            '    Case "DEL"
            '        .Write("<TR class=clsTREven>")
            '        .Write("<TD align=right>Project</TD>")
            '        .Write("<TD>")
            '        strSQL = "usp_Sel_AccessibleProjects_ForEmployee " + Session("intUserID").ToString
            '        CommonFunctions.HTMLControls.DrawComboBox("cboProject", strSQL, 200, , "onchange=javascript:onSelection('FrmWhizibleTodayFilter','cboProject','cboResource')", True, , , , , , 0)
            '        .Write("</TD>")
            '        .Write("</TR>")

            '        .Write("<TR class=clsTREven>")
            '        .Write("<TD align=right>Resource Name</TD>")
            '        .Write("<TD>")
            '        CommonFunctions.HTMLControls.DrawComboBox("cboResource", "usp_sel_WhizToday_Resource " + Session("intUserID").ToString, 200, , , True, , , , , , 0)
            '        .Write("</TD>")
            '        .Write("</TR>")

            '    Case "RV"
            '        .Write("<TR class=clsTREven>")
            '        .Write("<TD align=right>Project</TD>")
            '        .Write("<TD>")
            '        strSQL = "usp_Sel_AccessibleProjects_ForEmployee " + Session("intUserID").ToString
            '        CommonFunctions.HTMLControls.DrawComboBox("cboProject", strSQL, 200, , "onchange=javascript:onSelection('FrmWhizibleTodayFilter','cboProject','cboResource')", True, , , , , , 0)
            '        .Write("</TD>")
            '        .Write("</TR>")

            '        .Write("<TR class=clsTREven>")
            '        .Write("<TD align=right>Resource Name</TD>")
            '        .Write("<TD>")
            '        CommonFunctions.HTMLControls.DrawComboBox("cboResource", "usp_sel_WhizToday_Resource " + Session("intUserID").ToString, 200, , , True, , , , , , 0)
            '        .Write("</TD>")
            '        .Write("</TR>")

            'End Select
            .Write("</TABLE>")
            .Write("</div>")

            .Write("<BR>")
            .Write(strMenu)
            ' menu
        End With
    End Sub

    Protected Sub SaveFilterDtls()

        Dim strSQL As String

        m_strEntity = Request.QueryString("FromWhere")
        m_strOperation = "Insert"

        m_strField = "cboProject"
        If Request.Form("cboProject") <> "" Then
            m_strValue = Request.Form("cboProject")
        Else
            m_strValue = ""
        End If
        strSQL = "exec usp_ins_del_WhizibleToday_Filters '" & CType(Session("intUserID"), String) & "','" + Session("LoginType").ToString + "','" & m_strEntity & "','" & m_strField & "','" & m_strValue & "','" & m_strOperation & "','" & strDashBoard & "'"
        CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

        m_strField = "cboResource"
        If Request.Form("cboResource") <> "" Then
            m_strValue = Request.Form("cboResource")
        Else
            m_strValue = ""
        End If
        strSQL = "exec usp_ins_del_WhizibleToday_Filters '" & CType(Session("intUserID"), String) & "','" + Session("LoginType").ToString + "','" & m_strEntity & "','" & m_strField & "','" & m_strValue & "','" & m_strOperation & "','" & strDashBoard & "'"
        CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

        'CommonFunctions.General.WriteHTML("<SCRIPT language=Javascript>alert('Tracking Details Saved Successfully');</SCRIPT>")
    End Sub

    Protected Sub ClearFilterDtls()

        Dim strSQL As String

        m_strEntity = Request.QueryString("FromWhere")
        m_strOperation = "Delete"

        strSQL = "exec usp_ins_del_WhizibleToday_Filters '" & CType(Session("intUserID"), String) & "','" + Session("LoginType").ToString + "','" & m_strEntity & "',NULL,NULL,'" & m_strOperation & "','" & strDashBoard & "'"
        CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
        'CommonFunctions.General.WriteHTML("<SCRIPT language=Javascript>alert('Tracking Details Cleared Successfully');</SCRIPT>")

    End Sub
End Class
