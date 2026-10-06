Option Strict Off
Public Class RM_ReportHanddler
    Inherits WebPages.Template.WhizTemplate
    'Revision by ArchanaN on 7 Jun 2007
    'To Modify the ReportID 1997 to 2066, 1998 to 2067, 2017 to 2070 

    Protected m_strFileName As String           ' will be used at client side
    Protected m_intShowMessage As Integer = 0   ' will be used at client side
    Private m_lngReportID As Long
    Private m_strReportName As String
    Private m_blnUseSQL As Boolean
    Private m_ReportWidth As Integer = 0
    'Code Added By PradipK for CustomerWiseKPI 
    Private PreCustomerName As String = ""
    Private CurrentCustomerName As String = ""
    'End Addition By PradipK
    'Added By MahendraV On 18-Oct-2007 2.00 PM for WhizibleSEM 7.1
    ' Purpose : To set employeeid for reportID 2121
    ' Start_MV_18-Oct-2007
    Private m_intEmployeeID As Integer = 0
    Dim m_blnFlag As Boolean = False
    ' End_MV_18-Oct-2007
    Const COMBOBOX As Integer = 1
    Const DATECONTROL As Integer = 2
    Const TEXTBOX As Integer = 3
    Const CHECKBOX As Integer = 4
    Const LISTBOX As Integer = 5
    Private WithEvents oRpt As AdHocReports.Report.AdHocReport
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
        ' Added and Commented By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        'MyBase.ApplySecurity(False, 2)

        MyBase.ApplySecurity(True)
        ' End Added and Commented By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting

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
        'm_lngReportID = 1997 'PRODUCT_CUSTOMER_REPORT = 1997
        m_lngReportID = Request.QueryString("ReportID")
        ' use sql?

        'Added By MahendraV On 18-Oct-2007 2.00 PM for WhizibleSEM 7.1
        ' Purpose : To set employeeid for reportID 2121
        ' Start_MV_18-Oct-2007
        If Not Request.QueryString("UniqueID") Is Nothing Then
            If Request.QueryString("UniqueID") <> "" Then
                m_intEmployeeID = CInt(Request.QueryString("UniqueID").ToString())
            End If
        End If
        ' End_MV_18-Oct-2007
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
                'Code Added By PradipK on 28 Juky 2006 for CustomerWise KPI Report,Roamware Customization

                If m_lngReportID = 2029 Or m_lngReportID = 2030 Then
                    strSQL = strSQL & " , " & m_lngReportID
                Else
                    ' Commented and Modified By MahendraV On 18-Oct-2007 For WhizibleSEM 7.1 
                    ' Purpose: To set the employee resume image path dynamically.
                    ' Start_MV_18-Oct-2007
                    ' strSQL = strSQL & " " & m_lngReportID
                    If (m_lngReportID <> 2121) Then
                        strSQL = strSQL & " " & m_lngReportID
                    End If
                End If
                'End Addition By Pradipk on 28 Juky 2006

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
        ' Author                : KapilGK
        ' Created               : July 7,2006
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

        oReportUI.SubmitToPage = "RM_ReportHanddler.aspx"
        If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRWUI").Trim.ToUpper = "Y" Then
            oReportUI.UseHashTables = True
        Else
            oReportUI.UseHashTables = False
        End If
        'Added by ArchanaN on 6 Jun 2007 'To plot dynamic report 

        oReportUI.Action_NavigationSchema = AdHocReports.UI.ReportUI.DynamicAction_NavigationSchema.CLASSICAL
        'End by ArchanaN 
        oReportUI.GenerateUI(m_lngReportID)

        oReportUI = Nothing
    End Sub
    Protected Sub PageInit()
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
        ' Author                : KapilGK
        ' Created               : July 7,2006
        ' Revisions             :
        '=====================================================================
        'Addition of 'If condition' by SuchitraP on 8-Jan-2009 for IssueID:26391
        'Purpose:same page was opened in new window.
        If m_intShowMessage = 0 Then
            GenerateReportUI()
        End If
        'End of addition by SuchitraP on 8-Jan-2009
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
                'dr.Close()
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

    Private Sub oRpt_Report_BeforePrint(ByRef Cancel As Boolean, ByRef Args As AdHocReports.WAF_Report) Handles oRpt.Report_BeforePrint
        'Added By KapilGK On 7 Jul 2006 For RoamWare Customization
        If Args.ReportID = 2066 Then
            ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
            ''Dim intWidth As Integer = CommonFunction.Data.GetDataScalar("Select Count(ProductID) From Tbl_PRD_Product", True)
            Dim intWidth As Integer = CommonFunction.Data.GetDataScalar("usp_sel_Tbl_PRD_Product_Product", True)
            Args.Width = intWidth + 4
            If Args.Width < 10 Then
                Args.Width = 10
            End If
        End If
        If Args.ReportID = 2067 Then
            ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
            ''Dim intWidth As Integer = CommonFunction.Data.GetDataScalar("select Count(CompetitorID) from Tbl_RW_Product_Competitior", True)
            Dim intWidth As Integer = CommonFunction.Data.GetDataScalar("usp_sel_Tbl_RW_Product_Competitior_CompetitorID", True)
            Args.Width = intWidth + 2
            If Args.Width < 10 Then
                Args.Width = 10
            End If
        End If
        If Args.ReportID = 2070 Then
            ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
            ''Dim intWidth As Integer = CommonFunction.Data.GetDataScalar("select Count(Distinct Type) from v_TBL_IB_Issue", True)
            Dim intWidth As Integer = CommonFunction.Data.GetDataScalar("usp_sel_v_TBL_IB_Issue_DistinctType", True)
            Args.Width = intWidth + 9
            If Args.Width < 10 Then
                Args.Width = 10
            End If
        End If
        'End of 'Addition By KapilGK On 7 Jul 2006 For RoamWare Customization
        'Code Added By PradipK on 28 Juky 2006 for CustomerWise KPI Report,Roamware Customization
        If m_lngReportID = 2029 Then
            ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
            ''Dim intWidth As Integer = CommonFunction.Data.GetDataScalar(" SELECT COUNT(GroupId) AS CountGroupId FROM tbl_CNF_SLAGroups ", True)
            Dim intWidth As Integer = CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_SLAGroups_GroupId", True)

            Args.Width = (intWidth * 2) + (4 * 3)
            If Args.Width < 10 Then
                Args.Width = 10

            End If
        End If
        'End Addition By Pradipk on 28 Juky 2006
        'Code Added By PradipK on 28 Juky 2006 for CustomerWise KPI Report,Roamware Customization
        If m_lngReportID = 2030 Then
            ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
            ''Dim intWidth As Integer = CommonFunction.Data.GetDataScalar(" SELECT COUNT(GroupId) AS CountGroupId FROM tbl_CNF_SLAGroups ", True)
            Dim intWidth As Integer = CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_SLAGroups_GroupId", True)
            Args.Width = (intWidth * 2) + (13 * 3)
            If Args.Width < 10 Then
                Args.Width = 10

            End If
        End If
        'End Addition By Pradipk on 28 Juky 2006
        
    End Sub

    Private Sub oRpt_DynamicDataGrid_Control_BeforePlot(ByRef Cancel As Boolean, ByRef Args As AdHocReports.WAF_Control) Handles oRpt.DynamicDataGrid_Control_BeforePlot
        'Added By KapilGK On 10 Jul 2006 For RoamWare Customization
        Const intProductCustomerReportID As Integer = 2066
        Const intProductCompetitorReportID As Integer = 2067
        Const intProductQualityReportID As Integer = 2070

        If Args.ReportID = intProductCustomerReportID Then
            'If Args.ControlName.ToUpper = "TOTAL PRODUCT" Then
            '    Args.FontStyle = "BOLD"
            'End If
            If Args.ControlName.ToUpper <> "CUSTOMER" And Args.ControlName.ToUpper <> "REGION" Then
                Args.Alignment = 2
            End If
        End If

        If Args.ReportID = intProductCompetitorReportID Then
            'If Args.ControlName.ToUpper = "TOTAL COMPETITOR" Then
            '    Args.FontStyle = "BOLD"
            'Else
            '    Args.FontStyle = "REGULAR"
            'End If
            If Args.ControlName.ToUpper <> "PRODUCT" Then
                Args.Alignment = 2
            End If
        End If

        If Args.ReportID = intProductQualityReportID Then
            If Args.ControlName.ToUpper <> "PRODUCT" And Args.ControlName.ToUpper <> "SEVERITY" Then
                Args.Alignment = 2
            End If
        End If

        'End of 'Addition By KapilGK On 10 Jul 2006 For RoamWare Customization

        'Code Added By PradipK on 28 Juky 2006 for CustomerWise KPI Report,Roamware Customization
        If m_lngReportID = 2029 Then
            If Args.ControlName.ToUpper <> "CUSTOMER" And Args.ControlName.ToUpper <> "PRIORITY" And Args.ControlName.ToUpper <> "SEVERITY" And Args.ControlName.ToUpper <> "COMPLEXITY" Then
                Args.Alignment = 2
            End If

            If Args.ControlName.ToUpper <> "CUSTOMER" And Args.ControlName.ToUpper <> "PRIORITY" And Args.ControlName.ToUpper <> "SEVERITY" And Args.ControlName.ToUpper <> "COMPLEXITY" Then
                ' Args.Line_Width = 3
            End If

            'If Args.ControlName.ToUpper = "CUSTOMER" Then
            '    If Args.DataField.ToString = PreCustomerName Then
            '        ' Args.OutPutFormat = ""
            '    Else
            '        PreCustomerName = Args.DataField.ToString
            '    End If
            'End If

        End If
        'End Addition By Pradipk on 28 Juky 2006
    End Sub
    Protected Sub DrawPageHeader()
        If m_lngReportID = 2121 Then
            CommonFunctions.General.PlotPageHeadTag("Employee Resume")
        Else
            CommonFunctions.General.PlotPageHeadTag("ReportHanddler")
        End If
    End Sub
    Private Sub oRpt_Control_BeforePlot(ByRef Cancel As Boolean, ByRef Args As AdHocReports.WAF_Control) Handles oRpt.Control_BeforePlot
        ' Added By MahendraV On 18-Oct-2007 For WhizibleSEM 7.1 
        ' Purpose: To set the employee resume image path dynamically.
        ' Start_MV_18-Oct-2007

        If Args.ReportID = 2121 Then
            If Args.ControlType.ToUpper() = "IMAGE" Then
                ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                ''Dim strEmloyeeImagePath As String = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT '../../Images/Photo/' + SystemFilename FROM tbl_RM_EmployeeMaintenance_Attachment  WHERE EmployeeID=" & m_intEmployeeID, MyBase.UseSQL), ""))
                Dim strEmloyeeImagePath As String = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_RM_EmployeeMaintenance_Attachment_Images " & m_intEmployeeID, MyBase.UseSQL), ""))
                If Not strEmloyeeImagePath Is Nothing Then
                    'Args.ImagePath = strEmloyeeImagePath
                End If

            End If

        End If

        ' End_MV_18-Oct-2007
    End Sub
End Class
