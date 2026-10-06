Imports CommonEngines.General.cEventHandlers
Imports CommonFunctions
Imports Whizible
Public Class DocumentPrivillages_CommonList
    Inherits CommonList
    Public m_StrUnCheckMasterTagID1 As String = ""
    Protected m_strAction As String

    'Page is inherited by NitinC on 14 April 2011 for WhizibleSEM 10.0
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
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "DocumentPrivillages_CommonList.aspx"
        MyBase.strFormPage = "DocumentPrivillages_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        m_strAction = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"), "")
        If m_strAction.ToUpper = "SAVE" Then
            SaveDocumentPrevilages()
        End If
        MyBase.Page_Load(sender, e)
    End Sub
    'Public Sub PageInit() 


    'End Sub
    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

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

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal global As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub


    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cDocumentPrivillages_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function


    Public Sub SaveDocumentPrevilages()
     
        Dim strDocumentIds As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkSelectAccess"), "")
        'var objSelect = GetObjectReference('frmRecruiterAssignment','chkSelect',true);  
        Dim strSQL As String 
        Dim intRowCount As Integer = 0
        Dim strRoleID As String = ""
        Dim Isallowed As Integer
        Dim strRecruiterIDValues As String = ""
        Dim strAllSelectedEntityIDs As String = ""
        'Dim regDate As Date = Date.Now()
        'Dim strDate As String = regDate.ToString("ddMMMyyyy")

        Dim strSQLQuery As New System.Text.StringBuilder

        If Not HttpContext.Current.Request.Form("HDN_TXT_UNCHEKED") Is Nothing Then
            m_StrUnCheckMasterTagID1 = HttpContext.Current.Request.Form("HDN_TXT_UNCHEKED").ToString()
            Dim LEN As Integer = m_StrUnCheckMasterTagID1.Length

        End If
        'strAllSelectedEntityIDs = (HttpContext.Current.Request.Form("chkProjectSelect").ToString)
        '  strAllSelectedEntityIDs = (HttpContext.Current.Request.Form("chkSelectAccess1").ToString)

        '*************************************************************
        If strDocumentIds <> "" Then
            Dim strArray() As String = strDocumentIds.Split(",")

            For intRowCount = 0 To strArray.Length - 1
                strRoleID = HttpContext.Current.Request.Form("HDN_TXT_UNCHEKED" & strArray(intRowCount))
                Isallowed = HttpContext.Current.Request.Form("chkSelectAccess1_" & strArray(intRowCount))

                strSQLQuery = New StringBuilder()
                strSQLQuery.Append("Exec usp_InsertDocumentPrevilages ")
                strSQLQuery.Append(strArray(intRowCount))
                strSQLQuery.Append(strRoleID & ",1") 'asdfsdf

                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)

            Next
        End If
        If m_StrUnCheckMasterTagID1 <> "" Then
            Dim strUnchkd() As String
            strUnchkd = m_StrUnCheckMasterTagID1.Split(",")
            Dim valueofchk As String = ""
            For intRowCount = 0 To strUnchkd.Length - 1
                strRoleID = HttpContext.Current.Request.Form("cboRole" & strUnchkd(intRowCount))
                Isallowed = HttpContext.Current.Request.Form("chkSelectAccess1_" & strUnchkd(intRowCount))
                valueofchk = strUnchkd(intRowCount)
                If (valueofchk <> "0") Then
                    strSQLQuery = New StringBuilder()
                    strSQLQuery.Append("Exec usp_InsertDocumentPrevilages ")
                    strSQLQuery.Append(strUnchkd(intRowCount))
                    CommonFunctions.Data.InsertOrUpdateData(strSQLQuery.ToString, MyBase.UseSQL)
                End If
            Next
        End If
        '****************************************************************



        'strSQL = "usp_InsertDocumentPrevilages" & intDocumentId & "," & intRoleId & "," & boolIsAllowed & "," & intAuthorizedBy & ""
        'CommonFunction.Data.InsertOrUpdateData(strSQL, True)
    End Sub


End Class




