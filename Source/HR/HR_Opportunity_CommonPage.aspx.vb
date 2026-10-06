Imports CommonEngines.General.cEventHandlers

Public Class HR_Opportunity_CommonPage
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
    Private strOpportunityID As String

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "HR_Opportunity_CommonList.aspx"
        MyBase.strFormPage = "HR_Opportunity_CommonPage.aspx"

        If Request.QueryString("FromXML") = "1" Then
            Response.Clear()
            Select Case Request.QueryString("From")
                Case "BG"
                    Response.Write(GetBGwiseOU())
                Case "OU"
                    Response.Write(GetOUWiseDU())
                Case "DU"
                    Response.Write(GetDUWiseDT())
                Case "DurationValidation"
                    Response.Write(GetApproxEndDate())
            End Select
            Response.End()
        Else
            MyBase.Page_Load(sender, e)
        End If
    End Sub

    Private Function GetApproxEndDate() As String
        Dim StartDate As String = Request.QueryString("StartDate")
        Dim Duration As String = Request.QueryString("Duration")
        If Duration <> "" And StartDate <> "" Then
            'GetApproxEndDate = "DATE$___#" + CType(CommonFunction.Data.GetDataScalar("SELECT REPLACE((convert(varchar(50),cast(DATEADD(mm," + Duration.Trim + ",'" + StartDate.Trim + "') AS SMALLDATETIME ),106)) ,' ','-') ", MyBase.UseSQL), String)
            GetApproxEndDate = "DATE$___#" + CType(CommonFunction.Data.GetDataScalar("SELECT REPLACE((convert(varchar(50),cast([dbo].udf_Get_EndDate('" + StartDate.Trim + "'," + Duration.Trim + ") AS SMALLDATETIME ),106)) ,' ','-') ", MyBase.UseSQL), String)
            Exit Function
        End If
        GetApproxEndDate = "DATE$___#ERROR"

    End Function
    Private Function GetBGwiseOU() As String
        Dim dr As IDataReader
        Dim strQuery As String
        Dim strBGID As String
        Dim strJscript As String = "BG"
        If Request.QueryString("BusinessGroupID") Is Nothing OrElse Request.QueryString("BusinessGroupID") = "" Then
            strBGID = "NULL"
        Else
            strBGID = Request.QueryString("BusinessGroupID")
        End If
        strQuery = "usp_Sel_GetBusinessGroupsForLocation " + strBGID + ",NULL,0"
        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            strJscript = strJscript + "$___#" + CType(dr("OUPoolID"), String) + "$___#" + CType(dr("Location"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript
    End Function
    Private Function GetOUWiseDU() As String
        Dim dr As IDataReader
        Dim strQuery As String
        Dim strOUID As String
        Dim strJscript As String = "OU"
        If Request.QueryString("LocationID") Is Nothing OrElse Request.QueryString("LocationID") = "" Then
            strOUID = "NULL"
        Else
            strOUID = Request.QueryString("LocationID")
        End If
        strQuery = "usp_Sel_GetResourcePoolForLocation " + strOUID + ",0"
        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            strJscript = strJscript + "$___#" + CType(dr("ResourcePoolID"), String) + "$___#" + CType(dr("ResourcePoolName"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript
    End Function
    Private Function GetDUWiseDT() As String
        Dim dr As IDataReader
        Dim strQuery As String
        Dim strDUID As String
        Dim strJscript As String = "DU"
        If Request.QueryString("DeliveryUnitID") Is Nothing OrElse Request.QueryString("DeliveryUnitID") = "" Then
            strDUID = "NULL"
        Else
            strDUID = Request.QueryString("DeliveryUnitID")
        End If
        strQuery = "usp_sel_GetDeliverayTeam " + strDUID + ",0"
        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            strJscript = strJscript + "$___#" + CType(dr("GroupID"), String) + "$___#" + CType(dr("GroupName"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript
    End Function

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)
        If MyBase.GlobalObject.TagID = 3851 Or MyBase.GlobalObject.TagID = 3865 Then
            If strOpportunityID = "" Then
                strOpportunityID = HttpContext.Current.Request.QueryString("OpportunityID_PK")
                If strOpportunityID Is Nothing OrElse strOpportunityID = "" Then
                    strOpportunityID = HttpContext.Current.Request.Form("OpportunityID_PK")
                End If
            End If

            If strOpportunityID <> "" Then
                Dim strOpportunityApprovalStatus As String
                strOpportunityApprovalStatus = CType(CommonFunction.Data.GetDataScalar("usp_Sel_tbl_RM_Opportunity_ApprovalStatus " + strOpportunityID, MyBase.UseSQL), String)
                Args.RightPageCaption = "Approval Status : " + strOpportunityApprovalStatus + "&nbsp;&nbsp;"
            End If
        End If


    End Sub

    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        strOpportunityID = HttpContext.Current.Request.QueryString("OpportunityID_PK")
        If strOpportunityID Is Nothing OrElse strOpportunityID = "" Then
            strOpportunityID = HttpContext.Current.Request.Form("OpportunityID_PK")
        End If

        If strOpportunityID = "" Then
            strOpportunityID = PrimaryKey
        End If

        'Addition by SuchitraP on 12-Dec-2007 
        'Purpose:To save engagement probability values for particular opportunity
        Dim strProbabilityBy As String
        Dim strCreatedBy As String
        Dim strEngagementProbability As String
        Dim strComments As String
        Dim strSQL As String
        Dim dr As IDataReader

        strProbabilityBy = Session("intUserID").ToString
        strCreatedBy = Session("strUserName").ToString
        strEngagementProbability = HttpContext.Current.Request.Form("NonDatabase6").Trim
        strComments = HttpContext.Current.Request.Form("NonDatabase7")
        strComments = strComments.Replace("'", "''")

        If strEngagementProbability.Trim <> "" Then
            If strComments <> "" Then
                strSQL = "usp_Ins_tbl_RM_Opportunity_Probability " + strProbabilityBy + ",'" + strCreatedBy + "'," + strOpportunityID + "," + strEngagementProbability + ",'" + strComments + "'"
                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            End If
        End If
        'End of adition by SuchitraP

        ''''Added by ShraddhaM on 14,Dec 2007 to insert data in distribution when we change Approximate Duration and Date.
        ''''To Update SoftBooking when we update Role
        '''strSQL = "UPDATE tbl_RM_SoftBooking SET ResourceInDate='" + Request.Form("ApproxStartDate") + "'"
        '''strSQL += ",ResourceOutDate ='" + DateAdd("m", CType(Request.Form("ApproxDuration"), Double), CDate(Request.Form("ApproxStartDate"))).ToString("dd-MMM-yyyy") + "'"
        '''strSQL += " WHERE OpportunityID =" + PrimaryKey

        '''CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        '''dr = CommonFunction.Data.GetDataReader("select BookingID from tbl_RM_SoftBooking where OpportunityID = " + PrimaryKey, MyBase.UseSQL)
        '''While dr.Read
        '''    CommonFunction.Data.InsertOrUpdateData("usp_Ins_tbl_RM_SoftBooking_Distribution " + dr("BookingID").ToString + ",'" + Request.Form("ApproxStartDate") + "','" + DateAdd("m", CType(Request.Form("ApproxDuration"), Double), CDate(Request.Form("ApproxStartDate"))).ToString("dd-MMM-yyyy") + "'", MyBase.UseSQL)
        '''End While
        '''CommonFunction.Data.DisposeDataReader(dr)
        ''''End of addition By ShraddhaM
    End Function


    Protected Overrides Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cPlotGrid
        If m_objSubTagGlobal.TagID = 3309 Or m_objSubTagGlobal.TagID = 3305 Or m_objSubTagGlobal.TagID = 3313 Then
            Return New cOpportunity_Documents_PlotGrid(m_objSubTagGlobal)
        Else
            Return MyBase.InitSubTag_PlotGrid(m_objSubTagGlobal)
        End If

    End Function
    'Addition by SuchitraP on 13-Dec-2007 
    'Purpose:To hide the controls when value for that control is blank
    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cOpportunity_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function
    'End of addition by SuchitraP on 13-Dec-2007 

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.LinkName.ToUpper() = "REVISION" Then
            Dim m_objAccess As WebPage.Templates.AccessRights = New WebPage.Templates.AccessRights
            'Get the Access Rights 
            m_objAccess.GetAccess(m_objGlobal)
            If m_objAccess.Edit = False Then
                Cancel = True
            End If
        End If

    End Sub
End Class

Public Class cOpportunity_Documents_PlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim Isurl As Boolean

        If Args.ColumnName = "Review" Or Args.ColumnName = "Show History" Or Args.ColumnName = "Size (KB)" Then
            Isurl = CType(Args.DataReader("IsURL"), Boolean)
            If Isurl = True Then
                Cancel = True
                Args.StringToBeInserted = "<TD align='left'>-</TD>"
            End If
        End If

        If Args.ColumnName = "Document Name" Then
            Isurl = CType(Args.DataReader("IsURL"), Boolean)
            If Isurl = True Then
                Cancel = True
                Args.StringToBeInserted = "<TD   align=Left ><A href='" + Args.DataReader("FileName").ToString + "' target=_blank >" + Args.DataReader("FileName").ToString + "</A></TD>"
            End If
        End If
    End Sub
End Class
'Addition by SuchitraP on 13-Dec-2007 
'Purpose:To hide the controls when value for that control is blank
Public Class cOpportunity_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Private EngProb As String
    Private CreatedBy As String
    Private CreatedDate As String
    Private Comments As String
    'Added By ShraddhaM
    Private EngProbNew As String
    Private CreatedByNew As String
    Private CommentsNew As String
    Private CreatedDateNew As String

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")
        Dim dr As IDataReader
        Dim dr1 As IDataReader


        If Args.ControlName = "NonDatabase2" Or Args.ControlName = "NonDatabase1" Or Args.ControlName = "NonDatabase4" Or Args.ControlName = "NonDatabase5" Then
            'Cancel = True
            If EngProb = "" Then
                ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                ''dr = CommonFunction.Data.GetDataReader("Select EngagementProbability, CreatedBy, Comments,CreatedDate from tbl_RM_Opportunity_Probability Where ProbabilityID = (SELECT MAX(ProbabilityID) - 1 FROM tbl_RM_Opportunity_Probability WHERE OpportunityID = " + drControls("OpportunityID").ToString + ") AND OpportunityID = " + drControls("OpportunityID").ToString, True)  ''remove hard code
                dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_RM_Opportunity_Probability " + drControls("OpportunityID").ToString, True)
                ''dr1 = CommonFunction.Data.GetDataReader("Select EngagementProbability, CreatedBy, Comments,CreatedDate from tbl_RM_Opportunity_Probability Where ProbabilityID = (SELECT MAX(ProbabilityID)  FROM tbl_RM_Opportunity_Probability WHERE OpportunityID = " + drControls("OpportunityID").ToString + ") AND OpportunityID = " + drControls("OpportunityID").ToString, True)  ''remove hard code
                dr1 = CommonFunction.Data.GetDataReader("usp_sel_tbl_RM_Opportunity_Probability_Comments " + drControls("OpportunityID").ToString, True)  ''remove hard code
                ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query                If dr1.Read Then
                If dr1.Read Then
                    EngProbNew = dr1("EngagementProbability").ToString
                    CreatedByNew = dr1("CreatedBy").ToString
                    CommentsNew = dr1("Comments").ToString
                    CreatedDateNew = CommonFunctions.Dates.CGetDate(CType(dr1("CreatedDate"), Date))

                End If
                If dr.Read Then
                    EngProb = dr("EngagementProbability").ToString
                    CreatedBy = dr("CreatedBy").ToString
                    Comments = dr("Comments").ToString
                    CreatedDate = CommonFunctions.Dates.CGetDate(CType(dr("CreatedDate"), Date))

                End If
                CommonFunction.Data.DisposeDataReader(dr)
                CommonFunction.Data.DisposeDataReader(dr1)
            End If
            If EngProb = "" Then
                Cancel = True
            Else
                Select Case Args.ControlName.ToUpper
                    Case "NONDATABASE1"
                        Cancel = True
                    Case "NONDATABASE4"
                        If CreatedBy = "" Then Cancel = True
                    Case "NONDATABASE5"
                        Cancel = True
                End Select
            End If
        End If

        'Addition done by SuchitraP on 22 Feb 2008 for IssueID 19082
        'Purpose:To remove Customer line when only View access is given
        If Args.ControlName.ToUpper = "PROSPECT" Then
            Dim m_objAccess As WebPage.Templates.AccessRights = New WebPage.Templates.AccessRights
            'Get the Access Rights 
            m_objAccess.GetAccess(WhizGlobal)
            If m_objAccess.Edit = False And m_objAccess.Add = False Then
                Args.HREF_URL = ""
                Args.HREF_Parameters = ""
            End If
        End If
        'End of addition by SuchitraP
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")

        If Args.ControlName = "NonDatabase2" Or Args.ControlName = "NonDatabase1" Or Args.ControlName = "NonDatabase4" Or Args.ControlName = "NonDatabase5" Then

            If EngProb = "" Then
                Cancel = True
            Else
                Select Case Args.ControlName.ToUpper
                    Case "NONDATABASE2"
                        If EngProbNew <> EngProb Or CommentsNew <> Comments Then
                            Args.DefaultValue = "1-" + EngProb
                        End If

                    Case "NONDATABASE1"
                        If Comments = "" Then Cancel = True

                        'Args.DefaultValue = "1-Comments" 
                    Case "NONDATABASE4"
                        If CreatedBy = "" Then Cancel = True
                        'Args.DefaultValue = "1-" + CreatedBy 
                        If CommentsNew <> Comments Or EngProbNew <> EngProb Then
                            Args.DefaultValue = "1-" + CreatedBy + "&nbsp;&nbsp;&nbsp;[" + CreatedDate + "]"
                        End If

                    Case "NONDATABASE5"
                        If Comments = "" Then
                            Cancel = True
                        Else
                            If CommentsNew <> Comments Or EngProbNew <> EngProb Then
                                Args.DefaultValue = "1-" + Comments
                            End If

                        End If

                        'Args.DefaultValue = "1-" + CreatedDate
                End Select
            End If


        End If
    End Sub


End Class
'End of addition by SuchitraP on 13-Dec-2007 


