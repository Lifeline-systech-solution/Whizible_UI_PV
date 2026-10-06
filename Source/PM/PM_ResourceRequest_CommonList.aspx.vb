Imports CommonEngines.General.cEventHandlers
Public Class PM_ResourceRequest_CommonList
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
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "PM_ResourceRequest_CommonList.aspx"
        MyBase.strFormPage = "../General/CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)


    End Sub
#End Region
    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        PlotHeader()
    End Function
    Public Sub PlotHeader()

        CommonFunctions.General.WriteHTML("<TABLE cellpadding=0 cellspacing=0 class=clsTableNavLinks width='100%'>")
        ' CommonFunctions.General.WriteHTML("<TR class=clsTRNavLinks valign=middle>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRGroupHeader valign=middle>")
        CommonFunctions.General.WriteHTML("<TD noWrap>")
        If MyBase.m_objGlobal.TagID = CommonFunction.Constants.APP_TAG_RESOURCEREQUEST Then
            CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='Requested Requests' href='javascript:ItemTab_OnClick(""Requested"")' >Resource Allocation</a>")
        Else
            CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<a  Title='Requested Requests' href='javascript:ItemTab_OnClick(""Requested"")' >Resource Allocation</a>")
        End If
        If MyBase.m_objGlobal.TagID = CommonFunction.Constants.APP_TAG_EXTENDRESOURCEREQUEST Then
            CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='Extend Booking' href='javascript:ItemTab_OnClick(""Extend"")'>Extend Requests</a>")
        Else
            CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='Extend Booking' href='javascript:ItemTab_OnClick(""Extend"")'>Extend Requests</a>")
        End If

        If MyBase.m_objGlobal.TagID = CommonFunction.Constants.APP_TAG_PERPONERESOURCEREQUEST Then
            CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='Prepone Release' href='javascript:ItemTab_OnClick(""Prepone"")' >Prepone Requests</a>")
        Else
            CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='Prepone Release' href='javascript:ItemTab_OnClick(""Prepone"")' >Prepone Requests</a>")
        End If

        If MyBase.m_objGlobal.TagID = CommonFunction.Constants.APP_TAG_CHANGEALLOCATIONREQUEST Then
            CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='Change Allocation' href='javascript:ItemTab_OnClick(""Change"")' >Change Allocation</a>")
        Else
            CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='Change Allocation' href='javascript:ItemTab_OnClick(""Change"")' >Change Allocation</a>")
        End If

        CommonFunctions.General.WriteHTML("</TD> </TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")
    End Sub


    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New PM_ResourceRequest_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function
    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        Args.HTMLLegend = " "
        Cancel = True
    End Sub
