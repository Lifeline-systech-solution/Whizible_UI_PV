Imports CommonEngines.General.cEventHandlers
Public Class Project_UploadData_CommonList
    Inherits CommonList



#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "Project_UploadData_CommonList.aspx"
        MyBase.strFormPage = "Project_UploadData_CommonPage.aspx"
        'Put user code to initialize the page here
        'Added by Syamantak Chavan on 09 August 2011 for WhizibleSEM v10.0 To add Excel Upload For Agile Methodology
        Dim Flag As String
        If Not HttpContext.Current.Request.QueryString("Flag") Is Nothing Then
            Flag = HttpContext.Current.Request.QueryString("Flag").ToString
        Else
            Flag = ""
        End If
        'End Added by Syamantak Chavan on 09 August 2011 for WhizibleSEM v10.0 To add Excel Upload For Agile Methodology
        MyBase.Page_Load(sender, e)


    End Sub
    Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        Return New cProject_UploadData_CommonListDynamicFilters(MyBase.m_objGlobal)
    End Function
#End Region


    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        CommonFunctions.General.WriteHTML("<DIV class=""FadingTooltip"" id=""FADINGTOOLTIP"" style=""Z-INDEX: 101; LEFT: 50px; VISIBILITY: hidden; POSITION: absolute; TOP: 200px""></DIV>")
        CommonFunctions.General.WriteHTML("<script>WindowLoading(true, true);</script></HEAD>")
        If CType(HttpContext.Current.Request("UploadData"), String) = "1" Then
            'PageListPreRender = "window.open('CommonList.aspx?MasterTagID=3017&Fromwhere=" & CType(WhizGlobal.FromWhere, String) & "','_self')"
            ' Modified By MahendraV On 4:18 PM 6/29/2007 For WhizibleSEM 7
            ' Database update need to be moved in WhizForm_Init due to DataSet Related Changes
            ' Commented code moved from PageListPreRender To WhizForm_Init
            ' Start_MV_6/29/2007
            'If CType(HttpContext.Current.Request("RequestID"), String) <> "" Then
            '    Dim strRequest() As String = Split(CType(HttpContext.Current.Request("RequestID"), String), ",")
            '    CommonFunctions.Data.InsertOrUpdateData("EXEC USP_DXU_TRANSFERREQUESTDATA " & strRequest(0), True)
            'End If
            ' End_MV_6/29/2007
            CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
            CommonFunctions.General.WriteHTML(" window.location.href =window.location.href.substring(0,window.location.href.search('&UploadData'));document.refresh;" + vbCrLf)
            CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
        End If
        'If CType(HttpContext.Current.Request("MasterTagID"), String) = "5279" Then
        '    'PageListPreRender = " window.open('CommonList.aspx?FromWhere=SM&MasterTagID=3017',_self)"
        '    ' CommonFunctions.General.WriteHTML(" document.refresh;" + vbCrLf)
        '    CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
        '    CommonFunctions.General.WriteHTML(" window.open('CommonList.aspx?FromWhere=SM&MasterTagID=3017','_self')" + vbCrLf)
        '    CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
        'End If
    End Function

    Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strIDList() As String
        Dim strID As String
        Dim strSQL As String
        If DeletedIDList <> "" Then
            strIDList = DeletedIDList.Split(","c)
            For Each strID In strIDList
                If strID <> "" Then
                    strSQL = "if (Exists(select * from sysobjects where name like 'tbl_DXU_tmp" & strID & "')) drop table tbl_DXU_tmp" & strID & vbCrLf
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    strSQL = " if (Exists(select * from sysobjects where name like 'tbl_TMP_SpecialRequest_" & strID & "')) drop table tbl_TMP_SpecialRequest_" & strID
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                End If
            Next

        End If
    End Function

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cProject_UploadDataPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cProject_UploadDataCLSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
        ' Modified By MahendraV On 4:18 PM 6/29/2007
        ' Adde code moved from PageListPreRender To WhizForm_Init
        ' Start_MV_6/29/2007
        If CType(HttpContext.Current.Request("UploadData"), String) = "1" Then
            If CType(HttpContext.Current.Request("RequestID"), String) <> "" Then
                Dim strRequest() As String = Split(CType(HttpContext.Current.Request("RequestID"), String), ",")
                CommonFunctions.Data.InsertOrUpdateData("EXEC USP_DXU_TRANSFERREQUESTDATA " & strRequest(0), True)
            End If
        End If
        ' End_MV_6/29/2007
    End Sub
