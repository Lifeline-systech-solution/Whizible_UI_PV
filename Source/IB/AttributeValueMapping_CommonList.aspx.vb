Imports Whizible
Imports CommonEngines.General.cEventHandlers
Public Class AttributeValueMapping_CommonList
    Inherits CommonList
    Protected m_Action As String = ""
    Protected m_IntegrationID As String
    Protected m_intShowMap As String = "2"

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "AttributeValueMapping_CommonList.aspx"
        MyBase.strFormPage = "Commonpage.aspx"
        'Put user code to initialize the page here

        m_intShowMap = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShowMap"), "2")

        If m_intShowMap Is Nothing And m_intShowMap = "" Then
            m_intShowMap = HttpContext.Current.Request.Form("txtShowMap")
        End If
        CommonFunctions.General.WriteHTML("<input type=hidden name='txtShowMap' id='txtShowMap' value=" + m_intShowMap + ">")

        m_Action = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"))
        If m_Action.ToUpper = "SAVE" Then
            Dim strSysVal As String = ""
            Dim strwhizVal As String = ""
            ' Dim intSysID As Integer
            Dim cnt As Integer = 1
            Dim intWhizSysAttributeID As Integer
            Dim intTotCnt As Integer = 0
            Dim intProjectID As Integer
            m_IntegrationID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IntegrationID"), 0)
            intTotCnt = CommonFunction.General.CheckIsNothing(Request.Form("txtTotalCnt"), 0)
            intProjectID = Session("intProjectID")
            '            While HttpContext.Current.Request.Form("hid_SysID_" & cnt.ToString) > 0
            While cnt < intTotCnt
                strSysVal = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSysValue_" & cnt.ToString), "")
                strwhizVal = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("hid_txtWhizValue_" & cnt.ToString), "")
                intWhizSysAttributeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("hid_txtWhizSysAttributeID_" & cnt.ToString), 0)
                If strSysVal <> "" Then
                    SaveValue(strSysVal, strwhizVal, m_IntegrationID.ToString, intWhizSysAttributeID.ToString, intProjectID.ToString)
                Else
                    deleteValues(intWhizSysAttributeID.ToString, strwhizVal)
                End If

                cnt += 1
            End While
            CommonFunction.General.WriteHTML("<Script>")
            '            CommonFunction.General.WriteHTML("window.close();")
            CommonFunction.General.WriteHTML("window.location.href='../IB/AttributeValueMapping_CommonList.aspx?MasterTagID=8053&ShowMap=" + m_intShowMap + "&IntegrationID=" & m_IntegrationID.ToString & "&AttributeID=" & intWhizSysAttributeID.ToString & "&IntegrationID_PK=" & m_IntegrationID.ToString & "';")
            CommonFunction.General.WriteHTML("</Script>")
        End If


        MyBase.Page_Load(sender, e)

    End Sub
    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        If Not Request.QueryString("IntegrationID") Is Nothing And Request.QueryString("IntegrationID") <> "" Then
            m_IntegrationID = Request.QueryString("IntegrationID")
        End If
        If m_IntegrationID Is Nothing And m_IntegrationID = "" Then
            m_IntegrationID = HttpContext.Current.Request.Form("IntegrationID_PK") 'IntegrationID_PK'
        End If
        ''Commented and added by Nilesh g on 9/12/2015 for issue id 2633
        ''CommonFunctions.General.WriteHTML("<input type=hidden name='IntegrationID_PK' value=" + m_IntegrationID + ">")
        CommonFunctions.General.WriteHTML("<input type=hidden name='IntegrationID_PK' id='IntegrationID_PK' value=" + m_IntegrationID + ">")
    End Function
    Private Sub deleteValues(ByVal intWhizSysAttributeID As Integer, ByVal strwhizVal As String)
        Dim strSQL As String = ""
        strSQL = "usp_del_tbl_FCI_ExternalSysValue_Mapping " & intWhizSysAttributeID.ToString & ",'" & CommonFunction.General.BuildQueryString(strwhizVal) & "'"
        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
    End Sub
    Private Sub SaveValue(ByVal strSysVal As String, ByVal strwhizVal As String, ByVal intIntegrationID As Integer, ByVal intWhizSysAttributeID As Integer, ByVal intProjectID As Integer)
        Dim strSQL As String = ""
        strSQL = "Usp_ins_tbl_FCI_ExternalSysValue_Mapping " & intWhizSysAttributeID.ToString & "," & intIntegrationID.ToString & ",'" & CommonFunction.General.BuildQueryString(strSysVal) & "','" & CommonFunction.General.BuildQueryString(strwhizVal) & "'," & intProjectID.ToString & "," & Session("intUserID").ToString
        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
    End Sub

    
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New AttributeValueMapping_CommonList_CLPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cAttributeValueMapping_CommonList_CLSQL(MyBase.m_objGlobal)
    End Function
    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal whizGlobal As WebPages.Template.IGlobal)
        If Args.LinkName.ToUpper = "SAVE" Then
            Dim strSQL As String
            Dim drAccess As IDataReader
            strSQL = "Exec usp_Sel_tbl_UI_NodeAccess " & 8056 & "," & CType(HttpContext.Current.Session("intPostID"), Integer) & "," & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'" & CType(HttpContext.Current.Session("LoginType"), String) & "'"
            drAccess = CommonFunctions.Data.GetDataReader(strSQL, True)
            If drAccess.Read() Then
                If CType(drAccess.Item("A"), Boolean) = False And CType(drAccess.Item("E"), Boolean) = False Then
                    Cancel = True
                End If
            End If
        End If
    End Sub
