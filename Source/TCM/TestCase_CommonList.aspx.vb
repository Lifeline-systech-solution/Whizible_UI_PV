Imports CommonEngines.General.cEventHandlers
Public Class TestCase_CommonList
    Inherits CommonList



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
        MyBase.strListPage = "TestCase_CommonList.aspx"
        MyBase.strFormPage = "TestCase_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cTestCase_CommonList_PlotGrid(MyBase.m_objGlobal)
    End Function
    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function


    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub


    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim TestSetID As String
        TestSetID = CType(HttpContext.Current.Request.QueryString("TestSetID"), String)

        If Args.ClientSideFunctionName.ToLower = "section_onclick" Then
            Args.ToBeInsertedInFunction += "window.open ('../General/CommonList.aspx?FromWhere=SM&MasterTagID=3651&TestSetID=" + TestSetID.ToString + "', '', 'resizable=yes,scrollbars=yes,left=' + ((window.screen.width - 700)/2) + ',top=' + ((window.screen.height - 600)/2) + ',width=700,height=500');" + vbCrLf
            Args.ToBeInsertedInFunction += "return;"
        End If
        If Args.ClientSideFunctionName.ToLower = "addexisting_onclick" Then
            Args.ToBeInsertedInFunction += "window.open ('../TCM/Test_Section_Grid_CommonList.aspx?FromWhere=SM&MasterTagID=3662&TestSetId=" + TestSetID.ToString + "', '', 'resizable=yes,scrollbars=yes,left=' + ((window.screen.width - 700)/2) + ',top=' + ((window.screen.height - 600)/2) + ',width=700,height=500');" + vbCrLf
            Args.ToBeInsertedInFunction += "return;"
        End If


    End Sub
    'Added by PrashantSJ on 07 Nov 2006
    'Purpose: Before selection of resource when we select the Role only that role's employee will display
    Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        Return New cTestCase_CommonListDynamicFilters(MyBase.m_objGlobal)
    End Function
    'End of addition by PrashantSJ on 07 Nov 2006 


    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        If Args.HTMLLegend.ToUpper = "RED COLOR INDICATES APPLIED FILTER" Then
            Cancel = True
        End If
    End Sub

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)
        Dim TestSetID As String
        Dim strbuildstring As String
        Dim strSQL As String
        Dim strTestSetName As String
        Dim drname As IDataReader

        TestSetID = CType(HttpContext.Current.Request.QueryString("TestSetID"), String)
        ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
        ''strSQL = "Select TestSetName from tbl_TCM_TestSet Where TestSetID=" + CStr(TestSetID)
        strSQL = "usp_sel_tbl_TCM_TestSet_TestSetName " + CStr(TestSetID)
        drname = CommonFunctions.Data.GetDataReader(strSQL, True)
        If drname.Read Then
            strTestSetName = CStr(drname.Item("TestSetName"))
            strbuildstring = "Test Set : " + strTestSetName
            Args.RightPageCaption = strbuildstring
        End If
        CommonFunction.Data.DisposeDataReader(drname)

    End Sub
End Class




Public Class cTestCase_CommonListDynamicFilters
    Inherits CommonEngine.CommonList.cDynamicFilters
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As Whiz.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)

        If Args.FilterName.ToUpper = "TESTSECTIONID" Then
            Dim strTestSetID As String
            strTestSetID = CType(HttpContext.Current.Request.QueryString("TestSetID"), String)
            If strTestSetID Is Nothing Or strTestSetID = "" Then
                strTestSetID = HttpContext.Current.Request.Form("TestSetID")

            End If
            Args.SQL = " usp_Sel_tbl_TCM_TestSection " & strTestSetID

        End If

    End Sub
End Class
'End of addition by PrashantSJ on 07 Nov 2006 

