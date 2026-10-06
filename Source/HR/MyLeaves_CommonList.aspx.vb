Imports CommonEngines.General.cEventHandlers
Imports CommonEngines.EventHandlers.WAF_Controls
Public Class MyLeaves_CommonList
    Inherits CommonList

    Dim strLeaveStatus As String = ""

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "MyLeaves_CommonList.aspx"
        MyBase.strFormPage = "MyLeaves_CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)

    End Sub
#End Region


    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
    End Function


    Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)
        '''Added by ManishK  on 10 Feb 2006 as on clicking cancel link Email should fire

        If WhizGlobal.ParentTagID = 0 Then
            'For Master Tag

            If Args.ClientSideFunctionName.ToUpper = "CANCEL_ONCLICK" Then
                Dim strFunction As String
                'Dim strGetServerDateSQL As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
                'Dim strGetServerDate As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

                strFunction = "var bConfirmed;" + vbCrLf
                'Added By shraddhaM on 20,Mar 2007
                'Purpose : When we cancel Leave then validate today's date should not be greater than Leave ToDate
                strFunction += "var objToDate = GetObjectReference('frmCommonList',lngUniqueID);" + vbCrLf
                strFunction += "var objServerDate = GetObjectReference('frmCommonList','txtserverDate');" + vbCrLf

                strFunction += " if (disallowDate1LessThanDate2(objToDate,objServerDate,'Leave Cancellation not allowed since Leave Date occurs in past'))return ;" + vbCrLf
                'End of addition By shraddhaM on 20,Mar 2007
                'Purpose : When we cancel Leave then validate today's date should not be greater than Leave ToDate

                strFunction += "bConfirmed = window.confirm('Do you want to cancel the request?');" + vbCrLf
                strFunction += "if (bConfirmed == false){" + vbCrLf


                'Comment and modified By VarunA on 10-May-2007 Clean Activity for Leave Workflow
                'strFunction += "return;}else{window.open('../General/SendEmail.aspx?MessageID=84&LeaveID=' + lngUniqueID + '',null,'status=no,toolbar=no,menubar=no,width=600,height=500');}"
                strFunction += "return;} " + vbCrLf
                Dim drEmail As IDataReader
                Dim blnSendMail As Boolean
                Dim blnShowPopup As Boolean

                drEmail = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 84", MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drEmail) <> "" Then
                    If drEmail.Read() Then
                        blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("SendMail"), "False"), Boolean)
                        blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("ShowPopup"), "False"), Boolean)
                    End If
                End If
                CommonFunctions.Data.DisposeDataReader(drEmail)
                If blnSendMail = True Then
                    If blnShowPopup = True Then
                        strFunction += "else{window.open('../General/SendEmail.aspx?MessageID=84&LeaveID=' + lngUniqueID + '',null,'status=no,toolbar=no,menubar=no,width=600,height=500');}"
                    End If
                End If
                'End By VarunA on 10-May-2007

                Args.ToBeInserted = strFunction
            End If

        Else
        End If
        '''End of Added by ManishK  on 10 Feb 2006 as on clicking cancel link Email should fire

    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cLeave_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function


End Class

