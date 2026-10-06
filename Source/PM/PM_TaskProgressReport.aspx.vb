Public Class PM_TaskProgressReport
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Class	Name	        :	PM_TaskProgressReport
    ' Purpose				:	The class generates the UI for the Task Progress report
    '                           and generates the report for the parameters    
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	UmeshJ
    ' Created				:	March 23, 2004
    ' Revisions				:	
    '=====================================================================
    Protected m_strFileName As String           ' will be used at client side
    Protected m_intShowMessage As Integer = 0   ' will be used at client side
    Private m_lngReportID As Long
    Private m_strReportName As String
    Private m_blnUseSQL As Boolean
    Const COMBOBOX As Integer = 1
    Const DATECONTROL As Integer = 2
    Const TEXTBOX As Integer = 3
    Const CHECKBOX As Integer = 4
    Const LISTBOX As Integer = 5
    Private WithEvents oRpt As AdHocReports.Report.AdHocReport
    'Added by MahendraV On 10:37 AM 5/24/2007 for List of Reports modified for HTML Report Issue
    'Start_MV_5/24/2007
    Protected m_intOpenReportInSecurePage As Integer = 0
    'End_MV_5/24/2007
    Enum valueSign
        ZERO
        NEGATIVE
        POSITIVE
    End Enum

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


    Sub New()
        ' initialize the resource file for culture implementation
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
        ' MyBase.ApplySecurity(False, 2)
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True, 2)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting


    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        Dim strFilePath As String
        Dim strFormat As String
        Dim strSQL As String
        Dim intLoopCtr As Integer
        Dim strControls As String
        Dim strDataTypes As String
        Dim strParamOrder As String
        Dim strCaptions As String
        Dim strMasterTableID As String
        Dim dr As IDataReader

        ' the report id
        m_lngReportID = 996 'TASK_PROGRESS_REPORT = 996
        ' use sql?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        If Page.IsPostBack Then

            ' get the controls, their data types & actual param order from request querystring
            strControls = Request.QueryString("Controls")
            strDataTypes = Request.QueryString("DataTypes")
            strParamOrder = Request.QueryString("ActualPosition")
            strCaptions = Request.QueryString("Captions")
            strMasterTableID = Request.QueryString("MasterTableID")

            If Trim(Request.QueryString("Mode") & "").ToUpper = "VIEW" Then
                strFormat = Trim(Request.QueryString("Format") & "").ToUpper
                strSQL = GetReportSQL(m_lngReportID, strControls, strDataTypes, strParamOrder, strCaptions, strMasterTableID, GetEmptyValueReplacement(m_lngReportID, strFormat))
                dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                If dr.Read Then
                    ' The reports are created in the "Reports" folder
                    strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Reports/"))
                    ' get a unique file name
                    m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName.Trim
                    ' add extn to file name based on format requested
                    Select Case strFormat
                        Case "PDF" : m_strFileName += ".pdf"
                        Case "HTML" : m_strFileName += ".htm"
                        Case "RTF" : m_strFileName += ".rtf"
                        Case "EXCEL" : m_strFileName += ".xls"
                        Case "CSV" : m_strFileName += ".csv"
                        Case "TEXT" : m_strFileName += ".txt"
                        Case "XML" : m_strFileName += ".xml"
                        Case Else : m_strFileName += ".pdf"
                    End Select
                    ' create object of Adhoc reports
                    oRpt = New AdHocReports.Report.AdHocReport(m_lngReportID, strSQL, CommonFunctions.Application.ConnectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log/")))
                    With oRpt
                        .UseMSSQL = m_blnUseSQL
                        .DefaultLCID = CType(MyBase.DefaultUILCID, Integer)
                        .LCID = MyBase.CurrentThreadUICultureID
                        If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                            .UseHashTables = True
                        Else
                            .UseHashTables = False
                        End If
                        .UIParameters = strCaptions
                        .UIParametersDelimiter = "|"
                        '.WatermarkImageFilePath = ""
                        .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                        .CompanyName = CommonFunctions.Application.CompanyName
                        .GraphImageGenerationAbsolutePath = Server.MapPath("../../Images/")

                        ' generate the report in requested format
                        Select Case strFormat
                            Case "PDF" : .GenerateReport(AdHocReports.Format.PDF)
                            Case "HTML" : .GenerateReport(AdHocReports.Format.HTML)
                            Case "RTF" : .GenerateReport(AdHocReports.Format.RTF)
                            Case "EXCEL" : .GenerateReport(AdHocReports.Format.EXCEL)
                            Case "CSV" : .GenerateReport(AdHocReports.Format.CSV)
                            Case "TEXT" : .GenerateReport(AdHocReports.Format.TEXT)
                            Case "XML" : .GenerateReport(AdHocReports.Format.XML)
                            Case Else : .GenerateReport(AdHocReports.Format.PDF)
                        End Select
                    End With
                    oRpt = Nothing
                    'Added by PrashantD on 21 Aug 2007 for WhizFrameWork SP8
                    m_strFileName = CommonFunctions.General.EncryptString(CommonFunctions.General.EncryptString(m_strFileName))
                    Response.Redirect("../CRW/CRW_ReportExport.aspx?FileName=" + m_strFileName, True)
                    'End of addition by PrashantD on 21 Aug 2007
                Else
                    ' set the flag here to show the message that there is no data
                    ' at the client side
                    m_intShowMessage = 1
                End If
                CommonFunction.Data.DisposeDataReader(dr)
            End If
        End If
        'Added by MahendraV On 10:37 AM 5/24/2007 for List of Reports modified for HTML Report Issue
        'Start_MV_5/24/2007
        If UCase(Trim(Request.QueryString("Format") & "")) = "HTML" Then

            If Not CommonFunctions.General.GetApplicationKeySetting("WAF_OpenReportsInSecurePage") Is Nothing Then
                If CType(CommonFunctions.General.GetApplicationKeySetting("WAF_OpenReportsInSecurePage"), Boolean) Then

                    m_intOpenReportInSecurePage = 1

                End If

            End If

        End If
        'End_MV_5/24/2007
    End Sub


    Protected Sub GenerateReportUI()
        '=====================================================================
        ' Procedure Name        : GenerateReportUI()
        ' Purpose               : To generate the Report UI and is called from
        '                         the .aspx page
        ' Description           : Calls the private class ReportUI to generate the
        '                         UI for the report
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : Class ReportUI
        ' Author                : Rajanikant
        ' Created               : October 15,2003
        ' Revisions             :
        '=====================================================================
        Dim oReportUI As AdHocReports.UI.ReportUI
        ' integrated by harshada d on 19092005 for issue id 266
        ' added by Harshada D on 05-08-2005 for show /hide EXCEL option according to web.config setting .
        Dim strExcel As String
        'here if this key WAF_CRW_FormatsToBeDisabled contain value "EXCEL" then excel option is drawn . 
        strExcel = CommonFunctions.General.GetApplicationKeySetting("WAF_CRW_FormatsToBeDisabled")
        '- removed option excel from  arrMenu,arrMenuToolTip ,arrClientSideFunction 
        If strExcel = "EXCEL" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PDF"), MyBase.GetResourceString("MENU_HTML"), MyBase.GetResourceString("MENU_RTF"), _
                                       MyBase.GetResourceString("MENU_CSV"), MyBase.GetResourceString("MENU_Text"), MyBase.GetResourceString("MENU_XML"), MyBase.GetResourceString("MENU_Help")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_PDF_TOOLTIP"), MyBase.GetResourceString("MENU_HTML_TOOLTIP"), MyBase.GetResourceString("MENU_RTF_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_CSV_TOOLTIP"), MyBase.GetResourceString("MENU_Text_TOOLTIP"), MyBase.GetResourceString("MENU_XML_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
            Dim arrCSFunctions() As String = {"ViewReport_OnClick('PDF')", "ViewReport_OnClick('HTML')", "ViewReport_OnClick('RTF')", "ViewReport_OnClick('CSV')", "ViewReport_OnClick('TEXT')", "ViewReport_OnClick('XML')", "Help_OnClick('CRW_HELP_" + m_lngReportID.ToString + "')"}
            ' build the UI
            oReportUI = New AdHocReports.UI.ReportUI
            oReportUI.UseMSSQL = m_blnUseSQL
            oReportUI.arrMenu = arrMenu
            oReportUI.arrMenuToolTip = arrMenuToolTip
            oReportUI.arrClientSideFunctions = arrCSFunctions
            oReportUI.LCID = MyBase.CurrentThreadUICultureID
            oReportUI.DefaultLCID = MyBase.DefaultUILCID
            oReportUI.Action_NavigationSchema = AdHocReports.UI.ReportUI.DynamicAction_NavigationSchema.CLASSICAL

        Else
            ' end of modfication by harshada d 
            ' end of integration by harshada d on 16092005
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PDF"), MyBase.GetResourceString("MENU_HTML"), MyBase.GetResourceString("MENU_RTF"), _
                                               MyBase.GetResourceString("MENU_EXCEL"), MyBase.GetResourceString("MENU_CSV"), MyBase.GetResourceString("MENU_Text"), MyBase.GetResourceString("MENU_XML"), MyBase.GetResourceString("MENU_Help")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_PDF_TOOLTIP"), MyBase.GetResourceString("MENU_HTML_TOOLTIP"), MyBase.GetResourceString("MENU_RTF_TOOLTIP"), _
                                              MyBase.GetResourceString("MENU_EXCEL_TOOLTIP"), MyBase.GetResourceString("MENU_CSV_TOOLTIP"), MyBase.GetResourceString("MENU_Text_TOOLTIP"), MyBase.GetResourceString("MENU_XML_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
            Dim arrCSFunctions() As String = {"ViewReport_OnClick('PDF')", "ViewReport_OnClick('HTML')", "ViewReport_OnClick('RTF')", "ViewReport_OnClick('EXCEL')", "ViewReport_OnClick('CSV')", "ViewReport_OnClick('TEXT')", "ViewReport_OnClick('XML')", "Help_OnClick('CRW_HELP_" + m_lngReportID.ToString + "')"}

            ' build the UI
            oReportUI = New AdHocReports.UI.ReportUI
            oReportUI.UseMSSQL = m_blnUseSQL
            oReportUI.arrMenu = arrMenu
            oReportUI.arrMenuToolTip = arrMenuToolTip
            oReportUI.arrClientSideFunctions = arrCSFunctions
            oReportUI.LCID = MyBase.CurrentThreadUICultureID
            oReportUI.DefaultLCID = MyBase.DefaultUILCID
            oReportUI.Action_NavigationSchema = AdHocReports.UI.ReportUI.DynamicAction_NavigationSchema.CLASSICAL


        End If

        oReportUI.SubmitToPage = "PM_TaskProgressReport.aspx"
        If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRWUI").Trim.ToUpper = "Y" Then
            oReportUI.UseHashTables = True
        Else
            oReportUI.UseHashTables = False
        End If
        oReportUI.GenerateUI(m_lngReportID)

        oReportUI = Nothing
    End Sub

#Region "Other Procedures"
    Private Function GetReportSQL(ByVal ReportID As Long, ByVal strControls As String, ByVal strDataTypes As String, ByVal strParamOrder As String, ByRef strCaptions As String, ByVal strMasterTableID As String, ByVal strEmptyValueReplacement As String) As String
        '=====================================================================
        ' Procedure Name        : GetReportSQL()
        ' Purpose               : To get the report SQL with parameters
        ' Description           : The proc. builds the SQL-> SP name with parameters
        '                         coming from the UI page to generate the report
        ' Parameters Passed     : Report ID,ByVal strControls As String, ByVal strDataTypes As String, ByVal strParamOrder As String
        ' Returns               : Report SQL 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : usp_CRW_GetUIParameterInformation/ hash tables
        ' Author                : Rajanikant
        ' Created               : October 18,2003
        ' Revisions             :
        '=====================================================================
        Dim arrControlNames() As String = {}
        Dim arrDataType() As String = {}
        Dim arrParamOrder() As String = {}
        Dim arrCaption() As String = {}
        Dim arrMasterTableID() As String = {}
        Dim blnNoParameters As Boolean
        Dim blnUseHashTables As Boolean = False
        Dim sbWhereClause As New System.Text.StringBuilder("")
        Dim sbUIParam As New System.Text.StringBuilder("")
        Dim intMin As Integer = 1
        Dim intMax, intLoopCtr, intPos, intUBound As Integer
        Dim intLCID As Integer
        Dim lngDefaultLCID As Long
        Dim dr As IDataReader
        Dim strSPName, strSPParameters As String
        Dim htUI() As AdHocReports.UI.cReportUI
        Dim htUIControl As AdHocReports.UI.cReportUI
        Dim htMaster As AdHocReports.ReportDefinition.Master
        Dim lngQueryID As Long


        Try
            If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" And CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRWUI").Trim.ToUpper = "Y" Then
                blnUseHashTables = True
                intLCID = MyBase.CurrentThreadUICultureID
                lngDefaultLCID = MyBase.DefaultUILCID
                ' get the values from hash tables
                If intLCID = lngDefaultLCID Then
                    htMaster = AdHocReports.HashTables.GetHashTableObject.GetHashTableMasterObject(ReportID)
                    htUI = AdHocReports.HashTables.GetHashTableObject.GetHashTableReportUIObject(ReportID)
                Else
                    htMaster = AdHocReports.HashTables.GetHashTableObject.GetHashTableMasterObject(ReportID.ToString + intLCID.ToString)
                    htUI = AdHocReports.HashTables.GetHashTableObject.GetHashTableReportUIObject(ReportID)
                    If htMaster Is Nothing Then
                        htMaster = AdHocReports.HashTables.GetHashTableObject.GetHashTableMasterObject(ReportID)
                        htUI = AdHocReports.HashTables.GetHashTableObject.GetHashTableReportUIObject(ReportID)
                    End If
                End If
                strSPName = htMaster.SPName : strSPParameters = htMaster.SPParameters
                lngQueryID = htMaster.QueryID
                If Not htUI Is Nothing Then
                    For Each htUIControl In htUI
                        If htUIControl.ParamOrder > intMax Then intMax = htUIControl.ParamOrder
                    Next
                Else
                    blnNoParameters = True
                End If
            Else
                blnUseHashTables = False
                ' get the values from the database
                dr = CommonFunctions.Data.GetDataReader("usp_CRW_GetUIParameterInformation " + ReportID.ToString, m_blnUseSQL)
                If dr.Read Then
                    strSPName = dr("SPName").ToString
                    strSPParameters = dr("SPParameters").ToString
                    If Not IsDBNull(dr("QueryID")) Then
                        lngQueryID = CType(dr("QueryID"), Long)
                    End If
                    If Not IsDBNull(dr("MaxParamNumber")) Then
                        intMax = CType(dr("MaxParamNumber"), Integer)
                    End If
                Else
                    blnNoParameters = True
                End If
                CommonFunction.Data.DisposeDataReader(dr)
                dr = Nothing
            End If
            ' get the array of controls
            If strControls.Trim <> "" Then
                arrControlNames = Split(Left(strControls, Len(strControls) - 1), ",")
            Else
                blnNoParameters = True
            End If
            ' get the array of data types
            If strDataTypes.Trim <> "" Then
                arrDataType = Split(Left(strDataTypes, Len(strDataTypes) - 1), ",")
            Else
                blnNoParameters = True
            End If
            If strParamOrder.Trim <> "" Then
                arrParamOrder = Split(Left(strParamOrder, Len(strParamOrder) - 1), ",")
            Else
                blnNoParameters = True
            End If
            If strCaptions.Trim <> "" Then
                arrCaption = Split(Left(strCaptions, Len(strCaptions) - 1), ",")
            Else
                blnNoParameters = True
            End If
            If strMasterTableID.Trim <> "" Then
                arrMasterTableID = Split(Left(strMasterTableID, Len(strMasterTableID) - 1), ",")
            End If

            ' the element count in array
            intUBound = UBound(arrParamOrder)
            If Not blnNoParameters Then
                For intLoopCtr = intMin To intMax
                    For intPos = 0 To intUBound
                        If CType(arrParamOrder(intPos), Integer) = CType(intLoopCtr, Integer) Then
                            If Trim(Request.Form(arrControlNames(intPos)) & "") = "" Then
                                sbWhereClause.Append(",NULL")
                                sbUIParam.Append(arrCaption(intPos) + ": " + strEmptyValueReplacement + "|")
                            Else
                                ' When  some value is entered then based on the datatype of the value the 
                                ' Value is appended to the Parameter list.For Non Numeric fields '' quotes are used
                                ' otherwise the parameter is passed as it is.
                                If Not (intPos < 0 Or intPos > UBound(arrDataType)) Then
                                    If Trim(arrDataType(intPos) & "") <> "" Then
                                        ' Based uopn the datatyp appending the parameter
                                        Select Case UCase(Trim((arrDataType(intPos) & "")))
                                            Case "INT", "FLOAT", "DOUBLE", "REAL", "DECIMAL", "NUMERIC", "CURRENCY", "MONEY", "SMALLINT", "TINYINT", "SMALLMONEY"
                                                ' The field value without single quotes(numeric values)
                                                sbWhereClause.Append("," & Trim(MyBase.GetFormValue(arrControlNames(intPos)) & "") & "")
                                                sbUIParam.Append(arrCaption(intPos) + ": " + GetMasterTableValue(arrMasterTableID(intPos), Trim(Request.Form(arrControlNames(intPos)) & ""), blnUseHashTables) + "|")
                                            Case "BIT"
                                                sbWhereClause.Append("," & Trim(MyBase.GetFormValue(arrControlNames(intPos)) & "") & "")
                                                sbUIParam.Append(arrCaption(intPos) + ": True|")
                                            Case Else
                                                ' The other Field values with single quotes 
                                                sbWhereClause.Append(",'" & Trim(MyBase.GetFormValue(arrControlNames(intPos)) & "") & "'")
                                                sbUIParam.Append(arrCaption(intPos) + ": '" + GetMasterTableValue(arrMasterTableID(intPos), Trim(Request.Form(arrControlNames(intPos)) & ""), blnUseHashTables) + "'|")
                                        End Select
                                    End If
                                End If
                                Exit For
                            End If
                        End If
                    Next intPos
                Next intLoopCtr
            End If
            ' set the reference variable value
            strCaptions = sbUIParam.ToString
            If Trim(sbWhereClause.ToString & "") <> "" Then
                ' removing the first comma inserted to make it into exact format needed
                If lngQueryID <> 0 Then
                    GetReportSQL = strSPName + " " + Session("intUserID").ToString + "," + Right(sbWhereClause.ToString & "", Len(sbWhereClause.ToString & "") - 1)
                Else
                    GetReportSQL = strSPName + " " + Right(sbWhereClause.ToString & "", Len(sbWhereClause.ToString & "") - 1)
                End If
            Else
                ' return the default SP & param with which the report was created
                GetReportSQL = strSPName + " " + strSPParameters
            End If

            ' clean up
            sbUIParam = Nothing
            sbWhereClause = Nothing
        Catch exc As Exception
            exc.Source = "ReportUIBuilder->GetReportSQL"
            Throw exc
        End Try
    End Function

    Private Function GetMasterTableValue(ByVal MasterTableID As String, ByVal RequestValue As String, ByVal UseHashTables As Boolean) As String
        '=====================================================================
        ' Procedure Name        :   GetMasterTableValue()
        ' Purpose               :   to get the value for the ID passed from
        '                           combo/list box
        ' Description           :   we query the master table to get the field
        '                           value for the passed id
        ' Parameters Passed     :   ByVal MasterTableID As string, ByVal RequestValue As String, ByVal UseHashTables As Boolean
        ' Returns               :   Replacement String for the report
        ' Parameters Affected   :   none
        ' Assumptions           :   
        ' Dependencies          :   usp_sel_v_tbl_CRW_Report_EmptyValueReplacement
        ' Author                :   Rajanikant
        ' Created               :   September 29,2003
        ' Revisions             :   
        '=====================================================================
        Dim dr As IDataReader
        Dim strFields As String
        Dim strTableName As String
        Dim strSQL As String
        Dim arr() As String = {}
        Dim strReturn As String
        If Trim(MasterTableID & "") <> "0" And Trim(MasterTableID & "") <> "" Then
            'If IsNumeric(MasterTableID) Then
            ' this will happen in case of combo boxes
            dr = CommonFunctions.Data.GetDataReader("usp_sel_v_tbl_CRW_MasterTables " + MasterTableID, m_blnUseSQL)
            If dr.Read Then
                strFields = dr("Fields").ToString
                strTableName = dr("TableName").ToString
            End If
            CommonFunction.Data.DisposeDataReader(dr) : dr = Nothing

            arr = Split(strFields, ",")
            strSQL = " SELECT " + arr(UBound(arr)) + " FROM " + strTableName + " WHERE " + arr(LBound(arr)) + " IN (" + RequestValue + ")"
            Try
                dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                Do While dr.Read
                    strReturn += dr(0).ToString() + ","
                Loop
                CommonFunction.Data.DisposeDataReader(dr) : dr = Nothing
                If Trim(strReturn & "") <> "" Then
                    strReturn = Left(strReturn, Len(strReturn) - 1)
                End If
                Return strReturn
            Catch
                ' return the same request value
                Return RequestValue
            End Try
        Else
            ' return the same request value
            Return RequestValue
        End If
    End Function

    Private Function GetEmptyValueReplacement(ByVal ReportID As Long, ByVal Format As String) As String
        '=====================================================================
        ' Procedure Name        :   GetEmptyValueReplacement()
        ' Description           :   Queries the database to get the replacement
        '                           string for the report and format
        ' Purpose               :   same as above
        ' Parameters Passed     :   ByVal lngReportID As Long, ByVal Format As Format
        ' Returns               :   Replacement String for the report
        ' Parameters Affected   :   none
        ' Assumptions           :   
        ' Dependencies          :   usp_sel_v_tbl_CRW_Report_EmptyValueReplacement
        ' Author                :   Rajanikant
        ' Created               :   September 29,2003
        ' Revisions             :   
        '=====================================================================
        Dim intFormatID As Integer
        Dim dr As System.Data.IDataReader
        ' get the format id
        Select Case Format.Trim.ToUpper
            Case "PDF" : intFormatID = 1
            Case "HTML" : intFormatID = 2
            Case "EXCEL" : intFormatID = 3
            Case "RTF" : intFormatID = 4
            Case "TEXT" : intFormatID = 5
            Case "CSV" : intFormatID = 6
            Case "XML" : intFormatID = 7
        End Select
        GetEmptyValueReplacement = ""
        ' get the replacement string for the format & report
        dr = CommonFunctions.Data.GetDataReader("usp_sel_v_tbl_CRW_Report_EmptyValueReplacement " + ReportID.ToString + "," + intFormatID.ToString, m_blnUseSQL)
        If dr.Read Then
            GetEmptyValueReplacement = dr("ReplacementString").ToString
        End If
        ' close the data reader
        CommonFunction.Data.DisposeDataReader(dr)
        dr = Nothing
    End Function
#End Region

    Private Sub oRpt_Section_BeforePrint(ByVal sender As Object, ByVal e As System.EventArgs, ByVal Report As DataDynamics.ActiveReports.ActiveReport) Handles oRpt.Section_BeforePrint
        Dim section As DataDynamics.ActiveReports.Section
        Dim intCnt As Integer
        Const MAX_VARIANCE As Double = 30000
        section = CType(sender, DataDynamics.ActiveReports.Section)
        Select Case UCase(Trim(section.Name & ""))
            Case "DETAIL"
                For intCnt = 0 To section.Controls.Count - 1
                    If section.Controls(intCnt).GetType.ToString.Trim.ToUpper = "DATADYNAMICS.ACTIVEREPORTS.TEXTBOX" Then

                        CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Black
                        Select Case UCase(CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).DataField).Trim
                            Case "CURRENTSTART", "CURRENTEND", "CURRENTDURATION"
                                If CommonFunctions.Data.CheckIsDBNull(CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text).ToString.Trim = "" Or CommonFunctions.Data.CheckIsDBNull(Report.Fields("WhichTask").Value).ToString.Trim = "D" Then
                                    'For General Tasks 
                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "N/A"
                                End If
                            Case "CURRENTWORK"
                                If CType(CommonFunctions.Data.CheckIsDBNull(Report.Fields("CurrentWork").Value, "0"), Double) = 0 Then
                                    If CommonFunctions.Data.CheckIsDBNull(Report.Fields("WhichTask").Value).ToString.Trim = "D" Or CommonFunctions.Data.CheckIsDBNull(Report.Fields("WhichTask").Value).ToString.Trim = "B" Then
                                        'For General Tasks 
                                        CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "N/A"
                                    Else
                                        CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "NYE"
                                    End If
                                End If
                            Case "BASELINESTART", "BASELINEEND", "BASELINEDURATION", "BASELINEWORK"
                                If CommonFunctions.Data.CheckIsDBNull(CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text).ToString.Trim = "" Or CommonFunctions.Data.CheckIsDBNull(Report.Fields("WhichTask").Value).ToString.Trim = "D" _
                                     Or CommonFunctions.Data.CheckIsDBNull(Report.Fields("WhichTask").Value).ToString.Trim = "B" Then
                                    'For General Tasks and Assigned Issues
                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "N/A"
                                End If
                            Case "ACTUALSTART"
                                If CommonFunctions.Data.CheckIsDBNull(CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text).ToString.Trim = "" And _
                                    Report.Fields("IsTaskComplete").Value.ToString = "False" And CType(CommonFunctions.Data.CheckIsDBNull(Report.Fields("WorkToDate").Value, "0"), Double) = 0 Then
                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "NYS"
                                End If
                            Case "ACTUALEND", "ACTUALDURATION"
                                CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Black
                                If Report.Fields("IsTaskComplete").Value.ToString = "False" Then
                                    If CommonFunctions.Data.CheckIsDBNull(CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text).ToString.Trim = "" And CType(CommonFunctions.Data.CheckIsDBNull(Report.Fields("WorkToDate").Value, "0"), Double) = 0 Then
                                        CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "N/A"
                                    Else
                                        CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "IP"
                                        CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Green
                                    End If
                                End If
                            Case "WORKINLASTWEEK", "WORKINTHISWEEK", "WORKTODATE"
                                If CType(CommonFunctions.Data.CheckIsDBNull(CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text, "0"), Double) = 0 Then
                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "0.00"
                                End If
                            Case "REMAININGWORK"
                                Dim dblStartVariance As Double
                                Dim dblEndVariance As Double
                                Dim dblWorkVariance As Double
                                Dim dblCurrentVariance As Double
                                Dim d1 As Date, d2 As Date
                                'Wrap the Word
                                CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).WordWrap = True

                                'START VARIANCE : If BaseLine Start Date and Actual Start Date Present then calulate the date difference between them
                                If IsDate(Report.Fields("BaseLineStart").Value) And IsDate(Report.Fields("ActualStart").Value) Then
                                    dblStartVariance = DateDiff("d", CType(Report.Fields("BaseLineStart").Value, Date), CType(Report.Fields("ActualStart").Value, Date))
                                Else
                                    dblStartVariance = MAX_VARIANCE
                                End If

                                'END VARIANCE : If BaseLine End Date and Actual End Date Present then calulate the date difference between them
                                If IsDate(Report.Fields("BaseLineEnd").Value) And IsDate(Report.Fields("ActualEnd").Value) Then
                                    dblEndVariance = DateDiff("d", CType(Report.Fields("BaseLineEnd").Value, Date), CType(Report.Fields("ActualEnd").Value, Date))
                                Else
                                    dblEndVariance = MAX_VARIANCE
                                End If

                                'WORK VARIANCE : If BaseLine Work and Actual Work Present then calulate the Work difference between them
                                'For maintening the convesion +ve for delayed and -ve for earlier
                                dblWorkVariance = CType(Report.Fields("BaseLineWork").Value, Double) - CType(Report.Fields("WorkToDate").Value, Double)

                                'CURRENT VARIANCE : The difference between Baseline End Date and Current Server Date
                                If IsDate(Report.Fields("BaseLineEnd").Value) Then
                                    dblCurrentVariance = DateDiff("d", CType(Report.Fields("BaseLineEnd").Value, Date).Date, Date.Today.Date)
                                Else
                                    dblCurrentVariance = MAX_VARIANCE
                                End If

                                CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Black
                                If Report.Fields("IsTaskComplete").Value.ToString = "False" Then
                                    'Task is in progress : NOT COMPLETED
                                    Select Case dblStartVariance
                                        Case MAX_VARIANCE
                                            'No Base Line Parameters defined Task is not completed
                                            CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Green
                                            CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "IP"
                                            Select Case dblCurrentVariance
                                                Case MAX_VARIANCE
                                                    'No Processing
                                                Case Else
                                                    Select Case sign(dblCurrentVariance)
                                                        Case valueSign.ZERO '(TODAYS DATE IS CURRENT END DATE)
                                                            CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Green
                                                            CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "NYS RW(0d," + dblWorkVariance.ToString.Trim + "h)"
                                                        Case valueSign.NEGATIVE '(TODAYS DATE IS BEFORE CURRENT END DATE)
                                                            CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Green
                                                            CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "NYS RW(" + (-1 * dblCurrentVariance).ToString.Trim + "d," + dblWorkVariance.ToString.Trim + "h)"
                                                        Case valueSign.POSITIVE
                                                            '(TODAYS DATE IS AFTER CURRENT END DATE)
                                                            CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Red
                                                            CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "NYS D(" + dblCurrentVariance.ToString.Trim + "d,0h) RW(0d," + dblWorkVariance.ToString.Trim + "h)"
                                                    End Select
                                            End Select

                                        Case Else
                                            Select Case sign(dblStartVariance)
                                                Case valueSign.ZERO  '(TASK IS IN PROGRESS) (TASK STARTED ON CURRENT START DATE)
                                                    Select Case dblWorkVariance
                                                        Case MAX_VARIANCE
                                                            'No Processing
                                                        Case Else
                                                            Select Case sign(dblWorkVariance)
                                                                Case valueSign.ZERO  'ON TIME 0h : (TASK TOOK TIME = CURRENT WORK)
                                                                    Select Case dblCurrentVariance
                                                                        Case MAX_VARIANCE
                                                                            'No Processing
                                                                        Case Else
                                                                            Select Case sign(dblCurrentVariance)
                                                                                Case valueSign.ZERO 'RW (0d,0h) : Remaining work to do 0 days and 0 hours : (TODAYS DATE IS CURRENT END DATE)
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Green
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "RW(0d,0h)"
                                                                                Case valueSign.NEGATIVE 'RW (d,0h) :Remaining work to do d days and 0h hours : (TODAYS DATE IS BEFORE CURRENT END DATE)
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Green
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "RW(" + (-1 * dblCurrentVariance).ToString.Trim + "d," + (-1 * dblWorkVariance).ToString.Trim + "h)"
                                                                                Case valueSign.POSITIVE 'ID(d,0h) RW (0d,0h) : In progress but delayed by d days and 0 hours. Remaining work is 0 days and 0 hours : (TODAYS DATE IS AFTER CURRENT END DATE)
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DarkRed
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "ID(" + dblCurrentVariance.ToString.Trim + "d,0h) RW(0d,0h)"
                                                                            End Select 'sign(dblCurrentVariance)
                                                                    End Select 'dblCurrentVariance

                                                                Case valueSign.NEGATIVE 'DELAYED by h hours : (TASK TOOK TIME > CURRENT WORK)
                                                                    Select Case dblCurrentVariance
                                                                        Case MAX_VARIANCE
                                                                            'No Processing
                                                                        Case Else
                                                                            Select Case sign(dblCurrentVariance)
                                                                                Case valueSign.ZERO 'ID(0d,h) RW (0d,0h) : In progress but delayed by 0 days and h hours. Remaining work is 0 days and 0 hours : (TODAYS DATE IS CURRENT END DATE)
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DarkRed
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "ID(0d," + (-1 * dblWorkVariance).ToString.Trim + "h) RW(0d,0h)"
                                                                                Case valueSign.NEGATIVE 'ID(0d,h) RW (d,0h) : In progress but delayed by 0 days and h hours. Remaining work is d days and 0 hours : (TODAYS DATE IS BEFORE CURRENT END DATE)
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DarkRed
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "ID(0d," + (-1 * dblWorkVariance).ToString.Trim + "h) RW(" + (-1 * dblCurrentVariance).ToString.Trim + "d,0h)"
                                                                                Case valueSign.POSITIVE 'ID(d,h) RW (0d,0h) : In progress but delayed by d days and h hours. Remaining work is 0 days and 0 hours : (TODAYS DATE IS AFTER CURRENT END DATE)
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DarkRed
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "ID(" + dblCurrentVariance.ToString.Trim + "d," + (-1 * dblWorkVariance).ToString.Trim + "h) RW(0d,0h)"
                                                                            End Select 'sign(dblCurrentVariance)
                                                                    End Select 'dblCurrentVariance

                                                                Case valueSign.POSITIVE 'TOOK TIME LESS THAN ESTIMATED : (TASK TOOK TIME < CURRENT WORK)
                                                                    Select Case dblCurrentVariance
                                                                        Case MAX_VARIANCE
                                                                            'No Processing
                                                                        Case Else
                                                                            Select Case sign(dblCurrentVariance)
                                                                                Case valueSign.ZERO 'RW (0d,h) : Remaining work to do 0 days and h hours : (TODAYS DATE IS CURRENT END DATE)
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Green
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "RW(0d," + dblWorkVariance.ToString.Trim + "h)"
                                                                                Case valueSign.NEGATIVE 'RW (d,h) : Remaining work to do d days and h hours : (TODAYS DATE BEFORE CURRENT END DATE)
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Green
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "RW(" + (-1 * dblCurrentVariance).ToString.Trim + "d," + dblWorkVariance.ToString.Trim + "h)"
                                                                                Case valueSign.POSITIVE 'ID(d,0h) RW (0d,h) : In progress but delayed by d days and 0 hours. Remaining work is 0 days and h hous : (TODAYS DATE IS AFTER CURRENT END DATE)
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DarkRed
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "ID(" + dblCurrentVariance.ToString.Trim + "d,0h) RW(0d," + dblWorkVariance.ToString.Trim + "h)"
                                                                            End Select 'sign(dblCurrentVariance)
                                                                    End Select 'dblCurrentVariance
                                                            End Select 'sign(dblWorkVariance)
                                                    End Select 'dblWorkVariance

                                                Case valueSign.NEGATIVE '(TASK IS IN PROGRESS) (ACTUAL START DATE BEFORE CURRENT START DATE)
                                                    Select Case dblWorkVariance
                                                        Case MAX_VARIANCE
                                                            'No Processing
                                                        Case Else
                                                            Select Case sign(dblWorkVariance)
                                                                Case valueSign.ZERO  'ON TIME 0h : (TASK TOOK TIME = CURRENT WORK)
                                                                    Select Case dblCurrentVariance
                                                                        Case MAX_VARIANCE
                                                                            'No Processing
                                                                        Case Else
                                                                            Select Case sign(dblCurrentVariance)
                                                                                Case valueSign.ZERO 'SE (d) RW (0d,0h) : Started earlier by d days. Remaining work is 0 days and 0 hours : (TODAYS DATE IS CURRENT END DATE)
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Green
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SE(" + (-1 * dblStartVariance).ToString.Trim + "d) RW(0d,0h)"
                                                                                Case valueSign.NEGATIVE 'SE (d) RW (d,0h) : Started earlier by d days. Remaining work is d days and 0 hours : (TODAYS DATE IS BEFORE CURRENT END DATE)
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Green
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SE(" + (-1 * dblStartVariance).ToString.Trim + "d) RW(" + (-1 * dblCurrentVariance).ToString.Trim + "d,0h)"
                                                                                Case valueSign.POSITIVE 'SE (d) ID(d,0h) RW (0d,0h) : Started earlier by d days. In progress but delayed by d days and h hours. Remaining work is d days and h hous : (TODAYS DATE IS AFTER CURRENT END DATE)
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DarkRed
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SE(" + (-1 * dblStartVariance).ToString.Trim + "d) ID(" + dblCurrentVariance.ToString.Trim + "d,0h) RW(0d,0h)"
                                                                            End Select 'sign(dblCurrentVariance)
                                                                    End Select 'dblCurrentVariance

                                                                Case valueSign.NEGATIVE 'DELAYED by h hours : (TASK TOOK TIME > CURRENT WORK)
                                                                    Select Case dblCurrentVariance
                                                                        Case MAX_VARIANCE
                                                                            'No Processing
                                                                        Case Else
                                                                            Select Case sign(dblCurrentVariance)
                                                                                Case valueSign.ZERO 'SE (d) ID(0d,h) RW (0d,0h) : Started earlier by d days. In progress but delayed by 0 days and h hours. Remaining work is 0 days and 0 hours : (TODAYS DATE IS CURRENT END DATE)
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DarkRed
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SE(" + (-1 * dblStartVariance).ToString.Trim + "d) ID(0d," + (-1 * dblWorkVariance).ToString.Trim + "h) RW(0d,0h)"
                                                                                Case valueSign.NEGATIVE 'SE (d) ID(0d,h) RW (d,0h) : Started earlier by d days. In progress but delayed by 0 days and h hours. Remaining work is d days and 0 hours : (TODAYS DATE IS BEFORE CURRENT END DATE)
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DarkRed
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SE(" + (-1 * dblStartVariance).ToString.Trim + "d) ID(0d," + (-1 * dblWorkVariance).ToString.Trim + "h) RW(" + (-1 * dblCurrentVariance).ToString.Trim + "d,0h)"
                                                                                Case valueSign.POSITIVE 'ID(d,h) RW (0d,0h) : In progress but delayed by d days and h hours. Remaining work is 0 days and 0 hours : (TODAYS DATE IS AFTER CURRENT END DATE) : (TODAYS DATE IS AFTER CURRENT END DATE)
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DarkRed
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SE(" + (-1 * dblStartVariance).ToString.Trim + "d) ID(" + dblCurrentVariance.ToString.Trim + "d," + (-1 * dblWorkVariance).ToString.Trim + "h) RW(0d,0h)"
                                                                            End Select 'sign(dblCurrentVariance)
                                                                    End Select 'dblCurrentVariance

                                                                Case valueSign.POSITIVE 'TOOK TIME LESS THAN ESTIMATED : (TASK TOOK TIME < CURRENT WORK)
                                                                    Select Case dblCurrentVariance
                                                                        Case MAX_VARIANCE
                                                                            'No Processing
                                                                        Case Else
                                                                            Select Case sign(dblCurrentVariance)
                                                                                Case valueSign.ZERO 'SE (d)  RW (0d,h) : Started earlier by d days. Remaining work is 0 days and h hours : (TODAYS DATE IS CURRENT END DATE)
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Green
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SE(" + (-1 * dblStartVariance).ToString.Trim + "d) RW(0d," + dblWorkVariance.ToString.Trim + "h)"
                                                                                Case valueSign.NEGATIVE 'SE (d)  RW (d,h) : Started earlier by d days. Remaining work is d days and h hous : (TODAYS DATE BEFORE CURRENT END DATE)
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Green
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SE(" + (-1 * dblStartVariance).ToString.Trim + "d) RW(" + (-1 * dblCurrentVariance).ToString.Trim + "d," + dblWorkVariance.ToString.Trim + "h)"
                                                                                Case valueSign.POSITIVE 'SE (d) ID(d,0h) RW (0d,h) : Started earlier by d days. In progress but delayed by d days and 0 hours. Remaining work is 0 days and h hous : (TODAYS DATE IS AFTER CURRENT END DATE)
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DarkRed
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SE(" + (-1 * dblStartVariance).ToString.Trim + "d) ID(" + dblCurrentVariance.ToString.Trim + "d,0h) RW(0d," + dblWorkVariance.ToString.Trim + "h)"
                                                                            End Select 'sign(dblCurrentVariance)
                                                                    End Select 'dblCurrentVariance
                                                            End Select 'sign(dblWorkVariance)
                                                    End Select 'dblWorkVariance

                                                Case valueSign.POSITIVE '(TASK IS IN PROGRESS) : (ACTUAL START DATE AFTER CURRENT START DATE)
                                                    Select Case dblWorkVariance
                                                        Case MAX_VARIANCE
                                                            'No Processing
                                                        Case Else
                                                            Select Case sign(dblWorkVariance)
                                                                Case valueSign.ZERO  'ON TIME 0h : (TASK TOOK TIME = CURRENT WORK)
                                                                    Select Case dblCurrentVariance
                                                                        Case MAX_VARIANCE
                                                                            'No Processing
                                                                        Case Else
                                                                            Select Case sign(dblCurrentVariance)
                                                                                Case valueSign.ZERO 'SD (d) RW (0d,0h) : Start delayed by d days. Remaining work is 0 days and 0 hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Green
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SD(" + dblStartVariance.ToString.Trim + "d) RW(0d,0h)"
                                                                                Case valueSign.NEGATIVE 'SD (d) RW (d,0h) : Start delayed by d days. Remaining work is d days and h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Green
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SD(" + dblStartVariance.ToString.Trim + "d) RW(" + (-1 * dblCurrentVariance).ToString.Trim + "d,0h)"
                                                                                Case valueSign.POSITIVE 'SD (d) ID(d,0h) RW (0d,0h) : Start delayed by d days. In progress but delayed by d days and 0 hours. Remaining work is 0 days and 0 hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DarkRed
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SD(" + dblStartVariance.ToString.Trim + "d) ID(" + dblCurrentVariance.ToString.Trim + "d,0h) RW(0d,0h)"
                                                                            End Select 'sign(dblCurrentVariance)
                                                                    End Select 'dblCurrentVariance

                                                                Case valueSign.NEGATIVE 'DELAYED by h hours : (TASK TOOK TIME > CURRENT WORK)
                                                                    Select Case dblCurrentVariance
                                                                        Case MAX_VARIANCE
                                                                            'No Processing
                                                                        Case Else
                                                                            Select Case sign(dblCurrentVariance)
                                                                                Case valueSign.ZERO 'SD (d) ID(0d,h) RW (0d,0h) : Start delayed by d days. In progress but delayed by 0 days and h hours. Remaining work is 0 days and 0 hous
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DarkRed
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SD(" + dblStartVariance.ToString.Trim + "d) ID(0d," + (-1 * dblWorkVariance).ToString.Trim + "h) RW(0d,0h)"
                                                                                Case valueSign.NEGATIVE 'SD (d) ID(0d,h) RW (d,0h) : Start delayed by d days. In progress but delayed by 0 days and h hours. Remaining work is d days and 0 hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DarkRed
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SD(" + dblStartVariance.ToString.Trim + "d) ID(0d," + (-1 * dblWorkVariance).ToString.Trim + "h) RW(" + (-1 * dblCurrentVariance).ToString.Trim + "d,0h)"
                                                                                Case valueSign.POSITIVE 'SD (d) ID(d,h) RW (0d,0h) : Start delayed by d days. In progress but delayed by d days and h hours. Remaining work is 0 days and 0 hous
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DarkRed
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SD(" + dblStartVariance.ToString.Trim + "d) ID(" + dblCurrentVariance.ToString.Trim + "d," + (-1 * dblWorkVariance).ToString.Trim + "h) RW(0d,0h)"
                                                                            End Select 'sign(dblCurrentVariance)
                                                                    End Select 'dblCurrentVariance

                                                                Case valueSign.POSITIVE 'TOOK TIME LESS THAN ESTIMATED : (TASK TOOK TIME < CURRENT WORK)
                                                                    Select Case dblCurrentVariance
                                                                        Case MAX_VARIANCE
                                                                            'No Processing
                                                                        Case Else
                                                                            Select Case sign(dblCurrentVariance)
                                                                                Case valueSign.ZERO 'SD (d) RW (0d,h) : Start delayed by d days. Remaining work is d days and h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Green
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SD(" + dblStartVariance.ToString.Trim + "d) RW(0d," + dblWorkVariance.ToString.Trim + "h)"
                                                                                Case valueSign.NEGATIVE 'SD (d) RW (d,h) : Start delayed by d days. Remaining work is d days and h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Green
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SD(" + dblStartVariance.ToString.Trim + "d) RW(" + (-1 * dblCurrentVariance).ToString.Trim + "d," + dblWorkVariance.ToString.Trim + "h)"
                                                                                Case valueSign.POSITIVE 'SD (d) ID(d,0h) RW (0d,h) : Start delayed by d days. In progress but delayed by d days and 0 hours. Remaining work is 0 days and h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DarkRed
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SD(" + dblStartVariance.ToString.Trim + "d) ID(" + dblCurrentVariance.ToString.Trim + "d,0h) RW(0d," + dblWorkVariance.ToString.Trim + "h)"
                                                                            End Select 'sign(dblCurrentVariance)
                                                                    End Select 'dblCurrentVariance
                                                            End Select 'sign(dblWorkVariance)
                                                    End Select 'dblWorkVariance
                                            End Select 'sign(dblStartVariance)
                                    End Select 'dblStartVariance
                                Else
                                    'COMPLETED
                                    Select Case dblStartVariance
                                        Case MAX_VARIANCE
                                            'No Base Line Parameters defined Task is completed
                                            CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Blue
                                            CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "C"
                                        Case Else
                                            Select Case sign(dblStartVariance)
                                                Case valueSign.ZERO  '(TASK STARTED ON CURRENT START DATE)
                                                    Select Case dblEndVariance
                                                        Case MAX_VARIANCE
                                                            'No Processing
                                                        Case Else
                                                            Select Case sign(dblEndVariance)
                                                                Case valueSign.ZERO  'ON TIME 0h : (TASK TOOK TIME = CURRENT WORK)
                                                                    Select Case dblWorkVariance
                                                                        Case MAX_VARIANCE
                                                                            'No Processing
                                                                        Case Else
                                                                            Select Case sign(dblWorkVariance)
                                                                                Case valueSign.ZERO 'C : Completed
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Blue
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "C"
                                                                                Case valueSign.NEGATIVE 'CD (0d,h) : Completed but delayed by 0 days and h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Red
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "CD(0d," + (-1 * dblWorkVariance).ToString.Trim + "h)"
                                                                                Case valueSign.POSITIVE 'CE (0d,h) : Completed earlier by 0 days and h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Blue
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "CE(0d," + dblWorkVariance.ToString.Trim + "h)"
                                                                            End Select 'sign(dblWorkVariance)
                                                                    End Select 'dblWorkVariance

                                                                Case valueSign.NEGATIVE 'DELAYED by h hours : (TASK TOOK TIME > CURRENT WORK)
                                                                    Select Case dblWorkVariance
                                                                        Case MAX_VARIANCE
                                                                            'No Processing
                                                                        Case Else
                                                                            Select Case sign(dblWorkVariance)
                                                                                Case valueSign.ZERO 'CE (d,0h) : Completed earlier by d days and 0 hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Blue
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "CE(" + (-1 * dblEndVariance).ToString.Trim + "d,0h)"
                                                                                Case valueSign.NEGATIVE 'CE (d) CD (h) : Completed earlier by d days but delayed by h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Red
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "CE(" + (-1 * dblEndVariance).ToString.Trim + "d) CD(" + (-1 * dblWorkVariance).ToString.Trim + "h)"
                                                                                Case valueSign.POSITIVE 'CE (d,h) : Completed earlier by d days and h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Blue
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "CE(" + (-1 * dblEndVariance).ToString.Trim + "d," + dblWorkVariance.ToString.Trim + "h)"
                                                                            End Select 'sign(dblWorkVariance)
                                                                    End Select 'dblWorkVariance

                                                                Case valueSign.POSITIVE 'TOOK TIME LESS THAN ESTIMATED : (TASK TOOK TIME < CURRENT WORK)
                                                                    Select Case dblWorkVariance
                                                                        Case MAX_VARIANCE
                                                                            'No Processing
                                                                        Case Else
                                                                            Select Case sign(dblWorkVariance)
                                                                                Case valueSign.ZERO 'CD (d,0h) : Completed but delayed by d days and 0 hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Red
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "CD(" + dblEndVariance.ToString.Trim + "d,0h)"
                                                                                Case valueSign.NEGATIVE 'CD (d,h) : Completed but delayed by d days and h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Red
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "CD(" + dblEndVariance.ToString.Trim + "d," + (-1 * dblWorkVariance).ToString.Trim + "h)"
                                                                                Case valueSign.POSITIVE 'CD (d) CE (h) : Completed but delayed by d days but earlier by h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Red
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "CD(" + dblEndVariance.ToString.Trim + "d) CE(" + dblWorkVariance.ToString.Trim + "h)"
                                                                            End Select 'sign(dblWorkVariance)
                                                                    End Select 'dblWorkVariance
                                                            End Select 'sign(dblEndVariance)
                                                    End Select 'dblEndVariance

                                                Case valueSign.NEGATIVE '(TASK IS IN COMPLETED) (ACTUAL START DATE BEFORE CURRENT START DATE)
                                                    Select Case dblEndVariance
                                                        Case MAX_VARIANCE
                                                            'No Processing
                                                        Case Else
                                                            Select Case sign(dblEndVariance)
                                                                Case valueSign.ZERO  'ON TIME 0h : (TASK TOOK TIME = CURRENT WORK)
                                                                    Select Case dblWorkVariance
                                                                        Case MAX_VARIANCE
                                                                            'No Processing
                                                                        Case Else
                                                                            Select Case sign(dblWorkVariance)
                                                                                Case valueSign.ZERO 'SE (d) C : Started earlier by d days and Completed
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Blue
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SE(" + (-1 * dblStartVariance).ToString.Trim + "d) C"
                                                                                Case valueSign.NEGATIVE 'SE (d) CD (0d,h) : Started earlier by d days, and Completed delayed by d days and h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DeepPink
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SE(" + (-1 * dblStartVariance).ToString.Trim + "d) CD(0d," + (-1 * dblWorkVariance).ToString.Trim + "h)"
                                                                                Case valueSign.POSITIVE 'SE (d) CE (0d,h) : Started earlier by d days and Completed earlier by 0 days and h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Blue
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SE(" + (-1 * dblStartVariance).ToString.Trim + "d) CE(0d," + dblWorkVariance.ToString.Trim + "h)"
                                                                            End Select 'sign(dblWorkVariance)
                                                                    End Select 'dblWorkVariance

                                                                Case valueSign.NEGATIVE 'DELAYED by h hours : (TASK TOOK TIME > CURRENT WORK)
                                                                    Select Case dblWorkVariance
                                                                        Case MAX_VARIANCE
                                                                            'No Processing
                                                                        Case Else
                                                                            Select Case sign(dblWorkVariance)
                                                                                Case valueSign.ZERO 'SE (d) CE (d,0h) : Started earlier by d days and Completed earlier by d days and 0 hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Blue
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SE(" + (-1 * dblStartVariance).ToString.Trim + "d) CE(" + (-1 * dblEndVariance).ToString.Trim + "d,0h)"
                                                                                Case valueSign.NEGATIVE 'SE (d) CE(d) CD (h) : Started earlier by d days , Completed earlier by d days but delayed by h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DeepPink
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SE(" + (-1 * dblStartVariance).ToString.Trim + "d) CE(" + (-1 * dblEndVariance).ToString.Trim + "d) CD(" + (-1 * dblWorkVariance).ToString.Trim + "h)"
                                                                                Case valueSign.POSITIVE 'SE (d) CE (d,h) : Started earlier by d days and Completed earlier by d days and h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Blue
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SE(" + (-1 * dblStartVariance).ToString.Trim + "d) CE(" + (-1 * dblEndVariance).ToString.Trim + "d," + dblWorkVariance.ToString.Trim + "h)"
                                                                            End Select 'sign(dblWorkVariance)
                                                                    End Select 'dblWorkVariance

                                                                Case valueSign.POSITIVE 'TOOK TIME LESS THAN ESTIMATED : (TASK TOOK TIME < CURRENT WORK)
                                                                    Select Case dblWorkVariance
                                                                        Case MAX_VARIANCE
                                                                            'No Processing
                                                                        Case Else
                                                                            Select Case sign(dblWorkVariance)
                                                                                Case valueSign.ZERO 'SE (d) CD (d,0h) : Started earlier by d days, and Completed delayed by d days and 0 hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DeepPink
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SE(" + (-1 * dblStartVariance).ToString.Trim + "d) CD(" + dblEndVariance.ToString.Trim + "d,0h)"
                                                                                Case valueSign.NEGATIVE 'SE (d) CD (d,h) : Started earlier by d days, and Completed delayed by d days and h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DeepPink
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SE(" + (-1 * dblStartVariance).ToString.Trim + "d) CD(" + dblEndVariance.ToString.Trim + "d," + (-1 * dblWorkVariance).ToString.Trim + "h)"
                                                                                Case valueSign.POSITIVE 'SE (d) CD (d) CE (h) : Started earlier by d days , Completed delayed d days but earlier by h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DeepPink
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SE(" + (-1 * dblStartVariance).ToString.Trim + "d) CD(" + dblEndVariance.ToString.Trim + "d) CE(" + dblWorkVariance.ToString.Trim + "h)"
                                                                            End Select 'sign(dblWorkVariance)
                                                                    End Select 'dblWorkVariance
                                                            End Select 'sign(dblEndVariance)
                                                    End Select 'dblEndVariance

                                                Case valueSign.POSITIVE '(TASK IS COMPLETED) : (ACTUAL START DATE AFTER CURRENT START DATE)
                                                    Select Case dblEndVariance
                                                        Case MAX_VARIANCE
                                                            'No Processing
                                                        Case Else
                                                            Select Case sign(dblEndVariance)
                                                                Case valueSign.ZERO  'ON TIME 0h : (TASK TOOK TIME = CURRENT WORK)
                                                                    Select Case dblWorkVariance
                                                                        Case MAX_VARIANCE
                                                                            'No Processing
                                                                        Case Else
                                                                            Select Case sign(dblWorkVariance)
                                                                                Case valueSign.ZERO 'SD (d) C : Start delayed by d days and Completed
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Blue
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SD(" + dblStartVariance.ToString.Trim + "d) C"
                                                                                Case valueSign.NEGATIVE 'SD (d) CD (0d,h) : Start delayed by d days, and Completed delayed by d days and h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DeepPink
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SD(" + dblStartVariance.ToString.Trim + "d) CD(" + dblEndVariance.ToString.Trim + "d," + (-1 * dblWorkVariance).ToString.Trim + "h)"
                                                                                Case valueSign.POSITIVE 'SD (d) CE (0d,h) : Start delayed by 0 days and Completed earlier by d days and h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Blue
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SD(" + dblStartVariance.ToString.Trim + "d) CE(0d," + dblWorkVariance.ToString.Trim + "h)"
                                                                            End Select 'sign(dblWorkVariance)
                                                                    End Select 'dblWorkVariance

                                                                Case valueSign.NEGATIVE 'DELAYED by h hours : (TASK TOOK TIME > CURRENT WORK)
                                                                    Select Case dblWorkVariance
                                                                        Case MAX_VARIANCE
                                                                            'No Processing
                                                                        Case Else
                                                                            Select Case sign(dblWorkVariance)
                                                                                Case valueSign.ZERO 'SD (d) CE (d,0h) : Start delayed by d days and Completed earlier by d days and 0 hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Blue
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SD(" + dblStartVariance.ToString.Trim + "d) CE(" + (-1 * dblEndVariance).ToString.Trim + "d,0h)"
                                                                                Case valueSign.NEGATIVE 'SD (d) CE(d) CD (h) : Start delayed by d days , Completed earlier by d days but delayed by h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DeepPink
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SD(" + dblStartVariance.ToString.Trim + "d) CE(" + (-1 * dblEndVariance).ToString.Trim + "d) CD(" + (-1 * dblWorkVariance).ToString.Trim + "h)"
                                                                                Case valueSign.POSITIVE 'SD (d) CE (d,h) : Start delayed by d days and Completed earlier by d days and h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Blue
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SD(" + dblStartVariance.ToString.Trim + "d) CE(" + (-1 * dblEndVariance).ToString.Trim + "d," + dblWorkVariance.ToString.Trim + "h)"
                                                                            End Select 'sign(dblWorkVariance)
                                                                    End Select 'dblWorkVariance

                                                                Case valueSign.POSITIVE 'TOOK TIME LESS THAN ESTIMATED : (TASK TOOK TIME < CURRENT WORK)
                                                                    Select Case dblWorkVariance
                                                                        Case MAX_VARIANCE
                                                                            'No Processing
                                                                        Case Else
                                                                            Select Case sign(dblWorkVariance)
                                                                                Case valueSign.ZERO 'SD (d) CD (d,0h) : Start delayed by d days, and Completed delayed by d days and 0 hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DeepPink
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SD(" + dblStartVariance.ToString.Trim + "d) CD(" + dblEndVariance.ToString.Trim + "d,0h)"
                                                                                Case valueSign.NEGATIVE 'SD (d) CD (d,h) : Start delayed by d days, and Completed delayed by d days and h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DeepPink
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SD(" + dblStartVariance.ToString.Trim + "d) CD(" + dblEndVariance.ToString.Trim + "d," + (-1 * dblWorkVariance).ToString.Trim + "h)"
                                                                                Case valueSign.POSITIVE 'SD (d) CD (d) CE (h) : Started delayed by d days , Completed delayed d days but earlier by h hours
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.DeepPink
                                                                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "SD(" + dblStartVariance.ToString.Trim + "d) CD(" + dblEndVariance.ToString.Trim + "d) CE(" + dblWorkVariance.ToString.Trim + "h)"
                                                                            End Select '
                                                                    End Select '
                                                            End Select '
                                                    End Select '
                                            End Select 'sign(dblStartVariance)
                                    End Select 'dblStartVariance
                                End If
                                If Report.Fields("IsActive").Value.ToString = "False" Then
                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Red
                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "Deleted"
                                End If
                                If CType(CommonFunctions.Data.CheckIsDBNull(Report.Fields("CurrentWork").Value, "0"), Double) = 0 And CommonFunctions.Data.CheckIsDBNull(Report.Fields("WhichTask").Value).ToString.Trim = "D" Then
                                    'Gerenal Task
                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Black
                                    CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "N/A"
                                End If
                                If CommonFunctions.Data.CheckIsDBNull(CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text).ToString.Trim = "" And _
                                    Report.Fields("IsTaskComplete").Value.ToString = "False" And CType(CommonFunctions.Data.CheckIsDBNull(Report.Fields("WorkToDate").Value, "0"), Double) = 0 Then
                                    If CType(section.Controls("CurrentWork"), DataDynamics.ActiveReports.TextBox).Text = "NYS" Then
                                        CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Black
                                        CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = "N/A"
                                    Else
                                        'Equal to Current Work
                                        CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).ForeColor = System.Drawing.Color.Black
                                        CType(section.Controls(intCnt), DataDynamics.ActiveReports.TextBox).Text = CType(section.Controls("CurrentWork"), DataDynamics.ActiveReports.TextBox).Text
                                    End If
                                End If
                        End Select
                    End If ' Control Type
                Next
        End Select
    End Sub

    Private Function sign(ByVal dblNumber As Double) As valueSign

        If dblNumber < 0 Then
            sign = valueSign.NEGATIVE
        ElseIf dblNumber > 0 Then
            sign = valueSign.POSITIVE
        Else
            sign = valueSign.ZERO
        End If

    End Function

End Class
