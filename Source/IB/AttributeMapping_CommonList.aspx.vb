Imports System
Imports CommonEngines.General.cEventHandlers
Imports Whizible
Imports System.Text


Public Class AttributeMapping_CommonList
    Inherits CommonList
    'Modified by ArchanaN on 12-Jul-2010
    'Dim strAction As String
    'Dim SysID As String
    Private strAction As String
    Private m_SysID As String
    Private m_IntegrationID As String
    Private m_Attribute As String

    'End of Modified by ArchanaN on 12-Jul-2010


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
        MyBase.strListPage = "AttributeMapping_CommonList.aspx"
        MyBase.strFormPage = "AttributeMapping_CommonPage.aspx"

        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
        Dim intCnt As Integer = 0
        Dim strsql As String = ""
        Dim strSysAttributtesAll As String = ""
        Dim drSysAttributes As IDataReader
        MyBase.WhizForm_Init(WhizGlobal, m_intConnectionID)
        If Not Request.QueryString("Action") Is Nothing And Request.QueryString("Action") <> "" Then
            strAction = Request.QueryString("Action").ToString()
        End If
        'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"), "").ToUpper() = "CUSTOMATTR" Then
        '    strsql = strsql + " Select SysAttributeName FROM tbl_FCI_ExternalSysAttribute_Mapping WHERE  IntegrationID=" + CommonFunctions.General.CheckIsNothing(Request.QueryString("IntegrationID"), "0").ToString
        '    drSysAttributes = CommonFunctions.Data.GetDataReader(strsql, True)
        '    While drSysAttributes.Read()
        '        strSysAttributtesAll = CommonFunctions.General.CheckIsNothing(drSysAttributes("SysAttributeName"), "").ToString
        '        CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtSysAttributeAll_" & intCnt, "txtSysAttributeAll_" & intCnt, , 400, , CommonFunction.General.BuildQueryString(strSysAttributtesAll), , , , , , True, , True))
        '        intCnt = intCnt + 1
        '    End While
        '    CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtTotalCntAll", "txtTotalCntAll", , 100, , intCnt, "Center", , , , , True, , True))
        '    drSysAttributes.Dispose()
        'Else
        ' strsql = "SELECT WhizAttributeName,SysAttributeName FROM v_tbl_FCI_ExternalSysAttribute_Inherit WHERE ProjectID=" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0").ToString + " And IsCustomeField=0 "
        'strsql = strsql + " AND TableFieldName IN (Select WhizAttributeName FROM tbl_FCI_ExternalSysAttribute_Mapping WHERE IntegrationID=" + CommonFunctions.General.CheckIsNothing(Request.QueryString("IntegrationID"), "0").ToString + " )"

        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
        ''Updated by Dhanashri S on 24 Aug 2016 For mastercard nxtgen upgrade issue Fixing
        ''strsql = strsql + "Select SysAttributeName FROM tbl_FCI_ExternalSysAttribute_Mapping WHERE IntegrationID=" + CommonFunctions.General.CheckIsNothing(Request.QueryString("IntegrationID"), "0").ToString
        strsql = strsql + "usp_sel_tbl_FCI_ExternalSysAttribute_SysAttributeName " + CommonFunctions.General.CheckIsNothing(Request.QueryString("IntegrationID"), "0").ToString
        ''End of Updation by Dhanashri S on 24 Aug 2016
        'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
        drSysAttributes = CommonFunctions.Data.GetDataReader(strsql, True)
        While drSysAttributes.Read()
            strSysAttributtesAll = CommonFunctions.General.CheckIsNothing(drSysAttributes("SysAttributeName"), "").ToString
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtSysAttributeAll_" & intCnt, "txtSysAttributeAll_" & intCnt, , 400, , CommonFunction.General.BuildQueryString(strSysAttributtesAll), , , , , , True, , True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:06/10/15
            intCnt = intCnt + 1
        End While
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtTotalCntAll", "txtTotalCntAll", , 100, , intCnt, "Center", , , , , True, , True, EnableHTMLEncode:=True))
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        drSysAttributes.Dispose()
        'End If
        If strAction = "SaveList" Then
            SaveSysAttributes()
        End If

    End Sub

    Private Sub SaveSysAttributes()
        Dim strSysAttributes As String = ""
        Dim strWhizAttributeName As String = ""

        Dim strSysAttributesList As String = ""
        Dim strWhizAttributesList As String = ""
        Dim strMandatoryList As String = ""
        Dim strOrderNoList As String = ""
        Dim strIsMandatory As String = "Fasle"
        Dim strOderNum As String = "0"

        'Dim PrimaryKeys As String
        Dim strQuery As String = ""
        Dim intCnt As Integer = 0
        Dim intTotCnt As Integer = 0
        Dim IsCustomeField As Integer = 0

        'Modified by ArchanaN on 12-Jul-2010
        'strSysAttributes = Request.Form("txtSysAttribute").ToString()
        'strWhizAttributeName = Request.Form("txtWhizAttribute").ToString()
        ' PrimaryKeys = Request.Form("txtPrimaryKey").ToString()
        'strSysAttributes = strSysAttributes.Replace("'", "''")
        'strQuery = "usp_UPD_tbl_FCI_ExternalSysAttribute_Mapping '" + PrimaryKeys + "','" + strSysAttributes  

        intTotCnt = CommonFunction.General.CheckIsNothing(Request.Form("txtTotalCnt"), 0)
        'm_SysID = Request.QueryString("SysID")
        m_IntegrationID = Request.QueryString("IntegrationID")
        IsCustomeField = CommonFunction.General.CheckIsNothing(Request.Form("txtCustomeField"), 0)

        While intCnt < intTotCnt
            strSysAttributes = CommonFunction.General.CheckIsNothing(Request.Form("txtSysAttribute_" & intCnt.ToString), "").ToString
            strWhizAttributeName = CommonFunction.General.CheckIsNothing(Request.Form("txtWhizAttribute_" & intCnt.ToString), "").ToString
            strIsMandatory = CommonFunction.General.CheckIsNothing(Request.Form("txtMandatory_" & intCnt.ToString), "").ToString
            strOderNum = CommonFunction.General.CheckIsNothing(Request.Form("txtOrderNo_" & intCnt.ToString), "").ToString

            If strSysAttributes <> "" Then
                strSysAttributesList += CommonFunction.General.BuildQueryString(strSysAttributes) + ","
                strWhizAttributesList += CommonFunction.General.BuildQueryString(strWhizAttributeName) + ","
                strMandatoryList += strIsMandatory + ","
                strOrderNoList += strOderNum + ","

            End If
            intCnt += 1
        End While

        If strSysAttributesList <> "" Then
            strQuery = "usp_UPD_tbl_FCI_ExternalSysAttribute_Mapping '" + strWhizAttributesList + "','" + strSysAttributesList + "'," + m_IntegrationID + "," + Session("intProjectID").ToString + ",'" + strMandatoryList + "','" + strOrderNoList + "'," + IsCustomeField.ToString
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        End If
        'End of Modified by ArchanaN on 12-Jul-2010
        CommonFunction.General.WriteHTML("<Script>")
        CommonFunction.General.WriteHTML("window.close();")
        CommonFunction.General.WriteHTML("window.opener.location.href='../IB/FCI_IntegrationSetup.aspx?Action=Attribute&FromCL=1';")
        '        CommonFunction.General.WriteHTML("window.location.href='../IB/FCI_IntegrationSetup.aspx?Action=Attribute';")

        'CommonFunction.General.WriteHTML("refreshParent('frmCommonList', 'FCI_IntegrationSetup.aspx','../IB/FCI_IntegrationSetup.aspx?FromWhere=PM&Action=Attribute');")
        CommonFunction.General.WriteHTML("</Script>")
    End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cAttributeMapping_CommonList_PlotGrid(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cAttributeMapping_CommonListCLSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function


    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        If Not Request.QueryString("IntegrationId") Is Nothing And Request.QueryString("IntegrationId") <> "" Then
            m_IntegrationID = Request.QueryString("IntegrationId")
        End If
        If m_IntegrationID Is Nothing And m_IntegrationID = "" Then
            m_IntegrationID = HttpContext.Current.Request.Form("IntegrationId_PK")
        End If
        'Added by vidya J
        'CommonFunctions.General.WriteHTML("<input type=hidden  name='IntegrationId_PK' value=" + m_IntegrationID + ">")
        'CommonFunctions.General.WriteHTML("<input type=hidden  name='hidAction' value=" + m_IntegrationID + ">")
        CommonFunctions.General.WriteHTML("<input type=hidden id='IntegrationId_PK' name='IntegrationId_PK' value=" + m_IntegrationID + ">")
        CommonFunctions.General.WriteHTML("<input type=hidden id='IntegrationId_PK' name='hidAction' value=" + m_IntegrationID + ">")
        'End Of Added by vidya J
        Dim sbTabSection As New StringBuilder

        sbTabSection.Append("<div id='Headtbl'><TABLE cellpadding=0 cellspacing=0 class=clsTableNavLinks width='100%'>")
        sbTabSection.Append("<TR class=clsTRNavLinks  valign=middle>")
        sbTabSection.Append("<TR class='clsTRblank'><TD valign=center align=left>")
        sbTabSection.Append("<TABLE  cellspacing=0   class=clsTable><TR>")
        sbTabSection.Append("<TD id =""ignoreRight""></TD>")
        ' sbTabSection.Append("<TD noWrap>")
        'Added by Archanan on 15-Jul-2010
        If CommonFunction.General.CheckIsNothing(Request.QueryString("Action"), "ISSUEATTR").ToUpper() = "ISSUEATTR" Then
            sbTabSection.Append("<TD id =""ISSUEATTR"" align=center noWrap Title=""Issue Attributes""><span id='selected'>Issue Attributes</span></A></TD>")
            sbTabSection.Append("<TD id =""CUSTOMATTR"" align=center noWrap Title=""Custom Attributes""><A class='clsSelected' href='javascript:ItemTab_OnClick(""CustomAttr"")'>Custom Attributes</A></TD>")
            sbTabSection.Append("</TR></TABLE>")
            sbTabSection.Append("</TR></TABLE>")
            Response.Write(sbTabSection.ToString())
        ElseIf Request.QueryString("Action").ToUpper() = "CUSTOMATTR" Then
            sbTabSection.Append("<TD id =""ISSUEATTR"" align=center noWrap Title=""Issue Attributes""><A class='clsSelected'  href='javascript:ItemTab_OnClick(""IssueAttr"")'>Issue Attributes</A></TD>")
            sbTabSection.Append("<TD id =""CUSTOMATTR"" align=center noWrap Title=""Custom Attributes""><span id='selected'>Custom Attributes</span></TD>")
            sbTabSection.Append("</TR></TABLE>")
            sbTabSection.Append("</TR></TABLE>")
            Response.Write(sbTabSection.ToString())
        End If
        'If CommonFunction.General.CheckIsNothing(Request.QueryString("Action"), "ISSUEATTR").ToUpper() = "ISSUEATTR" Then
        '    sbTabSection.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='Issue Attributes' href='javascript:ItemTab_OnClick(""IssueAttr"")' IssueAttr?)?>Issue Attributes</a>")
        '    sbTabSection.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='Custom Attributes' href='javascript:ItemTab_OnClick(""CustomAttr"")' CustomAttr?)?>Custom Attributes</a>")
        'ElseIf Request.QueryString("Action").ToUpper() = "CUSTOMATTR" Then
        '    sbTabSection.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='Issue Attributes' href='javascript:ItemTab_OnClick(""IssueAttr"")' IssueAttr?)?>Issue Attributes</a>")
        '    sbTabSection.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='Custom Attributes' href='javascript:ItemTab_OnClick(""CustomAttr"")' IssueAttr?)?>Custom Attributes</a>")
        'End If
  
        sbTabSection.Append("</TABLE>")
        sbTabSection.Append("</div>")

        ' Response.Write(sbTabSection.ToString())
        'End added by vidya
    End Function
End Class

Class cAttributeMapping_CommonList_PlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Dim m_intCnt As Integer = 0
    Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(objGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Modified by ArchanaN on 12-Jul-2010
        Dim strSysAttribute As String
        Dim strPK As String
        Dim strWhizAttribute As String
        Dim strMandatory As String
        Dim strOrderNo As String

        'If Args.DataField.ToUpper = "MANDATORY" Then
        '    strMandatory = Args.DataReader("Mandatory").ToString
        '    Cancel = True
        '    Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawTextBox("txtMandatory_" & m_intCnt, "txtMandatory_" & m_intCnt, , 400, , CommonFunction.General.BuildQueryString(strMandatory), , , , , , True, , True)
        'ElseIf Args.DataField.ToUpper = "RNUM" Then
        '    strOrderNo = Args.DataReader("RNum").ToString
        '    Cancel = True
        '    Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawTextBox("txtOrderNo_" & m_intCnt, "txtOrderNo_" & m_intCnt, , 300, , CommonFunction.General.BuildQueryString(strWhizAttribute), "Center", , , , , True, , True)

        If Args.DataField.ToUpper = "SYSATTRIBUTENAME" Then
            strSysAttribute = Args.DataReader("SysAttributeName").ToString
            ' strPK = Args.DataReader("WhizSysAttributeID").ToString
            strWhizAttribute = Args.DataReader("InsWhizAttributeName").ToString
            Cancel = True
            Args.StringToBeInserted = "<TD align=left>"
            ' Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtPrimaryKey", "txtPrimaryKey", , 50, 6, strPK, "Right", IsHidden:=True, returnHTML:=True)
            'Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawTextBox("txtSysAttribute", "txtSysAttribute", , 200, , strSysAttribute, , , , , , , , True)

            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawTextBox("txtSysAttribute_" & m_intCnt, "txtSysAttribute_" & m_intCnt, , 400, , strSysAttribute, , , , , , , , True, EnableHTMLEncode:=True)
            Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawTextBox("txtWhizAttribute_" & m_intCnt, "txtWhizAttribute_" & m_intCnt, , 300, , strWhizAttribute, "Center", , , , , True, , True, EnableHTMLEncode:=True)
            Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawTextBox("txtMandatory_" & m_intCnt, "txtMandatory_" & m_intCnt, , 400, , CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Mandatory"), 0), Integer), , , , , , True, , True, EnableHTMLEncode:=True)
            Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawTextBox("txtOrderNo_" & m_intCnt, "txtOrderNo_" & m_intCnt, , 300, , CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RNum"), "0").ToString, "Center", , , , , True, , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
            Args.StringToBeInserted += "</TD>"
            m_intCnt += 1
        End If
    End Sub


    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Args.ToBeInserted = CommonFunctions.HTMLControls.DrawTextBox("txtTotalCnt", "txtTotalCnt", , 100, , m_intCnt, "Center", , , , , True, , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"), "").ToUpper() = "CUSTOMATTR" Then
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            Args.ToBeInserted += CommonFunctions.HTMLControls.DrawTextBox("txtCustomeField", "txtCustomeField", , 100, , "1", "Center", , , , , True, , True, EnableHTMLEncode:=True)
        Else
            Args.ToBeInserted += CommonFunctions.HTMLControls.DrawTextBox("txtCustomeField", "txtCustomeField", , 100, , "0", "Center", , , , , True, , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If


    End Sub
    'End of Modified by ArchanaN on 12-Jul-2010


End Class
Class cAttributeMapping_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(objGlobal)
    End Sub
    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        Dim strIntegrationID As String
        strIntegrationID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IntegrationID"), "0").ToString
        'If intIntegrationID = 0 Then
        '    intIntegrationID = HttpContext.Current.Request.Form("SysID_PK")
        'End If

        'strWhizAttributeName = CommonFunction.General.CheckIsNothing(Request.Form("txtWhizAttribute_" & intCnt.ToString), "").ToString
        GetPageSpecificFilters += " AND ProjectID = " + HttpContext.Current.Session("intProjectID").ToString
        GetPageSpecificFilters += " AND TableFieldName NOT IN (Select WhizAttributeName FROM tbl_FCI_ExternalSysAttribute_Mapping WHERE IntegrationID="
        GetPageSpecificFilters += strIntegrationID + ")"
        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"), "").ToUpper() = "CUSTOMATTR" Then
            GetPageSpecificFilters += " AND IsCustomeField=1"
            GetPageSpecificFilters += " AND TableFieldName NOT IN (Select WhizAttributeName FROM tbl_FCI_ExternalSysAttribute_Mapping WHERE IntegrationID="
            GetPageSpecificFilters += strIntegrationID + ")"
        Else
            GetPageSpecificFilters += " AND IsCustomeField=0"
        End If
        GetPageSpecificFilters += " Order By RNum "
    End Function
End Class