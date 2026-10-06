Public Class PRO_ProjectClosureDetails
    Inherits WebPages.Template.WhizTemplate

    Private WithEvents m_objMenu As WebPages.Template.StaticMenu

    Protected PRO_ProjectClosureDetails As String
    Private intHelpId As Integer
    Protected intProjectID As String
    Protected strMode As String = ""
    Private strSQLQuery As String = ""
    Private intUserID, intLevel As String
    Protected intAnalysisID As String
    Private drResult As IDataReader
    Private intTagID As String
    Private strFlag As String
    Private strGoals As String = ""
    Private strAssets As String = ""
    Private strArchivals As String = ""
    Private strAction As String = ""
    Private strQueryAnalysis As String = ""
    Protected intResultID As String
    Private m_blnValidate As Boolean = True

    Protected strToken As String   'Added by Yogesh Jalamkar on 19-Aug-2016 for PkToken
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.

        ' ''commented by nilesh g on 31/12/2015 for Security
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
        ' ''end of commented by nilesh g on 31/12/2015 for Security
        InitializeComponent()
        ''Added by Yogesh J on 10-Feb-2016 to validate Token
        'If Request.QueryString("AnalysisID") <> "" And Request.QueryString("PKToken") <> "" And Request.QueryString("ProjectID") <> "" Then
        '    If Request.QueryString("FromWhere") = "PRO" Then
        '        If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("AnalysisID"), String) + CType(Request.QueryString("ProjectID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then
        '            '  Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Process Assetes", 0, 0, "ProjectID", CType(Request.QueryString("ProjectID"), String))
        '            'Token is Invalid now redirect to the Invalid Access Page
        '            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '        End If

        '    End If
        'End If
        ' Added by Yogesh Jalamkar on 19-Aug-2016 for PkToken issue
        If (Request.QueryString("PKToken") IsNot Nothing) Then
            strToken = Request.QueryString("PKToken")
        End If
        'End of addition by Yogesh Jalamkar on 19-Aug-2016 for PkToken issue
        'Added and Commented By Tejal D purpose pk token validation date 13/8/2016 
        If (Request.QueryString("Action") = "PMICALC" Or Request.QueryString("Action") = "ADDISSUE" Or Request.QueryString("Mode") = "ADDCAUS") Then
            m_blnValidate = True
        ElseIf (Request.QueryString("PKToken") = "" And HttpContext.Current.Session("intUserID") <> 0) Then
            m_blnValidate = False
        ElseIf Request.QueryString("AnalysisID").ToString <> "" And Request.QueryString("ProjectID") <> "" Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("AnalysisID"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String) + CType(Request.QueryString("ProjectID"), String), Request.QueryString("PKToken")) = False) Then
                m_blnValidate = False
            End If
        ElseIf Request.QueryString("AnalysisID").ToString <> "" Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("AnalysisID"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then
                m_blnValidate = False
            End If
        End If

        If (m_blnValidate = False) Then
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'End of addition By Tejal D purpose pk token validation date 13/8/2016 
        ''end of cOMMENTED BY nILESH G ON 11/15/2016 Purpose PKToken issue 
        ''End of addition by Yogesh J on on 10-Feb-2016 to validate Token
        PRO_ProjectClosureDetails = MyBase.GetResourceString("PROJECT_TITLE")
    End Sub

#End Region

    Public Sub PageInit()


        '--following are the variables to sotr the data 
        Dim strUserName As String

        '--following are the variables which are uset to process the data in different modes and recordset variable

        Dim strTemp, chkElement As String

        '--Set the values to the variables
        intHelpId = 708

        strUserName = CType(Session("strUserName"), String)
        strMode = Request.QueryString("Mode")
        intProjectID = Request("ProjectID")
        intAnalysisID = Request("AnalysisID")
        strAction = Request("Action")
        intResultID = Request("ResultID")
        'Added by Chetan M on 9th Nov 2020
        If strMode = "CAUANA" Then
            strAction = Request.QueryString("Action")
        End If
        'End of Added by Chetan M on 9th Nov 2020
        Select Case strMode
            Case "SaveGoals"
                '-- Mode is Add Status of Quantitave Goals
                strGoals = Trim(FixString(MyBase.GetFormValue("Goals"), 2000, False, False))
                strFlag = "Goals"
                strSQLQuery = "Exec usp_Ins_PDB_ProjectAnalysisData '" & strFlag & "'," & intAnalysisID & ",'" & strGoals & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
            Case "SaveAssets"
                '-- Mode is Add Assets
                strAssets = Trim(FixString(MyBase.GetFormValue("Assets"), 3000, False, False))
                strFlag = "Assets"
                strSQLQuery = "Exec usp_Ins_PDB_ProjectAnalysisData '" & strFlag & "'," & intAnalysisID & ",'" & strAssets & "'"
                CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
            Case "SaveArchivals"
                '-- Mode is Add information about Archivals
                strArchivals = FixString(MyBase.GetFormValue("Archivals"), 3000, False, False)
                strFlag = "Archivals"
                strSQLQuery = "Exec usp_Ins_PDB_ProjectAnalysisData '" & strFlag & "'," & intAnalysisID & ",'" & strArchivals & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)

            Case "CAUANA"

                strSQLQuery = "EXEC usp_Sel_tbl_PDB_ProjectAnalysis " & intAnalysisID
                drResult = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

                If drResult.Read Then
                    intProjectID = CType(CommonFunctions.Data.CheckIsDBNull(drResult("ProjectID"), ""), String)
                    'intMilestoneID = rsMilestones.Fields("MilestoneID") & ""
                    CommonFunctions.Data.DisposeDataReader(drResult)
                    If strAction = "PMICALC" Then

                        strSQLQuery = "EXEC usp_PDB_PMICalculation_MilestoneAndProjectClosureAnalysis " & intAnalysisID & "," & intProjectID & ",NULL,'" & strUserName & "'"
                        'Response.Write "QUERY " & strSql
                        CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
                    End If
                End If
            Case "ADDCAUS"
                If strAction = "Save" Then
                    strSQLQuery = "EXEC usp_Del_tbl_PDB_Deviation " & intResultID
                    CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)

                    For Each chkElement In Split(Request.Form("chkCause"), ",")
                        'Response.Write(strQueryAnalysis)
                        If chkElement <> "" Then
                            strSQLQuery = "EXEC usp_Ins_tbl_PDB_Deviation " & intResultID & "," & chkElement
                            'drResult = 
                            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
                        End If
                    Next

                End If
        End Select

        DrawMenu()
        ''The main page div started here
        CommonFunctions.General.WriteHTML("<DIV id='PageDiv' style='Overflow:auto;width:100%;Height:460px'><br>")
        DrawPage()
        CommonFunctions.General.WriteHTML("</DIV><br>")
        DrawMenu()
        PostPlotScript()


    End Sub

