
Option Strict Off

'=====================================================================
' Module Name   :   Project Profit by Site Rates (Role / Resource)
' Purpose       :   To Display the Details of Site Rates (Role / Resource)
' Description   :   Same as above
' Dependencies  :   Resource file for the same
' Author        :   PrashantSJ
' Created       :   Nov 18, 2008
' Revisions     :
'=====================================================================
#Region " Imports "
Imports System.Text
#End Region
Public Class ProjectProfitBy_SiteRates
    Inherits WebPage.Templates.WhizTemplate
#Region " Member variables "

    Protected m_SBHTML As StringBuilder
    Protected WithEvents m_objMenu As WebPage.Templates.StaticMenu
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private cObjSectionTitle As WebPage.Templates.SectionTitle


    Protected m_strSQL As String = ""
    Protected drRole As IDataReader
    Protected m_strMode As String = ""
    Protected m_strRoleID As String = ""

    Protected m_strAction As String = ""
    
    Protected m_dsRoleRate As DataSet

    Protected blnIsRateExits As Boolean
    Private m_strScript As New System.Text.StringBuilder
    Protected m_strComboboxHTML As String = ""
    Protected m_strRoleComboHTML As String = ""

    Protected m_arrPrimaryKey() As String
    Protected m_strUserName As String = ""
    Protected m_lngProjectID As Long = 0
    Protected m_strEntityName As String = ""
    Protected m_strProjectStartDate As String = ""
    Protected m_strProjectEndDate As String = ""

    Protected m_blnSingleSite As Boolean
    Protected m_strFrom As String = ""
    Protected m_strEmployeeID As String = ""
    Protected m_strContractType As String = ""
    Protected m_StrFromDateHTML As String = ""
    Protected m_strLeavingDate As String = ""

    Protected blnIsExtrHrsBilling As Boolean = True
