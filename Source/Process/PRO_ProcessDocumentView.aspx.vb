Public Class PRO_ProcessDocumentView
    Inherits WebPages.Template.WhizTemplate

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
    End Sub

#End Region
    Private m_sbHTML As System.Text.StringBuilder
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private m_strProcessID As String
    Private m_strPKToken As String
    Private m_strFromWhere As String



    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Protected Sub PageInit()
        '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        Call InitializeVariables()
        Call GenerateMenu()
        m_sbHTML.Append("<BR>")
        Call DrawPage()
        m_sbHTML.Append("<BR>")
        Call GenerateMenu()

        Response.Write(m_sbHTML.ToString())
        m_sbHTML = Nothing
    End Sub
    Private Sub InitializeVariables()
        m_sbHTML = New System.Text.StringBuilder
        m_strProcessID = Request.QueryString("ProcessID")

        If m_strProcessID Is Nothing OrElse m_strProcessID = "" Then
            m_strProcessID = Request.Form("hidProcessID")
        End If

        m_strFromWhere = Request.QueryString("FromWhere")


        If m_strFromWhere Is Nothing OrElse m_strFromWhere = "" Then
            m_strFromWhere = Request.Form("hidFromWhere")
        End If

        If m_strFromWhere <> "" Then
            m_strFromWhere = m_strFromWhere.ToUpper()
        End If

        m_strPKToken = CommonFunctions.Security.Token.GetToken(m_strProcessID + CType(Session("intUserID"), String) + "0" + "1040")

        m_sbHTML.Append("<input type=hidden name='hidProcessID' id='hidProcessID' value='" + m_strProcessID + "'>")
        m_sbHTML.Append("<input type=hidden name='hidPKToken' id='hidPKToken' value='" + m_strPKToken + "'>")
        m_sbHTML.Append("<input type=hidden name='hidFromWhere' id='hidFromWhere' value='" + m_strFromWhere + "'>")


    End Sub
    Private Sub DrawPage()
        Dim strQuery As String
        Dim dr As IDataReader
        Dim processName As String
        Dim OrderNO As String
        Dim RevisionNo As String
        Dim SEICMMKPA As String
        Dim ISO9001ClauseNo As String
        Dim EntryCriteria As String
        Dim ExitCriteria As String
        Dim Department As String
        Dim Measurements As String

        Dim Purpose As String
        Dim Responsibility As String
        Dim TailoringOptions As String
        Dim OutRetention As String

        strQuery = "usp_sel_ProcessDetails_View " + m_strProcessID + ",'" + m_strFromWhere + "'," + Session("intProjectID").ToString

        dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)


        If dr.Read() Then

            OrderNO = CType(CommonFunctions.Data.CheckIsDBNull(dr("OrderNumber"), "-"), String)
            RevisionNo = CType(CommonFunctions.Data.CheckIsDBNull(dr("RevisionNo"), "-"), String)
            SEICMMKPA = CType(CommonFunctions.Data.CheckIsDBNull(dr("SEICMMKPA"), "-"), String)
            ISO9001ClauseNo = CType(CommonFunctions.Data.CheckIsDBNull(dr("ISO9001ClauseNo"), "-"), String)
            EntryCriteria = CType(CommonFunctions.Data.CheckIsDBNull(dr("EntryCriteria"), "-"), String)
            ExitCriteria = CType(CommonFunctions.Data.CheckIsDBNull(dr("ExitCriteria"), "-"), String)
            Measurements = CType(CommonFunctions.Data.CheckIsDBNull(dr("Measurements"), "-"), String)
            Department = CType(CommonFunctions.Data.CheckIsDBNull(dr("Department"), "-"), String)

            Purpose = CType(CommonFunctions.Data.CheckIsDBNull(dr("Purpose"), "-"), String)
            Responsibility = CType(CommonFunctions.Data.CheckIsDBNull(dr("Responsibility"), "-"), String)
            TailoringOptions = CType(CommonFunctions.Data.CheckIsDBNull(dr("TailoringOptions"), "-"), String)
            OutRetention = CType(CommonFunctions.Data.CheckIsDBNull(dr("OutRetention"), "-"), String)

            'Process Name
            m_sbHTML.Append("<TABLE class='clsTable' width='99.9%' cellspacing=0 cellpadding=0 style='MARGIN-LEFT: 2pt; MARGIN-RIGHT: 2pt'>" + vbCrLf)
            m_sbHTML.Append("<TR class='clsTRPageCaption'>" + vbCrLf)
            m_sbHTML.Append("<TD align='left'><FONT face='courier New' size='3'>" + dr("ProcessName").ToString + "</TD>" + vbCrLf)

            'SEI CMM KPA

            m_sbHTML.Append("<TD align='left'><FONT face='Times New Roman' size='2'>SEI CMMi KPA</FONT> : " + vbCrLf)
            m_sbHTML.Append("<FONT face='Times New Roman' size='2'>" + vbCrLf)
            m_sbHTML.Append(SEICMMKPA)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)


            m_sbHTML.Append("</TR>" + vbCrLf)
            m_sbHTML.Append("</TABLE>" + vbCrLf)
            m_sbHTML.Append("<BR>" + vbCrLf)

            m_sbHTML.Append("<DIV Id=divPage Style='HEIGHT:400px;OVERFLOW:auto;WIDTH:99.9%'>" + vbCrLf)
            'To Draw Process Image
            If m_strProcessID <> "15014" Then 'No Image for Management Review
                m_sbHTML.Append("<TABLE width='99.9%' style='MARGIN-LEFT: 2pt; MARGIN-RIGHT: 2pt' align='center' >")

                m_sbHTML.Append("<TR>" + vbCrLf)
                m_sbHTML.Append("<TD  align='left'><A href=Javascript:showHide_divActivity('divProcessImage')><IMG id='imgdivProcessImage' Collapse='N' border=0 Src='../../Images/minus.gif' ></A>" + vbCrLf)

                m_sbHTML.Append("<TABLE width='99.9%' style='MARGIN-LEFT: 2pt; MARGIN-RIGHT: 2pt' align='center'>")
                m_sbHTML.Append("<TR>")
                m_sbHTML.Append("<TD align='center' >" + vbCrLf)
                m_sbHTML.Append("<DIV Id=divProcessImage Style='OVERFLOW:auto;WIDTH:99.9%'>" + vbCrLf)
                m_sbHTML.Append("<IMG src='../../Images/Process/sysImages/" + m_strProcessID + ".JPG' align='middle' >" + vbCrLf)
                m_sbHTML.Append("</DIV>" + vbCrLf)
                m_sbHTML.Append("</TD>" + vbCrLf)
                m_sbHTML.Append("<TR>" + vbCrLf)
                m_sbHTML.Append("</TABLE>")

                m_sbHTML.Append("</TD>" + vbCrLf)
                m_sbHTML.Append("<TR>" + vbCrLf)

                m_sbHTML.Append("</TABLE>")
            End If
            'End of Process Image draw
            m_sbHTML.Append("<BR>" + vbCrLf)

            m_sbHTML.Append("<TABLE class='clsTable' width='99.9%' style='MARGIN-LEFT: 2pt; MARGIN-RIGHT: 2pt'>" + vbCrLf)
            ''Revision Number
            'm_sbHTML.Append("<TR>" + vbCrLf)
            'm_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Revision Number</EM> </FONT></STRONG> : " + vbCrLf)
            'm_sbHTML.Append("<FONT face='courier New' size='2'>" + vbCrLf)
            'm_sbHTML.Append(RevisionNo)
            'm_sbHTML.Append("</FONT></TD>" + vbCrLf)
            'm_sbHTML.Append("</TR>" + vbCrLf)
            ''Order Number
            'm_sbHTML.Append("<TR>" + vbCrLf)
            'm_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Order Number</EM> </FONT></STRONG> : " + vbCrLf)
            'm_sbHTML.Append("<FONT face='courier New' size='2'>" + vbCrLf)
            'm_sbHTML.Append(OrderNO)
            'm_sbHTML.Append("</FONT></TD>" + vbCrLf)
            'm_sbHTML.Append("</TR>" + vbCrLf)
            ''Process Name
            'm_sbHTML.Append("<TR>" + vbCrLf)
            'm_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Process Name</EM> </FONT></STRONG> : " + vbCrLf)
            'm_sbHTML.Append("<FONT face='courier New' size='2'>" + vbCrLf)
            'm_sbHTML.Append(dr("ProcessName").ToString)
            'm_sbHTML.Append("</FONT></TD>" + vbCrLf)
            'm_sbHTML.Append("</TR>" + vbCrLf)

            ''SEI CMM KPA
            'm_sbHTML.Append("<TR>" + vbCrLf)
            'm_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>SEI CMMI KPA</EM> </FONT></STRONG> : " + vbCrLf)
            'm_sbHTML.Append("<FONT face='courier New' size='2'>" + vbCrLf)
            'm_sbHTML.Append(SEICMMKPA)
            'm_sbHTML.Append("</FONT></TD>" + vbCrLf)
            'm_sbHTML.Append("</TR>" + vbCrLf)
            ''ISO9001ClauseNo
            'm_sbHTML.Append("<TR>")
            'm_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>ISO 9001 Clause Number</EM> </FONT></STRONG> : ")
            ''m_sbHTML.Append("</TR>")
            ''m_sbHTML.Append("<TR>")
            ''m_sbHTML.Append("<TD width='3%'></TD><TD width='97%' ><FONT face='courier New' size='2'>")
            'm_sbHTML.Append("<FONT face='courier New' size='2'>")
            'm_sbHTML.Append(ISO9001ClauseNo)
            'm_sbHTML.Append("</FONT></TD>")
            'm_sbHTML.Append("</TR>")

            'Entry Criteria
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Entry Criteria</EM> </FONT></STRONG> : </TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD width='3%'></TD><TD width='97%' ><FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(EntryCriteria)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            'Purpose
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Purpose & Scope</EM> </FONT></STRONG> : </TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD width='3%'></TD><TD width='97%' ><FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(Purpose)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            'Responsibility
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Responsibility</EM> </FONT></STRONG> : </TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD width='3%'></TD><TD width='97%' ><FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(Responsibility)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            'Description
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Description</EM> </FONT></STRONG> : </TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD width='3%'></TD><TD width='97%' ><FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(dr("Description").ToString)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            'TailoringOptions
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Tailoring Options</EM> </FONT></STRONG> : </TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD width='3%'></TD><TD width='97%' ><FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(dr("TailoringOptions").ToString)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            'OutRetention
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Retention of Outputs and Records</EM> </FONT></STRONG> : </TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD width='3%'></TD><TD width='97%' ><FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(dr("OutRetention").ToString)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            'Exit Criteria
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Exit Criteria</EM> </FONT></STRONG> : </TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD width='3%'></TD><TD width='97%' ><FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(ExitCriteria)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            'Measurement Criteria
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Measurement Criteria</EM> </FONT></STRONG> : </TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD width='3%'></TD><TD width='97%' ><FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(Measurements)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            'DepartmentId
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Department</EM> </FONT></STRONG> : " + vbCrLf)
            m_sbHTML.Append("<FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(Department)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            ''Is Process Active
            'm_sbHTML.Append("<TR>" + vbCrLf)
            'm_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Is Process Active</EM> </FONT></STRONG> : " + vbCrLf)
            'm_sbHTML.Append("<FONT face='courier New' size='2'>" + vbCrLf)
            'm_sbHTML.Append(dr("IsActive").ToString)
            'm_sbHTML.Append("</FONT></TD>" + vbCrLf)
            'm_sbHTML.Append("</TR>" + vbCrLf)
            'Is SDLC Process
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>SDLC Process</EM> </FONT></STRONG> : " + vbCrLf)
            m_sbHTML.Append("<FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(dr("SDLCProcess").ToString)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)

        End If
        CommonFunction.Data.DisposeDataReader(dr)
        Call DrawActivitySection()
        m_sbHTML.Append("<BR>" + vbCrLf)
        Call DrawRelatedProcesses()
        m_sbHTML.Append("<BR>" + vbCrLf)
        Call DrawRoles()

        m_sbHTML.Append("</TABLE>" + vbCrLf)
        m_sbHTML.Append("</DIV>" + vbCrLf)
    End Sub
    Private Sub DrawRelatedProcesses()
        Dim strQuery As String
        Dim dr As IDataReader
        Dim RelatedProcessID As String
        Dim ProcessName As String
        Dim Description As String
        Dim CNTRelatedProcesses As Integer
        CNTRelatedProcesses = 1

        'strQuery = "select RelatedProcessID,ProcessName,[Description] from V_tbl_PRS_RelatedProcess where ProcessID = " + m_strProcessID + " ORDER BY ProcessName"

        strQuery = "usp_Sel_Project_Related_Prcocess '" + m_strFromWhere + "'," + m_strProcessID + "," + Session("intProjectID").ToString()

        dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        While dr.Read()

            If CNTRelatedProcesses = 1 Then
                m_sbHTML.Append("<TR class='clsTRPageCaption'>" + vbCrLf)
                m_sbHTML.Append("<TD colspan='2'  align='left'>")
                m_sbHTML.Append("<A href=Javascript:showHide_divActivity('divRelatedProcess')><IMG id='imgdivRelatedProcess' Collapse='Y' border=0 Src='../../Images/plus.gif' ></A>" + vbCrLf)
                m_sbHTML.Append("Related Process</TD>" + vbCrLf)
                m_sbHTML.Append("</TR>" + vbCrLf)

                m_sbHTML.Append("<TR>" + vbCrLf)
                m_sbHTML.Append("<TD align='left' colspan='2'>" + vbCrLf)

                m_sbHTML.Append("<DIV Id=divRelatedProcess Style='display:none;OVERFLOW:auto;WIDTH:99.9%'>")

                m_sbHTML.Append("<TABLE class='clsTable'>" + vbCrLf)
            End If

            RelatedProcessID = CType(CommonFunctions.Data.CheckIsDBNull(dr("RelatedProcessID"), "-"), String)
            ProcessName = CType(CommonFunctions.Data.CheckIsDBNull(dr("ProcessName"), "-"), String)
            Description = CType(CommonFunctions.Data.CheckIsDBNull(dr("Description"), "-"), String)


            If CNTRelatedProcesses Mod 2 <> 0 Then
                m_sbHTML.Append("<TR>" + vbCrLf)

                m_sbHTML.Append("<TD colspan='2' align='left' width=50%>" + vbCrLf)
                m_sbHTML.Append("<A href=Javascript:RelatedProcess_onClick(" + RelatedProcessID + ")>" + vbCrLf)
                m_sbHTML.Append("<FONT face='courier New' size='2'>" + ProcessName + "</FONT>")
                m_sbHTML.Append("</A></TD>" + vbCrLf)
            Else
                m_sbHTML.Append("<TD colspan='2' align='left' width=50%>" + vbCrLf)
                m_sbHTML.Append("<A href=Javascript:RelatedProcess_onClick(" + RelatedProcessID + ")>" + vbCrLf)
                m_sbHTML.Append("<FONT face='courier New' size='2' >" + ProcessName + "</FONT>")
                m_sbHTML.Append("</A></TD>" + vbCrLf)

                m_sbHTML.Append("</TR>" + vbCrLf)
            End If


            'm_sbHTML.Append("<TR>" + vbCrLf)
            'm_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Description</EM> </FONT></STRONG> : </TD>" + vbCrLf)
            'm_sbHTML.Append("</TR>" + vbCrLf)
            'm_sbHTML.Append("<TR>" + vbCrLf)
            'm_sbHTML.Append("<TD width='3%'></TD><TD width='97%' ><FONT face='courier New' size='2'>" + vbCrLf)
            'm_sbHTML.Append(Description)
            'm_sbHTML.Append("</FONT></TD>" + vbCrLf)
            'm_sbHTML.Append("</TR>" + vbCrLf)

            CNTRelatedProcesses += 1
        End While
        CommonFunction.Data.DisposeDataReader(dr)
        If CNTRelatedProcesses > 1 Then
            m_sbHTML.Append("</TABLE>" + vbCrLf)
            m_sbHTML.Append("</DIV>")
            m_sbHTML.Append("</TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
        End If

    End Sub
    Private Sub DrawRoles()

        Dim strQuery As String
        Dim dr As IDataReader
        Dim RoleDescription As String
        Dim CNTRoles As Integer
        CNTRoles = 1

        'strQuery = "select RoleDescription from v_tbl_Prs_Process_RoleResponsible_Draft where ProcessID = " + m_strProcessID + " ORDER BY RoleDescription"

        strQuery = "usp_Sel_Project_Related_Roles '" + m_strFromWhere + "'," + m_strProcessID + "," + Session("intProjectID").ToString()

        dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        

        While dr.Read()
            If CNTRoles = 1 Then
                m_sbHTML.Append("<TR class='clsTRPageCaption'>" + vbCrLf)
                m_sbHTML.Append("<TD colspan='2'  align='left'>")
                m_sbHTML.Append("<A href=Javascript:showHide_divActivity('divRoles')><IMG id='imgdivRoles' Collapse='Y' border=0 Src='../../Images/plus.gif' ></A>" + vbCrLf)
                m_sbHTML.Append("Roles Responsible for the Process</TD>" + vbCrLf)
                m_sbHTML.Append("</TR>" + vbCrLf)

                m_sbHTML.Append("<TR>" + vbCrLf)
                m_sbHTML.Append("<TD align='left' colspan='2'>" + vbCrLf)
                m_sbHTML.Append("<DIV Id=divRoles Style='display:none;OVERFLOW:auto;WIDTH:99.9%'>")
                m_sbHTML.Append("<TABLE class='clsTable'>" + vbCrLf)
            End If
            RoleDescription = CType(CommonFunctions.Data.CheckIsDBNull(dr("RoleDescription"), "-"), String)

            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'>" + vbCrLf)
            m_sbHTML.Append("<FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(RoleDescription)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)

            CNTRoles += 1
        End While
        CommonFunction.Data.DisposeDataReader(dr)
        If CNTRoles > 1 Then
            m_sbHTML.Append("</TABLE>" + vbCrLf)
            m_sbHTML.Append("</DIV>")
            m_sbHTML.Append("</TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
        End If

    End Sub

    Private Sub DrawActivitySection()
        'To draw Activity Heading
        Dim strQuery As String
        Dim dr As IDataReader

        strQuery = "usp_Sel_Process_Activities_View " + m_strProcessID + ",'" + m_strFromWhere + "'," + Session("intProjectID").ToString

        dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        Dim ActivityStageID As String
        Dim ActivityOrderNumber As String
        Dim Title As String
        Dim Objective As String
        Dim Scope As String
        Dim InputCriteria As String
        Dim Inputs As String
        Dim ActivityDetails As String
        Dim ExitCriteria_ForActivity As String
        Dim ReviewActivity As String
        Dim IsActive As String
        Dim DivCNT As Integer
        DivCNT = 1
        Dim CNTActivity As Integer
        CNTActivity = 1

        
        'Details Activities
        While dr.Read()

            If CNTActivity = 1 Then
                m_sbHTML.Append("<TR class='clsTRPageCaption'>" + vbCrLf)
                m_sbHTML.Append("<TD colspan='2'  align='left'>" + vbCrLf)
                m_sbHTML.Append("<A href=Javascript:showHide_divActivity('divActivity')><IMG id='imgdivActivity' Collapse='N' border=0 Src='../../Images/minus.gif' ></A>" + vbCrLf)
                m_sbHTML.Append("Activity Details</TD>" + vbCrLf)
                m_sbHTML.Append("</TR>" + vbCrLf)

                m_sbHTML.Append("<TR>" + vbCrLf)
                m_sbHTML.Append("<TD align='left' colspan='2'>" + vbCrLf)

                m_sbHTML.Append("<DIV Id=divActivity Style='OVERFLOW:auto;WIDTH:99.9%'>")

                m_sbHTML.Append("<TABLE>" + vbCrLf)
                m_sbHTML.Append("<TR>" + vbCrLf)
                m_sbHTML.Append("<TD align='left' colspan='2'>" + vbCrLf)
            End If
            ActivityStageID = CType(CommonFunctions.Data.CheckIsDBNull(dr("ActivityStageID"), "-"), String)
            ActivityOrderNumber = CType(CommonFunctions.Data.CheckIsDBNull(dr("ActivityOrderNumber"), "-"), String)
            Title = CType(CommonFunctions.Data.CheckIsDBNull(dr("Title"), "-"), String)
            Objective = CType(CommonFunctions.Data.CheckIsDBNull(dr("Objective"), "-"), String)
            Scope = CType(CommonFunctions.Data.CheckIsDBNull(dr("Scope"), "-"), String)
            InputCriteria = CType(CommonFunctions.Data.CheckIsDBNull(dr("InputCriteria"), "-"), String)
            Inputs = CType(CommonFunctions.Data.CheckIsDBNull(dr("Inputs"), "-"), String)
            ActivityDetails = CType(CommonFunctions.Data.CheckIsDBNull(dr("ActivityDetails"), "-"), String)
            ExitCriteria_ForActivity = CType(CommonFunctions.Data.CheckIsDBNull(dr("ExitCriteria"), "-"), String)
            ReviewActivity = CType(CommonFunctions.Data.CheckIsDBNull(dr("ReviewActivity"), "-"), String)
            IsActive = CType(CommonFunctions.Data.CheckIsDBNull(dr("IsActive"), "-"), String)


            m_sbHTML.Append("<TABLE class='clsTable'>" + vbCrLf)
            'Activity Name
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>" + vbCrLf)
            m_sbHTML.Append("<A href=Javascript:showHide_divActivity('divActivityDetails" + DivCNT.ToString() + "')><IMG id='imgdivActivityDetails" + DivCNT.ToString() + "' Collapse='Y' border=0 Src='../../Images/plus.gif' ></A>" + vbCrLf)
            'm_sbHTML.Append("Activity Name</EM> </FONT></STRONG> : " + vbCrLf)
            m_sbHTML.Append("</EM> </FONT></STRONG>" + vbCrLf)
            m_sbHTML.Append("<FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(Title)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            'Activity Stage ID
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'>" + vbCrLf)
            m_sbHTML.Append("<DIV Id='divActivityDetails" + DivCNT.ToString() + "' Style='display:none;OVERFLOW:auto;WIDTH:99.9%'>")
            m_sbHTML.Append("<TABLE class='clsTable'>" + vbCrLf)

            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Activity Stage ID</EM> </FONT></STRONG> : " + vbCrLf)
            m_sbHTML.Append("<FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(ActivityStageID)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            'Activity Order Number
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Activity Order Number</EM> </FONT></STRONG> : " + vbCrLf)
            m_sbHTML.Append("<FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(ActivityOrderNumber)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)

            'Objective
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Objective</EM> </FONT></STRONG> : </TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD width='3%'></TD><TD width='97%' ><FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(Objective)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            'Scope
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Scope</EM> </FONT></STRONG> : </TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD width='3%'></TD><TD width='97%' ><FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(Scope)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            'InputCriteria
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Input Criteria</EM> </FONT></STRONG> : </TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD width='3%'></TD><TD width='97%' ><FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(InputCriteria)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            'Inputs
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Inputs</EM> </FONT></STRONG> : </TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD width='3%'></TD><TD width='97%' ><FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(Inputs)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            'Activity Details
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Activity Details</EM> </FONT></STRONG> : </TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD width='3%'></TD><TD width='97%' ><FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(ActivityDetails)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            'Exit Criteria
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Exit Criteria</EM> </FONT></STRONG> : </TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD width='3%'></TD><TD width='97%' ><FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(ExitCriteria_ForActivity)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            'ReviewActivity
            m_sbHTML.Append("<TR>" + vbCrLf)
            m_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Reviewed Frequently</EM> </FONT></STRONG> : " + vbCrLf)
            m_sbHTML.Append("<FONT face='courier New' size='2'>" + vbCrLf)
            m_sbHTML.Append(ReviewActivity)
            m_sbHTML.Append("</FONT></TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            ''Active
            'm_sbHTML.Append("<TR>" + vbCrLf)
            'm_sbHTML.Append("<TD colspan='2'><STRONG><FONT face='courier New'><EM>Active</EM> </FONT></STRONG> : " + vbCrLf)
            'm_sbHTML.Append("<FONT face='courier New' size='2'>" + vbCrLf)
            'm_sbHTML.Append(IsActive)
            'm_sbHTML.Append("</FONT></TD>" + vbCrLf)
            'm_sbHTML.Append("</TR>" + vbCrLf)

            m_sbHTML.Append("</TABLE>" + vbCrLf)
            m_sbHTML.Append("</DIV>")
            m_sbHTML.Append("</TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)

            m_sbHTML.Append("</TABLE>" + vbCrLf)

            m_sbHTML.Append("<BR>" + vbCrLf)
            m_sbHTML.Append("</DIV>")
            DivCNT += 1

            
            CNTActivity += 1
        End While
        CommonFunction.Data.DisposeDataReader(dr)
        'End of Activity Details
        If CNTActivity > 1 Then
            m_sbHTML.Append("</TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
            m_sbHTML.Append("</TABLE>" + vbCrLf)

            m_sbHTML.Append("</DIV>")

            m_sbHTML.Append("</TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)
        End If

    End Sub
    Private Sub GenerateMenu()
        '====================================================================
        ' Procedure Name        :  GenerateMenu
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To getnerate Menu
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  ShraddhaM
        ' Created               :  21,Feb 2008
        '=====================================================================
        Dim arrMenu As System.Collections.ArrayList = New System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList = New System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList = New System.Collections.ArrayList
        Dim strImage As String
        Dim strSQL As String
        Dim strmenu As String

        arrMenu.Add("Get Document")
        arrMenuToolTip.Add("Get Word Document")
        arrClientSideFunctions.Add("GetDoc_Click()")

        arrMenu.Add("Edit")
        arrMenuToolTip.Add("Edit Process")
        arrClientSideFunctions.Add("Edit_Click()")

        If m_strFromWhere.ToUpper() = "PRO" Then
            arrMenu.Add("Back")
            arrMenuToolTip.Add("Back")
            arrClientSideFunctions.Add("Back_Click()")
        End If

        'arrMenu.Add("<Img Border=0 src='../../Images/cssImages/Link images/close.gif'>&nbsp;Close")
        'arrMenuToolTip.Add("Close")
        'arrClientSideFunctions.Add("Close_Click()")

        If m_strFromWhere = "PM" Then
            arrMenu.Add("&nbsp;Help")
            arrMenuToolTip.Add("Help")
            arrClientSideFunctions.Add("Help_OnClick(2022)")
        ElseIf m_strFromWhere = "PRO" Then
            arrMenu.Add("&nbsp;Help")
            arrMenuToolTip.Add("Help")
            arrClientSideFunctions.Add("Help_OnClick(1040)")
        End If


        m_objMenu = New WebPages.Template.StaticMenu

        strmenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenu), GetArray(arrClientSideFunctions), GetArray(arrMenuToolTip), True)

        m_sbHTML.Append(strmenu)

        m_objMenu = Nothing


    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()

        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
End Class