#Region " Plots the Menu and Section Title"
    Private Sub DrawPage()
        'CommonFunction.General.WriteHTML("<DIV id=divList  style='OVERFLOW:auto; HEIGHT:100%'>")
        Dim strMetricName, intMetricID, intUCL, intLCL, fltActualValue, fltTargetValue As String
        Dim drDeviation As IDataReader
        Dim strTemp As String               'Temporary variable to store the value of TD
        Dim intCauseID, strCause, strPresent As String
        Dim strClsForTR As String() = {"clsTROdd", "clsTREven"}
        Dim intCounterForClass As Integer = 1
        'Added By Usha Pandit On 15.05.2020 to prevent close popup on save
        If Trim(strMode) = "SaveGoals" Then
            strMode = "Goals"
        End If
        If Trim(strMode) = "SaveAssets" Then
            strMode = "Assets"
        End If
        If Trim(strMode) = "SaveArchivals" Then
            strMode = "Archivals"
        End If
        'End Of Added By Usha Pandit On 15.05.2020 to prevent close popup on save
        If Trim(strMode) = "Goals" Then
            strFlag = "Goals"
            strSQLQuery = "Exec usp_Sel_PDB_ProjectAnalysisDetails '" & strFlag & "'," & intAnalysisID & ""
            drResult = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            If drResult.Read Then
                strGoals = CType(CommonFunctions.Data.CheckIsDBNull(drResult("Data"), ""), String)
            End If
            CommonFunction.Data.DisposeDataReader(drResult)
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE class=clsTable cellspacing=0 width='99.9%' style='WIDTH: 100%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<Tr class='clsTREven'>")
            CommonFunction.General.WriteHTML("<TD class=clsTDLabel align=left valign='top' width=25%>")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("STATUS_OF_GOALS"))
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("<Td valign='top' align='left'>")
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ''CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("Goals", "Goals", , , , "frmPRO_ProjectClosureDetails", , , , 80, 3000, strGoals, , "width:94%", , , , , , True, True))
            CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("Goals", "Goals", , , , "frmPRO_ProjectClosureDetails", , , , 80, 3000, strGoals, , "width:94%", , , , , , True, True, EnableHTMLEncode:=True))
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            'CommonFunction.General.WriteHTML("<TEXTAREA  class=clsTextArea Rows=7 cols=65  name='Goals'>" + strGoals + "</TEXTAREA>")
            CommonFunction.General.WriteHTML("</Td>")
            CommonFunction.General.WriteHTML("<Tr>	")
            CommonFunction.General.WriteHTML("</Table>")
        End If

        If Trim(strMode) = "Assets" Then
            '-- To select the data of the assets
            strFlag = "Assets"
            strSQLQuery = "Exec usp_Sel_PDB_ProjectAnalysisDetails '" & strFlag & "'," & intAnalysisID & ""
            drResult = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            If drResult.Read Then
                strAssets = CType(CommonFunctions.Data.CheckIsDBNull(drResult("Data"), ""), String)
            End If
            CommonFunctions.Data.DisposeDataReader(drResult)
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE class=clsTable  cellspacing=0 width='99.9%' style='WIDTH: 100%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<Tr class='clsTREven'>")
            CommonFunction.General.WriteHTML("<TD class=clsTDLabel align=left valign='top' Width=25%>")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("PROCESS_ASSESTS"))
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("<Td valign='top' align='left'>")
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            ''CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("Assets", "Assets", , , , "frmPRO_ProjectClosureDetails", , , , 80, 3000, strAssets, , "width:94%", , , , , , True, True))
            CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("Assets", "Assets", , , , "frmPRO_ProjectClosureDetails", , , , 80, 3000, strAssets, , "width:94%", , , , , , True, True, EnableHTMLEncode:=True))
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            'CommonFunction.General.WriteHTML("<TEXTAREA  class=clsTextArea Rows=7 cols=65  name='Assets'>" + strAssets + "</TEXTAREA>")
            CommonFunction.General.WriteHTML("</Td>")
            CommonFunction.General.WriteHTML("<Tr>	")
            CommonFunction.General.WriteHTML("</Table>")
        End If

        '--To insert the archivals for the selected project 

        If Trim(strMode) = "Archivals" Then
            strFlag = "Archivals"
            strSQLQuery = "Exec usp_Sel_PDB_ProjectAnalysisDetails '" & strFlag & "'," & intAnalysisID & ""
            drResult = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            If drResult.Read Then
                strArchivals = CType(CommonFunctions.Data.CheckIsDBNull(drResult("Data"), ""), String)
            End If
            CommonFunction.Data.DisposeDataReader(drResult)
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE class=clsTable cellspacing=0 width='99.9%' style='WIDTH: 100%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<Tr class='clsTREven'>")
            CommonFunction.General.WriteHTML("<TD class=clsTDLabel align=left valign='top' width=25%>")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("INFO_ARCHIVALS"))
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("<Td valign='top' align='left'>")
            'commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            '' CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("Archivals", "Archivals", , , , "frmPRO_ProjectClosureDetails", , , , 80, 3000, strArchivals, , "width:94%", , , , , , True, True))
            CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextArea("Archivals", "Archivals", , , , "frmPRO_ProjectClosureDetails", , , , 80, 3000, strArchivals, , "width:94%", , , , , , True, True, EnableHTMLEncode:=True))
            'End of commented and Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            'CommonFunction.General.WriteHTML("<TEXTAREA  class=clsTextArea Rows=7 cols=65  name='Archivals'>" + strArchivals + "</TEXTAREA>")
            CommonFunction.General.WriteHTML("</Td>")
            CommonFunction.General.WriteHTML("<Tr>	")
            CommonFunction.General.WriteHTML("</Table>")
        End If
        If strMode = "CAUANA" Then
            strSQLQuery = "EXEC usp_Sel_tbl_PDB_Results_MetricName " & intAnalysisID
            'Response.Write "QUERY "  & strQuery 
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TABLE Class=clsTable cellspacing=0 width='99.9%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TR class=clsTRSectionHeader><TD align = left ><INPUT TYPE = hidden name = hdnProjectID id = hdnProjectID  value =" & intProjectID & "> " + MyBase.GetResourceString("DEVIATION") + "</TD>")
            Response.Write("<TD align = left >" + MyBase.GetResourceString("CAUSES") + "</TD>")
            Response.Write("<TD align = left > </TD>")
            Response.Write("</TR>")

            drResult = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

            If drResult.Read Then
                Do
                    intCounterForClass = intCounterForClass + 1
                    strMetricName = CType(CommonFunctions.Data.CheckIsDBNull(drResult("MetricName"), ""), String)
                    intMetricID = CType(CommonFunctions.Data.CheckIsDBNull(drResult("ProjectPMI_MetricID"), ""), String)
                    intUCL = CType(CommonFunctions.Data.CheckIsDBNull(drResult("Above"), ""), String)
                    intLCL = CType(CommonFunctions.Data.CheckIsDBNull(drResult("Below"), ""), String)
                    fltActualValue = CType(CommonFunctions.Data.CheckIsDBNull(drResult("ActualValue"), ""), String)
                    fltTargetValue = CType(CommonFunctions.Data.CheckIsDBNull(drResult("TargetValue"), ""), String)
                    intResultID = CType(CommonFunctions.Data.CheckIsDBNull(drResult("ResultID"), ""), String)

                    If fltTargetValue = "" Then
                        fltTargetValue = "0"
                    End If
                    If fltActualValue = "" Then
                        fltActualValue = "0"
                    End If

                    Response.Write("<TR valign = top class =" + strClsForTR(intCounterForClass Mod 2) + "><TD align = left valign = top><B>" & strMetricName & "</B><BR>  Norms (" & intLCL & " - " & intUCL & ")<BR> Target = " & FormatNumber(fltTargetValue, 2) & " <BR>Actual Value = " & FormatNumber(fltActualValue, 2) & " </TD>")


                    strQueryAnalysis = "Exec usp_Sel_GetDeviationCauses " & intResultID & ",'P'"
                    drDeviation = CommonFunction.Data.GetDataReader(strQueryAnalysis, MyBase.UseSQL)

                    If drDeviation.Read Then
                        Do
                            If CType(CommonFunctions.Data.CheckIsDBNull(drDeviation("Present"), ""), String) = "True" Then
                                strTemp = strTemp & CType(CommonFunctions.Data.CheckIsDBNull(drDeviation("Cause"), "0"), String) & "<BR>"
                            End If
                            'strTemp = strTemp 
                        Loop While drDeviation.Read
                        CommonFunction.Data.DisposeDataReader(drDeviation)
                    Else
                        strTemp = ""
                    End If

                    'Response.Write "<TR><TD class = clsTdODD align = left valign = top><B>" & strMetricName &"</B> = " & fltActualValue & "  Range(" & intLCL  & "-" & intUCL & ")  Target =" & fltTargetValue & "</TD>"
                    Response.Write("<TD align = left >" & strTemp & "</TD>")
                    strTemp = ""
                    Response.Write("<TD align = left ><A HREF = 'JavaScript:AddCauses(" & intResultID & ")'>" + MyBase.GetResourceString("ADD_CAUSES") + "</A></TD></TR>")
                Loop While drResult.Read
            Else
                Response.Write("<TR class=" + strClsForTR(intCounterForClass Mod 2) + "><TD align=center colspan = 3>" + MyBase.GetResourceString("NO_ITEMS") + "</TD></TR>	")
            End If
            Response.Write("</table>")
        End If

        CommonFunction.Data.DisposeDataReader(drResult)

        If strMode = "ADDCAUS" Then
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Response.Write("<TABLE Class=clsTable cellspacing=0 width='99.9%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            intCounterForClass = 1
            Response.Write("<TR class=clsTRSectionHeader><TD align = left >" + MyBase.GetResourceString("CAUSES") + "</TD>")
            Response.Write("<TD align = left ></TD>")
            Response.Write("</TR>")

            strSQLQuery = "EXEC usp_Sel_GetDeviationCauses " & intResultID & ",'P'"
            drResult = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

            If drResult.Read Then
                Do
                    intCounterForClass = intCounterForClass + 1
                    intCauseID = CType(CommonFunctions.Data.CheckIsDBNull(drResult("CauseID"), ""), String)
                    strCause = CType(CommonFunctions.Data.CheckIsDBNull(drResult("Cause"), ""), String)
                    strPresent = CType(CommonFunctions.Data.CheckIsDBNull(drResult("Present"), ""), String)
                    Response.Write("<TR class= " + strClsForTR(intCounterForClass Mod 2) + "><TD align = left >" & strCause & "</TD>")
                    'Response.Write "<TD class = clsTdODD align = left ><A HREF = 'JavaScript:AddCauses(" & intResultID & ")'>Add Causes</A></TD></TR>"

                    If strPresent = "False" Then
                        Response.Write("<TD align = middle ><INPUT Type = checkbox  id = chkCause name = chkCause value =" & intCauseID & "></TD></TR>")
                    Else
                        Response.Write("<TD align = middle ><INPUT Type = checkbox  id = chkCause name = chkCause CHECKED value =" & intCauseID & " ></TD></TR>")
                    End If

                Loop While drResult.Read
            Else
                Response.Write("<TR class = " + strClsForTR(intCounterForClass Mod 2) + "><TD align=center colspan = 2>" + MyBase.GetResourceString("NO_ITEMS") + "</TD></TR>	")
            End If
            CommonFunction.Data.DisposeDataReader(drResult)
            Response.Write("</TABLE>")

        End If

    End Sub
    Private Sub DrawMenu()
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrasannaP
        ' Created               : Feb 25, 2004
        ' Revisions             :
        '=====================================================================


        Dim arrMenuCaptionsList As New ArrayList        'Stores the captions of the Menu
        Dim arrMenuToolTipsList As New ArrayList        'Stores the Tooltips of the Menu items
        Dim arrClientSideFunctionList As New ArrayList  'Stores the client side function name for the menu item
        Dim strMenu As String = ""                      'Used to store the Menu List as HTML
        Dim strTitle As String = ""                     'Used to store the title of the page
        Dim strPageAlphabets As String = ""             'Stores paging alphabets in this var

        If strMode = "CAUANA" Then
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CALCULATE_PMI"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("TOOLTIP_CALCULATE_PMI"))
            arrClientSideFunctionList.Add("CalculatePMI('" + CStr(intAnalysisID) + "')")

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_BACK"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_BACK"))
            arrClientSideFunctionList.Add("Back_OnClick('" + CStr(intProjectID) + "')")
        Else
            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE"))
            arrClientSideFunctionList.Add("SaveOnClick()")

            arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
            arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
            arrClientSideFunctionList.Add("Close_OnClick()")
        End If
        arrMenuCaptionsList.Add("?")
        arrMenuToolTipsList.Add(MyBase.GetResourceString("TOOLTIP_MENU_HELP"))
        arrClientSideFunctionList.Add("Help_OnClick('" + CStr(intHelpId) + "')")

        m_objMenu = New WebPages.Template.StaticMenu

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)

        ''Setting the objects to nothing
        arrMenuCaptionsList = Nothing
        arrClientSideFunctionList = Nothing
        arrMenuToolTipsList = Nothing

        CommonFunctions.General.WriteHTML(strMenu)

    End Sub
