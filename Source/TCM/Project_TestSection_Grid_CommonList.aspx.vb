Imports CommonEngines.General.cEventHandlers
Public Class Project_TestSection_Grid_CommonList
    Inherits CommonList
    Protected strCurrentTestSetID As String
    'Added by NitinC On 29 June 2011 For WhizibleSEM v10.0 (Agile Methodology)
    Protected strCurrentUserStoryID As String
    'End of Added by NitinC On 29 June 2011 For WhizibleSEM v10.0 (Agile Methodology)
 
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "Project_TestSection_Grid_CommonList.aspx"
        MyBase.strFormPage = "Project_TestSection_Grid_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
    'Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology)
    Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        Return New cProject_TestSection_Grid_CommonList_DynamicFilters(MyBase.m_objGlobal)
    End Function
    'End of Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology)
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cProject_TestSection_Grid_CommonList(MyBase.m_objGlobal)
    End Function
    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

        If Args.ClientSideFunctionName.ToUpper = "SAVECASE_ONCLICK" Then

            'Args.ToBeInsertedInFunction = "objUserStoryID = GetObjectReference('frmCommonList','UserStoryID');" + vbCrLf
            'Args.ToBeInsertedInFunction += "if(objUserStoryID == null)" + vbCrLf
            'Args.ToBeInsertedInFunction += "{var objForm,intItems,intCtr,blnSelected,strCheckboxIDs;" + vbCrLf
            'Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
            'Args.ToBeInsertedInFunction += "objForm.action='../TCM/Project_TestSection_Grid_CommonList.aspx?FromWhere=PM&MasterTagId=3667&ProjectTestSetID=15&Save=True';" + vbCrLf
            'Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf
            'Args.ToBeInsertedInFunction += "return; }" + vbCrLf
            'Args.ToBeInsertedInFunction += "else { if(document.URL.search(""UserStoryID"") != -1 )"
            'Args.ToBeInsertedInFunction += "{ var objForm,intItems,intCtr,blnSelected,strCheckboxIDs;"
            'Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList'); objForm.action='../TCM/Project_TestSection_Grid_CommonList.aspx?FromWhere=PM&MasterTagId=3667&ProjectTestSetID=15&Save=True'; "
            'Args.ToBeInsertedInFunction += "objForm.submit(); return; }	"
            'Args.ToBeInsertedInFunction += "else { alert('As this project has scrum practice,\nyou have to select scrum user story under which you want to copy test cases!  '); "
            'Args.ToBeInsertedInFunction += "window.open (""../General/CommonPage.aspx?MasterTagID=20130"",""MyPage"",""resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 400)/2 + "",width=500,height=150""); window.close(); return; } }" + vbCrLf



            Args.ToBeInsertedInFunction = "var objForm,intItems,intCtr,blnSelected,strCheckboxIDs;" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf


            ''Args.ToBeInsertedInFunction += "if('<%=m_CheckboxIDs%>' != '')   " & vbCrLf
            ''Args.ToBeInsertedInFunction += "{" + vbCrLf
            ''Args.ToBeInsertedInFunction += "strCheckboxIDs = '<%=m_CheckboxIDs%>'.split(',');" + vbCrLf
            ''Args.ToBeInsertedInFunction += "alert(strCheckboxIDs);" + vbCrLf
            ''Args.ToBeInsertedInFunction += "intItems = strCheckboxIDs.length;" + vbCrLf
            ''Args.ToBeInsertedInFunction += "blnSelected = false;" + vbCrLf
            ''Args.ToBeInsertedInFunction += "for (intCtr = 0;intCtr <= intItems - 1; intCtr++)" + vbCrLf
            ''Args.ToBeInsertedInFunction += "{" + vbCrLf
            ''Args.ToBeInsertedInFunction += "alert(intItems);" + vbCrLf
            ''Args.ToBeInsertedInFunction += "objCheckbox = GetObjectReference(objForm,strCheckboxIDs[intCtr]);" + vbCrLf

            ''Args.ToBeInsertedInFunction += "if(objCheckbox.disabled == false)" + vbCrLf
            ''Args.ToBeInsertedInFunction += "{" + vbCrLf
            ''Args.ToBeInsertedInFunction += "if(objCheckbox.checked == true)" + vbCrLf
            ''Args.ToBeInsertedInFunction += "{" + vbCrLf
            ''Args.ToBeInsertedInFunction += "blnSelected = true;" + vbCrLf
            ''Args.ToBeInsertedInFunction += "break;" + vbCrLf
            ''Args.ToBeInsertedInFunction += "}" + vbCrLf
            ''Args.ToBeInsertedInFunction += "}" + vbCrLf
            ''Args.ToBeInsertedInFunction += "}" + vbCrLf
            ''Args.ToBeInsertedInFunction += "if(blnSelected == false)" + vbCrLf
            ''Args.ToBeInsertedInFunction += "{" + vbCrLf
            ''Args.ToBeInsertedInFunction += "alert('Select at least one TestCase.');" + vbCrLf
            ''Args.ToBeInsertedInFunction += "return;" + vbCrLf
            ''Args.ToBeInsertedInFunction += "}" + vbCrLf
            ''Args.ToBeInsertedInFunction += "}" + vbCrLf
            If strCurrentUserStoryID <> "NULL" Then
                Args.ToBeInsertedInFunction += "objForm.action='../TCM/Project_TestSection_Grid_CommonList.aspx?FromWhere=PM&MasterTagId=3667&ProjectTestSetID=" + strCurrentTestSetID.ToString + "&UserStoryID=" + strCurrentUserStoryID.ToString + "&Save=True'" + vbCrLf
            Else
                Args.ToBeInsertedInFunction += "objForm.action='../TCM/Project_TestSection_Grid_CommonList.aspx?FromWhere=PM&MasterTagId=3667&ProjectTestSetID=" + strCurrentTestSetID.ToString + "&Save=True'" + vbCrLf
            End If

            Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf
            Args.ToBeInsertedInFunction += "return;" + vbCrLf
        End If

        If Args.ClientSideFunctionName.ToUpper = "SELECTALLCHECKBOXS" Then
        End If
    End Sub

    Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ClientSideFunctionName.ToUpper = "SETFILTER" Then
            If strCurrentUserStoryID <> "NULL" Then
                Args.ToBeInserted = Args.ToBeInserted + "&ProjectTestSetID=" + strCurrentTestSetID.ToString
            Else
                Args.ToBeInserted = Args.ToBeInserted + "&ProjectTestSetID=" + strCurrentTestSetID.ToString + "&UserStoryID=" + strCurrentUserStoryID.ToString
            End If

        End If
    End Sub

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        ' Modified By MahendraV On 9:34 AM 6/29/2007
        ' Database update need to be moved in WhizForm_Init due to DataSet Related Changes For Whiziblesem 7
        ' Commented code moved from PageListPreRender To WhizForm_Init
        ' Start_MV_6/29/2007
        Dim flag As Boolean = True
        Dim fl As Boolean = False
        Dim strSQL As String
        Dim strTestSetcmbvalue As String
        Dim strTestSectionId As String
        Dim drtestsection As IDataReader
        Dim strchkboxname As String
        'Dim strSelectedSectionID As String
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
        If CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectTestSetID"), "0") <> "0" Then
            strCurrentTestSetID = CType(HttpContext.Current.Request.QueryString("ProjectTestSetID"), String)
        End If
        'Added by NitinC On 29 June 2011 For WhizibleSEM v10.0 (Agile Methodology)
        If CommonFunction.General.CheckIsNothing(Request.QueryString("UserStoryID"), "0") <> "0" Then
            strCurrentUserStoryID = CType(HttpContext.Current.Request.QueryString("UserStoryID"), String)
        Else
            strCurrentUserStoryID = "NULL"
        End If

        If HttpContext.Current.Request.QueryString("SetFilter") = "1" And Request.Form("txthidCurrentUserStoryID") <> Nothing Then
            strCurrentUserStoryID = Request.Form("txthidCurrentUserStoryID").ToString
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCurrentUserStoryID", "txthidCurrentUserStoryID", , , , strCurrentUserStoryID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        ElseIf strCurrentUserStoryID <> "NULL" Then
            strCurrentUserStoryID = CType(HttpContext.Current.Request.QueryString("UserStoryID"), String)
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCurrentUserStoryID", "txthidCurrentUserStoryID", , , , strCurrentUserStoryID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If
        'End of Added by NitinC On 29 June 2011 For WhizibleSEM v10.0 (Agile Methodology)


        If HttpContext.Current.Request.QueryString("SetFilter") = "1" Then
            strCurrentTestSetID = Request.Form("txthidCuttentTestCaseID").ToString
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCuttentTestCaseID", "txthidCuttentTestCaseID", , , , strCurrentTestSetID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15

        Else
            strCurrentTestSetID = CType(HttpContext.Current.Request.QueryString("ProjectTestSetID"), String)
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCuttentTestCaseID", "txthidCuttentTestCaseID", , , , strCurrentTestSetID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If

        If HttpContext.Current.Request.QueryString("Save") = "True" Then
            strTestSetcmbvalue = CStr(HttpContext.Current.Request.Form("ProjectTestSetID"))
            If strTestSetcmbvalue <> "" Then

                ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                ''strSQL = "select ProjectTestCaseID   from tbl_Tcm_ProjectTestCaseDetails  WHERE IsNULL(ProjectTestSectionID,0)=0  AND  ProjectTestSetID=" & strTestSetcmbvalue
                strSQL = "usp_sel_tbl_Tcm_ProjectTestCaseDetails_ProjectTestCaseID " & strTestSetcmbvalue
                drtestcase = CommonFunctions.Data.GetDataReader(strSQL, True)
                strCaseID = ""
                'strSelectedCaseID = ""

                While drtestcase.Read
                    strtestcaseid = CStr(CommonFunctions.General.CheckIsNothing(drtestcase("ProjectTestCaseID")))
                    strchkboxname = "chk" + strtestcaseid
                    strCaseID = HttpContext.Current.Request.Form(strchkboxname)
                    If strCaseID = "" Then
                        flag = False
                    End If
                    If strCaseID <> "" Then
                        fl = True
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
                '    strSQL = "EXEC usp_sel_AddExistingProjectTestCase  " & strCurrentTestSetID & ",0,' " & strSelectedCaseID & "'"
                '    drInsertCase = CommonFunctions.Data.GetDataReader(strSQL, True)
                'End If

                'blnSectionChk = False






                ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                ''strSQL = "select ProjectTestSectionID  from tbl_tcm_Projecttestsection where ProjectTestSetID=" & strTestSetcmbvalue
                strSQL = "usp_sel_tbl_tcm_Projecttestsection_ProjectTest " & strTestSetcmbvalue
                drtestsection = CommonFunctions.Data.GetDataReader(strSQL, True)
                While drtestsection.Read
                    'blnSectionChk = False
                    strTestSectionId = CStr(CommonFunctions.General.CheckIsNothing(drtestsection("ProjectTestSectionId")))
                    ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                    ''strSQL = "select ProjectTestCaseID   from tbl_Tcm_ProjectTestCaseDetails WHERE ProjectTestSectionID=" & strTestSectionId
                    strSQL = "usp_sel_tbl_Tcm_ProjectTestCaseDetails_ProjectTest " & strTestSectionId

                    drtestcase = CommonFunctions.Data.GetDataReader(strSQL, True)
                    strCaseID = ""
                    'strSelectedCaseID = ""
                    'Count = 0
                    While drtestcase.Read
                        strtestcaseid = CStr(CommonFunctions.General.CheckIsNothing(drtestcase("ProjectTestCaseID")))
                        strchkboxname = "chk" + strtestcaseid
                        strCaseID = HttpContext.Current.Request.Form(strchkboxname)
                        If strCaseID = "" Then
                            flag = False
                        End If
                        If strCaseID <> "" Then
                            fl = True
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
                    '    strSQL = "EXEC usp_sel_AddExistingProjectTestCase  " & strCurrentTestSetID & "," & strTestSectionId & " ,'" & strSelectedCaseID & "'"
                    '    drInsertCase = CommonFunctions.Data.GetDataReader(strSQL, True)
                    'End If
                    'strSQL = "EXEC usp_sel_AddExistingTestCase " & strTestSectionId & " ,'" & strSelectedSectionID & "'"
                    'drtestcase = CommonFunctions.Data.GetDataReader(strSQL, True)
                    ' i = strSelectCaseIDs.LastIndexOf(",")
                End While
                CommonFunction.Data.DisposeDataReader(drtestsection)
                'strSelectedIDs = HttpContext.Current.Request.Form("chk")
                If flag = False And fl <> True Then
                    strScript = vbCrLf + "<Script language=javascript>"
                    strScript += vbCrLf + "    alert('Please Select atleast 1 Test Case');"
                    'strScript += vbCrLf + "    return;"
                    strScript += vbCrLf + "</Script>"
                    CommonFunction.General.WriteHTML(strScript)
                End If

                'Close this dialog and refresh the opener window
                If fl = True Then
                    If strCurrentUserStoryID <> "NULL" Then
                        strScript = vbCrLf + "<Script language=javascript>"
                        strScript += vbCrLf + "    refreshParent('frmCommonList','Project_Test_Cases_CommonList.aspx','Project_Test_Cases_CommonList.aspx?FromWhere=PM&MasterTagID=3666&ProjectTestSetId=" + strCurrentTestSetID.ToString + "&UserStoryID=" + strCurrentUserStoryID.ToString + "');"
                        strScript += vbCrLf + "    window.close();"
                        strScript += vbCrLf + "</Script>"
                    Else
                        strScript = vbCrLf + "<Script language=javascript>"
                        strScript += vbCrLf + "    refreshParent('frmCommonList','Project_Test_Cases_CommonList.aspx','Project_Test_Cases_CommonList.aspx?FromWhere=PM&MasterTagID=3666&ProjectTestSetId=" + strCurrentTestSetID.ToString + "');"
                        strScript += vbCrLf + "    window.close();"
                        strScript += vbCrLf + "</Script>"
                    End If
                    
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

            'strScript = vbCrLf + "<Script language=javascript>"
            'strScript += vbCrLf + "    refreshParent('frmCommonList','TestCase_CommonList.aspx','TestCase_CommonList.aspx?FromWhere=SM&MasterTagID=3655&TestSetId=" + strCurrentTestSetID.ToString + "');"
            'strScript += vbCrLf + "    window.close();"
            'strScript += vbCrLf + "</Script>"
            'CommonFunction.General.WriteHTML(strScript)

        End If
        ' End_MV_6/29/2007
    End Function

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        If Args.HTMLLegend.ToUpper = "RED COLOR INDICATES APPLIED FILTER" Then
            Cancel = True
        End If
    End Sub

    Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
        ' Modified By MahendraV On 9:34 AM 6/29/2007
        ' This code from PageListPreRender To WhizForm_Init
        ' Start_MV_6/29/2007

        ' Dim flag As Boolean = True
        ' Dim fl As Boolean = False
        Dim strSQL As String
        Dim strTestSetcmbvalue As String
        Dim strTestSectionId As String
        Dim drtestsection As IDataReader
        Dim strchkboxname As String
        Dim strSelectedSectionID As String
        Dim strSelectedCaseID As String
        Dim strCaseID As String
        Dim strSelectCaseIDs As String
        Dim strSelectCaseID As String
        Dim strSqlQuery As String
        Dim drtestcase As IDataReader
        'Dim drInsertCase As IDataReader
        Dim strtestcaseid As String
        Dim strcasechkboxname As String
        Dim i As Integer
        Dim blnSectionChk As Boolean
        Dim Count As Integer
        'Dim strScript As String
        If CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectTestSetID"), "0") <> "0" Then
            strCurrentTestSetID = CType(HttpContext.Current.Request.QueryString("ProjectTestSetID"), String)
        End If


        'Added by NitinC On 29 June 2011 For WhizibleSEM v10.0 (Agile Methodology)
        If CommonFunction.General.CheckIsNothing(Request.QueryString("UserStoryID"), "0") <> "0" Then
            strCurrentUserStoryID = CType(HttpContext.Current.Request.QueryString("UserStoryID"), String)
        Else
            strCurrentUserStoryID = "NULL"
        End If

        If HttpContext.Current.Request.QueryString("SetFilter") = "1" And Request.Form("txthidCurrentUserStoryID") <> Nothing Then
            strCurrentUserStoryID = Request.Form("txthidCurrentUserStoryID").ToString
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCurrentUserStoryID", "txthidCurrentUserStoryID", , , , strCurrentUserStoryID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        ElseIf strCurrentUserStoryID <> "NULL" Then
            strCurrentUserStoryID = CType(HttpContext.Current.Request.QueryString("UserStoryID"), String)
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCurrentUserStoryID", "txthidCurrentUserStoryID", , , , strCurrentUserStoryID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If
        'End of Added by NitinC On 29 June 2011 For WhizibleSEM v10.0 (Agile Methodology)


        If HttpContext.Current.Request.QueryString("SetFilter") = "1" Then
            strCurrentTestSetID = Request.Form("txthidCuttentTestCaseID").ToString
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCuttentTestCaseID", "txthidCuttentTestCaseID", , , , strCurrentTestSetID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        Else
            strCurrentTestSetID = CType(HttpContext.Current.Request.QueryString("ProjectTestSetID"), String)
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCuttentTestCaseID", "txthidCuttentTestCaseID", , , , strCurrentTestSetID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If

        If HttpContext.Current.Request.QueryString("Save") = "True" Then
            strTestSetcmbvalue = CStr(HttpContext.Current.Request.Form("ProjectTestSetID"))
            If strTestSetcmbvalue <> "" Then

                ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                ''strSQL = "select ProjectTestCaseID   from tbl_Tcm_ProjectTestCaseDetails  WHERE IsNULL(ProjectTestSectionID,0)=0  AND  ProjectTestSetID=" & strTestSetcmbvalue
                strSQL = "usp_sel_tbl_Tcm_ProjectTestCaseDetails_ProjectTestCaseID " & strTestSetcmbvalue
                drtestcase = CommonFunctions.Data.GetDataReader(strSQL, True)
                strCaseID = ""
                strSelectedCaseID = ""

                While drtestcase.Read
                    strtestcaseid = CStr(CommonFunctions.General.CheckIsNothing(drtestcase("ProjectTestCaseID")))
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
                    strSQL = "EXEC usp_sel_AddExistingProjectTestCase  " & strCurrentTestSetID & "," & strCurrentUserStoryID & ",0,' " & strSelectedCaseID & "'"
                    'drInsertCase = CommonFunctions.Data.GetDataReader(strSQL, True)
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                End If

                blnSectionChk = False
                ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                ''strSQL = "select ProjectTestSectionID  from tbl_tcm_Projecttestsection where ProjectTestSetID=" & strTestSetcmbvalue
                strSQL = "usp_sel_tbl_tcm_Projecttestsection_ProjectTest " & strTestSetcmbvalue
                drtestsection = CommonFunctions.Data.GetDataReader(strSQL, True)
                While drtestsection.Read
                    blnSectionChk = False
                    strTestSectionId = CStr(CommonFunctions.General.CheckIsNothing(drtestsection("ProjectTestSectionId")))

                    ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                    ''strSQL = "select ProjectTestCaseID   from tbl_Tcm_ProjectTestCaseDetails WHERE ProjectTestSectionID=" & strTestSectionId
                    strSQL = "usp_sel_tbl_Tcm_ProjectTestCaseDetails_ProjectTest " & strTestSectionId
                    drtestcase = CommonFunctions.Data.GetDataReader(strSQL, True)
                    strCaseID = ""
                    strSelectedCaseID = ""
                    Count = 0
                    While drtestcase.Read
                        strtestcaseid = CStr(CommonFunctions.General.CheckIsNothing(drtestcase("ProjectTestCaseID")))
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
                        strSQL = "EXEC usp_sel_AddExistingProjectTestCase  " & strCurrentTestSetID & "," & strCurrentUserStoryID & "," & strTestSectionId & " ,'" & strSelectedCaseID & "'"
                        'drInsertCase = CommonFunctions.Data.GetDataReader(strSQL, True)
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                    End If

                End While
                'strSelectedIDs = HttpContext.Current.Request.Form("chk")
                CommonFunction.Data.DisposeDataReader(drtestsection)

                'Close this dialog and refresh the opener window


            End If



        End If
        ' End_MV_6/29/2007
    End Sub
