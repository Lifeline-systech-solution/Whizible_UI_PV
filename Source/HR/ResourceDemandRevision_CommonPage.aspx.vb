Imports CommonEngines.General.cEventHandlers

Public Class ResourceDemandRevision_CommonPage
    Inherits CommonPage
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

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "../General/CommonList.aspx"
        MyBase.strFormPage = "ResourceDemandRevision_CommonPage.aspx"
        MyBase.Page_Load(sender, e)
    End Sub


    'Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
    '    'Put user code to initialize the page here
    '    Return New cResourceDemandRevision_CommonPagePlotControls(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
    '    Return New cResourceDemandRevision_CommonPagePlotControls(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
    '    Return New cResourceDemandRevision_CommonPageCPSQL(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
    '    Return New cResourceDemandRevision_CommonPageDataManagement(MyBase.m_objGlobal)
    'End Function


    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        '''Dim strSQL As String
        '''Dim strRevisionOf As String

        ''''strRevisionNo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(ControlsHashTable("RevisionNo"), "1"), "1")
        ''''strRevisionOf = HttpContext.Current.Request.QueryString("RevisionOf")
        '''If CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("OpportunityID"), ""), "") <> "" Then
        '''    'Response.Write("<script>")
        '''    'Response.Write("opener.location.href='../General/CommonList.aspx?FromWhere=RM&MasterTagID=3851';" + vbCrLf)
        '''    'Response.Write("window.close();")
        '''    'Response.Write("</script>")
        '''    AfterSave += "opener.location.href='../General/CommonList.aspx?FromWhere=RM&MasterTagID=3851';" + vbCrLf
        '''    AfterSave += vbCrLf + "window.close();"
        '''End If

        ''''''If CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("OpportunityID"), ""), "") <> "" Then
        ''''''    AfterSave += "opener.location.href='../HR/CommonList.aspx?FromWhere=SM&MasterTagID=3859';" + vbCrLf
        ''''''    AfterSave += vbCrLf + "window.close();"
        ''''''End If

        ''''''If CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("OpportunityID"), ""), "") <> "" Then
        ''''''    AfterSave += "opener.location.href='../PM/PM_ResourceTeamStructure_CommonList.aspx?FromWhere=SM&MasterTagID=3855';" + vbCrLf
        ''''''    AfterSave += vbCrLf + "window.close();"
        ''''''End If

        ''''Select Case strRevisionOf
        ''''    Case "OpportunityID"
        ''''        AfterSave += "opener.location.href='../HR/HR_Opportunity_CommonList.aspx?FromWhere=SM&MasterTagID=3851';" + vbCrLf
        ''''        AfterSave += vbCrLf + "window.close();"
        ''''    Case "SoftBookingID"
        ''''        AfterSave += "opener.location.href='../HR/CommonList.aspx?FromWhere=SM&MasterTagID=3859';" + vbCrLf
        ''''        AfterSave += vbCrLf + "window.close();"
        ''''    Case "TeamStructureID"
        ''''        AfterSave += "opener.location.href='../PM/PM_ResourceTeamStructure_CommonList.aspx?FromWhere=SM&MasterTagID=3855';" + vbCrLf
        ''''        AfterSave += vbCrLf + "window.close();"
        ''''End Select
        ''''If PrimaryKey <> "" Then
        ''''    strSQL = "usp_Ins_Tbl_RM_Opportunity_Published " + PrimaryKey
        ''''    CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        ''''    AfterSave += "opener.location.href='../General/CommonList.aspx?FromWhere=SM&MasterTagID=3851';" + vbCrLf
        ''''    AfterSave += vbCrLf + "window.close();"
        ''''End If
        '''RedirectToCL = False
        ''''strActionCode = ReturnCodes.ON_LOAD.ToString
        '''strActionCode = ReturnCodes.DO_NOTHING.ToString

    End Function

    Public Overrides Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String
        Dim strRevisionOf As String
        Dim strSQL, strRevisionDate, strRevisedBy, strComments, strRevisionNo, strMasterPK, strPrimaryKey As String
        strRevisionDate = HttpContext.Current.Request.Form("RevisionDate")
        strRevisedBy = HttpContext.Current.Request.Form("RevisedBy")
        strComments = HttpContext.Current.Request.Form("Comments")
        strRevisionNo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("RevisionNo"), "1"), "1")
        'strRevisionOf = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.QueryString("Revisionof"), ""), "")
        'HttpContext.Current.Request.QueryString("Revisionof")
        If CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.Form("hidOpportunityID"), ""), "") <> "" Then
            strMasterPK = HttpContext.Current.Request.Form("hidOpportunityID")
            strSQL = "Usp_Ins_tbl_RM_Opportunity_Revision " + strRevisionNo + ",'" + strRevisionDate
            strSQL += "'," + strRevisedBy + "," + strMasterPK
            strSQL += ",'" + CommonFunction.General.BuildQueryString(strComments) + "'"
            strPrimaryKey = CType(CommonFunction.Data.GetDataScalar(strSQL, True), String)

            If strPrimaryKey <> "" Then
                strSQL = "usp_Ins_Tbl_RM_Opportunity_Published " + strPrimaryKey
                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            End If
            BeforeSave += "opener.location.href='../General/CommonList.aspx?FromWhere=RM&MasterTagID=3851';" + vbCrLf
            BeforeSave += vbCrLf + "window.close();"
        End If

        If CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.Form("hidBookingID"), ""), "") <> "" Then
            strMasterPK = HttpContext.Current.Request.Form("hidBookingID")
            strSQL = "Usp_Ins_tbl_RM_SoftBooking_Revision " + strRevisionNo + ",'" + strRevisionDate
            strSQL += "'," + strRevisedBy + "," + strMasterPK
            strSQL += ",'" + CommonFunction.General.BuildQueryString(strComments) + "'"
            strPrimaryKey = CType(CommonFunction.Data.GetDataScalar(strSQL, True), String)

            If strPrimaryKey <> "" Then
                strSQL = "usp_Ins_Tbl_RM_SoftBooking_Published " + strPrimaryKey
                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            End If
            BeforeSave += "opener.location.href='../General/CommonList.aspx?FromWhere=RM&MasterTagID=3859';" + vbCrLf
            BeforeSave += vbCrLf + "window.close();"
        End If

        If CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpContext.Current.Request.Form("hidTeamStructureID"), ""), "") <> "" Then
            strMasterPK = HttpContext.Current.Request.Form("hidTeamStructureID")
            strSQL = "Usp_Ins_tbl_PM_TeamStructure_Revision " + strRevisionNo + ",'" + strRevisionDate
            strSQL += "'," + strRevisedBy + "," + strMasterPK
            strSQL += ",'" + CommonFunction.General.BuildQueryString(strComments) + "'"
            strPrimaryKey = CType(CommonFunction.Data.GetDataScalar(strSQL, True), String)

            If strPrimaryKey <> "" Then
                strSQL = "usp_Ins_Tbl_PM_Teamstructure_Published " + strPrimaryKey
                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            End If
            BeforeSave += "opener.location.href='../General/CommonList.aspx?FromWhere=PM&MasterTagID=3855';" + vbCrLf
            BeforeSave += vbCrLf + "window.close();"
        End If

        strActionCode = ReturnCodes.IGNORE_SAVE.ToString
        RedirectToCL = False
    End Function

    Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        If Not HttpContext.Current.Request.QueryString("OpportunityID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("OpportunityID") <> "" Then
            HttpContext.Current.Response.Write("<input type=hidden name='hidOpportunityID' value='" + HttpContext.Current.Request.QueryString("OpportunityID") + "'>")
        End If
        If Not HttpContext.Current.Request.QueryString("BookingID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("BookingID") <> "" Then
            HttpContext.Current.Response.Write("<input type=hidden name='hidBookingID' value='" + HttpContext.Current.Request.QueryString("BookingID") + "'>")
        End If
        If Not HttpContext.Current.Request.QueryString("TeamStructureID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("TeamStructureID") <> "" Then
            HttpContext.Current.Response.Write("<input type=hidden name='hidTeamStructureID' value='" + HttpContext.Current.Request.QueryString("TeamStructureID") + "'>")
        End If
    End Function

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)
        If Not HttpContext.Current.Request.QueryString("OpportunityID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("OpportunityID") <> "" Then
            Args.LeftPageCaption = "Opportunity Revision"
        End If
        If Not HttpContext.Current.Request.QueryString("BookingID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("BookingID") <> "" Then
            Args.LeftPageCaption = "Soft Booking Revision"
        End If
        If Not HttpContext.Current.Request.QueryString("TeamStructureID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("TeamStructureID") <> "" Then
            Args.LeftPageCaption = "Team Structure Revision"
        End If
    End Sub
End Class

'Public Class cResourceDemandRevision_CommonPageDataManagement
'    Inherits CommonEngine.CommonPage.cDataManagement
'    'Constructor
'    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
'        Call MyBase.New(WhizGlobal)
'    End Sub
'End Class

'Public Class cResourceDemandRevision_CommonPageCPSQL
'    Inherits CommonEngine.CommonPage.cCPSQL
'    'Constructor
'    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
'        Call MyBase.New(WhizGlobal)
'    End Sub
'End Class

'Public Class cResourceDemandRevision_CommonPagePlotControls
'    Inherits CommonEngine.CommonPage.cPlotControls
'    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
'        ''Assign the Parameter values to the local variables
'        Call MyBase.New(WhizGlobal)
'    End Sub
'End Class


