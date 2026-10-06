#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class ResourceAllocation_RAD
    Inherits WebPages.Template.WhizTemplate

    '=====================================================================
    ' Project Name          :   Whizible Enterprise
    ' Module Name           :   Resource Allocation Details

    ' Author				:	SANA
    ' Created				:	27-oCT-2009
    ' Revisions				:	
    '=====================================================================

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

#Region "Member Variables"
    Private WithEvents m_objMenu As New StaticMenu      'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New GenericGrid     'This variable is use to plotting grid.
    Private m_objGlobal As IGlobal                      'This variable is of global object inteface. 
    Private m_objAccessRights As cAccessRights          'This variable is for access rights of page.
    Private strMenu As String                           'stores the static menu string.
    Protected m_intProjectEmployeeRoleId As Integer

    Protected m_strpercentage As String = ""
    Protected m_strStartDate As String
    Protected m_strendDate As String
    Protected m_strHours As String = ""
    Protected m_intPriority As Integer
    Protected m_intResourcePool As Integer
    Protected m_strSpecialRequest As String

    Protected m_strMode As String
    Protected m_strScript As String
    Protected m_strAction As String
    Protected m_StdAllocationPercentage As Long

    Protected WithEvents frmResourceAllocation_RAD As System.Web.UI.HtmlControls.HtmlForm

    Private strStartDate As String = ""
    Private strEndDate As String = ""
    Private strEmployeeName As String = ""
    Private strEmployeeID As String = "0"
    Private strProjectID As String = "0"
    Private strRoleID As String = "0"
    Private mstrPercentage As String = "0"
    Private strSQL As String
    Private m_dblFreeHours As Double
    

    Private Enum MenuIndex
        SAVE
        CLOSE
    End Enum
    Protected m_lngTagId As Long = 0

#End Region

