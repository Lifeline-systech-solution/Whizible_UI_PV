Imports CommonEngines.General.cEventHandlers
Public Class HR_ResourceSkill_Addition_CommonList
    Inherits CommonList

    Private strEmployeeId As String
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
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "HR_ResourceSkill_Addition_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        'Put user code to initialize the page here
        Dim strSkillIDs As String
        strEmployeeId = Request.QueryString("EmployeeId")
        If strEmployeeId Is Nothing OrElse strEmployeeId = "" Then
            strEmployeeId = Request.Form("hidEmployeeId")
        End If
        'm_strOpenerTagID = Request.QueryString("OpenerTagID")
        'If m_strOpenerTagID Is Nothing OrElse m_strOpenerTagID = "" Then
        '    m_strOpenerTagID = Request.Form("hidOpenerTagID")
        'End If


        If HttpContext.Current.Request.QueryString("Operation").ToUpper = "SAVE" Then
            strSkillIDs = HttpContext.Current.Request.Form("cboskill")

            Dim arrSkillIDs() As String
            Dim iterator As Integer = 0
            arrSkillIDs = strSkillIDs.Split(","c)

            While iterator < arrSkillIDs.Length
                If arrSkillIDs(iterator) <> "" Then
                    Call Save_Rec(arrSkillIDs(iterator))
                End If
                iterator += 1
            End While
        End If

        MyBase.Page_Load(sender, e)
    End Sub
#End Region

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New HR_ResourceSkill_Addition_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function


    Public Sub Save_Rec(ByVal strSkillId As String)

        Dim strSkill As String
        Dim dr As IDataReader
        Dim strSQL As String
        Dim strSQLins As String
        Dim strUserName As String = CStr(HttpContext.Current.Session("strUserName"))
        strSQL = "usp_ins_tbl_Employe_OfferedSkill " & strEmployeeId & "," & strSkillId & ",'" & strUserName & "'"
        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

    End Sub

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strScript As New System.Text.StringBuilder
        CommonFunctions.General.WriteHTML("<Input type=hidden name=hidEmployeeId id=hidEmployeeId value =" + strEmployeeId + " >")
      
        If HttpContext.Current.Request.QueryString("Operation") = "SAVE" Then
            strScript.Append("<Script language=javascript>" + vbCrLf)
            strScript.Append("strParentPage = new String();" + vbCrLf)
            strScript.Append(" if (window.opener != null) " + vbCrLf)
            strScript.Append("{" + vbCrLf)
            strScript.Append("var objTokenPK = window.opener.document.getElementById('PKToken');" + vbCrLf)
            strScript.Append("var objIDPK = window.opener.document.getElementById('EmployeeID_PK');" + vbCrLf)
            strScript.Append("strParentPage = '../General/CommonPage.aspx?';" + vbCrLf)
            strScript.Append("strParentPage = strParentPage + 'EmployeeID_PK='+objIDPK.value+'&PKToken='+objTokenPK.value;" + vbCrLf)
            strScript.Append("strParentPage = strParentPage + '&MasterTagID=3873&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1';" + vbCrLf)
            strScript.Append("refreshParent('frmCommonPage', 'CommonPage.aspx', strParentPage)" + vbCrLf)
            strScript.Append("window.close();" + vbCrLf)
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


Public Class HR_ResourceSkill_Addition_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Dim strSkillComboHTML As String



    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)

        strSkillComboHTML = CommonFunction.HTMLControls.DrawComboBox("cboSkill", "usp_Sel_tbl_PM_Tools", 200, , , True, True)

    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.DataReader("Skill").ToString <> "New Row" Then
            Select Case Args.ColumnName.ToUpper
                Case "SKILL"
                    Cancel = True
                    Args.StringToBeInserted = "<td align='center'>" + strSkillComboHTML + "<IMG src='../../Images/Star.gif' border=0> " + "</td>"
                    'Case "IMAGE1"
                    '    Cancel = True
                    '    Args.StringToBeInserted = "<TD   align='Center' ><A href='Javascript:NewRec_OnClick()'><Img border=0 src='../../Images/addNewItem.gif'></A>"
            End Select
        End If
    End Sub


    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.DataReader("Skill").ToString = "New Row" Then
            Cancel = True
        End If
    End Sub
End Class


