'**********************************************************************************
'                  CSPL Code Header
' Project Name     :	PbNIT
' Module Name      :	PC_GradeTypeCostType.aspx.aspx
' Purpose          :	To bulk add the Grade wise RateType wise Cost Type wise Rates for storing Effective Dates
' Description      :	To bulk add the Grade wise RateType wise Cost Type wise Rates for storing Effective Dates
' Assumptions      :	None.
' Dependencies     :	
' Author           :	PrajaktaR
' Reviewed         :	
' Tested           :	
' Created          :	11 th Nov 2005
' Revisions        :			
'**********************************************************************************

Public Class PC_GradeTypeCostType
    Inherits WebPages.Template.WhizTemplate

#Region " Variable Declaration"
    Protected m_strWindowTitle As String


    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu    'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid   'This variable is use to plotting grid.

    Private m_objGlobal As WebPages.Template.IGlobal                    'This variable is of global object inteface. 
    Private m_objAccessRights As WebPages.Security.cAccessRights        'This variable is for access rights of page.
    Protected WithEvents frmGradeTypeCostType As System.Web.UI.HtmlControls.HtmlForm

    Private strSQLQuery As String
    Private m_intProjectID As String
    Private strClientSideScript As String = ""
    Protected m_intGradeID As Integer
    Protected m_EffectiveDate As String                           'Effective Date
    Private arrActualColumns() As String
    Private arrUserFriendlyColumnNames() As String
    Private arrCostTypes() As String
    Private strMenu As String                           'stores the static menu string.
    Private m_strMode As String

    Private Const MODE_LIST As String = "List"
    Private Const MODE_SAVE As String = "Save"
    Private Const MODE_BULKUPDATE As String = "BulkUpdate"

    Private strTextIDs As String
    Private m_intCount As Integer

    Protected strNotSavedValues As String
    'Added by PrajakatR 
    Protected m_lngTagId As Long = 0                    'Tag ID
    'END Of Addition by PrajakatR 