Public Class cTestCase_CommonList_PlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ColumnName.ToUpper = "COPY" Then
            Dim drAccessRights As IDataReader
            Dim strQuery As String
            Dim intPostId As Integer
            Dim intUserId As Integer
            Dim strLoginType As String
            Dim intProjectID As Integer
            Dim blnAddRight As Boolean
            Dim blnEditRight As Boolean

            intPostId = CType(HttpContext.Current.Session("intPostID"), Integer)
            intUserId = CType(HttpContext.Current.Session("intUserID"), Integer)
            strLoginType = CType(HttpContext.Current.Session("LoginType"), String)
            intProjectID = CType(HttpContext.Current.Session("intProjectID"), Integer)

            strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " & WhizGlobal.TagID & "," & intPostId.ToString & "," & intUserId.ToString & ",'" & strLoginType & "'," & intProjectID.ToString
            drAccessRights = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If CommonFunctions.General.CheckIsNothing(drAccessRights) <> "" Then
                drAccessRights.Read()
                blnAddRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("A"), "False"), Boolean)
                blnEditRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("E"), "False"), Boolean)
            End If
            If (blnAddRight = False) Then
                Cancel = True
            End If
            CommonFunctions.Data.DisposeDataReader(drAccessRights)
        End If
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ColumnName.ToUpper = "COPY" Then
            Dim drAccessRights As IDataReader
            Dim strQuery As String
            Dim intPostId As Integer
            Dim intUserId As Integer
            Dim strLoginType As String
            Dim intProjectID As Integer
            Dim blnAddRight As Boolean
            Dim blnEditRight As Boolean

            intPostId = CType(HttpContext.Current.Session("intPostID"), Integer)
            intUserId = CType(HttpContext.Current.Session("intUserID"), Integer)
            strLoginType = CType(HttpContext.Current.Session("LoginType"), String)
            intProjectID = CType(HttpContext.Current.Session("intProjectID"), Integer)

            strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " & WhizGlobal.TagID & "," & intPostId.ToString & "," & intUserId.ToString & ",'" & strLoginType & "'," & intProjectID.ToString
            drAccessRights = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If CommonFunctions.General.CheckIsNothing(drAccessRights) <> "" Then
                drAccessRights.Read()
                blnAddRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("A"), "False"), Boolean)
                blnEditRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("E"), "False"), Boolean)
            End If
            If (blnAddRight = False) Then
                Cancel = True
            End If
            CommonFunctions.Data.DisposeDataReader(drAccessRights)
        End If
    End Sub