End Class

Public Class AttributeValueMapping_CommonList_CLPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public m_cnt As Integer = 1
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.DataField.ToUpper = "WHIZVALUE" And (Args.DataReader("TableAttributeName").ToString.ToUpper = "ASSIGNTO" Or Args.DataReader("TableAttributeName").ToString.ToUpper = "CREATORORMODIFIER" Or Args.DataReader("TableAttributeName").ToString.ToUpper = "REPORTEDBY" Or Args.DataReader("TableAttributeName").ToString.ToUpper = "CODEDBY") Then
            Cancel = True
            Args.StringToBeInserted = "<td  align='left'>"
            Args.StringToBeInserted += CommonFunction.Data.GetDataScalar("Ups_sel_FCI_EmployeeName '" + CommonFunction.General.BuildQueryString(Args.DataReader("WhizValue").ToString) + "'", True)
            Args.StringToBeInserted += "</td>"
        End If
        If Args.DataField.ToUpper = "SYSVALUE" Then
            Cancel = True
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            ''Commented and added by Nilesh g on 9/12/2015 for issue id 2633
            '' Args.StringToBeInserted = "<td  align='left'>" + CommonFunction.HTMLControls.DrawTextBox("txtSysValue_" & m_cnt.ToString, "'txtSysValue_" & m_cnt.ToString, , 300, 100, Args.DataReader("SysValue").ToString, , , , , , , , True, EnableHTMLEncode:=True)
            Args.StringToBeInserted = "<td  align='left'>" + CommonFunction.HTMLControls.DrawTextBox("txtSysValue_" & m_cnt.ToString, "txtSysValue_" & m_cnt.ToString, , 300, 100, Args.DataReader("SysValue").ToString, , , , , , , , True, EnableHTMLEncode:=True)
            ''Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("hid_txtWhizValue_" & m_cnt.ToString, "'hid_txtWhizValue_" & m_cnt.ToString, , 300, 100, Args.DataReader("WhizValue").ToString, , , , , , True, , True, EnableHTMLEncode:=True)
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("hid_txtWhizValue_" & m_cnt.ToString, "hid_txtWhizValue_" & m_cnt.ToString, , 300, 100, Args.DataReader("WhizValue").ToString, , , , , , True, , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
            ''Commented and added by Nilesh g on 9/12/2015 for issue id 2633
            'Args.StringToBeInserted += "<Input type='hidden' name='hid_txtWhizValue_" & m_cnt.ToString & "' id='hid_txtWhizValue_" & m_cnt.ToString & "' class='clsTextBox' value=""" + Args.DataReader("WhizValue").ToString + """>"
            Args.StringToBeInserted += "<Input type='hidden' width='300px' name='hid_txtWhizSysAttributeID_" & m_cnt.ToString & "' id='hid_txtWhizSysAttributeID_" & m_cnt.ToString & "' class='clsTextBox' value=" + Args.DataReader("WhizSysAttributeID").ToString + ">"
            Args.StringToBeInserted += "</td>"
            m_cnt += 1
        End If
        If Args.DataField.ToUpper = "SHOW HISTORY" Then
            Cancel = True
            Args.StringToBeInserted = "<td  align='center'>"
            Args.StringToBeInserted += "<a href='javascript:History_OnClick(""" + Args.DataReader("WhizSysValueID").ToString + """," + Args.DataReader("WhizSysAttributeID").ToString + ")'<font size=1px color=blue>Show History</font></a>"
            Args.StringToBeInserted += "</td>"
        End If
    End Sub
    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Args.ToBeInserted = CommonFunctions.HTMLControls.DrawTextBox("txtTotalCnt", "txtTotalCnt", , 100, , m_cnt, "Center", , , , , True, , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
    End Sub
End Class

Class cAttributeValueMapping_CommonList_CLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(objGlobal)
    End Sub
    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        '' Dim intIntegrationID As Integer
        ' Dim intAttributeID As Integer
        ' Dim intShowMap As Integer = 2
        ' ' intIntegrationID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IntegrationID"), 0)
        ' intAttributeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("AttributeID"), 0)
        ' intShowMap = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShowMap"), 2)
        ' ' If intIntegrationID = 0 Then
        ' 'intIntegrationID = HttpContext.Current.Request.Form("IntegrationID_PK")
        ' ' End If
        ' GetPageSpecificFilters += " AND WhizSysAttributeID = " & intAttributeID.ToString

       

    End Function
    Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim intIntegrationID As Integer
        Dim intAttributeID As Integer
        Dim intShowMap As Integer = 2

        ' intIntegrationID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IntegrationID"), 0)
        intAttributeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("AttributeID"), 0)
        intShowMap = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShowMap"), 2)
        Args.GridSQL = "Exec usp_FCI_ExternalSysValue_Mapping " + intAttributeID.ToString + "," + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0").ToString
        If intShowMap = 1 Or intShowMap = 0 Then
            Args.GridSQL += "," & intShowMap.ToString
        End If
    End Sub
End Class