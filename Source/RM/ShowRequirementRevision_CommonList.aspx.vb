Imports CommonEngines.General.cEventHandlers
Public Class ShowRequirementRevision_CommonList
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
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "ShowRequirementRevision_CommonList.aspx"
        MyBase.strFormPage = "ShowRequirementRevision_CommonPage.aspx"
        'MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New Pending_Approval(MyBase.m_objGlobal)
    End Function
    Public Class Pending_Approval
        Inherits CommonEngine.CommonList.cPlotGrid

        Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            Call MyBase.New(WhizGlobal)
        End Sub
        Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
            Dim StrBlank As String = ""
            Dim strStatus As String
            Dim StrPending As String = "Pending"
            Dim StrApproved As String = "Approved"
            Dim StrRejected As String = "Rejected"

            strStatus = CType(Args.DataReader.Item("Status"), String)

            If Args.DataField.ToString() = "Status" Then

                If strStatus = "0" Then
                    Cancel = True
                    Args.IgnoreActualValue = True
                    Args.StringToBeInserted = "<td align='left' >" + StrPending + "</TD>"
                ElseIf strStatus = "1" Then
                    Cancel = True
                    Args.IgnoreActualValue = True
                    Args.StringToBeInserted = "<td align='left' >" + StrApproved + "</TD>"
                ElseIf strStatus = "2" Then
                    Cancel = True
                    Args.IgnoreActualValue = True
                    Args.StringToBeInserted = "<td align='left' >" + StrRejected + "</TD>"
                ElseIf strStatus = "3" Then
                    Cancel = True
                    Args.IgnoreActualValue = True
                    Args.StringToBeInserted = "<td align='left' >" + StrApproved + "</TD>"
                End If
            End If
            If strStatus = "0" Then
                If Args.DataField.ToString() = "EmployeeName" Then
                    Cancel = True
                    Args.StringToBeInserted = "<TD><table width= 20% cellpadding=1  cellspacing=1><tr><td  " & StrBlank & " width=100 height=12 ></td></tr></table></TD>"
                End If
            End If
        End Sub
    End Class
    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
    End Function
    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)
        Dim strProjectRequirementID As String
        Dim strbuildstring As String
        Dim strSQL As String
        Dim strRequirementTitle As String
        Dim drRequirement As IDataReader

        strProjectRequirementID = CType(HttpContext.Current.Request.QueryString("ProjectRequirementID"), String)

        'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
        'strSQL = "Select ReqTitle from tbl_RM_ProjectRequirements Where ProjectRequirementID=" + strProjectRequirementID
        strSQL = "usp_sel_tbl_RM_ProjectRequirements_ReqTitle " + strProjectRequirementID
        'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
        drRequirement = CommonFunctions.Data.GetDataReader(strSQL, True)
        If drRequirement.Read Then
            strRequirementTitle = CStr(drRequirement.Item("ReqTitle"))
            strbuildstring = "Requirement Title : " + strRequirementTitle
            Args.RightPageCaption = strbuildstring
        End If
        CommonFunctions.Data.DisposeDataReader(drRequirement)
    End Sub

  
End Class
