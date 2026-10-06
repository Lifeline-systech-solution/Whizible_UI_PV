Public Class RM_ResourceUtilizationReport
    Inherits WebPage.Templates.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents frmTimeSheet As System.Web.UI.HtmlControls.HtmlForm

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()

        ''Added by Yogesh J on on 11-Feb-2016 to validate Token
        Dim strProjectID, strDUID As String
        If Request.QueryString("ProjectID") IsNot Nothing Then
            strProjectID = CType(Request.QueryString("ProjectID"), String)
        Else
            strProjectID = "0"
        End If
        If Request.QueryString("DUID") IsNot Nothing Then
            strDUID = CType(Request.QueryString("DUID"), String)
        Else
            strDUID = "0"
        End If
        If (Request.QueryString("ProjectID") IsNot Nothing Or Request.QueryString("DUID") IsNot Nothing) And (Request.QueryString("Mode") = "Generate" Or Request.QueryString("Mode") = "DisplayDetails" Or Request.QueryString("Mode") = "DisplaySummaryDetails") Then
            If Request.QueryString("Token") IsNot Nothing And Request.QueryString("OUID") IsNot Nothing And Request.QueryString("DateRangeID") IsNot Nothing Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("BUID"), String) + CType(Request.QueryString("OUID"), String) + CType(strDUID, String) + CType(strProjectID, String) + CType(Request.QueryString("ResourceID"), String) + CType(Request.QueryString("DateRangeID"), String) + CType(Request.QueryString("PROJECTREPORT"), String) + CType(0, String) + CType(0, String), Request.QueryString("Token")) = False) Then
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If


            End If
        End If
        'If Request.QueryString("DUID") IsNot Nothing And Request.QueryString("Mode") = "Generate" Then

        '    If Request.QueryString("Token") IsNot Nothing And Request.QueryString("OUID") IsNot Nothing And Request.QueryString("DateRangeID") IsNot Nothing Then
        '        If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("BUID"), String) + CType(Request.QueryString("OUID"), String) + CType(Request.QueryString("DUID"), String) + CType(Request.QueryString("ResourceID"), String) + CType(Request.QueryString("DateRangeID"), String) + CType(Request.QueryString("PROJECTREPORT"), String) + CType(0, String) + CType(0, String), Request.QueryString("Token")) = False) Then
        '            'Token is Invalid now redirect to the Invalid Access Page
        '            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '        End If


        '    End If
        'End If
        ''End of addition by Yogesh J on on 11-FEB-2016 to validate Token

    End Sub

