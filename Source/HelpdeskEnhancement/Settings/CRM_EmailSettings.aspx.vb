Public Class CRM_EmailSettings
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
    Protected m_BlSendMail As Boolean
    Protected m_BlShowPopup As Boolean
    Protected WithEvents m_objGrid As New WebPages.Template.GenericGrid

    Public txtSQLQuery As New System.Text.StringBuilder
    Public strSQLQuery As String
    Public arrColumnHeadingList As New ArrayList       'To store the column Headings
    Public arrActualColumnNames As New ArrayList
    Public arrWidthArray() As String = {"align=left", "align=center width=10%"}
    Public arrCheckBoxIDs() As String = {"", "chkSelect"}
    Public arrSelectedCheckBoxIDs() As String = {"", ""}
    Public arrIgnoreHTMLEncode() As String = {"0"}
    Public EmailSettingsTagID As Integer = 456

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.Applysecurity(True)
        GetGlobalObject(EmailSettingsTagID)

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
        Dim objSetting As New CRM_EmailSettings

        If (m_objAccessRights.View) Then
            Dim str As String = objSetting.DrawPage()
            strHTML.Append(str)
        End If

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
        strHTML.Append("<div class='type-top-bar top-bar' id='divfilter'>")
        'strHTML.Append("<ul class='left'>")
        'strHTML.Append("<li class='search-bar'>")
        'strHTML.Append("<button class='search-bt'><i class='fa fa-search' aria-hidden='true'></i></button>")
        'strHTML.Append("<input type='text' id='txttblsrch' placeholder='Search in table' title='Type in a name'/>")
        'strHTML.Append("</li>")

        '/*Changed By Yasmin on 25th july 2018*/

        strHTML.Append("<ul class='left'>")
        strHTML.Append("<li class='search-bar'>")
        strHTML.Append("<div class='left search-bar'>")
        strHTML.Append("<i id='idSearchHistory' class='fa fa-search' aria-hidden='true'></i>")
        strHTML.Append("<input type='text' id='txttblsrch' placeholder='Search in table' >")
        strHTML.Append("</div>")
        strHTML.Append("</li>")
        strHTML.Append("</ul>")

        'strHTML.Append("<ul class='right'>")

        'If m_objAccessRights.Delete = True Then
        '    strHTML.Append("<li class='clearall'><button onclick='DeleteMailSettings()' type='button' class='btn'  title='Delete' style='font-size:12px;BACKGROUND-COLOR: WHITE;font-weight:bold;'>Delete<i class='fa fa-trash-o' aria-hidden='true' style='font-size:12px;'></i></button></li>")
        'End If

        'strHTML.Append("<li class='clearall'><button type='button' onclick='ClearMultipleSelecttion()' class='btn' style='font-size:12px;margin-left:2px;BACKGROUND-COLOR: WHITE;font-weight:bold;'>Clear All</button></li>")

        'strHTML.Append("</ul>")
        strHTML.Append("</div>")

        strHTML.Append("<div id='divgrid'>")
        '<!----------------------------  Grid Plotting  ----------------------------->

        str = PlotRefreshGrid()
        strHTML.Append(str)

        '****************************************************************************************************************************************
        strHTML.Append("</div>")

        'strHTML.Append("<div class='top-pagination'>")
        'strHTML.Append("<ul class='pagination' style='margin-bottom: 14px;'>")
        'strHTML.Append("<li><a href='#'>«</a></li>")
        'strHTML.Append("<li><a href='#'>‹</a></li>")
        'strHTML.Append("<li><a href='#' style='background: #c0c0c0;color:#000;font-weight:600;'>1-20 of 80</a></li>")
        'strHTML.Append("<li><a href='#'>›</a></li>")
        'strHTML.Append("<li><a href='#'>»</a></li>")
        'strHTML.Append("</ul>")
        'strHTML.Append("</div>")

        strHTML.Append("<div class='bottom-bar'>")
        strHTML.Append("<div class='pannel-section'>")
        strHTML.Append("<div class='col-md-12 col-sm-12'>")

        strHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
        strHTML.Append("<div class='panel'>")
        strHTML.Append("<div class='panel-heading' role='tab' id='headingOne'>")
        strHTML.Append("<h3 style='color:white;width:96%;'><span style='border-right: 1px solid;padding-right: 10px;' class='RemoveBold'>Email</span><span style='padding-left:10px;' class='RemoveBold'> Message Id : <label id='mesageidlbl'></label> </span><span style='float:right;' onclick='ShowHistory_OnClick()' id ='historybutton' style='font-weight:100;'>Show History</span></h3>")

        strHTML.Append("<h4 class='panel-title'>")
        strHTML.Append("<a role='button' data-parent='#accordion' aria-expanded='true' onclick='HideFooterPanel()'>")
        strHTML.Append("<i class='fa fa-plus' title='Expand' id='plus' style='color:white;MARGIN-RIGHT: 1EM;'></i>")
        strHTML.Append("<i class='fa fa-minus' title='Hide' id='minus' style='color:white;MARGIN-RIGHT: 1EM;'></i>")
        strHTML.Append("</a>")
        strHTML.Append("</h4>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='collapseOne7' class='panel-collapse' role='tabpanel' aria-labelledby='headingOne'>")
        strHTML.Append("<div class='panel-body' id='footerpanelbody'>")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")

        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-3'>Purpose</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("purpose", "purpose", "form-control", 208, , , , , , , , , "placeholder='Enter purpose' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-3'>Subject</label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("subject", "subject", , "form-control", , "frmEmailMeassages", "../../../images/zoomin.gif", , 208, 56, , , , "  class='form-control' placeholder='Enter subject' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-3'>Body</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("body", "body", , "form-control", , "frmEmailMeassages", "../../../images/zoomin.gif", , 208, 56, , , , "  class='form-control' placeholder='Enter body' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-3'>Send Email</label>")
        strHTML.Append("<div class='col-sm-3' style='MARGIN-TOP: 1% !IMPORTANT;'>")
        strHTML.Append("<input type='checkbox' style='width:11px;' id='sendmailchkbox'>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-3'>Show Popup Page</label>")
        strHTML.Append("<div class='col-sm-3' style='MARGIN-TOP: 1% !IMPORTANT;'>")
        strHTML.Append("<input type='checkbox' style='width:11px;' id='popupchkbox'>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-3'>Comments</label>")
        strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("comment", "comment", , "form-control", , , , , 208, , , , , "  class='form-control' placeholder='Enter comment' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("comment", "comment", , "form-control", , "frmEmailMeassages", "../../../images/zoomin.gif", , 208, 56, , , , , , , , , "class='form-control' placeholder='Enter comment' ", returnHTML:=True, EnableHTMLEncode:=True))
        'strHTML.Append("<label class='control-label col-sm-3'></label>")
        'strHTML.Append("<div class='col-sm-3'>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        '/*Added By Yasmin on 27th july 2018*/

        strHTML.Append("<div class='saveButton'> ")
        strHTML.Append("<div class='col-sm-12'>")
        strHTML.Append("<div class='right'>")
        If m_objAccessRights.Edit = True Then
            strHTML.Append(" <button type='button' class='btn btn-default save' style='background-color:#343660;color:#fff;' onclick='UpdateEmailSettings()' style=' margin-right: 3px;'>Save</button>")
        End If
        strHTML.Append(" <button type='button' class='btn btn-default save' style='background-color:#343660;color:#fff;' onclick='Cancel()' >Cancel</button>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</form>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        '<!-- end of panel -->

        strHTML.Append("</div>")
        '<!-- end of #accordion -->

        strHTML.Append("</div>")
        '<!-- end of wrap -->

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

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
        txtSQLQuery.Append("EXEC usp_NG2_sel_tbl_PM_EmailMessages_EMailDetails")
        strSQLQuery = txtSQLQuery.ToString

        arrColumnHeadingList.Add("Message Id")
        arrColumnHeadingList.Add("Subject")
        arrColumnHeadingList.Add("Send Mail")
        arrColumnHeadingList.Add("Show Popup Page")
        arrColumnHeadingList.Add("Edit")
        'arrColumnHeadingList.Add("Delete")

        arrActualColumnNames.Add("MsgID")
        arrActualColumnNames.Add("Subject")
        arrActualColumnNames.Add("SendMail")
        arrActualColumnNames.Add("ShowPopup")
        arrActualColumnNames.Add("")
        'arrActualColumnNames.Add("")
        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            .CheckboxCheckOnColumnArray = arrSelectedCheckBoxIDs
            .NoOfDataColumns = 4
            .PrimaryKey = "MsgID"
            .TDStyleArray = arrWidthArray
            '.ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 222
            .DIVStyle = "overflow:unset !important"
            .SQL = strSQLQuery
            '.ColNameToolTipOnEachRow = False
            .UseSQL = True
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode

            strHTML.Append(.DrawGrid())
        End With

        Return strHTML.ToString()

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetEmailSettingsDetails(ByVal Messageid As Integer)
        '================================================================================
        ' Procedure Name        : GetEmailSettingsDetails()	
        ' Purpose               : Get Email setting details for selected entry
        ' Description           : Get Email setting details for selected entry
        ' Parameters Passed     : Messageid
        ' Returns               : Datatable (String format)
        ' Parameters Affected   : None.
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Varsha Jorwekar
        ' Created               : 27-Nov-2017
        ' Revisions             :
        '===============================================================================
        Try
            Dim strSQL As String
            Dim strResult As String
            Dim dt As DataTable
            strSQL = "usp_NG2_sel_tbl_PM_EmailMessages_EMailDetails '" & Messageid & "'"
            dt = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dt)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function UpdateEmailSettingsDetails(ByVal Messageid As Integer, ByVal mailSubject As String, ByVal mailpurpose As String, ByVal emailbody As String, ByVal mailcomment As String, ByVal sendmailbit As Boolean, ByVal mailpopupbit As Boolean)
        '================================================================================
        ' Procedure Name        : UpdateEmailSettingsDetails
        ' Purpose               : save/update Email setting details for selected entry
        ' Description           : save/update Email setting details for selected entry
        ' Parameters Passed     : Messageid, subject, body, purpose 
        ' Returns               : Nothing.
        ' Parameters Affected   : None.
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Varsha Jorwekar
        ' Created               : 27-Nov-2017
        ' Revisions             :
        '===============================================================================
        Try
            Dim strSQL As String
            Dim strResult As Integer = 0

            strSQL = "usp_ins_NG2_tbl_PM_EmailMessages_EMailDetails '" & Messageid & "',"
            strSQL = strSQL & "'" & sendmailbit & "',"
            strSQL = strSQL & "'" & mailpopupbit & "',"
            'Added by Dipali V On 20th Dec 2017 For Issue Fixing
            strSQL = strSQL & "'" & mailpurpose.Replace("'", " ") & "',"
            strSQL = strSQL & "'" & emailbody.Replace("'", " ") & "',"
            strSQL = strSQL & "'" & mailcomment.Replace("'", " ") & "',"
            strSQL = strSQL & "'" & mailSubject.Replace("'", " ") & "',"
            'End of Added by Dipali V On 20th Dec 2017 For Issue Fixing
            strSQL = strSQL & "'" & HttpContext.Current.Session("strUserName") & "'"

            strResult = CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

    '<System.Web.Services.WebMethod()>
    'Public Shared Function DeleteEmailSettingsDetails(ByVal Messageid As Integer) As Integer
    '    '================================================================================
    '    ' Procedure Name        : DeleteEmailSettingsDetails()	
    '    ' Purpose               : Delete Email setting details for selected entry
    '    ' Description           : Delete Email setting details for selected entry
    '    ' Parameters Passed     : Messageid
    '    ' Returns               : Datatable (String format)
    '    ' Parameters Affected   : None.
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Varsha Jorwekar
    '    ' Created               : 28-Nov-2017
    '    ' Revisions             :
    '    '===============================================================================
    '    Dim strSQL As String
    '    Dim strResult As Integer = 0

    '    strSQL = "usp_NG2_Del_tbl_PM_EmailMessages_EMailDetails '" & Messageid & "'"
    '    strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)

    '    Return strResult

    'End Function

    '<System.Web.Services.WebMethod()>
    'Public Shared Function DeleteMultipleEmailSettingsDetails(ByVal Messageid As String) As Integer

    '    '================================================================================
    '    ' Procedure Name        : DeleteMultipleEmailSettingsDetails()	
    '    ' Purpose               : Delete Email setting details for selected entry
    '    ' Description           : Delete Email setting details for selected entry
    '    ' Parameters Passed     : Messageid
    '    ' Returns               : Datatable (String format)
    '    ' Parameters Affected   : None.
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Varsha Jorwekar
    '    ' Created               : 28-Nov-2017
    '    ' Revisions             :
    '    '===============================================================================
    '    Dim strSQL As String
    '    Dim strResult As Integer = 0
    '    Dim Msgid As Integer
    '    Dim str As String = Messageid
    '    Dim strArr() As String
    '    Dim count As Integer

    '    strArr = str.Split(",")
    '    For count = 0 To strArr.Length - 1
    '        Msgid = Convert.ToInt32(strArr(count))
    '        strSQL = "usp_NG2_Del_tbl_PM_EmailMessages_EMailDetails '" & Msgid & "'"
    '        strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
    '    Next

    '    Return strResult

    'End Function


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


    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        'If Args.ColumnName.ToUpper = "DELETE" Then
        '    Cancel = True
        '    'Args.StringToBeInserted = "<td align='center' Title = 'Delete'><input type='checkbox' id='DeleteSetting' name='chkmailsettingDelete' value=" & Args.DataReader("MsgID") & " >" + "</TD>"
        '    If m_objAccessRights.Delete = False Then
        '        Args.StringToBeInserted = "<td Title = 'Delete'><input style='text-align:center;' type='checkbox' id='DeleteSetting' name='chkmailsettingDelete' disabled value=" & Args.DataReader("MsgID") & "></TD>"
        '    Else
        '        Args.StringToBeInserted = "<td Title = 'Delete'><input style='text-align:center;' type='checkbox' id='DeleteSetting' name='chkmailsettingDelete' value=" & Args.DataReader("MsgID") & " >" + "</TD>"
        '    End If
        'End If

        If Args.ColumnName.ToUpper = "SEND MAIL" Then
            Cancel = True
            m_BlSendMail = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_sel_tbl_PM_EmailMessages_EMailDetails_SendMail " & Args.DataReader("MsgID"), True), "0")
            If m_BlSendMail = True Then
                Args.StringToBeInserted = "<td ><p style='color:green;text-align:center;'>Yes</p>" + "</TD>"
            Else
                Args.StringToBeInserted = "<td ><p style='color:red;text-align:center;'>No</p>" + "</TD>"
            End If
        End If

        If Args.ColumnName.ToUpper = "SHOW POPUP PAGE" Then
            Cancel = True
            m_BlShowPopup = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_sel_tbl_PM_EmailMessages_EMailDetails_ShowPopup " & Args.DataReader("MsgID"), True), "0")
            If m_BlShowPopup = True Then
                Args.StringToBeInserted = "<td  ><p style='color:green;text-align:center;'>Yes</p>" + "</TD>"
            Else
                Args.StringToBeInserted = "<td ><p style='color:red;text-align:center;'>No</p>" + "</TD>"
            End If
        End If

        If Args.ColumnName.ToUpper = "EDIT" Then
            Cancel = True
            Args.StringToBeInserted = "<td Title = 'Edit Email'> <a><i style='text-align:center;color: #4caac0;font-size: 14px;' class='fas fa-edit' aria-hidden='true' onclick='ShowEntry(" & Args.DataReader("MsgID") & ")'></i></a></TD>"
        End If

    End Sub

    Private Sub m_objSeverityGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint

        'If Args.ColumnName.ToUpper = "DELETE" Then
        '    Cancel = True
        '    Args.StringToBeInserted = "<th><input type='checkbox' id='chkAllDeleteSeverity' name='chkAllDeleteSeverity' onclick='DeleteMultiple()' title='Check this for Multiple Deletion.'/></th>"
        'End If


        If Args.ColumnName.ToUpper = "MESSAGE ID" Then
            Cancel = True
            Args.ApplyHTMLEncode = False
            Args.ApplySorting = False
            Args.TDStyle = " "

            Args.StringToBeInserted = "<th align='center'> Message Id <i class='fa fa-sort' aria-hidden='true'></i></th>"
        End If

        If Args.ColumnName.ToUpper = "SEND MAIL" Then
            Cancel = True
            Args.ApplyHTMLEncode = False
            Args.ApplySorting = False
            Args.TDStyle = " "

            Args.StringToBeInserted = "<th align='center'> Send Mail <i class='fa fa-sort' aria-hidden='true'></i></th>"
        End If

        If Args.ColumnName.ToUpper = "SHOW POPUP PAGE" Then
            Cancel = True
            Args.ApplyHTMLEncode = False
            Args.ApplySorting = False
            Args.TDStyle = " "

            Args.StringToBeInserted = "<th align='center'> Show Popup Page <i class='fa fa-sort' aria-hidden='true'></i></th>"
        End If
        If Args.ColumnName.ToUpper = "SUBJECT" Then
            Cancel = True
            Args.ApplyHTMLEncode = False
            Args.ApplySorting = False
            Args.TDStyle = " "

            Args.StringToBeInserted = "<th align='center'> Subject <i class='fa fa-sort' aria-hidden='true'></i></th>"
        End If

    End Sub
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
            Dim objSetting As New CRM_EmailSettings
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
        Dim strHTML As New StringBuilder("")

        If (storedprocedure = Nothing) Then
            txtSQLQuery.Append("EXEC usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory '" & 456 & "','" & UniqueID & "'")
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
            '.ColNameToolTipOnEachRow = False
            .DIVID = "ShowHistoryGrid"
            '.DIVStyle = "overflow: unset !Important"
            .SQL = strSQLQuery
            '.ColNameToolTipOnEachRow = True
            .UseSQL = True
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode

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
            Dim objSetting As New CRM_EmailSettings

            If (newModifiedField = "") Then
                newModifiedField = Convert.ToString("Null")
                strSQL = "usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory 456, '" & MessageID & "'," & newModifiedField & ",'" & newModifiedBy & "'"

            End If
            If (newModifiedBy = "") Then
                newModifiedBy = Convert.ToString("Null")
                strSQL = "usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory 456, '" & MessageID & "','" & newModifiedField & "'," & newModifiedBy & ""
            End If

            If (newModifiedBy = "" And newModifiedField = "" Or newModifiedBy = "Null" And newModifiedField = "Null") Then
                newModifiedBy = Convert.ToString("Null")
                newModifiedField = Convert.ToString("Null")
                strSQL = "usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory 456, '" & MessageID & "'," & newModifiedField & "," & newModifiedBy & ""
            End If

            If (newModifiedBy <> "" And newModifiedField <> "" And newModifiedBy <> "Null" And newModifiedField <> "Null") Then
                strSQL = "usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory 456, '" & MessageID & "','" & newModifiedField & "','" & newModifiedBy & "'"
            End If

            Dim str As String = objSetting.ShowMailHistoryGrid(MessageID, strSQL)

            Return str
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function

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