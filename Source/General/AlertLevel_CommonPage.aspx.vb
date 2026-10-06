Imports CommonEngines.General.cEventHandlers

Public Class AlertLevel_CommonPage
    Inherits CommonPage
    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cAlertLevel_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function
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

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "AlertLevel_CommonList.aspx"
        MyBase.strFormPage = "AlertLevel_CommonPage.aspx"


        MyBase.Page_Load(sender, e)



    End Sub
    'Private Sub PerformAction()
    '    Dim lngPaletteID As Long
    '    Dim dr As IDataReader
    '    Dim strSQL As String
    '    Dim blnUseSQL As Boolean
    '    Dim intOrderNumber As Integer

    '    Dim arrID() As String = {}
    '    Dim arrColor() As String = {}
    '    Dim intUBound As Integer
    '    Dim intCount As Integer
    '    Dim sbSQL As System.Text.StringBuilder

    '    blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

    '    'Select Case UCase(Trim(Args.LinkName & ""))
    '    'Case "SAVE"
    '    'Get the PaletteID (PK) for the commonpage
    '    'lngPaletteID = CLng(HttpContext.Current.Request("AlertID_PK"))

    '    ' we will use a single sql statement to execute delete & insert options for all palette colors
    '    sbSQL = New System.Text.StringBuilder

    '    ' SQL to delete all palette details (colors) for the palette
    '    'sbSQL.Append("exec usp_del_tbl_CDB_Palette_Details_ForPalette " + lngPaletteID.ToString + vbCrLf)

    '    ' SQL to insert new colors
    '    Dim AlertID As String = ""
    '    AlertID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("AlertID_PK"), "0"), String)
    '    arrID = Split(Request.Form("hdPaletteDetailID"))
    '    arrColor = Split(Request.Form("ColorName") + AlertID, ",")
    '    intUBound = UBound(arrID)
    '    For intCount = 0 To intUBound
    '        intOrderNumber = CInt(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request(arrID(intCount).ToString), "1"))
    '        If AlertID = "" Then
    '            sbSQL.Append("exec usp_ins_tbl_pm_AlertLevel " + HttpContext.Current.Request.Form("Alert") + ",'" + CommonFunctions.General.BuildQueryString(arrColor(intCount)) + "'" + "," + intOrderNumber.ToString + " ," + AlertID + vbCrLf)
    '        End If
    '    Next
    '    CommonFunctions.Data.InsertOrUpdateData(sbSQL.ToString, blnUseSQL)
    '    sbSQL = Nothing





    'End Sub


    Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        Dim NOIID As String = ""
        Dim m_strToken As String
        Dim m_AlertID As String
        Dim strQuery As String
        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        ''strQuery = "SELECT MAX(alertID) from tbl_pm_AlertLevel"
        strQuery = "usp_sel_tbl_pm_AlertLevel_alertID"
        ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        m_AlertID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), String)
        m_AlertID = CLng(CommonFunctions.General.CheckIsNothing(m_AlertID, "0"))



        If Not Request.Form("txtNOIID") Is Nothing Then
            NOIID = Request.Form("txtNOIID").ToString
        Else
            NOIID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("AlertID_PK"), "0"), String)
        End If

        m_strToken = CommonFunctions.Security.Token.GetToken(Request.Form("txtNOIID") + HttpContext.Current.Session("intUserID").ToString + "0" + "20031")
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtNOIID", "txtNOIID", , , , NOIID, , , , , , True, , True))
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtToken", "txtToken", , , , m_strToken, , , , , , True, , True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtNOIID", "txtNOIID", , , , NOIID, , , , , , True, , True, EnableHTMLEncode:=True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtToken", "txtToken", , , , m_strToken, , , , , , True, , True, EnableHTMLEncode:=True))
        ''end of Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        'If CommonFunction.General.CheckIsNothing(Request.QueryString("Action")).ToUpper = "SAVE" Then
        '    PerformAction()
        '    'If NOIID = 0 Then
        '    '    NOIID = m_AlertID
        '    'End If
        '    PageUIPreRender = "var objform=GetFormReference('frmCommonPage'); objform.action='../General/AlertLevel_CommonPage.aspx?AlertID_PK='+objPKvalue.value+'&PKToken='+ token +'&MasterTagID=20031&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1'objform.submit();"

        '    strActionCode = ReturnCodes.ON_LOAD.ToString
        'End If
    End Function


    Public Overrides Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String
        Dim lngPaletteID As Long
        Dim dr As IDataReader
        Dim strSQL As String
        Dim blnUseSQL As Boolean
        Dim intOrderNumber As Integer

        Dim AlertID As String
        Dim arrColor As String
        Dim intUBound As Integer
        Dim intCount As Integer
        Dim sbSQL As System.Text.StringBuilder

        blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        sbSQL = New System.Text.StringBuilder



        If PrimaryKey = "" Then
            PrimaryKey = "NULL"
        End If
        'Dim AlertID As String = ""
        'AlertID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("AlertID_PK"), "0"), String)
        'AlertID = Split(Request.Form("hdPaletteDetailID"))
        arrColor = Request.Form("ColorName")
        'intUBound = UBound(arrID)
        'For intCount = 0 To intUBound
        'intOrderNumber = CInt(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request(arrID(intCount).ToString), "1"))
        'If AlertID = "" Then
        'If CommonFunction.General.CheckIsNothing(Request.Form("ColorName"), "") <> "" Then
        sbSQL.Append("exec usp_ins_tbl_pm_AlertLevel '" + HttpContext.Current.Request.Form("Alert") + "','" + CommonFunctions.General.BuildQueryString(arrColor) + "'" + "," + HttpContext.Current.Request.Form("OrderNumber") + " ," + PrimaryKey + vbCrLf)
        'End If
        'Next

        'CommonFunctions.Data.InsertOrUpdateData(sbSQL.ToString, blnUseSQL)

        PrimaryKey = CommonFunctions.Data.GetDataScalar(sbSQL.ToString, blnUseSQL)
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_SAVE.ToString
        RedirectToCL = False
        sbSQL = Nothing
        'Else
        'Response.Write("var objAlertColor=GetObjectReference('frmCommonPage','ColorName');")
        'Response.Write("alert(objAlertColor.value);")
        'Response.Write("if (disallowBlank(objAlertColor,'Please select Alert Color',true)) {")
        'Response.Write("objAlertColor.focus();")
        'strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_SAVE.ToString
        'RedirectToCL = True
        'End If

    End Function


    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.LinkName = "Save" Then
            Args.ToBeInsertedInFunction = "var objAlertColor=GetObjectReference('frmCommonPage','ColorName');"
            Args.ToBeInsertedInFunction += "if (disallowBlank(objAlertColor,'Please select Alert Color',true)) {"
            Args.ToBeInsertedInFunction += "objAlertColor.focus();  return;  }"
        End If

    End Sub


    Public Class cAlertLevel_CommonPagePlotControls
        Inherits CommonEngine.CommonPage.cPlotControls
        Public Sub New(ByVal varGlobal As WebPages.Template.IGlobal)
            ''Assign the Parameter values to the local variables
            Call MyBase.New(varGlobal)
        End Sub

        Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")

            Dim strColorName As String
            If Args.ControlName.ToUpper = "COLOR" Then
                Cancel = True
                'Args.IgnoreActualValue = True
                Args.ControlToolTip = "Color Palette Control"
                If Args.IsEditMode = True Then
                    strColorName = CStr(CommonFunction.Data.CheckIsDBNull(drControls.Item("Color"), ""))
                Else
                    strColorName = ""
                End If
                Args.Mandatory = True
                Args.ValidationRules = "14,1"
                InsertBeforeControl = CommonFunction.HTMLControls.DrawColorPalette("ColorName", "ColorName", "clsColorPaletteTextBox", , strColorName, , , , , , , , , True, True)
                Args.InsertAfterControlOption = ""
                Args.Mandatory = True
                Args.ValidationRules = "14,1"
            End If
        End Sub

    End Class
End Class

