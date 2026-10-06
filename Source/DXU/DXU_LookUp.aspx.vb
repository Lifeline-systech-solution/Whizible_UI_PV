Public Class DXU_LookUp
    Inherits WebPages.Template.WhizTemplate

    Protected m_intMandatoryFldsCnt As Integer
    Protected m_intFieldID As Integer
    Protected m_strMode As String
    Protected strMatchFld As String
    Protected m_strWindowTitle As String
    Protected WithEvents objgrid As WebPages.Template.GenericGrid
    Protected WithEvents objMenu As WebPages.Template.StaticMenu
    Protected WithEvents objHeaderFooter As WebPages.Template.HeaderFooter
    Protected cObjSectionTitle As New WebPages.Template.SectionTitle
    Protected strComboSQL As String
    Protected strUpdateSQL As String
    Protected strMapSQL As String
    Protected m_objDataReader As IDataReader
    Protected m_objData As CommonFunctions.Data
    Protected m_strTemplateFieldName As String
    'Added by irtaizas
    Protected m_strTableSelected As String = ""
    'Protected m_strTableSelected As String = ""
    Protected m_strSqlToPopulateColumns As String = ""
    'Code added by SandipL on 23 sep
    'DXU Enhancements For WhizEngg Team
    'Purpose :- Data type Validation for ID
    Protected m_strSQLToPopulateDatatypes As String = ""
    'End addition by SandipL on 23 Sep

    Protected m_strLookUpMatchField As String = ""
    Protected m_strLookUpValue As String = ""
    Protected m_strSqlForInsertUpdate As String = ""
    Protected m_strSqlForGettingTableName As String = ""
    'Added by HemantB - 18th Feb
    Protected m_strPrimaryKey As String = ""
    Private m_strTemplateID As String
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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        If Not Request.QueryString("FieldID") Is Nothing Then
            m_intFieldID = CType(Request.QueryString("TemplateID"), Integer)
        End If

        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode")
        End If

        'Added by HemantB - 18th Feb
        If Not Request.QueryString("PrimaryKeyName") Is Nothing Then
            m_strPrimaryKey = Request.QueryString("PrimaryKeyName")
        End If
        'Adde by SandipL on 19 May 2006
        If Not Request.QueryString("intTemplateID") Is Nothing Then
            m_strTemplateID = Request.QueryString("intTemplateID")
        End If
    End Sub
    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draws the page with its 
    '                           controls on it. This procedure is called from the HTML body tag of the page.
    '                           This procedure gives call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	HemantB
    ' Created				:	Dec 08 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()


        MyBase.ApplySecurity(True)

        Dim arrNames As New ArrayList
        Dim arrToolTip As New ArrayList
        Dim arrFunction As New ArrayList


        objMenu = New WebPages.Template.StaticMenu


        If Not IsNothing(Request.QueryString("IsLookUp")) AndAlso Request.QueryString("IsLookUp") = "1" Then
            arrNames.Add("Clear Look-Up")
            arrToolTip.Add("Delete this Look-Up")
            arrFunction.Add("ClearLookUp_onclick()")
        End If

        arrNames.Add("Default Lookup")
        arrToolTip.Add("Insert Default Lookup")
        arrFunction.Add("DefLookup_onclick()")

        arrNames.Add("Save")
        arrToolTip.Add("Save")
        arrFunction.Add("Save_onclick()")

        arrNames.Add("Close")
        arrToolTip.Add("Close")
        arrFunction.Add("Cancel_onclick()")

        Dim ArrMenuNames(arrNames.Count - 1) As String
        arrNames.ToArray.CopyTo(ArrMenuNames, 0)
        arrNames = Nothing

        Dim ArrMenuToolTip(arrToolTip.Count - 1) As String
        arrToolTip.ToArray.CopyTo(ArrMenuToolTip, 0)
        arrToolTip = Nothing

        Dim ArrMenuFunctions(arrFunction.Count - 1) As String
        arrFunction.ToArray.CopyTo(ArrMenuFunctions, 0)
        arrFunction = Nothing

        Dim strMenu As String
        strMenu = objMenu.DrawMenuWithEvents(ArrMenuNames, ArrMenuFunctions, ArrMenuToolTip)
        Response.Write(strMenu)

        'header footer

        objHeaderFooter = New WebPages.Template.HeaderFooter
        With objHeaderFooter
            .HeaderFooter = "Map Fields"
            .DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.UI_HEADER
        End With
        Response.Write("<br>")
        Response.Write(objHeaderFooter.DrawHeaderFooter())
        Response.Write("<br>")
        objHeaderFooter = Nothing

        'Section
        With cObjSectionTitle
            Response.Write(.GetSectionTitle("Map Fields", "DivMap", "ShowHideMap"))
            'Write ClientsideScript in order to show hide the section
            Response.Write("<SCRIPT Language=javascript>")
            Response.Write(.ClientsideScript)
            Response.Write("</SCRIPT>")
        End With
        HttpContext.Current.Response.Write("<DIV Id='DivMap'" + " Style='HEIGHT:150px;'>")

        Select Case m_strMode
            Case "Save"
                Call SaveRecord()
            Case "Edit"
                Call EditRecord()
            Case "PopulateCombo"
                Call PopulateCombo()
            Case "ClearLookUp"
                Call ClearLookUp()
            Case "InsertDefault"
                Call InsertDefault()
        End Select

        'If Not IsNothing(Request.QueryString("TableID")) Then
        '    m_strTableSelected = Request.QueryString("TableID")
        'Else
        '    m_strTableSelected = m_strTableSelected
        'End If


        'hidden controls
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hdntxtTable", "hdntxtTable", IsHidden:=True, returnHTML:=True, value:=MyBase.GetFormValue("hdntxtTable"), EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hdntxtTemplateID", "hdntxtTemplateID", IsHidden:=True, returnHTML:=True, value:=Request.QueryString("intTemplateID"), EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hdntxtFieldID", "hdntxtFieldID", IsHidden:=True, returnHTML:=True, value:=Request.QueryString("intFieldID"), EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding

        Response.Write("<TABLE CellSpacing=0 width='100%' class=clsTable colspan=3><TR class=clsTREven><TD align='left'>")
        Response.Write("LookUp Tables")
        Response.Write("</TD></TR><TR class=clsTREven><TD align='left'>")
        Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cboTable", "usp_sel_tbl_DXU_LookUp_PopulateTables", , m_strTableSelected, "onchange='cboTable_OnChange()'", True, True))
        Response.Write("</TD></TR>")
        Response.Write("</TABLE>")

        If m_strTableSelected <> "" Then
            Response.Write("<TABLE CellSpacing=0 width='100%' class=clsTable colspan=3><TR class=clsTREven><TD align='left'>")
            Response.Write("LookUp Columns</TD><TD>")
            Response.Write("</TD></TR><TR class=clsTREven><TD align='left'>")
            Response.Write(CommonFunction.HTMLControls.DrawListBox("lstColumns", m_strSqlToPopulateColumns, 150, 100))
            Response.Write("</TD><TD align='right'>")
            'Code added by SandipL on 23 sep
            'DXU Enhancements For WhizEngg Team
            'Purpose :- Data type Validation for ID
            Response.Write(CommonFunction.HTMLControls.DrawComboBox("hdncboDatatypes", m_strSQLToPopulateDatatypes, 10, , , , , , , , True))
            'End addition by SandipL on 23 Sep
            Response.Write("<TABLE CellSpacing=0 width='100%' class=clsTable><TR class=clsTREven><TD></TD>")
            Response.Write("<TD align='left'>")
            Response.Write("Value from column")
            Response.Write("</TD></TR><TR class=clsTREven><TD align='left'>")
            Response.Write(CommonFunction.HTMLControls.DrawImage("../../Images/dblclick.gif", , , "AddForeignKey()", , , , True))
            Response.Write("</TD><TD align='left'>")
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtMatchField", "txtMatchField", , , , m_strLookUpMatchField, , , , True, , , , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            Response.Write("</TD></TR><TR class=clsTREven><TD></TD>")
            Response.Write("<TD align='left'>")
            Response.Write("Value to be matched with")
            Response.Write("</TD></TR><TR class=clsTREven><TD align='left'>")
            Response.Write(CommonFunction.HTMLControls.DrawImage("../../Images/dblclick.gif", , , "AddFieldToMatch()", , , , True))
            Response.Write("</TD><TD align='left'>")
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtMatchValue", "txtMatchValue", , , , m_strLookUpValue, , , , True, , , , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            Response.Write("</TD></TR></TABLE>")
            Response.Write("<TR class=clsTREven></TR>")
            Response.Write("</TD></TR></TABLE>")
        End If

        HttpContext.Current.Response.Write("</DIV>")

        Response.Write(strMenu)


    End Sub
    '=====================================================================
    ' Procedure Name		:	SaveRecord
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To save the data on the page into the database
    ' Description			:	This procedure reads the values of controls on the page and saves the data
    '                           into tbl_DXU_LookUp. The TemplateID and FieldId for which the record has been
    '                           saved are taken from the querystring.                        
    '                           After saving the record, the parameters required to set the values of the controls
    '                           on the page are initialised to proper values.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	IrtaizaS
    ' Created				:	Jan 18 2005
    ' Revisions				:	
    '=====================================================================
    Private Sub SaveRecord()
        'Save the record

        m_strSqlForInsertUpdate = "usp_Ins_Upd_tbl_DXU_LookUp " & Request.QueryString("intTemplateID")
        m_strSqlForInsertUpdate = m_strSqlForInsertUpdate & ", " & Request.QueryString("intFieldID")
        m_strSqlForInsertUpdate = m_strSqlForInsertUpdate & ", " & MyBase.GetFormValue("hdntxtTable")
        m_strSqlForInsertUpdate = m_strSqlForInsertUpdate & ", " & MyBase.GetFormValue("txtMatchValue")
        m_strSqlForInsertUpdate = m_strSqlForInsertUpdate & ", " & MyBase.GetFormValue("txtMatchField")
        Call CommonFunction.Data.InsertOrUpdateData(m_strSqlForInsertUpdate, MyBase.UseSQL)

        m_strLookUpMatchField = MyBase.GetFormValue("txtMatchField")
        m_strLookUpValue = MyBase.GetFormValue("txtMatchValue")
        m_strTableSelected = MyBase.GetFormValue("cboTable")
        m_strSqlToPopulateColumns = "usp_sel_tbl_DXU_LookUp_PopulateColumns " & m_strTableSelected

      
        'Code added by SandipL on 23 sep
        'DXU Enhancements For WhizEngg Team
        'Purpose :- Data type Validation for ID
        m_strSQLToPopulateDatatypes = "usp_Sel_SysColumn_dataType " & m_strTableSelected
        'End addition by SandipL on 23 Sep
    End Sub
    Private Sub InsertDefault()
        'Save the record
        Dim drInfo As IDataReader
        m_strSqlForInsertUpdate = "usp_Ins_Upd_Default_tbl_DXU_LookUp " & Request.QueryString("intTemplateID")
        m_strSqlForInsertUpdate = m_strSqlForInsertUpdate & ", " & Request.QueryString("intFieldID")
      

        drInfo = CommonFunction.Data.GetDataReader(m_strSqlForInsertUpdate, MyBase.UseSQL)
        'initialize paramters
        If drInfo.Read() Then
            m_strLookUpMatchField = CType(drInfo("MatchField"), String)
            m_strLookUpValue = CType(drInfo("MatchValue"), String)
            m_strTableSelected = CType(drInfo("LookUpTable"), String)
        End If
        CommonFunction.Data.DisposeDataReader(drInfo)
        'initialize paramters
        If m_strTableSelected <> "" Then
            m_strSqlToPopulateColumns = "usp_sel_tbl_DXU_LookUp_PopulateColumns " & m_strTableSelected
            m_strSQLToPopulateDatatypes = "usp_Sel_SysColumn_dataType " & m_strTableSelected
        End If

  
    End Sub
    '=====================================================================
    ' Procedure Name		:	EditRecord
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To initializa values of controls on the form.
    ' Description			:	This procedure simply initializes all the parameters
    '                           required to set the default values of the controls. 
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	IrtaizaS
    ' Created				:	Jan 18 2005
    ' Revisions				:	
    '=====================================================================
    Private Sub EditRecord()
        'See if there exists any record for the current field in the template
        m_strSqlForGettingTableName = "usp_tbl_DXU_LookUp_GetLookUptable "
        m_strSqlForGettingTableName += Request.QueryString("intTemplateID") & ", "
        m_strSqlForGettingTableName += Request.QueryString("intFieldID")
        m_objDataReader = CommonFunction.Data.GetDataReader(m_strSqlForGettingTableName, MyBase.UseSQL)

        'if the data exists, initialize parameters to that else initialize to blank
        If m_objDataReader.Read() Then
            m_strTableSelected = CommonFunction.General.CheckIsNothing(m_objDataReader("ID"))
            m_strLookUpMatchField = CommonFunction.General.CheckIsNothing(m_objDataReader("LookUpValue"))
            m_strLookUpValue = CommonFunction.General.CheckIsNothing(m_objDataReader("LookUpMatchField"))
            m_strSqlToPopulateColumns = "usp_sel_tbl_DXU_LookUp_PopulateColumns " & m_strTableSelected
            'Code added by SandipL on 23 sep
            'DXU Enhancements For WhizEngg Team
            'Purpose :- Data type Validation for ID
            m_strSQLToPopulateDatatypes = "usp_Sel_SysColumn_dataType " & m_strTableSelected
            'End addition by SandipL on 23 Sep
        Else
            m_strTableSelected = ""
            m_strLookUpMatchField = ""
            m_strLookUpValue = ""
            m_strSqlToPopulateColumns = "usp_sel_tbl_DXU_LookUp_PopulateColumns " & MyBase.GetFormValue("cboTable")
            'Code added by SandipL on 23 sep
            'DXU Enhancements For WhizEngg Team
            'Purpose :- Data type Validation for ID
            m_strSQLToPopulateDatatypes = "usp_Sel_SysColumn_dataType " & MyBase.GetFormValue("cboTable")
            'End addition by SandipL on 23 Sep
        End If
        CommonFunction.Data.DisposeDataReader(m_objDataReader)
        'm_strTableSelected = m_strTableSelected
    End Sub
    Private Sub PopulateCombo()
        m_strLookUpMatchField = ""
        m_strLookUpValue = ""
        m_strSqlToPopulateColumns = "usp_sel_tbl_DXU_LookUp_PopulateColumns " & MyBase.GetFormValue("cboTable")
        'Code added by SandipL on 23 sep
        'DXU Enhancements For WhizEngg Team
        'Purpose :- Data type Validation for ID
        m_strSQLToPopulateDatatypes = "usp_Sel_SysColumn_dataType " & MyBase.GetFormValue("cboTable")
        'End addition by SandipL on 23 Sep
        m_strTableSelected = MyBase.GetFormValue("cboTable")
    End Sub
    Private Sub ClearLookUp()
        Dim strSqlToClearLookUp As String
        strSqlToClearLookUp = "IF Exists (Select * from tbl_DXU_LookUp where TemplateID = " & Request.QueryString("intTemplateID")
        strSqlToClearLookUp &= " and DestinationFieldID = " & Request.QueryString("intFieldID") & ")"
        strSqlToClearLookUp &= " BEGIN"
        strSqlToClearLookUp &= " Delete from tbl_DXU_LookUp where TemplateID = " & Request.QueryString("intTemplateID")
        strSqlToClearLookUp &= " and DestinationFieldID = " & Request.QueryString("intFieldID")
        strSqlToClearLookUp &= " Update tbl_DXU_TemplateDetails SET IsLookUp = 0 where TemplateID = " & Request.QueryString("intTemplateID")
        strSqlToClearLookUp &= " and ActualFieldID = " & Request.QueryString("intFieldID")
        strSqlToClearLookUp &= " END"
        CommonFunction.Data.InsertOrUpdateData(strSqlToClearLookUp, MyBase.UseSQL)
        m_strLookUpMatchField = ""
        m_strLookUpValue = ""
    End Sub

    Private Sub objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles objMenu.Before_Link_Print
        If Args.FunctionName.ToUpper = "SAVE_ONCLICK()" Or Args.FunctionName.ToUpper = "CLEARLOOKUP_ONCLICK()" Or Args.FunctionName.ToUpper = "DEFLOOKUP_ONCLICK()" Then
            Dim strSQL As String
            Dim intCount As Integer

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQL = "Select Count(1) From tbl_DXU_UploadRequestsQueue Where TemplateID= " & CStr(m_strTemplateID) & " And (Status='I' OR Status='A' OR Status='B') "
            strSQL = "usp_sel_tbl_DXU_UploadRequestsQueue_CountRequestID " & CStr(m_strTemplateID)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            intCount = CType(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), Integer)
            If intCount > 0 Then
                Cancel = True
            End If

        End If
    End Sub
End Class
