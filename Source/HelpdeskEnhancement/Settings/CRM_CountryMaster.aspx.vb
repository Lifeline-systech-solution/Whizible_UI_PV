Public Class CRM_CountryMaster
    'Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate

    '============================================================================================================================='
    '                           Added By Varsha Jorwekar   Purpose ::: Email Settings Page                                        '
    '============================================================================================================================='

    Protected m_intRoleID As String
    Protected strLoginType As String
    Protected strUserName As String
    Protected intUserID As String

    Protected Shared m_objAccessRights As WebPages.Security.cAccessRights
    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface.
    Protected WithEvents m_objGrid As New WebPages.Template.GenericGrid

    Public txtSQLQuery As New System.Text.StringBuilder
    Public strSQLQuery As String
    Public arrColumnHeadingList As New ArrayList       'To store the column Headings
    Public arrActualColumnNames As New ArrayList
    Public arrWidthArray() As String = {"align=left", "align=left width=10%"}
    Public arrCheckBoxIDs() As String = {"", "chkSelect"}
    Public arrSelectedCheckBoxIDs() As String = {"", ""}
    Public arrIgnoreHTMLEncode() As String = {"0"}
    Public CountryMasterTagID As Integer = 713

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        GetGlobalObject(CountryMasterTagID)
    End Sub

    Public Function PageInit()
        '*******************************************************************************'
        ' Function Name	        :	DrawPage                                            '
        ' Purpose				:   Plotting the page                                   '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       ' 
        ' Author                :   Varsha Jorwekar                                     '
        '*******************************************************************************'

        Dim strHTML As New StringBuilder("")
        Dim objSetting As New CRM_CountryMaster

        Dim str As String = objSetting.DrawPage()
        strHTML.Append(str)

        CommonFunctions.General.WriteHTML(strHTML.ToString)
    End Function

    Public Function DrawPage()

        '*******************************************************************************'
        ' Function Name	        :	DrawPage                                            '
        ' Purpose				:   Plotting the page                                   '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Varsha Jorwekar                                     '
        '*******************************************************************************'
        Dim str As String = ""
        Dim strHTML As New StringBuilder("")
        m_intRoleID = CommonFunctions.General.CheckIsNothing(CType(Session("intLOGINID"), Long), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        strUserName = CType(Session("strUserName"), String)
        intUserID = CType(Session("intUserID"), Integer)

        strHTML.Append("<div id='EmailSettings' class='tabcontent2 h-type h-form clsSettingstabs'>")

       

        strHTML.Append("<div id='divTypeStatus'>")
        strHTML.Append("<div class='type-top-bar top-bar' id='divTypeTab'>")
        strHTML.Append("<ul class='left'>")
        strHTML.Append("<li class='search-bar'>")
        strHTML.Append("<i class='fa fa-search faSettingSearch'  aria-hidden='true'></i>")
        strHTML.Append("<input type='text' id='SearchRquestType' placeholder='Search in table'>")
        strHTML.Append("</li>")
        strHTML.Append("</ul>")
        strHTML.Append(" </div>")

        strHTML.Append("<div id='divgrid'>")
        '<!----------------------------  Grid Plotting  ----------------------------->

        str = PlotRefreshGrid()
        strHTML.Append(str)

        '****************************************************************************************************************************************
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        Return strHTML.ToString()
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function RefreshGrid()
        '*******************************************************************************'
        ' Function Name	        :	RefreshGrid                                         '
        ' Purpose				:   Call PlotRefreshGrid()                              '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Varsha Jorwekar                                     '
        '*******************************************************************************'
        Try
            Dim objSetting As New CRM_EmailSettings
            Dim strHTML As New StringBuilder("")
            Dim str As String = objSetting.PlotRefreshGrid()
            strHTML.Append(str)
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    Public Function PlotRefreshGrid()
        '*******************************************************************************'
        ' Function Name	        :	PlotRefreshGrid                                     '
        ' Purpose				:   Plotting the grid                                   '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Varsha Jorwekar                                     '
        '*******************************************************************************'
        '/*Changed By Yasmin on 25th july 2018*/

        Dim strHTML As New StringBuilder("")
        txtSQLQuery.Append("EXEC usp_NG2_sel_d_tbl_PM_CountryMaster")
        strSQLQuery = txtSQLQuery.ToString

        arrColumnHeadingList.Add("Country Name")

        arrActualColumnNames.Add("CountryName")
    
        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            .CheckboxCheckOnColumnArray = arrSelectedCheckBoxIDs
            .NoOfDataColumns = 1
            .PrimaryKey = "CountryID"
            .TDStyleArray = arrWidthArray
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 222
            .DIVStyle = "overflow:unset !important"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = False
            .UseSQL = True
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode

            strHTML.Append(.DrawGrid())
        End With

        Return strHTML.ToString()

    End Function

    Public Function GetArray(ByVal arrList As ArrayList) As String()
        '================================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : tejal D
        ' Created               : 
        ' Revisions             :
        '===============================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function


    Protected Sub GetGlobalObject(ByVal TagID As String)
        '=============================================================================
        ' Procedure Name        :	GetGlobalObject
        ' Purpose               :	Get the global object and assign it to variable
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Vidya Jadhav
        ' Created               :	2 Dec 2016
        '=============================================================================

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objGlobal.TagID = TagID
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

    End Sub

    '============================================================================================================================='
    '                          End of Added By Varsha Jorwekar   Purpose ::: Email Settings Page                                  '
    '============================================================================================================================='

#Region "Jquery AJAX Web Methods"
    Public Shared Function GetSerialized(dt As DataTable) As String
        Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim rows As New List(Of Dictionary(Of String, Object))()
        Dim row As Dictionary(Of String, Object)
        Dim jsonString As String = ""

        For Each dr As DataRow In dt.Rows
            row = New Dictionary(Of String, Object)()
            For Each col As DataColumn In dt.Columns
                If col.DataType = GetType(DateTime) Then
                    col.DateTimeMode = DataSetDateTime.Unspecified
                End If
                row.Add(col.ColumnName, dr(col))
            Next
            rows.Add(row)
        Next
        jsonString = serializer.Serialize(rows)

        Return jsonString
    End Function
#End Region
End Class