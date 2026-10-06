Imports CommonEngines.General.cEventHandlers
Public Class HR_PipeLine_Addition_CommonList
    Inherits CommonList

    Private strRoleComboHTML As String
    Private strSkillComboHTML As String
    Private strTotalFteHTML As String
    Private strOpportunityId As String
    Private m_strOpenerTagID As String



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
        MyBase.strListPage = "HR_PipeLine_Addition_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        'Put user code to initialize the page here

        Dim strRoleIDs As String
        Dim strSkillIDs As String
        Dim FTEIDs As String


        strOpportunityId = Request.QueryString("OpportunityID")
        If strOpportunityId Is Nothing OrElse strOpportunityId = "" Then
            strOpportunityId = Request.Form("hidOpportunityID")
        End If
        m_strOpenerTagID = Request.QueryString("OpenerTagID")
        If m_strOpenerTagID Is Nothing OrElse m_strOpenerTagID = "" Then
            m_strOpenerTagID = Request.Form("hidOpenerTagID")
        End If


        If HttpContext.Current.Request.QueryString("Operation").ToUpper = "SAVE" Then
            'PrashantD
            strRoleIDs = HttpContext.Current.Request.Form("cboRole")
            strSkillIDs = HttpContext.Current.Request.Form("cboskill")
            FTEIDs = HttpContext.Current.Request.Form("txtFTE")
            'PrashantD
            Dim arrRoleIDs() As String
            Dim arrSkillIDs() As String
            Dim arrFTEIDs() As String
            Dim iterator As Integer = 0
            arrRoleIDs = strRoleIDs.Split(","c)
            arrSkillIDs = strSkillIDs.Split(","c)
            arrFTEIDs = FTEIDs.Split(","c)
            'End of PrashantD

            While iterator < arrRoleIDs.Length
                If arrRoleIDs(iterator) <> "" Then
                    Call Save_Rec(arrRoleIDs(iterator), arrSkillIDs(iterator), arrFTEIDs(iterator))
                End If
                iterator += 1
            End While

            'End of PrashantD


        End If

        MyBase.Page_Load(sender, e)
    End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New HR_PipeLine_Addition_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

    Public Sub Save_Rec(ByVal strRoleID As String, ByVal strToolID As String, ByVal strTotalFTE As String)
        Dim dr As IDataReader
        Dim strSQL As String
        Dim strSQLins As String
        Dim StrCreatedBy As String
        Dim strUserName As String = CStr(HttpContext.Current.Session("strUserName"))
        strSQLins = "usp_Ins_tbl_RM_Pipeline " & strOpportunityId & "," & strRoleID & "," & strToolID & "," & strTotalFTE & ",'" & CommonFunction.General.BuildQueryString(strUserName) + "'"
        CommonFunction.Data.InsertOrUpdateData(strSQLins, MyBase.UseSQL)
    End Sub

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strScript As New System.Text.StringBuilder

        CommonFunctions.General.WriteHTML("<Input type=hidden name=hidOpportunityID id=hidOpportunityID value =" + strOpportunityId + " >")
        CommonFunctions.General.WriteHTML("<Input type=hidden name=hidOpenerTagID id=hidOpenerTagID value =" + m_strOpenerTagID + " >")
        If HttpContext.Current.Request.QueryString("Operation").ToUpper = "SAVE" Then

            strScript.Append("<Script language=javascript>" + vbCrLf)

            strScript.Append("if (window.opener != null)" + vbCrLf)
            strScript.Append("{" + vbCrLf)
            strScript.Append("if (window.opener.location.href.match(""HR_PipelineGraphicalView.aspx"") == ""HR_PipelineGraphicalView.aspx"")")
            strScript.Append("{" + vbCrLf)
            strScript.Append("window.opener.location.href='HR_PipelineGraphicalView.aspx?For=ENTRY&OpportunityID=" + strOpportunityId + "';" + vbCrLf)
            strScript.Append("window.close();" + vbCrLf)
            strScript.Append("}" + vbCrLf)

            strScript.Append("else if (window.opener != null) " + vbCrLf)
            strScript.Append("{" + vbCrLf)
            strScript.Append("var strParentPage = new String();" + vbCrLf)
            strScript.Append("var objTokenPK = window.opener.document.getElementById('PKToken');" + vbCrLf)
            strScript.Append("var objIDPK = window.opener.document.getElementById('OpportunityID_PK');" + vbCrLf)
            strScript.Append("strParentPage = '../HR/HR_Opportunity_CommonPage.aspx?';" + vbCrLf)
            strScript.Append("strParentPage = strParentPage + 'OpportunityID_PK='+objIDPK.value+'&PKToken='+objTokenPK.value;" + vbCrLf)
            strScript.Append("strParentPage = strParentPage + '&MasterTagID=" + m_strOpenerTagID + "&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1';" + vbCrLf)
            strScript.Append("refreshParent('frmCommonPage', 'HR_Opportunity_CommonPage.aspx', strParentPage)" + vbCrLf)
            strScript.Append("window.close();" + vbCrLf)
            strScript.Append("}" + vbCrLf)
            strScript.Append("}" + vbCrLf)
            strScript.Append("</Script>" + vbCrLf)
            HttpContext.Current.Response.Write(strScript.ToString)


        End If
    End Function

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        Args.HTMLLegend = ""
        Cancel = True
    End Sub
End Class

Public Class HR_PipeLine_Addition_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Dim strRoleComboHTML As String
    Dim strSkillComboHTML As String
    Dim strTotalFteHTML As String
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)

        strRoleComboHTML = CommonFunction.HTMLControls.DrawComboBox("cboRole", "Select RoleID, RoleDescription  from tbl_PM_Role Where IsUserGroup = 0 AND RoleID <> 23 AND [Level] = 3 order by RoleDescription ", 200, , , True, True)
        strSkillComboHTML = CommonFunction.HTMLControls.DrawComboBox("cboSkill", "usp_Sel_tbl_PM_Tools", 200, , , True, True)
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        strTotalFteHTML = CommonFunction.HTMLControls.DrawTextBox("txtFTE", "txtFTE", , 60, 6, , "Right", , , , , , , True, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15

    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strScript As New System.Text.StringBuilder
        If Args.DataReader("RoleDescription").ToString <> "New Row" Then
            Select Case Args.ColumnName.ToUpper
                Case "ROLE"
                    Cancel = True
                    Args.StringToBeInserted = "<td align='center'>" + strRoleComboHTML + "<IMG src='../../Images/Star.gif' border=0> " + "</td>"
                Case "SKILL"
                    Cancel = True
                    Args.StringToBeInserted = "<td align='center'>" + strSkillComboHTML + "<IMG src='../../Images/Star.gif' border=0> " + "</td>"
                Case "TOTAL FTE"
                    Cancel = True
                    Args.StringToBeInserted = "<td align='center'>" + strTotalFteHTML + "<IMG src='../../Images/Star.gif' border=0> " + "</td>"
                    'Case "IMAGE1"
                    '    Cancel = True
                    '    Args.StringToBeInserted = "<TD   align='Center' ><A href='Javascript:NewRec_OnClick()'><Img border=0 src='../../Images/addNewItem.gif'></A>"
            End Select
        End If
    End Sub

    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.DataReader("RoleDescription").ToString = "New Row" Then
            Cancel = True
        End If
    End Sub
End Class




