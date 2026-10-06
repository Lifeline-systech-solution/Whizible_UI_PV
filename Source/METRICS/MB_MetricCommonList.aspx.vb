'Imports Whizible

Public Class MB_MetricCommonList
    Inherits WebPage.Templates.WhizTemplate
    'Inherits CommonList 'WebPage.Templates.WhizTemplate

#Region "Variable Declaration "

    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid

    Protected m_strMode As String
    Protected m_strSnapShotDate As String
    Protected m_strFromDate As String
    Protected m_strToDate As String
    Protected m_strAction As String
    Protected m_blnDone As Boolean = False
    Protected m_lngRecordCount As Long
    Protected m_Pendingmeasurements As Long

    Private m_blnLowerMenu As Boolean = False
    Private m_blnFirstRow As Boolean = True

    Protected ALProject As New ArrayList
    Protected index As Integer
#End Region

#Region " Constructor "
    Public Sub New()
        ''Commented and Added by Yogesh Jalamkar on 10-OCT-2016 Purpose:Sql injection and Cross Site Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of addition by Yogesh Jalamkar on 10-OCT-2016 
        MyBase.InitializeResources("AppResourcePPM.MB_MetricCommonList", "AppResourcePPM")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
#End Region

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
    'Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
    '    'MyBase.strListPage = "MB_MetricCommonList_CommonList.aspx"
    '    'MyBase.strFormPage = "MB_MetricCommonList_CommonPage.aspx"
    '    ''eral/MB_MetricCommonList_CommonSubTag.aspx"
    '    ''Put user code to initialize the page here
    '    'MyBase.Page_Load(sender, e)


    'End Sub
    Protected Sub Init_Page()
        ' If CommonFunctions.General.CheckIsNothing(Request.QueryString("CMode"), "").ToString <> "REGEN" Then


        '--------------------------------
        InitVariables()
        '--------------------------------
        If m_Pendingmeasurements > 0 Then
            Call ValidatePendingMeaasurementData()
        Else
            ProcessMigration_N_Calculation()
            '--------------------------------
            Page_Draw()
        End If
        'End If
    End Sub
    Private Sub Page_Draw()
        '=====================================================================
        ' Procedure Name        : Page_Draw()	
        ' Purpose               : ITo draw page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : 02/08/2005
        ' Revisions             : 1.0  
        '=====================================================================
        'CommonFunctions.General.WriteHTML("<DIV id='DivMain' name='DivMain' style='Overflow:auto;height::350;width:100%;'>")
        '------Draw upper menu -------------
        DrawMenu()
        CommonFunctions.General.WriteHTML("<BR>")
        '------Diaplay page heading -------------
        DrawPageCaption()
        CommonFunctions.General.WriteHTML("<BR>")
        '------Draw grid -------------------
        DrawGrid()
        CommonFunctions.General.WriteHTML("<BR>")
        '------print totalno of records----------
        CommonFunctions.General.WriteHTML("<TABLE Class=clsTable Width='100%' cellpadding=0 cellspacing=0><TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD valign='Top' align='right'>")
        CommonFunctions.General.WriteHTML("Total Records :" & m_lngRecordCount)
        CommonFunctions.General.WriteHTML("</TD></TR></TABLE>")

        '----------------------------------------
        ' CommonFunctions.General.WriteHTML("</DIV>")
        '------Draw lower menu--------------
        DrawMenu()
    End Sub

    Private Sub ValidatePendingMeaasurementData()
        '=====================================================================
        ' Procedure Name        : ValidatePendingData()	
        ' Purpose               : To Inform user if any project having Measurements to be updated manually does not have the 
        '                         the value for the selected snapshotdate
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : 02/08/2005
        ' Revisions             : 1.0  
        '=====================================================================
        Dim strSQL As String

        '------Draw upper menu -------------
        DrawMenu()
        CommonFunctions.General.WriteHTML("<BR>")
        '------Diaplay page heading -------------
        DrawPageCaption()
        CommonFunctions.General.WriteHTML("<BR>")
        '------Draw grid -------------------

        ' Show the Note for Pending Project Measurements 
        CommonFunction.General.WriteHTML("<Table  border=0 cellspacing=0 cellpadding=0 width='99.9%' class='clsTable'>")
        CommonFunction.General.WriteHTML("<TR class='clsTROdd'><TD  align='Left' >")
        CommonFunction.General.WriteHTML("<I>" + MyBase.GetResourceString("NOTE_PENDINGMEASUREMENTS") + " " + CommonFunctions.Dates.GetDate(m_strSnapShotDate) + "<I>")
        CommonFunction.General.WriteHTML("</TD></TR></TABLE>")


        '----------To store the column Headings(user friendly name)-------
        Dim arrColumnHeadingList() As String = {CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("COL_PROJECT_NAME"), "Project") _
                                                , CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("COL_EXPECTED_START_DATE"), "Start Date") _
                                                , CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("COL_EXPECTED_END_DATE"), "End Date") _
                                                }

        '---------Atual column name  -------------------------------------
        Dim arrActualColumnNames() As String = {"ProjectName", "ExpectedStartDate", "ExpectedEndDate", "projectID"}
        '-----------------------------------------------------------------
        Dim arrCheckBoxId() As String = {"", "", ""}
        '---------To store the link details while clicking on Links in grid---
        Dim arrColRowLinks() As String = {"Update_Measurement(projectID)", "", ""}
        '-----------------------------------------------------------------
        Dim arrTDStyle() As String = {"align=left", "align=left", "align=left"}
        '-----------------------------------------------------------------
        strSQL = "usp_sel_Project_having_Pending_External_Measurements " + Session("intProjectID").ToString + ",'" + m_strSnapShotDate + "'"
        '-----------------------------------------------------------------

        ' CommonFunctions.General.WriteHTML("<DIV id='DivList' style='Overflow:auto;width=100%;Height:350'>")
        ''''Added By Vaijat K On 06/10/2015
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''''End Added By Vaijat K On 06/10/2015
        With m_objGrid
            .ActualColumnArray = arrActualColumnNames
            .UserFriendlyColumnArray = arrColumnHeadingList
            .CheckBoxIDArray = arrCheckBoxId
            .RowLinkArray = arrColRowLinks
            .NoOfDataColumns = 3
            .TDStyleArray = arrTDStyle
            .ColNameToolTipOnEachRow = True
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            .PrimaryKey = "HistoryID"
            .DIVHeight = 300
            '''' Added By Vaijat K On 06/10/2015
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''''End Added By Vaijat K On 06/10/2015
            .DrawGrid()

            m_lngRecordCount = .NoOfRows
        End With
        m_objGrid = Nothing
        ' CommonFunctions.General.WriteHTML("</DIV>")

        '------Draw upper menu -------------
        CommonFunctions.General.WriteHTML("<BR><BR>")
        DrawMenu()

    End Sub