End Class
Public Class cProject_UploadDataPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Public Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        MyBase.New(objGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strSQLQuery As String
        Dim drGetLevel As IDataReader
        Dim intLevel As Integer = 0
        Dim strUserName As String

        'If CType(WhizGlobal.FromWhere, String) = "SM" Then
        '    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectID"), "0"), String) <> "0" Then
        '        Cancel = True

        '    End If
        'Else
        If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectID"), "0"), String) = "0" Then
            Cancel = True
        End If

        'End If
        'Commented by ArchanaN on 26 Feb 2008 To Display all the  request to ADMIN .
        '''If CType(HttpContext.Current.Session("intPostID"), String) <> "" Then
        '''    strSQLQuery = " SELECT isnull(Level,0) as Level from tbl_PM_Role WHERE RoleID = " & CType(HttpContext.Current.Session("intPostID"), String)
        '''    drGetLevel = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
        '''    If (drGetLevel.Read) Then
        '''        intLevel = CType(CommonFunctions.Data.CheckIsDBNull(drGetLevel("Level"), "0"), Integer)
        '''    End If
        '''End If

        '''If intLevel <> 1 Then
        'Modified by ArchanaN on 26 Feb 2008 
        If CType(HttpContext.Current.Session("intPostID"), String) <> "7" Then
            'strSQLQuery = " SELECT UserName  from tbl_PM_Employee WHERE EmployeeID = " & CType(Args.DataReader("EmployeeID"), String)
            If WhizGlobal.LoginType = "E" Then

                ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strSQLQuery = " SELECT UserName  from tbl_PM_Employee WHERE EmployeeID = " & CType(Args.DataReader("EmployeeID"), String)
                strSQLQuery = " usp_sel_tbl_PM_Employee_UserNameForEmployeeID " & CType(Args.DataReader("EmployeeID"), String)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                drGetLevel = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
                If (drGetLevel.Read) Then
                    strUserName = CType(CommonFunctions.Data.CheckIsDBNull(drGetLevel("UserName"), "0"), String)
                End If
                If strUserName <> CType(HttpContext.Current.Session("strUserName"), String) Then
                    Cancel = True
                End If
                CommonFunction.Data.DisposeDataReader(drGetLevel)
            Else
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If

    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.DataField.ToUpper = "STATUS" And CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Status"), ""), String)).ToUpper = "INVALID TEMPLATE USED" Then
            Cancel = True
            'Args.StringToBeInserted = "<TD align=center Title=""Invalid Template""><A href=javascript:ViewLogFile(""" & CStr(Args.DataReader("RequestID")) & ".log" & """) >" & "Invalid Template" & "</A></TD>"
            Dim strErrmsg As String
            If Not Args.DataReader("Errmsg") Is DBNull.Value Then
                strErrmsg = CStr(Args.DataReader("Errmsg"))
            Else
                strErrmsg = "Invalid template Used"
            End If
            Args.StringToBeInserted = "<TD align=center>"
            Args.StringToBeInserted += "<SPAN onmouseover=""DisplayTooltipCL('<iframe height=325px width=425px scrolling=no src=../DXU/DXU_Popup.aspx?RequestID=" & CStr(Args.DataReader("RequestID")) & "></iframe>')"" onmouseout=""DisplayTooltipCL('')""><U>Invalid Template</U></SPAN></TD>"
            'Args.StringToBeInserted = "<TD align=center>Invalid Template</TD>"
        End If
    End Sub
End Class
Public Class cProject_UploadDataCLSQL
    Inherits CommonEngine.CommonList.cCLSQL

    Public Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        MyBase.New(objGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        'Added By Syamantak Chavan On 10 August 2011 for whizible 10.0 Excel Upload for Scrum
        Dim strProjectID As String = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), ""), String)
        Dim Flag As String
        If Not HttpContext.Current.Request.QueryString("Flag") Is Nothing Then
            Flag = HttpContext.Current.Request.QueryString("Flag").ToString
        Else
            Flag = ""
        End If
        'End Added By Syamantak Chavan On 10 August 2011 for whizible 10.0 Excel Upload for Scrum
        'If (objGlobal.FromWhere = "PM") Then
        'Modified by vidyak for whiziblesem9.0 Service Pack 1 -HotFix 9.0.025--Page Crashed, if Delegate Task for node ' Excel Upload for Low level resources' .
        Dim objAccessRights As WebPages.Security.cAccessRights
        objAccessRights = New WebPages.Security.cAccessRights(objGlobal)
        GetPageSpecificFilters &= " AND ProjectID is Not NULL "
        GetPageSpecificFilters &= "  AND ProjectID=" & HttpContext.Current.Session("intProjectID").ToString
        'Added By Syamantak Chavan On 10 August 2011 for whizible 10.0 Excel Upload for Scrum
        Dim m_intFlag As Integer
        m_intFlag = CInt(CInt(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + strProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))))
        If Flag = "UserStory" Then
            GetPageSpecificFilters &= "  AND ScrumEntityType=3"
            'Else
            '    Dim m_intFlag As Integer
            '    m_intFlag = CInt(CInt(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + strProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))))
            '    If m_intFlag = 1 Then
            '        GetPageSpecificFilters &= "  AND ScrumEntityType=5"
            '    Else
            '        GetPageSpecificFilters &= "  AND ScrumEntityType is null"
            '    End If
        ElseIf m_intFlag = 1 Then
            GetPageSpecificFilters &= "  AND ScrumEntityType<>3"
        End If
        'End Added By Syamantak Chavan On 10 August 2011 for whizible 10.0 Excel Upload for Scrum
        'Modified  by ArchanaN 26 Feb 2008 For Whiziblesem 7.1 Issue ID= 19154
        ''If objGlobal.LoginType = "C" Then
        ''    GetPageSpecificFilters &= " And Customer = " & CStr(objGlobal.UserID)
        ''Else
        ''If objGlobal.LoginType = "C" Then
        objAccessRights.GetAccess()
        If objAccessRights.View Or objAccessRights.Edit Or objAccessRights.Add Or objAccessRights.Delete Then
            If CType(HttpContext.Current.Session("intPostID"), String) <> "7" Then
                If objGlobal.LoginType = "E" Then
                    'End of Modified by ArchanaN 26 Feb 2008 For Whiziblesem 7.1 Issue ID= 19154
                    GetPageSpecificFilters &= " And EmployeeID = " & CStr(objGlobal.UserID)
                Else
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If
        Else
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'Else
        '    GetPageSpecificFilters &= " AND ProjectID is  NULL "
        'End If
        'End Modified by vidyak for whiziblesem9.0 Service Pack 1 -HotFix 9.0.025--Page Crashed, if Delegate Task for node ' Excel Upload ' .
    End Function
