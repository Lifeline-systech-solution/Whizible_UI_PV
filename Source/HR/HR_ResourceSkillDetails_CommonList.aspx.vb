Imports CommonEngines.General.cEventHandlers
Public Class HR_ResourceSkillDetails_CommonList
    Inherits CommonList
    '=====================================================================
    ' Class Name	    	:	HR_ResourceSkillDetails_CommonList
    ' Purpose				:	To draw all controls on the page
    ' Description			:	
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	ArchanaN
    ' Created				:	18 Oct 2007
    ' Revisions				:	
    '=====================================================================

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        ''Added By Vidya Jadhav ON 20/04/2017 For Unauthenticated user can view this page. 
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Of Added By Vidya Jadhav ON 20/04/2017 For Unauthenticated user can view this page. 

        MyBase.strListPage = "HR_ResourceSkillDetails_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
#End Region

    Private objDF As cHR_ResourceSkillDetails_DynamicFilters


    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cHR_ResourceSkillDetails_CommonListSQL(MyBase.m_objGlobal, objDF)
    End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strScript As New System.Text.StringBuilder
        strScript.Append("<Script language=javascript>" + vbCrLf)
        strScript.Append("function Category_OnChange() {" + vbCrLf)

        strScript.Append("objfrm.action=""../HR/HR_ResourceSkillDetails_CommonList.aspx?PagingNumber&SetFilter=1""; " + vbCrLf)
        strScript.Append("objfrm.submit();" + vbCrLf)
        strScript.Append("return; }" + vbCrLf)
    
        strScript.Append("function txtSkillName_OnKeyPress(e) {" + vbCrLf)
        strScript.Append("var code; " + vbCrLf)
        strScript.Append("if (e.keyCode)" + vbCrLf)
        strScript.Append("code = e.keyCode;" + vbCrLf)
        strScript.Append("else" + vbCrLf)
        strScript.Append("if (e.which)" + vbCrLf)
        strScript.Append("code = e.which; " + vbCrLf)
        strScript.Append("if(code==13) {" + vbCrLf)
        strScript.Append("objfrm.action=""../HR/HR_ResourceSkillDetails_CommonList.aspx?PagingNumber=1""; " + vbCrLf)
        strScript.Append("objfrm.submit();" + vbCrLf)
        strScript.Append("return; }}" + vbCrLf)

        strScript.Append("</Script>" + vbCrLf)
        HttpContext.Current.Response.Write(strScript.ToString)
    End Function

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

    End Sub

    Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        objDF = New cHR_ResourceSkillDetails_DynamicFilters(MyBase.m_objGlobal)
        Return objDF
    End Function
End Class