#End Region
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

        'Added by Yogesh J on on 28-MAR-2016 to validate Token
        If Request.QueryString("FromWhere") = "PM" Then
            If Request.QueryString("EmployeeID") IsNot Nothing And Request.QueryString("MToken") IsNot Nothing Then

                If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("EmployeeID"), String) + CType(0, String) + CType(0, String), Request.QueryString("MToken")) = False) Then
                    '   Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(Request.QueryString("UniqueID"), String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If

        End If
        If Request.QueryString("FromWhere") = "PM" Then
            If Request.QueryString("RoleID") IsNot Nothing And Request.QueryString("MToken") IsNot Nothing Then

                If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("RoleID"), String) + CType(0, String) + CType(0, String), Request.QueryString("MToken")) = False) Then
                    '   Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(Request.QueryString("UniqueID"), String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If

        End If
        'End of addition by Yogesh J on on 28-MAR-2016 to validate Token
    End Sub
    Protected Sub PageInit()
        '====================================================================
        ' Procedure Name    :      PageInit
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To init page details
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================
        'Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.ApplySecurity(True)
        'End Of Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)

        GetGlobalObject()

        GetTagAccessRights()

        InitializeVariables()


        PerformAction()

        GetDatabaseValues()

        DrawHiddenFields()

        DrawMenu()
        Response.Write("<br>")
        Response.Write("<div Id=divPage Style='OVERFLOW:auto; WIDTH:100%;z-index:2;'>")


        DrawMasterSection()


        m_strScript.Append("<script language=""javascript"">")
        m_strScript.Append("var arrRoleRateID=new Array();")

        Response.Write("<br>")
        If m_strFrom.ToUpper.Trim = "ROLE" Then
            DrawRolRate()
        Else
            DrawResourceRate()
        End If
        Response.Write("<br>")

        m_strScript.Append("</script>")
        Response.Write(m_strScript.ToString())

        Response.Write("</div>")
        DisposeDataSetObjects()

    End Sub
    Private Sub DisposeDataSetObjects()
        '====================================================================
        ' Procedure Name    :      DisposeDataSetObjects
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To dispose Dataset objects
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Nov 18, 2008
        ' Revisions         :
        '=====================================================================
        m_dsRoleRate = Nothing

    End Sub
    Protected Sub InitializeVariables()
        '====================================================================
        ' Procedure Name    :      InitializeVariables
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To init page varaibles
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================

        If Not Request.Form("hidtxtFrom") Is Nothing Then
            m_strFrom = Convert.ToString(CommonFunction.General.CheckIsNothing(Request.Form("hidtxtFrom")))
        Else
            m_strFrom = Convert.ToString(CommonFunction.General.CheckIsNothing(Request.QueryString("From")))
        End If

        If m_strFrom.ToUpper.Trim = "ROLE" Then
            If Not Request.Form("txtRoleID") Is Nothing Then
                m_strRoleID = CType(Request.Form("txtRoleID"), String)
            Else
                m_strRoleID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RoleID"), "0"), String)
            End If
        Else
            If Not Request.Form("hidtxtEmployeeID") Is Nothing Then
                m_strEmployeeID = Convert.ToString(CommonFunction.General.CheckIsNothing(Request.Form("hidtxtEmployeeID")))
            Else
                m_strEmployeeID = Convert.ToString(CommonFunction.General.CheckIsNothing(Request.QueryString("EmployeeID")))
            End If
        End If


        m_strAction = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("Action"), ""), String)

        If Not Request.QueryString.Get("Mode") Is Nothing Then
            m_strMode = CommonFunction.General.CheckIsNothing(Request.QueryString.Get("Mode"), "")
        End If

        m_strUserName = CommonFunction.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName")))
        m_lngProjectID = CLng(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"))


        m_strSQL = "usp_Sel_tbl_PM_WorkOrderRateContract " & m_lngProjectID.ToString
        drRole = CommonFunction.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        If drRole.Read Then
            m_blnSingleSite = CType(CommonFunction.Data.CheckIsDBNull(drRole("IsSingleSiteBilling"), "0"), Boolean)
            blnIsExtrHrsBilling = CBool(CommonFunction.Data.CheckIsDBNull(drRole("IsExtraHrsBilling"), "0"))
        End If
        CommonFunction.Data.DisposeDataReader(drRole)

    End Sub
    Protected Sub GetDatabaseValues()
        '====================================================================
        ' Procedure Name    :      GetDatabaseValues
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To get BOM Master details from Database.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================

        
        If m_strFrom.ToUpper.Trim = "ROLE" Then
            m_strSQL = "usp_Sel_tbl_PM_SiteRoleRates " & " " & m_lngProjectID.ToString & "," & m_strRoleID & "," & IIf(m_blnSingleSite, "1", "0")
            m_dsRoleRate = CommonFunction.Data.GetDataSet(m_strSQL, "Rate", , , MyBase.UseSQL)


            If m_dsRoleRate.Tables(0).Rows.Count > 0 Then
                blnIsRateExits = True

            End If
            m_strSQL = "usp_Sel_tbl_PM_Role " & " " & m_strRoleID
            drRole = CommonFunction.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            If drRole.Read Then
                m_strEntityName = Convert.ToString(CommonFunction.Data.CheckIsDBNull(drRole("RoleDescription")))
            End If
            CommonFunction.Data.DisposeDataReader(drRole)
        Else
            m_strSQL = "usp_Sel_tbl_PM_EmployeeBillingInfo " & " " & m_lngProjectID.ToString & "," & m_strEmployeeID & "," & IIf(m_blnSingleSite, "1", "0")
            m_dsRoleRate = CommonFunction.Data.GetDataSet(m_strSQL, "Rate", , , MyBase.UseSQL)

            If m_dsRoleRate.Tables(0).Rows.Count > 0 Then
                blnIsRateExits = True

            End If

            m_strSQL = "usp_Sel_tbl_PM_EmployeeProfile " & " " & m_strEmployeeID
            drRole = CommonFunction.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
            If drRole.Read Then
                m_strEntityName = Convert.ToString(CommonFunction.Data.CheckIsDBNull(drRole("EmployeeName")))
                m_strLeavingDate = CType(CommonFunction.Data.CheckIsDBNull(drRole("LeavingDate")), String)
            End If
            CommonFunction.Data.DisposeDataReader(drRole)

            If m_strLeavingDate <> "" Then
                m_strLeavingDate = CommonFunction.Dates.GetDate(CType(m_strLeavingDate, Date))
            End If

        End If

       

        m_strSQL = "usp_Sel_tbl_PM_Project " & " " & m_lngProjectID.ToString
        drRole = CommonFunction.Data.GetDataReader(m_strSQL, MyBase.UseSQL)
        If drRole.Read Then
            m_strProjectStartDate = CType(CommonFunction.Data.CheckIsDBNull(drRole("ExpectedStartDate")), String)
            m_strProjectEndDate = CType(CommonFunction.Data.CheckIsDBNull(drRole("ExpectedEndDate")), String)
            m_strContractType = CType(CommonFunction.Data.CheckIsDBNull(drRole("ContractType")), String)
        End If
        CommonFunction.Data.DisposeDataReader(drRole)

        If m_strProjectStartDate <> "" Then
            m_strProjectStartDate = CommonFunction.Dates.GetDate(CType(m_strProjectStartDate, Date))
        End If
        If m_strProjectEndDate <> "" Then
            m_strProjectEndDate = CommonFunction.Dates.GetDate(CType(m_strProjectEndDate, Date))
        End If
        If m_strContractType <> "5" Then
            blnIsExtrHrsBilling = True
        End If
    End Sub
    Protected Sub DrawHiddenFields()
        '====================================================================
        ' Procedure Name    :      DrawHiddenFields
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw Hidden data fields.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidtxtFrom", "hidtxtFrom", , , , m_strFrom, , , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        If m_strFrom.ToUpper.Trim = "ROLE" Then
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtRoleID", "txtRoleID", , , , m_strRoleID, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        Else
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            Response.Write(CommonFunction.HTMLControls.DrawTextBox("hidtxtEmployeeID", "hidtxtEmployeeID", , , , m_strEmployeeID, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        End If
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtItems", "txtItems", , , , , IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        Response.Write(CommonFunctions.HTMLControls.DrawDateControl("dtProjectStartDate", "dtProjectStartDate", , , m_strProjectStartDate, , "frmRoleRate", , , , , , , True, , , , True))
        Response.Write(CommonFunctions.HTMLControls.DrawDateControl("dtProjectEndDate", "dtProjectEndDate", , , m_strProjectEndDate, , "frmRoleRate", , , , , , , True, , , , True))
        Response.Write(CommonFunctions.HTMLControls.DrawDateControl("dtResourceLeavingDate", "dtResourceLeavingDate", , , m_strLeavingDate, , "frmRoleRate", , , , , , , True, , , , True))

        Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cmbSiteCurrency", "usp_sel_ProjectSiteCurrency" + " " + m_lngProjectID.ToString, , , , True, True, , , , True))
        '  Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cmbSiteRateMethod", "usp_Sel_Site_RateMethod_Lable" + " " + m_lngProjectID.ToString, , , , True, True, , , , True))

        Response.Write(CommonFunctions.HTMLControls.DrawComboBox("cmbHidRoleRate", "usp_Sel_ProjectSiteRoleRates" + " " + m_lngProjectID.ToString, , , , True, True, , , , True))



    End Sub
    Protected Sub PerformAction()
        m_SBHTML = New StringBuilder("")
        Dim strItemList As String = ""
        Dim i As Integer = 0



        If m_strAction.ToUpper = "SAVE" Then
            Dim strSiteID As String = ""
            Dim dblNormalRate As Double = 0.0
            Dim dblExtraRate As Double = 0.0
            Dim dblHolidayRate As Double = 0.0
            Dim dblCTC As Double = 0.0
            Dim intRoleID As Integer = 0
            Dim strFromDate As String = ""

            m_arrPrimaryKey = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("txtDatabaseItem"), "").Split(",")


            For i = 0 To m_arrPrimaryKey.Length - 2

                strSiteID = CommonFunction.General.CheckIsNothing(Request.Form("cmbSite" + m_arrPrimaryKey(i)))
              
                dblNormalRate = Convert.ToDouble(CommonFunction.General.CheckIsNothing(Request.Form("txtNormalRate" + m_arrPrimaryKey(i)), "0.0"))
                dblExtraRate = Convert.ToDouble(CommonFunction.General.CheckIsNothing(Request.Form("txtExtraRate" + m_arrPrimaryKey(i)), "0.0"))
                If Convert.ToString(CommonFunction.General.CheckIsNothing(Request.Form("txtHolidayRate" + m_arrPrimaryKey(i)), "0")) <> "" Then
                    dblHolidayRate = Convert.ToDouble(CommonFunction.General.CheckIsNothing(Request.Form("txtHolidayRate" + m_arrPrimaryKey(i)), "0"))
                Else
                    dblHolidayRate = 0.0
                End If

                'If Convert.ToString(CommonFunction.General.CheckIsNothing(Request.Form("txtCTC" + m_arrPrimaryKey(i)), "0")) <> "" Then
                '    dblCTC = Convert.ToDouble(CommonFunction.General.CheckIsNothing(Request.Form("txtCTC" + m_arrPrimaryKey(i)), "0"))
                'Else
                '    dblCTC = 0.0
                'End If

                If m_strFrom.ToUpper.Trim = "ROLE" Then
                    m_strSQL = "usp_Ins_Upd_tbl_PM_SiteRoleRates" + " " + m_lngProjectID.ToString + "," + m_strRoleID + ",NULL," + m_arrPrimaryKey(i) + ",NULL," + dblNormalRate.ToString + "," + dblExtraRate.ToString + "," + dblHolidayRate.ToString + ",N'" + m_strUserName + "'"
                Else
                    m_strSQL = "usp_UPD_tbl_PM_EmployeeBillingInfo" + " " + m_lngProjectID.ToString + "," + m_strEmployeeID + "," + m_arrPrimaryKey(i) + ",NULL,NULL,NULL," + dblNormalRate.ToString + "," + dblExtraRate.ToString + "," + dblHolidayRate.ToString + ",0," + m_objGlobal.UserID.ToString
                End If

                CommonFunction.Data.InsertOrUpdateData(m_strSQL, MyBase.UseSQL)
            Next


            Dim arrItem As String() = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("txtItems"), "").Split(",")
            For i = 0 To arrItem.Length - 2

                If m_blnSingleSite Then
                    strSiteID = CommonFunction.General.CheckIsNothing(Request.Form("txtDefaultSite"))
                Else
                    strSiteID = CommonFunction.General.CheckIsNothing(Request.Form("cmbSite_" + arrItem(i)))
                End If
                If m_strFrom.ToUpper.Trim = "RESOURCE" Then
                    intRoleID = CInt(CommonFunction.General.CheckIsNothing(Request.Form("cmbRole_" + arrItem(i)), "0"))
                End If

                strFromDate = CommonFunction.General.CheckIsNothing(Request.Form("dtFromDate_" + arrItem(i)))

                strFromDate = CommonFunction.Dates.CGetDate(Convert.ToDateTime(strFromDate))

                dblNormalRate = Convert.ToDouble(CommonFunction.General.CheckIsNothing(Request.Form("txtNormalRate_" + arrItem(i)), "0.0"))
                dblExtraRate = Convert.ToDouble(CommonFunction.General.CheckIsNothing(Request.Form("txtExtraRate_" + arrItem(i)), "0.0"))
                If Convert.ToString(CommonFunction.General.CheckIsNothing(Request.Form("txtHolidayRate_" + arrItem(i)), "0")) <> "" Then
                    dblHolidayRate = Convert.ToDouble(CommonFunction.General.CheckIsNothing(Request.Form("txtHolidayRate_" + arrItem(i)), "0"))
                Else
                    dblHolidayRate = 0.0
                End If

                'If Convert.ToString(CommonFunction.General.CheckIsNothing(Request.Form("txtCTC" + arrItem(i)), "0")) <> "" Then
                '    dblCTC = Convert.ToDouble(CommonFunction.General.CheckIsNothing(Request.Form("txtCTC" + arrItem(i)), "0"))
                'Else
                '    dblCTC = 0.0
                'End If
                If m_strFrom.ToUpper.Trim = "ROLE" Then
                    m_strSQL = "usp_Ins_Upd_tbl_PM_SiteRoleRates" + " " + m_lngProjectID.ToString + "," + m_strRoleID + "," + strSiteID + ",NULL,'" + strFromDate + "'," + dblNormalRate.ToString + "," + dblExtraRate.ToString + "," + dblHolidayRate.ToString + ",N'" + m_strUserName + "'"
                Else
                    m_strSQL = "usp_UPD_tbl_PM_EmployeeBillingInfo" + " " + m_lngProjectID.ToString + "," + m_strEmployeeID + ",NULL," + strSiteID + "," + intRoleID.ToString + ",'" + strFromDate + "'," + dblNormalRate.ToString + "," + dblExtraRate.ToString + "," + dblHolidayRate.ToString + ",0," + m_objGlobal.UserID.ToString
                End If
                CommonFunction.Data.InsertOrUpdateData(m_strSQL, MyBase.UseSQL)
            Next
        ElseIf m_strAction.ToUpper = "DELETE" Then
            strItemList = CommonFunction.General.CheckIsNothing(Request.Form("chkDelete"))
            If strItemList <> "" Then
                If m_strFrom.ToUpper.Trim = "ROLE" Then
                    m_SBHTML.Append("usp_Del_tbl_PM_SiteRoleRates" & vbCrLf)
                    m_SBHTML.Append(" " & vbCrLf)
                    m_SBHTML.Append(m_lngProjectID.ToString & vbCrLf)
                    m_SBHTML.Append("," & m_strRoleID & vbCrLf)
                    m_SBHTML.Append(",N'" & strItemList & "'" & vbCrLf)
                    m_SBHTML.Append(",N'" + m_strUserName + "'" & vbCrLf)
                Else
                    m_SBHTML.Append("usp_Del_EmployeeBillingInfo" & vbCrLf)
                    m_SBHTML.Append(" " & vbCrLf)
                    m_SBHTML.Append(m_lngProjectID.ToString & vbCrLf)
                    m_SBHTML.Append("," & m_strEmployeeID & vbCrLf)
                    m_SBHTML.Append(",N'" & strItemList & "'" & vbCrLf)
                    m_SBHTML.Append("," + m_objGlobal.UserID.ToString & vbCrLf)
                End If
                CommonFunction.Data.InsertOrUpdateData(m_SBHTML.ToString, MyBase.UseSQL)
            End If

            End If

        If m_strAction.ToUpper <> "" Then
            Dim strRefersh As New StringBuilder

            strRefersh.Append("<script language=javascript>")
            strRefersh.Append("refreshParent('frmContractRate','ProjectContractBy_Sites.aspx','../PRJPROFIT/ProjectContractBy_Sites.aspx?FromWhere=PM',true);")
            strRefersh.Append("</script>")

            Response.Write(strRefersh.ToString)
            strRefersh = Nothing
        End If

        m_SBHTML = Nothing

    End Sub
    Protected Sub DrawMenu()
        '====================================================================
        ' Procedure Name    :      DrawMenu
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw menu  details.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips
        m_SBHTML = New StringBuilder


        'If m_objAccessRights.Edit = True Then
        ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/Save.gif'>&nbsp;Save")
        ArrMenuToolTipsList.Add("Save")
        ArrClientSideFunctionsList.Add("Save_OnClick()")
        ' End If

        If blnIsRateExits Then
            ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/delete.gif'>&nbsp;Delete")
            ArrMenuToolTipsList.Add("Delete")
            ArrClientSideFunctionsList.Add("DeleteItems_OnClick()")

            ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/SelectAll.gif'>&nbsp;Selete All")
            ArrMenuToolTipsList.Add("Selete All")
            ArrClientSideFunctionsList.Add("SelectAll_OnClick('frmRoleRate','chkDelete')")

            ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/ClearAll.gif'>&nbsp;Clear All")
            ArrMenuToolTipsList.Add("Clear All")
            ArrClientSideFunctionsList.Add("ClearAll_OnClick('frmRoleRate','chkDelete')")


        End If

        'If m_strRoleID <> "0" Then
        '    ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/ViewHistory.gif'>&nbsp;History")
        '    ArrMenuToolTipsList.Add("History")
        '    ArrClientSideFunctionsList.Add("History_OnClick(" + m_strRoleID + ")")
        'End If

        'ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/back.gif'>&nbsp;Back")
        'ArrMenuToolTipsList.Add("Back")
        'ArrClientSideFunctionsList.Add("Back_OnClick('" + m_strFrom + "'," + IIf(m_blnSingleSite, "1", "0") + ")")

        ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/close.gif'>&nbsp;Close")
        ArrMenuToolTipsList.Add("Close")
        ArrClientSideFunctionsList.Add("Close_OnClick()")

        ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>&nbsp;")
        ArrMenuToolTipsList.Add("Help")
        ArrClientSideFunctionsList.Add("Help_OnClick('" + CommonFunction.Constants.APP_TAG_PROFIT_SITEROLE_RATE.ToString + "')")


        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing

        m_objMenu = New WebPage.Templates.StaticMenu
        m_SBHTML.Append(m_objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True))

        Response.Write(m_SBHTML.ToString)
        m_SBHTML = Nothing
    End Sub
    Protected Sub DrawMasterSection()
        '====================================================================
        ' Procedure Name    :      DrawMasterSection
        ' Parameters Passed :      None
        ' Returns           :      None 
        ' Parameters Affected :    None
        ' Purpose           :      To draw MasterSections details.
        ' Description       :      Same as purpose.
        ' Assumptions       :      None 
        ' Dependencies      :      None  
        ' Author            :      PrashantSJ
        ' Created           :      Sept 08, 2008
        ' Revisions         :
        '=====================================================================
        Dim strCaption As String = ""
        cObjSectionTitle = New WebPage.Templates.SectionTitle
        m_SBHTML = New StringBuilder
        With cObjSectionTitle

            If m_strFrom.ToUpper.Trim = "ROLE" Then
                strCaption = "Role Rate Details [ Role: " + m_strEntityName + " ]"
            Else
                If m_strContractType = "2" Or m_strContractType = "5" Or m_strContractType = "6" Then
                    strCaption = "Resource Rate History [ Resource: " + m_strEntityName + " ]"
                Else
                    strCaption = "Role Change History [ Resource: " + m_strEntityName + " ]"
                End If
                End If

                m_SBHTML.Append(.GetSectionTitle(strCaption, "divRoleSection", "HideShowRoleSection", , , , , , , , , , , ) & vbCrLf)
                m_SBHTML.Append("<SCRIPT Language=javascript>" & vbCrLf)
                m_SBHTML.Append(.ClientsideScript & vbCrLf)
                m_SBHTML.Append("</SCRIPT>" & vbCrLf)
        End With
        Response.Write(m_SBHTML.ToString)
        m_SBHTML = Nothing
        cObjSectionTitle = Nothing
    End Sub

    '=====================================================================
    ' Procedure Name        : GetGlobalObject()	
    ' Purpose               : Function To Fill Global Object
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : July 29, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject
    End Sub
    '=====================================================================
    ' Procedure Name        : GetTagAccessRights()	
    ' Purpose               : Function To Get access rights for selected TAG
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : PrashantSJ
    ' Created               : July 3, 2007
    ' Revisions             :
    '=====================================================================
    Private Sub GetTagAccessRights()
        If m_strFrom.ToUpper = "ROLE" Then
            m_objGlobal.TagID = CommonFunction.Constants.APP_TAG_PROFIT_SITEROLE_RATE
        Else
            m_objGlobal.TagID = CommonFunction.Constants.APP_TAG_TAB_EMP_RATE_INFO
        End If
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

    End Sub

    Protected Sub DrawRolRate()
        '=====================================================================
        ' Procedure Name        : DrawRolRate()	
        ' Purpose               : To plot OverHeads Grid 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : PrashantSJ
        ' Created               : Sept 16, 2008
        ' Revisions             :
        '=====================================================================
        m_SBHTML = New StringBuilder

        Dim strRoleRateID As String = ""
        Dim strSiteRoleRateIDList As String = ""
        Dim iRowCount As Integer = 0
        Dim strPreviousField As String = "0"
        Dim blnIsDisabled As Boolean = False
        Dim blnIsShowHistory As Boolean = False
        Dim strCurrencySymbol As String = ""
        Dim strPreviousSite As String = ""
        Dim strSiteID As String = ""
        Dim RowCount As Integer = 0

        With m_SBHTML
            m_strComboboxHTML = CommonFunctions.HTMLControls.DrawComboBox("cmbSite", "usp_sel_tbl_PM_ProjectSite" + " " + m_lngProjectID.ToString, 200, , "onchange=Site_OnChange", True, True, , , , m_blnSingleSite)
            m_StrFromDateHTML = CommonFunctions.HTMLControls.DrawDateControl("dtFromDate", "dtFromDate", , , , , "frmRoleRate", , , , , , , True, True, , )

            .Append("<div Id=divRoleSection Style='OVERFLOW:auto; WIDTH:100%;'>" + vbCrLf)
            .Append("<table class='clsGridTable' id='tblRoleRate' width='100%'  border=0 cellspacing=1 cellpadding=0>" + vbCrLf)

            .Append("<tr class='clsTRColumnHeader'>" + vbCrLf)
            .Append("<td  align='center'><b>Sr. No. </b>" + vbCrLf)
            .Append("</td>" + vbCrLf)
            If Not m_blnSingleSite Then
                .Append("<td  align='left'><b>" + vbCrLf)
                .Append("Site" + vbCrLf)
                .Append("</b></td>" + vbCrLf)
            End If

            .Append("<td  align='left'><b>" + vbCrLf)
            .Append("Effective From Date" + vbCrLf)
            .Append("</b></td>")

            .Append("<td  align='left'><b>" + vbCrLf)
            .Append("To Date" + vbCrLf)
            .Append("</b></td>" + vbCrLf)

            .Append("<td  align='right'><b>" + vbCrLf)
            .Append("Normal Rate" + vbCrLf)
            .Append("</b></td>" + vbCrLf)

            .Append("<td  align='right'><b>" + vbCrLf)
            .Append("Extra Rate" + vbCrLf)
            .Append("</b></td>" + vbCrLf)

            .Append("<td  align='right'><b>" + vbCrLf)
            .Append("Holiday Rate" + vbCrLf)
            .Append("</b></td>" + vbCrLf)

            '.Append("<td  align='center'><b>" + vbCrLf)
            '.Append("CTC" + vbCrLf)
            '.Append("</b></td>" + vbCrLf)

            .Append("<td  align='left'><b>" + vbCrLf)
            .Append("Show History" + vbCrLf)
            .Append("</b></td>" + vbCrLf)

            .Append("<td align='center'><b>" + vbCrLf)
            .Append("Delete" + vbCrLf)
            .Append("</b></td>" + vbCrLf)
            .Append("</tr>" + vbCrLf)


            For Each drRoleRate As DataRow In m_dsRoleRate.Tables(0).Rows
                strRoleRateID = CommonFunction.Data.CheckIsDBNull(drRoleRate("SiteRoleRateID"))
                blnIsDisabled = CType(CommonFunction.Data.CheckIsDBNull(drRoleRate("IsDisabled")), Boolean)
                blnIsShowHistory = CType(CommonFunction.Data.CheckIsDBNull(drRoleRate("IsShowHistory")), Boolean)
                strCurrencySymbol = Convert.ToString(CommonFunction.Data.CheckIsDBNull(drRoleRate("CurrencySymbol")))
                strSiteID = Convert.ToString(CommonFunction.Data.CheckIsDBNull(drRoleRate("SiteID")))
                strSiteRoleRateIDList += strRoleRateID + ","
                RowCount += 1
                If strPreviousSite <> Convert.ToString(CommonFunction.Data.CheckIsDBNull(drRoleRate("Name"))) And Not m_blnSingleSite Then
                    .Append("<tr class=clsTRGroupHeader>" + vbCrLf)
                    .Append("<td align=center>&nbsp;</td>" + vbCrLf)
                    .Append("<td  align=left colspan='8'>" + Convert.ToString(CommonFunction.Data.CheckIsDBNull(drRoleRate("Name"))) + "</td>" + vbCrLf)
                    .Append("</tr>")
                    iRowCount += 1
                End If
                .Append("<tr class=clsTRBlank>" + vbCrLf)
                .Append("<td align=center>" + Convert.ToString(RowCount) + "</td>" + vbCrLf)
                .Append(CommonFunctions.HTMLControls.DrawComboBox("cmbSite" + strRoleRateID, "usp_sel_tbl_PM_ProjectSite" + " " + m_lngProjectID.ToString + ",0," + CommonFunction.Data.CheckIsDBNull(drRoleRate("SiteID"), "").ToString, 200, CommonFunction.Data.CheckIsDBNull(drRoleRate("SiteID"), ""), "disabled", True, True, , True, , True) + vbCrLf)
                If Not m_blnSingleSite Then
                    .Append("<td  align=left>&nbsp;</td>" + vbCrLf)
                End If
                .Append(CommonFunctions.HTMLControls.DrawDateControl("dtFromDate" + strRoleRateID, "dtFromDate" + strRoleRateID, , , CommonFunction.Data.CheckIsDBNull(drRoleRate("StartDate"), ""), , "frmRoleRate", , , , True, , , True, True, , , True) + vbCrLf)

                .Append("<td  align=left><font size='1' face='Verdana'>" + CommonFunction.Dates.CGetDate(CommonFunction.Data.CheckIsDBNull(drRoleRate("StartDate"), "")) + "</font></td>" + vbCrLf)
                .Append("<td  align=left><font size='1' face='Verdana'>" + vbCrLf)

                If CommonFunction.Data.CheckIsDBNull(drRoleRate("EndDate"), "") <> "" Then
                    .Append(CommonFunction.Dates.CGetDate(CType(drRoleRate("EndDate"), Date)) + vbCrLf)
                Else
                    .Append("&nbsp;")
                End If

                .Append("</font></td>" + vbCrLf)

                'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                .Append("<td  align=right><label align='right'>" + strCurrencySymbol + "</label>" + CommonFunctions.HTMLControls.DrawTextBox("txtNormalRate" + strRoleRateID, "txtNormalRate" + strRoleRateID, , 100, 10, value:=CommonFunction.Data.CheckIsDBNull(drRoleRate("NormalRate"), "").ToString, textAlign:="Right", returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True) + "</td>" + vbCrLf)
                .Append("<td  align=right><label align='right'>" + strCurrencySymbol + "</label>" + CommonFunctions.HTMLControls.DrawTextBox("txtExtraRate" + strRoleRateID, "txtExtraRate" + strRoleRateID, , 100, 10, value:=CommonFunction.Data.CheckIsDBNull(drRoleRate("ExtraRate"), "").ToString, textAlign:="Right", returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True) + "</td>" + vbCrLf)
                .Append("<td  align=right><label align='right'>" + strCurrencySymbol + "</label>" + CommonFunctions.HTMLControls.DrawTextBox("txtHolidayRate" + strRoleRateID, "txtHolidayRate" + strRoleRateID, , 100, 10, value:=CommonFunction.Data.CheckIsDBNull(drRoleRate("HolidayRate"), "").ToString, textAlign:="Right", returnHTML:=True, IsMandatory:=False, EnableHTMLEncode:=True) + "</td>" + vbCrLf)
                '.Append("<td  align=right><label align='right'>" + strCurrencySymbol + "</label>" + CommonFunctions.HTMLControls.DrawTextBox("txtCTC" + strRoleRateID, "txtCTC" + strRoleRateID, , 100, value:=CommonFunction.Data.CheckIsDBNull(drRoleRate("CTC"), "").ToString, textAlign:="Right", returnHTML:=True, IsMandatory:=False) + "</td>" + vbCrLf)
                'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding

                .Append("<td  align=left>" + vbCrLf)
                If blnIsShowHistory Then
                    .Append("<a title='Show History' href='javascript:History_OnClick(" + strRoleRateID + ",3969,0)'>Show History</a>" + vbCrLf)
                Else
                    .Append("&nbsp;")
                End If
                .Append("</td>" + vbCrLf)
                .Append("<td  align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , strRoleRateID, blnIsDisabled, , True) + "</td>" + vbCrLf)
                m_strScript.Append("arrRoleRateID.push(" + strRoleRateID + ");")
                .Append("</tr>" + vbCrLf)
                strPreviousSite = Convert.ToString(CommonFunction.Data.CheckIsDBNull(drRoleRate("Name")))
            Next
            
            If m_blnSingleSite Then
                'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                .Append(CommonFunctions.HTMLControls.DrawTextBox("txtDefaultSite", "txtDefaultSite", , , , strSiteID, , , , , , True, , True, EnableHTMLEncode:=True) + vbCrLf)
                'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            End If
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtItemCount", "txtItemCount", , , , m_dsRoleRate.Tables(0).Rows.Count + iRowCount, "RIGHT", IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True) + vbCrLf)
            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtPreItemCount", "txtPreItemCount", , , , m_dsRoleRate.Tables(0).Rows.Count + iRowCount, "RIGHT", IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True) + vbCrLf)
            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtDatabaseItem", "txtDatabaseItem", , , , strSiteRoleRateIDList, "RIGHT", IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True) + vbCrLf)
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding

            .Append("<Tr class=clsTREven id=""TRAdd"" >" + vbCrLf)
            .Append("<td width=10px ALIGN='center'>" + vbCrLf)
            .Append("<A href='Javascript:CreateRowForRoleRate(""" + m_strFrom + """)'" + vbCrLf)
            .Append("><Img Border=0 id=tdShowHide Src='../../Images/right.gif' title=''></A>" + vbCrLf)
            .Append("</td>" + vbCrLf)
            .Append("<td ALIGN='center' colspan=9></td>" + vbCrLf)
            .Append("</tr>" + vbCrLf)

            .Append("</table>" + vbCrLf)
            .Append("</div>" + vbCrLf)
        End With

        Response.Write(m_SBHTML.ToString)
        m_SBHTML = Nothing
    End Sub
    Protected Sub DrawResourceRate()
        '=====================================================================
        ' Procedure Name        : DrawResourceRate()	
        ' Purpose               : To plot resource rate details.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : PrashantSJ
        ' Created               : Sept 16, 2008
        ' Revisions             :
        '=====================================================================
        m_SBHTML = New StringBuilder

        Dim strEmployeeBillingInfoID As String = ""
        Dim strEmployeeBillingInfoIDList As String = ""
        Dim iRowCount As Integer = 0
        Dim RowCount As Integer = 0
        Dim strPreviousField As String = "0"
        Dim blnIsDisabled As Boolean = False
        Dim blnIsShowHistory As Boolean = False
        Dim strCurrencySymbol As String = ""
        Dim strPreviousSite As String = ""
        Dim strSiteID As String = ""
        Dim strRoleID As String = ""
        Dim strEndDate As String = ""

        With m_SBHTML

           

            .Append("<div Id=divRoleSection Style='OVERFLOW:auto; WIDTH:100%;'>" + vbCrLf)
            .Append("<table class='clsGridTable' id='tblRoleRate' width='100%'  border=0 cellspacing=1 cellpadding=0>" + vbCrLf)

            .Append("<tr class='clsTRColumnHeader'>" + vbCrLf)
            .Append("<td  align='center'><b>Sr. No." + vbCrLf)
            .Append("</b></td>" + vbCrLf)
            If Not m_blnSingleSite Then
                .Append("<td  align='left'><b>" + vbCrLf)
                .Append("Site" + vbCrLf)
                .Append("</b></td>" + vbCrLf)
            End If
            .Append("<td  align='left'><b>" + vbCrLf)
            .Append("Role" + vbCrLf)
            .Append("</b></td>" + vbCrLf)

            .Append("<td  align='left'><b>" + vbCrLf)
            .Append("Effective From Date" + vbCrLf)
            .Append("</b></td>")

            .Append("<td  align='left'><b>" + vbCrLf)
            .Append("To Date" + vbCrLf)
            .Append("</b></td>" + vbCrLf)
            If m_strContractType = "2" Or m_strContractType = "5" Or m_strContractType = "6" Then

                .Append("<td  align='right'><b>" + vbCrLf)
                .Append("Normal Rate  " + vbCrLf)
                .Append("<label id='lblhdrNR'>")
                If m_strContractType = "5" Then
                    .Append("(Per Month)" + vbCrLf)
                Else
                    .Append("&nbsp;" + vbCrLf)
                End If
                .Append("</lable>" + vbCrLf)
                .Append("</b></td>" + vbCrLf)
                If m_strContractType = "2" Or m_strContractType = "6" Or (m_strContractType = "5" And blnIsExtrHrsBilling) Then
                    .Append("<td  align='right'><b>" + vbCrLf)
                    .Append("Extra Rate  " + vbCrLf)
                    .Append("<label id='lblhdrER'>")
                    If m_strContractType = "5" Then
                        .Append("(Per Hour)" + vbCrLf)
                    Else
                        .Append("&nbsp;" + vbCrLf)
                    End If
                    .Append("</lable>" + vbCrLf)
                    .Append("</b></td>" + vbCrLf)

                    .Append("<td  align='right'><b>" + vbCrLf)
                    .Append("Holiday Rate  " + vbCrLf)
                    .Append("<label id='lblhdrHR'>")
                    If m_strContractType = "5" Then
                        .Append("(Per Hour)" + vbCrLf)
                    Else
                        .Append("&nbsp;" + vbCrLf)
                    End If
                    .Append("</lable>" + vbCrLf)
                    .Append("</b></td>" + vbCrLf)
                End If
            End If
            '.Append("<td  align='center'><b>" + vbCrLf)
            '.Append("CTC" + vbCrLf)
            '.Append("</b></td>" + vbCrLf)

            .Append("<td  align='left'><b>" + vbCrLf)
            .Append("Show History" + vbCrLf)
            .Append("</b></td>" + vbCrLf)

            .Append("<td align='center'><b>" + vbCrLf)
            .Append("Delete" + vbCrLf)
            .Append("</b></td>" + vbCrLf)
            .Append("</tr>" + vbCrLf)


            For Each drRoleRate As DataRow In m_dsRoleRate.Tables(0).Rows
                strEmployeeBillingInfoID = CommonFunction.Data.CheckIsDBNull(drRoleRate("EmployeeBillingInfoID"))
                blnIsDisabled = CType(CommonFunction.Data.CheckIsDBNull(drRoleRate("IsDisabled")), Boolean)
                blnIsShowHistory = CType(CommonFunction.Data.CheckIsDBNull(drRoleRate("IsShowHistory")), Boolean)
                strCurrencySymbol = Convert.ToString(CommonFunction.Data.CheckIsDBNull(drRoleRate("CurrencySymbol")))
                strSiteID = Convert.ToString(CommonFunction.Data.CheckIsDBNull(drRoleRate("SiteID")))
                strEmployeeBillingInfoIDList += strEmployeeBillingInfoID + ","

                RowCount += 1

                .Append("<tr class=clsTRBlank>" + vbCrLf)
                .Append("<td align=center>" + Convert.ToString(RowCount) + "</td>" + vbCrLf)
                '.Append(CommonFunctions.HTMLControls.DrawComboBox("cmbSite" + strEmployeeBillingInfoID, "usp_sel_tbl_PM_ProjectSite" + " " + m_lngProjectID.ToString + ",0," + CommonFunction.Data.CheckIsDBNull(drRoleRate("SiteID"), "").ToString, 200, CommonFunction.Data.CheckIsDBNull(drRoleRate("SiteID"), ""), "disabled", True, True, , True, , True) + vbCrLf)
                If Not m_blnSingleSite Then
                    .Append("<td  align=left><font size='1' face='Verdana'>" + CommonFunction.Data.CheckIsDBNull(drRoleRate("Name"), "") + "</font></td>" + vbCrLf)
                End If
                .Append(CommonFunctions.HTMLControls.DrawComboBox("cmbSite" + strEmployeeBillingInfoID, "usp_sel_tbl_PM_ProjectSite" + " " + m_lngProjectID.ToString + ",0," + CommonFunction.Data.CheckIsDBNull(drRoleRate("SiteID"), "").ToString, 200, CommonFunction.Data.CheckIsDBNull(drRoleRate("SiteID"), ""), "disabled", True, True, , True, , True) + vbCrLf)
                .Append(CommonFunctions.HTMLControls.DrawComboBox("cmbRole" + strEmployeeBillingInfoID, "usp_Sel_ProjectRole_List" + " " + m_lngProjectID.ToString, 200, CommonFunction.Data.CheckIsDBNull(drRoleRate("RoleID"), ""), "disabled", , True, , True, , True) + vbCrLf)
                .Append(CommonFunctions.HTMLControls.DrawDateControl("dtFromDate" + strEmployeeBillingInfoID, "dtFromDate" + strEmployeeBillingInfoID, , , CommonFunction.Data.CheckIsDBNull(drRoleRate("StartDate"), ""), , "frmRoleRate", , , , True, , , True, True, , , True) + vbCrLf)

                .Append("<td  align=left><font size='1' face='Verdana'>" + CommonFunction.Data.CheckIsDBNull(drRoleRate("RoleDescription"), "") + "</font></td>" + vbCrLf)

                '.Append("<td  align=center>" + CommonFunctions.HTMLControls.DrawDateControl("dtFromDate" + strEmployeeBillingInfoID, "dtFromDate" + strEmployeeBillingInfoID, , , CommonFunction.Data.CheckIsDBNull(drRoleRate("StartDate"), ""), , "frmRoleRate", , , , True, , , True, True) + "</td>" + vbCrLf)
                .Append("<td  align=left><font size='1' face='Verdana'>" + CommonFunction.Dates.CGetDate(CommonFunction.Data.CheckIsDBNull(drRoleRate("StartDate"), "")) + "</font></td>" + vbCrLf)
                .Append("<td  align=left><font size='1' face='Verdana'>" + vbCrLf)

                '.Append(CommonFunctions.HTMLControls.DrawDateControl( "dtToDate" + strEmployeeBillingInfoID,  "dtToDate" + strEmployeeBillingInfoID,  ,  , CommonFunction.Data.CheckIsDBNull(drRoleRate("EndDate"), ""), , "frmRoleRate", , , , True, , , True, ) + vbCrLf)


                If CommonFunction.Data.CheckIsDBNull(drRoleRate("EndDate"), "") <> "" Then
                    .Append(CommonFunction.Dates.CGetDate(CType(drRoleRate("EndDate"), Date)) + vbCrLf)
                Else
                    .Append("&nbsp;")
                End If

                .Append("</font></td>" + vbCrLf)
                If m_strContractType = "2" Or m_strContractType = "5" Or m_strContractType = "6" Then
                    'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    .Append("<td  align=right><label align='right'>" + strCurrencySymbol + "</label>" + CommonFunctions.HTMLControls.DrawTextBox("txtNormalRate" + strEmployeeBillingInfoID, "txtNormalRate" + strEmployeeBillingInfoID, , 100, 10, value:=CommonFunction.Data.CheckIsDBNull(drRoleRate("NormalRate"), "").ToString, textAlign:="Right", returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True) + "</td>" + vbCrLf)
                    'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    If m_strContractType = "2" Or m_strContractType = "6" Or (m_strContractType = "5" And blnIsExtrHrsBilling) Then
                        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                        .Append("<td  align=right><label align='right'>" + strCurrencySymbol + "</label>" + CommonFunctions.HTMLControls.DrawTextBox("txtExtraRate" + strEmployeeBillingInfoID, "txtExtraRate" + strEmployeeBillingInfoID, , 100, 10, value:=CommonFunction.Data.CheckIsDBNull(drRoleRate("ExtraRate"), "").ToString, textAlign:="Right", returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True) + "</td>" + vbCrLf)
                        .Append("<td  align=right><label align='right'>" + strCurrencySymbol + "</label>" + CommonFunctions.HTMLControls.DrawTextBox("txtHolidayRate" + strEmployeeBillingInfoID, "txtHolidayRate" + strEmployeeBillingInfoID, , 100, 10, value:=CommonFunction.Data.CheckIsDBNull(drRoleRate("HolidayRate"), "").ToString, textAlign:="Right", returnHTML:=True, IsMandatory:=False, EnableHTMLEncode:=True) + "</td>" + vbCrLf)
                        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                    End If
                End If
                '.Append("<td  align=right><label align='right'>" + strCurrencySymbol + "</label>" + CommonFunctions.HTMLControls.DrawTextBox("txtCTC" + strEmployeeBillingInfoID, "txtCTC" + strEmployeeBillingInfoID, , 100, value:=CommonFunction.Data.CheckIsDBNull(drRoleRate("CTC"), "").ToString, textAlign:="Right", returnHTML:=True, IsMandatory:=False) + "</td>" + vbCrLf)

                .Append("<td  align=left>" + vbCrLf)
                If blnIsShowHistory Then
                    .Append("<a title='Show History' href='javascript:History_OnClick(" + strEmployeeBillingInfoID + ",2102,1)'>Show History</a>" + vbCrLf)
                Else
                    .Append("&nbsp;")
                End If
                .Append("</td>" + vbCrLf)
                .Append("<td  align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , strEmployeeBillingInfoID, blnIsDisabled, , True) + "</td>" + vbCrLf)
                m_strScript.Append("arrRoleRateID.push(" + strEmployeeBillingInfoID + ");")
                .Append("</tr>" + vbCrLf)
                strPreviousSite = Convert.ToString(CommonFunction.Data.CheckIsDBNull(drRoleRate("Name")))

                strRoleID = Convert.ToString(CommonFunction.Data.CheckIsDBNull(drRoleRate("RoleID")))
            Next

            m_strComboboxHTML = CommonFunctions.HTMLControls.DrawComboBox("cmbSite", "usp_sel_tbl_PM_ProjectSite" + " " + m_lngProjectID.ToString, 200, , "onchange=Site_OnChange", True, True, , , , m_blnSingleSite)
            m_strRoleComboHTML = CommonFunctions.HTMLControls.DrawComboBox("cmbRole", "usp_Sel_ProjectRole_List" + " " + m_lngProjectID.ToString, 200, strRoleID, "onchange=Role_OnChange", True, True, , True, , )
            m_StrFromDateHTML = CommonFunctions.HTMLControls.DrawDateControl("dtFromDate", "dtFromDate", , , , , "frmRoleRate", , , , , , , True, True, , )

            If m_blnSingleSite Then
                'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                .Append(CommonFunctions.HTMLControls.DrawTextBox("txtDefaultSite", "txtDefaultSite", , , , strSiteID, , , , , , True, , True, EnableHTMLEncode:=True) + vbCrLf)
                'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            End If
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtItemCount", "txtItemCount", , , , m_dsRoleRate.Tables(0).Rows.Count + iRowCount, "RIGHT", IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True) + vbCrLf)
            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtPreItemCount", "txtPreItemCount", , , , m_dsRoleRate.Tables(0).Rows.Count + iRowCount, "RIGHT", IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True) + vbCrLf)
            .Append(CommonFunctions.HTMLControls.DrawTextBox("txtDatabaseItem", "txtDatabaseItem", , , , strEmployeeBillingInfoIDList, "RIGHT", IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True) + vbCrLf)
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding

            .Append("<Tr class=clsTREven id=""TRAdd"" >" + vbCrLf)
            .Append("<td width=10px ALIGN='center'>" + vbCrLf)
            .Append("<A href='Javascript:CreateRowForRoleRate(""" + m_strFrom + """)'" + vbCrLf)
            .Append("><Img Border=0 id=tdShowHide Src='../../Images/right.gif' title=''></A>" + vbCrLf)
            .Append("</td>" + vbCrLf)
            .Append("<td ALIGN='center' colspan=9></td>" + vbCrLf)
            .Append("</tr>" + vbCrLf)

            .Append("</table>" + vbCrLf)
            .Append("</div>" + vbCrLf)
        End With


        Response.Write(m_SBHTML.ToString)
        m_SBHTML = Nothing
    End Sub
    Protected Overrides Sub Finalize()
        MyBase.Finalize()
        
    End Sub
End Class
