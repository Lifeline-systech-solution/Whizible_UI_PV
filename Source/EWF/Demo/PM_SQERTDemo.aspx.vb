'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhizibleE
' Module Name           :  PM_SQERT.aspx
' Purpose               :  
' Description           :  
' Dependencies          :  None
' Author                :  PrakashR
' Reviewed              :  
' Tested                :  
' Created               :  
' Revisions             :  
'=====================================================================

#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class PM_SQERTDemo
    Inherits WebPages.Template.WhizTemplate

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

#Region "Member Variables"
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0
    Protected m_intSessionProjectId As Integer
    Protected m_intSessionPostId As Integer
    Protected m_strMode As String
    ' Added by RajkumarM for Update SQERT Values
    Protected m_strAction As String
    ' End of Addition
    Protected m_strCategoryId As String
    Protected m_strBUId As String
    Protected m_strOUId As String
    Protected m_strProgramId As String
    Protected m_strProjectId As String
    Protected m_strReportedDate As String
    Protected m_intReportingPeriod As Integer
    Protected m_strSQLProject As String
    Protected m_strSQLOU As String
    Protected m_dtmReportingStartDate As DateTime
    Protected m_dtmReportingEndDate As DateTime
    Protected m_dtmProjectStartDate As DateTime
    Protected m_dtmProjectEndDate As DateTime
    Protected m_dtmNextReportingStartDate As DateTime
    Protected m_dtmNextReportingEndDate As DateTime
    Public Const GRAPH_DIRECTORY As String = "../../images/DB_Graphs/"  ' EV graph location
    Private m_intGraphHeight As Integer                 'EV graph Height    
    Private m_intGraphWidth As Integer                  ' EV graph width
    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Protected m_strQuery As String

    'Grid variables
    Private WithEvents objEVDetails As New WebPage.Templates.GenericGrid

    ' For Update SQERT Values

    Dim intSQERTID, intRecordcount, intRecordCnt As Integer
    Dim intScope, intQuality, intEffort, intRisk, intTime As Integer
    Dim StrScopeDesc, StrQualityDesc, StrEffortDesc, StrRiskDesc, StrTimeDesc, strClass As String
    Dim strGeneralRemarks, strEscalations As String
    Dim blnLocked, blnDisable As Boolean
    Dim intScopelow, intScopehigh, intQualitylow, intQualityHigh, intcnt As Integer


    Dim drEv As IDataReader
    Dim drSQERTValues As IDataReader
    Dim m_strTRstyle As String
    ' End of Addition

    'ADDED BY VIVEKP ON 21 SEP 2005
    Private intRoleLevel As Integer
    Private m_strProjectFilters As String
    Private WithEvents m_objActiveResourceGrid As New WebPages.Template.GenericGrid
    'END OF ADDITION BY VIVEKP ON 21 SEP 2005
#End Region

