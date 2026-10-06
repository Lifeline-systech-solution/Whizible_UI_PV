Imports CommonEngines.General.cEventHandlers
Imports CommonFunctions

Public Class cProjectRequirements_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cProjectRequirements_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cProjectRequirements_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cProjectRequirements_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls

    Private m_strProjectID As String
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
        If HttpContext.Current.Request.QueryString("ProjectID") <> "" Then
            m_strProjectID = HttpContext.Current.Request.QueryString("ProjectID")
        Else
            m_strProjectID = HttpContext.Current.Request.Form("hidProjectID")
        End If
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        Dim strSQL As String
        Dim strcurrency As String
        Dim drcaption As IDataReader
        Dim strProjectRequirementID As String
        Dim drRev As IDataReader
        Dim intStatus As Integer

        strProjectRequirementID = Args.PrimaryKeyValue
        'Added by PrashantD for removing session projectID placeholder to queryString ProjectID
        If Args.AdditionalInformation <> "" Then
            Args.AdditionalInformation = Args.AdditionalInformation.Replace("<PROJECT_ID>", m_strProjectID)
        End If

        If Args.AddNewRelativeSource <> "" Then
            Args.AddNewRelativeSource = Args.AddNewRelativeSource.Replace("<PROJECT_ID>", m_strProjectID)
        End If

        If Args.DropDownEditSQL <> "" Then
            Args.DropDownEditSQL = Args.DropDownEditSQL.Replace("<PROJECT_ID>", m_strProjectID)
        End If

        If Args.EditRelativeSource <> "" Then
            Args.EditRelativeSource = Args.EditRelativeSource.Replace("<PROJECT_ID>", m_strProjectID)
        End If

        'End of addition by PrashantD

        If Args.ControlName.ToUpper = "ESTIMATEDCOST" Then

            'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
            'strSQL = "select distinct currencycode FROM tbl_PM_Project P,tbl_PM_CurrencyMaster c Where c.CurrencyID=P.BaseCurrency and P.BaseCurrency=(select basecurrency from tbl_Pm_Project Where ProjectID=" + m_strProjectID + ")"
            strSQL = "usp_sel_tbl_PM_CurrencyMaster_currencycode " + m_strProjectID
            'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
            drcaption = CommonFunctions.Data.GetDataReader(strSQL, True)
            If drcaption.Read Then
                strcurrency = CStr(drcaption("currencycode"))

            End If
            CommonFunction.Data.DisposeDataReader(drcaption)
            Args.InsertAfterControl = " " + "  [ " + strcurrency + " ] "

            If strProjectRequirementID <> "" Then
                intStatus = CInt(drControls.Item("SentForApproval"))
                If intStatus = 1 Or intStatus = 3 Then
                    Args.Editable = False
                End If
            End If
        ElseIf Args.ControlName.ToUpper = "PLANNEDSTARTDATE" And strProjectRequirementID <> "" Then
            intStatus = CInt(drControls.Item("SentForApproval"))
            If intStatus = 1 Or intStatus = 3 Then
                Args.Editable = False
            End If

        ElseIf Args.ControlName.ToUpper = "PLANNEDENDDATE" And strProjectRequirementID <> "" Then
            intStatus = CInt(drControls.Item("SentForApproval"))
            If intStatus = 1 Or intStatus = 3 Then
                Args.Editable = False
            End If

        ElseIf Args.ControlName.ToUpper = "ESTIMATEDEFFORTS" And strProjectRequirementID <> "" Then
            intStatus = CInt(drControls.Item("SentForApproval"))
            If intStatus = 1 Or intStatus = 3 Then
                Args.Editable = False
            End If

            ''added by RohiniK on 03 Jun 07 for WeServe
        ElseIf Args.ControlName.ToUpper = "NONDATABASE6" And strProjectRequirementID <> "" Then
            Args.DefaultValue = "2-SELECT IsNull(Sum(EstimatedEfforts), 0) FROM tbl_RM_ProjectRequirements WHERE ProjectID= <#ProjectID> AND ProjectRequirementID <> " & strProjectRequirementID
            ''End of added by RohiniK on 03 Jun 07 for WeServe


        ElseIf Args.ControlName.ToUpper = "ENDDATEBYCLIENT" And strProjectRequirementID <> "" Then

            intStatus = CInt(drControls.Item("SentForApproval"))
            If intStatus = 1 Or intStatus = 3 Then
                Args.Editable = False
            End If
        End If
    End Sub

End Class


