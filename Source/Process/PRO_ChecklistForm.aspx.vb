Imports CommonFunctions

Public Class PRO_ChecklistForm
    Inherits WebPages.Template.WhizTemplate

    Protected Const CONST_MODE_DRAFT As String = "DRAFT"
    Protected Const CONST_MODE_PUBLISH As String = "PUBLISH"

    Protected m_strWindowTitle As String
    Protected m_strMode As String
    Protected m_strChecklistID As String
    Private m_strProjectID As String
    Private m_strUserID As String


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

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PRO_ChecklistForm", "AppResources")
    End Sub
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'set the window title 
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_FORM")
    End Sub

    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draw the page with its 
    '                           controls on it. This procedure is called from the HTML bady tag of the page.
    '                           this procedure gives the call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Mar 17 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim blnEOF As Boolean = False
        Dim blnTemplateFound As Boolean = False
        Dim strObjective As String = ""
        Dim strChecklistName As String = ""
        Dim strRevisionNo As String = ""
        Dim strRevisedBy As String = ""
        Dim strRevisedOn As String = ""
        Dim strApprovedBy As String = ""
        Dim strApprovedOn As String = ""
        Dim strChecklistSectionID As String = ""
        Dim strChecklistItemID As String = ""
        Dim strResponseID As String = ""
        Dim strPrevChecklistSectionID As String = ""
        Dim strPrevChecklistItemID As String = ""
        Dim strNextChecklistSectionID As String = ""
        Dim strNextChecklistItemID As String = ""
        Dim strChecklistItem As String = ""
        Dim blnUseStandardResponseFormat As Boolean = False
        Dim blnIsChecked As Boolean = False
        Dim blnAcceptComments As Boolean = False

        'added By   SachinR     on 25 May 2004
        'to resolve the problem of same name for the option buttons and checkboxes
        'for all the rows of the checklist. This variable is used as rowcounter and used 
        'for the control ID/Name.
        Dim intRowCount As Integer
        'addition end
        intRowCount = 0

        m_strMode = Request.QueryString("Mode") + ""
        m_strChecklistID = Request.QueryString("ChecklistID") + ""
        'm_strProjectID = Session("intProjectID").ToString + ""
        'm_strUserID = Session("intUserID").ToString + ""

        If m_strMode = "" Then m_strMode = CONST_MODE_DRAFT
        If m_strChecklistID = "" Then m_strChecklistID = "0"

        'get the details about the checklist
        If m_strMode = CONST_MODE_DRAFT Then
            strSQL = "usp_Sel_tbl_PRS_Checklists_Draft " + m_strChecklistID.Trim
            objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDR.Read Then
                strChecklistName = Data.CheckIsDBNull(objDR("Title"), "").ToString + ""
                strObjective = Data.CheckIsDBNull(objDR("Objective"), "").ToString + ""
                strRevisionNo = Data.CheckIsDBNull(objDR("CurrentRevisionNo"), "0").ToString
            End If
            Data.DisposeDataReader(objDR)
        Else
            strSQL = "usp_Sel_tbl_PRS_Checklists " + m_strChecklistID.Trim
            objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDR.Read Then
                strChecklistName = Data.CheckIsDBNull(objDR("Title"), "").ToString + ""
                strObjective = Data.CheckIsDBNull(objDR("Objective"), "").ToString + ""
                strRevisedBy = Data.CheckIsDBNull(objDR("RevisedBy"), "").ToString + ""
                strRevisedOn = Data.CheckIsDBNull(objDR("RevisedOn"), "").ToString + ""
                strApprovedBy = Data.CheckIsDBNull(objDR("ApprovedBy"), "").ToString + ""
                strApprovedOn = Data.CheckIsDBNull(objDR("ApprovedOn"), "").ToString + ""
                strRevisedOn = Data.CheckIsDBNull(objDR("RevisionNo"), "").ToString + ""
            End If
            Data.DisposeDataReader(objDR)
        End If

        '*******************************************************************************************
        'get the data about the checklist and display the controls 

        'display checklist name as page caption
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<TR class='clsTROdd' >")
        General.WriteHTML("<TD align='center' valign='middle'><B>")
        General.WriteHTML(strChecklistName.Trim)
        General.WriteHTML("</B></TD></TR>")
        General.WriteHTML("</Table>")
        General.WriteHTML("<BR>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<Table class='clsTable' cellspacing=0 cellpadding=0 width=99.9%>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='left' valign='top'><B>" + MyBase.GetResourceString("CAP_OBJECTIVE") + " : </B></TD>")
        General.WriteHTML("<TD align='left' colspan=3 >" + strObjective.Trim + "</TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='left'><B>" + MyBase.GetResourceString("CAP_REVISION") + " : </B></TD>")
        General.WriteHTML("<TD align='left' colspan=3 >" + strRevisionNo.Trim + "</TD>")
        General.WriteHTML("</TR>")

        If m_strMode <> CONST_MODE_DRAFT Then
            General.WriteHTML("<TR class='clsTREven'>")
            General.WriteHTML("<TD align='left'><B>" + MyBase.GetResourceString("CAP_REVISEDBY") + " : </B></TD>")
            General.WriteHTML("<TD align='left'>" + strRevisedBy.Trim + "</TD>")
            General.WriteHTML("<TD align='left'><B>" + MyBase.GetResourceString("CAP_REVISEDON") + " : </B></TD>")
            General.WriteHTML("<TD align='left'>" + strRevisedOn.Trim + "</TD>")
            General.WriteHTML("</TR>")
            General.WriteHTML("<TR class='clsTREven'>")
            General.WriteHTML("<TD align='left'><B>" + MyBase.GetResourceString("CAP_APPROVEDBY") + " : </B></TD>")
            General.WriteHTML("<TD align='left'>" + strApprovedBy.Trim + "</TD>")
            General.WriteHTML("<TD align='left'><B>" + MyBase.GetResourceString("CAP_APPROVEDON") + " : </B></TD>")
            General.WriteHTML("<TD align='left'>" + strApprovedOn.Trim + "</TD>")
            General.WriteHTML("</TR>")
        End If
        General.WriteHTML("</Table>")
        General.WriteHTML("<BR>")

        General.WriteHTML("<Div id='PageDiv' width=100% style='overflow: auto;'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=1 cellpadding=1 >")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        If m_strMode = CONST_MODE_DRAFT Then
            strSQL = "usp_Sel_tbl_PRS_Checklists_Draft_ForPreview " + m_strChecklistID.Trim
        ElseIf m_strMode = CONST_MODE_PUBLISH Then
            strSQL = "usp_Sel_tbl_PRS_Checklists_ForPreview " + m_strChecklistID.Trim
        End If
        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDR.Read Then

            While True

                blnTemplateFound = True
                strPrevChecklistSectionID = strChecklistSectionID
                strPrevChecklistItemID = strChecklistItemID

                strChecklistSectionID = Data.CheckIsDBNull(objDR("ChecklistSectionID"), "").ToString + ""
                strChecklistItemID = Data.CheckIsDBNull(objDR("ChecklistItemID"), "").ToString + ""
                strResponseID = Data.CheckIsDBNull(objDR("ResponseID"), "").ToString + ""
                strChecklistItem = Data.CheckIsDBNull(objDR("ChecklistItem"), "").ToString + ""
                blnUseStandardResponseFormat = CType(Data.CheckIsDBNull(objDR("UseStandardResponseFormat"), "0"), Boolean)

                ' If there is a change in the section, then, display the header for the section name.
                If strChecklistSectionID <> strPrevChecklistSectionID Then
                    General.WriteHTML("<TR >")
                    General.WriteHTML("<TD align='left' colspan=3 >")
                    General.WriteHTML("</TR>")

                    General.WriteHTML("<TR class='clsTRColumnHeader'>")
                    General.WriteHTML("<TD align='left'>" + Data.CheckIsDBNull(objDR("ChecklistSectionName"), "").ToString + "</TD>")
                    General.WriteHTML("<TD align='center'>" + MyBase.GetResourceString("COL_RESPONSE") + "</TD>")
                    General.WriteHTML("<TD align='center'>" + MyBase.GetResourceString("COL_COMMENTS") + "</TD>")
                    General.WriteHTML("</TR>")
                End If

                ' If the record for checklist item in the section is present, then...
                If strChecklistItemID <> "" Then

                    ' If there is a change in the checklist item, then, add a new row for the item.
                    ' Display the checklist item in the first division.
                    ' Display the response options in the second division.
                    ' Display the comments textarea in the third division.
                    If strChecklistItemID <> strPrevChecklistItemID Then
                        General.WriteHTML("<TR class='clsTREven'>")

                        General.WriteHTML("<TD align='left' valign='top' width=50%>")
                        General.WriteHTML(strChecklistItem.Replace(vbCrLf, "<BR>"))
                        General.WriteHTML("</TD>")

                        If blnUseStandardResponseFormat = True Then
                            General.WriteHTML("<TD align='center' valign='top' >")
                        Else
                            General.WriteHTML("<TD align='left' valign='top' >")
                        End If
                        intRowCount += 1    'added by SachinR   on 25 May 2004
                    End If

                    blnIsChecked = CType(Data.CheckIsDBNull(objDR("IsExpectedResponse"), "0"), Boolean)
                    ' Display the response option(s).
                    '--------------------------------									
                    ' Display the checkbox if the checkbox option is selected.
                    If blnUseStandardResponseFormat = False And Data.CheckIsDBNull(objDR("CustomResponseFormat"), "").ToString = "C" Then
                        General.WriteHTML(HTMLControls.DrawCheckBox("chkResponse" + intRowCount.ToString, "chkResponse" + intRowCount.ToString, , blnIsChecked, "1", , , True))
                    Else
                        ' Else, display the option button.
                        General.WriteHTML(HTMLControls.DrawOptionButton("optResponse" + intRowCount.ToString, "optResponse" + intRowCount.ToString, , blnIsChecked, "1", , , True))
                    End If
                    General.WriteHTML(Data.CheckIsDBNull(objDR("ResponseCaption"), "").ToString)

                    If blnUseStandardResponseFormat = True Then
                        General.WriteHTML("&nbsp;&nbsp;")
                    Else
                        General.WriteHTML("<BR>")
                    End If

                    blnAcceptComments = CType(Data.CheckIsDBNull(objDR("AcceptComments"), "0"), Boolean)
                End If

                'move to next record
                ' Get the next values...
                If objDR.Read Then
                    strNextChecklistSectionID = Data.CheckIsDBNull(objDR("checklistSectionID"), "").ToString
                    strNextChecklistItemID = Data.CheckIsDBNull(objDR("checklistItemID"), "").ToString
                Else
                    strNextChecklistSectionID = "-1"
                    strNextChecklistItemID = "-1"
                    blnEOF = True
                End If

                ' If there is a item-change, then end the item details.
                If strChecklistItemID <> "" Then
                    If strChecklistItemID <> strNextChecklistItemID Then

                        General.WriteHTML("</TD>")
                        General.WriteHTML("<TD align='left' width=10% valign='top' nowrap>")
                        If blnAcceptComments = True Then
                            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                            ''General.WriteHTML(HTMLControls.DrawTextArea("txtComments" + intRowCount.ToString, "txtComments" + intRowCount.ToString, , , , "frmPRO_ChecklistForm", , , 200, 50, , , , , , , , , , True))
                            General.WriteHTML(HTMLControls.DrawTextArea("txtComments" + intRowCount.ToString, "txtComments" + intRowCount.ToString, , , , "frmPRO_ChecklistForm", , , 200, 50, , , , , , , , , , True, EnableHTMLEncode:=True))
                            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
                        Else
                            General.WriteHTML(MyBase.GetResourceString("NA") + "")
                        End If
                        General.WriteHTML("</TD>")
                        General.WriteHTML("</TR>")

                    End If
                End If

                ' If there is a section-change, then end the section details.
                If strChecklistSectionID <> strNextChecklistSectionID Then
                    General.WriteHTML("<TR><TD colspan=3></TD></TR>")
                End If

                If blnEOF = True Then Exit While
            End While
        End If
        Data.DisposeDataReader(objDR)

        If blnTemplateFound = False Then
            General.WriteHTML("<TR class='clsTREven'>")
            General.WriteHTML("<TD align='center' >" + MyBase.GetResourceString("MSG_NOTEMPLATE") + "</TD>")
            General.WriteHTML("</TR>")
        End If
        General.WriteHTML("</Table>")
        General.WriteHTML("</Div>")

    End Sub

End Class
