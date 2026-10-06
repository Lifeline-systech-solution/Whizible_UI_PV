Imports CommonFunctions
Public Class DM_DocumentTemplates
    Inherits WebPages.Template.WhizTemplate


    Protected m_strMode As String
    Protected m_strFromWhere As String
    Protected m_strAction As String
    Protected m_strInitiativeID As String
    Protected m_NatureOfDemandID As String
    Private WithEvents objGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objTemplateGrid As New WebPage.Templates.GenericGrid
    Protected m_RequestStageID As String
    Protected IsPerformedLoad As Boolean = False
    Protected strSubCategory As String = ""
    Protected m_IsApplicable As String
    Protected m_IsMandatory As String
    Protected m_IdeaID As String = "0"
    Protected m_RevisionID As String = "0"


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

    End Sub

    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draw the page with its 
    '                           controls on it. This procedure is called from the HTML bady tag of the page.
    '                           this procedure gives the call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SwatiC
    ' Created				:	10 Mar 2008
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()

        Dim strSQL As String
        Dim drSubCategory As IDataReader
        'Dim arrValues As System.Collections.ArrayList
        Dim iRowLoop As Integer
        Dim strSubCat As String

        InitializeVariables()

        If General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "") = "Delete" Then
            Call DeleteTemplate()
        End If

        DrawMenu()

        If General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "") <> "Template" Then
            'Create Client Side array to filter Sub Categories 
            strSQL = "Usp_Sel_DocumentSubCategory_Template " + m_NatureOfDemandID + "," + General.CheckIsNothing(HttpContext.Current.Request.QueryString("TemplateID"), "0")

            If m_RequestStageID <> "" Then
                strSQL = strSQL + "," + m_RequestStageID
            Else
                strSQL = strSQL + ",NULL"
            End If

            drSubCategory = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

            Response.Write(" <SCRIPT LANGUAGE=javascript>	")
            Response.Write(" arrsubCategories=new Array; ")

            iRowLoop = 0
            While (drSubCategory.Read)
                strSubCat = ""
                strSubCat = Convert.ToString(drSubCategory("CategoryID"))
                strSubCat = strSubCat & "," + Replace(Convert.ToString(drSubCategory("SubcategoryID")), "'", "\'")
                strSubCat = strSubCat & "," + Replace(Convert.ToString(drSubCategory("SubCategory")), "'", "\'")
                Response.Write("arrsubCategories[" & iRowLoop & "]='" & strSubCat & "' ;  ")
                iRowLoop = iRowLoop + 1
            End While
            Data.DisposeDataReader(drSubCategory)
            Response.Write("</Script>")
        End If

        If General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "") <> "Template" Then
            General.WriteHTML("<br><TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageCaption><TD align=Left>Configure Document Settings</TD></TR></TABLE><BR>")
        Else
            General.WriteHTML("<br><TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageCaption><TD align=Left>Configure Document Settings</TD></TR></TABLE><BR>")
        End If

        If General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "") = "Save" Then
            Call SaveData()
        End If

        If General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "") <> "Template" Then
            Call plotTemplateUploadScreen()
        Else
            Call DrawTemplateGrid()
        End If

        DrawMenu()

    End Sub


    Public Sub New()
        ' Added and Commented By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting


        MyBase.ApplySecurity(True)
        ' End Added and Commented By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        MyBase.InitializeResources("AppResources.DM_DocumentTemplates", "AppResources")
    End Sub

    '=====================================================================
    ' Procedure Name		:	DeleteTemplate
    ' Parameters Passed		:	DeleteTemplate
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To Delete Templates.
    ' Description			:	To Delete Templates.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SwatiC
    ' Created				:	11 Mar 2008
    ' Revisions				:	
    '=====================================================================
    Private Sub DeleteTemplate()
        Dim strSQL As String

        strSQL = "Usp_INS_UPD_Del_tbl_IM_Templates NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,'"

        strSQL = strSQL + General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), "0") + "'"

        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
    End Sub
    '=====================================================================
    ' Procedure Name		:	SaveData
    ' Parameters Passed		:	SaveData
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To Save Template Data.
    ' Description			:	To Save Template Data.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SwatiC
    ' Created				:	11 Mar 2008
    ' Revisions				:	
    '=====================================================================
    Private Sub SaveData()
        Dim strSQL As String
        Dim strTemplateName As String = MyBase.Request.Form("txtTemplateName")
        Dim strCategory As String = MyBase.Request.Form("cboCategory")
        Dim strSubCategory As String = MyBase.Request.Form("cboSubCategory")
        Dim strDescription As String = MyBase.Request.Form("txtDescription")
        'Commented and modified by SuchitraP on 16-Sep-2008
        'Dim strIsApplicable As String = General.CheckIsNothing(MyBase.Request.Form("chkApplicable"), "0")
        Dim strIsApplicable As String = "1"
        'End by SuchitraP
        Dim strIsMandatory As String = General.CheckIsNothing(MyBase.Request.Form("chkMandatory"), "0")

        strSQL = "Usp_INS_UPD_Del_tbl_IM_Templates '" + General.BuildQueryString(strTemplateName) + "',"

        strSQL = strSQL + "NULL,NULL," + strCategory + "," + IIf(strSubCategory = "", "NULL", strSubCategory) + ",NULL,'" + General.BuildQueryString(strDescription) + "',NULL," + strIsApplicable + "," + strIsMandatory + ",1," + General.CheckIsNothing(HttpContext.Current.Request.QueryString("TemplateID"), "0")

        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
    End Sub
    '=====================================================================
    ' Procedure Name		:	plotTemplateUploadScreen
    ' Parameters Passed		:	plotTemplateUploadScreen
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the controls for the upload mode of the page.
    ' Description			:	Here HTML file control is plotted to select the file from the disk.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SwatiC
    ' Created				:	10 Mar 2008
    ' Revisions				:	
    '=====================================================================
    Private Sub plotTemplateUploadScreen()
        Dim strSQL As String
        Dim strTemplateName As String = ""
        Dim strCategoryID As String = ""
        Dim strDiscription As String = ""
        Dim strIsApplicable As Boolean = False
        Dim strIsMandatory As Boolean = False


        If General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "") = "Edit" Then
            Dim drTemplate As IDataReader
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'strSQL = "Select TemplateName, CategoryID, SubCategoryID,Description,IsApplicable,IsMandatory from v_tbl_IM_Templates Where TemplateID=" + HttpContext.Current.Request.QueryString("TemplateID").ToString
            strSQL = "usp_sel_v_tbl_IM_Templates_TemplateName " + HttpContext.Current.Request.QueryString("TemplateID").ToString
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            drTemplate = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If drTemplate.Read() Then
                strTemplateName = CType(CommonFunction.Data.CheckIsDBNull(drTemplate.Item("TemplateName")), String)
                strCategoryID = CType(CommonFunction.Data.CheckIsDBNull(drTemplate.Item("CategoryID")), String)
                strSubCategory = CType(CommonFunction.Data.CheckIsDBNull(drTemplate.Item("SubCategoryID")), String)
                strDiscription = CType(CommonFunction.Data.CheckIsDBNull(drTemplate.Item("Description")), String)
                strIsApplicable = CType(Data.CheckIsDBNull(drTemplate.Item("IsApplicable"), "0"), Boolean)
                strIsMandatory = CType(Data.CheckIsDBNull(drTemplate.Item("IsMandatory"), "0"), Boolean)
            End If
            CommonFunction.Data.DisposeDataReader(drTemplate)
            'drTemplate.Dispose()
        End If

        General.WriteHTML("<Table class='clsTable'  width=99.9% cellspacing=0 cellpadding=0 >")

        'display the Template Name
        'General.WriteHTML("<TR class='clsTREven'>")
        'General.WriteHTML("<TD align='left'>Template Name</TD>")
        'General.WriteHTML("<TD align='left'>" + HTMLControls.DrawTextBox("txtTemplateName", "txtTemplateName", , 400, 149, strTemplateName, , , , , , , , True, True) + "</TD>")
        'General.WriteHTML("</TR>")

        'If General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "") <> "Edit" Then
        '    'display the file control
        '    General.WriteHTML("<TR class='clsTREven'>")
        '    General.WriteHTML("<TD align='left'>Select Document</TD>")
        '    General.WriteHTML("<TD align='left'>" + HTMLControls.DrawFileControl("txtFileName", "txtFileName", "clsFileControl", 60, , , , , , , True) + "</TD>")
        '    General.WriteHTML("</TR>")
        'End If

        'display document category combo
        General.WriteHTML("<TR class='clsTRBody'>")
        General.WriteHTML("<TD valign='top' align='right'>Category</TD>&nbsp;")
        strSQL = "Usp_Sel_DocumentCategory_Template " + m_NatureOfDemandID
        If General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "") = "Edit" Then
            strSQL = strSQL + "," + General.CheckIsNothing(HttpContext.Current.Request.QueryString("TemplateID"), "0")
        Else
            strSQL = strSQL + ", 0"
        End If

        If m_RequestStageID <> "" Then
            strSQL = strSQL + "," + m_RequestStageID
        Else
            strSQL = strSQL + ",NULL"
        End If

        General.WriteHTML("<TD valign='top' align='left'>" + HTMLControls.DrawComboBox("cboCategory", strSQL, 250, strCategoryID, "onchange = 'cboCategory_OnChange()'", True, True, , True) + "</TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("<TR class='clsTRBody'>")
        General.WriteHTML("<TD valign='top' align='right'>Sub Category</TD>&nbsp;")
        General.WriteHTML("<TD id='tdSubCategory' valign='top' align='left'>" + HTMLControls.DrawComboBox("cboSubCategory", "Select 0,''", 250, strSubCategory, , True, True, , ) + "</TD>")
        General.WriteHTML("</TR>")


        'display discription textarea
        General.WriteHTML("<TR class='clsTRBody'>")
        General.WriteHTML("<TD valign='top' align='right'>Description</TD>&nbsp;")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'General.WriteHTML("<TD align='left' valign='top'>" + HTMLControls.DrawTextArea("txtDescription", "txtDescription", , , , "frmInitiativeDocuments", , , 250, 50, 2000, strDiscription, , , , , , , , True, True) + "</TD>")
        General.WriteHTML("<TD align='left' valign='top'>" + HTMLControls.DrawTextArea("txtDescription", "txtDescription", , , , "frmInitiativeDocuments", , , 250, 50, 2000, strDiscription, , , , , , , , True, True, EnableHTMLEncode:=True) + "</TD>")
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        General.WriteHTML("</TR>")

        'Commented by SuchitraP on 16-Sep-2008
        ''display Applicable CheckBox
        'General.WriteHTML("<TR class='clsTRBody'>")
        'General.WriteHTML("<TD valign='top' align='right'>Applicable</TD>&nbsp;")
        'General.WriteHTML("<TD align='left' valign='top'>" + HTMLControls.DrawCheckBox("chkApplicable", "chkApplicable", , strIsApplicable, 1, , "onClick='javascript:Applicable_OnClick(this)'", True) + "</TD>")
        'General.WriteHTML("</TR>")
        'End by SuchitraP

        'display  Mandatory CheckBox
        General.WriteHTML("<TR class='clsTRBody'>")
        General.WriteHTML("<TD valign='top' align='right'>Mandatory</TD>&nbsp;")
        General.WriteHTML("<TD align='left' valign='top'>" + HTMLControls.DrawCheckBox("chkMandatory", "chkMandatory", , strIsMandatory, 1, , , True) + "</TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("</Table>")

        'General.WriteHTML("<Table id='tblMsg' class='clsTable' width=99.9% cellspacing=0 cellpadding=0 style='Display: none;'>")
        'General.WriteHTML("<TR class='clsTROdd'><TD align='center'>Uploading file,Please wait...</TD></TR>")
        'General.WriteHTML("</Table>")
        General.WriteHTML("<br>")

        'To Draw Grid 
        General.WriteHTML("<Div id='DivList' width=100% height=90% style='overflow: auto;' >")
        DrawGrid()
        General.WriteHTML("</div>")

        'write client side script to set focus on the filename textbox
        General.WriteHTML("<Script language=javascript>")
        General.WriteHTML(" var objcboSC =  GetObjectReference('frmInitiativeDocuments','cboSubCategory');")
        General.WriteHTML(" if(objcboSC!=null) objcboSC.focus(); ")
        General.WriteHTML("</Script>")

    End Sub
    '=====================================================================
    ' Procedure Name		:	DrawTemplateGrid
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To Draw the Grid 
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SwatiC
    ' Created				:	12 Mar 2008
    ' Revisions				:	
    '=====================================================================

    Private Sub DrawTemplateGrid()

        'Dim ArrActualFieldNames() As String = {"TemplateName", "Category", "SubCategory", "IsApplicable", "IsMandatory"}
        Dim ArrActualFieldNames() As String = {"Category", "SubCategory", "IsApplicable", "IsMandatory"}
        'Dim ArrUserFriendlyFieldNames() As String = {"Template Name", "Category", "Sub Category", "Applicable", "Mandatory"}
        Dim ArrUserFriendlyFieldNames() As String = {"Category", "Sub Category", "Applicable", "Mandatory"}
        Dim strSQL As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'strSQL = "SELECT * FROM v_tbl_IM_ProjectTemplates WHERE ProjectNatureOfDemandID= " + m_NatureOfDemandID + " AND RequestStageID=" + m_RequestStageID '+ " AND RevisionID=" + m_RevisionID
        strSQL = "usp_sel_v_tbl_IM_ProjectTemplates " + m_NatureOfDemandID + "," + m_RequestStageID
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        With (objTemplateGrid)
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .NoOfDataColumns = ArrActualFieldNames.Length
            .DIVID = "DivList"
            .PrimaryKey = "ProjectTemplateID"
            .DIVStyle = "Overflow:auto;width:100%"
            .DIVHeight = 300
            .SQL = strSQL
            '.StaticHeaderStyle = STATIC_HEADER_STYLE.DISABLED
            '.ShowSummaryFunctions = True

            .UseSQL = MyBase.UseSQL
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        objTemplateGrid = Nothing

    End Sub
    '=====================================================================
    ' Procedure Name		:	DrawGrid
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To Draw the Grid 
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SwatiC
    ' Created				:	11 Mar 2008
    ' Revisions				:	
    '=====================================================================

    Private Sub DrawGrid()
        'Dim ArrActualFieldNames() As String = {"TemplateName", "Category", "SubCategory", "Description", "IsApplicable", "IsMandatory", ""}
        Dim ArrActualFieldNames() As String = {"Category", "SubCategory", "Description", "IsApplicable", "IsMandatory", ""}
        'Dim ArrUserFriendlyFieldNames() As String = {"Template Name", "Category", "Sub Category", "Description", "Applicable", "Mandatory", "Delete"}
        Dim ArrUserFriendlyFieldNames() As String = {"Category", "Sub Category", "Description", "Applicable", "Mandatory", "Delete"}
        Dim strSQL As String
        'Dim arrCheckBoxIDs() As String = {"", "", "", "", "", "chkDelete"}
        Dim arrCheckBoxIDs() As String = {"", "", "", "", "chkDelete"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'strSQL = "SELECT * FROM v_tbl_IM_Templates WHERE NatureOfDemandID= " + m_NatureOfDemandID + " AND StageID=" + m_RequestStageID
        strSQL = "usp_sel_v_tbl_IM_Templates " + m_NatureOfDemandID + "," + m_RequestStageID
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        With (objGrid)
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .ActualColumnArray = ArrActualFieldNames

            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "TemplateID"
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            .DIVID = "DivList2"
            .DIVHeight = 150
            .DIVStyle = "overflow:auto;width:99.99%;"
            .NoOfDataColumns = ArrActualFieldNames.Length - 1
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        objGrid = Nothing
    End Sub
    '=====================================================================
    ' Procedure Name		:	performUploadAction
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To upload the file given by the user and update the database with the entry.
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SwatiC
    ' Created				:	11 Mar 2008
    ' Revisions				:	
    '=====================================================================
    Private Sub performUploadAction()
        Dim strSQL As String
        Dim strFileName As String = ""
        Dim strCategory As String = ""
        Dim strDescription As String = ""
        'Dim objFileUpload As FileUpload.cUpload
        'Dim objFile As CommonFunction.FileDirectory.FileProperties
        Dim strOldFileName As String = ""
        Dim strUploadedFileName As String = ""
        Dim strFilePath As String = ""
        'Dim objDR As IDataReader
        Dim strSubCategory As String = ""
        Dim strTemplateName As String = ""
        Dim strSystemFileName As String = ""
        Dim m_ParentTagID As Long = 0

        strSubCategory = MyBase.GetFormValue("cboSubCategory") + ""



        'get the values from the form controls
        strCategory = MyBase.GetFormValue("cboCategory") + ""
        strDescription = MyBase.GetFormValue("txtDescription") + ""
        strTemplateName = MyBase.GetFormValue("txtTemplateName") + ""

        'If CommonFunctions.Security.Token.ValidateToken(CType(m_intUniqueID, String) + CType(m_lngUserID, String) + CType(m_ParentTagID, String) + CType(m_intTagID, String), m_strToken) = True Or m_strToken = "" Then

        'strFilePath = Server.MapPath("../../Documents/Templates/")

        'create the file object ot upload the file, Here Control Name is passed to the constructor
        'where the file name is taken internally from the control.Here we are not passing third parameter
        'to the constructor which is filename to upload.
        'This object creates the file name if it is already there to avoid the overwrite of old

        'objFileUpload = New FileUpload.cUpload("txtFileName", strFilePath)
        'objFileUpload.OverwriteIfExists = False
        'objFileUpload.UploadFile()
        'strOldFileName = objFileUpload.OriginalFileName
        'strUploadedFileName = objFileUpload.UploadedFileName

        'objFileUpload = Nothing

        ''create the fileProperties object ot get the properties of the file
        'objFile = New CommonFunction.FileDirectory.FileProperties
        'objFile.FilePath = strFilePath + "\" + strUploadedFileName.Trim
        'objFile.GetFileProperties()

        'strFileName = strUploadedFileName.Substring(0, strUploadedFileName.LastIndexOf("."))
        '
        strSQL = "Usp_INS_UPD_Del_tbl_IM_Templates "

        If strTemplateName <> "" Then
            strSQL = strSQL + "'" + General.BuildQueryString(strTemplateName) + "'"
        Else
            strSQL = strSQL + "NULL"
        End If
        If strFileName <> "" Then
            strSQL = strSQL + ",'" + General.BuildQueryString(strFileName) + "'"
        Else
            strSQL = strSQL + ",NULL"
        End If
        If strUploadedFileName <> "" Then
            strSQL = strSQL + ",'" + General.BuildQueryString(strUploadedFileName) + "'"
        Else
            strSQL = strSQL + ",NULL"
        End If

        strSQL = strSQL + "," + strCategory + "," + IIf(CBool(strSubCategory = ""), "NULL", strSubCategory) + "," + General.CheckIsNothing(HttpContext.Current.Request.QueryString("NatureOfDemandID"), "0") + ",'" + General.BuildQueryString(strDescription) + "'," + General.CheckIsNothing(HttpContext.Current.Request.QueryString("RequestStageID"), "0") + "," + m_IsApplicable + "," + m_IsMandatory

        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

    End Sub


    '=====================================================================
    ' Procedure Name		:	DrawMenu
    ' Parameters Passed		:	None
    ' Returns				:	None
    ' Parameters Affected	:	None
    ' Purpose				:	To Initialize Variables
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SwatiC
    ' Created				:	10 Mar 2008
    ' Revisions				:	
    '=====================================================================
    Private Sub DrawMenu()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim HasRecords As String
        Dim strSQL As String

        If m_strAction = "Upload" Then
            If IsPerformedLoad = False Then
                Call performUploadAction()
                IsPerformedLoad = True
            End If
        End If

        'initialize the resource file for standard menu.
        MyBase.InitializeResources("AppResources.DM_DocumentTemplates", "AppResources")

        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        If General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "") = "Edit" Then
            arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE")) : arrClientSideFunctions.Add("Save_OnClick(" + HttpContext.Current.Request.QueryString("TemplateID").ToString + ")")
        End If
        If General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "") <> "Template" Then
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'strSQL = "SELECT * FROM v_tbl_IM_Templates WHERE NatureOfDemandID= " + m_NatureOfDemandID + " AND StageID=" + m_RequestStageID
            strSQL = "usp_sel_v_tbl_IM_Templates " + m_NatureOfDemandID + "," + m_RequestStageID
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            HasRecords = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL), ""), String)
            If HasRecords <> "" Then
                arrMenu.Add(MyBase.GetResourceString("MENU_DELETE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_DELETE")) : arrClientSideFunctions.Add("Delete_OnClick()")
            End If
        End If

        If General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "") <> "Edit" And General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "") <> "Template" Then
            arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE")) : arrClientSideFunctions.Add("Upload_OnClick()")
        End If

        arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")

        'copy all the element to string array
        Dim arrstrMenu(arrMenu.Count - 1) As String
        Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
        Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
        arrMenu.CopyTo(arrstrMenu)
        arrMenuToolTip.CopyTo(arrstrMenuToolTip)
        arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
      

        'draw upper menu
        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
        General.WriteHTML(strMenu)

        arrMenu = Nothing
        arrMenuToolTip = Nothing
        arrClientSideFunctions = Nothing

    End Sub
    '=====================================================================
    ' Procedure Name		:	InitializeVariables
    ' Parameters Passed		:	None
    ' Returns				:	None
    ' Parameters Affected	:	None
    ' Purpose				:	To Initialize Variables
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SwatiC
    ' Created				:	10 Mar 2008
    ' Revisions				:	
    '=====================================================================
    Private Sub InitializeVariables()
        m_strMode = Request.QueryString("Mode") + ""
        m_strAction = Request.QueryString("Action") + ""

        m_NatureOfDemandID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("NatureOfDemandID"), "")
        If m_NatureOfDemandID = "" Or m_NatureOfDemandID Is Nothing Then
            m_NatureOfDemandID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("NatureofDemandID_PK"), "")
        End If

        If General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "") = "Template" Then
            m_NatureOfDemandID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectNatureOfDemandID"), "")
        End If

        If m_NatureOfDemandID = "" Or m_NatureOfDemandID Is Nothing Then
            m_NatureOfDemandID = "0"
        End If

        m_RequestStageID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RequestStageID"), "0")
        'Commented and modified by SuchitraP on 16-Sep-2008
        'm_IsApplicable = CommonFunctions.General.CheckIsNothing(MyBase.Request.Form("chkApplicable"), "0")
        m_IsApplicable = "1"
        'End by SuchitraP

        m_IsMandatory = CommonFunctions.General.CheckIsNothing(MyBase.Request.Form("chkMandatory"), "0")

        'If General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "") = "Template" Then
        '    Dim drInitiativeDetails As IDataReader

        '    m_IdeaID = General.CheckIsNothing(HttpContext.Current.Request.QueryString("IdeaID"), "0")
        '    drInitiativeDetails = Data.GetDataReader("SELECT NatureOfDemandID,RequestStageID, NatureOfDemand_RevisionID FROM tbl_IM_ProjectTemplates WITH (NOLOCK) WHERE IdeaID = " + m_IdeaID, MyBase.UseSQL)
        '    If drInitiativeDetails.Read Then
        '        m_NatureOfDemandID = CType(Data.CheckIsDBNull(drInitiativeDetails.Item("NatureOfDemandID"), "0"), String)
        '        m_RequestStageID = CType(Data.CheckIsDBNull(drInitiativeDetails.Item("RequestStageID"), "1"), String)
        '        m_RevisionID = CType(Data.CheckIsDBNull(drInitiativeDetails.Item("NatureOfDemand_RevisionID"), "1"), String)
        '    End If
        '    drInitiativeDetails.Dispose()

        'End If
    End Sub

    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<td  align=center><Input type=checkbox name=""chkDelete"" id=""chkDelete"" class='clsCheckBox' value=" + Args.DataReader("TemplateID").ToString + "></td>"
        End If
        'If Args.ColumnName.ToUpper = "TEMPLATE NAME" Then
        If Args.DataField.ToUpper = "CATEGORY" Then
            Cancel = True
            Args.StringToBeInserted = "<td  align=left> <a href=javascript:Template_OnClick(" + CType(Args.DataReader("TemplateID"), String) + ")>" + CType(Args.DataReader("Category"), String) + " </a> </td>"
        End If
    End Sub

    Private Sub objTemplateGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objTemplateGrid.DataRowTD_BeforePrint
        'If Args.ColumnName.ToUpper = "TEMPLATE NAME" Then
        'If Args.DataField.ToUpper = "ISMANDATORY" Then
        '    Cancel = True
        '    Args.StringToBeInserted = "<td  align=left>" + IIf(CBool(Data.CheckIsDBNull(Args.DataReader("IsMandatory"), "0")), "Yes", "No").ToString + "</td>"
        'End If
    End Sub
End Class

