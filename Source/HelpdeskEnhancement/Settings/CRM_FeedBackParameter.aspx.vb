Public Class CRM_FeedBackParameter
    Inherits WebPages.Template.WhizTemplate
#Region "Member Declaration"
    Private WithEvents m_objActivityGrid As New WebPages.Template.GenericGrid
    Private WithEvents objGrid As WebPages.Template.GenericGrid
    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Private Shared m_objAccess As WebPage.Templates.AccessRights
    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface.
    Protected Shared TagID As String = ""
    Protected Shared m_intRoleID As Integer = 0
    Protected Shared strLoginType = ""
    Protected Shared StrEditUniqueID As Integer = 0

    Public txtSQLQuery As New System.Text.StringBuilder
    Public strSQLQuery As String
    Public arrColumnHeadingList As New ArrayList       'To store the column Headings
    Public arrActualColumnNames As New ArrayList
    Public arrWidthArray() As String = {"align=left", "align=center width=10%"}
    Public arrCheckBoxIDs() As String = {"", "chkSelect"}
    Public arrSelectedCheckBoxIDs() As String = {"", ""}
    Protected WithEvents m_objGrid As New WebPages.Template.GenericGrid
#End Region
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        m_intRoleID = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), 0), Long)
        TagID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("MasterTagID"), Integer), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        GetAccessRights()
    End Sub
    Private Sub GetAccessRights()
        '=====================================================================
        ' Procedure Name        :	GetAccessRights
        ' Purpose               :	Get the Access Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Yogesh Jalamkar
        ' Created               :	08-DEC-2017
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

    End Sub
    Protected Function WritePage(Optional ByVal strflag = "")
        '=====================================================================
        ' Procedure Name        : WriteTabsControls()	
        ' Purpose               : To Plot the Tab Controls
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : YOgesh Jalamkar
        ' Created               :08-DEC-2017
        ' Revisions             : None
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        strHTML.Append(DrawFilter())
        strHTML.Append("<div class='table-responsive' id='divActivity'>")
        strHTML.Append(DrawGrid())
        strHTML.Append("</div>")

        ''Grid Plotting End
        ''Collapse Button Start
        strHTML.Append("<div class='bottom-bar' id='divSubTypeBottom edit_target'>")
        strHTML.Append("<div class='pannel-section'>")
        strHTML.Append("<div class='col-md-12 col-sm-12'>")
        strHTML.Append("<div class='panel-group wrap' id='accordion2' role='tablist' aria-multiselectable='true'>")
        strHTML.Append("<div class='panel'>")
        strHTML.Append("<div class='panel-heading' role='tab' id='headingOne2'><h3><span><i class='fa fa-plus' style='float: none; padding-left: 10px;'></i><span style='margin-left: 5px;'>Add Feedback Parameter</span></span></h3><h4 class='panel-title'>")
        strHTML.Append("<a role='button' data-toggle='collapse' id='Addaccordion' data-parent='#accordion2' href='#collapseOne2' aria-expanded='true' aria-controls='collapseOne2' class=''><i id='plus' class='fa fa-plus toggle-plus' title='Expand'></i><i id='minus' class='fa fa-minus toggle-plus' title='Hide'></i></a></h4>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='collapseOne2' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne2' aria-expanded='true' style=''>")
        strHTML.Append("<div class='panel-body'>")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;'> Feedback Parameter* </label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtParameter", "txtParameter", "form-control", 219, 1000, , , , , , , , " class='form-control'  placeholder='Enter Feedback Parameter' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;'> Rating* </label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRating", "txtRating", "form-control", 219, 1000, , , , , , , , " class='form-control' placeholder='Enter Rating'  ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))

        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' style='    border-bottom: none; margin-top: 5px; '>")
        strHTML.Append("<div class='right'>")
        If m_objAccess.Add = True Or m_objAccess.Edit = True Then
            strHTML.Append("<button type='button' id='Save' class='btn btn-default save'  onclick='SaveActivity()' style='background-color: #343660; color: #ffffff'>Save</button>")
            strHTML.Append("<button type='button' id='SaveandAdd' class='btn btn-default save clsbuttonLinks'  onclick='SaveAndAddActivity()' style='border-left: 1px solid; margin-left: 5px; background-color: #343660; color: #ffffff'>Save and Add<i class='fa fa-plus' id='idPlus' aria-hidden='true'style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
        End If
        strHTML.Append("<button type='button' id='History' class='btn btn-default save clsbuttonLinks'  onclick='ShowHistory_OnClick()' style=' display:none; margin-left: 5px; background-color: #343660; color: #ffffff'>Show History</button>")
        strHTML.Append("<button type='button' id='Cancel' class='btn btn-default save clsbuttonLinks'  onclick='Cancel_Login()' style='margin-right: 19px;    margin-left: 5px; background-color: #343660; color: #ffffff'>Cancel</button>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</form>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        ''Collapse Button End      
        If strflag = "1" Then
            Return strHTML.ToString()
        Else
            CommonFunction.General.WriteHTML(strHTML.ToString)
        End If
    End Function
    Protected Function DrawFilter() As String
        '=====================================================================
        ' Procedure Name        :DrawFilter()
        ' Purpose               : To Plot the Request Tab Controls
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                :YOgesh Jalamkar
        ' Created               :08-DEC-2017
        ' Revisions             : None
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div class='type-top-bar top-bar' id='CustomerFilter'>")

        strHTML.Append("<ul class='left'>")
        'strHTML.Append("<li class='search-bar'>")
        'strHTML.Append("<div class='left search-bar'>")
        'strHTML.Append("<i id='idSearchHistory' class='fa fa-search' aria-hidden='true'></i>")
        'strHTML.Append("<input type='text' id='txtSearchHistory' placeholder='Search Parameter' title='Search Parameter'>")
        'strHTML.Append("</div>")
        'strHTML.Append("</li>")
        '/*Changed By Yasmin on 25th july 2018*/

        strHTML.Append("<li class='left search-bar'>")
        strHTML.Append("<div class='left search-bar'>    ")
        strHTML.Append(" <i class='fa fa-search faSettingSearch' aria-hidden='true'>")
        strHTML.Append("</i> ")
        strHTML.Append("<input type='text' id='txtSearchHistory' placeholder='Search in table' >")
        strHTML.Append("</div>")
        strHTML.Append("</li>")
        strHTML.Append("</ul>")

        strHTML.Append("<ul class='right'>")
        If m_objAccess.Add = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("<button type='button' class='btn btn-default' title='Add Feedback' onclick='AddActivity()'>Add<i class='fa fa-plus' aria-hidden='true'></i></button>")
            strHTML.Append("</li>")
        End If
        If m_objAccess.Delete = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append(" <button type='button' class='btn btn-default' title='Delete Feedback' onclick='DeleteActivity()'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
            strHTML.Append("</li>")
        End If
        strHTML.Append("</ul>")

        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Protected Function DrawGrid() As String
        '=====================================================================
        ' Procedure Name        :DrawCustomerGrid()
        ' Purpose               : To Plot employee grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : YOgesh Jalamkar
        ' Created               : 08-DEC-2017
        ' Revisions             : None
        '=====================================================================
        Dim strGridHTML As New StringBuilder("")
        Dim strSQLQuery As String = ""
        Dim intNoOfDataColumn As Int16
        Dim strDivID As String = ""
        Dim arrstrActualList() As String
        Dim arrstrUserFriendlyList() As String
        Dim arrstrLinkArray() As String
        Dim arrCheckBoxArray() As String
        Dim arrWidthArray() As String
        Dim Flag As Integer = 0



        '/*Changed By Yasmin on 25th july 2018*/

        intNoOfDataColumn = 2
        strDivID = "divActivityGrid"
        strSQLQuery = "usp_NG2_Sel_tbl_CRM_FeedbackMaster "

        arrstrActualList = {"ParameterName", "Rating", "Edit", "Delete"}
        arrstrUserFriendlyList = {"Feedback Parameter", "Rating", "Edit", "Delete"}
        arrstrLinkArray = {"", "", "", ""}
        arrCheckBoxArray = {"", "", "", ""}
        arrWidthArray = {"align=left", "align=left", "align=center", "align=center"}
        objGrid = m_objActivityGrid
        If Flag = 0 Then
            With objGrid
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto;width:100%"
                .ColNameToolTipOnEachRow = False
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = False
                .UseSQL = True
                '.ClientSideSortFunctionName = "Sort_OnClickwe_For_CRM"
                '.SortBy = strSortBy
                '.SortOrder = strSortOrder
                ' .CurrentPage = m_intPageNumber
                ' .PageSize = m_intNoOfRecordInGrid
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With

            'intRecordCount = m_objGridAttachment.NoOfRows

            objGrid = Nothing
        End If

        Return strGridHTML.ToString
    End Function


    Private Sub m_objEmpGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objActivityGrid.DataRowTD_BeforePrint
        Dim CheckEnable As String

        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center'  title='Edit Feedback'><i class='fa fa-pencil-square-o' data-placement='bottom' data-toggle='tooltip' style='font-size:16px!important;cursor:pointer;' onclick=""Activity_OnClick(" & Args.DataReader("FeedbackID") & ")""   id='Editdata_" & Args.DataReader("FeedbackID") & "'></i></td>"
            Args.StringToBeInserted += "<input type='hidden' id='txthdnActivity_" & Args.DataReader("FeedbackID") & "' value='" + Args.DataReader("ParameterName") + "'>"
            Args.StringToBeInserted += "<input type='hidden' id='txthdnRating_" & Args.DataReader("FeedbackID") & "' value=" & Args.DataReader("Rating") & ">"
        End If

        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Dim strSQLCheckEnable As String = "Usp_Check_Feedback_Used " & Args.DataReader("FeedbackID") & ""
            CheckEnable = CommonFunctions.Data.GetDataScalar(strSQLCheckEnable, True)

            If CheckEnable = "1" Then
                Args.StringToBeInserted = "<td align='center' Title = 'Feedback is in use. Can not delete'><input type=checkbox id=chkActivityDelete name=chkActivityDelete  disabled value=" & Args.DataReader("FeedbackID") & " >" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Delete Feedback'><input type=checkbox id=chkActivityDelete name=chkActivityDelete  value=" & Args.DataReader("FeedbackID") & " >" + "</TD>"
            End If
            
        End If


    End Sub

    Private Sub m_objEmpGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objActivityGrid.ColumnHeaderTD_BeforePrint

        Select Case UCase(Trim(Args.DataField & ""))
            Case "ACTIVITY"
                Cancel = True
                Args.ApplyHTMLEncode = False
                Args.ApplySorting = False
                Args.TDStyle = " "
                Args.StringToBeInserted = "<th align='center'> Activity<i class='fa fa-sort' aria-hidden='true'></i></th>"
        End Select
        'Added by Dipali V on 22nd dec 2017 For Remove Delete  Caption Header and Plot CheckBox For Select All 

        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='DeleteMultiple_Activity()' type=checkbox id=chkAllActivity name=chkAllActivity title='Select All'/></th>"
        End If

        'End of Added by Dipali V on 22nd dec 2017 For Remove Delete  Caption Header and Plot CheckBox For Select All 

    End Sub
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveActivity(ByVal ActivityID As String, ByVal Parameter As String, ByVal Rating As String) As String
        '=====================================================================
        ' Procedure Name        : SaveActivity
        ' Description           : To save login details
        ' Created Date           : 08-DEC-2017
        'Purpose :  To save activity
        '=====================================================================
        Try
            If ActivityID = "" Then
                ActivityID = "null"
            End If

            Dim strSQl As String = "usp_NG2_Ins_tbl_CRM_FeedbackMaster " & ActivityID & ",'" & Parameter & "'," & Rating & ",'" & HttpContext.Current.Session("strUserName") & "'"
            Dim strFlag = ""

            CommonFunction.Data.InsertOrUpdateData(strSQl, True)
            strFlag = "1"
            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function CheckIsDuplicate(ByVal Rating As String, ByVal EditActivityID As String) As String
        '=====================================================================
        ' Procedure Name        : CheckIsDuplicate
        ' Description           : To is acitivity name alreadt exists
        ' Created Date           : 08-DEC-2017
        'Purpose :  To save activity
        '=====================================================================
        Dim strSQl As String = "usp_NG2_IsDuplicate_Rating '" & Rating & "'," & EditActivityID
        Dim strFlag = ""
        Try
            strFlag = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQl, True), "")
            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function RefreshPlotGrid() As String
        '=====================================================================
        ' Procedure Name        : RefreshGrid
        ' Purpose               : To Refresh Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Yogesh Jalamkar
        ' Created Date           :08-DEc-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objActivity As New CRM_FeedBackParameter()
            strGridHTML.Append(objActivity.WritePage("1"))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteActivity(ByVal ActivityID As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteActivity
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete customer
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================

        Dim strSQL As String = ""
        Dim strResult As String = ""
        Try



            strSQL = "usp_NG2_Del_tbl_CRM_Feedback  '" & ActivityID & "'"

            strResult = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True))


            Return strResult
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ShowMailHistoryDetails(ByVal UniqueID As Integer)
        '*******************************************************************************'
        ' Function Name	        :	ShowMailHistoryDetails                              '
        ' Purpose				:   Call ShowMailHistoryGrid function                   '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Varsha Jorwekar                                     '
        '*******************************************************************************'
        Try
            Dim objSetting As New CRM_FeedBackParameter
            StrEditUniqueID = UniqueID
            Dim strHTML As New StringBuilder("")
            Dim str As String = objSetting.ShowMailHistoryGrid(UniqueID, "")
            strHTML.Append(str)
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    Public Function ShowMailHistoryGrid(ByVal UniqueID As Integer, Optional ByVal storedprocedure As String = Nothing)
        '*******************************************************************************'
        ' Function Name	        :	ShowMailHistoryGrid                                 '
        ' Purpose				:   Plotting the grid                                   '
        ' Parameters Passed     :   UniqueID                                            '
        ' Returns               :   grid                                                '
        ' Author                :   Varsha Jorwekar                                     '
        '*******************************************************************************'
        '/*Changed By Yasmin on 25th july 2018*/

        Dim strHTML As New StringBuilder("")

        If (storedprocedure = Nothing) Then
            txtSQLQuery.Append("EXEC usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory '" & 916 & "','" & UniqueID & "'")
        Else
            txtSQLQuery.Append(storedprocedure)
        End If

        strSQLQuery = txtSQLQuery.ToString

        arrColumnHeadingList.Add("Modified Date")
        arrColumnHeadingList.Add("Field Modified")
        arrColumnHeadingList.Add("Modified By")
        arrColumnHeadingList.Add("Value")

        arrActualColumnNames.Add("Date")
        arrActualColumnNames.Add("FieldName")
        arrActualColumnNames.Add("ModifiedBy")
        arrActualColumnNames.Add("Value")
        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            .CheckboxCheckOnColumnArray = arrSelectedCheckBoxIDs
            .NoOfDataColumns = 4
            .PrimaryKey = "LogID"
            .TDStyleArray = arrWidthArray
            .ColNameToolTipOnEachRow = False
            .DIVID = "ShowHistoryGrid"
            .DIVStyle = "overflow: auto !Important"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = False

            .UseSQL = True
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SortOrder = "DESC"
            strHTML.Append(.DrawGrid())
        End With

        Return strHTML.ToString()

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function FilteredHistory(ByVal newModifiedField As String, ByVal MessageID As Integer, ByVal newModifiedBy As String)
        '================================================================================
        ' Procedure Name        : FilteredHistory()	
        ' Purpose               : Get Email setting details for selected filter
        ' Description           : Get Email setting details for selected filter
        ' Parameters Passed     : newModifiedField
        ' Returns               : Datatable (String format)
        ' Parameters Affected   : None.
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Varsha Jorwekar
        ' Created               : 01-Dec-2017
        ' Revisions             :
        '===============================================================================
        Try
            Dim strSQL As String
            Dim strResult As String
            Dim dt As DataTable
            Dim objSetting As New CRM_FeedBackParameter
            If newModifiedBy = "" Then
                newModifiedBy = "null"
            End If
            If newModifiedField = "" Then
                newModifiedField = "null"
            End If
            strSQL = "usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory 916, '" & MessageID & "','" & newModifiedField & "','" & newModifiedBy & "'"

            Dim str As String = objSetting.ShowMailHistoryGrid(MessageID, strSQL)

            Return str
        Catch ex As Exception
            Return "Bad Request found"
        End Try


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
End Class