Public Class cLeave_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Commented By VidyaJ - issueID - 11283
        'Instead Of Plotting the graph thro' code plot graph thro' framework graph section
        ''This Event will occur before 
        'If WhizGlobal.ParentTagID = 0 Then
        '    'For Master Tag
        '    'Added By JayavantK On 15-Oct-2004
        '    'Modified By SandeepA on 7 Dec,2005 for IssueID-672:the Change of DIV height for Whiz2.0 Integration (Earlier height:350px)
        '    CommonFunctions.General.WriteHTML("<DIV Id=divList Style='HEIGHT:400px; OVERFLOW:auto; WIDTH:100%'>")
        '    'End of Modification by SandeepA on 7 dEC,2005.
        '    'End Addition
        'Else
        'End If

        'Added By shraddhaM on 20,Mar 2007 for T-System
        'Purpose : When we cancel Leave then validate today's date should not be greater than Leave ToDate

        Dim strGetServerDateSQL As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
        Dim strGetServerDate As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
        HttpContext.Current.Response.Write("<input type = hidden id =txtserverDate value = '" + strGetServerDate + "'  >")
        'End of addition By shraddhaM on 20,Mar 2007 for T-System
        'Purpose : When we cancel Leave then validate today's date should not be greater than Leave ToDate

        MyBase.Initialize_Grid(Cancel, Args, WhizGlobal)

    End Sub
    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If WhizGlobal.ParentTagID = 0 Then
            'For Master Tag
            Dim lngLeaveStatusId As Long
            Dim strScript As String
            lngLeaveStatusId = CType("0" & CommonFunctions.General.CheckIsNothing(Args.DataReader.Item("LeaveStatusID"), "0"), Long)
            'commented by HarshK on 08-Mar-2006 
            ''if status is not submmitted then disable the link
            'Added By Chakshuta H on 12th Aug 2014
            'If the leave is submitted it should not be deleted
            If (Args.ColumnName.ToUpper = "DELETE") Then
                If lngLeaveStatusId = 1 Then
                    'If Args.DataField.ToUpper = "LEAVESTATUS" Then
                    'Args.EnableLink = False
                    'Args.IsCheckBoxDisabled = True
                    'strScript += "  var objstatus; " + vbCrLf
                    'strScript += "objstatus = GetObjectReference('frmCommonList', 'chkDelete');" + vbCrLf
                    'strScript += "{ objstatus.disabled = true;"
                    'strScript += "}" + vbCrLf
                    Args.StringToBeInserted = "<TD align='center'>"
                    'Args.StringToBeInserted = "<TD align='center'><input type='checkbox' disabled='true'></TD>"
                    Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkStatus", "chkLeaveShow", , , , True, , True, , , , )
                    Args.StringToBeInserted &= "</TD>"

                    Cancel = True
                    'Args.Editable = False
                End If
            End If
            'Ended By Chakshuta H 12th Aug 2014
            'End commented by HarshK on 08-Mar-2006 


            'Added By NitinVS on 14 May 2007 for WhizibleSEM 7.0 for Performace 
            ' Removed the Conditional clause for the link and added the condition in code.

            If (Args.ColumnName.ToUpper = "VIEW COMMENTS") Then
                If lngLeaveStatusId <> 2 And lngLeaveStatusId <> 3 Then
                    Args.StringToBeInserted = "<TD align='center'>-</TD>"
                    Cancel = True
                End If
                ' if The Leave is cancelled remove the cancel link
            ElseIf (Args.ColumnName.ToUpper = "CANCEL") Then
                If lngLeaveStatusId = 4 Then
                    Args.StringToBeInserted = "<TD align='center'>-</TD>"
                    Cancel = True
                End If
            End If

            ' End Addition BY NitinVS on 14 May 2007 for WhizibleSEM 7.0 for Performace 

        Else
        End If

        ''Modified and Commented By VarunA on 21-Sep-2007 Whizible 7.1 Development & Release (HotFix 7.0.016)
        ''Purpose : When we cancel Leave then validate today's date should not be greater than Leave FromDate

        'Added By shraddhaM on 20,Mar 2007 for T-System
        'Purpose : When we cancel Leave then validate today's date should not be greater than Leave ToDate
        ''If Args.ColumnName = "To Date" Then
        ''    'Dim strGetToDateSQL As String = "select REPLACE((convert(varchar(50),cast('" + Args.DataReader("ToDate").ToString + "' AS SMALLDATETIME ),106)) ,' ','-')"
        ''    'Dim strGetToDate As String = CommonFunction.Data.GetDataScalar(strGetToDateSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
        ''    Dim strGetToDate As Date = CType(Args.DataReader("ToDate").ToString, Date)

        ''    'Dim strGetToDate As String = CommonFunction.Data.GetDataScalar(strGetToDateSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

        ''    HttpContext.Current.Response.Write("<input type=hidden id=" + Args.DataReader("LeaveID").ToString + " value='" + strGetToDate.ToString("dd-MMM-yyyy") + "'  >")

        ''End If
        'End of addition By shraddhaM on 20,Mar 2007 for T-System
        'Purpose : When we cancel Leave then validate today's date should not be greater than Leave ToDate

        If Args.ColumnName = "From Date" Then
            Dim strGetFromDate As Date = CType(Args.DataReader("FromDate").ToString, Date)
            HttpContext.Current.Response.Write("<input type=hidden id=" + Args.DataReader("LeaveID").ToString + " value='" + strGetFromDate.ToString("dd-MMM-yyyy") + "'  >")
        End If
        ''End By VarunA on 21-Sep-2007 Whizible 7.1 Development & Release (HotFix 7.0.016)

    End Sub

    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Commented By VidyaJ - issueID - 11283
        'Instead Of Plotting the graph thro' code plot graph thro' framework graph section

        'If WhizGlobal.ParentTagID = 0 Then
        '    'For Master Tag
        '    'Added By JayavantK On 15-Oct-2004
        '    PlotLeavesGraph(WhizGlobal.UserID)
        '    CommonFunctions.General.WriteHTML("</Div>")
        '    'End Addition
        'Else
        'End If

    End Sub
    Private Shared Sub PlotLeavesGraph(ByVal lngUserID As Long)
        '====================================================================
        ' Procedure Name       : PlotLeavesGraph
        ' Parameters Passed    : lngUserID = User ID
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : To Plot the Balance Leaves Vs.Total Leaves graph.
        ' Description          : Since the graph need to plot on the list page (not on form) need to write
        '                        this procedure.
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : October 15, 2004
        ' Revisions            : 
        '=====================================================================
        Dim objGraph As New Graph.Graph
        Dim strVirtualImgPath As String = ""
        Dim strImageFileName As String = ""
        Dim strQuery As String = ""
        Dim arrChartType As String() = {"Column", "Column", "Column", "Column", "Column"}
        Dim objSectionHead As WebPages.Template.SectionTitle
        Dim objTemplate As New WebPage.Templates.WhizTemplate
        objTemplate.InitializeResources("AppResources.EventHandlers", "AppResources")

        objSectionHead = New WebPages.Template.SectionTitle
        With objSectionHead
            CommonFunctions.General.WriteHTML(.GetSectionTitle(objTemplate.GetResourceString("GRAPH_SECTION"), "divGraphSection", "ShowHide_divGraphSection", , , , , , , ))
            CommonFunctions.General.WriteHTML(System.Environment.NewLine + "<SCRIPT language=javascript>" + System.Environment.NewLine)
            CommonFunctions.General.WriteHTML(.ClientsideScript())
            CommonFunctions.General.WriteHTML(System.Environment.NewLine + "</SCRIPT>" + System.Environment.NewLine)
        End With
        objSectionHead = Nothing

        CommonFunctions.General.WriteHTML("<DIV Id='divGraphSection' Style='HEIGHT:150px;'>")
        CommonFunction.General.WriteHTML("<Table class=clsTable cellspacing=1 cellpadding=0 border=0>")
        CommonFunction.General.WriteHTML("<TR><TD>")

        strImageFileName = CommonFunction.FileDirectory.GetUniqueFileName
        strVirtualImgPath = CommonFunction.Constants.CLCP_IMAGES_FOLDER_PATH + "/" + strImageFileName

        strQuery = "select LeaveType AS [Leave Type], NoOfLeaves AS [Total Leaves], LeaveBalance "
        strQuery = strQuery + " AS [Balance Leaves] from d_tbl_PM_EmployeeLeaveMaster "
        strQuery = strQuery + " where EmployeeID=" + lngUserID.ToString() + " Order By LeaveType "

        With objGraph
            .AbsoluteImagePath = HttpContext.Current.Server.MapPath(strVirtualImgPath)
            .BorderColor = "white"
            .BorderGradientColor = "Blue"
            .BorderGradientStyle = "TopBottom"
            .BorderStyle = "FRAMETITLE5"
            .ChartAreaColor = "skyBlue"
            .ChartAreaGradientColor = "white"
            .ChartAreaGradientStyle = "TopBottom"
            .ChartBackColor = "Beige"
            .ChartBackGradientColor = "White"
            .ChartBackGradientStyle = "TopBottom"
            .ChartType = arrChartType
            .ConnectionString = CommonFunction.Application.ConnectionString
            .Enable3D = False
            .GraphTitle = objTemplate.GetResourceString("GRAPH_TITLE")
            .GraphTitleColor = "Black"
            .Height = 300
            .LegendCaptionColor = "Black"
            .LegendFont = New System.Drawing.Font("Microsoft Sans Serif", 9, System.Drawing.FontStyle.Regular)
            .PalleteStyle = "excel"
            .PieChartLabelStyle = ""
            .ShowExplodedPie = False
            .ShowLegends = True
            .SQL = strQuery
            .TitleFont = New System.Drawing.Font("Microsoft Sans Serif", 9, System.Drawing.FontStyle.Bold)
            .VirtualImagePath = strVirtualImgPath
            .Width = 600
            .EnableSmartLabels = True
            .ShowCaptions = True
            .GenerateImage()
        End With
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawImage(strVirtualImgPath + ".png", , , , , , , True))

        CommonFunction.General.WriteHTML("</TD></TR></TABLE></DIV>")
        objGraph = Nothing
        objTemplate = Nothing
    End Sub


End Class