End Class
'Added By Syamantak Chavan On 10 August 2011 for whizible 10.0 Excel Upload for Scrum
Class cProject_UploadData_CommonListDynamicFilters
    Inherits CommonEngine.CommonList.cDynamicFilters

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strProjectID As String = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), ""), String)
        Dim Flag As String
        If Not HttpContext.Current.Request.QueryString("Flag") Is Nothing Then
            Flag = HttpContext.Current.Request.QueryString("Flag").ToString
        Else
            Flag = ""
        End If
        If Args.FilterName.ToUpper = "TEMPLATEID" Then
            Dim m_intFlag As Integer
            m_intFlag = CInt(CInt(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + strProjectID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))))
            If Flag = "UserStory" Then
                If m_intFlag = 1 Then
                    Args.SQL = "SELECT Distinct (T.TemplateID),T.TemplateName FROM tbl_DXU_TemplateMaster T INNER JOIN Tbl_DXU_TemplateDetails  D on D.TemplateID = T.TemplateID INNER JOIN tbl_DXU_EntityMaster E on E.EntityID = T.EntityID WHERE(D.ActualFieldID Is Not Null) and E.ProjectRequired = 1 AND T.TemplateName  Not like '%Test%Case%' AND ScrumEntityType=3 ORDER BY TemplateName"
                Else
                    Args.SQL = "SELECT Distinct (T.TemplateID),T.TemplateName FROM tbl_DXU_TemplateMaster T INNER JOIN Tbl_DXU_TemplateDetails  D on D.TemplateID = T.TemplateID INNER JOIN tbl_DXU_EntityMaster E on E.EntityID = T.EntityID WHERE(D.ActualFieldID Is Not Null) and E.ProjectRequired = 1 AND T.TemplateName  Not like '%Test%Case%' AND T.TemplateID NOT IN (select TemplateID from Tbl_DXU_Templatemaster where ScrumEntityType is not null) ORDER BY TemplateName"
                End If
            Else
                If m_intFlag = 1 Then
                    Args.SQL = "SELECT Distinct (T.TemplateID),T.TemplateName FROM tbl_DXU_TemplateMaster T INNER JOIN Tbl_DXU_TemplateDetails  D on D.TemplateID = T.TemplateID INNER JOIN tbl_DXU_EntityMaster E on E.EntityID = T.EntityID WHERE(D.ActualFieldID Is Not Null) and E.ProjectRequired = 1 AND T.TemplateName  IN ('Issue_Upload_With_Customfield','Product based Issue Upload Template','Scrum Tasks Creation Template') ORDER BY TemplateName"
                Else
                    Args.SQL = "SELECT Distinct (T.TemplateID),T.TemplateName FROM tbl_DXU_TemplateMaster T INNER JOIN Tbl_DXU_TemplateDetails  D on D.TemplateID = T.TemplateID INNER JOIN tbl_DXU_EntityMaster E on E.EntityID = T.EntityID WHERE(D.ActualFieldID Is Not Null) and E.ProjectRequired = 1 AND T.TemplateName  IN ('Issue_Upload_With_Customfield','Product based Issue Upload Template','Tasks Creation Template') AND T.TemplateID NOT IN (select TemplateID from Tbl_DXU_Templatemaster where ScrumEntityType is not null) ORDER BY TemplateName"
                End If
            End If
        End If

    End Sub
End Class
'End Added By Syamantak Chavan On 10 August 2011 for whizible 10.0 Excel Upload for Scrum