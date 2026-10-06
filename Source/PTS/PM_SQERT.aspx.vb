'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  PbNITE
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

Public Class PM_SQERT
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
    Protected WithEvents frmPM_SQERT As System.Web.UI.HtmlControls.HtmlForm
    Private WithEvents m_objActiveResourceGrid As New WebPages.Template.GenericGrid
    'END OF ADDITION BY VIVEKP ON 21 SEP 2005
    '' Added By NitinVS on 6 Aug 2008 For Project Profitability Functionality 
    'Private Structure GraphCaption
    '    Dim GraphCaption As String
    '    Dim LeftCaption As String
    '    Dim XaxisCaption As String
    'End Structure

    'Dim m_dsGraphs As DataSet
    'Protected tblGraphs As New System.Web.UI.HtmlControls.HtmlTable
    '' End Added By NitinVS on 6 Aug 2008 For Project Profitability Functionality 
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
            .ReportGenerationDate = m_strReportedDate
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
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        strSQL = " EXEC usp_Sel_EarnedValueReport '" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & m_strProjectId
        With objEVDetails
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 2
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
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
        ' Added By MahendraV On 5:49 PM 7/19/2007 For WhizibleSEM 7
        ' To show all project on the basis of Login Type  for 'Project Health Sheet' 
        ' Start_MV_ 7/19/2007
        If CType(Session("LoginType"), String) = "E" Then
            ' End_MV_ 7/19/2007
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
            ' Added By MahendraV On 5:49 PM 7/19/2007 For WhizibleSEM 7
            ' To show all project on the basis of Login Type  for 'Project Health Sheet' 
            ' Start_MV_ 7/19/2007
        ElseIf CType(Session("LoginType"), String) = "C" Then
            Dim strQuery As String = ""
            Dim strProjectList As String = ""

            strQuery = "usp_Sel_GetProjectNameList_SQERT_Customer " + CType(Session("intUserID"), String)
            drProject = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            While (drProject.Read())
                strProjectList = strProjectList + "," + drProject("ProjectID").ToString()

            End While
            CommonFunction.Data.DisposeDataReader(drProject)
            strProjectList = strProjectList.Substring(1, strProjectList.Length - 1)
            m_strProjectFilters = strProjectList
            ' End_MV_ 7/19/2007
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
            ' Modified By MahendraV On 5:49 PM 7/19/2007 For WhizibleSEM 7
            ' To show Location on the basis of login type  for 'Project Health Sheet' 
            ' Start_MV_ 7/19/2007
            m_strSQLOU = m_strSQLOU & m_strBUId & "," & CType(Session("intUserID"), String) & "," & CType(Session("LoginType"), String)
            ' End_MV_ 7/19/2007
        Else
            m_strBUId = ""
           
            m_strSQLProject = m_strSQLProject & "NULL,"
            ' Modified By MahendraV On 5:49 PM 7/19/2007 For WhizibleSEM 7
            ' To show Location on the basis of login type  for 'Project Health Sheet' 
            ' Start_MV_ 7/19/2007
            m_strSQLOU = m_strSQLOU & "NULL " & "," & CType(Session("intUserID"), String) & "," & CType(Session("LoginType"), String)
            ' End_MV_ 7/19/2007
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
        ' Modified By MahendraV On 5:49 PM 7/19/2007 For WhizibleSEM 7
        ' To show all project on the basis of Login Type  for 'Project Health Sheet' 
        ' Start_MV_ 7/19/2007
        
            If m_strProjectFilters <> "NULL" Then
            m_strSQLProject = m_strSQLProject & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'," & CType(Session("LoginType"), String)
            Else
            m_strSQLProject = m_strSQLProject & CType(Session("intUserID"), String) & "," & m_strProjectFilters & "," & CType(Session("LoginType"), String)
            End If

        ' End_MV_ 7/19/2007
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
                    ' Commented and Added By MahendraV On 11:00 PM 29-Oct-2007
                    ' Purpose : To display Month start date and end date if Month end with 31st , 28th and 29th.
                    ' Start_MV_29-Oct-2007
                    ' m_dtmReportingStartDate = CType(DateAdd("d", -29, m_dtmReportingEndDate), Date)
                    ' m_dtmNextReportingEndDate = CType(DateAdd("d", 30, m_dtmReportingEndDate), Date)
                    Dim strStartDate As String
                    Dim strEndDate As String
                    CommonFunction.Dates.GetFromAndToDates("9", strStartDate, strEndDate, CType(m_dtmReportingEndDate, String))
                    Dim intLastDayOfMonth As Integer = m_dtmReportingEndDate.Day
                    Dim intMonthOfFeb As Integer = m_dtmReportingEndDate.Month
                    Dim intLastDayOfNextMonth As Integer = CType(strEndDate, Date).Day

                    If intLastDayOfMonth = 31 Then
                        m_dtmReportingStartDate = CType(DateAdd("d", -30, m_dtmReportingEndDate), Date)
                        m_dtmNextReportingEndDate = CType(DateAdd("d", intLastDayOfNextMonth, m_dtmReportingEndDate), Date)
                    Else
                        If intLastDayOfMonth = 28 And intMonthOfFeb = 2 Then
                            m_dtmReportingStartDate = CType(DateAdd("d", -27, m_dtmReportingEndDate), Date)
                            m_dtmNextReportingEndDate = CType(DateAdd("d", intLastDayOfNextMonth, m_dtmReportingEndDate), Date)
                        Else
                            If intLastDayOfMonth = 29 And intMonthOfFeb = 2 Then
                                m_dtmReportingStartDate = CType(DateAdd("d", -28, m_dtmReportingEndDate), Date)
                                m_dtmNextReportingEndDate = CType(DateAdd("d", intLastDayOfNextMonth, m_dtmReportingEndDate), Date)
                            Else
                                m_dtmReportingStartDate = CType(DateAdd("d", -29, m_dtmReportingEndDate), Date)
                                'm_dtmNextReportingEndDate = CType(DateAdd("d", 30, m_dtmReportingEndDate), Date)
                                'Intergrated By SuvarnaA on 6-April-09 For PTC RequestID - 19154
                                'Purpose:
                                'aaded by SonalD on 6th April 2009 For RequestID 19270
                                'Purpose : while calculating m_dtmNextReportingEndDaten no. of days to be aaded(30,31,28,29)depends on the month of m_dtmReportingEndDate
                                Dim intMonth As Integer
                                intMonth = m_dtmReportingEndDate.Month()
                                If intMonth = 4 Or intMonth = 6 Or intMonth = 9 Or intMonth = 11 Then
                                    'End of addition on 6th April 2009 For RequestID 19270
                                    'End of Intrgration BySuvarnaA on 6-April-09 For PTC RequestID - 19154
                                    m_dtmNextReportingEndDate = CType(DateAdd("d", 30, m_dtmReportingEndDate), Date)
                                    'Intergrated By SuvarnaA on 6-April-09 For PTC RequestID - 19154
                                    'Purpose:
                                    'Added by SonalD on 6th April 2009 For RequestID 19270
                                ElseIf intMonth = 1 Or intMonth = 3 Or intMonth = 5 Or intMonth = 7 Or intMonth = 8 Or intMonth = 10 Or intMonth = 12 Then
                                    m_dtmNextReportingEndDate = CType(DateAdd("d", 31, m_dtmReportingEndDate), Date)
                                ElseIf intMonth = 2 Then
                                    If Math.IEEERemainder(m_dtmReportingEndDate.Year, 4) = 0 Then
                                        m_dtmNextReportingEndDate = CType(DateAdd("d", 29, m_dtmReportingEndDate), Date)
                                    Else
                                        m_dtmNextReportingEndDate = CType(DateAdd("d", 28, m_dtmReportingEndDate), Date)
                                    End If
                                End If
                                'End of addition by SonalD on 6th April 2009 For RequestID 19270
                                'End of Intrgration BySuvarnaA on 6-April-09 For PTC RequestID - 19154

                            End If
                        End If
                    End If
                    ' End_MV_29-Oct-2007
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
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'm_strSQL = "Select ISNULL(ProjectGroupID,0) AS 'ProjectGroupID', ISNULL(ProjectGroupName,'') As 'ProjectGroupName' From tbl_PM_ProjectGroup WHERE ProjectGroupID = (SELECT ProjectGroupID FROM tbl_PM_Project WHERE ProjectID= " & m_strProjectId & ")"
            m_strSQL = "usp_sel_PID_tbl_PM_ProjectGroup " + m_strProjectId
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


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
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'm_strSQL = "Select Reportingdate from tbl_PM_SQERTValues Where Locked=1 AND ProjectID=" & m_strProjectId
            ' m_strSQL = m_strSQL & "group by Reportingdate,LockedDate Having LockedDate=(Select Max(Lockeddate) from tbl_PM_SQERTValues where Locked=1 and ProjectID=" & m_strProjectId & ")"
            m_strSQL = "usp_sel_tbl_PM_SQERTValues_Reporting " + m_strProjectId
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query

           

            drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            If drSQERT.Read Then
                m_dtmlastlockedDate = CType(drSQERT("ReportingDate"), DateTime)
            End If
            CommonFunctions.Data.DisposeDataReader(drSQERT)

            drSQERT = CommonFunctions.Data.GetDataReader("Exec usp_RPT_GetProjectandProgramdetails " & m_strProjectId & ",0", MyBase.UseSQL)

            If drSQERT.Read Then
                m_dtmProjectStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ExpectedStartDate"), "").ToString, Date)
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
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'm_strSQL = "Select TypeId, ProjectType From tbl_PRS_ProjectTypes WHERE TypeId = " & m_strCategoryId
            m_strSQL = "usp_sel_Type_tbl_PRS_ProjectTypes " & m_strCategoryId
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            If drSQERT.Read Then
                m_strCategory = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectType"), "").ToString
            End If
            CommonFunctions.Data.DisposeDataReader(drSQERT)
            m_strQuery = m_strQuery & "," & m_strCategoryId
        ElseIf m_strProjectId <> "" Then
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'm_strSQL = "Select TypeId, ProjectType From tbl_PRS_ProjectTypes WHERE TypeId = (SELECT ProjectTypeID FROM tbl_PM_Project WHERE ProjectID= " & m_strProjectId & ")"
            m_strSQL = "usp_sel_TypeProject_tbl_PRS_ProjectTypes " & m_strProjectId

            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


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
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'm_strSQL = "Select BusinessGroup from tbl_CNF_BusinessGroups where BusinessGroupID= " & m_strBUId
            m_strSQL = "usp_sel_tbl_CNF_BusinessGroups_BG " & m_strBUId
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            If drSQERT.Read Then
                m_strBU = CommonFunctions.Data.CheckIsDBNull(drSQERT("BusinessGroup"), "").ToString
            End If
            CommonFunctions.Data.DisposeDataReader(drSQERT)
            m_strQuery = m_strQuery & "," & m_strBUId
        ElseIf m_strProjectId <> "" Then
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            ' m_strSQL = "Select BusinessGroupID, BusinessGroup from tbl_CNF_BusinessGroups where BusinessGroupID=(SELECT BusinessGroupID FROM tbl_PM_Project WHERE ProjectID= " & m_strProjectId & ")"
            m_strSQL = "usp_sel_BG_tbl_CNF_BusinessGroups " & m_strProjectId
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


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
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'm_strSQL = "Select Location from tbl_PM_Location where LocationID= " & m_strOUId
            m_strSQL = "usp_sel_tbl_PM_Location_OU " & m_strOUId
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            If drSQERT.Read Then
                m_strOU = CommonFunctions.Data.CheckIsDBNull(drSQERT("Location"), "").ToString
            End If
            CommonFunctions.Data.DisposeDataReader(drSQERT)
            m_strQuery = m_strQuery & "," & m_strOUId
        ElseIf m_strProjectId <> "" Then
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            '  m_strSQL = "Select LocationID, Location from tbl_PM_Location where LocationID=(SELECT LocationID FROM tbl_PM_Project WHERE ProjectID= " & m_strProjectId & ")"
            m_strSQL = "usp_sel_Loc_tbl_PM_Location " & m_strProjectId
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


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

        'Added By VarunA on 11-Mar-2008 RequestID-12040
        'Purpose : To have the frequency of the timesheet in Management Dashboard (High level) 
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
        'End By VarunA on 11-Mar-2008 RequestID-12040

        If m_strMode.ToUpper = "" Or m_strMode.ToUpper = "CHANGE" Then
            ' Commented  by Viraj P on 16 Nov 2015

            'CommonFunctions.General.WriteHTML("<DIV ID='DIVLIST' STYLE='overflow:auto;WIDTH:100%;HEIGHT=440px'>")
            CommonFunctions.General.WriteHTML("<DIV ID='DIVLIST'  STYLE='overflow:auto;WIDTH:100%;'>")

            'End of Comment  by Viraj P on 16 Nov 2015
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            'Commented Added By Shamkant S on 30 Nov 2015
            'CommonFunctions.General.WriteHTML("<TABLE   CELLSPACING='0' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
            CommonFunctions.General.WriteHTML("<TABLE  class=clsTable CELLSPACING='0' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
            'Ended By Shamkant s on 30 Nov 2015
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TBODY><TR class=clsTREven > ")

            CommonFunctions.General.WriteHTML("<TD align='right' width=300>" & MyBase.GetResourceString("PRACTICE") & "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")

            'Display Category Combo  
            ' Modified by MahendraV On 11:54 AM 7/21/2007 For WhizibleSEm 7.0
            ' To show Practice on the basis of Login Type for Project Health Sheet
            ' Start_MV_7/21/2007
            'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboCategoryID", "Select TypeId, ProjectType From tbl_PRS_ProjectTypes Order By ProjectType", 300, m_strCategoryId, "" + " Langugage=JavaScript OnChange=cboCategory_change()", True, True, , False))
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboCategoryID", "usp_Sel_tbl_CNF_Practice_SQERT " & CType(Session("intUserID"), String) & "," & CType(Session("LoginType"), String), 300, m_strCategoryId, "" + " Langugage=JavaScript OnChange=cboCategory_change()", True, True, , False))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            ' End_MV_7/21/2007

            CommonFunctions.General.WriteHTML("<TR class=clsTREven > ")
            CommonFunctions.General.WriteHTML("<TD align='right' width=300>" & MyBase.GetResourceString("BUSINESSGROUP") & "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")

            'Display Business Unit Combo
            ' Modified by MahendraV On 11:54 AM 7/21/2007 For WhizibleSEm 7.0
            ' To show BU on the basis of Login Type for Project Health Sheet
            ' Start_MV_7/21/2007
            'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboBUID", "usp_Sel_tbl_CNF_BusinessGroup", 300, m_strBUId, "" + " Langugage=JavaScript OnChange=cboBU_change()", True, True, , False))
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboBUID", "usp_Sel_tbl_CNF_BusinessGroup_SQERT " & CType(Session("intUserID"), String) & "," & CType(Session("LoginType"), String), 300, m_strBUId, "" + " Langugage=JavaScript OnChange=cboBU_change()", True, True, , False))
            ' End_MV_7/21/2007
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
            ' Modified By MahendraV On 5:49 PM 7/19/2007 For WhizibleSEM 7
            ' To show Project Group on the basis of login type  for 'Project Health Sheet' 
            ' Start_MV_ 7/19/2007
            'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProgramID", "usp_Sel_tbl_CNF_ProjectGroup", 300, m_strProgramId, "" + " Langugage=JavaScript OnChange=cboProgram_change()", True, True, , False))
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProgramID", "usp_Sel_tbl_CNF_ProjectGroup_SQERT " & CType(Session("intUserID"), String) & "," & CType(Session("LoginType"), String), 300, m_strProgramId, "" + " Langugage=JavaScript OnChange=cboProgram_change()", True, True, , False))
            ' End_MV_ 7/19/2007
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

            'Commented By VarunA on 11-Mar-2008 for RequestID-12040
            'Purpose : We wasn't getting the correct m_intReportingPeriod, as the SP wasn't been executed
            'Dim objReportingFreqDR As IDataReader
            'Dim strFrequency As String
            'Dim intFrequencyId As Integer

            'objReportingFreqDR = CommonFunction.Data.GetDataReader("usp_SEL_Tbl_PM_companyInformation_ResourceTimeSheetFrequency", MyBase.UseSQL)
            'If objReportingFreqDR.Read Then
            '    strFrequency = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objReportingFreqDR("Frequency"), ""), "")
            '    intFrequencyId = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objReportingFreqDR("FrequencyID"), "0"), "0"), Integer)
            '    m_intReportingPeriod = intFrequencyId
            'End If

            'CommonFunction.Data.DisposeDataReader(objReportingFreqDR)
            'End By VarunA on 11-Mar-2008 for RequestID-12040

            CommonFunction.General.WriteHTML(strFrequency)
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            'CommonFunction.HTMLControls.DrawTextBox("txtReportingFrequency", "txtReportingFrequency", value:=intFrequencyId.ToString, displaynone:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtReportingFrequency", "txtReportingFrequency", value:=intFrequencyId.ToString, DisplayNone:=True, EnableHTMLEncode:=True)
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("</TR>")

            'Last locked date : hidden control
            CommonFunctions.General.WriteHTML("<input type=Hidden name='txtLastLockedDate' value='" & CommonFunction.Dates.GetDate(CType(m_dtmlastlockedDate, Date)) & "'>")
            CommonFunctions.General.WriteHTML("</TBODY></TABLE>")
        End If

        If m_strMode.ToUpper = "VIEWREPORT" Then
            ''Commented and Added by Dhanashri S on 23 Dec 2015
            ''CommonFunctions.General.WriteHTML("<DIV ID='PageDiv' STYLE='overflow:auto;width:100%;height=560px'>")
            CommonFunctions.General.WriteHTML("<DIV ID='PageDiv' STYLE='overflow:auto;width:100%;height:560px'>")
            ''End of Comment and Addition by Dhanashri S on 23 Dec 2015
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='0' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable' >")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            ' Modified by MahendraV On 6:13 PM 6/21/2007 To displaying reporting dates
            ' Start_MV_6/21/2007
            CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
            CommonFunctions.General.WriteHTML("<TD align=right colspan=2> <b>" & MyBase.GetResourceString("FDate") & "</b></td>")
            CommonFunctions.General.WriteHTML("<TD align=left COLSPAN=3 > &nbsp;" & CommonFunctions.Dates.GetDate(m_dtmReportingStartDate) & "</td>")
            CommonFunctions.General.WriteHTML("<TD align=right colspan=2> <b>" & MyBase.GetResourceString("TODate") & "</b></td>")
            CommonFunctions.General.WriteHTML("<TD align=left COLSPAN=3> &nbsp;" & CommonFunctions.Dates.GetDate(m_dtmReportingEndDate) & "</td>")
            CommonFunctions.General.WriteHTML("</TR>")
            ' End_MV_6/21/2007
            CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
            CommonFunctions.General.WriteHTML("<TD align='right' colspan=2 Width=25%> <b>" & MyBase.GetResourceString("BUSINESSGROUP") & "</b></td>")
            CommonFunctions.General.WriteHTML("<TD align='Left'  colspan=3 Width=25%> &nbsp;" & m_strBU & "</td>")
            '=========================================================================================
            'Code Added :   PadmnabhA                               Wednesday, November 16, 2005 9:27
            'Purpose    :   To Display OU filter
            '========================================================================================= 
            CommonFunctions.General.WriteHTML("<TD align='right' colspan=2 Width=25%> <b>" & MyBase.GetResourceString("ORAGNIZATIONUNIT") & "</b></td>")
            CommonFunctions.General.WriteHTML("<TD align='Left'  colspan=3 Width=25%> &nbsp;" & m_strOU & "</td>")
            '=========================================================================================
            'Additon Ends : PadmnabhA                               Wednesday, November 16, 2005 9:27
            '=========================================================================================
            CommonFunctions.General.WriteHTML("</TR>")

            CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
            CommonFunctions.General.WriteHTML("<TD align='right' colspan=2 Width=25%> <b>" & MyBase.GetResourceString("PROJECTGROUP") & "</b></td>")
            CommonFunctions.General.WriteHTML("<TD align='Left'  colspan=3 Width=25%> &nbsp;" & m_strProgramName & "</td>")
            CommonFunctions.General.WriteHTML("<TD align='right' colspan=2 Width=25%> <b>" & MyBase.GetResourceString("PROJECT") & "</b></td>")
            CommonFunctions.General.WriteHTML("<TD align='Left'  colspan=3 Width=25%> &nbsp;" & m_strProjectName & "</td>")
            CommonFunctions.General.WriteHTML("</TR>")

            CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
            CommonFunctions.General.WriteHTML("<TD align='right' colspan=2 Width=25%> <b>" & MyBase.GetResourceString("PRACTICE") & "</b></td>")
            CommonFunctions.General.WriteHTML("<TD align='Left'  colspan=3 Width=25%> &nbsp;" & m_strCategory & "</td>")
            CommonFunctions.General.WriteHTML("<TD align='right' colspan=2 Width=25%> &nbsp; </td>")
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

            'CommonFunctions.General.WriteHTML("<TD>")
            'Call DisplayIssueGrid()
            'CommonFunctions.General.WriteHTML("</td>")

            'KEY achievements Grid
            CommonFunctions.General.WriteHTML("<TD>")
            Call DisplayKeyAchivement()
            CommonFunctions.General.WriteHTML("</td></TR>")
            ' Modified by MahendraV On 7:46 PM 6/15/2007 To change format to displaying issue details
            ' Start_MV_6/15/2007
            CommonFunctions.General.WriteHTML("<TR class=clsTREven valign='top'>")
            CommonFunctions.General.WriteHTML("<TD>")
            CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' BORDER='0' class='clsGridTable' WIDTH='99.9%'>")
            CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'  Width=100%> <b> " & MyBase.GetResourceString("ISSUES_DEFECTS") & " </B></TD></TR></TABLE>")

            CommonFunctions.General.WriteHTML("<DIV id='divListBaseLine' style='overflow:auto;height=220;Width:100%;'>")

            Call DisplayIssueGrid()
            CommonFunctions.General.WriteHTML("</DIV></td></TR>")
            ' End_MV_6/15/2007

            CommonFunctions.General.WriteHTML("</TABLE>")
            '======================================================================================
            ' First Block of Issues and Key achivement grids completes
            '======================================================================================

            '======================================================================================
            ' SQERT draw section
            '======================================================================================
            Call DisplaySQERT()
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='0' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
            CommonFunctions.General.WriteHTML("<TD VAlign=TOP colspan=3>")



            '======================================================================================
            ' Milestone draw section
            '======================================================================================
            Call DisplayMileStoneDetails()

            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("</TR></TABLE>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE CELLSPACING='0' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TR>")

            ' To show the baseline details only when the Project Creation Workflow is applicable 
            CommonFunctions.General.WriteHTML("<TD VAlign=TOP >")

            '======================================================================================
            ' BASELINE draw section
            '======================================================================================
            If m_strProjectId <> "" Then
                Dim bln_IsprojectCreationWorkflowReqd As Boolean
                'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
                'bln_IsprojectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT ISNull(IsProjectCreationWorkFlowReqd,0) FROM tbl_PRS_ProjectTypes , Tbl_PM_Project WHERE tbl_PRS_ProjectTypes.TypeID =  Tbl_PM_Project.ProjectTypeID AND  ProjectID =  " + m_strProjectId, MyBase.UseSQL), "0"), Boolean)
                bln_IsprojectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_WorkFlow_tbl_PRS_ProjectTypes " + m_strProjectId, MyBase.UseSQL), "0"), Boolean)

                'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query



                If bln_IsprojectCreationWorkflowReqd = True Then
                    ' Modified by MahendraV On 5:07 PM 6/19/2007 To change format to displaying issue details
                    ' Start_MV_6/19/2007
                    CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
                    CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'   Width=100%> <b>" & MyBase.GetResourceString("TITLE_BASELINE") & "</b></td></TR></TABLE>")
                    CommonFunctions.General.WriteHTML("<div id='divListBaseLine' style='overflow:auto;height=220;Width:100%;'>")
                    ' End_MV_6/19/2007
                    Call DisplayBaselineDetails()
                    CommonFunction.General.WriteHTML("</DIV>")
                End If
            Else
                ' Modified by MahendraV On 5:07 PM 6/19/2007 To change format to displaying issue details
                ' Start_MV_6/19/2007
                CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
                CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'   Width=100%> <b>" & MyBase.GetResourceString("TITLE_BASELINE") & "</b></td></TR></TABLE>")
                CommonFunctions.General.WriteHTML("<div id='divListBaseLine' style='overflow:auto;height=220;Width:100%;'>")
                ' End_MV_6/19/2007
                Call DisplayBaselineDetails()
                CommonFunction.General.WriteHTML("</DIV>")
            End If


            CommonFunction.General.WriteHTML("</DIV></TD></TR>")

            '======================================================================================
            ' Active Resource draw section
            '======================================================================================
            If m_strProjectId <> "" Then
                CommonFunctions.General.WriteHTML("<TR><TD VAlign=TOP >")
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
                'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
                ' blnEVApplicable = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT IsNull(EVApplicable, 0) FROM tbl_PM_Project WHERE ProjectID = " + m_strProjectId, MyBase.UseSQL), "0"), Boolean)
                blnEVApplicable = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_EVApp_tbl_PM_Project " + m_strProjectId, MyBase.UseSQL), "0"), Boolean)
                'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query



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
                CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD colspan=3 align='center' Width=50%>" & MyBase.GetResourceString("EVNAMESSAGE") & "</td></TR>")
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
            ' Commented  by Viraj P on 16 Nov 2015
            ' CommonFunctions.General.WriteHTML("<DIV ID='DIVLIST' STYLE='overflow:auto;width:100%;height=410px'>")
            CommonFunctions.General.WriteHTML("<DIV ID='DIVLIST' STYLE='overflow:auto;width:100%;'>")
            'End of Comment  by Viraj P on 16 Nov 2015
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
                CommonFunction.General.WriteHTML("<TR class=clsTREven><TD colspan=8 align='center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
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
            ' Commented  by Viraj P on 16 Nov 2015
            ' CommonFunctions.General.WriteHTML("<DIV ID='DIVLIST' STYLE='overflow:auto;width:100%;height=230px'>")
            CommonFunctions.General.WriteHTML("<DIV ID='DIVLIST' STYLE='overflow:auto;width:100%;'>")
            'End of Comment  by Viraj P on 16 Nov 2015
            CommonFunction.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'><TR class='clsTRColumnHeader'>")
            CommonFunction.General.WriteHTML("<TD width='15%'>" & MyBase.GetResourceString("UPD_SQERT") & "</TD>")
            CommonFunction.General.WriteHTML("<TD align=center width='9%'>" & MyBase.GetResourceString("UPD_VALUE") & "</TD><TD align=center width='80%'>" & MyBase.GetResourceString("UPD_DESCRIPTION") & "</TD></TR>")
            CommonFunction.General.WriteHTML("<TR class=clsTREven>")
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            'CommonFunction.HTMLControls.DrawTextBox("txtscopelow", "txtscopelow", , , , intScopelow.ToString, , , , , , True)
            'CommonFunction.HTMLControls.DrawTextBox("txtscopehigh", "txtscopehigh", , , , intScopehigh.ToString, , , , , , True)
            'CommonFunction.HTMLControls.DrawTextBox("txtqualitylow", "txtqualitylow", , , , intQualitylow.ToString, , , , , , True)
            'CommonFunction.HTMLControls.DrawTextBox("txtqualityhigh", "txtqualityhigh", , , , intQualityHigh.ToString, , , , , , True)
            'CommonFunction.HTMLControls.DrawTextBox("txtSQERTID", "txtSQERTID", , , , intSQERTID.ToString, , , , , , True)
            'CommonFunction.HTMLControls.DrawTextBox("txtProjectID", "txtProjectID", , , , m_strProjectId, , , , , , True)
            'CommonFunction.HTMLControls.DrawTextBox("txtReportingDate", "txtReportingDate", , , , m_dtmReportingEndDate.ToString, , , , , , True)
            CommonFunction.HTMLControls.DrawTextBox("txtscopelow", "txtscopelow", , , , intScopelow.ToString, , , , , , True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtscopehigh", "txtscopehigh", , , , intScopehigh.ToString, , , , , , True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtqualitylow", "txtqualitylow", , , , intQualitylow.ToString, , , , , , True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtqualityhigh", "txtqualityhigh", , , , intQualityHigh.ToString, , , , , , True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtSQERTID", "txtSQERTID", , , , intSQERTID.ToString, , , , , , True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtProjectID", "txtProjectID", , , , m_strProjectId, , , , , , True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtReportingDate", "txtReportingDate", , , , m_dtmReportingEndDate.ToString, , , , , , True, EnableHTMLEncode:=True)
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ' Scope
            strDescTitle = MyBase.GetResourceString("UPD_SCOPE") & " " & MyBase.GetResourceString("UPD_DESCRIPTION")
            CommonFunction.General.WriteHTML("<TD valign=top><B>" & MyBase.GetResourceString("UPD_SCOPE") & "</b></TD>")
            CommonFunction.General.WriteHTML("<TD align=right valign=top>")
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            'CommonFunction.HTMLControls.DrawTextBox("txtScope", "txtScope", , 40, 10, intScope.ToString, "Right", , blnDisable, , , , "onkeypress=Javascript:OnlyNumeric(1)", , True)
            'CommonFunction.General.WriteHTML("</TD><TD valign=top>")
            'CommonFunction.HTMLControls.DrawTextArea("txtScopeDesc", "txtScopeDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrScopeDesc, , , blnDisable, , , , , , True)
            CommonFunction.HTMLControls.DrawTextBox("txtScope", "txtScope", , 40, 10, intScope.ToString, "Right", , blnDisable, , , , "onkeypress=Javascript:OnlyNumeric(1)", , True, EnableHTMLEncode:=True)
            CommonFunction.General.WriteHTML("</TD><TD valign=top>")
            CommonFunction.HTMLControls.DrawTextArea("txtScopeDesc", "txtScopeDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrScopeDesc, , , blnDisable, , , , , , True, EnableHTMLEncode:=True)
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            'Quality
            strDescTitle = MyBase.GetResourceString("UPD_QUALITY") & " " & MyBase.GetResourceString("UPD_DESCRIPTION")
            CommonFunction.General.WriteHTML("</TD></TR><TR class=clsTREven><TD valign=top><B>" & MyBase.GetResourceString("UPD_QUALITY") & "</b></TD><TD  align=right valign=top>")
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            'CommonFunction.HTMLControls.DrawTextBox("txtQuality", "txtQuality", , 40, 10, intQuality.ToString, "Right", , blnDisable, , , , "onkeypress=Javascript:OnlyNumeric(1)", , True)
            'CommonFunction.General.WriteHTML("</TD><TD valign=top>")
            'CommonFunction.HTMLControls.DrawTextArea("txtQualityDesc", "txtQualityDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrQualityDesc, , , blnDisable, , , , , , True)
            CommonFunction.HTMLControls.DrawTextBox("txtQuality", "txtQuality", , 40, 10, intQuality.ToString, "Right", , blnDisable, , , , "onkeypress=Javascript:OnlyNumeric(1)", , True, EnableHTMLEncode:=True)
            CommonFunction.General.WriteHTML("</TD><TD valign=top>")
            CommonFunction.HTMLControls.DrawTextArea("txtQualityDesc", "txtQualityDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrQualityDesc, , , blnDisable, , , , , , True, EnableHTMLEncode:=True)
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            'Effort
            strDescTitle = MyBase.GetResourceString("UPD_EFFORT") & " " & MyBase.GetResourceString("UPD_DESCRIPTION")
            CommonFunction.General.WriteHTML("</TD></TR><TR class=clsTREven><TD valign=top><B>" & MyBase.GetResourceString("UPD_EFFORT") & "</b></TD><TD  align=right valign=top>")
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            'CommonFunction.HTMLControls.DrawTextBox("txtEffort", "txtEffort", , 40, 10, intEffort.ToString, "Right", , blnDisable, True, , , "onkeypress=Javascript:OnlyNumeric(1)", , True)
            'CommonFunction.General.WriteHTML("</TD><TD valign=top>")
            'CommonFunction.HTMLControls.DrawTextArea("txtEffortDesc", "txtEffortDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrEffortDesc, , , blnDisable, , , , , , True)
            CommonFunction.HTMLControls.DrawTextBox("txtEffort", "txtEffort", , 40, 10, intEffort.ToString, "Right", , blnDisable, True, , , "onkeypress=Javascript:OnlyNumeric(1)", , True, EnableHTMLEncode:=True)
            ' CommonFunction.HTMLControls.DrawTextBox("txtEffort", "txtEffort", , 40, 10, intEffort.ToString, "Right", , blnDisable, False, , , "onkeypress=Javascript:OnlyNumeric(1)", , True, EnableHTMLEncode:=True)
            CommonFunction.General.WriteHTML("</TD><TD valign=top>")
            CommonFunction.HTMLControls.DrawTextArea("txtEffortDesc", "txtEffortDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrEffortDesc, , , blnDisable, , , , , , True, EnableHTMLEncode:=True)
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            'Risk
            strDescTitle = MyBase.GetResourceString("UPD_RISK") & " " & MyBase.GetResourceString("UPD_DESCRIPTION")
            CommonFunction.General.WriteHTML("</TD></TR><TR class=clsTREven><TD valign=top><B>" & MyBase.GetResourceString("UPD_RISK") & "</b></TD><TD align=right valign=top>")
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("txtRisk", "txtRisk", , 40, 10, intRisk.ToString, "Right", , blnDisable, True, , , "onkeypress=Javascript:OnlyNumeric(1)", , True)
            'CommonFunction.HTMLControls.DrawTextBox("txtRisk", "txtRisk", , 40, 10, intRisk.ToString, "Right", , blnDisable, False, , , "onkeypress=Javascript:OnlyNumeric(1)", , True)

            CommonFunction.General.WriteHTML("</TD><TD valign=top>")
            CommonFunction.HTMLControls.DrawTextArea("txtRiskDesc", "txtRiskDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrRiskDesc, , , blnDisable, , , , , , True)
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            'Time
            strDescTitle = MyBase.GetResourceString("UPD_TIME") & " " & MyBase.GetResourceString("UPD_DESCRIPTION")
            CommonFunction.General.WriteHTML("</TD></TR><TR class=clsTREven><TD valign=top><B>" & MyBase.GetResourceString("UPD_TIME") & "</b></TD><TD align=right valign=top>")
            ''CommonFunction.HTMLControls.DrawTextBox("txtTime", "txtTime", , 40, 10, intTime.ToString, "Right", , blnDisable, True, , , "onkeypress=Javascript:OnlyNumeric(1)", , True)
            ''Commented And Added By Vidya J ON 17 Aug 2016 
            CommonFunction.HTMLControls.DrawTextBox("txtTime", "txtTime", , 40, 10, intTime.ToString, "Right", , blnDisable, True, , , "onkeypress=Javascript:OnlyNumeric(1)", , True, EnableHTMLEncode:=True)
            '  CommonFunction.HTMLControls.DrawTextBox("txtTime", "txtTime", , 40, 10, intTime.ToString, "Right", , blnDisable, False, , , "onkeypress=Javascript:OnlyNumeric(1)", , True, EnableHTMLEncode:=True)
            ''Commented And Added By Vidya J ON 17 Aug 2016 
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            CommonFunction.General.WriteHTML("</TD><TD valign=top>")
            'CommonFunction.HTMLControls.DrawTextArea("txtTimeDesc", "txtTimeDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrTimeDesc, , , blnDisable, , , , , , True)
            CommonFunction.HTMLControls.DrawTextArea("txtTimeDesc", "txtTimeDesc", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, StrTimeDesc, , , blnDisable, , , , , , True, EnableHTMLEncode:=True)
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            CommonFunction.General.WriteHTML("</TD></TR></TABLE>")

            ' Addition Ends

            CommonFunction.General.WriteHTML("</DIv>")

            'General Remarks and Escalations 
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE CELLSPACING='0' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TR class='clsTRColumnHeader'><TD colspan=2 width='100%'><B>" & MyBase.GetResourceString("UPDATE_SQERT_GENERALREMARKS_ESCALATION") & " </B><br></TD></TR>")

            CommonFunction.General.WriteHTML("<TR class='clsTREven'><TD width='15%'> " & MyBase.GetResourceString("UPDATE_SQERT_GENERALREMARKS") & " </TD><TD>")
            'Commented and added by SuchitraP on 2-Aug-2007 
            'CommonFunction.HTMLControls.DrawTextArea("txtGeneralRemarks", "txtGeneralRemarks", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, strGeneralRemarks, , , blnDisable, , , , , , False)
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            '' CommonFunction.HTMLControls.DrawTextArea("txtGeneralRemarks", "txtGeneralRemarks", "General Remarks", , , "frmPM_SQERT", , , 500, , 500, strGeneralRemarks, , , blnDisable, , , , , , False)
            CommonFunction.HTMLControls.DrawTextArea("txtGeneralRemarks", "txtGeneralRemarks", "General Remarks", , , "frmPM_SQERT", , , 500, , 500, strGeneralRemarks, , , blnDisable, , , , , , False, EnableHTMLEncode:=True)
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            'End of Comment and addition by SuchitraP on 2-Aug-2007 
            CommonFunction.General.WriteHTML("</TD></TR>")

            CommonFunction.General.WriteHTML("<TR class='clsTROdd'><TD width='15%'> " & MyBase.GetResourceString("UPDATE_SQERT_ESCALATION") & " </TD><TD>")
            'Commented and added by SuchitraP on 2-Aug-2007 
            'CommonFunction.HTMLControls.DrawTextArea("txtEscalations", "txtEscalations", strDescTitle, , , "frmPM_SQERT", , , 500, , 500, strEscalations, , , blnDisable, , , , , , False)
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ''CommonFunction.HTMLControls.DrawTextArea("txtEscalations", "txtEscalations", "Escalations", , , "frmPM_SQERT", , , 500, , 500, strEscalations, , , blnDisable, , , , , , False)
            CommonFunction.HTMLControls.DrawTextArea("txtEscalations", "txtEscalations", "Escalations", , , "frmPM_SQERT", , , 500, , 500, strEscalations, , , blnDisable, , , , , , False, EnableHTMLEncode:=True)
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            'End of Comment and addition by SuchitraP on 2-Aug-2007 
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
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

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
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
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
        Dim m_intTotalOpenIssues As Integer = 0
        Dim m_intTotalCloseIssues As Integer = 0
        Dim m_intTotal_Issues As Integer = 0
        Dim m_intTotalOthersIssues As Integer = 0
        Dim m_intTotalLessThenFiveIssues As Integer = 0
        Dim m_intTotalInBetweenFiveToTenIssues As Integer = 0
        Dim m_intTotalMoreThenTenIssues As Integer = 0
        Dim m_intTotalOverDueIssues As Integer = 0
        Dim m_intTotalShownToCustomerIssues As Integer = 0
        Dim intCntIssue As Integer = 0
        Dim m_strTRstyleIssue As String
        '    m_strSQL = "Exec USP_RPT_GetOpenAndClosedIssues " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',0," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        'Else
        '    m_strSQL = "Exec USP_RPT_GetOpenAndClosedIssues " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',0," & CType(Session("intUserID"), String) & ",NULL"
        'End If

        'drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        'If drSQERT.Read Then
        '    m_intTotalIssues = CType(drSQERT("TotalIssues"), Integer)
        '    m_intOpenIssues = CType(drSQERT("OpenIssues"), Integer)
        '    m_intClosedIssues = CType(drSQERT("ClosedIssues"), Integer)
        '    m_intOverDueIssues = CType(drSQERT("OverDueIssues"), Integer)
        '    m_intCustomerReportedIssues = CType(drSQERT("CustReportedIssues"), Integer)
        'End If
        'CommonFunctions.Data.DisposeDataReader(drSQERT)
        ' Modified by MahendraV On 7:46 PM 6/15/2007 To change format to displaying issue details
        ' Start_MV_6/15/2007

        If m_strProjectFilters <> "NULL" Then
            'Commented & added by Viraj P on 18 Nov 2015 Purpose: To convert time format as well as Date Format
            ' m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod_Count " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
            m_strSQL = "Exec USP_RPT_GetOpenAndClosedIssuestypes " & m_strQuery & ",'" & Format(CType(FormatDateTime(m_dtmReportingStartDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "','" & Format(CType(FormatDateTime(m_dtmReportingEndDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "',0," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec USP_RPT_GetOpenAndClosedIssuestypes " & m_strQuery & ",'" & Format(CType(FormatDateTime(m_dtmReportingStartDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "','" & Format(CType(FormatDateTime(m_dtmReportingEndDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "',0," & CType(Session("intUserID"), String) & ",NULL"
        End If
        'Ended by Viraj P on 18 Nov 2015 Purpose: To convert time format as well as Date Format
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)


        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' BORDER='0' class='clsGridTable' WIDTH='99.9%'>")
        CommonFunctions.General.WriteHTML("<THEAD class=clsTRColumnHeader>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag'  colspan=5 Width=40%> " & MyBase.GetResourceString("ISSUES_DEFECTS") & " </TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag'  colspan=3 Width=30%>  " & MyBase.GetResourceString("AGEING_ANALYSIS") & " </TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag'  rowspan=2 Width=15%>" & MyBase.GetResourceString("SHOWN_TO_CUSTOMER") & "  </TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag'  rowspan=2 Width=15%>  " & MyBase.GetResourceString("OVER_DUE_ISSUE") & " </TH></THEAD>")

        CommonFunctions.General.WriteHTML("<THEAD class=clsTRColumnHeader>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag'  Width=10%>  " & MyBase.GetResourceString("ISSUETYPE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag'  Width=10%>  " & MyBase.GetResourceString("OPEN_ISSUE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag'  Width=10%> " & MyBase.GetResourceString("CLOSED_ISSUE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag'  Width=10%> " & MyBase.GetResourceString("OTHERS_ISSUE") & " </TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag'  Width=10%> " & MyBase.GetResourceString("TOTAL_ISSUE") & " </TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag'  Width=10%>   " & MyBase.GetResourceString("UPTO_5_DAYS_ISSUE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag'  Width=10%> " & MyBase.GetResourceString("5_TO_10_DAYS_ISSUE") & " </TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag'  Width=10%>  " & MyBase.GetResourceString("MORE_THEN_10_DAYS_ISSUE") & " </TH>")

        CommonFunctions.General.WriteHTML("<TH align='Center'  class='divListTag' Width=10%>&nbsp;</TH>")
        CommonFunctions.General.WriteHTML("<TH align='Center' class='divListTag'  Width=10%>&nbsp; </TH></THEAD>")
        'CommonFunctions.General.WriteHTML("</TR>")
        While drSQERT.Read
            intCntIssue = intCntIssue + 1
            If (intCntIssue Mod 2) = 0 Then
                m_strTRstyleIssue = "clsTREvenRow"
            Else
                m_strTRstyleIssue = "clsTROdd"
            End If
            CommonFunctions.General.WriteHTML("<TR class=" & m_strTRstyleIssue & ">")
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("Type"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD align='left'   Width=10%> " & CommonFunctions.Data.CheckIsDBNull(drSQERT("Type"), "").ToString & " </TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD>")
            End If
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("openissues"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML(DrawLink(CInt(drSQERT("openissues")), "OpenIssues", CommonFunctions.Data.CheckIsDBNull(drSQERT("Type"), "").ToString))
                m_intTotalOpenIssues = m_intTotalOpenIssues + CInt(drSQERT("openissues"))
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD>")
            End If
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("closeissues"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML(DrawLink(CInt(drSQERT("closeissues")), "ClosedIssues", CommonFunctions.Data.CheckIsDBNull(drSQERT("Type"), "").ToString))
                m_intTotalCloseIssues = m_intTotalCloseIssues + CInt(drSQERT("closeissues"))
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD>")
            End If

            If CommonFunctions.Data.CheckIsDBNull(drSQERT("OTHERSissues"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML(DrawLink(CInt(drSQERT("OTHERSissues")), "OtherIssues", CommonFunctions.Data.CheckIsDBNull(drSQERT("Type"), "").ToString))
                m_intTotalOthersIssues = m_intTotalOthersIssues + CInt(drSQERT("OTHERSissues"))
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD>")
            End If

            If CommonFunctions.Data.CheckIsDBNull(drSQERT("totalissues"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML(DrawLink(CInt(drSQERT("totalissues")), "TotalIssues", CommonFunctions.Data.CheckIsDBNull(drSQERT("Type"), "").ToString))
                m_intTotal_Issues = m_intTotal_Issues + CInt(drSQERT("totalissues"))
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD>")
            End If

            If CommonFunctions.Data.CheckIsDBNull(drSQERT("<5"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML(DrawLink(CInt(drSQERT("<5")), "IssuesAge", CommonFunctions.Data.CheckIsDBNull(drSQERT("Type"), "").ToString, "7"))
                m_intTotalLessThenFiveIssues = m_intTotalLessThenFiveIssues + CInt(drSQERT("<5"))
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD>")
            End If

            If CommonFunctions.Data.CheckIsDBNull(drSQERT("5-10"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML(DrawLink(CInt(drSQERT("5-10")), "IssuesAge", CommonFunctions.Data.CheckIsDBNull(drSQERT("Type"), "").ToString, "8"))
                m_intTotalInBetweenFiveToTenIssues = m_intTotalInBetweenFiveToTenIssues + CInt(drSQERT("5-10"))
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD>")
            End If

            If CommonFunctions.Data.CheckIsDBNull(drSQERT(">10"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML(DrawLink(CInt(drSQERT(">10")), "IssuesAge", CommonFunctions.Data.CheckIsDBNull(drSQERT("Type"), "").ToString, "9"))
                m_intTotalMoreThenTenIssues = m_intTotalMoreThenTenIssues + CInt(drSQERT(">10"))
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD>")
            End If

            If CommonFunctions.Data.CheckIsDBNull(drSQERT("ShownToCustomer"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML(DrawLink(CInt(drSQERT("ShownToCustomer")), "CustReportedIssues", CommonFunctions.Data.CheckIsDBNull(drSQERT("Type"), "").ToString))
                m_intTotalShownToCustomerIssues = m_intTotalShownToCustomerIssues + CInt(drSQERT("ShownToCustomer"))

            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD>")
            End If

            If CommonFunctions.Data.CheckIsDBNull(drSQERT("OverDueIssues"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML(DrawLink(CInt(drSQERT("OverDueIssues")), "OverDueIssues", CommonFunctions.Data.CheckIsDBNull(drSQERT("Type"), "").ToString))
                m_intTotalOverDueIssues = m_intTotalOverDueIssues + CInt(drSQERT("OverDueIssues"))
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD>")
            End If

        End While
        CommonFunction.Data.DisposeDataReader(drSQERT)
        If intCntIssue <> 0 Then

            CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
            CommonFunctions.General.WriteHTML("<TD align='left'   Width=10%> <b> " & MyBase.GetResourceString("TOTAL_ISSUE") & " </b></TD>")

            If m_intTotalOpenIssues <> 0 Then
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%> <b><a Href=""javascript:DetailsLink_onClick('TotalOpenIssues')"">" & m_intTotalOpenIssues & " </A></b></TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%><b>" & m_intTotalOpenIssues & "</b></TD>")
            End If
            If m_intTotalCloseIssues <> 0 Then
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%> <b><a Href=""javascript:DetailsLink_onClick('TotalCloseIssues')"">" & m_intTotalCloseIssues & " </A></b></TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%><b>" & m_intTotalCloseIssues & "</b></TD>")
            End If
            If m_intTotalOthersIssues <> 0 Then
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%> <b><a Href=""javascript:DetailsLink_onClick('TotalOthersIssues')"">" & m_intTotalOthersIssues & " </A></b></TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%><b>" & m_intTotalOthersIssues & "</b></TD>")
            End If
            If m_intTotal_Issues <> 0 Then
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%> <b><a Href=""javascript:DetailsLink_onClick('Total_Issues')"">" & m_intTotal_Issues & " </A></b></TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%><b>" & m_intTotal_Issues & "</b></TD>")
            End If
            If m_intTotalLessThenFiveIssues <> 0 Then
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%> <b><a Href=""javascript:DetailsLink_onClick('TotalLessThenFiveIssues')"">" & m_intTotalLessThenFiveIssues & " </A></b></TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%><b>" & m_intTotalLessThenFiveIssues & "</b></TD>")
            End If
            If m_intTotalInBetweenFiveToTenIssues <> 0 Then
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%> <b><a Href=""javascript:DetailsLink_onClick('TotalInBetweenFiveToTenIssues')"">" & m_intTotalInBetweenFiveToTenIssues & " </A></b></TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%><b>" & m_intTotalInBetweenFiveToTenIssues & "</b></TD>")
            End If
            If m_intTotalMoreThenTenIssues <> 0 Then
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%> <b><a Href=""javascript:DetailsLink_onClick('TotalMoreThenTenIssues')"">" & m_intTotalMoreThenTenIssues & " </A></b></TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%><b>" & m_intTotalMoreThenTenIssues & "</b></TD>")
            End If
            If m_intTotalShownToCustomerIssues <> 0 Then
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%> <b><a Href=""javascript:DetailsLink_onClick('TotalShownToCustomerIssues')"">" & m_intTotalShownToCustomerIssues & " </A></b></TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%><b>" & m_intTotalShownToCustomerIssues & "</b></TD>")
            End If
            If m_intTotalOverDueIssues <> 0 Then
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%> <b><a Href=""javascript:DetailsLink_onClick('TotalOverDueIssues')"">" & m_intTotalOverDueIssues & " </A></b></TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%><b>" & m_intTotalOverDueIssues & "</b></TD></TR>")
            End If

        End If
        CommonFunctions.General.WriteHTML("</TABLE>")




        ' End_MV_6/15/2007

        'inner table for issues
        'CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' BORDER='0'>")
        'CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center' colspan=3 Width=100%> <b>" & MyBase.GetResourceString("TITLE_ISSUES") & "</b></td></TR>")

        ''Issues Trend Graph
        'If m_strProjectId <> "" Then
        '    CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>" & MyBase.GetResourceString("ISSUEGRAPH") & "</TD>")
        '    CommonFunctions.General.WriteHTML("<TD align=left width='5%'> </TD>")
        '    CommonFunctions.General.WriteHTML("<TD align=left width='40%'>")
        '    CommonFunctions.General.WriteHTML("<a Href=""javascript:ShowGraphLink_onClick()"">Show Graph</a>")
        '    CommonFunctions.General.WriteHTML("</td></TR>")
        'End If

        'CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>" & MyBase.GetResourceString("TOTALISSUES") & "</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='5%'> " & m_intTotalIssues & "</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='40%'>")
        'CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('TotalIssues')"">" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</a>")
        'CommonFunctions.General.WriteHTML("</td></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>" & MyBase.GetResourceString("TOTALOPENISSUES") & "</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='5%'> " & m_intOpenIssues & "</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='40%'>")
        'CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('OpenIssues')"">" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</a>")
        'CommonFunctions.General.WriteHTML("</td></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>" & MyBase.GetResourceString("CUSTOMERREPORTEDISSUES") & "</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='5%'> " & m_intCustomerReportedIssues & "</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='40%'>")
        'CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('CustReportedIssues')"">" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</a>")
        'CommonFunctions.General.WriteHTML("</td></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>" & MyBase.GetResourceString("TOTALCLOSEDISSUES") & "</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='5%'> " & m_intClosedIssues & "</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='40%'>")
        'CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('ClosedIssues')"">" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</a>")
        'CommonFunctions.General.WriteHTML("</td></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'><FONT color='red'>" & MyBase.GetResourceString("TOTALOVERDUEISSUES") & "</FONT></TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='5%'><FONT color='red'> " & m_intOverDueIssues & " </FONT></TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='40%'>")
        'CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('OverDueIssues')""><FONT color='red'>" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</FONT></a>")
        'CommonFunctions.General.WriteHTML("</td></TR>")


        'CommonFunctions.General.WriteHTML("</TABLE>")
    End Sub
    ' Modified by MahendraV On 12:01 PM 6/18/2007 To change format to displaying issue details
    ' Start_MV_6/18/2007

    Private Function DrawLink(ByVal intData As Integer, ByVal strFlag As String, Optional ByVal strType As String = "", Optional ByVal strFlagVal As String = "") As String
        If intData <> 0 Then
            DrawLink = "<TD align=center WIDTH=10% ><a Href=""javascript:DetailsLink_onClick('" & strFlag & "'" ')"">" & intData & "</a></TD>"
            If strType <> "" Then

                strType = strType.Replace(Chr(39), "\'")
                DrawLink = DrawLink & ",'" & strType & "'"
                If strFlagVal <> "" Then
                    DrawLink = DrawLink & "," & strFlagVal
                End If
            End If
            DrawLink = DrawLink & ")"">" & intData & "</a></TD>"
        Else
            DrawLink = "<TD align=center WIDTH=10% > " & intData & "</TD>"
        End If
    End Function
    ' Start_MV_6/18/2007

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
        Dim m_intTotalPlnnedTasks As Integer
        Dim m_intTotalPlnnedDeliverables As Integer

        Dim m_strSQL As String
        Dim drSQERT As IDataReader

        ''=========================================================================================
        ''1. Calculation of count of Tasks completed in reporting period
        ''=========================================================================================
        'If m_strProjectFilters <> "NULL" Then
        '    m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',0," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        'Else
        '    m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',0," & CType(Session("intUserID"), String) & ",NULL"
        'End If
        'drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        'If drSQERT.Read Then
        '    m_intCompletedTasks = CType(drSQERT("CompletedTasks"), Integer)
        'End If
        'CommonFunctions.Data.DisposeDataReader(drSQERT)

        ''=========================================================================================
        ''2. Calculation of count of Tasks to be completed in next reporting period
        ''=========================================================================================
        'If m_strProjectFilters <> "NULL" Then
        '    m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmNextReportingStartDate & "','" & m_dtmNextReportingEndDate & "',1," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        'Else
        '    m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmNextReportingStartDate & "','" & m_dtmNextReportingEndDate & "',1," & CType(Session("intUserID"), String) & ",NULL"
        'End If
        'drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        'If drSQERT.Read Then
        '    m_intTobeCompletedTasks = CType(drSQERT("TobeCompletedTasks"), Integer)
        'End If
        'CommonFunctions.Data.DisposeDataReader(drSQERT)

        ''=========================================================================================
        ''3. Calculation of count of Slipping Tasks in reporting period
        ''=========================================================================================
        'If m_strProjectFilters <> "NULL" Then
        '    m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',7," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        'Else
        '    m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',7," & CType(Session("intUserID"), String) & ",NULL"
        'End If
        'drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        'If drSQERT.Read Then
        '    m_intSlippingTasks = CType(drSQERT("SlippingTasks"), Integer)
        'End If
        'CommonFunctions.Data.DisposeDataReader(drSQERT)

        ''=========================================================================================
        ''4. Calculation of count of Deliverables completed in reporting period
        ''=========================================================================================
        'If m_strProjectFilters <> "NULL" Then
        '    m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',9," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        'Else
        '    m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',9," & CType(Session("intUserID"), String) & ",NULL"
        'End If
        'drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        'If drSQERT.Read Then
        '    m_intCompletedDeliverables = CType(drSQERT("CompletedDeliverables"), Integer)
        'End If
        'CommonFunctions.Data.DisposeDataReader(drSQERT)

        ''=========================================================================================
        ''5. Calculation of count of Deliverables to be completed in next reporting period
        ''=========================================================================================
        'If m_strProjectFilters <> "NULL" Then
        '    m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmNextReportingStartDate & "','" & m_dtmNextReportingEndDate & "',13," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        'Else
        '    m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmNextReportingStartDate & "','" & m_dtmNextReportingEndDate & "',13," & CType(Session("intUserID"), String) & ",NULL"
        'End If
        'drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        'If drSQERT.Read Then
        '    m_intTobeCompletedDeliverables = CType(drSQERT("TobeCompletedDeliverables"), Integer)
        'End If
        'CommonFunctions.Data.DisposeDataReader(drSQERT)

        ''=========================================================================================
        ''6. Calculation of count of Slipping Deliverables in reporting period
        ''=========================================================================================
        'If m_strProjectFilters <> "NULL" Then
        '    m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',11," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        'Else
        '    m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',11," & CType(Session("intUserID"), String) & ",NULL"
        'End If
        'drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        'If drSQERT.Read Then
        '    m_intSlippingDeliverables = CType(drSQERT("SlippingDeliverables"), Integer)
        'End If
        'CommonFunctions.Data.DisposeDataReader(drSQERT)

        ' Modified By MahendraV On 2:16 PM 6/14/2007 for SP8 Performance
        ' Start_MV_6/14/2007
        '=========================================================================================
        ' 1. Calculation of count of Tasks completed in reporting period
        ' 2. Calculation of count of Tasks to be completed in next reporting period
        ' 3. Calculation of count of total planned Tasks in next reporting period
        ' 4. Calculation of count of Slipping Tasks in reporting period
        ' 5. Calculation of count of Deliverables completed in reporting period
        ' 6. Calculation of count of Deliverables to be completed in next reporting period
        ' 7. Calculation of count of Slipping Deliverables in reporting period
        ' 8. Calculation of count of total planned Deliverables in reporting period
        ''=========================================================================================

        If m_strProjectFilters <> "NULL" Then
            'Commented & added by Viraj P on 18 Nov 2015 Purpose: To convert time format as well as Date Format
            ' m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod_Count " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod_Count " & m_strQuery & ",'" & Format(m_dtmReportingStartDate, "MM/dd/yyyy") & "','" & Format(m_dtmReportingEndDate, "MM/dd/yyyy") & "'," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod_Count " & m_strQuery & ",'" & Format(m_dtmReportingStartDate, "MM/dd/yyyy") & "','" & Format(m_dtmReportingEndDate, "MM/dd/yyyy") & "'," & CType(Session("intUserID"), String) & ",NULL"
        End If
        'Ended by Viraj P on 18 Nov 2015 Purpose: To convert time format as well as Date Format
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        If drSQERT.Read Then
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("CompletedTasks"), "").ToString() <> "" Then
                m_intCompletedTasks = CType(drSQERT("CompletedTasks"), Integer)
            End If
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("TobeCompletedTasks"), "").ToString() <> "" Then
                m_intTobeCompletedTasks = CType(drSQERT("TobeCompletedTasks"), Integer)
            End If
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("SlippingTasks"), "").ToString() <> "" Then
                m_intSlippingTasks = CType(drSQERT("SlippingTasks"), Integer)
            End If
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("TotalPlannedTasks"), "").ToString() <> "" Then
                m_intTotalPlnnedTasks = CType(drSQERT("TotalPlannedTasks"), Integer)
            End If
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("CompletedDeliverables"), "").ToString() <> "" Then
                m_intCompletedDeliverables = CType(drSQERT("CompletedDeliverables"), Integer)
            End If
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("TobeCompletedDeliverables"), "").ToString() <> "" Then
                m_intTobeCompletedDeliverables = CType(drSQERT("TobeCompletedDeliverables"), Integer)
            End If
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("SlippingDeliverables"), "").ToString() <> "" Then
                m_intSlippingDeliverables = CType(drSQERT("SlippingDeliverables"), Integer)
            End If
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("TotalPlannedDeliverables"), "").ToString() <> "" Then
                m_intTotalPlnnedDeliverables = CType(drSQERT("TotalPlannedDeliverables"), Integer)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drSQERT)


        '=========================================================================================
        'Key Achivements and Slippage section 
        '=========================================================================================
        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'   Width=100%><B>" & MyBase.GetResourceString("KEY_ACHIEVEMENTS") & "</B></TD></TR></TABLE>")

        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
        CommonFunctions.General.WriteHTML("<THEAD class='clsTRColumnHeader'>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag'   Width=20%>&nbsp;</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag'   Width=20%>" & MyBase.GetResourceString("TOTAL_PLANNED") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag'   Width=20%>" & MyBase.GetResourceString("COMPLETED_TASK") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag'   Width=20%>" & MyBase.GetResourceString("TO_BE_COMPLETED") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag'   Width=20%>" & MyBase.GetResourceString("SLIPPINGTASKS") & "</TH></THEAD>")

        CommonFunctions.General.WriteHTML("<TR class=clsTROdd>")
        CommonFunctions.General.WriteHTML("<TD align='left'      Width=20%><B>" & MyBase.GetResourceString("TASKS") & "</B></TD>")

        If m_intTotalPlnnedTasks <> 0 Then
            CommonFunctions.General.WriteHTML("<TD align='center'    Width=20%><a Href=""javascript:DetailsLink_onClick('TotalPlannedTasks')"">" & m_intTotalPlnnedTasks & "</A></TD>")
        Else
            CommonFunctions.General.WriteHTML("<TD align='center'    Width=20%>" & m_intTotalPlnnedTasks & "</TD>")
        End If
        If m_intCompletedTasks <> 0 Then
            CommonFunctions.General.WriteHTML("<TD align='center'    Width=20%><a Href=""javascript:DetailsLink_onClick('CompletedTasks')"">" & m_intCompletedTasks & "</A></TD>")
        Else
            CommonFunctions.General.WriteHTML("<TD align='center'    Width=20%>" & m_intCompletedTasks & "</TD>")
        End If
        If m_intTobeCompletedTasks <> 0 Then
            CommonFunctions.General.WriteHTML("<TD align='center'    Width=20%><a Href=""javascript:DetailsLink_onClick('TobeCompletedTasks')"">" & m_intTobeCompletedTasks & "</A></TD>")
        Else
            CommonFunctions.General.WriteHTML("<TD align='center'    Width=20%>" & m_intTobeCompletedTasks & "</TD>")
        End If
        If m_intSlippingTasks <> 0 Then
            CommonFunctions.General.WriteHTML("<TD align='center'    Width=20%><a Href=""javascript:DetailsLink_onClick('SLIPPINGTASKS')"">" & m_intSlippingTasks & "</A></TD></TR>")
        Else
            CommonFunctions.General.WriteHTML("<TD align='center'    Width=20%>" & m_intSlippingTasks & "</TD>")
        End If


        CommonFunctions.General.WriteHTML("<TR class=clsTREvenRow>")
        CommonFunctions.General.WriteHTML("<TD align='left'      Width=20%><B>" & MyBase.GetResourceString("DELIVERABLES") & "</B></TD>")
        If m_intTotalPlnnedDeliverables <> 0 Then
            CommonFunctions.General.WriteHTML("<TD align='center'    Width=20%><a Href=""javascript:DetailsLink_onClick('TotalPlannedDeliverables')"">" & m_intTotalPlnnedDeliverables & "</A></TD>")
        Else
            CommonFunctions.General.WriteHTML("<TD align='center'    Width=20%>" & m_intTotalPlnnedDeliverables & "</TD>")
        End If

        If m_intCompletedDeliverables <> 0 Then
            CommonFunctions.General.WriteHTML("<TD align='center'    Width=20%><a Href=""javascript:DetailsLink_onClick('CompletedDeliverables')"">" & m_intCompletedDeliverables & "</A></TD>")
        Else
            CommonFunctions.General.WriteHTML("<TD align='center'    Width=20%>" & m_intCompletedDeliverables & "</TD>")
        End If

        If m_intTobeCompletedDeliverables <> 0 Then
            CommonFunctions.General.WriteHTML("<TD align='center'    Width=20%><a Href=""javascript:DetailsLink_onClick('TobeCompletedDeliverables')"">" & m_intTobeCompletedDeliverables & "</A></TD>")
        Else
            CommonFunctions.General.WriteHTML("<TD align='center'    Width=20%>" & m_intTobeCompletedDeliverables & "</TD>")
        End If

        If m_intSlippingDeliverables <> 0 Then
            CommonFunctions.General.WriteHTML("<TD align='center'    Width=20%><a Href=""javascript:DetailsLink_onClick('SlippingDeliverables')"">" & m_intSlippingDeliverables & "</A></TD></TR>")
        Else
            CommonFunctions.General.WriteHTML("<TD align='center'    Width=20%>" & m_intSlippingDeliverables & "</TD>")
        End If
        CommonFunctions.General.WriteHTML("</TABLE>")
        ' End_MV_6/14/2007

        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
        ''Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'  colspan=3 Width=100%> <b>" & MyBase.GetResourceString("TITLE_KEYACHIVEMENTS") & "</b></td></TR>")
        'CommonFunctions.General.WriteHTML("<TR></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>" & MyBase.GetResourceString("TOTALTASKCOMP") & "</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='10%'> " & m_intCompletedTasks & "</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='20%'>")
        'CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('CompletedTasks')"">" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</a>")
        'CommonFunctions.General.WriteHTML("</td></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>" & MyBase.GetResourceString("TOTALDELIVERABLESCOMP") & "</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='10%'> " & m_intCompletedDeliverables & "</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='20%'>")
        'CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('CompletedDeliverables')"">" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</a>")
        'CommonFunctions.General.WriteHTML("</td></TR>")
        'CommonFunctions.General.WriteHTML("<TR></TR>")
        '' Modified By MahendraV On 2:16 PM 6/14/2007 for SP8 Performance
        '' Start_MV_6/14/2007
        'CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'  colspan=3 Width=100%> <b>Total Planned Tasks</b></td></TR>")
        'CommonFunctions.General.WriteHTML("<TR></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>Total plnned tasks</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='10%'> " & m_intTotalPlnnedTasks & "</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='20%'>")
        'CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('TotalPlannedTasks')"">View Details</a>")
        'CommonFunctions.General.WriteHTML("</td></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>Total planned deliverables</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='10%'> " & m_intTotalPlnnedDeliverables & "</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='20%'>")
        'CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('TotalPlannedDeliverables')"">View Details</a>")
        'CommonFunctions.General.WriteHTML("</td></TR>")
        'CommonFunctions.General.WriteHTML("<TR></TR>")
        '' End_MV_6/14/2007



        'CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'  colspan=3> <b>" & MyBase.GetResourceString("TITLE_SLIPPINGTASKS") & "</b></td></TR>")
        'CommonFunctions.General.WriteHTML("<TR></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'><FONT color='red'>" & MyBase.GetResourceString("SLIPPINGTASKS") & "</FONT></TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='10%'><FONT color='red'> " & m_intSlippingTasks & "</FONT></TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='20%'>")
        'CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('SLIPPINGTASKS')""><FONT color='red'>" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</FONT></a>")
        'CommonFunctions.General.WriteHTML("</td></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'><FONT color='red'>" & MyBase.GetResourceString("TOTALDELIVERABLESSLIPPING") & "</FONT></TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='10%'><FONT color='red'> " & m_intSlippingDeliverables & "</FONT></TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='20%'>")
        'CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('SlippingDeliverables')""><FONT color='red'>" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</FONT></a>")
        'CommonFunctions.General.WriteHTML("</td></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'  colspan=3> <b>" & MyBase.GetResourceString("TITLE_TARGETACHIVEMENTS") & "</b></td></TR>")
        'CommonFunctions.General.WriteHTML("<TR></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>" & MyBase.GetResourceString("TOTALTASKPENDING") & "</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='10%'> " & m_intTobeCompletedTasks & "</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='20%'>")
        'CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('TobeCompletedTasks')"">" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</a>")
        'CommonFunctions.General.WriteHTML("</td></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD width='70%'>" & MyBase.GetResourceString("TOTALDELIVERABLESPENDING") & "</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='10%'> " & m_intTobeCompletedDeliverables & "</TD>")
        'CommonFunctions.General.WriteHTML("<TD align=left width='20%'>")
        'CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('TobeCompletedDeliverables')"">" & MyBase.GetResourceString("LINK_VIEWDETAILS") & "</a>")
        'CommonFunctions.General.WriteHTML("</td></TR>")
        'CommonFunctions.General.WriteHTML("</TABLE>")
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
            'Commented & added by Viraj P on 18 Nov 2015 Purpose: To convert time format as well as Date Format
            '  m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',4," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & Format(CType(FormatDateTime(m_dtmReportingStartDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "','" & Format(CType(FormatDateTime(m_dtmReportingEndDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "',4," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & Format(CType(FormatDateTime(m_dtmReportingStartDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "','" & Format(CType(FormatDateTime(m_dtmReportingEndDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "',4," & CType(Session("intUserID"), String) & ",NULL"
        End If
        'Ended by Viraj P on 18 Nov 2015 Purpose: To convert time format as well as Date Format
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)


        ' Modified By MahendraV On 3:12 PM 6/19/2007 for SP8 Performance
        ' Start_MV_6/19/2007
        Dim blnIsDataPresent As Boolean = False
        ' End_MV_6/19/2007

        '
        ''Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='0' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
        ''Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TBODY>")
        'CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'  colspan=11 Width=100%> <b>" & MyBase.GetResourceString("TITLE_MILESTONE") & "</b></td></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
        'CommonFunctions.General.WriteHTML("<TD ALIGN='center' WIDTH=25%><B>" & MyBase.GetResourceString("MLNAME") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD ALIGN='center' WIDTH=5%><B>" & MyBase.GetResourceString("MISREADYFORBILLING") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD ALIGN='center' WIDTH=10%><B>" & MyBase.GetResourceString("MBILLAMOUNT") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD ALIGN='center' WIDTH=10%><B>" & MyBase.GetResourceString("MPLANNEDSTART") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD ALIGN='center' WIDTH=10%><B>" & MyBase.GetResourceString("MPLANNEDCOMPLETION") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD ALIGN='center' WIDTH=10%><B>" & MyBase.GetResourceString("MLASDATE") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD ALIGN='center' WIDTH=10%><B>" & MyBase.GetResourceString("MLAEDATE") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD ALIGN='center' WIDTH=5%><B>" & MyBase.GetResourceString("MSLIPPAGE") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD ALIGN='center' WIDTH=5%><B>" & MyBase.GetResourceString("MLSTATUS") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("</TR>")

        'If drSQERT.Read Then
        '    m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
        '    CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD colspan=11><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
        'Else
        '    CommonFunctions.General.WriteHTML("<TR class=clsTROdd><TD colspan=11 align='center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
        'End If

        'CommonFunctions.Data.DisposeDataReader(drSQERT)
        'drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        While drSQERT.Read
            ' Modified By MahendraV On 6:31 PM 6/19/2007 for SP8 Performance
            ' Start_MV_6/19/2007
            If blnIsDataPresent = False Then
                CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
                CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'  Width=100%> <b>" & MyBase.GetResourceString("TITLE_MILESTONE") & "</b></td></TR></TABLE>")
                CommonFunctions.General.WriteHTML("<div id='divList2' style='overflow:auto;height=220;Width:100%;'>")
                CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
                CommonFunctions.General.WriteHTML("<THEAD class=clsTRColumnHeader>")
                CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=25%>" & MyBase.GetResourceString("MLNAME") & "</TH>")
                CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=5%>" & MyBase.GetResourceString("MISREADYFORBILLING") & "</TH>")
                CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>" & MyBase.GetResourceString("MBILLAMOUNT") & "</TH>")
                CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>" & MyBase.GetResourceString("MPLANNEDSTART") & "</TH>")
                CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>" & MyBase.GetResourceString("MPLANNEDCOMPLETION") & "</TH>")
                CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>" & MyBase.GetResourceString("MLASDATE") & "</TH>")
                CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>" & MyBase.GetResourceString("MLAEDATE") & "</TH>")
                CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=5%>" & MyBase.GetResourceString("MSLIPPAGE") & "</TH>")
                CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=5%>" & MyBase.GetResourceString("MLSTATUS") & "</TH>")
                CommonFunctions.General.WriteHTML("</THEAD>")
            End If
            blnIsDataPresent = True
            ' End_MV_6/19/2007
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString <> m_strBaselineProjectName Then
                intCnt = 1
                m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
                CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD colspan=11><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
            Else
                intCnt = intCnt + 1
            End If

            If (intCnt Mod 2) = 0 Then
                m_strTRstyle = "clsTREvenRow"
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

        ' Modified By MahendraV On 3:12 PM 6/19/2007 for SP8 Performance
        ' Start_MV_6/19/2007
        If blnIsDataPresent = False Then
            CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
            CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'  Width=100%> <b>" & MyBase.GetResourceString("TITLE_MILESTONE") & "</b></td></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
            CommonFunctions.General.WriteHTML("<THEAD class=clsTRColumnHeader>")
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=25%>" & MyBase.GetResourceString("MLNAME") & "</TH>")
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=5%>" & MyBase.GetResourceString("MISREADYFORBILLING") & "</TH>")
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>" & MyBase.GetResourceString("MBILLAMOUNT") & "</TH>")
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>" & MyBase.GetResourceString("MPLANNEDSTART") & "</TH>")
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>" & MyBase.GetResourceString("MPLANNEDCOMPLETION") & "</TH>")
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>" & MyBase.GetResourceString("MLASDATE") & "</TH>")
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>" & MyBase.GetResourceString("MLAEDATE") & "</TH>")
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=5%>" & MyBase.GetResourceString("MSLIPPAGE") & "</TH>")
            CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=5%>" & MyBase.GetResourceString("MLSTATUS") & "</TH>")
            CommonFunctions.General.WriteHTML("</THEAD>")
            CommonFunctions.General.WriteHTML("<TR class=clsTROdd><TD colspan=11 align='center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")

        End If
        ' End_MV_6/19/2007
        CommonFunctions.Data.DisposeDataReader(drSQERT)
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
            'Commented & added by Viraj P on 18 Nov 2015 Purpose: To convert time format as well as Date Format
            ' m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod_Count " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & Format(CType(FormatDateTime(m_dtmReportingStartDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "','" & Format(CType(FormatDateTime(m_dtmReportingEndDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "',5," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & Format(CType(FormatDateTime(m_dtmReportingStartDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "','" & Format(CType(FormatDateTime(m_dtmReportingEndDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "',5," & CType(Session("intUserID"), String) & ",NULL"
        End If
        'Ended by Viraj P on 18 Nov 2015 Purpose: To convert time format as well as Date Format
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        ' Modified By MahendraV On 3:12 PM 6/19/2007 for SP8 Performance
        ' Start_MV_6/19/2007
        Dim blnIsDataPresent As Boolean = False

        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
        CommonFunctions.General.WriteHTML("<THEAD class=clsTRColumnHeader>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=60%>" & MyBase.GetResourceString("REASONFORCHANGE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=15%>" & MyBase.GetResourceString("CHANGEDDATE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=15%>" & MyBase.GetResourceString("ESTIMATEDEFFORT") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>" & MyBase.GetResourceString("EXPENDDATE") & "</TH>")
        CommonFunctions.General.WriteHTML("</THEAD>")
        ' End_MV_6/19/2007

        ''Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='0' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
        ''Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TBODY>")
        'CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'  colspan=4 Width=100%> <b>" & MyBase.GetResourceString("TITLE_BASELINE") & "</b></td></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
        'CommonFunctions.General.WriteHTML("<TD ALIGN='center' WIDTH=60%><B>" & MyBase.GetResourceString("REASONFORCHANGE") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD ALIGN='center' WIDTH=15%><B>" & MyBase.GetResourceString("CHANGEDDATE") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD ALIGN='center' WIDTH=15%><B>" & MyBase.GetResourceString("ESTIMATEDEFFORT") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD ALIGN='center' WIDTH=10%><B>" & MyBase.GetResourceString("EXPENDDATE") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("</TR>")

        'If drSQERT.Read Then
        '    m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
        '    m_strRemarks = CommonFunctions.Data.CheckIsDBNull(drSQERT("ReasonForRevision"), "").ToString
        '    'm_dtmChangedDate = CType(drSQERT("RevisionDate"), DateTime)
        '    'm_dtmExpectedEnddate = CType(drSQERT("ExpectedEnddate"), DateTime)

        '    CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD Colspan=4><b>Project : " & m_strBaselineProjectName & "</b></TD></TR>")
        '    '**CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD>" & m_strRemarks & "</TD>")
        '    CommonFunctions.General.WriteHTML("<TR class=clsTROdd><TD>" & m_strRemarks & "</TD>")

        '    If CommonFunctions.Data.CheckIsDBNull(drSQERT("RevisionDate"), "").ToString <> "" Then
        '        CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("RevisionDate"), "").ToString, Date)) & "</TD>")
        '    Else
        '        CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
        '    End If

        '    If CommonFunctions.Data.CheckIsDBNull(drSQERT("EstimatedEffort"), "").ToString <> "" Then
        '        CommonFunctions.General.WriteHTML("<TD>" & CType(drSQERT("EstimatedEffort"), Integer) & "</TD>")
        '    Else
        '        CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
        '    End If

        '    If CommonFunctions.Data.CheckIsDBNull(drSQERT("ExpectedEnddate"), "").ToString <> "" Then
        '        CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ExpectedEnddate"), "").ToString, Date)) & "</TD>")
        '    Else
        '        CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
        '    End If
        '    '**CommonFunctions.General.WriteHTML("</TR><TR class=clsTREven>")
        '    CommonFunctions.General.WriteHTML("</TR>")

        'Else
        '    CommonFunctions.General.WriteHTML("<TR class=clsTREvenRow><TD colspan=4 align='center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
        'End If

        While drSQERT.Read
            blnIsDataPresent = True
            'If CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString <> m_strBaselineProjectName Then
            '    m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
            '    '**CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader><TD Colspan=4><b>Project : " & m_strBaselineProjectName & "</B></TD></TR><TR class=clsTREven>")
            '    CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD Colspan=4><b>Project : " & m_strBaselineProjectName & "</B></TD></TR>")
            '    intcnt = 1
            'Else
            ' Modified By MahendraV On 10:34 AM 6/20/2007 for SP8 Performance
            ' Start_MV_6/20/2007
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString <> m_strBaselineProjectName Then
                m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
                CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD Colspan=4><b>Project : " & m_strBaselineProjectName & "</B></TD></TR>")
                intcnt = 1
            Else
                intcnt = intcnt + 1
            End If
            ' End_MV_6/20/2007

            If (intcnt Mod 2) = 0 Then
                m_strTRstyle = "clsTREvenRow"
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
        If blnIsDataPresent = False Then
            CommonFunctions.General.WriteHTML("<TR class=clsTREvenRow><TD colspan=4 align='center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
        End If
        CommonFunctions.Data.DisposeDataReader(drSQERT)

        'CommonFunctions.General.WriteHTML("</TBODY>")
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

        'If m_strProjectFilters <> "NULL" Then
        '    m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',2," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        'Else
        '    m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',2," & CType(Session("intUserID"), String) & ",NULL"
        'End If

        'drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        'If drSQERT.Read Then
        '    m_intScopeTrend = CType(drSQERT("ScopeTrend"), Integer)
        '    m_intQualityTrend = CType(drSQERT("QualityTrend"), Integer)
        '    m_intEffortTrend = CType(drSQERT("EffortTrend"), Integer)
        '    m_intRiskTrend = CType(drSQERT("RiskTrend"), Integer)
        '    m_intTimeTrend = CType(drSQERT("TimeTrend"), Integer)
        'End If
        'CommonFunctions.Data.DisposeDataReader(drSQERT)

        'If m_strProjectFilters <> "NULL" Then
        '    m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',1," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        'Else
        '    m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',1," & CType(Session("intUserID"), String) & ",NULL"
        'End If

        'drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        'While drSQERT.Read
        '    m_intRecordCount = m_intRecordCount + 1
        'End While
        'CommonFunctions.Data.DisposeDataReader(drSQERT)

        'If m_strProjectFilters <> "NULL" Then
        '    m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',3," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        'Else
        '    m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',3," & CType(Session("intUserID"), String) & ",NULL"
        'End If

        'drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        'If drSQERT.Read Then
        '    m_intRecordCnt = 1
        'End If
        'CommonFunctions.Data.DisposeDataReader(drSQERT)

        'If m_strProjectFilters <> "NULL" Then
        '    m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',0," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        'Else
        '    m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',0," & CType(Session("intUserID"), String) & ",NULL"
        'End If
        ' Modified By MahendraV On 2:16 PM 6/14/2007 for SP8 Performance
        ' Start_MV_6/14/2007
        If m_strProjectFilters <> "NULL" Then
            'Commented & added by Viraj P on 18 Nov 2015 Purpose: To convert time format as well as Date Format
            'm_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',0," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'," & CType(Session("LoginType"), String)
            m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & Format(CType(FormatDateTime(m_dtmReportingStartDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "','" & Format(CType(FormatDateTime(m_dtmReportingEndDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "',0," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'," & CType(Session("LoginType"), String)
        Else
            m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & Format(CType(FormatDateTime(m_dtmReportingStartDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "','" & Format(CType(FormatDateTime(m_dtmReportingEndDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "',0," & CType(Session("intUserID"), String) & ",NULL," & CType(Session("LoginType"), String)
        End If
        'Ended by Viraj P on 18 Nov 2015 Purpose: To convert time format as well as Date Format
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        Dim intFlag As Integer = 0
        Dim m_intScope As Integer
        Dim m_intQuality As Integer
        Dim m_intEffort As Integer
        Dim m_intRisk As Integer
        Dim m_intTime As Integer
        Dim m_strScopeDesc As String
        Dim m_strQualityDesc As String
        Dim m_strEffortDesc As String
        Dim m_strRiskDesc As String
        Dim m_strTimeDesc As String
        Dim m_intTaskSQERT As Integer = 0

        Do
            Select Case intFlag
                Case 0
                    If m_strProjectId <> "" Then
                        If drSQERT.Read() Then
                            m_intTaskSQERT = m_intTaskSQERT + 1
                            If CommonFunctions.Data.CheckIsDBNull(drSQERT("Scope"), "").ToString() <> "" Then
                                m_intScope = CType(drSQERT("Scope"), Integer)
                            End If
                            If CommonFunctions.Data.CheckIsDBNull(drSQERT("Quality"), "").ToString() <> "" Then
                                m_intQuality = CType(drSQERT("Quality"), Integer)
                            End If
                            If CommonFunctions.Data.CheckIsDBNull(drSQERT("Effort"), "").ToString() <> "" Then
                                m_intEffort = CType(drSQERT("Effort"), Integer)
                            End If
                            If CommonFunctions.Data.CheckIsDBNull(drSQERT("Risk"), "").ToString() <> "" Then
                                m_intRisk = CType(drSQERT("Risk"), Integer)
                            End If
                            If CommonFunctions.Data.CheckIsDBNull(drSQERT("Time"), "").ToString() <> "" Then
                                m_intTime = CType(drSQERT("Time"), Integer)
                            End If

                            m_strScopeDesc = CommonFunctions.Data.CheckIsDBNull(drSQERT("ScopeDesc"), "").ToString()
                            m_strQualityDesc = CommonFunctions.Data.CheckIsDBNull(drSQERT("QualityDesc"), "").ToString()
                            m_strEffortDesc = CommonFunctions.Data.CheckIsDBNull(drSQERT("EffortDesc"), "").ToString()
                            m_strRiskDesc = CommonFunctions.Data.CheckIsDBNull(drSQERT("RiskDesc"), "").ToString()
                            m_strTimeDesc = CommonFunctions.Data.CheckIsDBNull(drSQERT("TimeDesc"), "").ToString()
                        End If
                    End If
                Case 1
                    While drSQERT.Read()
                        m_intRecordCount = m_intRecordCount + 1
                    End While

                Case 2
                    If drSQERT.Read Then
                        If CommonFunctions.Data.CheckIsDBNull(drSQERT("ScopeTrend"), "").ToString() <> "" Then
                            m_intScopeTrend = CType(drSQERT("ScopeTrend"), Integer)
                        End If
                        If CommonFunctions.Data.CheckIsDBNull(drSQERT("QualityTrend"), "").ToString() <> "" Then
                            m_intQualityTrend = CType(drSQERT("QualityTrend"), Integer)
                        End If
                        If CommonFunctions.Data.CheckIsDBNull(drSQERT("EffortTrend"), "").ToString() <> "" Then
                            m_intEffortTrend = CType(drSQERT("EffortTrend"), Integer)
                        End If
                        If CommonFunctions.Data.CheckIsDBNull(drSQERT("RiskTrend"), "").ToString() <> "" Then
                            m_intRiskTrend = CType(drSQERT("RiskTrend"), Integer)
                        End If
                        If CommonFunctions.Data.CheckIsDBNull(drSQERT("TimeTrend"), "").ToString() <> "" Then
                            m_intTimeTrend = CType(drSQERT("TimeTrend"), Integer)
                        End If

                    End If
                Case 3
                    If drSQERT.Read Then
                        m_intRecordCnt = 1
                    End If
            End Select
            intFlag = intFlag + 1
        Loop While drSQERT.NextResult()
        CommonFunctions.Data.DisposeDataReader(drSQERT)


        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'  Width=100%>")
        If (m_intRecordCount > 1 Or m_intRecordCnt > 0) Then
            CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('SQERT')"">")
        End If
        CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("TITLE_SQERT") & "</B></TD></A></TR></TABLE>")

        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
        CommonFunctions.General.WriteHTML("<THEAD class=clsTRColumnHeader>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=7%>" & MyBase.GetResourceString("SQERT_TITLE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=5%>" & MyBase.GetResourceString("SQERT_VALUE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=5%>" & MyBase.GetResourceString("SQERT_RATING") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=5%>" & MyBase.GetResourceString("SQERT_TREND") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=78%>" & MyBase.GetResourceString("SQERT_DESCRIPTION") & "</TH>")
        CommonFunctions.General.WriteHTML("</THEAD>")

        ' End_MV_6/14/2007



        ''Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
        ''Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TBODY>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'  colspan=5 Width=100%>")
        'If (m_intRecordCount > 1 Or m_intRecordCnt > 0) Then
        '    CommonFunctions.General.WriteHTML("<a Href=""javascript:DetailsLink_onClick('SQERT')"">")
        'End If
        'CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("TITLE_SQERT") & "</b></td></a></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTREven>")
        'CommonFunctions.General.WriteHTML("<TD ALIGN='center' WIDTH=7%><B>" & MyBase.GetResourceString("SQERT_TITLE") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD ALIGN='center' WIDTH=5%><B>" & MyBase.GetResourceString("SQERT_VALUE") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD ALIGN='center' WIDTH=5%><B>" & MyBase.GetResourceString("SQERT_RATING") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD ALIGN='center' WIDTH=5%><B>" & MyBase.GetResourceString("SQERT_TREND") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("<TD ALIGN='center' WIDTH=78%><B>" & MyBase.GetResourceString("SQERT_DESCRIPTION") & "</B></TD>")
        'CommonFunctions.General.WriteHTML("</TR>")

        If m_strProjectId <> "" Then
            ' Commented and modified By MahendraV On 2:16 PM 6/14/2007 for SP8 Performance
            ' Start_MV_6/14/2007
            ' drTask getting the value of SQERT (Scope,Quality,Effort,Risk,Time) and use it.
            ' Now SQERT value comming from drSQERT and collected into the variable
            ' m_intScope ,m_intQuality,m_intEffort,m_intRisk and m_intTime.
            ' drTask = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            'If Not drTask.Read Then
            'CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD colspan=5 align='center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")

            ' End_MV_6/14/2007 
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'm_strSQL = "select * from tbl_PRS_SQERT_Ranges ORDER BY SQERT_Order"
            m_strSQL = "usp_sel_SQERT_tbl_PRS_SQERT_Ranges"
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

            If m_intTaskSQERT = 0 Then
                CommonFunctions.General.WriteHTML("<TR class=clsTROdd><TD colspan=5 align='center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
            Else
                If m_intRecordCount > 0 Then
                    '===================== SCOPE ===========================
                    CommonFunctions.General.WriteHTML("<TR class=clsTROdd>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='left'>" & MyBase.GetResourceString("SCOPE") & "</TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='center'>" & CType(m_intScope, Integer) & " </TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
                    If drSQERT.Read Then
                        'If CType(drTask("Scope"), Integer) >= CType(drSQERT("Lower_Low"), Integer) And CType(drTask("Scope"), Integer) <= CType(drSQERT("Lower_High"), Integer) Then
                        If m_intScope >= CType(drSQERT("Lower_Low"), Integer) And m_intScope <= CType(drSQERT("Lower_High"), Integer) Then
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                            'ElseIf CType(drTask("Scope"), Integer) >= CType(drSQERT("Middle_Low"), Integer) And CType(drTask("Scope"), Integer) <= CType(drSQERT("Middle_High"), Integer) Then
                        ElseIf m_intScope >= CType(drSQERT("Middle_Low"), Integer) And m_intScope <= CType(drSQERT("Middle_High"), Integer) Then
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                            ' ElseIf CType(drTask("Scope"), Integer) >= CType(drSQERT("Upper_Low"), Integer) And CType(drTask("Scope"), Integer) <= CType(drSQERT("Upper_High"), Integer) Then
                        ElseIf m_intScope >= CType(drSQERT("Upper_Low"), Integer) And m_intScope <= CType(drSQERT("Upper_High"), Integer) Then
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                        End If
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
                    If m_intScopeTrend = 1 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/up_arrow.jpg' border='0' align='center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intScopeTrend = 2 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/both_arrow.jpg' border='0' align='center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intScopeTrend = 3 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/down_arrow.jpg' border='0' align='center' WIDTH='20' HEIGHT='20'>")
                    Else
                        CommonFunctions.General.WriteHTML("<b>NA<b>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='left'>" & m_strScopeDesc & "</TD></TR>")
                    '===================== END OF SCOPE ===========================

                    '===================== QUALITY ===========================
                    CommonFunctions.General.WriteHTML("<TR class=clsTREvenRow>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='left'>" & MyBase.GetResourceString("QUALITY") & "</TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='center'>" & CType(m_intQuality, Integer) & " </TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
                    If drSQERT.Read Then
                        'If CType(drTask("Quality"), Integer) >= CType(drSQERT("Lower_Low"), Integer) And CType(drTask("Quality"), Integer) <= CType(drSQERT("Lower_High"), Integer) Then
                        If m_intQuality >= CType(drSQERT("Lower_Low"), Integer) And m_intQuality <= CType(drSQERT("Lower_High"), Integer) Then

                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            'Modified & Commented By VarunA on 5-Mar-2008 RequestID-11651
                            'CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                            'End By VarunA on 5-Mar-2008
                            'ElseIf CType(drTask("Quality"), Integer) >= CType(drSQERT("Middle_Low"), Integer) And CType(drTask("Quality"), Integer) <= CType(drSQERT("Middle_High"), Integer) Then
                        ElseIf m_intQuality >= CType(drSQERT("Middle_Low"), Integer) And m_intQuality <= CType(drSQERT("Middle_High"), Integer) Then
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                            'ElseIf CType(drTask("Quality"), Integer) >= CType(drSQERT("Upper_Low"), Integer) And CType(drTask("Quality"), Integer) <= CType(drSQERT("Upper_High"), Integer) Then
                        ElseIf m_intQuality >= CType(drSQERT("Upper_Low"), Integer) And m_intQuality <= CType(drSQERT("Upper_High"), Integer) Then
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                            'Modified & Commented By VarunA on 5-Mar-2008 RequestID-11651
                            'CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                            'End By VarunA on 5-Mar-2008
                        End If
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
                    If m_intQualityTrend = 1 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/up_arrow.jpg' border='0' align='center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intQualityTrend = 2 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/both_arrow.jpg' border='0' align='center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intQualityTrend = 3 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/down_arrow.jpg' border='0' align='center' WIDTH='20' HEIGHT='20'>")
                    Else
                        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("SQERT_NA") & "<b>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='left'>" & m_strQualityDesc & "</TD></TR>")
                    '===================== END OF QUALITY ===========================

                    '===================== EFFORT ===========================
                    CommonFunctions.General.WriteHTML("<TR class=clsTROdd>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='left'>" & MyBase.GetResourceString("EFFORT") & "</TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='center'>" & CType(m_intEffort, Integer) & " </TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
                    If drSQERT.Read Then
                        'If CType(drTask("Effort"), Integer) >= CType(drSQERT("Lower_Low"), Integer) And CType(drTask("Effort"), Integer) <= CType(drSQERT("Lower_High"), Integer) Then
                        If m_intEffort >= CType(drSQERT("Lower_Low"), Integer) And m_intEffort <= CType(drSQERT("Lower_High"), Integer) Then
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                            'ElseIf CType(drTask("Effort"), Integer) >= CType(drSQERT("Middle_Low"), Integer) And CType(drTask("Effort"), Integer) <= CType(drSQERT("Middle_High"), Integer) Then
                        ElseIf m_intEffort >= CType(drSQERT("Middle_Low"), Integer) And m_intEffort <= CType(drSQERT("Middle_High"), Integer) Then
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                            'ElseIf CType(drTask("Effort"), Integer) >= CType(drSQERT("Upper_Low"), Integer) And CType(drTask("Effort"), Integer) <= CType(drSQERT("Upper_High"), Integer) Then
                        ElseIf m_intEffort >= CType(drSQERT("Upper_Low"), Integer) And m_intEffort <= CType(drSQERT("Upper_High"), Integer) Then
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                        End If
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
                    If m_intEffortTrend = 1 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/up_arrow.jpg' border='0' align='center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intEffortTrend = 2 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/both_arrow.jpg' border='0' align='center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intEffortTrend = 3 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/down_arrow.jpg' border='0' align='center' WIDTH='20' HEIGHT='20'>")
                    Else
                        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("SQERT_NA") & "<b>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='left'>" & m_strEffortDesc & "</TD></TR>")

                    '===================== END OF EFFORT ===========================

                    '===================== RISK ===========================

                    CommonFunctions.General.WriteHTML("<TR class=clsTREvenRow>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='left'><a Href=""javascript:DetailsLink_onClick('Risk')""> " & MyBase.GetResourceString("RISK") & " </a></TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='center'>" & CType(m_intRisk, Integer) & " </TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
                    If drSQERT.Read Then
                        'If CType(drTask("Risk"), Integer) >= CType(drSQERT("Lower_Low"), Integer) And CType(drTask("Risk"), Integer) <= CType(drSQERT("Lower_High"), Integer) Then
                        If m_intRisk >= CType(drSQERT("Lower_Low"), Integer) And m_intRisk <= CType(drSQERT("Lower_High"), Integer) Then

                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                            'ElseIf CType(drTask("Risk"), Integer) >= CType(drSQERT("Middle_Low"), Integer) And CType(drTask("Risk"), Integer) <= CType(drSQERT("Middle_High"), Integer) Then
                        ElseIf m_intRisk >= CType(drSQERT("Middle_Low"), Integer) And m_intRisk <= CType(drSQERT("Middle_High"), Integer) Then
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            'Modified & Commented By VarunA on 5-Mar-2008 RequestID-11651
                            'CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                            'End By VarunA on 5-Mar-2008
                            'ElseIf CType(drTask("Risk"), Integer) >= CType(drSQERT("Upper_Low"), Integer) And CType(drTask("Risk"), Integer) <= CType(drSQERT("Upper_High"), Integer) Then
                        ElseIf m_intRisk >= CType(drSQERT("Upper_Low"), Integer) And m_intRisk <= CType(drSQERT("Upper_High"), Integer) Then
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            'Modified & Commented By VarunA on 5-Mar-2008 RequestID-11651
                            'CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                            'End By VarunA on 5-Mar-2008
                        End If
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
                    If m_intRiskTrend = 1 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/up_arrow.jpg' border='0' align='center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intRiskTrend = 2 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/both_arrow.jpg' border='0' align='center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intRiskTrend = 3 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/down_arrow.jpg' border='0' align='center' WIDTH='20' HEIGHT='20'>")
                    Else
                        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("SQERT_NA") & "<b>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='left'>" & m_strRiskDesc & "</TD></TR>")

                    '===================== END OF RISK ===========================

                    '===================== TIME ===========================

                    CommonFunctions.General.WriteHTML("<TR class=clsTROdd>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='left'>" & MyBase.GetResourceString("TIME") & "</TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='center'>" & CType(m_intTime, Integer) & " </TD>")
                    CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
                    If drSQERT.Read Then
                        'If CType(drTask("Time"), Integer) >= CType(drSQERT("Lower_Low"), Integer) And CType(drTask("Time"), Integer) <= CType(drSQERT("Lower_High"), Integer) Then
                        If m_intTime >= CType(drSQERT("Lower_Low"), Integer) And m_intTime <= CType(drSQERT("Lower_High"), Integer) Then
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                            'ElseIf CType(drTask("Time"), Integer) >= CType(drSQERT("Middle_Low"), Integer) And CType(drTask("Time"), Integer) <= CType(drSQERT("Middle_High"), Integer) Then
                        ElseIf m_intTime >= CType(drSQERT("Middle_Low"), Integer) And m_intTime <= CType(drSQERT("Middle_High"), Integer) Then
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                            'ElseIf CType(drTask("Time"), Integer) >= CType(drSQERT("Upper_Low"), Integer) And CType(drTask("Time"), Integer) <= CType(drSQERT("Upper_High"), Integer) Then
                        ElseIf m_intTime >= CType(drSQERT("Upper_Low"), Integer) And m_intTime <= CType(drSQERT("Upper_High"), Integer) Then
                            'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                            'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                            CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                        End If
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
                    If m_intTimeTrend = 1 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/up_arrow.jpg' border='0' align='center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intTimeTrend = 2 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/both_arrow.jpg' border='0' align='center' WIDTH='20' HEIGHT='20'>")
                    ElseIf m_intTimeTrend = 3 Then
                        CommonFunctions.General.WriteHTML("<img src='../../images/down_arrow.jpg' border='0' align='center' WIDTH='20' HEIGHT='20'>")
                    Else
                        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("SQERT_NA") & "<b>")
                    End If
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunctions.General.WriteHTML("<TD ALIGN='left'>" & m_strTimeDesc & "</TD></TR>")

                    '===================== END OF TIME ===========================
                Else
                    CommonFunctions.General.WriteHTML("<TR class=clsTROdd><TD colspan=5 align='center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
                End If
            End If
        Else
            CommonFunctions.General.WriteHTML("<TR class=clsTREvenRow><TD colspan=5 align='center'>" & MyBase.GetResourceString("SQERTNAMESSAGE") & "</TD></TR>")
        End If
        'CommonFunctions.Data.DisposeDataReader(drTask)
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
        ' Added by MahendraV On 12:09 PM 6/18/2007 To change format to displaying issue details
        ' Start_MV_6/18/2007
        Dim strIssuetype As String = ""
        If Request.QueryString("Issuetype") <> "" And Request.QueryString("Issuetype") <> Nothing Then
            strIssuetype = Request.QueryString("Issuetype")
            strIssuetype = strIssuetype.Replace(Chr(39), "''")

        End If
        ' End_MV_6/18/2007
        m_strFlag = CType(Request.QueryString("blnFlag"), Integer)

        'm_strTitle = MyBase.GetResourceString("TITLE_ISSUES")
        m_strTitle = "Issues Details (<TYPE>)"
        'If m_strFlag = 1 Then
        '    m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("TOTAL"))
        'ElseIf m_strFlag = 2 Then
        '    m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("OPEN"))
        'ElseIf m_strFlag = 3 Then
        '    m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("CLOSE"))
        'ElseIf m_strFlag = 4 Then
        '    m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("OVERDUE"))
        ' Added by MahendraV On 2:12 PM 6/21/2007 To Issue Detail Title
        ' Start_MV_ 6/21/2007
        If m_strFlag = 1 Or m_strFlag = 19 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("TOTAL"))
        ElseIf m_strFlag = 2 Or m_strFlag = 16 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("OPEN"))
        ElseIf m_strFlag = 3 Or m_strFlag = 17 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("CLOSE"))
        ElseIf m_strFlag = 4 Or m_strFlag = 24 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("OVERDUE"))

        ElseIf m_strFlag = 5 Or m_strFlag = 23 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("SHOWN_TO_CUSTOMER"))
        ElseIf m_strFlag = 6 Or m_strFlag = 18 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("OTHERS_ISSUE"))
        ElseIf m_strFlag = 7 Or m_strFlag = 20 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("UPTO5DAYSISSUE"))
        ElseIf m_strFlag = 8 Or m_strFlag = 21 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("5TO10DAYSISSUE"))
        ElseIf m_strFlag = 9 Or m_strFlag = 22 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("MORETHEN10DAYSISSUE"))
            ' End_MV_ 6/21/2007
        End If





        m_strTitle = m_strTitle.Replace("<TODATE>", CommonFunction.Dates.GetDate(CType(m_dtmReportingEndDate, Date)).ToString)

        intCnt = 0

        If m_strProjectFilters <> "NULL" Then
            m_strSQL = "Exec USP_RPT_GetOpenAndClosedIssuesTypes " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        Else
            m_strSQL = "Exec USP_RPT_GetOpenAndClosedIssuesTypes " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",NULL"
        End If
        ' Added by MahendraV On 12:09 PM 6/18/2007 To change format to displaying issue details
        ' Start_MV_6/18/2007
        If strIssuetype <> "" Then
            m_strSQL = m_strSQL & ",'" & strIssuetype & "'"
        End If
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)


        CommonFunctions.General.WriteHTML("<div id='divList2' style='overflow:auto;height=400;Width:100%;'>")
        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'  colspan=10 Width=100%> <b>" & m_strTitle & "</b></td></TR></TABLE>")

        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
        CommonFunctions.General.WriteHTML("<THEAD class=clsTRColumnHeader>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=5%>" & MyBase.GetResourceString("SRNO") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=5%>" & MyBase.GetResourceString("ISSUEID") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=25%>" & MyBase.GetResourceString("SUMMARY") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=5%>" & MyBase.GetResourceString("REPDATE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=15%>" & MyBase.GetResourceString("ISSUETYPE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=10%>" & MyBase.GetResourceString("SUBTYPE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=5%>" & MyBase.GetResourceString("PRIORITY") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=5%>" & MyBase.GetResourceString("SEVERITY") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=10%>" & MyBase.GetResourceString("STATUS") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=10%>" & MyBase.GetResourceString("DUEDATE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=15%>" & MyBase.GetResourceString("REPORTEDBY") & "</TH>")
        CommonFunctions.General.WriteHTML("</THEAD>")
        Dim blnIsDataPresent As Boolean = False
        ' End_MV_6/18/2007


        'CommonFunctions.General.WriteHTML("<div id='divList2' style='overflow:auto;height=400;Width:100%;'>")
        ''Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
        ''Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TBODY>")
        'CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'  colspan=10 Width=100%> <b>" & m_strTitle & "</b></td></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=5%>" & MyBase.GetResourceString("SRNO") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=5%>" & MyBase.GetResourceString("ISSUEID") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=25%>" & MyBase.GetResourceString("SUMMARY") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=5%>" & MyBase.GetResourceString("REPDATE") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=15%>" & MyBase.GetResourceString("ISSUETYPE") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=10%>" & MyBase.GetResourceString("SUBTYPE") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=5%>" & MyBase.GetResourceString("PRIORITY") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=5%>" & MyBase.GetResourceString("SEVERITY") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=10%>" & MyBase.GetResourceString("DUEDATE") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=15%>" & MyBase.GetResourceString("REPORTEDBY") & "</td>")
        'CommonFunctions.General.WriteHTML("</TR>")

        'If drSQERT.Read Then
        '    m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
        '    CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD Colspan=10><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
        'Else
        '    CommonFunctions.General.WriteHTML("<TR class=clsTROdd><TD colspan=10 align='center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
        'End If

        'CommonFunctions.Data.DisposeDataReader(drSQERT)
        'drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        While drSQERT.Read
            blnIsDataPresent = True
            'If CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString <> m_strBaselineProjectName Then
            '    intCnt = 1
            '    m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
            '    CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader><TD Colspan=10><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
            'Else
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString <> m_strBaselineProjectName Then
                intCnt = 1
                m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
                CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD Colspan=11><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
            Else
                intCnt = intCnt + 1
            End If

            If (intCnt Mod 2) = 0 Then
                m_strTRstyle = "clsTREvenRow"
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
            ' Added by MahendraV On 4:34 PM 6/21/2007 To add new field 'Status'
            ' Start_MV_6/21/2007
            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("Status"), "").ToString & "</TD>")
            ' End_MV_6/21/2007
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("DueDate"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("DueDate"), "").ToString, Date)) & "</TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
            End If
            CommonFunctions.General.WriteHTML("<TD>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("reportedBy"), "").ToString & "</TD></TR>")
        End While
        If blnIsDataPresent = False Then
            CommonFunctions.General.WriteHTML("<TR class=clsTROdd><TD colspan=10 align='center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
        End If
        CommonFunctions.Data.DisposeDataReader(drSQERT)

        'CommonFunctions.General.WriteHTML("</TBODY>")
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
            ' Modified By MahendraV On 5:23 PM 6/15/2007 To displayed total planned tasks
            ' Start_MV_6/15/2007
        ElseIf m_strFlag = 14 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("TOTALPLANNED"))
            m_strTitle = m_strTitle.Replace("<TODATE>", CommonFunction.Dates.GetDate(CType(m_dtmReportingEndDate, Date)).ToString)
            m_strTitle = m_strTitle.Replace("<FROMDATE>", CommonFunction.Dates.GetDate(CType(m_dtmReportingStartDate, Date)).ToString)
            If m_strProjectFilters <> "NULL" Then
                m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
            Else
                m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",NULL"
            End If

        End If
        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        CommonFunctions.General.WriteHTML("<div id='divList2' style='overflow:auto;height=400;Width:100%;'>")
        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'  colspan=10 Width=100%> <b>" & m_strTitle & "</b></td></TR></TABLE>")

        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
        CommonFunctions.General.WriteHTML("<THEAD class=clsTRColumnHeader>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=5%>" & MyBase.GetResourceString("SRNO") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=20%>" & MyBase.GetResourceString("TASKNAME") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=10%>" & MyBase.GetResourceString("RESOURCENAME") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=10%>" & MyBase.GetResourceString("EXPSTARTDATE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=10%>" & MyBase.GetResourceString("EXPENDDATE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=10%>" & MyBase.GetResourceString("MLASDATE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=10%>" & MyBase.GetResourceString("MLAEDATE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=10%>" & MyBase.GetResourceString("BASELINE_START_DATE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=10%>" & MyBase.GetResourceString("BASELINE_END_DATE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=10%>" & MyBase.GetResourceString("WORKHRS") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=10%>" & MyBase.GetResourceString("ACTUALWORKHRS") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=10%>" & MyBase.GetResourceString("BASELINE_WORKS") & "</TH>")
        CommonFunctions.General.WriteHTML("</THEAD>")
        Dim blnIsDataPresent As Boolean = False
        ' End_MV_6/15/2007
        intCnt = 0



        'CommonFunctions.General.WriteHTML("<div id='divList2' style='overflow:auto;height=400;Width:100%;'>")
        ''Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
        ''Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TBODY>")
        'CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'  colspan=10 Width=100%> <b>" & m_strTitle & "</b></td></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=5%>" & MyBase.GetResourceString("SRNO") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=30%>" & MyBase.GetResourceString("TASKNAME") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=10%>" & MyBase.GetResourceString("RESOURCENAME") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=15%>" & MyBase.GetResourceString("EXPSTARTDATE") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=15%>" & MyBase.GetResourceString("EXPENDDATE") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=15%>" & MyBase.GetResourceString("MLASDATE") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=15%>" & MyBase.GetResourceString("MLAEDATE") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=10%>" & MyBase.GetResourceString("WORKHRS") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=10%>" & MyBase.GetResourceString("ACTUALWORKHRS") & "</td>")
        'CommonFunctions.General.WriteHTML("</TR>")

        'If drSQERT.Read Then
        '    m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
        '    CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader><TD Colspan=10><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
        'Else
        '    CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD colspan=10 align='center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
        'End If

        'CommonFunctions.Data.DisposeDataReader(drSQERT)
        'drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        While drSQERT.Read
            blnIsDataPresent = True
            'If CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString <> m_strBaselineProjectName Then
            '    intCnt = 1
            '    m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
            '    CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader><TD Colspan=10><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
            'Else
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString <> m_strBaselineProjectName Then
                intCnt = 1
                m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
                CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD Colspan=12><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
            Else
                intCnt = intCnt + 1
            End If

            If (intCnt Mod 2) = 0 Then
                m_strTRstyle = "clsTREvenRow"
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
                ' Modified By MahendraV On 5:49 PM 7/19/2007 For WhizibleSEM 7
                ' To Round the work and actual work for 2 digit' 
                ' Start_MV_ 7/19/2007
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("BaselineStart"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD><FONT Color = 'RED'>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("BaselineStart"), "").ToString, Date)) & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("BaselineEnd"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD><FONT Color = 'RED'>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("BaselineEnd"), "").ToString, Date)) & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If

                'CommonFunctions.General.WriteHTML("<TD align = 'right'><FONT Color = 'RED'>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("work"), "").ToString() & "</FONT></TD>")
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("work"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD align = 'right'><FONT Color = 'RED'>" & (Decimal.Round(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("work"), ""), Decimal), 2)).ToString() & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD align = 'right'>0</TD>")
                End If

                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualWork"), "").ToString <> "" Then
                    'CommonFunctions.General.WriteHTML("<TD align = 'right'><FONT Color = 'RED'>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualWork"), "").ToString & "</FONT></TD>")
                    CommonFunctions.General.WriteHTML("<TD align = 'right'><FONT Color = 'RED'>" & (Decimal.Round(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualWork"), ""), Decimal), 2)).ToString & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD align = 'right'>0</TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("BaselineWork"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD align = 'right'><FONT Color = 'RED'>" & (Decimal.Round(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("BaselineWork"), ""), Decimal), 2)).ToString() & "</FONT></TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD align = 'right'>0</TD>")
                End If
                ' End_MV_ 7/19/2007
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
                ' Modified By MahendraV On 5:49 PM 7/19/2007 For WhizibleSEM 7
                ' To Round the work and actual work for 2 digit' 
                ' Start_MV_ 7/19/2007
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("BaselineStart"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("BaselineStart"), "").ToString, Date)) & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("BaselineEnd"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD>" & CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("BaselineEnd"), "").ToString, Date)) & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
                End If
                ' End_MV_ 7/19/2007
                ' Modified By MahendraV On 5:49 PM 7/19/2007 For WhizibleSEM 7
                ' To Round the work and actual work for 2 digit' 
                ' Start_MV_ 7/19/2007
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualWork"), "").ToString <> "" Then
                    'CommonFunctions.General.WriteHTML("<TD align = 'right'>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("work"), "").ToString & "</TD>")
                    CommonFunctions.General.WriteHTML("<TD align = 'right'>" & (Decimal.Round(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("work"), ""), Decimal), 2)).ToString & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD align = 'right'>0</TD>")
                End If


                If CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualWork"), "").ToString <> "" Then
                    'CommonFunctions.General.WriteHTML("<TD align = 'right'>" & CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualWork"), "").ToString & "</TD>")
                    CommonFunctions.General.WriteHTML("<TD align = 'right'>" & (Decimal.Round(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("ActualWork"), ""), Decimal), 2)).ToString & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD align = 'right'>0</TD>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(drSQERT("BaselineWork"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<TD align = 'right'>" & (Decimal.Round(CType(CommonFunctions.Data.CheckIsDBNull(drSQERT("BaselineWork"), ""), Decimal), 2)).ToString() & "</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD align = 'right'>0</TD>")
                End If
                ' End_MV_ 7/19/2007
            End If

        End While
        If blnIsDataPresent = False Then
            CommonFunctions.General.WriteHTML("<TR class=clsTROdd><TD colspan=10 align='center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
        End If
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
        ' Modified By MahendraV On 12:35 PM 6/21/2007 To displayed total planned tasks
        ' Start_MV_6/21/2007
        ' Commented  by Viraj P on 16 Nov 2015
        ' CommonFunctions.General.WriteHTML("<DIV ID='DIVLIST' STYLE='overflow:auto;width:100%;height=410px'>")
        CommonFunctions.General.WriteHTML("<DIV ID='DIVLIST' STYLE='overflow:auto;width:100%;'>")
        'End of Comment  by Viraj P on 16 Nov 2015
        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><td align=left width=100% Colspan=8><b>" & MyBase.GetResourceString("TITLE_RISKDETAILS") & CommonFunctions.Dates.GetDate(CType(m_dtmReportingEndDate, Date)) & "</b></td><tr></TABLE>")

        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
        CommonFunctions.General.WriteHTML("<THEAD class=clsTRColumnHeader>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=30%>" & MyBase.GetResourceString("RISK") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=15%>" & MyBase.GetResourceString("IDENTIFIEDDATE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=15%>" & MyBase.GetResourceString("MITIGATIONDATE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=7%>" & MyBase.GetResourceString("PROBABILITY") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=7%>" & MyBase.GetResourceString("IMPACT") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=8%>" & MyBase.GetResourceString("SEVERITY") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=7%>" & MyBase.GetResourceString("RATING") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=7%>" & MyBase.GetResourceString("PERSONRESPONSIBLE") & "</TH></THEAD>")

        ' End_MV_6/21/2007
        'CommonFunctions.General.WriteHTML("<DIV ID='DIVLIST' STYLE='overflow:auto;width:100%;height=410px'>")
        ''Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
        ''Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TBODY>")
        'CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><td align=left width=100% Colspan=8><b>" & MyBase.GetResourceString("TITLE_RISKDETAILS") & CommonFunctions.Dates.GetDate(CType(m_dtmReportingEndDate, Date)) & "</b></td><tr>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRColumnHeader>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=30%>" & MyBase.GetResourceString("RISK") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=15%>" & MyBase.GetResourceString("IDENTIFIEDDATE") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=15%>" & MyBase.GetResourceString("MITIGATIONDATE") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=7%>" & MyBase.GetResourceString("PROBABILITY") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=7%>" & MyBase.GetResourceString("IMPACT") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=8%>" & MyBase.GetResourceString("SEVERITY") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=7%>" & MyBase.GetResourceString("RATING") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=7%>" & MyBase.GetResourceString("PERSONRESPONSIBLE") & "</td></TR>")

        'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        'm_strSQL = "select * from tbl_PRS_SQERT_Ranges where SQERT_Range_ID=4"
        m_strSQL = "usp_sel_Range_tbl_PRS_SQERT_Ranges"
        'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


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
            CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD Colspan=8><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strRiskProjectName & "</b></TD></TR>")

            intCnt = 0

            If (intCnt Mod 2) = 0 Then
                m_strTRstyle = "clsTREvenRow"
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

            CommonFunctions.General.WriteHTML("<td Align='center'>")
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
            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD colspan=8 align='center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
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

            CommonFunctions.General.WriteHTML("<td Align='center'>")
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
            ' Modified By MahendraV On 5:23 PM 6/15/2007 To displayed total planned deliverables
            ' Start_MV_6/15/2007
        ElseIf m_strFlag = 15 Then
            m_strTitle = m_strTitle.Replace("<TYPE>", MyBase.GetResourceString("TOTAL_PLANNED"))
            m_strTitle = m_strTitle.Replace("<TODATE>", CommonFunction.Dates.GetDate(CType(m_dtmReportingEndDate, Date)).ToString)
            m_strTitle = m_strTitle.Replace("<FROMDATE>", CommonFunction.Dates.GetDate(CType(m_dtmReportingStartDate, Date)).ToString)
            If m_strProjectFilters <> "NULL" Then
                m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
            Else
                m_strSQL = "Exec usp_RPT_GetNoOfTaskCompletedForPeriod " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "'," & m_strFlag & "," & CType(Session("intUserID"), String) & ",NULL"
            End If

        End If

        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)


        CommonFunctions.General.WriteHTML("<div id='divList2' style='overflow:auto;height=400;Width:100%;'>")
        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'  colspan=10 Width=100%> <b>" & m_strTitle & "</b></td></TR></TABLE>")

        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
        CommonFunctions.General.WriteHTML("<THEAD class=clsTRColumnHeader>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=5%>" & MyBase.GetResourceString("SRNO") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=30%>" & MyBase.GetResourceString("DELIVERABLENAME") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=15%>" & MyBase.GetResourceString("RESOURCENAME") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=15%>" & MyBase.GetResourceString("EXPSTARTDATE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=15%>" & MyBase.GetResourceString("EXPENDDATE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=10%>" & MyBase.GetResourceString("MLASDATE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=10%>" & MyBase.GetResourceString("MLAEDATE") & "</TH>")
        CommonFunctions.General.WriteHTML("</THEAD>")
        Dim blnIsDataPresent As Boolean = False
        ' End_MV_6/15/2007
        intCnt = 0


        '=========================================================================================
        'Details of Deliverables grid plotting
        '=========================================================================================
        'CommonFunctions.General.WriteHTML("<div id='divList2' style='overflow:auto;height=400;Width:100%;'>")
        ''Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
        ''Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TBODY>")
        'CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align='center'  colspan=10 Width=100%> <b>" & m_strTitle & "</b></td></TR>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=5%>" & MyBase.GetResourceString("SRNO") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=30%>" & MyBase.GetResourceString("DELIVERABLENAME") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=15%>" & MyBase.GetResourceString("RESOURCENAME") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=15%>" & MyBase.GetResourceString("EXPSTARTDATE") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=15%>" & MyBase.GetResourceString("EXPENDDATE") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=10%>" & MyBase.GetResourceString("MLASDATE") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=10%>" & MyBase.GetResourceString("MLAEDATE") & "</td>")
        'CommonFunctions.General.WriteHTML("</TR>")

        'If drSQERT.Read Then
        '    m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
        '    CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD Colspan=10><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
        'Else
        '    CommonFunctions.General.WriteHTML("<TR class=clsTREvenOdd><TD colspan=10 align='center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
        'End If

        'CommonFunctions.Data.DisposeDataReader(drSQERT)
        'drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        While drSQERT.Read
            blnIsDataPresent = True
            'If CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString <> m_strBaselineProjectName Then
            '    intCnt = 1
            '    m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
            '    CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader><TD Colspan=10><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
            'Else
            If CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString <> m_strBaselineProjectName Then
                intCnt = 1
                m_strBaselineProjectName = CommonFunctions.Data.CheckIsDBNull(drSQERT("ProjectName"), "").ToString
                CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD Colspan=10><b>" & MyBase.GetResourceString("PROJECT") & " : " & m_strBaselineProjectName & "</b></TD></TR>")
            Else
                intCnt = intCnt + 1
            End If
            If (intCnt Mod 2) = 0 Then
                m_strTRstyle = "clsTREvenRow"
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
        If blnIsDataPresent = False Then
            CommonFunctions.General.WriteHTML("<TR class=clsTROdd><TD colspan=10 align='center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
        End If
        CommonFunctions.Data.DisposeDataReader(drSQERT)


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

        'CommonFunctions.General.WriteHTML("<DIV ID='DIVLIST' STYLE='overflow:auto;width:100%;height=410px'>")
        ''Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0'>")
        ''Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'CommonFunctions.General.WriteHTML("<TBODY>")
        'CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><td align=left width=100% Colspan=7><b>" & MyBase.GetResourceString("TITLE_SQERTDETAILS") & CommonFunctions.Dates.GetDate(CType(m_dtmReportingEndDate, Date)) & "</b></td><tr>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRColumnHeader>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=52%>" & MyBase.GetResourceString("PROJECTNAME") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=8%>" & MyBase.GetResourceString("SCOPE") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=8%>" & MyBase.GetResourceString("QUALITY") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=8%>" & MyBase.GetResourceString("EFFORT") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=8%>" & MyBase.GetResourceString("RISK") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=8%>" & MyBase.GetResourceString("TIME") & "</td>")
        'CommonFunctions.General.WriteHTML("<td align='center' width=8%>" & MyBase.GetResourceString("PROJECTOVERVIEW") & "</td></TR>")
        ' Modified By MahendraV On 2:16 PM 6/14/2007 for SP8 Performance
        ' Start_MV_6/14/2007
        ' Commented  by Viraj P on 16 Nov 2015
        'CommonFunctions.General.WriteHTML("<DIV ID='DIVLIST' STYLE='overflow:auto;width:100%;height=410px'>")
        CommonFunctions.General.WriteHTML("<DIV ID='DIVLIST' STYLE='overflow:auto;width:100%;'>")
        'End of Comment  by Viraj P on 16 Nov 2015
        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><td align=left width=100% Colspan=8><b>" & MyBase.GetResourceString("TITLE_SQERTDETAILS") & CommonFunctions.Dates.GetDate(CType(m_dtmReportingEndDate, Date)) & "</b></td></tr></TABLE>")

        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
        CommonFunctions.General.WriteHTML("<THEAD class=clsTRColumnHeader>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=37%>" & MyBase.GetResourceString("PROJECTNAME") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=15%>" & MyBase.GetResourceString("REPORTING_DATE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=8%>" & MyBase.GetResourceString("SCOPE") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=8%>" & MyBase.GetResourceString("QUALITY") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=8%>" & MyBase.GetResourceString("EFFORT") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=8%>" & MyBase.GetResourceString("RISK") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=8%>" & MyBase.GetResourceString("TIME") & "</TH>")
        CommonFunctions.General.WriteHTML("<TH align='center' class='divListTag' width=8%>" & MyBase.GetResourceString("PROJECTOVERVIEW") & "</TH></THEAD>")


        Dim intFlag As Integer = 0
        Dim m_intRecords As Integer = 0

        If m_strProjectFilters <> "NULL" Then
            'Commented & added by Viraj P on 18 Nov 2015 Purpose: To convert time format as well as Date Format
            'm_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',0," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'," & CType(Session("LoginType"), String)
            m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & Format(CType(FormatDateTime(m_dtmReportingStartDate, DateFormat.ShortDate), Date), "hh:mm") & "','" & Format(CType(FormatDateTime(m_dtmReportingEndDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "',0," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'," & CType(Session("LoginType"), String)

        Else
            m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & Format(CType(FormatDateTime(m_dtmReportingStartDate, DateFormat.ShortDate), Date), "hh:mm") & "','" & Format(CType(FormatDateTime(m_dtmReportingEndDate, DateFormat.ShortDate), Date), "MM/dd/yyyy") & "',0," & CType(Session("intUserID"), String) & ",NULL," & CType(Session("LoginType"), String)
            'Commented and Ended by Viraj P on 18 Nov 2015 Purpose: To convert time format as well as Date Format
        End If
        drTask = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        m_strTRstyle = "clsTREvenRow"
        Do
            Select Case intFlag
                Case 1

                    While drTask.Read
                        intRecords = intRecords + 1
                        If m_strTRstyle = "clsTREvenRow" Then
                            m_strTRstyle = "clsTROdd"
                        Else
                            m_strTRstyle = "clsTREvenRow"
                        End If
                        'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
                        ' m_strSQL = "select * from tbl_PRS_SQERT_Ranges ORDER BY SQERT_Order"
                        m_strSQL = "usp_sel_SQERT_tbl_PRS_SQERT_Ranges"
                        'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


                        drSQERT = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

                        CommonFunctions.General.WriteHTML("<TR class=" & m_strTRstyle & ">")
                        ' Modified By MahendraV On 5:41 PM 7/23/2007 For WhizibleSEM 7.0
                        ' To Pass 'm_strReportedDate' parameter in Standard format
                        ' Start_MV_7/23/2007
                        ' CommonFunctions.General.WriteHTML("<td Align='left'><a Href=""javascript:SQERTProjectLink_onClick(" + CommonFunctions.Data.CheckIsDBNull(drTask("ProjectID"), "").ToString + ", " + m_intReportingPeriod.ToString + ", '" + m_strReportedDate.ToString + "' )"">" & CommonFunctions.Data.CheckIsDBNull(drTask("ProjectName"), "").ToString & "</a></td>")
                        If m_strReportedDate.ToString() <> "" Then
                            CommonFunctions.General.WriteHTML("<td Align='left'><a Href=""javascript:SQERTProjectLink_onClick(" + CommonFunctions.Data.CheckIsDBNull(drTask("ProjectID"), "").ToString + ", " + m_intReportingPeriod.ToString() + ", '" + CommonFunctions.Dates.GetDate(CType(m_strReportedDate.ToString(), Date)) + "' )"">" & CommonFunctions.Data.CheckIsDBNull(drTask("ProjectName"), "").ToString & "</a></td>")
                        End If
                        ' End_MV_7/23/2007
                        ' Added by MahebdraV On 5:35 PM 7/20/2007 For WhizibleSEM 7.0
                        ' TO show reporting date of SQERT for each project
                        ' Start_MV_7/20/2007
                        If CommonFunctions.Data.CheckIsDBNull(drTask("ReportingDate"), "").ToString() <> "" Then
                            CommonFunctions.General.WriteHTML("<TD ALIGN='center'>" + CommonFunctions.Dates.GetDate(CType(drTask("ReportingDate"), Date)) + "</TD>")
                        Else
                            CommonFunctions.General.WriteHTML("<TD ALIGN='center'>&nbsp;</TD>")
                        End If
                        ' End_MV_7/20/2007
                        CommonFunctions.General.WriteHTML("<td Align='center'>")

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

                        CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
                        If drSQERT.Read Then
                            If CType(drTask("Quality"), Integer) >= CType(drSQERT("Lower_Low"), Integer) And CType(drTask("Quality"), Integer) <= CType(drSQERT("Lower_High"), Integer) Then
                                'Modified By VarunA on 5-Mar-2008 RequestID-11651
                                'Purpose : To have color according to which we have specify at SQERT Ranges.
                                'strProjectOverview = strProjectOverview & 3 & ","
                                'StrQuality = StrQuality & 3 & ","
                                'strProgram = strProgram & 3 & ","
                                strProjectOverview = strProjectOverview & 1 & ","
                                StrQuality = StrQuality & 1 & ","
                                strProgram = strProgram & 1 & ","
                                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#FFFFFF' STYLE='background: #FF0000'>L</FONT>")
                                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                                'CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                                CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                                'End By VarunA on 5-Mar-2008
                            ElseIf CType(drTask("Quality"), Integer) >= CType(drSQERT("Middle_Low"), Integer) And CType(drTask("Quality"), Integer) <= CType(drSQERT("Middle_High"), Integer) Then
                                strProjectOverview = strProjectOverview & 2 & ","
                                StrQuality = StrQuality & 2 & ","
                                strProgram = strProgram & 2 & ","
                                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#000000' STYLE='background: #FFFF00'>K</FONT>")
                                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                                CommonFunctions.General.WriteHTML("<IMG src='../../images/yellow.gif'>")
                            ElseIf CType(drTask("Quality"), Integer) >= CType(drSQERT("Upper_Low"), Integer) And CType(drTask("Quality"), Integer) <= CType(drSQERT("Upper_High"), Integer) Then
                                'Modified By VarunA on 5-Mar-2008 RequestID-11651
                                'Purpose : To have color according to which we have specify at SQERT Ranges.
                                'strProjectOverview = strProjectOverview & 1 & ","
                                'StrQuality = StrQuality & 1 & ","
                                'strProgram = strProgram & 1 & ","
                                strProjectOverview = strProjectOverview & 3 & ","
                                StrQuality = StrQuality & 3 & ","
                                strProgram = strProgram & 3 & ","
                                'CommonFunctions.General.WriteHTML("<FONT FACE='Wingdings' SIZE='4' COLOR='#00FF00' STYLE='background: #008000'>J</FONT>")
                                'Integrated by SnehalV on 11sept 2006 for Whiziblesem6.0 SP 7 Issue ID.6195
                                'CommonFunctions.General.WriteHTML("<IMG src='../../images/green.gif'>")
                                CommonFunctions.General.WriteHTML("<IMG src='../../images/red.gif'>")
                                'End By VarunA on 5-Mar-2008
                            End If
                        End If
                        CommonFunctions.General.WriteHTML("</TD>")

                        CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
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

                        CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
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

                        CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
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

                        CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
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
                        CommonFunctions.General.WriteHTML("</TD></TR>")
                        CommonFunctions.Data.DisposeDataReader(drSQERT)
                        strProjectOverview = ""
                    End While
                    If intRecords = 0 Then
                        CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD colspan=8 align='center'>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
                    Else
                        If m_strTRstyle = "clsTREven" Then
                            m_strTRstyle = "clsTROdd"
                        Else
                            m_strTRstyle = "clsTREven"
                        End If

                        CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader >")
                        CommonFunctions.General.WriteHTML("<td Align='left'> <b>" & MyBase.GetResourceString("OVERVIEW") & " </b> </td>")
                        CommonFunctions.General.WriteHTML("<TD ALIGN='center'>&nbsp;</TD>")
                        CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
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


                        CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
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

                        CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
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

                        CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
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

                        CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
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

                        CommonFunctions.General.WriteHTML("<TD ALIGN='center'>")
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

                    'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                    CommonFunctions.General.WriteHTML("<table cellSpacing='1' cellPadding='0' width='99.9%' border='0'>")
                    'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                    CommonFunctions.General.WriteHTML("<TBODY><tr></tr>")
                    CommonFunctions.General.WriteHTML("<tr class=clsTRSectionHeader><td align='left' colspan=3 width=100%><b>" & MyBase.GetResourceString("UNLOCKED_PROJECTS") & CommonFunctions.Dates.GetDate(CType(m_dtmReportingEndDate, Date)) & "</b></td></tr>")
                    CommonFunctions.General.WriteHTML("<tr class=clsTRColumnHeader><td align='center' width=70%><B>" & MyBase.GetResourceString("PROJECTNAME") & "</B></td>")
                    CommonFunctions.General.WriteHTML("<td align='center' width=15%><B>" & MyBase.GetResourceString("PROJECT_START_DATE") & "</B></TD>")
                    CommonFunctions.General.WriteHTML("<td align='center' width=15%><B>" & MyBase.GetResourceString("PROJECT_END_DATE") & "</B></TD></TR>")

                Case 3
                    m_strTRstyle = "clsTREvenRow"
                    While drTask.Read
                        m_intRecords = m_intRecords + 1
                        If m_strTRstyle = "clsTREvenRow" Then
                            m_strTRstyle = "clsTROdd"
                        Else
                            m_strTRstyle = "clsTREvenRow"
                        End If
                        CommonFunctions.General.WriteHTML("<TR class=" & m_strTRstyle & "><TD Align=left width=70%>" & CommonFunctions.Data.CheckIsDBNull(drTask("ProjectName"), "").ToString & "</TD>")
                        If CommonFunctions.Data.CheckIsDBNull(drTask("ExpectedStartDate"), "").ToString() <> "" Then
                            CommonFunctions.General.WriteHTML("<td align='center' width=15%>" & CommonFunctions.Dates.GetDate(CType(drTask("ExpectedStartDate"), Date)) & "</TD>")
                        Else
                            CommonFunctions.General.WriteHTML("<td align='center' width=15%>&nbsp;</TD>")
                        End If
                        If CommonFunctions.Data.CheckIsDBNull(drTask("ExpectedEndDate"), "").ToString() <> "" Then
                            CommonFunctions.General.WriteHTML("<td align='center' width=15%>" & CommonFunctions.Dates.GetDate(CType(drTask("ExpectedEndDate"), Date)) & "</TD>")
                        Else
                            CommonFunctions.General.WriteHTML("<td align='center' width=15%>&nbsp;</TD></TR>")
                        End If




                    End While

            End Select
            intFlag = intFlag + 1
        Loop While drTask.NextResult()


        ' End_MV_6/14/2007

        CommonFunctions.Data.DisposeDataReader(drTask)
        CommonFunctions.Data.DisposeDataReader(drSQERT)


        'If m_strProjectFilters <> "NULL" Then
        '    m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',3," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'"
        'Else
        '    m_strSQL = "Exec usp_CRW_ProjectSheet_GetSQERTList " & m_strQuery & ",'" & m_dtmReportingStartDate & "','" & m_dtmReportingEndDate & "',3," & CType(Session("intUserID"), String) & ",NULL"
        'End If

        'drTask = CommonFunctions.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        'intRecords = 0

        'While drTask.Read
        '    intRecords = intRecords + 1
        '    CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD Align=left>" & CommonFunctions.Data.CheckIsDBNull(drTask("ProjectName"), "").ToString & "</TD></TR>")
        'End While

        'CommonFunctions.Data.DisposeDataReader(drTask)
        intRecords = m_intRecords
        If intRecords = 0 Then
            CommonFunctions.General.WriteHTML("<TR class='clsTREven'><TD Align=center>" & MyBase.GetResourceString("NO_ITEMS") & "</TD></TR>")
        End If

        CommonFunctions.General.WriteHTML("</TABLE>")
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
            ' Modified By MahendraV On 11:35 AM 7/21/2007
            ' To hide link 'UpdateSQERT Value' from the customer
            ' Start_MV_7/21/2007
            If CType(Session("LoginType"), String) <> "C" Then
                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_UPDATESQERTVALUES"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_UPDATESQERTVALUES_TOOLTIP"))
                ArrTopMenuFunctionsList.Add("UpdateSQERTValues_Click()")
            End If
            ' End_MV_7/21/2007


           

            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_VIEWREPORT"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_VIEWREPORT_TOOLTIP"))
            ArrTopMenuFunctionsList.Add("ViewReport_Click()")
            ' Added By MahendraV On 5:49 PM 7/19/2007 For WhizibleSEM 7
            ' To clear all filters  for 'Project Health Sheet'
            ' Start_MV_ 7/19/2007
            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("CLEAR_ALL_FILTERS"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("CLEAR_ALL_FILTERS"))
            ArrTopMenuFunctionsList.Add("ClearAllFilters_OnClick()")
            ' End_MV_ 7/19/2007
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

            ' Added By MahendraV On 5:30 PM 7/31/2007 For WhizibleSEM 7
            ' To hide close link when it displayed in 'Dashboard'
            ' Start_MV_7/31/2007
            If Not IsNothing(Request.QueryString("FromWhere")) Then
                If Request.QueryString("FromWhere").ToString() <> "DB" Then

                    ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
                    ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
                    ArrTopMenuFunctionsList.Add("Close_Click()")

                End If
            Else
                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
                ArrTopMenuFunctionsList.Add("Close_Click()")
            End If
            ' End_MV_7/31/2007
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
        '' Added By NitinVS on 6 Aug 2008 For Project Profitability Functionality 
        'Plot_ProjectProfitTrends()
        '' End Added By NitinVS on 6 Aug 2008 For Project Profitability Functionality 

        With objGraphs
            .ProjectID = CType(m_strProjectId, Long)
            .TagID = m_lngTagId
            .ReportGenerationDate = m_strReportedDate
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
    '    ' Added By NitinVS on 6 Aug 2008 For Project Profitability Functionality 
    '#Region "Project Profitability Trends"

    '    Private Function plotGraph(ByVal intTableID As Integer, ByVal strGraphType As String, ByVal GraphDetails As GraphCaption) As String
    '        '=====================================================================
    '        ' Procedure Name        : plotGraph()	
    '        ' Purpose               : to Generate  Graph
    '        ' Description           : same as above
    '        ' Parameters Passed     : none
    '        ' Returns               : none
    '        ' Parameters Affected   : 
    '        ' Assumptions           : 
    '        ' Dependencies          : 
    '        ' Author                : MahendraV
    '        ' Created               : 14-April-2008
    '        ' Revisions             :
    '        '=====================================================================

    '        Dim objGraph As Graph.Graph
    '        Dim strImageFileName As String = ""
    '        Dim blnShowLegends As Boolean = False
    '        Dim blnShowCaptions As Boolean = True
    '        Dim blnShowExplodedPie As Boolean = False
    '        Dim blnEnable3D As Boolean = False
    '        Dim lngEntityID As Long = 0
    '        Dim strNomenclature As String = ""
    '        Dim arrstrChartType() As String = {}
    '        Dim strVirtualImgPath As String
    '        Dim arr(3) As String
    '        Dim arrColor(5) As String
    '        Dim dsGraph As New System.Data.DataSet("Graph")
    '        Dim ddChart As New Dundas.Charting.WebControl.Chart
    '        Dim strctGraphDetails As New GraphCaption

    '        arrColor(0) = "red"
    '        arrColor(1) = "red"
    '        arrColor(2) = "green"
    '        arrColor(3) = "orange"
    '        arrColor(4) = "black"

    '        strctGraphDetails = GraphDetails
    '        dsGraph.Tables.Add(m_dsGraphs.Tables(intTableID - 1).Copy())
    '        strImageFileName = "ProjectProfitability_" + CommonFunction.FileDirectory.GetUniqueFileName()
    '        blnShowLegends = True
    '        strNomenclature = "Project Profitability"
    '        blnShowCaptions = True
    '        ' create the graph for the item values
    '        objGraph = New Graph.Graph


    '        With objGraph
    '            strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
    '            .VirtualImagePath = strVirtualImgPath
    '            .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
    '            .ConnectionString = CommonFunction.Application.ConnectionString
    '            .Enable3D = False
    '            arr(0) = strGraphType.ToUpper
    '            arr(1) = strGraphType.ToUpper
    '            arr(2) = strGraphType.ToUpper
    '            arr(3) = strGraphType.ToUpper
    '            .ChartType = arr
    '            .GraphTitleColor = "black"
    '            .ChartBackColor = "Bisque"
    '            .ChartAreaColor = "FloralWhite"
    '            .ShowLegends = True
    '            .XAxisTitle = strctGraphDetails.XaxisCaption
    '            .Nomenclature = strctGraphDetails.LeftCaption
    '            .LegendDocking = "bottom"
    '            .LegendStyle = "column"
    '            .LegendCaptionColor = "black"
    '            .PalleteStyle = "EARTHTONES"
    '            .EnableXAxis = True
    '            .EnableYAxis = True
    '            .EnableXAxisMinorGrid = False
    '            .EnableYAxisMinorGrid = False

    '            .EnableSmartLabels = False
    '            .ShowCaptions = False
    '            .GraphTitleColor = "black"
    '            .ShowDataColumnNameAsXAxisTitle = False
    '            '-- Fixed Settings
    '            .GraphTitle = strctGraphDetails.GraphCaption
    '            .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
    '            '.SQL = strSQL
    '            .DataSet = dsGraph
    '            'If intTableID = 1 Then
    '            '    .Width = m_intGraphWidth + m_intGraphWidth
    '            'Else
    '            '    .Width = m_intGraphWidth
    '            'End If
    '            .Width = 850
    '            .Height = 350
    '            .LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)
    '            .BorderGradientColor = "WHITE"
    '            .BorderGradientStyle = "TOPBOTTOM"
    '            .ChartBackGradientColor = "WHITE"
    '            .ChartBackGradientStyle = "TOPBOTTOM"
    '            .ChartAreaGradientColor = "WHITE"
    '            .ChartAreaGradientStyle = "TOPBOTTOM"

    '            .BorderStyle = "FrameTitle5"
    '            .BorderColor = "Blue"
    '            .GraphTitleColor = "white"
    '            .ChartBackColor = "PaleGoldenRod"
    '            .ChartAreaColor = "GoldenRod"


    '            .LegendColor = arrColor
    '            .XAxisTitleFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)
    '            .XAxisLabelStyle = 2
    '            '.XAxisInterval = 1
    '            'If intTableID = 1 Then
    '            .MapAreaHREF = "javascript:ShowGraphDetails(" & intTableID.ToString & ")"
    '            'Else
    '            .DrillDownClientSideFunctionName = "ShowGraphDetails(" & intTableID.ToString & ","
    '            'End If
    '            .ChartAreaWidth = 95
    '            .GenerateStackedGraphImage()
    '            'ddChart = .GenerateChartControl

    '        End With

    '        dsGraph.Dispose()
    '        dsGraph = Nothing
    '        Return strVirtualImgPath

    '    End Function

    '    Private Function GetGraphDetails(ByVal intAttributeID As Integer, ByVal intGraphOrder As Integer) As GraphCaption

    '        '=====================================================================
    '        ' Procedure Name        : GetGraphDetails()	
    '        ' Purpose               : to get graph details
    '        ' Description           : same as above
    '        ' Parameters Passed     : none
    '        ' Returns               : none
    '        ' Parameters Affected   : 
    '        ' Assumptions           : 
    '        ' Dependencies          : 
    '        ' Author                : MahendraV
    '        ' Created               : 14-April-2008
    '        ' Revisions             :
    '        '=====================================================================
    '        Dim strGraphTitle As String = ""
    '        Dim strGraphName As String = ""
    '        If intAttributeID = 1 Then
    '            strGraphTitle = "Cost Trend"
    '            strGraphName = "As On"
    '        End If

    '        If intAttributeID = 2 Then
    '            strGraphTitle = "Revenue Trend"
    '            strGraphName = "As On"
    '        End If

    '        If intAttributeID = 3 Then
    '            strGraphTitle = "GPM Trend"
    '            strGraphName = "As On"
    '        End If

    '        Dim arrStrFirstGraph(,) As String = {{strGraphTitle, strGraphName, "Amount"}, {strGraphTitle, strGraphName, "Amount"}, {strGraphTitle, strGraphName, "Amount"}, {strGraphTitle, strGraphName, "Amount"}}

    '        Dim arrStrSecondGraph(,) As String = {{strGraphTitle, strGraphName, "Amount"}, {strGraphTitle, strGraphName, "Amount"}, {strGraphTitle, strGraphName, "Amount"}, {strGraphTitle, strGraphName, "Amount"}}

    '        Dim arrStrThirdGraph(,) As String = {{strGraphTitle, strGraphName, "Amount"}, {strGraphTitle, strGraphName, "Amount"}, {strGraphTitle, strGraphName, "Amount"}, {strGraphTitle, strGraphName, "Amount"}}

    '        Dim strctGraph As New GraphCaption
    '        Select Case intGraphOrder
    '            Case 1
    '                strctGraph.GraphCaption = arrStrFirstGraph(intAttributeID - 1, 0)
    '                strctGraph.XaxisCaption = arrStrFirstGraph(intAttributeID - 1, 1)
    '                strctGraph.LeftCaption = arrStrFirstGraph(intAttributeID - 1, 2)
    '            Case 2
    '                strctGraph.GraphCaption = arrStrSecondGraph(intAttributeID - 1, 0)
    '                strctGraph.XaxisCaption = arrStrSecondGraph(intAttributeID - 1, 1)
    '                strctGraph.LeftCaption = arrStrSecondGraph(intAttributeID - 1, 2)
    '            Case Else
    '                strctGraph.GraphCaption = arrStrThirdGraph(intAttributeID - 1, 0)
    '                strctGraph.XaxisCaption = arrStrThirdGraph(intAttributeID - 1, 1)
    '                strctGraph.LeftCaption = arrStrThirdGraph(intAttributeID - 1, 2)
    '        End Select

    '        Return strctGraph
    '    End Function

    '    Private Sub Plot_ProjectProfitTrends()

    '        Dim intRowCount As Integer = 0
    '        Dim strSQL As String = ""
    '        Dim row As HtmlTableRow
    '        Dim cell As HtmlTableCell
    '        Dim strLabels As String = ""
    '        Dim strTitle As String = ""
    '        Dim strMenu As String = ""
    '        Dim blnRestrictView As Boolean = False
    '        Dim blnRestrictEdit As Boolean = False
    '        Dim FilterTable As New System.Web.UI.HtmlControls.HtmlTable
    '        Dim strGraphType() As String = {"SPLINE", "LINE", "COLUMN", "POINT"}
    '        Dim intGraphCount As Integer
    '        Dim strHTML As New System.Text.StringBuilder
    '        m_dsGraphs = CommonFunctions.Data.GetDataSet("USP_SEL_ProjectProfitabilityTrends " + m_strProjectId, "Trends", , , MyBase.UseSQL)

    '        Dim Graphcount As Integer = 0
    '        Dim strctGraphDetails As New GraphCaption

    '        CommonFunctions.General.WriteHTML("<br>")
    '        Dim strLeftSectionTitle As String = ""

    '        strHTML.Append("<table  cellspacing=""0"" align=""middle"" class=""clsTable"" style='width:99.99%' id=""tblProfitabilityGraphs"" cellPadding=""0"">")

    '        For Each table As DataTable In m_dsGraphs.Tables
    '            Graphcount += 1
    '            strctGraphDetails = GetGraphDetails(Graphcount, Graphcount)
    '            strHTML.Append("<tr class='clsTREven'><td>")
    '            strHTML.Append("<img src='")
    '            strHTML.Append(plotGraph(Graphcount, strGraphType(intGraphCount), strctGraphDetails))
    '            strHTML.Append(".png' />")
    '            strHTML.Append("</td></tr>")
    '            'With tblGraphs
    '            '    row = New HtmlTableRow
    '            '    .Rows.Add(row)
    '            '    cell = New HtmlTableCell
    '            '    cell.Attributes.Add("width", "100%")
    '            '    cell.Attributes.Add("colspan", "2")
    '            '    cell.Attributes.Add("align", "left")
    '            '    cell.Attributes.Add("Valign", "Top")
    '            '    cell.InnerHtml = "<TABLE CellSpacing=0 BORDER=0 class='clsTable' width='99.9%'><TR class='clsTRPageCaption'><td colspan='6'><b>" + strctGraphDetails.GraphCaption + "</b></td>"
    '            '    'cell.InnerHtml = cell.InnerHtml + "<TR class='clsTREven'><TD align='right'>Attribute Value</TD><TD align='left'>&nbsp;" & CommonFunctions.HTMLControls.DrawComboBox("cboAttributeValue", "usp_Sel_NormalizationCompensationAttributeValue " & CStr(m_intAttributeID), 200, m_intAttributeValue, " onchange=javascript:Filter_OnChange(5) ", True, True) & "</TD>"
    '            '    'cell.InnerHtml = cell.InnerHtml + "<TD align='right'>Attribute Value Type</TD><TD align='left'>&nbsp;" & CommonFunctions.HTMLControls.DrawComboBox("cboAttributeGraph1", "usp_Sel_NormalizationCompensationAttributeGraph1 " & CStr(m_intAttributeID), 200, m_intAttributeGraph1, " onchange=javascript:Filter_OnChange(6) ", , True) & "</TD>"
    '            '    'cell.InnerHtml = cell.InnerHtml + "<TD align='right'>Graph Type</TD><TD align='left'>&nbsp;" & CommonFunctions.HTMLControls.DrawComboBox("cboGraphType" + Graphcount.ToString(), "usp_SEL_GraphType ", 200, , " onchange=javascript:GraphOnChange(this," + Graphcount.ToString() + ") ", , True) & "</TD>")
    '            '    cell.InnerHtml = "</TR></TABLE><BR>"
    '            '    row.Cells.Add(cell)
    '            '    row = New HtmlTableRow
    '            '    .Rows.Add(row)

    '            '    'For intGraphCount = 0 To strGraphType.Length() - 1
    '            '    cell = New HtmlTableCell
    '            '    cell.Attributes.Add("width", "100%")
    '            '    cell.Attributes.Add("colspan", "2")
    '            '    cell.Attributes.Add("align", "center")
    '            '    cell.Attributes.Add("Valign", "middle")
    '            '    cell.Attributes.Add("id", "Graph" & Graphcount.ToString() & strGraphType(intGraphCount))
    '            '    If intGraphCount <> 0 Then
    '            '        cell.Attributes.Add("style", "display:none")
    '            '    End If
    '            '    cell.Controls.Add(plotGraph(Graphcount, strGraphType(intGraphCount), strctGraphDetails))
    '            '    row.Cells.Add(cell)
    '            '    ' Next


    '            'End With

    '        Next
    '        strHTML.Append("</table>")
    '        'tblGraphs.Attributes.Add("Style", "")
    '        'm_dsGraphs.Dispose()
    '        m_dsGraphs = Nothing

    '        CommonFunction.General.WriteHTML(strHTML.ToString())
    '        strHTML = Nothing


    '    End Sub

    '#End Region
    '    ' End Added By NitinVS on 6 Aug 2008 For Project Profitability Functionality 


    Public Sub New()
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016

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
        ''Added  By Shamkant s 31/12/2015
        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            Response.Write(vbCrLf + "<script>")
            Response.Write(vbCrLf + "		if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
            Response.Write(vbCrLf + "</script>")
        End If
        'Ended By Shamkant s 31/12/2015  



    End Sub

    Private Sub m_objActiveResourceGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles m_objActiveResourceGrid.ColumnHeaderTR_BeforePrint
        Args.clsColumnHeader = "clsTRSectionHeader"
    End Sub
End Class
