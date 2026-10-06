
Imports CommonEngines.General.cEventHandlers

Public Class Test_Section_Grid_CommonList
    Inherits CommonList
    Protected strCurrentTestSetID As String
    'Public m_sbValidationScript1 As New System.Text.StringBuilder
    ' Public m_sbValidationScript1 As New System.Text.StringBuilder
    'Public m_CheckboxIDs As String = ""
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cTest_Section_Grid_CommonList(MyBase.m_objGlobal)
        'dim 1 as New  cTest_Section_Grid_CommonList
        ' m_sbValidationScript1 = CType(New cTest_Section_Grid_CommonList(MyBase.m_objGlobal), System.Text.StringBuilder)
    End Function
    Public Class cTest_Section_Grid_CommonList
        Inherits CommonEngine.CommonList.cPlotGrid
        Protected m_sbValidationScript As String
        Dim m_strprevsection As String
        'Dim m_strprevsectionID As String
        Dim m_intCount As Integer
        Dim m_strsectionheader As String
        Dim m_CheckboxIDs As String
        Dim m_strTestCaseIDs As String
        Dim strstrTestCaseIdBox As String



        Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            Call MyBase.New(WhizGlobal)
            m_strprevsection = ""
            'm_strprevsectionID = ""
            m_strsectionheader = ""
            m_CheckboxIDs = ""

        End Sub
        Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
            If Args.ColumnName.ToUpper = "DELETE" Then
                Args.ColumnName = "Select"
            End If
        End Sub

        Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
            Dim strTestSection As String = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestSection")))
            Dim strTestSectionID As String = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestSectionID")))
            Dim strSectionID As String = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestSectionID")))
            ' Dim strchkboxname As String = "chkSection" + strTestSection
            Dim strchkboxname As String = "chk" + strSectionID
            Dim strTestCaseId As String = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestCaseID")))
            Dim strTestCasechkBox As String
            Dim strSQL As String
            Dim drtestsection As IDataReader
            Dim obj_m_sbValidationScript As New Test_Section_Grid_CommonList
            '  m_sbValidationScript = ""

            'Args.StringToBeInserted = "<tr class=clsTRSectionHeader>"
            If Args.ColumnName.ToUpper = "TEST SECTION" Then
                'Args.StringToBeInserted = "<tr class=clsTRSectionHeader>"
                If strTestSection <> m_strprevsection Then
                    ' Args.StringToBeInserted = "<tr class=clsTRSectionHeader>"
                    m_intCount = 0
                    'm_intCount = m_intCount + 1

                    'strchkboxname = "chk" + strSectionID '+ "_" + CType(m_intCount, String)
                    'Date 14 Dec 2006
                    strchkboxname = "chkSection" + strSectionID '+ "_" + CType(m_intCount, String)


                    Cancel = True
                    Args.StringToBeInserted = "<tr class=clsTRSectionHeader>"
                    Args.StringToBeInserted += "<td align='left' >" + strTestSection + "</TD>"
                    Args.StringToBeInserted += "<td align='left' > </td>"
                    'Args.StringToBeInserted += " <td align='left' > </td><td align='CENTER' width=10%><input type='checkbox' align='center' id='" + strchkboxname + "' name='" + strchkboxname + "' value='" + strTestSection + "' onclick='javascript:CheckTestCases(" + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestSectionID"), "0"), String) + "," + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestCaseCount"), "0"), String) + ")'> </td>"
                    'm_strTestCaseIDs = "171-172-"
                    m_strTestCaseIDs = ""
                    Dim count As Integer = 1
                    ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
                    ''strSQL = "select TESTCASEID  from tbl_Tcm_TestCaseDetails where testSectionID=" & strSectionID.ToString
                    strSQL = "usp_sel_tbl_Tcm_TestCaseDetails_TESTCASEID " & strSectionID.ToString

                    drtestsection = CommonFunctions.Data.GetDataReader(strSQL, True)
                    While drtestsection.Read
                        If count = 0 Then
                            m_strTestCaseIDs = CType(drtestsection.Item("TESTCASEID").ToString, String)
                        Else
                            m_strTestCaseIDs = m_strTestCaseIDs + "-" + CType(drtestsection.Item("TESTCASEID").ToString, String)
                        End If
                        count = 1
                    End While
                    Args.StringToBeInserted += " <td align='left' > </td><td align='CENTER' width=10%><input type='checkbox' align='center' id='" + strchkboxname + "' name='" + strchkboxname + "' value='" + strSectionID + "' onclick='javascript:CheckTestCases(" + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestSectionID"), "0"), String) + "," + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestCaseCount"), "0"), String) + ",""" + CType(m_strTestCaseIDs, String) + """)'> </td>"


                    ' m_sbValidationScript1 = "CheckTestCases(" + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestSectionID"), "0"), String) + "," + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestCaseCount"), "0"), String) + ",""" + CType(m_strTestCaseIDs, String) + """)" + vbCrLf

                    ' m_sbValidationScript.Append(vbCrLf + "CheckTestCases(" + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestSectionID"), "0"), String) + "," + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestCaseCount"), "0"), String) + ",""" + CType(m_strTestCaseIDs, String) + """)" + vbCrLf)
                    m_sbValidationScript += "CheckTestCases(" + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestSectionID"), "0"), String) + "," + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestCaseCount"), "0"), String) + ",""" + CType(m_strTestCaseIDs, String) + """)" + vbCrLf



                    'Args.StringToBeInserted += "<tr><td></td>"

                    Args.StringToBeInserted += "</TR><tr class='clsTREvenRow'><td></td>"

                    m_strprevsection = strTestSection
                    'm_strprevsectionID = strTestSectionID
                Else
                    Cancel = True
                    m_intCount = m_intCount + 1
                    Args.StringToBeInserted = "<td></td>"
                End If
            End If
            If Args.ColumnName.ToUpper = "DELETE" Then
                'Dim OBJ As New Test_Section_Grid_CommonList
                Cancel = True
                Args.IgnoreActualValue = True
                'Changes By PradipK 
                'strTestCasechkBox = CStr("chk" + CStr(strSectionID) + "_" + CStr(m_intCount))
                strTestCasechkBox = CStr("chk" + CStr(strSectionID)) ' + "_" + CStr(strTestCaseId))
                strstrTestCaseIdBox = CStr("chk" + CStr(strTestCaseId)) ' + "_" + CStr(strTestCaseId))

                Args.StringToBeInserted = " <td align='CENTER' width=10%><input type='checkbox' align='center' id='" + strTestCasechkBox + "' name='" + strstrTestCaseIdBox + "' value='" + strTestCaseId + "'> </td> "

                If (m_CheckboxIDs <> "") Then
                    m_CheckboxIDs &= "," + strTestCasechkBox
                Else
                    m_CheckboxIDs = strTestCasechkBox
                End If
            End If
            'Return m_sbValidationScript
        End Sub




        Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
            If Not m_strsectionheader = CStr(Args.DataReader("TestSection")) Then
                Args.StringToBeInserted = "<tr class=cldTRSectionHeader>"
            End If
            m_strsectionheader = CStr(Args.DataReader("TestSection"))
        End Sub


        Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidValidation", "txthidValidation", , , , CType(m_sbValidationScript, String), , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End Sub

        Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
            Dim strSQL As String = Args.GridSQL
            Dim m_intIndex As Integer = strSQL.IndexOf("TestSetID =", 0)
            'If string left found then
            If m_intIndex > 0 Then

            Else
                strSQL = strSQL.Replace("ORDER", " AND 1<>1  ORDER ")
                Args.GridSQL = strSQL
            End If
        End Sub
    End Class

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "Test_Section_Grid_CommonList.aspx"
        MyBase.strFormPage = "Test_Section_Grid_CommonPage.aspx"
        ' MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function



    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        ' Modified By MahendraV On 9:34 AM 6/29/2007
        ' Database update need to be moved in WhizForm_Init due to DataSet Related Changes For Whiziblesem 7
        ' Commented code moved from PageListPreRender To WhizForm_Init
        ' Start_MV_6/29/2007
        Dim flag As Boolean = True
        Dim FL As Boolean = False
        Dim strSQL As String
        Dim strTestSetcmbvalue As String
        Dim strTestSectionId As String
        Dim drtestsection As IDataReader
        Dim strchkboxname As String
        ' Dim strSelectedSectionID As String
        'Dim strSelectedCaseID As String
        Dim strCaseID As String
        'Dim strSelectCaseIDs As String
        'Dim strSelectCaseID As String
        'Dim strSqlQuery As String
        Dim drtestcase As IDataReader
        'Dim drInsertCase As IDataReader
        Dim strtestcaseid As String
        Dim strcasechkboxname As String
        Dim i As Integer
        'Dim blnSectionChk As Boolean
        'Dim Count As Integer
        Dim strScript As String
        If CommonFunction.General.CheckIsNothing(Request.QueryString("TestSetID"), "0") <> "0" Then
            strCurrentTestSetID = CType(HttpContext.Current.Request.QueryString("TestSetID"), String)
        End If

        If HttpContext.Current.Request.QueryString("SetFilter") = "1" Then
            strCurrentTestSetID = Request.Form("txthidCuttentTestCaseID").ToString
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCuttentTestCaseID", "txthidCuttentTestCaseID", , , , strCurrentTestSetID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15

        Else
            strCurrentTestSetID = CType(HttpContext.Current.Request.QueryString("TestSetID"), String)
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCuttentTestCaseID", "txthidCuttentTestCaseID", , , , strCurrentTestSetID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If

        If HttpContext.Current.Request.QueryString("Save") = "True" Then
            strTestSetcmbvalue = CStr(HttpContext.Current.Request.Form("TestSetID"))
            If strTestSetcmbvalue <> "" Then

                ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
                ''strSQL = "select TESTCASEID   from tbl_Tcm_TestCaseDetails  WHERE IsNULL(TestSectionID,0)=0  AND  TestSetID=" & strTestSetcmbvalue
                strSQL = "usp_sel_tbl_Tcm_TestCaseDetails_TESTCID " & strTestSetcmbvalue
                drtestcase = CommonFunctions.Data.GetDataReader(strSQL, True)
                strCaseID = ""
                'strSelectedCaseID = ""

                While drtestcase.Read
                    strtestcaseid = CStr(CommonFunctions.General.CheckIsNothing(drtestcase("TESTCASEID")))
                    strchkboxname = "chk" + strtestcaseid
                    strCaseID = HttpContext.Current.Request.Form(strchkboxname)
                    If strCaseID = "" Then
                        flag = False
                    End If
                    If strCaseID <> "" Then
                        FL = True
                        'blnSectionChk = True
                        'If Count = 0 Then
                        '    strSelectedCaseID = strCaseID
                        'Else
                        '    strSelectedCaseID = strSelectedCaseID + "," + strCaseID
                        'End If
                        'Count = 1

                    End If
                End While

                CommonFunction.Data.DisposeDataReader(drtestcase)
                'If blnSectionChk = True Then
                '    strSQL = "EXEC usp_sel_AddExistingTestCase  " & strCurrentTestSetID & ",0,' " & strSelectedCaseID & "'"
                '    drInsertCase = CommonFunctions.Data.GetDataReader(strSQL, True)
                'End If

                'blnSectionChk = False


                ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
                ''strSQL = "select TestSectionID  from tbl_tcm_testsection where TestSetID=" & strTestSetcmbvalue
                strSQL = "usp_sel_tbl_tcm_testsection_TestSectionID " & strTestSetcmbvalue

                drtestsection = CommonFunctions.Data.GetDataReader(strSQL, True)
                While drtestsection.Read
                    'blnSectionChk = False
                    strTestSectionId = CStr(CommonFunctions.General.CheckIsNothing(drtestsection("TestSectionId")))

                    ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
                    ''strSQL = "select TESTCASEID   from tbl_Tcm_TestCaseDetails WHERE TestSectionID=" & strTestSectionId
                    strSQL = "usp_sel_tbl_Tcm_TestCaseDetails_TESTCASEID " & strTestSectionId

                    drtestcase = CommonFunctions.Data.GetDataReader(strSQL, True)
                    strCaseID = ""
                    'strSelectedCaseID = ""
                    'Count = 0
                    While drtestcase.Read
                        strtestcaseid = CStr(CommonFunctions.General.CheckIsNothing(drtestcase("TESTCASEID")))
                        strchkboxname = "chk" + strtestcaseid
                        strCaseID = HttpContext.Current.Request.Form(strchkboxname)
                        If strCaseID = "" Then
                            flag = False
                        End If
                        If strCaseID <> "" Then
                            FL = True
                            'blnSectionChk = True
                            'If Count = 0 Then
                            '    strSelectedCaseID = strCaseID
                            'Else
                            '    strSelectedCaseID = strSelectedCaseID + "," + strCaseID
                            'End If
                            'Count = 1

                        End If
                    End While
                    CommonFunction.Data.DisposeDataReader(drtestcase)
                    'If blnSectionChk = True Then
                    '    strSQL = "EXEC usp_sel_AddExistingTestCase  " & strCurrentTestSetID & "," & strTestSectionId & " ,'" & strSelectedCaseID & "'"
                    '    drInsertCase = CommonFunctions.Data.GetDataReader(strSQL, True)
                    'End If
                    'strSQL = "EXEC usp_sel_AddExistingTestCase " & strTestSectionId & " ,'" & strSelectedSectionID & "'"
                    'drtestcase = CommonFunctions.Data.GetDataReader(strSQL, True)
                    ' i = strSelectCaseIDs.LastIndexOf(",")
                End While
                CommonFunction.Data.DisposeDataReader(drtestsection)
                'strSelectedIDs = HttpContext.Current.Request.Form("chk")
                If flag = False And FL <> True Then
                    strScript = vbCrLf + "<Script language=javascript>"
                    strScript += vbCrLf + "    alert('Please Select atleast 1 Test Case');"
                    'strScript += vbCrLf + "    return;"
                    strScript += vbCrLf + "</Script>"
                    CommonFunction.General.WriteHTML(strScript)
                End If
                If FL = True Then
                    'Close this dialog and refresh the opener window
                    strScript = vbCrLf + "<Script language=javascript>"
                    strScript += vbCrLf + "    refreshParent('frmCommonList','TestCase_CommonList.aspx','TestCase_CommonList.aspx?FromWhere=SM&MasterTagID=3655&TestSetId=" + strCurrentTestSetID.ToString + "');"
                    strScript += vbCrLf + "    window.close();"
                    strScript += vbCrLf + "</Script>"
                    CommonFunction.General.WriteHTML(strScript)
                End If
            Else
                'IF NO TEST SET IS SELECTED THEN SAVE OPERATION IS NOT ALLOWED
                strScript = vbCrLf + "<Script language=javascript>"
                strScript += vbCrLf + "    alert('Select a Test Set');"
                'strScript += vbCrLf + "    return;"
                strScript += vbCrLf + "</Script>"
                CommonFunction.General.WriteHTML(strScript)
            End If

        End If
        ' End_MV_6/29/2007
    End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    End Function




    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

        If Args.ClientSideFunctionName.ToUpper = "SAVECASE_ONCLICK" Then
            Args.ToBeInsertedInFunction = "var objForm,intItems,intCtr,blnSelected,strCheckboxIDs;" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf


            'Args.ToBeInsertedInFunction += "if('<%=m_CheckboxIDs%>' != '')   " & vbCrLf
            'Args.ToBeInsertedInFunction += "{" + vbCrLf
            'Args.ToBeInsertedInFunction += "strCheckboxIDs = '<%=m_CheckboxIDs%>'.split(',');" + vbCrLf
            'Args.ToBeInsertedInFunction += "alert(strCheckboxIDs);" + vbCrLf
            'Args.ToBeInsertedInFunction += "intItems = strCheckboxIDs.length;" + vbCrLf
            'Args.ToBeInsertedInFunction += "blnSelected = false;" + vbCrLf
            'Args.ToBeInsertedInFunction += "for (intCtr = 0;intCtr <= intItems - 1; intCtr++)" + vbCrLf
            'Args.ToBeInsertedInFunction += "{" + vbCrLf
            'Args.ToBeInsertedInFunction += "alert(intItems);" + vbCrLf
            'Args.ToBeInsertedInFunction += "objCheckbox = GetObjectReference(objForm,strCheckboxIDs[intCtr]);" + vbCrLf

            'Args.ToBeInsertedInFunction += "if(objCheckbox.disabled == false)" + vbCrLf
            'Args.ToBeInsertedInFunction += "{" + vbCrLf
            'Args.ToBeInsertedInFunction += "if(objCheckbox.checked == true)" + vbCrLf
            'Args.ToBeInsertedInFunction += "{" + vbCrLf
            'Args.ToBeInsertedInFunction += "blnSelected = true;" + vbCrLf
            'Args.ToBeInsertedInFunction += "break;" + vbCrLf
            'Args.ToBeInsertedInFunction += "}" + vbCrLf
            'Args.ToBeInsertedInFunction += "}" + vbCrLf
            'Args.ToBeInsertedInFunction += "}" + vbCrLf
            'Args.ToBeInsertedInFunction += "if(blnSelected == false)" + vbCrLf
            'Args.ToBeInsertedInFunction += "{" + vbCrLf
            'Args.ToBeInsertedInFunction += "alert('Select at least one TestCase.');" + vbCrLf
            'Args.ToBeInsertedInFunction += "return;" + vbCrLf
            'Args.ToBeInsertedInFunction += "}" + vbCrLf
            'Args.ToBeInsertedInFunction += "}" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm.action='../TCM/Test_Section_Grid_CommonList.aspx?FromWhere=SM&MasterTagId=3662&TestSetID=" + strCurrentTestSetID.ToString + "&Save=True'" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf
            Args.ToBeInsertedInFunction += "return;" + vbCrLf
        End If

        If Args.ClientSideFunctionName.ToUpper = "SELECTALLCHECKBOXS" Then


        End If

    End Sub


    Protected Overrides Sub After_Link_Print(ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub

    Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)

        If Args.ClientSideFunctionName.ToUpper = "SETFILTER" Then
            Args.ToBeInserted = Args.ToBeInserted + "&TestSetID=" + strCurrentTestSetID.ToString
        End If
    End Sub

    Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

        '  ToBeInsertedInFunction = "  if (strHiddenControlName=='TestSetID_UserFriendlyValue' && objControl.selectedIndex==0) "
        ' ToBeInsertedInFunction += vbCrLf + "        { alert('Please Select Test Set.');return;}"

        'ToBeInsertedInFunction += "  if (strHiddenControlName=='CompanyID_UserFriendlyValue' && objControl.selectedIndex==0) "
        'ToBeInsertedInFunction += vbCrLf + "        { alert('Shuld not blank');return;}"


    End Sub

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        If Args.HTMLLegend.ToUpper = "RED COLOR INDICATES APPLIED FILTER" Then
            Cancel = True
        End If
    End Sub

    Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
        ' Modified By MahendraV On 9:34 AM 6/29/2007
        ' This code from PageListPreRender To WhizForm_Init
        ' Start_MV_6/29/2007
        'Dim flag As Boolean = True
        'Dim FL As Boolean = False
        Dim strSQL As String
        Dim strTestSetcmbvalue As String
        Dim strTestSectionId As String
        Dim drtestsection As IDataReader
        Dim strchkboxname As String
        ' Dim strSelectedSectionID As String
        Dim strSelectedCaseID As String
        Dim strCaseID As String
        'Dim strSelectCaseIDs As String
        'Dim strSelectCaseID As String
        'Dim strSqlQuery As String
        Dim drtestcase As IDataReader
        'Dim drInsertCase As IDataReader
        Dim strtestcaseid As String
        Dim strcasechkboxname As String
        Dim i As Integer
        Dim blnSectionChk As Boolean
        Dim Count As Integer
        'Dim strScript As String
        If CommonFunction.General.CheckIsNothing(Request.QueryString("TestSetID"), "0") <> "0" Then
            strCurrentTestSetID = CType(HttpContext.Current.Request.QueryString("TestSetID"), String)
        End If

        If HttpContext.Current.Request.QueryString("SetFilter") = "1" Then
            strCurrentTestSetID = Request.Form("txthidCuttentTestCaseID").ToString
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCuttentTestCaseID", "txthidCuttentTestCaseID", , , , strCurrentTestSetID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        Else
            strCurrentTestSetID = CType(HttpContext.Current.Request.QueryString("TestSetID"), String)
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCuttentTestCaseID", "txthidCuttentTestCaseID", , , , strCurrentTestSetID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If

        If HttpContext.Current.Request.QueryString("Save") = "True" Then
            strTestSetcmbvalue = CStr(HttpContext.Current.Request.Form("TestSetID"))
            If strTestSetcmbvalue <> "" Then

                ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
                ''strSQL = "select TESTCASEID   from tbl_Tcm_TestCaseDetails  WHERE IsNULL(TestSectionID,0)=0  AND  TestSetID=" & strTestSetcmbvalue
                strSQL = "usp_sel_tbl_Tcm_TestCaseDetails_TESTCID " & strTestSetcmbvalue
                drtestcase = CommonFunctions.Data.GetDataReader(strSQL, True)
                strCaseID = ""
                strSelectedCaseID = ""

                While drtestcase.Read
                    strtestcaseid = CStr(CommonFunctions.General.CheckIsNothing(drtestcase("TESTCASEID")))
                    strchkboxname = "chk" + strtestcaseid
                    strCaseID = HttpContext.Current.Request.Form(strchkboxname)
                    If strCaseID <> "" Then
                        blnSectionChk = True
                        If Count = 0 Then
                            strSelectedCaseID = strCaseID
                        Else
                            strSelectedCaseID = strSelectedCaseID + "," + strCaseID
                        End If
                        Count = 1

                    End If
                End While

                CommonFunction.Data.DisposeDataReader(drtestcase)
                If blnSectionChk = True Then
                    strSQL = "EXEC usp_sel_AddExistingTestCase  " & strCurrentTestSetID & ",0,' " & strSelectedCaseID & "'"
                    'drInsertCase = CommonFunctions.Data.GetDataReader(strSQL, True)
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                End If

                blnSectionChk = False


                ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
                ''strSQL = "select TestSectionID  from tbl_tcm_testsection where TestSetID=" & strTestSetcmbvalue
                strSQL = "usp_sel_tbl_tcm_testsection_TestSectionID " & strTestSetcmbvalue
                drtestsection = CommonFunctions.Data.GetDataReader(strSQL, True)
                While drtestsection.Read
                    blnSectionChk = False
                    strTestSectionId = CStr(CommonFunctions.General.CheckIsNothing(drtestsection("TestSectionId")))

                    ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
                    ''strSQL = "select TESTCASEID   from tbl_Tcm_TestCaseDetails WHERE TestSectionID=" & strTestSectionId
                    strSQL = "usp_sel_tbl_Tcm_TestCaseDetails_TESTCASEID " & strTestSectionId
                    drtestcase = CommonFunctions.Data.GetDataReader(strSQL, True)
                    strCaseID = ""
                    strSelectedCaseID = ""
                    Count = 0
                    While drtestcase.Read
                        strtestcaseid = CStr(CommonFunctions.General.CheckIsNothing(drtestcase("TESTCASEID")))
                        strchkboxname = "chk" + strtestcaseid
                        strCaseID = HttpContext.Current.Request.Form(strchkboxname)
                        If strCaseID <> "" Then
                            blnSectionChk = True
                            If Count = 0 Then
                                strSelectedCaseID = strCaseID
                            Else
                                strSelectedCaseID = strSelectedCaseID + "," + strCaseID
                            End If
                            Count = 1

                        End If
                    End While
                    CommonFunction.Data.DisposeDataReader(drtestcase)
                    If blnSectionChk = True Then
                        strSQL = "EXEC usp_sel_AddExistingTestCase  " & strCurrentTestSetID & "," & strTestSectionId & " ,'" & strSelectedCaseID & "'"
                        'drInsertCase = CommonFunctions.Data.GetDataReader(strSQL, True)
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                    End If

                End While

                CommonFunction.Data.DisposeDataReader(drtestsection)
            End If

        End If
        ' End_MV_6/29/2007
    End Sub
End Class



