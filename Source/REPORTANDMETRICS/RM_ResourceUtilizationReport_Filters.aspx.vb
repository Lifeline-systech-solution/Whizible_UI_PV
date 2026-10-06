Public Class RM_ResourceUtilizationReport_Filters
    Inherits WebPage.Templates.WhizTemplate
    '=====================================================================
    ' Class	Name	        :	RM_ResourceUtilizationReport_Filters
    ' Purpose				:	Page for applying filters on resource utilization
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SuchitraP
    ' Created				:	Jan 10, 2008
    ' Revisions				:	
    '=====================================================================
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
        ' Added Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting


        MyBase.ApplySecurity(True)
        ' End Added Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
    End Sub

#End Region
    Protected m_strMode As String
    Protected m_ShowDeployableOnly As String = "0"
    Protected m_strBUID As String = "NULL"
    Protected m_strOUID As String = "NULL"
    Protected m_strEmployeeID As String = "NULL"
    Protected m_strDUID As String = "NULL"
    Private m_strDateRangeID As String = "NULL"
    Private m_DateRangeID As String = "NULL"
    Protected m_strSessionUserID As String = "NULL"
    Protected m_strProjectFilters As String = ""
    'FilterID
    Protected m_FilterID As String = "NULL"
    Protected m_strMonth As String = ""

    Public Const GRAPH_DIRECTORY As String = "../../images/DB_Graphs/"

    Private m_strAction As String
    Private m_FromWhere As String
    Private m_intGraphHeight As Integer
    Private m_intGraphWidth As Integer
    Private m_strUserName As String
    Private m_TotalRecords As Integer

    Private WithEvents objListGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objListSummaryGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objGrid As New WebPage.Templates.GenericGrid

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

    Private m_GrandTotalCapacity As Double = 0
    Private m_GrandTotalAllocated As Double = 0
    Private m_GrandTotalActual As Double = 0
    Private m_GrandTotalBillable As Double = 0
    Private m_GrandTotalCapacityPer As Double = 0
    Private m_GrandTotalAllocatedPer As Double = 0
    Private m_GrandTotalActualPer As Double = 0
    Private m_GrandTotalBillablePer As Double = 0
    Private m_GrandInstallCapacity As Double = 0
    Private m_GrandCapacityPer As Double = 0
    Private m_GrandAllocatedPer As Double = 0
    Private m_GrandActualPer As Double = 0
    Private m_GrandBillablePer As Double = 0
    Private m_IsExist As Boolean = False

    Protected m_lngQueryID As String
    Protected m_lngQueryID_Filter As String
    Protected m_TokenKEY As String


    Protected m_PKToken_FromDT As String = ""

    Protected m_PKToken_FromRequestDetail As String
    ''11 Aug 2016
    Protected m_PKToken_Flag As String
    ''11 Aug 2016





    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Added by Shamkant S on 28-Jan-2016 to Generate and Validate Token
        Dim strOUD, strDUID, FrmWhere As String
        If Not Request.QueryString("FromWhere") Is Nothing Then
            FrmWhere = CType(Request.QueryString("FromWhere"), String)
        Else
            FrmWhere = 0
        End If
        If Not Request.QueryString("ResourceID") Is Nothing Then
            m_lngQueryID = CType(Request.QueryString("ResourceID"), String)
        Else
            m_lngQueryID = 0
        End If
        If Not Request.QueryString("FilterID") Is Nothing Then
            m_lngQueryID_Filter = CType(Request.QueryString("FilterID"), String)
        Else
            m_lngQueryID_Filter = 0
        End If
        If Not Request.QueryString("DateRangeID") Is Nothing Then
            m_DateRangeID = CType(Request.QueryString("DateRangeID"), String)
        Else
            m_DateRangeID = 0
        End If
        If Not Request.QueryString("PKToken") Is Nothing Then
            '  m_TokenKEY = CType(Request.QueryString("PKToken"), String)
            m_PKToken_FromDT = Trim(Request.QueryString("PKToken") & "")
        End If
        If Request.QueryString("DUID") IsNot Nothing Then
            strDUID = CType(Request.QueryString("DUID"), String)
        Else
            strDUID = "0"
        End If
        If Request.QueryString("OUID") IsNot Nothing Then
            strOUD = CType(Request.QueryString("OUID"), String)
        Else
            strOUD = "0"
        End If
        If Not Request.QueryString("Flag") Is Nothing Then
            m_PKToken_Flag = Trim(Request.QueryString("Flag") & "")
        End If



        'If m_PKToken_FromDT <> "" And Request.QueryString("Mode") = "DisplayDetails" Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(m_lngQueryID, String) + "0" + "0", m_PKToken_FromDT) = False) Then

        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "ResourceID", CType(m_lngQueryID, String))
        '        'Token is Invalid now redirect to the Invalid Access Page

        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")


        '    End If

        'End If
       

        ''Added by Dhanashri S on 28 Mar 2016
        ''Added by Dhanashri S on 28 Mar 2016
        ''If (Request.QueryString("PKResUtilToken") = "" And HttpContext.Current.Session("intUserID") <> 0) Then
        If (m_PKToken_Flag = "FromCalender") Then
            If (Request.QueryString("PkToken") = "" And HttpContext.Current.Session("intUserID") <> 0) Then
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                ''End of Addition by Dhanashri S on 11 Aug 2016
            Else
                If (Request.QueryString("PkToken") <> "" And Request.QueryString("ResourceID") <> "") Then
                    If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ResourceID"), String) + "0" + "0", Request.QueryString("PkToken")) = False) Then

                        ''Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("ResourceID"), String))
                        'Token is Invalid now redirect to the Invalid Access Page
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    End If
                End If
            End If
        End If
        ''End of Addition by Dhanashri S on 28 MAr 2016

        If (m_PKToken_Flag = "FromProjectAlloc") Then
            If (Request.QueryString("PkToken") = "" And HttpContext.Current.Session("intUserID") <> 0) Then
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                ''End of Addition by Dhanashri S on 11 Aug 2016
            Else
                If Request.QueryString("ResourceID") IsNot Nothing And Request.QueryString("DateRangeID") IsNot Nothing And Request.QueryString("Mode") = "DisplayDetails" And Request.QueryString("FromWhere") = "RCV" Then
                    If Request.QueryString("PKToken") IsNot Nothing Then
                        If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ResourceID"), String) + CType(Request.QueryString("DateRangeID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then
                            'Token is Invalid now redirect to the Invalid Access Page
                            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                        End If


                    End If
                End If
            End If
        End If


                If (Request.QueryString("FilterID") IsNot Nothing And Request.QueryString("DateRangeID") IsNot Nothing) And (Request.QueryString("Mode") = "Generate" Or Request.QueryString("Mode") = "DisplayDetails" Or Request.QueryString("Mode") = "DisplaySummaryDetails") Then
                    If Request.QueryString("PKToken") IsNot Nothing And Request.QueryString("FromWhere") <> "RCV" Then
                        If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("BUID"), String) + CType(Request.QueryString("OUID"), String) + CType(Request.QueryString("DUID"), String) + CType(Request.QueryString("ResourceID"), String) + CType(Request.QueryString("FilterID"), String) + CType(Request.QueryString("DateRangeID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then
                            'Token is Invalid now redirect to the Invalid Access Page
                            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                        End If


                    End If
                End If



                'End of addition by Shamkant S on 28-Jan-2016 to Generate and Validate Token
                ''commented by nilesh g on 31/12/2015 for Security
                'If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
                '    Response.Write(vbCrLf + "<script>")
                '    Response.Write(vbCrLf + "		if (window.opener == null)")
                '    Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
                '    If strRedirectToPage.Trim = "" Then
                '        Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
                '    Else
                '        Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
                '    End If
                '    Response.Write(vbCrLf + "</script>")
                'End If
                ''end of commented by nilesh g on 31/12/2015 for Security
                'Put user code to initialize the page here
    End Sub
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_Print_OnClick(ReportID As String, ResourceID As String, DateRangeID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(ReportID, String) + CType(ResourceID, String) + CType(DateRangeID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateToken__OnClick(BUID As String, OUID As String, DUID As String, ResourceID As String, FilterID As String, DateRangeID As String) As String
        Try
            Dim m_PKToken_Request_Filter As String
            m_PKToken_Request_Filter = CommonFunctions.Security.Token.GetToken(CType(BUID, String) + CType(OUID, String) + CType(DUID, String) + CType(ResourceID, String) + CType(FilterID, String) + CType(DateRangeID, String) + "0" + "0")

            Return m_PKToken_Request_Filter
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
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
        ' Author                : SuchitraP
        ' Created               : Jan 10, 2008
        ' Revisions             :
        '=====================================================================
        Call SetVariables()

        Response.Write(GenerateMenu(True))


        'Initialize resource file 
        MyBase.InitializeResources("AppResources.RM_ResourceUtilizationReport", "AppResources")
        'Response.Write("<TABLE id='tblLegend' CellSpacing=0 width='99.9%' class=clsTable><TR class=clsTRBlank>")
        'Response.Write("<TD align='Right'><B><font Face='Verdana' color='white' size='1'>(Blue color indicates applied filter)")
        'Response.Write("</FONT></B></TD></TR></TABLE>")
        Response.Write("<BR>")
        If m_FromWhere.ToUpper = "RCV" Then
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Resource Utilization", "Period " + CommonFunction.HTMLControls.DrawComboBox("cboDateRange", "usp_sel_DateRange_For_ResourceUtilization Null ,0", 200, m_strDateRangeID.ToString, "onchange=Period_Onchange()", False, True, "clsComboBox"), , True))
        Else
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Resource Utilization", , , True))
        End If

        Response.Write("<BR>")
        Call DisplayPageDetails()

        If m_strMode = "" Then

            CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 Width='99.9%' height=2px class=clsTable><TR class=clsTRPageFooter " + ">")


            'Commented and Added by Yogesh J on 09 Oct 2015 for font size increment


            'CommonFunctions.General.WriteHTML("<TD class=clsTDEven width=10% align=right ><b> Note : </b> </TD> ")
            'CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left >Select appropriate filter to view the Resource Utilization.</TD></TR> ")
            CommonFunctions.General.WriteHTML("<TD class=clsTDEven width=10% align=right style='font-size:12px'><b> Note : </b> </TD> ")
            CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left style='font-size:12px'>Select appropriate filter to view the Resource Utilization.</TD></TR> ")

            'End Addition by Yogesh J on 09 Oct 2015 for font size increment

            CommonFunctions.General.WriteHTML("</Table><BR>")
        End If

        Response.Write(GenerateMenu(False))



        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidFilterID' id='hidFilterID' value='" + m_FilterID + "'>")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidDateRangeID' id='hidDateRangeID' value='" + m_strDateRangeID + "'>")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidResourceID' id='hidResourceID' value='" + m_strEmployeeID + "'>")



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
        ' Author                : SuchitraP
        ' Created               : Jan 10, 2008
        ' Revisions             :
        '=====================================================================

        m_intGraphHeight = 450
        m_intGraphWidth = 600

        If Not Request.QueryString("Mode") Is Nothing Then
            If Request.QueryString("Mode") <> "" Then
                m_strMode = Request.QueryString("Mode")
            Else
                m_strMode = ""
            End If
        Else
            m_strMode = ""
        End If

        If Not Request.QueryString("FromWhere") Is Nothing AndAlso Request.QueryString("FromWhere") <> "" Then
            m_FromWhere = Request.QueryString("FromWhere")
        Else
            m_FromWhere = ""
        End If

        m_strSessionUserID = CType(Session("intUserID"), String)
        m_strUserName = Session("strUserName").ToString
        m_strProjectFilters = ""


        If Not Request.QueryString("ShowDeployableOnly") Is Nothing Then
            m_ShowDeployableOnly = Request.QueryString("ShowDeployableOnly")
        Else
            m_ShowDeployableOnly = "0"
        End If



        ' Date Range 
        If Not Request.QueryString("DateRangeID") Is Nothing AndAlso Request.QueryString("DateRangeID") <> "" Then
            m_strDateRangeID = Request.QueryString("DateRangeID")
        ElseIf Not Request.Form("cboDateRange") Is Nothing AndAlso Request.Form("cboDateRange") <> "" Then
            m_strDateRangeID = Request.Form("cboDateRange")
        ElseIf Not Request.Form("hidDateRangeID") Is Nothing AndAlso Request.Form("hidDateRangeID") <> "" Then
            m_strDateRangeID = HttpContext.Current.Request.Form("hidDateRangeID") & ""
        Else
            m_strDateRangeID = "3"
        End If


        If Not Request.QueryString("FilterID") Is Nothing Then
            m_FilterID = Request.QueryString("FilterID")
        ElseIf Not Request.Form("cboAppliedView") Is Nothing AndAlso Request.Form("cboAppliedView") <> "" Then
            m_FilterID = Request.Form("cboAppliedView")
        ElseIf Not Request.Form("hidFilterID") Is Nothing AndAlso Request.Form("hidFilterID") <> "" Then
            m_FilterID = HttpContext.Current.Request.Form("hidFilterID") & ""
        Else
            m_FilterID = "NULL"
        End If



        If Not Request.QueryString("ResourceID") Is Nothing OrElse Request.QueryString("ResourceID") <> "" Then
            m_strEmployeeID = Request.QueryString("ResourceID")
        ElseIf Not Request.Form("hidResourceID") Is Nothing OrElse Request.Form("hidResourceID") <> "" Then
            m_strEmployeeID = Request.Form("hidResourceID")
        Else
            m_strEmployeeID = "NULL"
        End If



    End Sub


    Private Function GenerateMenu(ByVal isUp As Boolean) As String
        '=====================================================================
        ' function Name         : GenerateTopMenu()	
        ' Purpose               : To generate top menu
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuchitraP
        ' Created               : Jan 10, 2008
        ' Revisions             :
        '=====================================================================

        Dim ArrTopMenuCaptionsList As New ArrayList
        Dim ArrTopMenuToolTipsList As New ArrayList
        Dim ArrTopMenuFunctionsList As New ArrayList

        If m_strMode <> "" Then

            'Initialize resource file 
            MyBase.InitializeResources("AppResources.RM_ResourceUtilizationReport", "AppResources")
            If m_strMode.ToUpper <> "GENERATE" And m_strMode.ToUpper <> "DISPLAYDETAILS" And m_strMode.ToUpper <> "DISPLAYSUMMARYDETAILS" Then

                'Filter menu
                'CommonFunctions.General.WriteHTML("|&nbsp;<img id='imgFilter' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Filter.gif' alt='Filter' onclick='showFilters(1)'/>&nbsp;")

                'If isUp Then
                '    ArrTopMenuCaptionsList.Add("<img id='imgFilterUp' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Filter.gif'")
                '    ArrTopMenuToolTipsList.Add("Filter")
                '    ArrTopMenuFunctionsList.Add("showFilters('up')")
                'Else
                '    ArrTopMenuCaptionsList.Add("<img id='imgFilterDown' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Filter.gif'")
                '    ArrTopMenuToolTipsList.Add("Filter")
                '    ArrTopMenuFunctionsList.Add("showFilters('down')")
                'End If


                'Generate Report
                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_GENERATEREPORT"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_GENERATEREPORT_TOOLTIP"))
                ArrTopMenuFunctionsList.Add("GenerateReport()")

                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DISPLAYSUMMARYDETAILS"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DISPLAYSUMMAYDETAILS_TOOLTIP"))
                ArrTopMenuFunctionsList.Add(" DisplaySummaryDetails_OnClink('" + m_strBUID + "','" + m_strOUID + "','" + m_strDUID + "','" + m_strEmployeeID + "','" + m_strDateRangeID + "')")


                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DISPLAYDETAILS"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DISPLAYDETAILS_TOOLTIP"))
                ArrTopMenuFunctionsList.Add(" DisplayDetails_OnClink('" + m_strBUID + "','" + m_strOUID + "','" + m_strDUID + "','" + m_strEmployeeID + "','" + m_strDateRangeID + "')")


            Else
                'Initialize resource file 
                If m_strMode.ToUpper <> "DISPLAYDETAILS" And m_strMode.ToUpper <> "DISPLAYSUMMARYDETAILS" Then

                    MyBase.InitializeResources("AppResources.RM_ResourceUtilizationReport", "AppResources")
                    ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DISPLAYSUMMARYDETAILS"))
                    ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DISPLAYSUMMAYDETAILS_TOOLTIP"))
                    ArrTopMenuFunctionsList.Add(" DisplaySummaryDetails_OnClink('" + m_strBUID + "','" + m_strOUID + "','" + m_strDUID + "','" + m_strEmployeeID + "','" + m_strDateRangeID + "')")


                    ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DISPLAYDETAILS"))
                    ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DISPLAYDETAILS_TOOLTIP"))
                    ArrTopMenuFunctionsList.Add(" DisplayDetails_OnClink('" + m_strBUID + "','" + m_strOUID + "','" + m_strDUID + "','" + m_strEmployeeID + "','" + m_strDateRangeID + "')")

                End If

                'To allow user to see utilization for deployable only or all
                If m_strMode.ToUpper = "DISPLAYDETAILS" Or m_strMode.ToUpper = "DISPLAYSUMMARYDETAILS" Or m_strMode.ToUpper = "GENERATE" Then
                    'For removing show deployable link when EmployeeID is not null
                    If m_strEmployeeID Is Nothing OrElse m_strEmployeeID = "NULL" Then

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
                End If

                If m_strMode.ToUpper = "DISPLAYDETAILS" Or m_strMode.ToUpper = "DISPLAYSUMMARYDETAILS" Then
                    ArrTopMenuCaptionsList.Add("Print")
                    ArrTopMenuToolTipsList.Add("Print")
                    ArrTopMenuFunctionsList.Add("Print_Onclick('" + m_strBUID + "','" + m_strOUID + "','" + m_strDUID + "','" + m_strEmployeeID + "','" + m_strDateRangeID + "')")
                End If

                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
                ArrTopMenuFunctionsList.Add(" Close_OnClink()")

            End If
        End If


        'Initialize resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        ArrTopMenuFunctionsList.Add("Help_OnClick('MC_RU')")

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

    Private Sub DisplayPageDetails()
        If m_strMode = "" Then
            Call drawResourceUtilizationFilters()
            'CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width=99.9% class=clsTable><TR class='clsTREven'><TD align=right>Total number of records :" + CType(m_TotalRecords, String) + "</TD></TR></TABLE>")
        Else
            Call drawAppliedFilterView()

            If m_strMode.ToUpper = "GENERATE" Then
                CommonFunction.General.WriteHTML("<div id=DivGraph style='Overflow:auto;width:100%;height:380' >")
            End If
            CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTREven " + ">")
            If m_strMode.ToUpper = "GENERATE" Then
                CommonFunctions.General.WriteHTML(" <TD align=center>")
                Call GenerateReportGraph()
                CommonFunctions.General.WriteHTML(" </TD></TR>")

                CommonFunctions.General.WriteHTML("</TABLE>")

                CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageFooter " + ">")
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
                CommonFunction.General.WriteHTML("</div>")
            Else
                CommonFunctions.General.WriteHTML(" <TD align=center>")
                If m_strMode.ToUpper = "DISPLAYDETAILS" Then
                    Call DisplayResourceDetails()
                ElseIf m_strMode.ToUpper = "DISPLAYSUMMARYDETAILS" Then
                    Call DisplaySummaryDetails()
                End If
                CommonFunctions.General.WriteHTML(" </TD></TR>")
                CommonFunctions.General.WriteHTML("</TABLE>")

            End If

        End If
    End Sub
    Private Sub drawResourceUtilizationFilters()
        Dim drReader As IDataReader
        Dim strSQL As String

        CommonFunctions.General.WriteHTML("<div id='FilterRecordsdiv' style='Overflow:auto;width:100%;Height:360px' >")

        CommonFunctions.General.WriteHTML("<TABLE id='tblMainPage' border=0 cellspacing=0 cellpadding=0 class=clsTable width=99.9%>")
        CommonFunctions.General.WriteHTML("<TR width=99.9% class=clsTRPageCaption colspan=4>")
        CommonFunctions.General.WriteHTML("<TD align='Center' > Period ")
        'CommonFunctions.General.WriteHTML("<TD align='Left'>")
        CommonFunction.HTMLControls.DrawComboBox("cboDateRange", "usp_sel_DateRange_For_ResourceUtilization Null ,0", 200, m_strDateRangeID.ToString, , False, False, "clsComboBox", True)
        'CommonFunctions.General.WriteHTML("</TD>")

        'CommonFunctions.General.WriteHTML("<TD align='Center' style='border-width:1px; CURSOR: hand;'> ")
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img style='CURSOR: hand;' id=imgAppView' Border=0 src='..\..\Images\cssImages\Link Images\Filter.gif' alt='Filter' onclick='javascript:CreateView()'>")
        'CommonFunctions.General.WriteHTML("</TD><TD align='Left'>")
        CommonFunction.HTMLControls.DrawComboBox("cboAppliedView", "Select FilterID,FilterName FROM tbl_PM_ResourceUtilization_Filters WHERE CreatedBy='" + m_strUserName + "' ORDER BY FilterName", 200, m_FilterID, , True, False, "clsComboBox", True)
        CommonFunctions.General.WriteHTML("</TD></TR>")

        CommonFunctions.General.WriteHTML("<TR width=99.9% class=clsTRPageCaption><TD colspan=4></TD></TR>")

        CommonFunctions.General.WriteHTML("<TR width=99.9% class=clsTRPageCaption>")
        CommonFunctions.General.WriteHTML("<TD align='Center' colspan=4><A class='clsSelected' HREF=""Javascript:GenerateReport()"" Title=""Show Graph"" >Show Graph</A>")
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;<A class='clsSelected' HREF=""Javascript:DisplaySummaryDetails_OnClink('" + m_strBUID + "','" + m_strOUID + "','" + m_strDUID + "','" + m_strEmployeeID + "','" + m_strDateRangeID + "')"" Title=""Display Summary "" >Display Summary</A>")
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;<A class='clsSelected' HREF=""Javascript:DisplayDetails_OnClink('" + m_strBUID + "','" + m_strOUID + "','" + m_strDUID + "','" + m_strEmployeeID + "','" + m_strDateRangeID + "')"" Title=""Display Details"">Display Details</A></TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</Table>")

        CommonFunctions.General.WriteHTML("</div>")

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
        ' Author                : SuchitraP
        ' Created               : Jan 11, 2008
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


        strSQL = " EXEC  usp_Sel_ResourceUtilization_Monthly_Filters " + m_strBUID + "," + m_strOUID + "," + m_strDUID + "," + m_strEmployeeID + "," + m_strDateRangeID + ",0" + "," + m_strSessionUserID + ",'" + m_strProjectFilters + "'," + m_FilterID + "," + m_ShowDeployableOnly

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
    Private Sub DisplayResourceDetails()
        Dim ArrActualFieldNames() As String = {"Month", "ResourceName", "InstallCapacityHrs", "CapacityHrs", "Capacity%", "AllocatedHrs", "Allocated%", "ActualHrs", "Actual%", "BillableHrs", "Billable%"}
        Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("MONTH"), MyBase.GetResourceString("EMPLOYEENAME"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT")}
        Dim ArrSummaryFunctions() As String = {"", "", "SUM", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG"}
        Dim ArrGroupSummaryFunctions() As String = {"", "", "SUM", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG"}
        Dim ArrTDStyle() As String = {"align=left width=8%", "align=left width=15%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%"}
        Dim strSQL As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQL = " EXEC  usp_Sel_ResourceUtilization_Monthly_Filters " + m_strBUID + "," + m_strOUID + "," + m_strDUID + "," + m_strEmployeeID + "," + m_strDateRangeID + ",1" + "," + m_strSessionUserID + "," + "'" + m_strProjectFilters + "'," + m_FilterID + "," + m_ShowDeployableOnly

        'CommonFunctions.General.PlotStaticHeaderStyle("DivList")

        With objListGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 11
            .DIVID = "DivList"
            .DIVStyle = "Overflow:auto;width:100%"
            .DIVHeight = 580
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
        Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("MONTH"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT")}
        Dim ArrSummaryFunctions() As String = {"", "SUM", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG"}
        Dim ArrGroupSummaryFunctions() As String = {"", "SUM", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG"}
        Dim ArrTDStyle() As String = {"align=left width=8%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%"}
        Dim strSQL As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQL = " EXEC  usp_Sel_ResourceUtilization_Monthly_Filters " + m_strBUID + "," + m_strOUID + "," + m_strDUID + "," + m_strEmployeeID + "," + m_strDateRangeID + ",2" + "," + m_strSessionUserID + "," + "'" + m_strProjectFilters + "'," + m_FilterID + "," + m_ShowDeployableOnly

        'CommonFunctions.General.PlotStaticHeaderStyle("DivList")

        With objListSummaryGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 11
            .DIVID = "DivList"
            .DIVStyle = "Overflow:auto;width:100%"
            .DIVHeight = 580
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
    Private Sub DrawEndRowForFilterTable(ByVal intTDCount As Integer)
        If (intTDCount Mod 3) = 0 Then
            CommonFunction.General.WriteHTML("</TR>")
            CommonFunction.General.WriteHTML("<TR class='clsTRPageCaption'>")
        End If
    End Sub
    Private Sub drawAppliedFilterView()
        Dim drReader As IDataReader
        Dim strSQL As String
        Dim intTDCount As Int32 = 0

        strSQL = "usp_Sel_ResourceUtilization_FilterView " + m_strDateRangeID + "," + m_FilterID
        drReader = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        While drReader.Read
            CommonFunction.General.WriteHTML("<TABLE id=FilterTbl cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            CommonFunction.General.WriteHTML("<TR class='clsTRPageCaption'>")
            If Not IsDBNull(drReader("BusinessGroup")) Then
                CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true >Business Group </TD><TD class='TREven' width=5px>: </TD><TD  width=15% > " + drReader("BusinessGroup").ToString + "</TD>")
                intTDCount += 1
            End If
            If Not IsDBNull(drReader("OrganizationUnit")) Then
                CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true >Organization Unit </TD><td class='TREven' width=5px>: </TD><TD  width=15% > " + drReader("OrganizationUnit").ToString + "</TD>")
                intTDCount += 1
            End If

            If Not IsDBNull(drReader("DeliveryUnit")) Then
                CommonFunction.General.WriteHTML("<TD class='TREven'width=120px nowrap =true >Delivery Unit </TD><td class='TREven' width=5px>: </TD><TD  width=15% > " + drReader("DeliveryUnit").ToString + "</TD>")
                intTDCount += 1
                DrawEndRowForFilterTable(intTDCount)
            End If



            If Not IsDBNull(drReader("DeliveryTeam")) Then
                CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true >Delivery Team </TD><td class='TREven' width=5px>: </TD><TD  width=15% >" + drReader("DeliveryTeam").ToString + "</TD>")
                intTDCount += 1
                DrawEndRowForFilterTable(intTDCount)
            End If


            If Not IsDBNull(drReader("Role")) Then
                CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true >Role </TD><td class='TREven' width=5px>: </TD><TD  width=15% > " + drReader("Role").ToString + "</TD>")
                intTDCount += 1
                DrawEndRowForFilterTable(intTDCount)
            End If


            If Not IsDBNull(drReader("Designation")) Then
                CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true >Designation </TD><td class='TREven' width=5px>: </TD><TD  width=15% > " + drReader("Designation").ToString + "</TD>")
                intTDCount += 1
                DrawEndRowForFilterTable(intTDCount)
            End If


            If Not IsDBNull(drReader("Department")) Then
                CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true >Department </TD><td class='TREven' width=5px>: </TD><TD  width=15% > " + drReader("Department").ToString + "</TD>")
                intTDCount += 1
                DrawEndRowForFilterTable(intTDCount)
            End If


            If Not IsDBNull(drReader("Grade")) Then
                CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true >Grade </TD><td class='TREven' width=5px>: </TD><TD  width=15% > " + drReader("Grade").ToString + "</TD>")
                intTDCount += 1
                DrawEndRowForFilterTable(intTDCount)
            End If


            If Not IsDBNull(drReader("Skill")) Then
                CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true >Skill </TD><td class='TREven' width=5px>: </TD><TD  width=15% > " + drReader("Skill").ToString + "</TD>")
                intTDCount += 1
                DrawEndRowForFilterTable(intTDCount)
            End If


            If Not IsDBNull(drReader("Experience")) Then
                CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true >Experience </TD><td class='TREven' width=5px>: </TD><TD  width=15% > " + drReader("Experience").ToString + "</TD>")
                intTDCount += 1
                DrawEndRowForFilterTable(intTDCount)
            End If


            If Not IsDBNull(drReader("Certification")) Then
                CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true >Certification </TD><td class='TREven' width=5px>: </TD><TD  width=15% > " + drReader("Certification").ToString + "</TD>")
                intTDCount += 1
                DrawEndRowForFilterTable(intTDCount)
            End If


            If Not IsDBNull(drReader("Qualification")) Then
                CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true >Qualification </TD><td class='TREven' width=5px>: </TD><TD  width=15% > " + drReader("Qualification").ToString + "</TD>")
                intTDCount += 1
                DrawEndRowForFilterTable(intTDCount)
            End If


            'If Not IsDBNull(drReader("Project")) Then
            '    CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true >Project </TD><td class='TREven' width=5px>: </TD><TD  width=15% > " + drReader("Project").ToString + "</TD>")
            '    intTDCount += 1
            '    DrawEndRowForFilterTable(intTDCount)
            'End If

            If Not IsDBNull(drReader("ResourceName")) Then
                CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true >Resource </TD><td class='TREven' width=5px>: </TD><TD  width=15% > " + drReader("ResourceName").ToString + "</TD>")
                intTDCount += 1
                DrawEndRowForFilterTable(intTDCount)
            End If


            If Not IsDBNull(drReader("ResourcePool")) Then
                CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true >Resource Pool </TD><td class='TREven' width=5px>: </TD><TD  width=15% > " + drReader("ResourcePool").ToString + "</TD>")
                intTDCount += 1
                DrawEndRowForFilterTable(intTDCount)
            End If


            'If Not IsDBNull(drReader("Passport")) Then
            '    CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true >Passport </TD><td class='TREven' width=5px>: </TD><TD  width=15% > " + drReader("Passport").ToString + "</TD>")
            '    intTDCount += 1
            '    DrawEndRowForFilterTable(intTDCount)
            'End If


            'If Not IsDBNull(drReader("VisaCountry")) Then
            '    CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true >Visa Country </TD><td class='TREven' width=5px>: </TD><TD  width=15% > " + drReader("VisaCountry").ToString + "</TD>")
            '    intTDCount += 1
            '    DrawEndRowForFilterTable(intTDCount)
            'End If


            'If Not IsDBNull(drReader("VisaType")) Then
            '    CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true >Visa Type </TD><td class='TREven' width=5px>: </TD><TD  width=15% > " + drReader("VisaType").ToString + "</TD>")
            '    intTDCount += 1
            '    DrawEndRowForFilterTable(intTDCount)
            'End If


            If Not IsDBNull(drReader("Period")) Then
                CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true>Period </TD><td class='TREven' width=5px>: </TD><TD width=15% > " + drReader("Period").ToString + "</TD>")
                intTDCount += 1
                DrawEndRowForFilterTable(intTDCount)
            End If
            Dim TDcount As Integer
            TDcount = 1
            If (intTDCount Mod 3) <> 0 Then
                While TDcount <= (3 - (intTDCount Mod 3))
                    CommonFunction.General.WriteHTML("<TD class='TREven' width=120px nowrap =true></TD><TD class='TREven'></TD><TD class='TREven'  width=15%  ></TD>")
                    TDcount += 1
                End While

            End If


            CommonFunction.General.WriteHTML("</TR></Table><BR>")

        End While
        CommonFunction.Data.DisposeDataReader(drReader)


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


                If m_GroupInstallCapacity <> 0 Or m_GroupTotalCapacity <> 0 Then
                    Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalCapacity * 100 / m_GroupInstallCapacity).ToString("N2") + "</FONT></TD>"
                Else
                    Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
                End If

                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalAllocated.ToString("N2") + "</FONT></TD>"
                If m_GroupTotalCapacity <> 0 Or m_GroupTotalAllocated <> 0 Then
                    Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalAllocated * 100 / m_GroupTotalCapacity).ToString("N2") + "</FONT></TD>"
                Else
                    Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
                End If

                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalActual.ToString("N2") + "</FONT></TD>"
                If m_GroupTotalCapacity <> 0 Or m_GroupTotalActual <> 0 Then
                    Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalActual * 100 / m_GroupTotalCapacity).ToString("N2") + "</FONT></TD>"
                Else
                    Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
                End If

                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalBillable.ToString("N2") + "</FONT></TD>"
                If m_GroupTotalCapacity <> 0 Or m_GroupTotalBillable <> 0 Then
                    Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalBillable * 100 / m_GroupTotalCapacity).ToString("N2") + "</FONT></TD></TR>"
                Else
                    Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
                End If


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

            m_GrandInstallCapacity += CType(Args.DataReader("InstallCapacityHrs"), Double)
            m_GrandTotalCapacity += CType(Args.DataReader("CapacityHrs"), Double)
            m_GrandTotalAllocated += CType(Args.DataReader("AllocatedHrs"), Double)
            m_GrandTotalActual += CType(Args.DataReader("ActualHrs"), Double)
            m_GrandTotalBillable += CType(Args.DataReader("BillableHrs"), Double)


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


            m_GrandInstallCapacity += CType(Args.DataReader("InstallCapacityHrs"), Double)
            m_GrandTotalCapacity += CType(Args.DataReader("CapacityHrs"), Double)
            m_GrandTotalAllocated += CType(Args.DataReader("AllocatedHrs"), Double)
            m_GrandTotalActual += CType(Args.DataReader("ActualHrs"), Double)
            m_GrandTotalBillable += CType(Args.DataReader("BillableHrs"), Double)

        End If
    End Sub
    Private Sub objListGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objListGrid.DataRowTD_BeforePrint
        If Args.ColIndex = 0 Then 'if first column(Month)

            'Determine stylesheet for row
            If Args.NoOfRowsPrinted Mod 2 = 0 Then
                'While cancelling TD, TR will also get cancelled. hence add <TR>, grid class will close it.
                Args.StringToBeInserted = "<td name=toDel id=toDel></TD></TR><TR class='clsTREven'><TD align='left'></TD>"
            Else
                Args.StringToBeInserted = "<td name=toDel id=toDel></TD></TR><TR class='clsTROdd'><TD align='left'></TD>"
            End If
            Cancel = True
        End If
    End Sub
    Private Sub objListGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles objListGrid.SummaryFunctionsTR_BeforePrint
        If m_GroupTotalCapacity >= 0 Then
            m_intCount = m_intCount + 1

            'Insert sum for the Month
            Args.StringToBeInserted = "<TR class='clsTRSectionHeader' ><TD align='left' colspan=2><FONT color=blue> " + MyBase.GetResourceString("TOTALCAPTION") + "  " + m_strMonth + "</FONT></TD>"
            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupInstallCapacity.ToString("N2") + "</FONT></TD>"
            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalCapacity.ToString("N2") + "</FONT></TD>"

            If m_GroupInstallCapacity <> 0 And m_GroupTotalCapacity <> 0 Then
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalCapacity * 100 / m_GroupInstallCapacity).ToString("N2") + "</FONT></TD>"
            Else
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
            End If

            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalAllocated.ToString("N2") + "</FONT></TD>"

            If m_GroupTotalCapacity <> 0 And m_GroupTotalAllocated <> 0 Then
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalAllocated * 100 / m_GroupTotalCapacity).ToString("N2") + "</FONT></TD>"
            Else
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
            End If

            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalActual.ToString("N2") + "</FONT></TD>"


            If m_GroupTotalCapacity <> 0 And m_GroupTotalActual <> 0 Then
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalActual * 100 / m_GroupTotalCapacity).ToString("N2") + "</FONT></TD>"
            Else
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
            End If

            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalBillable.ToString("N2") + "</FONT></TD>"

            If m_GroupTotalCapacity <> 0 And m_GroupTotalBillable <> 0 Then
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalBillable * 100 / m_GroupTotalCapacity).ToString("N2") + "</FONT></TD></TR>"
            Else
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
            End If


        End If
    End Sub
    Private Sub objListGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles objListGrid.ColumnHeaderTR_BeforePrint
        Args.StringToBeInserted = "<TR class='clsTRColumnHeader' ><TD align='center' colspan=2>&nbsp;</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=1>" + MyBase.GetResourceString("HEADER_INSTALLCAPACITY") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_CAPCITY") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_ALLOCATED") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_ACTUAL") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_BILLABLE") + "</TD></TR>"

        'Args.StringToBeInserted = "<TR class='clsTRColumnHeader' ><TH align='center' class='DivList' colspan=2>&nbsp;</TH>"
        'Args.StringToBeInserted += "<TH align=center class='DivList' colspan=1>" + MyBase.GetResourceString("HEADER_INSTALLCAPACITY") + "</TH>"
        'Args.StringToBeInserted += "<TH align=center class='DivList' colspan=2>" + MyBase.GetResourceString("HEADER_CAPCITY") + "</TH>"
        'Args.StringToBeInserted += "<TH align=center class='DivList' colspan=2>" + MyBase.GetResourceString("HEADER_ALLOCATED") + "</TH>"
        'Args.StringToBeInserted += "<TH align=center class='DivList' colspan=2>" + MyBase.GetResourceString("HEADER_ACTUAL") + "</TH>"
        'Args.StringToBeInserted += "<TH align=center class='DivList' colspan=2>" + MyBase.GetResourceString("HEADER_BILLABLE") + "</TH></TR>"

    End Sub
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

    End Sub

    Private Sub objListSummaryGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objListSummaryGrid.DataRowTR_BeforePrint
        m_GrandInstallCapacity += CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("InstallCapacityHrs"), "0"), "0"), Double)
        m_GrandTotalCapacity += CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("CapacityHrs"), "0"), "0"), Double)
        m_GrandTotalAllocated += CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("AllocatedHrs"), "0"), "0"), Double)
        m_GrandTotalActual += CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ActualHrs"), "0"), "0"), Double)
        m_GrandTotalBillable += CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("BillableHrs"), "0"), "0"), Double)

        m_GrandCapacityPer = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("GrandCapacity%"), "0"), "0"), Double)
        m_GrandAllocatedPer = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("GrandAllocated%"), "0"), "0"), Double)
        m_GrandActualPer = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("GrandActual%"), "0"), "0"), Double)
        m_GrandBillablePer = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("GrandBillable%"), "0"), "0"), Double)
    End Sub
    Private Sub objListSummaryGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles objListSummaryGrid.ColumnHeaderTR_BeforePrint
        Args.StringToBeInserted = "<TR class='clsTRColumnHeader' ><TD align='center' colspan=1>&nbsp;</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=1>" + MyBase.GetResourceString("HEADER_INSTALLCAPACITY") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_CAPCITY") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_ALLOCATED") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_ACTUAL") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_BILLABLE") + "</TD></TR>"

        'Args.StringToBeInserted = "<TR class='clsTRColumnHeader' ><TH align='center' class='DivList' colspan=2>&nbsp;</TH>"
        'Args.StringToBeInserted += "<TH align=center class='DivList' colspan=1>" + MyBase.GetResourceString("HEADER_INSTALLCAPACITY") + "</TH>"
        'Args.StringToBeInserted += "<TH align=center class='DivList' colspan=2>" + MyBase.GetResourceString("HEADER_CAPCITY") + "</TH>"
        'Args.StringToBeInserted += "<TH align=center class='DivList' colspan=2>" + MyBase.GetResourceString("HEADER_ALLOCATED") + "</TH>"
        'Args.StringToBeInserted += "<TH align=center class='DivList' colspan=2>" + MyBase.GetResourceString("HEADER_ACTUAL") + "</TH>"
        'Args.StringToBeInserted += "<TH align=center class='DivList' colspan=2>" + MyBase.GetResourceString("HEADER_BILLABLE") + "</TH></TR>"


    End Sub

    Private Sub objListSummaryGrid_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles objListSummaryGrid.SummaryFunctionsTD_BeforePrint
        If Args.ColIndex = 0 Then
            Cancel = True
            Args.StringToBeInserted = "<TD align=right> Grand Total</TD>"
        End If

        If Args.ColIndex = 3 Then
            Cancel = True
            If m_GrandInstallCapacity <> 0 And m_GrandTotalCapacity <> 0 Then
                Args.StringToBeInserted = "<TD align=right> " + m_GrandCapacityPer.ToString("N2") + "</TD>"
            Else
                Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
            End If

        End If

        If Args.ColIndex = 5 Then
            Cancel = True
            If m_GrandTotalCapacity <> 0 And m_GrandTotalAllocated <> 0 Then
                Args.StringToBeInserted = "<TD align=right> " + m_GrandAllocatedPer.ToString("N2") + "</TD>"
            Else
                Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
            End If
        End If

        If Args.ColIndex = 7 Then
            Cancel = True
            If m_GrandTotalCapacity <> 0 And m_GrandTotalActual <> 0 Then
                Args.StringToBeInserted = "<TD align=right> " + m_GrandActualPer.ToString("N2") + "</TD>"
            Else
                Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
            End If
        End If

        If Args.ColIndex = 9 Then
            Cancel = True
            If m_GrandTotalCapacity <> 0 And m_GrandTotalBillable <> 0 Then
                Args.StringToBeInserted = "<TD align=right> " + m_GrandBillablePer.ToString("N2") + "</TD>"
            Else
                Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
            End If
        End If


    End Sub

    
   
End Class