Public Class cDocumentPrivillages_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid 
    Public m_StrUnCheckMasterTagID As String = ""
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

        Select Case WhizGlobal.TagID
            Case 20174
                Dim RoleDiscription As String
                Dim RoleID As Integer
                Dim ChkStatus As Integer
                'DocumentID = Args.DataReader("DocumentId")
                RoleID = CommonFunction.Data.CheckIsDBNull(Args.DataReader("RoleId"), 0)
                RoleDiscription = CommonFunction.Data.CheckIsDBNull(Args.DataReader("RoleDescription"), 0)
                ' ChkStatus = CommonFunction.Data.CheckIsDBNull(Args.DataReader("IsAllowed"), 0)
                If Args.ColumnName = "Role Description" Then
                    Cancel = True
                    ' Args.StringToBeInserted = "<TD lign=left>" + CommonFunctions.HTMLControls.DrawTextBox("cboRole" & Args.DataReader("RoleId").ToString, Args.DataReader("RoleId").ToString, , 300, , RoleDiscription, , , True, , , , , True) + "</TD>" '''"usp_GetAllRoles", 170, RoleID, " ", True, True
                    Args.StringToBeInserted = "<TD lign=left><Label id=cboRole>" + Args.DataReader("RoleDescription").ToString + "</Label></TD>"

                End If
                If Args.ColumnName = "IsAllowedToTimeSheetExe" Then

                    Cancel = True

                    '----------------------------------------------------------------------------
                    If Not HttpContext.Current.Request.Form("HDN_TXT_UNCHEKED") Is Nothing Then
                        m_StrUnCheckMasterTagID = HttpContext.Current.Request.Form("HDN_TXT_UNCHEKED").ToString()
                    End If

                    '----------------------------------------------------------------------------
                    ChkStatus = CommonFunction.Data.CheckIsDBNull(Args.DataReader("IsAllowedToTimeSheetExe"), 0)
                    If (ChkStatus = -1) Then
                        'Shamkant'
                        ' Args.StringToBeInserted = "<td  align=center><Input type=checkbox name='chkSelectAccess' checked='yes' id='chkSelectAccess_" + Args.DataReader("RoleId").ToString + "' class='clsCheckBox' value=" + Args.DataReader("RoleId").ToString + " >"
                        'Args.StringToBeInserted = "<td  align=center><a href='JavaScript:Section_Acess(RoleID)' title=ACESS  " + Args.DataReader("RoleId").ToString + " >Access</a></td>"
                        Args.StringToBeInserted = "<td  align=center><a href='JavaScript:Section_Acess(" + Args.DataReader("RoleId").ToString + ")' title=ACESS  " + Args.DataReader("RoleId").ToString + " >Access</a></td>"


                        'Shamkant'
                        'Args.StringToBeInserted = "<td  align=center>"
                        'Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkSelectAccess1" & Args.DataReader("DocumentId"), "chkSelectAccess1" & Args.DataReader("DocumentId"), , True, Args.DataReader("DocumentId").ToString, , " ", True, ) + "</td>"
                        'Args.StringToBeInserted &= "</TD>"
                        ' CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("HDN_TXT_UNCHEKED", "HDN_TXT_UNCHEKED", , , , m_StrUnCheckMasterTagID, , , , , , True, , True, EnableHTMLEncode:=True))
                    Else
                        'Shamkant'
                        Args.StringToBeInserted = "<td  align=center><a href='JavaScript:Section_Acess(" + Args.DataReader("RoleId").ToString + ")' title=ACESS  " + Args.DataReader("RoleId").ToString + " >Access</a></td>"
                        ' Args.StringToBeInserted = "<td  align=center><Input type=checkbox name='chkSelectAccess' id='chkSelectAccess_" + Args.DataReader("RoleId").ToString + "' class='clsCheckBox' value=" + Args.DataReader("RoleId").ToString + " >"
                        'Shamkant'
                        'Args.StringToBeInserted &= "</TD>"
                        'Args.StringToBeInserted = "<td  align=center>"
                        'Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkSelectAccess1" & Args.DataReader("DocumentId"), "chkSelectAccess1" & Args.DataReader("DocumentId"), , , Args.DataReader("DocumentId").ToString, , " ", True, ) + "</td>"
                        'Args.StringToBeInserted &= "</TD>"  
                        'Shamkant'
                        'Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawTextBox("HDN_TXT_UNCHEKED", "HDN_TXT_UNCHEKED", , , , , , , , , , True, , True, EnableHTMLEncode:=True)
                        ' Args.StringToBeInserted &= "</TD>"
                        'Shamkant'
                    End If


                End If


        End Select


    End Sub

   

End Class