#Region "Functions & Procedures"
    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        : GetGlobalObject
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Get the global object and assign it to variable
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_lngTagId = m_objGlobal.TagID
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
    End Sub

    Private Sub DrawMenu()
        '====================================================================
        ' Procedure Name        : DrawMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the menu
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SanaS
        ' Created               : Oct 27, 2009
        ' Revisions             :
        '=====================================================================

        Dim arrMenu(1) As String

        Dim arrMenuToolTip(1) As String

        Dim arrClientSideFunction(1) As String




        arrMenu(MenuIndex.SAVE) = "Save"
        arrMenuToolTip(MenuIndex.SAVE) = "Save"
        arrClientSideFunction(MenuIndex.SAVE) = "Save_OnClick(this)"

        
        arrMenu(MenuIndex.CLOSE) = "Close"
        arrMenuToolTip(MenuIndex.CLOSE) = "Close"
        arrClientSideFunction(MenuIndex.CLOSE) = "Close_OnClick()"

        


        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunction, arrMenuToolTip, True)

 
    End Sub

    Private Sub DrawPageCaption()
        '====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page caption thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================

        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, "Allocate Resource", , , True))
        Response.Write("<BR>")
    End Sub

    Private Sub DrawHeader()
        '====================================================================
        ' Procedure Name        : DrawHeader
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page Header thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================
        Dim objHeader As HeaderFooter
        Dim strReturn As String
        objHeader = New HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        strReturn = objHeader.DrawHeaderFooter(m_objGlobal, True)
        If strReturn <> "" Then
            Response.Write(strReturn)
        End If
        objHeader = Nothing

    End Sub

    Private Sub DisposeObjects()
        '====================================================================
        ' Procedure Name        : DisposeObjects
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Dispose all the objects
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================
        m_objMenu = Nothing
        m_objGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing

    End Sub

    Private Sub WritePageLegend()
        '====================================================================
        ' Procedure Name        : WritePageLegend
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the page legend
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : NileshD
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================

        Dim arrLegends(0) As String
        Dim arrLegendImg(0) As String
        'arrLegends(0) = "&nbsp;" & MyBase.GetResourceString("MANDATORY")
        'arrLegendImg(0) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        'CommonFunctions.General.WriteHTML(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends, True))
    End Sub
    Private Sub InitializeData()
        '====================================================================
        ' Procedure Name        : SaveData
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To Initialize variables 
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SanaS
        ' Created               : 01-Sep-2009
        '=====================================================================

      
        m_strMode = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), ""), String)
        ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion
        ' m_StdAllocationPercentage = CType(CommonFunctions.Data.GetDataScalar("SELECT IsNull(SettingValue,100) FROM tbl_sem_settings WHERE SettingName='RESOURCE_ALLOCATION'", MyBase.UseSQL), Long)
        m_StdAllocationPercentage = CType(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_sem_settings_SettingValue ", MyBase.UseSQL), Long)
        '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
        If m_strMode.ToUpper = "SAVE" Then
            If Not IsNothing(HttpContext.Current.Request.Form("cboProject")) = True Then
                strProjectID = HttpContext.Current.Request.Form("cboProject")
            Else
                strProjectID = "0"
            End If
            If Not IsNothing(HttpContext.Current.Request.Form("txtFromDate")) = True Then
                m_strStartDate = HttpContext.Current.Request.Form("txtFromDate")
            Else
                m_strStartDate = "NULL"
            End If
            If Not IsNothing(HttpContext.Current.Request.Form("txtToDate")) = True Then
                m_strendDate = HttpContext.Current.Request.Form("txtToDate")
            Else
                m_strendDate = "NULL"
            End If
            If Not IsNothing(HttpContext.Current.Request.Form("txtAllocationPer")) = True Then
                m_strpercentage = HttpContext.Current.Request.Form("txtAllocationPer")
            Else
                m_strpercentage = "0"
            End If
            If Not IsNothing(HttpContext.Current.Request.Form("txtemployeeid")) = True Then
                strEmployeeID = HttpContext.Current.Request.Form("txtemployeeid")
            Else
                strEmployeeID = "0"
            End If
            If Not IsNothing(HttpContext.Current.Request.Form("cboRole")) = True Then
                strRoleID = HttpContext.Current.Request.Form("cboRole")
            Else
                strRoleID = "0"
            End If

        Else
            strEmployeeID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("EmployeeID"), "0"), String)


        End If

    End Sub
    
    
    Private Sub DrawPage()
        '====================================================================
        ' Procedure Name        : SaveData
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To draw page
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SanaS
        ' Created               : 01-Sep-2009
        '=====================================================================

        'If mode is ADD then show the request end date , hours and priority as empty values




        Dim sbHtml As New System.Text.StringBuilder
        Dim strClass As String = "clsTROdd"
        Dim strSQL As String
        Dim strEmployeeName As String



        Dim dr As IDataReader
        Dim DivWidth As String
        Dim DivHt As String
        DivWidth = "720px"
        DivHt = "200px"
        If IsDBNull(m_strStartDate) Then
            m_strStartDate = ""
        End If
        If IsDBNull(m_strendDate) Then
            m_strendDate = ""
        End If
        If IsDBNull(mstrPercentage) Then
            mstrPercentage = "0"
        End If

        sbHtml.Append("<DIV Id= 'PageDiv' Style='Width:100%;OverFlow:auto'>")
        sbHtml.Append("<table cellSpacing='0' class='clsTable' width='99.9%'>")
        ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion
        'strEmployeeName = CommonFunctions.Data.GetDataScalar("Select Employeename from tbl_PM_Employee where employeeid=" + strEmployeeID.ToString, True)
        strEmployeeName = CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_PM_Employee_Employeename " + strEmployeeID.ToString, True)
        '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
        sbHtml.Append("<TR class='clsTREven' align='Left' nowrap >")
        sbHtml.Append("<TD  align='Left' >Resource</TD>")
        sbHtml.Append("<TD align=left COLSPAN=3>" + strEmployeeName)
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("txtemployeeid", "txtemployeeid", , , , strEmployeeID.ToString, , , , , , , , True, , , , True, EnableHTMLEncode:=True))
        'ended by Shamkant s  for HTML encoding Date:06/10/15

        strEmployeeID.ToString()
        sbHtml.Append("</TD>")
        sbHtml.Append("</tr>")
        sbHtml.Append("<TR class='clsTREven' align='Left' nowrap >")
        sbHtml.Append("<TD  align='Left' colspan=4 >&nbsp;</TD>")
        sbHtml.Append("</tr>")

        sbHtml.Append("<TR class='clsTREven' align='Left' nowrap >")
        strSQL = "usp_sel_project_for_allocation_from_Resourceallocationview " + strEmployeeID.ToString + "," + HttpContext.Current.Session("intUserID").ToString
        sbHtml.Append("<TD  align='Left'>Project</TD>")
        sbHtml.Append("<TD align=left >")
        sbHtml.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProject", strSQL, 0, strProjectID.ToString, , True, True, , True))
        sbHtml.Append("</TD>")
        sbHtml.Append("<TD  align=left>Role</TD>")
        strSQL = "usp_Sel_tbl_PM_Role_PopulateCombo "
        sbHtml.Append("<TD align=left >")
        sbHtml.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRole", strSQL, 0, strRoleID.ToString, , True, True, , True))
        sbHtml.Append("</TD>")
        sbHtml.Append("</tr>")
        sbHtml.Append("<TR class='clsTREven' align='Left' nowrap >")
        sbHtml.Append("<TD  align='Left' colspan=4 >&nbsp;</TD>")
        sbHtml.Append("</tr>")
        sbHtml.Append("<TR class='clsTREven' align='Left' nowrap >")
        sbHtml.Append("<TD  align='Left'>Expected start Date</TD>")
        sbHtml.Append("<TD align=left>")
        sbHtml.Append(CommonFunction.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , m_strStartDate, , "frmResourceAllocation_RAD", , , , , , , True, True))
        sbHtml.Append("</TD>")

        sbHtml.Append("<TD  align='Left'>Expected End Date</TD>")
        sbHtml.Append("<TD align=left>")
        sbHtml.Append(CommonFunction.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , m_strendDate, , "frmResourceAllocation_RAD", , , , , , , True, True))
        sbHtml.Append("</TD>")
        sbHtml.Append("</tr>")
        sbHtml.Append("<TR class='clsTREven' align='Left' nowrap >")
        sbHtml.Append("<TD  align='Left' colspan=4 >&nbsp;</TD>")
        sbHtml.Append("</tr>")
        sbHtml.Append("<TR class='clsTREven' align='Left' nowrap >")
        sbHtml.Append("<TD  align='Left'>Allocation %</TD>")
        sbHtml.Append("<TD align=left COLSPAN=3>")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("txtAllocationPer", "txtAllocationPer", , , , mstrPercentage.ToString, "right", , , , , , , True, EnableHTMLEncode:=True))

        'ended by Shamkant s  for HTML encoding Date:06/10/15
        sbHtml.Append("</TD>")
        sbHtml.Append("</tr></table></div>")
        Response.Write(sbHtml.ToString)
    End Sub

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        : PageInit
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the page
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SanaS
        ' Created               : 26-Oct-2009
        ' Revisions             : 
        '=====================================================================

        'This will initialize all the global objects.
        GetGlobalObject()
        InitializeData()
        'This will strore the constructed menu string in a string variable.   

        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)
        'Display the page legend
        WritePageLegend()
        'Display the page caption.
        DrawPageCaption()
        'Display the Header if exist. 
        DrawHeader()
        

        If m_strMode.ToUpper = "SAVE" Then
            SAVEDATA()
        End If



        DrawPage()
       

    End Sub
    Private Sub SAVEDATA()
        Dim strsql As String
        strsql = "usp_ins_tbl_pm_projectEmployeeRole_ResourceAllocation " + strProjectID + "," + strRoleID + "," + strEmployeeID + "," + m_strpercentage
        strsql += ",NULL,NULL,NULL,NULL,NULL " + ",'" + m_strStartDate + "','" + m_strendDate + "'," + HttpContext.Current.Session("intUserID").ToString
        CommonFunctions.Data.InsertOrUpdateData(strsql, True)
        Response.Write("<script language=javascript>")

        Response.Write("alert('Resource Allocated on Project successfully');" + vbCrLf)
        Response.Write("window.opener.location.href=window.opener.location.href;" + vbCrLf)
        Response.Write("</script>")
    End Sub
#End Region

#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region

#Region "Page - Control Events "

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load

     
        m_strMode = Request.QueryString("Mode").ToUpper
        ''Added by Nilesh g on 3/3/2016 for validate Token 

        If (Request.QueryString("PKToken") <> "" And Request.QueryString("EmployeeId") <> "") Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("EmployeeID"), String) + "0" + "0", Request.QueryString("PKToken")) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("EmployeeId"), String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If

        ''end of Added by Nilesh g on 3/3/2016 for validate Token 



    End Sub

    
#End Region

End Class
