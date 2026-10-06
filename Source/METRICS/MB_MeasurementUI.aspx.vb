Imports Whizible

Public Class MB_MeasurementUI
    'Inherits Metrics.WebPage.Templates.ProjectByNetTemplate
    Inherits WebPage.Templates.WhizTemplate

    'Protected m_strMode As String = "LIST"
    Protected m_strMode As String = "NEW"
    Protected m_intShowInvalidFormulaMsg As Integer = 0
    Protected m_intCounterI As Integer
    Protected m_lngFormulaID As Long = 0
    Protected m_lngEntityID As Long = 0
    Protected m_strSortBy As String = "CreateDate"
    Protected m_strSortOrder As String = "DESC"
    Protected m_strAlphabet As String = "-1"
    Protected m_intTotalRows As Integer = 0

    Protected m_arrText() As String = {}
    Protected m_arrValue() As String = {}
    Protected m_arrValidInputs() As String = {}
    Protected m_arrDataType() As String = {}
    Protected m_arrAttributeID() As Long = {}

    Protected m_arrFormulaID() As Long = {}
    Protected m_arrFormulaUsers() As String = {}
    Protected m_blnQueryUsesOracleDB As Boolean = False

    Protected m_strInvalidFormulaNameMsg As String = ""
    Protected m_strInvalidFormulaMsg As String = ""
    Protected m_strFormulasCannotBeDeletedMsg As String = ""

    Private m_arrFormulasInUse() As Long = {}

    Private m_strEntityName As String = ""
    Private m_strUserFriendlyEntityName As String = ""

    Private m_lngEmployeeID As Long
    Private m_strLoginType As String = "E"
    Private m_strUserName As String

    Private m_strAction As String
    Private m_blnUseSQL As Boolean

    Private m_strConnectionString As String = ""
    Private m_lngConnectionID As Long = 0

    Private m_strValidationResult As String = ""
    Private m_strExecutionResultGRID As String = ""

    Protected m_intMetricID As Integer
    'Foursoft
    Protected m_intProjectID As Integer
    Protected m_strUDFormula As String
    Protected m_blnValidStatus As Boolean = False
    Protected m_CorporateLevelMB As String = ""

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Public Sub New()
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
        ''Commented and Added by Yogesh Jalamkar on 10-OCT-2016 Purpose:Sql injection and Cross Site Scripting
        ' MyBase.ApplySecurity(False, 2)
        MyBase.ApplySecurity(True, 2)
        ''End of addition by Yogesh Jalamkar on 10-OCT-2016 

    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub


    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the module variables here
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : module variables
        '=====================================================================
        Dim dr As IDataReader

        ''Metric ID
        'If Not HttpContext.Current.Request.QueryString("MetricID") Is Nothing Then
        '    m_intMetricID = CType(HttpContext.Current.Request.QueryString("MetricID"), Integer)
        'ElseIf Not HttpContext.Current.Request("MetricID") Is Nothing Then
        '    m_intMetricID = CType(HttpContext.Current.Request("MetricID").ToString(), Integer)
        'End If


        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MetricID"), "0") <> "0" Then
            If HttpContext.Current.Request.QueryString("MetricID") = "" Then
                m_intMetricID = 0
            Else
                m_intMetricID = CType(HttpContext.Current.Request.QueryString("MetricID"), Integer)
            End If
        Else
            m_intMetricID = 0
        End If

        If Not HttpContext.Current.Request.QueryString("CorporateLevelMB") Is Nothing Then
            m_CorporateLevelMB = CType(HttpContext.Current.Request.QueryString("CorporateLevelMB"), String)
        End If


            ' entity id
            If Not HttpContext.Current.Request.QueryString("EntityID") Is Nothing Then
                m_lngEntityID = CType(HttpContext.Current.Request.QueryString("EntityID"), Long)
            End If

            ' formula id
            If Not HttpContext.Current.Request.QueryString("FormulaID") Is Nothing Then
                m_lngFormulaID = CType(HttpContext.Current.Request.QueryString("FormulaID"), Long)
            End If

            ' mode of the page
            If Not HttpContext.Current.Request.QueryString("Mode") Is Nothing Then
                m_strMode = HttpContext.Current.Request.QueryString("Mode").ToString
            End If

            ' Action of the page
            If Not HttpContext.Current.Request.QueryString("Action") Is Nothing Then
                m_strAction = HttpContext.Current.Request.QueryString("Action").ToString
            Else
                m_strAction = ""
            End If

            If Not HttpContext.Current.Request.QueryString("sortby") Is Nothing Then
                m_strSortBy = HttpContext.Current.Request.QueryString("sortby").ToString
            End If
            If Not HttpContext.Current.Request.QueryString("sortorder") Is Nothing Then
                m_strSortOrder = HttpContext.Current.Request.QueryString("sortorder").ToString
            End If

            If Not HttpContext.Current.Request.QueryString("Alphabet") Is Nothing Then
                m_strAlphabet = HttpContext.Current.Request.QueryString("Alphabet").ToString
            Else
                m_strAlphabet = "-1"
            End If
            'Foursoft
            'If Not HttpContext.Current.Request.QueryString("ProjectID") Is Nothing Then
            '    m_intProjectID = CType(HttpContext.Current.Request.QueryString("ProjectID"), Integer)
            'ElseIf Not HttpContext.Current.Request("MetricID") Is Nothing Then
            '    m_intProjectID = 0
            'End If
            If Not Session("intProjectID") Is Nothing Then
                m_intProjectID = CType(Session("intProjectID").ToString, Integer)
            Else
                m_intProjectID = 0
            End If


        'MrugajaB

        ' If Not HttpContext.Current.Request.QueryString("NewUDFormula") Is Nothing Then
        If m_strAction.ToUpper <> "VALIDATE" Then
            'Foresoft Customiczation
            Dim strSqlQuery As String
            'Dim strSqlQuery As String = "SELECT UDFormula FROM tbl_MET_Metricmaster WHERE MetricID=" & m_intMetricID
            If (m_CorporateLevelMB = "1" Or m_CorporateLevelMB.ToUpper = "CORPORATELEVELMB") And m_intMetricID <> 0 Then
                strSqlQuery = "SELECT NewUDFormula FROM tbl_MET_Metricmaster WHERE MetricID=" & m_intMetricID
            ElseIf m_CorporateLevelMB = "0" And m_intMetricID <> 0 Then
                strSqlQuery = "If Exists(SELECT NewUDFormula FROM tbl_MET_Metric_Project_BreakUp_Mapping WHERE MetricID=" & m_intMetricID & " ) "
                strSqlQuery = strSqlQuery + " SELECT NewUDFormula FROM tbl_MET_Metric_Project_BreakUp_Mapping WHERE MetricID=" & m_intMetricID
                strSqlQuery = strSqlQuery + " Else Select '' "
            End If

            'm_strUDFormula = HttpContext.Current.Request.QueryString("UDFormula").ToString
            If m_intMetricID = 0 Then
                m_strUDFormula = ""
            Else
                m_strUDFormula = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), "")
            End If
            m_strMode = "EDIT"
        ElseIf Not HttpContext.Current.Request("txtFormula") Is Nothing Then
        m_strUDFormula = HttpContext.Current.Request("txtFormula").ToString
        End If


        'End Addition

        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = HttpContext.Current.Session("strUserName").ToString
        m_strLoginType = HttpContext.Current.Session("LoginType").ToString
        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)


        ' get the connection properties to be used
        m_lngConnectionID = GetConnectionID(m_lngEntityID)

        m_strConnectionString = GetConnectionString(m_lngConnectionID, m_blnQueryUsesOracleDB, m_blnUseSQL)

        ' populate the attribute array--> these arrays are used across the page
        Call PopulateAttributeArrays(m_lngEntityID, m_strUserName, m_strLoginType, m_blnUseSQL)
        Call PopulateUsedFormulaArray(m_lngEntityID)

        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_QRB_DataDictionary_Master " & m_lngEntityID, m_blnUseSQL)
        If dr.Read Then
            m_strUserFriendlyEntityName = CommonFunctions.Data.CheckIsDBNull(dr("UserFriendlyEntityName").ToString)
            m_strEntityName = CommonFunctions.Data.CheckIsDBNull(dr("EntityName").ToString)
        End If
        CloseDataReader(dr)
    End Sub

    Private Sub PerformActions()
        '=====================================================================
        ' Procedure Name        : PerformActions()	
        ' Purpose               : To perform the actions on the page
        ' Description           : The settings are saved for actions SAVE/VALIDATE
        ' Parameters Passed     : ByVal DashboardID As Long, ByVal UseSQL As Boolean
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String
        Dim strFormulasInUse As String

        Dim strFormula As String
        Dim strActualFormula As String
        Dim strFormulaName As String
        Dim strDescription As String

        strFormula = Replace(Replace(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("txtFormula")), Chr(10), ""), Chr(13), "")
        strDescription = MyBase.GetFormValue("txtDescription")
        strActualFormula = BuildActualFormula(strFormula)
        strFormulaName = MyBase.GetFormValue("txtFormulaName")

        Select Case Trim(m_strAction & "").ToUpper
            Case "VALIDATE"
                'Call ValidateFormula(strActualFormula, m_strValidationResult)
                Call ValidateFormula(strFormula, m_strValidationResult)
            Case "EXECUTE"
                ' execute the formula and display the result set
                If ValidateFormula(strActualFormula, m_strValidationResult) = True Then

                    m_strValidationResult = ""
                    If m_blnQueryUsesOracleDB Then
                        strActualFormula = "(" + strActualFormula + ") As " + Replace(strFormulaName, " ", "") + ""
                    Else
                        strActualFormula = "(" + strActualFormula + ") As [" + strFormulaName + "]"
                    End If

                    strSQL = "SELECT " & strActualFormula & " FROM " & m_strEntityName & " ORDER BY 1 DESC"
                    m_strExecutionResultGRID = GetExecutionResultsGrid(strSQL, strFormulaName)
                End If

            Case "DELETE"
                If Trim(HttpContext.Current.Request("chkDelete") & "") <> "" Then
                    ' Query to delete the formulae
                    strSQL = "Exec usp_QRB_Del_Formula_Master  '" & HttpContext.Current.Request("chkDelete") & "'"
                    dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                    strFormulasInUse = ""
                    Do While dr.Read
                        strFormulasInUse += dr("FormulaName").ToString + ","
                    Loop
                    CloseDataReader(dr)
                    If Trim(strFormulasInUse & "") <> "" Then
                        strFormulasInUse = Left(strFormulasInUse, Len(strFormulasInUse) - 1)
                        m_strFormulasCannotBeDeletedMsg = "Formula(s) " + strFormulasInUse
                        m_strFormulasCannotBeDeletedMsg += " are in use and cannot be deleted!"
                    Else
                        m_strFormulasCannotBeDeletedMsg = ""
                    End If
                End If
            Case Else

        End Select

    End Sub

    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To write the page 
        ' Description           : same as above
        ' Parameters Passed     : 
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        '=====================================================================
        Dim dr As IDataReader
        Dim drFormulaUsers As IDataReader
        Dim strMenu As String
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../Images/star.gif'>"}

        Dim strFormulaName As String = ""
        Dim strFormula As String = ""
        Dim strDescription As String = ""

        Dim intCounter As Integer
        Dim intUpperBound As Integer
        Dim blnEnable As Boolean = True

        MyBase.InitializeResources("AppResourcePPM.MB_MeasurementUI", "AppResourcePPM")

        Dim objGrid As WebPage.Templates.GenericGrid
        Dim arrAttributesAN() As String = {"FormulaName", "CreateDate", "UserFriendlyFormulaValue", ""}
        Dim arrAttributesUFN() As String = {MyBase.GetResourceString("FORMULA_NAME"), MyBase.GetResourceString("CREATED_ON"), MyBase.GetResourceString("FORMULA"), MyBase.GetResourceString("DELETE")}
        Dim arrDelete() As String = {"", "", "", "chkDelete"}
        Dim arrRowLink() As String = {"Formula_OnClick(FormulaID)"}
        Dim strSQL As String = ""

        With Response
            ' menu
            .Write(GetMenu(False))

            'legends    
            WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend)

            MyBase.InitializeResources("AppResourcePPM.MB_MeasurementUI", "AppResourcePPM")

            ' page caption 
            WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("FORMULA_BUILDER"))
            .Write("<BR>" + vbCrLf)

            Select Case UCase(Trim(m_strMode & ""))
                Case "LIST"

                Case "NEW", "EDIT"
                    ' create/edit a formula
                    If Trim(m_strValidationResult & "") <> "" Then
                        .Write("<TABLE class=clsTable width='100%' cellpadding=0 cellspacing=0 border=1 bordercolor=black>")
                        .Write("<TR class=clsTROdd><TD align=center>")
                        .Write(m_strValidationResult)
                        .Write("</TD></TR>")
                        .Write("</TABLE>")
                    End If
                    m_strValidationResult = ""

                    If Trim(m_strExecutionResultGRID & "") <> "" Then
                        .Write(m_strExecutionResultGRID)
                    End If
                    m_strExecutionResultGRID = ""

                    ' for "execute" and "validate" requests showing the latest formula so that the user
                    ' doesnt lose his changes 
                    If UCase(Trim(m_strAction & "")) = "" Then
                        If UCase(Trim(m_strMode & "")) = "EDIT" Then
                            ' Getting the formula value from database for previously saved formulae			
                            dr = CommonFunctions.Data.GetDataReader("usp_QRB_GetFormulaDetails  " & m_lngFormulaID, m_blnUseSQL)
                            If dr.Read Then
                                strFormula = dr("UserFriendlyFormulaValue").ToString
                                strFormulaName = dr("FormulaName").ToString
                                strDescription = dr("FormulaDescription").ToString
                            End If
                            CloseDataReader(dr)
                        End If
                    Else
                        strFormulaName = MyBase.GetFormValue("txtFormulaName")
                        strFormula = MyBase.GetFormValue("txtFormula")
                        strDescription = MyBase.GetFormValue("txtDescription")
                    End If

                    ' Checking the formula use
                    If m_strMode = "EDIT" Then
                        ' In edit mode if the formula is in use disabling the formula name
                        blnEnable = True
                        intUpperBound = UBound(m_arrFormulasInUse)
                        For intCounter = 0 To intUpperBound
                            If m_lngFormulaID = m_arrFormulasInUse(intCounter) Then
                                blnEnable = False
                                Exit For
                            End If
                        Next ' intCounter
                    Else
                        ' Add new mode the text box for formula name is enabled
                        blnEnable = True
                    End If

                    With Response
                        .Write("<DIV id=divList style='overflow:auto;height:100'>")
                        .Write("<Table class=clsTable width='100%' cellpadding=0 cellspacing=0 >" & vbCrLf)
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        ' line 
                        DrawLine("black", 3)


                        ' The combo box with the accessible attributes
                        .Write("<Tr class=clsTrEven >" & vbCrLf)
                        .Write("<td width='15%'  align=left></td>")

                        .Write("<Td   align=left colspan=2>" & vbCrLf)
                        .Write(MyBase.GetResourceString("ATTRIBUTE"))
                        .Write("&nbsp;<select class='clsComboBox' name='cboAttributes' id='cboAttributes'>")
                        ' The upper bound of the attribute array
                        intUpperBound = UBound(m_arrText)
                        For intCounter = 0 To intUpperBound
                            .Write("<option value='" & Server.HtmlEncode(m_arrValue(intCounter) & "") & "'>" & Server.HtmlEncode(m_arrText(intCounter) & "") & "</option>")
                        Next
                        .Write("</select>")
                        .Write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")

                        .Write("Function ")
                        ' Combo of functions 
                        CommonFunctions.HTMLControls.DrawComboBox("cboFunction", "usp_sel_QRB_Functions", 0, , , True)


                        ' "Append" Link to append the attribute and the function applied to it
                        .Write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='JavaScript:Append_OnClick()'><font size='1' title='" & MyBase.GetResourceString("APPEND_TOOLTIP") & " ' Style='TEXT-DECORATION:None'>")
                        .Write("<font size='1' face='verdana' color='black' Style='TEXT-DECORATION:None'>")
                        .Write("<b>|&nbsp;" & MyBase.GetResourceString("APPEND") & "&nbsp;</b>")
                        .Write("</font>")
                        .Write("</a>")

                        ' "Clear" Link
                        .Write("<a href='JavaScript:Clear_OnClick()'><font size='1' title='" & MyBase.GetResourceString("CLEAR_TOOLTIP") & "  ' Style='TEXT-DECORATION:None'>")
                        .Write("<font size='1' face='verdana' color='black' Style='TEXT-DECORATION:None'>")
                        .Write("<b>|&nbsp;" & MyBase.GetResourceString("CLEAR") & "&nbsp;|</b>")
                        .Write("</font>")
                        .Write("</a>")

                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        .Write("<Td  width='15%'>" & vbCrLf)

                        ' Displaying the insetable operators 
                        .Write("<Table width='100%'bgColor=black cellpadding=1 cellspacing=1>" & vbCrLf)

                        ' "+" operator
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & Chr(34) & "+" & Chr(34) & ")'>" & vbCrLf)
                        '.Write("<a class='Menu' style='TEXT-DECORATION:NONE' Title='+' href='JavaScript:Operator_OnClick(" & Chr(34) & "+" & Chr(34) & ")'><font size='1' title='PLUS...' Style='TEXT-DECORATION:None'>")
                        .Write("<font size='2' face='verdana' color='black' >")
                        .Write("<b>&nbsp;&nbsp;&nbsp;&nbsp;+&nbsp;</b>")
                        .Write("</font>")
                        '.Write("</a>")
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        ' "-" operator
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & Chr(34) & "-" & Chr(34) & ")'>" & vbCrLf)
                        '.Write("<a class='Menu' style='TEXT-DECORATION:NONE'><font size='1' title='MINUS..' Style='TEXT-DECORATION:None'>")
                        .Write("<font size='2' face='verdana' color='black' >")
                        .Write("<b>&nbsp;-&nbsp;</b>")
                        .Write("</font>")
                        '.Write("</a>")
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        ' "/" operator
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & Chr(34) & "/" & Chr(34) & ")'>" & vbCrLf)
                        '.Write("<a class='Menu' style='TEXT-DECORATION:NONE'><font size='1' title='DIVIDE...' Style='TEXT-DECORATION:None'>")
                        .Write("<font size='2' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
                        .Write("<b>&nbsp;/&nbsp;</b>")
                        .Write("</font>")
                        '.Write("</a>")
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        ' "*" operator
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & Chr(34) & "*" & Chr(34) & ")'>" & vbCrLf)
                        '.Write("<a class='Menu' style='TEXT-DECORATION:NONE'><font size='1' title='MULTIPLY...' Style='TEXT-DECORATION:None'>")
                        .Write("<font size='2' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
                        .Write("<b>&nbsp;*&nbsp;</b>")
                        .Write("</font>")
                        '.Write("</a>")
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        '"<" Operator
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & Chr(34) & "<" & Chr(34) & ")'>" & vbCrLf)
                        .Write("<font size='2' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
                        .Write("<b>&nbsp;<&nbsp;</b>")
                        .Write("</font>")
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        '">" Operator
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & Chr(34) & ">" & Chr(34) & ")'>" & vbCrLf)
                        .Write("<font size='2' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
                        .Write("<b>&nbsp;>&nbsp;</b>")
                        .Write("</font>")
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        '"=" Operator
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & """=""" & ")'>" & vbCrLf)
                        .Write("<font size='2' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
                        .Write("<b>&nbsp;=&nbsp;</b>")
                        .Write("</font>")
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        '"." Operator
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & """.""" & ")'>" & vbCrLf)
                        .Write("<font size='2' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
                        .Write("<b>&nbsp;.&nbsp;</b>")
                        .Write("</font>")
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)


                        ' "(" 
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & Chr(34) & "(" & Chr(34) & ")'>" & vbCrLf)
                        '.Write("<a href='JavaScript:Operator_OnClick(" & Chr(34) & "(" & Chr(34) & ")'><font size='1' title='Appends (...' Style='TEXT-DECORATION:None'>")
                        .Write("<font size='1' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
                        .Write("<b>&nbsp;(&nbsp;</b>")
                        .Write("</font>")
                        '.Write("</a>")
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        ' ")" 
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & Chr(34) & ")" & Chr(34) & ")'>" & vbCrLf)
                        '.Write("<a href='JavaScript:Operator_OnClick(" & Chr(34) & ")" & Chr(34) & ")'><font size='1' title='Appends )...' Style='TEXT-DECORATION:None'>")
                        .Write("<font size='1' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
                        .Write("<b>&nbsp;)&nbsp;</b>")
                        .Write("</font>")
                        '.Write("</a>")
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        .Write("</Table>" & vbCrLf)

                        .Write("</Td>" & vbCrLf)

                        .Write("<Td  width='70%'>" & vbCrLf)

                        ' The Actual Formula
                        .Write("<Table class=clsTable width='100%' cellpadding=0 cellspacing=0>" & vbCrLf)
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        .Write("<Td  WIDTH='100%' RowSpan=7>" & vbCrLf)
                        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                        'CommonFunctions.HTMLControls.DrawTextArea("txtFormula", "txtFormula", , , , "frmFormulaBuilder", , , 500, 150, 2000, m_strUDFormula, , , , , , , " onkeypress='javascript:txtFormula_OnKeyPress()' ", , True)
                        CommonFunctions.HTMLControls.DrawTextArea("txtFormula", "txtFormula", , , , "frmFormulaBuilder", , , 500, 150, 2000, m_strUDFormula, , , , , , , " onkeypress='javascript:txtFormula_OnKeyPress()' ", , True, EnableHTMLEncode:=True)
                        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)
                        .Write("</Table>" & vbCrLf)

                        '-----------------------------------------------------
                        ' Displaying the date functions & case
                        .Write("<Td  width='15%'>" & vbCrLf)
                        .Write("<Table width='100%'bgColor=black cellpadding=1 cellspacing=1>" & vbCrLf)

                        ' "DateDiff() in days" function
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        If m_blnQueryUsesOracleDB Then
                            .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue'>" & vbCrLf)
                            .Write("<font size='1' title='" & MyBase.GetResourceString("DATEDIFF_DAYS_TOOLTIP") & "' Style='TEXT-DECORATION:None'>")
                            .Write("<font size='1' face='verdana' color='gray' style='BACKGROUND-COLOR: aliceblue'>")
                            .Write("<b>&nbsp;" & MyBase.GetResourceString("DATEDIFF_DAYS") & "&nbsp;</b>")
                            .Write("</font>")
                        Else
                            .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & Chr(34) & "DateDiff(dd," & Chr(34) & ")'>" & vbCrLf)
                            '.Write("<a class='Menu' style='TEXT-DECORATION:NONE'><font size='1' title='" & MyBase.GetResourceString("DATEDIFF_DAYS_TOOLTIP") & "' Style='TEXT-DECORATION:None'>")
                            .Write("<font size='1' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
                            .Write("<b>&nbsp;" & MyBase.GetResourceString("DATEDIFF_DAYS") & "&nbsp;</b>")
                            .Write("</font>")
                            '.Write("</a>")
                        End If
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        ' "DateDiff() in months" function
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        If m_blnQueryUsesOracleDB Then
                            .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue'>" & vbCrLf)
                            .Write("<font size='1' title='" & MyBase.GetResourceString("DATEDIFF_DAYS_TOOLTIP") & "' face='verdana' color='gray' style='BACKGROUND-COLOR: aliceblue'>")
                            .Write("<b>&nbsp;" & MyBase.GetResourceString("DATEDIFF_MONTHS") & "&nbsp;</b>")
                            .Write("</font>")
                        Else
                            .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & Chr(34) & "DateDiff(mm," & Chr(34) & ")'>" & vbCrLf)
                            '.Write("<a href='JavaScript:Operator_OnClick(" & Chr(34) & "DateDiff(mm," & Chr(34) & ")'><font size='1' title='" & MyBase.GetResourceString("DATEDIFF_MONTHS_TOOLTIP") & "' Style='TEXT-DECORATION:None'>")
                            .Write("<font size='1' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
                            .Write("<b>&nbsp;" & MyBase.GetResourceString("DATEDIFF_MONTHS") & "&nbsp;</b>")
                            .Write("</font>")
                            '.Write("</a>")
                        End If
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        ' "DateDiff() in years" function
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        If m_blnQueryUsesOracleDB Then
                            .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue'>" & vbCrLf)
                            .Write("<font size='1' title='" & MyBase.GetResourceString("DATEDIFF_DAYS_TOOLTIP") & "' face='verdana' color='gray' style='BACKGROUND-COLOR: aliceblue'>")
                            .Write("<b>&nbsp;" & MyBase.GetResourceString("DATEDIFF_YEARS") & "&nbsp;</b>")
                            .Write("</font>")
                        Else
                            .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & Chr(34) & "DateDiff(yy," & Chr(34) & ")'>" & vbCrLf)
                            '.Write("<a href='JavaScript:Operator_OnClick(" & Chr(34) & "DateDiff(yy," & Chr(34) & ")'><font size='1' title='" & MyBase.GetResourceString("DATEDIFF_YEARS_TOOLTIP") & "' Style='TEXT-DECORATION:None'>")
                            .Write("<font size='1' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
                            .Write("<b>&nbsp;" & MyBase.GetResourceString("DATEDIFF_YEARS") & "&nbsp;</b>")
                            .Write("</font>")
                            '.Write("</a>")
                        End If
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        ' "GetDate() -> Current date" 
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        If m_blnQueryUsesOracleDB Then
                            .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue'>" & vbCrLf)
                            .Write("<font size='1' title='" & MyBase.GetResourceString("DATEDIFF_DAYS_TOOLTIP") & "' face='verdana' color='gray' style='BACKGROUND-COLOR: aliceblue'>")
                            .Write("<b>&nbsp;" & MyBase.GetResourceString("CURRENT_DATE") & "&nbsp;</b>")
                            .Write("</font>")
                        Else
                            .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & Chr(34) & "GetDate()" & Chr(34) & ")'>" & vbCrLf)
                            '.Write("<a href='JavaScript:Operator_OnClick(" & Chr(34) & "GetDate()" & Chr(34) & ")'><font size='1' title='" & MyBase.GetResourceString("CURRENT_DATE_TOOLTIP") & "' Style='TEXT-DECORATION:None'>")
                            .Write("<font size='1' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
                            .Write("<b>&nbsp;" & MyBase.GetResourceString("CURRENT_DATE") & "&nbsp;</b>")
                            .Write("</font>")
                            '.Write("</a>")
                        End If
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        ' "CASE" 
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        If Not m_blnQueryUsesOracleDB Then
                            .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & Chr(34) & "CASE" & Chr(34) & ")'>" & vbCrLf)
                            .Write("<font size='1' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
                            .Write("<b>&nbsp;" & CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("CAP_CASE"), "CASE") & "&nbsp;</b>")
                            .Write("</font>")
                            '.Write("</a>")
                        End If
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        ' "WHEN" 
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        If Not m_blnQueryUsesOracleDB Then
                            .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & Chr(34) & "WHEN" & Chr(34) & ")'>" & vbCrLf)
                            .Write("<font size='1' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
                            .Write("<b>&nbsp;" & CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("CAP_WHEN"), "WHEN") & "&nbsp;</b>")
                            .Write("</font>")
                        End If
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        ' "THEN" 
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        If Not m_blnQueryUsesOracleDB Then
                            .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & Chr(34) & "THEN" & Chr(34) & ")'>" & vbCrLf)
                            .Write("<font size='1' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
                            .Write("<b>&nbsp;" & CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("CAP_THEN"), "THEN") & "&nbsp;</b>")
                            .Write("</font>")
                            '.Write("</a>")
                        End If
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        ' "ELSE" 
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        If Not m_blnQueryUsesOracleDB Then
                            .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & Chr(34) & "ELSE" & Chr(34) & ")'>" & vbCrLf)
                            .Write("<font size='1' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
                            .Write("<b>&nbsp;" & CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("CAP_ELSE"), "ELSE") & "&nbsp;</b>")
                            .Write("</font>")
                            '.Write("</a>")
                        End If
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        ' "END" 
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        If Not m_blnQueryUsesOracleDB Then
                            .Write("<Td  WIDTH='100%' VAlign=top align=right style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & Chr(34) & "END" & Chr(34) & ")'>" & vbCrLf)
                            .Write("<font size='1' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
                            .Write("<b>&nbsp;" & CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("CAP_END"), "END") & "&nbsp;</b>")
                            .Write("</font>")
                            '.Write("</a>")
                        End If
                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        .Write("</Table>" & vbCrLf)

                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)
                        '-----------------------------------------------------
                        ' The numerics
                        .Write("<Tr class=clsTrEven>" & vbCrLf)
                        .Write("<td  width='15%'></td>")
                        .Write("<Td  width='20%'align=right colspan=2 VAlign=Top>" & vbCrLf)

                        .Write("<Table  width='100%' bgcolor=black cellpadding=1 cellspacing=1>" & vbCrLf)
                        .Write("<Tr class=clsTrEven>" & vbCrLf)

                        For intCounter = 0 To 9
                            .Write("<Td  WIDTH='10%'  VAlign=top align=center style='BACKGROUND-COLOR: aliceblue' onclick='JavaScript:Operator_OnClick(" & Chr(34) & intCounter & Chr(34) & ")'>" & vbCrLf)
                            '.Write("<a href='JavaScript:Operator_OnClick(" & Chr(34) & intCounter & Chr(34) & ")'><font size='1' title='Appends " & intCounter & "...' Style='TEXT-DECORATION:None'>")
                            .Write("<font size='1' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
                            .Write("<b>&nbsp;" & intCounter & "&nbsp;</b>")
                            .Write("</font>")
                            '.Write("</a>")
                            .Write("</Td>" & vbCrLf)
                        Next ' intCounter	

                        .Write("</Tr>" & vbCrLf)
                        .Write("</Table>" & vbCrLf)

                        .Write("</Td>" & vbCrLf)
                        .Write("</Tr>" & vbCrLf)

                        ' line 
                        DrawLine("black", 3)

                        .Write("<tr class=clsTrEven><td colspan=3 align=center>")
                        .Write(MyBase.GetResourceString("NOTE"))
                        .Write("</td></tr>")
                        '--------------------------------------------
                        .Write("<Tr><TD align=center colspan=3>" & vbCrLf)
                        .Write("<div id=divBar style='width=100;height=11px;DISPLAY: none; BORDER-TOP-STYLE: double; BORDER-RIGHT-STYLE: double; BORDER-LEFT-STYLE: double; BACKGROUND-COLOR: transparent; BORDER-BOTTOM-STYLE: double'>")
                        .Write("<marquee  direction=right>")
                        .Write("<img align=middle src='..\..\Images\Bar.bmp'>")
                        .Write("</marquee></div>")
                        .Write("</TD></Tr>" & vbCrLf)
                        '--------------------------------------------
                        .Write("</Table>" & vbCrLf)

                        .Write("</div>" & vbCrLf)

                    End With
                Case Else
                    ' do nothing
            End Select

            If m_strAction <> "VALIDATE" Then
                CommonFunctions.General.WriteHTML(" <Script Language=javascript>")
                CommonFunctions.General.WriteHTML(" var objtxtFormula1 = GetObjectReference('frmFormulaBuilder','txtFormula'); ")
                CommonFunctions.General.WriteHTML("objtxtFormula1.value = window.opener.frmCommonPage.NewUDFormula.value;")
                CommonFunctions.General.WriteHTML("</Script>")
            End If

            'if mode is save then update formula value at parent form control
            If m_blnValidStatus = True Then
                CommonFunctions.General.WriteHTML(" <Script Language=javascript>")
                'CommonFunctions.General.WriteHTML(" var objtxtFormula1 = GetObjectReference('frmFormulaBuilder','txtFormula')")
                'CommonFunctions.General.WriteHTML(" if(objtxtFormula1 != null){")
                'CommonFunctions.General.WriteHTML(" if(window.opener.frmCommonPage.UDFormula != null){")
                'CommonFunction.General.WriteHTML("window.opener.frmCommonPage.UDFormula.value=objtxtFormula1.value;")
                CommonFunctions.General.WriteHTML(" var objtxtFormula1 = GetObjectReference('frmFormulaBuilder','txtFormula')")
                CommonFunctions.General.WriteHTML(" if(objtxtFormula1 != null){")
                CommonFunctions.General.WriteHTML(" if(window.opener.frmCommonPage.NewUDFormula != null){")
                CommonFunction.General.WriteHTML("window.opener.frmCommonPage.NewUDFormula.value=objtxtFormula1.value;")
                CommonFunctions.General.WriteHTML(" }}")

                CommonFunctions.General.WriteHTML("</Script>")
            End If
            ' menu
            .Write(GetMenu(True))
        End With

    End Sub

    Private Function GetExecutionResultsGrid(ByVal strSQL As String, ByVal strFormulaName As String) As String
        '=====================================================================
        ' Procedure Name        : GetExecutionResultsGrid()	
        ' Purpose               : To get the execution result grid 
        ' Description           : same as above
        ' Parameters Passed     : SQL, Formula Name
        ' Returns               : string of execution result
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        '=====================================================================
        Dim objGrid As WebPage.Templates.GenericGrid
        Dim arrAttributesUFN() As String = {strFormulaName}
        Dim arrTDStyle() As String = {" align=right "}
        objGrid = New WebPage.Templates.GenericGrid

        ''''Added By Vaijat K On 06/10/2015
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''''End Added By Vaijat K On 06/10/2015
        With objGrid
            .UserFriendlyColumnArray = arrAttributesUFN
            .DIVHeight = 150 : .DIVID = "divResult" : .DIVStyle = "overflow:auto"
            .NoOfDataColumns = 1
            .PrinterFriendlyVersion = False : .VerticalDisplay = False
            .SQL = strSQL
            .ColNameToolTipOnEachRow = True
            .ColumnHeaderAlignment = "right"
            .TDStyleArray = arrTDStyle
            .returnHTML = True
            .UseSQL = m_blnUseSQL
            ''''Added By Vaijat K On 06/10/2015
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''''End Added By Vaijat K On 06/10/2015
            GetExecutionResultsGrid = .DrawGrid()
        End With
        objGrid = Nothing
    End Function

    Private Function ValidateFormula(ByVal strActualFormula As String, Optional ByRef strValidationResult As String = "") As Boolean
        '=====================================================================
        ' Procedure Name        : ValidateFormula()	
        ' Purpose               : To validate the whereclause for the alert
        ' Description           : The query is built with the whereclause and executed
        '                         and in case of any error false is returned else true
        ' Parameters Passed     : 
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        '=====================================================================
        Dim strSQL As String
        Dim dr As IDataReader
        Dim intCounter As Integer


        Dim lngConnectionID As Long
        Dim strConnectionString As String
        Dim blnOracle As Boolean = False

        Dim strAcualFormula As String
        Dim drActualFormula As IDataReader

        MyBase.InitializeResources("AppResourcePPM.MB_MeasurementUI", "AppResourcePPM")

        strSQL = "usp_CalculateMetricParameterValue " & m_intMetricID & ",1,2,'04/04/2002','04/04/2005','V','" & strActualFormula & "'"
        drActualFormula = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

        ' if the formula has a valid name the recordset returns "1"
        If drActualFormula.Read Then
            strAcualFormula = CType(CommonFunctions.Data.CheckIsDBNull(drActualFormula("ActualFormulaValue")), String)
        End If

        strSQL = "SELECT " & Trim(strAcualFormula & "")

        ' set the validation to true
        strValidationResult = MyBase.GetResourceString("VALID_FORMULA_MSG")
        ValidateFormula = True

        ' connection to be used
        lngConnectionID = GetConnectionID(m_lngEntityID)
        strConnectionString = GetConnectionString(lngConnectionID, blnOracle, m_blnUseSQL)
        ' execute & check for errors
        Try
            dr = CommonFunctions.Data.GetDataReader(strSQL, Not blnOracle, strConnectionString)
        Catch exc As Exception
            strValidationResult = MyBase.GetResourceString("INVALID_FORMULA_MSG")
            strValidationResult += vbCrLf & "<font face=verdana;arial color=red size=0>" & exc.Message & "</font></B>"

            strValidationResult = Replace(strValidationResult, "[Microsoft][ODBC SQL Server Driver][SQL Server]", "<font color=black ><b>ProjectByNet Query Analyzer  - </font></b>")
            strValidationResult = Replace(strValidationResult, m_strEntityName, "")
            strValidationResult = Replace(strValidationResult, ".", "")

            For intCounter = 0 To UBound(m_arrValue)
                If InStr(1, Trim(strValidationResult & ""), Trim(m_arrValue(intCounter) & ""), CompareMethod.Binary) > 0 Then
                    strValidationResult = Replace(strValidationResult & "", Trim(m_arrValue(intCounter) & ""), "<Font color=black  >" & Trim(m_arrText(intCounter) & "</font>"))
                End If
            Next

            ValidateFormula = False
        Finally
            CloseDataReader(dr)
            CloseDataReader(drActualFormula)
        End Try

    End Function

    Private Function CheckUniqueFormulaName(ByVal EntityID As Long, ByVal FormulaId As Long, ByVal strFormulaName As String) As Boolean
        '=====================================================================
        ' Procedure Name        :	funCheckUniqueFormulaName()
        ' Description           :	The master is queried to see if the name already exists
        ' Purpose               :	to check the uniqueness of the formula
        ' Parameters Passed     :	EntityID
        '                           FormulaID | 
        '							strFormulaName | 
        ' Returns               :	True if the name is unique
        ' Parameters Affected   :   None
        ' Assumptions           :   FormulaID to be passed as 0 when for a new formula
        ' Dependencies          :	tbl_QRB_Formula_Master, commonFunctions.asp
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String = ""
        Dim intCount As Integer

        If Trim(FormulaId & "") = "" Then
            FormulaId = 0
        End If

        ' The Query to check uniqueness of the formula name
        strSQL = "usp_QRB_Check_Formula_UniqueName " & EntityID & "," & FormulaId & ",'" & CommonFunctions.General.BuildQueryString(Trim(strFormulaName & "")) & "'"

        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

        ' if the formula has a valid name the recordset returns "1"
        If dr.Read Then
            If Trim(dr("Value").ToString & "") = "1" Then
                CheckUniqueFormulaName = True
            Else
                CheckUniqueFormulaName = False
            End If
        Else
            ' returning false
            CheckUniqueFormulaName = False
        End If
        CloseDataReader(dr)
    End Function

    Private Function BuildActualFormula(ByVal strFormula As String) As String
        '=====================================================================
        ' Procedure Name        : funcBuildActualFormula()
        ' Description           : To build the actual formula
        ' Purpose               : To build the actual formula
        ' Parameters Passed     : 
        ' Returns               : the Actual formula
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          : module arrays m_arrText, m_arrValue
        '=====================================================================
        Dim arrTemp() As String = {}
        Dim intUpperBound, intCounter, intCount, intUpperBound2 As Integer
        Dim strTemp As String
        Dim blnMatch As Boolean

        '####################################################################
        '   The Formula String has the user friendly attribute names separated
        '	with "@" character
        '#####################################################################

        ' Splitting the string on @ 
        arrTemp = Split(strFormula & "", "@")

        ' Getting the upper bounds of the arrays holding Actual/User Friendly Attributes
        intUpperBound = UBound(arrTemp)
        intUpperBound2 = UBound(m_arrText)

        ' Here we will check each user friendly attribute name in the string
        ' and if there is a match we will replace it with the actual attribute name
        For intCounter = 0 To intUpperBound
            If Trim(arrTemp(intCounter) & "") <> "" Then
                ' Setting the Flag to false
                blnMatch = False
                ' If there is a match we put the actual attribute in place
                For intCount = 0 To intUpperBound2
                    If UCase(Replace(Trim(m_arrText(intCount) & ""), " ", "")) = UCase(Replace(Trim(arrTemp(intCounter) & ""), " ", "")) Then
                        strTemp = strTemp & " " & Trim(m_arrValue(intCount) & "")
                        blnMatch = True
                        Exit For
                    End If
                Next ' intCount 

                ' there were no matches so we use this at it is
                If blnMatch = False Then
                    strTemp = strTemp & " " & Trim(arrTemp(intCounter) & "")
                End If
            End If
        Next ' intCounter

        ' Returning the new string with actual attributes
        BuildActualFormula = "(" & Trim(strTemp & "") & ")"
    End Function

    Private Sub PopulateUsedFormulaArray(ByVal EntityID As Long)
        '=====================================================================
        ' Procedure Name        :	PopulateUsedFormulaArray
        ' Purpose               :	TO populate the array of formulaid which
        '							are used in queries
        ' Description           :	All the formula_names of the employee are
        '							checked in each select clause for the same
        '							entity and if it is found the formula id
        '							is added in the array
        ' Parameters Passed     :	EntityID
        ' Returns               :	
        ' Parameters Affected   :	Module level Array arrFormulasInUse() is Populated here
        ' Assumptions           :	
        ' Dependencies          :	CommonFunctions.asp;usp_QRB_Get_FormulaForEntity
        '							usp_QRB_Get_QuerySelectClasues_ForEntity
        '=====================================================================
        Dim dr, drQuery As IDataReader
        Dim intCount As Integer = 0
        Dim intIndex As Integer = 0
        Dim intUpperBound As Integer = 0
        Dim intFormulaID As Long
        Dim strFormulaName As String
        Dim strSelectClause As String
        Dim arr() As String = {}

        ' Initializing
        intCount = 0
        ReDim m_arrFormulasInUse(0)

        ' Getting all the formulas used in queries 
        drQuery = CommonFunctions.Data.GetDataReader("usp_QRB_Get_QuerySelectClasues_ForEntity " & EntityID, m_blnUseSQL)
        Do While drQuery.Read
            ReDim Preserve arr(intCount)
            arr(intCount) = drQuery("SelectClause").ToString
            intCount += 1
        Loop
        CloseDataReader(drQuery)
        intUpperBound = UBound(arr)

        intCount = 0
        ' get the formulas in use
        dr = CommonFunctions.Data.GetDataReader("usp_QRB_Get_FormulaForEntity " & m_lngEmployeeID & "," & EntityID & ",'" & m_strLoginType & "'", m_blnUseSQL)
        Do While dr.Read
            ' appending brackets to formula name since in the select 
            ' clause the formula name will be in [formula_name] format
            strFormulaName = Trim(dr("FormulaName").ToString & "")
            intFormulaID = CType(dr("FormulaID"), Long)

            ' Checking for the formula name in the queries for the entity 
            For intIndex = 0 To intUpperBound
                If InStr(1, arr(intIndex), strFormulaName, CompareMethod.Binary) > 0 Then
                    ' Populating the array and resizing it								
                    m_arrFormulasInUse(intCount) = intFormulaID
                    intCount = intCount + 1
                    ReDim Preserve m_arrFormulasInUse(intCount)
                    Exit For
                End If
            Next
        Loop
        CloseDataReader(dr)
    End Sub

    Private Function GetMenu(ByVal IgnorePaging As Boolean) As String
        '=====================================================================
        ' Procedure Name        : GetMenu()	
        ' Purpose               : To get the menu for current mode
        ' Description           : same as above
        ' Parameters Passed     : 
        ' Returns               : string of menu
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        '=====================================================================
        Dim strPaging As String = ""
        Dim strSQL As String = ""
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")

        If UCase(Trim(m_strMode & "")) = "LIST" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADD_NEW"), MyBase.GetResourceString("MENU_DELETE"), MyBase.GetResourceString("MENU_SELECT_ALL"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADD_NEW_TOOLTIP"), MyBase.GetResourceString("MENU_DELETE_TOOLTIP"), MyBase.GetResourceString("MENU_SELECT_ALL_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            MyBase.InitializeResources("Resources.StandardMessages", "Resources")
            Dim arrCSFunction() As String = {"AddNew_OnClick()", "Delete_OnClick('" + MyBase.GetResourceString("DELETE_CONFIRM") + "')", "SelectAll_OnClick()", "Close_OnClick()", "Help_OnClick('QRB_QUERYCREATION')"}

            If IgnorePaging Then
                strPaging = ""
            Else
                strSQL = "usp_QRB_Get_FormulaForEntity_ForPaging " & m_lngEmployeeID & "," & m_lngEntityID & ",'" & m_strLoginType & "'"
                strPaging = WebPage.Templates.Paging.DrawPaging(m_strAlphabet, strSQL, MyBase.GetResourceString("SELECT"), "Page_OnClick", "FormulaName", True)
            End If

            Return WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, True, strPaging)

        Else


            'Dim arrMenu() As String = {"Validate", MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_BACK"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            'Dim arrMenuToolTip() As String = {"Validate", MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_BACK_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            'Dim arrCSFunction() As String = {"Validate_OnClick()", "Save_OnClick()", "Back_OnClick()", "Close_OnClick()", "Help_OnClick('QRB_QUERYCREATION')"}

            Dim arrMenu() As String = {"Validate", "Build Formula", MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {"Validate", "Build Formula", MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrCSFunction() As String = {"Validate_OnClick()", "Save_OnClick()", "Close_OnClick()", "Help_OnClick(2128)"}

            Return WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, True)

        End If


    End Function

    Private Sub CloseDataReader(ByRef dr As IDataReader)
        '=====================================================================
        ' Procedure Name        : CloseDataReader()	
        ' Purpose               : To draw a line
        ' Description           : same as above
        ' Parameters Passed     : by ref data reader
        ' Returns               : String
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        '=====================================================================
        If Not dr Is Nothing Then
            If Not dr.IsClosed Then
                dr.Close() : dr.Dispose()
            End If
        End If
        dr = Nothing
    End Sub

    Private Function DrawLine(ByVal Color As String, ByVal ColSpan As Integer) As String
        '=====================================================================
        ' Procedure Name        : DrawLine()	
        ' Purpose               : To draw a line
        ' Description           : same as above
        ' Parameters Passed     : Color, Colspan
        ' Returns               : String
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        '=====================================================================
        Dim sb As New System.Text.StringBuilder("")
        sb.Append("<tr><td bgColor=" + Color + " width='100%' align='left' colspan='" + ColSpan.ToString + "'></td></tr>" + vbCrLf)
        Response.Write(sb.ToString)
        sb = Nothing
    End Function

    Private Function DrawLink(ByVal LinkName As String, ByVal CSFunction As String, ByVal strTitle As String) As String
        '=====================================================================
        ' Procedure Name        : DrawLink()	
        ' Purpose               : To draw a link
        ' Description           : same as above
        ' Parameters Passed     : LinkName, Client-side fn.,title
        ' Returns               : String
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        '=====================================================================
        Dim sb As New System.Text.StringBuilder("")
        sb.Append("|<a href=" + Chr(34) + "JavaScript:" + CSFunction + Chr(34) + "><font size='1' title='" + strTitle + "' Style='TEXT-DECORATION:None'>")
        sb.Append("<font size='1' face='verdana' color='black' style='BACKGROUND-COLOR: aliceblue'>")
        sb.Append("<b>&nbsp;" + LinkName + "&nbsp;</b>")
        sb.Append("</font>")
        sb.Append("</a>")
        DrawLink = sb.ToString
        sb = Nothing
    End Function

    Private Sub PopulateAttributeArrays(ByVal EntityID As Long, ByVal UserName As String, ByVal LoginType As String, ByVal UseSQL As Boolean)
        '=====================================================================
        ' Procedure Name        : PopulateAttributeArrays()
        ' Description           : the module level arrays are populated with the required 
        '						  Attribute information for the page list boxes
        ' Purpose               : 
        ' Parameters Passed     : EntityID,UserName,LoginType,UseSQL
        ' Returns               :
        ' Parameters Affected   : arrays are populated
        ' Assumptions           : 
        ' Dependencies          : usp_CDB_GetAccessibleAttributes, CommonFunctions.dll
        '=====================================================================
        Dim intCount As Integer
        Dim strSQL As String
        Dim dr As IDataReader

        ReDim m_arrText(0)
        ReDim m_arrValue(0)
        ReDim m_arrValidInputs(0)
        ReDim m_arrDataType(0)
        ReDim m_arrAttributeID(0)

        strSQL = "EXEC usp_sel_tbl_PRS_Measurements 1"
        dr = CommonFunctions.Data.GetDataReader(strSQL, UseSQL)

        intCount = 0
        Do While dr.Read And Response.IsClientConnected
            ' getting the entity name
            ReDim Preserve m_arrText(intCount)
            ReDim Preserve m_arrValue(intCount)
            ReDim Preserve m_arrValidInputs(intCount)
            ReDim Preserve m_arrDataType(intCount)
            ReDim Preserve m_arrAttributeID(intCount)

            m_arrAttributeID(intCount) = CType(dr("MeasurementID"), Long)
            m_arrText(intCount) = Trim(dr("UserFriendlyName").ToString & "")
            m_arrValue(intCount) = Trim(dr("MeasurementCode").ToString & "")

            intCount += 1
        Loop
        ' Closing the Recordset object			
        CloseDataReader(dr)
    End Sub

    Private Function GetConnectionString(ByVal lngConnectionID As Long, ByRef IsOracle As Boolean, ByVal UseSQL As Boolean) As String
        '=====================================================================
        ' Procedure Name        : GetConnectionString()	
        ' Description           : To get the connection info. for conn. id.
        ' Purpose               : To get the connection info. for conn. id.
        ' Parameters Passed     : ByVal Connection ID,ByRef Database type, BYval UseSQL (true/false)
        ' Returns               : connection string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : usp_sel_tbl_QRB_Connection_Master
        '=====================================================================
        Dim dr As IDataReader
        If lngConnectionID <> 0 Then
            dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_QRB_Connection_Master " + lngConnectionID.ToString, UseSQL)
            If dr.Read Then
                GetConnectionString = dr("ConnectionString").ToString
                If dr("DatabaseType").ToString.Trim.ToUpper = "S" Then
                    IsOracle = False
                Else
                    IsOracle = True
                End If
                dr.Dispose()
            Else
                GetConnectionString = ""
            End If
        Else
            GetConnectionString = ""
        End If
        dr = Nothing
    End Function

    Function GetConnectionID(Optional ByVal EntityID As Long = 0, Optional ByVal QueryID As Long = 0) As Long
        '=====================================================================
        ' Procedure Name        : GetConnectionID()	
        ' Description           : To get the connection info. for conn. id.
        ' Purpose               : To get the connection info. for conn. id.
        ' Parameters Passed     : ByVal Connection ID,ByRef Database type, BYval UseSQL (true/false)
        ' Returns               : connection string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : usp_sel_tbl_QRB_Connection_Master
        '=====================================================================
        Dim dr As IDataReader
        If QueryID = 0 Then
            dr = CommonFunctions.Data.GetDataReader("usp_QRB_GetConnectionID " & EntityID, m_blnUseSQL)
            If dr.Read Then
                If Not IsDBNull(dr("ConnectionID")) Then
                    GetConnectionID = CType(dr("ConnectionID"), Long)
                Else
                    GetConnectionID = 0
                End If
            Else
                GetConnectionID = 0
            End If
            CloseDataReader(dr)
        Else
            dr = CommonFunctions.Data.GetDataReader("usp_QRB_GetConnectionID_ForQuery " & QueryID, m_blnUseSQL)
            If dr.Read Then
                If Not IsDBNull(dr("ConnectionID")) Then
                    GetConnectionID = CType(dr("ConnectionID"), Long)
                Else
                    GetConnectionID = 0
                End If
            Else
                GetConnectionID = 0
            End If
            CloseDataReader(dr)
        End If

    End Function

    Private Function funGetUserFriendlyAttributeName(ByVal intEntityID As Long, ByVal strAttributeName As String) As String
        '=====================================================================
        ' Procedure Name        : funGetUserFriendlyAttributeName()
        ' Description           : to get the user friendlyname of the attribute
        ' Purpose               : 
        ' Parameters Passed     : ByVal intEntityID, ByVal strAttributeName
        ' Returns               :
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          : communfunctions.asp,usp_CDB_Get_UserFriendlyName
        '=====================================================================
        Dim dr As IDataReader
        Dim strTemp As String = ""
        Dim blnAppendChar As Boolean = False
        Dim strUFAttribute As String = ""

        If Left(strAttributeName, 1) = "@" Then
            strTemp = Replace(strAttributeName, "@", "", , , CompareMethod.Binary)
            blnAppendChar = True
        End If

        dr = CommonFunctions.Data.GetDataReader("usp_CDB_Get_UserFriendlyName  " & intEntityID & ",'" & CommonFunctions.General.BuildQueryString(Trim(strTemp & "")) & "'", True)
        If dr.Read Then
            ' REturning the User Friendly name
            strUFAttribute = Trim(dr(0).ToString & "")
            If blnAppendChar Then
                strUFAttribute = "@" & Trim(strUFAttribute & "")
            End If
        Else
            ' NO match found returning the same attribute back
            strUFAttribute = Trim(strAttributeName & "")
        End If
        CloseDataReader(dr)

        Return strUFAttribute
    End Function
    Protected Sub InitPage()
        Call Initialize()
        '        Process()
        If Page.IsPostBack Then
            Call PerformActions()
        End If
        If m_blnValidStatus = False Then
            WritePage()
        End If
    End Sub
    Protected Sub Process()
        Dim dr As IDataReader
        Dim strSQL As String
        Dim strFormulasInUse As String
        Dim strTemp As String

        Dim strFormula As String
        Dim strActualFormula As String
        Dim strFormulaName As String
        Dim strDescription As String


        strFormula = Replace(Replace(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("txtFormula")), Chr(10), ""), Chr(13), "")
        strDescription = MyBase.GetFormValue("txtDescription")
        strActualFormula = BuildActualFormula(strFormula)
        strFormulaName = MyBase.GetFormValue("txtFormulaName")

        Select Case Trim(m_strAction & "").ToUpper
            Case "SAVE"

                Select Case Trim(m_strMode & "")
                    Case "NEW", "EDIT"
                        If ValidateFormula(strFormula, m_strValidationResult) = True Then
                            'If m_intProjectID = 0 Then
                            '    strSQL = "EXEC usp_ins_tbl_MET_Metricmaster_Formula "
                            '    strSQL &= m_intMetricID & ",'"
                            '    strSQL &= CommonFunctions.General.BuildQueryString(Trim(strFormula & "")) & "','" _
                            '    & CommonFunctions.General.CheckIsNothing(Session("strUserName")) & "',1" '& "'," & "'usp_CalculateMetricParameterValue & "  '"
                            '    dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                            'Else
                            '    strSQL = "EXEC usp_ins_tbl_MET_Metricmaster_Formula "
                            '    strSQL &= m_intMetricID & ",'"
                            '    strSQL &= CommonFunctions.General.BuildQueryString(Trim(strFormula & "")) & "','" _
                            '    & CommonFunctions.General.CheckIsNothing(Session("strUserName")) & "',0" '& "'," & "'usp_CalculateMetricParameterValue & "  '"
                            '    dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                            'End If

                            'CloseDataReader(dr)
                            m_blnValidStatus = True
                            strTemp = "<root><isSaved>true</isSaved></root>"
                            Response.Clear()
                            Response.Write(strTemp)
                        Else
                            strTemp = "<root><isSaved>false</isSaved></root>"
                            Response.Clear()
                            Response.Write(strTemp)
                        End If
                    Case Else

                End Select
        End Select
    End Sub
End Class