#Region "Functions and Sub-Procedures"

    Public Sub BuildPage()
        '=====================================================================
        ' Procedure Name        : BuildPage()	
        ' Purpose               : Main procedure to build the page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Mangesh Y
        ' Created               : Jan 06, 2005
        ' Revisions             : By - PadmnabhA 
        '                         Purpose - Added Trend Graph 
        '=====================================================================
        Call SetVariables() 'Setting Veriables 

        If m_strMode.ToUpper = "SAVESQERTVALUES" Then
            blnDisable = False
        End If

        Response.Write(GenerateMenu())

        If (m_strMode.ToUpper = "TRENDGRAPH") Then
            Call DisplayTrendGraph()
            Exit Sub
        End If

        'Initialize resource file 
        MyBase.InitializeResources("AppResources.PM_SQERT", "AppResources")

        WritePageLegend()

        Call GeneratePageCaption()

        Call GeneratePageHeader()

        Call DisplayPageDetails()

        Response.Write(GenerateMenu())

    End Sub
    Private Sub DisplayTrendGraph()
        '=====================================================================
        ' Procedure Name        : DisplayTrendGraph 
        ' Purpose               : To Display Trend Graph
        ' Description           : Display Trend Graph
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Padmanhbh Anturkar
        ' Created               : Nov 17, 2005
        ' Revisions             : 
        '=====================================================================
        'Dummy Tag ID is taken in m_lngTagId as this Graph is a pop up graph for the same where other garph already exists
        m_lngTagId = 2000

        Dim objGraphs As New DBGraphs
        Dim objGraphSection As New WebPages.Template.SectionTitle
        With objGraphSection
            Response.Write(.GetSectionTitle("Graphs", "DivGraphs", "ShowHideGraphs"))
            Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
            Response.Write(.ClientsideScript())
            Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
        End With

        '--Div for section title
        Response.Write("<DIV Id='DivGraphs' Style='Overflow:Auto;Width=100%'>")
        With objGraphs
            .ProjectID = CType(m_strProjectId, Long)
            .TagID = m_lngTagId
            .ReportGenerationDate = "'" & m_strReportedDate & "'"
            .GenerateGraphs()
            .m_intGraphCount = 1
            .ShowFooterNote = True
        End With
        Response.Write("</DIV>")
    End Sub
    Private Sub GenerateReportGraph()
        '=====================================================================
        ' Procedure Name        : GenerateReport()	
        ' Purpose               : to Generate Earned Value Report for selected Project and date range
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Aug 04, 2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim drGraph, drTemp As IDataReader
        Dim objGraph As Graph.Graph
        Dim strChartType As String
        Dim strSQL As String
        Dim strImageFileName As String = ""
        Dim blnShowLegends As Boolean = False
        Dim blnShowCaptions As Boolean = True
        Dim blnShowExplodedPie As Boolean = False
        Dim blnEnable3D As Boolean = False
        Dim lngEntityID As Long = 0
        Dim strNomenclature As String = ""
        Dim arrstrChartType() As String = {}
        Dim strVirtualImgPath As String
        Dim arr(2) As String
        Dim strSQL1 As String
        Dim strSQL2 As String
        Dim arrExtSQL(2) As String
        Dim arrExtType(2) As String
        Dim i As Integer
        Dim strQuery As String
        Dim arrColor() As String = {"", "Blueviolet", "Green", ""}

        ' Earned value query
        strSQL = "  exec usp_CRW_EarnedValueReportDetails " + m_strProjectId + ",'" + CType(m_dtmProjectStartDate, String) + "','" + CType(m_dtmReportingEndDate, String) + "'"
        strSQL1 = strSQL + ",2" ' For EV
        strSQL2 = strSQL + ",3" ' For AC
        strSQL = strSQL + ",1" ' For PV and Total Budget    

        strImageFileName = "EV" + Session("intUserId").ToString

        blnShowLegends = True
        strNomenclature = "EV"
        blnShowCaptions = True

        ' create the graph for the item values
        objGraph = New Graph.Graph

        With objGraph
            strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
            .VirtualImagePath = strVirtualImgPath
            .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
            .ConnectionString = CommonFunction.Application.ConnectionString
            arrExtSQL(0) = strSQL1
            arrExtSQL(1) = strSQL2
            .ExtendedSeriesSQL = arrExtSQL
            arrExtType(0) = "LINE"
            arrExtType(1) = "LINE"
            .ExtendedSeriesGraphType = arrExtType
            .VirtualImagePath = ""
            .Enable3D = False
            arr(0) = "LINE"
            arr(1) = "LINE"
            arr(2) = "LINE"
            .ChartType = arr
            .GraphTitleColor = "black"
            .ChartBackColor = "PaleGoldenRod"
            .ChartAreaColor = "GoldenRod"
            .ShowLegends = True
            .XAxisTitle = "Weeks"
            .Nomenclature = " Man Days "
            .LegendDocking = "bottom"
            .LegendStyle = "column"
            .LegendCaptionColor = "black"
            .PalleteStyle = "EARTHTONES"
            .LegendColor = arrColor
            .EnableXAxis = True
            .EnableYAxis = True
            .EnableSmartLabels = False
            .ShowCaptions = False
            .GraphTitleColor = "Green"
            .ShowDataColumnNameAsXAxisTitle = False

            '-- Fixed Settings
            .GraphTitle = MyBase.GetResourceString("GRAPHTITLE")
            .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
            .SQL = strSQL
            .Width = m_intGraphWidth
            .Height = m_intGraphHeight
            .ShowExplodedPie = False
            .LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)

            .BorderGradientColor = "WHITE"
            .BorderGradientStyle = "TOPBOTTOM"
            .ChartBackGradientColor = "WHITE"
            .ChartBackGradientStyle = "TOPBOTTOM"
            .ChartAreaGradientColor = "WHITE"
            .ChartAreaGradientStyle = "TOPBOTTOM"

            ' return the graph image
            .GenerateImage()
        End With

        objGraph = Nothing

        '-- Display Graph
        If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY & "EV") & Session("intUserId").ToString & ".png") Then
            Response.Write("<IMG HEIGHT=" & m_intGraphHeight & " WIDTH=" & m_intGraphWidth & " src='" + GRAPH_DIRECTORY + "EV" & Session("intUserId").ToString & ".png" & "'>")
        Else
            Response.Write("<IMG src='..\..\images\NoPreview.gif'>")
        End If
    End Sub

    Private Sub DisplayEVDetails()
        '=====================================================================
        ' Procedure Name        : DisplayEVDetails()	
        ' Purpose               : TO display EV deatils
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Aug 05, 2004
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String
        Dim ArrActualFieldNames() As String = {"FieldName", "FieldValue", "EVElementName"}
        Dim drEV As IDataReader

        Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("FIELDNAME"), " ", "  "}
        Dim ArrTDStyle() As String = {"align=left width=60% colspan=2", "align=right width=40%", ""}

        strSQL = " EXEC usp_Sel_EarnedValueReport '" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & m_strProjectId
        With objEVDetails
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 2
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        objEVDetails = Nothing
    End Sub

    Private Sub WritePageLegend()
        Dim arrLegends(0) As String
        Dim arrLegendImg(0) As String

        If (m_strMode.ToUpper = "SAVESQERTVALUES" Or m_strMode.ToUpper = "SQERTVALUES" Or m_strMode.ToUpper = "CHANGE" Or m_strMode.ToUpper = "") Then
            arrLegends(0) = "&nbsp;Mandatory"
            arrLegendImg(0) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        Else
            arrLegends(0) = "<Font Color=RED> " + MyBase.GetResourceString("REDCOLORINDICATESETTINGS") + "</Font>"
            arrLegendImg(0) = ""
        End If
        CommonFunctions.General.WriteHTML(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends, True))
    End Sub

    Private Sub GeneratePageCaption()
        '=====================================================================
        ' Procedure Name        : GeneratePageCaption()	
        ' Purpose               : to generate page caption
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Mangesh Y
        ' Created               : Jan 06, 2005
        ' Revisions             :
        '=====================================================================
        'CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, , , , True))
    End Sub

    Private Sub SetVariables()
        '=====================================================================
        ' Procedure Name        :   SetVariables()	
        ' Purpose               :   Set variable values (QueryString and form references)
        ' Description           :   same as above
        ' Parameters Passed     :   none
        ' Returns               :   none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                :   Mangesh Y
        ' Created               :   Jan 06, 2005
        ' Revisions             :   
        '                           By      :   Padmnabh(Anturkar)
        '                           Purpose :   1. To add OU filter on Report main page
        '                                       2. Added two columns Gereral Remarks and Escalations
        '                           Date    :   November 16, 2005
        '=====================================================================
        Dim strSQL As String
        Dim drProject As IDataReader

        'Set Global object
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()

        m_lngTagId = 3068

        'Graph variables
        m_intGraphHeight = 350
        m_intGraphWidth = 500 '492

        m_intSessionProjectId = CType(Session("intProjectId"), Integer)
        m_intSessionPostId = CType(Session("intPostId"), Integer)

        ' Mode
        If Not Request.QueryString("Mode") Is Nothing Then
            If Request.QueryString("Mode") <> "" Then
                m_strMode = Request.QueryString("Mode")
            Else
                m_strMode = ""
            End If
        Else
            m_strMode = ""
        End If

        intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)

        '=========================================================================================
        '   Applying Role level Security for Project Filters
        '=========================================================================================
        If intRoleLevel = 2 Then
            m_strProjectFilters = ""
            Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
            If strFilter <> "" Then
                m_strProjectFilters += strFilter
            End If
            Dim strRemove As String = "ProjectID IN"
            m_strProjectFilters = m_strProjectFilters.Remove(0, strRemove.Length)
            m_strProjectFilters = m_strProjectFilters.Replace("'", "")
            m_strProjectFilters = m_strProjectFilters.Replace("(", "")
            m_strProjectFilters = m_strProjectFilters.Replace(")", "")
        Else
            m_strProjectFilters = "NULL"
        End If

        m_strSQLProject = "usp_Sel_GetProjectNameList_SQERT  "
        m_strSQLOU = "usp_Sel_pm_LocationList_SQERT "

        '=========================================================================================
        'Applying filters on Report main page
        '=========================================================================================

        '=========================================================================================
        '   Project Category
        '=========================================================================================
        If Request("cboCategoryID") <> "" Then
            m_strCategoryId = Request("cboCategoryID")
            m_strSQLProject = m_strSQLProject & m_strCategoryId & ","
        Else
            m_strCategoryId = ""
            m_strSQLProject = m_strSQLProject & "NULL,"
        End If

        '=========================================================================================
        '   Business Unit
        '=========================================================================================
        If Request("cboBUID") <> "" Then
            m_strBUId = Request("cboBUID")
            m_strSQLProject = m_strSQLProject & m_strBUId & ","
            m_strSQLOU = m_strSQLOU & m_strBUId
        Else
            m_strBUId = ""
            m_strSQLProject = m_strSQLProject & "NULL,"
            m_strSQLOU = m_strSQLOU & "NULL "
        End If

        '=========================================================================================
        '   Organization Unit
        '=========================================================================================
        If Request("cboOUID") <> "" Then
            m_strOUId = Request("cboOUID")
            m_strSQLProject = m_strSQLProject & m_strOUId & ","
        Else
            m_strOUId = ""
            m_strSQLProject = m_strSQLProject & "NULL,"
        End If

        '=========================================================================================
        '   Program
        '=========================================================================================
        If Request("cboProgramID") <> "" Then
            m_strProgramId = Request("cboProgramID")
            m_strSQLProject = m_strSQLProject & m_strProgramId & ","
        Else
            m_strProgramId = ""
            m_strSQLProject = m_strSQLProject & "NULL,"
        End If

        If m_strProjectFilters <> "NULL" Then
            m_strSQLProject = m_strSQLProject & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQLProject = m_strSQLProject & CType(Session("intUserID"), String) & "," & m_strProjectFilters
        End If

        '=========================================================================================
        '   Project
        '=========================================================================================
        If Request("cboProjectID") <> "" Then
            m_strProjectId = Request("cboProjectID")
        Else
            'MODIFIED BY VIVEKP ON 20 SEP 2005 
            'MODIFIED ONSITE BY MANGESH ON 18 MARCH 05 : DEFAULT PROJECT SHOULD BE CURRENT PROJECT
            'm_strProjectId = CType(Session("intProjectID"), String)
            m_strProjectId = ""
            'END MODIFICATION
            'END OF MODIFICATION ON 20 SEP 2005
        End If
        If m_strMode.ToUpper = "SHOWHISTORY" Or m_strMode.ToUpper = "SAVESQERTVALUES" Then
            m_strProjectId = Request.QueryString("ProjectID")
        End If

        '=========================================================================================
        '   Reporting Date
        '=========================================================================================
        If Request("txtReportingDate") <> "" Then
            m_strReportedDate = Request("txtReportingDate")
        Else
            m_strReportedDate = Now().ToString
        End If

        '=========================================================================================
        '   Reporting Period
        '=========================================================================================
        If Request("optReportingPeriod") <> "" Then
            m_intReportingPeriod = CType(Request("optReportingPeriod"), Integer)
        End If

        '=========================================================================================
        '   Action
        '=========================================================================================
        If Not Request.QueryString("Action") Is Nothing Then
            If Request.QueryString("Action") <> "" Then
                m_strAction = Request.QueryString("Action")
            Else
                m_strAction = ""
            End If
        Else
            m_strAction = ""
        End If

        'Modified by NitinvS on 2 Aug 2007 for WhizibleSEM 7 removed pcfc from sp name 
        'Added By RajkumarM on 13th Jul.,2004 
        strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTRange"
        'End Modification by NitinvS on 2 Aug 2007 for WhizibleSEM 7 removed pcfc from sp name 

        drProject = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drProject.Read Then
            intScopelow = CType(CommonFunctions.Data.CheckIsDBNull(drProject("Lower_Low"), ""), Integer)
            intScopehigh = CType(CommonFunctions.Data.CheckIsDBNull(drProject("Upper_High"), ""), Integer)
            drProject.Read()
            intQualitylow = CType(CommonFunctions.Data.CheckIsDBNull(drProject("Lower_Low"), ""), Integer)
            intQualityHigh = CType(CommonFunctions.Data.CheckIsDBNull(drProject("Upper_High"), ""), Integer)
        End If
        CommonFunctions.Data.DisposeDataReader(drProject)
        If m_strMode.ToUpper = "SQERTVALUES" Or m_strMode.ToUpper = "SAVESQERTVALUES" Then
            If m_strAction <> "Add" Then
                intSQERTID = 0
                intScope = 0
                intQuality = 0
                intEffort = 0
                intRisk = 0
                intTime = 0
                StrScopeDesc = ""
                StrQualityDesc = ""
                StrEffortDesc = ""
                StrRiskDesc = ""
                StrTimeDesc = ""
                blnLocked = False
                strGeneralRemarks = ""
                strEscalations = ""
                'Modified by NitinVS on 2 Aug 2007 for WhizibleSEM 7
                'Removed the PCFC from sp name changed usp_CRW_PCFC_ProjectSheet_GetSQERTValues to usp_CRW_ProjectSheet_GetSQERTValues
                strSQL = " Exec usp_CRW_ProjectSheet_GetSQERTValues " & m_strProjectId
                'End Modification By NitinVS on 2 Aug 2007 for WhizibleSEM 7

                drSQERTValues = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                If drSQERTValues.Read Then
                    intSQERTID = CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("SQERTID"), ""), Integer)
                    intScope = CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("Scope"), ""), Integer)
                    intQuality = CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("Quality"), ""), Integer)
                    StrScopeDesc = CommonFunctions.Data.CheckIsDBNull(drSQERTValues("ScopeDesc"), "").ToString
                    StrQualityDesc = CommonFunctions.Data.CheckIsDBNull(drSQERTValues("QualityDesc"), "").ToString
                    StrEffortDesc = CommonFunctions.Data.CheckIsDBNull(drSQERTValues("EffortDesc"), "").ToString
                    StrRiskDesc = CommonFunctions.Data.CheckIsDBNull(drSQERTValues("RiskDesc"), "").ToString
                    StrTimeDesc = CommonFunctions.Data.CheckIsDBNull(drSQERTValues("TimeDesc"), "").ToString
                    blnLocked = CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("Locked"), ""), Boolean)
                    strGeneralRemarks = CommonFunctions.Data.CheckIsDBNull(drSQERTValues("GeneralRemarks"), "").ToString
                    strEscalations = CommonFunctions.Data.CheckIsDBNull(drSQERTValues("Escalations"), "").ToString
                End If
                CommonFunctions.Data.DisposeDataReader(drSQERTValues)

            End If

            '=========================================================================================
            '   Depending on Lock Set for the project Disable value is Set. This blnDisable decides if 
            '   the user is allowed to add new entry in SQERT.
            '   Lock Value is Set in the table using SQERT Lock master from Processes tab
            '=========================================================================================
            If blnLocked = True Then
                blnDisable = True
            Else
                blnDisable = False
            End If
        End If
    End Sub

    Private Sub GeneratePageHeader()
        '=====================================================================
        ' Procedure Name        : GeneratePageHeader()	
        ' Purpose               : to generate page header
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Mangesh Y
        ' Created               : Jan 06, 2005
        ' Revisions             :
        '=====================================================================

        Dim objHeaderFooter As New WebPage.Templates.HeaderFooter
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing
    End Sub

    Private Sub DisplayPageDetails()
        Dim strHTML As String
        Dim strCase As String

        Dim strPossibleCauses As String
        Dim strPossibleSolutions As String
        Dim objSection As WebPages.Template.SectionTitle
        Dim strTitle As String
        Dim m_strProjectName As String
        Dim m_strCategory As String
        Dim m_strBU As String
        Dim m_strOU As String
        Dim drSQERT As IDataReader
        Dim drTask As IDataReader
        Dim m_strSQL As String

        Dim m_dtmlastlockedDate As DateTime


        Dim m_strProgramName As String
        Dim m_strProgramOwner As String
        Dim m_strProgramSponsor As String
        Dim m_strProgramManager As String

        Dim m_strProjectOwner As String
        Dim m_strProjectSponsor As String
        Dim m_strProjectManager As String

        m_dtmlastlockedDate = CType("1/1/1900", Date)

        If Not Request.QueryString("txtReportingDate") = "" Then
            m_dtmReportingEndDate = CType(Request.QueryString("txtReportingDate"), Date)
            m_dtmNextReportingStartDate = CType(Request.QueryString("txtReportingDate"), Date)
        Else
            m_dtmReportingEndDate = Now()
        End If

        If Not Request.QueryString("txtReportingDate") = "" Then
            m_dtmNextReportingStartDate = CType(DateAdd("d", 1, m_dtmNextReportingStartDate), Date)
            Select Case m_intReportingPeriod
                Case 0
                    m_dtmReportingStartDate = CType(DateAdd("d", -6, m_dtmReportingEndDate), Date)
                    m_dtmNextReportingEndDate = CType(DateAdd("d", 7, m_dtmReportingEndDate), Date)
                Case 1
                    m_dtmReportingStartDate = CType(DateAdd("d", -13, m_dtmReportingEndDate), Date)
                    m_dtmNextReportingEndDate = CType(DateAdd("d", 14, m_dtmReportingEndDate), Date)
                Case 2
                    m_dtmReportingStartDate = CType(DateAdd("d", -29, m_dtmReportingEndDate), Date)
                    m_dtmNextReportingEndDate = CType(DateAdd("d", 30, m_dtmReportingEndDate), Date)
                Case Else
                    m_dtmReportingStartDate = m_dtmReportingEndDate
            End Select
        End If

        'Modified by MrugajaB on 13th April,2005
        'Purpose:To display OU,BG,Practice and Prohject Group of seleced Project
        ' Program filter
        If m_strProgramId <> "" Then
            m_strSQL = "Exec usp_RPT_GetProjectandProgramdetails " & m_strProgramId & ",1"
            drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            If drSQERT.Read Then
                m_strProgramName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProgramName"), "").ToString
                'm_strProgramOwner = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProgramOwner"), "").ToString
                'm_strProgramSponsor = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProgramSponsor"), "").ToString
                'm_strProgramManager = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProgramManager"), "").ToString
            End If
            CommonFunctions.Data.DisposeDataReader(drSQERT)
            m_strQuery = m_strProgramId
        ElseIf m_strProjectId <> "" Then
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            '' m_strSQL = "Select ISNULL(ProjectGroupID,0) AS 'ProjectGroupID', ISNULL(ProjectGroupName,'') As 'ProjectGroupName' From tbl_PM_ProjectGroup WHERE ProjectGroupID = (SELECT ProjectGroupID FROM tbl_PM_Project WHERE ProjectID= " & m_strProjectId & ")"
            m_strSQL = "usp_sel_ProjectGroupID_tbl_PM_ProjectGroup " & m_strProjectId
            ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            If drSQERT.Read Then
                m_strProgramName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectGroupName"), "").ToString
                m_strProgramId = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectGroupID"), "").ToString
            End If
            CommonFunctions.Data.DisposeDataReader(drSQERT)

            If (m_strProgramId <> "0") And (m_strProgramId <> "") Then
                m_strQuery = m_strProgramId
            Else
                m_strQuery = "NULL"
            End If
        Else
            m_strQuery = "NULL"
        End If

        'Project Filter
        If m_strProjectId <> "" Then
            m_strSQL = "Select Reportingdate from tbl_PM_SQERTValues Where Locked=1 AND ProjectID=" & m_strProjectId
            m_strSQL = m_strSQL & "group by Reportingdate,LockedDate Having LockedDate=(Select Max(Lockeddate) from tbl_PM_SQERTValues where Locked=1 and ProjectID=" & m_strProjectId & ")"

            drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            If drSQERT.Read Then
                m_dtmlastlockedDate = CType(drSQERT("ReportingDate"), DateTime)
            End If
            CommonFunctions.Data.DisposeDataReader(drSQERT)

            drSQERT = CommonFunctions.Data.GetDataReader("Exec usp_RPT_GetProjectandProgramdetails " & m_strProjectId & ",0", MyBase.UseSQL)

            If drSQERT.Read Then
                'm_dtmProjectStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ExpectedStartDate"), "").ToString, Date)
                'm_dtmProjectEndDate = CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ExpectedEndDate"), "").ToString, Date)
                m_strProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
                'm_strProjectOwner = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectOwner"), "").ToString
                'm_strProjectSponsor = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectSponsor"), "").ToString
                'm_strProjectManager = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectManager"), "").ToString
            End If

            CommonFunctions.Data.DisposeDataReader(drSQERT)

            m_strQuery = m_strQuery & "," & m_strProjectId
        Else
            m_strQuery = m_strQuery & ",NULL"
        End If

        'Catagory Filter
        If m_strCategoryId <> "" Then
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            ''m_strSQL = "Select TypeId, ProjectType From tbl_PRS_ProjectTypes WHERE TypeId = " & m_strCategoryId
            m_strSQL = "usp_sel_TypeId_tbl_PRS_ProjectTypes " & m_strCategoryId
            ''End of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            If drSQERT.Read Then
                m_strCategory = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectType"), "").ToString
            End If
            CommonFunctions.Data.DisposeDataReader(drSQERT)
            m_strQuery = m_strQuery & "," & m_strCategoryId
        ElseIf m_strProjectId <> "" Then
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            '' m_strSQL = "Select TypeId, ProjectType From tbl_PRS_ProjectTypes WHERE TypeId = (SELECT ProjectTypeID FROM tbl_PM_Project WHERE ProjectID= " & m_strProjectId & ")"
            m_strSQL = "usp_ProjectType_sel_tbl_PRS_ProjectTypes " & m_strProjectId
            ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            If drSQERT.Read Then
                m_strCategory = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectType"), "").ToString
                m_strCategoryId = CommonFunctions.Data.CheckIsDBNull(drSQERT("TypeId"), "").ToString
            End If
            CommonFunctions.Data.DisposeDataReader(drSQERT)


            If (m_strCategoryId <> "0") And (m_strCategoryId <> "") Then
                m_strQuery = m_strQuery & "," & m_strCategoryId
            Else
                m_strQuery = m_strQuery & ",NULL"
            End If
        Else
            m_strQuery = m_strQuery & ",NULL"
        End If

        ' Business Unit Filter
        If m_strBUId <> "" Then
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            ''  m_strSQL = "Select BusinessGroup from tbl_CNF_BusinessGroups where BusinessGroupID= " & m_strBUId
            m_strSQL = "usp_sel_BusinessGroup_tbl_CNF_BusinessGroups " & m_strBUId
            ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            If drSQERT.Read Then
                m_strBU = CommonFunctions.Data.CheckIsDBNull(drSQERT("BusinessGroup"), "").ToString
            End If
            CommonFunctions.Data.DisposeDataReader(drSQERT)
            m_strQuery = m_strQuery & "," & m_strBUId
        ElseIf m_strProjectId <> "" Then
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            ''m_strSQL = "Select BusinessGroupID, BusinessGroup from tbl_CNF_BusinessGroups where BusinessGroupID=(SELECT BusinessGroupID FROM tbl_PM_Project WHERE ProjectID= " & m_strProjectId & ")"
            m_strSQL = "usp_sel_BusinessGroupID_tbl_CNF_BusinessGroups " & m_strProjectId
            ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            If drSQERT.Read Then
                m_strBU = CommonFunctions.Data.CheckIsDBNull(drSQERT("BusinessGroup"), "").ToString
                m_strBUId = CommonFunctions.Data.CheckIsDBNull(drSQERT("BusinessGroupID"), "").ToString
            End If
            CommonFunctions.Data.DisposeDataReader(drSQERT)

            If (m_strBUId <> "0") And (m_strBUId <> "") Then
                m_strQuery = m_strQuery & "," & m_strBUId
            Else
                m_strQuery = m_strQuery & ",NULL"
            End If
        Else
            m_strQuery = m_strQuery & ",NULL"
        End If

        '=========================================================================================
        'Code Added :   PadmnabhA                               Wednesday, November 16, 2005 9:27
        'Purpose    :   To Display OU filter
        '========================================================================================= 
        ' Organization Unit Filter
        If m_strOUId <> "" Then
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            ''m_strSQL = "Select Location from tbl_PM_Location where LocationID= " & m_strOUId
            m_strSQL = "usp_sel_Location_tbl_PM_Location " & m_strOUId
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            If drSQERT.Read Then
                m_strOU = CommonFunctions.Data.CheckIsDBNull(drSQERT("Location"), "").ToString
            End If
            CommonFunctions.Data.DisposeDataReader(drSQERT)
            m_strQuery = m_strQuery & "," & m_strOUId
        ElseIf m_strProjectId <> "" Then
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            ''m_strSQL = "Select LocationID, Location from tbl_PM_Location where LocationID=(SELECT LocationID FROM tbl_PM_Project WHERE ProjectID= " & m_strProjectId & ")"
            m_strSQL = "usp_sel_LocationID_tbl_PM_Location " & m_strProjectId
            ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            If drSQERT.Read Then
                m_strOU = CommonFunctions.Data.CheckIsDBNull(drSQERT("Location"), "").ToString
                m_strOUId = CommonFunctions.Data.CheckIsDBNull(drSQERT("LocationID"), "").ToString
            End If
            CommonFunctions.Data.DisposeDataReader(drSQERT)

            If (m_strOUId <> "0") And (m_strOUId <> "") Then
                m_strQuery = m_strQuery & "," & m_strOUId

            Else
                m_strQuery = m_strQuery & ",NULL"
            End If
        Else
            m_strQuery = m_strQuery & ",NULL"
        End If

        'End Modification by MrugajaB on 13th April,2006
        '=========================================================================================
        'Additon Ends : PadmnabhA                               Wednesday, November 16, 2005 9:27
        '=========================================================================================

        If m_strMode.ToUpper = "SHOWHISTORY" Then
            WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_SHOWHISTORY") & m_strProjectName)
        Else
            WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_PROJECTSHEET"))
        End If

        If m_strMode.ToUpper = "" Or m_strMode.ToUpper = "CHANGE" Then
            CommonFunctions.General.WriteHTML("<DIV ID='DIVLIST' STYLE='overflow:auto;WIDTH:100%;HEIGHT=440px'>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='0' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TBODY><TR class=clsTREven > ")

            CommonFunctions.General.WriteHTML("<TD align='right' width=300>" & MyBase.GetResourceString("PRACTICE") & "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")

            'Display Category Combo        
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            ''CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboCategoryID", "Select TypeId, ProjectType From tbl_PRS_ProjectTypes Order By ProjectType", 300, m_strCategoryId, "" + " Langugage=JavaScript OnChange=cboCategory_change()", True, True, , False))
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboCategoryID", "usp_sel_tbl_PRS_ProjectTypes_ProjectType", 300, m_strCategoryId, "" + " Langugage=JavaScript OnChange=cboCategory_change()", True, True, , False))
            ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")


            CommonFunctions.General.WriteHTML("<TR class=clsTREven > ")
            CommonFunctions.General.WriteHTML("<TD align='right' width=300>" & MyBase.GetResourceString("BUSINESSGROUP") & "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")

            'Display Business Unit Combo
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboBUID", "usp_Sel_tbl_CNF_BusinessGroup", 300, m_strBUId, "" + " Langugage=JavaScript OnChange=cboBU_change()", True, True, , False))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")

            '=========================================================================================
            'Code Added :   PadmnabhA                               Wednesday, November 16, 2005 9:27
            'Purpose    :   To Display OU filter
            '========================================================================================= 
            CommonFunctions.General.WriteHTML("<TR class=clsTREven > ")
            CommonFunctions.General.WriteHTML("<TD align='right' width=300>" & MyBase.GetResourceString("ORAGNIZATIONUNIT") & "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")

            'Display Organization Unit Combo
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboOUID", m_strSQLOU, 300, m_strOUId, "" + " Langugage=JavaScript OnChange=cboOU_change()", True, True, , False))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            '=========================================================================================
            'Additon Ends : PadmnabhA                               Wednesday, November 16, 2005 9:27
            '=========================================================================================

            CommonFunctions.General.WriteHTML("<TR class=clsTREven > ")
            CommonFunctions.General.WriteHTML("<TD align='right' width=300>" & MyBase.GetResourceString("PROJECTGROUP") & "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")

            'Display Program Combo
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProgramID", "usp_Sel_tbl_CNF_ProjectGroup", 300, m_strProgramId, "" + " Langugage=JavaScript OnChange=cboProgram_change()", True, True, , False))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")

            CommonFunctions.General.WriteHTML("<TR class=clsTREven > ")
            CommonFunctions.General.WriteHTML("<TD align='right' width=300>" & MyBase.GetResourceString("PROJECT") & "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")

            'Display Project Combo
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProjectID", m_strSQLProject, 300, m_strProjectId, " onchange='javascript:cboProject_change()'", True, True, , False))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")


            'Display Reporting Date
            CommonFunctions.General.WriteHTML(" <TR class=clsTREven > ")
            CommonFunctions.General.WriteHTML("<TD align=right>" & MyBase.GetResourceString("REPORTINGDATE") & "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")
            CommonFunction.HTMLControls.DrawDateControl("txtReportingDate", "txtReportingDate", , , CommonFunction.Dates.GetDate(CType(m_strReportedDate, Date)), , "frmPM_SQERT", , , , , , , , True)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")

            CommonFunctions.General.WriteHTML(" <TR class=clsTREven > ")
            CommonFunctions.General.WriteHTML("<TD align=right>" & MyBase.GetResourceString("REPORTINGPERIOD") & "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")

            ' Commented By NitinVS on 14 Oct 2005 for WhizibleSEM SP4 
            ' Resource Timesheet frequency is to be shown 

            'CommonFunctions.HTMLControls.DrawOptionButton("optReportingPeriod", "optReportingPeriod", , True, "0", , "", , True)
            'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("REPORTING_FREQUENCY_WEEKLY"))
            'CommonFunctions.HTMLControls.DrawOptionButton("optReportingPeriod", "optReportingPeriod", , False, "1", , "", , True)
            'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("REPORTING_FREQUENCY_FORTNIGHTLY"))
            'CommonFunctions.HTMLControls.DrawOptionButton("optReportingPeriod", "optReportingPeriod", , False, "2", , "", , True)
            'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("REPORTING_FREQUENCY_MONTHLY"))

            Dim objReportingFreqDR As IDataReader
            Dim strFrequency As String
            Dim intFrequencyId As Integer

            objReportingFreqDR = CommonFunction.Data.GetDataReader("usp_SEL_Tbl_PM_companyInformation_ResourceTimeSheetFrequency", MyBase.UseSQL)
            If objReportingFreqDR.Read Then
                strFrequency = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objReportingFreqDR("Frequency"), ""), "")
                intFrequencyId = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objReportingFreqDR("FrequencyID"), "0"), "0"), Integer)
                m_intReportingPeriod = intFrequencyId
            End If

            CommonFunction.Data.DisposeDataReader(objReportingFreqDR)

            CommonFunction.General.WriteHTML(strFrequency)
            CommonFunction.HTMLControls.DrawTextBox("txtReportingFrequency", "txtReportingFrequency", value:=intFrequencyId.ToString, DisplayNone:=True, EnableHTMLEncode:=True)
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("</TR>")

            'Last locked date : hidden control
            CommonFunctions.General.WriteHTML("<input type=Hidden name='txtLastLockedDate' value='" & CommonFunction.Dates.GetDate(CType(m_dtmlastlockedDate, Date)) & "'>")
            CommonFunctions.General.WriteHTML("</TBODY></TABLE>")
        End If

        If m_strMode.ToUpper = "VIEWREPORT" Then
            CommonFunctions.General.WriteHTML("<DIV ID='PageDiv' STYLE='overflow:auto;width:100%;height=560px'>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
            CommonFunctions.General.WriteHTML("<TD align='Right' colspan=2 Width=25%> <b>" & MyBase.GetResourceString("BUSINESSGROUP") & "</b></td>")
            CommonFunctions.General.WriteHTML("<TD align='Left'  colspan=3 Width=25%> &nbsp;" & m_strBU & "</td>")
            '=========================================================================================
            'Code Added :   PadmnabhA                               Wednesday, November 16, 2005 9:27
            'Purpose    :   To Display OU filter
            '========================================================================================= 
            CommonFunctions.General.WriteHTML("<TD align='Right' colspan=2 Width=25%> <b>" & MyBase.GetResourceString("ORAGNIZATIONUNIT") & "</b></td>")
            CommonFunctions.General.WriteHTML("<TD align='Left'  colspan=3 Width=25%> &nbsp;" & m_strOU & "</td>")
            '=========================================================================================
            'Additon Ends : PadmnabhA                               Wednesday, November 16, 2005 9:27
            '=========================================================================================
            CommonFunctions.General.WriteHTML("</TR>")

            CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
            CommonFunctions.General.WriteHTML("<TD align='Right' colspan=2 Width=25%> <b>" & MyBase.GetResourceString("PROJECTGROUP") & "</b></td>")
            CommonFunctions.General.WriteHTML("<TD align='Left'  colspan=3 Width=25%> &nbsp;" & m_strProgramName & "</td>")
            CommonFunctions.General.WriteHTML("<TD align='Right' colspan=2 Width=25%> <b>" & MyBase.GetResourceString("PROJECT") & "</b></td>")
            CommonFunctions.General.WriteHTML("<TD align='Left'  colspan=3 Width=25%> &nbsp;" & m_strProjectName & "</td>")
            CommonFunctions.General.WriteHTML("</TR>")

            CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
            CommonFunctions.General.WriteHTML("<TD align='Right' colspan=2 Width=25%> <b>" & MyBase.GetResourceString("PRACTICE") & "</b></td>")
            CommonFunctions.General.WriteHTML("<TD align='Left'  colspan=3 Width=25%> &nbsp;" & m_strCategory & "</td>")
            CommonFunctions.General.WriteHTML("<TD align='Right' colspan=2 Width=25%> &nbsp; </td>")
            CommonFunctions.General.WriteHTML("<TD align='Left'  colspan=3 Width=25%> &nbsp;</td>")
            CommonFunctions.General.WriteHTML("</TR>")

            CommonFunctions.General.WriteHTML("</TABLE>")

            'Code Added By NiranjanK on Oct 10,2005
            'Purpose    : To Provide main section for SQERT details
            Dim objSQERTSection As New WebPages.Template.SectionTitle
            With objSQERTSection
                Response.Write(.GetSectionTitle("SQERT Details", "DivSQERTSection", "ShowHideSQERTSection"))
                Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
                Response.Write(.ClientsideScript())
                Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
            End With

            '--Div for section title
            Response.Write("<DIV Id='DivSQERTSection' Style='Overflow:Auto;Width=100%'>")
            'End of modification By NiranjanK on Oct 10,2005

            '======================================================================================
            ' First Block of Issues and Key achivement grids
            '======================================================================================
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TABLE border='0' CELLSPACING='0' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TR class=clsTREven valign='top'>")

            'Issues Grid
            CommonFunctions.General.WriteHTML("<TD>")
            Call DisplayIssueGrid()
            CommonFunctions.General.WriteHTML("</td>")

            'KEY achievements Grid
            CommonFunctions.General.WriteHTML("<TD>")
            Call DisplayKeyAchivement()
            CommonFunctions.General.WriteHTML("</td></TR>")

            CommonFunctions.General.WriteHTML("</TABLE>")
            '======================================================================================
            ' First Block of Issues and Key achivement grids completes
            '======================================================================================

            '======================================================================================
            ' SQERT draw section
            '======================================================================================
            Call DisplaySQERT()
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
            CommonFunctions.General.WriteHTML("<TD VAlign=TOP colspan=3>")
            CommonFunctions.General.WriteHTML("<div id='divList2' style='overflow:auto;height=220;Width:100%;'>")


            '======================================================================================
            ' Milestone draw section
            '======================================================================================
            Call DisplayMileStoneDetails()

            CommonFunctions.General.WriteHTML("</DIV></TD>")
            CommonFunction.General.WriteHTML("</TR></TABLE>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TR>")

            ' To show the baseline details only when the Project Creation Workflow is applicable 
            CommonFunctions.General.WriteHTML("<TD VAlign=TOP >")
            CommonFunctions.General.WriteHTML("<div id='divListBaseLine' style='overflow:auto;height=220;Width:100%;'>")

            '======================================================================================
            ' BASELINE draw section
            '======================================================================================
            If m_strProjectId <> "" Then
                Dim bln_IsprojectCreationWorkflowReqd As Boolean
                ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                ''bln_IsprojectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT ISNull(IsProjectCreationWorkFlowReqd,0) FROM tbl_PRS_ProjectTypes , Tbl_PM_Project WHERE tbl_PRS_ProjectTypes.TypeID =  Tbl_PM_Project.ProjectTypeID AND  ProjectID =  " + m_strProjectId, MyBase.UseSQL), "0"), Boolean)
                bln_IsprojectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PRS_ProjectTypes_IsProjectCreationWorkFlowReqd " + m_strProjectId, MyBase.UseSQL), "0"), Boolean)
                ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                If bln_IsprojectCreationWorkflowReqd = True Then
                    Call DisplayBaselineDetails()
                End If
            Else
                Call DisplayBaselineDetails()
            End If


            CommonFunction.General.WriteHTML("</DIV></TD>")

            '======================================================================================
            ' Active Resource draw section
            '======================================================================================
            If m_strProjectId <> "" Then
                CommonFunctions.General.WriteHTML("<TD VAlign=TOP >")
                CommonFunctions.General.WriteHTML("<div id='divListActiveResource' style='overflow:auto;height=220;Width:100%;'>")

                Call DisplayActiveResourceGrid()

                CommonFunction.General.WriteHTML("</DIV>")
                CommonFunction.General.WriteHTML("</TD>")
            End If
            CommonFunctions.General.WriteHTML("</TR>")

            CommonFunctions.General.WriteHTML("</TABLE>")

            CommonFunctions.General.WriteHTML("</DIV>")
            CommonFunctions.General.WriteHTML("</BR>")

            '======================================================================================
            ' EV section
            '======================================================================================

            ' show EV only When the Flag EVApplicable in tbl_PM_Project is 1 
            If m_strProjectId <> "" Then
                Dim blnEVApplicable As Boolean
                ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                ''blnEVApplicable = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT IsNull(EVApplicable, 0) FROM tbl_PM_Project WHERE ProjectID = " + m_strProjectId, MyBase.UseSQL), "0"), Boolean)
                blnEVApplicable = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_Project_EVApplicable " + m_strProjectId, MyBase.UseSQL), "0"), Boolean)
                ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
                If blnEVApplicable = True Then

                    'To generate seperate Earned Value Report Section
                    Dim objEVRSection As New WebPages.Template.SectionTitle
                    With objEVRSection
                        Response.Write(.GetSectionTitle(MyBase.GetResourceString("TITLE_EVREPORT"), "DivEVRSection", "ShowHideEVRSection"))
                        Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
                        Response.Write(.ClientsideScript())
                        Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
                    End With
                    Response.Write("<DIV Id='DivEVRSection' Style='Overflow:Auto;Width=100%'>")
                    'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                    CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
                    'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                    CommonFunctions.General.WriteHTML("<TR><TD VAlign=TOP>")
                    Call DisplayEVDetails()

                    CommonFunctions.General.WriteHTML("</TD>")
                    CommonFunctions.General.WriteHTML("<TD>")

                    Call GenerateReportGraph()

                    CommonFunctions.General.WriteHTML("</TD>")
                    CommonFunctions.General.WriteHTML("</TR>")
                    CommonFunctions.General.WriteHTML("</TABLE>")
                    CommonFunctions.General.WriteHTML("</DIV>")
                End If
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
                'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                CommonFunctions.General.WriteHTML("<TR>")
                CommonFunctions.General.WriteHTML("<TD colspan=3>")
                Call ShowGraphSection()
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("</TR>")
                CommonFunctions.General.WriteHTML("</TABLE>")
            Else
                CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
                CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD colspan=3 align='Center' Width=50%>" & MyBase.GetResourceString("EVNAMESSAGE") & "</td></TR>")
                CommonFunctions.General.WriteHTML("</TABLE>")
            End If
        End If

        If m_strMode.ToUpper = "ISSUEDETAILS" Then
            Call DisplayIssueDetails()
        End If

        ' Task Details grid genartion
        If m_strMode.ToUpper = "TASKDETAILS" Then
            Call DisplayTaskDetails()
        End If

        ' Risk Details grid genartion
        If m_strMode.ToUpper = "RISK" Then
            Call DisplayRiskDetails()
        End If

        ' SQERT Details grid genartion
        If m_strMode.ToUpper = "SQERTDETAILS" Then
            Call displaySQERTDetails()
        End If

        ' Deliverable Details grid genartion
        If m_strMode.ToUpper = "DELIVERABLESDETAILS" Then
            Call DisplayDeliverableDetails()
        End If

        ' SQERT History
        ' Code Added by RajkumarM to Add History Link in SQERT Entry Screen%>
        If m_strMode = "ShowHistory" Then
            'Modified by NitinVS on 2 Aug 2007 for WhizibleSEM 7
            'Removed the PCFC from sp name changed usp_CRW_PCFC_ProjectSheet_ShowHistory to usp_CRW_ProjectSheet_ShowHistory
            m_strSQL = "Exec usp_CRW_ProjectSheet_ShowHistory " & m_strProjectId
            'End Modification by NitinVS on 2 Aug 2007 for WhizibleSEM 7

            drSQERTValues = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

            CommonFunctions.General.WriteHTML("<DIV ID='DIVLIST' STYLE='overflow:auto;width:100%;height=410px'>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<table cellSpacing='0' cellPadding='0' width='99.9%' border='0'><tbody>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<tr  class='clsTRColumnHeader' ><td align='left' width=10%>" & MyBase.GetResourceString("REPORTINGDATE") & "</td>")
            CommonFunction.General.WriteHTML("<td align='left' width=10%>" & MyBase.GetResourceString("LOCKEDDATE") & "</td>	")
            CommonFunction.General.WriteHTML("<td align='left' width=5%>" & MyBase.GetResourceString("SCOPE") & "</td>")
            CommonFunction.General.WriteHTML("<td align='left' width=5%>" & MyBase.GetResourceString("QUALITY") & "</td>	")
            CommonFunction.General.WriteHTML("<td align='left' width=5%>" & MyBase.GetResourceString("EFFORT") & "</td>	")
            CommonFunction.General.WriteHTML("<td align='left' width=5%>" & MyBase.GetResourceString("RISK") & "</td>	")
            CommonFunction.General.WriteHTML("<td align='left' width=5%>" & MyBase.GetResourceString("TIME") & "</td>	")
            CommonFunction.General.WriteHTML("<td align='left' width=40%>" & MyBase.GetResourceString("COMMENTS") & "</td></tr>")
            intcnt = 0
            While drSQERTValues.Read
                intcnt = intcnt + 1

                If (intcnt Mod 2) = 0 Then
                    strClass = "clsTDEven"
                Else
                    strClass = "clsTDOdd"
                End If

                CommonFunction.General.WriteHTML("<TR><TD class=" & strClass & ">" & CommonFunctions.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("ReportingDate"), ""), Date)) & "</TD>")
                CommonFunction.General.WriteHTML("<TD class=" & strClass & ">" & CommonFunctions.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("LockedDate"), ""), Date)) & "</TD>")
                CommonFunction.General.WriteHTML("<TD class=" & strClass & ">" & CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("Scope"), ""), Integer) & "</TD>")
                CommonFunction.General.WriteHTML("<TD class=" & strClass & ">" & CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("Quality"), ""), Integer) & "</TD>")
                CommonFunction.General.WriteHTML("<TD class=" & strClass & ">" & CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("Effort"), ""), Integer) & "</TD>")
                CommonFunction.General.WriteHTML("<TD class=" & strClass & ">" & CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("Risk"), ""), Integer) & "</TD>")
                CommonFunction.General.WriteHTML("<TD class=" & strClass & ">" & CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("Time"), ""), Integer) & "</TD>")
                CommonFunction.General.WriteHTML("<TD class=" & strClass & "><b>" & MyBase.GetResourceString("SCOPE") & "&nbsp;&nbsp; : </b>" & CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("ScopeDesc"), ""), String) & "</TD></TR>")
                CommonFunction.General.WriteHTML("<TR><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td>")
                CommonFunction.General.WriteHTML("<TD class=" & strClass & "><b>" & MyBase.GetResourceString("QUALITY") & " : </b>" & CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("QualityDesc"), ""), String) & "</TD></TR>")
                CommonFunction.General.WriteHTML("<TR><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td>")
                CommonFunction.General.WriteHTML("<TD class=" & strClass & "><b>" & MyBase.GetResourceString("EFFORT") & "&nbsp;&nbsp; : </b>" & CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("EffortDesc"), ""), String) & "</TD></TR>")
                CommonFunction.General.WriteHTML("<TR><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td>")
                CommonFunction.General.WriteHTML("<TD class=" & strClass & "><b>" & MyBase.GetResourceString("RISK") & "&nbsp;&nbsp;&nbsp;&nbsp; : </b>" & CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("RiskDesc"), ""), String) & "</TD></TR>")
                CommonFunction.General.WriteHTML("<TR><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td><TD class=" & strClass & "></td>")
                CommonFunction.General.WriteHTML("<TD class=" & strClass & "><b>" & MyBase.GetResourceString("TIME") & "&nbsp;&nbsp;&nbsp; : </b>" & CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("TimeDesc"), ""), String) & "</TD></TR>")

            End While

            If intcnt = 0 Then
                CommonFunction.General.WriteHTML("<TR class=clsTREven><TD colspan=8 align='Center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
            End If

            CommonFunctions.Data.DisposeDataReader(drSQERTValues)
            CommonFunction.General.WriteHTML("</TBODY></Table></Div>")
        End If
        'End of History Part

        ' Save SQERT Values
        ' Code Added by RajkumarM to Save SQERT Values from SQERT Entry Screen
        If m_strMode = "SaveSQERTValues" Then
            intScope = CType(Request("txtScope"), Integer)
            intQuality = CType(Request("txtQuality"), Integer)
            intEffort = CType(Request("txtEffort"), Integer)
            intRisk = CType(Request("txtRisk"), Integer)
            intTime = CType(Request("txtTime"), Integer)
            StrScopeDesc = Left(Trim(Request("txtScopeDesc")), 500)
            StrQualityDesc = Left(Trim(Request("txtQualityDesc")), 500)
            StrEffortDesc = Left(Trim(Request("txtEffortDesc")), 500)
            StrRiskDesc = Left(Trim(Request("txtRiskDesc")), 500)
            StrTimeDesc = Left(Trim(Request("txtTimeDesc")), 500)
            strGeneralRemarks = Left(Trim(Request("txtGeneralRemarks")), 1000)
            strEscalations = Left(Trim(Request("txtEscalations")), 1000)
            If m_strAction <> "Add" Then
                intSQERTID = CType(Request("txtSQERTID"), Integer)
            Else
                intSQERTID = 0
            End If
            'Modified by NitinVS on 2 Aug 2007 for WhizibleSEM 7
            'Removed the PCFC from sp name changed usp_CRW_PCFC_ProjectSheet_InsertSQERTValues to usp_CRW_ProjectSheet_InsertSQERTValues
            m_strSQL = "Exec usp_CRW_ProjectSheet_InsertSQERTValues " & m_strProjectId & ",'" & m_dtmReportingEndDate
            'End Modification by NitinVS on 2 Aug 2007 for WhizibleSEM 7

            m_strSQL = m_strSQL & "'," & intScope & "," & intQuality & "," & intEffort & "," & intRisk & "," & intTime
            m_strSQL = m_strSQL & ",'" & BuildQueryString(StrScopeDesc) & "','" & BuildQueryString(StrQualityDesc) & "','"
            m_strSQL = m_strSQL & BuildQueryString(StrEffortDesc) & "','" & BuildQueryString(StrRiskDesc) & "','"
            m_strSQL = m_strSQL & BuildQueryString(StrTimeDesc) & "'," & Session("intUserID").ToString & ", "
            m_strSQL = m_strSQL & "'" & BuildQueryString(strGeneralRemarks) & "'" & ", " & "'" & BuildQueryString(strEscalations) & "'"
            If intSQERTID <> 0 Then
                m_strSQL = m_strSQL & "," & intSQERTID
            End If

            If m_strAction <> "Add" Then
                drSQERTValues = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            End If
            CommonFunctions.Data.DisposeDataReader(drSQERTValues)
            m_strMode = "SQERTValues"
        End If

        ' Added for SQERT Entry Screen by RajkumarM on 11th Jan 05
        If m_strMode.ToUpper = "SQERTVALUES" Then
            Dim strDescTitle As String
            If m_strAction <> "Add" Then
                intSQERTID = 0
                intScope = 0
                intQuality = 0
                intEffort = 0
                intRisk = 0
                intTime = 0
                StrScopeDesc = ""
                StrQualityDesc = ""
                StrEffortDesc = ""
                StrRiskDesc = ""
                StrTimeDesc = ""
                blnLocked = False
                strGeneralRemarks = ""
                strEscalations = ""
                'Modified by NitinVS on 2 Aug 2007 for WhizibleSEM 7
                'Removed the PCFC from sp name changed usp_CRW_PCFC_ProjectSheet_GetSQERTValues to usp_CRW_ProjectSheet_GetSQERTValues
                m_strSQL = " Exec usp_CRW_ProjectSheet_GetSQERTValues " & m_strProjectId
                'End Modification By NitinVS on 2 Aug 2007 for WhizibleSEM 7

                drSQERTValues = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
                If drSQERTValues.Read Then
                    intSQERTID = CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("SQERTID"), ""), Integer)
                    intScope = CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("Scope"), ""), Integer)
                    intQuality = CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("Quality"), ""), Integer)
                    StrScopeDesc = CommonFunctions.Data.CheckIsDBNull(drSQERTValues("ScopeDesc"), "").ToString
                    StrQualityDesc = CommonFunctions.Data.CheckIsDBNull(drSQERTValues("QualityDesc"), "").ToString
                    StrEffortDesc = CommonFunctions.Data.CheckIsDBNull(drSQERTValues("EffortDesc"), "").ToString
                    StrRiskDesc = CommonFunctions.Data.CheckIsDBNull(drSQERTValues("RiskDesc"), "").ToString
                    StrTimeDesc = CommonFunctions.Data.CheckIsDBNull(drSQERTValues("TimeDesc"), "").ToString
                    blnLocked = CType(CommonFunctions.Data.CheckIsDBNull(drSQERTValues("Locked"), ""), Boolean)
                    strGeneralRemarks = CommonFunctions.Data.CheckIsDBNull(drSQERTValues("GeneralRemarks"), "").ToString
                    strEscalations = CommonFunctions.Data.CheckIsDBNull(drSQERTValues("Escalations"), "").ToString
                End If
                CommonFunctions.Data.DisposeDataReader(drSQERTValues)

            End If
            If blnLocked = True Then
                blnDisable = True
            Else
                blnDisable = False
            End If

            m_strSQL = " Exec usp_Sel_EarnedValueReportvalues '" & m_dtmProjectStartDate & "','" & m_dtmReportingEndDate & "'," & m_strProjectId

            drEv = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            If drEv.Read Then
                intTime = CType(CommonFunctions.Data.CheckIsDBNull(drEv("Time"), ""), Integer)
                intEffort = CType(CommonFunctions.Data.CheckIsDBNull(drEv("Effort"), ""), Integer)
                intRisk = CType(CommonFunctions.Data.CheckIsDBNull(drEv("Risk"), ""), Integer)
            End If
            CommonFunctions.Data.DisposeDataReader(drEv)
            'End mod

            ' UI for SQERT Values
            CommonFunctions.General.WriteHTML("<DIV ID='PageDiv' STYLE='overflow:auto;width:100%;height=400px'>")
            CommonFunctions.General.WriteHTML("<DIV ID='DIVLIST' STYLE='overflow:auto;width:100%;height=230px'>")
            CommonFunction.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'><TR class='clsTRColumnHeader'>")
            CommonFunction.General.WriteHTML("<TD width='15%'>" & MyBase.GetResourceString("UPD_SQERT") & "</TD>")
            CommonFunction.General.WriteHTML("<TD align=center width='9%'>" & MyBase.GetResourceString("UPD_VALUE") & "</TD><TD align=center width='80%'>" & MyBase.GetResourceString("UPD_DESCRIPTION") & "</TD></TR>")
            CommonFunction.General.WriteHTML("<TR class=clsTREven>")

            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("txtscopelow", "txtscopelow", , , , intScopelow.ToString, , , , , , True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtscopehigh", "txtscopehigh", , , , intScopehigh.ToString, , , , , , True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtqualitylow", "txtqualitylow", , , , intQualitylow.ToString, , , , , , True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtqualityhigh", "txtqualityhigh", , , , intQualityHigh.ToString, , , , , , True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtSQERTID", "txtSQERTID", , , , intSQERTID.ToString, , , , , , True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtProjectID", "txtProjectID", , , , m_strProjectId, , , , , , True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtReportingDate", "txtReportingDate", , , , m_dtmReportingEndDate.ToString, , , , , , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding

            ' Scope
            strDescTitle = MyBase.GetResourceString("UPD_SCOPE") & " " & MyBase.GetResourceString("UPD_DESCRIPTION")
            CommonFunction.General.WriteHTML("<TD valign=top><B>" & MyBase.GetResourceString("UPD_SCOPE") & "</b></TD>")
            CommonFunction.General.WriteHTML("<TD align=Right valign=top>")

            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("txtScope", "txtScope", , 40, 10, intScope.ToString, "Right", , blnDisable, , , , "onkeypress=Javascript:OnlyNumeric(1)", , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.General.WriteHTML("</TD><TD valign=top>")
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'CommonFunction.HTMLControls.DrawTextArea("txtScopeDesc", "txtScopeDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrScopeDesc, , , blnDisable, , , , , , True)
            CommonFunction.HTMLControls.DrawTextArea("txtScopeDesc", "txtScopeDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrScopeDesc, , , blnDisable, , , , , , True, EnableHTMLEncode:=True)
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'Quality
            strDescTitle = MyBase.GetResourceString("UPD_QUALITY") & " " & MyBase.GetResourceString("UPD_DESCRIPTION")
            CommonFunction.General.WriteHTML("</TD></TR><TR class=clsTREven><TD valign=top><B>" & MyBase.GetResourceString("UPD_QUALITY") & "</b></TD><TD  align=Right valign=top>")

            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("txtQuality", "txtQuality", , 40, 10, intQuality.ToString, "Right", , blnDisable, , , , "onkeypress=Javascript:OnlyNumeric(1)", , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.General.WriteHTML("</TD><TD valign=top>")
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'CommonFunction.HTMLControls.DrawTextArea("txtQualityDesc", "txtQualityDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrQualityDesc, , , blnDisable, , , , , , True)
            CommonFunction.HTMLControls.DrawTextArea("txtQualityDesc", "txtQualityDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrQualityDesc, , , blnDisable, , , , , , True, EnableHTMLEncode:=True)
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'Effort
            strDescTitle = MyBase.GetResourceString("UPD_EFFORT") & " " & MyBase.GetResourceString("UPD_DESCRIPTION")
            CommonFunction.General.WriteHTML("</TD></TR><TR class=clsTREven><TD valign=top><B>" & MyBase.GetResourceString("UPD_EFFORT") & "</b></TD><TD  align=Right valign=top>")

            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("txtEffort", "txtEffort", , 40, 10, intEffort.ToString, "Right", , blnDisable, True, , , "onkeypress=Javascript:OnlyNumeric(1)", , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.General.WriteHTML("</TD><TD valign=top>")
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'CommonFunction.HTMLControls.DrawTextArea("txtEffortDesc", "txtEffortDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrEffortDesc, , , blnDisable, , , , , , True)
            CommonFunction.HTMLControls.DrawTextArea("txtEffortDesc", "txtEffortDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrEffortDesc, , , blnDisable, , , , , , True, EnableHTMLEncode:=True)
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'Risk
            strDescTitle = MyBase.GetResourceString("UPD_RISK") & " " & MyBase.GetResourceString("UPD_DESCRIPTION")
            CommonFunction.General.WriteHTML("</TD></TR><TR class=clsTREven><TD valign=top><B>" & MyBase.GetResourceString("UPD_RISK") & "</b></TD><TD align=Right valign=top>")

            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("txtRisk", "txtRisk", , 40, 10, intRisk.ToString, "Right", , blnDisable, True, , , "onkeypress=Javascript:OnlyNumeric(1)", , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.General.WriteHTML("</TD><TD valign=top>")
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'CommonFunction.HTMLControls.DrawTextArea("txtRiskDesc", "txtRiskDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrRiskDesc, , , blnDisable, , , , , , True)
            CommonFunction.HTMLControls.DrawTextArea("txtRiskDesc", "txtRiskDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrRiskDesc, , , blnDisable, , , , , , True, EnableHTMLEncode:=True)
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'Time
            strDescTitle = MyBase.GetResourceString("UPD_TIME") & " " & MyBase.GetResourceString("UPD_DESCRIPTION")
            CommonFunction.General.WriteHTML("</TD></TR><TR class=clsTREven><TD valign=top><B>" & MyBase.GetResourceString("UPD_TIME") & "</b></TD><TD align=Right valign=top>")

            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("txtTime", "txtTime", , 40, 10, intTime.ToString, "Right", , blnDisable, True, , , "onkeypress=Javascript:OnlyNumeric(1)", , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.General.WriteHTML("</TD><TD valign=top>")
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'CommonFunction.HTMLControls.DrawTextArea("txtTimeDesc", "txtTimeDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrTimeDesc, , , blnDisable, , , , , , True)
            CommonFunction.HTMLControls.DrawTextArea("txtTimeDesc", "txtTimeDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrTimeDesc, , , blnDisable, , , , , , True, EnableHTMLEncode:=True)
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            CommonFunction.General.WriteHTML("</TD></TR></TABLE>")
            ' Addition Ends

            CommonFunction.General.WriteHTML("</DIv>")

            'General Remarks and Escalations 
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE CELLSPACING='0' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TR class='clsTRColumnHeader'><TD colspan=2 width='100%'><B>" & MyBase.GetResourceString("UPDATE_SQERT_GENERALREMARKS_ESCALATION") & " </B><br></TD></TR>")

            CommonFunction.General.WriteHTML("<TR class='clsTREven'><TD width='15%'> " & MyBase.GetResourceString("UPDATE_SQERT_GENERALREMARKS") & " </TD><TD>")
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'CommonFunction.HTMLControls.DrawTextArea("txtGeneralRemarks", "txtGeneralRemarks", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, strGeneralRemarks, , , blnDisable, , , , , , False)
            CommonFunction.HTMLControls.DrawTextArea("txtGeneralRemarks", "txtGeneralRemarks", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, strGeneralRemarks, , , blnDisable, , , , , , False, EnableHTMLEncode:=True)
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            CommonFunction.General.WriteHTML("</TD></TR>")
            CommonFunction.General.WriteHTML("</TD></TR>")

            CommonFunction.General.WriteHTML("<TR class='clsTROdd'><TD width='15%'> " & MyBase.GetResourceString("UPDATE_SQERT_ESCALATION") & " </TD><TD>")
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'CommonFunction.HTMLControls.DrawTextArea("txtEscalations", "txtEscalations", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, strEscalations, , , blnDisable, , , , , , False)
            CommonFunction.HTMLControls.DrawTextArea("txtEscalations", "txtEscalations", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, strEscalations, , , blnDisable, , , , , , False, EnableHTMLEncode:=True)
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            CommonFunction.General.WriteHTML("</TD></TR>")
            CommonFunction.General.WriteHTML("</TR></TABLE></BR>")

            'show notes 
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE CELLSPACING='0' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TR class='clsTREven'><TD width='15%'><B>NOTE :</B><br><I>" & MyBase.GetResourceString("UPDATE_SQERT_NOTE_EFFORT") & "</I></TD></TR>")
            CommonFunction.General.WriteHTML("<TR class='clsTREven'><TD width='15%'><I>" & MyBase.GetResourceString("UPDATE_SQERT_NOTE_QUALITY") & "</I></TD></TR>")
            CommonFunction.General.WriteHTML("<TR class='clsTREven'><TD width='15%'><I>" & MyBase.GetResourceString("UPDATE_SQERT_NOTE_RISK") & "</I></TD></TR>")
            CommonFunction.General.WriteHTML("<TR class='clsTREven'><TD width='15%'><I>" & MyBase.GetResourceString("UPDATE_SQERT_NOTE_SCOPE") & "</I></TD></TR>")
            CommonFunction.General.WriteHTML("<TR class='clsTREven'><TD width='15%'><I>" & MyBase.GetResourceString("UPDATE_SQERT_NOTE_TIME") & "</I></TD>")
            CommonFunction.General.WriteHTML("</TR></TABLE>")
        End If
        CommonFunctions.General.WriteHTML("</DIV>")
    End Sub
    Private Sub DisplayActiveResourceGrid()
        '=====================================================================
        ' Procedure Name        : DrawActiveResourceGrid()	
        ' Purpose               : procedure to show the grid for Active Resource 
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS 
        ' Created               : Oct 11 , 2005
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim arrstrActualList() As String = {"Resource", "Start Date", "End Date", "Work(Hrs)", "Actual Work(Hrs)"}
        Dim arrstrUserFriendlyList() As String = {"Resource", "Start Date", "End Date", "Work(Hrs)", "Actual Work(Hrs)"}
        Dim arrstrTDStyle() As String = {" align=left width='60%'", " align=left width='10%'", " align=left width='10%'", " align=right width='10%'", " align=right width='10%'"}
        Dim strGRID As String

        ' show the title 
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunction.General.WriteHTML("<TABLE  cellSpacing='0' cellPadding='0' width='99.9%' border='0'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunction.General.WriteHTML("<tr  class='clsTRPageCaption' ><td align='left' width=10%>" & CommonFunction.General.CheckIsNothing(MyBase.GetResourceString("ACTIVE_RESOURCES"), "Active Resources") & "</td>")
        CommonFunction.General.WriteHTML("</TD></TR></TABLE>")

        strSQL = "usp_Sel_PB_RD_ResourceDetailsForProject " + m_strProjectId

        With m_objActiveResourceGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .TDStyleArray = arrstrTDStyle
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .SQL = strSQL
            .DIVHeight = 0
            .returnHTML = False
            .UseSQL = MyBase.UseSQL
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
    End Sub

    Private Sub DisplayIssueGrid()
        '=====================================================================
        ' Procedure Name        :   DisplayActiveResourceGrid()	
        ' Purpose               :   procedure to show the grid for Issue Details 
        ' Description           :   same as above
        ' Parameters Passed     :   none
        ' Returns               :   none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                :   NitinVS 
        ' Created               :   Oct 11 , 2005
        ' Revisions             :   By      :   Padmnabh Anturkar
        '                           Purpose :   1. To Display Issues Trend Graph
        '                                       2. To Display Issues shown to Customer
        '                           Date    :   November 17, 2005
        '=====================================================================

        'VARIABLES FOR ISSUES BLOCK ONLY
        Dim m_intTotalIssues As Integer
        Dim m_intOpenIssues As Integer
        Dim m_intCustomerReportedIssues As Integer ' Added to display customer reported issues
        Dim m_intClosedIssues As Integer
        Dim m_intOverDueIssues As Integer
        Dim drSQERT As IDataReader
        Dim m_strSQL As String

        If m_strProjectFilters <> "NULL" Then
            m_strSQL = "Exec USP_RPT_GetOpenAndClosedIssues " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',0," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec USP_RPT_GetOpenAndClosedIssues " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',0," & CType(Session("intUserID"), String) & ",NULL"
        End If

        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        If drSQERT.Read Then
            m_intTotalIssues = CType(drSQERT("TotalIssues"), Integer)
            m_intOpenIssues = CType(drSQERT("OpenIssues"), Integer)
            m_intClosedIssues = CType(drSQERT("ClosedIssues"), Integer)
            m_intOverDueIssues = CType(drSQERT("OverDueIssues"), Integer)
            m_intCustomerReportedIssues = CType(drSQERT("CustReportedIssues"), Integer)
        End If
        CommonFunctions.Data.DisposeDataReader(drSQERT)

        'inner table for issues
        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' BORDER='0'>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='Center' colspan=3 Width=100%> <b>" & MyBase.GetResourceString("TITLE_ISSUES") & "</b></td></TR>")

        'Issues Trend Graph
        If m_strProjectId <> "" Then
            CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>" & MyBase.GetResourceString("ISSUEGRAPH") & "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=Left width='5%'> </TD>")
            CommonFunctions.General.WriteHTML("<TD align=Left width='40%'>")
            CommonFunctions.General.WriteHTML("<a Href=""javascript:ShowGraphLink_onClick()"">Show Graph</a>")
            CommonFunctions.General.WriteHTML("</td></TR>")
        End If

        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>" & MyBase.GetResourceString("TOTALISSUES") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='5%'> " & m_intTotalIssues & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='40%'>")
        CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('TotalIssues')"">" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</a>")
        CommonFunctions.General.WriteHTML("</td></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>" & MyBase.GetResourceString("TOTALOPENISSUES") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='5%'> " & m_intOpenIssues & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='40%'>")
        CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('OpenIssues')"">" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</a>")
        CommonFunctions.General.WriteHTML("</td></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>" & MyBase.GetResourceString("CUSTOMERREPORTEDISSUES") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='5%'> " & m_intCustomerReportedIssues & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='40%'>")
        CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('CustReportedIssues')"">" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</a>")
        CommonFunctions.General.WriteHTML("</td></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>" & MyBase.GetResourceString("TOTALCLOSEDISSUES") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='5%'> " & m_intClosedIssues & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='40%'>")
        CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('ClosedIssues')"">" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</a>")
        CommonFunctions.General.WriteHTML("</td></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'><FONT color='red'>" & MyBase.GetResourceString("TOTALOVERDUEISSUES") & "</FONT></TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='5%'><FONT color='red'> " & m_intOverDueIssues & " </FONT></TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='40%'>")
        CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('OverDueIssues')""><FONT color='red'>" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</FONT></a>")
        CommonFunctions.General.WriteHTML("</td></TR>")


        CommonFunctions.General.WriteHTML("</TABLE>")
    End Sub
    Private Sub DisplayKeyAchivement()
        '=====================================================================
        ' Procedure Name        : DisplayKeyAchivement()	
        ' Purpose               : procedure to show the grid for Issue Details 
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS 
        ' Created               : Oct 11 , 2005
        ' Revisions             :   By PadmnbhA
        '                           On November 24, 2005 
        '=====================================================================
        'TABLE FOR KEY achievements
        Dim m_intCompletedTasks As Integer
        Dim m_intCompletedDeliverables As Integer
        Dim m_intTobeCompletedTasks As Integer
        Dim m_intTobeCompletedDeliverables As Integer
        Dim m_intSlippingTasks As Integer
        Dim m_intSlippingDeliverables As Integer

        Dim m_strSQL As String
        Dim drSQERT As IDataReader

        '=========================================================================================
        '1. Calculation of count of Tasks completed in reporting period
        '=========================================================================================
        If m_strProjectFilters <> "NULL" Then
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',0," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',0," & CType(Session("intUserID"), String) & ",NULL"
        End If
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        If drSQERT.Read Then
            m_intCompletedTasks = CType(drSQERT("CompletedTasks"), Integer)
        End If
        CommonFunctions.Data.DisposeDataReader(drSQERT)

        '=========================================================================================
        '2. Calculation of count of Tasks to be completed in next reporting period
        '=========================================================================================
        If m_strProjectFilters <> "NULL" Then
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmNextReportingStartDate & "','" & m_dtmNextReportingEndDate & "',1," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmNextReportingStartDate & "','" & m_dtmNextReportingEndDate & "',1," & CType(Session("intUserID"), String) & ",NULL"
        End If
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        If drSQERT.Read Then
            m_intTobeCompletedTasks = CType(drSQERT("TobeCompletedTasks"), Integer)
        End If
        CommonFunctions.Data.DisposeDataReader(drSQERT)

        '=========================================================================================
        '3. Calculation of count of Slipping Tasks in reporting period
        '=========================================================================================
        If m_strProjectFilters <> "NULL" Then
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',7," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',7," & CType(Session("intUserID"), String) & ",NULL"
        End If
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        If drSQERT.Read Then
            m_intSlippingTasks = CType(drSQERT("SlippingTasks"), Integer)
        End If
        CommonFunctions.Data.DisposeDataReader(drSQERT)

        '=========================================================================================
        '4. Calculation of count of Deliverables completed in reporting period
        '=========================================================================================
        If m_strProjectFilters <> "NULL" Then
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',9," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',9," & CType(Session("intUserID"), String) & ",NULL"
        End If
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        If drSQERT.Read Then
            m_intCompletedDeliverables = CType(drSQERT("CompletedDeliverables"), Integer)
        End If
        CommonFunctions.Data.DisposeDataReader(drSQERT)

        '=========================================================================================
        '5. Calculation of count of Deliverables to be completed in next reporting period
        '=========================================================================================
        If m_strProjectFilters <> "NULL" Then
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmNextReportingStartDate & "','" & m_dtmNextReportingEndDate & "',13," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmNextReportingStartDate & "','" & m_dtmNextReportingEndDate & "',13," & CType(Session("intUserID"), String) & ",NULL"
        End If
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        If drSQERT.Read Then
            m_intTobeCompletedDeliverables = CType(drSQERT("TobeCompletedDeliverables"), Integer)
        End If
        CommonFunctions.Data.DisposeDataReader(drSQERT)

        '=========================================================================================
        '6. Calculation of count of Slipping Deliverables in reporting period
        '=========================================================================================
        If m_strProjectFilters <> "NULL" Then
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',11," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',11," & CType(Session("intUserID"), String) & ",NULL"
        End If
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        If drSQERT.Read Then
            m_intSlippingDeliverables = CType(drSQERT("SlippingDeliverables"), Integer)
        End If
        CommonFunctions.Data.DisposeDataReader(drSQERT)

        '=========================================================================================
        'Key Achivements and Slippage section 
        '=========================================================================================
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='Center'  colspan=3 Width=100%> <b>" & MyBase.GetResourceString("TITLE_KEYACHIVEMENTS") & "</b></td></TR>")
        CommonFunctions.General.WriteHTML("<TR></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>" & MyBase.GetResourceString("TOTALTASKCOMP") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='10%'> " & m_intCompletedTasks & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='20%'>")
        CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('CompletedTasks')"">" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</a>")
        CommonFunctions.General.WriteHTML("</td></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>" & MyBase.GetResourceString("TOTALDELIVERABLESCOMP") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='10%'> " & m_intCompletedDeliverables & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='20%'>")
        CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('CompletedDeliverables')"">" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</a>")
        CommonFunctions.General.WriteHTML("</td></TR>")

        CommonFunctions.General.WriteHTML("<TR></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='Center'  colspan=3> <b>" & MyBase.GetResourceString("TITLE_SLIPPINGTASKS") & "</b></td></TR>")
        CommonFunctions.General.WriteHTML("<TR></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'><FONT color='red'>" & MyBase.GetResourceString("SLIPPINGTASKS") & "</FONT></TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='10%'><FONT color='red'> " & m_intSlippingTasks & "</FONT></TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='20%'>")
        CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('SLIPPINGTASKS')""><FONT color='red'>" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</FONT></a>")
        CommonFunctions.General.WriteHTML("</td></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'><FONT color='red'>" & MyBase.GetResourceString("TOTALDELIVERABLESSLIPPING") & "</FONT></TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='10%'><FONT color='red'> " & m_intSlippingDeliverables & "</FONT></TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='20%'>")
        CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('SlippingDeliverables')""><FONT color='red'>" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</FONT></a>")
        CommonFunctions.General.WriteHTML("</td></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='Center'  colspan=3> <b>" & MyBase.GetResourceString("TITLE_TARGETACHIVEMENTS") & "</b></td></TR>")
        CommonFunctions.General.WriteHTML("<TR></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>" & MyBase.GetResourceString("TOTALTASKPENDING") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='10%'> " & m_intTobeCompletedTasks & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='20%'>")
        CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('TobeCompletedTasks')"">" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</a>")
        CommonFunctions.General.WriteHTML("</td></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>" & MyBase.GetResourceString("TOTALDELIVERABLESPENDING") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='10%'> " & m_intTobeCompletedDeliverables & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align=Left width='20%'>")
        CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('TobeCompletedDeliverables')"">" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</a>")
        CommonFunctions.General.WriteHTML("</td></TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")
        '=========================================================================================
        'Key Achivements and Slippage section Completed 
        '=========================================================================================
    End Sub
    Private Sub DisplayMileStoneDetails()
        '=====================================================================
        ' Procedure Name        : DisplayMileStoneDetails()	
        ' Purpose               : procedure to show the grid for Milestone Details 
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS 
        ' Created               : Oct 11 , 2005
        ' Revisions             :
        '=====================================================================
        Dim m_strBaselineProjectName As String
        Dim m_strRemarks As String
        Dim m_dtmChangedDate As DateTime
        Dim m_dtmExpectedEnddate As DateTime
        Dim intCnt As Integer
        intCnt = -1
        Dim m_dtmAStartDate As DateTime
        Dim m_dtmAEndDate As DateTime
        Dim m_strSQL As String
        Dim drSQERT As IDataReader

        intCnt = 0

        If m_strProjectFilters <> "NULL" Then
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',4," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',4," & CType(Session("intUserID"), String) & ",NULL"
        End If

        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TBODY>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='Center'  colspan=11 Width=100%> <b>" & MyBase.GetResourceString("TITLE_MILESTONE") & "</b></td></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader>")
        CommonFunctions.General.WriteHTML("<TD ALIGN='Center' WIDTH=25%>" & MyBase.GetResourceString("MLNAME") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD ALIGN='Center' WIDTH=5%>" & MyBase.GetResourceString("MISREADYFORBILLING") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD ALIGN='Center' WIDTH=10%>" & MyBase.GetResourceString("MBILLAMOUNT") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD ALIGN='Center' WIDTH=10%>" & MyBase.GetResourceString("MPLANNEDSTART") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD ALIGN='Center' WIDTH=10%>" & MyBase.GetResourceString("MPLANNEDCOMPLETION") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD ALIGN='Center' WIDTH=10%>" & MyBase.GetResourceString("MLASDATE") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD ALIGN='Center' WIDTH=10%>" & MyBase.GetResourceString("MLAEDATE") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD ALIGN='Center' WIDTH=5%>" & MyBase.GetResourceString("MSLIPPAGE") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD ALIGN='Center' WIDTH=5%>" & MyBase.GetResourceString("MLSTATUS") & "</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        If drSQERT.Read Then
            m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
            CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader><TD colspan=11><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
        Else
            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD colspan=11 align='Center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
        End If

        CommonFunctions.Data.DisposeDataReader(drSQERT)
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        While drSQERT.Read
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString <> m_strBaselineProjectName Then
                intCnt = 1
                m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
                CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader><TD colspan=11><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
            Else
                intCnt = intCnt + 1
            End If

            If (intCnt Mod 2) = 0 Then
                m_strTRstyle = "clsTREven"
            Else
                m_strTRstyle = "clsTROdd"
            End If
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("IsSlipping"), "").ToString = "1" Then

                'Milestone Name
                CommonFunctions.General.WriteHTML("<TR class=" & m_strTRstyle & "><TD><FONT Color='RED'>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("Milestone"), "").ToString & "</FONT></TD>")

                'Is Ready for Billing
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("IsReadyForBilling"), "").ToString <> "" Then
                	'Integrated by MrugajaB for Whiziblesem SP7 Issue ID.4518 on 29th June 2006
                    'Modified by SavitaS on 05 June 2006 for DSS IssueID 2182(Project Health Sheet - Billing Ready and Actual start dates not displayed)
                    'If CommonFunctions.Data.CheckIsDBNull(drSQERT("IsReadyForBilling"), "").ToString = "TRUE" Then
                    If CommonFunctions.Data.CheckIsDBNull(drSQERT("IsReadyForBilling"), "").ToString.ToUpper = "TRUE" Then
                        CommonFunctions.General.WriteHTML("<TD><FONT Color='RED'> YES </FONT></TD>")
                    Else
                        CommonFunctions.General.WriteHTML("<TD><FONT Color='RED'> No </FONT></TD>")
                    End If
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If

                'Billing Amount
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("BillAmount"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD><FONT Color='RED'>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("BillAmount"), "").ToString & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If

                'Planned Start Date
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("PlannedStartDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD><FONT Color='RED'>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("PlannedStartDate"), "").ToString, Date)) & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If

                'Planned End Date
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("PlannedEndDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD><FONT Color='RED'>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("PlannedEndDate"), "").ToString, Date)) & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If

                'Actual start Date
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualStartDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD><FONT Color='RED'>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualStartDate"), "").ToString, Date)) & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If

                'Actual End Date
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualEndDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD><FONT Color='RED'>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualEndDate"), "").ToString, Date)) & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If

                'Slippage
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("Slippage"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD><FONT Color='RED'>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("Slippage"), "").ToString & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If

                'Status
                CommonFunctions.General.WriteHTML("<TD><FONT Color='RED'>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("MilestoneStatus"), "").ToString & "</FONT></TD></TR>")

            Else
                'Milestone Name
                CommonFunctions.General.WriteHTML("<TR class=" & m_strTRstyle & "><TD>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("Milestone"), "").ToString & "</TD>")

                'Is Ready for Billing 
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("IsReadyForBilling"), "").ToString <> "" Then
                    If CommonFunctions.Data.CheckIsDBNull(drSQERT("IsReadyForBilling"), "").ToString = "TRUE" Then
                        CommonFunctions.General.WriteHTML("<TD> YES </TD>")
                    Else
                        CommonFunctions.General.WriteHTML("<TD> No </TD>")
                    End If
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If

                'Billing Amount
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("BillAmount"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("BillAmount"), "").ToString & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If

                'Planned Start Date
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("PlannedStartDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("PlannedStartDate"), "").ToString, Date)) & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If

                'Planned End Date
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("PlannedEndDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("PlannedEndDate"), "").ToString, Date)) & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If

                'Actual Start Date
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualStartDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualStartDate"), "").ToString, Date)) & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If

                'Actual Start Date
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualEndDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualEndDate"), "").ToString, Date)) & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If

                'Slippage
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("Slippage"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("Slippage"), "").ToString & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If

                'Status
                CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("MilestoneStatus"), "").ToString & "</TD></TR>")
            End If
        End While

        CommonFunctions.Data.DisposeDataReader(drSQERT)

        CommonFunctions.General.WriteHTML("</TBODY>")
        CommonFunctions.General.WriteHTML("</TABLE>")
    End Sub
    Private Sub DisplayBaselineDetails()
        '=====================================================================
        ' Procedure Name        : DisplayBaselineDetails()	
        ' Purpose               : procedure to show the grid for Baseline Details 
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS 
        ' Created               : Oct 11 , 2005
        ' Revisions             :
        '=====================================================================
        Dim m_strSQL As String
        Dim drSQERT As IDataReader
        Dim m_strBaselineProjectName As String
        Dim m_strRemarks As String


        If m_strProjectFilters <> "NULL" Then
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',5," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',5," & CType(Session("intUserID"), String) & ",NULL"
        End If

        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TBODY>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='Center'  colspan=4 Width=100%> <b>" & MyBase.GetResourceString("TITLE_BASELINE") & "</b></td></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader>")
        CommonFunctions.General.WriteHTML("<TD ALIGN='Center' WIDTH=60%>" & MyBase.GetResourceString("REASONFORCHANGE") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD ALIGN='Center' WIDTH=15%>" & MyBase.GetResourceString("CHANGEDDATE") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD ALIGN='Center' WIDTH=15%>" & MyBase.GetResourceString("ESTIMATEDEFFORT") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD ALIGN='Center' WIDTH=10%>" & MyBase.GetResourceString("EXPENDDATE") & "</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        If drSQERT.Read Then
            m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
            m_strRemarks = CommonFunctions.Data.CheckIsDBNull(drSQERT("ReasonForRevision"), "").ToString
            'm_dtmChangedDate = CType(drSQERT("RevisionDate"), DateTime)
            'm_dtmExpectedEnddate = CType(drSQERT("ExpectedEnddate"), DateTime)

            CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader><TD Colspan=4><b>Project : " & m_strBaselineProjectName & "</b></TD></TR>")
            '**CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD>" & m_strRemarks & "</TD>")
            CommonFunctions.General.WriteHTML("<TR class=clsTROdd><TD>" & m_strRemarks & "</TD>")

            If CommonFunctions.Data.CheckIsDBNull(drSQERT("RevisionDate"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("RevisionDate"), "").ToString, Date)) & "</TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
            End If

            If CommonFunctions.Data.CheckIsDBNull(drSQERT("EstimatedEffort"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD>" & CType(drSQERT("EstimatedEffort"), Integer) & "</TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
            End If

            If CommonFunctions.Data.CheckIsDBNull(drSQERT("ExpectedEnddate"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ExpectedEnddate"), "").ToString, Date)) & "</TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
            End If
            '**CommonFunctions.General.WriteHTML("</TR><TR class=clsTREven>")
            CommonFunctions.General.WriteHTML("</TR>")

        Else
            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD colspan=4 align='Center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
        End If

        While drSQERT.Read
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString <> m_strBaselineProjectName Then
                m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
                '**CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader><TD Colspan=4><b>Project : " & m_strBaselineProjectName & "</B></TD></TR><TR class=clsTREven>")
                CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader><TD Colspan=4><b>Project : " & m_strBaselineProjectName & "</B></TD></TR>")
                intcnt = 1
            Else
                '**CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
                intcnt = intcnt + 1
            End If

            If (intcnt Mod 2) = 0 Then
                m_strTRstyle = "clsTREven"
            Else
                m_strTRstyle = "clsTROdd"
            End If

            CommonFunctions.General.WriteHTML("<TR class=" & m_strTRstyle & ">")

            'MODIFIED BY VIVEKP ON 21 SEP 2005 
            ' If CommonFunctions.Data.CheckIsDBNull(drSQERT("ReasonForRevision"), "").ToString <> m_strRemarks Then
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("ReasonForRevision"), "").ToString <> "" Then
                m_strRemarks = CommonFunctions.Data.CheckIsDBNull(drSQERT("ReasonForRevision"), "").ToString
                CommonFunctions.General.WriteHTML("<TD>" & m_strRemarks & "</TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
            End If
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("RevisionDate"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("RevisionDate"), "").ToString, Date)) & "</TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
            End If
            'Else
            'CommonFunctions.General.WriteHTML("<TD></TD>")
            'CommonFunctions.General.WriteHTML("<TD></TD>")
            'End If
            'END OF MODIFICATION BY VIVEKP ON 21 SEP 2005 

            If CommonFunctions.Data.CheckIsDBNull(drSQERT("EstimatedEffort"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD>" & CType(drSQERT("EstimatedEffort"), Integer) & "</TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
            End If

            If CommonFunctions.Data.CheckIsDBNull(drSQERT("ExpectedEnddate"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ExpectedEnddate"), "").ToString, Date)) & "</TD></TR>")
            Else
                CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD></TR>")
            End If
        End While

        CommonFunctions.Data.DisposeDataReader(drSQERT)

        CommonFunctions.General.WriteHTML("</TBODY>")
        CommonFunctions.General.WriteHTML("</TABLE>")

    End Sub
    Private Sub DisplaySQERT()
        '=====================================================================
        ' Procedure Name        : DisplaySQERT()	
        ' Purpose               : procedure to show the grid for SQERT Details 
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS 
        ' Created               : Oct 11 , 2005
        ' Revisions             :
        '=====================================================================
        Dim m_intScopeTrend As Integer
        Dim m_intQualityTrend As Integer
        Dim m_intEffortTrend As Integer
        Dim m_intRiskTrend As Integer
        Dim m_intTimeTrend As Integer
        Dim m_intRecordCount As Integer
        Dim m_intRecordCnt As Integer
        Dim m_strSQL As String
        Dim drSQERT As IDataReader
        Dim drTask As IDataReader

        m_intRecordCount = 0

        If m_strProjectFilters <> "NULL" Then
            m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',2," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',2," & CType(Session("intUserID"), String) & ",NULL"
        End If

        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        If drSQERT.Read Then
            m_intScopeTrend = CType(drSQERT("ScopeTrend"), Integer)
            m_intQualityTrend = CType(drSQERT("QualityTrend"), Integer)
            m_intEffortTrend = CType(drSQERT("EffortTrend"), Integer)
            m_intRiskTrend = CType(drSQERT("RiskTrend"), Integer)
            m_intTimeTrend = CType(drSQERT("TimeTrend"), Integer)
        End If
        CommonFunctions.Data.DisposeDataReader(drSQERT)

        If m_strProjectFilters <> "NULL" Then
            m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',1," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',1," & CType(Session("intUserID"), String) & ",NULL"
        End If

        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        While drSQERT.Read
            m_intRecordCount = m_intRecordCount + 1
        End While
        CommonFunctions.Data.DisposeDataReader(drSQERT)

        If m_strProjectFilters <> "NULL" Then
            m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',3," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',3," & CType(Session("intUserID"), String) & ",NULL"
        End If

        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        If drSQERT.Read Then
            m_intRecordCnt = 1
        End If
        CommonFunctions.Data.DisposeDataReader(drSQERT)

        If m_strProjectFilters <> "NULL" Then
            m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',0," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',0," & CType(Session("intUserID"), String) & ",NULL"
        End If

        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TBODY>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='Center'  colspan=5 Width=100%>")
        If (m_intRecordCount > 1 Or m_intRecordCnt > 0) Then
            CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('SQERT')"">")
        End If
        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("TITLE_SQERT") & "</b></td></a></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader>")
        CommonFunctions.General.WriteHTML("<TD ALIGN='Center' WIDTH=7%>" & MyBase.GetResourceString("SQERT_TITLE") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD ALIGN='Center' WIDTH=5%>" & MyBase.GetResourceString("SQERT_VALUE") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD ALIGN='Center' WIDTH=5%>" & MyBase.GetResourceString("SQERT_RATING") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD ALIGN='Center' WIDTH=5%>" & MyBase.GetResourceString("SQERT_TREND") & "</TD>")
        CommonFunctions.General.WriteHTML("<TD ALIGN='Center' WIDTH=78%>" & MyBase.GetResourceString("SQERT_DESCRIPTION") & "</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        If m_strProjectId <> "" Then
            drTask = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            '' m_strSQL = "select * from tbl_PRS_SQERT_Ranges ORDER BY SQERT_Order"
            m_strSQL = "usp_sel_tbl_PRS_SQERT_Ranges"
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

            If Not drTask.Read Then
                CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD colspan=5 align='Center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
            Else
                If m_intRecordCount > 0 Then
                    '===================== SCOPE ===========================
                    CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='left'>" & MyBase.GetResourceString("SCOPE") & "</TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>" & CType(drTask("Scope"), Integer) & " </TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
                    If drSQERT.Read Then
                        If CType(drTask("Scope"), Integer) >= CType(drSQERT("Lower_Low"), Integer) And CType(drTask("Scope"), Integer) <= CType(drSQERT("Lower_High"), Integer) Then
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                        ElseIf CType(drTask("Scope"), Integer) >= CType(drSQERT("Middle_Low"), Integer) And CType(drTask("Scope"), Integer) <= CType(drSQERT("Middle_High"), Integer) Then
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                        ElseIf CType(drTask("Scope"), Integer) >= CType(drSQERT("Upper_Low"), Integer) And CType(drTask("Scope"), Integer) <= CType(drSQERT("Upper_High"), Integer) Then
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                        End If
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
                    If m_intScopeTrend = 1 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/up_arrow.jpg' border='0' align='Center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intScopeTrend = 2 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/both_arrow.jpg' border='0' align='Center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intScopeTrend = 3 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/down_arrow.jpg' border='0' align='Center' WIDTH='20' HEIGHT='20'>")
                    Else
                        CommonFunctions.General.WriteHTML("<b>NA<b>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='Left'>" & CommonFunctions.Data.CheckIsDBNull(drTask("ScopeDesc"), "").ToString & "</TD></TR>")
                    '===================== END OF SCOPE ===========================

                    '===================== QUALITY ===========================
                    CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='left'>" & MyBase.GetResourceString("QUALITY") & "</TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>" & CType(drTask("Quality"), Integer) & " </TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
                    If drSQERT.Read Then
                        If CType(drTask("Quality"), Integer) >= CType(drSQERT("Lower_Low"), Integer) And CType(drTask("Quality"), Integer) <= CType(drSQERT("Lower_High"), Integer) Then
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                        ElseIf CType(drTask("Quality"), Integer) >= CType(drSQERT("Middle_Low"), Integer) And CType(drTask("Quality"), Integer) <= CType(drSQERT("Middle_High"), Integer) Then
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                        ElseIf CType(drTask("Quality"), Integer) >= CType(drSQERT("Upper_Low"), Integer) And CType(drTask("Quality"), Integer) <= CType(drSQERT("Upper_High"), Integer) Then
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                        End If
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
                    If m_intScopeTrend = 1 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/up_arrow.jpg' border='0' align='Center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intScopeTrend = 2 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/both_arrow.jpg' border='0' align='Center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intScopeTrend = 3 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/down_arrow.jpg' border='0' align='Center' WIDTH='20' HEIGHT='20'>")
                    Else
                        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("SQERT_NA") & "<b>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='Left'>" & CommonFunctions.Data.CheckIsDBNull(drTask("QualityDesc"), "").ToString & "</TD></TR>")
                    '===================== END OF QUALITY ===========================

                    '===================== EFFORT ===========================
                    CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='left'>" & MyBase.GetResourceString("EFFORT") & "</TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>" & CType(drTask("Effort"), Integer) & " </TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
                    If drSQERT.Read Then
                        If CType(drTask("Effort"), Integer) >= CType(drSQERT("Lower_Low"), Integer) And CType(drTask("Effort"), Integer) <= CType(drSQERT("Lower_High"), Integer) Then
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                        ElseIf CType(drTask("Effort"), Integer) >= CType(drSQERT("Middle_Low"), Integer) And CType(drTask("Effort"), Integer) <= CType(drSQERT("Middle_High"), Integer) Then
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                        ElseIf CType(drTask("Effort"), Integer) >= CType(drSQERT("Upper_Low"), Integer) And CType(drTask("Effort"), Integer) <= CType(drSQERT("Upper_High"), Integer) Then
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                        End If
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
                    If m_intScopeTrend = 1 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/up_arrow.jpg' border='0' align='Center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intScopeTrend = 2 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/both_arrow.jpg' border='0' align='Center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intScopeTrend = 3 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/down_arrow.jpg' border='0' align='Center' WIDTH='20' HEIGHT='20'>")
                    Else
                        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("SQERT_NA") & "<b>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='Left'>" & CommonFunctions.Data.CheckIsDBNull(drTask("EffortDesc"), "").ToString & "</TD></TR>")

                    '===================== END OF EFFORT ===========================

                    '===================== RISK ===========================

                    CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='left'><a Href=""javascript:DetailsLink_onClick('Risk')""> " & MyBase.GetResourceString("RISK") & " </a></TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>" & CType(drTask("Risk"), Integer) & " </TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
                    If drSQERT.Read Then
                        If CType(drTask("Risk"), Integer) >= CType(drSQERT("Lower_Low"), Integer) And CType(drTask("Risk"), Integer) <= CType(drSQERT("Lower_High"), Integer) Then
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                        ElseIf CType(drTask("Risk"), Integer) >= CType(drSQERT("Middle_Low"), Integer) And CType(drTask("Risk"), Integer) <= CType(drSQERT("Middle_High"), Integer) Then
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                        ElseIf CType(drTask("Risk"), Integer) >= CType(drSQERT("Upper_Low"), Integer) And CType(drTask("Risk"), Integer) <= CType(drSQERT("Upper_High"), Integer) Then
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                        End If
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
                    If m_intScopeTrend = 1 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/up_arrow.jpg' border='0' align='Center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intScopeTrend = 2 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/both_arrow.jpg' border='0' align='Center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intScopeTrend = 3 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/down_arrow.jpg' border='0' align='Center' WIDTH='20' HEIGHT='20'>")
                    Else
                        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("SQERT_NA") & "<b>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='Left'>" & CommonFunctions.Data.CheckIsDBNull(drTask("RiskDesc"), "").ToString & "</TD></TR>")

                    '===================== END OF RISK ===========================

                    '===================== TIME ===========================

                    CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='left'>" & MyBase.GetResourceString("TIME") & "</TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>" & CType(drTask("Time"), Integer) & " </TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
                    If drSQERT.Read Then
                        If CType(drTask("Time"), Integer) >= CType(drSQERT("Lower_Low"), Integer) And CType(drTask("Time"), Integer) <= CType(drSQERT("Lower_High"), Integer) Then
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                        ElseIf CType(drTask("Time"), Integer) >= CType(drSQERT("Middle_Low"), Integer) And CType(drTask("Time"), Integer) <= CType(drSQERT("Middle_High"), Integer) Then
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                        ElseIf CType(drTask("Time"), Integer) >= CType(drSQERT("Upper_Low"), Integer) And CType(drTask("Time"), Integer) <= CType(drSQERT("Upper_High"), Integer) Then
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                        End If
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
                    If m_intScopeTrend = 1 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/up_arrow.jpg' border='0' align='Center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intScopeTrend = 2 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/both_arrow.jpg' border='0' align='Center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intScopeTrend = 3 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/down_arrow.jpg' border='0' align='Center' WIDTH='20' HEIGHT='20'>")
                    Else
                        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("SQERT_NA") & "<b>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='Left'>" & CommonFunctions.Data.CheckIsDBNull(drTask("TimeDesc"), "").ToString & "</TD></TR>")

                    '===================== END OF TIME ===========================
                Else
                    CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD colspan=5 align='Center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
                End If
            End If
        Else
            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD colspan=5 align='Center'>" & MyBase.GetResourceString("SQERTNAMESSAGE") & "</TD></TR>")
        End If
        CommonFunctions.Data.DisposeDataReader(drTask)
        CommonFunctions.Data.DisposeDataReader(drSQERT)

        CommonFunctions.General.WriteHTML("</TBODY>")
        CommonFunctions.General.WriteHTML("</TABLE>")

        'END OF SQERT TABLE

    End Sub
    Private Sub DisplayIssueDetails()
        '=====================================================================
        ' Procedure Name        : DisplayIssueDetails()	
        ' Purpose               : procedure to show the Issuedetails Details 
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS 
        ' Created               : Oct 11 , 2005
        ' Revisions             :
        '=====================================================================

        'Issue Detail block
        Dim m_strBaselineProjectName As String
        Dim intCnt As Integer
        Dim m_strFlag As Integer
        Dim m_strTitle As String
        Dim m_strSQL As String
        Dim drSQERT As IDataReader

        m_strFlag = CType(Request.QueryString("blnFlag"), Integer)

        'm_strTitle = MyBase.GetResourceString("TITLE_ISSUES")
        m_strTitle = "Issues Details (<TYPE>)"
        If m_strFlag = 1 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("TOTAL"))
        ElseIf m_strFlag = 2 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("OPEN"))
        ElseIf m_strFlag = 3 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("CLOSE"))
        ElseIf m_strFlag = 4 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("OVERDUE"))
        End If

        m_strTitle = m_strTitle.Replace("<TODATE>", CommonFunction.Dates.GetDate(CType(m_dtmReportingEndDate, Date)).ToString)

        intCnt = 0

        If m_strProjectFilters <> "NULL" Then
            m_strSQL = "Exec USP_RPT_GetOpenAndClosedIssues " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec USP_RPT_GetOpenAndClosedIssues " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",NULL"
        End If

        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        CommonFunctions.General.WriteHTML("<div id='divList2' style='overflow:auto;height=400;Width:100%;'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TBODY>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='Center'  colspan=10 Width=100%> <b>" & m_strTitle & "</b></td></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=5%>" & MyBase.GetResourceString("SRNO") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=5%>" & MyBase.GetResourceString("ISSUEID") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=25%>" & MyBase.GetResourceString("SUMMARY") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=5%>" & MyBase.GetResourceString("REPDATE") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=15%>" & MyBase.GetResourceString("ISSUETYPE") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=10%>" & MyBase.GetResourceString("SUBTYPE") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=5%>" & MyBase.GetResourceString("PRIORITY") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=5%>" & MyBase.GetResourceString("SEVERITY") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=10%>" & MyBase.GetResourceString("DUEDATE") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=15%>" & MyBase.GetResourceString("REPORTEDBY") & "</td>")
        CommonFunctions.General.WriteHTML("</TR>")

        If drSQERT.Read Then
            m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
            CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader><TD Colspan=10><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
        Else
            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD colspan=10 align='Center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
        End If

        CommonFunctions.Data.DisposeDataReader(drSQERT)
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        While drSQERT.Read
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString <> m_strBaselineProjectName Then
                intCnt = 1
                m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
                CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader><TD Colspan=10><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
            Else
                intCnt = intCnt + 1
            End If

            If (intCnt Mod 2) = 0 Then
                m_strTRstyle = "clsTREven"
            Else
                m_strTRstyle = "clsTROdd"
            End If

            CommonFunctions.General.WriteHTML("<TR class=" & m_strTRstyle & "><TD>" & intCnt & "</TD>")
            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("IssueID"), "").ToString & "</TD>")
            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("Summary"), "").ToString & "</TD>")
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("reportedDate"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("reportedDate"), "").ToString, Date)) & "</TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
            End If

            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("Type"), "").ToString & "</TD>")
            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("SubType"), "").ToString & "</TD>")
            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("Priority"), "").ToString & "</TD>")
            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("Severity"), "").ToString & "</TD>")
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("DueDate"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("DueDate"), "").ToString, Date)) & "</TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
            End If
            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("reportedBy"), "").ToString & "</TD></TR>")
        End While

        CommonFunctions.Data.DisposeDataReader(drSQERT)

        CommonFunctions.General.WriteHTML("</TBODY>")
        CommonFunctions.General.WriteHTML("</TABLE>")
        CommonFunctions.General.WriteHTML("</DIV>")

    End Sub

    Private Sub DisplayTaskDetails()
        '=====================================================================
        ' Procedure Name        :   DisplayTaskDetails()	
        ' Purpose               :   procedure to show the Task Details 
        ' Description           :   same as above
        ' Parameters Passed     :   none
        ' Returns               :   none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                :   NitinVS 
        ' Created               :   Oct 11 , 2005
        ' Revisions             :   By      :   Padmnabh Anturkar
        '                           Purpose :   1. Tasks to be displayed in RED if it is slipping
        '                                       2. Adding Actual Work, Resource Name columns in details grid
        '                           Date    :   November 16, 2005
        '=====================================================================
        'Tasks Detail block
        Dim m_strBaselineProjectName As String
        Dim intCnt As Integer
        Dim m_strFlag As Integer
        Dim m_strTitle As String
        Dim m_strSQL As String
        Dim drSQERT As IDataReader

        m_strFlag = CType(Request.QueryString("blnFlag"), Integer)
        m_strTitle = MyBase.GetResourceString("TITLE_TASKS")

        If m_strFlag = 2 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("COMPLETED"))
            m_strTitle = m_strTitle.Replace("<TODATE>", CommonFunction.Dates.GetDate(CType(m_dtmReportingEndDate, Date)).ToString)
            m_strTitle = m_strTitle.Replace("<FROMDATE>", CommonFunction.Dates.GetDate(CType(m_dtmReportingStartDate, Date)).ToString)
            If m_strProjectFilters <> "NULL" Then
                m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
            Else
                m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",NULL"
            End If
        ElseIf m_strFlag = 3 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("TOBECOMPLETED"))
            m_strTitle = m_strTitle.Replace("<TODATE>", CommonFunction.Dates.GetDate(CType(m_dtmNextReportingEndDate, Date)).ToString)
            m_strTitle = m_strTitle.Replace("<FROMDATE>", CommonFunction.Dates.GetDate(CType(m_dtmNextReportingStartDate, Date)).ToString)
            If m_strProjectFilters <> "NULL" Then
                m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmNextReportingStartDate & "','" & m_dtmNextReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
            Else
                m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmNextReportingStartDate & "','" & m_dtmNextReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",NULL"
            End If
        ElseIf m_strFlag = 6 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("SLIPPING"))
            m_strTitle = m_strTitle.Replace("<TODATE>", CommonFunction.Dates.GetDate(CType(m_dtmReportingEndDate, Date)).ToString)
            m_strTitle = m_strTitle.Replace("<FROMDATE>", CommonFunction.Dates.GetDate(CType(m_dtmReportingStartDate, Date)).ToString)
            If m_strProjectFilters <> "NULL" Then
                m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
            Else
                m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",NULL"
            End If
        End If

        intCnt = 0

        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        CommonFunctions.General.WriteHTML("<div id='divList2' style='overflow:auto;height=400;Width:100%;'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TBODY>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='Center'  colspan=10 Width=100%> <b>" & m_strTitle & "</b></td></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=5%>" & MyBase.GetResourceString("SRNO") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=30%>" & MyBase.GetResourceString("TASKNAME") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=10%>" & MyBase.GetResourceString("RESOURCENAME") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=15%>" & MyBase.GetResourceString("EXPSTARTDATE") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=15%>" & MyBase.GetResourceString("EXPENDDATE") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=15%>" & MyBase.GetResourceString("MLASDATE") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=15%>" & MyBase.GetResourceString("MLAEDATE") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=10%>" & MyBase.GetResourceString("WORKHRS") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=10%>" & MyBase.GetResourceString("ACTUALWORKHRS") & "</td>")
        CommonFunctions.General.WriteHTML("</TR>")

        If drSQERT.Read Then
            m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
            CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader><TD Colspan=10><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
        Else
            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD colspan=10 align='Center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
        End If

        CommonFunctions.Data.DisposeDataReader(drSQERT)
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        While drSQERT.Read
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString <> m_strBaselineProjectName Then
                intCnt = 1
                m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
                CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader><TD Colspan=10><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
            Else
                intCnt = intCnt + 1
            End If

            If (intCnt Mod 2) = 0 Then
                m_strTRstyle = "clsTREven"
            Else
                m_strTRstyle = "clsTROdd"
            End If

            If CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("IsSlipping"), "0"), Integer) = 1 Then
                CommonFunctions.General.WriteHTML("<TR class=" & m_strTRstyle & "><TD><FONT Color = 'RED'>" & intCnt & "</FONT></TD>")
                CommonFunctions.General.WriteHTML("<TD><FONT Color = 'RED'>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("TaskName"), "").ToString & "</FONT></TD>")
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("UserName"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD><FONT Color = 'RED'>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("UserName"), "").ToString & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("StartDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD><FONT Color = 'RED'>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("StartDate"), "").ToString, Date)) & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("EndDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD><FONT Color = 'RED'>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("EndDate"), "").ToString, Date)) & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualStartDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD><FONT Color = 'RED'>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualStartDate"), "").ToString, Date)) & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualEndDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD><FONT Color = 'RED'>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualEndDate"), "").ToString, Date)) & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                CommonFunctions.General.WriteHTML("<TD align = 'Right'><FONT Color = 'RED'>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("work"), "").ToString & "</FONT></TD>")
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualWork"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD align = 'Right'><FONT Color = 'RED'>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualWork"), "").ToString & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD align = 'Right'>0</TD>")
                End If

            Else

                CommonFunctions.General.WriteHTML("<TR class=" & m_strTRstyle & "><TD>" & intCnt & "</TD>")
                CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("TaskName"), "").ToString & "</TD>")
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("UserName"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("UserName"), "").ToString & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("StartDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("StartDate"), "").ToString, Date)) & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("EndDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("EndDate"), "").ToString, Date)) & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualStartDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualStartDate"), "").ToString, Date)) & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualEndDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualEndDate"), "").ToString, Date)) & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                CommonFunctions.General.WriteHTML("<TD align = 'Right'>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("work"), "").ToString & "</TD>")
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualWork"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD align = 'Right'>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualWork"), "").ToString & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD align = 'Right'>0</TD>")
                End If
            End If

        End While
        CommonFunctions.Data.DisposeDataReader(drSQERT)
        CommonFunctions.General.WriteHTML("</TBODY>")
        CommonFunctions.General.WriteHTML("</TABLE>")
        CommonFunctions.General.WriteHTML("</DIV>")

    End Sub

    Private Sub DisplayRiskDetails()
        '=====================================================================
        ' Procedure Name        : DisplayRiskDetails()	
        ' Purpose               : procedure to show the Risk Details 
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS 
        ' Created               : Oct 11 , 2005
        ' Revisions             :
        '=====================================================================
        Dim m_strRiskProjectName As String
        Dim intCnt As Integer
        Dim m_strSQL As String
        Dim drSQERT As IDataReader
        Dim drTask As IDataReader

        intCnt = 0
        intRecordcount = 0

        CommonFunctions.General.WriteHTML("<DIV ID='DIVLIST' STYLE='overflow:auto;width:100%;height=410px'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TBODY>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><td align=left width=100% Colspan=8><b>" & MyBase.GetResourceString("TITLE_RISKDETAILS") & CommonFunctions.Dates.GetDate(CType(m_dtmReportingEndDate, Date)) & "</b></td><tr>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRColumnHeader>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=30%>" & MyBase.GetResourceString("RISK") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=15%>" & MyBase.GetResourceString("IDENTIFIEDDATE") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=15%>" & MyBase.GetResourceString("MITIGATIONDATE") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=7%>" & MyBase.GetResourceString("PROBABILITY") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=7%>" & MyBase.GetResourceString("IMPACT") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=8%>" & MyBase.GetResourceString("SEVERITY") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=7%>" & MyBase.GetResourceString("RATING") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=7%>" & MyBase.GetResourceString("PERSONRESPONSIBLE") & "</td></TR>")
        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        '' m_strSQL = "select * from tbl_PRS_SQERT_Ranges where SQERT_Range_ID=4"
        m_strSQL = "usp_sel_SQERT_Range_ID_tbl_PRS_SQERT_Ranges"
        ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        'Modified by NitinVS on 2 Aug 2007 for WhizibleSEM 7
        'Removed the PCFC from sp name changed usp_CRW_PCFC_ProjectSheet_GetRiskDetails to usp_CRW_ProjectSheet_GetRiskDetails

        If m_strProjectFilters <> "NULL" Then
            m_strSQL = "Exec usp_CRW_ProjectSheet_GetRiskDetails " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec usp_CRW_ProjectSheet_GetRiskDetails " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & CType(Session("intUserID"), String) & ",NULL"
        End If

        'End Modification by NitinVS on 2 Aug 2007 for WhizibleSEM 7

        drTask = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        If drTask.Read Then
            m_strRiskProjectName = CommonFunctions.Data.CheckIsDBNull(drTask("ProjectName"), "").ToString
            CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader><TD Colspan=8><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strRiskProjectName & "</b></TD></TR>")

            intCnt = 0

            If (intCnt Mod 2) = 0 Then
                m_strTRstyle = "clsTREven"
            Else
                m_strTRstyle = "clsTROdd"
            End If

            CommonFunctions.General.WriteHTML("<TR class=" & m_strTRstyle & ">")
            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drTask("Risk"), "").ToString & "</TD>")

            If CommonFunctions.Data.CheckIsDBNull(drTask("DateIdentified"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drTask("DateIdentified"), "").ToString, Date)) & "</TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
            End If

            If CommonFunctions.Data.CheckIsDBNull(drTask("MitigationDate"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drTask("MitigationDate"), "").ToString, Date)) & "</TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
            End If

            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drTask("Probability"), "&nbsp;").ToString & "</TD>")

            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drTask("Weight"), "&nbsp;").ToString & "</TD>")

            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drTask("Severity"), "&nbsp;").ToString & "</TD>")

            CommonFunctions.General.WriteHTML("<td Align='Center'>")
            If drSQERT.Read Then
                If CType(drTask("Severity"), Integer) >= CType(drSQERT("Lower_Low"), Integer) And CType(drTask("Severity"), Integer) <= CType(drSQERT("Lower_High"), Integer) Then
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                ElseIf CType(drTask("Severity"), Integer) >= CType(drSQERT("Middle_Low"), Integer) And CType(drTask("Severity"), Integer) <= CType(drSQERT("Middle_High"), Integer) Then
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                ElseIf CType(drTask("Severity"), Integer) >= CType(drSQERT("Upper_Low"), Integer) And CType(drTask("Severity"), Integer) <= CType(drSQERT("Upper_High"), Integer) Then
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                End If
            End If
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drTask("PersonResponsible"), "&nbsp;").ToString & "</TD></TR>")
        Else
            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD colspan=8 align='Center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
        End If

        While drTask.Read
            If CommonFunctions.Data.CheckIsDBNull(drTask("ProjectName"), "").ToString <> m_strRiskProjectName Then
                intCnt = 1
                m_strRiskProjectName = CommonFunctions.Data.CheckIsDBNull(drTask("ProjectName"), "").ToString
                CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader><TD Colspan=8><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strRiskProjectName & "</b></TD></TR>")
            Else
                intCnt = intCnt + 1
            End If

            If (intCnt Mod 2) = 0 Then
                m_strTRstyle = "clsTREven"
            Else
                m_strTRstyle = "clsTROdd"
            End If

            CommonFunctions.General.WriteHTML("<TR class=" & m_strTRstyle & ">")
            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drTask("Risk"), "").ToString & "</TD>")

            If CommonFunctions.Data.CheckIsDBNull(drTask("DateIdentified"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drTask("DateIdentified"), "").ToString, Date)) & "</TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
            End If

            If CommonFunctions.Data.CheckIsDBNull(drTask("MitigationDate"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drTask("MitigationDate"), "").ToString, Date)) & "</TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
            End If

            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drTask("Probability"), "&nbsp;").ToString & "</TD>")

            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drTask("Weight"), "&nbsp;").ToString & "</TD>")

            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drTask("Severity"), "&nbsp;").ToString & "</TD>")

            CommonFunctions.General.WriteHTML("<td Align='Center'>")
            If drSQERT.Read Then
                If CType(drTask("Severity"), Integer) >= CType(drSQERT("Lower_Low"), Integer) And CType(drTask("Severity"), Integer) <= CType(drSQERT("Lower_High"), Integer) Then
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                ElseIf CType(drTask("Severity"), Integer) >= CType(drSQERT("Middle_Low"), Integer) And CType(drTask("Severity"), Integer) <= CType(drSQERT("Middle_High"), Integer) Then
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                ElseIf CType(drTask("Severity"), Integer) >= CType(drSQERT("Upper_Low"), Integer) And CType(drTask("Severity"), Integer) <= CType(drSQERT("Upper_High"), Integer) Then
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                End If
            End If
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drTask("PersonResponsible"), "&nbsp;").ToString & "</TD></TR>")
        End While

        CommonFunctions.Data.DisposeDataReader(drTask)
        CommonFunctions.Data.DisposeDataReader(drSQERT)

        CommonFunctions.General.WriteHTML("</TBODY></TABLE>")

    End Sub

    Private Sub DisplayDeliverableDetails()
        '=====================================================================
        ' Procedure Name        : DisplayDeliverableDetails
        ' Purpose               : procedure to show the Deliverable Details 
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Padmnabh Anturkar
        ' Created               : November 23, 2005
        ' Revisions             :
        '=====================================================================
        'Deliverable Detail block
        Dim m_strBaselineProjectName As String
        Dim intCnt As Integer
        Dim m_strFlag As Integer
        Dim m_strTitle As String
        Dim m_strSQL As String
        Dim drSQERT As IDataReader

        m_strFlag = CType(Request.QueryString("blnFlag"), Integer)
        m_strTitle = MyBase.GetResourceString("TITLE_DELIVERABLES")

        If m_strFlag = 8 Then
            '=========================================================================================
            '1. Calculation of details of Deliverables completed in reporting period
            '=========================================================================================
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("COMPLETED"))
            m_strTitle = m_strTitle.Replace("<TODATE>", CommonFunction.Dates.GetDate(CType(m_dtmReportingEndDate, Date)).ToString)
            m_strTitle = m_strTitle.Replace("<FROMDATE>", CommonFunction.Dates.GetDate(CType(m_dtmReportingStartDate, Date)).ToString)
            If m_strProjectFilters <> "NULL" Then
                m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
            Else
                m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",NULL"
            End If
            '=========================================================================================
            '2. Calculation of details of Deliverables to completed in next reporting period
            '=========================================================================================
        ElseIf m_strFlag = 12 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("TOBECOMPLETED"))
            m_strTitle = m_strTitle.Replace("<TODATE>", CommonFunction.Dates.GetDate(CType(m_dtmNextReportingEndDate, Date)).ToString)
            m_strTitle = m_strTitle.Replace("<FROMDATE>", CommonFunction.Dates.GetDate(CType(m_dtmNextReportingStartDate, Date)).ToString)
            If m_strProjectFilters <> "NULL" Then
                m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmNextReportingStartDate & "','" & m_dtmNextReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
            Else
                m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmNextReportingStartDate & "','" & m_dtmNextReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",NULL"
            End If
            '=========================================================================================
            '3. Calculation of details of Deliverables slipping in reporting period
            '=========================================================================================
        ElseIf m_strFlag = 10 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("SLIPPING"))
            m_strTitle = m_strTitle.Replace("<TODATE>", CommonFunction.Dates.GetDate(CType(m_dtmReportingEndDate, Date)).ToString)
            m_strTitle = m_strTitle.Replace("<FROMDATE>", CommonFunction.Dates.GetDate(CType(m_dtmReportingStartDate, Date)).ToString)
            If m_strProjectFilters <> "NULL" Then
                m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
            Else
                m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",NULL"
            End If
        End If

        intCnt = 0
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        '=========================================================================================
        'Details of Deliverables grid plotting
        '=========================================================================================
        CommonFunctions.General.WriteHTML("<div id='divList2' style='overflow:auto;height=400;Width:100%;'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TBODY>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='Center'  colspan=10 Width=100%> <b>" & m_strTitle & "</b></td></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=5%>" & MyBase.GetResourceString("SRNO") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=30%>" & MyBase.GetResourceString("DELIVERABLENAME") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=15%>" & MyBase.GetResourceString("RESOURCENAME") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=15%>" & MyBase.GetResourceString("EXPSTARTDATE") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=15%>" & MyBase.GetResourceString("EXPENDDATE") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=10%>" & MyBase.GetResourceString("MLASDATE") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=10%>" & MyBase.GetResourceString("MLAEDATE") & "</td>")
        CommonFunctions.General.WriteHTML("</TR>")

        If drSQERT.Read Then
            m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
            CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader><TD Colspan=10><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
        Else
            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD colspan=10 align='Center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
        End If

        CommonFunctions.Data.DisposeDataReader(drSQERT)
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        While drSQERT.Read
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString <> m_strBaselineProjectName Then
                intCnt = 1
                m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
                CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader><TD Colspan=10><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
            Else
                intCnt = intCnt + 1
            End If
            If (intCnt Mod 2) = 0 Then
                m_strTRstyle = "clsTREven"
            Else
                m_strTRstyle = "clsTROdd"
            End If

            If CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("IsSlipping"), "0"), Integer) = 1 Then
                CommonFunctions.General.WriteHTML("<TR class=" & m_strTRstyle & "><TD><FONT Color = 'RED'>" & intCnt & "</FONT></TD>")
                CommonFunctions.General.WriteHTML("<TD><FONT Color = 'RED'>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("Title"), "").ToString & "</FONT></TD>")
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ResponsiblePerson"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD><FONT Color = 'RED'>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("ResponsiblePerson"), "").ToString & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD></TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ExpectedStartDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD><FONT Color = 'RED'>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ExpectedStartDate"), "").ToString, Date)) & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ExpectedEndDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD><FONT Color = 'RED'>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ExpectedEndDate"), "").ToString, Date)) & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualStartDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD><FONT Color = 'RED'>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualStartDate"), "").ToString, Date)) & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualEndDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD><FONT Color = 'RED'>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualEndDate"), "").ToString, Date)) & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If

            Else

                CommonFunctions.General.WriteHTML("<TR class=" & m_strTRstyle & "><TD>" & intCnt & "</TD>")
                CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("Title"), "").ToString & "</TD>")
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ResponsiblePerson"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("ResponsiblePerson"), "").ToString & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD></TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ExpectedStartDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ExpectedStartDate"), "").ToString, Date)) & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ExpectedEndDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ExpectedEndDate"), "").ToString, Date)) & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualStartDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualStartDate"), "").ToString, Date)) & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualEndDate"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualEndDate"), "").ToString, Date)) & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
            End If

        End While

        CommonFunctions.Data.DisposeDataReader(drSQERT)

        CommonFunctions.General.WriteHTML("</TBODY>")
        CommonFunctions.General.WriteHTML("</TABLE>")
        CommonFunctions.General.WriteHTML("</DIV>")
        '=========================================================================================
        'Details of Deliverables grid plotting Ends
        '=========================================================================================

    End Sub

    Private Sub displaySQERTDetails()
        Dim strProjectOverview As String
        Dim strProgram As String
        Dim strScope As String
        Dim StrQuality As String
        Dim StrEffort As String
        Dim StrRisk As String
        Dim StrTime As String
        Dim intRecords As Integer
        Dim m_strSQL As String
        Dim drTask As IDataReader
        Dim drSQERT As IDataReader

        strProjectOverview = ""
        strProgram = ""
        strScope = ""
        StrQuality = ""
        StrEffort = ""
        StrRisk = ""
        StrTime = ""
        intRecords = 0

        CommonFunctions.General.WriteHTML("<DIV ID='DIVLIST' STYLE='overflow:auto;width:100%;height=410px'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TBODY>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><td align=left width=100% Colspan=8><b>" & MyBase.GetResourceString("TITLE_SQERTDETAILS") & CommonFunctions.Dates.GetDate(CType(m_dtmReportingEndDate, Date)) & "</b></td><tr>")

        CommonFunctions.General.WriteHTML("<TR class=clsTRColumnHeader>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=52%>" & MyBase.GetResourceString("PROJECTNAME") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=8%>" & MyBase.GetResourceString("SCOPE") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=8%>" & MyBase.GetResourceString("QUALITY") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=8%>" & MyBase.GetResourceString("EFFORT") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=8%>" & MyBase.GetResourceString("RISK") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=8%>" & MyBase.GetResourceString("TIME") & "</td>")
        CommonFunctions.General.WriteHTML("<td align='Center' width=8%>" & MyBase.GetResourceString("PROJECTOVERVIEW") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='Center' width=8%>EV</td></TR>")
        CommonFunctions.General.WriteHTML("</TR>")

        If m_strProjectFilters <> "NULL" Then
            m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',1," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',1," & CType(Session("intUserID"), String) & ",NULL"
        End If

        drTask = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        m_strTRstyle = "clsTREven"

        While drTask.Read
            intRecords = intRecords + 1
            If m_strTRstyle = "clsTREven" Then
                m_strTRstyle = "clsTROdd"
            Else
                m_strTRstyle = "clsTREven"
            End If

            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            '' m_strSQL = "select * from tbl_PRS_SQERT_Ranges ORDER BY SQERT_Order"
            m_strSQL = "usp_sel_tbl_PRS_SQERT_Ranges"
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

            CommonFunctions.General.WriteHTML("<TR class=" & m_strTRstyle & ">")
            '            CommonFunctions.General.WriteHTML("<td Align='left'><a Href=""javascript:SQERTProjectLink_onClick(" + CommonFunctions.Data.CheckIsDBNull(drTask("ProjectID"), "").ToString + ", " + m_intReportingPeriod.ToString + ", '" + m_strReportedDate.ToString + "' )"">" & CommonFunctions.Data.CheckIsDBNull(drTask("ProjectName"), "").ToString & "</a></td>")
            CommonFunctions.General.WriteHTML("<td Align='left'>" + CommonFunctions.Data.CheckIsDBNull(drTask("ProjectName"), "").ToString & "</td>")
            'CommonFunctions.General.WriteHTML("<td Align='left'>" & CommonFunctions.Data.CheckIsDBNull(drTask("ProjectName"), "").ToString & "</td>")
            CommonFunctions.General.WriteHTML("<td Align='Center'>")

            If drSQERT.Read Then
                If CType(drTask("Scope"), Integer) >= CType(drSQERT("Lower_Low"), Integer) And CType(drTask("Scope"), Integer) <= CType(drSQERT("Lower_High"), Integer) Then
                    strProjectOverview = strProjectOverview & 1 & ","
                    strScope = strScope & 1 & ","
                    strProgram = strProgram & 1 & ","
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                ElseIf CType(drTask("Scope"), Integer) >= CType(drSQERT("Middle_Low"), Integer) And CType(drTask("Scope"), Integer) <= CType(drSQERT("Middle_High"), Integer) Then
                    strProjectOverview = strProjectOverview & 2 & ","
                    strScope = strScope & 2 & ","
                    strProgram = strProgram & 2 & ","
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                ElseIf CType(drTask("Scope"), Integer) >= CType(drSQERT("Upper_Low"), Integer) And CType(drTask("Scope"), Integer) <= CType(drSQERT("Upper_High"), Integer) Then
                    strProjectOverview = strProjectOverview & 3 & ","
                    strScope = strScope & 3 & ","
                    strProgram = strProgram & 3 & ","
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                End If
            End If
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
            If drSQERT.Read Then
                If CType(drTask("Quality"), Integer) >= CType(drSQERT("Lower_Low"), Integer) And CType(drTask("Quality"), Integer) <= CType(drSQERT("Lower_High"), Integer) Then
                    strProjectOverview = strProjectOverview & 3 & ","
                    StrQuality = StrQuality & 3 & ","
                    strProgram = strProgram & 3 & ","
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                ElseIf CType(drTask("Quality"), Integer) >= CType(drSQERT("Middle_Low"), Integer) And CType(drTask("Quality"), Integer) <= CType(drSQERT("Middle_High"), Integer) Then
                    strProjectOverview = strProjectOverview & 2 & ","
                    StrQuality = StrQuality & 2 & ","
                    strProgram = strProgram & 2 & ","
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                ElseIf CType(drTask("Quality"), Integer) >= CType(drSQERT("Upper_Low"), Integer) And CType(drTask("Quality"), Integer) <= CType(drSQERT("Upper_High"), Integer) Then
                    strProjectOverview = strProjectOverview & 1 & ","
                    StrQuality = StrQuality & 1 & ","
                    strProgram = strProgram & 1 & ","
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                End If
            End If
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
            If drSQERT.Read Then
                If CType(drTask("Effort"), Integer) >= CType(drSQERT("Lower_Low"), Integer) And CType(drTask("Effort"), Integer) <= CType(drSQERT("Lower_High"), Integer) Then
                    strProjectOverview = strProjectOverview & 1 & ","
                    StrEffort = StrEffort & 1 & ","
                    strProgram = strProgram & 1 & ","
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                ElseIf CType(drTask("Effort"), Integer) >= CType(drSQERT("Middle_Low"), Integer) And CType(drTask("Effort"), Integer) <= CType(drSQERT("Middle_High"), Integer) Then
                    strProjectOverview = strProjectOverview & 2 & ","
                    StrEffort = StrEffort & 2 & ","
                    strProgram = strProgram & 2 & ","
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                ElseIf CType(drTask("Effort"), Integer) >= CType(drSQERT("Upper_Low"), Integer) And CType(drTask("Effort"), Integer) <= CType(drSQERT("Upper_High"), Integer) Then
                    strProjectOverview = strProjectOverview & 3 & ","
                    StrEffort = StrEffort & 3 & ","
                    strProgram = strProgram & 3 & ","
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                End If
            End If
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
            If drSQERT.Read Then
                If CType(drTask("Risk"), Integer) >= CType(drSQERT("Lower_Low"), Integer) And CType(drTask("Risk"), Integer) <= CType(drSQERT("Lower_High"), Integer) Then
                    strProjectOverview = strProjectOverview & 1 & ","
                    StrRisk = StrRisk & 1 & ","
                    strProgram = strProgram & 1 & ","
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                ElseIf CType(drTask("Risk"), Integer) >= CType(drSQERT("Middle_Low"), Integer) And CType(drTask("Risk"), Integer) <= CType(drSQERT("Middle_High"), Integer) Then
                    strProjectOverview = strProjectOverview & 2 & ","
                    StrRisk = StrRisk & 2 & ","
                    strProgram = strProgram & 2 & ","
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                ElseIf CType(drTask("Risk"), Integer) >= CType(drSQERT("Upper_Low"), Integer) And CType(drTask("Risk"), Integer) <= CType(drSQERT("Upper_High"), Integer) Then
                    strProjectOverview = strProjectOverview & 3 & ","
                    StrRisk = StrRisk & 3 & ","
                    strProgram = strProgram & 3 & ","
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                End If
            End If
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
            If drSQERT.Read Then
                If CType(drTask("Time"), Integer) >= CType(drSQERT("Lower_Low"), Integer) And CType(drTask("Time"), Integer) <= CType(drSQERT("Lower_High"), Integer) Then
                    strProjectOverview = strProjectOverview & 1 & ","
                    StrTime = StrTime & 1 & ","
                    strProgram = strProgram & 1 & ","
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                ElseIf CType(drTask("Time"), Integer) >= CType(drSQERT("Middle_Low"), Integer) And CType(drTask("Time"), Integer) <= CType(drSQERT("Middle_High"), Integer) Then
                    strProjectOverview = strProjectOverview & 2 & ","
                    StrTime = StrTime & 2 & ","
                    strProgram = strProgram & 2 & ","
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                ElseIf CType(drTask("Time"), Integer) >= CType(drSQERT("Upper_Low"), Integer) And CType(drTask("Time"), Integer) <= CType(drSQERT("Upper_High"), Integer) Then
                    strProjectOverview = strProjectOverview & 3 & ","
                    StrTime = StrTime & 3 & ","
                    strProgram = strProgram & 3 & ","
                    'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                    'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                End If
            End If
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
            If InStr(strProjectOverview, "3") > 0 Then
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
            ElseIf InStr(strProjectOverview, "2") > 0 Then
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
            Else
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
            End If

            'CommonFunctions.General.WriteHTML("</td><td Align='left'><a Href=""javascript:SQERTEVOnclick(" + CommonFunctions.Data.CheckIsDBNull(drTask("ProjectID"), "").ToString + ",'" + CDate(drTask("StartDate")).ToString("dd-MMM-yyyy") + "','" + CDate(drTask("EndDate")).ToString("dd-MMM-yyyy") + "' )"">EV</a></td>")
            CommonFunctions.General.WriteHTML("</td>")

            CommonFunctions.General.WriteHTML("</TR>")

            strProjectOverview = ""
            CommonFunctions.Data.DisposeDataReader(drSQERT)
        End While

        CommonFunctions.Data.DisposeDataReader(drTask)
        CommonFunctions.Data.DisposeDataReader(drSQERT)

        If intRecords = 0 Then
            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD colspan=7 align='Center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
        Else
            If m_strTRstyle = "clsTREven" Then
                m_strTRstyle = "clsTROdd"
            Else
                m_strTRstyle = "clsTREven"
            End If

            CommonFunctions.General.WriteHTML("<TR class=" & m_strTRstyle & ">")
            CommonFunctions.General.WriteHTML("<td Align='left'> <b>" & MyBase.GetResourceString("OVERVIEW") & " </b> </td>")

            CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
            If InStr(strScope, "3") > 0 Then
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
            ElseIf InStr(strScope, "2") > 0 Then
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
            Else
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
            End If
            CommonFunctions.General.WriteHTML("</TD>")


            CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
            If InStr(StrQuality, "3") > 0 Then
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
            ElseIf InStr(StrQuality, "2") > 0 Then
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
            Else
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
            End If
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
            If InStr(StrEffort, "3") > 0 Then
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
            ElseIf InStr(StrEffort, "2") > 0 Then
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
            Else
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
            End If
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
            If InStr(StrRisk, "3") > 0 Then
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
            ElseIf InStr(StrRisk, "2") > 0 Then
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
            Else
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
            End If
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
            If InStr(StrTime, "3") > 0 Then
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
            ElseIf InStr(StrTime, "2") > 0 Then
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
            Else
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
            End If
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TD ALIGN='Center'>")
            If InStr(strProgram, "3") > 0 Then
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
            ElseIf InStr(strProgram, "2") > 0 Then
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
            Else
                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
            End If
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
        End If

        CommonFunctions.General.WriteHTML("</TBODY></TABLE>")

        ''Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<table cellSpacing='1' cellPadding='0' width='99.9%' border='0'>")
        ''Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TBODY><tr></tr>")
        'CommonFunctions.General.WriteHTML("<tr class=clsTRSectionHeader><td align='left' width=100%><b>" & MyBase.GetResourceString("UNLOCKED_PROJECTS") & CommonFunctions.Dates.GetDate(CType(m_dtmReportingEndDate, Date)) & "</b></td><tr>")
        'CommonFunctions.General.WriteHTML("<tr class=clsTRColumnHeader><td align='Center' width=100%>" & MyBase.GetResourceString("PROJECTNAME") & "</td><tr>")

        'If m_strProjectFilters <> "NULL" Then
        '    m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',3," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        'Else
        '    m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',3," & CType(Session("intUserID"), String) & ",NULL"
        'End If

        'drTask = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        'intRecords = 0

        'While drTask.Read
        '    intRecords = intRecords + 1
        '    CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD Align=Left>" & CommonFunctions.Data.CheckIsDBNull(drTask("ProjectName"), "").ToString & "</TD></TR>")
        'End While

        'CommonFunctions.Data.DisposeDataReader(drTask)

        'If intRecords = 0 Then
        '    CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD Align=Center>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
        'End If

        'CommonFunctions.General.WriteHTML("</TBODY></TABLE>")
    End Sub
    Private Function GenerateMenu() As String
        '=====================================================================
        ' function Name         : GenerateTopMenu()	
        ' Purpose               : To generate top menu
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Mangesh Y
        ' Created               : Jan 06, 2005
        ' Revisions             :
        '=====================================================================


        Dim ArrTopMenuCaptionsList As New ArrayList
        Dim ArrTopMenuToolTipsList As New ArrayList
        Dim ArrTopMenuFunctionsList As New ArrayList

        'Initialize resource file 
        MyBase.InitializeResources("AppResources.PM_SQERT", "AppResources")

        If m_strMode.ToUpper = "" Or m_strMode.ToUpper = "CHANGE" Then
            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_UPDATESQERTVALUES"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_UPDATESQERTVALUES_TOOLTIP"))
            ArrTopMenuFunctionsList.Add("UpdateSQERTValues_Click()")

            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_VIEWREPORT"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_VIEWREPORT_TOOLTIP"))
            ArrTopMenuFunctionsList.Add("ViewReport_Click()")
        End If

        ''
        If m_strMode.ToUpper = "SQERTVALUES" Or m_strMode.ToUpper = "SAVESQERTVALUES" Then
            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SHOWHISTORY"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SHOWHISTORY_TOOLTIP"))
            ArrTopMenuFunctionsList.Add("ShowHistory_OnClick()")

            If m_strAction <> "Disabled" Then
                If blnDisable = True Then
                    ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_ADDNEW"))
                    ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_ADDNEW"))
                    ArrTopMenuFunctionsList.Add("AddNew_OnClick()")
                Else
                    ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_UPDATESQERTVALUES"))
                    ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_UPDATESQERTVALUES_TOOLTIP"))
                    ArrTopMenuFunctionsList.Add("SaveSQERT_OnClick()")
                End If
            End If
        End If
        ' End of Addition
        If m_strMode.ToUpper = "SQERTDETAILS" Or m_strMode.ToUpper = "SQERTVALUES" Or m_strMode.ToUpper = "VIEWREPORT" Or m_strMode.ToUpper = "SHOWHISTORY" Or m_strMode.ToUpper = "SAVESQERTVALUES" Or m_strMode.ToUpper = "RISK" Or m_strMode.ToUpper = "ISSUEDETAILS" Or m_strMode.ToUpper = "TASKDETAILS" Or m_strMode.ToUpper = "TRENDGRAPH" Or m_strMode.ToUpper = "DELIVERABLESDETAILS" Then
            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
            ArrTopMenuFunctionsList.Add("Close_Click()")
        End If

        ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        ArrTopMenuFunctionsList.Add("Help_OnClick(" & m_lngTagId.ToString & ")")

        Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
        ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
        ArrTopMenuCaptionsList = Nothing

        Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String
        ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)
        ArrTopMenuToolTipsList = Nothing

        Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
        ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)
        ArrTopMenuFunctionsList = Nothing

        'Generate menu string and return
        Return WebPage.Templates.StaticMenu.DrawMenu(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True)
    End Function

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        :   PageInit
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw all controls on the page
        ' Description           :   This is main procedure on this page which actually draw the page with its 
        '                           controls on it. This procedure is called from the HTML body tag of the page.
        '                           this procedure gives the call to other procedures and functions in the class.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   PrakashR
        ' Created               :   
        ' Revisions             :   
        '=====================================================================
        Call GetGlobalObject()

    End Sub

    Private Sub ShowGraphSection()
        '=====================================================================
        ' Procedure Name        : ShowGraphSection()
        ' Purpose               : Creates the Graph Section
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NiranjanK
        ' Created               : October 07, 2005
        ' Revisions             : 
        '=====================================================================
        Dim objGraphs As New DBGraphs
        Dim objGraphSection As New WebPages.Template.SectionTitle
        With objGraphSection
            'Response.Write(.GetSectionTitle(MyBase.GetResourceString("GRAPH"), "DivOtherInfo", "ShowHideOtherInfo"))
            Response.Write(.GetSectionTitle("Graphs", "DivGraphs", "ShowHideGraphs"))
            Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
            Response.Write(.ClientsideScript())
            Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
        End With

        '--Div for section title
        Response.Write("<DIV Id='DivGraphs' Style='Overflow:Auto;Width=100%'>")
        With objGraphs
            .ProjectID = CType(m_strProjectId, Long)
            .TagID = m_lngTagId
            .ReportGenerationDate = "'" & m_strReportedDate & "'"
            .GenerateGraphs()
            .m_intGraphCount = 1
            .ShowFooterNote = True
        End With
        Response.Write("</DIV>")
    End Sub

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        :  GetGlobalObject
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get an instance of the global object
        ' Description           :  This sub-routine fills the global object and 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub

