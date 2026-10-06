Public Class CRM_ActivityMaster
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
    Protected Addaccess = ""
    Protected Editaccess = ""
    Protected Deleteaccess = ""
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
        Addaccess = m_objAccess.Add
        Editaccess = m_objAccess.Edit
        Deleteaccess = m_objAccess.Delete
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
        strHTML.Append("<div class='panel-heading' role='tab' id='headingOne2'><h3><span><i class='fa fa-plus' style='float: none; padding-left: 10px;'></i><span style='margin-left: 5px;'>Add New Activity</span></span></h3><h4 class='panel-title'>")
        strHTML.Append("<a role='button' data-bs-toggle='collapse' data-parent='#accordion2' href='#collapseOne2' aria-expanded='true' aria-controls='collapseOne2' class='' id='Addaccordion'><i id='plus' class='fa fa-plus toggle-plus' title='Expand'></i><i id='minus' class='fa fa-minus toggle-plus' title='Hide'></i></a></h4>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='collapseOne2' class='panel-collapse collapse show' role='tabpanel' aria-labelledby='headingOne2' aria-expanded='true' style=''>")
        '/*'/*Added by Kashish for ui change*/
        strHTML.Append("<div class='panel-body'>")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;'> Activity* </label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtActivity", "txtActivity", "form-control", 219, 1000, , , , , , , , " class='form-control'  placeholder='Enter Activity' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group' style='    border-bottom: none; margin-top: 5px; '>")
        strHTML.Append("<div class='right'>")
        If m_objAccess.Edit = True Or m_objAccess.Add = True Then
            strHTML.Append("<button type='button' id='Save' class='btn btn-default save' onclick='SaveActivity()' style='background-color: #343660; color: #ffffff' >Save</button>")
            strHTML.Append("<button type='button' id='SaveandAdd' class='btn btn-default save clsbuttonLinks' onclick='SaveAndAddActivity()' style='border-left: 1px solid; margin-left: 5px; background-color: #343660; color: #ffffff'><i class='fa fa-plus' id='idPlus' aria-hidden='true'style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i>Save and Add</button>")
        End If
        strHTML.Append("<button type='button' id='Cancel' class='btn btn-default save clsbuttonLinks' onclick='CancelActivity()' style='margin-right: 19px;    margin-left: 5px; background-color: #343660; color: #ffffff' >Cancel</button>")
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
        '/*Changed By Yasmin on 25th july 2018*/

        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div class='type-top-bar top-bar' id='CustomerFilter'>")

        strHTML.Append("<ul class='left'>")
        strHTML.Append("<li class='search-bar'>")
        strHTML.Append("<div class='left search-bar'>")
        strHTML.Append("<i id='idSearchHistory' class='fa fa-search' aria-hidden='true'></i>")
        strHTML.Append("<input type='text' id='txtSearchHistory' placeholder='Search in table' >")
        strHTML.Append("</div>")
        strHTML.Append("</li>")
        strHTML.Append("</ul>")

        strHTML.Append("<ul class='right'>")
        If m_objAccess.Add = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("<button type='button' class='btn btn-default' onclick='AddActivity()' title='Add Activity'>Add<i class='fa fa-plus' aria-hidden='true'></i></button>")
            strHTML.Append("</li>")
        End If
        If m_objAccess.Delete = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append(" <button type='button' class='btn btn-default' title='Delete Activity' onclick='DeleteActivity()'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
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

        intNoOfDataColumn = 1
        strDivID = "divActivityGrid"
        strSQLQuery = "usp_NG2_Sel_tbl_CRM_Activity_Master "

        arrstrActualList = {"Activity", "Edit", "Delete"}
        arrstrUserFriendlyList = {"Activity", "Edit", "Delete"}
        arrstrLinkArray = {"", "", ""}
        arrCheckBoxArray = {"", "", ""}
        arrWidthArray = {"align=left", "align=center", "align=center"}
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

        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center'  title='Edit Activity'><i class='fas fa-edit' data-placement='bottom' data-toggle='tooltip' style='font-size:14px!important;cursor:pointer;' onclick=""Activity_OnClick(" & Args.DataReader("ActivityID") & ")""   id='Editdata_" & Args.DataReader("ActivityID") & "'></i></td>"
            Args.StringToBeInserted += "<input type='hidden' id='txthdnActivity_" & Args.DataReader("ActivityID") & "' value='" + Args.DataReader("Activity") + "'>"
        End If

        'Commented & Added By Dipali V On 22nd Dec 2017 For Select All option 
        'If Args.ColumnName.ToUpper = "DELETE" Then
        '    Cancel = True

        '    Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type=checkbox id=chkActivityDelete name=chkActivityDelete  value=" & Args.DataReader("ActivityID") & " >" + "</TD>"

        'End If
        Dim m_strCanActivityDelete As String = ""
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            m_strCanActivityDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Chk_tbl_CRM_Query_Activity " & Args.DataReader("ActivityID"), True), "0")

            If m_strCanActivityDelete = "0" Then
                Args.StringToBeInserted = "<td style='text-align:center;' Title = 'Delete Activity'><input type=checkbox id=chkActivityDelete name=chkActivityDelete  value=" & Args.DataReader("ActivityID") & " >" + "</TD>"
            Else
                Args.StringToBeInserted = "<td style='text-align:center;'' Title='" & m_strCanActivityDelete & "'><input type=checkbox id=chkActivityDelete name=chkActivityDelete disabled value=" & Args.DataReader("ActivityID") & ">" + "</TD>"
            End If
        End If

        'End of Commented & Added By Dipali V On 22nd Dec 2017 For Select All option 
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
    Public Shared Function SaveActivity(ByVal ActivityID As String, ByVal Activity As String) As String
        '=====================================================================
        ' Procedure Name        : SaveActivity
        ' Description           : To save login details
        ' Created Date           : 08-DEC-2017
        'Purpose :  To save activity
        '=====================================================================
        Dim m_ActivityID As String
        If ActivityID = "" Then
            ActivityID = "null"
        End If

        Dim strSQl As String = "usp_NG2_Ins_tbl_CRM_Activity_Master " & ActivityID & ",'" & Activity & "'"
        Dim strFlag = ""
        Try
            ' CommonFunction.Data.InsertOrUpdateData(strSQl, True)
            m_ActivityID = CStr(CommonFunction.Data.GetDataScalar(strSQl, True))
            strFlag = "1"



            If m_ActivityID Is Nothing Then
                m_ActivityID = ActivityID
            End If
            Return m_ActivityID
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod>
    Public Shared Function CheckIsDuplicate(ByVal Activity As String, ByVal ActivityID As String) As String
        '=====================================================================
        ' Procedure Name        : CheckIsDuplicate
        ' Description           : To is acitivity name alreadt exists
        ' Created Date           : 08-DEC-2017
        'Purpose :  To save activity
        '=====================================================================
        Dim strSQl As String = "usp_NG2_IsDuplicate_Activity '" & Activity & "'," & ActivityID & ""
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
            Dim objActivity As New CRM_ActivityMaster()
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



            strSQL = "usp_NG2_del_tbl_CRM_Activity_Master  '" & ActivityID & "'"

            strResult = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True))


            Return strResult
        Catch ex As Exception
            Return "Bad Request found"

        End Try

    End Function
End Class