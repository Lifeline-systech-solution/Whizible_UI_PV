Imports CommonEngines.General.cEventHandlers
Public Class cComputation_Rules_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class
Public Class cComputation_Rules_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub After_AttachmentDelete(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Protected Overrides Sub After_SaveAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Protected Overrides Sub After_UploadAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Protected Overrides Sub Before_AttachmentDelete(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Protected Overrides Sub Before_GetAttachmentFolderPath(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Protected Overrides Sub Before_SaveAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Protected Overrides Sub Before_UploadAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Protected Overrides Sub Before_ViewAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentView, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Protected Overrides Sub BeforePrintDetails_SubTag(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_SubTag, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    End Sub

    Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Always sort by the 
        Args.OrderClause = "Temp_StartRange"
    End Sub
End Class
Public Class cComputation_Rules_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
Public Class cComputation_Rules_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub


    Protected Overrides Sub After_PlotControl(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")

    End Sub

    Protected Overrides Sub After_PlotControlCaption(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterCaption As String = "")

    End Sub

    Protected Overrides Sub After_PlotControlCell(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")

    End Sub

    Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")

    End Sub

    Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

    End Sub

    Protected Overrides Function GetCheckDuplicateSQL(ByVal strSQL As String, ByVal objGlobal As WebPages.Template.IGlobal) As String

    End Function


    Protected Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

End Class


Public Class Computation_Rules_CommonPage
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

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "Computation_Rules_CommonList.aspx"
        MyBase.strFormPage = "Computation_Rules_CommonPage.aspx"


        MyBase.Page_Load(sender, e)



    End Sub
    Protected Overrides Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cPlotGrid
        Return New Computation_Rules_SubCommonPageGrid(MyBase.m_objGlobal)

    End Function
    Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String


    End Function
    Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String

    End Function
    Protected Overrides Sub After_ExecutingAction(ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)

    End Sub
    Protected Overrides Sub Before_ExecutingAction(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)

        Select Case UCase(Trim(Args.ClientSideFunctionName & ""))
            Case "ADDCR"

                Dim strQuery As String = "usp_Ins_tbl_KRA_ComputationRule " & "'" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "', 0"
                CommonFunction.Data.InsertOrUpdateData(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                strQuery = Nothing
                'exec(usp_Ins_tbl_KRA_ComputationRuleEmployeeSpecific) '<USER_NAME>',<USER_ID>
                '--------------

                Dim strRuleID_PK As String '= CommonFunctions.Data.CheckIsDBNull(HttpContext.Current.Request("RuleID_PK")).ToString

                Dim strSql As String = "Select max(RuleID) from tbl_KRA_ComputationRule_Master"
                strRuleID_PK = CommonFunctions.Data.GetDataScalar(strSql, True).ToString
                Dim intRuleID_PK As Integer = Convert.ToInt16(strRuleID_PK)
                'Args.ToBeInserted += "objfrm.action=""../KRA/Employee_ComputationRule_CommonPage.aspx?MasterTagID=30084&PKToken=DKeRcvOdBUiGS8V6cWIIsQ&RuleID_PK=" & intRuleID_PK & "&select=True"";"
                'Args.ToBeInsertedInFunction += "objfrm.action=""../KRA/SelectValueDriver_CommonList.aspx?MasterTagID=30063&Action=save"";"
                'Args.ToBeInserted += "objfrm.submit(); return;"
                'Args.CommonQueryString

                Dim strEmployeeKRAID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("sEmployeeKRAID"))
                HttpContext.Current.Response.Redirect("../KRA/Computation_Rules_CommonPage.aspx?MasterTagID=3881&PKToken=&FromCL=1&RuleID_PK=" & intRuleID_PK)



            Case "SAVECRD"
                Dim blnUseSQL As Boolean = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
                Dim arrSubRuleID() As String = Split(Request.Form("hdSubRuleID"), ",")
                Dim arrStartRange() As String = Split(Request.Form("StartRange"), ",")
                Dim arrEndRange() As String = Split(Request.Form("EndRange"), ",")
                Dim arrAppliedValue() As String = Split(Request.Form("AppliedValue"), ",")
                Dim intUBound As Integer = UBound(arrStartRange)
                Dim intCount As Integer
                Dim strRuleID As String = Request.Form("RuleID_PK").ToString

                Dim sbSQL As New System.Text.StringBuilder
                'Update the Computation Rule Details
                For intCount = 0 To intUBound
                    If arrStartRange(intCount) <> "" Then
                        sbSQL.Append("EXEC [dbo].usp_Upd_tbl_KRA_ComputationRule_Detail " + arrSubRuleID(intCount) + "," + arrStartRange(intCount) + "," + arrEndRange(intCount) + "," + arrAppliedValue(intCount) + ",'" + CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) + "'" + vbCrLf)
                    End If
                Next
                sbSQL.Append("EXEC [dbo].usp_Upd_tbl_KRA_ComputationRule_Master " + strRuleID + ",'" + CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) + "'")
                CommonFunctions.Data.InsertOrUpdateData(sbSQL.ToString, blnUseSQL)
                sbSQL = Nothing
                Cancel = True
                ' Hided by SwatiM on 18th Jan,08 to remove error of RefreshParent on Computation Rules page.
                'CommonFunction.General.WriteHTML(vbCrLf + "<Script language=javascript>")
                'CommonFunction.General.WriteHTML(vbCrLf + "   refreshParent('frmCommonList','Computation_Rules_CommonList.aspx','../../Source/KRA/Computation_Rules_CommonList.aspx');")
                'CommonFunction.General.WriteHTML(" window.close();")
                'CommonFunction.General.WriteHTML("</SCRIPT>")
        End Select

        'Dim lngPaletteID As Long
        'Dim dr As IDataReader
        'Dim strSQL As String
        'Dim blnUseSQL As Boolean
        'Dim intOrderNumber As Integer

        'Dim arrID() As String = {}
        'Dim arrColor() As String = {}
        'Dim intUBound As Integer
        'Dim intCount As Integer
        'Dim sbSQL As System.Text.StringBuilder

        'blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        'Select Case UCase(Trim(Args.LinkName & ""))
        '    Case "SAVE"
        '        'Get the PaletteID (PK) for the commonpage
        '        lngPaletteID = CLng(HttpContext.Current.Request("PaletteID_PK"))

        '        ' we will use a single sql statement to execute delete & insert options for all palette colors
        '        sbSQL = New System.Text.StringBuilder

        '        ' SQL to delete all palette details (colors) for the palette
        '        sbSQL.Append("exec usp_del_tbl_CDB_Palette_Details_ForPalette " + lngPaletteID.ToString + vbCrLf)

        '        ' SQL to insert new colors
        '        arrID = Split(Request.Form("hdPaletteDetailID" + lngPaletteID.ToString), ",")
        '        arrColor = Split(Request.Form("hdColorName" + lngPaletteID.ToString), ",")
        '        intUBound = UBound(arrID)
        '        For intCount = 0 To intUBound
        '            intOrderNumber = CInt(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request(arrID(intCount).ToString), "1"))
        '            sbSQL.Append("exec usp_ins_tbl_CDB_Palette_Details " + lngPaletteID.ToString + ",'" + CommonFunctions.General.BuildQueryString(arrColor(intCount)) + "'" + "," + intOrderNumber.ToString + vbCrLf)
        '        Next
        '        CommonFunctions.Data.InsertOrUpdateData(sbSQL.ToString, blnUseSQL)
        '        sbSQL = Nothing

        '    Case "COPY PALETTE"
        '        lngPaletteID = CInt(CommonFunctions.General.CheckIsNothing(Request.QueryString("UniqueValue"), "0"))
        '        strSQL = "usp_CDB_CopyPalette  " & lngPaletteID & "," & WhizGlobal.UserID & ",'" & WhizGlobal.LoginType & "'" & ",0"
        '        CommonFunctions.Data.InsertOrUpdateData(strSQL, blnUseSQL)
        '    Case Else
        'End Select

    End Sub



    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)
        Dim strQuery As String = "Select RuleDescription from tbl_KRA_ComputationRule_Master where RuleID=" + Gen.PrimaryKeyValue
        Dim RuleID As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, True))
        Args.RightPageCaption = "Rule Description:" + RuleID
    End Sub

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cComputation_Rules_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cComputation_Rules_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cComputation_Rules_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cComputation_Rules_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    Protected Overloads Function InitSubTagCLSQL() As CommonEngine.CommonList.cSubTagCLSQL
        Return New cComputation_Rules_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    End Function

    Private Sub Page_PreRender1(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.PreRender

    End Sub
End Class

Class Computation_Rules_SubCommonPageGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Dim count As Integer

    Private m_sbCSScript As New System.Text.StringBuilder("")
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        MyBase.New(WhizGlobal)

    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strDrawTextBox As String
        Dim strSubRuleID As String
        Dim strStartRange As String
        Dim strEndRange As String
        Dim strAppliedValue As String

        strSubRuleID = Args.DataReader("SubRuleID").ToString

        Select Case UCase(Args.DataField)
            Case "STARTRANGE"
                strStartRange = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("StartRange")).ToString

                ''''Commented And Added By Vaijat K On 07/10/2015
                ' ''strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("StartRange", "StartRange" + count.ToString, , 35, , strStartRange, "Right", , , , , , "onblur='validateCR_StartRange(this.id)'", True)
                ' ''strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdSubRuleID", "hdSubRuleID", , 35, , strSubRuleID, "Right", , , , , True, , True)

                strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("StartRange", "StartRange" + count.ToString, , 35, , strStartRange, "Right", , , , , , "onblur='validateCR_StartRange(this.id)'", True, EnableHTMLEncode:=True)
                strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdSubRuleID", "hdSubRuleID", , 35, , strSubRuleID, "Right", , , , , True, , True, EnableHTMLEncode:=True)
                ''''End Added By Vaijat K On 07/10/2015

                'Plot Text box instead of grid cell value
                Args.IgnoreActualValue = True
                Args.ReplacementValue = strDrawTextBox
            Case "ENDRANGE"
                strEndRange = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EndRange")).ToString
                ''''Commented And Added By Vaijat K On 07/10/2015
                '''strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("EndRange", "EndRange" + count.ToString, , 35, , strEndRange, "Right", , , , , , "onblur='validateCR_EndRange(this.id)'", True)
                strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("EndRange", "EndRange" + count.ToString, , 35, , strEndRange, "Right", , , , , , "onblur='validateCR_EndRange(this.id)'", True, EnableHTMLEncode:=True)
                ''''End Added By Vaijat K On 07/10/2015
                'Plot Text box instead of grid cell value
                Args.IgnoreActualValue = True
                Args.ReplacementValue = strDrawTextBox
            Case "APPLIEDVALUE"
                strAppliedValue = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("AppliedValue")).ToString
                ''''Commented And Added By Vaijat K On 07/10/2015
                '''strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("AppliedValue", "AppliedValue" + count.ToString, , 35, , strAppliedValue, "Right", , , , , , "onblur='validateCR_AppliedRange(this.id)'", True)
                strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("AppliedValue", "AppliedValue" + count.ToString, , 35, , strAppliedValue, "Right", , , , , , "onblur='validateCR_AppliedRange(this.id)'", True, EnableHTMLEncode:=True)
                ''''End Added By Vaijat K On 07/10/2015
                'Plot Text box instead of grid cell value
                Args.IgnoreActualValue = True
                Args.ReplacementValue = strDrawTextBox
        End Select
        count = count + 1

        'Cancel = True

        'strDrawTextBox = "<TD align=""Right"" align=""top""><table><tr><td>"

        '' write the validation required for the control
        'm_sbCSScript.Append("var obj" + lngPaletteDetailID.ToString + "=GetObjectReference('frmCommonPage','" + lngPaletteDetailID.ToString + "')" + vbCrLf)
        'm_sbCSScript.Append("if (disallowBlank(obj" + lngPaletteDetailID.ToString + ",'Order number cannot be blank')) return false;" + vbCrLf)
        'm_sbCSScript.Append("if (disallowNegativeNumeric(obj" + lngPaletteDetailID.ToString + ",'Please enter a positive numeric value')) return false;" + vbCrLf)

        'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox(lngPaletteDetailID.ToString, lngPaletteDetailID.ToString, , 35, , intOrderNumber.ToString, "Right", , , , , , , True)
        '' hidden control containing palette detail id
        'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdPaletteDetailId" + lngPaletteID.ToString, "hdPaletteDetailId" + lngPaletteID.ToString, , 35, , lngPaletteDetailID.ToString, "Right", , , , , True, , True)
        '' hidden control having colors
        'strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdColorName" + lngPaletteID.ToString, "hdColorName" + lngPaletteID.ToString, , 35, , Args.DataReader("ColorName").ToString, "Left", , , , , True, , True)
        'strDrawTextBox += "</td></tr></table></TD>"

        'Args.StringToBeInserted = strDrawTextBox

    End Sub

    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        m_sbCSScript.Append("return true" + vbCrLf)
        m_sbCSScript.Append("}" + vbCrLf)
        m_sbCSScript.Append("</SCRIPT>" + vbCrLf)
        HttpContext.Current.Response.Write(m_sbCSScript.ToString)
    End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        m_sbCSScript.Append(vbCrLf)
        m_sbCSScript.Append("<script language=javascript>" + vbCrLf)
        m_sbCSScript.Append("function validate_orderNo()" + vbCrLf)
        m_sbCSScript.Append("{" + vbCrLf)
    End Sub

    Protected Overrides Sub Finalize()
        m_sbCSScript = Nothing
        MyBase.Finalize()
    End Sub
End Class