#End Region

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
        ' Author                : PrasannaP
        ' Created               : Feb 24, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function


    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PRO_ProjectClosureDetails", "AppResources")
    End Sub

    Private Sub PostPlotScript()
        If strMode = "SaveGoals" Or strMode = "SaveAssets" Or strMode = "SaveArchivals" Then
            CommonFunction.General.WriteHTML("<script language = javascript>")
            'Commented By Usha Pandit On 15.05.2020 to prevent close popup on save
            'CommonFunction.General.WriteHTML("window.close()")
            'End Of Commented By Usha Pandit On 15.05.2020 to prevent close popup on save
            CommonFunction.General.WriteHTML("</script>")
        ElseIf strMode = "ADDCAUS" And strAction = "Save" Then

            strSQLQuery = "EXEC usp_Sel_tbl_PDB_Results " & intResultID
            drResult = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

            If drResult.Read Then
                intAnalysisID = CType(CommonFunctions.Data.CheckIsDBNull(drResult("AnalysisID"), ""), String)
            End If
            CommonFunction.Data.DisposeDataReader(drResult)
            CommonFunction.General.WriteHTML("<SCRIPT LANGUAGE='JavaScript'>")

            CommonFunction.General.WriteHTML("window.opener.frmPRO_ProjectClosureDetails.action = 'PRO_ProjectClosureDetails.aspx?Mode=CAUANA&AnalysisID=" + CStr(intAnalysisID) + "';")
            CommonFunction.General.WriteHTML("//alert('ACTION ' + window.opener.frmMilestones.action )")
            CommonFunction.General.WriteHTML("window.opener.frmPRO_ProjectClosureDetails.submit();")
            'Commented By Usha Pandit On 15.05.2020 to prevent close popup on save
            'CommonFunction.General.WriteHTML("window.close(); ")
            'End Of Commented By Usha Pandit On 15.05.2020 to prevent close popup on save
            CommonFunction.General.WriteHTML("</SCRIPT>")
        End If
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

End Class
