'=====================================================================

' Project Name          :  WhizibleSEM 8.0
' Module Name           :  WorkFlow_Association.aspx
' Purpose               :  To set workflow association applicability for Entity 
' Description           :  
' Dependencies          :  None
' Author                :  MahendraV
' Reviewed              :  28 april 2008
' Tested                :  
' Created               :  
' Revisions             :  
'=====================================================================

Public Class WorkFlow_Association
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
#Region "Member Variables"
    Private WithEvents m_objWFCorporateAssociationGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objWFProjectAssociationGrid As New WebPages.Template.GenericGrid

    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Protected m_StrMode As String = ""
    Protected m_StrActionMode As String = ""
    Protected m_StrProjectID As String = ""
    Protected m_StrUnCheckMasterTagID As String = ""
    Protected m_strAttributeID As String = ""
    Protected m_strAttribute As String = ""
    Protected m_strOperation As String = ""
    Protected m_SBHTML As System.Text.StringBuilder
    Protected m_strSQL As String = ""
    Protected drEM As IDataReader
    Protected arrIgnoreHTMLEncode() As String = {"0"}
    'Added By Usha Pandit On 14.05.2020 For getting/setting current active tab
    Protected m_clsTabSelected As String = "Submit"
    'Added By Usha Pandit On 14.05.2020 For getting/setting current active tab

