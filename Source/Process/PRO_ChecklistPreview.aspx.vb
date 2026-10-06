Public Class PRO_ChecklistPreview
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form DesigneAnswer Options r.
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

#Region "CSPL Code Header"
    '**********************************************************************************
    '                  CSPL Code Header
    ' Project Name     :	PBNITE
    ' Module Name      :	PRO_CheckListPreview.aspx
    ' Purpose          :	Show Preview of Check List
    ' Description      :	Same as above
    ' Assumptions      :	The stored procedures, and tables are present.
    ' Dependencies     :	
    ' Author           :	AmitD
    ' Reviewed         :	
    ' Tested           :	
    ' Created          :	31 Aug 2004
    ' Revisions        :	
    '**********************************************************************************
#End Region

#Region "Declaration of Variables"

    Private strSQLQuery As String
    Private intQuestionnaireID As Integer
    Private strMenu As String                           'stores the static menu string.
    Private intTempQuestionID As Integer
    Private strQuestionnaire As String
    Private strBtnName As String
    Private strQuestionWithOption As String
    Private strSingleSelectionWtCheckBox As String
    Private intCheckBoxCount As Integer
    Private strQuestionDescription As String
    Private blnComment As Boolean
    'Addition done by SuchitraP on 2-Jul-2007 for IssueID 12334
    Protected isblnShowNote As Boolean
    'End By SuchitraP on 2-Jul-2007

    Protected m_strWindowTitle As String
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu    'This variable is used for plotting static menu. 

#End Region

#Region "Page Load Functions"

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_strWindowTitle = MyBase.GetResourceString("TITLE_CHECKLIST_PREVIEW")
    End Sub

    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PRO_ChecklistPreview", "AppResources")

    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : the main function to initialize the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Aug 31 , 2004
        ' Revisions             :
        '=====================================================================

        intCheckBoxCount = 1
        '=====================================================================
        ' Get the QuestionnaireID
        '=====================================================================
        If Trim(Request.QueryString("QuestionnaireID")) <> "" Then
            intQuestionnaireID = CType(Trim(Request.QueryString("QuestionnaireID")), Integer)
        Else
            intQuestionnaireID = 0
        End If

        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        DrawQuestionnaireQuestionlist()

        'Uncommented by SuchitraP on 6-Jul-2007
        'CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;'>")
        CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;'>")

        'CommonFunctions.General.WriteHTML("</DIV>")
        CommonFunctions.General.WriteHTML("</DIV>")
        'End of uncomment by SuchitraP on 6-Jul-2007

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")


    End Sub
#End Region

#Region "Draw Menu"
    Public Sub DrawMenu()
        Dim arrMenuList As New ArrayList
        Dim arrMenuToolTipList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strGrid As String

        arrMenuList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        arrClientSideFunctionList.Add("Close_OnClick()")

        arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctionList.Add("Help_OnClick('2160')")

        'Create the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipList), True)

    End Sub
#End Region

#Region "General Functions"

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    

#End Region

