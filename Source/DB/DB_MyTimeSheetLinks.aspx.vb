#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class DB_MyTimeSheetLinks
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

#Region "Member Variables"
    Private m_objGlobal As IGlobal                      'This variable is of global object inteface. 
    Private m_objAccessRights As cAccessRights          'This variable is for access rights of page.

    Private m_blnAddAccess As Boolean = False 'user has Add Access ?
    Private m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Private m_blnEditAccess As Boolean = False 'User has Edit Access ?
#End Region

#Region "Functions & Procedures"

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        : GetGlobalObject
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Get the global object and assign it to variable
        ' Description           : WAF Templates Auto generated code
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
    End Sub
    Private Sub DrawPageCaption()
        '====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page caption thr' global object
        ' Description           : WAF Templates Auto generated code
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Response.Write(PageCaption.GetPageCaptions(m_objGlobal, , , , True))
    End Sub
    Private Sub DisposeObjects()
        '====================================================================
        ' Procedure Name        : DisposeObjects
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Dispose all the objects
        ' Description           : WAF Templates Auto generated code
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        m_objGlobal = Nothing
        m_objAccessRights = Nothing
    End Sub
    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        : PageInit
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the page
        ' Description           : WAF Template's Auto generated code
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        '######### Page Code starts here

        'This will initialize all the global objects.
        GetGlobalObject()
        'This will strore the constructed menu string in a string variable.   
        'Display the page caption.
        'DrawPageCaption()
        Dim drGetAccess As IDataReader



        'Added By SandeepA on 22 Dec,2005
        Dim dt As New Date
        Dim DayOfWeek As System.DayOfWeek
        Dim strFrDate, strTDate, strWeekDay, strDay, strMonth, strYear, strFromDate, strToDate As String

        dt = dt.Today
        strDay = CStr(dt.Day)
        strMonth = CStr(dt.Month)
        strYear = CStr(dt.Year)
        DayOfWeek = dt.DayOfWeek()
        strWeekDay = CStr(DayOfWeek)

        CommonFunction.Dates.GetFromAndToDates("1", strFromDate, strToDate, dt.Today.ToString)

        'Modified By SandeepA on 29 Dec,2005 for WeeklyView Page
        strFromDate = CStr(CommonFunctions.Dates.GetDate(CDate(strFromDate)))
        strToDate = CStr(CommonFunctions.Dates.GetDate(CDate(strToDate)))
        'End of Modification by SandeepA on 29 Dec,2005 for WeeklyView Page.

        'CommonFunctions.Dates.GetDate(DateAdd("d", 7, Date.Parse(dtmToDate)))
        'strFromDate = strMonth + "/" + CStr(CInt(strDay) - (CInt(strWeekDay) - 1)) + "/" + strYear
        'strToDate = strMonth + "/" + CStr(CInt(CInt(strDay) - (CInt(strWeekDay) - 1)) + 6) + "/" + strYear
        'End of Addition by SandeepA on 22 Dec,2005

        Response.Write("<Table class=clsTable cellspacing=0 cellpadding=0 width='99.9%'><TR class='clsTRPageCaption'>")
        Response.Write("<TD align=left>TimeSheets</TD>")
        Response.Write("<TD align=Right>|<b><a class='Menu' href='javascript:Tab_OnClick(1,""" & strFromDate & """,""" & strToDate & """)'>My TimeSheet</a></b>|")
        'Added By SandeepA on 22 Dec,2005
        Response.Write("<b><a class='Menu' href='javascript:Tab_OnClick(0,""" & strFromDate & """,""" & strToDate & """)'>Weekly View</a></b>|")
        'End of addition by SandeepA on 22 Dec,2005 

        'Added by MrugajaB on 31st July 2006 For WhizibleSEM 7.2 Issue ID.3734
        'Purpose : Access to 'Weekly Timesheet' functionality through PM Dashboard Enhanced View
        drGetAccess = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_tbl_UI_NodeAccess 3583," & CType(Session("intPostID"), String), MyBase.UseSQL)
        If drGetAccess.Read Then
            If CType(CommonFunctions.Data.CheckIsDBNull(drGetAccess("A"), "0"), Boolean) = True Or _
                CType(CommonFunctions.Data.CheckIsDBNull(drGetAccess("D"), "0"), Boolean) = True Or _
                CType(CommonFunctions.Data.CheckIsDBNull(drGetAccess("E"), "0"), Boolean) = True Or _
                CType(CommonFunctions.Data.CheckIsDBNull(drGetAccess("V"), "0"), Boolean) = True Then
                Response.Write("<b><a class='Menu' href='javascript:Tab_OnClick(3,""" & strFromDate & """,""" & strToDate & """)'>Weekly Timesheet</a><b>|")
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drGetAccess)
        'End Addition

        drGetAccess = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_tbl_UI_NodeAccess 2125," & CType(Session("intPostID"), String), MyBase.UseSQL)
        If drGetAccess.Read Then
            If CType(CommonFunctions.Data.CheckIsDBNull(drGetAccess("A"), "0"), Boolean) = True Or _
                CType(CommonFunctions.Data.CheckIsDBNull(drGetAccess("D"), "0"), Boolean) = True Or _
                CType(CommonFunctions.Data.CheckIsDBNull(drGetAccess("E"), "0"), Boolean) = True Or _
                CType(CommonFunctions.Data.CheckIsDBNull(drGetAccess("V"), "0"), Boolean) = True Then
                Response.Write("<b><a class='Menu' href='javascript:Tab_OnClick(2,""" & strFromDate & """,""" & strToDate & """)'>TimeSheet Approval</a><b>|")
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drGetAccess)

        Response.Write("</TD>")
        HttpContext.Current.Response.Write("</TR></TABLE>" & vbCrLf)

        DisposeObjects()
    End Sub
#End Region

#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting


        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub
End Class
