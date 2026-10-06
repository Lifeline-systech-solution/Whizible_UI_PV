Public Class PRO_ProjectTypeConfiguration
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Page Name             : PRO_ProjectTypeConfiguration
    ' Purpose               : 3 Pages 
    ' Description           : 1. Configure SDLC
    '                         2. Configiure Phases
    '                         3. Edit/ AddNew Project Template page     
    ' Parameters Passed     : Mode = Add_New, Save 
    '                         Flag = SDLC, PHASE Or Empty string  -> denotes Project Template page
    ' Assumptions           : AppResources.PRO_ProjectTypeConfiguration Resource file exists
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : SuryabirD
    ' Created               : Feb 16th, 2004
    ' Revisions             : 
    '=====================================================================

    '------------ Module level variable declaration --------------
    Protected m_strPageTitle As String
    Protected m_lngProjectTypeID As Long = 0
    Protected m_lngProjectID As Long = 0
    Protected m_lngProcessID As Long = 0
    Protected m_lngActivityID As Long = 0
    Protected m_strMode As String   'SAVEPROCESS
    Protected m_strFlag As String
    Protected m_strAction As String
    Protected m_lngTagID As Long
    Protected m_strFromWhere As String
    Protected m_bln_ShowHistory As Boolean = False
    Protected m_objGlobal As WebPages.Template.IGlobal
    'Added By JyotiG
    'Start_JG_CR_7138_06-Nov-2006
    'Protected m_TagProjectType As Long = CommonFunction.Constants.APP_TAG_TAB_PROJECT_TYPE_HISTORY
    Protected m_strUserName As String
    'End_JG_CR_7138_06-Nov-2006

    '-- Constants
    Private CONST_PRO_SDLC As String = "SDLC"
    Private CONST_PRO_PHASE As String = "PHASE"
    Private CONST_PRO_ACTIVITY As String = "ACTIVITY"

    Private m_blnUseSQL As Boolean
    Private m_blnAddAccess, m_blnDeleteAccess, m_blnEditAccess As Boolean
    Private strPMI As String
    Private blnProjectCreationworkflow As Boolean

    'Added By NitinC on 18 May 2011 for WhizibleSEM 10.0 Agile Methodology
    Private blnIsAgileMethodON As Boolean
    'End Added By NitinC on 18 May 2011 for WhizibleSEM 10.0 Agile Methodology

    Private WithEvents m_objGrid As New WebPage.Templates.GenericGrid

    '------------- Variable declaration ends ---------------------

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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Put user code to initialize the page here
        '-- The Project Type For the Page is Stored in Hidden variable 
        '-- else the Type id is passed thru' Query String 
        m_lngProjectTypeID = CType(Request("txtProjectTypeID"), Long)
        If m_lngProjectTypeID = 0 Then m_lngProjectTypeID = CType(Request.QueryString("TypeID"), Long)
        m_strFlag = Trim(Request.QueryString("Flag") + "")
        m_lngProcessID = CType(Request.QueryString("ProcessID"), Long)
        m_strMode = Request.QueryString("Mode")
        strPMI = Request.QueryString("PMIID")
        m_lngTagID = CType(Request.QueryString("MasterTagID"), Long)
        m_lngProjectID = CType(Session("intProjectID"), Long)
        m_strFromWhere = Request.QueryString("FromWhere")
        'Start_JG_07-Nov-2006
        m_strUserName = Session("strUserName").ToString
        'End_JG_07-Nov-2006
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        Call CreateGlobalObject()
        MyBase.InitializeResources("AppResources.PRO_ProjectTypeConfiguration", "AppResources")

        Select Case m_strFlag
            Case CONST_PRO_SDLC
                m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE_SDLC")

            Case CONST_PRO_PHASE
                m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE_PHASE")

            Case CONST_PRO_ACTIVITY
                m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE_ACTIVITY")

            Case Else
                m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE_TEMPLATE")

        End Select

    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name		:	PageInit
        ' Parameters Passed		:	None
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To draw all controls on the page
        ' Description			:	This is main procedure on this page which actually draw the page with its 
        '                           controls on it. This procedure is called from the HTML body tag of the page.
        '                           this procedure gives the call to other procedures and functions in the class.
        ' Assumptions			:	AppResources.PRO_ProjectTypeConfiguration exists
        ' Dependencies			:	None
        ' Author				:	SuryabirD
        ' Created				:	Feb 13 2004
        ' Revisions				:	
        '=====================================================================
        Dim strSQL, strQueryForGrid As String
        Dim strProcess() As String
        Dim strActivity() As String
        Dim intCount As Integer = 0
        Dim fltPercentageEforts, fltOrderNumber As Double
        Dim strMenu As String
        Dim drTemp As IDataReader
        Dim strType, strPMI As String
        Dim strTypeID As String
        Dim drCheck, drProjectTypes As IDataReader
        Dim strProjectType As String
        Dim strSQLQuery, strGrid As String
        Dim intProjectTypeID As Integer
        'added by SachinR   on 16 Sep 2004
        Dim strOUPoolID As String
        Dim strProjectTypeID As String
        'addition end
        'Added by ShamkantD on 4 Oct 2004
        Dim strIsProjectCreationWorkflowReqd As String = "0"
        'End of addition - ShamkantD on 4 Oct 2004
        'Added By JyotiG
        'Start_JG_CR_7187_06-Nov-2006
        Dim strIsActive As String = "1"
        'End_JG_CR_7187_06-Nov-2006

        'Added By NitinC on 18 May 2011 for WhizibleSEM 10.0 Agile Methodology
        Dim strIsAgileMethodFollowed As String = "0"
        'END Added By NitinC on 18 May 2011 for WhizibleSEM 10.0 Agile Methodology

        'Integrated by PrashantD on 1 March 2007 for Product Execution Project
        '' Added By ParagD On 20-May-2006            
        Dim strIsProductExecutionProject As String = "0"
        '' END : Added By ParagD On 20-May-2006
        'End of addition by PrashantD on 1 March 2007


        Select Case m_strFlag
            Case ""
                '========================= Project Template ============================
                '--- SAVE MODE --
                If (m_strMode = "SAVE") Then

                    If (Request("cboPMI") <> "") Then
                        strPMI = MyBase.FixString(MyBase.GetFormValue("cboPMI"), 0, True, True) 'Request("cboPMI")
                    Else
                        strPMI = "NULL"
                    End If

                    If (Request("txtProjectType") <> "") Then
                        strProjectType = MyBase.FixString(MyBase.GetFormValue("txtProjectType"), 100, False, True)   'Request("txtProjectTypeID")
                    Else
                        strProjectType = "NULL"
                    End If
                    strProjectType = strProjectType.Trim
                    strTypeID = Request("txtProjectTypeID")

                    'added by SachinR   on 16 Sep 2004
                    strOUPoolID = MyBase.GetFormValue("cboOUPool") + ""
                    strProjectTypeID = MyBase.GetFormValue("cboProjectType") + ""
                    'Commented And Added By Usha Pandit On 17.12.2020 For getting project type id
                    'strSQL = "EXEC usp_ins_ProjectType_Config " + m_lngProjectTypeID.ToString + "," + strPMI + ",'"
                    strSQL = "EXEC usp_ins_ProjectType_PracticeConfig " + m_lngProjectTypeID.ToString + "," + strPMI + ",'"
                    'End Of Added By Usha Pandit On 17.12.2020 For getting project type id
                    strSQL = strSQL + strProjectType + "'"
                    'added by SachinR   on 16 Sep 2004
                    If strProjectTypeID <> "" Then
                        strSQL += "," + strProjectTypeID.Trim
                    Else
                        strSQL += ",NULL"
                    End If
                    If strOUPoolID <> "" Then
                        strSQL += "," + strOUPoolID.Trim
                        'Modified by HarshK for sp4 issueid 149 on 11/10/2005
                    Else
                        strSQL += "," + "NULL"
                        'End Modified by HarshK for sp4 issueid 149 on 11/10/2005
                    End If
                    'addition end

                    'Added by ShamkantD on 4 Oct 2004
                    If CommonFunction.General.CheckIsNothing(Request("chkIsProjectCreationWorkflowReqd"), "").ToString().Trim() <> "" Then
                        strIsProjectCreationWorkflowReqd = "1"
                    Else
                        strIsProjectCreationWorkflowReqd = "NULL"
                    End If

                    If strIsProjectCreationWorkflowReqd <> "" Then
                        strSQL += "," + strIsProjectCreationWorkflowReqd.Trim
                    End If
                    'End of addition - ShamkantD on 4 Oct 2004
                    'Added By JyotiG
                    'Start_JG_CR_7187_06-Nov-2006
                    If CommonFunction.General.CheckIsNothing(Request("chkIsActive"), "").ToString().Trim() <> "" Then
                        strIsActive = "1"
                    Else
                        strIsActive = "0"
                    End If
                    If strIsActive <> "" Then
                        strSQL += "," + strIsActive.Trim
                    End If
                    If m_strUserName <> "" Then
                        'Commented & modified by AmitJ  For LGCNS IssueId 5348 => Page Crashes While deactivating process 
                        ' if username contains "." or "'"(for e.g Amol.Nikam OR Ashish'R) page crashes while activating/deactivating the process.
                        'strSQL += "," + m_strUserName.Trim 
                        strSQL += ",'" + Replace(m_strUserName.Trim, "'", "''") + "'"
                        'End of modifications By AmitJ
                    Else
                        strSQL += ",NULL"
                    End If
                    'End_JG_CR_7187_06-Nov-2006

                    'Added By NitinC on 18 May 2011 for WhizibleSEM 10.0 Agile Methodology
                    If CommonFunction.General.CheckIsNothing(Request("chkIsAgileMethodFollowed"), "").ToString().Trim() <> "" Then
                        strIsAgileMethodFollowed = "1"
                    ElseIf Request.QueryString("IsAgile").ToString().Trim() <> "0" Then
                        strIsAgileMethodFollowed = "1"
                    Else
                        strIsAgileMethodFollowed = "0"
                    End If

                    If strIsAgileMethodFollowed <> "" Then
                        strSQL += "," + strIsAgileMethodFollowed.Trim
                    End If
                    'End Added By NitinC on 18 May 2011 for WhizibleSEM 10.0 Agile Methodology


                    'Integrated by PrashantD on 1 March 2007 for Product Execution Project
                    '' Added By ParagD On 20-May-2006
                    If CommonFunction.General.CheckIsNothing(Request("chkIsProductExecutionProject"), "").ToString().Trim() <> "" Then
                        strIsProductExecutionProject = "1"
                    Else
                        strIsProductExecutionProject = "0"
                    End If

                    If strIsProductExecutionProject <> "" Then
                        strSQL += "," + strIsProductExecutionProject.Trim
                    End If
                    '' END : Added By ParagD On 20-May-2006
                    'End of addition by PrashantD on 1 March 2007

                    'Commented And Added By Usha Pandit On 17.12.2020 For getting project type id
                    'CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                    m_lngProjectTypeID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))), Long)
                    'End Of Added By Usha Pandit On 17.12.2020 For getting project type id

                    'Commented By NitinVS on 15 May 2007 as Discussed with satchit sir
                    ' Field configuration at practice not to be released.

                    ''Integrated by PrashantD on 1 March 2007 for Product Execution Project
                    ''Code Added By PradipK on 26 May 2006 for Project Configuratioan at Practice Level
                    'Dim TypeID As String
                    'strSQL = "SELECT IsNULL(TypeID,0)   FROM tbl_PRS_Projecttypes WHERE ProjectType='" + strProjectType + "'"

                    'TypeID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))), String)

                    'If TypeID <> "0" Then
                    '    CommonEngine.HashTables.ProjectInfo.CreateProjectInfoHashTable(CType(TypeID, Long))
                    'End If

                    ''  CommonEngine.HashTables.ProjectInfo.CreateProjectInfoHashTable()
                    ''End Addition By PradipK  on 26 May 2006
                    ''End of addition by PrashantD on 1 March 2007

                    ' End commenting by  NitinVS on 15 May 2007 as Discussed with satchit sir

                    '-- Go Back to the Main Common List Page
                    ''Commented By Usha Pandit For preventing to go to list page on save
                    'Response.Redirect("../General/CommonList.aspx?FromWhere=PRO&MasterTagId=1037")
                    ''End Of Commented By Usha Pandit For preventing to go to list page on save
                Else
                    m_strMode = "ADD_NEW"
                End If

                '-- END Of Save Mode --

                If (m_strMode = "ADD_NEW") Then

                    'If m_lngProjectTypeID = 0 Then m_lngProjectTypeID = CType(Request.Form("cboPMI"), Long)
                    If (Trim(Request.QueryString("TypeID") + "") <> "") Then
                        'intProjectTypeID = Request("ProjectTypeID")

                        strSQL = "EXEC usp_sel_ProjectTypeRelated_Informaion 3," & m_lngProjectTypeID & ",NULL"
                        drCheck = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

                        If (drCheck.Read) Then
                            strProjectType = drCheck("ProjectType").ToString + ""
                            strPMI = drCheck("PMIID").ToString
                            'added by SachinR   on  16 Sep 2004
                            strOUPoolID = CommonFunction.Data.CheckIsDBNull(drCheck("OUPoolID"), "").ToString
                            strProjectTypeID = CommonFunction.Data.CheckIsDBNull(drCheck("ProjectTypeID"), "").ToString
                            'addition end
                            'Added by ShamkantD on 4 Oct 2004
                            If CType(CommonFunction.Data.CheckIsDBNull(drCheck("IsProjectCreationWorkflowReqd"), "False"), Boolean) = True Then
                                strIsProjectCreationWorkflowReqd = "1"
                            Else
                                strIsProjectCreationWorkflowReqd = "0"
                            End If
                            'End of addition - ShamkantD on 4 Oct 2004
                            'Added By JyotiG
                            'Start_JG_CR_7187_06-Nov-2006
                            If CType(CommonFunction.Data.CheckIsDBNull(drCheck("IsActive"), "False"), Boolean) = True Then
                                strIsActive = "1"
                            Else
                                strIsActive = "0"
                            End If
                            'End_JG_CR_7187_06-Nov-2006

                            'Added by NitinC on 18 May 2011 for WhizibleSEM 10.0 Agile Method
                            If CType(CommonFunction.Data.CheckIsDBNull(drCheck("IsAgileMethodFollowed"), "False"), Boolean) = True Then
                                strIsAgileMethodFollowed = "1"
                            Else
                                strIsAgileMethodFollowed = "0"
                            End If
                            'End Added by NitinC on 18 May 2011 for WhizibleSEM 10.0 Agile Method


                            'Integrated by PrashantD on 1 March 2007 for Product Execution Project
                            '' Added By ParagD On 20-May-2006
                            If CType(CommonFunction.Data.CheckIsDBNull(drCheck("IsProductExecutionProject"), "False"), Boolean) = True Then
                                strIsProductExecutionProject = "1"
                            Else
                                strIsProductExecutionProject = "0"
                            End If
                            '' END : Added By ParagD On 20-May-2006
                            'End of addition by PrashantD on 1 March 2007

                        Else
                            strProjectType = ""
                            strPMI = ""
                            strOUPoolID = ""
                            strProjectTypeID = ""
                            'Added by ShamkantD on 4 Oct 2004
                            strIsProjectCreationWorkflowReqd = "0"
                            'Start_JG_CR_7187_06-Nov-2006
                            strIsActive = "1"
                            'End_JG_CR_7187_06-Nov-2006
                            'End of addition - ShamkantD on 4 Oct 2004

                            'Added by NitinC on 18 May 2011 for WhizibleSEM 10.0 Agile Method
                            strIsAgileMethodFollowed = "1"
                            'End Added by NitinC on 18 May 2011 for WhizibleSEM 10.0 Agile Method

                            'Integrated by PrashantD on 1 March 2007 for Product Execution Project
                            '' Added By ParagD On 20-May-2006
                            strIsProductExecutionProject = "0"
                            '' END : Added By ParagD On 20-May-2006
                            'End of addition by PrashantD on 1 March 2007
                        End If

                        CommonFunctions.Data.DisposeDataReader(drCheck)

                    Else
                        strPMI = Trim(Request("PMIID") + "")
                        'strProjectType = MyBase.FixString(MyBase.GetFormValue("txtProjectType"), 100, False, False)
                        strProjectType = Trim(Request.Form("txtProjectType") + "")
                        intProjectTypeID = CType(Request("txtProjectTypeID"), Integer)

                        strOUPoolID = MyBase.GetFormValue("cboOUPool") + ""
                        strProjectTypeID = MyBase.GetFormValue("cboProjectType") + ""

                        'Added by ShamkantD on 4 Oct 2004
                        If CommonFunction.General.CheckIsNothing(Request.Form("chkIsProjectCreationWorkflowReqd"), "").ToString().Trim() <> "" Then
                            strIsProjectCreationWorkflowReqd = "1"
                        Else
                            strIsProjectCreationWorkflowReqd = "0"
                        End If
                        'End of addition - ShamkantD on 4 Oct 2004
                        'Added By JyotiG
                        'Start_JG_CR_7187_06-Nov-2006
                        If CommonFunction.General.CheckIsNothing(Request.Form("chkIsActive"), "").ToString.Trim() = "" Then
                            strIsActive = "1"
                        End If
                        'End_JG_CR_7187_06-Nov-2006

                        'Added by NitinC on 18 May 2011 for WhizibleSEM 10.0 Agile Method
                        If CommonFunction.General.CheckIsNothing(Request.Form("chkIsAgileMethodFollowed"), "").ToString().Trim() <> "" Then
                            strIsAgileMethodFollowed = "1"
                        Else
                            strIsAgileMethodFollowed = "0"
                        End If
                        'End Added by NitinC on 18 May 2011 for WhizibleSEM 10.0 Agile Method

                        'Integrated by PrashantD on 1 March 2007 for Product Execution Project
                        '' Added By ParagD On 20-May-2006
                        If CommonFunction.General.CheckIsNothing(Request.Form("chkIsProductExecutionProject"), "").ToString().Trim() <> "" Then
                            strIsProductExecutionProject = "1"
                        Else
                            strIsProductExecutionProject = "0"
                        End If
                        '' END : Added By ParagD On 20-May-2006    
                        'End of addition by PrashantD on 1 March 2007

                    End If

                    Dim strClientSideScript As String
                    intCount = 0

                    ' Get all the sections created for the current checklist. (This list will be used to avoid duplication of sections.)				
                    strSQLQuery = "EXEC usp_sel_ProjectTypeRelated_Informaion 4,NULL,NULL"
                    drProjectTypes = CommonFunctions.Data.GetDataReader(strSQLQuery, m_blnUseSQL)
                    Do While drProjectTypes.Read
                        If CType(drProjectTypes("TypeID"), Integer) <> m_lngProjectTypeID Then
                            strClientSideScript = strClientSideScript + "strProjectTypeArray[" + intCount.ToString + "] = """ + Replace(Trim(drProjectTypes("ProjectType").ToString + ""), """", "\""") + """;" + vbCrLf
                            intCount = intCount + 1
                        End If

                    Loop

                    CommonFunctions.Data.DisposeDataReader(drProjectTypes)

                    Response.Write("<script LANGUAGE=javascript>" + vbCrLf)
                    Response.Write("var strProjectTypeArray;")
                    Response.Write("strProjectTypeArray = new Array(" + intCount.ToString + ");" + vbCrLf)
                    Response.Write(strClientSideScript + vbCrLf)
                    Response.Write("</script>")

                End If

                strMenu = DrawMenu()
                Response.Write(strMenu)

                MyBase.InitializeResources("AppResources.PRO_ProjectTypeConfiguration", "AppResources")

                '-- Page Legend : (* Mandatory)
                Dim arrLegend() As String = {MyBase.GetResourceString("MANDATORY")}
                Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}
                Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend) + vbCrLf)

                '-- Page Caption
                CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(m_objGlobal, , , , True))
                Response.Write("<BR>")

                Response.Write("<DIV ID=divList Style='WIDTH:100%;OVERFLOW:auto'>")


                '--1st Table: Project template
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                Response.Write("<TABLE class=clsTable width=99.9% border=0 cellPadding=0 cellSpacing = 0>")
                'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                Response.Write("<TR class=clsTREven >")
                Response.Write("<TD align=right>")
                Response.Write(MyBase.GetResourceString("PRACTICE"))
                Response.Write("</TD><TD align=Left >")
                'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                'CommonFunctions.HTMLControls.DrawTextBox("txtProjectType", "txtProjectType", , 200, 100, Server.HtmlEncode(strProjectType), , , , , , , , , True)
                ''-- hidden variable to store the Project Type ID    
                'CommonFunctions.HTMLControls.DrawTextBox("txtProjectTypeID", "txtProjectTypeID", , , , m_lngProjectTypeID.ToString, , , , , , True)
                CommonFunctions.HTMLControls.DrawTextBox("txtProjectType", "txtProjectType", , 200, 100, Server.HtmlEncode(strProjectType), , , , , , , , , True, EnableHTMLEncode:=True)
                '-- hidden variable to store the Project Type ID    
                CommonFunctions.HTMLControls.DrawTextBox("txtProjectTypeID", "txtProjectTypeID", , , , m_lngProjectTypeID.ToString, , , , , , True, EnableHTMLEncode:=True)
                'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                Response.Write("</TD></TR>")
                CommonFunctions.General.WriteHTML("<SCRIPT language=javascript>")
                CommonFunctions.General.WriteHTML("var objTextbox = GetObjectReference('frmProjectType','txtProjectType');")
                CommonFunctions.General.WriteHTML("objTextbox.focus();")
                CommonFunctions.General.WriteHTML("</SCRIPT>")

                'added by SachinR   on 16 Sep 2004
                Response.Write("<TR class=clsTREven >")
                Response.Write("<TD align=right>")
                Response.Write(MyBase.GetResourceString("OUPOOL"))
                Response.Write("</TD><TD align=Left >")
                'modified by SachinR   on 28 Oct 2004
                'To remove the mandatory rule for OUPool, previous line is commented 
                'CommonFunctions.HTMLControls.DrawComboBox("cboOUPool", "usp_Sel_tbl_PM_Location", 200, strOUPoolID.Trim, "onchange='javascript:OU_OnChange()'", True, , , True)
                CommonFunctions.HTMLControls.DrawComboBox("cboOUPool", "usp_Sel_tbl_PM_Location", 200, strOUPoolID.Trim, , True)
                Response.Write("</TD></TR>")
                'addition end

                Response.Write("<TR class=clsTREven >")
                Response.Write("<TD align=right>")
                Response.Write(MyBase.GetResourceString("PROJECT_PMI"))
                Response.Write("</TD><TD align=Left >")
                'Modified by SachinR    on 02 Nov 2004
                'removed the mapping of OU and PMI
                'CommonFunctions.HTMLControls.DrawComboBox("cboPMI", "usp_Sel_tbl_PRS_PMIMaster_ForOUPoolID " + strOUPoolID.Trim, 200, strPMI, " OnChange='PMI_Changed()'", True, , , True)
                CommonFunctions.HTMLControls.DrawComboBox("cboPMI", "usp_Sel_tbl_PRS_PMIMaster_ForOUPoolID ", 200, strPMI, " OnChange='PMI_Changed()'", True, , , True)
                'Modification end   on 02 Nov 2004
                Response.Write("</TD></TR>")

                'added by SachinR   on 16 Sep 2004
                Response.Write("<TR class=clsTREven >")
                Response.Write("<TD align=right>")

                'code commented and added by harshada d on 30 th may 2005 for NUCLEUS WSEM ISSUE ID : 18365
                'Response.Write(MyBase.GetResourceString("PRACTICE"))
                Response.Write(MyBase.GetResourceString("Project_Type"))
                ' end of addition by harshada d on 30 th may 2005)


                Response.Write("</TD><TD align=Left >")
                CommonFunctions.HTMLControls.DrawComboBox("cboProjectType", "usp_Sel_tbl_PRS_Main_ProjectType", 200, strProjectTypeID.Trim, , True, , , True)
                Response.Write("</TD></TR>")
                'addition end

                'Code Added By VidyaJ on 25th Nov 2004
                'Display this checkbox only if project creation workflow is enabled
                blnProjectCreationworkflow = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("select IsProjectCreationworkflowReqd from tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))), Boolean)
                'Intigrated by HarshK on 02/09/2005 for SP4 IssueID 149
                'Added By PradeepD for 20663 on 17-Aug-2005
                If m_lngProjectTypeID <> 0 Then
                    strIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("select IsNull(IsProjectCreationworkflowReqd,0) from tbl_PRS_ProjectTypes WHERE TYPEID = " & m_lngProjectTypeID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))), String)
                    'Added By JyotiG
                    'Start_JG_CR_7187_06-Nov-2006
                    ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                    ''strIsActive = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("select IsNull(IsActive,1) from tbl_PRS_ProjectTypes WHERE TYPEID = " & m_lngProjectTypeID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))), String)
                    strIsActive = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PRS_ProjectTypes_IsActive " & m_lngProjectTypeID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))), String)

                    'End_JG_CR_7187_06-Nov-2006
                End If
                'END: Added By PradeepD for 20663 on 17-Aug-2005

                'end intigration
                '<Summary>
                ' Commented by PrashantSJ on 19th June 2008
                ' Purpose: Don't need this setting.
                ' Product Version: WhizibleSEM 8.0
                ' </Summary>
                If blnProjectCreationworkflow = True Then
                    'Added by ShamkantD on 4 Oct 2004
                    Response.Write("<TR class=clsTREven >")
                    Response.Write("<TD align=right>")
                    Response.Write(MyBase.GetResourceString("IS_PROJECT_CREATION_WORKFLOW_REQD"))
                    Response.Write("</TD><TD align=Left >")

                    'Added by ShamkantD on 30 Nov 2004
                    Dim intProjectsBeingApproved As Integer = 0
                    Dim blnDisableProjWorkFlowCheckBox As Boolean = False

                    'Determine the number of projects that are sent for approval or are rejected.
                    ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                    ''intProjectsBeingApproved = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT COUNT(*) AS ProjectsBeingApproved FROM tbl_PM_ProjectRevision WHERE ProjectTypeID = " & m_lngProjectTypeID & " AND BaselineStatus IN ('S', 'R')", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)
                    intProjectsBeingApproved = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_ProjectRevision_ProjectsBeingApproved " & m_lngProjectTypeID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Integer)

                    If intProjectsBeingApproved > 0 Then
                        blnDisableProjWorkFlowCheckBox = True
                    Else
                        blnDisableProjWorkFlowCheckBox = False
                    End If

                    CommonFunctions.HTMLControls.DrawCheckBox("chkIsProjectCreationWorkflowReqd", "chkIsProjectCreationWorkflowReqd", , CType(strIsProjectCreationWorkflowReqd, Boolean), m_lngProjectTypeID.ToString(), blnDisableProjWorkFlowCheckBox)
                    'End of addition - ShamkantD on 30 Nov 2004

                    Response.Write("</TD></TR>")
                    'End of addition - ShamkantD on 4 Oct 2004
                End If
                ''End of addition by PrashanSJ on 19th June 2008

                'Added By JyotiG
                'Start_JG_CR_7187_06-Nov-2006


                'Added by PrashantD on 2 March 2007 
                'Pupose: hiding "Is Product Execution Project" checkbox if EnableProductExecution in companyInformation is not checked
                Dim blnEnableProductExecution_corpo As Boolean
                ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                ''blnEnableProductExecution_corpo = CType(CommonFunction.Data.GetDataScalar("SELECT ISNULL(EnableProductExecution,0) FROM tbl_PM_CompanyInformation", MyBase.UseSQL), Boolean)
                blnEnableProductExecution_corpo = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_EnableProductExecution", MyBase.UseSQL), Boolean)

                If blnEnableProductExecution_corpo = True Then
                    'End of addition by PrashantD on 2 March 2007
                    'Integrated by PrashantD on 1 March 2007 for Product Execution Project
                    '' Added By ParagD On 20-May-2006
                    Dim strCheck_ProductConfiguration_For_Practise As String
                    'Modified by ArchanaN on 11 Jun 2007 for Regression testing IssueID = 13331
                    ' Pupose : If any check box of Support Project or Product Engg. Project in Configuration Setting of Project Setting 
                    'is checked(For corresponding practise) then disable check box of "Is Product Execution Project" in practise
                    'strCheck_ProductConfiguration_For_Practise = CStr(CommonFunction.Data.GetDataScalar("usp_Check_ProductConfigurationFor_Practise " + m_lngProjectTypeID.ToString(), True))
                    strCheck_ProductConfiguration_For_Practise = CStr(CommonFunction.Data.GetDataScalar("usp_Check_ProductConfigurationFor_Practise " + m_lngProjectID.ToString(), True))
                    'End by ArchanaN
                    Response.Write("<TR class=clsTREven >")
                    Response.Write("<TD align=right>")
                    ''Response.Write(MyBase.GetResourceString("IS_PROJECT_CREATION_WORKFLOW_REQD"))
                    Response.Write(MyBase.GetResourceString("CAP_PRODUCT_EXECUTION"))
                    Response.Write("</TD><TD align=Left >")

                    If strCheck_ProductConfiguration_For_Practise = "1" Then
                        CommonFunctions.HTMLControls.DrawCheckBox("chkIsProductExecutionProject", "chkIsProductExecutionProject", , CType(strIsProductExecutionProject, Boolean), m_lngProjectTypeID.ToString(), True)
                    Else
                        CommonFunctions.HTMLControls.DrawCheckBox("chkIsProductExecutionProject", "chkIsProductExecutionProject", , CType(strIsProductExecutionProject, Boolean), m_lngProjectTypeID.ToString(), False)
                    End If
                    Response.Write("</TD></TR>")

                End If

                Response.Write("<TR class=clsTREven >")
                Response.Write("<TD align=right>")
                Response.Write("Is Active")
                Response.Write("</TD><TD align=Left >")
                CommonFunctions.HTMLControls.DrawCheckBox("chkIsActive", "chkIsActive", , CType(strIsActive, Boolean), m_lngProjectTypeID.ToString())
                'End_JG_CR_7187_06-Nov-2006
                Response.Write("</TD></TR>")

                'Added By NitinC on 18 May 2011 for WhizibleSEM 10.0 Agile Methodology
                'blnIsAgileMethodON = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("select IsAgileMethodOn from tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))), Boolean)

                'If blnIsAgileMethodON = True Then
                Response.Write("<TR class=clsTREven >")
                Response.Write("<TD align=right>")
                Response.Write("Is Agile Methodology Followed?")
                Response.Write("</TD><TD align=Left >")
                'Added By NitinC on 30 Nov 2011 for WhizibleSEM 11.0 Issue ID 56402
                Dim strValQuary As String
                Dim ValFlag As String

                strValQuary = "IF exists(SELECT 1 FROM tbl_PM_Project WHERE ProjectTypeID = " + m_lngProjectTypeID.ToString() + ") "
                strValQuary += "Select 1 "
                strValQuary += "ELSE "
                strValQuary += "SELECT 0 "
                ValFlag = CType(CommonFunctions.Data.GetDataScalar(strValQuary, MyBase.UseSQL), String)
                If ValFlag = "1" Then
                    CommonFunctions.HTMLControls.DrawCheckBox("chkIsAgileMethodFollowed", "chkIsAgileMethodFollowed", , CType(strIsAgileMethodFollowed, Boolean), m_lngProjectTypeID.ToString(), True)
                Else
                    CommonFunctions.HTMLControls.DrawCheckBox("chkIsAgileMethodFollowed", "chkIsAgileMethodFollowed", , CType(strIsAgileMethodFollowed, Boolean), m_lngProjectTypeID.ToString())
                End If
                Response.Write("</TD></TR>")
                'End If
                'End Added By NitinC on 18 May 2011 for WhizibleSEM 10.0 Agile Methodology

                'Added by PrashantD on 2 March 2007 
                'Pupose: hiding note if EnableProductExecution in companyInformation is not checked
                If blnEnableProductExecution_corpo = True Then
                    Response.Write("<TR class=clsTREven >")
                    Response.Write("<TD colspan=2>")
                    Response.Write(MyBase.GetResourceString("CAP_PRODUCT_EXECUTION_NOTE") + " </TD> </TR>")
                End If
                'End of addition by PrashantD on 2 March 2007
                '' END : Added By ParagD On 20-May-2006

                Response.Write("</TABLE>")
                Response.Write("<BR>")

                '--2. PMI Information
                If (strPMI <> "") Then
                    'Response.Write("<TABLE class=clsTable><TR class=clsTROdd><TD>")
                    CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PMI_INFO"), , , True))
                    Response.Write("<BR>")

                    '-- Vertical Grid for Other Information about PMI
                    strSQL = "EXEC usp_Sel_PMI_OtherInfo " & strPMI

                    Dim arrstrActualList() As String = {"Name", "description", "Notes", "Active"}
                    Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("PMI_NAME"), MyBase.GetResourceString("PMI_DESC"), MyBase.GetResourceString("PMI_NOTES"), MyBase.GetResourceString("PMI_ACTIVE")}
                    Dim arrstrTDStyle() As String = {" width='20%' align=Left ", " align=Left ", " align=Left ", " align=Left "}
                    Dim objGrid As New WebPage.Templates.GenericGrid
                    'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                    Dim arrIgnoreHtml() As String = {"0"}
                    'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

                    With objGrid
                        .ActualColumnArray = arrstrActualList
                        .UserFriendlyColumnArray = arrstrUserFriendlyList
                        .TDStyleArray = arrstrTDStyle
                        .NoOfDataColumns = 4
                        .DIVHeight = 0
                        .ColumnHeaderAlignment = "right"
                        .VerticalDisplay = True
                        .UseSQL = m_blnUseSQL
                        .returnHTML = True
                        .SQL = strSQL
                        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                        .IgnoreHTMLEncode = arrIgnoreHtml
                        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                        strGrid = .DrawGrid()
                    End With
                    objGrid = Nothing
                    Response.Write(strGrid)

                    Response.Write("<br>")

                    '-- 3. Data Grid for Metric Details
                    'Response.Write("<TABLE class=clsTable><TR class=clsTROdd><TD>")

                    'objGrid = New WebPage.Templates.GenericGrid
                    Dim arrstrActualList_Det() As String = {"CategoryName", "Name", "UCL", "LCL", "STATUS"}
                    Dim arrstrUserFriendlyList_Det() As String = {"", MyBase.GetResourceString("METRICS"), MyBase.GetResourceString("UCL"), MyBase.GetResourceString("LCL"), MyBase.GetResourceString("STATUS")}
                    Dim arrstrTDStyle_Det() As String = {" width='1%'", " width='40%' align=Left ", " align=center ", " align=center ", " align=Left "}
                    Dim arrGroupField() As String = {"1"}


                    strSQL = "EXEC usp_Sel_PMI_Information_ForGrid " + strPMI
                    With m_objGrid
                        .ActualColumnArray = arrstrActualList_Det
                        .UserFriendlyColumnArray = arrstrUserFriendlyList_Det
                        .GroupOnColumn = arrGroupField
                        .TDStyleArray = arrstrTDStyle_Det
                        .NoOfDataColumns = 5
                        .DIVHeight = 0
                        .ColumnHeaderAlignment = "left"
                        .ColNameToolTipOnEachRow = True
                        .UseSQL = m_blnUseSQL
                        .returnHTML = True
                        .SQL = strSQL
                        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                        .IgnoreHTMLEncode = arrIgnoreHtml
                        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                        strGrid = .DrawGrid()
                    End With

                    Response.Write(strGrid)

                    'Response.Write("</TD></TR></TABLE>")
                    Response.Write("</DIV>")
                    Response.Write("<BR>")
                    Response.Write(strMenu)
                    m_objGrid = Nothing
                End If
                '============================== END OF PROJECT TEMPLATE =================================

                '============================== SDLC Precesses ========================================
            Case CONST_PRO_SDLC

                '=========== For Saving the SDLC Precesses ==============
                If m_strMode = "SAVEPROCESS" Then
                    'Modified By VidyaJ - IssueID : 672 - Whiz2.0 Integration
                    'Added By NileshD on 13 Sep 2005 REQID - WAF3_PB_8
                    Dim drProjects As IDataReader
                    ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                    ''drProjects = CommonFunctions.Data.GetDataReader("SELECT ProjectID FROM tbl_PM_Project WHERE ProjectTypeID = " + m_lngProjectTypeID.ToString.Trim, MyBase.UseSQL)
                    drProjects = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_Project_Project " + m_lngProjectTypeID.ToString.Trim, MyBase.UseSQL)
                    While drProjects.Read
                        CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'P',null,null,null," + drProjects("ProjectID").ToString)
                    End While
                    drProjects.Close()
                    CommonFunction.Data.DisposeDataReader(drProjects)
                    'End OF Addition By NileshD on 13 Sep 2005 REQID - WAF3_PB_8
                    'End Of Modifications - IssueID : 672

                    'first delete all the entries from the list
                    strSQL = "EXEC usp_del_ProjectType_Info 1," & m_lngProjectTypeID.ToString
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

                    strProcess = Split(Request("chkParameter"), ",")
                    If (UBound(strProcess) >= 0) Then
                        Do While (intCount <= UBound(strProcess))
                            If UBound(strProcess) = 0 And Request("chkParameter") <> "" Then

                                strSQL = "EXEC usp_ins_Data_ProjectConfig 1," & m_lngProjectTypeID & "," & Request("chkParameter")
                                strSQL = strSQL & ",NULL"
                                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                            ElseIf UBound(strProcess) > 0 Then

                                strSQL = "EXEC usp_ins_Data_ProjectConfig 1," & m_lngProjectTypeID & "," & strProcess(intCount)
                                strSQL = strSQL & ",NULL"

                                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                            End If

                            intCount = intCount + 1
                        Loop
                    End If
                End If

                '=========== Draw the Page for SDLC Processes ==============
                '-- hidden Textbox to store the Row Count
                ' CommonFunctions.HTMLControls.DrawTextBox("txtRowcount", "txtRowcount", , , , intCount, , , , , , True)

                '-- Draw the Menu
                strMenu = DrawMenu()
                Response.Write(strMenu)
                Response.Write("<br>")

                MyBase.InitializeResources("AppResources.PRO_ProjectTypeConfiguration", "AppResources")

                '-- Get Project type Name for this Project Type ID
                strSQL = "EXEC usp_sel_ProjectTypeRelated_Informaion 7," & m_lngProjectTypeID.ToString & ",NULL"
                drTemp = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                strType = ""
                If (drTemp.Read) Then strType = drTemp("ProjectType").ToString
                CommonFunctions.Data.DisposeDataReader(drTemp)

                strType = MyBase.GetResourceString("PRACTICE") + " : " + strType

                '-- Draw the Caption
                CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, m_strPageTitle, strType, , True))
                Response.Write("<BR>")
                'Commented and added by Yogesh J on 19-Nov-2015
                '   Response.Write("<DIV ID=divList Style='HEIGHT:320px;OVERFLOW:scroll'>")
                Response.Write("<DIV ID=divList Style='OVERFLOW:auto'>")
                'End of comment by Yogesh J on 19-Nov-2015
                '-- Draw the Grid for SDLC
                Call Display_SDLC_Processes_Grid()

                Response.Write("</div>")
                Response.Write("<br>")
                Response.Write(strMenu)

            Case CONST_PRO_PHASE

                '=================== SAVE Logic for Phases =======================
                If m_strMode = "SAVEPHASE" Then

                    'first delete all the entries from the list
                    strSQL = "EXEC usp_del_ProjectType_Info 4," + m_lngProjectTypeID.ToString
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

                    intCount = 0

                    Do While (intCount < CType(Request("txtCount"), Integer))

                        If (Request("chkParameter" & intCount) <> "") Then

                            If (Trim(Request("txtPercentageEfforts" & intCount)) = "") Then
                                fltPercentageEforts = 0
                            Else
                                fltPercentageEforts = CType(Trim(Request("txtPercentageEfforts" + intCount.ToString)), Double)
                            End If

                            If (Trim(Request("txtOrderNumber" & intCount)) = "") Then
                                fltOrderNumber = 0
                            Else
                                fltOrderNumber = CType(Trim(Request("txtOrderNumber" + intCount.ToString)), Double)
                            End If

                            strSQL = "EXEC usp_ins_ProjectType_Phase_data " & Request("TypeID") & "," & Request("chkParameter" & intCount) & "," & fltPercentageEforts & "," & fltOrderNumber

                            'Response.Write "<BR>" & strSQL 
                            CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                        End If

                        intCount = intCount + 1
                    Loop

                End If

                '-- Draw the Menu
                strMenu = DrawMenu()
                Response.Write(strMenu)
                Response.Write("<br>")

                MyBase.InitializeResources("AppResources.PRO_ProjectTypeConfiguration", "AppResources")

                '-- Get Project type Name for this Project Type ID
                strSQL = "EXEC usp_sel_ProjectTypeRelated_Informaion 7," + m_lngProjectTypeID.ToString + ",NULL"
                drTemp = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                strType = ""
                If (drTemp.Read) Then strType = drTemp("ProjectType").ToString
                CommonFunctions.Data.DisposeDataReader(drTemp)

                strType = MyBase.GetResourceString("PRACTICE") + " : " + strType

                '-- Draw the Caption
                CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, m_strPageTitle, strType, , True))
                CommonFunction.General.WriteHTML("<br>")

                '-- Div for Activities grid
                'Commented and added by Yogesh J on 19-Nov-2015
                '   Response.Write("<DIV ID=divList Style='HEIGHT:320px;OVERFLOW:scroll'>")
                Response.Write("<DIV ID=divList Style='OVERFLOW:auto'>")
                'End of Comment by Yogesh J on  on 19-Nov-2015

                '-- Draw the Grid for SDLC
                Call Display_Phases_Grid()

                Response.Write("</DIV>")
                Response.Write("<br>")
                Response.Write(strMenu)

            Case CONST_PRO_ACTIVITY

                If m_strMode = "SAVEACTIVITY" Then
                    intCount = 0

                    'first delete all the entries from the list
                    strSQL = "EXEC usp_del_ProjectType_Activities " & m_lngProcessID & "," & m_lngProjectTypeID
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

                    strActivity = Split(Request("chkParameter"), ",")
                    If (UBound(strActivity) >= 0) Then
                        Do While (intCount <= UBound(strActivity))
                            If UBound(strActivity) = 0 And Request("chkParameter") <> "" Then

                                strSQL = "EXEC usp_ins_Data_ProjectConfig 2," & m_lngProjectTypeID & "," & Request("chkParameter")
                                strSQL = strSQL & "," + m_lngProcessID.ToString

                                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                            ElseIf UBound(strActivity) > 0 Then

                                strSQL = "EXEC usp_ins_Data_ProjectConfig 2," & m_lngProjectTypeID & "," & strActivity(intCount)
                                strSQL = strSQL & "," + m_lngProcessID.ToString

                                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                            End If

                            intCount = intCount + 1
                        Loop
                    End If

                End If

                '-- Draw the Menu
                strMenu = DrawMenu()
                Response.Write(strMenu)
                Response.Write("<br>")
                MyBase.InitializeResources("AppResources.PRO_ProjectTypeConfiguration", "AppResources")
                Response.Write("<DIV ID=divList Style='WIDTH:100%;OVERFLOW:auto'>")


                '-- get Name of the Process
                strSQL = "EXEC usp_sel_ProjectTypeRelated_Informaion 10,NULL," & m_lngProcessID.ToString
                drTemp = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                strType = ""
                If (drTemp.Read) Then strType = drTemp("ProcessName").ToString + ""
                CommonFunctions.Data.DisposeDataReader(drTemp)

                strType = MyBase.GetResourceString("PROCESS_TYPE") + " : " + strType

                '-- Draw the Caption
                CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, m_strPageTitle, strType, , True))
                CommonFunction.General.WriteHTML("<br>")

                '-- Draw the Grid
                Call Display_SDLC_Processes_Activity_Grid()

                Response.Write("</DIV>")
                Response.Write("<br>")
                Response.Write(strMenu)
            Case Else

        End Select

    End Sub

    Private Sub Display_Phases_Grid()
        '=====================================================================
        ' Function Name         : Display_Phases_Grid
        ' Purpose               : Code for SDLC Phases Data Grid
        ' Description           : Code for SDLC Phases Grid
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : SuryabirD
        ' Created               : Feb 15, 2004
        ' Revisions             : 
        '=====================================================================

        Dim strSQL, strClassName As String
        Dim drProjectTypes, drCheck As IDataReader
        Dim intCounter, intCount As Integer
        Dim strCheck, strDisabled As String
        Dim fltPercentageEforts, fltOrderNumber As Double
        Dim strMenu, strSaveMenu, strAddtion As String

        '-- Get All Phases for this Project Type
        strSQL = "EXEC usp_sel_ProjectTypeRelated_Informaion 11,NULL,NULL"
        drProjectTypes = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

        '-- Loop to display all SDLC Processes and checkbox (to show if its selected)
        '-- table Header
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TABLE width=99.9% class=clsTable border=0 cellPadding=0 cellSpacing = 0>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TR class=clsTRColumnHeader ><TD align=left>")
        Response.Write(MyBase.GetResourceString("SDLC_PHASES"))    'SDLC(Process)
        Response.Write("</TD>")
        Response.Write("<TD align=center>")
        Response.Write(MyBase.GetResourceString("PERC_EFFORTS")) 'Select
        Response.Write("</TD>")
        Response.Write("<TD align=center>")
        Response.Write(MyBase.GetResourceString("ORDER_NO")) 'Select
        Response.Write("</TD>")
        Response.Write("<TD align=center>")
        Response.Write(MyBase.GetResourceString("SELECT")) 'Select
        Response.Write("</TD></TR>")

        strClassName = "clsTROdd"

        strMenu = strMenu + "<script language='JavaScript'>" + vbCrLf

        strSaveMenu = strSaveMenu + "function SavePhase_OnClick(intProjectTypeID)" + vbCrLf
        strSaveMenu = strSaveMenu + "{" + vbCrLf
        'Added By Usha Pandit On 19.08.2020 For not allowing to enter duplicate/zero order numbers
        strSaveMenu = strSaveMenu + " objFormRef = GetFormReference('frmProjectType'); " + vbCrLf
        strSaveMenu = strSaveMenu + " var blnOrderNumberZeroExists = false; " + vbCrLf
        strSaveMenu = strSaveMenu + " var blnOrderNumberExists = false; " + vbCrLf
        strSaveMenu = strSaveMenu + " var curObj = ''; " + vbCrLf
        strSaveMenu = strSaveMenu + " var outputArray = []; " + vbCrLf

        strSaveMenu = strSaveMenu + " $('*[id*=txtOrderNumber]').each(function () { " + vbCrLf
        strSaveMenu = strSaveMenu + " curId = $(this).attr('id'); " + vbCrLf
        strSaveMenu = strSaveMenu + " curVal = $('#' + curId).val(); " + vbCrLf
        strSaveMenu = strSaveMenu + " if (curVal > 0) { " + vbCrLf
        strSaveMenu = strSaveMenu + " if (outputArray.length > 0) { " + vbCrLf
        strSaveMenu = strSaveMenu + " for (var ind = 0; ind < outputArray.length; ind++) { " + vbCrLf
        strSaveMenu = strSaveMenu + " if (outputArray[ind] == curVal) { " + vbCrLf
        strSaveMenu = strSaveMenu + " blnOrderNumberExists = true; " + vbCrLf
        strSaveMenu = strSaveMenu + " curObj = $('#' + curId); " + vbCrLf
        strSaveMenu = strSaveMenu + " } " + vbCrLf
        strSaveMenu = strSaveMenu + " } " + vbCrLf
        strSaveMenu = strSaveMenu + " } " + vbCrLf
        strSaveMenu = strSaveMenu + " if (blnOrderNumberExists == false) { " + vbCrLf
        strSaveMenu = strSaveMenu + " outputArray.push(curVal); " + vbCrLf
        strSaveMenu = strSaveMenu + " } " + vbCrLf
        strSaveMenu = strSaveMenu + " } " + vbCrLf
        strSaveMenu = strSaveMenu + " }); " + vbCrLf

        strSaveMenu = strSaveMenu + " if (blnOrderNumberExists == true) { " + vbCrLf
        strSaveMenu = strSaveMenu + " alert('This order number is already exists.'); " + vbCrLf
        strSaveMenu = strSaveMenu + " curObj.focus(); " + vbCrLf
        strSaveMenu = strSaveMenu + " return; " + vbCrLf
        strSaveMenu = strSaveMenu + " } " + vbCrLf

        strSaveMenu = strSaveMenu + " $('*[id*=chkParameter]').each(function () { " + vbCrLf
        strSaveMenu = strSaveMenu + " curId = $(this).attr('id'); " + vbCrLf
        strSaveMenu = strSaveMenu + " var curName = $(this).attr('name'); " + vbCrLf
        strSaveMenu = strSaveMenu + " var curOrder = curName.toString().replace('chkParameter', 'txtOrderNumber'); " + vbCrLf
        strSaveMenu = strSaveMenu + " curSelObj = $('[name=' + curName + ']'); " + vbCrLf

        strSaveMenu = strSaveMenu + " curOrderObj = $('[name=' + curOrder + ']'); " + vbCrLf
        strSaveMenu = strSaveMenu + " if (curSelObj.is(':checked') == true) { " + vbCrLf
        strSaveMenu = strSaveMenu + " if (curOrderObj.val() <= 0 && blnOrderNumberZeroExists == false) { " + vbCrLf
        strSaveMenu = strSaveMenu + " blnOrderNumberZeroExists = true; " + vbCrLf
        strSaveMenu = strSaveMenu + " alert('Order no should be greater than 0'); " + vbCrLf

        strSaveMenu = strSaveMenu + " curOrderObj.focus(); " + vbCrLf
        strSaveMenu = strSaveMenu + " return; " + vbCrLf
        strSaveMenu = strSaveMenu + " } " + vbCrLf
        strSaveMenu = strSaveMenu + " } " + vbCrLf
        strSaveMenu = strSaveMenu + " }); " + vbCrLf

        strSaveMenu = strSaveMenu + " if (blnOrderNumberZeroExists == true) { " + vbCrLf
        strSaveMenu = strSaveMenu + " return; " + vbCrLf
        strSaveMenu = strSaveMenu + " } " + vbCrLf

        'End Of Added By Usha Pandit On 19.08.2020 For not allowing to enter duplicate/zero order numbers

        strAddtion = "if(("

        If drProjectTypes.Read Then
            Do
                If intCounter Mod 2 = 0 Then
                    strClassName = "clsTROdd"
                Else
                    strClassName = "clsTREven"
                End If

                intCounter += 1

                strSQL = "EXEC usp_sel_ProjectTypeRelated_Informaion 12," + m_lngProjectTypeID.ToString + ","
                strSQL = strSQL + drProjectTypes("PhaseID").ToString

                drCheck = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                If (drCheck.Read) Then
                    strCheck = " Checked "
                    strDisabled = ""

                    If (CommonFunctions.Data.CheckIsDBNull(drCheck("PercentageEfforts"), "").ToString = "") Then
                        fltPercentageEforts = 0
                    Else
                        fltPercentageEforts = CType(drCheck("PercentageEfforts"), Double)
                    End If

                    If (CommonFunctions.Data.CheckIsDBNull(drCheck("ordernumber"), "").ToString = "") Then
                        fltOrderNumber = 0
                    Else
                        fltOrderNumber = CType(drCheck("ordernumber"), Double)
                    End If

                Else
                    strCheck = ""
                    strDisabled = " Disabled "
                    fltPercentageEforts = 0
                    fltOrderNumber = 0
                End If
                CommonFunction.Data.DisposeDataReader(drCheck)
                strMenu = strMenu & " var objFormRef = GetFormReference('frmProjectType'); " + vbCrLf
                strMenu = strMenu & "function chkParameter" + intCount.ToString + "_OnClick()" + vbCrLf
                strMenu = strMenu & "{" + vbCrLf
                strMenu = strMenu & "    var objtxtPrec" + intCount.ToString + "= GetObjectReference('frmProjectType','txtPercentageEfforts" + intCount.ToString + "');" + vbCrLf
                'Modified By VarunA on 23-Sep-2008 IssueID-22515
                'Purpose : Mozilla
                'strMenu = strMenu & "    var objCheckbox = GetObjectReference('frmProjectType','chkParameter" + intCount.ToString + "');" + vbCrLf
                strMenu = strMenu & "    var objCheckbox = GetObjectReference('frmProjectType','chkParameter" + intCount.ToString + "','true');" + vbCrLf
                'End By VarunA on 23-Sep-2008 IssueID-22515

                strMenu = strMenu & "	 var objOrderNum" + intCount.ToString + " = GetObjectReference('frmProjectType','txtOrderNumber" + intCount.ToString + "');" + vbCrLf
                strMenu = strMenu & "    if(objCheckbox)" + vbCrLf
                'strMenu = strMenu & "    if(objCheckbox.checked)" + vbCrLf
                strMenu = strMenu & "	 {" + vbCrLf
                'strMenu = strMenu & " alert('hi1');"
                strMenu = strMenu & "      objtxtPrec" + intCount.ToString + ".disabled = false;" + vbCrLf
                strMenu = strMenu & "      objOrderNum" + intCount.ToString + ".disabled = false;" + vbCrLf

                strMenu = strMenu & "	 }" + vbCrLf
                strMenu = strMenu & "	 else" & vbCrLf
                strMenu = strMenu & "	 {" + vbCrLf
                ' strMenu = strMenu & " alert('hi2');"
                strMenu = strMenu & "      objtxtPrec" + intCount.ToString + ".disabled = true;" + vbCrLf
                strMenu = strMenu & "      objtxtPrec" + intCount.ToString + ".value = 0;" & vbCrLf
                strMenu = strMenu & "      objOrderNum" + intCount.ToString + ".value = 0;" + vbCrLf
                strMenu = strMenu & "      objOrderNum" + intCount.ToString + ".disabled = true;" + vbCrLf
                strMenu = strMenu & "	 }" + vbCrLf
                ' End Modification.
                strMenu = strMenu & "}" + vbCrLf

                '-- Added
                'Commented by ShraddhaM on Date 4/10/2006 SP7 Issue ID.6545
                ''strSaveMenu = strSaveMenu + "    var objtxtPrec" + intCount.ToString + " = GetObjectReference('frmProjectType','txtPercentageEfforts" + intCount.ToString + "');" + vbCrLf
                '' strSaveMenu = strSaveMenu + "	 var objOrderNum" + intCount.ToString + " = GetObjectReference('frmProjectType','txtOrderNumber" + intCount.ToString + "');" + vbCrLf
                '-- End

                'Added by ShraddhaM on Date 4/10/2006 SP7 Issue ID.6545
                strSaveMenu = strSaveMenu + "    var objtxtPrec" + intCount.ToString + " = window.document.forms['frmProjectType'].elements['txtPercentageEfforts" + intCount.ToString + "'];" + vbCrLf
                strSaveMenu = strSaveMenu + "	 var objOrderNum" + intCount.ToString + " = window.document.forms['frmProjectType'].elements['txtOrderNumber" + intCount.ToString + "'];" + vbCrLf
                'Ended by ShraddhaM on Date 4/10/2006 SP7 Issue ID.6545

                strAddtion = strAddtion + "parseInt(objtxtPrec" + intCount.ToString + ".value) +"
                strSaveMenu = strSaveMenu & "if(objtxtPrec" + intCount.ToString + ".value < 0)" & vbCrLf
                'strSaveMenu = strSaveMenu & "if(objtxtPrec" + intCount.ToString + " < 0)" & vbCrLf
                strSaveMenu = strSaveMenu & "if(objtxtPrec" + intCount.ToString + ".value < 0)" & vbCrLf

                strSaveMenu = strSaveMenu & "{"
                strSaveMenu = strSaveMenu & "       alert('Value should not be negative');"
                strSaveMenu = strSaveMenu & "        objtxtPrec" + intCount.ToString + ".focus();"
                strSaveMenu = strSaveMenu & "       return;     "
                strSaveMenu = strSaveMenu & "}" + vbCrLf
                'Commented and Modified by SavitaS on 14 Sept 2006 for Whiziblesem SP7 IssueID 6227
                '   strSaveMenu = strSaveMenu & " if(isNaN(objtxtPrec" + intCount.ToString + "))" & vbCrLf
                strSaveMenu = strSaveMenu & " if(isNaN(objtxtPrec" + intCount.ToString + ".value))" & vbCrLf
                'End of Commented and Modified by SavitaS on 14 Sept 2006 for Whiziblesem SP7 IssueID 6227
                strSaveMenu = strSaveMenu & "{"
                strSaveMenu = strSaveMenu & "       alert('Only Numbers are allowed');"
                strSaveMenu = strSaveMenu & "        objtxtPrec" + intCount.ToString + ".focus();"
                strSaveMenu = strSaveMenu & "       return;     "
                strSaveMenu = strSaveMenu & "}" + vbCrLf


                strSaveMenu = strSaveMenu & "if(objOrderNum" + intCount.ToString + ".value < 0)" & vbCrLf

                strSaveMenu = strSaveMenu & "{"
                strSaveMenu = strSaveMenu & "       alert('Value should not be negative');"
                strSaveMenu = strSaveMenu & "        objOrderNum" + intCount.ToString + ".focus();"
                strSaveMenu = strSaveMenu & "       return;     "
                strSaveMenu = strSaveMenu & "}" + vbCrLf


                strSaveMenu = strSaveMenu & "if(isNaN(objOrderNum" + intCount.ToString + ".value))" & vbCrLf

                strSaveMenu = strSaveMenu & "{"
                strSaveMenu = strSaveMenu & "       alert('Only Numbers are allowed');"
                strSaveMenu = strSaveMenu & "        objOrderNum" + intCount.ToString + ".focus();"
                strSaveMenu = strSaveMenu & "       return;     "
                strSaveMenu = strSaveMenu & "}" + vbCrLf
                'Ended by ShraddhaM on Date 12 June,2006 for WhizibleSEM Issue ID.4168
                Response.Write("<tr class= " + strClassName + ">")
                Response.Write("<td align=Left title='Phase' >")
                Response.Write(drProjectTypes("Phase").ToString)
                Response.Write("</Td>")
                Response.Write("<td align=Center title='Percentage Efforts'>")
                Response.Write("<Input maxlength=4 " + strDisabled + " class=clsTextBox style ='text-align:Right;WIDTH:44px' type=Textbox ")
                'Modified By VarunA on 23-Sep-2008 IssueID-22515
                'Purpose : Mozilla
                'Response.Write("name='txtPercentageEfforts" + intCount.ToString + "' value = " + fltPercentageEforts.ToString + ">")
                Response.Write("id='txtPercentageEfforts" + intCount.ToString + "' name='txtPercentageEfforts" + intCount.ToString + "' value = " + fltPercentageEforts.ToString + ">")
                'End By VarunA on 23-Sep-2008 IssueID-22515
                Response.Write("</Td>")
                Response.Write("<td align=Center title='Order Number'>")
                Response.Write("<Input  maxlength=4 " + strDisabled + " class=clsTextBox style ='text-align:Right;WIDTH: 44px;' type=Textbox ")
                'Modified By VarunA on 23-Sep-2008 IssueID-22515
                'Purpose : Mozilla
                'Response.Write("name='txtOrderNumber" + intCount.ToString + "' value = " + fltOrderNumber.ToString + ">")
                Response.Write("id='txtOrderNumber" + intCount.ToString + "' name='txtOrderNumber" + intCount.ToString + "' value = " + fltOrderNumber.ToString + ">")
                'End By VarunA on 23-Sep-2008 IssueID-22515
                Response.Write("</Td>")
                'Modified by ShraddhaM on Date 13 June,2006 for WhizibleSEM Issue ID.4168
                Response.Write("<td align=Center ><INPUT  ID='chkParameter' type=checkbox onClick='javascript:chkParameter" + intCount.ToString + "_OnClick()'" + strCheck + " name=chkParameter" + intCount.ToString)
                'Ended by ShraddhaM on Date 13 June,2006 for WhizibleSEM Issue ID.4168
                Response.Write(" value=" + drProjectTypes("PhaseID").ToString + " ></Td>")
                Response.Write("</tr>")

                intCount = intCount + 1
            Loop While drProjectTypes.Read
        End If
        Response.Write("</TABLE>")

        'Modified By VarunA on 23-Sep-2008 IssueID-22515
        'Purpose : Mozilla
        'Response.Write("<Input name=txtCount value=" + intCount.ToString + " type=hidden>")
        Response.Write("<Input id=txtCount name=txtCount value=" + intCount.ToString + " type=hidden>")
        'End By VarunA on 23-Sep-2008 IssueID-22515

        strAddtion = strAddtion + ")> 100)" + vbCrLf
        strAddtion = strAddtion + "{" & vbCrLf
        strAddtion = strAddtion + "    alert('Percentage efforts for all the selected phases should not exceed 100% ')" + vbCrLf
        strAddtion = strAddtion + "	   return;	" + vbCrLf
        strAddtion = strAddtion + "}" + vbCrLf

        strAddtion = Replace(strAddtion, "+)", ")")
        strSaveMenu = strSaveMenu + strAddtion
        'added by harshK for sp4 issueid 113
        strSaveMenu = strSaveMenu + " if(IsorderUnique() == false)  return; "
        'end added by harshK for sp4 issueid 113
        strSaveMenu = strSaveMenu + "   	objFormRef.action = 'PRO_ProjectTypeConfiguration.aspx?Mode=SAVEPHASE&FLAG=PHASE&TypeID=' + intProjectTypeID;" + vbCrLf
        strSaveMenu = strSaveMenu + "		objFormRef.method = 'Post';" + vbCrLf
        strSaveMenu = strSaveMenu + " 		objFormRef.submit();" + vbCrLf

        strSaveMenu = strSaveMenu + "}" + vbCrLf

        CommonFunctions.Data.DisposeDataReader(drProjectTypes)

        strMenu = strMenu + strSaveMenu + "</Script>" + vbCrLf
        Response.Write(strMenu)

    End Sub
    Private Sub Display_SDLC_Processes_Activity_Grid()
        '=====================================================================
        ' Function Name         : Display_SDLC_Processes_Activity_Grid
        ' Purpose               : Code for Process's Activity Data Grid
        ' Description           : 
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : SuryabirD
        ' Created               : Feb 15, 2004
        ' Revisions             : 
        '=====================================================================

        Dim arrstrActualList() As String = {"title", "IsSelected"}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("PROCESS_ACTIVITY"), MyBase.GetResourceString("SELECT")}
        '-- define the Style/Tool tip for each column
        Dim arrstrTDStyle() As String = {" align=left ", " align=center"}
        Dim arrCheckboxCheckOnColumnArray() As String = {"", "IsSelected"}
        Dim arrCheckBoxIDArray() As String = {"", "chkParameter"}
        Dim objGrid As New WebPage.Templates.AdvancedGrid
        Dim strSQLQuery As String
        Dim strGRID As String
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        strSQLQuery = "EXEC usp_sel_ProjectTypeRelated_Informaion 9, " + m_lngProjectTypeID.ToString + "," + m_lngProcessID.ToString

        '--Plotting the Grid 
        With objGrid
            '--Columns in the Grid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            '.ColumnHeaderAlignment = "center"
            .SQL = strSQLQuery
            .PrimaryKey = "Activityid"
            .CheckboxCheckOnColumnArray = arrCheckboxCheckOnColumnArray
            .CheckBoxIDArray = arrCheckBoxIDArray

            .DIVHeight = 0
            .returnHTML = True
            .UseSQL = m_blnUseSQL
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            strGRID = .DrawGrid()
        End With

        Response.Write(strGRID)

        objGrid = Nothing
    End Sub

    Private Sub Display_SDLC_Processes_Grid()
        '=====================================================================
        ' Function Name         : Display_SDLC_Processes_Grid
        ' Purpose               : Manually create this Table: as we have to fire row level events 
        '                         to get status of the Checkbox
        ' Description           : Plot the Grid for displaying SDLC Processes (and checkbox for if they r selected)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : SuryabirD
        ' Created               : Feb 16, 2004
        ' Revisions             : 
        '=====================================================================

        '-- We Manually create this Table: as we have to fire row level events to get status of the Checkbox
        Dim strSQL, strType, strCheck As String
        Dim drProjectTypes As IDataReader
        Dim drCheck As IDataReader
        Dim strClassName As String
        Dim intCounter As Integer = 0

        'Modified by SachinR    on 20 Sep 2004
        'Purpose    :   New Sp created to get the list of processes for the given ProjectType 
        '               to apply the OU Pool filter

        'Get All SDLC Processes for this Project Type
        'strSQL = "Exec usp_sel_ProjectTypeRelated_Informaion 6," + m_lngProjectTypeID.ToString + ",NULL"
        strSQL = "usp_Sel_tbl_PRS_ProjectType_Processes " + m_lngProjectTypeID.ToString
        'modification end
        drProjectTypes = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

        '-- Loop to display all SDLC Processes and checkbox (to show if its selected)
        '-- table Header
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TABLE width=99.9% class=clsTable border=0 cellPadding=0 cellSpacing = 0>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TR class=clsTRColumnHeader ><TD align=left>")
        Response.Write(MyBase.GetResourceString("SDLC_PROCESS"))    'SDLC(Process)
        Response.Write("</TD>")
        Response.Write("<TD align=center>")
        Response.Write(MyBase.GetResourceString("SELECT")) 'Select
        Response.Write("</TD></TR>")

        strClassName = "clsTROdd"

        If drProjectTypes.Read Then
            Do
                If intCounter Mod 2 = 0 Then
                    strClassName = "clsTROdd"
                Else
                    strClassName = "clsTREven"
                End If
                intCounter += 1

                'Modified by SachinR    on 20 Sep 2004
                'Purpose    :   This has been commented, as no need to access database again to check whethear process
                'is selected or not.That column is added in the main record list.(Outer data reader)
                'strSQL = "EXEC usp_sel_ProjectTypeRelated_Informaion 8," & m_lngProjectTypeID.ToString & ","
                'strSQL = strSQL + CommonFunctions.Data.CheckIsDBNull(drProjectTypes("ProcessID"), "").ToString
                'drCheck = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                'modification end

                Response.Write("<tr class=" + strClassName + ">")
                Response.Write("<td align=Left  title='SDLC (Process)'>")

                'If (drCheck.Read) Then 
                If CType(CommonFunction.Data.CheckIsDBNull(drProjectTypes("IsSelected"), "0"), Boolean) Then
                    strCheck = "1"
                    Response.Write("<a Href='javascript:ShowActivity(" + CommonFunctions.Data.CheckIsDBNull(drProjectTypes("ProcessID"), "").ToString + "," + m_lngProjectTypeID.ToString + ")'>")
                    Response.Write(Server.HtmlEncode(drProjectTypes("ProcessName").ToString))
                    Response.Write("</a>")
                Else
                    strCheck = "0"
                    Response.Write(Server.HtmlEncode(drProjectTypes("ProcessName").ToString))
                End If
                'CommonFunctions.Data.DisposeDataReader(drCheck)

                Response.Write("</Td>")
                Response.Write("<td align=Center >")
                'CommonFunctions.HTMLControls.DrawCheckBox("chkParameter", "chkParameter", , CType(strCheck, Boolean), drProjectTypes("ProcessID").ToString)
                Response.Write("<INPUT Name='chkParameter' ID='chkParameter' Type=checkbox value=" + drProjectTypes("ProcessID").ToString)
                If CType(strCheck, Boolean) Then Response.Write(" checked ")
                Response.Write(">")
                Response.Write("</Td>")
                Response.Write("</tr>")

            Loop While drProjectTypes.Read
        Else

            Response.Write("<TR class=clsTROdd>")
            Response.Write("<TD align=center colspan=12>")
            Response.Write(MyBase.GetResourceString("NO_ITEMS"))
            Response.Write("</TD>")
            Response.Write("</TR>")

        End If

        CommonFunctions.Data.DisposeDataReader(drCheck)
        CommonFunctions.Data.DisposeDataReader(drProjectTypes)
        Response.Write("</Table>")

    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'initialize the resource file for PRO_ProjectTypeConfiguration page.
        MyBase.InitializeResources("AppResources.PRO_ProjectTypeConfiguration", "AppResources")
    End Sub

    Private Sub CreateGlobalObject()
        '=====================================================================
        ' Function Name         : CreateGlobalObject
        ' Purpose               : Creates the Global Object for accessing TagID, FrowWhere etc.
        ' Description           : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : SuryabirD
        ' Created               : Feb 16, 2004
        ' Revisions             : 
        '=====================================================================

        'Global object
        Dim objAccess As New WebPage.Templates.AccessRights

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject

        '-- HardCode the Master TagID For Popup page
        m_objGlobal.TagID = 1037
        m_objGlobal.FromWhere = "PRO"

        If m_strFromWhere = "" Then
            m_strFromWhere = m_objGlobal.FromWhere
        Else
            m_objGlobal.FromWhere = m_strFromWhere
        End If

        If m_lngTagID = 0 Then
            m_lngTagID = m_objGlobal.TagID
        Else
            m_objGlobal.TagID = m_lngTagID
        End If

        objAccess.GetAccess(m_objGlobal)

        m_blnAddAccess = objAccess.Add          'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete    'If User has Delete Access
        m_blnEditAccess = objAccess.Edit        'If user has Edit Access

        'destroy global and AccessRights objects
        objAccess = Nothing

    End Sub

    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        Dim arrMenuList As New System.Collections.ArrayList
        Dim arrEventList As New System.Collections.ArrayList
        Dim arrMenuToolTipList As New ArrayList

        Select Case m_strFlag
            '-- SDLC Processes
            Case CONST_PRO_SDLC

                'If m_blnAddAccess Or m_blnEditAccess Then
                arrMenuList.Add(MyBase.GetResourceString("MENU_SAVE"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SAVE"))
                arrEventList.Add("SaveProcess_OnClick(" + m_lngProjectTypeID.ToString + ")")
                ' End If

                arrMenuList.Add(MyBase.GetResourceString("MENU_SELECTALL"))
                arrMenuList.Add(MyBase.GetResourceString("MENU_CLEARALL"))
                arrMenuList.Add(MyBase.GetResourceString("MENU_CLOSE"))
                arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))

                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SELECTALL"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_CLEARALL"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_CLOSE"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP"))

                arrEventList.Add("SelectAll_OnClick('frmProjectType','chkParameter')")
                arrEventList.Add("ClearAll_OnClick('frmProjectType','chkParameter')")
                arrEventList.Add("Close_OnClick()")
                arrEventList.Add("Help_OnClick('PTYPECONFIG_SDLC')")

            Case CONST_PRO_PHASE
                Dim drProjectTypes1, drCheck1 As IDataReader
                Dim strSQL1 As String
                Dim intCnt As Integer = 0
                Dim intCnt1 As Integer = 0
                Dim i As Integer = 0
                ' If m_blnAddAccess Or m_blnEditAccess Then
                arrMenuList.Add(MyBase.GetResourceString("MENU_SAVE"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SAVE"))
                arrEventList.Add("SavePhase_OnClick(" + m_lngProjectTypeID.ToString + ")")
                'End If
                'Modified by ShraddhaM on Date 14 June,2006 for WhizibleSEM Issue ID.4168

                strSQL1 = "EXEC usp_sel_ProjectTypeRelated_Informaion 11,NULL,NULL"
                drProjectTypes1 = CommonFunctions.Data.GetDataReader(strSQL1, m_blnUseSQL)

                If drProjectTypes1.Read Then

                    Do
                        intCnt = intCnt + 1

                    Loop While drProjectTypes1.Read

                End If
                CommonFunction.Data.DisposeDataReader(drProjectTypes1)
                'Ended by ShraddhaM on Date 14 June,2006 for WhizibleSEM Issue ID.4168

                arrMenuList.Add(MyBase.GetResourceString("MENU_SELECTALL"))
                arrMenuList.Add(MyBase.GetResourceString("MENU_CLEARALL"))
                arrMenuList.Add(MyBase.GetResourceString("MENU_CLOSE"))
                arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))

                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SELECTALL"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_CLEARALL"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_CLOSE"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP"))

                'Modified by ShraddhaM on Date 14 June,2006 for WhizibleSEM Issue ID.4168

                arrEventList.Add("SelectAllCheck_OnClick('frmProjectType','chkParameter'," + intCnt.ToString + ")")

                arrEventList.Add("ClearAllCheck_OnClick('frmProjectType','chkParameter'," + intCnt.ToString + ")")

                'Ended by ShraddhaM on Date 14 June,2006 for WhizibleSEM Issue ID.4168

                arrEventList.Add("Close_OnClick()")
                arrEventList.Add("Help_OnClick('PTYPECONFIG_PHASES')")



            Case CONST_PRO_ACTIVITY

                If m_blnAddAccess Or m_blnEditAccess Then
                    arrMenuList.Add(MyBase.GetResourceString("MENU_SAVE"))
                    arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SAVE"))
                    arrEventList.Add("SaveActivity_OnClick(" + m_lngProcessID.ToString + "," + m_lngProjectTypeID.ToString + ")")

                End If
                arrMenuList.Add(MyBase.GetResourceString("MENU_SELECTALL"))
                arrMenuList.Add(MyBase.GetResourceString("MENU_CLEARALL"))
                arrMenuList.Add(MyBase.GetResourceString("MENU_CLOSE"))
                arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))

                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SELECTALL"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_CLEARALL"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_CLOSE"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP"))

                arrEventList.Add("SelectAll_OnClick('frmProjectType','chkParameter')")
                arrEventList.Add("ClearAll_OnClick('frmProjectType','chkParameter')")
                arrEventList.Add("Close_OnClick()")
                'added by harshada d for whizblesem6 on 3 April 2006
                arrEventList.Add("Help_OnClick('PTYPE_ACTIVITY')")
                'end of addition by harshada d

            Case Else
                '-- PROJECT TEMPLATE
                'Added By JyotiG
                'Start_JG_CR_7187_06-Nov-2006
                'Condition for ProjectID<>0 added By JyotiG for Issue ID : JG_7575_10-Nov-2006
                If m_lngProjectTypeID <> 0 Then
                    Dim drHistory As IDataReader
                    Dim strHistory As String
                    strHistory = "SELECT UniqueID FROM v_tbl_PM_AuditTrail WHERE TagID = 1037 and UniqueID = " + CType(m_lngProjectTypeID, String)
                    drHistory = CommonFunctions.Data.GetDataReader(strHistory, MyBase.UseSQL)
                    If drHistory.Read Then
                        m_bln_ShowHistory = True
                    End If
                    CommonFunctions.Data.DisposeDataReader(drHistory)
                    If m_bln_ShowHistory = True Then
                        arrMenuList.Add("Show History")
                        arrMenuToolTipList.Add("Show History")
                        arrEventList.Add("ShowHistory_OnClick(" + CStr(m_lngProjectTypeID) + ")")
                    End If
                End If
                'End_JG_CR_7187_06-Nov-2006
                If m_blnAddAccess Or m_blnEditAccess Then
                    arrMenuList.Add(MyBase.GetResourceString("MENU_SAVE"))
                    arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SAVE"))
                    arrEventList.Add("SaveType_OnClick()")
                End If

                arrMenuList.Add(MyBase.GetResourceString("MENU_BACK"))
                arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))

                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_BACK"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP"))

                arrEventList.Add("Back_OnClick()")
                arrEventList.Add("Help_OnClick('PTYPECONFIG')")

        End Select

        Dim arrMenu(arrMenuList.Count - 1) As String
        Dim arrMenuToolTip(arrMenuToolTipList.Count - 1) As String
        Dim arrClientSideFunctions(arrEventList.Count - 1) As String

        arrMenuList.CopyTo(arrMenu)
        arrMenuToolTipList.CopyTo(arrMenuToolTip)
        arrEventList.CopyTo(arrClientSideFunctions)

        arrMenuList = Nothing
        arrMenuToolTipList = Nothing
        arrEventList = Nothing

        'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_SELECTALL"), MyBase.GetResourceString("MENU_CLEARALL"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_SELECTALL"), MyBase.GetResourceString("MENU_CLEARALL"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        'Dim arrClientSideFunctions() As String = {"Save_OnClick()", "SelectAll_OnClick()", "ClearAll_OnClick()", "Close_OnClick()", "Help_OnClick()"}
        Dim strMenu As String = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        Return strMenu

    End Function



    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload

    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If Args.DataField.Trim.ToUpper = "CATEGORYNAME" Then
            Args.ColumnName = ""
        End If
    End Sub
End Class
