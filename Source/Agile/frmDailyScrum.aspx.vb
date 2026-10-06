Imports System.IO

Public Class frmDailyScrum
    Inherits WebPages.Template.WhizTemplate
    Private WithEvents objGrid As New WebPages.Template.GenericGrid
    Private WithEvents objHistoryGrid As New WebPages.Template.GenericGrid

    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Private Shared dtDSCurrentDate As String
    Protected Shared m_objAccess As WebPage.Templates.AccessRights
    Protected Shared m_objAccessImpediment As WebPage.Templates.AccessRights

    Protected m_objIsProjectResource As String = ""
    'Protected Shared m_lngReportID As Integer = 20214    'Previous report id
    Protected Shared m_lngReportID As Integer = 20243     'Letest report id
    Protected Shared m_strFileName As String
    Private Shared WithEvents oRpt As AdHocReports.Report.AdHocReport

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
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
        ' Author                :Yogesh Jalamkar
        ' Created               :	22-March-2018
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 22235, Session("intPostID"), CType(Session("intUserID"), Integer), Session("LoginType"))
        m_objAccess.GetAccess(objGlobal)
        Dim objGlobalImpediment As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, 22236, Session("intPostID"), CType(Session("intUserID"), Integer), Session("LoginType"))
        m_objAccessImpediment = New WebPage.Templates.AccessRights
        m_objAccessImpediment.GetAccess(objGlobalImpediment)

        m_objIsProjectResource = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("EXEC usp_NG2_Chk_ResourceAssignedOnProject " & HttpContext.Current.Session("intProjectID") & "," & HttpContext.Current.Session("intUserID"), True), "0")
    End Sub

    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        :	WritePage
        ' Purpose               :	Write The page
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Yogesh Jalamkar
        ' Created               :	16-MAR-2018
        ' Revisions             :
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        Dim strSQL As String = "usp_NG2_GetWeekDates "
        Dim drWeekDates As IDataReader
        Dim strColor As String = ""
        drWeekDates = CommonFunctions.Data.GetDataReader(strSQL, True)

        strHTML.Append(PlotFilterSection())
        strHTML.Append("<div class='row' id='divrow' style='width:100%'>")
        strHTML.Append("<div class='col-md-2' style=' margin-left: -15px;' id='divweekdates'>")
        strHTML.Append("<div>")
        strHTML.Append("<table id='tblweekdates' class='table' style='width: auto;'>")
        strHTML.Append("<thead>")
        strHTML.Append(" <tr>")
        strHTML.Append("<th style=''>")
        strHTML.Append("<i class='fa fa-angle-up' style='font-size: 25px; color: grey;text-align: center;' Title = 'Previous Week' data-toggle='tooltip' id='Prev'></i>")
        strHTML.Append("</th>")
        strHTML.Append(" </tr>")
        strHTML.Append("</thead>")
        strHTML.Append("<tbody id='weekdates' style='overflow-y: auto; display: inline-block;'>")

        'strHTML.Append("<input type='hidden' id='hdnDSCurrentDate' value='' & CurrentDate & ''>')

        While drWeekDates.Read()
            strHTML.Append(" <tr>")
            If (CommonFunctions.Data.CheckIsDBNull(drWeekDates("IsNonWorkingDay"), "") = "1") Then
                strColor = "red"
            Else
                strColor = "#337ab7"
            End If
            If (CommonFunctions.Data.CheckIsDBNull(drWeekDates("IsCurrentDay"), "") = "1") Then
                dtDSCurrentDate = CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "")
                strHTML.Append("<td class='scrum_date selecteddate' style='border-top-color: transparent;' onclick=WeekDate_onclick('" & CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "") & "',this)><a href='#' style='color:" & strColor & "' onclick=WeekDate_onclick('" & CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "") & "',this)>" & CommonFunctions.Dates.CGetDate(CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "")) & "</a></td>")
            Else
                strHTML.Append("<td class='scrum_date'style='border-top-color: transparent;' onclick=WeekDate_onclick('" & CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "") & "',this)><a href='#' style='color:" & strColor & "' onclick=WeekDate_onclick('" & CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "") & "',this)>" & CommonFunctions.Dates.CGetDate(CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "")) & "</a></td>")

            End If

            strHTML.Append(" </tr>")
        End While
        strHTML.Append("</tbody>")
        strHTML.Append("<tfoot>")
        strHTML.Append(" <tr>")

        strHTML.Append("<th>")
        strHTML.Append("<i class='fa fa-angle-down' style='font-size: 25px; color: grey;' id='Next' Title = 'Next Week' data-placement='bottom' data-toggle='tooltip'></i>")
        strHTML.Append("</th>")
        strHTML.Append(" </tr>")
        strHTML.Append("</tfoot>")
        strHTML.Append("</table>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='col-md-10' style='margin-top: 25px;'>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-sm-12'>")
        strHTML.Append("<div id='DivList'>")
        strHTML.Append(PlotGrid())
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        CommonFunctions.General.WriteHTML(strHTML.ToString)

    End Sub
    Protected Function PlotGrid(Optional strFromDate As String = "", Optional strWhereClause As String = "") As String
        '=====================================================================
        ' Procedure Name        :	PlotGrid
        ' Purpose               :	To plot grid
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Yogesh Jalamkar
        ' Created               :	16-MAR-2018
        ' Revisions             :
        '=====================================================================

        Dim strGridHTML As New StringBuilder("")
        Dim strSQLQuery As String = ""
        Dim intNoOfDataColumn As Int16
        Dim strDivID As String = ""
        Dim drScrumGrid As IDataReader

        Dim arrstrActualList() As String
        Dim arrstrUserFriendlyList() As String
        Dim arrWidthArray() As String
        intNoOfDataColumn = 12
        strDivID = "DivDailyScurmList"
        If m_objAccess.View = True Then

            strSQLQuery = "usp_NG2_sel_tbl_NG2_DailyScrumMeetingDetails " & HttpContext.Current.Session("IntProjectID") & ""
            If strFromDate <> "" Then
                strSQLQuery += ",'" + strFromDate + "'"

            ElseIf strWhereClause <> "" Then
                strSQLQuery += ",NULL,'" + strWhereClause + "'"

            End If

            drScrumGrid = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
            'Added By Dipali V On 24th March 2023 For Datatable Issue
            Dim dtListCount As New DataTable
            dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
            strGridHTML.Append("<input type=hidden id=FilterDailyScurmList value='" & dtListCount.Rows.Count & "'>")
            'End of Added By Dipali V On 24th March 2023 For Datatable Issue

            If (drScrumGrid.Read()) Then


                arrstrActualList = {"MeetingNo", "SprintNo", "PostedDate", "Description", "TargetDate", "ActualCompletionDate", "PostedByImage", "AssignToImage", "IsConvertedToImpediment", "Edit", "Status", "AssignToName"}
                arrstrUserFriendlyList = {"", "", "", "", "", "", "", "", "", "", ""}

                arrWidthArray = {"align=Center", "align=Center", "align=Center", "align=left", "align=Center", "align=Center", "align=Center", "align=Center", "align=Center", "class = clsShow"}

                With objGrid
                    .ActualColumnArray = arrstrActualList
                    .UserFriendlyColumnArray = arrstrUserFriendlyList
                    '.CheckBoxIDArray = arrCheckBoxArray
                    .NoOfDataColumns = intNoOfDataColumn
                    .TDStyleArray = arrWidthArray
                    .DIVStyle = "overflow:auto"
                    .ColNameToolTipOnEachRow = True
                    .EmptyValueReplacement = (" ")
                    .DIVID = strDivID
                    .SQL = strSQLQuery
                    .ColNameToolTipOnEachRow = True
                    .UseSQL = True
                    .returnHTML = True
                    .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                    strGridHTML.Append(.DrawGrid())
                End With
                objGrid = Nothing
            Else
                strGridHTML.Append("<div id='DivDailyScurmList' style='width:100%'><table style='width :100%'><thead><th class='clsTRColumnHeader'><th></thead><tr><td align=center style='border-bottom: 1px solid rgb(255, 255, 255) !important;border-top: 1px solid rgb(255, 255, 255)!important;'>No item is created for this day.</td></tr></table></div>")
            End If
        End If
        Return strGridHTML.ToString()


    End Function
    Private Sub objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles objGrid.ColumnHeaderTR_BeforePrint

        'Cancel = True


    End Sub
    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "MEETINGNO" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center' ><p Title = '&nbsp;&nbsp;&nbsp;&nbsp;Serial Number.' data-toggle='tooltip' data-placement='bottom' >" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MeetingNo"), "") & "</p></TD>"
        End If
        If Args.DataField.ToUpper = "SPRINTNO" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center' ><p Title = 'Sprint Number.' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SprintNo"), "") & "</p></TD>"
        End If
        If Args.DataField.ToUpper = "POSTEDDATE" Then
            Cancel = True
            If CommonFunctions.General.CheckIsNothing(Args.DataReader("PostedDate"), "") <> "" Then
                Args.StringToBeInserted = "<td align='center' nowrap ><p Title = 'Posted Date' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Dates.CGetDate(Args.DataReader("PostedDate")) & "</p></TD>"
            Else
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Posted Date' data-toggle='tooltip' data-placement='bottom'></p></TD>"
            End If

        End If
        If Args.DataField.ToUpper = "DESCRIPTION" Then
            Cancel = True
            Dim strDescription As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("Description"), "")

            'Dim strLessDescription As String = ""
            'Dim strRemainingDescription As String = ""

            'If strDescription.Length > 200 Then
            '    strLessDescription = strDescription.Substring(0, 100)
            '    strRemainingDescription = strDescription.Substring(101, strDescription.Length - 101)
            'End If

            If (CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Description"), "").ToString.ToUpper.Length > 100) Then
                'Args.StringToBeInserted = "<td align='left' ><p Title = 'Action Item/Description' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Description"), "").Substring(0, 100) & "..</p></TD>"
                If strDescription.Contains("'") Then
                    Args.StringToBeInserted = "<td align='left' ><p class='tt_large' Title = """ & strDescription & """ data-toggle='tooltip' data-placement='left' style='word-break: break-all;'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Description"), "").Substring(0, 100) & "..</p></TD>"
                Else
                    Args.StringToBeInserted = "<td align='left' ><p class='tt_large' Title = '" & strDescription & "' data-toggle='tooltip' data-placement='left' style='word-break: break-all;'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Description"), "").Substring(0, 100) & "..</p></TD>"
                End If

            Else
                'Args.StringToBeInserted = "<td align='left' ><p Title = 'Action Item/Description' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Description"), "") & "</p></TD>"
                If strDescription.Contains("'") Then
                    Args.StringToBeInserted = "<td align='left' ><p Title = """ & strDescription & """ data-toggle='tooltip' data-placement='left'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Description"), "") & "</p></TD>"
                Else
                    Args.StringToBeInserted = "<td align='left' ><p Title = '" & strDescription & "' data-toggle='tooltip' data-placement='left'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Description"), "") & "</p></TD>"
                End If
            End If


        End If
        If Args.DataField.ToUpper = "TARGETDATE" Then
            Cancel = True
            If CommonFunctions.General.CheckIsNothing(Args.DataReader("TargetDate"), "") <> "" Then
                Args.StringToBeInserted = "<td align='center'nowrap ><p Title = 'Target Date' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Dates.CGetDate(Args.DataReader("TargetDate")) & "</p></TD>"
            Else
                Args.StringToBeInserted = "<td align='center' ><p Title = 'Target Date' data-toggle='tooltip' data-placement='bottom'>-</p></TD>"
            End If

        End If
        If Args.DataField.ToUpper = "ACTUALCOMPLETIONDATE" Then
            Cancel = True
            If CommonFunctions.General.CheckIsNothing(Args.DataReader("ActualCompletionDate"), "") <> "" Then
                Args.StringToBeInserted = "<td align='center' nowrap><p Title = 'Actual Completion Date' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Dates.CGetDate(Args.DataReader("ActualCompletionDate")) & "</p></TD>"
            Else
                Args.StringToBeInserted = "<td align='center'><p Title = 'Actual Completion Date' data-toggle='tooltip' data-placement='bottom'>-</p></TD>"
            End If
        End If
        If Args.DataField.ToUpper = "POSTEDBYIMAGE" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center' >"
            Args.StringToBeInserted += "<span class='chat-img float-start'style='display:none'>"
            Args.StringToBeInserted += Args.DataReader("PostedByName")
            Args.StringToBeInserted += "</span>"
            Args.StringToBeInserted += "<span class='chat-img float-start'>"
            Args.StringToBeInserted += "<img Title = 'Posted By : " + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PostedByName"), "") + "' data-toggle='tooltip' data-placement='bottom' alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px;width:30px;' src='../../Images/Photo/" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PostedByImage"), "") & "' />"

            Args.StringToBeInserted += "</span> </TD>"
        End If
        If Args.DataField.ToUpper = "ASSIGNTOIMAGE" Then
            Cancel = True
            If CommonFunction.General.CheckIsNothing(Args.DataReader("AssignToName"), "") <> "" Then
                Args.StringToBeInserted = "<td align='center' >"
                Args.StringToBeInserted += "<span class='chat-img float-start'style='display:none'>"
                Args.StringToBeInserted += Args.DataReader("AssignToName")
                Args.StringToBeInserted += "</span>"
                Args.StringToBeInserted += "<span class='chat-img float-start'>"
                Args.StringToBeInserted += "<img Title = 'Assigned To : " + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("AssignToName"), "") + "' data-toggle='tooltip' data-placement='bottom' alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px;width:30px;' src='../../Images/Photo/" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("AssignToImage"), "") & "' />"
                Args.StringToBeInserted += "</span> </TD>"
            Else
                Args.StringToBeInserted = "<td align='center' >-"
                Args.StringToBeInserted += "</TD>"
            End If

        End If
        If Args.DataField.ToUpper = "AssignToName" Then
            Cancel = True
        End If
        If Args.DataField.ToUpper = "STATUS" Then
            Cancel = True

            If CommonFunction.General.CheckIsNothing(Args.DataReader("Status"), "") <> "" Then
                Args.StringToBeInserted = "<td align='center'> <span style='width: 80px; font-size: 12px; height: 25px; padding: 6px 10px; color:white; background-color: " & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("StatusColor"), "") & ";border-radius: 0px; margin-top: 9px;' data-toggle='tooltip' data-placement='bottom' title='Status'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Status"), "") & "</span></td>"
            Else
                Args.StringToBeInserted = "<td align='center'> N/A </td>"
            End If


        End If
        If Args.DataField.ToUpper = "ISCONVERTEDTOIMPEDIMENT" Then
            Cancel = True
            If (CommonFunction.Data.CheckIsDBNull(Args.DataReader("IsConvertedToImpediment"), False) = True) Then
                Args.StringToBeInserted = "<td><i Title = 'Converted To Impediment' data-toggle='tooltip' data-placement='bottom' class='fa fa-share-square-o' aria-hidden='true' style='font-size: 16px; color: #de1818; margin-top: 14px;'></i></td>"
            Else
                Args.StringToBeInserted = "<td></td>"
            End If

        End If
        If Args.DataField.ToUpper = "EDIT" Then

            Cancel = True

            Args.StringToBeInserted = "<td><div class='btn-group dropdown' style='float: right; padding: 8px;'>"
            'added by ashwini on 21-3-2023 for data-bs-toggle
            Args.StringToBeInserted += "<i class='fa fa-ellipsis-h mydetaildropdown' data-placement='left' title='Detail' id='idEdit' data-bs-toggle='dropdown'></i>"
            'End Of added by ashwini On 21-3-2023 for data-bs-toggle

            Args.StringToBeInserted += "<ul class='dropdown-menu' role='menu' style='width: 160px;top: 55%;'>"
            'Args.StringToBeInserted += "<li onclick=ShowModal('divAddDS',this,'" & CommonFunction.Data.CheckIsDBNull(Args.DataReader("MeetingID"), "") & "','" & CommonFunction.Data.CheckIsDBNull(Args.DataReader("Status"), "") & "')>View Details</li>"
            Args.StringToBeInserted += "<li onclick=ShowModal_DS('divAddDS',this,'" & CommonFunction.Data.CheckIsDBNull(Args.DataReader("MeetingID"), "") & "','" & CommonFunction.Data.CheckIsDBNull(Args.DataReader("Status"), "") & "')>View Details</li>"

            Dim strCurrentDate As String = CommonFunctions.Dates.CGetDate(DateTime.Now)
            Dim strTargetDate As String = CommonFunctions.General.CheckIsNothing(Args.DataReader("TargetDate"), "")

            If (CommonFunction.Data.CheckIsDBNull(Args.DataReader("IsConvertedToImpediment"), False) = False) Then
                If CommonFunction.General.CheckIsNothing(Args.DataReader("Status"), "") <> "Delayed" Then
                    If strTargetDate <> "" Then

                        If CommonFunctions.Dates.CGetDate(strTargetDate) > strCurrentDate Then
                            Args.StringToBeInserted += "<li onclick=ConvertToImpediment(this,'" & CommonFunction.Data.CheckIsDBNull(Args.DataReader("MeetingID"), "") & "','" & CommonFunction.General.CheckIsNothing(Args.DataReader("Status"), "") & "')>Convert to Impediment</li>"
                        End If

                    End If
                End If
            End If


            Args.StringToBeInserted += "<li onclick=ShowHistory('" & CommonFunction.Data.CheckIsDBNull(Args.DataReader("MeetingID"), "") & "')>Show History</li>"
            Args.StringToBeInserted += "</ul>"
            Args.StringToBeInserted += "</div>"
            Args.StringToBeInserted += "</td>"
        End If

    End Sub
    Protected Function PlotFilterSection() As String
        '=====================================================================
        ' Procedure Name        :	PlotStatusFilter
        ' Purpose               :	PlotStatusFilter
        ' Description           :	Plot a status for filter
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	YOgesh Jalamkar
        ' Created               :	16th-March-2018
        ' Revisions             :
        '=====================================================================

        Dim strHTML As New StringBuilder()
        Dim strSQL As String = ""
        Dim drStatus As IDataReader
        Dim strSprintName As String = ""
        drStatus = CommonFunctions.Data.GetDataReader("usp_NG2_GetStatusForDSM 'MeetingFilter'", True)
        Dim SQLSprints As String
        SQLSprints = "usp_NG2_Sel_Sprints_ForDailyScrum NULL," & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",1,0"
        strHTML.Append("<div class='col-sm-12 HeaderFreeze fixed-top' style='width:100%'>")
        strHTML.Append("<div class='col-md-4 col-sm-4 clsDivHeader' style='color: #888888b8; font-weight: 500; font-size: 15px;margin-left: 34px; margin-top: 6px;'>Daily Scrum/StandUp Meeting</div>")
        strHTML.Append("<div class='col-md-7 col-sm-7' style='float:right;margin-right:-18px;margin-top:-26px'>")
        strHTML.Append("<div style='float:right'>")
        'strHTML.Append(" <div class='btn-group dropdown' id='divHeaderLeftSection' style=''>")


        'If m_objAccess.View = True Then
        '    strHTML.Append("<div class='input-group input-group-sm' style='width: 300px; right: 20px !important; '>")
        '    strHTML.Append("<div class='input-group-btn'>")
        '    strHTML.Append("<button type='button' class='btn btn-default' onclick='PerformSearchForPTI()'><i class='fa fa-search'></i></button>")
        '    strHTML.Append("</div>")
        '    strHTML.Append("<input type='search' name='table_search' id='txtSearchDailyScrum' class='txtBox form-control float-end' value='' onkeyup='PerformSearchForPTI()' placeholder='Search'>")
        '    strHTML.Append("</div>")
        'End If

        'strHTML.Append("</div>")

        strHTML.Append("<div class='btn-group' id='divHeaderLeftSection' style=''>")
        If m_objAccess.View = True Then
            strHTML.Append("<div class='input-group input-Group -sm ' style='width: 240px;'>")
            strHTML.Append("<div class='input-group-btn'>")
            strHTML.Append("<input type='search' name='table_search' id='txtSearchDailyScrum' class='txtBox form-control float-end' value='' onkeyup='PerformSearchForPTI()' placeholder='Search' style='border-top: none!important; border-left: none!important;border-right: none!important;width: 200px;height: 33px;margin-bottom:0!important;/* width: 72%!important; */'>")
            strHTML.Append(" </div>")
            strHTML.Append("<i class='fa fa-search' style='border-bottom-color: none;margin-left: 10px;/* z-index: 99; */margin-top: 10px;'></i>")
            strHTML.Append("</div>")
        End If
        strHTML.Append("</div>")


        If m_objAccess.Add = True And m_objIsProjectResource = "1" Then
            strHTML.Append("<div class='btn-group dropdown' style=''>")
            strHTML.Append("<button type='button' class='btn btn-info' style='border-radius: 1px;'>Create</button>")
            'added by ashwini on 21-3-2023 for data-bs-toggle
            strHTML.Append("<button type='button' class='btn btn-info  dropdown-toggle-split ' data-bs-toggle='dropdown' aria-haspopup='true' aria-expanded='false'><i class='fa fa-sort-down'></i></button>")
            'End Of added by ashwini On 21-3-2023 for data-bs-toggle
            strHTML.Append("<ul class='dropdown-menu'>")
            'strHTML.Append("<li class='dropdown-item' onclick=ShowModal('divAddDS',this,'')>Create Daily Scrum</li>")
            strHTML.Append("<li class='dropdown-item' onclick=ShowModal_DS('divAddDS',this,'')>Create Daily Scrum</li>")
            If m_objAccessImpediment.Add = True Then
                'strHTML.Append("<li class='dropdown-item' onclick=ShowModal('divAddImpediment',this,'')>Create Impediment</li>")
                strHTML.Append("<li class='dropdown-item' onclick=ShowModal_DS('divAddImpediment',this,'')>Create Impediment</li>")
            End If
            strHTML.Append("</ul>")
            strHTML.Append("</div>")
        End If
        If m_objAccess.View = True Then
            strHTML.Append("<div class='btn-group dropdown' id='divfilterExport'  style='padding-left: 10px;'>")
            'added by ashwini on 21-3-2023 for data-bs-toggle
            strHTML.Append("<button data-bs-toggle='dropdown' style='border-radius: 1px;' class='btn btn-info' id='filterExport'>Export <i class='fa fa-download'></i> | <i class='fa fa-sort-down'></i> </button>") 'Added by Swapna
            'End Of added by ashwini On 21-3-2023 for data-bs-toggle
            strHTML.Append("<ul  id='ExcelFilter' class='dropdown-menu'>")

            strHTML.Append("<li class='dropdown-item' onclick=Excel_OnClick('Excel')>Excel</li>")
            strHTML.Append("<li class='dropdown-item' onclick=Excel_OnClick('PDF')>PDF</li>")
            strHTML.Append("</ul>")
            strHTML.Append("</div>")



            strHTML.Append("<div class='btn-group dropdown' id='divfilterDropdown'  style='padding: 8px;'>")
            'added by ashwini on 21-3-2023 for data-bs-toggle
            strHTML.Append("<i class='fa fa-filter my-dropdown' data-bs-toggle='dropdown'  data-placement='bottom' title='Filter' id='filterDropdown' style='cursor: pointer;'></i>")
            'End Of added by ashwini On 21-3-2023 for data-bs-toggle
            strHTML.Append("<ul id='UlFilter' class='dropdown-menu'  style='width: 160px'>")

            strHTML.Append("<li>")
            strHTML.Append("<i class='fa fa-star'>&nbsp;</i><span  onclick=ShowFilter(this,'CurrentSprint')>By Current Sprint</span>")
            strHTML.Append("</li>")

            strHTML.Append("<li>")
            strHTML.Append("<i class='fa fa-plus-circle'  onclick=ShowStatus(this,'divStatus')></i><span> By Status</span>")
            strHTML.Append("<div id='divStatus' class='clsFilterDiv' style='display:none'>")
            strHTML.Append("<ul class=''>")

            While drStatus.Read()
                strHTML.Append("<li class='' onclick=ShowFilter('" & CommonFunctions.Data.CheckIsDBNull(drStatus("Status"), "") & "','Status')>- " & CommonFunctions.Data.CheckIsDBNull(drStatus("Status"), "") & "</li>")
            End While
            strHTML.Append("</ul>")
            strHTML.Append("</div>")
            strHTML.Append("</li>")

            strHTML.Append("<li>")
            strHTML.Append("<i class='fa fa-plus-circle'  onclick=ShowStatus(this,'divSprints')></i><span> By Sprints</span>")
            strHTML.Append("<div id='divSprints' class='clsFilterDiv' style='display:none'>")
            strHTML.Append("<div class='form-group row' style='margin-top:10px'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("DSFilterSprint", SQLSprints, , , "class='form-control' style='width:70%;margin-left: 45px;' onchange=ShowFilter('','Sprints')", True, True))
            strHTML.Append("</div>")
            'strHTML.Append("<ul class=''>")
            'While drSprints.Read()
            '    strSprintName = CommonFunctions.Data.CheckIsDBNull(drSprints("IterationName"), "")
            '    If (strSprintName.Length > 20) Then
            '        strSprintName = strSprintName.Substring(0, 20)
            '    End If

            '    strHTML.Append("<li class='' data-toggle='tooltip' title='" & CommonFunctions.Data.CheckIsDBNull(drSprints("IterationName"), "") & "' onclick=ShowFilter('" & CommonFunctions.Data.CheckIsDBNull(drSprints("IterationID"), "") & "','Sprints')>- " & strSprintName & "</li>")
            'End While
            'strHTML.Append("</ul>")
            strHTML.Append("</div>")
            strHTML.Append("</li>")

            strHTML.Append("<li>")
            strHTML.Append("<i class='fa fa-plus-circle'  onclick=ShowStatus(this,'divImpediment')></i><span> By Impediment</span>")
            strHTML.Append("<div id='divImpediment' class='clsFilterDiv' style='display:none'>")
            strHTML.Append("<ul class=''>")
            strHTML.Append(" <li class='' onclick=ShowFilter('1','Impediment')>- Converted</li>")
            strHTML.Append("<li class='' onclick=ShowFilter('0','Impediment')>- Not Converted</li>")
            strHTML.Append("</ul>")
            strHTML.Append("</div>")
            strHTML.Append("</li>")

            strHTML.Append("</ul>")
            strHTML.Append("</div>")
            strHTML.Append("<div class='btn-group' id='DivfilterClear'  style='padding: 8px;'>")
            strHTML.Append("<i class='fa fa-filter' data-toggle='tooltip'  data-placement='bottom' title='Clear Filter' id='filterClear' onclick=ClearFilter(this)><i class='fa fa-remove'></i></i>")

            strHTML.Append("</div>")


        End If





        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString()

    End Function
    'Added by Usha Pandit on 21 April 2018 for Export Functionality
    <System.Web.Services.WebMethod()>
    Public Shared Function ExportToExcel(ByVal ReportFormat As String, ByVal WhereFlag As String, ByVal WhereValue As String, ByVal WhereDate As String)
        '====================================================================
        ' Function  Name        : ExportToExcel
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To export Scrum Log Details to excel
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Usha Pandit
        ' Created               : 21-Apr-2018
        ' Revisions             :
        '=====================================================================
        Try
            Dim strSQL As String
            Dim strFilePath As String
            Dim strFormat As String
            Dim strCaptions As String


            Dim strWhereClause As String = ""
            Dim strFromDate As String = ""
            strSQL = "usp_NG2_sel_tbl_NG2_DailyScrumMeetingDetails_Report " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")

            strFromDate = WhereDate

            If WhereFlag.ToUpper() = "STATUS" Then
                strWhereClause = "Status = ''" & WhereValue & "''"


            ElseIf WhereFlag.ToUpper() = "DSM" Then

                strWhereClause = "ScrumMeetingID " & WhereValue & ""
                'Added by Usha Pandit on 30 May 2018 for exporting data as per converted / not converted impediment
            ElseIf WhereFlag.ToUpper() = "IMPEDIMENT" Then

                strWhereClause = "IsConvertedToImpediment = " & WhereValue & ""

            ElseIf WhereFlag.ToUpper() = "CURRENTSPRINT" Then

                strWhereClause = "CurrentSprint = " & WhereValue & ""

                'End of Added by Usha Pandit on 30 May 2018 for exporting data as per converted / not converted impediment
            ElseIf WhereFlag.ToUpper() = "SPRINTS" Then
                strWhereClause = "tbl_NG2_DailyScrumMeetingDetails.IterationID = """ & WhereValue & """"
            End If

            If strFromDate <> "" Then
                strSQL += ",'" + strFromDate + "'"
            End If
            If strWhereClause <> "" Then
                If strFromDate = "" Then
                    strSQL += ",NULL,'" + strWhereClause + "'"
                Else
                    strSQL += ",'" + strWhereClause + "'"
                End If

            End If

            ' The reports are created in the "Reports" folder
            strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../Reports/"))
            ' get a unique file name
            m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName.Trim
            ' add extn to file name based on format requested
            Select Case ReportFormat
                Case "PDF" : m_strFileName += ".pdf"
                Case "HTML" : m_strFileName += ".htm"
                Case "RTF" : m_strFileName += ".rtf"
                Case "EXCEL" : m_strFileName += ".xls"
                Case "CSV" : m_strFileName += ".csv"
                Case "TEXT" : m_strFileName += ".txt"
                Case "XML" : m_strFileName += ".xml"
                Case Else : m_strFileName += ".pdf"
            End Select

            Dim frmObjImpedimentLog As New frmImpedimentLog
            ' create object of Adhoc reports
            oRpt = New AdHocReports.Report.AdHocReport(m_lngReportID, strSQL, CommonFunctions.Application.ConnectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../Attachments/Log/")))
            With oRpt
                .UseMSSQL = frmObjImpedimentLog.UseSQL
                .DefaultLCID = CType(frmObjImpedimentLog.DefaultUILCID, Integer)
                .LCID = frmObjImpedimentLog.CurrentThreadUICultureID
                If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                    .UseHashTables = True
                Else
                    .UseHashTables = False
                End If
                '.UIParameters = strCaptions
                '.UIParametersDelimiter = "|"
                '.WatermarkImageFilePath = ""
                .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                .CompanyName = CommonFunctions.Application.CompanyName
                .GraphImageGenerationAbsolutePath = HttpContext.Current.Server.MapPath("../../Images/")

                ' generate the report in requested format

                Select Case ReportFormat
                    Case "PDF" : .GenerateReport(AdHocReports.Format.PDF)
                    Case "HTML" : .GenerateReport(AdHocReports.Format.HTML)
                    Case "RTF" : .GenerateReport(AdHocReports.Format.RTF)
                    Case "EXCEL" : .GenerateReport(AdHocReports.Format.EXCEL)
                    Case "CSV" : .GenerateReport(AdHocReports.Format.CSV)
                    Case "TEXT" : .GenerateReport(AdHocReports.Format.TEXT)
                    Case "XML" : .GenerateReport(AdHocReports.Format.XML)
                    Case Else : .GenerateReport(AdHocReports.Format.PDF)
                End Select
            End With
            oRpt = Nothing

            'With Response
            '.Redirect("../CRW/CRW_ReportOutput.aspx?filename=" + m_strFileName, True)
            'window.open ("../CRW/CRW_ReportOutput.aspx?filename=" + filename, "_report",""); 


            Return (m_strFileName)
        Catch ex As Exception
            Return "Bad Request found"
        End Try
        'End With
    End Function
    'Added by Usha Pandit on 21 April 2018 for Export Functionality
    <System.Web.Services.WebMethod()>
    Public Shared Function AddDailyScrumModal(MeetingNo As String)
        '=====================================================================
        ' Procedure Name        :	AddDailyScrumModal
        ' Purpose               :	AddDailyScrumModal
        ' Description           :	Open DS
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	YOgesh Jalamkar
        ' Created               :	16th-March-2018
        ' Revisions             :
        '=====================================================================
        Try
            Dim objfrmReleasePlanning As New frmDailyScrum
            Dim objfrmDailyScrum As New frmDailyScrum()
            Dim strHTML As New StringBuilder()
            Dim strSQL As String = ""
            strHTML.Append("<div class='' id='container_impediment'>")
            strHTML.Append("<form>")

            strSQL = "usp_NG2_GetDailyScrumDetails " & MeetingNo
            Dim strActionItems As String = ""
            Dim strTargetDate As String = ""
            Dim strSprint As String = ""
            Dim strAssignedTo As String = ""
            Dim strStatus As String = ""
            Dim strActualCompletionDate As String = ""
            Dim strRemark As String = ""
            Dim strConvertToImpediment As String = ""
            Dim strclass As String = ""
            Dim strTxtclass As String = ""
            Dim strStausclass As String = ""
            Dim drDSDetails As IDataReader
            Dim AssignedToID As String = ""
            Dim isEditMode As String = "0"

            If (MeetingNo <> "") Then


                drDSDetails = CommonFunction.Data.GetDataReader(strSQL, True)
                If drDSDetails.Read Then

                    strActionItems = CommonFunction.Data.CheckIsDBNull(drDSDetails("Description"), "")
                    strTargetDate = CommonFunction.Data.CheckIsDBNull(drDSDetails("TargetDate"), "")
                    If (strTargetDate <> "") Then
                        strTargetDate = CommonFunctions.Dates.GetDate(strTargetDate)
                    End If


                    strSprint = CommonFunction.Data.CheckIsDBNull(drDSDetails("IterationID"), "")
                    strAssignedTo = CommonFunction.Data.CheckIsDBNull(drDSDetails("AssignToName"), "")
                    strStatus = CommonFunction.Data.CheckIsDBNull(drDSDetails("Status"), "")
                    strActualCompletionDate = CommonFunction.Data.CheckIsDBNull(drDSDetails("ActualCompletionDate"), "")
                    If (strActualCompletionDate <> "") Then
                        strActualCompletionDate = CommonFunctions.Dates.GetDate(strActualCompletionDate)
                    End If
                    AssignedToID = CommonFunction.Data.CheckIsDBNull(drDSDetails("AssignTo"), "")
                    strRemark = CommonFunction.Data.CheckIsDBNull(drDSDetails("Remark"), "")
                    strConvertToImpediment = CommonFunction.Data.CheckIsDBNull(drDSDetails("IsConvertedToImpediment"), "")
                    isEditMode = "1"
                End If
            End If
            strTxtclass = "form-control"
            If (strStatus.ToUpper = "CLOSED") Then
                strclass = "disabled"
                strTxtclass = "form-control clsDisableColor"
            End If
            If (strStatus.ToUpper = "CLOSED" Or strStatus.ToUpper = "REJECTED" Or strStatus.ToUpper = "DIFFERED") Then
                strStausclass = "disabled"
            End If
            strHTML.Append("<div class='form-group row'>")
            strHTML.Append(" <label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom' > Action Item/Description* </label> ")
            strHTML.Append("<div class='col-sm-9'>")
            'If strActionItems.Length > 400 Then
            '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtActionItems", "txtActionItems", , strTxtclass, , , , , , strActionItems.Length / 2, 1000, strActionItems, , "overflow:hidden;", , , , , "data-autoresize  onkeyup='javascript:Maxlength(this,""ActionItems"",1000)'" & strclass, True, EnableHTMLEncode:=True))
            'ElseIf strActionItems.Length <= 400 And strActionItems.Length >= 50 Then
            '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtActionItems", "txtActionItems", , strTxtclass, , , , , , strActionItems.Length, 1000, strActionItems, , "overflow:hidden;", , , , , "data-autoresize  onkeyup='javascript:Maxlength(this,""ActionItems"",1000)'" & strclass, True, EnableHTMLEncode:=True))
            'Else
            '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtActionItems", "txtActionItems", , strTxtclass, , , , , , 40, 1000, strActionItems, , "overflow:hidden;", , , , , "data-autoresize  onkeyup='javascript:Maxlength(this,""ActionItems"",1000)'" & strclass, True, EnableHTMLEncode:=True))
            'End If
            If strActionItems = "" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtActionItems", "txtActionItems", , , , , , , , , 1000, strActionItems, , "overflow:hidden;", , , , , "onkeyup='ShowLength(this,""ActionItems"",1000)' onchange='ShowLength(this,""ActionItems"",1000)' " & strclass, True, EnableHTMLEncode:=True))
                strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;float: right;' id='ActionItems'>1000</p>")
            Else
                Dim len As Integer = 1000
                Dim len1 As Integer
                If strActionItems.Length <> -1 Then
                    len1 = strActionItems.Length
                    len = 1000 - len1
                End If

                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtActionItems", "txtActionItems", , , , , , , , , 1000, strActionItems, , "overflow:hidden;", , , , , "onkeyup='ShowLength(this,""ActionItems"",1000)' onchange='ShowLength(this,""ActionItems"",1000)' " & strclass, True, EnableHTMLEncode:=True))
                strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;float: right;' id='ActionItems'>" & len & "</p>")
            End If


            strHTML.Append("</div>")
            strHTML.Append("</div>")



            '''''''''''''''''''''''''''''''''''''''''
            strHTML.Append("<div class='form-group row'>")
            'strHTML.Append("<div class=''>")

            strHTML.Append(" <label  class='col-sm-3 col-form-label' > Sprint* </label> ")
            strHTML.Append("<div class='col-sm-3'>")
            If (MeetingNo <> "") Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("DSSprint", "usp_NG2_Sel_Sprints_ForDailyScrum " & MeetingNo & ", " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",null,1", , strSprint, "class='form-control clsDisableColor' style='' disabled ", , True))
            Else
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("DSSprint", "usp_NG2_Sel_Sprints_ForDailyScrum NULL," & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",null,0", , strSprint, "class='form-control clsDisableColor' style=''disabled ", , True))
            End If

            strHTML.Append("</div>")
            'strHTML.Append("</div>")

            'strHTML.Append("<div class=''>")
            strHTML.Append(" <label class='col-sm-3 col-form-label'  style='white-space: nowrap;'>Assigned To</label>")
            strHTML.Append(" <div class='col-sm-3'>")
            'strHTML.Append("<div class=''>")
            'added by ashwini on 21-3-2023 for data-bs-toggle
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtAssignedTo", "txtAssignedTo", strTxtclass, , , strAssignedTo, , "", , , , , "onkeyup=myFunction() data-bs-toggle='dropdown'" & strclass, True, , , , , , True))
            'End Of added by ashwini On 21-3-2023 for data-bs-toggle

            strHTML.Append("<ul id='emplistUL' class='dropdown-menu' role='menu'>")
            strHTML.Append(objfrmDailyScrum.AssignToResourceList())
            'strHTML.Append("<li onclick=ShowModal('divAddDS',this)>View Details</li>')
            'strHTML.Append("<li>Convert to Impediment</li>')
            strHTML.Append("</ul>")
            strHTML.Append("<input type='hidden' id='hdnAssignToId' value='" & AssignedToID & "'/>")
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            ''''''''''''''''''''''''''''''''''''''''''''''''''     
            strHTML.Append("<div class='form-group row'>")
            'strHTML.Append(" <div class=''>")
            strHTML.Append(" <label  class='col-sm-3 col-form-label'  > Target Date </label> ")
            strHTML.Append(" <div class='col-sm-3'>")
            'strHTML.Append("<div class=''>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DSTargetDate", "DSTargetDate", "form-control", , , strTargetDate, , "", , , , , " onchange=checkBlankTargetDate(this.value) onclick=""$('#DSTargetDate').datepicker({minDate: 0});$('#DSTargetDate').datepicker('show');""  autocomplete='off' onpaste='return false;'" & strclass, True, , , , , , True))
            strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='float: right;margin-top: -29px;font-size: 16px; color:#0099CC;'></i>")

            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            strHTML.Append("</div>")
            'strHTML.Append("<div class='col-md-1'>")
            'strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; color:#0099CC;margin-left: 20px;  margin-top: 17px;'></i>")
            'strHTML.Append("</div>")
            'strHTML.Append(" <div class=''>")
            strHTML.Append("<label for='inputEmail3' class='col-sm-3 col-form-label' >Actual Completion Date</label></label> ")
            strHTML.Append(" <div class='col-sm-3'>")
            'strHTML.Append("<div class=''>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DSActualStartDateDate", "DSActualStartDateDate", "form-control clsDisableColor", , , strActualCompletionDate, , "", , , , , " onclick=""$('#DSActualStartDateDate').datepicker({minDate: 0});$('#DSActualStartDateDate').datepicker('show');"" autocomplete='off' onpaste='return false;' disabled", True, , , , , , True))
            strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='float: right;margin-top: -29px;font-size: 16px; color:#0099CC;'></i>")

            strHTML.Append("</div>")
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")




            strHTML.Append("</div>")
            ''''''''''''''''''''''''''''''''''
            strHTML.Append("<div class='form-group row'>")
            'strHTML.Append(" <div class=''>")
            strHTML.Append(" <label class='col-sm-3 col-form-label'  >Status</label> ")
            strHTML.Append(" <div class='col-sm-3'>")
            'strHTML.Append("<div class=''>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("DSStatus", "usp_NG2_GetStatusForDSM 'Meeting'", , strStatus, "class='form-control' style='' " & strclass, False, True))
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")

            'If (MeetingNo <> "") Then



            'End If
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            ''''''''''''''''''''''''''''''''
            '''
            strHTML.Append("<div class='form-group row'>")
            'strHTML.Append("<div class='remarkdiv' style='margin-left:-22px'>")
            strHTML.Append("<label  class='col-sm-3 col-form-label'>Remark</label>")
            strHTML.Append("<div class='col-sm-9'>")
            'If strRemark.Length > 400 Then
            '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtRemark", "txtRemark", , "form-control", , , , , , strRemark.Length / 2, 1000, strRemark, , "overflow:hidden;", , , , , "data-autoresize" & strclass, True, EnableHTMLEncode:=True))
            'ElseIf strRemark.Length <= 400 And strRemark.Length >= 50 Then
            '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtRemark", "txtRemark", , "form-control", , , , , , strRemark.Length, 1000, strRemark, , "overflow:hidden;", , , , , "data-autoresize" & strclass, True, EnableHTMLEncode:=True))
            'Else
            '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtRemark", "txtRemark", , "form-control", , , , , , 40, 1000, strRemark, , "overflow:hidden;", , , , , "data-autoresize" & strclass, True, EnableHTMLEncode:=True))
            'End If

            If strRemark = "" Then
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtRemark", "txtRemark", , , , , , , , , 1000, strRemark, , "overflow:hidden;", , , , , "onkeyup='ShowLength(this,""DSRemark"",1000)' onchange='ShowLength(this,""DSRemark"",1000)'" & strclass, True, EnableHTMLEncode:=True))
                strHTML.Append("<p style='margin-right: -30px;margin-top: -30px;font-size: 13px;font-weight: 500;color: grey;float: right;' id='DSRemark'>1000</p>")

            Else
                Dim len As Integer = 1000
                Dim len1 As Integer
                If strRemark.Length <> -1 Then
                    len1 = strRemark.Length
                    len = 1000 - len1
                End If

                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtRemark", "txtRemark", , , , , , , , , 1000, strRemark, , "overflow:hidden;", , , , , "onkeyup='ShowLength(this,""DSRemark"",1000)' onchange='ShowLength(this,""DSRemark"",1000)'" & strclass, True, EnableHTMLEncode:=True))
                strHTML.Append("<p style='margin-right: -30px;margin-top: -30px;font-size: 13px;font-weight: 500;color: grey;float: right;' id='DSRemark'>" & len & "</p>")
            End If

            'strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            ''''''''''''''''''''''''''''''''''''''''    
            strHTML.Append("<div class='form-group row'>")
            strHTML.Append("<label  class='col-sm-3 col-form-label' style='margin-left: 5.333333%;'>Convert To Imepediment</label>")
            strHTML.Append("<div class='col-sm-4'>")
            If strConvertToImpediment = "True" Then
                strHTML.Append("<input type='checkbox' id='IsConvertedToImpediment' style='margin-left:100px;margin-top:15px'checked disabled value=1 " & strStausclass & ">")
            Else
                If MeetingNo <> "" Then
                    strHTML.Append("<input type='checkbox' id='IsConvertedToImpediment' onchange = 'checkDelayStatus()'  style='margin-left:45px;margin-top:15px' value=0 " & strStausclass & ">")
                Else
                    strHTML.Append("<input type='checkbox' id='IsConvertedToImpediment' style='margin-left:45px;margin-top:15px' value=0 " & strStausclass & ">")
                End If
            End If
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            ''''''''''''''''''''''''''''''''''''''''''''''''''''
            strHTML.Append("</form>")
            strHTML.Append("</div>")
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    Protected Function AssignToResourceList() As String
        '=====================================================================
        ' Procedure Name        : AssignToResourceList
        ' Description           : For Plotting Assign To employee list
        ' Created Date           : 24th-OCT-2017
        '=====================================================================

        Dim dtTable As DataTable

        Dim strListHTML As New StringBuilder("")

        Dim intEmployeeID As Integer = 0

        dtTable = CommonFunction.Data.GetDataTable("usp_NG2_Sel_AssinedTo_ForDailyScrum " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), True)

        'strListHTML.Append('<a class='dropdown-item' href='#' onclick=''AssignToListClick('')'' > &nbsp; </a><br>' & vbCrLf)

        For Each drRow As DataRow In dtTable.Rows
            intEmployeeID = CInt(CommonFunction.Data.CheckIsDBNull(drRow.Item("EmployeeID"), "0"))

            strListHTML.Append("<li class='clsAssignedListItem dropdown-item'name='" & CommonFunction.Data.CheckIsDBNull(drRow.Item("EmployeeName"), "") & "'>")
            strListHTML.Append("<a href='#' id='" & CommonFunction.Data.CheckIsDBNull(drRow.Item("EmployeeID"), "") & "'name='" & CommonFunction.Data.CheckIsDBNull(drRow.Item("EmployeeName"), "") & "'  onclick='AssignToListClick(this)' >" & vbCrLf)
            'strListHTML.Append('<img id='imgUser' & intEmployeeID.ToString & '' src='' & strEmployeeImage & '' alt='No Image' style='height:30px;width:30px;border-radius:50%;' /> &nbsp; ')
            strListHTML.Append("<img  id='imgUser" & intEmployeeID.ToString & "' data-toggle='tooltip' data-placement='bottom' alt='User Avatar' class='img-circle' onerror=this.src='../../Images/Photo/no-photo.png' style='height:30px;width:30px;' src='../../Images/Photo/" & drRow.Item("EmployeeImage") & "' />&nbsp")
            strListHTML.Append(CommonFunction.Data.CheckIsDBNull(drRow.Item("EmployeeName"), "") & "</a>" & vbCrLf)
            strListHTML.Append("</li>")
        Next

        Return strListHTML.ToString

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetWeekDates(strFlag As String) As String
        '=====================================================================
        ' Procedure Name        :	GetWeekDates
        ' Purpose               :	GetWeekDates
        ' Description           :	Open DS
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	YOgesh Jalamkar
        ' Created               :	16th-March-2018
        ' Revisions             :
        '=====================================================================
        Try
            Dim strSql As String
            Dim strHTML As New StringBuilder("")
            If strFlag = "Prev" Then
                dtDSCurrentDate = CommonFunctions.Dates.GetDate(Date.Parse(DateAdd("d", -7, dtDSCurrentDate)))
            ElseIf strFlag = "Next" Then
                dtDSCurrentDate = CommonFunctions.Dates.GetDate(Date.Parse(DateAdd("d", 7, dtDSCurrentDate)))
            End If

            strSql = "usp_NG2_GetWeekDates '" & dtDSCurrentDate & "'"
            Dim drWeekDates As IDataReader
            drWeekDates = CommonFunctions.Data.GetDataReader(strSql, True)
            Dim strCurrentDate As String = ""
            Dim strColor = ""
            While drWeekDates.Read()
                strHTML.Append(" <tr>")

                If CommonFunctions.Data.CheckIsDBNull(drWeekDates("IsNonWorkingDay"), "0") = "1" Then
                    strColor = "red"
                Else
                    strColor = "#337ab7"
                End If
                'strHTML.Append("<input type='hidden' id='hdnDSCurrentDate' value='' & CurrentDate & ''>')
                If (CommonFunctions.Data.CheckIsDBNull(drWeekDates("IsCurrentDay"), "") = "1") Then
                    strHTML.Append("<td class='scrum_date selecteddate' style='border-top-color: transparent;' onclick=WeekDate_onclick('" & CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "") & "',this)><a href='#' style='color:" & strColor & "'onclick=WeekDate_onclick('" & CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "") & "',this)>" & CommonFunctions.Dates.CGetDate(CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "")) & "</a></td>")
                Else
                    strHTML.Append("<td class='scrum_date' style='border-top-color: transparent;' onclick=WeekDate_onclick('" & CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "") & "',this)><a href='#' style='color:" & strColor & "' onclick=WeekDate_onclick('" & CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "") & "',this)>" & CommonFunctions.Dates.CGetDate(CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), "")) & "</a></td>")

                End If
                strCurrentDate = CommonFunctions.Dates.CGetDate(CommonFunctions.Data.CheckIsDBNull(drWeekDates("Dates"), ""))
                strHTML.Append(" </tr>")
            End While
            'strHTML.Append("&&'' & strCurrentDate & ''')
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveDailyScrum(MeetingID As String, ActionItems As String, Sprint As String, TargetDate As String, AssignedTo As String, Status As String, Remark As String, IsConvertedToImpediment As String) As String
        '=====================================================================
        ' Procedure Name        :	SaveDailyScrum
        ' Purpose               :	SaveDailyScrum
        ' Description           :	Open DS
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	YOgesh Jalamkar
        ' Created               :	16th-March-2018
        ' Revisions             :
        '=====================================================================
        Try
            Dim strSQL As String = "usp_NG2_INS_tbl_NG2_DailyScrumMeetingDetails "
            Dim strFlag As String = "0"
            Try
                ''If status is closed and convert to impediment then check whether impediment is closed

                If ActionItems.Contains("'") Then
                    ActionItems = ActionItems.Replace("'", "''")
                End If
                If Remark.Contains("'") Then
                    Remark = Remark.Replace("'", "''")
                End If
                If Status.ToUpper = "CLOSED" And IsConvertedToImpediment = "1" Then
                    strFlag = CommonFunction.Data.GetDataScalar("usp_NG2_chk_ImpedimentClosedForDSM " & MeetingID, True)
                    If strFlag = "1" Then
                        Return "2"
                    End If
                End If

                If (MeetingID <> "") Then
                    strSQL += MeetingID
                Else
                    strSQL += "NULL"
                End If
                strSQL += "," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")

                strSQL += ",'" + ActionItems + "'"
                strSQL += "," + Sprint
                If TargetDate <> "" Then
                    strSQL += ",'" + TargetDate + "'"
                Else
                    strSQL += ",NULL"
                End If
                If AssignedTo <> "" Then
                    strSQL += "," + AssignedTo + ""
                Else
                    strSQL += ",NULL"
                End If

                If Status <> "" Then
                    strSQL += ",'" + Status + "'"
                Else
                    strSQL += ",NULL"
                End If

                strSQL += ",'" + Remark + "'"
                strSQL += "," + IsConvertedToImpediment
                strSQL += ",'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") + "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                strFlag = "1"
            Catch ex As Exception

            End Try
            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DrawGrid(Flag As String, Value As String) As String
        '=====================================================================
        ' Procedure Name        :	DrawGrid()
        ' Purpose               :	DrawGrid by Dates
        ' Description           :	
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	YOgesh Jalamkar
        ' Created               :	16th-March-2018
        ' Revisions             :
        '=====================================================================
        Try
            Dim objDailyScrum As New frmDailyScrum
            Dim strHTML As New StringBuilder("")
            Dim strWhereClause As String = ""
            Dim strFromDate As String = ""
            If (Flag.ToUpper() = "WEEKDATE") Then
                strFromDate = Value

            ElseIf Flag.ToUpper() = "STATUS" Then
                strWhereClause = "Status = ''" & Value & "''"

            ElseIf Flag.ToUpper() = "IMPEDIMENT" Then
                strWhereClause = "IsConvertedToImpediment = """ & Value & """"
            ElseIf Flag.ToUpper() = "SPRINTS" Then
                strWhereClause = "IterationID = """ & Value & """"
            ElseIf Flag.ToUpper() = "CURRENTSPRINT" Then
                strWhereClause = "IterationID = dbo.fn_NG2_Sel_CurrentIterationOrRelease(" & HttpContext.Current.Session("intProjectID") & ",''ITERATION'')"
            End If

            strHTML.Append(objDailyScrum.PlotGrid(strFromDate, strWhereClause))
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    'Commented and Added by Usha Pandit on 12 April 2018 for Impediment Modal Popup
    '<System.Web.Services.WebMethod()>
    'Public Shared Function AddImpedimentModal()
    '    '=====================================================================
    '    ' Procedure Name        :	AddImpedimentModal
    '    ' Purpose               :	AddImpedimentModal
    '    ' Description           :	Open DS
    '    ' Parameters Passed     :	None.
    '    ' Parameters Affected   :	None.
    '    ' Returns               :	None
    '    ' Assumptions           :	None.
    '    ' Dependencies          :	None.
    '    ' Author                :	YOgesh Jalamkar
    '    ' Created               :	16th-March-2018
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strHTML As New StringBuilder()
    '    strHTML.Append("<div class='container' id='container_impediment'>")
    '    strHTML.Append(" <form>")
    '    '''''''''''

    '    strHTML.Append("<div class='form-group row'>")
    '    strHTML.Append(" <label  class='col-sm-1 col-form-label' data-toggle='tooltip' data-placement='bottom' title='Action Items' > Description* </label> ")
    '    strHTML.Append("<div class='col-sm-6'>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtImpedimentDescription", "txtImpedimentDescription", , "form-control", , , , , , , 1000, , , " margin-left: 45px;", , , , , "onkeyup='javascript:Maxlength(this,""ImpedimentDescription"",1000)'", True, EnableHTMLEncode:=True))
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-md-1'>")
    '    strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;margin-left:20px;margin-top:40px;' id='ImpedimentDescription'></p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    '''''''''''

    '    strHTML.Append("<div class='form-group row'>")
    '    strHTML.Append(" <label  class='col-sm-1 col-form-label' data-toggle='tooltip' data-placement='bottom'> Severity </label> ")
    '    strHTML.Append("<div class='col-md-3'>")
    '    strHTML.Append("<div class='input-group'>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentSeverity", "usp_NG2_Sel_tbl_IB_SeverityDetails", , , "class='form-control' style='margin-left: 45px;width:200px' ", True, True))
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-md-1'>")
    '    strHTML.Append("</div>")

    '    strHTML.Append(" <label  class='col-sm-1 col-form-label' data-toggle='tooltip' data-placement='bottom' > Priority </label> ")
    '    strHTML.Append("<div class='col-md-3'>")
    '    strHTML.Append("<div class='input-group'>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentPriority", "usp_NG2_Sel_tbl_IB_PrioritiesDetails ", , , "class='form-control' style='margin-left: 45px;width:200px' ", True, True))
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    ''''''''''''''''''''''''
    '    strHTML.Append("<div class='form-group row'>")
    '    strHTML.Append(" <label  class='col-sm-1 col-form-label' data-toggle='tooltip' data-placement='bottom'  > Corrective Action </label> ")
    '    strHTML.Append("<div class='col-sm-6'>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtCorrectiveAction", "txtCorrectiveAction", , "form-control", , , , , , , 1000, , , " margin-left: 45px;", , , , , "onkeyup='javascript:Maxlength(this,""CorrectiveAction"",1000)'", True, EnableHTMLEncode:=True))
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-md-1'>")
    '    strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;margin-left:20px;margin-top:40px;' id='CorrectiveAction'></p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    '''''''''''''
    '    strHTML.Append("<div class='form-group row'>")
    '    strHTML.Append(" <label  class='col-sm-1 col-form-label' data-toggle='tooltip' data-placement='bottom' > Preventive Action </label> ")
    '    strHTML.Append("<div class='col-sm-6'>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtPreventiveAction", "txtPreventiveAction", , "form-control", , , , , , , 1000, , , " margin-left: 45px;", , , , , "onkeyup='javascript:Maxlength(this,""PreventiveAction"",1000)'", True, EnableHTMLEncode:=True))
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-md-1'>")
    '    strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;margin-left:20px;margin-top:40px;' id='PreventiveAction'></p>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    '''''''''''

    '    strHTML.Append("<div class='form-group row'>")
    '    strHTML.Append(" <label  class='col-sm-1 col-form-label' data-toggle='tooltip' data-placement='bottom' > Target Date </label> ")
    '    strHTML.Append(" <div class='col-md-3'>")
    '    strHTML.Append("<div class='input-group'>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("dtPlannedIssueDate", "dtPlannedIssueDate", "form-control", , , , , "margin-left: 43px", , , , , "onclick=$('#dtPlannedIssueDate').datepicker();$('#dtPlannedIssueDate').datepicker('show');", True, , , , , , True))
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-md-1'>")
    '    strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; color:#0099CC;margin-left: 20px;  margin-top: 17px;'></i>")
    '    strHTML.Append("</div>")


    '    strHTML.Append(" <label  class='col-sm-1 col-form-label' data-toggle='tooltip' data-placement='bottom'  > Status </label> ")
    '    strHTML.Append("<div class='col-md-3'>")
    '    strHTML.Append("<div class='input-group'>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentStatus", "usp_NG2_GetStatusForDSM 'Impediment'", , , "class='form-control' style='width:200px' ", True, True))
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")

    '    '''''''''''''''''''''''''''''''''''''
    '    strHTML.Append("<div class='form-group row'>")
    '    strHTML.Append(" <label  class='col-sm-1 col-form-label' data-toggle='tooltip' data-placement='bottom' > Raised Date </label> ")
    '    strHTML.Append(" <div class='col-md-3'>")
    '    strHTML.Append("<div class='input-group'>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("dtRaisedDate", "dtRaisedDate", "form-control", , , , , "margin-left: 43px", , , , , "onclick=$('#dtRaisedDate').datepicker();$('#dtRaisedDate').datepicker('show'); disabled", True, , , , , , True))
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='col-md-1'>")
    '    strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; color:#0099CC;margin-left: 20px;  margin-top: 17px;'></i>")
    '    strHTML.Append("</div>")


    '    'strHTML.Append(" <label  class='col-sm-1 col-form-label' data-toggle='tooltip' data-placement='bottom' > Actual Closure Date </label> ")
    '    'strHTML.Append(" <div class='col-md-3'>")
    '    'strHTML.Append("<div class='input-group'>")
    '    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("dtActualIssueDate", "dtActualIssueDate", "form-control", , , , , "margin-left: 43px", , , , , "onclick=$('#dtActualIssueDate').datepicker();$('#dtActualIssueDate').datepicker('show');", True, , , , , , True))
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("<div class='col-md-1'>")
    '    'strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='font-size: 16px; color:#0099CC;margin-left: 20px;  margin-top: 17px;'></i>")
    '    'strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    '''''''''''''''
    '    strHTML.Append("<div class='row form-group'>")
    '    strHTML.Append("<label class='col-sm-1 col-form-label' data-toggle='tooltip' data-placement='bottom' title='Converted To'>Convert To</label>")
    '    strHTML.Append("<div class='col-md-3'>")
    '    strHTML.Append("<div class='input-group'>")

    '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentConvertTo", "usp_NG2_Sel_ConvertTo_For_Impediment ", , , "class='form-control' style='margin-left: 45px;width:200px' ", True, True))
    '    strHTML.Append(" </div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append(" </div>")

    '    ''''''''''''''''''''''''
    '    strHTML.Append("</form>")
    '    strHTML.Append("</div>")
    '    Return strHTML.ToString
    'End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function AddImpedimentModal()
        '=====================================================================
        ' Procedure Name        :	AddImpedimentModal
        ' Purpose               :	AddImpedimentModal
        ' Description           :	Open DS
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	YOgesh Jalamkar
        ' Created               :	16th-March-2018
        ' Revisions             :
        '=====================================================================
        Try
            Dim strHTML As New StringBuilder()
            Dim objfrmImpedimentLog As New frmImpedimentLog()
            strHTML.Append("<div class='' id='container_impediment'>")
            strHTML.Append(" <form>")


            'Added by Usha Pandit on 24 May 2018 for plotting drop down for sprint
            ''''''''''''''''''''''''
            strHTML.Append("<div class='row form-group'>")
            strHTML.Append("<label class='col-sm-3 col-form-label'>Select Sprint*</label>")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append("<div class=''>")

            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSprint", "usp_NG2_Sel_tbl_PM_ScrumIteration_Open_Sprints " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), , "", " onchange=""GetSelectedSprint(this)"" class='form-control' style='width:200px;height:32px;' ", False, True))
            strHTML.Append(" </div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            ''''''''''''''''''''''''
            'End of Added by Usha Pandit on 24 May 2018 for plotting drop down for sprint


            '''''''''''      


            strHTML.Append("<div class='form-group row'>")
            strHTML.Append(" <label id='lblDescription'  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom' title='Action Items' > Action Items/Description* </label> ")
            strHTML.Append("<div class='col-sm-9'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtImpedimentDescription", "txtImpedimentDescription", , "form-control", , , , , , , 500, , , "overflow:hidden;", , , , , "data-autoresize", True, EnableHTMLEncode:=True))
            'strHTML.Append("<p style='margin-right: -30px;margin-top: -30px;font-size: 13px;font-weight: 500;color: grey;float: right;' id='ImpedimentDescription'></p>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtImpedimentDescription", "txtImpedimentDescription", , , , , , , , , 500, , , "overflow:hidden;", , , , , "onkeyup='ShowLength(this,""ImpedimentDescription"",500)' onchange='ShowLength(this,""ImpedimentDescription"",500)' ", True, EnableHTMLEncode:=True))
            strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;float: right;' id='ImpedimentDescription'></p>")
            strHTML.Append("</div>")


            strHTML.Append("</div>")

            '''''''''''

            strHTML.Append("<div class='form-group row'>")
            'strHTML.Append("<div class=''>")
            strHTML.Append(" <label  class='col-sm-3 col-form-label clsIsMandetory' data-toggle='tooltip' data-placement='bottom' > Priority </label> ")
            strHTML.Append("<div class='col-sm-3'>")
            'strHTML.Append("<div class=''>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentPriority", "usp_NG2_Sel_tbl_IB_PrioritiesDetails", , , "class='form-control' style='' ", True, True))
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            strHTML.Append("</div>")

            'strHTML.Append("<div class=''>")
            strHTML.Append(" <label  class='col-sm-3 col-form-label clsIsMandetory' data-toggle='tooltip' data-placement='bottom' style=''> Severity </label> ")
            strHTML.Append("<div class='col-sm-3'>")
            'strHTML.Append("<div class=''>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentSeverity", "usp_NG2_Sel_tbl_IB_SeverityDetails", , , "class='form-control' style='' ", True, True))
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            strHTML.Append("</div>")


            strHTML.Append("</div>")

            ''''''''''''''''''''''''
            strHTML.Append("<div class='form-group row'>")
            strHTML.Append(" <label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom'  > Corrective Action </label> ")
            strHTML.Append("<div class='col-sm-9'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtCorrectiveAction", "txtCorrectiveAction", , "form-control", , , , , , , 1000, , , "overflow:hidden;", , , , , "data-autoresize", True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtCorrectiveAction", "txtCorrectiveAction", , , , , , , , , 1000, , , "overflow:hidden;", , , , , "onkeyup='ShowLength(this,""CorrectiveAction"",1000)' onchange='ShowLength(this,""CorrectiveAction"",1000)' ", True, EnableHTMLEncode:=True))
            'strHTML.Append("<p style='margin-right: -30px;margin-top: -30px;font-size: 13px;font-weight: 500;color: grey;float: right;' id='CorrectiveAction'></p>")
            strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;float: right;' id='CorrectiveAction'></p>")

            strHTML.Append("</div>")

            strHTML.Append("</div>")

            '''''''''''''
            strHTML.Append("<div class='form-group row'>")
            strHTML.Append(" <label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom' > Preventive Action </label> ")
            strHTML.Append("<div class='col-sm-9'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtPreventiveAction", "txtPreventiveAction", , "form-control", , , , , , , 1000, , , "overflow:hidden;", , , , , "data-autoresize", True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtPreventiveAction", "txtPreventiveAction", , , , , , , , , 1000, , , "overflow:hidden;", , , , , "onkeyup='ShowLength(this,""PreventiveAction"",1000)' onchange='ShowLength(this,""PreventiveAction"",1000)' ", True, EnableHTMLEncode:=True))
            'strHTML.Append("<p style='margin-right: -30px;margin-top: -30px;font-size: 13px;font-weight: 500;color: grey;float: right;' id='PreventiveAction'></p>")
            strHTML.Append("<p style='font-size: 13px;font-weight: 500;color: grey;float: right;' id='PreventiveAction'></p>")

            strHTML.Append("</div>")
            strHTML.Append("</div>")

            '''''''''''

            strHTML.Append("<div class='form-group row'>")
            'strHTML.Append("<div class=''>")
            strHTML.Append(" <label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom' title='Planned Issue Closure Date'> Planned Issue Closure Date </label> ")
            strHTML.Append(" <div class='col-sm-3'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("dtPlannedIssueDate", "dtPlannedIssueDate", "form-control", , , , , "", , , , , " onchange=""checkProjectEndDate(this)"" onclick=""$('#dtPlannedIssueDate').datepicker({dateFormat: 'dd-M-yy', minDate: 0});$('#dtPlannedIssueDate').datepicker('show');""", True, , , , , , True))
            strHTML.Append(" <i class='fa fa-calendar-check-o' aria-hidden='true' style='    margin-top: -29px;    float: right;font-size: 16px; color:#0099CC;'></i>")
            'strHTML.Append("</div>")
            strHTML.Append("</div>")


            'strHTML.Append("<div class=''>")
            strHTML.Append(" <label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom'  > Status </label> ")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentStatus", "usp_NG2_GetStatusForDSM 'Impediment'", , "Open", "class='form-control' style='' onchange=getselectedDStatus(this) ", True, True))
            'strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            '''''''''''''''''''''''''''''''''''''

            '''''''''''''''
            strHTML.Append("<div class='form-group row '>")
            'strHTML.Append("<div class=''>")
            strHTML.Append("<label class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom' title='Converted To'>Convert To</label>")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("impedimentConvertTo", "usp_NG2_Sel_ConvertTo_For_Impediment ", , , " onchange=""GetSelectedConvertTo(this)"" class='form-control' style='' ", True, True))
            'strHTML.Append("</div>")
            strHTML.Append("</div>")

            '''strHTML.Append("<div id='divResponsePerson' class='form-group row clsShow'>")
            strHTML.Append("<label  class='col-sm-3 col-form-label' data-toggle='tooltip' data-placement='bottom' > Responsible Person* </label> ")
            strHTML.Append("<div class='col-sm-3'>")
            Dim strDefaultResponsiblePerson As String = objfrmImpedimentLog.getDefaultResponsiblePerson()

            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("ResponsiblePerson", "usp_Sel_IB_IssueEntry_EmployeeList 'AssignTo', " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"), , strDefaultResponsiblePerson, " onchange=""GetSelectedConvertTo(this)"" class='form-control' style='' ", True, True))

            'strHTML.Append("</div>")
            strHTML.Append("</div>")

            'strHTML.Append("<div id='divRiskCategory' class='form-group row clsShow'>")
            strHTML.Append(" <label class='col-form-label col-sm-3' style=''  data-toggle='tooltip' data-placement='bottom' title='Risk Category'>Risk Category*</label> ")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("RiskCategory", "usp_Sel_tbl_PM_RiskCategories", , , "class='form-control' style='' ", True, True))
            strHTML.Append("</div>")
            ' strHTML.Append("</div>")


            strHTML.Append(" </div>")
            ''''''''''''''''''''''''

            strHTML.Append("<div id='divRiskFields' class='clsShow form-group row'>")
            strHTML.Append(" <label  class='col-form-label col-sm-3' data-toggle='tooltip' data-placement='bottom'> Impact* </label> ")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Impact", "Impact", "form-control", , , , , "", , , , , " onkeypress='return validatedatatype(event,""Impact"")' ", True, , , , , , True))
            strHTML.Append("</div>")

            strHTML.Append(" <label  class='col-form-label col-sm-3' data-toggle='tooltip' data-placement='bottom' > Probability* </label> ")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Probability", "Probability", "form-control", , , , , "", , , , , " onkeypress='return validatedatatype(event,""Probability"")' ", True, , , , , , True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            ''''''''''''''''''''''''
            strHTML.Append("</form>")
            strHTML.Append("</div>")
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveImpedimentRisk(Probability As String, Impact As String, Description As String, RiskCategoryId As String, ImpedimentID As String, ImpactDescription As String, RiskStatus As String, DateIdentified As String) As String
        '=====================================================================
        ' Procedure Name        :	SaveImpedimentRisk
        ' Purpose               :	Save Impediment Risk
        ' Description           :	
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Usha Pandit
        ' Created               :	29 MAR 2018
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = ""
        Dim strFlag As String = "0"
        Try
            If Probability = "" Or Probability Is Nothing Then
                Probability = "0"
            End If
            If Impact = "" Or Impact Is Nothing Then
                Impact = "0"
            End If
            If RiskCategoryId = "" Or RiskCategoryId Is Nothing Then
                RiskCategoryId = "0"
            End If
            If ImpedimentID = "" Or ImpedimentID Is Nothing Then
                ImpedimentID = "0"
            End If
            If Description.Contains("'") Then
                Description = Description.Replace("'", "''")
            End If
            If ImpactDescription.Contains("'") Then
                ImpactDescription = ImpactDescription.Replace("'", "''")
            End If

            strSQL = "usp_NG2_Ins_tbl_PM_ImpedimentRisks '" & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") & "'," & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & "," & Probability & "," & Impact & ",'" & Description & "'," & RiskCategoryId & "," & ImpedimentID


            strFlag = CommonFunctions.Data.GetDataScalar(strSQL, True)
            strFlag = "Success"
            Return strFlag
        Catch ex As Exception
            strFlag = "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveImpedimentIssue(Description As String, ImpedimentID As String, AssignTo As String, Type As String, SubType As String, Status As String, ReportedBy As String, Summary As String, Priority As String, Severity As String) As String
        '=====================================================================
        ' Procedure Name        :	SaveImpedimentIssue
        ' Purpose               :	Save Impediment Issue
        ' Description           :	
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Usha Pandit
        ' Created               :	30 MAR 2018
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = ""
        Dim strFlag As String = "0"
        Try
            If ImpedimentID = "" Or ImpedimentID Is Nothing Then
                ImpedimentID = "0"
            End If

            If AssignTo = "" Or AssignTo Is Nothing Then
                AssignTo = "0"
            End If

            If Description.Contains("'") Then
                Description = Description.Replace("'", "''")
            End If
            If Summary.Contains("'") Then
                Summary = Summary.Replace("'", "''")
            End If


            strSQL = "usp_NG2_Ins_tbl_IB_ImpedimentIssue '" & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") & "'," & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ",'" & Description & "'," & ImpedimentID & "," & AssignTo & ",'" & Priority & "','" & Severity & "'"



            strFlag = CommonFunctions.Data.GetDataScalar(strSQL, True)
            strFlag = "Success"
            Return strFlag
        Catch ex As Exception
            strFlag = "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetProjectEndDate()
        '====================================================================
        ' Function  Name        : GetProjectEndDate
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To get ProjectEndDate
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Usha Pandit
        ' Created               : 11-Apr-2018
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = ""
        Dim strResult As String
        Dim index As Integer = 0

        Try

            strSQL = "exec usp_Sel_tbl_PM_Project  " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ""
            'strResult = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataReader(strSQL, True), "0")
            Dim drProjectDetails As IDataReader
            drProjectDetails = CommonFunctions.Data.GetDataReader(strSQL, True)
            If drProjectDetails.Read Then
                strResult = CommonFunctions.Data.CheckIsDBNull(drProjectDetails("ExpectedEndDate"), "")
            End If
            If Not strResult = "" Then
                strResult = DateTime.Parse(Convert.ToDateTime(strResult)).ToString("dd-MMM-yyyy")
            End If
            'Dim CurrentDate As String = DateTime.Parse(DateTime.Now).ToString("dd-MMM-yyyy")
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    'End of Added by Usha Pandit on 12 April 2018 for Impediment Modal Popup

    'Commented and Added by Usha Pandit on 12 April 2018 for Impediment Modal Popup
    '<System.Web.Services.WebMethod()>
    'Public Shared Function SaveImpediment(ImpedimentDescription As String, ImpedimentSeverity As String, ImpedimentPriority As String, CorrectiveAction As String, PreventiveAction As String, PlannedIssueDate As String, impedimentStatus As String, ConvertedTo As String) As String
    '    '=====================================================================
    '    ' Procedure Name        :	SaveImpediment
    '    ' Purpose               :	SaveImpediment
    '    ' Description           :	
    '    ' Parameters Passed     :	None.
    '    ' Parameters Affected   :	None.
    '    ' Returns               :	None
    '    ' Assumptions           :	None.
    '    ' Dependencies          :	None.
    '    ' Author                :	YOgesh Jalamkar
    '    ' Created               :	16th-March-2018
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strSQL As String = "usp_NG2_INS_tbl_NG2_ImpedimentsLog "
    '    Dim strFlag As String = "0"
    '    Try



    '        strSQL += "NULL"
    '        strSQL += "," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")
    '        strSQL += ",'" + ImpedimentDescription + "'"
    '        strSQL += ",'" + ImpedimentSeverity + "'"
    '        strSQL += ",'" + ImpedimentPriority + "'"
    '        strSQL += ",'" + CorrectiveAction + "'"

    '        strSQL += ",'" + PreventiveAction + "'"
    '        strSQL += ",'" + PlannedIssueDate + "'"

    '        strSQL += ",'" + impedimentStatus + "'"
    '        strSQL += ",'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") + "'"
    '        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
    '        strFlag = "1"
    '    Catch ex As Exception

    '    End Try
    '    Return strFlag
    'End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveImpediment(ImpedimentID As String, ImpedimentDescription As String, ImpedimentSeverity As String, ImpedimentPriority As String, CorrectiveAction As String, PreventiveAction As String, PlannedIssueDate As String, impedimentStatus As String, ConvertedTo As String, IterationID As String) As String
        '=====================================================================
        ' Procedure Name        :	SaveImpediment
        ' Purpose               :	SaveImpediment
        ' Description           :	
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	YOgesh Jalamkar
        ' Created               :	16th-March-2018
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = "usp_NG2_INS_tbl_NG2_ImpedimentsLog "
        Dim strFlag As String = "0"
        Try
            If (ImpedimentID <> "") Then
                strSQL += ImpedimentID
            Else
                strSQL += "NULL"
            End If
            If ImpedimentDescription.Contains("'") Then
                ImpedimentDescription = ImpedimentDescription.Replace("'", "''")
            End If
            If CorrectiveAction.Contains("'") Then
                CorrectiveAction = CorrectiveAction.Replace("'", "''")
            End If

            If PreventiveAction.Contains("'") Then
                PreventiveAction = PreventiveAction.Replace("'", "''")
            End If
            strSQL += "," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")
            strSQL += ",'" + ImpedimentDescription + "'"
            strSQL += ",'" + ImpedimentSeverity + "'"
            strSQL += ",'" + ImpedimentPriority + "'"
            strSQL += ",'" + CorrectiveAction + "'"
            strSQL += ",'" + PreventiveAction + "'"

            If PlannedIssueDate = "" Then
                strSQL += ",NULL"
            Else
                strSQL += ",'" + PlannedIssueDate + "'"
            End If

            If impedimentStatus = "Info" Then
                strSQL += ",'" + impedimentStatus + "'"
            ElseIf impedimentStatus = "Delayed" Then
                strSQL += ", NULL"
            Else
                strSQL += ",'" + impedimentStatus + "'"
            End If

            strSQL += ",'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") + "'"
            If (ConvertedTo <> "") Then
                strSQL += ",'" + ConvertedTo + "'"
            Else
                strSQL += "," + "NULL"
            End If

            strSQL += "," + IterationID                   'Added by Usha Pandit on 24 May 2018 for saving sprint for current impediment

            strFlag = CommonFunctions.Data.GetDataScalar(strSQL, True)

        Catch ex As Exception
            strFlag = ex.Message
        End Try
        Return strFlag
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DefaultIssueExist() As String
        '=====================================================================
        ' Procedure  Name		:	DefaultIssueExist
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Check if Default Issue Type is mapped or not
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   29 MAR 2018
        '=====================================================================

        Dim strSQL As String = ""
        Dim strResult As String
        Dim index As Integer = 0

        Try

            strSQL = "exec usp_NG2_chk_DefaultSettingForIssueMapped  " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0") & ""
            strResult = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "0")

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    'End of Added by Usha Pandit on 12 April 2018 for Impediment Modal Popup
    <System.Web.Services.WebMethod()>
    Public Shared Function UpdateImpediment(MeetingID, MeetingStatus) As String
        '=====================================================================
        ' Procedure Name        :	UpdateImpediment
        ' Purpose               :	UpdateImpediment
        ' Description           :	
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	YOgesh Jalamkar
        ' Created               :	16th-March-2018
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim strFlag As String = "0"
        Try
            strSQL = " usp_NG2_ConvertDSMToImpediment " & MeetingID & ",'" & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "") & "','" & MeetingStatus & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            strFlag = "1"

            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function CurrentSprintDates(SprintID As String) As String
        '=====================================================================
        ' Procedure Name        :	CurrentSprintDates
        ' Purpose               :	CurrentSprintDates
        ' Description           :	
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Usha Pandit
        ' Created               :	24-APR-2018
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim strFlag As String = "0"
        Dim StartDate As String = ""
        Dim EndDate As String = ""
        Try
            strSQL = "usp_NG2_Sel_Sprint_Dates " & SprintID

            Dim drSprintDetails As IDataReader
            drSprintDetails = CommonFunctions.Data.GetDataReader(strSQL, True)
            If drSprintDetails.Read Then
                StartDate = CommonFunctions.Data.CheckIsDBNull(drSprintDetails("StartDate"), "")
                EndDate = CommonFunctions.Data.CheckIsDBNull(drSprintDetails("EndDate"), "")
            End If
            strFlag = StartDate & "##" & EndDate
            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CurrenDateValidation(strDate As String, SprintID As String) As String
        '=====================================================================
        ' Procedure Name        :	CurrenDateValidation
        ' Purpose               :	CurrenDateValidation
        ' Description           :	
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	YOgesh Jalamkar
        ' Created               :	16th-March-2018
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim strFlag As String = "0"
        Try
            strDate = Convert.ToDateTime(strDate).ToString("yyyy-MM-dd")
            strSQL = " usp_Ng2_Validate_DueDate '" & strDate & "'"
            strFlag = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "")
            If strFlag = "" Then
                strSQL = "usp_NG2_Validate_Sprint_Dates " & SprintID & ",'" & strDate & "'," & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")
                strFlag = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "")
            End If
            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    <System.Web.Services.WebMethod>
    Public Shared Function ShowHistoryDetails(ByVal MeetingID As String) As String
        '=====================================================================
        ' Procedure Name        : ShowHistoryDetails
        ' Purpose               : 
        ' Description           : To Plot ShowHistory Details
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created Date           :23rd Feb -2018
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objfrmDailyScrum As New frmDailyScrum()
            strGridHTML.Append(objfrmDailyScrum.WriteHistoryGrid(MeetingID))
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    Private Function WriteHistoryGrid(ByVal MeetingID As String) As String
        '=====================================================================
        ' Procedure Name        : WriteHistoryGrid()	
        ' Purpose               : To Plot the Grids
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                :Yogesh Jalamkar
        ' Created               : 23-MAR-2018
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
        intNoOfDataColumn = 6
        strDivID = "DivGridShowHistory"
        strSQLQuery = "usp_NG2_sel_tbl_PM_ScrumAuditTrail " & MeetingID & ",22235"
        arrstrActualList = {"FieldName", "OldValue", "NewValue", "ModifiedBy", "Date"}
        arrstrUserFriendlyList = {"Field Name", "Old Value", "New Value", "Modified By", "Modified Date"}
        arrstrLinkArray = {"", "", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", "", ""}
        arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}
        'Added By Dipali V On 24th March 2023 For Datatable Issue
        Dim dtListCount As New DataTable
        dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
        strGridHTML.Append("<input type=hidden id=FilterGridShowHistory value='" & dtListCount.Rows.Count & "'>")
        'End of Added By Dipali V On 24th March 2023 For Datatable Issue
        With objHistoryGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            ' .CheckBoxIDArray = arrCheckBoxArray
            .NoOfDataColumns = intNoOfDataColumn
            .RowLinkArray = arrstrLinkArray
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:auto"
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = (" ")
            .DIVID = strDivID
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            strGridHTML.Append(.DrawGrid())
        End With
        objHistoryGrid = Nothing
        'End If
        Return strGridHTML.ToString


    End Function
    Private Sub objHistoryGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objHistoryGrid.DataRowTD_BeforePrint
        Dim blnDelayedStatus As Boolean = False
        Dim strOldValue As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("OldValue"), "")
        Dim strNewValue As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("NewValue"), "")
        Dim strFieldName As String = CommonFunction.Data.CheckIsDBNull(Args.DataReader("FieldName"), "")

        Dim strLessCommentOldValue As String = ""
        Dim strRemainingOldValue As String = ""
        Dim strLessCommentNewValue As String = ""
        Dim strRemainingNewValue As String = ""

        If strOldValue.Length > 200 Then
            strLessCommentOldValue = strOldValue.Substring(0, 100)
            strRemainingOldValue = strOldValue.Substring(101, strOldValue.Length - 101)
        End If
        If strNewValue.Length > 200 Then
            strLessCommentNewValue = strNewValue.Substring(0, 100)
            strRemainingNewValue = strNewValue.Substring(101, strNewValue.Length - 101)
        End If


        If strOldValue = "Delayed" Then
            blnDelayedStatus = True
        End If


        If Args.DataField.ToUpper = "DATE" Then
            Cancel = True
            If blnDelayedStatus = False Then
                If CommonFunctions.General.CheckIsNothing(Args.DataReader("DATE"), "") <> "" Then
                    Args.StringToBeInserted = "<td align='center' nowrap ><p Title = 'Modified Date' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Dates.GetDate(Args.DataReader("DATE")) & "</p></TD>"
                Else
                    Args.StringToBeInserted = "<td align='center' ><p Title = 'Modified Date' data-toggle='tooltip' data-placement='bottom'></p></TD>"
                End If

            End If
        End If



        If Args.DataField.ToUpper = "OLDVALUE" Then
            Cancel = True


            If blnDelayedStatus = False Then

                If (CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FIELDNAME"), "").ToString.ToUpper = "TARGET DATE") Then
                    If (CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OldValue"), "").ToString <> "") Then
                        Args.StringToBeInserted = "<td align='center' ><p Title = 'Old Value' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Dates.GetDate(Args.DataReader("OldValue")) & "</p></TD>"
                    Else
                        Args.StringToBeInserted = "<td align='center' ><p Title = 'Old Value' data-toggle='tooltip' data-placement='bottom'></p></TD>"
                    End If
                Else
                    Args.StringToBeInserted = "<td align='center' ><p Title = 'Old Value' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OldValue"), "") & "</p></TD>"
                End If

            End If

        End If
        If Args.DataField.ToUpper = "NEWVALUE" Then
            Cancel = True
            If blnDelayedStatus = False Then
                If (CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FIELDNAME"), "").ToString.ToUpper = "TARGET DATE") Then
                    If (CommonFunctions.Data.CheckIsDBNull(Args.DataReader("NEWVALUE"), "").ToString <> "") Then
                        Args.StringToBeInserted = "<td align='center' ><p Title = 'New Value' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Dates.GetDate(Args.DataReader("NEWVALUE")) & "</p></TD>"
                    Else
                        Args.StringToBeInserted = "<td align='center' ><p Title = 'New Value' data-toggle='tooltip' data-placement='bottom'></p></TD>"
                    End If
                Else
                    Args.StringToBeInserted = "<td align='center' ><p Title = 'New Value' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("NEWVALUE"), "") & "</p></TD>"
                End If
            End If
        End If
        If Args.DataField.ToUpper = "MODIFIEDBY" Then
            Cancel = True
            If blnDelayedStatus = False Then
                Args.StringToBeInserted = "<td align='left' ><p Title = 'Modified By' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MODIFIEDBY"), "") & "</p></TD>"
            End If
        End If

        If Args.DataField.ToUpper = "FIELDNAME" Then
            Cancel = True

            If blnDelayedStatus = False Then
                Args.StringToBeInserted = "<td align='center'><p Title = 'Field Name' data-toggle='tooltip' data-placement='bottom'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FIELDNAME"), "") & "</p></TD>"
            End If
        End If

        If strFieldName = "Description" Or strFieldName = "Remark" Then
            If Args.DataField.ToUpper = "OLDVALUE" Then
                Cancel = True
                If strOldValue.Length > 200 Then
                    If strOldValue.Contains("'") Then
                        Args.StringToBeInserted = "<td valign='top' align='left'><p class='tt_large' data-toggle='tooltip' data-placement='right' style='word-break: break-all;width: 250px;' title=""" & strOldValue & """>" & strLessCommentOldValue & "..</p></td>"
                    Else
                        Args.StringToBeInserted = "<td valign='top' align='left'><p class='tt_large' data-toggle='tooltip' data-placement='right' style='word-break: break-all;width: 250px;' title='" & strOldValue & "'>" & strLessCommentOldValue & "..</p></td>"
                    End If
                Else
                    If strOldValue.Contains("'") Then
                        Args.StringToBeInserted = "<td valign='top' align='left'><p data-toggle='tooltip' data-placement='right' style='word-break: break-all;width: 250px;' title=""" & strOldValue & """>" & strOldValue & "</p></td>"
                    Else
                        Args.StringToBeInserted = "<td valign='top' align='left'><p data-toggle='tooltip' data-placement='right' style='word-break: break-all;width: 250px;' title='" & strOldValue & "'>" & strOldValue & "</p></td>"
                    End If
                End If

            End If
            If Args.DataField.ToUpper = "NEWVALUE" Then
                Cancel = True
                If strNewValue.Length > 200 Then
                    If strNewValue.Contains("'") Then
                        Args.StringToBeInserted = "<td valign='top' align='left'><p class='tt_large' data-toggle='tooltip' data-placement='left' style='word-break: break-all;width: 250px;' title=""" & strNewValue & """>" & strLessCommentNewValue & "..</p></td>"
                    Else
                        Args.StringToBeInserted = "<td valign='top' align='left'><p class='tt_large' data-toggle='tooltip' data-placement='left' style='word-break: break-all;width: 250px;' title='" & strNewValue & "'>" & strLessCommentNewValue & "..</p></td>"
                    End If
                Else
                    If strNewValue.Contains("'") Then
                        Args.StringToBeInserted = "<td valign='top' align='left'><p data-toggle='tooltip' data-placement='left' style='word-break: break-all;width: 250px;' title=""" & strNewValue & """>" & strNewValue & "</p></td>"
                    Else
                        Args.StringToBeInserted = "<td valign='top' align='left'><p data-toggle='tooltip' data-placement='left' style='word-break: break-all;width: 250px;' title='" & strNewValue & "'>" & strNewValue & "</p></td>"
                    End If
                End If
            End If
        End If


    End Sub
End Class
