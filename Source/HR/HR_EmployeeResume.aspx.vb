Public Class HR_EmployeeResume
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.

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
        InitializeComponent()
        ''Added by Yogesh J on 15-Feb-2016 to validate Token
        If Request.QueryString("EmployeeID") IsNot Nothing And Request.QueryString("Token") IsNot Nothing Then
            If Request.QueryString("FromWhere") = "PM" Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("EmployeeID"), String) + CType(0, String) + CType(0, String), Request.QueryString("Token")) = False) Then
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If

            End If
        End If
        ''End of addition by Yogesh J on on 15-Feb-2016 to validate Token
    End Sub

#End Region
    '=====================================================================
    ' Page Name             : HR_EmployeeResume
    ' Purpose               : To display the resume of an employee 
    ' Description           : This page is called from the Releases page
    ' Parameters Passed     : 
    ' Assumptions           : 
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : AniruddhaD
    ' Created               : 12 March 2004
    ' Revisions             : 
    '=====================================================================
    'TODO : prepare resource file for this page
    Private m_strPageHTML As New System.Text.StringBuilder("")
    Private m_strDocBody As New System.Text.StringBuilder("")
    Private m_intEmployeeID As Integer

    Public Sub PageInit()

        ''Added By Vidya Jadhav ON 20/04/2017 For Unauthenticated user can view this page. 
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Of Added By Vidya Jadhav ON 20/04/2017 For Unauthenticated user can view this page. 

        ''Added by Shamkant S  on 16/02/2016 to validate Token
        If (Request.QueryString("Token") <> "" And Request.QueryString("EmployeeID") <> "") Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("EmployeeID"), String) + "0" + "0", Request.QueryString("Token")) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("EmployeeID"), String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")


            End If

        End If
        ''End of addiotion by Shamkant S  on 16/02/2016 to validate Token
        '######### Page Code starts here
        m_strPageHTML.Append("<TABLE BORDER='1' ALIGN='center' WIDTH='99%' BORDERCOLOR='#cccccc'><TR><TD>")
        Call SetVariables()
        Call DisplayEmployeeInformationFormatI()
        Call DisplayQualificationFormatI()
        Call DisplayCertificationsFormatI()
        Call DisplaySkillSetsFormatI()
        Call DisplayPreviousWorkExperienceFormatI()
        Call DisplayCurrentAssignmentsFormatI()
        Call DisplayPreviousAssignmentsFormatI()
        Call DisplayPassportDetailsFormatI()
        Call DisplayVisaDetailsFormatI()

        If Not HttpContext.Current.Request.QueryString("Type") Is Nothing Then
            If HttpContext.Current.Request.QueryString("Type").ToUpper() = "DOC" Then
                m_strDocBody.Append("<HTML " & _
               "xmlns:o='urn:schemas-microsoft-com:office:office' " & _
               "xmlns:w='urn:schemas-microsoft-com:office:word'" & _
               "xmlns='http://www.w3.org/TR/REC-html40' >" & _
               "<HEAD><TITLE>Resmue</TITLE>")
                'The setting specifies document's view after it is downloaded as Print instead of the default Web Layout
                m_strDocBody.Append("<!--[if gte mso 9]>" & _
                                            "<xml>" & _
                                            "<w:WordDocument>" & _
                                            "<w:View>Print</w:View>" & _
                                            "<w:Zoom>90</w:Zoom>" & _
                                            "<w:DoNotOptimizeForBrowser/>" & _
                                            "</w:WordDocument>" & _
                                            "</xml>" & _
                                         "<![endif]-->")

                m_strDocBody.Append("<STYLE>" & _
                                            "<!-- /* Style Definitions */" & _
                                            "@page Section1" & _
                                            "   {size:8.5in 11.0in; " & _
                                            "   margin:1.0in 1.25in 1.0in 1.25in ; " & _
                                            "   mso-header-margin:.5in; " & _
                                            "   mso-footer-margin:.5in; mso-paper-source:0;}" & _
                                            "   div.Section1" & _
                                            "   {page:Section1;}" & _
                                            "-->" & _
                                       "</STYLE></HEAD>")
                m_strPageHTML.Append("</TD></TR></TABLE>")
                m_strDocBody.Append("<BODY LANG='EN-US' STYLE='tab-interval:.5in'>" & _
                                        "<DIV CLASS=Section1>" + m_strPageHTML.ToString + "</DIV></BODY></HTML>")

                'Force this content to be downloaded as a Word document with the name of your choice
                Response.ClearHeaders()
                Response.AppendHeader("Content-Type", "application/msword")
                Response.AppendHeader("Content-disposition", _
                                       "attachment; filename=Resume_" + m_intEmployeeID.ToString() + ".doc")
                Response.Clear()
                Response.Write(m_strDocBody)

            End If
        Else
            Response.Write("<HTML>")
            Response.Write("" + CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("RESUME")))
            Response.Write("<BODY MS_POSITIONING='GridLayout' CLASS='clsBody' ONRESIZE='window_onresize()' ONLOAD='window_onload()'>")
            Response.Write(m_strPageHTML.ToString())

        End If

        '----------------------------------------------------------------
        'Commented by MahendraV for changing format of resume (11 Oct 2007) For WhizinbleSEM 7.1
        'Uncomment following procedure calls to get original format
        '----------------------------------------------------------------
        'Call SetVariables()
        'Call DisplayTitle()
        'Call DisaplyEmployeeInformation()
        'Call DisplayQualification()
        'Call DisplayCertifications()
        'Call DisplaySkillSets()
        'Call DisplayPreviousAssignments()
        'Call DisplayCurrentAssignments()

        ''Added by PrashantSJ on 18th Nov 2005 For IVL
        ''Purpose: To Display Previous Work Assignments For Employee 
        'Call DisplayPreviousWorkAssignments()
        ''End Addition by PrashantSJ 

        '----------------------------------------------------------------
        'End of Commented by MahendraV for changing format of resume (11 Oct 2007) For WhizinbleSEM 7.1
        '----------------------------------------------------------------


    End Sub

    Private Sub SetVariables()
        '=====================================================================
        ' Procedure Name        : SetVariables()	
        ' Purpose               : To set the variables being used in this page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 12, 2004
        ' Revisions             :
        '=====================================================================
        If Not Request.QueryString("EmployeeID") Is Nothing Then
            If Request.QueryString("EmployeeID") <> "" Then
                m_intEmployeeID = CType(Request.QueryString("EmployeeID"), Integer)
            End If
        End If
    End Sub 'Set the varibales being used in this page
    Private Sub DisplayEmployeeInformationFormatI()
        '=====================================================================
        ' Procedure Name        : DisplayEmployeeInformationFormatI()	
        ' Purpose               : To display Employee information for format I
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV 
        ' Created               : 11-Oct-2007
        ' Revisions             :
        '=====================================================================


        Dim drEmployee As IDataReader
        Dim strSQL As String
        Dim strEmployeeImage As String
        Dim strDocLink As String = ""
        Dim strImageName As String = ""
        strSQL = "Exec usp_tbl_Sel_EmployeeInfo " + m_intEmployeeID.ToString
        drEmployee = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)


        'Exit procedure if no employee found
        If Not drEmployee.Read Then Exit Sub
        If HttpContext.Current.Request.QueryString("Type") Is Nothing Then
            strDocLink = "<A href='../HR/HR_EmployeeResume.aspx?EmployeeID=" + m_intEmployeeID.ToString + "&Type=Doc'>Export To Word</A>"
            strEmployeeImage = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT '../../Images/Photo/' + SystemFilename FROM tbl_RM_EmployeeMaintenance_Attachment  WHERE EmployeeID=" & m_intEmployeeID, MyBase.UseSQL), ""))
        Else
            If HttpContext.Current.Request.QueryString("Type").ToUpper() = "DOC" Then
                strImageName = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT SystemFilename FROM tbl_RM_EmployeeMaintenance_Attachment  WHERE EmployeeID=" & m_intEmployeeID, MyBase.UseSQL), ""))
                Dim I As Integer = HttpContext.Current.Request.Url.ToString.IndexOf("Source")
                strEmployeeImage = HttpContext.Current.Request.Url.ToString.Substring(0, I - 1)
                strEmployeeImage = strEmployeeImage.Replace("\", "/")
                strEmployeeImage = strEmployeeImage + "/Images/Photo/" + strImageName
                strDocLink = ""
            End If
        End If

        m_strPageHTML.Append("<TABLE BORDER='0' WIDTH='100%'>")
        m_strPageHTML.Append("<TR>")
        m_strPageHTML.Append("<TD WIDTH='100%' ALIGN='left' COLSPAN = '3' >" + strDocLink + "</TD>")
        m_strPageHTML.Append("</TR>")

        m_strPageHTML.Append("<TR>")
        m_strPageHTML.Append("<TD  ALIGN='Left' WIDTH='25%' ROWSPAN='6'><IMG BORDER=0 ID=tdShowHide_showHide_divSection1 SRC='" + strEmployeeImage + "' TITLE='' HEIGHT=150 WIDTH=150></TD>")
        m_strPageHTML.Append("<TD WIDTH='44%' ALIGN='left'></TD>")
        m_strPageHTML.Append("<TD WIDTH='31%' ALIGN='right'><FONT FACE='Arial Narrow'>" + drEmployee("Address").ToString() + "</FONT></TD>")
        m_strPageHTML.Append("</TR>")
        m_strPageHTML.Append("<TR>")
        m_strPageHTML.Append("<TD WIDTH='44%'></TD>")
        m_strPageHTML.Append("<TD WIDTH='31%' ALIGN='right'><FONT FACE='Arial Narrow'>" + drEmployee("City").ToString + " - " + drEmployee("PinCode").ToString + "</FONT></TD>")
        m_strPageHTML.Append("</TR>")
        m_strPageHTML.Append("<TR>")
        m_strPageHTML.Append("<TD WIDTH='44%'></TD>")
        If CommonFunction.Data.CheckIsDBNull(drEmployee("Country"), "").ToString() <> "" Then
            m_strPageHTML.Append("<TD WIDTH='31%' ALIGN='right'><FONT FACE='Arial Narrow'>" + drEmployee("State").ToString + " - " + drEmployee("Country").ToString + "</FONT></TD>")
        Else
            m_strPageHTML.Append("<TD WIDTH='31%' ALIGN='right'><FONT FACE='Arial Narrow'>" + drEmployee("State").ToString + "</FONT></TD>")
        End If
        m_strPageHTML.Append("</TR>")
        m_strPageHTML.Append("<TR>")
        m_strPageHTML.Append("<TD WIDTH='44%' ALIGN='center'>")
        m_strPageHTML.Append("<FONT SIZE='5' FACE='Arial Narrow'><B>" + drEmployee("EmployeeName").ToString + "</B></FONT></TD>")
        If CommonFunction.Data.CheckIsDBNull(drEmployee("BirthDate"), "").ToString.Trim() <> "" Then
            m_strPageHTML.Append("<TD WIDTH='31%' ALIGN='right'><FONT FACE='Arial Narrow'>" + MyBase.GetResourceString("BIRTHDATE") + ":" + CommonFunction.Dates.CGetDate(CType(drEmployee("BirthDate"), Date)).ToString() + "</FONT></TD>")
        Else
            m_strPageHTML.Append("<TD WIDTH='31%' ALIGN='right'><FONT FACE='Arial Narrow'></FONT></TD>")
        End If
        m_strPageHTML.Append("</TR>")
        m_strPageHTML.Append("<TR>")
        m_strPageHTML.Append("<TD WIDTH='44%'></TD>")
        m_strPageHTML.Append("<TD WIDTH='31%' ALIGN='right'><FONT FACE='Arial Narrow' >Phone No.:" + drEmployee("Phone").ToString() + "</FONT></TD>")
        m_strPageHTML.Append("</TR>")
        m_strPageHTML.Append("<TR>")
        If drEmployee("EmailID").ToString <> "" Then
            m_strPageHTML.Append("<TD WIDTH='75%' ALIGN='right' COLSPAN='2'><FONT FACE='Arial Narrow' >Email ID :</FONT><A HREF=mailto:" + drEmployee("EmailID").ToString + " <FONT FACE='Arial Narrow'>" + drEmployee("EmailID").ToString + "</FONT></A></TD>")
        Else
            m_strPageHTML.Append("<TD WIDTH='75%' ALIGN='right' COLSPAN='2'><FONT FACE='Arial Narrow' ></FONT></TD>")
        End If
        m_strPageHTML.Append("</TR>")
        m_strPageHTML.Append("</TABLE>")
        m_strPageHTML.Append("<HR>")

        CommonFunction.Data.DisposeDataReader(drEmployee)

    End Sub 'Display employee Information
    Private Sub DisplayQualificationFormatI()
        '=====================================================================
        ' Procedure Name        : DisplayQualificationFormatI()	
        ' Purpose               : To display employee qualifications for FormatI
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : Oct 11, 2007
        ' Revisions             :
        '=====================================================================

        Dim drQualifications As IDataReader

        drQualifications = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmployeeQualificationMatrix NULL,NULL,NULL," + m_intEmployeeID.ToString, MyBase.UseSQL)
        If Not drQualifications.Read Then
            Exit Sub
        Else
            m_strPageHTML.Append("<TABLE BORDER='0' WIDTH='100%'>")
        End If

        Do
            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='33%'>")
            m_strPageHTML.Append("<UL>")
            m_strPageHTML.Append("<LI><FONT FACE='Arial Narrow'><I>" + Server.HtmlEncode(drQualifications("QualificationName").ToString.Trim) + "</I> (" + Server.HtmlEncode(drQualifications("PassoutYear").ToString.Trim) + ")")
            m_strPageHTML.Append(" From " + Server.HtmlEncode(drQualifications("University").ToString.Trim))
            If drQualifications("Percentage").ToString.Trim <> "" Then
                m_strPageHTML.Append(" with " + Server.HtmlEncode(drQualifications("Percentage").ToString.Trim) + " GPA.")
            End If
            m_strPageHTML.Append("</FONT></LI>")
            m_strPageHTML.Append("</UL>")
            m_strPageHTML.Append("</TD>")
            m_strPageHTML.Append("</TR>")
        Loop While drQualifications.Read

        m_strPageHTML.Append("</TABLE>")

        CommonFunction.Data.DisposeDataReader(drQualifications)

    End Sub ' Display employee qualifications of employee
    Private Sub DisplayCertificationsFormatI()
        '=====================================================================
        ' Procedure Name        : DisplayCertificationsFormatI()	
        ' Purpose               : To display employee certifications for format I
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : Oct 11, 2007
        ' Revisions             :
        '=====================================================================

        Dim drCertifications As IDataReader

        drCertifications = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmployeeCertificationMatrix NULL,NULL,NULL," + m_intEmployeeID.ToString, MyBase.UseSQL)
        If Not drCertifications.Read Then
            Exit Sub
        Else
            m_strPageHTML.Append("<TABLE BORDER='0' WIDTH='100%'>")
        End If

        Do
            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='33%'>")
            m_strPageHTML.Append("<UL>")
            m_strPageHTML.Append("<LI><FONT FACE='Arial Narrow'>Completed <I>" + Server.HtmlEncode(drCertifications("CertificationName").ToString.Trim) + "</I>")
            If CommonFunction.Data.CheckIsDBNull(drCertifications("CertificationDate"), "").ToString() <> "" Then
                m_strPageHTML.Append(" on " + CommonFunction.Dates.CGetDate(CType(drCertifications("CertificationDate"), Date)))
            End If
            If CommonFunction.Data.CheckIsDBNull(drCertifications("ActualScore"), "").ToString() <> "" Then
                m_strPageHTML.Append(" with score " + drCertifications("ActualScore").ToString.Trim)
            End If
            If drCertifications("TotalScore").ToString.Trim <> "" Then
                m_strPageHTML.Append(" out of " + drCertifications("TotalScore").ToString.Trim)
            End If
            m_strPageHTML.Append(".")
            If CommonFunction.Data.CheckIsDBNull(drCertifications("ValidUpto"), "").ToString <> "" Then
                m_strPageHTML.Append("It is valid upto ")
                m_strPageHTML.Append(CommonFunction.Dates.CGetDate(CType(drCertifications("ValidUpto"), Date)))
                m_strPageHTML.Append(".")
            End If
            m_strPageHTML.Append("</FONT></LI>")
            m_strPageHTML.Append("</UL>")
            m_strPageHTML.Append("</TD>")
            m_strPageHTML.Append("</TR>")
        Loop While drCertifications.Read
        CommonFunction.Data.DisposeDataReader(drCertifications)
        m_strPageHTML.Append("</TABLE>")
        m_strPageHTML.Append("<HR>")

    End Sub ' Display employee certifications
    Private Sub DisplaySkillSetsFormatI()
        '=====================================================================
        ' Procedure Name        : DisplaySkillSetsFormatI()	
        ' Purpose               : To display employee skill sets for format I
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : Oct 11, 2007
        ' Revisions             :
        '=====================================================================

        Dim drEmployeeSkills As IDataReader

        drEmployeeSkills = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmployeeSkillMatrix NULL,NULL,NULL," + m_intEmployeeID.ToString, MyBase.UseSQL)
        If Not drEmployeeSkills.Read Then
            Exit Sub
        Else
            m_strPageHTML.Append("<TABLE BORDER='0' WIDTH='100%'>")
            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='100%'>")
            m_strPageHTML.Append("<P ALIGN='center'><B><FONT SIZE='4' FACE='Arial Narrow'>" + MyBase.GetResourceString("TECHNICAL_SKILLS") + "</font></B></td>")
            m_strPageHTML.Append("</TR>")
        End If

        Do
            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='60%'>")
            m_strPageHTML.Append("<UL>")
            m_strPageHTML.Append("<LI><FONT FACE='Arial Narrow'><I>" + Server.HtmlEncode(drEmployeeSkills("Tool").ToString.Trim) + "</I>")
            If drEmployeeSkills("YearsOfExperience").ToString.Trim <> "" Then
                If drEmployeeSkills("YearsOfExperience").ToString.Trim = "0" Then
                    ' do not do anything
                Else
                    m_strPageHTML.Append(" - Experience of ")
                    If drEmployeeSkills("YearsOfExperience").ToString.Trim = "1" Then
                        m_strPageHTML.Append(drEmployeeSkills("YearsOfExperience").ToString.Trim + MyBase.GetResourceString("YEAR"))
                    Else
                        m_strPageHTML.Append(drEmployeeSkills("YearsOfExperience").ToString.Trim + MyBase.GetResourceString("YEARS"))
                    End If
                End If
            End If

            If drEmployeeSkills("MonthsOfExperience").ToString.Trim <> "" Then
                If drEmployeeSkills("MonthsOfExperience").ToString.Trim = "0" Then
                    'do not do anything
                Else
                    If drEmployeeSkills("YearsOfExperience").ToString.Trim <> "" Then
                        If drEmployeeSkills("YearsOfExperience").ToString.Trim <> "0" Then
                            m_strPageHTML.Append(" and ")
                        Else
                            m_strPageHTML.Append(" - Experience of ")
                        End If
                    Else
                        m_strPageHTML.Append(" - Experience of ")
                    End If

                    If drEmployeeSkills("MonthsOfExperience").ToString.Trim = "1" Then
                        m_strPageHTML.Append(drEmployeeSkills("MonthsOfExperience").ToString.Trim + MyBase.GetResourceString("MONTH"))
                    Else
                        m_strPageHTML.Append(drEmployeeSkills("MonthsOfExperience").ToString.Trim + MyBase.GetResourceString("MONTHS"))
                    End If
                End If
            End If
            m_strPageHTML.Append(".</FONT></LI>")
            m_strPageHTML.Append("</UL>")
            m_strPageHTML.Append("</TD>")
            m_strPageHTML.Append("</TR>")
        Loop While drEmployeeSkills.Read

        m_strPageHTML.Append("</TABLE>")
        m_strPageHTML.Append("<HR>")
        CommonFunction.Data.DisposeDataReader(drEmployeeSkills)

    End Sub ' Display employee skillsets
    Private Sub DisplayPreviousWorkExperienceFormatI()
        '=====================================================================
        ' Procedure Name        : DisplayPreviousWorkExperienceFormatI()	
        ' Purpose               : To display previous work experiance of the employee for format I
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : Oct 11, 2007
        ' Revisions             :
        '=====================================================================

        Dim drEmployeeHistory As IDataReader

        drEmployeeHistory = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmployeeHistory NULL,NULL," + m_intEmployeeID.ToString, MyBase.UseSQL)
        If Not drEmployeeHistory.Read Then
            Exit Sub
        End If

        m_strPageHTML.Append("<TABLE BORDER='0' WIDTH='100%'>")
        m_strPageHTML.Append("<TR>")
        m_strPageHTML.Append("<TD WIDTH='66%' COLSPAN='2' ALIGN='center'><B><FONT SIZE='4' FACE='Arial Narrow'>" + MyBase.GetResourceString("PREVIOUSWORKASSIGNMENT") + "</FONT></B></TD>")
        m_strPageHTML.Append("</TR>")

        Do
            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='37%'><FONT FACE='Arial Narrow'><B>" + Server.HtmlEncode(drEmployeeHistory("OrganizationName").ToString.Trim) + "</B></FONT></TD>")
            m_strPageHTML.Append("<TD WIDTH='29%'>")
            If (drEmployeeHistory("WorkedFrom").ToString.Trim <> "" Or drEmployeeHistory("WorkedTill").ToString.Trim <> "") Then
                m_strPageHTML.Append("<P ALIGN='right'><FONT FACE='Arial Narrow'><B>" + "(From ")
                If drEmployeeHistory("WorkedFrom").ToString.Trim <> "" Then
                    m_strPageHTML.Append(CommonFunction.Dates.CGetDate(CType(drEmployeeHistory("WorkedFrom"), Date)))
                    m_strPageHTML.Append("&nbsp")
                End If
                If drEmployeeHistory("WorkedTill").ToString.Trim <> "" Then
                    m_strPageHTML.Append(" To " + CommonFunction.Dates.CGetDate(CType(drEmployeeHistory("WorkedTill"), Date)))
                End If
                m_strPageHTML.Append(")</B>")
            End If
            m_strPageHTML.Append("</FONT></TD>")
            m_strPageHTML.Append("</TR>")
            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='66%' COLSPAN='2'><FONT FACE='Arial Narrow'><I>" + Server.HtmlEncode(drEmployeeHistory("PositionHeld").ToString.Trim) + "</I></FONT></TD>")
            m_strPageHTML.Append("</TR>")
            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='66%' COLSPAN='2'></TD>")
            m_strPageHTML.Append("</TR>")

        Loop While drEmployeeHistory.Read

        m_strPageHTML.Append("</TABLE>")
        m_strPageHTML.Append("<HR>")

        CommonFunction.Data.DisposeDataReader(drEmployeeHistory)

    End Sub ' Display previous work experiance of the employee
    Private Sub DisplayCurrentAssignmentsFormatI()
        '=====================================================================
        ' Procedure Name        : DisplayCurrentAsignmentsFormatI()	
        ' Purpose               : To display the projects, employee has worked on and currently working on for format I
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : Oct 11, 2007
        ' Revisions             :
        '=====================================================================

        Dim drAssignments As IDataReader

        drAssignments = CommonFunction.Data.GetDataReader("Exec usp_sel_CurrentAssignmentsForEmployee " + m_intEmployeeID.ToString, MyBase.UseSQL)
        If Not drAssignments.Read Then
            Exit Sub
        End If

        m_strPageHTML.Append("<TABLE BORDER='0' WIDTH='100%'>")
        m_strPageHTML.Append("<TR>")
        m_strPageHTML.Append("<TD WIDTH='100%' COLSPAN='2' ALIGN='center'><B><FONT SIZE='4' FACE='Arial Narrow'>" + MyBase.GetResourceString("CURRENTASSIGNMENTS") + "</FONT></B></TD>")
        m_strPageHTML.Append("</TR>")

        Do

            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'><U><B> " + MyBase.GetResourceString("PROJECTNAME") + "</B></U></FONT></TD>")
            m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'><B>:" + Server.HtmlEncode(drAssignments("ProjectName").ToString.Trim) + "</B></FONT></TD>")
            m_strPageHTML.Append("</TR>")

            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'></TD>")
            m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'> " + Server.HtmlEncode(drAssignments("Description").ToString.Trim) + "</FONT></TD>")
            m_strPageHTML.Append("</TR>")

            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>" + MyBase.GetResourceString("DURATION") + "</FONT></TD>")
            m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:")
            'From 
            If CommonFunction.Data.CheckIsDBNull(drAssignments("ActualStartDate"), "").ToString <> "" Then
                m_strPageHTML.Append(" From ")
                m_strPageHTML.Append(CommonFunction.Dates.CGetDate(CType(drAssignments("ActualStartDate"), Date)))
            End If
            If CommonFunction.Data.CheckIsDBNull(drAssignments("ActualEndDate"), "").ToString <> "" Then
                m_strPageHTML.Append(" To ")
                m_strPageHTML.Append(CommonFunction.Dates.CGetDate(CType(drAssignments("ActualEndDate"), Date)))
            End If
            m_strPageHTML.Append("</FONT></TD>")
            m_strPageHTML.Append("</TR>")


            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>" + MyBase.GetResourceString("TEAMSIZE") + "</FONT></TD>")
            m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:" + drAssignments("TeamSize").ToString + "</FONT></TD>")
            m_strPageHTML.Append("</TR>")

            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>" + MyBase.GetResourceString("ROLE") + "</fONT></TD>")
            m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:")
            m_strPageHTML.Append(drAssignments("RoleDescription"))
            m_strPageHTML.Append("</FONT></TD>")
            m_strPageHTML.Append("</TR>")

            If CommonFunction.Data.CheckIsDBNull(drAssignments("Tools"), "").ToString <> "" Then
                m_strPageHTML.Append("<TR>")
                m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>" + MyBase.GetResourceString("SKILLS_UTILIZED") + "</FONT></TD>")
                m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:" + drAssignments("Tools").ToString + "</FONT></TD>")
                m_strPageHTML.Append("</TR>")
            End If
            'Added by ShwetaS on 17 october 2006 for WEPM 2007 
            If CommonFunction.Data.CheckIsDBNull(drAssignments("Responsibility"), "").ToString <> "" Then
                m_strPageHTML.Append("<TR>")
                m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>" + MyBase.GetResourceString("SUMMARY") + "</font></td>")
                m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:" + drAssignments("Responsibility").ToString + "</FONT></TD>")
                m_strPageHTML.Append("</TR>")
            End If

            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'></TD>")
            m_strPageHTML.Append("<TD WIDTH='81%'></TD>")

            m_strPageHTML.Append("</TR>")

            m_strPageHTML.Append("<BR>")



        Loop While drAssignments.Read

        m_strPageHTML.Append("</TABLE>")
        m_strPageHTML.Append("<HR>")

        CommonFunction.Data.DisposeDataReader(drAssignments)

    End Sub ' Display projects, employee has worked on and currently working on.
    Private Sub DisplayPreviousAssignmentsFormatI()
        '=====================================================================
        ' Procedure Name        : DisplayPreviousAssignmentsFormatI()	
        ' Purpose               : To display the Assignments, employee has worked on and currently working on.
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV 
        ' Created               : Oct 11, 2007
        ' Revisions             :
        '=====================================================================

        Dim drPrevWorkAssignments As IDataReader

        drPrevWorkAssignments = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmployeeHistory_Projects " + m_intEmployeeID.ToString, MyBase.UseSQL)
        If Not drPrevWorkAssignments.Read Then
            Exit Sub
        End If

        m_strPageHTML.Append("<TABLE BORDER='0' WIDTH='100%'>")
        m_strPageHTML.Append("<TR>")
        m_strPageHTML.Append("<TD WIDTH='100%' COLSPAN='2' ALIGN='center'><B><FONT SIZE='4' FACE='Arial Narrow'>" + MyBase.GetResourceString("PREVIOUSASSIGNMENTS") + "</FONT></B></TD>")
        m_strPageHTML.Append("</TR>")

        Do
            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'><U><B>" + MyBase.GetResourceString("PROJECTNAME") + "</B></U></FONT></TD>")
            m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'><B>:" + Server.HtmlEncode(drPrevWorkAssignments("ProjectName").ToString.Trim) + "</B></FONT></TD>")
            m_strPageHTML.Append("</TR>")

            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'></TD>")
            m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'> " + Server.HtmlEncode(drPrevWorkAssignments("Description").ToString.Trim) + "</FONT></TD>")
            m_strPageHTML.Append("</TR>")

            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>" + MyBase.GetResourceString("DURATION") + "</FONT></TD>")
            m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:" + drPrevWorkAssignments("Duration").ToString + "</FONT></TD>")
            m_strPageHTML.Append("</TR>")

            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>" + MyBase.GetResourceString("TEAMSIZE") + "</FONT></TD>")
            m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:" + drPrevWorkAssignments("TeamSize").ToString + "</FONT></TD>")
            m_strPageHTML.Append("</TR>")

            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>" + MyBase.GetResourceString("ROLE") + "</FONT></TD>")

            m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:")
            m_strPageHTML.Append(drPrevWorkAssignments("Role"))
            m_strPageHTML.Append("</FONT></TD>")
            m_strPageHTML.Append("</TR>")

            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>" + MyBase.GetResourceString("ENVIRONMENT") + "</FONT></TD>")
            ''HTML Encode Aded by Dhanashri S on 7 Dec 2015 for IssueID:2675
            m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:" + HttpUtility.HtmlEncode(drPrevWorkAssignments("Environment").ToString) + "</FONT></TD>")
            ''End of Addition by Dhanashri S on 7 Dec 2015
            m_strPageHTML.Append("</TR>")

            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>" + MyBase.GetResourceString("SKILLS_UTILIZED") + "</FONT></TD>")
            ''HTML Encode Aded by Dhanashri S on 7 Dec 2015 for IssueID:2675
            m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:" + HttpUtility.HtmlEncode(drPrevWorkAssignments("SkillSet").ToString) + "</FONT></TD>")
            ''End of Addition by Dhanashri S on 7 Dec 2015
            m_strPageHTML.Append("</TR>")

            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'></TD>")
            m_strPageHTML.Append("<TD WIDTH='81%'></TD>")
            m_strPageHTML.Append("</TR>")

        Loop While drPrevWorkAssignments.Read

        m_strPageHTML.Append("</TABLE>")
        m_strPageHTML.Append("<HR>")

        CommonFunction.Data.DisposeDataReader(drPrevWorkAssignments)

    End Sub ' Display projects, employee has been worked.
    Private Sub DisplayPassportDetailsFormatI()
        '=====================================================================
        ' Procedure Name        : DisplayPassportDetailsFormatI()	
        ' Purpose               : To display Employee passport information for format I
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV 
        ' Created               : 15-Oct-2007
        ' Revisions             :
        '=====================================================================


        Dim drEmployee As IDataReader
        Dim strSQL As String
        Dim strEmployeeImage As String
        Dim strDocLink As String = ""
        Dim strImageName As String = ""
        strSQL = "Exec usp_tbl_Sel_EmployeeInfo " + m_intEmployeeID.ToString
        drEmployee = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)


        'Exit procedure if no employee found
        If Not drEmployee.Read Then Exit Sub

        m_strPageHTML.Append("<TABLE BORDER='0' WIDTH='100%'>")
        m_strPageHTML.Append("<TR>")
        m_strPageHTML.Append("<TD WIDTH='100%' COLSPAN='2' ALIGN='center'><B><FONT SIZE='4' FACE='Arial Narrow'>" + MyBase.GetResourceString("PASSPORT_DETAILS") + "</FONT></B></TD>")
        m_strPageHTML.Append("</TR>")

        m_strPageHTML.Append("<TR>")
        m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>" + MyBase.GetResourceString("FULL_NAME") + "</FONT></TD>")
        m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:" + Server.HtmlEncode(drEmployee("PP_FullName").ToString.Trim) + "</FONT></TD>")
        m_strPageHTML.Append("</TR>")

        m_strPageHTML.Append("<TR>")
        m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>" + MyBase.GetResourceString("PASSPORTNO") + "</FONT></TD>")
        m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:" + Server.HtmlEncode(drEmployee("PassportNumber").ToString.Trim) + "</FONT></TD>")
        m_strPageHTML.Append("</TR>")

        m_strPageHTML.Append("<TR>")
        m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>" + MyBase.GetResourceString("PLACE_OF_ISSUE") + "</FONT></TD>")
        m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:" + Server.HtmlEncode(drEmployee("PP_PlaceOfIssue").ToString.Trim) + "</FONT></TD>")
        m_strPageHTML.Append("</TR>")

        m_strPageHTML.Append("<TR>")
        m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>" + MyBase.GetResourceString("DATE_OF_ISSUE") + "</FONT></TD>")
        If CommonFunction.Data.CheckIsDBNull(drEmployee("PP_DateOfIssue"), "").ToString() <> "" Then
            m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:" + CommonFunction.Dates.CGetDate(CType(drEmployee("PP_DateOfIssue"), Date)) + "</FONT></TD>")
        Else
            m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:</FONT></TD>")

        End If

        m_strPageHTML.Append("</TR>")

        m_strPageHTML.Append("<TR>")
        m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>" + MyBase.GetResourceString("EXPIRY_DATE") + "</FONT></TD>")
        If CommonFunction.Data.CheckIsDBNull(drEmployee("PP_ExpiryDate"), "").ToString() <> "" Then
            m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:" + CommonFunction.Dates.CGetDate(CType(drEmployee("PP_ExpiryDate"), Date)) + "</FONT></TD>")
        Else
            m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:</FONT></TD>")

        End If
        m_strPageHTML.Append("</TR>")

        'm_strPageHTML.Append("<TR>")
        'm_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>Son of/Wife of/Daughter of:</FONT></TD>")
        'm_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>" + Server.HtmlEncode(drEmployee("PP_RelativeName").ToString.Trim) + "</FONT></TD>")
        'm_strPageHTML.Append("</TR>")

        'm_strPageHTML.Append("<TR>")
        'm_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>No of Pages Left:</FONT></TD>")
        'm_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>" + Server.HtmlEncode(drEmployee("NoofPagesLeft").ToString.Trim) + "</FONT></TD>")
        'm_strPageHTML.Append("</TR>")



        m_strPageHTML.Append("</TABLE>")
        m_strPageHTML.Append("<HR>")

        CommonFunction.Data.DisposeDataReader(drEmployee)
    End Sub ' Display employee passport details.
    Private Sub DisplayVisaDetailsFormatI()
        '=====================================================================
        ' Procedure Name        : DisplayVisaDetailsFormatI()	
        ' Purpose               : To display Employee visa information for format I
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV 
        ' Created               : 15-Oct-2007
        ' Revisions             :
        '=====================================================================
        Dim drVisDetails As IDataReader

        drVisDetails = CommonFunction.Data.GetDataReader("Exec usp_tbl_Sel_EmployeeVisaInfo " + m_intEmployeeID.ToString, MyBase.UseSQL)
        If Not drVisDetails.Read Then
            Exit Sub
        End If

        m_strPageHTML.Append("<TABLE BORDER='0' WIDTH='100%'>")
        m_strPageHTML.Append("<TR>")
        m_strPageHTML.Append("<TD WIDTH='100%' COLSPAN='2' ALIGN='center'><B><FONT SIZE='4' FACE='Arial Narrow'>" + MyBase.GetResourceString("VISA_DETAILS") + "</FONT></B></TD>")
        m_strPageHTML.Append("</TR>")

        Do
            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'><U><B>" + MyBase.GetResourceString("VISA_TYPES") + "</B></U></FONT></TD>")
            m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'><B>:" + Server.HtmlEncode(drVisDetails("VisaType").ToString.Trim) + "</B></FONT></TD>")
            m_strPageHTML.Append("</TR>")

            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>Country</FONT></TD>")
            m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:" + CType(CommonFunctions.Data.CheckIsDBNull(drVisDetails("CountryName").ToString, ""), String) + "</FONT></TD>")
            m_strPageHTML.Append("</TR>")

            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>" + MyBase.GetResourceString("VALID_FROM") + "</TD>")
            If CommonFunction.Data.CheckIsDBNull(drVisDetails("ValidFrom"), "").ToString() <> "" Then
                m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:" + CommonFunction.Dates.CGetDate(CType(drVisDetails("ValidFrom"), Date)) + "</FONT></TD>")
            Else
                m_strPageHTML.Append("<TD WIDTH='81%'>:</TD>")
            End If
            m_strPageHTML.Append("</TR>")

            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'><FONT FACE='Arial Narrow'>" + MyBase.GetResourceString("VALID_TO") + "</FONT></TD>")
            If CommonFunction.Data.CheckIsDBNull(drVisDetails("ValidUpTo"), "").ToString() <> "" Then
                m_strPageHTML.Append("<TD WIDTH='81%'><FONT FACE='Arial Narrow'>:" + CommonFunction.Dates.CGetDate(CType(drVisDetails("ValidUpTo"), Date)) + "</FONT></TD>")
            Else
                m_strPageHTML.Append("<TD WIDTH='81%'>:</TD>")
            End If
            m_strPageHTML.Append("</TR>")



            m_strPageHTML.Append("<TR>")
            m_strPageHTML.Append("<TD WIDTH='19%'></TD>")
            m_strPageHTML.Append("<TD WIDTH='81%'></TD>")
            m_strPageHTML.Append("</TR>")
        Loop While drVisDetails.Read

        m_strPageHTML.Append("</TABLE>")
        m_strPageHTML.Append("<HR>")

        CommonFunction.Data.DisposeDataReader(drVisDetails)
    End Sub 'Display employee visa details.


    Private Sub DisplayTitle()
        '=====================================================================
        ' Procedure Name        : DisplayTitle	
        ' Purpose               : To display title (Resume)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 4:15 PM 11-Oct-2007
        ' Revisions             :
        '=====================================================================

        Response.Write("<TABLE CLASS='clstable' WIDTH='100%' CELLSPACING='1' CELLPADDING='1' style='COLOR:sienna'>")
        Response.Write("<TR>")
        Response.Write("<TD ALIGN='middle'><FONT FACE='Arial' SIZE='14'>" + MyBase.GetResourceString("RESUME") + "</FONT></STRONG></TD>")
        Response.Write("</TR>")
        Response.Write("</TABLE>")
    End Sub 'Display title (Resume)
    Private Sub DisaplyEmployeeInformation()
        '=====================================================================
        ' Procedure Name        : DisplayEmployeeInformation()	
        ' Purpose               : To display Employee information 
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 12, 2004
        ' Revisions             :
        '======================================================================


        Dim drEmployee As IDataReader
        Dim strSQL As String
        strSQL = "Exec usp_tbl_Sel_EmployeeInfo " + m_intEmployeeID.ToString
        drEmployee = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        'Exit procedure if no employee found
        If Not drEmployee.Read Then Exit Sub

        'Heading - Personla Profile
        Response.Write("<P align=left><FONT face='Monotype Corsiva' size=5 color=sienna><STRONG><EM>" + MyBase.GetResourceString("PERSONALPROFILE") + "</EM></STRONG></FONT></P>")

        Response.Write("<TABLE class=clstable border=1 cellPadding=5 cellSpacing=2 width=100% style='BACKGROUND-COLOR: ivory; COLOR: sienna'>")

        'Name
        Response.Write("<TR>")
        Response.Write("<TD style='WIDTH: 25%' valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("NAME") + "</TD>")

        Response.Write("<TD style='WIDTH: 20px' align=middle valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")

        Response.Write("<TD valign=top style='PADDING-LEFT: 10px'>")
        Response.Write(drEmployee("EmployeeName").ToString)
        Response.Write("</TD>")
        Response.Write("</TR>")

        'Address
        Response.Write("<TR>")
        Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("Address") + "</TD>")
        Response.Write("<TD align=middle valign=middle><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
        Response.Write("<TD valign=top style='PADDING-LEFT: 10px'>")
        Response.Write(drEmployee("Address").ToString + "<BR>" + drEmployee("City").ToString + " - " + drEmployee("PinCode").ToString + "<BR>" + drEmployee("State").ToString + "<BR>" + drEmployee("Country").ToString + "<BR>")
        Response.Write("</TD>")
        Response.Write("</TR>")

        'Birth date
        Response.Write("<TR>")
        Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("BIRTHDATE") + "</TD>")
        Response.Write("<TD align=middle valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
        Response.Write("<TD valign=top style='PADDING-LEFT: 10px'>")

        If drEmployee("BirthDate").ToString.Trim <> "" Then
            Response.Write(FormatDateTime(CType(drEmployee("BirthDate"), Date), vbLongDate))
        Else
            Response.Write("-")
        End If
        Response.Write("</TD>")
        Response.Write("</TR>")

        'Phone number
        Response.Write("<TR>")
        Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("PHONE") + "</TD>")
        Response.Write("<TD align=middle valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
        Response.Write("<TD valign=top style='PADDING-LEFT: 10px'>")

        If drEmployee("Phone").ToString <> "" Then
            Response.Write(drEmployee("Phone").ToString)
        Else
            Response.Write("-")
        End If
        Response.Write("</TD>")
        Response.Write("</TR>")

        'Email
        Response.Write("<TR>")
        Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("EMAIL") + "</TD>")
        Response.Write("<TD align=middle valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
        Response.Write("<TD valign=top style='PADDING-LEFT: 10px'>")

        If drEmployee("EmailID").ToString <> "" Then
            Response.Write("<A href=mailto:" + drEmployee("EmailID").ToString + " <FONT face='Times New Roman' size=3>" + drEmployee("EmailID").ToString + "</FONT></A>")
        Else
            Response.Write("-")
        End If
        Response.Write("</TD>")
        Response.Write("</TR>")
        Response.Write("</TABLE>")

        CommonFunction.Data.DisposeDataReader(drEmployee)
    End Sub 'Display EMployee Information
    Private Sub DisplayQualification()
        '=====================================================================
        ' Procedure Name        : DisplayQualification()	
        ' Purpose               : To display employee qualifications
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 12, 2004
        ' Revisions             :
        '=====================================================================

        Dim drQualifications As IDataReader
        Response.Write("<P><FONT face='Monotype Corsiva' size=5 color=sienna><STRONG><EM>" + MyBase.GetResourceString("QUALIFICATIONS") + "</EM></STRONG></FONT></P>")
        Response.Write("<TABLE border=1 class=clstable cellPadding=5 cellSpacing=2 width=100% style='BACKGROUND-COLOR:ivory;COLOR:sienna'>")

        drQualifications = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmployeeQualificationMatrix NULL,NULL,NULL," + m_intEmployeeID.ToString, MyBase.UseSQL)
        If Not drQualifications.Read Then
            Response.Write("<TR>")
            Response.Write("<TD align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("NODATA") + "</TD>")
            Response.Write("</TABLE>")
            Exit Sub
        End If

        Response.Write("<TR>")

        Response.Write("<TD align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("QUALIFICATION") + "</TD>")
        Response.Write("<TD align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("UNIVERSITY") + "</TD>")

        Response.Write("<TD align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("PASSOUTYEAR") + "</TD>")

        Response.Write("<TD align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("GRADE") + "</TD>")
        Response.Write("<TD align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("PERCENTAGE") + "</TD>")
        Response.Write("</TR>")

        Do
            Response.Write("<TR>")
            Response.Write("<TD valign=top>")
            Response.Write("<B>" + Server.HtmlEncode(drQualifications("QualificationName").ToString.Trim) + "</B>")
            Response.Write("</TD>")

            Response.Write("<TD align=center valign=top>" + Server.HtmlEncode(drQualifications("University").ToString.Trim) + "</TD>")
            Response.Write("<TD align=center valign=top>" + Server.HtmlEncode(drQualifications("PassoutYear").ToString.Trim) + "</TD>")
            Response.Write("<TD align=center valign=top>" + Server.HtmlEncode(drQualifications("Class").ToString.Trim) + "</TD>")
            Response.Write("<TD align=center valign=top>")
            If drQualifications("Percentage").ToString.Trim <> "" Then
                Response.Write(Server.HtmlEncode(drQualifications("Percentage").ToString.Trim) + "%")
            Else
                Response.Write("-")
            End If

            Response.Write("</TD>")
            Response.Write("</TR>")
        Loop While drQualifications.Read

        Response.Write("</TABLE>")

        CommonFunction.Data.DisposeDataReader(drQualifications)
    End Sub ' Display qualifications of employee
    Private Sub DisplayCertifications()
        '=====================================================================
        ' Procedure Name        : DisplayCertifications()	
        ' Purpose               : To display employee certifications
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 12, 2004
        ' Revisions             :
        '=====================================================================

        Dim drCertifications As IDataReader

        Response.Write("<P><FONT face='Monotype Corsiva' size=5 color=sienna><STRONG><EM>" + MyBase.GetResourceString("CERTIFICATIONS") + "</EM></STRONG></FONT></P>")
        Response.Write("<TABLE border=1 class=clstable cellPadding=5 cellSpacing=2 width=100% style='BACKGROUND-COLOR:ivory;COLOR:sienna'>")


        drCertifications = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmployeeCertificationMatrix NULL,NULL,NULL," + m_intEmployeeID.ToString, MyBase.UseSQL)
        If Not drCertifications.Read Then
            Response.Write("<TR>")
            Response.Write("<TD align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("NODATA") + "</TD>")
            Response.Write("</TABLE>")
            Exit Sub
        End If

        Response.Write("<TR>")
        Response.Write("<TD align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("CERTIFICATION") + "</TD>")
        Response.Write("<TD align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("CERTIFICATIONDATE") + "</TD>")
        Response.Write("<TD align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("VALIDUPTO") + "</TD>")
        Response.Write("<TD align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("SCORE") + "</TD>")
        Response.Write("</TR>")

        Do
            Response.Write("<TR>")

            Response.Write("<TD valign=top><B>" + Server.HtmlEncode(drCertifications("CertificationName").ToString.Trim) + "</B></TD>")
            Response.Write("<TD align=center  valign=top>")
            If CommonFunction.Data.CheckIsDBNull(drCertifications("CertificationDate"), "").ToString <> "" Then
                Response.Write(CommonFunction.Dates.CGetDate(CType(drCertifications("CertificationDate"), Date)))
            Else
                Response.Write("&nbsp;")
            End If
            Response.Write("</TD>")

            Response.Write("<TD align=center valign=top>")
            If CommonFunction.Data.CheckIsDBNull(drCertifications("ValidUpto"), "").ToString() <> "" Then
                Response.Write(CommonFunction.Dates.CGetDate(CType(drCertifications("ValidUpto"), Date)))
            Else
                Response.Write(MyBase.GetResourceString("NA"))
            End If
            Response.Write("</TD>")

            Response.Write("<TD valign=top align=center>")
            If drCertifications("ActualScore").ToString.Trim <> "" Then
                Response.Write(drCertifications("ActualScore").ToString)
            End If

            If drCertifications("TotalScore").ToString.Trim <> "" Then
                Response.Write("/" + drCertifications("TotalScore").ToString.Trim)
            End If

            If drCertifications("ActualScore").ToString.Trim = "" And drCertifications("TotalScore").ToString.Trim = "" Then
                Response.Write("-")
            End If
            Response.Write("</TD>")
            Response.Write("</TR>")
        Loop While drCertifications.Read

        Response.Write("</table>")
        CommonFunction.Data.DisposeDataReader(drCertifications)
    End Sub ' Display employee certifications
    Private Sub DisplaySkillSets()
        '=====================================================================
        ' Procedure Name        : DisplaySkillSets()	
        ' Purpose               : To display employee skill sets
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 12, 2004
        ' Revisions             :
        '=====================================================================

        Dim drEmployeeSkills As IDataReader

        Response.Write("<P><FONT face='Monotype Corsiva' size=5 color=sienna><STRONG><EM>" + MyBase.GetResourceString("SKILLSETS") + "</EM></STRONG></FONT></P>")
        Response.Write("<TABLE border=1 class=clstable cellPadding=5 cellSpacing=2 width=100% style='BACKGROUND-COLOR:ivory;COLOR:sienna'>")

        drEmployeeSkills = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmployeeSkillMatrix NULL,NULL,NULL," + m_intEmployeeID.ToString, MyBase.UseSQL)
        If Not drEmployeeSkills.Read Then
            Response.Write("<TR>")
            Response.Write("<TD align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("NODATA") + "</TD>")
            Response.Write("</TABLE>")
            Exit Sub
        End If

        Response.Write("<TR>")
        Response.Write("<TD rowspan=2 align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("SKILL") + "</TD>")
        Response.Write("<TD colspan=2 align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("EXPERIENCE") + "</TD>")
        Response.Write("</TR>")
        Response.Write("<TR>")
        Response.Write("<TD style='WIDTH:15%' align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("YEARS") + "</TD>")
        Response.Write("<TD style='WIDTH:15%' align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("MONTHS") + "</TD>")
        Response.Write("</TR>")

        Do
            Response.Write("<TR>")
            Response.Write("<TD>")

            Response.Write("<B>" + Server.HtmlEncode(drEmployeeSkills("Tool").ToString.Trim) + "</B>")
            Response.Write("</TD>")
            Response.Write("<TD align=center>")
            If drEmployeeSkills("YearsOfExperience").ToString.Trim <> "" Then
                If drEmployeeSkills("YearsOfExperience").ToString.Trim = "0" Then
                    Response.Write("-")
                ElseIf drEmployeeSkills("YearsOfExperience").ToString.Trim = "1" Then
                    Response.Write(drEmployeeSkills("YearsOfExperience").ToString.Trim + MyBase.GetResourceString("YEAR"))
                Else
                    Response.Write(drEmployeeSkills("YearsOfExperience").ToString.Trim + MyBase.GetResourceString("YEARS"))
                End If
            Else
                Response.Write("-")
            End If
            Response.Write("</TD>")
            Response.Write("<TD align=center>")

            If drEmployeeSkills("MonthsOfExperience").ToString.Trim <> "" Then
                If drEmployeeSkills("MonthsOfExperience").ToString.Trim = "0" Then
                    Response.Write("-")
                ElseIf drEmployeeSkills("MonthsOfExperience").ToString.Trim = "1" Then
                    Response.Write(drEmployeeSkills("MonthsOfExperience").ToString.Trim + MyBase.GetResourceString("MONTH"))
                Else
                    Response.Write(drEmployeeSkills("MonthsOfExperience").ToString.Trim + MyBase.GetResourceString("MONTHS"))
                End If
            Else
                Response.Write("-")
            End If

            Response.Write("</TD>")
            Response.Write("</TR>")
        Loop While drEmployeeSkills.Read
        Response.Write("</TABLE>")

        CommonFunction.Data.DisposeDataReader(drEmployeeSkills)
    End Sub ' Display employee skillsets
    Private Sub DisplayPreviousAssignments()
        '=====================================================================
        ' Procedure Name        : DisplayPreviousAssignments()	
        ' Purpose               : To display previous work experiance of the employee
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 12, 2004
        ' Revisions             :
        '=====================================================================


        Dim drEmployeeHistory As IDataReader

        Response.Write("<P><FONT face='Monotype Corsiva' size=5 color=sienna><STRONG><EM>" + MyBase.GetResourceString("PREVIOUSASSIGNMENTS") + "</EM></STRONG></FONT></P>")
        Response.Write("<TABLE border=1 class=clstable cellPadding=5 cellSpacing=2 width=100% style='BACKGROUND-COLOR:ivory;COLOR:sienna'>")

        drEmployeeHistory = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmployeeHistory NULL,NULL," + m_intEmployeeID.ToString, MyBase.UseSQL)
        If Not drEmployeeHistory.Read Then
            Response.Write("<TR>")
            Response.Write("<TD align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("NODATA") + "</TD>")
            Response.Write("</TABLE>")
            Exit Sub
        End If

        Do
            Response.Write("<TR>")
            Response.Write("<TD>")
            Response.Write("<TABLE class=clstable cellPadding=5 cellSpacing=2 width=100% style='BACKGROUND-COLOR:ivory;COLOR:sienna'>")

            Response.Write("<TR>")
            Response.Write("<TD valign=top style='WIDTH:20%' align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("ORGANISATION") + "</TD>")
            Response.Write("<TD valign=top style='WIDTH:20px'><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>")

            Response.Write("<B>" + Server.HtmlEncode(drEmployeeHistory("OrganizationName").ToString.Trim) + "</B>")
            Response.Write("</TD>")
            Response.Write("</TR>")

            Response.Write("<TR>")
            Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("POSITION") + "</TD>")
            Response.Write("<TD valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>" + Server.HtmlEncode(drEmployeeHistory("PositionHeld").ToString.Trim) + "</TD>")
            Response.Write("</TR>")

            Response.Write("<TR>")
            Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("EXPERIENCE") + "</TD>")
            Response.Write("<TD valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>")

            If drEmployeeHistory("WorkedFrom").ToString.Trim <> "" Then
                Response.Write(MyBase.GetResourceString("FROM") + CommonFunction.Dates.CGetDate(CType(drEmployeeHistory("WorkedFrom"), Date)))
            End If

            If drEmployeeHistory("WorkedTill").ToString.Trim <> "" Then
                Response.Write(MyBase.GetResourceString("TO") + CommonFunction.Dates.CGetDate(CType(drEmployeeHistory("WorkedTill"), Date)))
            End If

            Response.Write("</TD>")
            Response.Write("</TR>")

            Response.Write("<TR>")
            Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("PROFILE") + "</TD>")
            Response.Write("<TD valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>" + Server.HtmlEncode(drEmployeeHistory("WorkProfileNature").ToString.Trim) + "</TD>")
            Response.Write("</TR>")
            Response.Write("</TABLE>")
            Response.Write("</TD>")
            Response.Write("</TR>")
        Loop While drEmployeeHistory.Read

        Response.Write("</TABLE>")

        CommonFunction.Data.DisposeDataReader(drEmployeeHistory)
    End Sub ' Display previous work experiance of the employee
    Private Sub DisplayCurrentAssignments()
        '=====================================================================
        ' Procedure Name        : DisplayCurrentAsignments()	
        ' Purpose               : To display the projects, employee has worked on and currently working on.
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 12, 2004
        ' Revisions             :
        '=====================================================================

        Dim drAssignments As IDataReader

        Response.Write("<P><FONT face='Monotype Corsiva' size=5 color=sienna><STRONG><EM>" + MyBase.GetResourceString("CURRENTASSIGNMENTS") + "</EM></STRONG></FONT></P>")
        Response.Write("<TABLE border=1 class=clstable cellPadding=5 cellSpacing=2 width=100% style='BACKGROUND-COLOR:ivory;COLOR:sienna'>")

        drAssignments = CommonFunction.Data.GetDataReader("Exec usp_sel_CurrentAssignmentsForEmployee " + m_intEmployeeID.ToString, MyBase.UseSQL)
        If Not drAssignments.Read Then
            Response.Write("<TR>")
            Response.Write("<TD align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("NODATA") + "</TD>")
            Response.Write("</TABLE>")
            Exit Sub
        End If

        Do
            Response.Write("<TR>")
            Response.Write("<TD>")
            Response.Write("<TABLE class=clstable cellPadding=5 cellSpacing=2 width=100% style='BACKGROUND-COLOR:ivory;COLOR:sienna'>")

            'Project Name
            Response.Write("<TR>")
            Response.Write("<TD valign=top style='WIDTH:20%' align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("PROJECTNAME") + "</TD>")
            Response.Write("<TD valign=top style='WIDTH:20px'><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>")

            Response.Write("<B>" + Server.HtmlEncode(drAssignments("ProjectName").ToString.Trim) + "</B>")
            Response.Write("</TD>")
            Response.Write("</TR>")

            'Description
            Response.Write("<TR>")
            Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("DESCRIPTION") + "</TD>")
            Response.Write("<TD valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>" + Server.HtmlEncode(drAssignments("Description").ToString.Trim) + "</TD>")
            Response.Write("</TR>")

            'Role
            Response.Write("<TR>")
            Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("ROLE") + "</TD>")
            Response.Write("<TD valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>")
            Response.Write(drAssignments("RoleDescription"))
            Response.Write("</TD>")
            Response.Write("</TR>")

            'Team Size
            Response.Write("<TR>")
            Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("TEAMSIZE") + "</TD>")
            Response.Write("<TD valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>" + drAssignments("TeamSize").ToString + "</TD>")
            Response.Write("</TR>")

            'From 
            Response.Write("<TR>")
            Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("FROM") + "</TD>")
            Response.Write("<TD valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            If CommonFunction.Data.CheckIsDBNull(drAssignments("ActualStartDate"), "").ToString <> "" Then
                Response.Write("<TD valign=top>" + CommonFunction.Dates.CGetDate(CType(drAssignments("ActualStartDate"), Date)) + "</TD>")
            Else
                Response.Write("<TD valign=top>&nbsp;</TD>")
            End If
            Response.Write("</TR>")

            'To
            Response.Write("<TR>")
            Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("TO") + "</TD>")
            Response.Write("<TD valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            If CommonFunction.Data.CheckIsDBNull(drAssignments("ActualEndDate"), "").ToString <> "" Then
                Response.Write("<TD valign=top>" + CommonFunction.Dates.CGetDate(CType(drAssignments("ActualEndDate"), Date)) + "</TD>")
            Else
                Response.Write("<TD valign=top>&nbsp;</TD>")
            End If
            Response.Write("</TR>")

            'Responsibility
            Response.Write("<TR>")
            Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("RESPONSIBILITY") + "</TD>")
            Response.Write("<TD valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>" + drAssignments("Responsibility").ToString + "</TD>")
            Response.Write("</TR>")

            'Assignment Status
            Response.Write("<TR>")
            Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("ASSIGNMENTSTATUS") + "</TD>")
            Response.Write("<TD valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>" + drAssignments("AssignmentStatus").ToString + "</TD>")
            Response.Write("</TR>")

            'Project Status
            Response.Write("<TR>")
            Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("PROJECTSTATUS") + "</TD>")
            Response.Write("<TD valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>" + drAssignments("ProjectStatus").ToString + "</TD>")
            Response.Write("</TR>")

            'Skills
            Response.Write("<TR>")
            Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("SKILLS") + "</TD>")
            Response.Write("<TD valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>" + drAssignments("Tools").ToString + "</TD>")
            Response.Write("</TR>")

            Response.Write("</TABLE>")
            Response.Write("</TD>")
            Response.Write("</TR>")
        Loop While drAssignments.Read

        'Added by PrashantSJ on 18th Nov 2005 for IVL 
        'Purpose: To Display the Previous Assignment Label accuratly
        Response.Write("</TABLE>")
        'End of Addition by PrashnatSJ on 18th Nov 2005 for IVL 

        CommonFunction.Data.DisposeDataReader(drAssignments)

    End Sub ' Display projects, employee has worked on and currently working on.
    Private Sub DisplayPreviousWorkAssignments()
        '=====================================================================
        ' Procedure Name        : DisplayPreviousWorkAssignments()	
        ' Purpose               : To display the Assignments, employee has worked on and currently working on.
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantSJ
        ' Created               : Nov 18, 2005
        ' Revisions             :
        '=====================================================================

        Dim drPrevWorkAssignments As IDataReader

        'Response.Write("<P><FONT face='Monotype Corsiva' size=5 color=sienna><STRONG><EM>" + MyBase.GetResourceString("PREVIOUSWORKASSIGNMENT") + "</EM></STRONG></FONT></P>")
        'Response.Write("<TABLE border=1 class=clstable cellPadding=5 cellSpacing=2 width=100% style='BACKGROUND-COLOR:ivory;COLOR:sienna'>")
        Response.Write("<P><FONT face='Monotype Corsiva' size=5 color=sienna><STRONG><EM>" + MyBase.GetResourceString("PREVIOUSWORKASSIGNMENT") + "</EM></STRONG></FONT></P>")
        Response.Write("<TABLE border=1 class=clstable cellPadding=5 cellSpacing=2 width=100% style='BACKGROUND-COLOR:ivory;COLOR:sienna'>")

        drPrevWorkAssignments = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmployeeHistory_Projects " + m_intEmployeeID.ToString, MyBase.UseSQL)
        If Not drPrevWorkAssignments.Read Then
            Response.Write("<TR>")
            Response.Write("<TD align=center class=clsTDColumnLabel>" + MyBase.GetResourceString("NODATA") + "</TD>")
            Response.Write("</TABLE>")
            Exit Sub
        End If

        Do
            Response.Write("<TR>")
            Response.Write("<TD>")
            Response.Write("<TABLE class=clstable cellPadding=5 cellSpacing=2 width=100% style='BACKGROUND-COLOR:ivory;COLOR:sienna'>")

            'Assignment Name
            Response.Write("<TR>")
            Response.Write("<TD valign=top style='WIDTH:20%' align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("ASSIGNMENTNAME") + "</TD>")
            Response.Write("<TD valign=top style='WIDTH:20px'><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>")

            Response.Write("<B>" + Server.HtmlEncode(drPrevWorkAssignments("ProjectName").ToString.Trim) + "</B>")
            Response.Write("</TD>")
            Response.Write("</TR>")

            'Description
            Response.Write("<TR>")
            Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("DESCRIPTION") + "</TD>")
            Response.Write("<TD valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>" + Server.HtmlEncode(drPrevWorkAssignments("Description").ToString.Trim) + "</TD>")
            Response.Write("</TR>")

            'Role
            Response.Write("<TR>")
            Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("ROLE") + "</TD>")
            Response.Write("<TD valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>")
            Response.Write(drPrevWorkAssignments("Role"))
            Response.Write("</TD>")
            Response.Write("</TR>")

            'Team Size
            Response.Write("<TR>")
            Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("TEAMSIZE") + "</TD>")
            Response.Write("<TD valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>" + drPrevWorkAssignments("TeamSize").ToString + "</TD>")
            Response.Write("</TR>")


            'Duration
            Response.Write("<TR>")
            Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("DURATION") + "</TD>")
            Response.Write("<TD valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>" + drPrevWorkAssignments("Duration").ToString + "</TD>")
            Response.Write("</TR>")

            'Environment
            Response.Write("<TR>")
            Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("ENVIRONMENT") + "</TD>")
            Response.Write("<TD valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>" + drPrevWorkAssignments("Environment").ToString + "</TD>")
            Response.Write("</TR>")


            'Skills
            Response.Write("<TR>")
            Response.Write("<TD valign=top align=left class=clsTDColumnLabel>" + MyBase.GetResourceString("SKILLS") + "</TD>")
            Response.Write("<TD valign=top><STRONG><FONT face=Georgia>:</FONT></STRONG></TD>")
            Response.Write("<TD valign=top>" + drPrevWorkAssignments("SkillSet").ToString + "</TD>")
            Response.Write("</TR>")

            Response.Write("</TABLE>")
            Response.Write("</TD>")
            Response.Write("</TR>")
        Loop While drPrevWorkAssignments.Read

        CommonFunction.Data.DisposeDataReader(drPrevWorkAssignments)

    End Sub


    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.HR_EmployeeResume", "AppResources")
    End Sub ' Constructor of page.

End Class
