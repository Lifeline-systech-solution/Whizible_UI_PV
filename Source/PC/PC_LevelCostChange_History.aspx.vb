#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
Imports System.Text
#End Region

Public Class PC_LevelCostChange_History
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
    Private WithEvents m_objGrid As New GenericGrid
    Protected m_lngTagId As Long = 0
    Private m_objGlobal As WebPages.Template.IGlobal

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
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        'Added by Mahavir A.
        m_lngTagId = CType(Request.QueryString("MasterTagID"), Long)

        strMenu = GenerateMenu()
        Response.Write(strMenu)

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

        'Close
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Close_OnClick()")

        'Help 
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Help_OnClick('5003')")

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


        Dim arrColHeadingsList As New ArrayList
        Dim arrColNamesList As New ArrayList
        Dim strSQLQuery As String
        Dim drRecordCount As IDataReader
        Dim intRecordCount As Integer

        '--- Set the Column Headings for the Pending Timesheet List
        arrColHeadingsList.Add("Cost")
        arrColHeadingsList.Add("Effective Date")

        '--- Set the Columns to be used from the SP 
        arrColNamesList.Add("Value")
        arrColNamesList.Add("EffectiveDate")

        '--- Set the TD style array
        Dim arrWidthArray() As String = {"align=left", "align=left", "align=left", "align=left", "align=left"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        '--- Display the Page Caption 
        CommonFunctions.General.WriteHTML("<br>")
        WebPages.Template.PageCaption.GetPageCaptions(, "History for Cost and Effective Date Changes")
        CommonFunctions.General.WriteHTML("<br>")

        'select Value, EffectiveDate from tbl_PM_ProjectCostTYpe_CostType_Grade
        'where(GradeID = 5 And ProjectCostTYpeID = 1 And CostTypeID = 2)
        'order by effectivedate desc

        '--- Display the list of records for the selected Employee
        strSQLQuery = "EXEC usp_Sel_CostChangeHistory " + CType(Request.QueryString("GradeID"), String) + " , " + CType(Request.QueryString("ProjectCostTypeID"), String) + " , " + CType(Request.QueryString("CostTypeID"), String)

        With m_objGrid
            .ActualColumnArray = GetArray(arrColNamesList)
            .UserFriendlyColumnArray = GetArray(arrColHeadingsList)
            .NoOfDataColumns = 2
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:auto"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 400
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            'Added By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

        intRecordCount = m_objGrid.NoOfRows

        m_objGrid = Nothing
        CommonFunctions.General.WriteHTML("<BR><TABLE class=clsTable cellpadding=0 cellspacing=0 width='99.9%'>")
        CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD width='100%' align='right'>")
        CommonFunctions.General.WriteHTML("Total Records " + CStr(intRecordCount) + " </TD></TR></TABLE>")

    End Sub 'Plot controls on the page

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
        ' Author                :
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        m_objGrid = Nothing
        m_objGlobal = Nothing

    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 10, 2005
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function



End Class
