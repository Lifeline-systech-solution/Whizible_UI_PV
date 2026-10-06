Public Class PC_CostEffectiveDate
    Inherits WebPages.Template.WhizTemplate

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

    Private strMenu As String
    Private m_strMode As String = ""

    Private m_intProjectCostTypeID As Integer
    Private m_intCostTypeID As Integer
    Private m_intLevelID As Integer
    Private m_dblCost As Double
    Private m_dtEffectiveDt As Date
    Private m_intCostTypeGradeID As Integer
    Protected m_dtEffectiveDate As String

    Private m_objGlobal As WebPages.Template.IGlobal                      'This variable is of global object inteface. 
    Private m_objAccessRights As WebPages.Security.cAccessRights        'This variable is for access rights of page.
    Protected m_TagID As Integer

    Public Sub PageInit()

        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : main procedure to build page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Priyanka
        ' Created               : Nov 15, 2005
        ' Revisions             :
        '=====================================================================

        Call SetVariables()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

        If m_strMode.ToUpper = "SAVE" Or m_strMode.ToUpper = "SAVECLOSE" Then
            Call SaveInformation()
        End If

        Call SetVariables()

        strMenu = GenerateMenu()
        Response.Write(strMenu)

        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {CommonFunction.HTMLControls.DrawMandatoryImage(, True)}
        CommonFunction.General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend) + vbCrLf)

        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, "Cost with respect to Effective Date", , , True))
        Response.Write("<BR>")

        Response.Write("<DIV ID='PageDiv' Style='Height:300px;WIDTH:100%;OVERFLOW:auto;'>")
        Call PlotControls()
        Response.Write("</DIV>")

        Response.Write("<BR>" + strMenu)
    End Sub ' Main procedure to build page


    Public Sub New()
        '=====================================================================
        ' Procedure Name        : New()	
        ' Purpose               : constructor for tha page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Priyanka
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================
        ''Commented and Added by Yogesh Jalamkar on 10-OCT-2016 Purpose:Sql injection and Cross Site Scripting     
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of addition by Yogesh Jalamkar on 10-OCT-2016 


    End Sub ' Constructor for the page

    Private Sub SetVariables()

        '=====================================================================
        ' Procedure Name        : SetVariables()	
        ' Purpose               : Set the variables being used in this page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Priyanka
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================
        Dim drCostType As IDataReader
        Dim strSql As String

        If Not Request.QueryString("Mode") Is Nothing Then
            If Request.QueryString("Mode") <> "" Then
                m_strMode = Request.QueryString("Mode").ToString
            Else
                m_strMode = "EDIT"
            End If
        End If
        If Not Request.QueryString("MasterTagID") Is Nothing Then
            If Request.QueryString("MasterTagID") <> "" Then
                m_TagID = CType(Request.QueryString("MasterTagID"), Integer)
            End If
        End If
        Dim strSQLQuery1 As String
        Dim dtEffectiveDate As Date
        'Get ProjectCostTypeID, CostTypeID, LevelID
        m_intProjectCostTypeID = CType(Request.QueryString("ProjectCostTypeID"), Integer)
        m_intCostTypeID = CType(Request.QueryString("CostTypeID"), Integer)
        m_intLevelID = CType(Request.QueryString("GradeID"), Integer)

        If CType(Request.QueryString("EffectiveDate"), String) <> "" Then
            m_dtEffectiveDate = CType(Request.QueryString("EffectiveDate"), String)
        End If

        'If Not IsNothing(CType(m_dtEffectiveDate, String)) And Not IsDBNull(CType(m_dtEffectiveDate, String)) Then
        '    'strSQLQuery1 = "select EffectiveDate FROM tbl_PM_ProjectCostType_CostType_Grade WHERE CostTypeGradeID = " + m_dtEffectiveDate 'MyBase.GetFormValue("cboEffectiveDate", True)
        '    'dtEffectiveDate = CType(CommonFunctions.Data.GetDataScalar(strSQLQuery1, True), Date)
        '    'strSQLQuery += ", '" + CType(dtEffectiveDate, String) + "'"
        'End If

        strSql = "EXEC usp_Sel_tbl_PM_ProjectCostType_CostType_Grade " + CType(m_intProjectCostTypeID, String) + ", " + CType(m_intCostTypeID, String) + ", " + CType(m_intLevelID, String) + ""
        If m_dtEffectiveDate <> "" And Not IsNothing(CType(m_dtEffectiveDate, String)) And Not IsDBNull(CType(m_dtEffectiveDate, String)) Then
            ''Commented added By Abhijeet K on 4/8/2016 Purpose : Remove Inline Query
            ''strSQLQuery1 = "select EffectiveDate FROM tbl_PM_ProjectCostType_CostType_Grade WHERE CostTypeGradeID = " + m_dtEffectiveDate
            strSQLQuery1 = "usp_sel_tbl_PM_ProjectCostType_CostType_Grade_EffectiveDate " + m_dtEffectiveDate
            dtEffectiveDate = CType(CommonFunctions.Data.GetDataScalar(strSQLQuery1, True), Date)
            strSql += ", '" + CType(dtEffectiveDate, String) + "'"
        End If

        'strSql = "EXEC usp_Sel_tbl_PM_ProjectCostType_CostType_Grade " + CType(m_intProjectCostTypeID, String) + ", " + CType(m_intCostTypeID, String) + ", " + CType(m_intLevelID, String) + ", '" + CType(dtEffectiveDate, String) + "'"
        'drCostType = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_ProjectCostType_CostType_Grade " + CType(m_intProjectCostTypeID, String) + ", " + CType(m_intCostTypeID, String) + ", " + CType(m_intLevelID, String) + ", '" + m_dtEffectiveDate + "'", MyBase.UseSQL)
        drCostType = CommonFunction.Data.GetDataReader(strSql, MyBase.UseSQL)
        m_dblCost = 0
        m_dtEffectiveDt = Now()

        If Not drCostType.Read Then
            CommonFunction.Data.DisposeDataReader(drCostType)
            Exit Sub
        End If

        m_dblCost = CType(CommonFunction.Data.CheckIsDBNull(drCostType("Value"), "0"), Double)
        m_dtEffectiveDt = CType(CommonFunctions.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(drCostType("EffectiveDate"), ""), Date)), Date)
        m_intCostTypeGradeID = CType(CommonFunction.Data.CheckIsDBNull(drCostType("CostTypeGradeID"), "0"), Integer)
        'm_strValueID = CType(CommonFunction.Data.CheckIsDBNull(drCostType("ValueID"), "0"), String)

        CommonFunction.Data.DisposeDataReader(drCostType)

    End Sub ' Set variables being used in this page

    Private Function GenerateMenu() As String
        '=====================================================================
        ' Function Name         : GenerateMenu()	
        ' Purpose               : To generate Menu 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : menu string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Priyanka
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips

        If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            'Save 
            ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))
            ArrClientSideFunctionsList.Add("Save_OnClick()")

            'Save & Close
            ArrMenuCaptionsList.Add("Save & Close")
            ArrMenuToolTipsList.Add("Save & Close")
            ArrClientSideFunctionsList.Add("SaveClose_OnClick()")
        End If
        'Show History
        ArrMenuCaptionsList.Add("Show History")
        ArrMenuToolTipsList.Add("Show History")
        ArrClientSideFunctionsList.Add("ShowHistory_OnClick()")

        'Close
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Close_OnClick()")

        'Help 
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Help_OnClick('" + CType(m_TagID, String) + "')")

        'Convert arraylist to array - Menu captions
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

        'Generate menu string and return
        Return WebPage.Templates.StaticMenu.DrawMenu(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)

    End Function 'Menu generation

    Private Sub PlotControls()
        '=====================================================================
        ' Procedure Name        : PlotControls()	
        ' Purpose               : Plot the controls on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Priyanka
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================


        Response.Write("<TABLE class=clsTable cellspacing=0 cellpadding=0 width=99.9%>")

        'Project Cost Type
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=right>Cost</TD><TD>")
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.HTMLControls.DrawTextBox("txtCost", "txtCost", "clsTextBox", 80, 5, m_dblCost.ToString, IsMandatory:=True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        Response.Write("</TD></TR>")

        'Cost Type
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=right>Effective Date</TD><TD>")
        CommonFunction.HTMLControls.DrawDateControl("txtEffectiveDate", "txtEffectiveDate", Value:=CommonFunctions.Dates.GetDate(m_dtEffectiveDt), IsMandatory:=True, FormName:="frmProjectCost")
        Response.Write("</TD></TR>")

        'Hidden Controls
        CommonFunctions.General.WriteHTML("<input name=txtLevelID id=txtLevelID type=hidden value=" + CType(m_intLevelID, String) + ">")
        CommonFunctions.General.WriteHTML("<input name=txtProjectCostTypeID id=txtProjectCostTypeID type=hidden value=" + CType(m_intProjectCostTypeID, String) + ">")
        CommonFunctions.General.WriteHTML("<input name=txtCostTypeID id=txtCostTypeID type=hidden value='" + CType(m_intCostTypeID, String) + "'>")

        Response.Write("</TABLE>")

    End Sub 'Plot controls on the page
    Private Sub SaveInformation()

        '=====================================================================
        ' Procedure Name        : SaveInformation()	
        ' Purpose               : Save company information
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Priyanka
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================

        Dim strSQL As New System.Text.StringBuilder("")
        If CType(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtCost"), "0"), Double) >= 0 Then
            strSQL.Append("EXEC usp_Ins_tbl_PM_ProjectCostType_CostType_Grade ")
            strSQL.Append("@intProjectCostTypeID = " + CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtProjectCostTypeID"), "") + ", ")
            strSQL.Append("@intCostTypeID = " + CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtCostTypeID"), "") + ", ")
            strSQL.Append("@intLevelID = " + CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtLevelID"), "") + ", ")

            strSQL.Append("@dblValue = " + CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtCost"), "") + ", ")
            strSQL.Append("@dtEffectiveDate = '" + CommonFunctions.Dates.GetDate(CType(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtEffectiveDate"), ""), Date)) + "', ")
            strSQL.Append("@strUserName = '" + CommonFunction.General.CheckIsNothing(Session("strUserName"), "") + "'")

            CommonFunction.Data.InsertOrUpdateData(strSQL.ToString, MyBase.UseSQL)
            strSQL = Nothing
        End If
        If m_strMode.ToUpper = "SAVE" Then
            CommonFunctions.General.WriteHTML("<Script language='javascript'>")
            CommonFunctions.General.WriteHTML("var objEffDt = GetParentObjectReference('frmGradeTypeCostType','cboEffectiveDate');")
            CommonFunctions.General.WriteHTML("var objGrade = GetParentObjectReference('frmGradeTypeCostType','cboGrade');")
            CommonFunctions.General.WriteHTML("opener.location.href='PC_GradeTypeCostType.aspx?Mode=List&EffectiveDate=' + objEffDt.value + '&GradeID=' + objGrade.value;")
            CommonFunctions.General.WriteHTML("</Script>")
        ElseIf m_strMode.ToUpper = "SAVECLOSE" Then
            CommonFunctions.General.WriteHTML("<Script language='javascript'>")
            CommonFunctions.General.WriteHTML("var objEffDt = GetParentObjectReference('frmGradeTypeCostType','cboEffectiveDate');")
            CommonFunctions.General.WriteHTML("var objGrade = GetParentObjectReference('frmGradeTypeCostType','cboGrade');")
            CommonFunctions.General.WriteHTML("opener.location.href='PC_GradeTypeCostType.aspx?Mode=List&EffectiveDate=' + objEffDt.value + '&GradeID=' + objGrade.value;")
            CommonFunctions.General.WriteHTML("window.close();")
            CommonFunctions.General.WriteHTML("</Script>")
        End If

        m_strMode = "EDIT"

    End Sub 'Save company information

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub
End Class