#End Region

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
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        'm_objGlobal.TagID = 5051
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

        Initialize()

    End Sub

    Private Function CheckMasters() As Boolean
        Dim strSql As String
        Dim strSql1 As String
        Dim drMasters As IDataReader
        Dim drMasters1 As IDataReader

        ''Commented added By Abhijeet K on 4/8/2016 Purpose : Remove Inline Query
        ''strSql = "SELECT DISTINCT ProjectCostTypeID FROM tbl_CNF_ProjectCostType"
        strSql = "usp_sel_tbl_CNF_ProjectCostType_ProjectCostTypeID"

        ''Commented added By Abhijeet K on 4/8/2016 Purpose : Remove Inline Query
        ''strSql1 = "SELECT DISTINCT CostTypeID FROM tbl_CNF_CostType"
        strSql1 = "usp_sel_tbl_CNF_CostType_CostTypeID"

        drMasters = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)

        If Not drMasters.Read Then
            Return False
            Exit Function
        End If

        drMasters1 = CommonFunctions.Data.GetDataReader(strSql1, MyBase.UseSQL)

        If Not drMasters1.Read Then
            CommonFunction.Data.DisposeDataReader(drMasters)
            CommonFunction.Data.DisposeDataReader(drMasters1)
            Return False
            Exit Function
        End If
        CommonFunction.Data.DisposeDataReader(drMasters)
        CommonFunction.Data.DisposeDataReader(drMasters1)
        Return True


    End Function

    Public Sub PageInit()

        Dim arrDailyActivityEntryIDs() As String
        Dim drCompanyInformation As IDataReader
        Dim strSQL As String

        CommonFunctions.General.WriteHTML("<DIV id='divList' style='Overflow:auto;width:100%;Height:420px'>")

        If CheckMasters() = False Then
            'MsgBox("Please Enter Values in the Masters")
            'COMMONFUNCTIONS.General.WriteHTML (
            CommonFunctions.General.WriteHTML("<BR>")
            WebPages.Template.PageCaption.GetPageCaptions(, "Either 'Project Cost Type Master' or 'Cost Type Master' does not contain data. Please Check the Data.")
            CommonFunctions.General.WriteHTML("<br>")
            Exit Sub
        End If

        DrawMenu(strMenu)
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
        'DrawPageHeaderFooter()

        'CommonFunctions.General.WriteHTML("<DIV id='divList' style='Overflow:auto;width:100%;Height:420px'>")
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {CommonFunction.HTMLControls.DrawMandatoryImage(, True)}
        CommonFunction.General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend) + vbCrLf)

        DisplaySelectionHeader()
        'CommonFunctions.General.WriteHTML("<BR>")
        If m_strMode <> MODE_BULKUPDATE Then
            If m_intGradeID <> 0 And CommonFunctions.General.CheckIsNothing(m_EffectiveDate, "") <> "" Then
                DisplayRateGrid()
            End If
        Else
            DisplayRateGrid()
        End If


        CommonFunctions.General.WriteHTML("</DIV>")

        CommonFunctions.General.WriteHTML("<input name=txtTextIDS id=txtTextIDS type=hidden value=" + strTextIDs + ">")
        CommonFunctions.General.WriteHTML("<input name=txtHiddenDate id=txtHiddenDate type=hidden value=" + CommonFunctions.General.CheckIsNothing(m_EffectiveDate, "") + ">")

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        DisposeObjects()

    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Function Name         : Initialize
        ' Purpose               : Initializes the varaibles used in the page.
        ' Description           : Also gets the various User Preferences from the Database and 
        '                         information from the Querystring
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : PrajaktaR
        ' Created               : 11 th Nov 2005
        ' Revisions             : 
        '=====================================================================

        Dim strSQLQuery As String
        Dim drDates As IDataReader
        Dim drGradeRates As IDataReader

        'm_lngTagId = 5003 'm_objGlobal.TagID
        m_lngTagId = m_objGlobal.TagID
        m_strWindowTitle = "Level wise Cost Type wise Costs"

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("EffectiveDate")) <> "" Then
            m_EffectiveDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("EffectiveDate"))
        End If

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("GradeID")) <> "" Then
            m_intGradeID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("GradeID")), Integer)
        End If

        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"))
        If m_strMode = "" Then
            m_strMode = MODE_LIST
        End If

        If m_strMode = MODE_SAVE Then
            UpdateRates()
            m_strMode = MODE_LIST
        End If

        m_intCount = 0

    End Sub

    Private Sub UpdateRates()
        Dim intCount As Integer
        Dim strName As String
        Dim strProjectCostTypeID As String
        Dim strCostTypeID As String
        Dim intGradeID As Integer
        Dim dtEffectiveDate As Date
        Dim strSql As String
        Dim strTextIDS As String
        Dim arrstrTextBoxID() As String
        Dim arrstrIDs() As String
        Dim NumericBit As Boolean


        strTextIDS = MyBase.GetFormValue("txtTextIDS")
        If strTextIDS = "" Then
            Exit Sub
        End If
        arrstrTextBoxID = strTextIDS.Split(CType("|", Char))
        NumericBit = False
        strNotSavedValues = ""
        For intCount = 0 To arrstrTextBoxID.Length - 1
            If MyBase.GetFormValue(arrstrTextBoxID(intCount), True) <> "" Then
                If MyBase.GetFormValue(arrstrTextBoxID(intCount), True) <> "0" Then
                    If MyBase.GetFormValue(arrstrTextBoxID(intCount), True) > "0" Then
                        If IsNumeric(MyBase.GetFormValue(arrstrTextBoxID(intCount), True)) Then
                            strProjectCostTypeID = arrstrTextBoxID(intCount)
                            If strProjectCostTypeID <> "" Then
                                arrstrIDs = strProjectCostTypeID.Split(CType("_", Char))
                                strProjectCostTypeID = arrstrIDs(1)
                                strCostTypeID = arrstrIDs(2)
                                intGradeID = CType(MyBase.GetFormValue("cboGrade", True), Integer)
                                dtEffectiveDate = CType(MyBase.GetFormValue("dtEffDate", True), Date)
                                strSql = "usp_Ins_tbl_PM_ProjectCostType_CostType_Grade " + strProjectCostTypeID + ", " + strCostTypeID + ", " + CType(intGradeID, String) + ", " + CType(MyBase.GetFormValue(arrstrTextBoxID(intCount), True), String) + ", '" + CType(dtEffectiveDate, String) + "', '" + CType(Session("strUserName"), String) + "'"
                                CommonFunctions.Data.InsertOrUpdateData(strSql, MyBase.UseSQL)
                            End If
                        Else
                            NumericBit = True
                            strNotSavedValues += MyBase.GetFormValue(arrstrTextBoxID(intCount), True) + ", "

                        End If
                    Else
                        NumericBit = True
                    End If

                End If
            End If
        Next

        If NumericBit = True Then
            'strNotSavedValues = strNotSavedValues.Substring(0, strNotSavedValues.Length - 2)
            CommonFunctions.General.WriteHTML("<Script> ")
            CommonFunctions.General.WriteHTML("alert('Non Numeric and Negative Values will not be saved. ');")
            CommonFunctions.General.WriteHTML("</Script>")
        End If

    End Sub

    Private Sub DrawPageHeaderFooter()
        '=====================================================================
        ' Procedure Name        : DrawPageHeaderFooter()	
        ' Purpose               : Plots the Page Header.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : March 11, 2004
        ' Revisions             :
        '=====================================================================
        If Not CommonFunctions.General.IsClientBrowserIE Then
            Dim strHTML As String = ""
            Dim objHeaderFooter As New WebPages.Template.HeaderFooter
            objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.UI_HEADER
            'objHeaderFooter.HeaderFooter = MyBase.GetResourceString("NOTE")
            strHTML = objHeaderFooter.DrawHeaderFooter(, True)
            If strHTML <> "" Then
                CommonFunctions.General.WriteHTML("<BR>" + strHTML + "<BR>")
            End If
        End If
    End Sub

    Private Sub DisplayRateGrid()
        '=====================================================================
        ' Procedure Name        : DisplayRateGrid()	
        ' Purpose               : Plots the Grid of Matrix.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrajaktaR
        ' Created               : Nov 11, 2005
        ' Revisions             :
        '=====================================================================

        Dim strSQLQuery As String = ""
        Dim strSQLQuery1 As String = ""
        Dim strWhereClause As String = ""
        Dim drCostTypes As IDataReader
        Dim strHeader As String
        Dim strHeader1 As String
        Dim strTDStyle As String
        Dim dtEffectiveDate As Date
        Dim strGrid As String

        Dim intRecords As Integer

        strSQLQuery = "EXEC usp_Sel_GradewiseProjectCostType_CostTypewise_Rates " & CType(m_intGradeID, String)
        If m_EffectiveDate <> "" And Not IsNothing(CType(m_EffectiveDate, String)) And Not IsDBNull(CType(m_EffectiveDate, String)) Then

            ''Commented added By Abhijeet K on 4/8/2016 Purpose : Remove Inline Query
            ''strSQLQuery1 = "select EffectiveDate FROM tbl_PM_ProjectCostType_CostType_Grade WHERE CostTypeGradeID = " + m_EffectiveDate 'MyBase.GetFormValue("cboEffectiveDate", True)
            strSQLQuery1 = "usp_sel_tbl_PM_ProjectCostType_CostType_Grade_EffectiveDate " + m_EffectiveDate 'MyBase.GetFormValue("cboEffectiveDate", True)

            dtEffectiveDate = CType(CommonFunctions.Data.GetDataScalar(strSQLQuery1, True), Date)
            strSQLQuery += ", '" + CType(dtEffectiveDate, String) + "'"
        End If

        strHeader = "ProjectCostType "
        'strHeader1 = "Project Cost Type "
        strTDStyle = "align='left' width=140px"
        drCostTypes = CommonFunctions.Data.GetDataReader("usp_sel_CostTypes_forCombo", MyBase.UseSQL)
        While drCostTypes.Read
            intRecords += 1
            strHeader += "," + CType(CommonFunctions.Data.CheckIsDBNull(drCostTypes("CostType"), "0"), String)
            strHeader1 += "," + CType(CommonFunctions.Data.CheckIsDBNull(drCostTypes("CostTypeID"), "0"), String)
            strTDStyle += "," + "align='centre' width=100px"
        End While

        arrUserFriendlyColumnNames = strHeader.Split(CType(",", Char))
        arrActualColumns = strHeader1.Split(CType(",", Char))
        Dim arrstrTDStyle() As String = strTDStyle.Split(CType(",", Char))
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'Set the Advanced Grid Properties
        With m_objGrid
            '.UserFriendlyColumnArray = arrUserFriendlyColumnNames
            .UserFriendlyColumnArray = arrActualColumns
            .ActualColumnArray = arrActualColumns
            .EmptyValueReplacement = "&nbsp;"
            .SQL = strSQLQuery
            .DIVID = "divList"
            .DIVHeight = 400
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intRecords + 1
            .ColNameToolTipOnEachRow = True
            .TDStyleArray = arrstrTDStyle
            .UseSQL = True
            'Added By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            '.DrawGrid()
            strGrid = .DrawGrid
        End With
        Response.Write(strGrid)

        CommonFunction.Data.DisposeDataReader(drCostTypes)

    End Sub

    Private Sub DisplaySelectionHeader()

        Dim strSQLQuery As String
        Dim strSQLQuery1 As String

        Dim strControlValue As String = ""

        Dim objDynamicLink As WebPages.UI.cDynamicLink

        '--- Query for displaying the Projects in Project combo
        strSQLQuery = "EXEC usp_sel_tbl_PM_GradeMaster_Combo "


        '--- Display the Page Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, m_strWindowTitle, , , True))
        CommonFunctions.General.WriteHTML("<BR>")

        WebPages.Template.PageCaption.GetPageCaptions(, "NOTE :- The data displayed is for the Latest EffectiveDate entered for the selected Level.")
        CommonFunctions.General.WriteHTML("<br>")

        '--- Display the Grade combo, dates selection
        CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        '--- Grade Combo
        ''******************
        'If MyBase.IsPostBack = True Then
        '    If Not MyBase.GetFormValue("cboGrade") Is Nothing Then
        '        strControlValue = MyBase.GetFormValue("cboGrade")
        '    Else
        '        strControlValue = ""
        '    End If
        'End If
        ''******************
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td>")
        CommonFunctions.General.WriteHTML("Select Level")
        CommonFunctions.General.WriteHTML("&nbsp;")
        If m_strMode <> MODE_BULKUPDATE Then
            CommonFunctions.HTMLControls.DrawComboBox("cboGrade", strSQLQuery, 120, CType(m_intGradeID, String), "Langugage=JavaScript OnChange=GradeComboChange()", True, , , True)
        Else
            CommonFunctions.HTMLControls.DrawComboBox("cboGrade", strSQLQuery, 120, CType(m_intGradeID, String), " this.disabled=true Langugage=JavaScript OnChange=GradeComboChange()", True, , , True)

        End If
        '--- Effective Date Combo
        strSQLQuery1 = "EXEC usp_sel_Effectivedate_tbl_PM_ProjectCostType_CostType_Grade " + CType(m_intGradeID, String)
        '******************
        If MyBase.IsPostBack = True Then
            'If Not MyBase.GetFormValue("cboEffectiveDate") Is Nothing Then
            If Not m_EffectiveDate Is Nothing Then
                strControlValue = m_EffectiveDate  'MyBase.GetFormValue("cboEffectiveDate")
            Else
                strControlValue = ""
            End If
        End If
        '******************
        If m_strMode <> MODE_BULKUPDATE Then
            CommonFunctions.General.WriteHTML("<td>")
            CommonFunctions.General.WriteHTML("Select Effective Date")
            CommonFunctions.General.WriteHTML("&nbsp;")

            CommonFunctions.HTMLControls.DrawComboBox("cboEffectiveDate", strSQLQuery1, 120, strControlValue, " ", True)
        End If

        CommonFunctions.General.WriteHTML("<td>")
        CommonFunctions.General.WriteHTML("Set Effective Date")
        CommonFunctions.General.WriteHTML("&nbsp;")
        If m_strMode <> MODE_BULKUPDATE Then
            CommonFunctions.HTMLControls.DrawDateControl("dtEffDate", "dtEffDate", FormName:="frmGradeTypeCostType")
        Else
            CommonFunctions.HTMLControls.DrawDateControl("dtEffDate", "dtEffDate", FormName:="frmGradeTypeCostType", isMandatory:=True)
        End If

        '--- Display the Show Link
        'Display the Show Link
        If m_strMode <> MODE_BULKUPDATE Then
            CommonFunctions.General.WriteHTML("<td colspan=2 align=center>")
            objDynamicLink = New WebPages.UI.cDynamicLink
            objDynamicLink.LinkName = "Show"
            objDynamicLink.Tooltip = "Show Values"
            objDynamicLink.FunctionName = "Show_OnClick()"
            objDynamicLink.ReturnHTML = True
            CommonFunctions.General.WriteHTML(" | <B>" + objDynamicLink.GetDynamicLink() + "&nbsp;</B> | ")
            objDynamicLink = Nothing
        End If
        CommonFunctions.General.WriteHTML("</td></tr></Table>")
        'CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader'>The data displayed is for the Latest EffectiveDate entered<BR></tr></table>")
        '        CommonFunctions.General.WriteHTML("<tr><BR></tr></Table>")
        'CommonFunctions.General.WriteHTML("<BR>")

    End Sub

    Public Sub New()
        ''Commented and Added by Yogesh Jalamkar on 10-OCT-2016 Purpose:Sql injection and Cross Site Scripting     
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of addition by Yogesh Jalamkar on 10-OCT-2016 
    End Sub

    Private Sub DrawMenu(ByVal strWhatToShow As String)
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrajaktaR
        ' Created               : Nov 15, 2005
        ' Revisions             :
        '=====================================================================

        Dim arrMenuList As New ArrayList
        Dim arrMenuToolTipList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strGrid As String
        'PrachiK
        'Modified By PrachiK on 15 Feb 2005 for Issue ID=15509. 
        'Purpose: Do not allow user to save changes who is having just "View" Access
        'If m_strMode <> "BulkUpdate" Then
        '    arrMenuList.Add("Bulk Update")
        '    arrMenuToolTipList.Add("Bulk Update")
        '    arrClientSideFunctionList.Add("BulkUpdate_OnClick()")
        'End If
        If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            If m_strMode <> "BulkUpdate" Then
                arrMenuList.Add("Bulk Update")
                arrMenuToolTipList.Add("Bulk Update")
                arrClientSideFunctionList.Add("BulkUpdate_OnClick()")
            Else
                arrMenuList.Add("Back")
                arrMenuToolTipList.Add("Back")
                arrClientSideFunctionList.Add("Back_OnClick()")
            End If

            arrMenuList.Add("Save")
            arrMenuToolTipList.Add("Save")
            arrClientSideFunctionList.Add("Save_OnClick()")
        End If

        arrMenuList.Add("?")
        arrMenuToolTipList.Add("Help")
        arrClientSideFunctionList.Add("Help_OnClick('" + CType(m_lngTagId, String) + "')")

        'Create the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipList), True)
    End Sub

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 18, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Private Sub DisposeObjects()
        '====================================================================
        ' Procedure Name        : DisposeObjects
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Dispose all the objects
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        m_objMenu = Nothing
        m_objGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing

    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint


        Dim strValue As Double
        Dim strName As String
        Dim strPCTName As String
        Dim strID As String
        Dim m_indchar As Integer

        If Args.ColumnName <> "ProjectCostType" Then
            If m_strMode = "BulkUpdate" Then

                Cancel = True
                strName = Args.ColumnName
                strPCTName = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectCostType"), ""), String).Trim
                strValue = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataFieldValue, "0"), Double)
                strID = "txt_" + strPCTName + "_" + strName
                Args.StringToBeInserted += "<td>"
                'Args.StringToBeInserted = "<td><Input Type=Textbox id='" + strID + " class='clsTextBox' style='width:50px'  maxlength=5 style='text-align:right' name='" + strID + "' value='" + CType(strValue, String) + "' ></td>"
                'Args.StringToBeInserted = "<td><Input Type=Textbox id='" + strID + " class='clsTextBox' name='" + strID + "' value='" + CType(strValue, String) + "' ></td>"
                'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox(strID, strID, , 45, 5, CType(strValue, String), "Right", , , , , , " ", True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                Args.StringToBeInserted += "</td>"
                strTextIDs = strTextIDs + strID + "|"
            Else

                Cancel = True
                strName = Args.ColumnName
                strPCTName = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectCostType"), ""), String).Trim
                strValue = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataFieldValue, "0"), Double)

                If strValue <> 0 Then
                    strID = "lnk_" + strPCTName + "_" + strName
                    'Args.StringToBeInserted += "<td width = 100px align = 'right'>"
                    Args.StringToBeInserted += "<td>"
                    Args.StringToBeInserted += "<a style='text-align:Right;width:50px' href=""javascript:GetCostType('" + strID + "')""><b>" + CType(strValue, String) + "</b></a>"
                    'ARGS.StringToBeInserted +=
                    Args.StringToBeInserted += "</td>"

                Else
                    strID = "txt_" + strPCTName + "_" + strName
                    'Args.StringToBeInserted += "<td>"
                    'Args.StringToBeInserted = "<td><Input Type=Textbox id='" + strID + " class='clsTextBox' style='width:50px'  maxlength=5 style='text-align:right' style='FONT-SIZE: 8pt' style='Font(-FAMILY) : Verdana(, Arial)'  name='" + strID + "' value='" + CType(strValue, String) + "' ></td>"
                    'Args.StringToBeInserted = "<td><Input Type=Textbox id='" + strID + " class='clsTextBox' name='" + strID + "' value='" + CType(strValue, String) + "' ></td>"
                    Args.StringToBeInserted += "<td>"
                    'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox(strID, strID, , 45, 5, CType(strValue, String), "Right", , , , , , " ", True, EnableHTMLEncode:=True)
                    'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    Args.StringToBeInserted += "</td>"
                    strTextIDs = strTextIDs + strID + "|"
                End If
            End If
        Else
            Cancel = True
            Dim strProjectCostType As String
            Dim strSql As String
            ''Commented added By Abhijeet K on 4/8/2016 Purpose : Remove Inline Query
            ''strSql = "SELECT ProjectCostType FROM tbl_CNF_ProjectCostType WHERE ProjectCostTypeID = " + CType(Args.DataFieldValue, String)
            strSql = "usp_sel_tbl_CNF_ProjectCostType_ProjectCostType " + CType(Args.DataFieldValue, String)

            strProjectCostType = CType(CommonFunctions.Data.GetDataScalar(strSql, True), String)
            Args.StringToBeInserted = "<td>" + strProjectCostType + "</td>"
        End If

    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If Args.ColumnName <> "ProjectCostType" Then
            Cancel = True
            Dim strCostType As String
            Dim strSql As String

            ''Commented added By Abhijeet K on 4/8/2016 Purpose : Remove Inline Query
            ''strSql = "SELECT CostType FROM tbl_CNF_CostType WHERE CostTypeID = " + Args.ColumnName
            strSql = "usp_sel_tbl_CNF_CostType_CostType " + Args.ColumnName

            strCostType = CType(CommonFunctions.Data.GetDataScalar(strSql, True), String)
            Args.StringToBeInserted = "<td>" + strCostType + "</td>"

        Else
            Cancel = True
            Args.StringToBeInserted = "<td>Project Cost Type</td>"
        End If
    End Sub
End Class