Public Class cHR_ResourceSkillDetails_CommonListSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Private objDF As cHR_ResourceSkillDetails_DynamicFilters
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal objDynamicFilter As cHR_ResourceSkillDetails_DynamicFilters)
        Call MyBase.New(WhizGlobal)
        objDF = objDynamicFilter
    End Sub


    Public objDFSQL As cHR_ResourceSkillDetails_DynamicFilters
    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        Dim strSQL As String
        Dim strCategoryID As String
        Dim strSkills As String
        Dim drFilter As IDataReader
        Dim intUserID As String = CStr(HttpContext.Current.Session("intUserID"))
        Dim strLoginType As String = CStr(HttpContext.Current.Session("LoginType"))

        Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

        strCategoryID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboCategory"), "")
        strSkills = CommonFunction.General.BuildQueryString(CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSkills"), ""), String))


        If strCategoryID = "" Then
            strCategoryID = objDF.m_strCategoryFilter
        End If

        If strSkills = "" Then
            strSkills = CommonFunction.General.BuildQueryString(objDF.m_strSkillFilter)
        End If

        If Not strCategoryID Is Nothing And strCategoryID <> "" Then
            GetPageSpecificFilters += "AND EmployeeID in ( SELECT EmployeeID FROM tbl_PM_EmployeeSkillMatrix EM INNER JOIN tbl_PM_Tools T ON EM.ToolID = T.ToolID WHERE Tools_CategoryID = " + strCategoryID + " ) "
        End If

        If Not strSkills Is Nothing And strSkills <> "" Then
            GetPageSpecificFilters += "AND (Skills Like '%" + strSkills + "%')"
        End If

        If strSkills <> "" Or strSkills Is Nothing Then
            strSkills = CommonFunction.General.UnBuildQueryString(CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSkills"), ""), String))
        End If

    End Function


End Class

Public Class cHR_ResourceSkillDetails_DynamicFilters
    Inherits CommonEngine.CommonList.cDynamicFilters

    Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(objGlobal)
    End Sub

    Public m_strCategoryFilter As String = ""
    Public m_strSkillFilter As String = ""
    Protected Overrides Sub After_Filter_Print(ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strHtml As String
        Dim strCategoryID As String = ""
        Dim strSkills As String = ""

        Dim strSQL As String
        Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
        Dim drFilter As IDataReader
        Dim intUserID As String = CStr(HttpContext.Current.Session("intUserID"))
        Dim strLoginType As String = CStr(HttpContext.Current.Session("LoginType"))

        strCategoryID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboCategory"), "")
        strSkills = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSkills"), ""), String)

        ''Purpose : To persists the value of the filters
        If HttpContext.Current.Request.Form("cboCategory") Is Nothing Then
            ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
            ''drFilter = CommonFunctions.Data.GetDataReader("SELECT ControlName, FixedValue FROM tbl_UI_EmployeeFilterSettings_FieldDetails WHERE TagID=3861 AND UserID=" + intUserID, blnUseSQL)
            drFilter = CommonFunctions.Data.GetDataReader("usp_sel_tbl_UI_EmployeeFilterSettings_FieldDetails_3861 " + intUserID, blnUseSQL)
            ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
            While drFilter.Read
                Select Case drFilter(0).ToString
                    Case "CategoryID"
                        m_strCategoryFilter = drFilter(1).ToString
                        strCategoryID = drFilter(1).ToString
                    Case "SkillID"
                        m_strSkillFilter = drFilter(1).ToString
                        strSkills = drFilter(1).ToString
                End Select
            End While
            CommonFunction.Data.DisposeDataReader(drFilter)
        Else
            strSQL = "usp_InsUpd_ResourceSkillView_FilterSettings "

            If strCategoryID = "" Then
                strSQL += " NULL,"
            Else
                strSQL += strCategoryID + " ,"
            End If

            If strSkills = "" Then
                strSQL += " NULL,"
            Else
                strSQL += "'" + CommonFunction.General.BuildQueryString(strSkills) + "' ,"
            End If

            strSQL += intUserID + ","
            strSQL += "'" + strLoginType + "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, blnUseSQL)
        End If
        strHtml += "<td align=right>Category Name &nbsp;</td><td align=left>"
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        '' strHtml += CommonFunction.HTMLControls.DrawComboBox("cboCategory", "select Tools_CategoryID,CategoryName from tbl_PM_Tools_Category ", 150, strCategoryID, "onChange='Category_OnChange()'", True, True)
        strHtml += CommonFunction.HTMLControls.DrawComboBox("cboCategory", "usp_sel_tbl_PM_Tools_Category_CategoryName ", 150, strCategoryID, "onChange='Category_OnChange()'", True, True)
        ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        strHtml += "</td>"

        strHtml += "<td align=right title='Contains'>Other Skills &nbsp;</td><td align=left>"
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        strHtml += CommonFunction.HTMLControls.DrawTextBox("txtSkills", "txtSkills", "clsTextBox", 150, 20, strSkills, "left", , False, False, , False, "Title='Contains' onkeypress=txtSkillName_OnKeyPress(event)", True, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15

        strHtml += "</td>"
        Args.ToBeInserted = strHtml

        If strSkills <> "" Or strSkills Is Nothing Then
            strSkills = CommonFunction.General.UnBuildQueryString(CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSkills"), ""), String))
        End If

    End Sub
End Class
