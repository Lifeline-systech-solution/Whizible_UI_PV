Public Class HR_ResourceAllocationSearch
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Class	Name	        :	HR_ResourceAllocationSearch
    ' Purpose				:	Page for Resource allocation search 
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SuchitraP
    ' Created				:	Nov 05,2007
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
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    Dim WithEvents objGrid As New WebPage.Templates.GenericGrid
    Private strBusinessGroup As String
    Private strBusinessGroupID As String
    Private strOrganizationUnit As String
    Private strOrganizationUnitID As String
    Protected strOpportunityID As String
    Private strDeliveryUnit As String
    Private strDeliveryUnitID As String
    Private strDeliveryTeam As String
    Private strDeliveryTeamID As String
    Private strResourceInDate As String
    Private strResourceOutDate As String
    Private strRoleID As String
    Private strTitle As String
    Private m_strOU As String
    Private m_strCN As String
    Private m_strSkill As String
    Private m_hidOpportunityID As String
    Protected m_IsMainSelected As Integer
    Protected m_Rolecheck As String
    Private m_TotalRecords As Integer
   
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here 
    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    Protected Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()
        ' Purpose               : Start of Page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : This function must be called within FORM tag in aspx page.
        ' Author                : SuchitraP
        ' Created               : Nov 05,2007
        ' Revisions             :
        '=====================================================================

        InitializeVariables()

        Dim arrMenu As New System.Collections.ArrayList
        Dim arrMenuToolTip As New System.Collections.ArrayList
        Dim arrCSFunction As New System.Collections.ArrayList

        'arrMenu.Add("Advance Search")
        arrMenu.Add("Close")
        arrMenu.Add("?")

        'arrMenuToolTip.Add("Advance Search")
        arrMenuToolTip.Add("Close")
        arrMenuToolTip.Add("Help")

        'arrCSFunction.Add("AdvanceSearch_OnClick()")
        arrCSFunction.Add("Close_OnClick()")
        arrCSFunction.Add("Help_OnClick('ASearch')")

        With Response
            .Write("<div id='divUpperMenu'>")
            .Write(WebPages.Template.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip)))
            .Write("</div>")
            .Write("<BR>")
            Call drawFilters()
            .Write("<BR>")
            'Call drawAdvanceSearch()
            '.Write("<BR>")
            'Call drawExactMatch()
            '.Write("<BR>")
            Call drawGrid()
            .Write("<BR>")
            .Write("<div>")
            .Write("<TABLE cellspacing=0 cellpadding=0 Width=99.9% class=clsTable><TR class='clsTREven'><TD align=right>Total number of records :" + CType(m_TotalRecords, String) + "</TD></TR></TABLE>")
            .Write("</div>")
            .Write("<BR>")
            .Write("<div id='divBottomMenu'>")
            .Write(WebPages.Template.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip)))
            .Write("</div>")

        End With
    End Sub
    Private Sub InitializeVariables()

        Dim strSQL As String
        Dim drReader As IDataReader
        Dim count As Integer
        Dim sbHtml As System.Text.StringBuilder = New System.Text.StringBuilder
        Dim strRoleList As String
        count = 0

        strOpportunityID = Request.QueryString("OpportunityID")

        If strOpportunityID Is Nothing Or strOpportunityID = "" Then
            strOpportunityID = HttpContext.Current.Request.Form("hidOpportunityID")
        End If

        m_strOU = HttpContext.Current.Request.Form.Get("cboOrganizationUnit")
        m_strCN = HttpContext.Current.Request.Form.Get("cboCategoryName")
        m_strSkill = HttpContext.Current.Request.Form.Get("txtOtherSkills")

        If m_strOU Is Nothing Then
            m_strOU = ""
        End If

        If m_strCN Is Nothing Then
            m_strCN = ""
        End If

        If m_strSkill Is Nothing Then
            m_strSkill = ""
        End If

        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidOpportunityID' id='hidOpportunityID' value='" + strOpportunityID + "'>")
        m_hidOpportunityID = HttpContext.Current.Request.Form("hidOpportunityID")

        If m_hidOpportunityID Is Nothing Or m_hidOpportunityID = "" Then
            m_hidOpportunityID = HttpContext.Current.Request.QueryString("OpportunityID")
        Else
            m_hidOpportunityID = HttpContext.Current.Request.Form("hidOpportunityID")
        End If

        strSQL = "usp_Sel_tbl_RM_Opportunity_BGAndOU " + m_hidOpportunityID
        drReader = CommonFunction.Data.GetDataReader(strSQL, True)
        While drReader.Read
            count = count + 1
            strBusinessGroup = drReader("BusinessGroup").ToString
            strOrganizationUnit = drReader("Location").ToString
            strDeliveryUnit = drReader("ResourcePoolName").ToString
            strDeliveryTeam = drReader("GroupName").ToString
            strTitle = drReader("Title").ToString
            strBusinessGroupID = drReader("BusinessGroupID").ToString
            strOrganizationUnitID = drReader("LocationID").ToString
            strDeliveryUnitID = drReader("ResourcePoolID").ToString
            strDeliveryTeamID = drReader("GroupID").ToString
            If count >= 1 Then
                sbHtml.Append(drReader("RoleID").ToString)
                sbHtml.Append(",")
                sbHtml.Append(drReader("ToolID").ToString)
                sbHtml.Append(",")
                sbHtml.Append(drReader("TentativeStartDate").ToString)
                sbHtml.Append(",")
                sbHtml.Append(drReader("TentativeEndDate").ToString)
                sbHtml.Append("|")
            End If

        End While

        strRoleList = sbHtml.ToString
        strRoleID = strRoleList.Substring(0, sbHtml.Length - 1)

        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidBGID' id='hidBGID' value='" + strBusinessGroupID + "'>")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidOUID' id='hidOUID' value='" + strOrganizationUnitID + "'>")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidDUID' id='hidDUID' value='" + strDeliveryUnitID + "'>")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidDTID' id='hidDTID' value='" + strDeliveryTeamID + "'>")
        'strRoleID
        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidRoleID' id='hidRoleID' value='" + strRoleID + "'>")
        CommonFunction.Data.DisposeDataReader(drReader)

    End Sub
    Private Sub drawFilters()
        'Dim cObjSectionTitle As New WebPage.Templates.SectionTitle
        'With cObjSectionTitle
        '    .GetSectionTitle("Filter", "DivFilterInfo", "ShowHideOtherInfo", , , , "../../Images/minus.gif", "../../Images/plus.gif", , , , , , )
        'End With

        'CommonFunction.General.WriteHTML("<DIV Id='DivFilterInfo' Style='Overflow:auto;HEIGHT:45px;'>")
        'cObjSectionTitle = Nothing
        'CommonFunction.General.WriteHTML("<TABLE ID='PageFilter' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        'CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        'CommonFunction.General.WriteHTML("<TD align='right'>Organization Unit")
        'CommonFunction.General.WriteHTML("</TD><TD align='left'>")
        'CommonFunction.HTMLControls.DrawComboBox("cboOrganizationUnit", "usp_Get_Resource_BG_OU", 150, m_strOU, "onchange=OU_onchange()", True)
        'CommonFunction.General.WriteHTML("</TD>")

        'CommonFunction.General.WriteHTML("<TD align='right'>Category Name")
        'CommonFunction.General.WriteHTML("</TD><TD align='left'>")
        'CommonFunction.HTMLControls.DrawComboBox("cboCategoryName", "select Tools_CategoryID,CategoryName from tbl_PM_Tools_Category ", 150, m_strCN, "onchange=Category_onchange()", True)
        'CommonFunction.General.WriteHTML("</TD>")


        'CommonFunction.General.WriteHTML("<TD title='Contains' align='right'>Other Skills")
        'CommonFunction.General.WriteHTML("</TD><TD title='Contains' align='left'>")
        'CommonFunction.HTMLControls.DrawTextBox("txtOtherSkills", "txtOtherSkills", "clsTextBox", , , m_strSkill, , , , , , , " onKeyPress=txtOtherSkills_onKeyPress(event)")
        'CommonFunction.General.WriteHTML("</TD></TR></TABLE>")
        'CommonFunction.General.WriteHTML("</DIV>")

        CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
        CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption><TD align=Left>Available Allocation ")
        CommonFunction.General.WriteHTML("</TD><TD align=right>Opportunity : " + strTitle)
        CommonFunction.General.WriteHTML("</TD></TR></TABLE>")


    End Sub

    Private Sub drawGrid()
        Dim strSQL As String
        Dim strWhereClause As String
        Dim strBGID As String
        Dim strOUID As String
        Dim strDUID As String
        Dim strDTID As String
        Dim StrRole As String
        Dim arrRoleSkill As String()
        Dim iterator As Integer
        Dim count As Integer
        Dim arrSeperator As String()
        Dim drReader As IDataReader

            If HttpContext.Current.Request.Form("hidBGID") <> "" Or Not HttpContext.Current.Request.Form("hidBGID") Is Nothing Then
                strBGID = HttpContext.Current.Request.Form("hidBGID")
            Else
                strBGID = strBusinessGroupID
            End If

            If HttpContext.Current.Request.Form("hidOUID") <> "" Or Not HttpContext.Current.Request.Form("hidOUID") Is Nothing Then
                strOUID = HttpContext.Current.Request.Form("hidOUID")
            Else
                strOUID = strOrganizationUnitID
            End If

            If HttpContext.Current.Request.Form("hidDUID") <> "" Or Not HttpContext.Current.Request.Form("hidDUID") Is Nothing Then
                strDUID = HttpContext.Current.Request.Form("hidDUID")
            Else
                strDUID = strDeliveryUnitID
            End If

            If HttpContext.Current.Request.Form("hidDTID") <> "" Or Not HttpContext.Current.Request.Form("hidDTID") Is Nothing Then
                strDTID = HttpContext.Current.Request.Form("hidDTID")
            Else
                strDTID = strDeliveryTeamID
            End If

            'strRoleID
            If HttpContext.Current.Request.Form("hidRoleID") <> "" Or Not HttpContext.Current.Request.Form("hidRoleID") Is Nothing Then
                StrRole = HttpContext.Current.Request.Form("hidRoleID")
            Else
                StrRole = strRoleID
            End If

            'DeliveryUnitID
            If strDUID = "" Or strDUID Is Nothing Then
                strDUID = "0"
            End If

            'DeliveryTeamID
            If strDTID = "" Or strDTID Is Nothing Then
                strDTID = "0"
            End If

            If StrRole = "" Or StrRole Is Nothing Then
                StrRole = "0"
            End If

            'Commneted and Added by ArchanaN on 28 Nov 2007

            'strSQL = "SELECT * FROM v_Sel_tbl_PM_Employee_IsOnBench WHERE 1=1 "

            'strWhereClause = " BusinessGroupID = " + strBGID + " AND LocationID=" + strOUID + " AND ISNULL(ResourcePoolID,0)=" + strDUID + " AND ISNULL(GroupID,0)=" + strDTID '+ " AND ISNULL(RoleID,0) IN (" + StrRole + ")"

            'arrRoleSkill = StrRole.Split(CType("|", Char))
            'For iterator = 0 To arrRoleSkill.Length - 1
            '    arrSeperator = arrRoleSkill(iterator).Split(CType(",", Char))

            '    If iterator = 0 Then
            '        strWhereClause += " AND ( "
            '    Else
            '        strWhereClause += " OR "
            '    End If
            '    strWhereClause += "(RoleID=" & arrSeperator(0)
            '    strWhereClause += " AND PrimarySkillIDs like '%" & arrSeperator(1) & "%'"
            '    strWhereClause += "AND (DateDiff(dd,AvailabilityFrom,'" & arrSeperator(2) & "') <=0) AND (DateDiff(dd,AvailabilityFrom,'" & arrSeperator(3) & "') >=0))"
            'Next

            'strWhereClause += ")"

            'strSQL += " AND " + strWhereClause

            strOpportunityID = Request.QueryString("OpportunityID")

            If strOpportunityID Is Nothing Or strOpportunityID = "" Then
                strOpportunityID = HttpContext.Current.Request.Form("hidOpportunityID")
            End If
            strSQL = "usp_Sel_tbl_PM_Employee_IsOnBench  " + strOpportunityID + ","
            strSQL += strBGID + " ," + strOUID + " ," + strDUID + " ," + strDTID

        'Dim strResourceDemandType As String = ""

        '    drReader = CommonFunction.Data.GetDataReader(strSQL, True)
        'While drReader.Read
        '    strResourceDemandType = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
        'End While

        'Dim strActColName As String = "ResourceLoading"

       
            '''    Dim arrActualColumns As String() = {"ResourceDemandType", "EmployeeName", "RoleDescription", "TotalExp", "PrimarySkill", "OtherSkill", "Resume"}
            '''    Dim arrUserfriendlyColNames As String() = {"Resource Demand Type", "Resource Name", "Role", "Total Experience (Yrs)", "Primary Skills", "Other Skills", "Resume"}
            '''    Dim arrRowLinkArray As String() = {"", "", "", "", "", "", "Resume_OnClick(EmployeeID)"}
            '''    Dim arrColumnGroup() As String = {"0"}
            '''    'End by ArchanaN      

            '''    CommonFunctions.General.PlotStaticHeaderStyle("divPage")

            '''    With objGrid
            '''        .GroupOnColumn = arrColumnGroup
            '''        .RowLinkArray = arrRowLinkArray
            '''        .ActualColumnArray = arrActualColumns
            '''        .UserFriendlyColumnArray = arrUserfriendlyColNames
            '''        .EmptyValueReplacement = " "
            '''        .NoOfDataColumns = 6
            '''        .DIVID = "divPage"
            '''        .DIVHeight = 500
            '''        .DIVStyle = "overflow:auto"
            '''        .returnHTML = False
            '''        .SQL = strSQL
            '''        .UseSQL = CBool(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), "True"))
            '''        .ConnectionString = CommonFunctions.Application.ConnectionString
            '''        .DrawGrid()
            '''        m_TotalRecords = .NoOfRows
            '''    End With
            ''Else
        
        Dim arrActualColumns As String() = {"ResourceDemandType", "EmployeeName", "RoleDescription", "TotalExp", "PrimarySkill", "OtherSkill", "Resume", "Resource Loading"}
        Dim arrUserfriendlyColNames As String() = {"Resource Demand Type", "Resource Name", "Role", "Total Experience (Yrs)", "Primary Skills", "Other Skills", "Resume", "ResourceLoading"}
        Dim arrRowLinkArray As String() = {"", "", "", "", "", "", "Resume_OnClick(EmployeeID)", "ResourceLoading_OnClick(EmployeeID)"}
        Dim arrColumnGroup() As String = {"0"}
        'End by ArchanaN      

        CommonFunctions.General.PlotStaticHeaderStyle("divPage")
        'Commented and added by Shamkant s for HTML encoding Date:07/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Shamkant s  for HTML encoding Date:07/10/15
        With objGrid
            .GroupOnColumn = arrColumnGroup
            .RowLinkArray = arrRowLinkArray
            .ActualColumnArray = arrActualColumns
            .UserFriendlyColumnArray = arrUserfriendlyColNames
            .EmptyValueReplacement = " "
            .NoOfDataColumns = 6
            .DIVID = "divPage"
            .DIVHeight = 500
            .DIVStyle = "overflow:auto"
            .returnHTML = False
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode

            .SQL = strSQL
            .UseSQL = CBool(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), "True"))
            .ConnectionString = CommonFunctions.Application.ConnectionString

            .DrawGrid()
            m_TotalRecords = .NoOfRows
        End With
      
               
    End Sub

    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        If CType(Args.DataReader.Item("ResourceDemandType"), String) = "Joining Pool Resources" Then
            If Args.ColumnName.ToUpper() = "RESOURCELOADING" Or Args.ColumnName.ToUpper() = "RESUME" Then
                Args.StringToBeInserted = ""
                Cancel = True
                Args.StringToBeInserted = "<td align='center'> - </td>"
            End If
        End If
    End Sub
End Class