#End Region
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Protected Sub PageInit()

        ' Added By Sanyogeeta on 10-10-2016  For Apply Security
        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Apply Security
        Call setVariables()
        Call DrawMenu()
        Call PageCaption()
        If m_StrActionMode.ToUpper() = "SAVE" Then
            Call PerformAction()
        End If

        CommonFunction.General.WriteHTML("<DIV Id=PageDiv name =PageDiv Style='OVERFLOW:auto; WIDTH:100%'>" + vbCrLf)
        If m_strOperation.ToUpper <> "EDIT" Then
            If m_StrMode.ToUpper() = "CORPORATE" Then
                Call DrawCorporateEntityGrid()
            End If
            If m_StrMode.ToUpper() = "PROJECT" Then
                Call DrawProjectEntityGrid()
            End If
        Else
            'DrawEntityDetails()
            DrawSections()
            ' Response.Write("<div id=DivEM Style=""OVERFLOW: Auto; WIDTH:100%;"">")
            Response.Write("<div id=DivEM Style="" WIDTH:100%;"">")

            CommonFunctions.General.WriteHTML(GenerateTabSections.ToString)
            DrawEmailMessages()
            Response.Write("</div>")
        End If
        CommonFunction.General.WriteHTML("</DIV>")


    End Sub
    Private Sub DrawSections()
        '====================================================================
        ' Procedure Name        :  DrawSections
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the EMail  section
        ' Description           :  Same as purpose.
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrashantSJ
        ' Created               :  8-Apr-2008
        ' Revisions             :  
        '=====================================================================
        m_SBHTML = New System.Text.StringBuilder
        Dim ObjEM As New WebPage.Templates.SectionTitle
        With ObjEM
            m_SBHTML.Append(.GetSectionTitle("Email Messages", "DivEM", "HideShowEMSection", , , , , , , , , , , ))
            'Write ClientsideScript in order to show hide the section
            m_SBHTML.Append("<SCRIPT Language=javascript>")
            m_SBHTML.Append(.ClientsideScript)
            m_SBHTML.Append("</SCRIPT>")
        End With
        CommonFunctions.General.WriteHTML(m_SBHTML.ToString)
        m_SBHTML = Nothing
    End Sub

    Private Function GenerateTabSections() As String
        '====================================================================
        ' Function Name         :  GenerateTabSections
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the EMail Tab section
        ' Description           :  Same as purpose.
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrashantSJ
        ' Created               :  8-Apr-2008
        ' Revisions             :  
        '=====================================================================
        Dim arrTabName() As String = {MyBase.GetResourceString("TAB_SUBMIT"), MyBase.GetResourceString("TAB_APPROVE"), MyBase.GetResourceString("TAB_REJECT")}
        Dim arrTabToolTip() As String = {MyBase.GetResourceString("TAB_SUBMIT"), MyBase.GetResourceString("TAB_APPROVE"), MyBase.GetResourceString("TAB_REJECT")}
        Dim arrTabOnClickFun() As String = {"TabOnClick(1)", "TabOnClick(2)", "TabOnClick(3)"}

        'Added By Usha Pandit On 14.05.2020 For getting/setting current active tab
        If Not Request.QueryString("ActiveTab") Is Nothing And Not Request.QueryString("ActiveTab") = "" Then
            m_clsTabSelected = Request.QueryString("ActiveTab")
        End If
        'End Of Added By Usha Pandit On 14.05.2020 For getting/setting current active tab
        m_SBHTML = New System.Text.StringBuilder
        Dim i As Integer = 0

        m_SBHTML.Append("<TABLE class=clsTable cellspacing=0 width='99.9%' cellpadding=0>")
        m_SBHTML.Append("<TR><TD valign=bottom align=left>")
        m_SBHTML.Append("<TABLE  BORDER=0 cellspacing=0   class=clsTable><TR> ")
        For i = 0 To arrTabName.Length - 1
            'Commented And Added By Usha Pandit On 14.05.2020 For getting/setting current active tab
            'm_SBHTML.Append("<TD id=td_" + arrTabName(i).ToString + " align=center noWrap Title='" + arrTabToolTip(i) + "'>")
            'm_SBHTML.Append("<A id=hrf_" + arrTabName(i).ToString + " class='navtab' href='JavaScript:" + arrTabOnClickFun(i) + "'>" + arrTabName(i) + "</A>")
            'm_SBHTML.Append("</TD>")
            Dim clsTabSelected As String = ""
            If m_clsTabSelected = arrTabName(i) Then
                clsTabSelected = "clsTabSelected"
            Else
                clsTabSelected = "navtab"
            End If
            m_SBHTML.Append("<TD id=td_" + arrTabName(i).ToString + " align=center noWrap Title='" + arrTabToolTip(i) + "'>")
            m_SBHTML.Append("<A id=hrf_" + arrTabName(i).ToString + " class='" + clsTabSelected + "' href='JavaScript:" + arrTabOnClickFun(i) + "'>" + arrTabName(i) + "</A>")
            m_SBHTML.Append("</TD>")
            'Added By Usha Pandit On 14.05.2020 For getting/setting current active tab
        Next
        m_SBHTML.Append("</TR></TABLE>")
        m_SBHTML.Append("</TD></TR></TABLE>")

        Return m_SBHTML.ToString
        m_SBHTML = Nothing
    End Function
    Private Sub setVariables()
        '====================================================================
        ' Procedure Name        :  setVariables
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the grid for Stage selection 
        ' Description           :  This sub-routine draws the grid for Stage selection 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  MahendraV
        ' Created               :  28-April-2008
        ' Revisions             :  
        '=====================================================================

        If Not HttpContext.Current.Request.QueryString("Mode") Is Nothing Then
            m_StrMode = HttpContext.Current.Request.QueryString("Mode").ToString()
        End If

        If Not HttpContext.Current.Request.Form("HDN_TXT_MODE") Is Nothing Then
            m_StrMode = HttpContext.Current.Request.Form("HDN_TXT_MODE").ToString()
        End If

        If Not HttpContext.Current.Request.QueryString("ActionMode") Is Nothing Then
            m_StrActionMode = HttpContext.Current.Request.QueryString("ActionMode").ToString()
        End If
        If Not HttpContext.Current.Session("intProjectID") Is Nothing Then
            m_StrProjectID = HttpContext.Current.Session("intProjectID").ToString()
        End If

        If Not HttpContext.Current.Request.Form("HDN_TXT_UNCHEKED") Is Nothing Then
            m_StrUnCheckMasterTagID = HttpContext.Current.Request.Form("HDN_TXT_UNCHEKED").ToString()
        End If


        If Not HttpContext.Current.Request.Form("txtHIDOperation") Is Nothing Then
            m_strOperation = HttpContext.Current.Request.Form("txtHIDOperation").ToString
        Else
            m_strOperation = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")).ToString
        End If

        If Not HttpContext.Current.Request.Form("txtHIDAttributeID") Is Nothing Then
            m_strAttributeID = HttpContext.Current.Request.Form("txtHIDAttributeID").ToString
        Else
            m_strAttributeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("AttributeID")).ToString
        End If

        If Not HttpContext.Current.Request.Form("txtHIDAttribute") Is Nothing Then
            m_strAttribute = HttpContext.Current.Request.Form("txtHIDAttribute").ToString
        Else
            m_strAttribute = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Attribute")).ToString
        End If
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHIDOperation", "txtHIDOperation", , , , m_strOperation, , , , , , True, , True, EnableHTMLEncode:=True))
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHIDAttribute", "txtHIDAttribute", , , , m_strAttribute, , , , , , True, , True, EnableHTMLEncode:=True))
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtHIDAttributeID", "txtHIDAttributeID", , , , m_strAttributeID, , , , , , True, , True, EnableHTMLEncode:=True))
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("HDN_TXT_MODE", "HDN_TXT_MODE", , , , m_StrMode, , , , , , True, , True, EnableHTMLEncode:=True))
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("HDN_TXT_UNCHEKED", "HDN_TXT_UNCHEKED", , , , m_StrUnCheckMasterTagID, , , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
    End Sub
    Private Sub DrawEntityDetails()
        '=====================================================================
        ' Procedure Name        : DrawEntityDetails
        ' Purpose               : Returns Entity details for the page.
        ' Description           : Same as purpose.
        ' Parameters Passed     : None
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantSJ
        ' Created               : Apr 8,2008
        ' Revisions             :
        '=====================================================================
        m_SBHTML = New System.Text.StringBuilder
        m_strSQL = "usp_sel_tbl_IM_Attributes " & m_strAttributeID
        drEM = CommonFunction.Data.GetDataReader(m_strSQL, MyBase.UseSQL)

        m_SBHTML.Append("<br>")
        m_SBHTML.Append("<table ID=tblEM width='99.9%'  CellSpacing=0 CellPadding=0  class='clsTable' >")

        While drEM.Read
            m_SBHTML.Append("<tr class=clsTREven text-align='center'>")
            m_SBHTML.Append("<td ALIGN='right'>")
            m_SBHTML.Append(MyBase.GetResourceString("COL_ENTITY") + " :")
            m_SBHTML.Append("&nbsp;</td>")
            m_SBHTML.Append("<td ALIGN='left'>")
            m_SBHTML.Append(m_strAttribute)
            m_SBHTML.Append("</td>")
            m_SBHTML.Append("<td ALIGN='right'>&nbsp;&nbsp;</td>")
            m_SBHTML.Append("</tr>")

            m_SBHTML.Append("<tr class=clsTREven text-align='center'>")
            m_SBHTML.Append("<td ALIGN='right'>")
            m_SBHTML.Append(MyBase.GetResourceString("COL_ACTIVE"))
            m_SBHTML.Append("&nbsp;</td>")
            m_SBHTML.Append("<td ALIGN='left'>")
            m_SBHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkActive", "chkActive", , CBool(CommonFunction.Data.CheckIsDBNull(drEM("Active"))), CommonFunction.Data.CheckIsDBNull(drEM("Active")), IIf(CBool(CommonFunction.Data.CheckIsDBNull(drEM("IsUsed"))), True, False), , True))
            m_SBHTML.Append("</td>")
            m_SBHTML.Append("<td ALIGN='right'>&nbsp;&nbsp;</td>")
            m_SBHTML.Append("</tr>")

            'm_SBHTML.Append("<tr class=clsTREven text-align='center'>")
            'm_SBHTML.Append("<td ALIGN='right'>")
            'm_SBHTML.Append(MyBase.GetResourceString("COL_DATAOWNERSHIP"))
            'm_SBHTML.Append("&nbsp;")
            'm_SBHTML.Append("</td>")
            'm_SBHTML.Append("<td ALIGN='left'>")
            'm_SBHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("optActor", "optActor", , IIf(CBool(CStr(CommonFunction.Data.CheckIsDBNull(drEM("SaveLinkAcceesibleTo"))) = "1"), True, False), "1", , , True))
            'm_SBHTML.Append("&nbsp;" + MyBase.GetResourceString("COL_APPROVER") + "&nbsp;")
            'm_SBHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("optActor", "optActor", , IIf(CBool(CStr(CommonFunction.Data.CheckIsDBNull(drEM("SaveLinkAcceesibleTo"))) = "0"), True, False), "0", , , True))
            'm_SBHTML.Append("&nbsp;" + MyBase.GetResourceString("COL_OWNER") + "")
            'm_SBHTML.Append("</td>")
            'm_SBHTML.Append("<td ALIGN='right'></td>")
            'm_SBHTML.Append("</tr>")
        End While

        m_SBHTML.Append("</table>")
        m_SBHTML.Append("<br>")

        CommonFunction.Data.DisposeDataReader(drEM)
        CommonFunctions.General.WriteHTML(m_SBHTML.ToString)
        m_SBHTML = Nothing
    End Sub
    Private Sub DrawEmailMessages()
        '=====================================================================
        ' Procedure Name        : DrawEmailMessages
        ' Purpose               : Returns Email Messages as string for the page.
        ' Description           : Same as purpose.
        ' Parameters Passed     : None
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantSJ
        ' Created               : Apr 7,2008
        ' Revisions             :
        '=====================================================================
        m_SBHTML = New System.Text.StringBuilder
        Dim arrActionType() As String = {"SYS_SUBMIT", "SYS_APPROVE", "SYS_REJECT"}
        Dim i As Integer = 0
        Dim strMsgID As String = ""

        m_SBHTML.Append("<table class='clsSubtagTable' width=99.9%><tr><td>")

        For i = 0 To arrActionType.Length - 1
            m_strSQL = "usp_Sel_tbl_IM_EmailMessages " & m_strAttributeID & ",'" + arrActionType(i) + "'"
            drEM = CommonFunction.Data.GetDataReader(m_strSQL, MyBase.UseSQL)


            m_SBHTML.Append("<DIV Id=divItem_" + arrActionType(i).ToString + " name =PageDiv_" + arrActionType(i).ToString + "  Style='display:none;OVERFLOW:auto; height;100%;WIDTH:100%'>" + vbCrLf)
            m_SBHTML.Append("<table ID=tblEM width='99.9%' style='text-align:center;'  CellSpacing=0 CellPadding=0  class='clsTable' >")
            m_SBHTML.Append("<tr class=clsTRBody>")
            m_SBHTML.Append("</td></tr>")

            While drEM.Read

                m_SBHTML.Append("<tr class=clsTREven>")
                m_SBHTML.Append("<td ALIGN='right'>")
                m_SBHTML.Append(MyBase.GetResourceString("COL_PURPOSE"))
                m_SBHTML.Append("&nbsp;</td>")
                m_SBHTML.Append("<td  ALIGN='left'>")
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'm_SBHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtAPurpose" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "txtAPurpose" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "Purpose", , , "frmWorkFlow_Association", , , 600, 70, 100, CommonFunction.Data.CheckIsDBNull(drEM("Purpose")), , , , , , , , True))
                m_SBHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtAPurpose" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "txtAPurpose" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "Purpose", , , "frmWorkFlow_Association", , , 600, 70, 100, CommonFunction.Data.CheckIsDBNull(drEM("Purpose")), , , , , , , , True, EnableHTMLEncode:=True))
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                m_SBHTML.Append("</td>")
                m_SBHTML.Append("</tr>")


                DrawFieldDetails("Subject", CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString)

                m_SBHTML.Append("<tr class=clsTREven>")
                m_SBHTML.Append("<td  ALIGN='right'>")
                m_SBHTML.Append(MyBase.GetResourceString("COL_SUBJECT"))
                m_SBHTML.Append("&nbsp;</td>")
                m_SBHTML.Append("<td  ALIGN='left'>")
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'm_SBHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtASubject" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "txtASubject" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "Subject", , , "frmWorkFlow_Association", , , 600, 70, 100, CommonFunction.Data.CheckIsDBNull(drEM("Subject")), , , , , , , , True, True))
                m_SBHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtASubject" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "txtASubject" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "Subject", , , "frmWorkFlow_Association", , , 600, 70, 100, CommonFunction.Data.CheckIsDBNull(drEM("Subject")), , , , , , , , True, True, EnableHTMLEncode:=True))
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                m_SBHTML.Append("</td>")
                m_SBHTML.Append("</tr>")

                DrawFieldDetails("Body", CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString)

                m_SBHTML.Append("<tr class=clsTREven>")
                m_SBHTML.Append("<td  ALIGN='right'>")
                m_SBHTML.Append(MyBase.GetResourceString("COL_BODY"))
                m_SBHTML.Append("&nbsp;</td>")
                m_SBHTML.Append("<td ALIGN='left'>")
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'm_SBHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtABody" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "txtABody" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "Body", , , "frmWorkFlow_Association", , , 600, 70, 4000, CommonFunction.Data.CheckIsDBNull(drEM("Body")), , , , , , , , True, True))
                m_SBHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtABody" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "txtABody" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "Body", , , "frmWorkFlow_Association", , , 600, 70, 4000, CommonFunction.Data.CheckIsDBNull(drEM("Body")), , , , , , , , True, True, EnableHTMLEncode:=True))
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                m_SBHTML.Append("</td>")
                m_SBHTML.Append("</tr>")

                m_SBHTML.Append("<tr class=clsTREven>")
                m_SBHTML.Append("<td  ALIGN='right'>")
                m_SBHTML.Append(MyBase.GetResourceString("COL_COMMENTS"))
                m_SBHTML.Append("&nbsp;</td>")
                m_SBHTML.Append("<td  ALIGN='left'>")
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'm_SBHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtAComments" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "txtAComments" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "Comments", , , "frmWorkFlow_Association", , , 600, 70, 500, CommonFunction.Data.CheckIsDBNull(drEM("Comments")), , , , , , , , True, ))
                m_SBHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtAComments" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "txtAComments" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "Comments", , , "frmWorkFlow_Association", , , 600, 70, 500, CommonFunction.Data.CheckIsDBNull(drEM("Comments")), , , , , , , , True, EnableHTMLEncode:=True))
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                m_SBHTML.Append("</td>")
                m_SBHTML.Append("</tr>")

                m_SBHTML.Append("<tr class=clsTREven>")
                m_SBHTML.Append("<td  ALIGN='right'>")
                m_SBHTML.Append(MyBase.GetResourceString("COL_SENDMAIL"))
                m_SBHTML.Append("&nbsp;</td>")
                m_SBHTML.Append("<td  ALIGN='left'>")
                m_SBHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkSM" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "chkSM" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, , CBool(CommonFunction.Data.CheckIsDBNull(drEM("SendMail"))), CommonFunction.Data.CheckIsDBNull(drEM("SendMail")), , , True))
                m_SBHTML.Append("</td>")
                m_SBHTML.Append("</tr>")

                m_SBHTML.Append("<tr class=clsTREven>")
                m_SBHTML.Append("<td  ALIGN='right'>")
                m_SBHTML.Append(MyBase.GetResourceString("COL_SHOWPOPUP"))
                m_SBHTML.Append("&nbsp;</td>")
                m_SBHTML.Append("<td ALIGN='left'>")
                m_SBHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkSPP" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "chkSPP" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, , CBool(CommonFunction.Data.CheckIsDBNull(drEM("ShowPopUp"))), CommonFunction.Data.CheckIsDBNull(drEM("ShowPopUp")), , , True))
                m_SBHTML.Append("</td>")
                m_SBHTML.Append("</tr>")


                strMsgID = CommonFunction.Data.CheckIsDBNull(drEM("MsgID"))
                m_SBHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("chkMsgIDs", "chkMsgIDS", , True, strMsgID, , , True, , , , True))
                ''Added By Vidya J ON 16 Aug 2016 For Save functionality not working in Mozilla/Chrome
                m_SBHTML.Append("<input type=hidden id=hdnMsgIDs name=hdnMsgIDs value=" & strMsgID & ">")

            End While
            CommonFunction.Data.DisposeDataReader(drEM)
            m_SBHTML.Append("</table></div>")
        Next
        m_SBHTML.Append("</td></tr></table><br>")
        CommonFunctions.General.WriteHTML(m_SBHTML.ToString)
        m_SBHTML = Nothing
    End Sub
    Private Sub DrawFieldDetails(ByVal FromWhere As String, ByVal MsgID As String)

        If FromWhere = "Subject" Then
            m_SBHTML.Append("<tr class=clsTREven>")
            m_SBHTML.Append("<td  ALIGN='right'>")
            m_SBHTML.Append("</td>")
            m_SBHTML.Append("<td  ALIGN='left'>")
            m_SBHTML.Append(MyBase.GetResourceString("COL_FIELDS"))
            m_SBHTML.Append("&nbsp;")
            m_SBHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboField_Subject" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "usp_Sel_ControlTagMaster_Captions " + m_strAttributeID, 150, , , , True))
            m_SBHTML.Append("&nbsp;")
            m_SBHTML.Append("&nbsp;<a href='JavaScript:Append_OnClick(""Subject""," + MsgID + ")'><font size='1' title='" + MyBase.GetResourceString("LINK_APPENDSUBJECT") + "' Style='TEXT-DECORATION:None;cursor:pointer;'>")
            m_SBHTML.Append("<font size='1' face='verdana' color='black' Style='TEXT-DECORATION:None'>")
            m_SBHTML.Append("<b>|&nbsp;" + MyBase.GetResourceString("LINK_APPENDSUBJECT") + "&nbsp;|</b>")
            m_SBHTML.Append("</font>")
            m_SBHTML.Append("</a>")

            ' "Append To Body" Link
            'm_SBHTML.Append("<a href='JavaScript:Append_OnClick(""Body""," + MsgID + ")'><font size='1' title='" + MyBase.GetResourceString("LINK_APPENDBODY") + "' Style='TEXT-DECORATION:None;cursor:pointer;'>")
            'm_SBHTML.Append("<font size='1' face='verdana' color='black' Style='TEXT-DECORATION:None'>")
            'm_SBHTML.Append("<b>|&nbsp;&nbsp;&nbsp;" + MyBase.GetResourceString("LINK_APPENDBODY") + " &nbsp;|</b>")
            'm_SBHTML.Append("</font>")
            'm_SBHTML.Append("</a>")

            m_SBHTML.Append("</td>")
            m_SBHTML.Append("</tr>")
        Else
            m_SBHTML.Append("<tr class=clsTREven>")
            m_SBHTML.Append("<td  ALIGN='right'>")
            m_SBHTML.Append("</td>")
            m_SBHTML.Append("<td  ALIGN='left'>")
            m_SBHTML.Append(MyBase.GetResourceString("COL_FIELDS"))
            m_SBHTML.Append("&nbsp;")
            m_SBHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboField_Body" + CommonFunction.Data.CheckIsDBNull(drEM("MsgID")).ToString, "usp_Sel_ControlTagMaster_Captions " + m_strAttributeID, 150, , , , True))
            m_SBHTML.Append("&nbsp;")

            m_SBHTML.Append("<a href='JavaScript:Append_OnClick(""Body""," + MsgID + ")'><font size='1' title='" + MyBase.GetResourceString("LINK_APPENDBODY") + "' Style='TEXT-DECORATION:None;cursor:pointer;'>")
            m_SBHTML.Append("<font size='1' face='verdana' color='black' Style='TEXT-DECORATION:None'>")
            m_SBHTML.Append("<b>|&nbsp;" + MyBase.GetResourceString("LINK_APPENDBODY") + " &nbsp;|</b>")
            m_SBHTML.Append("</font>")
            m_SBHTML.Append("</a>")

            m_SBHTML.Append("</td>")
            m_SBHTML.Append("</tr>")
        End If
    End Sub
    Private Sub DrawMenu()
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 28-April-2008
        ' Revisions             :
        '=====================================================================

        Dim arrMenu() As String = {"<Img Border=0 src='../../Images/cssImages/Link images/Save.gif'>&nbsp;" + MyBase.GetResourceString("MENU_SAVE"), "<Img Border=0 src='../../Images/cssImages/Link images/Back.gif'>&nbsp;" + MyBase.GetResourceString("MENU_BACK"), "<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>"}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_BACK_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {"Save_OnClick()", "Back_OnClick()", "OpenHelpPage('3930')"}

        m_objMenu = New WebPages.Template.StaticMenu
        Dim strmenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        CommonFunctions.General.WriteHTML(strmenu)
        m_objMenu = Nothing

    End Sub

    Private Sub PageCaption()
        '====================================================================
        ' Procedure Name        :  PageCaption
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw page caption
        ' Description           :  None
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  MahendraV
        ' Created               :  28-April-2008
        ' Revisions             :  
        '=====================================================================
        'Dim strSBSQLQuery As New System.Text.StringBuilder
        Dim strRightcaption As String = ""
        'strSBSQLQuery.Append("<BR>")
        'strSBSQLQuery.Append("<TABLE id='tblCap03927'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
        'strSBSQLQuery.Append("<TR class=clsTRPageCaption>")
        'strSBSQLQuery.Append("<TD align=Left>Entity Association")
        'strSBSQLQuery.Append("</TD></TR></TABLE><BR>")
        If m_strOperation.ToUpper = "EDIT" Then
            strRightcaption = MyBase.GetResourceString("PAGE_HEADER_RIGHT") & m_strAttribute
        End If
        CommonFunctions.General.WriteHTML("<br>")
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_HEADER_LEFT"), strRightcaption, , True).ToString)
        CommonFunctions.General.WriteHTML("<br>")
    End Sub

    Private Sub PerformAction()
        '====================================================================
        ' Procedure Name        :  PerformAction
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To formorm action
        ' Description           :  None
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  MahendraV
        ' Created               :  28-April-2008
        ' Revisions             :  
        '=====================================================================
        Dim strSBSQLQuery As New System.Text.StringBuilder
        Dim strAllSelectedEntityIDs As String = ""
        If m_strOperation.ToUpper <> "EDIT" Then
            If m_StrMode.ToUpper() = "CORPORATE" And m_StrActionMode.ToUpper() = "SAVE" Then
                If Not HttpContext.Current.Request.Form("chkCorporateSelect") Is Nothing Then
                    strAllSelectedEntityIDs = (HttpContext.Current.Request.Form("chkCorporateSelect").ToString)
                    If strAllSelectedEntityIDs <> "" Then
                        strSBSQLQuery.Append("usp_Upd_tbl_IM_Attributes ")
                        strSBSQLQuery.Append("'" + strAllSelectedEntityIDs + "'")
                        strSBSQLQuery.Append(",N'" + HttpContext.Current.Session("strUserName").ToString() + "'")
                        CommonFunctions.Data.InsertOrUpdateData(strSBSQLQuery.ToString(), MyBase.UseSQL)
                    End If
                Else
                    strSBSQLQuery.Append("usp_Upd_tbl_IM_Attributes ")
                    strSBSQLQuery.Append("''")
                    strSBSQLQuery.Append(",N'" + HttpContext.Current.Session("strUserName").ToString() + "'")
                    CommonFunctions.Data.InsertOrUpdateData(strSBSQLQuery.ToString(), MyBase.UseSQL)
                End If


            End If

            If m_StrMode.ToUpper() = "PROJECT" And m_StrActionMode.ToUpper() = "SAVE" Then
                If Not HttpContext.Current.Request.Form("chkProjectSelect") Is Nothing Then
                    strAllSelectedEntityIDs = (HttpContext.Current.Request.Form("chkProjectSelect").ToString)
                    If strAllSelectedEntityIDs <> "" Then
                        strSBSQLQuery.Append("usp_Upd_tbl_IM_ProjectAttributes ")
                        strSBSQLQuery.Append(m_StrProjectID)
                        strSBSQLQuery.Append(",'" + strAllSelectedEntityIDs + "'")
                        strSBSQLQuery.Append(",'" + m_StrUnCheckMasterTagID + "'")
                        strSBSQLQuery.Append(",N'" + HttpContext.Current.Session("strUserName").ToString() + "'")
                        CommonFunctions.Data.InsertOrUpdateData(strSBSQLQuery.ToString(), MyBase.UseSQL)
                    End If
                Else
                    strAllSelectedEntityIDs = ""
                    strSBSQLQuery.Append("usp_Upd_tbl_IM_ProjectAttributes ")
                    strSBSQLQuery.Append(m_StrProjectID)
                    strSBSQLQuery.Append(",'" + strAllSelectedEntityIDs + "'")
                    strSBSQLQuery.Append(",'" + m_StrUnCheckMasterTagID + "'")
                    strSBSQLQuery.Append(",N'" + HttpContext.Current.Session("strUserName").ToString() + "'")
                    CommonFunctions.Data.InsertOrUpdateData(strSBSQLQuery.ToString(), MyBase.UseSQL)
                End If
            End If
        Else
            '''<Summary>
            '''Added by :   PrashantSJ
            '''Dated    :   11th June 2008
            '''Purpose  :   To save entity details (i.e. Email messages and active or inactive entity)
            '''</Summary>
            'Comment by SuchitraP on 16-Sep-2008 : Active checkbox is removed
            'Dim strActive As String = ""
            'strActive = CStr(IIf(CBool(CommonFunction.General.CheckIsNothing(Request.Form("chkActive")) = ""), "0", "1"))
            'End by SuchitraP

            strSBSQLQuery.Append("usp_Upd_tbl_IM_Attributes ")
            strSBSQLQuery.Append("'" + m_strAttributeID + "'")
            strSBSQLQuery.Append(",N'" + HttpContext.Current.Session("strUserName").ToString() + "'")
            'Comment and modified by SuchitraP on 16-Sep-2008 : Active checkbox is removed
            'strSBSQLQuery.Append("," + strActive)
            strSBSQLQuery.Append(",1")
            'End by SuchitraP
            strSBSQLQuery.Append("," + CommonFunction.General.CheckIsNothing(Request.Form("optActor"), "0"))

            CommonFunctions.Data.InsertOrUpdateData(strSBSQLQuery.ToString(), MyBase.UseSQL)
            strSBSQLQuery.Remove(0, strSBSQLQuery.Length)
            ''Commented And Added By Vidya Jadhav ON 16 Aug 2016 For Save Functionality
            '    Dim strMsgIDs As String = CommonFunction.General.CheckIsNothing(Request.Form("chkMsgIDs"))
            Dim strMsgIDs As String = CommonFunction.General.CheckIsNothing(Request.Form("hdnMsgIDs"))
            ''End Of Commented And Added By Vidya Jadhav ON 16 Aug 2016 For Save Functionality 
            Dim arrMsgIDs() As String
            Dim k As Integer = 0
            Dim strPurpose As String = ""
            Dim strSubject As String = ""
            Dim strBody As String = ""
            Dim strComments As String = ""
            Dim strSendMail As String = ""
            Dim strPopUp As String = ""

            arrMsgIDs = strMsgIDs.Split(","c)

            For k = 0 To arrMsgIDs.Length - 1
                strPurpose = CommonFunction.General.CheckIsNothing(Request.Form("txtAPurpose" + CStr(arrMsgIDs(k))))
                strSubject = CommonFunction.General.CheckIsNothing(Request.Form("txtASubject" + CStr(arrMsgIDs(k))))
                strBody = CommonFunction.General.CheckIsNothing(Request.Form("txtABody" + CStr(arrMsgIDs(k))))
                strComments = CommonFunction.General.CheckIsNothing(Request.Form("txtAComments" + CStr(arrMsgIDs(k))))
                strSendMail = CStr(IIf(CBool(CommonFunction.General.CheckIsNothing(Request.Form("chkSM" + CStr(arrMsgIDs(k)))) = ""), "0", "1"))
                strPopUp = CStr(IIf(CBool(CommonFunction.General.CheckIsNothing(Request.Form("chkSPP" + CStr(arrMsgIDs(k)))) = ""), "0", "1"))

                strSBSQLQuery.Append("usp_Upd_tbl_IM_EmailMessages ")
                strSBSQLQuery.Append(m_strAttributeID)
                strSBSQLQuery.Append("," + CStr(arrMsgIDs(k)))
                strSBSQLQuery.Append(",N'" + CommonFunction.General.BuildQueryString(strPurpose) + "'")
                strSBSQLQuery.Append(",N'" + CommonFunction.General.BuildQueryString(strSubject) + "'")
                strSBSQLQuery.Append(",N'" + CommonFunction.General.BuildQueryString(strBody) + "'")
                strSBSQLQuery.Append(",N'" + CommonFunction.General.BuildQueryString(strComments) + "'")
                strSBSQLQuery.Append("," + strSendMail)
                strSBSQLQuery.Append("," + strPopUp)
                strSBSQLQuery.Append(",N'" + CommonFunction.General.BuildQueryString(HttpContext.Current.Session("strUserName").ToString()) + "'")

                CommonFunctions.Data.InsertOrUpdateData(strSBSQLQuery.ToString(), MyBase.UseSQL)
                strSBSQLQuery.Remove(0, strSBSQLQuery.Length)
            Next
        End If
        strSBSQLQuery = Nothing
        ''End of addition by PrashantSJ on 11th June 2008
    End Sub

    Private Sub DrawCorporateEntityGrid()
        '====================================================================
        ' Procedure Name        :  DrawCorporateEntityGrid
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the grid for Entity selection 
        ' Description           :  none
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  MahendraV
        ' Created               :  28-April-2008
        ' Revisions             :  
        '=====================================================================

        Dim strSBSQLQuery As New System.Text.StringBuilder
        'To store the link details while clicking on Links in grid
        Dim arrColumnHeadingList() As String = {MyBase.GetResourceString("COL_ENTITY"), MyBase.GetResourceString("COL_EMAIL"), MyBase.GetResourceString("COL_SELECT")}
        Dim arrActualColumnNames() As String = {"Attribute", "EmailSetup", ""}
        'Dim arrColRowLinks() As String = {"Entity_OnClick(Attribute,AttributeID)", ""}
        Dim arrColRowLinks() As String = {"", "Entity_OnClick(Attribute,AttributeID)", ""}
        ''Commented and Added by Dhanashri S on 2 Dec 2015 for IssueID:2139
        ''Dim arrWidthArray() As String = {"align=left", "align=center", "align=center"}
        Dim arrWidthArray() As String = {"style='text-align:left !important'", "style='text-align:center !important'", "style='text-align:center !important'"}
        ''End of Comment and Addition by Dhanashri S on 2 Dec 2015
        Dim arrCheckBoxIDs() As String = {"", "", "chkCorporateSelect"}
        Dim arrdisabledCheckbox() As String = {"", "", "IsUsed"}
        strSBSQLQuery.Append("usp_sel_tbl_IM_Attributes NULL,'PRO'")

        ''Plots the Table for Daily Activity.
        ''-------------------------------------------------------------------

        With m_objWFCorporateAssociationGrid
            .ActualColumnArray = arrActualColumnNames
            .UserFriendlyColumnArray = arrColumnHeadingList
            .CheckBoxIDArray = arrCheckBoxIDs
            .NoOfDataColumns = arrActualColumnNames.Length - 1
            .RowLinkArray = arrColRowLinks
            .PrimaryKey = "AttributeID"
            .TDStyleArray = arrWidthArray
            .CheckboxDisableOnColumnArray = arrdisabledCheckbox
            .DIVStyle = "overflow:none;margin-bottom:590px;"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            'Commented by Vidya J
            '.DIVHeight = 275
            'End of Commented by Vidya J
            .DIVStyle = "overflow:auto"
            .SQL = strSBSQLQuery.ToString()
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

        ' Clear Memory
        m_objWFCorporateAssociationGrid = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing
        strSBSQLQuery = Nothing
    End Sub

    Private Sub DrawProjectEntityGrid()
        '====================================================================
        ' Procedure Name        :  DrawCorporateEntityGrid
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the grid for Entity selection 
        ' Description           :  none
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  MahendraV
        ' Created               :  28-April-2008
        ' Revisions             :  
        '=====================================================================

        Dim strSBSQLQuery As New System.Text.StringBuilder
        'To store the link details while clicking on Links in grid
        Dim arrColumnHeadingList() As String = {MyBase.GetResourceString("COL_ENTITY"), MyBase.GetResourceString("COL_SELECT")}
        Dim arrActualColumnNames() As String = {"Attribute", ""}
        Dim arrWidthArray() As String = {"align=left", "align=center"}
        Dim arrCheckBoxIDs() As String = {"", "chkProjectSelect"}
        Dim arrdisabledCheckbox() As String = {"", "IsUsed"}
        strSBSQLQuery.Append("usp_sel_tbl_IM_ProjectAttributes ")
        strSBSQLQuery.Append(m_StrProjectID)
        ''Plots the Table for Daily Activity.
        ''-------------------------------------------------------------------

        With m_objWFProjectAssociationGrid
            .ActualColumnArray = arrActualColumnNames
            .UserFriendlyColumnArray = arrColumnHeadingList
            .CheckBoxIDArray = arrCheckBoxIDs
            .NoOfDataColumns = arrActualColumnNames.Length - 1
            .PrimaryKey = "AttributeID"
            .TDStyleArray = arrWidthArray
            .CheckboxDisableOnColumnArray = arrdisabledCheckbox
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            ' .DIVHeight = 275
            .DIVStyle = "overflow:auto"
            .SQL = strSBSQLQuery.ToString()
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

        ' Clear Memory
        m_objWFProjectAssociationGrid = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing
        strSBSQLQuery = Nothing

    End Sub

    Private Sub m_objWFCorporateAssociationGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objWFCorporateAssociationGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper() = "APPLY WORKFLOW" Then
            If Args.DataReader("Active") = True Then
                Args.IsCheckBoxChecked = True
                'Addition by SuchitraP on 16-Sep-2008 to enable checkbox when WF is not Active
            Else
                Args.IsCheckBoxDisabled = False
            End If
            'End by SuchitraP
        End If

        'Addition by SuchitraP on 16-Sep-2008 to show email setup link only when WF is Active
        If Args.ColumnName.ToUpper = "EMAIL SETUP" Then
            If Args.DataReader("Active") = False Then
                Cancel = True
                Args.StringToBeInserted = "<TD vAlign=top align=center> - </TD>"
            End If
        End If
        'End by SuchitraP

    End Sub

    Private Sub m_objWFProjectAssociationGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objWFProjectAssociationGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper() = "APPLY WORKFLOW" Then
            If Args.DataReader("Active") = True Then
                Args.IsCheckBoxChecked = True
            End If
        End If
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If m_strOperation.ToUpper <> "EDIT" Then
            If Args.FunctionName.ToUpper = "BACK_ONCLICK()" Then
                Cancel = True
            End If
        End If
    End Sub

    Public Sub New()
        MyBase.InitializeResources("AppResources.Workflow_Association", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
   
End Class