End Class
Public Class CopyData

    Public Shared Function CopyData(ByVal TagID As Integer, ByVal UniqueID As Integer, ByVal UseSQL As Boolean) As String
        '=============================================
        ' Procedure Name		: CopyData
        ' Description           : To Initialise the Controls on the CP with the values for The UniqueID Passed
        ' Purpose               : To Implement Copy functionality 
        ' Parameters Passed     : TagID, UniqueID 
        ' Parameters Affected   :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NitinVS
        ' Created               : May 4 2005
        ' Revisions             :
        '=====================================================================
        Dim flag As Boolean
        Dim strSQLQuery As String
        Dim strsqlcode As String
        Dim strTestCaseCode As String
        Dim objDR As IDataReader
        Dim objTest As IDataReader
        Dim strTableName As String
        Dim strPrimaryKey As String
        Dim strControlList As String
        Dim StringToBeInserted As String = ""
        Dim ControlTypeList As String
        Dim ControlTypeID() As String
        Dim ControlName() As String
        Dim strNewline As String
        Dim cnt As Integer
        Dim Value As String
        Dim strvalue() As String
        Dim strbillable As String
        Dim intTestSetId As Integer
        Dim i As Integer
        Dim strDoublequotes As String

        ' Get the TableName , PrimaryKey Name and List of Controls Shown on CP 
        strSQLQuery = " usp_sel_Tag_Information_for_CopyFunctionality " + TagID.ToString
        objDR = CommonFunction.Data.GetDataReader(strSQLQuery, UseSQL)

        If objDR.Read Then

            strTableName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR("TableName"), ""), "")
            strPrimaryKey = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR("PrimaryKey"), ""), "")
            strControlList = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR("ControlList"), ""), "")
            ControlTypeList = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR("ControlTypeList"), ""), "")
            ControlName = strControlList.Split(CType(",", Char))
            ControlTypeID = ControlTypeList.Split(CType(",", Char))
        End If

        ' Clear the Data Reader 
        CommonFunction.Data.DisposeDataReader(objDR)

        ' Get the data From the Source Table for The UniqueID 
        strSQLQuery = " SELECT " + strControlList + " FROM " + strTableName + " WHERE " + strPrimaryKey + " = " + UniqueID.ToString

        ' Get the information for Copying 
        objDR = CommonFunction.Data.GetDataReader(strSQLQuery, UseSQL)

        ' If Data Exists then Write a Javascript to Initialise the controls with The Respecive Value
        If objDR.Read Then



            For cnt = 0 To ControlName.Length - 1

                Value = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR(ControlName(cnt)), ""), "").Trim

                ' Configure the Fields for which the copied value is not to be assigned

                If TagID = 3655 Then

                    Select Case ControlName(cnt).ToUpper
                        Case "TESTCASECODE"
                            intTestSetId = CInt(HttpContext.Current.Request.QueryString("TestSetID"))
                            strsqlcode = "EXEC usp_sel_tbl_TestCode " & intTestSetId

                            objTest = CommonFunctions.Data.GetDataReader(strsqlcode, True)
                            If objTest.Read Then
                                strTestCaseCode = CStr(CommonFunctions.General.CheckIsNothing(objTest("GeneratedCode")))
                            End If
                            CommonFunction.Data.DisposeDataReader(objTest)
                            Value = strTestCaseCode
                            'StringToBeInserted += "var objTestCaseCode="

                    End Select

                ElseIf TagID = 3666 Then
                    Select Case ControlName(cnt).ToUpper
                        Case "TESTCASECODE"
                            intTestSetId = CInt(HttpContext.Current.Request.QueryString("ProjectTestSetID"))
                            strsqlcode = "EXEC usp_sel_tbl_ProjectTestCode " & intTestSetId

                            objTest = CommonFunctions.Data.GetDataReader(strsqlcode, True)
                            If objTest.Read Then
                                strTestCaseCode = CStr(CommonFunctions.General.CheckIsNothing(objTest("GeneratedCode")))
                            End If
                            CommonFunction.Data.DisposeDataReader(objTest)
                            Value = strTestCaseCode
                    End Select
                End If


                Select Case ControlTypeID(cnt)

                    Case "2" ' Combo 
                        StringToBeInserted += " var obj" + ControlName(cnt) + " = GetObjectReference('frmCommonPage','" + ControlName(cnt) + "');" + vbCrLf
                        StringToBeInserted += " if ( obj" + ControlName(cnt) + " != null) " + vbCrLf
                        StringToBeInserted += " obj" + ControlName(cnt) + ".value=""" + Value + """;" + vbCrLf

                    Case "6" ' CheckBox 

                        StringToBeInserted += " var obj" + ControlName(cnt) + " = GetObjectReference('frmCommonPage','" + ControlName(cnt) + "');" + vbCrLf

                        If Value = "True" Then
                            StringToBeInserted += " if ( obj" + ControlName(cnt) + " != null) " + vbCrLf
                            StringToBeInserted += " obj" + ControlName(cnt) + ".checked=true; " + vbCrLf
                        Else
                            StringToBeInserted += " if ( obj" + ControlName(cnt) + " != null) " + vbCrLf
                            StringToBeInserted += " obj" + ControlName(cnt) + ".checked=false; " + vbCrLf
                        End If
                    Case "11" ' Date 

                        StringToBeInserted += " var obj" + ControlName(cnt) + " = GetObjectReference('frmCommonPage','" + ControlName(cnt) + "');" + vbCrLf
                        StringToBeInserted += " if ( obj" + ControlName(cnt) + " != null) " + vbCrLf
                        If Value <> "" Then
                            StringToBeInserted += " obj" + ControlName(cnt) + ".value=""" + CommonFunction.Dates.GetDate(CType(Value, Date)).Trim + """;" + vbCrLf
                        Else
                            StringToBeInserted += " obj" + ControlName(cnt) + ".value=""" + Value + """;" + vbCrLf
                        End If
                        '***** Code added by SandipL on 3 dec 2005 --Blank Dates in Copy Form Due to added functionality of Editable date Control
                        StringToBeInserted += " var objFFE29587WHIZ_" + ControlName(cnt) + " = GetObjectReference('frmCommonPage','" + "FFE29587WHIZ_" + ControlName(cnt) + "');" + vbCrLf
                        StringToBeInserted += " if ( objFFE29587WHIZ_" + ControlName(cnt) + " != null) " + vbCrLf
                        If Value <> "" Then
                            Dim dtValue As DateTime
                            dtValue = CType(Value, DateTime)
                            'StringToBeInserted += " objFFE29587WHIZ_" + ControlName(cnt) + ".value=""" + CommonFunction.Dates.GetDate(CType(Value, Date)).Trim + """;" + vbCrLf
                            StringToBeInserted += " objFFE29587WHIZ_" + ControlName(cnt) + ".value=""" + CommonFunctions.HTMLControls.ConvertDateTo_InputDateFormat(Value) + """;" + vbCrLf
                        Else
                            StringToBeInserted += " objFFE29587WHIZ_" + ControlName(cnt) + ".value=""" + Value + """;" + vbCrLf
                        End If
                        '***** End addition by SandipL on 3 Dec 2005

                    Case Else ' for Other controls 
                        StringToBeInserted += " var obj" + ControlName(cnt) + " = GetObjectReference('frmCommonPage','" + ControlName(cnt) + "');" + vbCrLf
                        StringToBeInserted += " if ( obj" + ControlName(cnt) + " != null) " + vbCrLf


                        strNewline = Value.Replace(Chr(10), "\n")
                        strNewline = strNewline.Replace(Chr(13), "")
                        strNewline = strNewline.Replace(Chr(34), "\""")

                        'strNewline = Value.Replace(vbNewLine, "")
                        StringToBeInserted += " obj" + ControlName(cnt) + ".value=""" + strNewline + """;" + vbCrLf


                End Select

            Next



        End If


        CommonFunction.Data.DisposeDataReader(objDR)


        CopyData = StringToBeInserted
    End Function
End Class