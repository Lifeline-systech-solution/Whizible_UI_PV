Imports CommonEngines.General.cEventHandlers
Public Class CorporateLevelStatusFlowConfiguration_CommonList
    Inherits CommonList



#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object
    'Added By Usha Pandit On 01.04.2021 For two checkboxes getting checked
    Protected Shared cntStatus As Integer = 0
    'End Of Added By Usha Pandit On 01.04.2021 For two checkboxes getting checked
    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "CorporateLevelStatusFlowConfiguration_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
        'Added By Usha Pandit On 01.04.2021 For two checkboxes getting checked
        cntStatus = 0
        'End Of Added By Usha Pandit On 01.04.2021 For two checkboxes getting checked
    End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New CorporateLevelStatusFlowConfiguration_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New CorporateLevelStatusFlowConfiguration_CommonListCLSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strIssueTypeFromStatusToStatusList, strDelteQuery, strTypeID, strIssueType, strFromStatus, strToStatus, strSql As String
        Dim icount As Integer
        strDelteQuery = ""
        strIssueTypeFromStatusToStatusList = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), "")

        strTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtIssueTypeID"), "")
        strIssueType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtIssueType"), "")

        Dim strArrayITFT As String()
        Dim strScript As String = ""
        Dim StrActualValue() As String
        ''Dim StrProjectIDIssueType() As String


        If strIssueType <> "" Then
            strDelteQuery = " usp_Del_tbl_IB_CorporateLevelStatusFlow '" & strIssueType & "'"
            CommonFunction.Data.InsertOrUpdateData(strDelteQuery, MyBase.UseSQL)
        End If
        If strIssueTypeFromStatusToStatusList <> "" Then
            strArrayITFT = strIssueTypeFromStatusToStatusList.Split(","c)

            For icount = 0 To strArrayITFT.Length() - 1
                StrActualValue = strArrayITFT(icount).Split("|"c)
                'strProjectID = StrActualValue(0)
                strIssueType = StrActualValue(0)
                strIssueType = strIssueType.Replace("'", "''")

                strFromStatus = StrActualValue(1)
                strFromStatus = strFromStatus.Replace("'", "''")

                strToStatus = StrActualValue(2)
                strToStatus = strToStatus.Replace("'", "''")

                If strIssueType <> "" And strFromStatus <> "" And strToStatus <> "" Then
                    strSql = "usp_Ins_tbl_IB_CorporateLevelStatusFlow '" + strIssueType + "','" + strFromStatus + "','" + strToStatus + "'"
                    CommonFunctions.Data.InsertOrUpdateData(strSql, MyBase.UseSQL)
                End If
                'strProjectID = ""
                strIssueType = ""
                strFromStatus = ""
                strToStatus = ""
            Next
        End If
        strScript = vbCrLf + "<Script language=javascript>"
        strScript += vbCrLf + " if(!window.opener.closed) { "
        strScript += vbCrLf + "window.opener.document.forms[0].action='../General/CommonList.aspx?MasterTagID=1025&FromWhere=SM';"
        strScript += vbCrLf + "window.opener.document.forms[0].submit(); } "
        strScript += vbCrLf + "</Script>"
        CommonFunction.General.WriteHTML(strScript)

        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function


    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    'End Sub


    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)
        Dim strIssueType As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Type"), "")
        Dim IssueTypeID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TypeID"), "")

        ''Added By Usha Pandit On 21.02.2020 For getting correct Issue Type 
        
        If (IssueTypeID <> "") Then
            strIssueType = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_tbl_IB_Type_Type " + IssueTypeID, True), "")

        End If
        
        ''End Of Added By Usha Pandit On 21.02.2020 For getting correct Issue Type 

        Args.RightPageCaption = "Issue Type : " + strIssueType


        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunction.HTMLControls.DrawTextBox("txtIssueType", "txtIssueType", "clsTextBox", 150, 20, strIssueType, "left", , False, False, , True, , False, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtIssueTypeID", "txtIssueTypeID", "clsTextBox", 150, 20, IssueTypeID, "left", , False, False, , True, , False, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
    End Sub
    Class CorporateLevelStatusFlowConfiguration_CommonListCLSQL
        Inherits CommonEngine.CommonList.cCLSQL
        Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            Call MyBase.New(WhizGlobal)
        End Sub

        Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
            ''Added By VarunA on 24-May-2007 For Service Level Aggrement
            Dim strIssueType As String = ""
            Dim strProjectID As String = ""

            strIssueType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Type"), "")
            ''' strProjectID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID"), "")


            GetPageSpecificFilters += " AND ( IssueType ='" + strIssueType + "' )"
            GetPageSpecificFilters += " AND ( [Type] ='" + strIssueType + " ')"

            'GetPageSpecificFilters += " AND (B.ProjectID =" + strProjectID + " )"
            'GetPageSpecificFilters += "AND ( B.[Type] =" + strIssueType + " )"

        End Function
        Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
            MyBase.Initialize_GridSQL(Cancel, Args, WhizGlobal)
            '''Dim strSubTypeID As String = ""
            '''Dim strselected As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShowAllOrSelected"), "")
            '''If Not HttpContext.Current.Request.QueryString("SubRequestTypeID") Is Nothing Then
            '''    strSubTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubRequestTypeID"), "")
            '''ElseIf Not HttpContext.Current.Request.Form("txtSubTypeID") Is Nothing Then
            '''    strSubTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSubTypeID"), "")
            '''End If
            '''If strselected = "1" Then
            '''    Args.GridSQL = "USP_Sel_ShowSelectedStatus '" & strSubTypeID & "'"
            '''End If
            Dim IssueTypeID As String = ""
            IssueTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TypeID"), "0")
            Args.GridSQL = "usp_sel_for_CorporateStatusFlow " + IssueTypeID
        End Sub
    End Class
    Public Class CorporateLevelStatusFlowConfiguration_CommonListPlotGrid
        Inherits CommonEngine.CommonList.cPlotGrid
        Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            Call MyBase.New(WhizGlobal)
        End Sub

        Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
            If Args.ColumnName.ToUpper = "DELETE" Then
                Args.ColumnName = "Select"
            End If
        End Sub

        Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
            Dim strIssueType As String = ""
            strIssueType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Type"), "")
            ''Added By Usha Pandit On 21.02.2020 For getting correct Issue Type 
            
            Dim IssueTypeID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TypeID"), "")
            If (IssueTypeID <> "") Then
                strIssueType = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_tbl_IB_Type_Type " + IssueTypeID, True), "")
            End If
            
            ''End Of Added By Usha Pandit On 21.02.2020 For getting correct Issue Type 
            Dim strSelected As String = ""
            Dim FromStatus As String = ""
            Dim ToStatus As String = ""
            If Args.ColumnName.ToUpper = "SELECT" Then
                Cancel = True
                strSelected = Args.DataReader("Selected").ToString
                FromStatus = Args.DataReader("FromStatus").ToString
                ToStatus = Args.DataReader("ToStatus").ToString
                'Commented And Added By Usha Pandit On 01.04.2021 For two checkboxes getting checked
                'If FromStatus = ToStatus Then
                '    Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' disabled name='chkDelete' id='chkDelete' class='clsCheckBox' value=""" + strIssueType + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """></td>"
                'ElseIf strSelected = 1 Then
                '    Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' checked name='chkDelete' id='chkDelete' class='clsCheckBox' value=""" + strIssueType + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """></td>"
                'Else
                '    Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' name='chkDelete' id='chkDelete' class='clsCheckBox' value=""" + strIssueType + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """></td>"
                'End If
                cntStatus = cntStatus + 1
                If FromStatus = ToStatus Then
                    Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' disabled name='chkDelete' id='chkDelete" + cntStatus.ToString() + "' class='clsCheckBox' value=""" + strIssueType + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """></td>"
                ElseIf strSelected = 1 Then
                    Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' checked name='chkDelete' id='chkDelete" + cntStatus.ToString() + "' class='clsCheckBox' value=""" + strIssueType + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """></td>"
                Else
                    Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' name='chkDelete' id='chkDelete" + cntStatus.ToString() + "' class='clsCheckBox' value=""" + strIssueType + "|" + Args.DataReader("FromStatus").ToString + "|" + Args.DataReader("ToStatus").ToString + """></td>"
                End If
                'End Of Added By Usha Pandit On 01.04.2021 For two checkboxes getting checked
            End If

        End Sub

    End Class
End Class

