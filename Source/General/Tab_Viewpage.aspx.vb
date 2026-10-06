Imports System.Text
Public Class Tab_Viewpage
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    Private sbHTML As StringBuilder
    Private m_strFromFrame As String = ""
    Private m_strMasterTagID As String
    Protected strDefaultPageURL As String
    Private ProjectID As String
    Private PKToken As String
    'added by SUchitraP on 22-Aug-2008 for Alert Change
    Private m_strFromWhere As String
    'End by SuchitraP


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Protected Sub PageInit()
        Initialize_Variables()

        WritePage()



    End Sub
    Protected Sub Initialize_Variables()
        '=====================================================================
        ' Function  Name		:	Initialize_Variables
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To Persists the state of the page 
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Oct 09 2007
        ' Revisions				:	
        '=====================================================================
        m_strFromFrame = CommonFunction.General.CheckIsNothing(Request.QueryString("FromFrame")).ToString

        m_strMasterTagID = Request.QueryString("MasterTagID")

        If m_strMasterTagID = "32" Then
            ProjectID = Request.QueryString("ProjectID_PK")
            If ProjectID Is Nothing Then
                ProjectID = Request.Form("hidProjectID")
            End If
            PKToken = Request.QueryString("PKToken")
            If PKToken Is Nothing Then
                PKToken = Request.Form("hidPKToken")
            End If
        End If

        If m_strMasterTagID Is Nothing Then
            m_strMasterTagID = Request.Form("hidMasterTagID")
        End If

        'added by SUchitraP on 22-Aug-2008 for Alert Change
        If CommonFunction.General.CheckIsNothing(Request.QueryString("FromWhere"), "") <> "" Then
            m_strFromWhere = Request.QueryString("FromWhere")
        Else
            m_strFromWhere = Request.Form("hidFromWhere").ToString
        End If
        'End by SuchitraP

    End Sub
    Protected Sub WritePage()
        '=====================================================================
        ' Function  Name		:	WritePage()
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To Persists the state of the page 
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Oct 09 2007
        ' Revisions				:	
        '=====================================================================
        sbHTML = New StringBuilder

        Dim strQuery As String

        'CommonFunction.Data.InsertOrUpdateData("usp_INS_tbl_CNF_Employee_Gadgets " & CType(HttpContext.Current.Session("intUserID"), String), MyBase.UseSQL)

        'Modification and added by SUchitraP on 22-Aug-2008 for Alert Change
        If m_strFromWhere.ToUpper = "ALERTS" Then
            Call PlotTabMenu()
        Else
            sbHTML.Append(CommonFunction.MultipleWindowTabs.GenerateTabSections(strDefaultPageURL, m_strMasterTagID, ProjectID, PKToken, "iTabDetails") + vbCrLf)
        End If

        sbHTML.Append("<iframe name='iTabDetails' id='iTabDetails' onLoad='calcHeight()'  src='' scrolling='no' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' style='width:100%;' ></iframe>" + vbCrLf)
        sbHTML.Append("<input type=hidden name='hidMasterTagID' id='hidMasterTagID' value=" + m_strMasterTagID + ">")

        sbHTML.Append("<input type=hidden name='hidDefaultPageURL' id='hidDefaultPageURL' value='" + strDefaultPageURL + "'>")
        sbHTML.Append("<input type=hidden name='hidProjectID' id='hidProjectID' value='" + ProjectID + "'>")
        sbHTML.Append("<input type=hidden name='hidPKToken' id='hidPKToken' value='" + PKToken + "'>")

        'added by SUchitraP on 22-Aug-2008 for Alert Change
        sbHTML.Append("<input type=hidden name='hidFromWhere' id='hidFromWhere' value='" + m_strFromWhere + "'>")
        'End by SuchitraP

        Response.Write(sbHTML.ToString)

        sbHTML = Nothing

    End Sub
    Private Sub PlotTabMenu()
        Dim strHTML As New System.Text.StringBuilder

        strDefaultPageURL = "../DB/Alerts_CommonList.aspx?MasterTagID=3707&ParentTagID=0"

        strHTML.Append("<TABLE id='tblCap03707' cellspacing=0 cellpadding=0 Width='99.9%' class='clsTableNavLinks'>" + vbCrLf)
        strHTML.Append("<TR class=clsTRGroupHeader valign=middle>" + vbCrLf)
        strHTML.Append("<TD>" + vbCrLf)
        strHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;<A name='Tabs' class='clsSelected' id='Tab_HelpdeskAlert' HREF=""Javascript:Tab_OnClick('HelpdeskAlert')"" Title=""Alerts"" ><b>Alerts</b></A>" + vbCrLf)
        strHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;<A name='Tabs'  id='Tab_ProjectAlert' HREF=""Javascript:Tab_OnClick('ProjectAlert')"" Title=""Project Alerts"" ><b>Project Alerts</b></A>" + vbCrLf)
        'strHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;<A name='Tabs' class='clsNavTab' id='Tab_OutlookAlert'  HREF=""Javascript:Tab_OnClick('OutlookAlert')"" Title=""Outlook Alerts"" >Outlook Alerts</A>" + vbCrLf)
        strHTML.Append("</TD>" + vbCrLf)
        strHTML.Append("</TR></TABLE><BR>" + vbCrLf)

        Response.Write(strHTML.ToString)
    End Sub
End Class
