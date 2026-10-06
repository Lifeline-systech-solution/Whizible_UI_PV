
Imports Whizible
Public Class ShowHistory_TimeSheetConfiguration
    Inherits WebPages.Template.WhizTemplate

    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Protected Shared Heading_ToolSkill As String = ""
    Protected m_strNatureOfDemandStageID As String = ""
    Protected m_strPageNumber As String = ""
    Protected strMenu As String

    Private Shared WithEvents m_objstakeholderGrid As New WebPages.Template.GenericGrid



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)


    End Sub

    Public Sub PageInit()
       
        Response.Write("<DIV ID='PageDiv' Style='OVERFLOW:auto'>")

        WriteMenu()
        DisplayData_Grid()
        Response.Write("</DIV>")

    End Sub


    Private Sub DisplayData_Grid()
        '=====================================================================
        ' Procedure  Name		:	
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	plotting Grid Tools And Skills
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	tejal D
        ' Created				:  6/12/2016
        '=====================================================================

        Dim txtSQLQuery As New System.Text.StringBuilder
        Dim strSQLQuery As String
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim arrWidthArray() As String = {"align=left", "align=Left", "align=Left", "align=Left"}
        Dim arrCheckBoxIDs() As String = {"", "", "", ""}
        Dim arrSelectedCheckBoxIDs() As String = {"", "", "", ""}
        Dim arrIgnoreHTMLEncode() As String = {"0"}


        txtSQLQuery.Append("usp_Sel_ShowHistory_tbl_CNF_NG2_TimesheetConfigurationSettings_AuditTrail")
        strSQLQuery = txtSQLQuery.ToString
        ''-------------------------------------------------------------------
        arrColumnHeadingList.Add("Field Name")
        arrColumnHeadingList.Add("Field Value")
        arrColumnHeadingList.Add("Modified By")
        arrColumnHeadingList.Add("Modified Date")


        arrActualColumnNames.Add("FieldName")
        arrActualColumnNames.Add("FieldValue")
        arrActualColumnNames.Add("ModifiedBy")
        arrActualColumnNames.Add("ModifiedDate")

        m_objstakeholderGrid = New WebPages.Template.GenericGrid
        With m_objstakeholderGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            ' .RowLinkArray = arrColRowLinks
            .CheckboxCheckOnColumnArray = arrSelectedCheckBoxIDs

            .NoOfDataColumns = 4
            '.GroupOnColumn = arrGroupOn
            .PrimaryKey = "AuditID"
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 450
            .DIVStyle = "overflow:auto"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True

            .IgnoreHTMLEncode = arrIgnoreHTMLEncode

            .DrawGrid()
        End With


        ' Clear Memory
        m_objstakeholderGrid = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing
        ' arrColRowLinks = Nothing


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
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Protected Sub WriteMenu()

        'Procedure Name         : WriteMenu()
        ' Parameters Passed		:	
        ' Returns				:	
        ' Parameters Affected	:	None
        ' Purpose				:	to plot Menu(Link)
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	tejal eshmukh 
        ' Created				:	15/7/2017
        ' Revisions				:	
        '=====================================================================
        Dim arrMenu() As String
        Dim arrMenuToolTip() As String
        Dim arrCSFunction() As String
        Dim sbSTRHTML As New System.Text.StringBuilder


        Dim m_arrMenu() As String = {"Close"}
        Dim m_arrMenuToolTip() As String = {"Close"}
        Dim m_arrCSFunction() As String = {"close_OnClick();"}

        arrMenu = m_arrMenu
        arrMenuToolTip = m_arrMenuToolTip
        arrCSFunction = m_arrCSFunction


        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, True)

        CommonFunction.General.WriteHTML(strMenu)

        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Show History TimeSheet Configuration", , , True))

        sbSTRHTML.Append("</BR>")


        CommonFunction.General.WriteHTML(sbSTRHTML.ToString())

    End Sub


    
   
End Class