End Class


Public Class cProject_TestSection_Grid_CommonList
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
        m_strsectionheader = ""
        m_CheckboxIDs = ""
        m_strprevsection = ""
    End Sub


    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Not m_strsectionheader = CStr(Args.DataReader("TestSection")) Then
            Args.StringToBeInserted = "<tr class=cldTRSectionHeader>"
        End If
        m_strsectionheader = CStr(Args.DataReader("TestSection"))
    End Sub


    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strTestSection As String = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestSection")))
        Dim strTestSectionID As String = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectTestSectionID")))
        Dim strSectionID As String = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectTestSectionID")))
        ' Dim strchkboxname As String = "chkSection" + strTestSection
        Dim strchkboxname As String = "chk" + strSectionID
        Dim strTestCaseId As String = CStr(CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectTestCaseID")))
        Dim strTestCasechkBox As String
        Dim strSQL As String
        Dim drtestsection As IDataReader
        Dim obj_m_sbValidationScript As New Project_TestSection_Grid_CommonList
        '  m_sbValidationScript = ""

        'Args.StringToBeInserted = "<tr class=clsTRSectionHeader>"
        If Args.ColumnName.ToUpper = "TEST SECTION" Then
            'Args.StringToBeInserted = "<tr class=clsTRSectionHeader>"
            If strTestSection <> m_strprevsection Then
                ' Args.StringToBeInserted = "<tr class=clsTRSectionHeader>"
                m_intCount = 0
                'm_intCount = m_intCount + 1
                strchkboxname = "chk" + strSectionID '+ "_" + CType(m_intCount, String)
                Cancel = True
                Args.StringToBeInserted = "<tr class=clsTRSectionHeader>"
                Args.StringToBeInserted += "<td align='left' >" + strTestSection + "</TD>"
                Args.StringToBeInserted += "<td align='left' > </td>"
                'Args.StringToBeInserted += " <td align='left' > </td><td align='CENTER' width=10%><input type='checkbox' align='center' id='" + strchkboxname + "' name='" + strchkboxname + "' value='" + strTestSection + "' onclick='javascript:CheckTestCases(" + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestSectionID"), "0"), String) + "," + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestCaseCount"), "0"), String) + ")'> </td>"
                'm_strTestCaseIDs = "171-172-"
                m_strTestCaseIDs = ""
                Dim count As Integer = 1
                ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                ''strSQL = "select PROJECTTESTCASEID  from tbl_Tcm_ProjectTestCaseDetails where ProjecttestSectionID=" & strSectionID.ToString
                strSQL = "usp_sel_tbl_Tcm_ProjectTestCaseDetails_ProjectTest " & strSectionID.ToString

                drtestsection = CommonFunctions.Data.GetDataReader(strSQL, True)
                While drtestsection.Read
                    If count = 0 Then
                        m_strTestCaseIDs = CType(drtestsection.Item("PROJECTTESTCASEID").ToString, String)
                    Else
                        m_strTestCaseIDs = m_strTestCaseIDs + "-" + CType(drtestsection.Item("PROJECTTESTCASEID").ToString, String)
                    End If
                    count = 1
                End While
                CommonFunction.Data.DisposeDataReader(drtestsection)
                Args.StringToBeInserted += " <td align='left' > </td><td align='CENTER' width=10%><input type='checkbox' align='center' id='" + strchkboxname + "' name='" + strchkboxname + "' value='" + strSectionID + "' onclick='javascript:CheckTestCases(" + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectTestSectionID"), "0"), String) + "," + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestCaseCount"), "0"), String) + ",""" + CType(m_strTestCaseIDs, String) + """)'> </td>"


                ' m_sbValidationScript1 = "CheckTestCases(" + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestSectionID"), "0"), String) + "," + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestCaseCount"), "0"), String) + ",""" + CType(m_strTestCaseIDs, String) + """)" + vbCrLf

                ' m_sbValidationScript.Append(vbCrLf + "CheckTestCases(" + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestSectionID"), "0"), String) + "," + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestCaseCount"), "0"), String) + ",""" + CType(m_strTestCaseIDs, String) + """)" + vbCrLf)
                m_sbValidationScript += "CheckTestCases(" + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectTestSectionID"), "0"), String) + "," + CType(CommonFunctions.General.CheckIsNothing(Args.DataReader("TestCaseCount"), "0"), String) + ",""" + CType(m_strTestCaseIDs, String) + """)" + vbCrLf



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
        'Return m_sbValidationScriptt
    End Sub
    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidValidation", "txthidValidation", , , , CType(m_sbValidationScript, String), , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
    End Sub
    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strSQL As String = Args.GridSQL
        Dim m_intIndex As Integer = strSQL.IndexOf("ProjectTestSetID =", 0)
        'If string left found then
        If m_intIndex > 0 Then

        Else
            strSQL = strSQL.Replace("ORDER", " AND 1<>1  ORDER ")
            Args.GridSQL = strSQL
        End If
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ColumnName.ToUpper = "DELETE" Then
            Args.ColumnName = "Select"
        End If
    End Sub
End Class

Public Class cProject_TestSection_Grid_CommonList_DynamicFilters
    Inherits CommonEngine.CommonList.cDynamicFilters
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As Whiz.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology)
        If Args.FilterName.ToUpper = "USERSTORYID" Then
            Dim m_intFlag As Integer
            m_intFlag = CInt(CInt(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + CType(WhizGlobal.ProjectID, String), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))))
            If m_intFlag = 0 Then
                Cancel = True
            Else
                'Args.FunctionName = "Select_OnChange()"
                'Cancel = True
                'Args.ToBeInserted += "<TD align=right title="">Project User Story&nbsp;</TD><TD align=left title="">" + CommonFunction.HTMLControls.DrawComboBox("cboUserStory", "select UserStoryID,UserStoryName from d_tbl_PM_ScrumUserStory Where ProjectID = " + CType(WhizGlobal.ProjectID, String), 200, , "", True, , , True) + "</TD>"
            End If
        End If
        'End of Added by Nitinc on 28 June 2011 for WhizibleSEM v10.0 (Agile Methodology)
    End Sub
End Class