#End Region


    Private m_objGlobal As WebPages.Template.IGlobal   ' To store Global object
    Protected m_strBUID As String                              ' to store selected BU ID
    Protected m_strOUID As String                              ' to store selected OU ID
    Protected m_strProjectID As String                        ' to store selected Project ID
    Protected m_strEmployeeID As String                        ' to store selected Employee ID
    Protected m_strFromdate As String                          ' to store from date
    Protected m_strTodate As String                            ' to store To Date
    Protected m_strMode As String                             ' indicates mode of page 'GenerateReport' or ' 

    'Comment and addition done by SuchitraP on 10 Sep 2007
    'Dim m_strSessionUserID As String                    ' to store session user id
    Protected m_strSessionUserID As String                    ' to store session user id
    'End of Comment and addition done by SuchitraP on 10 Sep 2007

    'Private m_strResourcePageCaption As String = MyBase.GetResourceString("GRAPHTITLE") 'to store page caption
    Public Const GRAPH_DIRECTORY As String = "../../images/DB_Graphs/"  ' graph location
    Private m_intGraphHeight As Integer                 ' graph Height    
    Private m_intGraphWidth As Integer                  '  graph width
    Private WithEvents objListGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objListSummaryGrid As New WebPage.Templates.GenericGrid

    Protected m_strMonth As String = ""
    Private m_GroupTotalCapacity As Double = -1
    Private m_GroupTotalAllocated As Double = -1
    Private m_GroupTotalActual As Double = -1
    Private m_GroupTotalBillable As Double = -1
    Private m_GroupTotalCapacityPer As Double = -1
    Private m_GroupTotalAllocatedPer As Double = -1
    Private m_GroupTotalActualPer As Double = -1
    Private m_GroupTotalBillablePer As Double = -1
    Private m_GroupInstallCapacity As Double = -1
    Private m_intCount As Integer = 0

    Private UTILIZATION_TAGID As Long

    ' Added by NitinVS on 20 July 2005 for WhizSEM SP4 IssueId 182

    'Comment and addition done by SuchitraP on 10 Sep 2007
    'Private m_strProjectFilters As String = ""
    Protected m_strProjectFilters As String = ""
    'End of Comment and addition done by SuchitraP on 10 Sep 2007

    Private intRoleLevel As Integer
    Protected m_strDUID As String  ' Delivery Unit ID 
    Protected m_strDateRangeID As String
    Protected m_intProjectReport As Integer

    Private m_GrandTotalCapacity As Double = 0
    Private m_GrandTotalAllocated As Double = 0
    Private m_GrandTotalActual As Double = 0
    Private m_GrandTotalBillable As Double = 0
    Private m_GrandTotalCapacityPer As Double = 0
    Private m_GrandTotalAllocatedPer As Double = 0
    Private m_GrandTotalActualPer As Double = 0
    Private m_GrandTotalBillablePer As Double = 0
    Private m_GrandInstallCapacity As Double = 0
    Protected m_strLoginType As String = "E"
    Protected m_strLoginName As String = ""
    Private WithEvents objListRelatedDataGrid As New WebPage.Templates.GenericGrid

    ' End Addition By NitinVS on 20 July 2005 for WhizSEM SP4

    'Added by NitinVS on 17 July 2007 for WhizibleSEM 7 
    Protected m_ShowDeployableOnly As String = "0"
    Protected m_FromWhere As String = ""
    'End Addition by NitinVS on 17 July 2007 for WhizibleSEM 7 

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
        ' Author                : VidyaJ
        ' Created               : Sept 23, 2004
        ' Revisions             :
        '=====================================================================

        Call SetVariables()

        Response.Write(GenerateMenu())

        'Initialize resource file 
        MyBase.InitializeResources("AppResources.RM_ResourceUtilizationReport", "AppResources")


        'If Not IsPostBack() Then
        Call GeneratePageCaption()
        Call GeneratePageHeader()
        'End If

        Call DisplayPageDetails()

        Response.Write(GenerateMenu())


    End Sub


    Private Sub GenerateReportGraph()
        '=====================================================================
        ' Procedure Name        : GenerateReport()	
        ' Purpose               : to Generate Resource Utilization Graph
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Sept 23, 2004
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
        Dim arr(8) As String
        Dim i As Integer
        Dim strQuery As String

        'Modified by NitinVS on 17 July 2007 for WhizibleSEM 7 
        'to Consider deployable status 
        ' Modified by NitinVS on 20 July 2005 for WhizibleSEM SP4

        ' Initialize Resource Utilization Report SP
        'strSQL = " EXEC  usp_Sel_ResourceUtilizationDetails " + m_strBUID + "," + m_strOUID + "," + m_strProjectID + "," + m_strEmployeeID + ",'" + m_strFromdate + "','" + m_strTodate + "'" + ",0" + "," + m_strSessionUserID + "," + "'" + m_strProjectFilters + "'"
        If m_intProjectReport = 0 Then
            strSQL = " EXEC  usp_Sel_ResourceUtilizationDetails_Monthly " + m_strBUID + "," + m_strOUID + "," + m_strDUID + "," + m_strEmployeeID + "," + m_strDateRangeID + ",0" + "," + m_strSessionUserID + "," + "'" + m_strProjectFilters + "', " + m_ShowDeployableOnly
        Else
            strSQL = " EXEC  usp_Sel_ResourceUtilizationDetails_Monthly_Project " + m_strBUID + "," + m_strOUID + "," + m_strProjectID + "," + m_strEmployeeID + "," + m_strDateRangeID + ",0" + "," + m_strSessionUserID + "," + "'" + m_strProjectFilters + "'," + m_ShowDeployableOnly
        End If


        ' End Modification By NitinVs on 20 July 2005 for WhizibleSEM SP4
        ' end Modification by NitinVS on 17 July 2007 for WhizibleSEM 7 

        'strImageFileName = "ResUtil" + m_strSessionUserID
        strImageFileName = "ResUtil" + CommonFunction.FileDirectory.GetUniqueFileName()
        blnShowLegends = True
        strNomenclature = "ResourceUtilization"
        blnShowCaptions = True

        ' create the graph for the item values
        objGraph = New Graph.Graph

        With objGraph
            strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
            .VirtualImagePath = strVirtualImgPath
            .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
            .ConnectionString = CommonFunction.Application.ConnectionString
            .VirtualImagePath = ""
            .Enable3D = False
            arr(0) = "COLUMN"
            arr(1) = "COLUMN"
            arr(2) = "COLUMN"
            arr(3) = "COLUMN"
            arr(4) = "COLUMN"
            arr(5) = "COLUMN"
            arr(6) = "LINE"
            arr(7) = "LINE"
            arr(8) = "LINE"
            .ChartType = arr
            .GraphTitleColor = "black"
            .ChartBackColor = "PaleGoldenRod"
            .ChartAreaColor = "GoldenRod"
            .ShowLegends = True
            .XAxisTitle = MyBase.GetResourceString("XAXISTITLE")
            .Nomenclature = MyBase.GetResourceString("YAXISTITLE")
            .LegendDocking = "bottom"
            .LegendStyle = "column"
            .LegendCaptionColor = "black"
            .PalleteStyle = "EARTHTONES"
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
            .LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)

            .BorderGradientColor = "WHITE"
            .BorderGradientStyle = "TOPBOTTOM"
            .ChartBackGradientColor = "WHITE"
            .ChartBackGradientStyle = "TOPBOTTOM"
            .ChartAreaGradientColor = "WHITE"
            .ChartAreaGradientStyle = "TOPBOTTOM"
            .LegendDocking = "BOTTOM"
            .LegendStyle = "TABLE"
            .ChartAreaWidth = 95
            .ChartAreaHeight = 75
            ' return the graph image
            .GenerateImage()
        End With


        '-- Display Graph
        If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY) & strImageFileName & ".png") Then
            Response.Write("<IMG HEIGHT=" & m_intGraphHeight & " WIDTH=" & m_intGraphWidth & " src='" + GRAPH_DIRECTORY & strImageFileName & ".png" & "'>")
        Else
            Response.Write("<IMG src='..\..\images\NoPreview.gif'>")
        End If




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
        ' Author                : VidyaJ
        ' Created               : Aug 06, 2004
        ' Revisions             :
        '=====================================================================


        Dim ArrTopMenuCaptionsList As New ArrayList
        Dim ArrTopMenuToolTipsList As New ArrayList
        Dim ArrTopMenuFunctionsList As New ArrayList

        'Initialize resource file 
        MyBase.InitializeResources("AppResources.RM_ResourceUtilizationReport", "AppResources")
        If m_strMode.ToUpper <> "GENERATE" And m_strMode.ToUpper <> "DISPLAYDETAILS" And m_strMode.ToUpper <> "DISPLAYSUMMARYDETAILS" And m_strMode.ToUpper <> "RELATEDDATA" Then
            'Generate Report
            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_GENERATEREPORT"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_GENERATEREPORT_TOOLTIP"))
            ArrTopMenuFunctionsList.Add("GenerateReport()")

            ' Modified By NitinVs on 8 Sep 2005 for WhizibleSEM SP4 IssueId 182 
            ' Links for Summary And Details report are to be shown on first page.

            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DISPLAYSUMMARYDETAILS"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DISPLAYSUMMAYDETAILS_TOOLTIP"))

            'ArrTopMenuFunctionsList.Add(" DisplaySummaryDetails_OnClink('" + m_strBUID + "','" + m_strOUID + "','" + m_strProjectID + "','" + m_strEmployeeID + "','" + m_strFromdate + "','" + m_strTodate + "')")
            ArrTopMenuFunctionsList.Add(" DisplaySummaryDetails_OnClink('" + m_strBUID + "','" + m_strOUID + "','" + m_strDUID + "','" + m_strProjectID + "','" + m_strEmployeeID + "','" + m_strDateRangeID + "')")


            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DISPLAYDETAILS"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DISPLAYDETAILS_TOOLTIP"))
            'ArrTopMenuFunctionsList.Add(" DisplayDetails_OnClink('" + m_strBUID + "','" + m_strOUID + "','" + m_strProjectID + "','" + m_strEmployeeID + "','" + m_strFromdate + "','" + m_strTodate + "')")
            ArrTopMenuFunctionsList.Add(" DisplayDetails_OnClink('" + m_strBUID + "','" + m_strOUID + "','" + m_strDUID + "','" + m_strProjectID + "','" + m_strEmployeeID + "','" + m_strDateRangeID + "')")

        Else
            'Initialize resource file 
            If m_strMode.ToUpper <> "DISPLAYDETAILS" And m_strMode.ToUpper <> "DISPLAYSUMMARYDETAILS" And m_strMode.ToUpper <> "RELATEDDATA" Then

                MyBase.InitializeResources("AppResources.RM_ResourceUtilizationReport", "AppResources")
                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DISPLAYSUMMARYDETAILS"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DISPLAYSUMMAYDETAILS_TOOLTIP"))
                'ArrTopMenuFunctionsList.Add(" DisplaySummaryDetails_OnClink('" + m_strBUID + "','" + m_strOUID + "','" + m_strProjectID + "','" + m_strEmployeeID + "','" + m_strFromdate + "','" + m_strTodate + "')")
                ArrTopMenuFunctionsList.Add(" DisplaySummaryDetails_OnClink('" + m_strBUID + "','" + m_strOUID + "','" + m_strDUID + "','" + m_strProjectID + "','" + m_strEmployeeID + "','" + m_strDateRangeID + "')")


                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DISPLAYDETAILS"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DISPLAYDETAILS_TOOLTIP"))
                'ArrTopMenuFunctionsList.Add(" DisplayDetails_OnClink('" + m_strBUID + "','" + m_strOUID + "','" + m_strProjectID + "','" + m_strEmployeeID + "','" + m_strFromdate + "','" + m_strTodate + "')")
                ArrTopMenuFunctionsList.Add(" DisplayDetails_OnClink('" + m_strBUID + "','" + m_strOUID + "','" + m_strDUID + "','" + m_strProjectID + "','" + m_strEmployeeID + "','" + m_strDateRangeID + "')")

            End If
            ' End Modification By NitinVS on 8 Sep 2005 for WhizibleSEM SP4 IssueId 182 
            If m_strMode.ToUpper = "DISPLAYDETAILS" And m_intProjectReport = 1 Then

                ArrTopMenuCaptionsList.Add("Related Data")
                ArrTopMenuToolTipsList.Add("Related Data")
                'ArrTopMenuFunctionsList.Add(" DisplayDetails_OnClink('" + m_strBUID + "','" + m_strOUID + "','" + m_strProjectID + "','" + m_strEmployeeID + "','" + m_strFromdate + "','" + m_strTodate + "')")
                ArrTopMenuFunctionsList.Add(" RelatedData_OnClink('" + m_strBUID + "','" + m_strOUID + "','" + m_strProjectID + "','" + m_strEmployeeID + "','" + m_strDateRangeID + "')")

            End If

            'Added by NitinVS on 17 July 2007 for WhizibleSEM 7 
            'To allow user to see utilization report for deployable only or all
            If m_strMode.ToUpper = "DISPLAYDETAILS" Or m_strMode.ToUpper = "DISPLAYSUMMARYDETAILS" Or m_strMode.ToUpper = "GENERATE" Then

                If m_ShowDeployableOnly = "0" Then

                    ArrTopMenuCaptionsList.Add("Show Deployable")
                    ArrTopMenuToolTipsList.Add("Show deployable resources only.")
                    ArrTopMenuFunctionsList.Add(" ViewDeployable(1)")
                Else
                    ArrTopMenuCaptionsList.Add("Show All")
                    ArrTopMenuToolTipsList.Add("Show all resources.")
                    ArrTopMenuFunctionsList.Add(" ViewDeployable(0)")
                End If

            End If
            ' End Addition by NitinVS on 17 July 2007 for WhizibleSEM 7 

            'Addition done by SuchitraP on 10 Sep 2007
            'To add print link 
            If m_strMode.ToUpper = "DISPLAYDETAILS" Or m_strMode.ToUpper = "DISPLAYSUMMARYDETAILS" Then
                ArrTopMenuCaptionsList.Add("Print")
                ArrTopMenuToolTipsList.Add("Print")
                If m_intProjectReport = 1 Then
                    ArrTopMenuFunctionsList.Add("Print_Onclick('" + m_strBUID + "','" + m_strOUID + "','" + m_strProjectID + "','" + m_strEmployeeID + "','" + m_strDateRangeID + "')")
                Else
                    ArrTopMenuFunctionsList.Add("Print_Onclick('" + m_strBUID + "','" + m_strOUID + "','" + m_strDUID + "','" + m_strEmployeeID + "','" + m_strDateRangeID + "')")
                End If
            End If
                'End of addition done by SuchitraP on 10 Sep 2007


                'Added by NitinVS on 20 July 2007 for WhizibleSEM 7 
                ' When called from dashboard show link to show the filter UI
                If m_FromWhere = "DB" And m_strMode.ToUpper = "GENERATE" Then
                    ArrTopMenuCaptionsList.Add("Filters")
                    ArrTopMenuToolTipsList.Add("Show Filters.")
                    ArrTopMenuFunctionsList.Add("ViewFilters()")
                Else
                    MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
                    ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
                    ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
                    ArrTopMenuFunctionsList.Add(" Close_OnClink()")
                End If
                ' End Addition By NitinVS on 20 july2007 for whizibleSEM 7 

            End If

        'Initialize resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        'modified by harshada d for help updations for whiziblesem 6 on 3 April 2006
        'ArrTopMenuFunctionsList.Add("Help_OnClick(" & UTILIZATION_TAGID & ")")
        If (m_intProjectReport = 1) Then
            ArrTopMenuFunctionsList.Add("Help_OnClick('3062')")
        Else
            ArrTopMenuFunctionsList.Add("Help_OnClick('2221')")
        End If

        'end of modification by harshada d for help updations for whiziblesem 6 on 3 April 2006

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
        Return WebPage.Templates.StaticMenu.DrawMenu(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True) '+ "<BR>" Commented By Vaijat K ON 25/11/2015
    End Function

    Private Sub DisplayPageDetails()
        Dim strHTML As String
        Dim strCase As String

        Dim strPossibleCauses As String
        Dim strPossibleSolutions As String
        Dim objSection As WebPages.Template.SectionTitle
        Dim strTitle As String
        Dim strProjectName As String
        Dim drInfo As IDataReader
        Dim strBusinessGroup As String
        Dim strOrganizationUnit As String
        Dim strEmployeeName As String
        ' Modified by NitinVS on 9 Sep 2005 for WhizibleSEM SP4 IssueID 182 
        Dim strDeliveryUnit As String = ""
        Dim strDateRange As String = ""
        ' End Modification by NitinVS on 9 Sep 2005 for WhizibleSEM SP4 IssueID 182 


        If m_strMode.ToUpper = "GENERATE" Or m_strMode.ToUpper = "DISPLAYDETAILS" Or m_strMode.ToUpper = "DISPLAYSUMMARYDETAILS" Or m_strMode.ToUpper = "RELATEDDATA" Then
            'Main Div
            CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:600px'>")


            If m_strBUID <> "" And m_strBUID <> "NULL" Then
                '-- Get Business Unit Name
                drInfo = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_CNF_BusinessGroups " + m_strBUID, MyBase.UseSQL)
                If drInfo.Read Then
                    strBusinessGroup = CommonFunctions.Data.CheckIsDBNull(drInfo("BusinessGroup"), "").ToString
                End If
                CommonFunctions.Data.DisposeDataReader(drInfo)
            End If


            If m_strOUID <> "" And m_strOUID <> "NULL" Then
                '-- Get Organization Unit Name
                drInfo = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Location " + m_strOUID, MyBase.UseSQL)
                If drInfo.Read Then
                    strOrganizationUnit = CommonFunctions.Data.CheckIsDBNull(drInfo("Location"), "").ToString
                End If
                CommonFunctions.Data.DisposeDataReader(drInfo)
            End If

            If m_strProjectID <> "" And m_strProjectID <> "NULL" Then
                '-- Get Project Name
                drInfo = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " + m_strProjectID, MyBase.UseSQL)
                If drInfo.Read Then
                    strProjectName = CommonFunctions.Data.CheckIsDBNull(drInfo("ProjectName"), "").ToString
                End If
                CommonFunctions.Data.DisposeDataReader(drInfo)
            End If

            If m_strEmployeeID <> "" And m_strEmployeeID <> "NULL" Then
                '-- Get Organization Unit Name
                drInfo = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_EmployeeName " + m_strEmployeeID, MyBase.UseSQL)
                If drInfo.Read Then
                    strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drInfo("EmployeeName"), "").ToString
                End If
                CommonFunctions.Data.DisposeDataReader(drInfo)
            End If

            ' Modified By NitinVS on  9 sep 2005 for WhizibleSEM SP4 IssueID 182 
            If m_strDUID <> "" And m_strDUID <> "NULL" Then
                ' Get Delivery Unit Name 
                drInfo = CommonFunctions.Data.GetDataReader("usp_Sel_GetDeliveryUnit NULL , NULL ," + m_strDUID, MyBase.UseSQL)
                If drInfo.Read Then
                    strDeliveryUnit = CommonFunctions.Data.CheckIsDBNull(drInfo("ResourcePoolName"), "").ToString
                End If
                CommonFunctions.Data.DisposeDataReader(drInfo)
            End If
            ' End Modification By NitinVS on  9 sep 2005 for WhizibleSEM SP4 IssueID 182 
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageHeader " + ">")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TD class=clsTDEven><b>  " + MyBase.GetResourceString("SELECT_BU") + " : </b>  " + strBusinessGroup + "</TD>")
            CommonFunctions.General.WriteHTML("<TD class=clsTDEven> <b>  " + MyBase.GetResourceString("SELECT_OU") + " : </b> " + strOrganizationUnit + "</TD>")

            'Modified By NitinVS on  9 sep 2005 for WhizibleSEM SP4 IssueID 182 
            If m_intProjectReport = 1 Then
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven > <b>  " + MyBase.GetResourceString("SELECT_PROJECT") + " : </b>" + strProjectName + "</TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven > <b>  " + MyBase.GetResourceString("SELECT_DU") + " : </b>" + strDeliveryUnit + "</TD>")
            End If

            CommonFunctions.General.WriteHTML("</TR><TR class=clsTRPageHeader>")
            CommonFunctions.General.WriteHTML("<TD class=clsTDEven> <b> " + MyBase.GetResourceString("SELECT_RESOURCE") + " : </b> " + strEmployeeName + "</TD>")


            ' Date Range selected is to be shown and not from and To Dates 
            'CommonFunctions.General.WriteHTML("<TD class=clsTDEven > <b> " + MyBase.GetResourceString("FROMDATE") + " : </b>" + CommonFunctions.Dates.CGetDate(CType(m_strFromdate, Date)) + "</TD>")
            'CommonFunctions.General.WriteHTML("<TD class=clsTDEven colspan=3> <b> " + MyBase.GetResourceString("TODATE") + " : </b>" + CommonFunctions.Dates.CGetDate(CType(m_strTodate, Date)) + " </TD>")
            If m_strDateRangeID <> "" And m_strDateRangeID <> "NULL" Then
                ' Get Delivery Unit Name 
                drInfo = CommonFunctions.Data.GetDataReader("usp_sel_DateRange_For_ResourceUtilization " + m_strDateRangeID + " , " + m_intProjectReport.ToString, MyBase.UseSQL)
                If drInfo.Read Then
                    strDateRange = CommonFunctions.Data.CheckIsDBNull(drInfo("Description"), "").ToString
                End If
                CommonFunctions.Data.DisposeDataReader(drInfo)
            End If

            CommonFunctions.General.WriteHTML("<TD class=clsTDEven colspan=2 > <b> " + MyBase.GetResourceString("DATERANGE") + " : </b>" + strDateRange + "</TD>")
            CommonFunctions.General.WriteHTML("</TR></Table>")

            'End Modification By NitinVS on 9 sep 2005 for WhizibleSEM SP4 IssueID 182 
            'Commented By Vaijat K ON 25/11/2015
            'CommonFunctions.General.WriteHTML("<BR><BR>")


        End If


        If m_strMode.ToUpper <> "GENERATE" And m_strMode.ToUpper <> "DISPLAYDETAILS" And m_strMode.ToUpper <> "DISPLAYSUMMARYDETAILS" And m_strMode.ToUpper <> "RELATEDDATA" Then

            'Main Div
            CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:460px'>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTREven " + ">")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            'Display Business Unit Combo

            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD align=right>" + MyBase.GetResourceString("SELECT_BU") + "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboBU", "usp_Sel_GetBusinessGroups " + m_strOUID + "," + m_strProjectID + "," + m_strDUID, 250, m_strBUID, "" + " Langugage=JavaScript OnChange=Filter_change()", True, True, , False))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")

            'Display Organization Unit Combo

            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD align=right>" + MyBase.GetResourceString("SELECT_OU") + "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboOU", "usp_Sel_GetOrganizationUnit " + m_strBUID + "," + m_strProjectID + "," + m_strDUID, 250, m_strOUID, "" + " Langugage=JavaScript OnChange=Filter_change()", True, True, , False))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")

            ' Modified By NitinVS on 8 sep 2005 for WhizibleSEM SP4 IssueId 182 
            If m_intProjectReport = 0 Then

                'Display Delivery Unit Combo

                CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD align=right>" + MyBase.GetResourceString("SELECT_DU") + "</TD>")
                CommonFunctions.General.WriteHTML("<TD align=left >")
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboDU", "usp_Sel_GetDeliveryUnit " + m_strBUID + "," + m_strOUID, 250, m_strDUID, "" + " Langugage=JavaScript OnChange=Filter_change()", True, True, , False))
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("</TR>")

            End If

            If m_intProjectReport = 1 Then
                'Display Project Combo
                CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD align=right>" + MyBase.GetResourceString("SELECT_PROJECT") + "</TD>")
                CommonFunctions.General.WriteHTML("<TD align=left >")
                ' To show only those Projects for Which Resource Has access 
                'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_GetProjectNameList " + m_strBUID + "," + m_strOUID , 250, m_strProjectID, "" + " Langugage=JavaScript OnChange=Filter_change()", True, True, , False))
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_GetProjectNameList " + m_strBUID + "," + m_strOUID + "," + m_strSessionUserID + ",'" + LTrim(RTrim(m_strProjectFilters)) + "'" + ",'" + m_strLoginType + "'", 250, m_strProjectID, "" + " Langugage=JavaScript OnChange=Filter_change()", True, True, , True))

                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("</TR>")

            End If

            'Display Resources Combo
            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD align=right>" + MyBase.GetResourceString("SELECT_RESOURCE") + "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")
            ' CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboResource", "usp_Sel_GetResources  " + m_strBUID + "," + m_strOUID + "," + m_strProjectID, , m_strEmployeeID, "" + " ", True, True, , False))
            'Modified By VarunA on 21-Aug-2008  for access check
            'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboResource", "usp_Sel_GetResources  " + m_strBUID + "," + m_strOUID + "," + m_strDUID + "," + m_strProjectID, 250, m_strEmployeeID, "" + " ", True, True, , False))
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboResource", "usp_Sel_GetResources  " + m_strBUID + "," + m_strOUID + "," + m_strProjectID + "," + m_strDUID + "," + CType(HttpContext.Current.Session("intUserID"), String), 250, m_strEmployeeID, "" + " ", True, True, , False))
            'End By VarunA on 21-Aug-2008  for access check
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")

            ' Standard Date Range Selection is used inplace of dates 
            ''Display From and To Date
            'CommonFunctions.General.WriteHTML(" <TR class=clsTREven > ")
            'CommonFunctions.General.WriteHTML("<TD align=right>" + MyBase.GetResourceString("FROMDATE") + "</TD>")
            'CommonFunctions.General.WriteHTML("<TD align=left >")
            'CommonFunction.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , m_strFromdate, , "frmResourceUtilization", , , , False, , , , True)
            'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("FROMDATE_COMMENT"))
            'CommonFunctions.General.WriteHTML("</TD>")
            'CommonFunctions.General.WriteHTML("</TR>")

            'CommonFunctions.General.WriteHTML(" <TR class=clsTREven > ")
            'CommonFunctions.General.WriteHTML("<TD align=right>" + MyBase.GetResourceString("TODATE") + "</TD>")
            'CommonFunctions.General.WriteHTML("<TD align=left >")
            'CommonFunction.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , m_strTodate, , "frmResourceUtilization", , , , , , , , True)
            'CommonFunctions.General.WriteHTML("</TD>")

            ' Date Range 
            CommonFunctions.General.WriteHTML(" <TR class=clsTREven > ")
            CommonFunctions.General.WriteHTML("<TD align=right>" + MyBase.GetResourceString("DATERANGE") + "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")
            CommonFunction.HTMLControls.DrawComboBox("cboDateRange", "usp_sel_DateRange_For_ResourceUtilization Null ," + m_intProjectReport.ToString, 250, m_strDateRangeID.ToString, , False, , , True)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")


        Else
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTREven " + ">")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            If m_strMode.ToUpper = "GENERATE" Then
                CommonFunctions.General.WriteHTML(" <TD align=center>")
                Call GenerateReportGraph()
                CommonFunctions.General.WriteHTML(" </TD></TR>")


                CommonFunctions.General.WriteHTML("</TABLE>")
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageFooter " + ">")
                'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven width=10%><b> " + MyBase.GetResourceString("NOTE") + " : </b> </TD> ")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left> " + MyBase.GetResourceString("CAPCITY") + "   </TD></TR> ")
                CommonFunctions.General.WriteHTML("<TR class=clsTRPageFooter>")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven> &nbsp; </TD> ")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left>  " + MyBase.GetResourceString("ALLOCATED") + " </TD></TR> ")
                CommonFunctions.General.WriteHTML("<TR class=clsTRPageFooter>")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven> &nbsp; </TD> ")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left>  " + MyBase.GetResourceString("ACTUAL") + "     </TD></TR> ")
                CommonFunctions.General.WriteHTML("<TR class=clsTRPageFooter>")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven> &nbsp; </TD> ")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left>   " + MyBase.GetResourceString("BILLABLE") + "  </TD></TR> ")
                CommonFunctions.General.WriteHTML("<TR class=clsTRPageFooter>")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven> &nbsp; </TD> ")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left>   " + MyBase.GetResourceString("ONBENCH") + "   </TD></TR></TABLE> ")
            Else
                CommonFunctions.General.WriteHTML(" <TD align=center>")
                If m_strMode.ToUpper = "DISPLAYDETAILS" Then
                    Call DisplayResourceDetails()
                ElseIf m_strMode.ToUpper = "DISPLAYSUMMARYDETAILS" Then
                    Call DisplaySummaryDetails()
                ElseIf m_strMode.ToUpper = "RELATEDDATA" Then
                    Call DisplayRelatedData()
                End If
                CommonFunctions.General.WriteHTML(" </TD></TR>")
                CommonFunctions.General.WriteHTML("</TABLE>")

                ' Added By NitinVS on 20 July 2005 for WhizibleSEM SP4 
                ' if project based Resource Utilization is shown then only project Resource Efforts are considered 
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageFooter " + ">")
                'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                CommonFunction.General.WriteHTML("<TD class=clsTDEven >")

                ' for Middle Level or Low level resources only accessible Projects are Considered 
                If intRoleLevel <> 1 Then
                    CommonFunction.General.WriteHTML("<I>" + MyBase.GetResourceString("MIDDLE_LOW_LEVEL_RESOURCE_ACCESS") + "</I> ")
                End If

                CommonFunction.General.WriteHTML("</TD></TR></TABLE>")
                ' End Addition By NitinVS on  20 July 2005 for WhizibleSEM SP4 

            End If


        End If
        CommonFunctions.General.WriteHTML("</TABLE></DIV>")



    End Sub

    Private Sub DisplayResourceDetails()

        Dim ArrActualFieldNames() As String = {"Month", "ResourceName", "InstallCapacityHrs", "CapacityHrs", "Capacity%", "AllocatedHrs", "Allocated%", "ActualHrs", "Actual%", "BillableHrs", "Billable%"}
        ' Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("EMPLOYEENAME"), MyBase.GetResourceString("DATE"), MyBase.GetResourceString("TASKNAME"), MyBase.GetResourceString("DESCRIPTION"), MyBase.GetResourceString("ACTUALWORKHRS")}
        Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("MONTH"), MyBase.GetResourceString("EMPLOYEENAME"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT")}
        Dim ArrSummaryFunctions() As String = {"", "", "SUM", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG"}
        Dim ArrGroupSummaryFunctions() As String = {"", "", "SUM", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG"}
        Dim ArrTDStyle() As String = {"align=left width=8%", "align=left width=15%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%"}
        Dim strSQL As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Modified by NitinVS on 17 July 2007 for WhizibleSEM 7 
        'to Consider deployable status 
        If m_intProjectReport = 0 Then
            strSQL = " EXEC  usp_Sel_ResourceUtilizationDetails_Monthly " + m_strBUID + "," + m_strOUID + "," + m_strDUID + "," + m_strEmployeeID + "," + m_strDateRangeID + ",1" + "," + m_strSessionUserID + "," + "'" + m_strProjectFilters + "'," + m_ShowDeployableOnly
        Else
            strSQL = " EXEC  usp_Sel_ResourceUtilizationDetails_Monthly_Project " + m_strBUID + "," + m_strOUID + "," + m_strProjectID + "," + m_strEmployeeID + "," + m_strDateRangeID + ",1" + "," + m_strSessionUserID + "," + "'" + m_strProjectFilters + "'," + m_ShowDeployableOnly
        End If
        'End Modification  by NitinVS on 17 July 2007 for WhizibleSEM 7 

        With objListGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 11
            .DIVID = "DivList"
            .DIVStyle = "Overflow:auto;width:100%"
            .DIVHeight = 500
            .SQL = strSQL
            .ShowSummaryFunctions = True
            .GroupSummaryFunc = ArrGroupSummaryFunctions
            .SummaryFunctions = ArrSummaryFunctions
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()

        End With

    End Sub
    Private Sub DisplaySummaryDetails()

        Dim ArrActualFieldNames() As String = {"Month", "InstallCapacityHrs", "CapacityHrs", "Capacity%", "AllocatedHrs", "Allocated%", "ActualHrs", "Actual%", "BillableHrs", "Billable%"}
        ' Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("EMPLOYEENAME"), MyBase.GetResourceString("DATE"), MyBase.GetResourceString("TASKNAME"), MyBase.GetResourceString("DESCRIPTION"), MyBase.GetResourceString("ACTUALWORKHRS")}
        Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("MONTH"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT")}
        Dim ArrSummaryFunctions() As String = {"", "SUM", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG"}
        Dim ArrGroupSummaryFunctions() As String = {"", "SUM", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG"}
        Dim ArrTDStyle() As String = {"align=left width=8%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%"}
        Dim strSQL As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'Modified By NitinVS on 20 July 2005 For WhizibleSEM 7
        'To Consider deployable status  
        'Modified By NitinVS on 20 July 2005 For WhizibleSEM SP4 

        ' Only Accessible Projects are to be considered 
        'strSQL = " EXEC  usp_Sel_ResourceUtilizationDetails " + m_strBUID + "," + m_strOUID + "," + m_strProjectID + "," + m_strEmployeeID + ",'" + m_strFromdate + "','" + m_strTodate + "',2" + "," + m_strSessionUserID + "," + "'" + m_strProjectFilters + "'"
        If m_intProjectReport = 0 Then
            strSQL = " EXEC  usp_Sel_ResourceUtilizationDetails_Monthly " + m_strBUID + "," + m_strOUID + "," + m_strDUID + "," + m_strEmployeeID + "," + m_strDateRangeID + ",2" + "," + m_strSessionUserID + "," + "'" + m_strProjectFilters + "'," + m_ShowDeployableOnly
        Else
            strSQL = " EXEC  usp_Sel_ResourceUtilizationDetails_Monthly_Project " + m_strBUID + "," + m_strOUID + "," + m_strProjectID + "," + m_strEmployeeID + "," + m_strDateRangeID + ",2" + "," + m_strSessionUserID + "," + "'" + m_strProjectFilters + "'," + m_ShowDeployableOnly
        End If

        ' End Modification By NitinVS on 20 July 2005 for WhizibleSEM SP4 

        With objListSummaryGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 11
            .DIVID = "DivList"
            .DIVStyle = "Overflow:auto;width:100%"
            .DIVHeight = 500
            .SQL = strSQL
            .ShowSummaryFunctions = True
            .GroupSummaryFunc = ArrGroupSummaryFunctions
            .SummaryFunctions = ArrSummaryFunctions
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

    End Sub

    Private Sub DisplayRelatedData()
        '=====================================================================
        ' Procedure Name        : DisplayRelatedData()	
        ' Purpose               : To display the related data like resource start data end date and leaves etc
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : Sept 19, 2005
        ' Revisions             :
        '=====================================================================
        Dim ArrActualFieldNames() As String = {"EmployeeName", "ExpectedStartDate", "ExpectedEndDate", "ActualStartDate", "ActualEndDate", "Leaves", "Holidays"}
        Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("EMPLOYEENAME"), MyBase.GetResourceString("EXPECTED_START_DATE"), MyBase.GetResourceString("EXPECTED_END_DATE"), MyBase.GetResourceString("ACTUAL_START_DATE"), MyBase.GetResourceString("ACTUAL_END_DATE"), MyBase.GetResourceString("LEAVES"), MyBase.GetResourceString("HOLIDAYS")}
        Dim ArrSummaryFunctions() As String = {"", "", "", "", "", "", ""}
        Dim ArrGroupSummaryFunctions() As String = {"", "", "", "", "", "", ""}
        Dim ArrTDStyle() As String = {"align=left width=15%", "align=left width=15%", "align=left width=15%", "align=left width=15%", "align=left width=15%", "align=right width=15%", "align=right width=10%"}
        Dim strSQL As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        strSQL = " EXEC  usp_Sel_ResourceUtilizationDetails_RelatedData " + m_strProjectID + "," + m_strEmployeeID + "," + m_strDateRangeID


        With objListRelatedDataGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 11
            .DIVID = "DivList"
            .DIVStyle = "Overflow:auto;width:100%"
            .DIVHeight = 500
            .SQL = strSQL
            .ShowSummaryFunctions = True
            .GroupSummaryFunc = ArrGroupSummaryFunctions
            .SummaryFunctions = ArrSummaryFunctions
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
            .EmptyValueReplacement = "-"
        End With


    End Sub
    
    Protected Sub GeneratePageHeader()
        '=====================================================================
        ' Procedure Name        : GeneratePageHeader()	
        ' Purpose               : to generate page header
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

        Dim objHeaderFooter As New WebPage.Templates.HeaderFooter


        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)

        objHeaderFooter = Nothing



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
        ' Author                : VidyaJ
        ' Created               : Aug 04, 2004
        ' Revisions             :
        '=====================================================================
        'Modified by NikhatM on 24 Feb 2005 for isue id 16226,page caption vanishes when values are selected
        'CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        'Added by PrachiK on 17 Mar  2005 for IssueID 16226
        'Purpose:When a value is selected from combo fields 'Business Groups' / 'Organization Unit' / 'Project' Then the header title - 'Resource Utilization Report' vanishes.
        If m_intProjectReport = 1 Then
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("GRAPHTITLE") + " (By Project)", , , True))
        Else
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("GRAPHTITLE") + " (By Resource)", , , True))
        End If

        'Addtion ended
        'Modification ends
    End Sub

    Private Sub SetVariables()
        '=====================================================================
        ' Procedure Name        : SetVariables()	
        ' Purpose               : Set variable values (QueryString and form references)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Sept 23, 2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim drProjectInfo As IDataReader

        'Graph variables
        m_intGraphHeight = 450
        m_intGraphWidth = 600 '492
        m_strTodate = ""
        m_strFromdate = ""

        'get Financial Start And End Dates
        CommonFunction.Dates.GetFromAndToDates("10", m_strFromdate, m_strTodate, "")


        'Set Global object
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        UTILIZATION_TAGID = m_objGlobal.TagID

        'Mode
        If Not Request.QueryString("Mode") Is Nothing Then
            If Request.QueryString("Mode") <> "" Then
                m_strMode = Request.QueryString("Mode")
            Else
                m_strMode = ""
            End If
        Else
            m_strMode = ""
        End If

        If m_strMode.ToUpper <> "GENERATE" And m_strMode.ToUpper <> "DISPLAYDETAILS" And m_strMode.ToUpper <> "DISPLAYSUMMARYDETAILS" And m_strMode.ToUpper <> "RELATEDDATA" Then

            'Get Business Unit ID
            If Not MyBase.GetFormValue("cboBU") Is Nothing Then
                If MyBase.GetFormValue("cboBU") <> "" Then
                    m_strBUID = MyBase.GetFormValue("cboBU")
                Else
                    m_strBUID = "NULL"
                End If
            Else
                m_strBUID = "NULL"
            End If

            'Get Organization Unit ID
            If Not MyBase.GetFormValue("cboOU") Is Nothing Then
                If MyBase.GetFormValue("cboOU") <> "" Then
                    m_strOUID = MyBase.GetFormValue("cboOU")
                Else
                    m_strOUID = "NULL"
                End If
            Else
                m_strOUID = "NULL"
            End If

            ' Modified By NitinVS on 8 sep 2005 for WhizibleSEM SP4 IssueID 182 
            'Get Delivery Unit ID
            If Not MyBase.GetFormValue("cboDU") Is Nothing Then
                If MyBase.GetFormValue("cboDU") <> "" Then
                    m_strDUID = MyBase.GetFormValue("cboDU")
                Else
                    m_strDUID = "NULL"
                End If
            Else
                m_strDUID = "NULL"
            End If


            ' Standard Date Range is to be used in place of dates 
            ''From Date
            'If Not MyBase.GetFormValue("txtFromDate") Is Nothing Then
            '    If MyBase.GetFormValue("txtFromDate") <> "" Then
            '        m_strFromdate = MyBase.GetFormValue("txtFromDate")
            '    End If
            'End If

            ''To Date
            'If Not MyBase.GetFormValue("txtToDate") Is Nothing Then
            '    If MyBase.GetFormValue("txtToDate") <> "" Then
            '        m_strTodate = MyBase.GetFormValue("txtToDate")
            '    End If
            'End If

            ' Date Range 
            If Not MyBase.GetFormValue("cboDateRange") Is Nothing Then
                If MyBase.GetFormValue("cboDateRange") <> "" Then
                    m_strDateRangeID = MyBase.GetFormValue("cboDateRange")
                Else
                    m_strDateRangeID = "3" ' This Month
                End If
            Else
                m_strDateRangeID = "3"
            End If

            'Get ProjectID
            If Not MyBase.GetFormValue("cboProject") Is Nothing Then
                If MyBase.GetFormValue("cboProject") <> "" Then
                    m_strProjectID = MyBase.GetFormValue("cboProject")
                    'GET OU and BU of selected Project
                    '-- Get Project Name
                    drProjectInfo = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " + m_strProjectID, MyBase.UseSQL)
                    If drProjectInfo.Read Then
                        m_strBUID = CommonFunctions.Data.CheckIsDBNull(drProjectInfo("BusinessGroupID"), "").ToString
                        m_strOUID = CommonFunctions.Data.CheckIsDBNull(drProjectInfo("LocationID"), "").ToString
                        m_strFromdate = CommonFunctions.Data.CheckIsDBNull(drProjectInfo("ExpectedStartDate"), "").ToString
                        m_strTodate = CommonFunctions.Data.CheckIsDBNull(drProjectInfo("ExpectedEndDate"), "").ToString
                    End If
                    CommonFunctions.Data.DisposeDataReader(drProjectInfo)
                Else
                    m_strProjectID = "NULL"
                End If
            Else
                m_strProjectID = "NULL"
            End If

            'Get Resource ID
            If Not MyBase.GetFormValue("cboResource") Is Nothing Then
                If MyBase.GetFormValue("cboResource") <> "" Then
                    m_strEmployeeID = MyBase.GetFormValue("cboResource")
                Else
                    m_strEmployeeID = "NULL"
                End If
            Else
                m_strEmployeeID = "NULL"
            End If
        Else
            ' Standard Date Range is used in place of from and To dates

            'If Not Request.QueryString("FromDate") Is Nothing Then
            '    If Request.QueryString("FromDate") <> "" Then
            '        m_strFromdate = Request.QueryString("FromDate")
            '    Else
            '        m_strFromdate = "NULL"
            '    End If
            'Else
            '    m_strFromdate = "NULL"
            'End If

            'If Not Request.QueryString("ToDate") Is Nothing Then
            '    If Request.QueryString("ToDate") <> "" Then
            '        m_strTodate = Request.QueryString("ToDate")
            '    Else
            '        m_strTodate = "NULL"
            '    End If
            'Else
            '    m_strTodate = "NULL"
            'End If

            If Not Request.QueryString("DateRangeID") Is Nothing Then
                If Request.QueryString("DateRangeID") <> "" Then
                    m_strDateRangeID = Request.QueryString("DateRangeID")
                Else
                    m_strDateRangeID = "3"
                End If
            Else
                m_strDateRangeID = "3"
            End If

            If Not Request.QueryString("BUID") Is Nothing Then
                If Request.QueryString("BUID") <> "" Then
                    m_strBUID = Request.QueryString("BUID")
                Else
                    m_strBUID = "NULL"
                End If
            Else
                m_strBUID = "NULL"
            End If
            If Not Request.QueryString("OUID") Is Nothing Then
                If Request.QueryString("OUID") <> "" Then
                    m_strOUID = Request.QueryString("OUID")
                Else
                    m_strOUID = "NULL"
                End If
            Else
                m_strOUID = "NULL"
            End If

            ' Added Delivery Unit 
            If Not Request.QueryString("DUID") Is Nothing Then
                If Request.QueryString("DUID") <> "" Then
                    m_strDUID = Request.QueryString("DUID")
                Else
                    m_strDUID = "NULL"
                End If
            Else
                m_strDUID = "NULL"
            End If
            ' End Modification By NitinVS on 9 Sep 2005 for WhizibleSEM SP4 IssueId 182 

            If Not Request.QueryString("ProjectID") Is Nothing Then
                If Request.QueryString("ProjectID") <> "" Then
                    m_strProjectID = Request.QueryString("ProjectID")
                Else
                    m_strProjectID = "NULL"
                End If
            Else
                m_strProjectID = "NULL"
            End If
            If Not Request.QueryString("ResourceID") Is Nothing Then
                If Request.QueryString("ResourceID") <> "" Then
                    m_strEmployeeID = Request.QueryString("ResourceID")
                Else
                    m_strEmployeeID = "NULL"
                End If
            Else
                m_strEmployeeID = "NULL"
            End If
        End If

        ' Commented By NitinVS on 9 sep 2005 for WhizibleSEM SP4 IssueID 182 
        'If m_strFromdate <> "" Then
        '    m_strFromdate = CommonFunctions.Dates.GetDate(CType(m_strFromdate, Date))
        'End If
        'If m_strTodate <> "" Then
        '    m_strTodate = CommonFunctions.Dates.GetDate(CType(m_strTodate, Date))
        'End If
        ' End Comment by NitinVS on 9 sep 2005 for WhizibleSEM SP4 IssueID 182 

        m_strSessionUserID = CType(Session("intUserID"), String)
        m_strLoginType = Session("LoginType").ToString
        m_strLoginName = Session("StrUserName").ToString

        ' Added By NitinVS on 20 July 2005 For WhizibleSEM SP4 Issueid 182 
        If Not Request.QueryString("PROJECTREPORT") Is Nothing Then
            If Request.QueryString("PROJECTREPORT") <> "" Then
                m_intProjectReport = CType(Request.QueryString("PROJECTREPORT"), Integer)
            Else
                m_intProjectReport = 0
            End If
        Else
            m_intProjectReport = 0
        End If

        intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)
        'If middle level then apply filter for Projects
        If intRoleLevel = 2 Or m_strLoginType = "C" Then
            'Apply Role Access Filter for Project List
            m_strProjectFilters = ""
            Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
            If strFilter <> "" Then
                m_strProjectFilters += strFilter
            End If

            Dim strRemove As String = "ProjectID IN"
            m_strProjectFilters = m_strProjectFilters.Remove(0, strRemove.Length)
            'End Addition
            m_strProjectFilters = m_strProjectFilters.Replace("'", "")
            m_strProjectFilters = m_strProjectFilters.Replace("(", "")
            m_strProjectFilters = m_strProjectFilters.Replace(")", "")

        End If
        ' End Addition By NitinVS on 20 July 2005 for WhizibleSEM SP4 issueID 182 

        'Added by NitinVS on 17 july 2007 for whizibleSEM 7 
        ' To capture showdeployable 

        If Not Request.QueryString("ShowDeployableOnly") Is Nothing Then
            m_ShowDeployableOnly = Request.QueryString("ShowDeployableOnly").ToString()
        Else
            m_ShowDeployableOnly = "0"
        End If

        '
        If Not Request.QueryString("FromWhere") Is Nothing Then
            m_FromWhere = Request.QueryString("FromWhere").ToString()
        Else
            m_FromWhere = ""
        End If

        'End Addition by NitinVS on 17 july 2007 for whizibleSEM 7 
    End Sub



    Public Sub New()

        '=====================================================================
        ' Procedure Name        : New()	
        ' Purpose               : Constructor for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             :
        '=====================================================================

        'Apply security

        ' Added and Commented By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ' End Added and Commented By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        'Initialize standard menu resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

    End Sub 'Constructor for the page



    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub objListGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objListGrid.DataRowTR_BeforePrint
        m_intCount = m_intCount + 1
        'Check for Group Value
        If m_strMonth <> Args.DataReader("Month").ToString.Trim Then
            If m_GroupTotalCapacity >= 0 Then
                'Insert sum for the Month
                Args.StringToBeInserted = "<TR class='clsTRSectionHeader' ><TD align='left' colspan=2><FONT color=blue>" + MyBase.GetResourceString("TOTALCAPTION") + "  " + m_strMonth + "</FONT></TD>"
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupInstallCapacity.ToString("N2") + "</FONT></TD>"
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalCapacity.ToString("N2") + "</FONT></TD>"

                ' Modified By NitinVS on 20 July 2005 for WhizibleSEM SP4 
                ' The Percentage Is Shown and not average of Percentage 

                'Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalCapacityPer / m_intCount).ToString("N2") + "</FONT></TD>"
                If m_GroupInstallCapacity <> 0 Or m_GroupTotalCapacity <> 0 Then
                    Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalCapacity * 100 / m_GroupInstallCapacity).ToString("N2") + "</FONT></TD>"
                Else
                    Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
                End If

                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalAllocated.ToString("N2") + "</FONT></TD>"
                'Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalAllocatedPer / m_intCount).ToString("N2") + "</FONT></TD>"
                If m_GroupTotalCapacity <> 0 Or m_GroupTotalAllocated <> 0 Then
                    Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalAllocated * 100 / m_GroupTotalCapacity).ToString("N2") + "</FONT></TD>"
                Else
                    Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
                End If

                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalActual.ToString("N2") + "</FONT></TD>"
                'Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalActualPer / m_intCount).ToString("N2") + "</FONT></TD>"
                If m_GroupTotalCapacity <> 0 Or m_GroupTotalActual <> 0 Then
                    Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalActual * 100 / m_GroupTotalCapacity).ToString("N2") + "</FONT></TD>"
                Else
                    Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
                End If

                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalBillable.ToString("N2") + "</FONT></TD>"
                ' Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalBillablePer / m_intCount).ToString("N2") + "</FONT></TD></TR>"
                If m_GroupTotalCapacity <> 0 Or m_GroupTotalBillable <> 0 Then
                    Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalBillable * 100 / m_GroupTotalCapacity).ToString("N2") + "</FONT></TD></TR>"
                Else
                    Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
                End If

                ' End Modification By NitinVS on 20 July 2005 for WhizibleSEM SP4 

            End If

            'Initialize GroupSum to 0 for next group
            m_intCount = 0
            m_GroupTotalCapacity = 0
            m_GroupTotalAllocated = 0
            m_GroupTotalActual = 0
            m_GroupTotalBillable = 0
            m_GroupTotalCapacityPer = 0
            m_GroupTotalAllocatedPer = 0
            m_GroupTotalActualPer = 0
            m_GroupTotalBillablePer = 0
            m_GroupInstallCapacity = 0

            'reset Month
            m_strMonth = Args.DataReader("Month").ToString + ""

            'Insert TR which will have group value
            Args.StringToBeInserted += "<TR class='clsTRSectionHeader' ><TD align='left' colspan=11>" + Args.DataReader("Month").ToString + "</FONT></TD></TR>"
            m_GroupTotalCapacity += CType(Args.DataReader("CapacityHrs"), Double)
            m_GroupTotalAllocated += CType(Args.DataReader("AllocatedHrs"), Double)
            m_GroupTotalActual += CType(Args.DataReader("ActualHrs"), Double)
            m_GroupTotalBillable += CType(Args.DataReader("BillableHrs"), Double)
            m_GroupInstallCapacity += CType(Args.DataReader("InstallCapacityHrs"), Double)
            m_GroupTotalCapacityPer += CType(Args.DataReader("Capacity%"), Double)
            m_GroupTotalAllocatedPer += CType(Args.DataReader("Allocated%"), Double)
            m_GroupTotalActualPer += CType(Args.DataReader("Actual%"), Double)
            m_GroupTotalBillablePer += CType(Args.DataReader("Billable%"), Double)

            ' Added By NitinVs on 20 July 2005 for WhizibleSEM SP4 
            m_GrandInstallCapacity += CType(Args.DataReader("InstallCapacityHrs"), Double)
            m_GrandTotalCapacity += CType(Args.DataReader("CapacityHrs"), Double)
            m_GrandTotalAllocated += CType(Args.DataReader("AllocatedHrs"), Double)
            m_GrandTotalActual += CType(Args.DataReader("ActualHrs"), Double)
            m_GrandTotalBillable += CType(Args.DataReader("BillableHrs"), Double)

            ' End Addition By NitinVS on 20 July 2005 for whizibleSEM SP4 
        Else
            'update GroupSum
            m_GroupTotalCapacity += CType(Args.DataReader("CapacityHrs"), Double)
            m_GroupTotalAllocated += CType(Args.DataReader("AllocatedHrs"), Double)
            m_GroupTotalActual += CType(Args.DataReader("ActualHrs"), Double)
            m_GroupTotalBillable += CType(Args.DataReader("BillableHrs"), Double)
            m_GroupInstallCapacity += CType(Args.DataReader("InstallCapacityHrs"), Double)
            m_GroupTotalCapacityPer += CType(Args.DataReader("Capacity%"), Double)
            m_GroupTotalAllocatedPer += CType(Args.DataReader("Allocated%"), Double)
            m_GroupTotalActualPer += CType(Args.DataReader("Actual%"), Double)
            m_GroupTotalBillablePer += CType(Args.DataReader("Billable%"), Double)

            ' Added By NitinVs on 20 July 2005 for WhizibleSEM SP4 
            m_GrandInstallCapacity += CType(Args.DataReader("InstallCapacityHrs"), Double)
            m_GrandTotalCapacity += CType(Args.DataReader("CapacityHrs"), Double)
            m_GrandTotalAllocated += CType(Args.DataReader("AllocatedHrs"), Double)
            m_GrandTotalActual += CType(Args.DataReader("ActualHrs"), Double)
            m_GrandTotalBillable += CType(Args.DataReader("BillableHrs"), Double)
            ' End Addition By NitinVS on 20 July 2005 for whizibleSEM SP4 

        End If

    End Sub

    Private Sub objListGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objListGrid.DataRowTD_BeforePrint
        If Args.ColIndex = 0 Then 'if first column(Month)

            'Determine stylesheet for row
            If Args.NoOfRowsPrinted Mod 2 = 0 Then
                'While cancelling TD, TR will also get cancelled. hence add <TR>, grid class will close it.
                'Modified by VarunA on 1-Oct-2008 IssueID-22531
                'Purpose : To have proper alignment between rows in Mozilla.
                'Args.StringToBeInserted = "<TR class='clsTREven'><TD align='left'></TD>"
                Args.StringToBeInserted = "<td name=toDel id=toDel></TD></TR><TR class='clsTREven'><TD align='left'></TD>"
                'End by VarunA on 1-Oct-2008 IssueID-22531
            Else
                'Modified by VarunA on 1-Oct-2008 IssueID-22531
                'Purpose : To have proper alignment between rows in Mozilla.
                'Args.StringToBeInserted = "<TR class='clsTROdd'><TD align='left'></TD>"
                Args.StringToBeInserted = "<td name=toDel id=toDel></TD></TR><TR class='clsTROdd'><TD align='left'></TD>"
                'End by VarunA on 1-Oct-2008 IssueID-22531
            End If
            Cancel = True
        End If
    End Sub

    Private Sub objListGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles objListGrid.SummaryFunctionsTR_BeforePrint
        If m_GroupTotalCapacity >= 0 Then
            m_intCount = m_intCount + 1

            ' Modified By NitinVS on 20 July 2005 for whizibleSEM SP4 
            ' Percentage Is To Be Shown and not Average of Percentage 
            'Insert sum for the Month
            Args.StringToBeInserted = "<TR class='clsTRSectionHeader' ><TD align='left' colspan=2><FONT color=blue> " + MyBase.GetResourceString("TOTALCAPTION") + "  " + m_strMonth + "</FONT></TD>"
            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupInstallCapacity.ToString("N2") + "</FONT></TD>"
            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalCapacity.ToString("N2") + "</FONT></TD>"

            'Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalCapacityPer / m_intCount).ToString("N2") + "</FONT></TD>"
            If m_GroupInstallCapacity <> 0 And m_GroupTotalCapacity <> 0 Then
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalCapacity * 100 / m_GroupInstallCapacity).ToString("N2") + "</FONT></TD>"
            Else
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
            End If

            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalAllocated.ToString("N2") + "</FONT></TD>"

            'Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalAllocatedPer / m_intCount).ToString("N2") + "</FONT></TD>"
            If m_GroupTotalCapacity <> 0 And m_GroupTotalAllocated <> 0 Then
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalAllocated * 100 / m_GroupTotalCapacity).ToString("N2") + "</FONT></TD>"
            Else
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
            End If

            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalActual.ToString("N2") + "</FONT></TD>"

            'Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalActualPer / m_intCount).ToString("N2") + "</FONT></TD>"
            If m_GroupTotalCapacity <> 0 And m_GroupTotalActual <> 0 Then
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalActual * 100 / m_GroupTotalCapacity).ToString("N2") + "</FONT></TD>"
            Else
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
            End If

            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalBillable.ToString("N2") + "</FONT></TD>"
            'Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalBillablePer / m_intCount).ToString("N2") + "</FONT></TD></TR>"
            If m_GroupTotalCapacity <> 0 And m_GroupTotalBillable <> 0 Then
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalBillable * 100 / m_GroupTotalCapacity).ToString("N2") + "</FONT></TD></TR>"
            Else
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
            End If
            ' End Modification By NitinVS on 20 July 2005 for WhizibleSEM SP4  

        End If
    End Sub

    Private Sub objListGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles objListGrid.ColumnHeaderTR_BeforePrint
        Args.StringToBeInserted = "<TR class='clsTRColumnHeader' ><TD align='center' colspan=2>&nbsp;</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=1>" + MyBase.GetResourceString("HEADER_INSTALLCAPACITY") + "</TD>"
        'Modified By NitinVs on 20 july 2005 for WhizibleSEM SP4 
        ' If Project is selected then show the Booked hrs 
        'If m_strProjectID <> "" And m_strProjectID <> "NULL" Then
        '    Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_BOOKED") + "</TD>"
        'Else
        '    Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_CAPCITY") + "</TD>"
        'End If
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_CAPCITY") + "</TD>"
        ' End Modification By NitinVs on 20 july 2005 for WhizibleSEM SP4  

        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_ALLOCATED") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_ACTUAL") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_BILLABLE") + "</TD></TR>"

    End Sub

    Private Sub objListSummaryGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objListSummaryGrid.DataRowTR_BeforePrint
        ' Added By NitinVs on 20 July 2005 for WhizibleSEM SP4 
        m_GrandInstallCapacity += CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("InstallCapacityHrs"), "0"), "0"), Double)
        m_GrandTotalCapacity += CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("CapacityHrs"), "0"), "0"), Double)
        m_GrandTotalAllocated += CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("AllocatedHrs"), "0"), "0"), Double)
        m_GrandTotalActual += CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ActualHrs"), "0"), "0"), Double)
        m_GrandTotalBillable += CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("BillableHrs"), "0"), "0"), Double)

        ' End Addition By NitinVS on 20 July 2005 for whizibleSEM SP4 
    End Sub

    Private Sub objListSummaryGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles objListSummaryGrid.ColumnHeaderTR_BeforePrint
        Args.StringToBeInserted = "<TR class='clsTRColumnHeader' ><TD align='center' colspan=1>&nbsp;</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=1>" + MyBase.GetResourceString("HEADER_INSTALLCAPACITY") + "</TD>"
        'Modified By NitinVs on 20 july 2005 for WhizibleSEM SP4 
        ' If Project is selected then show the Booked hrs 
        'If m_strProjectID <> "" And m_strProjectID <> "NULL" Then
        '    Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_BOOKED") + "</TD>"
        'Else
        '    Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_CAPCITY") + "</TD>"
        'End If
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_CAPCITY") + "</TD>"
        ' End Modification By NitinVs on 20 july 2005 for WhizibleSEM SP4  

        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_ALLOCATED") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_ACTUAL") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_BILLABLE") + "</TD></TR>"
    End Sub

    ' Added By NitinVS on 20 July 2005 for WhizibleSEM SP4 
    ' The Percentage is to be shown and not average.
    Private Sub objListGrid_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles objListGrid.SummaryFunctionsTD_BeforePrint
        If Args.ColIndex = 0 Then
            Cancel = True
            Args.StringToBeInserted = "<TD align=right> Grand Total</TD>"
        End If

        If Args.ColIndex = 4 Then
            Cancel = True
            If m_GrandInstallCapacity <> 0 And m_GrandTotalCapacity <> 0 Then
                Args.StringToBeInserted = "<TD align=right> " + (m_GrandTotalCapacity * 100 / m_GrandInstallCapacity).ToString("N2") + "</TD>"
            Else
                Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
            End If

        End If


        If Args.ColIndex = 6 Then
            Cancel = True
            If m_GrandTotalCapacity <> 0 And m_GrandTotalAllocated <> 0 Then
                Args.StringToBeInserted = "<TD align=right> " + (m_GrandTotalAllocated * 100 / m_GrandTotalCapacity).ToString("N2") + "</TD>"
            Else
                Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
            End If
        End If

        If Args.ColIndex = 8 Then
            Cancel = True
            If m_GrandTotalCapacity <> 0 And m_GrandTotalActual <> 0 Then
                Args.StringToBeInserted = "<TD align=right> " + (m_GrandTotalActual * 100 / m_GrandTotalCapacity).ToString("N2") + "</TD>"
            Else
                Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
            End If
        End If

        If Args.ColIndex = 10 Then
            Cancel = True
            If m_GrandTotalCapacity <> 0 And m_GrandTotalBillable <> 0 Then
                Args.StringToBeInserted = "<TD align=right> " + (m_GrandTotalBillable * 100 / m_GrandTotalCapacity).ToString("N2") + "</TD>"
            Else
                Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
            End If
        End If

        ' End Addition By  NitinVS on 20 July 2005 for WhizibleSEM SP4 

    End Sub
    ' Added By NitinVS on 20 July 2005 for WhizibleSEM SP4 
    ' The Percentage is to be shown and not average.
    Private Sub objListSummaryGrid_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles objListSummaryGrid.SummaryFunctionsTD_BeforePrint
        If Args.ColIndex = 0 Then
            Cancel = True
            Args.StringToBeInserted = "<TD align=right> Grand Total</TD>"
        End If
        If Args.ColIndex = 3 Then
            Cancel = True
            If m_GrandInstallCapacity <> 0 And m_GrandTotalCapacity <> 0 Then
                Args.StringToBeInserted = "<TD align=right> " + (m_GrandTotalCapacity * 100 / m_GrandInstallCapacity).ToString("N2") + "</TD>"
            Else
                Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
            End If

        End If


        If Args.ColIndex = 5 Then
            Cancel = True
            If m_GrandInstallCapacity <> 0 And m_GrandTotalAllocated <> 0 Then
                Args.StringToBeInserted = "<TD align=right> " + (m_GrandTotalAllocated * 100 / m_GrandTotalCapacity).ToString("N2") + "</TD>"
            Else
                Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
            End If
        End If

        If Args.ColIndex = 7 Then
            Cancel = True
            If m_GrandInstallCapacity <> 0 And m_GrandTotalActual <> 0 Then
                Args.StringToBeInserted = "<TD align=right> " + (m_GrandTotalActual * 100 / m_GrandTotalCapacity).ToString("N2") + "</TD>"
            Else
                Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
            End If
        End If

        If Args.ColIndex = 9 Then
            Cancel = True
            If m_GrandInstallCapacity <> 0 And m_GrandTotalBillable <> 0 Then
                Args.StringToBeInserted = "<TD align=right> " + (m_GrandTotalBillable * 100 / m_GrandTotalCapacity).ToString("N2") + "</TD>"
            Else
                Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
            End If
        End If

        ' End Addition By  NitinVS on 20 July 2005 for WhizibleSEM SP4 
    End Sub
    ''Added by Yogesh J on 11-Feb-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_GenerateReport(EmployeeID As String, BUID As String, OUID As String, DUID As String, ProjectID As String, ResourceID As String, DateRangeID As String, PROJECTREPORT As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(BUID, String) + CType(OUID, String) + CType(DUID, String) + CType(ProjectID, String) + CType(ResourceID, String) + CType(DateRangeID, String) + CType(PROJECTREPORT, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    ''End of addition by Yogesh J on 11-Feb-2016
End Class