End Class
Public Class PM_ResourceRequest_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Select Case WhizGlobal.TagID
            Case CommonFunction.Constants.APP_TAG_RESOURCEREQUEST
                If Args.ColumnName.ToUpper = "DELETE" Then
                    Cancel = True
                    ' Added By JayavantK on 19-Jun-2004 - Start
                ElseIf Args.DataField.ToUpper = "STATUS" Then
                    Dim strRequestStatus As String = ""
                    Dim lngRequestID As Long = 0
                    Dim strQuery As String = ""

                    Args.IgnoreActualValue = True
                    lngRequestID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RequestID"), "0"), Long)
                    strQuery = "Exec usp_Sel_tbl_PM_ResourceRequest_GetStatusString " & lngRequestID.ToString()
                    strRequestStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                    Args.ReplacementValue = strRequestStatus
                    ' Added By JayavantK on 19-Jun-2004 - End
                End If
            Case CommonFunction.Constants.APP_TAG_EXTENDRESOURCEREQUEST
                Dim intprojectemployeeroleid As Integer
                Dim m_strToken As String
                Dim strRequestStatus As String = ""
                Dim lngRequestID As String = ""
                Dim strQuery As String = ""
                lngRequestID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RequestID"), "0"), String)
                strQuery = "Exec usp_Sel_tbl_PM_ResourceRequest_GetStatusString_ExtendRequest " & lngRequestID.ToString()
                strRequestStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                m_strToken = CommonFunctions.Security.Token.GetToken(HttpContext.Current.Request.QueryString("RequestID") + HttpContext.Current.Session("intUserID").ToString + "0" + "3909")
                'CommonFunctions.Security.Token.GetToken(HttpContext.Current.Request.QueryString("CustomerAddressID") + HttpContext.Current.Session("intUserID").ToString + "0" + "2114")
                Dim drProjectEmployee As IDataReader
                drProjectEmployee = CommonFunction.Data.GetDataReader("usp_sel_PROJECTEMPLOYEEROLEID " + CType(HttpContext.Current.Session("intProjectID"), String) + "," + lngRequestID, True)

                If drProjectEmployee.Read Then
                    intprojectemployeeroleid = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(drProjectEmployee("PROJECTEMPLOYEEROLEID"), "0"), "0"), Integer)
                End If
                CommonFunction.Data.DisposeDataReader(drProjectEmployee)
                If Args.ColumnName.ToUpper = "DELETE" Then
                    Cancel = True

                ElseIf Args.DataField.ToUpper = "STATUS" Then

                    Args.IgnoreActualValue = True

                    Args.ReplacementValue = strRequestStatus

                ElseIf Args.DataField.ToUpper = "REQUESTID" Then

                    'Args.IgnoreActualValue = True

                    If strRequestStatus.ToUpper = "READY FOR ASSIGNMENT" Then
                        Args.IgnoreActualValue = True
                        Args.ReplacementValue = "<A href=""JavaScript:Ready_OnClick('" + lngRequestID + "' ,'" + m_strToken + "')"">" + lngRequestID + "</A>"
                    End If
                    If strRequestStatus.ToUpper = "SUBMITTED" Then
                        Args.IgnoreActualValue = True
                        Args.ReplacementValue = "<A href=""JavaScript:Extend_OnClick('" + intprojectemployeeroleid.ToString + "' ,'" + m_strToken + "')"">" + lngRequestID + "</A>"
                    End If
                    If strRequestStatus.ToUpper = "ASSIGNED" Then
                        Args.EnableLink = False
                    End If
                    If strRequestStatus.ToUpper = "DECLINED" Then
                        Args.EnableLink = False
                    End If
                End If
            Case CommonFunction.Constants.APP_TAG_PERPONERESOURCEREQUEST
                Dim intprojectemployeeroleid As Integer
                Dim m_strToken As String
                Dim strRequestStatus As String = ""
                Dim lngRequestID As String = ""
                Dim strQuery As String = ""
                lngRequestID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RequestID"), "0"), String)
                strQuery = "Exec usp_Sel_tbl_PM_ResourceRequest_GetStatusString_PreponeRequest " & lngRequestID.ToString()
                strRequestStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                m_strToken = CommonFunctions.Security.Token.GetToken(HttpContext.Current.Request.QueryString("RequestID") + HttpContext.Current.Session("intUserID").ToString + "0" + "3908")
                Dim drProjectEmployee As IDataReader
                drProjectEmployee = CommonFunction.Data.GetDataReader("usp_sel_PROJECTEMPLOYEEROLEID " + CType(HttpContext.Current.Session("intProjectID"), String) + "," + lngRequestID, True)
                If drProjectEmployee.Read Then
                    intprojectemployeeroleid = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(drProjectEmployee("PROJECTEMPLOYEEROLEID"), "0"), "0"), Integer)
                End If
                CommonFunction.Data.DisposeDataReader(drProjectEmployee)
                If Args.ColumnName.ToUpper = "DELETE" Then
                    Cancel = True
                ElseIf Args.DataField.ToUpper = "STATUS" Then
                    Args.IgnoreActualValue = True
                    Args.ReplacementValue = strRequestStatus
                ElseIf Args.DataField.ToUpper = "REQUESTID" Then

                    If strRequestStatus.ToUpper = "SUBMITTED" Or strRequestStatus.ToUpper = "READY FOR ASSIGNMENT" Then
                        Args.IgnoreActualValue = True
                        Args.ReplacementValue = "<A href=""JavaScript:Prepone_OnClick('" + intprojectemployeeroleid.ToString + "' ,'" + m_strToken + "')"">" + lngRequestID + "</A>"
                    End If
                    If strRequestStatus.ToUpper = "ASSIGNED" Then
                        Args.EnableLink = False
                    End If
                    If strRequestStatus.ToUpper = "DECLINED" Then
                        Args.EnableLink = False
                    End If
                    ' If strRequestStatus.ToUpper = "READY FOR ASSIGNMENT" Then
                    '    Args.EnableLink = False
                    'End If
                End If
            Case CommonFunction.Constants.APP_TAG_CHANGEALLOCATIONREQUEST
                Dim intprojectemployeeroleid As Integer
                Dim m_strToken As String
                Dim strRequestStatus As String = ""
                Dim lngRequestID As String = ""
                Dim strQuery As String = ""
                lngRequestID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RequestID"), "0"), String)
                strQuery = "Exec usp_Sel_tbl_PM_ResourceRequest_GetStatusString_PreponeRequest " & lngRequestID.ToString()
                strRequestStatus = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "")
                m_strToken = CommonFunctions.Security.Token.GetToken(HttpContext.Current.Request.QueryString("RequestID") + HttpContext.Current.Session("intUserID").ToString + "0" + "3908")
                Dim drProjectEmployee As IDataReader
                drProjectEmployee = CommonFunction.Data.GetDataReader("usp_sel_PROJECTEMPLOYEEROLEID " + CType(HttpContext.Current.Session("intProjectID"), String) + "," + lngRequestID, True)
                If drProjectEmployee.Read Then
                    intprojectemployeeroleid = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(drProjectEmployee("PROJECTEMPLOYEEROLEID"), "0"), "0"), Integer)
                End If
                CommonFunction.Data.DisposeDataReader(drProjectEmployee)
                If Args.ColumnName.ToUpper = "DELETE" Then
                    Cancel = True
                ElseIf Args.DataField.ToUpper = "STATUS" Then
                    Args.IgnoreActualValue = True
                    Args.ReplacementValue = strRequestStatus
                ElseIf Args.DataField.ToUpper = "REQUESTID" Then

                    If strRequestStatus.ToUpper = "SUBMITTED" Or strRequestStatus.ToUpper = "READY FOR ASSIGNMENT" Then
                        Args.IgnoreActualValue = True
                        Args.ReplacementValue = "<A href=""JavaScript:Change_OnClick('" + intprojectemployeeroleid.ToString + "' ,'" + m_strToken + "')"">" + lngRequestID + "</A>"
                    End If
                    If strRequestStatus.ToUpper = "ASSIGNED" Then
                        Args.EnableLink = False
                    End If
                    If strRequestStatus.ToUpper = "DECLINED" Then
                        Args.EnableLink = False
                    End If
                    If strRequestStatus.ToUpper = "READY FOR ASSIGNMENT" Then
                        Args.EnableLink = False
                    End If
                End If
        End Select
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
        ElseIf Args.DataField.ToUpper = "STATUS" Then
            Args.ApplySorting = False

        End If
    End Sub
End Class
