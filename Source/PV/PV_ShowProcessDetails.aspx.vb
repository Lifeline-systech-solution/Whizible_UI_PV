#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class PV_ShowProcessDetails
    Inherits WebPages.Template.WhizTemplate

    '=====================================================================
    ' Page Name 	        :	
    ' Purpose				:	
    ' Description			:	
    ' Assumptions			:	
    ' Dependencies			:	
    ' Author				:	
    ' Created				:	
    ' Revisions				:	
    '=====================================================================

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
    Private WithEvents m_objMenu As New StaticMenu      'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New GenericGrid     'This variable is use to plotting grid.
    Private m_objGlobal As IGlobal                      'This variable is of global object inteface. 
    Private m_objAccessRights As cAccessRights          'This variable is for access rights of page.
    Private strMenu As String                           'stores the static menu string.
    Private m_strMode As String
    Private m_strProjectId, m_strProcessID As String
#End Region

#Region "Functions & Procedures"

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        : GetGlobalObject
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Get the global object and assign it to variable
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
    End Sub

    Private Sub DrawMenu()
        '====================================================================
        ' Procedure Name        : DrawMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the menu
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim arrMenu() As String = {}
        Dim arrMenuToolTip() As String = {}
        Dim arrClientSideFunction() As String = {}
        Dim strGrid As String
        'cerate the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True)
    End Sub

    Private Sub DrawPageCaption()
        '====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page caption thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Response.Write(PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        Response.Write("<BR>")
    End Sub

    Private Sub DrawHeader()
        '====================================================================
        ' Procedure Name        : DrawHeader
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page Header thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim objHeader As HeaderFooter
        Dim strReturn As String
        objHeader = New HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        strReturn = objHeader.DrawHeaderFooter(m_objGlobal, True)
        If strReturn <> "" Then
            Response.Write(strReturn)
        End If
        objHeader = Nothing
    End Sub

    Private Sub DisposeObjects()
        '====================================================================
        ' Procedure Name        : DisposeObjects
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Dispose all the objects
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        m_objMenu = Nothing
        m_objGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing

    End Sub

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        : PageInit
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the page
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        GetGlobalObject()
        InitParams()

        Response.Write("<DIV Id= 'PageDiv' Style='Width:100%;OverFlow:auto' >")
        DisplayProcessDetails()
        HttpContext.Current.Response.Write("</DIV>")
        Response.Write("<BR>")

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        DisposeObjects()
    End Sub

    Private Sub InitParams()
        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode")
        Else
            m_strMode = ""
        End If
        If Not Session.Item("intProjectId") Is Nothing Then
            m_strProjectId = CType(Session.Item("intProjectId"), String)
        Else
            m_strProjectId = ""
        End If
        If Not Request.QueryString("ProcessId") Is Nothing Then
            m_strProcessID = Request.QueryString("ProcessId")
        Else
            m_strProcessID = ""
        End If

    End Sub

    Private Sub DisplayProcessDetails()
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strProcessName As String
        'get the process name and display
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        'strSQL = "SELECT * FROM v_tbl_PRS_Process_Draft WHERE ProcessID= " + m_strProcessID.ToString
        strSQL = "usp_sel_v_tbl_PRS_Process_Draft " + m_strProcessID.ToString
        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query


        objDR = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If objDR.Read Then
            If Not IsDBNull(objDR("ProcessName")) Then
                strProcessName = objDR("ProcessName").ToString + ""
            Else
                strProcessName = ""
            End If

            WriteHTML("<TABLE class='clsTable' width='99.9%' style='MARGIN-LEFT: 2pt; MARGIN-RIGHT: 2pt'>")
            WriteHTML("<TR class='clsTRPageCaption'>")
            WriteHTML("<TD align='left'><FONT face='Verdana' size='4'>" + strProcessName + "</TD>")
            WriteHTML("</TR>")
            WriteHTML("</TABLE>")
            WriteHTML("<BR>")

            WriteHTML("<TABLE class='clsTable' width='99.9%' style='MARGIN-LEFT: 2pt; MARGIN-RIGHT: 2pt'>")

            'WriteHTML("<TR>")
            'WriteHTML("<TD width= '20%' ><STRONG><FONT face='Verdana'><EM>Name</EM> </FONT></STRONG></TD>")
            'WriteHTML("<TD><FONT face='Verdana' size='2'>" + strProcessName + " </FONT></TD>")
            'WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD colspan='2'><STRONG><FONT face='Verdana'><EM>Description</EM> </FONT></STRONG> : </TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD width='3%'></TD><TD width='97%' ><FONT face='Verdana' size='2'>" + objDR("Description").ToString + " </FONT></TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD colspan='2'><STRONG><FONT face='Verdana'><EM>Entry Criteria</EM> </FONT></STRONG> : </TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD width='3%'></TD><TD width='97%' ><FONT face='Verdana' size='2'>" + objDR("EntryCriteria").ToString + " </FONT></TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD colspan='2'><STRONG><FONT face='Verdana'><EM>Exit Criteria</EM> </FONT></STRONG> : </TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD width='3%'></TD><TD width='97%' ><FONT face='Verdana' size='2'> " + objDR("ExitCriteria").ToString + " </FONT></TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD colspan='2'><STRONG><FONT face='Verdana'><EM>Measurements</EM> </FONT></STRONG> : </TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD width='3%'></TD><TD width='97%' ><FONT face='Verdana' size='2'> " + objDR("Measurements").ToString + "  </FONT></TD>")
            WriteHTML("</TR>")
            WriteHTML("</TABLE>")

        End If

        CommonFunction.Data.DisposeDataReader(objDR)
        objDR = Nothing

        Dim drActivities As IDataReader
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        'drActivities = CommonFunctions.Data.GetDataReader("SELECT ActivityID, Title FROM v_tbl_PRS_Project_SDLC WHERE ProjectID = " + m_strProjectId.ToString + " AND ProcessID = " + m_strProcessID.ToString, MyBase.UseSQL)
        drActivities = CommonFunctions.Data.GetDataReader("usp_sel_Project_SDLC " + m_strProjectId.ToString + "," + m_strProcessID.ToString, MyBase.UseSQL)
        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query


        WriteHTML("<BR>")

        WriteHTML("<HR>")

        WriteHTML("<TABLE class='clsTable' width='99.9%' style='MARGIN-LEFT: 2pt; MARGIN-RIGHT: 2pt'>")
        WriteHTML("<TR class='clsTRPageCaption'>")
        WriteHTML("<TD align='left'>Activity Details</TD>")
        WriteHTML("</TR>")
        WriteHTML("</TABLE>")
        WriteHTML("<BR>")

        'General.WriteHTML("<Div id='DivList' width=100% style='Overflow: auto;' >")
        While drActivities.Read
            Call showActivityDetailsScreen(CType(drActivities.Item("ActivityID"), Long))
            Call ShowGuideLines(CType(drActivities.Item("ActivityID"), Long))
        End While
        CommonFunction.Data.DisposeDataReader(drActivities)
        Call ShowTemplates(m_strProcessID)
        Call ShowChekLists(m_strProcessID)

        WriteHTML("<HR>")

    End Sub

    Private Sub showActivityDetailsScreen(ByVal lngActivityId As Long)
        Dim strSql As String = "EXEC usp_sel_Activity_Details " + lngActivityId.ToString
        Dim objDr As IDataReader

        objDr = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)

        If objDr.Read Then

            WriteHTML("<TABLE class='clsTable' width='99.9%' style='MARGIN-LEFT: 2pt; MARGIN-RIGHT: 2pt'>")

            WriteHTML("<TR>")
            WriteHTML("<TD colspan='2'><STRONG><FONT face='Verdana'><EM>Activity Id</EM> </FONT></STRONG> : ")
            WriteHTML("<FONT face='Verdana' size='2'>" + objDr("ActivityId").ToString + " </FONT></TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD colspan='2' bgcolor='ButtonFace'><STRONG><FONT face='Verdana'><EM>Activity </EM> </FONT></STRONG> : ")
            WriteHTML("<FONT face='Verdana' size='2'>" + objDr("Title").ToString + " </FONT></TD>")
            WriteHTML("</TR>")

            WriteHTML("</TABLE>")

            WriteHTML("<TABLE class='clsTable' width='99.9%' style='MARGIN-LEFT: 2pt; MARGIN-RIGHT: 2pt'>")

            WriteHTML("<TR>")
            WriteHTML("<TD colspan='2'><STRONG><FONT face='Verdana'><EM>Objective</EM> </FONT></STRONG> : </TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD width='3%'></TD><TD width='97%' ><FONT face='Verdana' size='2'>" + objDr("Objective").ToString + " </FONT> </TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD colspan='2'><STRONG><FONT face='Verdana'><EM>Scope</EM> </FONT></STRONG> : </TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD width='3%'></TD><TD width='97%' ><FONT face='Verdana' size='2'>" + objDr("Scope").ToString + " </FONT></TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD colspan='2'><STRONG><FONT face='Verdana'><EM>Input Criteria</EM> </FONT></STRONG> : </TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD width='3%'></TD><TD width='97%' ><FONT face='Verdana' size='2'>" + objDr("InputCriteria").ToString + " </FONT></TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD colspan='2'><STRONG><FONT face='Verdana'><EM>Inputs</EM> </FONT></STRONG> : </TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD width='3%'></TD><TD width='97%' ><FONT face='Verdana' size='2'>" + objDr("Inputs").ToString + " </FONT></TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD colspan='2'><STRONG><FONT face='Verdana'><EM>Description</EM> </FONT></STRONG> : </TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD width='3%'></TD><TD width='97%' ><FONT face='Verdana' size='2'>" + objDr("Description").ToString + " </FONT></TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD colspan='2'><STRONG><FONT face='Verdana'><EM>Exit Criteria</EM> </FONT></STRONG> : </TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD width='3%'></TD><TD width='97%' ><FONT face='Verdana' size='2'> " + objDr("ExitCriteria").ToString + " </FONT></TD>")
            WriteHTML("</TR>")

            WriteHTML("</TABLE>")

        End If

        CommonFunction.Data.DisposeDataReader(objDr)
        objDr = Nothing

    End Sub

    Private Sub ShowGuideLines(ByVal lngActivityId As Long)
        WriteHTML("<BR>")

        WriteHTML("<TABLE class='clsTable' width='99.9%' style='MARGIN-LEFT: 2pt; MARGIN-RIGHT: 2pt'>")

        WriteHTML("<TR>")
        WriteHTML("<TD bgcolor='ButtonFace' ><STRONG><FONT face='Verdana'><EM> Guidelines </EM> </FONT></STRONG></TD>")
        WriteHTML("</TR>")

        WriteHTML("</TABLE>")

        WriteHTML("<TABLE class='clsTable' width='99.9%' style='MARGIN-LEFT: 2pt; MARGIN-RIGHT: 2pt'>")

        Dim strSql As String = "usp_Sel_Activity_Quality_References_Published " + m_strProcessID + ", " + lngActivityId.ToString + ", 'G'"
        Dim objDr As IDataReader

        objDr = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)

        While objDr.Read

            WriteHTML("<TR>")
            WriteHTML("<TD colspan='2' ><STRONG><FONT face='Verdana'>Guideline</FONT></STRONG> : " + objDr("title").ToString + "  </TD>")
            WriteHTML("</TR>")

            'WriteHTML("<TR>")
            'WriteHTML("<TD width='3%'></TD><TD width='97%' ><FONT face='Verdana' size='2'>" + objDr("title").ToString + " </FONT></TD>")
            'WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD colspan='2'><STRONG><FONT face='Verdana'><EM>Objective</EM> </FONT></STRONG> : </TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD width='3%'></TD><TD width='97%' ><FONT face='Verdana' size='2'>" + objDr("Objective").ToString + " </FONT></TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD colspan='2'><STRONG><FONT face='Verdana'><EM>Scope</EM> </FONT></STRONG> : </TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD width='3%'></TD><TD width='97%' ><FONT face='Verdana' size='2'>" + objDr("Scope").ToString + " </FONT></TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD colspan='2'><STRONG><FONT face='Verdana'><EM>Details</EM> </FONT></STRONG> : </TD>")
            WriteHTML("</TR>")

            WriteHTML("<TR>")
            WriteHTML("<TD width='3%'></TD><TD width='97%' ><FONT face='Verdana' size='2'>" + objDr("GuidelineDetails").ToString + " </FONT></TD>")
            WriteHTML("</TR>")

        End While

        WriteHTML("</TABLE>")

        CommonFunction.Data.DisposeDataReader(objDr)
        objDr = Nothing

        WriteHTML("<BR>")

    End Sub

    Private Sub ShowTemplates(ByVal strProcessId As String)
        Dim strSql As String = "usp_sel_PV_ProcessDetails 1, " + strProcessId
        Dim objDr As IDataReader

        objDr = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
        WriteHTML("<TABLE class='clsTable' width='99.9%' style='MARGIN-LEFT: 2pt; MARGIN-RIGHT: 2pt'>")

        WriteHTML("<TR>")
        WriteHTML("<TD  colspan='2' bgcolor='ButtonFace'><STRONG><FONT face='Verdana'><EM> Templates </EM> </FONT></STRONG> : </TD>")
        WriteHTML("</TR>")

        While objDr.Read
            WriteHTML("<TR>")
            WriteHTML("<TD width='3%'></TD><TD width='97%' ><FONT face='Verdana' size='2'>" + objDr("Name").ToString + " </FONT></TD>")
            WriteHTML("</TR>")

        End While
        WriteHTML("</TABLE>")

        CommonFunction.Data.DisposeDataReader(objDr)
        objDr = Nothing
        WriteHTML("<BR>")

    End Sub

    Private Sub ShowChekLists(ByVal strProcessId As String)
        Dim strSql As String = "usp_sel_PV_ProcessDetails  2,  " + strProcessId
        Dim objDr As IDataReader

        objDr = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
        WriteHTML("<TABLE class='clsTable' width='99.9%' style='MARGIN-LEFT: 2pt; MARGIN-RIGHT: 2pt'>")

        WriteHTML("<TR>")
        WriteHTML("<TD colspan='2'  bgcolor='ButtonFace' ><STRONG><FONT face='Verdana'><EM>Checklists</EM> </FONT></STRONG> : </TD>")
        WriteHTML("</TR>")

        While objDr.Read
            WriteHTML("<TR>")
            WriteHTML("<TD width='3%'></TD><TD width='97%' ><FONT face='Verdana' size='2'>" + objDr("Name").ToString + " </FONT></TD>")
            WriteHTML("</TR>")

        End While
        WriteHTML("</TABLE>")

        CommonFunction.Data.DisposeDataReader(objDr)
        objDr = Nothing

        WriteHTML("<BR>")

    End Sub


#End Region

#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.

        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region

End Class
