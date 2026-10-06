Imports CommonEngines.General.cEventHandlers
Public Class cProject_Test_Cases_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cProject_Test_Cases_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub




End Class
Public Class cProject_Test_Cases_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
Public Class cProject_Test_Cases_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub


    Protected Overrides Sub After_PlotControl(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")

    End Sub

    Protected Overrides Sub After_PlotControlCaption(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterCaption As String = "")

    End Sub

    Protected Overrides Sub After_PlotControlCell(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        Dim strSQL As String
        Dim strTestCaseCode As String
        Dim drTest As IDataReader
        Dim intTestSetId As Integer
        Dim intTestSectionId As Integer
        intTestSetId = CType(HttpContext.Current.Request.QueryString("ProjectTestSetID"), Integer)
        If Args.ControlName.ToUpper = "TESTCASECODE" Then
            If Args.PrimaryKeyValue = "" Then
                Args.IgnoreActualValue = True
                strSQL = "EXEC usp_sel_tbl_ProjectTestCode " & intTestSetId

                drTest = CommonFunctions.Data.GetDataReader(strSQL, True)
                If drTest.Read Then
                    strTestCaseCode = CStr(CommonFunctions.General.CheckIsNothing(drTest("GeneratedCode")))
                End If
                CommonFunction.Data.DisposeDataReader(drTest)
                Args.NewValue = strTestCaseCode
            End If
        End If

        If Args.ControlName.ToUpper = "PROJECTTESTSECTIONID" Then

            If Args.PrimaryKeyValue = "" Then
                Args.IgnoreActualValue = True
                ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                ''Args.AdditionalInformation = "Select ProjectTestSectionId,TestSection From Tbl_TCM_ProjectTestSection Where ProjectTestSetId =" & intTestSetId & " order by TestSection"
                Args.AdditionalInformation = "usp_sel_Tbl_TCM_ProjectTestSection_ProjectTestSectionId " & intTestSetId
            Else
                ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                ''strSQL = "Select ProjectTestSectionId,TestSection From Tbl_TCM_ProjectTestSection Where ProjectTestSetId =" & intTestSetId & " order by TestSection"
                strSQL = "usp_sel_Tbl_TCM_ProjectTestSection_ProjectTestSectionId " & intTestSetId
                'drTest = CommonFunctions.Data.GetDataReader(strSQL, True)
                'If drTest.Read Then
                '    intTestSectionId = CInt(CommonFunction.Data.CheckIsDBNull(drTest("ProjectTestSectionId"), "0"))
                'End If
                Args.DropDownEditSQL = strSQL '"Select ProjectTestSectionId,TestSection From Tbl_TCM_ProjectTestSection Where ProjectTestSetId =" & intTestSetId & "and ProjectTestSectionId=" & intTestSectionId & " order by TestSection"

            End If

        End If
    End Sub

    Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")

    End Sub

    Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

    End Sub

    Protected Overrides Function GetCheckDuplicateSQL(ByVal strSQL As String, ByVal objGlobal As WebPages.Template.IGlobal) As String

    End Function


    Protected Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub
End Class


Public Class Project_Test_Cases_CommonPage
    Inherits CommonPage
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

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "Project_Test_Cases_CommonList.aspx"
        MyBase.strFormPage = "Project_Test_Cases_CommonPage.aspx"


        MyBase.Page_Load(sender, e)



    End Sub

    Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String


    End Function

    Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        Dim objcopy As New CopyData
        Dim COPYDATA As String
        Dim UniqueID As Integer = 0
        Dim strTobeInserted As String
        COPYDATA = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("COPYDATA"), ""), String)
        If COPYDATA <> "" Then
            UniqueID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectTestCaseID"), "0"), Integer)
        End If
        If COPYDATA <> "" And UniqueID <> 0 Then
            strTobeInserted = objcopy.CopyData(3666, CInt(HttpContext.Current.Request.QueryString("ProjectTestCaseID")), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            strTobeInserted += " var objIsProjectSpecificTestCase1 = GetObjectReference('frmCommonPage','IsProjectSpecificTestCase'); "
            strTobeInserted += "  if ( objIsProjectSpecificTestCase1 != null)  "
            strTobeInserted += " objIsProjectSpecificTestCase1.value=""1"";"
            PageUIPostRender = strTobeInserted
            strActionCode = ReturnCodes.ON_LOAD.ToString
        End If
    End Function





    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If HttpContext.Current.Request.QueryString("COPYDATA") = "1" Then
            If Args.LinkName.ToUpper = "SAVE" Then

                Args.ToBeInsertedInFunction = "var objTestSection,objBriefScenario,objScenario,objTestData;" & vbCrLf
                Args.ToBeInsertedInFunction += "var objPriority,objSeverity,objPlannedStaffTime;" & vbCrLf
                Args.ToBeInsertedInFunction += "var objPreconditionsAndSetup,objTestProcedure,objVerificationProcedure;" & vbCrLf

                Args.ToBeInsertedInFunction += "objTestSection=GetObjectReference('frmCommonPage','TestSection');" & vbCrLf
                Args.ToBeInsertedInFunction += "objBriefScenario=GetObjectReference('frmCommonPage','BriefScenario');" & vbCrLf
                Args.ToBeInsertedInFunction += "objScenario=GetObjectReference('frmCommonPage','Scenario');" & vbCrLf
                Args.ToBeInsertedInFunction += "objTestData=GetObjectReference('frmCommonPage','TestData');" & vbCrLf
                Args.ToBeInsertedInFunction += "objPriority=GetObjectReference('frmCommonPage','Priority');" & vbCrLf
                Args.ToBeInsertedInFunction += "objSeverity=GetObjectReference('frmCommonPage','Severity');" & vbCrLf
                Args.ToBeInsertedInFunction += "objPlannedStaffTime=GetObjectReference('frmCommonPage','PlannedStaffTime');" & vbCrLf
                Args.ToBeInsertedInFunction += "objPreconditionsAndSetup=GetObjectReference('frmCommonPage','PreconditionsAndSetup');" & vbCrLf
                Args.ToBeInsertedInFunction += "objTestProcedure=GetObjectReference('frmCommonPage','TestProcedure');" & vbCrLf
                Args.ToBeInsertedInFunction += "objVerificationProcedure=GetObjectReference('frmCommonPage','VerificationProcedure');" & vbCrLf


                'Modified BY NitinVS on 26 Apr 2007 for WhizibleSEM SP 8 Regression Fixes IssueID 12410 
                ' Changed FROMWHERE=SM to FROMWHERE=PM 
                Args.ToBeInsertedInFunction += " objForm = GetFormReference('frmCommonPage');" + vbCrLf
                Args.ToBeInsertedInFunction += "        objForm.action='../TCM/Project_Test_Cases_CommonPage.aspx?Operation=SAVE&Mode=ADD_NEW&FromWhere=PM&PagingAlphabet=-1&ParentTagID=0&COPYDATA=1&ProjectTestCaseID=" + HttpContext.Current.Request.QueryString("ProjectTestCaseID") + "&ProjectTestSetID=" + HttpContext.Current.Request.QueryString("ProjectTestSetID") + "&MasterTagID=3666';" + vbCrLf
                'End Modified BY NitinVS on 26 Apr 2007 for WhizibleSEM SP 8 Regression Fixes IssueID 12410 
                Args.ToBeInsertedInFunction += "        objForm.submit();" + vbCrLf
                Args.ToBeInsertedInFunction += "        return;" + vbCrLf
            End If
        ElseIf HttpContext.Current.Request.QueryString("COPYDATA") <> "1" Then


            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then

                Args.ToBeInsertedInFunction = "var objTestSection,objBriefScenario,objScenario,objTestData;" & vbCrLf
                Args.ToBeInsertedInFunction += "var objPriority,objSeverity,objPlannedStaffTime;" & vbCrLf
                Args.ToBeInsertedInFunction += "var objPreconditionsAndSetup,objTestProcedure,objVerificationProcedure;" & vbCrLf

                Args.ToBeInsertedInFunction += "objTestSection=GetObjectReference('frmCommonPage','TestSection');" & vbCrLf
                Args.ToBeInsertedInFunction += "objBriefScenario=GetObjectReference('frmCommonPage','BriefScenario');" & vbCrLf
                Args.ToBeInsertedInFunction += "objScenario=GetObjectReference('frmCommonPage','Scenario');" & vbCrLf
                Args.ToBeInsertedInFunction += "objTestData=GetObjectReference('frmCommonPage','TestData');" & vbCrLf
                Args.ToBeInsertedInFunction += "objPriority=GetObjectReference('frmCommonPage','Priority');" & vbCrLf
                Args.ToBeInsertedInFunction += "objSeverity=GetObjectReference('frmCommonPage','Severity');" & vbCrLf
                Args.ToBeInsertedInFunction += "objPlannedStaffTime=GetObjectReference('frmCommonPage','PlannedStaffTime');" & vbCrLf
                Args.ToBeInsertedInFunction += "objPreconditionsAndSetup=GetObjectReference('frmCommonPage','PreconditionsAndSetup');" & vbCrLf
                Args.ToBeInsertedInFunction += "objTestProcedure=GetObjectReference('frmCommonPage','TestProcedure');" & vbCrLf
                Args.ToBeInsertedInFunction += "objVerificationProcedure=GetObjectReference('frmCommonPage','VerificationProcedure');" & vbCrLf

            End If
        End If
    End Sub



    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cProject_Test_Cases_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cProject_Test_Cases_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cProject_Test_Cases_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cProject_Test_Cases_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagCLSQL(ByVal WhizGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cProject_Test_Cases_CommonPageSubTagCLSQL(WhizGlobal)
    End Function

    'Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
    '    'Dim strscript As String
    '    'Dim intTestSetId As Integer
    '    'intTestSetId = CInt(HttpContext.Current.Request.QueryString("ProjectTestSetID"))
    '    'If IsEditMode = False Then
    '    '    AfterSave = "opener.location.href='../TCM/Project_Test_Cases_CommonPage.aspx?FromWhere=PM&MasterTagId=3666&ProjectTestSetID=" + CStr(intTestSetId) + "';"
    '    '    AfterSave += vbCrLf + "window.close();"
    '    '    RedirectToCL = False
    '    '    strActionCode = ReturnCodes.ON_LOAD.ToString
    '    'End If
    'End Function
End Class
