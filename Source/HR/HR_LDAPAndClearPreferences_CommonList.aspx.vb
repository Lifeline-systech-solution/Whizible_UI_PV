Imports CommonEngines.General.cEventHandlers

Public Class HR_LDAPAndClearPreferences_CommonList
    Inherits CommonList
    '=====================================================================
    ' Class	Name	        :	HR_LDAPAndClearPreferences_CommonList
    ' Purpose				:	Page for LDAP Authentication and User Preferences
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SuchitraP
    ' Created				:	Jan 03,2008
    ' Revisions				:	
    '=====================================================================
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
    Protected hidLDAPEmployee As String

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        ''Added By Dhanashri S ON 19/04/2017 For Unauthenticated user can view this page.
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Added By Dhanashri S ON 19/04/2017 For Unauthenticated user can view this page.

        Dim strAction As String
        Dim strChkLDAPAuthen As String
        Dim strLDAPArray() As String
        Dim iterator As Integer
        Dim count As Integer = 0
        Dim oldLADPvalue As String
        Dim newLDAPvalue As String
        Dim strchkDelete As String
        Dim strUserPrefArray() As String

        Dim strQuery As String
        Dim strQueryEmpFilters As String
        Dim strFieldFilters As String
        Dim drUserPreferences As IDataReader
        Dim Key As String

        Dim strSQL As String

        iterator = 0

        strAction = Request.QueryString("Action")

        If strAction = "Save" Then
            strChkLDAPAuthen = Request.Form("hidEmployeeIDs")
            strLDAPArray = strChkLDAPAuthen.Split(","c)

            While iterator < strLDAPArray.Length - 1
                oldLADPvalue = Request.Form("hidLDAP" + strLDAPArray(iterator))
                newLDAPvalue = CommonFunction.General.CheckIsNothing(Request.Form("LDAPAuthen" + strLDAPArray(iterator)), "0")
                If oldLADPvalue <> newLDAPvalue Then
                    strSQL = "UPDATE tbl_PM_Employee SET IsLDAPAuthentication=" + newLDAPvalue + " WHERE EmployeeID=" + strLDAPArray(iterator)
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                End If

                iterator = iterator + 1
            End While

            strchkDelete = Request.Form("chkDelete")
            If Not strchkDelete Is Nothing Then
                strUserPrefArray = strchkDelete.Split(","c)

                While count < strUserPrefArray.Length
                    ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                    '' strQuery = "SELECT  * FROM tbl_UI_UserPreferences WHERE UserID = " + strUserPrefArray(count)
                    strQuery = "usp_sel_tbl_UI_UserPreferences_UserID " + strUserPrefArray(count)
                    ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                    drUserPreferences = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    While drUserPreferences.Read
                        Key = drUserPreferences("UserID").ToString() + "-" + drUserPreferences("LoginType").ToString() + "-" + drUserPreferences("Identifier").ToString() + "-" + drUserPreferences("ItemID").ToString()
                        CommonEngines.HashTables.GetHashTableObject.ClearUPFHashTable(Key)
                    End While
                    CommonFunction.Data.DisposeDataReader(drUserPreferences)
                    ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                    '' strQuery = "DELETE FROM tbl_UI_UserPreferences WHERE LoginType='E' AND UserID = " + strUserPrefArray(count)
                    strQuery = "usp_Del_tbl_UI_UserPreferences_LoginType " + strUserPrefArray(count)
                    ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                    strQueryEmpFilters = "DELETE FROM tbl_UI_EMployeeFiltersettings WHERE LoginType='E' AND UserID = " + strUserPrefArray(count)
                    ''  strQueryEmpFilters = "usp_sel_tbl_UI_EMployeeFiltersettings " + strUserPrefArray(count)
                    ''end of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                    CommonFunctions.Data.InsertOrUpdateData(strQueryEmpFilters, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                    ''strFieldFilters = "UPDATE tbl_UI_EmployeeFilterSettings_FieldDetails SET FixedValue = NULL,UserFriendlyFixedValue = NULL WHERE LoginType='E' AND UserID = " + strUserPrefArray(count) + " AND FixedValue IS NOT NULL AND UserFriendlyFixedValue IS NOT NULL"
                    strFieldFilters = "usp_upd_tbl_UI_EmployeeFilterSettings_FieldDetails " + strUserPrefArray(count)
                    ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                    CommonFunctions.Data.InsertOrUpdateData(strFieldFilters, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    CommonFunctions.Data.InsertOrUpdateData("usp_Del_tbl_PM_DefaultTabProject " + strUserPrefArray(count) + ",'E'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    count = count + 1
                End While
            End If
        End If
        CommonFunction.Data.DisposeDataReader(drUserPreferences)

        MyBase.strListPage = "HR_LDAPAndClearPreferences_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"

        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cHR_LDAPAndClearPreferences_CommonListGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidEmployeeIDs' id='hidEmployeeIDs' value='" + cHR_LDAPAndClearPreferences_CommonListGrid.strEmpID + "'>")
    End Function

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    Dim strHtml As String
    '    strHtml = "<script language=javascript>" + vbCrLf
    '    strHtml += "var arrLDAP,i=0;" + vbCrLf
    '    strHtml += "var EmployeeIDs=GetObjectReference('','hidEmployeeIDs').value;" + vbCrLf
    '    strHtml += "if(GetObjectReference('frmCommonList','LDAPSelect').selected==true){" + vbCrLf
    '    strHtml += "if(EmployeeIDs!='' && EmployeeIDs!=null){" + vbCrLf
    '    strHtml += "arrLDAP=EmployeeIDs.split(',');" + vbCrLf
    '    strHtml += "for(i=0;i<arrLDAP.length-1;i++){" + vbCrLf
    '    strHtml += "if(GetObjectReference('','LDAPAuthen'+arrLDAP[i])){" + vbCrLf
    '    strHtml += "GetObjectReference('','LDAPAuthen'+arrLDAP[i]).checked=true;}" + vbCrLf
    '    strHtml += "}}}else{" + vbCrLf
    '    strHtml += "if(EmployeeIDs!='' && EmployeeIDs!=null){" + vbCrLf
    '    strHtml += "arrLDAP=EmployeeIDs.split(',');" + vbCrLf
    '    strHtml += "for(i=0;i<arrLDAP.length-1;i++){" + vbCrLf
    '    strHtml += "if(GetObjectReference('','LDAPAuthen'+arrLDAP[i])){" + vbCrLf
    '    strHtml += "GetObjectReference('','LDAPAuthen'+arrLDAP[i]).checked=true;}" + vbCrLf
    '    strHtml += "}}}" + vbCrLf
    '    strHtml += "</script>" + vbCrLf
    'End Function
End Class

Public Class cHR_LDAPAndClearPreferences_CommonListGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Shared strEmpID As String = ""
    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
        strEmpID = ""
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strEmployeeID As String
        Dim IsLDAPAuthen As Boolean

        strEmployeeID = Args.DataReader("EmployeeID").ToString
        IsLDAPAuthen = CType(Args.DataReader("IsLDAPAuthentication"), Boolean)

        If Args.ColumnName.ToUpper = "LDAP AUTHENTICATION" Then
            Cancel = True
            If IsLDAPAuthen = False Then
                Args.StringToBeInserted = "<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("LDAPAuthen" + strEmployeeID, "LDAPAuthen" + strEmployeeID, "clsCheckBox", False, "1", , "onclick=clearLDAPSelectAllChk(event)", True) + "</TD>"
                CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidLDAP" + strEmployeeID + "' id='hidLDAP'" + strEmployeeID + " value='0'>")
            Else
                Args.StringToBeInserted = "<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("LDAPAuthen" + strEmployeeID, "LDAPAuthen" + strEmployeeID, "clsCheckBox", True, "1", , "onclick=clearLDAPSelectAllChk(event)", True) + "</TD>"
                CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidLDAP" + strEmployeeID + "' id='hidLDAP'" + strEmployeeID + " value='1'>")

            End If
            'Code Added by VidyaK For LDAP Authentication PageWise Saving Issue -WhizibleSem9.0 SP1 --HotFix 9.0.006
            strEmpID += strEmployeeID + ","
            'End Of Code Added by VidyaK For LDAP Authentication PageWise Saving Issue
        End If
    End Sub

    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidEmployeeIDs' id='hidEmployeeIDs' value='" + Args.DataReader("EmployeeID").ToString + "'>")
        'Code Commented by VidyaK For LDAP Authentication PageWise Saving Issue -WhizibleSem9.0 SP1 --HotFix 9.0.006
        ' strEmpID += Args.DataReader("EmployeeID").ToString + ","
        'End of Code Commented by VidyaK--
    End Sub



    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ColumnName = "LDAP Authentication" Then
            Cancel = True
            Args.StringToBeInserted = "<TH  class='divListTag' align='center'>&nbsp;&nbsp;LDAP Authentication <BR>" + CommonFunction.HTMLControls.DrawCheckBox("LDAPSelect", "LDAPSelect", "clsCheckBox", False, , , "onclick=Select_UnSelectAllLDAP()", True) + "</TH>"
        End If

        If Args.ColumnName = "Clear User Preferences" Then
            Cancel = True
            Args.StringToBeInserted = "<TH  class='divListTag' align='center'>&nbsp;&nbsp;Clear User Preferences <BR>" + CommonFunction.HTMLControls.DrawCheckBox("UserPrefSelect", "UserPrefSelect", "clsCheckBox", False, , , "onclick=Select_UnSelectAllUser()", True) + "</TH>"
        End If

    End Sub
End Class