#End Region

    Private Sub InitVariables()
        m_strMode = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CMode"))
        m_strSnapShotDate = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SnapShotDate"))
        m_strFromDate = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromDate"))
        m_strToDate = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ToDate"))
        m_strAction = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CAction"))
        m_Pendingmeasurements = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Pendingmeasurements"), "0"), Long)
        ' m_lngRecordCount = CLng(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PRS_MetricHistory_SnapShot 1", True), "0"))

    End Sub

#Region " DataBase Functions "

    Private Sub ProcessMigration_N_Calculation()
        Dim strXMLString As String = ""
        If m_strAction.ToUpper = "MGRT" Then
            'SrikanthY on 19 Jun 2007 , uncommented , Finally , comment this and uncomment below code 
            'to move Generation logic to Service
            '''m_blnDone = MeasurementDataMigration(m_strSnapShotDate, m_strFromDate, m_strToDate)
            '''m_blnDone = MetricCalculation(m_strSnapShotDate, m_strFromDate, m_strToDate)
            '''If m_blnDone = True Then
            '''    strXMLString = "<root><Done>true</Done></root>"
            '''Else
            '''    strXMLString = "<root><Done>false</Done></root>"
            '''End If
            'End of Commnets by SrikanthY on 19 Jun 2007

            'Added by SrikanthY on 19 Jun 2007 to move Generation Logic To Service
            Dim strSQL As String
            strSQL = " USP_INS_TBL_MET_METRIC_GENERATEDATA_QUEUE  '" & m_strSnapShotDate & "','" & m_strFromDate & "','" & m_strToDate & "'," & Session("intProjectID").ToString
            CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            Response.Write("<script>alert(""SnapshotDate has been saved in Queue , Data will be Generated through Service in regular intervals !"")</script>")
            'End of addition by SrikanthY on 19 Jun 2007

            'Response.Clear()
            'Response.Write(strXMLString)
        ElseIf m_strAction.ToUpper = "GALL" Then
            m_blnDone = GenarateAll()
        End If
    End Sub
    Private Function GenarateAll() As Boolean
        Dim strSQLQuery As String
        Dim blnUseSQL As Boolean
        Dim drPendingList As IDataReader
        Dim strSnapShotDate As String, strFromDate As String, strToDate As String

        strSQLQuery = "usp_sel_tbl_PRS_MetricHistory_SnapShot " + Session("intProjectID").ToString
        blnUseSQL = MyBase.UseSQL

        Try
            drPendingList = CommonFunctions.Data.GetDataReader(strSQLQuery, blnUseSQL)
            While drPendingList.Read
                strSnapShotDate = CommonFunctions.Data.CheckIsDBNull(drPendingList("SnapShotDate"))
                strFromDate = CommonFunctions.Data.CheckIsDBNull(drPendingList("FromDate"))
                strToDate = CommonFunctions.Data.CheckIsDBNull(drPendingList("ToDate"))
                If IsDate(strSnapShotDate) And IsDate(strFromDate) And IsDate(strToDate) Then
                    MeasurementDataMigration(strSnapShotDate, strFromDate, strToDate)
                    MetricCalculation(strSnapShotDate, strFromDate, strToDate)
                End If
            End While
        Catch ex As Exception
        Finally
            CommonFunctions.Data.DisposeDataReader(drPendingList)
        End Try

    End Function
    Private Function MetricCalculation(ByVal strSnapShotDate As String, ByVal strFromDate As String, ByVal strToDate As String) As Boolean
        Dim blnUseSQL As Boolean
        Dim strSQLQuery As String

        Try

            blnUseSQL = MyBase.UseSQL

            strSQLQuery = "usp_ins_tbl_PRS_MetricHistory_Calculation  '" & strSnapShotDate & "','" & strFromDate _
                            & "','" & strToDate & "'"

            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, blnUseSQL)

            MetricCalculation = True
        Catch ex As Exception
            MetricCalculation = False
        Finally
        End Try
    End Function
    Private Function MeasurementDataMigration(ByVal strSnapShotDate As String, ByVal strFromDate As String, ByVal strToDate As String) As Boolean
        Dim strSQLQuery As String
        Try
            'AbhijitD 10-Nov-06 Renamed the procedure to more appropriate name
            'strSQLQuery = "usp_sel_tbl_PRS_Measurements_ForMigration  '" & strSnapShotDate & "','" & strFromDate & "','" & strToDate & "'"
            strSQLQuery = "Exec usp_ins_tbl_PRS_Measurements_History_Calculation  '" & strSnapShotDate & "','" & strFromDate & "','" & strToDate & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)

            MeasurementDataMigration = True
        Catch ex As Exception
            MeasurementDataMigration = False
        Finally
        End Try
    End Function
    'Private Function MeasurementDataMigration(ByVal strSnapShotDate As String, ByVal strFromDate As String, ByVal strToDate As String) As Boolean
    '    Dim strSourceConnection As String
    '    Dim blnUseSQL As Boolean
    '    Dim strConnectionID As String
    '    Dim strSQLQuery As String
    '    Dim drSource As IDataReader
    '    Dim drTran As IDataReader
    '    Dim strQueryToExecute As String
    '    Dim strErrorNo As String, strErrorDes As String, strMCode As String, strProjectID As String
    '    Dim strBeginTran As String, strCommitTran As String, strRollBackTran As String


    '    Try
    '        '----Initialise Local Param--------------------------------------------------
    '        blnUseSQL = MyBase.UseSQL
    '        strSQLQuery = "SELECT ConnectionID FROM v_tbl_QRB_Connection_Master_ConnectionID"
    '        'Code commented on 10 Oct,2005 by SandeepA
    '        'strConnectionID = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery, blnUseSQL))
    '        'strSQLQuery = "usp_sel_tbl_QRB_Connection_Master_GetConnectionString  " & strConnectionID
    '        'strSourceConnection = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery, blnUseSQL))
    '        'End of comment by sandeepa

    '        'Added By SandeepA on 10 Oct,2005 : For other database connection string
    '        'Get the Encrypted connection strin from Web.config
    '        strSourceConnection = CType(CommonFunctions.General.GetApplicationKeySetting("OtherDatabaseConnectionString"), String)
    '        'decrypt the connection string
    '        strSourceConnection = CStr(CommonFunctions.General.BuildConnectionString(strSourceConnection))
    '        'End of addition  by SandeepA on 10 Oct,2004

    '        strErrorNo = "0"
    '        strErrorDes = "No Error"
    '        strBeginTran = "BEGIN TRAN MeasurementTran"
    '        strCommitTran = "COMMIT TRAN MeasurementTran"
    '        strRollBackTran = "ROLLBACK TRAN MeasurementTran"
    '        '----END Initialise Local Param----------------------------------------------

    '        '----Fetching data from source
    '        strSQLQuery = "usp_sel_tbl_PRS_Measurements_ForMigration  '" & strSnapShotDate & "','" & strFromDate & "','" & strToDate & "'"
    '        drSource = CommonFunctions.Data.GetDataReader(strSQLQuery, blnUseSQL, strSourceConnection)
    '        '----Start Transection ------------------------------------------------------
    '        'CommonFunctions.Data.GetDataScalar(strBeginTran, strUseSQL)
    '        Do
    '            drSource.Read()
    '            strErrorNo = CType(CommonFunctions.Data.CheckIsDBNull(drSource("ErrorCode"), ""), String)
    '            If strErrorNo = "0" Then
    '                strQueryToExecute = CommonFunctions.Data.CheckIsDBNull(drSource("Query"), "SELECT 1")
    '                'Execute query to ppm
    '                CommonFunctions.Data.InsertOrUpdateData(strQueryToExecute, blnUseSQL)
    '            Else
    '                strErrorDes = CommonFunctions.Data.CheckIsDBNull(drSource("Query"), "Description Not Found")
    '                strMCode = CommonFunctions.Data.CheckIsDBNull(drSource("MCode"), "")
    '                strProjectID = CStr(CommonFunctions.Data.CheckIsDBNull(drSource("ProjectID"), "0"))
    '                strSQLQuery = "INSERT INTO tbl_PRS_Measurements_Log" _
    '                            & "(MeasurementCode, ProjectId, SnapShotDate, ErrorNumber, ErrorMessage) VALUES" _
    '                            & "('" & strMCode & "'," & strProjectID & ",'" & strSnapShotDate _
    '                            & "', " & strErrorNo & ",'" _
    '                            & strErrorDes & "') "
    '                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, blnUseSQL)
    '            End If
    '        Loop While drSource.NextResult
    '        '----Commit Transection
    '        'CommonFunctions.Data.GetDataScalar(strCommitTran, strUseSQL)
    '        MeasurementDataMigration = True
    '    Catch ex As Exception
    '        '----RollBack Transection
    '        '   CommonFunctions.Data.GetDataScalar(strRollBackTran, strUseSQL)
    '        MeasurementDataMigration = False
    '    Finally
    '        CommonFunctions.Data.DisposeDataReader(drSource)
    '    End Try
    'End Function
#End Region

#Region " Menu, Grid and PageCaption"
    Private Sub DrawMenu()
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : 04/10/2005
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList
        Dim arrMenuToolTipsList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strMenu As String                           'Used to store the Menu List as HTML

        If m_Pendingmeasurements = 0 Then
            ' TO DO Commented for timebeing as external values may not be updated for many projects as discussed with vidyaJ 
            'arrMenuCaptionsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_GENERATE_ALL"), "Generate All"))
            'arrMenuToolTipsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_GENERATE_ALL_TOOLTIP"), "Generate All"))
            'arrClientSideFunctionList.Add("GenerateAll_OnClick()")
        Else
            arrMenuCaptionsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_GENERATE"), "Generate"))
            arrMenuToolTipsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_GENERATE_TOOLTIP"), "Generate"))
            arrClientSideFunctionList.Add("Generate_OnClick('" + m_strSnapShotDate + "','" + m_strFromDate + "','" + m_strToDate + "',0" + ")")
        End If

        arrMenuCaptionsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_BACK"), "Back"))
        arrMenuToolTipsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_BACK_TOOLTIP"), "Back"))
        arrClientSideFunctionList.Add("Back_OnClick()")

        arrMenuCaptionsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MNU_HELP"), "Help"))
        arrMenuToolTipsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MNU_HELP_TOOLTIP"), "Help"))
        arrClientSideFunctionList.Add("Help_OnClick('UPDATE METRICS')")

        m_objMenu = New WebPages.Template.StaticMenu
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        CommonFunctions.General.WriteHTML(strMenu)

    End Sub

    Private Sub DrawGrid()
        '=====================================================================
        ' Procedure Name        : DrawGrid()	
        ' Purpose               : Plots the grid displaying pending measurement data
        ' Returns               : None
        ' Author                : HarshK
        ' Created               : 04/10/2005
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String
        Dim strTempEmployeeID As String, strTempStatusCode As String, strTempDateID As String, strTempLastID As String
        Dim strTempsortby As String, strTempsortorder As String

        '----------To store the column Headings(user friendly name)-------
        Dim arrColumnHeadingList() As String = {CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("COL_SNAPSHOT_DATE"), "Snap Shot Date") _
                                                , CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("COL_FROM_DATE"), "From Date") _
                                                , CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("COL_TO_DATE"), "To Date") _
                                                , CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("COL_STATUS"), "Status") _
                                                }

        '---------Atual column name  -------------------------------------
        Dim arrActualColumnNames() As String = {"SnapShotDate" _
                                                , "FromDate" _
                                                , "ToDate" _
                                                , "Status" _
                                                , "PendingMeasurement" _
                                                }
        '-----------------------------------------------------------------
        Dim arrCheckBoxId() As String = {"", "", "", ""}
        '---------To store the link details while clicking on Links in grid---
        Dim arrColRowLinks() As String = {"" _
                                            , "" _
                                            , "" _
                                            , "Status_OnClick(SnapShotDate,FromDate,ToDate,PendingMeasurement)" _
                                            }
        '-----------------------------------------------------------------
        Dim arrTDStyle() As String = {"align=left" _
                                            , "align=left" _
                                            , "align=left" _
                                            , "align=left" _
                                            }
        '-----------------------------------------------------------------
        strQuery = "usp_sel_tbl_PRS_MetricHistory_SnapShot " + Session("intProjectID").ToString
        '-----------------------------------------------------------------


        ' CommonFunctions.General.WriteHTML("<DIV id='DivList' style='Overflow:auto;width=100%;Height:350'>")
        ''''Added By Vaijat K On 06/10/2015
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''''End Added By Vaijat K On 06/10/2015
        With m_objGrid
            .ActualColumnArray = arrActualColumnNames
            .UserFriendlyColumnArray = arrColumnHeadingList
            .CheckBoxIDArray = arrCheckBoxId
            .RowLinkArray = arrColRowLinks
            .NoOfDataColumns = 5
            '.ClientSideSortFunctionName = "Sort_OnClick" ' without param. and brackets
            .TDStyleArray = arrTDStyle
            '.DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            '.DIVID = "DivList"
            '.DIVHeight = 0
            .SQL = strQuery
            '.SortBy = S
            '.SortOrder = strTempsortorder
            .UseSQL = MyBase.UseSQL
            .PrimaryKey = "HistoryID"
            '.FooterHTML = sbFooterHTML.ToString
            .DIVHeight = 300
            ''''Added By Vaijat K On 06/10/2015
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode

            ''''End Added By Vaijat K On 06/10/2015

            .DrawGrid()

            m_lngRecordCount = .NoOfRows
        End With
        m_objGrid = Nothing
        ' CommonFunctions.General.WriteHTML("</DIV>")

    End Sub

    Private Sub DrawPageCaption()
        WebPages.Template.PageCaption.GetPageCaptions(, CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("PAGE_CAPTION"), "Update Metric Data"), , )
    End Sub

#End Region

#Region " Generic Functions "
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
        ' Author                : HarshK
        ' Created               : 04/10/2005
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
#End Region


    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Select Case Args.DataField.ToUpper
            Case "STATUS"
                If m_strMode = "PND" Then
                    'shoe generate link on first recourd in pending mode
                    If m_blnFirstRow = True Then
                        m_blnFirstRow = False
                    Else
                        Args.EnableLink = False
                    End If

                End If
        End Select
    End Sub

End Class

