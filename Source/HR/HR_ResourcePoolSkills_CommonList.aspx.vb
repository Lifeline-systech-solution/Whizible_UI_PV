Imports CommonEngines.General.cEventHandlers
Public Class HR_ResourcePoolSkills_CommonList
    Inherits CommonList

    Private strshowSelected As String
    Private strResourcePoolID As String

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
        MyBase.strListPage = "HR_ResourcePoolSkills_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        'Put user code to initialize the page here

        strshowSelected = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("showSelected"), "")

        If strshowSelected Is Nothing Or strshowSelected = "" Then
            strshowSelected = CType(HttpContext.Current.Request.Form("showSelected"), String)
        End If

        strResourcePoolID = CType(HttpContext.Current.Request.QueryString("ResourcePoolID"), String)

        If strResourcePoolID Is Nothing Or strResourcePoolID = "" Then
            strResourcePoolID = CType(HttpContext.Current.Request.Form("hidResourcePoolID"), String)
        End If


        MyBase.Page_Load(sender, e)
    End Sub
#End Region


    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        CommonFunction.General.WriteHTML("<input type=hidden id='hidResourcePoolID' name='hidResourcePoolID' value=" + strResourcePoolID + " >")
        CommonFunction.General.WriteHTML("<input type=hidden id='showSelected' name='showSelected' value=" + strshowSelected + " >")
    End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.LinkName.ToUpper = "SHOW SELECTED SKILLS" Then
            If strshowSelected = "1" Then
                Cancel = True
            End If
        End If
        If Args.LinkName.ToUpper = "SHOW ALL SKILLS" Then
            If strshowSelected = "0" Then
                Cancel = True
            End If
        End If

    End Sub
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cHR_ResourcePoolSkills_CommonListSQL(MyBase.m_objGlobal)
    End Function



End Class

Public Class cHR_ResourcePoolSkills_CommonListSQL
    Inherits CommonEngine.CommonList.cCLSQL

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        Dim showSelected As String
        Dim strResourcePoolID As String

        showSelected = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("showSelected"), "")

        If showSelected = "" Then
            showSelected = CType(HttpContext.Current.Request.Form("showSelected"), String)
        End If

        strResourcePoolID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ResourcePoolID"), ""), String)
        If strResourcePoolID Is Nothing OrElse strResourcePoolID = "" Then
            strResourcePoolID = CType(HttpContext.Current.Request.Form("hidResourcePoolID"), String)
        End If

        If Not showSelected Is Nothing Or showSelected <> "" Then
            If showSelected.ToUpper() = "1" Then
                'GetPageSpecificFilters = " AND ToolID  IN (SELECT SkillID FROM tbl_PM_ResourcePoolSkills WHERE ResourcePoolID = " + strResourcePoolID + ")"
                GetPageSpecificFilters = " AND ResourcePoolID = " + strResourcePoolID + " AND IsSelected = 1 "
            End If
            If showSelected.ToUpper() = "0" Then
                GetPageSpecificFilters = " AND ResourcePoolID = " + strResourcePoolID '+ ")"
            End If
        End If

    End Function
End Class