#Region "Draw List"

    Public Sub DrawQuestionnaireQuestionlist()

        Dim drGetQuestionireList As IDataReader
        Dim intCounter As Integer
        Dim intNextSectionId As Integer
        Dim intPrevSectionId As Integer
        Dim intSrNo As Integer
        Dim strClass As String
        Dim strQuestionnaire As String
        Dim intQuestionOptionID As Integer
        Dim blnIncluded As Boolean
        Dim blnSectionChange As Boolean

        strSQLQuery = "Exec usp_Q_GetQuestionnaireDetailList " & CType(intQuestionnaireID, String)
        drGetQuestionireList = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        '##### Drawing Table for Displaying Header
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TABLE CellSpacing=0 class='clsTable' Border=0 width='99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TR><TD width='50%' class='clsTDSortColHeader' align=left>&nbsp;" & MyBase.GetResourceString("TITLE_CHECKLIST_PREVIEW"))
        CommonFunctions.General.WriteHTML("</TD></TR></TABLE><br>")
        '##### End

        If drGetQuestionireList.Read() Then
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TABLE CellSpacing=0 class='clsTable' width='99.9%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TR class='clsTRPageHeader'>")
            CommonFunctions.General.WriteHTML("<TD align='left' width='20%'>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("TITLE_CHECKLIST"))
            CommonFunctions.General.WriteHTML("</TD><TD width'80%'>")
            CommonFunctions.General.WriteHTML(CType(drGetQuestionireList("QuestionnaireName"), String))
            CommonFunctions.General.WriteHTML("</TD></TR>")
            CommonFunctions.General.WriteHTML("<TR class='clsTRPageHeader'>")
            CommonFunctions.General.WriteHTML("<TD align='left' width='20%'>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("TITLE_DESCRIPTION"))
            CommonFunctions.General.WriteHTML("</TD><TD width='80%'>")
            CommonFunctions.General.WriteHTML(CType(drGetQuestionireList("Description"), String))
            CommonFunctions.General.WriteHTML("</TD></TR>")
            CommonFunctions.General.WriteHTML("</TABLE><BR>")
            'Addition done by SuchitraP on 2-Jul-2007 for IssueID 12334
            'Purpose:To show note that specifies bold values indicate negative values
            CommonFunctions.General.WriteHTML("<TABLE CellSpacing=0 class='clsTable' width='99.9%'>")
            CommonFunctions.General.WriteHTML("<TR class='clsTRPageHeader'>")
            CommonFunctions.General.WriteHTML("<TD id='tdNote' align='Left'>Note:Answer options in BOLD characters represent negative Answer options</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            CommonFunctions.General.WriteHTML("</TABLE><BR>")
            'End by SuchitraP on 2-Jul-2007 for IssueID 12334

            CommonFunctions.General.WriteHTML("<DIV ID=DivList Style='HEIGHT: 450px; OVERFLOW:auto;WIDTH:100%'>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TABLE CellSpacing=0 class='clsTable' width='99.9%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TR class='clsTRColumnHeader'><TD align='left' nowrap width='10%'>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("HEADING_SR"))
            CommonFunctions.General.WriteHTML("</TD><TD align='left' nowrap width='50%'>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("HEADING_CHECKLIST_ITEM"))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD align='left' width='40%'>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("HEADING_ANSWER_OPTIONS"))
            CommonFunctions.General.WriteHTML("</TD></TR>")

            'End If
            'CommonFunction.Data.DisposeDataReader(drGetQuestionireList)

            'strSQLQuery = "Exec usp_Q_GetQuestionnaireDetailList " & CType(intQuestionnaireID, String)
            'drGetQuestionireList = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)


            ''Code Modified By SantoshK
            ''Date 7 Sept 2004
            ''Problem while displaying first Option
            ' If drGetQuestionireList.Read Then
            intCounter = 1
            intPrevSectionId = 0
            intSrNo = 0
            blnIncluded = False

            intTempQuestionID = CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("QuestionnaireQuestionID"), "0"), Integer)
        Else

            CommonFunctions.General.WriteHTML("<tr class=clsTROdd>")
            CommonFunctions.General.WriteHTML("<td align=center colspan=3>There are no items to show in this view.</td>")
            CommonFunctions.General.WriteHTML("</tr>")

        End If

        CommonFunction.Data.DisposeDataReader(drGetQuestionireList)
        'Modification Ends


        strSQLQuery = "Exec usp_Q_GetQuestionnaireDetailList " & CType(intQuestionnaireID, String)
        drGetQuestionireList = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        blnSectionChange = False

        While drGetQuestionireList.Read()
            intNextSectionId = CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("CaytegoryID"), "0"), Integer)
            '--Display the section for checklist items
            If intNextSectionId <> intPrevSectionId Then

                If intSrNo > 0 Or blnSectionChange = True Then
                    intSrNo = intSrNo + 1

                    'If intSrNo Mod 2 = 0 Then
                    If intCounter Mod 2 = 0 Then
                        strClass = "clsTREven"
                    Else
                        strClass = "clsTROdd"
                    End If

                    blnSectionChange = False
                    '--- Display the questions and options in the table.
                    strQuestionnaire = strQuestionnaire & "<TR class=" & strClass & ">"

                    '--- Display Column Sr. No.
                    strQuestionnaire = strQuestionnaire & "<TD align=center valign=Top>" & intSrNo & "</TD>"

                    '--- Display column for Question and its option
                    strQuestionnaire = strQuestionnaire & "<TD align=left>" & strQuestionDescription & "</TD>"

                    '--- Displaying the options for the above question with respect to the
                    '--- Parameters assigned for the question for eg. Question type-Single selection,
                    strQuestionnaire = strQuestionnaire & "<TD align=left>" & strQuestionWithOption & "</TD>"

                    '--- multiple selection etc.
                    strQuestionDescription = ""
                    strQuestionWithOption = ""
                    strSingleSelectionWtCheckBox = ""
                    blnComment = False
                    strQuestionnaire = strQuestionnaire & "</TR>"
                    blnIncluded = True

                End If

                strQuestionnaire = strQuestionnaire & "<TR class='clsTRSectionHeader'>"
                strQuestionnaire = strQuestionnaire & "<TD align='left' COLSPAN=3>"
                strQuestionnaire = strQuestionnaire & CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("CategoryDesc"), "0"), String)
                strQuestionnaire = strQuestionnaire & "</TD></TR>"
                intPrevSectionId = intNextSectionId
                strClass = "clsTROdd"
                intCounter = 1
                blnSectionChange = True




            End If

            If intTempQuestionID <> CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("QuestionnaireQuestionID"), "0"), Integer) Then
                intTempQuestionID = CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("QuestionnaireQuestionID"), "0"), Integer)

                If blnIncluded = False Then
                    intSrNo = intSrNo + 1

                    'If intSrNo Mod 2 = 0 Then
                    If intCounter Mod 2 = 0 Then
                        strClass = "clsTREven"
                    Else
                        strClass = "clsTROdd"
                    End If


                    '--- Display the questions and options in the table.
                    strQuestionnaire = strQuestionnaire & "<TR class=" & strClass & ">"

                    '--- Display Column Sr. No.
                    strQuestionnaire = strQuestionnaire & "<TD align=center valign=Top>" & intSrNo & "</TD>"

                    '--- Display column for Question and its option
                    strQuestionnaire = strQuestionnaire & "<TD align=left>" & strQuestionDescription & "</TD>"

                    '--- Displaying the options for the above question with respect to the
                    '--- Parameters assigned for the question for eg. Question type-Single selection,
                    strQuestionnaire = strQuestionnaire & "<TD align=left>" & strQuestionWithOption & "</TD>"

                    '--- multiple selection etc.
                    strQuestionDescription = ""
                    strQuestionWithOption = ""
                    strSingleSelectionWtCheckBox = ""
                    blnComment = False

                    strQuestionnaire = strQuestionnaire & "</TR>"


                End If

                blnIncluded = False

                
                '--- Generate the string for questions and options
                '--- Generate the string for Question and its realated option with the respective control
                '--- (option btn / check box)
                'strQuestionDescription = CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("QuestionDescription"), "0"), String)
                'Commented added by Shamkant s on 4 Dec2015 
                strQuestionDescription = HttpUtility.HtmlEncode(CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("QuestionDescription"), "0"), String))
                'Ended Shamkant s on 4  Dec 2015
                blnComment = CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("ShowComment"), "0"), Boolean)

                '--- Append the Option to the question
                If CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("SingleSelection"), "0"), Boolean) = True Then
                    '--- Set the radio button to the option.
                    strBtnName = "optOption" & intTempQuestionID
                    intQuestionOptionID = CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("QuestionnaireOptionID"), "0"), Integer)
                    strQuestionWithOption = strQuestionWithOption & "<INPUT id=" & strBtnName & _
                    " name=" & strBtnName & " type=radio value='" & intQuestionOptionID & "'>"
                    '--- Set option description
                    If CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("IsNegative"), "0"), Boolean) Then
                        'Addition done by SuchitraP on 6-Jul-2007 for IssueID 12334
                        'Purpose:To show note that specifies Bold Values indicates negative values
                        isblnShowNote = True
                        'End of addition done by SuchitraP on 6-Jul-2007 for IssueID 12334

                        strQuestionWithOption = strQuestionWithOption & "<B>" & CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("OptionDescription"), "0"), String) & "</b>"
                    Else
                        strQuestionWithOption = strQuestionWithOption & CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("OptionDescription"), "0"), String)
                    End If

                    strBtnName = ""
                    intQuestionOptionID = 0

                ElseIf CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("MultipleSelection"), "0"), Boolean) = True Then

                    '--- Set the check boxes to the option.
                    strBtnName = "chkOption" & intTempQuestionID
                    intQuestionOptionID = CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("QuestionnaireOptionID"), "0"), Integer)
                    strQuestionWithOption = strQuestionWithOption & "<INPUT id=" & strBtnName & _
                    " name=" & strBtnName & " type=checkbox value='" & intQuestionOptionID & "'" & _
                    " >"
                    '--- Set option description
                    strQuestionWithOption = strQuestionWithOption & CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("OptionDescription"), "0"), String) & "&nbsp;&nbsp;" '& " - " & CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("QuestionnaireOptionID"), "0"), Integer)
                    strBtnName = ""
                    intQuestionOptionID = 0

                ElseIf CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("SingleSelectionWithCheckBox"), "0"), Boolean) = True Then
                    strQuestionWithOption = ""
                    strBtnName = "chkOption" & intTempQuestionID
                    intQuestionOptionID = CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("QuestionnaireOptionID"), "0"), Integer)
                    strSingleSelectionWtCheckBox = "<INPUT id=" & strBtnName & " name=" & strBtnName & " type=checkbox value='" & intQuestionOptionID & "'" & " >"
                    strBtnName = ""
                    intQuestionOptionID = 0

                End If

                intCounter = intCounter + 1

            Else
               
                
                '--- Generate the string for Question and its related option with the respective control
                '--- (option btn / check box)
                'strQuestionDescription = CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("QuestionDescription"), "0"), String)
                'Commentd added by Shamkant S on 4 Dec 2015
                strQuestionDescription = HttpUtility.HtmlEncode(CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("QuestionDescription"), "0"), String))
                'Ended by Shamkant S on Dec 2015
                blnComment = CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("ShowComment"), "0"), Boolean)

                '--- Append the Option to the question
                If CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("SingleSelection"), "0"), Boolean) = True Then
                    '--- Set the radio button to the option.
                    strBtnName = "optOption" & intTempQuestionID
                    intQuestionOptionID = CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("QuestionnaireOptionID"), "0"), Integer)
                    strQuestionWithOption = strQuestionWithOption & "<INPUT id=" & strBtnName & _
                    " name=" & strBtnName & " type=radio value='" & intQuestionOptionID & "'" & _
                    " >"

                    If CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("IsNegative"), "0"), Boolean) Then
                        'Addition done by SuchitraP on 6-Jul-2007 for IssueID 12334
                        'Purpose:To show note that specifies Bold Values indicates negative values
                        isblnShowNote = True
                        'End of addition done by SuchitraP on 6-Jul-2007 for IssueID 12334

                        strQuestionWithOption = strQuestionWithOption & "<B>" & CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("OptionDescription"), "0"), String) & "</b>"
                    Else
                        strQuestionWithOption = strQuestionWithOption & CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("OptionDescription"), "0"), String)
                    End If
                    '--- Set option description
                    strBtnName = ""
                    intQuestionOptionID = 0

                ElseIf CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("MultipleSelection"), "0"), Boolean) = True Then
                    '--- Set the check boxes to the option.
                    strBtnName = "chkOption" & intTempQuestionID
                    intQuestionOptionID = CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("QuestionnaireOptionID"), "0"), Integer)
                    strQuestionWithOption = strQuestionWithOption & "<INPUT id=" & strBtnName & _
                    " name=" & strBtnName & " type=checkbox value='" & intQuestionOptionID & "'" & _
                    " >"
                    '--- Set option description
                    strQuestionWithOption = strQuestionWithOption & CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("OptionDescription"), "0"), String) & "&nbsp;&nbsp;" '& " - " & CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("QuestionnaireOptionID"), "0"), Integer)
                    strBtnName = ""
                    intQuestionOptionID = 0

                ElseIf CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("SingleSelectionWithCheckBox"), "0"), Boolean) = True Then
                    strQuestionWithOption = ""
                    strBtnName = "chkOption" & intTempQuestionID
                    intQuestionOptionID = CType(CommonFunction.Data.CheckIsDBNull(drGetQuestionireList("QuestionnaireOptionID"), "0"), Integer)
                    strSingleSelectionWtCheckBox = "<INPUT id=" & strBtnName & " name=" & strBtnName & " type=checkbox value='" & intQuestionOptionID & "'" & " >"
                    strBtnName = ""
                    intQuestionOptionID = 0

                End If

            End If

        End While

        intCounter = intCounter + 1

        If intTempQuestionID <> 0 Then

            intSrNo = intSrNo + 1
            'If intSrNo Mod 2 = 0 Then
            If intCounter Mod 2 = 0 Then
                strClass = "clsTREven"
            Else
                strClass = "clsTROdd"
            End If

            strQuestionnaire = strQuestionnaire & "<TR class=" & strClass & ">"
            '--- Display Column Sr. No.
            strQuestionnaire = strQuestionnaire & "<TD align=center>" & intSrNo & "</TD>"
            '--- Display column for Question and its option
            strQuestionnaire = strQuestionnaire & "<TD align=left>" & strQuestionDescription & "</TD>"
            strQuestionnaire = strQuestionnaire & "<TD align=Left>" & strQuestionWithOption & "</TD>"

            strQuestionDescription = ""
            strQuestionWithOption = ""
            strSingleSelectionWtCheckBox = ""
            strQuestionnaire = strQuestionnaire & "</TR>"

            CommonFunctions.General.WriteHTML(strQuestionnaire)
        End If


        CommonFunctions.General.WriteHTML("</TABLE>")
        CommonFunctions.General.WriteHTML("</DIV>")

        CommonFunction.Data.DisposeDataReader(drGetQuestionireList)
    End Sub
#End Region

End Class
