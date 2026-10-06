Public Class EntityUpdateSchedule
    Inherits WebPages.Template.WhizTemplate
#Region "Member Declaration"
    Private WithEvents m_objEntityGrid As New WebPages.Template.GenericGrid
    Private WithEvents objGrid As WebPages.Template.GenericGrid
    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Private m_objAccess As WebPage.Templates.AccessRights
    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface.
    Protected TagID As String = ""
    Protected m_intRoleID As Integer = 0
    Protected strLoginType = ""
    Protected strRowCount = ""
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
        ' Procedure Name        : WritePage()	
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
        strHTML.Append(DrawFilter(strflag))
        strHTML.Append("<div class='table-responsive' id='divEntity'>")
        strHTML.Append(DrawGrid())
        strHTML.Append("</div>")

        ''Grid Plotting End
        ''Collapse Button Start
        strHTML.Append("<div class='bottom-bar' id='divSubTypeBottom edit_target'>")
        strHTML.Append("<div class='pannel-section'>")
        strHTML.Append("<div class='col-md-12 col-sm-12'>")
        strHTML.Append("<div class='panel-group wrap' id='accordion2' role='tablist' aria-multiselectable='true'>")
        strHTML.Append("<div class='panel'>")
        strHTML.Append("<div class='panel-heading' role='tab' id='headingOne2'><h3><span><i class='fa fa-plus' style='float: none; padding-left: 10px;'></i><span style='margin-left: 5px;'> Entity Update schedule </span></span></h3><h4 class='panel-title'>")
        strHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion2' href='#collapseOne2' aria-expanded='true' aria-controls='collapseOne2' class='' id='Addaccordion'><i id='plus' class='fa fa-plus toggle-plus' title='Expand'></i><i id='minus' class='fa fa-minus toggle-plus' title='Hide'></i></a></h4>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='collapseOne2' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne2' aria-expanded='true' style=''>")
        strHTML.Append(EntityDetails(strflag))
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
    Protected Function EntityDetails(Optional ByVal EntityID As String = "")
        Dim strHTML As New StringBuilder("")
        Dim strSQL As String = "usp_NG2_Sel_tbl_CDB_Update_Schedule " & EntityID
        Dim strEntityName As String = ""
        Dim strSQLToUpdate As String = ""
        Dim strUpdateSchedule As String = ""
        Dim StartTime As String = ""
        Dim strLastUpdate As String = ""
        Dim drEntity As IDataReader
        Dim strCurrentDate As String = ""

        drEntity = CommonFunction.Data.GetDataReader(strSQL, True)
        If drEntity.Read Then
            strCurrentDate = CommonFunction.Data.CheckIsDBNull(drEntity("CurrentDate"), "")
            If EntityID <> "" Then
                strEntityName = CommonFunction.Data.CheckIsDBNull(drEntity("EntityName"), "")
                strSQLToUpdate = CommonFunction.Data.CheckIsDBNull(drEntity("SQLToUpdate"), "")
                strUpdateSchedule = CommonFunction.Data.CheckIsDBNull(drEntity("UpdateSchedule"), "")
                StartTime = CommonFunction.Data.CheckIsDBNull(drEntity("StartTime"), "")
                strLastUpdate = CommonFunction.Data.CheckIsDBNull(drEntity("LastUpdate"), "")
            End If
        End If
        strHTML.Append("<div class='panel-body'>")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;'> Schedule Name* </label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEntityName", "txtEntityName", "form-control", 200, 200, strEntityName, , , , , , , " class='form-control'  placeholder='Enter  Schedule Name' ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txthdnCurrentDate", "txthdnCurrentDate", "form-control", 200, , strCurrentDate, , , , , , True, " class='form-control' placeholder='Enter  Current date'  ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))

        strHTML.Append("</div>")
        strHTML.Append("</div>")

       


        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Stored Procedure* </label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSQLToUpdate", "usp_QRB_UpdateSchedule_StoredProcedures", 200, strSQLToUpdate, "class='form-control' placeholder='Enter Stored Procedure'  ", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' style='text-align: right;font-size: 11px'> Update Schedule* </label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboUpdateSchedule", "usp_QRB_UpdateSchedule_Schedules", 200, strUpdateSchedule, "class='form-control' ", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Start Time* </label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboStartTime", "usp_Qrb_Sel_QuerySchedule_Time ", 200, StartTime, " class='form-control'  ", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group'>")
        'strHTML.Append("<div class='col-sm-6'>")
        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right;font-size: 11px'> Next Update* </label>")
        'strHTML.Append("<label for='sel1'>Next Update</label>")
        strHTML.Append("<div class='col-sm-4' style='margin-bottom:-20px'>")
        If (strLastUpdate <> "") Then
            'Commented & Added by Dipali V on 15th Dec 
            ' strHTML.Append("<input type='text' value='" & strLastUpdate & "'  class='form-control' id='dtUpdatedate' placeholder='Enter Next Update''>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("dtUpdatedate", "dtUpdatedate", "form-control", 200, , strLastUpdate, , , , , , False, " class='form-control' placeholder='Enter Next Update'", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        Else
            'Commented & Added by Dipali V on 15th Dec 
            ' strHTML.Append("<input type='text' value=''  class='form-control' id='dtUpdatedate' placeholder='Enter Next Update'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("dtUpdatedate", "dtUpdatedate", "form-control", 200, , strCurrentDate, , , , , , False, " class='form-control' placeholder='Enter Next Update'", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        End If

        strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtUpdatedate').datepicker({orientation: 'right top'});$('#dtUpdatedate').datepicker('show');""></i>")
        strHTML.Append("</div>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='form-group' style='    border-bottom: none; margin-top: 5px; '>")
        strHTML.Append("<div class='right'>")
        If EntityID <> "" Then
            strHTML.Append("<button type='button' id='Save' class='btn btn-default save' onclick='SaveEntity()' style='background-color: #343660; color: #ffffff'>Save</button>")
            strHTML.Append("<button type='button' id='SaveandAdd' class='btn btn-default save clsbuttonLinks' onclick='SaveAndAddEntity()' style='border-left: 1px solid; margin-left: 5px; background-color: #343660; color: #ffffff' >Save and Add<i class='fa fa-plus' id='idPlus' aria-hidden='true'style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
        Else
            If m_objAccess.Add = True Or m_objAccess.Edit = True Then
                strHTML.Append("<button type='button' id='Save' class='btn btn-default save' onclick='SaveEntity()' style='background-color: #343660; color: #ffffff' >Save</button>")
                strHTML.Append("<button type='button' id='SaveandAdd' class='btn btn-default save clsbuttonLinks' onclick='SaveAndAddEntity()' style='border-left: 1px solid; margin-left: 5px; background-color: #343660; color: #ffffff' >Save and Add<i class='fa fa-plus' id='idPlus' aria-hidden='true'style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
            End If

        End If

        strHTML.Append("<button type='button' id='Cancel' class='btn btn-default save clsbuttonLinks' onclick='Cancel_Login()' style='margin-right: 19px;    margin-left: 5px; background-color: #343660; color: #ffffff' >Cancel</button>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</form>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Protected Function DrawFilter(Optional ByVal strFlag As String = "") As String
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
        strHTML.Append("<div class='type-top-bar top-bar' id='EntityFilter'>")

        strHTML.Append("<ul class='left'>")
        strHTML.Append("<li class='search-bar'>")
        strHTML.Append("<div class='left search-bar'>")
        strHTML.Append("<i id='idSearchHistory' class='fa fa-search' aria-hidden='true'></i>")
        strHTML.Append("<input type='text' id='txtSearchHistory' placeholder='Search in table' >")
        strHTML.Append("</div>")
        strHTML.Append("</li>")
        strHTML.Append("</ul>")

        strHTML.Append("<ul class='right'>")
        If (strFlag = "") Then

            If m_objAccess.Add = True Then
                strHTML.Append("<li class='clearall'>")
                strHTML.Append("<button type='button' class='btn btn-default' onclick='AddEntity()' title='Add Entity'>Add<i class='fa fa-plus' aria-hidden='true'></i></button>")
                strHTML.Append("</li>")
            End If
            If m_objAccess.Delete = True Then
                strHTML.Append("<li class='clearall'>")
                strHTML.Append(" <button type='button' class='btn btn-default' title='Delete Entity' onclick='DeleteEntity()' >Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
                strHTML.Append("</li>")
            End If
        Else

            strHTML.Append("<li class='clearall'>")
            strHTML.Append("<button type='button' class='btn btn-default' onclick='AddEntity()' title='Add Entity'>Add<i class='fa fa-plus' aria-hidden='true'></i></button>")
            strHTML.Append("</li>")


            strHTML.Append("<li class='clearall'>")
            strHTML.Append(" <button type='button' class='btn btn-default' title='Delete Entity' onclick='DeleteEntity()'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
            strHTML.Append("</li>")

        End If
        strHTML.Append("</ul>")

        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Protected Function DrawGrid() As String
        '=====================================================================
        ' Procedure Name        : DrawGrid()
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
        intNoOfDataColumn = 5
        strDivID = "divEntityGrid"
        strSQLQuery = "usp_NG2_Sel_tbl_CDB_Update_Schedule "

        arrstrActualList = {"ScheduleID", "EntityName", "SQLToUpdate", "LastUpdate", "NextUpdate", "Edit", "Delete"}
        arrstrUserFriendlyList = {"Schedule ID", "Schedule Name", "Update Schedule", "Last Update", "Next Update", "Edit", "Delete"}

        arrstrLinkArray = {"", "", "", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", "", "", ""}
        arrWidthArray = {"align=left", "align=center", "align=center", "align=left", "align=center", "align=center", "align=center"}
        objGrid = m_objEntityGrid
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
        strRowCount = ""
        Return strGridHTML.ToString
    End Function
    Private Sub m_objEmpGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objEntityGrid.DataRowTD_BeforePrint

        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center'   title='Edit Entity'><i class='fa fa-pencil-square-o' data-placement='bottom' data-toggle='tooltip' style='font-size:16px!important;cursor:pointer;' onclick=""Entity_OnClick(" & Args.DataReader("ScheduleID") & ")""   id='Editdata_" & Args.DataReader("ScheduleID") & "'></i></td>"

          

        End If

        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True

            Args.StringToBeInserted = "<td align='center' Title = 'Delete Entity'><input type=checkbox id=chkEntityDelete name=chkEntityDelete  value=" & Args.DataReader("ScheduleID") & " >" + "</TD>"

        End If


    End Sub
    Private Sub m_objEmpGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objEntityGrid.ColumnHeaderTD_BeforePrint

        Select Case UCase(Trim(Args.DataField & ""))
            Case "SCHEDULEID"
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
    <System.Web.Services.WebMethod()>
    Public Shared Function PlotEntityDetails(ByVal EntityID As String)
        '=====================================================================
        ' Procedure  Name		:	PlotEntityDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Plot Entity Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================

        Dim objEntityUpdate As New EntityUpdateSchedule()
        Dim strHTML As New StringBuilder("")

        Try
            strHTML.Append(objEntityUpdate.EntityDetails(EntityID))
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveEntity(ByVal EntitytyID As String, ByVal Entity As String, ByVal SQLToUpdate As String, ByVal UpdateSchedule As String, ByVal StartTime As String, ByVal UpdateDate As String)
        '=====================================================================
        ' Procedure  Name		:	SaveEntity
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	save Entity Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================
        Dim strSQL As String
        Dim strFlag As String = ""
        Try


            strSQL = "usp_NG2_Ins_tbl_CDB_Update_Schedule "

            If EntitytyID = "" Then

                strSQL += "NULL,"
            Else
                strSQL += EntitytyID & ","
            End If

            If Entity = "" Then

                strSQL += "NULL,"
            Else
                strSQL += "'" & Entity & "',"
            End If

            If SQLToUpdate = "" Then
                strSQL += "NULL,"

            Else
                strSQL += "'" & SQLToUpdate & "',"
            End If

            If UpdateSchedule = "" Then
                strSQL += "NULL,"

            Else
                strSQL += "'" & UpdateSchedule & "',"
            End If

            If StartTime = "" Then
                strSQL += "NULL,"
            Else

                strSQL += "'" & StartTime & "',"
            End If

            If UpdateDate = "" Then
                strSQL += "NULL"
            Else
                strSQL += "'" & UpdateDate & "'"
            End If

            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            strFlag = "1"
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
            Dim objEntityUpdate As New EntityUpdateSchedule()

            'strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))

            strGridHTML.Append(objEntityUpdate.WritePage("1"))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function CheckIsDuplicate(ByVal EntityName As String) As String
        '=====================================================================
        ' Procedure Name        : CheckIsDuplicate
        ' Description           : To is acitivity name alreadt exists
        ' Created Date           : 08-DEC-2017
        'Purpose :  To save activity
        '=====================================================================
        Dim strSQl As String = "usp_NG2_IsDuplicate_Entity '" & EntityName & "'"
        Dim strFlag = ""
        Try
            strFlag = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQl, True), "")
            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteEntity(ByVal EntityID As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteEntity
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



            strSQL = "usp_NG2_del_tbl_CDB_Update_Schedule  '" & EntityID & "'"

            CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True))

            strResult = "1"
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
End Class