Public Class ProjectRequirements_CommonPage
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
    Private m_strProjectID As String
    Protected m_strStartDate As String
    Protected m_strEndDate As String
    Protected m_intEfforts As Integer
    Private isUpperMenuPlotted As Boolean = False


    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "ProjectRequirements_CommonList.aspx"
        MyBase.strFormPage = "ProjectRequirements_CommonPage.aspx"
        MyBase.strSubTagFormPage = "../General/CommonSubTag.aspx"

        If Request.QueryString("ProjectID") <> "" Then
            m_strProjectID = Request.QueryString("ProjectID")
        Else
            m_strProjectID = Request.Form("hidProjectID")
        End If
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Dim strUrl As String = Request.RawUrl()
        CommonFunction.General.WriteHTML("<input type=hidden name=hidProjectID id=hidProjectID value=" + m_strProjectID + ">")
        If Request.Form("hidURL") = "" Then
            strUrl = ".." + strUrl.Substring(strUrl.IndexOf("/RM/"))
        Else
            strUrl = Request.Form("hidURL")
        End If
        CommonFunction.General.WriteHTML("<input type=hidden name=hidURL id=hidURL value=" + strUrl + ">")
        Return New cProjectRequirements_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cProjectRequirements_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cProjectRequirements_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cProjectRequirements_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitSubTagCLSQL(ByVal WhizGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cProjectRequirements_CommonPageSubTagCLSQL(WhizGlobal)
    End Function
    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        'Added by PrashantD on 9 Jan 2007 
        CommonFunction.General.WriteHTML("<SCRIPT>window.opener.document.forms[0].action=""../RM/RM_Tracking.aspx"";")
        CommonFunction.General.WriteHTML("window.opener.document.forms[0].submit();")
        If Request.QueryString("Mode") = "ADD_NEW" Then
            CommonFunction.General.WriteHTML("window.close();")
        End If
        CommonFunction.General.WriteHTML("</SCRIPT>")
        'End of addition by PrashantD on 9 Jan 2007
    End Function
    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim RevisionId As String
        Dim intProjectRequirementId As Integer
        Dim strsql As String
        Dim drApprover As IDataReader
        Dim strProjectRequirementID As String

        'Added by PrashantD for removing session projectID placeholder to queryString ProjectID
        If Args.CustomLink <> "" Then
            Args.CustomLink = Args.CustomLink.Replace("<PROJECT_ID>", m_strProjectID)
        End If
        'End of Addition by PrashantD

        '---- APPROVING REQUIREMENT
        If Args.LinkName.ToUpper = "APPROVE" Then
            If Args.PrimaryKeyValue <> "" Then

                'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                'strsql = "Select max(RevisionReasonId) RevisionReasonId from tbl_RM_ReqRevisionReason where ProjectRequirementId=" + Args.PrimaryKeyValue.ToString()
                strsql = "usp_sel_tbl_RM_ReqRevisionReason_RevisionReasonIdMax " + Args.PrimaryKeyValue.ToString()
                'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
                drApprover = CommonFunctions.Data.GetDataReader(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If CommonFunctions.General.CheckIsNothing(drApprover, "") <> "" Then
                    If drApprover.Read() Then
                        RevisionId = CType(CommonFunctions.Data.CheckIsDBNull(drApprover("RevisionReasonId"), ""), String)
                    End If
                End If
                CommonFunction.Data.DisposeDataReader(drApprover)
            End If
            If Args.ClientSideFunctionName.ToUpper = "APPROVE_ONCLICK" Then
                Args.ToBeInsertedInFunction = "window.open ('../RM/Approve_CommonPage.aspx?ProjectID=" + m_strProjectID + "&RevisionReasonID_PK=" + RevisionId + "&MasterTagId=3728&FromWhere=PM&Mode=EDIT&FromCL=1&ProjectRequirementId=" + Args.PrimaryKeyValue.ToString() + "', '', 'resizable=yes,scrollbars=yes,left=' + ((window.screen.width - 600)/2) + ',top=' + ((window.screen.height - 500)/2) + ',width=600,height=500');"
                Args.ToBeInsertedInFunction += "return;"
            End If
        End If

        '------- REJECTING REQUIREMENT
        If Args.LinkName.ToUpper = "REJECT" Then
            If Args.PrimaryKeyValue <> "" Then
                strsql = "Select max(RevisionReasonId) RevisionReasonId from tbl_RM_ReqRevisionReason where ProjectRequirementId=" + Args.PrimaryKeyValue.ToString()
                drApprover = CommonFunctions.Data.GetDataReader(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If CommonFunctions.General.CheckIsNothing(drApprover, "") <> "" Then
                    If drApprover.Read() Then
                        RevisionId = CType(CommonFunctions.Data.CheckIsDBNull(drApprover("RevisionReasonId"), ""), String)
                    End If
                End If
                CommonFunction.Data.DisposeDataReader(drApprover)
            End If
            If Args.ClientSideFunctionName.ToUpper = "REJECT_ONCLICK" Then
                Args.ToBeInsertedInFunction = "window.open ('../RM/Approve_CommonPage.aspx?ProjectID=" + m_strProjectID + "&RevisionReasonID_PK=" + RevisionId + "&MasterTagId=3728&FromWhere=PM&Mode=REJECT&FromCL=1&ProjectRequirementId=" + Args.PrimaryKeyValue.ToString() + "', '', 'resizable=yes,scrollbars=yes,left=' + ((window.screen.width - 600)/2) + ',top=' + ((window.screen.height - 500)/2) + ',width=600,height=500');"
                Args.ToBeInsertedInFunction += "return;"
            End If
        End If

    End Sub

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)
        Dim strSQL As String
        Dim drStatus As IDataReader
        Dim intStatus As Integer
        Dim strProjectRequirementID As String
        Dim strMode As String

        If Args.LeftPageCaption.ToUpper = "WORK PRODUCTS" Then
            Cancel = True
        End If

        strProjectRequirementID = Gen.PrimaryKeyValue  'CInt(HttpContext.Current.Request.QueryString("ProjectRequirementID_PK"))

        If strProjectRequirementID <> "" Then

            'strSQL = "Select SentForApproval From tbl_rm_ProjectRequirements Where ProjectRequirementID=" + strProjectRequirementID
            strSQL = "usp_sel_tbl_rm_ProjectRequirements_SentForApproval " + strProjectRequirementID
            drStatus = CommonFunctions.Data.GetDataReader(strSQL, True)
            If drStatus.Read Then
                intStatus = CInt(drStatus.Item("SentForApproval"))
                If intStatus = 0 Then
                    Args.RightPageCaption = "Status: Pending Approval"
                ElseIf intStatus = 1 Then
                    Args.RightPageCaption = "Status: Approved"
                ElseIf intStatus = 2 Then
                    Args.RightPageCaption = "Status: Rejected"
                ElseIf intStatus = 3 Then
                    Args.RightPageCaption = "Status: Sent for Approval"
                End If
            End If
            CommonFunction.Data.DisposeDataReader(drStatus)
        End If

    End Sub

    Protected Overrides Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cPlotGrid
        'Modified by AbhijitD on 22-Jun-07 to identify the correct subtab before plotting grid
        Select Case m_objSubTagGlobal.TagID
            Case 10072
                Return New cProjectRequirements_WorkProducts_PlotGrid(m_objSubTagGlobal)

                'Comment and addition by SuchitraP on 14 Sept 2007
                'Case 10085
            Case 3219
                'End of Comment and addition by SuchitraP on 14 Sept 2007
                Return New cProjectRequirements_TraceablityReference_PlotGrid(m_objSubTagGlobal)
        End Select
        'End of modification by AbhijitD on 22-Jun-07
    End Function

    Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        Dim strMode As String
        strMode = CType(HttpContext.Current.Request.QueryString("Mode"), String)
        If strMode <> "" Then
            If strMode.ToUpper = "APPROVE" Then
                'Do net set focus on any of the control 
                PageUIPostRender = vbCrLf & "var objCtrl = GetObjectReference('frmCommonPage','RequirementCode');" & vbCrLf & "if (objCtrl!= null)" & vbCrLf & "    objCtrl.focus=false;"
                strActionCode = ReturnCodes.ON_LOAD.ToString

            End If
            If strMode.ToUpper = "SENDMAIL" Then
                'Do net set focus on any of the control 
                PageUIPostRender = vbCrLf & "var objCtrl = GetObjectReference('frmCommonPage','RequirementCode');" & vbCrLf & "if (objCtrl!= null)" & vbCrLf & "    objCtrl.focus=false;"
                strActionCode = ReturnCodes.ON_LOAD.ToString

            End If
        End If
    End Function
    Protected Overrides Sub Before_Menu_Print(ByRef Cancel As Boolean, ByRef Args As WAF_MenuLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If isUpperMenuPlotted = False Then
            isUpperMenuPlotted = True
            RM_CommonFunction.Genereal.DrawRequirementHeaderNavigation("Requirement", Args.PrimaryKeyValue, m_strProjectID)
        End If
    End Sub

    Public Overrides Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String
        Dim strSQL As String
        Dim strPrevStatus, strReopenStatus As String

        If PrimaryKey <> "" Then

            'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
            'strSQL = "SELECT StatusID FROM tbl_RM_ProjectRequirements PR WHERE ProjectRequirementID=" & PrimaryKey
            strSQL = "usp_sel_tbl_RM_ProjectRequirements_StatusID " & PrimaryKey
            'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
            'Comment BY VarunA on 5-Sep-2007
            'strPrevStatus = Data.CheckIsDBNull(General.CheckIsNothing(Data.GetDataScalar(strSQL, MyBase.UseSQL)))
            strPrevStatus = CType(Data.CheckIsDBNull(General.CheckIsNothing(Data.GetDataScalar(strSQL, MyBase.UseSQL))), String)
            'End by VarunA on 5-Sep-2007

            'Comment BY VarunA on 5-Sep-2007
            'If ControlsHashTable("StatusID") <> strPrevStatus Then
            If CType(ControlsHashTable("StatusID"), String) <> strPrevStatus Then
                'End by VarunA on 5-Sep-2007

                strSQL = "SELECT StatusID FROM tbl_RM_ReuirementStatus WHERE MappedToReopen=1"
                'Comment BY VarunA on 5-Sep-2007
                'strReopenStatus = Data.CheckIsDBNull(General.CheckIsNothing(Data.GetDataScalar(strSQL, MyBase.UseSQL)))
                strReopenStatus = CType(Data.CheckIsDBNull(General.CheckIsNothing(Data.GetDataScalar(strSQL, MyBase.UseSQL))), String)

                'If ControlsHashTable("StatusID") = strReopenStatus Then
                If CType(ControlsHashTable("StatusID"), String) = strReopenStatus Then
                    'End by VarunA on 5-Sep-2007
                    CommonFunction.Data.InsertOrUpdateData("usp_Upd_tbl_RM_ProjectRequirements_ReopenParents " + m_strProjectID + "," + PrimaryKey, MyBase.UseSQL)

                End If
            End If

        End If

        'Dim strProjStartDate, strProjEndDate As String
        'Dim dblProjEstimatedEfforts, dblTotalRqmtEfforts, dblCurRqmtEfforts As Double
        'Dim strSQL As String
        'Dim drApprover As IDataReader

        'strSQL = "SELECT ExpectedStartDate, ExpectedEndDate, EstimatedEfforts FROM tbl_PM_Project WHERE ProjectID=" & m_strProjectID
        'drApprover = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        'If drApprover.Read Then
        '    strProjStartDate = CommonFunction.Data.CheckIsDBNull(drApprover.Item("ExpectedStartDate"))
        '    strProjEndDate = CommonFunction.Data.CheckIsDBNull(drApprover.Item("ExpectedEndDate"))
        '    dblProjEstimatedEfforts = CDbl(CommonFunction.Data.CheckIsDBNull(drApprover.Item("EstimatedEfforts"), "0"))
        'End If

        'CommonFunction.Data.DisposeDataReader(drApprover)

        'strSQL = "SELECT IsNull(Sum(EstimatedEfforts), 0) FROM tbl_RM_ProjectRequirements WHERE ProjectID=" & m_strProjectID
        ''' commented added by RohiniK on 30 Jun 07
        '' strSQL = "SELECT IsNull(Sum(EstimatedEfforts), 0) FROM tbl_RM_ProjectRequirements WHERE ProjectID=" & m_strProjectID & " AND ProjectRequirementID<>" & PrimaryKey
        'If General.CheckIsNothing(PrimaryKey, "") <> "" Then
        '    strSQL = strSQL & " AND ProjectRequirementID <> " & PrimaryKey
        'End If
        '''end of comment and addition by RohiniK on 30 Jun 07

        'dblTotalRqmtEfforts = General.CheckIsNothing(Data.CheckIsDBNull(Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), "0")
        ''modified by RohiniK on on 30 Jun 07
        'If ControlsHashTable("EstimatedEfforts") <> "" Then
        '    dblCurRqmtEfforts = CDbl(ControlsHashTable("EstimatedEfforts"))
        'Else
        '    dblCurRqmtEfforts = 0
        'End If
        '''end of modification by RohiniK on 30 Jun 07

        'If strProjStartDate <> "" And strProjEndDate <> "" Then
        '    If CDate(ControlsHashTable("PlannedStartDate")) < CDate(strProjStartDate) And _
        '       CDate(ControlsHashTable("PlannedEndDate")) > CDate(strProjEndDate) Then

        '        Response.Write("<Script>alert('Requirement Planned Start Date and End Date must be between Project Start Date: " & strProjStartDate & " and End Date: " & strProjEndDate & "');</Script>")
        '        strActionCode = ReturnCodes.IGNORE_SAVE.ToString

        '    ElseIf CDate(ControlsHashTable("PlannedStartDate")) < CDate(strProjStartDate) Then
        '        Response.Write("<Script>alert('Requirement Planned Start Date cannot be less than Project Start Date: " & strProjStartDate & "');</Script>")
        '        strActionCode = ReturnCodes.IGNORE_SAVE.ToString

        '    ElseIf CDate(ControlsHashTable("PlannedEndDate")) > CDate(strProjEndDate) Then
        '        Response.Write("<Script>alert('Requirement Planned End Date cannot be greater than Project End Date: " & strProjEndDate & "');</Script>")
        '        strActionCode = ReturnCodes.IGNORE_SAVE.ToString

        '    End If

        '    If dblTotalRqmtEfforts + dblCurRqmtEfforts > dblProjEstimatedEfforts Then

        '        Response.Write("<Script>alert('Total Estimated Efforts of all Requirements cannot exceed Project Estimated Efforts. Balance Efforts are : " & (dblProjEstimatedEfforts - dblTotalRqmtEfforts) & "');</Script>")
        '        strActionCode = ReturnCodes.IGNORE_SAVE.ToString
        '    End If

        'End If

    End Function
End Class

Public Class cProjectRequirements_WorkProducts_PlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''commented by RohiniK on 21 Jun 07 --For WeServe RTM change 
        'Dim strSQL As String
        'Dim drWorkProd As IDataReader
        'Dim drDetails As IDataReader
        'Dim strProjectRequirementID As String
        'Dim strWorkProductType As String
        'Dim strWorkProductid As String

        'strWorkProductType = CStr(Args.DataReader("WorkProdtype"))
        'strProjectRequirementID = HttpContext.Current.Request.QueryString("ProjectRequirementID_pk")

        ''Change Request
        'If strWorkProductType = "Change Request" Then
        '    strWorkProductid = CStr(Args.DataReader("WorkProductID"))
        '    If Args.ColumnName.ToUpper = "NAME" Then

        '        strSQL = "Select ChangeRequestSummary AS WorkProduct FROM tbl_PM_ChangeRequest_Master Where ChangeRequestID=" + strWorkProductid.Replace("C:", "").Trim
        '        drWorkProd = Data.GetDataReader(strSQL, True)

        '        If drWorkProd.Read Then
        '            Args.IgnoreActualValue = True
        '            Args.ReplacementValue = CType(drWorkProd.Item("WorkProduct"), String)
        '        End If
        '        CommonFunctions.Data.DisposeDataReader(drWorkProd)

        '    ElseIf Args.ColumnName.ToUpper = "START DATE" Then
        '        strSQL = "Select PlannedStartDate  FROM tbl_PM_ChangeRequest_Master Where ChangeRequestID=" + strWorkProductid.Replace("C:", "").Trim
        '        drWorkProd = Data.GetDataReader(strSQL, True)

        '        If drWorkProd.Read Then
        '            Args.IgnoreActualValue = True
        '            If CStr(General.CheckIsNothing(drWorkProd.Item("PlannedStartDate"), "")) <> "" Then
        '                Args.ReplacementValue = CStr(CDate(drWorkProd.Item("PlannedStartDate")).Date)
        '            Else
        '                Args.ReplacementValue = ""
        '            End If
        '            CommonFunctions.Data.DisposeDataReader(drWorkProd)

        '        End If
        '    End If
        '    'Project Feature
        'ElseIf strWorkProductType = "Project Feature" Then
        '    strWorkProductid = CStr(Args.DataReader("WorkProductID"))
        '    If Args.ColumnName.ToUpper = "NAME" Then
        '        strSQL = "Select FeatureName AS WorkProduct FROM tbl_PM_Project_Features Where ProjectFeatureID=" + strWorkProductid.Replace("P:", "").Trim
        '        drWorkProd = Data.GetDataReader(strSQL, True)

        '        If drWorkProd.Read Then
        '            Args.IgnoreActualValue = True
        '            Args.ReplacementValue = CType(drWorkProd.Item("WorkProduct"), String)
        '        End If
        '        CommonFunctions.Data.DisposeDataReader(drWorkProd)
        '    End If

        '    'Deliverable
        'ElseIf strWorkProductType = "Deliverable" Then
        '    strWorkProductid = CStr(Args.DataReader("WorkProductID"))
        '    If Args.ColumnName.ToUpper = "NAME" Then
        '        strSQL = "Select Title AS WorkProduct FROM tbl_PM_OtherSchedules Where ScheduleID=" + strWorkProductid.Replace("D:", "").Trim
        '        drWorkProd = Data.GetDataReader(strSQL, True)

        '        If drWorkProd.Read Then
        '            Args.IgnoreActualValue = True
        '            Args.ReplacementValue = CType(drWorkProd.Item("WorkProduct"), String)
        '        End If
        '        CommonFunctions.Data.DisposeDataReader(drWorkProd)
        '    ElseIf Args.ColumnName.ToUpper = "START DATE" Then
        '        strSQL = "Select StartDate  FROM tbl_PM_OtherSchedules Where ScheduleID=" + strWorkProductid.Replace("D:", "").Trim
        '        drWorkProd = Data.GetDataReader(strSQL, True)

        '        If drWorkProd.Read Then
        '            Args.IgnoreActualValue = True
        '            If CStr(General.CheckIsNothing(drWorkProd.Item("StartDate"), "")) <> "" Then
        '                Args.ReplacementValue = CStr(CDate(drWorkProd.Item("StartDate")).Date)
        '            Else
        '                Args.ReplacementValue = ""
        '            End If
        '            CommonFunctions.Data.DisposeDataReader(drWorkProd)
        '        End If
        '    ElseIf Args.ColumnName.ToUpper = "END DATE" Then
        '        strSQL = "Select EarliestStartDate  FROM tbl_PM_OtherSchedules Where ScheduleID=" + strWorkProductid.Replace("D:", "").Trim
        '        drWorkProd = Data.GetDataReader(strSQL, True)

        '        If drWorkProd.Read Then
        '            Args.IgnoreActualValue = True
        '            If CStr(General.CheckIsNothing(drWorkProd.Item("EarliestStartDate"), "")) <> "" Then
        '                Args.ReplacementValue = CStr(CDate(drWorkProd.Item("EarliestStartDate")).Date)
        '            Else
        '                Args.ReplacementValue = ""
        '            End If

        '        End If
        '        CommonFunctions.Data.DisposeDataReader(drWorkProd)
        '    End If

        '    'Module
        'ElseIf strWorkProductType = "Module" Then
        '    strWorkProductid = CStr(Args.DataReader("WorkProductID"))
        '    If Args.ColumnName.ToUpper = "NAME" Then
        '        strSQL = "Select ModuleName AS WorkProduct FROM tbl_PM_Module Where ModuleID=" + strWorkProductid.Replace("M:", "").Trim
        '        drWorkProd = Data.GetDataReader(strSQL, True)

        '        If drWorkProd.Read Then
        '            Args.IgnoreActualValue = True
        '            Args.ReplacementValue = CType(drWorkProd.Item("WorkProduct"), String)
        '        End If
        '        CommonFunctions.Data.DisposeDataReader(drWorkProd)
        '    ElseIf Args.ColumnName.ToUpper = "START DATE" Then
        '        strSQL = "Select EstimatedStartDate FROM tbl_PM_Module Where ModuleID=" + strWorkProductid.Replace("M:", "").Trim
        '        drWorkProd = Data.GetDataReader(strSQL, True)

        '        If drWorkProd.Read Then
        '            Args.IgnoreActualValue = True
        '            If CStr(General.CheckIsNothing(drWorkProd.Item("EstimatedStartDate"), "")) <> "" Then
        '                Args.ReplacementValue = CStr(CDate(drWorkProd.Item("EstimatedStartDate")).Date)
        '            Else
        '                Args.ReplacementValue = ""
        '            End If

        '        End If
        '        CommonFunctions.Data.DisposeDataReader(drWorkProd)
        '    ElseIf Args.ColumnName.ToUpper = "END DATE" Then
        '        strSQL = "Select EstimatedEndDate  FROM tbl_PM_Module Where ModuleID=" + strWorkProductid.Replace("M:", "").Trim
        '        drWorkProd = Data.GetDataReader(strSQL, True)

        '        If drWorkProd.Read Then
        '            Args.IgnoreActualValue = True
        '            If CStr(General.CheckIsNothing(drWorkProd.Item("EstimatedEndDate"), "")) <> "" Then
        '                Args.ReplacementValue = CStr(CDate(drWorkProd.Item("EstimatedEndDate")).Date)
        '            Else
        '                Args.ReplacementValue = ""
        '            End If

        '        End If
        '        CommonFunctions.Data.DisposeDataReader(drWorkProd)
        '    End If

        '    'Sub Projects
        'ElseIf strWorkProductType = "Sub Projects" Then
        '    strWorkProductid = CStr(Args.DataReader("WorkProductID"))
        '    If Args.ColumnName.ToUpper = "NAME" Then
        '        strSQL = "Select SubProjectName AS WorkProduct FROM tbl_PM_SubProject Where SubProjectID=" + strWorkProductid.Replace("S:", "").Trim
        '        drWorkProd = Data.GetDataReader(strSQL, True)

        '        If drWorkProd.Read Then
        '            Args.IgnoreActualValue = True
        '            Args.ReplacementValue = CType(drWorkProd.Item("WorkProduct"), String)
        '        End If
        '        CommonFunctions.Data.DisposeDataReader(drWorkProd)
        '    ElseIf Args.ColumnName.ToUpper = "START DATE" Then
        '        strSQL = "Select EstimatedStartDate FROM tbl_PM_SubProject Where SubProjectID=" + strWorkProductid.Replace("S:", "").Trim
        '        drWorkProd = Data.GetDataReader(strSQL, True)

        '        If drWorkProd.Read Then
        '            Args.IgnoreActualValue = True
        '            If CStr(General.CheckIsNothing(drWorkProd.Item("EstimatedStartDate"), "")) <> "" Then
        '                Args.ReplacementValue = CStr(CDate(drWorkProd.Item("EstimatedStartDate")).Date)
        '            Else
        '                Args.ReplacementValue = ""
        '            End If

        '        End If
        '        CommonFunctions.Data.DisposeDataReader(drWorkProd)
        '    ElseIf Args.ColumnName.ToUpper = "END DATE" Then
        '        strSQL = "Select EstimatedEndDate  FROM tbl_PM_SubProject Where SubProjectID=" + strWorkProductid.Replace("S:", "").Trim
        '        drWorkProd = Data.GetDataReader(strSQL, True)

        '        If drWorkProd.Read Then
        '            Args.IgnoreActualValue = True
        '            If CStr(General.CheckIsNothing(drWorkProd.Item("EstimatedEndDate"), "")) <> "" Then
        '                Args.ReplacementValue = CStr(CDate(drWorkProd.Item("EstimatedEndDate")).Date)
        '            Else
        '                Args.ReplacementValue = ""
        '            End If
        '        End If
        '        CommonFunctions.Data.DisposeDataReader(drWorkProd)
        '    End If

        '    'MileStones
        'ElseIf strWorkProductType = "Milestones" Then
        '    strWorkProductid = CStr(Args.DataReader("WorkProductID"))
        '    If Args.ColumnName.ToUpper = "NAME" Then
        '        strSQL = "Select Milestone AS WorkProduct FROM tbl_PM_Milestones Where MilestoneID=" + strWorkProductid.Replace("ML:", "").Trim
        '        drWorkProd = Data.GetDataReader(strSQL, True)

        '        If drWorkProd.Read Then
        '            Args.IgnoreActualValue = True
        '            Args.ReplacementValue = CType(drWorkProd.Item("WorkProduct"), String)
        '        End If
        '        CommonFunctions.Data.DisposeDataReader(drWorkProd)
        '    ElseIf Args.ColumnName.ToUpper = "START DATE" Then
        '        strSQL = "Select PlannedCompletiondate FROM tbl_PM_Milestones Where MilestoneID=" + strWorkProductid.Replace("ML:", "").Trim
        '        drWorkProd = Data.GetDataReader(strSQL, True)

        '        If drWorkProd.Read Then
        '            Args.IgnoreActualValue = True
        '            If CStr(General.CheckIsNothing(drWorkProd.Item("PlannedCompletiondate"), "")) <> "" Then
        '                Args.ReplacementValue = CStr(CDate(drWorkProd.Item("PlannedCompletiondate")).Date)
        '            Else
        '                Args.ReplacementValue = ""
        '            End If

        '        End If
        '        CommonFunctions.Data.DisposeDataReader(drWorkProd)
        '    ElseIf Args.ColumnName.ToUpper = "END DATE" Then
        '        strSQL = "Select Actualcompletiondate  FROM tbl_PM_Milestones Where MilestoneID=" + strWorkProductid.Replace("ML:", "").Trim
        '        drWorkProd = Data.GetDataReader(strSQL, True)

        '        If drWorkProd.Read Then
        '            Args.IgnoreActualValue = True
        '            If CStr(General.CheckIsNothing(drWorkProd.Item("Actualcompletiondate"), "")) <> "" Then
        '                Args.ReplacementValue = CStr(CDate(drWorkProd.Item("Actualcompletiondate")).Date)
        '            Else
        '                Args.ReplacementValue = ""
        '            End If

        '        End If
        '        CommonFunctions.Data.DisposeDataReader(drWorkProd)
        '    End If

        '    'Phases
        'ElseIf strWorkProductType = "Phases" Then
        '    strWorkProductid = CStr(Args.DataReader("WorkProductID"))
        '    If Args.ColumnName.ToUpper = "NAME" Then
        '        strSQL = "Select Phase AS WorkProduct FROM tbl_ib_project_phases Where ProjectPhaseID=" + strWorkProductid.Replace("PH:", "").Trim
        '        drWorkProd = Data.GetDataReader(strSQL, True)

        '        If drWorkProd.Read Then
        '            Args.IgnoreActualValue = True
        '            Args.ReplacementValue = CType(drWorkProd.Item("WorkProduct"), String)
        '        End If
        '        CommonFunctions.Data.DisposeDataReader(drWorkProd)
        '    ElseIf Args.ColumnName.ToUpper = "START DATE" Then
        '        strSQL = "Select EstimatedStartDate FROM tbl_ib_project_phases Where ProjectPhaseID=" + strWorkProductid.Replace("PH:", "").Trim
        '        drWorkProd = Data.GetDataReader(strSQL, True)

        '        If drWorkProd.Read Then
        '            Args.IgnoreActualValue = True
        '            If CStr(General.CheckIsNothing(drWorkProd.Item("EstimatedStartDate"), "")) <> "" Then
        '                Args.ReplacementValue = CStr(CDate(drWorkProd.Item("EstimatedStartDate")).Date)
        '            Else
        '                Args.ReplacementValue = ""
        '            End If

        '        End If
        '        CommonFunctions.Data.DisposeDataReader(drWorkProd)
        '    ElseIf Args.ColumnName.ToUpper = "END DATE" Then
        '        strSQL = "Select EstimatedEndDate  FROM tbl_ib_project_phases Where ProjectPhaseID=" + strWorkProductid.Replace("PH:", "").Trim
        '        drWorkProd = Data.GetDataReader(strSQL, True)

        '        If drWorkProd.Read Then
        '            Args.IgnoreActualValue = True
        '            If CStr(General.CheckIsNothing(drWorkProd.Item("EstimatedEndDate"), "")) <> "" Then
        '                Args.ReplacementValue = CStr(CDate(drWorkProd.Item("EstimatedEndDate")).Date)
        '            Else
        '                Args.ReplacementValue = ""
        '            End If

        '        End If
        '        CommonFunctions.Data.DisposeDataReader(drWorkProd)
        '    End If
        'End If
        ''End of comment by RohiniK on 21 Jun 07 --For WeServe RTM change 
    End Sub
End Class

Public Class cProjectRequirements_TraceablityReference_PlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Comment and addition by SuchitraP on 14 Sept 2007
        'If WhizGlobal.ParentTagID <> 0 And WhizGlobal.TagID = 10085 Then
        If WhizGlobal.ParentTagID <> 0 And WhizGlobal.TagID = 3219 Then
            'End of Comment and addition by SuchitraP on 14 Sept 2007
            If Args.DataField.ToUpper = "TRPHASENAME" Then
                Cancel = True
                Dim m_strToken As String
                m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader.Item("ProjectRequirementID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(0, String) + CType(20014, String))
                Args.IgnoreActualValue = True
                'Comment and addition done by SuchitraP on on 13 Sept 2007
                'Args.StringToBeInserted = "<TD Align='Left'><A href='javascript: var objChild= window.open(""../RM/RTM_Req_TRPhase_CommonPage.aspx?ReqTRPhaseID_PK=" & CType(Args.DataReader.Item("ReqTRPhaseID"), String) & "&ProjectRequirementID=" & CType(Args.DataReader.Item("ProjectRequirementID"), String) & "&ProjectID=" & CType(Args.DataReader.Item("ProjectID"), String) & "&MasterTagID=10059&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1" & ""","""",""left="" + (window.screen.width-800)/2 + "",top="" + (window.screen.height-400)/2 + "",width=600,height=400"");'>" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TRPhaseName").ToString, ""), "") + "</A>"
                Args.StringToBeInserted = "<TD Align='Left'><A href='javascript: var objChild= window.open(""../RM/RTM_Req_TRPhase_CommonPage.aspx?ReqTRPhaseID_PK=" & CType(Args.DataReader.Item("ReqTRPhaseID"), String) & "&ProjectRequirementID=" & CType(Args.DataReader.Item("ProjectRequirementID"), String) & "&ProjectID=" & CType(Args.DataReader.Item("ProjectID"), String) & "&MasterTagID=3840&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1" & ""","""",""left="" + (window.screen.width-800)/2 + "",top="" + (window.screen.height-400)/2 + "",width=600,height=400"");'>" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TRPhaseName").ToString, ""), "") + "</A>"
                'End of Comment and addition done by SuchitraP on on 13 Sept 2007
            End If
        End If

    End Sub
End Class