#End Region

    Public Sub New()
        ' MyBase.ApplySecurity()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    Private Sub objEVDetails_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objEVDetails.ColumnHeaderTD_BeforePrint
        If Args.DataField = "FieldValue" Then
            Args.StringToBeInserted = "<TD></TD>"
            Cancel = True
        End If
        If Args.DataField = "EVElementName" Then
            Cancel = True
        End If
    End Sub

    Private Sub objEVDetails_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objEVDetails.DataRowTD_BeforePrint
        Dim strColumn As String
        If Args.DataField = "EVElementName" Then
            Cancel = True
        End If

        strColumn = CType(Args.DataReader.Item("EVElementName"), String)
        If (strColumn = "Status") Or (strColumn = "PossibleCauses") Or (strColumn = "PossibleSolutions") Then
            '  Select Case strColumn
            '     Case "Status"
            'm_strStatus = CType(Args.DataReader.Item("FieldName"), String)
            'm_strStatus = CommonFunctions.General.FormatString(m_strStatus, True)
            '   Case "PossibleCauses"
            'm_strPossibleCauses = CType(Args.DataReader.Item("FieldName"), String)
            '   Case "PossibleSolutions"
            'm_strPossibleSolutions = CType(Args.DataReader.Item("FieldName"), String)
            'End Select
            Cancel = True
        End If
    End Sub

    Private Sub objEVDetails_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objEVDetails.DataRowTR_BeforePrint

    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MyBase.ApplySecurity(True)
    End Sub

    Private Sub m_objActiveResourceGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles m_objActiveResourceGrid.ColumnHeaderTR_BeforePrint
        Args.clsColumnHeader = "clsTRSectionHeader"
    End Sub
End Class
